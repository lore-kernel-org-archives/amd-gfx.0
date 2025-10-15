Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35642CCD18E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 09:38:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C53F410E76C;
	Wed, 15 Oct 2025 09:38:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TaVApmgP";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013003.outbound.protection.outlook.com
 [40.93.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5335B10E76C
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 09:38:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYwmYGyCJPRj4MrVZL1IKfatdDAL+OzcRF/FPIyCwzJ+Pwz30wyB1pNEoRXts64agv/7D5e4SbuTjEkWrsT8lPE0VPMu7BcTl+prrMpb7YoCBlza7737p34RQVvYRIkmGc2f8o9urq/Ap+WI7N9tfBtOZd+TSxajq0l9yrHRou1FxX1l4QrHjY/oNg038E7NbHdFN8LuOG8tcY82GJuZ7MlWxItdWyeYNedMio50I9s3epxr8JaRZmpSh3YObbUD8LYLkukAnFsU8mFDd0NHbB7UExqnEjDnGd/pOojA9LAkpQ3a2cPPzASSezH5/V/tL7T3wODEnxIt5NFEeSDBHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rv05hLTnQRIw+X2yrMQD+fAiA5Rk17DR3PdTbyoxrag=;
 b=Uny4oICBQfr7yGdurSHJKmtXKXlQ0GHun7ph6D+GzkkamOLz0H3K8YzC7bA+IItMBWKbk8R4KGYWH/1IeebcFOGklEpm4DYHPnkv/PU1blmIWsJsg1i/D6Z4T0ToTfypzUsmCbtD4+R9PfZ+lMi1NfqeWatpnLbtryRBV0OQeAvyxSYSJk7Ov4GnJWWLLAlvGySUh9GoF1jBiPOUvWI0gGQ5rKu/j+RYSxc1K63ckEWao+IZxSDc+ll5k0dbp1oWXT03dLndZi9obvOpWrp7K7raFGEKHpAo3Qp31A3n3E7ZAfGjzhM0VcrU6h/OiP6U6grXa/5e+h8rRRn3vpf7Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rv05hLTnQRIw+X2yrMQD+fAiA5Rk17DR3PdTbyoxrag=;
 b=TaVApmgPfofxN3EL0256pNE+YaimL1gs5gY7cAdEFCTe7l/1+AWYqONdRn13NHZUMewv5USh1fNr8ezXtpyapg5Vtm8R7JHHnLpY1TcON0KavweVfDQtdzjvI0cVURhtNZEg6hgnr2qulWulE5mvPP9zTJtmq5f6KcVVWlYK19E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB8298.namprd12.prod.outlook.com (2603:10b6:930:7c::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.13; Wed, 15 Oct 2025 09:37:59 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 09:37:59 +0000
Message-ID: <b333b7c5-af50-4830-a89b-8d5fe28acd3a@amd.com>
Date: Wed, 15 Oct 2025 15:07:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] drm/amdgpu: Add logic for VF ipd and VF bios to
 init from dynamic crit_region offsets
To: Ellen Pan <yunru.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Jeffrey.Chan@amd.com
References: <20251014201346.9422-1-yunru.pan@amd.com>
 <20251014201346.9422-5-yunru.pan@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251014201346.9422-5-yunru.pan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY8PR12MB8298:EE_
X-MS-Office365-Filtering-Correlation-Id: e380df28-001b-4dc5-90c2-08de0bce8713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eENVcUdSMk1jaHlTbmg1L21rbkRlK1BXMXpSUmVKemlEc2cwSHc0MkJqR2VZ?=
 =?utf-8?B?aE1ndlFFM0xRQ2F2ODVGOXFKTXEra2wveS9QTDQ5cWJGZjh5dnl5MU9GOGNz?=
 =?utf-8?B?dC9leFF4ZzRmYUlPTEc5cXNvMVNtTzVtRlRDZ2VMek0vN01tc3dQQW9aeTB6?=
 =?utf-8?B?bmRmUTU0T3lKMExGb2NKVU9ZanJDTGxUbE9xQ0d5RUE1NktOQXE1bHRlRlZ0?=
 =?utf-8?B?SHFVczIrTzdVbityZU1mZ1lTamxQUmh3U3lDeCtOd3ZnNkREbEtrVUs5OVlx?=
 =?utf-8?B?enVJeDUzT1BWQkMwUXQ1aDhJTVdFazB3VnNBWkUzVTRQVFhrTGY3a2thTG9q?=
 =?utf-8?B?eTkwZy90ZmwzWXRjWG0yUjliL1BRZy9XUWNYK2tpQ0RkL0RuREV5MytMS1Js?=
 =?utf-8?B?eEpObW9HSVQ5eVRIdEcySTRYSTBSc25PejFPdWN2bHpvMU5oRUlpNm9XNmw2?=
 =?utf-8?B?ek9tS3hvdGtYTHVaSG5CY0k1UjFHU3ZSVFY1VVljQnZqWGZaeThNSFM2YXF4?=
 =?utf-8?B?clMwdVBTd1E3VDdsekh2bkhkUFlSUnNtdWQrclNGK0NBSUhtUjUyd1RoWkNI?=
 =?utf-8?B?amNnUHkxNk50aEcyQnZUYm9jdTNYMEtvTXB0eWYrWEg4dnlGUUY5aW82SFNm?=
 =?utf-8?B?K0pYaDZpMFFRbWNXRXVnRlowMWNpSzFTSWVJeGhRZzI1eW81WllEY29aM3ZF?=
 =?utf-8?B?MXcrUm5RR0RFd1B0RkVLZlFsdG1zeTBPaTJlTys4V2RYNFVKVThnUndqdHAr?=
 =?utf-8?B?SEpjS1lQYXBUNXVWUE5hRDIwV3dETVdRbGhNU29MU3ZXNnhyUXM3Qkc1UEkz?=
 =?utf-8?B?clQxV2pEUVdXUWRBdnlFSEZ0ejNvOFRqSXB1a25MZjRGUFkzZEpWTmp3VkF5?=
 =?utf-8?B?UUtGU0c3ZUhWRnFiOURaVXJ2cktmRUpWci9iOC8zVkhhZkxIM242OWxtOG4v?=
 =?utf-8?B?Z3BnK0lndkNjUlBOVk03RzlXYnpNVExnZlZkSFhIZnA4RnpYQW1pd3g2aFhw?=
 =?utf-8?B?K2FWZDJBSGcwRzg2TzVqR3dZeExkZmlBUlNLQ1h2elFHL1FaeEw0V0hSdnBF?=
 =?utf-8?B?UVFhNE1oTVlBbUp0SGlZZGZQeTZ0U1Y4MytCbUs1YytiNFpDMERIa1MzRnNq?=
 =?utf-8?B?bURVQlcvMmgvOGl2VnptZURLbStFZTdxOFIvdzZ2eVk0a0Y0YndnWUNPMWp5?=
 =?utf-8?B?RVdyTmRSMlY1UU1USXQwaGNWWlFVZDRyU2pQS0RBUUtuVU5zUFBsK2p0RnB5?=
 =?utf-8?B?MG1oa3o5UE5YTnZsa29wRHYyV3ZSOEpqWFMxUFZJYjJQbjJROFppNGZxV3lu?=
 =?utf-8?B?cEVtSGZEemZGU1kwVXlQV2h0VGl5bEt2SXdpMlhCWThTWWVGR0JMaGtVT1M1?=
 =?utf-8?B?R3Q5akJJaG5ITGJ4MFN0eDIvR1dIbVlwSnJ5SSt2aGJSVWwzTC9LelZmUitW?=
 =?utf-8?B?RVI4djRsczFydzVzNHk0MGdaZjhrQmwvWURjMUZOVmViN2lWUllUdjZvNjFX?=
 =?utf-8?B?SGJORjQzcm96N3kzRFhaZlJ0dlBBampLNXRJOHlqRklkRVJuaUdqeitQYnVR?=
 =?utf-8?B?ejI3TzczMHlaTjVEWlVvRENTNEkzdkhSNDRoY3lmNzN0RjVMZURhNmp3UFRy?=
 =?utf-8?B?R3RBeEZvNnhEdXFUdDZNREcwRTJHcVRpZVpuTmkrcldHOEZIamRVL1NrZFho?=
 =?utf-8?B?ZVJ1b3U1a3lnZWR4YUgrVUNQKzJTaWxmRXZkNk5uNTRwTlU0MGZPcGc3czBp?=
 =?utf-8?B?Q0szOTZzckFPV08wQVd1NG53WDdtRnp2R3MyTytHZGxrUHVqU3JlTjA3MWt3?=
 =?utf-8?B?cjZwQUI3b3BuOTdjSC9udkcvQ051SnlqeEkrTUgxNjk0V0VpaFpsVHU3eTg5?=
 =?utf-8?B?aVJmaXhWaDJURUUrWGtDZmFZcHJkOGZTT25wNy9ocEljc1hjdDdCQ2pYZDl2?=
 =?utf-8?Q?E6CdqV+KnE4wSHjNUcOe0Be2F3ROBdOL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlN1b3kxaHBQQStNVHRCUGFsVHZ1cDM1ZTVtdnI1eXlkSllpZ21rdTlWZE9D?=
 =?utf-8?B?SXRUb2NnMXhsZFlOS1pnZmhMZTlwZ3JDQXp6NWdqTTE4NUxSWVd1YlZwZE4v?=
 =?utf-8?B?OG9Kd2NCaUV0TmxsbFNOUG9uM1NxbzZaOXMzN3o2UmwxZk9XYkNiRWNLajVK?=
 =?utf-8?B?TmxieXlranFVSWdlT2IvelBQOWpzd1Q0ajRDeTZLRFJwM2wxeEF2Z0RvM1Ez?=
 =?utf-8?B?OU5acnE0cUJVV3duTm5aZGtycFJaeHUrbVZCQnFoaG9EaVZSdW51YllUMTQv?=
 =?utf-8?B?VVd1M2VQai9pLzFtQzJheVlMbkIrUTVTM0M5MEE4SVFGQjg1cFdjdmw4MWNI?=
 =?utf-8?B?TW95UFRSbXZtVmszU0JwVmxLY1NkWlBGdVQ1WnFBRjVycDM0SlFpSkl2TVYw?=
 =?utf-8?B?S0s5bmQyZDluSlVuNE54YXUxRSszdjlNWHlyLzVpMm1PKzYrMVFBZ054amtR?=
 =?utf-8?B?OU5paVZKUXBKSkxTL09lL01wM0laK2dUdldxbWpoNExjVTVHOHBWeGVURFRI?=
 =?utf-8?B?SlZEcS8rWkVDUk1oM2E2dFd3ejhIQlNkSktNSUVyOEl4V2JmWUlVaUpYSWln?=
 =?utf-8?B?WTJGQU1nU05TbHhnc1VVb3hoUld6ZnBWZ2RmMDlzVnYxbWhjeldYVTJsNHkx?=
 =?utf-8?B?VzUwYy9uVHBLeGt0cUhNV1ZLampXWTJGSFdJKzFpTUZxbnVoY2I2MTVjVWpx?=
 =?utf-8?B?WWNMMTFCNlhzVFo4d2hoMlJRTThJWVdKZGZKV1M1L28yNVQ0b0N2bnpVQU00?=
 =?utf-8?B?bXBQM1lmTGZ2eC9pTmhVRys1WHJUSjJsY1I1Vm1IdUlKRkI1bDBGWGhIeW41?=
 =?utf-8?B?dE5Sdm94amlqZFFMbmxTdWlqSU5lUnVibGdkRXIwTGFVK2Y5TkYxNFR5eG1q?=
 =?utf-8?B?RXQvVmpzeXFuZDdPYlVocHlBbE16SEY5TmtGS1ZUWXcvOTMwczJtbzNORWN4?=
 =?utf-8?B?UWtyMUxmcThLaElsdmZ0NE04RkZSYXg5OGN3bzliQmNQL055MDJSa1ZiRitT?=
 =?utf-8?B?dVY2RytxalR6OENPQjJpenlMOFVjcVFkUHNHNkg4WkFQTXlUQm1WSzh0S2Y3?=
 =?utf-8?B?OWRNQm9IelNDek42OFdnakxOd3lrVytpa1kwVHVHRzBDRldvckhhaDZ1WGkw?=
 =?utf-8?B?cWErSitMRUtGdndMeFNIeEhtcThnT2ZqS3lVdXBXSGkyakYxd2Myb3Bhdzdj?=
 =?utf-8?B?VjdzR3hqK2hOTU1yVzZPZi9vMHVCRjZkNE1JVVpURG5aRWw0M0VZbm9kVzFL?=
 =?utf-8?B?N0dLWXJ0MWV2eXZZQkRZTFZkTzlzakVFalhrdWljeUpFSWNZdHo5WG91UHFU?=
 =?utf-8?B?cEtDR3BrTWRkd1hDTCszaWlJZ09HL0dNMGFpNzJZeXZBK0xTL0Z3LzB1YXl5?=
 =?utf-8?B?UnZKdDROeFBIa0pRZHF5U3FWenVVUDRBVXYya01USTBWYlZoTTNTTXhjNXVs?=
 =?utf-8?B?YmdWY3RKOElWQXIzNFMvcWpQTC8zQ0xkbjNuVlI2Nk5IbDJibDhBWEdRL09z?=
 =?utf-8?B?R0NOMEJaeXRhV3p1bGkrTUdhTGVCOE42ZVBCeVZZVkJCWG5jWS95enhqb1Br?=
 =?utf-8?B?dVNHRDNvL3liUXpQT2ZSRjdWQ2c3SGhFQ0VRd2VlVWVhYUxNZEZ0aXc2TWdl?=
 =?utf-8?B?K2M4bFFjamxUSllmR3Ayc3pnZDR2c3JRSVVJUEdvUVJZWnV3bG43a2tkM0ZI?=
 =?utf-8?B?N1BzbEhyYnI0cGlRWjRzMVBYRHpnWHlXZHhDVXg2emlLRis1bWx1eDNTeGRU?=
 =?utf-8?B?a1hPVy9DTm9iVnd1Njd6VTFxUXBydFB5U1M1K2xsQlEzWXFQRW16RUJ5RVBK?=
 =?utf-8?B?VjZPcUlublEwRHBMai9XRUhKRlZFemxMM3diU1cvQnllbnNKaHIvNzU1VDZr?=
 =?utf-8?B?VkM5ZnhjSEJ1SHBtOVF6Sy8wN0p4Q2EybHI3OE9aQUs5Zldnb1BYV2dPNEZP?=
 =?utf-8?B?NE5PaDcvUFBVdlp4MGZpK2w5VHFMUnJEV3I5aWM4VmFKWVVQOW01K2hlcVhi?=
 =?utf-8?B?MXBCS3RrVzhpaW1hUlVXdkJuTzJUN2c0dnpFYlgxU2hLMEp4WUhBeTlBN2lJ?=
 =?utf-8?B?bm5DeE5TRTR2Nkt4NTVUMHdRMWVCY1J3RXM4WkxGbW1paDhpeURIeWk4b2F5?=
 =?utf-8?Q?Xb8i9H20byEZnfQq5TQ2ikpmM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e380df28-001b-4dc5-90c2-08de0bce8713
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 09:37:59.4583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAFEyskD8oezbrptM1PwHEghORx57YnKOw/5Hw7/dOhDc77+9dZU2mhDjBW/fT3W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8298
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



On 10/15/2025 1:43 AM, Ellen Pan wrote:
> 1. Added VF logic in amdgpu_virt to init IP discovery using the offsets from dynamic(v2) critical regions;
> 2. Added VF logic in amdgpu_virt to init bios image using the offsets from dynamic(v2) critical regions;
> 
> Signed-off-by: Ellen Pan <yunru.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      | 36 ++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 23 +++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 63 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  2 +
>   4 files changed, 111 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> index 00e96419fcda..5960ab1be4d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -96,11 +96,12 @@ void amdgpu_bios_release(struct amdgpu_device *adev)
>    * part of the system bios.  On boot, the system bios puts a
>    * copy of the igp rom at the start of vram if a discrete card is
>    * present.
> - * For SR-IOV, the vbios image is also put in VRAM in the VF.
> + * For SR-IOV, if dynamic critical region is not enabled,
> + * the vbios image is also put at the start of VRAM in the VF.
>    */
>   static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
>   {
> -	uint8_t __iomem *bios;
> +	uint8_t __iomem *bios = NULL;
>   	resource_size_t vram_base;
>   	resource_size_t size = 256 * 1024; /* ??? */
>   
> @@ -114,18 +115,35 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
>   
>   	adev->bios = NULL;
>   	vram_base = pci_resource_start(adev->pdev, 0);
> -	bios = ioremap_wc(vram_base, size);
> -	if (!bios)
> -		return false;
> +
> +	/* For SR-IOV, if dynamic critical region is enabled,
> +	* the vbios image is put at a dynamic offset of VRAM in the VF.
> +	* If dynamic critical region is disabled, follow the same seq as on baremetal.
> +	*/
> +	if (!(amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled)) {
> +		bios = ioremap_wc(vram_base, size);
> +		if (!bios)
> +				return false;
> +	}
>   
>   	adev->bios = kmalloc(size, GFP_KERNEL);
>   	if (!adev->bios) {
> -		iounmap(bios);
> -		return false;
> +			if (bios)
> +				iounmap(bios);
> +			return false;
>   	}
> +
> +	if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled) {
> +		if (amdgpu_virt_get_dynamic_data_info(adev,
> +					AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID, adev->bios, &size))
> +			return false;
> +	}
> +

It may be cleaner to keep this code up - allocate, read the binary and 
then use a label to jump to verification (check_atom_bios) for a 
successful read.

>   	adev->bios_size = size;
> -	memcpy_fromio(adev->bios, bios, size);
> -	iounmap(bios);
> +	if (bios) {
> +		memcpy_fromio(adev->bios, bios, size);
> +		iounmap(bios);
> +	}
>   
>   	if (!check_atom_bios(adev, size)) {
>   		amdgpu_bios_release(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 73401f0aeb34..e035dba96790 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -283,7 +283,7 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
>   		 * wait for this to complete.  Once the C2PMSG is updated, we can
>   		 * continue.
>   		 */
> -
> +		
>   		for (i = 0; i < 2000; i++) {
>   			msg = RREG32(mmMP0_SMN_C2PMSG_33);
>   			if (msg & 0x80000000)
> @@ -299,13 +299,28 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
>   		vram_size <<= 20;
>   
>   	if (sz_valid) {
> -		uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
> -		amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
> -					  adev->mman.discovery_tmr_size, false);
> +		if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled) {
> +			/* For SRIOV VFs with dynamic critical region enabled,
> +			 * we will get the IPD binary via below call.
> +			 * If dynamic critical is disabled, fall through to normal seq.
> +			 */
> +			valid_size = vram_size;

Only mman.discovery_tmr_size is the allocation size of binary.
> +			if (amdgpu_virt_get_dynamic_data_info(adev,
> +						AMD_SRIOV_MSG_IPD_TABLE_ID, binary, &valid_size)) {
> +				ret = -EINVAL;
> +				goto exit;
> +			}
> +		} else {
> +			uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
> +
> +			amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
> +					adev->mman.discovery_tmr_size, false);
> +		}
>   	} else {
>   		ret = amdgpu_discovery_read_binary_from_sysmem(adev, binary);
>   	}
>   
> +exit:
>   	if (ret)
>   		dev_err(adev->dev,
>   			"failed to read discovery info from memory, vram size read: %llx",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 820dab538164..fef4ebb0f879 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -940,6 +940,14 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
>   	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].size_kb =
>   		init_data_hdr->bad_page_size_in_kb;
>   
> +	/* Validation for critical region info */
> +	 if (adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb > DISCOVERY_TMR_SIZE) {
> +		dev_err(adev->dev, "Invalid IP discovery size: 0x%x\n",
> +				adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb);
> +		r = -EINVAL;
> +		goto out;
> +	}
> +
>   	/* reserved memory starts from crit region base offset with the size of 5MB */
>   	adev->mman.fw_vram_usage_start_offset = adev->virt.crit_regn.offset;
>   	adev->mman.fw_vram_usage_size = adev->virt.crit_regn.size_kb << 10;
> @@ -958,6 +966,61 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
>   	return r;
>   }
>   
> +int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
> +	int data_id, uint8_t *binary, uint64_t *size)
> +{
> +	uint32_t data_offset = 0;
> +	uint32_t data_size = 0;
> +	enum amd_sriov_msg_table_id_enum data_table_id = data_id;
> +	char *data_name;
> +
> +	if (data_table_id >= AMD_SRIOV_MSG_MAX_TABLE_ID)
> +		return -EINVAL;
> +
> +	data_offset = adev->virt.crit_regn_tbl[data_table_id].offset;
> +	data_size = adev->virt.crit_regn_tbl[data_table_id].size_kb << 10;
> +
> +	switch (data_id) {
> +	case AMD_SRIOV_MSG_IPD_TABLE_ID:
> +		data_name = "IPD";
> +		if (!IS_ALIGNED(data_offset, 4) || !IS_ALIGNED(data_size, 4)) {
> +			dev_err(adev->dev, "IP discovery data not aligned to 4 bytes\n");
> +			return -EINVAL;
> +		}

I think this should also be part of table verification.

> +
> +		amdgpu_device_vram_access(adev,
> +				(uint64_t)data_offset, (uint32_t *)binary, data_size, false);
> +		if (!binary)
> +			return -EINVAL;

This NULL check should be before reading any content to the binary.> +
> +		if (((uint64_t)data_offset + (uint64_t)data_size) > *size)
> +			return -EINVAL;

This doesn't look correct either.

You may generically do like -
	// not valid binary or not enough size allocated
	if (!binary || !size || *size < data_size)
		return -EINVAL;

	// otherwise, copy the content
	amdgpu_device_vram_access(adev, (uint64_t)data_offset, (uint32_t 
*)binary, data_size, false);
	*size = (uint64_t)data_size; // update the size as out param.
> +
> +		*size = (uint64_t)data_size;
> +
> +		break;
> +
> +	case AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID:
> +		data_name = "BIOS";

If this name is preferred for printing, probably return as 
amdgpu_virt_get_dyn_table_name(tbl_id) so that it can be used at other 
places as well.
> +		if (data_size > *size) {
> +			dev_err(adev->dev, "Invalid vbios size: 0x%x\n", data_size);
> +			return -EINVAL;
> +		}
> +
> +		amdgpu_device_vram_access(adev,
> +				(uint64_t)data_offset, (uint32_t *)binary, data_size, false);
> +
> +		*size = (uint64_t)data_size;
> +		break;
> +	}
> +
> +	dev_info(adev->dev,
> +		"Got %s info from dynamic crit_region_table at offset 0x%x with size of 0x%x bytes.\n",
> +		data_name, data_offset, data_size);

This could be kept as dev_dbg().

Thanks,
Lijo

> +
> +	return 0;
> +}
> +
>   void amdgpu_virt_init(struct amdgpu_device *adev)
>   {
>   	bool is_sriov = false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 5c1dce9731e1..a3ae1ff40e84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -440,6 +440,8 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
>   void amdgpu_virt_init(struct amdgpu_device *adev);
>   
>   int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
> +int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
> +	int data_id, uint8_t *binary, uint64_t *size);
>   
>   bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
>   int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);

