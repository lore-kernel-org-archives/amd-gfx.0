Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0BAC71136
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 09:43:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88BB710E58F;
	Tue, 17 Jun 2025 09:43:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KviuSxjF";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46EB310E58F
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 09:42:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFsXM6UxG7+odo11V1Ru14Ticx6Vczja4CC+0Zgb8qEOFZgjZvnXHmwWPD2zLVBYQqEYfKppBnrbDSDNdUKmu32dY+FD6qL/Ifw+u27c5Yje2j9C8Qqj80tptR6DDLyNO3Lqm4wR1hlf2K4ckRG0AQPtCz9N0xt/OY/vrAOA68KraCK+KDiD/R8oQ+n8hensohnXdztL5ge36zNlwZLPp7/LSIvVFcTod446fNR858XvoEW7Yk698/N5ox2gLhYN6i3dvk7vQwaunyVnfW9ta6Q4XXPzGRny5kbQEU9Um7i0thnOyj1KS5+Prgy93+FskO2wyFxY5R+p4vzoFbl3LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKacahPLxS4vRdKNm8NmJ9u6JFtVl147OIeflEivaDo=;
 b=hdTMTlJyo7CJA1X9xZmkiIWeSWb1Ih48RR+auzjGZZSpein7qWOPcgHRE+jlMmhMS0m06dhfPg05XtOC7/dY/X1lnmTgENrqCYm/30w/0Vjsalh4iMbbe1SjF1CoPN76tIRwgZnHD7/QngEt4citjbrAzkX9aLeSVQxov+/BwRl0my5qFsWz/KQzu/DlJG+vBpLaTBJJIo+AFowWx7VhBEBOXOWWg5zKRInXJYaSQ9D1oxeChzqJyXXzcvGMDd1qpx/GPj5joG3GQe92iCGO0Npbw+lKHh7KNTnAKiyNkzY7LT1XQy7xvMn9lBzIdDpbhpvTsfOvjoXpkZLMHsgMDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKacahPLxS4vRdKNm8NmJ9u6JFtVl147OIeflEivaDo=;
 b=KviuSxjFAi+K+/j7ABW9yWMGnnVbzvbqdQrX7OMhhadySocHunDD1dgu8NDq1cCqAM0TSypeH5q36zes3/O2GKxN9Cup63Gj/69DLf+6w+rmzQm2ZDFs/wq/GRLAR2YtXhmLWb+n5Yj9tbsXOy8GG7xHeFjJ8ojWe9BIMI5P65U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9230.namprd12.prod.outlook.com (2603:10b6:408:186::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 09:42:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Tue, 17 Jun 2025
 09:42:56 +0000
Message-ID: <22edc038-9b73-4d14-a296-e257db5f75b8@amd.com>
Date: Tue, 17 Jun 2025 11:42:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/36] drm/amdgpu: switch job hw_fence to amdgpu_fence
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 sasundar@amd.com
References: <20250617030815.5785-1-alexander.deucher@amd.com>
 <20250617030815.5785-2-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250617030815.5785-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0095.namprd03.prod.outlook.com
 (2603:10b6:208:32a::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9230:EE_
X-MS-Office365-Filtering-Correlation-Id: 704ba33e-2c45-461c-3200-08ddad835681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUdWaVljTHBlSmpucTJMdUluZk15empudVo1SzF1dVNjYXpKS2tqVEJ0blgz?=
 =?utf-8?B?dmhDUjZRVThSU0VkQkg2MU9wTE5OT1Z2a3Arc0kzMU1FcEdCK3U0cVVLcnh1?=
 =?utf-8?B?c3FOQ1BOR2dLem45OFhjUUNESC9XRG41TkpKSDJGb1laYTQxb24xdmtJTkQ1?=
 =?utf-8?B?eE9EWnNkdHIvWXVoUCtuY2FENWgyM1IxUlc5dmlkSE5GYXdBM2pWaXRJVXVQ?=
 =?utf-8?B?b01vWXNIS1F1TjU0OTRrT2w2VEhFd054VEZ1TGxzVkwwakNoS3kwelhwUFht?=
 =?utf-8?B?eVJBN0t6U2VUUkJZNFFtT1V3MC9EUFRWanVGbzJzMXdZYXBYYUNORzJDdHVx?=
 =?utf-8?B?MFE1U1AyZW1UaDNTak9yWGVKRG4zQ25CZ1krYmU4RWluRFNYQUtOVi9rRUt1?=
 =?utf-8?B?MTlCRjEzVVVYTjNNSEl3VUVEVTZBYW5weUdHWWc4YXV0TUhTQW9iMXhxM3Bx?=
 =?utf-8?B?SnIyRkgwL0ZSUDhYVi80b0JyY1pxR2Y4VUFLOGRTVXF6V3JNdGt4Qk05RER2?=
 =?utf-8?B?N2hsRm91aGIzNTFsbFh2UlcvNGh2c3hBS1JOQ1ZueThLR0RVMGFnaXp6SEtP?=
 =?utf-8?B?MS9ZT0lMOVJrUE51T0ZjdU1hVUVvQVgvRytZcGE5VDVPR2dxdDhRSUxHcENm?=
 =?utf-8?B?dDhjQXdSNFNtZHUyQlFTM2VPeFpGSjZBZTNDUDg5SHhJVFBqT0gxYnBIWUg5?=
 =?utf-8?B?VjFOY3V4Q1ZTc0xTc1greUNhNXJqZDI1R0E5amFsanhXV3hBbkEzL25RV0dv?=
 =?utf-8?B?SXlyQjEvengyUVV5VmpOeStyKzdoek41NjQ1aEdURGxXZXdPMUMwam9UV1R1?=
 =?utf-8?B?TDdMUGh6c1ZubG8zSTFCQVQ3azZ0NzZZMnhGSXNTSXp5Z21CVFdWVnBZdVJB?=
 =?utf-8?B?MFpnWlFNaDFDRHBjNFRZb3h0bDltRm9JK0pld2diZVlyRXNuaWdYU09EQ0p6?=
 =?utf-8?B?RWF0NXg2NWpUcVhLZE5RUmt5MG9BTUIxK1VpVnp0REZkVGh6UVZKZVlWWHJJ?=
 =?utf-8?B?ZkhoZ3E1SzBEM2IrWVY2Q05TbmZpbWVvNm96bW9Ta0RWeDU5c0Eyd1UyaVcy?=
 =?utf-8?B?TFhCaERzK1hMd1lLUUVyVVBRUGJ1cTNrME5tVEp1UkxHQ1Rsb1ZGTGlKUUww?=
 =?utf-8?B?MktjWER6OElmVG5FeWlKVU1iNWRFaEJ3MXVRclJKa1hDWjZ3eGdITlNnb0pG?=
 =?utf-8?B?ak9VdE1xWWZoRzBxMVZYaDlvdTF0RVdPRi9iMXRqNGZkQUdVRCtVcmFFWTI4?=
 =?utf-8?B?a001VHRJbFhJNmJKK3cvaTNMQzAzRWh0MFV1UUlnZS9rTHNWaWxib3gyU0U3?=
 =?utf-8?B?R2pqNG9pczVqaURVRkt0M0g0aEVzek1hY01Tb3JJZSttalZaKzdyWU50MXNv?=
 =?utf-8?B?dDZqbUUzbUs3Q2ZsM21tSEpLQ1dENXREUlBhSkFINFJKTFdwRW9nVjRVeTdl?=
 =?utf-8?B?QUJ4N2VYSi9GWlRGOVcrUmFxd3EvNjhUN2dwbVMycG9yNHcyMUQ2LzVrNlUy?=
 =?utf-8?B?d29nTGxNUzZJQTE5QjgyWjQzRWdUYVRGRjFrVFg4d3RKaGlEZkNaMkMzUkJF?=
 =?utf-8?B?Ni9ReHU4RmUxaGNNL2oxalk5aVV0V0dEY2lXaE5LTXZ3Wjl1b0szaFo4bGN6?=
 =?utf-8?B?RUliWFM3YXNEUlBVNjNvQ3EwU2wvZDBrQXdQOWZ4WHAvL3RySytESzN0ampU?=
 =?utf-8?B?YU9paWFPN1FHZmhwVE56UGFQMGluY1Z2ZUpwNjFaWW5RZEk3eTB1S3dBaWpR?=
 =?utf-8?B?ZGhOVHVtNWQwcHhJYTRpa21YcGM5VDJPSVRreklCZ0YvZ29ocjRkODh2ME10?=
 =?utf-8?B?dE9HaEE2TmtyZzVvRHlxbkhXL3hvWFNUcEh5UEowNnI5OFdkdHpWdWdKd1hU?=
 =?utf-8?B?THJvRjV6NG9XV2hQU3RoWTMveHBsY0JyQXRqREU0Z0tkcWd6Z1FqVVByQ1hy?=
 =?utf-8?Q?UOsTt1hxnr4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlBSYWQyQjl6UGtLMjBxWEZCODA4NlV0OFF1dlpCaWlWUmpZQ0QxcUpKZVRh?=
 =?utf-8?B?aC9ERkM5blljRnVmYXRnTVo3Z1BLVlRXQkc4elYwV285RjVaaUVTaFFEcjhB?=
 =?utf-8?B?bDk0UGhIR25peWQwbDZsR1JuNlhKMTE3TEEzSDRMaGp1K3pRYWd3eFd4Q1ND?=
 =?utf-8?B?ZFR1MVpzaEozckFrV1d1VzNCeHVYcjkvU2h5R1lFZ3Z4Y2ZGUzVOZW5ZVHNZ?=
 =?utf-8?B?ZDNRZnJ4MHRMeVhoU0RDVG5jcytUR2hPNGZBajdwdDY4M3VKL1lqNFNtcVVN?=
 =?utf-8?B?YXBCYjFGWUxSU0VhUjJlMElpRkpFRDNUT1krdHVQa3VhWFZyeXFIalM1V2V1?=
 =?utf-8?B?NVhxWVd5dzJiSGtQbndWeTYwWmlid2Y5NGxBejhBNmd0N05zU0hsUGdKVXJx?=
 =?utf-8?B?YWMxRVczV3hFK3RrU2xkazlaNUZHOGRRNEhyZHZjZmVQWUI2WDNDSFdUVFZW?=
 =?utf-8?B?QXNRMVl2cjZxMHhMdFZBZ2pZREQrWFBlWm9ScG9Ba09qUmw1U3lOLzFxNWd3?=
 =?utf-8?B?STQ2ZXJYTFRKZkZ2bVdGWVZYZVkrenEvYWJPbDcxcGt1WTljbnJRZ0pKSW4r?=
 =?utf-8?B?RnhvSnV0Q2dEelorSVBOdFZxZFQrNVdNYllvM1k5ckgvb3ZITHg0T1NvK09i?=
 =?utf-8?B?UHB1NGJqRkREaTVzZWlEb2J4Z0dIK0E2WEFNdjdmdDR2bzNzNjkwUk1OenZ4?=
 =?utf-8?B?QjR2eW16QnFtbmRHaUhwSHQvd2srRUR5N0RLN21UNE9RQVZ1NnlrS2pDODBZ?=
 =?utf-8?B?VFRiblV3d0UwTm5KZnRnTHhNV2xDaE9Mb0IvQlNPaUJEekRMY2JtNmxXMFRB?=
 =?utf-8?B?c2lVNXJwVzNUbWRBckl6dHZwc1BDOWdOZi93WS9qOGI4YSt4dnp2dTZRTG9v?=
 =?utf-8?B?QndZa29PN3dpNmt4QWN0NWwwSy9MSVQwd1ZJTHRuYXhhYVJNdlE0TG9oYnlV?=
 =?utf-8?B?MXIvcEtLN2U4KzUrRVMxWmJaeXdZaDRXcXE0NW1FM3FmYXBEUi9Bd1V1UHgv?=
 =?utf-8?B?MmRaSktuYVRkRWlnMWx3TisxMXJrWnhIckxGTVdocXN5L0ZlVXIwak1RQ3V5?=
 =?utf-8?B?L0dXSHZvd2lQVGtWcmxvQUVwd0VXSS9JVEY1UWRadGdCbm5YcDlZZG1CWU13?=
 =?utf-8?B?Z05HdTJzK1hxQTZ3UVUwZ3RDbTdNaEoyZkxCL1hCa1N6dHEvVG1xMUlXWmRl?=
 =?utf-8?B?ekJkdEFVaTZvQ1YycjVtTDVjZUw2MjBYTHZ4QmQrZjFYOHh5NUNyMm83MWkw?=
 =?utf-8?B?S1EyOG1RY2lkdWkvOTk5YkQ4YWNNaDFCdDV4RWJLNFFZMDgrMzZid1Y5aTgx?=
 =?utf-8?B?NmRJb2ZHcGEyUE1vYWxENWlETkpya2NLRFlUOEJhaGZUaXlRbXRnWVB2TnRK?=
 =?utf-8?B?NGt5Slp3djM2eHVhdWEvNmp0WlJsSHI1QXJ1c3pxbXZEdHRSR2d2eFBWa0t0?=
 =?utf-8?B?a1plT1U0Y29QemJXU05QVS8zZXJITzJHaUtSUVFmNkZQWThBSjBJREZLaUlY?=
 =?utf-8?B?QUVQMEhKU2ZOMlpybjBLemYwVTMxN1pyQ0NQZmVib0ZGTGNEOURTYVFKVjNL?=
 =?utf-8?B?dGZTTTFCd3I0Tmo0RVYrVHU1U0F3N1JVbWVJcmxjSEpKSGVoaU05T2EybHZu?=
 =?utf-8?B?S2x3WXBmN1YyQlM2dmdPL1BxR2RZd3RDWHJyZGtoZlJjMjJkS21vZW5CWlJU?=
 =?utf-8?B?QjR0NXA0U0N1M3pMRm04MjhaaHVPOEkzN1lyRjY3UklaVjIzWi8yVlJEV1lh?=
 =?utf-8?B?VjhPNVo3NmdZazZ6Ync5SlZhR0Vsb2dVMjFzUTZVaFdFbG5ETVh0NjZYMnN6?=
 =?utf-8?B?YlB6WFo3MUFsRUZXSURDYjh6d1oveWNDVUFLbm0zNmY0NDY2dzV1T0U2SVdG?=
 =?utf-8?B?R2JsOGdnRkJpeHhWZjhTSW96ZGZldk5PZERhWUZkQU9EZ0swMUlaRjRuRnc2?=
 =?utf-8?B?a0JOZkUyLzJMemx2OGp2dERNMjl1aVJZMW9qOFN4UXNtZ1JIc24xMVpuUkxV?=
 =?utf-8?B?RXVEdUk0QTBJR1FscVc2QzVHVXFGM3FoZjhlMDBKUi9HUVp6MGhOL0g4TWx5?=
 =?utf-8?B?Q0VNODJNOXdmSEpzMUlwbzhDOXcyWkZWS1J0eitsWVhUZW05dkROd1RiUExl?=
 =?utf-8?Q?2neTVecq2TAcye4Y86lWtmN79?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 704ba33e-2c45-461c-3200-08ddad835681
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 09:42:56.2425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ew8Mt+0BZTbsNqcM1hl09gB2bue4aQtm440mgH7sG2hheeZCDlssSdPb67Q0mDb0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9230
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

On 6/17/25 05:07, Alex Deucher wrote:
> Use the amdgpu fence container so we can store additional
> data in the fence.  This also fixes the start_time handling
> for MCBP since we were casting the fence to an amdgpu_fence
> and it wasn't.
> 
> Fixes: 3f4c175d62d8 ("drm/amdgpu: MCBP based on DRM scheduler (v9)")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

CC: stable?
Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 30 +++++----------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 12 ++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    | 16 +++++++++++
>  6 files changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 8e626f50b362e..f81608330a3d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1902,7 +1902,7 @@ static void amdgpu_ib_preempt_mark_partial_job(struct amdgpu_ring *ring)
>  			continue;
>  		}
>  		job = to_amdgpu_job(s_job);
> -		if (preempted && (&job->hw_fence) == fence)
> +		if (preempted && (&job->hw_fence.base) == fence)
>  			/* mark the job as preempted */
>  			job->preemption_status |= AMDGPU_IB_PREEMPTED;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index f134394047603..13070211dc69c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6427,7 +6427,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  	 *
>  	 * job->base holds a reference to parent fence
>  	 */
> -	if (job && dma_fence_is_signaled(&job->hw_fence)) {
> +	if (job && dma_fence_is_signaled(&job->hw_fence.base)) {
>  		job_signaled = true;
>  		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
>  		goto skip_hw_reset;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 2f24a6aa13bf6..569e0e5373927 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -41,22 +41,6 @@
>  #include "amdgpu_trace.h"
>  #include "amdgpu_reset.h"
>  
> -/*
> - * Fences mark an event in the GPUs pipeline and are used
> - * for GPU/CPU synchronization.  When the fence is written,
> - * it is expected that all buffers associated with that fence
> - * are no longer in use by the associated ring on the GPU and
> - * that the relevant GPU caches have been flushed.
> - */
> -
> -struct amdgpu_fence {
> -	struct dma_fence base;
> -
> -	/* RB, DMA, etc. */
> -	struct amdgpu_ring		*ring;
> -	ktime_t				start_timestamp;
> -};
> -
>  static struct kmem_cache *amdgpu_fence_slab;
>  
>  int amdgpu_fence_slab_init(void)
> @@ -151,12 +135,12 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
>  		am_fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_ATOMIC);
>  		if (am_fence == NULL)
>  			return -ENOMEM;
> -		fence = &am_fence->base;
> -		am_fence->ring = ring;
>  	} else {
>  		/* take use of job-embedded fence */
> -		fence = &job->hw_fence;
> +		am_fence = &job->hw_fence;
>  	}
> +	fence = &am_fence->base;
> +	am_fence->ring = ring;
>  
>  	seq = ++ring->fence_drv.sync_seq;
>  	if (job && job->job_run_counter) {
> @@ -718,7 +702,7 @@ void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
>  			 * it right here or we won't be able to track them in fence_drv
>  			 * and they will remain unsignaled during sa_bo free.
>  			 */
> -			job = container_of(old, struct amdgpu_job, hw_fence);
> +			job = container_of(old, struct amdgpu_job, hw_fence.base);
>  			if (!job->base.s_fence && !dma_fence_is_signaled(old))
>  				dma_fence_signal(old);
>  			RCU_INIT_POINTER(*ptr, NULL);
> @@ -780,7 +764,7 @@ static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
>  
>  static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *f)
>  {
> -	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence);
> +	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
>  
>  	return (const char *)to_amdgpu_ring(job->base.sched)->name;
>  }
> @@ -810,7 +794,7 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
>   */
>  static bool amdgpu_job_fence_enable_signaling(struct dma_fence *f)
>  {
> -	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence);
> +	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
>  
>  	if (!timer_pending(&to_amdgpu_ring(job->base.sched)->fence_drv.fallback_timer))
>  		amdgpu_fence_schedule_fallback(to_amdgpu_ring(job->base.sched));
> @@ -845,7 +829,7 @@ static void amdgpu_job_fence_free(struct rcu_head *rcu)
>  	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
>  
>  	/* free job if fence has a parent job */
> -	kfree(container_of(f, struct amdgpu_job, hw_fence));
> +	kfree(container_of(f, struct amdgpu_job, hw_fence.base));
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index acb21fc8b3ce5..ddb9d3269357c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -272,8 +272,8 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
>  	/* Check if any fences where initialized */
>  	if (job->base.s_fence && job->base.s_fence->finished.ops)
>  		f = &job->base.s_fence->finished;
> -	else if (job->hw_fence.ops)
> -		f = &job->hw_fence;
> +	else if (job->hw_fence.base.ops)
> +		f = &job->hw_fence.base;
>  	else
>  		f = NULL;
>  
> @@ -290,10 +290,10 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>  	amdgpu_sync_free(&job->explicit_sync);
>  
>  	/* only put the hw fence if has embedded fence */
> -	if (!job->hw_fence.ops)
> +	if (!job->hw_fence.base.ops)
>  		kfree(job);
>  	else
> -		dma_fence_put(&job->hw_fence);
> +		dma_fence_put(&job->hw_fence.base);
>  }
>  
>  void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
> @@ -322,10 +322,10 @@ void amdgpu_job_free(struct amdgpu_job *job)
>  	if (job->gang_submit != &job->base.s_fence->scheduled)
>  		dma_fence_put(job->gang_submit);
>  
> -	if (!job->hw_fence.ops)
> +	if (!job->hw_fence.base.ops)
>  		kfree(job);
>  	else
> -		dma_fence_put(&job->hw_fence);
> +		dma_fence_put(&job->hw_fence.base);
>  }
>  
>  struct dma_fence *amdgpu_job_submit(struct amdgpu_job *job)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index f2c049129661f..931fed8892cc1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -48,7 +48,7 @@ struct amdgpu_job {
>  	struct drm_sched_job    base;
>  	struct amdgpu_vm	*vm;
>  	struct amdgpu_sync	explicit_sync;
> -	struct dma_fence	hw_fence;
> +	struct amdgpu_fence	hw_fence;
>  	struct dma_fence	*gang_submit;
>  	uint32_t		preamble_status;
>  	uint32_t                preemption_status;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index b95b471107692..e1f25218943a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -127,6 +127,22 @@ struct amdgpu_fence_driver {
>  	struct dma_fence		**fences;
>  };
>  
> +/*
> + * Fences mark an event in the GPUs pipeline and are used
> + * for GPU/CPU synchronization.  When the fence is written,
> + * it is expected that all buffers associated with that fence
> + * are no longer in use by the associated ring on the GPU and
> + * that the relevant GPU caches have been flushed.
> + */
> +
> +struct amdgpu_fence {
> +	struct dma_fence base;
> +
> +	/* RB, DMA, etc. */
> +	struct amdgpu_ring		*ring;
> +	ktime_t				start_timestamp;
> +};
> +
>  extern const struct drm_sched_backend_ops amdgpu_sched_ops;
>  
>  void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);

