Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E840AC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 03:40:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A226D60F5A
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 03:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A226D60F5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21B776F5CF;
	Thu,  4 Nov 2021 03:40:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23F766F5CF
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 03:40:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ko01davBiGrrHR072Aqk7yxENWIlFb6RWx0KAvUqnkhDA+qtHw9gzs2/Q8tdsvGLQlinR116NJNPWHgui99gWad7JUAawizHvKc3Ttu+ClRYjaFdrMXmu0+1ajKFrwF6H2qgFpVK6OT8DRDtTP7e5WqOMsHyI/A3uY/ojDUL0aokZI9gN1pGNb8YmYE1odSSknkp6CSAlSEfP10AfKSnNYPuflXySi7UCP01xdKXRvlCqdcDr8KCCO+1jZS+AqaszOd/w/9DOptcT35tS5iUKsy/FsyItT/jV0Aa+tq4DXkE8zYO2wWVur7Fl30qee+Oy2s9qnGlK0d0vDFhJ0WnQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yew4Rjj/L14DrV5iT5JE+FHQBNdGyTG9e1KP+1AH5mI=;
 b=bRCQe2Yl4YJ2B+hoSNTIVWRiEBLD1WR+xYF48X5+B6cNCQ9J5orJNi4Ovdai4PmDhRsgUkaHlVD0OK5ESIjXJX92tAa/s/kD/Kq+/wL+zsgXBedwPDuiVuCkZ8efJLVws79q9ePUscQfrpmq0nxQ5ehEQ5m59V0bWdzQeSx6dDjJneb1Om4V/4qklb8d8ZMNHqvq4AlWqE76Yyro/xZFhyWZkzqRmHfOFDb9kJmpttt0dFWUISDGgs7FKpqA0QJKWr9JmkrY6oZvvwh4x3IpeHTxBdkGqKf/9WMUPg2OazaDazAhMLDqjZZqz+SC/mnKi/bazPOStH4GSk9UWR6Kdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yew4Rjj/L14DrV5iT5JE+FHQBNdGyTG9e1KP+1AH5mI=;
 b=tvWw6LQg6SckNqSZ7pO18veB2VMNLsOih/L3nESyB/tebD3Og+ADOECFnQXlmaipGm7r24+bNQQlfPzIiNtP0l17j/JELtR1kX3qPp4+y4H1oTEl1cr1J5ChL7H0nH9YpFdalWuQLxLYpo496CWgGlqTXS/s+o+mFQRR19f+5nI=
