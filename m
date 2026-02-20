Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20643C54FCC
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 08:45:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A62F310E7F1;
	Fri, 20 Feb 2026 08:45:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OiC7UKsS";
	dkim-atps=neutral
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com
 [209.85.208.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8711510E775
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 03:02:04 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-385c2f88618so14258671fa.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Feb 2026 19:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771556523; x=1772161323; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hqp1jrv3QaroxdeHoV4ufkhY65ckcSlQNQnG63MUVbI=;
 b=OiC7UKsSkapzl4ETdNF16mGOA+vS/uSOuqdfGV+thQ4bRH9Fqdd+IS+OoKiUa/UBlr
 20ZKMwADnqNyCWXkeYrh/M0rIiYlqap1AawAMyoEu4B0eoOS7njRGSne75E5iwBfiHLN
 9JmfKRaDHmdyXRER/d3sKPUccFoSxkL5TGWrPO0qUQiRc8hlkoxPoiCCm9iA1YDWrgcC
 y8Q4vKKxs6SdkEhNGEOc14r6x4w7ImI00ffPjDri6xClYW0YtzK3b7w+L6FwdrZEhiqM
 JmTtrcSw5gVO1ARcdJEBIJ37mqcYlr4wxNjb1Woli6jSw6umHmXDfLFQxNJWWZWJDf5D
 SR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771556523; x=1772161323;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hqp1jrv3QaroxdeHoV4ufkhY65ckcSlQNQnG63MUVbI=;
 b=bsj+6aHN3nnnYinhgzjXELkMCtlb3+L7Xd6w5/dfYpcVh8XB1hcSMjlD9K0I1YdY6t
 GeQ/zLcxeIb1n+TzylXCCimgcxVXUfm9a1qyMX0jW1IdJOhoHH2+IwZbvNZB/B5Ta5P4
 5CIYuG4yuvWQbIIYq1FBq5s2HkhBaZ5igHwQYPBLyCK8IABpPxe6OCNI2a15xEwrqV0R
 Qx94/q3YENHia1LbXGWjRYgcS3/0dPxu1uSlneAmmb59JgASxUqlc+hoaozoaL+8Ed3i
 gkVeqnXynYo+XoN1hix03+HhyHWNp/Vfdm3tgYAgfdslz73+9j6phRkAFDo8DhaRUSPS
 F/8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW03sYN/Irzfm74a+Iwt6Pf9iLSMqbldTx8LohQzGZV6J8iTeDHMJA78otyBKlelFmIPk8JcCGn@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzNAcm6+aeU9v/AOaEWS8MFi+oslQXNHjsokVPogROnxCFKR/qw
 Hmij8LAJf4uXyzZ8dQMDJ+4Ph3F6XyfotED125w9o9EcuslTk7lFy0I=
X-Gm-Gg: AZuq6aKMBbECjH1kxdKdTrV3meLw0KRBtQO6HlAcX5MrugJL1I7UwpYNuBN/2+VGb+x
 bN75yt4AnHe5le7mEJvN9PmcjcYl4fxjFINSKxCfhV+BFtEAhWPKkNFXWV+9X9ML4OM9uJMAgPZ
 /+XfP8s3/u5pxrQChb3RCoB+5+jlWfGEyPaxIRVw1ycvuywcnKbfFW0U2Y2PZpXO7lmdIFHHonX
 irBme9qFDS7Buc7f5HOY6kUfkyX2hpyvZFhF2JFuduWIlNbzIVEFj8AakjYOyHLwrFxdbHU8/NF
 nxdM4rhkSU5YjnWUI5WemxjQMTAboOuistZKjnagRFd6CSCSbGb3Cr6gkit4B0YuJK9u733Scfg
 Dxr0JxgMhCdEvJ74h44CoVgKNq7TQ+7sO/PQgcbpqD7FSSoX8IVbsV6I8JNPLTPiPmknrOuQYOm
 wCxmsGe+w=
X-Received: by 2002:a05:651c:1504:b0:386:e936:71dd with SMTP id
 38308e7fff4ca-38846e37a02mr23095861fa.41.1771556522541; 
 Thu, 19 Feb 2026 19:02:02 -0800 (PST)
Received: from localhost ([2a0e:e6c0:20d0:4f00::1d])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-387069259c1sm52664811fa.41.2026.02.19.19.02.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 19:02:02 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Feb 2026 06:02:01 +0300
Message-Id: <DGJGDIRQWDG7.XHHKF6UQP0HG@gmail.com>
Cc: <dri-devel@lists.freedesktop.org>, <regressions@lists.linux.dev>,
 <mwen@igalia.com>, <mario.limonciello@amd.com>, <alex.hung@amd.com>,
 <daniel.wheeler@amd.com>, <rodrigo.siqueira@amd.com>,
 <alexander.deucher@amd.com>, <harry.wentland@amd.com>,
 <sunpeng.li@amd.com>, <christian.koenig@amd.com>, <huangalex409@gmail.com>
Subject: Re: [REGRESSION] VRR not detected on a DisplayPort monitor using an
 AMD GPU
From: "Ivan Sergeev" <ivan8215145640@gmail.com>
To: "Ivan Sergeev" <ivan8215145640@gmail.com>, "Mario Limonciello"
 <superm1@kernel.org>, <amd-gfx@lists.freedesktop.org>
X-Mailer: aerc 0.21.0
References: <CAKx_Wg7_HBxuq5W4T_AmoFYJGQpa6TAS_Fx9SUzyy1itPmj5Bw@mail.gmail.com>
 <090d89a2-4f80-44ef-827c-6462d8948493@kernel.org>
 <DGJFVPAQJA15.378GMU7XZXLU@gmail.com>
In-Reply-To: <DGJFVPAQJA15.378GMU7XZXLU@gmail.com>
X-Mailman-Approved-At: Fri, 20 Feb 2026 08:45:29 +0000
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

On Fri Feb 20, 2026 at 5:38 AM MSK, Ivan Sergeev wrote:
>
> I've done the bisect using the v6.12.68 tag as good and v6.18.8 tag as ba=
d

Sorry, those are not the tags I've used for the bisect. Before doing a
bisect in git I first checked versions from 6.18 to 6.13, and could
reproduce the issue in all of them, so after that I went for the git
bisect between 6.12.68 and 6.13.6.
