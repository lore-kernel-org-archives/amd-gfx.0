Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF5AC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:04:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B223650A0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B223650A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D850C6EC3B;
	Fri,  5 Mar 2021 20:04:14 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680069.outbound.protection.outlook.com [40.107.68.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EB2C6EC3B
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 20:04:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aH3h9zAOUvYg7yTHP5OXeO+mrtwO51eQd/0FWFS52vJxY2YaR53CgXrmCW/6FxSkd8bxhUrZDJ+czO5cGXNyONB2E42DZGqdui2zUIiqA6RHLoeeDaDqEycLuC+ZxbMXkPDPrdYHNr3zSUiaQZktsXHVSgEgLk+yQkXPOatveWahphK38O8X5EZ62NjxvlGJIlBaVjE5GeF33v+hj9e3kgrBMiac0740k8ujtrBnqX70KMQ345LEFDuQ9r+qg/QRBJzdMeFC09Gwn0wrnWvNhspc4P0z9IC5O8H1WSiQF63idE2gAl4BMKFRNJ/ruSDL5yX3qwxnx+121EnIRo4prQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQJMQt/u6Lgd/R+Uj8xwKJ4tLJn/iXO8gS4oUTY3KxY=;
 b=gT2gyC+Z9mw8eWxVGyTDU1UvbCaMj3p/bG86yVdrVp+l4omYFKX5uS7p3ER/BhNPAEWdnoJ/mCSFR1gAjGgwYmPbP7sflti5RZ9q34DqXvvgS492HzrTWs//HHJgolJWW8+6PGfuv6/3PjfDYvKEEdhBLn5yFo0LIb7eUCzBupwx450dOtrK11HI4vPfVLaRO3QZOOLl+8Hj/PlItR6yuH2CX2eHG8GC8ELvqcDdA4OPMwJsD0lSRvSLbN1svH4pQV7y3WAytP+APkVBJI34xjTUxpGM/8OFz/QlB7pf2XLRc5uZV7xgNHqfzwJpwGs3rOQcblmBTnRLIFsZFhOxGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQJMQt/u6Lgd/R+Uj8xwKJ4tLJn/iXO8gS4oUTY3KxY=;
 b=5AbexyT6ZWMlJVhAgtTNA0H2hpJnr9OeyTv4gTvk7hie0PtoIhCcXAsBuY3oSPKBRhm6IaaJHsRxcdCBuE48aBR/oYYwKQCuTQQGEx6caSdLGlkz8e63R8+P6z/DkWu6pjOEn2+k9ln+ZqjLUedgjnJBYdc7fCiVB2tZQzSBKCk=
Received: from MWHPR20CA0025.namprd20.prod.outlook.com (2603:10b6:300:ed::11)
 by BYAPR12MB2917.namprd12.prod.outlook.com (2603:10b6:a03:130::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 5 Mar
 2021 20:04:12 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::8f) by MWHPR20CA0025.outlook.office365.com
 (2603:10b6:300:ed::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 20:04:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 20:04:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 14:04:08 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 14:04:08 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 5 Mar 2021 14:04:02 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/14] drm/amd/display: Fix dmub trace event not update issue
Date: Fri, 5 Mar 2021 15:02:52 -0500
Message-ID: <20210305200301.17696-6-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305200301.17696-1-eryk.brol@amd.com>
References: <20210305200301.17696-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80baf523-691a-46a6-4cea-08d8e011d78d
X-MS-TrafficTypeDiagnostic: BYAPR12MB2917:
X-Microsoft-Antispam-PRVS: <BYAPR12MB29176DF9A1696DC4089B3585E5969@BYAPR12MB2917.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:302;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWaKBXD+2zXzMIuMEBJ8QWCdnCB9Z2zE2E1/rxoI+viBkIHRV1ZA8kEtNJlfV9Q2hL0genogaC7VlgfaE6rwEmN7oIh7d6970yIjShasna/XdGq8AqVamz45+ocytque9lJlgI8Obc0hvW11lLe2WmJ0H/rmlEaDoje769OL5izQ0nD6H2nZl18csHwGkuc5kQpvsfiPY0/2qfK4DRXWGGC1oyDe2sAEv0OQImVmGwCkYx9HZoJwpKwd6UT8aW0b4rFSehHKb58jh/YamyXMwz6SGg33AgDKMjIVqDEzYTDvwtijGBmtkHNacZsrGPy+nQlYbb+rPCAuxrhXVNsDUINxeY1R3f4sP3oG7xmI0AWr3DjBvtnscvST1jgFKzsV0NwH/3rOBJa+kVT4LW6P9H+3Up34aI+OVgjmFp4UoJHVa0TYvCu/Z9EvAcD+Z7vNvAMjJwo0wa3k7FY/WyLnaV9kO9fuvV4PDdenbpJwU/1B2EAt+NdUsHTpkgs+OlCJV5Jlh8sl8PAapUNcF98qLpG26lkuliXkLL6QlvKdnS0Y9xG/DJeS51I8NninEUZ+34Svfbo/t4nPMldUeUMBogS+QMQHLnT30zUH35RfwQsNhAR0KXdQfCaMjq02z3oPLvRjY/7v0tQPstSjPYPFtAmCqVOoKZ2MU7sdYCJuo04qOnS/h5uAi72T86OXh6ez
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966006)(36840700001)(478600001)(8936002)(70586007)(36756003)(316002)(8676002)(336012)(54906003)(86362001)(426003)(6666004)(81166007)(44832011)(36860700001)(82310400003)(5660300002)(6916009)(83380400001)(1076003)(26005)(82740400003)(2906002)(356005)(2616005)(47076005)(186003)(70206006)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 20:04:10.6863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80baf523-691a-46a6-4cea-08d8e011d78d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2917
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Yongqiang Sun <yongqiang.sun@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why & How]
Reference to read pointer which is incorrect.
Change to reference to write pointer.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 55ee27defd0f..2522492dcd42 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -722,7 +722,7 @@ enum dmub_status dmub_srv_cmd_with_reply_data(struct dmub_srv *dmub,
 static inline void dmub_rb_out_trace_buffer_front(struct dmub_rb *rb,
 				 void *entry)
 {
-	const uint64_t *src = (const uint64_t *)(rb->base_address) + rb->rptr / sizeof(uint64_t);
+	const uint64_t *src = (const uint64_t *)(rb->base_address) + rb->wrpt / sizeof(uint64_t);
 	uint64_t *dst = (uint64_t *)entry;
 	uint8_t i;
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
