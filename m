Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC88CEDD88
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 11:59:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AE4310E14A;
	Wed,  9 Oct 2024 11:59:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VXm2+2J/";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BDB110E14A
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 11:59:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1l9iJ1s0ISXkQVlA7MiTOvSm8IJpiN+GPZuiek66cjg64GneY1t/UtYM2ktBiJLb98I1ZdfoZybIkfkkTcxKxdEqBr1CqIRyXJIhh3Zx2Y8bfWeeR9eEJeDycY4R4qJyx4/8OHxmOnHWXXcwqom665k4O1uz0amqA2I7Y5Y4a6iR/v3QnMKJGOmZ9rtlLgEPY21Qx/FX6XKniOcMKEUQbj4R+3/N+cLqg7+6Qq2cldvGsepuUQS4yqhErjKciVIb/bsShxr1xdxy2smYW51YkHf+rXM0HZLJvAZX5R05gBI3OaLjQoYPt1eAaa/3ZJ/Pzf8q/sogI69Jo4HHNcf9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvdyQwEP7D2u/aX1WZaakOSQ97ZtYFvT4CJQeiNS5i8=;
 b=SYAZpw6ZC73h0U2hcgItSReNq+orhyM/ZDRTfqku01gMK75thqP2UgeHIEbzmopDB8lu0IGZRGmGAWCZrMdMgL5iTnVdR30/ICR8zPevi7SA+etyY2fTI64UmGrVGv43GilEM0uK43Hx3k1WYe8UpDh2Ur0WI8pTWK9ovqtIwc5AaOJxdIOtpjIvDki0hJSaTzgFKHrtNqheF+S3fNpBcSVAquX4Gh6R46MUCX8QAPET30uxgjsc5YMLzH9SQK/sRanv8ejxSPymcBstJFQ1Smyg/5FZJ1O0wJEh0YbOj+y3ehjC4bgx207cfsT97CSzB2tfnmMy5wwsJbv/7eBv3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvdyQwEP7D2u/aX1WZaakOSQ97ZtYFvT4CJQeiNS5i8=;
 b=VXm2+2J/2iS73G1WXiD1cthN46MqY0pz1ivKddwrWmx22f9pxrzJWZwjLyi09oJuoXkBvCDPiPLNfpGHHAgt0w+1IB3zjqGaO/w4OKQMf8TuEHlcabd4BkszoIEBtgo9EH5eXI7enmxwRPKDtm0tThjPA8fYmZZjsF6hrUY2xEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by MN0PR12MB6247.namprd12.prod.outlook.com (2603:10b6:208:3c1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 11:59:18 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%6]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 11:59:18 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: validate if sw_init is defined or NULL
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241009084823.828235-1-sunil.khatri@amd.com>
 <d605349a-0e09-414c-add3-b1a1350e1a9e@amd.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <36517755-5959-04c5-37af-68870fd8e2b9@amd.com>
