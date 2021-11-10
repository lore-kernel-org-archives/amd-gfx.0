Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37122C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 14:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBA63610FC
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 14:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EBA63610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79F646E165;
	Wed, 10 Nov 2021 14:00:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3446B6E165
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 14:00:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5Nwgdca0EQ3oStFyLqcW2C6WCPX2S/mYcvOkm2z1vr29z35pMaFGoW6NCE6rnvklQ4XpeXg5RazNxICkyocBxxJrR/LyidDZ2Xz+nYT3w8Ca+kc1joGA2A7v1ulJZ1DcmrkpDL1u4/saNKwKLv4TvbSPFLc+ZWqnmMrCzqYO40hyLy/NlIxE8hNAGVENSzuwkeXg7A6QPll9EG2hrCCZ8Q+6dyjsX8bT3Tsg9CVHN3a0B14kMpzpoynqk7e+FHoW3RoF9MFqxJExpM5uGprDmdpxp6qcVkvHxoznETBHF9cRtmXbgjZaZ3srD9GS3N+Oem1jvm3gaBVWrHrVtbgJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghQoN17/XMh4twZy+8sSMm6/ZxSzLEzI6/CSbQmQ5Fo=;
 b=DZSTnwyJFHiX66Ajz69tIrLKHHvhBpNI1JxtpJoPRfCPQlN+x3cA58HvMAo78xATH4UWpBaouENJVQL3lDdJb++3RbxgIzWdf9QQD92sbEVlvFysFQ4XsYHvx9Vhf7VPbs/PsqVydl4sgYwG0GSrzoo7VfmLQ/7se9Iv8iAv2hG5IJOV/jUhApLR2VHtMS9WCAUIuH+bznump/zFgVjXj0hnIqjqOuY8KafVTN885P/kca588gqes85o5DQKCZw0cgDxPG3uXBj5cElKfNpYE73V55mbYE+tyld9lQaou2Qe1ohsY23s2q1LYoxRn0G/2m5kVC655rUCKL9J1E6uvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghQoN17/XMh4twZy+8sSMm6/ZxSzLEzI6/CSbQmQ5Fo=;
 b=fY9guUWD42ATjJIqe2rFwp9A95zMKs3rUdBulOZCuldaAtLvIYzHQlN6nNmMy9E4DzEveO/WqEMLUfzqg6XwMn1cYPWalITh7e1LMDKztAiKGsv2kUGFHYLB3SPhVTZVdjUbI1X1UjfLmJMscU/0fXIEYAINn1O+F9s+8l28kQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5328.namprd12.prod.outlook.com (2603:10b6:5:39f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Wed, 10 Nov
 2021 14:00:04 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf%4]) with mapi id 15.20.4669.015; Wed, 10 Nov 2021
 14:00:04 +0000
Subject: Re: [PATCH 1/5] drm/amdgpu: handle IH ring1 overflow
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211109230432.3947-1-Philip.Yang@amd.com>
 <1862b795-3401-b89f-089b-4b544957d150@gmail.com>
