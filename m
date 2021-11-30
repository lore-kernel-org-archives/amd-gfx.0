Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753B1C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 14:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AA666E883;
	Tue, 30 Nov 2021 14:07:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A83C16E911
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 14:07:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3P835hkJzwGHXR11aB4+EzJJV8GMGOZpOjxYUEOnTfG+ylkEogRYX7gWU/EG7pPgHGIRfYYYDtqcZqGPWLQG1zz08iyYGP2TSIOPJSK31v8wj3DoUrdYMIQbYzqGZlDcKSeEFE+LdI2XCrnD20IO3MQdSzqqDQG3MrY1ormh/eNECYSYRJ+1aiHriucMqWzp1RsImevo7zYvZcxfaNNKahFepRQSGQFABu+kOtL3ycSuPro0y4K+sngne15ruxcXuM4vLz1BI6PhaJQs0ZjI7paPbtoe/SKNaPwsrp3YK1/KzLQY3dTFjF32jTT7VR9rnCST02ukbILISeEZ8qgLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckwjtqLVA6nUn7kPjqezmygbIZ7AuVHOv/QRRggMbcA=;
 b=BQDdBNZTrj+IK9H3/asw9DY80x/AxXfttcwJ42o2zB0Vrkb7UZyNB/FvZwn1UHrgV5PKayKEh4poP/HeDsnXhCpl/oOibY/J8GNHDquUMo5iEC90IVR976YLmBNc6iNQi/DyWot/3GvVYXjSDCZVNECAyUplS6y2FclS0RCAp1i7ontn9HxbbOVcK0OB/1h/yM6CRqSCEvUSx/xi5KLUwQLllmr4XAToB4s2zYMUJrKi+meblhiP94oK12vz2WxTn2CRYv7dP5XdXrFrAMEJpe6zAiYRW47ryUu5oeXHE81IMYeU9gpg9Wv4Xx9zqn1ZGCFderzhQ+tOJAA/IuHu6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckwjtqLVA6nUn7kPjqezmygbIZ7AuVHOv/QRRggMbcA=;
 b=D8Lgadq9uRi2xPWO4am9flNzRnusRL0kMkj0Vsyp0ju+mvucal8IXnfnPmps4RgHmvq9u+3HtKvPA3orpy7e+AensZVy9rqPrGSnBCV+kGk5M46os7eryq/mtlqvuWld860na3LHPsrQ+SYfHL7n8ZFoiQWXrwrFuElQpm7rIuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB2485.namprd12.prod.outlook.com (2603:10b6:4:bb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.19; Tue, 30 Nov
 2021 14:07:18 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 14:07:18 +0000
Message-ID: <bbada5c3-984a-dcfa-f401-1f757ca90ff7@amd.com>
Date: Tue, 30 Nov 2021 19:37:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH V2 14/17] drm/amd/pm: relocate the power related headers
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211130074259.1271965-1-evan.quan@amd.com>
 <20211130074259.1271965-15-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211130074259.1271965-15-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::33) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BM1PR01CA0093.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.24 via Frontend Transport; Tue, 30 Nov 2021 14:07:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0058d1e3-83b4-49fa-e670-08d9b40ab812
