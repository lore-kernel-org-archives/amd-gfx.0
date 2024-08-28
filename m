Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12E9C54EDA
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 11:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 790E510E401;
	Wed, 28 Aug 2024 11:26:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tcXGjLZy";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13B9310E401
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 11:26:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8WCfCNBy/ihf6dVZ81yTxmGw8U6Syg0hUz+c3wCnC7JYmd07xsAykw7kx/ghTe0Frt7DRUv55uT2KxlrDUpBvZ0XrVE+b7HPQOwW5UAvPMkemRuZ54Q4+f89AeU0RVkVDLub4bxwnxPlguuLK5mgOmbJq8oO4Fd/KoRcutCsWR5gaN1mJVTD5LR6s943ZL+fp+QszsqnNJEGzu/AnBWe2IrolfwnNBpwChsoOYjroocSARP6he21avGeFfMxxbud+QSnDNfPV9Fv72FqUH7rSDlLWZurwHG0hIyFzjqIggW7K+mTpSOMbaXUKHxY7blO/wjmV6Cf4Fve4x0WbkFcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=910WFqPyqvPmWvtE+of35IiRvMp8yo7mj3VJgGqySEc=;
 b=MK3SJDgll9ujwHFthygYC5FX4pf5f+RurtMzybFeTgFX3MwUaQ2nqIxmIz2kYVF2zCRAJYmaxoOYlYgknAJgvXLiVnXI6pUvLMiJdIxD0Nbnm1IzZPS2GmPCd6QfAq/05pgY85sRDYAURukKYQGJgDmSGdClo7PDSbgMKtlCOabHn5/M5Vl28/EQaIhx11P0Ps2drxwy3nXG1G61aevjIt/KD3PfBf5uvAbHilKNPEaobzA++DTIGZcr/AexXIpqdJgsNP/SbAoTBSjhFkO3qs9m2jKsDJa9WAGgIphPMnvN2Kh83sR9/EDaRAIq7VN/NGcNdt4MMRR6oWRnn0/BOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=910WFqPyqvPmWvtE+of35IiRvMp8yo7mj3VJgGqySEc=;
 b=tcXGjLZyxfdIjCNlMv64TtjZZ6tmbBQ5SyNwwPbwVR+HEfd5JzMOoeg1uzLUGh6F9HN18EUEd/UDa+weOwRpxcBqt33oSKCfaVEh+3mBFj2iB7LUOnS4o32VNZ8hwq16SH71eoeN9DBPfWZH3w6gqhie84db9FTDZ/6EbJ5J4b4=
