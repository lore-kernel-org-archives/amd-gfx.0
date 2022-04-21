Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478F4C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Apr 2022 11:00:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B411F10E771;
	Thu, 21 Apr 2022 11:00:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE5E410E771
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Apr 2022 11:00:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8b9LO6bYLDjamZ8/fR+EzJPPftRQ63IpPjj22D1fEicYKSvRuDlsxslO3h0pwJE3jY6e5WRPnZ3iOXNATw/Q1UZKv2IqXl3tqXfSd09wZo6eaKEHCe90pj0C6n7rEaIvg5uSYid+kV9hpBexqGfc3SqcWDVP0X5kv4EgQFrWseshWXj/UTBCErXr9940aHM2LWWVjoGjWVEVd+zg2EBJLHRdXbGkZHyJZcoj42uYSx5idsVASL50dqFItAHzXgi91cmu596VBWGA95ZIXp0iMMg5ERNywND5lceXZsw8I6Symo42Gk9/gGdqd9AfYM4oOh5TiYlzu4SW2TlzeMszw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PX17N4Vplj7N1JoGfG6gCRFcNw4PJEWUEWP/y67wyQ=;
 b=jkkTFbISPT9+Qdxn0GvRS6dz4o76Oaumj1pw3mNqd0oiatwI4ycfI36aZQLFRrWIIpwDsNHzpG7141YCfhH8jJeVTmFnRFn3aAuPZh7ehRJGG+rgKrVvCJBARB/dp4m6ueeO0Ml5dwbl3Slq0hTbsUNt7cVMOXjGkXjOsi3ZcEqP1PBi953ezq4zgKCU20TTl46UbYJJJQE2NqmIhrFrMlBACGsIYYljBpP97BjQx1qeka7RmYcAU2ZAWMw8pIuShottiM33SFVPS/w1JnKFtX3rH3ZXKQgaHqFnWTS/vtdS3d81+D/IcPE6pQrh42w8phtAEcfGtSQR0uIChqrQlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PX17N4Vplj7N1JoGfG6gCRFcNw4PJEWUEWP/y67wyQ=;
 b=EIIgdhSi/EFTsZ+0nk6UXfgEbBOPaKzFCr+Bq7AOEqVGHNL/1hYzF7NcgXtnjadNgqsYj/SB6yL/kukLYD7SrB8/AU2Aeq38cXUy6mDDrDFh/E03/lsiDIpRMFbpdkVsUdisp5NnZ+tfArwYoGYMARzO2xLBincKM89EJ3JHGfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM8PR12MB5397.namprd12.prod.outlook.com (2603:10b6:8:38::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.13; Thu, 21 Apr 2022 11:00:46 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::88f5:b843:e848:fcf]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::88f5:b843:e848:fcf%3]) with mapi id 15.20.5186.013; Thu, 21 Apr 2022
 11:00:46 +0000
Message-ID: <d1e31c22-517c-8d57-ad7f-03f00680ca8f@amd.com>
Date: Thu, 21 Apr 2022 16:30:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Add debugfs TA load/unload/invoke
 support
Content-Language: en-US
To: "Li, Candice" <Candice.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220420111357.9488-1-candice.li@amd.com>
 <20220420111357.9488-2-candice.li@amd.com>
 <a48beb99-5843-b457-9382-dd46d7b50ac5@amd.com>
 <CY4PR12MB149687204F4D9F1E7DEDEE3D91F49@CY4PR12MB1496.namprd12.prod.outlook.com>
 <17ab42d0-2629-21ae-0bdc-ddbc50acf6f6@amd.com>
 <CY4PR12MB14967E58DC7197CF1EBA814891F49@CY4PR12MB1496.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CY4PR12MB14967E58DC7197CF1EBA814891F49@CY4PR12MB1496.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0134.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::19) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d65bc1b-2462-44a3-d214-08da23862f76
