Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A64CA101F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 11:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2AEE10EC11;
	Fri, 12 Sep 2025 11:17:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O9904veI";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1124110EC11
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 11:17:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yd50wBvrzdZfmjCDiN1PKSG5HJnlu88KXup54/jZFPzBKM0h6ykt0zgeHTnASa+ZbuAOrCW9fChshHJF46A9qptTdItD1G/CDCre94tlD0TUv0k8THtujW5Qzb0jCLXanrPYnnzF1zjPyFOfvoHsH+lJwWqgrgGT8RQAAhYIdi0467pxU56cz+hzOM9l7/6K6njnEbzAKA/4bba+FchGbZWM21P8ezBtFq1hbqrxQmWPBP7Mf6Ahp7MJFOzraBw67mEa52vohg5SSRvzyzEGelisjyqjQyDOAC+XCOgyyC7e6dQNAL2c+KJa1a5lDuvoy4vptT+A3Gx0smuDKeF/Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxjwTgDi49OYqyCROIKseAt6cbcZu4ljeEVMK3jZq+I=;
 b=f4r0X17l40SzfNBkCxLxhGBy+ZB0Q4zLzUhyp936GfS/NoUJcCZKArKmEwBCdO310d4bK6NjRhQrhUlduxNT4esATPWWCzObcOvh6x1ALOv34/Gz9lCisPG6eoWntmqgudatD/UnMiDwUMmUN8otkebVd1WwOr3pQFMiW9vc6h4MPyGj5EQgOsn3OXE95odp97MWANDgnnQcxjnmE1PQzAvq3tmO05NrXmWvzM77ZSAOnl1L6lA++6Ycf87n7z2AnzD6bMaSHzw+OXOnkYgk1UrO2ZCspkh6xGA9EEQ05H7LE0gPsJrUlH9Iu20eMDk/8Gv7iNV55YNQBGmHlyQdUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxjwTgDi49OYqyCROIKseAt6cbcZu4ljeEVMK3jZq+I=;
 b=O9904veIOlg4M2aNRARByMov2Yxystx7jfQME2LmaO7LjmmeDD2tT5sb/w3BP/LZcpE7thM1FtdyOVBcxENY+Hx82WmrEjrgeBkEmvDK2Vpvwym1cnJLdU5YOYqJ5wfwxELFs93mAAIZ9VE3C9fOUf2WAKdoKEk9QCvS8jb3vn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 11:17:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 11:17:20 +0000
