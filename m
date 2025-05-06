Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03D9C3ABAC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 12:29:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8022310E67B;
	Tue,  6 May 2025 12:29:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QWFaWbj5";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D704710E67B
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 12:29:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jyQL9TAeCj5B48LnK+UJ+jXSD8qEa65YdLz3txF4zjrF5x8L4PsEx7hwqXI/4USBxhnARH0QTCXm79/Dwe+yWU2So+8SLBdj3uE+bj5BqkVavhylw1SgXJ0Wd+xb2yis/5hFJV+dA1/WOuNF+34XzLEoe6sL4SMdZ2HtKZiG3jKvkxO+f9reHG8x6XZayk/t2RxiqmYtvgOuZlFVdEvfHG/WrvyEinroWDdsiF1A0RezFmkap6BvUAOsMKD6bx/hj+rnNi0jyWE+1QIyaeaKObf2bGCNNUP3UZdbeh+lmXfStH6dvGkj5OyAIrPnxELm/ok442CTQDjJk/YZpH/KYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JGTwCJR9yrlRggjjiXq4Yv6mN42aduVH+PQTyBO+EM=;
 b=mMG8Sq24X+xnzefqLfq1tMsF3yG/BD/b5isvk1Nw5eqPrSFZXg6wUECjUnKaqsJDfP4YLe3OSgxYUnxdPNjkGAH9/gKkEowqXVmtPX+8HIb9JYyYzGeS8GgYZWfNDsAGr99V5s56kcTx0SXugVaQqr6BwGp86YNpcrvkC+rY199J4EPEpt0MjclibcZoBQu+CHCBtQM2XdENdaSGQWLagEYeaeZ5jZPUssH1XO9OfNjBrI4bxBa64ET2kI29NXeHoP/eHJijatxN+XuQbFNpKPp/gQTfCK7sZucpimEQHQR1rxRnllRV+9iCUXjIdXKgQ17Qjub5tNmMPUU2RWL5KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JGTwCJR9yrlRggjjiXq4Yv6mN42aduVH+PQTyBO+EM=;
 b=QWFaWbj5XXjhB/9ftChYLI8/2XNd3fH9IYqhbZX6dmQ1IzOTrchPrYq8VZREB0jysmbPxvLfvDgmhYRn/mNU8rY92YWAG9oqh3tmAxdoHB3mN7iX/wHgtrZjrRA9uZsqW8MygbzQbfYIZS6KqFU7Cx5E2VdW+euEgpMFY8LaxfQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB6366.namprd12.prod.outlook.com (2603:10b6:208:3c1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Tue, 6 May
 2025 12:28:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Tue, 6 May 2025
 12:28:53 +0000
Message-ID: <a5299419-85c8-4609-b0d3-85af0de549a3@amd.com>
Date: Tue, 6 May 2025 14:28:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] drm/amdgpu: update XGMI physical node id and GMC
 configs on resume
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Alexander.Deucher@amd.com,
 Owen.Zhang2@amd.com, Qing.Ma@amd.com, Jiang Liu <gerry@linux.alibaba.com>
