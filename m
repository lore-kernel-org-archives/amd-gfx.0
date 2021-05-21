Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7232C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 02:58:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7781261244
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 02:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7781261244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F19A6E47B;
	Fri, 21 May 2021 02:58:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9E156E47B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 02:58:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csN4dVLkyon9eChnoxnFxNZ8eL5dfyVdZjNqbbdqjffGNL7vYox7iBfZPOrOLuO+79byPUgeJYdLycwze2Ao/cXguqBby2nwePcwyB3xJpse0ArKxxcKJ+96fD7p3XslOmW2EjaRBOjpe3KgPyrSB+kMMsmw9CS9BK3e9bjzM/RHFNuqNQNMjrbxEUWtKp31GbMwZbEjC8rceVa6l2j58d9gx2niHj2uGYgLiW+qRgLVfp6kbMC7jNQy44hnm8LsPLHTT1Ybc74B2AFsgKCNMhdNsqnX68b/A2D8bTvWYrGMnJ9hdHmA9VaghrdNIai+ciRPEfDodcrDkW1+M4VQjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYheJi7N3qfH4HC5qNVsBunc0YpRjbieX0ehDK+GUXk=;
 b=AQYB6esM25/IV47VujWYZb3LI/WT+Ss2BP7DOnK7a64OC48CPUw8WJZHEiNuFaT+d2XAn3XJmY18RNlz9ETPEqIeX0oBminWvDr8X+Q8JxobQ+a6V4V2J+9bj/lhMpF5lSX+NG+ZO22uEo2cszjgRgoozcvrHHD9Ek/qcvdhaBCaCZ7ZFtxXvQ3c35TcpO2KdJxDMb145fV6SzyEkXKbwkNudq88bzpYx3MNDz9qEna/8tDxUFIqs+Zk709pqgBybjuDp+p4hRlrKiVMjqB9OcAibScXrNa9muQZlcy8JtDAEd7UeBetPz7W6fBLG5bQY4Q4G1ATY06Q+wOpnkc/Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYheJi7N3qfH4HC5qNVsBunc0YpRjbieX0ehDK+GUXk=;
 b=US1tOFom0gtj6o31xeuinIgz/+Hl+0AGjPr6mJjepg34c/tj9Le1lDsFgdbXjebex+BXGcqT6TxWTMM6syL58VgT0P20105dh2XVw4TuMgqGVZhxze1HHbUqKY0FYZZ2wibPNR89sfpDLysR4hCSJfc90+14Q/bKHS1Ohh+z5Jo=
Received: from MW2PR16CA0035.namprd16.prod.outlook.com (2603:10b6:907::48) by
 BYAPR12MB3511.namprd12.prod.outlook.com (2603:10b6:a03:132::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Fri, 21 May
 2021 02:58:48 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::62) by MW2PR16CA0035.outlook.office365.com
 (2603:10b6:907::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Fri, 21 May 2021 02:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 21 May 2021 02:58:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 20 May
 2021 21:58:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 20 May
 2021 21:58:46 -0500
Received: from jack-code-machine.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 20 May 2021 21:58:45 -0500
From: Chengming Gui <Jack.Gui@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Correct reserved uint32_t number in
 beige_goby_PPTable
Date: Fri, 21 May 2021 10:58:40 +0800
Message-ID: <20210521025840.6203-1-Jack.Gui@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 794b34b8-9e86-42fd-98f6-08d91c045b10
X-MS-TrafficTypeDiagnostic: BYAPR12MB3511:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3511FC441A0A7C5D5F6EE6FA8B299@BYAPR12MB3511.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1PZYqNZVAaT0VFzqugAZSQoTQTxMbOSLSu0oUzU1dRHqpv/B/yDz7hrW10ko0bnFVSIc2eUrDRXRbZ0gTHvaxf5bW5RGngfmvmBKSLZ4aTfDAawyaRoU4WNifPDoYUFsOWd9eBoI5s8+jA0E1B4qFUfyvmkdaAU2EwpRr9Xt9tNYU5bxc93QpB6nteACk8dbLpTlDtuezVs3ddtO8noz8xwjyU5IgaJWy146Y3nXlFgXCs6pwZT50kU1NZ0izBFQ9S7Bk88wk6sQBNSGajuX0SqLBS+os1RqDPJQK3fy8w7uSLjV+EZRYhoptIFcLRGsB8f29L1eUgKv5zT5BWSD+y4nAdFfsnWi03rDkWDi7kqiJch8ThdsLzzkMZx0El0Id3qIm0CH3IdtzDadPRA/879Mi6ZCFTgg5z6vTMenyBgnnIJsAO7re7sjscfix6UFx7GQvbWkJxypefK0ITAB3RxsMEObReWu8tWF4gguSIknTKIDOrgh5JFs/tiufnO/c0RBoZwsI8EZUrkFlzcedjSSFCAjhLzN2cQZrAJKfyxlpQkIPEQ09XcpOC37iFLB3UXo8Blq86HcZvWmiafTb9Jhga63luFS6HhA0lGtJ6DUg0PSl5Ni//IrQ8rbaD/sTTDRyU6zQEv76n+U3Mpl3bRFpgE49S/Yw8O0YfvofxfT9IwEzznnVU5t1s1M6orq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(36840700001)(46966006)(356005)(1076003)(6666004)(81166007)(83380400001)(36860700001)(54906003)(70206006)(7696005)(2616005)(70586007)(4326008)(4744005)(82740400003)(426003)(5660300002)(36756003)(6916009)(316002)(336012)(26005)(478600001)(47076005)(82310400003)(8936002)(8676002)(2906002)(86362001)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 02:58:48.1268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 794b34b8-9e86-42fd-98f6-08d91c045b10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3511
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
Cc: Kenneth.Feng@amd.com, Tao.Zhou1@amd.com, Hawking.Zhang@amd.com,
 Jack.Gui@amd.com, Jiansong.Chen@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct reserved number according to the latest struct in drm-next

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Change-Id: I5991a8ef53134c00348a96f776a539bad6da4fa1
---
 drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
index a1079256d318..61c87c39be80 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
@@ -1176,7 +1176,7 @@ typedef struct {
   uint16_t         LedGpio;            //GeneriA GPIO flag used to control the radeon LEDs
   uint16_t         GfxPowerStagesGpio; //Genlk_vsync GPIO flag used to control gfx power stages 
 
-  uint32_t         SkuReserved[55];
+  uint32_t         SkuReserved[63];
 
 
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
