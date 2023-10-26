Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7A5C25B48
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 10:25:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 467CB10E7A3;
	Thu, 26 Oct 2023 10:25:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E82B710E7A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 10:24:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFCCvQeeF48yttVHrCmwvCwcevrmxR3dqWVVT/CX0DKmvL0C1qCO/dKxvuN/us6cqaHTGJ5a2ZJQ9Ev/nIing09RBCnazy7JTMPpXVbXbgYkiKzgGUNJ6mE0IAT6eIHn5O310vdAgte84dPKxdXnyZkSC1C1yXoXVDDIG9C9g9lavrn70MCtDxoOe+Th7vYkwnile82BCVn+qZsVJKGalJfQ77wzZQ1QglDcArd8TsiTUW+YP647WVU1ZR8FsmT/ZXKTx2TfoaK+DFlXv1Zb7lSJFS2BnCGGYrBcd2MDwIFoLgV8DroCeVURR62hpIhoAIPTrwpQjJFGvqxZZ0XaPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teEEJCk+GEiJWIqsUhTcMPJdhfd0SY+puxuxUu591XA=;
 b=IlTUkR751XA7sksUvA44u79k8tXwFged3iu08NAVvNdoDh0RydrZEepAuextCuVd/rS6idHvtlO0i8Xp9kvEwalRhBr9TJjfnaRzZgjcMe/MycPqQeosLNkpnZf26JkJn+hJQFn0TeWZuw1jyggMkQERdWKlwKzGKV9FhhyA4ETdxBkOPWZYojQoQOqHGs14F/GZ8U5Yk24qb4GJuIguydlt4kdnUl64GkLHr+yrcx9MZxtRwUX4venmbJBiGy/RA9BPswAsfosoBTqQqtHjmA/EeuLkJHm135LFY5w5D9U0nNO6hXjLfspsoQ4GvMgJU8RBDciO+WPPpLj8vD+vdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teEEJCk+GEiJWIqsUhTcMPJdhfd0SY+puxuxUu591XA=;
 b=rpCscvvHTpQmZgYl5d6DNo9F0TTxXUIBID1l+g+qmRiosbtsIDFzd4kh1dP3md+cuUc7dKdRtd1qKmlF+7UjFyqkP48BYHnXTTiA7vpLT/Fim9gEqpfqK+5ppAWuwh91MJILuzrzCrjYo0gHTJ44XwIfFDIA4CxqOalRD95XqAA=
Received: from BY5PR17CA0039.namprd17.prod.outlook.com (2603:10b6:a03:167::16)
 by PH7PR12MB7817.namprd12.prod.outlook.com (2603:10b6:510:279::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 10:24:55 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:167:cafe::7c) by BY5PR17CA0039.outlook.office365.com
 (2603:10b6:a03:167::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Thu, 26 Oct 2023 10:24:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 10:24:54 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 26 Oct 2023 05:24:52 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: remove the seq64 map sequence temporarily
Date: Thu, 26 Oct 2023 03:24:02 -0700
Message-ID: <20231026102402.206783-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|PH7PR12MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c3e36e-31c9-4773-ec96-08dbd60dcc1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DBnBBhvcCU9JPiaG+T2cLFWEnstFDB/GSdZ1PbtHQEJJdHtVxzHDhbF8X13GmL0ylusYDUXjX7QLaGpPcOYLpw8/PNq1xkGVnCdXig2MdP4LrwxCL/WwLFeIekezbiitd0HX41DZaLaka395vxDvK9sfObYXZoITjy5stmdI1OKmvTkr2aQ0UDXPCK00jURAWruSlI7QM9d29Ux23FjC5ExIz6IKaP+GNPAV7Y/GKSBF3xOLqxCA7gSECebEJEOBQkjAkngZBGGZvxw1Km9/lIIDEgO2kuQXcE3j+usDrsWB1zJVQeae+/wg77fAIOX+zXNE2NrVZC1HsYGAyc94zYzwYz0phOHS6mmcWzt6MHEpFz9rWoLFP56DModHWs9CqN6AslDBIDk0Dea4WVPkwMgFhyZkIsyyikBiimdHR7iKThrVN+jdxEArJKjtmdjFwDTw0mS4penain9uUMZl6d1Ij8uR76qsvzHayaLPe0KxyBh1c2tgnpubx472Qnmq8PRv5tayiHOXigKc+yQUPo+dFgXriLJXQMt0jyHaNVSOxxP3xO2S3JgsQlkUrI4Bw7+sGe2EnRnXJ+PPCiN+Ehk40Ne01yXXl5DAve22qmxNc2qarLUKBj75eU/Po80IrCXWyT4U99W//wi+qzoyjP5VGjU/Bd4T2fZC8LdZWT8LjOHOMuD7PmRf5eWGXBS9W5vZj5dbQgX7+QSwKaFGPSKtpK4JV+90je+jwEQ0ADvpkdM7p2fDo8PbKZ7Mh2AOcx0c/3b2C+S9xISfs6aGYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(186009)(82310400011)(1800799009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(7696005)(6666004)(478600001)(2616005)(70586007)(70206006)(54906003)(316002)(6916009)(86362001)(1076003)(47076005)(36860700001)(82740400003)(426003)(336012)(26005)(16526019)(81166007)(356005)(83380400001)(8936002)(8676002)(4326008)(41300700001)(5660300002)(2906002)(36756003)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 10:24:54.8886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c3e36e-31c9-4773-ec96-08dbd60dcc1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7817
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Arunpravin
 Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Temporarily remove the seq64 mapping sequence.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 55fea7564758..b5ebafd4a3ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1365,12 +1365,6 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 			goto error_vm;
 	}
 
-	r = amdgpu_seq64_map(adev, &fpriv->vm, &fpriv->seq64_va,
-			     AMDGPU_SEQ64_VADDR_START,
-			     AMDGPU_SEQ64_SIZE);
-	if (r)
-		goto error_vm;
-
 	mutex_init(&fpriv->bo_list_lock);
 	idr_init_base(&fpriv->bo_list_handles, 1);
 
-- 
2.25.1

