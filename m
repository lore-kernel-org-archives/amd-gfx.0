Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E235C87FCB
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Aug 2025 04:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B0BA10E248;
	Tue,  5 Aug 2025 04:53:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o5r1ofco";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E46C710E248
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Aug 2025 04:53:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8WUaTfvgy/RmTIGaEjTLggwITRnQlQ+l9c1SOKXnHgKoV6GuW4d3+8oF6VR7XqJhRXOs1qR+AhvjqclVSw3GrzUrIeFeHQ/Jc325pYLDAiniux5CfotT6t753ZlZ4zqJw15NythUeHvnrqDCxBYFWuG0dHhBqgYPHeVAbYSZHPBem3g58+oEdnWeAQpxHlSjwdn+P3TNCB5UW7IgzWygrCdHtsmrP9TojmRYec7YjVRhZbnZ4feGxOl5jz+KB5YvO8x0/Er+bL8DTgM62CySsBJKDoAyAm9Ep6He14rV65Fn1WuWiB6QMbBmrgbDRAdgTTt0DudPJrWbPqh61YHGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7GLEnZeRzn3MrwwpwXJijNs/Ez2vPoK4e4Yh8/i3lE=;
 b=bJU8jwmVnchM7R3LPea7xnIcGeEaPWDGMwhZp1qqoX2NRGn/gLQ//XMfJI39zBq43uR5cOeJU2fgHoM6YZfoLRwb1SCizC2EF5/7srZcL9qxF9ZpUHDaMfigjupmPImrS3Ijw1U2II5Qz9J5bf+d5zeAO/zIQ8sS5pr/9QxrEd5SD0Xd7N6uOOtISNEwFDYtaqZ6BP60dxHZzZE/mWN5EgsUKoNIZ1BLApD1u2D5tRu7WfWAmt4ESX+ZGgrxPDLOeYAHGrY1Ckn6GDZcAd6zjaDw3pqo9FSBgSic7vEh2CZ7aDMmZHMhe3Ppw1JAEirfc9Jhq1PjxQOj4EoQJuaLJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7GLEnZeRzn3MrwwpwXJijNs/Ez2vPoK4e4Yh8/i3lE=;
 b=o5r1ofcoR6XRkg2GceRM3xrkiM1R+6+s1/6a0oMLHqI6ZlWVMjqEnYSRvSWy1siqksdXSWOU6kFIQPbgEXyCMs6QeQ91edSaLFJZAST8EQz7/Sin8tjMwnax4Vw7+XBn6y7KC+bup79xjsHX3nvQZSg2oMKzgm2zoQ4NuMovTAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 04:53:11 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%5]) with mapi id 15.20.8989.017; Tue, 5 Aug 2025
 04:53:11 +0000
