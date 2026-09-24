Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120BBC98317
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 13:38:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A03F210F585;
	Thu, 24 Sep 2026 13:38:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hPAPcwZR";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7559110F585
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 13:38:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yeu3VzG7PrFRcvZKfrSD0vx0qYpYiX5mQqt98PQfVRylparNy/Wc/8UQwVDHjlvVq53RrKqw/gfNWqcC7KIC1DQWlLUZJbSKZqnRYCNUBBcZweLktAPgSKNmRL/kOOFL9DNB1a7Y5EX4V8H20IdvPJX8T5NugLAHrg9v5iXqevY1Gdj9yaHYHuFq4jO/nWCKEWizOOhiTS+MmPYzwyk4JycfvmDoFCkqUrAhZY2o7Zi6lFrVMImXAw/4ovoqxF/kzJH5hOS93igC5SB3qWEv5WTbLixZtdLv7NHrDi4Mti+1veTtp0KAM+KETwJuPWhH7+tYV+pbfwhXh1rjopb+iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYe3vBhB+PvovzrzMJOTKZexTmldUN53KdkT3R9NHC8=;
 b=HWPosQRteDxyx4EemgTIKaeg1NmM+CzIrRa196pfrG/dSekSFyv5qGtnCVOWG+IvF+ZTwyuj/aoVs4ZwE+KXijxYJNUTlD0a2V2vLNtnfPpia1Ovm5lZvjBTp16uZAv8tcsKZcdn/SeS5w8VjXmj+o1Lew8/AYki6CpluzywR2y8G00OQ1fgx5VBT1PZODyR8dEMlyfLZdFuZVri6L8Iq2YZyXbA/RXuvHa8DgTfKvxiXez2cA5Zjdxrs1Xj8hHWLupAo7DVRVI/iIO+6HcRq/eL5ig8eoXrRnswKGREawNa/te8UV2+lxv7LTVomZYBYwCa251UoYz/+tZzsesx8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYe3vBhB+PvovzrzMJOTKZexTmldUN53KdkT3R9NHC8=;
 b=hPAPcwZRVROZc1VFy78Yo2Y9t/K7eWTZhdCWEXcbJ4kEKKU8O08G4+B18uKlY7KNaEJkNM5hQUbRNee/JcVTAunYsvQBp6A4MRNYhQvZTWbgK09vjQ5TckYqnbKTNAb0BJC0dHLVtl/uRLCgrWyQ52hTpZuvmf90LNC32rLr7yk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15) by DS4PR12MB9745.namprd12.prod.outlook.com
 (2603:10b6:8:2a9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Thu, 24 Sep
 2026 13:38:38 +0000
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4]) by PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 13:38:38 +0000
Content-Type: multipart/alternative;
 boundary="------------CHX3gfhOm700dU6DMTn0K6uY"
Message-ID: <8cc1d354-7ce9-4591-8933-9d7eafb4ae81@amd.com>
Date: Thu, 24 Sep 2026 09:38:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: place VRAM-capable dma-buf imports in the
 PREEMPT domain
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20260923212838.1421843-1-mukul.joshi@amd.com>
 <b4254043-2c62-4fa4-927f-ba84aa816560@amd.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <b4254043-2c62-4fa4-927f-ba84aa816560@amd.com>
