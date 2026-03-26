Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C70010A3D81
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 12:30:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E94110E38D;
	Thu, 26 Mar 2026 12:30:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3WpwvIMH";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E32C10E38D
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 12:30:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HD0Zn3bBEZskfpTocpHf07qn8ZzPioo/h82bnnBFbL8sdEVWOrjLgax4An5GuWQPTEeiyivYqMRvFUQKYNsw+bY3a/JLNVT56bvc5VwcdwzsxolcyaP5AUB5OWoqK05iST/oV3ev4WA+o1zhIC12geP3MxYoqUaY+1HM6i8nSK0jDaxmTx3sAehYDouqXSUrFnePH1eijX34TvYEUByMb+aSWhf7NTZ/bwtBqvnGvfvGDRLAruSr2nOPzAfAod/gHmzCdSzcclCOyBB1KzX6Lg37bAnxdVvVz5cj/TozHqjcpFkbUC2QNTGsjs/7YT7Mnv3MlewhedKXn+C5s8+RYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvtrL2Fg/3sHUMhdzveeAxf8+TQ/uK2+V+68zH5iATw=;
 b=Ni3ZJhH7RAmXLinmvIiLPeFqytMEtPM75kw1akaPE+o0eFba8FyC0Lk1MNHATsjdJwDXVUe6ZwRmE+JxXs35GurXpSYVcHkZ7B7lByrcwE5ycQ8T11uJpUVhk3xvEbTMdaACVVAns5i7unx7sgya57lxEJxOMM4+/iK1L/dV5wuUTYPwSYzFCRHdcabzYZ52aEjw6fbyAgC/hn7iZAOHXNu1fx56VUpwy9cTTGDI55LMzMCcaY3xLBIg8c8RSB2g8EMip6ZkQQ47V9S9QhsOKaFseH3JspoOMNtJAO+Lhof64S6X5D2iYgVIxgobydJH6fkBJcadxL9gAWNiRbIntg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvtrL2Fg/3sHUMhdzveeAxf8+TQ/uK2+V+68zH5iATw=;
 b=3WpwvIMHZj4rG3JjY2JGIAsmyh4/c3WHp4xvTsTnftt7GuMBnyPIGHyWYRw082SAwQthNAoCVQEAt6EuvbGYYK+5Ci64VFXz58DWZVVYs4HtOPSQZSzf4XNtO0slJCENKiuGq8dl7QE7qtxRbpPbtT6oP5+UuT7dAOmST7yRBZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SJ1PR12MB6219.namprd12.prod.outlook.com (2603:10b6:a03:456::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 12:30:30 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9769.006; Thu, 26 Mar 2026
 12:30:30 +0000
Content-Type: multipart/alternative;
 boundary="------------eMRwcasOf2Glq3U2507qGIR0"
Message-ID: <26bef1cf-e636-46f8-b27a-e2840d0bd04d@amd.com>
Date: Thu, 26 Mar 2026 18:00:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v1 2/4] drm/amdgpu/userq: no need to use local variable
 here for return
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260326085601.2665215-1-sunil.khatri@amd.com>
 <20260326085601.2665215-3-sunil.khatri@amd.com>
 <23d8f2a6-b705-4380-8897-93d0612f1237@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <23d8f2a6-b705-4380-8897-93d0612f1237@amd.com>
