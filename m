Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C109BD75BCC
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 07:47:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68D3710E890;
	Thu, 21 Nov 2024 07:47:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="46nEfxUv";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2966110E890
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 07:47:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGsJR1GPNWU7buew5ffWKwOQX56B1M2W7WBn7mQKz7g0VznRx6gDH/1QmnZjBVKdik6cwDUMLXXjl5aF/XJh9jyStYHu/zShsfe7jp/3EdAcjWpyLG6CkQtY0HcJoKeB+TDoNTzAi+YGHKk677eoz26wA2wP+TbfHF1gFxzGzdEU7cz9JXq+kHFmgHol7HKxWIJ/lcRoKG8lGwZ9PiNabSqBh6DzOr/YLE83i5mzTon4Qi4QwiXPVvf7QDQJ+be631yUV1PfFatQjqFKoTlFTSY7kINCfs4bo16D35xVSTndjjfqz0iKfGTNDuC8/czW9cDkNv7wav8gvfNKwIvlBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpyURWYr+Brukk9d6tv1y7LOpTIMzdqzwZ9FwmUZdKI=;
 b=Q+Ao2s21WJgxf9ySnKnuFEC2lf8bh8/4x8ieq7oQeDEtI9Y7dNEolK/M7EexDVgWrasjPss2/Ac2D0MG/DF8tIQmtYbRtikAmoCVStBFgSkIrwdVFezVonIHn9ES/2oVi5POau9Yjmfj0ZZNBCyItLq46j74eEUrJW0FduuGKazs2pCqr+ZdLFzVoSFGwjfoA+6+tE7OaiVC9TWf9FVzIflbnrJmJE7Hr8hDrF3zg1LaivJJmw+8h0V4aBrO26KIjOQsGgrZAFOqqiTUIqmjdzSgWGfykt5uuXr9ZmQ5csOR10MwyFLtKEY0FNivf8omAmECQdJ/aARLvyxY1ek4BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpyURWYr+Brukk9d6tv1y7LOpTIMzdqzwZ9FwmUZdKI=;
 b=46nEfxUvMSzDIYsF+YPBI0QuDKd6g7u5hV3eF3VKCC0HUfExs/rOSPnbpo7n9G2qMBGBmY6j6DbHzmqEvcQ1eX2hyLiuLzjl46qMGmdmyv7a06GdS0IvxqCgBAWNd0F37hFg1UVg9/+eNcUS+Z4j/Y4goMoqc7Iol6ul0PwY7eM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB8444.namprd12.prod.outlook.com (2603:10b6:8:128::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.23; Thu, 21 Nov 2024 07:47:54 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8182.013; Thu, 21 Nov 2024
 07:47:54 +0000
Message-ID: <33453e2d-cdef-499c-89e1-e670054bc578@amd.com>
Date: Thu, 21 Nov 2024 13:17:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] drm/amdgpu/jpeg: cancel the jpeg worker
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241113214453.17081-1-alexander.deucher@amd.com>
 <20241113214453.17081-5-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241113214453.17081-5-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0123.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::8) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: e588f6a1-840e-4952-9632-08dd0a00ced2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDYrNFRJbC9JSkhyL2NVOFE5dzZoWUtkM3UvUUtrYzM3dnFMcjA3WHpHM0dz?=
 =?utf-8?B?TjVzY01teGNIMnU0c3dJY2daQkk2YTJOSlZDMElIWnZucDk3d2NjaGxSMUU3?=
 =?utf-8?B?enR4K0Jib3I5TVNRYVFRZk5ERldGd3JLL1dtamo3Z1FnWXZrdE5DWnNSUTM4?=
 =?utf-8?B?NUNwQ0g2bHl1RDE0U0JSZEJyMEtVVmt2REdPTGhibnV0SFo3blg5bk9ab29E?=
 =?utf-8?B?K2ZMajg3Y2dmYVZYRHBCQTRESFgzcTlHNjFNd3NKTGExODVOS2hCU2dZSFA5?=
 =?utf-8?B?VitDdko3amFuRml6bmkxdzlDZGJtYXJDVXZyUUxVRnhxUVpBU2hCcUoycjVE?=
 =?utf-8?B?SnBlK1BmMU5WWWhtZlJZSkQ5WlYxa0oxOGd6SWVmMFRVeFhNVFVweTNaeUQw?=
 =?utf-8?B?K0dqL1FwbkRFalpsR0pFVXVLY0pCSThsWVEzTytYck1QaVNWU3huUEFTVHht?=
 =?utf-8?B?RHhrd3hXSHdOWDJIbS9hcmZLNWpnSGZsbVkxdFVWK2ZxdWMyOTNIYjY3Vjc4?=
 =?utf-8?B?Y2hOKy9WN0t3ZmRWaVc4MEVZclFEb2pzTnJHQ3RrRzNGOXlpLzRaTnNuM1Fi?=
 =?utf-8?B?TStzaHBOYUVDY28xeS9VSWFuU1BOVFh1aDIzZEp3bFlBZWg5NUxNNlVMOHJz?=
 =?utf-8?B?Qm0xZmtWNWx6cGpPYndMY0ZQYkVpODYwV0QwVVNLZ3Y1ZVdXSFpxM1pkZ01x?=
 =?utf-8?B?SUk2U1JQaVRqU0NuanBvRUowaFFWeFJxRm41M2tHUDlobE5XWjRpNmJjZHFz?=
 =?utf-8?B?KzhOT0NaWWtmSzZvWVhYWnJsRWcvYVlML0VNRVNsLzJzdUgxdTBRRENibFZJ?=
 =?utf-8?B?ZmxOUks2aS9PTnR5ZmJPN2JvTUttdFIrQzVibUlIbDNBV3FhVldpZDhPUVZH?=
 =?utf-8?B?OG1abnZJY0RIeXVjQWxuZmV4VDk4R3FNSlZIM3VseXRHR1FzcUw4cjZyOHUw?=
 =?utf-8?B?aGNyUlQ2cVo5dUhiRkhPWGN2aVNZVlBTMmlkM2wraG9lRDQzNWMycjZDRmpP?=
 =?utf-8?B?dDlPeHgrWFNqQlRTSk5iQ2FjUXJmajFoNlRkeDlHNlJDb2JLS3JLcU1BYk00?=
 =?utf-8?B?U3ZVandSVk1PRzc1RnVPL2FEWXpPSnhSV090SENzUnNqL3I1QTlISlFlaWRy?=
 =?utf-8?B?cDdWTTF0UWRDNXV3RnZTeWIyUXJlaTBMS1N6ODdiMU1UNVBkWlhZOHoxVERF?=
 =?utf-8?B?alFJYmFBVDVkNWpoQ0RnbWwrZkpodkhLRFZjbzluVFQvSEkxbENkOFM1K3ZB?=
 =?utf-8?B?UlJjSmFjVHF3aVFVV1BkeEVVdnFwMVAyM29uRHl5akJkeU9CZmtOSWZ5MHlT?=
 =?utf-8?B?SGxBZ0hhM3NUYlRFOXlKcUUxa1hpRUhrSFo2VVRkV2RDR3U0NFZJbUE5eU5B?=
 =?utf-8?B?SEcvNFFPNDZNd1BnditGMWd6R09YVDVBbEt4M2RDNFpzcWkwaUdsWXIrQTg2?=
 =?utf-8?B?NjhpZTNBNFB0eFhqbVU3azBoSm5VTGxjK0pOaExNYzdLZWViVWdIZWIwQmtX?=
 =?utf-8?B?RzdzZ05KUFlnbktjUFlabCthY0RMNThLclh0cWFMY29jbFlGVmtIdldoMHJ5?=
 =?utf-8?B?MHUvUnRuSGtLL2dNbHdETjhVb3d5aUJ6c3liTlhpZkVMTGFnL1UzTVRZSEds?=
 =?utf-8?B?QmoxSWpzNHI1N3Q3SEZ5b3hlclhEZWJ2OWJHdVQzV2R6M2JxaVkrNzd5Z2RN?=
 =?utf-8?B?N0IrdVhiaVVuRkJuKzFzblIyWGVvWFVQamJQSzlsWmlFME9kZTBMbi9MTHI0?=
 =?utf-8?Q?g1lOX8+wVWlvcF94/w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkxWQ2NlOXNKcGFxRXBkc2NiSlZKVGRrUlBVQmFyWTFqVmQ5NU15NjBkY3FP?=
 =?utf-8?B?TG1oSTFpZXdPM2V3bWg0WktPVjlYQ2pKUDhJL0tkamJDMmoxM2ZyUE1LVUQ2?=
 =?utf-8?B?U3UreW8wb3E2aXhvWUZNTXl2MjZzQU4xcXdyVnNTL0lsYktYVXVWd0Q1MG9i?=
 =?utf-8?B?Zm5aWm1xb0NpTHZveFd2dzhpK09GWG11ejA0OFd6Mk82TnpIRnBaN3dMMHpE?=
 =?utf-8?B?YXlYRVFCZlNsQ0o0cXoxUi9jTzZUZVBDN3hSelpENU5vajFhVHdFK1QxN0M5?=
 =?utf-8?B?cU54Y2F5RkorYnFBMGZyNVJMMHJOUWhNb3BuRHdxQndWR2x5VVJRT1hHQXQv?=
 =?utf-8?B?Zmo1Nm4vT0tUNFFMWU1lNkNDdDljallWUmpnaXM1WXdVQlc2MUE1d0tVcjNo?=
 =?utf-8?B?NDdpT1hUQWN4azJtNGhLbU9uYU1kaFY1SG8vbVN6bThMdHpiY2tEM3VlY0RJ?=
 =?utf-8?B?WUM5RUcrZk1tTnRsU2xIWGdYNzYyZ09ONkNyWVV6TWdZRmhVM2NZNU4vY2lH?=
 =?utf-8?B?UXNGaVNoSHRGWDlaN3JkTXlHYlgvWXV6OWoxdURRbGFpWWRDSWVCdldCVDVB?=
 =?utf-8?B?MERaRDhmK0JXcmRtN0xqb3dKclJhYU1wQ0JUNUIzVUZoS0x6SnJ1QWhzcFlL?=
 =?utf-8?B?d0dENGxnMFhFSWNFcG9VanJNbmxCdzREVDk5KzFDNkJab2xxQTZ0VlNlLzVJ?=
 =?utf-8?B?V1BuRUhISzE5MEZUMXd1TDVYQ0Z2dmpwV3BrRXZkaWF3WUZlZzE0MHJ2b1dq?=
 =?utf-8?B?eFVJSjFqM0UrZWNaTVhyMldCSWlGTGFvRlUxbUljMXdUYmY1UHpPZEg5Ni9v?=
 =?utf-8?B?RGRteVYrWm5jVmFOQTZkZURDNHBLLzVSbEVBTkhVbEVkc055MEFYSzBLd2VI?=
 =?utf-8?B?aVhTYktSc1RJQ1hLdll2YlYweitJM3JOeDZrWVo0b2h0OVNSRGo5RDlqWnJi?=
 =?utf-8?B?ejdtZ3lXeWFSV1Z1NWwwcnYrT3AxMDAzZ0FLc1dwZ3NLSkV0R0JlWnQvcHFo?=
 =?utf-8?B?R3pNTU1tVlBwbk1URWtIK2h6M0VOZ0M5cTd1K2RjNGVJMmhmNXd5bWNFZ2NH?=
 =?utf-8?B?ZjI3OHRGS1FremQvWkNEVzdnakc5bUtveXN0SlJWdmVjZll0L1BpQ1BNQ0lq?=
 =?utf-8?B?eldiMjhKSDJkNUoyUldGa3IyekpnVXhhWVV6ZHVOV1VKTmNaTURnOTVvWUVZ?=
 =?utf-8?B?bUxJR0trSkZNS3pyT1FkV3h1YWxBS2U2Z2l5Rk9pQ0FSVTUrVmdDU1dUUzcv?=
 =?utf-8?B?ZWxGd0NJM01yMElpbms5OGE4WnA1ejRqNHB4eE02QWVMWHNwZzFKdWdHa0pC?=
 =?utf-8?B?MXo1cHhzcHpEZkpLQzMxbzJzUjFtNXkxdUxjWW1nOHJBdjdwSThVai83VUlI?=
 =?utf-8?B?blBZTkd4cERZWU9qdTlaM21uNFlObFhnb3ExbHI2eU42QVFsT25hM3NVWVJE?=
 =?utf-8?B?VVVvQ1J3cmhNeTVxMW5vWGEwWCtxSmNTdFdma1RvcWIrTFpXZzRCdVh3VVNu?=
 =?utf-8?B?RUtIQUFNOHU1aTlDeTdDZyswMmNTMXl3RXc0UDdMOHZ2YXhzT1JRNzFuaXg2?=
 =?utf-8?B?Qm44Yk92RW9yY04rVWM3V013bDExM1Y4MDlOMWM4a1BPSjRad0lrZWl0Qjl0?=
 =?utf-8?B?dXhzZ0Vva011WnNCUTNZK1VleWh1eDZZWUlVMHdDQUU4TVQrYUphTHhobzlp?=
 =?utf-8?B?MzFWU3FNS3VyVFZyVkY2elpVOEZFS3RuQWdWNnp5dFFBcXpOaDJ3ZmdCWHRi?=
 =?utf-8?B?U0drSTRTYXkzZFRjd3NBalFVMVRYZDNJRzBDNHdOWVIzWHJIYWx1endkaXZq?=
 =?utf-8?B?dmFRK1ZIL1RBN2JueWRpMnFjMGdxM01kVjFxd0VmcTBtVmJ5d09iaG5IL2Q2?=
 =?utf-8?B?cDU4dzdRUS9mckNuNkR6SGVqeDVUdUYzdWRaeWhiOC9ZNTcvRzNqYzlqb3Za?=
 =?utf-8?B?VlF1RUt2RklBL3BWeGxEL3NoSVNOUy9seEVhOUUxMDMvMloxdWRFSWNoOFFO?=
 =?utf-8?B?emV1LzljSURoUDExZGJHSHVIdjFRTWgwdmZYclA4MUo5aEdBdXRveXNVWlB6?=
 =?utf-8?B?UUJqQWZtUk12aFhjTktnUXVuM1NmeDRCNTFycXM1elVxY1BoZFFNdWRDQndj?=
 =?utf-8?Q?RNcgr6A56VkCkd1Z/XZoteB6P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e588f6a1-840e-4952-9632-08dd0a00ced2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 07:47:54.5743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTEQIJmd2T0ONkEgZ0jVD7pBZVVcpg/LxGtA6eRmdziSCFCXKhgK5fQmbVukfvMc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8444
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



