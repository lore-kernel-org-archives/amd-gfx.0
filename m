Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7E6C35669
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 20:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A9C02072C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 20:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="U5X+fufs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A9C02072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C78B66F507;
	Fri, 21 Feb 2020 20:24:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BF8A6F507
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 20:24:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtZukQtYARJJOKQaZ+u6iZ5muAhkeyyIrFpabOhbTeLBs+6zidPPapVM6GeYgQrFFQyMfU2YPgsOGZIxEG5vAF4eNzmOyDzufCc7hd8fDzIDM0WPRvi+2MUqMGqyL31pDlm4UgrVenFGVcGaseBZY2vIiJwVViuIsXc+XNPYCs6kGl0ozo4lJiq2rw5JpQ4p3Y7rcvoOwyN0kO+cyfCqE4DdxdN2MytcZBv0lcX8K018QmfmbEizdUom95FZ/r5/oeckbmXRQMmKQqeJ/OvHwRCUUm5T0N7J5QcveAwnOCgSS/Lv9kXuGjDnqTPdQRlba2UtguNAJB9hMAxN+KMVfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Riexe4qJv1UPJrosFb+zunUcSKEWbUelzNvZ9yO0bQ=;
 b=cRpRv6mGbY48tdXbeqzJ0vxhZ/2cNs2szPUFdBJgVpSdH7w376gd1esejmdyuzYXoXUtU2iFEpYJj+V9PGdNf9FHuPQ78gYBrIaaOOJ+0NzL7a1QXeCbEclI1BpGOy73xZaK/TzzpGwh8glb1IU4ZhkyOBdXjdFvldfunBb+ArpcJLcyG0/mql0pSQmiboEC3VSMNDfOPtC7O4yuZRhSsGV0ZA1lNYnrdrP1QMHbRLMOLdrq3D7ye2VwGZRVnh23K0s325LfGFwkD6VmbiTc0z4lFQSNsdYFnLXwjkn+DfIsR9WrwqAoVoHofgCUyebLTL4iJsNjkhKv1urI6kuZEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Riexe4qJv1UPJrosFb+zunUcSKEWbUelzNvZ9yO0bQ=;
 b=U5X+fufst3Dopa6xUdoxNLur06kQZza1CyvDe/oMIbfazLHdT3GZEmI42vmuicnT2rd8bsU1vyLhbMy9MXXBjnP4gbhVUqhMHJIKqxeZ0KKTgyacFRbOrVLJSOUSf9G9zci9oc4WL3YuFB0u4RD/1JF/tWIkRRKLzWJJiHqLBw8=
Received: from MWHPR12CA0061.namprd12.prod.outlook.com (2603:10b6:300:103::23)
 by DM6PR12MB3546.namprd12.prod.outlook.com (2603:10b6:5:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24; Fri, 21 Feb
 2020 20:24:26 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::a2) by MWHPR12CA0061.outlook.office365.com
 (2603:10b6:300:103::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 20:24:26 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2750.18 via Frontend Transport; Fri, 21 Feb 2020 20:24:25 +0000
Received: from Rohit-Dev.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 21 Feb
 2020 14:24:23 -0600
From: Rohit Khaire <Rohit.Khaire@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] SWDEV-220585 - Navi12 L1 policy GC regs WAR #1
Date: Fri, 21 Feb 2020 15:24:10 -0500
Message-ID: <20200221202410.3876-1-Rohit.Khaire@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB01.amd.com (10.181.40.142) To SATLEXMB01.amd.com
 (10.181.40.142)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(346002)(376002)(428003)(199004)(189003)(16526019)(2906002)(86362001)(4326008)(26005)(316002)(186003)(70586007)(8936002)(81166006)(1076003)(6916009)(36756003)(70206006)(2616005)(7696005)(5660300002)(8676002)(478600001)(336012)(426003)(356004)(6666004)(81156014)(17413003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3546; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d1f1b77-aa04-40fd-3566-08d7b70c0b8f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3546:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3546A44DA62BC79D7EE0F88787120@DM6PR12MB3546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 0320B28BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cdT4B4XarbE7nMWUNUr4xUMUjiUK30T2MpwfSIF458xlWp7xQaELjFjZRHU88cIPTowP9m6AN67TZu+DZZGvI9VKyx7OW0n4cjk3GpKBFP2RRXYTnUEDsCqUmQ/frxqz/SF9CJC1AS13lRGXvPlGPGdrgc4QBp0TBaAb3w0YOA+1fhMMRhazRFzjMcV3iBcPSyVjTMcgGe4GD/u36bBA+45EOzuM1K46VOU55aOtI2k0vMljwbPeH1s3IMvLsnWiACTcg403d+A0dUeODMzrFk6XOJdPLpGcgHCKTR1LYI4P4SnR15I7ZPlPh9Q+YDvdfeEkKcyOqZU5sE6AdpQ5vBsi8q7ryvG70PwtKiT6CCWogCUlrB5iZ2+Ej5xO5OAv20svA8lpzYNLYyZghyJP637kMg8fQV8z9mHmsD+RI+dcjvwt+7nnj4TDpWqIWL2q/agxjFiVoK2wsxERiMgAN7OLda3REHTCKWB2pTofp1Com3URRbQ+uof6gjmv6HQ7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 20:24:25.6040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1f1b77-aa04-40fd-3566-08d7b70c0b8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3546
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
Cc: Rohit Khaire <Rohit.Khaire@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This change disables programming of GCVM_L2_CNTL* regs on VF.

Signed-off-by: Rohit Khaire <Rohit.Khaire@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index b70c7b483c24..e0654a216ab5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -135,6 +135,10 @@ static void gfxhub_v2_0_init_cache_regs(struct amdgpu_device *adev)
 {
 	uint32_t tmp;
 
+	/* These regs are not accessible for VF, PF will program these in SRIOV */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* Setup L2 cache */
 	tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_CNTL);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL, ENABLE_L2_CACHE, 1);
@@ -298,9 +302,11 @@ void gfxhub_v2_0_gart_disable(struct amdgpu_device *adev)
 			    ENABLE_ADVANCED_DRIVER_MODEL, 0);
 	WREG32_SOC15(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL, tmp);
 
-	/* Setup L2 cache */
-	WREG32_FIELD15(GC, 0, GCVM_L2_CNTL, ENABLE_L2_CACHE, 0);
-	WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL3, 0);
+	if (!amdgpu_sriov_vf(adev)) {
+		/* Setup L2 cache */
+		WREG32_FIELD15(GC, 0, GCVM_L2_CNTL, ENABLE_L2_CACHE, 0);
+		WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL3, 0);
+	}
 }
 
 /**
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
