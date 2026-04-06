Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF78F46C4D
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2026 15:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCC4910E269;
	Mon,  6 Apr 2026 15:45:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CnbumQLY";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011014.outbound.protection.outlook.com [52.101.52.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 295DA10E269
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2026 15:45:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NODdwDoiwsyPoZ2Qieu2IzoZqxGSBR1XQnaMcSftBwZ/0n5ibsvwJdAzIbo8p7QFfyAMakaWpgJVeNdesWmQDYTsBbdJy0s3PiuRmgIE7i7vyEYQsmCU1PeWGiePe/szOgvT+9kNHBgraqKdxVQeSBY2BVOJXuPtc38GGeaufEiJHnwRtmA3/Gdw2gzRgmSQNg36JaoVtEGE/N1gCio4Kv32jkRVBYILydlj0yZRNYEHJxa+oX6Xc2UWc9aEzFitDtnn6KGjxY2sRNxhY8/Yvq5WxVv/6lqJJi7FGTRHhGvaLByxdBNRFvy3RIbesDzIFHcZfHPAh3CdVqs2ogXfTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6Fp1udnNJQiQOMzzm4On1X73d/vl1bQGUcrRsGV4vI=;
 b=OUiDxSpm9NpB8KUwBUdUL3ZQatXGlrQPitQhIMn+cE3/sU/51Iei9Tlid56pw6PIGldMWF2d1aVRGvAWbnXm2RdWIF5eyAwwXPnClsDe9uzXCxNr1sKueLT8ykxnmzB699bDLF9zw6YVr52B9MvwZSzeA4wRGJWC1pkYdUb3cIFeNQ+TqhLS5BzBT+tJLE/WZw78XVkJ+UBQx/9lUd4ccMqZwTt/uoAHX19fXmvzVf6oqQdBSE71jU4G4FEFBY6+PvTYEr0o/LMKTj0k5GARMDjY6PG40QkiqmwdsJKZteXjl1HuVfyD5HFduDzAE9/bT/e37oImdghZOgtT8QRFjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6Fp1udnNJQiQOMzzm4On1X73d/vl1bQGUcrRsGV4vI=;
 b=CnbumQLYnMGTJw0rH6IAG2QhBnMDW1QXZdvCRhI0jFNhbwfin+beGNqcWz3d+J4QhG2rcOTDgIwV5Hq2HwVvSp3GmDLYJqmhtowOeaotzkO5qG4Y2DuaB4YFWfPE3KC9fqaIpqNq2N7f0yUnC8lx5o/VokfeIRKbLIKS6pcVVBY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 15:45:28 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%7]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 15:45:28 +0000
