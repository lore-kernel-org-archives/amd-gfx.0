Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0C9C00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 16:11:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49F25B4277;
	Fri,  5 Aug 2022 16:11:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0677B79C5
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 16:09:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S17rtQj+UQVv/QMUoQHKHy/V+j2yJNYjzi7EHs+qW/AMK6mX5GiYzRXO1JEAfLkdTgCU80riRkfXvnIOaWbgvHsXjQfPG9laQ3K11RF7khCYG23DiF1yBzRT/uJEKnBBSlaIwJWzfXLqqyvU54AKkc5Z1InyXIfzkxZGJdcB20cip6nlBhVOrPX2b9wYeKseKV9n1aiMRMOXGsmvM0kPy6AcFSkCe6p1m8dS1/U1+T8cEA+JWZT6iMgCiCErDD+6yqFWQalvEdewKlTFDUIEUzGvzlN5JxBL6/gnBPOMWVWNLfvinGEhAK0pKt5mx4s1IRYp1XW9pO/94+gjpgh1mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N88srQh7SksrouijLTb69vpWxOQ6aMamn+SZiZGtgFs=;
 b=niEdVNd8aIkW/gte1ANFZfhrHm4WEm/Pyyvyd/WSvTPjqfgDK+clU6bTNPQiEF7Xz1Dwc/jisLmvpSQJb1pBrEIzZIAEqNhqXLkUQrAKyMJm2w2OBcctYkzQQQ/QOBe1mtVEgCqjsiVgKBVx5WW1qbrEM1c1QxWc3VOttM+m7rCe4glhCv65Mq13BPZ3FmrZtmqMM7Zm29Oe/JjWI5sbohh9Iwilj4jjPS0LAoQncBVxiWBk1McSuD16mCdcXkH0PTDywGLKcjVq5W2BLAXEQ0DzboaccNyvSfXllVteG7jc8H+moX2hJjRuM+onJLnbJQBpuNU5keZXKjNJpL6/Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N88srQh7SksrouijLTb69vpWxOQ6aMamn+SZiZGtgFs=;
 b=iA+8rMZD9nCJ2zysUfeOY6uUjLv/Y/TY114cjhJnGcExncMm4InwuhGkPJ3KigWGPkmElAGNBriqTCl0lUfMkXettoUSkXpak8m2S/SVOj1taQ817Q2/3uMUzIMN59XKRcnsUxZver6uLULyufEuPztnHJl6l+4Vo9pesp7DUAQ=
