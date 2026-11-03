Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38532606A328
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 11:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RV794XZ/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9150210FB75;
	Wed,  4 Nov 2026 11:12:39 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F084610F6B0
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 15:53:29 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a599e9110eso22165715e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2026 07:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793721208; x=1794326008; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QOWQN6KK00fNNA4WnFOnqK7uxhM/XkYooxesvFiwoQo=;
 b=RV794XZ/jNvy6XhD16ZAKxTGITXtoZL5n+WVfAtPPnUferCd73A1vq/huJVgbeJqDD
 Fmw/UK/X6ulcOzz4CC+lTnW2MNyyACsRUaxOi0huce9JrPE7Il9XYK+qApVnV/e4/Fek
 Hx6PmrLPMWiomYpUPJ1rSFodEX6zzZMtp8K6vm8cV1t51DLZaglY3MYolk0PrldxGx7h
 cXgB4atDGUCiW8TetPuyCVhsY/83hIqQ/15URINRQeKmf8wUhT7aYoU5YOZIuC8M4jez
 ycW0vhw9Zy3vCNSFq0RIZcKWyFmxzU7POh69Iwr7BzrX4vm229NfzdDll4OdP7CrAZ9d
 Jvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793721208; x=1794326008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QOWQN6KK00fNNA4WnFOnqK7uxhM/XkYooxesvFiwoQo=;
 b=SV+VHGgtY5r+IkkRZlMOd0oQoc7KiTtxnSzZwYkIm+km7ZtUSKgqKjnuAp+WSclEY+
 2LOx9cpeFmFBctSgtD3RGodDwT634uHJrNwpdthSLc9KhT6rjqjD0qLEt9o7o0g5YEOE
 3VsmB8IP7spZuGW7dlTIFNDRye66QwplPDJeIdaz90KKnNJWhOx7s2OE158pOPyPleGl
 v/2OxXjHahQvdmcQH07TJxLd2i8WpT8hizpvUPckkYHLo6THcrutUjyRB+JL1Jn8CGaq
 ICnS6j+RpBLGeFxnP1QqsNL9GsfmQvf4Yf0VdTNJN4j6eRp+05Mzzs2xsYzulAEsk91B
 ickQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByFjOsmdj5KQFFL8nAlI6BLCrfSnQOT945PNSOUdd34ftjfKlJ697FnQDjOATGCbF+GqSn6mPRi@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8saYViKCO2tmEZpUNctowmnO5/sBIzKon3F8tBS6DIVjX37PBw
 pOy3rHZ+vsO9kyqB599u6nSwymG/3WIXeU2yL+3iEIu6jNTwdXhKPUZ2
X-Gm-Gg: AYBFou0u2f34BICYMfjgix5P1GrSEBfANeGVdh1AUEAiV1QHXbQO5GKqa8PKQpT1UJG
 X1cJpu/77ouzG5faMbxf0UH7V2e3iz9/BqXqqPcI2OVm54BNUm5L4kWTszLnFclAUjYSMmvWAOH
 h5a8Y6CIAS7jcuVtpjL/54gtYClDBe4Ye83e+YGVxZz/h/czdgtygYXTi/PlzabxUZAVaLEns8l
 +0TCG8kAyu+d5Oitz2OBawLlX9f17R5AVO8PrxSVXHHDg0/jEnQFI2uKwdAkJ7Vp6G+VHCNWE7C
 gj2Q0I6rqe5XdihYfu+TYDC/qsb91rM0TfsHuRD3ET+VR6jn3IcwNIOyGEjlLZGvQ44qGawycAh
 hwTpJjP/8HCqBXJimo6MVql7a/vQGx6ysngrezyFjV1rFuOdA5NiffAZsSEPBSrB0ygUuTwMnAZ
 g2h1WhQZuScRbJSiEct6knY+/t1w8pAkSHPvDSiEILJ0DbX6l6YdZ9osLDd1nAmPZLRE1ZJnGF4
 5HOGz7y6n+CbVWUYuDOjY8AHpiejWKeXrzXPwXxj0hDxDC5as9Mwwh4AbE/TctnUv79kONLeNHP
 jQcKV1z0V0mcoG1wcRy5Ax6baKn35/yvGGmlm4l+ueZpTplRYkou5uAIq1NUAlzuKlaqly/Q
