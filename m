Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671C3C433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 18:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 240F361041
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 18:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240F361041
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6DD86E2D8;
	Thu,  8 Apr 2021 18:38:04 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750089.outbound.protection.outlook.com [40.107.75.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EE0F88FD2
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 18:38:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvXSRAXHwIW3Jp9loxHx6exzJverJg4kdaw9DVnNAwOrAOVWJV8/wMkc7RGb6b/DC5SyQS2JqrSzIgNclAc2+hikgJaSNShByT1NV9Wim0hLdAkx8RcZFtKFOIRFTiH6J8/i6/ayN3yzZuJxKhjq+p6/vK70KADY8nDSF4kp/NF2Mi/Tf2mDiTnADofrj3QJEJQF83TC+JmN7pqk4BVUL/Wa3L2BZEhmQY7ub0hAzUGYtmgVI2v7uVFLG5VPa44a8cluF0gQEHbBQG0KlDea/fKPwrtNrhxfKu2ke2kgGRpGDt7jomn7DtdEOQSYqLeZDFlVGcML9CdfwdLDcBe+rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XetYjmOmCZ0GiY+PHpuM13TUOC1Sa/HzcaO+eWwxipg=;
 b=j/kS4dg+KUgqWmvCQTBIoPNVbtGK5MF+rb+HWSPBHOkkha4DPlXZgXgS+ZUVhNvyKTpoLybzefEwWprIg+EHS3U+pkDUROtO9bu+u/BNvqOVgO6bUSaLx8nAfw+it+xCAxKdQJdFq9483JH/MdHZxqWH24VsQhCDveHOrT4cpItgQwnfXSj4pFapKLics+zssWP5vOk66uAIEesotrXgEvAReR1wGffysbGhm5TfPznE3Y0J+nD8RgArc6aAdyEFeo4WtT49ZDvbc5jiTT/zm9ZCWZ2IaE3ZqO2RPoTLJdWc8G2RAjKE1XYiUQEm3AOQM1S4rhcpV0k9ZgF5aRMPFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XetYjmOmCZ0GiY+PHpuM13TUOC1Sa/HzcaO+eWwxipg=;
 b=JMZZuRZsN8HkYxVKxlZ7B7TkkBJO/3ZyfgxvWVoQp8pVC3B/2wNy2wtKJweUthGfL6di24nvvk9xyc36O2QYD04fCL7QJV3cukCnc4aiEQYiJuz0FeIgbRiINMSQ9JCnWFUrQ+wLf5qO8C32p1IEaHkQ5Q3zsaP0bwl+exk/mAQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MWHPR12MB1869.namprd12.prod.outlook.com (2603:10b6:300:111::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 8 Apr
 2021 18:38:01 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::4987:8b2f:78ca:deb8]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::4987:8b2f:78ca:deb8%8]) with mapi id 15.20.3999.036; Thu, 8 Apr 2021
 18:38:01 +0000
Subject: Re: [PATCH] drm/amd/display: Fix two cursor duplication when using
 overlay
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210407214948.879763-1-Rodrigo.Siqueira@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <1691c63f-f898-b1ac-b530-5e11f50d5a4b@amd.com>
Date: Thu, 8 Apr 2021 14:37:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210407214948.879763-1-Rodrigo.Siqueira@amd.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YT1PR01CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::25) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by
 YT1PR01CA0056.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.32 via Frontend Transport; Thu, 8 Apr 2021 18:38:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 297a96ee-9cb7-48e9-8c5e-08d8fabd6ffe
