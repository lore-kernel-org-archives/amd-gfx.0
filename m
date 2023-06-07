Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3527EC7EE2F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 09:46:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A56A610E4AE;
	Wed,  7 Jun 2023 09:46:40 +0000 (UTC)
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5918210E4A7;
 Wed,  7 Jun 2023 09:46:38 +0000 (UTC)
Date: Wed, 07 Jun 2023 09:46:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1686131196; x=1686390396;
 bh=cJbxiYRG4+GDcR8+bOjwETCgvvOXEPXxSJzUF6F0cAY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=ZNd+UkS+c647LbF7iWHUUUgB5TnstAL29F0rlapzMyMnpVntgTYW3vdPKi1xDU+gh
 2ZddtVx+tDbLuR+pzqALzWR5hD2G62AGg15g41Kh/Cwo0t2F2WxBthN2O9zPmSjKon
 Xq+zhr6+2Pt6K+T8EC9m4lRn0rNu/H2NazMlvYPs6U/KbCLcLEJDTiF0DBDQz8Tzlt
 uW8pWgg+GWlpLGFVEl2bCC3iakRKF06lwRiaFw21+Quy+eq91t3yuvgCqjxizxgM9w
 4J4TTFA/K7er+O7wOUa09kSRWNZFWVn4mRMfXZZ51oYTtbADFGBYOPYi/vu2xNMx+3
 NCxNKAAbDBJoA==
To: Harry Wentland <harry.wentland@amd.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v5 04/13] drm/connector: Use common colorspace_names array
Message-ID: <FZ35H51NfkJ9AW7308J3UnZV4tkbehUMp-hAeohZT0-sfWYnsNEHFSa3VHD07WcisBW3-6yhcbCG-D_qfOCi1VKQGGFj5T0ed4Mjhm0kkvQ=@emersion.fr>
In-Reply-To: <20230606202607.122914-5-harry.wentland@amd.com>
References: <20230606202607.122914-1-harry.wentland@amd.com>
 <20230606202607.122914-5-harry.wentland@amd.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Sebastian Wick <sebastian.wick@redhat.com>, amd-gfx@lists.freedesktop.org,
 Melissa Wen <mwen@igalia.com>, Pekka Paalanen <ppaalanen@gmail.com>,
 Uma Shankar <uma.shankar@intel.com>, dri-devel@lists.freedesktop.org,
 Joshua Ashton <joshua@froggi.es>,
 =?utf-8?Q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Vitaly.Prosyak@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tuesday, June 6th, 2023 at 22:25, Harry Wentland <harry.wentland@amd.com=
> wrote:

> +=09=09if (supported_colorspaces !=3D 0 && (colorspaces & BIT(i)) =3D=3D =
0)

This patch actually also introduces a change in behavior: passing no
colorspace will make the function advertise all colorspaces. I have a
hard time understanding how this can be useful: we want to either
advertise all DP colorspaces, or all HDMI colorspaces, but not both?

One way to fix this would be to handle the "zero means everything"
behavior in the specific DP/HDMI callers. But I wonder, is it really
worth the magic if we can expose a simple const variable with all
DP/HDMI colorspaces?
