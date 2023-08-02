Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EF3C001E0
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Aug 2023 07:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A75C210E5B2;
	Thu,  3 Aug 2023 07:25:06 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2605310E57C
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Aug 2023 19:23:17 +0000 (UTC)
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2b9c0391749so2583161fa.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Aug 2023 12:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691004195; x=1691608995;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=JI2K3/PcSU16SfdP5G82uId5N2ZoQeoXguPyrHWGg6g=;
 b=tkMu6S6U09q5cbMC2faJ6XMuyy/++wbqdEdZQuxFKXozCoiSofPMmmKu56DsNj3dte
 QDALUCNMAFVjAmv5bKBAry1F8F0lI0ksk7I6Axl3c2nhJV280O04ioXZbvsKW2t0Dj+o
 puVbk8MXW29h67qAbAu1hfjjwUQkneRNaP6J7odNXeIMQ3dg8rGT4avdUpwS5HpUvmOg
 2vGRDLsMxaoqsd/fcivVzvMBerknFUFR0FHbBaPRAIDUnksH1liS7pAoKK39M83IsShU
 LJqqVxajJzIAUaudL6lNmlSBTWCBm90yZfqFcCbAPO41ymMZ8fMttR93kDAg425LPfeP
 03zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691004195; x=1691608995;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JI2K3/PcSU16SfdP5G82uId5N2ZoQeoXguPyrHWGg6g=;
 b=c2g0ol4EUYBNIXcfhD2z/KOPgXLWHuH/kCKSP2ZBdf51QxylizD91F00x8HejoDH/P
 5n6Idt8uVZMCNZUpbGtv7g8goJSsW+CuFlpjs0xuxIeLti+/562gqKoNWWL149yPI2qT
 umlxCutBjGdqPVPRwJB6rgR5RjfYnzV87lo+DV/3JZlxCMXgFkpeW8eG/9/xXDFp99X4
 LXihzZV8Lqlqsag+siplV2qMue5kuVe25ZodPVkkf0/o4+2ONWSM1qNbrYNzxBRuoYJW
 6a/ABOI+JZwRK+E7hU3IGnCDTpHTb+PJ8N6s52PFrdS3fX+efQefGtF+vNKXYrtFY79+
 qzxw==
X-Gm-Message-State: ABy/qLb23OzmdbBJBYL88Uh/N12wNmB21ObZKJk0Mmu2Qan91lphK3SF
 1A4gwkUORNu8TEucx5YbkiyAKA==
X-Google-Smtp-Source: APBJJlGtKeD676HvToSidDuUv88oPdXG/NhYmfpmAPpdeFYZVFMNg6R4XBWpqpRFoiNXESjcvPqjbw==
X-Received: by 2002:a19:4f4c:0:b0:4fb:9168:1fc7 with SMTP id
 a12-20020a194f4c000000b004fb91681fc7mr5082939lfk.51.1691004195381; 
 Wed, 02 Aug 2023 12:23:15 -0700 (PDT)
Received: from [127.0.0.1] (85-76-68-36-nat.elisa-mobile.fi. [85.76.68.36])
 by smtp.gmail.com with ESMTPSA id
 d25-20020ac24c99000000b004f86d3e52c0sm3043962lfl.4.2023.08.02.12.23.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 12:23:14 -0700 (PDT)
Date: Wed, 02 Aug 2023 22:23:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 3/4] drm/uapi: document the USB subconnector type
User-Agent: K-9 Mail for Android
In-Reply-To: <20230802191351.GA1407@pendragon.ideasonboard.com>
References: <20230729004913.215872-1-dmitry.baryshkov@linaro.org>
 <20230729004913.215872-4-dmitry.baryshkov@linaro.org>
 <20230802185547.GC32500@pendragon.ideasonboard.com>
 <a32ce695-038f-0ef8-3584-5bd1ba528131@linaro.org>
 <20230802191351.GA1407@pendragon.ideasonboard.com>
Message-ID: <DE2B4523-D16C-4AFC-8352-212B23548DD5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 03 Aug 2023 07:25:02 +0000
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
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Andrzej Hajda <andrzej.hajda@intel.com>, Janne Grunau <j@jannau.net>,
 Robert Foss <rfoss@kernel.org>, David Airlie <airlied@gmail.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Andy Gross <agross@kernel.org>,
 Harry Wentland <harry.wentland@amd.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jonas Karlman <jonas@kwiboo.se>,
 Leo Li <sunpeng.li@amd.com>, intel-gfx@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Ser <contact@emersion.fr>,
 Bjorn Andersson <andersson@kernel.org>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?ISO-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

