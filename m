Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F20CC61DA3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Feb 2023 08:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 214FC10E2FC;
	Tue, 21 Feb 2023 08:29:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE12310E47A
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Feb 2023 08:29:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RetOOD96aYftnESKqIVcJK34SQB16eXiFD4TSf/R222rBnqXkwA0DEJSNK1/eK1gy8j6O7s5TL2HmGX06151PE0nriFPBKIuyUThWdkllR5UfDyNMG/acdBQsEqgYj4LuxLjZpixkPl7SM8jkv84ezsZldk1AsoBDSqHCG9uNa6vvMhxuVZa5E7JFPWWxjwuOIAeuVBqyfb9Yj3P7vJ4zYhp+cxVLXaEAhm9mXgCWxdMOHasyqWvbDlMoZbmewnVpgnRmhdgXEhgcIIZ9oNJAdRN1NbBOSmobJ2AdzPp7iAvh4wCpVoc16V7K8htGGyGmbvnNJkZMTQrpcf/JAOP2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLTQiYruaJ4sQWTpE2uuw7knxugvCe6YhF7zg+ly11Q=;
 b=jmXaJkzuU9WKVBca5v1Vu71BVHhZ1sWNm+/csn1bU4rJuUFIVbCsrRmA5VFigyhovI0Cep8KSi/gObuwjEdXq+ONAmDQY3zOLluUNeAxc24AuUZ5q+ds+rtL4t5z06hTlF1b4zoWX6QCLsX4svirj7LE6feFxrvfxs1X5V9+wvUiTjat5iIb2OA1/HYwXlm87VKAo5G4uJzUnHmn3SrMAvEZFFViMvaCXXqVS3QkZSvNgUesMFJug0xXu+pMrEaOfolQh+WSa8l38HEXBVQN6povxeW1NiVVsoOW2F+LmWkdniQv9RXH4zo/j2fzqGSUs02DUU5+Bh/mrGB+M0b9ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLTQiYruaJ4sQWTpE2uuw7knxugvCe6YhF7zg+ly11Q=;
 b=2mNbtR3dpQic9LiO10K1MdPZ8D2TrYtpbCQIH+qJNmaNPW4Fwi1YrTtvOB/k52ysL0/8qNnezr7OD2QRJEyVI/5t9T8JA+Wo35dseY8EuoNQlAEfmcmzY2SI3Pk62ekPfaIW6574VHYm653LlwJePa8w8C330BZXtzsqCKfwgeQ=
Received: from DS7PR03CA0214.namprd03.prod.outlook.com (2603:10b6:5:3ba::9) by
 PH8PR12MB7421.namprd12.prod.outlook.com (2603:10b6:510:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Tue, 21 Feb
 2023 08:29:49 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::5f) by DS7PR03CA0214.outlook.office365.com
 (2603:10b6:5:3ba::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20 via Frontend
 Transport; Tue, 21 Feb 2023 08:29:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.17 via Frontend Transport; Tue, 21 Feb 2023 08:29:39 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Feb
 2023 02:29:34 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>, <candice.li@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add bad_page_threshold check in
 ras_eeprom_check_err
Date: Tue, 21 Feb 2023 16:29:23 +0800
Message-ID: <20230221082923.19190-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230221082923.19190-1-tao.zhou1@amd.com>
References: <20230221082923.19190-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT064:EE_|PH8PR12MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: cee0f8c3-b1d0-40be-fc37-08db13e5cc12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HYGRxwAMHcG5spW+iB8Y1gjmmJ5CTdMLD1ljz7ZIh6QV5S7F1qtQQVDkWG8PlY0ALGBC1NWoQnv0Al2YW7L2SJg4CA4ME31xMosM6GBhYzSI59a8yXWRqQqhr4l73AEeChPoizNMkQgPUXZ1Rx6F5+hOYtTd/R9a2ft8raVUbJHanNet9yJK1kktS7yw0qRrl0xDMQKmpk7rZ3LlmDPBoNQwOMebQHUNPOJkbhe9qe7TR/q5w6UWq4jEBa0JV9Cn6Ih6tF5mW9D6CmkHWY/2QiDEJ39my0K9Ab3elBKahi9tgDXHe26+OhHiiA9bAbdq6W6OFtej7ELaUpYNXiIIbTkFrjwVYO9TVG5YHte9kxnZ3CRDCa/xSAXiJcQg9nug/oQhwMxDHOdikHeNSQHdvAfH9HrRhIxuvvZS8ywXladZQuQAPr0+0m+4JPnTbpX4iRR2Jan3hxi9bnSLU3cFKyl9ZAu9SxNY0b0IRdwe49Ltgrw1oMv1WZ6I17DE7BquZcHPRlsd+XDTK82wiFYHB03UoOV6nsVxcIvIQ/36Mp9ofa0RFyltpsI3VrWiOU5SQhdtAJW5B2Kpa8LBXSMWhV3A4zSEwPwTIjjJZFSyZZ0mmmfSgFaWPhdl00iekFsY23GOsUfHq/cpov2Pz26o/NGbg1sCe79SgdDcX/xA/IP4WFd6gErNN5n1wC0+ihNp0jID/GO92Si0++bycfIArG5MaE9vfeLbQ/crcBdvCPU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199018)(40470700004)(46966006)(36840700001)(47076005)(426003)(110136005)(40460700003)(336012)(478600001)(81166007)(82310400005)(86362001)(82740400003)(2906002)(36860700001)(356005)(316002)(6636002)(41300700001)(5660300002)(83380400001)(8676002)(40480700001)(4326008)(70206006)(2616005)(70586007)(26005)(8936002)(186003)(6666004)(36756003)(1076003)(7696005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 08:29:39.6545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cee0f8c3-b1d0-40be-fc37-08db13e5cc12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7421
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

bad_page_threshold controls page retirement behavior and it should be
also checked.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 9d370465b08d..c88123896fe8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -417,7 +417,8 @@ bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
-	if (!__is_ras_eeprom_supported(adev))
+	if (!__is_ras_eeprom_supported(adev) ||
+	    !amdgpu_bad_page_threshold)
 		return false;
 
 	/* skip check eeprom table for VEGA20 Gaming */
@@ -428,10 +429,19 @@ bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev)
 			return false;
 
 	if (con->eeprom_control.tbl_hdr.header == RAS_TABLE_HDR_BAD) {
-		dev_warn(adev->dev, "This GPU is in BAD status.");
-		dev_warn(adev->dev, "Please retire it or set a larger "
-			 "threshold value when reloading driver.\n");
-		return true;
+		if (amdgpu_bad_page_threshold == -1) {
+			dev_warn(adev->dev, "RAS records:%d exceed threshold:%d",
+				con->eeprom_control.ras_num_recs, con->bad_page_cnt_threshold);
+			dev_warn(adev->dev,
+				"But GPU can be operated due to bad_page_threshold = -1.\n");
+			return false;
+		} else if (amdgpu_bad_page_threshold > 0 ||
+		    amdgpu_bad_page_threshold == -2) {
+			dev_warn(adev->dev, "This GPU is in BAD status.");
+			dev_warn(adev->dev, "Please retire it or set a larger "
+				 "threshold value when reloading driver.\n");
+			return true;
+		}
 	}
 
 	return false;
-- 
2.35.1