X-MS-TrafficTypeDiagnostic: DM8PR12MB5397:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB53978FDDB7FE2980C23326B697F49@DM8PR12MB5397.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kZdwQrp1OJH8BGG+9XwlEormHS9A7LlvVC9euBaDvfIoFgQmmKVMKbvJiKMwxJVVimlqJs2eN9wmw4O2Np6eL8hWC6nh8wU8K9sJrLqRLK6S6lh9i2bQyLEaRnhLMLGwywAJCAXKgfChlhm/MYV23ek4N+sfEjrkJGkWOzrA/lDVGO1TkqeEF7mHj6/6YIwvoOuljsdiK11+MdSknxv5/Y45urJmFrQpVh4wQF5jopavSVNwROLzUeNcxc9ppiRSM/H05aYf8h75jboIV0f9/tLguJiUaUv0CwPLcZh+5fmjtnRoct/AKK5hTRMmf5ZotG9kmmGcBeeEmYGzqx7aXZWIUZpFcBogP+wrEArvp0JHwQO+Ex6qYywXS+tPfSxDu9Ap2RNofYod6XllHfIDq+MuTM8mktdYEWm53vmV7VYxx4csOBSrvI5/JouOEysKOlL8zIIz+n+ODJvNsTGZ5AKo267awHEjf6OIbtMaIOxbeEe2L93/aPMgXTS2afoNB44744uYnSzVdJghz16w5Y471RJte0EqvO2CcPiNdjqOgArW5GBXP3AOQiwZYqcsOUHvbUmxCLgG838q7Jrh2yAm0K7SoXNcllAPodL/HyZZTo7ezaYfgcjh4vnioo2oxCrct/muXYiR1KC+8sRWX/i52R+Ul1fWoi7x1bxOjt5zogqt9AeOOuq789OYakSq6WgqGu3apvyPduOrFXCV6Xeye6PftK4wDx9Q8MSHxgzHtPorfAH33Xz6KxdJzu1AKWBJ5wqeCRTxoaHu0juz/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(6506007)(6666004)(83380400001)(36756003)(316002)(6512007)(4326008)(8676002)(6486002)(508600001)(66556008)(31686004)(86362001)(31696002)(66476007)(110136005)(53546011)(30864003)(2906002)(2616005)(26005)(5660300002)(8936002)(186003)(38100700002)(461764006)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlhORElxVHRYVndNUklDL0Y1clpnVVhBTUZvYkcvSGlWOVkxVmxiTi93K0pz?=
 =?utf-8?B?VEpEaytHZDgyd2h0aExYNGppS2MzVEhFeFh2c21EdVkvUE1pbVFiWHlCZXNx?=
 =?utf-8?B?S256OWh1ZDhRQXZnTmZmSWh2R3Njb0t5SE5pRE1UN0c4Z1NTUFYrVCtYRkFB?=
 =?utf-8?B?MW95VHRQZnUyT2RiLzR3YUQyWDcxZnRmVlFmVUdsZGR6a3JEeU9sREhRNk5i?=
 =?utf-8?B?V0xDWGpablhCdjVVUnlLOEVCR1VQVWJQcTJpNUFWbTJ0Z1ZDS3dmVXZUTmIv?=
 =?utf-8?B?WGhCMk5IVEJPamNCWDQ2OU5maHp2aW5lT1FoeWdtcmR0a3E1TWUvalZKdzND?=
 =?utf-8?B?cGxKaDRLWHUvMDBHeE14MTQ4OXk3NkZXYjJQMnJseEx6Zm1tNXJyT3RNZVF5?=
 =?utf-8?B?MlM4VnJncHRkQTlkTDB3Z0ZnK3lsMjhudHdsTUdZeUlZcFU0RWpzK3Z3bWdt?=
 =?utf-8?B?dVpyTEdvSVd1Y2ZMckhBYmFrQzcwbmFOYmRLNEFob00rVXZnWUxPRXBnL2Mz?=
 =?utf-8?B?QVBkVDE2TzlZRFBQNlE4eGErQWNTQTdVeERpVmYwRU5GVFI3L1JkNVZxSHhR?=
 =?utf-8?B?TzB4b1R1TTBmTzgzcjhqQkJmWTA2Rk53V3dRb3lPSk5wV1piWnFxV2pOUW15?=
 =?utf-8?B?alJrYWJlZHFLQWhKNHpzWjhYaXZ1RHZNeHRvaU02cDBDQ21KRHdDZDNQOEts?=
 =?utf-8?B?M1RTVjlWKzQ1QSsvc3BqdURXVnBUclRyYmpsUUNHNFo3TExKMVFQT3dPMGly?=
 =?utf-8?B?UzdseUlYbUJJK1E2RU82dEE2N1Rma1JGUisycWhySHp6bksrbUxPYmc3RVBL?=
 =?utf-8?B?K3R4V2lWNm4wWXY5SGJMU2QyS3JWYTZNcGpUTm9MSWdqdS9xYjg0am13aUV4?=
 =?utf-8?B?dmx5ellHVEo1OFZjeFpoKzlxYXdNbXRqd3p2dEdqdWx5NFdmRFdyNUJ4VGx6?=
 =?utf-8?B?ZG9CT245SDJvOG9McFBKVHpBN2lwdXRzRXJzblVQU2Q2OHdpVldEcjRVYXlr?=
 =?utf-8?B?MlIvUSt4d01qU1kwbFVObDlvNGFwdW9UOXEvZGtkYVJPY21ya1NhM0NmSzVW?=
 =?utf-8?B?bGZjcE1NWGF1clNIQ1JQNlp6NlZOdWNsWjM2YjRTOUpFV213dUlWT1dnVlda?=
 =?utf-8?B?NFpwTGFQU1JnR1dFNFB1SzdpVlJUV29sWkRNbFIvamVENFFlZytvbTRpbEZC?=
 =?utf-8?B?cmtldk9xclBVNDBZanZkTHZmWmwzR2R2Z1VBOUJBT3NTd0JyZlVRL1BqVmkr?=
 =?utf-8?B?YUZKU3M4MGlQYkhQTHFoNDlZTjZTd1NsWkJJZXdsa25TV2ZKNThoZTlaOWpX?=
 =?utf-8?B?ZFNkTFpOZmNteEZIOGhMcUNDME56S0tIbDdwV2RGbHNpdDJmQWgxVHRabmdX?=
 =?utf-8?B?Z1pHcWdUemtrTjVFbWZrck82cW5weEtBU0RmTitCOXVXeWVXVXVUN2ttNENk?=
 =?utf-8?B?Q1FORkY0RFlySmhPUkNJczdOQ1VGN05VRjBzb2NxaGdZMlduSGpRaWtBMU5j?=
 =?utf-8?B?R3FrY3BsbXZUM0VIOEo5QlI1eXJkRnBzTlJBaDNtbHJkNkZKaDUrU09Tb2ZQ?=
 =?utf-8?B?U2ZGUEVhNk5MeTRZNkpMeFBhbHJ5V3VXdG9qTmNzTnZwUHBLVGVYS3JsN3Nj?=
 =?utf-8?B?TTNjT1BPSiszT3B6MkpGVGZZdi9BV01xQTFWM0NyeVZvUEhBNEdTWXVUYWtH?=
 =?utf-8?B?anFhSmdZM1l2RzBWbUZ4eWkvOEwxYzNPVE5lcXlRUThMM3JlYzhWM0JxZi9V?=
 =?utf-8?B?QWdwY1pMaU5pRENXZW0vS0g3WVpWbjVheEVtN0tvbThLRG9BUlJwZXZNdS93?=
 =?utf-8?B?VG9uTXhhVGsvUHQ3QjdoREtZOEhoYlZseHhGeTdORE8vZlRFb0hEdEtJNWdJ?=
 =?utf-8?B?bHJxaml5OVJSS0lDZGZ3dW1OS29RMGJhZkwwSHZrb3RNN1dGNlFjTCtHQ21w?=
 =?utf-8?B?Rmp2cVd1SFBFT1NoajIzQW5ObUxSYUtub0l2TS9kYjl4M0hsTWgwN1hORXFs?=
 =?utf-8?B?eVFWZDhSbnI0MWFQVWpweDBGLzRWUzhVYkhtVFV1OVNGYjBGTlNFQjFuTkVL?=
 =?utf-8?B?cjNwbmM3dllzanlYUVkwajdwQ2xqc2RMaUcrdEFTdXRvcE5KMk1NTUFaNUhr?=
 =?utf-8?B?MCs2Q0hKY3JJQ3N2QzBMZnd5SGVHVXhpZFdMK3FaSVIrSHF5WlpsU0tVd01p?=
 =?utf-8?B?RndnaWhxcVlJZFlBYkU3bmJ2M3N5VUhTVmt4R1luV3hpWXJ5cFdHeVk0Q0VE?=
 =?utf-8?B?emtYN2orcDdBR0IxN2VpelFVMUtvMHhEcHdUOENIMHJVNWhYU1RrYitsY0hk?=
 =?utf-8?B?RmpMNS9ZMVJLSGMrVVdHY2x3RWdodERLTGh3UDlwZWgxVGl0L29Xdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d65bc1b-2462-44a3-d214-08da23862f76
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 11:00:45.9783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Ei9rQhflVizY3uKcDooQGmB9j9bLymVpKliuB/rNNZ/Pquyc8mYZPf3PPTY3dg1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5397
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
Cc: "Clements, John" <John.Clements@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 4/21/2022 4:08 PM, Li, Candice wrote:
> [Public]
> 
> 
> 
> 
> 
> Thanks,
> Candice
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, April 21, 2022 6:03 PM
> To: Li, Candice <Candice.Li@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Clements, John <John.Clements@amd.com>
> Subject: Re: [PATCH v2 2/2] drm/amdgpu: Add debugfs TA load/unload/invoke support
> 
> 
> 
> On 4/21/2022 3:28 PM, Li, Candice wrote:
>> [Public]
>>
>>
>>
>>
>>
>> Thanks,
>> Candice
>>
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, April 21, 2022 5:23 PM
>> To: Li, Candice <Candice.Li@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Clements, John <John.Clements@amd.com>
>> Subject: Re: [PATCH v2 2/2] drm/amdgpu: Add debugfs TA load/unload/invoke support
>>
>>
>>
>> On 4/20/2022 4:43 PM, Candice Li wrote:
>>> v1:
>>> Add debugfs support to load/unload/invoke TA in runtime.
>>>
>>> v2:
>>> 1. Update some variables to static.
>>> 2. Use PAGE_ALIGN to calculate shared buf size directly.
>>> 3. Remove fp check.
>>> 4. Update debugfs from read to write.
>>>
>>> Signed-off-by: John Clements <john.clements@amd.com>
>>> Signed-off-by: Candice Li <candice.li@amd.com>
>>> ---
>>>     drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c  | 308 ++++++++++++++++++++
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h  |  30 ++
>>>     4 files changed, 341 insertions(+), 1 deletion(-)
>>>     create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
>>>     create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
>>> index 7d7af43a258f83..b525f9be9326f4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>> @@ -58,7 +58,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>>>     	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
>>>     	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>>>     	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>>> -	amdgpu_eeprom.o amdgpu_mca.o
>>> +	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o
>>>     
>>>     amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>>>     
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index 13e4d8f9b87449..eedb12f6b8a32d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -38,6 +38,7 @@
>>>     #include "amdgpu_umr.h"
>>>     
>>>     #include "amdgpu_reset.h"
>>> +#include "amdgpu_psp_ta.h"
>>>     
>>>     #if defined(CONFIG_DEBUG_FS)
>>>     
>>> @@ -1767,6 +1768,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>     		DRM_ERROR("registering register debugfs failed (%d).\n", r);
>>>     
>>>     	amdgpu_debugfs_firmware_init(adev);
>>> +	amdgpu_ta_if_debugfs_init(adev);
>>>     
>>>     #if defined(CONFIG_DRM_AMD_DC)
>>>     	if (amdgpu_device_has_dc_support(adev))
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
>>> new file mode 100644
>>> index 00000000000000..247a476e63544c
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
>>> @@ -0,0 +1,308 @@
>>> +/*
>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person obtaining a
>>> + * copy of this software and associated documentation files (the "Software"),
>>> + * to deal in the Software without restriction, including without limitation
>>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>>> + * and/or sell copies of the Software, and to permit persons to whom the
>>> + * Software is furnished to do so, subject to the following conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>> + *
>>> + */
>>> +
>>> +#include "amdgpu.h"
>>> +#include "amdgpu_psp_ta.h"
>>> +
>>> +static const char *TA_IF_FS_NAME = "ta_if";
>>> +
>>> +struct dentry *dir;
>>> +static struct dentry *ta_load_debugfs_dentry;
>>> +static struct dentry *ta_unload_debugfs_dentry;
>>> +static struct dentry *ta_invoke_debugfs_dentry;
>>> +
>>> +static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf,
>>> +					    size_t len, loff_t *off);
>>> +static ssize_t ta_if_unload_debugfs_write(struct file *fp, const char *buf,
>>> +					    size_t len, loff_t *off);
>>> +static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf,
>>> +					    size_t len, loff_t *off);
>>> +
>>> +
>>> +static uint32_t get_bin_version(const uint8_t *bin)
>>> +{
>>> +	const struct common_firmware_header *hdr =
>>> +			     (const struct common_firmware_header *)bin;
>>> +
>>> +	return hdr->ucode_version;
>>> +}
>>> +
>>> +static void prep_ta_mem_context(struct psp_context *psp,
>>> +					     struct ta_context *context,
>>> +					     uint8_t *shared_buf,
>>> +					     uint32_t shared_buf_len)
>>> +{
>>> +	context->mem_context.shared_mem_size = PAGE_ALIGN(shared_buf_len);
>>> +	psp_ta_init_shared_buf(psp, &context->mem_context);
>>> +
>>> +	memcpy((void *)context->mem_context.shared_buf, shared_buf, shared_buf_len);
>>> +}
>>> +
>>> +static bool is_ta_type_valid(enum ta_type_id ta_type)
>>> +{
>>> +	bool ret = false;
>>> +
>>> +	switch (ta_type) {
>>> +	case TA_TYPE_RAS:
>>> +		ret = true;
>>> +		break;
>>> +	default:
>>> +		break;
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static const struct file_operations ta_load_debugfs_fops = {
>>> +	.write   = ta_if_load_debugfs_write,
>>> +	.llseek = default_llseek,
>>> +	.owner  = THIS_MODULE
>>> +};
>>> +
>>> +static const struct file_operations ta_unload_debugfs_fops = {
>>> +	.write   = ta_if_unload_debugfs_write,
>>> +	.llseek = default_llseek,
>>> +	.owner  = THIS_MODULE
>>> +};
>>> +
>>> +static const struct file_operations ta_invoke_debugfs_fops = {
>>> +	.write   = ta_if_invoke_debugfs_write,
>>> +	.llseek = default_llseek,
>>> +	.owner  = THIS_MODULE
>>> +};
>>> +
>>> +
>>> +/**
>>> + * DOC: AMDGPU TA debugfs interfaces
>>> + *
>>> + * Three debugfs interfaces can be opened by a program to
>>> + * load/invoke/unload TA,
>>> + *
>>> + * - /sys/kernel/debug/dri/<N>/ta_if/ta_load
>>> + * - /sys/kernel/debug/dri/<N>/ta_if/ta_invoke
>>> + * - /sys/kernel/debug/dri/<N>/ta_if/ta_unload
>>> + *
>>> + * How to use the interfaces in a program?
>>> + *
>>> + * A program needs to provide transmit buffer to the interfaces
>>> + * and will receive buffer from the interfaces below,
>>> + *
>>> + * - For TA load debugfs interface:
>>> + *   Transmit buffer:
>>> + *    - TA type (4bytes)
>>> + *    - TA bin length (4bytes)
>>> + *    - TA bin
>>> + *   Receive buffer:
>>> + *    - TA ID (4bytes)
>>> + *
>>> + * - For TA invoke debugfs interface:
>>> + *   Transmit buffer:
>>> + *    - TA ID (4bytes)
>>> + *    - TA CMD ID (4bytes)
>>> + *    - TA shard buf length (4bytes)
>>> + *    - TA shared buf
>>> + *   Receive buffer:
>>> + *    - TA shared buf
>>> + *
>>> + * - For TA unload debugfs interface:
>>> + *   Transmit buffer:
>>> + *    - TA ID (4bytes)
>>> + */
>>> +
>>> +static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf, size_t len, loff_t *off)
>>> +{
>>> +	uint32_t ta_type    = 0;
>>> +	uint32_t ta_bin_len = 0;
>>> +	uint8_t  *ta_bin    = NULL;
>>> +	uint32_t copy_pos   = 0;
>>> +	int      ret        = 0;
>>> +
>>> +	struct amdgpu_device *adev   = (struct amdgpu_device *)file_inode(fp)->i_private;
>>> +	struct psp_context   *psp    = &adev->psp;
>>> +	struct ta_context    context = {0};
>>> +
>>> +	if (!buf)
>>> +		return -EINVAL;
>>> +
>>> +	ret = copy_from_user((void *)&ta_type, &buf[copy_pos], sizeof(uint32_t));
>>> +	if (ret || (!is_ta_type_valid(ta_type)))
>>> +		return -EINVAL;
>>> +
>>> +	copy_pos += sizeof(uint32_t);
>>> +
>>> +	ret = copy_from_user((void *)&ta_bin_len, &buf[copy_pos], sizeof(uint32_t));
>>> +	if (ret)
>>> +		return -EINVAL;
>>> +
>>> +	copy_pos += sizeof(uint32_t);
>>> +
>>> +	ta_bin = kzalloc(ta_bin_len, GFP_KERNEL);
>>> +	if (!ta_bin)
>>> +		ret = -ENOMEM;
>>> +	ret = copy_from_user((void *)ta_bin, &buf[copy_pos], ta_bin_len);

Missed another point here - during your tests, do you see the write 
calls coming multiple times while passing TA binary from userspace? 
Usually libc maintains buffers and if the size of the file is large,  it 
will be calling write multiple times with different offsets.

 From the code, it looks like there is an assumption that TAs are small 
enough that the entire TA can be passed in one shot.

Thanks,
Lijo

>>> +	if (ret)
>>> +		goto err_free_bin;
>>> +
>>> +	ret = psp_ras_terminate(psp);
>>> +	if (ret) {
>>> +		dev_err(adev->dev, "Failed to unload embedded RAS TA\n");
>>> +		goto err_free_bin;
>>> +	}
>>> +
>>> +	context.ta_type             = ta_type;
>>> +	context.ta_load_type        = GFX_CMD_ID_LOAD_TA;
>>> +	context.bin_desc.fw_version = get_bin_version(ta_bin);
>>> +	context.bin_desc.size_bytes = ta_bin_len;
>>> +	context.bin_desc.start_addr = ta_bin;
>>> +
>>> +	ret = psp_ta_load(psp, &context);
>>> +
>>> +	if (ret || context.resp_status) {
>>> +		dev_err(adev->dev, "TA load via debugfs failed (%d) status %d\n",
>>> +			 ret, context.resp_status);
>>> +		goto err_free_bin;
>>> +	}
>>> +
>>> +	context.initialized = true;
>>> +	ret = copy_to_user((char *)buf, (void *)&context.session_id, sizeof(uint32_t));
>>> +
>>> +err_free_bin:
>>> +	kfree(ta_bin);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static ssize_t ta_if_unload_debugfs_write(struct file *fp, const char *buf, size_t len, loff_t *off)
>>> +{
>>> +	uint32_t ta_id  = 0;
>>> +	int      ret    = 0;
>>> +
>>> +	struct amdgpu_device *adev   = (struct amdgpu_device *)file_inode(fp)->i_private;
>>> +	struct psp_context   *psp    = &adev->psp;
>>> +	struct ta_context    context = {0};
>>> +
>>> +	if (!buf)
>>> +		return -EINVAL;
>>> +
>>> +	ret = copy_from_user((void *)&ta_id, buf, sizeof(uint32_t));
>>> +	if (ret)
>>> +		return -EINVAL;
>>> +
>>> +	context.session_id = ta_id;
>>> +
>>> +	ret = psp_ta_unload(psp, &context);
>>> +	if (!ret)
>>> +		context.initialized = false;
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size_t len, loff_t *off)
>>> +{
>>> +	uint32_t ta_id          = 0;
>>> +	uint32_t cmd_id         = 0;
>>> +	uint32_t shared_buf_len = 0;
>>> +	uint8_t	 *shared_buf    = NULL;
>>> +	uint32_t copy_pos       = 0;
>>> +	int      ret            = 0;
>>> +
>>> +	struct amdgpu_device *adev   = (struct amdgpu_device *)file_inode(fp)->i_private;
>>> +	struct psp_context   *psp    = &adev->psp;
>>> +	struct ta_context    context = {0};
>>> +
>>> +	if (!buf)
>>> +		return -EINVAL;
>>> +
>>> +	ret = copy_from_user((void *)&ta_id, &buf[copy_pos], sizeof(uint32_t));
>>> +	if (ret)
>>> +		return -EINVAL;
>>> +	copy_pos += sizeof(uint32_t);
>>> +
>>> +	ret = copy_from_user((void *)&cmd_id, &buf[copy_pos], sizeof(uint32_t));
>>> +	if (ret)
>>> +		return -EINVAL;
>>> +	copy_pos += sizeof(uint32_t);
>>> +
>>> +	ret = copy_from_user((void *)&shared_buf_len, &buf[copy_pos], sizeof(uint32_t));
>>> +	if (ret)
>>> +		return -EINVAL;
>>> +	copy_pos += sizeof(uint32_t);
>>> +
>>> +	shared_buf = kzalloc(shared_buf_len, GFP_KERNEL);
>>> +	if (!shared_buf)
>>> +		ret = -ENOMEM;
>>> +	ret = copy_from_user((void *)shared_buf, &buf[copy_pos], shared_buf_len);
>>> +	if (ret)
>>> +		goto err_free_shared_buf;
>>> +
>>> +	context.session_id = ta_id;
>>> +
>>> +	prep_ta_mem_context(psp, &context, shared_buf, shared_buf_len);
>>> +
>>> +	ret = psp_ta_invoke_indirect(psp, cmd_id, &context);
>>> +
>>> +	if (ret || context.resp_status) {
>>> +		dev_err(adev->dev, "TA invoke via debugfs failed (%d) status %d\n",
>>> +			 ret, context.resp_status);
>>> +		goto err_free_ta_shared_buf;
>>> +	}
>>> +
>>> +	ret = copy_to_user((char *)buf, context.mem_context.shared_buf, shared_buf_len);
>>> +
>>> +err_free_ta_shared_buf:
>>> +	psp_ta_free_shared_buf(&context.mem_context);
>>> +
>>> +err_free_shared_buf:
>>> +	kfree(shared_buf);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static struct dentry *amdgpu_ta_if_debugfs_create(struct amdgpu_device *adev)
>>> +{
>>> +	struct drm_minor *minor = adev_to_drm(adev)->primary;
>>> +
>>> +	dir = debugfs_create_dir(TA_IF_FS_NAME, minor->debugfs_root);
>>> +
>>> +	ta_load_debugfs_dentry = debugfs_create_file("ta_load", 0200, dir, adev,
>>> +						     &ta_load_debugfs_fops);
>>> +
>>> +	ta_unload_debugfs_dentry = debugfs_create_file("ta_unload", 0200, dir,
>>> +						     adev, &ta_unload_debugfs_fops);
>>> +
>>> +	ta_invoke_debugfs_dentry = debugfs_create_file("ta_invoke", 0200, dir,
>>> +						     adev, &ta_invoke_debugfs_fops);
>>
>> This uses global variables, is this tested on a system with multiple GPUs?
>>
>> Thanks,
>> Lijo
>>
>> [Candice] Yes, it has been tested on mGPU system and works.
>>
> 
> Did you also cover amdgpu_ta_if_debugfs_remove() during your tests? I'm
> wondering how it removes the directory of all devices as by above logic
> 'dir' will always point to the entry of the last probed device.
> 
> Thanks,
> Lijo
> 
> [Candice] That's a good point. Not yet for degbufs remove function, it has not been called in the initial patch.
> 
>>> +	return dir;
>>> +}
>>> +
>>> +void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev)
>>> +{
>>> +#if defined(CONFIG_DEBUG_FS)
>>> +	dir = amdgpu_ta_if_debugfs_create(adev);
>>> +#endif
>>> +}
>>> +
>>> +void amdgpu_ta_if_debugfs_remove(void)
>>> +{
>>> +	debugfs_remove_recursive(dir);
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h
>>> new file mode 100644
>>> index 00000000000000..883f89d57616d0
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h
>>> @@ -0,0 +1,30 @@
>>> +/*
>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person obtaining a
>>> + * copy of this software and associated documentation files (the "Software"),
>>> + * to deal in the Software without restriction, including without limitation
>>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>>> + * and/or sell copies of the Software, and to permit persons to whom the
>>> + * Software is furnished to do so, subject to the following conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>> + *
>>> + */
>>> +
>>> +#ifndef __AMDGPU_PSP_TA_H__
>>> +#define __AMDGPU_PSP_TA_H__
>>> +
>>> +void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev);
>>> +void amdgpu_ta_if_debugfs_remove(void);
>>> +
>>> +#endif
>>>
