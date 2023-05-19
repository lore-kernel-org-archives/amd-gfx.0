Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DD0C77B7F
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 12:45:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD39A10E0BB;
	Fri, 19 May 2023 12:45:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C958210E0BB
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 12:45:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltUXNDswX5BJ3S41KeWvUU8Jm9jelXr5HVcA7h5miFioQsAcwjIu8hkMU434JmcRnTVxX+QusAZ69McMg1cdqV8gyX+/qAdgRApfDXJzVbDvVMKGeV1EfJMGoPISNtsLA+IFOUdOENOWOpB371HYiI8+ROSMRyO67tz2TPxF8u3aiBFIHVm82TR9TQPR4+eS8dfE8SRg0IVmTIl5xkfxuWUFeYNK8hPe0nq9cULFTxbOILCNmQg9ntRdZ7Vh6wrRstjzoHRfI6JUUOAPTYbuaagBavTgUyUaD2250QJ0lu9f4eA5l7QKdqgVNi3SImPsJzoovEkohUo96xP08E3EEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bGQwQRhJ3PdmVb7Bkzus3cvCBj6qBi2P1xxAgFAU9g=;
 b=HMWt5X5f09a5+1ljEz8gXjtHBe2ZfuxqUqJ+u9S0sGpYKWuAKkGiP6p8PQ08S5PmJ4Ppk5C5WEn06YyMRSvoFfZ5g+4jbqoc/rHLO0j1vH4cd1w6ga+xVSGAplhGgi88ScMEBZ5syujD2IDTdEY32ntE4dbr6bmQlJ0a4v3d6ImlcfNqqNTMCzKliXCGNOYf4j+o/eYmZfYgxrubSm5ecEj6eq+jYFUTjuXr4tM+QNKFbmzf+txgYyprGOSW3J0brsqRbPABrlYXMHl26XUJ0mEZa7UzOwGMwblsKzD8B99ppT9lL57EKVBQ3h4q1119rjQLbt0zUA2gZ3mHpuMzvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bGQwQRhJ3PdmVb7Bkzus3cvCBj6qBi2P1xxAgFAU9g=;
 b=gEQD5Mt0dXLK8kdcaAT7fnbWolQhIcs67syF3TCVEdetHmJx0J0QHDUoXKeYhfcMoxpP1AEvNeG2zszxSf5vbwg+71+Y/7BT+ELLwNtbK+JEqxGNsjXIcOO5QkKAHOWYAsNq7l6oBJcpOi8d0Qu3lWr+J+unU58RQpMHQKlJUqQ=
Received: from BYAPR08CA0049.namprd08.prod.outlook.com (2603:10b6:a03:117::26)
 by CY8PR12MB7659.namprd12.prod.outlook.com (2603:10b6:930:9f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 12:44:58 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::fc) by BYAPR08CA0049.outlook.office365.com
 (2603:10b6:a03:117::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.20 via Frontend
 Transport; Fri, 19 May 2023 12:44:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.7 via Frontend Transport; Fri, 19 May 2023 12:44:58 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 07:44:55 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH] drm/amdgpu: Mark mmhub_v1_8_mmea_err_status_reg as
 __maybe_unused
Date: Fri, 19 May 2023 18:14:38 +0530
Message-ID: <20230519124438.365184-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|CY8PR12MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 09f435a7-a88e-4ce4-a7f8-08db5866dac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Ur2JtmSn89DPTVoSgHQw2vJ2oeQ8kTy4M7WVUNzdrx7TXLVRrQ8vNRW6xMrX01xqWhyrxEX2vHYnqQPWS4wwTy8rsuRO+NuNHRpVV8KXpIOqfbz8yvDeZlHdpk+4rRnZLhSX/VJJkhuXD0GHsZbLOmahLCeJ4xtQ/G+pSZyz78Xa6fF7fdoCF9M9JoE1txmxJdeDLslzzdXiwe0CJPo7xqlu2qpCTOvB5auBLPpUv5d33TIiOPqZScsaoUXZ4QxTKldHBmVx8aEh7wZNs4kUycIsRIuN7ZW+2fFlYLe2KG5p7bbjey0dLmU1XwENf3V6+jNSRXH4RcCzZnSDFsG8cqOiYQsSXUgeVWl23HdVb049zapazl1ESnyYcVjNYAADBdgIAuv0i7/RqK8YRyDOuxozRYOnvo8mvYl6PN8gmr7p8U/2EoiJQLcs+G46/q5rG/7UvzSCm/IBhjT52HEC2KIppLeJ0/wpyNFl7pEWy8VdOXNTexXCpXx2y1GRr+IqYtNcVyA0kxUBNyfTNogonUrgh735nhTy8SnkkSUc73qJQLgi89T/izcL0idJKSCnp7zT4oA+efTTbLFFZWDqGXrwv8ahKBz2mF3IJjUzLA4nHRbaLeyHjfWk/1xmmnVGDo79b1BkrqDJuwFTxa4Hb/v9b/NiZMhB6+dIucheVwrazYeFau0EPD90OS0omSfndEgm/Cr7Rd5xsthrIE8FF3CfaxodCoSdTwozF44ph+70/lL+/aEimTyvcF+t5kj9TZl0ZdUsxW60BTNhpeTSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(1076003)(26005)(40460700003)(36756003)(36860700001)(47076005)(81166007)(40480700001)(336012)(66574015)(426003)(83380400001)(2616005)(82310400005)(86362001)(356005)(82740400003)(186003)(16526019)(54906003)(110136005)(44832011)(478600001)(7696005)(2906002)(8676002)(4326008)(316002)(8936002)(6636002)(41300700001)(5660300002)(6666004)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 12:44:58.1986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f435a7-a88e-4ce4-a7f8-08db5866dac8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7659
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

Silencing the compiler from below compilation error:

drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c:704:23: error: variable 'mmhub_v1_8_mmea_err_status_reg' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
static const uint32_t mmhub_v1_8_mmea_err_status_reg[] = {
                      ^
1 error generated.

Mark the variable as __maybe_unused to make it clear to clang that this
is expected, so there is no more warning.

Cc: Christian König <christian.koenig@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 3648994724c2..cba087e529c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -701,6 +701,7 @@ static void mmhub_v1_8_reset_ras_error_count(struct amdgpu_device *adev)
 		mmhub_v1_8_inst_reset_ras_error_count(adev, i);
 }
 
+__maybe_unused
 static const uint32_t mmhub_v1_8_mmea_err_status_reg[] = {
 	regMMEA0_ERR_STATUS,
 	regMMEA1_ERR_STATUS,
-- 
2.25.1

