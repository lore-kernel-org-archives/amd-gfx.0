Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7685C6FD1F
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Apr 2024 10:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38EED10FC19;
	Tue,  2 Apr 2024 10:30:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="20qewOfO";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2115.outbound.protection.outlook.com [40.107.220.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E1AB10FC19
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Apr 2024 10:30:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nx+31Q2OODj9pXO9YX/s/1j357IBfa2UJL+U8/Vc25XsDuzrvjNS9jVIQtQVolD5aCkY5i8FBeuKAIrUGvktIzW0IDpBWunvUbbLLR/IcaD0C2926d3Y1e/G4JgP+u3/CUnnFi4Nn6EVNqf0QrRGj4ZzyijB2Y5YbilgQAUdn1HwuUtR88ne/wp2+q07H69SIfg0mdU8rRSkIsmUoUlMkVqIJOT0EkBZDk7aNEAD4Prv/NTdyGvm/O7xuZY/1AJjRL+eTxkODYQ1We04t0rNAcf6ZnSn7+uc6GKsWKTDVFfPwXFJFRVcdV0ASOQtXF9hyTyIMnT1ve4pWO+/wsRF8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTOr/9ypRJmjul+9XW7YwFSafSthT09ELDomATkYh9U=;
 b=dsGa96S/X3PZeYPfL56SypCL61mapIU5o5/A0l+AVZahummMFKIa8GUF837ChK1/oy/fl4IzPhH4iWfwek/tcmWdi15sm6UgVpOR5TXK7vzdkhR92GCzw0ElbxZnq2DFRRe5ZlEeesN+HH28l0CL5eCWZDZWrf0X1+ttlw/YmHs+uFqWb7bXLuqsdmSF1ICsIOy16GyVFKozBD8HY4FygLyO7NPU9ztMWgkbCTv2mM86b2U6oDWduReeEUiml49rrFF4LALgDdTtNIeKiuQjU0oIQEuxK4QudukO722k/j7eEkBVjpAOT/CSNbWi6syRrCJnIb6zbo6IbgE2CrdKZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTOr/9ypRJmjul+9XW7YwFSafSthT09ELDomATkYh9U=;
 b=20qewOfOxLrYWa1IexJ7gKX6L68lmuir8s5ZwSnMRo8DmFuMhaJE0q3rR2amuoxbxiNixhaCqxoLD7jrlrgQfyJBfjVb7cm2QmVE4QYZqLvGtACHCdJm347Eu5zxOOOVNgjJ2oPnuO5S2J1oYQXLaigu5MxUc3yRTwnSDCcynZ8=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MW4PR12MB7468.namprd12.prod.outlook.com (2603:10b6:303:212::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 10:30:25 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 10:30:25 +0000
Message-ID: <8aadcc95-3d19-4ae3-9352-04254a878971@amd.com>
Date: Tue, 2 Apr 2024 16:00:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd/pm: Report uclk and sclk limit
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 donald.cheung@amd.com, sepehr.khatir@amd.com, daniel.oliveira@amd.com,
 charis.poag@amd.com, Shuzhou.Liu@amd.com
References: <20240402102244.3374108-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240402102244.3374108-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0178.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::33) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MW4PR12MB7468:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wjsmqhO0NAAnTV3jU5wrt+NIxflHMz57CSYIvYJEtXQR8fKOup36Zk8L2GlLh4OQfg8DesyaWuSuCIq/kyxP5eq7ypsDnX3EeulW0YB+mm9l3mRk0aDqZD+9e3abDSrg4U9zd4TD+e5SupMRIgkLT8FpeZT4AFvgfUjelMYLfecfVNs14cUr4Ww/q2ryJ2yuq6y/avIjZGGZUGkSN32roAHjJ3Hcx5wEEdXolLOl2SsMrMbsyCpSXAd2iA9AKGBKa/2j+zlMj7xy0mNMKzUXORPvpTmROnz5c7QvLee00W5+SXmayWUkgsIanr14lKjOurf5TRTifkxSLs8CH9VagdaqUW9XdSwGd4u6s0Xrnz373OGWBs+lymqWt+C4ifPYfC7JElhFHu7JmJ3zMf+ljQJez0EIGfkFgOdWCbAeqyMwC2I7bUnAkLavziuJvwQDIFWZMsnBCiqEofsqyijNPCkd9zq1OKjP9wciCvj5PXyY94soc3ODaML0wF3UbzHGlRQuOzRT/NcgDqYdonEVAfUHWpf5fsLbXUKRrVZS0Wqvgq4Y8yCgtox6nbZTySiWY4k+zNYAcIFQDHTZ4OyKIDqZkmSGqekai8p7lV5yruhSNHhdmQCbzfRVg/4DqBwfUJHmP2w51hFVaejDtdL8tqxV1OeW9kBXGBz/ZENBTL8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUZiV3JPNngrTnFsMExCOEplSTA3T2l4ZzROdGJSZHQrZDFhQU9MdjZNZmI2?=
 =?utf-8?B?VGZCZlZIbmFIYkkyMmxxVzNDdHRuLzZ4aFlJU1ZYNEcvS0dVbytTSGk4VzVL?=
 =?utf-8?B?OXdWUnJOSXVXQmFET3g1ZmpodVloL0M1bmpMWXRrWEZhMSszeGlTM3BNWWYy?=
 =?utf-8?B?aTgvVGFFbWJwcmFRZ2FSWUNXbVZMQ1hoS21wc2grd1FHR3VGbHlvc2I4K2Mv?=
 =?utf-8?B?NHk5NnNTbnh0TlpwM1Z2RkN4bzBBWVg4ZFdPdDZWeVBhZ2NXVzV1OStKQ0hz?=
 =?utf-8?B?TGk4aExVdmdMaW1rRjY0UGQ5cmgyMXZiZ1B0R3ZpMkdYcDh4NHJhL1dnaXgr?=
 =?utf-8?B?dDhBcjQ2UTdKeTlwUHI2MnBYUnFFZ0RyNDRnMXYxVSs5RmwyMFZmbFIyb0hD?=
 =?utf-8?B?WlZKVSs5YUM2djNNdkRFeUY0WTQwZVZuM05mODlmeWtCSlE1bndjNnNVVk9Y?=
 =?utf-8?B?cytGWkRFZWpEbENObjlheFBOdzlMSzlnTXRnenc1M3BxQ1E4Qkh5WldGeHpq?=
 =?utf-8?B?enJ1eEc3UGFSOTMzckhWVFU1VjFSb2tWZnk4ZGw2bk9WRXdTUXBobXprV0lK?=
 =?utf-8?B?d1BxbWN2aVRsclhUdjhEeDdQN2FrenRranQzUlJsdjhhSkQ0aWVXdjlNMllt?=
 =?utf-8?B?N011REloc25QYjEvWFhmZjJndGl4SjdVSnN5UlNncGFGK2o1MUNXalQrd1hS?=
 =?utf-8?B?WEpCNW1ld0lTeGdZUUNoYmdJdGJaZExwTU00K0FkRzc0NEhyTUg4Z0NKaWM1?=
 =?utf-8?B?SzBZc2QrM25kUXpwcXd0LzJwYWJJaVZBYWY5NlhlSFBwTGlWVXdEYk0vaDVq?=
 =?utf-8?B?eVFrNlFCWUExZk4wMVNFVEdTSVpRTDR1eTFJNis4d0sxRSs3aDVyNDdJYzQ2?=
 =?utf-8?B?OUttNktDa2tvM2gvNkRGMUhGemVYUXVWQTFPMVlhbndCQ3lwWDBKbHhQcndv?=
 =?utf-8?B?M3hjVUdnV1MwdVZRTjNWL1NpQ05uZk5Fa1lROGh3dmhWQ3hTM2x0ZllCdGtv?=
 =?utf-8?B?ZzIzUHE0aG1QMXlrenVJaHBHTXF3cytRdXdaU2Z5L3ZwU21mYngzM0NPTWND?=
 =?utf-8?B?cU1aMksyL2xCbnYvY2RGRUgycHJLT1JLbUprQ0c4czVvMzU4Qk82Wm5GTHA4?=
 =?utf-8?B?WVpGL2hwYWE1TVpJNjRoUXdUbnpXTWlZNmRFSXp1R1ZNbGExelB5Y011aHNM?=
 =?utf-8?B?TWFpNnM5d3B4eXkrM2xsRDc5clI0YkMreExUYW92SlNSMXgxU1BMb3A5Uiti?=
 =?utf-8?B?QU5ibEdUZE9aLytTYnZrTEhxUGZYWk5wQUVGZ3FuQS9pRGJYQ2pRMUltWXpG?=
 =?utf-8?B?Rk4wWWpKMGlEblFOVnFKWWRrUE1TRHdNa2YrQW5tZTNYYVZ4SDZnZGgwY2FC?=
 =?utf-8?B?SUNNZzA5M3U3MnZsWHdOM1laYm5jRG8vcXYrNFZTQjhUeTZPcmhTOG1NV2tm?=
 =?utf-8?B?YU54YnFpaTNQVDZUU3hYalZHNys3TVdnR2JQaHAvdTd5NlhYYkUzQ3VDcWY3?=
 =?utf-8?B?WitpSjdxRC9jaHVrR2F6d09ETDlGSW4yVW5JTzE5a2lBQjFnZXNoalEvbXdJ?=
 =?utf-8?B?amw0Mjlna2JzSmlkSEE4bEdmZGZyd25mbEhySTVPMVdTMGNSL1BpdEFtOGR2?=
 =?utf-8?B?bEZKdERla0hhQ0JxZWJKUzNiTkxBUndoSTlWZDVhZEZrN05kaXpoL2dpM2N3?=
 =?utf-8?B?dGFpSE1GWXRYdzFRSnE3MFVpYzcxRnNmZ0I2RzI3N0ROc1ZDZFBwYU56NkhD?=
 =?utf-8?B?WENEQUFXWVRnQXVkQjdVcmtlNVdBMFkwb2tLUXY2T2diblVheU0rOVIrNXp4?=
 =?utf-8?B?K3E0TC9ta2kyRDdTRDJib0YvL2ZhSi9xQk1BU2wzeU5ZQkNYRUZjRmJnTUdv?=
 =?utf-8?B?eE5KTFpTemk5Z2FPNWpXQ0poQlpmSTFLNmZQL0RtRmUyV1RmcE9zRFBFRkhs?=
 =?utf-8?B?VzcyN0lOUjdUa3lVWERnNkxBT1d4dmIvSGhKQkw1L1VoTVVSc1RMcFRFVU50?=
 =?utf-8?B?S0E0dG9iRi8wQ1I4V2VvVEtORUlFTi9LOGxZQlgydU5lSUZrRmNPUUtiWmVX?=
 =?utf-8?B?YzlnQ0ZVN3Bmc3NMc1N6aUtPQ3JFYzZPSEdWY1NDVTEvbG5FQ0M0YnQzdjFu?=
 =?utf-8?Q?fz+vsi6Cn2y7Qy8Ma6rr+XuGB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c5dccc-8e68-435f-ac82-08dc52ffe83c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:30:24.9827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUFfl4YqDoaa1nmPDEIiXFqyyipK4A7nRcwtjMde6wtYse2c575Pa3DJ2/FaYwuw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7468
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



On 4/2/2024 3:52 PM, Asad Kamal wrote:
> Report max set uclk and sclk for smu_v_13_0_6
> 

You may rephrase as

"Use OD (pp_od_clk_voltage) interface to report current limits, default
or those set by user, for SCLK and UCLK."

Thanks,
Lijo

> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 575292314f57..f81096bfbf2c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -1010,8 +1010,11 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
>  
>  	switch (type) {
>  	case SMU_OD_SCLK:
> -		size += sysfs_emit_at(buf, size, "%s:\n", "GFXCLK");
> -		fallthrough;
> +		size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
> +		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
> +				      pstate_table->gfxclk_pstate.curr.min,
> +				      pstate_table->gfxclk_pstate.curr.max);
> +		break;
>  	case SMU_SCLK:
>  		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_GFXCLK,
>  								&now);
> @@ -1052,8 +1055,11 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
>  		break;
>  
>  	case SMU_OD_MCLK:
> -		size += sysfs_emit_at(buf, size, "%s:\n", "MCLK");
> -		fallthrough;
> +		size += sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
> +		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
> +				      pstate_table->uclk_pstate.curr.min,
> +				      pstate_table->uclk_pstate.curr.max);
> +		break;
>  	case SMU_MCLK:
>  		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_UCLK,
>  								&now);
