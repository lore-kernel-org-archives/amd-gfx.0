Return-Path: <SRS0=b4Qt=JW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FF3C433ED
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Apr 2021 07:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD6861404
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Apr 2021 07:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD6861404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B48716E0C6;
	Sun, 25 Apr 2021 07:10:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6DAB6E0C6
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Apr 2021 07:10:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDec/Fj8PcRioEU5RFxmO4sH+o0P6mHsIF1TP9+ZejuHmTmvrqMG5X986JQw8zpME09doq/u9vuQilUhZ8dpoKQjqyg9FcGD43/KYkgygPYtpb//fxfIsxf8pGV/RMN2KDCD3Jmqm/2E563pKx/3XTf5SvU6SC0G1hhEZzjnicL3ghQJPW44XgSwiKbH160G22e1WSB51gKixzKcsaCRRKiSx8XBAcS6Oo9dyJQmq9WMRE6j12lpgN20s3IUeDhp3V7rkzTmU3LKnBpA5zYTn00ZoX7GmcRhDqFBVoTR/NbrNoATKP5KiokQRG2YRoOPPEw2u+RwxSky/OSoVmTGWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Mj9Cec1gDD8e0y7SZSiCgzJTItYtCcgThAm+iwgGUA=;
 b=fhwzXRc/nGu0fu4LEaRdeSDAa6ncI9vNI3FhzmmxlxZ9ABF6FLG75FJibxQEIxkLrFlgZBkE7PD5XLxsR6ixtzLt2C8HQ0LMxSdQqGNui5LJrGHAD+aT843wAEe3/C2LDBnRSU0HmG7Av26AP1y+mxPXsgfOZTCHfRyOAmVLZTMr7KKrkCk0FnqlsNI4PGEb3PWFJBbC+tmsICWQKFxZ4pq332Y4Mxat83rjU7gaoncAdZGZEU3llGiKAr8FYOpTkrNqRuZHZItb/Cjds2Znp31b/LNmRTUapQM1wDmxl3S7bjdyMwulQD6VfZVy/Jp1vHt4zSYfb3EmRPL0t9cVHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Mj9Cec1gDD8e0y7SZSiCgzJTItYtCcgThAm+iwgGUA=;
 b=k/eItxMsRRt55abHUsmYr3mFFXeyf0wIRMl0Jnr1xbWRKcuc++w4AebMtDRQJiRHVgM1AxjnJ5aTza7VG7CUoY++HzLGiCZ2TWKhxjaXVZkM8hkxWSkmk6nehxK/gaBRSttf3jpHlAaxbzIWG9bGgJl1l3vyg/TuNnIZ9SRifSY=
Received: from DS7PR03CA0071.namprd03.prod.outlook.com (2603:10b6:5:3bb::16)
 by CH2PR12MB3685.namprd12.prod.outlook.com (2603:10b6:610:2d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Sun, 25 Apr
 2021 07:10:08 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::19) by DS7PR03CA0071.outlook.office365.com
 (2603:10b6:5:3bb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22 via Frontend
 Transport; Sun, 25 Apr 2021 07:10:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Sun, 25 Apr 2021 07:10:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 25 Apr
 2021 02:10:07 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Sun, 25 Apr 2021 02:10:06 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Dennis Li <Dennis.Li@amd.com>, "John
 Clements" <John.Clements@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: remove unnecessary header include
Date: Sun, 25 Apr 2021 15:10:03 +0800
Message-ID: <1619334603-8305-1-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5bc47bc-f035-48ad-fa0b-08d907b928b9
X-MS-TrafficTypeDiagnostic: CH2PR12MB3685:
X-Microsoft-Antispam-PRVS: <CH2PR12MB368583F778461BD08079B436FC439@CH2PR12MB3685.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KIfFWXdHorHFi29mnYXg93013OZJ10WOQIZCkZ9UANL41iqAgOF461Lun/fJWlRJNcpNuLNQsEl7oXdGYoYdk0Qn7aHkT5djwB8RcXMdDIkoHIaH7vADdjW1f6cURodVcsQytVoj2sVCFt7ViTHg2Y9jNIM9ttN1gTGWcrXGmCtzwqouor2LPo9dbkg3siTyCtW/Jg9DHAccE3Qd+iQwIDdp9DXxWxmExZsVot3oc4TPZZEEK1HJ5fQ/YVSbsTiIndnFQwC2BHWsxyaBSQ+WxnY8dcqxicjMGp/zkY0z6mdzcnFJ+PsTfeQHPb2gClnlQuceYL6/XPU8gQi/gnfqcJ9WzQcA9kMnFKvSc4yI15PSaqQ6oCmJ3YSjGa1/7VleUd72ZfhV/Q8zR5s0uDzG8oL/I2AatQCPjLwqtQc1s+YLZreg97rVmx6g1m7OBF9jdiFSAPf75Sc/yeS5wTUowQe3YvDYC1bVXI/stnjeISvR1S9BVre0WttqWU86aYr8NnQGiNxCeimSVj9JuCUFpiPax6mk3bHs3s3U9J2D+SNyy+hycbjes7X82Udywg4WuuhDtcu0iBZ2Zx+yvrzY+C7riIr+RgHGrs2yY6gYASLKh2O6FyOdBOLw1gz55lIsbukqIg2oiKjZ03TQ6BaidmTTmL7aa39c/2lROXi7QaSBIrp288x3NQzSEafgUCnL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(46966006)(36840700001)(26005)(36860700001)(356005)(478600001)(83380400001)(186003)(5660300002)(6666004)(110136005)(36756003)(4744005)(82310400003)(8676002)(47076005)(7696005)(82740400003)(4326008)(2616005)(336012)(426003)(86362001)(6636002)(70206006)(316002)(2906002)(70586007)(8936002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2021 07:10:08.2287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5bc47bc-f035-48ad-fa0b-08d907b928b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3685
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu.h is included in kfd_priv.h

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 696944f..97c36e3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -25,7 +25,6 @@
 #include "soc15_int.h"
 #include "kfd_device_queue_manager.h"
 #include "kfd_smi_events.h"
-#include "amdgpu.h"
 
 enum SQ_INTERRUPT_WORD_ENCODING {
 	SQ_INTERRUPT_WORD_ENCODING_AUTO = 0x0,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
