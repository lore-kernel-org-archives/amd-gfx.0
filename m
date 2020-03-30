Return-Path: <SRS0=xvO7=5P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CC8C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 13:00:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D47BD20733
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 13:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aeXsm8i2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47BD20733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93E1C6E2A0;
	Mon, 30 Mar 2020 13:00:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C183C6E2A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2020 13:00:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmuBzRrA7anc2h9CA7ekLTo8f/q9vqCXRJbilpi1UEowjLkLbOBQf8gqqz6T6ISNmtSjABFm1PTvc0Rs2DvW05BSuo8hzbg3w7HuzeCN4DdW9Kr9DkMnO4HPFOFikEVVsERthnXOM2qFddbNEAFEPb3b99P8HBzexuaIdimZqYHxpGfbbnE0EKXLcPXTDxqP2GJ/vmkwO1LIGc1IxdhCsUQuEAmEb5HqYn+INOIcGE1dyz1HRDXK9bQXUr77GFV5Og+yc0c5yS56YF+3aMqnm0RJ9sovVq9KFAsz9Szi8I1tCRzp26Qxkiu2/Ec5nWfpfMIVNwCxYBIJpANE4gmi6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wkQliGikcN28wQMUrA+ce6nX7tqZhI+ZhKhOMFl/DM=;
 b=d0DOwq/hAWwmOTZD+valpL9A7DAxp8HxGQ7DB2F0XLk3sUzs6ZiLM+KSgasDus2dwy4J5nc3cYZMTq02PUiM7lDw9VhO0dtk1wMNMCqf1XYpyMWIKLgYSxd2/sIbPgf20XLre5pROMXRJz6MNi+JMSurinz0EmKMZHBbo2qqHfgiW69Ct0ovws1sRE/cYCLKkDEn+NgqhQ0G2DVzK/ptyMS/11P1lgGfG9Au+ryzAhq7aplA4GtT4KpdykawaGGe0FeJ8fxXwfkE+SoaE1Fo7kXGHkaGmmnnjAGFOpM6Mp78icjQxENdoeBKnDDO1gIvGdnlO0BE1X4EICwMLtyjsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wkQliGikcN28wQMUrA+ce6nX7tqZhI+ZhKhOMFl/DM=;
 b=aeXsm8i2SDJ+u0fiYXg9j/L8wxue2uwsiiRfAhUW3lj4aTv7E8f2xs7X5N4q7B3NdQzWbJbq0eLcAZ1mXoQThng7Xkq5N6zfGdVKEQnpS8HjO7DBfkET1l+O/F8Nah9KjYrORk5/zNeX+PS/X9nnQHGX2PGkadmHE6/68c0lw6g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB2629.namprd12.prod.outlook.com (2603:10b6:a03:69::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 13:00:04 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::e8:c007:9a5:da4d]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::e8:c007:9a5:da4d%5]) with mapi id 15.20.2835.023; Mon, 30 Mar 2020
 13:00:04 +0000
Subject: Re: [PATCH] drm/amd/display: add basic atomic check for cursor plane
To: Simon Ser <contact@emersion.fr>, amd-gfx@lists.freedesktop.org
References: <67AgM0yylniATabNxt8ct_5KATDTAwvscoDJBJxA3cm0vb0LJvyUM9VAX4r6Ib5Vxykoy9AN0G1uyZO8q00_RvTwmaimmGNQ3hZYoWKXZAo=@emersion.fr>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <83db678a-a5d2-cf64-65f0-8fece62b2fbd@amd.com>
Date: Mon, 30 Mar 2020 08:59:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <67AgM0yylniATabNxt8ct_5KATDTAwvscoDJBJxA3cm0vb0LJvyUM9VAX4r6Ib5Vxykoy9AN0G1uyZO8q00_RvTwmaimmGNQ3hZYoWKXZAo=@emersion.fr>
Content-Language: en-US
X-ClientProxiedBy: YQBPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::25) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.204] (24.212.165.133) by
 YQBPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.18 via Frontend Transport; Mon, 30 Mar 2020 13:00:03 +0000
