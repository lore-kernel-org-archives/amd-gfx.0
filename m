Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753FCC77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDD4610E90E;
	Tue, 28 Mar 2023 15:14:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D092C10E918
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOUJoEF1TtqgDBimM8P2L8trImkFIsKxtV9yp/ZxT8LsstqKcGB/dnYRlxQRElIqVF4jVzx5F96LQInmGEPsGL9egFqfR1PA/p0OIqSdfdmfM22gQALHwmVZI9bIlBtbZNSO5fBvkcpJijFKqiCOi4oeIIMMfOJ9CPhWOzx2P+IhFL0HYFxZcSF6lL0x8mAtiDRWo/ZV95GXDvQ1VJCLPfaIwFwVlZ1/nH8VgGedH2yGABqfzwTEoi/arLq4vJ1h6myBsrVRo4rwcIo/G/qPKCm/5KAcjeiitX7wf/ptmMpMXKxaKbDFFBI5RipMzSlsyAfP2SpidnMRHjTlJf74NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHVEOawhbh0BVNyv5RqrkAG0T5rn5GUxj1gAhTiNG7Y=;
 b=FFu0a85wohdU94+G0LTNXY7RR7UR5oTZKGLyo04D3VT6XXE5GNsPHwnFvxtWUyQJhW2gSw8VADgwp3SceU7dOtgtpj4LMbTv5jPgIco2EPTIxjcBG2b4gFLDzOmeXVOvQBJcKlNBFkHZGR9Ph1C0Q4tmKJ9aAwbhMk7+8avCN1Ov+1NN3JfJSqKjAkfmdeCPiUeVa/dldaSOXckP9IvsooHdeOnPB7I7xCmwdvQ2m80fneZtkfj05E21lugBiA7cV7XvqT52jpnBzahSKhxxehqX9ty6z35ovT/CZAN7SokRf5suFtXg/WqvcZUAkRbertFYoxEByGalqLNq8YUnNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHVEOawhbh0BVNyv5RqrkAG0T5rn5GUxj1gAhTiNG7Y=;
 b=VWevhYEUzo/ayGDLRWwR95qKFl3dWsgQFcmxvN66Uc3YvzOnyyP32CuILNL+8GDrGwWjWgo2uB86iIixvbdaqHhUcAH35dDXt+RYB1/hR7Hy98hk+qt66U3aZIQEomcNJoDLsWe0PW8EEF6ywRDMreJj7sJSUAtksp95HXbUYjk=
Received: from BL1PR13CA0074.namprd13.prod.outlook.com (2603:10b6:208:2b8::19)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 15:14:43 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::8f) by BL1PR13CA0074.outlook.office365.com
 (2603:10b6:208:2b8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.18 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:14:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/32] drm/amdgpu: Use new atomfirmware init for GC 9.4.3
Date: Tue, 28 Mar 2023 11:13:31 -0400
Message-ID: <20230328151344.1934291-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151344.1934291-1-alexander.deucher@amd.com>
References: <20230328151344.1934291-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 508c7a24-8c0e-4e16-e5b5-08db2f9f2916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Lx7b6XfX/2G26SaC3eA5RIspEzqdxFgS02tYz4BGbJpnzIrOo4Ystm+o9Kmz/Hh8uSIUgw9cACK8F+B9McptzEqO0j8Vnx3COwD5xh5nSsnfmVcjnZkPEeMYyfUgg2l0yjwUSDOY1RESsng23t7HgXGaA47pKzaTUMa49P0mws/E/+CVAoBw9/09+AZBusYVM2SldasGdzsgl+mplmVIcrC/smLkRiVX37ep/ARF155M3Mf2SZtYt5jqYE8q87wrrA8cdeeh71qjIRID3M8Dyf6LB6JMU225pyxXJhIkrhfS2PmrGhW9MsYmL5VxIhpjLuytNqo3PXp3tdIMYTAZlszcgJgE14e0RAaJ5QX96D0a05JNYkaOUc8RU4TaQ3B458j6cJsYRTzsVBsx9ImGWk6rEavLk3op8GZezqyr71taD9r/olioHrjlO+oGdzTYQkpfDJe0/E8HllRYDuA5FKDPZ9sRMlhT4hxuOoKErYqN/djrqogk2BdfasydXwTrOWR1LG304sukqey6uaMqdGVpzXDEWbCD+bbLcStNS9ovPY/P8rldfpwz5Fc8rBpIklc/7VCdJ+lmHU12D4cxgAvK53/L8bIA1d1I9Sw7wEKGfAQ7SggDtQ2SnWRFJ3sTWKc3N1lXm9i1XHzmSQn/LWWZZHs0IVaZ5FiAkEyP/xlce8ElWHENR/hkW/J0QmJUTlLrBsHPF7AJ6bUHkMwaA2+nX9QXSfwqOxGCrKBMCA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(7696005)(40480700001)(4326008)(6916009)(41300700001)(36860700001)(40460700003)(70586007)(70206006)(316002)(478600001)(8676002)(54906003)(2906002)(83380400001)(16526019)(5660300002)(2616005)(82310400005)(186003)(336012)(426003)(86362001)(47076005)(36756003)(82740400003)(6666004)(1076003)(26005)(81166007)(8936002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:43.8104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 508c7a24-8c0e-4e16-e5b5-08db2f9f2916
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Use the new atomfirmware initialization logic for GC 9.4.3 based ASICs
also. ASIC init logic doesn't consider boot clocks during init.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index aa3c27b6035a..1c657273d9ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -941,7 +941,8 @@ static int amdgpu_device_asic_init(struct amdgpu_device *adev)
 {
 	amdgpu_asic_pre_asic_init(adev);
 
-	if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(11, 0, 0))
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3) ||
+	    adev->ip_versions[GC_HWIP][0] >= IP_VERSION(11, 0, 0))
 		return amdgpu_atomfirmware_asic_init(adev, true);
 	else
 		return amdgpu_atom_asic_init(adev->mode_info.atom_context);
-- 
2.39.2

