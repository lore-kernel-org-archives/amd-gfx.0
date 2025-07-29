Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2701C83F26
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jul 2025 18:04:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6464110E66A;
	Tue, 29 Jul 2025 18:04:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xz1Rj+Y8";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5D9C10E66A
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jul 2025 18:04:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dR0awVU0jQlN5NBWY4kfLPuue1Mb0HSa/UMwnDgkPkH7pilpwa1j/hWcel/SzlSOP7+wMXQioKj8T0tAGuOXrT668UwCe417erlmom0Q0NMElOPaOxo/OjnacTlkT8YZG7BnZh60n8KxB+gM+E/c3FUQc8X1EEjqEjJIQeCiUBiV5OZAQxbv4/gEfHtFJ8/K3s2c3XzZEv512VSMw8mtfxHFjLEcyeDAl7iUaH4NZJeyu7zlNgpArNf5oxvj3+y54LXDVK9zdSbGFkFkC4NbLCEh0Vx3elYAoKiNrr6NTDJpcrAegF78q4hRCHhDG2pbkTqi/WolAXsNT8cYTuVP3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K00j0IK36IDS5tsFCuVv6c7FfSZwKbJhiXxQRrqDS/I=;
 b=YcpHKLEdUge/fIuEOOPl61MXCwKwUbQz0yFIktK+1VlaZwal0Nb+5LzD1y45I2GtIYP9Z9e013gVHOqcfOMO+OkbVAI+2sKvLcIKhhAcav9JaYR0T66RrGtAzG0IM82k3bPc6sUOrLO2tF11O+OpdElQM0FX36l4qa/AMl7EfADxU4uQDZG/BydrDl1H0hyhnRVQQ+VtbG2futqF+G+rkZ/mHCcYLqFDjT2diWcx7NIaBRTWpPmaP7h5bI0E6yzBYYT982iytlysDTjypM6GQZOYhrwO8dIUeLrPbswmnY+gjbCKNjjnTzmML0zRkaZ6pSc6SBDLNluxjSig8xMhaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K00j0IK36IDS5tsFCuVv6c7FfSZwKbJhiXxQRrqDS/I=;
 b=xz1Rj+Y8KgwqI83SZ3tk6FVYNy7PNyZk0GzM3KLGuYcJwjyzS896u/UWFPBaIpW/TDcM2JjoWs57WBq2G+HJSWyPJ/su97BWHoAyuKyXVjqn4nkTPraHNc5OuAcB8IT8Os+l4FxoaHmOLaJhCcLYrUrkO55FDSs+cC7V8S7nblw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 18:03:57 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 18:03:57 +0000
