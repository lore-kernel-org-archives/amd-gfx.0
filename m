Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7898C7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6875810EFEC;
	Thu, 30 Mar 2023 19:42:55 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4DA810E2D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:42:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=caoXQrbPweKKM+0aL/5XBlDzylCPLdE3Dd/N/yQmRIV83PWNFUPWBGUy43ZPLrzO1ZXvsJ9nsWPWiZ9lLAsBhpxL5ZSqf54g93d3CMRWfh3j7NKdWOQw2N3fHldH3MvUXbdztkjKtk3PJnVr/KczBSx6Zlx0CdAPGBLFCbliB9ZO+CTuDjM1TaeQjvW4zIKSYUdrALyH5pKpIWERdRY04heyoBWnigxacYONcKjgel5Opze2quLBZjomXnTaM8rhWE3igODyKQD47aXgH6Hat9yKW+p7Z5GchBcilH8s8RhaO/t2bJAsJ2GkvCq7NfTREzD+hsjJg6oNcFF4TvZuOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0v8EphrK0l14wUvbTdtTOtsaZrh/A73PxRoGFuZXd0=;
 b=KhlyEcTubNCNc7oDN0bk3DmybRDiwlxx7XFaVFdUFk1C5lbLS9Ja5iFpzqAQVWozPLaFJjg1hV4VqA+ESkJU97ZhyVcQe5FUoD5s/EhG7zUQ6WOQtAlKKq0yygwAs9CnyOV0WNhEQGH1aYvZubscACdoTCCZQZ7for6zHoVohjnboN5NSvjo13Omfq9EDv65tp1vgyo6U9MTAzfhVHm12kcpNQyBR+0hRnB1xr0FsiACAObwOqsCJfJMFzn8+kp808BpbqhB3AGgIz2FaP0JJbLAoI9rgAFVY+JWPN3CgwbtQEwTOhq5dpDk/EvQuHyrcANk8/SarycJsF2kgOgGXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0v8EphrK0l14wUvbTdtTOtsaZrh/A73PxRoGFuZXd0=;
 b=2d+LxeIK6c6Ik41O53gEyIkXlnn8CAwrWeAazFlpohwimgxaLjIBnrDX9WnWuBh03uPZvaCVsGC2m8DhchoukHos83IwZfBDK7FppBPsN7oaXoaIMPpA9gq2y6gvrcasMF6js7shLk7dXxhKmxXnTB5AyUXGiWhRLjYPwORvRpg=
Received: from DM6PR03CA0091.namprd03.prod.outlook.com (2603:10b6:5:333::24)
 by MN2PR12MB4334.namprd12.prod.outlook.com (2603:10b6:208:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 19:42:51 +0000
Received: from DS1PEPF0000E63C.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::c4) by DM6PR03CA0091.outlook.office365.com
 (2603:10b6:5:333::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:42:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63C.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:42:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:42:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/23] drm/amdgpu: Derive active clusters from SDMA
Date: Thu, 30 Mar 2023 15:42:16 -0400
Message-ID: <20230330194234.1135527-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194234.1135527-1-alexander.deucher@amd.com>
References: <20230330194234.1135527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63C:EE_|MN2PR12MB4334:EE_
X-MS-Office365-Filtering-Correlation-Id: 18077815-8dc5-4b64-9c1b-08db3156f2b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i8/xKTVsoiWF+NumErOzHnxS6ZJXFzhp+saVfqunugslhDkKxVQbKhyZa4N2VhVZ8cXfMjPalWemX+binukUp72fIgoBTmN2keE4RGZq1/Nippap9TV0tf1sNcex99aJ3AzBdFaLH+stv8pHUOXMEBm8TsJSYzczsRv/YKOHH+Rejes1vnPNQe0yD5Vf/PaJzNaYxPZ+ylzwN6Vdxh7XVhgcNujn0ZbOPNkKZlWvbXN1Z+lbBAbghwgNZ4wrzWrZQjDxf7ZhgoUWOV5fmNwyA8eC7fD2Kb2WI1f/v5OCsAeigPtpsZ8fyxiKTiErurLVWjA4Xdx+iC38C7r2e6aLhgKeuO788F8roX/t6VaPwO4bLxklaKPtPO2v/u7N2r4HFD/OCTRMgvNgi9nbVwTxpHWF16SrVdJJl5QRbtbCxnUsCM/g77xxoKoYWyIbWkl8maTg4Ux9kRMQUE2u85N5zqpA/yZ6mBMqmyihiiDuFTeO8hNTWKo/RtlFXGzOtY4sduxZnljmBSm9WThTbehRHIU0jfJ25jlwSVOd4kDXIIza9oMrWTcAy1A1nN0GeAz4mv4eMoHB5WKwkVXieVimbXngcmbOFNIde1ObGhqXORkDWryO/QHlm5VXLmtxACLzPxsqb/PJP8AGx5hf59ad1KT6vqBVbJ+NrZiN6AYk3cqk/bow3/uJzYVknSzOXJLtu0f5+K/tF38EJc1KS62VbOuuLv88599Rjiy3MeXpq/8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(47076005)(81166007)(8936002)(4326008)(40460700003)(36756003)(356005)(86362001)(5660300002)(82740400003)(70586007)(70206006)(82310400005)(40480700001)(8676002)(6916009)(41300700001)(36860700001)(426003)(2616005)(1076003)(336012)(6666004)(2906002)(26005)(186003)(478600001)(16526019)(54906003)(316002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:42:51.0950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18077815-8dc5-4b64-9c1b-08db3156f2b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4334
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

SDMA instances per active cluster and SDMA instance mask are used
to find the number of active clusters.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index a6204b588829..6f7226b5d446 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -357,12 +357,22 @@ static int aqua_vanjaram_xcp_mgr_init(struct amdgpu_device *adev)
 
 int aqua_vanjaram_init_soc_config(struct amdgpu_device *adev)
 {
+	u32 inst_mask = adev->sdma.sdma_mask;
 	int ret;
 
 	/* generally 1 AID supports 4 instances */
 	adev->sdma.num_inst_per_aid = 4;
 	adev->sdma.num_instances = NUM_SDMA(adev->sdma.sdma_mask);
 
+	adev->num_aid = 1;
+	inst_mask >>= adev->sdma.num_inst_per_aid;
+
+	for (const u32 mask = (1 << adev->sdma.num_inst_per_aid) - 1; inst_mask;
+	     inst_mask >>= adev->sdma.num_inst_per_aid) {
+		if ((inst_mask & mask) == mask)
+			adev->num_aid++;
+	}
+
 	adev->vcn.num_inst_per_aid = 1;
 	adev->vcn.num_vcn_inst = adev->vcn.num_inst_per_aid * adev->num_aid;
 	adev->jpeg.num_inst_per_aid = 1;
-- 
2.39.2

