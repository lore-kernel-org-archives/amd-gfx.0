Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0CEC5AD49
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 11:34:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DFDF10E0A1;
	Fri,  6 Jun 2025 11:34:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xgQBJRMG";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5286910E0A1
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 11:34:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBm8+rkuAJ5T7NE5gHGfBld+wW3t5MLu3Lrp5QGEKV495WIzwdYql+vjx7b8Y2G01jIineOPdgMtdMRuKOCjRD/nTYgueO+ES0KF+cAM4X4zQcOXt5T+JvxzIKCP6FvIqOcyzL47Mo+3i8ALsJ3ONYL2z8dF73eSbPuNBrgvxSs49Bp37lOub2S6rBgcLxL+p1WScwy/iywxqMYAC0hx/8AZ9R/5tAWKF0jCX8uVLxHjv9qfTZLPjsSjlCTjqGUQE9XwzaG5dhvoIXEga6pVuOF/447o6Si4Qql4HvsyWLK6wpCUEvAfZpmAnQ5tBmbRDsnbWkPns32XOWX8AFlhhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xLPBb4PYGrnG8okCLZem3XmCfZksbwSCxlEw0w8kng=;
 b=Ria/T57EiWmCD2/B88+wI1+Wr2L4UFw0X+fw55j77FYB9D27lbvTe7IUfuMOAFoE6Z1Km5qj2rF2kA+3AJy8jLGzrJj4R14lYS/2jYsoTeInzIh90RZ2GvIaBskITz0QeOofFtXWHNOX79LDfAQprGkGOxqJJbTkuylxd28RQzRJp+IwmFk4pl+lHGsq3YsO2GBoLqKbwNHJnCoQsnRieT57EL3Sm5BiYCaUVXui06vHQKF8kTCanAXzVnfDIzGtEH/s2z7A9IsnEnoGnkvyzpK8JyCTJla/aeNh+R3cJ+9Zenw8Feov0FXo9t3TyDMH9IWUC/Qolxzzp2gc4+GY4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xLPBb4PYGrnG8okCLZem3XmCfZksbwSCxlEw0w8kng=;
 b=xgQBJRMGnm1FZXGIXsMIg3WjvXq5JwbQ/O1LSVZ/RkcvKiUsVlnCy9vASL/cOdfyljDD6nmAZ6BWRHSSzdXhYvS+u1htyov5f+8WJOUFDtfr5URLcK828cttbs2KYup3COjZQ4hmipD8hyMnYZhHAQZaNwMkWe3lTib9ido7Tyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 11:33:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Fri, 6 Jun 2025
 11:33:58 +0000
