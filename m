Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A245C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 16:34:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9177F89C17;
	Tue,  1 Mar 2022 16:34:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A96E989C17
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 16:34:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmDt0mFEK+EkXwmnDjFqVULZ3PMT00LowQq6TxrTKV7fM8JpN64GIVgZosRzLyjeJm0EKsxUBc4QQnj+QNeQa6THCwc85B5DlCGIPgzIShcnodF9qt/mTLyo3nWzoKGA0tqgbAQFVqmq9ynTrMghu4EmmGQVsezSqg93T3KD08Iqt2dAChYevmTB84PGHa7hdd3KjbAVIaAyJA9W7RsK20G2z474eqyRyXARHEFIG3uoNOpMSBqazDHL1p2IUKYRipeYyfrjcH5bnnpRHinAQHnQvqrnuhqzoWk49O8EEIOltSReAVjamDYfqut9wJx2gH1LHMfHinkkd6BvEXSjJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NS1hcGjV3Ck/E0J8TfbVSh1CTc0MhM1O+J5l+6vSLiY=;
 b=cLxe9p4NN9O2ddXqEaraFcuiaeOVRQjUSVGZtIUzvFKjh1rBp0LTMPqMK9hP8LVjd2siAOm7DsYCZF5mLgDLK2l85gRYxng8inIj5NKTY1B6muvBxPArBS1Mj9xVqwo4r1OyQ4y+tdZcxakq8jSX63Mt8pRJ/RGH0tnm0GjXJV4mEA/pnff5+MifODrLoqgLgykb0rQ3mLNZRFUFtlOV+7Y4+WQ19khrVZ/qEnT+61Hx3QJG8G9WwH9atQdpydWleiU1rrzyk9noQC3OM0IW6/F3XDaAbMB2TzUZg5DFZwQVht7Nap+OQ2kwyR5LzuUjSsJ8S8pFb1ZOH9w6d/0L3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NS1hcGjV3Ck/E0J8TfbVSh1CTc0MhM1O+J5l+6vSLiY=;
 b=Vreh/ujRC0FZ8ACVPjQlfwFumF8lJsk4j3sgkROlme1u68sx2hOMZkCHmx+lP8AcU+S/pm/qcx3Y4iryLtcVIqLx4ln/WiFdrjQ3WRYtEnkEAAW1l+IaoHEWLLE5TxMJbOi9eloq0P+rMY0YlBJRPjMkPwbiAYplfsO0UKyRdoU=
Received: from BN9PR03CA0726.namprd03.prod.outlook.com (2603:10b6:408:110::11)
 by BN9PR12MB5083.namprd12.prod.outlook.com (2603:10b6:408:134::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Tue, 1 Mar
 2022 16:34:55 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::60) by BN9PR03CA0726.outlook.office365.com
 (2603:10b6:408:110::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Tue, 1 Mar 2022 16:34:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 16:34:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 1 Mar
 2022 10:34:54 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: add a comment about ip_discovery
 firmware
Date: Tue, 1 Mar 2022 11:34:33 -0500
Message-ID: <20220301163433.1406960-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8172ba77-5bac-4f5f-a109-08d9fba16b1c
X-MS-TrafficTypeDiagnostic: BN9PR12MB5083:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5083F3E83646CF57F6392811F7029@BN9PR12MB5083.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NdSkjRfOD26MxFdHQberXzmi2DefcrBe+7Fa8lSQCaOBC2Tl7TxD3PEreOq664tQgdCXOTjeiq2exZUv2D/wjdC1whXAxezeaT7EXh8SipoJEspKAZMr2WhqI+osJIbONtqjr5mCWQoDBO77qZFRuDI+jgKqeCpsLoAulQKS7lYu4lIQzmuztzUDKYT2FIddXsLAdK3p5XjTZffuzeQBG8ykw10FWoP7dkXWeXNFHM+pxkVv09bZ4RHHqetr80ufH/68CRqDN/FfbmNmKUD8ofua0qtjD2anzd0aU/fS28GidK2TEwdae4GbQdqM9LdIzLalu1/kgY/KupHSWIvd5ESbA31J8ave/w1qcODFVyfdCtSlqBN7suYBOf8LD3WmFR05erCbGcy5SqzA5UpeCGRG7iX2mKX2mg/tA8v22VLyon/9uIZSeER7HYSH3quQw2i9MXquVj/iXCODCGn4YMsuHELha3EBOOG73DbMD9Z9eMWy459Q5bDZafrg22Jq5MnujgWop0LFXBP5TN6fyVktwVHfLaJz5QdkOI4GosUouvudLZponavMDgw0h+gEMLfH1RC9SDrwpeRA1v5Z/WTlFPlYGGXfV5sf36zYKsMdD0OJJdCxtuMa8FYton2SRD1MRPKMwi7Uejqns0uMNqy83jT1T7T+Og8i3SUDsI9VIrp18GA4p3p7xtJCmSaVX8bYdCYd3BloKJcIOoSsPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70586007)(8676002)(8936002)(5660300002)(4326008)(70206006)(40460700003)(316002)(2906002)(36756003)(6916009)(508600001)(26005)(7696005)(6666004)(426003)(1076003)(16526019)(186003)(2616005)(336012)(86362001)(82310400004)(356005)(81166007)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 16:34:55.4355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8172ba77-5bac-4f5f-a109-08d9fba16b1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5083
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The firmware is optional and only used as a fallback when
the IP discovery table is not available (e.g., during asic
bring up).  Once the chip goes into production, the
table will always be available on the part itself.

Unfortunately, there is no way to mark a firmware as
optional.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index e4fcbb385a62..31d86d083968 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -67,6 +67,13 @@
 #include "smuio_v11_0_6.h"
 #include "smuio_v13_0.h"
 
+/* This firmware is optional, but there is no way to
+ * specify a firmware file as optional.  It is only
+ * used as a fallback when the IP discovery table
+ * is not available for some reason (e.g., during
+ * bring up).  Once the product is in production
+ * the IP discovery table is shipped on the part itself.
+ */
 #define FIRMWARE_IP_DISCOVERY "amdgpu/ip_discovery.bin"
 MODULE_FIRMWARE(FIRMWARE_IP_DISCOVERY);
 
-- 
2.35.1