X-ClientProxiedBy: MA5P287CA0077.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::11) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SJ1PR12MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b1e4a9e-edbf-4d3a-0db6-08de8b3377d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: 31VixMHTyW3PJI9HSY8KHlwqwTwjClaga1uvuU9IiOnntZohreCDPwkk+IJ6KSRNC6toeSNgi63A5Ig5GMzp7Ft83gfx7m9IoXCekoDG9YMgs7iknFdHWRKF+L8xqcnQq08hxLKMbpzJ9TNuRNholnFzSL7j6YbW0f3UjFtLC61prNDfKQHwNNjcDQsvbR9WcDomASdvvLf614EFmCIlvgdT3N6NQksClgHmYNrGuX6VSpTxO/Dt3xXKdhSCFzurveoa59Zjmb1F5vjNRLCJZvnO1ht+um4ZRXO1k5rhP35HjRCnAfifHIFzUsT61pzS74XjjQDZI+3PQGTS8CnSmkjYqFfQQrAxVp2GVvrhNdkmklJna9Q22O+e2HEzeDSUnM40BDKNGhmoEmC0WUE/VtJigaI+qRhnV5Nt+YP/6Bn3uEVoJfFBpeFHLRMh2C605rr+WigIBrGZF30MSe02BQZJO5Wh1x3TV2i9qVmJqKObmsMGRHVcxtKsKZ4y6FkrD9fm7bFyMksApUd/N+QvDbt92bmYHWxMfZ+1s0BGLkCV9dCPb0r2RyLOUzaIJVOLqcOwG9xhOyMWIMnD3e3IGsp3Xfwe9REXcU0pA4OlLB7ZQTOl4GSKcQ2y2ZBavUGtJB3xoZ7/5okhGb3gHajEc0Tnc7S9iZRmDBnC16+WN85/JVz5O5Kg7h1Xzx1Sbo6vg7jV31dbKzc5QQ/VGOKi76GZ0r3vzJ3L/vVxuvnlpZo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUk3S3IxbGxtdDd2djRmRnhMQk9xTWZXcHRQalR2d2FJR0dNSVlST0t4ZkNJ?=
 =?utf-8?B?VGFZQ1ZVdVBmK01VclhpZS9tekkyVEpveVB0S2V1TXAwaFpzTE1TVmdsaXhh?=
 =?utf-8?B?elZUeEloT3VUaHhJcjZPa2R2YjNGalhLejcrUUFtdDh5dUJHRDlLTkwydzVG?=
 =?utf-8?B?REdUMlBVN1YyaktycE9SQkUySGtjSE1TclNaQ1QxdFUwL09JUnZlOWRxNnhU?=
 =?utf-8?B?T1JyOWkzc1VTQjNWaGMxZnVXcklpTHRkYktXNFY0OXdFM0FZK2pDdVMwRnJN?=
 =?utf-8?B?ZVZUcHRnaDJuUjNrUzZnWHR2UE0wMnhJYmlibU03M1hFa3Q3emo2MEpDLy9O?=
 =?utf-8?B?Qzlhd3QxcFM0SzlscWhXamZEVDlISFl5M2w0d3dOQ2hiOUpONFNlKzV6VTZW?=
 =?utf-8?B?Uk5SWnpwTjY4MFdqR3NRS09vL29nS1hVWitjNkxGMTk0alJjQVRXZUdzN3pJ?=
 =?utf-8?B?Mmw5K2tUQlE2SVRDK3ZsUk9MMnFKeHlQelZVb1FtMlBZZjE1VkszMndLT3VN?=
 =?utf-8?B?S0xJQ0dZZUFBUVBwV2JxYzhUMVl2QUkwdXpOZ001UVQxRnBldjY1OTJlZjhp?=
 =?utf-8?B?Njd3bmlLV2FZTU9wU2d3RU5lREVPUVU0amxiaDBTVmlBMEJXaFNGbUZYK3kx?=
 =?utf-8?B?bGRzeG92dkhYOWpjWW1IQS9TU25ObFBuWE1JSk9TeGxGQ25udDhEMXRSNjBI?=
 =?utf-8?B?TXlaQkFzbGNSZU1XTUwvT2FpNDlhVVhySjBUUUdLK0N0Z1VnVDhTa2Y2alNl?=
 =?utf-8?B?MzlrZHMrZGNvWDJ6VmlscWN5OG93UUlYZ0xwSTFBR0srL3BkTU5pQnh1ZkRw?=
 =?utf-8?B?SjR0VUxnZXBTbFhOWnpjeFpSeGQ4UTRIZU1KSHRPVDNlcEhLRm9IcG5iVjNM?=
 =?utf-8?B?bVRIbm5BRmhpV2dkK1pwWHVNTlJrbUs3ZE9xY2RpTlpjRlNDSWZQSFZNQ2hZ?=
 =?utf-8?B?NVZuQ1lWUEU4ZUVXandYNk1KTkFycFZOVWxsUUNhNG5xL2pZalhVcWcvTVI1?=
 =?utf-8?B?aURwOHhmcUpZUWVwbStMUDE3VWg0UnViekxmdXJwMmtaT0g4S0pQL2RSWmNG?=
 =?utf-8?B?STFjS3lOa1NmZlo3QXAweGF0RVM3d0JtYktwUnJRd2FZS0dqZHJLTXJ2S2VQ?=
 =?utf-8?B?eGN4RFE3cGhFN3FIeC9Eb0dqRTFMZXBSTWcvYzdGMW5lU1lCamFEcmEyYitk?=
 =?utf-8?B?UmhwMmVJbTFYVm1FYXovM0N5WkJmaVd0cmkvbHJBY0l5VE9WQ2tRbVJSMHZV?=
 =?utf-8?B?Ynl5aFZFV0dzNGZRVWJ6Q2xkaG8wQlRqZ0svbGRzejRpVkxsZUdKbnNLMnFR?=
 =?utf-8?B?dzN0c3pWUk9jOXFHbG5YQ0k5OXMwcVF2TE84VExGdzI3ck9JaXh5YnlGQ3hQ?=
 =?utf-8?B?bVdWYWkvSnRuSVgrQ2dFYnc3YU1ERmN5Y04wNld3N242aWk1VTF6T01vVnBL?=
 =?utf-8?B?TytPVDFBeVVPVmdGREZWYStFK2RTVjdUWTdNU2hNZit2cVNTR0VmRXJsQThk?=
 =?utf-8?B?dnhPeUZuK2JpN3I4UUJiSFJxMW92a2liZDhKZWY2ekgxbHpJVTJWbEhiYlo3?=
 =?utf-8?B?UnBpeVJCZ0tsR24zSWQxVnBuNEpQUTNDMStHak9kZExHT0JoT1R4MUxqLzhX?=
 =?utf-8?B?SU9Ya3I4UDRMN0tMZVVsK2VvN014RkROQnRtTVVYeVRiOGtKNmNnZHRDTXBC?=
 =?utf-8?B?dnJVeTgxNlc4TXZvTzc4S083dTRBRTFsQnpVYkRWeWYzSHI4c3JYZzdLczha?=
 =?utf-8?B?QVJGNGhYWFE4ZHlHKzFtbmdPR28zbzhkZk9vaHpUUkw0RTZJUms2YU5vcjJ5?=
 =?utf-8?B?ZE52K2tRSEJsa1IraThVQlNmZ1lxMFE2T3dWeHoxa1hZSWdUTy9vUm5LNEdz?=
 =?utf-8?B?VXhkZ0NNSll0TExZL0ZDWWxOWkl1VnM0YklQakd0Qk5JbjVDZ1VYVkNKbWlR?=
 =?utf-8?B?T3Q3d3JLZCtjSjl6Sm5UNmlzWVAzNDZDUERFYjdUaFo5a2RmSUZDQTJRZWZx?=
 =?utf-8?B?SWFWejk2R0J5R0k2ZkNWcHVuZFJ0SW9mK1I1M0FBaFVYeWNKUXJpTmkwSzg5?=
 =?utf-8?B?WmJFSlZRcjRBWGc2Y1U5WlB3bUUvZzdMNWUzQ3FGeTNzRDVtUFg1cWF2bjZJ?=
 =?utf-8?B?UUJ2NUt1aUJlNDdYU0Q3eVYzNmlYSWpHK3BnVGhkdFhhR2c2bEErZHBFaDM0?=
 =?utf-8?B?ZFBJR0xHOWp2QzBtTHZmbjhHK1FOYXZUN3Znd1AwSFBQbkZaT3BHcVZQV1Zw?=
 =?utf-8?B?SWNMQVg3ZitGOWFMeWEvR2V0QkQxQkZTNUZESU1qSldWTG5RRkY0VG5QYUpi?=
 =?utf-8?B?cFkxbStTSW91Vi9ucFdNcXJXdUwxbFJhNm5tVWhXV2V6a1pUWlQ3UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1e4a9e-edbf-4d3a-0db6-08de8b3377d5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 12:30:30.7864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVmdC+DwRYER+odrmbT+R3t8TeAvEON85D4cx6+uUkTC1IcAubk3j40QCCtDTRsz86SZ+CXNBKC+V+uND143vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6219
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