Message-ID: <8a4ba195-fab2-4089-9a74-4b4a52a9abae@amd.com>
Date: Tue, 5 Aug 2025 10:23:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] drm/amd/pm: Add temperature metrics sysfs entry
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com
References: <20250804141757.643501-1-asad.kamal@amd.com>
 <20250804141757.643501-5-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250804141757.643501-5-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::33) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|MW3PR12MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: 38d1c671-e352-47a6-5228-08ddd3dbfaa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEUxbXdpbDRuY29qbkJJMWJGQnFQYzBva1UxRUdsTUJXSkF6VXVkS0JxZkxw?=
 =?utf-8?B?RHVWK3VHYWFtcStuRnBDQlBiVlpRR2c4Umlud2V0V3MrQUZTMTZtU1AxUlBY?=
 =?utf-8?B?emVteDFFRHZCUnh6ODIxQ3RDTGFENkJyOXZwY0FZU2N3UnlOU01Wa1ZPMGlU?=
 =?utf-8?B?YWJGK2RlWHgzOVZ6cnVGazIwb3o2elhLMysyVlZHaHc2OFJYd0xxdE4vV1Zj?=
 =?utf-8?B?MXd0NmVvNXR2WTZDaGpxdlJ4YmNac0RldWt0Z3Nkb1E5NGRrYlZWMXpETnhS?=
 =?utf-8?B?aWZOckdzMk5IZHhKYk12Vm5JbWs4bTRsMnJNcVFYZEd1VUljaG9KRUQzQURG?=
 =?utf-8?B?RFI0NzdZdGdTZ0tkMGpya0d2VFIxQTd1Z3pZUktMbTYrY3VKNVR3T29hbU9a?=
 =?utf-8?B?MzlVWG5tVzREY2FRTVk2YzdzbG44YlRwamlQMm5hT01DL1RqZnJpOHdzWkpr?=
 =?utf-8?B?eDFTMW9XbW5rVkJob3p4aENtTVl0dkV2djMrcm1jeWV4ZHVnZTVKU1R1SjJ0?=
 =?utf-8?B?UklQZkJ3UzFrRWhYR3JQT1BJZm9sSmdhSUk1ZlZxT2FEcUlCTFhWb0VUODZk?=
 =?utf-8?B?OXlTU2JFYjQ1cE91bEtxSjJaSU96TktmeURSdWlKNlN5VFN5cEtNeEFlRHVV?=
 =?utf-8?B?Q1Jrbm5yaDRIRlBIZEZPbXZGMXAvU0VTOHE0Wm5qTGRzOHdJNm9pazY4RlNo?=
 =?utf-8?B?WXlPaGtoZkRYOEdMQ3M2d0VBT3NqbHdmdHErUGFuT2NPTnNudjRTSnNhTnBr?=
 =?utf-8?B?Z0c5NGRYSG5aMHh3Sy9YSlBqUVRHZkZ1MXJ2dlIvYVhkOE1mbHhLNDZUV1pp?=
 =?utf-8?B?ZTBXY0ZXblBkcFg1clR4a0V4bGNoLzJMaXdDaHJJYTFmLzZIUExPVjZjcmVF?=
 =?utf-8?B?eGhnYkFOZEdwb3dVWFF0cGFUcDhDZVlUM3hWUnJxSXhDQytlbXBwdmVCT2k3?=
 =?utf-8?B?UVVwRlpCS3VPQUU3c2s4SjZZd0YvVnVBdFdNN3hGSVYwaStFMlVlK3VyMk8r?=
 =?utf-8?B?L2tLUVUxcjJsdFV1dUtSNlNuVjNaR1h2enExSGkzeG1yMmZJSVBLbkVZZW00?=
 =?utf-8?B?eWdxVzc5QWRQNmkreFBjUkY0d2g4d0tzanVhWEtzQko5MXVRTlh0aEVSUlJ4?=
 =?utf-8?B?Z0JSbktuekZEdjdLZTB1YjAxUEVzc2Q2M1ZOa2tsbXhscUZPbG9NdWFrcDA4?=
 =?utf-8?B?UnFHRCt1MHQ3YWZONFNLRzVIRTRzR3YyNFJPcVM1R3IxOWZTRkd6R2taS1Rz?=
 =?utf-8?B?c0QxbW5zNUdvWUp2dlZEMVpVMzlkMmpzNXdUcDJqWmMxenhyNXBLT3BQdDha?=
 =?utf-8?B?WWF3RzFFekNnVC9tM3p3T1J2bkxqWGtTSGRDRTlmcCsydEY3MmdpQ0F4S291?=
 =?utf-8?B?MUJSRTZzZzltOFdKU3hzaUU2SzdQeGZuTE4xaU41ZHltYjBzdGxaUld0Y2d5?=
 =?utf-8?B?c291Y1BPdHFXMTh6bjZ0RVRZTXdieGlRM2htWWtXZHY5ZGZtYzNiM1AxKy9q?=
 =?utf-8?B?b2VrUTJYRFpWOFNaSFZQWHRtckZ2eFJFeWVWcUVYbHoxYXZWeGROeEpVd0pu?=
 =?utf-8?B?UVlSSXF5c2JPZjdHbVdmbUhuaG95UW9tVktISHRDdUV1RVUxaDNjNngzcXFm?=
 =?utf-8?B?UkpIZ0Rlc1pGWTJBWnY1V3Bqa3N1Mi9QNGwwaU01QlZLUTNGNFN1WEVZS1Mx?=
 =?utf-8?B?Tzl4MGxwVGxCQWhtZXluNUNBQXNjMzFKOUczVk9sVWl3ZGJiT2pEd3dwMTVo?=
 =?utf-8?B?MUpTbzdJdHJ4dzNGSDdEaFc3NnB6RlljMjVUVElVUHk5MmJBbHAyRzFkUVVp?=
 =?utf-8?B?MUZzTlVpcHh6aWdsV2Q2ZllXRWFsbXBwNWNhN0thMms5eTRGM3l4eUhqMWNn?=
 =?utf-8?B?dG5LbFBMY3ZveHNpWjBETHdrOVN6NUo0YWtPOG1JYnZERWpmbGw1Tld3T1Qw?=
 =?utf-8?Q?XS7PqPawyQA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGc3VHdwbGJXYnZVRHZBSkJXb0xkSGpFZWpuVFRYeHNRZlNLZXZzV1lBNTZh?=
 =?utf-8?B?U3c1WDVBdXVVNDFaeWh1RW0zTURmbEdlWmJLRFo2SGIrN0hoZ1VmVXhXZ21O?=
 =?utf-8?B?Q0F0T1pZSEZHZmQ5bUIzN3NmQUpaNzhOTGpWY1ZRQk1IQWhPZUw1U1JRYllr?=
 =?utf-8?B?R29ieTNWOGZLMHJBNTk5c01US0JyaWlpVFNlR1VjQThGNDVLWWRRaXVCcENW?=
 =?utf-8?B?bTVSTjc1bVF6R092Zno1RXR6OGxaL2dVeC9DUk9UcmhNcXJPY29sZVB6VXcy?=
 =?utf-8?B?cVZHQ0c2UjBaN09zS253cjdDVW1vbFgvTzIyaThnM01Wc1diSnJQOXZhSS9i?=
 =?utf-8?B?bTA4NmY4MkNDTkpaUjBla3NLYWM3TDkyTThDdU1iTURUbnZBUjlQL2VPd1lh?=
 =?utf-8?B?azhiM0F5VExydGdvMUZyVXVYZ2hKTXFjYlcrdWhKSkhXNzhlN29STEtIL1h5?=
 =?utf-8?B?RXlMR0VSWGYxOHVGSXBQczIwc1UwNDV0cjU4bzliMUlyamI1SmoxSXZuMG5h?=
 =?utf-8?B?VUVuM2tmVW44WG5uekJqbG9sQTd5Z2xIQXQ5MmVSZlRaeGQ1Rlg1NkIvc3o2?=
 =?utf-8?B?YUZ5Mm1Dc296aXdOSkUwZWVQN1ViZDZObTJvYmdsUTFpTEtIVXlENVBIaGph?=
 =?utf-8?B?ZU9KZXk0Y3FGbVdLNndKMGxUaU1XREhmOVdPSHk3SEdnMkRHSjlOdDJrOXlP?=
 =?utf-8?B?d3ZaRU1WVzNGdzQ5Mk1HWEZXWiszQjdaWjZjUXprTDhJYkEyZWtPRVhhVGxO?=
 =?utf-8?B?bDhUeU9SNFhWWW5kN1BsTDJzdDlFTkF2aFVsTk1DTWdqMjJQN3drc3VkQUhY?=
 =?utf-8?B?cXRPV3pieVFWZ2lGR0JOTmhHK0RtbWZuRk5IaklkWmhHTENwS0tIeWhQRVli?=
 =?utf-8?B?Y3NiUHd2NXRteG5rRHZKNkw4Q0FqQUp1ZjZFYXJVN202bU1PVk54MmNHdU9j?=
 =?utf-8?B?ZndOV3pBT2Nzank0ZzRaMVAxUFN2dGhkUTJER3RhVlArVk5Dd2gwTEV0STh5?=
 =?utf-8?B?VytMUGpsUWlPZlhmU1p6YVVtdmJyRlQvR2VxV25Xbjl0U29SOTNCYlI5V005?=
 =?utf-8?B?QWJweWFSeU15eG1uWFhpbnpZWDNQT3lDYnVKY21wY0Erc3J6OHVOVi82SkFP?=
 =?utf-8?B?Umo1cFZBblQxZGpUWkNrR3FIWkdFY0NTOTJVdkpMQm5uc00wVVlja2lnYkRH?=
 =?utf-8?B?WSs3VDhoQ1lkcGc0MHFKbnBpZmtzUCtjUE5RMTlVVnNQNU5UNlQwdXpxdnZt?=
 =?utf-8?B?RkdmMU5uQ1hHRE1rZ08vM3cybldBU3hhUWJ3OTVWTVJCL0w4dkpwV293RFhV?=
 =?utf-8?B?NlNaNE0relFNR3hPRjF4RFZGRm03bXpZdDAydlhjaUIzZEZkbUhSdWcyWVNF?=
 =?utf-8?B?VjVJcEQ2dlBROFE1bHdBQXlrNW1KU25Vams4M2xWMm9jVEpJcXJwUmpaNS80?=
 =?utf-8?B?VGR4MWt0cWw2cEZ6TGlNSlpoV3B2S0VJUks5Y3NOQUV2cUhqNEZobnF1cXBI?=
 =?utf-8?B?eDQvZ0t4TTZrTUkydEN6a3M0WDJOK3B3TjB4MzNkclN3eFgvMitxbmowWlUr?=
 =?utf-8?B?N1B0bWhhU1pVbmZQSEZNRGhqb3VjTURpWkl1WHpDOHMzOHU5bXhRTGt5UlhL?=
 =?utf-8?B?Yld1dDErQ3QxaEdCYk5iaEY3UnpQS1l0NGZZbVlRVjc0U1dzSDBxZ2t5Q2kx?=
 =?utf-8?B?MGJtbU1pSFlaRzJEMm55amxpaEZmbC9QOUtJTTdVK0dKcnhmSVBGOVhTbjFT?=
 =?utf-8?B?SnJPdlhaYm5LZE00dDF3ODgySWVET09mN0RsZTFzaHRkZjZ6eXJGN2h6eVRH?=
 =?utf-8?B?bHRXaW9Id1p1akVaZDJLMHJIcHk3OEZQUUsvS3pPZ3A0aXJkNnJoNHpvaXdB?=
 =?utf-8?B?WmMzS1lqMmgrUDU5QkJzTS95VHRBS1JyRCtxUlhzUEVFOUs4WHVaU1plcUY4?=
 =?utf-8?B?ME03cndPQWJCVGJnMG5idkhSc1lxOEtDM1NmZ0M2VEc3VU5FM25zT0tWQ3Y1?=
 =?utf-8?B?TWZOM2VGR2s2alBDckFScTR3Y1pHMVZKUEQxalVXZDUyQVFYc0YwQXZKVUFH?=
 =?utf-8?B?bHBXeWp3RngvUGxSQ1czc1NCc3M5WXNKWGxJNnpNalhFS2xpb3UyUkpCNXVj?=
 =?utf-8?Q?KuYnaGcMq3WLKdTxtjgHvlE+V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d1c671-e352-47a6-5228-08ddd3dbfaa2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 04:53:11.6081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpjARDnutUyl2aq8mg5aBfTavri9pawiHlzpiUHMNM0Mkw5meGgSbQbX4tT5nBWE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492
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



