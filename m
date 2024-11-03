Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C40BD10C0D
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2024 09:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78C6410E3A8;
	Mon,  4 Nov 2024 09:05:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.b="FKhFlW+f";
	dkim-atps=neutral
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8630710E284;
 Sun,  3 Nov 2024 17:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
 s=mail; t=1730653481;
 bh=i1lGRcvBSYaAkRCU3PsefBTXEi2eEGtd/RNZhauMerg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=FKhFlW+fXVU9iiG5WHWrfxqIg2MK5RN4rmEJ6qMm9w3609SWSEqzIiyskpf0F3SE/
 5Hue+UAKF4NoE2Q53mkBkJ7j/9iT4JRSPm/DM+o1r+XqpuQf548H1TiWzMDARBYT4p
 NmQ6pgjd99tSp5B6B0CVtWY1Wv6AMrStXbMf+hV8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 03 Nov 2024 17:03:39 +0000
Subject: [PATCH v2 10/10] driver core: Constify attribute arguments of
 binary attributes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241103-sysfs-const-bin_attr-v2-10-71110628844c@weissschuh.net>
References: <20241103-sysfs-const-bin_attr-v2-0-71110628844c@weissschuh.net>
In-Reply-To: <20241103-sysfs-const-bin_attr-v2-0-71110628844c@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, 
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 "David E. Box" <david.e.box@linux.intel.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Frederic Barrat <fbarrat@linux.ibm.com>, 
 Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Logan Gunthorpe <logang@deltatee.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-rdma@vger.kernel.org, linux-mtd@lists.infradead.org, 
 platform-driver-x86@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-alpha@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730653468; l=2330;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=i1lGRcvBSYaAkRCU3PsefBTXEi2eEGtd/RNZhauMerg=;
 b=wjQlo57jq0Wj7AlLBOYWjC3NLTcXdQ4S/vHvyo3etlKonEvBK3xDMeXVEI2nFeo1fRBiMSJWq
 8Dy1FhYi+4pDACqaxOlIcEPw5eL4UaDS9rJJgllbu0x7Wp3mt9dGtys
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Mailman-Approved-At: Mon, 04 Nov 2024 09:05:01 +0000
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

As preparation for the constification of struct bin_attribute,
constify the arguments of the read and write callbacks.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/base/node.c     | 4 ++--
 drivers/base/topology.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index eb72580288e62727e5b2198a6451cf9c2533225a..3e761633ac75826bedb5dd30b879f7cc1af95ec3 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -27,7 +27,7 @@ static const struct bus_type node_subsys = {
 };
 
 static inline ssize_t cpumap_read(struct file *file, struct kobject *kobj,
-				  struct bin_attribute *attr, char *buf,
+				  const struct bin_attribute *attr, char *buf,
 				  loff_t off, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -48,7 +48,7 @@ static inline ssize_t cpumap_read(struct file *file, struct kobject *kobj,
 static BIN_ATTR_RO(cpumap, CPUMAP_FILE_MAX_BYTES);
 
 static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
-				   struct bin_attribute *attr, char *buf,
+				   const struct bin_attribute *attr, char *buf,
 				   loff_t off, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 89f98be5c5b9915b2974e184bf89c4c25c183095..1090751d7f458ce8d2a50e82d65b8ce31e938f15 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -23,7 +23,7 @@ static ssize_t name##_show(struct device *dev,				\
 
 #define define_siblings_read_func(name, mask)					\
 static ssize_t name##_read(struct file *file, struct kobject *kobj,		\
-			   struct bin_attribute *attr, char *buf,		\
+			   const struct bin_attribute *attr, char *buf,		\
 			   loff_t off, size_t count)				\
 {										\
 	struct device *dev = kobj_to_dev(kobj);                                 \
@@ -33,7 +33,7 @@ static ssize_t name##_read(struct file *file, struct kobject *kobj,		\
 }										\
 										\
 static ssize_t name##_list_read(struct file *file, struct kobject *kobj,	\
-				struct bin_attribute *attr, char *buf,		\
+				const struct bin_attribute *attr, char *buf,	\
 				loff_t off, size_t count)			\
 {										\
 	struct device *dev = kobj_to_dev(kobj);					\

-- 
2.47.0

