Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9992CC77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 05:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ED4810E060;
	Fri, 19 May 2023 05:06:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6C3C10E060
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 05:06:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EslxAKKUSWU9PbdQhZ5pGQQys1lpz9+R/ZLNKRbZ9vy731TqDRVV3SM2iLkK2PWTs5R6PL/bCcAH0I62ufp4jHDhtIEeNwPrjv88dukjmkXzXBrlbeuWJIwxCsTcqaRBYwhXCektceLaeULE//Af9RvxQZDwDkHv4zzcDe5TuYuhyFxsr+RP7+UoTiqetDBSthteGSqj5Cy2/XG3AXuJhvW8PYabhjIb3gZaaPhn/nPW1UqjPhDvIn7yOtRCJQ9eBtDW2+ZRGL3YkiBXeeUpa85N5A70NQtgZk2ng+AarL5vXhlraoKcRJzNm4LrBLIzaAY5/9f9Uz3CWiM3w0rudA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzeCC2uOt1MuigGriMJ3bY7U97kEkOmH7KeW8YR/7h0=;
 b=Gc2wszI+OOrCfpIaB99DlE56d5rGCLjmlh777PMSkfdZfR1Zb11xVzMcpXjiJ0ufh3Os3qTGqYkuFCsqlLn6Rr2+4Se9NHDMDdppKimg855k/SE8Lyt/dhw1X6ItGHq1hmViAzwWtX/5b6hl7bZuPH8AnIV2PkjZ9vo865a9D2svCg6CvdzcyiT13KLGTJ2DeVfWGPG+yAjZGERybEzb5fin3qyF+2OPPeoIujKVlavx57jzt7/e/5Unj8Vbrr2e6CEmCeK69SGebVRBwu+Q9S5ap3m+7KBDV7yoz6uEWf+XY6CWAASK641h424YAPJ9ZwoFd4rxr+EaAjPnCJrhtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzeCC2uOt1MuigGriMJ3bY7U97kEkOmH7KeW8YR/7h0=;
 b=lj9uQy8xtCmOW9kb7iSqDUbHsYB3svbfv5xhJTtI94OfyIRRYL6+pzAp+WwZRWOKoz2dZcMIbcg/kVZaZPqZ0jXPtNsffUCTwiu7nppqAzlVQFLPwTjwAzXHfVFGBzbVlkmobqlH8qKte+ZNQkARfMf5V0aZvDb5ivPEvqcmuaI=
Received: from MW4PR03CA0112.namprd03.prod.outlook.com (2603:10b6:303:b7::27)
 by SA1PR12MB6749.namprd12.prod.outlook.com (2603:10b6:806:255::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Fri, 19 May
 2023 05:06:08 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::87) by MW4PR03CA0112.outlook.office365.com
 (2603:10b6:303:b7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Fri, 19 May 2023 05:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 05:06:08 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 00:06:05 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 James Zhu <James.Zhu@amd.com>, Leo Liu <leo.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Fix uninitalized variable in jpeg_v4_0_3_is_idle
 & jpeg_v4_0_3_wait_for_idle
Date: Fri, 19 May 2023 10:35:48 +0530
Message-ID: <20230519050548.4192535-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT028:EE_|SA1PR12MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e5dccf-da75-4db0-2bf6-08db5826c194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /bCWQYndife8bmc3X9uNYg94lo5OTPmoC2UXgqxqrUhw4RddfVKuCDrqwUHw5o15FLb9PKdnmHsph74UiwrYb9GgeCG39AiT3sl9+fgg1z/KfACAphoLUDo3XMz/M/R1zT0oNfVUHz1+OScm9qU1R8t/DcWmHNVaDjvcsRQZVu7uRmN+cFgnA5VIsJ3+bOWkXeMBxVpVlL2h+qfgv6MBLuIvT081c4ntcbe5E4NAfnoS95UUnU0u8+rrm41jwileCbCZ8Oz1xPfgIl64AEM/UGP2Yrrpnbyo/xzIK/tqoTdaj006H46tIN2taUNOUuEfUDOsE1h4s9xCTcm7WWDyvFp5A0O/tR6GO69V6pZqf5IqssKmqt95vZE12ugdRD8+suu/foUpSSSM5m6DhnMe1oK8xB8UWzQGhhWnydGpV6/ewTulXe0al6AGs/WhHKskou+gOJ3TCfgPTzr5leonqQ7+BrmvdGXCxAedN2IDYiNtyhBu11d8Jx8z7vr3rGhPuk4D4t1yf5gfuhAsy3CvfgMgtqcf2pkXndAt0wLemq0u1/KLoEXULveG/js7vpnYGPIN4vPWSPNmtTT01cBiSj7kNsNhX0CLa5Dx0YHKIjn8gzeIHD/Tv2Fetn0rQ1TSetv8yblJZJv0lG6hqVfI+EeBB/vU8J3MPIeq52zeneD4R1EUinaoM1A7IHfKpXAQVIT4IJfz3t2q773ERLbyLfEQnJ7KsS9PTZU4r7eEHP/8YXks8WBqcI8TpXpie4cg255ZX2HgT3e4V21B1DimfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(1076003)(26005)(7696005)(36860700001)(36756003)(2616005)(66574015)(83380400001)(40480700001)(356005)(86362001)(426003)(336012)(82310400005)(47076005)(82740400003)(16526019)(186003)(81166007)(2906002)(8936002)(478600001)(4326008)(316002)(44832011)(6636002)(54906003)(8676002)(110136005)(70586007)(5660300002)(6666004)(70206006)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 05:06:08.1053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e5dccf-da75-4db0-2bf6-08db5826c194
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6749
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c:752:4: error: variable 'ret' is uninitialized when used here [-Werror,-Wuninitialized]
                        ret &= ((RREG32_SOC15_OFFSET(
                        ^~~
drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c:745:10: note: initialize the variable 'ret' to silence this warning
        bool ret;
                ^
                 = 0
drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c:774:4: error: variable 'ret' is uninitialized when used here [-Werror,-Wuninitialized]
                        ret &= SOC15_WAIT_ON_RREG_OFFSET(
                        ^~~
drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c:767:9: note: initialize the variable 'ret' to silence this warning
        int ret;
               ^
                = 0
2 errors generated.

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: James Zhu <James.Zhu@amd.com>
Cc: Leo Liu <leo.liu@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index ede15a3a4701..ce2b22f7e4e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -742,7 +742,7 @@ static void jpeg_v4_0_3_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count)
 static bool jpeg_v4_0_3_is_idle(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	bool ret;
+	bool ret = false;
 	int i, j;
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
@@ -764,7 +764,7 @@ static bool jpeg_v4_0_3_is_idle(void *handle)
 static int jpeg_v4_0_3_wait_for_idle(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int ret;
+	int ret = 0;
 	int i, j;
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
-- 
2.25.1

