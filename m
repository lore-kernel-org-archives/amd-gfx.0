Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6721C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 15:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 648FA61186
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 15:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 648FA61186
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB49F6E5C0;
	Wed, 10 Nov 2021 15:45:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F26B6E5C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 15:45:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mD9sIdQnkpltnDHeH+VIzKUZTPEwaYIqpl2QzKBg8b+snbrNUIJQ0M/bMcP/0C06xsBwk4JzbGojvuwWU0BdPAawxZtGTbyU8CYRrJ2+L5K68U1m2d8FFtrr2NlZisci24pJYAoEslNYlNKmKiXge35H89Wu+UBfgqfQ3RU00XseYIQQvUMdfvFUD2M23iHjosffTMuZ4GR4FHKizR9uhvs7JsqYNKvMCh9ABwxijBQAcQhXyT21TL+KvMM3mpvil/iWLZL06OwQnMdUN6m6k6ZV5nD8E+07J9IW1MJLhJGKUGbJXTmFICqoMZEPKUN2Ycev2v07UKXACW5cliGsBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBh9cuZ8le6IyyMoPcWaqSHIoU91AevSvoYMQUc1XM0=;
 b=fYdeKEQPgCtW9zYskVIGm8kti3HtJur1cIHzeEktromXWUcv0VAKcQdwskC4oN4ZPl2nzSmiyO87EgB/Yvq+03e7tQJUrnHQOtqAq67G5gUzMuamD4OKuqThgbQfQylyYB1w8B5I+Xe6m5NHzFgLLCdZhrdcNZBW0hLsdcCC8Bmu+bAF2iolS9u3YNphET8kwFn/iJ2kziiTJW5jchaims6QdBlqz3Mm7tZlbOfLYLgipwUv6r+MN6uug+XqCXPi3m3wPLmYjvtXWqFBT2jzhj6kVe5o3Um7dK7jTwNjoYgIFRo6A9CZWcwbEWXZaq82d11HKMLZZiqrvsgJvukHBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBh9cuZ8le6IyyMoPcWaqSHIoU91AevSvoYMQUc1XM0=;
 b=WTbDBawXEhbjPiLZVMKaFQBFAK+Q082jYtwOP5SDf4FFjyLMWsGdt37wjOxC1dDVUgQxVUpIQAqVDdKR39e3HgAk5fzEGpBz6ttSkMB/xRrzMzs1xwIqy3RwPRP+CeNafu/AFDM9PKJz0s0eqbz8PBvOTiKd7K2615F6FEyuZJM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5374.namprd12.prod.outlook.com (2603:10b6:5:39a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Wed, 10 Nov
 2021 15:45:21 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf%4]) with mapi id 15.20.4669.015; Wed, 10 Nov 2021
 15:45:21 +0000
Subject: Re: [PATCH 1/5] drm/amdgpu: handle IH ring1 overflow
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211109230432.3947-1-Philip.Yang@amd.com>
 <1862b795-3401-b89f-089b-4b544957d150@gmail.com>
 <c5855126-de94-f2b4-c912-f386b6b47142@amd.com>
 <9e4e654f-8996-fc9a-0ec6-211a7c0ddf42@gmail.com>
 <8582ee1f-3327-2822-9385-38c2a283f89d@amd.com>
 <4130bde8-8184-4aed-4634-7d58f3e61d2f@gmail.com>
