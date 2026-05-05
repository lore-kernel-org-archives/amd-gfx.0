Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D83CD3427
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2026 15:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1CA810EB5F;
	Tue,  5 May 2026 15:36:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HIKjZXDK";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013009.outbound.protection.outlook.com
 [40.107.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54D5C10EB67
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2026 15:36:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0ZyQMzFbOiMgdUbyqscGhyT9iz//gox1IlIKZJYvKMqyLBpalTN3wOATVdyw+sT7DI+LjA0+bM8+vtm+IrMSzEPErtdjpzHjnVOMSmbBf90MFNLpQkgLfhP6I8cxiM3KHv4UComaJlblIVTPafuuao5IbHmABflG4dvx05mzv/h3GYg6JLvJIUfkKYZVJXkWWgmCMokiNAeSh0FYJqXr2asbgGoNmMNQXPWLKWf6l0bQsYeHa+XDeL9fU3/oq3UY/AjSHW3OA8h2bZgJqCV7jD0jFxB/fsIOzI5dKnkk2h+in6Rfmw4a5ZWyXJgyUR8Q3lCqFjWIZQoMCF3c+2ZjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrWbrEynI1ovbgOlBE7RVpQ0JstdOZozad6WnvGcCb4=;
 b=qYZG1lj4siBguBtSubYtHS8UVAJB/iRM7VZR10aF1XEZbAglGGIKPNWpOxsiHsRKPPz2oGhcC7edb746Sjdyxt9ordNNz8sRm+hIB+XJiuGkNpAJiUsOg7alOC+sXXMlTyd/nJ0dG7pTaXLnC/DtuhQGKOLuoC0rYcOeGROKdLNhcbEBj03ilnf1WsEICpDDyZejmyZAc5+cnYcfZGAmk3iXtWj53Hlhi4ZVmM8/sa4StNvsIsl2R71rUfWZQ8xQaxzyHwPsOLj8aH3fQ+2bM9nAa1wnf5n49eddNcaswx/XY3szCZWjflZVqUd19E53nryfXUf04f29YmNPN+fPlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrWbrEynI1ovbgOlBE7RVpQ0JstdOZozad6WnvGcCb4=;
 b=HIKjZXDKAZ/HPVCZagJts0PSeusl2t6z34pHnTGh6lwfpqQy0+8EDwzu43/R4JQ9WvUZNAjzNe/lXMnbjODgUEe3YHUNDSZDFjeR9vOmEbuDZrn++CXNnV4tX4SJ2H2ZR8XKn0/oaU6aXPoZIg8Bt6CdbCwZozq4tCsJLl6Th/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by IA0PR12MB7724.namprd12.prod.outlook.com (2603:10b6:208:430::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 15:36:44 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 15:36:44 +0000
Message-ID: <8b617d99-7cfd-4637-997a-dd561d372730@amd.com>
Date: Tue, 5 May 2026 11:36:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/21] drm/amd/display: Tie FRL programming together in
 HWSS
To: Dyllan Kobal <dyllan@dyllankobal.com>, amd-gfx@lists.freedesktop.org
References: <20260502140825.705534-1-dyllan@dyllankobal.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260502140825.705534-1-dyllan@dyllankobal.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0152.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::25) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|IA0PR12MB7724:EE_
X-MS-Office365-Filtering-Correlation-Id: edeeaffe-4c1c-4697-ab73-08deaabc1c7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 6QsFXoTI34k8BH9kCnybEDSqmCs6jlFSFTO+kgAaTLPYdwA3do/NrIT1pNa4vKV2njE/Ea9v/DNVB3VW3VWEdLXFCGBUXLprl+ZlodiG1ga2UZEut6yDpFpiOyI7u66G7TS1Y7VDYi8pig3DffAihJIRK3BvLWRLqAZxF/TSI4uxRuumknq6Iz79w8QVIaLsF07yWybqrdJ+SaPUe7+tkQ2cOy3DUEf19NhTHB8797FHOqMK/H++pZcUNYwG0awQ3M3lKGJeI46iinUp6M4EdAdk4zuUV8e/iQbT6Lisb+xcMT20UdkGB7T/cRKy1k9WpePG5aqsUv3yfUQ+vLqZMoDiNgGdUqu1hd8vQMtE67ZSgB0PGYGPKTGXazYwIumKFpQ6yAViHfxzNh84oq3OE8mq2246OzTVvk8zYl9XagvB6Mtf01w4/JoYkhEnvZsyoiy2+ce7O4hiVRlf5jYqakrIqeTN2/pdnOdg4lHmpgcPwffwhOQ2voMvdWI0m3epIleuFoxkIyoL19ybExjCemgpAiUJ/0ZbKjrfTdg6dKZESB/20qWMLpKx7fSCX5IRMmgaaRwBTNew/ls87UM6+xcxTGM1IyQnH949NIT6og01d8FTrOp6MHfS0n7rgI3SkMvqmjMKivNJDZBmMibHUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkM1WHlua3ZRRkxkRUZDRW9oYkhxY3dBeGZCSzZxL2o2ZWxZT1RVU1NHVWY0?=
 =?utf-8?B?cHFVMkM1UTVpSTdpSEtnVVQ5RnkwR3hqQmloUVZ6aExhajVLOU8xd2pqRGNY?=
 =?utf-8?B?NmtLaFZ6aDBQWCtOQ21ZUmIvN1VZUElQZVVrNmdJQ1p4NGNtU1EyWmZ1dTE4?=
 =?utf-8?B?UWhxSHYvSitVZUZnQ1g0N0prYTlpUzB3dGI0S2p4UHhjYU5LODNlemVsSExN?=
 =?utf-8?B?d2xlYVJiTWdkcXZkQjNPdlQxUU1MUnVNVnJpZFRBZXZVV2FCRW9ZL29RS0Jl?=
 =?utf-8?B?dmQ1ME96MkFuQkZWdERRVTVHN0kyQmJzU0g3S2cvZmNYOWtoTzNCRk9KeStK?=
 =?utf-8?B?MGx0ZjRqYlNkWWVLVENDdGZDa0FLQTBXSDhaNGxCb3BTTmdSeEtVQWxoZkdn?=
 =?utf-8?B?TmxEMUk5L1ZuTXBSRVJ3R2tkK1pTQ040S20rVm8rek1lQUMzUHkrb2E5VzZJ?=
 =?utf-8?B?V2R0bGt3aXp4NUptWVhYcUdpd2Q4Qmw3dXZPWFk5VW5WNzFCZmlxRnRTK0ox?=
 =?utf-8?B?UGM4SUJDcDBqSmFHN3N6b2pGaXgwdC9GQURySnAzRVJEbWRtSjlpSHBjSElJ?=
 =?utf-8?B?RXlvamtFc3pHNU9aa3lwUUdoWnRVRWx6QUE3Zmc0UHVCT0s5Tk4zMEpPVUEr?=
 =?utf-8?B?cVRJQk1MS2NJOGFoL3ZXNW44ajlkOHNVSEJNblU1dGlRNGlNd1lIeGc5VEhD?=
 =?utf-8?B?dFZLMy8wSFVTMlE5ZTZqWlliVDRDNUszMGZhTEJ2dTF4azN6YWpjTCsvbWhV?=
 =?utf-8?B?bDRMUTc2N3NJTnN3RXREMWczblNTdVVHaGU5Q01RVE1QUUkvK3QvN3ZDdFlH?=
 =?utf-8?B?MUUrREFVVis3bVZVZXc5TzBHbmMraXU2cWRtcnJUUG1Ganc3YVNlaXpKQ3FH?=
 =?utf-8?B?ZEc4K1dOM3JMUFRUTjFZRGg5NDB2RXlaWXlVRnA2S0loZ0hiYUVkTnJGVXpu?=
 =?utf-8?B?ek5qamRCcE5iRnhwY21wWUlBSDl5czhLZjJpTDMyRGQ0K2lLbkFKbTY5eTVD?=
 =?utf-8?B?UGhxWnNnak1jaEtmNlBIZU9WYnJUc1ZoL3IvMzIwd01RaGJZQWpJdzYzc1lX?=
 =?utf-8?B?OGtWMFNLK2F6d2tvZkFxemwySEhidTNjNEpjby9lSkxTaERFT3lhM0t6S1NN?=
 =?utf-8?B?OUNEVFdCWEY4NFZvN2czdUFTQU5rZnJGVzVSQklxQkwraVNxcnlTWDk5SnlF?=
 =?utf-8?B?dGdGa2MydzcyZjd3OUVWb3d2djNQVWh6dy9RWThwSEE2NFJCSkRBWFpqQVU2?=
 =?utf-8?B?T2ZhbkdDUGpxaXcyOEREN3BuSlp6MnQ0ZzlFQm1vMWE4TkNDa0xiNEYwclZ5?=
 =?utf-8?B?UDJ1Z1dhaytLSTVZd25NT3VlNnhFSHhlc2x4NEsvdm53azRSU083UThhUjNv?=
 =?utf-8?B?U3RvMDJ4dWYwN0ZiNFp5L0hncXNXRi91cGtldFlRTmtldzNTdjBiOU9tZkU2?=
 =?utf-8?B?bVZZbm14enozMmFKRXJPR2VPbFlDYkdJN2IrU25TVkNKWVFZVXlOUktMS0Zp?=
 =?utf-8?B?WGNFMG92NEpVQ2pLTXREczZVWHF4UVc2TU42MkxCZDFZRHpucXdtTHlaVm1k?=
 =?utf-8?B?VTBuTTd2a3dZVFV2bXozRGhXQlFhbEUrMmVuZFJWS1pUeEJzN01HYTNVR0t5?=
 =?utf-8?B?Y0czd1JmZVRpNU8xNmlKV0ZZbHVtekRMS1VOYzJGZ2dKWXBkOFJFSE0vQ2VI?=
 =?utf-8?B?T0JycFY2TGlIM2h1RGlaMGI3MmlaalROOVdFTEZqTG9Ybm1COFBDYmJTOWQy?=
 =?utf-8?B?algwMXdpWTNWNEFLbllvOU9sT01rWXFHZVFMWENxcll3M0FCSjIxTXl2ZXJw?=
 =?utf-8?B?aGdCYlFFUnFZUGVqU2NqazN5elByTHN5WEpZNkk4T25MMzlhNmxVeEY4MW9j?=
 =?utf-8?B?NFh3cmFHK25kcUdTR2EvYXVFNnlsZ3JmWDdoRFFSSXVNdm1hVEdhRHBXV0o2?=
 =?utf-8?B?WE1aUitnSUNkbUNpeitBbzU4MlpoV3IyQ2l6YmZQalllOU41U3J3QmJyYUx2?=
 =?utf-8?B?WXhKR1kzd0JHS0x1N2hSSEtTVTlRL3RyRXI0ajJlL1F5b25zUmVaL1ZKbTRI?=
 =?utf-8?B?MGk0V3ZjT282UGhPM2RwODlLT2haVXZzRDMxZHlpMFB0ZTdYLzIxMmRtTEFp?=
 =?utf-8?B?ZVJrSWM5T2hsbHJiTTN1NVZ1OUFWVUpKLzlOWXZ6ZlBRM1BrOEt3aWliN1Z3?=
 =?utf-8?B?VzI0SVpsSytKZFArS2V6TDJwd3Z2c2VwOVoydjNOd3ZDWW9rSThDM2pVTVNP?=
 =?utf-8?B?QUZ4R01BRlhoZmZKc205NlMvN0ZmZWZoMXpXY2dLSGl2cWRZNEZ6WFAycGpD?=
 =?utf-8?B?WmRnWWNXK2wxVyszdUZ2b2lFQ21qYWJTV0RpZ1RtWjZ3VGtUQUQ2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edeeaffe-4c1c-4697-ab73-08deaabc1c7e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 15:36:44.3459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YrAlzx0iweFZ6DGKnl4BZ8QFAXiX+QFfCAJIbLiMN8v+0bFkdB9H7i5FTaMP9C5AdP+xPNthC0aCVRW2qGNU7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7724
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

