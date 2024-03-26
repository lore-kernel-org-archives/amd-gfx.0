Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E435CD11DF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 09:26:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 904E110E3F8;
	Tue, 26 Mar 2024 09:26:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ghcp1GOL";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2134.outbound.protection.outlook.com [40.107.96.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C53110E3F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 09:26:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHjA5/dGbzoFF7Rnpxg3i9J0tUQhDa1s7Sdm+hLlXf+3CSvIn/RAHMas6p350B67leFT09tQojUkCkgR7dP9QtQyEuiVpTKw8oty4a6K2xUzFJboVqlYtreszrMiUfuwkuoYxW491xAuCl7E8t/HUVtu1tbcaSonGU4E4na4cghb9DVcljnKVbuKs6PNLDkKAFQCy/RLTCF9NMFA8O7AZzaYdLW5WTjLNQ49RGZqrO6hhVqxv/zFz+GnAJeEI8nlnrcnRyzaxaZyZv+/t8dfrP1dR/NYecBeDIRo+oA70GOtVUtj8IUDbz1GrbSjyRXtnq/CNCdj/9zuAopXcR79Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cklyOwcC0wKBboxuhgqfTLDxRp9KXu0oKxMavz8NfZc=;
 b=YwI5CO5oJWeg2IP2/z6/Ipy3DJnx7FlSDxS2pN3edcCd6eKzoFaNf/9tLu3WAuDeNqq6CAE2ZuLARO4a63MCPRxy4RM/HEEKZRujpnP8Wjrn64V8XB9rPPzhAQYUeYKdddMc92hZX1pTdiKVHYNhSvh05eWV3p3wBU6ZnnC9wMVFqL57WovHC0Kc3EBvkr+cqxQmHDotMLsW4ZNUii4HFw6o87/7uTgBvAKScAkFIs1LJlaykGhtiE7/4I+3aM5t9kILwNX6XezXuHEV6RJyMa0gIj9z1nwSLTuE2KxTC9q4g9aol3ZseXx2SMR8XuoEE/SGb5gLxGwdxYVAApJSeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cklyOwcC0wKBboxuhgqfTLDxRp9KXu0oKxMavz8NfZc=;
 b=ghcp1GOLPLpw50MXXsWWMUfVRrFP/xTYHorJ9/sUnbA66fFbjgtIHvrgJOQzVIoEpIPLxTPZeZOHERm6WqYVLiXRxIzUmmsk5tQJon44N98rwtSQphXar+irfZIbCpc0LpexD5p5fxZwwYJp7rMClKo7BZwU9b4qzPDukJY7D+k=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.33; Tue, 26 Mar 2024 09:26:16 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 09:26:16 +0000