2 =D0=B0=D0=B2=D0=B3=D1=83=D1=81=D1=82=D0=B0 2023 =D0=B3=2E 22:13:51 GMT+03=
:00, Laurent Pinchart <laurent=2Epinchart@ideasonboard=2Ecom> =D0=BF=D0=B8=
=D1=88=D0=B5=D1=82:
>On Wed, Aug 02, 2023 at 10:01:19PM +0300, Dmitry Baryshkov wrote:
>> On 02/08/2023 21:55, Laurent Pinchart wrote:
>> > Hi Dmitry,
>> >=20
>> > Thank you for the patch=2E
>> >=20
>> > On Sat, Jul 29, 2023 at 03:49:12AM +0300, Dmitry Baryshkov wrote:
>> >> To properly define the USB-C DP altmode connectors, add the USB
>> >> subconnector type=2E
>> >>
>> >> Suggested-by: Simon Ser <contact@emersion=2Efr>
>> >> Signed-off-by: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg>
>> >> ---
>> >>   drivers/gpu/drm/drm_connector=2Ec | 1 +
>> >>   include/uapi/drm/drm_mode=2Eh     | 1 +
>> >>   2 files changed, 2 insertions(+)
>> >>
>> >> diff --git a/drivers/gpu/drm/drm_connector=2Ec b/drivers/gpu/drm/drm=
_connector=2Ec
>> >> index a6066e4a5e9a=2E=2E9e96b038f5d0 100644
>> >> --- a/drivers/gpu/drm/drm_connector=2Ec
>> >> +++ b/drivers/gpu/drm/drm_connector=2Ec
>> >> @@ -1050,6 +1050,7 @@ static const struct drm_prop_enum_list drm_dp_=
subconnector_enum_list[] =3D {
>> >>   	{ DRM_MODE_SUBCONNECTOR_DisplayPort, "DP"        }, /* DP */
>> >>   	{ DRM_MODE_SUBCONNECTOR_Wireless,    "Wireless"  }, /* DP */
>> >>   	{ DRM_MODE_SUBCONNECTOR_Native,	     "Native"    }, /* DP */
>> >> +	{ DRM_MODE_SUBCONNECTOR_USB,	     "USB"       }, /* DP */
>> >=20
>> > Should this be DRM_MODE_SUBCONNECTOR_USB_C and "USB-C", in case we ge=
t
>> > another USB type later ?
>>=20
>> Hmm, which id should I use for micro-USB then? (consider anx7808,=20
>> SlimPort)=2E I thought about using DRM_MODE_SUBCONNECTOR_USB for both o=
f=20
>> them=2E But maybe I should add another subtype for SlimPort=2E
>
>I suppose it depends on whether userspace needs a way to differentiate
>those=2E Do you have a good visibility on the userspace use cases ?

No=2E I'm not even sure, which userspace handles subtypes properly=2E

For the reference, SlimPort is mostly legacy hardware, think about Nexus 4=
, 5, 6, 7 (2013)


>
>> >>   };
>> >>  =20
>> >>   DRM_ENUM_NAME_FN(drm_get_dp_subconnector_name,
>> >> diff --git a/include/uapi/drm/drm_mode=2Eh b/include/uapi/drm/drm_mo=
de=2Eh
>> >> index 92d96a2b6763=2E=2E0f74918b011c 100644
>> >> --- a/include/uapi/drm/drm_mode=2Eh
>> >> +++ b/include/uapi/drm/drm_mode=2Eh
>> >> @@ -398,6 +398,7 @@ enum drm_mode_subconnector {
>> >>   	DRM_MODE_SUBCONNECTOR_HDMIA       =3D 11, /*            DP */
>> >>   	DRM_MODE_SUBCONNECTOR_Native      =3D 15, /*            DP */
>> >>   	DRM_MODE_SUBCONNECTOR_Wireless    =3D 18, /*            DP */
>> >> +	DRM_MODE_SUBCONNECTOR_USB         =3D 20, /*            DP */
>> >>   };
>> >>  =20
>> >>   #define DRM_MODE_CONNECTOR_Unknown	0
>

