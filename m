Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F9DC7EE2E
	for <amd-gfx@archiver.kernel.org>; Sun, 11 Jun 2023 10:46:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B879310E0D0;
	Sun, 11 Jun 2023 10:46:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68AE210E0D0
 for <amd-gfx@lists.freedesktop.org>; Sun, 11 Jun 2023 10:46:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Orp7emmNIl4wEF4JnwlPLX2gtJ7WEbM6COyiB7+lYu8E9hveYrowUD5ehS90G/b2XZ0Xg5fLyssas5E2crHPHoTHkz68ShiqJlISoSTqTjdn2vy88P6pAzGP20UdkQlQeusbtzlSIh2VHqxpXCt3HVDpJgx8VDSUlNzK6J/kKFmq2+Tc+z0gI6YK5Tw0l0aGUVeIp2aiG6FPFsCesEzqUe9VLdttc3yTrxn/QqwYupELrS7Af5eDnGoFsjczeO3dtSdSRTRi6v2zqPs34nXvh5GYAU1f7/aNE3zjE1PR5UWINLK3kfBPGTOF3JQBNdiHfNFP45uQpxGbrZS18lCpow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDJkbWGAcwl9JQ2oeBeEFn05NLYHLUviT67wKYvP2tU=;
 b=SnMBp3eq2ftDB8FAF1y8f6rRmNIuot/SxYmQqr4Nc2BlWsu2w1W4tqBWRXIb6vBp3C4R1iKpZnqBkrxjfYdl//gJnIubnK7d9ufiLWFAvaBt9BG9ulEsrxYo1//E4dS0lFDQf2GJuDcsShCHlVQwoD/p7IKwOdfJSkJnoxwCX5oPxY2l+sxiqocjElyxMydj3N+uNiHZFe0Pd57ehIO44pMZZAHXLoTFxLCoGWVDuptmp3/ey8IiajA+kiRhPkMwl8HHoF8dmgWSZUVVhehWvQbhUDeXTkkTVSTMo5wyLrmJPBt8FWzP4l6kdA75QqSkb5WgszNb4WFgMc2qBW0GKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDJkbWGAcwl9JQ2oeBeEFn05NLYHLUviT67wKYvP2tU=;
 b=nuaooh90nJ53ZlOUoGRghpxU/2K7NngKPDgj/H5ID0jyntJbtXSYy8QKTE7M6gE5ylJ+aIdT8Zewr+zxL172GXFzlA/DxNtO1TzPCQACfOtlPydeXBs3uUJ0Gda4l0FQGqrwJEpuMNfJvwcKbOGzVN91yTVNtvPhosYQB4kU2mM=
