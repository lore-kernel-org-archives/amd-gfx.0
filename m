Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C6AC54E60
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 01:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD83510E377;
	Mon, 18 Mar 2024 01:44:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2ynd/uYu";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AFB310E377
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 01:44:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYHodXJ5D1u5dcWuBivy0GtS3qxOc4HoGSb98h3cJ6ypBYihpz3qK7XnZDhufBeQOatiii9rk/guCVt+Fd9fpBsN65kn/sm67bSqjLv4F0S3te6O4GJXq4oSKL9r4i5s6N7sl7p/jEom1BL8MPjgRpbM9KXoggh0HW6e834+x47+Ow6vtqA9+mzBuP2eRRBN9MoFtk8e+Lhz2folgLSP+RxcPwto2u/XSiLm6uAwikQ0/PH5/6aXuAs69qj3ZqGka7FfjMHAu+W2BDkIuBzVDMBkIGKi2chdmh1JAwH+46ihgPVrcp8qa+xBYV5OdWdxOajCyhrATrZCHJb/IoEUNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSa9P7Z/dEe+J/wnlqMQAa3pzeznNsqDlKpP7dL1ov8=;
 b=dBF7H4BN5+rsEFgouewlRLBVv2yhLRnxSmo0rNnUvj/hTWJ1G9ZV0MvlsPC2kip6YGw0RP9m8JYPSDqzpltquXtRC7pW8qg7dDY6XeZElzwohRAf0CPAERcW4qnppIU6Z2gBRw5JPRLZx9nFjolfuGPQENRdcacKaC6KO81LcLHRcfqwYtKbn+XqU8gnqsfSOoeMBuQJNjbTMC0ZrDjkRU7oJP6sihkpW4CnZQCM4gPuy3FlQfusbUFOXvbmIxXhHtEPn7qm35n+P7AxfV26eZGwwOD8LJzqgKqoLIU/PqpuE9XOQtoh7sPxid9N2mE+9xwU1pFLe/Juz4511ZrjxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSa9P7Z/dEe+J/wnlqMQAa3pzeznNsqDlKpP7dL1ov8=;
 b=2ynd/uYus26F2oTR4XCnGWFWmE9PwQkrK5FP3A2ZK7XRbEKR8NbWyPnCt65WYydQNxISB3qNsNVr04ir1xSOH5pCrcenqNOdwk1yUzUcVeFf8TOUoAUKCaC6TdXFUBiBs1k32Kv2HHFYXZyIN9x9gboqLQlPmc5tMCz6HX8YLOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 IA0PR12MB8907.namprd12.prod.outlook.com (2603:10b6:208:492::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 01:44:07 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510%3]) with mapi id 15.20.7362.031; Mon, 18 Mar 2024
 01:44:06 +0000
