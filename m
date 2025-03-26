Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96ADC36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 09:14:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 523C810E109;
	Wed, 26 Mar 2025 09:14:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R79QmtHO";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83F1A10E109
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 09:14:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqXMKxcFufCW5ZfIX9T9STLv4Hx8HQR+pSYZg4E+JzBO5AaSkQmV1y8fG9+JBwFmFu36VZBzShyRn9QI5uNQ8m5lua9kLwb5yizeD2fAbdw4fkuVGaTnroA8/Gkw5dwwltW+3KvKj319ZuO6y7s3+g3tv3KX2e479ZmSS8N0pMLT/pbRV2thNXHZeG/nR79qwC9+VieasYyZuj8uQSKRIlOyzOOkZHGNicqTqXu0/KFgRRhdPr+Pj7p6aElNk96ig5Web3yuWj8w5PpqTu3EQ4T4Q86izuCAoKXNPbXvHG87vE8FxMp0U8N+y+eVkYHo+hCUOD6t4Od+HCj6IBFUvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIeX7PbVplGufzZlG0yY5xHeRCLOBP2Thm4+CTIQB8U=;
 b=B8hOEcrsboJjU08qjF3uLS8W4dvNS8I0lJEFcISe9bw7TWMbmOEDHT1xlqDxUKjyM8V0Sr3gOP+vYZDfPQJJwLYW3uyw3nl+xwZZLI0/F3LSZ6jXDRHf7sczHj35V9RCUUiECA890gzKu3rWhXUPHpPDhB8W80OA++/AtsLECcmQW4pRYaXPFHtURfPwbo/k/6fA9nFBnqpUXSQ5mLHUxH2jNSfthYS1XrvWIWEVTFaHDNiRI0GbHucGMyWLcccc3FuZ7J+h4XSQRN5PVT1kjhrf8zSMLB65RfV8/DwxhtSdJNxkwFyPSin0lGcltr8Vm+ZNox7yqKOyczn0JZqEgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIeX7PbVplGufzZlG0yY5xHeRCLOBP2Thm4+CTIQB8U=;
 b=R79QmtHOY0pDDv4ji3KRrrcEo/qbdVIhxxnWT/1Gy1yexrC8Rsjz27aOkmZym4m1Aw3vgki8wqmoBCvZf8rGBrVU9NOjSB88eH8kLLeeRIBuMHWQ1WxGDV1CMwVs7q9KC0d/9FYcLQFlvdwqswgOvRhv+wmxXr7QyT6dUIxyTGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6411.namprd12.prod.outlook.com (2603:10b6:208:388::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 09:14:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8511.026; Wed, 26 Mar 2025
 09:14:17 +0000
Message-ID: <01399be0-45ec-4823-a58a-6b33e258aeba@amd.com>
Date: Wed, 26 Mar 2025 10:14:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] Documentation/gpu: Create a GC entry in the amdgpu
 documentation
To: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Melissa Wen
 <mwen@igalia.com>, =?UTF-8?Q?=27Andr=C3=A9_Almeida=27?=
 <andrealmeid@igalia.com>, =?UTF-8?Q?=27Timur_Krist=C3=B3f=27?=
 <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, linux-doc@vger.kernel.org,
 kernel-dev@igalia.com