Message-ID: <3cb0ba02-90f7-4b32-86be-ad991e8a397b@amd.com>
Date: Mon, 6 Apr 2026 09:45:26 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix do_mccs handling (MCCS/DDC) in
 amdgpu_dm_update_freesync_caps
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Roman Li <roman.li@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>
References: <20260405023145.2259115-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260405023145.2259115-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:303:b4::20) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DS0PR12MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f408caa-35e8-465d-3974-08de93f386a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: /eNw87t5hwXo7nbJK1I/+bN4FagxyKaKExhS182pzsbJyxuOEXNrd6Y8ffnuTPCNELZyovXKFtSaoXxly8GIQUIIgoPr8BewlshI+ojPm19zFZIupT6isBeB8k5ZyvLglbacr9wUBsfJo4PxpakXY+gNplmThpuCeoR4sYMpWvdS68GIoTeFD1QpSN/w02fkyXdcC3n2lrmC34KTlAr3xNy82eK1e3A/FGQtanOcdG66qu2808keKXTToUjkRsfq7iPtRQNJdLYJMSkRfVkOne8pGmw1vvOEGIYJDiTZl8nbMUJpyoU2A8Q32gaJtnhczMcsEObyzaV0tqMhlA3uGx21b0pj+P4no9F+jBYj9+PrfF/2SxCJFqNs9Bh4iTx2j6lR5HZR8YpD0zPSq2ME6SLBVP3XESy/ar4cE+WKxAAt3UMATyFR42eUcOZkfK556uNrrKTydLJoj4Ry/sbkJAahhwWJPSj/6Tjf2atOVFC34xLvd5/C6jdOsso4TWNVAnlaPGu7clRO/MEHrYsRysXNthXZOyOwRwGb25cL8cZbIpVy9G/Lk2wyviPWk3RacDssR63UtrcZiuLDmyIT/g+IpIWgF/JdGiSnjBAp4qBapaskX55uIH78+jNyrxstfUUlyglOgJBioh7yUH1knMC0vuebTeyg0JCEwxm/WlJi5XB2FYYDwJNL1m4OWGgk9cTkaDnhWsqJmtvXoO9BL9C58ybwvggMpkqF3oO/E0g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkRGQmVXR0lFR0ZaZFdpVWdDMUZVSkIycFVaZU8wejBld2pqZDM4ZWljdEtZ?=
 =?utf-8?B?YStGMTc4dFZxMThXbEVGNHh6Z3BKM0orTG5SdTNKWEhjbU43emJxWFBzWnJ4?=
 =?utf-8?B?d3RVVTZJbFlwY05PaW4wbFRYMmozSE1zdW5haC9RM05McDBQNEk2SVE2cTRZ?=
 =?utf-8?B?VE9kRStZZHY1dVRjMXdQV1MvNUxtNWFJTXJqSlBoampSYmN5M0JlUXRSY05a?=
 =?utf-8?B?L1NCbmtoWC9nbmxvbHpWYmt4Ym1URVkwOExIcWtvRTVqNTYwNDc3c0Mzemk3?=
 =?utf-8?B?dkc0QlRHQ2dtcGtCdkZkK2pkdkMwT29TR1R2Y09ycU1HblM3TFE5Vm9lZ01o?=
 =?utf-8?B?bm0zUzc0eEdBRm52bDdzRjdWNVlVWjRqOGZDUTZzWk56azZReEhwSWdsSzRN?=
 =?utf-8?B?bTkvRXJMUnVLZXRTalpRQUFBSjFOUjJHdkc1NUF0K2FwTXAvYXYwQ3pWQmx3?=
 =?utf-8?B?SHVENWRUWElhWjkzYWdUdnRMS0J3S2pWMmJZZ3gwVnhhd3RWeTNNdU0zSWh0?=
 =?utf-8?B?Wm9qTVlmcXFUeDluemUyd2dQNnNaYVJwREc0T09sOElXaEpzMVFYRHljY01Y?=
 =?utf-8?B?SmE1TVF6dVdXSy9qMGtBaXhOOTBjUytTZGRkRUZGR1dOYXN0T3RvUU5rOEFz?=
 =?utf-8?B?SGhXRysyRmxPb2Q4cHNURTRsSDdsR0J6UFFCNU9nS1JlYTc3UXY4dm82R2NX?=
 =?utf-8?B?aDBlTm9zYUtuaWloTjdpdENDQXhNcXQrTm9zd0VrODhGTmhQa1JkSlhka2lN?=
 =?utf-8?B?WXFDY3ZtTXZKQkxURjhSbGdYa0Jsbkk3YnFmZ0xWOTN2b2NYNlQwcWkxd0sv?=
 =?utf-8?B?YW1aNjhtQWphSXFwRGxON2VQYTJOMTRBcVF5M1dXREVBN20zNkJQY2pBR0pn?=
 =?utf-8?B?S3JlN3dRMzNmWUhoV0xrV3NVSXpLaElweXd1S1VuUXJXM3NPeFZPYU5qOFpS?=
 =?utf-8?B?dmZKVXlyNWV0ditPREEzZU9aS2c4SWRWU2IyeFEwdlJ5eXNGdkFTWHdTZzZL?=
 =?utf-8?B?ZHZxd0dwaUdKTWt1eVpmeVVZcCtZNURPN1FYT2poQU5aUERUcjRxZGpFRzdN?=
 =?utf-8?B?a3ZTay9QcUhmTHdrTDg2alltY2dQOWV4WFZ6NENNWklNUmUwQ0Nna3R2R3l5?=
 =?utf-8?B?WG44L0JxMm9QVE9WMzVwOVlkdnBOeW5UbFo3dFFzeVI5TTF0UWlsQmZPaHVl?=
 =?utf-8?B?WnRBSUw5cXdOYjFXWVhKQ1RzazRtaDJrRDcxUWxKOC90NHI4eWRmU0JpamJh?=
 =?utf-8?B?N1RRS3Z3UU5nb08rMDJ1VTBZc1dnOW92ZGZhcjVXYXhqL2ZmTGlHSFRFRUNw?=
 =?utf-8?B?cEg0L1F0dGxMQ0Y0QXU4cUVpYkU0RmpQRVJFS212bmQwQk1icDhVRTMwLzJr?=
 =?utf-8?B?TDNLTUJweit2M01WZE04N1VocjRIR3dqZEs4MVBRVEdTTXRjSWJPK2QxaVhB?=
 =?utf-8?B?Qnh6c2kzNlhmVFZ4M2ZZOVpyMk5PYXZpMnVodU04ZTlURE43a3B6ZEpOOWpx?=
 =?utf-8?B?R050Wi9TVENESC9KVkgwbkk0MjdDTGo2amo3WVl5U01CbTVBNllENDVpaW56?=
 =?utf-8?B?WlducllIaEtoNGpSYUdsdkE4TlpaOW4rSVRxK3lLaUtSakwzS1p4TXg3RVhI?=
 =?utf-8?B?UDB1YmxpWVluK2VjTk93S3pQVmY2b1NrdnlhSUw5b2dhWUt6Z1ZSSitSUXVr?=
 =?utf-8?B?d0ozTGt0Ly9QbDZ3TE5xd1NaYXFrRVVQSFh1N3cvWGhxOU5KRG1uQnMxdW9Y?=
 =?utf-8?B?NWQzUmdFNUJvRUsxMGxoNmF4SFpZeXY2T3VMNVlZendmNWlLK0lzREwrRnky?=
 =?utf-8?B?aEE5UnhvNGo0N0dsRmR5SEhKS25GT3VaSmdsdmd2cmhOZ0lWNmVtbWFidDVj?=
 =?utf-8?B?ZlNVcnNSOUV5R1Z3Znk2Um4zQlJZeVc4NDlqWEMxQ3c2OGF2N3hKdlZHYXRy?=
 =?utf-8?B?Z1ZBelZqVlpnZ2RDVkw3Vy9ndlVCN1AzbC9iNHdlWHpJbDJpb1ZyYUdWNjYy?=
 =?utf-8?B?QzdhRmk3bDZ0SFNjUzZCRS96cE5la1VJY25DcFJ1UHJPZDhEbnBuUHpjNytT?=
 =?utf-8?B?U0lEZXkrQ1JlV2ptQkEvdFFCeHNYTWtHWHFkNFF6aGs0bDJENmRZdnRpaDNJ?=
 =?utf-8?B?cnpBdHhkU1JnbkhkNHBQSnN5OTk1NEVSdEpxYkZtUkR1ZzBqQ1VWZGk1T1RK?=
 =?utf-8?B?aGpKQjkrbU8yVmV0WE5jN09xUEpyUE1sK2hhR25hYWliSitFa1JaaWFZeGVv?=
 =?utf-8?B?Um55M3psUngwS1hKOW5WV3RQMnY2Tk9YNjBJaXB1TGl4eXVQR0ttY3ZURFYr?=
 =?utf-8?B?RFBQNE5QeFdIdWFFa292MWVURnFoMTlWQml3a3BLZmhxS3RKNmF5UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f408caa-35e8-465d-3974-08de93f386a2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 15:45:28.1042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8FJY3x0yqYJ8xR3N+HHh68pX3MOJqWa+Gy5QKVhiUUupi8J/cblH87m/0lV0dyYAeFiYG3kZRFLZPXuGmxHxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629
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


On 4/4/26 20:31, Srinivasan Shanmugam wrote:
> Fix do_mccs parameter usage in amdgpu_dm_update_freesync_caps.
> 
> This function checks FreeSync support from the display and updates
> driver state.  MCCS (Monitor Control Command Set) over DDC (Display Data
> Channel) is used for communication between GPU and monitor.

This changes comments but the title and the commit descriptions sound 
like changing the code. Can you clarify them?

> 
> Fixes: 980a8981351a ("drm/amd/display: Avoid to do MCCS transaction if unnecessary")
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Wayne Lin <Wayne.Lin@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index bac02ea15b8a..4b6a1c62bfa8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -13259,6 +13259,7 @@ static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
>    *
>    * @connector: Connector to query.
>    * @drm_edid: DRM EDID from monitor
> + * @do_mccs: Whether to query/update MCCS-based FreeSync capability handling.
>    *
>    * Amdgpu supports Freesync in DP and HDMI displays, and it is required to keep
>    * track of some of the display information in the internal data struct used by

