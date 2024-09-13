Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722E5FA374A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Sep 2024 12:43:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CC9410E1AE;
	Fri, 13 Sep 2024 12:43:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bh76p3Re";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C5A310E1AE
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Sep 2024 12:43:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pey3OZLKL2+7tsmcDzgpZ7n/Lcgz3go1eWXMS4iF7l8R+eb9cy0hptVg3qBRCIfVISTlP469M6A4ozPu7A0JkiCQTZ7/560chND0Tl0+hJsR2ZBT64zWQ5N9wg25bl+xahYPo3m4myl2r16vJQULrmRcnZtKyO9SFXGw1g+443nIZEcAofVPdobq9x+0t2G6Q7wbxsKrefB5PbBCGYqtr1H6Y2oyxky+cRrP28zttP/kn9bu6T72jw8vGyPpt+vTlVdoo5HRK/u3djPv5GeKqLqrS+SU5Nf5Xct9ghTxgM0zKjfojyKmckyO/DUTmWv2JMEA2Rb6cE1zHdBES5ckkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfUPM8yzfWG0goGv+/cuggm3shhm80OYm8Fw4JUaiQI=;
 b=MnndsLjz4PgOLrOrL2VSNyynqbL+k79BuY8Siop+IkK8ww7rIk64SETEZeE/7M2+K/PXEiQV/I5pPANX15URmhfnkcH1SdF3TzeV07Pxp/2tos0i7vANAPPfnDhNmiqnLL5s4QL2BDVdMtBYEdhqkQ6Ok3cKObd1ikBsdvah/CjkjhDTWBcmt/gs8+Bd2KZfb6irZHxiXQF0w9c/XTX22D7oa0dHlrmsckdAJ5AALKZzcmodUZ49yRMdnbqcydRThwKT7anwgSooHZX4ERa1CXqbo7aaD4G7bg3q3bp7YCNeOceWqb60DR27b0PP7kL6dOAAB97YVqkZGvbsAIn5Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfUPM8yzfWG0goGv+/cuggm3shhm80OYm8Fw4JUaiQI=;
 b=Bh76p3ReRM6YNQFAojzNNyPtBNn7ksLZpPlmcbIZjDxk0C9wFzrmSeUOtbGUIkE4Uv0quDTCXGoU5nXCqbUvJcXc5Tfi8V3HSM+GNHCI6BGpShEggND+T6WqtWeOqnSbTl2gC6nXL7XPGLHe783eQS5Ytikfh+aYYyQJ8hDdhLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by PH0PR12MB5632.namprd12.prod.outlook.com (2603:10b6:510:14c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Fri, 13 Sep
 2024 12:43:10 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947%4]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 12:43:09 +0000
Content-Type: multipart/alternative;
 boundary="------------ICaQlVe03Ed3h12QpDaSe7Gy"
Message-ID: <0c084cb8-255c-4818-9b70-55d8c5cacc34@amd.com>
Date: Fri, 13 Sep 2024 08:41:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd:Add kfd function to config sq perfmon
To: Feifei Xu <Feifei.Xu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking Zhang <Hawking.Zhang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
References: <20240913083234.54001-1-Feifei.Xu@amd.com>
 <20240913083234.54001-2-Feifei.Xu@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20240913083234.54001-2-Feifei.Xu@amd.com>
