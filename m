Return-Path: <SRS0=WxFm=O3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B59C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 21:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68EB161212
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 21:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 68EB161212
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDC7E6F4E3;
	Thu,  7 Oct 2021 21:38:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7894E6F4E3
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Oct 2021 21:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0DR2ByiRiMjVxFXIUNt7tOOmConEwbTMhs8abB1zVIfLTFaasKoDNbSQlJcQH0Qe9xulFUqKNYVFlmNoGRcD0SyZ8Ei8h5vWLpRKriy3Xg13E/Qa9pMlcJ2KxdQtjojB1prkBsESkT1oB0b/GW8egGvBiDAW5m3BrMo79g46ykL+N/7nVAyxXbBKeozc2oxUM7N446nBWAno4e+hL0Xkv5+H5EFQjX3JReEpRKhc77MlIvzRLKYFpkBbvlVLLGrIh7lTrLzz6QyINn71YGMdvWN/gEs0cWFjL0BEGh12o5qAw4v8HF/KakF2FZuoaPHLTTW0NAPWgR2G+CH9Z9DWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6z0ru5WVU2SG2uxhUPuNOWwj537zyrKYmVeuowsa5IA=;
 b=iO8wQ9z2xCw9P4E3ZtWAQUUjn45YkjjhCpX+qcf6+pe4aCyIqew178S4tw5fvVvny8tcPItnNd0/eDswNVSpP/oS2uO0eZ4jz5ISfEPtQUGIAGreT8Lj/9pFbbpYYYgQ3yt1T+x3cdM9tnelhNRlhLtSvikYHJl0/1EuJg6af/NieiSuiapAsZ3fnxoswPOSY8mjV3yPXl1ZghmvDq0Pp6f3ADCUj0UoHlNLxLZlMdu/7py0qE1j0uinLES8VLso4Yy0mgoqDUYubY0bJy0K6iWQcsjhflvJviBONeDHjjwfKqi1n96ZqHTygah3jPWxX2tdD7Nuqu0SsYa1ejQzLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6z0ru5WVU2SG2uxhUPuNOWwj537zyrKYmVeuowsa5IA=;
 b=bb1DbvpKbf5GQaXD37NgR1piqPcbdU7HQhFYEEg3IRgR1mVmdC9wdmVGmH/rKYh2+YlM9M1LVlk7sqYL6SiI9N23HKZ5c8KjvSXCU/W7eFJa/xcWVvxocdGZh68dKGrz9dwH2G5V7Y3+NgGzVVUqIgf2JPQDioY1RYUF9KEylJg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM6PR12MB5518.namprd12.prod.outlook.com (2603:10b6:5:1b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 21:38:16 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5425:6607:8b21:1bab]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5425:6607:8b21:1bab%7]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 21:38:16 +0000
