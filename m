Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C644C87FD3
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 04:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D637E10E126;
	Mon,  4 Aug 2025 04:33:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Frltxeks";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5FC810E126
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 04:33:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7+F7ic14awOFH2PzEjBpgFRH7eJMqPAH+rscYhRdYi/MKaK54m4kIDRxKwFrtSYTnvT9rLX9KD+3yibQAG3dg2AawDiI4FC6mGLoybkc/ZG3Ruu+ytkGSLCG61VPJJhAh7Z5gJJXGoQ1GMjdzhwn3l4x5HipzkSBeaMcf9AVrFLt0WihuF/6tqeE5cfMi/x4YqTr1N8rFJ/SCAlFAXn+Veul9Slha1mM8SEtt6J0mDqr48CMa3SdqKnYjtsLWZI470EeZUwbLeoo036aQOnGfDkBQbBh6CxRp+o/4wj2PwBlQ/E+oXNJEFzmKNFif5gIXQdcEeGyln4UaMYxOYuJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnxxUuTii7FIH3I/a+otlpAxAcXTIX717cQzVKgR//g=;
 b=U7PzVBUIlV6pg8VRJzu5PuYJVgYDtO5JrWR3dVTDpXA+TyPDZjOlC+2ipmit3yyOF7iRwwHGcvFwxiU0WkiobkqPD8tT4EkhYmzcDKgW2PyjqkNu7bBVKXCe+KEwZ2YdosvHL+xQrMF+fTYtWamhtri+gQwHhL8RjxewVOzkQjbo4J5Q9BSWFTFOnm9KEv0kYrJpTSG13fB4cZ4Grg6XklPWPODO8EKUnNPzSxyPvX4EDvulkLXq14s9q4PJPoFe1g5gEMfDSHvvMoJOEEsgG+B5auKZpidgnj5cVkML+8QOUskUsHCv7vnnnG2Uf1n8vBW9PhA87xVs+sNqL+C4Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnxxUuTii7FIH3I/a+otlpAxAcXTIX717cQzVKgR//g=;
 b=Frltxeksa+Uir4ev4j3yHEDrAf42h3Arojr/Sh4PbMaz0TJwt6dZ/Q279D7E22AQRThF/9brV4HIKS241BK3iauMmpmbSCUFYDuj6ethv11QTu+MOpWfqueyikV5Gbm9p4LQkOB7ykwUsS+KbLpzHV29fJlLGTtSByq9U77tySs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by PH7PR12MB6419.namprd12.prod.outlook.com (2603:10b6:510:1fd::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.19; Mon, 4 Aug
 2025 04:33:32 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%5]) with mapi id 15.20.8989.017; Mon, 4 Aug 2025
 04:33:32 +0000
