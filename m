Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F2E606A326
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 11:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l6QeI8DW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C594C10FB4D;
	Wed,  4 Nov 2026 11:12:26 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 212AC10F6A4
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 15:53:27 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a78ec32fadso9966065e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2026 07:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793721205; x=1794326005; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zmgOx3DOkVSwagY2PRIacCzKqEPjbIHBYHXTptn9QVw=;
 b=l6QeI8DW86DyAdx0PQRQrpCQ7/BWqu0deLtzdhS8+3YbivRxJWetRhkOgIn6Iu1s86
 06wifXjhGF0FypwI93iwkBfuCWKVypXIi03KWeEfLHYYNnckrtq+spBd0QORfprMcT9n
 ZEzGVRQKobzgZpqjRHdMMY3VFWrSn7Og5nW5HHIoPAtfHnms2TzWEt+0kS5KDoKkRBE7
 NT9h4UjklQ4uc6xfrdD6z2WtrnT9D6IzrOxWFIZAY/L+Hviv3arZgnONeKbX2S9VYrFw
 Hr46Tn5Njt5/W34ntLLkcEgmgrdjWs3M+N6mpqn+DBjjBAwE8t6NNI4YgegLa/2aom/d
 +Ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793721205; x=1794326005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zmgOx3DOkVSwagY2PRIacCzKqEPjbIHBYHXTptn9QVw=;
 b=NebqSVvfnv/aTJ2hSa6JcCuJsVT9146j3aic+OGKp7v7FDcThd5lgCni0L9JFAa8or
 7p8d1PUFtmuCTHGonMEq5BC9+RgUnTYgxkaRflU992eFZvsSMb5sgePGlqhHrDb5OTK7
 tcrRRLoCZPSwjL58FEfiM0JJxDGSjCaraPSPQENH/KOI4wCRYeBelVzBgQ1TPBEbSlSp
 poZVxRNMsOn3IurcNzkEcMs5d9d1Ceed46vMIAXMg+xWAs2fTOHZNXYvgrVzoA14V4n4
 X5Sn97cTiTbXYFklBCjc0AsfLsourhB55HTUEzBTMMK/X6fPUqufMCvxDKvvAYk4/N8S
 BeiQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzANOypeX/NH8/l5nppQ2yY9SsNSEFbGtIyeABVxlsB91ra5Mq+w0U3YeDfBLkoACpIHc1TAu5q@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+/6z6cFwjuMIV5RhI3OANI2H9mhLBKtQyBasmCmeoS8G6eQawn
 mbH0Nw6vC+qU0OL7cRCa+4/eUcUFr/d6wtg+IDCn82p5Ds0V2F3Fpg9U
X-Gm-Gg: AYBFou3tH+GB+hi+46q8Tp43KA+m5245VHB351N/AMT35vYd17rI0X5RLEz1WRUah6F
 GTRZU/LvIok8KfDW816y/NhQtvNZBjT3+Ua+waQwDtKmh/qUc6R/4bElT12nZDGqAY5jpAsxsDN
 I+yydaZXbCUb22xZRoPAmfYRxpIgPN/HL38LpvMoLuoc2phvW/Qu9GSIeNdLc8nb7pGgFskzhNQ
 8mGG5R3+uetiOylWJna2+XTdlQYwfCJpuq5yV6JDfYhrOgvpkXO7nUaks4mcVINeV7y39LiyZ5P
 yXNpu1nlTkwqcTEyQtI20NiEoAJ0XxjWNxSA4svIbrkq4T1+2I/LF/6EuF6LKhbVBwlr5NpgMVr
 UbMfYbmfb19nMSnbI+2UKqyEV3CNVw7BLDE+nblup5l8OqhJaaoRRDaS3swhp/coUe7u+35SQZ3
 1a8Z/E5WKTQGkBtPai0QpkSy5zHkgzgV0VrSAEv9xLyHzYAniOXNwM/i3A57aNx68xMfYi0lFEf
 /HIYldsYzgJrWt1hY9Kv6ik1YUrCI6gB7jljJrEWYOqoTodndV6zeojkpwjmH9zs73dEBdXIYft
 /S/rQ7FaDtiJRJaqbu8Jp/Ag8ExMHmnJjVacLqUQfJBQNgOJ/HQ=
X-Received: by 2002:a05:600c:4897:b0:4ad:5ec2:d3b3 with SMTP id
 5b1f17b1804b1-4ad5ec2d3e4mr152905945e9.1.1793721205339; 
 Tue, 03 Nov 2026 07:53:25 -0800 (PST)
Received: from Termis-ROG-FLOW-Z13 ([2001:16a2:4495:e600:1209:ec98:a2b4:9c5a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a879f401sm63777815e9.5.2026.11.03.07.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 07:53:24 -0800 (PST)
From: Seifelden Abdelmonem <saif.elden.hatim@gmail.com>
To: Mario Limonciello <superm1@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bin Du <bin.du@amd.com>, Nirujogi Pratap <pratap.nirujogi@amd.com>,
 Benjamin Chan <benjamin.chan@amd.com>, King Li <King.Li@amd.com>,
 Caspar Adriani <caspar.adriani@proton.me>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Arec Kao <arec.kao@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Seifelden Abdelmonem <saif.elden.hatim@gmail.com>
Subject: [RFC PATCH 1/3] media: i2c: ov13b10: add an I2C device ID table
Date: Tue,  3 Nov 2026 18:53:11 +0300
Message-ID: <20261103155313.114347-2-saif.elden.hatim@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103155313.114347-1-saif.elden.hatim@gmail.com>
References: <20261103155313.114347-1-saif.elden.hatim@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Nov 2026 11:12:26 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On AMD ISP4 platforms the amd_isp4 platform driver creates the sensor's
I2C client by name ("ov13b10"), with a software node and no ACPI
companion. The driver only has an ACPI match table, so the I2C core
does not bind it to that client.

Add an I2C device ID table so the driver can bind to clients created
by name. Nothing changes for ACPI-enumerated sensors.

Signed-off-by: Seifelden Abdelmonem <saif.elden.hatim@gmail.com>
---
 drivers/media/i2c/ov13b10.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/i2c/ov13b10.c b/drivers/media/i2c/ov13b10.c
index 242a95834..d33fb7032 100644
--- a/drivers/media/i2c/ov13b10.c
+++ b/drivers/media/i2c/ov13b10.c
@@ -1706,6 +1706,12 @@ static const struct acpi_device_id ov13b10_acpi_ids[] = {
 MODULE_DEVICE_TABLE(acpi, ov13b10_acpi_ids);
 #endif
 
+static const struct i2c_device_id ov13b10_i2c_ids[] = {
+	{ "ov13b10" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ov13b10_i2c_ids);
+
 static struct i2c_driver ov13b10_i2c_driver = {
 	.driver = {
 		.name = "ov13b10",
@@ -1715,6 +1721,7 @@ static struct i2c_driver ov13b10_i2c_driver = {
 	.probe = ov13b10_probe,
 	.remove = ov13b10_remove,
 	.flags = I2C_DRV_ACPI_WAIVE_D0_PROBE,
+	.id_table = ov13b10_i2c_ids,
 };
 
 module_i2c_driver(ov13b10_i2c_driver);
-- 
2.56.0