On 11/14/2024 3:14 AM, Alex Deucher wrote:
> Looks like these got missed when jpeg was split from vcn.
> Cancel the jpeg workers rather than vcn workers.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Patches 1-4 are -

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> index 03b8b7cd5229..7319299f25ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> @@ -604,7 +604,7 @@ static void jpeg_v1_0_set_irq_funcs(struct amdgpu_device *adev)
>  static void jpeg_v1_0_ring_begin_use(struct amdgpu_ring *ring)
>  {
>  	struct	amdgpu_device *adev = ring->adev;
> -	bool	set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	bool	set_clocks = !cancel_delayed_work_sync(&adev->jpeg.idle_work);
>  	int		cnt = 0;
>  
>  	mutex_lock(&adev->vcn.vcn1_jpeg1_workaround);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index 1100d832abfc..7c9251c03815 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -150,7 +150,7 @@ static int jpeg_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
>  
>  	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>  	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index 3d72e383b7df..11f6af2646e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -211,7 +211,7 @@ static int jpeg_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int i;
>  
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
>  
>  	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>  		if (adev->jpeg.harvest_config & (1 << i))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index 200403a07d34..4eca65ea9053 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -164,7 +164,7 @@ static int jpeg_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
>  
>  	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>  	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index afba0eaa1500..0aef1f64afd0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -202,7 +202,7 @@ static int jpeg_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
>  	if (!amdgpu_sriov_vf(adev)) {
>  		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>  			RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> index e05ca131c1e6..6b3656984957 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> @@ -227,7 +227,7 @@ static int jpeg_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int i;
>  
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
>  
>  	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>  		if (adev->jpeg.harvest_config & (1 << i))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> index 8a14108361d4..87b3f91440e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -168,7 +168,7 @@ static int jpeg_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
>  
>  	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>  	      RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