X-ClientProxiedBy: YT4P288CA0013.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::18) To PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PHXPR12MB999256:EE_|DS4PR12MB9745:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a93534-97ac-4a29-4b58-08df1a4123c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|4143699003|11063799006|56012099006|8096899003|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: 45CgzvPfIAVmpV//KI/WFm/MSUGKizNHG7vcCJQiJM9Tc+52jXhul0abi7aLQ1nYTGNKOOjDD8QN4vrO8Hk43WOHZNQaV7RtV2afDdsnzuYA2hoUwFQcI/26yhD50xARY4E1uCBXxKmQBSk4J8ckXTazUexbsLw+snUyNSX7iKJfA5S8DNHuDyRZAts/404b5YGZmjMCK7lAtFPm/8B1boR851QWQlId7sxbf3BZZ0YlLJWO6rWHR3FMP0fjUKaXAh9R5WCqymxR+PUyOBZ0AKNd+EK46t6kfPekrUq3YrGUvQwc3JHeqizqIBukmo356vjYxc4JQdbljpBboB4GKmbfOyYK228KnLSCOxPDPlY5i1y8ByzHAT96mgZTXPNc9zj1cMvr2LV4aEXHW9YAapeGgduz1wyz4Xo3dZ9eMJIEDDj5J0DFtAYPuDQYj3WokdqtoDU7VbjQCWZRrW8/11TDZF4ZpKJzSiI6mfcQQfU8WQOE/B3ohR04FhoW/lZhGCW1iAba6ITvK5lmGUT/R8pjIFOPWYI0HqpErhU8gDt0f5vOobvqG81GLRxMYD5KOZ7dHJj1UeNIff1lSBD567iLHzvYYale0oUR/Z8I2pcxlKhq+j3SJjJWiSNVGQ4hXfIMHFFCBQOSm6YL+GTXovzxMSO2JG/cmVPFrPdMqCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(8096899003)(5023799004)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1hzU2Mvbm5pYkxMZ0ZhY2pKSWF5MEVJalhkVjJablE1Sm83ajByLzdQWi9T?=
 =?utf-8?B?NmR2aHNaWXhpb0lXaDFGMmFBWHlLNFZFRTRLV0VMSjlrZGtGOUJtd2tUOEQr?=
 =?utf-8?B?WW96a2dxT0ZFTll1Z2F1Vk95dEZqM25ieEVJaEtVVGd0OXV6RkVsTFpDdFlk?=
 =?utf-8?B?QzhOVTBkQzB1Szl5eFp6WnRqa1haN0NwRGRUNGFpeDNRL0YxOHRkSzZ6cDdn?=
 =?utf-8?B?UnVqUEpLTTBONHErbXptOTNVL0p4UDNyS1dSSlNGc1dYejY5UlhFa0lUWFJG?=
 =?utf-8?B?ZUo4UFQyOVRMVWxrOFZGWmdlcGFud3V0ajhmTHlHaXZ0QmNSelFsTkk4eDZk?=
 =?utf-8?B?SER0d1J0ek8zLzBmYTNUOVRRbmJDQXBzcVM3SXprWnR4eWorNHRUZWQ2VnYy?=
 =?utf-8?B?Vm9Wb0puTm1Vd0hab3R5V0F1amFoOFd2enduQjJYU2dzUncvUGdqWnlSelNz?=
 =?utf-8?B?VjlpV3hlbzdOcXdNc2hJc2JwOWN1bkVDTThVRkw0T2duRFdlZ01KeHNvWDI3?=
 =?utf-8?B?dzZrT3JlQUlQbjBuSWZJaWtzeExqL3ZmWTd1Y0I4a0ZQVEtZU21DcTdMMHlT?=
 =?utf-8?B?NCsySUxFa2JLSTJQaEVaanhYa21DOG5NL2VaT0luSUswODBkelJIZzlxanlQ?=
 =?utf-8?B?alJESEpOaHMrUkoyV1JSVEtrUXkzcU4wMEFyWVU2aVNQRHpwRTVhTklYTUJr?=
 =?utf-8?B?U1lXUml4T0tacUJROTVXbTdkczFmU241clN5NDluSzVqVjNjQ010QnovYzhy?=
 =?utf-8?B?MWxNOUJ4Q2ZjR1hOOVVTSEc0VDF6aVVOTitQQ2FhZ2Y1OFkzRWtWblV6dFpy?=
 =?utf-8?B?SjFmUTFJUXlGNktpQXp3M2JIYWpnZlJIY0hTNWdJeE52ODh6RERwdDhvRGRr?=
 =?utf-8?B?dVdmeFNFMVNVVlFoc21ubnlRYUt4V2c0QXY1d3JUeHZKeVJoOWZJQklDSG0r?=
 =?utf-8?B?SDFXZCsrN3Q2SWg0WTVEbWNBWUhaYTRKZ2tDcHoxWjRZUVAyQUMzMnVBVXZv?=
 =?utf-8?B?Y1V3SGNJem9zVTQ1KytVZzlkbCtZb0FKYUp3WmVrckkzS3FYM3hoc1g3cEtE?=
 =?utf-8?B?NlAwSThoQ0VUdXBDTEZPZFNlYnRKdWdBd0FrcU85YWtkNHRQTG5mQlJ4elVC?=
 =?utf-8?B?Si8vK3hidEE0Y0FGRXNDeTRtZmtmYUxDTkJ2d2dHQkVPYmErMEJiZkFCS1hF?=
 =?utf-8?B?b2tQOUtsYnFLZnVyRlMwdGdMc25ZQ2haK210dDhUY240azNSRnFRUSt4U3VR?=
 =?utf-8?B?MHN0VTAzZlV1Q1BFQWlJZGU3bTBNK1NvVGRPc1JMcFBkYnJzeHhhNVNRL1l4?=
 =?utf-8?B?bWNtZkNoTGhpRVJqOW56SWZPYmpyRkd5ZUVSQmdoeWdTc3QxQWNMZ2pVclFk?=
 =?utf-8?B?VjE3YU1lWHhBSXlSSWpRTUYwQVR0dWVydXRiNXFvUEI0eStPT1Bxa0FIWjc4?=
 =?utf-8?B?dHFISktZUDhhcWY5b2lSbGdKL0hyOTVoSEVrMlpyT1VnOWxSZVkzL1pMN1kw?=
 =?utf-8?B?bTZJNDY5VFhBazRCbDJnWEhQNUVNQWFDdk1NWngvcWpGMStnQXkxRnRkOTBJ?=
 =?utf-8?B?VS81OXQ5R3c3dytVQXhScjdSQUp4b1RRVDByRGhWZUU5WnM4Rzl1QnZvaHd2?=
 =?utf-8?B?VTBMNnZNU0tCTk82VktCNFJISnNWN3JKZ0ZDNmRQVjQvSmtXLzRVZWFDL0V2?=
 =?utf-8?B?NGhNMHJyWE9KaUVqTUxIdVdqdnNFREZzd3NMUXFtME5IOFFNL0t4VjdIYkNY?=
 =?utf-8?B?ZEY1YUlFcE9uYU9RK29tSC9kZlNLS0VpR2E5cXRsc0VvNHArU2hOV1N1ajJR?=
 =?utf-8?B?cG1vYW1MOWU2RnhZRXRGM0Q0Y3FxaUphcCtTT3BXMUgwdWx2QlVzZ0lDTFps?=
 =?utf-8?B?NW5iTXNYMXJJT3AxeFRMUUxwcklDa3FLbFpHVytDTDRndUJISzNlcnBPYWFM?=
 =?utf-8?B?eFJITExFZmcvSEJUbkczNVpZbE5Ta3liVmx2aGFoRktjT2habUFQemZHSExw?=
 =?utf-8?B?cS9jRnM0RmY1WEpXbnV5aE92cFNMRXdJdlZyUkl2bHNCKzdSZjcwN0VrQk40?=
 =?utf-8?B?TEVVMnJ2KzRRVS84OGdaVlZDNXZBWkhZNTRpcVZLSWNwL09zbUNXYmMxckdM?=
 =?utf-8?B?RFlXYVJvY2g2WVpJTjBXdVo5R01UaHBibExuVGFwTGhxTU1zcUZFdGozcVlP?=
 =?utf-8?B?Wnd4M1AxYTM3SWlXdXNmbWRSN0o3ZmZLcTZCUXJMR0xOSlRsRzlpYk8vV1Zi?=
 =?utf-8?B?M0lZaXNqcmRoWlFYbEg3OHhEYUIzamlwcmF0eTdDVFpQRm80VkFxK0VJN3JT?=
 =?utf-8?B?eVhBQTVkUzhZYUMvblZucXh4UDg5MFYwVlh4RnUwYU9TaGJhSnhKdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a93534-97ac-4a29-4b58-08df1a4123c6
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 13:38:38.6789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3uzS9C3LXQY5pem/TxuAAavqu/SVRZBB8e9AOqelIbyuGUX45JsHMeG8eMsD2DRlSNYDSAqCI2lgEAaCHvwqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9745
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