X-Originating-IP: [24.212.165.133]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b36c135-4042-4bd2-0465-08d7d4aa43ca
X-MS-TrafficTypeDiagnostic: BYAPR12MB2629:|BYAPR12MB2629:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2629A6EB9B0D472BAF89017BECCB0@BYAPR12MB2629.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(31696002)(52116002)(54906003)(53546011)(81166006)(316002)(8936002)(6486002)(81156014)(4326008)(16576012)(2906002)(6666004)(8676002)(16526019)(186003)(966005)(26005)(66946007)(478600001)(66476007)(66556008)(956004)(86362001)(31686004)(5660300002)(36756003)(2616005);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VlST6cC23Uuv4vBVzLFB1EpF3eL8k4u5LOLcVADz74RHFKe1smNXZN4wBCY4c9QoWmoT5A3A4CteJKkQ3w4rThonE7pcNURzAuofTTGTcdZbdMQPaEPZp2BqV18HbMYh6tQ+/FFVT4rGpBz1B+Zgy6RBd98Bi2n1v/TqjEhq3U2bBxFiSBuZMsQ+0oJEwxtCUYR2ge3X8R6COddev2YNeF9vPDGl5PNhRXPC3IQhja2XWjMC1/bE4aoKCTpHmogPQskJW1c5WtrD8c4MQTfsVRdBnCk/McaMfxudpT3ljwf8uNruiO2vJLXZXX56RiROtEgqyMa/7wzrQEQNIaRhdyykqa1c9k7R+mTZeVtIGZ6QHUBrAXGZdpBZGekIA8qg/EB4OhGSVnQfdcnt4Mq1QZhKULdE1Qbkv3m+6bwm+J1EyaM+iH27OZrSHxEfno52vvFkRnq/uIL2cnxp2SAYinUyaMyUEmcxQ390oB4+4nOfVjTof/dNCKjuB5lehUL007b30jw8XMGqpNHK5os+2g==
X-MS-Exchange-AntiSpam-MessageData: kBmx8sRxsCznZq42gdD6dnoE6lNbRQt+3LRrKwL/AjIQMkZO28zTS4COgE4tQvlnTZoyORo2vnxdDmoYWdYSOB3+epJ4mjBiYl9gsVt0PYcUouHnrPg7MttEB0BNIFoIcn6tdlR5RUTtz2T7TBgwOQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b36c135-4042-4bd2-0465-08d7d4aa43ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 13:00:04.5444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mGpBXkgpp+83efYCK5+LU/VGYH+1WcYUVjHW5LebUlHuFdl9PeVp0YBbB6uiqLfxGIC5yV4MGhriMmfgGkPag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2629
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Roman Gilg <subdiff@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-03-30 5:23 a.m., Simon Ser wrote:
> This patch adds a basic cursor check when an atomic test-only commit is
> performed. The position and size of the cursor plane is checked.
> 
> This should fix user-space relying on atomic checks to assign buffers to
> planes.
> 
> Signed-off-by: Simon Ser <contact@emersion.fr>
> Reported-by: Roman Gilg <subdiff@gmail.com>
> References: https://github.com/emersion/libliftoff/issues/46
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 26 +++++++++++++++++--
>   1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index f6b0b9a121fd..e1b084318ad6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7843,6 +7843,7 @@ static int dm_update_plane_state(struct dc *dc,
>   	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
>   	struct dm_crtc_state *dm_new_crtc_state, *dm_old_crtc_state;
>   	struct dm_plane_state *dm_new_plane_state, *dm_old_plane_state;
> +	struct amdgpu_crtc *new_acrtc;
>   	bool needs_reset;
>   	int ret = 0;
> 
> @@ -7852,9 +7853,30 @@ static int dm_update_plane_state(struct dc *dc,
>   	dm_new_plane_state = to_dm_plane_state(new_plane_state);
>   	dm_old_plane_state = to_dm_plane_state(old_plane_state);
> 
> -	/*TODO Implement atomic check for cursor plane */
> -	if (plane->type == DRM_PLANE_TYPE_CURSOR)
> +	/*TODO Implement better atomic check for cursor plane */
> +	if (plane->type == DRM_PLANE_TYPE_CURSOR) {
> +		if (!enable || !new_plane_crtc ||
> +			drm_atomic_plane_disabling(plane->state, new_plane_state))
> +			return 0;
> +
> +		new_acrtc = to_amdgpu_crtc(new_plane_crtc);
> +
> +		if ((new_plane_state->crtc_w > new_acrtc->max_cursor_width) ||
> +			(new_plane_state->crtc_h > new_acrtc->max_cursor_height)) {
> +			DRM_DEBUG_ATOMIC("Bad cursor size %d x %d\n",
> +							 new_plane_state->crtc_w, new_plane_state->crtc_h);
> +			return -EINVAL;
> +		}
> +
> +		if (new_plane_state->crtc_x <= -new_acrtc->max_cursor_width ||
> +			new_plane_state->crtc_y <= -new_acrtc->max_cursor_height) {
> +			DRM_DEBUG_ATOMIC("Bad cursor position %d, %d\n",
> +							 new_plane_state->crtc_x, new_plane_state->crtc_y);
> +			return -EINVAL;

We've been doing these checks for position before but I don't think we 
really need them. DC should be disabling the cursor when we ask for a 
position completely off the screen.

I think that's better than rejecting the commit entirely at least.

Nicholas Kazlauskas

> +		}
> +
>   		return 0;
> +	}
> 
>   	needs_reset = should_reset_plane(state, plane, old_plane_state,
>   					 new_plane_state);
> --
> 2.26.0
> 
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
