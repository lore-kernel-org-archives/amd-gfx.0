Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75180C3DA60
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 08:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29E0410E5ED;
	Thu, 18 Jul 2024 08:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DsVkoHwC";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C030310E5ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 08:46:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTaiRfhnxw3jsdvQYXNFXpoe502te0p+nbSQndsH4Hu/h4lxs4YOpDa2AjlYxIG+0dGAVahUNTOXbbWUcV8K/OYI5yGZ2A1NvwSSNGEzmTi1NmxSCSTskDfZaGUuBZXMsOPoaC8w02vMVWIRBMXVTal5GX9acbpdoOxjh+DJom3Flp/74q68gVmDfP5pG0bZa+sDWKhRh81XO0lbxojfNaqxWAUGyX0lxoLm5OIv/B5RpTz3v0O03FaH+sq+PBGPuZEXjaeWCZ5kBi4G83bpjxD1sBveATTPO1aJ94YllR9eG29Ilr0+TPUHFpbfZMGx8cmlQvkStgL/zaLcIkbKNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7zTMDlpVRNhj3xIRSt75Box5WSNzdNMbL+8EIIcW3s=;
 b=G6WxgOK6GNqkZozIT+tfEXjxDeUVQxRZm4U0EkemPAiPsf++kekxz/rMoQO+zCu+Pbv0ZuT+6Tj9OCj3U6dgemTjUv8al96sBskAJcnWxRWclW2i+MBFh7OQsL/I9zI2jmuML3BFG+rSN38l48Q7u1H2RdqoLmpOUL4+R1xP8e8IdZpWd75bBjXOxKlSAOnwVRZwWgDGU28mtrP98Y5xCa0OF3HakOx46/ftmNIf4moJrgRlzNRdaYPqD4oxKbo4GqBgiUuL+USS7rJAAgnu3aJ0Dfz/uzK8mFjzJpTmQOLNPH6Fg3P8k84TP6RUc3s/Fa1fz8gSv205EqJfIFRKGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7zTMDlpVRNhj3xIRSt75Box5WSNzdNMbL+8EIIcW3s=;
 b=DsVkoHwCgfBxoV6nJt5JzMcXX626LBBtslpeZjr9XB9vowz17Oofy5BxfUM5ttxXvqapw4MqGf3fITj5tGLcTIJlZ/iXSbNlrAZtky4h/G3THvp2X93UF7L85OWHNXUdV06GXGkqfhspVaapQIX9YWyZHYzUdzeP0rUkX7jq91Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 18 Jul
 2024 08:46:49 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381%5]) with mapi id 15.20.7784.017; Thu, 18 Jul 2024
 08:46:49 +0000
