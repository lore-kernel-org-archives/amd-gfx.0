Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4117C369C9
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 17:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8428310E324;
	Thu, 17 Apr 2025 17:47:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L5oi/hAl";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51A8510E324
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 17:47:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/1yh2DDGtJHQz9C2dO+tqkPqX5oiy2ULpb/fPNuG9mkc+SIkJbtA8QWSe9Pi05+sl8hGej/lpQEn/AWDndRGMy9ApJjNZnJ1Sv9Gm58fGmanwbx49pn7WeyiV+MpqTR2e+HI3FkeBoteWfWhonvW3pa6ZNOa5xnxuDARfNNd4N1PTrToowAiYS5T2JHj9LocPEErX7j5sh1P4REcngJxrycMgnln8bx0g3OFh3uA7tg9aF/YVmOWnRtcCI+6nWaeg/4Pi4WbQ1GTGivrlppZurjZlTmdX5EGxdosLl7Ho1g9ZWrJq4IVawBoTOj1oZ15TgXoCpSJgHlTxNlIclu1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZFx46vJWDPOwarJqKaoFu6jb5rfK9mRZmTIulgu0Xc=;
 b=A4n9WkJom7WjmzlSnTdTw0zG2SDoPx2k25OwfsEH5KQ4yTsnigp2aVMH+o4zpSINaVzRLRT6Lj6emYD/7joQEs0qFAI4bRwCDiIe++pNhtOE3W88Md4vrPWC3LUcXmhAGIYJ6QRria6NEm0Whi985Rydus3jHMMTmX+P33FpjFwanakyMFro4mkz90GjZVbc1GG4FBeDRZHe9gEbNrW4RtRjCeKTG0IAagLwLEK3FeWBc09qZARnjH5dCrfYJGMmwBj/ZAAmdAL76rDd3nGuoRTSyQPGpg9LYFAIWteG0d8Svz+t4sa0vBHJ6bblQVZh80q83pL3c3YBLZA8lmkicA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZFx46vJWDPOwarJqKaoFu6jb5rfK9mRZmTIulgu0Xc=;
 b=L5oi/hAlP0SAxljRxjRizCzTj7MX0pUbjner6LCZSFylmmVNrCO8KSnr9sEGWFahQ1Q0snkF9pQzRUQEBMzqvxfyHVcY56bd58AKEp0li1bveYivp8fH4zsxLWcnydeCqFdjbv5s/bChbmHFqQzYBuxGb0CaxUx5whXfTkqHs+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by SN7PR12MB7810.namprd12.prod.outlook.com (2603:10b6:806:34c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 17:47:16 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%4]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 17:47:14 +0000
