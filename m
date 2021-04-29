Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C15CC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 06:31:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA992613FF
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 06:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA992613FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D8236EC8F;
	Thu, 29 Apr 2021 06:31:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A5A26EC8F
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 06:31:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5CjEl7EjKTQ5PNLlOTtEjpmw9ea7+xCUB1O+w2G7JPytc1+HxCsm35mi1iimEousi5t7fgeIrNvoF9KzmV8KiIHvkjQGPr1bnvYzkq1cUoH/vSJIAkD9O14xfAi1cTCB8/s/6Yv761VOiXIv3hZkimdwHqNd3d2tInpgmRg4reKlIysqZ03wBJ3LPaeq4cQupC5c5118ImQJ4tWkdBCHzQwGvE7j/amO6ZMuXgODnrzq5EDkAXDsuix4WJL7zvtWxuoZGgO4LEL/vYC3KTjvM6jGjqh+AuT5++hvVxVFKHHf/vBzNA0iiIAy3+veQtuqICx6fv30i/ivmuebavF/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XktTdeHjChPRGzPWtzHxL38tRmDxzbyuYaOgU/KbnBM=;
 b=VSiTrssD/GKllNcehqF6h1q5ug5RxpCsXHMXkdHByAoMfUMEh4TseUCjDcwUlo/TsaMNW5ywAfyROqUgYfk3Ho6/G1X5OPFBcUhCx+ixq/o+B7lASc8dgj3jrrm6xZPqYCq1ZbuAlBuYmkD6CL1ADfV3BJ7Hzr+JL/Woj1vzFAQbjQI3/0J7vzoAlVS7k9Uj85osfw+cdK2RnAvZuPDeeD/tKjaphTN9QdqeuyHyYhValawAV+bcSDoNLBrv/aIfKv509WECdNtgQ/vO7jWJIhd4nTLv0fBNn59PLKuJkWIndbvytF+qvJr7ideya4UiNejlKgmQ2yRZ7PCVfUWajQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XktTdeHjChPRGzPWtzHxL38tRmDxzbyuYaOgU/KbnBM=;
 b=jqx9Gw6cnGRocayGh9voX81nrpraE6IaK9ruhxXDtyr8VhdKISeGSTnGC5U/QBT1NeyDmUwImWN/x4xbFZfciV16V2wpHofPKVblnMoEVFGDXPfwVLC5oc+YEQ96OxKoIfNtn6M0/U/VkW4WCMi4teU5AQpDFlB3Uc6EN32QiX0=
Received: from DS7PR03CA0270.namprd03.prod.outlook.com (2603:10b6:5:3b3::35)
 by DM4PR12MB5360.namprd12.prod.outlook.com (2603:10b6:5:39f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 29 Apr
 2021 06:31:12 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::a1) by DS7PR03CA0270.outlook.office365.com
 (2603:10b6:5:3b3::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Thu, 29 Apr 2021 06:31:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 06:31:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 01:31:11 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 29 Apr 2021 01:31:11 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Rename the flags to eliminate ambiguity v2
Date: Thu, 29 Apr 2021 14:31:02 +0800
Message-ID: <20210429063102.23693-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 397edfc4-3dc4-4404-b5f0-08d90ad86230
X-MS-TrafficTypeDiagnostic: DM4PR12MB5360:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5360A33072792AEB02A5EBF6F85F9@DM4PR12MB5360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gMIgPSAV8cOtRyyhxDOCto/z/Z1v4km7GQCxQBQ5jXaUbm0C/MKpfPchh1omG1z2irNj49fWH2j3kXQBNimGd5o7SQvg0AjGsM7Iux/mSFVPckiaKQeRT2KvYtFuMAr3GsLIhmPXCZDirVEAVKKtgDwDKb/pwjsHKVSwAqv74sr3Fc7a0D/3I+xOieaP3Qckker0ZotZ23AyEyAqXK+HbFV4OoxRGPCnKiCmCxevKk/OrxqlULZx/Q4afHRgCasdswVk1X7l+RHc4zEru2eeEnhW03EpU+vEmDZgLbCtUsItLZKBNMtNmsudOIwAuUK+Z+Ba4ub6fL/nFwoNvoBM2grKnujr3uOJztPSjILgZYPmHKaj64Gwyp6TjA2Q0mPMMubmVVoT6FG6BsBBEcSAxZByPzRB8axMxWBts6cpagV9WpHpxXsqARQ6jDk5KanZHo0gVjH5VPX8jGuYoMSlO3JsbrO3JC9QpK0zx/9Z92F+spYQ1EEMuhbSjrDI2NURPGtyIZkpUiIiXcXuHucxTNUpWQKMbPlqEdNw1WDJrkNgn7qpQzDdUUHG+mV8ultLqNOBSXll5ieI69t73OroAU19116BxxVPcmYkhtBuw+/ng5A27f+GEkbzh6FSE28zCe0jwppBiV/kHDGQeVJ8Tp7Fm6y0oaraD1rYcBD49oSFniEQwOmpg1HyOsUHGJ90
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(36840700001)(46966006)(8936002)(83380400001)(5660300002)(426003)(4326008)(6916009)(6666004)(478600001)(356005)(81166007)(36756003)(82310400003)(8676002)(70206006)(316002)(4744005)(336012)(86362001)(186003)(26005)(1076003)(70586007)(7696005)(2906002)(47076005)(36860700001)(82740400003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 06:31:12.5279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 397edfc4-3dc4-4404-b5f0-08d90ad86230
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5360
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

The flags vf_reg_access_* may cause confusion,
rename the flags to make it more clear.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 1a8f6d4baab2..befd0b4b7bea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -98,9 +98,9 @@ union amd_sriov_msg_feature_flags {
 
 union amd_sriov_reg_access_flags {
 	struct {
-		uint32_t vf_reg_access_ih    : 1;
-		uint32_t vf_reg_access_mmhub : 1;
-		uint32_t vf_reg_access_gc    : 1;
+		uint32_t vf_reg_psp_access_ih    : 1;
+		uint32_t vf_reg_rlc_access_mmhub : 1;
+		uint32_t vf_reg_rlc_access_gc    : 1;
 		uint32_t reserved            : 29;
 	} flags;
 	uint32_t all;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
