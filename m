Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DABC83F15
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Aug 2023 09:43:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1515110E4DE;
	Wed, 30 Aug 2023 09:43:05 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74A2C10E124
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Aug 2023 09:43:03 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-401ef656465so861825e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Aug 2023 02:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1693388582; x=1693993382; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=viHZkgSW0z1TbhhriSlmivc4PJ+sy0cGul8lmxZzVUY=;
 b=g+KgPLG8bbtegTtgRrLa9pOtKKEc9diQ7fJJWY+JwcWva8oionMa3DgpEWPy8n0+SI
 AeU9AT2P+g4fXqIF78t8TUQypWGdHKNuuSZrJezS5MFb953WVkP3i32vrzmFMNANB5to
 Xxk8PugYg5lvThGLw9LUWZwbGih3+zsDmQaBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693388582; x=1693993382;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=viHZkgSW0z1TbhhriSlmivc4PJ+sy0cGul8lmxZzVUY=;
 b=IxSEk9OodhGn9lO4Cn7v40AUXdimy6kmUHyEr/bmhe5M9WqBWPgPL+9hpAcoW5biuo
 azTG4TMTey7YmDsTIT4i3OnGrWkkEv3CWlrZNS9eUQMu2F/3gWmrGuYzavwZcGHluVhH
 /D68VbimGZ/AMbRlpHch8pq/hfjCLBCeV5PcDTiIWqMrMs6YdLCk/+sa0NwbTDDzy4TO
 jTsG3R6ctg5INZZxIpKB3WixnudjgGxxel8TptFNtyG7PmZtJBN9zfZGM42O6cAaKob8
 cKnghdOp5s9wXdvoATENasHR9qa72AUbCgvwCTX2kytRYOg7MhlYWT8c4+jGjmABFccH
 L15g==
X-Gm-Message-State: AOJu0YwIQ6PIIlcmeEm8zB33+HJKQGBWEvvWy64sQ6IOUpTk7uUqRSP8
 x6hxZF3T5SCcUsUEEKQVcPB3+w==
X-Google-Smtp-Source: AGHT+IGUucwXdtUXAYEetJnCsYJnlfqFZQvjwqtcvIW1PmgoCi2qMZX7yrpGdZp9lI5heUgjRDnHrg==
X-Received: by 2002:a5d:4101:0:b0:31a:e54e:c790 with SMTP id
 l1-20020a5d4101000000b0031ae54ec790mr1238582wrp.6.1693388581246; 
 Wed, 30 Aug 2023 02:43:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 p14-20020a5d638e000000b003176eab8868sm16075188wru.82.2023.08.30.02.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 02:43:00 -0700 (PDT)
Date: Wed, 30 Aug 2023 11:42:57 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Jani Nikula <jani.nikula@intel.com>
Subject: Re: [Intel-gfx] [PATCH 0/4] drm/amd/display: stop using
 drm_edid_override_connector_update()
Message-ID: <ZO8PIQ5PluPGuz7t@phenom.ffwll.local>
References: <cover.1692705543.git.jani.nikula@intel.com>
 <788721f6-afff-e0b2-db7c-32ab2dd075a9@amd.com>
 <87il965gob.fsf@intel.com> <871qfm2kg1.fsf@intel.com>
 <CADnq5_P49U3dcqiZhB-CjS8UbOtB7K2jNObS0ZQqMhOr3UhLQg@mail.gmail.com>
 <87o7ip252r.fsf@intel.com> <87jztd2332.fsf@intel.com>
 <1e6aa1ff-9aa9-6b2f-84f4-e0304205085c@amd.com>
 <87h6oh0yz9.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6oh0yz9.fsf@intel.com>
X-Operating-System: Linux phenom 6.4.0-2-amd64 
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
Cc: Alex Hung <alex.hung@amd.com>, intel-gfx@lists.freedesktop.org,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Leo Li <sunpeng.li@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, dri-devel@lists.freedesktop.org,
 Wenchieh Chien <wenchieh.chien@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, "Wang,
 Yu \(Charlie\)" <Yu.Wang4@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Aug 30, 2023 at 10:29:46AM +0300, Jani Nikula wrote:
> Upstream code should be reviewed in public.
 
Yup
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