From: philip yang <yangp@amd.com>
Message-ID: <c5855126-de94-f2b4-c912-f386b6b47142@amd.com>
Date: Wed, 10 Nov 2021 08:59:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <1862b795-3401-b89f-089b-4b544957d150@gmail.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::18) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 LNXP265CA0006.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.16 via Frontend Transport; Wed, 10 Nov 2021 14:00:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 726aba68-c330-49cb-7d78-08d9a4526510
X-MS-TrafficTypeDiagnostic: DM4PR12MB5328:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5328210B5D1A5777B6625265E6939@DM4PR12MB5328.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yR+q1QaD5FrkWgFgbaqWtDAq5YtB/ZNgxillWDovj/foOzV1FVCMhWePfdpmeMVSyWy0VudHWT7434vxRYicP3YTszFuBURpl3XmqPT8iSAxCLtzzjgSVtEbz8k+s9gIsnNEWhqe2f8YuaccVBV6OvvBgMDU17G9EPiQZkns0Goegx6/XNOfCjzaSXOemcLoqJVc0tNNkyCwNWsDzt9UCpYUnjlS62GuAFzGs9RHa2Mcn33MAd7aY8tSd0ygBIcl36HQfscOySxTtr8aTPClLpD3i7YymjlfMiNq8PIIFLaJJabzu/PvwAVuOt8S/1t5gh2LsqzXh+6O+I2UuaJDwt+/uudcJpYHUcQ5FWDsYlVXfaiPUr8wohgtd4t2NDYC3Wu6I0voQrSI2lcsu3Vh+4poNIhSJK8fJ1wLIXleRQjZKGzbM90e7p1K3KFchJqr6kNX+5V0WmRnMMCfGv6bB62E/mAx4oj8cSpUIsSt0nIWb6wf6VWkc54H/6E1Mjj4JqQ7q9pbX9Vs5jLyllPAWCu/j5Ql2iEY5gVarDmD0WMeDaQfQJhu44DjisgLA9R8Fe1q8V78sa19NR/+iSWFKIguGymcWuSteUQbgoledDv6A0NzaAqHDQX88bYjTL5WGWmI2SZ0NhAM+6vehQGa9AdSpM+pRB/g8MKtUC464K+W0SqXdCJ62/gfusJRee1X48Hav23MAA9CYDEBbu76tlFzCtjHfF2LbYvKyVSYUzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(26005)(66946007)(66556008)(66574015)(8676002)(31686004)(38100700002)(66476007)(83380400001)(36756003)(53546011)(5660300002)(8936002)(4001150100001)(6666004)(2906002)(186003)(956004)(31696002)(2616005)(4326008)(110136005)(16576012)(316002)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0RscXZoalpyMVFyMm5jcjJZZE9vVWhvN2tTeXNnOU8zN3Y4MXlUVUxOQmp0?=
 =?utf-8?B?cXpneWVQMEVjVmdxU3F3ejZKWjNiNXNoVk5CYW9Ld0JSVG4zTW1aSFAydDAz?=
 =?utf-8?B?V0JtNWpJdTh6RHZqNlpWRGFGOUpPNXBXRXdzMHM3SjRrbHhHRnQrOEJYbzFI?=
 =?utf-8?B?U3kvNkhDNUV0Z2EzSWVDNEgreXphT3UyM21mdEx1RHR4UUZsTFlyTlh0eVF0?=
 =?utf-8?B?Ykw0TGFwQUw5Vm12T2RTdGd5SG5rS09PQ1c3N3hic0hOeFlyYlZucHA2NU1a?=
 =?utf-8?B?UUt0TE9wMFZZbE52TEF6cFBBQlZvd3U0d0FKS2VQN1B0OWFJTnJKWGRRN2RK?=
 =?utf-8?B?RzA0MTBlMEZXTzFzeG41UXdWVnJwL29PMFp6aWNBVVpETGhIMmRRNXMzVEFa?=
 =?utf-8?B?LzJxUXVsRGxlYUZjalhIYlZOaXpia3l4S3BiaW9ZeS9UK0pROHViM2d2a1Yy?=
 =?utf-8?B?bnRscjJITnFDYzNOZWE5WGVnTVZPWjRrVUxqUHFIbjdRRjEwWW0wWE5MbHJx?=
 =?utf-8?B?TW1CSktCOXVjdUFmZE04TDE4aW5PN0g3WFFKd05ZVnV6UkYwUDZJcW9LTnpw?=
 =?utf-8?B?eUE2Z3hiWlgrNDZydThrenRWQWJkQUs2a2RSU0xOeHdoQVBKZmhUTHpqQ2lN?=
 =?utf-8?B?UnpyOWV3dm1DV2FvQ1MzdTRBb2VFV0lrZ2tPc2h4VjFSR0hUUTk2Y0xweUc0?=
 =?utf-8?B?NW9tSklTTmpGQ29QbDc2RGNqazhPV2d0eVVlUzFVVGlOb0c0YytsYVZlN2Qy?=
 =?utf-8?B?aXZCdCtFTTd2ZUJ5QTJDRzlzQTZwVjF3YjZsdUNiUmd3YU5FMjhDZXloZDFl?=
 =?utf-8?B?aUlsOTYrMlNqN01mQmtFWmhTWVd3bGk0S3MybzNpQ2lBWkNkeVVQSVNHV3VS?=
 =?utf-8?B?UWpmalE1TFAvOE5qK1FwY2huWGJUREF1SVdidUE5N2JVcWpVR3RWa2pLU0RI?=
 =?utf-8?B?RXVFL0FqMnlSR3QyN082MVVsVXA2czFwWVZoZHk3bVROcmRTWW5LVzFlWGRS?=
 =?utf-8?B?Um82clZiV1RBRHZpY0JodFIvZUFzVSt0MDl6VFJOMlY5Vjhqa0xCYy9MNFlX?=
 =?utf-8?B?TXpYY0kzYldKQzU5VEdBVlJ0dVltTEZpZmRHRWVUTWhOQmNHTzJHV2tNTUpm?=
 =?utf-8?B?NmtoWG1qa0FZUzVJSHVMazZDZFlHSUFSNEdnNFZUYVhUNmVlZHdwM0dacjRZ?=
 =?utf-8?B?THFYaXVFckRpQ2UzZ1A1anp4UWZWc2h4cEIrMWlwMmlEL3JEWWNBUUtOWS92?=
 =?utf-8?B?TndLcmlkaFVQb0xYRk16OWpEQWdIWFl2Y3FRVEN4cVd4WmdBNHg0cWhRTytY?=
 =?utf-8?B?bXVaYk5RQmI2WTJ1c3VPcXBiVlY4VGtzMVJORzk1SXp3QnFIRDM2VXJHNHBx?=
 =?utf-8?B?SjhBMFJtd29jR0dwNjBmQWtwWTBJMUxYNUpML1lWUkMxeTdWUXgrM2xEWUZk?=
 =?utf-8?B?Z3V5cVV6ZVZMTXlUQVN6dGpSV2lDQjhDMU84eE5UWEYyZ3BuMVFyRldwN21u?=
 =?utf-8?B?b2c5U05Sa0phdGF1M2g5bGIwaFVvNUJxQnpaMzl1d0c4NjNOMXFIM1NrSFg0?=
 =?utf-8?B?SEhpUWNWck16SktseE1FZlQwSmcwaW1WNHZuZzh5QzdIMzg2cUgzYW9SN1lE?=
 =?utf-8?B?cVY4bkd3SVl6cmJPWU9xV004NUlFNlVNUEdRSCs5TXhsamxScXNpb0xMS2I3?=
 =?utf-8?B?SE1ZMGhYUDFoczlHeDRPa3JVUFpGendoMFJDK1RwbWluOWFWK2w5WUV1RWpS?=
 =?utf-8?B?YlZWcG05d1Y2UFVJaGFKRnkrRUU1Vzd1VWZGcjIzTHVHNWl5NjJmQ2pZdDFQ?=
 =?utf-8?B?WFJTUUd2aG0yRG02ZXJFWjE1ZC9YQk81NDE4WmRzWm5hY3pxZ0hzckplaHFR?=
 =?utf-8?B?cUNLaVlOai9QUmEyK0wzL0RCYUdZNG1sSEE2dHdNUmlOSk5iaWJjNU1RODNl?=
 =?utf-8?B?R3ZIOXVmdnUxTnZuU0R3MUFwZTJzeE02d3JOcE5HR1d1S2tFeGljcm1aN3Nt?=
 =?utf-8?B?VVAvbE1GUmJ0Q0JTeCt3YWJ0TFY1YThiSmtoTkZuNlJLbUpzbitTTC9DSGFN?=
 =?utf-8?B?TVQrY2pJTWFVajJXc0liQ1RzMEN1M2FTYVRrbkpBRkxlOXRFSktxWTgzYnZs?=
 =?utf-8?Q?n3po=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 726aba68-c330-49cb-7d78-08d9a4526510
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 14:00:04.1310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnvRAeE++d9kqykAVumLyQ4QF7v64fdf6rAxK9UfVXm9vlqdsAV3fBjePRU0wrmv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5328
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
    <div class="moz-cite-prefix">On 2021-11-10 5:15 a.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:1862b795-3401-b89f-089b-4b544957d150@gmail.com">Am
      10.11.21 um 00:04 schrieb Philip Yang:
      <br>
      <blockquote type="cite">IH ring1 is used to process GPU retry
        fault, overflow is enabled to
        <br>
        drain retry fault before unmapping the range, wptr may pass
        rptr,
        <br>
        amdgpu_ih_process should check rptr equals to the latest wptr to
        exit,
        <br>
        otherwise it will continue to recover outdatad retry fault after
        drain
        <br>
        retry fault is done, and generate false GPU vm fault because
        range is
        <br>
        unmapped from cpu.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 7 ++++++-
        <br>
        &nbsp; 1 file changed, 6 insertions(+), 1 deletion(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
        <br>
        index f3d62e196901..d1ef61811169 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
        <br>
        @@ -223,7 +223,7 @@ int
        amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
        <br>
        &nbsp;&nbsp; */
        <br>
        &nbsp; int amdgpu_ih_process(struct amdgpu_device *adev, struct
        amdgpu_ih_ring *ih)
        <br>
        &nbsp; {
        <br>
        -&nbsp;&nbsp;&nbsp; unsigned int count = AMDGPU_IH_MAX_NUM_IVS;
        <br>
        +&nbsp;&nbsp;&nbsp; unsigned int count;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 wptr;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ih-&gt;enabled || adev-&gt;shutdown)
        <br>
        @@ -232,6 +232,8 @@ int amdgpu_ih_process(struct amdgpu_device
        *adev, struct amdgpu_ih_ring *ih)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr = amdgpu_ih_get_wptr(adev, ih);
        <br>
        &nbsp; &nbsp; restart_ih:
        <br>
        +&nbsp;&nbsp;&nbsp; count = AMDGPU_IH_MAX_NUM_IVS;
        <br>
        +
        <br>
      </blockquote>
      <br>
      This looks like a bugfix to me and should probably be in a
      separate patch with CC: stable.
      <br>
    </blockquote>
    ok, will add separate patch for this fix. I think this bug shows up
    now for ring1 because retry fault is burst and flooding even after
    filter.<br>
    <blockquote type="cite" cite="mid:1862b795-3401-b89f-089b-4b544957d150@gmail.com">
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;%s: rptr %d, wptr %d\n&quot;,
        __func__, ih-&gt;rptr, wptr);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Order reading of wptr vs. reading of IH ring data */
        <br>
        @@ -240,6 +242,9 @@ int amdgpu_ih_process(struct amdgpu_device
        *adev, struct amdgpu_ih_ring *ih)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (ih-&gt;rptr != wptr &amp;&amp; --count) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_dispatch(adev, ih);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih-&gt;rptr &amp;= ih-&gt;ptr_mask;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ih == &amp;adev-&gt;irq.ih1)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr = amdgpu_ih_get_wptr(adev, ih);
        <br>
      </blockquote>
      <br>
      Well that handling does not really make much sense.
      <br>
      <br>
      The AMDGPU_IH_MAX_NUM_IVS define controls how many IVs we can
      process before checking the wptr again.
      <br>
      <br>
    </blockquote>
    <p>It is hard to understand, this debug log can explain more
      details, with this debug message patch</p>
    <p>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
      b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c<br>
      index ed6f8d24280b..8859f2bb11b1 100644<br>
      --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c<br>
      +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c<br>
      @@ -234,10 +235,12 @@ int amdgpu_ih_process(struct amdgpu_device
      *adev, struct amdgpu_ih_ring *ih)<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return IRQ_NONE;<br>
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr = amdgpu_ih_get_wptr(adev, ih);<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ih == &amp;adev-&gt;irq.ih1)<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;entering rptr 0x%x, wptr 0x%x\n&quot;,
      ih-&gt;rptr, wptr);<br>
      <br>
      &nbsp;restart_ih:<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ih == &amp;adev-&gt;irq.ih1)<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;starting rptr 0x%x, wptr 0x%x\n&quot;,
      ih-&gt;rptr, wptr);<br>
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Order reading of wptr vs. reading of IH ring data */<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rmb();<br>
      @@ -245,8 +248,12 @@ int amdgpu_ih_process(struct amdgpu_device
      *adev, struct amdgpu_ih_ring *ih)<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (ih-&gt;rptr != wptr &amp;&amp; --count) {<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_dispatch(adev, ih);<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih-&gt;rptr &amp;= ih-&gt;ptr_mask;<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ih == &amp;adev-&gt;irq.ih1) {<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;rptr 0x%x, old wptr 0x%x, new
      wptr 0x%x\n&quot;,<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih-&gt;rptr, wptr,<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_get_wptr(adev, ih));<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_set_rptr(adev, ih);<br>
      @@ -257,6 +264,8 @@ int amdgpu_ih_process(struct amdgpu_device
      *adev, struct amdgpu_ih_ring *ih)<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (wptr != ih-&gt;rptr)<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto restart_ih;<br>
      <br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ih == &amp;adev-&gt;irq.ih1)<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;exiting rptr 0x%x, wptr 0x%x\n&quot;,
      ih-&gt;rptr, wptr);<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return IRQ_HANDLED;<br>
      &nbsp;}<br>
      <br>
    </p>
    <p>This is log, timing 48.807028, ring1 drain is done, rptr == wptr,
      ring1 is empty, but the loop continues, to handle outdated retry
      fault.<br>
    </p>
    <p>[&nbsp;&nbsp; 48.802231] amdgpu_ih_process:243: amdgpu: starting rptr
      0x520, wptr 0xd20<br>
      [&nbsp;&nbsp; 48.802235] amdgpu_ih_process:254: amdgpu: rptr 0x540, old wptr
      0xd20, new wptr 0xd20<br>
      [&nbsp;&nbsp; 48.802256] amdgpu_ih_process:254: amdgpu: rptr 0x560, old wptr
      0xd20, new wptr 0xd20<br>
      [&nbsp;&nbsp; 48.802260] amdgpu_ih_process:254: amdgpu: rptr 0x580, old wptr
      0xd20, new wptr 0xd20<br>
      [&nbsp;&nbsp; 48.802281] amdgpu_ih_process:254: amdgpu: rptr 0x5a0, old wptr
      0xd20, new wptr 0xd20<br>
      [&nbsp;&nbsp; 48.802314] amdgpu_ih_process:254: amdgpu: rptr 0x5c0, old wptr
      0xd20, new wptr 0xce0<br>
      [&nbsp;&nbsp; 48.802335] amdgpu_ih_process:254: amdgpu: rptr 0x5e0, old wptr
      0xd20, new wptr 0xce0<br>
      [&nbsp;&nbsp; 48.802356] amdgpu_ih_process:254: amdgpu: rptr 0x600, old wptr
      0xd20, new wptr 0xce0<br>
      [&nbsp;&nbsp; 48.802376] amdgpu_ih_process:254: amdgpu: rptr 0x620, old wptr
      0xd20, new wptr 0xce0<br>
      [&nbsp;&nbsp; 48.802396] amdgpu_ih_process:254: amdgpu: rptr 0x640, old wptr
      0xd20, new wptr 0xce0<br>
      [&nbsp;&nbsp; 48.802401] amdgpu_ih_process:254: amdgpu: rptr 0x660, old wptr
      0xd20, new wptr 0xce0<br>
      [&nbsp;&nbsp; 48.802421] amdgpu_ih_process:254: amdgpu: rptr 0x680, old wptr
      0xd20, new wptr 0xce0<br>
      [&nbsp;&nbsp; 48.802442] amdgpu_ih_process:254: amdgpu: rptr 0x6a0, old wptr
      0xd20, new wptr 0xce0<br>
      [&nbsp;&nbsp; 48.802463] amdgpu_ih_process:254: amdgpu: rptr 0x6c0, old wptr
      0xd20, new wptr 0xce0<br>
      [&nbsp;&nbsp; 48.802483] amdgpu_ih_process:254: amdgpu: rptr 0x6e0, old wptr
      0xd20, new wptr 0xce0<br>
      [&nbsp;&nbsp; 48.802503] amdgpu_ih_process:254: amdgpu: rptr 0x700, old wptr
      0xd20, new wptr 0xce0<br>
      [&nbsp;&nbsp; 48.802523] amdgpu_ih_process:254: amdgpu: rptr 0x720, old wptr
      0xd20, new wptr 0xce0<br>
      [&nbsp;&nbsp; 48.802544] amdgpu_ih_process:254: amdgpu: rptr 0x740, old wptr
      0xd20, new wptr 0xce0<br>
      [&nbsp;&nbsp; 48.802565] amdgpu_ih_process:254: amdgpu: rptr 0x760, old wptr
      0xd20, new wptr 0xce0<br>
      [&nbsp;&nbsp; 48.802569] amdgpu_ih_process:254: amdgpu: rptr 0x780, old wptr
      0xd20, new wptr 0xce0<br>
      [&nbsp;&nbsp; 48.804392] amdgpu_ih_process:254: amdgpu: rptr 0x7a0, old wptr
      0xd20, new wptr 0xf00<br>
      [&nbsp;&nbsp; 48.806122] amdgpu_ih_process:254: amdgpu: rptr 0x7c0, old wptr
      0xd20, new wptr 0x840<br>
      [&nbsp;&nbsp; 48.806155] amdgpu_ih_process:254: amdgpu: rptr 0x7e0, old wptr
      0xd20, new wptr 0x840<br>
      [&nbsp;&nbsp; 48.806965] amdgpu_ih_process:254: amdgpu: rptr 0x800, old wptr
      0xd20, new wptr 0x840<br>
      [&nbsp;&nbsp; 48.806995] amdgpu_ih_process:254: amdgpu: rptr 0x820, old wptr
      0xd20, new wptr 0x840<br>
      [&nbsp;&nbsp; 48.807028] amdgpu_ih_process:254: amdgpu: rptr 0x840, old wptr
      0xd20, new wptr 0x840<br>
      [&nbsp;&nbsp; 48.807063] amdgpu_ih_process:254: amdgpu: rptr 0x860, old wptr
      0xd20, new wptr 0x840<br>
      [&nbsp;&nbsp; 48.808421] amdgpu_ih_process:254: amdgpu: rptr 0x880, old wptr
      0xd20, new wptr 0x840<br>
    </p>
    <p>Cause this gpu vm fault dump because address is unmapped from
      cpu.<br>
    </p>
    <p>[&nbsp;&nbsp; 48.807071] svm_range_restore_pages:2617: amdgpu: restoring
      svms 0x00000000733bf007 fault address 0x7f8a6991f</p>
    <p>[&nbsp;&nbsp; 48.807170] svm_range_restore_pages:2631: amdgpu: failed to
      find prange svms 0x00000000733bf007 address [0x7f8a6991f]<br>
      [&nbsp;&nbsp; 48.807179] svm_range_get_range_boundaries:2348: amdgpu: VMA
      does not exist in address [0x7f8a6991f]<br>
      [&nbsp;&nbsp; 48.807185] svm_range_restore_pages:2635: amdgpu: failed to
      create unregistered range svms 0x00000000733bf007 address
      [0x7f8a6991f]</p>
    <p>[&nbsp;&nbsp; 48.807929] amdgpu 0000:25:00.0: amdgpu: [mmhub0] retry page
      fault (src_id:0 ring:0 vmid:8 pasid:32770, for process kfdtest pid
      3969 thread kfdtest pid 3969)<br>
      [&nbsp;&nbsp; 48.808219] amdgpu 0000:25:00.0: amdgpu:&nbsp;&nbsp; in page starting at
      address 0x00007f8a6991f000 from IH client 0x12 (VMC)<br>
      [&nbsp;&nbsp; 48.808230] amdgpu 0000:25:00.0: amdgpu:
      VM_L2_PROTECTION_FAULT_STATUS:0x00800031<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:1862b795-3401-b89f-089b-4b544957d150@gmail.com">We could
      of course parameterize that so that we check the wptr after each
      IV on IH1, but please not hard coded like this.
      <br>
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_set_rptr(adev, ih);
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
