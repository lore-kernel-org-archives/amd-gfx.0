Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B8CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Mar 2022 21:50:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B37210E211;
	Fri, 18 Mar 2022 21:50:07 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2069.outbound.protection.outlook.com [40.107.100.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C85610E211
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 21:50:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkI3vPnLBdiaTatsNeDqia38Z6KEpkfN/qcNwcdpGUL7t2NpdBYd7lqYZUBW5N4kUprmRSVdopuS/UXtRDkSBYbb7qus7lCPKLYahguyEf5/1aaYv4Af29DN/yxJdXDleT87Xp+OKtMOw0u8jEIiTV6eXIy2XLzUxfKkrk7B81HZ9yRfbYCHwj4xv//Ss0TIA1cRQrfFW88nt5rvNRazNKDJN7VIOQxgf9mDt0kNIWf/PfZ8lG2SKnQagj00LVa1U0mQHa31cUOfIYUj686YdaE6ij9+wgjPSNFRAgahWVwSsg8DQvbN3uaKPUZMyogbUNkiXdFnLRk6jDII/T4eRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mvl0GR5nAorwH0zUQRLAZr9EgcQGBo7HHcYQ0h6C8h0=;
 b=Y5SJRArgVyZ76H59wYf41kFxVuB5Ri5n5mpMfr+c+KLh+0QQE7SoEKmffrZ+BHCYtyIyPFLdYkO4GouAxgfNakP3fq5/Kn2AYjjg0DtcnTpXinQR7zpBoeNG6mEPEwMlcYhRXf3B2p8CbvgBuP3ETqyg9qa5B/UjEj8AmPVC+Z/yjH7+ShHCs19scBG6nCbJERMMdlF3MPS9SbNyJ2Q8NXY98P8B1TuWkHGoIRzHrDXJjg1R7WXWc+6AKgO1SK85t7c3IUdD4E30PIPRZH5U216Tj3gTa4CP2ldUfRSbjZnCjIoQMDKLeAW2gDat6Q8aRT16MBrqcwwfAyOeNw6MhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mvl0GR5nAorwH0zUQRLAZr9EgcQGBo7HHcYQ0h6C8h0=;
 b=gJYpZgd0lKKJu6xtZufChwNc6WJrjs8B/PUifjD6FlQhv7hqAF/Sbf1c2XZkyY/aiq1EbwpPZK/tY0b4IN642mnTs2go5CJUhId4I0oy1lK0hm73Ni7ZEb2/2Wmbc1fwD5p9pxMmUtmBX/iblcB92tAZqBWzOjtDsh9IU890S/Y=
Received: from BN9P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::23)
 by DM5PR1201MB0091.namprd12.prod.outlook.com (2603:10b6:4:57::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 21:50:02 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::81) by BN9P220CA0018.outlook.office365.com
 (2603:10b6:408:13e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18 via Frontend
 Transport; Fri, 18 Mar 2022 21:50:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Fri, 18 Mar 2022 21:50:02 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 18 Mar
 2022 16:50:00 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/13] drm/amd/display: 3.2.178
Date: Fri, 18 Mar 2022 15:47:55 -0600
Message-ID: <20220318214800.3565679-9-alex.hung@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220318214800.3565679-1-alex.hung@amd.com>
References: <20220318214800.3565679-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29a5cd9a-90bc-4006-c9e8-08da0929419d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0091:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00912925B069D4154024FDBAF7139@DM5PR1201MB0091.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6DI6lRZPuUbIxOf2l5R/vGM1xvULTQ4CGH+w0htgakJHfm+ebVwjd/MY8mrTQTxiIU/Z8Cbe9Z+3sWSPqPNZoPFH1iqfl3+exMLxaoHmxPWwEVSL3TfiL1QwvchWIbUJvtIoUUcHpctfqq6qnE4YMjyvomFJlcSOe7kGU01X89NXN/gu7tmEVaWQxrud/LDALp19zdDtHE9FijnB5ilnTNsM5yR7j7/Ox6fivFq7NuN51g1kTbnoNYTRBvYj5f2B2kjdw8nRdJ7Jr13/pENAqdNndxByL5uNXJSgMYHzDvnpHmWhQjU6s7CwOj9bptUgCAXCPdHbT5tYrdWIYXvUmlPtWZHrFNycgV4HWy2TOV7jOq99IVMcecbZd3olrqKdARc6SHR7HbrgPWGVyikcEW9KubsBkED8CVxK07VMjEBCQrlwkNlPJt37reZtXmG9Ye0xUXCiGVa3bmb1oNEd7I/if7k2NkDJzxf1G0pdxiSWLWOLm5D8ZE0WrJFGvBLCywrw+mI/RXxIC76VRy8HwSz+wZHFk/seE6BPQ5MebBSWDwCxJhaE6WeLR/ZvQt5Utl3eThb3778ciFlaucg8MBNWVGhwpFNrievHpv9oAHzMK/PwTQE34Uq0UrUydzsayLbYKyRzWhMBI+nkvronw+brS73OCuwyoNgCUfLjDThpamwHDu6NgLlYTEGx3/+4ZRidPgMZwLb1sFxgizvFRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(54906003)(316002)(6916009)(8676002)(81166007)(356005)(4326008)(47076005)(70586007)(36756003)(36860700001)(70206006)(86362001)(44832011)(5660300002)(7696005)(508600001)(4744005)(83380400001)(6666004)(2906002)(8936002)(1076003)(82310400004)(2616005)(16526019)(26005)(186003)(40460700003)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 21:50:02.4734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a5cd9a-90bc-4006-c9e8-08da0929419d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0091
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- HDCP SEND AKI INIT error
- fix audio format not updated after edid updated
- Reduce stack size
- FEC check in timing validation
- Add fSMC_MSG_SetDtbClk support
- Update VTEM Infopacket definition
- [FW Promotion] Release 0.0.109.0

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4ffab7bb1098..116967b96b01 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.177"
+#define DC_VER "3.2.178"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.35.1

