Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90638C7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 342B910E431;
	Tue,  9 May 2023 22:21:48 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B881C10E430
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:21:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTNvdAMDEfJwdMW1nRu6e9wQ3ahtV5umj2MlguJZV3wjHO3gXyayeFjebBOYRhgofsxjh4kMzFtZ6xk9d4mWxi0A67k64vjuzhIxpL25CyqHbDT6MXGFMnBoeIZhthR0qcBB58ZXqT97MmefgkMs18XNJw9DBVMob3BbhPoSUgDlDhultxa13B1vELdvi7yET1vfXy587eb439W41PKotR+IbqrGfKdh88G4T8dhtkApBo/K0sUIv7U79oHTs39b/38yvkCMY0gY25fuvXk473sy3mcP+B6Ql18WXHXhfPJ/O0uvvwKD5uTm8uKhE8XdcAE3jtuhChQ68lxNIaWQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPw/DcLHptp92hSDj4YvgN1CQAwOM7SiHG8Btib9fV8=;
 b=hPNh6aQO++smKe2MwQp6UkM+aL0xpwZkftKRGyCK8sMscMKQx+JUeh+3G7I5UXs6qQTih0M33YcRTTJ+nUPhqdO3eWII8AP0TSG0wJCWCcxJnS5nifYj58ysXzeVsjwxPhxHY3+qppSU0sYOIgqIlf0kqcCcikmQ1SoAHRf5Pp6gxizJu+5W0ky38m9mMQqBCTHnfOPBrVcaPLWdygKrw9LZpvWWkEyLb+Fv4xpichQCJS+pdxXItvHbZHTQiZRHr6+o1aSOzdKTKeLdcMpiT8c+X203VD4yamrRrWSlQmcAO00EzfufHNYlkVd+zSlPpCe+Ndayu0l12Obal/ImvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPw/DcLHptp92hSDj4YvgN1CQAwOM7SiHG8Btib9fV8=;
 b=mvRDTqnEJpZ1dm0FFvGrzC6pDUg3OOEusmrpimrJDcwVeV3hqlc9olsv1mdyjG4WCZZWcNk/EWwg5W7XXYUa9zPDqDtMrbtq5WDvb3oWlo3VQEXa2P4MacIHvuHFTgAn78jprcDF2VWXCwxPxc2jecM3bu2WuPZI4F6/Gqi9VbI=
Received: from BN8PR15CA0027.namprd15.prod.outlook.com (2603:10b6:408:c0::40)
 by SN7PR12MB8148.namprd12.prod.outlook.com (2603:10b6:806:351::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Tue, 9 May
 2023 22:21:44 +0000
Received: from BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::d3) by BN8PR15CA0027.outlook.office365.com
 (2603:10b6:408:c0::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:21:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT114.mail.protection.outlook.com (10.13.177.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:21:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:21:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/9] drm/amdgpu: Add reset_ras_error_count for jpeg v4_0_3
Date: Tue, 9 May 2023 18:21:24 -0400
Message-ID: <20230509222126.477847-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509222126.477847-1-alexander.deucher@amd.com>
References: <20230509222126.477847-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT114:EE_|SN7PR12MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ead4d34-cb66-4c57-a150-08db50dbc52a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zy8M7lzi4qJbb2Apo/2SzLgNwrUrRU2MFM7WdMzTtFKTtj1hnhhfJqknB2NuJGGNmC1HqwQ7ML4KDU3J404U23LXvCpPRUA70qo00RnrnN7DADPoB8ZAPeJ7hgkX9WPAy8qyItErIdm8VjZSeV0h/SBS1mKSvkmSiZAIk2zzM6XVr4CYylIRW3cbgp0cPsMLiegxu5vvY72JFMmA+/ww4bi+IAzZvKU4Kb022ZGb7gHVj32gSPo5/iGRdDrTNkcv2Nu9e+VMOTkgRYHsf9HUdWAW9JajWR8iarMdQ7SswoINX7d6l+7td2X6nlfXOZIqI+p94hjP2PHF4zJOIHIzOiDy5TK6Z/Pep4DjSqyv0fVakkOoO5uzz0AyLttB1HrGQWWrWcqnG8XWRXVhf1Msa891H2T+cu2K9FBVgAO0Scky+NZ5sE4Z/eNR0XVI7LtwW+dbrAb2m4xh+ZaMvezJWu7o1l7/ebMg1etGksDJQ1TyTGjET3cn8PqRLn2DyTSgiYEfg7EktrhwK+BuLU635R02a4gD2yUFC+8WuBYFavRB9/nXb6mmCUVnTpBOaZA2yrwhQcbQmaExk1i67sD3GYi46FQdgDlvaEM2pcWwmBxmRzlgEZBIitZZLRIIdLha2H4ZCdvTsNC17+G070B5CFUWSb12y6jk+Ku/icqYA1/YnMszCPkBzqBkEUXrlTU/2FpYACex5vAQtk+dpnYElqybdWbOzV+sxL6cy0eq64jwjsZLYgyO6Xa4yK7k5WYq9kuGLhFOUcHzLPMGboNh8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(2616005)(2906002)(40460700003)(186003)(16526019)(36756003)(478600001)(7696005)(6666004)(40480700001)(26005)(41300700001)(1076003)(83380400001)(356005)(316002)(82740400003)(81166007)(54906003)(47076005)(4326008)(6916009)(70586007)(70206006)(8676002)(8936002)(82310400005)(86362001)(5660300002)(36860700001)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:21:43.8709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ead4d34-cb66-4c57-a150-08db50dbc52a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8148
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add reset_ras_error_count callback for jpeg v4_0_3.
It will be used to reset jpeg ras error count.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 5dedba91fa32..21226d6d26f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1024,3 +1024,25 @@ static void jpeg_v4_0_3_query_ras_error_count(struct amdgpu_device *adev,
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++)
 		jpeg_v4_0_3_inst_query_ras_error_count(adev, i, ras_err_status);
 }
+
+static void jpeg_v4_0_3_inst_reset_ras_error_count(struct amdgpu_device *adev,
+						   uint32_t jpeg_inst)
+{
+	amdgpu_ras_inst_reset_ras_error_count(adev,
+			jpeg_v4_0_3_ue_reg_list,
+			ARRAY_SIZE(jpeg_v4_0_3_ue_reg_list),
+			GET_INST(VCN, jpeg_inst));
+}
+
+static void jpeg_v4_0_3_reset_ras_error_count(struct amdgpu_device *adev)
+{
+	uint32_t i;
+
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG)) {
+		dev_warn(adev->dev, "JPEG RAS is not supported\n");
+		return;
+	}
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++)
+		jpeg_v4_0_3_inst_reset_ras_error_count(adev, i);
+}
-- 
2.40.1

