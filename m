Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0996AC11F6A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE11B61D4D
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE11B61D4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A0C189F53;
	Tue, 29 Jun 2021 15:55:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 563F289F8B
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 15:55:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IO3HjLpcBp8cSiYVqe0E8GyjRkvSI3+FMwa2FZePQgzcbh9PFgpENg2JHtd2d1kF0roRJz/iBFp3yz0ClrdJL6T6DHGCK2AbcvDMa1RikY9IbiwOZOx35tZtxd4oLIgEDMbCm9woPN9+lpQnjLrPAGb+wzTQHeH8+obVXxcamEGmTeDXzbVEnOUbpame0NEhqQuqDja6WCdVGZhDJE6n+ytpUNuR+zhga6GJxLHvw7wkRhnFe/PH00+Ct3aBKrRvbTr0Y1OTavXettuppzX5Hy8RUDABa9sMhJxNyDaUtLHuFgSxNctb48YahKFgg7+NgUDWAGAqQpMmPWMoa6xo6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CH5cQfpGnxFxTJ4inUmRJ19lI88guiapla7o1pYyXpw=;
 b=cNX4XtS1AaVRr55v5y5ritNHVxcGAx3lDXzcWb28JPyyED6JWCHDoyCgUALBvhixhzZo4f1aazoDTHFRve16nNNfv5fbHjsBAi6PwD2XuDxQE7KciWFGgABlDONy+kv6qI1L5Jk6qXmsMsbtExok7NPnEzn9cQNm2dknMW+iUj6M7dgH4qkk/2fZVtumyRrx0Lk7ZSOw7A/cGXeTi/Nmc3KB531av9DOoUf+bl3ePXcaFQpphk3tEvwyxQDUMEtHZdow6+fRIKHzCov09BwOSJrEFcp8RLZ5XEUtjlTUI6zzxnhnmNdpXncxyLHcsrCj0Zo+Tu7YHRuqA4MA1nEzUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CH5cQfpGnxFxTJ4inUmRJ19lI88guiapla7o1pYyXpw=;
 b=TAZVYGyP3nKzV4nUX9D9tVvnOOjtBlfXu0e26M6axhRhIxQggjCH3C7A8KtK4e/q1FI8Rh0LzsfjIfYZoDekHY+/SizpuKRV2eNWTredJx0wRnrajHJPQaljavZvJmS0bS/S7j0b6rk9Pi8IGVCXE9VHL558QT5QjTaxfp1jWc4=
Received: from DM5PR13CA0039.namprd13.prod.outlook.com (2603:10b6:3:7b::25) by
 MN2PR12MB3757.namprd12.prod.outlook.com (2603:10b6:208:15a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Tue, 29 Jun
 2021 15:54:58 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::23) by DM5PR13CA0039.outlook.office365.com
 (2603:10b6:3:7b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend
 Transport; Tue, 29 Jun 2021 15:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 15:54:57 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 29 Jun
 2021 10:54:54 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/12] drm/amd/display: remove faulty assert
Date: Tue, 29 Jun 2021 11:54:17 -0400
Message-ID: <20210629155422.26118-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629155422.26118-1-Rodrigo.Siqueira@amd.com>
References: <20210629155422.26118-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78dd03db-03a3-4523-5086-08d93b163ed4
X-MS-TrafficTypeDiagnostic: MN2PR12MB3757:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3757A9DAB44C934F20A681E998029@MN2PR12MB3757.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c6NNDRAg3TbUOoen1whoQyEZZv6mP3+h460RnKCyEDGnttmPwt5ljSBNt2ajudU2wy33qEcPOUaIzt3HzviD+DbzPoD2fPX7aptlMl0SYuv6DRo1RPVGwn0z1gOBKO4cpFLpU9omAQeDqzlnbtm+e/ZK2g2SMjuHtRyDeyB+RFh3nOCzBk1uiF8gzeDdjghTcQEp2HHxYa8YhtZY5ukJHeo45g/t112h/QFhij3V3/mi2tee186wbQZcqRzH+U+PZSnspC6XZrYgmdafJjxH6LrA6xiVo9a+Q19SR+9ixpY6eWIYeefIJ5fndAg5m5USbfOCMxg5hotrDFNGUUMiMPdWhH7TDDC3mEdq0a16xmdsk0fWepfvTkE5O6REVFhG7PCtEYA2Ry/6Kvf/9Y0fBL4/9taPnmps3CLwDBFYNf5fAm+d2WI4yLCnqV/l4oPyj3uTpu2ZXx1UwzAZjof8YB9uh5KKoK3hzUJupuU6wylhikY+d/ostqaOFxvqTyaLLtHfcd3KmCvPWJeD6yIiDX3Q0C/ik0KKhAFra09n+HN+lMcCZaXeHv+Hgsca5pQsv4hayBiKUzaqqXYQsPBG0XmKbXclJOi/NXn/5EnOZqEmrFQBTsc3YKQGtBVGURLzlJ6MjPe6sRXqs75ve53WKPQcjLrxP8JS7on9c3OJCh+RDowhW8970hImwK13QwkqrK1T1dRbYKySe88GsuHGXMY6CM16YIlFmMoFOKLFbFw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39850400004)(396003)(136003)(346002)(46966006)(36840700001)(336012)(36756003)(1076003)(70206006)(26005)(47076005)(478600001)(81166007)(316002)(2906002)(83380400001)(5660300002)(4326008)(86362001)(186003)(36860700001)(6666004)(6916009)(70586007)(426003)(2616005)(82740400003)(8676002)(16526019)(356005)(54906003)(82310400003)(4744005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 15:54:57.7997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78dd03db-03a3-4523-5086-08d93b163ed4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3757
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 410543797275..335018f0f0c3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1776,7 +1776,6 @@ bool perform_link_training_with_retries(
 		link_enc = stream->link_enc;
 	else
 		link_enc = link->link_enc;
-	ASSERT(link_enc);
 
 	/* We need to do this before the link training to ensure the idle pattern in SST
 	 * mode will be sent right after the link training
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
