Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44C4C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78E0710E0CE;
	Tue,  3 May 2022 20:38:50 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2074.outbound.protection.outlook.com [40.107.100.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B4EF10E0CE
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:38:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctrie4HgGXduXgRUalRlCC+al+sqt/SFepI8mHIRmIckpv0twVmAOhwgLQh9/POpjMBZzR67xB+2lP6MB5BtJF1TKkJTamAVUXwK8s3r1HCHuwDYlwhu3iMvaYUrhxKBluICvBji6oR938s63P4/6gV/qFUD237RuKZE3u0jAxD2k7MQycR2rIi6g8kiAxmFkpbAAfcLG/tgAuR9/sQrQszuBp/TcsyyColK7eeNKL48FKxogliSJ3JkkliyD69tPhUaEMNXwDlur/36Y5K985dPCFxNsfJ2qDanszZOd8hmdZGq650VrlowA6LLlAsD0oRYAVZWvx5L0MeO2oh7qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzUOVWIpi6zNM+96WWB1S7SO6TLR0LhXUeTCkWiaxGo=;
 b=SaAfFT57kHrCqjsTnDhhwjg7TY0aDT5aSHoEs5+30H4Ur/UfggX3LaB0oEAdWUDeyCF8CjVi0Wopl5AsxhJz4QzhTB8OAUK7T/ndg6fz/uUUt6SuHRo81Z2LPa4ua7mRYB9PpI+R8ZwjLitOsTKGdk1Csn/3nWnzzDldQgeiLL6FegaqN9314f9Og799pqECLZANT4FixINHAASAkdNmS1QtoMnH2CHycmhJPjLFln3OdtyvYVENVErtWDeNq/mqIHqEeH//z50lJfAQRDrEH+RidTM6psftvD2PFEW/t8Qj064o7IPRqAOlXLSK8rOyO2eGk2xGw6C2aSWYBj4vHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzUOVWIpi6zNM+96WWB1S7SO6TLR0LhXUeTCkWiaxGo=;
 b=Voy3EM5m6p35uG2yfgijr1fUwOjD/o3YuA0pLmqPTt4752O85in4+cWmqybw3wpiTwiZzbsjR16FU8co3Jw+O8636FFNHm5plDZDwPCOuH1qxTExfxKLhKm+ZdJKDiZGpHR3LnovMn30PupiYnAid7vfwD409F/BCN31Qb6NHS8=
Received: from MW4PR04CA0185.namprd04.prod.outlook.com (2603:10b6:303:86::10)
 by DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 3 May
 2022 20:38:47 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::ae) by MW4PR04CA0185.outlook.office365.com
 (2603:10b6:303:86::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Tue, 3 May 2022 20:38:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:38:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:38:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: handle asics with 1 SDMA instance
Date: Tue, 3 May 2022 16:38:33 -0400
Message-ID: <20220503203834.1230487-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b8c38b9-5c7d-409c-1e0b-08da2d44ec2f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4105:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4105B532DFAEDD71180FFE58F7C09@DM6PR12MB4105.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nRZ0wOCyUeBIb6YvFW/5tbgZZpGMHGtKMp7v0A/epsh1tnx9mLMeXRYpCnmAvFETelaJE+Yb8iJCgz5E2dZgegs+EfP6bE6u3q0mPxPV1FgTRNCjPNKGDJaVWMj7u+4zdcW9qubH0RpbAK9hfsrmgfYQ3Ly33rIt/lXWwgxP0/HPehW+9x1AUhx4V7QTCCvJwPmJqWG+1aDrRz2ixWmcl30f0xmKnvjXEXi0esXFKmV3RK1PVp9BCcW0Sg7Z1hDKj0wgSw3x5KOReg4h7uVI0sWc2yAOzxb9IlAbqTHdVs+Kia1YsDSCuILiiSld2GrNvybV+gfu83ZYFKHuVbgBjoXrvke8AG+ALA3oG17FO0AuMEZI/eIde0hFeHIw4jb2RVftCNQ35MYgjZutkupucDPl0H33Z7XXV/eHscn8tCh9AQZUuXHJDyVuDULvMcvJMgF815tgv91nAGN2UwMZTCeypTcvEwzZB7/k1SIWx8VbVzWjrVsOC4Exz95xCWPVBQ1sr/P1s14cfPIjTfhRKF+nECRDXm6z/zue9bzb6jNw2Xm3oe2VRny92BEMOrovXmYe53/cbMEgQHCoZgU6fkXMDhaodyJwPg8sx6kdfzqyeoYBXMG87ieNQhbf4+LXu4dS7Psk7jkNOEcnDJUt7c9Oaex7NVZ91ZEEpDL7sx6CKzb/YeMYroJTK1pn+OsvAh9zEvfI8bjkijx2jfjIwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70586007)(8676002)(70206006)(4326008)(6916009)(508600001)(316002)(54906003)(81166007)(36756003)(86362001)(356005)(40460700003)(426003)(336012)(186003)(7696005)(36860700001)(1076003)(26005)(6666004)(8936002)(82310400005)(83380400001)(2616005)(16526019)(47076005)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:38:46.8008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8c38b9-5c7d-409c-1e0b-08da2d44ec2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Xiaojian Du <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaojian Du <Xiaojian.Du@amd.com>

This patch will handle asics with 1 SDMA instance.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 307a1da13557..29acc5573f56 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -252,8 +252,9 @@ static int soc21_read_register(struct amdgpu_device *adev, u32 se_num,
 	*value = 0;
 	for (i = 0; i < ARRAY_SIZE(soc21_allowed_read_registers); i++) {
 		en = &soc21_allowed_read_registers[i];
-		if (reg_offset !=
-		    (adev->reg_offset[en->hwip][en->inst][en->seg] + en->reg_offset))
+		if ((i == 7 && (adev->sdma.num_instances == 1)) || /* some asics don't have SDMA1 */
+			reg_offset !=
+			(adev->reg_offset[en->hwip][en->inst][en->seg] + en->reg_offset))
 			continue;
 
 		*value = soc21_get_register_value(adev,
-- 
2.35.1

