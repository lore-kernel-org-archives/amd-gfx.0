Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABB9C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBEBF10F675;
	Fri, 29 Apr 2022 17:47:46 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2064.outbound.protection.outlook.com [40.107.96.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1643D10F6C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmMcuh4dW0QpTcstVi3YZDBBKYB7s5B31FEw8bhC/oSsVK2UGHxTg+2wnHHiBq2seXQvMqeT7SKDibMO8CCxA0kv+zGAtnm2oCc5Mhgtspx8NR5BqPv0etkOfEgPfg6kNMSw4hHmhd+f636tRtGOoLvAIQCIoV71tHa/tNrIjd4oMZlNPVDFfBSyr3KArs5yDIiUmu0R/jyauazt0B+zF6MLWpIV7n2tCf4zE2U0wFNgT3LnMmwDgUT3VBfGjVKbu/jbm0HRR5uZlu8na1zDBzVdU5A8Qo7vnO6HBFKIl5T3Hm+RuhmhnaWwnvKkWmQ/XC8JWDcXn7O0T4Na4eVvRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvoEQpc6xATZhzyR2pltK+zMwcI6RP2enESIjiEmdVA=;
 b=TpfcInMhVWNfWHFXKVsfrHFEyGbhnwpkf/EFEe0TXM0p/vSMyCKOKltz2aW/XJ90mtjDIG5yOLKyMdRu4+biW+TE6u5IRLRoNTALfJd9KAGq3TwffM23v8V9bGP0hog3se5swoI6MHKG7F62vYBLq7xR//Wfg6SXBiH6TXDi3Jl6wDxnIIbIvxv4rLx2pwerbuRZVdXq40gKKwUBuDp4Ky31pgu5L0+vy197LJQbb+8GpPaWWwM8AaDdvkvY4ZLZ9aOcpu6ypK0swRXiXI9WN1OovGvTi1C7UX7a3iqwzY/jfvXF5cecaFoEv0B8Wi2R2q+Yr/h3AJdcyQt4smXk0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvoEQpc6xATZhzyR2pltK+zMwcI6RP2enESIjiEmdVA=;
 b=UQ2SQM/Hxr5CKt6OaiFiLy66FN/a3WC6maWSVDFGHtosd38BGsWx/nog8+HPWek6ltbsqS4PUud9XZP1tP8BsfJb0V8/AU1T7+YKDunOABH3Sqbhq12MOQc5beWO2DDuKW/2wPxr4kX3MyUYTvpzrDW54dPBY0etc00Lhkb03tY=
Received: from DM6PR17CA0004.namprd17.prod.outlook.com (2603:10b6:5:1b3::17)
 by CO6PR12MB5474.namprd12.prod.outlook.com (2603:10b6:303:139::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 29 Apr
 2022 17:47:19 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::59) by DM6PR17CA0004.outlook.office365.com
 (2603:10b6:5:1b3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 65/73] drm/amdgpu: kiq takes charge of all queues
Date: Fri, 29 Apr 2022 13:46:16 -0400
Message-ID: <20220429174624.459475-66-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c65cb25f-14d5-48c3-3f72-08da2a084e73
X-MS-TrafficTypeDiagnostic: CO6PR12MB5474:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB54744D438CACDCC90C041F4CF7FC9@CO6PR12MB5474.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iWDHsJHTEX1sOj1HS8zIg5C72Eqpj4fTlweDKZZoYm7mD/ZulJ1TAinhxj/agLp/67uBXACeQMknL0bFOq3i7TTdw9jpRAGZutQbBWBcbM6yVU3K3dda0qdXr56eOg1fcuOulQ4W/QM0Ua8/Yu/7s2eUzz/FWaGHP/PKWEPqOVNvn8Kmjr015cqhOFsiojK6e8IcN6aRxeV+UhG3V7WUVJAif1jb1uFgq1AG7p4O1MLnHR9kHWP4i3cIwj31iGdQePyy8CC9u/A4RCJyZWynCHIkDCAOy6R37UelcRhh0LgPELPcpaIKrrtTx395ZFCiWUEeK0DiYXZW34jt6K5pLyBEa8qWfT57eKvErf9vjegaBw3IyYML1EgkRmdY/pbZ/qU8tyrd/jZfH1269VH/t2E3wI47G/UNfXnBuzg7s71yIl291QUUqUQSFTdWhE9krD0mZcnzpEZTQ8qvxsj4cXMXvxQ9qL8VnOkL5KjGBteD9N06Wg23aI3GD73pGuRheJxCgBkl4a8y6O7NU97Xd5WhgIJpbUMzg1w/PPquTsYvOGsjUfr6pnK3QUSLYLpsOmHE6ZOTKJFI1e1ela0v+nFK5/MvKVr71XKW0r34DC67Em9+z8wGRzsYYeBqZukzCHZWzoKPc8tcQwaGKw2F6H9KIj96QMlhVdmmmE/caN0SJLpISJCFeh1v+qh+CXoCAyStIug9Izjp4LTJvdYCxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(81166007)(26005)(186003)(47076005)(336012)(426003)(16526019)(82310400005)(4326008)(36756003)(54906003)(316002)(8676002)(4744005)(6916009)(70206006)(70586007)(40460700003)(1076003)(508600001)(2616005)(8936002)(5660300002)(36860700001)(356005)(86362001)(2906002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:18.9533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c65cb25f-14d5-48c3-3f72-08da2a084e73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5474
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

To make kgq/kcq and mes queue co-exist, kiq needs take charge
of all queues.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 28a736c507bb..40df1e04d682 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -535,6 +535,9 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev)
 		return r;
 	}
 
+	if (adev->enable_mes)
+		queue_mask = ~0ULL;
+
 	kiq->pmf->kiq_set_resources(kiq_ring, queue_mask);
 	for (i = 0; i < adev->gfx.num_compute_rings; i++)
 		kiq->pmf->kiq_map_queues(kiq_ring, &adev->gfx.compute_ring[i]);
-- 
2.35.1