References: <20250506093629.249792-1-guoqing.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250506093629.249792-1-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: f437e0c3-345e-471b-42b2-08dd8c998fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnA2K2dvVzdHd0VPZy9TcGtOckc3SXpKTUE4TmhqeXJYRGxxQy9uOWlWcTFL?=
 =?utf-8?B?NmV5c0FzdmIraGJLLzUreGlsZEdwR3h1V3VrZHdQSEYyRmFVWkREMCtiV0xR?=
 =?utf-8?B?bTNzdWRhTG9remkyR0dkZSt2N1FRRDAxUWhpbFkzRnBpWlFQV2l6MGNwQnZj?=
 =?utf-8?B?SE5DVzJJSnprVGYvTVZKemJtdURqMW5tMkQ1YWYzLzVyR0Rlblg1N2NucitS?=
 =?utf-8?B?VGlYUXMvUHR0K3RZOURJQ3lINUJPQXpmVEJ4SUpwcFRLNTFpSm1KQkFld0xH?=
 =?utf-8?B?cFAza0NvTTFkcTJPSkpYVWhJcGN3MnQxU3A0c3JzMVZZRkVMSWVCV3E2bEww?=
 =?utf-8?B?eTkyNzRqWldnZm1SQlNvbTAwMGpBeFpFR2M5Nnpsd3QySGVrcGZPQS9EN1ZV?=
 =?utf-8?B?aUJ3Y011MGw1TkZZVWQxQ3hlTldYY2E0NWN5OGhGd3VITk5SUWxFVVFKMzBQ?=
 =?utf-8?B?RW1sejBTcjFKSUhxalAvRExIRHowZnVkck9vZGh5c0ZreVV3SEtycndqNlNO?=
 =?utf-8?B?RHl6dGtwaFpRRnVycG5MblFWc3BJK2xOZzJOc1EvRE9FNXFseDRCUmZRQ0o4?=
 =?utf-8?B?aElrdVEzSlNYN3k1OVhzS2J2eDgzWElsd3RUR3FYdW54RzNHSFUyUWtkbXZu?=
 =?utf-8?B?RnRqQkx3eUlUb2Y0U09pM0R5YmRXWHpnZUV5L3BXaDYydjBrRHhKN3pEc0Jv?=
 =?utf-8?B?OUNsVzdhcXhYYnNiTGRmYnhBb2o2Z1h2QnROYXdwcnZjZFBuY2dZV0w3SWVw?=
 =?utf-8?B?OXozelhFSzJaZU9lTmh6bG43TEhWOGxHZW16VFZYc3NmdUZWUEtRTk1pbUt5?=
 =?utf-8?B?N01QdlJEREVpZ2tiTFFlT01RWXdOQTVTSU8zTklVTW5nRzRvN1lSMkQ0YUZn?=
 =?utf-8?B?czAzaXljSjEwNFVXb3F6YXV5dDE2NFJrMkpNQmIvc3FtZmRvZ3UxOVkxNVVn?=
 =?utf-8?B?RHIvcEVkUzdyS1A1Y3VuU2xWWFlGTkZEa08xSW5OSnNvdk5SNC9QRkh0RzRX?=
 =?utf-8?B?S3dzTjBjZFExSzl4cllWTGlzM1RYL2ZLUGR6SnA1MWJrUUpkdnVNV2lqTnpR?=
 =?utf-8?B?Sy83OEUyeGJtbUxHZWMxbVViOFJnQlVvdHhTRmRQbExiVWhyRk1KU2hyZnFn?=
 =?utf-8?B?bVR1bDR4bWtKbWd5U2dhUDZ1Qk1HZmRFVm4vRHJkQllkQzRvYzBNUWRTMmY3?=
 =?utf-8?B?L3ArdW5WbE12SVZhMHJsai9lZEo1N0pSWGJLZUhVMW9iT3g2eFVJaGthUjhx?=
 =?utf-8?B?RjJNS3pTaEpaeFZWb0xYRGlHYXk5ejJFdnlqZzdzY3ExalA2aUwvQlhUeGpE?=
 =?utf-8?B?VUViN3hQdHRZd2hHdEpUVEVuNmNRbDlmSUtiZVJacXo5bFFlVWVVZ05LK05S?=
 =?utf-8?B?TnFyWWZBd0VoYStiQWFuWUJUZ1Bid2Z3ejk0V3Nmczl1YWlKSG1XcHdRM2NW?=
 =?utf-8?B?ODhmbW1TOC8xMS9qUjI5ZHFEdGppQ2MwT1dMc1VoNkJBTHZ4c3gvZGwwNXlU?=
 =?utf-8?B?SC9OM2VadFY1dW9zNUJxN2drb3d5OEM3SS90UXR1QzlZQks4RU5QYVAyQmIy?=
 =?utf-8?B?alpIMnRNbGNqWHZRRFc1eXZKd3kvUGphNThvUit1Q0g4OXdLR1V1eEZIVHI2?=
 =?utf-8?B?NVlaZ3B5WTc4NnlSS2R0Qng5NjZqUmR3MGc5R3MvY2lDTmtXMUxpa1hsSDBj?=
 =?utf-8?B?MzdLNTV0b2IvMWkwZWN5YXE3NVg5alZQTVBqdEtLVVcxM2REckRwL0Z0V3lI?=
 =?utf-8?B?NXllOEZHc01DMjhMWEo5NHpnYjU5QndiL3BkUXdoUS92TWJmRU1ZUHVwalc4?=
 =?utf-8?B?ZnJBWnpjRzZtbVU2Nmd0MXlzNXJHTHdTRWV0bXVCNWNMQldlL0p5L0hiUFNh?=
 =?utf-8?B?cWtra2o5Q1MwSE56YVpkaUxiWndOZkNRNER1NlRzcVlUbXQxZEV1K0pFeFpF?=
 =?utf-8?Q?izR7+cjnt9U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXRJUEI2OTZFQ25Od2tEZE9oRWJoYkl6dlVvWmFJMjFobjM5RXoreFkwS2la?=
 =?utf-8?B?R3R2TVk0VmRXaENadzlqQnlwZ3ZyUVMyVHAvY3pyampmN0VIcDN3Vmk5Umw1?=
 =?utf-8?B?WUtqdE4wWEdyTXRMcnhhQ0tjYWRPaEFxcDYxeGpxR0dGMG5GRktGQkpocjdn?=
 =?utf-8?B?b0x0MDlYVHhTaDZFN25ScEQ2eGNPWXFRdlNYTkhuKzJ1aWdyb2tEUmk2NlpN?=
 =?utf-8?B?WFVEYWtQUDlONHd3ZThwVU0xc0l0cUkvemd5SjJsY1VYYURTRnhwcEI4c3B1?=
 =?utf-8?B?eHRBR2tnT0kzeDQrNGZ6aWJUSjNEYTNpUXAvMTI2MkZhMlBIRm9qWHlQR3hu?=
 =?utf-8?B?Qkw2WW9EM3RzRUU2THpFTUNHNHJRNmtOUmJpUVdwdFd1K1p5dlFMZmMyVWhU?=
 =?utf-8?B?RjFHUUdLd2p1MTRsVlhuSmM5ZlM4WXRldlloV3czWnBrakZEcThQNTZDQ1gz?=
 =?utf-8?B?SnkyelVIQnExNDJ5THJuMXJ4NTFzRWxGd1lCQXNUNUFYdktwUVpZam5sTHNt?=
 =?utf-8?B?Njd1UVRNQlQwTVpVRlI1d0lVTTNndVd5d2RobWdhRDZsSWNpdVlFbTU1UlFr?=
 =?utf-8?B?WTJ2RXljSkZMamdSMU9oRGU5bzdHNnF3bEJ0VTJHYzlKQWZzYVlGY0R6NnRO?=
 =?utf-8?B?MFN3d1ozTnF6YjExQ2trSzRsUVhXOGZNVm5kc2tpY1V3SXl1MTljUDd6bUU5?=
 =?utf-8?B?RGtGdWt2S1JNVUVBcnYydHp4dHpVQUdjWlF3bnZKYUZWb25GaGhka3FQWk1u?=
 =?utf-8?B?WjNtRUVaUTNwZTNyL1VHbFhZVFdRTVlUN3pxR2Y2UXozRG8wNGV2eGxEeDJk?=
 =?utf-8?B?YlJtVnhkNE8xaTl1c3JoMFd3cmxqd3UyaGdQTWdwdS9ZNGRpaUF2UEpVSEpy?=
 =?utf-8?B?eHNZaUFxUkJQOUN0bVlQbVJVLzdPSU1TQWJjckE1OFRYOFRoSVpFN3VZNWpj?=
 =?utf-8?B?ZGk2bjJZbW9FRXVmU29UQ21NcWV1UEUya1lPUFBCTERFNEFKaEZHYzJFejFa?=
 =?utf-8?B?TmJtTXJHREFYdDhlUUFxUEFrdDhjQ1BDOCtralZwMEdIRlhDNm1VeVJRTDU1?=
 =?utf-8?B?aW1jZVJIWThWa2JvSXVjV09ZM3BpYldXbXQ2Q2EvMndyMWFwWmJyYng3V1Yx?=
 =?utf-8?B?enIxbS9sTXF6RHBERnJqQnptOFZPdDA0N3lpa04xVC96ZHV2Vys4UmVCMkZz?=
 =?utf-8?B?ejJxMDFEKzlSWTJVUnA5aS9PbmU4NE1QK0pjbHJZeWRrbS9LVEVnMzZwME1F?=
 =?utf-8?B?THJTSkw2U3g4VEJFNGluQnNTK2hEenM3aytWZStvY3VyVG1aN0J6dlFsNCtH?=
 =?utf-8?B?YWhJMm1NdFVBNXNiMjVuZEdMT2FqWXV3QTVKVzQ5SnNMbVdlQzhCVktOdmZo?=
 =?utf-8?B?TVA1MXFvd0psSmxscmY4emZacGlmOFhFZUt2Qy9oQ0lMUW1ZUlZFdU9sWWlj?=
 =?utf-8?B?NVAzM00yaTNKY2prSmJYZ0Y2OGRIRUNpMkhpeFRNdlNhUSt1cElsM2paQWx1?=
 =?utf-8?B?MTBlZDRCaDAweVZUYmEzcU13bnNpdW5SSmlna01va2dIa2FNUG53MnRZRVRT?=
 =?utf-8?B?L3lCS2hYR2RWZlExUWNWUkJweVh4cEVnODJyMmZwbTM5RVl3STFQb1k0SlBL?=
 =?utf-8?B?aEJkaHhBR1RiTUpBLzlqVkh1a0RWbzlGcFZzdk85azA2cWxVREhoalRSS1FL?=
 =?utf-8?B?NlNrR29mQVNVb25Bb1hxMUZKZ09hZHd4bGtaVWtQTFJ3ekExcW8wQjlqa2Vm?=
 =?utf-8?B?WXp5QURoV1JhSkFhZXR1MHlKV0ZYMG1JbkJ4VnZjbVY4Q3hkcWhkZHMzcnBh?=
 =?utf-8?B?bDlva3pSYlBQWDFtcDRDUFVGbHJrVEV2VTNXYnBTNmJjRGRyZkNySGM5bmg0?=
 =?utf-8?B?R0pxaWVtVUErMFkzT2dnRW1yNUZ0RkFGVURLR3BpbzFxYzd4Wmo0ZWJOdWdW?=
 =?utf-8?B?VDREeHNFcWpmNVgwTHUvcUdpM0ZYV3RxQU9aemxCTFdqdWpnL2R3VzA3UFV6?=
 =?utf-8?B?anQxTXVzSXRYb2Z5eGpNUXF3U2lFQWlzM0I5VDI5VUMwS043SDJlbDJsQThX?=
 =?utf-8?B?OGRlbldQYzRlL0xGamxuZGdxakh2dGRoaVB1K2xkWGwvYis3blB1eThQVm5O?=
 =?utf-8?Q?7xRt+DFJkKFiXnVNYtbiyir0m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f437e0c3-345e-471b-42b2-08dd8c998fb7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 12:28:52.9697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbusVGHZXw7N6JXOnRyo/PfJsRkaV3pEsiAvm27obxFBEivzB6Mgy1uByKl4cfot
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6366
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