X-Received: by 2002:a05:600c:a010:b0:4a1:7dcf:be1f with SMTP id
 5b1f17b1804b1-4ac166ee4d6mr304046925e9.1.1793721208244; 
 Tue, 03 Nov 2026 07:53:28 -0800 (PST)
Received: from Termis-ROG-FLOW-Z13 ([2001:16a2:4495:e600:1209:ec98:a2b4:9c5a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a879f401sm63777815e9.5.2026.11.03.07.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 07:53:27 -0800 (PST)
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
Subject: [RFC PATCH 2/3] platform/x86: amd_isp4: add the OV13B10 (OMNI13B1)
 board configuration
Date: Tue,  3 Nov 2026 18:53:12 +0300
Message-ID: <20261103155313.114347-3-saif.elden.hatim@gmail.com>
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

The rear camera of the ASUS ROG Flow Z13 (GZ302EA) is an OmniVision
OV13B10 behind the AMD ISP 4.1.1, exposed in ACPI as \_SB.CAMB with
_HID "OMNI13B1". Like the OV05C10 reference platform, its ACPI device
has no resources and no endpoint graph, so add a platform
configuration with the software-node graph for it:

- I2C address 0x10, where the sensor answers on the ISP's I2C bus (the
  camera's _DSM also returns this value);
- a 24 MHz sensor clock, the rate declared for the OV05C10 reference
  platform;
- four CSI-2 lanes at 560 MHz, the link of the ov13b10 driver's
  full-resolution mode.

If the host ov13b10 driver binds to the sensor, it currently accepts
only a 19.2 MHz external clock, so it does not probe with this
configuration until it supports 24 MHz. The sensor's reset GPIO is
registered by amdgpu together with the other ISP GPIOs.

Signed-off-by: Seifelden Abdelmonem <saif.elden.hatim@gmail.com>
---
 drivers/platform/x86/amd/amd_isp4.c | 127 ++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/drivers/platform/x86/amd/amd_isp4.c b/drivers/platform/x86/amd/amd_isp4.c
index 0d4948995..6b850e0fc 100644
--- a/drivers/platform/x86/amd/amd_isp4.c
+++ b/drivers/platform/x86/amd/amd_isp4.c
@@ -19,10 +19,13 @@
 #define AMDISP_OV05C10_I2C_ADDR		0x10
 #define AMDISP_OV05C10_HID		"OMNI5C10"
 #define AMDISP_OV05C10_REMOTE_EP_NAME	"ov05c10_isp_4_1_1"
+#define AMDISP_OV13B10_I2C_ADDR		0x10
+#define AMDISP_OV13B10_HID		"OMNI13B1"
 #define AMD_ISP_PLAT_DRV_NAME		"amd-isp4"
 
 static const struct software_node isp4_mipi1_endpoint_node;
 static const struct software_node ov05c10_endpoint_node;
+static const struct software_node ov13b10_endpoint_node;
 
 /*
  * AMD ISP platform info definition to initialize sensor
@@ -245,8 +248,132 @@ static const struct amdisp_platform_info ov05c10_platform_config = {
 	.swnodes = amd_isp4_nodes,
 };
 
+/*
+ * ASUS ROG Flow Z13 (GZ302EA) rear camera.  Its ACPI camera device has no
+ * resources or endpoint graph, so provide the same complete software-node
+ * graph used by the reference OV05C10 platform.  The ISP supplies the
+ * sensor clock at 24 MHz, as on that platform; four CSI-2 lanes at 560 MHz
+ * are the link of the ov13b10 driver's full-resolution mode.
+ */
+static const struct software_node ov13b10_amd_camera_node = {
+	.name = "amd_camera",
+};
+
+static const struct software_node ov13b10_isp4_node = {
+	.name = "isp4",
+	.parent = &ov13b10_amd_camera_node,
+};
+
+static const struct software_node ov13b10_isp4_ports = {
+	.name = "ports",
+	.parent = &ov13b10_isp4_node,
+};
+
+static const struct software_node ov13b10_isp4_port_node = {
+	.name = "port@0",
+	.parent = &ov13b10_isp4_ports,
+};
+
+static const struct software_node_ref_args ov13b10_isp4_refs[] = {
+	SOFTWARE_NODE_REFERENCE(&ov13b10_endpoint_node),
+};
+
+static const struct property_entry ov13b10_isp4_endpoint_props[] = {
+	PROPERTY_ENTRY_REF_ARRAY("remote-endpoint", ov13b10_isp4_refs),
+	{ }
+};
+
+static const struct software_node ov13b10_isp4_endpoint_node = {
+	.name = "endpoint",
+	.parent = &ov13b10_isp4_port_node,
+	.properties = ov13b10_isp4_endpoint_props,
+};
+
+static const struct property_entry ov13b10_i2c1_props[] = {
+	PROPERTY_ENTRY_U32("clock-frequency", 1 * HZ_PER_MHZ),
+	{ }
+};
+
+static const struct software_node ov13b10_i2c1_node = {
+	.name = "i2c1",
+	.parent = &ov13b10_amd_camera_node,
+	.properties = ov13b10_i2c1_props,
+};
+
+static const struct property_entry ov13b10_camera_props[] = {
+	PROPERTY_ENTRY_U32("clock-frequency", 24 * HZ_PER_MHZ),
+	{ }
+};
+
+static const struct software_node ov13b10_camera_node = {
+	.name = AMDISP_OV13B10_HID,
+	.parent = &ov13b10_i2c1_node,
+	.properties = ov13b10_camera_props,
+};
+
+static const struct software_node ov13b10_ports = {
+	.name = "ports",
+	.parent = &ov13b10_camera_node,
+};
+
+static const struct software_node ov13b10_port_node = {
+	.name = "port@0",
+	.parent = &ov13b10_ports,
+};
+
+static const struct software_node_ref_args ov13b10_refs[] = {
+	SOFTWARE_NODE_REFERENCE(&ov13b10_isp4_endpoint_node),
+};
+
+static const u64 ov13b10_link_freqs[] = {
+	560 * HZ_PER_MHZ,
+};
+
+static const u32 ov13b10_data_lanes[] = {
+	1, 2, 3, 4,
+};
+
+static const struct property_entry ov13b10_endpoint_props[] = {
+	PROPERTY_ENTRY_U32("bus-type", 4),
+	PROPERTY_ENTRY_U32_ARRAY_LEN("data-lanes", ov13b10_data_lanes,
+				     ARRAY_SIZE(ov13b10_data_lanes)),
+	PROPERTY_ENTRY_U64_ARRAY_LEN("link-frequencies", ov13b10_link_freqs,
+				     ARRAY_SIZE(ov13b10_link_freqs)),
+	PROPERTY_ENTRY_REF_ARRAY("remote-endpoint", ov13b10_refs),
+	{ }
+};
+
+static const struct software_node ov13b10_endpoint_node = {
+	.name = "endpoint",
+	.parent = &ov13b10_port_node,
+	.properties = ov13b10_endpoint_props,
+};
+
+static const struct software_node *ov13b10_amd_isp4_nodes[] = {
+	&ov13b10_amd_camera_node,
+	&ov13b10_isp4_node,
+	&ov13b10_isp4_ports,
+	&ov13b10_isp4_port_node,
+	&ov13b10_isp4_endpoint_node,
+	&ov13b10_i2c1_node,
+	&ov13b10_camera_node,
+	&ov13b10_ports,
+	&ov13b10_port_node,
+	&ov13b10_endpoint_node,
+	NULL
+};
+
+static const struct amdisp_platform_info ov13b10_platform_config = {
+	.board_info = {
+		.dev_name = "ov13b10",
+		I2C_BOARD_INFO("ov13b10", AMDISP_OV13B10_I2C_ADDR),
+	},
+	.swnodes = ov13b10_amd_isp4_nodes,
+};
+
 static const struct acpi_device_id amdisp_sensor_ids[] = {
 	{ AMDISP_OV05C10_HID, (kernel_ulong_t)&ov05c10_platform_config },
+	{ AMDISP_OV13B10_HID, (kernel_ulong_t)&ov13b10_platform_config },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, amdisp_sensor_ids);
-- 
2.56.0

