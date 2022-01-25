Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE3DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 18:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D144810E3F0;
	Tue, 25 Jan 2022 18:18:47 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E09010E3F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 18:18:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2gGnemp3Hlpo3yvRFD7Zlzl6LY0Blo8wkEPx3FvBMGplKlpqja7neMp7w2zGY9FNlkwxG8ZiRgsssqZhzeVGoPp/YLQk9iBqsHF61uZShx0Cp+UAmrPU+ICKtoElZoDJI7S50Ukar5pKig5BeuWuYLAVyMqDMtDk1Jk/IoImidehnUwBwGb8Y6aME+J2SWpLC09RbZlTrUn7MzyWA7QtIOsZb6GA3gqjk0XRTsUEFFU3R4JOGtf8kyodArMoJ9T8X/4AKoQ7IbOXVDBx53M74ZkaLMP0AowL4bYWlq0UPIa0uTV81PnTiCTsz2rsZPrTB1AGpiDu2c6aTw0wrTlmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dygKUufnvOYrk1TlPQT3zvrpLGRK2xjq9tz3aeNsWww=;
 b=IZaxcLmY2coPSpRL41a+D6dNIH8FbGDquNk48eqtUcSzrBk4bmRcF7KxqKz+KHeGemJtkKkFjhIAk4wFo0FgdpLDhK8HGcta/9TzG6HGiisfoatsOCMz6DdTuD3+2DaSvehOpM1oFZKYyIwvxtM8jkzDDkSZ80UAqaznR6Tq8xddmO9gbBf2PMRRZa6py3+dUBbqZuuPTFziTPMYdciFpwUun8D/7/+M4mq1FqZsclutTyMDEVSXqgc8bHp8UbHBdNCwIcHDydWQ1J8RDYod76JGyKGm+2PWRSO8/SBll4CT7ANwy89mmHHd8lUGv+Zv8bVyxr7xSEY5dHD97GSwyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dygKUufnvOYrk1TlPQT3zvrpLGRK2xjq9tz3aeNsWww=;
 b=A4YDi/3/I4mVEP8myL+9PY+f4I1wG3GxL7vpvXneTXq5zEUjklZH4QCrvmZizmP+Z9l7JZ+H+QfCg1LJXlebOCGtKxnAEwvlILHTzXj4s24NWpTcbCl3xM3SLHf72pLTIS7Ibai3kFPsssVUOOOwWy0hT01PFRqbV0R37GYKSqM=
Received: from DM6PR14CA0039.namprd14.prod.outlook.com (2603:10b6:5:18f::16)
 by BL0PR12MB4609.namprd12.prod.outlook.com (2603:10b6:208:8d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Tue, 25 Jan
 2022 18:18:44 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::4c) by DM6PR14CA0039.outlook.office365.com
 (2603:10b6:5:18f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Tue, 25 Jan 2022 18:18:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 18:18:43 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 25 Jan
 2022 12:18:42 -0600
From: Tom St Denis <tom.stdenis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Add ip_discovery_text sysfs entry (v2)
Date: Tue, 25 Jan 2022 13:18:35 -0500
Message-ID: <20220125181835.2735521-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3d918b7-ae99-4d98-997d-08d9e02f1f20
X-MS-TrafficTypeDiagnostic: BL0PR12MB4609:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4609844FBE4D633DE4058F30F75F9@BL0PR12MB4609.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jTI2UKMWqpV4jaOn4GFtA+SKqYLq/i/2erOgfEdzWVgkVdupJ9rYbquVlBVkyKouN1Mxik3n/N/uuO/twh+ryLWQ/oek+xmyRKbu/9zyIY7u1uEx0Ag91Wrnuf4qDIektTv2CLzJZdDunub+N6LtaMTi9l7twwfNhqaAISE3VZoA1u04L11AW6CudqaoSdylLRdO8qZTgazW6+UIFLtKxpb3LAjk2bdvu1jhoKfrihPL7PDFDIksUcrUCKBplL5IjAMvtKKejUlTuocV+k7yjP8ivIex1sOGxX4W4TIMuC+6NmGGS4L0RsjARr9vRzCXsEBQAzgAZ7kOkRYIReW+rSJBueo8QUCPaPY+Q1E2Vm2HYKWmoqN5V/IQEnfJO8rH5beg/QK3eS3ZyXYReRNdyBiuxBRBxKb+F3FOTzSjaG6279PcmtYPHlAcyNHqCaJJckVm/4+rfvFsvOAObsXhR2Q8pGCqmKMtda6ar1gX2amg9V2KiSYUuuKxLp4XggpaCVHf6BIvWhvZ1t5UbhB1TLC9t9BEBr7VreJXeFzAu2+f+1wA8dMoB/6rBl6GqWqSLL941eubNQmOtkSKwqZlA/FjUTHXO6AS5pRLGt+Vrv6DKaJANEbIJrUzE6Dk1wl+/ZcaUwlb46IInFx2myCArMvLPQs+HERHikch5n3OwIj1C1DqfiX9AsS5pJZYiGAs9b70gIcVFrin3XxpZwpEwVdZ/YmItg84VhPW8vWcWbSf8GkedPVuFC0CohQwL5/LKRujJGHYiuDDVdv7m5/MAU1UTXQ8Zegd6/nvbxsAM7k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700004)(46966006)(36840700001)(36860700001)(336012)(26005)(36756003)(81166007)(16526019)(2906002)(426003)(86362001)(2616005)(47076005)(186003)(1076003)(356005)(70586007)(82310400004)(8936002)(4326008)(83380400001)(5660300002)(6666004)(8676002)(316002)(40460700003)(70206006)(6916009)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 18:18:43.8232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d918b7-ae99-4d98-997d-08d9e02f1f20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4609
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

