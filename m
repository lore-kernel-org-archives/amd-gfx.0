Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2463C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 20:20:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4336110E73C;
	Mon, 10 Jan 2022 20:20:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 409ED10E6D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 20:20:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGWUO556414ClDIGdV0ISyK5mGcOMyUM5cnOb9dO003BjGavW6vlccelKZER9UVAIW9XAp0OXwwCOvZX6ZJSlye+lcsgNAjpeDgnWdfRik+rbWyzKZZFJRkb/sIuVB/1CvZd/siDGVnVisTOSMmkjZuw93lQPWmR2i3Qd5khZKWrX0faRVY24lUzvRN+ndvIPZ/YgF+hySfJFX0CCcdKY31S0gt0/m3suWEe6Cb6WuPWnhp62/xvss5qR9WYvyIHvqNMdozVktbrTjKUDxnatJErJwRsI2kA1RKNKbs216MVowx+3GjT6eVmANSKy78RQkZqJWz/8iGvKVzKIO/t8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNiojhPRjdkYomoDLkNvl4jziIuegGX25/N8sjZmB8o=;
 b=CAWclTKB8NP9D90iAVVQro7KpM1Rafbn4ZMiqISSCW2kNJKN9WRLctTThNByLgsjQaE9TLp6+c45EN1cw8VEQyRqq2EkweyPbbPxuA2fOaMO2rWjdEfqpZjeBEGwqt2v3d5x0PSjH/ICSCD9irk5WgpxaNNgkfO7IfBq16nf/jeZSxGhAEW9HfgdQMV4XVts40K+Q7jo14DTB43ju2JvI1AtFOEIbOhNBjhynQIvlsP/jERFeU9smqluIkWPT7IGTzxN1z5wY7z9r9PMwN/0QWJz+najLHOvmB0tFvsO2ryDYW4WOwNbjkV7AZ9dxgoLrl5ffhoL+wlBjKTStG9V2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNiojhPRjdkYomoDLkNvl4jziIuegGX25/N8sjZmB8o=;
 b=RdsruXuPldKmaCD6JnnPl51rKpgcb3aPvorNjd5FlZRxnvmxL8wnP7oYcTR5PL4+qNHkuo8aOQIRkk+pnJ9eYA8+rsb/KpA/0unU8EDrYs/Spiv6BzM5Q3OEB27idLHhJ2dGFZosb5elQv+23d/klvnulkyuTtRu7eJdNNXCLck=
Received: from CO2PR04CA0171.namprd04.prod.outlook.com (2603:10b6:104:4::25)
 by DM6PR12MB3705.namprd12.prod.outlook.com (2603:10b6:5:14a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 20:20:41 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::6) by CO2PR04CA0171.outlook.office365.com
 (2603:10b6:104:4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Mon, 10 Jan 2022 20:20:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Mon, 10 Jan 2022 20:20:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 10 Jan
 2022 14:20:38 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: bump driver version for new CTX OP to set/get
 stable pstates
Date: Mon, 10 Jan 2022 15:20:27 -0500
Message-ID: <20220110202027.1949684-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220110202027.1949684-1-alexander.deucher@amd.com>
References: <20220110202027.1949684-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d214737f-7243-41f7-41cb-08d9d476ac5e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3705:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3705CDB8088DBB655162F6FBF7509@DM6PR12MB3705.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:65;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M8eMDoKoMWGemXcdtXKww/XlQd9mniveA517985mWyZzmbCPnNGkmuV4Rw3I1Kl1Ae/7gJTYh7AKOO3hgp1HQh3Zzl6LcN5UEOUtFKFHqs3vpabM8Dt670nYGtqgQ1u0FZkPnAr1pHOczkW1h98zpimP1sx+mMBfetOcYxk8x8+dYHSSh19w+sfz2dM/aXWYWiErkd266hODQi7KQ6D/3ZeRqdkBeVaS9/D0GH9/3TaaREMgzm2tNarmrcjySSj3vMifXt7kdpgAevCP+ABfA1gTgj9+k22s0JDmfvfixpqaPlAB5g5cIlZ9TGLSld3+bIBVCox5vQvDNHP9DqI0FSDR/dH0FU3ePbjuMyx6Ar4ulcy/ATtoPaU/v+YWeuofmZLieAs5rmahsb8HOpmAPkVEVlMKmcSpI8ce2Yluf39YCJFPij+U9a8ymyIrE9vdJ6/ea67f5Y2P7OA542UXRhmw6v8c0LNjr6eqKlgouAOkmndOmmq0UUOgqRen1oLgJKPLOQ6PWXVszpKKQqKm3CwUdYb5VpWlZTcKHB7emESSzkldB2iIW20IceqXGzUqiRbmj8z2Gc2IodI+Fg2kN/hIjKWcL8YEX8vchZyEGV4hM0yqruwEmGVUwsP/it2Atk8cqRPlKvD4lsomfOYypRXL/1VECJm5hlxUhVvWvgiA2xvySVrzOzZTQm0TvsvWj20BtIfrkSmLdwFId1r0BKHMkFUA4z4Qj9EiF+xKUpmvm9BFotz643tca08nJnAHzKoozErPgy1TDCR5uBZ49uB8JIZqW9EQupv1N4cqNtU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(7696005)(6666004)(186003)(81166007)(40460700001)(336012)(4744005)(2906002)(8676002)(82310400004)(8936002)(508600001)(966005)(6916009)(36860700001)(83380400001)(4326008)(47076005)(316002)(26005)(1076003)(2616005)(5660300002)(356005)(16526019)(70206006)(70586007)(86362001)(36756003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 20:20:41.1161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d214737f-7243-41f7-41cb-08d9d476ac5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3705
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So mesa and tools know when this is available.

Mesa MR: https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/207

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d3ef99d7d117..5e3de111ae0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -99,9 +99,10 @@
  * - 3.42.0 - Add 16bpc fixed point display support
  * - 3.43.0 - Add device hot plug/unplug support
  * - 3.44.0 - DCN3 supports DCC independent block settings: !64B && 128B, 64B && 128B
+ * - 3.45.0 - Add context ioctl stable pstate interface
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	44
+#define KMS_DRIVER_MINOR	45
 #define KMS_DRIVER_PATCHLEVEL	0
 
 int amdgpu_vram_limit;
-- 
2.33.1

