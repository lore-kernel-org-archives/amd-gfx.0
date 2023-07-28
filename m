Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D911C001E0
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 19:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B285010E77B;
	Fri, 28 Jul 2023 19:16:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A09510E77D
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 19:16:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SC9ZYrspPSfmJD7kS15w50KZN+mazDGFvXnp8hAScgjt4kte5GBnmznM4pWDRbcu9m6rXZhxpbBLMZcJ2JU/N9RGLfMHt4nI/12zBvnXBMekFOv5NqMXZNgfE1MkN/O8KW95W4S1lBt2T26PzQhDoN1l2oFDdep7KGsbFcQgHFhQnF1tQw7vmN1mQx4cc6o0YDnRf+OiuYjV2nW+uUc1Y7e8Xjcd4ulLXOsqiLMPx5RUDZ8Wg5SxaiX8Ykn49YXI8w9U/55ud1yozaShYI9AOVcU2juqM/Isu2WlugI0n5E575sH1ZiAmIF7VGdNQLpqfxCJG8LovEuG55ooyivLrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/Ddp1HlTkKZkowOcL7Rr4sVkSZ9JEy+zWtNxO81KUM=;
 b=diLoKvL8j+YFjt0TrVlwrtbgTME9y2X9soEjmgUkUNgVsPbiy1mBubefHZBkDrb3OFaG5YGY2Q+m6U36gjD4ORfvZbLR55jhJg9K3f+m3AMJhrr5tpbc6qJy3cHDSnGNmsGYvRAqbdpcTBMio1O0ng2ab7if7oPIvJpG1iOAvJfSs43gOsEehpx7ZRfPD5y1R1vduaz0AcacwjtpOO5wjAv1vMi+/lcEJa4jQt1QTVXcCJ8x4XCPHVTOePyF6x/1Vx4h868VQuHUth2mPEVGlKfa85jAm3EduPonj7CvabjiyROe+PVwYAO+OCL30hQzS3JuCz/aX4ktP/GyCOvLVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/Ddp1HlTkKZkowOcL7Rr4sVkSZ9JEy+zWtNxO81KUM=;
 b=C6Uye9FHvDDvr4Sv6lUjCLcmaus+wjHAfP8vV8sYNQleXiVIFSe5K8bWXK9moLAP7u4wk0JXv3TMgCI8hoa4fFpqaMauhugx3M6DG0j+XIPsfEdTDlh/dKq2VMNlW3xBR4Q00NU2B1Ye927mYWC7249k59L3T8V5at9BSVGxBd0=
Received: from DM6PR06CA0100.namprd06.prod.outlook.com (2603:10b6:5:336::33)
 by SJ1PR12MB6218.namprd12.prod.outlook.com (2603:10b6:a03:457::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 19:16:12 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::8a) by DM6PR06CA0100.outlook.office365.com
 (2603:10b6:5:336::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 19:16:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 19:16:12 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 14:16:10 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 4/7] drm/amdgpu/vcn: mmsch_v3_0_4 requires doorbell on 32
 byte boundary
Date: Fri, 28 Jul 2023 15:15:38 -0400
Message-ID: <20230728191541.1778424-4-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728191541.1778424-1-samir.dhume@amd.com>
References: <20230728191541.1778424-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT037:EE_|SJ1PR12MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: 66837966-5f18-4bec-8d47-08db8f9f1b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ISNajWs15hLB6cOnJIMsHh4B4VSj1SD5T9xPLAxP1bQkF+AnOLlqEaTtAkQhuTTJvOr3YoJRq54RIFsvo4KNg7T+q30UhZxXfQe4g7Gn3F+daZoi0asc44SuJGnsoQNMfrdKsQ9VsIzj26oAlwUYGAZ5H6b3V2bnd9RSAQBoGm7PQ64Y4RMWBIe8ohgLFM+fOKSvFu4Vwxh4BEzdTMHLmFCf96Z38F11zVBgNVWHTyX88i4mAxWVIX87OblxDuGaANgR2uCLq9qfPHjmw4m24mhrAhRbPkOuS0fqupnE6AiMRLu2MFYG2GyEn9C9gyDRadO4hDsU/67F5NUpnk97QdH82ficWAugVVzpHNI5w0eckgbUitFN2+ZyPueZOWfffMW4tY++RAuNSSPwR3zsRbizaZf+Axzv+vFnQyrc0iDb1oL1JVbhLTImUhcSqA3YPjMWNN0hhmwTOtsBDvZwNTtGp5K2R7l7DTbRemYdeUV5Y7qC5BPwCKFNQwD6OLG9On0fhKknieygL/eg7mthk283RkJ2Keqg3GbFQK1AFJkdgCZIwViMH3x+ZtjIh3JDpi2ZvPuyXeGg/EtIx4jLEp2Q7pI3B2jUc1yzgUsqN0mL9pNkNRkQE6dTaeG/6Uf23BwhiLg7B6pd9SPa4rotjN2gC2fGSBoG2X3iC3FVc7PLUo9gHHhsPu4+lsbF5inb/RgO1tNKAVZSxjg04/PwWw51OibemcBLxDr+lPNinECwd+fIRHkd4KPw8SWqtTQ6ywEy1D0PkEuoESSkv3vz9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(7696005)(6666004)(82740400003)(478600001)(356005)(83380400001)(47076005)(26005)(1076003)(6916009)(70206006)(70586007)(81166007)(54906003)(336012)(186003)(426003)(16526019)(36860700001)(4326008)(2616005)(5660300002)(86362001)(40460700003)(44832011)(41300700001)(316002)(2906002)(8676002)(8936002)(40480700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 19:16:12.0097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66837966-5f18-4bec-8d47-08db8f9f1b22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6218
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
Cc: zhigang.luo@amd.com, guchun.chen@amd.com, gavin.wan@amd.com,
 lijo.lazar@amd.com, Samir Dhume <samir.dhume@amd.com>, frank.min@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index b978265b2d77..7cd5ca204317 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -113,9 +113,16 @@ static int vcn_v4_0_3_sw_init(void *handle)
 
 		ring = &adev->vcn.inst[i].ring_enc[0];
 		ring->use_doorbell = true;
-		ring->doorbell_index =
-			(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-			9 * vcn_inst;
+
+		if (!amdgpu_sriov_vf(adev))
+			ring->doorbell_index =
+				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+				9 * vcn_inst;
+		else
+			ring->doorbell_index =
+				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+				32 * vcn_inst;
+
 		ring->vm_hub = AMDGPU_MMHUB0(adev->vcn.inst[i].aid_id);
 		sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[i].aid_id);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
-- 
2.34.1

