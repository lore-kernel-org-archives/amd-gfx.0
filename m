Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96118C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 18:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4332561AAD
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 18:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4332561AAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E55B86ED02;
	Thu, 21 Oct 2021 18:19:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE7586ED02
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 18:19:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqRbPjVbGN6tUl9YrvFtOjXmyRAHbCa+S2OUPH9ZisvTvCfwAPYyac2zDE86dHTN38lZaK2WsdImCF8jmALY0GnYo1SPxc4SwEktcLA02gJOMTt1FnZIoZem5yUfut3bHMOoVm0SqxoAxOWLDHs8zeoM2fA7jUAgo92JdzGZjyDNXHsUoWeGAMocssx5hpDdHHAVfJySSBIHRSBVHdrNp1gLv8Eyq4Pp4EZQaR/l/FJ9WdIWFJ2GF3mXPhOlvgQhdGl9PjMerOFVFe/asJDmN7x4ewiLEH7/UHLOVgqaH4zW1hnwTZpKk3qOt+MzdPZadkhSJ6bHTeBZM/wCYio6mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxC8rmRjsiYNex69CowXP8N6xZJRCw7kBOPzpqDeOog=;
 b=jXq8SZl0di6iUqQm2aBaC0sRZsyeC1gsxf3Rcd1LDwOf1GEojxygSYNtS/I2qE+YGOsXKaU1WHkjDVwQlIZuFrc53eIw2n5Cy1VHlvVDla0CuSlBJRd1Q7J1RyUmmOYDpCC8017EUuykgSljrFxxPIOJbV5QpxyHX8sWiwRkZSk8qJ6AXxR3lyHn+OJll3FH4egPXIGqSR/wb06Lm9HCnDHFcwDyrqJBOe6xPadEnTIULIbh1nt8bMTJ1EgMMcLFAYUP3hhsKK/7Qx2NTJnKvXE8dKobwtJyYhJzXBwoZP0aUMBwr4Q8grMzcj0S4VR8IEa1W8GxsOGV3kW/kgSqpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxC8rmRjsiYNex69CowXP8N6xZJRCw7kBOPzpqDeOog=;
 b=sJ2F/rSHO7kiXciemlLbARqqCotabuBU0JsVnlHfjf20jM2pxDzdH+bFBrXNuzLQRnpU0Ka2ZG+tuB+dqODG8MyDnbY3wE2pUDs60ZW1pH8w6kgA900XJcqktPI4hwN/lW9v1ck430RHZAI+DQK3rdzw2oOxfrMXE/ulPjeKV18=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5490.namprd12.prod.outlook.com (2603:10b6:303:13d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Thu, 21 Oct
 2021 18:19:05 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%9]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 18:19:05 +0000
Message-ID: <25eb363b-e97f-0762-f39a-a8a459ba019f@amd.com>
Date: Thu, 21 Oct 2021 14:19:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] amd/display: remove ChromeOS workaround
Content-Language: en-US
To: Rodrigo Siqueira Jordao <rjordrigo@amd.com>,
 Simon Ser <contact@emersion.fr>, amd-gfx@lists.freedesktop.org,
 Harry Wentland <hwentlan@amd.com>, markyacoub@google.com,
 Sean Paul <seanpaul@chromium.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
References: <20211014153433.169454-1-contact@emersion.fr>
 <f6993cb2-53e0-b4c8-48f2-c5bf4eaaf511@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <f6993cb2-53e0-b4c8-48f2-c5bf4eaaf511@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::34) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQBPR01CA0062.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18 via Frontend Transport; Thu, 21 Oct 2021 18:19:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14846d38-59ec-4422-42dd-08d994bf4426
