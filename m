Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50FDFB44CE
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2026 08:05:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFC6F10F403;
	Fri, 24 Apr 2026 08:05:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZFFpef85";
	dkim-atps=neutral
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E794910E213
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 20:54:08 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id
 5614622812f47-479e4835e16so2475924b6e.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 13:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776977648; x=1777582448; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vh+dAS21x3C6ulKovRegxLPmO53GnqH/AjpAPmkhI+c=;
 b=ZFFpef85PM+gNR5T8XilJeoDtJmGgjpxDB4uBu5bTFA7GYEc9oJt2KKbtR3GkimElm
 OGoqNsrKzTaLukeoYe0B1sNIw6FvsJlDOdF9+0M4DgkW6yyvT8MWeYfREbTGN97NpDTX
 StlrXQ1J1nzFpi+i31JcH2kBWh6C4My8NKIp+QQhc7Cec1ug+fZMCbXygHhVpIeMFXfe
 yZ3Ij0cQDshrjqc425Pu4UtSv6xepZo7XblsGSjjrodK89DcRapm1AKtnavWsVr6fF7E
 Uav2QUw67/dWppXwYMNezmQWyWDJswHkRYwGkKPBD+KM7mQccmyPZYF99CsZ9cvyJAm6
 TyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776977648; x=1777582448;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vh+dAS21x3C6ulKovRegxLPmO53GnqH/AjpAPmkhI+c=;
 b=jZsYhF2343vFr8y0DJ7i0Y4Ravup/UJwHCXYsyZXykFM6zkjCiuG6NS56HupOE5q37
 yMQBhC7oQJy9xk5gryjAhCV+WlmlikC4ehqAgRVHbHqv6pjuK65c8fOYxMgLGGVFc7h7
 Tpn4lW+PBLkEkam9FWQ2Yx0eme7qdkIuJy+zA6NW0UX8CvLPW4+ROS03CIRe1c1xUDxW
 hY5BaRnzcMpA7Kay0BEeIllWSR0MQXiDraLhg+8ArDiTPNPRpsrkIMo9tn+tl3KMgQWQ
 7YWzk43Jh8tmHqD8qds2rqmaCtgYfPJoag0XoDde0xl4hTQEejfXZftAnNjdFKpXU8CV
 EPow==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+paAEmFaQrbz+wE1CAAJytPVwaeG4zfdaOGub5OzzJHum0WNqBuG6e3zDl4Fm8n+1ifb2E4Ww@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzMf0E055JG+HIjuGV3XCDPrHoiGEa8GShtnuDBWklfCxDV+lhr
 OSDDieDgmWHGs3vS4qErv4/xmUFT+EsHkTxy+sabWDASkv8YPZaldYzG
X-Gm-Gg: AeBDievizO1OunkFubQClqGa+TLMIyu20HQDmz4mrC2iInZiO285opxZS1gkMW4OwU1
 hpqZ4hROqdNOTE+NggIzrkIZc2eD+bzmWxct1/K4+U3KI62INQ3MUcvhjDNi7MGULSkjTdu8kt4
 2rGHvaLrFOAo/ImO+UZCrZ0yYdq70gKqLC3BEgAEf7DFm2nO2uSjmw7lRuKqJCGBZOC8bHYMCIU
 PlVFAfNRrpb30amIcxOSr7oBGKctfxfsuQCrabc2dzuUw9/Wcpx2nXD7Ot7sYay7ttz6GvG3g4t
 saL9+4PdkNLxi3v6r2MSvVfvJhlqky1Fy28cnDSLqLxv1+AKgH5IpZJAL25eVTpWnPZdqt8yl8X
 yOFGcSjg7/0SQab4WQPTSnHoqR73tw8PdWiVqw4+sDOM4ggOqc2Lrf8+9AixrCyqdqGFmBpX4wn
 avBIMe6uYY175V205bnoedXrFRWD7IihO39DQPNV4dydOe9wOcIeqz8xTsuIa3WWm9z078HUvcb
 EJF/pbOMt0=
X-Received: by 2002:a05:6808:138b:b0:45f:59e:1e06 with SMTP id
 5614622812f47-4799c8711e1mr17988935b6e.4.1776977647783; 
 Thu, 23 Apr 2026 13:54:07 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4799fead505sm14329744b6e.2.2026.04.23.13.54.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 13:54:07 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 23 Apr 2026 14:53:42 -0600
Subject: [PATCH v14 01/92] dyndbg: fix NULL ptr on i386 due to section
 mis-alignment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-submit-dyndbg-classmap-foundation-v14-1-2b809a8019d0@gmail.com>
