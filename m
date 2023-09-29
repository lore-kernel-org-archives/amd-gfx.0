Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3473CE7B1F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Sep 2023 09:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E74110E138;
	Fri, 29 Sep 2023 09:38:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3B3110E0F9
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 09:38:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aum+ZrdIpbaEoXDIytFW1AUsBa5muq45W1G+2DC/YTREXcW3SYZhi74MX1QaHJFhbQn2gTu62PppKW18g1sWKoNv5Nn915wLVHGlR1DQkAIwp7alO4FvDGktJ+7t3anaZBTJHkz5WsKZaBuDD5eKenRhKY4TgxGGyDTfNpVBczq6YBneZiyY1IPZrXJpMbSXLynPEORF2t8v7NUplDG828OXVTwH/YGSIF8ECSiHQ08rvJOR0ACHre7NjdNjhOzgckMfzsZKtroYuLQKAK4TVUPkC+bqw1n5OxO7B505bzg2HiYpmsAMrUruZ6bAGFD6PxsXm9s9txIIHY0/AfQWXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOjdfR26zGGWZuNoNJWjFkfy4Td8fvkhr8/QxFRyfAs=;
 b=n/fh/UkXq3aLZbZcneCDaWS9Sv0UFNnrtF7NEAFoKBBnmySeLcEsSyfcM8sZFeA+ZZIfGOuJPgQCGhzZ1hL7g0mBkso4+EFsLHXIVZdoAm1obYKNKijkyi/y8cfnpJk8WKhlyjU9qzrO/8RS6OeHGahLovtVpSND6hgXKlIKkCMWo7Df2ZtwHTFwByG5Yc2ls2v3ystJ2aPy1/loZzre7hEBiK1Y5kNmJsEWGIGK/TMBDUkJJ2wkxYwm4plnw1NhO07Z8Besu1MBPLMuxGkpvxXXHMRM+jGpPqzjgsrNHcWZC8Ct0dOqesvc+xltkeIm16LGFIhn0xlyAih8q9GMWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOjdfR26zGGWZuNoNJWjFkfy4Td8fvkhr8/QxFRyfAs=;
 b=AzmlIp/+ejIh+c42QqFiOS8D9Ae6jowxNuj/4dU9NKojSnRgHOi1jUgoay43P//ctN4bY+dMjPufY2IQW37rn01jymPAZwJhMMjQEiBe3LUBg1u9FYNtUFK3ODN4TWf6N1J5tVV82+LopbngIgf4iXCLv9Rvnsvru3nGyCNhpaI=
Received: from BL6PEPF00016416.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:4) by SN7PR12MB7129.namprd12.prod.outlook.com
 (2603:10b6:806:2a1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 09:38:12 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2a01:111:f403:f902::1) by BL6PEPF00016416.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Fri, 29 Sep 2023 09:38:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 09:38:12 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 04:38:10 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amdgpu: Add more smuio v13.0.3 package types
Date: Fri, 29 Sep 2023 15:07:44 +0530
Message-ID: <20230929093747.1456991-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230929093747.1456991-1-lijo.lazar@amd.com>
References: <20230929093747.1456991-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|SN7PR12MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 18cf959e-74fa-47f0-ca45-08dbc0cfcc73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Qy+QnnMP2oWmjCzUqoPW4W9N1yyss0mI6o7s8wU+ghxE3BZhPuToVwT1SMGJyBjOwGZxQ9lCyCHFtYjkKOfePV39SgRvpS1Qec5lQzGhZkYX5Y74PghyZAu1Qjc5AOIB9p6TDqClCvY0rumDBT1Z1WMZeyl/2zJ5fQW93H+URdyF0TZp3t/HmUDpyvqHLr3lRgWEbrEH8+XZXQYTs0/NoBUcuzTXEAmqqgJvbIGL1/qS0exehr5MpioFPO8JaLWs6wcZ2hCHuNZg9AKh0YKnSLtvQ2UwoZRDcUW6LLdch+57p6Ac8lryEz84Upf26m5F8nT6yzjnqI/+fYblElp/Si7W8YdACkIsAmL6Z70xzvwvHi5OZ2Nt/oWKtQHQkWuMaMdy0mFDsqPAazGjRu/UGIwlevLo+2HsyY1wbDLkyJlhiLWxb9pno0gxe3vitB2DCxLoF/xPOxQ+1gY5xyQAvgr0nRNQ0SfWeyrb8Wj0paJNExc7cEBup411jAx/0IcvzoaPkk9vb30w/+ByW6VFH7KUZCiF2Ixzq5vCzvd3B8VYWgM0vStaMMIJoTqDDoh+49FF7/MiOX9VHdrM+5KVrE4uz22NBT4fY87okD0nm4kMAiiC/tCZDOaF3wSbn7RIT46xkrn4OAE1Cy9m+stp3Z+KajxHPXE2/NIN8C6yR33zrmuEFCfgKsW/VApmz+cBvATqjpyGCGF+c92Y/d/6sGE506VEOREgNLsUXEaZWZTjIe4iT3HxIIeXxnx7YQyQ4z+5VM8qp7KlI1MJ5tNGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(451199024)(82310400011)(186009)(1800799009)(64100799003)(46966006)(36840700001)(40470700004)(6916009)(40480700001)(36756003)(40460700003)(426003)(336012)(2616005)(1076003)(4744005)(2906002)(16526019)(5660300002)(44832011)(86362001)(8676002)(356005)(8936002)(82740400003)(4326008)(81166007)(316002)(54906003)(36860700001)(41300700001)(70206006)(47076005)(70586007)(6666004)(26005)(7696005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 09:38:12.3492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18cf959e-74fa-47f0-ca45-08dbc0cfcc73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Expand support to get other board types like OAM or CEM.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.c b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.c
index 4368a5891eeb..5461b5289793 100644
--- a/drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.c
@@ -84,6 +84,12 @@ static enum amdgpu_pkg_type smuio_v13_0_3_get_pkg_type(struct amdgpu_device *ade
 	 * b0100 - b1111 - Reserved
 	 */
 	switch (data & PKG_TYPE_MASK) {
+	case 0x0:
+		pkg_type = AMDGPU_PKG_TYPE_CEM;
+		break;
+	case 0x1:
+		pkg_type = AMDGPU_PKG_TYPE_OAM;
+		break;
 	case 0x2:
 		pkg_type = AMDGPU_PKG_TYPE_APU;
 		break;
-- 
2.25.1

