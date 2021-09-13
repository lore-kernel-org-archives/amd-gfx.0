Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065A7C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 19:11:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C56A660F12
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 19:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C56A660F12
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6356689CDB;
	Mon, 13 Sep 2021 19:11:50 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2068.outbound.protection.outlook.com [40.107.95.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8C3A89CDB
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 19:11:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2TVCJwNPaw7yvOJmIpJ/0TOehuZKgg9ti0FxvLn8zqGc1AdFSCZk1cfBIWonyVnH59biG6tv6BP0cchXQLd85chrxtrqtKlJUkw1HnoJ+1a7/N4Txl7tbh1Cmo/Zhn4ljq5ma8oCbKeIb56MvDLk+QcWL1aHYVhukICZS5a6q6yjZPWE2qi2B/C/NWyHOwdqgexO1hxHqSv8sGLejQ3Sf9xUPp2YbnzBVboWfPtF69AzJ6uizbkKn3qF9CDWmaFfggdii7+oM77YN8o4d/i1QEhyLbsbAGO81Yex4QvAiZAQY7+Z5v4RzpUMteyEjD0sUUj4vYQYZZRCGVb14gFXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Myl66Ww6kdFOTgX4ixmRfHSECw5SAPVvFonNUUqz6TI=;
 b=RhsHHxys1wZgTSNj7ykDDBJ8N73i5FJfh6aCRoqeI/nHMbe6kmB0rIGf2n2gC3CDYZ9jj2XCzQESzgM3+oge18cdwY3W1q4roZcGzbSVdv9L73KuaQpeiwjgkzYZ3dSsoRYw4cnu/dICeMjCc+00c5PLqdhskV1/ztQ3kchhK0iCkSpV+rLYVySuHpBbELGmGYebTUvAPqEKkJosX7h8R5fKp2C/y2jW11+6EDAO+2W3uvI8h4jeqRWCC9T+PbaPqwWk7xuBwtQZqdRo5vAeKSgdb8DmhreAf37sMOHqZ432722VeE6DMvshWbUAUf3yPztCbsftYG+9bdR3ou5VxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Myl66Ww6kdFOTgX4ixmRfHSECw5SAPVvFonNUUqz6TI=;
 b=rcUIDtoeuh/I0rEHzZoIZ3JNoG7PY7rBn9d9gtWsigm5Dh6k+WHbKtLgVNEcPw22sFWU7co4S2GY+aTkK8IUH9Zp0ijuzaHR8oHZA1s/65vM+L4yWzHJnVnTvYjlZRZ8YSrZgJLJscZnEkrnTJVo1CZPN0Uz54NxYSfhSd5GtuQ=
Received: from MWHPR1201CA0018.namprd12.prod.outlook.com
 (2603:10b6:301:4a::28) by DM5PR12MB1659.namprd12.prod.outlook.com
 (2603:10b6:4:11::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Mon, 13 Sep
 2021 19:11:47 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::f2) by MWHPR1201CA0018.outlook.office365.com
 (2603:10b6:301:4a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 19:11:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 19:11:46 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 13 Sep
 2021 14:11:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 13 Sep
 2021 12:11:45 -0700
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Mon, 13 Sep 2021 14:11:45 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Aaron Liu
 <aaron.liu@amd.com>
Subject: [PATCH] drm/amd/display: Fix white screen page fault for gpuvm
Date: Mon, 13 Sep 2021 15:11:36 -0400
Message-ID: <20210913191136.104609-1-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a81e9b0a-4831-4239-d85b-08d976ea54db
X-MS-TrafficTypeDiagnostic: DM5PR12MB1659:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1659A8F419242E293E11E55AECD99@DM5PR12MB1659.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K8k0TTzeSTr4C26jHVAEbbvsyRRZLjqPEia+XQRvVMJtocOydsvQtbXJojGmGV2J/6JZQtlY6/Az28iofth9jc1yaCBft3xpb+MZaH5QPiQvhSbbVtaXK5m7NrfZp4HuR3vRL1QZ2u5jjU7xHftsstGD40x8SjitMTmv0UU0iviHZ90V4UHuliDXNEz5CGDSQ/TVyVNDSDEk6rXe4Ux5jhHYUso3RBdVwAYo753jE8mtyzwi35T0VnTY8tcon+9NlDhm/oHEZhsnjKDE2kS5Lcc0y4a/ldFVvKbqJsP/XAVoX3NRkOfa+PTfp40IwIiA31g0EJVP3XRpyu+NvwbMyVF4mKhrjwYKFycMRum6HKsZ6KO/jcWtBJmlDUKQ8lFmWbwU0cziIyzoIx6DKDVuXsJAjONYOsW1KnNJnScMd8ew+4FJSU1HUhCCFtIBJPef7xviO9CKRQPSVTpV290AOGX7hO+kNQMau2BAGEyHrPlYgvfeVIGzI+Bu58xzzNwz9XzogtScFvnD2kSZO8Y766TzvI1NsyRs9gEv/DxqDLCWQR4rCUyqIR/OzVGHuqYe8bS23S71PAbwK24+MNiztGbilC1Uga7320yecLoIAWgLx17Ax5iw9EZUU30OfdWGJy3AnU0D0v3E14ciNS6Obr3Afd7CdlUBPVtN+3nW0wFFKKzW3Q/ff+FGOMAYVMrx7zY7w+S9mUSM5gw+v4sep39Yt6dpOL84vt09+uA1nwY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(356005)(36860700001)(54906003)(316002)(83380400001)(6666004)(6916009)(336012)(426003)(81166007)(26005)(186003)(5660300002)(44832011)(82310400003)(4326008)(2616005)(47076005)(86362001)(36756003)(508600001)(2906002)(70206006)(8676002)(70586007)(8936002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 19:11:46.6072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a81e9b0a-4831-4239-d85b-08d976ea54db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1659
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

[Why]
The "base_addr_is_mc_addr" field was added for dcn3.1 support but
pa_config was never updated to set it to false.

Uninitialized memory causes it to be set to true which results in
address mistranslation and white screen.

[How]
Use memset to ensure all fields are initialized to 0 by default.

Cc: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 53363728dbb..b0426bb3f2e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1125,6 +1125,8 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 	uint32_t agp_base, agp_bot, agp_top;
 	PHYSICAL_ADDRESS_LOC page_table_start, page_table_end, page_table_base;
 
+	memset(pa_config, 0, sizeof(*pa_config));
+
 	logical_addr_low  = min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18;
 	pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
 
-- 
2.25.1