Subject: Re: [PATCH] drm/amdkfd: rm BO resv on validation to avoid deadlock
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211007182335.17152-1-alex.sierra@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <cfe2d514-d070-fbb8-4fb3-a0e84a2d9f9d@amd.com>
Date: Thu, 7 Oct 2021 17:38:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211007182335.17152-1-alex.sierra@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YTXPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::21) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 YTXPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Thu, 7 Oct 2021 21:38:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3b6afd3-7d44-4354-0267-08d989dac595
X-MS-TrafficTypeDiagnostic: DM6PR12MB5518:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB5518DFB0B9F9C7A2C1B5509EE6B19@DM6PR12MB5518.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IpLGOLW20n+Pc/ZWYa+HWxNwNsMNRxco+ZTQspQ0udJEnsFK6fNBM2xrVSan+Hd9yRQURg2zwQ7NaxFMlpa5eylHfix8/13ZRO8ERumuVjCDiyE2vIpvFHHKRICj63P44XVyWpAPApO9kD7nR74jFRi9lUPo8X0aOfXuvj4bJNJbOzf5YIupUrRNno7rsNGcCRZrej7k8yyJvC6kuvyYbWNYkpjWaXus7KADlRy6ipqxsFv1o3nWi1sjRefwk/um2wtR4sOCBYHTudXy1xBCdnYITS0+3Dd7VNiF2KdHfUiA1UGPQmiZrCQS4bycUlmKId9O0rQl4igi/JYS/VHljyBvEg4I1NlbzYQ0498Hm2bvQ7YeJM0TvBlT89k8H1EnmqBAI0YVfzt5+EiWxR3MoPl1+FZA+t6OtJJYzXsj7ZMiJMQA4FCl79Ub8tp02IKFZ0ydukxrz/cci6XncfMEXx36wjAbeAvIopnkDuVqoM9SaiVKiuPKPotNAwlA84Nfk8Yc2UuFyvHquHY5dbGN2LAyIWnO/KPkwd/gmkzBgel5Pcqs001ampJdHWXCo41IrnqGPraRG9GJIYv/SvRpEHXTrA0/5eWIfRkxckjFnlHw0kb9oeGisCig7iRWALwl26zeHCrAeikZYUOiXjD4g/QxbwTv9VSNaiO5bgrwE+PSwUgO5veoYHFYeeyhqOYoG9cC9UgQ8iR0oUBKgqp3qd+z9KkTHcA1jAzct+DHO0DDhpMHoxr8lLXe6YP/keDK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(5660300002)(31696002)(956004)(2616005)(8936002)(316002)(16576012)(31686004)(53546011)(508600001)(2906002)(26005)(6486002)(66556008)(66476007)(36756003)(38100700002)(8676002)(83380400001)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekE1bWtZd2ZOdWtPZ2tDa2V1VTQrN0I5WGNRbEU2WEQ2TUloY3R4ai9uemla?=
 =?utf-8?B?b0U0SkdlTGFKMFUzZmtrVmNmTmRCbnFIQ25ld2hHZXM3amFtNFQzcERTSFNh?=
 =?utf-8?B?OExTZEtVL09oZXJ5RWFBbGh0d3NScFU5STR4QkZ3UXQ4Q0xhYmNJRWRXQ1N3?=
 =?utf-8?B?Z3JWdk9UQ0ZiWXQ1bk0rTjMyYVBvNksyN1I2S3pqZ05UbEJyN3FoYVUvbHda?=
 =?utf-8?B?ZjlCejh0aWVqa2h4Z2FMTCtzNmNLMGpmeHNlN0lkdjd6cG1mVHB3Sk9GaVVM?=
 =?utf-8?B?NFJ1TnhTVmNBWStYVWZXTW8zUnFXYW5XL2QyUGxsWGo1Qi9ETWlJYk9ONmUw?=
 =?utf-8?B?dDRyV2VtcjdaR3JRTkEwTjlNT2tweCtMTXprVWFpbzJrZVFiTlRZd0ZkeXNM?=
 =?utf-8?B?RkpoOGhaNkd2ZEQvbjZZY0RlN2lNY3BVUkxGcndtekR2TG9XVk1NbkUwWG8v?=
 =?utf-8?B?U3A2eDRyMkNMdHpBZURCNE5qQldFa0FBNnlHdDVWUVBPTVBLdHdOSVRxV2Vj?=
 =?utf-8?B?RjQwQjNCb2E5M2ZyWkxiSzg4ajhPSloycW1iS3dhbDBRalpNVzc3a1pSc2I3?=
 =?utf-8?B?clkxOElCY1NuazRlYmJlaGQvS2dBZ0lUaEpSdVhRS3I4NFpuL1JRbFBDRUg2?=
 =?utf-8?B?SStUdjhiU0hGdldjblhrbHJyNmliQ0xiZTUzeDRyajh5YncyUnlpME9YTllx?=
 =?utf-8?B?b0ZZWWYxWFlrOElqcTlKUWtRVkdNUkRFTDdjaWFtZExObEhNeGh3c3I0Zk1y?=
 =?utf-8?B?NmpCck1PdXVPUEZvTE9tVnVhWUZsNllKLzBNam96RWRBNjZtdUdFNG9zL2ZL?=
 =?utf-8?B?aEFLbW92cE5BdWVRZTFXRlZGUEprV0hZTUdDQWJZbGwrWm1BenRWdXFYemdB?=
 =?utf-8?B?VHRpZFdXL1JKbW13bmk1ZUJsOERUNjJTV1VoN2dCWVRYUkpheVhoTm1ValAz?=
 =?utf-8?B?Zloza3ZLOG9yN1dEYU40aHQ4Uld0S0JsOE1xc3Nlc3FvL0FrQWMvWDFkNk9r?=
 =?utf-8?B?V1YrNlg2WXliK2lCRUcrNVc2RG5zQ1NxVG0vTURBdzR1WVdTSXRtZXlkRTBP?=
 =?utf-8?B?c0s2aW9HZXRWR2EwcGFtVGx4ZWk3aFQzM3EwZENORHpTQ2dza08yS3I3UUdH?=
 =?utf-8?B?T0ZpKzBIeFJnRFEwYjZRUHhrSjFJSjdiZTJJS1gwWTF0MTdqSmFvYVpNQ3V5?=
 =?utf-8?B?c0dmTVdGWS9PY0hiU3B5TkdQNEJFYzBWTCtVaUx5NEk2amZ5K2pWb2diT0xo?=
 =?utf-8?B?RVduY2NicTNrNm5BNmhMMDZpYTJMa05vejJqVXdrTkNnZXljUjhuUzBFQ000?=
 =?utf-8?B?WlZBZlh6Qi92NWRvYkJodWdWN3F1SFJGRk1XMmxMUFlJZnNtSTdsbTdmWmox?=
 =?utf-8?B?NzFEeGpSSG0xVUErNW41RlA1VG5VRHhQNC9XK0M1ZS9qdUU0OXNwMGtlVEd3?=
 =?utf-8?B?bFAvTjlFYkdteVBtNDNvOUduMjFpTklncUFyMnZRcGw4R2k3Y0J5Z2RNM1Jj?=
 =?utf-8?B?aEZPU0tUVWJSRTl0SWsxTVBFNk9DVjNaREIrTUdFSkVFZWZlVWRVQnZtZytZ?=
 =?utf-8?B?cVp3cnhENERCdUpjMERjTmNGVXZwSlZRME5sOWhiYnhQa2VGU0RubS9HcnJD?=
 =?utf-8?B?WUVqTmpyLzJ6U3h3WUFRZGtseVhpNWF3Z21YeDNnYzRPakk1ZHdjeTNEcEdU?=
 =?utf-8?B?ZmZCUlkrOUhTWUF0U3VqSFBoNGU4R2tadi93UnZycTBreVIvaXIrMTlPSlNx?=
 =?utf-8?Q?W//6CF75DCHAbKG+jD/o1/aMIPfiaoGtT7KkSl3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b6afd3-7d44-4354-0267-08d989dac595
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 21:38:16.2350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2C/7geL6gZyW01vEGtUYw/FB5KwdeDt4FuEzM3/MBU/NQRLDHxqhLXvjx/qWOXNH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5518
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
    <div class="moz-cite-prefix">On 2021-10-07 2:23 p.m., Alex Sierra
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20211007182335.17152-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">This fix the deadlock with the BO reservations during SVM_BO evictions
while allocations in VRAM are concurrently performed. More specific,
while the ttm waits for the fence to be signaled (ttm_bo_wait), it
already has the BO reserved. In parallel, the restore worker might be
running, prefetching memory to VRAM. This also requires to reserve the
BO, but blocks the mmap semaphore first. The deadlock happens when the
SVM_BO eviction worker kicks in and waits for the mmap semaphore held
in restore worker. Preventing signal the fence back, causing the
deadlock until the ttm times out.
</pre>
    </blockquote>
    <p>Please add this to comment, <br>
    </p>
    <p>svm_range_restore_work hold prange-&gt;migrate_mutex, to prevent
      range is migrated while updating GPU page table<br>
    </p>
    <blockquote type="cite" cite="mid:20211007182335.17152-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">
