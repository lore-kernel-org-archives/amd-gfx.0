Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDE5CCD1BF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 17:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF9BA10EB2A;
	Fri, 24 Oct 2025 17:12:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sJAIXHI2";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012045.outbound.protection.outlook.com
 [40.93.195.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AD7210EB26
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 17:12:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbLoOxpqb4WJj0v2upeTmGeR25R6VQ/s+t9nKoeK+ufZWG74MT+TznzIvTlG52rAyhl7m7tBjbaqO/zZfFRAEYIXFRZX0hBJp3xEY5zD0aYNd1uh0LwA6TJHPkp1ERMMK0SLAo2NSbzrRnRY7cGsnbSWubYaFvV6ZB93nxNBcPwcnckTL8ZIRhbTKDQFhw3ojnwlpFrFb41Pv097c5YNHIp34zn3vcucwgwYXuIgZZxBXRo1euw1ueI6tUf48q7e1WOFJiyQ4SKp3GwDCskou/RLTSI4aogTV0vSwdv36dUb3bpkBytprLt9JA9c7/ZftSUuNBXltaxx7V1G3krP7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gqvreXKCP/k/BuaOJHywiAOAVPHKHUUebGf/AoOhsE=;
 b=xjejc+dW/eAMhUrXy2x+pqJnaXl/TL3oUDUj8kKftVomWbxKkMX0J9acdECSL5NH5bUfO7pEI/UqF074uo53wHTiOXKjihhOS/Nnme5H8vs5CYSxM7CBtmMnmIkHHjG2MAXak1erbG+rfym0GIztmmnwiw94NDsBNQak2iFso8M/U+UhmveMdnzrjCQjFDUUmcpXkP7mxli34zp2TXtvE5jX5z6MJES0QnxMayUCSmf16+7A85l4RR4U1H6hiHLZGrfb0UpB1EwAZ6HwhceCOub7tKrdGEH1TzNJKewBboCiPdwH/Yl/rn9OTmPOvMVUCbR1iKt1GyXBNUVZTrBcoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gqvreXKCP/k/BuaOJHywiAOAVPHKHUUebGf/AoOhsE=;
 b=sJAIXHI27TKht4qNNltbqU7e3JnrTg7QMY5hvX8Mc1ARPDyHptgEvUkJ9Ofa7xV8msFLcgGmGvJsIV9LnztQWarpC732iD9NsHjl8aUR+YxoJKARyYBZOXuHhiDdnZ40wEl0f804JmM0LHLMZEc+5U73BUYFn+/FIgF4FYk1cz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB7960.namprd12.prod.outlook.com (2603:10b6:510:287::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 17:12:07 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 17:12:07 +0000
Message-ID: <7f08ca96-a028-4249-aaed-c1b58b1daba5@amd.com>
Date: Fri, 24 Oct 2025 12:12:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu/smu: Handle S0ix for vangogh
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: lkml@antheas.dev, bob.beckett@collabora.com
References: <20251024170811.57760-1-alexander.deucher@amd.com>
 <20251024170811.57760-2-alexander.deucher@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20251024170811.57760-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0008.namprd11.prod.outlook.com
 (2603:10b6:806:6e::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB7960:EE_
X-MS-Office365-Filtering-Correlation-Id: acd37a0b-31c9-4deb-0aa3-08de132075d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjRMWEtNQ0I4dnJwaGNFbm9oMHNMOXY0ZmsrbUROSUJvWmtiZ2xLNlU1TC9K?=
 =?utf-8?B?c2d4TGJuWEVNMUxGY2ZkSmhINjNpZFYvZ0t3K0pRNDFGMjBvcDRwS1QxaEls?=
 =?utf-8?B?a2VZOXcwbkN3VzJBRmlMajBmMjJvNGVtalBzK2hvWTFXYVd6QUk1TVVhNVBW?=
 =?utf-8?B?aExPZjk5eDNsZ096TjR1OVh2Y29HNnVxTGJXcE05WVJrVm9Zb0ZMRFhkYmh1?=
 =?utf-8?B?L0RQTWJraEhvV0NNUTYrNzFQR0JlZGZiV1JqMjhhbGVhSHgrZ3NRdFVxWFQ5?=
 =?utf-8?B?dXlvcWY2d0RnRDNsM3FaVjRFVk9mUzFESWdHUEszaHpUYUR1Mjhya0tjMW54?=
 =?utf-8?B?SENHcHNqcjIwWkJZYzV3RXZvWk9XNHRnMHpwMjE2T2hXdDNpY2JyMFc5VFBk?=
 =?utf-8?B?bWl6TFN2cFZnWDBmQ0R4Y0dHdlpDYjRXWXZYNnFTeW1kd0ZUKy9hRG9hRDND?=
 =?utf-8?B?bTR3eUVtZ1Vhc2JNYWRZQVBjS2tXZ1ltcytnM2J1MEZuQ2FscFNQd21Cdk5W?=
 =?utf-8?B?NjZ2ay92MFhZZEk1QllvWEc0c1hJQ1ZrT3dkc1pvMUs4R09BbWxxS2pWUDNO?=
 =?utf-8?B?S1ZESWZxbE05L0Z0ZmFOZjczRFpIOFpqbHNsKzlQb1c4UHIydEpPQ1ErTytt?=
 =?utf-8?B?VHM2a0UxS1gvWFZLaGhvS2V6K05RSVFwdmJidGlORUhBV2tDYjluelRiRjY2?=
 =?utf-8?B?WjAybUF5ZlZZcmJCMmpUOTQrQXg0VmZFWmJPS3hqWGlYRGNrM0VOd3RxZ05l?=
 =?utf-8?B?SU1UT25vOWRldXJmT1QwdTJ1T2huKzZwemsyQVp0L0g4ZXd6OUorUG5IeW5u?=
 =?utf-8?B?V0pkRWIxMTRnSThEblQ4N1FmUVpGMVRmakMvbzZiMmVUSHdra21qQjZDeUpm?=
 =?utf-8?B?aElxUFpVRDdIMS9MR2dNYlM0Z01zL2dzSXltN2VFaVNXMUR3a3haTlVxa1FC?=
 =?utf-8?B?MTJHWVhtY3JFVTBJeTc0QmdtRmk2RFBJc0FIMVNxRThFWkdmWnloWkdjZXZU?=
 =?utf-8?B?NXRkMUVqYTVJRGZ1NTJ5VmxYUSt3WTZUVGtDU3pUbTQ5a3dpYURnbVJ0eFB2?=
 =?utf-8?B?ZFMrbEZ5ZnpzWGpZRGRhRyt3OGdRV0hxUnNBd3ZrSDBtc1ltN05xa0VVM1Bv?=
 =?utf-8?B?TndTZG1NN0dmN3J4T2JqT2x4elZMRGs3UHhETm5Pc2U5Q1EwVTRsS1BoemZ0?=
 =?utf-8?B?QzhObGREcGpKd1hOTDVoeTZ5YWphU2RmRGhpSWNZMk1QbzU5cnk1U1AwWVJE?=
 =?utf-8?B?bFlUZE9tYm1PTXJ0NVh0VHQvU2tBNHJ2QVI5M0ZmNHdVNDJXdW8yY3puOW1i?=
 =?utf-8?B?QVk4aUlFYVlsRGozNXhRUVIyVkxIc1ZaOHgrKzJIRWNicjE2dVFnKzF3d0dN?=
 =?utf-8?B?RTNiZVVWTGFkQXhOcUNPU2E5QjRBUU93TGdKeGJzaFRRNDFGa244T3FsZEFH?=
 =?utf-8?B?V1FwWURvajJFTWhXb09rYU5EV0xOT09vcGxGdUw0ZGdXSkRCRjBkZlZvbW5k?=
 =?utf-8?B?YVU0RDByakVtbndacU50aTNXVEhKL2pOeXhSbC9SS3N5bEQxQzZUWnZlM3lZ?=
 =?utf-8?B?d2Q3Qy9udFc2NWFheHFNY1F4T0ZuQlpMc290akZQWGxZSXVzbXJQRnRuaTd4?=
 =?utf-8?B?QWZoWFpFanhUSDNSMHl6VmdZc0Jad1JQTGxQMEtUL0hJZVVnRVVZZCtvc04z?=
 =?utf-8?B?a1MybmRoTmZGT1ZRWVdZUFEyQ1BVbnBER2o4dkNzNkI2ODdDRFdZeHEyeWpK?=
 =?utf-8?B?Y1NMbVFaRi9uRlorWEV6Y3R5aEE5YURyR2puZUF1Vk52RHAzdm4yeFFCR1py?=
 =?utf-8?B?OHJnSk91bVN1aGs0Qi9HVnpCd25DdVo1c1R3RkJZUmJNN3cwWVRtQU9BUEhh?=
 =?utf-8?B?Qi9tUnVoTTBMUjNYQ2dwbldxS1lVZ014ellNQllWMDc2d2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2NuSitxUEgvQThnMGQ3Sk5PK2UrMGZZMy91eFI4RDdpQ2tIQnRsajBJUk1i?=
 =?utf-8?B?TnlFZFNqQkx4cFU2clVKVmFSc2trcFhoZCt1eStIK2liNzYwVFV0dkZ4S29Y?=
 =?utf-8?B?L1R1anAvUmJGNHFlOGlHWEFwcUlWRCsxWDlDOFdrZ3VSbEZ2UUpseWdyM2V0?=
 =?utf-8?B?YVdyNXo0M3lkanJqc1V1akNGZ2tacjJGeFdEMzFuQmxFVVJYUHFBbnFvL0tQ?=
 =?utf-8?B?Zy9QUElTWG9yenloZUlzUHhUdHA4ZlY0dFY4amFQSFg3dnJiYThsLzllc0tR?=
 =?utf-8?B?bEZhM054eFNOc1o2czJNWU9YUnpsL2crS2NzaG1zSnRBSCtKMDBNVFNzUjRC?=
 =?utf-8?B?R216N3h6TGVKaWl1d2tEK2NuamxDT3poRmpxQ0MyeUdZQktrS0Zuc1N1TlRs?=
 =?utf-8?B?T3A4M0ZDYURGT25ZUldPSEhhZ0RwSENoVUxLTVduVjQra0hLM1U5UEQweEpy?=
 =?utf-8?B?dUJWb3htNDRwemphNmEybUJnbmZKUWVxVjBzTndFUnRrVVR4eVhqaWcrSWhU?=
 =?utf-8?B?WndobG9hemJScEdwK3Qwb1pPbThuVXBVZFVqeWVobExjN1BJU2Y0Ym5mMGg3?=
 =?utf-8?B?MHVzVGVnNjJFaGtYZHAvZVFseDNHNWdPTVRxOE9YTldhckNqTm05OU1GNVdO?=
 =?utf-8?B?VDNrOVZkdTAxZXhUdjVLYWF3Z2d1V1ArOFlOV0lJalFaT3I0b2t2VHJBRXl2?=
 =?utf-8?B?YWV4NkNFdzBuWjM5cThtcEtSOWQzK0tSdjVwZEkxMHVBTlR0YWU2TDZwRWZU?=
 =?utf-8?B?RVlQY2hwWE9YOERxZlFFNndyRmFxOFkrTU5OWjg5QjJDVkQ3bFdYMkRPSmU4?=
 =?utf-8?B?S3FsWW05dGM0M0ROVUFpNWRxTklqZTZUdjBhd3VUNjBxZWFCZW80a0lXNWIv?=
 =?utf-8?B?ZEhqTWlNSmVnMW9UUUpOK2diWUF0MUl0bk41UmduS1ZSckdqbTlWV3EybE5Y?=
 =?utf-8?B?QmtDK0RCNUh0UjN0eW9zZjBpZUh4SEY2aXNjbjQrUy8zUVBkU0FZamt1WXVw?=
 =?utf-8?B?REU3YUU5UHF4VVlSUWpabithcG9taHJZMHJYZHBpK2w0cUU3cVVHRUVmNHRz?=
 =?utf-8?B?TklUOFZmRXorK0lCOXp4YXYxdlovcVM2SUh2QVF1MmV2a0NqSXgwVTJsYkVl?=
 =?utf-8?B?NTg4cjltUjk1Q2JraTFrcmdrNWx1VmtpeStaK2wyajFkWmwrSUM2cjl0V1RR?=
 =?utf-8?B?SlRPcXR3QnA1bFVjSFg3NHBuc0lqUFdKbTQvR3p3SDRDQkVpa2JUUkVLV2VC?=
 =?utf-8?B?SEdVbE5SSEI0a2lsRk9GOHY2QWNWMEF5aXhjNjUvWWRwcmx6WFI5d3oweW44?=
 =?utf-8?B?cnluQnVHMFA2T3V0dVlwWEFrSEw0SDhzVlp3azNVT3dMTzVUR09VRHp5azhh?=
 =?utf-8?B?UEtjODllRDRMQThnWFhEenhQL09ydnZ5SVI0bEkycnF3UW9wYytDNGZwdkNx?=
 =?utf-8?B?NnFLYkNDQ3Jsb1ZDT1pSK2pPSWZFNjlIVDhTV1ltQ0c5MHN5NUlKdkZ4NXh5?=
 =?utf-8?B?OEp5S2crSzFUaWdIQXA0NkV2NXlnNGlGODFMRU9JM1ZwSUxKNDdOeVFUaW1h?=
 =?utf-8?B?VmZoQi9BdERoOXVVQmZubmJFVndQRmY0Z3J2Q21uc3NrQUFlK1BnaUsxc05F?=
 =?utf-8?B?VVczY2JGMjR1S24yby9hSDBDTnlJMWppN0J2Wk9wYUd3Wm5OamZYb0duQys2?=
 =?utf-8?B?dWRrNTFXVUlPVlptYm0reW5XZmFwSTcrOU42dDBmZEl4ODcwSUlkY3ZnaVQ0?=
 =?utf-8?B?YnNnL2M3c01xMENmdi8yRER5WWdBUEhuaGppczNBaWE4ejYrdS9EUVl0aVhy?=
 =?utf-8?B?Q3VtZFVBdm9lREdiYmdaYU05OUNJQjRoUGpQbWttSE1aYThsNFo0NjhwTmhH?=
 =?utf-8?B?VUtCRmVneEV6SStjdzRzMHVKVmRLWHl0ZjdqM2VmQkYyZy9IdFNhTkhEakV6?=
 =?utf-8?B?QkFYSjdSaVhtMTBHc2Z0dlhMOXc5NDNLS1E0bUZZbHNYQ2FkRlREVUJRQjAv?=
 =?utf-8?B?RTJlTkxoUUEvS05DeHRhQnJWN0ZtZU1ESVFNaXhwRXRUeFFZTDhUdmIxTzlo?=
 =?utf-8?B?WW1YUHRTeU9WTUNNdUtCVDBRRWNkeGtLbzlTbzRtcldEcGxiSGdGVlJJaFpu?=
 =?utf-8?Q?YtwOcAGsnpJgTKPaD//VxyDcl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd37a0b-31c9-4deb-0aa3-08de132075d4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 17:12:07.1416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qIWuYJvtOUbz7HGGj133YgIin8CqyR4Eu0AlvGo7HysRUK71G4OkWyvJBbvKm+NchvxRluWk3v52z4F3aymjng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7960
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



On 10/24/2025 12:08 PM, Alex Deucher wrote:
> Fix the flows for S0ix.  There is no need to stop
> rlc or reintialize PMFW in S0ix.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4659
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 6 ++++++
>   drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 3 +++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 10d42267085b0..5bee02f0ba867 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2054,6 +2054,12 @@ static int smu_disable_dpms(struct smu_context *smu)
>   	    smu->is_apu && (amdgpu_in_reset(adev) || adev->in_s0ix))
>   		return 0;
>   
> +	/* vangogh s0ix */
> +	if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5, 0) ||
> +	     amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5, 2)) &&
> +	    adev->in_s0ix)
> +		return 0;
> +
>   	/*
>   	 * For gpu reset, runpm and hibernation through BACO,
>   	 * BACO feature has to be kept enabled.
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 53579208cffb4..9626da2dba584 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -2219,6 +2219,9 @@ static int vangogh_post_smu_init(struct smu_context *smu)
>   	uint32_t total_cu = adev->gfx.config.max_cu_per_sh *
>   		adev->gfx.config.max_sh_per_se * adev->gfx.config.max_shader_engines;
>   
> +	if (adev->in_s0ix)
> +		return 0;
> +
>   	/* allow message will be sent after enable message on Vangogh*/
>   	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
>   			(adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {

