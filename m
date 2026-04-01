Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC19D2ED0A
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 13:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3432710E1E3;
	Wed,  1 Apr 2026 13:36:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SwNQiDWy";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010049.outbound.protection.outlook.com
 [52.101.193.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E915F10E1E3
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 13:36:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlyyXSk5Xq/xlRSz4/ky9zxuWbrv9QrQZKYCVS1VAjqlp85B69bdVpvc6tZgML8fuaFWC5vvljHgSG5JqUOj2FId0Lzlav9IHtVyt8/iUuWbdWXqyntvBXFMyqVRmVWacNFI6ueC2TteTLCssrd3Wj1jsRIo0aM2VqcRhV7LiY9Nw8Dp0OXzY3bm3H5m80yeemgjoJETw1lm4PZR2uJzaRMnI0fCnKXdUSA/D6QxRDonHQFVsxY6GZycQbiyTWXsfbHljISeNMjEa6Q6RaEKhNwtJMjJo7tMAlQB4b2YLHkiyHzDq33jz4ddspXJ2eI6NtniZH6f9dqHd13PAOZMHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2AbNSFBX54LKIXca/FUUGuZQTlvdZnqTRXjJVqE8vg=;
 b=Pz60mH1ZE1vYeIXop9V+uwHzyAInHH/qrOh6qLu8mwWro3VgYJWu69Cm6kCCXZRH71SZU3XxQfnixi7zgwpBJ5v46VNbt9nck9O32Mk9VoaihuJvXPEKCR6lZZaazpLORbx6jO7yDbEdBRVnYtSzDoYYJHz+sKd5Vk4WJq2NFYPxIZ3usG3ZOnJWqhBHlJwQRC91T6gs2/G2qYFhABBopjvb5jJGmaza4Zc96IVyobbKpGN8TI41SgEmgAg+kjYuJJHFFVxmWt1pR1pmwiZ/PHfVpMdTCXk7s3uxJcpxhjdxQkVHaYcUVq0Yze3IdGFCYbSGmo1nBvXgEWa5PiVhGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2AbNSFBX54LKIXca/FUUGuZQTlvdZnqTRXjJVqE8vg=;
 b=SwNQiDWyJ08cCtOb28rODRR+YhUcfu5ZS1DbmI5RSMpyqPAhr51KZoo8fGuGCt06/pjbhZTrr3Jtb3Dm0uxNIR4oKCfcUafN2xX5RQChIkT/4Z7HmKZN8uoAjphVPJ9Js8dTc6zCNpYLyLKO7//ZNmX86yumrFDVI+Xt/iqcd5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DS4PR12MB9682.namprd12.prod.outlook.com (2603:10b6:8:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 13:36:53 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 13:36:53 +0000
Message-ID: <43e779a2-0e3d-4721-97e4-a69707f2c9ee@amd.com>
Date: Wed, 1 Apr 2026 19:06:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 2/5] drm/amdgpu/userq: dont need check for return
 values in amdgpu_userq_evict
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260331134654.2762805-1-sunil.khatri@amd.com>
 <20260331134654.2762805-3-sunil.khatri@amd.com>
 <89b5637d-f52d-4b67-a774-02aa99b114ed@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <89b5637d-f52d-4b67-a774-02aa99b114ed@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26a::9) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DS4PR12MB9682:EE_
