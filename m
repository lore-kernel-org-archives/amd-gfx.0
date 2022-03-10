Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11721C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 22:21:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F7EF10E452;
	Thu, 10 Mar 2022 22:21:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98F7F10E452
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 22:21:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fK19rPQ42Nkf0kuBUUZuAKh3j7RqmW1i4hRJ1FABPsjnfyW1wfgS8H90wELpVezscNMeEg481I2kJjCgvwZVcfg7UkCG3D0eLIfEoC6yZCE1G7TWkQleQbMZTDJ3zfryDY0QpyUUeuI+L7qyVZqW4ucvaxPy40Wu1whJfxBqBHs530i0oH6gELCGp66NBsxNgWR3W3z6IzY1s6fHDdpYXAPTMu/P0dtGW2vTzSlb8L6L4jhOAeC1M1KIE0PkxA7S5R/BlajoyMDCpN3mkFGjOWVWURq4LyJXu6EOTFssAsKPv3YZbnJrDO8p0xwCu3/Bbndi87L0Ho/3EXkkS1pYZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bk+9+dALRp5AXkfdTTta4E/mZ3yidQ8gicufp+4n5Fo=;
 b=ShWB3ozeq3dE3zrmfGUFtELgf+i79JoWOdurnBu11+A0U/7jZt488/AgixjMzdIbOLtq7kQGxI36Hk/2VLWG9hQuRh76lkCFZfF1XsHAE3S6/L9KFqnTBb1rZn63YN/JuI2ZDz/jPai/im7IRSbe5lsY9sSkYVtDFSLSUlo2u/utN54fljpUgICr0B40F3qFPDUmTvOt3pjSQSISchf0JJp8sYDiujcUC0Io96CDDM3wEWyq5a/AHvQSLKXNWineDRKRtui7/8aih4hLsKXQtzx67B47EC72Ix7mCZhBrCR1x4stO9mtYjP9fW1ol4e1tkVUPgPowK0rDMxZSVDnHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk+9+dALRp5AXkfdTTta4E/mZ3yidQ8gicufp+4n5Fo=;
 b=TOjjoFDTdhZI///jxEgolDNeFqKXtm+eOcykEzD18ABPj8c5DIYTzGf6ulT91oHpwO9Qv97xPdzrq3vPDa8l1As2VhHULeZV4jIiXMp3HWAPxWJZdtM7UsXVVuzLd/2FM+N8S2GSQh9g1ihGRl3EeGDJe0JXRxKRdHJPmGJiG/o=
Received: from BN9P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::7)
 by BN8PR12MB2948.namprd12.prod.outlook.com (2603:10b6:408:6d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Thu, 10 Mar
 2022 22:21:31 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::20) by BN9P220CA0002.outlook.office365.com
 (2603:10b6:408:13e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.20 via Frontend
 Transport; Thu, 10 Mar 2022 22:21:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 22:21:31 +0000
Received: from Linux-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 16:21:27 -0600
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/12] drm/amd/display: Update engine ddc
Date: Thu, 10 Mar 2022 17:20:37 -0500
Message-ID: <20220310222045.664867-5-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310222045.664867-1-agustin.gutierrez@amd.com>
References: <20220310222045.664867-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7ab1121-305b-46f9-c93d-08da02e45425
X-MS-TrafficTypeDiagnostic: BN8PR12MB2948:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB29487F32D012A2FAB7E07D57F50B9@BN8PR12MB2948.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVNQuN00P54kIcoHNODgRd0SfNaWYWHXKKSVcvNqVZb8LL4vnAmNRRuzeIhEp9rK4WmmLXYzyXo1CPsQqh/ZMoV/RihDzcEyu6piYFYMSvXKiuAwfTXx5jHCKsFFu9zOpnQBH5pUNvahx7bRZgQjKrWhlwJa3TIHKCj/cle1oxfMo/H+KpN96yUhMVkznvysQ9ZINAUTDhZeNz/tqYO5cH2nrm3+caz6ZBBB6xwA+tSrw2MwpZ//nBTmhiAhzZsqfkhzoi0/FjAyIfw4N12hvlyqD/vc17lF0J6IuO4nHTTV4gmKKcFbSE9Mtvgq71UzRt0mS8VE1tytXPjAZwcnk/flyTaX7MKEwC7n26LEKa84xDhcAXjwKeKH8HnbCfdVlZNhnScYxTnJuSVLJpBtFhNCjExMZGCOTAfGmeY4olx62fFnc4rA4+NwoRrI/V7lxt883H9kdjez6AabOhoFoxPH6J/heieTf8tfiPh/RcqMM88VlqD+VK4MZLYxoNtq+8mXQnHbgUN3NGQPpjYkkTyiQzNsqBgbQswndKwgZfPT6Qgwv2U2Js6sAA1T39gBuyljLr9XX/Zfzbub6FUsDRRmHgXmzkK+txn/ZBddfdpeSYI9oez48at8zfNvFQEFb6vxsXcI3r/hz6uM1bsr9383KFF6LdLC9XXAoPCdpXZHi73xLelWfBO7Da0SNyW/Rh3JBYUSX8cm9O640hknng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(186003)(26005)(16526019)(426003)(336012)(1076003)(6666004)(81166007)(83380400001)(2906002)(15650500001)(8936002)(5660300002)(36860700001)(44832011)(4744005)(36756003)(40460700003)(6916009)(54906003)(508600001)(316002)(8676002)(70206006)(70586007)(4326008)(7696005)(2616005)(47076005)(356005)(82310400004)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 22:21:31.1876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ab1121-305b-46f9-c93d-08da02e45425
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2948
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Wyatt Wood <Wyatt.Wood@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Jing Zhou <Jing.Zhou@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jing Zhou <Jing.Zhou@amd.com>

[Why]
Crash caused by a ddc update failure

[How]
Update engine ddc before release engine.

Reviewed-by: Wyatt Wood <Wyatt.Wood@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Jing Zhou <Jing.Zhou@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index b8d6f4202413..8e814000db62 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -413,6 +413,7 @@ static bool acquire(
 		return false;
 
 	if (!acquire_engine(engine)) {
+		engine->ddc = ddc;
 		release_engine(engine);
 		return false;
 	}
-- 
2.35.1

