Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4886AC678D5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Mar 2023 15:13:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6514E10E50B;
	Tue,  7 Mar 2023 15:13:20 +0000 (UTC)
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4E7810E4F3
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Mar 2023 15:13:18 +0000 (UTC)
Date: Tue, 07 Mar 2023 15:13:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1678201996; x=1678461196;
 bh=OIIWWI7n50ipHApkP2JQXFesbGEEpFpiDmFcAw6aH1w=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=syQyoRe6iu5MFT2ATrKo8jZt/sImaY035/q01835cQN7zzlES8Z90REOLDENNQX/f
 AuPzMpRe6bgzY5Ux/lQFTQVAbjKDuM3cL20j+THDLK8gKr73Wqb9gXLM4Hq+BHzfwX
 p16ch9uQkMYdV4QKumxg+9RZfO+BaK8Wg534Ju1DkSUIPC4VCtIaQCBW/0XT7LFatO
 Cp6aTtnzWNaLvxabr6UItfwi+8VVLu2tSzSf63Ao18EC2FenkJII2Rqud7zntrExiF
 tq8BCFbzIlu9KLImS1rZN8bx2l+R/27XdsWzByOJ/JO5r4zAq5RAvLpARWFk5o64TO
 Mr6OROH4jkJ1A==
To: Harry Wentland <harry.wentland@amd.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v3 01/17] drm/connector: Convert DRM_MODE_COLORIMETRY to
 enum
Message-ID: <vT46Q_J1ih6YRi8a30VhwbuI43l7uCbTnS9ReApjeTZFD79HaDTZ-9FiNu_sS4iDn-XHhOsQYVQT-Bc699_qGmqMSSyc6XG7YYHVq-EJ-2s=@emersion.fr>
In-Reply-To: <20230307151107.49649-2-harry.wentland@amd.com>
References: <20230307151107.49649-1-harry.wentland@amd.com>
 <20230307151107.49649-2-harry.wentland@amd.com>
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
Cc: Sebastian Wick <sebastian.wick@redhat.com>, dri-devel@lists.freedesktop.org,
 Pekka Paalanen <ppaalanen@gmail.com>, Uma Shankar <uma.shankar@intel.com>,
 amd-gfx@lists.freedesktop.org, Joshua Ashton <joshua@froggi.es>,
 =?utf-8?Q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Vitaly.Prosyak@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tuesday, March 7th, 2023 at 16:10, Harry Wentland <harry.wentland@amd.co=
m> wrote:

> * This enum is used to indicate DP VSC SDP Colorimetry formats.
> * It is based on DP 1.4 spec [Table 2-117: VSC SDP Payload for DB16 throu=
gh
> - * DB18] and a name of enum member follows DRM_MODE_COLORIMETRY definiti=
on.
> + * DB18] and a name of enum member follows &enum drm_colorimetry definit=
ion.

Nit: the "&" is not necessary here, "enum drm_colorimetry" alone should
linkify properly.
