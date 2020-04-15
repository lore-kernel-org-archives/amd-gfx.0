Return-Path: <SRS0=+yFv=57=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C594C2BA19
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 11:21:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23ACF20575
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 11:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vcCaGQR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23ACF20575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C65436E96C;
	Wed, 15 Apr 2020 11:21:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89FDF6E96C
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2020 11:21:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNUqNnu2vQl5IVDI2R4nVzmXmhpnvH/Wl+x8h3HmUgpgieIf8zLZAcvcbQnZO+cF0J0TaW/taIWuW3FBm2gtl3VsDAMTNghyHYG3D7glmTQBvzItKSWHlyl6YgMWDwImFFY+MKEO5f70M2vohbj5hK0JmsQWnEnS0ZFu7NBf83A9+rYGfiymlgaitKYAC8pvm1HFUDCbHDBXjFMFlP2RikbnCZ22zhq/kTcbZf5nEauT901MSHByEItEbtov6PK452Tgf5UeqF8mJrtVvGampOHudtvuugB6SAD6axOYt1x1oUre3UUJ5e6sbkjxyvqbw3zFPYn6P8dQ5atLebOlUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+l9cKYTCOQqzJtQ2n/95y13Uk94D1C5eyg+ucYntzY=;
 b=KDdoN++EI5GZwq8yVFmt9AaCgH4xKu8lfEdsCHmQA5FbdIYr5sUtLDZHe9A75KxNWJtdFiqf/C0SIHVXxAvRRSWF1Ote+jes0lkJWYgFcBvlmFI/OCuud+ttTIZgzDX/KG907UTrpLD6qLzWJuFLlvfm5h1uFLUZTb9Wm56out0nc6+CBqz8Hge6Wh76tiuyaHsm/AlMBe96QwP4hHCWFJshuxx3a5O5w0axo4Xoq5KRi4Oh5B7WPvlB/7UJiDkas8iH1V2hqa89Kz7O5hIVI7zlP8y2U68L5T5umrGp+wwni62vo9/EGkbb9XVEIhrpS37T/ZGLQHKZ5Fx8HBFGfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+l9cKYTCOQqzJtQ2n/95y13Uk94D1C5eyg+ucYntzY=;
 b=vcCaGQR8X6JvCDiiTT01ci43RP0Ba5O2Yjet4kLjYF505oNE5dYifD0nCrKQZuacIfxzQevnTk5jQLIxGzRdSKqZ/b5Q3IVljuvhvqNoRvC43qmsTKWtId2x34tsVye1GHkc4HElKDOhv/rZ3odaR8gmyY5t9OKXQCvB+aln2PE=
Received: from BN8PR15CA0061.namprd15.prod.outlook.com (2603:10b6:408:80::38)
 by BL0PR12MB2388.namprd12.prod.outlook.com (2603:10b6:207:4a::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Wed, 15 Apr
 2020 11:20:58 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::36) by BN8PR15CA0061.outlook.office365.com
 (2603:10b6:408:80::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17 via Frontend
 Transport; Wed, 15 Apr 2020 11:20:58 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2921.25 via Frontend Transport; Wed, 15 Apr 2020 11:20:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 15 Apr
 2020 06:20:57 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 15 Apr
 2020 06:20:57 -0500
Received: from jenkins.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 15 Apr 2020 06:20:56 -0500
From: Yuxian Dai <Yuxian.Dai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/powerplay:avoid to show invalid DPM table info
Date: Wed, 15 Apr 2020 19:20:31 +0800
Message-ID: <20200415112031.9950-1-Yuxian.Dai@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(39860400002)(396003)(428003)(46966005)(426003)(2616005)(356005)(70586007)(70206006)(81166007)(8676002)(6916009)(1076003)(4744005)(81156014)(6666004)(5660300002)(186003)(82740400003)(336012)(4326008)(2906002)(86362001)(478600001)(8936002)(26005)(316002)(7696005)(47076004)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a5b1df9-7639-4322-1b8a-08d7e12f124e
X-MS-TrafficTypeDiagnostic: BL0PR12MB2388:
X-Microsoft-Antispam-PRVS: <BL0PR12MB238838E7055937E8817A88CB8DDB0@BL0PR12MB2388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-Forefront-PRVS: 0374433C81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LyBmG4RRcmkJXKvbpjwlZQzYb2SElGuzDciUFi1dgecVCpgeur/MkJrsTiMmU2dpOt7zDxjWVFyN9jst1+RZGaiLMRmW4nD+sRI0U/FWyD9ndzD3YtGmHtkzN3HFeTtQSyDK7PsOAl2J3bqfjAR/a9L1GApCKH7fmCMSCAz7adkpS4XjAVfdUct1TZx9PfUM+5O9L7hDfP/A8doQEW/HfMKqkfouL7sPjcsm9w1Hanyh3FE0HknGXJ/PoQ0iCpvW4QNJnzhQfm3f+Vw7HF3dzYsnWE6gAfpwK2/J5OjRbAlMWD7asFuetQhW7vRxqDXC4DNIpiI80KYusN6I26U1wBKe4Fep9OWgpEgu/2cS7fM30rySVc9+TC+hi09ldnNI1kLrxXm5ii02TZLgZhDEnjaMVInx6SnjMURF1qrjPXmx9Ax+S1670DN5cSe9M30KhkG3t7A1LpK9fktUTVEhnc76LX3iXVog99aRpSLhLBbu70aTW8f3Q5Vv20JEUZmYbWQvZ4zJ21zkiCFeTdqD1g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2020 11:20:58.2606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5b1df9-7639-4322-1b8a-08d7e12f124e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2388
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
Cc: Yuxian Dai <Yuxian.Dai@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

we should avoid to show the invalid level value when the
DPM_LEVELS supported number changed

Signed-off-by: Yuxian Dai <Yuxian.Dai@amd.com>
Change-Id: Ib66d0cf34a866fa6f0cedd1d5fc642f59236787d
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 281b7b6cf1a4..e4e7a352d032 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -296,6 +296,8 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 
 	for (i = 0; i < count; i++) {
 		GET_DPM_CUR_FREQ(clk_table, clk_type, i, value);
+		if (!value)
+			continue;
 		size += sprintf(buf + size, "%d: %uMhz %s\n", i, value,
 				cur_value == value ? "*" : "");
 		if (cur_value == value)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