--------------CHX3gfhOm700dU6DMTn0K6uY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/24/2026 3:41 AM, Christian König wrote:
>
> On 9/23/26 23:28, Mukul Joshi wrote:
>> An imported dma-buf BO backed by a VRAM-capable exporter holds no host
>> pages of its own, yet when validated into TTM_PL_TT it is charged against
>> the GTT page budget; importing many such buffers can exhaust that budget
>> and fail with -ENOMEM even though no host memory is used. Set
>> AMDGPU_GEM_CREATE_PREEMPTIBLE on these imports so they land in the PREEMPT
>> domain instead, which is GTT-like and still bound (keeping the exporter
>> resident) but carries no host-page limit.
>>
>> Signed-off-by: Mukul Joshi<mukul.joshi@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> index 4031ebe075d8..5bac2474af03 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> @@ -472,6 +472,15 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
>>   					 AMDGPU_GEM_CREATE_COHERENT |
>>   					 AMDGPU_GEM_CREATE_EXT_COHERENT |
>>   					 AMDGPU_GEM_CREATE_UNCACHED);
>> +
>> +		/*
>> +		 * A VRAM-capable import is backed by the exporter's device
>> +		 * memory, not host pages of its own. Place it in the PREEMPT
>> +		 * domain (GTT-like, but with no host-page budget) so many such
>> +		 * imports cannot exhaust the GTT limit.
>> +		 */
>> +		if (other->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM)
>> +			flags |= AMDGPU_GEM_CREATE_PREEMPTIBLE;
> You also need to check if the attachment results in P2P access, otherwise the DMA-buf will be moved to system memory.
>
> Take a look at the amdgpu_gem_prime_import(), since the BO is not published yet just unconditionally clearing the AMDGPU_GEM_CREATE_PREEMPTIBLE flag there again should do the trick.
>
> Apart from that looks good to me,