Message-ID: <08055519-6217-4c95-8f65-6d91767b26d9@amd.com>
Date: Thu, 17 Apr 2025 13:47:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix NULL pointer dereferences in
 dm_update_crtc_state()
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Roman Li <roman.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
References: <20250312023409.2687233-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20250312023409.2687233-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::26) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|SN7PR12MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: d153776e-2852-4f42-25e8-08dd7dd7e355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2tkWFhIYkxESUUzWEthaGRTVndSS2NrZm9Hd1ZNMnJWbmlxaEpRQ3BHSy9u?=
 =?utf-8?B?dlpYeUoxMDE3c0NkaXdnR1o2ME9ZV09zbEN3L3RWNUVhTTVZeFBZMzUxdm5y?=
 =?utf-8?B?cmN6M2xyVG5qQXBWb1dGbTNjS3R4cDhGcUZsT0dHOVJzdlBSTzcxelZGUUs5?=
 =?utf-8?B?UmplbGhIVzFiV0RjM3lTc1hKSHVJNGVPRE9nc2lyY2pBQmlUaTIrZHJvWnNQ?=
 =?utf-8?B?STZ3LzU3WGhJVWdrQ3Y1aU9weHpKelc2QUlScCt4Y2t0U1ZkTG8wNXlkZlhK?=
 =?utf-8?B?K0ZsVFV0TGw3SGxJclEzWk9EVVJ4RTlkRVFoUDZEaDNYSG9ucFhqMFVpUFYz?=
 =?utf-8?B?K3pyeFFpQzUzWEE2cFZVdjF6LytpRC9LMFRGSG9tV1A3VmxoRGVXZk5jaWsz?=
 =?utf-8?B?OXRVcyt3ckg5UzIwQUZ4cG9mcTRlR1RNVUdyMm5TVGJ0Q1N1czduNjFVR1pk?=
 =?utf-8?B?Z1FOQkM5emFKTkV2UXhFejhtMmhoZGFVRnlUWWtvUlVUVFV2LzRYVCt4a0x3?=
 =?utf-8?B?K1M5QWZPNStRR2hIT0hsa21pK1kwdWwveGpMNmxQa2tRcFJCV2F1YWZPSHNR?=
 =?utf-8?B?bmZnMVNzSUhiUUZhWWNuZmFySkI3dmJPNm01dVhHcEFZQnp6KzA3V2xOU1VU?=
 =?utf-8?B?VWZkcDF1azdQODcyS2dPRUFjWVU5MDBtMEN5V2NFczBwVWRzWE9KbmxZT1pw?=
 =?utf-8?B?Tml1dTlWbHVWYzJZTUlCbDJRNTRrZWtqYVVmT0lwRjFzeEpuOFpYQ2kvOE84?=
 =?utf-8?B?UWN5amNtaTAxdkI2R3hucUU0dnlFQmdBU1RXR0ljRWhVV0NRWDdQTVd4RUVn?=
 =?utf-8?B?N055S1gzcEU3bFlGODhzOFd1bE93Si82UWg3ZjBVN05hM3ExbmcxUUw0NkhI?=
 =?utf-8?B?dVdTT2Fhc1JLQXJac0dtbkhsbE90UWExcXJWOUxqdUFJd1VoK3RDSXB5eDdY?=
 =?utf-8?B?QTU4NURTR2NSVWk4dFhiQUNXSGw3NXJFR2dKSTh5NjNOMlkxcEN6c0FTYWMw?=
 =?utf-8?B?RXU3YmJaSnI0MlRXbnA1elhzdTBhMllwdnJSOTRuWXAyMjYvWlBaSXJNRGZz?=
 =?utf-8?B?R0JjWVpHSWtQdE1EdlhrZ21GN3NVOFFBSGR3N3dpd0t4RFgrM04zb0xXb2Zy?=
 =?utf-8?B?SStLTHJGelA5U0FONFNubmtlbXNrYlFIVFNzVlR5S1FSaU41eE92V3dCZENs?=
 =?utf-8?B?S3RaeWdiZDF2ZWlUQlBSR01vUmoyVHpDZnprU3FDclp5a2xjZTRjQWFUT1pN?=
 =?utf-8?B?eGNEZXFDdVpHZVN6VStQR2JTRVVLaXk0NUZsUmZWa1RzdjREOUl2MGw4ZVp6?=
 =?utf-8?B?T3NKNE9kaCtGcHRKejFhNWRDaDd3T2RCSUo0WitPZnIxSXp6ZWNRdkFDcCtE?=
 =?utf-8?B?dUhhdDkxSlNBeHcrMXYrQXdRZUcwQ2VXMWJlYU1ER1ZLcTBFNnJHRzIwYTFn?=
 =?utf-8?B?MkZWY2gyZEo0aS9Zd2NJUkxsbC9kcUE5K1F4aXZGbUZxb3FqTVJydTN1NkNi?=
 =?utf-8?B?Wkt0Z0t1QTRsY3BISUhRZVNMMDhheWViL1k4QkZESGEvdVFXNktZWFhDYkRB?=
 =?utf-8?B?SlYyWEVzL1JsZGJ3K3VFQmlIWnZ4aFZiUGNkbDlBZXZ3UmpyWDgvd1Ivb2Q3?=
 =?utf-8?B?ckpNRDBoZ2hpYWpqR0w1NEVCSXdLWFpqT0cyY1ZKb281Q0lXUzN4YnB0dERC?=
 =?utf-8?B?TWt3TlcwQ0NPZ2dUdGc2WHlXSnZiaHh3bjRZR1h4WWNWYzZsTDJCWVFuTnRW?=
 =?utf-8?B?U1I3dHlUOWYrS2JvVFptZ0VSWitTOWordHYrSEZhUDdwMVY4aFM5bC9nbVZq?=
 =?utf-8?B?QjVxSUYySGN2eEREOVhpM29kRjgrRnJaUEZ5ZVViNGVDc1hVL2JYeUJRUzRn?=
 =?utf-8?B?TjNjcGlKOTh4VUlwWHVKZnZ1b1doeUFMeDJpVVpVVHRYOFF5amRXZjZpZFFR?=
 =?utf-8?Q?/C9W085zp1o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ny9Ndng3b1FZbCtJY3UwZWkzRmVxc0d5RjJJUWxzaFBiTzYxRmc0TTAvZUc1?=
 =?utf-8?B?QU1SOHVTZE5neE1oeWtKUnpxbFQ0OFNTM2xCWFcyQnY0SjFkUVIrM3dlcVJD?=
 =?utf-8?B?SlYramFvMHhGQ1NoSjRlK0QveXZkQmR1TzZsZU9PdDRJOUlvS2dpNk1OS1Rz?=
 =?utf-8?B?ZS9TemVtUFJVais0WlQ3T1RpeXFFN21JcHRYTDd1bmJKM2NQSXcwQVhZSlF3?=
 =?utf-8?B?dWtrSGNrVkxIRjBGaDUrc2FPemJMT3FnRW9Rcndhc21pSFBwcGNQMzR1dUIx?=
 =?utf-8?B?QXl1bGYwSjA0Y2JMV0VURUtYeHpWdysxZXFTRVlGNzNQRzlzS1RUeUpiNG1z?=
 =?utf-8?B?alFZUlRRY0tHOVVFSG5DUXBtbUxzOVpwcHVOaGlCWWVCVGI0NkpqYW9WVkRT?=
 =?utf-8?B?QkdSYkoxR3YyMTJra2s2WXpBN2hmMW41cUQvSG5KeFV2Z1V2cFQ4aStSbUFz?=
 =?utf-8?B?NEh1eEpFM2VSOXpidDNnd3FWOHh2WWpwRDA5dnZtVGcxOGxZTDlpWXBXbFNI?=
 =?utf-8?B?Rkt5TnNRcmpld0ZleTZwK3VRM0p5Q2xSdTlUcXpkNnlIY1p0UEhQUk5MYU5X?=
 =?utf-8?B?d2dvb2FnVWNDNms5ZmkrWUY4dTUrWVZpSThwZXhFN1dnL2VYU3VqNHoyZ1Ey?=
 =?utf-8?B?YnRRcEphU1Nld1dERkNxK01GQ0tWT3MvWmlJV1pJUDVMTi8rT2NoVlhsQzFG?=
 =?utf-8?B?K3pITzMrbHptYSsyemdOYWlhM2M0aWxzOStzQmpOTzZIVmFZekpiWVNRUFBt?=
 =?utf-8?B?K1B1b2lxcTNuUnJENnBMYXV5ZmZmUW5hRE9OOFBwdklrQkIvSDNJcmNlWEhq?=
 =?utf-8?B?M2k3TXFpM1htOXVXNndQVGNsN0xkOFc5M3drRWU1cnpJeEZzdlNEVGFXTENw?=
 =?utf-8?B?V3VoMWJMamgvRVhKTlRNN1FzNEhiK1FxWGc4RldWeTQ0WVp6RjhyUmVlbVZt?=
 =?utf-8?B?NVQydUFxczhVSWx5YndRZmhsOUxjeW5Vem1wbUF0VHVvWlZheFZ0VXI1ZGI1?=
 =?utf-8?B?SXBDUmI5ZkdzcVZGaE9YZGFmN0ljZlBwY05iNmp5YXRYeHZVMUhGaXNLd2t3?=
 =?utf-8?B?NzNpUWtQQkFqeFh5b20wTm9lc3RyYWloTGd4YnZCVnV1WHQzdG1oUXZVNnFz?=
 =?utf-8?B?R1hUZDJoNkNYdFF0ZTBvOThUS0RLbGxQK3Z4Sko5STMrTlpKcWZEcGw5dnNK?=
 =?utf-8?B?V204TVl3b09jTnlyazdQeFo5VUNGME1ROFU2TnVwbWRyNHo0ZVp3am1xM2t5?=
 =?utf-8?B?YSs1ck0zcjhVZjNoSzNmOCtmYmhER3ZhT3ZqTks0MUVYOHp6MjJqbHpDM2Ja?=
 =?utf-8?B?Y3lVNDhjT2ZzYTRadXZwb2wvQ0cwRkIzV0lqbmw5NHF3dWttU3hzY1djc1A2?=
 =?utf-8?B?VlBNSkxjK3NETG5UWmtyTDNZZGYwbTZGeXNzMFhuQjNtMXAwakVPTlg2d1dZ?=
 =?utf-8?B?TUZLNTlxVnpOdjg5Q0JQUEI2ZXh1a2t2cXk0akRuUVQ0U0xqQjNhdWdyUWdx?=
 =?utf-8?B?VFRDcURiYVB0dysveGZRY011cDlNSkJCSWpOWERHS0VzZlhDaVNUdWlGTVEz?=
 =?utf-8?B?WEpLemN4NUE5eXlqbU9OeXJHT2dKVTVxWlFBWFh4ZmlPZUlxVXZ1WS8vczhP?=
 =?utf-8?B?Y1BIV3k5OXQvbmFUajd1NW51cHkzQ3M2OTdKbk1PR0Q2WE5GUms5SGZzNHhY?=
 =?utf-8?B?OW0rRmtYWU1NcWdnYU14ZEpTaGV2RXQ4dEk1cS9nY3QxeUFOYzlUNGI4dUJY?=
 =?utf-8?B?N2xyNFRibFdHdk5WcDJ3WXlOT2l2dUVlK1RaN09saThiU1Bqd2tnOXd4TTJF?=
 =?utf-8?B?RVZ4b2hPR0VoVDRrOUhWWlFETENmNlNxZ0hUekxXa01lYkZWYVIrTUFINFFE?=
 =?utf-8?B?Sy9DeTdIblpDb0cwWlE3QlN1djV5STVYZDYrWkF2Z2lMTmpaSFY4YnJjVnlM?=
 =?utf-8?B?emV6YjFmaGVrUHR4TThNT2Q5UUtEcnFCS1I1YmxGMnU5MUdlKzVsMTVsalVY?=
 =?utf-8?B?WksvOGZ2T2N5NTNpekZwU005VzV3M0NCSVBBR0tLRHk1LzBSbjR2dGt6RW1l?=
 =?utf-8?B?VW1qQ0ZTQ3hJaktzOEtEU2gxNmU5ZE5uL0R2dzZ3Z2w3SEdtZnZ3M3dWdGZt?=
 =?utf-8?Q?dafJ/Vpcv3r8aHvIVE5XIu7K/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d153776e-2852-4f42-25e8-08dd7dd7e355
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 17:47:14.3724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ptlMaZRe6HokhRqkdmEkTZLNmBn/zP2b6eTiMrNOSI9YSPlMBJwePwRQkdokiT3h+KnEg51ZLfhLPxWl4qAIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7810
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