Received: from CY5PR15CA0103.namprd15.prod.outlook.com (2603:10b6:930:7::26)
 by SA1PR12MB7101.namprd12.prod.outlook.com (2603:10b6:806:29d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Sun, 11 Jun
 2023 10:46:09 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:7:cafe::c6) by CY5PR15CA0103.outlook.office365.com
 (2603:10b6:930:7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.33 via Frontend
 Transport; Sun, 11 Jun 2023 10:46:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.20 via Frontend Transport; Sun, 11 Jun 2023 10:46:09 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 11 Jun 2023 05:46:06 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Stanley Yang <Stanley.Yang@amd.com>,
 Candice Li <Candice.Li@amd.com>, Thomas Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Only create err_count sysfs when hw_op is
 supported
Date: Sun, 11 Jun 2023 18:45:45 +0800
Message-ID: <20230611104546.7383-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SA1PR12MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: f4816077-1e3b-42ca-5f9a-08db6a691114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yFFOUo5kr+d8hoQhRUVFOall2JfQZnf+1VLE9gfYP2TxRAX5wO+ueXyuepHLRRY54OrJ7d49Zx/7it5DWceB3Wtg5K1G3J5PVhT+S5mE725HfhXPyibKehmrBaT4nnRgw7LCCfbfnyupSboyEdNWu4GmnTlMDc88+cOxWP+KNgAtbwx58wKocLFV4YsGfOBGmatA1C/II8BR1xrYOmbxSZtY1Mympo8hyl+zYgLglke7holZeuGveg3stCtKNVehIHDaZ8eKIp+fQIHzhnwwul7n9sSwqJZfO1EPNF5vW5EpR3r9lEAzOm5ies71lLrQoflstk8yU2/vOEVP60r+U+24lKOAYh6nJ2jma2Gd7hImednzkovab5g5Wz4SIOK3wd7qjKxG0BWJkk2PedVkgL/QOo9lsUOWT3CTEOhm+d0WGt071gsSwsStriYCM2Gji7vy3a6pm7zoo5cOTgVObNdcVpy7zz9irTZWtqziL/bgoyM51dMQ5o226lJyWiyDeA3IE5kW0lefJLqkXAZzK3nIGeuYriD38lO1dbOD5wmrc/jMdAi9b3dhPJXO+xB8h61+VhOkhUOJAhTpmiKwyujXIuE+zhy5WQqWs4G2x6ABYWoa5XnNKmfPwNw+5evHQCWSCOGcG+6/jL41Ajq+jXxlnQPSz+WeC3Oxnu9RvEelQizx3eOTu/eolRa7qkZIHUD6QMeNie3r5HXQ4ghqu8Tc8hFQQVyIS2e30v6e5TWeJTZyG6BCOxBWt1m+FLxrtyVEkP8Z3Sij1Z578pbW4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(40470700004)(46966006)(36840700001)(26005)(186003)(1076003)(16526019)(2616005)(82740400003)(336012)(426003)(83380400001)(47076005)(6666004)(36756003)(7696005)(2906002)(36860700001)(82310400005)(8676002)(8936002)(110136005)(40480700001)(478600001)(5660300002)(40460700003)(41300700001)(6636002)(316002)(356005)(4326008)(86362001)(81166007)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2023 10:46:09.2621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4816077-1e3b-42ca-5f9a-08db6a691114
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7101
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some IP blocks only support partial ras feature and don't
have ras counter and/or ras error status register at all.
Driver should not create err_count sysfs node for those
IP blocks.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 31 ++++++++++++++-----------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index a6c3265cdbc4..dd7cdc234d7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2757,23 +2757,28 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
 			goto cleanup;
 	}
 
-	r = amdgpu_ras_sysfs_create(adev, ras_block);
-	if (r)
-		goto interrupt;
+	if (ras_obj->hw_ops &&
+	    (ras_obj->hw_ops->query_ras_error_count ||
+	     ras_obj->hw_ops->query_ras_error_status)) {
+		r = amdgpu_ras_sysfs_create(adev, ras_block);
+		if (r)
+			goto interrupt;
 
-	/* Those are the cached values at init.
-	 */
-	query_info = kzalloc(sizeof(struct ras_query_if), GFP_KERNEL);
-	if (!query_info)
-		return -ENOMEM;
-	memcpy(&query_info->head, ras_block, sizeof(struct ras_common_if));
+		/* Those are the cached values at init.
+		 */
+		query_info = kzalloc(sizeof(struct ras_query_if), GFP_KERNEL);
+		if (!query_info)
+			return -ENOMEM;
+		memcpy(&query_info->head, ras_block, sizeof(struct ras_common_if));
 
-	if (amdgpu_ras_query_error_count(adev, &ce_count, &ue_count, query_info) == 0) {
-		atomic_set(&con->ras_ce_count, ce_count);
-		atomic_set(&con->ras_ue_count, ue_count);
+		if (amdgpu_ras_query_error_count(adev, &ce_count, &ue_count, query_info) == 0) {
+			atomic_set(&con->ras_ce_count, ce_count);
+			atomic_set(&con->ras_ue_count, ue_count);
+		}
+
+		kfree(query_info);
 	}
 
-	kfree(query_info);
 	return 0;
 
 interrupt:
-- 
2.17.1

