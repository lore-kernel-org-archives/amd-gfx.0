Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A467C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 17:28:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C76CD24655
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 17:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X9zHXYoP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76CD24655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CA906E1BC;
	Tue, 17 Dec 2019 17:28:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50E056E1B9
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 17:28:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRN7tPXfK7oql1J7waflDbU0Cnt9tFgjuKUiG7YPNVNaxowwGC20lIOnT8O6IsySsrbPzB149L9K8CWqq4/9PAUQ6qCeZb1H2Ip0cx7BDdAHhkmy0Ozq6wW0dnQ6Of2t3eGAtYWsM8T03ezsQQCU3eQWMUqJ+Q0VoEzAsdWptgtBIzcTK2st4Nv4Cpj2QNoq5qx8zE8+xfRupFaGfq9PoO18cIKD56YyhCONvPGNZmcubYM4lE0164rfbLRpr3XXV2FQFwz7Q3gEaWUyYBWtmlBea5lVOlBizN8srQdkt1l5Wbu8PYa7StQq+/h53aWJXDlt20qwuYKcez6Q45nCZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HE4H4Ola0yiD+DQKFNRdyIQ8Ui/arzZ2w+cRi/LS8HA=;
 b=A6atuifjPHNMzKn5d8asEMQCRAzU3FHH+M6poxpPRwAZfcn8/BJvkk/4SNU7AtQqWQPW3K2ScLL7Z6ImjWVkfws7vri9K/ggjYfDeWkv1gUhw98psJhXSRc8nXI7T1WH6WYG++g1CpYlqT49YE0JKf7wZOXRzUb0R1005OxAjkoyk6wdSjDdXm/v8y+zrtiHwrUqmVXqlu8N36QN3ieMUsuxS6JwKN1xhXrfWAG0V7/JEzEWQHuLHUjpkhTsS/AKreeUdYavmZvInWzNwxTKP/uKOjGQqhFYlDUAXHlkAUTimM2/8GLFhsYUQopa1N2782wwx8U7BVUmj/SAlbGaaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HE4H4Ola0yiD+DQKFNRdyIQ8Ui/arzZ2w+cRi/LS8HA=;
 b=X9zHXYoPhWmpUZSGHc+ucga2EH+2XcrI/HHJ5tN0KOIEoUzeS2e8OrWr2QIKbzd+BVTiWo3RtkOSMgRXA8WuUKKm/kljR3l0cXWiojpd63M2Z21A7v1oPi8DijJh0D1slUtIkzvB2Ox6bkq2bJlLvlsEpc/oja++dDsbSh40wyY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jonathan.Kim@amd.com; 