Message-ID: <13e1a3fe-3761-4a36-8258-e516d2bded03@amd.com>
Date: Fri, 6 Jun 2025 13:33:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/29] drm/amdgpu/gfx7: drop reset_kgq
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250606064354.5858-1-alexander.deucher@amd.com>
 <20250606064354.5858-3-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250606064354.5858-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:208:335::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: f699039d-f9ab-402e-a800-08dda4ee0745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dllkTDNxanhsODlrWXM0akdxcW1KVXpBMzFoc1J1U3FGdXpYSi9aTFBhQlZO?=
 =?utf-8?B?STJ6OTZSSkdwVllWRVJPZzNUN3N5OVVVMTU3WUtxaUJWZFh1M2dlL1EzbHlo?=
 =?utf-8?B?ZHQzdFBnMExIQ3I4QXJyanJjWlpRajJLWWp1ajZCand1dFM5dzV6ZDFvOFhN?=
 =?utf-8?B?bnQ3YVNtNytjU1dha2xsbVZzRWlvN0s4aDM1MnpHSVRHcVVoMnl3YUg2R1lE?=
 =?utf-8?B?Vnd3WjZ1YzVVOFVxbkxuUnBhZVBqQ0lhaGFHbTlSakllNVNqYjBPZzIwOTVM?=
 =?utf-8?B?MHFNZiswM1UzVFdsVVRHM0RyVE9qVEZzUFBsTWYvdCtCVGtJeXNhM3RDVDJL?=
 =?utf-8?B?NVNXRmtvWVEvU3A3YmFFSUtUSmp4R29CZStYZnBFcWEwZTV1NXE2WlBIV3Bi?=
 =?utf-8?B?RjJmOSszK2JSNWVBYlpVUkZNeG1pSVJkYnhhdUwvT2NzUHRoYVhKUTJBcjVL?=
 =?utf-8?B?aCtnOEdKcWt6azlEd25GSGp6RXJqTGZnVlJ4NldEVzF1R3JPc0R6N3g4R25K?=
 =?utf-8?B?bkg0QThreFFHbHJQcGtVaXdwVjRzUmEySGlVV0pTVUxIUFl0dG9KbDJRa0NI?=
 =?utf-8?B?Z3ZSYnRoR0RYOWFLbmFMR1NHUkRDeWtIWkliVDBzRHpvOWVvbTRnb3lHUHJI?=
 =?utf-8?B?cHJoMWdSUjdhUkRqeUQvY3VrZUlLNFFtekh5QkFtM0FDYk9sT0F4bDNTaUlk?=
 =?utf-8?B?cFV1c1BIRWRJaXNCWmt5UnIxOWJhRGc4TUk0ZXpWalIvVnBSUmppWGhNMWps?=
 =?utf-8?B?R2RXYTliNjdQOTkvYWR4d2hNamNJNG1vRW00YzRIOE9LNFVjSW5EMGhKc0E3?=
 =?utf-8?B?ZitUNHVyanhyVVVZcXRwL2E0WWMvc1d0VU9uTGNXbDIyNGc3WElaYmdndnNK?=
 =?utf-8?B?UDlSUTl1NUwrbFN1SmhMSzNoaDNOVFJIWFlVL1JkNEZoT1cxZWh4aWR2Nzc3?=
 =?utf-8?B?a2NWOW1PanUxUTlyUFVMZ0l1VTBDMDRTNlF0UzNsZlZmb0hWRS9XR2U3NmlY?=
 =?utf-8?B?cTY4Sjd0aVI4Mll6SDEvdm5DYjVzZ0djRmdtazZ1TldRV25XTHJsd1lUUE5G?=
 =?utf-8?B?T2NqclhSdzlLbTA0YTB0U25MSDhHc2cxb1JDR2laYi9LZW1sTGZ1V1dGTUFB?=
 =?utf-8?B?czIrbHFycmJwSDFGckVmWnZoSmxPYm9vS1BQSlA1STdFWW1HQk5oK1c1eSt4?=
 =?utf-8?B?a3I2MG9sdFMxUXNhOVBSVEdCbnJ6WjJzZnd3NUlLby95KytrM296dXFBNWlS?=
 =?utf-8?B?MTBEUWl3WXB5RmZBZGpSaEdodFZXV1c5eEE5U1pwaVg4VjJ3c2FudnlpakVP?=
 =?utf-8?B?UkZKK2Z5azk0U1JKTGVySXFNZFdvK05BLzhNaGgrdVNndjJGVWl5b3I5L2FQ?=
 =?utf-8?B?V3dSNi9ZVzUvWVpYdUl6QTBPajhLTzRWb2Z0NFhveHRRUXMxVEo1NzJYZzEv?=
 =?utf-8?B?cEFDVWRudy9mVStFNStHdkx5MWNCOVJ6Unc3eWF3K1VCV0lIZ1VMVnFVRFJ4?=
 =?utf-8?B?Ym1kcXNwaWNMTVZDZ1RGeDltdjQvQXBDMXlpNGlFcXkrMS9iVWlDb2ZVTjMz?=
 =?utf-8?B?cTJSMTUzMzZmS1lQVUtsTWZiZWQ3VFBIQll1OTRpK2cwcXEweVVsWHNpNUpO?=
 =?utf-8?B?aURoRjQ0VkNSUlJjVGwwZzBTOVlJcUl2RFVtR3k2WFBoMkxZM0wvSXRjNlJF?=
 =?utf-8?B?R3R1c1VySC9FY3NDNUhZWjQzSU1vdGo0TVJjY2VmSDlFVHd6QTBsMjJNTU5X?=
 =?utf-8?B?WHdRWFhkTVdEaUdHZHhYNXk4YVdPTndkOEJPSlkwZ2xMQ2J3QVFmbS9HVEdl?=
 =?utf-8?B?SG8wY1RsL0x6TG94UDh3NjRVUEZaNmhaOWJ0YWlsd3Y0Vk9WbUl4c3FwK2I2?=
 =?utf-8?B?Rk1BaXdQU1JxckpXZ0xQVG1WK2pRTGdxSURhTTE4NG81YjRtZTZSNVBZS0dK?=
 =?utf-8?Q?JEFCQKUTWDU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmR0ZHFYdXlMTE94L0NOMjZyejB0MGVvSUJpQVRhNlVDSEo0Rk1IRnNuczI1?=
 =?utf-8?B?RFd3L2pLQkVOZnp5bGVwcE1oSFliWTdtM1pjRmhZd0NNczNOU1FyY0lvY1pQ?=
 =?utf-8?B?Szh4RExnWjEvSERCVU9Cbk84cmEzUlE1L3FBR09XL0l1TEhxZW02bWFMUysz?=
 =?utf-8?B?WFlNWldyL0x5dVhsbTZtRE5wa2FhbTc0T1JFVklJY29MbzRHOFZiN3RkbGdy?=
 =?utf-8?B?elphbGtBTlMwdWo4cGVBTmk2QjBVUk8xajN4NnZqLzNDTzZmWlk4ckRzbjBR?=
 =?utf-8?B?b1NraHczU01HQmtrNFRwS2VlbVNWRkFOcXM3K0hoWnRWSDUzU01qZW1yY1Q2?=
 =?utf-8?B?T3dVRjViT3lOalRId1FDL1FDZVJiK013UDU0Nkxtc20zNllTN2U0TmxoREdL?=
 =?utf-8?B?VUdQanl6bEpQME5HOUdZaVZvZEtiNE9pbnpxQzFMSUNWeWVyMGEzV0ZKbHZV?=
 =?utf-8?B?MjdqT0VnRjRWTER0NnlyMllhOHErT01nMjR0bXlyWFpVbDlOWERkalVGTlp6?=
 =?utf-8?B?SkllUGdIQ01WTEtoN014TlViK2x1dXBLYmlGclphcmpRclNOZHNUb3ZkUkJk?=
 =?utf-8?B?QkhNdHJsZzFJeWxoSHRseCsvcWRXSFZnUHdkVGhwVE00aHdGd2kybW9QUFNj?=
 =?utf-8?B?UWgwQXc2cmV3Qk5CM0hPaGpxd0s5YnVLK09BK2dXVndLaE1zOHRudkkzMUho?=
 =?utf-8?B?cHRSWDBxOTFQZnBieGFZZ1RpUnhWQ1pNWW5LMWFKeEhuMk5ENzI4RS9PcTBU?=
 =?utf-8?B?di9WK2dFZWEyTXF1MGxQR3ZRTVg2NWM4WmhZbWlTRENmZGxJdFRtN0xWQkoy?=
 =?utf-8?B?OE5GbHF0UlkzVXNuNkcwV0gwU3dTeHJUank1Uk5IeFIyRXpyZUJ4NWFNNW55?=
 =?utf-8?B?RjlpcGEyL0xrTXNsUnRjMExMWXU4d3ZLdDhYUW1OZSsxeTFVbXZiZVpmYm5y?=
 =?utf-8?B?R1RyK3ZCZElDS0JGTnJVWUpiM2ZaVkl0NlpxQlBGUW1KNmd5S0NCaVQ3RlRT?=
 =?utf-8?B?RzFFQ3prQnlGWHF3TlUrNnJ1LzRwS01lZ3BCbVk3UjBRVWdBbmh5ekFIdWpF?=
 =?utf-8?B?eFBLMmE1ZGdMOVdrRnk2TEpwbHZyYW1acmpFQVF4UkdiYzZVQXVxODNnQkRR?=
 =?utf-8?B?Q2tVUFJvR0g5Z2lSSjhHKzdmcU5Oa3ZZSFNPVzU4SEN2MEtQS1hoTlArT2Jq?=
 =?utf-8?B?aHhNNnRaeWRzSmlKOWJBVFQ5WDRvdVFDYzBqVDFOY3lJc3FFWFFYL2FIaVVt?=
 =?utf-8?B?UVczWjZ6M2gvVTVKWk5XM25SOEhwbEVEZ1BydDZ5V2orcDM5TUVOSzFxa0Jw?=
 =?utf-8?B?VUdrNy85ejJzTjlrRDM2UktsWk55Y1ljSTN4RjU3NSswSWxBR0pFT2dRaUNO?=
 =?utf-8?B?eWhiTlk1bjdERUo0L25xbFdwOHRTTHpqM0daY3A1NzZHWDZLUEx3MTRVNSs4?=
 =?utf-8?B?UlArR1FUc0h1TGJmMkhoa1plZnpBc1hyTUpkYXNmMHdidWNBV1d0dGNjd1Uy?=
 =?utf-8?B?UHVZZDhwTlhqeXhjaEpsdll1OXFuanVzNTJ1QjJ5Z0ZaU1QyNHFweHJEbXR2?=
 =?utf-8?B?NTFhSlZqUWhISU4vcVNCYnNmNkRVQUpvdloxTHFOR1lJMThFeTcxRWhpdm9N?=
 =?utf-8?B?Y0IxQjhkdjVZdTZ3d3lXRUdQZEZhSE9BeGRySCtFY3RnR0pyR0NSSThqN2g3?=
 =?utf-8?B?blQzODVPTWp2dHNWQVpmTkNrUVFONTNaMjdDQUh0dTBVT0M0TVZ2YXpyWldM?=
 =?utf-8?B?cDRscnhVMkorQ0orbzMxYkMxdS8zR1BXSXBhZHRvU2xoZVFpRXhGV1BqTi9N?=
 =?utf-8?B?WGYzc2hWeVRLcnQvenRuM1c5c2I2aXBKS2xTclpYQzRDL0Ira0dKa2pyMC9n?=
 =?utf-8?B?WGtIMTduOVM2WDdvQ3hBRXpQekdYeEpRZTJHQlRjazVkakxaWE1MSkUwdHJN?=
 =?utf-8?B?WU4raWFvWTRIOXN5bVR2UW5uOHVtWHBnNktla3c2QW44U0ZtV1RJRzFRRmpo?=
 =?utf-8?B?QjlLbU1kMDFRNzhIV2NuNEZ3QytBNjJsbWRzY0s4VFJ2S2daamQwUVdIUWs0?=
 =?utf-8?B?UVZLaTJ3UTNTVzBvRVNKT2g2NFEwdUpCZmw2Uzczak1XOWFPTStkYXNETFB0?=
 =?utf-8?Q?JZ12Dc2FpgUzLGzyGT8o0caB6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f699039d-f9ab-402e-a800-08dda4ee0745
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 11:33:58.8660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bqy0icuxlAk7Ol6TKx/dcF9+SaM1vJiIxTIlT4H7CT0s0kuhw61J8/l9Mt6tTV/a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
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

