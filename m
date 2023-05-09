Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3B0C77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:20:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1BBC10E40C;
	Tue,  9 May 2023 22:20:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AAC710E405
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:20:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qx2kbIuurpJAc867nmoXmHdDhUc9+38HCFpfcbxqvI3jVuNkajLe/dKj+L/9y2rvDjKLTBaqFj1mqSItn8yJ7SZhpB2Un1NUgtIChug3U7UKCJZtehdZWI12aDkpq/8lZAfy3qxJn5yD0e7LI4PEJpy24TuCUnfs8zN4JxXi7XZI2Yfqz+gVU1ze5s6jG+F9mcpbH70X3IYtYP8CKsfip+KVFGvDp726BEyAiPz3StwmSnv+sd3H3gaXhPZu7QKT44ou4+8OMA2xPxedVaJgd9Pn5/ttfi5yZQmO6m5V/avwnQ35vUDWnKfFiYfKsHFQo/8R+AGI+cmGgYWjmqOlsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smRSHgo8v4JFb0+KNeMuKetuPwPvGhCLDI5xPD6USJ0=;
 b=UosDs1HfjrFr844DF8rX1J5GcNP7kW1h48GJXcQB1MPD4e87W2wu1rim1kT5UnEWlHUK8txfC1fT3VRK921+tAF63Oa7t/xHpBcfV5hc8UVU7hUCYvI7X50O4v68WtN6X+hnEE6UL4FFpBkA1ri/LBkLLtsWH7Cbav8s4VWlHkJcOGh13bOoiyCYOCAQNcfxnF/nmu6IkRASQNIVzspmJSrQQ6TsaV6nu3qTELsjy8DaJRf56w4dVKUZVrs0hfwGr7/dJdVx3S6r4wf7cnIcL8anZ3M8lUgxrA6RStHuX2MeUu/EXXMcPw+gE1U+Hgqm4Nvm5Z5VCDWCmXNOJINfjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smRSHgo8v4JFb0+KNeMuKetuPwPvGhCLDI5xPD6USJ0=;
 b=F1wA+KwPY4Jcdv12a+qbAfTJR5wm74tZ5vbZYELB0oUA03NzbW1Nalh+BIhfSXMaMDwsQ9GWoKdjqzDdhKQY1iheHUtIYznrqskJwrCx0uSCi1eWMqSuJUzi/jq+iuYnX3L++N3RZylYEsPnkBRpjNIBfzrGmN3q20rbpWjcnZg=
Received: from MW2PR16CA0035.namprd16.prod.outlook.com (2603:10b6:907::48) by
 BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33; Tue, 9 May 2023 22:20:29 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::a6) by MW2PR16CA0035.outlook.office365.com
 (2603:10b6:907::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:20:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.19 via Frontend Transport; Tue, 9 May 2023 22:20:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:20:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: Add PSP supporting PSP 13.0.6 SRIOV ucode
 init.
Date: Tue, 9 May 2023 18:20:08 -0400
Message-ID: <20230509222011.477547-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 4679f471-5b9b-487b-95e5-08db50db987e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eB0J2p3oux70JjFYm2sKqbQEGr9M3TsQoABWFrpyV3bu6wIDpFBBEXHFoMuYXQAdO4GD+MEjG9lpmCVulULliqNIGia6frcQ9oy+ey7Uf4Zy4owhe84fAyA9oBu75Pg+EghSXcGSCttVtwaIGO2e1yofklIL45jMuaWg7DTecrAv9+ond9eNX0DE6q0wriixI4djfs1UeBr71+c5VuauDmguGBnYVCMkRtWtNh9NCJFwd23jSWQZRWV87WAqKppdW5J1No777zFtdXjhO2hrjlgBYrhzdX8ghMYFy5gk65Cb2PFsnQ+1p5X9hSG53J//V78zBGdIPQ/1AAp82G7G9PKdblhf0ScY55YWEM/psNWa/ve2ZA4eGB1z1r+BJcU8ikEcn0YwryqmDGoKEMaBFE/Ps1Vwxwl8SEoCxnQBeZm3Gq0imlrvfCaUR49Ce3FAX9xKC7L4poB77dpASxOOCSge+YLUXpIweT6bkOnGsNJVD9WRtcjAwXpBskFEVvFHZWVPZsyHcrRPkx42jT7ngPUzH/DCXZ4DRx+ZIbrgEkJEkvzvccXFBtdE7Tsj03W8yq/tUxOJDJp/5R2mw6n1hPaF7KXmsMIuKpkeuMRjpJIaWj8Snb1BPN7U6T/2fpyXIZNzUcpLhna4SKWTTp9LaCCwXxcBDsR0RB1uPTVPRgUWNjzrO7c7XcTvarS6xZac/K+OGyvXyQx9Q8f1+G7hT4GaUELC8TftCcqUAw7x2Ng=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(36840700001)(40470700004)(46966006)(54906003)(478600001)(40480700001)(41300700001)(6666004)(7696005)(70586007)(70206006)(4744005)(2906002)(316002)(4326008)(6916009)(40460700003)(82740400003)(36860700001)(5660300002)(82310400005)(47076005)(36756003)(426003)(2616005)(8676002)(8936002)(86362001)(186003)(336012)(26005)(1076003)(16526019)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:20:28.8143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4679f471-5b9b-487b-95e5-08db50db987e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Gavin Wan <Gavin.Wan@amd.com>,
 Yang Wang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Gavin Wan <Gavin.Wan@amd.com>

Add PSP supporting PSP 13.0.6 SRIOV ucode init.

Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index d62746b596f5..ec79a5c2f500 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -146,6 +146,9 @@ static int psp_init_sriov_microcode(struct psp_context *psp)
 	case IP_VERSION(13, 0, 0):
 		adev->virt.autoload_ucode_id = 0;
 		break;
+	case IP_VERSION(13, 0, 6):
+		ret = psp_init_cap_microcode(psp, ucode_prefix);
+		break;
 	case IP_VERSION(13, 0, 10):
 		adev->virt.autoload_ucode_id = AMDGPU_UCODE_ID_CP_MES1_DATA;
 		ret = psp_init_cap_microcode(psp, ucode_prefix);
-- 
2.40.1