Message-ID: <5a04607d-0d50-4543-8498-52122045048d@amd.com>
Date: Fri, 12 Sep 2025 13:17:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 1/2] drm/amdgpu: Simplify user queue locking with global
 device mutex
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250912093202.4905-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250912093202.4905-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: 3071f378-6a2d-4940-6262-08ddf1edf0b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0xJTW10S0dzbnlRUExOMW52cTgyUVkwdGVHZlhHVTlBcDVxSEo2L1NOSG12?=
 =?utf-8?B?Y3E3UzZXNlk1RUZ1NURNWFRQaHE3bzNyblR1RUhJWkRSd2ZBZVVnUTNDL3J2?=
 =?utf-8?B?RllxSTRScWRRbUN1cmFMOG1ZOVNJNUJkZHdOckhUTDBZUHA0TlExUVVSVDVR?=
 =?utf-8?B?bTNnVGtuWEF4QTBZN0tLdUZab0lCTjdSU0JlUGpHaGZwT3F2d3UrR09QK0Zz?=
 =?utf-8?B?QlJhZUxQelVOTUg3Y09CRG41anhSSWxRQ01ZTnB6WDRTK3QwaTNTVFBVT1dO?=
 =?utf-8?B?N3lyRmdWRWJUb0p0Z2xZTThZbStiV1dRbUEzUnR3T1FVY2RvQXNrZktNREZU?=
 =?utf-8?B?czRBUndnYVdSQXp4YldieEIrSkc4K3UwbTZjN0dCSzF1RFplak9BMUM2TjlH?=
 =?utf-8?B?aXJjV003dS9uK3J0WXlWOG1zeXFydnMyOVlEcFhneGUwd3ZUMDE3RnIwdFdV?=
 =?utf-8?B?blRmSkRldHZab2gyOHdyV2hlanNRVzVMMmNwelZEaUJBV0xnUGl6THdka0d0?=
 =?utf-8?B?Y1dtK1VUY3lJTTFuRDhOczdlM1pDREhFZG1GZVJNUnJ2MklrN2Rjc0RST1U1?=
 =?utf-8?B?dzBEVDdSY3pFY2lLdEx5Z3EzVGN5REt3TmhqQkJUZFlMb3V2Rm9zNDlNa2JT?=
 =?utf-8?B?ZlIwUHBMbWczc29PY1hRbUJyK0hubFQwRmIzVzZwd0JnYllqR1J6MzhuTlZa?=
 =?utf-8?B?U1J2anRxNGRRdFRGcXQxSGJGM3l6TlBYTXA0Rm83MWFkcW9LM3pobXFCS0ZY?=
 =?utf-8?B?UWZJZ3BuRkVPQlFpUDRuS3BDVis3VmVFNk9iR3ZRSEFUaXhnbjRFNTY0M1h3?=
 =?utf-8?B?SHAzTFp0MHBRdnVhUUtXeEFHeW4va3ZRVFN4Y1FBTVpFSFpBK2E0a0lyWnh0?=
 =?utf-8?B?NWllTGhwczZFUTRpUUIvYWhwSzE0WjM4REo4eU03eDcrVUliWkJvdi8zWENt?=
 =?utf-8?B?eTlzaFZ3SDZJVENmT0Z5eCtyR3lTQXJWMVcvT2ZHODRkckkwbE5aaWZSeDYv?=
 =?utf-8?B?NWUvMFppMmRJcldsUUJJUHhTbmlIZThaZUFpL2h5d01tbWVubHRpYWtFZ1l1?=
 =?utf-8?B?NzVkcjNhaXlSQ2E2WnNiMGtTR1RiVzNRQTZhbDhTZXpEbUp5YytiOE1PL3ZT?=
 =?utf-8?B?YXVQMHhwY3Qwd3UzTm52NEgwd055VDFJdy9WZHJEUFB3MVh2ZEJ1VGE2THlu?=
 =?utf-8?B?ZWZmZDBTVGdJejhCWWRmamJxNkxzbE8wRSt0NDRWQUNPbkkyMi9kZ0hlcGZo?=
 =?utf-8?B?ZW54a3FRZ3RLQUx5cFhBKzUzOEJnakdZMzRXKzN4OEhNVDYvb3JkVU9kRGt4?=
 =?utf-8?B?dktUUmRWTWl2UEpSb1hMdjJUTW9aTGpNalBMRUU4YndYZXdnNjRhaUpNS29t?=
 =?utf-8?B?VVF4YlgvaDV3TlVqb3hadDJXd1I1R2tzVDA1UjhFL0NVR1JWUzh4cFlOTldv?=
 =?utf-8?B?bTl4eVA1MzMrcXdSdXpVSEx0L0xPcFBZTmtXblFnMWNEN2luNHpGbXZ1dXlS?=
 =?utf-8?B?Q3dyMTUxV0Q5SFNaRDlXR090bWFKTUZ2Z2FaMjRTbFpmMVIxQkxUOWFjZWtj?=
 =?utf-8?B?K0xkQy9WeGlPL2F3enc1MXBCWHRkKzN6VUVMVW5hNzdNbDJQU2hsQnRIaFdw?=
 =?utf-8?B?QjRKNlFGZTFGMmtqT3FMMlJtWVZ5N0JQNWd6UllMNGtTSURWeHhJTXpSMS82?=
 =?utf-8?B?c0FYc05QU0puVzF1cGhPUlZIY3dya013NjI1c2JPRDM0SW5zRmxhQ013OEVv?=
 =?utf-8?B?cVZ2UmFyYTkyUTg2UkJyRUJjN3BnbWw1bmE1dFpkSjFQWDZHVC9YZGpteFBJ?=
 =?utf-8?B?bVhxeUNmeGdQK2dpcHZvcTF6OHZEV0pxOGdIWVhZaTVkNDdDKy9XUGFkYjhz?=
 =?utf-8?B?S0xpc2h2RzZBR3pPQnozKzQyYjA2dmlldmEzdDNtcDBCSElYOElQRW0weVRy?=
 =?utf-8?Q?cbGncuhQ+8Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUwxMG5QWk94dDduMVFKUW5KbWFZcDNkVnR0TzVXUHMwRll5SnNGNlhFYm9u?=
 =?utf-8?B?bWFIYmxadW1ibWhWOGx1TVoyVVM3cmFRa0M2TFF4S25Cd3pZdkJkQ3graENo?=
 =?utf-8?B?VlNVMnV2ZjhPNWsrY2FnTmRJb1dtek5rYklHbE1Gd0tUNmRTb21ra3hidWtX?=
 =?utf-8?B?RVVPaE8xNGRSMFdWUzE3cnBUZDZMQ1BDdEhIV05ZQjhhL0dkVW5VejJRcEdV?=
 =?utf-8?B?RDNDdzdJU1d3SEtxSVVraXhLVm04T3g4S1M2dW1aSG5FTjhjdjArdUFTS0xx?=
 =?utf-8?B?L29lakM3engwc2xOSWs5ay8xVDZhYlNpTkVvckZVbGVtZXgzVHNpWmVqc2ZG?=
 =?utf-8?B?V1FmdnozVWk3Ykp5RnZ0c2ltUld5SUZVdDFzbmduNUp6VXI5RFBsR1ZaZjhr?=
 =?utf-8?B?cmI5ejcxUGVZcjNzdmlEMjcyaFlmZndVKzE2dWxzQURJamhkaUtLQTY4cnZq?=
 =?utf-8?B?d2xiUkpUVXdYODMyTk9ZTUk0U3dTVmhSYmZhZytkcHV2VDFROVIyQXRVTlZj?=
 =?utf-8?B?U3VqMWwyTEN2aEljZEtETkExQVlkT3RwNEVFSFdLNGIrTjZqRE0zbW1yNUtV?=
 =?utf-8?B?TE40ZWJ2eHJWVU1rV0FuTTJtckxoQmQ1VnBXa3dxR0N1MFB1Rko2ejlvbWVQ?=
 =?utf-8?B?cWVNRzRBMFUxd2ZQZnRHb0pYeHJ1Y1FaN3lvYUoxYmxORVRTb1V1RENJYnI0?=
 =?utf-8?B?SzFYbVBwUHIvOWQyTkVpSXV5aTU3bXpsUmpnU0REQ3RlOWJMZ2hYejlSQ3dQ?=
 =?utf-8?B?SDlPeWJVZlRwbGNtVE9tbHZ2dlF6eFg5dnVyTUo5a0t3V3VuVGVhVzBQWWYw?=
 =?utf-8?B?M2FYYXZVYWtPYjBrZDRib1R6N05WMFhwRFpndE9iSVJKWVgrWFNWRzRuRlZ3?=
 =?utf-8?B?MkRYUU43TitkaCsrN3RkMm85bkRaVmVLa2V1eUs2VDl1TGV3TEJFQU1Odndy?=
 =?utf-8?B?R2E2TzJBUmdSVU9UT0ZJbkZ5K01wbkVTejJ0YTZFSDBPYkpicnJsdkNoUUM4?=
 =?utf-8?B?MlhYS2o0YWFvMU5Eck8wNmhNMFgwVUJkTzZUcVNQbzBHbnpwTk1oblFYR2p2?=
 =?utf-8?B?TUhXaXhaMGpFdlhHcEJJWFg1UHc0OTk3eEhiS2dtMkxaM2VreGtjUmtUWW53?=
 =?utf-8?B?YURhN0JJcXVvNjJtYk5tV0J5amx6VzRiaGhTT1ZncWVUa2xNVHBFY0U2RDNh?=
 =?utf-8?B?RVRseDNlZWp6cHRuajdtQkRXM1BSZ0ZQY2lsMW9LUHlOaENLOXNHWWo1OGRv?=
 =?utf-8?B?aHJFMGYzVExmcHJ2eUk1ZFBONUZmVnRXaFFpUzluREJ3ZVJzeEFtVXhnUVY4?=
 =?utf-8?B?OFVrSkNDb1h0dkZ1YlhKZ1krWkdIYjNMVWZTZHJpQW4wMUE1N1BadEQ4WDY0?=
 =?utf-8?B?K25oOWlGaWxLTnlXbFcvQ21rN3JDWkpIaTQwaXRFUTJTbDZWczhuZjE4MGtq?=
 =?utf-8?B?RmNSWXBoTTkxckM5TFQwdWcxUFVQU21sRzV3S0c1M25KRG9GRGlVKy9PWElW?=
 =?utf-8?B?VHFqdkN1NXZiV2FPSVdPeWlPNFlhZlIrZkJ1L002emNPcEV4eUtZT1ZGcysz?=
 =?utf-8?B?M05ZZ3BtaURsY0VzWlNpS1doWVNxQWZQdHN2VE85NzRvU1dBS1oyL1pkY3Bm?=
 =?utf-8?B?dlBNcVRBVC9BczB3ankzVHl2K1UwKzhGSE1lVXVEYWw1cnJBQjg2OVM5TmN2?=
 =?utf-8?B?cG5kYXRSYTBUWmJvcEJvWGxGekl2L2J4UGRET0J6RmgzN2RmVFRFSHRicTYy?=
 =?utf-8?B?MTVtNVA4Q1dLWUZxUFRvV2lkM3Bnd1lGRGVlSDVvYUE2T0tpdUNLRnJGdUhW?=
 =?utf-8?B?SnNOME50TjFJakIzaWcrS0QvdWhIWkhINnNzTHozWEZYMkdGRS9uS2VRMTdq?=
 =?utf-8?B?OHRsWEl5aGRtME1nMStzVkJsK0o2WW15NURHTFU0U21nbUg0ai9oNmMranJo?=
 =?utf-8?B?M2JsTnVIZVFsd1U4Smh6a3FqZDRMVG80Z3VCN2Z5YUZCNlB4SnVvTlFJdERR?=
 =?utf-8?B?YkNQeEV5VEN5YTJVWFJncDJzZWZ6akM3dUw1N2I5WFpNUFJEWWY5VFh2empz?=
 =?utf-8?B?aXZLZ1FTeDZPWEhZVkdUUlA1M2xBdkFoUnNKWTl1Q2ZTSTJ4NzhRbCtFV0d2?=
 =?utf-8?Q?MnChEwWkRLVPuSjCH/NJ+wQ2O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3071f378-6a2d-4940-6262-08ddf1edf0b4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 11:17:20.5982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKY/jhgK/8PK+aNDLbZskor/rYLBeiV3/3il/WLWJPfH7i5QYS6jS0AK6LaLrF1l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762
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