Date: Wed, 9 Oct 2024 17:29:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <d605349a-0e09-414c-add3-b1a1350e1a9e@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN2P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::9) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|MN0PR12MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: 7998570d-a113-4b8e-a92d-08dce859cd91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1J3UzR4M01UVEVSZlRLNzFUUFpDamZOR3NPT1Y4UUxWMXR3VEoxamlnMUJ3?=
 =?utf-8?B?S3JTUHl2T1laWGprZExXME41a3l3S0hLVjV3RS83UGdUR051MUpmSHlvNDNR?=
 =?utf-8?B?M3VPbEFleXIvSHdIWTF4OWtnRHFqQ0NFWnkzejVMQXhCTm1UNnU0ZnFnaGdO?=
 =?utf-8?B?ajN6eXdaT0tLaVh5cEJrbGlvdlpMUEZEcndNRngyN3lDcWtCK3ZCSkx0c2pw?=
 =?utf-8?B?TjBReXhzalhxRjBtMHh2ODN1VHNxdDFPamNDTHBoVHIvWkdCUndiQVVUc0RF?=
 =?utf-8?B?OC9OWVZRViszSXNlUmh0VldpSCtHRW5VUzZxbHpXRHp1cG55dkNSNEJDNTN2?=
 =?utf-8?B?ZHpTNG9UZXFDY0I0WEhQUE04bnBnVE5INHRVb2VDWjZCMnFoWTVkejlkcjNV?=
 =?utf-8?B?aW9SbGRhNjJmWGgyaFRwU2VOVG1nL2xqQnF2QlBvY0xiRzJBN1VkME9XMEtO?=
 =?utf-8?B?ZWhRaG45WDlRVmZOQjRXQnYrRFplL04wZWpkckFOdFJURWZWcjdkUGh3VG04?=
 =?utf-8?B?bWM0eVpIM3pVNHAvVlRUVEpndEExTUlBQ1pYdUsrbEd3bE0yWlVkR2h4TXlp?=
 =?utf-8?B?WXRTaG4wNUc5bmNDVXUyS3ZTaUI2aXZCV0NHZkN0Y3RyWk5QemEyWCthbVZO?=
 =?utf-8?B?SzBLZ2dFV1lzdVlmSk9lK1JyNW8rNm5EazNVQ1BlMS9sOG9RWEdxQkRncGRO?=
 =?utf-8?B?MllJVTUybzRtRkhhZGZ6Y1pXb0hqV3p3N1ZWNGlLTDJjVnNQeUlUSjU0b2tk?=
 =?utf-8?B?UUVvNnpyYjVCZDgvTlRyNHFxTWpBV1hHVHV0eW1hTGxKeGs5cmtDcVZkRUl0?=
 =?utf-8?B?S3FHVnU4TG95dUNhbm1xQTNkN2pWdWVkTjdhNTQ4bDhTbFZCa3d1a1RPZmcv?=
 =?utf-8?B?a3dRbDN4N29JQXFReTRCSThpMlB5bndwYWRUSHpkSTdUK2xndkhaKzcrMGNp?=
 =?utf-8?B?N0VSMHd1V0gvTFBoT2oxMzhXU3dGVC9VVXRuSzF5eFhpVFFvK05MTXlPZm5I?=
 =?utf-8?B?U2t2MnkwNXA5QzdDWFdac2NxVG0xS0RSVFRlQ2MybVRURUYvWnJMNzl5Ujcx?=
 =?utf-8?B?U21CaXRqSXloeVBUUkl4UE1sS1pZRFN5RnFtblA1citmeWVpMzVWRG1FaVg0?=
 =?utf-8?B?dmgvaXdnb1gzQzdhTzRIelJHNzF0TTh0L1lYOFNtQ0UyRnFtNjN2NHpLT25x?=
 =?utf-8?B?RWJPTE81anhsYytnekVOMm5vUzIzT3JQbVkyQTI2cDFaOEx1S1UxMExlMU1p?=
 =?utf-8?B?VXo0Q2RwWlZDb1FYZ1A3Y3lJa2pENnFCRSt6MERnc0RWVHhBZUZqSGEyN3Bw?=
 =?utf-8?B?MDlPZHJsajdjbm42VDRIcW16TmJ4UENKZkVuYlJHRVk3d0M0Qy95R1lxRG52?=
 =?utf-8?B?ZlZndm00clF3MDRqOFhDbVJWTlR6MjFhTmR0STdrbVQ2ZEt6K0tvYVFtejZN?=
 =?utf-8?B?UFlQQmlsYmwwaEx0ZXhXaURncUJqOHh3dDE4cG8wa2FuNnB0a2xmM2VLUnVL?=
 =?utf-8?B?R3kxS0hxYmZGZWRyTlRGTHhmc3Yrb0RQb0lzQkQ5dm5uaEIwb2tJZG9uVmE0?=
 =?utf-8?B?N09XWFVkSVI1dTYrUmxkTXZHUTh3ZTRLRFdkajBhT0tKa0dPTGxIdDA3R3dX?=
 =?utf-8?B?QmZoY0h3UHBjSTZqcFJvT1YxdjdyTURMcC9SV3VwWjBaRTZPNEFMUFdleEZF?=
 =?utf-8?B?Z29tK1JxYTZLdXFCb3V1SHlYdms0blRyOUNxL1BTbVp4T3JnZnNSb0ZBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzRRTXlWZUQvNWRadVJPdHJmdHUyUnJ6Snl0MUdsZ0hOOFFYVnIwYXYrRVV5?=
 =?utf-8?B?LzYrWUh0dEROTFN1RkI1ZnV4M0ErN1RlVmtodFJQcFB4MHNkUndDWDNXc3RV?=
 =?utf-8?B?bnBBdzA5VThHSEVFaVpzamthZTBSaWh5L1J5L0d3RVE0dTYwbG16Q0haNjV5?=
 =?utf-8?B?SnJiQUprcWZMdThSOWVVOFRPTG4wb2d3UEFnbmxCTTBvKzNKVTRFbnUvVjRs?=
 =?utf-8?B?aGM1QkFIOWR2SEV4RDBlVnRubkdCMTZ3M2w5UFNLY0RueHFPWGdPRXdXc2I4?=
 =?utf-8?B?L2R6aTJqMEFQZ0Q5YXB2NUY3TXZqaC9RdEhjOW45MlpPN2dzSlkwNVJYWlBD?=
 =?utf-8?B?VE9SNVJCckhVT1JtVlIzK0N6SzBCTHdUbnFOVTg2d1hoWWhzUERBVzlwNzBH?=
 =?utf-8?B?ekhzbVFjczZ4L3hXTTFGbmVxVzlyWlRWbmVBZ2dxSis2aGhoZjlpdzdzWU9C?=
 =?utf-8?B?MU5ueVp3ZjdQYjdYRC9zNFJXQUVDV0lJalA4WkdGYmxXcWQ4QmViOE5mVTR4?=
 =?utf-8?B?L1d0aFpkYjQ4WnpuTVRnTnVuRDg1V1dGRXcydHVaM0o5N1VxSDF3UDVzWHEv?=
 =?utf-8?B?TE44U2dYcXZCQnBVbjFRai9VcVdDY1F4UlBXV1JSSmJiWkk2VjdDNW5mZXlQ?=
 =?utf-8?B?WlFqZS9lRW5sSmlXcktudGNVeEYrTDZuVGMxRTVuQTZ0MUdSZUhzOFgyb1VV?=
 =?utf-8?B?dXk3MUZtQncyc2tCL3R2Zjc2TXFzby8zVUNxc3RKeHZFWlpzVU1YbDF5V1N6?=
 =?utf-8?B?Szd2R3VBb2E2Zlk3ZlZmRVlYVmRqZVloc2pYd2M4OVJVdGhXbTc5TlNieFBa?=
 =?utf-8?B?aWgrSDdWTVE3alpEWXBRb3crLzRDdTMxeTdEcGxFeExFaFdxTU16MWlCN1Uy?=
 =?utf-8?B?N2dKVS8xMGFsOWFvNFFDeWxuL0JmRk9pZnZWeHRneFkrcll6aEFYQ0NST2h4?=
 =?utf-8?B?QWpnQTZaSWpJa29zcTB2alJVV0NWSE9kMkxORXQ2ZkNZOE55eTJDN1BISGVC?=
 =?utf-8?B?bi9NdVhmT29KWVRSbDUwbVdVT2QzWVoyV0hlS0lkZ3VJbUlYb2NkZVcyK3M3?=
 =?utf-8?B?SHc0K01WdWhuSzhvZVZJUWZacFZGbWs1Uy9jazQ5T0lXbjR3RkNPSXdoWmt6?=
 =?utf-8?B?RkxaRE81SzNiZEVGa2ZTZGRkTitwQjBCdkMzc29OZEFyQmVvNmRXZlFOUzFu?=
 =?utf-8?B?NlovWW1YMmJIbUFvN3Q1Qm9lcUk3K0U0N1o1WmR4MUllZ1QxZXhhWmdDbGtE?=
 =?utf-8?B?YzMweFNTTW05Vis5cnhTMm9NbUV2aHRENmRQaXBiZStMaWFjVkxwUzdXRTFP?=
 =?utf-8?B?WjFwVzd1U003V0J4dzFEYXpYUGZlYVhQWkQyK05JTGRVWmhPd2JMN0t1QmY2?=
 =?utf-8?B?NWVoeUFZWXV5eXY5ZWZPQjl4YzFHOUptTmRjOW8zaTdPNWEzUkx0OTRPekhU?=
 =?utf-8?B?RE54ZEFtcVM3bWFGS09jUW5UUUVaZUMyV1dQOGRsR0QxRWZoMk5DcWg5OEx3?=
 =?utf-8?B?TjQyWnBMMzBjNEpINmIzM08wZ1NaTVF5SDVIOWZVVjhFQVhZK1d3ay9waDYw?=
 =?utf-8?B?akhRWTVsMGNzTnhnNUxqM2lnUjNlMUVJOHcydHVHNWdBSVRmZWw1azJ5ZUp3?=
 =?utf-8?B?MEZQbjBGeDBCK2lva2pwU3BzbEI5ZXdqNmRwRjdXR0hhdjkwLzRaQlM1SE0y?=
 =?utf-8?B?STdLS2lCUDdzNmVrck5iMDVLaWg4dDNEcEMzOTMzOS84Nk5qNzdsVVhzbmlV?=
 =?utf-8?B?b2ZWdWd0RXBqa1ZiUWI2TzNvVlpSWUN4blZkeDVKN3NONXY4dis5dGNwZFBK?=
 =?utf-8?B?WlBkM21LTVFUcVFuTEowQlIzSHMwaWF1VWUrRS9mYURKRCtyakdteG5aVVEz?=
 =?utf-8?B?SmhENWo0Vmp2TW85cUE5N092YVVUelpZTFMxYmlvYzR6aXBtazI5WVo5b1Ft?=
 =?utf-8?B?ZlZaY2xoaUROMThLd1R6RTdHOFN0QXkzUjF6MlR3cTd3MUtDUE9sQkNCVUJt?=
 =?utf-8?B?eEkxNDltSHE1RVU5ZTBzaGZTTVU3M0kvQ2pkeWlUUXZQR1dJdlZtVnF1dkU2?=
 =?utf-8?B?MVBwRDBJTTlFSTJRS0EzTGE2aVNWSm1VRFFlSnBya3NyUWRGTlRLb1dzR0Nw?=
 =?utf-8?Q?5BVMInLemTY6xgkft5uDEFTae?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7998570d-a113-4b8e-a92d-08dce859cd91
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 11:59:18.1125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SX0Oer0dgjCMblM+oLsICec7qgv15POk6B9tWP7G76mIsYo5wi1rPwAyonr1qZFVR/fkj0QMHeggEDG2KH8iRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6247
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


