Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B077BC07E9B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E536601FC
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E536601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 115C76E444;
	Tue, 20 Jul 2021 15:44:30 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2089.outbound.protection.outlook.com [40.107.95.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E048C6E436
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EX/CVuNBXaagTw/uqvp1cQAOR4AurcRGl+1TedZ1mpEyksU1nOWRwLHwtoCYLVH1zBEEooBypKSrfZIcauP5CYMG/j77ohxHu+/9E7JTMJUuV3sWNucptu+UDPLlEUKMTNxYY5mObIUomWgx0Utr8Es1umWknZGu3edEp3Oikr389IkjvhzlrGrasibbu/E5T37oj1xSItxMRZPZZlpjdDTFQ3YkhL6mdKJYn3thn4eQ2gQLBX/k9fqGxY87OpvYiNV/NFGLmOU2duV/Fvm8P6twGRHk9e8oO2oYQO3btgMJuC2b3l0lxBwS05+/7zTcTjqqdXLYSpMBlfnz7Eljug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTUeHrvRjSk4ak5/fRdSpYHgkN+GPS60xAmZ0MdUlVs=;
 b=alcAOJFe0CVW3SzkQffIw2VKSXyd39FXfh6g+lqI9+wHlsFemq8BFsY6bYX8u6wos8HipNbhqFFXzH0vziDrNjHA3Eeb7GLI5HzuYriBve/MyJQB2sBnRLbAWaYBW8XvMpW7MMZi4ZzUWzf+iJIoLaQAi/N6p/KEsieRurTU4QD9fcUMI0ktpLfj0JbMT2t624oQm10FV+9U4fL/aEgR5I3pP2XnQ3lsLIitoQXwqmRJIetu91+MGRyyipGF7Wujag3nqgYIAxNwQm8rpfxAJZu6ywJDCMCXWKkbgH7Fhblu+d8WCsxM0U1RobFS1QsdJ31JcDhnxEMn/AcK/TgRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTUeHrvRjSk4ak5/fRdSpYHgkN+GPS60xAmZ0MdUlVs=;
 b=nL7wznRXOfUGbAGaPnZgTRbuFRDnPlSscv4WeN/9qL4F+aIWZrKxMeg7yBfpVJYsete4FVVHJxFm8AwAG4dd0hhoGGJSQksjJR/z5FlTXoq8esqhn3vtD4CVxP9tDIGh9vG4uGHpTPCF/vAkDpKJQihQU+ZTTxb+4uFpPU+xgUQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Tue, 20 Jul
 2021 15:44:21 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:21 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 19/29] drm/amdgpu: init psp v11.0.8 function for cyan_skillfish
