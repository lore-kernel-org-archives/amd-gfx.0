Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9967C47077
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 11:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C76610E438;
	Thu,  4 Jan 2024 11:49:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 747BB10E443
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 11:49:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8o7muxPJJxKr4XMbWqspWUsEwcG1kTbKRMXrZaKUxCmEW6vy3ZSHZT2GL/tDUv+rGSnNSJrHvZKTEcBhoWYNO8DuJ6nBGuQG7wgIPC6SRLu9CWqVAp4fX7hJWh9pWINWJvjKudx4A5az1HI0cOJTJzy37sy4qSFEdUbAb/Ei2njAOZZf6X/beZe3p/Ct3ApYFXIZMseHb3bmjQqaKNY5/ZNrnpJLCAaEGGUL3JedANA/8uWpWMJOvMppM2EuQk/R6odlZp92O5rYS7gmog1TxqGTlnnbu2UIKfEdfJGFGagPA6iSE9ucOkYAC3HAl5k+7ndRbDXptF0Y/nmeGRYOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImgDnh/IjHTC/ONMpFaqvgI977x5wkjVQbfmFXMz+Qs=;
 b=d/P86nv/xcrpiAiPg7DjkO5upMBcVG41ZI01BwVs6LJF0lfA9mhrTjAXtPR2FvMkSsgf088dLXpiEEyb2jtJcRPejJIeZsUfRE3FdrS6gkOVjxvUxWKPRdpoBz4medSYtAflU1ylnpibDDdiz1hrKtSlSc3Uhsx9mH0DxrC2m91h9qujfDss/BsBCfQ9miiE34mn2TRvRzKjs2fyhe4yISd7jcLBhVod1CB/yVgimWm3nWx1H0GaN2Kimc+DjzoDDkeX+MJntkBS41wCvXRQeqOvLAWEO5s5b6hxRHwWKajsA7OmJNtjlAjbCss2tyeiil52VhjqZBvG8ds6lfZczQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImgDnh/IjHTC/ONMpFaqvgI977x5wkjVQbfmFXMz+Qs=;
 b=zYJ3H22AkyftkL8gPhJdUXcJ+ra0HviZ8sX1YEcu82XHKgXTXuaG8ly9QGw+Tr8hsUF9awvK76/6i72wi7XvyEF7X7/7Ix2rJt+X7cemIqkw6hPd7gi99YW6KLaPi719B/Icuzfqg2Pw+GGxUQshH0+YprFBu5ai7xwXzcv+mQU=
Received: from SJ0PR13CA0025.namprd13.prod.outlook.com (2603:10b6:a03:2c0::30)
 by DM4PR12MB8474.namprd12.prod.outlook.com (2603:10b6:8:181::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 11:49:26 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::1d) by SJ0PR13CA0025.outlook.office365.com
 (2603:10b6:a03:2c0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15 via Frontend
 Transport; Thu, 4 Jan 2024 11:49:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 11:49:25 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 05:49:22 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 02/12] drm/amdgpu: add ACA kernel hardware error log support