Message-ID: <68370e57-cb4e-4ebd-8d04-b198a7f2f02f@amd.com>
Date: Tue, 29 Jul 2025 14:03:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] drm/amd/display: Determine DRM connector type more
 accurately
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20250723155813.9101-1-timur.kristof@gmail.com>
 <20250723155813.9101-2-timur.kristof@gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20250723155813.9101-2-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::18) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: ae263659-3322-4db1-4ccf-08ddceca49f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFUzdUd3RGdrWlNQamZnSjhjMytGbDR0VWNrYUh6dlUyMXY1RlROWURwM3c1?=
 =?utf-8?B?RGlMeXQzb2lHVnRRWFIrK1NGeXNMOWpNMUlUanhuK2t5S2hxWjZwWlEyd24z?=
 =?utf-8?B?SVRQR0ZNUUdXM0VpU1h2ZkMxUDRVRTBKOUpkSVVJbUlUekJ1K1A2VlZHV0hW?=
 =?utf-8?B?MXl5Vk93eU53TEhFRVB2c3hoKys5Zlp1blBUUFhpMUtSRVI0QS9GWVFqYkNC?=
 =?utf-8?B?WjV3d0RETWdvZ2xYRWJjbXVHakl3UlhpMkFyZC9CeElacWtPcXEvRklwN1Fw?=
 =?utf-8?B?VmpvU1R3RGIveVJFenQrTS91L3ZrbTZ0aHJ0SHVtVGEyV054Z0kyUVJIbmMw?=
 =?utf-8?B?RGxuZlorZlYwejlOSFhpTEgvamVxVExGK09zQy9DVlFNN0UyWVJDRSs1VFhz?=
 =?utf-8?B?ZERTNVhVNlB1dEZ4NU1keDdtZnVUNUplOXdvbnZPRGVzaUtOZ0VOeVk2amFW?=
 =?utf-8?B?ckYyNzVWWTdrU3BWNGZYZTFqK1IvcG00Z0syZWdydzJ6eEdHS1RBL1d6czNw?=
 =?utf-8?B?WHJjcXhpWGY5RkZ0a2RlZGxmdWxEd3ZubEx6RXVjSmVpajFPVzdoajFDY2E4?=
 =?utf-8?B?RkJMbkV1eDJIV0VJTkpqVWRsZm54cEJGemVkSHlHL0pXV25vUG1uRzVBaFFt?=
 =?utf-8?B?d2tnRWl5dWJxRW1ydEo1aWY0NU1KYklMUS92QTFIbDQzTnhINVg1K0JCb1o1?=
 =?utf-8?B?VzhJOFZiVUw3TkNnOS9Qc292MEJkYWtNTnAwN3k3TVRaQUVFTU9tdllTSE9o?=
 =?utf-8?B?RFEzeTBtTGM0VjVPUFJTM3Z4Nm96Ti9MdUh2ZkNHVS9xM1dMM1ZxUTJPRC9k?=
 =?utf-8?B?WllPMEV5Nm56cEtaQXdVK0lPeG1mZ3FWZGVQbEJyaVFZYVdRV3YwYlRETWNw?=
 =?utf-8?B?VFphdEJlZzZ3ZWdwajJNK3hsZGVEdmIvM09SMG95bE1zMlg4L1hvREdqOWVE?=
 =?utf-8?B?RW1HT0VXTVVtQXNzOHVqb2hTdlljdnl4M1RvN2xhcFBEYU5ScmlsN212b2dv?=
 =?utf-8?B?dlBRazNwTUNSTnBiMzVybUUzSUpvSkNUbGVYcWJ3aVczWWQ5Mm5hVFdFRjYz?=
 =?utf-8?B?T3dMd0RrOE1UMWJCYWNjV0FJOEtMZXo2SG9ZbUF1a09wclIwaGQwL1NxcE40?=
 =?utf-8?B?bjFEd3JpR2pSdzd6YWpwN0pnMkNNZWQvNy9CaDB1NE9IVk9OcDNGdUgxWC9C?=
 =?utf-8?B?Vm9rY1lQTVRWSjRiNlN3aEtVejlWQXlNNFFKSnNQZnBaRXNsUHQrbVFyYi9I?=
 =?utf-8?B?ditEZ3g3MS9uSkdNZXpSblRQUjVyNnZhM0xsNjVVaXdFbFFqcTJ1R0ZDQVZ1?=
 =?utf-8?B?SWFQNHhDaGNFR2RoM01PMGJqQ1Y3SGlhMXZWb2tMS2o1emhpZ0RDN0NEUWhI?=
 =?utf-8?B?R01YN1JxRm56MFBNZ25JUFNpQ0lTSmFNVjF5V2htMXdTZCtwYmYwQ1RCK3Zo?=
 =?utf-8?B?RnVTdS92SFV4NmZkdXBJZUZSUVlENElWTG4yeHM3eE1XVHVGWmVUY0ptcDdR?=
 =?utf-8?B?RnU1UnZ0d0hGNjhrUzBaakcxREErS2hNWVJYelpOWFFSWXJka3h1bER2MkdG?=
 =?utf-8?B?anp0VkxqdzJYRFBNa3F3SWkvTm9aWXdUcDg5L2Z4cEI0T0RDUXJYcW9kdTRi?=
 =?utf-8?B?MVR2QzlENWExdUVuMjNtK285N0RrT2ZzdEE0Nk9oU1pzcm5wNGlGSHRvZHNJ?=
 =?utf-8?B?RkdtVk9UNHF1T2xmTW5FWkNBUVZRcjdyWHd4SDhrdHN2RmxBd09ZVTBSZEkw?=
 =?utf-8?B?b1djRkFmbStqS2N2aGUxTVZ2a1IyTEY0ZnJMY0hUdU43L1RyTURrZFFlUlE4?=
 =?utf-8?B?WW9aalkxR0xoenZqR1hCWXFOdEJpVEQzbjR0SUpNaTVJdjI4enJsZE9aeFdN?=
 =?utf-8?B?QjRiMXpJS3JQQ0JsOUxCY0ZTNktUdjE4Mk9seGFUZGUzekNzeWllNHA1Tkp4?=
 =?utf-8?Q?DMW3AKAYLcw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b25wM3J3ZG9Ka08zT3o2WS85Vzl5MjJacThadEhCOTUrOGhjVUpDWHlNdGE3?=
 =?utf-8?B?WmcrS2Rsb2VBakpzNXNhVTlsOTUzTHRtUXgrL2tGcVoyS2x4TVg0eURVcjJN?=
 =?utf-8?B?VkxKZjdES1lTZkRLN2xBZEFRMUdwZzY0WHYyeUh2RjlHOUtyK1RQT0FvK0o5?=
 =?utf-8?B?MEZMbjNkN3ROU0E2d3Jwb21Tc3NNSkNPNnVhUVp3S0RmN25wak9maDdsNmFR?=
 =?utf-8?B?Y09FeXRiZFB1TE5nQmxzS2hEVmJVK0VXNkMyb2dKS0tGN3o2T0lVTmwxalI3?=
 =?utf-8?B?ZTBaaktmM3hOYjhPWHlES08zbkRKTlBJZDAzczF3bTBLejdwaFdUdFdtYmsr?=
 =?utf-8?B?dWNOSWx0WmtZSnd3OHpkQmY4VGZrUGtGa2UzVE1BVFBxNFZuQUdvNXlWNDhK?=
 =?utf-8?B?VmJlcGtaSE1ESFF4WFpLN2dtYVBLU0NXTm1MZEdpaGFnUGZTejcvakwwbVVz?=
 =?utf-8?B?M0RuQVhYOTl5SVdTdncxUjliaDdVSkFDNE13LzFpM3JTK2hlYnB4SzVjK2ow?=
 =?utf-8?B?YlFDTExEQ0d2VFlJSG5hUEs4LzlvTGtxaXBRWk9jQzlGR2tIYm51R2RMNEtY?=
 =?utf-8?B?b3hXdnZ4emhHSXZTMUg0K2d5UzFDWjRZYlJ3M3lKeDVnemNSdEl2Rm83L2VY?=
 =?utf-8?B?aFdoSFY1YnlvY0Fsb2JJWEdvdzd1Ym5IdEhtNkcydVF6bEtmWDhubWo2ZGlK?=
 =?utf-8?B?aDltUm1wWlVDL1h2NEt1U3pFMTBrd3Q3bmV4ZUJGV1hkK0czeTVidEpJVXlJ?=
 =?utf-8?B?RHRoaWdIV0NIa1Y1akVFbDBaNUJNQTR0QkVrcS9rZ2ZCN0o3NGJkU29RaGND?=
 =?utf-8?B?RVdRbjQxQzRkL2RrcTBINWNXRHpRdHNtbmZyL2h1R0VYZGVtRlExRHlkTlY5?=
 =?utf-8?B?M1NWZHBCT0FCcG5pVlhCakN0a1c1UUZhN3BKWXNqTjJwMDR4ckdaWnpwR3J3?=
 =?utf-8?B?dHdaSnhhY3ZLTC9KeFhSaUZJaVdFZjRrN0F2cXRTRnR3S3N6Tm9Selc4ZDVr?=
 =?utf-8?B?S2o5dkxERXlXaU5hbnc3djZQY0M3ZS9MdEpBRE1GKy8wNEErMFVLSlhuT0d0?=
 =?utf-8?B?Uk9FNjRIN2xNMkd0bHRLWFcvbkkxNllHSU4wMng1ajVmK3ptb0taT1VoNUR2?=
 =?utf-8?B?d2lkNHRDbVNYdThPUWluTkJMTmdoNk5GRDl3eFlWTGFMNDNZZFh4NVM1Slkz?=
 =?utf-8?B?Y1VnZkk5ZDRkUkVPeW13S0VqYlJ4cWR5Nyt5SFkxYjI2WXJRMEUxZm1QSit6?=
 =?utf-8?B?K0RzVVJHaXJVblFVOUtEWXRYZ2tEcGJvcTRkQlRtK0VnTmxBL2x0NWo3NjRW?=
 =?utf-8?B?MXRQNGpPOHhabkVhR0U4TzVLTmdBc0dvV0FlUUNsVEtjUG83SEQ1blQ4V0Y0?=
 =?utf-8?B?Q2pkK3IzNFlIZzI4T0xBRXVMSGsxRlYyb3p6RzJsVFZhUnJURzJzMDZ5Yjl4?=
 =?utf-8?B?UjQ5bm5kVnA0d2tmUEh6ZXZYL1h1d2N4Z001cXhRbVZNcGNDYmZrcVFwYjJS?=
 =?utf-8?B?MlVuNWgzT3pRRjVFRzV4MHovOTJudTNaVXc2eFkwbUVIR0dRK0EwbkwzL20z?=
 =?utf-8?B?UFQ1Vk1jYStQK3BzTUFVaVFTaVZoYXh1UDRpWmZXVW4xa25GNzBOd1RZOW43?=
 =?utf-8?B?aUFKV2thQ2RIUkZ1N0Frc2tmTEt1Q3Jxa0pCV0NOM1FNWXRGU1h5V0c2MHhj?=
 =?utf-8?B?eGRCRnFXbG90STBTWWZLMlphLzlvZ2FuUGFtVXRGSUlhMUVEVDAzWXhJTjZq?=
 =?utf-8?B?ZHB4b0xRUTlWT0Nxdk1uRElRRStRNWtodmVnSXgzZjh0SW9RTVpGSVNkTkpQ?=
 =?utf-8?B?QlZjajhjNlNObXpxK1ByaHk1Z3YxekVESTNmcGdMY2t6b2N4UHg1K1J3UjVC?=
 =?utf-8?B?bVFpaWZZeFNzcVdHblBUakowYkRmbVI4cDZhWCtUSVJaUXZxL2w3MjE1bS9U?=
 =?utf-8?B?cHRweU16THVmTjMrUzgzZys4WU4rTlA3aXlXSFA1TnlhUU54TFlzNXA5emNW?=
 =?utf-8?B?cHNPSFhOYUxmaEQvNUpueVNGMjR4cGdRQy9nMnFybnpiMkgvMjRLMDJwNHJC?=
 =?utf-8?B?WDFERFZDaGRBR2Y5bC83VnZsTklMNXdrczVKb1VPbG9RdExCZUxYOTkwTHNt?=
 =?utf-8?Q?R0o4UqjGgQoN+bAK9/tZqPVY8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae263659-3322-4db1-4ccf-08ddceca49f7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 18:03:57.8090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IUyQFtWf2/2pBD8sMb8r+SiTbtcoUtIFC4Xutc5QPpKBSFiVk8pLLRT8SSoWRbVOIW2ApL19gkBuDxSGxQEcgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875
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



