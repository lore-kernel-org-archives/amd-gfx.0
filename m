Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263B8C25B76
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 15:30:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43C9410E0D3;
	Wed,  5 Jun 2024 15:30:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sceu9f5U";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15CDC10E1AE
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 15:30:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTQWsc7yK7OWkrKn9kPUIeQ/6LPIQuUq/NUyxEsFW7oHNaM1jLIWSf6c0OtyV8VAdi8zriCwfyj+73KhUubcH4BpdobeGrEtMaQHur3Mls4ydFDIm8bAiGDLymh9k9ybax0JNj/Ec6QnaN11qhMgQQlGex9FX/xbTCXW5uFrCnp4/0RU3EukGvY8Lzo3cWXDogfm5XHfyYusSEyjpiPaNOniJfUpqsUBSenXUMLICDsqIxlDC4RT8JaCBvaQdq9mXubnURBtTS4BlCTF9SenD/aY39FbPBzgaWzZa8CxIQLVa+kWvBA4sM/Z7R2w7aYRDinb7smfPTZTWT28K4IFhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSbD7bm+EcleaBwxZ+v0hQl5M7dtABso3kJRSehHI3Y=;
 b=AqzQiaBzWRGT0T/DTdVbcxtdrth8sSLM4j3XdfsMtou2iW38UR/sJI8eSpT/2GernHeo/snZRMSn71C+6ACjBAVvSbBihllB21NnkA4PSwB5ZJ6X8qDy80eyzTdEcQqq7AyNa6Sk0hHn/CMx/ScWFwFUKQgQnPeKC7q9ZyRS1fFuLcJm29V1LHFKOrqyD/ZFQ7PZkSgrpsLO6cXo5is78mo8oH0l1ZKfxUh68Z5412vNj9yzkVEdfR/WsSCuk0LC04bX79FN/INFKZzweR4i3rItxT21HUllPEiIshTZH3sJbjPYyp9XNHmnTp5NDyVP+eFsRu7FGTawJvBDhQWhHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSbD7bm+EcleaBwxZ+v0hQl5M7dtABso3kJRSehHI3Y=;
 b=sceu9f5UApfjqzDpmtcH4GkBlyR5sAHux+XbiMuBjU/SHaHzO8gK9mnZwl3bb+2BYPa+Jgz9tCk19wt5vm+c5r4J5chyZbGDdf6CeBsxSgGfnNUjCUhe8TcuYNJ2jeldfCsqesQHvX2AD6CR3TJ8gRjsnvbqM+gn28TY0tnHD9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DS7PR12MB6008.namprd12.prod.outlook.com (2603:10b6:8:7f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Wed, 5 Jun
 2024 15:30:43 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%7]) with mapi id 15.20.7633.033; Wed, 5 Jun 2024
 15:30:43 +0000