We don't need to hold the BO reservation anymore during validation
and mapping. Now the physical addresses are taken from hmm_range_fault.

Signed-off-by: Alex Sierra <a class="moz-txt-link-rfc2396E" href="mailto:alex.sierra@amd.com">&lt;alex.sierra@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c4de7ce2f21c..6de3fb5266bf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1326,11 +1326,6 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx)
 		ctx-&gt;tv[gpuidx].num_shared = 4;
 		list_add(&amp;ctx-&gt;tv[gpuidx].head, &amp;ctx-&gt;validate_list);
 	}
-	if (ctx-&gt;prange-&gt;svm_bo &amp;&amp; ctx-&gt;prange-&gt;ttm_res) {
-		ctx-&gt;tv[MAX_GPU_INSTANCE].bo = &amp;ctx-&gt;prange-&gt;svm_bo-&gt;bo-&gt;tbo;
-		ctx-&gt;tv[MAX_GPU_INSTANCE].num_shared = 1;
-		list_add(&amp;ctx-&gt;tv[MAX_GPU_INSTANCE].head, &amp;ctx-&gt;validate_list);
-	}</pre>
    </blockquote>
    with this is removed, this data structure can change from<br>
    &nbsp; struct ttm_validate_buffer tv[MAX_GPU_INSTANCE+1];<br>
    <p>to</p>
    <p>&nbsp;struct ttm_validate_buffer tv[MAX_GPU_INSTANCE];</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:20211007182335.17152-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">
 
 	r = ttm_eu_reserve_buffers(&amp;ctx-&gt;ticket, &amp;ctx-&gt;validate_list,
 				   ctx-&gt;intr, NULL);
</pre>
    </blockquote>
  </body>
</html>
