Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6A9C4450A
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Jul 2026 01:44:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8E2410E367;
	Sun, 19 Jul 2026 01:43:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=leandro.ribeiro@collabora.com header.b="cYhZyK8C";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF3DA10E2E5
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 22:54:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784328895; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=B8dVvF5W0UK/Id6aeqAllIzfgB45tjDS92iLw7PgEIj/CT+xlprVTjsTkNWafNB6jwRxmkQ95l6NwmOU1Q7rE/QqHuwQN3R4/KWLjyY7XjTAHpIqIN5jJds+7YTp+0Z4y+oLaevczKypr6cuknxMmGdbhl1s09VLtr0Ir2uDTUA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784328895;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=1axtl3tCNHAHjeKjFPctqjuywHMJ27BqGaKLqopjT9M=; 
 b=WZx9E92q8lDw/4eYdfdAlQYyKq08YMZDymo9j/7+mX+59/Nnvm4Sm6/U3/teIqWJXzP1F5GTUrmvx2I/nnCaLG1cqHM2zyDqAhcjq0NWduQEcnLm2yUWKSM5uMbB9HW+zV6ClsjyVUnm72TkrwF7HUvGCHYxR0BSBOv+955wdQ0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=leandro.ribeiro@collabora.com;
 dmarc=pass header.from=<leandro.ribeiro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784328895; 
 s=zohomail; d=collabora.com; i=leandro.ribeiro@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=1axtl3tCNHAHjeKjFPctqjuywHMJ27BqGaKLqopjT9M=;
 b=cYhZyK8CvmXiVJgEqkdt6fW86GT9T0XNoUrYVEw5w9UEymh/tsb90HocTEMiKA/b
 7IgmNR/eZLuX1TogU8MMq2ydks1mWA0fSS1blIJ38YyVf39rd4L98HGXEhm8oGcGpiC
 rTCesg8Hyax6T6aG6Upv/max6wjf3JnrN8YDeQFs=
Received: by mx.zohomail.com with SMTPS id 1784328892532746.7691096186728;
 Fri, 17 Jul 2026 15:54:52 -0700 (PDT)
Message-ID: <45d341e6-d438-4e34-bba2-f6d23dbcf7fb@collabora.com>
Date: Fri, 17 Jul 2026 19:54:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: warnings from validate_blend_mode_for_alpha_formats() in
 next-20260715
To: Alex Deucher <alexdeucher@gmail.com>, Bert Karwatzki <spasswolf@web.de>,
 "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>, Alex Hung <alex.hung@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-next@vger.kernel.org,
 Jesse Zhang <jesse.zhang@amd.com>, Amber Lin <Amber.Lin@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20260716152933.6744-1-spasswolf@web.de>
 <CADnq5_PEN=iuspWbQ9C3gJZ5qJVOLmJ5hrsi6FH0Dg2Y_u2mZQ@mail.gmail.com>
Content-Language: en-US
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
In-Reply-To: <CADnq5_PEN=iuspWbQ9C3gJZ5qJVOLmJ5hrsi6FH0Dg2Y_u2mZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Mailman-Approved-At: Sun, 19 Jul 2026 01:43:58 +0000
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



On 7/17/26 11:55 AM, Alex Deucher wrote:
> + Some display folks
> 
> On Fri, Jul 17, 2026 at 9:04 AM Bert Karwatzki <spasswolf@web.de> wrote:
>>
>> commit 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
>> introduces validate_blend_mode_for_alpha_formats() which prints warnings for amdpgu as
>> amdgpu only set blend_mode_property for planes of type DRM_PLANE_TYPE_OVERLAY. I tried to fix
>> this by removing he (plane->type == DRM_PLANE_TYPE_OVERLAY) check in amdgpu_dm_plane_init():
>>
>>         printk(KERN_INFO "%s: plane=%px plane->type=0x%x plane_cap=%px\n", __func__, plane, plane->type, plane_cap);
>>         if (plane_cap)
>>                 printk(KERN_INFO "%s: per_pixel_alpha =%u\n", __func__, plane_cap->per_pixel_alpha);
>>         if (plane_cap && plane_cap->per_pixel_alpha) {
>>                 unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>>                                           BIT(DRM_MODE_BLEND_PREMULTI) |
>>                                           BIT(DRM_MODE_BLEND_COVERAGE);
>>
>>                 printk(KERN_INFO "%s: creating alpha and blend mode properties for plane %px\n", __func__, plane);
>>                 drm_plane_create_alpha_property(plane);
>>                 drm_plane_create_blend_mode_property(plane, blend_caps);
>>         }
>>
>> But this does not completely silence the warnings becuase for planes of type DRM_PLANE_TYPE_CURSOR plane_cap is NULL.
>> Is this a problem that should be fixed in amdgpu or is should validate_blend_mode_for_alpha_formats() only be called
>> for planes of certain types?

IMO validate_blend_mode_for_alpha_formats() should be called for all
types of planes. I can't think of anything special about a cursor plane
that would justify it being allowed to expose formats with alpha but not
the blend mode property.

I'm not familiar with the AMD codebase to suggest the best fix, but the
driver would need some way to know whether cursor planes are exposing
formats with alpha.

>>
>> Bert Karwatzki
>>

-- 
Leandro Ribeiro

