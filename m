Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04248C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 17:34:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 798E410E854;
	Thu, 28 Apr 2022 17:34:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F9D910E854
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 17:34:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZPyqsTfPdzuvwvFuIzQsQ5mUQplcxVDWDrm6aRI8sgrV8CaGvBa7TtHbJcsPlP4zfcMsWzvCJpTSVd+HAwb/8nrJLhS2602ROJXJdMMFfOe/KPAP8Hf39Knm+w9R4e0x0u7lQnpgqTc5IKi4IR6qhH+SyMJo4psNdiRdpNsvym2PPzPeuEH51nFi6FYnxzeMSZTOip5j/B8/9KnCAED+UD1e1bGid8yy8plUA1PtibgOsb4M9Y8XXkEQ9UfMvxx01FDnAEeM5s1ybqy26YDrEaNZjJlHPjj4pw9HP9BwV3B2VtVtC1v9ckhZZOG2+shV7RBe4zKfwHaseMpSLbyfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMvJJIaMDwuNoghRwlXIIvJpuUZFse68ZJQwRBV82To=;
 b=j4AlE6nDE0pTIBw5FsGu3tTcT38NBdyzKoHJ1j9LkZ9y376Z+880JiaOj5xKqTQR2RRzTVcwgq4UcpmvSzhIbVQSWPeuBJFamVdLyNZHLb2+XhnH9OrWdyCV+AO53/Kp8i9gL4Xb8sMTukrGvMTx8zLlJu4LRSYae+awtWzauB8zoGuc8XHMH+gtSVDdex86hUQx28pT4ypzIAuRh1hOwWNZIrrKKU/Msx95iWrFNWVtgHvmWyj683hfwzDRaR2pu3vyx0GDZ9pQuH1AEniKrT1WXtfbAo2A47ZwLkKSXP1gIL4W/x3Hj+oxgjVP7qXtReJH8WEyFhqp7s+trnj0Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMvJJIaMDwuNoghRwlXIIvJpuUZFse68ZJQwRBV82To=;
 b=Gwxnv+Qpz6R9RXJMUBOWcBYOQ9S6b1nElv1G4yedZpzrAGlHetP96fiXGWMwHYRfBoNQwAJDI/V+VTj/20A2T7J31s/KzhrkvnMM4g4ExLE+vhR87mvht6EsKhH/I02yWKdSd70nLauUjnZbmIrCWZ8vBSTXMpJNyKrCnStgXQo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CH0PR12MB5172.namprd12.prod.outlook.com (2603:10b6:610:bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 17:34:12 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b176:c415:e589:a801]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b176:c415:e589:a801%3]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 17:34:11 +0000
Message-ID: <fa22e1bc-c493-d2ec-811a-cb05f4647a07@amd.com>
Date: Thu, 28 Apr 2022 13:34:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/1] drm/amdgpu: Free user pages if amdgpu_cs_parser_bos
 failed
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <CAP145piim21dDoS7fsv9WQ-Toc3xr-xG7ayP7_T+F4SeS8AUmQ@mail.gmail.com>
 <20220427230700.11891-1-Philip.Yang@amd.com>
 <a214a2f2-c790-a76d-5b67-0712341ce69a@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <a214a2f2-c790-a76d-5b67-0712341ce69a@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0108.namprd04.prod.outlook.com
 (2603:10b6:610:75::23) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a91c4e1b-38a1-4bdd-e510-08da293d4eaf
