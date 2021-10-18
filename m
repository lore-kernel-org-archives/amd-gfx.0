Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD0FC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 10:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D901F61002
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 10:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D901F61002
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27CAB6E9D7;
	Mon, 18 Oct 2021 10:50:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47E3C6E9D6
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 10:50:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsRk2Xd0ZZZbNWZI/rkeb/LqScV6h2pXWZz8LsXO8r3sxIdbvML00a1CTmJ+x1AcFZJSViWL6wIBAq//Q0VnC7/pzqfbpxkn6AaVYAFxmAQ0apDg8YB85HEfkcdt/4wr24+dP+E53VYs8njgXHKEvQwu7/Uoazq3cZLr8WKNazA9SZXcg+BFeOjnyQQhbgPHBWznUbb6orhZAUkbedaez07Pim00uBw/j19bO9ozMYrjR9lverw2Akp7Gc13WuYqWcyl8pbsS5GHVfdrN30hLFpjj80l6odIetFQmahKSIfIXqXu8qP/09kyXXeje0MtSIhacoQwnzIBTRvRfuunaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWqeKUq8og7HOsFToP5NnlH789BQfqNgIulNjFDgjVE=;
 b=W99sG2tMoV5ccrNyabbL2w5UIrIKAHzm/n+6o56LKbJ536AIGS+ribuTJZfCCvdgtL6YqLzm+reS8cnb61oppefSjPduSeOCYQucwkQbQBaJX1vO0q7yJ6cDJHV0qg9UkZi+1Mk4AftpLmsNl9K0a/xlwfMrqx/zz+nDu3duaeDFL3/gU99773sCAc3WV5HRswmBr8eOrp7sCeGmpvmEFK3c45AxWDnVIIuLAi26gOPYcxXEcE4++PVho83r0tvztsWjnF0vk+1UrRGHfw6RlQzDst7j+UNADFhDXYZLHpPi1yo0dM7vcnBlxDkaB1agyAyCtjIatMSW3Kc2x1dLYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWqeKUq8og7HOsFToP5NnlH789BQfqNgIulNjFDgjVE=;
 b=lCNSNV0nWM39PJEZz6gic6VoPyZV0ZNxyc0fK4gIu9C8+8blT4plNnzrz8Qn5vekdGhRD1W10jVaojRbTys3m+5kszFzbvCefxRty6pX8WhUO1rTxrEzZI435lB6sWWzOXd70c3EjxnJfmSVGmvU6A8FRU5bx0DvOhWBTMyfFUI=
Received: from DM5PR07CA0149.namprd07.prod.outlook.com (2603:10b6:3:ee::15) by
 BYAPR12MB4774.namprd12.prod.outlook.com (2603:10b6:a03:10b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Mon, 18 Oct
 2021 10:50:03 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::41) by DM5PR07CA0149.outlook.office365.com
 (2603:10b6:3:ee::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Mon, 18 Oct 2021 10:50:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 10:50:03 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 18 Oct
 2021 05:50:00 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <john.clements@amd.com>, <stanley.yang@amd.com>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: output warning for unsupported ras error
 inject (v2)
Date: Mon, 18 Oct 2021 18:49:49 +0800
Message-ID: <20211018104949.17814-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211018104949.17814-1-tao.zhou1@amd.com>
References: <20211018104949.17814-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4695c532-82ff-426d-8013-08d992250a5c
X-MS-TrafficTypeDiagnostic: BYAPR12MB4774:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4774572AEFD8C21A6D34B188B0BC9@BYAPR12MB4774.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVb/wiCudc88YEXDEWOupsR1bbVT8AgLfShSqjcNjoEsw8MM7ryeLsElsVsSXWacXu00JAjbYttTJgcrUU4Hlew08b+dQMmbSPHk49XRjLmeVweXQLcUxF/+60KKt7vhxPPld/cuvivoPP0SWSTwjbmbM0GimOM8c1LtsDCcEYPkvrFj2ZwG5m2EHMBkgEWrGY1MsNACQZm+21XzpewpbYV1iyKYatcNS2O+hC4TQYez8aQFmPMmP7HHdkfPMIFFinq88cfmd1Kqsp+T/j/LImdEdYG/ovciZZITAQF50mFpCrzANeyYSs319u1Tju9NkBdAwjTDnPR4UPtjrHp6W8B31YB7BM8RIvx82LWJDhJN0J9x6BsLkdG3PofGkulf7ng1RdUPD/kH2kTnJ95TKSNWrbKKVDd2fy8Nvh7ULCAN9IEu3ARX5+kiEQsVM9QNfQICsqXU1YxVgyFnjm27DLSz6l42mphj8C6rjvU85wTARZ6X+kJ0Y+XXesGdUw6PfKt/wx+3W95MholDVCSVY6cuvrucORm8NIMj7lgKjWbXk8UBKM6G1ezdckUczcDuo2XujjERvAFe5WdFQnu09wGM+8RXFg8LAAdxG/2Y3KbSiJZsew/W7xplNpp2z/IzF1Pu3lF+GvuY9ILW5eT2J2GX5ZyNYncp+zMO8vVTXHFodkvsLRhYK7SPKOJGtAHiUTJtxKdykQjSJ3nzszxyvyVhvGY9kDFYEWwyIQY7sOE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2616005)(426003)(336012)(16526019)(2906002)(83380400001)(1076003)(8676002)(8936002)(186003)(86362001)(47076005)(4326008)(26005)(7696005)(356005)(36756003)(82310400003)(508600001)(6636002)(81166007)(110136005)(316002)(6666004)(5660300002)(70586007)(36860700001)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 10:50:03.4121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4695c532-82ff-426d-8013-08d992250a5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4774
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Output a warning message if RAS TA returns UNSUPPORTED_ERROR_INJ status.

v2: implement it in psp_ras_ta_check_status function.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/ta_ras_if.h  | 7 ++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index bcf95982f6fa..fd04e83031d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1302,6 +1302,10 @@ static void psp_ras_ta_check_status(struct psp_context *psp)
 		dev_warn(psp->adev->dev,
 				"RAS WARNING: cmd failed due to unsupported ip\n");
 		break;
+	case TA_RAS_STATUS__ERROR_UNSUPPORTED_ERROR_INJ:
+		dev_warn(psp->adev->dev,
+				"RAS WARNING: cmd failed due to unsupported error injection\n");
+		break;
 	case TA_RAS_STATUS__SUCCESS:
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
index de24a0a97d5e..5093826a43d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
@@ -59,7 +59,12 @@ enum ta_ras_status {
 	TA_RAS_STATUS__ERROR_SYS_DRV_REG_ACCESS         = 0xA011,
 	TA_RAS_STATUS__ERROR_RAS_READ_WRITE             = 0xA012,
 	TA_RAS_STATUS__ERROR_NULL_PTR                   = 0xA013,
-	TA_RAS_STATUS__ERROR_UNSUPPORTED_IP             = 0xA014
+	TA_RAS_STATUS__ERROR_UNSUPPORTED_IP             = 0xA014,
+	TA_RAS_STATUS__ERROR_PCS_STATE_QUIET            = 0xA015,
+	TA_RAS_STATUS__ERROR_PCS_STATE_ERROR            = 0xA016,
+	TA_RAS_STATUS__ERROR_PCS_STATE_HANG             = 0xA017,
+	TA_RAS_STATUS__ERROR_PCS_STATE_UNKNOWN          = 0xA018,
+	TA_RAS_STATUS__ERROR_UNSUPPORTED_ERROR_INJ      = 0xA019
 };
 
 enum ta_ras_block {
-- 
2.17.1

