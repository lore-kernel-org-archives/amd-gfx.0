Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDA0C04EB5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2004720720
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J87S+WbN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2004720720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFB806E907;
	Fri,  7 Feb 2020 15:47:40 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4CAF6E907
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 15:47:38 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id a9so3289005wmj.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Feb 2020 07:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QDn+8XVq0FUwpnSZgdryYRqkDzTJOTdYkYSxjNlBlck=;
 b=J87S+WbNAq/HNUo1yjmmiFcIiNSpLyRyV15+gr1HR2zyrFzqpo276CHbqjVhYD+NWL
 sSnGGtlaZ9YSjuHP6PHpq5B+Oz2KM0T/WWjdH9Qll+I8B00BcoyoZ1PEZACjQqVGZ5Jk
 O9+V20Z5ch76ZQT+gsvQlNH8TdWmM7OlxCCY+WyF8zXEWHGuqut7ZBVSu16/0NECFSvm
 TGYVhoJvsCxXQim0mALzBp5wx8N8kfAnOkN/61BQrmcMo+F7FXKKIl+vr4ABneE9N2Qa
 9Ln524OSwn3XzkBagmsP27AArgdam5HoyrqLoWWev01xoBrc9ROyehZlvvg/IKMBIf21
 Oxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QDn+8XVq0FUwpnSZgdryYRqkDzTJOTdYkYSxjNlBlck=;
 b=hUfhgtsB+bw6VydaEDZpoF/TeoEaD7W1xwNIimb2++iQLOuvUFa7Cnbu9L4Z4ELw4x
 gk6vHyx3QRH4f76+WNHFlSB+S1sHHauCThs2KQW8bMy34KIvaVestBJOL7fdbX8vwpCp
 i8jUuMpq4l1o5xXvSGY3CTkFDP66LKzq1h5V5s4yLEwOMA5FX7wB3jHlqBBZ63lMcbr0
 pu8kNyfIyDBofkd/o/46OfEsZtPjIVKRd01IHzlJqne3qN/Y7+Pq4lkLKLb3Y0MqVlgv
 l5IbD2hb9zQFx0Bk2LReuW5wMb2LXzPFY3MoL5ByGnvstMOjlRjaikHsE6mtrSgpVbug
 563w==
X-Gm-Message-State: APjAAAVECWStbAIvopeXQHI9lmL7sm2Oiin828xjY5Hf/V8dd3RLwTTa
 pzdm0UlKPrq4uTW4OVwuGm6VVrMnLgnRET9YP2lh2iIu
X-Google-Smtp-Source: APXvYqx6ndWFG2V5WF/Ia91DQdtWrtFTElfw99opAg2QUKdBvVxg1/CRn9kPe+sjf9RaFImKsuXxrkiR50ttQ53UHck=
X-Received: by 2002:a05:600c:218b:: with SMTP id
 e11mr5080374wme.56.1581090457367; 
 Fri, 07 Feb 2020 07:47:37 -0800 (PST)
MIME-Version: 1.0
References: <20200206195516.302101-1-alexander.deucher@amd.com>
 <MN2PR12MB3344E3BA0850A91ED80C55A0E41C0@MN2PR12MB3344.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3344E3BA0850A91ED80C55A0E41C0@MN2PR12MB3344.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 7 Feb 2020 10:47:26 -0500
Message-ID: <CADnq5_MetLwGsrbaSLBuPo9ENJmWjfFbnCudZnpNTxDA42Q+og@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: update smu_v11_0_pptable.h
To: "Quan, Evan" <Evan.Quan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 7, 2020 at 2:36 AM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> >     SMU_11_0_ODFEATURE_COUNT                = 14,
> This seems a little weird.
> Maybe it should be "SMU_11_0_ODFEATURE_COUNT = 1 << SMU_11_0_ODCAP_COUNT, "

I copied it verbatim.  The naming makes more sense as 14 (number of
features) as opposed to 1 << 14.  I agree it's not consistent though.
I'd prefer to stay consistent with the internal headers.

Alex