Message-ID: <9ab9186b-5ea4-48bb-9a0f-f83ff8e43373@amd.com>
Date: Wed, 5 Jun 2024 11:30:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add null check for 'afb' in
 amdgpu_dm_update_cursor
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Tom Chung <chiahsuan.chung@amd.com>, Roman Li <roman.li@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Alex Hung <alex.hung@amd.com>
References: <20240605145328.1785663-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240605145328.1785663-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::8) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DS7PR12MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: 21fe5cc3-9b87-429d-08ea-08dc857476a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NklSSllkVmRYVHpRSVBDWVg4N0lTR0YwcENSWXFMMGx4ZS9pbUptaUs5eGUr?=
 =?utf-8?B?SGlsTEtlcGNjeWFtNTExc2JVS2xFQS81bU9uMHRwNTRMR0dVcHhlNDF0RjFJ?=
 =?utf-8?B?RkJ2cmxHbFVnQ29sdnNmOFRjMlRleXpiQ0JqVHhjQjJJR0lETGZYUTQwTmxK?=
 =?utf-8?B?ai9QY3F6MGUwN3d0OUNMdGgyeHplYjNDZG9WcE9SRDAwempJdG5LazBzWUdR?=
 =?utf-8?B?alBHWHluRVBSWlhpL0JWdEFkK2lHaWlBZ0ZYYmNPSWhUT1ZpQjhXaXFjUG9s?=
 =?utf-8?B?U0ZqOFBPc0xsanlyKzhmZzd0c2JCU290aVVvaEtJbVcxcjJCcTVHZWlQMW9J?=
 =?utf-8?B?ekQ0NktxTXlBRS9OVVJvRDhUWmltK2F4Sy9LWmxGZ0JZRFhwRFB4UkhDKzhE?=
 =?utf-8?B?aFJ2bFIzajgzaU45QnU0ZU05bnpLWHRtMmhycmFMZTczaDNSSTBYcldlcENF?=
 =?utf-8?B?MnZ2Zm8xUkZQbkZPNDdMTytpc2R3VjJma2NCalZkRlBRbndrVmU2TU4vYU5t?=
 =?utf-8?B?VFJidzF6a2gvVW1aekR4OUZBcTl4TTNpSkxGb0VXbzh3MHZXVmwxL2NNZGpz?=
 =?utf-8?B?UlRTZmUzc1FCaG9QNTJVZjBIWWJCV2dRN1h4YTUrOWlaZy9QYUJPeWFqSnZN?=
 =?utf-8?B?NGptbXVySExXeS9hdThFYk9XeG9ZdG1wQUc2MmFGejQ5UFpqenN5WVFWMkNP?=
 =?utf-8?B?dUM3cXNhK3pxampzc0s4Q1haMmFkUVgydkZ4VkdGUEdKOHdEek5LcjBYT3Zy?=
 =?utf-8?B?aDM0ajVsOTJheGlrcndsU0ZWOFNsV21ETklOVWRHcU93SklSRlNoek94Wko0?=
 =?utf-8?B?My9DaThJQ1VYUTAxdFBpK1ROYnZwOHRYZXRKYUpNOXA2NFN3a3dUR29heUFN?=
 =?utf-8?B?RTI5R3JVUjlTSEc0dUZVSFM3ZzdibkpqbTMwamYxb0ZWVWUwZ3dsRVluRlVV?=
 =?utf-8?B?UVBZbDRaVnpnc2Yydm5NSThrb1llam1JZ3Q5QXp3b0oxWG9acHFGNEdBUDZG?=
 =?utf-8?B?aUNaUTVwWG0rdHJSTGR2QnY2dkVabCtNeVIzdXR3Vy9xcUs3VWNvditybmtJ?=
 =?utf-8?B?YlBFQzVkdWhndmhhUUk2M2JqQjZCWXk5a0tVeWdJcjlrMHFGVEcrUlFKM3NE?=
 =?utf-8?B?UGxNQnVxYkcyTGc4L0ZHSk9HR09vZzVEdWZ2Ny8wWGZ3U1pDZld0WDNiaTNy?=
 =?utf-8?B?aVV5aVdxVis0eFZ5NG1VYUIyZ29xT0lia0o0TU9rZTFIc0ovbExqdjFjbUZG?=
 =?utf-8?B?ZlFDT0l5cjdOa2FxbGd2WitQSTJLUnR1YjZodFphQndsbjQrbmtRUlhUaC8r?=
 =?utf-8?B?NWsxRXdUaGY2a0lqNWlQV2UwaWdGbkU2aTUxRDBZZW44K2habDRUcHIzajdF?=
 =?utf-8?B?eURJVnN1MzFtbnJsVFh1RlNiaFlQQzdEbFVlVWZINXExV1Y5OTdndUFpb1l1?=
 =?utf-8?B?NDlScVRoVG5QWGZLdlk4Z0pzYnRRNlVtM25scmxiNTBBdUlZcXNidTR3S1pL?=
 =?utf-8?B?YlAyblJiR3ZYV3V3d3dTODBEYUlrVWJhNWNVdWJVZ0pSV25ZSG1HQ2JWVmIw?=
 =?utf-8?B?VjhYSjhnWUhqOEJTRC9oaUJWZ1FVNmRvbGVjNzNYcjAyNHF5RWsyakJld1ZU?=
 =?utf-8?B?MzM5WUpmRmJ6aUFtcHIxdS9nMHRrekFaU3RtMTM1ZGhYSmdxN1BIbkhjOTVm?=
 =?utf-8?B?V2hJOG5zTElKTjlGUkQ5bFRVbi9LZWtHOHdLWnFMYkI5cU0vTlJQNVVyRFB5?=
 =?utf-8?Q?nomVwn9PvvFM8HaB6OqFBlkj+FFzjr6RFdKRPea?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUhqeU5ER1ZvWWFXRXNXbS9CcHBmWmJxZys0UjhiM0g0bXFOMmh4eHg0QjdJ?=
 =?utf-8?B?WmZJaGpiVk11S0MwaWU2S0hqd2hMbjh2R1orNENBRm9tNHZOWlZzcW83aTNO?=
 =?utf-8?B?dEE1S0dvQ3ZnWlZxZFZjcStLQVZDekllSU1MS2hxZXNwdDdZS21iQXV3SUtX?=
 =?utf-8?B?U3duSUoxQmdIQXRUckVlZmhjeFliZXRML0ZUTVdKUEdRbHByRzkxNTM0R1dU?=
 =?utf-8?B?cnpLL3F5Wk4xTDZWdFA1VHZieTZJR2svck1tMnRYRDUvZkVaN0Rod052R1RN?=
 =?utf-8?B?SlpIOGkrcHJrUVAyaC9Ja3RhSmZ3ZWVXQnJDNXdLSmFQc2s0WEFSR2xzcytv?=
 =?utf-8?B?WVk5MHp2a2NhTWh5VGd2UFhmWWtza2NZMVVvLzZyd0tRMVQ2NllXamtxajFP?=
 =?utf-8?B?Q1pOK201cnhmY2hZSjRpa0w3Y0RVR2taM3VRY1ROcmxUVG9kaWtYd3ExVnNW?=
 =?utf-8?B?c1gvdGVSR2VSVFlwTGF3TzFzNzI1S3BidzAxK3VmR0RTQlQrSjl5RUtIcWY5?=
 =?utf-8?B?T1lQTFVpdDErbm9DeDF3NWpUUzhVM05EWms0S2JQWFpJRk03NDJxc3RlMnZT?=
 =?utf-8?B?QUN5cFRpcGJadUtqSkVRb0NPZ3lxZ1hBYllhRzZ0OTQvSDlycEwvaTlMVzJI?=
 =?utf-8?B?b08zOTFDaGVRTUVBSEhVOStPOEFMRmJyaXIxdTdSd0RmTWxMbEZMLy9TVVhT?=
 =?utf-8?B?UGYrd2JiUWhmZWRpaXNXL1gxcEMrZXkzdlJKdTNGY3ZRQmx0dS8vQlJ0RmVl?=
 =?utf-8?B?bWZ2QjBvOWw4ZkhsOUFnWnVaeE1VNnV5dHBjREZ6cW00M25OTVI5K3AwS2pm?=
 =?utf-8?B?elRIOGRxYURmSnBZc1hmTlR3OGFja1k3c2VtNjNQNTB3VFhKRTYzWGMzUTNQ?=
 =?utf-8?B?eC9WRkdTM1gvQlozM2RvcGhDd2pwZjVWaHhtUUdZTkIzb3VxNDZCNWRKV1ZV?=
 =?utf-8?B?U3diNk94VlUwU3d3L1RRQXJVcUIxYUFqTTN6d2ZCR1IwcTMrQmNWWHI2R0xt?=
 =?utf-8?B?S2U1czczYUtjelA0dVFJakJvQXIrYlphRFBnRmRZUTVFM2E1d3V1cmhEcVJB?=
 =?utf-8?B?QWZKVk9uRFR3TWUzYncyTVIvUG11c2gzUDNHUGJPZ2dCK05jREdKQlY0VWx1?=
 =?utf-8?B?N3RyMmZCRUp5SFcwS0ZMWlJiQjB0T1BmdHBzVktQZ2VFaGsxeGcxWWl6dEVq?=
 =?utf-8?B?OHM0Ull4TVh5RWJIa09BR1Y4ZStMR2ltZkR0dWY3MGY1QVh2N3h6MFV0TEx2?=
 =?utf-8?B?b3hLdDNROGNOR2lNSGRvZTloSUx2UCtDdS81OEcwSWpNbzRmWGlJQk5MQU9M?=
 =?utf-8?B?c2prcURtaThKclphWU1GY3BkbUpsL1NtZEhHK2hCMDRDcDliMExKeXp4SWhJ?=
 =?utf-8?B?NWIyaEdUUHU4dWF6QnNVaDRWSG5xTzg1UXdoNmI1aDVaeU5Rc2doTEVBdEs3?=
 =?utf-8?B?WnlqSldtNEYxa2tlQnROU2dMQUFLTVVTMGUxc3dnTVNSRENhZUxFeUVSOWFD?=
 =?utf-8?B?dG11MWdOUzNyaGFZZW1jUWpKK09Menl0MU9ZalN4Njlna3VTNndTeUduZUJH?=
 =?utf-8?B?NEFzWG4xeUswVW1UYmpielhHWjIwdVNKTFRCc09rYWhvOVltbVZvSVhUUm9K?=
 =?utf-8?B?TWkwVDl6dHhOdmZ2WG5GbitzNG5IMVRJa3V3NmlPSzZRWmxoK1N2NmpReVZC?=
 =?utf-8?B?TnhDdk9DSlFBNFRlUVJBRC9rNEYxZmx1Zzc3SjVLOXdhNjdtbGFNZGt1c3FT?=
 =?utf-8?B?WVAvdXMraDQ1YjRyUGFONXFXZ1Q2S3RKbjIrazZDSkRhbHJIc2hWMnZWZ0t0?=
 =?utf-8?B?Mm9QZkloM1Y4SHNPV3F0WFhvMlVHTTFPYU1CRENTR2NTZzFzVXA4dGZxSVlO?=
 =?utf-8?B?MEg1MWhMRWlLZVoxQS8zaGtJajJhc1E4VFVycFFrTHhwdTEzRFFrelE4Y2J2?=
 =?utf-8?B?b1doeGZOZG9NWHBVWFEyK1Q0V3dhbkVMbmhQampzY0lGK1E3NFJoK0hpWUVI?=
 =?utf-8?B?RHJiVXJMQ3FoZGNTU0h6MFpmVmQvVVgwKzB5M0ZnSHlFclFTamVJcHh0RStx?=
 =?utf-8?B?d2RnTVJoODdnYTNDV1dFdDRUaHdVN2wwUDE5Vnppbk1CYWtqTTYwbWVjbXhu?=
 =?utf-8?Q?da+bRP9LKA4F4nZfqxIwlsP2q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fe5cc3-9b87-429d-08ea-08dc857476a9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 15:30:43.5048 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JF+3aQPhCCMud6VNxPnnqj6yhDpHgHGqc5L0ez5ClLlUuoJD+uPK+Yj6y3yUM2lIgMNF5xqR45CI4a47cSvZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6008
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



