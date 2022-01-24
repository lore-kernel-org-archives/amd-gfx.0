Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34006C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 18:07:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9C5010E518;
	Mon, 24 Jan 2022 18:07:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B56B610E518
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 18:07:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cP89XFplqoyWhhDzZLS4cGBfHBvgE0fW+zDRLUbs7Ne87LkzN4UmmDaTr1rP7rF+sid75OIV5ZfKWYZq6oDHCjcCWTiAJf8uo+LQEAu8tLp9kqvmLRZxrMki7fMPDQCaGxNyMdIBM0Yx5b70qD4nozz8sKHLJPT1RMb+49ovCn3n0sWpn5f8KEl8buN1KYuMydG07l3PgZwSxQHBbn/XfvkOHyJJNbnP1KtP1gXfGMdXBJ5e/3d9iC0n4iAB+ckB/LMbSEEGwlQOAKfMobjh5l2gb2vO5CO6pe+OwhXKNrTtotXd48dblam4jr74ByDBwlBtLToQBh03zokCUQoRZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSOAueklIIROYJ5YrLq/uSSYyzj7M/w53Lzcl7gG6X4=;
 b=gvjNTnJSF91z6+Ctwd3fjthWDfhH/3chBjaKYDnfkUw2U5/0sppqV/ySAIOQ0sjT2VeZcZQ5y5RfVQ7jkk5mol9cwWE4H5uqP/jqY9IhRnl7fqA53Ey/AEKxCSkK9fBBCq9uFRfX2WwG6utToALjyhFZ/A28whqhxYCLAlDgR/h9f5sIVrcnmGG67mYlcDIbwxKNYiKevivps6Dm12B+MkESFQvAac2okCHDpE5WamHutwnH+uppXEHA/f11Oz/DAnMLye7RTrrdKxHnt/GxsLdGPWtvFSTAYwV5aEBaZE2acUDYKOp3gRtHtsGczb+b10KHGrjpkznIZqyhvOum9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSOAueklIIROYJ5YrLq/uSSYyzj7M/w53Lzcl7gG6X4=;
 b=Z14J1Euk5KJEaQwzbxriWLcZrsrIkNJIX47vnB6+7+8prqeONsmbiS4XYXtdnkN/Qiq4VhmxAC4qx3yWguvuccG5mij1ZyNSmDYRAnb4GsR0j32WOgYPUy8PuhA9ic2iTaPf5glyF4Hw/98b0NMfJm+Xs5fz5qRdyWpjoAywtJk=
