Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257DCC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 04:56:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6170F10EB6C;
	Fri, 18 Feb 2022 04:56:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB6010EB73
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 04:56:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWIMLS5ShT0whGJi5utR5uns3mdHP/gKop6B0X/cD/QoaMuyeCYDsTnfX49LYGQi5RdNxEcMctQ4pZlNm6Tg397fC2ABpW69BNHIzzkbnCqLHnaxoUyUITvEwMQ0StUEm39FptV4c4VdMiDq0MTfDKk8qRneBM4IxoW86kBQzwpDlaDHQgQSIFxRKjo/YZLuxSoKJy+/6HplbaS2WpMS22289wOeH5Ggj7LCwVj7z8MyPVWOhh60tOeh8fAc8cT9EcsIJA0xgSYs6a1zfjpSdGIa3hjAoh4cvDsO/qcmpAx3CMm2I9krx6OmyRp1dfZEj5vuBH6BDMi2IjFpudyQ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbeb314uwfyuehpQkalpzR4KM3DRnDZvT/JxC1bWKIY=;
 b=G60nUXYs/CiL0wjz9hlqBYqeb5vHt9AuywJcoOi7ZUUAwqqZWsVXgUY7fwKaqq5jHYqNdXGuCxikbGDadCh6YEdGYrwqnZsHzxxxirwjfKaVBpXBys0b/qIjjgIp2bR6q9ji6NlDN8IYl4FmLG4UiHY72fKAXZOcGZSXCD8eQccb1GQJYO/OvFj7dmHWfwTjGAJFHQCKVNyVgLxbl4uz3+fZ4uaLu5S5MVcJ5uObz3r/QiaXUI/spPOU+B4AzUWuK2kFQdk9zKXmIewjJav9+wO07NqYT4W0e1ZS+UN80UHWvEfgJ5kp5xchyjGBOjAiJ4v+XDjpMle1CCt3S42PRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbeb314uwfyuehpQkalpzR4KM3DRnDZvT/JxC1bWKIY=;
 b=SQQiWzQ2e8qYsiGGOt6et7t+wZf4/VYsrOCPm/sJxyakp+rxZ3CqBz4p0+eVEGT354C29mZ85Av4XAw3VUtNHGZ0MinfZ4AK2WcXxgVmOoW7lJPmM3l1TdmtwMtNm0PjzaKuix41pdYnWRPMvcCESvmGKX8IB96PLF4AW+UMAlQ=
Received: from BN9PR03CA0978.namprd03.prod.outlook.com (2603:10b6:408:109::23)
 by BYAPR12MB4744.namprd12.prod.outlook.com (2603:10b6:a03:9e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Fri, 18 Feb
 2022 04:56:44 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::e5) by BN9PR03CA0978.outlook.office365.com
 (2603:10b6:408:109::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Fri, 18 Feb 2022 04:56:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 04:56:43 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 17 Feb 2022 22:56:41 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <christian.koenig@amd.com>, <xinhui.pan@amd.com>
Subject: [PATCH] drm/amdgpu: read harvest bit per IP data on legacy GPUs
Date: Fri, 18 Feb 2022 12:56:27 +0800
Message-ID: <20220218045627.13491-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c37eb63c-58f4-4de2-1560-08d9f29b0f49
X-MS-TrafficTypeDiagnostic: BYAPR12MB4744:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4744AEB9D78FDF1ED36C2CCBF1379@BYAPR12MB4744.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5McJIh9QxC4+U84iinkdyQodG7ZzKN7Ayuzxpc2O7yUTK8M7pNkbo+av08CLV3zAmWaiMonXs+ZXnwCEb2avnbl9cexC66cALczHI3qulXk2gMDQTNsQT1dU6kdiMvLA9FNzkB/CANGJA/aXbDY60A/1fHUDQ/gUAvYVY+8L7qsIcqQl3lFF/tQMe7TyWcuYSZC0XptVfJ4a7OJYRI9rQBBHxf8C0ZVX9vyXHU/b3BK3dV5EGZV5KuVwoShTv7UM308V0CrL0xLqytoRKma/ZS+QtDRZ6OsqAIGQ0k4rQwM5+OlzONWSngl2haBXflBK96jcv+3U842hndCQYSl3NQ9DwBYv+rADrrtFy45J3u+0YyN3EywdCve1ObyNmNq2mN9lPIa+pXKmUjLqJc8+nS6VWfIKyiYxc5f94tdGNZkDYUM21sgWiCcEwK2W8jOYKIhP7Y8ow3MwumaEvG42zKAqNtxjMYoyAPkw10//xpZR1GakUbKFoeLtxBAPjMZLjFxdJnHGlzjy24FWiOigPWEMgJBhZTtNKXl8XHZGElMn5Oy0iPPUUTIrD+fhEXKHN67Gj6rh8xILeSKmSJd2nTmHfqkL3A0pFmty+MCQR4nQtHjKidf4i71pQWhHQXTPzw28B9x9SWMOYtfqrSmXRCc+IC5+V64leiggN/jm86uoyrr7MJb0RxlTMyB301ctE/x+0qrh7tKcTaNZE6jTjWaxLJpezY1VlOAsZc3PpU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(40460700003)(6636002)(110136005)(82310400004)(7696005)(508600001)(1076003)(8936002)(36756003)(8676002)(81166007)(5660300002)(70586007)(86362001)(4326008)(316002)(6666004)(356005)(70206006)(83380400001)(426003)(2616005)(47076005)(186003)(36860700001)(2906002)(26005)(44832011)(16526019)(336012)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 04:56:43.8530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c37eb63c-58f4-4de2-1560-08d9f29b0f49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4744
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Based on firmware team's input, harvest table in VBIOS does
not apply well to legacy products like Navi1x, so seperate
harvest mask configuration retrieve from different places.
On legacy GPUs, scan harvest bit per IP data stuctures,
while for newer ones, still read IP harvest info from harvest
table.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 119 ++++++++++++++----
 1 file changed, 93 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 2506bcf36c87..2ccac1f1582f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -385,6 +385,87 @@ static int amdgpu_discovery_validate_ip(const struct ip *ip)
 	return 0;
 }
 
