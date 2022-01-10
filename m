Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F326C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 23:39:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3523C10E880;
	Mon, 10 Jan 2022 23:39:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 663C710E663
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 23:39:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egTRrkMEUqkdfEefbB+h/WxpXIUYFxDDlsim1LiiXVzt2Q7A0CZwmwTnmoIEFtXyTC926cf6PDwMurNFJdbXrCduEBzVgakkZxYkLUb98ApRyrvijgMGpornBo74KqN0iSpJqB5cKgL8MOci3V/0qCHqPEIZ+mjl2BanZ4Pz+2uoWt66U0gEpfqxMLWQCCqszJ/3opg5xjcNCpSqxovFcJ6VqDgahv/FWKOHnYv1QZ4+vEujmfP1wZ3tN0taRRtU1VfuiwviTPSVmf5nb6ZM/4KfCPhl5Bb2HsrCCjAuu2wp7fGXKrtL4PTXXwftoLelSHNzvWpTotVa74rcYijxAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8FA0Unv+uWuEn5J+frW+LZNC5zKT5EzIBUIUqyUkKY=;
 b=K51BsYiKJuMLDnM/QKz92nh/PpKPYtOpe6ry9lFmJq2lk43+7ow4iYUP36c39Qw1TKM3P5h/H1on2DT54eUzxzZObdRtr9Q+6VD3Z8Q/0gcExp71jkBvDqDYS16AcltggsuVTJ+imCk5Ad1ahqvbI1euZHmD8pqILph3pD5UGaml0iMXUgIxIYC0mks+5fiR2Ucz2rP1w7ieYP5wpMZpO2StGzEsWwKk2BX8EgJFGTdbaPTHgggg3u1yvB5WgtZlNnRPcK+WPHF46FGe3WJu/WT1pVkQmCHFMuUIJgkJkCYpvXbyUUFLB+qMIiyIPYY59EadRsWYyhU3LQ5js6GEzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8FA0Unv+uWuEn5J+frW+LZNC5zKT5EzIBUIUqyUkKY=;
 b=YVmygrrMV+zWZfVmcY3UmqCiXhvm2TtxRI2cYHJTQom0RnGU4JE4on6TkPbPH52tJT5eC6OI2p0jkQe+0oWMzKcLl+w2NSz6NGmuYH18lukYx0boAlhifqo+5qLSca15W5dqL7k8I7PjpBFe3cT55TKykIPOi6p33FHgOzdsGRY=
Received: from BN1PR13CA0024.namprd13.prod.outlook.com (2603:10b6:408:e2::29)
 by MN2PR12MB4581.namprd12.prod.outlook.com (2603:10b6:208:260::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 23:39:19 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::92) by BN1PR13CA0024.outlook.office365.com
 (2603:10b6:408:e2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Mon, 10 Jan 2022 23:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.9 via Frontend Transport; Mon, 10 Jan 2022 23:39:18 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 10 Jan
 2022 17:39:18 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Fix compilation warning due to double
 semicolon
Date: Mon, 10 Jan 2022 18:39:04 -0500
Message-ID: <20220110233906.1178021-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220110233906.1178021-1-Rodrigo.Siqueira@amd.com>
References: <20220110233906.1178021-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb4729e1-6b23-410e-bdca-08d9d4926be5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4581:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4581388581D8C05FE525EA2398509@MN2PR12MB4581.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U0/mIMY8+tXgjezs1JC9WGIrY6RWuQIFjDZtVzWZZ4SOIZ5oKzDnn7ddhrs0cTMHUTaLBC/dQxmh6G5V0xPZCTuOSyYcBzZfitzlAj+mYrAQ7POMFbervUjBh4McBv+c0Raqp7+I5zNqn7JH3p/vjoiSV4CrMysV8Q3VxWZYvaOf1SZa2jFXyLkbxxr6R4JtT87hijxpirSqfAzD5HygzrAZygLwQ/LktYTDbquenZwQrLWvNkhHUMyqfk6EGWw8fhD6ity+/GrynB+b3dUU8bgG5grc8WiFggWnEL6ndsBIFRpvmD9/3sRt84bfytN1yubb0Un5WQaPhyQUeOJrYzeI9fH2u991AKIGQf6wnMWSjHsXhtuToGSVNYzaRc41SogtWx5p94KYr/vCVLSZx0eZK5sp1Gusl0UKZQ66QNt20T7MrVWo4MDtupRdWXj3U3GK99vllSAgH1KnWCu4lfkpL33f2lbJ/M0YVWC6INHerSuNjrliJ7/SO7AvReWuAAu3CQC9z0Y5tv4rEPgXgQsONUrU8+uTVvEbQ1tkSLtddpHBYoKDtAUIxV4j/Gj7/MYjo5DwP2+heDea7ErT1AoYZPJ6vo+IsDYoN8qEH++YUkCoZXDyULw2p0fll7cytO+QHdYHMPnN2GII8Plv2dr5aK/kRLEqDaGUr0qhwH65QIMnOnJeWA2kLuH13aLuCzbyhJqR2N7rIr/x0e6MPNIZwwcOgOexKC/wR3dtcC1TxLTXD9OxtsMXj/GnkCn5A0GfKuRuVtgNsP0loAGwXw+YGker5/E5o8NZ0QfKdbk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(336012)(186003)(40460700001)(36756003)(70586007)(70206006)(47076005)(16526019)(26005)(82310400004)(8676002)(8936002)(110136005)(54906003)(1076003)(2906002)(83380400001)(356005)(6666004)(5660300002)(508600001)(81166007)(6636002)(4326008)(86362001)(2616005)(36860700001)(426003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 23:39:18.6730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4729e1-6b23-410e-bdca-08d9d4926be5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4581
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
Cc: nicholas.choi@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There is a double semicolon that makes GCC complain about the following
warning:

amdgpu_xgmi.c:953:2: error: ISO C90 forbids mixed declarations and code
  [-Werror=declaration-after-statement]
  953 |  struct ta_ras_trigger_error_input *block_info;

Drop the extra semicolon to get rid of the GCC warning.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index aa8d614009d4..d47a510a7f5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -949,8 +949,8 @@ static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 /* Trigger XGMI/WAFL error */
 static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,  void *inject_if)
 {
-	int ret = 0;;
-	struct ta_ras_trigger_error_input *block_info =  (struct ta_ras_trigger_error_input *)inject_if;
+	int ret = 0;
+	struct ta_ras_trigger_error_input *block_info = (struct ta_ras_trigger_error_input *)inject_if;
 
 	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
 		dev_warn(adev->dev, "Failed to disallow df cstate");
-- 
2.25.1

