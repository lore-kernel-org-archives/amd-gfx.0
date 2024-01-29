Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A121C48286
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 17:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47C6110F3D3;
	Mon, 29 Jan 2024 17:47:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA34810F3D3
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 17:47:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/QIxkqWqyZtr98c9p6dazSTHg9hGZnB8WkJt5g1BHaQLQZvE8Qd1DM9oURYY3/F+swE7Qx/FyZUtfZJyiPNGz9vHPRcKX5CdHY/gMFsRlZMfAdl0Tk9uiZ8BBEXJ9SBjrheCw1ibL3yFjootnbBpR0XNsb4qNT5eAEI2R5UgKSYpkv6+n9RUliOJSCg/E4Bd4NSUMyLuvPHQw067+Z33OZqKGD6SVMvjXDVEFiovPdZ4dkTt3Pwz8IyqZ3q20msOGAhUtmwnQLWjzui1/ycviffJRyXNw8T67nfaOnAoxnl4AW4fxDs1lObBWGYcbARFZ8ZkBdNZErdN+CxqM49QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7tffdt9gGxVUJVYXpESjdULyuIcJDlL6cQYzxpFTtg=;
 b=mLk0zOLluEfaROuKmUFVSgYnyh6wl0gHT4G0HH5n4pG4cXOIDe7GeSHbXzN7SD52lq1AdoDJRdGjdlrwRQccy7TsJUhTaJ6b87PqrHajEvNR2zCy55rHJxY28wJ5neQ2+BFCyWTWRWVPcEibL+2mOS+xVRA5636l0LgiOOBVIavLc9cwbUh/4OAEHl74Zn6pLcNTgyf4v050FCR8qsX6qFr1vkjWfoTI17KjrW0cwdz4WJQLUSJGaH0pBEllQGQfFRZYY61BZqoYi/FenLPoWCvlQjh1maAO/ktX2sw4xNpgyYZbhwnaKJ24ct5dsf0N/FOOMvkExuflB1TkpynlNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7tffdt9gGxVUJVYXpESjdULyuIcJDlL6cQYzxpFTtg=;
 b=Uu7EnI48gdD8lRxL2RUU0lmAVxACoNo4DT7kfYj2YbNLEAFg6+O5TgIhKDXrb9Ty+fZf9DKESGcmcJq+hHe0ome/m++jtEQTGsrWyN+uuI8FQvoP4Bxrp01IbiOal1ZSa3eF/cY3FEO5Q21ICafLwRKibds4gnTwkt4ePEDo9V0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS7PR12MB6007.namprd12.prod.outlook.com (2603:10b6:8:7e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 17:47:29 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::267c:6dd1:b603:a75c]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::267c:6dd1:b603:a75c%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 17:47:29 +0000