On 2024-06-05 10:53, Srinivasan Shanmugam wrote:
> This commit adds a null check for the 'afb' variable in the
> amdgpu_dm_update_cursor function. Previously, 'afb' was assumed to be
> null at line 8388, but was used later in the code without a null check.
> This could potentially lead to a null pointer dereference.
> 
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8433 amdgpu_dm_update_cursor()
> 	error: we previously assumed 'afb' could be null (see line 8388)
> 
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
>     8379 static void amdgpu_dm_update_cursor(struct drm_plane *plane,
>     8380                                     struct drm_plane_state *old_plane_state,
>     8381                                     struct dc_stream_update *update)
>     8382 {
>     8383         struct amdgpu_device *adev = drm_to_adev(plane->dev);
>     8384         struct amdgpu_framebuffer *afb = to_amdgpu_framebuffer(plane->state->fb);
>     8385         struct drm_crtc *crtc = afb ? plane->state->crtc : old_plane_state->crtc;
>                                          ^^^^^
> 
>     8386         struct dm_crtc_state *crtc_state = crtc ? to_dm_crtc_state(crtc->state) : NULL;
>     8387         struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
>     8388         uint64_t address = afb ? afb->address : 0;
>                                     ^^^^^ Checks for NULL
> 
>     8389         struct dc_cursor_position position = {0};
>     8390         struct dc_cursor_attributes attributes;
>     8391         int ret;
>     8392
>     8393         if (!plane->state->fb && !old_plane_state->fb)
>     8394                 return;
>     8395
>     8396         drm_dbg_atomic(plane->dev, "crtc_id=%d with size %d to %d\n",
>     8397                        amdgpu_crtc->crtc_id, plane->state->crtc_w,
>     8398                        plane->state->crtc_h);
>     8399
>     8400         ret = amdgpu_dm_plane_get_cursor_position(plane, crtc, &position);
>     8401         if (ret)
>     8402                 return;
>     8403
>     8404         if (!position.enable) {
>     8405                 /* turn off cursor */
>     8406                 if (crtc_state && crtc_state->stream) {
>     8407                         dc_stream_set_cursor_position(crtc_state->stream,
>     8408                                                       &position);
>     8409                         update->cursor_position = &crtc_state->stream->cursor_position;
>     8410                 }
>     8411                 return;
>     8412         }
>     8413
>     8414         amdgpu_crtc->cursor_width = plane->state->crtc_w;
>     8415         amdgpu_crtc->cursor_height = plane->state->crtc_h;
>     8416
>     8417         memset(&attributes, 0, sizeof(attributes));
>     8418         attributes.address.high_part = upper_32_bits(address);
>     8419         attributes.address.low_part  = lower_32_bits(address);
>     8420         attributes.width             = plane->state->crtc_w;
>     8421         attributes.height            = plane->state->crtc_h;
>     8422         attributes.color_format      = CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA;
>     8423         attributes.rotation_angle    = 0;
>     8424         attributes.attribute_flags.value = 0;
>     8425
>     8426         /* Enable cursor degamma ROM on DCN3+ for implicit sRGB degamma in DRM
>     8427          * legacy gamma setup.
>     8428          */
>     8429         if (crtc_state->cm_is_degamma_srgb &&
>     8430             adev->dm.dc->caps.color.dpp.gamma_corr)
>     8431                 attributes.attribute_flags.bits.ENABLE_CURSOR_DEGAMMA = 1;
>     8432
> --> 8433         attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
>                                     ^^^^^                  ^^^^^
> Unchecked dereferences
> 
>     8434
>     8435         if (crtc_state->stream) {
>     8436                 if (!dc_stream_set_cursor_attributes(crtc_state->stream,
>     8437                                                      &attributes))
>     8438                         DRM_ERROR("DC failed to set cursor attributes\n");
>     8439
>     8440                 update->cursor_attributes = &crtc_state->stream->cursor_attributes;
>     8441
>     8442                 if (!dc_stream_set_cursor_position(crtc_state->stream,
>     8443                                                    &position))
>     8444                         DRM_ERROR("DC failed to set cursor position\n");
>     8445
>     8446                 update->cursor_position = &crtc_state->stream->cursor_position;
>     8447         }
>     8448 }
> 
> Fixes: 66eba12a5482 ("drm/amd/display: Do cursor programming with rest of pipe")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Hersen Wu <hersenxs.wu@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