X-MS-Office365-Filtering-Correlation-Id: 21efa493-ae67-45f2-f512-08de8ff3bbf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: GWEUEYM8V9m1SNy84Q0QI0cHVT895f/OkHQU7RQDSPydbKu2g0Z2n2I/kZD1po0MlCKRHMTRnFDDVnQw4Xv5/lJDYRqsiOjlvrh8ckUw2ijmdQ4Gu8KUBQLJqiVNYN+iqRDmgtSSyjCE2tk4k3AUEZxE/XPJkb6WNhtSyQx3nPsAK/sSLZ0L8WGF//7lQOUOlIiCBodAOfqU/7dfQPr0y8zFS21VeXh6BXE/offkxqGc3cJKiafNCTRwpggTCpPLkOvB/TjGMlyIE8QboQdb4thKLLIsxag07srVTbciGcvmOHNwADksi4+Wz3NI7sU3T29saMoWC0CrGP3itOSq2K5zC6h0U/rAssSaaZvY3Y+hjRopo6TevVq9kuR7oc5B1RN/gZC+UCQZM/GRWF7IGGMOC/ifJF0Imez+akUInMP1jaWRYN2b6oQeOxtheTfdFLY7eZeDZdNkr/+K0PCQGhkCcWGmD2KVD8wq7oj59wDJFs2uB4PMoSP8FUFQ/JhGZL7hZM6x6kuKkvrwsRC13eL/kpVm3j1+T+Jbc1AYfncyKaBxmQTZEv4k6whm+WnGqbDQRqqXG9saYNU375VJ8JdjgQjVkpNfYyIqzIideso15IyaFc1duoHji8UTAwkI2AskNrS5CWdGyPdLOqy1FJ+ZUU7LLcRsz1inXgCFY3D1qll5KpcrELXMAOZ0rnqt2GLDZg4ymrHzn8kMcqCAQ9zZALPoZjHNCR82k1saf4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFB1VlBkRDlnRnF3R2IxZmJqcXVCdlozUXgyOXlBa1VlRVNwRHV2OUxnYm5i?=
 =?utf-8?B?TkJTTTFkUWVLa1pPZWIvdjl1NXFUTVgxMlhuT1NXUHllUUs1aHVkR3JNOGhD?=
 =?utf-8?B?UHpHQjY2V2lFVE5oK3BpTUVwWlM2QXBic1hHOXoxTEdlaDM4MU9Bdk1kcFcw?=
 =?utf-8?B?RHo4U0gyQlNXMWkxRkp6b1hsYjZPclRMQnI2MDcramZIandncjBEdmt2b3I2?=
 =?utf-8?B?aFhiMVNiWHY2Zm5BaGovYXJTby9jWUNLbTA5QS91OU9tTzI2UVhEMmtVeVo5?=
 =?utf-8?B?aGJ1bktFcUVDbGE0RVBxMlNjbnppOTFLQ2dON0hCTXNWUXMzMlF6S3Nha24z?=
 =?utf-8?B?eDFRY1dPWUU1R3pXQTNMdWFrYmZiZ1pMNkRPc0ZETTBlblRNdlhlTWp0NnRr?=
 =?utf-8?B?L1EvaXdqY1NzcTdEQmNOUlR5WUdZVGxHTEVWbDJJRVcvYnJJTHBNQnZmZEpB?=
 =?utf-8?B?NmhOaFhYYVNEUlRUaVVDN2lFbDIySFRkTU85RjFZOExlMTRieFJKVUhOVU5T?=
 =?utf-8?B?azB5akVJME5mMjBZc3lMRUhlckEzK3kvSndzZlhGcmhkcWZYbC9QV2ZYTC9h?=
 =?utf-8?B?MjZhRWtKMStvSFliei9mVnFNcFVKaW9uTDlXMjBwbWNtK2hyRzEyMGQ2ZXVL?=
 =?utf-8?B?emdQYXhyVGJFeG5CcW9PTWJXb042OStvbnE5NDlpdkQvK2pydStBUGxkbWNQ?=
 =?utf-8?B?ZFZDd0ROK1pVbTZKOFhiWUMrWkxjRmw3cHozWU11VEhCQUdrdXZTdG5GOEV4?=
 =?utf-8?B?NWJhWExUNVc1dGxQaTFZaXg3OGg3aGJQWExJcWZuRWxwYTN5TEVGM2haMHBy?=
 =?utf-8?B?VHpWbDBMMFRNL04zS2Zhd3MrMVI5TmFZb3lYOFdQeWZLK05PQlA2aUZsUnF2?=
 =?utf-8?B?bjAyd3JWZW5QeE5DSjZ5MkoxV3hIV1dDTThZeHNoRjRJMUJ3aGFmVzhzTkkw?=
 =?utf-8?B?ejl5NDRYUDdFeVV4Rm5RazNJMXZSNGFvRVE2a3lubXlhQVFLV3NjeXhLaEU2?=
 =?utf-8?B?SzVTUVkvZFFIdEgvS2EyQnhNUXFYeVNzc3QzM3BpeTBmWThaZ3hjTzFQYXhy?=
 =?utf-8?B?eUxmWUlwRzZkTDRPN0FYV0U3VDdmYTlzYkt5YlU5dGtXQ0VraThEbEg2Mk42?=
 =?utf-8?B?Lys3ckt5U3BaZmxMdFpxRkZHOVRFWTFEc1NZNXNacEhSN2JFaXNQSG4veG54?=
 =?utf-8?B?RWJnbzBydFZvV1RnWW5DVDUwenU5T0lXQVB2U29kcDJWSFI4N2V5NlNWV21u?=
 =?utf-8?B?akNLZGlyc0wyanJPT3UzSEdNK2tmNVpZU0l0Uk02WjFheWRuSm5VYTVQYzB5?=
 =?utf-8?B?MW9JL3RjY3cwZy9Yd1ViaGdKRzlDVWxla1hPaGhXTHNjc0xiamdiTFJvNFNQ?=
 =?utf-8?B?Yzk1UmF0aktFYk9KQTNSNmRXc0x4aHdKM3pOOUxxaFpjS1RhQU1wWWxRbjRU?=
 =?utf-8?B?dXN4UzgwbWhmMGZzeDR5TVduNzE3dTZlNzBvTzNDbTk3M0dwcnlhTG5pZUxu?=
 =?utf-8?B?djJMUUFiVWdsd21RdC95bjhXQUpjelZmYkRTQ1Z6MVg5a0ZvMFFpcmFoWTVw?=
 =?utf-8?B?V3BoM2ovblI2RmRtdkwzeHJ6NG5kTmRqNEdoZFU5Y0FsOHdPRUlOdHc0aDda?=
 =?utf-8?B?cUM5QXFGOEVZRmtORW15amtFcGowTkQ2Y1F6UmM0ZUpyN2MyWjR6QTBXQlVG?=
 =?utf-8?B?SForTmt0cU5NZUJ5cmIzRUhjV0J3SmIyOEdmWnorTkpBam5FSlVYSUsxRnZH?=
 =?utf-8?B?UHNTZERtYlUzR0U0WkxuMEZ3UGorS1lJMmRNWkJsdFBuVHl0dWU5azh3YXRQ?=
 =?utf-8?B?MFVHcEp3ay9DcjJybmkzdE1GYndjbDFURDFRZDQrT2M4d1FsOERlNFFTWFd1?=
 =?utf-8?B?Tk5IKzBWNzJyUVRpYVpnbHdFNmtKVVkrS0JXZmhRUUtxNCtZa1NiV3N0VEZY?=
 =?utf-8?B?SUpPUFdoRGtEY3pGOXM4S2ljRG1pMFNtcGQ4a21hS1dzUDd6MVU1RjhPM3ZW?=
 =?utf-8?B?dFJrTC9NVWtWZGFrYy82cnlRVUdSdXM0c3V3Qk9HVTFYRVFQV0NqYXlCMDY3?=
 =?utf-8?B?WDRCZTFBc0Y3QWJGM2hIRHdFTlJjd08zMHcwVm1OQVgzK3VQLytVbVJwckJ2?=
 =?utf-8?B?UXB1YkRhSWdJbWpvT044dkxkMTFqZmF2VDNWbkg5dldiMm5aYUdlbGV5eG1p?=
 =?utf-8?B?ZVNGQWJNeC9aWjMybEswN2RwODZtZGV0RXhBbFdDLy9QOWhwM0hvUVJXZ0tY?=
 =?utf-8?B?WUhJazFqNFJIUEtLUUVtaStnVzBDbUNRVUozSUlkK1BIM1FOWGJEQWxXR1Vh?=
 =?utf-8?B?RWJXbWFYT3pTbjdNY3JmU1J3bVVNaGFDY1diblhsbFp5R2taUDRKdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21efa493-ae67-45f2-f512-08de8ff3bbf7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 13:36:53.0534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuWp4/VO/xDIy0wkVx8Uea9cGzyA1X9YR4N4a2pPSBhWzn42j78yZI+nlg2zjnFUeE4AgFvvDHEh2V1oVMwttg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9682
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


