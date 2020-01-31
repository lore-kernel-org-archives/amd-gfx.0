Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD84C35240
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A44020CC7
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zyWYP6bV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A44020CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 086D26FC3D;
	Fri, 31 Jan 2020 22:17:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 863EF6FC3C
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oO8feN6nDcGR37zXqOj1BGt3gHzutJCG3nX3nF5sGBdaqmAtBR+0bdrgxlL82p2NhTCo/teNLohmt8YKL2bMA6g5dEM45fMr//LNuqgxFsM+sHOeyJiC8DXhEXi8apYCvF468um/zP05a7DiStKmfDybef8E97USExRH/UHbKhFTduM4O0DwaX0dGmJR6O+RS4CPSchdyqO/BfrJOO1aexvuARwEPyHFeG4zISRCV2hk+efwlpyBrdEyta/XP4lZuH7Fmq77+t8eJDtl82K+iGKGoSQc0WAFmy1AUpm6P0LdJKQfe4AaHOxZjc/F+2Y4geH1+e4T8MdFS0yJpF4CpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdKybqy1ieVxh5d3Fk76ZkoXz7uoQLnCgUK8QLECQGc=;
 b=BZhmwJYvEzh9ncsNYKj5g3ye+8hKBBYg3/IBJMx2w3Im4nUZPbARNOuBO/HH8s7t7kjzo7cCEV/+o4HNeRsTmoRudL040CK7bzK/nBTEjVDPLZXMa/yNjJP5ZlXAuBz7DmMWEk8IwbfyanZMo+E+F0ix7gTePiL3tAxELdRSaM/50qR53xdQln1iy7T1odMp8c7gwh8zo5FPOdZtoTgvD8Qms8K4WjHhbW9zq9EQ+O5GEIvWj6YSB/7lxW2zkfaUq5v33xh2jre64fpqf4TV19Jj5QBDvHKNjCFXp8h7QIEbu22IfKjYvfuCMYPCJsKWcXGtO1tOmaknk8BZIxMnrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdKybqy1ieVxh5d3Fk76ZkoXz7uoQLnCgUK8QLECQGc=;
 b=zyWYP6bVQTGKDrRhVfjkaNUznvwh3InfbWAVhxkGv5cI7rbBglA7NbIQsahi4oga2giM9EMeib1HnwwM/CjEYMd68sdJdxTKm6C65Bkm3RrZV9ffJgEl9wlvBS2YXi4eH5EfXWOBTK2/YdnMHLLAVP2/4NFl8VP+aWliyPvZfrc=
Received: from SN1PR12CA0098.namprd12.prod.outlook.com (2603:10b6:802:21::33)
 by BN6PR12MB1795.namprd12.prod.outlook.com (2603:10b6:404:107::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.29; Fri, 31 Jan
 2020 22:17:13 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::204) by SN1PR12CA0098.outlook.office365.com
 (2603:10b6:802:21::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.23 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:13 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:12 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:06 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:05 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/33] drm/amd/display: remove unused variable
Date: Fri, 31 Jan 2020 17:16:23 -0500
Message-ID: <20200131221643.10035-14-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(376002)(39860400002)(428003)(189003)(199004)(6916009)(70586007)(4744005)(316002)(6666004)(7696005)(356004)(54906003)(2616005)(336012)(81156014)(81166006)(2906002)(86362001)(36756003)(5660300002)(426003)(8936002)(1076003)(4326008)(186003)(26005)(478600001)(8676002)(70206006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1795; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d868288b-d899-4969-3610-08d7a69b5270
X-MS-TrafficTypeDiagnostic: BN6PR12MB1795:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1795B0404002C47AD303CA43F9070@BN6PR12MB1795.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V06QCzBDQ+6L8GNJJoITmENou3H/hw3CCEQ3nY9j5ncrLWEuD78MgXKNazYUpoIAo0f/aTsRgJM/nq0L16U4kK74WxMBo5FoYv+ofLtvFc3J6JmqBY/9hWmnq7X44x11LMaRGe7VmeA7EvM5x2JMmpEtE94cihsEs1d5CYxYZUp6Y/kM3JEIhvD4G5qG+SG2Gmoy8py8iyXwMKgFXza7AG+vn29JcVYnzBeTntvIagAZnkblgNd5NaZLjyZFAIqPkvKdUNh84ygWCsp50t9YhMJbz4OWOUX2+NMsSqBArKabpWIXpOsxM6NbHJcT06m9Om+F7fe0lImREoZvzXe4onbvwihI5tQiNPmcBN82hXR9NdHcVd8ptjZhTVeC2IvsMiQcOl46+hm4KzosoAOQIjGFYYMCCf+tuUlLh96+I1blUOYBE6ZSylcDcxGoRLi6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:12.7810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d868288b-d899-4969-3610-08d7a69b5270
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1795
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, Aric Cyr <aric.cyr@amd.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e8d126890d7e..d00b72df469a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -682,7 +682,6 @@ struct dc_3dlut {
 	struct kref refcount;
 	struct tetrahedral_params lut_3d;
 	struct fixed31_32 hdr_multiplier;
-	bool initialized; /*remove after diag fix*/
 	union dc_3dlut_state state;
 	struct dc_context *ctx;
 };
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
