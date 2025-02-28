Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050AEC19776
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 04:54:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D64210EBFA;
	Fri, 28 Feb 2025 04:54:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uU6RROk1";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89DB210EBFA
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 04:54:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OD8HrpDy06So27LdUrQbHahziMIiHVjwLhg3PyMh1ZxgnAiERkZ5b0bf4H6PvLXjSwhsz6ySFLHqkMYgUoQx0u26Jo3Sgl2g49lpAhJbrCfDdPTRJ6QLMxDlszg0xhTC8K+480Cm+hDWzGZGO0Q7YYEleXxqNjxM7RIdPF4jbro89Fmk5lXBPdU++QB84V2bNrKIZAsBBMG5FvA7aFhUkCNVLeM75Mx2CNnvYSvOJaHWoXUBFFMvfoFtOmyxHcGikzFMNGjGY5IOcB6FC0Z4sFV6CKtkOzy6wvCSBDzKx0YqfHmdV6hAYIM5EIBnq+HuTCC9jf5bIghKVzRnp0AfAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOcAWJRyT/dfL+aHz3FN0yjMcqx5zaePLYwZM6hjuMg=;
 b=OcKOIk9oCbQvPJD0JHvChkZjTWMQUJSZ0VRfJ4BJqv7pfSTybfBXDld9Wdixd27nuTWRlncGknSMr48bsMfnZtTnicmqrQ3u4j3y2nOP7ffK+vtblOoRdLNr4zdVfi+0hFQKu58h6G1p5HGgW6cyarRS3L+TqKqC/aH/YtNh1Ekr455itbNJV5uQPV4YvX4gmTGJY7Du7aCCylO2epxhmKDH0l/rcg5jhorfjZhAVaK9V3skCvdLmyF7LQroFI1c/CfpigoiQarACmWUYNoQoJ7HpmpFCG2Bf8vRp4wPvF7crJd21qVPabwa2BFDxAp1OGTMXjy4PQrmTxkuzNRI3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOcAWJRyT/dfL+aHz3FN0yjMcqx5zaePLYwZM6hjuMg=;
 b=uU6RROk1I3/4BOx72jnJsUo5c7jqiZFJTbnNKezjyYlGIB4T+BW4M4T1ygsNV9BYDtFqD10eyo0gyXInXdev17M6qwGBTw+1JPNM9nTk5b86SH5hgQvAYI2N+IABP0R7za5PQUzSuT/prGp4A1GUWESyhPLbBty6wCYyWT+Elv8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 LV2PR12MB5989.namprd12.prod.outlook.com (2603:10b6:408:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 04:53:56 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 04:53:56 +0000
Message-ID: <b4215fcd-ea18-481c-8de0-6825bea2f8f3@amd.com>
Date: Fri, 28 Feb 2025 10:23:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Use the right struct for VCN v5.0.1
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, leo.liu@amd.com,
 sonny.jiang@amd.com
References: <20250226073132.142539-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20250226073132.142539-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::8) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|LV2PR12MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf6e764-4050-47fa-90c1-08dd57b3e839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVh4MjRPUUh1SWVPRmk1ak9nWWVyWXBXSTNoRG9zb284bFdKdXhuQS9PSENm?=
 =?utf-8?B?VVNESHZyenBrNDIzK2o2WlZVZnJuSERiRnJqRUsyMTBBelRldkU2dllJeFZ6?=
 =?utf-8?B?TE1RYjBIQzFrWmNjZjd2UHkrRUhvbGcrdjFlTGNJbGxtOTd3ZWlaWlY2cUox?=
 =?utf-8?B?MVhndlEzVUZ4dWlyZERhMGhhNVhPSTJWS3pMbXBrWnN6eDhFdUxpSkMzWUV0?=
 =?utf-8?B?cnpVZHNjNHlCN3J1NlFCVlQ3czJEQWpmdlBub3B4RzFxSSszdkVwQW04OHRk?=
 =?utf-8?B?aXUxcUtNdjZ4VTEvSUtZNHFEcXV5a2dlbHBFT210ejdaZFIraFV3Y3FNaUVR?=
 =?utf-8?B?cE5MM2ozYjhjREYwOGhPNlRXSzhzV2Fuei84dTBwOFFpd1hYS0tvdk41ZStY?=
 =?utf-8?B?cEVNRlIyKzc3SzVFdGY5YWhnVUxwVE00UndjWnRKdElYcDdSQ0dnL1BwclZt?=
 =?utf-8?B?TWY5MmFjRHZKSkRtMk1WT3JDb0pVWDVsczE5NkdRaHRXbXFwZUJwSWxMZzZh?=
 =?utf-8?B?TVdCM0F4b1dDWmRaZEVNenFld1phTEE0T3NxK1Y1Rm91Q0FGUm5Cd1lEajh4?=
 =?utf-8?B?bnVLeHdMZ3BpLzdOMkdaTTBaeHhUN3ljMHMyYTNkZ2UrcUNaT1JISXo3UEZY?=
 =?utf-8?B?Q0lvdUc1UHlmdHBPaG04eTZQWHRsWVVzVmNSbHZGeGc0YXJvbjJCczFxeEN5?=
 =?utf-8?B?aE9ZSmtXcjhDZ1JnWWVpclg2L3V5NGd1cXFxQyt4b2VJNXZnQ0ZkcWZ0KzIy?=
 =?utf-8?B?VTM1T0t4NkJkY3ptaGtzMHc5R2dXYWNrc0huaHVTd0haS2xsanBnMnZqaVAv?=
 =?utf-8?B?TnY5WE5mZEE2TFF4cW9BU04zbHVCeHRGbyt2eWNRNmp2ZHNXM3I4c2RKZWF4?=
 =?utf-8?B?UGlUNlByMlo5bzBucjc3MFBUZ2JFVWpERzVIcDBOMVhQVkRzZUZKOU1GbTZu?=
 =?utf-8?B?MWwyT1grSTRDUWd5V3gzVll5cXkwMkovRllCQkZZQUJOMjBrUUtOM0tLL05Q?=
 =?utf-8?B?RzhSODZnZ0lNRE9nbG1ZdGVPalE4WVdhTkJnM0EvQzRkUU9HRFlnUEtRVGw3?=
 =?utf-8?B?b3U2ckRUMEZqaGZuNlh5U2I0WEEwYTllYytsR2hoVFo0SmNFYkFmT2pqSW9H?=
 =?utf-8?B?a0ZFOXBGaENnWEo4ZVVQeUZLNnBBRG5JMEtLc1NkOU9DeWl0U2RMaW1vdHJl?=
 =?utf-8?B?NThLdUQrTFFGZy9Lbmh3Z250RHE4bkNBbkozMDNkMmcrcFZKNlF1WHNZSklj?=
 =?utf-8?B?aG1NbDRBSGxYaTBYb0lvYlVSTmg5SitXeFRzZmhTMHlycXRKdXFPZU13S2Zj?=
 =?utf-8?B?R0VLTEVUaDZHdmFMWGkzS3JVYTY4Z21TSklubWVxY1hGR1RmdnQ0SFRROUdK?=
 =?utf-8?B?K3pzN2xXK0lacXg2YnlnVm1yL0NVbUxPSDQ2NndwbUpRZEZGVUtBWDZPWVNq?=
 =?utf-8?B?WW80dGFqOWFYa2FLREMySithVGlmYXRIVW9SZUhFLzRnV21uV21ScHlwazRO?=
 =?utf-8?B?dk9mejFjR0hjY3J1cHl5aVlnSkpPUDkzSWcxR3RhYUczRzhuTU5ac21INGlX?=
 =?utf-8?B?dDJuVWduT2RaajM1WnFKVlVlN3pCVHhaVEJEY2VzMnZjWXk5TlpPVHJLbTJs?=
 =?utf-8?B?VUU3TW83Uy9HMFpRZjRrYVMrdGZUQllIQXY2MmtMTjRBMHRLbnRWTnRCN0tR?=
 =?utf-8?B?N0VXNDZFQjExYTM0T2MwUVJ1Mk5QZ3BkZ1VyaTRwZHMyMUZKeDRRM1RVY1RZ?=
 =?utf-8?B?TjdHbHJvUldFbFArT3NWVkQxdVEyTFVwdlpRKzdUNis0aGZGejA4MVJsbC9D?=
 =?utf-8?B?eXlMREowNE9HMlNlTE4yTXVOWVY4UWIySEVQMUVGaEY1cGwvcEVGUEU1M3Yy?=
 =?utf-8?Q?qLzFXTULVkjJD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWdKR0R4Mi8vanpOeCs4THNoNzdTMW1weGhzQzNid1dqcG9zQi84dE54bUp3?=
 =?utf-8?B?SjNBSks4ZGdnVDNENS9ldTZuRzJZVXB6aEFET3M3cDArTUwrVHJnVWpMR0VX?=
 =?utf-8?B?VWZCT0d1Qm1iWWEvbXA3akpySVZOdnhUY3ZQa2hrS2NPZElIZ3RhQ1JLUkh2?=
 =?utf-8?B?RFlaVXZiUEFGU0FNL1l1SVdiQ01IcVNZZEFYYTkrTDNhU2FITVdvZnBBNWh2?=
 =?utf-8?B?Q2M2Y2VCdjNGR2xYRFJSY1lwNER6LzZ3U0wxcFVGMkROVWUyWmsrVkM0ZVNJ?=
 =?utf-8?B?TStxNm5XMm4ramFiaGxGdUVxVzQ5WWM5V2x2WFVXMXNxc1U0eFlLWW83T3pN?=
 =?utf-8?B?bnRaclRKRGFXQ1FWVXNvZ1N4cnJIaEV5ME05eGZHS0Erenk3b1A5Qnk3SkVN?=
 =?utf-8?B?WmpzaEJWb1d6V3EraEJSOTd4VmZmbGpwZUlzRFRqaTFDcE9zMjdRL3duUFFR?=
 =?utf-8?B?ZUlVZjJObmMvZTBHYnkxMWJUQ214djU3WDJRZDdJMHF4aEwzalcvZ1ZPaVJ6?=
 =?utf-8?B?d2xSUmg0bFZUVGxSK2xiYUdSclZsa0Q0NCtuMnNyMytYMkhwbXlxNmE3Q0hT?=
 =?utf-8?B?K21XZWQ0VjFPOTI0eG5NM2hpMEZhUG50T1d6NFFFNHQraHdaNWE4ZFJoK2lY?=
 =?utf-8?B?aUhVUXZPU1FjeVhaUDBkYW1KUXZjQTJOSE9pV3krWUo0Y25jTEtHZ3F0a1R5?=
 =?utf-8?B?cXpqQUtnTURHMGdnaFRqOXJTQ285NzNjK293Y1JvSTBwLzVhK05jMFdqWnlS?=
 =?utf-8?B?Zmh2Vkg3Ni8zV2tVRzkxZm9aREozbUthMGRqNm5VZ0xJTnpkMmVvN0dSYmly?=
 =?utf-8?B?VnN6MUczcGU3aHVheFpQbU1KaTFHZ1IwbVpQYjVjemF3THlidXVPYnYxY2Fj?=
 =?utf-8?B?THhJRG5mVGZtL0VGd3g5dUIvU1pmcU4wakxUdXpac0dLL2ZaMk5ieVRCU0xO?=
 =?utf-8?B?WDFiUWNhR1hXa21BeXBERzBqZ3pvZG5UcTZzL3Uyb0JMb1hFSUtMT0h1dGJy?=
 =?utf-8?B?REIydEtqY1diZVU1ZENjSHMydDJUZDhUN21KTmVnVWl3ZG94cVY1MUM4VEdD?=
 =?utf-8?B?aDdNMmZOcGRxLzQ4ejFZK3JVWVpwdTVLV2dCemJuZDJVcC8yR05ObmhLMDNu?=
 =?utf-8?B?RkpaV1VIZkpQSkR3UTQvdkJVOXZ0SmlaWFNFVXcyY1NxODNyZDVWWXdlcjFq?=
 =?utf-8?B?dnF3NjFUR2lqSEFjR1lrWStxSXJ0NEdBdmt1UmE0MGpVc1Yrc3Y3ZUdPOXJn?=
 =?utf-8?B?amgwVW4yS3U2ZTA1Zms0OEtveHIrbFZvTEZQR1Z0aXp5V2hkbloxUkkzQTQv?=
 =?utf-8?B?KzVjWGtTVWlGU0cwTVRzQlc1YUYyRnFGcDNhQU51YlZ3YmJZWVU5aHltdzNC?=
 =?utf-8?B?R3B3ODJ3MzRkU2NaZVNtOTlYSUxsR3o5cUZ4SkFINUF2QXJBa2pYU2hGdUhN?=
 =?utf-8?B?ZDJRMTZlMktnemVSZ2U0QVNOS09mSmp5WWx0am5xM3h4RVVoWEZrNjVnY0F2?=
 =?utf-8?B?eVBuOW5kODhQU0NEYmJZSGx4V0xBVHhHMnUxcU1sSTFxcE5HZFdhSkc5aU9R?=
 =?utf-8?B?R1NKbVlsVHZLQVlEUmt5T1N6SXgrSmZnYnV0Ritya3Q4aG9vZVFqMWRlT0tz?=
 =?utf-8?B?bzJaUWw5SVFxcFFKQTU1RFlXZlNiV0hNSTBRcGlFV3dsV3FodVAvajZycTJj?=
 =?utf-8?B?c3RVRU9OOFAxcTBpWExjL2cvL3daNjBENjVGdTlIMG95Z1VRNXNIOUVnNEhu?=
 =?utf-8?B?RkZZR09wcmIwQWxycmZMcnc2bU1iZmhSbHZTclZoSFo5MERGb0hBdDBXc3p4?=
 =?utf-8?B?cHBaNlFPQTQxZ3dQdmkydjN3VkcwbjhkcUtsbHNlTHVOQ29ZYkxFdld5blNs?=
 =?utf-8?B?ekR2ejdVV056RS9xb2FHUEJHSFJtd2NnamZUS2JsUThEZ29kQUQxRlpMU3hq?=
 =?utf-8?B?aDNXeTBDOGdvUzl6RFZ4QmpZMy80elFHRHlrRVRNQnVHZ2NndnI0K0syNG9w?=
 =?utf-8?B?NW1aSnVQOGFoVm1DVTJzeE4vNW9pQkFlWFJjQzRkL0NRM29vd0dxeUZOSm53?=
 =?utf-8?B?SzIrK0Z1NjFvdkI1djQvKzlqcldNeEhzKzd0VGJqcEJ4NHpkNU1qNCtxS3RO?=
 =?utf-8?Q?Ks5OTLD5bviwV4gnw/hPiIRnB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf6e764-4050-47fa-90c1-08dd57b3e839
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 04:53:56.7742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ujvnnbhd9qdUTF+og0Ml4XErC6hl93qLxiMm10EGyAEJAUv1HLsJdifgIc/ljjA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5989
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

