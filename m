Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459A4D41D74
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 10:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B580910E3FE;
	Mon, 15 Dec 2025 10:56:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="khMOfPuh";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2454D10E3FD
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 10:56:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnxFHqXZN7y0Ynwuacj0IXELUUGwFkvB8StCqccnZeLPZzPySnWwW2Ue38sbSYRCnvU/5PZtygb185C7gwa5dWS2ULbTOZ9sgI2ITwMN9jOhZFDqSHrB8a1XJb3mMJo7GFLNbfZCJqt4QC2CFJqqwX+AhtUREPMMnjXBaARTZoj7QCvsXnbJW3kby2wTiE3+99hPOTdLBgbPqy1ufTzOUDgXu1vXm64P5xKm7esttGnE9qiseYg8kLXusBdH7iBQo3eehgqWGBkItUdpez3PVv1iSZAVecyKQlfBWdQEIhjsQ16Gm2ieWrgX7Tj11v5k8qGT/SkE58owKo/D5qwM2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ki0CA5Vw7+NInx1dSP4MAGNDaGPtQW0uracn2w956Ls=;
 b=kBCt/mWZbn2NRZOLOKF1v8nMlhh71cDonYg6bgMMbvox/zXhItCZ1QeOJV/k3eq/iSETlK4lnfmM3HC+vs61fhi0czCHDc3bNHstTzItGDl/9CsG79QG+C19ZKs2rvOMg7aF87e5BYsIljoCRIJCUCy+J6a04jpUM0NhE5aCJyv7j6JNz2+r1JNzRUpRW/c7PfmHz3EzxiefB7fHgg/t9c+bWXYU2KzWwzInLIvh/01M0Gc9nCmAiyGqt58dHqMnQN1mPuZjJAB+1IlgWn0To9iY8XrcSDygtPLYSxGec2mg31zNIjVV05p67jSukcIW4Qu6NrINalMVhMgKhydcjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ki0CA5Vw7+NInx1dSP4MAGNDaGPtQW0uracn2w956Ls=;
 b=khMOfPuhJf2wXADYyFl+knhq/m4QiY3TqkqPFyaaCp88L/V6NF595uO8d53GV3xflmDC2OPQ77FPMWMK/zQB3I7SDhZ1X/+vXCMSyhz9feIalso2DsRdBBdxXOx+1CuJlhhGNkO92E04RuvHnLwJoVHeKxPJMWCdA2wcyojVTW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MW3PR12MB4377.namprd12.prod.outlook.com (2603:10b6:303:55::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 10:56:32 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 10:56:31 +0000
Message-ID: <97eaa300-c054-473c-bd31-499e3128487d@amd.com>
Date: Mon, 15 Dec 2025 16:26:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amd/pm: force send pcie parmater on navi1x
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, alexander.deucher@amd.com
References: <20251215104634.983674-1-kevinyang.wang@amd.com>
 <20251215104634.983674-2-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251215104634.983674-2-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MW3PR12MB4377:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb991a2-5f9d-4d9f-e820-08de3bc89adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXI1MEl0Mit6dHFzU3ZuNkJzQmtiWlk2cHBaQXlCcUdUOVpCT3Q3dGZZbHhh?=
 =?utf-8?B?UlZZcUxhcmxQcTArNDlxZzkyVjZEZFV3aFZ2QzZJcjdSVzBYVGVkWmV6b09s?=
 =?utf-8?B?czlXbUdCR2lPMmlyN0kvVHBMN1lQMWVuOGtRUEtXSlpuSjlIbGE2eG9XVitP?=
 =?utf-8?B?TkdiZmdNTXNGdENzNCtQdFpSOVd2QzZ1NU0rNDRHV0NJMzJiVThxSkRSZW1W?=
 =?utf-8?B?YzFuTTROQWYvTXExUXFTczJEdSs1a0JaT3JnaENvOHZ5aG1weWhzU2JMVzNk?=
 =?utf-8?B?ZmkwUm05NmppNU1BK0thV3ZGS21qSmlkcU1CbzZOeXo3eDQydSt4MlM2UWg1?=
 =?utf-8?B?dlc0dzJYVCtLUzgrR3o3aURRVHB2WnVHMkIzSmxZc0d2MHh2NnVyOTVhRUlN?=
 =?utf-8?B?Q0tONy9qbkl2bmt3SXVpQ0JaNjEreGZVUnkrWVoxZkRmQnVmV0VsQVNjL21t?=
 =?utf-8?B?aUtHVG9tSnNiUjFFaVlEWExWanh6TytXVk5FaGthSkdXOFhoMTRYSG0yckpo?=
 =?utf-8?B?bFI4OWFhUDJSK05mY2dJOTNMdERpR1NqYlpCZ01NSHd2RGVQZzAvUVFqelpk?=
 =?utf-8?B?R3k1MTVsZDRNeGw3ODdCd2w2RFh6Zm5xeEFFRi9kSmRNQ2dFa1hKMTUyNnFC?=
 =?utf-8?B?MjEvZVhmYWhDeGpFdXFza3BJenVqVklwUmhxZHhHOGNBNUw0OEswekt5cXR0?=
 =?utf-8?B?UDlXSE85RzJTbDhIMDk4YTl2ZFd2OWh3VmI2REoyNDZPcmFiamllNmdYL2kr?=
 =?utf-8?B?NXJXdGhTbFZUWWhXeEJtSjRGMHBYNmV6NTVnNE1pdE9KWGFRczdqdmpjSkI2?=
 =?utf-8?B?ZkphSGp5MlZoNHdzNUhVYkdndDFUMXdYWlNOZWF5RitNSHZBL3FHemJtNHVH?=
 =?utf-8?B?d1doZklwZHVaSS9pTEhUQUZOOUh2REtjdUpsUU1PMWhQNFIrU2hKVEZGa1U3?=
 =?utf-8?B?SFNNZHhBOG1qV2E0OVFDY0xWeGI1NnhWcjdKUGdINXJvcHEyQTJhMWhlTFUv?=
 =?utf-8?B?OEdiaEMxVmwrTVlWdEdHdEZZR2ZHSExrSk01T2VuRXFTamlxc0cvakc2ZHJ4?=
 =?utf-8?B?dHNTZTJrNVNaNHN0MzNFbEY4aXZXNGdkdlRXeTJUcUozL2x1UFNxTTVrcVdR?=
 =?utf-8?B?Z1JTeTFRQ0lITFpjSmRUS01IczJtNHNDNHNPNGs0eWEyN0k3MERCN21uRE5p?=
 =?utf-8?B?b3IvWEtLZzExRnRVRXVkWEZvdlRkb0RjQXpXdlZMeVlFNllxbFpiT0JkUmJS?=
 =?utf-8?B?eXBtcE5NMmN1TWI1bi9QTERnWlRUWHlnL2lnUS9rYnM4VUNPR3FDTkZ2Y0sw?=
 =?utf-8?B?NVhocE1QRUU1SzlEY3BnQnVXZDg4Rk5TbWxUcEFXUzkvNmx5Zk5zOGFOczhT?=
 =?utf-8?B?Sk5qa3dqcnFxYkFKTjZqMnNsbk4vWURDZjVvdkZ0WW45QVA4UTVvUmwzTzVB?=
 =?utf-8?B?QVRZajhPV21CcW5FS3Vrd09LQzc0OUhWRE1MWFc0VGpORHNSM2J3dWQ3TEdF?=
 =?utf-8?B?ZDYwSWRpNWFvS3BrTWlybE43aVB6ZS91b1ZwNmREMnUxNXlEK0loUHZrL3U4?=
 =?utf-8?B?V29mTkNGblpQbXRvTWZEbFpzc1VXSDVZaVhWblI1S2pteUZ0OVpWb1pXdmc2?=
 =?utf-8?B?M2VUeFJ5dTFuNGYyWDljTVRiNkJxT2V0UHRoM0pqVFAzbGtuNEw1UVg0cGo5?=
 =?utf-8?B?aXk0dFFVWUlyVTJlaWs3bGFESnNUcEZkN1Z0NU1nRGRmbVdVWWhNbGhmUWpR?=
 =?utf-8?B?bWhOaHZscnFidUluS0NhT1Avd2pTaE9OR1VmOUFnVHVwRjNsUjBJQk8zRHU5?=
 =?utf-8?B?L3BCNUgrdk1rb1A1MjZzYVFjNHJGaHZGZGVmM2hhTVlxdVp2TElvYngwMzFC?=
 =?utf-8?B?akdQRFJOZ1A0Sk5MYzBOZ2RaY0JyVmFXbWN6WHpJK01va0YvSGRMVkY4aGVW?=
 =?utf-8?Q?NanITY9REJxX6D7sJaTB1zVuHnTczkjb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmpMVHg5S0pzdzFOd3NZT1NLOTR2RWI4NXdvbXJROVhNMFJnUEQwcGRFZmkx?=
 =?utf-8?B?V1pUNC9lYUNCQ1NMdEpOQjgvU1A1TlhKTjRmYWN5bHBVUDBmdzBzbmtXcnJx?=
 =?utf-8?B?cHl3N2twOXlkWDY0Rk50N0lwVzBFeEk5c1B6b2wrQnY5UUlTeFR2R2xud09F?=
 =?utf-8?B?cFU0Yjk4cmxFcThPU1VpSFRReTFubE5qTjBab0FWRFMyWCtoZElpQ0VrNGcv?=
 =?utf-8?B?blRiRmozTFh2alFkTUNNTzE3d2xUM3k4WFltMnpiOUxzNERLb28zWU9GNGFk?=
 =?utf-8?B?em42TFNBdFJkT2ZhMTY3RHVuSnBrUFlSMW1xSEZBcFlDc1orWFhkRms0YVo1?=
 =?utf-8?B?RzBldWRlRnJXN2V2ZmhLWmhWZjZEQzUvbzhnMVNWZ0JYaEVEaHRLcWVoYTF1?=
 =?utf-8?B?Nit0N1ZleXBWZnpMaVhBN2tzUnRSZU54Q1RlMGJkZnVPOEorUVRSOVBRQWY0?=
 =?utf-8?B?K1NJNWpNdnh1QVlMM21WMEx4ZXJyWXNyZkM4VHNZY2pXcnFWR1I1Z09qVS8w?=
 =?utf-8?B?OHZVQ09LWDNaOHdremtPRC8xMVRSRlc5ZWtnS3A1R05ES2tGZ1lRZkZjbHNI?=
 =?utf-8?B?enF4a2oxREM2bTN2cFlTdUVPTHdIQmJabmhucEZsczhxdnh2OFZLZ2V3MC9D?=
 =?utf-8?B?Y2lhV3RJQnNyTFNmdkxIS25QUFpzK1ZUVWttQzV0Q2Q5VUpOc1pwNGFtdkZk?=
 =?utf-8?B?QUlqcVJMVnE2VENXcnRhWW1VSktGVDg2NCtwZENmRkxScnhVQldQejh4QW9W?=
 =?utf-8?B?Y09WbDhUWFdpNG5wNjhjNkZFSkxKVXU1b2R3N1huRVdha0MyaHprMEdRM29n?=
 =?utf-8?B?ZlpWSVk0U2pIN1BMdExTWnhjRlFoZmVMQWdJUkltNCswRkhlVXpnSkNEclM0?=
 =?utf-8?B?cUtvNFpsdU0ybUI3QitNUTN3UzRqc3dBUEoxTnVHRFRaWThIK1g4K0cvbUVK?=
 =?utf-8?B?WFJuaWh0M3BRRVcreWQ5M0o4VzVGamlrQnZYZWxwL2RjK1ZyNEI0MW5YWitk?=
 =?utf-8?B?OVcrWnViQWxoVjZvTjVlT1ArUG1KV21XRDhQcTA3dVZPRGhaT3NUQXgwd0RJ?=
 =?utf-8?B?ajFoTWpIcUZpODhJQXh6WFAzNURDQXREK3lJdGlnR2pUaWtYNVdvOXM2VXBy?=
 =?utf-8?B?QkdmQVdHV3NPcGF4YTNyU2YycENvT3kzTnVmNGRjN1NkNzFEZDNFNU9udjZQ?=
 =?utf-8?B?ZXM4ZjBxZXN3cDJES2tPazBEaC94M3hsZHBMbXhvUys2NnF5VytYRkJ6TEZQ?=
 =?utf-8?B?Y2xpRGJHQ1dXanczNFF4Y01wVDFpMGNlSmJCQ1FpQU9UOC8rc2ZGeXNjQWhS?=
 =?utf-8?B?UCtNdVk5NVBXYm9xamNnWjFFTTdDcEw3cEp5MmMvVVpFNnc4SnNQUXFlaTNZ?=
 =?utf-8?B?OTNQUU1xa3o3RjU5VnRUT0lOL2RERXo3NXJrYUNvdXhPQ3pjeGtqZHJ2QnBQ?=
 =?utf-8?B?bnFOaEVWZ0s5ZDBnTjFudlUvMjZWSkIwV1pmbGo2Qzl1ZUovN1RNOGdjZGM5?=
 =?utf-8?B?MkxNNDRoNHVxRVdvUE5wazRlMnZUWEFmSEhJUUJLbk9KbDNJc1RJaldYUVdW?=
 =?utf-8?B?WEVrMVVHTEUxZTZCbkZiK2Z6Rm1nWEhQOG5wWDFVQnRKaE52UVR3bXdoeHBS?=
 =?utf-8?B?Sm5UQzFEdlptQWYrQmdkSnVJWG1PTy8rZ0lMWkZHZ0hpdUdHUjJXVlRZcjRy?=
 =?utf-8?B?SFB0ZkZhNDArQTdnbFA2bUFnYWI1SFNMSmJiL016eCtyNzVmLzFrUTdmQ1pZ?=
 =?utf-8?B?UUdEeWR2V0NjMStsT2t5c090R3BCcy93WmZJNjlJVHk4QzhaVU94ang5dVR5?=
 =?utf-8?B?QTJnK3dnWEE0cTNqMzk5T1E4YUo3eGFZcXNlYlYwRFZKVHdjWFEwNmRydTJl?=
 =?utf-8?B?VkEzdlRNM3FXZGc3NmxZRzRodXhVaUNwMzhDU1h4eFJ6TE1HTjJyZ2hsS0tR?=
 =?utf-8?B?ZG5uQUJURmQ4UFNHdHFSUTNzY3RzYW5aNnNKU3NwMDNiaGl1S28yOG12QVBo?=
 =?utf-8?B?N01UL3NVSENzbCtvVm0rZ0R2aVhVUzlXYlVHVUJZN3NzV0VBREtJbVpoMkxa?=
 =?utf-8?B?aFRRNTV0eWpBT0FvVzdCMUdvSExzZGp4a21WT3JmVXBwdGtnZEU3dXhjR1Ax?=
 =?utf-8?Q?ddOXBNuUK6ZkECfWYqqeLykMK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb991a2-5f9d-4d9f-e820-08de3bc89adb
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 10:56:31.6425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itfqs94//I8sI63zv0cs0uaEuYjki2ViSEnKgnPn1nmn9XBkxDsVVP1sEUhudf/i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4377
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



On 15-Dec-25 4:16 PM, Yang Wang wrote:
> v1:
> the PMFW didn't initialize the PCIe DPM parameters
> and requires the KMD to actively provide these parameters.
> 
> v2:
> clean & remove unused code logic (lijo)
> 
> Fixes: 1a18607c07bb ("drm/amd/pm: override pcie dpm parameters only if it is necessary")
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 33 +++++++++----------
>   1 file changed, 15 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 0c26fe6fb949..4896200a0bd9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2207,24 +2207,21 @@ static int navi10_update_pcie_parameters(struct smu_context *smu,
>   	dpm_context->dpm_tables.pcie_table.lclk_levels = NUM_LINK_LEVELS;
>   
>   	for (i = 0; i < NUM_LINK_LEVELS; i++) {
> -		if (pptable->PcieGenSpeed[i] > pcie_gen_cap ||
> -			pptable->PcieLaneCount[i] > pcie_width_cap) {
> -			dpm_context->dpm_tables.pcie_table.pcie_gen[i] =
> -									pptable->PcieGenSpeed[i] > pcie_gen_cap ?
> -									pcie_gen_cap : pptable->PcieGenSpeed[i];
> -			dpm_context->dpm_tables.pcie_table.pcie_lane[i] =
> -									pptable->PcieLaneCount[i] > pcie_width_cap ?
> -									pcie_width_cap : pptable->PcieLaneCount[i];
> -			smu_pcie_arg = i << 16;
> -			smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_gen[i] << 8;
> -			smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_lane[i];
> -			ret = smu_cmn_send_smc_msg_with_param(smu,
> -							SMU_MSG_OverridePcieParameters,
> -							smu_pcie_arg,
> -							NULL);
> -			if (ret)
> -				break;
> -		}
> +		dpm_context->dpm_tables.pcie_table.pcie_gen[i] =
> +			pptable->PcieGenSpeed[i] > pcie_gen_cap ?
> +			pcie_gen_cap : pptable->PcieGenSpeed[i];

Use of min() would have simplified this and below one a bit.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> +		dpm_context->dpm_tables.pcie_table.pcie_lane[i] =
> +			pptable->PcieLaneCount[i] > pcie_width_cap ?
> +			pcie_width_cap : pptable->PcieLaneCount[i];
> +		smu_pcie_arg = i << 16;
> +		smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_gen[i] << 8;
> +		smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_lane[i];
> +		ret = smu_cmn_send_smc_msg_with_param(smu,
> +						      SMU_MSG_OverridePcieParameters,
> +						      smu_pcie_arg,
> +						      NULL);
> +		if (ret)
> +			return ret;
>   	}
>   
>   	return ret;

