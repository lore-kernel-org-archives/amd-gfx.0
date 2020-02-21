Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E060C35646
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2378C2067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hhK6ygol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2378C2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEF1B6F4AA;
	Fri, 21 Feb 2020 16:04:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 154AA6F4AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:04:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gD9haiZUBqFu518SjaQ4Ra+4cselZ+PDWeFRk1aMU0EYirYe9gi6ALkosgICWcen85BZHLcDpHg+C8TN4hbL+ahXyfLPMcluDNhpgwA4QMU7DKXj6HTkDye2SMT84+KzZVr7iIe/924dGUwwthOBtiezntmmrq2IfMyYKWlm1BlMrIpPZSowMCtjEmVQogqwgHxcUuTXAygc1dVhPE1VUqLc48773k9Lu6pi1+phuhq9cLdcnW1pgXQSdvC5fk/xNcSgmXvS/d+4cI7luoglj9cjyIEyx+6yC2oYD50OfUsZHYcTEKjKkJN6rWmKRupxKDxIfgZYVYKZhPpn7zTphw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueoSmq1gKJP7V87qeNvmbzetdTw24z+PXaez3t+LWHI=;
 b=mfSeKH4y1XG85Su9VBUcZ5ospDF8fPGN22AeclIPBvVWmRNlThidsxtbobfVzCaarFH753B0OXfBO3GmyMHJigXhrYAp51PUBgtNuqMi1cSkVNCe35LZx4XChhnAq7Qpjn1yYfNuQwj+zGLGslaCFa22pGgTRqewWLBZ8he5HL6faX24r80reI4WxdJyeoFayz2N5C9vTFs+cPE9KsEUUvZDolP8T6ojLdqWRlLZwdQfWubzOIZQZzpTzy915rktfdjJDppKLciEzivLiILEUtHt3uHEe0P5e+4J0npq3FElBweNMiuTWQ5hoUUUg3gZyewAo1R4Iz5OO1ueq0J/Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueoSmq1gKJP7V87qeNvmbzetdTw24z+PXaez3t+LWHI=;
 b=hhK6ygolwSQU0dH9oH6srC+Iu/cek6x05hON9WuylBDzEoh07J7jHHIJ2WjTKMxlkDSKVttdQZSJN3QMXcZeJ0so3crNwUBT8qFjinppQOpiLr81TgAWNIvVi9uMYpgV6BT91eJbhcbsf/rtkpfI4GgtZM3C+25D4j0gHWf5nRI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:04:50 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:04:50 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 32/35] drm/amd/display: Make clock table struct more accessible
Date: Fri, 21 Feb 2020 11:03:21 -0500
Message-Id: <20200221160324.2969975-33-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:04:14 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e86ae090-1d2b-49c2-809c-08d7b6e7b2b3
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2572EEA128B2154FB5C714FA98120@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(1076003)(5660300002)(36756003)(2906002)(8936002)(86362001)(8676002)(6486002)(81156014)(81166006)(7696005)(52116002)(4326008)(6666004)(316002)(186003)(26005)(6916009)(16526019)(54906003)(2616005)(66476007)(66556008)(66946007)(956004)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B80EjLjQ68y6+Z9LI9q5AKUE8Ey3VIxSgjVtMegaUw5VUYFonwIaSlm+C0y3dyCUDaYpwIKz1vuolD0AR8PwUy3mYJ0J9DY/VNvXqmM/zCbKV4Svo7oOJCVFXeBO68b+gZ4apln+IWqlKniOt+jBUJAJct+GJXbGLF8R9g/sks4fXt9Xh/JVwH4yExB7wLW3Gs/G4pbqdtar0hQAp0tF2qhrQzpVzcEku7p9wgv/wFK2WG1dtN1Uk6GjO31tfxw/atpV15uacNqNJ/IbwWHA3Y3JLKrhrIoAH3zToa7eLUZbDxrgJwp5ZAVD+vf6zgxN4kkUj8BSA8fBxFD2lTwG4BmVsh3bJG0iUhHcW33g/UZQSA216/WMN9APyW4Ceve1dznKaipUzYYLjgpGcl5b8wq03iA0ZpbhHWMEuX5zUbevTN2kchwHZjXmxjA1dqjB
X-MS-Exchange-AntiSpam-MessageData: /q1Gr52CB1OFhiw7sZEVICBt4sokD0Qyk3ERZj6mNp1s8fC5GVxGFMMatwXQW6rhINl2TQZ8Bx+ajgCoQ/LU7FA8hm8+5fGlxhfsRwnO02J77YHaD1zHoMc77Ix8aXV7K2RWTxm34lxIAudT7ph++w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86ae090-1d2b-49c2-809c-08d7b6e7b2b3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:04:14.9722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEmOc5zhVQu7iXRMgl/JcXpoIzwd68CitwmzGq800KVMsdZACvjA7XwBX9sQb7V5A2i4v2iNxy7ovPfgRGrGgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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
Cc: Sung Lee <sung.lee@amd.com>, Eric Yang <eric.yang2@amd.com>,
 Sunpeng.Li@amd.com, Harry Wentland <harry.wentland@amd.com>,
 Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY]
Currently clock table struct is very far down in the bounding box struct
making it hard to find while debugging, especially when using the
dal3dbgext.

[HOW]
Move it up so it is the first struct defined, and therefore much easier
to find and access.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index 114f861f7f3e..a56b611db15e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -68,6 +68,7 @@ struct _vcs_dpi_voltage_scaling_st {
 };
 
 struct _vcs_dpi_soc_bounding_box_st {
+	struct _vcs_dpi_voltage_scaling_st clock_limits[MAX_CLOCK_LIMIT_STATES];
 	double sr_exit_time_us;
 	double sr_enter_plus_exit_time_us;
 	double urgent_latency_us;
@@ -111,7 +112,6 @@ struct _vcs_dpi_soc_bounding_box_st {
 	double xfc_xbuf_latency_tolerance_us;
 	int use_urgent_burst_bw;
 	unsigned int num_states;
-	struct _vcs_dpi_voltage_scaling_st clock_limits[MAX_CLOCK_LIMIT_STATES];
 	double min_dcfclk;
 	bool do_urgent_latency_adjustment;
 	double urgent_latency_adjustment_fabric_clock_component_us;
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
