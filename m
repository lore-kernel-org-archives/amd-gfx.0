Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF333E6FE4A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Sep 2024 21:24:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AB4810E025;
	Fri,  6 Sep 2024 21:24:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cVcayCjI";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57B1610E025
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Sep 2024 21:24:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9hQhgzg/oMB8YXLFSFTTkny2qK+YklMq3Cy+oAjaCyP1Ayfk476yZTxMUERanaji0XwLWkrP593z6Mgxvnu9+5P2vjM7vIPnA+A2RC/epqQez/4POhYER482Lhw0DwefXbWAi0VX8AfI73zpdEJUxyDPEqO5lizfprhpCcbTBjRbYktkeCpRqwyYbXYuIYyuiq6pR2+BgLDMaiqGPWQJ7Mgfb2lxoHwXXhD+jp+lhoanxlG4R9S91zJIdYFDPfoKC5Dfe/eSpZpsRnxHm3qWch0/m7oW3D0DT5obWDrkABcJmHNNXw/VEs5I8rGgsAYkmXsemsSfoHU9eRjs6ix5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTKcQCeS1VtxodTPB3RpPhBsIPdSP4rwk07ZahY9Uyk=;
 b=pCbTAZWz7fHqqT6KTNZ8/Kf+AP+Xjzx2XCXJrXFv4QKsIxtn4+EtAg2CE4Oz1Q+s62HsotvLKieZue7OBbkGeFMgLeAI/0nkKdCeYZs3UoAPqGL6ZkvFSzIxK50KHTsDvwW+B/pqhQxjkI+n7wDs935/Ni+l/M/dfymcXJN7ZVpUt8GgYwsKi1Eak7Puyv7O3CoM4Cvy4pT48pRgQWSs9LkGZwPSQNYQ/MxtjwVyBHqJveNPQNjiT9yjZZNfQUIXkWTWg2n7pL/kBDl4eNdtBwp050Eggbpf+se1fQvza0e05kmDREGKKv1EAevePNZKq+I6Umv/OounGL9kXuOdzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTKcQCeS1VtxodTPB3RpPhBsIPdSP4rwk07ZahY9Uyk=;
 b=cVcayCjIG69PNI16N5QmlXio0t807GDvTAHc1rfHP9BF1fLCSPGwYcMlofMqpSSIPD2GKmwHjv539h9WPoJz3nm5LQvNdVrf+62SSP1KlVZI7jve9pv7/ZRhq4QxLt8IzL7XOWiaT+HrL5AdyDhSSVVqkaudWfRQdLeIiEuo1vU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 6 Sep
 2024 21:24:44 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 21:24:44 +0000
Message-ID: <71e1804c-7f26-4a61-86ae-eaab2a679dac@amd.com>
Date: Fri, 6 Sep 2024 17:24:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Do not reset planes based on crtc
 zpos_changed
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
Cc: hamza.mahfooz@amd.com, rodrigo.siqueira@amd.com,
 mario.limonciello@amd.com, alexander.deucher@amd.com