On 10/9/2024 4:19 PM, Christian König wrote:
> Am 09.10.24 um 10:48 schrieb Sunil Khatri:
>> Before making a function call to sw_init, validate
>> the function pointer.
>
> Maybe add " like we do for hw_init." or some similar example of 
> optional callback.
Sure will update the commit message also
>
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 38a7423101f3..4a6def74964e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2851,13 +2851,15 @@ static int amdgpu_device_ip_init(struct 
>> amdgpu_device *adev)
>>       for (i = 0; i < adev->num_ip_blocks; i++) {
>>           if (!adev->ip_blocks[i].status.valid)
>>               continue;
>> -        r = 
>> adev->ip_blocks[i].version->funcs->sw_init(&adev->ip_blocks[i]);
>> -        if (r) {
>> -            DRM_ERROR("sw_init of IP block <%s> failed %d\n",
>> +        if (adev->ip_blocks[i].version->funcs->sw_init) {
>> +            r = 
>> adev->ip_blocks[i].version->funcs->sw_init(&adev->ip_blocks[i]);
>> +            if (r) {
>> +                DRM_ERROR("sw_init of IP block <%s> failed %d\n",
>> adev->ip_blocks[i].version->funcs->name, r);
>> -            goto init_failed;
>> +                goto init_failed;
>> +            }
>> +            adev->ip_blocks[i].status.sw = true;
>>           }
>> -        adev->ip_blocks[i].status.sw = true;
>
> I think we should set that to true regardless of the callback being 
> defined or not.
That exactly is done in v2 patch set already.
>
> Could be that an IP has a sw_fini callback, but not a sw_init one.
> Yes there are example of it where sw_init is not there but sw_fini is 
> there
>
> Regards,
> Christian.
>
>>             if (!amdgpu_ip_member_of_hwini(
>>                   adev, adev->ip_blocks[i].version->type))
>
