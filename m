Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402F4606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hc11300R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC04210FCB1;
	Wed, 18 Nov 2026 13:56:11 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011068.outbound.protection.outlook.com [40.107.208.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EF3410FCB1
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 13:56:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXZKlSwbvV2XPGPMnieOzjU7I4T5m+T9Iot7h0Yw6r4u9Qh2ufTMd4N/UbmANKgw4Vx/8p8eyAyHmqnxjU8es3Tp61Ks5LiU3BX76zaPExMzEbj/gaKo3nnbesfUp1ni1wNovE9axmiHLSWcTUvUVsixs9MYu+kVQikVptlPKYGKLm9biAU04x47cS4MBy+aNaNz9JlKJ9nvTVVyG6ryOq7o9USoMGBBE0jpoRHf/5OGFKdMSz2laryp+OXD3JMljZqk6ZMt0WrCVQ8spC6vPd0Vo0Btx9vtgORdgIO4OVy41xUyeYq9zMuUVLOori5STRztkYVloNt5M9kSFepxXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6ebbAp5p+rR1ne+CJITayb48Bp2gTBQY+StX9GXkAg=;
 b=Q5lzokvjGmCN2C5+9iG0wVcvZkt4+oewFA4SaH1OW4RP3wst79eDe1T/jYv7dJdJD6N5XHaWkRc+Eo6+HtSUpWpBO+N6Ms7gIPEiFpZvx1mGsj+D86aQfOaBC5WqyCFbAb6h65gPwIM3OH/dNp7TjOTodwKNp+4bjGhge2rO32p2UIUun2qMnOuedeiV+YD6mBTL+DZQ0wdGDmDi122MIYl/lVDN4HMBaYGjAC4bMlDVU4eW3pWd1geFporGXZH9aEyZww6lyZT3aiGGupxbb7TgEJ5b00QGfvUM/kjYvHi/6lHso8DWQ1tJ1GxgFrXId4y9aRDY187WrHj6QCZb9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6ebbAp5p+rR1ne+CJITayb48Bp2gTBQY+StX9GXkAg=;
 b=hc11300RmKc8hzKGGG/VLw7tmC56Sg594A7Ok6sli0zw2t/xm5Ucf1iT8yzOLu24ElZ9BqH/RXQGXW17CrkM0ioa0hO/PgFT58iEPJPwBF2fWFnMVPZZRr3NStb02e7mkbXurm78WLdxH4hHZT6FGVD+kEXzqLulvSpS5AhS4VI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA1PR12MB8240.namprd12.prod.outlook.com (2603:10b6:208:3f2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 13:55:59 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 13:55:59 +0000
Message-ID: <c14edcc8-3bbf-497d-8e8d-c0a766eaae3b@amd.com>
Date: Wed, 18 Nov 2026 19:25:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Enable IMU_I/DRAM FW_LOAD CMD
To: "Guttula, Suresh" <Suresh.Guttula@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20261118132348.4101528-1-suresh.guttula@amd.com>
 <b7863c55-dacc-4519-97e8-a9cc6b07ffea@amd.com>
 <DM4PR12MB7719CCEBF0DDECF8CE99D732937A2@DM4PR12MB7719.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM4PR12MB7719CCEBF0DDECF8CE99D732937A2@DM4PR12MB7719.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::18) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA1PR12MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: 3698dd68-0bea-485f-a83e-08df457bac8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|261021123027099003|10067099003|261022075727099003|56012099006|4143699003|11063799006|261021121427099003|261026121527099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UswZ0W8lXjlRG5J8bISzF2lI5P7ytRajxx5CKmQzBYqMT+e6MQK2HNwdSpzReyWa6rZIh/+s5OpZ2XnIWLpTJTa55R90aBMasmskg4rwqIO0chC/xFk7OZnlRNfgasvLzhWtcp/PPfJBKhETvuTE8zjyoKSqBUD5XTFbfCpfpahRLbBT7HaHjmMVJM51OsB6lTRCZSXOh4DvMgCn4lNXBHr1eI4+NDjVVK5u3QuZSXn6Ocn4/HvfeBBRT52G4kDv+STecqPE9LNv3PKgTdT87QUWxarsgDJPXZSPtR74RLTC90gBcgxxsEhb8K2UMHIK8AXYdmYDTTajyB7qbryoX2V5XhFGqIIdNNbatw14nRpxXeB3w9K2U1OdtQI101dswT28jirbBBR1liUScbW8t5JFcjYinSy1yYqeQLT/uig6ENOo79DYfeX/EYSyfoECJ1W7/EE2DWGiALyjpXmeu6HjjBnF6wqGtqWyuSs0au8SFmw88BtT0tFb99vpvHL2PI97AEUsNPTXxPkSwWnVcpbOvsE35NAXRWEUqvM3zuVwVn3yyadRliY3PltGxHk4MnYfdcTitBZ/08p1TRA2PjAmhlaklsVqJldTBOqrnqgIDqzQz2RbVgWyOBMjbeXVyfxo4hovQtgD6NJRcJ72lq6sUQ2qxIwpM1p2t4xzZIY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261021123027099003)(10067099003)(261022075727099003)(56012099006)(4143699003)(11063799006)(261021121427099003)(261026121527099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUMrMGNQRkRDbWM4MFJDZDFSNW5UTkFXZ2x5OE5VeHhmeWFkc2J2QkgxcElR?=
 =?utf-8?B?VzIvNmliZThjU0xOVVJ0L254ZVB1SFJOeGl1TVc5bUVlVUZLaUhOSGRyYjg2?=
 =?utf-8?B?RFNnaFhON0NuK3hKaHVBRklBeFJ0eUQ5YXArbktjQWFJc0JSM2EwdVBNdDRL?=
 =?utf-8?B?bGRlM2NrNndNRmdKZ1lhb0lJZnMxeDBPblh0amd1VTR6RktycXR6eitxU0RM?=
 =?utf-8?B?cW5MdnBBRkJndUFnRjYzNmd4QkNqYzROM0dxR1RBWHd4V2tyOXJjZDFMTk8w?=
 =?utf-8?B?bTNkMlEyUTFNLzM3azROdDVKazVrVDdYQnd1a09GVnJjaU9mZ0pocGx3c3dj?=
 =?utf-8?B?RmtFVGxBVnZNaHQwZkQ3UFYrS0RtTCtqSkVwUWxxQ3RUWjFwME02OVZxajFa?=
 =?utf-8?B?T1hrejh3TmJRU2FHbGZHd1ZsWFpRbUQ1aU1CbHZQdUJ1Z1JWSWppcDRVQ1VH?=
 =?utf-8?B?RHhGUXZ2WmFZQVJPazZiWmRiVi9wTGRoOE5nUDBacUkybFlBUlpJSi95bExU?=
 =?utf-8?B?ZERaYzhNUGMzSWZiUDcxNncxZDRpS0wzUENBY1pnaDRHS3I2MEFEYTZ2WnB6?=
 =?utf-8?B?Y1dmNFdaUEdFZWhsbTFlY21oaUVVOFhSL25yVGs3bmZjbjJjRFZIRnltZEtQ?=
 =?utf-8?B?b1RiTW0zWHJQWkFtM1ZNWXdPRWExeGIxdUl0dDRFUWdVUWJEYmJLdGI4eXRt?=
 =?utf-8?B?VU9kSWJFVDcxenVQbnFIcWYwVTFyMnBtYlVMWXpJcEhLbmxIbjl3RGYwcXhV?=
 =?utf-8?B?b2ZlQW1iZUg3bTZLNjJhbGRncTIzRDhRVk5aR1FoZmU2VFl0cTJBaXYyeW52?=
 =?utf-8?B?NUtwclhGYjFrekxGenc5UmZGbHRjWVF1RURVOUI3bzhiWDlwYVM1dlU4WjJC?=
 =?utf-8?B?NWIwOXNMaS9oamFjVVVuMHFrY0tEQ0t1WWl2d1RvZFY2Znd3YXJWNUJHVmxW?=
 =?utf-8?B?Uk1BVldUNEhUNS8zTjBtazZWZWMxeVJ3QkpwOUhRRzErNmloTC9jcmNocXVp?=
 =?utf-8?B?ZVE5eXN1UlE5dVN6R1BrTlhTOUJ6Y3l1SDVMTUpydTRVT1FKcGxOY3Q0bFFX?=
 =?utf-8?B?VHpYOHArTEFpeTJPZWdqUGlueHhYUjVyWFlIZDdQRkoveEhOVUEzTitKOWJ0?=
 =?utf-8?B?ZHl6RzZ5Y054V2wxV3RMcjdHV2NKQjJHd08wYmlSQWtta1VqcnNFQ2JKa0pH?=
 =?utf-8?B?TWp2Z09YOGY5eklHUG5pNEZUamZSMzd4RW5iQ3ptVklKa3l0RDNRVjRQVUZt?=
 =?utf-8?B?dkdLZ0RBLzljdDlpb2g3blNUcDA1Wkx1ZHJXZHZrMEU3Zy9UZXFDUkZxVlU0?=
 =?utf-8?B?b3RwblozUEZja1c3YzhSeUF2TWdRVDYwOGFRVHpCWVBxaDhBVVhLWFBHcEJy?=
 =?utf-8?B?dGdrekQwV2dTM1dxNFFmUk5DOFhWU0UwaVdwUmdSWDdkanJ4SmgzRGptbUVh?=
 =?utf-8?B?NFdpZ0dZWHhGemNWTXRaVUhrdUZlYVFTVGNPTkN5bGltZFpldHlRV2JhNG5w?=
 =?utf-8?B?YU1yc21BT2toOWR6d2RmUGllR21aU21Qa0puYjI5dkRoVFg0TmMvMEtKc0JG?=
 =?utf-8?B?NHFpR0ZBRDZoeHVEc1NOdkp4VEIrWE42Z1JJTC9DNVZETHV6MTdxc01qWjVR?=
 =?utf-8?B?WC9WbmdKT3lEZmpuY0xtZGs1RUtZMW4rNE1iRWNMcjJTSzd2d3JUakJTem1T?=
 =?utf-8?B?L2UxMjZYQUhhSkVaRHJWcjhsa2NnaTc4K2lEaVI1MFVrb3haTWtSSDBRTW8w?=
 =?utf-8?B?eXVycUNaQnRtNldhUTRyZkl0NzJ1MmpWVk9rZFVza1htVGwvS2phWHoyU212?=
 =?utf-8?B?ODJEU09nNkZtenRXLzZDN01TbWYzZHA3c1BhczdxQVVacnZBY203OFhtcGhR?=
 =?utf-8?B?bHlRZURYSTRxekROVjUyTFBVMXdlcFV6TVorcjIvNkpCTHIrbkFmQXFZVDUy?=
 =?utf-8?B?S1F6RjJvVFVsSFFCbm9sbzBlTmw3RGtNYUdEdTZlb2h3L3BJTEtNOEhGa2Vy?=
 =?utf-8?B?NzFsT3dUekRZai9yeUpJQm1LcUNzVXZSZnRBdldzbzRtSTgzNmJNVkxhM05o?=
 =?utf-8?B?SmFOaGFwNWJSaE0reXRYMnhhQXhRRU4wN0tWcXZNWmovb2Q0RzhPTlJ2MTA2?=
 =?utf-8?B?M3ZVc1pXaCs4bFcxTmd5WTBCeTZCb3pkQldoQ0VFUVRpT3FZelVhQ0xVbklz?=
 =?utf-8?B?eGtvZUVuTW5IVlZ5QzRKYm5kVWZZQlpHL1ErK1JLNW82eTY4clFTcTc5Qmds?=
 =?utf-8?B?WXIxV045eFNIN29pSHVKb294QjBoalVNaitCZlBldVZUdE05NzR5Qzh5eHFU?=
 =?utf-8?Q?FqQkwAB59SE2qXEBNW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3698dd68-0bea-485f-a83e-08df457bac8a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 13:55:59.1570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/19PCTr2uhsiHYhCl1sV8WtiSrSaUoVZvldAUYVIECprnbIwYDdavdy/6yt84bM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8240
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 18-Nov-26 7:21 PM, Guttula, Suresh wrote:
> AMD General
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: 18 November 2026 19:14
> To: Guttula, Suresh <Suresh.Guttula@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amd/amdgpu: Enable IMU_I/DRAM FW_LOAD CMD
> 
> 
> 
> On 18-Nov-26 6:53 PM, Suresh Guttula wrote:
>> For GC 11, Eventhough IMU ucode load from BIOS/IFWI, PSP exepct Load
>> command from GFX to load IMU ucode.
>>
>> Signed-off-by: Suresh Guttula <suresh.guttula@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  9 +++++++--
>>    drivers/gpu/drm/amd/amdgpu/imu_v11_0.c  | 14 +++++++++++++-
>>    2 files changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> index 7a8cc043df5e..9d6c192db348 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> @@ -4091,8 +4091,13 @@ static int psp_load_non_psp_fw(struct psp_context *psp)
>>                        continue;
>>                }
>>
>> -             if (fw_load_skip_check(psp, ucode))
>> -                     continue;
>> +             if (fw_load_skip_check(psp, ucode)) {
>> +                     if (!ucode->fw && (ucode->ucode_id == AMDGPU_UCODE_ID_IMU_I ||
>> +                         ucode->ucode_id == AMDGPU_UCODE_ID_IMU_D))
>> +                             dev_dbg(psp->adev->dev, "don't skip IMU fw load!\n");
>> +                     else
>> +                             continue;
> 
> Keeping this in common code causes side effect on other SOCs. Better add a check inside fw_load_skip_check() such that it returns false for the particular GC IP version.
> 
> Thanks,
> Lijo
> 
> This is specific to APUs, Let me add APU check also.. Like added in imuv11_init_microcode(), that will differentiate.

If it's applicable for all APUs including any upcoming ones, then the 
commit message shouldn't specify "For GC v11".

Thanks,
Lijo

> Thanks.
> 
>> +             }
>>
>>                if (psp->autoload_supported &&
>>                    (amdgpu_ip_version(adev, MP0_HWIP, 0) == diff --git
>> a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
>> b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
>> index b6c4ae35ca03..3aef68c9891a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
>> @@ -31,6 +31,8 @@
>>    #include "gc/gc_11_0_0_offset.h"
>>    #include "gc/gc_11_0_0_sh_mask.h"
>>
>> +#define IMU_DATA_SIZE_BYTES  66304
>> +
>>    MODULE_FIRMWARE("amdgpu/gc_11_0_0_imu.bin");
>>    MODULE_FIRMWARE("amdgpu/gc_11_0_0_imu_kicker.bin");
>>    MODULE_FIRMWARE("amdgpu/gc_11_0_1_imu.bin");
>> @@ -73,8 +75,18 @@ static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
>>        else
>>                err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, required,
>>                                           "amdgpu/%s_imu.bin", ucode_prefix);
>> -     if (err == -ENODEV && imu_in_ifwi)
>> +     if (err == -ENODEV && imu_in_ifwi) {
>> +             info = &adev->firmware.ucode[AMDGPU_UCODE_ID_IMU_I];
>> +             info->ucode_id = AMDGPU_UCODE_ID_IMU_I;
>> +             info->fw = adev->gfx.imu_fw;
>> +             info->ucode_size = IMU_DATA_SIZE_BYTES;
>> +
>> +             info = &adev->firmware.ucode[AMDGPU_UCODE_ID_IMU_D];
>> +             info->ucode_id = AMDGPU_UCODE_ID_IMU_D;
>> +             info->fw = adev->gfx.imu_fw;
>> +             info->ucode_size = IMU_DATA_SIZE_BYTES;
>>                return 0;
>> +     }
>>        if (err)
>>                goto out;
>>
> 