On 12.09.25 11:31, Jesse.Zhang wrote:
> The current user queue implementation uses a dual-mutex scheme with
> both per-device (adev->userq_mutex) and per-process (uq_mgr->userq_mutex)
> locking. This overcomplicated design creates potential deadlock scenarios
> and makes the code harder to maintain.
> 
> Simplify the locking by switching entirely to the global adev->userq_mutex
> for all user queue operations. This approach:
> - Eliminates potential deadlocks between the two mutexes
> - Serializes all user queue handling at the kernel level
> - Provides adequate protection since user queue operations aren't
>   performance-critical paths
> - Makes the code more maintainable with a single locking scheme
> 
> Key changes:
> 1. Remove uq_mgr->userq_mutex entirely from amdgpu_userq_mgr
> 2. Consistently use adev->userq_mutex across all user queue operations
> 3. Add proper work flushing in amdgpu_userq_ensure_ev_fence() to
>    prevent races when ensuring eviction fence availability
> 4. Maintain proper locking order throughout all user queue functions
> 
> The serialization of all user queue operations is acceptable since
> these are management operations that don't need high parallelism.
> 

Absolutely clear NAK to that.

This also serialized eviction handling making it completely useless.

The global mutex should only be used when new clients open up their connection for the first time or closes the last reference and never otherwise.