Message-ID: <ef66910e-aeab-49e2-b109-27a2ce2cba0f@amd.com>
Date: Thu, 18 Jul 2024 16:46:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add 'pstate_keepout' kdoc entry in
 'optc1_program_timing'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240718040344.1370693-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240718040344.1370693-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0186.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::14) To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|PH7PR12MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: 36bccafa-faf9-442f-a326-08dca70629dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VkpzWGJoK3MrM1BMcXA3V3RJODIyS1NoQ3RySTJZWStRcGcyRlhOdGgwMUpW?=
 =?utf-8?B?MldEMUREOXR5aGF5T1NPdXFmQWQxOWRPSFd0U3BLaEpFNDlEcmwvYjM3N0ZR?=
 =?utf-8?B?NHVEOUp1UnFROWFvR1FRVllXUWY4UEhlRko4VkFhZFRGS3llOTRvcGxjMGtq?=
 =?utf-8?B?ekxOMzNhdy94aGdQV0ZnaFpETWlKLzNtZWdRRGYxMDh5UmpjZUVvYjBuTkNN?=
 =?utf-8?B?VFc0SFE2MTNxL3pFdmsyOUJnN1ZtVFpBSzhLdmhlM2NSc2hoMTdyZXZxalpj?=
 =?utf-8?B?M21YUnZjaXIxbXBsTlhqOWdLY21TUFdSRG5PZGhrWngxZzFiQzN0ZS9jbVE3?=
 =?utf-8?B?WW9CQXlnN2pRNGtMa2N2aG50SzFCVVhuZHJVc1lBL3JjTUw3OXdDcXplcGhZ?=
 =?utf-8?B?aDR6dmNnaHhSbzBSSkh3aWJhblhIKzE1UTdKaWR1ZUtxUFRTMDV5czFrSEZu?=
 =?utf-8?B?RFM5Y1FCUXBTSURhZkpVYzF6S2NKcHpDYWJPKzkzeHoxMnVYTHBjQnFjQ082?=
 =?utf-8?B?RzFpVWFsM3ZwOW5ZQ3U5aXNYZ3R5Q0l4azVWMVp6bTh4aW5LR1lMZFluYy9p?=
 =?utf-8?B?MDBYOExMc25RcWFTdUQyaWNudGtYNkVpcTcyT3B5SVNnMWkrNEJuOFZWSFVT?=
 =?utf-8?B?a3lWZVgvYk1xbzlvZWs4TUs4elh3aW5GVzEyeXZaNEtNT08ra1kyTDVwQkM2?=
 =?utf-8?B?SStmb3FpZTJ1YzNwWjIzSnhTOWVhZ211djUyT0ZvaWhaNmJPS2pkaDZtMHF1?=
 =?utf-8?B?b0RnRXhUQXh0WDkxM0l3cDJ2dzhwNUR3aU8vcUE3UHlacGgwMkRpU3dROEVP?=
 =?utf-8?B?RG1TRVRpZEdZRS9SamNzc1lhLyszdFh4d0RwL1RCRG9IaVlscGRTUHRVcG5Q?=
 =?utf-8?B?RGRKaG9yRlVla3d3RVhSK0grd2o4RHJwT2ZlRDdRTVF6SXZvV3VhYUJqdWdy?=
 =?utf-8?B?U2NmaG9FbENNQUZEaVRvSjBCWC9uOVRPdjVMelgxeWtib2lId1c4TGNCaWRp?=
 =?utf-8?B?ME1kYXBiSE9BODQ4YklISERYTGRPREFMUDE3MXZaeDA3WFo1ZVRGTE9GcUlU?=
 =?utf-8?B?YnNDODBXL3kxRU1QejQwSnQ5VWZoam01UGZPbUc2T2k5UTEzczA4NkxKb3dW?=
 =?utf-8?B?RFpVZTcrajc4aTVtRmh5ZUJxNEdjd0xteTRHN3BLeWQzWHd0ZStNYVM3bVlM?=
 =?utf-8?B?SEpUZUxjMk5FdHQ0VGtOQWQyckd1dzg3Vk5MSnVnTG5OMDUzMXE4SGxBS3lm?=
 =?utf-8?B?bWdROVlkVDVhTkQ5Q3BCcCt4WUQ5RVFSM2JGQ2ZQNjVjMndqeTRhWUt1azV2?=
 =?utf-8?B?K3dlQnp4cTEyVHcrM2R6aDNvd0hDMFN2RTZKTm44K1RvQ1A0Tk81aWxLQk8v?=
 =?utf-8?B?MkJkVHZDSzVqckRwbEYrcUxrT2hNbzlUZDJQNFBQOE9BT1U4L2V6dUFXWC96?=
 =?utf-8?B?OWV6QjZ0aHl5dUFOejZpMTkwZDZqZCtIRlkrZzI1U3JKZDNrbXZYc3lBVE10?=
 =?utf-8?B?Uitvak1iV3hXTTBuWkhaYndSZkhldC9Uc3BKUE1GVnBod3JBVkJrSDhiVC9J?=
 =?utf-8?B?UG1RdkpEK0FOZm1TREN0N2dHdytmWXpBRS9xMm9xbjMxOEZaK1NieW9LOUlz?=
 =?utf-8?B?dWlpN3dwbXQ3TitKckp5VFJsYlBKNS9adXZaaDl1U25Cc1J6eTB3L2Z1TW9G?=
 =?utf-8?B?Q29vUm5FaFJHeG41VkthMTd4ZVdjeVdERzVhUWsvaGdOQ29DTXNSQUp0VnZp?=
 =?utf-8?B?cTZCeGNDTW9FWG4rcVNxU1JudXEzMUpqOGx5OThKZkVGNHRoY3g4OUl5REpQ?=
 =?utf-8?B?WXFHekpsNzdzb1BydEM5QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnA3T3l6WUdPbTJxMGlFRVhWd1NWRnRRRzE5NGd4TzRUTGdOQWdHa09UNkZL?=
 =?utf-8?B?SWJyakQxYmUySnlOdGpGVkN4Uk8vajdTSTFNZlp0UWNEOVZpd1lrOXRTNVAz?=
 =?utf-8?B?QVJkVW5mc1FsRExkVVdVTm55d0pmZlhwZVlWTUI3c3J5V1dxb1pnVlVjSjJK?=
 =?utf-8?B?ZlZ1NCtuUFJzSjlzTElrVE9UQlVHQTZWMjFYU1J3NC9sNkQ4dnlJUFNWREF6?=
 =?utf-8?B?a2d1bC9mczcvOGNIdnNKRXZSNkNWQlprdmlueFhldGJPQXkrSHNIM25ITFZp?=
 =?utf-8?B?MHRCR2cwOTFYOFVNenA0dzUvRUdVQnlSUGQ1SEhrTXIxUlFtMmFiVWtKakVn?=
 =?utf-8?B?SjF2V3BEb3orYk84K0dPS2gwaUM5VzExdkJEdnQyL3FvV3JaTGhjSDA4UFJh?=
 =?utf-8?B?T2V5WVpqelgyREcyNkxxc09QK0FIZEVuVVQzaVZ4L0Zoc2RDZGIxUHUvTWpZ?=
 =?utf-8?B?WWxlUnV2M0x1RWQwaTIvUk4xcTBtMnlMYlJnS0JmYTNDZ3htVWQ3RDlDTTlC?=
 =?utf-8?B?ejlvZWJzNnB5Yko5VmpweXg2ejNFMHdESTJvTmY3UXVEY1UrQjQrV0JscUM0?=
 =?utf-8?B?R0UwaWxYSkplRGplRmdDS1V1bmh3a3NLbVZTa1dxSHpicGpSck5qeHVBQVh6?=
 =?utf-8?B?SDJyV21DaGE3UUNHcTJYMnV2QkZ1LzNkalY4N2NIVytlL0R5NmpuV1NvdC85?=
 =?utf-8?B?bTZKNnI2OGVOMzdGQjNKRDd4N0puR0dkTk1weG5nZEJMdG42aWNnNTlmNWRn?=
 =?utf-8?B?cXpTM21ySkxvZnRQUVFhOWZXbVlYWHdnMkZoUEl2c254Ukx2ZU0zN1Erc2pI?=
 =?utf-8?B?NWNxRW1lQ3Nma1FCUTJDVEFISEtaejRUdDJNY2pPUUtON0ZmRmFlcXNwTVVC?=
 =?utf-8?B?VTJXNEQyRFBVdjJXcnJyc1NuM0ZwWERTaVJwaWVRQmU5TWFwY3VVQ2tBcGJj?=
 =?utf-8?B?QUpuOVl3bzVvWlhqNkp6d24xbmZVQlNubkMrU3NldWFLOXllVGh5TC9qMEQ1?=
 =?utf-8?B?c1VWb2NWYTlPbFFhNTBld0FTdEw4T2lrL29OY09qQllyMUhZSnFrZWpCeGJP?=
 =?utf-8?B?RHRuZ1NTRFRCSk5JTFI1eUtPRENnaUNHR0JGcXl5cjFFcDJIdEkxclpMWG5y?=
 =?utf-8?B?M0F6dmgzWEw4WlpSaFBJRE1mNi9BeUFqZEM5ZXQ5VnoxK2VMbjNvSjMrNEJH?=
 =?utf-8?B?VUs4dVZUT2NUV05zTDdmOHEwSHU2anc5dUpGelJMazJOcUtTbkJ6SXJCQTdj?=
 =?utf-8?B?QjZBN1h1Z0pqRVp2dDNTWkk0U1duZThnc2lIUU5KRE1MaEIwYTFrbEtlRnVZ?=
 =?utf-8?B?TWJsRS9vb1NyY0E3K3VMY1FUa0JEa0t6a0FxbzY4MkZ4TnpBakNSQ3IzNmdY?=
 =?utf-8?B?MklHSDhQY3NBTmNFWXUwcFo5d09zd2Q5dkxYYTRVaFhWN1dCS1ZTQkpibGpG?=
 =?utf-8?B?ZFo5V1dMNmFsR3JpWXNXaklVdXVqeVhRVDdGWjU5QU14M1F0OTNQNFg2c0lZ?=
 =?utf-8?B?TFlJN1J3R1NBQnZBdDBibzJXSlJjRmZhMS9mRXIrMjUrODB6YjA2VlJWSEVK?=
 =?utf-8?B?SDExS0F3OWdIeTQ0K0Z4cFJ5MnRPVzI1RVgyN21TYnMra2ZqcWJtRXhvYzh4?=
 =?utf-8?B?ZVlZQUlYa0Z3VjdpNzA3Z1VobnJPK0dkck9DRlU3YU92b2NmVGxrNExEWlBw?=
 =?utf-8?B?QWRiQ3hjcGtrODE2dmNUdmtvdHFuMDJoSDNLZ3ZBVTMwUjc0a0EzeEpRLy9y?=
 =?utf-8?B?ZTBLTzV6dU9DN1RqOUREa1ZlOWhDRldYOVhQQlFQVS9aWFhaS1cxd0J4TVNl?=
 =?utf-8?B?V1k0ZDlYRXd3VENwYkYrSFY1ZFYzVWR5TjFtRmRQajlPQlZucCtpU2dWbS9U?=
 =?utf-8?B?WXdRU0Y5ZWI5RHBQVnVWRk1jY2tkenBQM0dFaENGREFPb2toV09pMS8wRUxm?=
 =?utf-8?B?SkFlMDJ0OWgyT2w1N2x3S3BtTWd5QWNXNjRaTjFjUFVQOGdpZWJoOWVlUmdV?=
 =?utf-8?B?eUV0N2EyYUlxQ3lTVXh2VnMxS2IrZjZjNjVhVGlxRWplSzJod0NIUEtpbXdS?=
 =?utf-8?B?T0ZaRmNHbnRkVWk3UUtWUG1UN094V3BsR0Nyb1UxSlBjaEFIcndlZ1FEb3hV?=
 =?utf-8?Q?KxYtFp3xSIqNbnVWuUdZpygS2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36bccafa-faf9-442f-a326-08dca70629dd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 08:46:49.6441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEQuCuFEAC6mySmNDk8sI1VONORPkIlgWm8jhh30dfx9zElg3JS20GXjpfYptfIJTyiXDF/ycNHZ992XQZ8xRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594
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

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

On 7/18/2024 12:03 PM, Srinivasan Shanmugam wrote:
> Fixes the below with gcc W=1:
> Function parameter or struct member 'pstate_keepout' not described in 'optc1_program_timing'
>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
> index f00d27b7c6fe..097d06023e64 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
> @@ -148,6 +148,7 @@ void optc1_setup_vertical_interrupt2(
>    * @vstartup_start: Vstartup period.
>    * @vupdate_offset: Vupdate starting position.
>    * @vupdate_width: Vupdate duration.
> + * @pstate_keepout: determines low power mode timing during refresh
>    * @signal: DC signal types.
>    * @use_vbios: to program timings from BIOS command table.
>    *
