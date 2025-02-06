Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84B6C02194
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 13:53:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8713010E838;
	Thu,  6 Feb 2025 13:53:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2VeUl/8z";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09F3E10E838
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 13:53:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ez931MtczicGxCxSezkUOzheYgwB0xhnFnAUzv1mFE74jRgwYkhVG3OKB35gMBJ6GJamRYWJZGjINyQcbdTY8Net8XH9+rSIlF+nHyvUjy3r1xz0XqnV8r7dBZPq8boV2EF3H5AfgObYC8EhTmjD3Wx5unoStK06y0lL157tEMtivzNTCFFSpyPwUuxTFxDZB5Cpmk45JBppmFh3MllnGOXTV67YBbQWWICekarEZ55nqfN8yXU2ElQPEVlWo2p3GizNaK/ZZHXyDHbqRltV7ILPHAEJBu/kbS+UGy4hjVfoYBCiH4K/5ixKtFVoD6Swk9wlScLFA3j5tiGNlzdQyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NReVLe974HOcbCUrhlbRv7ubOPhLXibfaO2dfJZui0w=;
 b=iFifpANWazuw00Otqcsa+FBoihy6laYyP3F/m5zjHs58BeNT9NHjNTtFLIvTA3DeP9owVdrtv+Npxhx79EoM0m7sRpmWZgLsDUJSlLtH4z2TeVUrUuNDKzvjp2ljYAcBIxmU/uP2LJYNDE2lenAX6lQ2F+SH7IxAcR6PUJujQ4nlawSUiRan/Tqf2nlFUQnkCNFCDIoptO+YvKIa+rKt1OdFHS4MJvTN3Fs3mNYIF2OfDQGiYh/Fax0ytIRPPmjk42RVFZN7ydnVMmkkhelwu7deTVtSMz9ONgiBr0391vMUkdgjEZin7W0MbzN7ugkX4PKpXnqgjKv7KuMktng2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NReVLe974HOcbCUrhlbRv7ubOPhLXibfaO2dfJZui0w=;
 b=2VeUl/8z5K2J1N3+aC0dCKORohSfhFOFFeCuT2zf5oRi/Z+9v4bJcER847+WKrGDZRSztXHYDk6mgjcCQCA9hinPhCpOHNiUHRrJHQfDPVVgki7m6xkqAm5vqZQwCQNa6D4duHASl5/1Ocz+S5SMZvNl2Mg32SCpxqqqagh/QSw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by PH7PR12MB9125.namprd12.prod.outlook.com (2603:10b6:510:2f4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Thu, 6 Feb
 2025 13:53:23 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%5]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 13:53:23 +0000
Content-Type: multipart/alternative;
 boundary="------------HWCzuTGaLja1gt0S7vgWin7u"
Message-ID: <fc4d3983-860c-4be3-b358-78a39b49afb3@amd.com>
Date: Thu, 6 Feb 2025 08:53:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/44] drm/amdgpu/vcn: use per instance callbacks for idle
 work handler
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
 <20250131165741.1798488-33-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250131165741.1798488-33-alexander.deucher@amd.com>
