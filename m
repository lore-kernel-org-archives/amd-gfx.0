Return-Path: <SRS0=770C=P7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E8EC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 15:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63BB960F41
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 15:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 63BB960F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E90306EE6C;
	Fri, 12 Nov 2021 15:56:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E7C66EE6D
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 15:56:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYj9Lhv3BGgjPCR9GvUL+6x8lUOqmKDCLqcT+jcuSAqdS0UidM2WXNmf2tHf8O2K3RJneBNYk5HhR9B2hiVHttYeUtOf1Dkk72ToLGMG5Fc65aLYFvg1/POL3Sq8PGufgFg0KLeuxl7fuKi08X3jIPGh/ky/8nQAu6yuqfI9WGAQvbOhMx8ulCW0RR7ROjmisf+Wfnl+DkNw3ALFP1/wN6iwiEkiTPYvvD9GkBN4n0RS/Mqh9ff204RlCnu9NGyug7nKkqGq6yqXsMLT5+JksEQLGEUsTn40PcxEljybE5iF/eX+S6HUxjDWB0lQa03jdyvktJYGh2zuvTvHfQc+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsstFUhnm482ygFLYOVCNGlkkzDZScQQZUDGgpppRd8=;
 b=kpzvM+11I8rKGNzv7sHbW18fQhXw4GP+Ax4hgcZcKriGxQgFzPB32TWXD1YflaNdmut2MKW2auVESHcEjqZpC+y4A+RqREsYWJ355psCdDfvG2IVQpx+7ENElVrZzISSHDmchWsomTC959V9rBcMds6HFkQDWXhh05Zh0otu4maApaUEV7M9eFfcmIRDCWI9uOyB0K63X/++zzi0Wnfee69mzs+FU3Nb7TdUF26DZgJIl6ly2ScnDutdFCRHi2pGkVDkbp7+o78Orq8sxJp+2h58JsdLLCEJyKcVOMV2PqUlfhp5YHetIBA7oQ4Q/v6qI8/k87t2tWgSoVQVYIguAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsstFUhnm482ygFLYOVCNGlkkzDZScQQZUDGgpppRd8=;
 b=K6futCOGN5SeJ2/DNijK2dHFB6QkLC8gV4IL/m7NClPJi+xmVsq/7Rz1eFzV/brmi1XNMF/CChGA9cKKdCZ974DS4Z+fcE1hNYMU9103qZ6zXg8YdQsaZkXaXi31re3Mv3Mtdg8XVDCvKXch5lRxryR8XA4riZUod+0oDkvE3qk=
Received: from MWHPR14CA0051.namprd14.prod.outlook.com (2603:10b6:300:81::13)
 by MWHPR12MB1136.namprd12.prod.outlook.com (2603:10b6:300:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.18; Fri, 12 Nov
 2021 15:56:28 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::40) by MWHPR14CA0051.outlook.office365.com
 (2603:10b6:300:81::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Fri, 12 Nov 2021 15:56:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 15:56:27 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 12 Nov
 2021 09:56:26 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 12 Nov
 2021 07:56:26 -0800
Received: from leo-VirtualBox.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 12 Nov 2021 09:56:25 -0600
From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>
To: <nicholas.kazlauskas@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Reduce dmesg error to a debug print
Date: Fri, 12 Nov 2021 10:56:18 -0500
Message-ID: <20211112155618.5674-1-hanghong.ma@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbe22090-9353-444e-09df-08d9a5f4fc70
X-MS-TrafficTypeDiagnostic: MWHPR12MB1136:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1136D9C1B3721E33BB4E695AF1959@MWHPR12MB1136.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:162;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ZHNI2EnCg3arEWez6kOy2Y+KMDYUcea/xX4EY/FhZfNVnvQMConKZXTtZg8fFeRR6SQVjVeIP9Cf/Gm8/qXrOKgR6VfvbxKfYbkqedbVneev5pMndu5bh0iRntsV0xsPoNf8I2Sa7fPFKc2p7bqcLe6iondril4W0mjBR74AxIVwvIEb/WGJ+xNMMAd3/o1efKHmg2ji7sC1a4QvBn9DeLYPUhddGKQDwoxz7dtGBHEX5n+zIy0BcD383JSs5BXU/cwZuaMLm+A3GXTdPKoH6XehAnmwMuZVZ7fziKEeUDdxMCYdywZmiKTXmdmh0X/8TQmBWR5y6jdMzpwcbuin8Uk7sOimxxx5jajLYB1O3jUTtPKUxkbTDb77hHsLiqSpcSfuAORajogthqhTgut21um2U7O84zD6IXIfcThYOrrmbdffdcvfZ4GKhTeQaQ5XK2eoNX51yLQQqMtjiUhQTPPxWb0Wjx4gmDZCXIsVDQOhLZtNKXa7ODQcSrMZcYHfYPvfoewPobhwaldFXMDe2I1PjHkdi8rdKbWf+mQjaYeprTh44Naq4I2lBtgB08CdP7Ni73HDm7Z34nTRFXXajKWEcp0FezalY19N4ZvIifpviOFOJstFSI08uBWA+lJd4E+CnkJUExDX1LolLBWIi1mxUVFZeasemqEPB7/Cj/bMyHLkVPP0jXdak9mhIszx4/sWbX5F5dFYgPzpSc7ofBM3qIaVl2pVGKvM69AQio=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(1076003)(82310400003)(2616005)(26005)(70586007)(4744005)(316002)(70206006)(336012)(508600001)(186003)(83380400001)(86362001)(8676002)(426003)(6666004)(4326008)(7696005)(36860700001)(2906002)(5660300002)(81166007)(36756003)(8936002)(47076005)(54906003)(110136005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 15:56:27.3890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe22090-9353-444e-09df-08d9a5f4fc70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1136
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
Cc: "Leo \(Hanghong\) Ma" <hanghong.ma@amd.com>, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why & How]
Dmesg errors are found on dcn3.1 during reset test, but it's not
a really failure. So reduce it to a debug print.

Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index cb7bf9148904..c7785e29b1c0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -4454,7 +4454,7 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
 				lttpr_dpcd_data,
 				sizeof(lttpr_dpcd_data));
 		if (status != DC_OK) {
-			dm_error("%s: Read LTTPR caps data failed.\n", __func__);
+			DC_LOG_DP2("%s: Read LTTPR caps data failed.\n", __func__);
 			return false;
 		}
 
-- 
2.17.1