On 2/26/2025 1:01 PM, Lijo Lazar wrote:
> VCN IP versions >= 5.0 uses VCN5 fw shared struct.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index d29e8d685194..7ef83c9346e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -153,7 +153,7 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
>  
>  	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>  		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> +			volatile struct amdgpu_vcn5_fw_shared *fw_shared;
>  
>  			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>  			fw_shared->present_flag_0 = 0;
> @@ -341,7 +341,7 @@ static void vcn_v5_0_1_mc_resume(struct amdgpu_vcn_inst *vinst)
>  		upper_32_bits(adev->vcn.inst[inst].fw_shared.gpu_addr));
>  	WREG32_SOC15(VCN, vcn_inst, regUVD_VCPU_NONCACHE_OFFSET0, 0);
>  	WREG32_SOC15(VCN, vcn_inst, regUVD_VCPU_NONCACHE_SIZE0,
> -		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared)));
> +		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn5_fw_shared)));
>  }
>  
>  /**
> @@ -451,7 +451,7 @@ static void vcn_v5_0_1_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
>  		VCN, 0, regUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
>  	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
>  		VCN, 0, regUVD_VCPU_NONCACHE_SIZE0),
> -		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared)), 0, indirect);
> +		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn5_fw_shared)), 0, indirect);
>  
>  	/* VCN global tiling registers */
>  	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
> @@ -493,7 +493,7 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
>  {
>  	struct amdgpu_device *adev = vinst->adev;
>  	int inst_idx = vinst->inst;
> -	volatile struct amdgpu_vcn4_fw_shared *fw_shared =
> +	volatile struct amdgpu_vcn5_fw_shared *fw_shared =
>  		adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
>  	struct amdgpu_ring *ring;
>  	int vcn_inst;
> @@ -602,7 +602,7 @@ static int vcn_v5_0_1_start(struct amdgpu_vcn_inst *vinst)
>  {
>  	struct amdgpu_device *adev = vinst->adev;
>  	int i = vinst->inst;
> -	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> +	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
>  	struct amdgpu_ring *ring;
>  	uint32_t tmp;
>  	int j, k, r, vcn_inst;
> @@ -780,7 +780,7 @@ static int vcn_v5_0_1_stop(struct amdgpu_vcn_inst *vinst)
>  {
>  	struct amdgpu_device *adev = vinst->adev;
>  	int i = vinst->inst;
> -	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> +	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
>  	uint32_t tmp;
>  	int r = 0, vcn_inst;
>  

