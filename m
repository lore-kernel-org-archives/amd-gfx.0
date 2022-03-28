Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681BBC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 06:25:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1C5A10E5EB;
	Mon, 28 Mar 2022 06:25:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A2FD10E5EB
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 06:25:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjCzyxHJfU/uX5mhMdWho7uNaiFyavdS2jx5MCSkGViTWdIDR+p9CXBeDf/9T6ZK/u8Qv+YsFLmzyOc8MtKIUF0mjG6OBpNrSHld3NYoTExbMRB11e0FaloobJzLEvK25CMl2jBnemNLjDZuMFQJbUcAuKHyavoz5p3Tz4EHiKTtT5gHT5AtTUR/pTNLsOC5jyzevAWo8feJzhMu13tvOi9fd7jUUX/M66B4RJ9HbayOoJ4+9jtWz5/I87R//tGPvMpTFm8373he79fIkMP9eo03Cuihg3WFTENGN58eQKOtWaEEVXM4tUcu9egAHqR0TD+rfylqyCAF7hqCPZqNsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6x07uWKwdY/VQ2uWQXH/s3GusHQKLk0HWn5NXHH2p8g=;
 b=dkbfQfRnVEoP9dvA6mPXZUniNNnujROw428US2XV6D3OyA5q37SFCH6UcTcMyCVg7TT8s9sh5kmkFYidKwZaqTHeSw9mDMfFQHnVwRrdd7mnAqCqx8qdFG+LgjdWpPGj8jCNGhD1pvq98F1KwmogYPJtOcw7FWdE232/7shmncPD6TEd7NX/z5RPLWKTDwq/maS1dkATZQz4/yhwrvpoWyveHKzyqVXv67H9PVIgaP4LktQbINloz8jClbBULpSUYWcU4kDTZgvJVGsujMEEBnmTpq6gus4zKyisdI1W/dec9X4Bi1/4bBL3mUAtPajqNIzhQ8lHstvG964fLnrgjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6x07uWKwdY/VQ2uWQXH/s3GusHQKLk0HWn5NXHH2p8g=;
 b=fE9gOIE5fs5baziQzgdEBVy6ckRRHh8ZfbH+AHCOh1Y59AulyJA+hsVhRiLNeFwaW0h6bi58BvHc44uxEWnDhL2oE5gD88222BiiKvDj+sPOAMzx7S1Bu33zhzzffgQQd0fhHW/EN6ZLGuQO1nSCDx40UpqnWdywFUPADL/b+/k=