X-ClientProxiedBy: YT3PR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::24) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|PH0PR12MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fdcaf23-b3e6-4ac9-3134-08dcd3f19f55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0hQYk5xamZuelcrQWJXYUtJRWJNandaUFE3aUNSOUdtZ3RUN2xDTkw4M3JI?=
 =?utf-8?B?ZEdnRHJoMW51YWM3Uk9teVE0alpXVFVoQmNMZzEvMml0eXJSellTNm9BS3Vl?=
 =?utf-8?B?ZjhyVDFnb3haUEJTREpSTnorcjJQKzV3b3c1LzBXRGVlRXRUbWZyeXFEOEJw?=
 =?utf-8?B?WVVlV3I1azZEblVhUHhkQ1BQWTZ4NHp4VVd5UmZCNWdWV0JpaVA2dnNlZlds?=
 =?utf-8?B?ajJCVUtHWmFMUklUNitiNE1welpLVHhUdXdVN04vY1VTcjJwMW9xMGhBTzE4?=
 =?utf-8?B?c1BGdXhObE9SRUNiM0UxaDBKQTFMQ0NtUmJvTkZGWDBhOUJGdnFDSWdtL3BF?=
 =?utf-8?B?emtBNkxFZ2ZkY1JGNUpDT0VEdFB1b1hKM2FTN3hqbEJhT2JLZGY1ZU1OSHE4?=
 =?utf-8?B?c1ZxRDk3akl3bUI0Y0xCTWJZTXZuZk50RE5TZ1Z3dzhhKzhDa0d5MXltWms0?=
 =?utf-8?B?cFFNcUY4WURTQkxWdThGRU4zUWpJTXZaeklScHN0eHNXam5FMHBuMUs3RHRK?=
 =?utf-8?B?TEVaajNSMytuNTU5RTNJQzF5L1RwMFl6ejdPZTh2ZW5RcXMwT2xhbWd5ZDls?=
 =?utf-8?B?SUVsWVloUU9Kbmw5VVF0OVRJY0xMLzRwMUJIbzQyM3lBZ1JOTEtXb2tRZCtt?=
 =?utf-8?B?YkMyNWMyd2lrRElHWE5QOUR4RXRldWdGclpOOUwyVUV1VlVHcWdCZ1JyWnFO?=
 =?utf-8?B?MFFndklkVXlCRmNyekdBVDJ6cHhURUMxR0JpbGcxQnlkRS9BcUlQVTlGOXJy?=
 =?utf-8?B?WE5wczAweVY1azZzbEl0MW1zMHljMjcyaVJyMGVOSkdJTUJpZDVLcysvSE1l?=
 =?utf-8?B?YSt0eWlvbGxiSmZiWVF1TTFaV05VTVloOHh4SU1XU0J4d2dtbG1EQVN0Tmhn?=
 =?utf-8?B?cUlNM0lUdTFpWEFPSnZxZXdDcU9pN1d4dU96Q2sxbUJOSTVBR1lwVnVSRzN1?=
 =?utf-8?B?M1F4QzBEaHZOSDBiTGc0b3J4ajIyNHl4OWNYTlhjVGpvalYxWHRuOVlpMmtq?=
 =?utf-8?B?MkJubHZ1eHI1QURRZVBtVjhPbnljZHFHY3pVclRESy9MME1haWRuWWJ0a0pH?=
 =?utf-8?B?dXdvcjZhdi9YWmFFOENOYXk4UlNRN3pzWEpNTWJUa0JsaVVEdWxLcnNXb1V6?=
 =?utf-8?B?aVJ4TzlUVkxETnMvL2tLMDc1bmZOUk9QbGl5ajJYdWpIbHROSXIxSTBXbnpX?=
 =?utf-8?B?cGhFTUNCMEpzcUQ0cEQxTUw2WThFNFZhZVVJZW1VeTRVUjZzaTlkUENWUjlK?=
 =?utf-8?B?cXY1S0laNS9CVnkybzJXS0JDcWJNNTdTYyt0UjZjRjFTcWJaNTRIMDZJZDZD?=
 =?utf-8?B?eVljNWM3clVTUGNBdjdhcVV2ZTFPdDlpc1RQM2RmMUR5UWE4SVRja3hudWpr?=
 =?utf-8?B?SnRDOG9JNHJwVDQ3ODc2Sm1SOElneUtJZkpRTDJuQ28zckttTXVqUjBldHRs?=
 =?utf-8?B?SWpHdDFlcWttcjdKdEVBalJmWXJiRWdBMEsxcVcwY0s2aHBmZnNaY0pKdlhk?=
 =?utf-8?B?THhhd2dvVTZtRENCelh4MDJZanNNcXB4MnJyaXRacHVvdTdZNlpWM3pnZERl?=
 =?utf-8?B?Z05JU00vZldXL1NxMGsxQUFNYWhSdDVQYmhYeU91VHBEWFR1Snh3VE1ZUXBa?=
 =?utf-8?B?ZGxsNDhjdk41SHZOMEttbm5oVFpVWkFvMXdXY2RWZmtiQVlvUnRUQ2E0Rjdu?=
 =?utf-8?B?TU41eEhPL2hQMElsK3FHOGh4K0RaNnZrK1RkNXdVMW1DWVZiQktWL05VMVdK?=
 =?utf-8?B?M1RRNDhtK1NzYWFwTi9WQkVWVlFEdThrZWllUndoVlR1R1Y1S1dtcWNIdE1w?=
 =?utf-8?B?aGxaVHppWE0wUjBvNlpzZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGcraUpHWjJHd1NzVXdhVFRvZFNwWmc4aCtYSXdhT2JINXlYZGdTc2drNjhq?=
 =?utf-8?B?WnhhUE9vQ0QwV2lLUHRiaXBSekFZVzQvdmg0NTBLNUJYdlJRRUJqOG9iNURC?=
 =?utf-8?B?Zk5mNFI5ZTFua1dSdm9sOWt2QVVIT2JzQlIxTDRsenVHaXhYWDJvMXRtNENj?=
 =?utf-8?B?NzFqeWNqcWJ4bFhlenJwUDFrWnJEU2pKb3lwSWdUOUxwZ1ZtdmoxeXh2L2Jo?=
 =?utf-8?B?anVVTHJTTE1iVmQ5QlZmWUlPc0ZFeFgwTHB6OWhhczE0VjROc2dsUTRjR1lS?=
 =?utf-8?B?Qk0rTWZlTURiSEpJYVNSTEpySlU5THcyRk5wUk5waUg0YzMzYlVMc0tTYjk2?=
 =?utf-8?B?bGlCTkx0RVJhcDdpblBhaElMeXlzblFrYmpnOGh3UjBnSzV5dklrL1RCRHJT?=
 =?utf-8?B?dkVTRDdOUWhhUUdqT1QyMy9GUStqdkVMdlFoUXJCSjhTdFRCaVJHeXJnSlZj?=
 =?utf-8?B?emZXZGZjcERFUFl2WnpONmFvaDVlTGcrQlFwQ2VkSFluWkZGVlhRRmtTczJz?=
 =?utf-8?B?Z2doODFqd3B6MmxsM0dDT3FjMkw5UmJEVDRldXUxajlMQVVTMFFLL3RJaTZR?=
 =?utf-8?B?bnlvS1JtRW05SlVQWkY1ZFptY3FUL2UwMjFGVnk2L1k5ZDZ2Vmg1ZU4zNWpk?=
 =?utf-8?B?Y1B4WGI5a052NDA2STd0Q0RMTDlWQWJuelcra1RiOHl6dFRGZTRsS3Uxd2w4?=
 =?utf-8?B?dWZ6L3dEOWFNcnBKZ0NLZ3hVdmlpVXZhdnlhb2IxSGpzUWdISkhNeW5aOE9I?=
 =?utf-8?B?Rmp0ejJDWUdOM28yNlZ2aFUrZkVHSFBRMWVNTFhUbHdha3NwV3VkTWtWeVJk?=
 =?utf-8?B?RHZYZUo1U2NOY01oRW9DcndaY1prUVdyenA2bGl3VDV3Uk9udU5qeVRqdkpJ?=
 =?utf-8?B?NnZTekRGSWV6RjJoLy9zYXJUdGVHTHpEVy9GdkErVzVMakd4N2xjUXZQNmtN?=
 =?utf-8?B?c1pPRmtCUy9IQjlhWkJNZlQzdjhodjJ0Q3B3djVXak1BNGptZVF4Vm9XMFow?=
 =?utf-8?B?UWhpWE1RNlZ1ZWlRd3Y1ZlNOTVZRak16eStmWXBNWlF5aHFpaEJ5U0hONGM1?=
 =?utf-8?B?a3gxTFhDSDd5WVcyYU5CQmNKU1cxNHRBaXYxd1RGSWlCVDh5dVRwbEJFeDJv?=
 =?utf-8?B?TzRCSXFrMGRqZkxaMjA1VklTVjZnQ2lLVUt5L1dWSFNCTzR0VGRHVUhxOTYy?=
 =?utf-8?B?ZHF5VjNOamZ2Q1ZMb3hLVjljQW9FeEV2b1RCczFJaDZRZE40SUgvUXlPSjNM?=
 =?utf-8?B?cmVUWVpLRmZ1b3V2cVR0bVdsQ2taSWdnR1dleXBEamJObWtJWkQ2T3hLVEJJ?=
 =?utf-8?B?cWIrWWdSb2pQYW5talV4cmY3VS9xWDNndVJldjU1UjY5dlUzNGx2M3BaQnpp?=
 =?utf-8?B?SWw3RElXWlVrU1phaDlwK3NKZHRteVNQeHVnanY2WDhEQkxKcjJiNzNveVcw?=
 =?utf-8?B?WE02bXRubjMrZno3REpwZzd4M3lXR0ZEa3Y1aSs4OFE5T0FzUWtIaFRrdW9s?=
 =?utf-8?B?eFQvN1E2N2dsWEZIS0RTT0ptZUJHNzJ2QVoxbGdFNTlESUZKK1l4bFlKZWZl?=
 =?utf-8?B?ZG0rb1lGTkdHalE3dm94Y3p2N0tyVFBqM1FLWXM0WXhNQTJYMXdsZVg0VXdR?=
 =?utf-8?B?akZST0JtMzVUT1pWbDJ3Mm56UmQ5NWdHQVVibkdYLzc1N2FldFJ1Q25iaXl2?=
 =?utf-8?B?VFlKcTlZV1lhUW5DeUx5U09RdVR0U28rcGNTby9SMWdTcUIrTTM2Yld2U3Vq?=
 =?utf-8?B?RmVOSE9DbEVNaGFUMWVGSDVjWGtvYlJkSGJsOEV3S2JKbm5tSGg5bFpTazVC?=
 =?utf-8?B?eWQvbnhpRGcvaGx2TFhJOEFKckg1Q2tlYVFIM21Ka1BTb0xuUlNOeDhCQWYx?=
 =?utf-8?B?WFpQeGVvb2c1UUVRbjRDSW5icUNFaEFtUmJYQ280QXJyRmJ1ZXdtejV0NDVN?=
 =?utf-8?B?YkNvd1g3aUZGdGZzL1pvVE9TZzJqZUtocjFMNTNqL3FselNvVmVwRHpOVS9Y?=
 =?utf-8?B?SldEejUybmwvYWxiK1ZqYXBFMmRUUDB3Y3RSVDBpeUMrK0VLRXA0UnJpSWd1?=
 =?utf-8?B?K1E5K0JuOTBJcm1RUTZGNm5wczJzamNPVEVGUC8zUWNHKzFydlhQRk44Q3ow?=
 =?utf-8?Q?bcUC4jOjR+t2Im4k6ZmF9+DcU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdcaf23-b3e6-4ac9-3134-08dcd3f19f55
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 12:43:09.8262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vw6l03el2cU5Wn1oUgE2IGN3SBQnVagpvSQr5eMBECG7NzNN5MPLHkyFpTaAw1Rw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5632
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

