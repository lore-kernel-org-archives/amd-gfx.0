Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEEBC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 05:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3219710E387;
	Tue, 22 Nov 2022 05:54:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 187E210E386
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 05:54:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0AolfCMGAWZEtJmUQCKtcpCLhdQcdYGmblJHcPwZwavFhaExCOrzNb0UtzZTD8fJ+W4hqFrgG5R7QjPdHbS3QnXyQj68fdT1hVh6MR94uGXa/yEmvN0ZJacQ7bl9bDS+ixYCy0lsIwMxyQ/cvCpeaTo6Fo2saqUj1Ak5NVhKCFTFJvpk0vGBr7rbX6dWapZUJOf6123xdbMLjjdyQFympqrSovqt1ZT6UNLlnNacn0OT39BgnQYSuD2spqWA4MHyQzUUKnWsYWgfwfcklRelYaX1qQWSUIXZVlE1bHb/gNN+/72cuKIAInGh7uqBnCPIYa4ZGQIGQNuwi0O9HCpuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sldSQP15MsuRwxiwT9JitROq6y1YUPhUG2q0ijbJkio=;
 b=Xtm/xF/PRvpXHspXpQIgmCe7XfnuZo7MzAoxwxnC6WeV0kDOx2m+U7zXJSnX/wb8AIo59RoDs/Kg10cK1anaMuiqnwVA/ifefkvUcpR3tdxYGUGuklZgaEbbFQ5uSaGbTPk6I3Z+7iybDePEISVFS/K1m5E8fzoQlEcIILozOMs5QQEV1yrl1e/rUSth2xe8iZL92WDPg8mj6KXxAoGlk1VH+fPOTQR+MzCKy7Uvsyq5ESCaQHRtMHOJ623OY2idhueunGLtRIoPIzOubmUM1yk4jU6Yn3E38OnpuiXOo2Svfukcxs9ETOVW98lj/boZjRlr6AJpCGqqoLgh34vVMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sldSQP15MsuRwxiwT9JitROq6y1YUPhUG2q0ijbJkio=;
 b=QXXlC5PN1ErYxDBNcPjnf0Gu7P1eFus+i0vzHmGHIe92bTZ2fctLWX9VGQP9ZVLCoLnY9ylSdBVCbH8wOMCGmpCbK4PgMrsy1NB1grrYNfg9DsTT+JmlzQiZbgHIbxpadlsR3KZCkjcwKamDaW+9ZH0K7SZtd8Cg6yZn5cNOxtQ=
Received: from CY5PR13CA0040.namprd13.prod.outlook.com (2603:10b6:930:11::15)
 by DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 05:54:47 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:930:11:cafe::c7) by CY5PR13CA0040.outlook.office365.com
 (2603:10b6:930:11::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17 via Frontend
 Transport; Tue, 22 Nov 2022 05:54:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8E8.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Tue, 22 Nov 2022 05:54:47 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 23:54:44 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/19] drm/amdgpu: enable PSP IP v13.0.11 support
Date: Tue, 22 Nov 2022 13:50:25 +0800
Message-ID: <20221122055025.2104075-19-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221122055025.2104075-1-yifan1.zhang@amd.com>
References: <20221122055025.2104075-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E8:EE_|DM4PR12MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: eda35b21-3ee9-4881-8ce9-08dacc4e1009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XiZsjeTlPFWHuqvmvBMinVXPABLqdt5CpiXEiRQTVfSnxmg3bEaseVe8i9ilnrxeXG/LJXpqygAc4UL4RBH1+qsT+gmPGYc2hiEKn3kNdNsxuvexwPxwMaEKiiLWjSPEI6laoJAEV6NLxxmAuvrVyqVyVxyTPdu/RdlChsuTzZf/JQw4TWsu2XFCsGvXQttyEkykTPXDmImBHIePvbj13sM2Z4IUUVPqsjlDT4Uung1t2gOVd+5wPsFh+pKAn/M50Ly04n0nn3ti4R+ZjSCmibAypz20a8fNObIl9kGEXsQ3htCVmgoZXbaUjRIBVXUatuYeyNg+614Sg2i56MlEcaRWUVQXPiOy+07ENb6LgijNxxjAUbxQzegmPxq5cwBcdiJG922uCEyKAda+43y5AHiO1gTBjdE9W0+308wVQ0ivhsLbPG1+umaS5xiMepJ5jwbLo8sr71hFyYefBJwoHn1Z4CPh1eq8DYqUkPNbpZSPICjMJwOXG0+AOQIFipF3YVhRTK68TyBOxSXQyLjJ2aAX7vXfKIctd4+JQWkyzmYyGX2MwzCeX8XjKDatPhtOfKGTNX4Ti8P4P8MwdaS1tV/n0BU6iMQKAzqWy42xhvkIwOBUoqIXkYA+g1c8OgfhcuvTWDv4db9dLAwNLDrQ5QGzBdMCOv0QapKAa9gFEFVZvXbmleRjIpYrABggs0tH+IgjU7xpJ0yoPwNrBfYcqrxjpkHCdQMX/XNbajvPBPo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(40470700004)(36840700001)(46966006)(47076005)(8936002)(2616005)(426003)(82740400003)(336012)(4326008)(186003)(5660300002)(26005)(478600001)(36756003)(86362001)(16526019)(1076003)(316002)(54906003)(356005)(6916009)(82310400005)(6666004)(40480700001)(41300700001)(8676002)(40460700003)(70586007)(70206006)(81166007)(7696005)(36860700001)(83380400001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 05:54:47.3829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eda35b21-3ee9-4881-8ce9-08dacc4e1009
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6109
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
Cc: Alexander.Deucher@amd.com, Tim Huang <tim.huang@amd.com>,
 Xiaojian.Du@amd.com, Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tim Huang <tim.huang@amd.com>

Enable PSP FW loading for PSP IP v13.0.11

Signed-off-by: Tim Huang <tim.huang@amd.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 1 +
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 7bb2de1d11ff..4670b86ebf74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -165,6 +165,7 @@ static int psp_early_init(void *handle)
 	case IP_VERSION(13, 0, 5):
 	case IP_VERSION(13, 0, 8):
 	case IP_VERSION(13, 0, 10):
+	case IP_VERSION(13, 0, 11):
 		psp_v13_0_set_psp_funcs(psp);
 		psp->autoload_supported = true;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 2abf48f187fa..1c7eb46aa4e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -45,6 +45,8 @@ MODULE_FIRMWARE("amdgpu/psp_13_0_7_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_7_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_10_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_10_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_11_toc.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_11_ta.bin");
 
 /* For large FW files the time to complete can be very long */
 #define USBC_PD_POLLING_LIMIT_S 240
@@ -101,6 +103,7 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 	case IP_VERSION(13, 0, 3):
 	case IP_VERSION(13, 0, 5):
 	case IP_VERSION(13, 0, 8):
+	case IP_VERSION(13, 0, 11):
 		err = psp_init_toc_microcode(psp, chip_name);
 		if (err)
 			return err;
-- 
2.37.3