On 01-04-2026 06:57 pm, Christian König wrote:
>
> On 3/31/26 15:46, Sunil Khatri wrote:
>> Function of amdgpu_userq_evict function do not need to check
>> for return values as we dont use them and no need to log errors
>> as we are already logging in called functions.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 ++++------------
>>   1 file changed, 4 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index a98118898832..1aeaa5662dda 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -1258,7 +1258,8 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>>   	}
>>   
>>   	if (ret)
>> -		drm_file_err(uq_mgr->file, "Couldn't unmap all the queues\n");
>> +		drm_file_err(uq_mgr->file,
>> +			     "Couldn't unmap all the queues, eviction failed ret=%d\n", ret);
>>   	return ret;
>>   }
>>   
>> @@ -1298,18 +1299,9 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>>   void
>>   amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr)
>>   {
>> -	struct amdgpu_device *adev = uq_mgr->adev;
>> -	int ret;
>> -
>>   	/* Wait for any pending userqueue fence work to finish */
>> -	ret = amdgpu_userq_wait_for_signal(uq_mgr);
> That confirms my suspicion that patch #1 would cause build failures when applied alone.
>
> Please re-order the patch before pushing them so that this one here comes first.
Sure Christian.

Thanks Sunil
>
> With that done Reviewed-by: Christian König <christian.koenig@amd.com>
>
> Regards,
> Christian.
>
>> -	if (ret)
>> -		dev_err(adev->dev, "Not evicting userqueue, timeout waiting for work\n");
>> -
>> -	ret = amdgpu_userq_evict_all(uq_mgr);
>> -	if (ret)
>> -		dev_err(adev->dev, "Failed to evict userqueue\n");
>> -
>> +	amdgpu_userq_wait_for_signal(uq_mgr);
>> +	amdgpu_userq_evict_all(uq_mgr);
>>   }
>>   
>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
