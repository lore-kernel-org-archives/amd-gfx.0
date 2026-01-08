Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E34D185EC
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 12:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69A9610E6FB;
	Thu,  8 Jan 2026 12:44:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EO7gfd7v";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012010.outbound.protection.outlook.com
 [40.93.195.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C573610E6FC
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 12:44:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1BjBcHeYw+DmZmOTkCXpxAuU8eWkVTh/bZQ3A1wYCdx+YA6uU4o9kk5jqyBU4HhWN3VTmuR8ZykSsUBAL/coCOVekpATh8rnP57t5Ag2Yd1N2NnRg26fbpsF5FodWFlPZ4RJIq0/8hC1KTgnIffENxAe7XSpYWZz4XtElv6k/9n7GykWNpSZfT7x5EirMbnHoVAM5Xd+GRAgms3mJPduePl1traGHVW8ue6JKunQjpG7zP3LQTMVW+QwC9GJ3x02mZPoIjNaXdIMS4RE1ENuEZxq/JTK5s+dikl7wJOv8iE/VeAfvI7xx70fyfk0S4dlJqATLQZinPCKVsS7c0aQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7oCO2hMBtzJ7XsMcPOPmVMRaNVk/S87Kz8W68Yqg18=;
 b=cfIrzvAu2MNRm4T3DRhOURoLtdaoKmD2niBT++s1epbxMXHvsZpvbgLRugsBqzT7EVQAguobd5Rxsi+AHaHHZzg5BVDJovoZmuktEAvnBlI+ShVN80qEDHQMIEh+76j9+KS+lH9ZKHeCdLnSpLxnu/8Ns7CatizDQlHqivDreTLE0bdRjjG78p6FwhqAtWkl367DkSCP7mQQCr3dv3Rg0IMZCdZv+D4IR1T7d3Chyaqqq3R0dWFXiJJ9XHCwNGZr6gu2RqKGt/ALDJXd5DdsrL9nNe1PbI1TaQzWe8wJ6j5yjEYw+vfLL+Yscg7lOBTbWh04u5NGaC68+vGdlMiGtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7oCO2hMBtzJ7XsMcPOPmVMRaNVk/S87Kz8W68Yqg18=;
 b=EO7gfd7vQKNkn3WkFfKpvpeSs6kV4QJm6+cpEq5oMsrYmU4w6/GhMBXI5HihXFq2Vu09ethO+mDNCrT0otDnCBHZShdyPBrCP5hhyUgsyRe4bHQ1OYBE156CPQAR870aDEay2Nk0SadsIN/n1ixWKwkFAzZF0HQ2wF3tW5ATlb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA4PR12MB9764.namprd12.prod.outlook.com (2603:10b6:208:5d0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 12:44:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 12:44:28 +0000
Message-ID: <2275758d-de1e-42eb-b224-89485511a83d@amd.com>
Date: Thu, 8 Jan 2026 13:44:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: validate the flush_gpu_tlb_pasid()
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260106131921.801193-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260106131921.801193-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0400.namprd03.prod.outlook.com
 (2603:10b6:408:111::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA4PR12MB9764:EE_
X-MS-Office365-Filtering-Correlation-Id: a6c62cf2-b76c-4999-f83d-08de4eb3a959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUgwR2dWTFVqR05JMjFlM2ZOb1RBM3MyOExhOWRvbTcrRS9sRWFYNm1QRk5y?=
 =?utf-8?B?VEI2OCtWUktIRjE1c2FoYjBYZ2U0YXFIYWJuczdkUGFON1dMNVVkVHFya21h?=
 =?utf-8?B?YU10ZEZJUkJBYlMvejB1MFA4U1oySm94RFA4ZmVDSFRRcXJwaHZ0M1U4Q3dH?=
 =?utf-8?B?ZXdwQzhLeHRIazB5UVFtYVJXb2FnRHdVRUpnamM0MnJGa3p1V0ZRN3RlTWdo?=
 =?utf-8?B?aG9NRzNUaEwzeStxUDFTQkZhd3c0czFHVmphZzN4R3F1aTRKci9NNlR6NS9u?=
 =?utf-8?B?cDZpdktpUGFaeC9MQzJFYTRiZlRxc3lsZncwaUFoUUsrS1F4cWpsV3E3cVFG?=
 =?utf-8?B?OWdqZy9mK0xPYnRMajFpNHU5MUo5NmZKOEJvczA1d0N4M05FQlBLMnMvNFh6?=
 =?utf-8?B?TStTQ2lWNU9hRjQwY1hHMW5HSmQyUGF5cjhLa0JIbGRsK1hNZjU0b2hYR0VY?=
 =?utf-8?B?UG4zaVJUbHpWWTJ4WWhYeUpIYXRXeXlLZ2NkOStvYmRJLy9TUGZZa2JYSGxL?=
 =?utf-8?B?TEtTTG14enBlMHZiMmsyTk5zYzBDQWl4V2Zkejc1Y21UaXZJUkNyb3dlT3o2?=
 =?utf-8?B?NkJoTzlDYjVBWXYyTVcxNGdJZXlzcDhuQnFHaU5JOHVBVEtIQWhuVlRPbHRO?=
 =?utf-8?B?bXdpTzErS3lxVVJqQ3RpSldueW4yc2VONXFQclFEVHNjcTU1TTBhVnY2NlNC?=
 =?utf-8?B?OFJOQlNPY0pvVWY1SHJNMEZnUWVZbkhjZmRqdi9NSEZtaEtra1F3cFhxV2Q1?=
 =?utf-8?B?WVdpYUNUVDV6RXRpZVk5Q01RL1lYMjJLL1czc2o0QysxeFBVaHFmdjNDNGFI?=
 =?utf-8?B?VG1FRnNFRFB2NlNSMlhua2dPS2h6TXJPQ0c1NnV6MTdBZVdoZm00TFVjUFk4?=
 =?utf-8?B?N3FmVkVLbExmUTlKTW1OSWdIc2R3MVk0dG9ubXZYYVZxVE1nVHdiejJWRFJX?=
 =?utf-8?B?Ykg2WThRSm1mbWpFOFF0cnZYOWN6QWhDclhyaXZCTkhkY1V2TUh0blNsNGlG?=
 =?utf-8?B?dk9xaGY3dDF0Y2N1cVBoL2dpcWk3ME9JaEowMjBBMy9pbFhjQ1hMWXhRZnVP?=
 =?utf-8?B?d3dhUzZMeGFJSjJJbk0wL3N6RzhYcjFnMWFZaHJxS0ZkN0NaMUxsd2wvay9s?=
 =?utf-8?B?THZpaEZMRUZuZEF5dDZoNmJYUkRoRjNBT3IwLzByLzg0TFl2R2NVY01lWTVS?=
 =?utf-8?B?M0pOMUlEdEwza1F2UEtPNVpMRTFHN2Z3TWk1Q0VPRFNvdDNPUUc3R01MWDZa?=
 =?utf-8?B?RFlTaUREblI1V0w3V1FjK2EvMGhkeGExZitrTlRudGNYelFOb2xTVzg5UmtJ?=
 =?utf-8?B?bjN4Uy9Mcnd1ZE9PWXRZZmY5SWwzeVgvRXVILzlxMjNFWDhkNXBnQ1JkaFJj?=
 =?utf-8?B?Q01rc2dWS05Jb0ZzbVNxbytROWhSZTlqZFVTS1ovWG5BOXR4bVpHZ2VoWXFR?=
 =?utf-8?B?YjhjK0I0OS9UaDNHTmpIcEVyektjUzEzNmVCd2Y4b0dmRjkwZEZOdFBjc0hH?=
 =?utf-8?B?bzZ0dGFnN1I5NDlCU2lSc3NIYzhTUHZQcGZ2WGVYR2Vuek9CUmpldVJkRXFD?=
 =?utf-8?B?SjFDQmJlRU5LTTNsTk5rWFpJOVdmWU5lQkl3Q0FTOXpDamNmTTRDOCtINXhB?=
 =?utf-8?B?TEI0c1B4SUxwTmFJTVdveHZjWGdXYWlUNmJwWjdZczVCZWdyUGg1RlJtNGlS?=
 =?utf-8?B?VkxVbmQxRGFzWUxrWnhydmJnMUpEVjRRazM2KzRhVWZkb05rRTlUbUh3bjFX?=
 =?utf-8?B?eUNXc0N2ckl1RElBZkhFajZ4TDBXWDEvZkExNEZvQ0Jwa01UZUZlbkZ0c0RX?=
 =?utf-8?B?MWhLRFhlSnpJUWVMSFA2L3BxdHF2MzZjK3l5T3FRMFV0VmtrMGI0NjdCMVNy?=
 =?utf-8?B?NlVXMVVsWUNoaWJLWTlMSEJGa2o5cHowMUZJTjBJS2lma1hPdFE4U0U0d0d3?=
 =?utf-8?Q?hyTX25znsjmfwQlonjd/tdqjSjex9/iq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STZDWFJTd2NFa0ZSeEZxZ0gvL1Y3b0o0M0s0b2owbWtYajJ0bm9zL2RXYyt2?=
 =?utf-8?B?WnJjYlN3azc1R3VEVlV2cEpmNGZBWWtzQkJ0dnJiUTdKeFdWTGNibHhWNkxw?=
 =?utf-8?B?SndZalpuWWVXWTBuZm8xRWNVVU1hSmY5TlFUNkdmTkdKOFBxbnU3V1ZGU3p5?=
 =?utf-8?B?eUhpdXNjT0lZcC9PdkFkZnZEbDkzam5lUGlvL2w1aTRSYlN1UUFjRUxMRlRH?=
 =?utf-8?B?N0dzTDlOMWFoaDhrdVB1ZkMwdHFZMURsRXBCQVgyRWJiMUhmbUh0RW9xSGh2?=
 =?utf-8?B?TEVYTTJEenVHQlFBU3l4d0V0Y1JxdmF3aXFuZTdrT3RRSE4vWnhmV1hVVk9X?=
 =?utf-8?B?MStlQUlhcW5oM0YzSzk1WUxjVmlQYUI2RG52SFNsR3pGQ0gzOFFXcFp4L3Iy?=
 =?utf-8?B?Wm5PVWNuQ05TdmxUYXlZOVUvdi9FVXNtbDd5ekRKbVNjdGk1eUc0dFRIZ3FW?=
 =?utf-8?B?R0xvUXdKZlBvbGg2aXhDNFZhbVFIUXNNSC9lZzk2WWNIUWYzWXNlSTNPV09s?=
 =?utf-8?B?WXZEbEoyeHg3RlN2eXlENlFsd3Y0RCt3ZDl6T1kyajBqcmRLT1lValNGdnpm?=
 =?utf-8?B?S09ZWWtpV2taMVh5ZmZoRkF1V3NOM3FwTTREZGV4WWlHWndpUkhwcmMvZGU5?=
 =?utf-8?B?ZkpDVXE1eFBHY3ZuQzFWV2dyL29veHd0NXFjNlp3Ui9jK1E2eUlGa1E0R0F1?=
 =?utf-8?B?N1AzbWZlVi9DOVgzdkNiVlNOY0pZUWNlaDNVcFN0SElPT29tVlFjMkFWNDZ1?=
 =?utf-8?B?NG84bTZZVWhtMG1Xc1B3M3QrYXV1ZzQrby9rYjBKZjBuUTVBRGdPNWhQK0NR?=
 =?utf-8?B?YzBEVTNxV0oyYlhDZlBKVThRZ0ZPVGJTcUcxbGVPaUxjMHJrM0RVSmFseFQv?=
 =?utf-8?B?eHhlb244bm9XOFRYWit1UnVGQVRVdnE1WWl2TFB3dlZaZEJWR2VrWlVHekRt?=
 =?utf-8?B?RG9FaDdrbVhHTXBzUVIyTUlaeWc4NDVGWlNMdDZjMk1CMFp6YUVhdGx3NjI1?=
 =?utf-8?B?M1M0WWZvbmdJbnlwbWtXOEsyUHFaMnNBM1ZFUldTWUdkUnBGbUF0Zk9ETldH?=
 =?utf-8?B?SlZ4RmVNQzhSRE0wcUNGYVByUnlUSDcxdkZZSGNRdVVMaFFiMXptSndUVzFx?=
 =?utf-8?B?L2djR2djUHVDbE1pbmV5dW1WZlg1b0hscXc0R0dCbUZiNS8vNmk5WU5ubmpI?=
 =?utf-8?B?R3RIcjl3VVhkT21QS0FIaEFjMEJXazZsUk83WjdjYUQrUzBOZE5KcWtoUVIx?=
 =?utf-8?B?aDFmK1NJRFI1SHh6dnhpcFBqVmxNdTZNZkJaSnZtQWR6S1pTc1ZOQmpKS0NY?=
 =?utf-8?B?c2ZpaE9SRCtZbmt4cWhGTS9HaTZzV0dqb3Z4N2l3WDUxWG8xaXR3YW0xWUFO?=
 =?utf-8?B?YmdvTEpNcjVJMXdNWDN4YUx6eHNDeDc3NlMzU0IrbXBiUkFlU1R4Q2JTMnZs?=
 =?utf-8?B?QU1KNUdUZ0pqVXVJZVJ3NDRvS2EwOVFTbk5wUlBnUFdUR3pJODRRa0QzSm52?=
 =?utf-8?B?S3lpSnk4TFFFTU9Ub09XSWN1cWNUdkxvWTdxUUJSVS9ETVVZZzlMRjlqZDIz?=
 =?utf-8?B?c3RLYTVpencyODNrVWlBWjd1WjdWMFlWcnJkNUpCZzYxL0ZBWGxwTGFJT1lp?=
 =?utf-8?B?Z2V6M0lrcDJacHBvYlFyMkUzMEdYRnEwa2tQOERHM0JrK3J4T1k5VG5TQkRs?=
 =?utf-8?B?eFVxalhUMjhYeDR6R240K1h2djV0amgrOERQSmVodFVvZG1CZVBQZkhCVVh2?=
 =?utf-8?B?MmNUTVlwYW9yU0h0WXdSRHVEbE5VWUxJcGdxb3FnV2FERnU0c2Uyb0tCd29n?=
 =?utf-8?B?eG9SVXpSUlZXZFM5VlgzUnRneEkvU0RQVTNua2ZCanYwOEF1MUJhN29ZZ1Nn?=
 =?utf-8?B?Mm12OS96cS9VQU80N3VGbjU3UDZneUtFV28wN0FYUWJOVUtPSTdRN2E3bXNK?=
 =?utf-8?B?R1ZVTXl6RXlVMDh3dTBKNmZRTjNMdzNraE9oUzBwZ2VkL2F6TFBlSkVOUlVW?=
 =?utf-8?B?N0txeFlQUUxjWXhFOFdhZmFUU3YrL3Zxd1MrbmZnNVVpV3Fvck56WWRoMkc2?=
 =?utf-8?B?bHp0d1F5aEtQWGJRdXFXWG9GVWtmYXhpMVB0Wm9ESCticDRGOUoxaWl3NWVB?=
 =?utf-8?B?U0ZNN1BxUytWODEzbEdHd3lkeWhsTGZrOVllREd4c2ZiMTBpdEFCd0dlVENr?=
 =?utf-8?B?Tmx1SjFBdE5ZSDgzd0k2cVJFOXFKYTVhem1nL2RSa1I2YmVaMUtaclNJQWpL?=
 =?utf-8?B?QnAyVEkxQjIweXdwNmlFcm1YZFppTnVMNjdwYjhGb3RaUnl3cHNDWnNqNDBR?=
 =?utf-8?Q?u6pU4LLxyvCVZAzbZi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c62cf2-b76c-4999-f83d-08de4eb3a959
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 12:44:28.2542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9vLZ8AYTHg8mhlrp+EeVPrlTTNBUpTM7bt1MlJ2b7ZnEitfH6mDoU6CciNinV7s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9764
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

On 1/6/26 14:19, Prike Liang wrote:
> Validate flush_gpu_tlb_pasid() availability before flushing tlb.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index cd4acc6adc9e..f871f1693483 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -780,6 +780,10 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
>  		return 0;
>  
>  	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready) {
> +
> +		if (!adev->gmc.gmc_funcs->flush_gpu_tlb_pasid)
> +			return 0;
> +
>  		if (adev->gmc.flush_tlb_needs_extra_type_2)
>  			adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
>  								 2, all_hub,

