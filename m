Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1D6C71136
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 17:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19BC910E424;
	Mon, 16 Jun 2025 17:45:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jm60jtr4";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B1F710E33E
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 17:45:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7dZvlhUocZSRuWagBaSjH6bAu81NYrpCZLR9UjUAYQSmrHW+gj+tAvcNua09OIWvbyBsFv5ExqO2N7cYmIp3ebnCI0O0awQKCSWsNfV4KH2V6HlWFfEQ7pdBwQ0bB+kfXRnZlSqErbi9vrso9n64DtOwUfa4R0GRNqBrNWz+260Q6JtknJ5SfaCoXWtj/KF1xDCoALKPfMnO1tGk6aa6ro7plHggBAbVIBW4J1v1z25rV9UAtcahdLXtI8/qUp1fWkQ7fXj8/xWJ4XXzCUY+uBPkgFwA3OJhDhnuQ8+vMno7WWyHTde/QLdXZbEXUuPjWkHM2MhJCj1grrIZaWUxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZKDXyK9JqAFbOoka18FWglfRklSF05x4hPxz8n8unw=;
 b=XEyMMLNRbSG6eTpka1MLjvtyefbE68jr28WsYvBRulZlccrbiyK4m7bnAfGYlfaQUIu/+7IE+F+Lu0klqxUosA72CTrqXDSuzaZcOSxDRcYRLQ4YPgao8j4jOFv7N7kvUzr8w+doeGiDH/PK9l5Ud44fkixV15YfExeng1Spd3KxoMDezBKiGwggZXLJGdZjB8r5AaNrjgWZD6owMdz/sBfhYLkIQQWJxtsA/gAkssIPfOo4TTiK6I9IA9W9ae9v0oPf4ynAqKiCMi0u2H7mgF/S5XwBl3SCqUQoCEfYs+x/hSFJEdjKbjR4fefDpC8XYmypv9xgYRB2NrUCNflf4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZKDXyK9JqAFbOoka18FWglfRklSF05x4hPxz8n8unw=;
 b=jm60jtr4DhEoV3F0QZ2Rx/CPrgRErU35tQ+OH6yxa1h+3pNnFyUHk/8g+T/gnyMmrzTlSOO3Atck3wGhdMBNQU0vFqnUGBoIREaJH4y80SI4rAEbh3nFs406oOOYs+OXoAtiZdYXCBCPyYHU1eocrR1duNXXv4Ke5EDZbPvRfiQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 17:45:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Mon, 16 Jun 2025
 17:45:36 +0000