Message-ID: <1dab012d-a9a9-4d62-a542-5e4589140d17@amd.com>
Date: Tue, 26 Mar 2024 14:56:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] drm/amdgpu/pm: Add support for MACO flag checking
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20240325101559.2807629-1-Jun.Ma2@amd.com>
 <20240325101559.2807629-3-Jun.Ma2@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240325101559.2807629-3-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::32) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM4PR12MB6254:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S7N14V611/Rv5l+aYNWw8fnY+edapMDSWeK7niXXgAtcdi2Ya1aykBzc8q1c001xJ6Br2lX8QHBgiV33o7+BD/LiftrpKCIpcp4HCONKBAvNRhCTSURljiKgnchGr+bUtt1ZsJRAIcXHH4Wcy/9n9jOnNA3fcQhFEeiNf4LMDSaWd75o9hzAMIlvLyJVyKuQP8A/DnzX7eXJQyPptGbOshybIg4qO2UucPVuEiy4uIW4SYK7GwLu+He4xHq17fFfi/brdTf9NjYagdRQEoJ2t6gMoJeLyrQ8USO1ddIFRMycv5wsLovWFyzTm7OwL/tnsjGoAZeuWRandbz23ODe2YZT+b0069ZYRsr9FL+OZuKolYNl0pru8WYBh0PWZCaDxUx2RMPmaBtn0063UAVhvRvugZqkTZt+51s/pI+VsHhrfdNL0Z9ObgMXv/FXOVNdSP7FaJkbBGpsapuqQqKfX4tSTTcM0b5GugPdDlKmHZr9wCMo9ezAVXjjcCQ29jzRxR82vFDRUba9PEPBTJk49RTc73bu0YVxMMEQ4VTAM2SD09EAEDh+dikdzh7RDYxpNjAo40ZR0rjYa9d/rFjTI8GSxXIEC2rE0Hs90IM7xFK12cgdRCQxD0UC0C9oyQd63IPw8gj0tWZOnHECvlfCnDuBnQTBQq2BCcaBE8H6Qw4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXUzcEMxVlAwc01QQzZIZ2kwRmxJRjk5SHZULzBMT1ErVk5sZHQyTnNmNmRk?=
 =?utf-8?B?YVFmT0NGdXpQSzBRRWRkZUNmTjNCWTRweFBETXlNYit2eWlkQ2ttdUZqalgx?=
 =?utf-8?B?UGl4eFpPdnhSckRicHFuNDEyUGRic2kxK0pGS1REUnRKK3FmZUVEVmladEUv?=
 =?utf-8?B?QW50WW9QNGNNNG1zTmZSQkQvdDBQeURpSzR1MFFDOGVPUERqR1ZwQUQxK2ww?=
 =?utf-8?B?TDhnRlBtZFQ4VWZnblJFN3ViSVlVZThxWThzc29JRVlyKzJKZlBRUTM0RFRP?=
 =?utf-8?B?cHNuQzcrdVRPamFXUmRPUFRPSXQ4UmNEV01sU0x4RnIxRmUreXQrNW5qam0y?=
 =?utf-8?B?UU5Zc21VUTZNa0tUb3FnS0E2TjNoZ1F2S3NtbjMxY05ZZ1ZOOWpDaWdYMjFo?=
 =?utf-8?B?Mmp5eGRvdG8wR2ZmYlM3NGwvMkVDOUFNc3VMOGtkLzF5Qk5zRDE0bFN2akNu?=
 =?utf-8?B?cHVybi83WTV4eWJkeUFDVmZ2emhReU8yMnltN09aSFBaZEtJdUZVY3M4WURn?=
 =?utf-8?B?dWVDNTNzbVpaNjc2U2x0Y0JjdFJvME5IVmhIanRTM2xSWk1mWXhEQ0o2ZjJ6?=
 =?utf-8?B?N2ZMUitQd21NU1o2TVREaFAzNHh1b3d0K3dOTlBpMnI5TWdmNkJ3V29SNmI4?=
 =?utf-8?B?MmMrM2tjVW9KdXh0cmZqVTgxMkhVaitCeHgvNG82OVlpd0dUNUxINTJoTGhh?=
 =?utf-8?B?V21PYkZFSElRbWlDcmV4SU9pa1JHKzJTbExpR0I0ZUVETWRtVVQzNGFqTHRC?=
 =?utf-8?B?c1F2Y3pQUXJmTG5LaUtuZndlZDlKMDQyU21LblVaWXhieWhuOFJFTk56dHRO?=
 =?utf-8?B?WTl4cWxpWkVqSW9wVTBPL1k0UmU5Q1BmeVd4bTlZZGVYSlFKd0pzWWF2R0xZ?=
 =?utf-8?B?VndaY1FWVmFoTFdXTzc1ek5GUFJnb1dZVDB6b3hHR3hWN3l1cWRIZUczenFv?=
 =?utf-8?B?RCsvUGY5cHZWWitPUkhwNDVsRnkvczhPQ2J4S3BnSVQ3cUJQUWpDdE43ZU9P?=
 =?utf-8?B?SXUwY0V1VjdaUVpxQktnQXlLVGhoZy9TR2x1N0dSbm5sdHBiMTJORWw1ODBG?=
 =?utf-8?B?ek9iU01TTlRiWklvSG9wUXpsQWd1aHE3aEhlYnd5MERobVZjZ2Q3eGROeE9O?=
 =?utf-8?B?ZmJHcHprK29odStmdkZXT3VWa2lLRmtqcmw4Z2dydVMzTFJSRWFKclhoNTFi?=
 =?utf-8?B?am00OVdPRlNGQ1Q2V3k2WUJqdTZyZ3ZnZ0Qva3o4elZrL0twTDdpbVR0WEI2?=
 =?utf-8?B?OFA3OFoyRzFxODFwTnhndU5TbU1XN1BRUEIyL3NFeXd6MGtPRUp6ZVdBWnZZ?=
 =?utf-8?B?SDJPSUpQZForKzBCNSs2YThoalpQTDFqT3kyOHdBeGZybWNXMXZBV0lGdHZs?=
 =?utf-8?B?d2dKTHNMTHB6dG00Ny83ZldWN0hUM21FZmI5U00zeVN5eVJpMzRxVE5DUmc0?=
 =?utf-8?B?bWJaTUVvVTJsWEQ0dlVhVk1IVkt4TTdhQnJYcnZRNGZmbnBNbFo5WGN6VEdr?=
 =?utf-8?B?WWNlMWduOXdac0pucHd5SGpGVDhXdVVqYTR1Z2J6RGQ0MlZuTE5yU3c1Y0V2?=
 =?utf-8?B?NGFZZEpZeGZaaHZTTmNQcURZZHRwQmc4dWllemptZ0U4ODF3d3VEc1VlTzJj?=
 =?utf-8?B?NWNCSXU5Y0xFZE01RTB6ZE1vUXY1MkRpWmpDbi9NZ0RMd1ozL0NMT0paVXhN?=
 =?utf-8?B?QjJmbXhOS2ZkQ1RqdkErMzBmYVB3NVFvR0JUS09BakRUY04xeTVRUW5NSDZC?=
 =?utf-8?B?bE5uSTA0dFNtOUREcGhQWmpwbmxYa0hxS0xhdHpnQVR1U1RyRXd5U21pYzF0?=
 =?utf-8?B?bEt3dHJSZysrTW5RcHFIV3E4dXVNMGI2TmRPQWJ3WStKbTRIR0k0SmJKL1dq?=
 =?utf-8?B?c2xqdnY0dkZLd1ZGQ1Bmb1BvYmFQSkNpQjQvR3hSR2J5Wm9td1Njc00zeE1I?=
 =?utf-8?B?RkdiMjdDZG1aWDMxTmVUU2gybmlRYldvYkU2RU5nenJWQ2J3VHh0MmVGTGFB?=
 =?utf-8?B?VVdmQy9qeXZlYW5ndEM2N1Vxdkk1dFdFNm93WUtYYXowRGdoUmtlNTRxdHI5?=
 =?utf-8?B?ZHFXV2xpbEVua2F2WUtKdTBkK3BtRkZaVlNGS1ZTcXAxMWR2L0srMWdLVUhX?=
 =?utf-8?Q?M4NkOGlCI68N0pKsbOrG2cpZF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a828d7ae-373e-42b9-c45d-08dc4d76c92e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 09:26:16.0480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6Gk1uP/3OsPDx0ugXeQDUmhq6X8C2FgDC9WI8JLlx2bCzTd3kgESBE4bODSAB4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6254
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