X-MS-TrafficTypeDiagnostic: CH0PR12MB5172:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB51728AEAB9C399A61EB90F37E6FD9@CH0PR12MB5172.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l7uXwkvZjttYjPJrr7NLkYztoATWAGR2eXgmNektVOituraZnXWxxBQYk2UaTACUuna7obcVB5qTLxS2hGkhdGN2gqU+jqN9TxisiO+Dzx9gig0/XKju6L5Fz524W0XX/yTB9R78nNXDk8/XV+l847hzKkV+NVrFUxEe+2qsehN7ikU2sBSP/SzzsmPUH3hJxDlQ+aNd/FEee33xG0wdYEuLaYtY2ED1ApotgzipXTZQAaJfZADX41CfhNBolj0CTH67HX2+aeMKvvr6ap6ti2qDMV+zsXvfVeCPcKUpCeum6lbgv1vhzK05WHm8D34V2utKXdIm9YDClPN+4yJJDWzFLKIapxtbE3MKYX2pUL4Ct33asjxXm87vv1g9AKoqJAk7Uoaz7WgVHxocBS5SYuYVhutjAq/XDHWINnbWXlxfxLzYgtd4Rm0UuMHna0S+IrQ57cbYsX7UZCZi+l7+g8pRiHfbQR0whxMCgul0YCDmBv6u9Ix6XYbJQANp63ZKLzYfnvCtlAJvMnWkSaXYAWz1trYuOOJ5Kd1+c7HdDl6tbbh2M+g58JpHTmxwHFgGYsHV3yCT0m0cwfDXpChxXL8Chc6RpQjduMruBYeba8ubw6dG0iJKgC/oXHKzwlEJ+QWGIoDtXk0xDnWgKv0UaAuCWjoN2PyG5gFZ8i8wl9iluBjErULqudIlYXiCbT/wto1gk1jm1Rj8fBVne/+uzic9EE1o8xMEMyuy7+m5URc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(6506007)(53546011)(6486002)(186003)(8936002)(26005)(31696002)(508600001)(6512007)(5660300002)(2616005)(110136005)(36756003)(316002)(66556008)(66476007)(8676002)(66946007)(38100700002)(31686004)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEtTOVkwNkZKNlFTeFBlZnZUUHFyMzJsMHlnOXp2WUpCdWVkNFlrcWN2M3hT?=
 =?utf-8?B?YUVmRVNJVkhzVXlWTFhMd3JhS1VLV0dnU092Y2l5dEdPbS9NMExXbUxRU3NI?=
 =?utf-8?B?OU1lazdsaWNKOUs3c08vTk1yRnpvVjB3aVZIMThPYzFiS1p6V0R5bkNKd0Zk?=
 =?utf-8?B?clhKdnJLdUlWYUlrSGF4dGxjaW5SYkZyN2p1dTgwUkxrckRRY2lLaFVQS0Rr?=
 =?utf-8?B?OGk0bHp5SlhZV0VSb3dTSjZLZDVFZXBUOGs5VWczbkJrVGtqQk5Jc053azBV?=
 =?utf-8?B?dnIrZkdrcXhrMGJaNTloaHhiMkR2ZnpDNFhQc3JiQUd5UTRVQlRUS2pWOXpp?=
 =?utf-8?B?c3dhVDMvTGpiVzdKTmMzbDAxNlg4RlQ3QnJzL1dvM3R4ZlRzdHhrb05YUzJt?=
 =?utf-8?B?TmFMckVmTXI5WXBSQ2NMWCtBZ08zS0VtQ3F0MjFWYTdXcjN4ci9zeG9PemFY?=
 =?utf-8?B?R3BEdENHMlFzZ2JYVHhyZ2l4TW9rMWJUYWZQVlNSNHNyUHZ6THY3VmRmV3Vy?=
 =?utf-8?B?VHJGSmUzZmMwdEo1RXVNUjIzNGxjdndySE9tSi9XVzN2ZTdjQWtBWEtXd2hy?=
 =?utf-8?B?cG5mekQwaXl5M3o3Nkg5Mkx6SzdKSDhaaEVsRTRZTlpkbXptUFljNjNnN3JH?=
 =?utf-8?B?UEdwcTZzYVBWNWxZajNDNnFkOUhia3J1K2ZvdVh0SENzSHQ2Zk9YczJKNytJ?=
 =?utf-8?B?R3ExdmR3S3dwUDAxdlkxeERpZUgySmdqUzlDUzlXek1TN1pNWE01VUdjS1F5?=
 =?utf-8?B?cFlMRFRPY0UwbkZvVE5VcTJ5VU1mVGhsaGNzK2FwcTZuQ3N6a00wSHlEbkV3?=
 =?utf-8?B?MGpkU3ROVXVLV0NQSWMyeVBYR2JrYUVWWmhjNXJyWVY3V3AwdXJ4ckZCT1BQ?=
 =?utf-8?B?akExRUYvbFQ1US90T3JRYkp4MzFTYmpPdnVNVHhMWXJLMXBWWktDQXZmVlR3?=
 =?utf-8?B?Zk05MDVRN2RJRlZpZDJuTlM3TERHWnlhNnQxOFZKQ1JHbWpsUEZvVERjQUd3?=
 =?utf-8?B?NG0rcmdKN3c4TmthTlJNckRkU3I1d1RFTGRRYXB6MDZ2UDNnL2lnWGlEWUo4?=
 =?utf-8?B?ZlIzU1NjZ3VGY3Zpekd3bXh3UVpxT0M4aHk0MlpFVWZQWkJvWnJFM1NSem5T?=
 =?utf-8?B?dHVwbXhMaXdNQ3Fxdjd2TWhiUlpVelRtOUc1a1NNdVpuU2l1UmY4NktiQ2g2?=
 =?utf-8?B?WHdKa3RxdWprdnM3QXYzamhXSHRlM3A1ekF1NlZ6dkk2Sy9CQXBIRnlSNkdm?=
 =?utf-8?B?WHVabkYyaGlOTXAvS2lGTHNnSTRVZS9wUzh1cFB2MXJqcjNJQlV4aFBzbG41?=
 =?utf-8?B?UlJFT1hpdTBNcHRXR3VzcHllR0ZrdHdiM2t5QUNQUHFDTjRhdWNYVldPcURs?=
 =?utf-8?B?Si9udGRacjQxUStoR0dKQlhQbUxBNktoNUtld2lOdUFDa0NGcUpwbnZxaFFY?=
 =?utf-8?B?b1lLUGN4bW45V2c4NWgzZlVJVkh5UW9GRGgrQ1o4K29vMmlPamNxYmNQOEN2?=
 =?utf-8?B?MHFJRTJwaEtiRDNYNG5jcE9oTktDZUtHWVpKRG1SZXM0elphS1N3WWtwRFJn?=
 =?utf-8?B?K0ZIa2N6QmFHTDV0cjVPT3JHYmdyWFJ1OXdsYWRWWDN5QUhPc3pSNGxBQStM?=
 =?utf-8?B?ZFl3UWx3Vld2UjZHUEo4NlpNbnlteVFiRGlzRVB6czZleVFXc2NvUGEyNlVH?=
 =?utf-8?B?aDh0QmRyeUpaSnJqNlJ0eko2Z2g0ak10SlN5YkNFbTlzN05tblBsRm5KVFhj?=
 =?utf-8?B?THNaTGllUmhiK2RuZ3NoSi9OTEVqcHFPbENQcW00dlcvYk9ac1VKdFFteDY0?=
 =?utf-8?B?Sktoa0ZZUVF1M29TaE4rRFFsanpzSFBxSG5ZeUpPemtFLzdJNTRVNVNucFJH?=
 =?utf-8?B?TlVHYnVyVFNBeGVqRVF4K3p1cFFicVN4NzBiZmZzSkZ3RDlGVncxbk5SYzBa?=
 =?utf-8?B?S1lWaXpOeHZZLzhTd0tMN1JZUW5tQjlMb3c0cmtHRGFmTlJMbEF5UzBBRFhP?=
 =?utf-8?B?VXpFaWlPM2RzUjFlUU41eVRLUFU3ME1DL0JWSUpMUCtpZGVIZ1lzZ3J6TFVC?=
 =?utf-8?B?WkpEVFp3MW5SdGpxcExIUkJMRmhOdmNBcFhMS3o5dFJjQU1PL25keUNRWExj?=
 =?utf-8?B?ZUEzbXB4UUN1TCtJaWVoemlLNVBqZVpWaUUzR200MTJ6VDhPTWpxRGFESWZw?=
 =?utf-8?B?SWpMWVdvRkozaTdwM1RheTFVRHJob2JoY0JLSjR0WWlUbGR6QmVrRWlXUDJr?=
 =?utf-8?B?emtNWEpTRzF0aEJYZ1BnUnhsNUZ4TTFhU2pFaEpjdkhMTGk2Y2pDakhsZlkx?=
 =?utf-8?B?NDFMVm45ZmlDakRtUE5Ld2hBWmFUTUQvZ3ZiRlZBSVlvY3B3S0pmUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91c4e1b-38a1-4bdd-e510-08da293d4eaf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 17:34:11.7959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EYebH7Qt4Sb5A/tgyvv4y5QGduua2kqTR5iXuvtZWmLRfyd1aozLKVm1qsHYkbCe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5172
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-04-28 09:51, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:a214a2f2-c790-a76d-5b67-0712341ce69a@amd.com">Am
      2022-04-27 um 19:07 schrieb Philip Yang:
      <br>
      <blockquote type="cite">Otherwise userspace resubmit the BOs again
        will trigger kernel WARNING
        <br>
        and fail the command submission.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 18 +++++++++++++++---
        <br>
        &nbsp; 1 file changed, 15 insertions(+), 3 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
        <br>
        index ea28942b0ede..44dcbef80229 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
        <br>
        @@ -550,7 +550,7 @@ static int amdgpu_cs_parser_bos(struct
        amdgpu_cs_parser *p,
        <br>
      </blockquote>
      <br>
      There is another error case a few lines up, if kvmalloc_array
      fails. I think that needs to be handled with a goto
      out_free_user_pages as well.
      <br>
      <br>
    </blockquote>
    yes, thanks for catching this, I will send another patch to fix this
    as I have merged this patch.<br>
    <blockquote type="cite" cite="mid:a214a2f2-c790-a76d-5b67-0712341ce69a@amd.com">
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kvfree(e-&gt;user_pages);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e-&gt;user_pages = NULL;
        <br>
      </blockquote>
      <br>
      The above two lines can be removed. The loop under
      out_free_user_pages should handle this.
      <br>
    </blockquote>
    <p>No, out_free_user_pages will call
      amdgpu_ttm_tt_get_user_pages_done with gtt-&gt;range is NULL for
      this BO, and trigger kernel WARNING.<br>
    </p>
    <p>Thanks,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:a214a2f2-c790-a76d-5b67-0712341ce69a@amd.com">
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_free_user_pages;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; bo-&gt;tbo.ttm-&gt;num_pages;
        i++) {
        <br>
        @@ -567,7 +567,7 @@ static int amdgpu_cs_parser_bos(struct
        amdgpu_cs_parser *p,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(r != 0)) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r != -ERESTARTSYS)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;ttm_eu_reserve_buffers failed.\n&quot;);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_free_user_pages;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_list_for_each_entry(e, p-&gt;bo_list) {
        <br>
        @@ -649,7 +649,19 @@ static int amdgpu_cs_parser_bos(struct
        amdgpu_cs_parser *p,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_eu_backoff_reservation(&amp;p-&gt;ticket,
        &amp;p-&gt;validated);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -out:
        <br>
        +
        <br>
        +out_free_user_pages:
        <br>
        +&nbsp;&nbsp;&nbsp; if (r) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_list_for_each_userptr_entry(e, p-&gt;bo_list)
        {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bo =
        ttm_to_amdgpu_bo(e-&gt;tv.bo);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!e-&gt;user_pages)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ttm_tt_get_user_pages_done(bo-&gt;tbo.ttm);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kvfree(e-&gt;user_pages);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e-&gt;user_pages = NULL;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp; }
        <br>
        &nbsp; </blockquote>
    </blockquote>
  </body>
</html>
