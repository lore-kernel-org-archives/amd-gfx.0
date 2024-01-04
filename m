Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5F6C3DA6E
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 02:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 057B910E2EC;
	Thu,  4 Jan 2024 02:32:30 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B828710E2EC
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 02:32:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nARsacm/lK1dN6GQYICYFfNNiXZu85VAV5kUoQD4Uq5Fih9I6ftgRSbmxTQwon9U2mfjDF2bPuMp7tARz63rbdc7k1L9/ZT86OZS9AAusf3N+P8BrTvqoR+pOWmeh07Haw3ebhgWMFgUymXDzRYyFQlzgghto+oJRtVaqQLlOyDAIu1I8dRV/OO6uPdpw3UnjHcGU8Fahwyf9sBsnq8P1p9pPPXCMyAM2t9WKTiQ5kLsgbhvp0zXV8/E8xQE+u2XbU4nrBoDYYPhU7fu9J7PufYhRCvgP4hmiavOTTUVzF9E5XvxqBbQc7NLEsbQM3sigOWhPw3ZK7fuveVkq/9Qww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aONzj9+Ltg1J7rTrvPOqfBzmyhIjEjl9L213aGWSpO8=;
 b=jEgP9jxuPLXFzeKUkdpHO+dGtRCffDvNcDgBVfMiLtwV3fCXu5XMrf3hpJJvE8UunuOd607kL8sCilcchnZRUc/Vy+9kyvrnmHPuesNWZmT3oBD1kf6EqWKTxcjlJr9WqcCygz+tQj3aqXiqr6aGPgY9dy++HnLV8/5iC4kz6Sw51d6saSh+zlU+V99ZSOE7X2pYDdrmCwDasTxAUTifIcHjCw1nyd26SODbKkwCk0UxGyidnl3/xjOjrK5wcZNjMABO/nzDW86mtjuQl542+HQrdYYYFDDuogtJwJdaQoZZN2p+aVrmQBwcsV6tSDKrdoCSSbFxQRO/5dBCMIRnNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aONzj9+Ltg1J7rTrvPOqfBzmyhIjEjl9L213aGWSpO8=;
 b=bSk54upEAdD9GohvGs4sSeHCyeAhuY76weaZeiQYl7wWoD7wT9LcSDZnGWUuEWXkborYPVhdEL0PKMr0vloBEaBcTagpiVBgvreX5W8dPZnIh5gn21UmPidwQK5VxV8rRcWsOffJgkCwZAm+f4D5qSNLtfw6coLUgr/Gl2f0j8U=