Message-ID: <70adb9ab-52fa-4877-a0de-e6399e8aee8f@amd.com>
Date: Mon, 16 Jun 2025 19:45:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/27] drm/amdgpu: switch job hw_fence to amdgpu_fence
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 sasundar@amd.com
References: <20250613214748.5889-1-alexander.deucher@amd.com>
 <20250613214748.5889-2-alexander.deucher@amd.com>
 <29965831-bf4c-4a00-b619-9782b8c6afae@amd.com>
 <CADnq5_PVLAVejzPLbYmpDKYt3qdA_BPb_fhMHXp4hr7WX+m=uQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_PVLAVejzPLbYmpDKYt3qdA_BPb_fhMHXp4hr7WX+m=uQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0255.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 7abe996d-1350-48c6-f4f5-08ddacfd9988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1pRMGplZ3RNdXI5TnFKek4yd0s2ckprNHQzTVErZW02dk9nSkdJeUp1aGk5?=
 =?utf-8?B?b0N5UWNZK2JiZkgvSmhpRjR5Z2VsaU5TM3o5M0tOV1QxQVhENm5MaFlWeGZu?=
 =?utf-8?B?czUzOFR1WUtHc055bTZldStEK2F4Vnk2SlZ3VEs4b05TdlMrcnpaR0dFWFhJ?=
 =?utf-8?B?djRCOU81cW9XRFdmaEtWRFhSVWk1T09VQ3h2SGY4NEV1RHkvMWpYUXZCeXpu?=
 =?utf-8?B?THFtZ1RicG9rWmZSa3dlcFVCWXE3Mm45NEJCbFZvM2tFZy9rLzNiK2dscm1Q?=
 =?utf-8?B?ZWsrYTFjU2dCYlhzL0RBRXJaWEdxY2lwR0V0S2FWZ0xZTzJwSllnZzVLalZC?=
 =?utf-8?B?VXBIYzFrM2Zaa0o4ZnQrVVZ1cmVtdTh0bEcxbVg3Ukx3d0FjaUw0YU1ZaktE?=
 =?utf-8?B?b1lsUmdLUThkaGdJeWFkMUZ6RGxxWjlqRWJ2dGlpMGNJOHZReGVrZjhWKzMw?=
 =?utf-8?B?RDFUWTlabTB5Tkl6STI4WmFENmJ3N3dwUEUwVnFWUzViYVM5UHZYV2JISmp4?=
 =?utf-8?B?U1JCd1Z6YkkrR1pjTHBvMWhmRzJaQTEySHA2Mys1ckFrR2JFUk5paWZxRkR5?=
 =?utf-8?B?c2ZBZGJmdnJmSzhyTG9RS1VuTWZtVms5SmQ5YkNFZnlMLzQxcjQ3RE84NVFG?=
 =?utf-8?B?TEI1ZEdJT3pDbE9ieGxDZGd1VGp4WWJrOGJ1ajVZVHlzSG1xblBTY0xyeUcw?=
 =?utf-8?B?RnBJZmpOUGtnbkZ1VlRjeGVKUGQ4amJwZWpyYUpiSHFnc21GOHNHdFZQRTUx?=
 =?utf-8?B?TVpvYUQzc2tMMGFJZkNaMG8rOGFjY29UdXI1Q3ViazYwUGcxSlJ6eGx5Wkxt?=
 =?utf-8?B?TG0yZ0RLbkQzTXk3QlVWeTd6YU1vblhvOGthMzEwRXVUNU5lMmszUU10ZkE5?=
 =?utf-8?B?S3V3YXFhVm1nWG9CN21MYXFoUmNGWUVkQWZGY3BMR2tES2lOcnhTSU8zczZv?=
 =?utf-8?B?UTNFNCtYcFVHV2d1Y29rMi9YMFBGV0FYWXpuLzBOVjFUQTVNNk9EMFJNNzZ2?=
 =?utf-8?B?bXE2aENvanJzd3JPSmZJcjdocUo2VnZURmFoNTQrV1B4ZWZNT3VaV1lpNlRh?=
 =?utf-8?B?U0tLYkFVVUNka016Y05yN0ZzNHpQREczNVdqNlRlMHpuaURxWkJRNzJra29h?=
 =?utf-8?B?R1NLTWJlbDR3em9VZHlNcUNlMGtMdWZwb0JEcWVKbVduWW1CdnM3RU5zWlBt?=
 =?utf-8?B?OHU2TW56TGFmMTNncU5MZklxQk5vcXczUVpQWlpyMDBsNnNlN1FIZG94bFUr?=
 =?utf-8?B?cllzWUlFVU5lenY2aTZWbUdqenN6OUt4SVpjY1AxUUowZ3ArbDd3N2F1TWhr?=
 =?utf-8?B?a2MxY2hKcUd4dUhLVmZoSVY5RWZWNC8rdlh1ZXFzaktESnhkR3ExOTRrWkNI?=
 =?utf-8?B?WEVQeWpsczQydmduL2NXTm4xWnpHK0ZJWkxaZU1oZEJDQjFTL0lqdFVnK1o5?=
 =?utf-8?B?dDA5OS9IenZJVUUyRExpQkNIKytmblBNc2hVTHluOFF4bTdsaFNnbHVGekt3?=
 =?utf-8?B?Ui9PbWNSNU1qMWYwNGZMUmZVNmQzaThSZVdLbVFnRk1lMTE5V0dTQUVTa0Rl?=
 =?utf-8?B?TkF1MVkyc2VadFJvWGlaQTNIamFraTJndVFTY2tJbzIvLzNZRTVpZjAwSmxK?=
 =?utf-8?B?RFBzYS9yanBoMWowRlRBMnRxVkl6S3htWEdSdE1Pc3pyMWlCN0hNSHpYdnNp?=
 =?utf-8?B?ZkFUd0xhdjNxTG9SRmlUMXh6QXlEdlArL3FKWENlbDF4bVYzM2xHVG1YS0Qx?=
 =?utf-8?B?b0pSQS9INUNVMGR0Wld1aDl2SkE2RXZSd3RIbkk5RHdwdUxhdWpyc1hVVE90?=
 =?utf-8?B?TWxOSGNZZ2pmZ1czRG1JcVhNOWNtVnYzK254am1hMGh1empZaUd1SnVjcFVJ?=
 =?utf-8?B?TkZZREMvbzI4T3JSQUMwTDhQVW1hNjVvbjJnRzduNFFLV21uTUtvZGZzR3hH?=
 =?utf-8?Q?me8yvxb6oT4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXdmQ0xpaHdQeXluYitaaG1LMnN4RWVya3FyRUJnaVo4TTYvK3dBQlltMk11?=
 =?utf-8?B?Y2ZTUTFiQk4zempIZVo4am5yYW9JRnVieWJMU09IdlpRa00vZ1pvTkNZcFJ6?=
 =?utf-8?B?K3p3eStENEhEQ1YwWHhoVzMyeXIyU0JCT2hoRWtIV1dvT0FEUHlDUWZKVVBo?=
 =?utf-8?B?K01Uanoyb25hK2VqZW8ySVc1dDI3Q3lmdFg5d1pLeWFVQk5XakVva2RxTlhh?=
 =?utf-8?B?TlA4cTZ5Ym9CbGF0T3lzdTJIVnI1SnFXaTBlYS9aYTBwRnJwY21jOE96TnFP?=
 =?utf-8?B?WHIzbmoyOHM3cHFUWHFZUVZJRGE0b1loUWRUUlBGcUlVOG5WR2dGWEdPRVJV?=
 =?utf-8?B?akpCdldXVnlFTlBCS0gwb25aRkhsWWRwVmZkcERzSWlWVnUxSi83UUt1YWRK?=
 =?utf-8?B?c25wZGNGdzMrQ2dwL0UxTU5ZbC90cVpmVHF3ODdqZFA0Q1BzdFhJY3JNbFVH?=
 =?utf-8?B?R3J3UDY3Zlo4NzRzZ0xtdVdNcHB1a2pTcVR0TEN4aytOaHZZTU5NSU9rU1Np?=
 =?utf-8?B?NHRoY3R3WEZNQUVzNWlQNTRCYU1FSnlkaGloaUcyeWRabHhPTTlIaVN0VGJx?=
 =?utf-8?B?ZmpzVUVyT2NKemo1anNSWlJEWjBhZUtJRE1KZFpTQ2kxc01KQjBWWUxDaUha?=
 =?utf-8?B?N2VRZkRsZmtzY2tyTit2cFN6enFualZKRDgzcHNYZkx3MGNwZTd2UmI0WDdw?=
 =?utf-8?B?djdTRGpUdnArUExzMXkwbXUxK3dhYkJvMUZKUVlmUVNWa1NiN2tBcGtlcFRB?=
 =?utf-8?B?d1lmNjY3dFNiOG92QVFJdFFvWTBwZWsxbERxeTVKVXZNM1liUG02SHg2UFU4?=
 =?utf-8?B?ejJmWEVJeVpKa1ZYTC8vWmlSY1V4TWQ1Tk4yMldEajVjYTVtU2crU0tsM2k0?=
 =?utf-8?B?SFFpd0V0QVoxdjRYYkZKbzhIMGpRSlFLRXR2cDlXNU94a243TmxGVEw3RjJt?=
 =?utf-8?B?elVmaEhJaXJMQ1JMMmo4L1pxNXhYV1QxRmxGdzJQYXI1U3gzcnNKVmQ0T0t4?=
 =?utf-8?B?OTZLc0xQL3d3bXR3WTVOcjk0M0p5b0VwY3RLZlRaZVhUSWhVelpvaVNyVlNz?=
 =?utf-8?B?b3hOcm1mK1N4QnBldVY4dkRYWGhiVCtxSHZ6RDJTb1RidklzSEJFZTIzL0c3?=
 =?utf-8?B?dzlObjdINXlDZjR5NVdaZ2lpc2daQXIwYytsN09Hd3cyZUpFYlFtRXlHTmxP?=
 =?utf-8?B?OFRvWHB2ano0UHhtMHAzK2FzUVAyMC9CMWEwWFMxaEkvbFppTFU1MVVFM2xS?=
 =?utf-8?B?cThBUG1Ub3BGL0pzU2NSNEpQa1BocG5paVBVRFI3RUc1S3Exdm4rb2xnZENF?=
 =?utf-8?B?UnZyUStmN1pmUlZwd0N4dVpHeUloUXFHRkZnTVdlbG1oL3pZVGpZbWZhUW94?=
 =?utf-8?B?U3hzbkNVY2MvUVFacjNuVmRreEdZTnF6T1poTGFDdjA0S0VNYWdMVFJrUENz?=
 =?utf-8?B?ZUpRbG82dVB6Nm1zZGdteVZaYi95bjlBaFd4UTlTcHN0dWFJSkZtRFhwakNP?=
 =?utf-8?B?NEZ4UXVrR1ZXeHVkc25UV2FwUjhhVmxOclRBTWFiZ081YVAvc1R2Y2YreGcw?=
 =?utf-8?B?S1NvMlk0WGVCaTRodlRCT2pwT3VWSGNIVFZGd3cvc0dmU09Ia3B6d1ZPUDUv?=
 =?utf-8?B?TlI1L3RDbU5xUEVvTzZEVGJQYUdScVp1ZFh2Nk9VZU44aHN2a2sxcU5udmt2?=
 =?utf-8?B?N2hYRlQyZ0lWS0tvUWFCZE4vQWFlSHB4Z3hSVlJOQVRFNi9GN3U1SE80Yi9P?=
 =?utf-8?B?V0pxUDdpOFNkMmhzeGFkcURnRmlMVVVGQXVpaDVzbVVJS2E1aXFFbGNVcHQ1?=
 =?utf-8?B?WGRaeXRhcG9YWjF1SXdycStpU0lFTDJxK0NKL1V5aFVESlFvQmJ5SHQ0eEUw?=
 =?utf-8?B?VXd2aWp5ZjNHM1dKeGg3d29JbTJLRlhFRjh3Zm9LSTlkY2l0NitPTzVKbDdV?=
 =?utf-8?B?Ym5rRWRTaExGbkJTSGRaenh2NFNhMUF0WFB3MkQ2bCtUNFFTTHNOVmJhUTJE?=
 =?utf-8?B?NWs5RTBHTlpUemRKWks3NTFNZEE4cVJheTNMSzZLZ2ltQ0Z1TFZLRlEwZDBz?=
 =?utf-8?B?VUYxTXNtMmpWKzhHOFNkWVg5SGUyRi9lakgzdnp6Tm5kcFBPK25pMU9SbE9H?=
 =?utf-8?Q?Gl3zr+YYJ8V621dvfzMjHXFSo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7abe996d-1350-48c6-f4f5-08ddacfd9988
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 17:45:36.0435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gifjhwOyf3wlwi1YAdMa2spU6yCqqAEGRSrfuQ8bFNLOqktqlUv7m9nLdNJ1bj6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811
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

