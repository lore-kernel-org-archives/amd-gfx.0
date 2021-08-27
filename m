Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721FEC432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 01:29:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA8760EFE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 01:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2AA8760EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11FF06E8A3;
	Fri, 27 Aug 2021 01:29:28 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62A036E045
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 01:29:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCHaXsoFr9/dDKaJhDOc2EGX3ZFMZZof7yrZrcWyQSRZogd94sivKOIajLoxFHTD7cPCTiHSbXju9Ub4CptVX/uZ47dMAGrp/q5O0DZg7mXe2pdfeZ0d0Mz+oZzYi4cIRp+KL9rcjaC/9w5KZvKiK3EW0kSQ7lOxDrL429P6oWZUMzP+9x8By1AAuhCniWQ3MziTzKaxL7QziBuQl2/oaXGG17gc/FZXmusFWsMpxBhRSjsnf9zPS7F3zd4FRA1VOBMWgNuTVC4uf/g8fpvFxn7+uK7bxD57Arwi3ATBZteCL7/SHE65u92lbG6Vrt4UJH9UfS42JNAgiaxFPF3xyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTE+xX76Hp/O0qkAd+fWiG2R1JcmnCOvUVO7P+S8q7s=;
 b=QYOYba3QDVdsv7CDKV8QRGKGCZh+7eLm5yLvVHZd+RGTBIN2Y/PggwIzGAGGBOAJFKYRLMHkDhqLBkfNkLz9a03S0oL1pTzk/GTqnG2piit4HIMDPaURyhQHDthRi/QLw5hSofe5ZRywTUZCAWq9dsXIHykWd6XPHrL6i58frv8rwmBKhiqXRWjZJk5oHD0O9lEopEmx9t8hwdqw0u+vTwdl2l6aMS83/Jf8pahXqTg73z+M81OPpgUNuxFRYJaJDVpjH+nnDIqS3ua0CXl2x8FA67pSvboyVvF0xfGhQRA8523zgJMxMVgC/ll3etJ1t/qabpY3rNLwh6h4IGYRow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTE+xX76Hp/O0qkAd+fWiG2R1JcmnCOvUVO7P+S8q7s=;
 b=znl6CtyNuLloLL4of8VtVVclYmGFPDEaXYe2+OJO9g8sHAabP1SUWGOAE7mgqJjlwUNldEDOkDVsZ4CJ1zbmMNSbKeuFCD3Ln+MOLnqtDGRjoqeEToqCYv5I3jT/2cGZoaOirQaNNkyopaWJ3FHYJu3qCkUuiEMMi6ZLHpyHgnk=
Received: from CO2PR06CA0071.namprd06.prod.outlook.com (2603:10b6:104:3::29)
 by DM4PR12MB5101.namprd12.prod.outlook.com (2603:10b6:5:390::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Fri, 27 Aug
 2021 01:29:25 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::19) by CO2PR06CA0071.outlook.office365.com
 (2603:10b6:104:3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend
 Transport; Fri, 27 Aug 2021 01:29:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 01:29:24 +0000
Received: from aaliu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 26 Aug
 2021 20:29:22 -0500
From: Aaron Liu <aaron.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Ray.Huang@amd.com>,
 <nicholas.kazlauskas@amd.com>, Aaron Liu <aaron.liu@amd.com>
Subject: [PATCH 2/2] drm/amd/display: setup system context for APUs
Date: Fri, 27 Aug 2021 09:29:07 +0800
Message-ID: <20210827012907.2348995-2-aaron.liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210827012907.2348995-1-aaron.liu@amd.com>
References: <20210827012907.2348995-1-aaron.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d14a2d14-405b-47ef-bbf4-08d968fa1ad0
X-MS-TrafficTypeDiagnostic: DM4PR12MB5101:
X-Microsoft-Antispam-PRVS: <DM4PR12MB51013F5C079A32311255579BF0C89@DM4PR12MB5101.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WcxqlItJR3l+JRtXW0v5ScjtGgXdbRKan5fyopVIlif41nUX03f1XFmBbTdR+V71en+6n5M2tAN++exESlyxD5c+gDHV6Z/Hc9kTqDG3qRjUct6iX5bUO7fVsHogfWuIYT5IvSM/5E50SIDzO1JNekS1vUjQbYiEmkEy40KlYFwI/3ihjj8gV2IawPl8kn3PkxUEVpfZ5itUHWOctWt/xNTaNa7MiYQ/AEDGUVj+Gg5wvS0lvYON3breroYOBjYvMwBUeYEoSZSxVjiq/nBVpttDCxaJRnruKeiOLBjFxr/ZhdMv5pJ281Vhv76HC0tUIxVZ95008YK5jZH2y3+oDiD8ZX7UVWWgc3CsP+jqpI6BJjBM3DMOG9fsRt7YyQ+CukJBODyogwCgW/vRrlz7VQSZmI5RWzUyvJIC2mmtHUfPHJW1zc1ExdRHT5LawSxkpxAP/oA4hynEkrTUfQg1Ila8cWixIEzM5ArPmgoN3q68MouyKcY0RZY4GuKC57gq0/5rwYzHGEZGs4ITN6WkL3nWivryGiZlmOp88n68kvJbKLOZS1dmgBVSR3pYvrAOqEqHaf7fq/xGCMKIlM/VU8jAPW58NGPrRVophCfRs2skiKwgahcam7e8H5W3EIKH2WaenQb5PDZ5BvkuW4j7NGeSZ7GBYy7Q+e0H+fGu1aXI8lA2aBr3J+TMl8paCaiHjRbE0Hr1TvQbYyuRqXiC5QytAx82HBM1+O0KW4sJM4A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966006)(36840700001)(86362001)(81166007)(6916009)(70586007)(2616005)(4326008)(316002)(2906002)(6666004)(54906003)(8676002)(44832011)(70206006)(426003)(36756003)(36860700001)(356005)(186003)(26005)(4744005)(336012)(7696005)(82740400003)(83380400001)(478600001)(47076005)(5660300002)(1076003)(8936002)(82310400003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 01:29:24.8926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d14a2d14-405b-47ef-bbf4-08d968fa1ad0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5101
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

Scatter/gather is APU feature starting from carrizo.
adev->apu_flags is not used for all APUs.
adev->flags & AMD_IS_APU can be used for all APUs.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e1e57e7465a7..7f311bba9735 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1327,7 +1327,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	dc_hardware_init(adev->dm.dc);
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-	if (adev->apu_flags) {
+	if ((adev->flags & AMD_IS_APU) && (adev->asic_type >= CHIP_CARRIZO)) {
 		struct dc_phy_addr_space_config pa_config;
 
 		mmhub_read_system_context(adev, &pa_config);
-- 
2.25.1