(v2): Use a macro for buffer size and fix alignment in amdgpu.h

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 79 ++++++++++++++++++-
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3bc76759c143..43caeb4bdc07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1019,6 +1019,7 @@ struct amdgpu_device {
 	struct amdgpu_ip_block          ip_blocks[AMDGPU_MAX_IP_NUM];
 	uint32_t		        harvest_ip_mask;
 	int				num_ip_blocks;
+	char            *ip_discovery_text;
 	struct mutex	mn_lock;
 	DECLARE_HASHTABLE(mn_hash, 7);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 07623634fdc2..d036977dab8a 100644
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
@@ -382,6 +404,22 @@ static int amdgpu_discovery_validate_ip(const struct ip *ip)
 	return 0;
 }
 
+#define IP_DISCOVERY_BLOCK_SIZE 4096
+
+static int add_string(char **dst, unsigned *size, char *src)
+{
+	if (strlen(src) + strlen(*dst) >= *size) {
+		void *tmp = krealloc(*dst, *size + IP_DISCOVERY_BLOCK_SIZE, GFP_KERNEL);
+		if (!tmp) {
+			return -1;
+		}
+		*dst = tmp;
+		*size = *size + IP_DISCOVERY_BLOCK_SIZE;
+	}
+	strcat(*dst, src);
+	return 0;
+}
+
 int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 {
 	struct binary_header *bhdr;
@@ -396,6 +434,8 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 	int hw_ip;
 	int i, j, k;
 	int r;
+	unsigned txt_size = IP_DISCOVERY_BLOCK_SIZE;
+	char *linebuf;
 
 	r = amdgpu_discovery_init(adev);
 	if (r) {
@@ -410,6 +450,15 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 
 	DRM_DEBUG("number of dies: %d\n", num_dies);
 
+	adev->ip_discovery_text = kzalloc(txt_size, GFP_KERNEL);
+	linebuf = kzalloc(IP_DISCOVERY_BLOCK_SIZE, GFP_KERNEL);
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
@@ -419,6 +468,8 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 		if (le16_to_cpu(dhdr->die_id) != i) {
 			DRM_ERROR("invalid die id %d, expected %d\n",
 					le16_to_cpu(dhdr->die_id), i);
+			kfree(linebuf);
+			kfree(adev->ip_discovery_text);
 			return -EINVAL;
 		}
 
@@ -458,6 +509,19 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 			    le16_to_cpu(ip->hw_id) == SDMA3_HWID)
 				adev->sdma.num_instances++;
 
+			snprintf(linebuf, IP_DISCOVERY_BLOCK_SIZE-1, "%s{%d} v%d.%d.%d: ",
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
@@ -465,6 +529,19 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				 */
 				ip->base_address[k] = le32_to_cpu(ip->base_address[k]);
 				DRM_DEBUG("\t0x%08x\n", ip->base_address[k]);
+				snprintf(linebuf, IP_DISCOVERY_BLOCK_SIZE-1, "%08lx ", (unsigned long)ip->base_address[k]);
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
@@ -491,7 +568,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 			ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
 		}
 	}
-
+	kfree(linebuf);
 	return 0;
 }
 
-- 
2.32.0