X-MS-TrafficTypeDiagnostic: DM5PR12MB2485:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24852E10350CC548932AB71297679@DM5PR12MB2485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A0SNaTwSbNsWW4W7eAu3UYGjLdSpQn2l59H2udU70EvRAB6fYKIm3sV/nraXbBrCUtIYsd63AWExWoEH8M1FriAGtsU/2f0JAwdRYXHPwJF2PA7sJ/wIkASBQC7v5xUDKaAsWSwX+MCkHZWHr/Gn7FzXkcuU0i+Nw+OdXlzsBmTqEKl3BanH4Y2BI34ztIf5NKLpNNZ9YGc7AbPGv7mHnVt/b3c7vmxuXYWKdjMpbeChM7CYTK2wcYDarqJiMFY9Sc31KEOuVkGcAmV5qI5aipSFnAYN9i5jahC1Cdk4wZxCoT+7qv+SRZtt23LxF8oFJOTyusoQuoqemYmSQ4O8T1q8IRkAss5t8HzBMjx7afTNXm7oBMIMad4gpz1XBjIeN0oU8CqMYs2SBzI2LaTBTC030TzFWaQKOsDP8JTrPbvAt7AKhTwVpF4jiAqKdUHrrz8Ed0NTA1HjMN2v9GS5MQqP4JQ/Xx5iQij7VTGNE9R8azrA160HOS6tkNiDQy+Xm+XZ4Pyoac/DvRWa73iRRI66FfcgwPjSMs4AZcv7t+Mh9+WJEYfWV57HmblMI8slVY46CTc06/8zbktdTtqRTIxjw2ohteTV4pcp8THyMY5CYqNDx1fIWXPcbUt4kzbuHqw+UjKhj3XU5tNjUnPlRHz62ZoKO7OA5YxHeE6phohxMCuwX69eI18XJ9X1DrVSsDaUBtYWBS8uZapz7Dy6fjbKreuQjW8UNWy6Nlk4tZ2lBVcc/A15QqRqewLG+7Ea
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(53546011)(956004)(6666004)(8936002)(31696002)(508600001)(31686004)(36756003)(30864003)(86362001)(4326008)(26005)(16576012)(8676002)(186003)(2906002)(66556008)(66946007)(66476007)(6486002)(5660300002)(2616005)(316002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K010RkhPcFNjNFNmRFdVMHl2UzNtQzMzVUROQ3BEcUV4ck45bGRJN0hqNE1v?=
 =?utf-8?B?ZS8ycWt4cTd5MjA4N1gvZ05maFFKcUxnUk1iOHZKbjJOVnorNnVQalFwYmR6?=
 =?utf-8?B?RzVCaENRaUIzcnFZZjZTc3hUNGZhS0ZSSFVHZWpGM1VZZ3BDMFZNNEhtSWVs?=
 =?utf-8?B?eVNESzVGQ2hSRHkrOU1Sb2M4ZTRNQSszaytrTDJPUnNCZG1nbUY2VlJsY2hm?=
 =?utf-8?B?L2JNNDBiY3dDRjZYdW4vRHRCb3dFNGUzZFg1Z2lnZW5XOFBIMW9JOG02c0Nq?=
 =?utf-8?B?SFEvTzcwcThiRldoRzFCUU9ndDNld0Q4WjhzczZxQVI2Wm54emlRRVdnVUZw?=
 =?utf-8?B?NHlIdzZLMDFMQTdrTndHTGlORlBBMHlET2tDbUNDSmFteko4TlFtQzBpNFV5?=
 =?utf-8?B?R2ljRmU2SVFUVTMyS0VCNE4zTVNJM0hZYW5taTZXSnpGaStVdHdlTVZwV2tt?=
 =?utf-8?B?UEZpNEkzaFlMU2RCMWNIYk9XZTBQRnZwdzU1aFpPeFFrWTJDTTQ3WEQzVDVV?=
 =?utf-8?B?RnYrT3gySy9TSUcyN0JLK1FrWVE3dGNFbzdwTWFwY0xITThVUUZ5VHhsT29u?=
 =?utf-8?B?WGpDM1lJVXUwUnV6Qm1JVzJweVluN21aRW9URnM4bmF6UUJXWFgxcmZKQkVD?=
 =?utf-8?B?YkovZ0VueEltbms5MmY2M1ArTjZDYWJvc1FUZDFRamU2YW5mK2ptMVNiS1ZV?=
 =?utf-8?B?MFdOdmRJVnk0RE5CUGU1aURTemsyNkF5MG53MUt4bDJJUGxmRFAzQzBNSW5H?=
 =?utf-8?B?dnNqVFhhdXlZaW5nMVo1QllXd25JdEZldFZkNnBTUUQ3TUtqVlp5T29NYzgw?=
 =?utf-8?B?Q0F1Z01nZDk3ckRETEt5MlU0REVKT3YwS2dpWCttcWZOVzJhaXhTNWVRWDF1?=
 =?utf-8?B?eVQyYzZGTlNzODBZSkgxYldRbWRDbjhGYUx1QnRLUHBvRmRPUjFyUHRZNTVr?=
 =?utf-8?B?MlpsdnBrY2xFT3hCc3VMZHNlOEFjOU05ZnA5YWVkUUljL3ZJN1dKQjBtUFRN?=
 =?utf-8?B?WElaRUxlZEVXYmZia0ZyTXNUY2lTR01VM3BLQmtmL1JEZmg3WWRjaUlrVkh3?=
 =?utf-8?B?eGlwUnBSM3JodlJCdG5teWFNY2lWb2MxcDZHV0p4Vy9nRHY5TkZhN1ovOFFR?=
 =?utf-8?B?eG9uNlhFWTNTeEMybE9qVlQraDJBQWdyVVBuc1c2cWV3WDA5dlNZRlZOdEhV?=
 =?utf-8?B?cGJ5NTB4ME1LbWt3SExxOXQwQkRMSjhSb3AxTmUzZEFEVTB4UFFBRHpDWGdT?=
 =?utf-8?B?MWZac3I5Q0RxWTFpQkJuWkQrbjFla2RVT2F4RTc4SXoxdm9sWWsvKzhlSUhY?=
 =?utf-8?B?RS9YOHFCWXV1eGJmQlAreU1iTkRGQ2VBQjdGMUhIaFBZQ09aRXJod0N0Z0RX?=
 =?utf-8?B?ejNXUWpPWEpJLzI0UzRlN1o4MTQwVzJlRzVvcjBCTzkwZXpzSlVXTFZuVTZW?=
 =?utf-8?B?L2RISmdXQkdWSWU3OE9MSEw2NHEwYzRsQUpUQzlXUTFCelRpQkpYR2REMmNG?=
 =?utf-8?B?dnpMSDBpTjgvaFRHNmNrdzNQd1ZpbUxRazQ4UzlHRy9FZ2lBV0NhOCtlNmlQ?=
 =?utf-8?B?K29PVlBISGpqRE1iSC9IeE1aL1lvc1plcWl2MWtPSFhOY0MxWkxPUVBtQlJO?=
 =?utf-8?B?N1FqY2lsWlpRYzEvbFN6dFp3TmNwd2xiVjBMWUpYS2NXWGpuVU5rQklycEJC?=
 =?utf-8?B?S0taRHF2UVY1K3VGcXZVNTY5VUE3ekhLLytvajVEZGdVQ01CQkNQMUYzZGd3?=
 =?utf-8?B?c25aMnV5dkdMNmRza0NnVi9LbjIwcm1vVER2ZW1sMGE2aHhtVUd2WVZGYVZl?=
 =?utf-8?B?bEJHYVBib1h5dFRLTkw0UTJzOWZNUUJoWG90TW9paGxNRU04cnNtaCtRL1o3?=
 =?utf-8?B?cTN4cXJLY0dCbC8vejdOZ0dzZ0ZmbVc3WWd6R0R1ZDlsaHZ3TXUwTDNGMTNu?=
 =?utf-8?B?bjVuVzJxL2tGTmphUVdLaEhPbnVLUTU4NlNrMWdTbU5MMnJXbjl2akFlcnN3?=
 =?utf-8?B?eWdnRDAyN1c1L1U1d3ZjckN0eUxQb0VWNk5vUWNwZTU0M0Nhd1NrSTBUL1FE?=
 =?utf-8?B?TnRSTDd0RlB3TGFvK3d4dWhFc1BOZ3p4NGowd0tTMjl3bXdDOU51Y0pwTEVW?=
 =?utf-8?Q?d3mw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0058d1e3-83b4-49fa-e670-08d9b40ab812
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 14:07:18.5302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LmTCK1LH6QoFX8yJu2PZw5F/AWAIiWcwp6p87oCXojl5ZqgkURbbEM3Dfo81CiGE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2485
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
Cc: Alexander.Deucher@amd.com, Kenneth.Feng@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/30/2021 1:12 PM, Evan Quan wrote:
> Instead of centralizing all headers in the same folder. Separate them into
> different folders and place them among those source files those who really
> need them.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: Id74cb4c7006327ca7ecd22daf17321e417c4aa71
> ---
>   drivers/gpu/drm/amd/pm/Makefile               | 10 +++---
>   drivers/gpu/drm/amd/pm/legacy-dpm/Makefile    | 32 +++++++++++++++++++
>   .../pm/{powerplay => legacy-dpm}/cik_dpm.h    |  0
>   .../amd/pm/{powerplay => legacy-dpm}/kv_dpm.c |  0
>   .../amd/pm/{powerplay => legacy-dpm}/kv_dpm.h |  0
>   .../amd/pm/{powerplay => legacy-dpm}/kv_smc.c |  0
>   .../pm/{powerplay => legacy-dpm}/legacy_dpm.c |  0
>   .../pm/{powerplay => legacy-dpm}/legacy_dpm.h |  0
>   .../amd/pm/{powerplay => legacy-dpm}/ppsmc.h  |  0
>   .../pm/{powerplay => legacy-dpm}/r600_dpm.h   |  0
>   .../amd/pm/{powerplay => legacy-dpm}/si_dpm.c |  0
>   .../amd/pm/{powerplay => legacy-dpm}/si_dpm.h |  0
>   .../amd/pm/{powerplay => legacy-dpm}/si_smc.c |  0
>   .../{powerplay => legacy-dpm}/sislands_smc.h  |  0
>   drivers/gpu/drm/amd/pm/powerplay/Makefile     |  6 +---
>   .../pm/{ => powerplay}/inc/amd_powerplay.h    |  0
>   .../drm/amd/pm/{ => powerplay}/inc/cz_ppsmc.h |  0
>   .../amd/pm/{ => powerplay}/inc/fiji_ppsmc.h   |  0
>   .../pm/{ => powerplay}/inc/hardwaremanager.h  |  0
>   .../drm/amd/pm/{ => powerplay}/inc/hwmgr.h    |  0
>   .../{ => powerplay}/inc/polaris10_pwrvirus.h  |  0
>   .../amd/pm/{ => powerplay}/inc/power_state.h  |  0
>   .../drm/amd/pm/{ => powerplay}/inc/pp_debug.h |  0
>   .../amd/pm/{ => powerplay}/inc/pp_endian.h    |  0
>   .../amd/pm/{ => powerplay}/inc/pp_thermal.h   |  0
>   .../amd/pm/{ => powerplay}/inc/ppinterrupt.h  |  0
>   .../drm/amd/pm/{ => powerplay}/inc/rv_ppsmc.h |  0
>   .../drm/amd/pm/{ => powerplay}/inc/smu10.h    |  0
>   .../pm/{ => powerplay}/inc/smu10_driver_if.h  |  0
>   .../pm/{ => powerplay}/inc/smu11_driver_if.h  |  0
>   .../gpu/drm/amd/pm/{ => powerplay}/inc/smu7.h |  0
>   .../drm/amd/pm/{ => powerplay}/inc/smu71.h    |  0
>   .../pm/{ => powerplay}/inc/smu71_discrete.h   |  0
>   .../drm/amd/pm/{ => powerplay}/inc/smu72.h    |  0
>   .../pm/{ => powerplay}/inc/smu72_discrete.h   |  0
>   .../drm/amd/pm/{ => powerplay}/inc/smu73.h    |  0
>   .../pm/{ => powerplay}/inc/smu73_discrete.h   |  0
>   .../drm/amd/pm/{ => powerplay}/inc/smu74.h    |  0
>   .../pm/{ => powerplay}/inc/smu74_discrete.h   |  0
>   .../drm/amd/pm/{ => powerplay}/inc/smu75.h    |  0
>   .../pm/{ => powerplay}/inc/smu75_discrete.h   |  0
>   .../amd/pm/{ => powerplay}/inc/smu7_common.h  |  0
>   .../pm/{ => powerplay}/inc/smu7_discrete.h    |  0
>   .../amd/pm/{ => powerplay}/inc/smu7_fusion.h  |  0
>   .../amd/pm/{ => powerplay}/inc/smu7_ppsmc.h   |  0
>   .../gpu/drm/amd/pm/{ => powerplay}/inc/smu8.h |  0
>   .../amd/pm/{ => powerplay}/inc/smu8_fusion.h  |  0
>   .../gpu/drm/amd/pm/{ => powerplay}/inc/smu9.h |  0
>   .../pm/{ => powerplay}/inc/smu9_driver_if.h   |  0
>   .../{ => powerplay}/inc/smu_ucode_xfer_cz.h   |  0
>   .../{ => powerplay}/inc/smu_ucode_xfer_vi.h   |  0
>   .../drm/amd/pm/{ => powerplay}/inc/smumgr.h   |  0
>   .../amd/pm/{ => powerplay}/inc/tonga_ppsmc.h  |  0
>   .../amd/pm/{ => powerplay}/inc/vega10_ppsmc.h |  0
>   .../inc/vega12/smu9_driver_if.h               |  0
>   .../amd/pm/{ => powerplay}/inc/vega12_ppsmc.h |  0
>   .../amd/pm/{ => powerplay}/inc/vega20_ppsmc.h |  0
>   .../amd/pm/{ => swsmu}/inc/aldebaran_ppsmc.h  |  0
>   .../drm/amd/pm/{ => swsmu}/inc/amdgpu_smu.h   |  0
>   .../amd/pm/{ => swsmu}/inc/arcturus_ppsmc.h   |  0
>   .../inc/smu11_driver_if_arcturus.h            |  0
>   .../inc/smu11_driver_if_cyan_skillfish.h      |  0
>   .../{ => swsmu}/inc/smu11_driver_if_navi10.h  |  0
>   .../inc/smu11_driver_if_sienna_cichlid.h      |  0
>   .../{ => swsmu}/inc/smu11_driver_if_vangogh.h |  0
>   .../amd/pm/{ => swsmu}/inc/smu12_driver_if.h  |  0
>   .../inc/smu13_driver_if_aldebaran.h           |  0
>   .../inc/smu13_driver_if_yellow_carp.h         |  0
>   .../pm/{ => swsmu}/inc/smu_11_0_cdr_table.h   |  0
>   .../drm/amd/pm/{ => swsmu}/inc/smu_types.h    |  0
>   .../drm/amd/pm/{ => swsmu}/inc/smu_v11_0.h    |  0
>   .../pm/{ => swsmu}/inc/smu_v11_0_7_ppsmc.h    |  0
>   .../pm/{ => swsmu}/inc/smu_v11_0_7_pptable.h  |  0
>   .../amd/pm/{ => swsmu}/inc/smu_v11_0_ppsmc.h  |  0
>   .../pm/{ => swsmu}/inc/smu_v11_0_pptable.h    |  0
>   .../amd/pm/{ => swsmu}/inc/smu_v11_5_pmfw.h   |  0
>   .../amd/pm/{ => swsmu}/inc/smu_v11_5_ppsmc.h  |  0
>   .../amd/pm/{ => swsmu}/inc/smu_v11_8_pmfw.h   |  0
>   .../amd/pm/{ => swsmu}/inc/smu_v11_8_ppsmc.h  |  0
>   .../drm/amd/pm/{ => swsmu}/inc/smu_v12_0.h    |  0
>   .../amd/pm/{ => swsmu}/inc/smu_v12_0_ppsmc.h  |  0
>   .../drm/amd/pm/{ => swsmu}/inc/smu_v13_0.h    |  0
>   .../amd/pm/{ => swsmu}/inc/smu_v13_0_1_pmfw.h |  0
>   .../pm/{ => swsmu}/inc/smu_v13_0_1_ppsmc.h    |  0
>   .../pm/{ => swsmu}/inc/smu_v13_0_pptable.h    |  0
>   .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  1 -
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  1 -
>   87 files changed, 39 insertions(+), 11 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/pm/legacy-dpm/Makefile
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/cik_dpm.h (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/kv_dpm.c (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/kv_dpm.h (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/kv_smc.c (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/legacy_dpm.c (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/legacy_dpm.h (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/r600_dpm.h (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/si_dpm.c (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/si_dpm.h (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/si_smc.c (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/sislands_smc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/amd_powerplay.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/cz_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/fiji_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/hardwaremanager.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/hwmgr.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/polaris10_pwrvirus.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/power_state.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/pp_debug.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/pp_endian.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/pp_thermal.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/ppinterrupt.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/rv_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu10.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu10_driver_if.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu11_driver_if.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu71.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu71_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu72.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu72_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu73.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu73_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu74.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu74_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu75.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu75_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_common.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_fusion.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu8.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu8_fusion.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu9.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu9_driver_if.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu_ucode_xfer_cz.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu_ucode_xfer_vi.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smumgr.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/tonga_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega10_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega12/smu9_driver_if.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega12_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega20_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/aldebaran_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/amdgpu_smu.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/arcturus_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu11_driver_if_arcturus.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu11_driver_if_cyan_skillfish.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu11_driver_if_navi10.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu11_driver_if_sienna_cichlid.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu11_driver_if_vangogh.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu12_driver_if.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu13_driver_if_aldebaran.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu13_driver_if_yellow_carp.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_11_0_cdr_table.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_types.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0_7_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0_7_pptable.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0_pptable.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_5_pmfw.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_5_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_8_pmfw.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_8_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v12_0.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v12_0_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0_1_pmfw.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0_1_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0_pptable.h (100%)
> 
> diff --git a/drivers/gpu/drm/amd/pm/Makefile b/drivers/gpu/drm/amd/pm/Makefile
> index d35ffde387f1..84c7203b5e46 100644
> --- a/drivers/gpu/drm/amd/pm/Makefile
> +++ b/drivers/gpu/drm/amd/pm/Makefile
> @@ -21,20 +21,22 @@
>   #
>   
>   subdir-ccflags-y += \
> -		-I$(FULL_AMD_PATH)/pm/inc/  \
>   		-I$(FULL_AMD_PATH)/include/asic_reg  \
>   		-I$(FULL_AMD_PATH)/include  \
> +		-I$(FULL_AMD_PATH)/pm/inc/  \
>   		-I$(FULL_AMD_PATH)/pm/swsmu \
> +		-I$(FULL_AMD_PATH)/pm/swsmu/inc \
>   		-I$(FULL_AMD_PATH)/pm/swsmu/smu11 \
>   		-I$(FULL_AMD_PATH)/pm/swsmu/smu12 \
>   		-I$(FULL_AMD_PATH)/pm/swsmu/smu13 \
> -		-I$(FULL_AMD_PATH)/pm/powerplay \
> +		-I$(FULL_AMD_PATH)/pm/powerplay/inc \
>   		-I$(FULL_AMD_PATH)/pm/powerplay/smumgr\
> -		-I$(FULL_AMD_PATH)/pm/powerplay/hwmgr
> +		-I$(FULL_AMD_PATH)/pm/powerplay/hwmgr \
> +		-I$(FULL_AMD_PATH)/pm/legacy-dpm
>   
>   AMD_PM_PATH = ../pm
>   
> -PM_LIBS = swsmu powerplay
> +PM_LIBS = swsmu powerplay legacy-dpm
>   
>   AMD_PM = $(addsuffix /Makefile,$(addprefix $(FULL_AMD_PATH)/pm/,$(PM_LIBS)))
>   
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/Makefile b/drivers/gpu/drm/amd/pm/legacy-dpm/Makefile
> new file mode 100644
> index 000000000000..baa4265d1daa
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/Makefile
> @@ -0,0 +1,32 @@
> +#
> +# Copyright 2021 Advanced Micro Devices, Inc.
> +#
> +# Permission is hereby granted, free of charge, to any person obtaining a
> +# copy of this software and associated documentation files (the "Software"),
> +# to deal in the Software without restriction, including without limitation
> +# the rights to use, copy, modify, merge, publish, distribute, sublicense,
> +# and/or sell copies of the Software, and to permit persons to whom the
> +# Software is furnished to do so, subject to the following conditions:
> +#
> +# The above copyright notice and this permission notice shall be included in
> +# all copies or substantial portions of the Software.
> +#
> +# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> +# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> +# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> +# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> +# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> +# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> +# OTHER DEALINGS IN THE SOFTWARE.
> +#
> +
> +AMD_LEGACYDPM_PATH = ../pm/legacy-dpm
> +
> +LEGACYDPM_MGR-y = legacy_dpm.o
> +
> +LEGACYDPM_MGR-$(CONFIG_DRM_AMDGPU_CIK)+= kv_dpm.o kv_smc.o
> +LEGACYDPM_MGR-$(CONFIG_DRM_AMDGPU_SI)+= si_dpm.o si_smc.o
> +
> +AMD_LEGACYDPM_POWER = $(addprefix $(AMD_LEGACYDPM_PATH)/,$(LEGACYDPM_MGR-y))
> +
> +AMD_POWERPLAY_FILES += $(AMD_LEGACYDPM_POWER)
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/cik_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/cik_dpm.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/cik_dpm.h
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/cik_dpm.h
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/kv_dpm.h
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.h
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_smc.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_smc.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/kv_smc.c
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/kv_smc.c
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.c
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/ppsmc.h b/drivers/gpu/drm/amd/pm/legacy-dpm/ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/ppsmc.h
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/r600_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/r600_dpm.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/r600_dpm.h
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/r600_dpm.h
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/si_dpm.h
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.h
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_smc.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/si_smc.c
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h b/drivers/gpu/drm/amd/pm/legacy-dpm/sislands_smc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h
> rename to drivers/gpu/drm/amd/pm/legacy-dpm/sislands_smc.h
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/Makefile b/drivers/gpu/drm/amd/pm/powerplay/Makefile
> index 614d8b6a58ad..795a3624cbbf 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/Makefile
> +++ b/drivers/gpu/drm/amd/pm/powerplay/Makefile
> @@ -28,11 +28,7 @@ AMD_POWERPLAY = $(addsuffix /Makefile,$(addprefix $(FULL_AMD_PATH)/pm/powerplay/
>   
>   include $(AMD_POWERPLAY)
>   
> -POWER_MGR-y = amd_powerplay.o legacy_dpm.o
> -
> -POWER_MGR-$(CONFIG_DRM_AMDGPU_CIK)+= kv_dpm.o kv_smc.o
> -
> -POWER_MGR-$(CONFIG_DRM_AMDGPU_SI)+= si_dpm.o si_smc.o
> +POWER_MGR-y = amd_powerplay.o
>   
>   AMD_PP_POWER = $(addprefix $(AMD_PP_PATH)/,$(POWER_MGR-y))
>   
> diff --git a/drivers/gpu/drm/amd/pm/inc/amd_powerplay.h b/drivers/gpu/drm/amd/pm/powerplay/inc/amd_powerplay.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/amd_powerplay.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/amd_powerplay.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/cz_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/cz_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/cz_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/cz_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/fiji_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/fiji_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/fiji_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/fiji_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/hardwaremanager.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/hardwaremanager.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/hwmgr.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/polaris10_pwrvirus.h b/drivers/gpu/drm/amd/pm/powerplay/inc/polaris10_pwrvirus.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/polaris10_pwrvirus.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/polaris10_pwrvirus.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/power_state.h b/drivers/gpu/drm/amd/pm/powerplay/inc/power_state.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/power_state.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/power_state.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/pp_debug.h b/drivers/gpu/drm/amd/pm/powerplay/inc/pp_debug.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/pp_debug.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/pp_debug.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/pp_endian.h b/drivers/gpu/drm/amd/pm/powerplay/inc/pp_endian.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/pp_endian.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/pp_endian.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/pp_thermal.h b/drivers/gpu/drm/amd/pm/powerplay/inc/pp_thermal.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/pp_thermal.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/pp_thermal.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/ppinterrupt.h b/drivers/gpu/drm/amd/pm/powerplay/inc/ppinterrupt.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/ppinterrupt.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/ppinterrupt.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/rv_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/rv_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu10.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu10.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu10.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu10.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu10_driver_if.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu10_driver_if.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu10_driver_if.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu10_driver_if.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu11_driver_if.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu11_driver_if.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu7.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu7.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu71.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu71.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu71.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu71.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu71_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu71_discrete.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu71_discrete.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu71_discrete.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu72.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu72.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu72.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu72.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu72_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu72_discrete.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu72_discrete.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu72_discrete.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu73.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu73.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu73.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu73.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu73_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu73_discrete.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu73_discrete.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu73_discrete.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu74.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu74.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu74.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu74.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu74_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu74_discrete.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu74_discrete.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu74_discrete.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu75.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu75.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu75.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu75.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu75_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu75_discrete.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu75_discrete.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu75_discrete.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu7_common.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_common.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu7_common.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7_common.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu7_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_discrete.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu7_discrete.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7_discrete.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu7_fusion.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_fusion.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu7_fusion.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7_fusion.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu8.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu8.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu8.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu8.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu8_fusion.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu8_fusion.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu8_fusion.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu8_fusion.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu9.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu9.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu9.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu9.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu9_driver_if.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu9_driver_if.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu9_driver_if.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu9_driver_if.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_ucode_xfer_cz.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_cz.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_ucode_xfer_cz.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_cz.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_ucode_xfer_vi.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_vi.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_ucode_xfer_vi.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_vi.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smumgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smumgr.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smumgr.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/smumgr.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/tonga_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/tonga_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/tonga_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/tonga_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/vega10_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/vega10_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/vega10_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/vega10_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/vega12/smu9_driver_if.h b/drivers/gpu/drm/amd/pm/powerplay/inc/vega12/smu9_driver_if.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/vega12/smu9_driver_if.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/vega12/smu9_driver_if.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/vega12_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/vega12_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/vega12_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/vega12_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/vega20_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/vega20_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/vega20_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/inc/vega20_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/aldebaran_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/aldebaran_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/arcturus_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/arcturus_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/arcturus_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/arcturus_ppsmc.h


Generic comment -
	swsmu/inc => Only common headers
	smuXY/ => All specific headers

Ex: smu11/smu11_driver_if_arcturus.h

Thanks,
Lijo

> diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_arcturus.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_arcturus.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if_arcturus.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_arcturus.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_cyan_skillfish.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_cyan_skillfish.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if_cyan_skillfish.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_cyan_skillfish.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_navi10.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_navi10.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_sienna_cichlid.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_sienna_cichlid.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_vangogh.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_vangogh.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu12_driver_if.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu12_driver_if.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu12_driver_if.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu12_driver_if.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu13_driver_if_aldebaran.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu13_driver_if_aldebaran.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_yellow_carp.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu13_driver_if_yellow_carp.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu13_driver_if_yellow_carp.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu13_driver_if_yellow_carp.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_11_0_cdr_table.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_11_0_cdr_table.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_11_0_cdr_table.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_11_0_cdr_table.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_types.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h

> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_pptable.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_pptable.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_pptable.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0_pptable.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_5_pmfw.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_5_pmfw.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_5_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_5_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_8_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_8_pmfw.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_8_pmfw.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_8_pmfw.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_8_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_8_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v11_8_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_8_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v12_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v12_0.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v12_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v12_0_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_1_pmfw.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_1_pmfw.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_1_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_1_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_pptable.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_pptable.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/pm/inc/smu_v13_0_pptable.h
> rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_pptable.h
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index a03bbd2a7aa0..1e6d76657bbb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -33,7 +33,6 @@
>   #include "smu11_driver_if_arcturus.h"
>   #include "soc15_common.h"
>   #include "atom.h"
> -#include "power_state.h"
>   #include "arcturus_ppt.h"
>   #include "smu_v11_0_pptable.h"
>   #include "arcturus_ppsmc.h"
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 3c82f5455f88..cc502a35f9ef 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -33,7 +33,6 @@
>   #include "smu13_driver_if_aldebaran.h"
>   #include "soc15_common.h"
>   #include "atom.h"
> -#include "power_state.h"
>   #include "aldebaran_ppt.h"
>   #include "smu_v13_0_pptable.h"
>   #include "aldebaran_ppsmc.h"
> 
