Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C149ECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Sep 2022 14:31:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4F3F10E58E;
	Mon, 12 Sep 2022 14:31:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A266F10E58F
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 14:31:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECxUTUNXjLSCimUv9qRd3EahMLuqIZtzZk88YphJih2ar4i3KTxYbpUFuR4aAM6/UOypLJ6sKMLl0dbGB/9O04/au98jZpCx3Qv+Y96UDMFNAkDxwtgUITJc9tXzWVmiSToXOIBixkPfERR9SkzxxojY5WPiNWCZdDcRCzpZAgwFLfA9a0lxf+Poy7aqJDJgDxVjA2g8F0pzk3LDYytCdlMQRedi/2RjxU71nJLU7Tbj7N/kZHlJfssMJOQvZJGKDRDN4emcSUY/OzljJt+8g5kHyIPclnfnj534erCnSdUQh5Hbgh/WS0RK6zoDgbzwnbN2spNfKz1w+9ZNxxp1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZ4S/K/SRqr4ZOVTlwfstGXK+xZpe3GlYaNnXk+4aoM=;
 b=J6lm88dHB6C7hlv3nw6bkmz41gbcfr6YojxCHca8S+09GdmP7oWE+JzPMdsro7sxJhq6ms5JRM2buaG3kBkBRtozTqDXn7ikzEKNNgz7xSPKpJsJywkng3J9V6qMmO8d5k2FQSRg2zBj+FPGeTR6MMCwGGBrNssT4xyw1APgF3UYeQUfZ+dKkMrLYMhIDlpEd5Q3w/4laOuhZ0l8E0i6sgVnzylRzmRo11sTT0gAXWn79jftwygYa3nyIDwj0EjQ9QYmYzKm+jyiguXH9UEadFYHuYHHjeVFSpq7pOYTNJr7jR0QIB9ZMXD6PNEWyvtiY+gi0VdIPA7IyGYVXoXdaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZ4S/K/SRqr4ZOVTlwfstGXK+xZpe3GlYaNnXk+4aoM=;
 b=2mEhmBmDY+pxG7lJHxFxpaQuGeAb+RqBvrF4cCftKk74dDQ9vWzt8D1eIPgRJDYuFnwlZsVUAkQKdF44uJkLQqyOSPF8mZUvHcErW5aJPXWWssy7Hafcurfu5pMERVtJLOiwzoXYyoMfVl35QdXLBs1HY0gxTgE+rrpymlrPuU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 PH8PR12MB6892.namprd12.prod.outlook.com (2603:10b6:510:1bc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Mon, 12 Sep
 2022 14:31:39 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::c549:82d4:60d9:2a8a]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::c549:82d4:60d9:2a8a%3]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 14:31:39 +0000
Message-ID: <e1d450ae-f5e7-41de-96b6-c7870953ecbf@amd.com>
Date: Mon, 12 Sep 2022 10:31:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/4] drm/amdgpu: Introduce gfx software ring(v3)
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
References: <20220909015022.557099-1-jiadong.zhu@amd.com>
 <5c0a4135-72e3-184f-e581-8e1fe222597d@gmail.com>
