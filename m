Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BFCC4828D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 02:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03B02112659;
	Wed,  7 Feb 2024 02:22:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3AqahfGI";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4931112659
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 02:22:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGb3eO9vXRjV4E+puMDkOJ+Ab+nRIENNx+SKxjhubkiHIpJVXxuRmP2NXr9JH3dPoyWOw9AdRJteakcbVnfH8/1ZZ0ZctKaNGiy14LU6K5QV0nFZuLalhBEu9G3JDARcWH67eEgIO9J6Ou4csWFqh4XQHYvZFha0CeKqCl68pn458vqVV6s3mvi9P1baAS3e1CDjSAuSJx+tmJvUBejMnbaSqkHALS06OKUL52Q6gYV32BfFVTfQq1zF8+ezojTypzGJhdMhkckySocwok749YSCgZHWqQPSHkS1qOvsMx1FOsTX9IvFHlGuVxOJTz+D9+YaQUM+MoTUoTkZa7ZRVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPv74M0XXFwWaM5SAn8CPCczIyoKxnxwcn6LhyPXHvM=;
 b=D/BVad5aD/YQgsFBHPpLkAgpTuW80lqQERsLEGUGe6MA01dfg7YbbiQtcdeKwukW0YGFhFTPBc1DoYEW4uUHFDZgpeLNl4hVjM0xcWhs5NMF5H2d9AMz9ICukDYOiblEFcbUTVv9iylYihOzSI2vvlJ9hu+VwBo+AtRZDymR/ZB11DmdfS8S3jAM+9a+UJp8usgpXOQ+TnpmnrAysiry1OW4ev7SUPDtkFibP0WInKCHjp0kETXQtg7raU9wV/cPFKNfm9YlTRLHCkZJluZuhdTHNRe2MAWSJDVDusQwjUUl4czaLscEQ/BUO2AFsLTIPObZdHYN4AbBh1PP3AaRIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPv74M0XXFwWaM5SAn8CPCczIyoKxnxwcn6LhyPXHvM=;
 b=3AqahfGIckzRd1e4htiz1bEO6SXBDqjlBOm9GIwJd5plYv0Ta+n6BeGSTU26oSS/dhXs1/ZCimEO6ryyaN0CLWp8zz3Dsj4f3ANqvxOtIGyjmcehR4J4kIDAAjopjJQBb2zzKgwqnHxSG7DvIqHrNaxw6FnNgJZpIeFxXPMN0qY=
Received: from SA1P222CA0110.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::22)
 by DM4PR12MB6398.namprd12.prod.outlook.com (2603:10b6:8:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 02:22:19 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:806:3c5:cafe::5b) by SA1P222CA0110.outlook.office365.com
 (2603:10b6:806:3c5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 02:22:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 02:22:19 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 20:22:14 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Davis.Ming@amd.com>, <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: Fix HDP flush for VFs on nbio v7.9
Date: Wed, 7 Feb 2024 07:51:56 +0530
Message-ID: <20240207022156.297987-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|DM4PR12MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: 1944c8e9-6bda-44e5-4bdf-08dc27839c15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QzndfLrWOQ4ma0kQ9itK2KbK2GlT2uxezBLUvk1E5OCfwh4kpNwTUK1wyVrDOGajPlCCYvrQIg6BXaXF9huWeTofZzoHAZzpCI2v/07kGlXfGyvDZ95cZOQcnBaS5DWGfsii7MImP+Mh4OgjY8wrmO1LvkE2Prz1hlwu2A44vgGL0MxSiplHbh28dvYPPSJNJq2XI9au0rJ2OyK2s0Sd98fra8R+ZwnbW+0eJKw2yyTOQuu5sf6LzpLtKNPhLRjRWmioUoIyemTFGZilcQ8L7f5A/y+/kMwbqcOhn/FsYQnQ+fpAKHq9SvKr5njVURO2dyUSPo7MtEB3S7WZxejFwA8ZTBgW2VTgmmLfgr7RW5ZDwBt+1zXGZrM9JjAk0+oFsHfIC92iDsENIytNs5BOTL+lXe7AFiDh0kbVzJnXASDwCSZYk8bW0xbLC4mpE3rNIlAgO2Qq0S4Pi6xXoTQ063JZxeUe4FhWch71+9YLukgW28pZj7u7yHNGWBV1F2CIW8xXbnhpZ9DjhcefIYCkMdm0YfrzxaCUq7PAVUYm2mnNttQN/L0fSgsE1T/P07KhkCYVswznO//bbr2/DJ8ojfA9IcH32JBha3cBdIH1VnfdWvd0xeICGqDgRjGb7+nlXM3dVBwMl+wV+f73tBtMG71xi9R+Lf/lVHbYAYQ+GCWq3sAkgvwx2oa61tOhJflD/T2Ex/6YxIRitAWzRBpDplEWC/J3/5I55DzZMj6VIo8sSuhZn2ixnDzSssy7wuhe/ojNN0KZk5auYDJSy82qOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(46966006)(40470700004)(36840700001)(5660300002)(44832011)(8676002)(8936002)(4744005)(2906002)(4326008)(86362001)(426003)(41300700001)(6916009)(26005)(40460700003)(336012)(16526019)(47076005)(1076003)(40480700001)(6666004)(7696005)(2616005)(82740400003)(36860700001)(81166007)(356005)(70586007)(70206006)(54906003)(36756003)(316002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 02:22:19.0889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1944c8e9-6bda-44e5-4bdf-08dc27839c15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6398
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

HDP flush remapping is not done for VFs. Keep the original offsets in VF
environment.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index e90f33780803..b4723d68eab0 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -431,6 +431,12 @@ static void nbio_v7_9_init_registers(struct amdgpu_device *adev)
 	u32 inst_mask;
 	int i;
 
+	if (amdgpu_sriov_vf(adev))
+		adev->rmmio_remap.reg_offset =
+			SOC15_REG_OFFSET(
+				NBIO, 0,
+				regBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL)
+			<< 2;
 	WREG32_SOC15(NBIO, 0, regXCC_DOORBELL_FENCE,
 		0xff & ~(adev->gfx.xcc_mask));
 
-- 
2.25.1