On 2025-07-23 11:57, Timur Kristóf wrote:
> Previously, DC determined the DRM connector type based on the
> signal type, which becomes problematic when a connector may
> support different signal types, such as DVI-I.
> 
> With this patch, it is now determined according to the actual
> connector type in DC, meaning it can now distinguish between
> DVI-D and DVI-I connectors.
> 
> A subsequent commit will enable polling for these connectors.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 28 +++++++++++--------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 096b23ad4845..c347b232ae06 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8038,24 +8038,26 @@ static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
>  	return 0;
>  }
>  
> -static int to_drm_connector_type(enum signal_type st)
> +static int to_drm_connector_type(uint32_t connector_id)
>  {
> -	switch (st) {
> -	case SIGNAL_TYPE_HDMI_TYPE_A:
> +	switch (connector_id) {
> +	case CONNECTOR_ID_HDMI_TYPE_A:
>  		return DRM_MODE_CONNECTOR_HDMIA;
> -	case SIGNAL_TYPE_EDP:
> +	case CONNECTOR_ID_EDP:
>  		return DRM_MODE_CONNECTOR_eDP;
> -	case SIGNAL_TYPE_LVDS:
> +	case CONNECTOR_ID_LVDS:
>  		return DRM_MODE_CONNECTOR_LVDS;
> -	case SIGNAL_TYPE_RGB:
> +	case CONNECTOR_ID_VGA:
>  		return DRM_MODE_CONNECTOR_VGA;
> -	case SIGNAL_TYPE_DISPLAY_PORT:
> -	case SIGNAL_TYPE_DISPLAY_PORT_MST:
> +	case CONNECTOR_ID_DISPLAY_PORT:
>  		return DRM_MODE_CONNECTOR_DisplayPort;
> -	case SIGNAL_TYPE_DVI_DUAL_LINK:
> -	case SIGNAL_TYPE_DVI_SINGLE_LINK:
> +	case CONNECTOR_ID_SINGLE_LINK_DVID:
> +	case CONNECTOR_ID_DUAL_LINK_DVID:
>  		return DRM_MODE_CONNECTOR_DVID;
> -	case SIGNAL_TYPE_VIRTUAL:
> +	case CONNECTOR_ID_SINGLE_LINK_DVII:
> +	case CONNECTOR_ID_DUAL_LINK_DVII:
> +		return DRM_MODE_CONNECTOR_DVII;
> +	case CONNECTOR_ID_VIRTUAL:
>  		return DRM_MODE_CONNECTOR_VIRTUAL;
>  
>  	default:
> @@ -8440,6 +8442,8 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
>  			link->link_enc->features.dp_ycbcr420_supported ? true : false;
>  		break;
>  	case DRM_MODE_CONNECTOR_DVID:
> +	case DRM_MODE_CONNECTOR_DVII:
> +	case DRM_MODE_CONNECTOR_VGA:

This seems unrelated and would do better in a separate patch.

Harry

>  		aconnector->base.polled = DRM_CONNECTOR_POLL_HPD;
>  		break;
>  	default:
> @@ -8631,7 +8635,7 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
>  		goto out_free;
>  	}
>  
> -	connector_type = to_drm_connector_type(link->connector_signal);
> +	connector_type = to_drm_connector_type(link->link_id.id);
>  
>  	res = drm_connector_init_with_ddc(
>  			dm->ddev,

