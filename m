Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC34CA0EEB
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 15:39:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3365A10E360;
	Thu, 21 Aug 2025 15:39:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5O1ZeYgb";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 491A010E360
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 15:38:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXIHshs4JB2I0QrgwHgKp7aWz0IidRRjORW4Y3YtyYiC1bszPr+oLqKOVOcfFCcMclnAqjwqoupK7cZIwJXGrLaL9QC2k6TdArlI0usdK/WMcWzqM20mouZtJUWCipmR6RnKDNwJWDae5LMnNsgLJjKmPbKQGsmqliILj+9VywlnnkYKrA75OYWydxpBmIQAdSD/VJjD5AB/cz/BXvlllNBkyNP1GQoARliWhoJuslOaeBi7DHXSMXG5zSh78VbxuYNlnA+XgPUW+Ro7aPTI0HrUzNjzhXh1Vey2NN/0WSnndIF7J/sK2HCxGYzx3uKSdGSPOVRjOTQY9dXSR8vRtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qWUpvjtcMfOnYlE9AYJg9Wp6JX4aHQF80ANWcySXPk=;
 b=U+6W7WhY6KtXFhxmh9jkWhcv4MTDgObeukq1tMBveqC/QY3oke9W0ZISqGxtYnAg4LcCAVNHpWasxbypFgMkX+il6jVdTMQ6HEIe8VTxZcBlXhrdPxoRd0ERmmpXhyrx+0eQ0rwkHwk9SGFFm1tUZhJ8/dvZdK8mNAWayOMaN08jg38NckFbhoQ30zkuSSZEPPSz5rKG5YP9s73xj3kIQbpgw5ZcvQuzvh7MDx0mATA4uQ+y/7IX4wP8l9hjkdPBOKS+VMwIpFMtHriiFnQfOT0lptSt2JoKE++Gi9YWp/3E2A+9geADJ9ReR71SSQSxx5hlWB/zv6ngHYw2enkMfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qWUpvjtcMfOnYlE9AYJg9Wp6JX4aHQF80ANWcySXPk=;
 b=5O1ZeYgbHaN1/vCMmWXD/arThnXD/99EP8K9Vsp61I2pk1xZ3ZHmWQ09I6vVeC1M4JAltoWASvIluoxvJ6WqdzHXePG6bVOOHgvbMeXNJpvsVUkwMtYEQK6yvY9R3m+tHj7vUNxKo3IUh0n0dfRkYxGSUzut1x1rMoeQSddin90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB8742.namprd12.prod.outlook.com (2603:10b6:806:373::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.17; Thu, 21 Aug 2025 15:38:55 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.9031.018; Thu, 21 Aug 2025
 15:38:55 +0000
Message-ID: <3a855984-2140-4c6e-928f-80c69dc59aeb@amd.com>
Date: Thu, 21 Aug 2025 21:08:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 2/5] drm/amdgpu: Add ring reset support for VCN v5.0.1
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 leo.liu@amd.com, sonny.jiang@amd.com, Ruili Ji <ruiliji2@amd.com>
References: <20250820030400.514460-1-Jesse.Zhang@amd.com>
 <20250820030400.514460-2-Jesse.Zhang@amd.com>