X-ClientProxiedBy: YQBPR0101CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::31) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|PH7PR12MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a8d0535-9a42-4dc4-594e-08dd46b59f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1ljR205U3RMS0hHc1N2WEFYWFlIa1J3aW05QnRhKzdSaXV4Z2xxUUxnRFha?=
 =?utf-8?B?OWQ4N0VXRmdzZWxuaW1NdUQrMzRFSE5yZStPTDBvanA0YSsrYkVNQmlXanVS?=
 =?utf-8?B?NTJSRGxFQmZYUVpXV1pyMXFTU2p2cTBtVjE2OWViNlVIRnpHZGIzcnp1T0c2?=
 =?utf-8?B?d3ovRUk0bDNPZUJ5MEJCSG9ZdnM3Nm5qdXhuWGVUZ2tjWUFGYi9yNmxXaGF3?=
 =?utf-8?B?TFV1V0ZNV0lSUUdrQ0ZNNHlOTnVBWVhXRUsrdE14Q0RxbWpaaXdiVE9MTWI0?=
 =?utf-8?B?S1AvdFkvZWpFSTZteng4ZUtiWi9tdGh5NWlESldLaUY3cFltVHJkNGFXTExp?=
 =?utf-8?B?K1RuREdYY0l3OWdtcEFha0U2QUxtZjNRVXBxbVAwUlBwaHRteXh2V3R1aTYr?=
 =?utf-8?B?MFFDSlpxaTRRajBvVjRHR3QvclVBVWxtVUt2akxib25yYVMyeU5BV2E3eHJ3?=
 =?utf-8?B?OXM1ZlZEeVVQcnpIa01FNVpNcitiWWo1dWJpTk1rMmhTWVpBSnJwRlBBVjE5?=
 =?utf-8?B?SHJ2OXEzT3QwZXYzVFJLVExyZG9HTEFEWDB2WVV0Mzd3UUxVVjd5MWFETTZy?=
 =?utf-8?B?NGthNER3WUlEV1p0ZWVubXZRNXdoZGZmMW02TWdUUzcyeEgzTDdHOE5ueW1q?=
 =?utf-8?B?ek5wTUNaN2wyeDIvYmU5U1lKZG1jN1M5ay9SUkR3TVVJUzRQTzkwYSt1dENJ?=
 =?utf-8?B?U3JIZmZCQkVHSk5yRGJ4Q2lnZTVWODB5VFA0eUZBZWJ2UTlYK2ltMXl4b2ps?=
 =?utf-8?B?QmZkRklZcWxDL2xlTkJHaHZtbGtmSk9nZ3phb3Z5VXV5aTNxUXJkSTRzVFcw?=
 =?utf-8?B?VWV5U3UrUC9ReVUzQmtIeWxrUkZOSFE1bXIybWNpQ3NRTnorYzJuT05YSXVF?=
 =?utf-8?B?QzV0TWN6R2Q4UzlEU0ovc0F0VkFjYWZSQSthc0NMSSt1eW9lZnlHaWdOckZy?=
 =?utf-8?B?Q0ZsaGpEMmovRVVqTXZxRTlna0V4UkhodGpSVmRVS0M4b0RLMlRZTFFTTWFV?=
 =?utf-8?B?cjAvZFI0YjFobmZaeExQay9hVHVXejFydmJHUk5lTityMHo4RkpiU3ZwRmVp?=
 =?utf-8?B?SUJCZFZrTGlaU2NSWXFZZ3kxQjh0WU5GWjZuUDVTdWtXcEdHemUxU2hpY3l2?=
 =?utf-8?B?MTJGWllMRUZvTmNqLzNkcTBnQ0NiTmJmZEdGYXN5bE9HRlZpcWN6OGZiUmU3?=
 =?utf-8?B?M1hpYUIrYXVCYXNpdG9kT2tPdUJjR3UzbmtBR3BLcG9JTEQzRHdmbFVrMlVh?=
 =?utf-8?B?Wkdab0xvMDVLbkttNmJSeVpNUlFTU3lwM2EvbkIzZXAveCtsclBzbmhFUVRl?=
 =?utf-8?B?ODdGVGFKTDZRM0VlUnJyTnRsdzFGMDRPMEQ3eVVFSXAyNEFvUGhiOWZlUjZn?=
 =?utf-8?B?Ymc5ZXZraUo0NmJpa1p3cjVOek1GNzduNFFkSVhsaEt1andYUWs2d05keUQ4?=
 =?utf-8?B?RGFFYjNmV0VubGlVSXFKQ3kzRlVPRHkrMWVuUllMRnUzakYrdFVQb3pxc253?=
 =?utf-8?B?eUlqZzcram1FN0N2OGhuL1hxWGJLY2VXZmNUZ1I0eXJYUUpMNTlWVncwZXhM?=
 =?utf-8?B?a0Y3SXd1cnVtOU5vOUlSYlRidHdRZGtwR1E0Y0pYaHByQ1dxeEVXZG1UOUhh?=
 =?utf-8?B?ZHlaRFVOanRxbW83SDlqQ1VOUFovNjNHMGlWUGRrMHhTQXlnL3dEZ3g4aS9G?=
 =?utf-8?B?N0xRSkRNQUxMNXBQMUxDUFV2VFpjeGRBdVZuY0NCaVJKSWpMa2ZlbjlnN0h1?=
 =?utf-8?B?UEZCbnF5TDZwTzlnaGkxOHFtYTdXVzFDekxGUU5IMnEyaFZsWUJwNkVnUVYy?=
 =?utf-8?B?aXk3SEVtS1BXeWkvWG1vZVVGRFRtTGNEUHdjYmtta01VM0xHQ3dCVDdBMVJW?=
 =?utf-8?Q?NlnLDZFOtKL4B?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZE8wdmw3WXRoTy9YMlhyVTVuRnJyWThiRktNNHZpMnVNTG5mMEkvN2w5aU9x?=
 =?utf-8?B?ZitIbTN2YjdXNE5CcFBxR0hVczVhdjEyRTZZVWhHejRQZXNBN2JjY1NmeXlE?=
 =?utf-8?B?Wnl5Tm1YU1l4UXNyblFoQS9hNHhaZklDTjFaVmNQdVJJSGhmK3BFd0RBTDdu?=
 =?utf-8?B?UDVTVFNTL1hPTi9GNXBPeU1kWnlMYjhIMEg1ZVlNTUh5ZnJ0cTBaSCtoNEFX?=
 =?utf-8?B?b3h2dUh0MHhqK2x4d3BlM2FqNmpGT2E2VTRQTTUwMlpIbXk2VmRrT09meEpC?=
 =?utf-8?B?WVgxbFVVakZwcnY0Z3JHVWtlNFhoRkd0ZDRMQW5NNWRQaVgzbUdqbGsrNWZK?=
 =?utf-8?B?emllSkJiY0dQVEg3RkNEMXJhZEkxWEFoei9sUjQ1ODkyTm53Sm5Sa0hEK2Ir?=
 =?utf-8?B?UE5oOVlDVnNuQmM5YnFSZGNSK1dZc0ZQMjJaaEZ0VU03UzBIczJ6aUkvdE5U?=
 =?utf-8?B?UWhkdWVJajY1Z2hkUXFKM2tnTmNULzlxT2hOUElLSXJKZHArVDI0Nm5rV3N1?=
 =?utf-8?B?NTJrWEkyemZ2TlNZVjN4alNBWCthVkxra3dRVWtraHpucWVFNVRBdXRQbm90?=
 =?utf-8?B?eW5wSGZTMzhLamt6cXhtV0wreDVOdVllQy8vODJRRFM0TEhkVHRRS2YrWkFI?=
 =?utf-8?B?bjJQK3NhMVBKVWN4dnFGSUxiSmhCUC9JcnFKbllic2I1MWVOKzJwdUFqajAz?=
 =?utf-8?B?RUtTaVhNM2g1MmZjaXIvM1lGNmMrL1ZwODdRQ2p3eG1tTUdNSzJVaThKYi9L?=
 =?utf-8?B?V3VHSVBaaGloaEdNSjJYclN0cXBSRjRNbGNOZjZWL2QrdTFaYjcvTFpCeWN3?=
 =?utf-8?B?ZkxVVk93dFVmcXhkSlpibmJtdzFwRG9XUDJ0SUFJaTZUR2ZqTHZoOXJrYnRX?=
 =?utf-8?B?RGllWTBrWmdZaE5jYmovQXBvQWNZeVQxVVRiUU45c2orQzVhYm5nb3N2OGFa?=
 =?utf-8?B?MXQ0d2tHclVkaVhDd2ZmZFhUdGtCZzg4dFdFQ3Bac0F2QzAwL1crUFM2OWxv?=
 =?utf-8?B?K2Zod1YyQURIeTd4Q0FMeG42UUYwb1Y0Yk05eVZEa0tmY2lvS2lFUlNHbjZD?=
 =?utf-8?B?d0NJRjIwT0tzdFVrZUxXRGhKWm5UeHl1aitneUUrRjFyZlNFTEgybmdybHpO?=
 =?utf-8?B?clFJdFl2dVNScjFMcXg4U05iTXVPQUZHQWNjSksvUlNvQjhEbEpIQXIwbnJw?=
 =?utf-8?B?MGE5NzBWa1JEK2xaL1Q3WXhLL1pKNEJjdG4rZG44bzF0YkZJSll4S0cyejRh?=
 =?utf-8?B?S0M3Q2RnN2tpSEFLaThUc0tBRmlzVlAzN3E5c0Jmcmh5OGJ5R1doZzdlcDNz?=
 =?utf-8?B?RUI2UTNCelNac3VOb0lFUVRUNGwyWlB2OWJveXMxdE9DaHo3SFh5QjJKbFlx?=
 =?utf-8?B?V3RlTjdEN3NxU2s3VVV2UjhVekVUeFlLc29sRFhrOGJkSlpWSVBNaGd5VTZK?=
 =?utf-8?B?cnQvL3BRcG5BM1BqcUkyYVRkR2FqMXE5SS85Nko5Sy9UVWJBcmJpMFFydkVO?=
 =?utf-8?B?SHpVeEE1akZMNno2RHdPaS92MC8vNjFzeVkxNkpwdkp5OGZZR2gvTzhMZGJH?=
 =?utf-8?B?NGNDankxa0lIdU43RFVla2xQS3BZSTRUeG40Y2RvMEpFNnBkWFlpZTBVRVh1?=
 =?utf-8?B?bTBSSWd3Y3FZNWZDVEp3ck5zZllsK2NNZ2plaDJjNUJQbFR4dFA0OXZTYzdP?=
 =?utf-8?B?VzFiWHFQZDRFMzhDeEJXUFdSRjdkOXUyVVJzbDZ6M2N0dEJHdkRVMUpUcHJz?=
 =?utf-8?B?VGNUSFp2bUlzVVFnTDQ4Q0NEbE54OVdDd2d1eG10M0dNUFhQVm5Vc0w2Slkz?=
 =?utf-8?B?YUxqOU4xeXJRNzhTODlGU1kwVCtXUkQrdSsrMVZ5TkJpdDdFV0djS1g0dWpT?=
 =?utf-8?B?YSs1Q3YxWHJJLzgrN1cyM0g5REg3N0FKMzNJZzNGUnBndXpUcmMxZlMyMWFz?=
 =?utf-8?B?N3B1ei9rM2o3UkV6R0tQc3FnZG9PUVJxc3ViODh0NWRONUd3UVNKbWJIQm1L?=
 =?utf-8?B?Z0JESFNIRTM1Rktpa3NlbUdjMkpoOUJtcmJZVDlldVNTRWZrallpMTdPNjBo?=
 =?utf-8?B?eFZkNS83NGVuV3d6UUtHSVl6NVF1VmsrdmRlZGJFcVAyTHA3RVVUUlNLVXpE?=
 =?utf-8?Q?j9CwoJomJkXBaCcbPnLROnIDt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8d0535-9a42-4dc4-594e-08dd46b59f81
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 13:53:23.7016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGF0Bv8vfT4AR34pUaba813FaTcx2PQaW1cX2gsUGplobqfvjNJbHANCNpmqaj6aOJ3YDjUo7uHrOXRC6G1byA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9125
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

