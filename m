Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C00D58CC9
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 12:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C96C510E15B;
	Tue, 24 Mar 2026 12:39:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0OFCKsUV";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D98EC10E15B
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 12:39:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcQi2L2j12Zu2vzdLy61bwVRbdA9u1ZqBKNJb+FqrAPddlFg4EiHJjz9XPhOTcU3PfOeMvyabOAVjETzIWP/TRm1BdGMZ/EX40qXjKUg9jIxY+UcHluSm12g+UbXLBROiq9xK2rI6r2uJ+OfRNJ1jop3AzPMuQ7V7o/y8pNHDtiIElwGmftjojkerIFxdwhCjRTUgnrCi8ZyvnwKKZeN18sMneyKe1BFQAFa0Yt/eLYtiaSFt8TtqKq3PyAO35OM+g7ogcrTX0KoMQWsq4xplIN6MLnVoc8g6SUBJ5FJ9e+iIhNHV5rX7kw51Ww/2plW4JQv8N9Uzq6wSqAQGsTu+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dok30nQ5+gwLOe8kOSSKwejdDsgNL55HxlN7R7/fSgg=;
 b=aGk5FBS5qJNkCt6KclvRb0ahgh0bRdDQUmz+FD0sZRLAZHJR8ZpMZ0G/zT7fMU8uvCh25YO6Osu2T8VmauuNFC1Qy3Tu+g0y+ZWsZ3nULjwMsN2NsD7ryHdm3dT0WXoRS0lAebYyyocUlAeslRB8KC5N7mNQrI8S+48mV0CYXDfD8xsoUcLJbzG71dy+q4E96bsutUL6ejwkj6C9Dvrhnl2MNh2vwqltV7eCUsO30rDjKqAOYnbKrS8H3/sHKNGFMXBpBKq0HTCLAXPnzS28vWRoOkBipIAOwq48LfCqW+lm53TK7YG/K5/efo5nASoOY9EFwcZhkijt532wQSWEGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dok30nQ5+gwLOe8kOSSKwejdDsgNL55HxlN7R7/fSgg=;
 b=0OFCKsUVCE/FLH+aZATjYZKLucNs8ykiqCxJ3VsyqZQ3jn0tOYbpb9xZQShyve+oPJewvyx5S7KBoZ/+1jwC5fbZbpbEkjz1bLrajrzytA4ar/GLANmLGrUeI1g4xum3O3XxRcXdKTfxhijV2yBJNE/tsdvxwNID1Phg/c8zw58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS1PR12MB999187.namprd12.prod.outlook.com (2603:10b6:8:495::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 12:39:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 12:39:30 +0000
Message-ID: <a60a281e-e507-474b-b05e-732730c7c450@amd.com>
Date: Tue, 24 Mar 2026 13:39:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v1] drm/amdgpu/userq: dont use goto to jump when at end of
 function
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260324075149.622626-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260324075149.622626-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:208:d4::45) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS1PR12MB999187:EE_
X-MS-Office365-Filtering-Correlation-Id: 5daf4f40-cdbd-4bab-9bb0-08de89a264cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: en+1rYv7eJf2xdV8yE7PRb1ppwwibfbYpWsUB4MKyy4nHhANL89NQRvSdxN1KO0qGf3wJ7hXzxdyds6d9e1fP6ro/nfMjbjiPLiHre8zsKygSYsVPXh+PRWinTSXLwV1E4Z/K9pANB6MQ7Jcl8Jc0O3pNCk9FWCTorGD+IWic5uHepw7fdSJ+GD6WKbzuTcBiWgeYgwbt5HlSSsg9WoA9cMf1TnHYdWA6YaKdy72SqbN4cpa2UtBOIdNqTQf5twniJSUPq7sxA3+H98YyiIhvw1zpm9OjDUg+H1dJwycMEqEc3jBv2nk9LPZ72CNZOSsZUqAHAn5vp+d5jyowAXJCJIHdW0plN0zty80RlO9AGZYjKZTsFxXPy7cbwdw0hdo5Y+lRxVheV5lZT0F6moW4PszHBJpbYLmXBB9lY0VlNmGn1V7QSqc4TB2yRBEWJyZ0q7Z8sMsyZ/UFidDbv6sSYw+0HBsUxeuY1SFpCDXUTtE9LyF5p8K4ztnWlZjcZor4HWXIMcM23MX8JYOPKOfEx+9UzqgQvH77NnpA7wdVtesYmFBsrr10OfrIE1W42c8nfiiHvM3VUhoZyA4jyIeJlYhwAyvXOcFGZUVYVVwDcNBd1WvhOyDG7DGaRZjuZAxaM+aiz9BYaJP/I4uY9qZiX3uwPYbxpvwH1BSxFWCRZmIn/+xaXmb+ksz6SrmSFRK+gldtTNhE1ujI0a98jOLDnpDsWiqpnlotAXvLC6VOqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2xtTFI3UlRWWDFxdWVsUmd3L3V1MUFZSkhRQTg3NzJIVzJNQmh0NEIxNDBl?=
 =?utf-8?B?VXFsZTE0aWJCNUFucXpaZ05nVzZIbXgwZ3JKVmxXL08rbjMxMC9QVkp0YURH?=
 =?utf-8?B?RlMzWlJoOXdkOTlTQ3BVUmcwZFNaODZ4ZlV5T1VHb2V3aXhtZGhUUkpFeUdw?=
 =?utf-8?B?c0pNdkUyWTZzYmFXL0N4MmVTZkJRSEhVUVdyK3VwTkF1bjdwcTBEemZpZWF2?=
 =?utf-8?B?d3RGSXYyUmRQeGFaai93MUR4NUMyVjRLbmtXdkdmVUllOXh5Mi8yUTJVUUNm?=
 =?utf-8?B?TE9MU2s5VEtvSWY5eStFMzBJdFI5aDFlZExZcFk2MnJPS0ZjVitvUEFvTWw2?=
 =?utf-8?B?QldtNHRBQXNhb0hBNXQ0bEhFanRsRHdqOXNJU3RFS2d3dmh4VEY2bVpWb3py?=
 =?utf-8?B?aXppbmo0MlVDTFhGY2lHUVNkb05zKzdlaUJNSG9Eblp2SXFrYXRkdUlpa1BP?=
 =?utf-8?B?aEJOekJqRllqR0dVK1R0aWFNeVBVNnZJV1ZGTkJoL3RmMVdSQlRhR3llQU83?=
 =?utf-8?B?WkdRaERwN1V1dFFDeFV4M3dKTDc2aXhpSG5GOTZPbkxIbTMvazdMMTZoUXpu?=
 =?utf-8?B?SWdMNjhLRTdhNkI3Yzd2bHNZcmV4Y2VNTkxkSk5qTjBrbjhTMkVDYVFxTkRp?=
 =?utf-8?B?UlB3OVE3OXlDNGtHMGRSUHhiUVNpcmt4R1J1MnF0RVhsRTBPRlBCdTAxK1hX?=
 =?utf-8?B?VkNSTDhpa0FnbjNqRjk3dGRzdlpPM0ZwU1pFU2l0WW5NTXB1Q3d6R2pZckps?=
 =?utf-8?B?OUtiWVFLSjJSazFEeWZmMm1EeTBzeVY1amVHYnk5b3E3aG1HSThoeEE2ZnFl?=
 =?utf-8?B?QjA1UUpQdzhjMHBuRmUrRjArMUtGTEpkdXFQTk5WTjVyV0MyTmJWcXJBdjlD?=
 =?utf-8?B?SFRtU1VzdThwU1FQdzMxRVhxMVdmMXAvTXEvQXRqVGxDNllsMlVvRzhBM25u?=
 =?utf-8?B?N29ST3JSdVA4bk9KS3NlRTBYYUpVNit3Z005UVRsZEtFSE5BZ3U5YUV6WVpE?=
 =?utf-8?B?Qi9qejZnajUvbGxXbDhEUVBiK00zOEdMWnhwTlJPYzZqcGFYWlJSTjgrckJE?=
 =?utf-8?B?b2hRWXV0WXpOM05GZGtRRFh3Ym9Cam1UV3I5SnRidDdOTG5uSm1PY3ZLWFhI?=
 =?utf-8?B?cW1vV1hZc0d4d0k5eVpLWTgrdmx4alpFaTEzd1haKzFBZTBrMDNrbExyYWNq?=
 =?utf-8?B?VXdyblNXeTB5dmQ2elM5N2Q2VWZEVVZMSE9UYUpxSmNmRmtITkxFcmdOMW8y?=
 =?utf-8?B?WVlUTzQvOEprSDJjdGM5T2d1ZHp1UkJzcXc1aTZ0UGtpS3FKdDZ0MUtBRm1Q?=
 =?utf-8?B?VlFUWHl3Y21qTkM4bFpUSTdCNXc3aVNvR2w3dXBYcHVBUlNhZUJmNnZHNlhr?=
 =?utf-8?B?NGxVOHE0bGFoZmdUTUcya1NOOEtxdHdGUHNNNE56S2I3MmwwUTZjWCtma2x4?=
 =?utf-8?B?Rm1SNnV2SWhraXgrSkFBcFRBZ2ZUQjl2YTQ3cWcvci8xWDI4Y1RkQk1ObzQ1?=
 =?utf-8?B?bnBtRXcrL3RHZk5mSWFsdVJFQ2pnUlo4ZDZDNW1FYThkdDRmN0xaYUtqbDFi?=
 =?utf-8?B?UnZ4Yk0ra2ROWit4bWh1cU8ySm1NZk1UWGQ0UlhUWGpkWmgyaTY2OEhLWVVI?=
 =?utf-8?B?bTczY3FCdTM2YlVxNGc4eFF6b2dKbGJCSS9kalBwak5tU3NIRzJnTGlkNXYx?=
 =?utf-8?B?M1ExMjVXQ1ozTENsbElUZGlJMElqc3p2bDJLcGUyYUtMaFg2dk5NM1IyK1dr?=
 =?utf-8?B?NXE3bGdUTUk4V2hMV3pZc0FmRUlqb1Jybi9LbUorVDNTZnM1RW5aM1h3R2ZR?=
 =?utf-8?B?TWtXQ2lWVXZQaDIybDVxM05iWGxOTFJWa0cxaEJCL1FxZnA5R0R6aXliMHJ1?=
 =?utf-8?B?cjdRT3Bnck9BZWgxc0NXSEdCT0N4SXROaHdsZmxwQUFkcUdhQjNkeVppUFFi?=
 =?utf-8?B?VmkxNzZlNklBMndPalYwUTBuYnpKME5qMFYwMWJpZEx6TW1kTCtwNlBUZzhT?=
 =?utf-8?B?dVRNaFhZV2kwcytEZDlwdG4vMnFOUnJxWXQyMkxTYkZJSkpCWnptdklMZU8z?=
 =?utf-8?B?aEdwK0xwK3pTYXcrVGo1eUoybFJYUXVYakZkbFZ5RE5zaVF2WTlyWTlaMitw?=
 =?utf-8?B?VUwyRk0xZSt4aVFpSE1ReHd2OGFiQjRLSVBtOWd6WnFNOHVyamhkS3Z3WkI5?=
 =?utf-8?B?SjdiVUdicDNJNlBtMDdacVdHVGNzd2psNEE0eVVkRlNReXpqLysvYlJ4eXVI?=
 =?utf-8?B?VU1SL2hNZllidWpwazhmM0xOU1FRbStvVjBoUldkYWtvY0ZINzArZVFpWjZG?=
 =?utf-8?Q?in7kUfz6AMxQjS1Z22?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5daf4f40-cdbd-4bab-9bb0-08de89a264cf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:39:30.3677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acAx996vBRW9y1CBMy0opXMhuZYgBN6P3mH8CL3mwjFxtH9G1HiFEhvQ3+fF10jK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR12MB999187
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

On 3/24/26 08:51, Sunil Khatri wrote:
> In function amdgpu_userq_restore_worker we dont need to use
> goto as we already in the end of function and it will exit
> naturally.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index eb07ed078bfa..a351383b432b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1227,10 +1227,8 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
>  	}
>  
>  	ret = amdgpu_userq_restore_all(uq_mgr);
> -	if (ret) {
> +	if (ret)
>  		drm_file_err(uq_mgr->file, "Failed to restore all queues\n");
> -		goto unlock;
> -	}
>  
>  unlock:
>  	mutex_unlock(&uq_mgr->userq_mutex);