Content-Language: en-CA
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <5c0a4135-72e3-184f-e581-8e1fe222597d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::10) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|PH8PR12MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: f3063245-5c2f-49a7-be82-08da94cb813c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DuM1xR9kQXwLJraz0QnH8IZMWj10coPTVnXme1IGVFKdUDdrYrJrHqSeq0tDvL43BXwols8yyrTFBkpvkm/aRfVaRJjyoVOj+wA6oWGdkpl5OwHLG7Ee+EB1/2Z1Uo7Ny2FamIiZSq9i0IfZLochtzd1TPgTn58uV7EfpnbmUra7cK7N+nGk5uYUT/ZqRPofiSgMYtiFf3G9b9ajtS2TZOnJxfBWfWGXQUoNWPD12fYpN31biQErSZo+9qQvN7okfvUQwxTPjUUbfHKVnGA243AP36sFkgB+QbPa6MKP1+CPmN8TH8uvxjjzUVOUkzfAr6t/guGbmIumHYhGbz1B5KQv9ELZWijR2l4f9BL0rZm22/YXP8d6si0Q7YQJEU4YO5XneZqEBRziV9saMqnPERybjM/3xgXo6O7QQzNJCee+hf2y973ucJXhnlxVB/IQhkW9Mw0WOUhtNYIA6rlrNQDXkGLb/Uc9lTA8EjRjk33thAxFcdtdiC7KaVzPtCeNzCDo+DooT6XLk5Ha4y2rW2/60Gjf8GSKtyvszJdln7x0JDi6HJZ2LLKht0+tUpQF5G2mp9DEu/cFl48OLOSdxfXwdOjDMcESFY8Bi5ooEZTlYhWk30AMi0UbjA9u11ojChn5qXgkaWUcffDW76S1grrVp1UqzXBzasGgun6hJsGDVS5z6RzryJIuNu+aknbn+ooP2k+WOscTicbaN1Rw/lrPaX7hl6s+C1gNMvZqabNjlgL/xKCocndUv+c9/KSIKAMRIl4lBuw+Lpclf21bF9YwRr8r9ebg74JUBCT/aJ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(36756003)(30864003)(5660300002)(4326008)(53546011)(31686004)(66556008)(66476007)(8936002)(26005)(6512007)(66946007)(38100700002)(2906002)(44832011)(6486002)(6506007)(8676002)(110136005)(31696002)(6636002)(66574015)(186003)(2616005)(86362001)(41300700001)(316002)(83380400001)(6666004)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a212dWwxMFkyTkVxVUJUS210amswVkxrYzRFOTFndVUxTmxEa2I2Ymw1akVM?=
 =?utf-8?B?dW9na01kek5yVk5YaWpRSkcvemFwd3Rnek5UWDE2eUd4RG10SGx1YXg5THZX?=
 =?utf-8?B?Vk1QdkpNcG1LeS9oWmhUcFVuK2s4KzRaMHQyUCttZW12eUFLN0ZFVURMb2F5?=
 =?utf-8?B?bFdVMWE0REcvcFBwVlNYMjdkUlErS1kwbklCQUs1Wkt0a2pYY2xUN1A2c2dS?=
 =?utf-8?B?SDl6dU1Ja215L3RMcmRDSXhUN0luN3loNG8wUDNiTzA4ZlNpNnpwVWxpS2hk?=
 =?utf-8?B?M0RJL2VLcytyb09meFcxaENsNDFsS3Q2RHoxc1lDSUV6eGRSdi9na2Rna2ky?=
 =?utf-8?B?QTM2UEU4RE9yMmtYV2M3UUV1dGJoRkdpeEFaUkNnVW9Bcmg2SSswWWdZZ0sw?=
 =?utf-8?B?NzA3RFBsSkJ0ZzVhQmQ4SWFFR2g0YlI5TEcxNGl4enpXc0tZcTlsaGRuTHFZ?=
 =?utf-8?B?TEEzZlRzL2tpRThQS3ZuL0cwK2c4U2c5ZmVRUURXZWFEV2R2SWZYd3BkeGVh?=
 =?utf-8?B?YmJYaHh2eW1zb01lRFNlVDZxc3pJTXVLYkwzR2gwN3V6TVcwcWJLamhtc1A4?=
 =?utf-8?B?WGtESE1WSXFNTVRndXN4Q1RHV05VK1pNUE8wdi9hSWZyWmpMa2JUVTd1V0ty?=
 =?utf-8?B?Qmg4R0tDak5pNWxONUp6WEk4bEJRNHdPdEZqVFRzTk5jTEpkWEZIeVh2bnYr?=
 =?utf-8?B?R08xampicCttM1hGL3lScGV3T3dCc3ZBRG9POFpUTy9GSnF5RTJJWHVaNDJz?=
 =?utf-8?B?ak1XT0xvTTE2Ym9wU0s0MytmQStaclpKSlk5T0c3eEp5eEd4UmdEckRSNTRX?=
 =?utf-8?B?clhKc3hUeHVtNFlzQ0VhYTE1TFRkbVd1MXA4NlhGVUtPZlMrUTAzSmtZNTd6?=
 =?utf-8?B?ZHp2S09ZTm1FcjZJbkMrUFpjRW0wbnNoWjFkc2tka293MlltUkszRk5kc1lH?=
 =?utf-8?B?VHY3OTFWSWppNDdyL1JleXAzaEoxaStMRXN6R3UxVGtTeVV3UXEvODEveVlq?=
 =?utf-8?B?dW5IMXg5SXVqQUdTUnd2bE1rbVQ3djdnYmtWeGlNd3ZJWlJUdTRsZzhQb0Ez?=
 =?utf-8?B?Ujl4U2VrQjVudDgwV2RqRjFnMy9sMDc0Y0IwR2w4VUErV29HUmJ1Rmw3blZK?=
 =?utf-8?B?U0Y0OWVIRDhYZmg4bVVXY0JFVS95NFE2T0M4VVkwQmNRZVpuS1M1SndGNENz?=
 =?utf-8?B?b2p6ZTlhaVNtT2Q1U21WQ0YwYTd1eDNCMXFUaGpJaGZYenZPd1dIaDhxLzI0?=
 =?utf-8?B?MTNaQmxWT1NFOHlob0pGMGxPOWEwMU1vZzNkSWRMTExWdytPRXUxVjlnZG1R?=
 =?utf-8?B?VjNDelNJN0p3Y2NKV1RwTi9lcnhQMEk5aWl3WjVZSjFyNVdEWU9ia2JkYldF?=
 =?utf-8?B?VkpuNkRGb1FFWTU5QkhEVEVDR084WW1yZWNJcnhRaWlOVXFmc2xwcDgyRlpx?=
 =?utf-8?B?bzhTSnExWk8wNWZ2a29lL1FlK01Ya2hraVVVc0hVS3QyS3hNVWpmUUpvVEtq?=
 =?utf-8?B?L2NtN0VzK3FacGk0WjFrWVA4MzgvK1RkdzEvYWg5eHMweHJ4aVhKcXNHejBr?=
 =?utf-8?B?dTlBeVc3ejYydFV1MkhuUE5YZUc0ZTUzR1lHWUpiMkF2Zkp3NFc0ZlhJb2J0?=
 =?utf-8?B?eTF5VHd0ZkF5N0h6c1JZWWRBbFcxY0dOVHNNNXZ5VFp4UmVud2tNRXcvU3RM?=
 =?utf-8?B?WnFsREQxT0RIMk0yU0NhU2RWWFpSREFOb1pubUR3T3JXYXpkbFgrSUdnT3VZ?=
 =?utf-8?B?bHJhZVRwQk0yakY0VWJsOVBCQmdqL0ZqY0NiM3YvQUhyL2IycVl2YXEvalRG?=
 =?utf-8?B?NnpsS0FnckFYRHdiOGZld0hMbDJLdHkzbFZpYW1VWUFrRzJTOGw5ZnMxZEdq?=
 =?utf-8?B?bjBnTm9GN1JwSk5QckVTN1lnWENTaWNCTTB1MCsvSklrRHExZGQ0Y2RYRFFk?=
 =?utf-8?B?S21OR3dIQloxc29MOWlHRk9vM2RienQxNTNtUVp6NkJZVXZ5YW13QWhZOURQ?=
 =?utf-8?B?QWsyMHpDVzZyWitBUTBaNXNlQzE1bjY3ZnNvUXVFeUk0am96V09PTFRmRXpF?=
 =?utf-8?B?Z1NQdXFXRExJbFZvTTI3UmY3K1Q0ZERaR2FXeDRrT2RJTy9wQzRadEwzN2xJ?=
 =?utf-8?Q?leJ3J8QDBLPQeTC6TIl7MXe7l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3063245-5c2f-49a7-be82-08da94cb813c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 14:31:39.6360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VuOf4sXtvKb1GQQLc52dsuamlMhPUmdSqgUTMkDP/p0S91LN5Cury8UzFVSVEhCZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6892
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
Cc: Ray.Huang@amd.com, jiadong.zhu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No problem Christian--will do today. Thanks.

