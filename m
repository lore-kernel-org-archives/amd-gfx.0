Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70359CE7AA8
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 10:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DCD710EA45;
	Fri, 14 Nov 2025 10:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0cZL+TxS";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010065.outbound.protection.outlook.com
 [52.101.193.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 419D010EA45
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 10:36:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqHuQAD75lnL+VRw+3LP5ml5DMQFlAe/fO5szBncg7MUEC7kXSLWyf/IQaCdI8JHGqA5A75Tqzvs/ChVxiKVneNzxfCFxHwMhyEk/DZY66Lwrtk/XF0owG1PYKNMn+Ngg2eZ6zZaYOYtT1NwiY0MnwXMZd2BZUWlDWKSQUWc2sMF3eTCMNKYIzZghbcBPEUrJchgG/Fe8LAPpaTfne2RoyiMlCdiOLZRw6ue/N5IDosCAtSvjuwju5jlv5dWYV5UEj63BP/c3gBAomR4k5SwZQC53nAX5thGIwvLdwaA2+G0R1c3n9lrCxm8qPqEie32EkNLTZpTQdTH2uV5Rid5Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvOGTYBRRR1Lnf6ftnKvlFmVo/Bb7fvNN4T5tUgwYuQ=;
 b=TRcN42RgespIJzDvqzkEiXsS7ACT/SieEBc4S2smYK4+FB5RYasdnLLydGthLP8PziCEDCwDgrOISZTN3gQ1PexoY118tSE6lx00R04nTtT/ILM3CuSLjc736KbT+z2ha13YCD69xl1+uZl2nMZ4w9zf+PzpZIVMDuAimzKFg7Viwnvk74XlEox2z/ANEpbgsKuWooqJTR2NASby8ZyHdiqmWFnA67kdheM+Z4dHiQ6Hc40EcOHFioayQ4xbcwigV9t3UXy4OnZieZOo+lTqxkMHQmBeRzGkiXY4g8oaeJ1f6V1OpILk8Nq592mnqK0tTf5gjLXjij7kfH42vaxaSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvOGTYBRRR1Lnf6ftnKvlFmVo/Bb7fvNN4T5tUgwYuQ=;
 b=0cZL+TxSEapKaSdKd1CBXnNAq1QJfvzHJVGUat6Bj2Bgol9PdV+Q47VqEZh+rWuj9H8tQ46i7aQvxXQs+zI/OH81YCIZzqzcnOUrXd5xsOmelgZ5M8qAdM43zWeI271h2p7c7Tm+Ityl6HyEZ4J6MrgNpdBg1RSJhdZoF5a1qNY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4344.namprd12.prod.outlook.com (2603:10b6:208:26e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Fri, 14 Nov
 2025 10:36:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 10:36:29 +0000
Message-ID: <de8051d9-ffe7-49c6-9876-f34cfd70e7f2@amd.com>
Date: Fri, 14 Nov 2025 11:36:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Skip emit de meta data on gfx11 with rs64
 enabled
To: Yifan Zha <Yifan.Zha@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Cc: Horace.Chen@amd.com, haijun.chang@amd.com, Monk.Liu@amd.com
References: <20251114100719.4036094-3-Yifan.Zha@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251114100719.4036094-3-Yifan.Zha@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4344:EE_
X-MS-Office365-Filtering-Correlation-Id: a594d57f-f3ec-4597-d0ea-08de2369ab70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2hrS2tUUk9UNFR6Z0gvdTBvejFGN2dsaTRiNm00a09pTlljNnBYZjZPa3hV?=
 =?utf-8?B?dWdPRU83Mmk4K3RnTUV2cFUyb3BGa0wyUUVNV2c0SHhacjEwK2phQlRpL1hm?=
 =?utf-8?B?MG9DRCtTOVZoWm1QSW0wN0pUOW9jdFp1a2krY0lxMDZhL2ZOSTRqbG9Od2t2?=
 =?utf-8?B?ak03VnVKZC9BSHYwcnhRcmpReVBTYkRNWFZWMHozL2g1UWRHWnNGWjdRTDJ5?=
 =?utf-8?B?RmNrMkNtVkVBRDU2YXM4VHBYOWRZN0NqcmFPNVkvNnMxWS9JNCtMMTd3b09q?=
 =?utf-8?B?YjNPMjh2cnR2dHoyR1M3K1VnUVN0WFBXRXloNGQyWE91V1FZa0x4YWVzQkRs?=
 =?utf-8?B?dmtQZnp3TTRROS9lSm9YMTFpNXpmZzQ2ZXB5MWpaWGZuVGNwWFJ0Y0RUNmVy?=
 =?utf-8?B?L0Rwb3VmcjQ0STdnUWFFcGs0S3hWY1c2ZzJVanZZKzdJa0t1akQzOE92MVdL?=
 =?utf-8?B?Y3dPUEpIb0s3SmdGajJ0cThSS0RzTFFNRlBGNzV3Z2ovTktzUmV1VkhNM2ho?=
 =?utf-8?B?TEZLbW8wQi9OeXp6bHVXeDB2MnI5MFBSVmkvdzd4bmRBZCtNMjYvMUtnVE50?=
 =?utf-8?B?cVRSdGYraVRTVkw0aGVGS01HTEhveDRhMUxOLzdZSzAzdk9iOXh1UThrWElU?=
 =?utf-8?B?VWxSRDBQREwzZHJLQWV4ZGwwUGtRc0ZrbWw1ZC8yYyt5ZmJHNGxZa0wvVm43?=
 =?utf-8?B?ODVYMUZkMnJTeGNWZ0h3RWExWHhRQ1RQRTFTZU9ZeXUxMXdiU016aTBVUXpk?=
 =?utf-8?B?Rytwb1RxVVkzY0JuTklyTjZrbVdUWCtkSWN6NHFUUHpKZlpLUHNXMXBhUkVr?=
 =?utf-8?B?dHgwRGQzRUFZNHZ1dWFlV2FoZjZRM1BSRS9ISHBSdVNETDR4RzNHd1RtYmwr?=
 =?utf-8?B?SThNTTJ4d3I1WjZNUEZCL2tuYUNQdVVpSWNlejJtQ052RUJNRENPZHpQNEx3?=
 =?utf-8?B?amlHa09DOUxPTit4VS9uallXUWRvd1ljRkt1UUJ4MmdGOU5RM2s0T0owWmZV?=
 =?utf-8?B?Z2dIUVpiZ1VqY3Q4WG9VNnh2b2JTeGFYMFZqdFc2OE40Q3Y3RXYwRUxxQ1Zh?=
 =?utf-8?B?cWduWEVSdnZCQnVhWUJmTG9kMVQ5Nm9XZzRvd2FCdFhsaXhEb0dlZFZoMkhs?=
 =?utf-8?B?Y2F6WmYvbUsvSnJPQTVRMGZzZVFlRUJMWjRSaWVuQnlFaUpiTE5CNkcxc0tB?=
 =?utf-8?B?N3BTR285TXNPSjVwRG01cWFXTXM0Z2lkOHVrZ0UrUGFtK1AwSW1YVUVsOWJW?=
 =?utf-8?B?NGorL055UFUzVE5IRDhBZlFLdGZlbmRYZUtrZlhYTzZWZzNnMzMrL2MyMXNa?=
 =?utf-8?B?eGptVSsrek5NTCs5RHVpaWtsdWhRS2o1aDlYUENQMlhNSnZ2QzZON1NONklN?=
 =?utf-8?B?TWRGc1RKL0FVdU5JMnhCZGprR2NNOFJwbVdHS2lNSVl3RFE1L2tqUEJFTFhS?=
 =?utf-8?B?c0dGekhubFNURmdxOUhLZEJ4VzhyMSt3YlhKMkJjSzZRV01aMHFiUzUwNks1?=
 =?utf-8?B?N3NUbTU2NSt0cjhwTldVMXR6b0VOeFFwLzdzUkRTUWtoN3lwdzVNTk53cEVl?=
 =?utf-8?B?UE9ZNXM5WHgwSDc1QXVIaEVvRE9vS0N2SGpGNkRpZDYzRzZCKzE5MmV6WnJr?=
 =?utf-8?B?c1lza0o1Z0xoMjhubENqVzI0aU02RTRjUGw4UmdvdVFZckNDMHIyRmpLRnJJ?=
 =?utf-8?B?Um13SzdaWmRqSFVTL0c3MVYyWWl0NWtjUG5VZG5zMWx4RTQ5NytKdm0yNWlC?=
 =?utf-8?B?QmFvL2RyY0ZOSzczdHhWUjkzMkxYZnp0M3drS2lJa1hYVGU2YkwrUkFIWHdO?=
 =?utf-8?B?Q3BwekFpT1I2WitMODF5STNCK2F2elArbW54ZysxdmRlVTBuTFptL2JFN21t?=
 =?utf-8?B?ODRoNmd1NHJRbXBTSWZxQXFWVzJZSHQ4YmZCU2RSbDBkWm0zRUVMWFNQN21t?=
 =?utf-8?Q?JSxKQ/kHTzLvx5stUNqusDr4JTOlWASg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2ZkZDFUUWtUL2Y0V2ZJQmlyNkltVUpML1NhdzFnK1lvVzhTV3puUi9Rd3RX?=
 =?utf-8?B?UHV5bzh3cFpUS0UwR2pBd3VUUFFMSnVSb05qYnZRVVdWZ1B3anZMTS9XbDg0?=
 =?utf-8?B?OGRnZ1pMQmlaNmljQmZTcWNQVWtWcmJ0Ty9GWit5bWNDR3NlRUU0cjdsNE9G?=
 =?utf-8?B?eHdUK0dlSUtXcE9Hb2N6dE9oV3h3aXRYaVRmb3FMRlhjU2g3UDhDLzB5Q0px?=
 =?utf-8?B?UU5iYlZqcmZIdGk4YUdGbktieXBXRFNjdVlabzVvOFlyaTd3SGk4UFB6ZXZ4?=
 =?utf-8?B?QUEvL0RDaFhNQmxNZWN5M3FGVW5adXlXNnF3L1V6UE1kd0xDcVNtQnB1b3VI?=
 =?utf-8?B?S2t2WGx6VEEyOTBKaXE1TjRBY2JuWVZ6RUd1Vk1XYU5mVFl5M20yWVgwd2pz?=
 =?utf-8?B?d3crL1ZPeXdPV2JDMGJSZExMcWg3Sko5YVN2U0t2SFBZd2pvN1BKeG80OVRL?=
 =?utf-8?B?Q3h4RzNkQlJ6TjRjUk9XanZKNFlQQnpDSFBSUFNMNTRuanIzQzNuQiszQ09k?=
 =?utf-8?B?c2FRQVJyVVkvS1F3a2lrZkp5Zm5sZC96TmpuT1d4RTFWNTNOeHhTbU1scEE0?=
 =?utf-8?B?dTg1YjMyRXVvek1UdXRIdGN3eWl5eGxkWSswNjQ3MTZqbFNNaEtTNmZmOUhH?=
 =?utf-8?B?dnVKN3IxcGRYZEl5OHR5SENMTjNOQ2dta2IySksxaC92aG5id21kbzArQTFj?=
 =?utf-8?B?dzRwaDZRQXZzNUIvVEp5S2hleldUU04zWkczb3FoTWpiTXVhUzQxQ2pXaTcy?=
 =?utf-8?B?Nzk0RWFBdWU5Ukh3TTJkbXVTNmJyU2ZGcm1Zc2pSQlRDeXZJdys0SG9BaXNU?=
 =?utf-8?B?V0F0dng1Um5GUVAzdVNSRjZQZXZONVM0UTlDRzUrSW9ROHdiTUQwRXpFNTZL?=
 =?utf-8?B?S1lkcDJRL0cycUxKT2lRM1VsMXowUTJMMlRxalBZSXYxcFMxNmluVkVZS21o?=
 =?utf-8?B?azFYTW9mVGd6NWplWURreUV3VkdkYnl2RlNpdG1zaXhycldHam5RS2ZvOXYx?=
 =?utf-8?B?eUJPRm92VnlUdGxsRHZTeEFOc3Y3Z0oxQVhNaDNoN2hydklVUkMrWUM4SWMw?=
 =?utf-8?B?cnV0K2E1YjhURmZPU2pPV1dJeVZVaWUva25FOVlLcW0zT1NVSjdtQUhhcThW?=
 =?utf-8?B?ckRnR1lOSG5KNHJyOWs3RUVKRXN4eHVxU1JlMlJkakhyNnkrUGsydmtqSnFz?=
 =?utf-8?B?YUt4THlRVWxCWUFpV3pnMEZhQUxwMGtKUk1zcjRvY0VLMFFja3l0UFRTYVFm?=
 =?utf-8?B?QmVkWmdMeVUyell0cWJtSFl5QlJkZ0VGTU5QL3BRbjdieVBNWW1zbjFoWGFY?=
 =?utf-8?B?bTFXQXhyUDdtUGxRdmZORXhWS1ArZ0w2NkpaNWxhVVo2T01hSmFrSDFnemQw?=
 =?utf-8?B?am9HVGI3aHFLU1Z3eTRjbHYzdmN2ME5CZ1VURXE3WjVKVm0zeDJjblh3WUxl?=
 =?utf-8?B?eXd4c3cvVGhNd3IvNWRoWktNVW15eHJZTXpnR3NSU2VnTjNCaWtuS0hiTnY4?=
 =?utf-8?B?bzNaNW5zN2VVNE90WUllcGxTWndYR0oxdlBFMnZlMFhTOEoyOXNGYkxubm1F?=
 =?utf-8?B?Q3kwQmgvVHlaNHVCMkFRRDhZVFoycXd6cG1NOFBpSmxaSW5kVmtIeDJTTGI0?=
 =?utf-8?B?akZRNlZHbG4wY2RwWnVnNE9HL1BGUDRvM3hZK1YxeWNBV2UyWTM1OEViYlhn?=
 =?utf-8?B?TjQ3UXo2K1V5QWtyQ1g5U0dyOFB5WE4rQjY2dWJ1bFpkQ2Q4Mm43NjRUWnor?=
 =?utf-8?B?UFVVZTJIS0EvU1R3YlpmR3lGMjgzdGV4MUZTWW4rdG42Tm1yTXBqSUlqMjd4?=
 =?utf-8?B?Zk5TRFN0NXpUSVJEUUdoR3dDSnhFcEpQcFBRVStlM09pd291M2RyVlBkem1v?=
 =?utf-8?B?eWVETWNCMW5yZWNSZmFMN3N5MUFRUUtkWjVZMjhnMjVwcVIydzFpSGtNOXJn?=
 =?utf-8?B?K0loYXBZOSszV0RBWDZTTUo2UFU5MGVGcGd2cDRmMjJYdlFPZDM0b3JLSFpr?=
 =?utf-8?B?VldDTHlmRDN4NWpsQTJnVkJpdW1UQXZTVXFneGl0N3pXUmVoTlBPY3N6Q2tK?=
 =?utf-8?B?RXJGSjRLVFNoR3NMcnNpTGFpQTBKUkltVDQ5QVV6ZlRWS1F1cmF0ekJ4SWJH?=
 =?utf-8?Q?gBTZDavy/Bi7WWiGccOBVLmud?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a594d57f-f3ec-4597-d0ea-08de2369ab70
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 10:36:29.2064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3mlt/eOPbCmF5+xIEWEpJhQrOjgAdzm61c/Bbo0TBxCsrm1P+kyTGpp66VkcKh9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4344
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



On 11/14/25 11:07, Yifan Zha wrote:
> [Why]
> Accoreding to CP updated to RS64 on gfx11,
> WRITE_DATA with PREEMPTION_META_MEMORY(dst_sel=8) is illegal for CP FW.
> That packet is used for MCBP on F32 based system.
> So it would lead to incorrect GRBM write and FW is not handling that
> extra case correctly.
> 
> [How]
> With gfx11 rs64 enabled, skip emit da meta data.
> 
> Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 02d7cfae22bd..e4d525bf9d0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -5874,7 +5874,7 @@ static void gfx_v11_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>  		if (flags & AMDGPU_IB_PREEMPTED)
>  			control |= INDIRECT_BUFFER_PRE_RESUME(1);
>  
> -		if (vmid)
> +		if (vmid && !ring->adev->gfx.rs64_enable)
>  			gfx_v11_0_ring_emit_de_meta(ring,
>  				    (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ? true : false);

While at it please also remove this "? true : false". That is usually extremely frowned upon.

Regards,
Christian.

>  	}

