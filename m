Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A368CC021A4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 15:17:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F75810E3EC;
	Thu, 13 Feb 2025 15:17:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0/L5cANW";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 309CC10E0D9
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 15:17:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjmxowpyexXQr5bwVCyiNGgGNJrxia7LEfrPLFmTQ8wrJiCFu5C4gWtc7w+S4ZPaHJZrux2HXMKm9AA9BdjRTSlSvNEtylBk9e4I8BUOrqWHs3AA2Gjq5nvSGC9uR6z2/ecStfzNqhHqQcGArcZPouU1LqS0LWHceT1tro1xUelknBDWpnzcNorAU9SoF9mzCvyBk8OdZGUkQskexeEk0jydVzHzi/du3cjA6IfV1bI+HiG42gKKGNfxUlTffSXum354dLqsoa8egH+dBXVG6n9t7dJZFK7nxNEuwQV3NriQKX/+FexVJqGpvgcZtVtFyokUNhEITfl3mJRBzelQQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GyP/OFyJWezpU1crNywCQvJLRbYWxKMx77jW2ECClo=;
 b=tsVCPvwsM/HDM5VNnznJpZnKDYNbMzZGSYMXSs930hAanHyprl5pF1BwC9j2yefWN7TPo6q5QUo9gi1vqUGTF9NKqqK4YFgjXDChhsNb3PXcn8WweMMvoVyYzZ4kCO/WS1Y0581/UogUpfFoV0aQ0sBzOC5aBmTnc1LKn1/47hYpIbnhJiIqI5JozOV3+ENQRQMQ+vNcDGuqFNWE5ide3D/DwHaxrVMemGWLJIxsSpwndhFLqDCbXvUnSYr2hF+w18XTso1fM97xAl9pFrmErJzWUPbu1gndtec/UooMEuBFBxLTt3hhFMPbLlE/7eFb6fO4HAqTy3zv145CENi5rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GyP/OFyJWezpU1crNywCQvJLRbYWxKMx77jW2ECClo=;
 b=0/L5cANW9X8keOReosvT7p2UWPOTt/TRx2v09VFjmuCMfuEIhYs0Vn+MFM67qMv9bckk0dfNRh9A4ajx4F1TQwScT2Wjj8BAp/zUB4pFu7jSCfsrJGm1OULuRWweDKcRhmlPwjxj2DfkpSfJUmyk0W95RH8bzCZxSq2VYlfqbm0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9)
 by PH0PR12MB7791.namprd12.prod.outlook.com (2603:10b6:510:280::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 15:17:08 +0000
Received: from PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286]) by PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286%7]) with mapi id 15.20.8445.015; Thu, 13 Feb 2025
 15:17:08 +0000
Message-ID: <b03f98a9-db5b-41cc-b4b8-70357dd99502@amd.com>
Date: Thu, 13 Feb 2025 20:47:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu/umsch: declare umsch firmware
To: amd-gfx@lists.freedesktop.org
References: <20250212214821.2871419-1-alexander.deucher@amd.com>
 <CY5PR12MB6130D813E6E37328D4D120E7E3FF2@CY5PR12MB6130.namprd12.prod.outlook.com>
