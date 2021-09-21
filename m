Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33A5C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B09A960527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B09A960527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2837D6EAA0;
	Tue, 21 Sep 2021 18:08:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76A4B6EA82
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UL8QkhZbkFvE/7do1ZkxneiEc7e3WvuouUUKDiY1Jbqf7Km5UnSxSCxiBN3MRfqkoZeoVrz7qFPu9jx1SIRaSfXptmf4P8EchwNo8rE9qN4e8yOLYNJ3Z9OCNP3yBZAGaQhpxoooX1y9A9sd2DeY+MLcAdwp+m97S3czBWFg/TGBaE36TPQafB0V5CmmN2JwcI9qxHvMqov1DluspjfHB9mHMNu+bY9gmXgdlryOMVekfFv2Z7E9GbXEl4kJiqd1egiWCdnta75uyUYXnNRrVw+6877LJzIrUfXyWkTDOpafYLJwtBvM1Bhn9d/Np6x0fZP+iG9S8xBPR9JmMqlxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Iu7iGoOq423jV0aZwI7Ee09GLry12Ghk1xsj0LoER+4=;
 b=fZNeWYQUDcyRLqE655+s7y2vKLwxotizG5GHCZsX2EoEa9gQXu50UfiM132QtV0dVlGRhD0Dz1hNrCoGhZG2yzjH7yX/wlM47MUP9lV4CEZ4kdnAtqJDaE1ckkV5WuNPsy2hXln9WWLAFkOp0JvVoVU/X8ZM9NFraVrIdgZ716U9mlQ3seb4GDNPHT5bhCYGKar7mYe1Nt6/FA59eoX6Hq602F+abOUb7dqnFrCjwe+uFAu7SFuT4Gd+DGe8Rao//vmrMpTJYv8a6wGxKrPzt9Wqj9sOQUk1rqeoi7EXvmhG14XapI7UogXFUQzeF26tKYVO5cEFQNAg4hhOQdCW+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iu7iGoOq423jV0aZwI7Ee09GLry12Ghk1xsj0LoER+4=;
 b=GGROs+SPjXFBdVkiXgDuPePebsQoysR23IuEBL+J7NKOU0Qn0ZkJaVmhP0fczRmtnoypZTHE2fCKypP7JozpWSWvyT6DgymHXC0JjqhXpM+a0fosO14mGzumxuX76Y2ichT8NUnUrJWERIoRLpHBkXyXNbU23Qp9eooGX33T3pY=
Received: from DM6PR03CA0100.namprd03.prod.outlook.com (2603:10b6:5:333::33)
 by CY4PR1201MB0053.namprd12.prod.outlook.com (2603:10b6:910:23::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 18:07:54 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::7e) by DM6PR03CA0100.outlook.office365.com
 (2603:10b6:5:333::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 27/66] drm/amdgpu: drive all navi asics from the IP discovery
 table
Date: Tue, 21 Sep 2021 14:06:46 -0400
Message-ID: <20210921180725.1985552-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 209c207a-2bb1-4e4e-5892-08d97d2abc1b
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0053:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB005314C2C394A10AFCBA87ACF7A19@CY4PR1201MB0053.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZMc+1Q7uiiR/Pi9/4FdbeBk+bhWpWWBSz2NpZ70mRi3f/1l4NyhNTUh/wWeXGKxFHoMW2BnWo7tLMZm8T/fUvy1AEPDYIBPle6MFt42u6gtIctDk78+u6gUYsueVch4dvufnNgnrB5S67xDs735ErBmNSnu0AS03OGyoEiEwC6i78iElnWf7JDhkHrK63i7d4nX88c7akBNauwgnxZBpt4fTYvu5NiS1Pzyyq/yHRadfdr5z1iDSlYbFB/kn6vAAKOXcxWwzMNZlX9j0Doq6DxwXGjHxobEySyHzfAWC/4lGRqDH3s7BD/3QMY1PbjTf2++C6AGIIPm2xHZb/WYdvDLSnAHQZsAg6yFNSE4SLMm7g7uc9N6bN53JGbe+Em8u5+kBAIVP+abPmBeUbO/jl/m76Lv015O0GeCb4eIxm4rUQPXSZvOpsgDFrpwk8GijEWnbK8Nb4KDy8JTRtPhSlettA5vbSJGqYlkkL87EY7C6X3Tv3hfd/U3niBzLcpclW6liJ84skfvyjxaPP0PiRPiNKl08elzJF3ZkYxIn5sqYE6hhfMHqDGz/k4yzvKxCQJy+R3rAxQyCCvYHrBdK+SIHotAsiaY+szNFe+xDvfotsMeK2hzI7Q12T5xhbjLz/OAxALmgk7zQjXHsK5+9hp5iYrnfxmBbwInqRsGlI4QKN994B7pcHBxG3Lde42nDRg6XGNKp0nhPm/1HEIi/6H1HTdcdpVY/wXt1cpXgmy0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2906002)(426003)(5660300002)(82310400003)(81166007)(316002)(70586007)(186003)(36756003)(7696005)(2616005)(356005)(70206006)(6916009)(36860700001)(6666004)(4326008)(86362001)(47076005)(83380400001)(8676002)(16526019)(508600001)(26005)(336012)(1076003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:54.6843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 209c207a-2bb1-4e4e-5892-08d97d2abc1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0053
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

Rather than hardcoding based on asic_type, use the IP
discovery table to configure the driver.

v2: rebase

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a4503e006fb3..2bf18bc30f69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2142,26 +2142,6 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 		break;
-	case  CHIP_NAVI14:
-	case  CHIP_NAVI12:
-	case  CHIP_SIENNA_CICHLID:
-	case  CHIP_NAVY_FLOUNDER:
-	case  CHIP_DIMGREY_CAVEFISH:
-	case  CHIP_BEIGE_GOBY:
-	case CHIP_VANGOGH:
-	case CHIP_YELLOW_CARP:
-	case CHIP_CYAN_SKILLFISH:
-		if (adev->asic_type == CHIP_VANGOGH)
-			adev->family = AMDGPU_FAMILY_VGH;
-		else if (adev->asic_type == CHIP_YELLOW_CARP)
-			adev->family = AMDGPU_FAMILY_YC;
-		else
-			adev->family = AMDGPU_FAMILY_NV;
-
-		r = nv_set_ip_blocks(adev);
-		if (r)
-			return r;
-		break;
 	default:
 		r = amdgpu_discovery_set_ip_blocks(adev);
 		if (r)
-- 
2.31.1