Message-ID: <60a6b7ad-cb2f-4c59-9b8e-e7082f44aaf8@amd.com>
Date: Mon, 18 Mar 2024 09:43:59 +0800
User-Agent: Mozilla Thunderbird
Cc: majun@amd.com, srinivasan.shanmugam@amd.com
Subject: Re: [PATCH] drm/amdgpu: Fix the iounmap error of rmmio
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20240315051725.2450734-1-Jun.Ma2@amd.com>
 <e9917d19-110e-4523-b268-8e79698466e3@amd.com>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <e9917d19-110e-4523-b268-8e79698466e3@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|IA0PR12MB8907:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be8681d-3fe7-430d-2e8c-08dc46ece5e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WI2TA092zhlV2YNo6MraNdJ9NytABYHjbvdJrLyDerVcWaEi9QYBdcjwlpE/2iISJ1UVnRGD4gsGuu1B8/+bTl16a76bgP151GY8NLKwvgqUe5hBCnG9Q95oHJCL/tEnHADKY5nKJ47KDfvSYzuyBs0jvT4F7Co9iSbIRfOsdoe8mkM13OHS8P/vdwMgNuz29BThBvj4S/6NzoiNFsV06sSAYFo4rGgfierTfeSvt72RAwRzm5ASxpgTpoJVArYepWfunt6ba4Yw/i7mhF5p1Q9hlmqOJ21uGnLMtekfeGWjLCG2VxqUQ5b/Qxy8ZCeh3POWxiHl3j0kvVpD31lzQvTwQHE48WnVBddTzlEBEZTYegUmKw2TEh01rwJnW25Ee2Ps9TbK2wOj9kaQ/EsacvzKhl2dC3HzZQiMknKuYdw06ItHYJa4b4bjrDDSy2m0AeidgoKs6ifbBgavvJpnl4igq3rY73DYyqLHkzkuAk9upXBs+WyP58i9HN5eBGJcZXBau3mpajoFaKQCzohQbUlWT4+bskwmQ779VnSgSEDtsCi4ZwxL7zojjY0CG6bKNOLXP1Vvp2HkwRNujJbjE964MxrwYSegjUZO1G8x1L5SknqlFKLR72bl2ahAXxN+LSQHxjIMSLDifcRxUAmBynNiS44NxSkmEsOmA8qoq+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXFOWlhvU3htS1djTmJScTFoMkJkWkVDZHdwZnVYR1FaSy8zdmVWcE85NVNz?=
 =?utf-8?B?YjZVcFJLdEZjcjN2ZjVuRTNlWW9wRVUyaCtyb1YvVUZhdmQwby9CcDdORktq?=
 =?utf-8?B?RGYxMnZ4T2JZTmNUZWN5Qm1KeTRucTNiM3NlVXJiSmNNbUZLQjNSODBZTXk3?=
 =?utf-8?B?UXZQeUI4VkRKUGFYeTkzZjkvK1pkTHRtVTFJY21PSlBjOUdxUVUvbW5jSlhx?=
 =?utf-8?B?ekJsMCtWcXZPNXFUNTNIcmwrTy9OUEwwM1FvTk1acDQ3enI1QWlyajYzdno5?=
 =?utf-8?B?YkhJc0twSi9yYmxuSXpncC8xdEpzSWFyaDB3cnhxVk9IT1VuMVkwLzFuVXUy?=
 =?utf-8?B?VjEvcGh1RlhiaHdNMjQrNjI1QW1uYVBMTVVJOE8yU2RQTnV6WDlsT0NKSEJX?=
 =?utf-8?B?M3l1RlJzY0cydUw2MEo2bEk1RUtOR0JSSXFLY0ZrMlB0cnRJanAySkk2akYz?=
 =?utf-8?B?bkNKNS9UaWhCcWUzelg0R0s3QyszRGtFd0piT0dTaVJTWEhNZVlpZFV0YWdD?=
 =?utf-8?B?MjZvLzJORi9SRHBGdlV3N1B2YUlHbWQ2aHE2bGxJV2Rnc1BXeDArVFZIaDZx?=
 =?utf-8?B?UEtsNDlJemZ0L2g0SlNqR0QyTEI2OEJSVllzemZ3Mk9wTzdYWUhQYzF4TDZG?=
 =?utf-8?B?b0pyQzRGNkJzUS9iaGIvTkRjMng3Qm05Nmxjck1BUkZ4R090Q3NMaE1wWlly?=
 =?utf-8?B?elpmMWpOdTdDeGM1VnkrR0p6bGUzeXN3VFpmRExMUklGcURta1VZSUNLeTJu?=
 =?utf-8?B?MW5hZVZuMHJBVUVwZjEzRjFNNEhwMGNydmJTYnFaUGlOYWZwM3dlQngzano0?=
 =?utf-8?B?cGFyMFRaOVlaZ3piVUhNbjRwcHFuVzFleG9tRWd5V2RZVkl3UURwUkhaSk5w?=
 =?utf-8?B?L2ExbEdYUy9jQzlObllYcGtNdXZ0Z2kzclZWbDkyaTBDY01Zd2c0ZHNSNHkv?=
 =?utf-8?B?L1NwTU5OOEFHRHlCUi9OOTd4WlZtdDZ3MExpN2lxYnR5QnpRZHZvOWFxa011?=
 =?utf-8?B?MDduRThUSWNMSHZCNGdLYWdUMWNxbStUTHZ3UXBjTW9PbDlQS2Y2RU9YcHZU?=
 =?utf-8?B?U29UM3JMTGYrVEVWbkxkZmdDUG82NjhONGJJSnJLTkk5SU5tMmxSS1JtQWZ2?=
 =?utf-8?B?cFpXeHpmWDhtK2tJUlpVNlZlUjFRaGtXeUZyYm5DSXlBNEt0WHF3OXFlcE9X?=
 =?utf-8?B?NmFaTW91Q3Mrc0plZitWanNMY1ZPUVVZY2ZlMHhTdjBqdW0wQXUyUUptNDd6?=
 =?utf-8?B?Z0hRaEhPZVlWM1VGVWl2Nys4T3BXRFQ5R1I1Tk51bzNLMXFRbEVUYnZidllq?=
 =?utf-8?B?TjZPOU4xcXpNTzhuRzV1ODZqeUc4MGlCdXI5UE0yRHBMM0ZEZXl2VDgvSkw4?=
 =?utf-8?B?Syt0bFNmUnlBVFlMWVpDSTFKTzhmSjl6Wk1qdmV5L1hJSXVXdVlTdE54aG9T?=
 =?utf-8?B?NFVWWnpwUkx3N1BwbDM2aGR6NVBjZmhQbm01ZFNXVWhYY2VZZ1J5N1VyaEJs?=
 =?utf-8?B?dXVwSnF2VWplWW9WN2dqOXl0NVRrT0ZNVUZrK3M0SGlBT1QxYVh0eUFjYnI5?=
 =?utf-8?B?QUZqV09odGJkL0sxbG4vOHhLUTJJbzBCZ3ltdFF3NXliWVU3S3FZaGU2U21M?=
 =?utf-8?B?Uzd1S2ZtK1hBdGNicXFmYnlMMGJ3bzgyY2pEMXdBcU9JOEtOcU9hc2QvM2Qx?=
 =?utf-8?B?bDRUc1lManJ2RUVkaWZ6c0lITi9aZ3dpTjZGbTRtbGNVM1N4T2EvK1NiT3V1?=
 =?utf-8?B?NXV5Y3o4a3c3bmJsWExlY085L3NWZ0tjSUVHOFJKYlFYUzRhMWdUaWg4aWdU?=
 =?utf-8?B?RkhRL0RWTlhSeHNzMlR6Wk5Ed1ZrR2tlUVdSUjhhekNrcGM2bEcxcS9IQitt?=
 =?utf-8?B?c3YxWGpOeGxIK0orUXpZUTEzdFR3d2pqRENqdkY4RGlaQ01KVzBhemZ0R1I5?=
 =?utf-8?B?aVRJQnNpV2wwc0dHU016cHJwWnlQNjkyV2pvRFBkRFJ5YjVUK2hpd3VpTlNO?=
 =?utf-8?B?cVVlQmpXeUp2czlaR0pUVXNzWnR1SzM4dkZ0R09GYm1oektScExGdGZvdlNx?=
 =?utf-8?B?RlBQb2hMTkczYlVvdjhWYXlRbFJSYlRlYmJXYnpHRTZnZWtlNlRHTS92SDFI?=
 =?utf-8?Q?E1e2MylaSx1wpNO3O+Z8LhTB4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be8681d-3fe7-430d-2e8c-08dc46ece5e8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 01:44:06.6134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8KxWTNpTX7yJS/JHgld/hYDVERdAwDtdYI7ZhX7Rkh79WLBge+Yb84k+FtLmI0w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8907
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