On 6/16/25 15:47, Alex Deucher wrote:
> On Mon, Jun 16, 2025 at 8:16 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 6/13/25 23:47, Alex Deucher wrote:
>>> Use the amdgpu fence container so we can store additional
>>> data in the fence.  This also fixes the start_time handling
>>> for MCBP since we were casting the fence to an amdgpu_fence
>>> and it wasn't.
>>>
>>> Fixes: 3f4c175d62d8 ("drm/amdgpu: MCBP based on DRM scheduler (v9)")
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 30 +++++----------------
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 12 ++++-----
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    | 16 +++++++++++
>>>  6 files changed, 32 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index 8e626f50b362e..f81608330a3d0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -1902,7 +1902,7 @@ static void amdgpu_ib_preempt_mark_partial_job(struct amdgpu_ring *ring)
>>>                       continue;
>>>               }
>>>               job = to_amdgpu_job(s_job);
>>> -             if (preempted && (&job->hw_fence) == fence)
>>> +             if (preempted && (&job->hw_fence.base) == fence)
>>>                       /* mark the job as preempted */
>>>                       job->preemption_status |= AMDGPU_IB_PREEMPTED;
>>>       }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 00174437b01ec..4893f834f4fd4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -6397,7 +6397,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>>        *
>>>        * job->base holds a reference to parent fence
>>>        */
>>> -     if (job && dma_fence_is_signaled(&job->hw_fence)) {
>>> +     if (job && dma_fence_is_signaled(&job->hw_fence.base)) {
>>>               job_signaled = true;
>>>               dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
>>>               goto skip_hw_reset;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> index 2f24a6aa13bf6..569e0e5373927 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> @@ -41,22 +41,6 @@
>>>  #include "amdgpu_trace.h"
>>>  #include "amdgpu_reset.h"
>>>
>>> -/*
>>> - * Fences mark an event in the GPUs pipeline and are used
>>> - * for GPU/CPU synchronization.  When the fence is written,
>>> - * it is expected that all buffers associated with that fence
>>> - * are no longer in use by the associated ring on the GPU and
>>> - * that the relevant GPU caches have been flushed.
>>> - */
>>> -
>>> -struct amdgpu_fence {
>>> -     struct dma_fence base;
>>> -
>>> -     /* RB, DMA, etc. */
>>> -     struct amdgpu_ring              *ring;
>>> -     ktime_t                         start_timestamp;
>>> -};
>>> -
>>>  static struct kmem_cache *amdgpu_fence_slab;
>>>
>>>  int amdgpu_fence_slab_init(void)
>>> @@ -151,12 +135,12 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
>>>               am_fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_ATOMIC);
>>>               if (am_fence == NULL)
>>>                       return -ENOMEM;
>>> -             fence = &am_fence->base;
>>> -             am_fence->ring = ring;
>>>       } else {
>>>               /* take use of job-embedded fence */
>>> -             fence = &job->hw_fence;
>>> +             am_fence = &job->hw_fence;
>>>       }
>>> +     fence = &am_fence->base;
>>> +     am_fence->ring = ring;
>>
>> I would rather completely drop the job from the parameters and the general fence allocation here.
>>
>> Instead we should just provide afence as input parameter and submit that one.
>>
>> This should make sure that we don't run into such issues again.
> 
> How about doing that as a follow on patch?  It looks like that will be
> a much bigger patch for a stable bug fix.  I think we can clean up a
> lot of stuff in amdgpu_fence.c with that change.

