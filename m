Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B61C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 13:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 991CE10E19F;
	Mon, 28 Mar 2022 13:07:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6397110E104
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 13:07:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2wFHIx5j/0oV2ulI9S8zisod7yqn9C9o4iii3U8eDcWn+fWdWwDZmxJNANKNNaAq/S7qdRgaEs2yBSvE7Z8bJoRvINUPMb2qWC7dcEBTm5525YHDUBWBk92TgvvX4fhuAK34uClfI0Wlu6ntJjtF0Kz71Mz2RsPy0ukIICeC9ROXsX5ygm1knb7Vn84m9MJQFwVkNB4SYF2BiR9oo7+fymTdZsQVN4Vpqnw5hjPNvdgMxCpNiyj9u4uY/oSB9oik6pFSI414mp03AxpUHqKvneaTODlizU5sAN24rI/68q7VkjsvHztXpy3ieAoBt3N+2MBp7Y9LjJ6p0RVWO/vfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgT+VxqEgJ/XoivrQy1omNefb9o4zwQQXv67s/YGwKE=;
 b=U4u0pd2t0EN5ExNqYDON8eXKjuYAjGvGWJ4dCUfssZh8qqz3tHGRItM16atxGW5SIk8PoH1iMx0f0P7zPEDWov3P1EZDOhR9lmsi70tn5qqwZIdNsih68n3y69EsiMcx0kjuBYas7A91JZra/ZLRnhcQpgF70+ULjDRzGbr3y4XVeHVqy+NtQdg7X7B/9dPjV+reVqs9d7Vqp3/YW0flL2opcXU6yle+w9XVlB6TGnrplG4ZK+5zi30FjANiLXsk8LePvHbT55KjdPMB3NGhjwsEsfDTvQjDMYGjpXQSaxxl77j4zYWlbCGExA+aGwJnBCQ7hgSYi8w0UzMEOtgrqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgT+VxqEgJ/XoivrQy1omNefb9o4zwQQXv67s/YGwKE=;
 b=t5fuotXvQbZX7XhAezLDfFcG74rIqckNTd2RATiL2Qr1sha9qBtKP6qdaMv/qlOyij2kVPpG9jcmoZW2XnP71lA2gotb+4YnyQwR1nn47VJ0tl9IPD8IHlDEAiIq9WEUCX5/ui9e0gmrUvRTHG3vpVD7RtThREl7fYpnuvfY0cw=
Received: from BN9PR03CA0680.namprd03.prod.outlook.com (2603:10b6:408:10e::25)
 by MWHPR12MB1296.namprd12.prod.outlook.com (2603:10b6:300:f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Mon, 28 Mar
 2022 13:07:03 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::9a) by BN9PR03CA0680.outlook.office365.com
 (2603:10b6:408:10e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Mon, 28 Mar 2022 13:07:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 13:07:02 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 08:07:01 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Change unique_id to use IP_VERSION
Date: Mon, 28 Mar 2022 09:06:45 -0400
Message-ID: <20220328130646.1226563-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af37f465-d562-4acb-9fb3-08da10bbda08
X-MS-TrafficTypeDiagnostic: MWHPR12MB1296:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB12968E3EDB577D464A961196851D9@MWHPR12MB1296.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gwZDWKINGKUfOXQLapW1Nb2solECOP+0ZtrgQcxBNLR4B91tRZH+dGr83QPrDaX57wlxT4pge2/tLR2JPGyVvGyajzhwrFTDe1AuVwHuyYbssfrUworKDi8qygJBGbj8eDWSPsKq3DsyS6tz4xErS6Ha1rF0U/pVbOLjn+RpXTOpY4ugU3vvDm6eSg4a8dGTYGfLU/e7pSB87QhUF/Z2qSnX0vcgdGwj79G2pY+jUWp6Y2XsTX4/D0yyAj8caRIyBwLqO+aMXtvCGkkbQLLQwjzO13LbBrcaAOTgvQ/0nA1upK62p4TTpBUE9yhdKhTLxPP0yK4f3C9xG/wsyzl48NCCztYpbVDOsEk8ciqloPUwyFFMubuBkAgiQGSABO6s06WvzGZ002hEOa/lDYeaj0ImOCKe6hF+fO/3nuaRDyBeRrLtTAE2vHqt+x+Rp+HY9QoaDuLlRLAc9CTxzOpc6ZJP22YVUS+neVrSxyZtse526vWRpOoDTpRzPy3dgdrsSnMHYn/eeQH9qeU3lOEhhLn+7YoXW6L3U+OfWWMh4PUbOfrW+TADBZ1dHzKVajkGiCy8uwrsrfCZGqavrmXOvoZB+jpjORIhSsq2YsZvuDtmjhqT7aLjpk0RxB7GyTo3BzqYmNu4OrPWvxx4lO7pUM5XNRPG4kQrMMAuhP1YJCe3tzav7KQ73x+yxVVrzvRFLjOnYLmHvZ5aZLgNskO/oA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(508600001)(83380400001)(40460700003)(336012)(1076003)(2616005)(16526019)(26005)(426003)(7696005)(186003)(6666004)(36756003)(6916009)(82310400004)(5660300002)(44832011)(356005)(2906002)(86362001)(316002)(47076005)(81166007)(36860700001)(70206006)(8936002)(70586007)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 13:07:02.8648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af37f465-d562-4acb-9fb3-08da10bbda08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1296
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
Cc: Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is transitioning throughout amdgpu, so we may as well get it
started now. This also cleans up the logic on what IP_VERSIONs do or
don't support unique_id.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 5cd67ddf8495..a5216c0f5c2b 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1987,11 +1987,15 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		if (adev->flags & AMD_IS_APU)
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(unique_id)) {
-		if (asic_type != CHIP_VEGA10 &&
-		    asic_type != CHIP_VEGA20 &&
-		    asic_type != CHIP_ARCTURUS &&
-		    asic_type != CHIP_ALDEBARAN)
+		switch (adev->ip_versions[GC_HWIP][0]) {
+		case IP_VERSION(9, 0, 1):
+		case IP_VERSION(9, 4, 0):
+		case IP_VERSION(9, 4, 1):
+		case IP_VERSION(9, 4, 2):
+			*states = ATTR_STATE_SUPPORTED;
+		default:
 			*states = ATTR_STATE_UNSUPPORTED;
+		}
 	} else if (DEVICE_ATTR_IS(pp_features)) {
 		if (adev->flags & AMD_IS_APU || asic_type < CHIP_VEGA10)
 			*states = ATTR_STATE_UNSUPPORTED;
-- 
2.25.1

