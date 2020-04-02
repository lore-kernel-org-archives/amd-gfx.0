Return-Path: <SRS0=ZYFY=5S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853F3C43331
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 05:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A4320784
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 05:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uNIGtUf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A4320784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A88846E9C9;
	Thu,  2 Apr 2020 05:39:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5956B6E9C9
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2020 05:39:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZODEQqSZmmX86Smg+J6txEEAqiVj3Xe5ZuFNDwZMfTHsvzXk/1j54HlOCZf8JyKfvLkx8qjMv34qxlAjToRoUryhUZk9vMiFhY1C5q/yJ16l8ZVF9Rpz0T90w7ygCcfGRtFmi2Z3lK7QZPZD9tKEFObv8JW1s26t6CpZes+VvKNRE3X6myN5r2wJEuP5G7+u+ScSihThoVGx+SiP9kxEPyFyPU9c+GP2q3IjapwrFVIemdKfe+LcoZPacOLoOD8qWch53XCvStopmVF5nKcJp23Dlz8YiI34/wFlt5nDPxteUzcLnZSnmp16yiDXPKt2/nvDNV15NUzXYjuU4LLTLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgLtZd7KbXhrPbF8kXkfupRkMPK1Id//GoBmsU9XJRU=;
 b=nKEMGGnCHX6aC+PxO88qnZ+yuAbV3MLR2k3xX64kwirHJyZxNJl7X5NTty401++2uH6UKryS7M3lvrlmUAjq8Cto/pK6oek+y5EJODQrPVnPokIf/IV67foVSs/fljSe5qk55k7brxQTQsyaGIH+El1/pNVPobVob7OumLtNClux0qcpKhirWlemaLTbYLXDMDhoHH82UrTLt/e9dXbaQCnWDc7QByVr2oIobVbTbHyOYDOHIqtVtvYWNDY0cBnJqVBII6Du+YV76IuHjOwKkSPNPCe/iS21NHEVE8bpkTCXn3UQQMP6xrkKkCdXhkbyJRpgCQDesLHu69+TNKYvSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgLtZd7KbXhrPbF8kXkfupRkMPK1Id//GoBmsU9XJRU=;
 b=uNIGtUf81wb/mLRV2Tg93s4qmBmc1E/fqSFRMkmxIXK4vSmc+FBImnY8YGNny+9HMZDdgUhF4rtOs1G3Z5O3kl+wcxneOmNqZHIVQddF+3zFoXeaqpb60k22WQu9d4tRt2m2oG6oWOhz1xiTUbUeFEfSEpor09wyArYpuDKG3hg=
Received: from MN2PR17CA0022.namprd17.prod.outlook.com (2603:10b6:208:15e::35)
 by DM5PR12MB1419.namprd12.prod.outlook.com (2603:10b6:3:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Thu, 2 Apr
 2020 05:39:49 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:15e:cafe::dd) by MN2PR17CA0022.outlook.office365.com
 (2603:10b6:208:15e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Thu, 2 Apr 2020 05:39:49 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2878.15 via Frontend Transport; Thu, 2 Apr 2020 05:39:49 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 2 Apr 2020
 00:39:48 -0500
Received: from gamma.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 2 Apr 2020 00:39:47 -0500
From: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/powerplay: determine pm_en at amd_powerplay_create
Date: Thu, 2 Apr 2020 13:39:34 +0800
Message-ID: <20200402053934.28834-1-Tiecheng.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(396003)(428003)(46966005)(26005)(186003)(6916009)(5660300002)(2906002)(426003)(478600001)(7696005)(70206006)(82740400003)(336012)(2616005)(70586007)(47076004)(8676002)(86362001)(1076003)(36756003)(316002)(4326008)(6666004)(81156014)(356004)(8936002)(81166006);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d970ec9f-e030-45f1-989c-08d7d6c842a8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1419:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1419A8BF286F96C12D67069BE4C60@DM5PR12MB1419.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 0361212EA8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7fQvl0W4t9qIemKxXqvSVjrOOG3GKBnXmcuBuu7pUG7N0ZqWsT6GmaHGOFpaW7iIH8H6CCrm/6QW63TRymxWo3vaujwSPY/WwN6wLXi86fv0+ByI0XbfT+f/lhpkkoXRGDIq85Pj1/WogIbWfsWz6Rr15yjICXbUwp0MsUlwYObE2sWsLQ24zxBWGiV2YcFxjJ6fzB9/TVMRP15gVCujkZRDxhlI39sEaKZCyWyq1sHCSibmov7YtUdS2D2MW5nld65RpwibKmHWqA73ZkZ6UQ1pSvq5LOsNKYqE12SJn5r2FBm1HlzhXWNBY9HCrUeEsIR1EbzSfxd0xG30iYvITDTM39JAoRyb6vs23GRuvhx4YwoSdU2mQqz4rxoPtWxhzxi1aO5ZMXjd0vTlk1+c5u3ft+V80GEYzYheQPqhoVexTFZQrts3U0sNGz9bjkFubJkME2SEbjCJZd+9rnwGtYNOFgrYH9APdrQ2OXBi/rHcILPU3F+vH4EU9WYq6Nfn5yeIzNKueKRn6Yg3dBs2oA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 05:39:49.5933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d970ec9f-e030-45f1-989c-08d7d6c842a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1419
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
Cc: Tiecheng.Zhou@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Need to determine pm_en at amd_powerplay_create of early_init stage.

Signed-off-by: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 3 +++
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c   | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index 71b843f542d8..a37dc37dfe49 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -48,6 +48,9 @@ static int amd_powerplay_create(struct amdgpu_device *adev)
 
 	hwmgr->adev = adev;
 	hwmgr->not_vf = !amdgpu_sriov_vf(adev);
+	hwmgr->pp_one_vf = amdgpu_sriov_is_pp_one_vf(adev);
+	hwmgr->pm_en = (amdgpu_dpm && (hwmgr->not_vf || hwmgr->pp_one_vf))
+				? true : false;
 	hwmgr->device = amdgpu_cgs_create_device(adev);
 	mutex_init(&hwmgr->smu_lock);
 	mutex_init(&hwmgr->msg_lock);
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
index f48fdc7f0382..7aee382fc1f9 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
@@ -221,9 +221,6 @@ int hwmgr_hw_init(struct pp_hwmgr *hwmgr)
 {
 	int ret = 0;
 
-	hwmgr->pp_one_vf = amdgpu_sriov_is_pp_one_vf((struct amdgpu_device *)hwmgr->adev);
-	hwmgr->pm_en = (amdgpu_dpm && (hwmgr->not_vf || hwmgr->pp_one_vf))
-			? true : false;
 	if (!hwmgr->pm_en)
 		return 0;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
