Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D88C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:54:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED10C6145B
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED10C6145B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B90D6ED7D;
	Thu, 29 Apr 2021 07:54:51 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760049.outbound.protection.outlook.com [40.107.76.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 867706ED7D
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 07:54:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eN7GKre2w0qxqxTmiRsHpJ5QE9dqb1n/Q4RPYSnUxwBOAVoeaPp/jk93MF4iw9gVxGnAK8BjAEuFiMIpEpueU3g2dnU1Uja4mO/SC5gByO2B3Yn+lDuwDMA76R++Fbc8txk/ilCyKWemd7RmA/RoNezeESh+2ezMKgvtwiePKetws1n3xspu/2vV8sIBPjXYtAK7xKvSLLo2j6AqhSSfLClWPcEsBrMs0BZLu3QsVbBaf/bIZby4S5IGWfD8sjBadwjgJPsmS2pQ2Iyus25yhAHoVAUz5GKsxIieBr8dvfQniMUqjG4M96+QGVx1QlSc9PqBgC8acxutJyJ+DGnrwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNZnVRlPQzN1jmMtap1b4Oa8l7srOA3BGScY0PZNuNw=;
 b=RLNxopPqfP2khRzUdf8wKpiZLWgPNh/El3WXgcqU+a3BiW99IHdhs8+RgZraUbMqoxz98PbZ7DgOPIo5DGE/8x7S7ot5ba6kmvvDhQhUqCs/LElxEacDL7Rzqr9fhe5XBSl0WjOvgybRLQO6S6HO+VA0HtCuW9Y3LhE/6nDO1PMiAD3J4/l73yFUnedIb/gf9zQgdDiLt8HYtglxxREd2uNqmSB+nWuS0KrTTT4qku2fjPPX0zEvB029BTQ5H/Yy4ZNJtgnbQb37NooIUB7tesAW5kXybFwZvQfa+GxsIfts3DqI7MBcb5dDxMDr2KYVxIJyZdPH5imdpfD496DxSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNZnVRlPQzN1jmMtap1b4Oa8l7srOA3BGScY0PZNuNw=;
 b=pg3NsuvrzWmiPep+xOr3GM4yfp37bgFpKp0dCT1jZ5E8aF3kzBRJeDvlQqyjAoWQFjTZmny6qBViyl8prY8B/giVRhmXL6W6RMz5UyxDzVM1AJ+weWC0h9EK//+5crtPb/1S4QAmvUQy8VPYnyHHFOIvD7VnCb71NE1IzPOANtg=
Received: from DM3PR12CA0123.namprd12.prod.outlook.com (2603:10b6:0:51::19) by
 CH0PR12MB5137.namprd12.prod.outlook.com (2603:10b6:610:bc::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.21; Thu, 29 Apr 2021 07:54:47 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::7a) by DM3PR12CA0123.outlook.office365.com
 (2603:10b6:0:51::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Thu, 29 Apr 2021 07:54:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 07:54:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 02:54:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 02:54:46 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 29 Apr 2021 02:54:43 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/14] drm/amd/display: Set stream_count to 0 when
 dc_resource_state_destruct.
Date: Thu, 29 Apr 2021 15:52:03 +0800
Message-ID: <20210429075206.15974-12-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429075206.15974-1-Wayne.Lin@amd.com>
References: <20210429075206.15974-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11289a94-1cb1-44a1-6703-08d90ae40f17
X-MS-TrafficTypeDiagnostic: CH0PR12MB5137:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5137B6193EA38450B920E379FC5F9@CH0PR12MB5137.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ACfY6RWc4F5CLCT1lcLzqVINAzuKrjK2nmbHeUFTAppXhGGrazbMlg5uZ7+QqmZ+tZdRn+kBXpxMO+l0TgY8rxp8jPFrPZTInblYngMyNtXgpCHKlAokK1HabF4475NAbBPFDC9r3ozDc0G8oW26ZETl1Ubw0LjenfU9O3OjuIwq5wtO3rYejLwqPfKM+wYxMDR9n2yGcNwcFuffhEe/yFJMeu6al5w8fIginRG+Cqnv2Ns91ywPwdihkF+mo8kqS8Y/woh+c8nstn42ohvcvwMrWNizyEZ6LvQ2o2JWIoWa2Tht9GiK6dnPHTZgZa3hAX0nPn48v2UtfObD2F4xl9cgXjsTGV0agvQouBsrvQmnuQdYCNNzICEwDfplBnMFaGfihfEHUPE9dMmFsH8dkjJvhf1AjhuSIyH4aNCtkSUABJ2Qi8OzZdm9Od1cJrU/U3v1WEt80X15JJP3ct/ACtlQ+loxPEQAu9PcY7H7wAdDe5g6W2mW4qEU2ZdoWFZhHuHEw5LTtbJv+llmnN+/bjobSL6MeB5d1+9VF+juhnL352TeL8CnFv//F+vXnPG42ZJuP94Y7QQlxnWJ0vn/eENbvj2kyqb0B4WKgeR4iNkALFXaKtVEWecOk8cAsm4TsPEkMZ3PVQAZmxidHnaQ1qB5r1fqbOxI4Q+0F5pq671C7Gpc+8v6Gg5ERKWZy628
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(36840700001)(46966006)(36860700001)(356005)(336012)(426003)(47076005)(70206006)(54906003)(5660300002)(8936002)(7696005)(478600001)(86362001)(4326008)(186003)(36756003)(82310400003)(6666004)(81166007)(6916009)(2616005)(2906002)(1076003)(8676002)(26005)(82740400003)(70586007)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:54:47.0669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11289a94-1cb1-44a1-6703-08d90ae40f17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5137
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Paul Wu <paul.wu@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Paul Wu <paul.wu@amd.com>

[Why]
When hardware need to be reset, driver need to reset stream objects but
dc_resource_state_destruct function omit resetting stream_count. It will
lead page fault if some logic will touch stream object.

[How]
Set stream_count to 0 when dc_resource_state_destruct.

Signed-off-by: Paul Wu <paul.wu@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 9fb0930f977b..f2bc630a0871 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2673,6 +2673,7 @@ void dc_resource_state_destruct(struct dc_state *context)
 		dc_stream_release(context->streams[i]);
 		context->streams[i] = NULL;
 	}
+	context->stream_count = 0;
 }
 
 void dc_resource_state_copy_construct(
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