Thanks for your fix, Dyllan, and for giving the series a spin.

Would you mind if I simply picked up your patch from https://gitlab.freedesktop.org/dyllan500/linux/-/commit/560a1b22e4f764b8325e17f1d8f6dbbfd008e409 when I merge the series?

Harry

On 2026-05-02 10:08, Dyllan Kobal wrote:
> [You don't often get email from dyllan@dyllankobal.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Dyllan Kobal <dk@zetier.com>
> 
> Hi Harry, Rodrigo, Jerry,
> 
> Tested this series on Navi 22 (RX 6700 XT class, DCN 3.0.2) with a
> Sony Bravia 8 II as the HDMI sink. Hit a NULL deref at amdgpu probe:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   #PF: supervisor instruction fetch in kernel mode
>   Oops: Oops: 0010 [#1] SMP NOPTI
>   CPU: 14 UID: 0 PID: 568 Comm: (udev-worker) Not tainted 6.19.0+
>   RIP: 0010:0x0
>   Call Trace:
>    <TASK>
>    hdmi_frl_perform_link_training_with_fallback+0x64/0x110 [amdgpu]
>    hdmi_frl_verify_link_cap+0x24e/0x5d0 [amdgpu]
>    link_detect+0x4b4/0x550 [amdgpu]
>    amdgpu_dm_initialize_drm_device+0x73f/0xb21 [amdgpu]
>    amdgpu_dm_init.cold+0x734/0x86c [amdgpu]
>    dm_hw_init+0x1b/0x90 [amdgpu]
>    amdgpu_device_ip_init+0x690/0x7fe [amdgpu]
>    amdgpu_device_init.cold+0x460/0x781 [amdgpu]
>    amdgpu_driver_load_kms+0x19/0x80 [amdgpu]
>    amdgpu_pci_probe+0x19b/0x550 [amdgpu]
> 
> Cause: this patch wires .setup_hdmi_frl_link into the dcn314, dcn32,
> dcn35, dcn351, dcn401 and dcn42 hwss tables, but not into dcn30's.
> The dcn30 family (dcn30/302/303 — Navi 21/22/23) does get FRL
> resource creation per patches 16/17, so hdmi_frl_verify_link_cap()
> runs on these ASICs and dispatches through the NULL
> hwss.setup_hdmi_frl_link inside hdmi_frl_perform_link_training_with_fallback().
> amdgpu probe is fatally aborted with no display.
> 
> Fix locally:
> 
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
> @@ -105,6 +105,7 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
>         .enable_tmds_link_output = dce110_enable_tmds_link_output,
>         .enable_dp_link_output = dce110_enable_dp_link_output,
>         .disable_link_output = dce110_disable_link_output,
> +       .setup_hdmi_frl_link = dcn30_setup_hdmi_frl_link,
>         .set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
>         .get_dcc_en_bits = dcn10_get_dcc_en_bits,
>         .update_visual_confirm_color = dcn10_update_visual_confirm_color,
> 
> With that one-line fix folded in, the Bravia comes up at 4K@120Hz
> 10bpc RGB native FRL on cold boot. Live register state confirms the
> HPO HDMI block is what is driving the link, not legacy TMDS:
> 
>   - All legacy DIG[0-5] show DIG_BE_EN_CNTL.DIG_ENABLE = 0
>   - All legacy SYMCLK[A-E] show CLOCK_ENABLE = 0
>   - DIG0_HDMI_CONTROL.HDMI_DATA_SCRAMBLE_EN = 0
>     (HDMI 2.0 TMDS scramble path is provably idle)
>   - HPO_TOP_CLOCK_CONTROL.HPO_HDMISTREAMCLK_GATE_DIS = 1
>     (HPO HDMI stream clock is forced on)
>   - PHYASYMCLK_CLOCK_CNTL.PHYASYMCLK_FORCE_EN = 1,
>     PHYASYMCLK_FORCE_SRC_SEL = 1 (FRL signaling source selected)
> 
> Worth noting: the public dcn_3_0_2 ASIC register headers in tree do
> not expose any of the HPO HDMI / HDMI_FRL_ENC / HDMI_LINK_ENC
> register offsets — they only define HPO_HDMISTREAMCLK_GATE_DIS as a
> single bit field inside HPO_TOP_CLOCK_CONTROL. Despite that, the
> silicon clearly decodes the rest of the block (the relative offsets
> from dcn_3_1_2 evidently land at usable addresses on dcn_3_0_2).
> This is the first time, to my knowledge, that native HDMI 2.1 FRL
> has been demonstrated working on a Navi 22-class card on Linux.
> 
> Happy to retest a v2 if you fold the fix in.
> 
> Reported-by: Dyllan Kobal <dk@zetier.com>
> Tested-by: Dyllan Kobal <dk@zetier.com>  # Navi 22 + Bravia 8 II, 4K@120 10bpc RGB
> 
> Thanks,
> -Dyllan
> 