Date: Thu, 4 Jan 2024 19:48:48 +0800
Message-ID: <20240104114858.3475783-3-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104114858.3475783-1-kevinyang.wang@amd.com>
References: <20240104114858.3475783-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|DM4PR12MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: 990a5966-ed7d-480c-1c7d-08dc0d1b33a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O08BMlY+3da4+C8FHv7zxI24gWDhsUwtEX4FnuMKrmNrIz3VKoXbpQWy/dnHHem/+aRlnfQOiEeXRmBL80wNMMp73cNkdlNdHzxl7mrHkbtJAc+o1ICUGm2FQGP9C0fpW3IZWf7rT0eldH8U5Juh3bCRBQ47I/ik+c9jD/2IvPtPkweYW5m8UEtU+TQgEnZuRiKmYXeEBbGIG2YZiqt/uVh+Nd8KTzgWSCIRKAt8Q+Fas8ZkzP6Kc9TdORwgEKeVKN2vVhelrs4EzsSTuhuYi3ANNWuee7tfsmsNlBAHfgFHSHa40JDCqfA4Oc/eWMIqkcyUMcxZaSp3zUQB4dhXvM5MASDN+rCW/o/VPQuxhMwCOxfdJoBAUsKbli3wPjt2oC+I8vt9tk1RFJivvQxzx0lv2djVyyZR/NXr+8/UJ4I/tZf+m566zHztyFSn2vqBQgiZBYqsZPLC+N7Kuxjlyy/8AJ458dvTnu+iezE5WFZEteXadIuZ9o74WNOwN7EOZn4uQVoFZ0Q2B8j0ICSf5Go/ahXtzikrn7wH7nWJ+AIcDXwOTYsdKswWRSVzZaDdN0qno1RAz4Avupmt8c3zREgPFdVNrW+pLbf0jytUJUvkcyVqcgpWM03sjtia8mwpeIDXp/yTEH4qaELHxYb35YY/lDSAYvMgRZ04EksZkqCjWJQ9P8RP0ihpRu5ddWmN9DD6ZIkGizvkj7uKUEuEPBjN2DnNB+VhjDy/LBnFu7zc9qq44okeU6ZqPQGOjoKQgBWzhC6OehrFOgZ3NXpgrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799012)(46966006)(40470700004)(36840700001)(82740400003)(356005)(81166007)(36756003)(40460700003)(40480700001)(86362001)(478600001)(7696005)(83380400001)(426003)(47076005)(16526019)(336012)(6666004)(70206006)(70586007)(36860700001)(26005)(1076003)(2616005)(54906003)(316002)(8676002)(6916009)(8936002)(4326008)(41300700001)(5660300002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 11:49:25.9891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 990a5966-ed7d-480c-1c7d-08dc0d1b33a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8474
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
Cc: yipeng.chai@amd.com, tao.zhou1@amd.com, Yang
 Wang <kevinyang.wang@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add ACA kernel hardware error log support.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 756b40bde38b..f03c7898991c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -100,6 +100,33 @@ static int aca_smu_get_valid_aca_count(struct amdgpu_device *adev, enum aca_erro
 	return smu_funcs->get_valid_aca_count(adev, type, count);
 }
 
+static struct aca_regs_dump {
+	const char *name;
+	int reg_idx;
+} aca_regs[] = {
+	{"CONTROL",		ACA_REG_IDX_CTL},
+	{"STATUS",		ACA_REG_IDX_STATUS},
+	{"ADDR",		ACA_REG_IDX_ADDR},
+	{"MISC",		ACA_REG_IDX_MISC0},
+	{"CONFIG",		ACA_REG_IDX_CONFG},
+	{"IPID",		ACA_REG_IDX_IPID},
+	{"SYND",		ACA_REG_IDX_SYND},
+	{"DESTAT",		ACA_REG_IDX_DESTAT},
+	{"DEADDR",		ACA_REG_IDX_DEADDR},
+	{"CONTROL_MASK",	ACA_REG_IDX_CTL_MASK},
+};
+
+static void aca_smu_bank_dump(struct amdgpu_device *adev, int idx, int total, struct aca_bank *bank)
+{
+	int i;
+
+	dev_info(adev->dev, "[Hardware error] Accelerator Check Architecture events logged\n");
+	/* plus 1 for output format, e.g: ACA[08/08]: xxxx */
+	for (i = 0; i < ARRAY_SIZE(aca_regs); i++)
+		dev_info(adev->dev, "[Hardware error] ACA[%02d/%02d].%s=0x%016llx\n",
+			 idx + 1, total, aca_regs[i].name, bank->regs[aca_regs[i].reg_idx]);
+}
+
 static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_error_type type,
 				       int start, int count,
 				       struct aca_banks *banks)
@@ -137,6 +164,8 @@ static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_erro
 		if (ret)
 			return ret;
 
+		aca_smu_bank_dump(adev, i, count, &bank);
+
 		ret = aca_banks_add_bank(banks, &bank);
 		if (ret)
 			return ret;
-- 
2.34.1