Received: from DM6PR11CA0009.namprd11.prod.outlook.com (2603:10b6:5:190::22)
 by DM8PR12MB5464.namprd12.prod.outlook.com (2603:10b6:8:3d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Thu, 4 Nov
 2021 03:40:43 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::24) by DM6PR11CA0009.outlook.office365.com
 (2603:10b6:5:190::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Thu, 4 Nov 2021 03:40:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 03:40:43 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 3 Nov
 2021 22:40:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 3 Nov
 2021 22:40:42 -0500
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15
 via Frontend Transport; Wed, 3 Nov 2021 22:40:39 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/amdgpu: Avoid writing GMC registers under sriov in
 gmc9
Date: Thu, 4 Nov 2021 11:39:46 +0800
Message-ID: <20211104033944.541532-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43afac3b-a037-4919-b0d3-08d99f44e14e
X-MS-TrafficTypeDiagnostic: DM8PR12MB5464:
X-Microsoft-Antispam-PRVS: <DM8PR12MB54640F1CEE599957773221C6E58D9@DM8PR12MB5464.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:469;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fwp9wcSXla0p1c8fI85VK0vC2dXiOUfpelyT7WuguxPkqt8dyx74tljhu1O0qICs6hvdPLWZZmDeJPiNljUOdFWjb+9u0zQrxd6gAwZy8xhfhqAO7WNd1ipP2MYdIGiF76WqS6N0C8dIe1TtwOemKTuNPt/Mgn2GpNMxKmZ+7dzy6Wya2Xh6cDdR2GYhu+zT4eWkeAlMxcFNK/azpAb29UEts+DHM3qobq/SjGWP+HYJuIvFMkD4y7sDJoS8PAZ1b5x6QaQXV7OMyfeWT9/w6X8yjqRiRgnhK+PZcYpbqLptE5JcjQSSqRNFFTAUjSPfAQMEGQ80kbRTQcRYUKUpB/txsXOcJqbx6bospD6K5Ri3LEdG8cSuMfosZKJOEtG9T3ZS2ck7LCLwS3iE6UDqXiXJONAyrzHyJM0XwYQhTx0UDUdyP0ODT4X8YxOnJDM6JSSb4KdNDhp0ueS6t0cVgI5oUgltSpsWO8aXmhciedWXXNga5jLsJFzl62ZLUH9OsSQAgu8hG3ht3T/rti2Xa+Kht6AQYg9bGkln9uAgpc/vVkF1LL2syRC6+nzJrWGoqq4G7Qg+G4Wc+n0pRgh0T0DJQBNGFj3riSy7Dg/OhhdQu1czozUpP4qAWjoXJtYTPLxvi9pT0emsVYpS/Y7b5BU7jDuRN9iIVv9lnur16ClcpqPvq7LkSHbwO05oddMisXVmtAXY/rfRwQUlH5JpwqpLcmGLYDrwJbDSBKa18Os=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6666004)(508600001)(70586007)(8676002)(336012)(70206006)(8936002)(426003)(6916009)(26005)(7696005)(1076003)(83380400001)(82310400003)(4326008)(47076005)(2616005)(2906002)(356005)(36860700001)(186003)(316002)(81166007)(36756003)(86362001)(5660300002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 03:40:43.5519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43afac3b-a037-4919-b0d3-08d99f44e14e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5464
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
Cc: YuBiao Wang <YuBiao.Wang@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Jingwen Chen <Jingwen.Chen2@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
For Vega10, disabling gart of gfxhub could mess up KIQ and PSP
under sriov mode, and lead to DMAR on host side.

[How]
Skip writing GMC registers under sriov.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 26 +++++++++++++-----------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index bda1542ef1dd..f9a7349eb601 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -348,18 +348,20 @@ static void gfxhub_v1_0_gart_disable(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT0_CNTL,
 				    i * hub->ctx_distance, 0);
 
-	/* Setup TLB control */
-	tmp = RREG32_SOC15(GC, 0, mmMC_VM_MX_L1_TLB_CNTL);
-	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB, 0);
-	tmp = REG_SET_FIELD(tmp,
-				MC_VM_MX_L1_TLB_CNTL,
-				ENABLE_ADVANCED_DRIVER_MODEL,
-				0);
-	WREG32_SOC15_RLC(GC, 0, mmMC_VM_MX_L1_TLB_CNTL, tmp);
-
-	/* Setup L2 cache */
-	WREG32_FIELD15(GC, 0, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
-	WREG32_SOC15(GC, 0, mmVM_L2_CNTL3, 0);
+	if (!amdgpu_sriov_vf(adev)) {
+		/* Setup TLB control */
+		tmp = RREG32_SOC15(GC, 0, mmMC_VM_MX_L1_TLB_CNTL);
+		tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB, 0);
+		tmp = REG_SET_FIELD(tmp,
+					MC_VM_MX_L1_TLB_CNTL,
+					ENABLE_ADVANCED_DRIVER_MODEL,
+					0);
+		WREG32_SOC15_RLC(GC, 0, mmMC_VM_MX_L1_TLB_CNTL, tmp);
+
+		/* Setup L2 cache */
+		WREG32_FIELD15(GC, 0, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
+		WREG32_SOC15(GC, 0, mmVM_L2_CNTL3, 0);
+	}
 }
 
 /**
-- 
2.25.1

