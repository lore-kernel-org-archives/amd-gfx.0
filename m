Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F196C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 09:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 162E223434
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 09:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162E223434
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CD7289A67;
	Fri, 15 Jan 2021 09:27:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D8FC89A67
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 09:27:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QML3iNa5RDqe7Bhab6oJXqSiS3CCaO2kjAqrZNls0RXRHquVR8gtNX7BZVgwVKf0N+HJRrcysUAtdoA35VfuKZ/ZCz38T+rjIaD6nS/6cOszSg/qtGCjDU3FBbSqOdxXaFQ/igw/62z5VYAmGVxr1oHANryxpir7f11RVcNqI0h2nPK9PrxPjBVeb3elcfGN25n/zv+xjwGGmRxQLfNx/NQy89wNt6A0o8MSRVnhDG33GnWgfykRlHWwDd8UZglECDtZs7F0JUIjoUWGg/Brrxphp/tyuxOREG2bOnE9iDF9fX/ZB5bJFtOIuf15/x2/Qx81n6beSiatkCVC4mZHTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ye+A8Ee4I5T6pa9JtUr2gf0EeVwgOnUgAOjgzedDfTw=;
 b=DCXEYvjL2D629BtTRoinuVSaWNNwSWo5Dy6i1VRO3DqzdofD/oiOyuCZmQmj5opbH6fd1ifnRq6AETxWov0X6Fzf/sKRVjh8cO4kVWAhoI0N9o+ZFQqVup9yYlaq7k2v3OcwuA3/zZjPgI2DpfN8jnIRvLL0i2cbaH+y0dObvcwNXb0/ZaxaGFoxxsNz90oBRYpruHwIhsyEYZLCmrI6T5spbG4sEwoJ6W5JBmDeiAYubiHZAeI16/884vVQE1v/DKYgX4NSmwxN7Zz4vjSHBaXhebiJO7OrA6Ya15FXqp0eR4obBx0uZNcT1+kUiKPT5B0wLfTebCubEWX/uznu4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ye+A8Ee4I5T6pa9JtUr2gf0EeVwgOnUgAOjgzedDfTw=;
 b=fPZ2jx2wD7touX4CYkAy4DyZ4FxA3cieBYxFqSTs1lC/LZww+KEJyn6tuzU5ODKwurY0ZjgKPJsWaKxpZjkx32RqPc6sjfaZHGFrXC4aJBUt7U5V2uptvRYv5+dCntaduR9CRMUkNREaeQG4GjYSZ8jPmNqPAP5dsi8xOlUYWJA=
Received: from MW2PR16CA0001.namprd16.prod.outlook.com (2603:10b6:907::14) by
 SA0PR12MB4559.namprd12.prod.outlook.com (2603:10b6:806:9e::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.10; Fri, 15 Jan 2021 09:27:35 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::fa) by MW2PR16CA0001.outlook.office365.com
 (2603:10b6:907::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend
 Transport; Fri, 15 Jan 2021 09:27:34 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3742.6 via Frontend Transport; Fri, 15 Jan 2021 09:27:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 03:27:32 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 03:27:31 -0600
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Fri, 15 Jan 2021 03:27:30 -0600
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: update driver if version for navy_flounder
Date: Fri, 15 Jan 2021 17:27:22 +0800
Message-ID: <20210115092722.2589-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b463179-a388-4a38-f2f4-08d8b937c9b6
X-MS-TrafficTypeDiagnostic: SA0PR12MB4559:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4559678360F5EFC2E6F45430EAA70@SA0PR12MB4559.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: si6IKyjWpaT55uuub6Z+UfNP68m6ZDx3/KJm6cIwrYLwm609CD/QbIncavBFy1Nt2MoA3uytwV4/n++2jPG/u7O1nIqblKwfGnh7O034nktLG4xchPjXbIjFAC1ahY4OlWgi5Homgvebd/yp3lnIHASaCM+8+jsljgz/LJDmvLjmh/p1DniUB2Izr3nL5LZ4dazRWKDjHy8QGwg0tGudMi+JyFY1QrROPObUI69R8RcSMB00ix94Pwjw5XtSMQELNZ7QGMoOXUpy8Al6Rl6XFk/3bzgnuLT4Ed52to18CzK6CNjE46yZKRmvTOQK58Cmby0B+Hu+l1BeA0uPe+ebQOddeJZDwJsgjIf4mjqyXXxWExg7klYUlgZHNWcQCkTQV1V4rbtnylkJYrAYtrTGdkmm7XADv+noQs5DwSrlacpTEu79U2diu/+Uke97xOxPls66tia5tJHSzZ1S4XSuKn9G2vZjDVBeWtSqc8VAS463G/6tcjlcclXHNTsTXJMh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(46966006)(36756003)(83380400001)(5660300002)(81166007)(4744005)(316002)(47076005)(6916009)(2616005)(8676002)(86362001)(8936002)(6666004)(2906002)(356005)(70586007)(34020700004)(82740400003)(4326008)(70206006)(82310400003)(186003)(7696005)(336012)(1076003)(26005)(54906003)(478600001)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 09:27:32.9856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b463179-a388-4a38-f2f4-08d8b937c9b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4559
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
Cc: Tao.Zhou1@amd.com, Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's in accordance with pmfw 65.22.0 for navy_flounder.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I85fcf7a238b5a7d1da76709ef7963140702048ab
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 13de692a4213..102a0cf12d7a 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -31,7 +31,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV12 0x36
 #define SMU11_DRIVER_IF_VERSION_NV14 0x36
 #define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3D
-#define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0xC
+#define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0xE
 #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x02
 #define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xF
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