References: <20250325172623.225901-1-siqueira@igalia.com>
 <20250325172623.225901-6-siqueira@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250325172623.225901-6-siqueira@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0276.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: a0968324-91ce-4752-af90-08dd6c46959c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmZ6OERwdWZNS2NieU16YUlHSVppdXgyUGlhVE5zNWhXNUhwc3RIa3NpTm1v?=
 =?utf-8?B?ZGdMSGo0M3BWMmpiNXI1VmNHQXRWQUlNOXA2ZUZBL1RYeld6K0RzYkVoTEg4?=
 =?utf-8?B?T0FyZzdSK3JiZDhmMWRaM2RCSnNlK1NFTHdDN3VCaVlyeU8zUkd3S0V1QlBL?=
 =?utf-8?B?UFNTVWlDYUFFYnZrYWVyN3ZSeElhaXdDd0sxT3Q1TU5qK05NN1NybUo5cU82?=
 =?utf-8?B?L2ErWkc4RC9odis0VGZ2bFIvK0twT2IvcGovZEdCclRQR2wzYnVwOTIwSVIr?=
 =?utf-8?B?T3VPL0prOGRBTjdjckJwL0FpQWNpaGdnb09vWVdUMHJhb20wRU1LK0pWUm1r?=
 =?utf-8?B?RnVkMi9EdlJqM3lwaHRadWc0VGhnM3V1c3N6ckFRUG9tc3FYUEYxWXJONk5T?=
 =?utf-8?B?Tml3WHJma2NmSi9uNGFHb0FjelFud3M4QmozaFJ1RlA3K0o2UmE2VDNjS294?=
 =?utf-8?B?TWR0UXppUmlmZ2tXZFVNeHcyOXgvYU05MGU5b1pseFNXaSsxVGxxKzZuZFNS?=
 =?utf-8?B?My83S2hOSHUzODA2RWJmemZxMGhaZFdpVWEyMytpd3dnR09iZnlxK1Q4MEJa?=
 =?utf-8?B?em9tTWM3TGgwK05RWUVLcGRONzduS1Fwc3JOT0YxaGlhNmxlem1TdGZLVVIr?=
 =?utf-8?B?OWJQdVRxZWNka21jczNta0kzVExwN1EzaGdNL0pTcXZHOFg3d2hFL0tVdGRL?=
 =?utf-8?B?SUw0RW4zUG9EV2dXYWVXVGloTHF3VERTcEVxWEV0SE9reDk2ekJzVi9XeG16?=
 =?utf-8?B?aVVmUlFHM2tyMUo0Z09KV3lDaGhHV3BTZzdMRmphRmcrcUExN3VSVnBIZTJu?=
 =?utf-8?B?b0o2aG11YUdab0s2bnlTcFk0WElXdGM2dWtaWHl6ZWI1R1RrU3pHZ3ZReGpk?=
 =?utf-8?B?c2VSc1NBcTBkWklZRlFKRTZ6NHdra0NnUFdUUHJkRnlRZlFRY2hNSHFjQ3V6?=
 =?utf-8?B?RGd1WHV5Sms5VzZSVCtNc2JWM0ZsOFVzaW9qenlJanA4eXQrSmRRZzVWZjlk?=
 =?utf-8?B?eTI1SDI2K1J4RlVwOXNNSENxeUw0RU5pM29Ca2k1emJNZWxxY28rUWhUR2ww?=
 =?utf-8?B?a28zZDZhbFNOWXczMWI1aG5yVGJGR2pSdTBBeU5LcVRjRlg3alNjOXUxN2NU?=
 =?utf-8?B?NTkwbUc1ZisvUHdaVnE0ZzlrSk85MDNXN2ZQL3VERTZQd1VVaG5vblJZVVkx?=
 =?utf-8?B?M2p4aWhjUUcxSEQ1anZwaERMK0hyT2Q2WnBxSnVSdU5BaGFYN1psRDlheTlz?=
 =?utf-8?B?aDAwRVpIWlp5UEFPYXVPWkJiQ0pGbmh3b3M1QmJ1ZGFRc1BuZ1FEYlJoNUx2?=
 =?utf-8?B?QXFJUHFLOExGclFTRjFpRjNkVkNBVXpiZjVSUGxzei85UFNva3dTU3ZIL2lX?=
 =?utf-8?B?UGE2Q3oyTHhaNGFyamZzQ2FTMDhHZUJVL2JmZ09vQ1Z4Vm8yVkZXRG56OUhF?=
 =?utf-8?B?ZTNqRFpmNzZsUWt6V2dzNlVSaHpFUlh2cmFzWVMrS0xXVEVscXhveHB3eWFy?=
 =?utf-8?B?TUxBNjBXMVlNRUdNaWlvdHRIaGJ5SXhncmExMmg1dlhueUZCbHlxZ2VoUm0x?=
 =?utf-8?B?QUdDRkNNTUlxM2xKSmMrOVZjSE1EYVlhUi9FUzB2YTROc050RzFuL29zQTVE?=
 =?utf-8?B?elFsRFIvU2drQTNNY2Q4Tzc3c2Z5ZXVVTDZxb3psRkFoOHQ2SEU1NUR6SXpp?=
 =?utf-8?B?cDNNTWUwTHlqQzV3VGVKbXA0WWpPNmVjSkFYNmdmUGpCcHUreFNGdzdJK1hR?=
 =?utf-8?B?TFF4Q21tTXNVRVBobFl5ZmpWdGNRZ2dYY1kxejBiWGF4cTZxVHJCU2FNQ2h1?=
 =?utf-8?B?eVk5TkRnNVhxQ3JRbU10dno1T1NFbElVNnVRaFg5TDk5NldhQW4yWFJPMUNO?=
 =?utf-8?Q?MkxV09Toy8U1e?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU1OYjk1UVc1VThRRG90bWY3bC9yWlFQTld3UjJvbk9BZDd0WjhxTXRoZmMv?=
 =?utf-8?B?ZnpieGZVcG94T0locDdLVGVZeEZ5ZzdiWHdoUFlvODFnOVkrMlJnbTRVQUVw?=
 =?utf-8?B?OEV2VDNTWGdCZXZpcHJMUFcrMUFrLzhCR2FqOHVuQmRoSlF6QkFaVng4Qlgr?=
 =?utf-8?B?dzBIejQyczg2M01rcGZkU3Jxb0JMSE1DYXhsRVVsSkNVa3h1Vi8xQTk2dERt?=
 =?utf-8?B?anZPNVRsajVhT3loOWVyRTJaekw0dFlCQ2F2TDduNW13VFFjYmZxSXFoL0xQ?=
 =?utf-8?B?QmpHSlNjR09taDNLdkRuU1JQS2svdGRmcVVHV05FV1VoRTF6MlQ4QnFhMkNr?=
 =?utf-8?B?aHhpVTg2d1ZwVlRidzk1bjh4eEl3VnNSMHUyUVFRRnUrL3ZWYWtTNGxjNnhD?=
 =?utf-8?B?cjVOWndyT21EYVdnTVQvNGpsVjRPZ3BUdXRWUlRzKzZSZ29meWZPRGdwVW0w?=
 =?utf-8?B?NzVMUnlYcDlaTWJIbGRJME1FeFFWYUMwekt2MEk3c1NPNEovSHVTaWplem5V?=
 =?utf-8?B?VEV1Njl6VGdnbUxLUVo2NnFlMzY0b1R0NC9sSytDTldreWdNRjhHcmdvbWVl?=
 =?utf-8?B?VTRwdGk3R2dQWlh3R21DUzgxejczSXVPKzdjcm5iSk04SDQxRjNheEloTTJl?=
 =?utf-8?B?MVlDNG5QVVdaV09VS29lWHExb1BKYUdCMWE2WjE2dDBXZ1hqdjZmem1aR3Vl?=
 =?utf-8?B?a0hmS3B0RlZjbGtIVjlEOExrLzQwVFdUbHZRUFZSR0h2cGdraVA5dXI0M1Fo?=
 =?utf-8?B?K2R5VWVBa2paMTJjN3dVMFdiSk5TVmNwaVVUV0tUamR2UDVDUC90dmtBSStF?=
 =?utf-8?B?WG9PbmREWkRWT2JYQUFUdTk3bVVyVDlCa2RBZUU1Z3R5aG9ybFBSOStqM0xY?=
 =?utf-8?B?b3J0Y0hXWjJuTExsSjV5R2ZzVHNtekRtY0FUdFREUjRVOVJuMktuZk9XR0R3?=
 =?utf-8?B?dnA3SlhlSEhhSmdXdGxnVTBJU3g0Q2d1enJNUmNsNmpqY0dTWEtWWmwwN3Bo?=
 =?utf-8?B?aUJ6L2RuY2t3VGx4M1NDQ0JNYit5MXlReURKdTNpdkdqYmd5TWtlbTd3RnFN?=
 =?utf-8?B?N0EzQXpSUnBUbGJOdzlOTk5ESUNjdXhLUWlIMXVpbEFuVkp5anN1M0RUcHJP?=
 =?utf-8?B?aURoWTNFYnlUdm5DQmdNTzhMeUo0VDVyZDh0ZnRnMWxQa0hUbmY1TFgwOHV2?=
 =?utf-8?B?Q2YwMzhTQVNiYnBmZ0VxM2xkL3pQcmZGMWZ6Y0VIUVdEUWFodFFuY0ZYYlpl?=
 =?utf-8?B?bHRLUXVCOTVhVld2V0VHTjFnc1U3TTJDU0xQdDRHK3JiajBTWU1LSm9mWWha?=
 =?utf-8?B?NXZJVFY2cG81TGJPOUxzQjRaeWZCNWZMVEhvLzhMNWhIUDhuVHMweFRieXc5?=
 =?utf-8?B?QXdRZG5pblRoVVBnZGdnVWxnemF3Vy8xY2J3QWxnT21xem5tS09PaEh0TnEx?=
 =?utf-8?B?RTQvbFM0a2ttNmREVS9xaW5FdXRyTkM3d2Z2b3NxK01JMFlONmsranBrL3do?=
 =?utf-8?B?ZW1PYUIyZXRpT25zNzZvMEtleENCTW1FdU9VeHNnYjVtY2VyN1VyM1J3Qnh3?=
 =?utf-8?B?R1Y5UXRFNHlvMDFORW02eHBrUllESG9mT1c0M0JNaE5hcFFvWVVEcEZOeGFh?=
 =?utf-8?B?aXp4UWFqc3J2NXFLSDBnanR6UU95cjFxTjY0YUF0dGtyQ2pSMXNXOWNablc1?=
 =?utf-8?B?ZHdOQTFrZnBtTHIramhKM3gwN1AzUnpYT2d0UG9kS08zeVQza2xuUnVpaE1Y?=
 =?utf-8?B?dmNtUkdkdWl2VkwrR2VtTmtjRGhVQVl3Z1ozelV4ZXNQMUZhMGxnQXdlUCt0?=
 =?utf-8?B?KzZCNTlwUmN2eDkvdSt5bW44TkVkVkVlM3ZkSGFqUFVBQmM0SXRSRlQ3a2Vv?=
 =?utf-8?B?YUVIRmtsWkpzK1pSVDA3RkhsMGxicFNCV2pYM2VpeFFBdUh5WFJIQlhRUHM0?=
 =?utf-8?B?MWwzb0NKdUFENlVwSG15b1dyaS9xR3lzRzNUYjBaMWNDTVJNM09xb3ovY3Ry?=
 =?utf-8?B?U0kzVDB2NkxMTGZ5M2ZXSWZvSGdUaU92WHAvOEViZno5RmVnLzNyY0JlNmNH?=
 =?utf-8?B?WWtBZ25SdzBNdS91SGpDMzFqaEg4ZWJxREtiUEFGQjdaVVovc0N4ekFxd0p5?=
 =?utf-8?Q?VTJV0aQxcgXP1iHXR4fz0XxAe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0968324-91ce-4752-af90-08dd6c46959c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 09:14:17.1571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHCYP65ZpbtrpSGmRR06ps9sqtrQf19P75J/X6v8DmxHY1OObTZedlRHM1RJlOav
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6411
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