On 6/6/25 08:43, Alex Deucher wrote:
> It doesn't work reliably and we have soft recover and
> full adapter reset so drop this.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for this one and the same for gfx8 and gfx9.

I think you can start pushing the first patches to amd-staging-drm-next, makes it less stuff to send out again.

Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 71 ---------------------------
>  1 file changed, 71 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index da0534ff1271a..2aa323dab34e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -4884,76 +4884,6 @@ static void gfx_v7_0_emit_mem_sync_compute(struct amdgpu_ring *ring)
>  	amdgpu_ring_write(ring, 0x0000000A);	/* poll interval */
>  }
>  
> -static void gfx_v7_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
> -				  int mem_space, int opt, uint32_t addr0,
> -				  uint32_t addr1, uint32_t ref, uint32_t mask,
> -				  uint32_t inv)
> -{
> -	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
> -	amdgpu_ring_write(ring,
> -			  /* memory (1) or register (0) */
> -			  (WAIT_REG_MEM_MEM_SPACE(mem_space) |
> -			   WAIT_REG_MEM_OPERATION(opt) | /* wait */
> -			   WAIT_REG_MEM_FUNCTION(3) |  /* equal */
> -			   WAIT_REG_MEM_ENGINE(eng_sel)));
> -
> -	if (mem_space)
> -		BUG_ON(addr0 & 0x3); /* Dword align */
> -	amdgpu_ring_write(ring, addr0);
> -	amdgpu_ring_write(ring, addr1);
> -	amdgpu_ring_write(ring, ref);
> -	amdgpu_ring_write(ring, mask);
> -	amdgpu_ring_write(ring, inv); /* poll interval */
> -}
> -
> -static void gfx_v7_0_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
> -					uint32_t val, uint32_t mask)
> -{
> -	gfx_v7_0_wait_reg_mem(ring, 0, 0, 0, reg, 0, val, mask, 0x20);
> -}
> -
> -static int gfx_v7_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
> -{
> -	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
> -	struct amdgpu_ring *kiq_ring = &kiq->ring;
> -	unsigned long flags;
> -	u32 tmp;
> -	int r;
> -
> -	if (amdgpu_sriov_vf(adev))
> -		return -EINVAL;
> -
> -	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> -		return -EINVAL;
> -
> -	spin_lock_irqsave(&kiq->ring_lock, flags);
> -
> -	if (amdgpu_ring_alloc(kiq_ring, 5)) {
> -		spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -		return -ENOMEM;
> -	}
> -
> -	tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
> -	gfx_v7_0_ring_emit_wreg(kiq_ring, mmCP_VMID_RESET, tmp);
> -	amdgpu_ring_commit(kiq_ring);
> -
> -	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -
> -	r = amdgpu_ring_test_ring(kiq_ring);
> -	if (r)
> -		return r;
> -
> -	if (amdgpu_ring_alloc(ring, 7 + 12 + 5))
> -		return -ENOMEM;
> -	gfx_v7_0_ring_emit_fence_gfx(ring, ring->fence_drv.gpu_addr,
> -				     ring->fence_drv.sync_seq, AMDGPU_FENCE_FLAG_EXEC);
> -	gfx_v7_0_ring_emit_reg_wait(ring, mmCP_VMID_RESET, 0, 0xffff);
> -	gfx_v7_0_ring_emit_wreg(ring, mmCP_VMID_RESET, 0);
> -
> -	return amdgpu_ring_test_ring(ring);
> -}
> -
>  static const struct amd_ip_funcs gfx_v7_0_ip_funcs = {
>  	.name = "gfx_v7_0",
>  	.early_init = gfx_v7_0_early_init,
> @@ -5003,7 +4933,6 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_gfx = {
>  	.emit_wreg = gfx_v7_0_ring_emit_wreg,
>  	.soft_recovery = gfx_v7_0_ring_soft_recovery,
>  	.emit_mem_sync = gfx_v7_0_emit_mem_sync,
> -	.reset = gfx_v7_0_reset_kgq,
>  };
>  
>  static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_compute = {

