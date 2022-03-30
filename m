Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F988C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Mar 2022 13:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFC9010E0E9;
	Wed, 30 Mar 2022 13:30:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30C9E10E0E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Mar 2022 13:30:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ezqsky3Lu/Ikr9fA3vCNve4lY/p1cftaEzXkq5yyHdCP+AAfgrq0mTN6i3VjezEOpiX49Vii2ezW73Xj9pEMM0n/nFSH7wImenU/n1HiOlGct34RJs8UmN+eqhPBS1t1rrysUfZZmO/p+qe8ofMPXoZ0s3Dw0Mg+dekKFkzrxSPajg0fh1/sZKRAIqcFceaghQ7gkXdnfGuUVhAlRIe6z6O3j+I9ESLCJr7uFTi3ROrB2i3WZWvdOZyUY9S5DShsm//ytNwd+kBiqUTKR7Vu/SS3610tJk7QSJiWVsQjVkBA7lmPsBEA2ktF3+ZVe1UvYJRjIpCHH1snMNilmIycAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adlUj0ZU7bw9E4lATor0TUHEAxzlcAxSTK2BiFPBFYY=;
 b=gMmOuyE0fPMwsWrsdssF0JlnRzbz9zpYspPNU91HqposhFf9fO7igSj6mDMxlBH7+1olg44yeupTJM2ekMU9ycJW21I3jUcDtVNx83WTua12YH78UbMmLzpS/F0B3Tj4MLM9566clq2k7vkqLpy5SApn/AFLovywM2jehDSCTcXQ/S7cYjQom8zo4a164puir9fUUoi6KniKijz7kYe7L7BITmgV/1FMmLpDG6sNbeE4vgs8K7I3auK123dFLMIsa+oMrfwQLUvnASrL2w0OugFttKB5/ghyeVvXw2pLpWQ2+jX1zVMgMsb25GbPFWIUYkyVRekILaaHmjKHlT1d6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adlUj0ZU7bw9E4lATor0TUHEAxzlcAxSTK2BiFPBFYY=;
 b=xWg/YYyMUgBeD+efI82yb7Xd+J5whl00UVRV8OCu7XySHm0mLZ1s+WXQXElC85uAX3B88CEsXsR8wECRSiSMAr4zIZV4kEGBkQPzMeX3+BW+moSXVymJ+aMftPXD7goR2/glc92Vv2eDg0L2RvfnpT3urup1yXM+OcblP3n5yuI=
