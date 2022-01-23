Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC152C433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jan 2022 18:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19BE810E73B;
	Sun, 23 Jan 2022 18:21:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FCE310E213
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 18:21:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EohHwckPveuqROidJl3zIOtc7sXHOM/MPex0/nviLxVkj6N4FvPnglQtcLR98J6rBgYTi7vhIDbQjAJumblV69Ux56KB4RFz98xik26azlcIHa4SNtuxf6Ooa3CWzjWocVoGIrQotu3CZ6TTbiqQTGRuswEkiacndifjZTW4qHGO1ldrQ7pErAr1ptanx/ujGINiy96E/giHBYyjau/Nu6l3MNSEqXfQwh3Xf+/kzVJ0mxjdtlWZ2/RkA13X7fejaqlOXi1WApOGQJ4SfpTfYfNImYOBBdsS8JpYnOCWBlXPqU7yz7ipLA1w8BreJhV++CNdrpJc3G0WRK+EzRWB9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TN7JHEY+b8Y9vrLCTils2QhH7hSt9fUSDc1t4KzSmo=;
 b=Boo5sXf8QTCeAH6MFDsAEKkRG/yXUh5bSoKuY9NeVM3MfP1dxIsrz0tLnwiazW5jFj5kLIMVC+f0JHfoSab5kQlO0tzKSkAL1n1qt0RZYwCb1LOEuf194iT4vBiPC9+XZcWZtoANhOa08MCqiw1k8Ngi/id+Kir7BroS457SvLWq0m4/6eakAs+f2JCWCDQp3U27UeZFpFYnP4NgzCDiCO+maUGa1NUvKIJP+uq0NIRuzPNlcYFkYE9by50KfQJY9BBj4kZcBUCA8zdxMkGqGxmYAYfg9HQ2RUt0vCiTpLDQpIGZyV84k9CiVgnLfAlN5WoplHnseZTlyysTGUq/nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TN7JHEY+b8Y9vrLCTils2QhH7hSt9fUSDc1t4KzSmo=;
 b=fqFp2YCTFk/ei6ImbiJJF7biejZvFF2SNYIN9tuFkXceOxUSstv0kFzopZkua/vUWKJrjxooNmQrk+XSTK9IwdcGU/51tWOQZZvVs++WU0d+VQ/gMamc13i5yOQvu/LP2DqdUS2ZO/EfU7XmDxDX1BxCAHfN7FzXc62ZbJKjr5k=
Received: from BN6PR14CA0001.namprd14.prod.outlook.com (2603:10b6:404:79::11)
 by BY5PR12MB4835.namprd12.prod.outlook.com (2603:10b6:a03:1fd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Sun, 23 Jan
 2022 18:20:59 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::18) by BN6PR14CA0001.outlook.office365.com
 (2603:10b6:404:79::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Sun, 23 Jan 2022 18:20:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sun, 23 Jan 2022 18:20:58 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 12:20:56 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/24] drm/amd/display: Change error to warning when hpd
 remains low for eDP
Date: Sun, 23 Jan 2022 13:20:01 -0500
Message-ID: <20220123182021.4154032-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
References: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91bcc1af-27a2-4995-e113-08d9de9d1a78
X-MS-TrafficTypeDiagnostic: BY5PR12MB4835:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4835E800542703A63ECC2BDD985D9@BY5PR12MB4835.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:605;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WlMKEd06S6NJCj8VtdWaQ68cnrYv/JTxncH5lvTckzrVMJztFUmuR89jWu/6ePtRqxEEBLMnF0WFMxsK0q/aRWvsiKPbjjXVnp3mExUVbSwGg/P89m3xASa86xNiAROYN6G/uYgnQnGZ/PVeUMTAGSI/CBRbacyX/hjJD1sCsFrX58/zjR1MQRfebZ/Jg9YReH0yMRtlCW61+HsSvgtGFzPkxX62XgZlstPC16N72KTIlLrKyj08Ilz/6VpCfgQ++JZ5xj35HZg70hj1HKxcWzxV46ULY1Mg5k6agVgwVcxiudBGzr6xfTMywZ+Y0EDqfsIuOKxQ3ZbKQ/KUBU6j8w7dATPvmRcmLazt2fh44oS5YXAFAb6BbmENyeCnDbuJOPHbQWvHUuFKmOKxoI5jqmtD6KG2km2Mi2/VWq3aelTTdwDKMwJmTzqRp2637klMt0VH9f1EIk8eleh4otn6D4R3UJX/0lyV7Kv2MJg3uHjDN21a+a9GbYaBDFzsE4ADBHkMsAKgi74y72gfNH9urXEtsHbDBQlqC9XiBpf1KS9MfmLqVgnAcxGKhi65PPrAJOLkVjwDIAOekNWJgBTEe763558O8fSNEjCiaxy0gRYJM8dgbXwk6GOE5K6PiXnsP5tsdN1F8RUbQUrWZUaqaDyX1wK4Oc4OcHvyU4lM9yabgeU3DcTIVT2ICP+aYMyS+wNihN6fpnL/caVdjTMKVTtHQW8o7ijKQrJ+x3nnq2a6FuHTrq0b6cBIXOi45a4Y/0+LMrGZEwjX8xBc0l9dQpV3OBjYQ42XsikbTulDWdk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700004)(46966006)(83380400001)(336012)(356005)(40460700003)(36756003)(508600001)(47076005)(86362001)(16526019)(186003)(6916009)(70206006)(70586007)(82310400004)(2906002)(81166007)(8676002)(426003)(54906003)(2616005)(1076003)(26005)(36860700001)(6666004)(316002)(4326008)(8936002)(4744005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 18:20:58.4528 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91bcc1af-27a2-4995-e113-08d9de9d1a78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4835
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
Cc: stylon.wang@amd.com, Varone <divarone@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Varone <divarone@amd.com>

[WHY?]
SKUs that contain an unused eDP connector will throw an error when no
display is connected.

[HOW?]
Change error to a warning.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Dillon Varone <divarone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 9857e7b1b37d..bdde8786ff9b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -793,7 +793,7 @@ void dce110_edp_wait_for_hpd_ready(
 	dal_gpio_destroy_irq(&hpd);
 
 	if (false == edp_hpd_high) {
-		DC_LOG_ERROR(
+		DC_LOG_WARNING(
 				"%s: wait timed out!\n", __func__);
 	}
 }
-- 
2.25.1