References: <20240906212021.74460-1-sunpeng.li@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240906212021.74460-1-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0430.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::13) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c98a37b-c92d-4abb-a076-08dcceba53c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUhQR3l0WjhjRnQ1YVRacEdXaVlUY3pDcXJTSjJwalZuaERBaWtheWoxZC9s?=
 =?utf-8?B?TXZmT0NTOWJ0Q0k5S1hOMUgrNXB1UnVCWFlqeitYVmdFbzJZWm9YSkErdFNz?=
 =?utf-8?B?SEZyRjd2QWlscGlWamgrVmxlbHlxMkt5TkRiZ05WbkpVVGtCaVRyNFdlTzRC?=
 =?utf-8?B?MjJWbWl3TUN2dVNxMkMwYjJtenB0dUYwelN6ZWRBdnB3UnVWUDNJZSs5eDRa?=
 =?utf-8?B?RzY1YTJpeHAxczc3UGtwM3JHMWdZV3QzNFZzR0Q4VnprWWhlNyt4VEZYRlFm?=
 =?utf-8?B?NnR5QlZoQ0s5MzkweW05MGZKdzlmTjFtZWRZV1MxTTFrZDJ2RVdMZFJ0UEFr?=
 =?utf-8?B?NG9pTVhwV2tENzJhMTJOdUwvL2ZaZnY2ZjljOERBMmFOb2V3cndvNzMvTFI4?=
 =?utf-8?B?cWhRZ1hyWEZXcVR1VmxoYUFDeXdYcTVoUm5scFhEYTg2SWtoYkJWSzIyYW9M?=
 =?utf-8?B?TjVWdGJFdWRUS2JTMEZMK1dPODFHZlRRY2RZazJtajg2MldBemV0aENDN1dF?=
 =?utf-8?B?dkZiOTNwL0RwbzRjc29ab29JQnBnelAwcWhXRTFKMWdoOG1UNHNxdXBJa1NL?=
 =?utf-8?B?cXBNY0ZkWjM4bXFzeUlyMWRLbllWN1ZDb0d2OWJRc2IxMlZ1R3BwNzJTZnVk?=
 =?utf-8?B?ZVlUNnR5N29pVzJycEZQbUVRSEZQRGhWR3BSblZoSFRnS3kzQ0hZU2gxOXlw?=
 =?utf-8?B?Zmo3a20zUGI5THh1WTRtcHZxemRNQWdlNGlkQWRjQXNkZCs3ZnVlcW9xWTNk?=
 =?utf-8?B?UE1nVitjcDYyUEJ0VnJ0cjJEMDVCcU56UmhrYm5JZCs4VVZGWCtQeWlySUZm?=
 =?utf-8?B?NCtJTGlBam5XZEhHdVh5Q0Y4M3VYdFozSVYzUzdGeHBPQXdIM0RlMnF5TlI5?=
 =?utf-8?B?aXJOZUVkWTV6OHF1V2J3RDRiT0xlWnFvQW9qOVJaaGU4VzJZQjd0YUlRenZ1?=
 =?utf-8?B?dHV6WmhTNE9MS3JCUFFmcFZWNlpMRU5zcDJ0V2MwN0IyVHdMdnNGMXlFYVVh?=
 =?utf-8?B?ZkY4MENvL3BuRzY3MlN2U1hSSVVmblV2ZlJtWHA5S1dyajNnRTRFb2Z4c3l6?=
 =?utf-8?B?YkdIU3E4bWNtV3dkUFNrRUo4VjYwdEVIVFFRZEhHc2xUczV1RjFEZkprOTY5?=
 =?utf-8?B?OVQ0OTJBYzcyaGxmbldTYVNsR2RRMmdpdlpCQ1BHNzg2bXBtQnV6SWdTaDI0?=
 =?utf-8?B?TDh0QkROME5IU3NWT1FCbDhzOXpEWGFJdjZVcVJiTjlzNzF4L0xFM2dveGZz?=
 =?utf-8?B?RWVUbkpTQ1BvNkxmNEhlL0Y1N0pzbWlLb1pDT3d6bE5MZlRORHo5RlVjMmE4?=
 =?utf-8?B?UU9lRkQxS2ZYQjhLNkNoSEpCUkh5QmMyenQzalJQWlpFU2VLcXBLSDBFaWRp?=
 =?utf-8?B?R1pCMkVSVlVoQmduVFZ5ZkVmdllUOHFaaXpuOGJPK3dYQXBlOUFPL2FIa3Vn?=
 =?utf-8?B?UVdmK0pQdWhHclRFK25uRUxpOFl5M3JhRVJ3ck4yc2JmVS9MQ0wyRjcxeUJK?=
 =?utf-8?B?L2x2aW1Xd1QrUDBuWTZvRzhQTkZrcm9ZQWFYVm5TZkloMFZKRjd4NjZpRFpV?=
 =?utf-8?B?a3NMQVlFNXdzeGF1NURkaHVJcmVrUHZTb0Z2VHhweXYwdzhML1FxVWFvaTB6?=
 =?utf-8?B?bHBpR05CeDFzZ0hyWGdXcC9vVzhHODR0N2RCemVIQUw2RjgzTExxTHR0ZGNp?=
 =?utf-8?B?eFdINVpYazB4OUVCZitoaldIOEdNRGFaTnFBMC9xTDNPNC91SitydzVoZzF2?=
 =?utf-8?Q?MYZxB44QA3+zGtHwLI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWVYUTVUMkxLVW1QZXpvbHgxQStJbW1vZE5kT2I1QTU0TWJ0cXVVclFBaXR3?=
 =?utf-8?B?RU5wVldNazArMUh5NFJJN2ZVaVlEVGN4aWNJRGR2Ti9rdnlwWEgwOVdSR056?=
 =?utf-8?B?Z2IxZzRpRFNsWXowY1lhc1UyUTB2WWlZRXVEallET0IvUWVjWXRNOWs0YXZ2?=
 =?utf-8?B?WjBkVExrS002SkFtZVorbG9UeS9kclZ2bkdBWHBIbkJsK25GSk90dDhaaUFM?=
 =?utf-8?B?S25TcFYrTisyaDVuc3VBMThvZ2lOUjFOU1RWT2hEbnMxeWcvQWg3cUJEMkFQ?=
 =?utf-8?B?bVMwMzRVU1FlaEY4ak93b240bmFPK2g2VytQMklxU0hHZ3dXNGQ3WmFON2FE?=
 =?utf-8?B?dk5BaFNxNFdrNXBRUGpiUW1xT3pEVWwwZDd0amtlTmZMMndvQmVsV0FnRGhT?=
 =?utf-8?B?cHd1RmRoeTFFZkxzVDAxZHlmcUJsOG80NW9CaTRlUmlRd1pWS09SK0JFTEYx?=
 =?utf-8?B?Z3F0R0xnTzhqODg3VnJqRm9mVFpMRUhzemFzMTUrTWtTN3ZrSHFXQVR4WHRT?=
 =?utf-8?B?c1phem94dUFSejRackhMSDlxYVIxRHBTTFQvYXgzdVdTL2ZVOXRFMGx5ZElG?=
 =?utf-8?B?REZaTTd1RkpMWXhrZW05WElNVWxpS0MveFJKYVJaSHozbXBwT2xLN1kyNkJn?=
 =?utf-8?B?cnVoZDBtVVlsS2N5UE5Ea1NpQWY1OUdSY3lTNTRSNmFtMm5MdE5TWnFrZXpa?=
 =?utf-8?B?NHdvOVZyQXFma081MXRZN0hYOWFTakRNRCsrNGRoS2VWbXlqcTN3RWlvNVph?=
 =?utf-8?B?dmhjWjk5QXo3WlRHL295RDZVanhaYUlwWUMxS0hOUWFoQmp6anZlNFR1WURq?=
 =?utf-8?B?OUdFMzk0OTNxZ1NOaW9JeUVXSzBGZXhRKzVJeGtHSTEySExiMDFXeUV1M3Uv?=
 =?utf-8?B?UkIzck5aeGlKazhzTVRkaUxlMmpMOVBYazF6UEQ1T09IV1kxWG5TdTd5bEVN?=
 =?utf-8?B?SDdqMWhkOXpuanJJMUpTZmFSVGQ1VDVQOUN6OEQ2S2h0N1JRU1N0aGdLWnpZ?=
 =?utf-8?B?WmtKcG1CTENmYmMya291a0huZEIxSEF0dVk3S1Rxa0pNUWhIb252QVpOcGRU?=
 =?utf-8?B?a1BtOXprMnhMZmR4YnlQc0NIQXN6am9LVnNacDFKQmU3emtWWTNaK1lxQU5Z?=
 =?utf-8?B?OUxiNGwyQ01ZUlJTMGs1N05UdnlNUnFHTXJ1dE1ibnl6MVp5V2MrNVR3c1cz?=
 =?utf-8?B?b1krZFQyU29JSVBYcXljQ3FPV1dCRURMY3E5K1VaNFhxZE1sYlhUK2wvdkRP?=
 =?utf-8?B?UW1mTXM0Tk9xOVloaGVoZ1RkMVRENFIrSEt5amZZazFNU2V4MTJGRFNWYzhy?=
 =?utf-8?B?MTdGS0F5cTZZQzZjOW5ML0xJZVZQWHZQY1lITVF1ajRrdTNHMWJ3RjNzNkhK?=
 =?utf-8?B?d3hBLzRiQzRBaGFJemcyNkRoZXlFd3k0MmMzYms3eEVZMHlVR2JGSW1rRk9I?=
 =?utf-8?B?WGpaWlZsZXY0b2ZHdGFDK0w1WFdEM0U2cVM1dGpjaUYxRlVZaU1sVDZhazVl?=
 =?utf-8?B?YUNpSnQxQjdpUUdhSE53VTRKYXR2ZlZSUE4reGFvM3VrTko0YzlYY3RsNlhM?=
 =?utf-8?B?RzIweHAxUHI2c1ZGeEpQT3hmVEFrUDR6QktTTitUeHA2N0ZSZGNWcERSTHU2?=
 =?utf-8?B?Ny9ab3BxVGcyQmV2WDdEREdNNC83QzdEMVozYVhCbTkyWUZXaGZoQUpCM3g2?=
 =?utf-8?B?S1Z1VEJuVzlCVmdYQW1Ya3F5TjBxVVMyYzBseVVNdkcvR0Fta01LTmRDUFc4?=
 =?utf-8?B?dENnTWZPcDZobE93WW12NEpXeW5KbnZCeDY1U0t4ZnFkU1BsTUVVMHZMdXV0?=
 =?utf-8?B?dzcyeDdUeU9PVzB5WExRUFV5M2pIeXU3VzF3em9TaDEycUVhU1BLMkFoZ0R2?=
 =?utf-8?B?RGl5RWNwRU9qZGRMaTlvYjZoZlpxSlNReFBoS1NQVEluWkFEODJSNUUxbTFr?=
 =?utf-8?B?emdZK1ljdVR1Wkp5MFRucTRQNVBUL09jeGlhWFNhM3ZZRjZ4cWYrWWpOZlRT?=
 =?utf-8?B?cGhQTFhSSE56VWt3TEFKZ3pOaHJSRmxUUURjMmJZblB1Ri9ieDlwUDNBaStT?=
 =?utf-8?B?Z1ZnS1FjV25WSVdPMC9JaUVUQ3RhZGpqT2ZKQ1N5L3VwalZOZVZrdTlscUlG?=
 =?utf-8?Q?ECps2HUoZbJjmvIKCy6Ak84nS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c98a37b-c92d-4abb-a076-08dcceba53c8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 21:24:44.7543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2LnOZb3colAFit5zrCAmY3MauyXGrC83oRpuClnXHxCqyOeDkOTNhfkIz4TcWoKz/bmpnMW/nQ3FjvKznsFxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875
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