On 5/6/25 11:36, Samuel Zhang wrote:
> For virtual machine with vGPUs in SRIOV single device mode and XGMI
> is enabled, XGMI physical node ids may change when waking up from
> hiberation with different vGPU devices. So update XGMI physical node
> ids on resume.
> 
> Update GPU memory controller configuration on resume if XGMI physical
> node ids are changed.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  3 +--
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  4 ++++
>  3 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index d477a901af84..e795af5067e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5040,6 +5040,27 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>  	return 0;
>  }
>  
> +static int amdgpu_device_update_xgmi_info(struct amdgpu_device *adev)
> +{
> +	int r;
> +	unsigned int prev_physical_node_id;
> +
> +	/* Get xgmi info again for sriov to detect device changes */
> +	if (amdgpu_sriov_vf(adev) &&
> +	    !(adev->flags & AMD_IS_APU) &&
> +	    adev->gmc.xgmi.supported &&
> +	    !adev->gmc.xgmi.connected_to_cpu) {
> +		prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
> +		r = adev->gfxhub.funcs->get_xgmi_info(adev);
> +		if (r)
> +			return r;
> +
> +		dev_info(adev->dev, "xgmi node, old id %d, new id %d\n",
> +			prev_physical_node_id, adev->gmc.xgmi.physical_node_id);
> +	}
> +	return 0;
> +}
> +
>  /**
>   * amdgpu_device_resume - initiate device resume
>   *
> @@ -5059,6 +5080,9 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
>  		r = amdgpu_virt_request_full_gpu(adev, true);
>  		if (r)
>  			return r;
> +		r = amdgpu_device_update_xgmi_info(adev);
> +		if (r)
> +			return r;
>  	}
>  
>  	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index d1fa5e8e3937..a2abddf3c110 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -1298,8 +1298,7 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
>  	if (!mem_ranges || !exp_ranges)
>  		return -EINVAL;
>  
> -	refresh = (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
> -		  (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);
> +	refresh = true;

That looks extremely fishy.

>  	ret = amdgpu_discovery_get_nps_info(adev, &nps_type, &ranges,
>  					    &range_cnt, refresh);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 59385da80185..1eb451a3743b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2533,6 +2533,10 @@ static int gmc_v9_0_resume(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int r;
>  
> +	r = gmc_v9_0_mc_init(adev);
> +	if (r)
> +		return r;
> +

And that is almost certainly incorrect.

You only want to update the PDB0 and not initialize all parameters optained during driver load again.

Regards,
Christian.



>  	/* If a reset is done for NPS mode switch, read the memory range
>  	 * information again.
>  	 */

