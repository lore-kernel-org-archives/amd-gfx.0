Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240A4C433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8D1173DBA;
	Mon,  6 Dec 2021 10:19:31 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F67F6E0DD
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Dec 2021 10:20:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uj5cjbMoyZOdeL9PTkBBP0KpmyKG6HF2SsauK5UEJuTIP+EsikRgNr7kADGI+lX6CaJpVOKpxgY2mtHZjp7iQzuQEVPbaOnZI7hjWTuZ+WV/v5DNkszB2Zb13T0ZrNf+fW5YnzKFDQggVB1vbP9g7X8cogyDr+DJLK+STWdlw+CGRu91/+0I2bE1p050Ckn6cVW0BwJOhHbApWO+qvPLt2XBK4TQA8RPXRDLoOy6I7u6SlI8wKI0ZK52mtS92Hw1W30eiYsowkC+pwuDn7XZFBP3/F8p2JZRe8DdDbXd6OZp1tpUS8ie5zAt66sXvnxflfYjPAEeLeoX12M8eyXGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uh0URztECdUqhPPWeRzu1c4sVhidfqHIfa6tzuRDec=;
 b=aUPEKpFpKEGciUb4/FXoOkGQN3Tk0xKBuOMuy23qeN2+ktyVRCXvqhh4FPTyWFmFZLiolUy3lS9AA9QrECO1uXWyndE2Fg8SPqQhOcVH686ltZI3alWJbxsvt0knEDQ6JTRDYn29CHqSzHiujdnsAXiGYkAHFg2ZjKce02uPjCNFgcFM61yzfxAlbuFltdYGTmlYPDfJOeX9qqIxx7Kq/Up2M3wZYfcdPzg+iFiLVj5MZP/MbqWkIPzoA1mAg5awnTHGodnewqOXbaasmI/J8Y/6vJnYk2jmB9ASD9qrd6aOKq3Jibo0TEBFd4ttWPbWxggY1mTSd8SyjBWNDxF1BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uh0URztECdUqhPPWeRzu1c4sVhidfqHIfa6tzuRDec=;
 b=3PYCUSlUpQAxM1q1pCIiskbd70q5rEB6lj+mXjjaG7g0w5AcjwXULUFyA2qg9zVjC3L9MeoRcXcP5BKKLp9blyWM+Oxjq3r1JEjk3h+cB6hNmUln9MW4KH0BziIWfKjLcblBqbb9prHqW09U3AQWE3b5h/Klmkya4iFPKtueFWE=
Received: from MWHPR02CA0005.namprd02.prod.outlook.com (2603:10b6:300:4b::15)
 by BYAPR12MB4711.namprd12.prod.outlook.com (2603:10b6:a03:95::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Sat, 4 Dec
 2021 10:20:48 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:4b:cafe::e3) by MWHPR02CA0005.outlook.office365.com
 (2603:10b6:300:4b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Sat, 4 Dec 2021 10:20:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Sat, 4 Dec 2021 10:20:47 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sat, 4 Dec 2021 04:20:46 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: add helper to load ip_discovery binary from
 file
Date: Sat, 4 Dec 2021 18:20:29 +0800
Message-ID: <20211204102032.3063-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea51cee3-f81e-480f-eb91-08d9b70fbd62
X-MS-TrafficTypeDiagnostic: BYAPR12MB4711:
X-Microsoft-Antispam-PRVS: <BYAPR12MB471162CB407FAFE7F7B526E2FC6B9@BYAPR12MB4711.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: onD1Y+M9zkEmrncjlwFroxNz4q4ofhQxUKJaQdP+6AMd+jEdoJGvBavTOjRsAtXa+46hrFeuWCc/ghbBlIxskWUf9I9Nxxswhzr7Ipdk6f2m4x+sxx6+NCdEfD3XLIkMl8b0YQGhQvOp+/gmWIqvAUvEhOU/6DpIfMGvEyKq0KR/ZrzTOVPeCA/Y95owYF/n2sK1x1F4IVIW4OLi5ICKnMHChvg2mU7PVj+Lcmjmvh8dKHexWy9AyYb5Ie/6ZkLQGv4jdWEWPqs0nAN668xi3yWckaML7VVaoP30advKl4kAhu4tNt3HcnG+l5TmQoM9sr1q5T0ii+0sHqqpBL40v1L2Mh+MaeXnHVQVmQqH9Y/W3jTucl1dL7fbCs85u1cceee/Q5EVLrwYx97JFxHegVLofgOibuyAM0Uvg6dUAdgS76u+eIX4yrb6xvBSFCJnoXeS3a+1ni5c7oUXxwHXkg1BrcyHRbpoq2LLuHaMJlTvVC1SwtV4ZkWtmG0D5gTaC43ps495/Er9B0jwut9i2ktiIcMRMPQ66rd+B7VNbBs8TA/VDVnxgapuF9EI/rcagaSajyCIo+4r4n/d7UefZJV5iw6AmALxtjOshSLJOBI8pdKB86Gsvsmxa7ZgqlwXlOdIcvns4Wpovy44J1QuI7AL9iOYUGkbqVSzpiGUSM76ytDf3iQCzPiivnLB7EvcLUNloW7CqxSXQQ5xKc4Q41uJC0uNTk5sov7E3QEFOZe0vsthY0P8KAu/ZP3z9hV67YuyEtBN7RR3JTfF378HfFJaImiAY41wG9bQ/rx7PoM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(5660300002)(2616005)(47076005)(6666004)(70586007)(81166007)(4326008)(16526019)(70206006)(356005)(186003)(26005)(36756003)(36860700001)(336012)(7696005)(316002)(426003)(83380400001)(40460700001)(2906002)(508600001)(8676002)(82310400004)(8936002)(6916009)(86362001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2021 10:20:47.7842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea51cee3-f81e-480f-eb91-08d9b70fbd62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4711
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To be used when ip_discovery binary is not carried by vbios

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 4e3669407518..8ec60f826c7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -67,7 +67,8 @@
 #include "smuio_v11_0_6.h"
 #include "smuio_v13_0.h"
 
-MODULE_FIRMWARE("amdgpu/ip_discovery.bin");
+#define FIRMWARE_IP_DISCOVERY "amdgpu/ip_discovery.bin"
+MODULE_FIRMWARE(FIRMWARE_IP_DISCOVERY);
 
 #define mmRCC_CONFIG_MEMSIZE	0xde3
 #define mmMM_INDEX		0x0
@@ -187,6 +188,34 @@ static int amdgpu_discovery_read_binary(struct amdgpu_device *adev, uint8_t *bin
 	return 0;
 }
 
+static int amdgpu_discovery_read_binary_from_file(struct amdgpu_device *adev, uint8_t *binary)
+{
+	const struct firmware *fw;
+	const char *fw_name;
+	int r;
+
+	switch (amdgpu_discovery) {
+	case 2:
+		fw_name = FIRMWARE_IP_DISCOVERY;
+		break;
+	default:
+		dev_warn(adev->dev, "amdgpu_discovery is not set properly\n");
+		return -EINVAL;
+	}
+
+	r = request_firmware(&fw, fw_name, adev->dev);
+	if (r) {
+		dev_err(adev->dev, "can't load firmware \"%s\"\n",
+			fw_name);
+		return r;
+	}
+
+	memcpy((u8 *)binary, (u8 *)fw->data, adev->mman.discovery_tmr_size);
+	release_firmware(fw);
+
+	return 0;
+}
+
 static uint16_t amdgpu_discovery_calculate_checksum(uint8_t *data, uint32_t size)
 {
 	uint16_t checksum = 0;
-- 
2.17.1

