Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B49C001B0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 16:27:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC8A010E1F4;
	Tue,  8 Aug 2023 16:27:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51E2310E1F4
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 16:27:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KySofasXnQFWBTPxqJfZwc3JF+Zm8PPAmM5RJM61diB7mV21lEvII2F5OmE8jbfe+62R9oZCQGtrVP8D/gqxtqpv30JBeSeC1O3yT2a+WGmpBabRDSYYhGYTVV/U7rV98BlqjUuY2GE/6YKKCyp9uOM/b4qNEZMzlJKiRxS/3y5RE6wf/O019y+H04q4VmiCB6N0wDJCK4QjFqILrlzDf3MWARRu/oFW+l4+yFb87mkOU1tjBfyF1lruD4gwjtv/A1z2C11BoDXFwuFniTBdLb4HcUiGpoAJpeU9f+XJPAucUxrStCzvEoApkBUjkkLFcMY6UtrCrnnXjf8r5Ip8Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1JhxbitICNhv3PxvrK7rqXOvAM+6zTsH/mmLk4gi7A=;
 b=hX43twV8KDPH3pMkaAunYRwgl9A0Hd7y5I4+AymuJqQYtg+WJYgy3Bi5+rA8y0s7tYFUyjz0WTBNv7yCB6Vp4Bu6N72QPGjZjmRCBpHFxykqyBPpvslE39qTGpBG4AZTNNshQOww+bnstv8bM7sRI2TT3092t/l0vAJ5uPbnUjZrbXamlgApUSkgzO+pcm4G5PmhHQtf4gKcVAMo9UPb6/xVbaygAWifORpL1zaFKrxpDvbHVyTYQWxrxVt4bKvFRb1g1o5Wj/dBUD4Gw0N9obLgI2U94tFH2/pJ5xtvm8ETvlPZlSkbO6fWDZI7LwRx/McKxZ5fz0pp7yvDEIYYTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1JhxbitICNhv3PxvrK7rqXOvAM+6zTsH/mmLk4gi7A=;
 b=jsmtc7j7rvYdrBVd+2AVR5EXB1B/qcDOChi1poGMo5vvZPATqh1AoN9BXblZwWgcvX0dKy+w+EIU/2V1qDKVgm0621I7GlNF64g1cIqZrUpheVTLyvVe0O469BzklRnc+2Q4EBAm/KX1ja6J2njYDt287P88gXOaPtQZUziLE7Y=
Received: from SA0PR11CA0021.namprd11.prod.outlook.com (2603:10b6:806:d3::26)
 by BY5PR12MB4920.namprd12.prod.outlook.com (2603:10b6:a03:1d3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 16:27:04 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:d3:cafe::37) by SA0PR11CA0021.outlook.office365.com
 (2603:10b6:806:d3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 16:27:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 16:27:04 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 11:27:02 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 4/7] drm/amdgpu/vcn: mmsch_v3_0_4 requires doorbell on 32
 byte boundary
Date: Tue, 8 Aug 2023 12:26:19 -0400
Message-ID: <20230808162622.74937-4-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808162622.74937-1-samir.dhume@amd.com>
References: <20230808162622.74937-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|BY5PR12MB4920:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c8fa0b1-ed5e-401b-b50d-08db982c4d24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hQvyEVHQikjLkHifZ6FgIrsPm9rWRaTD0U7u0osYnmsfMvoETYYPJOeVqdSFq2AXFhnLQWdaL3W/VueRQwhglFPK18txvenODr15+uixj9FAGSBe6Xmm/X9SOrsBWFlUXLckR2ipUPPfUbKCYKzCBlGyHsmyeIp2srGmDwgN1wS0e3Njah+s+lMkE2evmbkZZ7bVig0A0ArUQCO1mzse29NZEx20tri5DpwWNeVeVtMD5M+UVz2W6KHQX6eAS6vVhwTg5s+apXThP1+tJaUP+Z4QrTHRDUe1AMbuqUkY09Sk4jKmkPTTj11k7tzfYdx3Lo1kaRhl9pdn+A71UMEnXnkDvtDxnuDTWcGzk7fWD+ucoqXp6VuZbXGHWQWlrM/Q9T2dhu/xnUX6I2GGkIM57tA6FFdGkZsWdA+QYneuastyMbILoQUJtvxP/Cz30WtMZI4ATgZ9zgInWLgc4eH+vLZYTyEyjxBKJmJEGvfGwNn6DSYc9njiiEDv00P831l0W91Q+6KYO/38VzWNXDBXvPfQ0kRiuy6+bdNYEhcY8Fq/hkBE++Ig6/niDbpd2i76XHeCCQHjM2u2JN90UHoGn1kSTO875gb8Ewpr5Ap+mDWsRhom01clv6GEl4vSlOlDngxE+VxXNpM4tGOuSDbHkOds39TxLbEnMSoElm0QYj+XjMSni9vr3u1pgY5S8kQOaLQrqhdFHUaNdQmt3wIwVAbDvbyJYIVFwADKE30BeYKWjMqX8XZ5vaHobPuOCdQtAyfdbigWD752IChjw8bQRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(82310400008)(186006)(1800799003)(451199021)(46966006)(36840700001)(40470700004)(426003)(8936002)(1076003)(26005)(41300700001)(2906002)(5660300002)(44832011)(83380400001)(8676002)(36860700001)(47076005)(16526019)(40460700003)(2616005)(40480700001)(336012)(81166007)(6916009)(316002)(7696005)(478600001)(356005)(54906003)(70206006)(70586007)(82740400003)(6666004)(86362001)(4326008)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 16:27:04.0166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8fa0b1-ed5e-401b-b50d-08db982c4d24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4920
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
Cc: zhigang.luo@amd.com, guchun.chen@amd.com, gavin.wan@amd.com,
 lijo.lazar@amd.com, emily.deng@amd.com, frank.min@amd.com,
 alexander.deucher@amd.com, Samir
 Dhume <samir.dhume@amd.com>, leo.liu@amd.com, monk.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 66eb0c8e6f94..1e5aad207878 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -113,9 +113,16 @@ static int vcn_v4_0_3_sw_init(void *handle)
 
 		ring = &adev->vcn.inst[i].ring_enc[0];
 		ring->use_doorbell = true;
-		ring->doorbell_index =
-			(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-			9 * vcn_inst;
+
+		if (!amdgpu_sriov_vf(adev))
+			ring->doorbell_index =
+				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+				9 * vcn_inst;
+		else
+			ring->doorbell_index =
+				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+				32 * vcn_inst;
+
 		ring->vm_hub = AMDGPU_MMHUB0(adev->vcn.inst[i].aid_id);
 		sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[i].aid_id);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
-- 
2.34.1

