Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4829ACD98D2
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 12:03:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE68110EEA8;
	Thu, 11 Jun 2026 12:03:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="24EZjjuW";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012036.outbound.protection.outlook.com
 [40.93.195.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 955E610EEA8
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 12:03:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pwlfy9nuPW+2VLgasHHd6K11F7jYuTQwD6j5Wbo/9MRNuCNIyBj6pioSwoolbhuu9iwMcYu+FJ4q2A+cb/Gj6+UZ20RpVFVrp8C/+LRzQB9suKW/GkuthdLADPnCHgOsP3olilFSQhmBVMS0zibQiE5LIOSfe0TGDAVpM0NPaaq1Sec8S48LnDJAIuuYTtVwWEPR/uFqq6A0owzRDhvXUI7vlg9YJbkiGixNeoewz8oVAhLGYo1BiXYu8ZmXsMXpEcHiGrv23sqHj2rzG9mww1RhdFXoXegCP6qoJ4c50m3fZzh4luwQJa9UFdl/cFRk3z/l3Ydfl90KEXj8jX5vTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unfbugpBGjd43H5cYOy7FVw5rfjkSErleDRfNyLSJts=;
 b=YbvG3lc7KteI3xYpFIiaznJ5YybuwSqTq+uOo08LXTE/BfW3rD+K0JAVngzv3NvWfAv+8rSeh1jn4ksHNljduKpDZvbMcLMUrTfcum7X8Y0ZbHK8SJhJI2nSk1xUdHjEqFMm+PE0MZlk8zdpjFydeOTXt0oZhzEm4/FN/jaqVuoR5z1sj7qUMaCML4oCyFx+5tvkSJQF3fb3uCk0o+WnEiO0nfE9YCL7pWLmQYMzlyzgrwjLwCQw5fC+MyJGl3FwJP2oZUpt1b7VAO/mlYh8ISQpKT6Bsvow4tESJFTFqQVjAgtMnkfar7uA2mBUvyn56Ig/1UT4NS6ra7unsl6I2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unfbugpBGjd43H5cYOy7FVw5rfjkSErleDRfNyLSJts=;
 b=24EZjjuWZ/y9sdMU44p2AT+7bUwPEoQ4XamMpHLp0FH7SiJGEN/Q36iR95hVt45s192R1xSAsf+bUBbK5wsDEtTLNpHjZbmGezsHTgwAunrY36yAmHIwwYKVY1+2qVKKhgS33cu8CTroTca9l9on7FeK4/61BDjgXd2cLdHnozc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH8PR12MB6891.namprd12.prod.outlook.com (2603:10b6:510:1cb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 12:03:38 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0092.011; Thu, 11 Jun 2026
 12:03:38 +0000
Message-ID: <75eecbfb-afdb-4b55-a4c7-2c6c0e5cb12f@amd.com>
Date: Thu, 11 Jun 2026 17:33:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] drm/amd/pm: smu_v14_0_0: add closest-match
 fallback for DPM level marking
To: Priya Hosur <Priya.Hosur@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 Mario.Limonciello@amd.com, Kenneth.Feng@amd.com
Cc: Pratik.Vishwakarma@amd.com, Veerabadhran.Gopalakrishnan@amd.com
References: <20260611113628.3217-1-Priya.Hosur@amd.com>
 <20260611113628.3217-5-Priya.Hosur@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260611113628.3217-5-Priya.Hosur@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26e::13) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH8PR12MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aa8990b-2baa-49ae-e1ff-08dec7b1787d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hqCvYNS2s10wn6mKu2607n6NRjcV0eNEM5PDgZvvAndgQbgR3WuelEUvsIhUaoj99xjvlvKUFe5gqHY+5mk1SJfQMjmz8rxrNERSqv/leDTcJVwo2pmLJYFPJuJAvkXpLozW7jnVko5aqPyPENrSXk2GsMNh3fePj6vYGAfBUX0ZcfqHGAYyU7wfuU+QENdR7wcGe5/DXz63v5y/MbbH0DZr0oZyfCSmRas+244y8jIflcKRhYVBbpmPL4RP7OBvMeMOhATWFiO6OvCBvbl26lqADIqzG6heLziNSFtLWMLVX2MLGO0ZWTtuqqHZX3OKKcib1WEUAWv8VZEwkPe6mwwgQyz6hLT1c0LVQpzFilfCodYeIhoZOmpQ7qKhcrXFlKw/FbPmewdIdDQAs9XAgrzEdBdhNYwACivN9PS08FrraY5QN3d7qPPPRY6UmtQUsgALObg/XIW1uOo03xf/lHQsn3QDr7i7ttMONV+tWp6mvVDb0Cr+GRC3IzCXLiuut49qt9gD+WojUUkdUe1JURoGZTbUxeDwiFHRAPatjOGmuTzE/MFhBKWilkmQCrIFEoAaIPtFVDMiBWmirxGNE2FmXtPudwakdUu/oBP3fPrafwfD4qktZTorkM9h1lN18e3uKQljddKbFC5Ft8GnMN7+lGGmBwi//kvD3iJLdJoxpv80mbkOS2+WSiCdEzG6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U01WSCtsS3BnblQ5NzdCUnY4Y29lTHJpZ3ZSK25IZ2lkc2twek5GbXA3c3Vu?=
 =?utf-8?B?TWRiU1VvWjNIelJXU0J2NWFteXhick1QRnVzL0ppVWRKeWozOG1ZalR1SVl2?=
 =?utf-8?B?T010NnBPcHVycVo5c1Z0WnZWdDZ3bzMydjREdkRlcWkrWlk3WEIwdFV6Y0Qv?=
 =?utf-8?B?bTFvZ1ZKcUZVTEFQNWcxS3pESThrWCt0Z0xTbmtXeGRGOCs1MHR0TUVMWm1z?=
 =?utf-8?B?WC9xR2dOek5HRUp0TFVsVExrZmdhK2RhNWdFMTJnYXZvVjdDdFVrSzl0dlA5?=
 =?utf-8?B?eis5cG9FOEw0TTVvQWM3L2ZqUm50dHJoNVdnZjB3dC9SNHY0NmJFK2UzbkIz?=
 =?utf-8?B?RXY4ZVFqbkRFYlJzUEthVFpnQi9wWEs5WmxvamZFNFVjVmJENkJJMm14VEo2?=
 =?utf-8?B?MnJybDlLL1R0UExhNW9Vd3NEMUZVcE5qTy9oK0xxTXAwMW1JMkl6MHZYNklj?=
 =?utf-8?B?SW1CeS9ocVhlME52Z1RpRUFKSEJoejc2YkhKbVZnR2FPT2hNZ0d3NXRSN0lK?=
 =?utf-8?B?YkJENFN3NjViL0NiZ1hCQ09kcjdYQ05Yc3A3SnlQck9GcHA3dS9BRFdPVUFE?=
 =?utf-8?B?UlAzeEIyYTRhelQ0K2ZtZjZWY29sSjE5dlZmc2RFajFoVXRnbHdtT3Rvemcx?=
 =?utf-8?B?eGdnOW5Xc2QrbHh1cDVMQWhTamsrbzhWbHowelFRZmx3bUtJVjQ1Y1lIZXY1?=
 =?utf-8?B?UnJmcWljcXU3V0FkVkpLZVhYOTZzWG1leDg3Si9xV0FRUDFaemttb3FRdTRa?=
 =?utf-8?B?YjdYWlJhbjZxSDJMZlZBcGl6K2YxSCs3QkVQVGVQSWFUR3p0OGgzREZ5MDly?=
 =?utf-8?B?UUd6WEQ0VDIvYkFhbU9oOHZySy91Zm43SXhheGJkOE9oTVp2Q0llNFlFeGZK?=
 =?utf-8?B?Vi9yQy9ZZTQxNkJjSWJaRUtpaHdiZDRDcXJUUFZiVU5ZeGhMem14TlRlbGRq?=
 =?utf-8?B?NXpPU24xcThKWFE4c2RIcFFMbGtOQkJRUmViMU5XMXBFM29vZXZtTlhSd29s?=
 =?utf-8?B?V1poZVJKbzRsT1pUM0JoTzUrNWx1OVFWYmoxczAySmxpYzFRWmcrL2dVSVIz?=
 =?utf-8?B?M2FHbGdkZ0hIS2J4QTIyNStkMXZ3SFpLMkgwLzNGSzlPWms3ejBvSkF3cS9v?=
 =?utf-8?B?V2U5Q0Jvbk12QTgxMkhTVnpaQmVTNVFqdGRIU0ozRzQ1UnpzQ0haOGpiWStY?=
 =?utf-8?B?eWFTTndYcUtGYnh5WkZKcVlGK0ZGNHNoeHJ0VmlrczY1WnRLYjZXZ0htY2lR?=
 =?utf-8?B?OW5wWDdmQUN6TURURU94bmIvMnM5WE1Bek1SblI1MWo3SVpyNTd5UWdhcWxS?=
 =?utf-8?B?eCs0S1ByVXd6ZW9lRjFNbkprK1Zmb3UzUkRCNzRHT0tXbWs4ZzB1OHRFUUtq?=
 =?utf-8?B?Unpxc0JqTnMwOUhzM0FEZGNjejA0UEUwdUIyNlo0ZzB5eENLV09wcWhja1Ja?=
 =?utf-8?B?RjRHS1IyaU1QaUFZSnhKRkJueHNRaXViWkxXSFY2NXgvNkExVklSNnpqbnEy?=
 =?utf-8?B?UnZiajI1eHYxc1F2dFlWNm1wdnliVmZhbGJpdFZmcjJPUTk3eFRMWVo4Ri9p?=
 =?utf-8?B?SkM4WHdHLzFub0dvME9IdTQ4ekp3eFlHL2tadmlhOUMxNFBmOThzRm12azV4?=
 =?utf-8?B?a3NrVllGNCtiNXMyOElITHNUTmFBaDJEbDhMRVNlN1VrejMwVTVreXIxVlo3?=
 =?utf-8?B?bEhNRlByOFhyQ3c1ZHBJNHdOWFQ4OGhCQnBTT3dUQUErTVFhR0RlYk1nNGpr?=
 =?utf-8?B?T2VZWmIxVGZOdmU4NGdxM2RTTnB5TTl4NWNOK1lKdEhOazd4bGZ5Qi9jS3lW?=
 =?utf-8?B?ZlcyL1ZqdkFESHB4WmNRaWlhbC95L3VoQW1hSkQzTTJ0dzRNS2lScURTbDhO?=
 =?utf-8?B?d0phalV5M2NjZ2VibXdyZk1VREFSbkw4TGYrMG5ROEdaRXk0bG5wcDBmOWlh?=
 =?utf-8?B?bzJpL3JIcVRKdjZCVTdNU1E0eG5LYkZ5K2tKVTlmS2xTODQwTmJpc1FJRzEr?=
 =?utf-8?B?MVRIb3hUVGZ2L1kvSmFJSEE5c1Q5NytpOFRlZFNmWngrUU9QVUd5NHQ0R2Nt?=
 =?utf-8?B?Wm55Yzd4VmUxN3RZZWE0RUoxUS9QR2c0c29qSEVnc1phRHE0WjU1UzhBRTF3?=
 =?utf-8?B?amRIOGplb0Z3Vm9IQ0FYcGtQYk9RcTVzbWdmRS9oWUxwRW16enhxNzk1bTJh?=
 =?utf-8?B?NzRRelNqczJHOUdYNDZpVW9yOFBBbEZjN0tMZEdQRzZJbCtrZm1OdXlTVUZ3?=
 =?utf-8?B?RUsyRXVTV2RqZ3lLZW9JWlp4RFN1M3lBNmhtK3BuWEhMYjNETjJjVzl2eVdj?=
 =?utf-8?Q?KFcRV4sqmvK2eimZTU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa8990b-2baa-49ae-e1ff-08dec7b1787d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 12:03:38.0029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlauki9+4opxLfmbMRUlHBOCG/xFXAeLp2qHPchg/6/aTE6zIFzDnT7K1EcgvKha
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6891
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



On 11-Jun-26 5:06 PM, Priya Hosur wrote:
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

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 46 ++++++++++++++++---
>   1 file changed, 39 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> index 4469048d966e..1c11e74072d3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> @@ -1194,14 +1194,46 @@ static int smu_v14_0_0_emit_clk_levels(struct smu_context *smu,
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
> +			uint32_t diff;
> +
> +			for (i = 0; i < count; i++) {
> +				idx = (clk_type == SMU_MCLK) ? (count - i - 1) : i;
> +				ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, idx, &value);
> +				if (ret)
> +					return ret;
> +
> +				if (cur_value == value) {
> +					closest_idx = i;
> +					break;
> +				}
> +
> +				diff = abs((int)cur_value - (int)value);
> +				if (diff < closest_diff) {
> +					closest_diff = diff;
> +					closest_idx = i;
> +				} else if (diff > closest_diff) {
> +					break;
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
> +				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +						      i, value,
> +						      i == closest_idx ? "*" : "");
> +			}
>   		}
>   		break;
>   	case SMU_DCEFCLK:

