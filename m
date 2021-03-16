Return-Path: <SRS0=fEJB=IO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E08C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 02:30:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85ED364DE8
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 02:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85ED364DE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C83B989971;
	Tue, 16 Mar 2021 02:30:05 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760050.outbound.protection.outlook.com [40.107.76.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ABA589971
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Mar 2021 02:30:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7n7ZgMzVpCTc701kjUZMJXMIzOTcXUkc0WVRYn3A+NnFTA60321a87Vww7jwjrgMAUSlLAhogsHS7qEV/Vyx9pvmeIlqfPBDM8Auw7UaGbkigkaiWpb6FBelKgUsQ7aM9i53yfjisJoopVl4FjIsos+DnUpB6c3Wbp0mE+jXaTjNakh8G7yQzH8RG0oSdiZ7XQ0Launryhpj8lRDa0OV1CHDVVlkhKS4NTlTsMqtVVUbQ75piUbbDncdExMr8dPnQFrzg4etOOxPSWEBpE/fSL99XRoaC+Pe0x8/EPlcJCGZcO15qqobrkbb58PRtz2jz7Z9QxrQ1tKDZQHgx1yMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upfWAqkMG8M914BD3gbSP0SzFPdqWSAqcIjvPB7qCXM=;
 b=VRUC+EOJ7nyIqw1f+IhDKNa2czn/51D7/mjwcVy5ZDrvLCMfGgz4KYFasTSCe/MbJ1erccO4IR48jwgvsRSTBQongmLjN9WLSr0b4uXK7ZL1/ybuBpBQLFi/LtYI+Ap34K/zF12ydOEEdCbdBvleZvXyzPkbpGuvZ/nv/ZfR88oRihMTfYkP8eCAw8Hjn5uQ7o8F+oaW8jq6mMe+pAb+ku7j/ULPK0cT3iBeYlbXpql1RL8aBMItWWjskRYuyisiv4hCakZlWO8BOAkh6rcpQ1VznhFneBaKBegz/LVEzr0BIWJjOYFbSHnEZkH61coBXuhcWJBZbU1jFKCsBOREWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upfWAqkMG8M914BD3gbSP0SzFPdqWSAqcIjvPB7qCXM=;
 b=IYXGi6q30m0pROrljWYOJrMgTV05VR5hRMpYIXe9BwuFVtqUmK9Pfu1r3yMKiC4+EysubYGDR8mPwfERZqqeyNbULnqe9ZXOigLc/HGMWd8bJyj+2CI3aoTIRz2orI7D6w6XAbnekbipROEEkWcTNLJENCH51ISvmFET9dDyfSQ=
Received: from BN8PR15CA0044.namprd15.prod.outlook.com (2603:10b6:408:80::21)
 by CY4PR12MB1493.namprd12.prod.outlook.com (2603:10b6:910:11::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Tue, 16 Mar
 2021 02:30:02 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::ad) by BN8PR15CA0044.outlook.office365.com
 (2603:10b6:408:80::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend
 Transport; Tue, 16 Mar 2021 02:30:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3933.31 via Frontend Transport; Tue, 16 Mar 2021 02:30:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 15 Mar
 2021 21:30:01 -0500
Received: from kenneth-u1804-kvm.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Mon, 15 Mar 2021 21:30:00 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: fix workload mismatch on vega10
Date: Tue, 16 Mar 2021 10:29:51 +0800
Message-ID: <20210316022951.9544-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88bc3602-49ab-4f71-a6ed-08d8e82366fc
X-MS-TrafficTypeDiagnostic: CY4PR12MB1493:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1493E2A5D9E579E72D698AC48E6B9@CY4PR12MB1493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KaZ1fVvmcvswmYGF6BzUOJge/rfN3HYFl1XnwIfwIgG0fBzVGpYXz9LfsfkmLnqf+lJQ8Ct2ep1SjlgrzzI+9urvekY/yC+t1QSv8p+kFTtM0NLgnW1L6IvsZUFwpa/r50YPggenFKmWYzjc7yPTcp7vBQFuJ5sU+p7mJMMve18NFjGEU04ZBmeq7HkIpnBgJTiGye+2aZwbyiniehkI2+6JOE7gkbbK3SM5ksJfue+npnljVFhfxp6Pkb6ezeHOi/A0vk4WrVplAIV2GCAN20Us0v+PJyPh6GF15h4nqUnnRGZjgml8JktpRL7R7h6QNQVE9jYdQ/Hci2zy2yVuQ1lveHMJ7iL0pC7LkEpGhgiOR359HG5yvt/qddzcjS031UdkzMJMcCOP4jg2+sIjGFywJqP2xLCmeTd8ow38hqInvCePqyIuqdBSg21esJwjLOh46PxoXV+QbP1x0EJFQUtroIzGRHXFXPcbKf6+pQK9gjr5cnKuAOyVLtqbpCQU/ZrDmUUsHezXxy4ou5b1rcFumr81CP/yVgB+7Bu2zfBTg/0qAHHp/0NNMxH00kkCK9Pugklc6nv4ZJ7Uqs5rmEsjeZaWAHXbI3FTdOO2zUzG7LuPUgFeC4tfQDaca55HYJ1LXAQBSjlBw28Xit9uuOYDY7sSd0Eou5xZztuXIz4x7wtW5c0WhyTeN/19K9v1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966006)(36840700001)(6916009)(82310400003)(426003)(82740400003)(2616005)(6666004)(2906002)(4326008)(356005)(336012)(86362001)(83380400001)(4744005)(316002)(1076003)(44832011)(5660300002)(36756003)(70586007)(186003)(8676002)(8936002)(36860700001)(70206006)(478600001)(7696005)(47076005)(81166007)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 02:30:02.1808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88bc3602-49ab-4f71-a6ed-08d8e82366fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1493
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Workload number mapped to the correct one.
This issue is only on vega10.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index f5a32654cde7..31c61ac3bd5e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -5160,7 +5160,7 @@ static int vega10_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, ui
 
 out:
 	smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_SetWorkloadMask,
-						1 << power_profile_mode,
+						(!power_profile_mode) ? 0 : 1 << (power_profile_mode - 1),
 						NULL);
 	hwmgr->power_profile_mode = power_profile_mode;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
