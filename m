Return-Path: <SRS0=7Ry8=JY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31897C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 10:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D38613C5
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 10:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D38613C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3651F6E06B;
	Tue, 27 Apr 2021 10:03:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83A736E06B
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Apr 2021 10:03:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3zysvqHOdzkkObE6gHiO93Dn9DYkmVpwFTxkIUWrzIIkC8A6ua8pTid76fDT9RcYpUnwcxcZ2qW89KFAgx2WwblShUMTt7h7ASt1nWjggwXw70trdUHKHQ8YQlUrFBURMn7ptgZDD/w3Cnc1G7NjEvcp4YR1C3r+nBau/CoaNcrtPy3cVFu4W6argIdUFUT1PgHIu1TFYVg68RmqEiW7biYW/mo1yYcihfM5J6A0oX+Gkw0n0kYVSlEb40cFQzjHaf0N1Sm7NmYtqkXQwLA+Mv/Xec2fYgMICtLLknwTdZ/5VuAfV7xuwe6aL/sf5qHnn/yk75ePOKgwJhAAfMRdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DtkTEMqprxObol80+b4fA9IvF8Cy7pIe0afL6UYgec=;
 b=iAHqC8gNhg/xpmJ7TS84TW5uXXbrnd0q8oA/9BbSgrGGcsjC0SueCDzEw+7lINkz+J2s+fohwPBUAM4gsWALfDBhUEyj0c2X4ztHXicKdaSzbbq5QOdHSxLpcAXC4V+y8bJE8EoTTwGRom5vA67NH5EqEwSi5CaC5u24qyv7CcNIo4IcM0Lj9PDVkmEAFVQGbf4pk+WKSmcgI36Ty2/DxAtSJKDBC+2qrnEBESWhsAvACPJd26PvQ7cF+Szcr5H1T0Np3tbdzkT7HLNOoahzVn+m0/LPLhc/J82B2RSt3qbvWcV9F9FXxzpxQGw2080HtuDwnlPvqoZlrrQ0xZ2diw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DtkTEMqprxObol80+b4fA9IvF8Cy7pIe0afL6UYgec=;
 b=Ca0V+qtu0YsXlNnsVx1/aj9KrJuEUepN+Ll9qdkpHleWkeYqgddfSSwj7PwcRV3Mc08caXpPSmDFUmnltr3fuf5o0aNVU4AmdTViKEistoUsfgbgsGFsWwfCljiR+6AeqBBZSV5OhhGrvUvIMx1acpdLFwPFvs4FZYbUC75+0sc=
Received: from DS7PR03CA0268.namprd03.prod.outlook.com (2603:10b6:5:3b3::33)
 by BYAPR12MB2597.namprd12.prod.outlook.com (2603:10b6:a03:6e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Tue, 27 Apr
 2021 10:03:08 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::6) by DS7PR03CA0268.outlook.office365.com
 (2603:10b6:5:3b3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Tue, 27 Apr 2021 10:03:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 10:03:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 27 Apr
 2021 05:03:07 -0500
Received: from ubuntuBBNew.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 27 Apr 2021 05:03:06 -0500
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Monk.Liu@amd.com>, <Emily.Deng@amd.com>, 
 <JingWen.Chen2@amd.com>
Subject: [PATCH] drm/amd/amdgpu/sriov disable all ip hw status by default
Date: Tue, 27 Apr 2021 18:03:03 +0800
Message-ID: <20210427100303.532655-1-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 116d024b-5fec-42da-32f0-08d90963a8c9
X-MS-TrafficTypeDiagnostic: BYAPR12MB2597:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2597AFCA93249705375A6F16BB419@BYAPR12MB2597.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4RjaRaoS4ssxfrYYq6XCYvQF+BUbZWsNm4Msbo4jm84uV6nM0wHIlGo1ZoxmhK+OOow+DRsfQh/RmIBKOKGEf48YbGC5ieSKgnRj0C5XiKDjseGExxPqLgEcfnReeH8j5Lhh3T+hFYlRNvUKyo99poqzndIafeAs1iUrQxCtC/yXj9bn/LCMZbAdH1/OpvMHMSeO6lBvPn8BeGHFA5OLHoXCnWYTJDd6afkgjS1k4AV1WBOFb4UkTPjl3eGgxLN+SscGJqiMAPjMaaXQwJU2QVUgPykOf8QOPNR1MItd/V7NWgY5dsuLVTjFaEWNJfWnrceLSMfbU5yvALel7SRDU40NwJzZnR3KUfdwhe315XBm46d53ULZA/Ly4AUNoOLZjMl4S/kc5w1g7izYP43H3z1Y1ptPyrg8NIapch7bB1bNkRLFdoB1nW3HBOV3XtDWFQaxUGtDSgWFEihJyCSyRnQczbO0m9LKYNwqcteB/YPAa5y1qY8hARnbG6iPHTXWt+0EMO1hMWHeGDMQpnvEsJiz9eVy9xDjKieYyHxvBB63E3oRqzgJpd7x+c5oKDVWlGfJ/4OERksZSUMtIPwTdqA16I65X/qGJKqjkOrkX5B2RZHIIr8Kc2JdOa6P+9r1ghop1GBSYLxWXfNPcpMrXNIQDAYJCj5gI+NkmdEGox3HNb9C50auws18nUIoL3Bl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(36840700001)(46966006)(4744005)(36756003)(1076003)(47076005)(36860700001)(5660300002)(186003)(426003)(86362001)(83380400001)(6666004)(4326008)(2906002)(82310400003)(110136005)(6636002)(316002)(356005)(7696005)(82740400003)(81166007)(2616005)(336012)(26005)(8676002)(8936002)(70586007)(70206006)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 10:03:08.6896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 116d024b-5fec-42da-32f0-08d90963a8c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2597
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
Cc: Jack Zhang <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Disable all ip's hw status to false before any hw_init.
Only set it to true until its hw_init is executed.

The old 5.9 branch has this change but somehow the 5.11 kernrel does
not have this fix.

Without this change, sriov tdr have gfx IB test fail.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index eef54b265ffd..5cb171c2273c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2843,7 +2843,7 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
 		AMD_IP_BLOCK_TYPE_IH,
 	};
 
-	for (i = 0; i < ARRAY_SIZE(ip_order); i++) {
+	for (i = 0; i < adev->num_ip_blocks; i++) {
 		int j;
 		struct amdgpu_ip_block *block;
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
