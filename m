Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5252BC54E65
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 08:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E15E510E6B0;
	Wed, 21 May 2025 08:06:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R5xih3HS";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 734F810E6B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 08:06:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlXWZMNcPdsTEhqweAl8H+FCg8Ch7Lofd6kZwihbpUp8FPuAVKnJO+0S1xO/fvb0Tt25aREuMMi8D/ZKs6AIf3l0IVCINzjxWtX2VjN3BfBMsaPzj1GZvlPtC7LsGCx3sM5fNiIPJJvMV7WpWgV+pDw+2Joo3u5aCBh/rxzCdMEwV0MyzNkk4NweasuahJdoCWJRO+k8U89yEV6vgJZW33vnkYumBzEw5VloRCXItrYfn86oL+1zQNjDpGsnUqI7/BnDxEGlkMQbnOp7NzQkvoNvnaAORbyKlRo/jByNOJhYl63T5VankDIkcaI2rFxBfa2daRPcKXovoqiLcJo/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYKXVoyIq5WJDB8kt7VMO8po36kkzF7FH1tSQ/V/JO4=;
 b=Y9pykkOJ6rNdhGF9PhpbD4Zgz3ya67/YHSH8rlMvnoXqVNMUthJmPgBkYXE/AWEbLuCfK/Ik400RA4OakEDUQg1g4Ye+Z1va+a829F9n6yQb6aRHBmEfFRlUUXI9/2qAl0xQp46IE4x8cXsHO5NZjhgdv4Q5GDwnFGsr5AUnYWJu5E9x6sUS24gofhn8C5pzc2K6+lwjgf9FnNKJxxmH47QoBw2jlUxtEveXXjCeu8a49/tf+hcRzAMmajGGpclrWOA+e4T81nIj5KTkI1m5Z370lWWbyDfapF8Alw2qhsSfobXPY+MwkArmEfGzIhRHRh+CaOTV/LWp4ghT6Qx62w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYKXVoyIq5WJDB8kt7VMO8po36kkzF7FH1tSQ/V/JO4=;
 b=R5xih3HSWfUwz4UsCixb6qz0Ra/z/58buCPQ0e1Q62Gb4KSbHigKNhLXtoG9Ffa5kBWbPjcnUGzx9jT9Iy0WFbA052QZXyjeMF0zSBbP2HYnLZ1XSqyXdmkepjTamq+jazHPLcmBZ2yy66vM7foteFn02l6U/5PICR0BzXNcyR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 08:06:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Wed, 21 May 2025
 08:06:07 +0000
Message-ID: <67fc5bc0-e1a7-4074-ab4e-bd7735b60cd1@amd.com>
Date: Wed, 21 May 2025 10:06:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] drm/amdgpu: enable pdb0 for hibernation on SRIOV
To: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>, "Ma, Qing (Mark)"
 <Qing.Ma@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Deng, Emily" <Emily.Deng@amd.com>
References: <20250519082038.21459-1-guoqing.zhang@amd.com>
 <20250519082038.21459-4-guoqing.zhang@amd.com>
 <e75c26e4-8011-4e49-9e2d-d354dcf7358b@amd.com>
 <4f3c7a86-c89a-429d-8ec1-5db7a0d12c6c@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <4f3c7a86-c89a-429d-8ec1-5db7a0d12c6c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0359.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::34) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4269:EE_
