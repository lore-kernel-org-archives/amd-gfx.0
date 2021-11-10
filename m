Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B720C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 20:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC5EA61211
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 20:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DC5EA61211
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58C466EA23;
	Wed, 10 Nov 2021 20:12:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8DFA6EA23
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 20:12:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QojZ9HciJJ7aTxaBYfqTpvQpZlJcwHfZGc0eTVGRvsf+AqS7qZlKiezs/STQEwFn1Bk/FbEXRAU2fOtEMYPUEqz+g6O+2UbmvgtMRFObpDzevWKC7s2nBaLNo0+0w+w4fxIKee4s5mAKGKUROLOzx7PUdnUe1bjfhu+GNFiKutMNgPXHJdFu9ukLaOWlfJCWbNhN3cr9edSMpIScxnV92ACkELMBhypmKA1xLc6kZo92h2D02GY1XGQWWT9nrAsCDF/cW54UjAZ2pGNyg3NurxYb5WXfwM0Xu/g1QpDnEXAi8vau45EMU9K6C/NebNJthRyZJkZy2RO5gZxW3wGQfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFC4UvoefKK0aKpopj83TKne9zxQUCgvQzcuSKjLYXg=;
 b=maYxXXCm2p1Ni62qkCwSrgtzz2SuYEJBaxZ4/RwkkuAC/nzRWpX2WIAd7ZtxVilQU8wAMPdzDjlNJ04vP02p+QyPqVHv6L34TehmoSKj5aqEowyUtKvkFuqeANVYJRC9GH8qa6h459bZ6LpjpCCAw9iGFjmyU2rzRf59JtGwM9BtGFezGZjkmwYWzxYkPwhlKqLUt1ANNafj2F+v9vxGnBMj2bUi4xTyFNcVe1W6CVQwqySf3JgJLQC01/yheCqVF4iVA8hgJa9DFxGIg8tQbPfiCIAeJ7d463mSmCp8dEGE/mG3eyPrGln/iL2MfuZ/0S1nNLwxiSe90ZU9iR1Mig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFC4UvoefKK0aKpopj83TKne9zxQUCgvQzcuSKjLYXg=;
 b=jbX5lOLMiazC1R812fRKlUVz4gGv1Qub5jv5un8MD9/dfuO/H3rrVfvMQK2voJCOfgDURBZww5bZOk4teqW+4VI6LzBvFZdaHquWoYqR1d8SkHpFrfjboIQJfDzXiiRKDYUi32PPKfvFpG7CXC8bOqsff6o4TCuF4Ub/Q3fHXaQ=
Received: from BN6PR11CA0023.namprd11.prod.outlook.com (2603:10b6:405:2::33)
 by BL1PR12MB5379.namprd12.prod.outlook.com (2603:10b6:208:317::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Wed, 10 Nov
 2021 20:12:48 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::81) by BN6PR11CA0023.outlook.office365.com
 (2603:10b6:405:2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Wed, 10 Nov 2021 20:12:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 20:12:47 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 14:12:45 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Enhanced reporting also for a stuck command
Date: Wed, 10 Nov 2021 15:12:34 -0500
Message-ID: <20211110201234.53851-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.33.1.558.g2bd2f258f4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a078d82-c5e0-42ab-32de-08d9a48676e9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5379:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5379FFB417756D9C6DAA6E4799939@BL1PR12MB5379.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WL5kpnIuBkHJ3WmjRJsxsJ85PlunfeNZQd4RwWIlagHzntm1DMvzrS5g3Qer73uQ5KARALtaeRL07MtCdKYL6owEA+p4gUqpzB3e8SBj5Z7Gl0sGz+5KAy3NBHISaO86vCfKqNGVu8XR5Qh4VGoZ/bl9LNMaSqM8xinB0/FRrAZae5Bxxti6lhMe8KMoAFNuOjqEkt4zUGo5V4QOIt7PspzEOezjfRA4sl4wHtIb1MDg7m3VT/RjBL6V0WroVKa9duC0ytUJYjgI7GPWTqE+dCCVmMdBM6FPuP3A5hBTYG6CgLSZeNTsSx7Q1caHkfc2WNdX6lKYU9uY3iE5Cv0rjXltH4CO0DKurJMpdeU84bGD3mPojex9cPAWJrulohsGBlvuxzxasUloThEqv+8Tt92gP+x26QoJWo8sCr/X4Vec1Ps3/es/RL4eLQYsGTiO1+LPpWmtI21bvrrRT+73aHKu1X2/yY5jlJ8naAC+5gXju92dIv4tRUBTuVzkzI3GYTXbZM7ZPArxRPaCcPV1Rln21ckHyavyml0+WWpOyCh4hCrBsTYe9X/xqjh+O8/9GfDxZM8vKa0tEcyXfff33iuBe9rnOKsCn5JoxOJ9F2waa2t9T6OSlnEkDiguUPqNpTsj+gTq7TZcPesocZKbnyk+pJjiv3aybuZI5Po2vtMWNeXVVoqVXsnckTbHOtaA7VzvGF99cpU4K1EQgu62IXKWya7jFMPE+BoDSglxvvs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6666004)(5660300002)(26005)(4744005)(6916009)(7696005)(86362001)(81166007)(54906003)(70206006)(36756003)(36860700001)(4326008)(356005)(336012)(70586007)(44832011)(2906002)(16526019)(82310400003)(508600001)(186003)(8936002)(8676002)(1076003)(2616005)(316002)(47076005)(83380400001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 20:12:47.6763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a078d82-c5e0-42ab-32de-08d9a48676e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5379
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Also print the message index, parameter and message
type on a stuck command.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 843d2cbfc71d4c..63cab6173206e2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -141,7 +141,8 @@ static void __smu_cmn_reg_print_error(struct smu_context *smu,
 	switch (reg_c2pmsg_90) {
 	case SMU_RESP_NONE:
 		dev_err_ratelimited(adev->dev,
-				    "SMU: I'm not done with your previous command!");
+				    "SMU: I'm not done with your previous command! Index:%d param:0x%08X message:%s",
+				    msg_index, param, message);
 		break;
 	case SMU_RESP_OK:
 		/* The SMU executed the command. It completed with a

base-commit: 14271bc7f5e7ec276c58927ea87af9e81d97fdf3
-- 
2.33.1.558.g2bd2f258f4

