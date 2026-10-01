Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA84CA5FD4
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2026 21:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6928010E033;
	Thu,  1 Oct 2026 21:14:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CCGVpHDz";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9B7C10E033
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2026 21:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuU8y71GZSiXKFL/MmC3u8ywTovRRkF+skPUyG9NkZq6nhSLFyEMm+ZU+pZiV5CtC2ca7An2ut3yLRnR9HSDwF6LOKxZs7G78+zlL9HiKURZMKY9vg02ptE3JTDLsIbixbNOApzZOGrdu4KxeJBAXz51qvmzmJebWGFlbH7x01i/nfgrKbZBHbRcnbnzh5CIca22SG+SD227am/1+LMDQ2OovkAzeClw5Gq2xztCLArUXkOnXlvoRx2dTPOe1YrzqTJ5X1RBbY+5l1lN1ZoMwu0beVEB0jIRcRHiHafXj/HEZrvN/N+znTN6S0uTirAdbk7J3L0Sdj39sX9MEQSYTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Y8IPvc9GaVRUCFD4va1VcAVSIOP+YdfOhecW5iPdIY=;
 b=ggnbKTJKkvishi0QZqVqdEkLtYOoQFcSSEhVWJz9wXmGeAIeCDNNTF3OnbiM70fZWvihkawLt1E+WW3Y/MZfZtba3tYjoSNCGN2l1AoAZD83JF/xmyZf4A4nYXitM6Ka6vSYXsT5RvrSFMkS6zzXnCUlLxNaP5whrg6wMvL204CvmJVJSgtQc3xxAKCaTy6I9AoC7/XBbB68zR8Jwxxw5KMzH/2mTWMjfb51Z2uZ6OerZhDANrUwQawKY4m35KQizlRhnklqzE/pXYj3zNhjhQGEOja+Ci9iHRvBI6aC8nvMY/6MpYudbrWvxgKHu4wNSD0CL/eeCkyK4zsCRvLu4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Y8IPvc9GaVRUCFD4va1VcAVSIOP+YdfOhecW5iPdIY=;
 b=CCGVpHDzT1+w1fVh3FrRGZwrzTSfjjbYyOcUk7r62WiZu/JD3zUVFsy8o31Cwh0Ti69tF3aNeqNRU6F4vm7/ls4CRGrgUC1rlF3pXQG2x+LyZWybshgkL6C/fAe4VLim7FXGKGS/1T8Vfxz3IZgjjS9HNBjTKj+XSustOcgDQ9Q=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SN7PR12MB7202.namprd12.prod.outlook.com (2603:10b6:806:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Thu, 1 Oct
 2026 21:14:13 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0472.016; Thu, 1 Oct 2026
 21:14:13 +0000
Message-ID: <ca2e957b-a0ad-459b-907d-d57fb8ce10dd@amd.com>
Date: Thu, 1 Oct 2026 17:14:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] amdgpu display debugfs handling fix and refactor
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Roman Li <roman.li@amd.com>,
 Tony Qi <Haoming.Qi@amd.com>
