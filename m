Return-Path: <SRS0=VPxi=76=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD79C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 22:00:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 870D821852
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 22:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YxHNlLDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870D821852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16F916E1AA;
	Wed, 17 Jun 2020 22:00:04 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750077.outbound.protection.outlook.com [40.107.75.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F35EB6E1AA
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 22:00:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G71JqsAwAddzg0Uyx342EB0rGrVcMCun23WyaF33VHsXtoV50E0XnIzlk1EUC/wJThHM+qv+vK7jAK2om+qsM4cfF7ABDa/MDsKZ4DEFWHRuDgfG8oizuKSItF5k+SlQCQOjOKN/cZF6GXMNQ1hFrHCsj3MvCKrtFpMGatTD1iOGREafopqLI+nhGFts3P8GNh2wFz1nPGsMBhWIljj/u+1Dm952gVTiKPY3eceehaZ9r9XGbFCdxo/pDjuPFIjoB/8p861UnG1Y3fS9hQ0y1CWSJag5zIzrP0PG80cla6kt2maA4ZvW7blleSMfK4jd8C70QMdIWk0iqcJe7DxlAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYd4Ke5WVxzw4OY/eLtZikM5hd6f/2TXXi7v+ISrU6E=;
 b=MME7Zi+7X2V4klcF50bmZvvk5zyxDGy+lk//wjQowqxyv7dREPBoNrXd/yGgrjqTQc0tG87fmvKM4U05Pqz76wjZaYgvrIpBrj78PwCKsLBiH2cZ4hKSVY+8CgiHZ/mYIw2Pb6fmvDrWJEQKfb0x+ybQwyarp7IgvVS3o+DKWGRK3PbwICVtgbRk7DKIW69L1pakzA1GdmMA0eAlHHSc4n2WGXFM5VpL8ztYBYTkE/PQMnbmpmPifwlWpoq5CbwU2ncnVzEKbQneDOXcVdwDN/e+3DnRP3Jdmi77GWE3lv7CLewEV4jG0KdT4S1wmF9JTMAkUG3ZlpIKV5zbif9qnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYd4Ke5WVxzw4OY/eLtZikM5hd6f/2TXXi7v+ISrU6E=;
 b=YxHNlLDzJhxSvyCNi3CccOZ7Urw9Y+ebtRvdN3M7CtpRuJbvTxpSijfpj2x2lGa2rPwnamT15LahMGpw/lD2iQcQ6AEp5o5BlVs6ZxKRuUWSoVI3aehuMV2yLJHyvIop2wG2JliLjlU+kkpWcvSCvUMhWLOwu5HDsaEyLz1K4jI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3433.namprd12.prod.outlook.com (2603:10b6:5:38::14) by
 DM5PR1201MB0185.namprd12.prod.outlook.com (2603:10b6:4:55::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22; Wed, 17 Jun 2020 22:00:01 +0000
Received: from DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::64ab:bf43:33df:e88c]) by DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::64ab:bf43:33df:e88c%7]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 22:00:01 +0000
From: Sonny Jiang <sonny.jiang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm amdgpu: SI UVD add Oland, Pitcairn, Verde, Tahiti firmware
Date: Wed, 17 Jun 2020 17:59:43 -0400
Message-Id: <20200617215943.4783-1-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: BN8PR12CA0020.namprd12.prod.outlook.com
 (2603:10b6:408:60::33) To DM6PR12MB3433.namprd12.prod.outlook.com
 (2603:10b6:5:38::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 BN8PR12CA0020.namprd12.prod.outlook.com (2603:10b6:408:60::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Wed, 17 Jun 2020 22:00:00 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 52402194-6ff6-4713-0f9d-08d81309c83d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0185:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0185A1CB750C4FC763CAEF73FD9A0@DM5PR1201MB0185.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cCIHaIhfD5YFxiumRtV8ZWkmCSMVa/FvwAuQyZgKvyuXKN0b1uDP3eujRItEZqcFx/WW47Hjyb/d2IRzh0NYO08ATGOq36bPFEciQ7O0OncybpIH0jwc2X5i3W4BI+Y+iQqUwAemo6qtDQnqH1uIQwjRbFtnx2NQXVsM2Yer/vQa6Cp+XwLoh3UPKUH9Q4dSGXYWXuH9UkFXMMlbWdR4Fn8/UHoNtx072dkzlnqaT3YmpvSQfaDcakByaAvsXDl56iQF1RDfqp2bFyGuak4ie/spEZl2nu0AJnGPmvlZAtDrZRdfxmDLl/5SY+Wfb/O7rqsD7RGjwNrqZNDEQO+jfmJSpzNqrnusjZ4O1RzxgdlpCDqDNjEsr94ayvqGej11
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(5660300002)(316002)(6666004)(86362001)(6512007)(186003)(4326008)(1076003)(16526019)(26005)(66946007)(2616005)(8676002)(6916009)(44832011)(6486002)(66476007)(66556008)(478600001)(36756003)(52116002)(6506007)(8936002)(69590400007)(956004)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: JqF/SkotQE7BVfvYHlBw0f/AISnNbwQJQeZxhDME4PHmxeaPbm6kCpXXfGUNoQ7dfKou60fBi0+pFgLvigw5P5p7Lpz/nGymVo5b/TCYTJXGBiYyAjIIrIMX3uJjrNIiqLO6av1o2EOjr83HiGIhjZMoYIXNC4/tBxdWmrQ9URZQI1Vv7OyDXv4+gVBe8ZIOQhZ/JtZXy10CbEm06UfuXt4za+zbkVJqpVpN29+u560/OOlbtEa7vKV3SMedT1/JGbIrhTPem8Qc4QRyGJZntKAChjk2rcAJWBpnfaBPJcJV6kBhBO6wUkdAZeqdGn+JXQFw6NRlAiQEaPXIwla7HXIfR6lMmgyo/Hdc4xN95UhUZXGWEyBk2Uq+84/wDRGCoAEjBpCdS2S2cx0mCQCAmwMb4nlZuC7Ye3LtL0Ylltr24cA/dgxOsv1YJdHuoSMMbo4PGtjyB1nzV5/OMt/TkIgw9zxCP338LIS5bJYJspk=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52402194-6ff6-4713-0f9d-08d81309c83d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 22:00:01.1911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0SREAcG8V0+vUqN8FvDvcRr03QbXyGJib8DqzKk6tZ8nhWlz8YrdEq31CMoAFTIiJs0aakMXdZGgPn2BNPcIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0185
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
Cc: Sonny Jiang <sonny.jiang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 5100ebe8858d..f8bebf18ee36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -54,6 +54,12 @@
 #define FW_1_66_16	((1 << 24) | (66 << 16) | (16 << 8))
 
 /* Firmware Names */
+#ifdef CONFIG_DRM_AMDGPU_SI
+#define FIRMWARE_TAHITI		"amdgpu/tahiti_uvd.bin"
+#define FIRMWARE_VERDE		"amdgpu/verde_uvd.bin"
+#define FIRMWARE_PITCAIRN	"amdgpu/pitcairn_uvd.bin"
+#define FIRMWARE_OLAND		"amdgpu/oland_uvd.bin"
+#endif
 #ifdef CONFIG_DRM_AMDGPU_CIK
 #define FIRMWARE_BONAIRE	"amdgpu/bonaire_uvd.bin"
 #define FIRMWARE_KABINI	"amdgpu/kabini_uvd.bin"
@@ -100,6 +106,12 @@ struct amdgpu_uvd_cs_ctx {
 	unsigned *buf_sizes;
 };
 
+#ifdef CONFIG_DRM_AMDGPU_SI
+MODULE_FIRMWARE(FIRMWARE_TAHITI);
+MODULE_FIRMWARE(FIRMWARE_VERDE);
+MODULE_FIRMWARE(FIRMWARE_PITCAIRN);
+MODULE_FIRMWARE(FIRMWARE_OLAND);
+#endif
 #ifdef CONFIG_DRM_AMDGPU_CIK
 MODULE_FIRMWARE(FIRMWARE_BONAIRE);
 MODULE_FIRMWARE(FIRMWARE_KABINI);
@@ -133,6 +145,20 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 	INIT_DELAYED_WORK(&adev->uvd.idle_work, amdgpu_uvd_idle_work_handler);
 
 	switch (adev->asic_type) {
+#ifdef CONFIG_DRM_AMDGPU_SI
+	case CHIP_TAHITI:
+		fw_name = FIRMWARE_TAHITI;
+		break;
+	case CHIP_VERDE:
+		fw_name = FIRMWARE_VERDE;
+		break;
+	case CHIP_PITCAIRN:
+		fw_name = FIRMWARE_PITCAIRN;
+		break;
+	case CHIP_OLAND:
+		fw_name = FIRMWARE_OLAND;
+		break;
+#endif
 #ifdef CONFIG_DRM_AMDGPU_CIK
 	case CHIP_BONAIRE:
 		fw_name = FIRMWARE_BONAIRE;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
