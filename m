Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3819C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 11:06:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51AA61127D0;
	Tue, 31 May 2022 11:06:08 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2048.outbound.protection.outlook.com [40.107.95.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E59F710FC7B
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 11:06:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fo785wfGW2npqaPDlBh/z6jkjBXdKO45Y8ouS1gN/IZOOR5MKgsM9bVCeELzjJXf7DcVYxLQgSq3GZuBcHVnoUdkezLUCgA1AyFjG7fe46vuUInwKhosg/VMPt7M+D09GI9x33I6uNvg6soPE1+qGlJxqMGICxTiJa4WKhkIyMnuC8wHa0LbFYp12UJMOD8m5vo6yxKlcfet+tSPqAfjWRpcUx2YHPr5/SDNixeHz+AEwkEE5RSkKo85AaorD7mmBMxt12SlvDdM/kiC3HyPDL01hQU+H47lhlXcdiEVAJ5T2Js2KtboFYmvpyHgbTtgXopPNPe/tB9MlP9RQWR6zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNYlnL+Xouya8zfpTL5SsVqSz+RFfEkHjcgQash/XAY=;
 b=lAmuCOC28cIj4UhWiaaQN1odWlncm1di0nsG93+A1pL4RmCC6kUbcY8mOR4J1eKdq0VIKaMAiMPjlHCzPVYG8BBu0HjdSd4/bihPfFmQmZFSJvqTzSmRBz0qkv6Wp0ApgzazCWCMmt5D8kAmoQjoOLGuQHHFbTqC3ftd1FCNnB7JwzNciP5/4U3iqXl08Py1SrkYp5nh9shWO0UmK8AtYZTthFJN/Z8Lnye8wxhxfdCvvZRKT1/L4jL1lSu2yE3GMj7+Mj972ubC1J5GqFHV2E4aDovJv9UjdWiRAQ1xpUBiU/OswlUab0Xd98gIq7FblgGQfbPI0E+YzJC62yAPKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNYlnL+Xouya8zfpTL5SsVqSz+RFfEkHjcgQash/XAY=;
 b=g1/A+G6OIzFrSVX+QGNs3nxdNoTFgL5ir0okDxupskqc0vUB0nqDvYjT+vpbnUXuSXjn5M09YdyiFnew7lViJS03SVbFBPdZikEZ1quAZLC5D+hVfgSimGlsyCuspQ2KR3KY/jYsOL/AN3EXEJIYrFHj2lYQamuGxXrsTvozUOg=
Received: from DM5PR17CA0069.namprd17.prod.outlook.com (2603:10b6:3:13f::31)
 by DM5PR1201MB0076.namprd12.prod.outlook.com (2603:10b6:4:55::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Tue, 31 May
 2022 11:06:04 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::b1) by DM5PR17CA0069.outlook.office365.com
 (2603:10b6:3:13f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19 via Frontend
 Transport; Tue, 31 May 2022 11:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Tue, 31 May 2022 11:06:04 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 31 May
 2022 06:06:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 31 May
 2022 04:06:03 -0700
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 31 May 2022 06:06:02 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <tao.zhou1@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: fix ras suppoted check
Date: Tue, 31 May 2022 19:06:00 +0800
Message-ID: <20220531110600.8514-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c36519b1-9a10-4f38-5dd6-08da42f58e39
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0076:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB007618A99D594B73433EE2DB9ADC9@DM5PR1201MB0076.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pkvu/b5oN3zOEVL5EI7OoSllv7oS4JcZUjnvdO6B850oSTxqFy6AQQtZzUlAq03txIttnT3kdDI4G07i6wtU3W8XGUHxuA3GMETaKFaT3Ysw30FgpLSmLMmZAKpBvkO1SGp9dY+WfSP8wHicgB+t4A1ui1Wi/MA/KkI8ybPxxl4FzDGY9UbgLzjKwaQTot3gsl3MAWPQDsuNRfijspMaUP4TUj0yT7RUboH522CP0Lv6q7Iipkxxv5MjSN7l1bbSuKh9nTcQKPLDfgcPxp9n3OVIY2EKoU4KOYIJm4ZrPM2gA/0npWozOZKr2h7IKJ1rn7XDEgi2ruJtPo5aRhdMuMFW8xSQDRZe2iPLeujUgyVY+lRMh9duQRxTUstMcjtW6qSxOXw9s4h9FsFzvOznBgWUoR69oGrXKhDf2Wn9vN4hpV/Uw3jeSxpd8pUDNdynAzJklusW26Fl3fQCIaKUY8Q5FU1F6u++N3AiwIZ+dyh9iWnErTSSw03xAhdy1OmUnoskFr80mBggwWNQ6gZ0l97G5NRpGntuFuqd22saTpFiHquNCyQlarLbyuByaTcrdVAJeubfbsMfdWNgZ+TfWVbOVbN2Oxq93YzOngvrO8FMjOl69zGAWVDV4pI6EMGtFuO59Ravf0I5dJ0/FaQzAuVabhE+UNzfUbgbYaK2N17NeI97/effa+EY8gGRPSvC7ehicQ3xl4Y6KgwYIGyaCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(86362001)(4326008)(8676002)(356005)(186003)(70206006)(70586007)(7696005)(5660300002)(508600001)(4744005)(336012)(47076005)(426003)(83380400001)(8936002)(2906002)(316002)(36756003)(6636002)(1076003)(2616005)(36860700001)(81166007)(40460700003)(82310400005)(26005)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 11:06:04.5954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c36519b1-9a10-4f38-5dd6-08da42f58e39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0076
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix aldebaran ras supported check on SRIOV guest side,
the previous check conditicon block all ras feature
on baremetal

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index a9d1cce192b2..8bda285c9e97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2285,8 +2285,9 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 	    !amdgpu_ras_asic_supported(adev))
 		return;
 
-	if (!(amdgpu_sriov_vf(adev) &&
-		(adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 2))))
+	/* If driver run on sriov guest side, only enable ras for aldebaran */
+	if (amdgpu_sriov_vf(adev) &&
+		adev->ip_versions[MP1_HWIP][0] != IP_VERSION(13, 0, 2))
 		return;
 
 	if (!adev->gmc.xgmi.connected_to_cpu) {
-- 
2.17.1

