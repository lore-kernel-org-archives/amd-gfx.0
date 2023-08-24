Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828AAC6FA8F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:59:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10C1710E5E7;
	Thu, 24 Aug 2023 21:59:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 385B710E5E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:58:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOwqN01uHeFWXOavKzeAAd/z83U4zw/ZtZyp+g1IGWDbcHsoWoebwyle30fGtziBPgVpOe+Yjuz5dn5+OTj6nlHGZcZbC8cQsqRKzuLIN0oG1+PMdx/r1H6dfMZpprtE/3DP5EmCLEezNmanJo+84fCUYx1Psf32awWznZGzCUa82vsneOyZrY2EqmfQ0M+ePq/HVhk9+Evkurp+B+SohdewBvU0wTNeBu7dh30jLWeH1Ersc5eYap26BYlpHLhjR6C6/hEdHES2oHU2otGjqPmKzMrEgdi07NpAln9Kgghk1xO4tnSlzFuK85JgCp4dkY1sG54aAaGKe4iPjyEdnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVnKXTC3Hx7MtOdWk/M9Mh4dAVUPavsUZsBXSPdz9uo=;
 b=lLJ7Ud5wJdIiOwiyzZrNYRgItCP0JTltEDUL0yqgBUWeK8T2Y7HLkdrVJN2uIBM8n+j6yWrs2b/axPddUjeRQqgD2zIEIXEeH5zVuqIfpelK8HsyGM3sGaxU7amlHivfkDK7ESs5Z6CGy9thL79q1OCZC9dbIUkSNfHlTPoNac/gdIfqHpsCDg+imW1YcVYJX+zCbGYmbdm7a0KETY2bw7qr/O8znQ4KXtNNsYSEqn3kuOvVLArZs1HFE9fIj5V/Np+FJGZF0E815kmAtPqgfowTFX0SDNjp87Gf9HfCqnB7QPerhFv+w4R1hN8A5pEZ+8rqCGFY/h4EUV0I5M5c9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVnKXTC3Hx7MtOdWk/M9Mh4dAVUPavsUZsBXSPdz9uo=;
 b=yKdPwgk4F3Q16T3QloFRzPnxylggTgllNHm+rTreRPnZhbRKw1k28zVLuGgR9A9en6otBRXhjLp0qHwvss3CgaUb67LR2Q5QWSu3fqk1alVvWRyMmGVu5VECRHOg3xc804fOf1QZlOVfzU81ASg3PScWLrnkPVzPddjLgfIkTfM=
Received: from DS0PR17CA0009.namprd17.prod.outlook.com (2603:10b6:8:191::9) by
 DS0PR12MB7876.namprd12.prod.outlook.com (2603:10b6:8:148::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.27; Thu, 24 Aug 2023 21:58:54 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::9c) by DS0PR17CA0009.outlook.office365.com
 (2603:10b6:8:191::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:58:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 21:58:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:58:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/14] drm/amdgpu: enable UMSCH scheduling for VPE
Date: Thu, 24 Aug 2023 17:58:28 -0400
Message-ID: <20230824215835.2740115-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824215835.2740115-1-alexander.deucher@amd.com>
References: <20230824215835.2740115-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DS0PR12MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: fafe5f6f-340f-42b3-2438-08dba4ed4eda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /kJtupcuWeoA+TfVfbkHO5m+YdzEduyKHtWGRW5niWcFHx3fElMufWhndDqTB7m+Ddh8Tz7aLqHP8TPJRTh5wE53VOGF6RXrGIe/t4C2YJHr32sJq6qTHVbyYFf/O5EnMaCoKNPyD75aOABs43FkixHMvwm+Buc70wRhJm46rotXkEYMipIBH2vNeKk7wsxXXf6dzjqqCUXskRGbKu+3hZWMDnKnHaLRfmrTwZ1rKVWMerJLszPkMjAhmBveZ6qxD5AuKZQxSnx440xEp7v0JLakUWWXfuyKv1r+Yu64jhd6+imHNcsc0sVRMZZ04CJNxothdElRYe90bHmkMpiVlfMibuSSFDQJ3KuJKjhQAr07J1Su9W8bV09Bzw+Cg11iCFps2pmREGPXztiC/Vyl+qu8xRoiJXeeM6hteBPJYMcNgbcL1BbVo0K/QHq1+dgMSFIpUdNgM28NUfDSv0xKAVDVSUEgmUugRM/QdoVY8VEm1yFHvriX+RHWXMC3MYr0u4CkFtRZYvIUpoweZT+4F6j/nB6I4W6upU2up8DPzl8cd+7FLYtW1zLno4fB86B7sxUcRXTUxV15qwSW8fvW+pDKq9mkgM+EFzFWYz2mPa9sP0zgUixKL4kyC8lb5WzQHZcmA0jQNd5m7ISFGsxSnrnxli/9jcP1jr5j1QXMtaaiOAXfu5US45Oiv9JKSn9AE5wXItqgQ0tKLKhoTS0JtBNu79S6Wum4G/HEz7CnTxtUf/OM0sbPsDIhAtWD5okkrUs/o6dK+HbMe3Z3MJjD0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(1076003)(40460700003)(2616005)(5660300002)(4326008)(8676002)(8936002)(336012)(47076005)(426003)(36756003)(7696005)(36860700001)(26005)(40480700001)(16526019)(82740400003)(356005)(6666004)(81166007)(70586007)(70206006)(54906003)(6916009)(316002)(478600001)(41300700001)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:58:53.9086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fafe5f6f-340f-42b3-2438-08dba4ed4eda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7876
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Veerabadhran
 Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Add VPE into UMSCH hw resourses,
set vmid mask to 0xf00,
set hqd mask to 0xfe,
then UMSCH can schedule VPE queues.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index a8a35547e883..29457c503c85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -231,6 +231,10 @@ static int umsch_mm_init(struct amdgpu_device *adev)
 {
 	int r;
 
+	adev->umsch_mm.vmid_mask_mm_vpe = 0xf00;
+	adev->umsch_mm.engine_mask = (1 << UMSCH_SWIP_ENGINE_TYPE_VPE);
+	adev->umsch_mm.vpe_hqd_mask = 0xfe;
+
 	r = amdgpu_device_wb_get(adev, &adev->umsch_mm.wb_index);
 	if (r) {
 		dev_err(adev->dev, "failed to alloc wb for umsch: %d\n", r);
-- 
2.41.0