> With above confirmed, the patch series is reviewed-by: Evan Quan <evan.quan@amd.com>
>
> >-----Original Message-----
> >From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> >Deucher
> >Sent: Friday, February 7, 2020 3:55 AM
> >To: amd-gfx@lists.freedesktop.org
> >Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> >Subject: [PATCH 1/2] drm/amdgpu: update smu_v11_0_pptable.h
> >
> >Update to the latest changes.
> >
> >Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >---
> > .../drm/amd/powerplay/inc/smu_v11_0_pptable.h | 46 +++++++++++++-----
> >-
> > 1 file changed, 32 insertions(+), 14 deletions(-)
> >
> >diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h
> >b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h
> >index b2f96a101124..7a63cf8e85ed 100644
> >--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h
> >+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h
> >@@ -39,21 +39,39 @@
> > #define SMU_11_0_PP_OVERDRIVE_VERSION                   0x0800
> > #define SMU_11_0_PP_POWERSAVINGCLOCK_VERSION            0x0100
> >
> >+enum SMU_11_0_ODFEATURE_CAP {
> >+    SMU_11_0_ODCAP_GFXCLK_LIMITS = 0,
> >+    SMU_11_0_ODCAP_GFXCLK_CURVE,
> >+    SMU_11_0_ODCAP_UCLK_MAX,
> >+    SMU_11_0_ODCAP_POWER_LIMIT,
> >+    SMU_11_0_ODCAP_FAN_ACOUSTIC_LIMIT,
> >+    SMU_11_0_ODCAP_FAN_SPEED_MIN,
> >+    SMU_11_0_ODCAP_TEMPERATURE_FAN,
> >+    SMU_11_0_ODCAP_TEMPERATURE_SYSTEM,
> >+    SMU_11_0_ODCAP_MEMORY_TIMING_TUNE,
> >+    SMU_11_0_ODCAP_FAN_ZERO_RPM_CONTROL,
> >+    SMU_11_0_ODCAP_AUTO_UV_ENGINE,
> >+    SMU_11_0_ODCAP_AUTO_OC_ENGINE,
> >+    SMU_11_0_ODCAP_AUTO_OC_MEMORY,
> >+    SMU_11_0_ODCAP_FAN_CURVE,
> >+    SMU_11_0_ODCAP_COUNT,
> >+};
> >+
> > enum SMU_11_0_ODFEATURE_ID {
> >-    SMU_11_0_ODFEATURE_GFXCLK_LIMITS        = 1 << 0,         //GFXCLK Limit
> >feature
> >-    SMU_11_0_ODFEATURE_GFXCLK_CURVE         = 1 << 1,         //GFXCLK Curve
> >feature
> >-    SMU_11_0_ODFEATURE_UCLK_MAX             = 1 << 2,         //UCLK Limit
> >feature
> >-    SMU_11_0_ODFEATURE_POWER_LIMIT          = 1 << 3,         //Power Limit
> >feature
> >-    SMU_11_0_ODFEATURE_FAN_ACOUSTIC_LIMIT   = 1 << 4,         //Fan
> >Acoustic RPM feature
> >-    SMU_11_0_ODFEATURE_FAN_SPEED_MIN        = 1 << 5,         //Minimum
> >Fan Speed feature
> >-    SMU_11_0_ODFEATURE_TEMPERATURE_FAN      = 1 << 6,         //Fan Target
> >Temperature Limit feature
> >-    SMU_11_0_ODFEATURE_TEMPERATURE_SYSTEM   = 1 << 7,
> >//Operating Temperature Limit feature
> >-    SMU_11_0_ODFEATURE_MEMORY_TIMING_TUNE   = 1 << 8,         //AC
> >Timing Tuning feature
> >-    SMU_11_0_ODFEATURE_FAN_ZERO_RPM_CONTROL = 1 << 9,         //Zero
> >RPM feature
> >-    SMU_11_0_ODFEATURE_AUTO_UV_ENGINE       = 1 << 10,        //Auto
> >Under Volt GFXCLK feature
> >-    SMU_11_0_ODFEATURE_AUTO_OC_ENGINE       = 1 << 11,        //Auto Over
> >Clock GFXCLK feature
> >-    SMU_11_0_ODFEATURE_AUTO_OC_MEMORY       = 1 << 12,        //Auto
> >Over Clock MCLK feature
> >-    SMU_11_0_ODFEATURE_FAN_CURVE            = 1 << 13,        //VICTOR TODO
> >+    SMU_11_0_ODFEATURE_GFXCLK_LIMITS        = 1 <<
> >SMU_11_0_ODCAP_GFXCLK_LIMITS,            //GFXCLK Limit feature
> >+    SMU_11_0_ODFEATURE_GFXCLK_CURVE         = 1 <<
> >SMU_11_0_ODCAP_GFXCLK_CURVE,             //GFXCLK Curve feature
> >+    SMU_11_0_ODFEATURE_UCLK_MAX             = 1 <<
> >SMU_11_0_ODCAP_UCLK_MAX,                 //UCLK Limit feature
> >+    SMU_11_0_ODFEATURE_POWER_LIMIT          = 1 <<
> >SMU_11_0_ODCAP_POWER_LIMIT,              //Power Limit feature
> >+    SMU_11_0_ODFEATURE_FAN_ACOUSTIC_LIMIT   = 1 <<
> >SMU_11_0_ODCAP_FAN_ACOUSTIC_LIMIT,       //Fan Acoustic RPM feature
> >+    SMU_11_0_ODFEATURE_FAN_SPEED_MIN        = 1 <<
> >SMU_11_0_ODCAP_FAN_SPEED_MIN,            //Minimum Fan Speed feature
> >+    SMU_11_0_ODFEATURE_TEMPERATURE_FAN      = 1 <<
> >SMU_11_0_ODCAP_TEMPERATURE_FAN,          //Fan Target Temperature
> >Limit feature
> >+    SMU_11_0_ODFEATURE_TEMPERATURE_SYSTEM   = 1 <<
> >SMU_11_0_ODCAP_TEMPERATURE_SYSTEM,       //Operating Temperature
> >Limit feature
> >+    SMU_11_0_ODFEATURE_MEMORY_TIMING_TUNE   = 1 <<
> >SMU_11_0_ODCAP_MEMORY_TIMING_TUNE,       //AC Timing Tuning feature
> >+    SMU_11_0_ODFEATURE_FAN_ZERO_RPM_CONTROL = 1 <<
> >SMU_11_0_ODCAP_FAN_ZERO_RPM_CONTROL,     //Zero RPM feature
> >+    SMU_11_0_ODFEATURE_AUTO_UV_ENGINE       = 1 <<
> >SMU_11_0_ODCAP_AUTO_UV_ENGINE,           //Auto Under Volt GFXCLK
> >feature
> >+    SMU_11_0_ODFEATURE_AUTO_OC_ENGINE       = 1 <<
> >SMU_11_0_ODCAP_AUTO_OC_ENGINE,           //Auto Over Clock GFXCLK
> >feature
> >+    SMU_11_0_ODFEATURE_AUTO_OC_MEMORY       = 1 <<
> >SMU_11_0_ODCAP_AUTO_OC_MEMORY,           //Auto Over Clock MCLK
> >feature
> >+    SMU_11_0_ODFEATURE_FAN_CURVE            = 1 <<
> >SMU_11_0_ODCAP_FAN_CURVE,                //Fan Curve feature
> >     SMU_11_0_ODFEATURE_COUNT                = 14,
> > };
> > #define SMU_11_0_MAX_ODFEATURE    32          //Maximum Number of OD
> >Features
> >--
> >2.24.1
> >
> >_______________________________________________
> >amd-gfx mailing list
> >amd-gfx@lists.freedesktop.org
> >https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
> >reedesktop.org%2Fmailman%2Flistinfo%2Famd-
> >gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C99774c3d5dfa4e98e6
> >e408d7ab3e83c6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637
> >166157332486214&amp;sdata=n8ey1rnXwX3JLecL%2BWnNSV6cNNGTagtn2lR
> >ORmI%2Bb%2Bk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