+static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
+						uint32_t *vcn_harvest_count)
+{
+	struct binary_header *bhdr;
+	struct ip_discovery_header *ihdr;
+	struct die_header *dhdr;
+	struct ip *ip;
+	uint16_t die_offset, ip_offset, num_dies, num_ips;
+	int i, j;
+
+	bhdr = (struct binary_header *)adev->mman.discovery_bin;
+	ihdr = (struct ip_discovery_header *)(adev->mman.discovery_bin +
+			le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
+	num_dies = le16_to_cpu(ihdr->num_dies);
+
+	/* scan harvest bit of all IP data structures */
+	for (i = 0; i < num_dies; i++) {
+		die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
+		dhdr = (struct die_header *)(adev->mman.discovery_bin + die_offset);
+		num_ips = le16_to_cpu(dhdr->num_ips);
+		ip_offset = die_offset + sizeof(*dhdr);
+
+		for (j = 0; j < num_ips; j++) {
+			ip = (struct ip *)(adev->mman.discovery_bin + ip_offset);
+
+			if (amdgpu_discovery_validate_ip(ip))
+				goto next_ip;
+
+			if (le16_to_cpu(ip->harvest) == 1) {
+				switch (le16_to_cpu(ip->hw_id)) {
+				case VCN_HWID:
+					(*vcn_harvest_count)++;
+					if (ip->number_instance == 0)
+						adev->vcn.harvest_config |= AMDGPU_VCN_HARVEST_VCN0;
+					else
+						adev->vcn.harvest_config |= AMDGPU_VCN_HARVEST_VCN1;
+					break;
+				case DMU_HWID:
+					adev->harvest_ip_mask |= AMD_HARVEST_IP_DMU_MASK;
+					break;
+				default:
+					break;
+                                }
+                        }
+next_ip:
+			ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
+		}
+	}
+}
+
+static void amdgpu_disocvery_read_from_harvest_table(struct amdgpu_device *adev,
+						uint32_t *vcn_harvest_count)
+{
+	struct binary_header *bhdr;
+	struct harvest_table *harvest_info;
+	int i;
+
+	bhdr = (struct binary_header *)adev->mman.discovery_bin;
+	harvest_info = (struct harvest_table *)(adev->mman.discovery_bin +
+			le16_to_cpu(bhdr->table_list[HARVEST_INFO].offset));
+	for (i = 0; i < 32; i++) {
+		if (le16_to_cpu(harvest_info->list[i].hw_id) == 0)
+			break;
+
+		switch (le16_to_cpu(harvest_info->list[i].hw_id)) {
+		case VCN_HWID:
+			(*vcn_harvest_count)++;
+			if (harvest_info->list[i].number_instance == 0)
+				adev->vcn.harvest_config |= AMDGPU_VCN_HARVEST_VCN0;
+			else
+				adev->vcn.harvest_config |= AMDGPU_VCN_HARVEST_VCN1;
+			break;
+		case DMU_HWID:
+			adev->harvest_ip_mask |= AMD_HARVEST_IP_DMU_MASK;
+			break;
+		default:
+			break;
+		}
+	}
+}
+
 /* ================================================== */
 
 struct ip_hw_instance {
@@ -1046,33 +1127,19 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int n
 
 void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 {
-	struct binary_header *bhdr;
-	struct harvest_table *harvest_info;
-	int i, vcn_harvest_count = 0;
-
-	bhdr = (struct binary_header *)adev->mman.discovery_bin;
-	harvest_info = (struct harvest_table *)(adev->mman.discovery_bin +
-			le16_to_cpu(bhdr->table_list[HARVEST_INFO].offset));
-
-	for (i = 0; i < 32; i++) {
-		if (le16_to_cpu(harvest_info->list[i].hw_id) == 0)
-			break;
+	int vcn_harvest_count = 0;
 
-		switch (le16_to_cpu(harvest_info->list[i].hw_id)) {
-		case VCN_HWID:
-			vcn_harvest_count++;
-			if (harvest_info->list[i].number_instance == 0)
-				adev->vcn.harvest_config |= AMDGPU_VCN_HARVEST_VCN0;
-			else
-				adev->vcn.harvest_config |= AMDGPU_VCN_HARVEST_VCN1;
-			break;
-		case DMU_HWID:
-			adev->harvest_ip_mask |= AMD_HARVEST_IP_DMU_MASK;
-			break;
-		default:
-			break;
-		}
-	}
+	/*
+	 * Harvest table does not fit Navi1x and legacy GPUs,
+	 * so read harvest bit per IP data structure to set
+	 * harvest configuration.
+	 */
+	if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 2, 0))
+		amdgpu_discovery_read_harvest_bit_per_ip(adev,
+							&vcn_harvest_count);
+	else
+		amdgpu_disocvery_read_from_harvest_table(adev,
+							&vcn_harvest_count);
 
 	amdgpu_discovery_harvest_config_quirk(adev);
 
-- 
2.17.1

