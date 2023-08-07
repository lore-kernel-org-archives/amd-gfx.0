Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C000CEB64DD
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Aug 2023 08:27:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FCC610E055;
	Mon,  7 Aug 2023 08:27:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38D2610E055
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Aug 2023 08:27:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/J8ad9hukmas3qJECWU7NjdzPdy3snNVpOgQ1TeNfE8G8yWQOg+yc45P994XfTq/mwOzIV8xGDMFWMeYlg9//apLO+Nkpz5vub+3TZuTYLhvg9iXeVzQAEcfr2ycHZU9+uR7DwihrpxRMecKLDaQ4WmMz8Dni7/1UZCo92XW2MHgb8B8SnN4VzPdLCT9bO/dTSKL/v2TapEWCw2+i0wp1sr06Qj6T4rilvPzvJwR7Wsk1wckR6TmGr4876/LRQFdH19sJLfXn1lGfxXQz3PdJCH6tZza5K3YwQcQwr4AeWWVI17JeNyc36665smrkr8dRPYCLK9Ww9Z2/5OvB8Fwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3aDbqT0OHLRH4hRT7uRiYbOyv0c9CD6Juw4cZX2z6Rc=;
 b=UwmgJwx+/6vRbm0GbNNB1Z16rB9IWUo9RaFYhgXYJUqXQsrchxAQHVRI5xxpFtftt2zazTGStbfGrH/2BRUL/hjWOWW0KIBihgdpa62bgqd/g4yaDY3IED/LS34Flga8PJAMr35opCd1ghWOgkiNqO0VwNdVdTjX3ihi/Cfh1xAJfNufwHnqLm6DPuNOyE+AUratNozUR8Cph5dDkTs3sOl2oAkIpzR7G5yprrmw0J9YU7Qd9hwuFqRsmAW82C8Q1C+lXpgrAemKSFvH4hQE+mPka0hvDKbsx8DZH5JnwoEYjfBYUXepXq5sEvgnwgYxf+4stLIv12SIPawIS9/ZMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aDbqT0OHLRH4hRT7uRiYbOyv0c9CD6Juw4cZX2z6Rc=;
 b=Cno0lUulWEiGT57ibWajA/OtYfAHSmD3QthKzZyYjyqGZczOFcFoMDWmRp7Jws5UdkcJiWYZNt3hCb+FKL5MMaNCym5n2IjcyfoGPU13PYIzlHJ70rkvXw2ae0pxE4zd/EuGNzOU7Upch++iAzJFNeeZ0gRgpCh9fMVtMRwld00=
Received: from MWH0EPF00056D0D.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:6) by DM6PR12MB4387.namprd12.prod.outlook.com
 (2603:10b6:5:2ac::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 08:27:04 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2a01:111:f403:c903::1) by MWH0EPF00056D0D.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.3 via Frontend
 Transport; Mon, 7 Aug 2023 08:27:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 08:27:03 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 03:26:57 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>, "Pan
 Xinhui" <Xinhui.Pan@amd.com>
Subject: [PATCH] drm/amdgpu: Fix identifier names to function definition
 arguments in atom.h
Date: Mon, 7 Aug 2023 13:56:39 +0530
Message-ID: <20230807082639.135375-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|DM6PR12MB4387:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a6c278-0750-48e8-c27c-08db97201457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: urp57KL2bTlbv19GUjLp8HRTLOn4CsOsbIqbzwXYx8YJ2VHs0E0VoyjSKREAsdvAfZosKxMpTbkIn51Vkj4fhR/RooR6cpeltcGerx7ZIevDBfyvaIX82DPqV+dnoglsC+LKrYUcSPmpKnLRTBEYFH0rXsmuwNGZaC1H3at/8g+Rr1N8XvCXeJugTZ3ox2UJeGZzA8HE8ZTIhyGJEfKfuO4nHoah8x6x1+aYwts8NCvFQftLmUJlHq4WP46Sgqkc+sNQalPMt1itt5L1/qNSvjXEjj+lmK2/XvR58Tx8KLpgFSFH+dWw954a8xr1CL/Fxw40bT116eCog1MqDDcn67jHb0LFtYaYY/Ayct/b52otgwqxXpUm3bocE2L93PY7EP6nZJjatKiijXod0E+/kLyOAFPsKS+avph/MjQSBc14BG8QONt7auCscmx2GFBl5ylrZ2+wX91Mn/235oWumxi+4qCL6xh6MrgWQHHLJu7Tjf97nb8mUdb2zWjP5jBKvdH7b5Qwc5YbAW65tROajQ1DojoiyLALvg4UOhpFWjx3zg+07di0bEfj4/f5izVBjjfJxF/Roa0gLx5rCwv+KqsQAaNThRdmDaJX/5UwT3SKIUdVTH9GtI9SXN6fqmlhW4yLQwo1h4N1WWb5whjOZ0aw6rE2g9WM7azkYL/OgRGZXNA/OGPEab4YMsADWgdNwydqK9LUeyGKGiv119H1+NlxhiDn2sfs9g7POisC4Rmv5soGKEReWu9a2355d6ic0gwbdyv75qeg7Ks0elzSRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(82310400008)(451199021)(1800799003)(186006)(46966006)(40470700004)(36840700001)(86362001)(44832011)(40480700001)(41300700001)(16526019)(336012)(478600001)(40460700003)(1076003)(26005)(8936002)(8676002)(7696005)(6666004)(426003)(66574015)(2616005)(5660300002)(47076005)(36756003)(83380400001)(2906002)(54906003)(110136005)(36860700001)(316002)(356005)(70586007)(70206006)(6636002)(81166007)(4326008)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 08:27:03.7538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a6c278-0750-48e8-c27c-08db97201457
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4387
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following:

WARNING: function definition argument 'struct card_info *' should also have an identifier name
WARNING: function definition argument 'uint32_t' should also have an identifier name
WARNING: function definition argument 'void *' should also have an identifier name
WARNING: function definition argument 'struct atom_context *' should also have an identifier name
WARNING: function definition argument 'int' should also have an identifier name
WARNING: function definition argument 'uint32_t *' should also have an identifier name
WARNING: Unnecessary space before function pointer name
ERROR: space prohibited after that '*' (ctx:BxW)
CHECK: Prefer kernel type 'u32' over 'uint32_t'

Cc: Guchun Chen <guchun.chen@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.h | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/amdgpu/atom.h
index 55bf99d5288d..c11cf18a0f18 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.h
+++ b/drivers/gpu/drm/amd/amdgpu/atom.h
@@ -117,12 +117,15 @@ struct drm_device;
 
 struct card_info {
 	struct drm_device *dev;
-	void (* reg_write)(struct card_info *, uint32_t, uint32_t);   /*  filled by driver */
-	uint32_t (* reg_read)(struct card_info *, uint32_t);          /*  filled by driver */
-	void (* mc_write)(struct card_info *, uint32_t, uint32_t);   /*  filled by driver */
-	uint32_t (* mc_read)(struct card_info *, uint32_t);          /*  filled by driver */
-	void (* pll_write)(struct card_info *, uint32_t, uint32_t);   /*  filled by driver */
-	uint32_t (* pll_read)(struct card_info *, uint32_t);          /*  filled by driver */
+	void (*reg_write)(struct card_info *info,
+			  u32 reg, uint32_t val);   /*  filled by driver */
+	uint32_t (*reg_read)(struct card_info *info, uint32_t reg);          /*  filled by driver */
+	void (*mc_write)(struct card_info *info,
+			 u32 reg, uint32_t val);   /*  filled by driver */
+	uint32_t (*mc_read)(struct card_info *info, uint32_t reg);          /*  filled by driver */
+	void (*pll_write)(struct card_info *info,
+			  u32 reg, uint32_t val);   /*  filled by driver */
+	uint32_t (*pll_read)(struct card_info *info, uint32_t reg);          /*  filled by driver */
 };
 
 struct atom_context {
@@ -152,10 +155,10 @@ struct atom_context {
 
 extern int amdgpu_atom_debug;
 
-struct atom_context *amdgpu_atom_parse(struct card_info *, void *);
-int amdgpu_atom_execute_table(struct atom_context *, int, uint32_t *);
-int amdgpu_atom_asic_init(struct atom_context *);
-void amdgpu_atom_destroy(struct atom_context *);
+struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios);
+int amdgpu_atom_execute_table(struct atom_context *ctx, int index, uint32_t *params);
+int amdgpu_atom_asic_init(struct atom_context *ctx);
+void amdgpu_atom_destroy(struct atom_context *ctx);
 bool amdgpu_atom_parse_data_header(struct atom_context *ctx, int index, uint16_t *size,
 			    uint8_t *frev, uint8_t *crev, uint16_t *data_start);
 bool amdgpu_atom_parse_cmd_header(struct atom_context *ctx, int index,
-- 
2.25.1