Received: from DS7PR03CA0240.namprd03.prod.outlook.com (2603:10b6:5:3ba::35)
 by MWHPR12MB1759.namprd12.prod.outlook.com (2603:10b6:300:113::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Wed, 30 Mar
 2022 13:30:00 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::a4) by DS7PR03CA0240.outlook.office365.com
 (2603:10b6:5:3ba::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Wed, 30 Mar 2022 13:30:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Wed, 30 Mar 2022 13:29:59 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 30 Mar
 2022 08:29:58 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix unique_id references for Sienna Cichlid
Date: Wed, 30 Mar 2022 09:29:48 -0400
Message-ID: <20220330132948.1332199-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff6f5ce4-7f40-4541-fa5e-08da1251638d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1759:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1759D96A61E0CF0C36380463851F9@MWHPR12MB1759.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0XfImVSpsGdXmetahRYkcUs7nExwTxZb6cOcevDPR6RZk4tErgUVTEg42aHmNplbygza1gVcfKOs6KV0guEvFb5Dviy/SfJXcGpAiPPs/EsSD0DwAfxP5eqYLYT+VN2boO/sQQCCCTspYaIq+zX0Gy5jtfthu8Vj9PS9PGlYXFrykDh9ZDQKbyQZLf9iY0wyV1CoxocdvSiL2Q+LyHO6dxu+JCJQwqI8HjltvEslgsl7nzu2dkiSQL+TY5fGKKajKK9mGUey6wrcTr7esZ5lHP2beqDqWsVfKgIA3kWEkfSbq+OV9hoAdxu+CwR+/xwyOLk97FAE3ev848TaBpPqntDsCyzqAjtfT1QvujZCiMWv79ASCLmyOv1FKY37YIB4qbHASBP5i4IK78AvvaGP1l+OEj7vWkdocRS4k960ZpaYP2/yUBPORzs06mRYyUHwKWaSCDbK6IjMaLY3fqRf6Y0cyS9/ujweC8UF1WWDNu7/LhfP8T4kC8pKPhIsK0XrrX+z1UNUnep1OkSZ8tIIysfGPvtCrJ7AMOVeftqu3p3KhguFTFfYaXSgwaWRCS9fFNZi83VFwR5PBV7ErKLb46r+k7sAienS2eFOm1PyTRyN19lb62DbPYtiUGrnoen8+FHEsspC6r3t/rFcZ7xymmOft5IgmK5nBZr2/XK8koi6GPdLvcRdKm0QX3r83uUHTfD/NngDsRAC1jHeBSs+mA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(6916009)(36860700001)(2616005)(47076005)(44832011)(426003)(336012)(508600001)(82310400004)(26005)(186003)(8936002)(16526019)(1076003)(5660300002)(81166007)(36756003)(86362001)(356005)(83380400001)(40460700003)(6666004)(2906002)(4326008)(70586007)(7696005)(70206006)(316002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 13:29:59.7152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6f5ce4-7f40-4541-fa5e-08da1251638d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1759
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
Cc: Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since unique_id is only supported in PMFW 0x3A5300 and higher, we will
only be able to use it inside Smu_Metrics_V3_t, which requires PMFW
0x3A4900 and higher. Remove the unique_id/serial_number references from
the v1 and v2 tables to avoid any confusion, and return 0 if metrics_v1
or metrics_v2 are used to try to get the unique_id/serial_number.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 .../swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h |  6 ------
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 10 ++++------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
index 5831145646e6..08f0bb2af5d2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
@@ -1420,9 +1420,6 @@ typedef struct {
   uint8_t  PcieWidth              ;
   uint16_t AverageGfxclkFrequencyTarget;
 
-  uint32_t PublicSerialNumLower32;
-  uint32_t PublicSerialNumUpper32;
-
   uint16_t Padding16_2;
 } SmuMetrics_t;
 
@@ -1480,9 +1477,6 @@ typedef struct {
   uint8_t  PcieWidth              ;
   uint16_t AverageGfxclkFrequencyTarget;
 
-  uint32_t PublicSerialNumLower32;
-  uint32_t PublicSerialNumUpper32;
-
   uint16_t Padding16_2;
 } SmuMetrics_V2_t;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index b2f3d80e5945..ab3e9d8b831e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -716,14 +716,12 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 			use_metrics_v2 ? metrics_v2->CurrFanSpeed : metrics->CurrFanSpeed;
 		break;
 	case METRICS_UNIQUE_ID_UPPER32:
-		*value = use_metrics_v3 ? metrics_v3->PublicSerialNumUpper32 :
-			use_metrics_v2 ? metrics_v2->PublicSerialNumUpper32 :
-			metrics->PublicSerialNumUpper32;
+		/* Only supported in 0x3A5300+, metrics_v3 requires 0x3A4900+ */
+		*value = use_metrics_v3 ? metrics_v3->PublicSerialNumUpper32 : 0;
 		break;
 	case METRICS_UNIQUE_ID_LOWER32:
-		*value = use_metrics_v3 ? metrics_v3->PublicSerialNumLower32 :
-			use_metrics_v2 ? metrics_v2->PublicSerialNumLower32 :
-			metrics->PublicSerialNumLower32;
+		/* Only supported in 0x3A5300+, metrics_v3 requires 0x3A4900+ */
+		*value = use_metrics_v3 ? metrics_v3->PublicSerialNumLower32 : 0;
 		break;
 	default:
 		*value = UINT_MAX;
-- 
2.25.1

