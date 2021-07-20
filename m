Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0545AC07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE584601FC
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE584601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 452386E448;
	Tue, 20 Jul 2021 15:44:30 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2054.outbound.protection.outlook.com [40.107.100.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDC436E446
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzre52Lb5fwMViduQtvevYNQKIUY5J4pWHpqy2w67Q2JEiy+X2ZR6e8lYn9PtRLVE8YdsK5+zI35ZJl6POXiJHqfXcIhr1j5PkRYcdDu9Ud/OlX+cNrgYkNBKGzweM+fW5QAiOMRAkru4AFQgnPdYCrAcXo3okHrCMJOoxR7IFg4pD5ZrCqoafvFFlxU36rZrQVv90cpEZ9VAyGtGRx9oP7ZxajChBGUV309hSBJal+PWE+YrQ/Yvhcd51hjYpc1SzQHk5/6fPOtxDgSDfQW0C8V85IZNB/3AVMyCxbd1frkw1GnZSeuItv9YiU8KAjklObYRw/bCR4WK6XkdcaDtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oP1DJCBhLHC6cOzsR3QISlAV2EuC2K/BMpbXIPNF5t8=;
 b=FCR1aqBTmI01MIAc+5s47J3ab7cMlpYRmQ0qlxz3MFvOLmN1bgTS+6ACDBZms+hWa2XsxSJFZdOYuIM8jDrf1Wiv6eqYBb+1bCALvtETszHRi27Oa0Wffy4Iogv6G6Irmw30OR+82AkbnCvJFugBwgIHuZZooO2modvjNdo0UDDXOtq8vAOgR7Fvnt+J/xjl6p+5CgbGfnPN7omVsV6yMz8tAn6ANM+qKTLi9ip/FP69jtUH0LBeEpNWlqQ/ruh9xbI3uK6en/CA9pJ1gfawTJRFyrJbWHj0paEm9tDabD5AwsTsqWzpcQnOj5u8IBSrJtH39yyZ4R+pihinZ6WTCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oP1DJCBhLHC6cOzsR3QISlAV2EuC2K/BMpbXIPNF5t8=;
 b=1+whx7ej/vXxf76AyLNhc1hjL9WwaWdN5ULsAzySaUVFSmUK7iLxY5FIV2+0SjkcymM5tCNndn72fQKfvFIZVgqqUksfpRHUZLBsJopU3y8kqYDavHQFghcOvzbw4N1WCVBrWmvp8Gtg2g95MB96O8JTyBKD5IOxxbVXrBNLug4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL0PR12MB5538.namprd12.prod.outlook.com (2603:10b6:208:1c9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 15:44:27 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:27 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 26/29] drm/amdgpu: add check_fw_version support for
 cyan_skillfish
Date: Tue, 20 Jul 2021 11:43:46 -0400
Message-Id: <20210720154349.1599827-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720154349.1599827-1-alexander.deucher@amd.com>
References: <20210720154349.1599827-1-alexander.deucher@amd.com>
X-ClientProxiedBy: MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37)
 To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31e09570-d737-4c5e-3c02-08d94b9541c7