Received: from BN9PR03CA0461.namprd03.prod.outlook.com (2603:10b6:408:139::16)
 by MW6PR12MB8661.namprd12.prod.outlook.com (2603:10b6:303:23f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 11:26:23 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:139:cafe::65) by BN9PR03CA0461.outlook.office365.com
 (2603:10b6:408:139::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Wed, 28 Aug 2024 11:26:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7939.2 via Frontend Transport; Wed, 28 Aug 2024 11:26:22 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 06:26:19 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: Add missing kdoc entry for
 'bs_coeffs_updated' in dpp401_dscl_program_isharp
Date: Wed, 28 Aug 2024 16:55:59 +0530
Message-ID: <20240828112559.83911-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|MW6PR12MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: cebbc27f-984b-4243-3924-08dcc7543ecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0WGvFHZzXkOccIqWjJjkazWzYUuBkVsfnNvzh80r/p1inFsWnKpcZosGnmA9?=
 =?us-ascii?Q?hcvctHd5BcunhzuZsm+RzPcOWaF02z0G8lZdJE4pOGOJaP5f4uOTotckZrj9?=
 =?us-ascii?Q?4df3TrSxsdvjw59r7EN4F2aRuKDsCyTb1W4lLYCaaeg6SzC2v+J6wH10iqws?=
 =?us-ascii?Q?NK8p+3/5PFf5xF8wSZsktOuTKZi0F7XMemfT0Tz1lH7nrgfSD+L6TLjAqpCJ?=
 =?us-ascii?Q?nzqhOja8qP+R5CPxskN08y2JYAFGZK+bIhpPyo4WEBpt7y6X9AIqTKg7cwc5?=
 =?us-ascii?Q?pCGv3K9YfbXVHU3jJqAytOP/lYrSrnNqjVDWNh75zz8vI6nF+62XD4zmcvhx?=
 =?us-ascii?Q?gMbnNwoGE3gTwujW3X0xlo3bBjUMH2SjZwbyM49/iDBfYSll4C0aCxqcTHsW?=
 =?us-ascii?Q?u7w7q7U71Diw4lc/x4y+UWVFWHfz9Xrp4CQvbO5/lOMqiJj9FtKwEVvBIEoz?=
 =?us-ascii?Q?Qnp0zy790zk1FQqsyvblD1uefe6a48QGjY6ijNiXyrRbobshjFuOQ94CWrbh?=
 =?us-ascii?Q?+45N1XMWMjNLUfM8Lhuywka8yXhDZg4RDbmZFXkvquMFRPbnqkRzVBPxVraq?=
 =?us-ascii?Q?r3cCKmpI0BXfaI6ounHYsYSovjISbcvNzsmC0iTxGefvUpOZ1I2OKzkMmr/J?=
 =?us-ascii?Q?HDXED042mwymCB5ZXpBe0bqLLy4sShWyrHp6EK3dTHT+gaO0dzfjePj5pY41?=
 =?us-ascii?Q?kVFYZh/rW7JwB8gPIFI6zblmR6JJrQAO1KiwWTlj41udHTEHkHrEWugoPi1f?=
 =?us-ascii?Q?2/VxwaMoQtYdzEFBx6s7PXxn4VzoTpkecueHlJiGfdX3t3Y51GwgoANl+53O?=
 =?us-ascii?Q?f0ZXxEhC3TDEvIihTpqa8hn/6+6N2jGTNV0O8g+bpsfEpPcG73cyrf99gOuJ?=
 =?us-ascii?Q?IMy0hD54Z/KhH4hYZJez/rDJSfIEYn5b55jApLBcnx/5buUuzcISHCJiJd2F?=
 =?us-ascii?Q?31kvzczdVs5xT342rfgYxFj85kzcWLF34OFtdjfqS+FTqc6Ba7Sr2/Wun5Rv?=
 =?us-ascii?Q?D752mwNin/i3ia+Yyp6Roq/0hDBjmBBqxVJEpMMP0p6cBgX2bxdGksiQ7liY?=
 =?us-ascii?Q?cxU/+iEEuEK1gORdSMGFAccL11UVEMFF283I39PLVQ3oCdTJqYwfNFDJnhJ8?=
 =?us-ascii?Q?ruCIIMJB37qUzWyA8dDPPb0NILqNi9pIkHc4/vmkqvA+XptRpySEwxawCDmx?=
 =?us-ascii?Q?Po9YVGEd0lsGN7AXzSwtdZq1HZojRe70MhCw/Omj+ETuCunkI6/hLH/sqshk?=
 =?us-ascii?Q?hBQ3/PQqlTyJdSQs6a48CrAW6DCd/cTpZraG8CKNto0CAB5bdJVnMEEMhzL8?=
 =?us-ascii?Q?pIfCR8H+HScnZn8+vs1cCzahQ+ulFcvVtdltyyn6AnpUhMFQnmrqyu4y21eR?=
 =?us-ascii?Q?EM7ibHoE7OIDfjpEO3+pFRhrJai/hJntbEn03FXpV99MYgS/+ktfTkyuEGzJ?=
 =?us-ascii?Q?aTX1ARafDURX7vcARhwY9r/1PTYGDf+B?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 11:26:22.3959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cebbc27f-984b-4243-3924-08dcc7543ecd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8661
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

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/../display/dc/dpp/dcn401/dcn401_dpp_dscl.c:961: warning: Function parameter or struct member 'bs_coeffs_updated' not described in 'dpp401_dscl_program_isharp'

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
index 703d7b51c6c2..3a3745597f0c 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
@@ -951,6 +951,7 @@ static void dpp401_dscl_set_isharp_filter(
  *
  * @dpp_base: High level DPP struct
  * @scl_data: scalaer_data info
+ * @bs_coeffs_updated: coeffs update flag
  *
  * This is the primary function to program isharp
  *
-- 
2.34.1

