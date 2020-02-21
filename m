Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049F2C35656
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF4442067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UdDIUq9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4442067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76E876F499;
	Fri, 21 Feb 2020 16:03:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B108D6F497
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:03:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5RUyf/0tOxmtk6zbYkmXX3q2W0b2FIxBefC0xRcA3ImYzTjN6hMV7iJXf5eIBXiSAxMM7dlwaoe3LhAiZilsSntk69ZvpLnlXuV741vygPEExCoEIMJ/6Aqz5pCB796dorK4lDHlEfZiGzKT2csVPn0nkWDsmRJFUExVj+kHaXqY3rkdlpVNd0yzdU+OHZWygI39FWWbJ7RxqUf9Q8fxle3713risLUtoyGz6ernT2U/xKngfeF6GsotxQiCixgkm0I96nQfJrUT4zF84J6k6CMnn2YhXkjxEavBU6K7GUOEv3mZD/BrNdAD6f374NgWzZT3p5B6IZxQaW203+BQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZJMxi6nCqTWUPqlpyzjGN7zdNC35xtzeyRsqQ7+plM=;
 b=B5Vdbj4EfMT60X2xDRj1GgTV2QOoYf6s0bjD2ozFXQh2hKjyc6oCO0Vva3ZpDw/G6R6KcDG+O+nFdwYNyEklBV0xhpvO4pwL94WXVGYe2KkZuOrhqTmZhwj95aDJ3KJHKdQuH7FybVA9nhc/8Xn5w4pelQg78ztFPPoF/pHPcV9IE7U2TGKLM2D0WWqPxF1RIkBpqAJXkQlL04ElS4DbvyC3Ab4Ds4gY3ocaMr8f9/vbr+yDBA5ciXv91H8ibI/eZLJ/QRuvIJWRQEA8Dl+HbTX4PnztCSgWLJuioLI+OOg0z+w/4XR4G/wFvl9UKKxvSkq5NN6mrgUsAubjabzNgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZJMxi6nCqTWUPqlpyzjGN7zdNC35xtzeyRsqQ7+plM=;
 b=UdDIUq9hiEG7nVOX/oAaLlqHwQxUCi3x0e5MZ9BQ5M0S3+sRRnULAJ8G8R0jPGzZfEcABwJ8qwB8gNqoY9ya3kVJOCsYRstF2Ic0vdrCcWu6uUxqKAnnU/iQuBg6Q/c8K/tvbxfZxsTepnkKxK4+XpPKOMUJAGmlHun2qbNydyY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:03:50 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:03:49 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/35] drm/amd/display: dmub back door load
Date: Fri, 21 Feb 2020 11:02:53 -0500
Message-Id: <20200221160324.2969975-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:03:45 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2d383527-5ca7-4ee3-9cfa-08d7b6e7a1ca
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2572411E17A9504BC4F2936E98120@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(1076003)(5660300002)(36756003)(2906002)(8936002)(86362001)(8676002)(6486002)(81156014)(81166006)(7696005)(52116002)(4326008)(6666004)(316002)(186003)(26005)(6916009)(16526019)(54906003)(2616005)(66476007)(66556008)(66946007)(956004)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Flc1Kr+78P7C07Q/Z/cX68DM9kzzZVXEluLVKaiKwTUFakQZaQ2evfSGorM8zB1Yt0Z9vT1SgC9re1jWZI/rXDZc9hLbmsQLXel3X7j7jmvz+GWZ0nQgaaCXnWe0lKfYoiJU4O0pW/wk8H9e5C17eviHZ9TRHCYkqy/EG5DWGlMmZQ/8AMfLXSHmwDpkIX6XNQSLwtR4RNxL7B4eSfflBZ8xklg++vX8tqf+w5LHxfxLVoHOUJ48TtzsyFuW4DSl5MmIQyG3d8dsWZP+erLVNzY0czk6b9calSnnn351m4+ERnVvLPyMw3x6zDdjeSiGsH9FTWfdlbBBZ76hX5pBfH+XT/oxxF0WAccjIspBm7xVs57EJLnTTMXT1gEhws4FWggTiSDvIs/HbjFrewb+8yeJvxkcJLAuw7cjipPNKjkeKXSSSJ18p+EWCNlxaLPo
X-MS-Exchange-AntiSpam-MessageData: Sq7AoYGyqQlgwRQn/l48SDlrgKJn/whkWW7L88oqSuBHw3mM7mxMT9sV9eWsRpqZtopJrFbiuxCf8Z981Z0PFouRWEg+yBSjHKN0/DHywmd/JKtSu5Ba6KLtSAe4g8paPc+TOkVkM4D16P+nA8zCEw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d383527-5ca7-4ee3-9cfa-08d7b6e7a1ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:03:46.6664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QG2Xz6HD3XpJCn2arAcVzv3tvcatwbaF/Hj5lJM0rAgAFfhaXQMc+6nwSYIXnFsY25WDyjwgHCpeCCct6K1X8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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
Cc: Sunpeng.Li@amd.com, Harry Wentland <harry.wentland@amd.com>,
 Rodrigo.Siqueira@amd.com, Jerry Zuo <Jerry.Zuo@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hersen Wu <hersenxs.wu@amd.com>

Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0e7d75436d59..aeca0ada2484 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -823,6 +823,10 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	hw_params.fb_base = adev->gmc.fb_start;
 	hw_params.fb_offset = adev->gmc.aper_base;
 
+	/* backdoor load firmware and trigger dmub running */
+	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
+		hw_params.load_inst_const = true;
+
 	if (dmcu)
 		hw_params.psp_version = dmcu->psp_version;
 
@@ -1187,11 +1191,6 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		return 0;
 	}
 
-	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
-		DRM_WARN("Only PSP firmware loading is supported for DMUB\n");
-		return 0;
-	}
-
 	hdr = (const struct dmcub_firmware_header_v1_0 *)adev->dm.dmub_fw->data;
 	adev->firmware.ucode[AMDGPU_UCODE_ID_DMCUB].ucode_id =
 		AMDGPU_UCODE_ID_DMCUB;
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