Received: from DS7PR03CA0214.namprd03.prod.outlook.com (2603:10b6:5:3ba::9) by
 BN9PR12MB5145.namprd12.prod.outlook.com (2603:10b6:408:136::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 02:32:22 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:3ba:cafe::94) by DS7PR03CA0214.outlook.office365.com
 (2603:10b6:5:3ba::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Thu, 4 Jan 2024 02:32:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 02:32:22 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 3 Jan 2024 20:32:19 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Fix variable 'mca_funcs' dereferenced before NULL
 check in 'amdgpu_mca_smu_get_mca_entry()'
Date: Thu, 4 Jan 2024 08:01:38 +0530
Message-ID: <20240104023138.2226002-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|BN9PR12MB5145:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b3a2e01-da01-4190-e8b1-08dc0ccd6179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OEg1PZSm/Dki1Tuq71jeYOiKaESZ1RSPUBR/pMCOXHPVKz1BHb0apVgC26maFhXD4ESNxdIZ9gbMvSnGc1ukWvWoyjM4lhQ207QMsQ6rLGh7U/ItKzHa/0xSD4+D0nJnT8QJQbPDxgMIhRg81xNhhDyNkdX4oCExkVYcqfq7KziImkYnPDXl9WZ7AegruWZnLlGVpov/SU5KH0i5ey1SfE/BzPOaoUUHVs0S7wpPK29I+WNubXNZNRW6GXlsXxg9QvWpcoQdWCkivhW/KLQTkpZXeOso7MCEsbKUMnxri9ss6xs1cP2L2EPUNAiMrod6pcmM/f49stw5pSI+GXvRQ2fO4sKP5iuRKLiuFdZ+Oh39F0svXeLpCcO4OMwNefMzjIElQQ+CQ/U4saHJ3kNYMuIf75k1qevmohLlf47GHiAcGzSvpVbIpFm47g++i9m8llRoxVfxLIiQEkOCdnS3JXx7PJbps0CeB0NbUz8pNVfBVP3UYuV+QF8rYd75temvuALkHRSi+9D07zaJcEp56evc3HoQBpU9NEHhQzSTzPpvxrpgovsqehr6VwPdiBqzMSg/emWazmgjECvFLdAIq5u0j/zj0shY1fLLwyCQP5ZcNS8PSi2NycP2PoviHui7pueYFsfxq1/DyuYan3KRuCJCvqQ+ybUrAE/bhKdD0iGfjbaQAbqfeYfQ275ZZ29YBsrmt+biOUyjGVyMoSmBbSoRUoppbg/My2v7ED4Ldp3BrRzfxCr8uVG1/NrMwpDN/qcTEWC3KbUoVdqS/buSzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(2906002)(82740400003)(44832011)(5660300002)(356005)(81166007)(36756003)(26005)(1076003)(16526019)(426003)(336012)(66574015)(478600001)(2616005)(6636002)(70206006)(83380400001)(70586007)(40460700003)(40480700001)(41300700001)(6666004)(86362001)(7696005)(8676002)(8936002)(4326008)(47076005)(110136005)(54906003)(316002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 02:32:22.1257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3a2e01-da01-4190-e8b1-08dc0ccd6179
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5145
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
 Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org, Hawking
 Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the below:

drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c:377 amdgpu_mca_smu_get_mca_entry() warn: variable dereferenced before check 'mca_funcs' (see line 368)

357 int amdgpu_mca_smu_get_mca_entry(struct amdgpu_device *adev, 
				     enum amdgpu_mca_error_type type,
358                                  int idx, struct mca_bank_entry *entry)
359 {
360         const struct amdgpu_mca_smu_funcs *mca_funcs =
						adev->mca.mca_funcs;
361         int count;
362
363         switch (type) {
364         case AMDGPU_MCA_ERROR_TYPE_UE:
365                 count = mca_funcs->max_ue_count;

mca_funcs is dereferenced here.

366                 break;
367         case AMDGPU_MCA_ERROR_TYPE_CE:
368                 count = mca_funcs->max_ce_count;

mca_funcs is dereferenced here.

369                 break;
370         default:
371                 return -EINVAL;
372         }
373
374         if (idx >= count)
375                 return -EINVAL;
376
377         if (mca_funcs && mca_funcs->mca_get_mca_entry)
	        ^^^^^^^^^

Checked too late!

Cc: Yang Wang <kevinyang.wang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 8911310f98df..18790d5c96c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -360,6 +360,9 @@ int amdgpu_mca_smu_get_mca_entry(struct amdgpu_device *adev, enum amdgpu_mca_err
 	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
 	int count;
 
+	if (!mca_funcs || !mca_funcs->mca_get_mca_entry)
+		return -EOPNOTSUPP;
+
 	switch (type) {
 	case AMDGPU_MCA_ERROR_TYPE_UE:
 		count = mca_funcs->max_ue_count;
@@ -374,7 +377,7 @@ int amdgpu_mca_smu_get_mca_entry(struct amdgpu_device *adev, enum amdgpu_mca_err
 	if (idx >= count)
 		return -EINVAL;
 
-	if (mca_funcs && mca_funcs->mca_get_mca_entry)
+	if (mca_funcs->mca_get_mca_entry)
 		return mca_funcs->mca_get_mca_entry(adev, type, idx, entry);
 
 	return -EOPNOTSUPP;
-- 
2.34.1