Message-ID: <124c2f27-760d-4a13-a343-310ef356be2d@amd.com>
Date: Mon, 4 Aug 2025 10:03:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add description for partition commands
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com
References: <20250717110722.1557961-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20250717110722.1557961-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::15) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|PH7PR12MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: 02caf124-9bde-4a87-45cb-08ddd310113b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFd5WC8wUDB4dEROL1Jwc1I1bkEzclZmTUxuN05LREJyc0xTSE9CV0ErUm5v?=
 =?utf-8?B?bk1lVGlaZWRpdnliU1BaL3lWYjlWWVpXVy82dFNRK1JZMmZmcE1nbGdGcUpi?=
 =?utf-8?B?cEw4bkpBdDFIMjdYS2crS1l1L04wYXg3QU9oWm9pOGdqd0EzQk1pd3hBR29m?=
 =?utf-8?B?WTZvR2o0dnVEcnF5dmx1MDQxRWRtWDdlTzRONDNjcG40WjJVL3h5MnFOZ1ZD?=
 =?utf-8?B?SU5yc29oTlhOMHJ6LzY1aUt2Vk5RTTYrTDdkT1k5WUtic2dQTll3cEtFTFZ5?=
 =?utf-8?B?SHBOMkUwUUszdllYbXRGd3VVSm5KS1I0ejhwbllhS1lMaXRwSWU4UC9mUGpT?=
 =?utf-8?B?SXBsT21xWisvc1NYMkQ1bFpuNDRyTFJ2NXlPUXVQcHhhVGJZekYrUlk3RlZz?=
 =?utf-8?B?K0p6ektYalYvbDNLdUtXQ0I4eGhFOGJTZC9JVWN6WmVTLzRZSUFXYWFneTk3?=
 =?utf-8?B?L3Buc3N6VjQrUlNVNEV4Q3c2bzR2VXcwdEw1YmJodnhGdE1UcUpQdGNGRnpo?=
 =?utf-8?B?VjhhV01Wbno0T0NnV0lzRGsySW5GTDl4bjY5WVdLQXJFaVlqRlNlNExXdGVl?=
 =?utf-8?B?UGZxYnRESkRxMEMyRnpldGxNY0NGbmFjVEdhaXpnODNuTkg2ejRGNkZ2b1or?=
 =?utf-8?B?Ti84eFNPbDdCU1p6YmFyV0x6NmRibW81Q1U0ZXBCRGxYc1RLRlZCcHZ5Q09p?=
 =?utf-8?B?VHVQblVCNi9keDFPZGFVMHh1VnR4QkQzWUozS3RTTElpWk5MVjJrUkQ4Rmls?=
 =?utf-8?B?U0ZCK3VvV1dERUI4WHZZM0NOZnpsUTI2OE94SWVOYnFRdlN2emxNRVFCZklH?=
 =?utf-8?B?TmwzM1hZTkI0Z3I4bU4raHpsMnFOVWpFM0VpdzJSQlFtNDNEbUJLSk1Ebkth?=
 =?utf-8?B?VnRsQ3VjT2h3bWkwNWZrOGkxVy9GNGd3Z3lDbFVuV0FVVjM2bzc0MHF5K0Jx?=
 =?utf-8?B?ZWpGamI5ZnZnMUY5cXo4b1l1UGpDNkoxQ2VxY0hlck5iTmZ0NThiVlkyNWhi?=
 =?utf-8?B?YU5OOFpGK3BFTXYwY3NLVnZ4akpaZEhjNU5jUjBmNGRSNE02NVdBNjhOMDI5?=
 =?utf-8?B?Vit4VHJGYUdoVVBwUFlMcVpJbnV4SDZ1MHpOU2E1M0t4RytScnBUdm1rZHpq?=
 =?utf-8?B?U1E2Q2RGa0Z0UEE1VTc1TG9Qd3Z3NFBjQmR3ZEl3T216dWk1MStXQUFGVVhU?=
 =?utf-8?B?UzhyVFI3NWJWbi9VbUlhWHlIK2ZkbmpVMmxNVW9sUDIzVkZzMTdOaThJQlRa?=
 =?utf-8?B?dDJXSXRCWDJyMnMyQ1VZNDBPTFZjcWRKZ2FIUnZVdFFHc2tQTXN6UHZxNE9J?=
 =?utf-8?B?YmF0ODl0UWNZRkhUYmNlU0ozcXdpTWgzL3pFUEtYUUoyQjRlN2tyL3hZN3Qr?=
 =?utf-8?B?TFVqa1BySFpLV0VZSUpqMk1mNHp5dXpjQkRRalZoU1VjZjlRa1AzM2hQZ1hB?=
 =?utf-8?B?SmtDbm5HdkdBQkVDUTU4cWFMSEErQ2hpNlhtYVBneDNndG5ZN2YwYVRMSWlV?=
 =?utf-8?B?bUlaandIQUpnajE2aHdBL2JJa3BjejRLS2N6TzA0bTE2Sy9FNFltR0taZHc1?=
 =?utf-8?B?bkU1WXBPeUJNb0FYdDdUd1ZBNnQ3SVRyenJvTENtNmVtT3Y5bTZkTnlFdW5X?=
 =?utf-8?B?QTJtWlhTZmdBU0Ztc1JPN25DR3NscFR2ZS9mVXlsb0I2d3J1VWVqeVBmZWti?=
 =?utf-8?B?ZkJ1MG5jMnFPWFRmcVh2NUlwWnl6c2puYy9vNGRmVXVOT21Fb2FxOXNBcmNU?=
 =?utf-8?B?ZjJzbS95WmIreWp0bUxHR1MvNXppRlRQRnNYdkFOTnpJZ2JtbFBCM0Nzai9i?=
 =?utf-8?B?UXNXRklFOXdCWmRTaDhjVGZCMTRaQTFxNURLajkxSm1qRDVTSXJMU3RlN1JV?=
 =?utf-8?B?MFdwTG1rL0ZhYnIxZlFsRVh5UThYOTR3L0pOUng1bEltOTRWV2VvM21PQ3Vw?=
 =?utf-8?Q?ykqjbYGk/Es=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzRPZ3hPbThNenNsMDEyZy9tUis3YmNCMWlQMGtNRlNxRzdJMGpPOFVrQk5l?=
 =?utf-8?B?UjRuT1dtbFkvRy82VUN5UzEza1lqelZqSzNkbXVwWXNDMmJLaDdheDJBbWZy?=
 =?utf-8?B?dUZScWRMSzBCUTBHRytXUkl4VXdXWUZFbVhxemtiRWlWblIwUE5JSC9jSloz?=
 =?utf-8?B?VkM0bVBLK3ZLN3lqUnppZ3lQMDI3RWtXTm54cHh5VjVmQjJlcnFEdlpoNVl5?=
 =?utf-8?B?Y2Q3YUd5TFZzR1ZEd2RmOEVyUS93Q3E4Y1g4WUdmNjN5MkdYNEZzbXppcjdr?=
 =?utf-8?B?ZDNmejRteGZEcmFKeXNUMkdPU29VSUVaSEFPZ1hkaWoxOWQ5NWM0NGc5UUE3?=
 =?utf-8?B?bzRBbHlWbTVmbVZIb0lCRjNSVUxyWXdTdDYyc3ppTUlSK29ydmhNaTRyclBi?=
 =?utf-8?B?UmNhV1RqdVM3d05tTGVZNnU2Y1NmSXorRlpzNWhQRUZ1enFnc1liMmc5enNp?=
 =?utf-8?B?SW9Rc0JZdGhRb0xPME5hdG1rbzdUMU40NDliMWhwWWM4ZGNhYmlLVUdSUEJu?=
 =?utf-8?B?YjBnZGUrSEZqRlRuTnBqNkFOQXlNaFhBWHN4c3ZJMklYZDVMVUp6enlYN3Vn?=
 =?utf-8?B?UjNTM1cyZEQrcTVZMVFvV3Y3SjF0T2JxVmtNcjBKaVRZV3BYQ20zZ2ZZcC9Y?=
 =?utf-8?B?KzdnaWpMWEloNUU1cjRvcjY3NXBKK2l2aGE0Vk9zRU10cXl1eDkwY3JCRFZL?=
 =?utf-8?B?NG5NbVBCaVlVRzRUV2drSWlyTXY0OFFyR1NqYVQ3dUFIV2hKUVFEMGVJSDV5?=
 =?utf-8?B?Qld0U0FFODkyTUNENitBOW8veE5hSjd1cWRjRFMyeUlLMWYyVWI3WXo1UzdV?=
 =?utf-8?B?UzlGZWdielFqZndSam9ScVNybjV1N3pOMWpmcGhiZ0pZcU1PbHdLclU4V2JC?=
 =?utf-8?B?RTgxanZ0SUtnejJqNGpLYnBCeXdWdFlybHZTcm5hVHB2YW9ZeGlpU3VXSk9J?=
 =?utf-8?B?OFJBWmI0V2lUSmJGcG1XZkFmTjNWZkhRM01LWXAzZThuM0YzaGNCRG9WWkQ2?=
 =?utf-8?B?VzBiSlk5aUtVNEJDeWJXSStQaWtiL0FmZ2hXVlR4Mi9QSlFSQ0JobnRYU1ZD?=
 =?utf-8?B?cnN5djhvSkhTUXE2MW9acjFQa00rNHBkSG1ObU9PcGFNWVBGcWFjNU94Ukdu?=
 =?utf-8?B?NktlMmJoU0pIWFRrdmFKSXFVRDlHQzJRSDhLQmhIcDdCRk8ycGkwY0VvRDkv?=
 =?utf-8?B?U2xiUzZ2QjhnVi9tR0JnT1VLcmE0VC9ESjJLejhZbGJ5anVoY2JtRjdvSThl?=
 =?utf-8?B?cThzVVdrT2tlb0VjOTVLMWh1MThwQ2FwR3kxODJaTzAxc0hBMk1SVmhKM1Zz?=
 =?utf-8?B?d2NhWVJCY2VrQUZEMG95c3hpSE56RXk2SFMwVmdZTi9KMWlRVURDR05yRVNm?=
 =?utf-8?B?R3poaCs3b3dmZU1qSm5BcHVvdFdIc2hyYkRQbmJ1OTZjK1NocnpzTlVmTEF3?=
 =?utf-8?B?UlE3NjM3RXVxakRBYnZCczhBOCtZa0NTUFRrN3NxVFR3VGk1TGNsV0drUVcz?=
 =?utf-8?B?YUsyNkhXcFNneVc2MGVZazd2REc0VEV5N0ZwM3NDMkE0bCtrV1pLTHJ0WXh4?=
 =?utf-8?B?R29GOVVjWTNIVEpwL0Jtd1VPRGdwZkxhM3hOK2NsSDh5bURDZXNoS0J6UXNr?=
 =?utf-8?B?eWVKWjloUWtUSTlXOTlWY2FvTEowL0h2NGIxVGJ6b2w5QXEvU1Z0QWc0S0R1?=
 =?utf-8?B?UEs3RGluM3J0a3R2dzhaajZoY1FGNkU4eUtvc0RnNFFYTVNSWFpVcTBaYVVJ?=
 =?utf-8?B?YnU4WSsvYkgzMVVnNnBTZk1TZlFrblc4NmVHcGRaL3phRTNhdlVodjVzaXJ6?=
 =?utf-8?B?WitqcXhVb1J6ZU5TWUl1TFJHMVZaNU8yRlREdTVjZG9sZUo1OHlUS2ZmRXlt?=
 =?utf-8?B?bWU1amhvajBHb1o0bmxyRlAva1B4eW1KL3JONkNLelFGNEltdzdrZlQ3OWtB?=
 =?utf-8?B?OHRtdmpFenBBM0F6Mk9CcWlVZWpNZ051N1RnNE5MR1FNTnM1Yk42dGhDWlJC?=
 =?utf-8?B?aU9UUk56SDVDeDFUS0Q1TzQ2ZitXdE5VL01JSlIyUGRoajZUMmhrVDcvUUxD?=
 =?utf-8?B?MnVQKy9ab3pXbTdsVUt4RzJuTkkxaFRiYU0rZ3lkS2ZBRnNBZkpRbE5GYVdR?=
 =?utf-8?Q?7zhyMtQFei/2NENr6iu60XlKe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02caf124-9bde-4a87-45cb-08ddd310113b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 04:33:32.2646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QVquFL9+X52m1pRdHb0o1xANNUsxNf3JfOIR65Eg+TbriLRCUzyroNcLbdNHdze
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6419
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

<Ping>

On 7/17/2025 4:37 PM, Lijo Lazar wrote:
> Add string description for partition commands.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 25aa35de1e41..030d7db78b4a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -666,6 +666,10 @@ static const char *psp_gfx_cmd_name(enum psp_gfx_cmd_id cmd_id)
>  		return "FB_FW_RESERV_ADDR";
>  	case GFX_CMD_ID_FB_FW_RESERV_EXT_ADDR:
>  		return "FB_FW_RESERV_EXT_ADDR";
> +	case GFX_CMD_ID_SRIOV_SPATIAL_PART:
> +		return "SPATIAL_PARTITION";
> +	case GFX_CMD_ID_FB_NPS_MODE:
> +		return "NPS_MODE_CHANGE";
>  	default:
>  		return "UNKNOWN CMD";
>  	}