References: <20260924114049.55201-1-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260924114049.55201-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::27) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SN7PR12MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bde5098-c29d-4be8-1d5c-08df2000f14f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: AlbRkgv8KgFxWbOLDbiebveewQTlPkUIbEiCcEM5JN5Mv5uWmYE9NsFm7ldMdRIgKUCiqG8ETAfd82ezulLl8I/ixEMWyWs5bbPvZ6ZHB29ktM0kx+S3xRCne5vl8+L/U3POtKLyWLwKTtLhiFAWGZGrWY6sJMUCNbQ7tqPc1o715B66+/ygJLxMLZRqdAAQu8+UC3pw8OIDJIhdoU8rRg/vizHVfkr6JXWgkE/w38FCE+5EHBSCjmi4bgaQPRkTtju+Cppho8OI2Pe5EaY+3bohDh8LO7MLX4aJwvguTPJbvLTaN9gcobkC/zSUuruuR2qlb/+PvbH72fZfOdBsth8bnF/TNuObcCb7ADIyStLihLtqyAI3R8VCD6lrgE5btJ54k/kd9TbW9WrW1IO0geivFPTDfEAwi3s1e7ii2TB2clsRJVjCrPiGCJT8dO1TMlbq3ae1LbrDnQ/wmu9bMK1nr4nx+XjLaSjmqd2MNnlbMmLwmdKy4KuF9fhJFgLOdT4hs0gm/VP2s5Bf/ugFLJF4H2p6O0auEonYGLCLsiDBYh+fZhRADOvrb0ZQAxR0nXZCJFg3I+pdPn4HV6IVD7YMaoHE0GAs9B5EWQduVUm68LxqzOc81rn1W1HX1fNKPp+F0EU1J4a9EEbrke8w0XPex5vyLaCksaiOUc0aWLc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHQ1Wk8weDhOQThPNE9jcG5mK0FWWFFrNDFsV0lJbmZYU2FoTXFaaUlzSzYw?=
 =?utf-8?B?NG9PM1pxZkVvMTVObGVRdTZ3S2F3OGlmWW1qaTlNN3NlTnQ3OEZrWngzeER3?=
 =?utf-8?B?SW9MNDd5a2dWTDgvdFV0QmxOQllYVEZvL1pVNVB5SGQrTFF3VXhINUFLYjR2?=
 =?utf-8?B?Wk44MWpjd0xrazROM05vNk1CaDQ3UVdvb0tFbm9OeWt6cUxTZ0ZwY0xFamlq?=
 =?utf-8?B?WWkyckdTZkF0UXpXRy9DMDQ3QTFKWmhBYXVFRFQzd093NnpRd05oQTNkL0hv?=
 =?utf-8?B?eUc3RUNOUkJGS1pDQS81eE50MituUEtDWlV1bmhEKzlIYTBzdXRHWnpFOGNi?=
 =?utf-8?B?K3pET3NjRHR5SlpybWJQTEFuSVp6bnBDQm1GTjVUVURVTktRd1pxMnAvTlRr?=
 =?utf-8?B?UXArUDZmTnFBVFM1a2tmcDd6V21MUzBCeDJSQU9lYUJwMGhHaUFwMVBDbUVx?=
 =?utf-8?B?amQvWTBxN0RCckVzNkhGQlVBYUdwdG82Vzl4NjNIMXBNNWY2ck9LRlJrOGFr?=
 =?utf-8?B?REFlSHpPUU8xNUtDZ29tSTVvLzd6Vk90OUlrM3RKU1ZPOTB1dGFHa1hqRHpK?=
 =?utf-8?B?SVAwa3pZcnUyQkhTbVovY2lCbUMxaU1PRXgyMDh3cExWVFNkNzNTTGNrL2Q2?=
 =?utf-8?B?OW9xcktnRFFZdEZoV1FyRWthYzhTQzcyZUhpVmhpSTJydHlSU09TNTRKZExC?=
 =?utf-8?B?bXdzWjhuUGJIYk8relVDV0dobGNTMW5mSkF3eG44SjRyY3EvblpKRkpXbmtn?=
 =?utf-8?B?aEhXd28wVEliZSs5YjRIU2ZuVndCdFJ3UnU5YURnUWxlWmNvNXpIQTVJU2V1?=
 =?utf-8?B?U08yWEJZcTd1WnBFYVdDWm50YTRleTl6SE5COEhPdEd2TFo4RHRNQmJmWm5V?=
 =?utf-8?B?alNCMXZCNGQwVGplaWFNeXhUaFRUb0dKSWk0azlreG9GNVZwalp4K0tqU3lu?=
 =?utf-8?B?K1VpQ1BxN3VlUDFCaTh0bGszN0UrRGttUWZGM05VV1ZMcmF4YkJ6czlQeVU4?=
 =?utf-8?B?VnVGMm1oQUladERUdUlpOUx6M2JmOENRL3h2QkYxdmJpSXpsTlpKME5HWTcw?=
 =?utf-8?B?dkZpeWxZeWNTQWx2TFlvWEVYc0E0M1UxVmppNGpXSk5USUhuL0pnWXJGcEFR?=
 =?utf-8?B?a05lTFZSeHRHVThwcTlGdGFlL3hEUWpSaEpBaXI4OTN0dGFibGRac2VneUx3?=
 =?utf-8?B?TDBpL1lGRUxaY0RDaklWSWt5QUVCUEQzcTUyM0s0UGl6eE1odnYzNDc2N1p0?=
 =?utf-8?B?V2xwZUFFZTJsSXZPYUJwU09IWTc4dWlMc3pRQ3FLMXVNN2tKSUZZUUVhOFY4?=
 =?utf-8?B?NE8rQnhaNG9mT2VlaVpTRkMrT3M4MENuNDJucGRSVWc1RXBDMVExT2kxckZG?=
 =?utf-8?B?UndsbG1ub05OVVZUY3J3Zzg2QkJyd1dtWFpEWEp1U1kxaWZWdSt4Nm5HZUlJ?=
 =?utf-8?B?RnhxZjYvR2I0YThlbldpa2s5VGNRbGVYQm5KWU1xMVl3TmpFTmk1MjlzUWsx?=
 =?utf-8?B?bGFYVkgvSGxvWFk3YWVsZmhqZVd6WXlqdmw2b2dNUGRsaW5ZZDhjYUtVMEVU?=
 =?utf-8?B?ZWhKaTFHck1xUXZRalBxRGgvdDZCVklQc0pLVG5jakN0RW9BZW92QXlPbWVQ?=
 =?utf-8?B?OFZCRlE5a3R2MEU5NW9jeVBJNEgzbnd6YjFkOVZKSENlVCt3ZnJMdDdTakN6?=
 =?utf-8?B?alc4bElsSkFmL2d0a2FTUWZlSVlubGJtb3NhVFBmSFJ3cGJBcDEwMzlwOExl?=
 =?utf-8?B?eDBnSVZMcWV6UjFNbXFkZERaeC9pb1lDMzh4TDU4QlVSc25rbmpCbHdEeUUw?=
 =?utf-8?B?TVhiSkkvYkZDUWJPelhSdmhnQVErbEx3UEtYRTVWcDk5VUdCNVlJK1E3aVlP?=
 =?utf-8?B?a0NLT2Y0VFFFSE80NklsQkRYVTJsbk5kVi9tQVZocjhIRGRvclh6Mys1YzFv?=
 =?utf-8?B?Wk9xeCs5c2VMc2lMZC9kTWNDRXFOc3BFMjFjaW1heUo1eXpCb3MrMG5qeCtZ?=
 =?utf-8?B?R1h5UkI2NFIyaXh4b2lzelZ5YW1nd2EwbXdlS0NPQnFIRkZDNEtaWm1WdmU1?=
 =?utf-8?B?U1RhWCtnRFVHZUVzUVAwMHlHc1g4VVRvT1JZQjN2dU9MTHhKQVY4Rk51cFRE?=
 =?utf-8?B?M0FaMFE4WkM5THQ5enNoVVJiMzNGSFh0aWU4U1JFbG43SkNSNThRRlJKNUZk?=
 =?utf-8?B?ZzkwUnd6RlZXVzRXaUU5SVYxdmR0aGI2Vy9SdTg0V0NaRmwxVFFaTmZiMm5B?=
 =?utf-8?B?b3Ezd0V3WjhwRHpud3FPMzZtQm11MmFFV2JYUnh3aFlmdTVaU1cydEJ0d0w5?=
 =?utf-8?B?SVd2TnBodHdkdURTRjIyWEh4aVNIQW9wczJmTHBvOTVpUjNiTXc2dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bde5098-c29d-4be8-1d5c-08df2000f14f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 21:14:13.3145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pwtaYTXifLzPfrzBcmkS2WeZegFtyJB6VL8A2dpKnA7MY2HrDogQSy7ewqp5hh0XrfMsw+Pg0xeR3k7CPMzoeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7202
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

