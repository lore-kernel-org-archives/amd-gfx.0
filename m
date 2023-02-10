Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980ACC636CD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Feb 2023 08:04:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A27710EC8D;
	Fri, 10 Feb 2023 08:04:09 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8E5710EC55
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 04:51:07 +0000 (UTC)
Received: by mail-pg1-x530.google.com with SMTP id s8so2950917pgg.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Feb 2023 20:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEls10WodkspsIvZIvxa4LCxo5R1yCy5xPl31tNRCfY=;
 b=AI5OkR5ngOdIYwA82Bd2NHyMJ+O2BLu1AlHUiAUk5u2mES8050ILPnIi34V/HwnVmn
 UCnnl/NNHpnSFBN3X0R580Y09W5YGDjQXorCqi2JWHAwRM3mAVXKAyPB7q7B66d3DoWt
 zBvfn3AmAyRezdi5kNYRSaoRxCZe3u4hC11prURWNE0PK6ZNCw5117fr7UHA3ZhhHI6z
 ua9y3dmza6fdLajFD3iCgQy+ca3vadxm1QgxmG6b53N46lfItM+tP6BzFu/BuB6LbEC1
 2TmnClABN6Fxc12v6c0kbWm8LL7Al2NDRYIr/vhwsP9jpjc8vOPXdePVWan8RRrIxgG1
 ma/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tEls10WodkspsIvZIvxa4LCxo5R1yCy5xPl31tNRCfY=;
 b=kqRLmxJ4wx1DKNnHF7V8btSeHYW0QytMxwCHBaVtXqrA4ysYTUfh1ETM/vrFuh5xB/
 8YGlcMowJHXcBWMe9BADT+GW2fALbGSvDj6MUMQTkqfdcGrGmQflKbF++jf0H1Esan0H
 NbrXJOrYQS374V/FznslZRmFQ3USRWutDpBVDwo1sCcWzEuBaZWdomPFNuWSw8d5VZyd
 w92JCHefU+0klWmovoOQQil8nddgdbBanEz6+FB5SbF5V7+aOrVrjAwnON0kUv1mFvMs
 099BdmBQaGFq90RxobRsuqfnbk6je+mYIu+Nr+hY0q/ODOjkZta6B7zIa/Zm7KXlrpcT
 Mw+Q==
X-Gm-Message-State: AO0yUKVitXEqRa6v6+EE9d95GnkD8ufM9kcMyKwboFXEbC8V8wXghtF5
 YZ8Z1c1LQKHJ56y4p07XuY8=
X-Google-Smtp-Source: AK7set+I/CPPxHXAhf5qBsL4mcZeaWR1Cid3atIIseLpDh1NtpOroP8ski833jPHpzXBgHHcqOiaLw==
X-Received: by 2002:a62:15d3:0:b0:5a8:4db3:266e with SMTP id
 202-20020a6215d3000000b005a84db3266emr3828885pfv.10.1676004667360; 
 Thu, 09 Feb 2023 20:51:07 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a62ea0d000000b0057fec210d33sm2269218pfh.152.2023.02.09.20.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Feb 2023 20:51:07 -0800 (PST)
From: Orlando Chamberlain <orlandoch.dev@gmail.com>
To: platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [RFC PATCH 7/9] apple-gmux: add sysfs interface
Date: Fri, 10 Feb 2023 15:48:24 +1100
Message-Id: <20230210044826.9834-8-orlandoch.dev@gmail.com>
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

Allow reading gmux ports from userspace. When the unsafe module
parameter allow_user_writes is true, writing 1 byte
values is also allowed.

For example:

cd /sys/bus/acpi/devices/APP000B:00/physical_node/
echo 4 > gmux_selected_port
cat gmux_selected_port_data | xxd -p

Will show the gmux version information (00000005 in this case)

Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 129 ++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index c38d6ef0c15a..756059d48393 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -66,6 +66,11 @@ struct apple_gmux_data {
 	enum vga_switcheroo_client_id switch_state_external;
 	enum vga_switcheroo_state power_state;
 	struct completion powerchange_done;
+
+#ifdef CONFIG_SYSFS
+	/* sysfs data */
+	int selected_port;
+#endif /* CONFIG_SYSFS */
 };
 
 static struct apple_gmux_data *apple_gmux_data;
@@ -651,6 +656,121 @@ static void gmux_notify_handler(acpi_handle device, u32 value, void *context)
 		complete(&gmux_data->powerchange_done);
 }
 
