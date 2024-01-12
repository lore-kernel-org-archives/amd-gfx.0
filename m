Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA11C4706C
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jan 2024 06:26:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DB1810EA36;
	Fri, 12 Jan 2024 06:26:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53B4C10EA36
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jan 2024 06:26:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evOHJUMx0XaC+WlnUcWIzOjeZ3PoMGjpjFyIoQ3Rn0X/pWH9XGmXEW/VQ5Qw+6EcTusxKxxs3N+CBRR1u7XC2ImfC3Y17Ya6b/4l9sJFmUdaMYSGo6XsunbxFOkSgIB9nG5RLTKJvoD+lyePy0sQb69mvE+JxUr5Dx7BpLKe48f4JOV53kTIiZnEF2YHlBO3sVNyeVUkvveRxlNokpOoi+IvMCaPsQ/QunR4UbXMXS5VHpsjdTphocTkCp/3Eadqd4sqrGrRdSuV7euf2QrDcHo0QlDteIpfUmzU8FXYDL3fV8JeSJVjeqMGJ5P/DhLbY0uUaX2x1ZEpJDIuTO58TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8a2Q2AWQcrrDy2380nCQ5Bf0r81LoppT55b6ewdNo8=;
 b=gQbxbROx6+5yLhmuxjzvcL8lpL5mMgZEIrp1elbMxeM90sJ5uWT/X9J03I2KjNByT+htZXGbuydSKOYFakFfKCIrX1G2y3Pt/Cv4vn7V5w9kSQUW/hpfWlzto7mM3mM2oqA3MojiwIKK/gNu4Py8WXKi3z/oovcJlpHPGpuj4EN3iL/yiRjhKdZt1gpV+chPhyrOuqXPhI3taNbiykgZb01YhQurCSmbdSDjgjWn1Qc/3B3D+iTvq0YFo3FxcxTjBBuZWfKhGFOOf25iVQ4XA1aoqIw4n6ZwIsyu9Q45WWH0rDUw1m017QNEsGBZo7N5ATWitTw+r+JPkNsp1CmviA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8a2Q2AWQcrrDy2380nCQ5Bf0r81LoppT55b6ewdNo8=;
 b=vSF3InqC39gWAHs5WHlAyEMWG+A8jjrG5rgjVPiysanAgudKoxhv0xCSHOkf9LWPVYYsvmA5EPBp7f/vMhu4VpAYICVHeU2boQOa56hBbSUycZF0EumY9qxZ+c+qAvtED8AOAlF3XGCaG3tfcTSCW+WNr7izKRJ9Bcb57awJRbw=
Received: from BYAPR02CA0068.namprd02.prod.outlook.com (2603:10b6:a03:54::45)
 by CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Fri, 12 Jan
 2024 06:26:37 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::46) by BYAPR02CA0068.outlook.office365.com
 (2603:10b6:a03:54::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21 via Frontend
 Transport; Fri, 12 Jan 2024 06:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 06:26:36 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 12 Jan
 2024 00:26:33 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix the null pointer when load rlc firmware
Date: Fri, 12 Jan 2024 14:26:08 +0800
Message-ID: <20240112062608.778456-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|CY5PR12MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: 0316cd92-bd6a-473d-66f9-08dc13376de2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ASgQxwpu9q110NxYtNkD1Q50Z2GRQgh1GsT8+wvBwqmNRt8rAYeH0XScTbrptnhCm+YUxGZS17+IfVRulgduq0Ya6LYsF2FXtHS1EMTNaGZWTTcvpwTYky7FFk2gE3tfOjgTWCEv4St3ju93qOrXZHIIhqHpOAFS68hsTd9ar/qjl1Wtp1JQrDSoOvYIcv7UqAWs+Ux9zwyNa1TxmoHX+zRUUV6iMo+W+2Hu+IKB5Mdc60Hp3JfkO+UcR/nVRaVb4K2OhIqSHnDVfCeZRy0QQiP/FKP2u6+pQt5LD5Eu2dhOMcOT86CE6vYJFLOLdT1Nc7NkLRWDEa2zEowXzEtpC0oAx8xRF1EUKExjtMf4G2uk1lNeiFzZxsOh1PNnJ474dtUoKfYsul1eIQI3HKNdG+SIrvmKeyUNSf7aVUKacQ4LW7ULIp1OPhNKWSoUtsOEuov7pyHmY6TyZa2JwXT7XWJWGbQQvLgQMSlAu4C2dIwR8/ZVjojltg+LmPY5WH/WQL/JrlMrCcnjRhKupoivbamcgYPYk0ds/Lmqj/TG1OQiaFLIjewWHy+FFQJuBItJJJliG09LPCbMr6NA46Q454zJSDdut05urUfbFaIUxTAMTEy5CKrTg9ke2XlthLrDmnyCJOmsyjt5hlGt6wvfdx/JcHWr+d95oQ4zdPfzpqRx4kB5AzPhGT/C4i6q5a79OJPhZjP7fHltTiYyR2pd95hHtoR/94tYFOkRG6l6OJyX2l+S/QiRzUVTAPmNRgTD2W+3FTBSljg9EXsQbuOkrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799012)(40470700004)(36840700001)(46966006)(5660300002)(478600001)(7696005)(6666004)(2616005)(86362001)(1076003)(26005)(336012)(83380400001)(8936002)(110136005)(36756003)(70586007)(41300700001)(4326008)(426003)(6636002)(316002)(70206006)(36860700001)(81166007)(8676002)(82740400003)(356005)(16526019)(47076005)(2906002)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 06:26:36.6200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0316cd92-bd6a-473d-66f9-08dc13376de2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6252
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
Cc: Ma Jun <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If the RLC firmware is invalid because of wrong header size,
the pointer to the rlc firmware is released in function
amdgpu_ucode_request. There will be a null pointer error
in subsequent use. So skip validation to fix it.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d2c34436aefc..4d90e570b3cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3996,16 +3996,13 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 
 	if (!amdgpu_sriov_vf(adev)) {
 		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", ucode_prefix);
-		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, fw_name);
-		/* don't check this.  There are apparently firmwares in the wild with
-		 * incorrect size in the header
-		 */
-		if (err == -ENODEV)
-			goto out;
+		err = request_firmware(&adev->gfx.rlc_fw, fw_name, adev->dev);
 		if (err)
-			dev_dbg(adev->dev,
-				"gfx10: amdgpu_ucode_request() failed \"%s\"\n",
-				fw_name);
+			goto out;
+
+		/* don't validate this firmware.  There are apparently firmwares
+		 * in the wild with incorrect size in the header
+		 */
 		rlc_hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
 		version_major = le16_to_cpu(rlc_hdr->header.header_version_major);
 		version_minor = le16_to_cpu(rlc_hdr->header.header_version_minor);
-- 
2.34.1