X-MS-Office365-Filtering-Correlation-Id: 87be4eff-f530-4488-05f3-08dd983e56fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3FIUTh5N21IY3RQZUFHSENGUGx6SkNFUk5LWEMvVk53Y0E1WUNnZjlITXNn?=
 =?utf-8?B?bEpIYnJJcUI0SGlrVS8vSmZ0bWwrZVhpM3MwVVJISTdUQ0N1S1cveVY3UjJr?=
 =?utf-8?B?N2Z5aEdqK0c3WkxPdlE0ODJsUGczWXR1S0RkUm8wZC9oTzdrVElkSU1lTTJT?=
 =?utf-8?B?TWVSSVgzb3lDL2cvcWgzTVVMbkd2ci9zL3dNakhaaFRIakJpck1wM3BydWVR?=
 =?utf-8?B?ZzhmRktMdkhKdTRaUXVuSDBYL0Z6OUVnaWwySWR6cjJGV2RsclRpMCsyeGVw?=
 =?utf-8?B?S01na3JKTjlMTFdJTE9iRWgrV1dicXZjZHRHWENOKzNXM1hLVzZSSjFkLzQx?=
 =?utf-8?B?eUt1K3crd1B2eDBINVlsYm9GOURmS25Wc3VIKzBYOHoxaGpEY3pObG1SSkND?=
 =?utf-8?B?OThaMHlKSTVDZHU2ZkJlNC9RWGQybGZpbEN4NTA3Z0lJU1FLL1pQZ0EwTHNu?=
 =?utf-8?B?Um5lRjNXSEVzRkNrVjdVcjQrbk53MllNKzRDUDB4eS9xcUpIZGY3M1RtcVhv?=
 =?utf-8?B?YThyRmtlWHVPbXRBUXh6Snh4cVRiSXRDbndLdENNSlNMRkRMUnFVbG9WUWdm?=
 =?utf-8?B?bXg5NHp5UXFwWGlwYlFhZThhVTNTblZKdzcwUStUa0NBWUZYUzVwSXJ6aVNw?=
 =?utf-8?B?cWdVMnJVN05UY2xMbFZWYzJQVjVjcC94Q281WGpsN1hUb3dqeUExUWkxcERI?=
 =?utf-8?B?Skw2ZWwvWll1U2FqZ1pTSTNsTHN4VGtIMzRCMERIWlREWjBYcS9OOUs0d2wx?=
 =?utf-8?B?aXZRMjY1TGtiNkxUS29kZmlHUUk4UjJHNDk4ZlAzQkVFS1JncmpnVHV1YWZP?=
 =?utf-8?B?eVdKV21wVlZVM3ErYmlVZ2FNcC9reWNkN2k1NDBRRTdERUxWOFowZ0hrdkFX?=
 =?utf-8?B?bnMyRms5cEVaQkJJbmI3bGJKdVQ5MVFlbjZCK0p1WFZEc1VKYTFRWHdkZXlV?=
 =?utf-8?B?TnZaTUk3MDBvUTNkdnhWMHV3YWhVVFhUOUUxMEllL0huWHh0RUJ0MldIamkv?=
 =?utf-8?B?YWdNQXBTaHVwQ09oRCtRVWMxcUdwR3Jud091UzEwQ21qUnFtOTE2QlNyMU42?=
 =?utf-8?B?bjFzZ0F2SzdDLzNvWWdRV0tGRjczRnJNaDVlVG1VRkJmU0dkM05lUGZiUjh0?=
 =?utf-8?B?QU02N1A0TWhsSzZ5a21rdU1UWm9jOG5JTTZ5ckVucjA3QUx3RGF3RFpWVWVt?=
 =?utf-8?B?T21BNmFZcUx3NzdBYWVZeWd4TWJQK0U3OW9obVRIM0Uzb05ibGl5M2xKNmp0?=
 =?utf-8?B?YzVzdHJnSkhMK1BDVVBNbXAycEpKZUJRdTVYWmZ4YjM2UWlxNGo3QjVnZzhW?=
 =?utf-8?B?NHkwYURmV0kwNm9neDQ1NkJIK0t0T2FTVGIrcSsxUUtvbXE5Yjl1U1NWTHIw?=
 =?utf-8?B?YmlYYldwZXlHTi94SlErMTBqbjVzcEdDUGdDU2R3R1BqeGU4M05LbmdlS3g5?=
 =?utf-8?B?czNlRUpOeE5IUXduMzFNSWhZT2lzNTJzS2dZOFhKL28rNWFHdDg5QmVDTTJx?=
 =?utf-8?B?d0JqYmM4ZHlZT2N1b0UxdXJBbTJzUjh2LzdtUjdNVDQreDBkUElnb0hiOFpz?=
 =?utf-8?B?ditHeDRtQjlGT0d4MGx6RjROT2tkS2ZWMExZWXRrYWNZREJ6L1h2TjRkWk90?=
 =?utf-8?B?cW1ZWmNCd0gzNXJkU0lPS0gwSUxRZmxLLzJ4K1IvQ082cG53bE5FalI3d1Rw?=
 =?utf-8?B?amUyVDc1WlNWNTBiNlFiWmJuektBSkdwbUlyR21YZ01GTTRKWUVGL3pUdlhj?=
 =?utf-8?B?K0xLUUp1cHpDSGlmTjEwM1M4TThiclAvbmp0RnN3UHU1M1dMTmxFazZLR1Zw?=
 =?utf-8?B?VEU1SmtQUHBCNHlwVDdDdVNKOTlxdkNscFFaUmxMQllzN0ZKQnE4eVY2eHRX?=
 =?utf-8?B?eGU5c3lFSGFJcDlnZmhqdFcrdnJiRGdKdFQ5bHV1WnhrQjV4a29CMTd2d2kz?=
 =?utf-8?Q?H4b3dAVFDD4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWd0ZDR6d2RkbFNlVTdSSzJiaCsveEs1SDN4bVdtbERtalZuT05Fcm5mUU0z?=
 =?utf-8?B?a3JQYVFmZUE3MVN3ZGtONHMrYzVuSEdSbGl2akdaS2xaY3ZpaHhpWWxtRk9i?=
 =?utf-8?B?MVVZUFpOV0NrS2NvQW5kVzJBbGV2Y1BZQ3BoNCtMbWVudUxQdmxTSUhEOVNM?=
 =?utf-8?B?dmZaaHB4UjBLdXQ3TWRaWlJIUG9HMnRyeTJLSEFGZ2N2WnNXNDBBcjNBQ3VY?=
 =?utf-8?B?ai8xMkNxdS9INkU3cDNpK1ByU05WK3JLMzlkYW5uTlljWnpiQVl5aDFYM1RY?=
 =?utf-8?B?VjVHODJSY1o1U1NsU05tamR1MVVZMkZJeDQ2NHVnYzNXNElBMmRTTlUzN1c1?=
 =?utf-8?B?WUFvWnAwTWgrbWJjT0xPQ1MvMFdSRTBuVFhZZTZsaHcrK29VcW9PNnVCd0dM?=
 =?utf-8?B?S3lMRWVRM0EweXhJTGI2NUVTUjR1N1FWdng3Q3NpeGppaWgyUXJtSTZXU3M1?=
 =?utf-8?B?RmM1RW1kcmptcXhtMUtVaG84Mk90NVk4aUpiWXQ5SGZYN096VFkvQUdXaDFJ?=
 =?utf-8?B?RThPSUN1SUFJNkRCUE51eTF4ZXFZd2Nobm8vK09yMUVMUWh2TFA3eVNDdEk0?=
 =?utf-8?B?WDhlVlpVQy9nMkNibTFhQ2lzY3VobFVxRzZiTVQ0R01RamJRLzdrVmx1Q0VZ?=
 =?utf-8?B?TGRaR2ZYM0FLNmI1OS9la0Jueldxc3JoN3drRFpFWXZ0MXFaWXNKTGpWQTRq?=
 =?utf-8?B?Z1FzSjF2UEVXZGkwQ1MvU3RmMDFmcDJwVWcwNk5aS2RWOUhjOGNTaDJKZDJB?=
 =?utf-8?B?UVlJYlA5RVFKM3FkcEZmZGpELzgwNTk0K0hBY1VFM2g0TFhZU0JjelAycThl?=
 =?utf-8?B?dWFCamhUZWNua1Ewbm0zM2pXWDFJQ01FSEVFZ01NUVZjcGlveFhybXZFZWo4?=
 =?utf-8?B?N2pmaWJxeG9KSUU0dWRYWXBJNi9SYkNGNUpKQ1hyYko5SzdjV1MxZE9hN0hZ?=
 =?utf-8?B?WVhTbktrOXdGOTN4L3lxQ21kWEdLOXpvZnJsRTNsbXlGMzRJMXhndW1yaUhw?=
 =?utf-8?B?d2U0ZHZ5VWFFNjZzZUduUHAzYmE1M0p6WHEzdVZad2xZRGtqKzFVRkQyQlBZ?=
 =?utf-8?B?b1RhdW5jQmFDb1A4TE81bENXa3phMUZ4OEFSUnVHR2c3d1Zlc2hVWlYzczhy?=
 =?utf-8?B?VUkwQS8xaHFrRWxVbEVEcERDMzhna0Zhb0dEa1NQTHIxeEQzM0VubE5aejJI?=
 =?utf-8?B?TGNLWmxzbGtLY1gxOVpyV1JvdXg1dmFWNkJxTENaaWx5Uit0aHJkS2xlZXYy?=
 =?utf-8?B?MTNCU3YvZTUxYUlRUngyVE4xQTd1RW9NOGkzVndwaXVuTFl3b2JicENxdlNM?=
 =?utf-8?B?ZG5oV09JbVRwZ0k5dU94WmZQL0h4UXRSblEranZkUEZQd3NnTG84SytUZHZ4?=
 =?utf-8?B?TW9DUkkyRWZmWlY3WU5TSFFranlpRmluUXlNWjhyVkZLTTlzN0RJaS9NS2Uz?=
 =?utf-8?B?ZXRMNHpsMnlsRVlJV3hDbnluNUVwWEZPa1ZUOXl2SkNJb3FSU1duTUZTTGNJ?=
 =?utf-8?B?R095UmhGVmNYNC91OTVqTk45bmZieTR2c0JkMTNwODhibUorWmYrOTYrMUdG?=
 =?utf-8?B?RVVHbXZtRDNRbDVuVG5LeHdaNjRSY3M1ZStFcHI0eStwSTZCRDVFSFA4c1Jl?=
 =?utf-8?B?U3RyTmk5MUxBWFZZNElpbDdleXFUS0NOelVQUGlzZDFUY0JsdXNjc3A4M1VB?=
 =?utf-8?B?QmxuWVk3Ly84Q1lnWGIvQXhXVXFFNDIxeGliNkRXa2dSeEozRXBBSktRcU1D?=
 =?utf-8?B?UGRUSWpsMGtsckNjeTNlTWxJRVRxdmttWmhwSHZldGFPODRJUFM4ZGFwRU8z?=
 =?utf-8?B?aWw4d0RXOThVYjFhTTE3MGJEVGc5U3NPMWRFakV5RVMrMGRnTkRmdUxkSVE4?=
 =?utf-8?B?ZzVvTGhVd0hPeURSTGwrRGhUNk1SOEx0em1ZWXFkcFdrcU5QaHB3VCsyU00w?=
 =?utf-8?B?azdZS1FNVVFGVGlXVDN4Rko5SDVlMTcxS1lidTZSWEJ0UmNMZktmQ2V6ZjV2?=
 =?utf-8?B?ZXJWVzYwUG9kK2pqVmZoZnc1Q3lncXcrMUJzOHhOd3QyQUZ5SlM4cW9WUnFU?=
 =?utf-8?B?dm1DMVdUb2tZM1gxT0Fha1FVZ3VINXRVQ2hxTStrdEEwWStDT0hZc3hod0lX?=
 =?utf-8?Q?154HR2E3OeYFeZ9Vad4zTpK7e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87be4eff-f530-4488-05f3-08dd983e56fc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 08:06:07.2560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hr7dGj9YvXo7IVe5BNUvSy0L8h1LyQVK0SEGhcHO74LnfxSUm+xTZsOvhdKPMTat
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
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

