Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BB9C77B7C
	for <amd-gfx@archiver.kernel.org>; Thu,  4 May 2023 15:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1261C10E168;
	Thu,  4 May 2023 15:51:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D169B10E170
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 May 2023 15:51:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwyPA0TdEJjyExR3GaK6GCD6Vh0QVdNB5q0Rvn0eukbRugZAyyOU82Ssjp92mIJxhxYMu/3xfLlOUArVEw8V9Sl5WSgcGkwOkM+Gd7WEfkuaU3WSzqY8deYCx8iFP1jiB7sTXRf496fz8DgUmlIARCP9UI5OA2CF4lzbLRk2brUNysYN5Q4TB4wfMiy7aYvzg8POcIs/yvOvP2UDrsaxIq061T57ArhP6v1BWi8GaH6Dfz7FKwfUmgHPz/Bg25Pa3uS+TL7giv5GrO5EukUhAJSStiTXsv1q/Rffj0K1uwtrYwri/3RfpB/CerH7Wtgfo2wAI/dV3IuN/cXGh/60CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9c2AMXFmgcg3Trl4dl+cHhqIDvI0KagsLARrJPhzDA=;
 b=TF7snzVwMraEp4zqnpRpBEKoJLbZ1UQvRsTggbLHpOMWQdNVQPHMjzkuALV11kh/onF0fnNSz+PBNqfGCeMs68AwTSyyMpjhcUHMLlI7RUpjOCVpp0eJgPUwPhL2Lrr7HfOdC/TguT3PQ15BNuD+v4GQ+BADiaRjKFxasQ0FMVPt6Hqpuqd/betyqiTyQqwItGbo5NsURXnT+HfwvvIthb/Dw81RlUwDy6chOl3TFe9bnHi34kCKSsy9EM834n05M/TRDMcHBL4JZwwlUh3CxbSchSsFBBVcbN42KSn9pE2vpuy3a26BJJg7FS1xfTRoEpD9Bww2+3CQMAhSHCNuzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9c2AMXFmgcg3Trl4dl+cHhqIDvI0KagsLARrJPhzDA=;
 b=bRPGQaFrHPCj/bzNqnnk0HLYV87loifN8q97Ab6XrM/gMU47P7+pAQCKwablRRTtb+1U0VzOZ3mbvUFoIRkAORQp1iL62RvCe3H+WklmcK/ahnU/FnCRykNbf4eEx5jVMS4qgHZMNwPNpqxHzTtwEMLHrN2vafjk3PUSH34P/CQ=
Received: from DM6PR12CA0003.namprd12.prod.outlook.com (2603:10b6:5:1c0::16)
 by SN7PR12MB7130.namprd12.prod.outlook.com (2603:10b6:806:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 15:51:03 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::59) by DM6PR12CA0003.outlook.office365.com
 (2603:10b6:5:1c0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26 via Frontend
 Transport; Thu, 4 May 2023 15:51:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.26 via Frontend Transport; Thu, 4 May 2023 15:51:03 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 4 May
 2023 10:50:58 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: change vm_inv_engs array based on new
 GFXHUB/MMHUB layout
Date: Thu, 4 May 2023 23:50:22 +0800
Message-ID: <20230504155023.1415369-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT063:EE_|SN7PR12MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: bcee2e13-47e2-4e98-4187-08db4cb75d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: evElgrZXqF6jtbqPVL0o5+ULJqZffRLKV/dGAqQ9IGud8SKvwr+jBEsZ0DQGxx3KLaZFghJzEPEUSAM0NaXuqeBPxWEB05gNFWxdrY20NZZYyfJiAk7RNT1J3KN+fOgu8e4z/n5Zz8Q5dh1PjprGnSUkbRgyHTi+Y0RDeBNvhRjzWMxeLSmCMIRzLi2DbLMP5hbrLh7XoRdWpps44jXe8Tn6RbWHBiXC98D7ZyK1Lqz1LdwxSXK89BnEYDaxk9E3axLglqycutOgMjW3AwXlvJS5NhgfZ7Rtk6xkgavCANbk27PPbPf/auTMr0r/ztZkhz4VIS6NScOk6SR9XvQqykADYEWTNKrAZNIVDeOFOPDNAotEbxZn7+lW9pXOu9soQmIP62A0wFa1ng4nxCvEnAXYqVijuJbVwIE9kFu9XTDC6dSFAarzMuhSQrouy3T38QcA8l4SwBjFWAi7/ZFB3pd6GDvKUjRzXUnuonJo2lY/EQTByDO0vAtBtpcKMNBgrlXS+iMRadvBGYdiVwG4e+lshOFETsK4psV/HsQ1Vcx1qYWwQUppWtaPdHD2CcTEy8d0OUkQYBzNFwFisx17DfN00JJ7MGwwtJW1H5/505IwMooyl5Wn6cZlN2BK/d8Icb7EFacE5mccJuIgty37JUitiq9mX9xPykE14gySKai/kQJLgPnCuZjezeNFFlOCt/iiTZtQ5me6pk8IW75DzaGo+tx1llH20wX0SQmz1Wc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(478600001)(81166007)(356005)(40480700001)(82740400003)(8936002)(8676002)(5660300002)(40460700003)(2616005)(54906003)(82310400005)(1076003)(26005)(6666004)(86362001)(47076005)(70206006)(70586007)(336012)(7696005)(83380400001)(6916009)(426003)(4326008)(316002)(41300700001)(186003)(16526019)(2906002)(36756003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 15:51:03.4540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcee2e13-47e2-4e98-4187-08db4cb75d8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7130
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
Cc: Alexander.Deucher@amd.com, le.ma@amd.com,
 Yifan Zhang <yifan1.zhang@amd.com>, christian.koenig@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

vm_inv_engs should be changd accordingly.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 8c8a2f37ba33..eeaa8d215801 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -539,12 +539,14 @@ void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
 int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring;
-	unsigned vm_inv_engs[AMDGPU_MAX_VMHUBS] =
-		{GFXHUB_FREE_VM_INV_ENGS_BITMAP, MMHUB_FREE_VM_INV_ENGS_BITMAP,
-		GFXHUB_FREE_VM_INV_ENGS_BITMAP};
+	unsigned vm_inv_engs[AMDGPU_MAX_VMHUBS];
 	unsigned i;
 	unsigned vmhub, inv_eng;
 
+	vm_inv_engs[AMDGPU_GFXHUB(0)] = GFXHUB_FREE_VM_INV_ENGS_BITMAP;
+	vm_inv_engs[AMDGPU_GFXHUB(1)] = GFXHUB_FREE_VM_INV_ENGS_BITMAP;
+	vm_inv_engs[AMDGPU_MMHUB0(0)] = MMHUB_FREE_VM_INV_ENGS_BITMAP;
+
 	if (adev->enable_mes) {
 		/* reserve engine 5 for firmware */
 		for (vmhub = 0; vmhub < AMDGPU_MAX_VMHUBS; vmhub++)
-- 
2.37.3

