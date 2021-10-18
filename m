Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60C6C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 14:30:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8495B60F93
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 14:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8495B60F93
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 154E56EA4B;
	Mon, 18 Oct 2021 14:30:32 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 500DE6EA4B
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 14:30:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvSsgqI3NgLmfz+yvapcnyvDJqzmlX/ioW0Ma225th4zd4rB5TC+MVNlNDSWHp39zOUx2U8XMiPL0J+qyhNOn9ynlBor4dd14avVjfMF0ikiOC+2xJRMFyuU9joxAAEdZ7wTYTWxiPDOMns5EczFgQ+7rgWCuepoGvkqsVtVF/0BoX0okE27MGjFA+H/ygFbD0uPiV955lDDRMBuLYL4QPuhcICXm55d9FT+xhfTjQ9DSUjsDMsq6ywCGQz1I/2fKEJc9ADtcWIFY3sWA9+loNXF8FfPlAoQuJQ5CV2qRq0R32tMarGyy0b6EcsgoZuUc4E85IXd95vzowndWa2axw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jg0nnIQMybQjvcm6/NW6vhNds+Tg2uikaIKckGzlpAE=;
 b=ZcuCsZ7wAmJUkjvlDshakHRQlCuM/x7CLMnwcl3bDNKLmLzfz1/hegspHHDN68pOU52x7GZWutybqRUHgn/JuQORWq6ukfEeszwdHixB+jKBABO8SIa7ehCrtfLSUOJFAAPX4lsrJHbefLuosiQdPN2HJQUcMawITNCKQPIDI6Z3KzFpHUKnmcfnjuHxhcY9afTJvhm9GNwsI409qRLe8sd3Zbv2+8HFkWG/AE2G7U2HtTuTaEeQpcF39i66qkHYfTMtyA2HCzA/g4lTrm/BD2NeciSC0ZlNfo8GGN9epqaBfY7Vekh2fekxqU9SBPxPhQFd9JkW2cHxj4QXMNL2Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jg0nnIQMybQjvcm6/NW6vhNds+Tg2uikaIKckGzlpAE=;
 b=rg8QqGsBwLQ1iGe5MGxLBGalz4oZmTyK1diNI0uou1FZ66/uQF53IJ1R+Uyv0IVpYAl1sb/i0w09+q8Bi8rjQjCvKHFcCLx8SGxOw1rdecSbUO9hnC1bFpd3VG4bPE7xjPNkQDnj4+alAXqbEgV1i43yDHfmiS91Pk8S61soKm8=
Received: from BN9PR03CA0765.namprd03.prod.outlook.com (2603:10b6:408:13a::20)
 by BN9PR12MB5366.namprd12.prod.outlook.com (2603:10b6:408:103::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Mon, 18 Oct
 2021 14:30:29 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::5b) by BN9PR03CA0765.outlook.office365.com
 (2603:10b6:408:13a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Mon, 18 Oct 2021 14:30:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 14:30:29 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 18 Oct 2021 09:30:26 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>
CC: Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH] drm/amdgpu/discovery: parse hw_id_name for SDMA instance 2
 and 3
Date: Mon, 18 Oct 2021 22:30:14 +0800
Message-ID: <20211018143014.9474-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2885565-b623-49bb-bf7d-08d99243d5a7
X-MS-TrafficTypeDiagnostic: BN9PR12MB5366:
X-Microsoft-Antispam-PRVS: <BN9PR12MB536633B25ADD82ABC8D4B9ECF1BC9@BN9PR12MB5366.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7XGyrtf6HNCF2g0CXtal8eqKnOBDxxr8x23D+QdgipKRfzx7YzhzFJ4sqtgoS9J2BP73gEd3mJN3nVxwVxih0suRCU4yOm6J8+4babhTH9pDrUbG4zCIu+qNlMyp2zkPrtBw8znCSjFzlt4nEh4vHqOiF9gOLlY1y99YYNdTBdxvioxbORqXOXvRqxvDRJk4OvHWRVqU4/UbUdQjfn9+ZzW6quOvkpc8eiqwpsIxHK7rkrv/Qnr5ifXyZ1G9CmKSYp3WfQYt0NLKIBqDclow6lHp+jKwEJCdOMPoS7o60mD0WOk8P/FNMS3V+julcCwuqRtwrt7xpU8cmrmcqH0Wwi3YbfmMk/vatdLrc0wGU1/h5+aP9UK0ejMoKrTooDAhosnI3EeWD2vMp6V7UN9uEQqk+gctCPwVnI5BKwMC1wEFv6mI8bkZlbTzM3I9Pek7jILggdjmbwSeU8qJzK8AG917wy9yhr2G4Zsstrst1cwKBmB70lTgwnlvcMkvwbS6ogQksjWC0SqKgsrheNrpNhrhNWdz1UoE/Ot66CVQ5Kh2d/Qk6MnEQ3yBkR5NAI9FZah11JY/IUGRMgtZ2ZmMtRuooKJcLzRlWBehIBdx3TvmUK9w6y4ecS1lpT3nvdEM3xlvwMhwbanbJUBC8GGrzXaA9ucC9gsRllvOX3Yg7dvOBOu1GNgN4Ie6LPbnZWWJmf5S1y9PlJl92tEAorzyxbBVz/mmatXTBi23CGywarDl/zA3mke0qZ0Og2jCE2ug
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8936002)(508600001)(47076005)(5660300002)(356005)(426003)(4326008)(6636002)(2616005)(2906002)(70206006)(4744005)(1076003)(44832011)(82310400003)(36860700001)(7696005)(81166007)(316002)(70586007)(336012)(8676002)(186003)(110136005)(36756003)(26005)(6666004)(86362001)(16526019)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 14:30:29.3910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2885565-b623-49bb-bf7d-08d99243d5a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5366
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

Otherwise, hw_id_name string is NULL for SDMA 2 and 3 when dumping
ip version from VBIOS.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 9645b95b9c42..dfb92f229748 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -108,6 +108,8 @@ static const char *hw_id_names[HW_ID_MAX] = {
 	[HDP_HWID]		= "HDP",
 	[SDMA0_HWID]		= "SDMA0",
 	[SDMA1_HWID]		= "SDMA1",
+	[SDMA2_HWID]		= "SDMA2",
+	[SDMA3_HWID]		= "SDMA3",
 	[ISP_HWID]		= "ISP",
 	[DBGU_IO_HWID]		= "DBGU_IO",
 	[DF_HWID]		= "DF",
-- 
2.17.1

