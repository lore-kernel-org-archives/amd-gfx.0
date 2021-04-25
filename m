Return-Path: <SRS0=b4Qt=JW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13255C433B4
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Apr 2021 07:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF7E2613C2
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Apr 2021 07:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF7E2613C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8784F6E0E9;
	Sun, 25 Apr 2021 07:10:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F3936E0E9
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Apr 2021 07:10:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rzbs/II7x/VPyZsdWZss8nhCYCmn5c+yTq4s3Tfxe77LxUTcduMYSr0yYyc5dg+Hvkuzg7a6m9yxtkgNaOlY0rEu9QhpYqNnz3zgGL/fww4DVo0RHSxnhfUrGqYURAIC82QD47jmWvTSJdMFJiAb6RbaFLGoCwLGGugn0vGMci8TMHbk0Plr7mIB86ko6Ppj5SPwxd80htj6TXRRIHg6pZOHZXmGic6DBiwKZ3y32pE7iUSZc5mWo/v6dmT+tVohrmqBe3jmDO9uq7FiW1ZXb+BMW2W6Cg9b/xpdox+/HQsP2HoyLsNGu/vMTtqZVRmFHp0PVhISN6/hEaMDEBBCdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cj3GWWnU5UL4Zoz8KhxI7Of58h97jj2sPi5W8FaG97o=;
 b=HtnKW94BN/oyGaxQVmZMeEO2qYUQgX5VTvjhqEFKyoRuMzEXhUwNV2Q9623q9H7VZlGpAE+v+jrEymyEByHnHCbGu4mVBVZskmb3uQ3coi6MrBqtMLLc8TQ3KxkVwi9Fhzwa+8A14aqLOfl4+UBM5YirUjzP/0yJtrI7Juay72dcDWiBfMioTJCuFR4FjDKe9V34K/2pnVT9ba0B7HnKQQ9aVlQrXLYdwfbzFP9lof9N4ETYCW2K3qKY1fArC60diVpXDENkw/mEdA3xAMLcbdlPGOonkZB05LLxz1mHjC5tAiD2OSKgkoMiZl5xTSmH9c6D6fT+XtChJOZz5b4yVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cj3GWWnU5UL4Zoz8KhxI7Of58h97jj2sPi5W8FaG97o=;
 b=MvD+l6JTvlTvJ5bxsvkUa9iL3M9/+gDlRAHS9QWvAPbxQnLvqlLDb/oAZ0yF0vS8lYlDRZiKfIS12Wgl6roAVM86w6bpLozZ6mcjT7BAWl5B5o6kcmIwaXP7SX1usIjlKQuCC1v2hJlggx36ZtAxiMMRjNHjQWAGWz4+ulHRO68=
Received: from DM5PR17CA0071.namprd17.prod.outlook.com (2603:10b6:3:13f::33)
 by DM5PR1201MB0139.namprd12.prod.outlook.com (2603:10b6:4:4e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Sun, 25 Apr
 2021 07:10:27 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::53) by DM5PR17CA0071.outlook.office365.com
 (2603:10b6:3:13f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Sun, 25 Apr 2021 07:10:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Sun, 25 Apr 2021 07:10:27 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 25 Apr
 2021 02:10:26 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Sun, 25 Apr 2021 02:10:24 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Dennis Li <Dennis.Li@amd.com>, "John
 Clements" <John.Clements@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: provide socket/die id info in RAS message
Date: Sun, 25 Apr 2021 15:10:22 +0800
Message-ID: <1619334622-17940-1-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8561dddc-4cf6-4ace-aca2-08d907b93424
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0139:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB013932685659952FB88C3A46FC439@DM5PR1201MB0139.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:116;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iDA9wIrjXhdeyuFZs0YuF3QZBbBa4uO+wxxihXa3CwqAtdkrMqiEeTmeJe78FJ0Bh0IdkphR8UvlvnIXrfzBzNUoWVXgokY8LY+ItquXH4C8hIXn5hUd+S9cmNrdQkDEdYPQX6RmL0TzxlXbZwrN/kUpeumBSkiznLfpmly0LQ37WrjtvhQkecn1kgejQA3LrmlkzTV7Jnd7GsSGF/aZYiN39nGMItCHmRV5szwmayc7CFn5SrDAVW3ofq6tYknF2IsCk2PsaUEm36tIzaxfUW/6N+dUVUAdXD6fftmQlTCvq/plpxL9BeEsTD9Xrh/vq2NlNH0Zk9YL6316+Uigr3HFtcHKqDh023qCENDEQYKazg4y81ULQ51VR+9/Rpuh6j1qfjqhGAW00pk298nzgkCnGm62EDln5KNP04HG7yYRsEs7tgsLesfwL0YMdCvHp6ICsQapeeh8g0F8Owg//6KHQoDjvCiDkG8THEfWCqpVzfjuRZ8O6ffy9+rTgqVW0kkvmaOAyq7rzs0cHyW8G3mCXiNQTZt9AIva37We/cwDbo53vwLDO0KwfX9eCSxe1iqgCjvRBXH0MKb867JB1zdcy50bT44uV0V+K+13GKZTmbFj0NImroh0tIYQUnm0iPTLvTgQxLz1ilP5ROBIu78L5NCMTKvPJdLi9wLLYw/qvGyHBXuV89ktbNBFr59f
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(46966006)(36840700001)(336012)(426003)(8676002)(4326008)(478600001)(2616005)(70586007)(70206006)(8936002)(5660300002)(26005)(36756003)(15650500001)(186003)(6636002)(2906002)(81166007)(83380400001)(86362001)(110136005)(356005)(82310400003)(316002)(82740400003)(7696005)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2021 07:10:27.3819 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8561dddc-4cf6-4ace-aca2-08d907b93424
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0139
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

Add socket/die information in RAS messages for platforms
that support query those information

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index f62873f..ae9fb20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -901,17 +901,42 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 	info->ce_count = obj->err_data.ce_count;
 
 	if (err_data.ce_count) {
-		dev_info(adev->dev, "%ld correctable hardware errors "
+		if (adev->smuio.funcs &&
+		    adev->smuio.funcs->get_socket_id &&
+		    adev->smuio.funcs->get_die_id) {
+			dev_info(adev->dev, "socket: %d, die: %d "
+					"%ld correctable hardware errors "
 					"detected in %s block, no user "
 					"action is needed.\n",
+					adev->smuio.funcs->get_socket_id(adev),
+					adev->smuio.funcs->get_die_id(adev),
 					obj->err_data.ce_count,
 					ras_block_str(info->head.block));
+		} else {
+			dev_info(adev->dev, "%ld correctable hardware errors "
+					"detected in %s block, no user "
+					"action is needed.\n",
+					obj->err_data.ce_count,
+					ras_block_str(info->head.block));
+		}
 	}
 	if (err_data.ue_count) {
-		dev_info(adev->dev, "%ld uncorrectable hardware errors "
+		if (adev->smuio.funcs &&
+		    adev->smuio.funcs->get_socket_id &&
+		    adev->smuio.funcs->get_die_id) {
+			dev_info(adev->dev, "socket: %d, die: %d "
+					"%ld uncorrectable hardware errors "
 					"detected in %s block\n",
+					adev->smuio.funcs->get_socket_id(adev),
+					adev->smuio.funcs->get_die_id(adev),
 					obj->err_data.ue_count,
 					ras_block_str(info->head.block));
+		} else {
+			dev_info(adev->dev, "%ld uncorrectable hardware errors "
+					"detected in %s block\n",
+					obj->err_data.ue_count,
+					ras_block_str(info->head.block));
+		}
 	}
 
 	return 0;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