On 2025-03-11 22:34, Srinivasan Shanmugam wrote:
> Added checks for NULL values after retrieving drm_new_conn_state and
> drm_old_conn_state to prevent dereferencing NULL pointers.
> 
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:10751 dm_update_crtc_state()
> 	warn: 'drm_new_conn_state' can also be NULL
> 
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
>      10672 static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>      10673                          struct drm_atomic_state *state,
>      10674                          struct drm_crtc *crtc,
>      10675                          struct drm_crtc_state *old_crtc_state,
>      10676                          struct drm_crtc_state *new_crtc_state,
>      10677                          bool enable,
>      10678                          bool *lock_and_validation_needed)
>      10679 {
>      10680         struct dm_atomic_state *dm_state = NULL;
>      10681         struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
>      10682         struct dc_stream_state *new_stream;
>      10683         int ret = 0;
>      10684
>      ...
>      10703
>      10704         /* TODO This hack should go away */
>      10705         if (connector && enable) {
>      10706                 /* Make sure fake sink is created in plug-in scenario */
>      10707                 drm_new_conn_state = drm_atomic_get_new_connector_state(state,
>      10708                                                                         connector);
> 
> drm_atomic_get_new_connector_state() can't return error pointers, only NULL.
> 
>      10709                 drm_old_conn_state = drm_atomic_get_old_connector_state(state,
>      10710                                                                         connector);
>      10711
>      10712                 if (IS_ERR(drm_new_conn_state)) {
>                                       ^^^^^^^^^^^^^^^^^^
> 
>      10713                         ret = PTR_ERR_OR_ZERO(drm_new_conn_state);
> 
> Calling PTR_ERR_OR_ZERO() doesn't make sense.  It can't be success.
> 
>      10714                         goto fail;
>      10715                 }
>      10716
>      ...
>      10748
>      10749                 dm_new_crtc_state->abm_level = dm_new_conn_state->abm_level;
>      10750
> --> 10751                 ret = fill_hdr_info_packet(drm_new_conn_state,
>                                                       ^^^^^^^^^^^^^^^^^^ Unchecked dereference
> 
>      10752                                            &new_stream->hdr_static_metadata);
>      10753                 if (ret)
>      10754                         goto fail;
>      10755
> 
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 +++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1b92930119cc..e3df11662fff 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10727,11 +10727,20 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   		drm_old_conn_state = drm_atomic_get_old_connector_state(state,
>   									connector);
>   
> -		if (IS_ERR(drm_new_conn_state)) {
> -			ret = PTR_ERR_OR_ZERO(drm_new_conn_state);
> -			goto fail;
> +		/* Check if drm_new_conn_state is valid */
> +		if (drm_new_conn_state) {
> +			dm_new_conn_state = to_dm_connector_state(drm_new_conn_state);
> +
> +			/* Attempt to fill HDR info packet */
> +			ret = fill_hdr_info_packet(drm_new_conn_state,
> +						   &new_stream->hdr_static_metadata);
> +			if (ret)
> +				goto fail;
>   		}
>   
> +		if (drm_old_conn_state)
> +			dm_old_conn_state = to_dm_connector_state(drm_old_conn_state);
> +
>   		dm_new_conn_state = to_dm_connector_state(drm_new_conn_state);
>   		dm_old_conn_state = to_dm_connector_state(drm_old_conn_state);

This line above becomes a duplicate now. With that removed, the patch is:

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
>   
> @@ -10766,11 +10775,6 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   
>   		dm_new_crtc_state->abm_level = dm_new_conn_state->abm_level;
>   
> -		ret = fill_hdr_info_packet(drm_new_conn_state,
> -					   &new_stream->hdr_static_metadata);
> -		if (ret)
> -			goto fail;
> -
>   		/*
>   		 * If we already removed the old stream from the context
>   		 * (and set the new stream to NULL) then we can't reuse

-- 
Thanks & Regards,
Aurabindo Pillai