Regards,
Luben

On 2022-09-09 10:24, Christian König wrote:
> Andrey and Luben please take a look at this set here and help with 
> reviewing it.
> 
> Thanks,
> Christian.
> 
> Am 09.09.22 um 03:50 schrieb jiadong.zhu@amd.com:
>> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>>
>> The software ring is created to support priority
>> context while there is only one hardware queue
>> for gfx.
>>
>> Every software rings has its fence driver and could
>> be used as an ordinary ring for the gpu_scheduler.
>> Multiple software rings are binded to a real ring
>> with the ring muxer. The packages committed on the
>> software ring are copied to the real ring.
>>
>> v2: use array to store software ring entry.
>> v3: remove unnecessary prints.
>>
>> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile          |   3 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h      |   3 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   3 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 182 +++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  67 ++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c  | 204 +++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h  |  48 +++++
>>   7 files changed, 509 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 3e0e2eb7e235..85224bc81ce5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -58,7 +58,8 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>>   	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
>>   	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>>   	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>> -	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o
>> +	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
>> +	amdgpu_sw_ring.o amdgpu_ring_mux.o
>>   
>>   amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> index 53526ffb2ce1..0de8e3cd0f1c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> @@ -33,6 +33,7 @@
>>   #include "amdgpu_imu.h"
>>   #include "soc15.h"
>>   #include "amdgpu_ras.h"
>> +#include "amdgpu_ring_mux.h"
>>   
>>   /* GFX current status */
>>   #define AMDGPU_GFX_NORMAL_MODE			0x00000000L
>> @@ -346,6 +347,8 @@ struct amdgpu_gfx {
>>   	struct amdgpu_gfx_ras		*ras;
>>   
>>   	bool				is_poweron;
>> +
>> +	struct amdgpu_ring_mux			muxer;
>>   };
>>   
>>   #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> index 7d89a52091c0..fe33a683bfba 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> @@ -278,6 +278,9 @@ struct amdgpu_ring {
>>   	bool			is_mes_queue;
>>   	uint32_t		hw_queue_id;
>>   	struct amdgpu_mes_ctx_data *mes_ctx;
>> +
>> +	bool			is_sw_ring;
>> +
>>   };
>>   
>>   #define amdgpu_ring_parse_cs(r, p, job, ib) ((r)->funcs->parse_cs((p), (job), (ib)))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>> new file mode 100644
>> index 000000000000..ea4a3c66119a
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>> @@ -0,0 +1,182 @@
>> +/*
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#include <drm/drm_print.h>
>> +
>> +#include "amdgpu_ring_mux.h"
>> +#include "amdgpu_ring.h"
>> +
>> +#define AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT (HZ/2)
>> +
>> +static int copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
>> +	u64 s_begin, u64 s_end);
>> +
>> +int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
>> +{
>> +	mux->real_ring = ring;
>> +	memset(mux->ring_entries, 0, sizeof(mux->ring_entries));
>> +	mux->num_ring_entries = 0;
>> +	spin_lock_init(&mux->lock);
>> +	return 0;
>> +}
>> +
>> +void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux)
>> +{
>> +	memset(mux->ring_entries, 0, sizeof(mux->ring_entries));
>> +	mux->num_ring_entries = 0;
>> +}
>> +
>> +int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
>> +{
>> +	struct amdgpu_mux_entry *e;
>> +
>> +	if (mux->num_ring_entries == AMDGPU_MAX_GFX_RINGS) {
>> +		DRM_ERROR("adding sw ring exceeds max gfx num\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	e = &mux->ring_entries[mux->num_ring_entries++];
>> +
>> +	e->ring = ring;
>> +	e->start_ptr_in_hw_ring = 0;
>> +	e->end_ptr_in_hw_ring = 0;
>> +	e->sw_cptr = 0;
>> +	e->sw_rptr = 0;
>> +	e->sw_wptr = 0;
>> +
>> +	return 0;
>> +}
>> +
>> +static struct amdgpu_mux_entry *amdgpu_get_sw_entry(struct amdgpu_ring_mux *mux,
>> +				struct amdgpu_ring *ring)
>> +{
>> +	struct amdgpu_mux_entry *e;
>> +	int i;
>> +
>> +	e = NULL;
>> +	for (i = 0; i < mux->num_ring_entries; i++) {
>> +		if (mux->ring_entries[i].ring == ring) {
>> +			e = &mux->ring_entries[i];
>> +			break;
>> +		}
>> +	}
>> +
>> +	return e;
>> +}
>> +
>> +void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring, u64 wptr)
>> +{
>> +	struct amdgpu_mux_entry *e;
>> +
>> +	e = amdgpu_get_sw_entry(mux, ring);
>> +	if (!e) {
>> +		DRM_ERROR("cannot find entry for sw ring\n");
>> +		return;
>> +	}
>> +
>> +	spin_lock(&mux->lock);
>> +	e->sw_cptr = e->sw_wptr;
>> +	e->sw_wptr = wptr;
>> +	e->start_ptr_in_hw_ring = mux->real_ring->wptr;
>> +
>> +	if (copy_pkt_from_sw_ring(mux, ring, e->sw_cptr, wptr) == 0) {
>> +		e->end_ptr_in_hw_ring = mux->real_ring->wptr;
>> +		amdgpu_ring_commit(mux->real_ring);
>> +	}
>> +
>> +	spin_unlock(&mux->lock);
>> +}
>> +
>> +u64 amdgpu_ring_get_wptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
>> +{
>> +	struct amdgpu_mux_entry *e;
>> +
>> +	e = amdgpu_get_sw_entry(mux, ring);
>> +	if (!e) {
>> +		DRM_ERROR("cannot find entry for sw ring\n");
>> +		return 0;
>> +	}
>> +
>> +	return e->sw_wptr;
>> +}
>> +
>> +u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
>> +{
>> +	struct amdgpu_mux_entry *e;
>> +	u64 r_rptr, r_wptr, offset, start, end;
>> +
>> +	e = amdgpu_get_sw_entry(mux, ring);
>> +	if (!e) {
>> +		DRM_ERROR("no sw entry found!\n");
>> +		return 0;
>> +	}
>> +
>> +	r_rptr = amdgpu_ring_get_rptr(mux->real_ring);
>> +	r_wptr = amdgpu_ring_get_wptr(mux->real_ring);
>> +
>> +	if (r_wptr < r_rptr)
>> +		r_wptr += mux->real_ring->ring_size >> 2;
>> +
>> +	start = e->start_ptr_in_hw_ring & mux->real_ring->buf_mask;
>> +	end = e->end_ptr_in_hw_ring & mux->real_ring->buf_mask;
>> +	if (start > end)
>> +		end += mux->real_ring->ring_size >> 2;
>> +	if (r_rptr <= end && r_rptr >= start) {
>> +		offset = r_rptr - start;
>> +		e->sw_rptr = (e->sw_cptr + offset) & ring->buf_mask;
>> +	} else if (r_rptr < start) {
>> +		e->sw_rptr = e->sw_cptr;
>> +	} else {
>> +		e->sw_rptr = e->sw_wptr;
>> +	}
>> +
>> +	return e->sw_rptr;
>> +}
>> +
>> +/*copy packages on sw ring range[begin, end) */
>> +static int copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
>> +	u64 s_begin, u64 s_end)
>> +{
>> +	u64 begin, end, r_begin, r_end;
>> +	struct amdgpu_ring *real_ring = mux->real_ring;
>> +
>> +	begin = s_begin & ring->buf_mask;
>> +	end = s_end & ring->buf_mask;
>> +
>> +	r_begin = real_ring->wptr & real_ring->buf_mask;
>> +	if (begin == end)
>> +		return -ERANGE;
>> +	if (begin > end) {
>> +		amdgpu_ring_alloc(real_ring, (ring->ring_size >> 2) + end - begin);
>> +		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[begin],
>> +			(ring->ring_size >> 2) - begin);
>> +		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[0], end);
>> +	} else {
>> +		amdgpu_ring_alloc(real_ring, end - begin);
>> +		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[begin], end - begin);
>> +	}
>> +
>> +	r_end = real_ring->wptr & real_ring->buf_mask;
>> +
>> +	return 0;
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>> new file mode 100644
>> index 000000000000..d058c43bb063
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>> @@ -0,0 +1,67 @@
>> +/*
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#ifndef __AMDGPU_RING_MUX__
>> +#define __AMDGPU_RING_MUX__
>> +
>> +#include <linux/timer.h>
>> +#include <linux/spinlock.h>
>> +#include "amdgpu_ring.h"
>> +
>> +struct amdgpu_ring;
>> +/*
>> + * start_ptr_in_hw_ring - last copied start loc on hw ring
>> + * end_ptr_in_hw_ring - last copied end loc on hw ring
>> + *sw_cptr -the begin of copy ptr in sw ring
>> + *sw_rptr; the read ptr in sw ring
>> + *sw_wptr; the write ptr in sw ring
>> + */
>> +struct amdgpu_mux_entry {
>> +	struct amdgpu_ring	*ring;
>> +	u64 start_ptr_in_hw_ring;
>> +	u64 end_ptr_in_hw_ring;
>> +
>> +	u64 sw_cptr;
>> +	u64 sw_rptr;
>> +	u64 sw_wptr;
>> +};
>> +
>> +struct amdgpu_ring_mux {
>> +	struct amdgpu_ring *real_ring;
>> +
>> +	struct amdgpu_mux_entry ring_entries[AMDGPU_MAX_GFX_RINGS];
>> +
>> +	unsigned num_ring_entries;
>> +
>> +	spinlock_t			lock;
>> +
>> +};
>> +
>> +int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
>> +void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux);
>> +int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
>> +void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring, u64 wptr);
>> +u64 amdgpu_ring_get_wptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
>> +u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
>> +
>> +#endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>> new file mode 100644
>> index 000000000000..452d0ff37758
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>> @@ -0,0 +1,204 @@
>> +/*
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + * All Rights Reserved.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the
>> + * "Software"), to deal in the Software without restriction, including
>> + * without limitation the rights to use, copy, modify, merge, publish,
>> + * distribute, sub license, and/or sell copies of the Software, and to
>> + * permit persons to whom the Software is furnished to do so, subject to
>> + * the following conditions:
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
>> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
>> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + * The above copyright notice and this permission notice (including the
>> + * next paragraph) shall be included in all copies or substantial portions
>> + * of the Software.
>> + *
>> + */
>> +
>> +#include "amdgpu_sw_ring.h"
>> +#include "amdgpu_ring_mux.h"
>> +
>> +#define amdgpu_ring_get_gpu_addr(ring, offset)				\
>> +	(ring->is_mes_queue ?						\
>> +	 (ring->mes_ctx->meta_data_gpu_addr + offset) :			\
>> +	 (ring->adev->wb.gpu_addr + offset * 4))
>> +
>> +#define amdgpu_ring_get_cpu_addr(ring, offset)				\
>> +	(ring->is_mes_queue ?						\
>> +	 (void *)((uint8_t *)(ring->mes_ctx->meta_data_ptr) + offset) : \
>> +	 (&ring->adev->wb.wb[offset]))
>> +
>> +
>> +int amdgpu_sw_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>> +		     unsigned int max_dw, struct amdgpu_irq_src *irq_src,
>> +		     unsigned int irq_type, unsigned int hw_prio,
>> +		     atomic_t *sched_score)
>> +{
>> +	int r;
>> +	int sched_hw_submission = amdgpu_sched_hw_submission;
>> +	u32 *num_sched;
>> +	u32 hw_ip;
>> +
>> +	BUG_ON(!ring->is_sw_ring);
>> +
>> +	if (ring->adev == NULL) {
>> +		if (adev->num_rings >= AMDGPU_MAX_RINGS)
>> +			return -EINVAL;
>> +
>> +		ring->adev = adev;
>> +		ring->num_hw_submission = sched_hw_submission;
>> +		ring->sched_score = sched_score;
>> +		ring->vmid_wait = dma_fence_get_stub();
>> +
>> +		if (!ring->is_mes_queue) {
>> +			ring->idx = adev->num_rings++;
>> +			adev->rings[ring->idx] = ring;
>> +		}
>> +
>> +		r = amdgpu_fence_driver_init_ring(ring);
>> +		if (r)
>> +			return r;
>> +	}
>> +
>> +	r = amdgpu_device_wb_get(adev, &ring->fence_offs);
>> +	if (r) {
>> +		dev_err(adev->dev, "(%d) ring fence_offs wb alloc failed\n", r);
>> +		return r;
>> +	}
>> +
>> +	r = amdgpu_device_wb_get(adev, &ring->fence_offs);
>> +	if (r) {
>> +		dev_err(adev->dev, "(%d) ring fence_offs wb alloc failed\n", r);
>> +		return r;
>> +	}
>> +
>> +	r = amdgpu_device_wb_get(adev, &ring->trail_fence_offs);
>> +	if (r) {
>> +		dev_err(adev->dev, "(%d) ring trail_fence_offs wb alloc failed\n", r);
>> +		return r;
>> +	}
>> +
>> +	r = amdgpu_device_wb_get(adev, &ring->cond_exe_offs);
>> +	if (r) {
>> +		dev_err(adev->dev, "(%d) ring cond_exec_polling wb alloc failed\n", r);
>> +		return r;
>> +	}
>> +
>> +	ring->fence_gpu_addr =
>> +		amdgpu_ring_get_gpu_addr(ring, ring->fence_offs);
>> +	ring->fence_cpu_addr =
>> +		amdgpu_ring_get_cpu_addr(ring, ring->fence_offs);
>> +
>> +	ring->trail_fence_gpu_addr =
>> +		amdgpu_ring_get_gpu_addr(ring, ring->trail_fence_offs);
>> +	ring->trail_fence_cpu_addr =
>> +		amdgpu_ring_get_cpu_addr(ring, ring->trail_fence_offs);
>> +
>> +	ring->cond_exe_gpu_addr =
>> +		amdgpu_ring_get_gpu_addr(ring, ring->cond_exe_offs);
>> +	ring->cond_exe_cpu_addr =
>> +		amdgpu_ring_get_cpu_addr(ring, ring->cond_exe_offs);
>> +
>> +	/* always set cond_exec_polling to CONTINUE */
>> +	*ring->cond_exe_cpu_addr = 1;
>> +
>> +	r = amdgpu_fence_driver_start_ring(ring, irq_src, irq_type);
>> +	if (r) {
>> +		dev_err(adev->dev, "failed initializing fences (%d).\n", r);
>> +		return r;
>> +	}
>> +
>> +	ring->ring_size = roundup_pow_of_two(max_dw * 4 * sched_hw_submission);
>> +
>> +	ring->buf_mask = (ring->ring_size / 4) - 1;
>> +	ring->ptr_mask = ring->funcs->support_64bit_ptrs ?
>> +		0xffffffffffffffff : ring->buf_mask;
>> +
>> +	/* Allocate ring buffer */
>> +	if (ring->ring == NULL) {
>> +		ring->ring = kzalloc(ring->ring_size + ring->funcs->extra_dw, GFP_KERNEL);
>> +		if (!ring->ring) {
>> +			dev_err(adev->dev, "(%d) swring create failed\n", r);
>> +			return r;
>> +		}
>> +
>> +		amdgpu_ring_clear_ring(ring);
>> +	}
>> +
>> +	ring->max_dw = max_dw;
>> +	ring->hw_prio = hw_prio;
>> +
>> +	if (!ring->no_scheduler) {
>> +		hw_ip = ring->funcs->type;
>> +		num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
>> +		adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] =
>> +			&ring->sched;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring)
>> +{
>> +	struct amdgpu_device *adev = ring->adev;
>> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
>> +
>> +	BUG_ON(!ring->is_sw_ring);
>> +	return amdgpu_ring_get_rptr_from_mux(mux, ring);
>> +}
>> +
>> +u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring)
>> +{
>> +	struct amdgpu_device *adev = ring->adev;
>> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
>> +
>> +	BUG_ON(!ring->is_sw_ring);
>> +	return amdgpu_ring_get_wptr_from_mux(mux, ring);
>> +}
>> +
>> +void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring)
>> +{
>> +	BUG_ON(!ring->is_sw_ring);
>> +}
>> +
>> +void amdgpu_sw_ring_commit(struct amdgpu_ring *ring)
>> +{
>> +	struct amdgpu_device *adev = ring->adev;
>> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
>> +
>> +	BUG_ON(!ring->is_sw_ring);
>> +	amdgpu_ring_set_wptr_to_mux(mux, ring, ring->wptr);
>> +}
>> +
>> +void amdgpu_sw_ring_fini(struct amdgpu_ring *ring)
>> +{
>> +	BUG_ON(!ring->is_sw_ring);
>> +
>> +	/* Not to finish a ring which is not initialized */
>> +	if (!(ring->adev) ||
>> +	    (!ring->is_mes_queue && !(ring->adev->rings[ring->idx])))
>> +		return;
>> +
>> +	ring->sched.ready = false;
>> +
>> +	amdgpu_device_wb_free(ring->adev, ring->cond_exe_offs);
>> +	amdgpu_device_wb_free(ring->adev, ring->fence_offs);
>> +
>> +	kfree((void *)ring->ring);
>> +
>> +	dma_fence_put(ring->vmid_wait);
>> +	ring->vmid_wait = NULL;
>> +	ring->me = 0;
>> +
>> +	ring->adev->rings[ring->idx] = NULL;
>> +}
>> +
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
>> new file mode 100644
>> index 000000000000..c05d8a94ad0c
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
>> @@ -0,0 +1,48 @@
>> +/*
>> + * Copyright 2012 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#include <drm/amdgpu_drm.h>
>> +#include <drm/gpu_scheduler.h>
>> +#include <drm/drm_print.h>
>> +
>> +#include "amdgpu_irq.h"
>> +#include "amdgpu_ring.h"
>> +#include "amdgpu.h"
>> +
>> +#ifndef __AMDGPU_SWRING_H__
>> +#define __AMDGPU_SWRING_H__
>> +
>> +int amdgpu_sw_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *sw_ring,
>> +		     unsigned int max_dw, struct amdgpu_irq_src *irq_src,
>> +		     unsigned int irq_type, unsigned int hw_prio,
>> +		     atomic_t *sched_score);
>> +void amdgpu_sw_ring_fini(struct amdgpu_ring *ring);
>> +u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring);
>> +u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring);
>> +void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring);
>> +void amdgpu_sw_ring_commit(struct amdgpu_ring *ring);
>> +
>> +void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring);
>> +void amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring);
>> +
>> +#endif
> 

Regards,
-- 
Luben
