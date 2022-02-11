Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253F1C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 07:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A752F10EA05;
	Fri, 11 Feb 2022 07:52:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA7D210EA05
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 07:52:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mu6nMGVK5vdReaL7W/Yxot3Z9F5J2VBtMR8PLBEL/o1F51QdI/OnYToyzfPifwHMaQTgBHGTeXhrnENOF2AK5ukHz0Xzuuc8g7znyJOYZLzMqn3hGJHCpfL+56FyalRz5a8gF05JRRi302x22jOc2DVbwuuaK5eMc0mvaNqfOMjsSN56rK2FTxYP847WhhldUJIkhjNVLNT9GpyVViDS/1532WZorCaj5nmetvt9QOU+OwdH7GajXEC957DtMcijeRMWPFDr8Yn3Jh5chBVriobqnYVNu5+rMJp/OmXnMjxLKevmQaW6TrTOPwbl3YibJ6D7jOgM50juoVgl4c2K5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyFT0CDLwpNA78tquUxfZ64h9DXkZlshF5yyG5nKXsk=;
 b=O8IH4hnqRHUCzbydGwnGKcUjuHqecPrEDX3p532ycHQVIYNyCLTa3ESUlxnFx3Z6yt7X7ZP5KkJaGzAsYHqjzevAbrB/VS+UVilLqsl/RcDeayGHOiU+fXvH9mMizTu5ZmT4h68mAzks9Q5k01p0eDC11Uo+Fpr4umkOEg98OPtHhE/fBpgflL1IPzwhAcaBkbnRRwP877S1KFHEACwrCtrshgaFfN4MyztJV7ZDyVl2ZJk5pooIqS1BSJ1CmY9IJBYHFBgGb3GUvezUsovGu48h0SmX9/QjMdUB4PyYxW/MTHitcTURBqQfDvlQ27XsV7hebxd6FbWVCMv/BqSLXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyFT0CDLwpNA78tquUxfZ64h9DXkZlshF5yyG5nKXsk=;
 b=YquR1Qowam3yvBdkgNeZi4v43+jFWhFQD5putHTZhbmmPPSnH8rJ0WoWEjLRfFt+SuxwYlaZjcQusIu65Jlo2RRsJkTZLt3Nk9ivLaFGtJPUIZ99EJVqvohgttv7QMbsWeEpMb/OlSBvTJLwNjDm3fTiEZLGaU6fq72ctQ0B5yc=
Received: from DM6PR02CA0155.namprd02.prod.outlook.com (2603:10b6:5:332::22)
 by BN6PR1201MB2498.namprd12.prod.outlook.com (2603:10b6:404:ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 07:52:54 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::d5) by DM6PR02CA0155.outlook.office365.com
 (2603:10b6:5:332::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14 via Frontend
 Transport; Fri, 11 Feb 2022 07:52:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 07:52:53 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 01:52:51 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/12] drm/amd/pm: add proper check for amdgpu_dpm before
 granting pp_dpm_load_fw
Date: Fri, 11 Feb 2022 15:52:05 +0800
Message-ID: <20220211075209.894833-8-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220211075209.894833-1-evan.quan@amd.com>
References: <20220211075209.894833-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f0fb0a1-7dbc-4983-cc88-08d9ed3382ab
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2498:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2498ED769304995C2E13B5CEE4309@BN6PR1201MB2498.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6VCDqRBwrIRypigKIo17wgeVO6MGsxVSC1XKmtBroevjQDLMZbdTZUBYV93feV0Sz3FObaHIMRwhNKDbdkeN7bioBP7ccUgQRqoakUTn/MTzikU5tzd5pXUSKX2BYHkI5w+YNp/XVc98+oxBDJpxhyOvvnH2WQcLw98ec2CK1BnQQxI+RvTzmOgE7bmXlhBEh3M/ngEdAdk/UzOt1WqL0A54uudsLGvIvbie1odjR5X+CqFuYxMHO96x4zwMqV4M/kk2Dtu39pCmRMdt44/jx2TkkWekenvvzkGXA/tVBGqBN8MFvN3P3PaWTpXU/uryvZSsZN+H9p5E3CG6fK7gMCRH2q3E5pha8OTQBnN+MsdQy2mrw2nIFOBqCXXfrdKe4tPPEb7w7YKsdqDfcduEDZxfdYL+qV94b2LMofnGez4KTBdubE0H0IPZV2z2TGoehwzCmp1ehYZ99uiTadBJpLK5UEvhTEIYcCaL2Ki8VRQKVhsRgIQt7C34FhJIjKQhaGIr1tkQogEuK7SlMmCwSHcGjO+y5YJJESO8WfOOnCAcn5BC5GLzei4VIpNdVFIgUl2hXWBAubpxU92l0qF+DXMwmtGnBvARelAoPMZdoQO0EM2Q87pd4AMX9CBnOVYLeIBYL6ANgSyz4q/TFir1T+CxkVqcyLt3wSP/Lr0wz6cCn2k3SPsyYPzZnFUIMc6HW3Hm4O0jkzwYpNcd1UEvzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(54906003)(2616005)(6916009)(316002)(4326008)(8676002)(83380400001)(2906002)(44832011)(7696005)(36756003)(70586007)(70206006)(508600001)(426003)(336012)(1076003)(26005)(186003)(16526019)(40460700003)(86362001)(36860700001)(356005)(47076005)(8936002)(82310400004)(6666004)(5660300002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 07:52:53.9954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0fb0a1-7dbc-4983-cc88-08d9ed3382ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2498
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>, rui.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make sure the interface get granted only when amdgpu_dpm enabled.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ia1d1123470fab89b41b24ea80dcb319570aa7438
---
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 6 ++++++
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c   | 3 ---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 4c709f7bcd51..e95893556147 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -49,6 +49,9 @@ static int amd_powerplay_create(struct amdgpu_device *adev)
 
 	hwmgr->adev = adev;
 	hwmgr->not_vf = !amdgpu_sriov_vf(adev);
+	hwmgr->pp_one_vf = amdgpu_sriov_is_pp_one_vf(adev);
+	hwmgr->pm_en = (amdgpu_dpm && (hwmgr->not_vf || hwmgr->pp_one_vf))
+			? true : false;
 	hwmgr->device = amdgpu_cgs_create_device(adev);
 	mutex_init(&hwmgr->msg_lock);
 	hwmgr->chip_family = adev->family;
@@ -275,6 +278,9 @@ static int pp_dpm_load_fw(void *handle)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
+	if (!hwmgr->pm_en)
+		return -EOPNOTSUPP;
+
 	if (!hwmgr || !hwmgr->smumgr_funcs || !hwmgr->smumgr_funcs->start_smu)
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
index 4fd61d7f6c70..c0c2f36094fa 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
@@ -217,9 +217,6 @@ int hwmgr_hw_init(struct pp_hwmgr *hwmgr)
 {
 	int ret = 0;
 
-	hwmgr->pp_one_vf = amdgpu_sriov_is_pp_one_vf((struct amdgpu_device *)hwmgr->adev);
-	hwmgr->pm_en = (amdgpu_dpm && (hwmgr->not_vf || hwmgr->pp_one_vf))
-			? true : false;
 	if (!hwmgr->pm_en)
 		return 0;
 
-- 
2.29.0

