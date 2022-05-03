Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E03C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:09:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D45E10EA16;
	Tue,  3 May 2022 20:09:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F8F910E9EE
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:09:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUchtW+/52SHB1qF3wgAXcn4+SsckHFkhcggShoicR4hQZ+nydnFA7uvJ9MyxdIxKpW4fEtSjgWrvpvxdoPmXM0oZmvblbJ0Lr2OOAmq3J/8L1UXfpT7KzNFxFCn26brM12spDjtEqBBkBB6jCP8v/uWkbRmkgwp9egge8egYhDSpNbdVkyXxM5nhPIJibLZFKVOq7DK+j9NBNOz1nm1Gk5lIQfkqGmXmi7HQKXfseFprUJZULDrPohqGgwLamonixvnQvu8tUer8CiiEeUSMZCgt3BGVN1wPdivEs789bucVrmXKjfRFnEkEEjR//lsk+PmZr5DxD8w8vtBjyxcZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7U0mb8GCdAUV419TuZ4LilmGB50go+76a9amo9y1Z2c=;
 b=E5Kn9rnMId+Vj4rt0EPkD8b2wiuCc7vxeRyYgwz0IoakHU4RjLLGzuH3jXSsfIb+gD4+Q2e9mIrfv+ug2GgB6X6/mXVaTckyIexZ4WjZrhj9UwjrZPTshkMsMRWqJ+kAKGyjnkjVn++uu7NPLyHXsGeB20TD4kOKkxT2X+R98DKmxNojDt/YyfOyvDFOh6Xof6RljFNZUUXWTiZKKSpDj/kuuJwlyMBTX0mnUH9dnkDBhIHYBzaly0JFxSCvnKiYCeFvM8Vzw9hXsXASS2Ztq5uro3gQWRSjfyXzQwYU5DQbspqlbvyPkmCYreWG2hcDK1oWC7uxKUMONVYlZB87fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7U0mb8GCdAUV419TuZ4LilmGB50go+76a9amo9y1Z2c=;
 b=W8ASb0MKzrEytcvRzS2raP2wQTPb3GMFLLVdPZLhdE1b4VuKv39Ia37m+78gidjq8GSUTfxJF6471lW020La7A/WrxB1+2pJs/F2UUOdL+Qaowx0cDIx77SptLfEl7JkQxy8JFHb5G6ZfwOfIZtTqjGDhawuVYfIMZcYufhrGGA=
Received: from DM6PR07CA0063.namprd07.prod.outlook.com (2603:10b6:5:74::40) by
 BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Tue, 3 May
 2022 20:09:12 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::bb) by DM6PR07CA0063.outlook.office365.com
 (2603:10b6:5:74::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Tue, 3 May 2022 20:09:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:09:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:09:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable PMLOG support for SMU 13.0.0
Date: Tue, 3 May 2022 16:08:36 -0400
Message-ID: <20220503200855.1163186-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200855.1163186-1-alexander.deucher@amd.com>
References: <20220503200855.1163186-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 809a5a34-5933-4e1d-ddb8-08da2d40ca99
X-MS-TrafficTypeDiagnostic: BL1PR12MB5755:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB57558B590176F946AF8D378EF7C09@BL1PR12MB5755.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oVdWopmmPi8iXhsB781yONmhLSG34N6SgV6iB3Cf/OXU62ABQQf/ajJYJSM5fCHIKF1A88CMAXCgHfzcmyGJ8PM2quAbzCdQNt1mxfv22n5B2WztI/AecmmhQEIAdA8cqgkFlz9j6Ujcy5k9Nn0ZqIVEF8+dfYKlFqr6SohJ/FoxRDhMxCR55nODMbJrte9ZJ/oLIfj/zFg3y6CDl9cowad0S4VDGUmrvuNgEDVH987Ya4mwEn4s658P4fXpEg3xsTXjO1ACEgY3Qqat8OgYJFsmD5bi4fkn+5hGp1m9CPVenrydni9TuuYCpwOnYCt36s5BHiUQmPA0juSMZ16nQDx4P2PCZctdCvFZ8Gy+cEMCKuBRpGLypVRYPP/q2l/0KKttZ6pGnniVQAUVu9DY+VEsLNJj/nXjIvoNMLdwXhrC21+YNeyK0FEbehBJ9r0wodNPgbmqO0EmpCCQHEmyb1XXX9qh04xGeDxnI4axyXXusVedD2PFn9iHUXKILTXr99FcjU2a8ae86uy6qVC63sCtX2DOUQpiZlIY6gJA6b8cYvVhRe/gHRrQ1R1+A/RUcLq0IvrhnMM3uuWsfkLBZXRvxG7t4f8oEv1Ioux6IZF7QGDSjKt3EhU/UnShyPx+N4yQCEAF8vnMGj0huJM5jpUN/UPxuY+StpKoWq43IiuIXVOKXD9iYjUYzFXUg6SelmP5EeFIMygBWyA9f9rtTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(4326008)(70206006)(16526019)(36756003)(82310400005)(36860700001)(426003)(66574015)(336012)(70586007)(316002)(47076005)(8676002)(186003)(26005)(7696005)(54906003)(6916009)(2616005)(40460700003)(86362001)(81166007)(5660300002)(6666004)(8936002)(508600001)(356005)(2906002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:09:12.5491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 809a5a34-5933-4e1d-ddb8-08da2d40ca99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

Fulfill the interface for setting PMLOG DramAddr
on SMU 13.0.0.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index b9a6dcccc0b0..e3c31ac7a63f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1552,6 +1552,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.run_btc = smu_v13_0_run_btc,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
+	.set_tool_table_location = smu_v13_0_set_tool_table_location,
 };
 
 void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
-- 
2.35.1

