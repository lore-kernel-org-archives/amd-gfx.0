Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 894C6C71133
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Aug 2023 09:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0733B10E649;
	Fri, 25 Aug 2023 09:29:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F5A710E649
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Aug 2023 09:29:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJSvIVokKxU4zRJ+Fm6+eSlg9KfSSJpuS4mpXwnwX/HohjGXA7jHKQKhUJ2LAGnQJy/NInQMsuBvuaSOaynkTsADjQnpUfONxPKjYeykPNGikw8HC4sx6ur5Wo02G3KAYun1a5EkwvW4bMLI9AIqyPNX9C/L1WWH3mPXZPjfkOU73P9ei/t7X0dSBhWjIjOCeC+ERKOgIs8CraMMTY8hSR5KLvvRInk3WUZu2ElZvQSuwVrHn0L9DcmbJi7Jwwn+xE3ktq/LRuol1kMVa1DfruBQr25B3X7JravC8vYibZsm9R0eR5MucD+/N1He1W1PAa/cptE1cT5MJbvvHjOzdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5Q8pkAia4IYLUQzUSMjECDsbrclpjzpvoK7MmR//Vs=;
 b=IsaW5kN8KoGjcToKaaxG3VBSm/FkBtesTBX9wvATwivN97ikaaKLkrgI/LhmDrKSfEEuaLC/iKT4bqRZz/Nuwi30lgHkt2n2eDbcDmsdGxSTUNcU94hgVYuBjQCywIxujBonsrRJbRheoNSK+aiFuwN4U10j55k4KuWGvBpqht9fZu3PLhShFVMELnDIAsUGj0g7y4Ku2cSzSiSI4sBSB+5lx1ErMNVdT0/j1coaEZZTRhGYc0PINazIssbxi73vNGZIm175vNUXEYiJ4FFk1V56dl5b+nrKfZuuVIBJBk00axBjKJZ6nmYP5clMqI0c4qYxck86weMxg/4L/hvPPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5Q8pkAia4IYLUQzUSMjECDsbrclpjzpvoK7MmR//Vs=;
 b=l9JaSw7l3aPjq2c2ydl9iB5yOEYLgKgraJwB1I2exIcwZ3l4e0rimE+V+9GzL3RIRUuSq7/HPIvBz7bRsLmtK/KshQZAVg+stHmE8+HJ+1ZjpRdUj1kUhbZU6cp3W/FSyypEZLNrARxt6gS6jAaCBDcuoSVVj8M+SU55la6OzgY=
Received: from SN7PR04CA0099.namprd04.prod.outlook.com (2603:10b6:806:122::14)
 by DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.27; Fri, 25 Aug 2023 09:29:39 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:122:cafe::89) by SN7PR04CA0099.outlook.office365.com
 (2603:10b6:806:122::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25 via Frontend
 Transport; Fri, 25 Aug 2023 09:29:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 25 Aug 2023 09:29:38 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 04:29:35 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add only valid firmware version nodes
Date: Fri, 25 Aug 2023 14:57:43 +0530
Message-ID: <20230825092743.842810-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DS0PR12MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 808fb19b-a666-4681-2bef-08dba54dcde2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fIp6rMdS3Y5ZAI089FoG7NjSx/u+kCITGXUj7X0ikS+7Scr2c5jjdRLXa5uyHQjKieUZElEZ5MPsLSXLfvOfDqKELe6RSpgk0hiWQ8NOqj36fGcdes5GaBNyEVJ39CW8IWNJ/GQFRaTcpTaeB/nnzIfEPPS0SOEy3xhUJ4EK4uLNPlOOyohkZEWGZuT7LMC5XNjO3uqUSoejx0CrBq8LGKCgzyu6cvp4+HoUfq0jAd0ctvJxrEJfUTrWQd/oO6rV6iVPfWik2ESiMD2oNnfSvIfCmZvCgrYos42DJUjPJVqeR/2zIhZ6yDVBkQYUJuBz4D9seWXIu7WyVAhrpNNrax5pp8Jmb+UA5yrOS6S46lzDV43vkkRR91IwrHzzZp01ckIN6JXjihtat2E4HR9xBG+oClpxr5oGhWbSKqueEf1AIY6BbSfDSDlHJZKt7nsPO22DP3EsNhla09sd2GLsGGPT1dEXichR0OYipRL4bZdEe71htVlMbbgdpR9q8TquNw58d380vJe/92OhqVXyKX8LNIwht4zg8mKLIb0q10MtZSybMt/MHQTxSVKbSRNTtDpG6qgoeXOtKnteaRISwjnId5APsj1ICp4W8sPad3M5YqRVdMjUwKWb9/7efONelbskKGf1k9EIiMNBybY1odA4ZtJOWg+SL7027QMvbP4OjejzgPp4OjQ3Uf1CGdkb39i8HR5ooNQ0KPf+oBFErTlh1u1CGfJoXSlR3KoVrCD643yRCVo3CzHBSOPFzar/n06JPEws/jPgwyNn4IKznA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(1800799009)(186009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(1076003)(40460700003)(2616005)(5660300002)(4326008)(8676002)(8936002)(336012)(426003)(47076005)(36756003)(83380400001)(44832011)(36860700001)(26005)(40480700001)(16526019)(82740400003)(356005)(6666004)(81166007)(70586007)(7696005)(54906003)(70206006)(6916009)(316002)(478600001)(41300700001)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 09:29:38.7804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 808fb19b-a666-4681-2bef-08dba54dcde2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Show only firmware version attributes that have valid version. Hide
others.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 33 ++++++++++++++++++++---
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 8beefc045e14..b0b37c056c36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -669,15 +669,25 @@ const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID ucode_id)
 	}
 }
 
+static inline int amdgpu_ucode_is_valid(uint32_t fw_version)
+{
+	if (!fw_version)
+		return -EINVAL;
+
+	return 0;
+}
+
 #define FW_VERSION_ATTR(name, mode, field)				\
 static ssize_t show_##name(struct device *dev,				\
-			  struct device_attribute *attr,		\
-			  char *buf)					\
+			   struct device_attribute *attr, char *buf)	\
 {									\
 	struct drm_device *ddev = dev_get_drvdata(dev);			\
 	struct amdgpu_device *adev = drm_to_adev(ddev);			\
 									\
-	return sysfs_emit(buf, "0x%08x\n", adev->field);	\
+	if (!buf)							\
+		return amdgpu_ucode_is_valid(adev->field);		\
+									\
+	return sysfs_emit(buf, "0x%08x\n", adev->field);		\
 }									\
 static DEVICE_ATTR(name, mode, show_##name, NULL)
 
@@ -722,9 +732,24 @@ static struct attribute *fw_attrs[] = {
 	NULL
 };
 
+#define to_dev_attr(x) container_of(x, struct device_attribute, attr)
+
+static umode_t amdgpu_ucode_sys_visible(struct kobject *kobj,
+					struct attribute *attr, int idx)
+{
+	struct device_attribute *dev_attr = to_dev_attr(attr);
+	struct device *dev = kobj_to_dev(kobj);
+
+	if (dev_attr->show(dev, dev_attr, NULL) == -EINVAL)
+		return 0;
+
+	return attr->mode;
+}
+
 static const struct attribute_group fw_attr_group = {
 	.name = "fw_version",
-	.attrs = fw_attrs
+	.attrs = fw_attrs,
+	.is_visible = amdgpu_ucode_sys_visible
 };
 
 int amdgpu_ucode_sysfs_init(struct amdgpu_device *adev)
-- 
2.25.1

