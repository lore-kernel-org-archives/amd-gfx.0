Return-Path: <SRS0=y248=KD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F96C433ED
	for <amd-gfx@archiver.kernel.org>; Sat,  8 May 2021 11:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC137610CB
	for <amd-gfx@archiver.kernel.org>; Sat,  8 May 2021 11:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC137610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AF306E87A;
	Sat,  8 May 2021 11:52:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 813EA6E87A
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 May 2021 11:52:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wm41FFPqjay3roLN5g0QFnT4F5vm58sTV8raTm9QRmixp5Q0G/KIiU3FaGH1/vZCFP2BB4WWgHqDj5Oi4R+udwSSV3tftkACMr/KaHPPXp6ZAKgR4tqzPImdn/bRFQOLhtYWdIBiUzF0KJOItVSOLkkPnaWKjvnFftpXGcssg+h3FKLK7Duqa6zRmpRwIZXctdsKmugXyahjfzCBCv3DVt8ilsSa/DxWkh3m1b5oMAqUd64jqsXLdgn/AkCq3F7lMoDL3gqsE4PPLGRyaNmUIyxeQkA6SGK2FAI3B+6xIrANu3SvCQDMF/gjQ/ITpe04c0EYeeFsXPdN3ykdBmYCxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqzabFWpPoE78fzOCtp4OYIL1YGBWzSREPsXPAl6Vws=;
 b=JteGjDfjhK2g1fzpCtIBhoKmWWsIAtw4/mi3FGCNxmNwsSqD2vW/feFV2cW8pepogwF0WFB0hwKW30+9lzDysnNh4lRxUN2BHTd3vWrBFZXVqQFRhO3yRctUNeU4nQWVD5O6V9ACnk1a2OYgAMRcafXng1MU18WFPtma1MafSaEUIa3dAzUEMBHGO3zahr9XXr7mYZ+rG0rhg6n92xtINA5og5cURby5VvYaRoarQpPk/Pm/FCcVRfy88OG4FYrQnaiO0X0PSMxekE0y8PLbjFS/cRBpmCBiK60/LZiHDa7KCDJc+XQMJlGr/pO+lTz8l3rXgp3SGQZPJ9F2tVz/GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqzabFWpPoE78fzOCtp4OYIL1YGBWzSREPsXPAl6Vws=;
 b=apSuJoz7QkzYi7Dm8wbnz2RLBp5OJtLf4T7pa87YR1OFx2g2Vgyz1lvrXak6bGSQ5hIspzVGA/WcypUlvcY1KFjyfcd4Xa9it1BFNPkX3X7WDxVDTRVtVbtjjFY4fnHlvFOF2wMN1Na26KpuEiDMhSPgwUutIwtFm79xC/vxAvM=
Received: from BN9PR03CA0119.namprd03.prod.outlook.com (2603:10b6:408:fd::34)
 by BY5PR12MB3668.namprd12.prod.outlook.com (2603:10b6:a03:194::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Sat, 8 May
 2021 11:51:58 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::38) by BN9PR03CA0119.outlook.office365.com
 (2603:10b6:408:fd::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Sat, 8 May 2021 11:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4108.25 via Frontend Transport; Sat, 8 May 2021 11:51:57 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sat, 8 May 2021
 06:51:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sat, 8 May 2021
 04:51:57 -0700
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Sat, 8 May 2021 06:51:56 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 04/13] drm/amdgpu: Modify GC register access from MMIO to
 RLCG in file soc15.c
Date: Sat, 8 May 2021 19:51:36 +0800
Message-ID: <20210508115145.758-4-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210508115145.758-1-PengJu.Zhou@amd.com>
References: <20210508115145.758-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47a926ce-e965-45bd-3913-08d91217aed7
X-MS-TrafficTypeDiagnostic: BY5PR12MB3668:
X-Microsoft-Antispam-PRVS: <BY5PR12MB36687E6C2AA29A868C2A9414F8569@BY5PR12MB3668.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AgZIqSBAzPp+ZgsnxgXMmE0L/QlEXEVN2M5t0NAp9iDxCFMu4FYHZ+HeUk5yTEr27+YuLf/4liT8SVoySdd9hNflrwK8DvVr6x81IRUYJrfXXcT2gphpkIQA5lTuKrwNCaDbBNkjsJyoUz5SbpQbyjbQRyYXwNczNAyocWwCA4mvoOoGylcmRUkDwesmWnHRWTA6PhwPo1RF0KP/jm2kdfhRJbwHmRuubG1rkxVBcPjI5vv/YfZK7erzcMzB7aKTIT3d1/UQ30BSRFMBMlgx7dZMxiRYs12QZM+POBSr6V/eRgkG4EDcZYlG1EmXOo10cAwwecYeha2PuhLtwJi3/q0x2SVH/O0JPVCT13rspgEyIIp/3tyM4IfbL8cgELvM3PqHuBT/rf4aiXrfDdmjDGtNBcRL33ufICltj+LSPgNc44Sa7EXn1G4yLZMspbXsLFZnMshG47lvNg1fuyq42DHxdlkCPAPlSXxQ3pnMNHcOg9wYcun5QHqktt7L4cmMBxH1sBeXlH7RdENE/k+xNxhWli4qjbdzsirQ6b6BS2UBprYGUkHAdsoCGzK5m1VXKRZRrNrXYsV9/CbAFRAFExWdcWYjWF1uHaA7Tzfv2j45k9vq2u2VuEgsSs4zIZpGF8NL4oYaEHBp8SiCc/L4UzEmTa+mCrZyyVqlGR0Y/zLAt8HPSMB2nE68SO2RJvkN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(346002)(39850400004)(36840700001)(46966006)(4326008)(5660300002)(2906002)(47076005)(1076003)(6666004)(6916009)(316002)(82310400003)(86362001)(70586007)(478600001)(36756003)(26005)(186003)(82740400003)(8936002)(70206006)(8676002)(336012)(426003)(356005)(81166007)(83380400001)(7696005)(2616005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2021 11:51:57.6084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a926ce-e965-45bd-3913-08d91217aed7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3668
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In SRIOV environment, KMD should access GC registers
with RLCG if GC indirect access flag enabled.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 28e9f6b726a6..e1c5dfd1d771 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -632,7 +632,9 @@ void soc15_program_register_sequence(struct amdgpu_device *adev,
 		if (entry->and_mask == 0xffffffff) {
 			tmp = entry->or_mask;
 		} else {
-			tmp = RREG32(reg);
+			tmp = (entry->hwip == GC_HWIP) ?
+				RREG32_SOC15_IP(GC, reg) : RREG32(reg);
+
 			tmp &= ~(entry->and_mask);
 			tmp |= (entry->or_mask & entry->and_mask);
 		}
@@ -643,7 +645,8 @@ void soc15_program_register_sequence(struct amdgpu_device *adev,
 			reg == SOC15_REG_OFFSET(GC, 0, mmSH_MEM_CONFIG))
 			WREG32_RLC(reg, tmp);
 		else
-			WREG32(reg, tmp);
+			(entry->hwip == GC_HWIP) ?
+				WREG32_SOC15_IP(GC, reg, tmp) : WREG32(reg, tmp);
 
 	}
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
