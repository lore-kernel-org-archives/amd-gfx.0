Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CECE606A323
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nimJVxLT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91A6D10FABC;
	Thu, 12 Nov 2026 13:56:20 +0000 (UTC)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9282510FC1C
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 16:31:41 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-170135e43c7so1150494c88.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 08:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794414701; x=1795019501; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mVXVpcIxf04fTtGzwVKXj/X6mhkeKnV3VwdMgeKl5U8=;
 b=nimJVxLTXjFvuRzCiAYkFWdRV/3FGIikMoJzchTHLi02wN8HUl/zRDWyk+slQYXv6F
 7h61+p6tC17EL9WP4UM+YbHVzynx28gjAz0xcX/iW4bEl4WBBbQ3bTxKRdtDE35MtZgc
 iRRcT+gdLGFw8PUrVgf5m/R0eMPy3FU33H09MvRUrW1M//f5PwISmRZH1O8EvmnYj414
 rGN6wiLL0DZ/JrGdUHeqybZTJmpxQP4krNk4EeYF/ZOfLs7ZBJwtBPUgFOrmkWSXJLvZ
 0JijJ7fQiptYZE4OliqKa+AUqYE5y/xA+F7xS/GiCcS3g3q1jd1TpYC0TIOMug6yDYox
 MqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794414701; x=1795019501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mVXVpcIxf04fTtGzwVKXj/X6mhkeKnV3VwdMgeKl5U8=;
 b=2b12kiUTNzc3Q72fbTDA8pxrdLWxUFB7yFk/p4xaoZ4nehbeCR23qtBAR60YWFLfXW
 ce8a6dmud2jLj7IQ+tUaL5OV0gE9CD/gRUp6KROu+TS7wgbXaELPKNVa3PfAWE2gDPGy
 GpDGZCDfHJFOvIgk25ZDcHnqFTZAuz7j5cYbCx5HfLvn8rKw6JI+X8sQuEaFSiKIJROF
 KkbhB82U5KuZG/jkj3l+7tK6+uRBFx5K/jKW+qXaFmpelZhbKxnqp9BjgKI+CDbFaOiR
 16SsplIaGQ3asrmRVnJyCNJ6WZvBqahJ5F0CqGAcIH03ii1xkTybPILdO+FdkpXG99wV
 12DQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEfZcjS7nQmZivC7PicLy/DzAqRjQmiC1tBoEChsHqTVGXYwl1jiVSNvaQJgQqayVXcootcOuOM@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+Z6LE6mxKSaqHQtgFilVFrj76jPmrGknDJzD6oTxbEhMHBfj/9
 h337RfDFjSol+yfifZAND1PYW2pi7TitAxr6Vy7LF/I+FSqXuxKOfhlQF/73GJxHYoc=
X-Gm-Gg: AYBFou06m5mP+kDhhApabMlAJ3dWlncg7OJHgBt6tmfrxrM1Nc7hUhj2TftxuH57VGe
 KnfmucASVcDZzoeXfW2Hu8yf0W78PHPw/jQ/NJit/nRSQjoiZH+Iux+fgDln91btmYbXa1BoWLm
 Q9KcCvk2GsE3EnVPbYt5bWYLNZe5aVsMPuI/pw4Mx6jS6ywfbIdNEBsvUjnq+5Fv14I29Ln5aJs
 /2MKUBWC77KlFJVEdMy7HGFwrMw2WjoZGvNsF8KwwbE0a4RCy6P2znBRQdbK9FyMTYwkyr1WP72
 +fY7Vq4rmpqVzAdj9Z3rQGOe6wOWbJNFPaNjuST7iAlnRY1Z4exRAJjSe03Lwd+MbTGdMK+7gDJ
 qoGS9AoJ5hjL8KJfmutalzRgXRjY3K51Cdu74zNDAZh9k11H9h4VIELl0xuwbuxrlITxf9JTKgc
 +VEgfe55y4ni7a3Dvu9gNpQeQRBw74ugsCnNRfEUQAqF+2cAxMmNOPjyxvRfWcrySYQ5/WUu9Pi
 TJHH/qD8fmEYT3Y2Hj7wQQ6lE7T9vNGV+89DTgT+d+fqXzZVfWdehAKr4W0ksA0rLL9Kd7kGAKX
 TT9IjXbYljUTpm8pQlDU/5fckka19pAsBUh32pmQuui7AB41yxe5pRhCuLclYLyZdOEhjbnSBYz
 76GLnspFvhwCNnIbxGx4V+RO5v6U=
X-Received: by 2002:a05:7022:7e09:b0:143:868a:20c1 with SMTP id
 a92af1059eb24-1b3c0366cafmr3066679c88.46.1794414700262; 
 Wed, 11 Nov 2026 08:31:40 -0800 (PST)
Received: from localhost.localdomain ([2405:201:301c:f8cd:1808:a1a7:f209:e018])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3b5b11150sm23661200c88.5.2026.11.11.08.31.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Nov 2026 08:31:39 -0800 (PST)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/amdgpu: fix kernel-doc in amdgpu_ualink.c
Date: Wed, 11 Nov 2026 22:01:23 +0530
Message-ID: <20261111163131.25965-1-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <CADnq5_N7zDDuE-S6Jyg7q706H3SW6WuM4eOTBcEU90boYJG=PA@mail.gmail.com>
References: <CADnq5_N7zDDuE-S6Jyg7q706H3SW6WuM4eOTBcEU90boYJG=PA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Nov 2026 13:56:07 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 11:21 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> for patch 1.  I'm skipping patch 2 because I find str_enable_disable()
> harder to understand and just as long to write as the current code.

Thanks for the review, Alex. For what it's worth, the helpers were meant to
keep these strings consistent across the tree, but it's your driver and
your call, so consider patch 2 dropped. Thanks! Have a nice day ahead.

Aryan