Thanks Christian for the review. I incorporated the change and sent out 
a v2 just now.

Regards,

Mukul

> Christian.
>
>>   	}
>>   
>>   	ret = amdgpu_gem_object_create(adev, dma_buf->size, PAGE_SIZE,
--------------CHX3gfhOm700dU6DMTn0K6uY
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 9/24/2026 3:41 AM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:b4254043-2c62-4fa4-927f-ba84aa816560@amd.com">
      <pre wrap="" class="moz-quote-pre">

On 9/23/26 23:28, Mukul Joshi wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">An imported dma-buf BO backed by a VRAM-capable exporter holds no host
pages of its own, yet when validated into TTM_PL_TT it is charged against
the GTT page budget; importing many such buffers can exhaust that budget
and fail with -ENOMEM even though no host memory is used. Set
AMDGPU_GEM_CREATE_PREEMPTIBLE on these imports so they land in the PREEMPT
domain instead, which is GTT-like and still bound (keeping the exporter
resident) but carries no host-page limit.

Signed-off-by: Mukul Joshi <a class="moz-txt-link-rfc2396E" href="mailto:mukul.joshi@amd.com">&lt;mukul.joshi@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 4031ebe075d8..5bac2474af03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -472,6 +472,15 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
 					 AMDGPU_GEM_CREATE_COHERENT |
 					 AMDGPU_GEM_CREATE_EXT_COHERENT |
 					 AMDGPU_GEM_CREATE_UNCACHED);
+
+		/*
+		 * A VRAM-capable import is backed by the exporter's device
+		 * memory, not host pages of its own. Place it in the PREEMPT
+		 * domain (GTT-like, but with no host-page budget) so many such
+		 * imports cannot exhaust the GTT limit.
+		 */
+		if (other-&gt;preferred_domains &amp; AMDGPU_GEM_DOMAIN_VRAM)
+			flags |= AMDGPU_GEM_CREATE_PREEMPTIBLE;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
You also need to check if the attachment results in P2P access, otherwise the DMA-buf will be moved to system memory.

Take a look at the amdgpu_gem_prime_import(), since the BO is not published yet just unconditionally clearing the AMDGPU_GEM_CREATE_PREEMPTIBLE flag there again should do the trick.

Apart from that looks good to me,</pre>
    </blockquote>
    <p>Thanks Christian for the review. I incorporated the change and
      sent out a v2 just now.</p>
    <p>Regards,</p>
    <p>Mukul</p>
    <blockquote type="cite" cite="mid:b4254043-2c62-4fa4-927f-ba84aa816560@amd.com">
      <pre wrap="" class="moz-quote-pre">
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 	}
 
 	ret = amdgpu_gem_object_create(adev, dma_buf-&gt;size, PAGE_SIZE,
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------CHX3gfhOm700dU6DMTn0K6uY--