Content-Language: en-US
From: Lijo Lazar <lijo.lazar@amd.com>
In-Reply-To: <20250820030400.514460-2-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::19) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA1PR12MB8742:EE_
X-MS-Office365-Filtering-Correlation-Id: f75b6e32-ea4d-4f4f-28a6-08dde0c8d674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXNVa0lXVTdFeU1uYk5sZFZpYjd3bFJDb0dEQzdmdmJRaUxvcjIxUS9WUmI1?=
 =?utf-8?B?STBOdFcvUm5ESmRHZDJHOTNEZ3VwZWpPNEFsYWlocm9sd0ZNZnBRQnAxUGk5?=
 =?utf-8?B?RVQ4S0VEQ0NIb1gwaDVPemFUVFl3SmRSR3ZWSDB2NWFTbjRvcExYeTBnS3RR?=
 =?utf-8?B?VmZzQUZ3bFV1dUpvNFZLYzhDSWdUL3ZPcXRmNEhuSnhCUmVQbzdYQWRONTA4?=
 =?utf-8?B?NVJGSk1DYnBpd2MyWVdnenhuSlhySzFDNDV6dGZ0N2VKclNOMXRvSHZ4NDNQ?=
 =?utf-8?B?ZW1ES1cwdjFaK1hjUHgyczZLa0pBYVQ2a3FuVXVaNWhNZzRHQ0hhTVUrTEN6?=
 =?utf-8?B?RkQwRVpiMGdOcThzWmpsMDNCVGx3TGZqUkYvM3Rjcm1JdFFDRDRhVEFWcWs1?=
 =?utf-8?B?NlViMmhFUEpBandlMFlmZEpJRzNsZTFRMFVJWTlyZjlMak9SUEExSmhGaWxx?=
 =?utf-8?B?dkcrQkdxRTBnK3dZamZLMFpxKzUwSmhUOHNrbWR1RHIremQwSGlPcEZtdEh0?=
 =?utf-8?B?cXh0YzJpR2s4clF2RmF2U3pIWmdLNGw5azlIcDdlWm5Vd1dmbmwvK2FvZS9i?=
 =?utf-8?B?ekZZQXkzZ3dGUWtKaGMveWEzZk1YdjRhT0NFbFRWR3dVTjhoSWZiTWJaZE1y?=
 =?utf-8?B?aEcxdGtaeitwQmFhc3RkcHVoN2VYbnhrbkxhNU1ybDdXUWg0T2xxejdkT3ZL?=
 =?utf-8?B?K2UxbFhPNDhpVFUvMml5SUR2YVE2dE5rYWlWdjQ5aGp1aW50cUl1eUJ1cHJG?=
 =?utf-8?B?NjJyYXF5d05JR2lVSlVTY2w1MHFlcjhMaHJPRkt3VCs1SlNxY0lBU3ZodDdT?=
 =?utf-8?B?UmVEUGFZVnRZN3VaMWVYWFE1VVE4UXp0MVBnRE01ZmQzLytTcnYyUkhNUWwz?=
 =?utf-8?B?NEpwVllZeCtKRGdzUk8rQ3RYejdiVFlDVWFjaU83Z3FjT0dHWUxpRnJUZ1dG?=
 =?utf-8?B?endGSE9KeHRGT2dlVWxNMjhBeWVxMWFITUJoeGVMYW1TbHFwVC96YlAwMk00?=
 =?utf-8?B?UDYydCs0d2Nma2JtMFVCeXJXbzJna29DQXRZOTluYW90MjU3UmxCY1l2aklJ?=
 =?utf-8?B?V2k1dDJCcmlsU0Z3UDhFd3pXNS96OEdVeWtOMU5nVElCV0ZudWlKcGl6TTh5?=
 =?utf-8?B?Nit4SHRQclR1ZVdGL056WUltKzdjMHY2aDlPRlo0NUdkMGp4MjlWMWRvMU9V?=
 =?utf-8?B?RkF3LzNhMGJxZXpZcDNGaVpvSVRUZVY1Y0FoQ0ZGb2tCMTBvZmxObVFWczlU?=
 =?utf-8?B?Q2p3dkJkTXV1aVZFRFU4Q2lxL3RjWm5qWXhKZjZPSnh2RW53TDFHY1lVSUNh?=
 =?utf-8?B?QkdwV0k2c290TmhBeEhjT1Zib3J1L2FFY3NsYzJtV1J2cUtIdkZhdkJPRkJu?=
 =?utf-8?B?TWl3bmFxNmtFRFdQV3VGQ1dzL3YyTTI5NjFtV2JOZGVYbTN3UFNxVi9xWEpl?=
 =?utf-8?B?Q1hJTHZqK3JBMzJDKy9QVVA1cHV3Sm5VcWgwMlJUQ2U4TlFreXI3akhlTTNi?=
 =?utf-8?B?cTBRSTducmgzSjRFbWJnQldWWU02aUNJK2dkeUpsMVJtR2JwYnIvTnFiRFNM?=
 =?utf-8?B?TUFLRG1hQUZKMlNsNHJUcUdCekxENUI5Q1pEVnRFaC9Pams3bWFEV2RLT2lk?=
 =?utf-8?B?dWVCM3UvV2R3MytPZFdEeEgwQUlvUHR2ZmxKQzVmdWpnY0haNndjUStsSzNk?=
 =?utf-8?B?OXRZd2xISnAwSm81K3IreWRhRy9KL1BSUWdPUUxkUHQ3RWgzRTM3OWN3Q2g0?=
 =?utf-8?B?dDFvNlVtQ01JWmxKVDg4L25tZEJ0VGRoL0ZmaFhJUGNiL1hGYVhNYmFERzU4?=
 =?utf-8?B?QmNwNFBmS2wxTDZqbVVwK1VZVDhIZFpxbC9zNjFpa3kwVkZBbk03WXNRM2VR?=
 =?utf-8?B?SkkzemFHT1VIOUZOd2NDM0JRZDQyUTBCV1l6NlZ0MDQ2aGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzJmUkI2SCtVS0JKVDVjdUZQZGlSMjZ5ZnVqaGszbm5Fd2lSa3FzdDNjc2kw?=
 =?utf-8?B?SkV2K2NudEVCencxaUNtdUVaTFJZVWRGSHdaTk5iNDlDZHh3Y3NVTk5udnVY?=
 =?utf-8?B?SU04T25uQ0srZ3p6ZDk4ZWRlN3BDU01SaDhtTkpLUUplRUlTeHRNeFRxNW1L?=
 =?utf-8?B?SGQ5czhzalVJVDM0eVJOZU5uOG5xUHJvZVg4bWc1cXJNQk93ODE4OTljWG0w?=
 =?utf-8?B?OUM5QlY0dUVOTE5ZalA5NU1SU1lkZDMzUWZOZ2gvekxaVHhSclQ5UlM5SW5q?=
 =?utf-8?B?RG44am1zWnRSOVBhM3phUTd3Ny9xQ1F4QUZ2TlZQYWU0ckUyV0xpUCt2WVQ0?=
 =?utf-8?B?d2kweVRVTEwyTUpaZkpoV0NDMDZZaWoyaXhSZXZYVTI3Y3piOVk0NE5QTndh?=
 =?utf-8?B?VDhlM3BCclNWZnBySTdvREdhclZxdU1JcXI1cGQrcGRtUjBvdGhrbVl6WnFB?=
 =?utf-8?B?VElVQjNXdXZpSFlMZkxBbk1VL04vb0tzb2JWTVRJZlRrT3NPWkVRQTRUNkdY?=
 =?utf-8?B?L1krZTQwM1hnK2FtYkEydnpwYWlnL250a285Y1loTEMvaG5rWU9mWkcvM29M?=
 =?utf-8?B?ZDlKZlJldXRzN1ArMitHcU05U1oveCsyc0NXUDhoL3kra2VtWUNrUWl0ZnZt?=
 =?utf-8?B?V2daaFRqa1oxeG4raXQrbW0zdnliL0o2bDl2VTZ4V0dHMDdlV0hnQ3RKUzBI?=
 =?utf-8?B?Z0ZOc3NzRloxODI1UUZmb2lmQld0ZHZCdDk0NVFKd0xHMHI0bnRWclBoVmJa?=
 =?utf-8?B?ckRkaHJhV04vd1FSYjJNT3IrUUhGTzRtVitUUEpTK00vVlJiRy8xY2tEaVF1?=
 =?utf-8?B?eVQ4Q2x2dmxMUDhIanZsTVgxd2l2bmZiUFArZmlMcEg4MUdrbW1hc3JVM0M3?=
 =?utf-8?B?dkd6SWxSMWVrRzduWXJzM2xOVjhCZ0NuT1ZnMEk4dTllVXZTc2dNZXFJcWxU?=
 =?utf-8?B?OWxpUXpCcTV2Nm5ZUWgxU01RaFdYKzM3MzZuOVRHcGhLMnNTT2RyMTNuaEhj?=
 =?utf-8?B?ZDg3dkVJZmRzMWlDNzBhREl2Y0FSOHZDekdHa2czU2FlQWtwS285V1NhVkkr?=
 =?utf-8?B?eDVmdXJhNHlxL210aVlxejhXM0g3VjBzWkZDbnlvdkNBWFRkOFNtclNLMmQ4?=
 =?utf-8?B?N0pENGRDYkRoZmlMVmJtZWtSa3lVV1V3WXoxcFRoTk12aDZrY3djNUZ3TFEz?=
 =?utf-8?B?eFYyL0hHVUtqdDllWlZwRHlwU1IydldnWFhaUWkzTTBvbEw1S1BZeWR0Z3dk?=
 =?utf-8?B?anJFalBmZVU0VURHdE9ncUM5d2oyOXdqWlZhV0hHcDZjNEJacW5QNHZONURD?=
 =?utf-8?B?UGlVQmx6NGdJcXlsQ1ZnWGtYSUVwVlNkRzcyTnhNeEc3ZlljNTUyU1RPcHZx?=
 =?utf-8?B?Z2xLQW5iOFNpN0twb0c0NkxuMWhiUFZINThiYnBraUxHQTVFaHVUaWszV2FD?=
 =?utf-8?B?Ukd0bXFCSnR2bVl6UGd6SnJscUl6Ymc1UmN0eVBJd0R6MWFTNE9HMzFzK213?=
 =?utf-8?B?SXVpcVdSSHMrdE1rdUVwZGpzLzFDYm1EMUtPL2FGOFllNmJVT0ZnQkE5OHVI?=
 =?utf-8?B?Lzd6cGJQTnhiNE9GZHo0TGlWaHFONUVqa0NKS3Y2M3I3Yzk4VmxYaWRDcUs2?=
 =?utf-8?B?RXVYdTIraU81ZTk2NmZxUDFEVExPc3FhenVCYXQzNUFEUnE3UVpYUFRUTGRS?=
 =?utf-8?B?dHIvTWdJZ1hIaS96L1JydHEvemV5UlphOXNpN0RPeXVtbUJWMms3UkQ5Y3Bl?=
 =?utf-8?B?SVFGUEdNTm1Rb0REMzliSGtoQTFMNmlRVmt0eHk4a1hxMTJzekZaeUd4aVVZ?=
 =?utf-8?B?cVJ0WnZLRTNVSVc4U3AzRnIxWEo1UTJpSlRHRm12TzFDazdiYVNuRTlDUlRR?=
 =?utf-8?B?ZnJBSzcrSkpiOXcxQ25pZDdzWkhqZzN2L1JEUGliMWY5UEg2bDREemlycVJw?=
 =?utf-8?B?bThtNFd5ckV1aEd3WWRHL05MWFFSM3lCWDlac3Nrb0lpK3pyY0Z2ekZyZ3lF?=
 =?utf-8?B?MCtLTHFacEk0TXYvYnlzcTF0bGxua3RCRkZaRVZkWE9jdmNnaUpYOUNLMlJt?=
 =?utf-8?B?TTNra1ZBRGdFaW9vLy9Xb3VoWkJjQWQ4eEkrRk1ha0lYd2x3Um9qMXVpVVNR?=
 =?utf-8?Q?BJiXnSnZjnIbQuLwQXt+AMXAr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f75b6e32-ea4d-4f4f-28a6-08dde0c8d674
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:38:55.4029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BHSfbKcYHKigp96B/6BBaTUEtFsPMhs3SwOh0ZeQ1/Q5fOBskcqtR7UDE7kq/zzK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8742
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