Hi Tvrtko,

Building this patchset with clang generated the following errors:


   DESCEND objtool
   INSTALL libsubcmd_headers
   CC [M] 
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.o
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1516:6: 
error: variable 'crtc' is used uninitialized whenever 'if' condition is 
true [-Werror,-Wsometimes-uninitialized]
  1516 |         if (connector->state == NULL)
       |             ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1541:6: 
note: uninitialized use occurs here
  1541 |         if (crtc)
       |             ^~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1516:2: 
note: remove the 'if' if its condition is always false
  1516 |         if (connector->state == NULL)
       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  1517 |                 goto unlock;
       |                 ~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1492:23: 
note: initialize the variable 'crtc' to silence this warning
  1492 |         struct drm_crtc *crtc;
       |                              ^
       |                               = NULL
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1674:6: 
error: variable 'crtc' is used uninitialized whenever 'if' condition is 
true [-Werror,-Wsometimes-uninitialized]
  1674 |         if (connector->state == NULL)
       |             ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1699:6: 
note: uninitialized use occurs here
  1699 |         if (crtc)
       |             ^~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1674:2: 
note: remove the 'if' if its condition is always false
  1674 |         if (connector->state == NULL)
       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  1675 |                 goto unlock;
       |                 ~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1650:23: 
note: initialize the variable 'crtc' to silence this warning
  1650 |         struct drm_crtc *crtc;
       |                              ^
       |                               = NULL
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1832:6: 
error: variable 'crtc' is used uninitialized whenever 'if' condition is 
true [-Werror,-Wsometimes-uninitialized]
  1832 |         if (connector->state == NULL)
       |             ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1857:6: 
