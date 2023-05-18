Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0170C77B7D
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 10:53:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6191510E50E;
	Thu, 18 May 2023 10:53:56 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8B8110E50B
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 10:53:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0D7xaCAZu+6yb8KNn12IRVJ900yqUCDNcG/9CXnm01VNMV7q6niUsLzBD7R+geL2uKhbEgq7w+2wvTMya6gM7wElQjd2IAokQXYXPzAIvPJ0wGW5woLhRBQ1UYDY0LCBLQEBkvJA5q6YJb6Zt0tXqWEJqZkcTQoQyj77Py43UoOU8hSLOlptvktE6NwyLQXtuI+JUq1fScqKoTsvLafm/u7AlHCQt2Iw0tVH6MhgWOL5en4xuWjw87A4rt7ccVjeY0Ky+RwmQmv/MgLhjLsy+azVQ9xsMQ0wk1tLei9bZ3LkjCwgsv+EVRTN8eTQ0XSOULb8ms9dy2T5SEKleuChg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFCtfsA0Ox2JXLudLbfvyLhwzd1OoGOPnmoyT8oBt6E=;
 b=kYZ6KOOucMWyIF74TdSzhtCuv8xch34Z28Soy5M9gSKVe5jLMLM8rLhK6as5qxpCoQt/ZXKG6gvoAQZi0AyUyiyHzDlWPU9td0xyuwiEtz9PbRIqHRELHp2Z6eon94mcozF/8CKrmLxXsOrL/jaBGIXqUGsz7K5bo9BDsUnaULTCkMVFL5M8zylM+UvdfRKfwIJT9ZCIvzLSy3CbMVO686oNuboHwXyo8bZEL3iv7LDbf20OJHjIAMnEnJqVIRij7Py8BKEcOBwfMME0QRyLi3n3FhrX2wMxvZaZ9J8VrPOuH5YD1CR0gSjq4FNTUVh6EKznPyD/doq4h8OKCdssCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFCtfsA0Ox2JXLudLbfvyLhwzd1OoGOPnmoyT8oBt6E=;
 b=nzGYFSu8tL9EzIts75N0SiU/+tt4rccj/aGyYQRc1F7RqZhMWZZLOqVH7ujW5RFNlvG/sUqT5IY8XCe3aCQ0ooor+yYPSKCe4Lo9oEXfSv7OOnwPwtZuw+0pDWwIxM2GCqTekM/3qDm9zwdIwWq9j7YPYXdU73peyGNiQoha6MA=
Received: from MW4PR04CA0312.namprd04.prod.outlook.com (2603:10b6:303:82::17)
 by BL1PR12MB5110.namprd12.prod.outlook.com (2603:10b6:208:312::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 10:53:52 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::ca) by MW4PR04CA0312.outlook.office365.com
 (2603:10b6:303:82::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 10:53:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.19 via Frontend Transport; Thu, 18 May 2023 10:53:52 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 05:53:50 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/8] drm/amdgpu: complement the 4, 6 and 8 XCD cases
Date: Thu, 18 May 2023 18:53:25 +0800
Message-ID: <20230518105325.15609-9-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230518105325.15609-1-shiwu.zhang@amd.com>
References: <20230518105325.15609-1-shiwu.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT005:EE_|BL1PR12MB5110:EE_
X-MS-Office365-Filtering-Correlation-Id: 19320cdd-74ea-4b72-8b9f-08db578e2b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5iBObM1Zgpm6xfbfZF2BXlcO8teZamC62oB4cT0x2IAA9R6dcbod6nz+M+RfdLHNptSZ5xloPK+ldZ94D+GJzWzbwUInaF937tDHI0IkZ0J1Cxk+Y06dFYYRVP1oojqRhXvBd/XKGtt1tBvQkaQrjEdVnjrpvZDbk7MLUnfa7lFC8y6Ngd4YZ+40IYHu7Kfhd54GBdSkBIwYVwi05gMBsm4HY4JE91gY9K85bzvWpZHVsENiOQ9nfqDyxPWqLnTU20EgPwTZqo6N62paNW0EhcCYZKCXuCGZkyMHNm95cCIy81D2qM9hoqQceK3RKf7InyuRjvW/+n6bJz/pqix0ETrKW2xbACCdTbDWjnPsAEj2QiTcgOn+s44jsr0ZMfV6oufaQSH7Yo7V3pXa+02sd1OPRLJOQcAxJU+yT2Q4XKYnZTgMhZPYi24yWv0lUHyxMFQpnAqIzDqk4G8gUjuPjBtfrDDsT6ORka2kOzZ2L4VPlGEC8ydm0WctWeR4Tg0vdCRmIyVT7Xx/DeKHTEZM78zFK9q95GHOy5rkSUTZSCPJJrY1MqQQqVkMBzkPiP1PFrbw3ozMo+DxHEy0Xy1qe/Praudxa/k0QnLGwReSclPcXXxvIgrLfnbH+VGeCalljtgyISfGtd3UPB0j+i1iUAeiLm1296eZdX5pSR6C/ylH9vFcRk9+zEQpOIakedfh7B3L4jkbR1YoOick+fupyeIOJvjOqACsGaJEZu4yuILIJfbf9WS4r6iP9LGaMjAhGX94N11tXu35GEIGjiOtMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(6666004)(7696005)(70206006)(70586007)(6916009)(316002)(478600001)(41300700001)(5660300002)(40460700003)(186003)(16526019)(8936002)(1076003)(44832011)(26005)(40480700001)(8676002)(47076005)(426003)(336012)(2616005)(36756003)(2906002)(36860700001)(4744005)(82740400003)(356005)(82310400005)(86362001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 10:53:52.2242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19320cdd-74ea-4b72-8b9f-08db578e2b21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5110
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

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index e5cfb3adb3b3..97f6f854d077 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1031,6 +1031,9 @@ static void gfx_v9_4_3_xcc_program_xcc_id(struct amdgpu_device *adev,
 		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HYP_XCP_CTL, 0x8);
 		break;
 	case 2:
+	case 4:
+	case 6:
+	case 8:
 		tmp = (xcc_id % adev->gfx.num_xcc_per_xcp) << REG_FIELD_SHIFT(CP_HYP_XCP_CTL, VIRTUAL_XCC_ID);
 		tmp = tmp | (adev->gfx.num_xcc_per_xcp << REG_FIELD_SHIFT(CP_HYP_XCP_CTL, NUM_XCC_IN_XCP));
 		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HYP_XCP_CTL, tmp);
-- 
2.17.1