On 8/20/2025 8:33 AM, Jesse.Zhang wrote:
> Implement the ring reset callback for VCN v5.0.1 to properly handle
> hardware recovery when encountering GPU hangs. The new functionality:
> 
> 1. Adds vcn_v5_0_1_ring_reset() function that:
>    - Prepares for reset using amdgpu_ring_reset_helper_begin()
>    - Performs VCN instance reset via amdgpu_dpm_reset_vcn()
>    - Re-initializes hardware through vcn_v5_0_1_hw_init_inst()
>    - Restarts DPG mode with vcn_v5_0_1_start_dpg_mode()
>    - Completes reset with amdgpu_ring_reset_helper_end()
> 
> 2. Hooks the reset function into the unified ring functions via:
>    - Adding .reset = vcn_v5_0_1_ring_reset to vcn_v5_0_1_unified_ring_vm_funcs
> 
> 3. Maintains existing behavior for SR-IOV VF cases by checking RRMT status
> 
> This provides proper hardware recovery capabilities for VCN 5.0.1 IP block
> during fault conditions, matching functionality available in other VCN versions.
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Signed-off-by: Ruili Ji <ruiliji2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 29 +++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index 1b5d44fa2b57..779043eac827 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -1284,6 +1284,34 @@ static void vcn_v5_0_1_unified_ring_set_wptr(struct amdgpu_ring *ring)
>  	}
>  }
>  
> +static int vcn_v5_0_1_ring_reset(struct amdgpu_ring *ring,
> +				 unsigned int vmid,
> +				 struct amdgpu_fence *timedout_fence)
> +{
> +	int r = 0;
> +	int vcn_inst;
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
> +
> +	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> +
> +	vcn_inst = GET_INST(VCN, ring->me);
> +	r = amdgpu_dpm_reset_vcn(adev, 1 << vcn_inst);
> +
> +	if (r) {
> +		DRM_DEV_ERROR(adev->dev, "VCN reset fail : %d\n", r);
> +		return r;
> +	}
> +
> +	/* This flag is not set for VF, assumed to be disabled always */
> +	if (RREG32_SOC15(VCN, GET_INST(VCN, 0), regVCN_RRMT_CNTL) & 0x100)
> +		adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);

This is not required. The assumption is settings is common across all
instances, hence only the first instance's setting is taken. So if vcn
instance 2 or 3 is reset, this doesn't matter.

> +	vcn_v5_0_1_hw_init_inst(adev, ring->me);
> +	vcn_v5_0_1_start_dpg_mode(vinst, adev->vcn.inst[ring->me].indirect_sram);

You could use vinst->indirect_sram. That said, it seems there is no need
to pass this as an extra parameter.

Thanks,
Lijo
> +
> +	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> +}
> +
>  static const struct amdgpu_ring_funcs vcn_v5_0_1_unified_ring_vm_funcs = {
>  	.type = AMDGPU_RING_TYPE_VCN_ENC,
>  	.align_mask = 0x3f,
> @@ -1312,6 +1340,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_1_unified_ring_vm_funcs = {
>  	.emit_wreg = vcn_v4_0_3_enc_ring_emit_wreg,
>  	.emit_reg_wait = vcn_v4_0_3_enc_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
> +	.reset = vcn_v5_0_1_ring_reset,
>  };
>  
>  /**

