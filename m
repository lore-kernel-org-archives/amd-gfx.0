Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3F4C369AB
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 15:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72E7410E7D7;
	Tue, 15 Apr 2025 15:00:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bt2FgTSS";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D914A10E7D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 15:00:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=peXVSMfk5X4N+7MpTT4cPDViKkfpxrjXqkZPYSioi3iVEyK0Wil3MtWVfRosO/zPTL1Nv6Bsciq8TYJuuQhrl5lkfGpS+to3dkeTuO59jS2r2aKTRQ3dGroJXirHhEDsZdj/VUqbvTXJixDlugq6WKmoyhhCm6VAzeSlSzi2XYpo3cNy2yI58Ra5rnvhaaDBjVBvmgm6X/9GyTK11CAJmZ+oH3xQewIoa3jif5tcrywJvx9BEQolLtJRwd8+YXE+9ypxx9Hb7oQUBX5z2kpFcjs1x/nz+PQcSXiE5s4WEX6+2kHfnt3/1m9bAxRrB49m6ZfSNoT+Xepp6hsVm7uirA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8rSoNSjYSZEfPg1CX16wgDnRO+mOkjkHXcJqi8NzAI=;
 b=w5mwspdlRymhS0ZUti8i6yDMELVvOvKDB9cjMuRvQhmNGBdgyc3k7xcluGGz1L0w91LtNrUia3kv0/t9QDYvsJItwc4QswnSSbQXwdx70EZFsvMdblSn1Hh8oO9+vWPaDAFvq053QHTVaSpx1gCrqFYmxByVqA8Gh74KtyWZvrwrTmHwVMa5aPEh57iqEadgi2L81RoLLtXxFP+YNInRGKbib6NpSCJaaJD1PsJ1m2gebSQXvf8JOJws57Aut7gZO4dvsZnyB6i7MLeUAbm5dKQUxVxMghmn+2VIrkDlWJNPh4U4JRC7zdPgMs7iktkn2afeI9kFCREqGyo2/MNB8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8rSoNSjYSZEfPg1CX16wgDnRO+mOkjkHXcJqi8NzAI=;
 b=bt2FgTSSr5qAIR9MshKVL/i3dZSAnc5qolpUQsOZeRulb890gMuBH5s51GFwt8Lhz7L5CYwsuTpysB1lHpmGEwdyK8k29ALZHpgWAkqWBFLkCTEIfARVa1Mh7nz+6vvFFEYvEtoNCxc2f/TVl8XlnX3HsDN9Zf0rsowsoBhRVTE=