This code comes from amdgpu_dm_plane_handle_cursor_update. Would be
good to fix the same problem in that function as well.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 6196de6cebbf..6d468badb669 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8637,14 +8637,22 @@ static void amdgpu_dm_update_cursor(struct drm_plane *plane,
>  {
>  	struct amdgpu_device *adev = drm_to_adev(plane->dev);
>  	struct amdgpu_framebuffer *afb = to_amdgpu_framebuffer(plane->state->fb);
> -	struct drm_crtc *crtc = afb ? plane->state->crtc : old_plane_state->crtc;
> -	struct dm_crtc_state *crtc_state = crtc ? to_dm_crtc_state(crtc->state) : NULL;
> -	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
> -	uint64_t address = afb ? afb->address : 0;
> +	struct drm_crtc *crtc;
> +	struct dm_crtc_state *crtc_state;
> +	struct amdgpu_crtc *amdgpu_crtc;
> +	u64 address;
>  	struct dc_cursor_position position = {0};
>  	struct dc_cursor_attributes attributes;
>  	int ret;
>  
> +	if (!afb)
> +		return;
> +
> +	crtc = plane->state->crtc ? plane->state->crtc : old_plane_state->crtc;
> +	crtc_state = crtc ? to_dm_crtc_state(crtc->state) : NULL;
> +	amdgpu_crtc = to_amdgpu_crtc(crtc);
> +	address = afb->address;
> +
>  	if (!plane->state->fb && !old_plane_state->fb)
>  		return;
>  

