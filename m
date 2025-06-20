Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F82AC71155
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jun 2025 10:10:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2519E10EB26;
	Fri, 20 Jun 2025 10:10:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kode54.net header.i=@kode54.net header.b="wmc/Dxu9";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="ef4sgo0X";
	dkim-atps=neutral
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8655910EB26
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jun 2025 10:10:10 +0000 (UTC)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal
 [10.202.2.47])
 by mailfout.phl.internal (Postfix) with ESMTP id E5E191380510;
 Fri, 20 Jun 2025 06:10:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Fri, 20 Jun 2025 06:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1750414209;
 x=1750500609; bh=4nyyrNGcXM41jYHw6ZWJaEiCsy7oQlzTvtSuTIA2+yI=; b=
 wmc/Dxu9ffkHP+5h4HqXEeRBKohVf86d9Sq1r0eamn+Pil7HLkqYfw90oMZpPS7T
 /wgqWxsYeSdF3gv1xn3rs9SSj/IYQbmWCDNWYHnFm5SUcs3ul++3vsgR0oibjaRS
 A+Il2gTzaVf6aNApbEviBYgCYuQ97XJ/3Jc9Yf9oKgU3OqioT2ugpfhjSvrSz4hg
 AAT7EVhnyEleBqWG7EhaxsMZBk9niiMoNVXZ4xZVK8G3KMUaDL4I+eOjrKWi4pf+
 XHqhSLNEIgiXsi1MVSKaXD6xZvAVQheEm43vN5enlG2bxuPX08ZN4Tiec/Sqs45l
 QNX4lAfQKLmOPOiUT41jPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750414209; x=
 1750500609; bh=4nyyrNGcXM41jYHw6ZWJaEiCsy7oQlzTvtSuTIA2+yI=; b=e
 f4sgo0XXxLaAe/7DswUx3trE+qqjGmhzZEtjvLynqatPNPUg9kcFCc+FeP1mY1Oq
 WFpFCSv/u/ma5r58D/iVLREMaEhN2zXAl++C4pG6VX4+lNhHKf86T+xX7izENdDZ
 x2nmMzriyvdDWewd23YMT6cpE1oY1agY7fSKWaW1ybqrB51O031J8ETkv9xkNKXK
 EvrMFJRzgFf/HfowYbA+M2p9TrANfO4UtBgJ/UkCCDP3ZpGPJ3GmL1LhR9dnVYsJ
 CBjJODEejTLgLP56R79Uv7slnltX8hNFZ0SHyx0K07KXQPqjaWpAlOqjnAZEnPmy
 eHipIkUP4G1l9SJ9e5SoQ==
X-ME-Sender: <xms:gTNVaKd2Gluzajq0PcuZeD7YhaPjaRttKKsr2LwpYMcfXgf7Mb0Yhw>
 <xme:gTNVaEOryAxVpGuVYwpZ-ZQSInR1Jh9peznGpm79vk4M1z1neijMsExdqCHW1W1bJ
 yApyse1cIvFFvudKkU>
X-ME-Received: <xmr:gTNVaLh1c64JrzqP5hoigYLOfPeZNwID3zkXCH4oVHbtO-mXmEpZtimCRLbhak8Nl8rLxz8356BciphrzdU3wG5B9RMEaQe1mg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdekudefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 epggfgtgffkfevuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfvehhrhhishht
 ohhphhgvrhcuufhnohifhhhilhhlfdcuoegthhhrihhssehkohguvgehgedrnhgvtheqne
 cuggftrfgrthhtvghrnhepieeltedujeffgeejgeffhffhhfekfeejgfdtudejheehveel
 veejjeffkeeikeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomheptghhrhhisheskhhouggvheegrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehkohguvgehgeesghhmrghilhdrtghomh
 dprhgtphhtthhopegrmhguqdhgfhigsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdho
 rhhgpdhrtghpthhtoheprghlvgigrghnuggvrhdruggvuhgthhgvrhesrghmugdrtghomh
 dprhgtphhtthhopegthhhrihhsthhirghnrdhkohgvnhhighesrghmugdrtghomhdprhgt
 phhtthhopegthhhrihhssehkohguvgehgedrnhgvth
X-ME-Proxy: <xmx:gTNVaH_bb11AjGINZayAHURaXsMGw9TYQYj8ti1SUOKGFneo7_X61Q>
 <xmx:gTNVaGtTLP_p8FDB8b8kLUbwPO7Dd-bWedCFnMpzI0m7otwXKIgR-Q>
 <xmx:gTNVaOFCXKreZ0nbO9MF6g212pq4wDV0aN9JaIgjsAqErUAYMpWXjw>
 <xmx:gTNVaFMxaKVyuz76Mq8vF50YMP7KAFAsnsVvfPVe55OW7J80PEma4g>
 <xmx:gTNVaJ7Hbu1IeD_GFlNzhhXkfqEYvbBJcEXY0r16-tKZCRdN7u9Gi8Gf>
Feedback-ID: i9ec6488d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jun 2025 06:10:09 -0400 (EDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Jun 2025 03:10:08 -0700
Message-Id: <DARA1U86AS72.QOIEVZWCFPYC@kode54.net>
Cc: "Alex Deucher" <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Christopher
 Snowhill" <chris@kode54.net>
Subject: Re: [RFC PATCH] drm/amdgpu: Enable async flip for cursor planes
From: "Christopher Snowhill" <chris@kode54.net>
To: "Christopher Snowhill" <kode54@gmail.com>, <amd-gfx@lists.freedesktop.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250619125507.54384-1-kode54@gmail.com>
In-Reply-To: <20250619125507.54384-1-kode54@gmail.com>
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

Here's another alternative change, which may be more thorough. It does
seem to fix the issue, at least. The issue does indeed appear to be
no-op plane changes sent to the cursor plane.

If anyone wants to propose style changes, and suggest a proper commit
message, if this is indeed a welcome fix for the problem, please let me
know.

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic=
_uapi.c
index c2726af6698e..b741939698e8 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1087,17 +1087,22 @@ int drm_atomic_set_property(struct drm_atomic_state=
 *state,
 			}

 			/* ask the driver if this non-primary plane is supported */
-			if (plane->type !=3D DRM_PLANE_TYPE_PRIMARY) {
-				ret =3D -EINVAL;
+			else if (plane->type !=3D DRM_PLANE_TYPE_PRIMARY) {
+				ret =3D drm_atomic_plane_get_property(plane, plane_state,
+								    prop, &old_val);
+
+				if (ret || old_val !=3D prop_value) {
+					ret =3D -EINVAL;

-				if (plane_funcs && plane_funcs->atomic_async_check)
-					ret =3D plane_funcs->atomic_async_check(plane, state, true);
+					if (plane_funcs && plane_funcs->atomic_async_check)
+						ret =3D plane_funcs->atomic_async_check(plane, state, true);

-				if (ret) {
-					drm_dbg_atomic(prop->dev,
-						       "[PLANE:%d:%s] does not support async flips\n",
-						       obj->id, plane->name);
-					break;
+					if (ret) {
+						drm_dbg_atomic(prop->dev,
+							       "[PLANE:%d:%s] does not support async flips\n",
+							       obj->id, plane->name);
+						break;
+					}
 				}
 			}
 		}