Message-ID: <72d6fa08-2aa4-546c-7329-9cb42e891511@amd.com>
Date: Mon, 29 Jan 2024 12:47:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Support >=4GB GTT memory mapping
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240126194721.18853-1-Philip.Yang@amd.com>
 <e128767a-9980-4892-a8bc-9acc206dd84e@amd.com>
 <43f6a455-4256-bfbb-f4ca-84e46440e5eb@amd.com>
 <adb1a9d0-11ff-44c7-9d5d-c20d1bb7f01b@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <adb1a9d0-11ff-44c7-9d5d-c20d1bb7f01b@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0235.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::23) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS7PR12MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f75b51-0b3b-46b4-2149-08dc20f25cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ec9uOyPktArfOO0ncXEM7EW6W1/Lp4NXZuo1HztEqfO1A1wusZhhPuKZpqlzzTKHpBLgu0twXRlnZS2vGajGPjYU5OBYiF7YMKO7bQS2R5NE6EnrwXzqF6n7QTPXX7JUr0P+i3bI48RbsR3n4h5KRlD5YVdl/1N1h3i/mVvfZ16Sj60NoGN5J/aumo6aE9J+opfRRMfsED1+C/vacPA46Q+72CsmlwgXS1hcyPVkTF/xAHCAEhMwwiuHDHqOoZBnjAX46zREDgJdyd2R9phVpC4WSY9Xs1BLeriLG04COaB33KLv1vVLRi3cUkgrCse643Xnh/7KqaLqOlWs2mDzvzxhozFpLHN6y2cDFHN8iWqWvHSQ65tpeYVDqBpNMetBWe0k/Tws0QjaNHmb1z7F5Fc5Jc8lfCe2MGofyi0l/0A02NiztocyOU7+nmfMFx84+PtGhQQruz7XGETgbznoLJUC1PqjntybYijHqn3/jgtATOqvRz5f56UvUhgHEhKovTewKCXubw/Kxg/4hYDcQ95j8jjAz72WnfSpAWn63ZAXxgwlBbCYz/opICFEhmrdWGiQGFTxQPVpCXUtvbS4lUsH3T4j1xdH9nz3AH3hNXFTvxAmiIXzsYN8FYLMO412DKMxtfEtchNR1/d7RmpTVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(366004)(39860400002)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(66574015)(83380400001)(53546011)(26005)(6512007)(6506007)(2616005)(38100700002)(5660300002)(4326008)(8676002)(8936002)(41300700001)(66476007)(478600001)(6486002)(2906002)(66946007)(110136005)(66556008)(316002)(31696002)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzE5Qm85Q2dLK2N2a3c2czV1V3phUCtuczhCSlc5V3hFb2lLZjBmQlhzZEZv?=
 =?utf-8?B?dUVYM1czWnArTmMxWU02ejFndzBjd2N6U2Q4L240R2RIbU5QS3NaTlNNazc1?=
 =?utf-8?B?KzlRbDNqbmdha2x6UEdXU3pUZFZuNUpOMEZIM3BxSFUvcllOYkhLeDQyZXFG?=
 =?utf-8?B?Zmw2MDJDZjZUUGxYRlZGYmtSNGVBWnZKTTkzQUNNU1ViMVpxclBpWi9Db1Ey?=
 =?utf-8?B?TDROS1ZjeCtreEJ0cHhyNHhYRjBkay95RkRKM1dMeUpNVkhyOFBzUTcwNStp?=
 =?utf-8?B?Q3ZJNVdtSGtWbzFFa3A3T3Q3dDlwQlB2RnlURmttZm1QQVZkaTFqWU9XM1Bx?=
 =?utf-8?B?a3hMSy9vUjBHbDg1RjhBZHlDTUlXdkRxelJKT3Y1Rmd4NnV0ai90enZiL25T?=
 =?utf-8?B?WG1NZ3NlRnNnaDdQdDN0N21Td3RpQ3pZaXlVb1I5ZjcvLy9WeGloWU5tejVh?=
 =?utf-8?B?RDFObDZjbmZkL0I1OHY0L0lXK3FjNE01R1ZoODRJWTJoV2pqcm16cFVBWnBx?=
 =?utf-8?B?bnczMHZodUVPeXJmY21xRHNHZ1E5eDhVN2ZOSDAzcnVOTWlHT3hXckQraGhU?=
 =?utf-8?B?R3hCUHVqZnovSDA3blM2cmJKUHhQK2FRa1FURndhaGRlL0N2TUEzcGQwcVpF?=
 =?utf-8?B?UzRJNTZ4TE9RQjZ4enMvSDJVQjBmby9IWWxvcXc1Ym5wbm5hVFE2d2pTRElv?=
 =?utf-8?B?dXJjb1I4akt4VGtnZWFxQ0ZVSmR2UktXLzIwUXFSMFUrZjFvVkk2S1JSRGZE?=
 =?utf-8?B?QzVGb3NRV293Vk9sODA0TWZEcktTOTI0ZmhxNlNNSk9HQm9OdjdWZ3JrbVc4?=
 =?utf-8?B?Q2FnQlVET2FxWjhqa1Z5Q3FOVG1mSTJwSHVUUW9wQndSQklFRXZQYVc1NHF5?=
 =?utf-8?B?OEw1d3g4ZytRcWlyN3hVaGhHSmpTRmlMLzcyM3NJYlhKSno2ekwzN3Z2ZUhK?=
 =?utf-8?B?TlZzakQrQ0t0YVQyKzA5cG1MREIzSmxzSXB3bXRjT0FpeDh6b2cyUTJLY1hP?=
 =?utf-8?B?TU45TXRyRHR0dmhxalFScDIyQmsvRWFZL1VuOG9iUTU0N1h5czBZL2NCZUVU?=
 =?utf-8?B?TDdoSVI1elYwTE5xdTlVTVQ4N05hcFdac0VoVkdxSGlhdzlKRTArV04wckVF?=
 =?utf-8?B?MDk0aXJxcGZqclNOZkE3b25jVmdlN1dOREZ2WDlVMmI0M3VGL1R6ei9LTmMz?=
 =?utf-8?B?THJVNENkcWdpMTJ5NmRhSEU4alBZTFZrSXp1bTZrckpJS3E0czlsTFF4dVZk?=
 =?utf-8?B?Q1J2cWt0Q09OWUdkN1pUMU1pWHBEQzFiUWJBcmhwekRFdDhVVlVXUC9wdVI5?=
 =?utf-8?B?UE00M040ZDE3N3FTMlFwZFVOdU9lZWpPT0FEZkJEa3hsVkZmWFBRaW40d1Y2?=
 =?utf-8?B?SHJNbTdINFlWT1pPSkVKSjFwRmRDcVg1d2U1NW14VXYyYzk5U3BjNjZmYkZq?=
 =?utf-8?B?V1ZINU9KMG8yWXJIWGRKbDFFZjc5d1B1QlU3aFd2YlBaMkx1dnp1VHhySG92?=
 =?utf-8?B?UENWMk1NbURCRGk4R3B2M3V5cnhzYWdLNkJUMVc5OXd1c3U0ck1SVVE1Zmhu?=
 =?utf-8?B?eWovdVp2QVM0bUYwVGs5azF0TFVFZUR6WmtDbE1UUG1qOXJraThHeU5nYXIv?=
 =?utf-8?B?aHJ3QzdyQ201Nm15dDRkc01UYTNiZW8rTVhIOTB5WXN6ZDhpdGsyOHMyY01w?=
 =?utf-8?B?QjEvOFBxWUYrU3pLV0ZNMGtPWUxySE9XNFJNNHM4TjlHS3ZzVGUxc1ZPaUZl?=
 =?utf-8?B?dzVqZ2YyTjA0SmlaZm5MMW9tRVJUZ0NCdkg3OGhGNDJvMzl5bUNRcGpDc0hM?=
 =?utf-8?B?eDQ2YWJWWDVEQi83amJXeGh6Tlc0cVFGa2grTDEwZy9KTi9YNFBpenVUN3Rv?=
 =?utf-8?B?MUdicWZWYjU0dDh1RTZYS3R3cEt2cW9ZMEVMdzdVbWFKSnU0WmJlSmlJcThX?=
 =?utf-8?B?eDJGakx6Q0d1L0hZVERkR0Fvb1d3Mit0UkZUbVoyeEtZczVZQndWWDFFUWNo?=
 =?utf-8?B?Zk1WM2hHWHA1ZkRGZzQ3VFZLclVhYWdhaTRIR3NTR3NyNHFSU0Mza043T3hm?=
 =?utf-8?B?Wkw0UTBkajZpd1hFaC9qaXRQWEhGMXNQdU0yQVhKbWI1TUpSUkJ0SktlWnl4?=
 =?utf-8?Q?KQ10=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f75b51-0b3b-46b4-2149-08dc20f25cc8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 17:47:29.1799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVRSwsT4vlg829sjTw6KF2BDEp01e0pbGCJlyy0bMP/UApFNWOTfNya1y4Zb5Lbs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6007
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-01-29 11:30, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:adb1a9d0-11ff-44c7-9d5d-c20d1bb7f01b@amd.com">Am
      29.01.24 um 17:25 schrieb Philip Yang:
      <br>
      <blockquote type="cite">On 2024-01-29 05:06, Christian König
        wrote:
        <br>
        <blockquote type="cite">Am 26.01.24 um 20:47 schrieb Philip
          Yang:
          <br>
          <blockquote type="cite">This is to work around a bug in
            function drm_prime_pages_to_sg if length
            <br>
            of nr_pages &gt;= 4GB, by doing the same check for
            max_segment and then
            <br>
            calling sg_alloc_table_from_pages_segment directly instead.
            <br>
            <br>
            This issue shows up on APU because VRAM is allocated as GTT
            memory. It
            <br>
            also fixes &gt;=4GB GTT memory mapping for mGPUs with IOMMU
            isolation mode.
            <br>
          </blockquote>
          <br>
          Well that was talked about before and rejected. If we really
          want more than 4GiB in DMA-bufs we need to fix
          drm_prime_pages_to_sg() instead.
          <br>
        </blockquote>
        <br>
        I sent a patch to fix drm_prime_pages_to_sg but the patch was
        rejected.
        <br>
        <br>
      </blockquote>
      <br>
      Why was that rejected? If this isn't something we want for DRM we
      probably don't want it for AMDGPU either.
      <br>
    </blockquote>
    <p>The reason is same as your concern, to check if we want more than
      4GB dmabuf support and may need fix for other drm functions.</p>
    <p>I am not familiar with drm layer, amdgpu need more than 4GB
      dmabuf on mGPUs APU. Do you want me to resend that drm patch to
      fix only drm_prime_pages_to_sg function?</p>
    <p>anything like this will cause size becomes 0 if nr_pages size is
      more than 4GB:<br>
    </p>
    <p>unsigned int nr_pages;</p>
    <p>unsigned long size = nr_pages &lt;&lt; PAGE_SHIFT;<br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:adb1a9d0-11ff-44c7-9d5d-c20d1bb7f01b@amd.com">
      <br>
      <blockquote type="cite">This issue happens on APU, as VRAM is
        allocated as GTT memory, get to this patch only if IOMMU is
        isolation mode, with IOMMU off or pt mode, multiple GPUs share
        the same dma mapping.
        <br>
        <br>
        Even with the fix patch accepted by drm, we still need this
        patch to workaround the issue on old kernel version.
        <br>
        <br>
      </blockquote>
      <br>
      Yeah, but that's then just a functions fixup for our backporting
      team and shouldn't be worked around like this.
      <br>
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">Regards,
        <br>
        <br>
        Philip
        <br>
        <br>
        <blockquote type="cite">
          <br>
          Regards,
          <br>
          Christian.
          <br>
          <br>
          <blockquote type="cite">
            <br>
            Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
            <br>
            ---
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 50
            ++++++++++++++-------
            <br>
            &nbsp; 1 file changed, 34 insertions(+), 16 deletions(-)
            <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
            <br>
            index 055ba2ea4c12..a203633fd629 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
            <br>
            @@ -171,18 +171,41 @@ static struct sg_table
            *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (bo-&gt;tbo.resource-&gt;mem_type) {
            <br>
            -&nbsp;&nbsp;&nbsp; case TTM_PL_TT:
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sgt = drm_prime_pages_to_sg(obj-&gt;dev,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;tbo.ttm-&gt;pages,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;tbo.ttm-&gt;num_pages);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(sgt))
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sgt;
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dma_map_sgtable(attach-&gt;dev, sgt, dir,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DMA_ATTR_SKIP_CPU_SYNC))
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_free;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
            <br>
            +&nbsp;&nbsp;&nbsp; case TTM_PL_TT: {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t max_segment = 0;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 num_pages;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sgt = kmalloc(sizeof(*sgt), GFP_KERNEL);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!sgt)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ERR_PTR(-ENOMEM);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (obj-&gt;dev)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_segment =
            dma_max_mapping_size(obj-&gt;dev-&gt;dev);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (max_segment == 0)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_segment = UINT_MAX;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Use u64, otherwise if length of num_pages &gt;=
            4GB then size
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * (num_pages &lt;&lt; PAGE_SHIFT) becomes 0
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_pages = bo-&gt;tbo.ttm-&gt;num_pages;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err = sg_alloc_table_from_pages_segment(sgt,
            bo-&gt;tbo.ttm-&gt;pages,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_pages, 0,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_pages &lt;&lt; PAGE_SHIFT,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_segment, GFP_KERNEL);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(sgt);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ERR_PTR(err);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dma_map_sgtable(attach-&gt;dev, sgt, dir,
            DMA_ATTR_SKIP_CPU_SYNC)) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sg_free_table(sgt);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(sgt);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ERR_PTR(-EBUSY);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case TTM_PL_VRAM:
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vram_mgr_alloc_sgt(adev,
            bo-&gt;tbo.resource, 0,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;tbo.base.size,
            attach-&gt;dev,
            <br>
            @@ -195,11 +218,6 @@ static struct sg_table
            *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sgt;
            <br>
            -
            <br>
            -error_free:
            <br>
            -&nbsp;&nbsp;&nbsp; sg_free_table(sgt);
            <br>
            -&nbsp;&nbsp;&nbsp; kfree(sgt);
            <br>
            -&nbsp;&nbsp;&nbsp; return ERR_PTR(-EBUSY);
            <br>
            &nbsp; }
            <br>
            &nbsp; &nbsp; /**
            <br>
          </blockquote>
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
