Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88104C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 07:45:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34E3610E411;
	Fri, 21 Jan 2022 07:45:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC60B10E411
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 07:45:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEx7tMfgLCId/tmgfMUtffVPci/dWIxoohhRA55evATKlWGGi2yTwrc6YEYTHOop6ahatZUl/sjAUa4Rno+35BaIQw3g5DQXZ7U3CaKCHu2wWTSJAvTXYi33IM57xh4+9cWF5Da6iglpNtQp6IcLZvY0WD2IH4fovpf51ZX3ctBVOZpM/9Cz7eBjDFibD34kIrJN2zPg9QPtBnSlbh4SD0VhWRUFYLUXE9eonQ5X3qcxPG8NHmcJA3jBn7+rAiO8fKcF1uhjud9LTp08yOpy1Mn6UrXH+mZoQWgbKWl7dgJ+doQzLYpxc62ByYTJxpYJNfo5kqmngKlQECOFhKYddQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGVKwT9Nv6oWiVr0nPDkGF7ITttbVboGxuzH/cXMAiY=;
 b=SvOmvRTacH3IvcyeBhXc4xuyxhjcMjtzQqgX8Lm8BHdB87JUIf+OYZNVZDZmWh/suzFbzokJat/6VhbuYXKex3ftxbDVpgiIiXogHn21v3vCHKcLNs6qQ9uq6nUF5X0iKrl3h9B4Gp8sCefWAi8enFah5eDVyAQzcSJWxYIQ9Ynj0YLPl/ohko7cnnTuHlKKvNvxwA3E/005HwXkrWvBBAe8hQpYodj8LghoYoAKcDU5MBVUP/nm3FtSHGwt9L52e4Gl1q02yItfJe38Ax/sNjZ+com5aWBfZ3pJXZusFNAdq1DbgOuwBrXq37UJZEz2DETPaacWTu8pYFOYAXH77g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGVKwT9Nv6oWiVr0nPDkGF7ITttbVboGxuzH/cXMAiY=;
 b=3tkJtxLei64A50hpYHP9Bcr2XqOEuL61Z0fM9jM/MvMtxS3LQOYQWO9AqcuREznOZmptRWMf3AojU4JM+ooyj2kOIjzOWJCznTj1BqyNnneyD/W88p3jb9SE99m8bWcgpbaMIvb5s5FScpoLsJx1piynlARwo4KM/MeleZa78Ww=
Received: from MWHPR12CA0059.namprd12.prod.outlook.com (2603:10b6:300:103::21)
 by BY5PR12MB5509.namprd12.prod.outlook.com (2603:10b6:a03:1d7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Fri, 21 Jan
 2022 07:45:06 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::b3) by MWHPR12CA0059.outlook.office365.com
 (2603:10b6:300:103::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Fri, 21 Jan 2022 07:45:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Fri, 21 Jan 2022 07:45:06 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 21 Jan
 2022 01:45:04 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/7] drm/amd/pm: correct the way for retrieving enabled
 ppfeatures on Renoir
Date: Fri, 21 Jan 2022 15:44:37 +0800
Message-ID: <20220121074443.639392-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9aa4f99b-834a-4f4c-2fd3-08d9dcb1f15a
X-MS-TrafficTypeDiagnostic: BY5PR12MB5509:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB55096A87E4D674A00032EB49E45B9@BY5PR12MB5509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mOf5D/v8ErYOFN9/EzYDn5v9H9b13H6I5Sgj6hIiu+uUYWTT5kFm2r92z4VK5W2FccpssIeNsc/rw2OvMWfqKjfAI2f4Vu8tQXPXQTJYbnCelVfeX+OxMAiPKCIPCp4MSahbV1KMDG0Ljl6n8e9j3l3456rMDnlMGl5shXk2xPxS+p/69S6oDDDS2BmyDFMc6I+GkUR0xsJX5jnY0EDXpJyiOlQVbYvqYoRs/AgPFujqV6xjym8Dmy4225a87sa72Sj0yKzgKj98nFKq5tsvRzImPNs0T01637mjE+1m/qqTwXOEyddp+HV82NqIqzZ803ETUBaVV8qqVJhR0wdsid9DiK/PZmdOWCuvypK9nXz2rOFIqFmasp7TC3FVMZWDOsbHGj5kCkSX48bUWEIb9sgpam4dT8B0v9cSZ5S6bjThIEWjnxipehQYK99riy9/eQORhCJRluwfyTocieyph/5zKI50nbom5+TQUuuxqdqwArlfNmfvxW2coa8LiPaWuISzvUDR7D8w46cz8PxE1swzntwLESOsZk7enN9Bacj0VJTsE5ihlIziinPe0XAp5botqdC/FRX9+5SFGyIOdIOrg1W0sGzOdxD1ZSeG+xYRjWY2G5bNU4LxJtO4GmQQK8Xlvj5b8JiTMa47Ad18jqtlU4wsk40kiD3S7lbVjQLo82lwhCqE+lg3vv74GFqTNGHztmWjS5ufgU7ypJsWdWq/H22XW0ycI0X5j0uHE83FHV/BJ8FNT97uc8rOd+X8YAn91u0QXcN8qKMDBvaOt+vltUKZW4GA0gG7m2h4JRg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(6916009)(508600001)(2906002)(7696005)(6666004)(8936002)(70206006)(70586007)(8676002)(4744005)(336012)(86362001)(47076005)(83380400001)(1076003)(5660300002)(36860700001)(36756003)(16526019)(26005)(54906003)(81166007)(82310400004)(44832011)(2616005)(40460700001)(186003)(426003)(4326008)(316002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 07:45:06.4615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa4f99b-834a-4f4c-2fd3-08d9dcb1f15a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5509
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, ray.huang@amd.com,
 Evan Quan <evan.quan@amd.com>, Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As other dGPU asics, Renoir should use smu_cmn_get_enabled_mask() for
that job.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I9e845ba84dd45d0826506de44ef4760fa851a516
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index fcead7c6ca7e..c3c679bf9d9f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -710,7 +710,8 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 	size_t size = 0;
 	int ret = 0, i;
 
-	if (!smu->is_apu) {
+	if (!smu->is_apu ||
+	    (smu->adev->asic_type == CHIP_RENOIR)) {
 		ret = smu_cmn_get_enabled_mask(smu,
 						feature_mask,
 						2);
-- 
2.29.0

