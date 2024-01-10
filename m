Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD6EC47077
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 02:11:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 053BA10E560;
	Wed, 10 Jan 2024 02:11:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D625D10E560
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 02:11:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLZvtDdGcxPzmjd9adpVDbtim3tOGHiey6P0P6E5GXwcFaxYi6jknWZPYnytYcvf0W/BzGsnM8UUvcGMv1CJgOt8xI+fIX7PUwVvEcxoW+rSEmlod01/F//PZQ3Y2waL8YQ/eZwt4nA2XRBPNEJsvR1FwXnf5eAgME/AYtSr5o889IF7vJBVL3UO+QrF6u9fgQty8N+/2ByAwzWa6et49Fbsnff4937Z6ds2kWk1Fk6fU+M63Avl5EyESt2TRAG5QcrfSIuq+KIRJrUTmVow9ZtK0eC1YEop60Jm3sAVnM/0aOW5cjgVnTHIMx3/Mux8NvUxPleZm4DccKd69zF9mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmVv1ZzyMaqkxJ01P9bZGMpsYIsyZYYVpyaw3cRr18M=;
 b=kD5wUPS14Umv8VTx/yBP9Ad2qky2IRy0iEdoTfGs6XJQZk4iatODUAAtypKiUJRgYl2uCNQYA/SDpu9bbMkLPO+0OyACYbIjIvjZrQjCNxL29JnpFfAWHX++4kMHGcSxE8sPhOkvM98C0l90AjQobOqKVW6zfys5TWAljFbRkiyIH/KfXfv8q5JJhsUkZKmevuXgaW7FbpDRlxAx7Y0CaaZsyekacFxfY2jKav2RhRC8p1py/IJ1tMGAixibrWX41DIeE4jVCtiJWnnJhfhWhDUUEuUIjjsc8IQJdFETqepTuc5TL/ZPywFF+nEeAD10IPkLXTsSspFUbBghzaMQ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmVv1ZzyMaqkxJ01P9bZGMpsYIsyZYYVpyaw3cRr18M=;
 b=qHGrv2yy+StoJwKhCSiHY5iJu26nV5P9qhET45VGwhyqkA5V5uG4n2Wr5ONL4HCRnS+rJGa29nVRpaFUoVwVOJvBMdPLg5DT6yAfiNEHBl1WI7neQznkrVhogeFIU/sTTEAixT92YJTDqAo01bxKhOB8cQ5ClqYwkPgCCZLZzng=
Received: from CY5PR15CA0143.namprd15.prod.outlook.com (2603:10b6:930:67::12)
 by SJ1PR12MB6122.namprd12.prod.outlook.com (2603:10b6:a03:45b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Wed, 10 Jan
 2024 02:11:37 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:67:cafe::a0) by CY5PR15CA0143.outlook.office365.com
 (2603:10b6:930:67::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Wed, 10 Jan 2024 02:11:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 02:11:36 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 9 Jan
 2024 20:11:34 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Enable smu v13_0_6 eccinfo in firmware query mode
Date: Wed, 10 Jan 2024 10:11:09 +0800
Message-ID: <20240110021109.88159-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|SJ1PR12MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: 71977250-1b13-4e16-2603-08dc1181798d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dD4T+xmEm3V0yEerbuyKUGo7sGzMfdte6WbpIOc01SB/7DdTCxM7GESxolcKy49FX+MFTcXkAn9wNKc/1o6CebHQN/NziOpY8gfo4zxYLTyB8XLUx2Vf6rywu/lSK81eVICYyXJKZ+AuDTT2hs875cYhOiIOjXhmr0iKJWfAAXz8IDUVE8DzrnO9umE74PW16res8R96YatX8MrgJJrOvwYMixgTR104R08FNqgWLe7k3SXBiV+Aow2GPP/3/Z1hNO371KG7H66CVffU9V6JlMkmwPFNuYmwiiHYDZF0wjxhAvz3xr0CPtN/OYcuygogLLrAvR8JRAfni2FGNIQF5dlfeS0ElyBUQ83a1OZqnknNUi2SkjHKqaA94Ef3fekJk2ws+n0vEKejSx51dwVZY97V6dTPQNAz9OrGcTuNK3EKoIBCYkVplq0WM6YQMCNbCwAeL5J7nuljosjVBvvFdN62lmNI0x0JZUD6YHUknEXaw+5Yb68ukJv52bcL+vJu/jq9Wbqxnrki7tnzbtTZe0W/7AZxprYnN/KLApQqhBxPibWQ96PM1NQYU+8cdXg6ZEM/PoWBAZjjU+9kmDsw76iF3S1EkWzT4A4fqLWe1iTTvTNJfYh2KL/rYbUBeqqDMAqznoFSavB7bOIEhYvynp+Tq74gc4gQkDRKQyAJA1YmlPBZKGQG944A8APOdjqaHFgLshie5LvZbw6yfbmyyKn2k1Ad/Uvkqk1n+ooWl179HpkSC20islDhPyyPrrKStT4zPexC+tbpsy2Gq94xaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(46966006)(36840700001)(40470700004)(36860700001)(6666004)(478600001)(40480700001)(82740400003)(40460700003)(47076005)(81166007)(356005)(426003)(83380400001)(16526019)(26005)(336012)(2616005)(8676002)(7696005)(8936002)(2906002)(316002)(44832011)(6916009)(5660300002)(86362001)(36756003)(4326008)(70206006)(70586007)(1076003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 02:11:36.6420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71977250-1b13-4e16-2603-08dc1181798d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6122
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

smu v13_0_6 eccinfo is supported in firmware query mode only.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 4ebc6b421c2cb4..8f78294e4a6195 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2896,8 +2896,11 @@ static int smu_v13_0_6_select_xgmi_plpd_policy(struct smu_context *smu,
 static ssize_t smu_v13_0_6_get_ecc_info(struct smu_context *smu,
 			void *table)
 {
-	/* Support ecc info by default */
-	return 0;
+	struct amdgpu_device *adev = smu->adev;
+	unsigned int error_query_mode;
+
+	return (amdgpu_ras_get_error_query_mode(adev, &error_query_mode) &&
+		error_query_mode == AMDGPU_RAS_FIRMWARE_ERROR_QUERY);
 }
 
 static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
-- 
2.25.1