X-MS-TrafficTypeDiagnostic: MWHPR12MB1869:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1869C8170F363044B724FEAD8C749@MWHPR12MB1869.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EPdfHR1k/pSHbwgweSmxY0+7Si5n47yKpubo98uYl8yyibx53WjI8X+wCGW8YX4XdCyTYXqRFtx6xmBP1C3+mVym39wT8ICR+nZQtrR+jtGP2IskV20OZ40CyfF/uoRsknUXgFfn3zMZTli0/P0OYbg/+OvmFFzoNvEOlUQFCQu+9QetxkxAjz2UfotMNHKrAq+08GiUUpKOl+gZ126yyuJB7boBCzkxNlU2BTSfK/Wl3tUy8X88yUzO97RRmwxsL7qnRDp6PYJrIfjOJ9ISoWfhq3dwEqMBD9M6wsznEEMsUtITCOqTceY/bvJm7wIweA+perblzXFQG323O6+GpDJa2iP0ch9hgRiudYvAsXstmTRSj1EZWJNFRsTYw3YIipWrf8PODLGO7bfvA/9zhcFeppaBg0zZXdFnyBPN0nzhP74kyddjDJLSBD95bE2AqM1FOLpZaUJbuC/qzrfyq6YTf5iw2mu9VsEO856RUiAxXO8mv8Fm7jCaPuUXZZWxo5YXD1THiCMu4nHqCfSxvqGRmRxaBCl9Jy8p5z2fxV8tVMOeDU2pbDc6JFRmYgQgNnQrwVYpYSGYY8yqsVD715XZIt3Mn/gVfNc+nyNfsiXhg6YKeRI61LLBbmgl4XzqVcgGWbLz+MQ8JpWtSbdp4BbRN8tV713/844UJ+q99z9E4X0DHGPCUsD+tELxHlGc/I2cdJmO5H2nuGIYyvLb/QMbNhtVV+TL1NUiI3ujr3c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(2616005)(31696002)(956004)(66476007)(8936002)(53546011)(66556008)(66946007)(6486002)(5660300002)(8676002)(2906002)(44832011)(31686004)(54906003)(4326008)(316002)(16576012)(36756003)(38100700001)(83380400001)(16526019)(186003)(478600001)(86362001)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Qk0xK2xQYTNRZTB4YWtTYzhpZDVMTlVXeGhBNWdtZnRvMlFLS3JEWklVeEpr?=
 =?utf-8?B?anJrNldUaWZyb2JzYXE4VGJwR2w3UkFSRFZiUjBXd3llWG1EMWU4WDdkWTMx?=
 =?utf-8?B?LzRRODc2OXFDMzZFSWcxU0JlSTlKZkxBNDhQYWJJc0x6WCt5ckxqQ0dyL3k1?=
 =?utf-8?B?ZndCekNueVJ6SnkvTkxOYzRqbnhaZDdCcC9TZ1VoK1I1am9JTWhGNXJ1S2Y2?=
 =?utf-8?B?aGt5WHFxQm1iS0pUQmM3dklZUjZBQVFRZS82dnVBd3RrSHo3N0hUbmdYYk5F?=
 =?utf-8?B?TkNpazFmcnhTaGJaQUJRYTVaSW9wUCtvRlI3NFUvOEl1SE16Z2hOQ0hMekZK?=
 =?utf-8?B?a3lzWTdYVFJOczhDclp1d1VoTUZjNUpZR3djZVBESDFzT3IrVnFOSGwyNXgx?=
 =?utf-8?B?WlpaTlllTFBqd0M0UUZic09PbGNWOUg2ME5WNW0wSjQyZWlOZlRxdTg5aGtQ?=
 =?utf-8?B?bWhHMTRYUGJXVEx5bEFNNkVSRm5BWXFyZldaK0x2VEgwdlBMSW1lR1dESXA1?=
 =?utf-8?B?MDNNR3Z3UVZHenZ5S3F5NkxFNFZQTUFBZFl0amlWN21GSmN2dE5YMFlKNHgw?=
 =?utf-8?B?M2VjODNMTzlUcGRFR2ZEL2lLUDVHZlE5alNMT0t2NVgwSVhzNStaQnk5bGpW?=
 =?utf-8?B?Uzk0WXhWODRUR2ZmbzdpNnpsYWlyZDdMYlpZcEJKam1rRll1SHIySThFd3NJ?=
 =?utf-8?B?TUlUeVhkendxQ0VPdnJWM3VNZkF4WHBSRDBRMXY3QjFqSXFRb2ZXR2J6bUVU?=
 =?utf-8?B?bUV0R0o1ZjcwN0tXbVgyTVpkbjl0Q3Nsd2NyZlJ1SldlL0w5T3FMTEU0cmY4?=
 =?utf-8?B?K3BhMzdIcENWN3g3Z0tKekpRMENuaWlIalROSnl0eU9FOElTSnZPd09ocUhK?=
 =?utf-8?B?UjZxU1dQZE1TbFBLWjNjSFdBZnpHcmVaNGlWdTk4MXo2QkxBbWZUQ01PRnRS?=
 =?utf-8?B?ZzVFZnpZbmRrSDVXbHUvNkdhK0lMOXA3RW9tbFhMc0l6Y2pwVDBIMkwybXJO?=
 =?utf-8?B?WVdXa1QyVGJPeHBkWGNxVXJhU2ozQkRCeUFvUmRqKytaTC9TOWl4QmQ3ZFdS?=
 =?utf-8?B?UmNSa1AwSjNVZTJ0WEwzVUtydkVpSmQrYWg0VllWbytXS0xjbUxlUUllcm5Z?=
 =?utf-8?B?azN1SmRBaXBHMUIwSXhiVHBwSDVXZXg5L2dDZmxjQWxnZ29LdWZwSDg5L0ZR?=
 =?utf-8?B?UmkxdnQzWHU4VGNwUEVTYWxLcG5UU3p3djFMNzZ6dE1ESFV5S21UTTBVcS96?=
 =?utf-8?B?b2I4ZlJ5TjlOWE9KSUhBb2kxc3JMcWZmaUZQdjNlc0FSMlJKc3VzMzhkSXR2?=
 =?utf-8?B?NndUSTlGUXRLOHI0Y041dmU1ejBzeWtYcGVUYm5yQkFUaUMxcXJoaXdwaytI?=
 =?utf-8?B?U0FwRlMwWVY3OXl4V1BxQUFhZWVGT1U1N2V3SXpZSTV6TXpxS2ZBUDVvbk91?=
 =?utf-8?B?Yk1mYm5pSWVQNlBvUVpmRmo1bHEvMjBTODNwaXE4WnhoVkdNR25SOWx3Vnhj?=
 =?utf-8?B?YUh3WCtkdHVRVURGU0xpOFR3TGVwREFieDNHV1JkZ0orYzFyTWhZU0Nxa1cz?=
 =?utf-8?B?WVZBZ2E0SlBlNy9mZTdzMFd0cHhFcHRSNlRZZjZWWjN0Wk9tS0JHa0RqT2Nz?=
 =?utf-8?B?OWMyZmovdnJmMWpGbkZ4UWpuVFpZQU9HVlJyTG9wTEYyam5DRjlGbmNKSG5q?=
 =?utf-8?B?SWswUm8yK0JtamJXSThQTTllRUVMYy93dGZ0ZFgvaDR1ZWhIV0FrNERmQnc0?=
 =?utf-8?Q?sJMPAeXnV6yyTsYWxYuFrlyOJIaCfkTHhuEd0VJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297a96ee-9cb7-48e9-8c5e-08d8fabd6ffe
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 18:38:00.9702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xMq88k7Ieb0tx55VPgJrWFooSWVefeQuUhz0CfpTKu1HMIBH0uhbYZufR7z4Qmq/EJdxKGKF9Hh2FXZ7KiND5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1869
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
Cc: Hersen Wu <hersenxs.wu@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Louis Li <Ching-shih.Li@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-04-07 5:49 p.m., Rodrigo Siqueira wrote:
> Our driver supports overlay planes, and as expected, some userspace
> compositor takes advantage of these features. If the userspace is not
> enabling the cursor, they can use multiple planes as they please.
> Nevertheless, we start to have constraints when userspace tries to
> enable hardware cursor with various planes. Basically, we cannot draw
> the cursor at the same size and position on two separated pipes since it
> uses extra bandwidth and DML only run with one cursor.
> 
> For those reasons, when we enable hardware cursor and multiple planes,
> our driver should accept variations like the ones described below:
> 
>    +-------------+   +--------------+
>    | +---------+ |   |              |
>    | |Primary  | |   | Primary      |
>    | |         | |   | Overlay      |
>    | +---------+ |   |              |
>    |Overlay      |   |              |
>    +-------------+   +--------------+
> 
> In this scenario, we can have the desktop UI in the overlay and some
> other framebuffer attached to the primary plane (e.g., video). However,
> userspace needs to obey some rules and avoid scenarios like the ones
> described below (when enabling hw cursor):
> 
>                                        +--------+
>                                        |Overlay |
>   +-------------+    +-----+-------+ +-|        |--+
>   | +--------+  | +--------+       | | +--------+  |
>   | |Overlay |  | |Overlay |       | |             |
>   | |        |  | |        |       | |             |
>   | +--------+  | +--------+       | |             |
>   | Primary     |    | Primary     | | Primary     |
>   +-------------+    +-------------+ +-------------+
> 
>   +-------------+   +-------------+
>   |     +--------+  |  Primary    |
>   |     |Overlay |  |             |
>   |     |        |  |             |
>   |     +--------+  | +--------+  |
>   | Primary     |   | |Overlay |  |
>   +-------------+   +-|        |--+
>                       +--------+
> 
> If the userspace violates some of the above scenarios, our driver needs
> to reject the commit; otherwise, we can have unexpected behavior. Since
> we don't have a proper driver validation for the above case, we can see
> some problems like a duplicate cursor in applications that use multiple
> planes. This commit fixes the cursor issue and others by adding adequate
> verification for multiple planes.
> 
> Cc: Louis Li <Ching-shih.Li@amd.com>
> Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
> Cc: Harry Wentland <Harry.Wentland@amd.com>
> Cc: Hersen Wu <hersenxs.wu@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 59 +++++++++++++++++++
>   1 file changed, 59 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index ac6ab35f89b2..5ae6d61e83f1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9939,6 +9939,61 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm
>   }
>   #endif
>   
> +static int validate_overlay(struct drm_atomic_state *state)
> +{
> +	int i;
> +	struct drm_plane *plane;
> +	struct drm_plane_state *old_plane_state, *new_plane_state;
> +	struct drm_plane_state *primary_state, *cursor_state, *overlay_state = NULL;
> +
> +	/* Check if primary plane is contained inside overlay */
> +	for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, new_plane_state, i) {
> +		if (plane->type == DRM_PLANE_TYPE_OVERLAY) {
> +			if (drm_atomic_plane_disabling(plane->state, new_plane_state))
> +				return 0;
> +
> +			overlay_state = new_plane_state;
> +			continue;
> +		}
> +	}
> +
> +	/* check if we're making changes to the overlay plane */
> +	if (!overlay_state)
> +		return 0;
> +
> +	/* check if overlay plane is enabled */
> +	if (!overlay_state->crtc)
> +		return 0;
> +
> +	/* find the primary plane for the CRTC that the overlay is enabled on */
> +	primary_state = drm_atomic_get_plane_state(state, overlay_state->crtc->primary);
> +	if (IS_ERR(primary_state))
> +		return PTR_ERR(primary_state);
> +
> +	/* check if primary plane is enabled */
> +	if (!primary_state->crtc)
> +		return 0;
> +
> +	/* check if cursor plane is enabled */
> +	cursor_state = drm_atomic_get_plane_state(state, overlay_state->crtc->cursor);
> +	if (IS_ERR(cursor_state))
> +		return PTR_ERR(cursor_state);
> +
> +	if (drm_atomic_plane_disabling(plane->state, cursor_state))
> +		return 0;
> +
> +	/* Perform the bounds check to ensure the overlay plane covers the primary */
> +	if (primary_state->crtc_x < overlay_state->crtc_x ||
> +	    primary_state->crtc_y < overlay_state->crtc_y ||
> +	    primary_state->crtc_x + primary_state->crtc_w > overlay_state->crtc_x + overlay_state->crtc_w ||
> +	    primary_state->crtc_y + primary_state->crtc_h > overlay_state->crtc_y + overlay_state->crtc_h) {
> +		DRM_DEBUG_ATOMIC("Overlay plane is enabled with hardware cursor but does not fully cover primary plane\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>   /**
>    * amdgpu_dm_atomic_check() - Atomic check implementation for AMDgpu DM.
>    * @dev: The DRM device
> @@ -10113,6 +10168,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   			goto fail;
>   	}
>   
> +	ret = validate_overlay(state);
> +	if (ret)
> +		goto fail;
> +
>   	/* Add new/modified planes */
>   	for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, new_plane_state, i) {
>   		ret = dm_update_plane_state(dc, state, plane,
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