X-MS-TrafficTypeDiagnostic: BL0PR12MB5538:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB55385930E9E1B81490AA843EF7E29@BL0PR12MB5538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bx6FdbtPHjiR0XOI+oED7p1geTfG033i6Pbsj6bOL1AIhy1Bpm1aocFYY7UT726tUpnE3AppMnooIzLuqeKodnCB8ag8sOB31qW3Hv5l2XvAuYjiivtJ71iY87qW05nrw/TQi13pMsZhypnK0OKMseU8bS12IBHE3/9ChmqZJXNxdzUuag0SI2eOjJUVLaW4bXkMjA/v1jJ8/aO/fRN3YH5bQmey4XvPgiPYawQ3pIu8gg+13z4Yo6iHUV4/19PuYI+4Ux1UltDRpLZ9DE6kLXkWpKxaxgCBRBxzGr4KeB2W1WrAcOFY7sv19upp2hsEnY1yDv5Bcp9laEWLXs83sT/rP0NohAgu5Om67Cr9Andss52BWmMMnX5cgwkxpg7x+YnHJPEfNE89s8Jzp44ThHaK/sfTPA41mKy95huQ+QuLz4AL8f1LW6L35zMd86qaINLY7HUIEpPTwudcISlD8mwG3pfWUBr4KHUfLlKfsWJuuf75wsnqX429a8W7Q1B/c6WcuZbvFtyFPT3n99IYW/IhD8+aAybNuvkvhOw0VfFTjcFwljYpoftT6Eq3AbpaP9Tc/fO8Mku133XsaH9R/KJ1rY769YWNQa4kdS5sif+WfsUWPuI9yWGrdBNgoBlQhB2bLhMNZYw6udWVAxC1D0lK5ZccFH4GxRNqsumjqY7gFEJ59MhL+RaixLWWzQhafWZ2AT4jaZ/w8KicQ7F/3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(186003)(4326008)(956004)(6916009)(478600001)(36756003)(5660300002)(52116002)(7696005)(6486002)(1076003)(6666004)(2616005)(2906002)(8936002)(38350700002)(38100700002)(66946007)(316002)(66476007)(66556008)(26005)(54906003)(83380400001)(8676002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tufAw6NOORLV56grc0kAlzDLAe45MRGF1cLDEADIN0eNSllNaeX4NqY39uv0?=
 =?us-ascii?Q?9hizZf6eEWC3zHiAFFb61Dae0ue4LqyMInQXxMKlsNsy1mROzF0I3uzRWMV/?=
 =?us-ascii?Q?Oh5PhopgMv83kVUN754sNgJeiOJpJpCVPdohCCCtToWIzlzv1i6G2Q5vkP2e?=
 =?us-ascii?Q?c6vDM6ECcMPVyRgfmwUB+m2fnSP7xcDyJhEvJLwzRFfD2KxUTJkR/tV/cGao?=
 =?us-ascii?Q?gD5mGyVOMfN2rcxdvSU2LTug9SfbYrGo2o+79SmW44TfuwkP1lEaza4vM6ti?=
 =?us-ascii?Q?FxxO4qcVhxsk5yyW+xZ9bgaL1BdSf6PSsID8o6rHlycmq913bzLPnK0KHrU0?=
 =?us-ascii?Q?lzPgt90zYmxl/lwT7+jl0qDiNMNIn7GvyvSQeWUOV0MViyZvoImIuOXQ+oX4?=
 =?us-ascii?Q?t8/CBkPV9ffXPbh2iM46U905LJZDACiLanFm8PlXhM8/6y1W0zLmjUTAGsxy?=
 =?us-ascii?Q?sUtZfb7o3r9GLTcNUoeWfrHJEbVXPVXhGor4RsbGaRzJbeEg24XVYvTSASup?=
 =?us-ascii?Q?Bib/IgvSLgujGVuH/x0NSa21k+rnEFYYk6XHfa4IkJ/exfYicUUlfv1pTFyp?=
 =?us-ascii?Q?qyr4nyKm+3jbpDFxGORR/DMIvjUBGNuVZFCtcXo0y4apXIjalUiyCEq83WWl?=
 =?us-ascii?Q?e/4P3Zh8q5BQ2dbW2xTzGnrIpiGjhNuyA/or5UC/MZn+gmb1efgkp3LZLpU+?=
 =?us-ascii?Q?pjFalLAH2INa9ApxNr/jufICLQxfZt//pKxsbrwbYT2fg1S5PDjHZn9SpGYA?=
 =?us-ascii?Q?wqyiuv0C/8Alo75ikdH/5Uk0DVWv98p0z4BLLx44Bp6yW/wk2eAnjKU3X/Re?=
 =?us-ascii?Q?PD/Bi5E/gwV+PAloEREbX21Nq+ANIEd9v08XRVYN2Tzw1TYuu7MS8l1XWjzK?=
 =?us-ascii?Q?MaL65MtRbzT78+OnTuiCRB1FX6uPRuKyD+Bx+2t+MI8IRkb41yD/+JTUliNt?=
 =?us-ascii?Q?bNtFYTbh4WYyEdGldaO62W4H7WaN8eVQSJiPh3gSUqSTUzeAhUguiYyZT62c?=
 =?us-ascii?Q?ocKt465/8U504LFfLoUQHNaKl/mh3hfoUfpbNovQZjyBhhbChX89JsA1fqMS?=
 =?us-ascii?Q?24kO8VAqgTxEwZ5sMQB42hzVhcz9fVUw1mxVZsU9N8ZMiU8emvXhx6dCp/VR?=
 =?us-ascii?Q?WrZ0Zph7WWsKP3UPj2Yg0Cuyit1DLV18PjIGssKr5tKDVFsQ2uzOGxrVtxjJ?=
 =?us-ascii?Q?pz9dvz+lC0S33iIC2dLhwrbnKS9VDYo5nGEKQmk8k24CBoD5zJbWQ3Ph/bzy?=
 =?us-ascii?Q?pxbbcr8T26acB0u+w1Dc1CNusVYsMgejiBOEGs0PIZbuDWeeYp4BTzgIXNFl?=
 =?us-ascii?Q?YbAagXuTegixolxmpdO72WZf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e09570-d737-4c5e-3c02-08d94b9541c7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:27.7562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: maE13e36z14rjG6dr7U1aYgc2jrpwC5iTHZ/EtkNDA8dpbV5ZYS85gM3gff05dPkNAb40n158CQ4Gi6aD2Y0hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5538
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <Lang.Yu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <lang.yu@amd.com>

Add check_fw_version function support for cyan_skillfish.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h                  | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c          | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index b89e7dca8906..bc29f0ee4a5c 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -35,6 +35,7 @@
 #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x03
 #define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xF
 #define SMU11_DRIVER_IF_VERSION_Beige_Goby 0x9
+#define SMU11_DRIVER_IF_VERSION_Cyan_Skillfish 0x8
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 4fbffc14021c..b05f9541accc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -57,6 +57,7 @@ static struct cmn2asic_msg_mapping cyan_skillfish_message_map[SMU_MSG_MAX_COUNT]
 static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
 
 	.check_fw_status = smu_v11_0_check_fw_status,
+	.check_fw_version = smu_v11_0_check_fw_version,
 	.init_power = smu_v11_0_init_power,
 	.fini_power = smu_v11_0_fini_power,
 	.register_irq_handler = smu_v11_0_register_irq_handler,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 0a5d46ac9ccd..1ba57e5afefb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -266,6 +266,9 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
 	case CHIP_BEIGE_GOBY:
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Beige_Goby;
 		break;
+	case CHIP_CYAN_SKILLFISH:
+		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Cyan_Skillfish;
+		break;
 	default:
 		dev_err(smu->adev->dev, "smu unsupported asic type:%d.\n", smu->adev->asic_type);
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_INV;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
