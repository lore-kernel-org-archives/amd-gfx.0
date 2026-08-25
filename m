Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C86C61DB9
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 13:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 958A210E5ED;
	Tue, 25 Aug 2026 13:01:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CI2w5PPl";
	dkim-atps=neutral
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36BF910E033
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 11:25:28 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-92e5c9211d2so368512685a.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 04:25:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787657127; cv=none;
 d=google.com; s=arc-20260327;
 b=B4OQ8eqEJCWCAMdlIQ1EL98zLMSRCrHtzZkoG14bSwli+AY1ITdee1UiEWjlgoJ7Zu
 E0TfX98vUrkwAkXHHFpTJ5UP9qYY4M9WrZDy967pbEXdQnDjtiijKFy8ScSEHhDRnyMX
 t1OfXKxHKXPfgfOJ+HZPR8/OxIbTuDFGOIU2hMbT875dk1PAf6qs25L7OH5y5vfACotb
 dQ5qupYKe1AdvdY03JJYR02J41UB7Mf6jE9WWItMTYQeOepz+tkl0CVzqxMsx+c5NREg
 3yfJg+wL/lWf70qfRGkoWS16UBQDgA8B4DWVaewhmN77PhsOtOWw65HXJEQkWlI20ETQ
 NuAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bTk5vcYR8pi2e5/lQNvnOQAYENjfWWfdZ4lkpyYPlYA=;
 fh=QlK4U3b/0Xtf8J4zPFfTFQ5Z+FdSWnSEthxZdfZUYQg=;
 b=dIW+sch5mE5YT9YCGPxulKsDqQzYFl1vSzzlN7AdvohP5YfMT+vGUg8z+o0+3EZFHG
 /m8hoCbO/CNE1MHAUB3+0UGhbviRS7wO+glfGuIWiBfaf26MQDlD10n6zKrVN7D3RIUP
 gReJhW4mEoe8GP5myVeU7LmUFqjvWLlaa9oJDejXe+lERfjWfERM7L0POK0ldZ4e7kxW
 0n03AAJJ7UZ1CETfZtRgIy2Zt+fNC8UMSFOA4BlnkXaXrVRdacYQjE+O1fz15w+RqQlR
 XS5A4aYZhkKDAQJkQn93iN3buN39+hNklv/ExcnsUHNX5dRjJ8WsgO4qH420ctj1d/js
 gVQA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787657127; x=1788261927; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bTk5vcYR8pi2e5/lQNvnOQAYENjfWWfdZ4lkpyYPlYA=;
 b=CI2w5PPlAQh78VRcTssgo6Qh4WIGTHKOrfZrIP605tAe8e4La+W18MtLgV2NdNOalP
 kiUp27yWZaGIxg+0iY9nJU5xwHzmTKTTM/DCCzb0mHly18okCkb5OUWCvtsIsK3rTlEG
 FyJ3I8o9yjUbgryKGQVkf/q0lNnGaadbyLQvx4i6oZbYOuujOa0OoIjikwc9RNqlPZzi
 i+awccgkW4tVSipdsOjZhcUx7RHtxQloTS6974zpx3o94DdilcGcagbiYLgBtHn+oat+
 3fPgwwcsV21eE1M4/byEfcdWv+3VTTtglWbScwosXbIXp8m7rq1+lrBvGGbTUaqG2Xk5
 zjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787657127; x=1788261927;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bTk5vcYR8pi2e5/lQNvnOQAYENjfWWfdZ4lkpyYPlYA=;
 b=YLb1tMmeLi+xvUuWBe6PBEcjfe7Hr635ii9asiVeXsz59Idi0EhF4SLuMbkIMPwVBe
 oS7/3J2aVg5pA/+5KQIuB69igCT2NrV3yZRX/M9STvhvgYriKpKGSaAbiE4EO/dju6ou
 IPDHfWtZP03l9w9WuVA0LfyC7YNbLdkmFn3+VEG8A6hufA/d98oJ3k/J5Cxg6alPUKLz
 LgyL/qdXbVCvJ3C0HZ+rE7YafFsg/ue9PEKMOSNd1UvXCavFMdkNDfcTU/Lmi1fRdoYy
 Zu2bVGuUkt85JZILNyC/ZtyyAXMmP1UduiJX61GLuBXp0+U5uHwa5/hkTz1LI4uQsbuW
 fcxg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCxYJQMgCkk4JLjNb2/rcPt2QN9yKpVBSb7XyLYBs/RzqaZwP/h1qVn8GiKZX5+hjU/xxi6744@lists.freedesktop.org
