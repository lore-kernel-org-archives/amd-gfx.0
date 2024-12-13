Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D851BE7717F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 20:23:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 859EF10E1BE;
	Fri, 13 Dec 2024 20:23:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kcAyb11T";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0DA110E1BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 20:23:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDQd0BGHfD1AsJSoYhQvXnjM8d3vtKKhh9yS/aK9ObMvOVdb7b/Gnyy59YN0F+QL/4/BBh7M2T92zOljF8iP/lTtu+QLFLxLz8hHwOnhbxKPIQQI9s8BPbQTi1TTUtO+f2ZX1s/gyFJZ9sn3Z9Gg7rl4e8rhoAeYXx1XuqB7tC/qmNCllWdhJWujKWlkxQdrc1K2Fx7RVxHN6mvkFAV72t/ZlmTdPezYKIz3aLR5wepZ5UK1GxzVPrtbZQlhBOf/akHwvwzCiAKFN7W8cvDXanLuXuYBZ4fqBt/GHDhoiy+TOQ2E2/4oedVOcEnzQc21ypbNW+hRGc/FKO6hLvvqUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEQ3eIZyBrQRPTl4Yv1nFn0bhWkAI76pzS2CFV6xqow=;
 b=BL8lU4y/R1ahZoCk2Nb4/J/NmomjT0SF3HxwRVsB0d95EkG1SbGJCl8zh0w54uO0CRxB82Ox/sHPKXBqGCtO2nCHkTobKV/ge2n1JK95msBGC55nIWU/I5PyRvoNQRech1scux5pkIZf87NlXz5JoI01S7I9EWxSKnnAZl0W9VWfmsuVTlnJUrh8N7EIJeZIIv9pdiSxO/eWSIqqOJfaHwLoUbb8wrWYV/Myk7DZ/haTnBS+XR74KuxnVGtfSuqoootVGDMdkVC1bibsAHs7IwjqfiK9eU9kctlxjZHdf+qta9tkZpFz537tY+uO37KhfGWB4WwimvEOsuxTJY3GBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEQ3eIZyBrQRPTl4Yv1nFn0bhWkAI76pzS2CFV6xqow=;
 b=kcAyb11T/4e72f3alrXTJSxBfzm9JaGhqKWnes+1yq/N8yMVVV60JG/t1q9TlTnzx4hA7m6JeJiUdb/4EF1bVGNBHVFc1N/qL2jPwS3fXyHxAl+JGWvBeVvZDPz58mqwRDJ4EJei8PaUdT5xTxL2OijVT3TuusyCO6f5XigrA0I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 20:23:34 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 20:23:34 +0000
