Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F14DEE6420
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Sep 2024 02:09:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 607B710E844;
	Thu, 12 Sep 2024 02:09:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kiwXNP34";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C525B10E844
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Sep 2024 02:09:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrVYa5AoBf+9of4JYY7uOgEtt0CxeDLwhjag327/BDfVndcPPUag7s/ZSDI6A0N6Z7XjXZcdwbXqFuRGuIfy4cJiiuOanhKZOSlnMOyC77A4MvRlFVoCxeHuokyYL5a0jRu7r1GxqHuzVCso9wbTxJa/ps4lbUcyhAP+lAH4xbRFUSKFxt39rbSjftbham7KYldGk5/G2dgK49ZdmCmOvosPd64TVBx9QNRyv6IiH4vATWKoNyfJiQ3VCLTIxevDI79yyJ0sql9lCMqdIS+Yie7nYc8Mm2pGHQU9qtgVS/y/N1g5x/5i7+LCbS3ymGrNhvZj7h7A2qY5E6Lipj2C6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cs6gjLg5pSWU+xK0R5FBna0JhKRwBh7HUAQnNlP/tGI=;
 b=VC/LY1VBNYM/VPfWGcJoknFAYgDgQIWGGFv3cj2I39FH+kpbXnAniCeVezOtuiyLiJc+L9/1glzn/dDs3BIOuC0oifu5ru0x62K0gmYEEnxvhZKBC1lUOo/RE6peqRSuFMrrWxVTbTY89LzJbxwR0MaZywMZwiB155VyxQa6snMxmlvoForjY3Phhpx5p2Eb9iRZ+ZRa1BiFoh05v7oZFB/rN1pIeK9SAgsLbVEVzRlXRP2Zp1c3n3Iawpnm3wY3o41PUPSqJM7/tF9wIVMPoN46DzNRB4VYduWWRBXa7y/AdByhCM67UQsFYYGB9qSyeEpiFIDTyJ2lDAyY5Ccp+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cs6gjLg5pSWU+xK0R5FBna0JhKRwBh7HUAQnNlP/tGI=;
 b=kiwXNP349JXQKNeHhQ8nw81XY55078NkWxocXSy/Hd8sYsfAY6uOKcFs9VdesM1TTCgmiloK9ITZTCocKOeAXvkkFxykLl0Z2aj9dj0wihFjfoPUlWF1Ooua6ceHAQoCdaf39uIJpLLfZ/A9A7RjNXngkA+g816N1ihXeAzZL78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) by
 SA1PR12MB6800.namprd12.prod.outlook.com (2603:10b6:806:25c::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.24; Thu, 12 Sep 2024 02:09:33 +0000
Received: from DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::6f01:2f45:71e4:653d]) by DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::6f01:2f45:71e4:653d%7]) with mapi id 15.20.7918.031; Thu, 12 Sep 2024
 02:09:33 +0000
Message-ID: <ad24e421-c24c-409d-9823-e128e2fde7ad@amd.com>
Date: Wed, 11 Sep 2024 22:09:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] drm/amdgpu: Add init levels
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, feifxu@amd.com
References: <20240911065858.2224424-1-lijo.lazar@amd.com>
 <20240911065858.2224424-2-lijo.lazar@amd.com>