Received: from BN8PR04CA0015.namprd04.prod.outlook.com (2603:10b6:408:70::28)
 by DM5PR12MB1836.namprd12.prod.outlook.com (2603:10b6:3:114::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Mon, 24 Jan
 2022 18:07:44 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::81) by BN8PR04CA0015.outlook.office365.com
 (2603:10b6:408:70::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Mon, 24 Jan 2022 18:07:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Mon, 24 Jan 2022 18:07:44 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 24 Jan
 2022 12:07:43 -0600
From: Tom St Denis <tom.stdenis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Add ip_discovery_text sysfs entry
Date: Mon, 24 Jan 2022 13:07:36 -0500
Message-ID: <20220124180736.2646458-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e4d9b20-7721-4e17-b3a2-08d9df646b69
X-MS-TrafficTypeDiagnostic: DM5PR12MB1836:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB183656907CAFD71BD3C03BDDF75E9@DM5PR12MB1836.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oIcvmdef/detL9y83fwE+7d8FwJRGuYfvoEhIJMyNLmTqz26aLlK7CNxui2a3Yf4LEmThD9Zzr329PZaQL7z0EcGQQmt5dldS6ieeLbZyfcQXPjHv3kXCRGjqA4Ch0ReV9ROa7+BrDsAsqCQwU9IWms0LFPvvpnyAM8JlkT0AsaNf/DIfttPZ2ZeRKdVrocGwoR2OmvV25dsQaV9XJCT0CDmdVqZGwa4RVyrwfJ4vqOZcLnk+jjFAl6Pokl+y7qTCJIdQOgWb3V59j2TyCZ+PDNu0XHmNFNnKE51hxGFbgpKULv5pLVw4zbRlaQRot2rJEKEt3QB+l34zrNUjgHOAUxHawWg9tGBM9beaQs4I/bLg+gBNDJEmmQYaWSYjuONmVOhRXlsksh48IwWCWVAnvhEKuhLeFgKfijcdT+YGde+Bc+RuuZuTBdeWVWMYHGAgp4GoZmbs3gaQVYm55k4QCZ5mwdoxwWVWxnN/xAY2hvnucEOrXyKIif84I9zxGe6iAw/RC+IWDXa7Ry9lwICxJ8dB8yvAqi5Wkw0dkrcxE9FiecfBW+/s7QlcNUvgniB3OVICTRhtZQd5YPtnBvcq+/jN6IVmx5nvlz/RhEfl5us74mUOOiGrIGzo0IcWt2qBa6yIfhpSpLA15MdD34S7ofn+nmuNeeUBiNCNCNqzQFX1epgV19CCIc3bmPUGxk8y55agaHdC/O/Wz0vaOfjBugpHj2v3T0veTd3+9P/zxPoxTLuJ/2Go/UipRw+iRyPMnT5TCCdGi3pI0Z4VHkOYeUdj07+p6OsVTxrIp2tUtE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700004)(46966006)(36840700001)(508600001)(336012)(82310400004)(70206006)(8936002)(83380400001)(36756003)(36860700001)(16526019)(70586007)(86362001)(316002)(1076003)(6666004)(2906002)(356005)(5660300002)(26005)(2616005)(47076005)(186003)(8676002)(6916009)(81166007)(426003)(4326008)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 18:07:44.0980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4d9b20-7721-4e17-b3a2-08d9df646b69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1836
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
Cc: Tom St Denis <tom.stdenis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Newer hardware has a discovery table in hardware that the kernel will
rely on instead of header files for things like IP offsets.  This
sysfs entry adds a simple to parse table of IP instances and segment
offsets.

Produces output that looks like:

$ cat ip_discovery_text
ATHUB{0} v2.0.0: 00000c00 02408c00
CLKA{0} v11.0.0: 00016c00 02401800
CLKA{1} v11.0.0: 00016e00 02401c00
CLKA{2} v11.0.0: 00017000 02402000
CLKA{3} v11.0.0: 00017200 02402400
CLKA{4} v11.0.0: 0001b000 0242d800
CLKB{0} v11.0.0: 00017e00 0240bc00
DBGU_NBIO{0} v3.0.0: 000001c0 02409000
DBGU0{0} v3.0.0: 00000180 02409800
DBGU1{0} v3.0.0: 000001a0 02409c00
DF{0} v3.0.0: 00007000 0240b800
DFX{0} v4.1.0: 00000580 02409400
DFX_DAP{0} v2.0.0: 000005a0 00b80000 0240c400
DMU{0} v2.0.2: 00000012 000000c0 000034c0 00009000 02403c00
FUSE{0} v11.0.0: 00017400 02401400
GC{0} v10.1.10: 00001260 0000a000 02402c00

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 77 ++++++++++++++++++-
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3bc76759c143..6920f73bbe73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1019,6 +1019,7 @@ struct amdgpu_device {
 	struct amdgpu_ip_block          ip_blocks[AMDGPU_MAX_IP_NUM];
 	uint32_t		        harvest_ip_mask;
 	int				num_ip_blocks;
+	char			*ip_discovery_text;
 	struct mutex	mn_lock;
 	DECLARE_HASHTABLE(mn_hash, 7);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 285811509d94..c64cab0ad18e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -267,6 +267,19 @@ static void amdgpu_discovery_harvest_config_quirk(struct amdgpu_device *adev)
 	}
 }
 
+static ssize_t ip_discovery_text_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	return sysfs_emit(buf, "%s", adev->ip_discovery_text);
+}
+
+static DEVICE_ATTR(ip_discovery_text, S_IRUGO,
+				ip_discovery_text_show, NULL);
+
+
 static int amdgpu_discovery_init(struct amdgpu_device *adev)
 {
 	struct table_info *info;
@@ -351,6 +364,11 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 		goto out;
 	}
 
+	// init sysfs for ip_discovery
+	r = sysfs_create_file(&adev->dev->kobj, &dev_attr_ip_discovery_text.attr);
+	if (r)
+		dev_err(adev->dev, "Could not create amdgpu device attr\n");
+
 	return 0;
 
 out:
