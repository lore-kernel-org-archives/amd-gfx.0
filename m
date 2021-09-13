Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE124C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 17:28:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0F21603E9
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 17:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A0F21603E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BF796E20E;
	Mon, 13 Sep 2021 17:28:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FDCC6E20A
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 17:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3X+cC55SNHHlTROhtfur49C6oNJIxSnosu8v/Xy139pHKt/rB08d3U/ZXpsCaYoMUS+yLxatdV3TfgNIFKpcuJ/HyaB51SaaoFZS46ow3Sr1cb2S4Ne7Im25TJVlCqlL4q2xgLWFMY2Plxl+0x4zjVLRTRmZD5DGCu7S9GoggC8XK3No8aBtHjyfUljyNDkz9dIm3eN2w3BwACNf9MNHXxyJ7XXNnjrMSZdmZtJV/hvVSrEzzYUoJhT3WZQFnTG4Z7k52myQY8tywsUoNC07z45Pgjoih1kCWDrt6a7C2HRacPq40phPG2che+Y6UhlvCXHjp+PwMpTRqHnUPmzug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=NkElWGYqVjXsgu1UbWUYnDYITLM21k8T+al7joAsTT0=;
 b=F600dMIKfpS6fTxxIMKMhDaGkwKzYVLc2UaBz3hr3Qj8m0i00s0RPsAIvBhI5KQdFGI2/bxEt2L+ZHwOqkMoSBftHEjz02NZDebZBhRFtxluxqSTPuS6Bi0doOBXz2CkOZrP9WT74hfMrWFGgmPZsxspyTVIH+1/dJRIBDJIPxCorEuAy06jnygLZnVfn4ujsRgVyEbZong8fhHwlVv5nyG28yaXFdIOe3lIeLQUAO7BykEwXV0FXsibtvFOy3gHgXGo6v3NOfcQAr9AC6irTU5wuGTTNxA1LWOo9fyI6kf3mQh7foc4VxHg+uCcKp5+hZMq7ip2T+bw1kYH+qGAdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkElWGYqVjXsgu1UbWUYnDYITLM21k8T+al7joAsTT0=;
 b=Sq7bf7iWXdoMM0b2bBBQubZIW9pcHSOnvkKYtEt/hP0EZeKaouDne6tYSktAg0co7EDNqGyAS/cv8vFPWqSWaZeR0VWuNNaWKTu670DGAshN+uDGDvNLU2RX2OjL8JRaVRqToZctL7gvnKiKRPeaSNxGYmjcaCafsjqosK3pCyA=
Received: from MWHPR22CA0024.namprd22.prod.outlook.com (2603:10b6:300:ef::34)
 by CY4PR12MB1896.namprd12.prod.outlook.com (2603:10b6:903:124::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Mon, 13 Sep
 2021 17:27:56 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::89) by MWHPR22CA0024.outlook.office365.com
 (2603:10b6:300:ef::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend
 Transport; Mon, 13 Sep 2021 17:27:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 17:27:56 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 13 Sep
 2021 12:27:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 13 Sep
 2021 10:27:55 -0700
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Mon, 13 Sep 2021 12:27:54 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Anson Jacob <Anson.Jacob@amd.com>
Subject: [PATCH] drm/amdgpu: Remove ununsed variable from amdgpu_ib_pool_init
Date: Mon, 13 Sep 2021 13:27:51 -0400
Message-ID: <20210913172751.2008689-1-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 594c5f62-1528-45ec-c3a7-08d976dbd33e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1896:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1896B63CFA04D27BF39E12AEEBD99@CY4PR12MB1896.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:288;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0URkgQAphf1UURcmUVmctx+nP2MMMPSuqRYotlBilbVjhyIi7UM7UF399xuW3WigFQH6sCcBQeF8sINQFRt+HtOOM5m1s2JLEumZtijFAxDypuj/ERxqpDT0Np0I4rLimQ1kL2gkjI6jsdpGJSg/cJ/wLY51FeQWQMPpAr/DQUN2/Mjsn9TEvcNJ/IsPcoQzlcA0Cy1SzqgMQ5wg722pCnIlqYuz5pG6SU1pU9AxQOE9ZnRj5Shh4jckaXvCC94hzCvPEFCBKMs3uemckv32A+cRbcDbVuhzyzLO/dSxgItQjo1aGc/kw3k2o5G2ctOP1MBBWiYEzSYVhiFk4656o2NRDMWoX3rHix2GYCLxQnUe5w2yllpicLpZLmwrZHbxO0P6Pu7UzaPeMYCYjZwdq7SnH9SQWtv7glb0q5ZcBziEL+vSD+s5IdUDzdJ9DcBM6cq/6xm8W/k7B5X6/CLFDThIqfLog/QEvfKcnH1qGeG/wyyzdUo6eBeC14UM2UzcXVNhsssMXlePqlHeSrqHT9zOaqO5dGkAaU/K+m1xcE1mgOyqKuOmQ0ktjn/csm0dgr/tAAaMRdczinHrP2nQp9F0RBrRdzFM0V6Te7+z+uXV9j1H77lFpgCWAizCYmQOksYAWx2peUq/5zlKAXnp14ajS01b+5dRRE4LB83y1UfgCKznQMKSmV10a+ogHPdqiDjtzbFpnv4fk5zcEsVNJp4lSqwPExHF52kIMjWxorg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(7696005)(36860700001)(81166007)(316002)(336012)(70586007)(47076005)(5660300002)(82310400003)(1076003)(426003)(86362001)(4326008)(356005)(6666004)(36756003)(8676002)(83380400001)(2906002)(4744005)(8936002)(26005)(2616005)(186003)(6916009)(70206006)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 17:27:56.1918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 594c5f62-1528-45ec-c3a7-08d976dbd33e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1896
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

Remove unused variable 'size'.

Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 9274f32c3661..bc1297dcdf97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -300,7 +300,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
  */
 int amdgpu_ib_pool_init(struct amdgpu_device *adev)
 {
-	unsigned size;
 	int r, i;
 
 	if (adev->ib_pool_ready)
-- 
2.25.1

