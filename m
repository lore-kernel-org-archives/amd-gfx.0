Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1636C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70D8461165
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 70D8461165
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1380D6E14B;
	Fri, 29 Oct 2021 15:15:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66F246E14B
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 15:15:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYaaNQ2SKwyMMLqiEEiwoRxMNRWe0daMbvVlLi9WH0H4IYuRgsfoMM/iavwt7i5B4wOaBsfoi1QahDQ9CKW8b9USBG7Jatg9QxYenAtvhc3l5F234+Hhj27PXDAsbkH8QuoAOksIia7pFPgOKTdQtD24T/GO9ow7EAE/vAUoT7GcTCdobNGPPj6ZjaHr7aeOnAZwcmjCyaDziRMRnec8xGH8URrnT0IxvAOkM8EmMAFlG7wznjfqaTczqw+F02RLFB1ber3M6aIt+7EgWyiX0xSTw8xlLehX7elO2FdWAqkTXshnUv3RisFD4bZvTzZzVpSBGhhvEmICcDYnbXGW1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iW2+ngTWDH4EuvQF9DD+XXtmPSOHzSuwl+gms02LJqw=;
 b=mNqTnJVbE2PNov7BdDemSOXoDqUn/CH4IWkspGmpaFTK1/EHlbUPGA0VqMzBcMe4JDrw/iXuBly/inZrchPIZ7O+cW3OZbe+pPhlUQVN67z47NY0iQR3KtoRMHhpavNZoBsCI/WyfWjRbrHXVriIKXUe9t5w7abmqtrBpIUbUbJ+3bw6WHuedARxv/mhvbxgsNZg5vxHgIj0Wh0ZQ3NzF/e0Hm1Y9z+upmRPTJ6c7lgvSvlHW+sWVOp0SNzoXOfQjPvj2xg1KjhrKpFzUjZkB0ljb0hjROH9OFtVfy3ypfNP64Bz3WgokInS5aiL73a6/bG62QdQTuXrRaej1aMVzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iW2+ngTWDH4EuvQF9DD+XXtmPSOHzSuwl+gms02LJqw=;
 b=lXZn3N4BYmAZYL6ahszrZBrnWYZJpAtpfrjeQUK5y6SWU6t0F+BLA+RDWd7J6F9Kmy+rp/nnFh1lEdsHzaurRISleeRJzdvtxV3im5G80/IgTvui6rNaNfB5f7RQJKfTQYkVnGAfD9a6M1ZOEC3s20XMYcDYAnMPIKFgWmFpW58=
Received: from BN6PR1701CA0007.namprd17.prod.outlook.com
 (2603:10b6:405:15::17) by MWHPR12MB1230.namprd12.prod.outlook.com
 (2603:10b6:300:f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 15:15:30 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:15:cafe::94) by BN6PR1701CA0007.outlook.office365.com
 (2603:10b6:405:15::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Fri, 29 Oct 2021 15:15:30 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=temperror
 action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 15:15:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 10:15:27 -0500
Received: from elite-desk-aura.lan (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Fri, 29 Oct 2021 10:15:21 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Subject: [PATCH 12/14] drm/amd/display: add condition check for dmub
 notification
Date: Fri, 29 Oct 2021 11:14:54 -0400
Message-ID: <20211029151456.955294-13-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211029151456.955294-1-aurabindo.pillai@amd.com>
References: <20211029151456.955294-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 316be59f-73bf-407e-8e02-08d99aeef0f1
X-MS-TrafficTypeDiagnostic: MWHPR12MB1230:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1230BBD7CB540DD12DE7F5ED8B879@MWHPR12MB1230.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PL9e+ckqz3gH1OyZkTjz/v9z8uFjDAGYL/zf1L1TgJzebIO5KC6HLxmPPftNEx01WXKjlpbPsYBfyJ7mSjvJar4ufhbqOgA17NjeU2O1sXLzAucmhkoNDLhGy+yZDB+e0/VT8BFvOEbdGSTPtArRRVqiqFxjBJoOcJNCXi5tfTXCFhJmXwrlKuC/Y75skNQbMARRaA+g2X+ZnOuPEBNZ1ttpqNSE1wtXn1+4iojYzeqKWYpCsWamYdeI+Zx2TB6vdkjuddK0ho7EJaCkLoKN86V0l36JdjGtlze1rtsOXArQScpOIZbyErVe6DtmJ/sW7x2dC/SKwyuiIKGe4mpP5kFzaVpoWCcW/pHTLtuY1qaaG041omBy8wrMcZifmWDbc3VQSrRXxwQz5Uhr/ddbfhNCqqRk9qaW03sOjFN4N9SLm6LzIBrW0Wr3+zgMVcMaSHHME+0oHyL0HBA8MR22o7CKkM0kucqXCqL4IYErOxZSS7rrHPmTGBCFbS1kYR25NCPVCCH7ZDcM9JyvToW3IYELDzbZ600YntVSxjZDnnxqxwWw54c6y0J+9sXLvn+XIoRUQ7csr2dtqFBe2rl9IMaPBLu0qg0jEoo0PgBVqqF3Y8NNtmw2yUfU9a0ROrIZ9Wjtpb4E7Z3Uyor7F7d9Uxu+GGeSV+JeiukgDlTE41QPRcfVrg4NkDyjYAHLDKX/w6qpdpyEALIDPPhOt8M2EyD1yCFgV+MuAH3mx6lVxYihNinuKSDfEezBHIcBI7HNJ4vzOmnUu2+IFwrvS/4ZhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(54906003)(47076005)(8936002)(336012)(15650500001)(508600001)(26005)(186003)(70206006)(36860700001)(44832011)(70586007)(83380400001)(81166007)(1076003)(2906002)(356005)(63350400001)(82310400003)(86362001)(63370400001)(426003)(2616005)(316002)(36756003)(6916009)(8676002)(6666004)(4326008)(5660300002)(117716001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 15:15:28.4452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 316be59f-73bf-407e-8e02-08d99aeef0f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1230
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

[Why & How]
In order to have dc_enable_dmub_notifications() more precise, add
one more condition to check if dc->debug.dpia_debug.bits.disable_dpia
is false.

Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 11a00e4d9e81..398de46fb7e4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3608,7 +3608,8 @@ bool dc_enable_dmub_notifications(struct dc *dc)
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* YELLOW_CARP B0 USB4 DPIA needs dmub notifications for interrupts */
 	if (dc->ctx->asic_id.chip_family == FAMILY_YELLOW_CARP &&
-	    dc->ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0)
+	    dc->ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0 &&
+	    !dc->debug.dpia_debug.bits.disable_dpia)
 		return true;
 #endif
 	/* dmub aux needs dmub notifications to be enabled */
-- 
2.30.2

