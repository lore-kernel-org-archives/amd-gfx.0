Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7373C4332F
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Nov 2023 18:01:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BD4710E0AA;
	Sun, 12 Nov 2023 18:01:10 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFED110E242
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 23:32:43 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-32d849cc152so1617638f8f.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 15:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699659162; x=1700263962; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1wkd7rIipmMYONgRoY2xjF4x8cV6fihkOEeUr4AhBok=;
 b=KuilRjS3OrhVu1uza5iuKXJgcqNVmzb9cepBwTws7ayAMX3meRAKTsLAE57o8cmDx+
 F245fGX5wohmXYubVG/0EqddaU+FbdhA6XTW8md+cVFZhcnm65mrj6p32RAAjeXhxZUC
 +/pDOPBlimHDA8ZXgk3mtu3tm7i1K+7QUYVPcjUhnxONjoWaD/erc5S+7jKk/WDLdXJq
 tqEyS3pjyNq8PGgiRzwGo/A6NCjlGYAYYtUDysOh1XIQXh4yxwKRYr1fL3eGkc/I4QSW
 F3HqzdRIDCCypSZpc/YhTpNnY5aR1M7WUG6E8DPHyFU1DALYmV3mfdB9gG21cTunkwyW
 5GJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699659162; x=1700263962;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1wkd7rIipmMYONgRoY2xjF4x8cV6fihkOEeUr4AhBok=;
 b=Ot4Oo9BsIh7omsdEJ35+XROOQtiFoD7ScKnHw5XBTfIPOc8NUTi5H4d2BF3d1cdGJS
 1JDUSYaig6jzmCyBKiTlbmBG/8GOikseBxoybEqcLrcJkUSEKV9r8tBrOwcLKdwYNYPF
 e85EN3Kq5FC9v4OuYPfWRsoIROfPccRlDt8FTm7DVFTC/+UHDTb1HybESMNd9BUQPLhp
 Nnew092+NaNTBrocnwsi5Yrkz021bZj3y/Wd8XdmbeIAvLIJhdrHbQfPfzCG60JvOM09
 zr74Ax5aIknS/653HZIStqapFbfHmpSsYTWllthXb8IJDCPJKXGbb7H4Ht5ealJ0yDXQ
 /NCQ==
X-Gm-Message-State: AOJu0Yz4WKJedvlTk8psJ8XjV0mAE3fwGR0Lh1JWRpSIcv9+vE7E3cJr
 qDxMjiAYZWFSFM+tTQgh5+MvqKsrMLvDdSmwvKjGjrhcdHeyJOhg
X-Google-Smtp-Source: AGHT+IFKvVIBAoZz/9YLXCAvVGWjeDaLFF+pjDET/Y9BEeZMk22i22WhZ3o7w0MEEwje0zQQsXw1c4jALJvs7AvOBzg=
X-Received: by 2002:a5d:588e:0:b0:32d:ad4a:bcef with SMTP id
 n14-20020a5d588e000000b0032dad4abcefmr482245wrf.2.1699659161993; Fri, 10 Nov
 2023 15:32:41 -0800 (PST)
MIME-Version: 1.0
From: J Fra <jfra4799@gmail.com>
Date: Fri, 10 Nov 2023 17:32:31 -0600
Message-ID: <CAE584xbGzrZtk6RFtWkP-N19M1MaKWpaoT+zg1WyMikuG5J0Nw@mail.gmail.com>
Subject: Re: [PATCH v7d 01/23] test-dyndbg: fixup CLASSMAP usage error
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="00000000000097079a0609d4bc68"
X-Mailman-Approved-At: Sun, 12 Nov 2023 18:01:09 +0000
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

--00000000000097079a0609d4bc68
Content-Type: text/plain; charset="UTF-8"



--00000000000097079a0609d4bc68
Content-Type: text/html; charset="UTF-8"

<div dir="auto"></div>

--00000000000097079a0609d4bc68--