Received: from DM5PR21CA0042.namprd21.prod.outlook.com (2603:10b6:3:ed::28) by
 DM6PR12MB3386.namprd12.prod.outlook.com (2603:10b6:5:115::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.19; Mon, 28 Mar 2022 06:25:16 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::17) by DM5PR21CA0042.outlook.office365.com
 (2603:10b6:3:ed::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16 via Frontend
 Transport; Mon, 28 Mar 2022 06:25:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 06:25:15 +0000
Received: from zafar-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 01:25:11 -0500
From: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 1/6] drm/amdgpu: Add vcn and jpeg ras support flag
Date: Mon, 28 Mar 2022 14:24:48 +0800
Message-ID: <20220328062453.4156191-2-Mohammadzafar.ziya@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220328062453.4156191-1-Mohammadzafar.ziya@amd.com>
References: <20220328062453.4156191-1-Mohammadzafar.ziya@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d785a1a6-2fcb-43ad-2f14-08da1083b915
X-MS-TrafficTypeDiagnostic: DM6PR12MB3386:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB33868B5F0F78CEC4111D4ABD981D9@DM6PR12MB3386.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jdkGq+X0gSG+kna0QDu1vOVWWUR5COicEci0lawdD6RG/s4Gdieoh80FaKXeSCICagi2bpCehJYsE97tmfTH4AaeCFjKzu68usVVAWD7LePOjqBGJMA+bsGqCaf4AkV87jvDmXGbJ4ejege7oSb+Hp2H61ntK5eGJveHG8iOg6ugtM4FEmv1OydTeWAIjstHw43AR5S1n7lV/wtXUZkpMSKWYCnbboZ7TVHmV9StG8hGk1j8koxoe2VTGJgQpKbHe/QsVgVYnws4VrphuqZEbcQIsGmHjIL6RC1xhvCLibP+YIiiL9QbFxAByemCEJbLAgAYjQofArNNmfXAIry9xq/SPmGQuNTO1nLHHwQABWkiq2GyUB9bfpgv3KMIjM3guxXNIFNAmZ8osFKI1ceAYpU00/jOHhfeHbVC3AHY0myJIYD/m1jLNd99N9lNRbwheYEHEw96DBOmrq/KGtyQ30PabpGZSjlEY28EvpRCyDvHr5qIVGzAUwi5DGWXPPHdcwMJ17oR3Iv17Lq2iu5rYu1HW37DdqviBPI4QXZ3PWGfKKYRcZsua/koU0ZlCTZ0RBUV8kRkQRqMTYmSRYYOjFY+8+G5gxZk0U+wejJddTiU2RbJsox6m8qHp5m/K/ind0blG68WVTJqmcplyvSqXoyUOCRWdjANjEgk3GuIumT+U1EM4v/2gf5VI8homwkQn/43ItTgDfhCW4kOfdxxpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(356005)(81166007)(83380400001)(186003)(47076005)(36860700001)(26005)(86362001)(336012)(426003)(8936002)(16526019)(1076003)(2906002)(36756003)(5660300002)(4326008)(54906003)(8676002)(2616005)(70206006)(40460700003)(6666004)(7696005)(82310400004)(6916009)(316002)(70586007)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 06:25:15.7186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d785a1a6-2fcb-43ad-2f14-08da1083b915
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3386
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
Cc: Tao.Zhou1@amd.com, lijo.lazar@amd.com,
 Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add vcn and jpeg ras support options

V2: vcn and jpeg ras flag enabled for aldebaran asic only

V3: vcn and jpeg ras flag disabled for error counter query
Generic poison query interface added
VCN and JPEG ras enabled based on IP version check

V4: vcn and jpeg ras flag moved under ecc flag for dGPU

Signed-off-by: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index f9104f99eb9c..4bbed76b79c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -66,6 +66,8 @@ const char *ras_block_string[] = {
 	"mp1",
 	"fuse",
 	"mca",
+	"vcn",
+	"jpeg",
 };
 
 const char *ras_mca_block_string[] = {
@@ -2205,6 +2207,13 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 			dev_info(adev->dev, "SRAM ECC is active.\n");
 			adev->ras_hw_enabled |= ~(1 << AMDGPU_RAS_BLOCK__UMC |
 						    1 << AMDGPU_RAS_BLOCK__DF);
+
+			if (adev->ip_versions[VCN_HWIP][0] == IP_VERSION(2, 6, 0))
+				adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__VCN |
+						1 << AMDGPU_RAS_BLOCK__JPEG);
+			else
+				adev->ras_hw_enabled &= ~(1 << AMDGPU_RAS_BLOCK__VCN |
+						1 << AMDGPU_RAS_BLOCK__JPEG);
 		} else {
 			dev_info(adev->dev, "SRAM ECC is not presented.\n");
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 9314fde81e68..1e1a3b736859 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -49,6 +49,8 @@ enum amdgpu_ras_block {
 	AMDGPU_RAS_BLOCK__MP1,
 	AMDGPU_RAS_BLOCK__FUSE,
 	AMDGPU_RAS_BLOCK__MCA,
+	AMDGPU_RAS_BLOCK__VCN,
+	AMDGPU_RAS_BLOCK__JPEG,
 
 	AMDGPU_RAS_BLOCK__LAST
 };
-- 
2.25.1

