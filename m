Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCCFCA5FB3
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 03:06:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EDCF10F157;
	Wed, 30 Sep 2026 03:06:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MbN4tE8E";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010031.outbound.protection.outlook.com
 [40.93.198.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABB7B10F157
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 03:06:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7S9egl7lBNGlG8ccHG6Wya7PbzyjAZhojSzkNo6hRsecrzkwGv9m3fmXfJv0xHB8NZX9raJaco9/A/6igm1W8u6ozomyVhxKlqg7nQSzwMhhZlhiwZZfW5iPQ3HZdQDPUIJTOS8ExUf7bJ2iCMjq90U3USVHDVd9YGdZz5OEsGuuFrN7aCDgEFLn5VfvcjkmJ+u/3+bcEAakDr0VEEWM+gi3+mSts9YXlVYdEcfBpk5OncLqJDzI/5aocR0n4Eyod3nm+2xX9J2kqdulF7EHv5vyv44FyvJBhFVCV2B1WXTEMzUwXyusPIOYzD/KeiySW/OILWKlFYDjKtQJ6oqOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dft58y7R7zwG5ci6jdKqTIRbO6ePjRuvxdDxP1hyJQ=;
 b=DWdGkJltbMYBc/Ntdw8cgbf7sjastKDZgh4IWP6UD9Lky4stFGRropArIP+1lDZqk9Ov3UlMVKqh/NGfYBjYhs3xGL73owVOIdv0F/wasuW8PL49ZvuN81plZzbdUUFv5zRqVIbkLkATOX7UHDSlVl/4zgAdwJdgsSv32n4HMjG6BLgOF3ttFFtqKcls+JXk1arx+t3JbVvPY61mQe50JHnGj6+uHZWBGR2VCEwKW5mpNfPhTmiOC8feItsHh3B6kdFTP8N7WHDZx7280ac83ugzkZw3SUo+AOk86nKKSNLqvAcHTFP/Ufbbg/qI2PS3KpKzVgE1JHmTvRccdlS62w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dft58y7R7zwG5ci6jdKqTIRbO6ePjRuvxdDxP1hyJQ=;
 b=MbN4tE8Ez3ss4D5Jf6q3yJROi63CjIVjPBbDc5gElYOQbgaHVWrpB0H74Lu3XlDAjifNpx5mHg1ThOaNGBKJoYbeQtIjO669t/ng0dOtfb5sUAgL/Gh+lP53br3037FmvbZNu8oDFVy15SywijXvenpVEl1Iq8N8Fr2OseIN2zM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MW4PR12MB6804.namprd12.prod.outlook.com (2603:10b6:303:20d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Wed, 30 Sep
 2026 03:05:57 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 03:05:56 +0000
Message-ID: <6b086b84-deed-47ec-ab7f-8cc016ab519d@amd.com>
Date: Wed, 30 Sep 2026 08:35:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset on
 gfx12
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Yuan, Perry" <Perry.Yuan@amd.com>
References: <20260929022540.122318-1-yifan1.zhang@amd.com>
 <f9db848b-da68-4acf-a0e3-41464b939817@amd.com>
 <CY5PR12MB6369B765E89F17858A5AB4A8C18C2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <BN9PR12MB5146D08AFE80E7E6EE34B614F78C2@BN9PR12MB5146.namprd12.prod.outlook.com>
 <CY5PR12MB63694BE5CF3FB172F837CCBFC18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CY5PR12MB63694BE5CF3FB172F837CCBFC18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MW4PR12MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b3b0917-158f-4373-cc89-08df1e9fbef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ScB4h1cHE2pFVvndQGtlRQ51meM+o/KHu7Tyn1sFKUfi5PYkKRDzpoKXuDkaxnw5Qirr3HhhzYykUZr6K2eJqLW7otzLdwoF3s+mzin+V5p66e6rormBnRP3yXxgP1EVpZOJyxODFZC3db3heX/kaJ9DvRzCuzwq+1fnFkfmGYodTVZ1Imclu7rJ+scMm2ited4qDX3LQ1utKJA5fp0HHB99mL+g0ZSUJDIl5+hUUpvRCp6OVcpcbUw8BZMyZOpght92DjDEMliHI0oyDsjoXZGyninnaX+tEMfZ9njOdcycM7bgIme4axiZNF73xwTXkcLa8yaPktuiUYXVF/A0oEoInvPrtQ+b3TtBqVcu+3JBi9t03/DgEOMb0G5nKf5zOLnhqg9tAHgi1FQC0WRjmsfbr1P9H6xRyGcvRlHyqCRYNiCwicW5FQJ/rUrdI73UjinhYQA1/GmWHMeLZd7CR32iGm/qT3eoyhKC9ZdYUocjJtEwpuBqXm5FMbOSKmu1r9LAnY8836f1LNM0+GJNaBFKVm8wt7jW2kkkfm4S5gFGLyDO1gSQWUyprXA3rD3Pp0dOIW92Ber8ZijZswba8iPJFXYNANVyDaWUscJt7FJlqTI0BHdA66KYXDX+uw1d4/L2Bck4v77L04xcTkfgYV0inERQVPugr375AmBBTPQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnhPSGd4UWxoV2VTRTZ0VHdGdHBQeG84WG1uWE55TzUycDdkeGhIdDV3UHQv?=
 =?utf-8?B?cEluK0Z4VHpvelVHQnRCbVNjNyttMWwwNk13K2tSdWpxVk5vVVZSVTBUbVZn?=
 =?utf-8?B?Mmg3dXA4dko5MjJyaTE0NDFTaStlZUpGMGFCcU1lNTlnZ3R4OHRGK2xWYjNC?=
 =?utf-8?B?emVlWHZKQWJlSk1MWkZhOGR3QlliVEU4NUhnMllzVXRkdXB6cThFTFlZWnNs?=
 =?utf-8?B?azVNemgrTGJveVhRMnh4UmRqcGZSRXhia2gzTHAxaVFkMHc5d0NLdEVzQlN0?=
 =?utf-8?B?TWQ1WTlSMkUrbzErOTg3ZW90RkZLbkVpb2UwT1l6cCtaaG9sT0FNOVlLSFVB?=
 =?utf-8?B?WGFHOE1ycTcvc05KSlRtZlMwckorUFNkQjVXWXFyalN2dFpkSC9lTmhZKzhu?=
 =?utf-8?B?K3hpM1NoZTRNU3BYYnkzRkNTcGZOVVpkVUM0a1lscGt5Z0dTQnIzbDdITGNl?=
 =?utf-8?B?QUhvdEliVzYwN1F0bjNjQlU4OU9oRXBVZjZZMklmTFpiMENEYkJXUnRheUJJ?=
 =?utf-8?B?WWRERUo4UTViZFRta0I0cFhnbmVMUVU1K0VzN1JzS2lnZjVSZ3ppRlNSQmxW?=
 =?utf-8?B?Nm44Y1l4ZzgwWExBSWhKU1pBUTlDMFNINitWUmQ2dVRJUFJYTThaZWJtVDA2?=
 =?utf-8?B?NTR6RzJieHQ5djJ3Z1hycG5oVTIrbE1uclphblZEOTVGM25ZVHl4VUhFa2tH?=
 =?utf-8?B?M1JCUFlaNUl4eDVUdlI4SHk4UFlNTC9qODBVK3lNRkcxeURyZUw3My8yMzJG?=
 =?utf-8?B?Y0t0OE9pMldkODgxc2VwTzlXNDNtdmxnNEM4ZktlUkFwZytTWE4wSXg5Q2Ni?=
 =?utf-8?B?OXc0ZlBYOExwb0hISnJsbWVsZFZnejRWTjNkWVNDQVZZaTlRd1BWZWdjQkhU?=
 =?utf-8?B?dzBoSENmZ0Q3SCtoNVkvYzI0aitPSXhwaXZHVHNQNS9JMVRiSGZ5d3dVV0Nw?=
 =?utf-8?B?WTk2dTh5dzNCSS91K3o5aVNHejNVbjlNWm5mbXgyQkZidW02WVE4Y0poS1BT?=
 =?utf-8?B?K0hZTGxqcjV5U2R6RkJKZXY1ZmRjdHNwdGNLbWlNT3NXMXh3MDBLaEZTZlJM?=
 =?utf-8?B?K1F2Zmg2UUdXN2tDeFQxeVJIUnZmbXBtakw3R1BPTG5jS2VhZFNQVzI5ZU8r?=
 =?utf-8?B?b0ZweU94OHYvWTNFOGpmTjVJUTcybElPV3Y5cXh5d01WbmVWZExuSnNQVWt3?=
 =?utf-8?B?Zk15RFpxZnpFaEYrbHNWWkVFY2lvUDVaWVJIYjJsWE9sUVBEdGt3TUdFa0Ev?=
 =?utf-8?B?YS9QM21tVU41S3grS0JWUHNCa3BMME93N3ZJOUhsSDB0VEZwY2ozV1NDdnFM?=
 =?utf-8?B?Y21YUTNhZ3Q2akE0VEVMWjRlZ2Z3TjdZSjVhemNReU9wRnpaUFdVeTZCUXBM?=
 =?utf-8?B?cHc2U09PZnJ2LytXSkprWW9UWGtiVlEwc05iblFNN0lkT3h4cG5oaGxQTWV1?=
 =?utf-8?B?ckxwdjRmTTkzQWJ2UWZEZlJXcFd6RFN5cDJSOGtUSEpJOXU4SitxdVFYMVZz?=
 =?utf-8?B?MHlObnVONlFQQnpUWElCck9TTjc5OHZvbndYeHFSQ3Q1cDBGcTN2WUc3RXJq?=
 =?utf-8?B?aXRTRTIyOU1la2o4RWZ1RnhqRlhRTHRLbmJIRDM0SWtLdW9lUnNnbDB4eXJH?=
 =?utf-8?B?VGtueDYxZEc3aEJHSE56MzR4VUhYczZFelZmWWxDZmpnRDRrbWtuVktiWTJR?=
 =?utf-8?B?Q0VTNGVJUVB4Y0JJcWZTb1hIcG8zcEpnUzAvNDNjNStod3JEVHRENXNLL25x?=
 =?utf-8?B?Q2psdmNVNXJDdDRFYXBZNFZWbHBMaytVMnY1bWpMOEJ4VjZIaWZFSnZRWWFj?=
 =?utf-8?B?WEpycWpwazR5YVVKT1JpaURHT051KzF3Z3hmM3dFelFwZnU3bnRpcXVMRUtD?=
 =?utf-8?B?dndyQzRDZGRtL3FuNnBna2MzSHU3MnYzNmZ0SUdRNHV1VWVVandadG14aWoy?=
 =?utf-8?B?bjE1ZEIzNmdRRnNIWXN0cHRwNUtod0NlWlA0NmRNVWt3OUthanR6RmpkTFJV?=
 =?utf-8?B?YTk2WDlIYk1DZHA4WnhLZEQvQTNyTlJRelhIeVl5b1RnRkFRWEgwSjhCdGVP?=
 =?utf-8?B?cXQwMWEwa1lkbzk4ZEp6QjlzNkkyakllTms2K2c5NENWNGVmVDZoaGVBVW1v?=
 =?utf-8?B?RHJwNzNWakR6cmN3bFVNN2xZazRUNUVJaDc0U0hTZjFRRHMrQ1ZHdldVeUpr?=
 =?utf-8?B?RURZU0VCdlNETDJwakovU21zS2dwZG9Uc0RmZVUrMFM2dTJiUTlJN2RncXA3?=
 =?utf-8?B?TVEzQkh6L2l6cHk4WldjM0ppdUthdzUwVmNSeGlvUmIreE1MM2lwRkN6MjVn?=
 =?utf-8?B?MmZJeXFqSHVhTGRyV2VpT2hwUDM4WGcxZXVLdXpNaEZvK0VBT1JRUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3b0917-158f-4373-cc89-08df1e9fbef1
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 03:05:56.7227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQLvg+d7ifJmckjgSTgTJQY1PQsUjXO099YcotlCOzCSpLWWEMKTyyThDJ3UmNnD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6804
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

This doesn't work for all (at least on some datacenter GPUs). With AER 
enabled, this will result in AER errors. Depending on the platform 
config, some may classify this access as fatal.

Thanks,
Lijo

On 30-Sep-26 8:25 AM, Zhang, Yifan wrote:
> Public
> 
> 
> Hi Alex,
> 
> I think it is reasonable to apply the patch to all ASICs. I will sync 
> with the hardware team about this change; so far we have only tested it 
> on Navi31.
> 
> How about adding a common helper and calling it from ASIC-specific code, 
> starting with Navi31? For example:
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/ 
> drm/amd/amdgpu/amdgpu_device.c
> 
> index b690a07e31ab..075de681ab86 100644
> 
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> 
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> 
> @@ -4931,6 +4931,28 @@ bool amdgpu_device_should_recover_gpu(struct 
> amdgpu_device *adev)
> 
>                  return false;
> 
> }
> 
> +void amdgpu_device_mode1_reset_wait(struct amdgpu_device *adev,
> 
> +                                   unsigned int delay_ms)
> 
> +{
> 
> +       u16 saved_cmd, cmd;
> 
> +
> 
> +       pci_read_config_word(adev->pdev, PCI_COMMAND, &saved_cmd);
> 
> +       cmd = saved_cmd & ~PCI_COMMAND_MEMORY;
> 
> +       pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
> 
> +
> 
> +       msleep(delay_ms);
> 
> +
> 
> +       pci_write_config_word(adev->pdev, PCI_COMMAND, saved_cmd);
> 
> +}
> 
> +
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/ 
> gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> 
> index b250c5e41e45..356e09b7eef9 100644
> 
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> 
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> 
> @@ -2242,7 +2242,8 @@ int smu_v13_0_mode1_reset(struct smu_context *smu)
> 
>          ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
> 
>          if (!ret)
> 
> -               msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
> 
> +               amdgpu_device_mode1_reset_wait(smu->adev,
> 
> +                                              
> SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
> 
>          return ret;
> 
> }
> 
> Best Regards,
> 
> Yifan
> 
> *From:*Deucher, Alexander <Alexander.Deucher@amd.com>
> *Sent:* Wednesday, September 30, 2026 2:59 AM
> *To:* Zhang, Yifan <Yifan1.Zhang@amd.com>; Koenig, Christian 
> <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
> *Cc:* Yuan, Perry <Perry.Yuan@amd.com>
> *Subject:* Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 
> reset on gfx12
> 
> Public
> 
> I think this should be asic agnostic.  Any asic doing mode1 reset should 
> do this?
> 
> Alex
> 
> ------------------------------------------------------------------------
> 
> *From:*Zhang, Yifan <Yifan1.Zhang@amd.com <mailto:Yifan1.Zhang@amd.com>>
> *Sent:* Tuesday, September 29, 2026 5:36 AM
> *To:* Koenig, Christian <Christian.Koenig@amd.com 
> <mailto:Christian.Koenig@amd.com>>; amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org>>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com 
> <mailto:Alexander.Deucher@amd.com>>; Yuan, Perry <Perry.Yuan@amd.com 
> <mailto:Perry.Yuan@amd.com>>
> *Subject:* RE: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 
> reset on gfx12
> 
> Public
> 
> Hi Christian,
> 
> The no_hw_access flag was first set in commit 
> 0de604d0357d0d22cbf03af1077d174b641707b6. This was intended to fix the 
> Mode 1 reset hang, but it proved insufficient.
> I think the flag was set in the SMU code so that it would apply only to 
> SMU13/14 ASICs, without affecting the Mode 1 reset process on other ASICs.
> I’m not sure whether we can drop the no_hw_access flag after disabling 
> PCI_COMMAND_MEMORY. The PCI hang occurs intermittently, so we may need 
> another round of stress testing to confirm that the flag is no longer 
> needed. Should we remove no_hw_access in a separate patch?
> 
> Best Regards,
> Yifan
> 
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com 
> <mailto:Christian.Koenig@amd.com>>
> Sent: Tuesday, September 29, 2026 5:06 PM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com <mailto:Yifan1.Zhang@amd.com>>; 
> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com 
> <mailto:Alexander.Deucher@amd.com>>; Yuan, Perry <Perry.Yuan@amd.com 
> <mailto:Perry.Yuan@amd.com>>
> Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 
> reset on gfx12
> 
> On 9/29/26 04:25, Yifan Zhang wrote:
>> block GPU PCI bar access during mode1 reset on gfx12, to resolve the
>> random mode1 reset hang issue.
> 
> Interesting idea, that is much simpler than trying to mess with CPU page 
> tables in the GPU reset path.
> 
> The only downside I can see is that we now drop VRAM and doorbell 
> writes, but I think that won't matter since VRAM is lost by a mode1 
> reset anyway.
> 
> MMIO writes are dropped as well which means that we can also drop the 
> no_hw_access flag.
> 
> And BTW the SMU code should absolutely *NOT* touch that no_hw_access 
> flag in any way. Who added that there?
> 
> Regards,
> Christian.
> 
>>
>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com <mailto:yifan1.zhang@amd.com>>
>> ---
>>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 29
>> ++++++++++++-------
>>  1 file changed, 19 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>> index 072d9c4e202d..25b9085ead71 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>> @@ -2078,21 +2078,30 @@ static int smu_v14_0_2_set_df_cstate(struct
>> smu_context *smu,
>>
>>  static int smu_v14_0_2_mode1_reset(struct smu_context *smu)  {
>> +     struct amdgpu_device *adev = smu->adev;
>> +     u16 saved_cmd, cmd;
>>       int ret = 0;
>>
>>       ret = smu_cmn_send_debug_smc_msg(smu, DEBUGSMC_MSG_Mode1Reset);
>> -     if (!ret) {
>> -             if (amdgpu_emu_mode == 1) {
>> -                     msleep(50000);
>> -             } else {
>> -                     /* disable mmio access while doing mode 1 reset*/
>> -                     smu->adev->no_hw_access = true;
>> -                     /* ensure no_hw_access is globally visible before any MMIO */
>> -                     smp_mb();
>> -                     msleep(1000);
>> -             }
>> +     if (ret)
>> +             return ret;
>> +
>> +     pci_read_config_word(adev->pdev, PCI_COMMAND, &saved_cmd);
>> +     cmd = saved_cmd & ~PCI_COMMAND_MEMORY;
>> +     pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
>> +
>> +     if (amdgpu_emu_mode == 1) {
>> +             msleep(50000);
>> +     } else {
>> +             /* disable mmio access while doing mode 1 reset*/
>> +             smu->adev->no_hw_access = true;
>> +             /* ensure no_hw_access is globally visible before any MMIO */
>> +             smp_mb();
>> +             msleep(1000);
>>       }
>>
>> +     pci_write_config_word(adev->pdev, PCI_COMMAND, saved_cmd);
>> +
>>       return ret;
>>  }
>>
> 

