Return-Path: <SRS0=FsAh=JQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F15C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 08:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FE5660FF1
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 08:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE5660FF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A252E6E14C;
	Mon, 19 Apr 2021 08:47:31 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760081.outbound.protection.outlook.com [40.107.76.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EBD66E14C
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Apr 2021 08:47:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkzicMX3rP+tItKjV/0HHi5Q7Eg5Wacuio7TjCiBRyGswsi9rNh6py/4ZogRtkTcKM4BvR1t2Zqtn2zIJe4CgDFfn4pWJIqJ3s3jrHqQSCmv536C2S7TQkHp7csoCSuLBkgGg/JMsYb+stBzdOMTbORqBxvdsx90vybN3o2YcNnglkHX1Nf+KJk6i3vMlIRMwknhiVFdriLkxzE1fbDbxmvUTB7kvq6VnnOKSHmQpka5Am+HH8IzGhFT/1GM1GfEacY/PjoIDM4f7mp5TgkflzipKAocGosQyPlSm1GjkN+gD5x3EVRXr6TjU+kj/hFAeoS1OjPYqw2i51sjNG7Mug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIBTL6LY3oWHs0obNlEk6B6NLgzudTBxOxWXATtlkvg=;
 b=BqO41AuEqQVb5R76NHMIaKwqbPBwgv6l8bih7h0rqpDEc5l1XvPptZ2GskT+PyEjpEVldmdXBkEUQ68B9ErcWd8nojf2cFncMZmB75PH/XaMikCtPCvqytbF1g2zCVsG2LTRE97BqE9WI0iy0i8V4aw9vG+0O8uhB7D5OchxRD3/t1Ac/S1FXzpz7LnbrLXQ3r/ahi8XYzTgaAkCXSTvnVkaH3mKipP/D5t03G/RsD+tR22Dt1Ujy9UKq9WH/Q4Qyq1y0aodJOgEEB6ONdzX92FbLJ1Leb7TW9G6xADAcdxJYKYhGBxYf2KU/bSICBSrJ4l+uefKjinr8lbCcNhOxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIBTL6LY3oWHs0obNlEk6B6NLgzudTBxOxWXATtlkvg=;
 b=EY355xDGHlOJBPCdJ7EOOukoiVelCepIdTClLIUcpro//4pev2uP4D+nyZMu/y9BiEJwDzYhjRtr+wvX5Hhg2zf20UYMFd8YKbY/XBr7EQqDDXMDhPK21hB5YolJpBpo/JecU+fSCYe1bNnd1yRJyGTQMg+hNqB3uNXTVPj9MEo=
Received: from MWHPR10CA0050.namprd10.prod.outlook.com (2603:10b6:300:2c::12)
 by BN9PR12MB5209.namprd12.prod.outlook.com (2603:10b6:408:11a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Mon, 19 Apr
 2021 08:47:28 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:2c:cafe::f7) by MWHPR10CA0050.outlook.office365.com
 (2603:10b6:300:2c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Mon, 19 Apr 2021 08:47:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 08:47:28 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Apr
 2021 03:47:27 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Apr
 2021 03:47:27 -0500
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Mon, 19 Apr 2021 03:47:25 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix GCR_GENERAL_CNTL offset for dimgrey_cavefish
Date: Mon, 19 Apr 2021 16:47:09 +0800
Message-ID: <20210419084709.4955-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f72e5c5c-8f37-4087-b130-08d9030fc33a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5209:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5209F41F1245632E01B754E1EA499@BN9PR12MB5209.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O0Ko/mYVzpt4HdsVmIFCnHgl6I1t9AXeNoE1vgShTNebCQAd/ga/KKgWbcK92BjkTPrD5r5wpsex2fjJCdt1/MB4IyAfbLgoYmL8xpWBkvnA5BAD5Bv0JUgZBHU1ZCbaYSioiGfwJmjB0t7/7YlAPn9Aw617Zwts13aDMm7bTgCOX3lKej+yA6q09EUx5YYvdVIb5xOKHSET9RCzPNjQd8nxM3eZd2LgPrhSng2OZFsimngORwvDzlZ3Ql/BUcvLdbGAeutV+UJ4o9qqY32Dh70ddbcirjVPwUzNQ37QJyguKeD6Ttd3rxmQ4Zw63h/m5YOnZjXa6YGoZvxfqLYfgNzxBBg26rYP4IfvRtBQUx0gLN1chU+gWs5+ndiJvFEAWfizd/e0aHHiDLtfIgufoN+vUSqrHtVQ03rKYCUdDbSVhCRiatOC2xhCVMyvOT7FHgrBqFiZMgr9MvJVs8e7TS2kVMHYvvA3yi6YcysUqMPFgXt0e6yW8la8vOQuw3gwtD+1tMhXvZrQ/5TpvSGO2SgWRTqxAhxcjq802VBA3BzLRFeREKeu+NB0Gf5Y6srvXFwPd5O53nHRjgLHHwrL1pG6xGPe99MVEpCnelNIKQIb1+cky8kD/HpH4kO31nJkYUCDck7hcHxoocrKmxM8UP0l/HKF+75tVmVKoxaOkUz5uON/Kt3ZdJlJ9JMvDGll
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(46966006)(36840700001)(6916009)(1076003)(47076005)(36756003)(186003)(83380400001)(5660300002)(4326008)(70586007)(70206006)(36860700001)(8676002)(8936002)(336012)(26005)(6666004)(86362001)(82310400003)(81166007)(356005)(54906003)(2906002)(426003)(82740400003)(2616005)(316002)(478600001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 08:47:28.2873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f72e5c5c-8f37-4087-b130-08d9030fc33a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5209
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
Cc: tao.zhou1@amd.com, jack.gui@amd.com, Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

dimgrey_cavefish has similar gc_10_3 ip with sienna_cichlid,
so follow its registers offset setting.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I2c8f1022c0b4c5baf70d09ec99b7b2ca8da36bba
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 85a6a10e048f..49fd10a15707 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3377,7 +3377,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_4[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCPF_GCR_CNTL, 0x0007ffff, 0x0000c000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0x00000280, 0x00000280),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0x07800000, 0x00800000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL, 0x00001d00, 0x00000500),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL_Sienna_Cichlid, 0x00001d00, 0x00000500),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGE_PC_CNTL, 0x003c0000, 0x00280400),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2A_ADDR_MATCH_MASK, 0xffffffff, 0xffffffcf),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_ADDR_MATCH_MASK, 0xffffffff, 0xffffffcf),
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
