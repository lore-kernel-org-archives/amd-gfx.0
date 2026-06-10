Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C269CD8CB9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 13:42:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D453610E964;
	Wed, 10 Jun 2026 13:41:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L9MHj7HA";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013054.outbound.protection.outlook.com
 [40.93.196.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C07510E964
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 13:41:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TiS92sv6CngUpmBEf2r7jfe+wRAqtVZ7Vws0be2hP7tJeUqRJfk5U0fkGVtlhUclluldxQ+aOHpSgiQY07OuYhA6CE+OXHi3XPuXars8TNpt+UZifwdKJGKHCzBKexvN0cg0Lm9JsbSQFjXIHHZvcpITPgokrgY08YaoyzDEiMlA8ewtxBIvaxh9T/3kPOmD+j3lDojXnBwlaH3sJTy+bKeRAfl5pB7XL/jytju04dc+q+J2KLMda8FkZHR5M8h5zcWLmS8yHWobSS5hM6FlzezSHqAHL6rlA8XxJSxjgB7RDqqL3nfsUB8eMZYufUEO1IGVthl4dxCM91u+niiIaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJK0UFQVy3Ko/DcFBzQdFR2S3yi53IDDPhzPqEHS6gk=;
 b=wSy7smjL9xJhf8T5Kdtez9eXfh/jv1w3AOuVWg0ZXQLUCnkydnbiBwit7iwxo28WB5SQmVZSb7fnVnyzPv6GFN380YuX2xguqk0l+4h8zJm7yrqAUGf3TCLC3UaFmgtQ+xW6Cq6/jEci7yjsMFCYhgRV+gVMraQvXjbjfJjlrRZGvUxjbNqcM+ucqiXcdjrFJgDPJip5KKmPYMNYIUDA6WYeP+/xrBpTfiZmQZQGMMsYMA+X4QuvRn1/A85dv3oheeN1o2j3J6+aD/T0NrB4rZHHgwDVulX8ssMGHehMeYBIRS+9nxDDracLV8gQ/Yb+z19UXISDR3ukfdVKjS7yxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJK0UFQVy3Ko/DcFBzQdFR2S3yi53IDDPhzPqEHS6gk=;
 b=L9MHj7HAW2+R52yh35Ufk7WseHrPH0QZGnFVnZr0bFtvfNfywS1Mwr9HgjNTwaerLMF4e41iIrkzROH3lPW3nYGkSs23FzD1g0D8RER9lmk3oOqLEts5xCx+U9MznPx2eYX4dSZ8FFNUccuw8C/avBe28sF4FWgxRL0OhzdSj/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 13:41:55 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 13:41:55 +0000
Message-ID: <df04058d-b730-4597-befb-562c0067cffd@amd.com>
Date: Wed, 10 Jun 2026 19:11:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amd/pm: smu_v14_0_0: add closest-match fallback
 for DPM level marking
To: Priya Hosur <Priya.Hosur@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 Mario.Limonciello@amd.com, Kenneth.Feng@amd.com
Cc: Pratik.Vishwakarma@amd.com, Veerabadhran.Gopalakrishnan@amd.com
References: <20260610120944.124040-1-Priya.Hosur@amd.com>
 <20260610120944.124040-5-Priya.Hosur@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260610120944.124040-5-Priya.Hosur@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM4PR12MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 7186d5fd-aaa9-42a0-b030-08dec6f60911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11063799006|56012099006|4143699003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 4p2tSjsmV7C0cYWuuWoRinYkgY6bh8n06ctSOfzId23PITUP4L36Pa+Kqu+wYcw7SVtnDiN7zrlidEtMbE4jk0AiDerUpHESRrL00GiW4v2uo0lmoe1ebDhUAqW24wCJ4DhRZCm7NSbmeDdnlvLDsbrrrAkplA2UXLJwEvR/Ql4qcjGDIgarfXLCijF0qYmMD1caHQfy3sVCzecsFUh7kKLCWDcTFCkHw7E2ADtMvObgYgEH0C0kREqFIvgxL9J3H9BHDKJeiGruLAV4pc2kpxVtso/sJGwCWXJLpdW49MQ9kMWpXMPR/LUImNFRqqBDET8oX7cY+VBUX/IapOmLJt8Eok/CkiLIcSDPBr8KX2Yex57K81gt22TsJAal6sE8k+AYEygjpQ9NhYbDiTGw+cmSxYIxZJpZubrhxssI+Y3rtGuTSBZRQpxxQ0LB/vMjDj5JDJEWCI5Ic+tF5FfO24OTf35TjU+67ryDKohCnWH9QfjLSQEwo24MDQXCYGn/RLtKhC0F5bM53tW9/cjOpyS/XOTf8Ki856U62Q5He14YcikDA7xbENGjsHPlsjJfnb+xeB+Dcfd14ZfCh4s3aSb8M9c26sdr/pdhRkZzGyJqexkRtpGCZMsEfbx7kCeJw426gCbd2uAWLU7fezyUMVn/NfjnXkP4gHnloBCvlXdvoJ6qJMSvcd2GDwWwIMWY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0pZeSsxZHFOWW9lN1ZzU2NjMXZPWmpTYzk4S2dVT2NlMlZXZkQrMTRmNHl2?=
 =?utf-8?B?aVg3Skt0MnRSVFRJQkFrN2IrbSszeDFwbmF3cDVSb0gxa3lpNlZIYXFGdVZp?=
 =?utf-8?B?d2MxU2R0RzNxTkFCQ1laK0VncU9jdURKeVllV3Z2UExCQTJQRDh4UytEOTZy?=
 =?utf-8?B?YXAva1FzRUNjYnNDdTRCWHB1UVJ3bnV3eFU2VWFsK1pFWUFEOGRwak53NERL?=
 =?utf-8?B?bDEvTUFRM0xpNTE3R2p2eW8rTFlaL2t1YlBMdEc0eWhUbU9HcklqUlZPVW1x?=
 =?utf-8?B?MHhWRm12NlZnMVRuSEd4NDliOVAyclVsNXF6OE9wbm1iR1Nhb0d4WlRvZDkw?=
 =?utf-8?B?ZVVSRDVBS1NZdkJiOFZ0LzBLRUwrVG1rQkFuc29mS3c0WlY3N3E4SkVTaCtv?=
 =?utf-8?B?aHc0NFpnaUhrNSt5QWFPNlE5UkE3RUtWWldPbm8zZHRYU1d2S09PUVB6ek1r?=
 =?utf-8?B?cEhwSk5oeDF1WGV3UU9RcG10SVJDSVpNL3RnVmY4ay9Od3VPbGp6cW1uWDRN?=
 =?utf-8?B?TXlSTWxFMExRQjB4T25YYVIrL0ZYNytnK3FydUY1L3kyTmY4cDRJcGJyeWI3?=
 =?utf-8?B?QnRQMnlLcEJ2Kzg0K1JzQWdMK0gzTjNqc1JWc2ovM2c1dmRDMmtMK1ZMcUhr?=
 =?utf-8?B?Y2RETkMwMnd5blVOejlFWWorL2ZURDkyWTRKelZBeUk4ZDRIbDRNOWpON3pm?=
 =?utf-8?B?L2J0V3hLVHpERFd5MmtjSGZLS1hteEpoQU5oOHVNdWxQZ2M5MTdONXQ1amlC?=
 =?utf-8?B?V0hLanBVZ2VBb21WRk5PRi9YQytob0xqd05ZODBpVlVDQTZUek5sU2dkdlRu?=
 =?utf-8?B?eGRBUDMrK29OWG8yRkFWOFlOaXpIUVBuWk1uTU5EdUpjb2d3MElka05uMG15?=
 =?utf-8?B?NWk3MXd0dWpPaUVOMnZFSEJZRVlxMklnNzlNWTMzZm90TVd1blBTUkJQMWhU?=
 =?utf-8?B?L2pxVXh3OUwrYTlsajhxRHFqc1c5Zlo4eXlhUVNoSmpNNFBPVUFQczNCOGdQ?=
 =?utf-8?B?eC8vSHBhMVVkaGN6N1c3RFZWbkRmV3Mwdno5d0o2bFR3WXRNaTlncnFIYUpB?=
 =?utf-8?B?WG0rbVJZdVRMR0RqcDJycmZ3cW1yQUZac2dyWm5LWGxVNVkxelEvenZ6S1gv?=
 =?utf-8?B?cGFxWmx0d29OSmE3dVFsQkFSUGwwWFVRdFZHamgrK2Fqekx3dUhNWUt1Wi81?=
 =?utf-8?B?WHNhNUhjS2s1cW11RXIrdnpsSm1IYWVQV2RyblplSEQxWGxqV0RyOUdBbkZ3?=
 =?utf-8?B?Ym5MMGwxemRtM28vaDV0ZlY1eHcvTWN6cmhaYm1zOVIvU01XSVFVZi9NSVk5?=
 =?utf-8?B?bU4zSnJ1R0N4YTduUlE5ZnA1dDhmMFM2aC9EZ0ViTWpxMWQ0UXlmRzFNQWF6?=
 =?utf-8?B?bFR2WEk3SU9CYUNZK1FmWDJaVFNrM0NiVWNpaHFWbDBjSTAxbGxXSUV2b1Np?=
 =?utf-8?B?WitoVXNzbWNMakhod093WUhFcENpakxSdnRNL3JoSStrZ1JmS3NKT3FtOVZ1?=
 =?utf-8?B?ajk1N3JaTTViKzM4N0o5L2xlb0gyam1yZzRyK1Nmdi9uRm0zSHlHL2VyR0lW?=
 =?utf-8?B?by9DOGxHUzdKZEFGejBJb05XVG9rZzZGeEh3cExRNFY5UngzOEl2WkFzTm9Y?=
 =?utf-8?B?THRUSjlRMElVd0FSK3V4NXdWdnZuQ1dRNjdqR2kyNGxFVFljMlRsZzRYT1Vw?=
 =?utf-8?B?U1ZFeThYQWNTLzNrZXlMcS9LZUVsaXFmaGJNVlBvUkwraGROekRIUUF5cDRH?=
 =?utf-8?B?ejZJWktxZWk2LzdOSmg1Y2NxRFFiK2RUblJINnczUW81QWRkbHJhUXZQbm4z?=
 =?utf-8?B?bE0wbm95T0UrV3dmM24rczVOQkZlYXlValRJVFdWalBBZE8zMGRoWVE5ZGNq?=
 =?utf-8?B?clRidGllaXY3K3h6a21lWjBsdlhZQXBJNG1WamNvbEtyUGFseitaWlBHUG9v?=
 =?utf-8?B?eXpvS1pmdkNOQytzQ3REWkJ3cy85VFJiUjRuWi81Z29rYUtVMkxjRFFCSi8r?=
 =?utf-8?B?VXJzcXlXUVM4RDZHUlNZcGc1WHM5Y09wTnNiSVNWRDBUQVlSa2VCUWVici9q?=
 =?utf-8?B?QlVHdTdaOHNJNHRVQ3VyWndWVGxhbmNNVnRzNi9lNHZ0Z1NzMGZ5SXM4Nmhv?=
 =?utf-8?B?ZWVOeE5ZVHdCVHFPaVpOenZZa1pLME9CcXFRck9NL1djZXhGcUZSdG44UVBh?=
 =?utf-8?B?bTExZHF1dGJsWUlhSzZvQXFUZkl1STcydHNmbXU4dEJCNHYrSUpXbEVCdGkz?=
 =?utf-8?B?K1VJSFpOamovVjI1R0hhaTdkYk9hek54MlhkeG1qWmhDQ252WUhxdmpuVnp1?=
 =?utf-8?Q?BcgZvmNoVwXayCYWyE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7186d5fd-aaa9-42a0-b030-08dec6f60911
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 13:41:55.1541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbGIVWv0X4lxPK0Z24d0do97jOyUnmcxe0EH4A1ziD+GBVhOGe+HEjTLvzPwWtL4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572
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



On 10-Jun-26 5:39 PM, Priya Hosur wrote:
> Replace the simple exact-match loop in emit_clk_levels with a
> two-pass approach: the first pass checks whether the current
> frequency matches any DPM level exactly and also tracks the closest
> level by absolute frequency difference. The second pass emits the
> levels, marking the exact match if found, otherwise the closest
> level.
> 
> The SMU reports time-filtered average frequencies that often do not
> match any DPM table entry exactly. Without this fallback, MCLK,
> FCLK and other clocks show DPM levels but never display the *
> marker, breaking userspace tools that rely on it to identify the
> active frequency.
> 
> Also uses reverse DPM index for SMU_MCLK since MemPstateTable
> stores levels high-to-low.
> 
> Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
> ---
>   .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 46 ++++++++++++++++---
>   1 file changed, 39 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> index c203e828cce4..b113cf2b26fa 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> @@ -1195,14 +1195,46 @@ static int smu_v14_0_0_emit_clk_levels(struct smu_context *smu,
>   		if (ret)
>   			return ret;
>   
> -		for (i = 0; i < count; i++) {
> -			idx = (clk_type == SMU_MCLK) ? (count - i - 1) : i;
> -			ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, idx, &value);
> -			if (ret)
> -				return ret;
> +		/*
> +		 * Try exact match first. If the SMU reports a time-averaged
> +		 * frequency that doesn't match any DPM level exactly, fall
> +		 * back to marking the closest DPM level.
> +		 */
> +		{
> +			int closest_idx = 0;
> +			uint32_t closest_diff = U32_MAX;
> +			bool exact_match = false;
> +
> +			for (i = 0; i < count; i++) {
> +				idx = (clk_type == SMU_MCLK) ? (count - i - 1) : i;
> +				ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, idx, &value);
> +				if (ret)
> +					return ret;
> +
> +				if (cur_value == value)
> +					exact_match = true;

What about closest_idx = i; and break here? You may also break the loop 
if new_diff > closest_diff

Thanks,
Lijo

> +
> +				if (abs((int)cur_value - (int)value) < closest_diff) {
> +					closest_diff = abs((int)cur_value - (int)value);
> +					closest_idx = i;
> +				}
> +			}
>   
> -			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
> -					      cur_value == value ? "*" : "");
> +			for (i = 0; i < count; i++) {
> +				idx = (clk_type == SMU_MCLK) ? (count - i - 1) : i;
> +				ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, idx, &value);
> +				if (ret)
> +					return ret;
> +
> +				if (exact_match)
> +					size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +							      i, value,
> +							      cur_value == value ? "*" : "");
> +				else
> +					size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +							      i, value,
> +							      i == closest_idx ? "*" : "");
> +			}
>   		}
>   		break;
>   	case SMU_DCEFCLK:

