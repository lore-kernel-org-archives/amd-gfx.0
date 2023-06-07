Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDBFC7EE2E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 09:37:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BA3010E49E;
	Wed,  7 Jun 2023 09:37:56 +0000 (UTC)
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B8CB10E49E
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 09:37:52 +0000 (UTC)
Date: Wed, 07 Jun 2023 09:37:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1686130669; x=1686389869;
 bh=/37RiszT2hQkqefLXSWgn0PU/fXLOedYWzon5kBfTN4=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=GBWhjcPdoqCnveEEbJmt/yxGnkDBtWA1BUlvmhR8XKVJi5gj8vzLrvOV9zJkmtPxJ
 +dN/y3J8+ugQPuRlWcWsSUizo7P4rCv8eTdJ49MJLRIHf24GgIHgN0lKDLLhhwwL4p
 SwCJcLNH8Ru1A64ACawicz01uSLm9qValzkWawrzH5SJxPCdIORlpyHzqNkB/5HRlh
 EyYedqNG3qeWHAYIZSvV8H2n4Fxn2wN099l8kfbZeDaemnNVCylXs6G2cyKJwsdKsD
 LUcn+qSgdiYd0HfLuuNd2KJOSziphIBrbrv4SQlu2YtqObxEDVLnGrRAlOp2wUaNI5
 EvchU7xGQT4yQ==
To: Harry Wentland <harry.wentland@amd.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v5 04/13] drm/connector: Use common colorspace_names array
Message-ID: <cmrrldxWMcHBZPTtrtNWKhTmgBqdJcEl1XAHvp_OS3RQMTjVk_wvYkwmDYJNKX4AWIVR_GkjJcackYtcKfhQHD1_LirFv2cl5hVn7q3vnC4=@emersion.fr>
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

> We an use bitfields to track the support ones for HDMI

Typo: "We can"
