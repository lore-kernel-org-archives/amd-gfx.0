Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B89C77B75
	for <amd-gfx@archiver.kernel.org>; Fri,  5 May 2023 05:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96B4710E569;
	Fri,  5 May 2023 05:29:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D761010E569
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 May 2023 05:29:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MS0kFsviQFVsJ5vjPpbjK1umysNJClEtbcSKcpmr5sYRgpJDD05nI24LhwA0nWLyAwJNyVOul5Z3VtilOb2jw8NaQht3Gk7j/tC0bnKEICSICiuodYJ11XQYwUFCL6e/6OuRhml1ejE6uu3EMSIInc/5zaNUjCgspDoyBBO/CrjLTxImHB8nywni+QJ97WMymKr6e4A3aMzySkRSvWrHSbwV7HP6OrKFLn6Vf02SronvPYZbZZ4MK3P0Eg3UArJL0dXEeyTniH/lZIh/kOmBTbHnFssYI6q0OJzTRfzYENFO1HJ+bsqVPjsD7p7Z/vc8sM+y4p+D0EK80sVMX2SAQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRrrFrzXXLduZMcsC/P+9uF0XfyooF66dVhFllSxAEk=;
 b=SyPuyv3EFFJTncHo46NBJnEf6fIXoFnY4uc7HDR41i48GRpxHmanAz7oPiqDn7mS5IzrmgHuUglwwBLreOhL1BC9WfLDStLgPWx6To8UjjC/ejdqs9hN/jFtUY+IjKLKNzCHHvO0GBwQP8DOpSCruVh64BQgzWF3wIjDNtoy6+mL5hOJmTL90gT47lVr4Cpg3O/9jVGHFhZJm/nDBdZE+y8oBkqG6w2Da7bdJGI7D2F/43XKyecXSNQg3v1DL/m1Q3Xn3v5ue2HWFZWTyFAgVs1SiNaulz7C4PiV/0gFQFFbiFDbfadAsx2LpmRD6W+LKybnWycrWAiS9U2/8skiJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRrrFrzXXLduZMcsC/P+9uF0XfyooF66dVhFllSxAEk=;
 b=GRpbrf1F80MP5mzIecx03LbZ48UnY2Txrl/aIR2snjLIKhIw2l8KuXvtblaOb+xoqfOlLO4GOLL/LFgMJ6nxWzRqL77t2CXMF3gNIKMtHp1nt2otTZfHU1zcVu7P8LsPYVg9d04U4V05RBSziMplP00FCbRn3pRuxhguIJIAmK4=
