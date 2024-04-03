Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882E4CD1284
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Apr 2024 10:31:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E17911B384;
	Thu,  4 Apr 2024 10:31:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="Zu7UAbkB";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17613112A7E
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 12:11:51 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-a45f257b81fso678454266b.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Apr 2024 05:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1712146310; x=1712751110; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:user-agent:references
 :message-id:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=GSa+lE+eQAjqGBMhpo2IZGzrJi4XTjtSb1roD3a7SZ0=;
 b=Zu7UAbkB1t71g6BiXghDSFS+3uLhOM4c/2XnuhaqBHCMRJXsYIp3C0kg2k0ODHd/wn
 vo7u4dUv7XUfXojzG4fy7xwamq9BQSfv7L3t76WcCZxL/L9NmT8KtRCxen1mCWzzV1vO
 2mqjCcvu6jKH428cUkUYysjeKmV/iJPfZdjMWU5/OMvqrcFY1799oxQWSvPhA1xHg/jF
 Eupny92//1fcC6WtyQSOlXtCJzhFjFZtOGOvzcRlDwtYD9bn+BRxwgfuRyJ14G4mQ2Ro
 o9wh+oVM+6MdgNHpcXTjQ3LtAbLDK6Ym1RlDMe/1kT2xQY9xKyD0q2CdPfP07gjbHF4t
 Xz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712146310; x=1712751110;
 h=content-transfer-encoding:mime-version:user-agent:references
 :message-id:in-reply-to:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GSa+lE+eQAjqGBMhpo2IZGzrJi4XTjtSb1roD3a7SZ0=;
 b=Ta8g2b2ZAVRyNlFYsX7dgORcbvSzwa38Z5Xei+mXPEDl4mmyqLfwEKYgb5zDykXOKt
 +CCRnYPYebfjFRn5ZIazEEi8Fv6We/sbIV8rLLvpfhwqOLSZlBnCTaGVWM25MvQ6LJ5X
 v+qawtxX09CnjGiz/eVQa9FtRnf7vlzztRQBltsE2/ameeL6HcKhgiXPDx1BexWrEyFO
 g/wt1uCK1XKb+TA5+qcOVB5YdXlRrt0uTmAd9JLPXsCUOWFkpKjcSpMKet388TB5kbvz
 NzSF2huxr0a22o2op0QfHXrRZ1zaV+4U8hZPgH3nYO1aQTaIRyDQd7eXyzRX5IhvCnUh
 tMow==
X-Gm-Message-State: AOJu0YwS78MwsLvUbKeM+pV8dgBDteD7+5u2E4eLqph952h6y4MBzGtB
 dqWVoes++Db6RjY+6GvEsYVvLVvTPuY6EzLG3DhATsapl/g7fs7kQ9ZiAys8ctU=
X-Google-Smtp-Source: AGHT+IEenrhww/1YtDRsup4vgQa1dwYsyDmSOe2UJixnfKDN3x+SdGjt3O5dR7s4h9bw9IA6743mZQ==
X-Received: by 2002:a17:907:7652:b0:a4e:7301:eddc with SMTP id
 kj18-20020a170907765200b00a4e7301eddcmr6110111ejc.4.1712146309958; 
 Wed, 03 Apr 2024 05:11:49 -0700 (PDT)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 qu20-20020a170907111400b00a46e2f89a9csm7649968ejb.32.2024.04.03.05.11.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Apr 2024 05:11:49 -0700 (PDT)
Date: Wed, 3 Apr 2024 14:11:49 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.com>
To: Li Ma <li.ma@amd.com>
cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 richard.gong@amd.com, yifan1.zhang@amd.com, 
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
 =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH 1/8] HID: amd_sfh: rename float_to_int() to
 amd_sfh_float_to_int()
In-Reply-To: <20240329101748.3961982-1-li.ma@amd.com>
Message-ID: <nycvar.YFH.7.76.2404031411160.20263@cbobk.fhfr.pm>
References: <20240329101748.3961982-1-li.ma@amd.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-Mailman-Approved-At: Thu, 04 Apr 2024 10:31:24 +0000
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

On Fri, 29 Mar 2024, Li Ma wrote:

> From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>=20
> [Backport]: to fix amd_sfh init fail issue in ASDN
>=20
> Current amd_sfh driver has float_to_int() to convert units from
> float to int. This is fine until this function gets called outside of
> the current scope of file.
>=20
> Add a prefix "amd_sfh" to float_to_int() so that function represents
> the driver name. This function will be called by multiple callers in the
> next patch.
>=20
> Link: https://lore.kernel.org/all/ad064333-48a4-4cfa-9428-69e8a7c44667@re=
dhat.com/
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Co-developed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> Signed-off-by: Jiri Kosina <jkosina@suse.com>
> (cherry picked from commit 4e71d262899d7bab1f0c65936a2e639afeb83e4d)

What am I supposed to do with this? All of this code has already been=20
upstreamed.

--=20
Jiri Kosina
SUSE Labs