note: uninitialized use occurs here
  1857 |         if (crtc)
       |             ^~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1832:2: 
note: remove the 'if' if its condition is always false
  1832 |         if (connector->state == NULL)
       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  1833 |                 goto unlock;
       |                 ~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1808:23: 
note: initialize the variable 'crtc' to silence this warning
  1808 |         struct drm_crtc *crtc;
       |                              ^
       |                               = NULL
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1983:6: 
error: variable 'crtc' is used uninitialized whenever 'if' condition is 
true [-Werror,-Wsometimes-uninitialized]
  1983 |         if (connector->state == NULL)
       |             ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:2003:6: 
note: uninitialized use occurs here
  2003 |         if (crtc)
       |             ^~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1983:2: 
note: remove the 'if' if its condition is always false
  1983 |         if (connector->state == NULL)
       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  1984 |                 goto unlock;
       |                 ~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1959:23: 
note: initialize the variable 'crtc' to silence this warning
  1959 |         struct drm_crtc *crtc;
       |                              ^
       |                               = NULL
4 errors generated.
make[6]: *** [scripts/Makefile.build:289: 
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.o] Error 1
make[5]: *** [scripts/Makefile.build:548: drivers/gpu/drm/amd/amdgpu] 
Error 2
make[4]: *** [scripts/Makefile.build:548: drivers/gpu/drm] Error 2
make[3]: *** [scripts/Makefile.build:548: drivers/gpu] Error 2
make[2]: *** [scripts/Makefile.build:548: drivers] Error 2
make[1]: *** [/home/alexhung/develop/amd/amdgpu/Makefile:2144: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2


On 9/24/26 07:40, Tvrtko Ursulin wrote:
> I had some patches in this area ages ago so I re-visited them, tweaked and
> decided to re-post.
> 
> First is a clear fix while second is a serious refactor which needs a lot of
> scrutiny. Mostly closing in on the desired semantics and thinking whether
> changing any of the existing (incosistent) semantics is likely to break any
> (hypothetical) scripts used for debugfs configuration. In it probably desirable
> in principle since it removes a lot of redundant and somewhat questionable code.
> 
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Timur Kristóf <timur.kristof@gmail.com>
> 
> Tvrtko Ursulin (2):
>    drm/amd/display: Use memdup_user_nul in debugfs code
>    drm/amd/display: Simplify debugfs token parsing
> 
>   .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 600 ++++--------------
>   1 file changed, 130 insertions(+), 470 deletions(-)
> 