On 5/20/25 07:10, Zhang, GuoQing (Sam) wrote:
>>> +    if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
>>> +            /* set mc->vram_start to 0 to switch the returned GPU address of
>>> +             * amdgpu_bo_create_reserved() from FB aperture to GART aperture.
>>> +             */
>>> +            amdgpu_gmc_vram_location(adev, mc, 0);
>> This function does a lot more than just setting mc->vram_start and mc->vram_end.
>>
>> You should probably just update the two setting and not call amdgpu_gmc_vram_location() at all.
> 
> I tried only setting mc->vram_start and mc->vram_end. But KMD load will
> fail with following error logs.
> 
> [  329.314346] amdgpu 0000:09:00.0: amdgpu: VRAM: 196288M
> 0x0000000000000000 - 0x0000002FEBFFFFFF (196288M used)
> [  329.314348] amdgpu 0000:09:00.0: amdgpu: GART: 512M
> 0x0000018000000000 - 0x000001801FFFFFFF
> [  329.314385] [drm] Detected VRAM RAM=196288M, BAR=262144M
> [  329.314386] [drm] RAM width 8192bits HBM
> [  329.314546] amdgpu 0000:09:00.0: amdgpu: (-22) failed to allocate
> kernel bo
> [  329.315013] [drm:amdgpu_device_init [amdgpu]] *ERROR* sw_init of IP
> block <gmc_v9_0> failed -22
> [  329.315846] amdgpu 0000:09:00.0: amdgpu: amdgpu_device_ip_init failed
> 
> 
> It seems like setting mc->visible_vram_size and mc->visible_vram_size
> fields are also needed. In this case call amdgpu_gmc_vram_location() is
> better than inline the logic, I think.