Received: from SA0PR11CA0167.namprd11.prod.outlook.com (2603:10b6:806:1bb::22)
 by MW3PR12MB4474.namprd12.prod.outlook.com (2603:10b6:303:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 14:59:56 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:806:1bb:cafe::8f) by SA0PR11CA0167.outlook.office365.com
 (2603:10b6:806:1bb::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Tue,
 15 Apr 2025 14:59:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:59:55 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:59:53 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Renjith Pananchikkal
 <renjith.pananchikkal@amd.com>, Mark Pearson <mpearson@lenovo.com>, "David
 Ober" <dober@lenovo.com>
Subject: [PATCH 14/22] drm/amd/display: Fix ACPI edid parsing on some Lenovo
 systems
Date: Tue, 15 Apr 2025 10:59:00 -0400
Message-ID: <20250415145908.3790253-15-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
References: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|MW3PR12MB4474:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d1cee9-f654-4915-517d-08dd7c2e2f40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WG0Np3om1xzVVgMNS8jmSQMmXeX0xaVJ5p6oiunpke8qfsUkoTKbHgQfsSvo?=
 =?us-ascii?Q?+RLbMdH5M52U4bPy+BNC5Dus4cGXzBwiWdvZefmggg1maX04oYaZ79mm0q/M?=
 =?us-ascii?Q?TeoLnnKy0hr6WqWP4zG1HYlhGP43hr+gC288bX2hm/t4CbrDpFgTAtNCjqUf?=
 =?us-ascii?Q?Z3F5QDaJ/dCN2I2qmATy3JY+DEtgBWfufIJtj1e61+rZ9QdTfaipcGNUzzZS?=
 =?us-ascii?Q?l6hX2CUZvJmVzuijOI4fnBu/aF6Mij5duMhVuxu8s2OSHkduShJHUJPBXBwl?=
 =?us-ascii?Q?QF9g5iF7npiR00yJBcMaFcgItjvozsgs0aeWY74a02Jhqx8pQZeoo1wHmnep?=
 =?us-ascii?Q?zVMIiJRi1EUQ3CrRQ3FEnJM7sLWtJW0weVsnJXASTa12+5O4lGFol5R0yavc?=
 =?us-ascii?Q?wz3Ri5TlAEwg369J5vdtsltRwqXxqLpvMtVeXc36cF/4g1Qx8tEHJDuIIf/a?=
 =?us-ascii?Q?ySDyWpCujZTi3Dl9he5F4EtPCyk6WxDGHRtY2E7SxLzF5eRlSimSVKhCDfyP?=
 =?us-ascii?Q?PqS2xnH8P0gLkY8SR4n7Iw4sHeA8O5cGUVRr+rs9/XyRr/kR+poSa8H9mWW9?=
 =?us-ascii?Q?USw6fKrrPqkrtnnsowfA/52Jwx0aYdGh6VzMqCu/N++MADiWPOqDmgt1mAmM?=
 =?us-ascii?Q?Bgjv3ZHgsd5bMoCw596oXlDmz2MuVcbLYVCH6hW6EgRyvatJjoY0IORRNI+p?=
 =?us-ascii?Q?/CaXyaxQJ3vpwpcFCb1EydynlbkqQh5KWbJJLGBQFTs7fDjvx/osVFQqj+R+?=
 =?us-ascii?Q?GZtiV2rgcBkJ6WfoYOXHgQKm9r1tTON8jT3l/jfJeVKoC59EGRFSv/1KVoem?=
 =?us-ascii?Q?/Y0aSa2U+iT4mAENYHUq9IIk9tJKaH8nxr1qcaReSHv45mUErtz4qCm9IhbW?=
 =?us-ascii?Q?OI95DYuSVkoyEqg5v7T1t8d1BpRRbIrQXtkQAIETHcGG8JuKzfXTUPqEeXzE?=
 =?us-ascii?Q?/ny2vgmJJfUXWyXRKPJYkdgfj/oPFJqvudozsUkwn+UpH1U9+yhoPyv+mklI?=
 =?us-ascii?Q?gUV0Jkurp32M6uhv1Zmr6c9D5NSqk5UO6WLE6HfPpstQvbWjug5NED18Nafi?=
 =?us-ascii?Q?qK+rQOvKPNAuPfTQJ28xKjNFKO9MXbaBiOVgN1HLr8TXSzHIb3LuM9yrZyrR?=
 =?us-ascii?Q?9EFrqNUEiIumKYHBSUBNAkW+lj2C0LmbO8nH3XbQg24k2az+EoXeMJrROmS5?=
 =?us-ascii?Q?D4q+IiQhv2ePcN4CUjaVQqeVugTeK9T1kXa0I4tGtGBgYVXBYOR/X8EJT7ED?=
 =?us-ascii?Q?oJT60hUGZe57B7ZXOImLJHrdXF85kE56iK+CIiemY7laT0yzlzoiJUIojlXW?=
 =?us-ascii?Q?JVxWBTwSxrt3Zpxzo7f5E4lnlmlZL7BkJqP5GXGEpO1x8Rc23QkZnJIzc4ML?=
 =?us-ascii?Q?/iDiqhp5H2HYu5iK0rsBnAa59WIIkN1gX6Xe6eNYwVnK6f4+mwyWs+v0LIbI?=
 =?us-ascii?Q?dAJGC5Vq29uGGLoVIIuEP2+IQbBsjAtGhSFDewWe+oZCF3tPF7vCSI7xNQ0H?=
 =?us-ascii?Q?9FboXCPFpwtKkN0ODG/wkycZCUvV3QbCC+eO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:59:55.8937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d1cee9-f654-4915-517d-08dd7c2e2f40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4474
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

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
The ACPI EDID in the BIOS of a Lenovo laptop includes 3 blocks, but
dm_helpers_probe_acpi_edid() has a start that is 'char'.  The 3rd
block index starts after 255, so it can't be indexed properly.
This leads to problems with the display when the EDID is parsed.

[How]
Change the variable type to 'short' so that larger values can be indexed.

Cc: Renjith Pananchikkal <renjith.pananchikkal@amd.com>
Reported-by: Mark Pearson <mpearson@lenovo.com>
Suggested-by: David Ober <dober@lenovo.com>
Fixes: c6a8370 ("drm/amd/display: Fetch the EDID from _DDC if available for eDP")

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 62954b351ebd..d4395b92fb85 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -931,7 +931,7 @@ dm_helpers_probe_acpi_edid(void *data, u8 *buf, unsigned int block, size_t len)
 {
 	struct drm_connector *connector = data;
 	struct acpi_device *acpidev = ACPI_COMPANION(connector->dev->dev);
-	unsigned char start = block * EDID_LENGTH;
+	unsigned short start = block * EDID_LENGTH;
 	struct edid *edid;
 	int r;
 
-- 
2.34.1