On 2024-09-06 17:20, sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> [Why]
> 
> drm_normalize_zpos will set the crtc_state->zpos_changed to 1 if any of
> it's assigned planes changes zpos, or is removed/added from it.
> 
> To have amdgpu_dm request a plane reset on this is too broad. For
> example, if only the cursor plane was moved from one crtc to another,
> the crtc's zpos_changed will be set to true. But that does not mean that
> the underlying primary plane requires a reset.
> 
> [How]
> 
> Narrow it down so that only the plane that has a change in zpos will
> require a reset.
> 
> As a future TODO, we can further optimize this by only requiring a reset
> on z-order change. Z-order is different from z-pos, since a zpos change
> doesn't necessarily mean the z-ordering changed, and DC should only
> require a reset if the z-ordering changed.
> 
> For example, the following zpos update does not change z-ordering:
> 
>     Plane A: zpos 2 -> 3
>     Plane B: zpos 1 -> 2
>     => Plane A is still on top of plane B: no reset needed
> 
> Whereas this one does change z-ordering:
> 
>     Plane A: zpos 2 -> 1
>     Plane B: zpos 1 -> 2
>     => Plane A changed from on top, to below plane B: reset needed
> 
> Fixes: 38e0c3df6dbd ("drm/amd/display: Move PRIMARY plane zpos higher")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3569
> Signed-off-by: Leo Li <sunpeng.li@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 43bf8883ddc0f..a3edaf658ae00 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10579,7 +10579,7 @@ static bool should_reset_plane(struct drm_atomic_state *state,
>  	 * TODO: We can likely skip bandwidth validation if the only thing that
>  	 * changed about the plane was it'z z-ordering.
>  	 */
> -	if (new_crtc_state->zpos_changed)
> +	if (old_plane_state->normalized_zpos != new_plane_state->normalized_zpos)
>  		return true;
>  
>  	if (drm_atomic_crtc_needs_modeset(new_crtc_state))

