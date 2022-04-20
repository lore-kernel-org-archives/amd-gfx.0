Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C285C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 02:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8251810F1D4;
	Wed, 20 Apr 2022 02:32:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5135210F1D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 02:32:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7yO65VnmWoz+oL/guXcmwvozFl3VXl64ZM48rZGdoUAFjinf49cZgBZ6LsHXN+07Dv8pe9gTnkvXAiGpR63aX6jaUr4eAmrYZhVAsxDnrsSzw4oVfS8F5fl1Gr8MM+sxsI4Ipr0zdX7kkWY2Hth4wC2yry34zvZXHPHp6sQW3DIWR1dFguuZojS+Y2LlDrXC/hg3f6RCf+qYPUUkvdvFr0yrZzH63aN1hVwK+C++3LLW08z0AvBUouVsdV9ftgIxO/GwHsrppD/gturSAy1mf/3XnTVXThfoLqnMu17S7XlN88p/DXPFDgSIjUI21INiE8OcKsXI25PSCcQRbRRLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKxcZzsc3sfeRF7C7aIUvd+qI5RS7YgC1ItLX5Vk434=;
 b=YRu9QgHBClZfsAltUxKwxHuQmN4fVoQaCdao6HvWhGx/QWFbO6mN5y1JTCwKqNH/XAj0Rco4U/2z7iKGl3+YmkmU3iF/z4chb8vLf6ulG+WERGEM5/f5Z1QAZAoZk/yYtzTN5GD58wV0w0QMvkH/SkPFiCTIiZfV1TtGc+Wgkp1QgW+e///rQjSt3f9F5W5hb3eZoL1j/tUW8fjm+YLi+YuEjIdEqtR0chkJvZsH2+J64+34m2McCCiDhGGsGdRTRG4wtGRqJfrp8jB5F0EFjgGvE9RebPf8vEIVePE0GE9PXwMUchGkt6KLSZ9LiW4tYXxaaQGGhehzKrWoiJa2rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKxcZzsc3sfeRF7C7aIUvd+qI5RS7YgC1ItLX5Vk434=;
 b=M1szvBQvAnalgl/1EwU3e9JGRqN+4jIuytbzuVZkEPH664LISR/+vW087Ld73ajEM/a+awYtgI2R0tqKe2Tprp1ugBE+KAE1TWwFVjjuhAkZUmHRxqymfRiqwyTfNLJ1PpAlm38SacJJ3VkTnNzB+AvVz/z7ykYS0KsaiQmm5UE=
Received: from BN0PR02CA0031.namprd02.prod.outlook.com (2603:10b6:408:e5::6)
 by DM6PR12MB2858.namprd12.prod.outlook.com (2603:10b6:5:182::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 02:32:29 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::c3) by BN0PR02CA0031.outlook.office365.com
 (2603:10b6:408:e5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Wed, 20 Apr 2022 02:32:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Wed, 20 Apr 2022 02:32:29 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Apr
 2022 21:32:27 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amdkfd: only allow heavy-weight TLB flush on some
 ASICs for SVM too"
Date: Wed, 20 Apr 2022 10:32:07 +0800
Message-ID: <20220420023207.1293007-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a625af53-b9df-4db0-a016-08da227603d2
X-MS-TrafficTypeDiagnostic: DM6PR12MB2858:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2858B8C1A780DE8059B6B6D2FBF59@DM6PR12MB2858.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wmfvDD44rxvNzW7yZViiPBcMtvV8uN6jw7+nvRofKTR5kjVKqhFkmNbWWMXp6/G70q76yDL6J4UsY6MhghJUl4UfPtEjQPHC0L5gfGGIgKuAbAU1ftKzjOTE08lgO45w6F4dU803P8Tjcy7a4CnKkEvrTkdeiy3JAyika/d+JT284GNHiLSd13oPTre2kOPwtJnam7j0DIERwFmJN3UhQN2sTZQ3fisAGUgcyTB++inauF8hxK/C+8fwxUoveOtMz7aMzX5ug0Xjc649j/NYGtCUzXH/bSEw4buulYJZibOtA+XAFeqO0Tg8BUjRIx4daikor9gbtAV0+cl4ADLU0bwYki1yhlYit1bT8vwwTxwVZGhIHnllnb2eaGLq5UkBE6fwCc6ojqbAjjr/y785/fpfe0gudnwLuotVZTOMkRY+cGEqTLmB5e9JDwnL0OAO+wgGV+m8IYhf2YWJLYIOgUprIchlnx38SyxvHVH4IHMhNa61QcS6hIjGR0ViPh0qZmrClU55CAvaFFXQv6J/u8BzUXdtNUQkwT1MdaHFJD8YzD5KFs6JWWTDdBZrmdpBIO4wueya9V8AN01q3u3w7mnXMaIVwt3UU97GjkX0AiuzaPJ+jtCQHU/F8gD1ssYhyKdtQoUtOPV3ixkeihEpYuWo81X4cHYrvnY6RD8DV9UQb0do1uGriwTrmDhqQGNVuTLdXf6AMzp8EKLTFPOEpYNwEPQv27Dz0TQEKm7sxAeKU1PvJis7V8ADaO/eCVBH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(316002)(36860700001)(70206006)(6666004)(2616005)(8676002)(4326008)(8936002)(40460700003)(5660300002)(4744005)(356005)(7696005)(70586007)(82310400005)(1076003)(26005)(426003)(81166007)(86362001)(508600001)(16526019)(54906003)(47076005)(2906002)(6916009)(336012)(186003)(36756003)(83380400001)(16393002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 02:32:29.1498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a625af53-b9df-4db0-a016-08da227603d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2858
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit a129dbca92edaeb5a515a0e5b63ada71cf9b981a.

It causes SVM regressions on Vega10 with XNACK-ON. Just revert it
at the moment.

./kfdtest --gtest_filter=KFDSVMRangeTest.MigratePolicyTest

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 5afe216cf099..459fa07a3bcc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1229,9 +1229,7 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 			if (r)
 				break;
 		}
-
-		if (kfd_flush_tlb_after_unmap(pdd->dev))
-			kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
+		kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
 	}
 
 	return r;
-- 
2.25.1

