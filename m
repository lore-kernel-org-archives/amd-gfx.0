Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B6EC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 05:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F0DA10E168;
	Fri, 14 Jan 2022 05:59:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA73010E160
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 05:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtXVPLxulQete/r0qS73AEUSMVWq8AiCZ7Zcuev1NWCFNQ4cT+MyAzG9utLhlj4NsxACQozE7daY0jO/1RP4OduwFXpAkxR5myU20uw79kCBzQSUoE/LKD/Wc0FwG3No4xFe2VtJLZGAGvvQ0deGG7gMuTISjYQBlcWcWoAOdKK5xUzcyZyUsAViRwjTZTu7Wy2FMhS6HToIYHY4uNkN9MGznfg9YzGwrzkXt7/G87v/mtHkWMIu8CibVjXZ7FjUYTVGXZszCTO5TI4Yi3diibr0jBEiuO2gmVYDHLIFrWA04CFEJceA5mR24fClsVZbmpeEC3R2pKmDWyUonZ8hzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2VEMYz6jyI5O4z2iap1uLkpZRjc6CihQuDRjYT6xG8=;
 b=J+VckpWLCMtsZ2jcz0PnHuCPlz3FehAzRNlF2KvssaAqBeNSSx0sJfVKGpDmVMKo7pQ9cj2k44tqh/YMkrPD3AMw3ZkEvhXZUlTOFZfwKbX0zfHDK7mwRzJKAzYHFTn6tOYlYg8NBCH6APhQVk5l4uftFMQang5tHxmeei+JmgMSpq0LIPiZ2V6pXBGYQeuoB6173nm9jCcz1wEyv2yxN2z6u68huipsWao6vBK8hnJCC/1B/HQa+8JJcMXHf0EPKEU9HhNgIulNtJBfopfVvb/umuYo9eIu4mQHbSXnVaWYN1+UPt8MVLZSjRISU+6ehj/vC9pw6nELRBCulxhFQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2VEMYz6jyI5O4z2iap1uLkpZRjc6CihQuDRjYT6xG8=;
 b=PrqQQCOW2TwvHiSvmA+DbhhcM7f7jH8ukEksfex8P2YI9yREHE1JOQpaxFcGIcKk2Me1x0ZiEenSPAXCA33fF4gQHc6Cxo4M/HRwAPoHO2URH87wbWiPD1FQ11jyFAq5c6MrhOXjJ3JLQSHAHq6EZSVXgjwEvQ8+PvUPFhq2X1A=