Received: from BN9PR03CA0471.namprd03.prod.outlook.com (2603:10b6:408:139::26)
 by DS7PR12MB5960.namprd12.prod.outlook.com (2603:10b6:8:7f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 16:09:47 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::73) by BN9PR03CA0471.outlook.office365.com
 (2603:10b6:408:139::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Fri, 5 Aug 2022 16:09:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 16:09:47 +0000
Received: from shaoyunl-dev1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 11:09:46 -0500
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: use sjt mec fw on aldebaran for sriov
Date: Fri, 5 Aug 2022 12:09:30 -0400
Message-ID: <20220805160930.13664-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fe9a113-e20c-4594-f974-08da76fceb36
X-MS-TrafficTypeDiagnostic: DS7PR12MB5960:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iHVGjhm3kIbrVopVmBcadyFWZO8smU2nqjcYGkzlrZW8wKgavC28/UpVvQkVC4tLkNTiFlvSDv/+adWqBdNNr5i+Z5Xc5jzX68fnMgFg37SuULC1anLY/t5aP9pUqQ4CZQNUmQoxFE+H+wZzpDPi3JynSen1p9Q4OCdMF3XZNxkAMtbHR/ovob1zfLh3TCh4zxZkUPudfGPB0F+syvrozShIwANJttmFoOaY9a4F+jRiOgajzP2kFp1CRXU7sOD4Z51ZFl46PuBYhXenqpn+WLaku+NGV6f/o4J+yQrfzhu9R6J9YJISDBCEa++V08rNnNGshUev1Pwa7Esh7fPdTUUDLsuwfFH57s5JVLGiz53N0c0cxjd21PzJSNdBmAwDfLeSsuPG3nMUbQTv0HVuqNYSYbe3QYWYyeWEAaMOx7+uXA6mBZfmS52h/EkMoT2tTzELclptnayTHXGWUzTcDzan0XgC61CZTQcYoTtLg0BcrW4P6uuIk/TA5UwxcjH7xuTw+HmMRL1kRJNhggXWgG/KTeubZZl84McR7SXBGKuA4dDo4gaRG5W/EVvre7H/2AcLduPx+jtnwj4s+LsDHDXq7L8FGxo+bBh9NRrMngwDV+xz50sDiLxfh3/BJU13B8A/SAXo8NXXSFxCcxQ9die8RQhPH3bUda7QOnBpmcRkQLxr/doX/fDIYPkg6ajwuVg7DqeOmSZ1vm+CKnxN64bOfabmcmVltxZiowcHq1rHa/7R4MBFNkHh8hXPgoL0oPTtFGfRATnq1apo1Z78LuI1/BBLmnPL5WmYofGWmzfwEa4pAjez/ljLE40NUKz5HdfZWj3XdIgwwU6Ht0RmpuT9SpoajmIJpFMr67fxL2M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(346002)(136003)(396003)(40470700004)(46966006)(36840700001)(6666004)(41300700001)(7696005)(82310400005)(316002)(86362001)(40480700001)(81166007)(356005)(40460700003)(26005)(5660300002)(83380400001)(186003)(70586007)(2616005)(336012)(70206006)(8936002)(8676002)(4326008)(36860700001)(2906002)(36756003)(16526019)(1076003)(6916009)(478600001)(82740400003)(47076005)(426003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 16:09:47.5806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe9a113-e20c-4594-f974-08da76fceb36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5960
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The second jump table is required on live migration or mulitple VF
configuration on Aldebaran. With this implemented, the first level
jump table(hw used) will be same, mec fw internal will use the
second level jump table jump to the real functionality implementation.
so the different VF can load different version of MEC as long as
they support sjt

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index c6e0f9313a7f..7f187558220e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -126,6 +126,8 @@ MODULE_FIRMWARE("amdgpu/green_sardine_rlc.bin");
 MODULE_FIRMWARE("amdgpu/aldebaran_mec.bin");
 MODULE_FIRMWARE("amdgpu/aldebaran_mec2.bin");
 MODULE_FIRMWARE("amdgpu/aldebaran_rlc.bin");
+MODULE_FIRMWARE("amdgpu/aldebaran_sjt_mec.bin");
+MODULE_FIRMWARE("amdgpu/aldebaran_sjt_mec2.bin");
 
 #define mmTCP_CHAN_STEER_0_ARCT								0x0b03
 #define mmTCP_CHAN_STEER_0_ARCT_BASE_IDX							0
@@ -1496,7 +1498,11 @@ static int gfx_v9_0_init_cp_compute_microcode(struct amdgpu_device *adev,
 	const struct common_firmware_header *header = NULL;
 	const struct gfx_firmware_header_v1_0 *cp_hdr;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
+	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_ALDEBARAN))
+		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sjt_mec.bin", chip_name);
+	else
+		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
+
 	err = request_firmware(&adev->gfx.mec_fw, fw_name, adev->dev);
 	if (err)
 		goto out;
@@ -1509,7 +1515,11 @@ static int gfx_v9_0_init_cp_compute_microcode(struct amdgpu_device *adev,
 
 
 	if (gfx_v9_0_load_mec2_fw_bin_support(adev)) {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
+		if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_ALDEBARAN))
+			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sjt_mec2.bin", chip_name);
+		else
+			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
+
 		err = request_firmware(&adev->gfx.mec2_fw, fw_name, adev->dev);
 		if (!err) {
 			err = amdgpu_ucode_validate(adev->gfx.mec2_fw);
-- 
2.17.1