+/**
+ * DOC: Sysfs Interface
+ *
+ * gmux ports can be read from userspace as a sysfs interface. For example:
+ *
+ * # echo 4 > /sys/bus/acpi/devices/APP000B:00/physical_node/gmux_selected_port
+ * # cat /sys/bus/acpi/devices/APP000B:00/physical_node/gmux_selected_port_data | xxd -p
+ * 00000005
+ *
+ * Reads 4 bytes from port 4 (GMUX_PORT_VERSION_MAJOR).
+ *
+ * Single byte writes are also supported, however this must be enabled with the
+ * unsafe allow_user_writes module parameter.
+ *
+ */
+
+#ifdef CONFIG_SYSFS
+
+static bool allow_user_writes;
+module_param_unsafe(allow_user_writes, bool, 0);
+MODULE_PARM_DESC(allow_user_writes, "Allow userspace to write to gmux ports (default: false) (bool)");
+
+static ssize_t gmux_selected_port_store(struct device *dev,
+		struct device_attribute *attr, const char *sysfsbuf, size_t count)
+{
+	struct apple_gmux_data *gmux_data = dev_get_drvdata(dev);
+	u8 port;
+
+	if (kstrtou8(sysfsbuf, 10, &port) < 0)
+		return -EINVAL;
+
+	/* On pio gmux's, make sure the user doesn't access too high of a port. */
+	if ((gmux_data->config == &apple_gmux_pio) &&
+		port > (gmux_data->iolen - 4))
+		return -EINVAL;
+
+	gmux_data->selected_port = port;
+	return count;
+}
+
+static ssize_t gmux_selected_port_show(struct device *dev,
+		struct device_attribute *attr, char *sysfsbuf)
+{
+	struct apple_gmux_data *gmux_data = dev_get_drvdata(dev);
+
+	return sysfs_emit(sysfsbuf, "%d\n", gmux_data->selected_port);
+}
+
+DEVICE_ATTR_RW(gmux_selected_port);
+
+static ssize_t gmux_selected_port_data_store(struct device *dev,
+		struct device_attribute *attr, const char *sysfsbuf, size_t count)
+{
+	struct apple_gmux_data *gmux_data = dev_get_drvdata(dev);
+
+	if (count == 1)
+		gmux_write8(gmux_data, gmux_data->selected_port, *sysfsbuf);
+	else
+		return -EINVAL;
+
+	return count;
+}
+
+static ssize_t gmux_selected_port_data_show(struct device *dev,
+		struct device_attribute *attr, char *sysfsbuf)
+{
+	struct apple_gmux_data *gmux_data = dev_get_drvdata(dev);
+	u32 data;
+
+	data = gmux_read32(gmux_data, gmux_data->selected_port);
+	memcpy(sysfsbuf, &data, sizeof(data));
+
+	return sizeof(data);
+}
+
+struct device_attribute dev_attr_gmux_selected_port_data_rw = __ATTR_RW(gmux_selected_port_data);
+struct device_attribute dev_attr_gmux_selected_port_data_ro = __ATTR_RO(gmux_selected_port_data);
+
+static int gmux_init_sysfs(struct pnp_dev *pnp)
+{
+	int ret;
+
+	ret = device_create_file(&pnp->dev, &dev_attr_gmux_selected_port);
+	if (ret)
+		return ret;
+	if (allow_user_writes)
+		ret = device_create_file(&pnp->dev, &dev_attr_gmux_selected_port_data_rw);
+	else
+		ret = device_create_file(&pnp->dev, &dev_attr_gmux_selected_port_data_ro);
+	if (ret)
+		device_remove_file(&pnp->dev, &dev_attr_gmux_selected_port);
+	return ret;
+}
+
+static void gmux_fini_sysfs(struct pnp_dev *pnp)
+{
+	device_remove_file(&pnp->dev, &dev_attr_gmux_selected_port);
+	if (allow_user_writes)
+		device_remove_file(&pnp->dev, &dev_attr_gmux_selected_port_data_rw);
+	else
+		device_remove_file(&pnp->dev, &dev_attr_gmux_selected_port_data_ro);
+}
+
+#else
+
+static int gmux_init_sysfs(struct pnp_dev *pnp)
+{
+	return 0;
+}
+static void gmux_fini_sysfs(struct pnp_dev *pnp)
+{
+}
+
+#endif /* CONFIG_SYSFS */
+
 static int gmux_suspend(struct device *dev)
 {
 	struct pnp_dev *pnp = to_pnp_dev(dev);
@@ -846,8 +966,16 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 		goto err_register_handler;
 	}
 
+	ret = gmux_init_sysfs(pnp);
+	if (ret) {
+		pr_err("Failed to register gmux sysfs entries\n");
+		goto err_sysfs;
+	}
+
 	return 0;
 
+err_sysfs:
+	vga_switcheroo_unregister_handler();
 err_register_handler:
 	gmux_disable_interrupts(gmux_data);
 	apple_gmux_data = NULL;
@@ -877,6 +1005,7 @@ static void gmux_remove(struct pnp_dev *pnp)
 {
 	struct apple_gmux_data *gmux_data = pnp_get_drvdata(pnp);
 
+	gmux_fini_sysfs(pnp);
 	vga_switcheroo_unregister_handler();
 	gmux_disable_interrupts(gmux_data);
 	if (gmux_data->gpe >= 0) {
-- 
2.39.1