Received: from DM6PR17CA0026.namprd17.prod.outlook.com (2603:10b6:5:1b3::39)
 by SA1PR12MB8644.namprd12.prod.outlook.com (2603:10b6:806:384::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Fri, 5 May
 2023 05:29:36 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::57) by DM6PR17CA0026.outlook.office365.com
 (2603:10b6:5:1b3::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27 via Frontend
 Transport; Fri, 5 May 2023 05:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.27 via Frontend Transport; Fri, 5 May 2023 05:29:35 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 5 May
 2023 00:29:31 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: alloc vm inv engines for every vmhub
Date: Fri, 5 May 2023 13:28:44 +0800
Message-ID: <20230505052846.1489935-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230505052846.1489935-1-yifan1.zhang@amd.com>
References: <20230505052846.1489935-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT038:EE_|SA1PR12MB8644:EE_
X-MS-Office365-Filtering-Correlation-Id: 21efb0bd-d4c3-4226-e873-08db4d29b6e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GKo2C+DgCOj8ZqU7pF4p68deh/b5FWxf3uNcW3i46cShIwpWmWeq+YYFbBAtxjcON+bsDw9bhPRtZEf/lWQju0uE165YTMKIosAQYMYY7cQOJvWM3RcK256sMATq7AM3rRv5+chiNmKN5GN6m/pkbrXSfjbUz1A85ybWtBo0pobsMBYTKKGtnmE9fHoil2azW6OegYljEwitX/+Wdi6hUnLd9PlDQ44e8mpQqkbxKBTyTiJKoxvcUngxzUc9DhTRd5xNTEXPuhB7F9qhanQ6MgbJTQ8MjffxMgoFHeenT6YJeKzhN0tb+hqbP5A6XgtYwkrs5KAktQST1fZxAz7K2nW1O6ZnszZQbJr73OLzNHcEkN30pD8rwVj2DB4Nr7fU40X4R6Er6fNMSFZmZHv9TVUSzEWmq49WARVHOJ2kziUOm4Rzl6ldLjrQdyh6SkBN2+jAYfU+sNI0aIdsbDfuHpNKGc1jWcgWG3uMWFlojCd7RXrDmMakSIMASFpwkGCi3OdT/UbS0OWPEbxKhiqCrjkUdav2uHtGCIaf9LT8bW7l6C6mRX8kmAwJrjHm43cbDDWMggfh10VeiCy9AeC/y/KD6QUPOp7MA7WOqaiCCameCcjbGt4JTt1AMDPwwqGA7D/wDJIc8w57PBgBp7MvlrHneSedpYYwesP40Uzqr6mskJtpR/c/lM/pMGoskyoEZauJp947Zl8TTk07zqE71zZZvzDE4KmXRd2Wilq6f1Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(2906002)(8936002)(6916009)(70206006)(4326008)(8676002)(316002)(70586007)(54906003)(41300700001)(478600001)(6666004)(7696005)(83380400001)(5660300002)(336012)(26005)(1076003)(40460700003)(82740400003)(47076005)(426003)(186003)(36860700001)(40480700001)(2616005)(36756003)(86362001)(16526019)(82310400005)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 05:29:35.9663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21efb0bd-d4c3-4226-e873-08db4d29b6e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8644
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>, Lijo.Lazar@amd.com,
 Shiwu Zhang <shiwu.zhang@amd.com>, Le Ma <Le.Ma@amd.com>,
 Alexander.Deucher@amd.com, Christian Koenig <Christian.Koenig@amd.com>,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shiwu Zhang <shiwu.zhang@amd.com>

There are AMDGPU_MAX_VMHUBS of vmhub in maximum and need to init the
vm_inv_engs for all of them.

In this way, the below error can be ruled out.
[  217.317752] amdgpu 0000:02:00.0: amdgpu: no VM inv eng for ring sdma0

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Christian Koenig <Christian.Koenig@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 8c8a2f37ba33..a4ba2c50a5c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -533,18 +533,19 @@ void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
 	 *                    subject to change when ring number changes
 	 * Engine 17: Gart flushes
 	 */
-#define GFXHUB_FREE_VM_INV_ENGS_BITMAP		0x1FFF3
-#define MMHUB_FREE_VM_INV_ENGS_BITMAP		0x1FFF3
+#define AMDGPU_VMHUB_INV_ENG_BITMAP		0x1FFF3
 
 int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring;
-	unsigned vm_inv_engs[AMDGPU_MAX_VMHUBS] =
-		{GFXHUB_FREE_VM_INV_ENGS_BITMAP, MMHUB_FREE_VM_INV_ENGS_BITMAP,
-		GFXHUB_FREE_VM_INV_ENGS_BITMAP};
+	unsigned vm_inv_engs[AMDGPU_MAX_VMHUBS] = {0};
 	unsigned i;
 	unsigned vmhub, inv_eng;
 
+	/* init the vm inv eng for all vmhubs */
+	for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
+		vm_inv_engs[i] = AMDGPU_VMHUB_INV_ENG_BITMAP;
+
 	if (adev->enable_mes) {
 		/* reserve engine 5 for firmware */
 		for (vmhub = 0; vmhub < AMDGPU_MAX_VMHUBS; vmhub++)
-- 
2.37.3

