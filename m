Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9A2D6004C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 07:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0155310E127;
	Tue, 19 Nov 2024 07:47:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HeiPo0lS";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D840410E5E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 07:47:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFLhlKSUNyej3fpiLP0SVxjJ07FfH/ZSj3ETXnnVPxNRMTFwKWE33l7DHYO9DiVJtvkUlA5k3ZU5xiFUD2QxUjcP8LSMUeZAFMAAwWA7hGfrtk30VJqukGH/zJ00rZ+0NrKym9X2kG8oQnuclHADpkxLiTByk7f6iTyEwN6UAqTPlal71b5Coaue3kleovrP6L3a+vdKb+GcMuI9rvZO1vJ7tZar1dvWmcn/AeBjT1G/RwRdtjbP9841ma5RrmwZ+B4ArHxHeJvXDgkrepzahF3qrq2F3RXlhLxi0z0XJfaJhrK+fv/R+ieXo8e7+S14MSRxNTK8Er2/r4T8ifp4cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VnCkwERyZ5i4ThEQqOkyNzlRYJOfk6Kq1Uh41IFaQc=;
 b=waGs54UI9odJbE8nVsP3aVGPhFx+PVpbnGNbgvp5XbXHvNhXdmrk+avmDIOh/R7wOltEg4XpboqduvZ8kuLZ2w0aVSAvsmc4Fy6m63lkZdZ/gBw9t+qFWUGS2WDF3n+vxLXlpyXcDduCBXERLlr0w+F4lzPPlmIxwi9W4g8qlmWU/48rZmBa18bHxSFOV3KJ/NELXofktcYRhziAb5aZ+NsXCfOjms79Z0ghEjRoZqoHEnx6lbNb54i4p4ysWTlUytUR4dY5yC+q5orZtB0pTzE/Rnzexv7P2JJXs/LWc0EkvT2AsKdeUu7Ud56esOqaJM/jikmJgyJ9LbnSwz5XTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VnCkwERyZ5i4ThEQqOkyNzlRYJOfk6Kq1Uh41IFaQc=;
 b=HeiPo0lSoHz01+gfQsxcD6/X3VIP7R6CjWKucKgQfBP90fhSYNId1icSBo568YIgcrZjPf8NKA/rUTeM+p9vleABpdEX3j00WQ1IHnAud4kUnETqduK9AFGcQLjc6iGls4UGf8XbE6fjbRQfojqyBpbX2qLVlgDv92fjJsPbouE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB8132.namprd12.prod.outlook.com (2603:10b6:806:321::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.23; Tue, 19 Nov 2024 07:47:25 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8182.013; Tue, 19 Nov 2024
 07:47:25 +0000
Message-ID: <ce61f30a-42de-4927-9484-1f3a03249a03@amd.com>
Date: Tue, 19 Nov 2024 13:17:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/pm: disable pcie speed switching on Intel
 platform for smu v14.0.2/3
To: Kenneth Feng <kenneth.feng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241119063601.437225-1-kenneth.feng@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241119063601.437225-1-kenneth.feng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::20) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 23e43cc7-97ba-4006-3507-08dd086e688b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFR0bXphdzY5b1l6U2RyMFREUHlFYjZsK01VYjJ5U09IQVJoMnhTb29PV2g5?=
 =?utf-8?B?NnVOMFNGeHUya016dWNQakp1VHZ3ODdNN3daNFFaWHpyNUIyQVZjTnRxWGhz?=
 =?utf-8?B?U2tMS29uczRGd1BlVjhIRThiTjd3RDFseU9mdGxjeDY3NXFZeE10RUpGZ0Nn?=
 =?utf-8?B?YTdnRmsyb3lqSWsyTjkvVlE0RTE2K3NqZnNicGNLenY2SS9ySHphcnNkMnZD?=
 =?utf-8?B?QzhReURkZFZ5cldMaEpyeXlva2poaWF4YkRzSEc2YkM5NWlQekg4Vm40OU9G?=
 =?utf-8?B?T0xxVHRuZUVPV2tDQVp0ZTR1cnRHWGpRblhaTjB4SU9QOG5KT0Y2Z2tMdUtZ?=
 =?utf-8?B?VDNCeVU5WnNpSkNmaXRiMjBqTlhuTlBqNEdMTzJYU1hzQzBmQ2FHTE1IRmt4?=
 =?utf-8?B?MTk5cklOcFVIZm5NOGZFenhmRlBHc0RuaWdjQ3hoSXdTUzhYeWFWalorbEY2?=
 =?utf-8?B?L1lYS3BqZEdxWDdCMS9sd1VKVGxFR2xoM1k1Rk43OFVkOVVuNk9OTkIzRkto?=
 =?utf-8?B?ZERLQkhodVB4YVBXdnk5cUZORVRNN1dqNCtMY1R2ZFE2QnJoUU1QejA2L1hk?=
 =?utf-8?B?R01QOU4wWmhnaW9idnVOL3RGaTRMMXdLZHpWWlo3NW1ZdWNkWDNZZkZraXg2?=
 =?utf-8?B?N3pKWkFBVGF3NGFoMGZPMkwyNWFFQ0h5a0RGTjNxbzZnRkRIQmFJUlFKdFBi?=
 =?utf-8?B?OTlWYXVNc3FoeGpXR0drMEp3Rk1ReWFpc0E3U3VsVUlnVlJBZkE1N0RveGJI?=
 =?utf-8?B?YlR4M3JzTGNkS1FlUCszQ3hwRm5lK2l5Yzg0QjlFWW5QYWRWYzUrK3F6MWth?=
 =?utf-8?B?bmxUWnRKdEQzUVpNbjVPaEd5YnRRSFZyUkxUZTQ0TVRmWVhzT2dTQURKN1dE?=
 =?utf-8?B?SDZuVU51U3ZKZTFNbTZ5MUZ6azJVWHYyMWswd3Y3VlFYSFR4ZU9tQWJWV0RY?=
 =?utf-8?B?RzQrMk5IaUd5QUpUREFvZysxM0pVNG9aV0c4L1ZRWXg2VWQ5MkRlcGJvY0VU?=
 =?utf-8?B?Z3ExLzJJQlQ5UG1yay9yaVlzSGk4N20zQVhDRklmNGdHYnlLQ2JGaStNSis1?=
 =?utf-8?B?ZFM0YlFxM1N4b05WNVJXb3dvbVJaRjlYT1ZNNjdlQVgydVNBUU5sVjU5OHRy?=
 =?utf-8?B?YTJZNE5SQTZKY0haTVdZZTdmUGJqY0FxdFNHeVIxRFdzdjd0RThhNzdZTksw?=
 =?utf-8?B?UjlTZkhxSGVtb3pwYThtNnBLb0xCRTJuQW92ZXZOME5iUTJjdis2V1hDWW1Y?=
 =?utf-8?B?ZDA2TUFDREpIeVdjTlhIZnJabnF6bjRlVGRjTThpN1hrU2FUSXp5OWM1aXE5?=
 =?utf-8?B?UTkzSjcvRDNVYnNoMUpOb1d6NUxWZUU2L3JqV2Rsek1INjJQaVJVV0R0bC9s?=
 =?utf-8?B?Z1RpVVFWd01PenhXK0g3VVprdXloOEVLcUxYbE8yWFAxTlE2dGgxQlU0cXRQ?=
 =?utf-8?B?QWpBWkM2NW1KUFlxWldCcU41cjFTSHo5VmZyZ0NzRWlDRjYveExncnI3Y2h3?=
 =?utf-8?B?bnRDQVIrVWpjVEJLL2p2RWd1VlZDM0lMdm4xS25RR0lSaERFTktaUFJhV2F3?=
 =?utf-8?B?QnpDVVBsNHI4WjdDL09QV1haMk9DU3MyaHRFOTZ5QXNFUFdOcnJweFkrc1Va?=
 =?utf-8?B?RGNCS0UxQzU3ZUNrb0JxRlJ1N21OVDRiQkhJRm9MY2ZVejlZcGhUbkxxZG5E?=
 =?utf-8?B?a3Z0VnNCb1Z5eHN6dDNhQytlb2doMUdCamJXSGE5OHhPOFdNWi9KRGpsZUdj?=
 =?utf-8?Q?ePqNPT8/qOm55C7i9IpZ4J/O/GQ3ED4OpES//JJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmN4OEJrYU00M0k0NjY0T2QvYzFBTEh6NGdCSitmSHJPbFA4TmZTYmdmVnRO?=
 =?utf-8?B?N0xZZ3ZPWDh6aDE1cFdMWEZvRXpySXlMb2U0cFd4Q2tpTWhPd2FKb1ovdExF?=
 =?utf-8?B?bW0wNmtOQ245Vm9uNm91REtpNm9mdGoxeFV3UkdlOG5CdURWYmxZV2dwSnVX?=
 =?utf-8?B?NlhwTFhoelNERUtuelNZY09WTlRVRDdFRjBNUU1yWXZSSWh3WGQvdTEwYmxO?=
 =?utf-8?B?MWEvNmRDOWV4QjJERHZpeHc1SnQvUzJhWGQvQnNRSTI4b2hOQXVKbFRxNnBs?=
 =?utf-8?B?RXdyaURKYXYycGdaMEVFeHlaY0paQllyMGxqc1F1MWUrUXgyaHptL3pJbWdL?=
 =?utf-8?B?RXhoL1RYSjFqK3NrV21JQ3lCYmx6aVlzR0tJU25aeVZDQ093SVozdDFoSEIw?=
 =?utf-8?B?NGthb0kwbTNFSEJNcVkzeVdXcm5CaVJGZ2dhaEgwdnVBZS9LbW1ZSll2bGR0?=
 =?utf-8?B?WUtTd1BPSWIxRTJGS2FKZmdSTlRuYWVnVjlyMTJ0aHAxNUhuUGQ4WER0SnFG?=
 =?utf-8?B?K1FMeDdEeHFrdkZHTG9kc0Z6eXdaVmZHRkZGS010KzI0R1B3TEF3SzkwT1Bt?=
 =?utf-8?B?dmRGMms0YUlIb21tT3lCYTF3QjI5RDFpQm9uZkJieFM3R2t2SzYwSU13SnhO?=
 =?utf-8?B?bEpxVEpTTGNFa1lPWDVGaUJETEZ0WjdnRWZPSUJ0MWpCQmF1Z0wyYzdWWnBa?=
 =?utf-8?B?ZDc5NUlYUEExZkkzZkR1OVVSYnA4N04vbjUvMTRMUGhuQm43dy9keGdGaFdn?=
 =?utf-8?B?OWNrck9HdUdacWNBL3BZRXhRbzI2eGRFYWtHdzg1bnEwNVNEOWtBeFg1SXd5?=
 =?utf-8?B?c0VvenZMOGEybnQzSnFUbXRzdG1JdkxBTHNyeUJ1aldPbE1jZnh2NDVTR3lu?=
 =?utf-8?B?RU92VFlxR005ZDMwUU1LZkdxcTRsSVZNaTZhT3QwK2pDSzZzbFRGbThZajMz?=
 =?utf-8?B?ZFVHdEw4cDZkOEhXUGxJVmxSejQzTFowRDNrcENpdG45VTFGNGVwNkFvWTZB?=
 =?utf-8?B?L1NXbjFyYWJZUmlodGlLdVR4VmZBSWs4ZzFjdXNlOFFMN2k3MmV3SHhUcHpZ?=
 =?utf-8?B?MlZxSUdMVTIxTG5PcHMvOWRkY0VlQWhwelhTL2xacW4vNHlhb2JFYUhRUFY3?=
 =?utf-8?B?UFdKYXo3aENIczcyL3E0VXFLNy9FRFZvZE5KbmxhYm1RLy9WY1Z6YXB4RnN6?=
 =?utf-8?B?enl6TnRMQ3R4RGFjZVBvdXFCTHczTmhnYnFFSTltQW5JaUpHQU9CYUNBUk5o?=
 =?utf-8?B?MXpyWk1NZHF2UzhKK2xyWUQwWTZhVzZ5RjFRMmozV1J2U0k0VnZ6RHVldExW?=
 =?utf-8?B?UWtsVjJRQWdmTndzY0k0RG15TkhwTkJrS2QvYTQwUnl0MWM4WlNBcFRJZVA2?=
 =?utf-8?B?MHhaMjZpdnNlbDVId1MrSXFpaXB0SFo1eFRiWHpwdENCNXhudkRiamh6SUpm?=
 =?utf-8?B?TXdFNkxtUTdkQkN0bFBRcmV6S1lhVjVWa0JMUjNocURMODRJMHppTG5QMWkw?=
 =?utf-8?B?MEs1UmNDNGtqN3JkbHRremMvWWx6WG5sL1JWOXlabmNieGo5ditwWCtVM0xn?=
 =?utf-8?B?bEg5amFmL1NDUDlKVzhIM1pSS3Z5cVNINkV1eHRycDFuZVI5QUNjNVFOSlZu?=
 =?utf-8?B?aVhGeERSWXEvc1E5WXJLS2p0UTcxQ3ZEc29XWEtkdmdKRjhSZnpXdXN1ajhO?=
 =?utf-8?B?WTg3a1Q5dC83a203MlZsVWF2eTBCUVNsQTBXbGkrQmptU3ErcWlObzQ0UzJ3?=
 =?utf-8?B?VnowMXkrWlVTdGNlaEU0Nk1sajhaMGJxTWRFZk1sc1AxV0MrN3JHSGM3MmtS?=
 =?utf-8?B?ZHpRSXJ4NXRySnVoUkU5djFRQ0RCam9FRUNjcWx6M2VSZEU4b3FRUlBvNnd5?=
 =?utf-8?B?R3lUZ1U2QnZDRktXWjF5M0RHaE1XSllxb1ZlbHNXQ2RrVG1QL05QaTNHbXZy?=
 =?utf-8?B?T3BaOFFtOVVhUzVmcGNRWnFYZWZEeC9zN01oeFFMRUJPZEI4aVRyeXZORk9S?=
 =?utf-8?B?SkVrdUxreTFncks4Tm42QUlBdE0vWDl5dUZxQjhGY2NUS2tTaHByRW42RzdU?=
 =?utf-8?B?Z05pN1dSTWlVWGI0RnNjcWxJVUVSbzRZcnhucSsraHYyQlcrUWZ4aEVXT3Qw?=
 =?utf-8?Q?CqbPJyAk2/NJXkGEbKSVfc8gj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e43cc7-97ba-4006-3507-08dd086e688b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 07:47:25.3260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ip40rptQmeRHgnuRzxZQgGzqVIDUtQN8GraNVDegt1eIhHlyz5QEXN3fZVv8eoY8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8132
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