Message-ID: <52a00418-80c0-4516-9f56-74614dcaa52a@amd.com>
Date: Fri, 13 Dec 2024 15:23:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] amdkfd: wq_release signals dma_fence only when
 available
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20241213070828.21365-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20241213070828.21365-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0030.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: e89ee854-e8d8-49da-5f74-08dd1bb404ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Kyt6MzhJVjlqNFo4VGNRUStTTkFLM0d0UWplV1ZBT21pVGJxWWNUZFZGb0RG?=
 =?utf-8?B?TjFua3ZFTHdzVTRwYm9YMFZZeVg5czJOS0Uwd0dWM25YOVllVldjWEMyZGFN?=
 =?utf-8?B?WTNxS2tjTXNHTkM3bmc5LzhyR3NWMXMvdmFFWjdTd1BiUHVaQ080ODZYaGJS?=
 =?utf-8?B?R3Fhb255Y3FoUytISkQ4R2p0MkxUTGlVZ0JVbWRHa2pJL2doM0JBWXZ4V0Zj?=
 =?utf-8?B?cW9BTTNpd3lrQUxtWk9BdXF5MlNFcWw3bGNOWVk3VG5XcG1DZjFjOHFTWFl5?=
 =?utf-8?B?aVNVZDYrYndDak54aDE5cWltMUNwcm1qTlFONTloVnFyc2pScnRTSno3VFN5?=
 =?utf-8?B?Y2pFdVhnRjVzM0xuYnNGVHpucUx1aGJEOFNPaWpuRUdmRXQ2OFNlME5XTzcx?=
 =?utf-8?B?YkpocFFVblM2ZEM3NU9IYVkrZnl5R3J0U0l4UmF4SUVhL3kybUJ3MG1aQkt3?=
 =?utf-8?B?OXNnVEk4SnhidldCUERraGtGdkxEU1V0Y1U2a1BMZzBlQ2huWkFRWlVnMTYy?=
 =?utf-8?B?OTVDMStSM3VYcmZvRnVNcFViemlmT1hmK3VDbXF2Sll5STRzZVVJaTdETmN0?=
 =?utf-8?B?MFJUL2VtenIvR01HUjh3N3hESFN1NVk3akNSRC9OWlFYQmhEWkFBT09Ha0xs?=
 =?utf-8?B?RDdjem53bWVPdFZWU1diWGpheFZTa2hCb0c5d25wSWtoM0dBM240QldLaktm?=
 =?utf-8?B?SnZaSEJzVE43YnVKQ2t5K1loUi96UlR6eXgxanNpWWIvTFhPenVLck1jdWNV?=
 =?utf-8?B?WHFpWW1QMk5LbjZBcWFPS0ZHczBSUmxGZDJkTUczaVJQNHdTTUpuWkZXZkd5?=
 =?utf-8?B?d1NpOHBzcC9EaW9DNHBiOGR0eG1iZGpFc1NFalBESjdkRkRZWlpvU1Z2aTN1?=
 =?utf-8?B?QmVGMGpJbmNacnBOZGJGVldhd1NwWWp2TXgzZ1I4QnIvU1F2c0hTNGNpdUd0?=
 =?utf-8?B?ZDkyMi9RWGVsdXc1SlVpVjc4Tk5VSk94dUN3TUZUQkY5TUVzWFpOL2ZCV2xq?=
 =?utf-8?B?eE91T2NLcC8wd1FXVUlhNjNQbHdGY3p1VW5tT2sxTndoa1JXdFRVdzUzUklm?=
 =?utf-8?B?YlZ1QSsrdm1HdHZ1Tm1tbWJoRDNYUEU5M29CSXYxbDNPTmZ0cFU0bGRSVUxv?=
 =?utf-8?B?YUJLNHdqdFVyZUhiOG1yWDV0RUEwS0pwbE9qdVI2bzBaYkFUb2dBdzdJSzE1?=
 =?utf-8?B?aXNkMHZlbUFLdkFYcU5QMWRzbGdpRnhGSEEyNFdyRnExZzZTQVE2QjBJQkYw?=
 =?utf-8?B?dnJlSE5sSnk0NzdxQ0hMa0hSb280RlZ4TDJlblZyMU5EQkVrN3JmMHpCZDFp?=
 =?utf-8?B?MDN6NFAra3oxY2VIcWJKb1Z4Z1lTQ3ltR2MzMDZBdGt4OTlENnArbjV3TXU2?=
 =?utf-8?B?cktmZlBBRjlRbXFsMWpSMmdzNWdzUUlZOWE5NWtPaUExZVU3T2ZLZFZuQkNJ?=
 =?utf-8?B?eFRubHAvWGZOcFBZSmVHYjFnREt5Vng5TndoQ2xMZEg1UVA1aC9NaWM2NXhj?=
 =?utf-8?B?dDRKclQzTENodS9ablNhUFQrakNvbzArbldPc1ZhalloTTlGZyt0dVphbzhB?=
 =?utf-8?B?MFdORVR1VitCVlBVLzF5d0p4Z2p1aloyZ3NxN2tkSXFqd21RVTFhTVE0Slc5?=
 =?utf-8?B?MzhPam40VXRpNEJpaS9HVVpaRFNNL1VvQkg0Sy9uTmlTMlcvaFFvSGdXZG1P?=
 =?utf-8?B?TFp5RVBkQ01KU0IyZVBUdXB0Tk5ldlc1UEUvS1JMY1BaNTdIZlZ4eTRqdFds?=
 =?utf-8?B?NEhvd1Z1VTdoQXo3RExDQ2ZOTzczYzRtL2pqUFJpOVFTRTBYOWxLSXpDZTVy?=
 =?utf-8?B?Um5XcHB4MG9qRFdrdGV1QlhlUzJWOUdyQzQrWlYrL2ZhWFl0dVp3d2ZScFdx?=
 =?utf-8?Q?L4ajTLjPjWus+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eCtJMjZCdDRjN1lwN2R5c2k4TENmcnd2a3ZJemxQOWNPdnJWQUtnQkZWd0Nh?=
 =?utf-8?B?NktLeEJRcUFvN2RPaXlZOFlpNjFXRDEvY2labnZCTytmV2VVZEF0T0xHRHpm?=
 =?utf-8?B?aS9qVjBRMldyUjhJWEJTMFN3SENmekNUekNORVVDamxkNkl6NlI0N202V3hK?=
 =?utf-8?B?WXREckF3cGdDbDNEWEZISXJoc2R1TU9oVGRmSHgxSzJvWGVmN25aYU4rQWpP?=
 =?utf-8?B?UEdNWk85d0JGeCswUnMrQUhzci9Lams5UVJ0R3FoRmtNZWZwekloVmJvaHZW?=
 =?utf-8?B?ZHJtRE40eXQzemx5d3NDcEl4UzRlMHJHQWIvc0w1ZnBWQi9JVHFzaTE3K0Yw?=
 =?utf-8?B?dE9LZkw5SFNleFF0N2VnRHBSMi9ST2szM0VmM3BzVktZa2VxQjJuNEJERGgy?=
 =?utf-8?B?RWNHWGpESm5rdEppajVYM1BuVU45YVZKblNvUHo3TEhGUmh5UXg4M2NGc3Vo?=
 =?utf-8?B?KzJSVlNpR3Q3ZGVONndFOHVucnlmWXJ3UlZ2MGR5MVpSNlJPSHVsUG9HYWlX?=
 =?utf-8?B?T1lLYnNTOUtUaFBvL052c2UwdjhyL0haOHhtbFhCV3VnVTJnUktzNGoveXhF?=
 =?utf-8?B?TmRid3VlWmJWZENjbVlyclJBS1VIYXVOUmh2TVFxNVk1TjMvRGNEMjZBcjhS?=
 =?utf-8?B?NXdyTVFibWs5Q1VJdzNSYXRHeTBkQVpxSTlUbWZpampKMmsvSVNRejV3V0hZ?=
 =?utf-8?B?SWQ1Wm5xeU9hMlQzN0I2aER1ZklnRDVMdGgxd1VPOUF5NjA2RWwrWTBFRHhI?=
 =?utf-8?B?bm9iaXpFdlNydjJ4eGdjY2hrcTlJTnVoRWZmNVc3SFZXdU01QTFFWEJJL2tt?=
 =?utf-8?B?NGFJQ0tyQWl2TEtDWUhNWWZ1Nk9tQnJjRno5aHg3MDRwYzMyT0hyQ1V3LzdM?=
 =?utf-8?B?RmtQSlJYZFowdDExeXo0SGRYRmF6L1V1OWs2QmVMUUhvZHpDd3AwY20yaEVa?=
 =?utf-8?B?WFVVOUFwZ1JlSFh0WCtGYy9qU2RxVDN5UUdEaTdMbmFnM2xlY1RUUmIyZldy?=
 =?utf-8?B?K3R0YUpYMUtsMmEvc2ViVVhUUWJpK3lkSFNhYlBBNno0U0k5ZUo1QU9jdExs?=
 =?utf-8?B?UjVRc0tXVGFtTGlNV295SXVwbnZjcy80SURQbjJGeGFyZnJmY0duU2FVM3k4?=
 =?utf-8?B?NEUxbE95akQrejFxenZBNjYxMVhRSUp2cUZuVGlSV3RUOXBDOFhCVUlGK1Vx?=
 =?utf-8?B?MGpnMGYzSndtVytieUpVUENUTmxMOS80Z3htUEdWOW9OWEhXV05EQWVXMFJR?=
 =?utf-8?B?WUVzVjI2VmZoc3ZWVWdiVUJhQlkzdktBdmJSRTFFNnVINmlmM0hycVkvRENU?=
 =?utf-8?B?RVcxZnkvc3owekpkRkhDWXZrOEZKUDF3OVU0NzJ2NUZnak5YN05XUFNFNUZE?=
 =?utf-8?B?T3R3ZHU0ckF0eUh4bzhXdThnVzE0eWhMWjJBL0U3WkZKeXlLM1g0QThZaXcw?=
 =?utf-8?B?dmY2aWtpUVJMeG1uMy9vdFZSRlIwbUJTTTVaemNOaVpLUFRZaWY4S2srRTcr?=
 =?utf-8?B?NDkzUmN6OVN6Y3BSV0pkSGlaaGhUSTMyTlE1Q0FOeElKODU4dThMY1pvUlRO?=
 =?utf-8?B?T1F0TjE4cWwrVkorZ29Id0ZNNW1BQjhZKzFJUm5DSDdaRlN2Q2RKUTFTd3Ry?=
 =?utf-8?B?SnZtMFpwM1U4WnhvUWN3M01vaTdVRVA1N0hDb0NmNXBxQUFYdW5UeklvSkVh?=
 =?utf-8?B?dWNGVFhQSW9SdTN3NVJ1Mk1qL1dRWmJyaldNODlRMVRqR01mU25RU2hyQjhY?=
 =?utf-8?B?Y1NSVVBxTDN1L1paZHJYMUcvUjdzeWxzbU9FeUxzTHNRSWFVbGU2eHBEaHRO?=
 =?utf-8?B?ZGpFYzVBTzlpcTJCN3MvOGFOTk1sUWtTVHAzZkxXWitYVnFJY3hMNU96K1E3?=
 =?utf-8?B?cFp5Qnh3dHA2RWtUVVBLYUkrWXkrdk15UkkxckRWck01ck5yTXVtRStrRXI2?=
 =?utf-8?B?eklNU3V6azMxWUVtaWRlMzhTUHFoZUZGdiswOHhaMlRLL3JVTVpXOW9oYWN1?=
 =?utf-8?B?a0d1d2c4c2N5QTBBaWxobVpQR2VoMTRzQVcrN1VVOWRJY2xtK1BHQlM4MDdy?=
 =?utf-8?B?QUtYWEdudk5MNzJwU251NFJ4bndyZ0ZwYk5VN1RqN0s4NXRRL1Vxd3Byd08z?=
 =?utf-8?Q?XGP3Kz4SMnikORcEjNoKV/43s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e89ee854-e8d8-49da-5f74-08dd1bb404ed
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 20:23:34.8431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOy8Y2GHmRyxvM7Y8aJM3ciB6pLXfA9uiddFIDxx6hCYvyUR6p7S7PA41RxfNDyBvFMoQXkE10jZqd2O3iqZIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459
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

