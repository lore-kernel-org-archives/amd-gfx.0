Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFB5C71135
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 03:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D44510E045;
	Mon, 16 Jun 2025 03:44:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Uekp8pcV";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3D2C10E045
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 03:44:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMUpz4cVDiaFHUFQcOOlGrKG/awYFaORJkmzQ4lGwe7DuPIUQZ+y+LYuGaHqfQ6xexYoDVrdwucWElCbfm7SDwsB811TdMdpBVLXsSungxxxuyEFugiREqdLqQwwGHmZLskFAOC9iQUNCB1UzROl1GP+8oFLn1WtDppXvp+SSohLAtz6UV+xUYK52vBWJemM/AnTGXoosK/MvQayl+TmjmAS8uDdm63H+/3vxPqQhGxjhCYN+h2TJNj6LJiVUzC6COpH8Zpc+zPPrDwf58YuMqnoNLkS+K91GocXsEI3cc21TGubfJgTJQh+ad61aBFnQEVb5mZ7uwTd1gg8LD0gAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4APNNVi4dTp2Te/V14Oh/XW25i+ZmNDa7vI3WAwcniA=;
 b=Mb9633kyiU9aHsKG1cfNgbs73fKwqyfCOeAfqCNudiCNkD2VEWSHGiOYncYuA2WSpMqQDRFmp73uqxYCqgR5v8iLNHr+X+RWOl6WQOe2lN11pb4v5l3cugCMSdcItDEmi/ONydXFRuenhG77+c8aXu6xFvcDtoJxq2a1AJCPJGnmaGMddWmQEsIErqDzy5atpZhjE05Ve3a9P6QzsIsSZDC1WOBD3xzPZc2PJMtwwE567eZeeXIhBoHCl1zEZPxU6el3mYaB3rzU7dIP8YUxm7DYBpjVSI2bTnCmaZ9d4Hy1ThK94QvcCNP4VV0Q3Tm354TdZiMhvsSJfXYwJLbbyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4APNNVi4dTp2Te/V14Oh/XW25i+ZmNDa7vI3WAwcniA=;
 b=Uekp8pcVCDGNrSNUI1t768ALqT2TBMJ3dtKfnjuXrzWFATwGjVLHA4pAbsF+HU2WSGm0/XrRkzHK2eN+ZGj2Orc7rIR+S4EIoFISxWkI7djUaZ6Arbi6+HZYEiXpm3mlIkiszK2FLdyhcKl0lNYV3EmGaACobpBEWJ4iRraxaKI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB7363.namprd12.prod.outlook.com (2603:10b6:930:51::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.25; Mon, 16 Jun 2025 03:44:18 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 03:44:18 +0000
Message-ID: <3dd704b4-3caa-4dc1-82ea-df6081e5668c@amd.com>
Date: Mon, 16 Jun 2025 09:14:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd/pm: move the dpm table setting back after
 featureenablement
To: Kenneth Feng <kenneth.feng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250613144203.441129-1-kenneth.feng@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250613144203.441129-1-kenneth.feng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY8PR12MB7363:EE_
X-MS-Office365-Filtering-Correlation-Id: 85009219-0bb8-41e0-e948-08ddac88127a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTBCNzE3Y1kvZEttV2FNSHhkVUk2Q21KRzR1RG5TNHBCMjh2RmlNRUVyeEZS?=
 =?utf-8?B?bC9CRGNINWkvbGwyaHVqdWVIKzFINU5GMDZ6ZEw2UHlLa1RnSlB5MEYzRnJl?=
 =?utf-8?B?SjFUVGFsZ0RZZkZldHRBai9iV1VicmY1b3RUN01VaVhGdm15NEFSd2p2VHlS?=
 =?utf-8?B?QnJ3MmtSWUxocHdma3BkeGJMVlJlOEFvOHl6WVVJdDRSSkRNWFloWjE0dHpo?=
 =?utf-8?B?ZEFaZThTVUMweHJmSFRUQlZPeWlaUUpnSU1QT1NlQitGUUVPM0lpWUxYMjBj?=
 =?utf-8?B?ekJoMXJCWTJuTzRpRFJFZjA5Sm9EdXB3MEdZdEcwZU8vcFU4V1NFdFROYTU1?=
 =?utf-8?B?eVh5V1Zha2FyNS9NcTYyVXMvbkVBNi9YU3RmVVA5RUNTc0YwQkJ1NW83R3l5?=
 =?utf-8?B?SC9acFRSU3hlbU5DTDllZjBxSW5sUnFFbHdFR2Yvc1F0eTFpeUJ4U0JOWkNn?=
 =?utf-8?B?dnVYT3h6ZG9wWnVRSkQ5Umh2SkpoVnh2ZW9HTDZ6RDFIL0hLM1dLSmZXVk52?=
 =?utf-8?B?d0VTaG0wOXhUbFlPcWFIQXNjcjZ6SXZsWnR3ejVZQVViVklJUVNOYkg3YTRR?=
 =?utf-8?B?V2s3V1BiQ1g3M2NCSlo2RDZoejFkcG44L0YrK2VUUHduTk1qblZxZW0yZ2RF?=
 =?utf-8?B?SUdZYlUxalJBNFhDbVg4b21iMERwVXJjbTNNbDkvRlprek14dXpRU09ZYUpp?=
 =?utf-8?B?Y1E2RDZYOHcxS1lseGMzNDVHUk16d0cwYUVSRnYvRkdHRVpybDdYMm1SbGM3?=
 =?utf-8?B?d0h2L0I5cU9TYUhOdFVMQmpDOWtjOWtsVWFpN01HMkk1dFVDbEYrZEpYK1Nj?=
 =?utf-8?B?dW9CSXhIdTlhaHpPSkhQMGVhaGlXU2Y5ZWdUM1BCcG5qckgwV0EyQjBxUW9I?=
 =?utf-8?B?M25BZC9aQnFBQW1qQ2VDUnlQSVlyVzgrWEVsSERXTkxNR3dPOEh1Y1ZTWFJK?=
 =?utf-8?B?RENuaVhmNHdvampJTURCSHhibGxNOVpwcjVET1RDZGxlUmxRT2daaWRtRG9E?=
 =?utf-8?B?cjR3ckVoZlRmeWZodVBadVRLS1VlV0g3cUhOL1YrWlE0SUphdHAzWWpNUFR0?=
 =?utf-8?B?eUdMa0dNK0VuN3NqSG1wakJvZDVSeGt3TkVEeDBUbnFOMGp3YmxGQzh5cGRG?=
 =?utf-8?B?NG1aWTdreWhNWU9aU1V0MzViZGRuYWorak5ibEpLUWgzRFBkNSs3eFpCSE5C?=
 =?utf-8?B?a2lxdFJIUzBiNmtjK292THNNUE5wNG5kMHNUMDZCSmkxWEorN3oyUHJoeGFO?=
 =?utf-8?B?UUFNK2trOEY0Rkkzd1ByTkJNTEVCdkdraGUvbkptdEdDQi9wcUEvVFlLNnEr?=
 =?utf-8?B?NGNReGgyd0VkRXR5SmxZdFB1R1ZxK05hT2ZKM1Bpa2tWa04zYkx1NmV6eHht?=
 =?utf-8?B?WXpTNDR6SnRETkQrdURuNDE1LzdvdG55cElRNUJGVjBpZEo3Vm8xa1orUDhJ?=
 =?utf-8?B?UnZ1OFNWNU5aZmZxanA1Vnc2aDR2Y3BrTVlGejAvaFE1cUFXbVdUQlY5bThy?=
 =?utf-8?B?SUtwQ0ZPK0cvM054ZGVJN3Yxc0trUnJhblp4cUdnZ1dYZEUrTnVWTS9SeU9r?=
 =?utf-8?B?ZG1JS29pZzhlQTRHeWpqbERnUktEK3FlaU5aRVhINFk4dnMzL0d4c0o2blRF?=
 =?utf-8?B?TDVBVjVONmhORnVlRXl4Q2pSWnpDWXBDa0Iydm5UK1VES2VFR3B4MDcyd0Q5?=
 =?utf-8?B?NDVGc3V1Vko2NFFLd3B0akw0ejdKZUwyMENpZ00zWkozZ2ZVY3NuTVgxN2hz?=
 =?utf-8?B?UDYxUzdkcldTaXl4Zmk3M3c0eEMwUUFjRW8zTlMrNE1ITEphTnA4aU9WVk54?=
 =?utf-8?B?SHhSV3J2UFZXS2IxbExjcFpDTW5oMzJLWWNyU2Q3c0FEUjRsN3NvSm9mYzBO?=
 =?utf-8?B?OXE2cEo3aWtRbjVjWlRwakllZERpU2ZMYzNyZlRhLysvR2NjM2JCc2tZSk55?=
 =?utf-8?Q?lN88+Xb38NM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnNGbFdhdlJ4UXI5ZlFHSXdOckJpd1p1WW9iSDJDdERLL21SaFk0TGlRMkZQ?=
 =?utf-8?B?YTBMR0ROeFR0bko2ZTFOSFFhRlFwaDFLaXNsUGs2YTBtaE1rb3hPSGhLVUlM?=
 =?utf-8?B?QVZjYlh1RXdDTDZ4YURYS1Y5Qk5hUWVVN3duMVpCbVFmUnkvS05uMTF6Zkhm?=
 =?utf-8?B?V3VwMWpsdWtCNVd2bnRTZ0FSYkp0dHZ1WFlvMGFleVhNSnJKWHNsWWdFaVcr?=
 =?utf-8?B?aTcrazMxQ0Fic2krcC9pWW94U0llclFOR0JyMC9jOU55VkZ3UmtzL01zcjNH?=
 =?utf-8?B?N082Z2RmTk1RdWxLOFJwMmp5WkgwSkVadFN6TysyRWNBU25ybTBQRUY0WExP?=
 =?utf-8?B?cmUzeUtYNlFTY1hlUVh6RGVnbjBYSGozSGYyWnVWMkQ2N3hubmtoTWdyK1hM?=
 =?utf-8?B?RFV0QXZ1N0pMWFZGMzlYQXJzUCtxSC9Jd21lSC9ubU41c1V2d01PeEUwWG1x?=
 =?utf-8?B?MFl5MlM4SVQ4UU03QTlpNk1OVDBxaUY0MlZSM1JjUkJsa0VheTF6VkxFS3Y0?=
 =?utf-8?B?WmdCTCsvaUdBSEpkNERrdWVvY05SdklDQTM1dGxlU0VHR2E0RHJTaXk4Qm8v?=
 =?utf-8?B?c2pRWk1FZ2xZeG1mVll0ek1CR0NWUUtIaWdXSlBOQ2RTUUEvMFpjYzRQT2Qr?=
 =?utf-8?B?a3gwSG5GSHVUNWxnTUtKYXEyL1lvN3N1d0lUdEY4OENIckRsNnRqQmZna1Nr?=
 =?utf-8?B?NCtYbUgzQVhMamZRdzNBNUZJTjJldzYxS1d3eE9YTXN5SVJTZVRzYzFWWXVJ?=
 =?utf-8?B?N053enl3YjJ2TWdqbloweVV2SUZXeEVMRmI2VmdYK3JQV2NGRm8wb04yVVJj?=
 =?utf-8?B?NUdYdCtlcWlqYkxZelhuNEZmQ0dnRnF3WGVJdVEzeEVEVk0rQWV6VGg2VEZM?=
 =?utf-8?B?cm5rLzA4NDBpdW04M3ZIWWtFd0FERDdSOFg1ejFOVVQ1eXI2Q2lRWjY3aWlj?=
 =?utf-8?B?VVh5T1Q0Z3RGTndabUZ3WTRCQVB5V0pTZ3ZPQlR6TUx4anYxc29iUUpwYWhN?=
 =?utf-8?B?TzNiZXpCU0tPcVhNMmc5cXJFeE5ORWtobE5YRlpYak9HaEZTajlqTGF2ODg3?=
 =?utf-8?B?L0crSGhDalBhN0pDUFZJcDZmNllHRHVEYkpFajVMWlE4MGhQSTRGL0pzWTQv?=
 =?utf-8?B?WFlKcmN5aDR1RG5LL1hDUEZIQzRvQkQzV2N0U01qeFhuV3pIM0RUV1ZZSXhh?=
 =?utf-8?B?L3p6SEVBSUlyREQvOHZHR3JucDRybDQzd2krazdaSXRFaG1MUDQ1YzlmY1JW?=
 =?utf-8?B?MUhHU0RreERybGtKbTJCS1Y1MUEzRTdRZDFYY000ak9PdXZjSmRndHdUc25Z?=
 =?utf-8?B?RE5CZVYyME9nYXA3WEQzZXp4VVpScEx6d2VmejZqNGN1WkkxMngrOUN1S0t6?=
 =?utf-8?B?cU0zUTNyMWdCRmpBd2lOSjdiM1FNdDRYVlI2eHRqTThkVEJxRVd3SEhlUlNP?=
 =?utf-8?B?UGZIWDBWMUd5Yk9QczNkTDhpaTkyMHFHR1BPOG1PeFhwcVJVRFNsZkc3a01D?=
 =?utf-8?B?NERJWGw0V1hhbkp2UGtUUFdvbkdlV2drWmM2MnRSRldMRFlNdU9tRDRHMlcr?=
 =?utf-8?B?Y2lJcW1FTkRtNzR4anEzVkoxWkNFa0o2L1ZVSi9qZ0dNSmgxUEV6eVY3WE85?=
 =?utf-8?B?M0FMVjNVRnQzallzOHZUUEtmUjBscW5lNVdnL2FnRDViK1hsUHVGTWlSNWc2?=
 =?utf-8?B?RHFYLzdkYitNQVBMZjNyOFlHM0xialdtTzlkSm9tK0g5WE5DR084RVdvUzJU?=
 =?utf-8?B?TDUxeXJ6TDVVZ2FwMi9sMndPMG52cnI5SVhKSnhUU0RrdnZoVUJiTnN4d1A5?=
 =?utf-8?B?QkpWMmdBNkVra1JwZDNBMkw5SEZQakF6ZmdwQk5BMVNWRGgyTG9HOFRxSnhL?=
 =?utf-8?B?WlpBTFBJbitCaFZOZHdWc1JGMWs4STkrV2JpN3lxaFdqSnJnL2lST3VNUWdy?=
 =?utf-8?B?cFJCdGV6MkxmekRiT1JOWXM2MFA2V0h1T0h5dHMrbFBzZDJYZXF0aERxNE5K?=
 =?utf-8?B?UGpNaWtDQUl5dk1YeVluVnovUlBqSGZCeTlvVnRXckdkekxGdmdoU05LRHQ0?=
 =?utf-8?B?VTJwY1k0U3gzWWRobld3ZnB4eVlZT0FGMjZsU09JRmtZVHM2WUpxQ1VGSVBu?=
 =?utf-8?Q?pKO3f1uU2lf97G2bohc+3+pIR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85009219-0bb8-41e0-e948-08ddac88127a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 03:44:18.7442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okc73oesPpj3+M6DfgAcn4XPrbP5sm9pP8/WJv6GmBWvLILQhXBev/3F6pVKjPGG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7363
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



On 6/13/2025 8:12 PM, Kenneth Feng wrote:
> move the dpm table setting back after featureenablemend due to dependancy.
> 
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 824fcc6dd32a..cf4ac3914b68 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1687,17 +1687,6 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>  		}
>  	}
>  
> -	/*
> -	 * Set initialized values (get from vbios) to dpm tables context such as
> -	 * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
> -	 * type of clks.
> -	 */
> -	ret = smu_set_default_dpm_table(smu);
> -	if (ret) {
> -		dev_err(adev->dev, "Failed to setup default dpm clock tables!\n");
> -		return ret;
> -	}
> -
>  	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN5)
>  		pcie_gen = 4;
>  	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)
> @@ -1739,6 +1728,17 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>  		return ret;
>  	}
>  
> +	/*
> +	 * Set initialized values (get from vbios) to dpm tables context such as
> +	 * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
> +	 * type of clks.
> +	 */
> +	ret = smu_set_default_dpm_table(smu);
> +	if (ret) {
> +		dev_err(adev->dev, "Failed to setup default dpm clock tables!\n");
> +		return ret;
> +	}
> +

As was in the original code, please move this after -

if (!smu_is_dpm_running(smu))
                dev_info(adev->dev, "dpm has been disabled\n");

This point completes all the diagnostic messages related to DPM feature
enable stage. That helps to check if any issue happened before fetching
tables from firmware.

Thanks,
Lijo

>  	smu_init_xgmi_plpd_mode(smu);
>  
>  	ret = smu_feature_get_enabled_mask(smu, &features_supported);

