Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CFAC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 14:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E91F611ED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 14:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8E91F611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E13AB6E529;
	Wed, 10 Nov 2021 14:44:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3278F6E49F
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 14:44:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aR+f/3dCiTKwGC22zqoYe+o8DOn3gA3QLrzYZs+UaMGI96H38JBNQYptFWSMKJiOcq17VG7wP6kZtMPJ5rtjI/3AGQiCvtQU0MxtiElsNyn7cSM/Jxa/M40sA5JfPd/4Z8rQcrLvsvRm6JmE3/JXGy/BnrGedb+gCyAkzkdGZbf3obeuJKg8RM9XoDhOvAhz2J8UJqSazPFhAVVvnj4/Eso9g71qd0dEY3pXaY5YEkTVOM7172gOgw8vQ51YwIFwyIjEMxXXq6DB1zeKJQamUZqkNwXvtxyp/KCzHW37EuWNV4eG3vXqixViyT/405KrBEkBZ8xbSTiUDiFO/d41Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OxRh7ePpWm6Glx6iuRZkmOostAQAgZnFTXnSt7KkIE=;
 b=j4/hbro5+8asIOPHJayoY9yqhphF8XMNeZWY/wBa0RPmMKM/wa9j/d7Dz7AF/7bvh8sbzIV6U7k99C9G6u9dgqHFjVS+6IL1abIX0TmB+HagEF2t5pBrRJk9zRKI4aHErD+3O7W8f26m0g32dAWdds2yKpdwEXW9eDDKzgcooUyu8rWi1sN1nOnjtP6CSf1DegCG9lfD6vSygxQIpVCn0c0A5+SbcGiOPlV0zk1i49dEM3jusJmDmj6kAm6v+lbgXEsySy2F2/24kdnRdm5kduXSzS05NuKuKwMC4UkMYms7770+iu7GtI8LXuFFiepHtIa6PZj+OwGtf7NAeaF5Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OxRh7ePpWm6Glx6iuRZkmOostAQAgZnFTXnSt7KkIE=;
 b=0qg07lEnKlWM3+pFIEVly/5Gd2NmmAN+8RrLYOT5OQp5IJquNRtjYklUmq4ihXqslhArEtUANlROEJ3/AfjElJLNzONem/bTvap2Yns4rVB0S/G7/Q3t2+v958D2uuipEn5KXGa1GozM3ht5h3TGi3OXmb8W54JsInr4yswAflQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5086.namprd12.prod.outlook.com (2603:10b6:5:389::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Wed, 10 Nov
 2021 14:44:28 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf%4]) with mapi id 15.20.4669.015; Wed, 10 Nov 2021
 14:44:28 +0000
Subject: Re: [PATCH 1/5] drm/amdgpu: handle IH ring1 overflow
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211109230432.3947-1-Philip.Yang@amd.com>
 <1862b795-3401-b89f-089b-4b544957d150@gmail.com>
 <c5855126-de94-f2b4-c912-f386b6b47142@amd.com>
 <9e4e654f-8996-fc9a-0ec6-211a7c0ddf42@gmail.com>