Hi Christian,

On 3/15/2024 3:16 PM, Christian König wrote:
> Am 15.03.24 um 06:17 schrieb Ma Jun:
>> Setting the rmmio pointer to NULL to fix the following
>> iounmap error and calltrace.
>> iounmap: bad address 00000000d0b3631f
>>
>> Fixes: 923f7a82d2e1 ("drm/amd/amdgpu: Fix potential ioremap() memory leaks in amdgpu_device_init()")
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 39dd76e57154..d65a6aabefbb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4383,6 +4383,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>   
>>   unmap_memory:
>>   	iounmap(adev->rmmio);
>> +	adev->rmmio = NULL;
> 
> Well that doesn't looks correct to me. You seem to be working around 
> broken initialisation code here.

I got this error when I tried to rescan the gpu device after removing it.

Regards,
Ma Jun
> 
>>   	return r;
>>   }
>>   
>> @@ -4514,9 +4515,11 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>>   #endif
>>   
>>   	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> 
> Ok, well that alone doesn't look correct to me. The MMIO regions needs 
> to be unmapped independent if the driver is disconnected or not.
> 
>> +		if (adev->rmmio) {
> 
> That looks just like a hack to me.
> 
> Regards,
> Christian.
> 
>> +			iounmap(adev->rmmio);
>> +			adev->rmmio = NULL;
>> +		}
>>   
>> -		iounmap(adev->rmmio);
>> -		adev->rmmio = NULL;
>>   		amdgpu_doorbell_fini(adev);
>>   		drm_dev_exit(idx);
>>   	}
> 
