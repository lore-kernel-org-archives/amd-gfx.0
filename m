Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEF2C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E2161168
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 30E2161168
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E35D6EA36;
	Tue, 21 Sep 2021 18:07:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B1B26EA1E
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJJMZ1HmvCIRPOVaAIweoc9maKP5IxcWCf+Uoy7mqv8W7Or0V5VcK0xJ/G3KiJkFWiwlAyE2vc3lFakdMW7SpVRGkMmhtP/b5YLd/6qzGoyTzxdRDgtYaIZgGanN7bdwEvF6OHitYjq1SotT06TGOwHSG2AuexqvIZC57FOygLIFjL12MAWzga/dSsm6AD8A98C8kUF/HBeJZ/ybyKNgklwiUyDO1d0bdYqT+VtinklZYKR5vXtbePV75j+z4yDVCh4ga6vux5Hk0zWmo1imvbPMWWGVkrHdScK3lT037yaUsK3qDVJwkxMea9TCbWRkxLcjVnzuFMSDUnMpnmubIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=rf0pofDiFN9nBp6KYGRlAD0GlqmnRGrQXWrbrEyUgaM=;
 b=dHMukJp7LTo5lP49dEdYOGEaj48wwCswam91P3eP7ySyTKcYLA3aT8oYV3zyGMxowyZTSwajXGwsWnaSsGWuTPQ+OIaLG85m/zLT59n2UQZ7TYkOWYG7P9gTq6aikz6dtGfHP9NHVZbhNi62ijW509HKxuBuTNMdbDHpDQRtIqPrDWuYNo5eXmG4fn/30x8t6G60XbEQpd6QbWJhCdfuyjW2llQdx+dnM/i6ZyxdATPAuHVVDNgIJfbBucPA3e7tMugC+zH7qE4rmhSj+eex4/3raxfi7vOcl+LpLzKBS5eHHGJZV/tfUzB4G346abh+empavcJef7x+XdnunKsNDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rf0pofDiFN9nBp6KYGRlAD0GlqmnRGrQXWrbrEyUgaM=;
 b=J4xdgy9m/PmJNCVzY8lySjvddX7Altk4mWJql4940BcW+8aJGin8a+zpUIo4xKzPxE22xJMr2strT1h8tfOx1si1XIOSXKw5OMxJbzPsfih3nFwKTxJC5MT5NEzTK+On7sZOD1OLCR0XkgEieClngAAJLpGJeIy49HT41EjJePY=
Received: from DM5PR11CA0018.namprd11.prod.outlook.com (2603:10b6:3:115::28)
 by DM5PR12MB1625.namprd12.prod.outlook.com (2603:10b6:4:b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.16; Tue, 21 Sep 2021 18:07:44 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::f3) by DM5PR11CA0018.outlook.office365.com
 (2603:10b6:3:115::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/66] drm/amdgpu/nv: export common IP functions
Date: Tue, 21 Sep 2021 14:06:25 -0400
Message-ID: <20210921180725.1985552-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 153f2ad6-6899-4f5f-40d1-08d97d2ab5ae
X-MS-TrafficTypeDiagnostic: DM5PR12MB1625:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1625D3BDA631952346F37486F7A19@DM5PR12MB1625.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:254;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OY8mqKOlIWzT3PAhmCUfN+a1QktiuJmZC22byxT+KR2P6pGcZa1suG0Yb2oGsfOvj+YYBkcF/zehhj1Yxw1w5HAVpOKvDeK+7Tzn1ZxCCvXex16gWjLRZeRHv/4uiZwkXVez96acyvvwdhOXtblGOIqPZM8Pq+Su1eQmKonLBPASUF+lKZ++Dz3YXpd8J8wo8BcYScoRXPpBN1XJfZ66B2Ft2Z3994FF+FVhiTB+3lNpzD2X+aAz/oTFD4JtT9XJFp3S52GcYErtAYLzfclfRFcml3SxKR/IlYbo1RPy9YfH7QofbX8wF3mdpSaRPhqc9GXiFzLFHQNpS4DrLhnQMh5ZNC4Y/zQSdUrbKF8kNhebM4oKRdOBtXGCBxK1rKeS+dD5BzHAsx4DNB9KLWg28rUiCKXy4yGGT2GYvvjeeHk4Hp0BTZ9ztAcmqUgLnmbq2WrT3LeqdJ4w8pdCnDImTWCawc702aS8yOXzzsHnEBam/iV8zt5aQZioE2Q22t7fhFyJ316eXV9vPNjttOlJap9L0qijTRtPK4xRZifXhtqA13r2Z13XDokxWVVDsNjRHYjlqYJOHK2ZLbowyvlOvpLAWJnSPxqU2m2KzEJGLhuTJTWlvz4X2JYcv3T8krK5WFOFTNl4OpkmQ9SlBp1dIP8+damPzCA8o1pefFZ0jmko37zXeqY7rcmiT9FuS04Ca4APv2LY5CgmStJNLssg8YKTN+c69X2+eADYhMU8xP8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2906002)(70206006)(47076005)(83380400001)(316002)(8676002)(70586007)(8936002)(36756003)(356005)(1076003)(336012)(6666004)(508600001)(2616005)(426003)(81166007)(6916009)(86362001)(16526019)(26005)(186003)(36860700001)(5660300002)(7696005)(4326008)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:43.9040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 153f2ad6-6899-4f5f-40d1-08d97d2ab5ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1625
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

So they can be driven by IP dicovery table.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/nv.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 726975caf4be..0dc390a7509f 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -599,7 +599,7 @@ static void nv_enable_doorbell_aperture(struct amdgpu_device *adev,
 	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
 }
 
-static const struct amdgpu_ip_block_version nv_common_ip_block =
+const struct amdgpu_ip_block_version nv_common_ip_block =
 {
 	.type = AMD_IP_BLOCK_TYPE_COMMON,
 	.major = 1,
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amdgpu/nv.h
index 1f40ba3b0460..7df2f85bbcd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/nv.h
@@ -26,6 +26,8 @@
 
 #include "nbio_v2_3.h"
 
+extern const struct amdgpu_ip_block_version nv_common_ip_block;
+
 void nv_grbm_select(struct amdgpu_device *adev,
 		    u32 me, u32 pipe, u32 queue, u32 vmid);
 void nv_set_virt_ops(struct amdgpu_device *adev);
-- 
2.31.1