From: philip yang <yangp@amd.com>
Message-ID: <8582ee1f-3327-2822-9385-38c2a283f89d@amd.com>
Date: Wed, 10 Nov 2021 09:44:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <9e4e654f-8996-fc9a-0ec6-211a7c0ddf42@gmail.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0071.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fd::6) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 PAZP264CA0071.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fd::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11 via Frontend Transport; Wed, 10 Nov 2021 14:44:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d907178-5841-43ab-76fb-08d9a45898fa
X-MS-TrafficTypeDiagnostic: DM4PR12MB5086:
X-Microsoft-Antispam-PRVS: <DM4PR12MB508644F4A271465DF27C5322E6939@DM4PR12MB5086.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3akC6GsYIcRlAbukiN2HlKSbTvAsOzPnVxNX79G0VgzI783DrHFPGK5LnHE3YmvUtEuD66i/QgBSLq/EvItImIMASf3oBjnxMhOgw0js1T+iRsMoq0ml9W1i0H4CM0FSTlezWtv3Og9Dnt7iUYqxgeNjn4Y1keG5TjZ9ZYP5ZDw6KhktPZ4iryfcn5kY9fqXUNBTybMYTrh4uQf/v9bc3SFJvke+KDl3v1hFm3UMnbu2aPA0Tf64bEZHL0tNj6czsROoK9KHxm8TX6pTMAaOsOrmjN5qIwfWd9mUPDSmqcN7YvP9WPSbIqkKQXt/B+eu5G6QQgO58UKFyFCfBzuhoYvRorHDhSwCZyc9NmpOYT0tfw4o3Z6tZKE/UB7kHu/w76NGUSEQ4BWABqvfo1oYokLYey51A+D3NbYbMx8qeOcPOXrTeAqopR+0kRd9Q6V52Lna1yAkFoFrCelOXXioSh9LLa3WJ+ojA5jzeDsTg4bEiOcuX76A7YQckWZXRmMPn7EGwWIYFwyYT1kkFMIM7Lmo891rp5eQeauPO4yQMiHLAaCLP9NwrJcl4ZX2rgYRU84z0irkLcWOiE+FPXUcetYdD5IinUT2QxmOsNd2z5dzFxZK6QH6738MsU9HsLoSt4L5HdJUhgFfok3I8Y3SH8hzrvunoRq9e3PN3lN68l9NQeCmlSCQXmp3awFOQz8vxRx7WwORkl7kmh+AhCBPE+f9hLOeROX4rS5AX0n/E2A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(2616005)(2906002)(66946007)(316002)(16576012)(508600001)(4326008)(36756003)(4001150100001)(83380400001)(66556008)(8676002)(6666004)(38100700002)(66476007)(5660300002)(31686004)(8936002)(53546011)(66574015)(6486002)(31696002)(956004)(110136005)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzF4YzlZY1lBM3RpSm1Vc0llcjFHOXhvQ0hzbXcyRnZEb1FKS2JmNjlhUWV5?=
 =?utf-8?B?b1VWaWk5eXd0OHFTQkgxWWdBc01MdVB4em10Wnp0cEdVTGtRS1AyUFB5aXNa?=
 =?utf-8?B?YWhBaW5oMHRZL0RQOEdNQkxOZFZVVm02YzFVK1k4dXcyUkFuSnlsTTNsWGpk?=
 =?utf-8?B?eGQxZzFneEpJR082UmdZdEFPOXZKdWpDWUR5bmtBa0V1R0ZXT0llNXJKVlVk?=
 =?utf-8?B?blV0NWVJVTczNU1hQzloeWNkbXUrOXJsZEUzNUc3Y24xV0hzU1NtRmFQK0pv?=
 =?utf-8?B?NEhtYWN3SkVyTWd6MDlsWGtOci9ZWTN5NDEvRnhxUmdEUzdiR3Q1a3dybFU5?=
 =?utf-8?B?cEpxTjhsSVZXeHpPN2dZT1d1bTlaT3h5Ry9ERWFGUnpVSFBLVWxtK1FFUlVZ?=
 =?utf-8?B?WjVFWGRtL0FpRHVEWjB1WEk4cXhJeEM1aGJWeTV4cW1tRWJWVEFuMkR1VC9I?=
 =?utf-8?B?TDNjK1c0MGRMcjZBZW51R3llZFgzK0Q0NnJ2bFI1SFpZN3k4bWF4dndLTWhy?=
 =?utf-8?B?MjZjZGU4bWNyY2hDN1NDMFZVdDAwTEM3SE5SckJncldtcDR2R1k2NFMyOFZK?=
 =?utf-8?B?bjNvZW5KOU5vRUVueHVadjFXUlgwR24zamZPSStOMVBVS0hmdzJ1djExSnZp?=
 =?utf-8?B?U21Dai9oWFVxMDNTRmp1Rnp4TUo3MVpDWWxZa0VoOVdWd3ZJeEpzODhyVldt?=
 =?utf-8?B?TzRoSWc4R1JFd0R2Q3g5bFdubTdQSkcvSFoycnNERnM1TE1WK1RuNUM4OHBt?=
 =?utf-8?B?cy83SjM5Vm9zVDh3R3BpNWxIVzZRV3JORWkyZFlUMFlYZVpZT1lFNnplMlB3?=
 =?utf-8?B?WFRLdms2SDFOa0swcU93K1FuaTYrd2hBT0xFSVVheWRTUEhocGdHSmxpVm5y?=
 =?utf-8?B?cnQ4VE9oUlVTeFpxUGhnS2o3bURlQ0ZQNFlpbkdlbjRWdzVnL01VOVQ0ZFIw?=
 =?utf-8?B?MG9nUWdaSi9jcFl2U0VrNUJvTWs2d0tyU3pERXNzcU5IZHdDOE9pc3gySUcy?=
 =?utf-8?B?MGd3Y2dCSmxUYm0rYnYwV2xRRWxkbm1kdzh6d3lYUTdMU20ySndoVEo2bStK?=
 =?utf-8?B?UUF0MkJhSmQzOGEzRGNURmFTWXFhYW1VVXFGWm5CSDFiR0ZrdXI3NG03QXpY?=
 =?utf-8?B?RU9TUTlIOVAyOFNXNU1USG84WUE3NE5XcExGMjl5SlI5ZThwR0VRY0VnTmw5?=
 =?utf-8?B?SlN6a1pQdVF0K2ZOSmwrQmpRZ1VVQkJuWndPbmtmOUw0ZVFpWVh1S29xZ2cv?=
 =?utf-8?B?KzhNOExiL05FMGdKOG1qcHpheXdVTFdTaEE5VkVUbVhhbXdObU1aZHFhamNM?=
 =?utf-8?B?VkF5MVRFOGNtam5ZNmtTRGVEQ2pTaXg5R0RJU2lJZUFXUEp0ZXVBOFpUeHl6?=
 =?utf-8?B?Q3pVZmJPcm9Ncks0SkZOa0UwRUVURXYzY1JUYWVnMy80UmpjZUpka1hWOWZh?=
 =?utf-8?B?djhZbStrVFMreG1PckpnQjkzYmY1NEkrbHd0TUtqYTlHRmJNVVgxWXJlRVN2?=
 =?utf-8?B?QjU5RUw5SEhWUDRFdmk3M2dETE9CUWt2cWJZR1BRNU5OS0xKVjl2TUtzRlFs?=
 =?utf-8?B?b3VRdndHcE4rQ3Q2dGgvb0dMRWlDWlo0eHJWVWQ1NG1yMWMyeVhQSHRpMHQ3?=
 =?utf-8?B?TmRZMWt3U3hTeldZdml5ODdweUVEOVVmdk1DQ2o3L1lmak51V2dRa29VTzhl?=
 =?utf-8?B?UVhyZjdnZHlBVmtYYmE5YmQwN203V3grZk5scEZjMjF3bUJDdVpnMkpmNjBL?=
 =?utf-8?B?N3ZwZW1LdE1JODNpampxeUd0ZldZNzRFRHlWZmNXM0NFbTVjcWJDMlJRMGVQ?=
 =?utf-8?B?UDZuZm9WSGJpeGdhZ3BFbHY2Szd3amNTcTdBK1RuWnIwelRMZDNEK280eUQ0?=
 =?utf-8?B?ZzhoUUNDYWVXTCtQWmVQRkkwbzhqdmdoS1RTQVVSRHNYRC9DTTNMbTkra2RH?=
 =?utf-8?B?VjZ4VkM4TmFha1lBOFh2bDE0Uy8yb0hWRks2Qm04UjA3eUJ5TkN4TlhyN1Nn?=
 =?utf-8?B?aTVGVSt2Zk5rbVREdWM2SlFVMHI0bTJoa3psZGIxVlY3cHByQ1AvbzB1RENz?=
 =?utf-8?B?dDNlMmYyQW1vMVZJaTNlQ3ZONDdtZnppVzFYd1NYMmw1bTJubTE5dUw1dUM1?=
 =?utf-8?Q?5zbA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d907178-5841-43ab-76fb-08d9a45898fa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 14:44:28.1688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLnteiQskt2SwnkKNwyil/WmKAPWihd8VnUyZ8Nz/AqA9to/SSi2eH9/xAoCmNzO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5086
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
    <div class="moz-cite-prefix">On 2021-11-10 9:31 a.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:9e4e654f-8996-fc9a-0ec6-211a7c0ddf42@gmail.com">Am
      10.11.21 um 14:59 schrieb philip yang:
      <br>
      <blockquote type="cite">
        <br>
        On 2021-11-10 5:15 a.m., Christian König wrote:
        <br>
        <br>
        <blockquote type="cite">[SNIP]
          <br>
        </blockquote>
        <br>
        It is hard to understand, this debug log can explain more
        details, with this debug message patch
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
        <br>
        index ed6f8d24280b..8859f2bb11b1 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
        <br>
        @@ -234,10 +235,12 @@ int amdgpu_ih_process(struct amdgpu_device
        *adev, struct amdgpu_ih_ring *ih)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return IRQ_NONE;
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr = amdgpu_ih_get_wptr(adev, ih);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ih == &amp;adev-&gt;irq.ih1)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;entering rptr 0x%x, wptr 0x%x\n&quot;,
        ih-&gt;rptr, wptr);
        <br>
        <br>
        &nbsp;restart_ih:
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ih == &amp;adev-&gt;irq.ih1)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;starting rptr 0x%x, wptr 0x%x\n&quot;,
        ih-&gt;rptr, wptr);
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Order reading of wptr vs. reading of IH ring data */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rmb();
        <br>
        @@ -245,8 +248,12 @@ int amdgpu_ih_process(struct amdgpu_device
        *adev, struct amdgpu_ih_ring *ih)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (ih-&gt;rptr != wptr &amp;&amp; --count) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_dispatch(adev, ih);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih-&gt;rptr &amp;= ih-&gt;ptr_mask;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ih == &amp;adev-&gt;irq.ih1) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;rptr 0x%x, old wptr 0x%x, new
        wptr 0x%x\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih-&gt;rptr, wptr,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_get_wptr(adev, ih));
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_set_rptr(adev, ih);
        <br>
        @@ -257,6 +264,8 @@ int amdgpu_ih_process(struct amdgpu_device
        *adev, struct amdgpu_ih_ring *ih)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (wptr != ih-&gt;rptr)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto restart_ih;
        <br>
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ih == &amp;adev-&gt;irq.ih1)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;exiting rptr 0x%x, wptr 0x%x\n&quot;,
        ih-&gt;rptr, wptr);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return IRQ_HANDLED;
        <br>
        &nbsp;}
        <br>
        <br>
        This is log, timing 48.807028, ring1 drain is done, rptr ==
        wptr, ring1 is empty, but the loop continues, to handle outdated
        retry fault.
        <br>
        <br>
      </blockquote>
      <br>
      As far as I can see that is perfectly correct and expected
      behavior.
      <br>
      <br>
      See the ring buffer overflowed and because of that the loop
      continues, but that is correct because an overflow means that the
      ring was filled with new entries.
      <br>
      <br>
      So we are processing new entries here, not stale ones.
      <br>
    </blockquote>
    <p>wptr is 0x840, 0x860.....0xd20 is not new entries, it is stale
      retry fault, the loop will continue handle stale fault to 0xd20
      and then exit loop, it is because wptr pass rptr after timing
      48.806122.</p>
    <p>Regards.</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:9e4e654f-8996-fc9a-0ec6-211a7c0ddf42@gmail.com">
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">[&nbsp;&nbsp; 48.802231] amdgpu_ih_process:243:
        amdgpu: starting rptr 0x520, wptr 0xd20
        <br>
        [&nbsp;&nbsp; 48.802235] amdgpu_ih_process:254: amdgpu: rptr 0x540, old
        wptr 0xd20, new wptr 0xd20
        <br>
        [&nbsp;&nbsp; 48.802256] amdgpu_ih_process:254: amdgpu: rptr 0x560, old
        wptr 0xd20, new wptr 0xd20
        <br>
        [&nbsp;&nbsp; 48.802260] amdgpu_ih_process:254: amdgpu: rptr 0x580, old
        wptr 0xd20, new wptr 0xd20
        <br>
        [&nbsp;&nbsp; 48.802281] amdgpu_ih_process:254: amdgpu: rptr 0x5a0, old
        wptr 0xd20, new wptr 0xd20
        <br>
        [&nbsp;&nbsp; 48.802314] amdgpu_ih_process:254: amdgpu: rptr 0x5c0, old
        wptr 0xd20, new wptr 0xce0
        <br>
        [&nbsp;&nbsp; 48.802335] amdgpu_ih_process:254: amdgpu: rptr 0x5e0, old
        wptr 0xd20, new wptr 0xce0
        <br>
        [&nbsp;&nbsp; 48.802356] amdgpu_ih_process:254: amdgpu: rptr 0x600, old
        wptr 0xd20, new wptr 0xce0
        <br>
        [&nbsp;&nbsp; 48.802376] amdgpu_ih_process:254: amdgpu: rptr 0x620, old
        wptr 0xd20, new wptr 0xce0
        <br>
        [&nbsp;&nbsp; 48.802396] amdgpu_ih_process:254: amdgpu: rptr 0x640, old
        wptr 0xd20, new wptr 0xce0
        <br>
        [&nbsp;&nbsp; 48.802401] amdgpu_ih_process:254: amdgpu: rptr 0x660, old
        wptr 0xd20, new wptr 0xce0
        <br>
        [&nbsp;&nbsp; 48.802421] amdgpu_ih_process:254: amdgpu: rptr 0x680, old
        wptr 0xd20, new wptr 0xce0
        <br>
        [&nbsp;&nbsp; 48.802442] amdgpu_ih_process:254: amdgpu: rptr 0x6a0, old
        wptr 0xd20, new wptr 0xce0
        <br>
        [&nbsp;&nbsp; 48.802463] amdgpu_ih_process:254: amdgpu: rptr 0x6c0, old
        wptr 0xd20, new wptr 0xce0
        <br>
        [&nbsp;&nbsp; 48.802483] amdgpu_ih_process:254: amdgpu: rptr 0x6e0, old
        wptr 0xd20, new wptr 0xce0
        <br>
        [&nbsp;&nbsp; 48.802503] amdgpu_ih_process:254: amdgpu: rptr 0x700, old
        wptr 0xd20, new wptr 0xce0
        <br>
        [&nbsp;&nbsp; 48.802523] amdgpu_ih_process:254: amdgpu: rptr 0x720, old
        wptr 0xd20, new wptr 0xce0
        <br>
        [&nbsp;&nbsp; 48.802544] amdgpu_ih_process:254: amdgpu: rptr 0x740, old
        wptr 0xd20, new wptr 0xce0
        <br>
        [&nbsp;&nbsp; 48.802565] amdgpu_ih_process:254: amdgpu: rptr 0x760, old
        wptr 0xd20, new wptr 0xce0
        <br>
        [&nbsp;&nbsp; 48.802569] amdgpu_ih_process:254: amdgpu: rptr 0x780, old
        wptr 0xd20, new wptr 0xce0
        <br>
        [&nbsp;&nbsp; 48.804392] amdgpu_ih_process:254: amdgpu: rptr 0x7a0, old
        wptr 0xd20, new wptr 0xf00
        <br>
        [&nbsp;&nbsp; 48.806122] amdgpu_ih_process:254: amdgpu: rptr 0x7c0, old
        wptr 0xd20, new wptr 0x840
        <br>
        [&nbsp;&nbsp; 48.806155] amdgpu_ih_process:254: amdgpu: rptr 0x7e0, old
        wptr 0xd20, new wptr 0x840
        <br>
        [&nbsp;&nbsp; 48.806965] amdgpu_ih_process:254: amdgpu: rptr 0x800, old
        wptr 0xd20, new wptr 0x840
        <br>
        [&nbsp;&nbsp; 48.806995] amdgpu_ih_process:254: amdgpu: rptr 0x820, old
        wptr 0xd20, new wptr 0x840
        <br>
        [&nbsp;&nbsp; 48.807028] amdgpu_ih_process:254: amdgpu: rptr 0x840, old
        wptr 0xd20, new wptr 0x840
        <br>
        [&nbsp;&nbsp; 48.807063] amdgpu_ih_process:254: amdgpu: rptr 0x860, old
        wptr 0xd20, new wptr 0x840
        <br>
        [&nbsp;&nbsp; 48.808421] amdgpu_ih_process:254: amdgpu: rptr 0x880, old
        wptr 0xd20, new wptr 0x840
        <br>
        <br>
        Cause this gpu vm fault dump because address is unmapped from
        cpu.
        <br>
        <br>
        [&nbsp;&nbsp; 48.807071] svm_range_restore_pages:2617: amdgpu: restoring
        svms 0x00000000733bf007 fault address 0x7f8a6991f
        <br>
        <br>
        [&nbsp;&nbsp; 48.807170] svm_range_restore_pages:2631: amdgpu: failed to
        find prange svms 0x00000000733bf007 address [0x7f8a6991f]
        <br>
        [&nbsp;&nbsp; 48.807179] svm_range_get_range_boundaries:2348: amdgpu: VMA
        does not exist in address [0x7f8a6991f]
        <br>
        [&nbsp;&nbsp; 48.807185] svm_range_restore_pages:2635: amdgpu: failed to
        create unregistered range svms 0x00000000733bf007 address
        [0x7f8a6991f]
        <br>
        <br>
        [&nbsp;&nbsp; 48.807929] amdgpu 0000:25:00.0: amdgpu: [mmhub0] retry page
        fault (src_id:0 ring:0 vmid:8 pasid:32770, for process kfdtest
        pid 3969 thread kfdtest pid 3969)
        <br>
        [&nbsp;&nbsp; 48.808219] amdgpu 0000:25:00.0: amdgpu:&nbsp;&nbsp; in page starting
        at address 0x00007f8a6991f000 from IH client 0x12 (VMC)
        <br>
        [&nbsp;&nbsp; 48.808230] amdgpu 0000:25:00.0: amdgpu:
        VM_L2_PROTECTION_FAULT_STATUS:0x00800031
        <br>
        <br>
        <blockquote type="cite">We could of course parameterize that so
          that we check the wptr after each IV on IH1, but please not
          hard coded like this.
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
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
