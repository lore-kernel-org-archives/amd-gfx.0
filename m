Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E765D1625F
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Oct 2024 12:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E541110E29D;
	Mon, 14 Oct 2024 12:50:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m6jjrEpo";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 402CA10E259
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Oct 2024 21:31:06 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-37d4fd00574so2048255f8f.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Oct 2024 14:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728855064; x=1729459864; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5xmURMaQB+kGaBR3ftXlO/ng8uDZS60gJunFqpNO3LI=;
 b=m6jjrEpohmCitoy0xrziwRYYCUT7cQ6O4lCXpF0rAXGFa1GCtlYUyayCCJ7ckqA+Ff
 TemBhLJkeUMPTMQPHWSbYkG/NPcfRAT90wxF+PFfKpJOFsyS1VFMKnuThIOYaORMX0wm
 YlC+iCqHgpgFRTlQF441dUywBNS4Keg2lVIoQE6ebd+YorK9DgWiWoj3YcgCqJ4OEBhf
 A+/Ox8Z4jRwKBBAtNfaFAfgjqZzWYXQx0xWgDvX/Os3F+A0V2n2Ta9b5vi/8iXY7yoDN
 E1t9KP19/NbIm0kaJAHMtUcK1sZq8XcTnsKWds2LA9G8+LaMrtkiv9z4jxgLPe0AKE5X
 mXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728855064; x=1729459864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5xmURMaQB+kGaBR3ftXlO/ng8uDZS60gJunFqpNO3LI=;
 b=qamFAZoaDTWnxXcHx7NFGyow+k+rVG2+QxHbIYiUdAoBakB188uLLtJ6tjtaMDiyYh
 aqcQspJW687LyAMzjjmHuqmkJRdKNHxg3tWtavm9G9FRNToJlItO/KmEUQk9V7NblTIt
 8B0qaV5clANNxO2jGNtB2bE4Zf2PxNaRtnkuyl+xARp/sdO15ksem2II8NfYWSLLpGVh
 rVuVDZO5YQS1eHAXdhzrfOVixHVq/tm17WaYQ1IacCSmZvL5YIvPnRY0JQSPmbyC0bBl
 vK2OJWxClxhVP3XNRbua0YObDvOnxiNIkLQIW52jtxfY3V6Bcudl5vOPpgGrRM6QpXKw
 nGtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx7Mr5sR0DznYs2xr1F1+TJ5lbOArO0UftknQu53sT0SVx6Me+NouOLnyynzDjbsLH5pTLqSXh@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxB4NI1JyG/TuAIzM2Dksg5c01f4oAXN5MV5+My9D8ArDuIi9M9
 9jrjTucz+DiXg12NBGh3/7LNjLv/t5rEqHeCcoh+pkfOJHAcHzGA
X-Google-Smtp-Source: AGHT+IGz9v7rDMqSJARiljy8htrk4kg2Dmg1qxC2+iB38XQ4EDYnr7OU5moms3j0Ydhr9mjD5DBZOA==
X-Received: by 2002:adf:f805:0:b0:377:94b:4f51 with SMTP id
 ffacd0b85a97d-37d5529bc83mr6691981f8f.22.1728855064210; 
 Sun, 13 Oct 2024 14:31:04 -0700 (PDT)
Received: from localhost.localdomain ([109.175.243.76])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d4b6a88c9sm9639468f8f.20.2024.10.13.14.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 14:31:03 -0700 (PDT)
From: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
To: mario.limonciello@amd.com
Cc: Hamza.Mahfooz@amd.com, Marc.Rossi@amd.com, amd-gfx@lists.freedesktop.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: Disable PSR-SU on Parade 08-01 TCON too
Date: Sun, 13 Oct 2024 22:31:03 +0100
Message-ID: <20241013213103.55357-1-stuart.a.hayhurst@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240205211233.2601-1-mario.limonciello@amd.com>
References: <20240205211233.2601-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Oct 2024 12:50:04 +0000
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

Hi, can this be considered again please? Still facing issues with the 660M in
my Lenovo Yoga 7 14ARB7. This fixes the weird behaviour I have with black
screens, back-traces and flickering.