--------------HWCzuTGaLja1gt0S7vgWin7u
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-01-31 11:57, Alex Deucher wrote:
> Use the vcn instance power gating callbacks rather than
> the IP powergating callback.  This limits power gating to
> only the instance in use rather than all of the instances.
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 27 ++++++++++++-------------
>   1 file changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index a2250747a7c81..81bfd8a9d8268 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -424,8 +424,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   	fences += fence[i];
>   
>   	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
> -		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> -						       AMD_PG_STATE_GATE);
> +		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
>   		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
>   						    false);
>   		if (r)
> @@ -438,45 +437,45 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_vcn_inst *vcn_inst = &adev->vcn.inst[ring->me];
>   	int r = 0;
>   
> -	atomic_inc(&adev->vcn.inst[ring->me].total_submission_cnt);
> +	atomic_inc(&vcn_inst->total_submission_cnt);
>   
> -	if (!cancel_delayed_work_sync(&adev->vcn.inst[ring->me].idle_work)) {
> +	if (!cancel_delayed_work_sync(&vcn_inst->idle_work)) {
>   		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
>   				true);
>   		if (r)
>   			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
>   	}
>   
> -	mutex_lock(&adev->vcn.inst[ring->me].vcn_pg_lock);
> -	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> -					       AMD_PG_STATE_UNGATE);
> +	mutex_lock(&vcn_inst->vcn_pg_lock);
> +	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>   
>   	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> -	    !adev->vcn.inst[ring->me].using_unified_queue) {
> +	    !vcn_inst->using_unified_queue) {
>   		struct dpg_pause_state new_state;
>   
>   		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC) {
> -			atomic_inc(&adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
> +			atomic_inc(&vcn_inst->dpg_enc_submission_cnt);
>   			new_state.fw_based = VCN_DPG_STATE__PAUSE;
>   		} else {
>   			unsigned int fences = 0;
>   			unsigned int i;
>   
> -			for (i = 0; i < adev->vcn.inst[ring->me].num_enc_rings; ++i)
> -				fences += amdgpu_fence_count_emitted(&adev->vcn.inst[ring->me].ring_enc[i]);
> +			for (i = 0; i < vcn_inst->num_enc_rings; ++i)
> +				fences += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[i]);
>   
> -			if (fences || atomic_read(&adev->vcn.inst[ring->me].dpg_enc_submission_cnt))
> +			if (fences || atomic_read(&vcn_inst->dpg_enc_submission_cnt))
>   				new_state.fw_based = VCN_DPG_STATE__PAUSE;
>   			else
>   				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
>   		}
>   
> -		adev->vcn.inst[ring->me].pause_dpg_mode(&adev->vcn.inst[ring->me], &new_state);
> +		vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
>   	}
> -	mutex_unlock(&adev->vcn.inst[ring->me].vcn_pg_lock);
> +	mutex_unlock(&vcn_inst->vcn_pg_lock);
>   }
>   
>   void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
--------------HWCzuTGaLja1gt0S7vgWin7u
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-31 11:57, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250131165741.1798488-33-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">Use the vcn instance power gating callbacks rather than
the IP powergating callback.  This limits power gating to
only the instance in use rather than all of the instances.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody"><span data-markjs="true" class="mark5quw442ch" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span></span>:
          Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="2">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></p>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20250131165741.1798488-33-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 27 ++++++++++++-------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index a2250747a7c81..81bfd8a9d8268 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -424,8 +424,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	fences += fence[i];
 
 	if (!fences &amp;&amp; !atomic_read(&amp;vcn_inst-&gt;total_submission_cnt)) {
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-						       AMD_PG_STATE_GATE);
+		vcn_inst-&gt;set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 						    false);
 		if (r)