X-MS-TrafficTypeDiagnostic: CO6PR12MB5490:
X-Microsoft-Antispam-PRVS: <CO6PR12MB549084B7C799493886A4EFA88CBF9@CO6PR12MB5490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dPXhld+rsXHttFXD3+tPvCYBJ7paT+YETViSS758niw7L2lkiaNpdW157+cj3pYD6yHSzzTAEfyffCeROvC8K0HoMnVRQINn0IbASeX15xdKBh5/lMHvVb7S3Vi5uUkpb4znmxCIDUmazWkgXQgGolHISbX8lTBjBRvBF6rAwn4h/HBjPaVC37RJlhzfzIlH2ZzEAKNEm5H/i7kHREHcYb9lS/VP+hygv+HH4UhtcgnukWdjNWw6EWXxwzUIYUxwypNJIeu55ay5InmeUEQR1JOzJMC40ntzlF+WzJqJxU2/S9Z1aaMfOMlGI8WqUMqeGmOnWES4AyXtT4GgAuTlk5SbJDDxMzxurJ4ACnGzeYI3nTVkveIgko8vLMkj3ZHp+S8kEDXzZeUNGmOSb1xUdp1gXNPRf90oidRHhS+c6bAc3TsLTPyrp92Po6y4/S5Thqi5cBptOAuYvlyzIQqmhy40cyDu7Nt8M4f4/zUcrDDVTQAm2jvgHMUYXyWZ99jETY7PkO31dhpSZpAs6axzt7Z/FUP+AG9fYNxeUBq6+URQJmM5gJmprD/VuKxhrbTdjhJrM7D2SdS39/6FrWeBL9e3fndHMGgkxhKUzUoIQfSGgRkLFzFl1hjNC4U9zeaNejbFHJxdfL1tSF9sxStoBctjOfrgI4KwzdpfMYoAYw1GzPzontrp1byV5C8Vctnx7Lgx6X9cog0cM0n0r+w+kxd0UalBAwik3TpiRnHIysWAPjyF//9tDC7lmG7QSM42hP1B4ylxOZ5O9Ff6OD0BqFg/n1TEcnmcXIVa7KSYMxTBHoAD22QyPU1CW5OuvJjGbIPPbMfRXleLGhJz8KWAFGpODswtfRGQvXzIr3SBrHYBisl/ZoiMyMJXKV4awXSI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(110136005)(5660300002)(66476007)(316002)(966005)(38100700002)(36756003)(66556008)(6486002)(16576012)(86362001)(2906002)(54906003)(31686004)(31696002)(186003)(44832011)(2616005)(4326008)(4001150100001)(8676002)(956004)(83380400001)(8936002)(53546011)(508600001)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzNOdE5PQ1krUHhSVWQya0VtSUphQVMxUVZSZ2ViWW9PcVZJVno3akxEb1Fu?=
 =?utf-8?B?ZFZKN3YrNFpiVGdWcVp0b3IrYW5Mdnk0b1ZJaVUxaldMTnN2d2JRd1l3ZWti?=
 =?utf-8?B?WWQzbG00b1ZmbitGRkY4bklydWlxZEt1TkdSblhlanJua0l1WXhMU2pPSmNy?=
 =?utf-8?B?SUtEYllRWUtGWlJXMmxENnNpMGhwMEwyVHJrL1VKblozRk1OV2lvb0ZlelhG?=
 =?utf-8?B?YlZiNWxTNjVRS2VXb1UyendCSThVU3NKM1B2Mlo5Z3VielQxdC9qNEV4SnMr?=
 =?utf-8?B?QStxYnp5bjVET0dZNmp2dUtZMkhYYzFya2xybFJCK3Vhd0pJYXZBbStGYzk0?=
 =?utf-8?B?dXlmNzNiNFNQczQwbkxVZ3dWYXRra01GNm5lUDF0L1NLMm01TVcxUXcwalVQ?=
 =?utf-8?B?QnJ3QThHcGdiQzNNM0tjaDFweUo2Znd4OWY2TXBsamVTYjAraW9uRkhGam9I?=
 =?utf-8?B?Y3FJZ0ZoZnhmSWFUUFlvN3Znemx4N09WL2IyaGhRS2hUcEJXcHBGUm4vYkd3?=
 =?utf-8?B?aUFkdDlXa0l5VmFNa1h5WFJFS3cvV1FvTzV5T2ROUnV4VEd1WHB6Z204dXNO?=
 =?utf-8?B?elhVYUVOMjlSeWF0T3dDaXJ5aSs1RjlhRUdjbTUrK1VTcE9zd2I5eGk4K3ZY?=
 =?utf-8?B?bUhBY2JqSzdodFBJSjZLYm9LM0lsUzNTdWowTVBORE11ditEcmpOUE45Ylll?=
 =?utf-8?B?NTRYWGtOWmxOeFlqZkxGSjFoN2kwcFVNa29wanVWNTV4eVlZQ09Yc1pxNVo5?=
 =?utf-8?B?ZXk0Q0toNERMTVZIZlp0M0lFZ1NBczlETEMrd1c4SDgycFBMTXdJZ3BrVkpT?=
 =?utf-8?B?YjJMZ3VXTGlPbGkzdDZLTVpMVllMaERVTERhVHY3czNyRkh5b21YUk9aa3NQ?=
 =?utf-8?B?TUJrZWptZHRJdEVqRTZKTnBxb2h5MXVlN1RWMEF5WlB0NnBUY1NWN1dsVGFh?=
 =?utf-8?B?UGNMRmR1czdpNjA3eTVIemVTV053Tmo3cGtqQUJFRzA1SXhwQ2ZreHIyU3Jk?=
 =?utf-8?B?WnlYeVVIQ0ZuSUhVNXNzb0Y2cy9ISWUybmtTblJoZ1RwdzZrUDlKWHBsVWEw?=
 =?utf-8?B?ZTByNExVZC8yM2VDdjVvcm9tRWhXUGJEL2o2OG1nK1dlampVekRTYndTazBL?=
 =?utf-8?B?NUxuNk5CMVNsZ0llMDhYNmxYZUNFK3cvZytDY0NKWGY4aFBmcGRiRmJIZHhO?=
 =?utf-8?B?M2gwZlNpeHprK1Qxc2Z0a3huVmlrSW5pVjY1NWJpbnRkdVZjeExvOFUxak8x?=
 =?utf-8?B?YzNsa3RQaFluV3oxVnJWT1ZwczQ0amk0ajV0NkVTYUR6YVd4R0VlMlAwM2g2?=
 =?utf-8?B?WXJpVXlQczBKWFVxN2xFUFQ2K3NjVmlueTVtQk1ZVC9TTWxzZUxIRGNqWlY5?=
 =?utf-8?B?S0JUQWlxYnY1M3Y3cTRoNlRPSzlYcktMYkxmN3UzU2VCYWtNbEdVTnMzTjBn?=
 =?utf-8?B?UUNCSTBJbHVTS3RHV0ZHS3VRSENvcHNyOThhNTA5bVpseVhJZU5vV3d5cXNj?=
 =?utf-8?B?Mk44VzF0MXBVcjY0aFZiRDBOV0Y3VjRUWUR2TGZ6VDIyQWk3M2tQdmJNd0gz?=
 =?utf-8?B?cmMyZDF0Nk5MbCtaMkFUMmsrM2x5ZWdqV01PeW1CV09mNVU1T0JyYWlFOHNh?=
 =?utf-8?B?NFdNNEZLWm5URmRUMnd0MnlBZUZOc1BFVFZpdm1LK0xwaXFpaHNyRUpETGg3?=
 =?utf-8?B?WklENGZUNE5wZmM4K0ZMVXZUWklobzlsM1F1K05ld2I1ZENEYTRESWtja1VR?=
 =?utf-8?B?Uk5VVEkvYzhLdTdCRW1zYWZwaVpoREdhMzVhZXdyWTFlMnJ6VisvcnlEempv?=
 =?utf-8?B?YzVHTU9BSmRZZm1WV0kwcmk3eUdkbGs2Wm5kZXlGM015QkhqL0crZlp1aHZz?=
 =?utf-8?B?WGJhWFBEa3QwaE1DZENXUEhkKzdMc1VONUxDbHFFS1lUaklOZExic0RzUWpy?=
 =?utf-8?Q?wh6ZZy2UaCk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14846d38-59ec-4422-42dd-08d994bf4426
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 18:19:05.5107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwentlan@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5490
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



