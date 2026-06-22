Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27102CDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA02210E531;
	Mon, 22 Jun 2026 08:23:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eyfO9DZy";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011057.outbound.protection.outlook.com [52.101.57.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 411B410E531
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:23:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWJwXQ+6AYLNgZU8mgcfDt8il8vQY0GQ2KzlxDBE5RrROmitwcXfTHOBUujwABUQmszFoUBqYu92NdhzAwfSm7y4Pfm0Qls2xMVfPslFIS7lR5tygke/IVlFv+8DBVqwKglWkB7h8SgYxk7GFIkcbivtJMyJ1ej5MkLtUEFkINmpZy+ZXKrg87LCUacFrKsIGT/lZLO7ONw+FG901yCeV95lA9gGqKRB6vUyhuPhNjbSbdlnk36PpUW20hrf3Rnk94AmHQu855EVhAtXSsPRifz5US/2OynFF8FVHbCYyS07CFag83kRDq7pxi1d82kQAkH3oBZFHgdj4pYc/fAVqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTFLFN1H6fHYCO2lmM8xDeEzdOLXJvdW4VmUAqSOtZU=;
 b=kCEXp4tJQMsPWozhuvDLHSiXA90KnWn5mRDIEu2++HUIe2IS8lB6C1oZjhUnO74OoDEurctLA5avWub83lAX1UBu8c0JFIIwFfpofoHo4pKLItUZ4pCwdQkZZhrcIYgS+TEP16BlmU4U8uv0FZfXsGQleruJENMWBEhg9fb54j+HIghWztuSi8xO3NIORHnRBdlqSWd40p5aK9O9wol7hzHy8Nz2AOySTbJj+NmwwqsNL/qYZ8/OmdErnd8lzfsJXPkJOruG6LdBBdY1OXHuGwg8n3Uw7GjLft3PZPtUOOlw4Gx0dY5xLR3h/3jQUm41EBBij/ZCOrPCJqdy9ejH1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTFLFN1H6fHYCO2lmM8xDeEzdOLXJvdW4VmUAqSOtZU=;
 b=eyfO9DZygnJnIE4ISmyX+wWU5Oqj6c6/kf0KvXVuYjsBwH02XlfNWTFR1zsrm8h8zQXF0L2iSfgwTSh2itJqqK7up0egdyfguXnATW8FwjWIyoXFioF2bjO2XJGqfDqLldmEKHklnI2mjMHduwlArxubXdePZTgdGdOzUMtAt84=
Received: from DS1PR04CA0004.namprd04.prod.outlook.com (2603:10b6:8:44f::19)
 by SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 08:23:21 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:44f:cafe::38) by DS1PR04CA0004.outlook.office365.com
 (2603:10b6:8:44f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 08:23:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:23:20 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:23:18 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: re-set ClearMcaOnRead CE/UE in late init
 for uniras
Date: Mon, 22 Jun 2026 16:23:09 +0800
Message-ID: <4f4a3348cabace3a7a192761b6c89aa1147555d3.1782116341.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6396c0ca408e0d8806a0f06467def1d69bf0bb75.1782116341.git.cesun102@amd.com>
References: <6396c0ca408e0d8806a0f06467def1d69bf0bb75.1782116341.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SJ2PR12MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: 522324f2-b52b-496a-a19c-08ded03784b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: iJZM+bwyARBykwxxAvT0F2+1IQeLCTMQUkqI/mhQJbqDAZllszTnYL/Z3oO8qJGKc/JpwypzqXlUz7EbRvFigykT218lCDdjG8WXAweVhSQuWVwPnQFrGgQ7RFNV8GGzM4PfmHbpTHr7iPwXQod9Hlw3nkYu6taG6PzJBIyo+0c7Yg2plvB3ZP7Gk/S1edgTevdtmwNdJHf3OZsEb8Swsx1uAYjAEI1UAKbUshvzvV9eyCru5P18O2aacPIItAXUrgUum4RVrUdcXUUKrLNFACbco9+qoVs24i6n1KFGmJPko+69i65jDNKrJ3asa9O7Pk2vvu5qVgYWBQ1YKdcZAH0tZmAYSaR+5fVaOVp9OT0mGbtrIYO3xmoLTt49hZ2EtcEn0NGXwNYAGrs7f7TXaVrkNEhrayIv+Y1xgOcsHOrZPkt7ZMiqz23ewTL6ukyZeZdXL0+s81dQ3fPoxt54oKafJ0H7StANUKvXXQv1k3o6YZfw0NLMNp2nBzNziBAocFakyysHgr2JcenaPoqaE1thXKPgWc8fDNSinYacG0+1+KbKK2znprwvH5+GevbQjIZq56cZHbXSHCmTGVwv4PfWujQTB1A+vlaicvUz3tkVqUlOG+DNKOBwd3bOjFc2weXwtq1e3o75533/x1Es2a2NKc4tYPPZWoTUmJpAmWkW08+11zzna5cuu4BwIeAdq9rIT7odhfMe9N1FEeQ4Ow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fyQYZoYbo3lrKJVDKJBI3DtP4I8Lm4gSR9YV4SHEkanh1JjAQFpV56lXZxVaq/z5aQud58NzxEKN6rw4GUuZ+8WuOAQzNKFykhdxu2+LRvW0Bizdc30SK4JRjC63afaOWzayRubJ6xMC9NIggaSZneHc3iVfKawtZfxO7HWswFDN+pVT4/JPURG17uxmgxxXHYxh4RTygRyl6OV4WvQQsE3fkll74EMcMp0JsJVB46tOd5ZY6WyG8BdR6VjQVPuEZm2/bm0kX27mb4EgRHiIhlmOTfqhqDvt13OcSUQAER4kf8OAciz46nED2lBt81UZ6eIc4YoGx2IwepHkMx+Y4Utg6eYvl3oPTlBrJwCzeOVdE4E90Y9Lx9Lfa1xFLdWm/7bwz/9LWnACDaPrjaKOUoVbB+oSDoidnEm82lJP8zIJdBd3pG8A7aFshoAckShh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:23:20.0495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 522324f2-b52b-496a-a19c-08ded03784b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210
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

Re-set the ClearMcaOnRead flags for UE and CE errors during RAS late init
to maintain correct MCA error handling behavior

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 465f82c660f2..953a35ec93fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3903,6 +3903,9 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_ras_telemetry_en(adev))
 		return 0;
 
+	if (amdgpu_uniras_enabled(adev))
+		amdgpu_ras_mgr_set_debug_mode(adev, false);
+
 	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
 		obj = node->ras_obj;
 		if (!obj) {
-- 
2.34.1

