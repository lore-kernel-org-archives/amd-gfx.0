Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6F7C072DD
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Nov 2023 18:01:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADDBE10E0DA;
	Sun, 12 Nov 2023 18:01:12 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 808B710E242
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 23:32:05 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4084095722aso19561945e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 15:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699659124; x=1700263924; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=G0Xxx3+DUmKqCjOHgRxC9Cu8pQOaIoyEbq7uXsJmyuo=;
 b=NRIIDSGhC1KCkpZNDUvFce5VoinJP+am3iVEUsZLl2J34+YVwESJew+2Y4ijuVnOLb
 V8N+qHfNpIzWxfg3pOD0OPlsVpUUOzruz2FzLtTrDyz54pzEZkp3K+ssWhoK1CCMmWxx
 f9VwmBljkDFdXS2w8V3LV/xgcxBh20UKJGqa8vKVh8h14V4Kcg7e5+y3deFpzX8oeCBn
 qj6QT3YqPyk+wYqLfTwAvq4dZK6eqEEMRzrUvRadIPPTGk5onLRgfJS0DOi3WtSON5Oo
 vfbpsBUHH62i57bgK9ITDMcBBhUHBPdg8UcpadmjDPC1E4Hgco3bqp6iqCx7k7rcaKJE
 Fs+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699659124; x=1700263924;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G0Xxx3+DUmKqCjOHgRxC9Cu8pQOaIoyEbq7uXsJmyuo=;
 b=v+bLjvXrBNLuCmB1KP3OsLuL3vJGuSkB8KiFR0i/TEEHzcw+jwu0/j9DJhUt9FtvN9
 StfSuFRSehWIPs7MwqQRW1qRiuNSMgWt+I90qUa2J03EOO+snFuODHitmAENtGqm5BjD
 KA7O9cfsRxCDGvLYBFoqIbGxqJI3TwPwxf82Dxh+asxfHT9m1VhdjpEoijKl9DXi1zn6
 h2rMWh7neqttH4N9xdFab5+LcQg5i59A2Ks0XgxzyeX8leVTFH3RCQ9+nfbYnLImVN4A
 7g63BEUyjbqmpUzJowEWoxxST5mcTtMVP5QFDHVgwxEQ0zgCr8fOaJHbWSWEiKYKueX6
 JvSw==
X-Gm-Message-State: AOJu0Yy3cyHG63ZM1hF0sN/RcztqwzNeygYHRIuZ2ey6vF0alDnsITVY
 T/JNHnuotC3zM3r7JtPA1dWejKboSOZ/EDdkKExLlFKdY537vQ==
X-Google-Smtp-Source: AGHT+IFG6URo6uQE2p8wiMVe/XtEaUyefdx6hpALNvAZBpUx688Cz2eYMzmFqf0yRanMiS5kiR+oZO/fKeOyOUJm7K8=
X-Received: by 2002:a05:6000:1567:b0:319:867e:97d7 with SMTP id
 7-20020a056000156700b00319867e97d7mr500266wrz.52.1699659123266; Fri, 10 Nov
 2023 15:32:03 -0800 (PST)
MIME-Version: 1.0
From: J Fra <jfra4799@gmail.com>
Date: Fri, 10 Nov 2023 17:31:52 -0600
Message-ID: <CAE584xbwK36APghuq_83W6KD2XHNY99-NmH+M1a3kZufyYp8WA@mail.gmail.com>
Subject: Re: [PATCH v7d 00/23] fix DRM_USE_DYNAMIC_DEBUG=y regression
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="0000000000004819e60609d4ba44"
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

--0000000000004819e60609d4ba44
Content-Type: text/plain; charset="UTF-8"



--0000000000004819e60609d4ba44
Content-Type: text/html; charset="UTF-8"

<div dir="auto"></div>

--0000000000004819e60609d4ba44--
