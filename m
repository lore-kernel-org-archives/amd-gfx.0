Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0701C7EE24
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 14:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B435110E2E0;
	Tue,  9 May 2023 14:01:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FF7B10E296
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 14:01:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyvqCow/fk+FpbeQ1mVEhMyh9dLTFdypYrGbnx1CKxy89zcz0KSr1i/RIKfo1a8GjMCMNC4BaO/Ltme098vkPR6Qh3T0UgUPPfk+71cYNUccbTz505FKW+CukdzForxmvc9eywW29nZOcKN1Ceb0DmN9zyBlaOQqHf5X2SoKVODjtF/ViT1e9/q49mnmIADOCYxwvgew1K1ej8OucnK6j916ok1b3eo8f3/wgCxmkUYAlq5BNfSNgXNEtOffHdscK8Qa/RqhtDmWqqrn4YLRKuHhdXRnPQuktvMj9SmySnL47Z3xMChCZsKJAmLS1SPn0jN/s2ZGMCWUEXhJYi3nFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6WAnZ+5jUX11c1jSMrW6ArmMYl8lxBUxWY+9aJ+378=;
 b=JfL9bb1/w5pHD5x+eN1IAyKco9Ilud96Hw/l9Esk/s/Olnxps9224L6kEidPg5jv3Y+D2dfztigOt2cl9qR8Y7LhqDOupj0+d9bYsALUYAboGKhv6wGN2ZBgHi0tMTzpaHxgl3pBCNuIHBFrPA8bX3AyGn+ubgGm8NmqELlEwerxj7Rh69o+BGqWziTj01s98FwAlehn2QI0sT2i3aewWKObrHZb87OVfJYae3iDMFSQ/BmW/BAWWxXZe2HHqthmHzDcqzEaD77c+aLNNFL/wmxJA/ynSzlB/Irb7lBZKOZHgItogqW3rb6sL7hMYTZJZxej+4hPOeCHKbUQIZySlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6WAnZ+5jUX11c1jSMrW6ArmMYl8lxBUxWY+9aJ+378=;
 b=4p6Jp5VcFtPbwEx82dg57mk1usCeZ5phnxNGKrNfMu8doGCrZT+6xJHI/ftQahBsyymhYMsnBo+MjfMFWSTiNCaApZbDp1624MOoKueW5mLbIKEdQ4OHHNrv3vyZPjlCWXd1bHVpMQ/Fmwt5Q7QAGargB5dBTQiD4hAic0dQn9E=
Received: from BN0PR04CA0113.namprd04.prod.outlook.com (2603:10b6:408:ec::28)
 by BN9PR12MB5367.namprd12.prod.outlook.com (2603:10b6:408:104::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 14:01:18 +0000
Received: from BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::9e) by BN0PR04CA0113.outlook.office365.com
 (2603:10b6:408:ec::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 14:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT085.mail.protection.outlook.com (10.13.176.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 14:01:18 +0000
Received: from x570-ryzen9-5900x.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 9 May 2023 09:01:14 -0500
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <saleemkhan.jamadar@amd.com>, <leo.liu@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <veerabadhran.gopalakrishnan@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/jpeg: Remove harvest checking for JPEG3
Date: Tue, 9 May 2023 19:30:42 +0530
Message-ID: <20230509140042.1213641-1-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT085:EE_|BN9PR12MB5367:EE_
X-MS-Office365-Filtering-Correlation-Id: cb0e5a2b-d47c-487b-251b-08db5095dc77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IXFN7C2ITAUeKfzdhTd/E7sTvAZrO759JBjwjX7i3F49AnO6msonvtdO+rVUIUIhBFj5XScnV4GzqCgTKPBiVj9fC5SxYjQDIEUk8alXW/7ZAs1odrYIp1Hn/Ym9q3D+psqbwDS7p1+LKVgMni4huUgPBfz5wQNIg8og7NdwfuBr3r5EEIQ3EBQTItaK4v1cL0fNNQk7hfnrmAYrfgDK/7B6FsLOw2N8uuVhqp4enprhB7ckLMbpKl1969aT5QGlh9V7gtDpOQfQze+XuU+AkeCp7oXq0/MedYpUjWDhE8Gke0W1bBSu/BuC0kXTxG3+111z7fh4WgGo87aI8oLSGSiL562fRDaUscsXHv4ZTwPKNKy51lXbBGpeOVi0LeiSaiYzR3mu+C17z6tppxEt7k/TRxJ4Il7ml+eeA9WdjoRJlCh1KuNQ0VfN+JfqXQ8OmnTtSrIqj2Usk0ItEfFmC6SVEFKPTukMsVbgqdQ/Q34Sc8hrbKfRA6Z43CJoRK+udxloAeeIoVtrTSXGq1zoyBtwZLgtAwd/jzbx70I4R+vFrnsmg+9cKGThDARQzqxTBgS4Ieb7KUkvLbZDg+1XGru/L8Fo8TyaG0XMistOJAP5cthnx5w4SRA8MJaaAlni6n4Pz7Yto4GNUqPpvY+teyJHIJezbM5/PEtfjfqHsHi7sK2eNWC8mF4cCFn9+cwQaj57XAlB+ejzviILV+lkfExhlmWWcRSMN0QUnkFQcLc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(356005)(1076003)(81166007)(26005)(82740400003)(6666004)(7696005)(336012)(426003)(36860700001)(2616005)(47076005)(186003)(16526019)(36756003)(44832011)(2906002)(4744005)(40460700003)(86362001)(70206006)(40480700001)(70586007)(110136005)(5660300002)(478600001)(41300700001)(8936002)(8676002)(316002)(4326008)(6636002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 14:01:18.1772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0e5a2b-d47c-487b-251b-08db5095dc77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5367
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
Cc: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Register CC_UVD_HARVESTING is obsolete for JPEG 3.1.2

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index c55e09432e26..1c2292cc5f2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -54,6 +54,7 @@ static int jpeg_v3_0_early_init(void *handle)
 
 	switch (adev->ip_versions[UVD_HWIP][0]) {
 	case IP_VERSION(3, 1, 1):
+	case IP_VERSION(3, 1, 2):
 		break;
 	default:
 		harvest = RREG32_SOC15(JPEG, 0, mmCC_UVD_HARVESTING);
-- 
2.25.1