--------------eMRwcasOf2Glq3U2507qGIR0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 26-03-2026 05:39 pm, Christian König wrote:
>
> On 3/26/26 09:55, Sunil Khatri wrote:
>> In function amdgpu_userq_restore_worker use directly
>> the function's return value in the if condition instead
>> of local variable ret.
>>
>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 2a1832fce6d2..2b07c3941927 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -1222,20 +1222,17 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
>>   	struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, resume_work.work);
>>   	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>>   	struct dma_fence *ev_fence;
>> -	int ret;
>>   
>>   	ev_fence = amdgpu_evf_mgr_get_fence(&fpriv->evf_mgr);
>>   	if (!dma_fence_is_signaled(ev_fence))
>>   		goto put_fence;
>>   
>> -	ret = amdgpu_userq_vm_validate(uq_mgr);
>> -	if (ret) {
>> +	if (amdgpu_userq_vm_validate(uq_mgr)) {
>>   		drm_file_err(uq_mgr->file, "Failed to validate BOs to restore\n");
> Again, probably a good idea to print the error code here.
since this is a void function and all the functions called here are 
already printing the failures and we could just remove the if and let 
the called function print error.
>
> Regards,
> Christian.
>
>>   		goto put_fence;
>>   	}
>>   
>> -	ret = amdgpu_userq_restore_all(uq_mgr);
>> -	if (ret)
>> +	if (amdgpu_userq_restore_all(uq_mgr))
>>   		drm_file_err(uq_mgr->file, "Failed to restore all queues\n");
Could avoid printing this error all together as we are printing the 
error in the function. We could update the error message.
if(ret)
drm_file_err(uq_mgr->file, "Failed to map all the queues\n");
returnret;


>>   
>>   put_fence:
--------------eMRwcasOf2Glq3U2507qGIR0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 26-03-2026 05:39 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:23d8f2a6-b705-4380-8897-93d0612f1237@amd.com">
      <pre wrap="" class="moz-quote-pre">

On 3/26/26 09:55, Sunil Khatri wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">In function amdgpu_userq_restore_worker use directly
the function's return value in the if condition instead
of local variable ret.

Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 2a1832fce6d2..2b07c3941927 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1222,20 +1222,17 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
 	struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, resume_work.work);
 	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	struct dma_fence *ev_fence;
