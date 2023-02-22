Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0784C64EC7
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 02:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8BBC10E0DA;
	Wed, 22 Feb 2023 02:52:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD49A10E0DA
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 02:52:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZTy3oDBOEynLjQvAC5i9kcWZAabmBstYJ9wWQWCsmoLlkL1/O/EIkQQJ5jGSu6m2G2IV4BGEK3MogHoKfXkc1BEKvCZc6W0ye/9uaPqnACsqFGIVD3CGPreSCxVXZ7kng1SETHn3vRR4S9nkYuoHkZhd+0IJmD+pNGE5hr0l/XjcSYPYu9hspd6d9z6oURBmJRd1RYG37X6VJ4+X2o4kWjg+IRcU5AQUFyVD6DLF8oIb48BJGnqOd4n8euFm34fe1veQ7OxNQoAWpMA2A//LbJp+qefV3V1h+WvgDUHhm+4e3MVqfKznXtkhohocUJfH/4oJv72/gQo1mJT8Cm0iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SOBhwgfoC0UTojfQ/mc7HmDpHYGzAnJY3WYNwpm288=;
 b=bmS2kHcwdo+4xV3OOqoSs8d9FVDn+omePO5wzBO1sppp6oo8rhZBXSkpj7fj3sYTWU4vu6A01ts3LunViTzT/XXN7Gizac7+++OFvK9QsOVMWZVyeZmYMTJaSfz6e37LOsx94QwGVRGYFSd1OJgq7AOBcRYUF6qiOfKs3mimTQTSVHavTaFgiuozQ/xtgxHXWbNbAiiXyZJyL/zAO5jVwBNdpzAOUeEoqdt7JC8MK3Y21DNUKQ9nK9ONccSIhi79ft/rIUe/uHdrWLPqM+9yljN3eRAAJr2CJehHlWHiq7xlNUJHIvJHc/EZjfUcGkj9JSnuJC7HuXADu0g2s2lE3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SOBhwgfoC0UTojfQ/mc7HmDpHYGzAnJY3WYNwpm288=;
 b=4Vxb3Ng0n3Cg7TRS3vRV4ivmiybLNJeHAsSDNwt+7SQD2LVvMS5A1vH6KW8HnaXR0OLA+Q9g49nkbIA8MtGxHAUIyGo5apveDXYaqpPqfOnQ8848aC4LppqwYVU1iVZzYj33Fw9bwz07LajETiTKgz7XIxy9+86K2FSY/cG+s8k=
Received: from MW4PR04CA0361.namprd04.prod.outlook.com (2603:10b6:303:81::6)
 by DM4PR12MB6639.namprd12.prod.outlook.com (2603:10b6:8:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 02:52:03 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::22) by MW4PR04CA0361.outlook.office365.com
 (2603:10b6:303:81::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21 via Frontend
 Transport; Wed, 22 Feb 2023 02:52:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.18 via Frontend Transport; Wed, 22 Feb 2023 02:52:02 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Feb
 2023 20:51:59 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>, <candice.li@amd.com>,
 <lijo.lazar@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add bad_page_threshold check in
 ras_eeprom_check_err
Date: Wed, 22 Feb 2023 10:51:48 +0800
Message-ID: <20230222025148.29652-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230222025148.29652-1-tao.zhou1@amd.com>
References: <20230222025148.29652-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT061:EE_|DM4PR12MB6639:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d1a711-8949-4307-c01f-08db147fc69b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hVKb22VD5XqAPgb4x8SIRl1cT3EtstyKrUffu38YwRkxzgCpdAWF17Meq+NX7ofxvPUEfnrFzXifmUmw1FAxYt2oJl9J4WUX3Ao7SKnTzHfQXxlvGd21rwXAH8jmETB56gEJGVR+IHkAopxa5nmf0iSgaqd7iZWzwrEpLPeCsn1Tkxqis0Hk9Xlbp8a6pGQEPdpycCqzRxUv/QUBOWtBvgrBx9I14wKCPNrfruenRjE8gwK2uWer3MEj+XIcg/dWEB4fukhDP9pfaaE32flGOWbau4tBZq97aqXriRsyMClnhjfK25pDnUB3IaukXM89mq1K32VSF24Z7n/Lykz7RyobLOQUKYuSBTvxd+PHxkZkTDCJCauWJUWDIYLhF19uaalyaMf9Pifjh97vzRh5e/3T9xuppxoWPyf7NTGjGUHxZtJRLiE00tkz/Nir5UoWDrPZz9XDPuhk9gMWqDWiW5B/jD7xeG9yWBdby5p++/WlNWUMBVMl9HVXrmL1S0RfLT3Is90n/E/uXO7ch/r21uxicmjhTOKokXOca5nDxR1NrdNFCU6utZQMBIkt3ev65r4DgNaaweTVD91/Yqmyt7veK67GsskWVIRnTZyG1w7Gs8LrXysMDXW4Ggjhm2TYiFOG5BUPI1795KjAny1x/azWSIRnmBCdkoo1igS31gWh1bf2Pzjj650k+OUciftVeu7oXygf3nmwWCc4PHvb4HHDNZbeWdRrltsIK2qoMJs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(5660300002)(83380400001)(426003)(47076005)(82310400005)(82740400003)(81166007)(356005)(36860700001)(7696005)(2906002)(40460700003)(36756003)(478600001)(336012)(86362001)(2616005)(6666004)(40480700001)(26005)(186003)(16526019)(6636002)(1076003)(110136005)(316002)(70586007)(70206006)(8676002)(4326008)(8936002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 02:52:02.6836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d1a711-8949-4307-c01f-08db147fc69b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6639
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

v2: simplify the condition of bad page handling path.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 9d370465b08d..2e08fce87521 100644
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
@@ -428,10 +429,18 @@ bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev)
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
+		} else {
+			dev_warn(adev->dev, "This GPU is in BAD status.");
+			dev_warn(adev->dev, "Please retire it or set a larger "
+				 "threshold value when reloading driver.\n");
+			return true;
+		}
 	}
 
 	return false;
-- 
2.35.1