From: philip yang <yangp@amd.com>
Message-ID: <6e18ae5a-f4b5-2330-7168-6953f0c812a7@amd.com>
Date: Wed, 10 Nov 2021 10:45:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <4130bde8-8184-4aed-4634-7d58f3e61d2f@gmail.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR0P264CA0145.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::13) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 PR0P264CA0145.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 15:45:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57859a0e-eac1-4686-69f1-08d9a4611a5b
X-MS-TrafficTypeDiagnostic: DM4PR12MB5374:
X-Microsoft-Antispam-PRVS: <DM4PR12MB537473905EECCF46FFCC07DDE6939@DM4PR12MB5374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CPgyebaMd9fkKdsne6xqY2l8BdryWFvq3IIBzQ+KIsfWbViDpBBPDCtI7iXdYfcmmmcSS0Wwoojtrn+V7sSLz2xztqosBFZOXgJZrt8iaaLjdJ1O7pasUGxnJiLuBIC1JdRolIOoYXzUN+aToKhrCoS09GRxO37RiXQNzo375LNpmXas8QoJmbnI2+YAgaTLy2DaQxyrnkqi5VhLuk99UAs4C9zS9ZtxdRgWnLZP23KOv0SL/f08Ge03pjdXmX2j91Ezk6JOs/jvU9j6ReMrg3LPGRrZFTawd4K3zVKGEPurVg7EkdMlw/QDt00KD5krh8EsdOno8GUE/GUPDDW2vpSvAclYgt/sin27k1+eLCWrI7IAM9ecylpy9X2qDSdlvmHc0rMnkHLtM4mLKCpxbJeQOEIW0nCMQSkm/on1KEF/C/TbXIwv9Jfjb4qBQL0hUGFwkDWq+hs4F3WClAWMx8RTbFjLT4wWJJNW9zmg8QOCQ/2jWBbAboEzyFmCI0PJNDl8oFVGqGY/ySX6Tt7h12AiZuCFcAwhhE7yTVIrACrpcEBKum0nbrr5kK/ml0aaeMGxWJXWEFvc2AA61NdTES4w9JvQn+uG4YpIQJwsd68m+3p7mzZI+VEIWu3UNBAsPur5fF/ABl4z+sl9ahQIfeGvVDbCDCIoJUsK052o7xTdnu6fGhyKHyymMgcOmW7rWDtsDAjHshRatr/FsmOE/bOgEAngr2+oJlHhHd6jXww=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(2616005)(66946007)(6666004)(53546011)(4001150100001)(66556008)(956004)(36756003)(186003)(508600001)(110136005)(38100700002)(4326008)(2906002)(5660300002)(6486002)(31696002)(66574015)(83380400001)(8676002)(8936002)(26005)(316002)(16576012)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bS9HWVV3cmhiSnVsQkYrOTg1ZElwdG1MQldTUHFhWEFpSVlXWXd4Q00weFFy?=
 =?utf-8?B?MUhtTGdLbHZ0TnhBT01kZHBNNFNVZFZrZHZvZUhQeU5JY0NadHJxdkJyb0l5?=
 =?utf-8?B?R1hvVXVEckVScHByUXJ2bDQvWTNrZ0F5NGtkNFJQZjg1RmFmejZhZ3FkTEVn?=
 =?utf-8?B?RFhqOWRYWGdWVzFOWHRTN29raTduSFB3L24wZExrRmtMbGxpMk51cTRrWldU?=
 =?utf-8?B?R2NFbUFPZ1VuWTg4clUvYStvS25FVmJReExueG5NUUlaTE96SzV4UDJaSzZJ?=
 =?utf-8?B?Qzd0KzErTDVNN3U5V2RVZlIrY2xWdC81VkcxT0RkR01ZTGI5b005NzN1T3Mz?=
 =?utf-8?B?M3h6ZFVkdHlzZnBTYVhTQnBjVUhxMndyV2ZMMEhVdGpDYWlLQXRVbEM0cWpo?=
 =?utf-8?B?S3hoTUQrd05LRG5mZVZ4Z2F2ZmZZTFlsOUI3TEREWDc1VTlydkpEOWxTcUEz?=
 =?utf-8?B?cTFOdHUwWEtWbGdKcm1BU3JZMitqUXZvVXVUUkJzTHpWSFZnZnZzcVNMdjVq?=
 =?utf-8?B?R0VoaWVXcnNIYkszUTVKWTFYUTlZSHNrd2pHR3hRUnZyR3BRbEh3TEtXM1M2?=
 =?utf-8?B?TWUxbVFqcFNROVJHV3EwS3RqWFJVa05vTXRhZm5keDNpOUJnRGEvcVc0NFNp?=
 =?utf-8?B?UXRrREpFZ2M5RUtmcytwenBxaE5ocy9LbldzcHhWdGNRTVM3UERQUmdjczRv?=
 =?utf-8?B?UkdEUi9tK1FRZERQTjJub2EvYXR4Tndob2VicFVyUkR5a0dJWTFENGhWSmxV?=
 =?utf-8?B?bGFOMXFuWk1pdUgyem04WkV3M2lPc1BKU1VVTXRBNGprZjg4ME5QblRjZFJC?=
 =?utf-8?B?NlVPNGNaSkJOengwamU3a1ROVWI5Zkl3aHNvUVMydXRkeDdVSm1Fc1NtSDFM?=
 =?utf-8?B?S1hWMjkvZEFvY0l1UnY0bGVxcHBQMFlaZzFXSmNUNTJNQmJRVFRWMGJWZGl6?=
 =?utf-8?B?UnErUnMyVS90TzBnYjRoYUx5MEg5b2dWT3daeDFmU3pBblJYMVhQUC9hVVRV?=
 =?utf-8?B?UUdWRGh3TjZjNnB1Zy9YeCs2azZHMEJoc0loV24rbCtLYklkd3luUzdtc0xw?=
 =?utf-8?B?U1o5d0p5ZFp5SzBabzIxUTRhSkFjWE1ROVdSL1IyMlQ2RGFLaitGZFowOE9n?=
 =?utf-8?B?TjNCcDBzb1dxWmFqclVQZXlvc2o1QjRScGszR3B0WGtmRFVDYVp5c2V3ekli?=
 =?utf-8?B?aWZkTmJvUG9Nd0lWaUE4UzJVRHY1SzY1a2ZGWjJveHZjWkNBb1l6Rm1KOFh1?=
 =?utf-8?B?enViT0ViNG1CbUlQY01PQkdEK0d5Vnp1OTZKLzgxWTBFbjhxTlhqcWRwNWhq?=
 =?utf-8?B?ekdLNjFzM1ZoMEQxT0Q2U3hoQzRTNWhYQXBLaFgrV2Z2NVhDVjkvV1pFK0tj?=
 =?utf-8?B?WVRvUlluanEwZ2N1djVKVjR3YmNTZDk3RHE2ZGVOUHQwbUhmMGQ4enJyY1pa?=
 =?utf-8?B?RFRRUXJjeFlUMmRLNE9MWEdyYlZRY0hiNnMrU01QaTA5UEwzZFBnVmVibFRu?=
 =?utf-8?B?ZTlncFhqb3Njc0Z4SURDaDREaFNraTBvZjhiRjZtVUJDUDN6VU94YmtEaXYz?=
 =?utf-8?B?YjFTNzZKaVpMSi9OZlRsclhPMlFTdVJxYTFaZ09WUEtncUZyczJwMWR4V2FE?=
 =?utf-8?B?S2ozcEU5SnFhc3BIK3dnbXJvMEoyTTlhSE8xODRSRnhNamtEdGhMQ08wdUFw?=
 =?utf-8?B?OExMZmdhNDZrN1l1Vml6ZkI4eWJtc0lWK0dqdHVrUlhUejBkcFBGMVlCZkor?=
 =?utf-8?B?clhhbnJYRUVZTUNVcHZXVnZmeTZhbVVRbnBOL09RLy9XeU9jR0w2ZmxnRUZa?=
 =?utf-8?B?R2dyZEdacjVTdzBZLzhSS3NtRDc3K3J5ejN5b051amdaMjVNUDFWQlJZczJt?=
 =?utf-8?B?QzFHUzk0c2N2OThkZ0Nsd0NTZ0psL0ZuV29YWEtyRktxeVVsUlgwcURkMy9Y?=
 =?utf-8?B?M1E1bmpiVGJFdW1yTDdrN1RPMHBHSmE4dDJPbTRZdnI3MmE4bGV5aXBmaE9Q?=
 =?utf-8?B?SlZVak9uZUZUYStTYlpkU1JQVXhrSWhuYWMreVQwUnNKTnk4eCtlYzZLT1M4?=
 =?utf-8?B?VUJlakNMR1hwdjMwYnNSTjlkZCtxZEhTRnhUdWd1MVUwVHh0aWJPYzlWMmFs?=
 =?utf-8?Q?+l1A=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57859a0e-eac1-4686-69f1-08d9a4611a5b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 15:45:21.3395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7fmN/zb97WACPHtSELpsRRhhTTS0bU1WzTywJ/+0kBut+X6aT1N1eRnsczfcEiK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5374
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
    <div class="moz-cite-prefix">On 2021-11-10 9:54 a.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:4130bde8-8184-4aed-4634-7d58f3e61d2f@gmail.com">Am
      10.11.21 um 15:44 schrieb philip yang:
      <br>
      <blockquote type="cite">
        <br>
        On 2021-11-10 9:31 a.m., Christian König wrote:
        <br>
        <br>
        <blockquote type="cite">Am 10.11.21 um 14:59 schrieb philip
          yang:
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
            @@ -234,10 +235,12 @@ int amdgpu_ih_process(struct
            amdgpu_device *adev, struct amdgpu_ih_ring *ih)
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
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Order reading of wptr vs. reading of IH ring data
            */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rmb();
            <br>
            @@ -245,8 +248,12 @@ int amdgpu_ih_process(struct
            amdgpu_device *adev, struct amdgpu_ih_ring *ih)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (ih-&gt;rptr != wptr &amp;&amp; --count) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_dispatch(adev, ih);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih-&gt;rptr &amp;= ih-&gt;ptr_mask;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ih == &amp;adev-&gt;irq.ih1) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;rptr 0x%x, old wptr 0x%x,
            new wptr 0x%x\n&quot;,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih-&gt;rptr, wptr,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_get_wptr(adev,
            ih));
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_set_rptr(adev, ih);
            <br>
            @@ -257,6 +264,8 @@ int amdgpu_ih_process(struct
            amdgpu_device *adev, struct amdgpu_ih_ring *ih)
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
            wptr, ring1 is empty, but the loop continues, to handle
            outdated retry fault.
            <br>
            <br>
          </blockquote>
          <br>
          As far as I can see that is perfectly correct and expected
          behavior.
          <br>
          <br>
          See the ring buffer overflowed and because of that the loop
          continues, but that is correct because an overflow means that
          the ring was filled with new entries.
          <br>
          <br>
          So we are processing new entries here, not stale ones.
          <br>
        </blockquote>
        <br>
        wptr is 0x840, 0x860.....0xd20 is not new entries, it is stale
        retry fault, the loop will continue handle stale fault to 0xd20
        and then exit loop, it is because wptr pass rptr after timing
        48.806122.
        <br>
        <br>
      </blockquote>
      <br>
      Yeah, but 0x840..0xd20 still contain perfectly valid IVs which you
      drop on the ground with your approach. That's not something we can
      do.
      <br>
    </blockquote>
    <p>We drain retry fault in unmap from cpu notifier, drain finish
      condition is ring checkpoint is processed, or ring is empty
      rptr=wptr (to fix another issue, IH ring1 do not setup ring wptr
      overflow flag after wptr exceed rptr).</p>
    <p>After drain retry fault returns, we are not expecting retry fault
      on the range as queue should not access the range, so we free
      range as it is unmapped from cpu. From this point of view,
      0x860..0xd20 are stale retry fault.<br>
    </p>
    <blockquote type="cite" cite="mid:4130bde8-8184-4aed-4634-7d58f3e61d2f@gmail.com">
      <br>
      What can happen is that the ring buffer overflows and we process
      the same IV twice, but that is also perfectly expected behavior
      when an overflow happens.
      <br>
    </blockquote>
    <p>After wptr exceed rptr, because no overflow flag, we just drain
      the fault until rptr=wptr, yes, this drops many retry faults, it
      is ok as real retry fault will come in again.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:4130bde8-8184-4aed-4634-7d58f3e61d2f@gmail.com">
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">Regards.
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
          <blockquote type="cite">[&nbsp;&nbsp; 48.802231] amdgpu_ih_process:243:
            amdgpu: starting rptr 0x520, wptr 0xd20
            <br>
            [&nbsp;&nbsp; 48.802235] amdgpu_ih_process:254: amdgpu: rptr 0x540,
            old wptr 0xd20, new wptr 0xd20
            <br>
            [&nbsp;&nbsp; 48.802256] amdgpu_ih_process:254: amdgpu: rptr 0x560,
            old wptr 0xd20, new wptr 0xd20
            <br>
            [&nbsp;&nbsp; 48.802260] amdgpu_ih_process:254: amdgpu: rptr 0x580,
            old wptr 0xd20, new wptr 0xd20
            <br>
            [&nbsp;&nbsp; 48.802281] amdgpu_ih_process:254: amdgpu: rptr 0x5a0,
            old wptr 0xd20, new wptr 0xd20
            <br>
            [&nbsp;&nbsp; 48.802314] amdgpu_ih_process:254: amdgpu: rptr 0x5c0,
            old wptr 0xd20, new wptr 0xce0
            <br>
            [&nbsp;&nbsp; 48.802335] amdgpu_ih_process:254: amdgpu: rptr 0x5e0,
            old wptr 0xd20, new wptr 0xce0
            <br>
            [&nbsp;&nbsp; 48.802356] amdgpu_ih_process:254: amdgpu: rptr 0x600,
            old wptr 0xd20, new wptr 0xce0
            <br>
            [&nbsp;&nbsp; 48.802376] amdgpu_ih_process:254: amdgpu: rptr 0x620,
            old wptr 0xd20, new wptr 0xce0
            <br>
            [&nbsp;&nbsp; 48.802396] amdgpu_ih_process:254: amdgpu: rptr 0x640,
            old wptr 0xd20, new wptr 0xce0
            <br>
            [&nbsp;&nbsp; 48.802401] amdgpu_ih_process:254: amdgpu: rptr 0x660,
            old wptr 0xd20, new wptr 0xce0
            <br>
            [&nbsp;&nbsp; 48.802421] amdgpu_ih_process:254: amdgpu: rptr 0x680,
            old wptr 0xd20, new wptr 0xce0
            <br>
            [&nbsp;&nbsp; 48.802442] amdgpu_ih_process:254: amdgpu: rptr 0x6a0,
            old wptr 0xd20, new wptr 0xce0
            <br>
            [&nbsp;&nbsp; 48.802463] amdgpu_ih_process:254: amdgpu: rptr 0x6c0,
            old wptr 0xd20, new wptr 0xce0
            <br>
            [&nbsp;&nbsp; 48.802483] amdgpu_ih_process:254: amdgpu: rptr 0x6e0,
            old wptr 0xd20, new wptr 0xce0
            <br>
            [&nbsp;&nbsp; 48.802503] amdgpu_ih_process:254: amdgpu: rptr 0x700,
            old wptr 0xd20, new wptr 0xce0
            <br>
            [&nbsp;&nbsp; 48.802523] amdgpu_ih_process:254: amdgpu: rptr 0x720,
            old wptr 0xd20, new wptr 0xce0
            <br>
            [&nbsp;&nbsp; 48.802544] amdgpu_ih_process:254: amdgpu: rptr 0x740,
            old wptr 0xd20, new wptr 0xce0
            <br>
            [&nbsp;&nbsp; 48.802565] amdgpu_ih_process:254: amdgpu: rptr 0x760,
            old wptr 0xd20, new wptr 0xce0
            <br>
            [&nbsp;&nbsp; 48.802569] amdgpu_ih_process:254: amdgpu: rptr 0x780,
            old wptr 0xd20, new wptr 0xce0
            <br>
            [&nbsp;&nbsp; 48.804392] amdgpu_ih_process:254: amdgpu: rptr 0x7a0,
            old wptr 0xd20, new wptr 0xf00
            <br>
            [&nbsp;&nbsp; 48.806122] amdgpu_ih_process:254: amdgpu: rptr 0x7c0,
            old wptr 0xd20, new wptr 0x840
            <br>
            [&nbsp;&nbsp; 48.806155] amdgpu_ih_process:254: amdgpu: rptr 0x7e0,
            old wptr 0xd20, new wptr 0x840
            <br>
            [&nbsp;&nbsp; 48.806965] amdgpu_ih_process:254: amdgpu: rptr 0x800,
            old wptr 0xd20, new wptr 0x840
            <br>
            [&nbsp;&nbsp; 48.806995] amdgpu_ih_process:254: amdgpu: rptr 0x820,
            old wptr 0xd20, new wptr 0x840
            <br>
            [&nbsp;&nbsp; 48.807028] amdgpu_ih_process:254: amdgpu: rptr 0x840,
            old wptr 0xd20, new wptr 0x840
            <br>
            [&nbsp;&nbsp; 48.807063] amdgpu_ih_process:254: amdgpu: rptr 0x860,
            old wptr 0xd20, new wptr 0x840
            <br>
            [&nbsp;&nbsp; 48.808421] amdgpu_ih_process:254: amdgpu: rptr 0x880,
            old wptr 0xd20, new wptr 0x840
            <br>
            <br>
            Cause this gpu vm fault dump because address is unmapped
            from cpu.
            <br>
            <br>
            [&nbsp;&nbsp; 48.807071] svm_range_restore_pages:2617: amdgpu:
            restoring svms 0x00000000733bf007 fault address 0x7f8a6991f
            <br>
            <br>
            [&nbsp;&nbsp; 48.807170] svm_range_restore_pages:2631: amdgpu: failed
            to find prange svms 0x00000000733bf007 address [0x7f8a6991f]
            <br>
            [&nbsp;&nbsp; 48.807179] svm_range_get_range_boundaries:2348: amdgpu:
            VMA does not exist in address [0x7f8a6991f]
            <br>
            [&nbsp;&nbsp; 48.807185] svm_range_restore_pages:2635: amdgpu: failed
            to create unregistered range svms 0x00000000733bf007 address
            [0x7f8a6991f]
            <br>
            <br>
            [&nbsp;&nbsp; 48.807929] amdgpu 0000:25:00.0: amdgpu: [mmhub0] retry
            page fault (src_id:0 ring:0 vmid:8 pasid:32770, for process
            kfdtest pid 3969 thread kfdtest pid 3969)
            <br>
            [&nbsp;&nbsp; 48.808219] amdgpu 0000:25:00.0: amdgpu:&nbsp;&nbsp; in page
            starting at address 0x00007f8a6991f000 from IH client 0x12
            (VMC)
            <br>
            [&nbsp;&nbsp; 48.808230] amdgpu 0000:25:00.0: amdgpu:
            VM_L2_PROTECTION_FAULT_STATUS:0x00800031
            <br>
            <br>
            <blockquote type="cite">We could of course parameterize that
              so that we check the wptr after each IV on IH1, but please
              not hard coded like this.
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
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