@@ -363,7 +381,11 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 void amdgpu_discovery_fini(struct amdgpu_device *adev)
 {
 	kfree(adev->mman.discovery_bin);
+	kfree(adev->ip_discovery_text);
+	sysfs_remove_file(&adev->dev->kobj, &dev_attr_ip_discovery_text.attr);
+
 	adev->mman.discovery_bin = NULL;
+	adev->ip_discovery_text = NULL;
 }
 
 static int amdgpu_discovery_validate_ip(const struct ip *ip)
@@ -382,6 +404,20 @@ static int amdgpu_discovery_validate_ip(const struct ip *ip)
 	return 0;
 }
 
+static int add_string(char **dst, unsigned *size, char *src)
+{
+	if (strlen(src) + strlen(*dst) >= *size) {
+		void *tmp = krealloc(*dst, *size + 4096, GFP_KERNEL);
+		if (!tmp) {
+			return -1;
+		}
+		*dst = tmp;
+		*size = *size + 4096;
+	}
+	strcat(*dst, src);
+	return 0;
+}
+
 int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 {
 	struct binary_header *bhdr;
@@ -396,6 +432,8 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 	int hw_ip;
 	int i, j, k;
 	int r;
+	unsigned txt_size = 4096;
+	char *linebuf;
 
 	r = amdgpu_discovery_init(adev);
 	if (r) {
@@ -410,6 +448,15 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 
 	DRM_DEBUG("number of dies: %d\n", num_dies);
 
+	adev->ip_discovery_text = kzalloc(txt_size, GFP_KERNEL);
+	linebuf = kzalloc(4096, GFP_KERNEL);
+	if (!adev->ip_discovery_text || !linebuf) {
+		DRM_ERROR("Out of memory\n");
+		kfree(linebuf);
+		kfree(adev->ip_discovery_text);
+		return -ENOMEM;
+	}
+
 	for (i = 0; i < num_dies; i++) {
 		die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
 		dhdr = (struct die_header *)(adev->mman.discovery_bin + die_offset);
@@ -419,6 +466,8 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 		if (le16_to_cpu(dhdr->die_id) != i) {
 			DRM_ERROR("invalid die id %d, expected %d\n",
 					le16_to_cpu(dhdr->die_id), i);
+			kfree(linebuf);
+			kfree(adev->ip_discovery_text);
 			return -EINVAL;
 		}
 
@@ -458,6 +507,19 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 			    le16_to_cpu(ip->hw_id) == SDMA3_HWID)
 				adev->sdma.num_instances++;
 
+			snprintf(linebuf, 4096, "%s{%d} v%d.%d.%d: ",
+				  hw_id_names[le16_to_cpu(ip->hw_id)],
+				  ip->number_instance,
+				  ip->major, ip->minor,
+				  ip->revision);
+			if (add_string(&adev->ip_discovery_text, &txt_size, linebuf)) {
+				DRM_ERROR("Out of memory\n");
+				kfree(linebuf);
+				kfree(adev->ip_discovery_text);
+				return -ENOMEM;
+			}
+
+
 			for (k = 0; k < num_base_address; k++) {
 				/*
 				 * convert the endianness of base addresses in place,
@@ -465,6 +527,19 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				 */
 				ip->base_address[k] = le32_to_cpu(ip->base_address[k]);
 				DRM_DEBUG("\t0x%08x\n", ip->base_address[k]);
+				snprintf(linebuf, 4096, "%08lx ", (unsigned long)ip->base_address[k]);
+				if (add_string(&adev->ip_discovery_text, &txt_size, linebuf)) {
+					DRM_ERROR("Out of memory\n");
+					kfree(linebuf);
+					kfree(adev->ip_discovery_text);
+					return -ENOMEM;
+				}
+			}
+			if (add_string(&adev->ip_discovery_text, &txt_size, "\n")) {
+				DRM_ERROR("Out of memory\n");
+				kfree(linebuf);
+				kfree(adev->ip_discovery_text);
+				return -ENOMEM;
 			}
 
 			for (hw_ip = 0; hw_ip < MAX_HWIP; hw_ip++) {
@@ -491,7 +566,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 			ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
 		}
 	}
-
+	kfree(linebuf);
 	return 0;
 }
 
-- 
2.32.0

