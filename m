Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DF4C2BA83
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 08:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14DEC20873
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 08:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bVGXE6d6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14DEC20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B124B6E0A2;
	Fri, 14 Feb 2020 08:25:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2A616E0A2
 for <amd-gfx@freedesktop.org>; Fri, 14 Feb 2020 08:25:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPm3CJEE5vYNjIcCrwp5F+d5fcvVXx1U2MQx+B3StI0nP67r9fRY0ETKIy/vxPdJsSbRKW4szPfmLurB+JfwsTFn66iwGuyMD6P2Mcue6we1zH4Le+30vd4tzM3gmTiyoBRIAG907JVMF/CIIhlm9vurJDgn4DpkVv68YteHCcQqd9IM4SxA7S62V14/u9ajzVySF/xjyqLU/2mUAAa6mPJzfBiJhrx+SUgdQhuFb0HMONgXrnGBZ1qgN/CpOhFaXClddav3WQNsydgJISszUgLoY+NWKSJykdvUDXbXEyiA35TfDaBGSX+0lk26QqY++aLoJ5NSdPZMwhdSh/8QMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiHm6ts5PuYWPASQq5ItPGJHIegAeQRLu8aRWoX/ZVc=;
 b=EnONKCYmZ43M25ASZVDsGOZddi3wcayWVJAJRoIHGmDYxK/1JtCcIsImpp32LzhRUURtz45s+ZWdfirAoHIFYSgVk004LKkH/iZCoTMZp0mrGgV8LA3cWQVs08cXXvHGelwUTWWIvQ5WVKD+mlZSby3EcPAE+cYJtjVRBFJBZd0MibN1PmsXTqhfGW/IUwaIFPtfzO1+OVqm2JDUd539ROU8QqrTB3OzyRtUKwd3+eGqIPRzcUT8T1KxsKIHG/WIEaRqP2ACSMJjMqNjr6t7L05YGl6yaL4ObUKqQzUOEL8c1fmXOyzH96fO+NovNG4Hphm2j8wpYadAY9QrJ4JA+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=freedesktop.org smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiHm6ts5PuYWPASQq5ItPGJHIegAeQRLu8aRWoX/ZVc=;
 b=bVGXE6d63kTYYHr4ZgKf2dDeS0PfZAKj/42v3DtIoOC81oZh68UynEsU8hc0UyrV8C0Sm+5TPWZw9i3Bamy4iHqtw0XdRY3Gqqsirx59vSH+omu2kopSvlBLNxpO28WbZMC3TFhmoUuHsjj+6WrQ0+zejIY+w5CVyGFcrbgpqOs=
Received: from CH2PR12CA0019.namprd12.prod.outlook.com (2603:10b6:610:57::29)
 by MWHPR12MB1198.namprd12.prod.outlook.com (2603:10b6:300:d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Fri, 14 Feb
 2020 08:25:14 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::209) by CH2PR12CA0019.outlook.office365.com
 (2603:10b6:610:57::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend
 Transport; Fri, 14 Feb 2020 08:25:14 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; freedesktop.org; dkim=none (message not signed)
 header.d=none;freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2729.22 via Frontend Transport; Fri, 14 Feb 2020 08:25:14 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 14 Feb
 2020 02:25:13 -0600
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 14 Feb 2020 02:25:12 -0600
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@freedesktop.org>
Subject: [PATCH] avoid to use NULL pointer
Date: Fri, 14 Feb 2020 16:25:02 +0800
Message-ID: <1581668702-7121-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(396003)(346002)(376002)(428003)(199004)(189003)(316002)(6916009)(2616005)(2906002)(4744005)(7696005)(426003)(8676002)(86362001)(81156014)(81166006)(8936002)(336012)(5660300002)(70206006)(70586007)(186003)(4326008)(6666004)(356004)(36756003)(478600001)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1198; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9326f846-2900-4e63-b814-08d7b1276a4a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1198:
X-Microsoft-Antispam-PRVS: <MWHPR12MB11987AA2004C5C22BA119CE484150@MWHPR12MB1198.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 03137AC81E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PkgAkNSHAZ9OMop6QMNVrr5DnPnfBMUnsz+cvcrOyL1ZxOzkmZXzRzYYGa52pb1BDZUDzbJLrjozqenFQ/G++ATYCojxJWz0UIbzbyfXzPQsgZTGgkAnD0CmmvJVR5leXDm2QQEeP2ItRVscujk/Ni10Ua7DHhzdwm9K4ztoYr9mY/TDzcp70ajCRbPwQPW/hiRsH13mDwp1Kcl7BOk9kNmOtLJoTsgCYhUVXWLTdMZkixqvoDdV0nxAm2m8wNjUOY8Q+j2kJhCjxv91cS1kPPfdaaK+a+w2GzkpfT0RjFI0Tnz07qgDzPJ6UN/0ffJ65R6oPOC4EsMrq8uHIY4UYMH/4vhvrRJXscQgNJWBasrkTCv7mtAKCDEXDAWsyN2VYoXAlpJaPHOa6oyGoeKwcUyE5GatL72WzgRzsdm+rUa1bueywKpHJoodoM05fN5A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 08:25:14.0916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9326f846-2900-4e63-b814-08d7b1276a4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1198
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 src/lib/umr_read_pm4_stream.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/lib/umr_read_pm4_stream.c b/src/lib/umr_read_pm4_stream.c
index 60bea49..317b638 100644
--- a/src/lib/umr_read_pm4_stream.c
+++ b/src/lib/umr_read_pm4_stream.c
@@ -325,6 +325,9 @@ int umr_pm4_decode_ring_is_halted(struct umr_asic *asic, char *ringname)
 	// since the kernel returned values might be unwrapped.
 	for (n = 0; n < 100; n++) {
 		ringdata = umr_read_ring_data(asic, ringname, &ringsize);
+		if (!ringdata)
+			return 1;
+
 		ringsize /= 4;
 		ringdata[0] %= ringsize;
 		ringdata[1] %= ringsize;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
