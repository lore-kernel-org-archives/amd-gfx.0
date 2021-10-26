Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE58C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 11:08:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824C160EBD
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 11:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 824C160EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBC7889C18;
	Tue, 26 Oct 2021 11:08:20 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E800D89C18
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 11:08:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXi8/vO0cU8YJ+eZik5WKvLSSEJLYf/9MhEAqnPuInk2B+FK43cqKytOi8li/WcKCFIqUiK9imJ38+YETT1RrqzmtjhuEMc0PvZeh1z2ynVqXQRbMfmQool2eL00YH/YvWAEKkKFm35uzgnii3xZ0FCoYupm4aXH0GwUgb5s0RZGqf2PmUggc35qHwgiIaSeyT9Ca3EEtXRyXabbGA06pc8B73G1ShZF445Kj7sOpWvJ/siL8/vlYnkUnldsenfJu3xrGx/1Ync8t6MzC0skh3rhwcYKBSenlN1N9Ib9XW8YGEIyEjctnnPqcF6nU3Q6wIeaH7Q+MtRm+Zd98Gx+IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WY4vXBY+XYgGdHHv3v7b1aovm2ZHfN05xm6YXi9n+UE=;
 b=QkarUZSfDxMoFImhE5r4ysxeMv9H62hAsdbeF1NB5M6aLr+BdCQtOnTbHsv38fR7tsxeef/1ANjLJEgSFbhIU549eMlGPJsyyq04LZEAXvN7aItT5dIKBqxQaiXFhwrgQU+UbYaSVMqYpBSIYLtkoJ/Q9ieM0HfuQYjGM/mS0LcNCk11CTg+FPr63je4amtAvlVFOKZR3rXXwBhOl1zg9WpLu+3zsbkMtGxtU/xEWfB+nD+40TtziCCUqwL+fZa52+Q+r3uePoJ7JsQu1MsjATcAPfX2MiOCCZCg/oSxLpyiHS8GLvAenUI8KKP/KaQp3LbFNXx6V1UGn6wxM7M30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WY4vXBY+XYgGdHHv3v7b1aovm2ZHfN05xm6YXi9n+UE=;
 b=BxOnX6kVJHdeVew2VphNpgSj44WDEqsSRCj2iTbcdKFiSuRxLDJhiegfQUUFsHCVOuSywKh+l4/RZMSlVUtJNn4v4x1O2LMWVcoklmW/GznjJWslUlIb7vPjO2iiDgiK4sQxV1g3bw7BkEgZqfG2vshEtokPH4IV1yrMee2+E3Y=
Received: from BN9PR03CA0355.namprd03.prod.outlook.com (2603:10b6:408:f6::30)
 by BYAPR12MB2646.namprd12.prod.outlook.com (2603:10b6:a03:65::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Tue, 26 Oct
 2021 11:08:17 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::89) by BN9PR03CA0355.outlook.office365.com
 (2603:10b6:408:f6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20 via Frontend
 Transport; Tue, 26 Oct 2021 11:08:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.18 via Frontend Transport; Tue, 26 Oct 2021 11:08:16 +0000
Received: from stylon-T495.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 26 Oct
 2021 06:08:13 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <mdaenzer@redhat.com>, <contact@emersion.fr>, <nicholas.kazlauskas@amd.com>,
 Stylon Wang <stylon.wang@amd.com>
Subject: [PATCH] drm/amd/display: Fix error handling on waiting for completion
Date: Tue, 26 Oct 2021 19:07:40 +0800
Message-ID: <20211026110740.152936-1-stylon.wang@amd.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b01ec5a1-8eaf-4d70-2365-08d99870e94d
X-MS-TrafficTypeDiagnostic: BYAPR12MB2646:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2646D92DA034119C5C48A738FF849@BYAPR12MB2646.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:363;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C/G0hNwmZJW+rXb5Ho7hfgQwfJ2CRRmbtzhwHiupO/XaeDTfF9kW4c3igv0GQdGwNcP0Jf+ht5BFQEWuTzqnrKOi7MaIIECUq5e/kIPo4i7X/zKupXmPcQEn0yGAbJMl6RCw5WYMLLYgxjoWhPsHyNVOhg7TfRep9tq8nALvD4J9h0ZNCNoZ1pB9dHhUMeSsvhdLbBxUWEAT0X923Mwb8THuWG/LSpo4JOQBQMokF2fMuA6whdIi6uQ0MUdB++LcZ8MHLi0cDcUVOBI23msx5xfBwSr7Ta+p/wQVKoh8c/Z1wpk4ouDWk8X2oba+m2fJIIPDDCHAx6K3jyOS+qy1J/kNnwkN3TWJmEvCtaSUPhOzReafF8g5hZk+uLqUlrgFnbR7S1L4QEMFia/UKE6aZjb/tQeTz81zv8pytNCMGwXq/KZl2DwJVBmeimaftP6n5xMu5Nk15M+PnpiOuoP4JcInQ0iXJk2gSfa5G3vUSaepyFZXhmQQPVsujQ/hKkkxTXQmAlPbs0CcvaBa4wBYismoe9GJJ5thI3ueRhZXvJwkBLXaTEbQiqZgrW891+sZ88ABExDbjMSh69cUpa7me1sU/BJ0PTHr3iSo/oNezAl6T9fScaMS7DGg7gVX54L2LVsgFq9S4486Umn0haCYZH18Ix7a5MbprjbtDQvu03bYYQW1RjWog/sw4HC+i2JZUWAEMM1Tzc4vtAq0VAbm6OivT4l98eOziPDts8nB5+U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70206006)(70586007)(6916009)(336012)(44832011)(2616005)(36860700001)(82310400003)(36756003)(8936002)(1076003)(81166007)(6666004)(83380400001)(508600001)(186003)(5660300002)(426003)(16526019)(47076005)(86362001)(54906003)(316002)(2906002)(356005)(7696005)(8676002)(4326008)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 11:08:16.7121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b01ec5a1-8eaf-4d70-2365-08d99870e94d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2646
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
In GNOME Settings->Display the switching from mirror mode to single display
occasionally causes wait_for_completion_interruptible_timeout() to return
-ERESTARTSYS and fails atomic check.

[How]
Replace the call with wait_for_completion_timeout() since the waiting for
hw_done and flip_done completion doesn't need to worry about interruption
from signal.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4cd64529b180..b8f4ff323de1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9844,10 +9844,10 @@ static int do_aquire_global_lock(struct drm_device *dev,
 		 * Make sure all pending HW programming completed and
 		 * page flips done
 		 */
-		ret = wait_for_completion_interruptible_timeout(&commit->hw_done, 10*HZ);
+		ret = wait_for_completion_timeout(&commit->hw_done, 10*HZ);
 
 		if (ret > 0)
-			ret = wait_for_completion_interruptible_timeout(
+			ret = wait_for_completion_timeout(
 					&commit->flip_done, 10*HZ);
 
 		if (ret == 0)
-- 
2.33.0