On 8/4/2025 7:47 PM, Asad Kamal wrote:
> Add temperature metrics sysfs entry to expose gpuboard/baseboard
> temperature metrics
> 
> v2: Removed unused function, rename functions(Lijo)
> 
> v3: Remove unnecessary initialization
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 135 +++++++++++++++++++++++++++++
>  1 file changed, 135 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 8d934a365c3b..b94cdfd9e6ae 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2080,6 +2080,134 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
>  	return 0;
>  }
>  
> +/**
> + * DOC: board
> + *
> + * Certain SOCs can support various board attributes reporting. This is useful
> + * for user application to monitor various bard reated attributes.

Typo bard -> board.

> + *
> + * The amdgpu driver provides a sysfs API for reporting board attributes. Presently,
> + * only two types of attributes are reported, baseboard temperature and
> + * gpu board temperature. Both of them are reported as binary files.
> + *
> + * * .. code-block:: console
> + *
> + *      hexdump /sys/bus/pci/devices/.../board/baseboard_temp
> + *
> + *      hexdump /sys/bus/pci/devices/.../board/gpuboard_temp
> + *
> + */
> +
> +/**
> + * DOC: baseboard_temp
> + *
> + * The amdgpu driver provides a sysfs API for retrieving current baseboard
> + * temperature metrics data. The file baseboard_temp is used for this.
> + * Reading the file will dump all the current baseboard tempertature  metrics data.

Typo -> temperature
> + */
> +static ssize_t amdgpu_get_baseboard_temp_metrics(struct device *dev,
> +						 struct device_attribute *attr, char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +	ssize_t size;
> +	int ret;
> +
> +	ret = amdgpu_pm_get_access_if_active(adev);
> +	if (ret)
> +		return ret;
> +
> +	size = amdgpu_dpm_get_temp_metrics(adev, SMU_TEMP_METRIC_BASEBOARD, NULL);
> +	if (size <= 0)
> +		goto out;
> +	if (size >= PAGE_SIZE) {
> +		ret = -ENOSPC;
> +		goto out;
> +	}
> +
> +	amdgpu_dpm_get_temp_metrics(adev, SMU_TEMP_METRIC_BASEBOARD, buf);
> +
> +out:
> +	amdgpu_pm_put_access(adev);
> +
> +	if (ret)
> +		return ret;
> +
> +	return size;
> +}
> +
> +/**
> + * DOC: gpuboard_temp
> + *
> + * The amdgpu driver provides a sysfs API for retrieving current gpuboard
> + * temperature metrics data. The file gpuboard_temp is used for this.
> + * Reading the file will dump all the current gpuboard tempertature  metrics data.


Typo -> temperature

Thanks,
Lijo

> + */
> +static ssize_t amdgpu_get_gpuboard_temp_metrics(struct device *dev,
> +						struct device_attribute *attr, char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +	ssize_t size;
> +	int ret;
> +
> +	ret = amdgpu_pm_get_access_if_active(adev);
> +	if (ret)
> +		return ret;
> +
> +	size = amdgpu_dpm_get_temp_metrics(adev, SMU_TEMP_METRIC_GPUBOARD, NULL);
> +	if (size <= 0)
> +		goto out;
> +	if (size >= PAGE_SIZE) {
> +		ret = -ENOSPC;
> +		goto out;
> +	}
> +
> +	amdgpu_dpm_get_temp_metrics(adev, SMU_TEMP_METRIC_GPUBOARD, buf);
> +
> +out:
> +	amdgpu_pm_put_access(adev);
> +
> +	if (ret)
> +		return ret;
> +
> +	return size;
> +}
> +
> +static DEVICE_ATTR(baseboard_temp, 0444, amdgpu_get_baseboard_temp_metrics, NULL);
> +static DEVICE_ATTR(gpuboard_temp, 0444, amdgpu_get_gpuboard_temp_metrics, NULL);
> +
> +static struct attribute *board_attrs[] = {
> +	&dev_attr_baseboard_temp.attr,
> +	&dev_attr_gpuboard_temp.attr,
> +	NULL
> +};
> +
> +static umode_t amdgpu_board_attr_visible(struct kobject *kobj, struct attribute *attr, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +
> +	if (attr == &dev_attr_baseboard_temp.attr) {
> +		if (!amdgpu_dpm_is_temp_metrics_supported(adev, SMU_TEMP_METRIC_BASEBOARD))
> +			return 0;
> +	}
> +
> +	if (attr == &dev_attr_gpuboard_temp.attr) {
> +		if (!amdgpu_dpm_is_temp_metrics_supported(adev, SMU_TEMP_METRIC_GPUBOARD))
> +			return 0;
> +	}
> +
> +	return attr->mode;
> +}
> +
> +const struct attribute_group amdgpu_board_attr_group = {
> +	.name = "board",
> +	.attrs = board_attrs,
> +	.is_visible = amdgpu_board_attr_visible,
> +};
> +
>  /* pm policy attributes */
>  struct amdgpu_pm_policy_attr {
>  	struct device_attribute dev_attr;
> @@ -4468,6 +4596,13 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>  			goto err_out0;
>  	}
>  
> +	if (amdgpu_dpm_is_temp_metrics_supported(adev, SMU_TEMP_METRIC_GPUBOARD)) {
> +		ret = devm_device_add_group(adev->dev,
> +					    &amdgpu_board_attr_group);
> +		if (ret)
> +			goto err_out0;
> +	}
> +
>  	adev->pm.sysfs_initialized = true;
>  
>  	return 0;

