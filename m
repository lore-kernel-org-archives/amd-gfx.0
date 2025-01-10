Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5D7E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 19:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E636710F16C;
	Fri, 10 Jan 2025 19:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JQccodrj";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4AFD10F16C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 19:02:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RM/TKw6Gn7OXYBXRG3J7RlzEA3rIuAFy5C9PtTkJmPdcgYPnKSWI29UePRDHWh+f9vBAQ6c6m4dEaPLlS7F/03idxiP0Q936NPxRK2h6r910tqQDCJiXfqXhpb/PbLUJBSuyR8xFpvXurxF/CoKl6KYxA+QjM5lA47BFmPOL9Sh5rHhvjd0SKAVxaQp80TuvuidXM186nMDaHRMQlXkZlwLTe6vrEDVtdS8grX53NbjKv5byRRNCA0GWRM9InoZn+I7jiXRkSqm975qZ+hkQbLuoUxmXquHRSbHspJSlsEAVEuKY0TkMFcud+mYhUhyKy7svNXCBOg8I96DL/ZoF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwGARWtDzn31MY/Lr4do2N7Wc40DVVLrnxutfaorNI0=;
 b=Rd52lmz6B/IR1efZz9XaC21qugRfNz+jtdwI0McxvPtjzqPBQ8+o/6Pq4UTmRgGV3nm7f2dOaJhnSWavlpZvjsudyDgKA4pPICXjT4PdelgU+3RyJ3slPjFjVS9dr6Dhu8Xeotp5CELEp05XaVHBLRaFTX7KYxilYdnkfuyv4n20MlUJApVyO4HrKyOUDx0dGrlRcJfL5VMFTjrdkwMQVwP0DLgES1FFLHql0wI/t1K84kDAiOyFjo0T3SDU+0U0xnEKFwmI4UdvfcXFMwahOvGlPTzcK5z4APKaFCF1O9c6yiPwA3AFd0nV+VlAQG1hrMfZh0xYW7Oep5BXY1/UTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwGARWtDzn31MY/Lr4do2N7Wc40DVVLrnxutfaorNI0=;
 b=JQccodrj/6wNX6HYO/7rhdhRt4J9EN87iptJA2iX5NeZY0zRzZOkg/VQXOQhKzZmBkrcVdcX2F7OoEy9tXU6azVpMpbo9Y6eUiqqLOqVpSbmy6XXZmE6UGoEtEz1CoMdYC5pQtMdtM026h88qvvPD/YUPwVKRSMyRFthq7YBHJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 19:02:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 19:02:13 +0000
