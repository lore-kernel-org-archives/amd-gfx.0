Return-Path: <SRS0=Inwe=AH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E220C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 16:19:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34856206BE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 16:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1K08i1XW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34856206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF6876ECD7;
	Fri, 26 Jun 2020 16:19:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 475526E125
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2020 16:19:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bd1i8NhZgfqap9HE3ltxF4Tr8MP8DHTjjzn4WQ88FHBN/BbRN8dfCs6I8ny8QJeml0bnRHmGG0QmwyXNJv0PzAIgzJ9rmFxNu69x9oD4OSunuHM8DIgtHukkZbh9erojMbAigAJT9xtKze0T8WJXRjpu7Wo1O5yovYjBBJt+H+fXjErBwFODsSHr/8UOkc5ACPIdJeYrMGcvSlZv2C6z+EapPHMgCQzrtwT5jGD0C1/nZRdQ9FYp0LZwot3sIUX32Z4DCcseH6TQGD84iqDevMmHb8KlL2iLSIEcn7QR12UuCCM83bBt04MW5x3hAfELZ1YegGvyk/G5Gn8Lk7lgTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/ZXLQ5fG/4QoOnbwzIVzIZl6CSu6jWD28FLcitRGJc=;
 b=URJ4WDNwLX9TTlBkJycQ3XI0JzoKo0nxBENEmmHlicmdT4cW2A5Z3Sm0V/CAlGSsca3iGYQffUX0nZUolULZX2A+YnqVM9tFqyH987KstxkgPBzAxsR0yiRjG2gR7ZTpfzgTr9Hs/hpWEBXMpq/hW4P6JTncJ4Uxr3zJcXnem4eb912XVOz87yJmYxCTldbuaycH8zduHDU43Sxyb6cqASvTjzNX321zV2Bo7iJB7VjeXsamWLieaADAwg4YwJll19Q++bwZPrIrOZmNblx/f2tqd3MdXE/odSb8C3kacqkKycQ03ktJRTe7XD+/vs3rTl7lC9G6Y8Q4ERpTw2z4vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/ZXLQ5fG/4QoOnbwzIVzIZl6CSu6jWD28FLcitRGJc=;
 b=1K08i1XWFR9jIMPQ8MOVLzgo5PuNuPgAwG/MCLAhIjeMa5Jbu2P306eIsv/xaki5LdcQSdPy/OwmJd5Uv5z6s479HasqKnp2B1TTDWPBZ88CXoK0nG2vuCDzKWpmJZTWJjbO1qV3XbYKM4oxqG/V1MLdppXa/ABiA1xuNXkSroE=
Received: from MWHPR15CA0043.namprd15.prod.outlook.com (2603:10b6:300:ad::29)
 by DM5PR12MB2422.namprd12.prod.outlook.com (2603:10b6:4:b9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Fri, 26 Jun
 2020 16:19:49 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::a7) by MWHPR15CA0043.outlook.office365.com
 (2603:10b6:300:ad::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Fri, 26 Jun 2020 16:19:48 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 16:19:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 26 Jun
 2020 11:19:47 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 26 Jun
 2020 11:19:47 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 26 Jun 2020 11:19:47 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/11] drm/amd/display: Initialize psr debug flags to 0
Date: Fri, 26 Jun 2020 12:18:37 -0400
Message-ID: <20200626161847.16000-2-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626161847.16000-1-eryk.brol@amd.com>
References: <20200626161847.16000-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(46966005)(2906002)(70206006)(6916009)(478600001)(2616005)(47076004)(86362001)(70586007)(336012)(5660300002)(6666004)(8936002)(4326008)(81166007)(426003)(8676002)(1076003)(83380400001)(44832011)(82310400002)(54906003)(82740400003)(316002)(186003)(26005)(36756003)(356005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1a9d913-e014-42de-d12f-08d819ecbf3d
X-MS-TrafficTypeDiagnostic: DM5PR12MB2422:
X-Microsoft-Antispam-PRVS: <DM5PR12MB242243AFE1BF0772908511A1E5930@DM5PR12MB2422.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A3/Lvd53uRhQybMa5CH8eoslNNTjkluEJ+Eh+kTmHB604k2/krkJTPRKNVWkbsFnCOwKM7ai+LEfUonq0OF9eimOEalPqYJpou+iqmw4tN9Yb3mrle6cODe6a21UZQohmtO+xK/53nOC6TinJ72+3sm974CUFHuUtYIs9TXuFudnkL0ap5kHTOV3Y94qqEuxeb69fclnAVyyp3u5+tOGhWgf9d9VKZfoPKgffVHV/+ZyxnOdy43JZKZO9y5BlKTEiMp3WkXdylunU3lpNBh8taN/iQbULrQjzXtoyrC0AkoYfZqc+Og4rhTLcA4Dzo+eqq1wz+kCA8lqouLdN2DhkL/TGbWavzsMxd4ZwDZcJ1q/c0M0Txa1uqYCspomt3WLBmxcY3psSR4BPg1NqlJCOg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 16:19:48.2771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a9d913-e014-42de-d12f-08d819ecbf3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2422
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
Cc: eryk.brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Wyatt Wood <wyatt.wood@amd.com>, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
Debug flags are not set by default.

[How]
Set debug flags to 0

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 916d305d3022..82e67bd81f2d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -234,6 +234,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	copy_settings_data->debug.bitfields.visual_confirm	= dc->dc->debug.visual_confirm == VISUAL_CONFIRM_PSR ?
 									true : false;
 	copy_settings_data->init_sdp_deadline			= psr_context->sdpTransmitLineNumDeadline;
+	copy_settings_data->debug.bitfields.use_hw_lock_mgr	= 0;
 
 	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
 	dc_dmub_srv_cmd_execute(dc->dmub_srv);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
