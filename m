Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F494C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jan 2024 08:42:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E87D0112E49;
	Tue, 30 Jan 2024 08:42:46 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A00F1112B76
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 22:20:50 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-4280f3ec702so9339771cf.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 14:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706566787; x=1707171587; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rXIXfE1IaW1LDC/wdh4qZU8N1MZsXJXUAM05+N35GNs=;
 b=U+cIrsWT8MJEOFaqK53TzMW4k0qsdDG7hiod/rOOuqasZn2lOV3GBBUg9ce7WRO32J
 0MW1SSRAf8knJvGa9uOj++pDC5ZDIILc9XYE0d9jG5srPJRT4sfgLk9YoyR1r/MIA5Dc
 hX2B4DBHpqy2D7Uvu6N+K33D0NMOsnNHHYoGZrTLV562kvQz6tYjju8mDiUgqN5uS9cl
 FjxEPjELxIA5uhcLBW0jV3ub8AKlLDD0/D0WoKFL38xh9q5ViIr4VqMZw4I0Y5t4n73J
 Z1gQoASYNff3cXJ5aS9eWVC3SSy1dqOcJVOxjw57f691Tvtn5fDTpXH6bymagFsICaGH
 sdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706566787; x=1707171587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rXIXfE1IaW1LDC/wdh4qZU8N1MZsXJXUAM05+N35GNs=;
 b=edxhBF5RyC5BwPsP1Dk5JfcHZnAjl0eRQFt5qeTCZp9C0Cq2rOFqlugn8yjX5bWLw4
 4X87Z9LnZkYU/IJk2kJSM//zYMhzk/W7HlouOF2XlV9MNiBpU784MJduKCN6d9Fztsxl
 34b0FyDGKqeTYu3yOCXUvnt1EmYOt0NGD/X7vF8W5hCvEwCRyng/IN529zH7hdCBqy/p
 ontQq3y/MbFWgdNXimLXjBl7unJkj/wLpEXjUsQ8HQdjU2TGKGvIwmk9yywC/ILQcbip
 fQdloYAjcx1/8GOQMRRYcjT95pR+M80n6j9DqMOC8aveqFuoS3/hwYW0PvSJ7isyDvZk
 ToQg==
X-Forwarded-Encrypted: i=0;
 AJvYcCWrdrzwjuCwSorcHTUHi78p/suVpWSEAm4NWYDcwoOQ++2aQPLpukrleIguEfPIs9Doi9cXQrMa3SuD2IGTkbFc/ICJj3+Iw/+z1j+TWQ==
X-Gm-Message-State: AOJu0YzicO5t+xArrF+gY9FA0ckQZ7lbXvEar4BvuFQNykj3dqFzcFKt
 JQDxGbONGZ4oiHyGLCIgRp+M3h0hQIVJgiwng4AJjPyJ1a+6Idhl
X-Google-Smtp-Source: AGHT+IH0q8D88BVwnCXKJ9VHC8a29Z0VKkrOf3H+BeqLkLV+1WD6BqZaCfU+dIJh5KMU8L2q3Z1GlA==
X-Received: by 2002:a05:620a:2455:b0:783:f7e2:8feb with SMTP id
 h21-20020a05620a245500b00783f7e28febmr5668393qkn.4.1706566787087; 
 Mon, 29 Jan 2024 14:19:47 -0800 (PST)
Received: from davidm-laptop.home
 (hlfxns018gw-134-41-187-249.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [134.41.187.249]) by smtp.gmail.com with ESMTPSA id
 x12-20020a05620a0ecc00b0078366823711sm2009468qkm.119.2024.01.29.14.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 14:19:46 -0800 (PST)
From: David McFarland <corngood@gmail.com>
To: mario.limonciello@amd.com
Subject: [PATCH v2 0/1] drm/amd: Don't init MEC2 firmware when it fails to load
Date: Mon, 29 Jan 2024 18:18:19 -0400
Message-Id: <20240129221817.8797-1-corngood@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8bda643f-314d-4947-83a4-8ad536dfdc41@amd.com>
References: <8bda643f-314d-4947-83a4-8ad536dfdc41@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Jan 2024 08:42:45 +0000
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
Cc: David McFarland <corngood@gmail.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

> Sorry to be pedantic; but I realized after I tried to apply this is
> missing a S-o-b.  Can you please add one?

Of course, here you go.  I left it off because I wasn't 100% sure about
the intention of your previous change.


David McFarland (1):
  drm/amd: Don't init MEC2 firmware when it fails to load

 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 --
 1 file changed, 2 deletions(-)

-- 
2.40.1