Date: Tue, 20 Jul 2021 11:43:39 -0400
Message-Id: <20210720154349.1599827-20-alexander.deucher@amd.com>
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
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84e844a1-db52-4622-212c-08d94b953de6
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5349250C0EF2025DE162AB53F7E29@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 75f8BpGQsePKHz5cWWibci2ZTDpLsLcOOkEQTKuIZDV49l5+oftkKwg//GiSlcauXKopb7FiZM8CVaA0gmbCA/1RhiPshRMEKmZ9p8OEZbkVlgQx2o0ObBMhQTL6zDidg4kslLqlJIoSiUUqPDMuMkioxJQdxkumJcbhlf8a8kziS7bFG6xDJCLlFaiWtsHzvPhhz7JV48I6WtqpzbgXkkcobeW//8YAB58/tf6M4e6uqRbRr0YGOQAXWAMuXQJymcfVh1NP/OJNSMsrnXNw7fu8uWP9+3CgltHZEQyjhM9kVuCHCknOBYjxYoMxKT6JJvoQnHl7BOGQaJaBJu0HyqSxPh20Cw4PjgljAa0KZskVMenQUEEBr9ogGYyCm1kcd91dOAxQqVOBDFWYfu8amXlbtne2kjf2l7yYeDiB1FG9d5mvsUEdZ4DcObSoHu95aqFbmPBOL9vzHdu1aDMe8u1udJUIaa4CJqyobgPvZMSWBN+M0rD6JNCR9JtK/rmSwhGpHVYM+Tk5PKWmexiCc6zBg25wKYAWSg5UXkgnTS0a6nGA5N+NQeB4YL+KaRyqqHhi8gGkdTSv/cWxg1dNNsqKpVqETjTORyeYW22s/3vvZJMvV51XT0wCRtxTunO7dyTcAfhz6I2f/CiF3T6AyG43XUWss405sqhnVFB9x4Q8Yyr39rMdPMlfPk/nS/il9roEU2EAbaz6AkPnaLl4WA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(2616005)(86362001)(6916009)(38100700002)(6486002)(54906003)(6666004)(4744005)(956004)(478600001)(316002)(1076003)(4326008)(52116002)(2906002)(66946007)(38350700002)(66476007)(5660300002)(8936002)(36756003)(7696005)(66556008)(8676002)(26005)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gkmiBITw48J1Uv1lFEx037HZ0VGeRurzlyhgC+Epe3+2Z4Uq1EusJ3ISXU3/?=
 =?us-ascii?Q?TiH62KplkzxQEexGaQ+KcQfJ7Oq5omhpBdtg/QWHf83SBKHq4urDaBlpeNvm?=
 =?us-ascii?Q?7gHH5K4a5GwRbfgclf6URAbAsHUMsWbLa1397FI5m0mmTaP69Fuc+tA7NDg6?=
 =?us-ascii?Q?ACCegwqwOvzEqJplsSL8t9iXm1/7hUhNuPyfJbUyn/dL2V8heow38DRY89bq?=
 =?us-ascii?Q?x5pJkTOE1159qvGyiHCVqV2nvjvYg3/Ytow62MMiGFpxtXiM56lPJXan+zDW?=
 =?us-ascii?Q?ZrnsulPjD9/m7izfQGG3wmw8zNKrDoA60lEWwJnVMtwAxENFCzxEAsCA9Xng?=
 =?us-ascii?Q?fntHzGekPW0a2CYhs/0oer/xuZ7s2thPK013n5tqb8q2GpZvtXK8E2vg6Cyl?=
 =?us-ascii?Q?3hZTtQLR0GLTCY0sLBFNTP//gKJ7ovwkiMSjeV9OkVj826tHHpMZHdaXMzp2?=
 =?us-ascii?Q?MFgBkDnruOHp9vY97kbnpLPzzH7brnswCBvDWoP2Iob0ZDP5jWWQ4LkIVKLo?=
 =?us-ascii?Q?D9a/dBVML6Ucces+WhdDV7Gj6ZZFIb01SwIanS8/oOCFRCpD6mzb1/yAtQC0?=
 =?us-ascii?Q?nu5cO6PPOZlsASZW9JOqOdFjN1Tkhr3bxm6cmrSRSfCojjH9i1ztfdpls+oj?=
 =?us-ascii?Q?eLVg+H/rmZGa2iYosdqUCu4h+4sCz/pFeEXw5QCVOF1pyGrYl5v7HQUUpBcj?=
 =?us-ascii?Q?cZEJLQqTdczDNERE/s7D4vO9t5tB8baKkHGo/ONLg4YRzN5m6dSVjILF0nFT?=
 =?us-ascii?Q?6BkadB/DqWOD0u1CuPSZo9Z8cG7/8+vmTW87DPHZA7htuqhLkZ4SGqJYYW96?=
 =?us-ascii?Q?pdkhC26gDpFFugXCxanRAEv3pSXQuoOoi4iwilialxFCd3Fs235jidHKzoSV?=
 =?us-ascii?Q?zLXJXBRF49+613FlWVc7Nts6t2DicUjJ/gGQAgrnnmca3xMs1q/2j+gGiEoD?=
 =?us-ascii?Q?ghEuqMRAbTsIGqc7Rsp1jPQfH6CvO/c7EfSVojssnfByMMNEwSpXYtqAcaW3?=
 =?us-ascii?Q?faJ6/b4OYAMSja24wkFXWJ/XNpeF0jwPYRzd6aaXPbgjK+Jy3bU75DSDy00x?=
 =?us-ascii?Q?zoDS4tmwUDtye4AYShkYq3w614LkVNH8yzwS5Fcn35vx/D40anR2eAoFJgID?=
 =?us-ascii?Q?lPqJmIEqZjJ+fr91vfmOKDebehVLb3eHcB7mxcz16WpUNXQ9Oym35Gz+Te12?=
 =?us-ascii?Q?EeQ3J0SChQbb1Qxn0yWCyPKxGaBQae4ZO38m9LfrPib2TfvkRK0i++NMDBzb?=
 =?us-ascii?Q?7v3V1L/Mpl+uFFmYq094b4mY+0Ql1lylMsol/AaGhX9nS4f4ShVGvhtfS8fR?=
 =?us-ascii?Q?1dVlACWboOEzF55IXYossODg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e844a1-db52-4622-212c-08d94b953de6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:21.2847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9KaTRygRdXxs6JkzipOi/2OYkETZaT8NwsXWO4HHzcLHw6DvXelSPqQ3cXbjvZDdjYuYfTbsAJC4vIMY2SyuHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <lang.yu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <lang.yu@amd.com>

Add psp v11.0.8 function into psp driver.

Signed-off-by: Lang Yu <lang.yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 2ef4355c12f2..821a521eae38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -33,6 +33,7 @@
 #include "psp_v3_1.h"
 #include "psp_v10_0.h"
 #include "psp_v11_0.h"
+#include "psp_v11_0_8.h"
 #include "psp_v12_0.h"
 #include "psp_v13_0.h"
 
@@ -119,6 +120,12 @@ static int psp_early_init(void *handle)
 		psp_v13_0_set_psp_funcs(psp);
 		psp->autoload_supported = true;
 		break;
+	case CHIP_CYAN_SKILLFISH:
+		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2) {
+			psp_v11_0_8_set_psp_funcs(psp);
+			psp->autoload_supported = false;
+		}
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
