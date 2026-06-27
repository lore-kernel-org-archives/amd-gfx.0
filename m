Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78205C43458
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Jun 2026 05:24:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BA7710E456;
	Sat, 27 Jun 2026 05:24:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vh5kzskx";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011030.outbound.protection.outlook.com [40.107.208.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44EBE10E456
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Jun 2026 05:24:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFsnSj+LjWrZsc1UAOF8KbbGs4ERMfkEOWbk0e8UdnDQaDkpdOxy3FqqYdZyZQotuaI4RkeX0/SCCjxwES972qIU1HPEb3LF0MAPgNToAzS8FEtM1PewBtbZVsBIGFdMLqvqZI/XjlwNGQdiQUO4dNsdvcwA5gyEOGiBZ8HoHLkh3Rt4dwZ1yStwvvT6Z3TkyaIDmTpEOhDJBbilnTB+HshSI8++2yx5BMj5mThCmAhR8Uu/9t/fqUJjgTMiJ1E58dv2OMx/q2dHQX1Alpf7hPQUX720WJz0AEZwQQkSCUYV5np1hLQ0U+WuleKBiue/XyTv82CuPLBtlrBc9XyoPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaDhHgfHDXKH9fnzGDg4Zwio5IHi3dPQZsN6gC6uH+w=;
 b=YXZdiEr3NgiiI91OLYCX+NJqlN13nbvozffHeA3PyOk9fG9CnBapH/MVm88h31WrW9+h0FzwNK7FX24JkLjebKwhlr3BWCdfHGRDUFdbGmBgcS4U/Z71aTotBBVnC9/bHdgEwXPxUGZg0Asvlk1CzA4TKqj6IYzVu4KdqazfPmkvSmLI+R1YkfmYNQ/YsUTwUYGvKJQGPKXMgoCp6byR7chOp72cRIcbAZGUWWKaxrs2dr8iair8dF0Mdd/de/dBtZpI2iwFXKj3A0rTL1nWj5qLlbyjWi8HCFQ0t9tb7me9C1Wgw2528pqrHemhjmY0S1rof48O9ty3ehrxOd4cWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaDhHgfHDXKH9fnzGDg4Zwio5IHi3dPQZsN6gC6uH+w=;
 b=Vh5kzskx2KqJPGrqTrAA9cRKP33ziGjJvbZPaaW/YQso6VRdLcLcmYT09IQy8t1Ypidma2KW5/oMk8ORP6ZV1DMPMKQtSnWjh45tvjNtv2GTS3r1h5W9YIBY8HzmttCeLoBkBI5ghsV8KXs8f2TeolvC9eAgtz1RAi7i5F1WyZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DSSPR12MB999237.namprd12.prod.outlook.com (2603:10b6:8:377::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Sat, 27 Jun
 2026 05:24:00 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0159.018; Sat, 27 Jun 2026
 05:24:00 +0000
Message-ID: <acfb4b8e-a320-4a31-ba1d-7cf86afe5a7a@amd.com>
Date: Sat, 27 Jun 2026 00:23:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Fix typos in comments for IP block soft
 reset
Content-Language: en-US
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Lazar Lijo <lijo.lazar@amd.com>, Martin Roukala <martin.roukala@mupuf.org>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
References: <20260624073829.40835-1-timur.kristof@gmail.com>
 <20260624073829.40835-2-timur.kristof@gmail.com>
 <83fb4528-326f-4c32-a4e1-2cba75c257bb@igalia.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <83fb4528-326f-4c32-a4e1-2cba75c257bb@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0118.namprd13.prod.outlook.com
 (2603:10b6:806:24::33) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DSSPR12MB999237:EE_
X-MS-Office365-Filtering-Correlation-Id: 71dc1863-c567-4427-345a-08ded40c4b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|921020|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: vs+bjo0ZsfF68SL0qFcPuWXI6fwYAJ7UOojLzg/2DyBnEp5GAXTQw8isDpM8Bw7PV1Lqy1MJZbLV1XkpHIHdAnD1wDniJq/9AjGhind9NVL5dTjNUT2TEnk8wDgiP6/d4AsHbgbUeSsBjvazE/wBU9EIV84ar4jY/We0nEetv4Zx8F7beXP8apqyCbKJ/5YQPuC0YTYUptWGEnHMFfR2pmnSNvdLdp7DfR26eNSXySlNA0/dvWzxpfN1JlVmV4XOfPcjVYZNBcxDtZ9GnMRji3yeBSKMrLvunGK7wLPAWZJ0lnzEQvAFJGxSR48dFMKS+n8Sw+eVwwjaK4Ql4+AqnmReMr066uW0vAqyB9EaH0rkpJEHM0BUsKhQiMGMtuIJR7Lw5r7SYtbNTeGgC8/1XrGkd3HsguP+ue/icHkaUgWPKojPYFUD5xFqPoRf4Dhea6m6esna/JWDZvSjEYen9f+eIoTItY+WKYXkqRI08Dqe4faYSrLne4NWbFfvfu5w+j2slwy7gxmPtg/vlOpkdHWQ7qNQfFPcPDWjd/EvdSyuDB5WUvhwDSOZCW9lasAvx06c9t8RBszEo2lI1gyKTPS+iLhIw2uLcx8ycmKHLyGTymbyDehM0r8k5QcpuxXe5MLWWWkQCrk6QAjlRlomCcgS141nJvsNzm9LNLGw63we13jxr+PtqJCP7OVUkh+UnsBfTGlFTRW6P7BqxfbXHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(921020)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0sxaUZianR4QnZueExhNnJPV202VFpjdGt2L3dUanluOUpOTGFYMUswaHFz?=
 =?utf-8?B?KzdVV01kZGdrYXFUV0tXWjlzQ0x4RFNZNEhFQzBpUlF2TnMxaEFBZi9IMk5o?=
 =?utf-8?B?ZmYvTGlqZ2t1cDFLc1hMMmZRUGdxanFBY20wOWdETWdPcWpvNWNBUVJLVk9i?=
 =?utf-8?B?czkvY3pWZzdjZmY2Q0x4YkMzRDdzOXFOOGNnV1VjNWRtSGx2Rlo2Mkx5QkdF?=
 =?utf-8?B?RnJrd0xCL2RkQ3FHb2kveTRzTERFQTFZbXI1dExpMTJiVDBuSzR3aGRTL21N?=
 =?utf-8?B?TlRNVlhyM05lQ0daTExSSDZVUG5WOW5SYmNHQzJqdGtWcFpOSUx1K2lHYkZo?=
 =?utf-8?B?aWJWUHFwNjR4dFU4UndEempiY3V1N3NWVWtDTjViZDVpWjhxcnpWVFJqS0FW?=
 =?utf-8?B?RmhZVERDOS9PN2QxNklOTzV6RnFqRVhEQ0d2aDFQL0pCRVhCUlZuOWM5NHpQ?=
 =?utf-8?B?ejBZQWh6bmVhYy9SQU91WStWSkxSVjBnV0FRYlhzTEQzSnpSZDNJZ2ZtajRx?=
 =?utf-8?B?Y1lGcnBubUlYSDlTSjR6SFVSUXRqUGxFSFk0TXd5YzNRU2RscWZzQm91Tm9K?=
 =?utf-8?B?bThWdUxFYjduUmRWeHBQcnpqamhsSEdDWVRhcTQ2N1pXRnoxN2FVdWxDV1lo?=
 =?utf-8?B?SnljMXd0UEJxS3BVZStRYzBNZExTVzNGYWpiK1ZKQUkydTYrMEk0V3BSSW5w?=
 =?utf-8?B?ZmN4NFpERkJNcUErcjNQcWJzeG80dHBJcnJJb1NyUS9xRFVtVEZDWnFKRXJK?=
 =?utf-8?B?U2dJSE9VQjVqQ0ozYmJ1ZUM2ZkNJTXhySEJuUHlaSDJ1Y1ZhZ3NwMUg4V0s3?=
 =?utf-8?B?TmtMNTZDYlF4UVA1SE9Yc2IvSXQybnUxcUViQ2pScmZiUWhuNzdjb2dFTkF5?=
 =?utf-8?B?dGxMTlJZR2RvRzlidzRGZHJDbmhVckFzMFI3NWFPWm1jU2ttWWhGd293NFNP?=
 =?utf-8?B?ZXBoN1FjRis1K2RockJZejdBMjBhVXJBa0Z5SlNRK09SVmFhYWo5WVhiU0Nw?=
 =?utf-8?B?U3BtN2tyQi9DNUluVlUzMnM4RmFlcndjK21tWURaYmp0OWdFMlN6N29KQkxN?=
 =?utf-8?B?RGlLb1Q0a0ZxUElpWXJIZ0JSYm1yYUJJK2JjRnpKbkFBM3FSbTd5bmR6S1JL?=
 =?utf-8?B?Q29zSVBFZ0NYRE9VZVpVZ2VaUUQ4bjB2aVREUkluWUV6VGxXTVpQUWErWTRm?=
 =?utf-8?B?L3p3V1JRNTVsaXpkcVU3WDI2czFtU05zR2Z0ZGRQbDd1Y2RwK0R1eVJqaUxw?=
 =?utf-8?B?S1UySlgwTHRVdThTZEk2bk1ndU8xM2ZVMHB2TitBcG9DKzZJdFlCRXR1Yzh0?=
 =?utf-8?B?YXVkMzdBOGk5c0lzcmFhVXpSb2MyajBjNW4vcHFSU01aVEFNZXN6MnFtTXk2?=
 =?utf-8?B?ajZ1UEFVc2pvVmYvOEhLOW9UbnFaWEc5VWF3aTlMcXp4OG5zSWZGRjRJUG5y?=
 =?utf-8?B?aFoxZTFmQ1h0VWw4c3NWSTBVTW1MdS91Q2NlR0tGZ3VNRGVyTWR6SmRjV1dv?=
 =?utf-8?B?b2NPMTVja0ZTZWR1TFFzcnFtcXpVeFhEbkNQZGo3eDJ4Z3UwYUZEQ2RveXJU?=
 =?utf-8?B?UUpETkZQbkJEUjcyTFB4TW1jZm0vWHhmcTBmc2t5TUJPaW41bTgwZVI0ZWdr?=
 =?utf-8?B?TWxqc3MySnM0VGFtRUtLWm0wTlJZalkxc3RGb2E4VWw2dmUzeGUrQm9HZ0lV?=
 =?utf-8?B?emFvbHVHQzByUVNmQUE2dll1UWtZWUtUa1loUi94NjhVc2k4bjN6QUJFamcz?=
 =?utf-8?B?QzFUTWxCTldJNC9vMUl2V0pqWWw3MU9XK1FUWGJKTlNzV1A3d0p3T1lUUWxs?=
 =?utf-8?B?TGZEZEVSamVvaVRSVXB1b0VPVllrNEpUMXU5TVpUVHgyRE45eFBGWDRmcnU2?=
 =?utf-8?B?VmFPOUR0NFRtbXFrREpJMkVYMVZ3QlAyWExyc1pLdHUwZHBZWmJEbHh2R3lw?=
 =?utf-8?B?eTVIc0hFTU1WZG5CaHpGNWR5OE53WEIvdkpwM085cDBMZWRmM3dZaFZaUDNZ?=
 =?utf-8?B?U3lBOWtUVS9uQUF2bDEvby9KUmF6bVBzaG1obCsxYURDQlhUVkZ0a1UxRERX?=
 =?utf-8?B?dmdPUkdadnV5NlpKYU9JcFRrSWtaSUo0UWFUZlN3TnY1a3crSnhhR2I0anFI?=
 =?utf-8?B?cStkcmxaYkpMVnBpc2trdGVyVCtjSnhDUFBqK2xLUWE5elB4cnUwQW5LRTgw?=
 =?utf-8?B?RTlPZFdITTFIRldtaXlNZlVoYzNDcjdQS3lNUHVJVzkxME9sYjhCWU5BUWlE?=
 =?utf-8?B?UFNEa0FKN0VtSnZvdThtd3RoS3NVZTY5ek1Tb1hFbWEvZHRJcVB3OGttUjl0?=
 =?utf-8?Q?fb5WMn82DIXV1PIM71?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71dc1863-c567-4427-345a-08ded40c4b29
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 05:24:00.1079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0rKfdJU0Yv7X8wAQEBRssf+PS4f3InUegsd77G46uth1gStXtdPEmlVahyRFPfJZ8RYle+ecuV0QBIOEBIpLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999237
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



On 6/24/26 06:01, Tvrtko Ursulin wrote:
> 
> On 24/06/2026 08:38, Timur Kristóf wrote:
>> These typos were accidentally overlooked. Let's fix them now.
>>
>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_ring.c
>> index ab5df854c1d20..dad04a88179cd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> @@ -942,7 +942,7 @@ void amdgpu_multi_ring_reset_helper_begin(const 
>> u32 ring_type_mask,
>>        * Give some time for non-guilty rings to finish their
>>        * current submission, to try to minimize collateral damage.
>>        *
>> -     * Note that this just a best effort, but really there
>> +     * Note that this is just a best effort, but really there
>>        * is no way to really know which ring is actually responsible
>>        * because different rings may share resources, eg. a compute
>>        * ring may hog shader engines, causing a graphics ring to hang.
>> @@ -1003,12 +1003,12 @@ void 
>> amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
>>    * @guilty_ring: The ring which is guilty of causing a reset.
>>    * @ret: Return code from the reset function.
>>    *
>> - * After calling amdgpu_multi_ring_reset_helper_end()
>> + * After calling amdgpu_multi_ring_reset_helper_begin()
>>    * and executing the actual reset method, call this
>>    * function to restore normal operation.
>>    *
>>    * In case the reset failed, this function should still
>> - * be called to restore some state, but it won't attempt to
>> + * be called to restore preemption state, but it won't attempt to
>>    * fully restore the ring contents.
>>    */
>>   int amdgpu_multi_ring_reset_helper_end(const u32 ring_type_mask,
>> @@ -1032,7 +1032,7 @@ int amdgpu_multi_ring_reset_helper_end(const u32 
>> ring_type_mask,
>>       /* Flush HDP cache so the GPU can see the updated COND_EXEC 
>> values */
>>       amdgpu_device_flush_hdp(adev, NULL);
>> -    /* If the reset was unsuccessful, return without restoring 
>> anything. */
>> +    /* If the reset was unsuccessful, return without restoring 
>> anything else. */
>>       if (ret)
>>           return ret;
> 
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> Regards,
> 
> Tvrtko
> 
Applied.
