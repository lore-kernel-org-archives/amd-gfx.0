Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578ABC433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Nov 2022 08:50:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9900210E22C;
	Mon,  7 Nov 2022 08:50:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0C2710E22C
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Nov 2022 08:50:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuSCEVnYM5Css2JKs4NSErgiiRQ9WizVTHbnXqs21xlP9GUka6yJGwffgA7gigOMN07Upc4PaNYQPcgBM1IVAEVKuEQSO5REY8CzKUjEsXd4XpIE7zJxZnhdrZseirLUdDImvrK8Qz7z+RUfnUnDkGp8cFZJXuUP4jon3dXCj8nIBoP+5yeQWUdiW/3PDIjNUpVW7W3Nt/lo88/cxmjHXi7qA5nAn+BPauSbJfo0MmqbPv2U9qBMDaUYcZBAVI6vW0BJRhXEUWcp6INhyiMES6t3q4ABCdQhwD9c9+IOhSxl7zmSxJxhyQHHnZOqJdIelJMhBymsrN/4R4kVxwjE4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3X9RT6BwfFjs9f0WUVooaR1+2K3yO7YvJhSHwGZFf3k=;
 b=Y2MUR/PgV8thzkawbXNSOjiE8P/+Vdk0d7eXOUS8pQXCBUC39guriKHqDjMauxZ5SGvw8kMtvRf14RAow3whThFRydxhcu/AlnoJpnS2eb5VZugXnKV8c8IuWrHmMAlgVpWXDaAtxMERKM1jf/vjc8u0OCS70W8oyaHtxeJ9GvklrNsQAw7fyOgNDENx/CIYYkNQ8D15ObUi9m7dE7nwYjj83B4TIp6t0Ypns4SkUpUAGSEgOzjVXaaL4IaAHAyzy6X6pieOSavrB2389gxM+Z5jMLPFeYi7IkGv9r80nTn1UT+3ut3veDfXyCIZNBMKQnAdd7OcpKqMoUSjwNm/3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3X9RT6BwfFjs9f0WUVooaR1+2K3yO7YvJhSHwGZFf3k=;
 b=QwyE4naE6aFf4/uVhxxy7UaXaCimbthEyIpdREkeknTf2U5LgSutcC7a8tMDhg/2JxlvABkEXJFR49flbDHjHDXEMlsYXIjKjZyOHQbvcqBsOVCQD0kTOVxHRrEZKoL05stN+W6Fee+o0rdPFRouArWtdm01jWoD5At0zp6sVp0=
Received: from BN9PR03CA0062.namprd03.prod.outlook.com (2603:10b6:408:fc::7)
 by DM6PR12MB4172.namprd12.prod.outlook.com (2603:10b6:5:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 08:50:05 +0000
Received: from BL02EPF0000C406.namprd05.prod.outlook.com
 (2603:10b6:408:fc:cafe::35) by BN9PR03CA0062.outlook.office365.com
 (2603:10b6:408:fc::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Mon, 7 Nov 2022 08:50:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C406.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Mon, 7 Nov 2022 08:50:04 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 02:49:57 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>
Subject: [PATCH] drm/amdgpu: disable BACO on special BEIGE_GOBY card
Date: Mon, 7 Nov 2022 16:49:42 +0800
Message-ID: <20221107084942.1065293-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C406:EE_|DM6PR12MB4172:EE_
X-MS-Office365-Filtering-Correlation-Id: 180879f6-178a-4cea-7d14-08dac09d103a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 71c20B4vwu33HZ4QxtUCB4j8BqwC7gKyVF/UlFu3+zBsdWj69QAOnq2R2geebt28YQbPeSXdLWaWcRZodHh+j4nXRptKwfb2bPJwYDM1cNbYP07HEuTF536X7ohB01c0m4JlGNLMZPN7F5O0cEetzxfEVRAjnVAy6vfTORta1Jdj7grp8kjKXKNxzW1ey58nBS/OAr+zqkoYzG8i5RNU1JQoYO2EJh9CFmEXtol5D76nD6DrkdU5J+yURUAjfZU6IxLsNT+gc839f16z/rDhtORp28qvRGlHHj1kGvI/jb3bCUFO8UEAmvfpFrEu0QLRAX6W/VINvjfDCLs1Wbuy+a5vAN8z+c/dv13SRjhV1V6fv8621ZJEclltHD2fZdTAgwlTHDYtFq79c3ef68rLBU1NZBHtSxhlLhhhvezK5R+IVetsl27Lhqt4rLLObAGqfKN/TfwF9qNxXiLINImI69ymNOPguqhJDWKyJffdCcjZHC3Y5YKmQfOHrducO5waeaie+0aImrNVcL/bdrYGHjdZUj/HFWYZ5VVS7i3s1+9TpopGu1fCbGLa9AvF1T3eQVD2EZK0CAiS3M2BuG7QgyCi4DIO/+SYYNQqMC8PFnPB0wB0yZaD2AwQfhHvWC7q3oASj4WZaH8GbFaz2VaF//saWn4e/2Uo7NV5ELEbZbh/QlcwY5te7KwTuFiCOnfsOg5FQdwP4BpG+q1ytuedgvNHM0d2ybm4/8BZICnMTYmwfR8J3OY2jiMNt0zWcyf44tCqx+DnJKwvdDu7NM5CMsUzUi4XM30jrL7ZprXfdAT9/BLCuvNKLk4lwjfCRTQU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199015)(40470700004)(46966006)(36840700001)(1076003)(82310400005)(36756003)(110136005)(8936002)(40480700001)(4744005)(5660300002)(81166007)(83380400001)(356005)(2906002)(478600001)(44832011)(70586007)(41300700001)(6636002)(4326008)(8676002)(70206006)(316002)(26005)(426003)(2616005)(186003)(336012)(16526019)(47076005)(40460700003)(36860700001)(82740400003)(86362001)(7696005)(6666004)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 08:50:04.0232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 180879f6-178a-4cea-7d14-08dac09d103a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C406.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4172
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Still avoid intermittent failure.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 74996a8fb671..c9e0be9bb180 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -377,7 +377,9 @@ static void sienna_cichlid_check_bxco_support(struct smu_context *smu)
 		if (((adev->pdev->device == 0x73A1) &&
 		    (adev->pdev->revision == 0x00)) ||
 		    ((adev->pdev->device == 0x73BF) &&
-		    (adev->pdev->revision == 0xCF)))
+		    (adev->pdev->revision == 0xCF)) ||
+		    ((adev->pdev->device == 0x7422) &&
+                    (adev->pdev->revision == 0x00)))
 			smu_baco->platform_support = false;
 
 	}
-- 
2.25.1

