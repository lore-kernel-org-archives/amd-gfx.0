Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282BCCFC276
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 08:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C55110E531;
	Tue, 15 Oct 2024 08:08:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dYzx+t5/";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0BA110E143
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 00:30:18 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-37d3ecad390so3742671f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Oct 2024 17:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728952217; x=1729557017; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WqzwA+or3NqGNBho9kDhIYHCDYygL6ZXy4nRRa0QQ3k=;
 b=dYzx+t5/Y+sUATSHLp1S74rTrY0vM4IhlxOsL5Pgpm/xTN2MU/VQ6Yo45/8YgAJQI+
 C8IwmnGDCZ24d3R3FmSXwmy6a5lu6VrnX5sXpHWczKpL9sCEARr8FnszACPAGZ6f03ZQ
 etEJgmSjgDha6Yd1/PnZKgq0zI0jHsPp3P4ma+kT6vhv31LB9Qe8nhqhiDMuT3fwxv2d
 HrCwiwRfPbiyVcxwpC8YQta7cagU+VtUhyJDsPZJYG3CDcPe/YwHRXGbL4h/Wivg7/A9
 ImXhW6h7memwXHVAf4ip0AgFfXmH4duUjXrNHNPwVwRnWQDHjyXmDZBcVnActklXxZnY
 CIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728952217; x=1729557017;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WqzwA+or3NqGNBho9kDhIYHCDYygL6ZXy4nRRa0QQ3k=;
 b=T3vVI0XwjHevsADZIRcG5adWvRASMxj8FM3QCmwrcbc3HYbBqPKJB4RfgMSZi8243y
 ATh/P8jo+PZOex1/36CS1sx80TUkSrxxA+xQRvuWUpYaBnqfJwpQqpE3VEAisaxFw14Y
 R9ku6ybvONwEkHj4Qu9wOuXZTFsXAquHp4gRorbpQB1sLGW2kzloLj4FjGQGQXOdFtju
 6YxJvnMLNZA0ftVx0LRwdst5b+1XvfWE2cQ49RxHxuFgWOR928g7kfjBAYdMxxUyVc7K
 Cmqy6nP4y8pwxBoTUGeyTqukkUUiVBmUz1s5k3qbzqGIfV12u2nPVb5SUTKGtOOAZMis
 EkkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsrVzE8G2kA0AilPbM9SLWm+ogKf2CC9g1J6ykqAv37DJL0n4c9kwYlvyF4vAfI6H0EBx7DYxP@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxiQeyUAQzFCY/KgBCo7mg+qJ1aUcUFF6Uk7Ztx+TDiSBHLFZ1/
 YqDcvrsD6dFQBNPFlC/JH4JGpt4gtpFu2vvw+zor6W3mfwQI5YNzznjOHSQTRtzhmLhry6A4Kbg
 ms8SJPxJmd/0WWSqKPovRiYYrTnI=
X-Google-Smtp-Source: AGHT+IFPAxDn9Ocl0LS03WxYc8aEQzGGOLCCAjLOCm3WRw4+Fkxt+cvbLLevHQD36JPExtOkdy+JI3CIpchS01moSbw=
X-Received: by 2002:a5d:504e:0:b0:37c:ce3c:e15d with SMTP id
 ffacd0b85a97d-37d551d9cb7mr9596165f8f.14.1728952217042; Mon, 14 Oct 2024
 17:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240205211233.2601-1-mario.limonciello@amd.com>
 <20241013213103.55357-1-stuart.a.hayhurst@gmail.com>
 <MN0PR12MB6101BA1509A6D9B6338EC8E9E2442@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB6101BA1509A6D9B6338EC8E9E2442@MN0PR12MB6101.namprd12.prod.outlook.com>
From: Stuart <stuart.a.hayhurst@gmail.com>
Date: Tue, 15 Oct 2024 01:30:05 +0100
Message-ID: <CALTg27nH4FfnRi8js8hqh1_C-As-Ouw1Q5FGKm-9Bm8p9c8r+Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Disable PSR-SU on Parade 08-01 TCON too
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc: "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "Rossi,
 Marc" <Marc.Rossi@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 15 Oct 2024 08:08:24 +0000
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

> Is this on a mainline 6.11.y or 6.12-rc3 kernel?  Can you please open up a new issue with all the details?  You can ping it back here.

Currently a Debian 6.11.2 kernel, but I did reproduce it with a
mainline 6.10 and earlier versions in the past.

Issue link: https://gitlab.freedesktop.org/drm/amd/-/issues/3688