References: <20260423-submit-dyndbg-classmap-foundation-v14-0-2b809a8019d0@gmail.com>
In-Reply-To: <20260423-submit-dyndbg-classmap-foundation-v14-0-2b809a8019d0@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 Zack Rusin <zack.rusin@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, Sean Paul <sean@poorly.run>, 
 Jocelyn Falempe <jfalempe@redhat.com>, Ruben Wauters <rubenru09@aol.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Xinliang Liu <xinliang.liu@linaro.org>, Tian Tao <tiantao6@hisilicon.com>, 
 Xinwei Kong <kong.kongxinwei@hisilicon.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Oded Gabbay <ogabbay@kernel.org>, 
 Maciej Falkowski <maciej.falkowski@linux.intel.com>, 
 Karol Wachowski <karol.wachowski@linux.intel.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 Liviu Dudau <liviu.dudau@arm.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Liu Ying <victor.liu@nxp.com>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Paul Kocialkowski <paulk@sys-base.io>, 
 Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Huacai Chen <chenhuacai@kernel.org>, Mingcong Bai <jeffbai@aosc.io>, 
 Xi Ruoyao <xry111@xry111.site>, Icenowy Zheng <zhengxingda@iscas.ac.cn>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
 Jani Nikula <jani.nikula@intel.com>, Luca Coelho <luciano.coelho@intel.com>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, spice-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-renesas-soc@vger.kernel.org, 
 etnaviv@lists.freedesktop.org, Jim Cromie <jim.cromie@gmail.com>, 
 kernel test robot <oliver.sang@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776977636; l=2644;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=YvI+c+2Ph7G01gY6UA2wVrmrHHoi2nJdOmOI4+tqFF4=;
 b=JyTcuYLHHiwHBHDMwQ80bkTwG2D19eoKHDE+tl83KcpGRfh3fZenxZ7q9Sw+M3I1crSkiEMPL
 U/h1shBkXbNDxTVmN1qvPMSBm5G8hxuK6TqMgzZBBZXdklZASPjpC8F
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Mailman-Approved-At: Fri, 24 Apr 2026 08:04:49 +0000
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

When dyndbg classmaps get used (later in this series), the
__dyndbg_classes section (which has 28 byte structs on i386), causes
mis-alignment of the following __dyndbg section, resulting in a NULL
pointer deref in dynamic_debug_init().

Fix this by:

Adding ALIGN(8) to the BOUNDED_SECTION* macros.  This aligns all
sections using those macros, including the problem section above.
Almost all the other macro uses are already ALIGN(8), either
directly or by being below one.

Removing BOUNDED_SECTION* uses in ORC_UNWINDER sections.  These
explicitly have smaller alignments, and using the modified macros here
would override that alignment, which scripts/sorttable.c does not
tolerate.

Move __dyndbg section back above __dyndbg_classes, restoring its
original position.  This is cosmetic, given the alignment added to the
macros.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202601211325.7e1f336-lkp@intel.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 60c8c22fd3e4..db38f52035f3 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -212,11 +212,13 @@
 #endif
 
 #define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+	. = ALIGN(8);							\
 	_BEGIN_##_label_ = .;						\
 	KEEP(*(_sec_))							\
 	_END_##_label_ = .;
 
 #define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+	. = ALIGN(8);							\
 	_label_##_BEGIN_ = .;						\
 	KEEP(*(_sec_))							\
 	_label_##_END_ = .;
@@ -862,15 +864,21 @@
 #ifdef CONFIG_UNWINDER_ORC
 #define ORC_UNWIND_TABLE						\
 	.orc_header : AT(ADDR(.orc_header) - LOAD_OFFSET) {		\
-		BOUNDED_SECTION_BY(.orc_header, _orc_header)		\
+		__start_orc_header = .;					\
+		KEEP(*(.orc_header))					\
+		__stop_orc_header = .;					\
 	}								\
 	. = ALIGN(4);							\
 	.orc_unwind_ip : AT(ADDR(.orc_unwind_ip) - LOAD_OFFSET) {	\
-		BOUNDED_SECTION_BY(.orc_unwind_ip, _orc_unwind_ip)	\
+		__start_orc_unwind_ip = .;				\
+		KEEP(*(.orc_unwind_ip))					\
+		__stop_orc_unwind_ip = .;				\
 	}								\
 	. = ALIGN(2);							\
 	.orc_unwind : AT(ADDR(.orc_unwind) - LOAD_OFFSET) {		\
-		BOUNDED_SECTION_BY(.orc_unwind, _orc_unwind)		\
+		__start_orc_unwind = .;					\
+		KEEP(*(.orc_unwind))					\
+		__stop_orc_unwind = .;					\
 	}								\
 	text_size = _etext - _stext;					\
 	. = ALIGN(4);							\

-- 
2.53.0