On 11/19/2024 12:06 PM, Kenneth Feng wrote:
> disable pcie speed switching on Intel platform for smu v14.0.2/3
> based on Intel's requirement.
> v2: align the setting with smu v13.
> 
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>

Need to revisit later for keeping common logic at one place.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
> ---
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 26 ++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 59b369eff30f..342eabd08f0d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -1463,15 +1463,35 @@ static int smu_v14_0_2_update_pcie_parameters(struct smu_context *smu,
>  	struct smu_14_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
>  	struct smu_14_0_pcie_table *pcie_table =
>  				&dpm_context->dpm_tables.pcie_table;
> +	int num_of_levels = pcie_table->num_of_link_levels;
>  	uint32_t smu_pcie_arg;
>  	int ret, i;
>  
> -	for (i = 0; i < pcie_table->num_of_link_levels; i++) {
> -		if (pcie_table->pcie_gen[i] > pcie_gen_cap)
> +	if (!num_of_levels)
> +		return 0;
> +
> +	if (!(smu->adev->pm.pp_feature & PP_PCIE_DPM_MASK)) {
> +		if (pcie_table->pcie_gen[num_of_levels - 1] < pcie_gen_cap)
> +			pcie_gen_cap = pcie_table->pcie_gen[num_of_levels - 1];
> +
> +		if (pcie_table->pcie_lane[num_of_levels - 1] < pcie_width_cap)
> +			pcie_width_cap = pcie_table->pcie_lane[num_of_levels - 1];
> +
> +		/* Force all levels to use the same settings */
> +		for (i = 0; i < num_of_levels; i++) {
>  			pcie_table->pcie_gen[i] = pcie_gen_cap;
> -		if (pcie_table->pcie_lane[i] > pcie_width_cap)
>  			pcie_table->pcie_lane[i] = pcie_width_cap;
> +		}
> +	} else {
> +		for (i = 0; i < num_of_levels; i++) {
> +			if (pcie_table->pcie_gen[i] > pcie_gen_cap)
> +				pcie_table->pcie_gen[i] = pcie_gen_cap;
> +			if (pcie_table->pcie_lane[i] > pcie_width_cap)
> +				pcie_table->pcie_lane[i] = pcie_width_cap;
> +		}
> +	}
>  
> +	for (i = 0; i < num_of_levels; i++) {
>  		smu_pcie_arg = i << 16;
>  		smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
>  		smu_pcie_arg |= pcie_table->pcie_lane[i];