Works for me. I would also suggest to remove the kmem_cache_alloc() and just use kmalloc for the rare cases where we need an independent fence.

Additional to that the ring and start_time member looks suspicious. We should not have that inside the fence in the first place.

Regards,
Christian.

> 
> Alex
> 
>>
>> Apart from that looks good to me,
>> Christian.
>>
>>>
>>>       seq = ++ring->fence_drv.sync_seq;
>>>       if (job && job->job_run_counter) {
>>> @@ -718,7 +702,7 @@ void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
>>>                        * it right here or we won't be able to track them in fence_drv
>>>                        * and they will remain unsignaled during sa_bo free.
>>>                        */
>>> -                     job = container_of(old, struct amdgpu_job, hw_fence);
>>> +                     job = container_of(old, struct amdgpu_job, hw_fence.base);
>>>                       if (!job->base.s_fence && !dma_fence_is_signaled(old))
>>>                               dma_fence_signal(old);
>>>                       RCU_INIT_POINTER(*ptr, NULL);
>>> @@ -780,7 +764,7 @@ static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
>>>
>>>  static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *f)
>>>  {
>>> -     struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence);
>>> +     struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
>>>
>>>       return (const char *)to_amdgpu_ring(job->base.sched)->name;
>>>  }
>>> @@ -810,7 +794,7 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
>>>   */
>>>  static bool amdgpu_job_fence_enable_signaling(struct dma_fence *f)
>>>  {
>>> -     struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence);
>>> +     struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
>>>
>>>       if (!timer_pending(&to_amdgpu_ring(job->base.sched)->fence_drv.fallback_timer))
>>>               amdgpu_fence_schedule_fallback(to_amdgpu_ring(job->base.sched));
>>> @@ -845,7 +829,7 @@ static void amdgpu_job_fence_free(struct rcu_head *rcu)
>>>       struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
>>>
>>>       /* free job if fence has a parent job */
>>> -     kfree(container_of(f, struct amdgpu_job, hw_fence));
>>> +     kfree(container_of(f, struct amdgpu_job, hw_fence.base));
>>>  }
>>>
>>>  /**
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> index acb21fc8b3ce5..ddb9d3269357c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> @@ -272,8 +272,8 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
>>>       /* Check if any fences where initialized */
>>>       if (job->base.s_fence && job->base.s_fence->finished.ops)
>>>               f = &job->base.s_fence->finished;
>>> -     else if (job->hw_fence.ops)
>>> -             f = &job->hw_fence;
>>> +     else if (job->hw_fence.base.ops)
>>> +             f = &job->hw_fence.base;
>>>       else
>>>               f = NULL;
>>>
>>> @@ -290,10 +290,10 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>>>       amdgpu_sync_free(&job->explicit_sync);
>>>
>>>       /* only put the hw fence if has embedded fence */
>>> -     if (!job->hw_fence.ops)
>>> +     if (!job->hw_fence.base.ops)
>>>               kfree(job);
>>>       else
>>> -             dma_fence_put(&job->hw_fence);
>>> +             dma_fence_put(&job->hw_fence.base);
>>>  }
>>>
>>>  void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
>>> @@ -322,10 +322,10 @@ void amdgpu_job_free(struct amdgpu_job *job)
>>>       if (job->gang_submit != &job->base.s_fence->scheduled)
>>>               dma_fence_put(job->gang_submit);
>>>
>>> -     if (!job->hw_fence.ops)
>>> +     if (!job->hw_fence.base.ops)
>>>               kfree(job);
>>>       else
>>> -             dma_fence_put(&job->hw_fence);
>>> +             dma_fence_put(&job->hw_fence.base);
>>>  }
>>>
>>>  struct dma_fence *amdgpu_job_submit(struct amdgpu_job *job)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> index f2c049129661f..931fed8892cc1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> @@ -48,7 +48,7 @@ struct amdgpu_job {
>>>       struct drm_sched_job    base;
>>>       struct amdgpu_vm        *vm;
>>>       struct amdgpu_sync      explicit_sync;
>>> -     struct dma_fence        hw_fence;
>>> +     struct amdgpu_fence     hw_fence;
>>>       struct dma_fence        *gang_submit;
>>>       uint32_t                preamble_status;
>>>       uint32_t                preemption_status;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> index b95b471107692..e1f25218943a4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> @@ -127,6 +127,22 @@ struct amdgpu_fence_driver {
>>>       struct dma_fence                **fences;
>>>  };
>>>
>>> +/*
>>> + * Fences mark an event in the GPUs pipeline and are used
>>> + * for GPU/CPU synchronization.  When the fence is written,
>>> + * it is expected that all buffers associated with that fence
>>> + * are no longer in use by the associated ring on the GPU and
>>> + * that the relevant GPU caches have been flushed.
>>> + */
>>> +
>>> +struct amdgpu_fence {
>>> +     struct dma_fence base;
>>> +
>>> +     /* RB, DMA, etc. */
>>> +     struct amdgpu_ring              *ring;
>>> +     ktime_t                         start_timestamp;
>>> +};
>>> +
>>>  extern const struct drm_sched_backend_ops amdgpu_sched_ops;
>>>
>>>  void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
>>

