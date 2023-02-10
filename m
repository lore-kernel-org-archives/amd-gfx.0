Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CEEC636CD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Feb 2023 08:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 613A810EC8E;
	Fri, 10 Feb 2023 08:04:09 +0000 (UTC)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E99D10EC55
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 04:50:19 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 v6-20020a17090ad58600b00229eec90a7fso7819586pju.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Feb 2023 20:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y8Z+rw3Lo4ZI53HBYFrES/rZyYmIcMPWeV9Tjc6GjJE=;
 b=dfjrwZCUTXg0++zE/wVkz4Z96Dke9cdiJGPWOJx+bSbwOuQzxzamUP7h08RKQKxmci
 TJuBqsc+PY+NgKeBk1dK5ehjoB56e05oCGCVdL0fCqIdQhc0VEGhFat0cmuxanHzAMg0
 PkBLd+8yttsFpd3mZCaA1SzojWL4FcQ3HiMdQp77gFhOpZsKqeYz/jeR1LyHxN4YyLTb
 3ZMp1vTJystxqoDQUey6c9p8i3s2QjUBsSsvBZ5rfq9WUIORdJzIDSR0QALHgrjXZ77j
 ScTwjw3ohujsiuZkCI2r2hTPzZp/mGapCXYydIZhMspEsgiXfPGfK8D+y5YVUcqfbqEh
 3VYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y8Z+rw3Lo4ZI53HBYFrES/rZyYmIcMPWeV9Tjc6GjJE=;
 b=tJ0RRGQrxrZEE4YDzjJOi62t8fIqc9cjxe0BZsJCy75sKkFhdLTjOqRsrheSWy9YGW
 /UIVfGAw/Y91OIOB9AdcrGByyKj5Qh+3hlcTLwdm1J7mrBiuDLoGWLAyWcZkvxw/a6r2
 n7NbcwqU0TzDaNROFxRnPZYzDAtE1i7gHb/ScKW5dUUEz3HYfTTQ1r9EJRnBBXYu9hsF
 QWGg+CAYtf6dz9E1ncTYIYiZ5+rP3T2OKORYXqtOWL01/fGSWE4rBkGyP0f8V2bj8P6b
 HZ0ocaCytE3xif+bxErS7POxJv62Yg7YP1mWKnvPZnYNibBNUAvo+6Xgg36vXrW3GQ0o
 iTcg==
X-Gm-Message-State: AO0yUKUHcpNVavhW0VrGgtd2DmApl22OjaRMuuldhraRdeULqQWasrvp
 yezG1cOUF5U53lY/3HeHAGA=
X-Google-Smtp-Source: AK7set/7KSbVgE9qkN7uNWue+wzw+pXkSmt+auWpnDKP9/ad63Y3Jn6uOO0PkG79K7jm7BGnaA7Ihg==
X-Received: by 2002:a05:6a21:339a:b0:bf:22ca:ef55 with SMTP id
 yy26-20020a056a21339a00b000bf22caef55mr17822193pzb.37.1676004618944; 
 Thu, 09 Feb 2023 20:50:18 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a62ea0d000000b0057fec210d33sm2269218pfh.152.2023.02.09.20.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Feb 2023 20:50:18 -0800 (PST)
From: Orlando Chamberlain <orlandoch.dev@gmail.com>
To: platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [RFC PATCH 2/9] apple-gmux: consolidate version reading
Date: Fri, 10 Feb 2023 15:48:19 +1100
Message-Id: <20230210044826.9834-3-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210044826.9834-1-orlandoch.dev@gmail.com>
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Feb 2023 08:04:04 +0000
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Rander Wang <rander.wang@intel.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Airlie <airlied@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Evan Quan <evan.quan@amd.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Yong Zhi <yong.zhi@intel.com>, Aun-Ali Zaidi <admin@kodeit.net>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Bokun Zhang <Bokun.Zhang@amd.com>,
 Orlando Chamberlain <orlandoch.dev@gmail.com>,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Kerem Karabay <kekrby@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Jack Xiao <Jack.Xiao@amd.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 Takashi Iwai <tiwai@suse.com>, Aditya Garg <gargaditya08@live.com>,
 Daniel Vetter <daniel@ffwll.ch>, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Read gmux version in one go as 32 bits on both indexed and classic
gmux's.

Classic gmux's used to read the version as

major = inb(base + 0x4);
minor = inb(base + 0x5);
release = inb(base + 0x6);

but this can instead be done the same way as indexed gmux's with
gmux_read32(), so the same version reading code is used for classic
and indexed gmux's (as well as mmio gmux's that will be added to this
driver).

Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 14 ++++++--------
 include/linux/apple-gmux.h        |  6 +-----
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index e8cb084cb81f..67628104f31a 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -580,15 +580,13 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	if (indexed) {
 		mutex_init(&gmux_data->index_lock);
 		gmux_data->indexed = true;
-		version = gmux_read32(gmux_data, GMUX_PORT_VERSION_MAJOR);
-		ver_major = (version >> 24) & 0xff;
-		ver_minor = (version >> 16) & 0xff;
-		ver_release = (version >> 8) & 0xff;
-	} else {
-		ver_major = gmux_read8(gmux_data, GMUX_PORT_VERSION_MAJOR);
-		ver_minor = gmux_read8(gmux_data, GMUX_PORT_VERSION_MINOR);
-		ver_release = gmux_read8(gmux_data, GMUX_PORT_VERSION_RELEASE);
 	}
+
+	version = gmux_read32(gmux_data, GMUX_PORT_VERSION_MAJOR);
+	ver_major = (version >> 24) & 0xff;
+	ver_minor = (version >> 16) & 0xff;
+	ver_release = (version >> 8) & 0xff;
+
 	pr_info("Found gmux version %d.%d.%d [%s]\n", ver_major, ver_minor,
 		ver_release, (gmux_data->indexed ? "indexed" : "classic"));
 
diff --git a/include/linux/apple-gmux.h b/include/linux/apple-gmux.h
index 1f68b49bcd68..eb2caee04abd 100644
--- a/include/linux/apple-gmux.h
+++ b/include/linux/apple-gmux.h
@@ -67,7 +67,6 @@ static inline bool apple_gmux_is_indexed(unsigned long iostart)
  */
 static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, bool *indexed_ret)
 {
-	u8 ver_major, ver_minor, ver_release;
 	struct device *dev = NULL;
 	struct acpi_device *adev;
 	struct resource *res;
@@ -95,10 +94,7 @@ static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, bool *indexed_ret)
 	 * Invalid version information may indicate either that the gmux
 	 * device isn't present or that it's a new one that uses indexed io.
 	 */
-	ver_major = inb(res->start + GMUX_PORT_VERSION_MAJOR);
-	ver_minor = inb(res->start + GMUX_PORT_VERSION_MINOR);
-	ver_release = inb(res->start + GMUX_PORT_VERSION_RELEASE);
-	if (ver_major == 0xff && ver_minor == 0xff && ver_release == 0xff) {
+	if (!(~inl(res->start + GMUX_PORT_VERSION_MAJOR))) {
 		indexed = apple_gmux_is_indexed(res->start);
 		if (!indexed)
 			goto out;
-- 
2.39.1