Yeah, exactly that is not a good idea.

The mc->visible_vram_size and mc->real_vram_size should have been initialized by gmc_v9_0_mc_init(). Why didn't that happen?

>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
>>> index 84cde1239ee4..18e80aa78aff 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
>>> @@ -45,8 +45,10 @@ static u64 mmhub_v1_8_get_fb_location(struct amdgpu_device *adev)
>>>       top &= MC_VM_FB_LOCATION_TOP__FB_TOP_MASK;
>>>       top <<= 24;
>>>  
>>> -    adev->gmc.fb_start = base;
>>> -    adev->gmc.fb_end = top;
>>> +    if (!amdgpu_virt_xgmi_migrate_enabled(adev)) {
>>> +            adev->gmc.fb_start = base;
>>> +            adev->gmc.fb_end = top;
>>> +    }
>> We should probably avoid calling this in the first place.
>>
>> The function gmc_v9_0_vram_gtt_location() should probably be adjusted.
> 
> mmhub_v1_8_get_fb_location() is called by the new
> amdgpu_bo_fb_aper_addr() as well, not just gmc_v9_0_vram_gtt_location().

Oh, that is probably a bad idea. The function amdgpu_bo_fb_aper_addr() should only rely on cached data.

> mmhub_v1_8_get_fb_location() is supposed to be a query api according to
> its name. having such side effect is very surprising.
> 
> Another approach is set the right fb_start and fb_end in the new
> amdgpu_virt_resume(), like updating vram_base_offset.

That is probably better. And skip setting fb_start and fb_end in amdgpu_gmc_sysvm_location() for this use case.

That was done only because we re-program those registers on bare metal.

Regards,
Christian.

> 
> Which approach do you prefer? Or any better suggestions? Thank you.
> 
> 
> Regards
> Sam
> 
> 
> 
>>
>> Regards,
>> Christian.
>>
>>>  
>>>       return base;
>>>   }
> 