Content-Language: en-US
Cc: alexander.deucher@amd.com, lang.yu@amd.com
From: Saleemkhan jamadar <sjamadar@amd.com>
In-Reply-To: <CY5PR12MB6130D813E6E37328D4D120E7E3FF2@CY5PR12MB6130.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0186.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::13) To PH7PR12MB9173.namprd12.prod.outlook.com
 (2603:10b6:510:2ee::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9173:EE_|PH0PR12MB7791:EE_
X-MS-Office365-Filtering-Correlation-Id: 81382413-6b9e-4b89-1024-08dd4c417b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWdWbTNicEh0WE9GU2ljcE5uS2xMdi9tc1cxNFZBMlBMeFdjZTdhWXJTcjYv?=
 =?utf-8?B?OWZ5bC9PU0c3R1puaURnV0xsdWNwVUE4NEt6dFVHZnhpK0N1cWRMelNHejM0?=
 =?utf-8?B?T3lyRG9LRHNKc2FCNEl4Ukd5YnNzajNPR2tkN3BrMTF3UXBEa3BKSk5ISENr?=
 =?utf-8?B?Y0V1dWdmVW55U2RYeHBIdFovbnFvWFlpWGs2V1ZBK21LT29nKzVtYXB2MW5G?=
 =?utf-8?B?dCsyT2YrN1ZlNHFSZkVTYk4wYjdENk54VHRzMGx4WEEyaWkrT1dWNEtuUGps?=
 =?utf-8?B?WXhxcG5XSHhtaWNjNk5FYkwrSGRkZEVuMjJVSXhLbzFGMHZFZWN6UEhjOU9P?=
 =?utf-8?B?akx5bFZ2R1ZoQVk0TDlDRC9IV1F3UTFnaGdUWG9JdjlGdjQxOWEwNDVnUE4v?=
 =?utf-8?B?Tnhta2ZHWEQ3NnRodUI3cUxrZUs1UDBhdm9QZnhmSFdyRWlwWllLdXZOOElI?=
 =?utf-8?B?T242NStydmJhMi9lblRFT3pJNzl1V3QzdHZSK3hVZFN1Ti9pS3pWYTc4c0FX?=
 =?utf-8?B?blg5QWxscUJSM2MrQU9sUlFlc1VzSFdmTGRUNGkzNnBPcGR4Y3o1b2VGWCtt?=
 =?utf-8?B?blpOOTE5cWplQWNLdmltVFYwc2FZU2FvM1Z5MDdLTkFWZ29nNG0zUXVHNERK?=
 =?utf-8?B?WEtqRmYxdmQzLzYycDhORzBxWmlNVFladHcvQ3pPL2FEMjF1Y3hqckRFWmFO?=
 =?utf-8?B?aDduQnVvVms5TStySXE2eEk2cVMybmJwa2gyQU9OQ080blRsZ3dKMm84VCtT?=
 =?utf-8?B?NHJ0c2c5T25ON29tRmtFRnN1V0NCZjd5Q2Fic1dORk9lRWQrWUxnSk9Xbkl0?=
 =?utf-8?B?K0pjd1pYdWo0aXArZSt0Mk04VUU0RUlvek4vSFpUT3NGLzJoNGllRXJlRzdY?=
 =?utf-8?B?Q3dPVytKdWttT05pdlpyTUhMSnFuQmpIWDNGRmtBUGdjMVpJMUpBUkNKY0g1?=
 =?utf-8?B?bGpJeVRUTEdMVGswS1ViaTFJbThYeDFMcWZOT1VwQjAxZkVEOXFOV3IzMk9k?=
 =?utf-8?B?ZDBOMTRaOURyN1YxajV2K0FtV1BQcnFQVkZWOGZ1RlplYkI5QlZBSDNuSmVR?=
 =?utf-8?B?S3R5NHJ1bmtwWTJuUXlENEhySHhIL05qekxnaGovNXJsYkwyU0JRcTVrUUFr?=
 =?utf-8?B?NUVCZlBQT1l4ZGZSeCtmUEthMzQzaFlBRHRTT2cvNDhvWEhiM2txM1psR0wx?=
 =?utf-8?B?cm9zNmFIMFVCQzU5NzFadUtjY3UyeUprc1JzZFloalBNTTJPdE1TT3d0dktn?=
 =?utf-8?B?UCtLRnE0cWE3VldjLzR2bitmOHlwckpmYkwxSURGeWM4a2s2MitTd1BuRHcz?=
 =?utf-8?B?MDdQcjd2Vnp4UittZDRnRUhidk1SbHIxUGNaUWxxZjlYNzBIaVUvaWkzNFdD?=
 =?utf-8?B?V3Q1QkNpb2tHTzRUVGdXRVF5cWVwaWdpQW5XdktZZ01iNFFTYWJlRzB3NXVC?=
 =?utf-8?B?cmNmMVQvdVI1eHIrZ281Q1cvZ01CMXlpWUtvNFlUb3RRMXlOZDhxR2hNWisr?=
 =?utf-8?B?TytrODVYWUtXaWVOMU1STVMxRDh1UURsZ3QrbFdScjQ5STV0cytHR0pSTDcz?=
 =?utf-8?B?azFLVDRIQjY3WHRDNmNhaldEenh5a2RYUDRWV0F1b0U1aGdjVjNnRkVvOTU4?=
 =?utf-8?B?ZzR2YjJGdWowNWNLZWgwVWh6WEdOTG15L2RkU2VPSWJOekZOUzlCdnVENEJY?=
 =?utf-8?B?amliR214WXNPL2RuVytVSTg1N2hHNW9mMFZ2Y3pwR3hScU9mWnVtMXpGcVAw?=
 =?utf-8?B?NDFzMVZJWUJlc3dLSDJQS2dlYmx3YWpJVElhZCtacGFKbjczZzlwckhRVHA0?=
 =?utf-8?B?WVA2TGZScTQ0VFArSHVqQlBHOHprcUpQWUpJNVZKMkh2U28zanhlVFFwSUZG?=
 =?utf-8?Q?YYWgbr05/wn1h?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9173.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWNYbGdQVk1ScUgwSXpaZjB2K203MTNKclBOSTY0NUE3c1UwQXJOSlVVT3VH?=
 =?utf-8?B?dGlrYldXTElWVFhod3VWYnFjdURKUHR6MEYwOTZDUFZqWFlhRXhGMjgzVHZp?=
 =?utf-8?B?Zko2RHIvYi9iZ2NYbzVvWitYeDg2NUdFcXppaFdrYkhneThTSDd5K1QwT0VR?=
 =?utf-8?B?dEZkdmRrNmt4dDhxNWRSNEx2SngzZmJpQ0x1MjBZRVdGOVV0NHRWemxXSjdQ?=
 =?utf-8?B?cWZ1bDl3emp6YzdnZEFTNGZJQWdrYmNuZDlVM1lsNkkxNTVzbXdneUVTTmJI?=
 =?utf-8?B?WVVINVR0N1picUE1ZzdmVWFBaExhalJPSkQxd0h3ZVgxOVRkM2ZINjBiRDhr?=
 =?utf-8?B?a2o5MDhLTXVJMXd2VkNibkEwTzIxV2pnMTBtZ1FmcEtMeGZrU1p2VUJ4cUpV?=
 =?utf-8?B?VzR4MTJwRTRFTW1hQkhMM0hmRVlDckdSa1ZkRzEvSDNCeDBrZ2VTemhOL2hF?=
 =?utf-8?B?V0ZxYitxZ2ptbVNtbWJtQ1VTSDlrb0NsMWNzejgvMTQ2ZmtHc0dadGRLQW82?=
 =?utf-8?B?MnlzNUNkNWFzSWhkRVI1VW5qSTNpMy9QRytrbmxMbXJSdG53L2N4ZGZidlVT?=
 =?utf-8?B?R3dCYjhxVUF6SW9BNjJEdTNDMm1qdmYrbXNFcklWbkpBVWhJbzZQSlU4bUtp?=
 =?utf-8?B?YzcvQWNPOGUwQUF2akhrME9rMGg0bGJkOWxFcm9Vek9LTkk1L3JWd0ZxSjdj?=
 =?utf-8?B?Nk9aWUJvc29Cb1RMWlNKZ3BoTDBhQ0hiOVNpakVoTlIrWEhMSk9xUHdReHpU?=
 =?utf-8?B?NGhXRjlqR0xzUzJkZmkycXNyVXBYZ3MvbmgvaHBTUkx5cDF1NzNtNmExSzZY?=
 =?utf-8?B?eUpub052clpMaU9NZE42YUIzSVdLS0ludHQ5TlFpRnNkVmsyY3VkNkNMb1hQ?=
 =?utf-8?B?UElZNUhwYjlGRkhoakNvN04wcGFBRjNZbks0UXJxVUZ1TjdvM0wxMW9xRVRq?=
 =?utf-8?B?akVKblNETGlOcE9iR2lCbVNHNVBLb014cVJBU0lzMkc1TXhYZzBXSnpDRGJy?=
 =?utf-8?B?MytlL3lrcTFieERlRE42REJyS3NxM3o3Yi9hVXpLNk1lemxNOUJpVGFIbk02?=
 =?utf-8?B?UDdlMVpEbDJvVGc3NG15MDVaZEUvWHNIaFg5eWM2QnNqYmJmSW1uM04ybllG?=
 =?utf-8?B?cDRWU0wzcFdWYkdBUGhOY1V4bnlXRG1aZURVNnREbElhT3MxMmREWVA2dzBB?=
 =?utf-8?B?SmFVODA2Wm5Bekg5YTIzWjMwaThnQWdHWGVrell3QnZWSmU5NlNMYXQwNmRn?=
 =?utf-8?B?TjJubzNjbkVzRjFwVWtRTkFiZzMxdWlDbzNYV2pvYkE5UUNNK3F6V3lOUzZD?=
 =?utf-8?B?RWZLZW93Y3QzdDVmelNVcVNRc1hzejA4Y2ZKdGdXMm5OTXc3QXJuZVFEMzN6?=
 =?utf-8?B?MitnQW94QjVSUGhTSDNYRW5XaGNMemRMVW1kWDNPREZYelBrV1ZGRzRkdU5o?=
 =?utf-8?B?NHhTQVpRTEpnbStpNDRhL1ZCMi9FbFF6U2dlQnJGSGRIb2FrWU5LZzlDY2Np?=
 =?utf-8?B?M3lTWjEyNGszZXJuUW5ibFVGMExKSDhNYmE1K3QwVHFkYjV2U2lxSldXMUV2?=
 =?utf-8?B?TnZER0NjNDNCYnpvSENHYms4dlVsWHZOME5sdUg4VHBWVlo0OFJBNjRiZXFE?=
 =?utf-8?B?WXZ3UFN6S3p2Wk9pZVhQRjV4R0cyTCtVcUtMVGtKQ0dZRnlRMWhPSG9BOFpP?=
 =?utf-8?B?M3hsSHo0WHNxTnQ1N2dETjVjNzVGMXI1VjhIdTRGdUdCaThNRkxaUFM3MUg4?=
 =?utf-8?B?SU9YeE0wbXZKOFE5bnR6MTUwNWtLY2Q0ZkVrNWFJUWlCdHRUd0h3bllEcEpB?=
 =?utf-8?B?b2ZjYng1NXZSSkNlbEN4U2pyMmlNaWVKelRmZmt5QWxINjUvRzB2MDVIWTNK?=
 =?utf-8?B?L2ZCTzU3STZBWE1FQThTNE1lWnZncjdCRUNIR0hpb2VxQXBpMW5XVXpvU2Vv?=
 =?utf-8?B?Wk43eGFaQ3h5YjYzaVp6Vm9SWjJncVlybmZuOWxZdmU0OENld09KZlB1THlJ?=
 =?utf-8?B?K2pFelgxY1NUcUp5NnV4RTh3YzdNRkU0NHhJZit3ZXQ2c3N0RzNCUVl4eVRx?=
 =?utf-8?B?M0FLWGkvb1V3TTJyckpDMlI2OXdSTlUyNTlhWVdxRVN6Vko5TmZVall1clVZ?=
 =?utf-8?Q?T7mOwAgzl5EpMBuGiYrfXmdFC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81382413-6b9e-4b89-1024-08dd4c417b2e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9173.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 15:17:08.3644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDUkNuxlEexHlg4WzkQ9gSg729buFtXQvSFEumKrPF0H2yf6obCBjOSjkn8avX7IHObxz+Rrs3LbmcCuJHDofw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7791
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

Hi,

Changes looks good to me.

Series is Reviewed-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>

Regards,
Saleem


> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
> Sent: Thursday, February 13, 2025 3:18 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Yu, Lang <Lang.Yu@amd.com>
> Subject: [PATCH 1/3] drm/amdgpu/umsch: declare umsch firmware
>
> Needed to be properly picked up for the initrd, etc.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
> index ba550c7e2118e..bbf16e7b5ab9c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
> @@ -32,6 +32,8 @@
>   #include "amdgpu_umsch_mm.h"
>   #include "umsch_mm_v4_0.h"
>
> +MODULE_FIRMWARE("amdgpu/umsch_mm_4_0_0.bin");
> +
>   struct umsch_mm_test_ctx_data {
>          uint8_t process_csa[PAGE_SIZE];
>          uint8_t vpe_ctx_csa[PAGE_SIZE];
> --
> 2.48.1
>