On 2024-12-13 02:08, Zhu Lingshan wrote:
> kfd_process_wq_release() signals eviction fence by
> dma_fence_signal() which wanrs if dma_fence
> is NULL.
>
> kfd_process->ef is initialized by kfd_process_device_init_vm()
> through ioctl. That means the fence is NULL for a new
> created kfd_process, and close a kfd_process right
> after open it will trigger the warning.
>
> This commit conditionally signals the eviction fence
> in kfd_process_wq_release() only when it is available.
>
> [  503.660882] WARNING: CPU: 0 PID: 9 at drivers/dma-buf/dma-fence.c:467 dma_fence_signal+0x74/0xa0
> [  503.782940] Workqueue: kfd_process_wq kfd_process_wq_release [amdgpu]
> [  503.789640] RIP: 0010:dma_fence_signal+0x74/0xa0
> [  503.877620] Call Trace:
> [  503.880066]  <TASK>
> [  503.882168]  ? __warn+0xcd/0x260
> [  503.885407]  ? dma_fence_signal+0x74/0xa0
> [  503.889416]  ? report_bug+0x288/0x2d0
> [  503.893089]  ? handle_bug+0x53/0xa0
> [  503.896587]  ? exc_invalid_op+0x14/0x50
> [  503.900424]  ? asm_exc_invalid_op+0x16/0x20
> [  503.904616]  ? dma_fence_signal+0x74/0xa0
> [  503.908626]  kfd_process_wq_release+0x6b/0x370 [amdgpu]
> [  503.914081]  process_one_work+0x654/0x10a0
> [  503.918186]  worker_thread+0x6c3/0xe70
> [  503.921943]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  503.926735]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  503.931527]  ? __kthread_parkme+0x82/0x140
> [  503.935631]  ? __pfx_worker_thread+0x10/0x10
> [  503.939904]  kthread+0x2a8/0x380
> [  503.943132]  ? __pfx_kthread+0x10/0x10
> [  503.946882]  ret_from_fork+0x2d/0x70
> [  503.950458]  ? __pfx_kthread+0x10/0x10
> [  503.954210]  ret_from_fork_asm+0x1a/0x30
> [  503.958142]  </TASK>
> [  503.960328] ---[ end trace 0000000000000000 ]---
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> Fixes: 967d226eaae8 ("dma-buf: add WARN_ON() illegal dma-fence signaling")

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 87cd52cf4ee9..47d36f43ee8c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1159,7 +1159,8 @@ static void kfd_process_wq_release(struct work_struct *work)
>   	 */
>   	synchronize_rcu();
>   	ef = rcu_access_pointer(p->ef);
> -	dma_fence_signal(ef);
> +	if (ef)
> +		dma_fence_signal(ef);
>   
>   	kfd_process_remove_sysfs(p);
>   