Am 25.03.25 um 18:18 schrieb Rodrigo Siqueira:
> GC is a large block that plays a vital role for amdgpu; for this reason,
> this commit creates one specific page for GC and adds extra information
> about the CP component.
>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>

Acked-by: <christian.koenig@amd.com>

> ---
>  Documentation/gpu/amdgpu/driver-core.rst | 30 ++-------------
>  Documentation/gpu/amdgpu/gc/index.rst    | 48 ++++++++++++++++++++++++
>  Documentation/gpu/amdgpu/index.rst       |  1 +
>  3 files changed, 53 insertions(+), 26 deletions(-)
>  create mode 100644 Documentation/gpu/amdgpu/gc/index.rst
>
> diff --git a/Documentation/gpu/amdgpu/driver-core.rst b/Documentation/gpu/amdgpu/driver-core.rst
> index 746fd081876f..2af1e919d76a 100644
> --- a/Documentation/gpu/amdgpu/driver-core.rst
> +++ b/Documentation/gpu/amdgpu/driver-core.rst
> @@ -67,38 +67,16 @@ GC (Graphics and Compute)
>      This is the graphics and compute engine, i.e., the block that
>      encompasses the 3D pipeline and and shader blocks.  This is by far the
>      largest block on the GPU.  The 3D pipeline has tons of sub-blocks.  In
> -    addition to that, it also contains the CP microcontrollers (ME, PFP,
> -    CE, MEC) and the RLC microcontroller.  It's exposed to userspace for
> -    user mode drivers (OpenGL, Vulkan, OpenCL, etc.)
> +    addition to that, it also contains the CP microcontrollers (ME, PFP, CE,
> +    MEC) and the RLC microcontroller.  It's exposed to userspace for user mode
> +    drivers (OpenGL, Vulkan, OpenCL, etc.). More details in :ref:`Graphics (GFX)
> +    and Compute <amdgpu-gc>`.
>  
>  VCN (Video Core Next)
>      This is the multi-media engine.  It handles video and image encode and
>      decode.  It's exposed to userspace for user mode drivers (VA-API,
>      OpenMAX, etc.)
>  
> -Graphics and Compute Microcontrollers
> --------------------------------------
> -
> -CP (Command Processor)
> -    The name for the hardware block that encompasses the front end of the
> -    GFX/Compute pipeline.  Consists mainly of a bunch of microcontrollers
> -    (PFP, ME, CE, MEC).  The firmware that runs on these microcontrollers
> -    provides the driver interface to interact with the GFX/Compute engine.
> -
> -    MEC (MicroEngine Compute)
> -        This is the microcontroller that controls the compute queues on the
> -        GFX/compute engine.
> -
> -    MES (MicroEngine Scheduler)
> -        This is a new engine for managing queues.  This is currently unused.
> -
> -RLC (RunList Controller)
> -    This is another microcontroller in the GFX/Compute engine.  It handles
> -    power management related functionality within the GFX/Compute engine.
> -    The name is a vestige of old hardware where it was originally added
> -    and doesn't really have much relation to what the engine does now.
> -
> -
>  GFX, Compute, and SDMA Overall Behavior
>  =======================================
>  
> diff --git a/Documentation/gpu/amdgpu/gc/index.rst b/Documentation/gpu/amdgpu/gc/index.rst
> new file mode 100644
> index 000000000000..f8128cca7028
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/gc/index.rst
> @@ -0,0 +1,48 @@
> +.. _amdgpu-gc:
> +
> +========================================
> + drm/amdgpu - Graphics and Compute (GC)
> +========================================
> +
> +The relationship between the CPU and GPU can be described as the
> +producer-consumer problem, where the CPU fills out a buffer with operations
> +(producer) to be executed by the GPU (consumer). The requested operations in
> +the buffer are called Command Packets, which can be summarized as a compressed
> +way of transmitting command information to the graphics controller.
> +
> +The component that acts as the front end between the CPU and the GPU is called
> +the Command Processor (CP). This component is responsible for providing greater
> +flexibility to the GC since CP makes it possible to program various aspects of
> +the GPU pipeline. CP also coordinates the communication between the CPU and GPU
> +via a mechanism named **Ring Buffers**, where the CPU appends information to
> +the buffer while the GPU removes operations. It is relevant to highlight that a
> +CPU can add a pointer to the Ring Buffer that points to another region of
> +memory outside the Ring Buffer, and CP can handle it; this mechanism is called
> +**Indirect Buffer (IB)**. CP receives and parses the Command Streams (CS), and
> +according to the parser result, the CP writes the request for operations in the
> +correct block.
> +
> +Graphics (GFX) and Compute Microcontrollers
> +-------------------------------------------
> +
> +GC is a large block, and as a result, it has multiple firmware associated with
> +it. Some of them are:
> +
> +CP (Command Processor)
> +    The name for the hardware block that encompasses the front end of the
> +    GFX/Compute pipeline. Consists mainly of a bunch of microcontrollers
> +    (PFP, ME, CE, MEC). The firmware that runs on these microcontrollers
> +    provides the driver interface to interact with the GFX/Compute engine.
> +
> +    MEC (MicroEngine Compute)
> +        This is the microcontroller that controls the compute queues on the
> +        GFX/compute engine.
> +
> +    MES (MicroEngine Scheduler)
> +        This is the engine for managing queues.
> +
> +RLC (RunList Controller)
> +    This is another microcontroller in the GFX/Compute engine. It handles
> +    power management related functionality within the GFX/Compute engine.
> +    The name is a vestige of old hardware where it was originally added
> +    and doesn't really have much relation to what the engine does now.
> diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgpu/index.rst
> index 7e9d60754287..1624f4b588c5 100644
> --- a/Documentation/gpu/amdgpu/index.rst
> +++ b/Documentation/gpu/amdgpu/index.rst
> @@ -10,6 +10,7 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA) architectures.
>     driver-core
>     amd-hardware-list-info
>     module-parameters
> +   gc/index
>     display/index
>     flashing
>     xgmi