Received: from CH2PR12MB3831.namprd12.prod.outlook.com (52.132.245.141) by
 CH2PR12MB3941.namprd12.prod.outlook.com (52.132.245.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Tue, 17 Dec 2019 17:28:52 +0000
Received: from CH2PR12MB3831.namprd12.prod.outlook.com
 ([fe80::adcc:f57d:89f5:279f]) by CH2PR12MB3831.namprd12.prod.outlook.com
 ([fe80::adcc:f57d:89f5:279f%5]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 17:28:51 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: add perfmons accessible during df c-states
Date: Tue, 17 Dec 2019 12:28:11 -0500
Message-Id: <20191217172812.128736-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0068.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::45) To CH2PR12MB3831.namprd12.prod.outlook.com
 (2603:10b6:610:29::13)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fc4f9bcd-54ff-4f2e-2812-08d783169576
X-MS-TrafficTypeDiagnostic: CH2PR12MB3941:|CH2PR12MB3941:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB394182F18778027EDB9C42D085500@CH2PR12MB3941.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 02543CD7CD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(189003)(199004)(6486002)(8936002)(2906002)(316002)(81166006)(81156014)(8676002)(52116002)(1076003)(66946007)(66556008)(66476007)(44832011)(5660300002)(4326008)(36756003)(6512007)(478600001)(19627235002)(186003)(86362001)(26005)(54906003)(6506007)(6916009)(6666004)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3941;
 H:CH2PR12MB3831.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C9WGnohbrnRXW3JfR8Fli00FZLMW54FhsTUj9IhhLeBgGpbCLghJDZW03YwGq9iNohppeh2GRFtewhjx35J+umkyVprGiuHwHYjQ4RrIajZ6XXWRz+UwLVsrL3aoBfvIp/+2+EhRPptiuvxy2sMbJMXF5GxYJyeki2+uGhJw4mR08aGOViGflJSywq7zMVip7IC2yQGd81FZKjek0Ge2R+Sr3W9jd0b5ky/DaDDOHvKRkgSZ9OlFuKEQcupv3U20Z1vyiN0Kda8e0uzCqrz7xNydvH/LJdfMtpa8gvYp9FIWW7Hb6zbb1fuKIWd+OPcgzVRynY/JBjTmzcnD9M0Gfehw59fawA0AygT+9yeTO4ClNt/NmSZWgWSP80p1WsNjPPKAktaUzEESIG7q4cCT/8KrnWkFG5hAIDRDQKp/ViAnX1pm4KNqzXunMQcEVSyk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4f9bcd-54ff-4f2e-2812-08d783169576
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2019 17:28:51.8641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8MUcdJe2ThSAGNeZ/uo9G8lxmcv9KNyFaUUHMMnivKRMxQ7WdYkFhQ8RXD7TQ4B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3941
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
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 Jonathan Kim <Jonathan.Kim@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

During DF C-State, Perfmon counters outside of range 1D700-1D7FF will
encounter SLVERR affecting xGMI performance monitoring.  PerfmonCtr[7:4]
is being added to avoid SLVERR during read since it falls within this
range.  PerfmonCtl[7:4] is being added in order to arm PerfmonCtr[7:4].
Since PerfmonCtl[7:4] exists outside of range 1D700-1D7FF, DF routines
will be enabled to opportunistically re-arm PerfmonCtl[7:4] on retry
after SLVERR.

Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
Acked-by: Alex Deucher <Alexander.Deucher@amd.com>
---
 .../drm/amd/include/asic_reg/df/df_3_6_offset.h  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_offset.h b/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_offset.h
index c2bd25589e84..f301e5fe2109 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_offset.h
@@ -38,6 +38,14 @@
 #define smnPerfMonCtlHi2					0x01d464UL
 #define smnPerfMonCtlLo3					0x01d470UL
 #define smnPerfMonCtlHi3					0x01d474UL
+#define smnPerfMonCtlLo4					0x01d880UL
+#define smnPerfMonCtlHi4					0x01d884UL
+#define smnPerfMonCtlLo5					0x01d888UL
+#define smnPerfMonCtlHi5					0x01d88cUL
+#define smnPerfMonCtlLo6					0x01d890UL
+#define smnPerfMonCtlHi6					0x01d894UL
+#define smnPerfMonCtlLo7					0x01d898UL
+#define smnPerfMonCtlHi7					0x01d89cUL
 
 #define smnPerfMonCtrLo0					0x01d448UL
 #define smnPerfMonCtrHi0					0x01d44cUL
@@ -47,6 +55,14 @@
 #define smnPerfMonCtrHi2					0x01d46cUL
 #define smnPerfMonCtrLo3					0x01d478UL
 #define smnPerfMonCtrHi3					0x01d47cUL
+#define smnPerfMonCtrLo4					0x01d790UL
+#define smnPerfMonCtrHi4					0x01d794UL
+#define smnPerfMonCtrLo5					0x01d798UL
+#define smnPerfMonCtrHi5					0x01d79cUL
+#define smnPerfMonCtrLo6					0x01d7a0UL
+#define smnPerfMonCtrHi6					0x01d7a4UL
+#define smnPerfMonCtrLo7					0x01d7a8UL
+#define smnPerfMonCtrHi7					0x01d7acUL
 
 #define smnDF_PIE_AON_FabricIndirectConfigAccessAddress3	0x1d05cUL
 #define smnDF_PIE_AON_FabricIndirectConfigAccessDataLo3		0x1d098UL
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
