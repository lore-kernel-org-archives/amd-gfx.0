Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4D9C47258
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jan 2024 21:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 381E410E8D6;
	Tue, 23 Jan 2024 21:07:53 +0000 (UTC)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com
 [209.85.161.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9909D10E932
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jan 2024 21:07:51 +0000 (UTC)
Received: by mail-oo1-f43.google.com with SMTP id
 006d021491bc7-59969ec581aso1972760eaf.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jan 2024 13:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=umich.edu; s=google-2016-06-03; t=1706044010; x=1706648810;
 darn=lists.freedesktop.org; 
 h=user-agent:content-disposition:mime-version:message-id:subject:to
 :from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Lv3cBdtly9zro2A6oM+YcF+4ZmTNcsN/WZV6RGAgtnA=;
 b=YE1i7zDarPoNgq3/llXazkCkSr67LXUDp3baiiNTbxrZFy3fiOHSMiktZig6B3cC5x
 D9VFyeWPY29/i+5ep+zfy8ytHByxhamtI4Yr+ctFgMFbTsLzgCiS+zoF30XyUKAcgtoY
 YgvWu9RY6D6TQVmXns3u1J+4DNV9ppqHiWAhRg55cTlTiXk49FN2bHvk8i4UBVqnXUcU
 Vy8M5isLEkNs+0FyUC60wmY4lkC0DgZiQOhfP/GFgQSvA5Z2OXgzJE1bGVI9EbymWmYu
 IEuYgisiOmo8aWTtdjmoMIdOZujTevT0KUICBmH2OpGbjUUB6stles+ZKWfL+hA3d/KQ
 m3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706044010; x=1706648810;
 h=user-agent:content-disposition:mime-version:message-id:subject:to
 :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lv3cBdtly9zro2A6oM+YcF+4ZmTNcsN/WZV6RGAgtnA=;
 b=hLMltmOxVmMXqxHgaB0Y6jy1/g4aMq07ZyzDtkw4FcEaXSEjUfHKBnJxrbXp9IsHV4
 C59JM1ZcY+9XhGDGsb4EhsvVMebaWr1G9LCpDNviBjl+d3K8DrKHJhz1EbO0/X9USYY+
 /YozwzTDMk9SFrT+n9qItw2DjzTsq0v3Ci6mbwd3Y4gMBDtgDOJ6AqKZjp9j2pJORkP3
 /ux2SpKNhfyOXaztbxFjOkwguRQ9skMAwnbyiCQG/k27gMQTBW1jz3qEz4okWPp4WI61
 DuqN4O+X/N+19w3N8ksiZXJHzlDGRnNedk9HsshEpx073LJppLYJwzC37POmY+lby7zK
 zSyw==
X-Gm-Message-State: AOJu0YzNmrzm+h9vJuuCLhoHeEI0S3kcpyBx47+7UJeSNAmmQa1bY9pp
 gGpHbhyNXZ1806PaV5J7fiXbtM4b855swgxoRT69Z/iIA8/82q3ar7vFE+USMvjTcQmLGMNiW4t
 FxJ0CT2Eiqla2DBtZqGHP9Hxaa5twwQPmMU/MckS/7L7zWn5sew3XkRDPgixRMZDW4dvE7HEckU
 AMsOecCxQsQ42gu+M76+AcpVb5Ij076fEjZsLq
X-Google-Smtp-Source: AGHT+IGz3Si9jBdF08dpD7rjZ2HBDsVlOhaGOUorHAXWLm/axlnGaulsrhsXXEFKZKbRED+ENrfEiw==
X-Received: by 2002:a4a:de4c:0:b0:599:9e55:cedc with SMTP id
 z12-20020a4ade4c000000b005999e55cedcmr539725oot.10.1706044009770; 
 Tue, 23 Jan 2024 13:06:49 -0800 (PST)
Received: from localhost (162-232-88-33.lightspeed.livnmi.sbcglobal.net.
 [162.232.88.33]) by smtp.gmail.com with ESMTPSA id
 k9-20020a4ab089000000b00591d271c95fsm4611938oon.4.2024.01.23.13.06.49
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Jan 2024 13:06:49 -0800 (PST)
Date: Tue, 23 Jan 2024 16:06:48 -0500
From: William Bulley <web@umich.edu>
To: amd-gfx@lists.freedesktop.org
Subject: Wanted: pointer to FreeBSD Radeon expertise
Message-ID: <20240123210648.GA1477@dell4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
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

I don't know where to ask for help with my Radeon graphics card.

I can't get it to work -- always says: "[EE] no screen found" or
something like that.  I've read everything in the handbook, and
several related man pages.  I can't get it to work.

Surely there is someone in FreeBSD who could point me in the
right direction.  Can you help me?  Thank you in advance.

-- 
William Bulley
E-MAIL: web@umich.edu
<web@umich.edu>