@@ -438,45 +437,45 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring-&gt;adev;
+	struct amdgpu_vcn_inst *vcn_inst = &amp;adev-&gt;vcn.inst[ring-&gt;me];
 	int r = 0;
 
-	atomic_inc(&amp;adev-&gt;vcn.inst[ring-&gt;me].total_submission_cnt);
+	atomic_inc(&amp;vcn_inst-&gt;total_submission_cnt);
 
-	if (!cancel_delayed_work_sync(&amp;adev-&gt;vcn.inst[ring-&gt;me].idle_work)) {
+	if (!cancel_delayed_work_sync(&amp;vcn_inst-&gt;idle_work)) {
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 				true);
 		if (r)
 			dev_warn(adev-&gt;dev, &quot;(%d) failed to switch to video power profile mode\n&quot;, r);
 	}
 
-	mutex_lock(&amp;adev-&gt;vcn.inst[ring-&gt;me].vcn_pg_lock);
-	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-					       AMD_PG_STATE_UNGATE);
+	mutex_lock(&amp;vcn_inst-&gt;vcn_pg_lock);
+	vcn_inst-&gt;set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
 
 	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG &amp;&amp;
-	    !adev-&gt;vcn.inst[ring-&gt;me].using_unified_queue) {
+	    !vcn_inst-&gt;using_unified_queue) {
 		struct dpg_pause_state new_state;
 
 		if (ring-&gt;funcs-&gt;type == AMDGPU_RING_TYPE_VCN_ENC) {
-			atomic_inc(&amp;adev-&gt;vcn.inst[ring-&gt;me].dpg_enc_submission_cnt);
+			atomic_inc(&amp;vcn_inst-&gt;dpg_enc_submission_cnt);
 			new_state.fw_based = VCN_DPG_STATE__PAUSE;
 		} else {
 			unsigned int fences = 0;
 			unsigned int i;
 
-			for (i = 0; i &lt; adev-&gt;vcn.inst[ring-&gt;me].num_enc_rings; ++i)
-				fences += amdgpu_fence_count_emitted(&amp;adev-&gt;vcn.inst[ring-&gt;me].ring_enc[i]);
+			for (i = 0; i &lt; vcn_inst-&gt;num_enc_rings; ++i)
+				fences += amdgpu_fence_count_emitted(&amp;vcn_inst-&gt;ring_enc[i]);
 
-			if (fences || atomic_read(&amp;adev-&gt;vcn.inst[ring-&gt;me].dpg_enc_submission_cnt))
+			if (fences || atomic_read(&amp;vcn_inst-&gt;dpg_enc_submission_cnt))
 				new_state.fw_based = VCN_DPG_STATE__PAUSE;
 			else
 				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
 		}
 
-		adev-&gt;vcn.inst[ring-&gt;me].pause_dpg_mode(&amp;adev-&gt;vcn.inst[ring-&gt;me], &amp;new_state);
+		vcn_inst-&gt;pause_dpg_mode(vcn_inst, &amp;new_state);
 	}
-	mutex_unlock(&amp;adev-&gt;vcn.inst[ring-&gt;me].vcn_pg_lock);
+	mutex_unlock(&amp;vcn_inst-&gt;vcn_pg_lock);
 }
 
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
</pre>
    </blockquote>
  </body>
</html>

--------------HWCzuTGaLja1gt0S7vgWin7u--
