Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC826C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 12:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 792422220D
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 12:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VGrs3DVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792422220D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37AE36E370;
	Tue, 14 Jul 2020 12:06:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 289D76E370
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 12:06:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9XyKWGSk9RwGFwo6mkJzG+4sV/wPyagaMZdz1FB2XaWf6gfgCA1qDa6Rz0mjEtPX1wTMVcXlbnCogoE+Iv7R2Jlin8XMDED7yVUFW4q40cy/IT9/YsaDajWVuK7EFqv+WHTJfbsR4yhoGRila2eTKELIhA5HOATeJMauVBYsRSQY42LTHOiYqAzBULSt0ey2RwVTMRgjkvkJtij1KZqWUV7fF9sP0A7lXFoZqJoFMua4dPh3WCD9ggi9Eng0VXmnPh19gRYglyRli82CzE7MPNsYgu4pkmbLzUzB4nDGi1RxHdLwyvRw+jgW1xeLeU1jil7wccdJMSQjxnc1cND8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUBlsYG17luIaYpQ407R9BqIFpWG32ExIu1zpn9UT3Y=;
 b=jRY7l+oIECgvv0KvypcZeYuatxlhYHEPUHZE19WfFi4IsWcMZa1A043St4eqLWUcwHMfEcpFpGD1qXYgYPm0pv7z/w+qlerfkvXvmDhb93XCTu2IqZz+/JbjCOldSfUYFG+jUOGW1aCPLwdkviRUuz/Nr6wjFtSaH3bs0gB5oBK5sVOeb5knIjYtFpkMW3FXpw/EkvF9aacXqjN57cosRN+8sJivkjdewxhxps4EDjHBhTsvnF8drwLProkUZaZmN3Pkr0yRsdUyzzdc2wLXxzM+y76TTgNYVgnbbvqoy4XkymwpVGnyDeJo1CYIbHJYcl4cfQZUp6N4aba2/+lYPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUBlsYG17luIaYpQ407R9BqIFpWG32ExIu1zpn9UT3Y=;
 b=VGrs3DVorw+wDNMRfhwXIjz6UTt708eMyPF0nXz5EnWPeNe+hfHIax7kqQuSTQtI1q8lmvvYijc6l/yw71voKJdxgC3oz5lgtAg+MFTzcHyHh5/LxeUKbztwn6RHPUhmWAAVU70p2MyPbJORKYyzdXC2m3WyecXqWhPdqtIPcHY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4214.namprd12.prod.outlook.com (2603:10b6:610:aa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 12:06:24 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1%9]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 12:06:24 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Fix compilation error on dcn3
Date: Tue, 14 Jul 2020 08:06:02 -0400
Message-Id: <20200714120602.916527-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: YTXPR0101CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::43) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:8440::b10e) by
 YTXPR0101CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Tue, 14 Jul 2020 12:06:23 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:8440::b10e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 860cc0cd-350c-48d7-e04f-08d827ee53e3
X-MS-TrafficTypeDiagnostic: CH2PR12MB4214:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB421416873CDD44296605F16998610@CH2PR12MB4214.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:337;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ub/xRC7PHNDdAHiuNa1pnWLTX92aDkbV+2XxnWKVpYBXnLPK0WswBUx2DzYPOOWj2wBr+jumiiYIoT+mzsV1ssOoUTni21rc+sb46z4sZ8bYaUGBg/lWICLwRftgS56XXK5EzlLBw22862DVwHoq2/Xh8jSGRejGxk6ZGnOqxUH18M502kLOUN85vm/hLr1CtneNR4wdZJqN6SJLCJVz1JtKfH8DQSjfl2ayPa36qc8o4EvhO8+XDEvmLjymj6bLDHgIQp2/l+JR5Igsz2oFtkHlaK1Px99vpwIVypBVrZHJ7zRDUe/za/ShD+dfuj1Hp93zc5Uq568+FOrcjkyueg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(54906003)(4326008)(6916009)(83380400001)(316002)(6512007)(6666004)(5660300002)(6486002)(36756003)(2616005)(1076003)(66946007)(8936002)(66476007)(66556008)(8676002)(2906002)(478600001)(6506007)(86362001)(16526019)(186003)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: W/Rgmb0jULGON4EETEoKgCH1VstBo0ckFHnPiLqU+likAXDfXMz8425gXY44HfMnUesci3r3gtQycgGJ4QVERp6DyLgfKxmUle9DNfAoGDakoQbq2ltoVwCKqWRPqnCHe+/CP0fc8+X909rDCt72qhVL3xtiT2Yq+XtRK9PxYKDVL2Osb9cMWycGINg6OVvzDIexOCl7GLSQdyYKf3TbPw+/CwNJDeJLoeNrsY6zMk0S90euHKOkH6gLJtkRE/zKp89EgARbn+KQNZweJyzFPilMq7LozCj+BIHAl9ACSNhsPZxKU37rfKMGCPnpQORztmdke8CIc/VN9gyiFjB0W0s2rup2I5OENIGYEZPI2GI4Kmz2If/w7VEI/1mhN0FsNMMxFfam+Kp3TqtzXeC122aS1ZJfuUEzvTAEoq7juawpKyybYLix2/RnVDm0QEhIwuTGXGRFQJl5DxId5uAzIaQka1egvpoastd3O9/duTbZGlP1RX6zAdJhoMeL0XAHaeJFtwHHNgbpz/Gf5Cl/7g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 860cc0cd-350c-48d7-e04f-08d827ee53e3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4198.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 12:06:23.8417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQ6ws2skb0XJMsugynzGHtIrYy4tUNfkvjSFgyHlShjazl0ujBBRFat39nNdFpoS/Yaq0qqrSp31YZr1DE+Hnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4214
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
Cc: Leo Li <sunpeng.li@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Rui Teng <rui.teng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We have a compilation error when compiling dcn30_resource.c due to a
missing field in _vcs_dpi_soc_bounding_box_st. This commit fixes this
issue by introducing the required field and include file.

Cc: Rui Teng <rui.teng@amd.com>
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index 0fac7f754604..6ab74640c0da 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -24,6 +24,7 @@
  */
 
 #include "dc_features.h"
+#include "display_mode_enums.h"
 
 #ifndef __DISPLAY_MODE_STRUCTS_H__
 #define __DISPLAY_MODE_STRUCTS_H__
@@ -120,6 +121,7 @@ struct _vcs_dpi_soc_bounding_box_st {
 	double urgent_latency_adjustment_fabric_clock_reference_mhz;
 	bool disable_dram_clock_change_vactive_support;
 	bool allow_dram_clock_one_display_vactive;
+	enum self_refresh_affinity allow_dram_self_refresh_or_dram_clock_change_in_vblank;
 };
 
 struct _vcs_dpi_ip_params_st {
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
