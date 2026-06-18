Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F2BCD98ED
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 13:19:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C937210F2CD;
	Thu, 18 Jun 2026 13:19:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R5h49Wjy";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB87B10EDE0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 13:19:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQ+1DUi5jRaxfahnO7Ew2onLus9xh0RLY3KVE78luoah6nRcaWjbxSI9PtfclCQwBIYfe9RA6Z5g8w2hbJqUVdG8yH/DPY3xDNY9dbpdbTC3lYXqT5D9qU6OXJYuFRgYfNlxvMljNAZP/MDyEuYUnqdY/nhoiEwk06mNJfpO4xdUrmwmY6qJG0IlB4kvCiniVjrHanhJv3aAiq3Q5RIX+BEonXZVp6MYRUpibRjAnuL1cyVWhJmryh0/b6QVzy+0sf0sT8PRu0Ph066GXkSmPKSglImltzGCSGHrEEMb19WX9XMxl7grcNjfgIQ/g4SWVjPzu2XKp23ZSHN62qjXHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZ1cfCJjdc5M1gcyy4dzRbwdOEu7Dx3fw7vpqSWXVUA=;
 b=sGJ1NkN8Ww5staszwL5AxQAaRhMVBqdjf+AhxeNwHtpb/BDr+JVMB1wrvHPDH/Q+QIV0YqHA9/xsla83+6Jgp8PkNKPoJYHsQrMuMkvTAwFnLnWjZP49oVN3QFsTmXvp0N4NskmSZQ+wB36+swpxGF3F8NW7fKMzVJOuHlcGKCeOqVDj2d5OyOmJdq6WwGStCyszxgQN8kFlVgMNWhGM1wt4AbjG91AIWn5y4JWag0njEd8EoPuh/3Qo3cp0Mr5I9RE7MRqz0/4kJK6PEK/qjwV44GscZcXIfCMyiUKHqM9E9xmVtaIWtoR8lO313GXc1rKwYmej2/YEJNaS2GaRlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZ1cfCJjdc5M1gcyy4dzRbwdOEu7Dx3fw7vpqSWXVUA=;
 b=R5h49Wjy8aEgBPeVBvL8yiXjmIp62U9g7cdbYpUCzPxdC53x/N0Ubqg52/0Tg6uFSRF5imQNhduJaBwFBDcmLsLASNj3N1p49p03hwRhyRtKsnEEDH3ADoTEgcKECWZbG4Amjsf8abJDhUe4uOHSeztzpaVFnRADPR2RuGj6Gbo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18)
 by IA1PR12MB9498.namprd12.prod.outlook.com (2603:10b6:208:594::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 13:19:01 +0000
Received: from SA3PR12MB7782.namprd12.prod.outlook.com
 ([fe80::a9df:115c:2208:56f3]) by SA3PR12MB7782.namprd12.prod.outlook.com
 ([fe80::a9df:115c:2208:56f3%5]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 13:19:01 +0000
Content-Type: multipart/alternative;
 boundary="------------0RG0s1mwowjTTiQvJEhyqfGn"
Message-ID: <151c36e3-ead9-42c4-8bc8-1585a7871f38@amd.com>
Date: Thu, 18 Jun 2026 18:48:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu: amdgpu_userq_restore_all return errors on failed
 bo reservation
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Zhu Lingshan <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Ray.Huang@amd.com
References: <20260618105158.93562-1-lingshan.zhu@amd.com>
 <d2a07581-dae9-45ff-909f-a87795e0b472@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <d2a07581-dae9-45ff-909f-a87795e0b472@amd.com>
X-ClientProxiedBy: MA0PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::19) To SA3PR12MB7782.namprd12.prod.outlook.com
 (2603:10b6:806:31c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7782:EE_|IA1PR12MB9498:EE_
X-MS-Office365-Filtering-Correlation-Id: cff89443-d1a3-41d4-54f5-08decd3c2981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|56012099006|4143699003|11063799006|22082099003|18002099003|8096899003;
X-Microsoft-Antispam-Message-Info: EqqlPKipwnqe3nCxJsdWwaK/efM3yDyJlE7hie9NfLrYPEsv081ESrQ2Htz/sE+JTTwHzbIDEAeolFpXx+PC/At7/xD63NmC3iMQdIGb/UXl8c4Y9/MKoDze3B1z7AMmK73uZwziK9+o3rBm/tlrViwAOQS3RmfKvYBUOYR1SBUWtNQ9EiIBHypSAAYFZd2rX6i+M5tHhkkhsD4LlDIaHYt9lS1O/oBDWq5yQtJbGyEE1EcGk5pJY1v7iWiNcvirS6HJwkWGdLd3aYm/1Ug6fyBdw6k8a6mpqSGDuQkFte/pksE2QP+1nrAUllpLxcYUJ2jJVb8ggxgmtGAEopp6XTH9/oY+H05w+pud87W2w9dT9pm047Ii5x1agXjZcGkxwWTJso+vfMFWKP/+nWM2lI5qxLXV8pPWUg6JlqicKM41CPNf5aNDwjIFNc4qLlsN8q02JgXFZxash74gtkRJQeqIFyZ5Xy17lpdg/bjRXfCSiTa0n8sbNUrTMS2Hjz6ffITv3vtCvHx427kbdlisjVkJCNparM+I3D2rMSkD+3O9ucjpFIQa3EOsi30uHOIk8b9+5MepZMGcJLwEcAaM/Ke9Rqj5q12QeUCbhINmx5zA5An0DzlRaXQOo5YCB70je/ONG/KXbiGghRZvLdEtgwNvTb/xjQBVRY/fr+GIh8jjUJWVajVcCAeT8GR7uKCd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB7782.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2M1RlQ4T2NEb2JLR1Zuc1ZHZENBem93RG83Mzl5dnVvSHFyTkJWQkpjcVNt?=
 =?utf-8?B?em5SQmFHdVF5elJJVjlNRnZSdy9ZeGVOZU9RdXo4blF6cFp4aGRjaEJyaGNm?=
 =?utf-8?B?ZlFTeVhkbGVUTzAxYUxvQlFOMkJ4dHdTNXYzMGg4Q0FGSUZ5VmZYdnE1UTlD?=
 =?utf-8?B?U3N0WUFZVHRZaHplaitGdGI2NTlyZ3YwWk1GbmFlY2lDRlorbjYwZVNJaDhr?=
 =?utf-8?B?V3lzUy9tYldPVzdrMHpCRmcvTGFFYnY4bXpMZnVWOEJieFFaeWhUSUlJVWUx?=
 =?utf-8?B?VnkzTnJTQzJXZ0tiNEs1dExCcjh0ajRhR1R4TzlnbjJzeW1aOUVsQmoxZWNv?=
 =?utf-8?B?NnloeG9tbjdqMjZrQVlPaXVlajIzVXo0TjRyTC9IdUdDYVVldXM1Rm0xOXFK?=
 =?utf-8?B?Y2hJaEdzYitGaVZoUkJSR0JyZCsvVEw5bVZ5TmUvMDVjN2xsZDJOZGpGdFl0?=
 =?utf-8?B?Tit3bEM1WlJFZ1ZyVVlpNkJmTFJzUVJveEdhaE9SeDd3WWdhZDliV2NQVEdR?=
 =?utf-8?B?UTdxbFdQM1Q5dFRKRTRNeXZCZHlURS9DSnU1OVdqcEIxQ1NtTTBOMGJYZW9m?=
 =?utf-8?B?aFNGTGsrOXBkY0VyM3hBZ2NvZVZXb1plVEdhVWdyczhHRDQvS1FhSWVsc0RX?=
 =?utf-8?B?c2ZRbzRjSDhXMEQ3dFFhSHMrYlFLTzBzenE2TGFQYWZ2Vm9ZMFFodjlWbjBK?=
 =?utf-8?B?MmpWVmU0dGI4dGdZY1Q0a3Y5MTI0N0xHVkxXbWZnMkErNzZjSytvYm9lMnd2?=
 =?utf-8?B?RzYwcDZMZE9rQTdWVHNtdnVnN1MxdXJLd1ZiVDdYTk84MURvVTlLRE5GNlAw?=
 =?utf-8?B?aXNsV1dtdkliMkJvNWJScmFBWFlUVjZsSGUwcllPOXJmS0d1b242cjlBQmF4?=
 =?utf-8?B?QUlpRWg1dURVY0cwRGFHS1lBMmFDOE1KTkROYWU2LzR0MStLTXVTa240b2hz?=
 =?utf-8?B?dkJsWW91V2lzRzlGYVltSWdqRVAyZkkzd2dxV1RvT2N2TnQ2QmtTYkNwdzh1?=
 =?utf-8?B?eG5kRGl4bXpWZlVzVEx2UGxKVno0a242aXF4aDBZdWl1UlF5cStvMnJmRFFO?=
 =?utf-8?B?Y1BmbmNFdzg0ZXJwbXNiY2hSM0ZoY0pzbDRkd0xEYWh2eEhvWXJMSnJyenU1?=
 =?utf-8?B?Q3ljckFRcndrMUdoQWxmYmdteGw0eGcxaHNCZS8xQ3BlSHNZZ2NoR2RCM1pH?=
 =?utf-8?B?RzQ3UXJrM2ZmbnFOK0I5UG9lQ3pqWmQ5eHM4aVpnSkRwMHFSbEwrZXlaTGhX?=
 =?utf-8?B?Vm5xR3k3YXp3ZzR1ZEk5N2gybURQOFhtTEdqa0lmOXpDTTBBSTRLWDlkRTVT?=
 =?utf-8?B?TXZpallheU5ZWWlWNHR1bzA4eHB4L3V1U0g0SDErVjZGMDh3MzVpOW9Pd3VM?=
 =?utf-8?B?cm9PY3NVNDNVUnFHOEZpcUF2LzM3OVJvdVhES05TbE43VDFXYUdzUVpnNFVI?=
 =?utf-8?B?aUNwN3ArSnZwSDliR0YzUTN0OVJrelpUdVFkbFZRb2pxQmovWGJMbVEyR2li?=
 =?utf-8?B?V0tYanZrMXdQQW9nT2J5NGd4Q3ozZ2dKOGxEaGdFdEt1U2xzWmgvSUI2amdi?=
 =?utf-8?B?ZGJHMXF0RkRoWXJWZCsxRE14a003M0w0M3dzdHpMR1RUdFAyMW50czJjTnNF?=
 =?utf-8?B?NGFGc2lIdWVOWTEybDZ1aHpJY0dSdkZYUStudllkRkFpQ1czeGU5cjJwdnl2?=
 =?utf-8?B?aHBCVUU3WXBKeWpaRU14TXlZZUNHYThETjZaU3JBNExBR1QrRnczMDI4a0Zi?=
 =?utf-8?B?Tk51bE5CUTlNMEhkbGVwQ0d1cm11NDdveWFVME9jNlY3ek80djgwWmxlQStM?=
 =?utf-8?B?ODZZNzMrdUhqYitVeGNzLzIvNFh0eUNLZXhyWThGdDBnaTVudTlBS2krWXFy?=
 =?utf-8?B?eDQwYTd6TDdaWnRGdGRHbDVNOEFEUS8ydFhaeWFHUVovbUI3dXdNWDJ5Q0lX?=
 =?utf-8?B?QXgwRU5WVEk5S25XZVh2QnQ4S3dQaHZwWDRjYnJ0cWJjSHV2VlR1allmUWtr?=
 =?utf-8?B?VmFCdERET1pWaERLRkphamwralNOZy94eUk3NXpSbUE1M2pRZ21DWTR2ZHVi?=
 =?utf-8?B?SWxKQUM4Ny9XZzdyMG8xYVY2NWc4QTJrWUdDNyt1QWRiY0dEVmxnK1lWSG04?=
 =?utf-8?B?Q1VrZSs4RnpuWVJuUmE0bUZyVTFNQndYRytLS3BOT2NjdGdjais2YXJDVUxK?=
 =?utf-8?B?Y1FFVmVPSkhRM2oxckFxd1R5ZlBUcTRHWE96RFpMV3FFVTZ2SGozWkc1a2pL?=
 =?utf-8?B?K2tIRlFSRHhnWkhPcnlBNjJZQWJtVW93SU9mNW1SN1llSWw2bTMyTTlyUngw?=
 =?utf-8?B?OHJjME8rNU84WGVUeE90UStJbHdaOThnaXFTVXR0b3JOTzNGTWNiUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff89443-d1a3-41d4-54f5-08decd3c2981
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7782.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 13:19:01.5168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZKJIIjBV1cI5dsTShkdMZjM7zW36ZV12NFtSy/pa9s84+2n8s6Y6CP3+bAetT/bfosmILYyU0WSPftMv0nzUvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9498
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

--------------0RG0s1mwowjTTiQvJEhyqfGn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 18-06-2026 06:12 pm, Christian König wrote:
> On 6/18/26 12:51, Zhu Lingshan wrote:
>> In amdgpu_userq_restore_all(), when failed to reserve
>> a bo, it should return a meaningful error code other than
>> "false" that means SUCCESS, which is wrong.
>>
>> The caller should not ignore the return code of
>> amdgpu_userq_restore_all as well
>>
>> Signed-off-by: Zhu Lingshan<lingshan.zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 95b680fc88c5..8b14870afbf5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -894,9 +894,9 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>>   	unsigned long queue_id;
>>   	int ret = 0, r;
>>   
>> -
>> -	if (amdgpu_bo_reserve(vm->root.bo, false))
>> -		return false;
>> +	r = amdgpu_bo_reserve(vm->root.bo, false);
>> +	if (r)
>> +		return r;
> Good catch, but that amdgpu_bo_reserve() is called here is a bug in the first place.
I think i probably missed that. There is no return value check for 
amdgpu_userq_restore_all and this cant fail. We should wait 
uninterruptible here i.e change false->true and drop the if condition.
>
> The call to amdgpu_userq_vm_validate() must be moved into amdgpu_userq_vm_validate(), right before we call drm_exec_fini() and the manual call to amdgpu_bo_reserve() here dropped.
>
> Otherwise we have a small windows where we drop the BO locks before starting the queues which could make the VM invalid again and cause all kind of issues.

we need to maintain order of locking First reserve root bo and then take 
mutex else we had mutex deadlocks.... this is why we have added root bo 
locking first before taking mutex in next line.

Regards

Sunil Khatri

>
> Regards,
> Christian.
>
>>   
>>   	mutex_lock(&uq_mgr->userq_mutex);
>>   	/* Resume all the queues for this process */
>> @@ -1133,7 +1133,9 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
>>   		goto put_fence;
>>   	}
>>   
>> -	amdgpu_userq_restore_all(uq_mgr);
>> +	ret = amdgpu_userq_restore_all(uq_mgr);
>> +	if (ret)
>> +		drm_file_err(uq_mgr->file, "Failed to restore user queues, ret=%d\n", ret);
>>   
>>   put_fence:
>>   	dma_fence_put(ev_fence);
--------------0RG0s1mwowjTTiQvJEhyqfGn
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 18-06-2026 06:12 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:d2a07581-dae9-45ff-909f-a87795e0b472@amd.com">
      <pre wrap="" class="moz-quote-pre">On 6/18/26 12:51, Zhu Lingshan wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">In amdgpu_userq_restore_all(), when failed to reserve
a bo, it should return a meaningful error code other than
&quot;false&quot; that means SUCCESS, which is wrong.

The caller should not ignore the return code of
amdgpu_userq_restore_all as well

Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 95b680fc88c5..8b14870afbf5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -894,9 +894,9 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 	unsigned long queue_id;
 	int ret = 0, r;
 
-
-	if (amdgpu_bo_reserve(vm-&gt;root.bo, false))
-		return false;
+	r = amdgpu_bo_reserve(vm-&gt;root.bo, false);
+	if (r)
+		return r;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Good catch, but that amdgpu_bo_reserve() is called here is a bug in the first place.</pre>
    </blockquote>
    I think i probably missed that. There is no return value check for&nbsp;<span style="white-space: pre-wrap">amdgpu_userq_restore_all and this cant fail. We should wait uninterruptible here i.e change false-&gt;true and drop the if condition.

</span>
    <blockquote type="cite" cite="mid:d2a07581-dae9-45ff-909f-a87795e0b472@amd.com">
      <pre wrap="" class="moz-quote-pre">

The call to amdgpu_userq_vm_validate() must be moved into amdgpu_userq_vm_validate(), right before we call drm_exec_fini() and the manual call to amdgpu_bo_reserve() here dropped.

Otherwise we have a small windows where we drop the BO locks before starting the queues which could make the VM invalid again and cause all kind of issues.</pre>
    </blockquote>
    <p>we need to maintain order of locking First reserve root bo and
      then take mutex else we had mutex deadlocks.... this is why we
      have added root bo locking first before taking mutex in next line.</p>
    <p>Regards</p>
    <p>Sunil Khatri</p>
    <blockquote type="cite" cite="mid:d2a07581-dae9-45ff-909f-a87795e0b472@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 
 	mutex_lock(&amp;uq_mgr-&gt;userq_mutex);
 	/* Resume all the queues for this process */
@@ -1133,7 +1133,9 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
 		goto put_fence;
 	}
 
-	amdgpu_userq_restore_all(uq_mgr);
+	ret = amdgpu_userq_restore_all(uq_mgr);
+	if (ret)
+		drm_file_err(uq_mgr-&gt;file, &quot;Failed to restore user queues, ret=%d\n&quot;, ret);
 
 put_fence:
 	dma_fence_put(ev_fence);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------0RG0s1mwowjTTiQvJEhyqfGn--