--------------ICaQlVe03Ed3h12QpDaSe7Gy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by:JamesZhu<James.Zhu@amd.com>fortheseries.

On 2024-09-13 04:32, Feifei Xu wrote:
> Expose the interface for kfd to config sq perfmon.
>
> Signed-off-by: Feifei Xu<Feifei.Xu@amd.com>
> Suggested-by: Hawking Zhang<Hawking.Zhang@amd.com>
> Reviewed-by: Lijo Lazar<lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 15 +++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  3 +++
>   2 files changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 4f08b153cb66..203e669fce5f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -889,3 +889,18 @@ int amdgpu_amdkfd_start_sched(struct amdgpu_device *adev, uint32_t node_id)
>   
>   	return kgd2kfd_start_sched(adev->kfd.dev, node_id);
>   }
> +
> +/* Config CGTT_SQ_CLK_CTRL */
> +int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, uint32_t xcp_id,
> +	bool core_override_enable, bool reg_override_enable, bool perfmon_override_enable)
> +{
> +	int r;
> +
> +	if (!adev->kfd.init_complete)
> +		return 0;
> +
> +	 r = psp_config_sq_perfmon(&adev->psp, xcp_id, core_override_enable,
> +					reg_override_enable, perfmon_override_enable);
> +
> +	 return r;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index f9d119448442..7e0a22072536 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -266,6 +266,9 @@ int amdgpu_amdkfd_unmap_hiq(struct amdgpu_device *adev, u32 doorbell_off,
>   				u32 inst);
>   int amdgpu_amdkfd_start_sched(struct amdgpu_device *adev, uint32_t node_id);
>   int amdgpu_amdkfd_stop_sched(struct amdgpu_device *adev, uint32_t node_id);
> +int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, uint32_t xcp_id,
> +	bool core_override_enable, bool reg_override_enable, bool perfmon_override_enable);
> +
>   
>   /* Read user wptr from a specified user address space with page fault
>    * disabled. The memory must be pinned and mapped to the hardware when
--------------ICaQlVe03Ed3h12QpDaSe7Gy
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>

</p>
    <pre style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">Reviewed-by:<span style=" color:#c0c0c0;"> </span>James<span style=" color:#c0c0c0;"> </span>Zhu<span style=" color:#c0c0c0;"> </span><a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a><span style=" color:#c0c0c0;"> </span><span style=" color:#ff9d04;">for</span><span style=" color:#c0c0c0;"> </span>the<span style=" color:#c0c0c0;"> </span>series.<span style=" color:#c0c0c0;"> </span></pre>
    <p><style type="text/css">p, li { white-space: pre-wrap; }</style></p>
    <div class="moz-cite-prefix">On 2024-09-13 04:32, Feifei Xu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240913083234.54001-2-Feifei.Xu@amd.com">
      <pre class="moz-quote-pre" wrap="">Expose the interface for kfd to config sq perfmon.

Signed-off-by: Feifei Xu <a class="moz-txt-link-rfc2396E" href="mailto:Feifei.Xu@amd.com">&lt;Feifei.Xu@amd.com&gt;</a>
Suggested-by: Hawking Zhang <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a>
Reviewed-by: Lijo Lazar <a class="moz-txt-link-rfc2396E" href="mailto:lijo.lazar@amd.com">&lt;lijo.lazar@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 4f08b153cb66..203e669fce5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -889,3 +889,18 @@ int amdgpu_amdkfd_start_sched(struct amdgpu_device *adev, uint32_t node_id)
 
 	return kgd2kfd_start_sched(adev-&gt;kfd.dev, node_id);
 }
+
+/* Config CGTT_SQ_CLK_CTRL */
+int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, uint32_t xcp_id,
+	bool core_override_enable, bool reg_override_enable, bool perfmon_override_enable)
+{
+	int r;
+
+	if (!adev-&gt;kfd.init_complete)
+		return 0;
+
+	 r = psp_config_sq_perfmon(&amp;adev-&gt;psp, xcp_id, core_override_enable,
+					reg_override_enable, perfmon_override_enable);
+
+	 return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index f9d119448442..7e0a22072536 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -266,6 +266,9 @@ int amdgpu_amdkfd_unmap_hiq(struct amdgpu_device *adev, u32 doorbell_off,
 				u32 inst);
 int amdgpu_amdkfd_start_sched(struct amdgpu_device *adev, uint32_t node_id);
 int amdgpu_amdkfd_stop_sched(struct amdgpu_device *adev, uint32_t node_id);
+int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, uint32_t xcp_id,
+	bool core_override_enable, bool reg_override_enable, bool perfmon_override_enable);
+
 
 /* Read user wptr from a specified user address space with page fault
  * disabled. The memory must be pinned and mapped to the hardware when
</pre>
    </blockquote>
  </body>
</html>

--------------ICaQlVe03Ed3h12QpDaSe7Gy--