On 3/25/2024 3:45 PM, Ma Jun wrote:
> Add support for MACO flag checking.
> MACO mode only works if BACO is supported.
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  2 +-
>  drivers/gpu/drm/amd/amdgpu/cik.c                   |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/si.c                    |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/soc15.c                 | 10 +++++-----
>  drivers/gpu/drm/amd/amdgpu/vi.c                    |  8 ++++----
>  drivers/gpu/drm/amd/include/kgd_pp_interface.h     |  2 +-
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c                |  8 ++++----
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h            |  2 +-
>  drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c   |  2 +-
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c |  6 +++---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h |  2 +-
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c |  8 ++++----
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h |  2 +-
>  .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c   |  8 ++++----
>  .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h   |  2 +-
>  drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h       |  2 +-
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  2 +-
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |  2 +-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h       |  2 +-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h       |  2 +-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h       |  2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     | 14 +++++++++-----
>  drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |  4 ++--
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     | 14 +++++++++-----
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |  4 ++--
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c     | 14 +++++++++-----
>  27 files changed, 74 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 9c62552bec34..3723235f5818 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -605,7 +605,7 @@ struct amdgpu_asic_funcs {
>  	/* PCIe replay counter */
>  	uint64_t (*get_pcie_replay_count)(struct amdgpu_device *adev);
>  	/* device supports BACO */
> -	bool (*supports_baco)(struct amdgpu_device *adev);
> +	int (*supports_baco)(struct amdgpu_device *adev);
>  	/* pre asic_init quirks */
>  	void (*pre_asic_init)(struct amdgpu_device *adev);
>  	/* enter/exit umd stable pstate */
> @@ -1407,7 +1407,7 @@ bool amdgpu_device_supports_atpx(struct drm_device *dev);
>  bool amdgpu_device_supports_px(struct drm_device *dev);
>  bool amdgpu_device_supports_boco(struct drm_device *dev);
>  bool amdgpu_device_supports_smart_shift(struct drm_device *dev);
> -bool amdgpu_device_supports_baco(struct drm_device *dev);
> +int amdgpu_device_supports_baco(struct drm_device *dev);
>  bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
>  				      struct amdgpu_device *peer_adev);
>  int amdgpu_device_baco_enter(struct drm_device *dev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 12dc71a6b5db..aecb55d6963a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -341,7 +341,7 @@ bool amdgpu_device_supports_boco(struct drm_device *dev)
>   * Returns true if the device supporte BACO,
>   * otherwise return false.
>   */
> -bool amdgpu_device_supports_baco(struct drm_device *dev)
> +int amdgpu_device_supports_baco(struct drm_device *dev)
>  {
>  	struct amdgpu_device *adev = drm_to_adev(dev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
> index a3a643254d7a..fdbc26346b54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> @@ -1375,14 +1375,14 @@ static int cik_asic_pci_config_reset(struct amdgpu_device *adev)
>  	return r;
>  }
>  
> -static bool cik_asic_supports_baco(struct amdgpu_device *adev)
> +static int cik_asic_supports_baco(struct amdgpu_device *adev)
>  {
>  	switch (adev->asic_type) {
>  	case CHIP_BONAIRE:
>  	case CHIP_HAWAII:
>  		return amdgpu_dpm_is_baco_supported(adev);
>  	default:
> -		return false;
> +		return 0;
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
> index 23e4ef4fff7c..67e179c7e347 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -1409,9 +1409,9 @@ static int si_gpu_pci_config_reset(struct amdgpu_device *adev)
>  	return r;
>  }
>  
> -static bool si_asic_supports_baco(struct amdgpu_device *adev)
> +static int si_asic_supports_baco(struct amdgpu_device *adev)
>  {
> -	return false;
> +	return 0;
>  }
>  
>  static enum amd_reset_method
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index dec81ccf6240..c8abbf5da736 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -502,7 +502,7 @@ static int soc15_asic_baco_reset(struct amdgpu_device *adev)
>  static enum amd_reset_method
>  soc15_asic_reset_method(struct amdgpu_device *adev)
>  {
> -	bool baco_reset = false;
> +	int baco_reset = 0;
>  	bool connected_to_cpu = false;
>  	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
>  
> @@ -540,7 +540,7 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
>  			 */
>  			if (ras && adev->ras_enabled &&
>  			    adev->pm.fw_version <= 0x283400)
> -				baco_reset = false;
> +				baco_reset = 0;
>  		} else {
>  			baco_reset = amdgpu_dpm_is_baco_supported(adev);
>  		}
> @@ -620,7 +620,7 @@ static int soc15_asic_reset(struct amdgpu_device *adev)
>  	}
>  }
>  
> -static bool soc15_supports_baco(struct amdgpu_device *adev)
> +static int soc15_supports_baco(struct amdgpu_device *adev)
>  {
>  	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
>  	case IP_VERSION(9, 0, 0):
> @@ -628,13 +628,13 @@ static bool soc15_supports_baco(struct amdgpu_device *adev)
>  		if (adev->asic_type == CHIP_VEGA20) {
>  			if (adev->psp.sos.fw_version >= 0x80067)
>  				return amdgpu_dpm_is_baco_supported(adev);
> -			return false;
> +			return 0;
>  		} else {
>  			return amdgpu_dpm_is_baco_supported(adev);
>  		}
>  		break;
>  	default:
> -		return false;
> +		return 0;
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
> index 1a98812981f4..2415355b037c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -897,7 +897,7 @@ static int vi_asic_pci_config_reset(struct amdgpu_device *adev)
>  	return r;
>  }
>  
> -static bool vi_asic_supports_baco(struct amdgpu_device *adev)
> +static int vi_asic_supports_baco(struct amdgpu_device *adev)
>  {
>  	switch (adev->asic_type) {
>  	case CHIP_FIJI:
> @@ -908,14 +908,14 @@ static bool vi_asic_supports_baco(struct amdgpu_device *adev)
>  	case CHIP_TOPAZ:
>  		return amdgpu_dpm_is_baco_supported(adev);
>  	default:
> -		return false;
> +		return 0;
>  	}
>  }
>  
>  static enum amd_reset_method
>  vi_asic_reset_method(struct amdgpu_device *adev)
>  {
> -	bool baco_reset;
> +	int baco_reset;
>  
>  	if (amdgpu_reset_method == AMD_RESET_METHOD_LEGACY ||
>  	    amdgpu_reset_method == AMD_RESET_METHOD_BACO)
> @@ -935,7 +935,7 @@ vi_asic_reset_method(struct amdgpu_device *adev)
>  		baco_reset = amdgpu_dpm_is_baco_supported(adev);
>  		break;
>  	default:
> -		baco_reset = false;
> +		baco_reset = 0;
>  		break;
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index afb930b70615..805c9d37a2b4 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -421,7 +421,7 @@ struct amd_pm_funcs {
>  	int (*set_hard_min_dcefclk_by_freq)(void *handle, uint32_t clock);
>  	int (*set_hard_min_fclk_by_freq)(void *handle, uint32_t clock);
>  	int (*set_min_deep_sleep_dcefclk)(void *handle, uint32_t clock);
> -	bool (*get_asic_baco_capability)(void *handle);
> +	int (*get_asic_baco_capability)(void *handle);
>  	int (*get_asic_baco_state)(void *handle, int *state);
>  	int (*set_asic_baco_state)(void *handle, int state);
>  	int (*get_ppfeature_status)(void *handle, char *buf);
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index f84bfed50681..eee919577b44 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -199,14 +199,14 @@ int amdgpu_dpm_notify_rlc_state(struct amdgpu_device *adev, bool en)
>  	return ret;
>  }
>  
> -bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
> +int amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
>  {
>  	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>  	void *pp_handle = adev->powerplay.pp_handle;
> -	bool ret;
> +	int ret;
>  
>  	if (!pp_funcs || !pp_funcs->get_asic_baco_capability)
> -		return false;
> +		return 0;
>  	/* Don't use baco for reset in S3.
>  	 * This is a workaround for some platforms
>  	 * where entering BACO during suspend
> @@ -217,7 +217,7 @@ bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
>  	 * devices.  Needs more investigation.
>  	 */
>  	if (adev->in_s3)
> -		return false;
> +		return 0;
>  
>  	mutex_lock(&adev->pm.mutex);
>  
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index e6cad9f7aaeb..501f8c726e8d 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -411,7 +411,7 @@ int amdgpu_dpm_baco_reset(struct amdgpu_device *adev);
>  int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev);
>  int amdgpu_dpm_enable_gfx_features(struct amdgpu_device *adev);
>  
> -bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev);
> +int amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev);
>  
>  bool amdgpu_dpm_is_mode1_reset_supported(struct amdgpu_device *adev);
>  int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index fafd4e0b7908..d4b7a80c649a 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -1371,7 +1371,7 @@ static int pp_set_active_display_count(void *handle, uint32_t count)
>  	return phm_set_active_display_count(hwmgr, count);
>  }
>  
> -static bool pp_get_asic_baco_capability(void *handle)
> +static int pp_get_asic_baco_capability(void *handle)
>  {
>  	struct pp_hwmgr *hwmgr = handle;
>  
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c
> index 1ab4fbfe0cde..4ce068c08cb8 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c
> @@ -33,7 +33,7 @@
>  #include "smu/smu_7_1_2_d.h"
>  #include "smu/smu_7_1_2_sh_mask.h"
>  
> -bool smu7_baco_is_support(struct pp_hwmgr *hwmgr)
> +int smu7_baco_is_support(struct pp_hwmgr *hwmgr)
>  {
>  	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
>  	uint32_t reg;
> @@ -44,9 +44,9 @@ bool smu7_baco_is_support(struct pp_hwmgr *hwmgr)
>  	reg = RREG32(mmCC_BIF_BX_FUSESTRAP0);
>  
>  	if (reg & CC_BIF_BX_FUSESTRAP0__STRAP_BIF_PX_CAPABLE_MASK)
> -		return true;
> +		return BACO_SUPPORT;
>  
> -	return false;
> +	return 0;
>  }
>  
>  int smu7_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state)
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h
> index df142c2eec8e..a2d6b71789f8 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h
> @@ -25,7 +25,7 @@
>  #include "hwmgr.h"
>  #include "common_baco.h"
>  
> -extern bool smu7_baco_is_support(struct pp_hwmgr *hwmgr);
> +extern int smu7_baco_is_support(struct pp_hwmgr *hwmgr);
>  extern int smu7_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);
>  extern int smu7_baco_set_state(struct pp_hwmgr *hwmgr, enum BACO_STATE state);
>  
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c
> index 687cd80ebad8..3684bca772bb 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c
> @@ -28,13 +28,13 @@
>  #include "vega10_inc.h"
>  #include "smu9_baco.h"
>  
> -bool smu9_baco_is_support(struct pp_hwmgr *hwmgr)
> +int smu9_baco_is_support(struct pp_hwmgr *hwmgr)
>  {
>  	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
>  	uint32_t reg, data;
>  
>  	if (!phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_PlatformCaps_BACO))
> -		return false;
> +		return 0;
>  
>  	WREG32(0x12074, 0xFFF0003B);
>  	data = RREG32(0x12075);
> @@ -43,10 +43,10 @@ bool smu9_baco_is_support(struct pp_hwmgr *hwmgr)
>  		reg = RREG32_SOC15(NBIF, 0, mmRCC_BIF_STRAP0);
>  
>  		if (reg & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK)
> -			return true;
> +			return BACO_SUPPORT;
>  	}
>  
> -	return false;
> +	return 0;
>  }
>  
>  int smu9_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state)
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h
> index 24461f1e3b01..2decf7d549d5 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h
> @@ -25,7 +25,7 @@
>  #include "hwmgr.h"
>  #include "common_baco.h"
>  
> -extern bool smu9_baco_is_support(struct pp_hwmgr *hwmgr);
> +extern int smu9_baco_is_support(struct pp_hwmgr *hwmgr);
>  extern int smu9_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);
>  
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
> index bc0ff417921b..934d530a9cce 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
> @@ -36,22 +36,22 @@ static const struct soc15_baco_cmd_entry clean_baco_tbl[] = {
>  	{CMD_WRITE, SOC15_REG_ENTRY(NBIF, 0, mmBIOS_SCRATCH_7), 0, 0, 0, 0},
>  };
>  
> -bool vega20_baco_is_support(struct pp_hwmgr *hwmgr)
> +int vega20_baco_is_support(struct pp_hwmgr *hwmgr)
>  {
>  	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
>  	uint32_t reg;
>  
>  	if (!phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_PlatformCaps_BACO))
> -		return false;
> +		return 0;
>  
>  	if (((RREG32(0x17569) & 0x20000000) >> 29) == 0x1) {
>  		reg = RREG32_SOC15(NBIF, 0, mmRCC_BIF_STRAP0);
>  
>  		if (reg & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK)
> -			return true;
> +			return BACO_SUPPORT;
>  	}
>  
> -	return false;
> +	return 0;
>  }
>  
>  int vega20_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state)
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
> index 006eb6633ce8..13eef042ec42 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
> @@ -25,7 +25,7 @@
>  #include "hwmgr.h"
>  #include "common_baco.h"
>  
> -extern bool vega20_baco_is_support(struct pp_hwmgr *hwmgr);
> +extern int vega20_baco_is_support(struct pp_hwmgr *hwmgr);
>  extern int vega20_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);
>  extern int vega20_baco_set_state(struct pp_hwmgr *hwmgr, enum BACO_STATE state);
>  extern int vega20_baco_apply_vdci_flush_workaround(struct pp_hwmgr *hwmgr);
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> index 83f903d8e994..bee0eedc2b3f 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> @@ -351,7 +351,7 @@ struct pp_hwmgr_func {
>  	int (*set_hard_min_fclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t clock);
>  	int (*set_hard_min_gfxclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t clock);
>  	int (*set_soft_max_gfxclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t clock);
> -	bool (*baco_is_support)(struct pp_hwmgr *hwmgr);
> +	int (*baco_is_support)(struct pp_hwmgr *hwmgr);
>  	int (*get_asic_baco_state)(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);
>  	int (*set_asic_baco_state)(struct pp_hwmgr *hwmgr, enum BACO_STATE state);
>  	int (*get_ppfeature_status)(struct pp_hwmgr *hwmgr, char *buf);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 246b211b1e85..1f0a34251b9c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -3200,7 +3200,7 @@ static int smu_set_xgmi_pstate(void *handle,
>  	return ret;
>  }
>  
> -static bool smu_get_baco_capability(void *handle)
> +static int smu_get_baco_capability(void *handle)
>  {
>  	struct smu_context *smu = handle;
>  
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index a870bdd49a4e..dad43894cab2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1175,7 +1175,7 @@ struct pptable_funcs {
>  	/**
>  	 * @baco_is_support: Check if GPU supports BACO (Bus Active, Chip Off).
>  	 */
> -	bool (*baco_is_support)(struct smu_context *smu);
> +	int (*baco_is_support)(struct smu_context *smu);
>  
>  	/**
>  	 * @baco_get_state: Get the current BACO state.
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> index a0e5ad0381d6..7cd991069a79 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> @@ -237,7 +237,7 @@ int smu_v11_0_set_azalia_d3_pme(struct smu_context *smu);
>  int smu_v11_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
>  		struct pp_smu_nv_clock_table *max_clocks);
>  
> -bool smu_v11_0_baco_is_support(struct smu_context *smu);
> +int smu_v11_0_baco_is_support(struct smu_context *smu);
>  
>  enum smu_baco_state smu_v11_0_baco_get_state(struct smu_context *smu);
>  
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> index fbd57fa1a004..b81aa9c521e0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> @@ -210,7 +210,7 @@ int smu_v13_0_set_azalia_d3_pme(struct smu_context *smu);
>  int smu_v13_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
>  					       struct pp_smu_nv_clock_table *max_clocks);
>  
> -bool smu_v13_0_baco_is_support(struct smu_context *smu);
> +int smu_v13_0_baco_is_support(struct smu_context *smu);
>  
>  int smu_v13_0_baco_enter(struct smu_context *smu);
>  int smu_v13_0_baco_exit(struct smu_context *smu);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
> index 3f7463c1c1a9..5e887f551b3e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
> @@ -159,7 +159,7 @@ int smu_v14_0_register_irq_handler(struct smu_context *smu);
>  int smu_v14_0_baco_set_armd3_sequence(struct smu_context *smu,
>  				      enum smu_baco_seq baco_seq);
>  
> -bool smu_v14_0_baco_is_support(struct smu_context *smu);
> +int smu_v14_0_baco_is_support(struct smu_context *smu);
>  
>  enum smu_baco_state smu_v14_0_baco_get_state(struct smu_context *smu);
>  
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 5e5da9b16718..d0c6dad24458 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1557,23 +1557,27 @@ int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu,
>  	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ArmD3, baco_seq, NULL);
>  }
>  
> -bool smu_v11_0_baco_is_support(struct smu_context *smu)
> +int smu_v11_0_baco_is_support(struct smu_context *smu)
>  {
>  	struct smu_baco_context *smu_baco = &smu->smu_baco;
> +	int bamaco_support = 0;
>  
>  	if (amdgpu_sriov_vf(smu->adev) || !smu_baco->platform_support)
> -		return false;
> +		return 0;
> +
> +	if (smu_baco->maco_support)
> +		bamaco_support |= MACO_SUPPORT;
>  
>  	/* return true if ASIC is in BACO state already */
>  	if (smu_v11_0_baco_get_state(smu) == SMU_BACO_STATE_ENTER)
> -		return true;
> +		return bamaco_support |= BACO_SUPPORT;
>  
>  	/* Arcturus does not support this bit mask */
>  	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_BACO_BIT) &&
>  	   !smu_cmn_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
> -		return false;
> +		return 0;
>  
> -	return true;
> +	return (bamaco_support |= BACO_SUPPORT);

If this is to report a set of flags instead of bool, better rename the
ppt function to get_bxco_support() or similar. That name aligns better
with the return value (flags representing BACO/BAMACO etc.)

Thanks,
Lijo

>  }
>  
>  enum smu_baco_state smu_v11_0_baco_get_state(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 0467864a1aa8..33da5347880a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1582,11 +1582,11 @@ static void aldebaran_get_unique_id(struct smu_context *smu)
>  	adev->unique_id = ((uint64_t)upper32 << 32) | lower32;
>  }
>  
> -static bool aldebaran_is_baco_supported(struct smu_context *smu)
> +static int aldebaran_is_baco_supported(struct smu_context *smu)
>  {
>  	/* aldebaran is not support baco */
>  
> -	return false;
> +	return 0;
>  }
>  
>  static int aldebaran_set_df_cstate(struct smu_context *smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index ce16f2a08a47..a65877eeaa8d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -2268,22 +2268,26 @@ static int smu_v13_0_baco_set_state(struct smu_context *smu,
>  	return ret;
>  }
>  
> -bool smu_v13_0_baco_is_support(struct smu_context *smu)
> +int smu_v13_0_baco_is_support(struct smu_context *smu)
>  {
>  	struct smu_baco_context *smu_baco = &smu->smu_baco;
> +	int bamaco_support = 0;
>  
>  	if (amdgpu_sriov_vf(smu->adev) || !smu_baco->platform_support)
> -		return false;
> +		return 0;
> +
> +	if (smu_baco->maco_support)
> +		bamaco_support |= MACO_SUPPORT;
>  
>  	/* return true if ASIC is in BACO state already */
>  	if (smu_v13_0_baco_get_state(smu) == SMU_BACO_STATE_ENTER)
> -		return true;
> +		return bamaco_support |= BACO_SUPPORT;
>  
>  	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_BACO_BIT) &&
>  	    !smu_cmn_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
> -		return false;
> +		return 0;
>  
> -	return true;
> +	return (bamaco_support |= BACO_SUPPORT);
>  }
>  
>  int smu_v13_0_baco_enter(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 443233563a52..02b098d81ebf 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2078,11 +2078,11 @@ static void smu_v13_0_6_get_unique_id(struct smu_context *smu)
>  	adev->unique_id = pptable->PublicSerialNumber_AID;
>  }
>  
> -static bool smu_v13_0_6_is_baco_supported(struct smu_context *smu)
> +static int smu_v13_0_6_is_baco_supported(struct smu_context *smu)
>  {
>  	/* smu_13_0_6 does not support baco */
>  
> -	return false;
> +	return 0;
>  }
>  
>  static const char *const throttling_logging_label[] = {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> index 9e39f99154f9..cc7cc2a6d871 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> @@ -1590,23 +1590,27 @@ int smu_v14_0_baco_set_armd3_sequence(struct smu_context *smu,
>  	return 0;
>  }
>  
> -bool smu_v14_0_baco_is_support(struct smu_context *smu)
> +int smu_v14_0_baco_is_support(struct smu_context *smu)
>  {
>  	struct smu_baco_context *smu_baco = &smu->smu_baco;
> +	int bamaco_support = 0;
>  
>  	if (amdgpu_sriov_vf(smu->adev) ||
>  	    !smu_baco->platform_support)
> -		return false;
> +		return 0;
> +
> +	if (smu_baco->maco_support)
> +		bamaco_support |= MACO_SUPPORT;
>  
>  	/* return true if ASIC is in BACO state already */
>  	if (smu_v14_0_baco_get_state(smu) == SMU_BACO_STATE_ENTER)
> -		return true;
> +		return (bamaco_support |= BACO_SUPPORT);
>  
>  	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_BACO_BIT) &&
>  	    !smu_cmn_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
> -		return false;
> +		return 0;
>  
> -	return true;
> +	return (bamaco_support |= BACO_SUPPORT);
>  }
>  
>  enum smu_baco_state smu_v14_0_baco_get_state(struct smu_context *smu)
