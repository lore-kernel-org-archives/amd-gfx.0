Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA01FF8868
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 14:56:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C38E10ED10;
	Tue, 28 Apr 2026 14:56:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KB+ssGPn";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010027.outbound.protection.outlook.com [52.101.61.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71F5210ED10
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 14:56:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=waFu0mjg9iJWN9dBKJ19SKkkHun6GAIGgBG80QiITfpP0W0II39W5jfWHZTPs19xxts4nNr3Jv9U0IjvqgVMPA2AAX2oRf2zdVFf+PCIb2xlGV6xamBT8vTCC7HOINaL0mrE5ChDD0uY+Dv6VGFUR1OkNHQn/feMJ0hcEkmdJbH/rlYIjAN5U9ulageC2JgJrwRLvWwnBCUaxBvtozF17vxIPKrmoBObhDBvFs4X5MKhkBkjqz4OtPtwjaNOdOdQqYM/fllSUjo5jvs60Phc2+gA2uw3vC8cASZ9RkJPjm8eeR0SqwybFRarXkKSPyaChyZrhKgg2Za3zFKHKK2WlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYmY5gauzSIlQjZ5t2JJyyc9Czqr7ooxb/o+h1O6Ua4=;
 b=CJtQOL9GWglGbzDcWJEma87glfGKEdSBHD+rqK+raHaMrEeIYnN6pKF/9Z7z6gPwGidAliXWWCPikOR6zU4C2Qed5O2itdzu+e1m45tnM/Gx0At7/pYytksSPsVNoMUvs6Ni7Opgs8T6ZPfEhID1T99vsiawgjzpX4p+xnftJBXYGchmFTpELvgeAxMyWO9MfQGH4yGhm01kvPjTxEvIkUe/6I35yRQUW3cQRPh9/HauQzWj0BbkfHHNYjmx87PgIgbrQ0VnAXjUx8WG8SSZd28fjn0/M8h6SHrjBFUFKSC81fWZCkQTlb9nPK8kh0KoDE5cDRekuvH0pczRHCZVqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYmY5gauzSIlQjZ5t2JJyyc9Czqr7ooxb/o+h1O6Ua4=;
 b=KB+ssGPnthYHemoAb4PoNFm19erUmRQXjVsfEqcaLSqAiBp5S8K4yZTbAGPs/BFdLYW8i4+fG8jMTsig0U/yiOsr0WnXKhKtZ4EEMXnkxlNyfYp2JXO6u/IoLy3RY0u9RH0fLcHe4wM+Ic5OlMOSMQj84z5SvGr12VdAx4+CabY=
Received: from MN2PR05CA0037.namprd05.prod.outlook.com (2603:10b6:208:236::6)
 by DS0PR12MB8816.namprd12.prod.outlook.com (2603:10b6:8:14f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 14:56:41 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::d0) by MN2PR05CA0037.outlook.office365.com
 (2603:10b6:208:236::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 14:56:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 14:56:40 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 09:56:39 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Apr 2026 09:56:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <timur.kristof@gmail.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Kent Russell
 <kent.russell@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/pm: add missing revision check for CI
Date: Tue, 28 Apr 2026 10:56:18 -0400
Message-ID: <20260428145620.1480646-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|DS0PR12MB8816:EE_
X-MS-Office365-Filtering-Correlation-Id: cc73185c-8fec-4753-d9b1-08dea5365ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: JgWOkTY09ygjfFf5CA3a53m9TYRI595NQAjQZwkx+kT9Ux2WUTVQe11UrNPs1+0z6dU5JizmYNaW2t/GbHa5tXTxfpB9OnbOISsi81gT5gUjRi1ZR7DXeZlaOwS4ojcvfPu567bh0VzMLqJw1dRTOnSWNv+Viua61N2m8n/oipP4uPUqVAEoa7wFZJGc4EumuvEOYoe5itiZMGwVP7dBPLrrc6abIe6tOneRPnUYb302AuWQvu9y2xVl8xBFEOceJZc4QYJYfFIyVb7I90lMqN78n1+76PTddE3NELg6talwfeSwlbk1dz3ZEa+ZT/WW4L/43DKVYB+wV0c7l12h7s0MkwLco4pdPTmeCgw/ED6Ev6eIYHOc/t9yvGS2ufQHt0yKVk6Z104TFGZpmHgM9C1lajB4/8LMLA2VPwoVdtTXUCPF6Q/OHh0IRyeti1jwNSasv8Z6NkLQQPVBvl43U/tZ4Fq0carXUI1446yjATktLnLiyeHcfvuuYaec9kwkb5I702YexkjTBvNHEyxxUWZfCVwo2Rgedb/iLcsIu+eCAtxLoR4PD1kvHHjUsmJ8XbUUOz9gMLoCsT8h7ATxS4oyUKbWloz7KnH6nMxJ66/QCRd0Xc43apc4vLHCyg4RdAQuWo2LnQz9rwNV5hhxfF18ah5WynjkeWRfe84l1inwVoxpRYT87AzfNjp63bP63/R/9Fs/jlqA4th15GM3cbNReoqYlCzMevZlVHrZsz0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(13003099007)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: InhFHt/h4B6m9kxJjmiPGwEQoKaYOvMEKI9jYaMfFu/r8XSV3Sh1c+kgr+0TscXRH1hMeJPIePM1iaAvq4bh3pWLMbJgImaySpjkmo5/65tinN+45MkpYlxlS1Me623EcOZ1BeUyG8zcoVIiD3nabY7zEZp8s6EkrWAUqo8I5TVoBj6d9hlABG58K3AH1LDGpdx4Q/2tmxJMpdsWqDqkLcZa66RjsS5ePyWJ69KQq5omuVVDbea1IzQHcHjWMbtyRZCMtYO3afrWJ0LhP02mHr2XYu5oHZv7zVy7IB/03Lo78pShnAMvDI9EFlTBV0Mbpnj4Mln7Aur+1BxVclx5Dv/eL6mtESw8nKFkKI1SMF50FyYaEzisoL6c/08SCixkj5zHrxlxAQwnu1alr6D8vgEIVqkuut0byvZQ7+lqw2hezOhxC3vHzpyskSnMNtHi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 14:56:40.1479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc73185c-8fec-4753-d9b1-08dea5365ab6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8816
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

The ci_populate_all_memory_levels() workaround only
applies to revision 0 SKUs.

Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/1816
Fixes: 9f4b35411cfe ("drm/amd/powerplay: add CI asics support to smumgr (v3)")
Reviewed-by: Kent Russell <kent.russell@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
index 69d8b05ef2457..6e89a032e3dcf 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
@@ -1333,8 +1333,9 @@ static int ci_populate_all_memory_levels(struct pp_hwmgr *hwmgr)
 
 	dev_id = adev->pdev->device;
 
-	if ((dpm_table->mclk_table.count >= 2)
-		&& ((dev_id == 0x67B0) ||  (dev_id == 0x67B1))) {
+	if ((dpm_table->mclk_table.count >= 2) &&
+	    ((dev_id == 0x67B0) ||  (dev_id == 0x67B1)) &&
+	    (adev->pdev->revision == 0)) {
 		smu_data->smc_state_table.MemoryLevel[1].MinVddci =
 				smu_data->smc_state_table.MemoryLevel[0].MinVddci;
 		smu_data->smc_state_table.MemoryLevel[1].MinMvdd =
-- 
2.53.0

