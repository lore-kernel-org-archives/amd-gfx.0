Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507FCC4167B
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Nov 2023 11:26:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBEC310E34B;
	Tue, 28 Nov 2023 11:26:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0A3210E34B
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Nov 2023 11:26:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMbCovgKYpmkuPnlpGcLMJ0QmGy/zlN4GxejamYyzbkwq6A3dx1KGVMit4xKlYo7bImJGA/9VjziFfm59Mlk2KBjVpFSauIFzyLqetPaQdACbuy/daeXVj3OwC1pAhVhnTsPvtnr72HUOWONNksVNKpYmiz6WMGgLFvXZa8DzcxSHoNnLSG1BZy+U5igp/EVmdX4rklT36wmLNsxHAdIYtDdj3g3G2IBxJ0DDosOiNSqVGStXvMeHQobRS7h2dKokdCq6i1TkIzbwx4ndrV13R5Y+sHQ109LiED7Oyr4eXqdf4y5hQeXueYK9rXTeEdYwdxbkvTf9FGgyAp8hv1/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KPUseGZVZ3B7zCPanfSZX25qckTeWYeWf0KNO6anyk=;
 b=JQnwvvaqtzACtb3YpXZY9iFj+Qma8YXPg0FxcoCrJHEA9RxlvK7VxxPPi6uu4L+/kDSAI9AzEEdPUFWkZZ8wr6N3k+27oGP/ZPksM8CWhudMTAIigES315X3+532IK4IfL5HAQu8qh4KwbsBfNykEF7RVWtTg6QO/aNtigjGPTi7IN3pXrEnG0XHN9kSZCa7lBZyYGK9Ej9GqXkMKJyNTB7xr/2vZxjpocyCDpb4W4sZ9Rwh+NWC8h4GaB9HpKlS7GJF64E+BtBMrWXORq0lqfKJrL1ic9lRS/I+ZT9lwCqE0EJ6iyEcXrpu8/tvBKdB6s9OIHp+A4vFkpEd0ljhIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KPUseGZVZ3B7zCPanfSZX25qckTeWYeWf0KNO6anyk=;
 b=LWy9NFwAH48DUqhqu7aDsI2XBaiVriZjHcDWHzcc3po2IgzLV4RzAkuNpGARmbSFXMY8vztq9WYptxvskylz8i6/VuyAmax0rUeOs9LOQ4xqxyP8K+vBc88Tq73zny4tb480JsEiZEC9CDWkAYBPRDJIuwtK21++9K6psSy2J8w=
Received: from BL1PR13CA0270.namprd13.prod.outlook.com (2603:10b6:208:2ba::35)
 by SJ2PR12MB7868.namprd12.prod.outlook.com (2603:10b6:a03:4cd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 11:26:13 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:2ba:cafe::47) by BL1PR13CA0270.outlook.office365.com
 (2603:10b6:208:2ba::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19 via Frontend
 Transport; Tue, 28 Nov 2023 11:26:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.21 via Frontend Transport; Tue, 28 Nov 2023 11:26:12 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 28 Nov
 2023 05:25:51 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Use another offset for GC 9.4.3 remap
Date: Tue, 28 Nov 2023 16:55:36 +0530
Message-ID: <20231128112536.1129777-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|SJ2PR12MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 9341ac1a-5bb7-40ca-4c9c-08dbf004d3b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bjhs4odQ6FAtI/P4rGuJBB80l+ML8Zzr2/Y0dFgApaFaVGtoHPANn+t33VEM8wDw+GDaYRSDrvp1pDT0S51hHcxlaMEyqiVZdZiMjGMXqnlOFiE88UnsLhWLgILZeSATQ8FIvrhZJlVtefy7eD4b65ZEsUrn2AFEU7z+CuimT+WnaNnPvmEAVBjHHVsWGYM5UYV7JV5kjQfh85KJAG9WhWYComXUfM3Oe1dJhe1uEHlMVurIHINwrs0a2G/Lo4coVlig5emuneSBXKZbpt8nv3c8HRxURScG08cNM5uYx2eH1ClArqmEl7rWBJG9ZpUHEV43PgqFTUlXROUE7wnpTMrHhw2PAmsOSeovZjB19sFKuTEnKfx5MQskFA+La7or/O7vlDpBsOgEcVeueEmXYqvV4filuqyGPnpjFLt0XJSJBxhOm0mIg7CreNIuJGWHH4wyR3AYs+sG6iOooi+qLWfD2iXzog2t2AMxN1T8TTtb89+cjj0Ri9zE+/7dvPI5qdipX4lwP7548CNQFvnoBu42GYwpW3kqEWJEvOBhULl+Fzb3edS0RO2JB7dwnrCRZFjbuUGNdedOST9AqVEA2mNuYJZ1S6kuYbEqLvC1ujbZYa5biRE8NQb6kSNF5WV3Qc1j4UTol6Z4BQWlCH9DB9gJ8N8we87+uR71OXfbZL/mMOU++An5QsTF4z4Y0qOKgEsUuFCCFFdtkxjMhAVUbnyx7ykgixvCZQ65whVsJ9sjle/wmN2Cv0zGloClzDgIYsW4AX3i0oLq8Gv+yhQR3ifRJwleOpvLXsMTBgBFAf27DELkzjTv1ghXYuPjCZ3q61d+DMZzHfeddLGVJ+a6wjW7FzJM8Hkihna99Kxu0qA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(46966006)(36840700001)(40470700004)(86362001)(82740400003)(356005)(81166007)(40460700003)(36756003)(478600001)(316002)(6916009)(70586007)(26005)(5660300002)(16526019)(1076003)(54906003)(70206006)(426003)(6666004)(7696005)(2616005)(336012)(44832011)(4326008)(4744005)(2906002)(41300700001)(8676002)(8936002)(36860700001)(40480700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 11:26:12.4866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9341ac1a-5bb7-40ca-4c9c-08dbf004d3b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7868
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, Felix.Kuehling@amd.com,
 Mangesh.Gadre@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The legacy region at 0x7F000 maps to valid registers in GC 9.4.3 SOCs.
Use 0x1A000 offset instead as MMIO register remap region.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index e3d41e8aac9d..9ad4d6d3122b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1162,6 +1162,11 @@ static int soc15_common_early_init(void *handle)
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0x46;
+		/* GC 9.4.3 uses MMIO register region hole at a different offset */
+		if (!amdgpu_sriov_vf(adev)) {
+			adev->rmmio_remap.reg_offset = 0x1A000;
+			adev->rmmio_remap.bus_addr = adev->rmmio_base + 0x1A000;
+		}
 		break;
 	default:
 		/* FIXME: not supported yet */
-- 
2.25.1