Content-Language: en-US
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
In-Reply-To: <20240911065858.2224424-2-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::48) To DS7PR12MB5933.namprd12.prod.outlook.com
 (2603:10b6:8:7c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5933:EE_|SA1PR12MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c26c2a8-a4f5-4182-0dbd-08dcd2cff149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGRTVGU3d2kwREtzRmZacGxoaHhVZnlzbnJLNlZ0QUdSSlBnSHFOZ1I0dG5s?=
 =?utf-8?B?aHJMNFFIVTNYRXRsUlpUVWsyTnFWcFFrMjRyNW5EVStBZjJXU21iUFRCdi9S?=
 =?utf-8?B?a1RjbXdaTm94MGZUdGY3MjloQmxqc3VNNnhkb1Q4aTNWYWpBR2ZjSThkT0Ni?=
 =?utf-8?B?c0tTbkZjeDh3cVFlV1IwU2hPU1NMNkFEVUM1aFZIaFgrZ2hxQ08wYkJXeTFD?=
 =?utf-8?B?MHMzMitsaUt4WFhVeFI2TUVIRGdHTG91cWpzVEZpUndXYitvUjhpcU5zQ21Z?=
 =?utf-8?B?ZEM4OXRNazlVR2o4dzhuejNrSzcyVEEvQVVMdjMwTW04eDBPdlArTGZocENk?=
 =?utf-8?B?QW9wL3BJT3ErZTRjTk1NMjJ3NnBEaEFVWURPQzgweWpxREVXUzNxaGlVQWdV?=
 =?utf-8?B?QUhvOTBNZ0FTT0VtODhKdGUydFVacUVrc3FxaHhjNmFpVDJhS1g5NzFFdEk1?=
 =?utf-8?B?Y3pKdWg4c2VUQkoycGZmTkNLMzhpZ3k2Q2Nid0dEUWkrdWdoMGM5bENBV0U4?=
 =?utf-8?B?aTYzejNnTHVCVXF6d2N0TWxScXlZZ2NSMkxtei9EYUE0TmEvUHM5MXVLRnRV?=
 =?utf-8?B?VkR3VDU1TUVvT2laR3g2T1JmZU10ZFJzYUh1Q29lKytTdnNFMzdMRlZJNXhL?=
 =?utf-8?B?Tk5DSE52YWoxYnZhQnJMUWlVMTROZFg1TERob3k4YjU5U3E4ZitVMUt4Vk1R?=
 =?utf-8?B?YmxtT0Y2V2hjK2tRQlM0bDhpOEN6bVlvU2dlaStaTFk4RzVmNHpScTRLYUFo?=
 =?utf-8?B?QkVRLzB1TnpRR2ZacDN2N1Uzdm1VQUNXV0VIdit3Y2RCRFFLTlJiQ2I5Q3pC?=
 =?utf-8?B?UUV2czVvSDROMWxzbUtEaWJJL2V3bkFHU1BJekF0YW9yNVl0WjF6WDM3R0lD?=
 =?utf-8?B?RW9obWZVZ2J3RUZ1UEJBVG1TVmFzQ1FMZzFBZytGN3FZdU1HWElqOXNHWmFu?=
 =?utf-8?B?VWd6a0ZlYm9LUktqM2JiRG5FQlJEL2FISTcwYUpBWGF4cDU5VitiOHdqcmg4?=
 =?utf-8?B?Z09tQkxGQ1pleDRPTm41ZVZyVnBvbUZBUk4xbDM2aFpmUzdnTDlxN3ppMjRK?=
 =?utf-8?B?OURtcnEzQnpoM09SVEU3TEZ5Q2tMcCs2ZjUwVDIxcnErcUd0ZVVmMTA2Mlhx?=
 =?utf-8?B?d3Q5R2VzMTNZTFN0UDd0R2crbHRmajFLM2xHZThSb2NDTlZkcXllY2M3TW1D?=
 =?utf-8?B?bEp0VTFRajBPUHA3aDdPNERacTd1ZkdZUFAwTUxtWExOMm5CQllEQXoxeVNV?=
 =?utf-8?B?NmFOY3phK005dlN5ckhrbnpBWTk1cmlEVjZPc3E3ZmU5NVBiL1RHTXRQMjFs?=
 =?utf-8?B?MUZrRG5ZMHZzK0pOUEEzaERTa3B2aFlkYUpndmp4Vk9rejZMaTh6aVRXcW5h?=
 =?utf-8?B?dEVESDMvNkFFczh5WFBma3ZteWNWREhra0ZTNS9GRGdYQmtyWEo3a056T2hR?=
 =?utf-8?B?T0JjUUxpd044S0o5aFdoL1poNjBGL1dMN2taMUVBYWpLbkhaZDh4SVRKOUtz?=
 =?utf-8?B?SWsvR0pudElGV3VEV0ZHdmxjM2RnT1EwK2J0S0ROWFc3TExibW1oOTZtOGk0?=
 =?utf-8?B?eWE2clZGSFRYOGtIdURmMVRWUEpWYWhQc200RmJQMlNtWjdMd1lBdEJ0YWVn?=
 =?utf-8?B?QlpjSzcwNy8wem0xd0dLZkRMaW5rc1FTT2M2TGp4Q1dNazkzUlRRb0lrcm5V?=
 =?utf-8?B?Ylo3d3hsaUZFYUpSTWZudlVJa25lUHg5eVI2UkVKY1dzT0lNeTdySXBxSGNJ?=
 =?utf-8?B?RWRqMFpmZ1ROQnIrN3NyZUlVV2xWeWE4a253UUJVdGFpOXFrZDBKeGZHRmRE?=
 =?utf-8?B?cEorTjhIejFoOEZBSWRoZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5933.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXp4UmdOWU5GaU53ejZ2NnZubzc1emNodHhIdnlXYnE0NFMyamsvZFM1V25z?=
 =?utf-8?B?cDFoZTg4OVY2bW44RTN3WGNxaXNhNDFxMXQ2ZzdOd0FLblYveXBaUkpRbmda?=
 =?utf-8?B?TWhPZU5SUkFWM3dZV29Pc2JuSCttMCtra2V0eWhNTmk0UWpnKzFNRUVCN2hm?=
 =?utf-8?B?SmZhU1RBcEdCb1ppam5JVWVLSE8yL0lSc0U0TU9ybEtDeGlUS0lxeGR4dWJN?=
 =?utf-8?B?ODE3LzQ5THI3a2h4NWx3MXB4NFY2U0Z6OEd4UlRmZmUxb2pmSHZvN3k2aHZz?=
 =?utf-8?B?WW85UEc2KzVNOFRHWUF0d0J3cVdHZVkwRjcraEpLeXExMnZEdDJpYnhkTUYz?=
 =?utf-8?B?VGhuQmxBd0VXSXhQQ0VFb2VGS0o1M3FKdmZVSUFlQmN3aGlGeUxHRzFQNE15?=
 =?utf-8?B?Qk05dkJDMlhNblkwd3ZWVDBoNXdDOUd0bXhqc2svbHM5NW9MSDhTcitkemJ6?=
 =?utf-8?B?aG1Gbmx1WS9iSlh4elZyQ0NvNTgxRE5Ob0lHalJwMHkyUlJkbWhIR0pwYW13?=
 =?utf-8?B?Y0hMTDA5aC9WanZJb1hYM0NBdVRKN1JCSGVhUG1jMVZ5REloc25mS01OeXFo?=
 =?utf-8?B?UDdGdnZwc3lnV1pIcGRIZkRmb0s1bFF5MzhIcG8xK2tLdmxlb01lTFI2U0lY?=
 =?utf-8?B?cGwwMXk4R3dieFdJMzA1K0RnU2ZscmtOL0ppWTB2UGhFaTJPUkhvNks2U1JU?=
 =?utf-8?B?SUxMenV2MDVnMUtHa0w0RTlkYXFNdGRjaWpDd0E1S0p6NWZJdVdaNEZJTVJT?=
 =?utf-8?B?aFNnOHBJZ3M2bjI1bEJnZjlXMjlRakRwLzJoYTlRZGd2SFVldXIwVU56Vzky?=
 =?utf-8?B?Q1dvazJTbHVaZ0FwRlBZUWNzODdWQ28zanFyRzV6UG0xRVdSaDhqSVB1YTdH?=
 =?utf-8?B?QldibVNuSjFnNmIwSW0xcVRCQTFFM1RCdDJsV1VvTEtaMkpSclpDWlJQZ3hU?=
 =?utf-8?B?OWV4Z2JUZ0t2b0hmSHgzTVVWNExhTlFQTlRXQm9EQ0dYY0JlR3V1Z1hBUkkz?=
 =?utf-8?B?V2N4NjlNRSs2SzljTFBUSUUvZGJ1ZEJpTUhTSjVDTU1NRVpiSWJmRVEvT1NM?=
 =?utf-8?B?WFkrWlNoNEZaSzdUS205Rjc0b1dBa2N6aUh1Vnlad1o4VlNjY0JWVHR6OFBC?=
 =?utf-8?B?ZVJKbzYzU1hnSG1vYi9NSHliWGcrVnZiVXBKTEY1RVNJUzh1TjJneG5PUzdq?=
 =?utf-8?B?RUUycElrT0x2TEdQUG9IU3JrbmY2UkRLMzA3ZWhjMnpvSFgvZnFEUitaRE80?=
 =?utf-8?B?dGY2Y01YazhLSVE4Zmo4VmlqUjdiVDUrQ3dqRjZRbUFIOWl5bXdYaVNxUHNm?=
 =?utf-8?B?WTBieXlVNTVpRDFTcXFIRXlsVzlCRkRCR281cjN5czJRUXZPN0hsQTY3TnQz?=
 =?utf-8?B?MlUzOVVSUEZZYURkVEpWWWhtZnZiVnVWWkdWaWxveDhaTGxNV2dGUVViYURv?=
 =?utf-8?B?TndhWUVqSlVobURHTEpZRnFoT1BxeTZHNjQwbUY5emJKdUptRy94MHFERkZm?=
 =?utf-8?B?Nk02VCtLeU10T095SnIxK2F6S0toV1I5dFp4ZEdTT3pmVERGOWp5TVE3dDZF?=
 =?utf-8?B?K2E1eUVOZDFqZ3Q3R294TWdGZFlIdU5jNWNiVlN6Yi9pM1B3UC9iS2pKRUVJ?=
 =?utf-8?B?aWlMb1doUmRGaXNWLzMzcWlYMjFkaHhpUHpXTVFSNjhpeEg5QlZ4TGRWSTBi?=
 =?utf-8?B?VlE3VzMya01paDNjOHNwZktyWWdaeGNjZ2hpbjNiaTNpZkhYV0s5MUtzNGxD?=
 =?utf-8?B?Zlltd3J3eEsrSU1KamlCVmZDNG0rdVMzZHZ4SW1ZbFdyY0h0a0RpUGI1dnV2?=
 =?utf-8?B?UHBmUnNoWE9pc2NJVUlGWkdlMGVrUE1lSFdodHR0K1A2dlJCZjNxSlZ5c1FV?=
 =?utf-8?B?N0dmY3VyMlAwWEtCS2llNVBsYWtZKzN1WFMwWTF5djRVVUxaZ2JYVWgxcThB?=
 =?utf-8?B?dkdZMGRGV2Nkb1hQWUhQWlRCNEZVUStYdUt2dmsxN2xGelN4SStwbDBlRjZo?=
 =?utf-8?B?U1VGS3BmbTJnaU5ZbmsrMFIyd0V0ZGx3MW1kU0gzNWY4Qko5eDE5Q0ZCakxK?=
 =?utf-8?B?OWxtNHltbUtENTFJOHVKL0YrWHgzeDY5SzZWZHRGT21sTnE0UGxmUitDdytS?=
 =?utf-8?Q?1QGSNJuxlc9nQy2foGJeiYlhQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c26c2a8-a4f5-4182-0dbd-08dcd2cff149
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5933.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 02:09:32.9830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZsS3hm3QdjmgAFTIYj8J/Diz2quoqnrkcXQwouLOvcKyUHN0+A1lUms7xhjmfeaKy22rISCJZg1XGLxBaK+ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6800
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

The series is

Acked-and-tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

On 9/11/2024 2:58 AM, Lijo Lazar wrote:
> Add init levels to define the level to which device needs to be
> initialized.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>
> v2:
> 	Add comments describing init levels
> 	Drop unnecessary assignment
> 	Rename AMDGPU_INIT_LEVEL_MINIMAL to AMDGPU_INIT_LEVEL_MINIMAL_XGMI
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 22 ++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 66 ++++++++++++++++++++++
>   2 files changed, 88 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 6e6580ab7e04..d8299383af11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -820,6 +820,24 @@ struct amdgpu_mqd {
>   			struct amdgpu_mqd_prop *p);
>   };
>   
> +/*
> + * Custom Init levels could be defined for different situations where a full
> + * initialization of all hardware blocks are not expected. Sample cases are
> + * custom init sequences after resume after S0i3/S3, reset on initialization,
> + * partial reset of blocks etc. Presently, this defines only two levels. Levels
> + * are described in corresponding struct definitions - amdgpu_init_default,
> + * amdgpu_init_minimal_xgmi.
> + */
> +enum amdgpu_init_lvl_id {
> +	AMDGPU_INIT_LEVEL_DEFAULT,
> +	AMDGPU_INIT_LEVEL_MINIMAL_XGMI,
> +};
> +
> +struct amdgpu_init_level {
> +	enum amdgpu_init_lvl_id level;
> +	uint32_t hwini_ip_block_mask;
> +};
> +
>   #define AMDGPU_RESET_MAGIC_NUM 64
>   #define AMDGPU_MAX_DF_PERFMONS 4
>   struct amdgpu_reset_domain;
> @@ -1169,6 +1187,8 @@ struct amdgpu_device {
>   	bool				enforce_isolation[MAX_XCP];
>   	/* Added this mutex for cleaner shader isolation between GFX and compute processes */
>   	struct mutex                    enforce_isolation_mutex;
> +
> +	struct amdgpu_init_level *init_lvl;
>   };
>   
>   static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
> @@ -1623,4 +1643,6 @@ extern const struct attribute_group amdgpu_vram_mgr_attr_group;
>   extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
>   extern const struct attribute_group amdgpu_flash_attr_group;
>   
> +void amdgpu_set_init_level(struct amdgpu_device *adev,
> +			   enum amdgpu_init_lvl_id lvl);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 61a189e30bcd..2ecc70f220d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -144,6 +144,50 @@ const char *amdgpu_asic_name[] = {
>   	"LAST",
>   };
>   
> +#define AMDGPU_IP_BLK_MASK_ALL GENMASK(AMDGPU_MAX_IP_NUM - 1, 0)
> +/*
> + * Default init level where all blocks are expected to be initialized. This is
> + * the level of initialization expected by default and also after a full reset
> + * of the device.
> + */
> +struct amdgpu_init_level amdgpu_init_default = {
> +	.level = AMDGPU_INIT_LEVEL_DEFAULT,
> +	.hwini_ip_block_mask = AMDGPU_IP_BLK_MASK_ALL,
> +};
> +
> +/*
> + * Minimal blocks needed to be initialized before a XGMI hive can be reset. This
> + * is used for cases like reset on initialization where the entire hive needs to
> + * be reset before first use.
> + */
> +struct amdgpu_init_level amdgpu_init_minimal_xgmi = {
> +	.level = AMDGPU_INIT_LEVEL_MINIMAL_XGMI,
> +	.hwini_ip_block_mask =
> +		BIT(AMD_IP_BLOCK_TYPE_GMC) | BIT(AMD_IP_BLOCK_TYPE_SMC) |
> +		BIT(AMD_IP_BLOCK_TYPE_COMMON) | BIT(AMD_IP_BLOCK_TYPE_IH)
> +};
> +
> +static inline bool amdgpu_ip_member_of_hwini(struct amdgpu_device *adev,
> +					     enum amd_ip_block_type block)
> +{
> +	return (adev->init_lvl->hwini_ip_block_mask & (1U << block)) != 0;
> +}
> +
> +void amdgpu_set_init_level(struct amdgpu_device *adev,
> +			   enum amdgpu_init_lvl_id lvl)
> +{
> +	switch (lvl) {
> +	case AMDGPU_INIT_LEVEL_MINIMAL_XGMI:
> +		adev->init_lvl = &amdgpu_init_minimal_xgmi;
> +		break;
> +	case AMDGPU_INIT_LEVEL_DEFAULT:
> +		fallthrough;
> +	default:
> +		adev->init_lvl = &amdgpu_init_default;
> +		break;
> +	}
> +}
> +
>   static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev);
>   
>   /**
> @@ -2633,6 +2677,9 @@ static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device *adev)
>   			continue;
>   		if (adev->ip_blocks[i].status.hw)
>   			continue;
> +		if (!amdgpu_ip_member_of_hwini(
> +			    adev, adev->ip_blocks[i].version->type))
> +			continue;
>   		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
>   		    (amdgpu_sriov_vf(adev) && (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP)) ||
>   		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH) {
> @@ -2658,6 +2705,9 @@ static int amdgpu_device_ip_hw_init_phase2(struct amdgpu_device *adev)
>   			continue;
>   		if (adev->ip_blocks[i].status.hw)
>   			continue;
> +		if (!amdgpu_ip_member_of_hwini(
> +			    adev, adev->ip_blocks[i].version->type))
> +			continue;
>   		r = adev->ip_blocks[i].version->funcs->hw_init(adev);
>   		if (r) {
>   			DRM_ERROR("hw_init of IP block <%s> failed %d\n",
> @@ -2681,6 +2731,10 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
>   			if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_PSP)
>   				continue;
>   
> +			if (!amdgpu_ip_member_of_hwini(adev,
> +						       AMD_IP_BLOCK_TYPE_PSP))
> +				break;
> +
>   			if (!adev->ip_blocks[i].status.sw)
>   				continue;
>   
> @@ -2803,6 +2857,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>   		}
>   		adev->ip_blocks[i].status.sw = true;
>   
> +		if (!amdgpu_ip_member_of_hwini(
> +			    adev, adev->ip_blocks[i].version->type))
> +			continue;
> +
>   		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON) {
>   			/* need to do common hw init early so everything is set up for gmc */
>   			r = adev->ip_blocks[i].version->funcs->hw_init((void *)adev);
> @@ -4196,6 +4254,12 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   
>   	amdgpu_device_set_mcbp(adev);
>   
> +	/*
> +	 * By default, use default mode where all blocks are expected to be
> +	 * initialized. At present a 'swinit' of blocks is required to be
> +	 * completed before the need for a different level is detected.
> +	 */
> +	amdgpu_set_init_level(adev, AMDGPU_INIT_LEVEL_DEFAULT);
>   	/* early init functions */
>   	r = amdgpu_device_ip_early_init(adev);
>   	if (r)
> @@ -5473,6 +5537,8 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   	}
>   
>   	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
> +		/* After reset, it's default init level */
> +		amdgpu_set_init_level(tmp_adev, AMDGPU_INIT_LEVEL_DEFAULT);
>   		if (need_full_reset) {
>   			/* post card */
>   			amdgpu_ras_set_fed(tmp_adev, false);
