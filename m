Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9E5C48BDF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 18:38:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56287613E2
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 18:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56287613E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D4176E9CF;
	Fri, 18 Jun 2021 18:38:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E292E6EA6C
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jun 2021 18:38:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l17v7HezdxHFi2IGwYhFBgc3gKDKc4NjaIJQR2+NB7yG1iwr9aWFyXIwr1PjBVb0mTR2a6ddJIdaF2fJrzDM9EIcwUAGnPRtS1ZgzN7mimGSUK2RXZU9kyOL6WJKJrNAItdl+uwNfmqz9Jv7ZcqtC5AVsGqAxm9bs84Whcockrw5Nt9kKRCQeQo1AJ7mr8kgfCD3HHctd2TTsNeCzjWcHzGNwY4FdJsXMDbCx+jXm3eB4ZtAzF6dvGKEAs0RqJbE3p2+NEqY9sKWhxL1Cma7aPKOhoVjn1q/rMEzzvfTVz+k8PczYXyWlrSGr/HYEQxysSq5Qp3fWWCTsgu7AcSo2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPCfmPWv3su+hGsctQOKYvjlj4y+K9tMsy610HOGRK0=;
 b=TzXqQihInBzXDnQe1fjpJTASx9YrTsVMSy/kbmSyFaUXI+mXUR1cFlnvbDMx/SeFAzVjAupZSY0DU7fAfJ70pTpct1jxxLvnFaMLiX8wytl63t5CzUoCoSA/GNdLUb1pZ+0ZmRIwxjkTO/cyvqxMwj7kxJAELDUYDg828V+nRf8dHQOPASr9DSXhCCFHUqCcERj7y7Qn7oZMs67ulKKA7f4BOfbempA7Zv4KbL5avpHLvDeRVyzjBGgrXOenZeJhHPPR8SJxW4cu/OP/nO8fh4g0vRZeHY6aYUa8M1QNOKBNKBbt0FkAZho0bZ7p+SR/9SMj1YVgoJom+2p2WJ909Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPCfmPWv3su+hGsctQOKYvjlj4y+K9tMsy610HOGRK0=;
 b=3yqJH0ZF7V5WZJBzwXrGSqpgWFb/GvNmpyQk/dI4wJXzvLwHYSdjMfA9sLOJvHyEriJe+6rJjQSlr4+KkX34i4s2Xz2Z7Yd2cd2ZQDDRYH2jPo9i6u+ZlGyhJKweZM3v4bYdW/LLohbPNtD/oinxEICTF5Ml1x5e56qn3C91yOY=
Received: from MWHPR20CA0005.namprd20.prod.outlook.com (2603:10b6:300:13d::15)
 by DM5PR12MB1466.namprd12.prod.outlook.com (2603:10b6:4:d::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.24; Fri, 18 Jun 2021 18:38:26 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::d1) by MWHPR20CA0005.outlook.office365.com
 (2603:10b6:300:13d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Fri, 18 Jun 2021 18:38:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 18:38:26 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 18 Jun
 2021 13:38:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 18 Jun
 2021 11:38:24 -0700
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 18 Jun 2021 13:38:18 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/12] drm/amd/display: 3.2.141
Date: Fri, 18 Jun 2021 14:37:36 -0400
Message-ID: <20210618183736.647268-12-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618183736.647268-9-bindu.r@amd.com>
References: <20210618183736.647268-9-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47f8812a-16e4-486b-e489-08d932884287
X-MS-TrafficTypeDiagnostic: DM5PR12MB1466:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1466271DC664EEBE0A03D3C0F50D9@DM5PR12MB1466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wFfnlXjzGLxIpA1B1JhBoqna2OLQfwFcopPsw/6JPsgAUlO4lEQ0NUusncR8WX+dy4xlmWsRkaIchyhrCdmFNTvveHzVm7CrKFxInWhIJvIJUOL6VUJh/vHw21a/ZlarnQ8vHJ1V2HnnxUJ3VbSSjdupvktJAzAmIDQX2UqSj4SwVZic+0BicUH8A54Izxzfl9Wf/m4xpNh+jeqlVTccKwADWmFWn/0mFH0rnuCvaOKXJt/GkFp9yaiXE57c2mXCSx6CIN0I7pm1SwptXkGENM+BgTfv5suCEcTCqJ3mnUZIn8SuMVwPsNvd1BdJ1W7EkY1JS8oZXWD/4TTPb6dZ1Vncq/pBJQgvxny/TF9JeEdW7SI/+Vro6z2Xwpx8E4jmzzZd+yrkORR6qkY9s+DaBkGN9gsZjfaBXB9gd8WxX2xDr0MnLGdhZz8ne5Dn1hVeSNE0LLm3Wp8Mm5z9DEISmv4D/WT+HyBHJKWQyy6XOTEN4wyrTDXpfuI6X4YsWn7QBjKjDOUNtckAThGuOIse5p/mhI+ydScoYhuwMjHo+8wIOnacEqhM7gSrjWIesNmjkzBUCjX7TeMTaFUKz0qFNuZAfsL19JXgGbRIV2vnmqTv5vlub4YURF5V9ouvgHMeKfpO7EL7npgia/pBB9cyy4uw9p1vUmMVL1/gRQpOQIw1e6/JD4fSuabMwqyylAtD
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(46966006)(36840700001)(86362001)(26005)(83380400001)(4744005)(36860700001)(81166007)(5660300002)(2616005)(82740400003)(2906002)(186003)(8936002)(70586007)(36756003)(6916009)(70206006)(82310400003)(1076003)(6666004)(47076005)(4326008)(478600001)(316002)(7696005)(54906003)(336012)(356005)(8676002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 18:38:26.1189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f8812a-16e4-486b-e489-08d932884287
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1466
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 9d924e8496f9..7674535654ec 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.140"
+#define DC_VER "3.2.141"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
