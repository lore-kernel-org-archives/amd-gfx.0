Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21086CDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 17:42:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9256810E440;
	Wed, 18 Oct 2023 17:42:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCA5B10E43F
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 17:42:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSr243yJBOZ5+sm15gwqFUmH9gyKWmSJd6j3pBifxSiiNZ3n1HNfkp1jKFbjXtkuiu7Grt4a8Mwi3Nq8nvV9V/WZyBqYVE+hxbIGh/spNzmi08PhKDpPnG5x41DG44zwRTOLYB2ANuPatnYjCX2wQm5lbnK3E1EDr8izxU5WmcR7nL0AS9c7Wxp7UojT7r0SqPqEptefAPXqogQYlqICcTNHOUWCPDuW26zclZj+67QrjxS/F89Wj6XqxK1cCXjxhRHESjueiIPYUpAh1M6lLfac1wr0+xfqPkqtu0i0/gnsel9jQk5jQaO6GMavWxgjTF45HUJ006j0QmqpqKQarw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9FHnfze21lOv6nyGGXsP6gdqDxB1K7bmal6JujAnWQ=;
 b=izoFWreW7HQ+YfFQkLa7o98g9L4Ud77jVfRl0Aefi1Xgvi2EuNkOs2K496WfV/r4KVvIyu88BVrk4oX4FTFQkEWXSbXOra0TSVTAh4rR9AvxVMLppkCUrDOFOpgoDdKV6aLiJp+utUmx3EVmZNqtB3R8Q/hDvreLMtNbQh4+QtvvtWi4dTma3WqkOSr/Su/88cCqOLNI1dhSkcusoaC5L6ivwyVijeFDH/WIq0svcunhhwvZsqIEFpRmsB9P04I+8NTCqyIsHPmABtZdq8p/T98M9fHzwe/iVGwbBUOECOmWbFQfX05TSQCZIhD5cq/8IXJ2DGtb6cnTs+BQluOp5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9FHnfze21lOv6nyGGXsP6gdqDxB1K7bmal6JujAnWQ=;
 b=WUpLQ9Et+VP1nYJihsh1WAt/Hc6fSmIMg+d1KfPOXSlEdB9At9P0XruSoT07b/artfxMWVhLh7vpO7MlnFZPnDNBWDegcvmexUinZye8LyNmtsM3KautPba5x44t6Vu/mEFrMv+Im+a155l2soplc04MtBos1C21Knesd5Ps3fw=
Received: from SJ0PR13CA0233.namprd13.prod.outlook.com (2603:10b6:a03:2c1::28)
 by DS7PR12MB6261.namprd12.prod.outlook.com (2603:10b6:8:97::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 17:42:46 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::ec) by SJ0PR13CA0233.outlook.office365.com
 (2603:10b6:a03:2c1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7 via Frontend
 Transport; Wed, 18 Oct 2023 17:42:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Wed, 18 Oct 2023 17:42:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:42:44 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:42:44 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 12:42:33 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/26] drm/amd/display: Correct enum typo
Date: Wed, 18 Oct 2023 13:41:22 -0400
Message-ID: <20231018174133.1613439-16-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018174133.1613439-1-Roman.Li@amd.com>
References: <20231018174133.1613439-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|DS7PR12MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: 31813b29-ef5f-49e6-0cd5-08dbd001a35f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ttwL6XLaoVjzRZRAzSvD5IfUkWxY7yqTmYO5Rxwv0yx7GglvcSIXV2D09TTCGmgqYURvAGAoabNZx7UPTrmKov7EoN53V5uSpDVi8l6EOdTIMluHULlz0qTkueXU2+UfEtd4HeReHQG2xHqsjk1sMxvkN8H9cLFvPLHiFzV6Hftpxnz6WHCZUDvq8Ibd9h2+OOVkcpt/0M9upUlZeHxtykK693Fnnf9hi/yuHJI2CR3je6Jh7eV+47hIlffJ02jXE5cWuRZ7TWox1brgpZ8mpDl86u0J71fDnFJ/B7gnOs8BMTz/Em7QXwUA2IlkTXFLFfINLfea+eBtp/t7EMMF4gEqKWH2vvykHu15FSfplLEWM2H13w7ulUscPwBw5jJhXes8+/ulD9nstJbTDdGMKU+I8Albzn8WQsyXWQJwjM3kPrxQtEq3f8vnYsSR8rZvzf7I+DDbfFnVP5jSIQLFjsNVcxMD6SgnCZur09qFf28yCLLWKT0xvTwHi0wdBST9BiDLAo1XgZspPZ7T4c9M8hb5MP4pzPnrAKE3tddMwDd6z4+76IFLUdbwIW2FKj3DVOJiY/0nZZDpzVtGSNj7Ob3z4CCqA2BPpMa81qAflk+4q9FXEtoqfJWxtDXTbZ7KWdqB0gFb11qxPPWHcQQwmK3Qw5oXyYadQhaQ0oK8pK2r8IPf+nKyt/V7JOla0VUXMsPEmQWfjVDcOMAM5BPNVPLVU1151XRrOtNo0oSjlLvExeiKadr+gcXE72H7KbncDxSCXk8/6rbpQ4LDTDUMaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(1076003)(478600001)(8676002)(8936002)(4326008)(70206006)(70586007)(6916009)(54906003)(316002)(41300700001)(40480700001)(7696005)(47076005)(356005)(81166007)(86362001)(82740400003)(36860700001)(336012)(36756003)(2876002)(6666004)(83380400001)(26005)(40460700003)(2906002)(5660300002)(426003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:42:45.5486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31813b29-ef5f-49e6-0cd5-08dbd001a35f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6261
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <rodrigo.siqueira@amd.com>

This commit just replaces dc_interrupt_po*r*larity with its correct
name, which is dc_interrupt_polarity.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/irq_types.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/irq_types.h b/drivers/gpu/drm/amd/display/dc/irq_types.h
index 530c2578db40..93354bff456a 100644
--- a/drivers/gpu/drm/amd/display/dc/irq_types.h
+++ b/drivers/gpu/drm/amd/display/dc/irq_types.h
@@ -178,7 +178,7 @@ enum dc_interrupt_context {
 	INTERRUPT_CONTEXT_NUMBER
 };
 
-enum dc_interrupt_porlarity {
+enum dc_interrupt_polarity {
 	INTERRUPT_POLARITY_DEFAULT = 0,
 	INTERRUPT_POLARITY_LOW = INTERRUPT_POLARITY_DEFAULT,
 	INTERRUPT_POLARITY_HIGH,
@@ -199,12 +199,12 @@ struct dc_interrupt_params {
 	/* The polarity *change* which will trigger an interrupt.
 	 * If 'requested_polarity == INTERRUPT_POLARITY_BOTH', then
 	 * 'current_polarity' must be initialised. */
-	enum dc_interrupt_porlarity requested_polarity;
+	enum dc_interrupt_polarity requested_polarity;
 	/* If 'requested_polarity == INTERRUPT_POLARITY_BOTH',
 	 * 'current_polarity' should contain the current state, which means
 	 * the interrupt will be triggered when state changes from what is,
 	 * in 'current_polarity'. */
-	enum dc_interrupt_porlarity current_polarity;
+	enum dc_interrupt_polarity current_polarity;
 	enum dc_irq_source irq_source;
 	enum dc_interrupt_context int_context;
 };
-- 
2.34.1