-	int ret;
 
 	ev_fence = amdgpu_evf_mgr_get_fence(&amp;fpriv-&gt;evf_mgr);
 	if (!dma_fence_is_signaled(ev_fence))
 		goto put_fence;
 
-	ret = amdgpu_userq_vm_validate(uq_mgr);
-	if (ret) {
+	if (amdgpu_userq_vm_validate(uq_mgr)) {
 		drm_file_err(uq_mgr-&gt;file, &quot;Failed to validate BOs to restore\n&quot;);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Again, probably a good idea to print the error code here.</pre>
    </blockquote>
    since this is a void function and all the functions called here are
    already printing the failures and we could just remove the if and
    let the called function print error.
    <blockquote type="cite" cite="mid:23d8f2a6-b705-4380-8897-93d0612f1237@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 		goto put_fence;
 	}
 
-	ret = amdgpu_userq_restore_all(uq_mgr);
-	if (ret)
+	if (amdgpu_userq_restore_all(uq_mgr))
 		drm_file_err(uq_mgr-&gt;file, &quot;Failed to restore all queues\n&quot;);</pre>
      </blockquote>
    </blockquote>
    Could avoid printing this error all together as we are printing the
    error in the function. We could update the error message.
    <div style="color: #cccccc;background-color: #1f1f1f;font-family: Consolas, 'Courier New', monospace;font-weight: normal;font-size: 14px;line-height: 19px;white-space: pre;"><div><span style="color: #c586c0;">if</span><span style="color: #cccccc;"> (</span><span style="color: #9cdcfe;">ret</span><span style="color: #cccccc;">)</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #dcdcaa;">drm_file_err</span><span style="color: #cccccc;">(</span><span style="color: #9cdcfe;">uq_mgr</span><span style="color: #cccccc;">-&gt;</span><span style="color: #9cdcfe;">file</span><span style="color: #cccccc;">, </span><span style="color: #ce9178;">&quot;Failed to map all the queues</span><span style="color: #d7ba7d;">\n</span><span style="color: #ce9178;">&quot;</span><span style="color: #cccccc;">);</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #c586c0;">retur
 n</span><span style="color: #cccccc;"> </span><span style="color: #9cdcfe;">ret</span><span style="color: #cccccc;">;</span></div></div>
    <br>
    <br>
    <blockquote type="cite" cite="mid:23d8f2a6-b705-4380-8897-93d0612f1237@amd.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
 
 put_fence:
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------eMRwcasOf2Glq3U2507qGIR0--