Message-ID: <3f2d18a8-e75c-4ab5-bf5f-48443c208e0c@amd.com>
Date: Fri, 10 Jan 2025 13:02:11 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 2/5] drm/amdxcp: introduce new API amdgpu_xcp_drm_dev_free()
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, lijo.lazar@amd.com,
 Hawking.Zhang@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736474822.git.gerry@linux.alibaba.com>
 <79267ddb1b1b8d83e2ec170f4b0b578c705de4dd.1736474822.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <79267ddb1b1b8d83e2ec170f4b0b578c705de4dd.1736474822.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0037.namprd05.prod.outlook.com
 (2603:10b6:803:41::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: b0f26863-9a37-486b-6ea1-08dd31a94b2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEZsdXdOcEsyMzc1SlR3T2dEcU10cVFYRTdFS1ZPYzgvTTdXenVrZ1BwSTVh?=
 =?utf-8?B?Vmt2OTlUcUVhRHhzRFhaS0QrcnZNdDJjRGhITmRpeTJ4R05ZZmVEZXJzUXNC?=
 =?utf-8?B?WlZJOFdxRXc3d2gwalRuS1VYQSs5L2hwb1hKSVdlNlR2TllLUmhXRWUrUnlJ?=
 =?utf-8?B?bnZSYWc5Yzh2Z2pKTW1oWGZ5U0lmL2dKbGFFU3FsU0Z4OXFvemdPaEFMK29l?=
 =?utf-8?B?UzcxV2ExWVlhVEw1WFRjTTF2TDZXQUhnRmFVdTN4WjFmZ3BhVWtUUDFQc2xK?=
 =?utf-8?B?NWJONWRKYUdKZ2JvT1ZoWDBORmNWMmJiK2JQbkpIVUxLVUt4QmtaaEo2aTJv?=
 =?utf-8?B?WlJBUGtTaGxOS2EwSkZlT2lwOGJTTkVCRVA0RGpZS25qOTZ0b1RJQW9DRHJM?=
 =?utf-8?B?aDhBYTZXbHlWWTFPUURxRFh5UVdkZE02VGhhb3JOVHdFaWc2aDdSRTNPWFdn?=
 =?utf-8?B?SHFuM29OeXRtM0wrK2NSUm9mRmJrcWtvVXNtWWNpdHRwUDVVbk85anpnN0Vs?=
 =?utf-8?B?L3F1ZXRrNDU5UWF2T0hNRnJyOEM4YXlmdThkcjJZYzZGc09WSmVxd0trWThi?=
 =?utf-8?B?WWhXYnl2RlZ4S1FYVmxPU01Sd1p3N1R2MVE1N0x0ZzluU0lUUVBsMFhjcjJr?=
 =?utf-8?B?ZzkxNnhORWtqUlM3U1IyVWdNcDNIalEzRk5iam9UaUpqcVF6Z2RsOWhzQ1Az?=
 =?utf-8?B?VUV0Y0NWTlVuRUhjR2kyV2ZybWlGemozc0hMdzB4ZjJyV0VuT01NbGxWRjZU?=
 =?utf-8?B?T3dIdGE4V3dVWlczWk9oN01EOWlTdFgxUEdsc2h3N2IzQTd1MC9Va0ZET0hR?=
 =?utf-8?B?VUluaU1GQlZwaDJqbk5BNXpuQkdPT3Vzd0dUQlh0c04wb2F0YUs1ZTlORjlw?=
 =?utf-8?B?d3NnMHBqUWk0dVMzWHd6ZXFER29HbmZPejlUNm9pSFNTdG15M3hBbFFCWnlt?=
 =?utf-8?B?UVFkVVFmei9CeWd1VjM5WWdZcDBaVHNFWFBxOFVxRDA0ZG1xTVdMc051NllW?=
 =?utf-8?B?SW5BN3pVOXVkdXVvTFZOc3Q5T3FUdHF4Q0hEYXpnMXM1R0JOY3gwdS9TOW9h?=
 =?utf-8?B?ZWFmN2svejR1SWxTTVA5T09KdXN0WlYxWDlvdkFIQ21xM3ZWZ2ZQZ2s1ejAr?=
 =?utf-8?B?SWFQWWMzVUV4VisyVG5VOW04bFdqWGdhMDhoY2MyYk5JSGhGVTU2cTRpTmpo?=
 =?utf-8?B?YUhITTM4N3pTejZFeUNGcHNFRkp2dWh2QUluUWgrS1AyWXZjRkR0VXpuMGdo?=
 =?utf-8?B?dkxyQVBzWkZsaVNlaC9DZE5JYTROS0J0NVFYeGNQcExHbFVNa1R3UndaNGpM?=
 =?utf-8?B?WGRsY0FXTUVzL1ppbGs4Wit0QWFPK2RwUjQ1V2UxTEJEZklkR2U2dTdsaWpt?=
 =?utf-8?B?SytHYUdHY3RVNUZwMTBFbjdMdVhyNDh6Tms4VzZTSFNoY3ZvSld1UkxvUHVq?=
 =?utf-8?B?SXFFTkR2aWx3dTFKSWdxMHByRDVUQWt3UkErUnFkbG9rVlArd09JZWg1NE9C?=
 =?utf-8?B?NVhXTXFrYzlrMFFuZEEwMXNmbEcyTFF3Y3Rha3JWMXl1QUw3VTNRNm42bVI0?=
 =?utf-8?B?dWROelgxZ2JQaG11WUpPenVQaHJYOHdOUDRQdnRmQTcrT0psdTlOTVBxU3Jy?=
 =?utf-8?B?QXRMdGdaSW1LMnhySkR6UVBhcFFwV21qSFU2bUtURmJCTW5XNmxwQ09mQzY4?=
 =?utf-8?B?b0EzcmlLYkQybkRzVjM0QTQxdmF5NXYvS0Y3RGprdmdQa0FwSU9seHNzNnpr?=
 =?utf-8?B?Uk02aFM3OHg2ejBSQmc2UTBoc3VuamdxRnlQbUJQVE44MWcxM1JSQzA4dHdz?=
 =?utf-8?B?dlp3SmxXVUJhNkJKUnBHckU0c2FOSG5aYkVubTNsVFViRHAzNWFvMmxIMGpK?=
 =?utf-8?B?dDlGNFNWOG54cG11RDdEcDdRSEY0VS9DaGlKS200c2ZOMDhaeWc5NHVVTG02?=
 =?utf-8?Q?CccztjfTcPI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmpyWnF4dUJEVUxweS9DZExjeS9FbWdGbzZrVENpM0xja3lNSkhqUnpYQUc2?=
 =?utf-8?B?TzYxaFhIZ0FrMDQ3T2FhSENTOVA2QSt3VDV4OGVVYkxrOVNKcVhUdUZMU0Vn?=
 =?utf-8?B?TFg0TjRQYjlLQWM5RFBxOEtVbkJmRlhaMjViVk1XRGcvMHdCQ1pJOUthaHIz?=
 =?utf-8?B?cVNHa29hUDdCOXBpQkI3OEVtTmZyL3ErSXhyZVFJYkJvT1NncDk4a3RsR0Fo?=
 =?utf-8?B?K1ZIaEN5NXlEYjVhTWlIR21ZMjFNZ0habm5STUhxTjhESGJsRkZkT1NGVEw2?=
 =?utf-8?B?WW1TMVEyempCRU1VNitRRTdpMUxUZldvMWVOckhHYnN4cENWbW1obUVNNUU5?=
 =?utf-8?B?UWF0djkyRmJPcWsySDlMN0V4SE9iUjdPRWlnWm94NVJWbkdwZmovVnRTTTI1?=
 =?utf-8?B?YXBHaDVoZFZSZ0JnbEM3VmJJQUpNM0JVWXMzRm5VRWZjS0V0TlVwY1BaUGtm?=
 =?utf-8?B?cWFsTlBubXJFSFh0WjdvNTZjUXVSRkZMK1ZhNjgrV3V2RjVHWWNjN09sVnpV?=
 =?utf-8?B?eVpuSnlHaUx6R250cDZTd0x0eVU3WVpMdUpOejg0d0Y1b2hndGkzN2pkMmli?=
 =?utf-8?B?cUx0bHlZSHR0RGh5SGlqZnhySUJ6L0gwUjR4UnlvbXJuc1d2bzF5cjI2WlRV?=
 =?utf-8?B?aEtwaHZiTlN5bE1BOUExNXFIdGZGMU9Sb3R4dzhZREFUck94dGNSRDlSbDR0?=
 =?utf-8?B?Q0pvdVRQOElSQzZ6VGlqQ1NKdFVyVVJBY0tZdm0wcVh3USs0QitNaUE0Y3Bw?=
 =?utf-8?B?NGc5QjVOd3gvTTFYRVhkZlZ6UHd6WGxuUFpFaDNadmwzV2xrK1NjTytveUhp?=
 =?utf-8?B?MGxuWUpDd2tkbThScGxHVEdFc0tUemN3ckdRcWNTTGphWk55V1ZIWjlscWtF?=
 =?utf-8?B?eElNZmNVM1FpV0xSZDd5emxPWmlGdHhWZXFKOTZ0b3B0QXVSQkN0OXpadmd5?=
 =?utf-8?B?YWw1aW8rZFAzN0ZyYW1razRnQnlLbkgxZ1c2TWJYc0N6N1lWU0lMNG9CV1Qr?=
 =?utf-8?B?ei9GdGRHT3JxUkZSMlZ4Q04vSURuNTg3cDFjNzZYOUZ4SElXYlRvOHc4VkVX?=
 =?utf-8?B?UU5vWjB6WUlnWkxhU1doTWR2bkJWb0NraS9uVU52dTJZUVNYMWJqcGkxZllW?=
 =?utf-8?B?Q2JxaGRvVWZ3MFUrSWZoeDEwUnAzZlVFNTRMcXBCL3kxeC9ZVFptU0IyeVZh?=
 =?utf-8?B?My9BR1RtbllHalViQXhVYUJJUjRDVEFPUmFqNmt2N1dvRW1QbDdKZ2lVMUhW?=
 =?utf-8?B?L3RZQ0JsREVoYmlWbzNDbTdIT1lwOTZOSUp4R1lvVk9pSEV1SGhUY1JmZlpE?=
 =?utf-8?B?L2hISHR2QzZpR2RvMkVYVWJFS3A2T2JnMWJ2bHg4Y0tjakZ5MUxaWnNBQXBS?=
 =?utf-8?B?YVlqOWhSNGh1NzVJbFpVMFRBVXUrekNpcWJYVE0vNEp6azBXeVVUblJ1YWpk?=
 =?utf-8?B?OHFaMm9RaGNsL0RCUG56anBMSTZhWFRUbk1VeWlyVjJBOFFYeVhxNlZReElh?=
 =?utf-8?B?c1FXVVpuekczbElObzZvWWNOL0tERWpCKzFMOEZxYWZYMHo5Y2NST0hmdFk3?=
 =?utf-8?B?REw2RTJUbFh5NG5GNjkyTFZ1Rlp4ODFrM3l6QW1DR0Q5RFRZV2V1ZFZaNndY?=
 =?utf-8?B?d3BLZmhTTGV4dlQrYW1EU2k3QzJCT1o3YS9LdTV0aGNCdXptMzJxaU1hNXRD?=
 =?utf-8?B?bzdETmxSQmN2L1pxb1NqT04xRDdlZlZ6c2tqc1NRWWlBUVZkdS9WZGNWZDZS?=
 =?utf-8?B?cmhQb0xka1YxVDFueC9IVjdMQmYwTTVYc0l1SWxYckM0ZHNXNUZBdGlQdXI5?=
 =?utf-8?B?S293akNjY1Zka2pFTHZwa2tpRzFDZnZzWmxNNE56YUV2dVNqUVhlWVlXbmtL?=
 =?utf-8?B?a2psaERQU0lsVFVoTkpTRzNjUVZBNjRaUzYwaHNFTlJBSVB2VTN3UWJzYmNi?=
 =?utf-8?B?K3dsWDRRRjZqQ1gxTlVHL1I4T090YmsrVTNIVGtaeGJ4a055QTJFVW9nNUEv?=
 =?utf-8?B?U210SUdWY1lORlp2cmtkUTd3d0xQMysrZ2tvdEMvQ2RPL0RmQnlpUS9oMjZy?=
 =?utf-8?B?alQ1b2lKMUV3UGtxZTZTVVNPbStFZlBHTVN2T0tIRS9MejFtL213TG9MT1dD?=
 =?utf-8?Q?T6hrmgbIVkGWLCaGC2QUuCEd+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f26863-9a37-486b-6ea1-08dd31a94b2d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 19:02:13.8435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYtPUOAKhWIMV6721CxgyvMS47Mo8UDe1fVwglgU0TNQQJ6wiYjQ0LHPy0yTYBF+OMLLlCWXTe94NdaEpJ1yJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160
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

On 1/9/2025 20:08, Jiang Liu wrote:
> Introduce new interface amdgpu_xcp_drm_dev_free() to free a specific
> drm_device crreated by amdgpu_xcp_drm_dev_alloc(), which will be used
s/crreated/created/
> to do error recovery.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>   drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 65 +++++++++++++++++----
>   drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
>   2 files changed, 56 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> index faed84172dd4..0473fe0479d9 100644
> --- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> +++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> @@ -45,18 +45,26 @@ static const struct drm_driver amdgpu_xcp_driver = {
>   
>   static int8_t pdev_num;
>   static struct xcp_device *xcp_dev[MAX_XCP_PLATFORM_DEVICE];
> +static DEFINE_MUTEX(xcp_mutex);
>   
>   int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>   {
>   	struct platform_device *pdev;
>   	struct xcp_device *pxcp_dev;
>   	char dev_name[20];
> -	int ret;
> +	int ret, index;
> +
> +	guard(mutex)(&xcp_mutex);
>   
>   	if (pdev_num >= MAX_XCP_PLATFORM_DEVICE)
>   		return -ENODEV;
>   
> -	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", pdev_num);
> +	for (index = 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {
> +		if (!xcp_dev[index])
> +			break;
> +	}
> +
> +	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", index);
>   	pdev = platform_device_register_simple(dev_name, -1, NULL, 0);
>   	if (IS_ERR(pdev))
>   		return PTR_ERR(pdev);
> @@ -72,8 +80,8 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>   		goto out_devres;
>   	}
>   
> -	xcp_dev[pdev_num] = pxcp_dev;
> -	xcp_dev[pdev_num]->pdev = pdev;
> +	xcp_dev[index] = pxcp_dev;
> +	xcp_dev[index]->pdev = pdev;
>   	*ddev = &pxcp_dev->drm;
>   	pdev_num++;
>   
> @@ -88,16 +96,53 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>   }
>   EXPORT_SYMBOL(amdgpu_xcp_drm_dev_alloc);
>   
> +static void __amdgpu_xcp_drm_dev_free(int index)
> +{
> +	struct platform_device *pdev;
> +

Would it be valuable to have WARN_ON(!pdev_num) here?

> +	pdev = xcp_dev[index]->pdev;
> +	devres_release_group(&pdev->dev, NULL);
> +	platform_device_unregister(pdev);
> +	xcp_dev[index] = NULL;
> +	pdev_num--;
> +}
> +
> +void amdgpu_xcp_drm_dev_free(struct drm_device *ddev)
> +{
> +	int index;
> +	struct xcp_device *pxcp_dev;

Just a nit; this should be reverse xmas tree order.

> +
> +	if (ddev == NULL)
> +		return;
> +
> +	guard(mutex)(&xcp_mutex);
> +	WARN_ON(!pdev_num);
> +
> +	pxcp_dev = container_of(ddev, struct xcp_device, drm);
> +	for (index = 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {
> +		if (xcp_dev[index] == pxcp_dev) {
> +			__amdgpu_xcp_drm_dev_free(index);
> +			break;
> +		}
> +	}
> +}
> +EXPORT_SYMBOL(amdgpu_xcp_drm_dev_free);
> +
>   void amdgpu_xcp_drv_release(void)
>   {
> -	for (--pdev_num; pdev_num >= 0; --pdev_num) {
> -		struct platform_device *pdev = xcp_dev[pdev_num]->pdev;
> +	int index;
>   
> -		devres_release_group(&pdev->dev, NULL);
> -		platform_device_unregister(pdev);
> -		xcp_dev[pdev_num] = NULL;
> +	guard(mutex)(&xcp_mutex);
> +
> +	for (index = 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {
> +		if (xcp_dev[index]) {
> +			__amdgpu_xcp_drm_dev_free(index);
> +			if (!pdev_num)
> +				break;
> +		}
>   	}
> -	pdev_num = 0;
> +
> +	WARN_ON(pdev_num != 0);
>   }
>   EXPORT_SYMBOL(amdgpu_xcp_drv_release);
>   
> diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
> index c1c4b679bf95..580a1602c8e3 100644
> --- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
> +++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
> @@ -25,5 +25,6 @@
>   #define _AMDGPU_XCP_DRV_H_
>   
>   int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev);
> +void amdgpu_xcp_drm_dev_free(struct drm_device *ddev);
>   void amdgpu_xcp_drv_release(void);
>   #endif /* _AMDGPU_XCP_DRV_H_ */