X-Gm-Message-State: AFuF++l/qpIW1WVeGf68JvvJF4YTyPJveiizBwG5+uCc+isG9klXZl+Z
 2H4ttPMTFt3ibYa2VONyJKwvu8s+yZeKec4WydESQFrr9bggt2WiNyHVHOUAzkj5BS0lamZXlw2
 55Ab7fEameg4ttRntFxCRF+y6YCguTAs=
X-Gm-Gg: AR+sD11uaw9YweOvP6IzvFImJ9G9idJHuyAav8RmGMvW0IfcGb9YcOx6sN833DCcdnJ
 v9z588lZ+tQpl2BqyPa6MlcEwGz0aMPerRmUHtOLGErebd/bRYEK0uWMubrcIE8omfJSzqKLEtO
 NCOpV8B0jD1gHibUkRJnZ3nN1lavvUvWm3OlrRx5tei9xio1NYP5PMRNr/pfNWps9e4f+FsJc29
 c37QL4Hi1LvZ9l3pb9cyV466fly1GSQfTy1+xyAQGOnsg/1PIho2H/yxnT5EYKaavF9x6cCwHgS
 hI+cUe2NvDzaDXFYsXFLcJK1qJNH8mZ5a1Mn4KGacrsbNXFjjJIuc1cU1rhPUXBy/5IZ4kCnENp
 qChc=
X-Received: by 2002:a05:620a:3902:b0:936:ab1f:6aa4 with SMTP id
 af79cd13be357-9374685c16dmr2214475185a.1.1787657127090; Tue, 25 Aug 2026
 04:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260813143605.106104-1-mwen@igalia.com>
 <20260813143605.106104-4-mwen@igalia.com>
 <512414f0-ca55-435e-8ca3-7dbf48d0c114@freenet.de>
 <2b6f24cb-c387-4174-9e81-0a1a7ef42581@freenet.de>
 <6faf80d8-2972-44a9-93f7-39ffee0d1fec@igalia.com>
In-Reply-To: <6faf80d8-2972-44a9-93f7-39ffee0d1fec@igalia.com>
From: Xaver Hugl <xaver.hugl@gmail.com>
Date: Tue, 25 Aug 2026 13:25:15 +0200
X-Gm-Features: AcwNN1WgZlGvTNsBsAB_EDQkX72P-7AQnIjXxJ06yMCsNUZTXib0L-LoQc4rjh8
Message-ID: <CAFZQkGxwOQ6a+ZmjfNE=BnKV3VosOm6A_7=3rmWowTTwZsD3Tw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/amd/display: advertise PIXEL_NONE as blend
 mode for DCE generations
To: Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?=
 <viktor_jaegerskuepper@freenet.de>, 
 airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com, 
 daniels@collabora.com, harry.wentland@amd.com, leandro.ribeiro@collabora.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 pekka.paalanen@collabora.com, simona@ffwll.ch, siqueira@igalia.com, 
 sunpeng.li@amd.com, tzimmermann@suse.de, Alex Hung <alex.hung@amd.com>, 
 Daniel Wheeler <Daniel.Wheeler@amd.com>, kernel-dev@igalia.com, 
 Lyude Paul <lyude@redhat.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 25 Aug 2026 13:01:27 +0000
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

> I suspect KDE is not interpreting correctly the blend mode
Yeah, KWin made the assumption that pre-multiplied is always
supported, since the documentation said so in the past.
Thanks for notifying me, I'll have that fixed in the next bugfix update.

> I think we can keep it working as before by adding PREMULTI. In the end there is no overlay plane for DCE, and PIXEL_NONE and PREMULTI are equivalent when one primary is composed on top of a black background.
Makes sense to me.

- Xaver