Received: from BN9PR03CA0123.namprd03.prod.outlook.com (2603:10b6:408:fe::8)
 by BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Fri, 14 Jan
 2022 05:59:39 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::82) by BN9PR03CA0123.outlook.office365.com
 (2603:10b6:408:fe::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11 via Frontend
 Transport; Fri, 14 Jan 2022 05:59:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 05:59:38 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 13 Jan 2022 23:59:35 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>, <Hawking.Zhang@amd.com>,
 <pengju.zhou@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: apply vcn harvest quirk
Date: Fri, 14 Jan 2022 13:59:19 +0800
Message-ID: <20220114055919.13026-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 376248d2-8534-4415-181e-08d9d7230c6c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3126:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3126AB739A52B8159981A8F4F1549@BYAPR12MB3126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xAEj0bEFMC4lrHvUM+hO+WUv0PBNdlyrnZHYpipQKIcg4vIbpuAUn4oaM/dUicl5GOk2miYLf2VNOdVu6HyiB/mJYjD/BNDQ0/28kvJuml8R+iEtfR+dtsCQZYOGjvaCJxS6n9itAYJmgFaPYlBTb+gZZYuuHKaGnGmKcWkolTqhGkJDCHaehweh1I5ayaj3BZFH3akGRJ4bPa+b6kKKK6kX59YqzvcaDTZbFMgvFaaaHJTJNSfKXzhhO/GNXYr+eykDj2DW1c+eUL1XqlW0kG6yYqg4RxhJ6ZUPWQm/KIXZRUC4BkzGCmAgwGmo9/0X9WP5ETDnVu2C2hJiBRdQl4G1G4l2oyMQdgd3HBOYrSQx1kg/54NOMcEWWHkSSAF/Y7mMaucXGjz4ED8nODJoA5X/yl0P+V6AnHyceiHCL31Bxa1jztqeuFnYZZ4RdCLffCn9wVVoBw1rTh1Qn8Z3GEy3hDCexY9oaOHTpCGhBbIsSUtOB7iaW9DIMkods/Np4LXhKU5FzVfoc8Ld9vn4WVyRqnW8FFt8E0PimSJ/MHDn9n6tVrZeBOp/QQa6/49OqZMCqmNhw6+mMw3qM/bJCd6KRgH8qy8V+y4g3zK9MNUZfOmxHjVe5EecRpbe5LqhVRZyfxPDRzzWZKui8CUYw9K7s1NOCDgBBdDSrzNwzlneB50cL07NrTHi95BP6BSdCtAAyAo0oHkDXFRf3M359u4GhO2s8LBa/OM9cTCfBWAe5ulhz5D1r3n5j9YQ0NUhpzz4yx5jZhw5ETMWfGb4EtppmVzI8GFTJi1mlCccR7ITFu2y0W/v4g6QL4+1cH1L
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(6666004)(8936002)(82310400004)(336012)(16526019)(8676002)(1076003)(508600001)(47076005)(2616005)(5660300002)(36860700001)(426003)(44832011)(40460700001)(86362001)(186003)(110136005)(70206006)(81166007)(2906002)(70586007)(6636002)(316002)(4326008)(26005)(83380400001)(7696005)(356005)(36756003)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 05:59:38.1404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 376248d2-8534-4415-181e-08d9d7230c6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3126
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

This is a following patch to apply the workaround only on
those boards with a bad harvest table in ip discovery.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 32 ++++++++++++++++---
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 2f891ae90bad..07965ac6381b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -243,6 +243,30 @@ static inline bool amdgpu_discovery_verify_binary_signature(uint8_t *binary)
 	return (le32_to_cpu(bhdr->binary_signature) == BINARY_SIGNATURE);
 }
 
+static void amdgpu_discovery_harvest_config_quirk(struct amdgpu_device *adev)
+{
+	/*
+	 * So far, apply this quirk only on those Navy Flounder boards which
+	 * have a bad harvest table of VCN config.
+	 */
+	if ((adev->ip_versions[UVD_HWIP][1] == IP_VERSION(3, 0, 1)) &&
+		(adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 2))) {
+		switch (adev->pdev->revision) {
+		case 0xC1:
+		case 0xC2:
+		case 0xC3:
+		case 0xC5:
+		case 0xC7:
+		case 0xCF:
+		case 0xDF:
+			adev->vcn.harvest_config |= AMDGPU_VCN_HARVEST_VCN1;
+			break;
+		default:
+			break;
+		}
+	}
+}
+
 static int amdgpu_discovery_init(struct amdgpu_device *adev)
 {
 	struct table_info *info;
@@ -548,11 +572,9 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 			break;
 		}
 	}
-	/* some IP discovery tables on Navy Flounder don't have this set correctly */
-	if ((adev->ip_versions[UVD_HWIP][1] == IP_VERSION(3, 0, 1)) &&
-	    (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 2)) &&
-	    (adev->pdev->revision != 0xFF))
-		adev->vcn.harvest_config |= AMDGPU_VCN_HARVEST_VCN1;
+
+	amdgpu_discovery_harvest_config_quirk(adev);
+
 	if (vcn_harvest_count == adev->vcn.num_vcn_inst) {
 		adev->harvest_ip_mask |= AMD_HARVEST_IP_VCN_MASK;
 		adev->harvest_ip_mask |= AMD_HARVEST_IP_JPEG_MASK;
-- 
2.17.1

