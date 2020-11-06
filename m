Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09569C55178
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 23:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B46A8206A5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 23:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tr7iQrez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46A8206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E6F86EB5A;
	Fri,  6 Nov 2020 23:19:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89C8F6EB58
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 23:19:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqJs8+ps7fY888DPB1DXkf3WUkd6sK5rhi3YHZtt2cbQw5Es5qRwtNtWcaeuQ0cVzNayxhL0LWVSwC+GItipSRHhGVVx/DLkWvUyCaS+PIHaVq7sYEwO+A+BrrLE5xWVnv7z9dBCdA5B/nZgKerw/qbyONrSRB55I9XGXZnkdyuxsPC5YDU8u73h9krTtWb7HbVjkRCP/heT1tz4ex77Ynt5KJX/x61l4PgVeGrBfwy7xxPhuH899eITS4PT/6/vFghZm2VW8Lr3hm1miC0s0/DgAn3T5YVeqAE+ujwG6Zq4wfGJcMXIz+FUjYRHmI2up34izOw3RBj9Voa8i8+UlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rxq1bG+TlWDnzEinGX5mxx67Es9fd8e+9os9zHbrIc=;
 b=Z2bnYFor8BMd5o2YErScK6L95RJdJbAr5eTKO/t5RxbX2VHdhNw+H+yLiPKnQG7aTYBCAoBn5eQbXwkXZdNz2wpuASM2D1LXk6zBlKZ6YgFC5k8S4vxxGjTx3ZHzfW8vQOmR2s2EY3/iQ/HrX38FtJ5m16NcixdFXmd7/8798XnafAVyyfDpgaq+0ILSYjLK8vmKXYTyGV36fwuX8SBAiFpi0udYreI0CygJtikW7jzm2PWPiIw0DmbsqlklxJX7zGx3wLPxUZnGv8fUfVDfGYv4DemcpYtesi7OKVmfOrA5Vi0FbfORcOt8UQ5TKan+u7EHcScT9W6n0kqkZzks4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rxq1bG+TlWDnzEinGX5mxx67Es9fd8e+9os9zHbrIc=;
 b=tr7iQrezw48c/AgEBJS/HM8BLS8y1Hovj5sIdKGOqrpjB+VQoTjN30N7+3SNJl+3aJNHRNpFaaIYOE7w8YdWYT2H/NCJdm5lm+/04awQuvs9RL0CCuZzezSoznDGHyd0GJBJJeU5daqM6CZNmCVq3b5oatsZy0pbdhLXkO5Sryk=
Received: from CO2PR05CA0075.namprd05.prod.outlook.com (2603:10b6:102:2::43)
 by DM6PR12MB3209.namprd12.prod.outlook.com (2603:10b6:5:184::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 23:19:35 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::3e) by CO2PR05CA0075.outlook.office365.com
 (2603:10b6:102:2::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10 via Frontend
 Transport; Fri, 6 Nov 2020 23:19:34 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 6 Nov 2020 23:19:34 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 6 Nov 2020
 17:19:32 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 6 Nov 2020 17:19:31 -0600
From: Bindu R <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/14] drm/amd/display: [FW Promotion] Release 0.0.41
Date: Fri, 6 Nov 2020 18:17:07 -0500
Message-ID: <20201106231710.1290392-12-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106231710.1290392-1-bindu.r@amd.com>
References: <20201106231710.1290392-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87510069-d2eb-4449-5074-08d882aa6c4c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3209:
X-Microsoft-Antispam-PRVS: <DM6PR12MB320927034D013AB6D794300CF5ED0@DM6PR12MB3209.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SieFnySsNQd6YuJrCa6xsPnfnuZjAaKFRACf4IhFAbqAU0W44b+yplnmfyfc+Xa/a5CGYEQD6r0ifrFfR/Bk9nJVy4y7e0WifKXedUDHXLMLGFiglRjYjKkvJ5CPzTZOvEuDIyBv8D4DokAAsz5qa2D9bZ6aeJ0kATiKsws8IpY4hNsQTu32duoh2w9TM2lCGx6c3xXjYEn3HaD8TgfXrt6IKDqmiiRS80CTfTDtYG1Cl4F42J1a0DIPWCqRM/WNye56OCCe31Kqp2gCN7V70Dl+Rn2LFce4XvyBbmuITpZ6VThqEBzxSZjidUc1ANSw44/DdNCZDFhwexvlviElu8Sw15rOcuvvEkP1sSC1hWEsO1ddwZyZBrrQRy0/QzkibcNDVRdybLo1n49tL/9Rqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966005)(478600001)(356005)(316002)(6916009)(83380400001)(47076004)(70586007)(2616005)(82740400003)(186003)(81166007)(26005)(426003)(336012)(36756003)(5660300002)(2906002)(70206006)(6666004)(7696005)(8936002)(4744005)(4326008)(1076003)(82310400003)(8676002)(54906003)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 23:19:34.4238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87510069-d2eb-4449-5074-08d882aa6c4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3209
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bindu Ramamurthy <bindu.r@amd.com>, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 81433c22fb51..b0d1347d13f0 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x9f0af34af
+#define DMUB_FW_VERSION_GIT_HASH 0x821097815
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 40
+#define DMUB_FW_VERSION_REVISION 41
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