Regards,
Christian.

> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |  7 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 32 ++++++-------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  1 -
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  5 +--
>  4 files changed, 16 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 23d7d0b0d625..d6a07fac7df2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -105,9 +105,10 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>  	struct amdgpu_eviction_fence_mgr *evf_mgr = work_to_evf_mgr(work, suspend_work.work);
>  	struct amdgpu_fpriv *fpriv = evf_mgr_to_fpriv(evf_mgr);
>  	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
> +	struct amdgpu_device *adev = uq_mgr->adev;
>  	struct amdgpu_eviction_fence *ev_fence;
>  
> -	mutex_lock(&uq_mgr->userq_mutex);
> +	mutex_lock(&adev->userq_mutex);
>  	spin_lock(&evf_mgr->ev_fence_lock);
>  	ev_fence = evf_mgr->ev_fence;
>  	if (ev_fence)
> @@ -118,13 +119,13 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>  
>  	amdgpu_userq_evict(uq_mgr, ev_fence);
>  
> -	mutex_unlock(&uq_mgr->userq_mutex);
> +	mutex_unlock(&adev->userq_mutex);
>  	dma_fence_put(&ev_fence->base);
>  	return;
>  
>  unlock:
>  	spin_unlock(&evf_mgr->ev_fence_lock);
> -	mutex_unlock(&uq_mgr->userq_mutex);
> +	mutex_unlock(&adev->userq_mutex);
>  }
>  
>  static bool amdgpu_eviction_fence_enable_signaling(struct dma_fence *f)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index b649ac0cedff..af92450ea6eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -198,17 +198,18 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
>  			     struct amdgpu_eviction_fence_mgr *evf_mgr)
>  {
>  	struct amdgpu_eviction_fence *ev_fence;
> +	struct amdgpu_device *adev = uq_mgr->adev;
>  
>  retry:
>  	/* Flush any pending resume work to create ev_fence */
>  	flush_delayed_work(&uq_mgr->resume_work);
>  
> -	mutex_lock(&uq_mgr->userq_mutex);
> +	mutex_lock(&adev->userq_mutex);
>  	spin_lock(&evf_mgr->ev_fence_lock);
>  	ev_fence = evf_mgr->ev_fence;
>  	spin_unlock(&evf_mgr->ev_fence_lock);
>  	if (!ev_fence || dma_fence_is_signaled(&ev_fence->base)) {
> -		mutex_unlock(&uq_mgr->userq_mutex);
> +		mutex_unlock(&adev->userq_mutex);
>  		/*
>  		 * Looks like there was no pending resume work,
>  		 * add one now to create a valid eviction fence
> @@ -362,12 +363,12 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>  	int r = 0;
>  
>  	cancel_delayed_work_sync(&uq_mgr->resume_work);
> -	mutex_lock(&uq_mgr->userq_mutex);
> +	mutex_lock(&adev->userq_mutex);
>  
>  	queue = amdgpu_userq_find(uq_mgr, queue_id);
>  	if (!queue) {
>  		drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Invalid queue id to destroy\n");
> -		mutex_unlock(&uq_mgr->userq_mutex);
> +		mutex_unlock(&adev->userq_mutex);
>  		return -EINVAL;
>  	}
>  	amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
> @@ -388,7 +389,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>  		queue->state = AMDGPU_USERQ_STATE_HUNG;
>  	}
>  	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
> -	mutex_unlock(&uq_mgr->userq_mutex);
> +	mutex_unlock(&adev->userq_mutex);
>  
>  	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -478,7 +479,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  		return r;
>  	}
> -
>  	/*
>  	 * There could be a situation that we are creating a new queue while
>  	 * the other queues under this UQ_mgr are suspended. So if there is any
> @@ -486,7 +486,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	 *
>  	 * This will also make sure we have a valid eviction fence ready to be used.
>  	 */
> -	mutex_lock(&adev->userq_mutex);
>  	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>  
>  	uq_funcs = adev->userq_funcs[args->in.ip_type];
> @@ -588,9 +587,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	kfree(queue_name);
>  
>  	args->out.queue_id = qid;
> -
>  unlock:
> -	mutex_unlock(&uq_mgr->userq_mutex);
>  	mutex_unlock(&adev->userq_mutex);
>  
>  	return r;
> @@ -820,11 +817,12 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
>  {
>  	struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, resume_work.work);
>  	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
> +	struct amdgpu_device *adev = uq_mgr->adev;
>  	int ret;
>  
>  	flush_delayed_work(&fpriv->evf_mgr.suspend_work);
>  
> -	mutex_lock(&uq_mgr->userq_mutex);
> +	mutex_lock(&adev->userq_mutex);
>  
>  	ret = amdgpu_userq_validate_bos(uq_mgr);
>  	if (ret) {
> @@ -839,7 +837,7 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
>  	}
>  
>  unlock:
> -	mutex_unlock(&uq_mgr->userq_mutex);
> +	mutex_unlock(&adev->userq_mutex);
>  }
>  
>  static int
> @@ -919,7 +917,6 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
>  			  struct amdgpu_device *adev)
>  {
> -	mutex_init(&userq_mgr->userq_mutex);
>  	idr_init_base(&userq_mgr->userq_idr, 1);
>  	userq_mgr->adev = adev;
>  	userq_mgr->file = file_priv;
> @@ -942,7 +939,6 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>  	cancel_delayed_work_sync(&userq_mgr->resume_work);
>  
>  	mutex_lock(&adev->userq_mutex);
> -	mutex_lock(&userq_mgr->userq_mutex);
>  	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
>  		amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
>  		amdgpu_userq_unmap_helper(userq_mgr, queue);
> @@ -956,9 +952,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>  		}
>  	}
>  	idr_destroy(&userq_mgr->userq_idr);
> -	mutex_unlock(&userq_mgr->userq_mutex);
>  	mutex_unlock(&adev->userq_mutex);
> -	mutex_destroy(&userq_mgr->userq_mutex);
>  }
>  
>  int amdgpu_userq_suspend(struct amdgpu_device *adev)
> @@ -975,13 +969,11 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
>  	mutex_lock(&adev->userq_mutex);
>  	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>  		cancel_delayed_work_sync(&uqm->resume_work);
> -		mutex_lock(&uqm->userq_mutex);
>  		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>  			r = amdgpu_userq_unmap_helper(uqm, queue);
>  			if (r)
>  				ret = r;
>  		}
> -		mutex_unlock(&uqm->userq_mutex);
>  	}
>  	mutex_unlock(&adev->userq_mutex);
>  	return ret;
> @@ -1000,13 +992,11 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
>  
>  	mutex_lock(&adev->userq_mutex);
>  	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> -		mutex_lock(&uqm->userq_mutex);
>  		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>  			r = amdgpu_userq_map_helper(uqm, queue);
>  			if (r)
>  				ret = r;
>  		}
> -		mutex_unlock(&uqm->userq_mutex);
>  	}
>  	mutex_unlock(&adev->userq_mutex);
>  	return ret;
> @@ -1031,7 +1021,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  	adev->userq_halt_for_enforce_isolation = true;
>  	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>  		cancel_delayed_work_sync(&uqm->resume_work);
> -		mutex_lock(&uqm->userq_mutex);
>  		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>  			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
>  			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
> @@ -1041,7 +1030,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  					ret = r;
>  			}
>  		}
> -		mutex_unlock(&uqm->userq_mutex);
>  	}
>  	mutex_unlock(&adev->userq_mutex);
>  	return ret;
> @@ -1065,7 +1053,6 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  		dev_warn(adev->dev, "userq scheduling already started!\n");
>  	adev->userq_halt_for_enforce_isolation = false;
>  	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> -		mutex_lock(&uqm->userq_mutex);
>  		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>  			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
>  			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
> @@ -1075,7 +1062,6 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  					ret = r;
>  			}
>  		}
> -		mutex_unlock(&uqm->userq_mutex);
>  	}
>  	mutex_unlock(&adev->userq_mutex);
>  	return ret;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index c027dd916672..2d63308d55c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -89,7 +89,6 @@ struct amdgpu_userq_funcs {
>  /* Usermode queues for gfx */
>  struct amdgpu_userq_mgr {
>  	struct idr			userq_idr;
> -	struct mutex			userq_mutex;
>  	struct amdgpu_device		*adev;
>  	struct delayed_work		resume_work;
>  	struct list_head		list;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 95e91d1dc58a..daf3be92a39c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -464,6 +464,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  	u32 *bo_handles_write, num_write_bo_handles;
>  	u32 *syncobj_handles, num_syncobj_handles;
>  	u32 *bo_handles_read, num_read_bo_handles;
> +	struct amdgpu_device *adev = userq_mgr->adev;
>  	int r, i, entry, rentry, wentry;
>  	struct dma_fence *fence;
>  	struct drm_exec exec;
> @@ -557,14 +558,14 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  	/* Create a new fence */
>  	r = amdgpu_userq_fence_create(queue, userq_fence, wptr, &fence);
>  	if (r) {
> -		mutex_unlock(&userq_mgr->userq_mutex);
> +		mutex_unlock(&adev->userq_mutex);
>  		kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
>  		goto put_gobj_write;
>  	}
>  
>  	dma_fence_put(queue->last_fence);
>  	queue->last_fence = dma_fence_get(fence);
> -	mutex_unlock(&userq_mgr->userq_mutex);
> +	mutex_unlock(&adev->userq_mutex);
>  
>  	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
>  		      (num_read_bo_handles + num_write_bo_handles));