On 2021-10-21 13:55, Rodrigo Siqueira Jordao wrote:
> Hi Simon,
> 
> I tested this patch and it lgtm. I also agree to revert it.
> 
> Btw, did you send the revert patch for "amd/display: only require overlay plane to cover whole CRTC on ChromeOS"? I think we need to revert it as well.
> 

Agreed that this patch is good but we'll need to also revert the is_chromeos w/a.

This patch is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> Sean, Mark
> 
> For ChromeOS, we should ignore this patch. Do we need to take any action to avoid landing this patch on ChromeOS tree?
> 
> Thanks
> Siqueira
> 
> On 2021-10-14 11:35 a.m., Simon Ser wrote:
>> This reverts commits ddab8bd788f5 ("drm/amd/display: Fix two cursor duplication
>> when using overlay") and e7d9560aeae5 ("Revert "drm/amd/display: Fix overlay
>> validation by considering cursors"").
>>
>> tl;dr ChromeOS uses the atomic interface for everything except the cursor. This
>> is incorrect and forces amdgpu to disable some hardware features. Let's revert
>> the ChromeOS-specific workaround in mainline and allow the Chrome team to keep
>> it internally in their own tree.
>>
>> See [1] for more details. This patch is an alternative to [2], which added
>> ChromeOS detection.
>>
>> [1]: https://lore.kernel.org/amd-gfx/JIQ_93_cHcshiIDsrMU1huBzx9P9LVQxucx8hQArpQu7Wk5DrCl_vTXj_Q20m_L-8C8A5dSpNcSJ8ehfcCrsQpfB5QG_Spn14EYkH9chtg0=@emersion.fr/>> [2]: https://lore.kernel.org/amd-gfx/20211011151609.452132-1-contact@emersion.fr/>> Signed-off-by: Simon Ser <contact@emersion.fr>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Harry Wentland <hwentlan@amd.com>
>> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>> Cc: Sean Paul <seanpaul@chromium.org>
>> Fixes: ddab8bd788f5 ("drm/amd/display: Fix two cursor duplication when using overlay")
>> Fixes: e7d9560aeae5 ("Revert "drm/amd/display: Fix overlay validation by considering cursors"")
>> ---
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 51 -------------------
>>   1 file changed, 51 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 20065a145851..014c5a9fe461 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -10628,53 +10628,6 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm
>>   }
>>   #endif
>>   -static int validate_overlay(struct drm_atomic_state *state)
>> -{
>> -    int i;
>> -    struct drm_plane *plane;
>> -    struct drm_plane_state *new_plane_state;
>> -    struct drm_plane_state *primary_state, *overlay_state = NULL;
>> -
>> -    /* Check if primary plane is contained inside overlay */
>> -    for_each_new_plane_in_state_reverse(state, plane, new_plane_state, i) {
>> -        if (plane->type == DRM_PLANE_TYPE_OVERLAY) {
>> -            if (drm_atomic_plane_disabling(plane->state, new_plane_state))
>> -                return 0;
>> -
>> -            overlay_state = new_plane_state;
>> -            continue;
>> -        }
>> -    }
>> -
>> -    /* check if we're making changes to the overlay plane */
>> -    if (!overlay_state)
>> -        return 0;
>> -
>> -    /* check if overlay plane is enabled */
>> -    if (!overlay_state->crtc)
>> -        return 0;
>> -
>> -    /* find the primary plane for the CRTC that the overlay is enabled on */
>> -    primary_state = drm_atomic_get_plane_state(state, overlay_state->crtc->primary);
>> -    if (IS_ERR(primary_state))
>> -        return PTR_ERR(primary_state);
>> -
>> -    /* check if primary plane is enabled */
>> -    if (!primary_state->crtc)
>> -        return 0;
>> -
>> -    /* Perform the bounds check to ensure the overlay plane covers the primary */
>> -    if (primary_state->crtc_x < overlay_state->crtc_x ||
>> -        primary_state->crtc_y < overlay_state->crtc_y ||
>> -        primary_state->crtc_x + primary_state->crtc_w > overlay_state->crtc_x + overlay_state->crtc_w ||
>> -        primary_state->crtc_y + primary_state->crtc_h > overlay_state->crtc_y + overlay_state->crtc_h) {
>> -        DRM_DEBUG_ATOMIC("Overlay plane is enabled with hardware cursor but does not fully cover primary plane\n");
>> -        return -EINVAL;
>> -    }
>> -
>> -    return 0;
>> -}
>> -
>>   /**
>>    * amdgpu_dm_atomic_check() - Atomic check implementation for AMDgpu DM.
>>    * @dev: The DRM device
>> @@ -10856,10 +10809,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>               goto fail;
>>       }
>>   -    ret = validate_overlay(state);
>> -    if (ret)
>> -        goto fail;
>> -
>>       /* Add new/modified planes */
>>       for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, new_plane_state, i) {
>>           ret = dm_update_plane_state(dc, state, plane,
>>
> 

