Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2037BC07E9B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 03:33:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3323610D0
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 03:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3323610D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69E5489C25;
	Tue, 20 Jul 2021 03:33:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6000C89C25
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 03:33:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZgF1fixnKrZEqB/6vqu5a29oer11YE3pjVRL7FWplHj6AGPpUEC2+jz7qhTFe1wo1PkPSkMmwj6ogYhTPRzYqiE44wL3ZxdUXOhsnBxNKLCVD4L4qyskhrPdrYyoQGBZdliOee1x2Yb2TkQk0HddBrp8kRGgj7pGljTbOCx+s2u6oc1dXtTu/XOzN8+yuVB7795Ke3WMiPqAm1SISy7bWdbxwjBC4IDGtHWFdlbTPokIsqaoMw4WN0DQj/3u4TjxmN/ASJIaxsXROngzCNhuwWZ5qgo9cTJR/HjV1xBRk1p2wOqtCDP6E/iK7MS59xw2CbAYC5Saw6kDuHtCx65hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejf9ymg3UTFvNMupMQA7LNMiH2Xa9T6aorUvxjFKuHQ=;
 b=kn3tI3fdZBAM5tzCLQDsTwSoq4hm2N8do1OwETwblLBDGCt2L7t1sT0vZO2RWRsDKBzr86UfPslLSbA4T3FFJ4SgQsG5rIFxtM6uLC5yQIweTdR95LAxbVQ/3lMuE0gWXyjl7Wg54hChMuaEZHMPKXvNB7ml7++tEgwxQI0Y/qoS5/ChbU+pJrPqGTRx2ItT6dgA3dhY7wb0O3HCnwZYk7pVYs+d5cvo5f7MMO0N27vx4NeaLv/Kq2kScYIzA9vSefZzOrW4GHgrfOySUztpL7/xYVVTFr8rxa+XqmqjdlEPrbdQnLjfeylenAWRTHKJKIHck7bfubR4hwlYsCWbyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejf9ymg3UTFvNMupMQA7LNMiH2Xa9T6aorUvxjFKuHQ=;
 b=41QlwQth49pSiwoh/f0Vzy6jsZ/QS75wtjnO2K2rDta8FuTr6ds/aFqjlN8BwG5L7xuoyzzqS4bgl3gvXXWtuH3opcb++TpY7FvTt2NMovtBVTX/v7NTztHEcpGy8ybUTtgJGGyN8v+p9fl78gxKkNRX7p88rq3I+V9xep/tv48=
Received: from DM6PR07CA0067.namprd07.prod.outlook.com (2603:10b6:5:74::44) by
 DM5PR12MB1308.namprd12.prod.outlook.com (2603:10b6:3:76::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.29; Tue, 20 Jul 2021 03:33:41 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::ee) by DM6PR07CA0067.outlook.office365.com
 (2603:10b6:5:74::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 20 Jul 2021 03:33:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 03:33:41 +0000
Received: from stylon-T495.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 22:33:37 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/2] Fix regression on embedded panels caused by enabling ASSR
Date: Tue, 20 Jul 2021 11:33:15 +0800
Message-ID: <20210720033317.686726-1-stylon.wang@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cd6bf6d-c7ed-4a98-f097-08d94b2f2b68
X-MS-TrafficTypeDiagnostic: DM5PR12MB1308:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1308504E2EB1E3B75A477292FFE29@DM5PR12MB1308.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UX3tAUeaAw4rUouTSpEt3BGiVCez1UGBHfbfDmdCrWf+f12CRC98i5jkYrwmMp9+9YXZ3Tb26g2ck1pk506lP/2M3G7NO2Ug9kwzIflyZhD5eoXPJRbh6MXFnay3EscUmcv40ydJjiTcCJ7cibka1ckLe7uHenMYS5bQ8G1Bpw09uivzipJp0/EsyjbDl3PAFuabvZJQMm2M5li2BVXXaKHAu8niqMi7f5y0YCS1FmYy4jSGgIycC/XZGf/r5+868kM4muSflc2+P4XwjrVh5zl1SRYZwcnUX4YA7KgsxTpseah2cA7juntS+qtwOamCGystqSWe+BGuJufKrXZ4gkwxrsen0Mt1VRIQWppESzeBuEI8bLGPrlykWjK7O/caGbIi8GbiSb1foXHLLGJhcApRZGmPqnJkysIq/H4kNsKGNzgBSn39qcLl+5a+o9R+yecR/3RYB6f+VE8zTSz0iH1w3vvIZqDRw2P0H+LtNKaB/DNowFTs2H1lW2bXWyByazV8g05WuGNu61znfRCEi5yK/lygwbjAY8jv42tC1ApW2P4VZzUsbFoqQ7MoI72nG0WYu1vHqpIQBdp1oM0iHSI1SAQilxmUR6yIxSekx6HQBuhuiEP9roeABosBwbhmeHDLqpsL1MObOvYCXbYIXxT60UGpYfLV8Kt2xHLb6onYtDG5aj3RMMrx6bTIHTcUJ8tawqgN0P9ISg4x5aOJvKHXB+gtE6jEI3OO6jwoH1Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(46966006)(36840700001)(6916009)(36756003)(70586007)(70206006)(2906002)(478600001)(4326008)(81166007)(83380400001)(356005)(54906003)(8676002)(36860700001)(8936002)(82310400003)(186003)(7696005)(336012)(86362001)(2616005)(16526019)(426003)(316002)(5660300002)(44832011)(82740400003)(47076005)(6666004)(4744005)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 03:33:41.2310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd6bf6d-c7ed-4a98-f097-08d94b2f2b68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1308
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Previous ASSR-enabling patches cause blank screen on some embedded
panels. This patch set minimize the changes made to code logic prior to
the ASSR change and also improve on code readability.

Stylon Wang (2):
  drm/amd/display: Revert "Re-enable 'Guard ASSR with internal display
    flag'"
  drm/amd/display: Fix ASSR regression on embedded panels

 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 58 +++++++------------
 1 file changed, 20 insertions(+), 38 deletions(-)

-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
