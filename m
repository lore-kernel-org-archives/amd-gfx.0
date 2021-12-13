Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFD3C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 19:34:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1143789911;
	Mon, 13 Dec 2021 19:34:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71D5C89906
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 19:34:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtqEd0n+ydOdHmOvBlczGev+1F2CqH7lqMypuI6GjE94FKuM+vySBcfXhw4Gf+K4E7GZF864+rnjtFNcAEAXLEZCJBQmZpQ12d4RDhOO5p0BqL9+b4e7fb9BIoq4zZUy6In/KIqOzTzI/T16wwWvj41QlU2HnF2nkmELuU1KXufWG6MPSgN4qRUWfmdAZD9E9ow9BHt6YBD2yEKnKfbpvq5L0XvgXz6QTnwx0ba+t+lIyCxupOOtUGaik2W3l174GxnHK8ILhhfC/aotrzVPFiE/rnq/1kqHBKzocYhYxL6yOk5fGIG6sqVwPog/+1i2LCClM7M6zaC9t1zu+c63PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyAnlv3m4shEtFSJ4Juoonl4/n3TdtIdb9i4bAmQSIk=;
 b=R9CcVLWvMCk1/VndAbeJvOBdgQf/3o2Y4uCxfYBH66Fg5QeEkGlfuQ1kBFNQREIJKK6vYL3J5R5DbUZWryrgj/1+5TwTmrND1p5tF2gEWY5/dIhNfg5Sd8UKgDIS63YxE6XsNlit11mb5HTCzCGxbZLfzbgmPSi9IRvaP44vLZHWO+bFTWq200pFDqrVd6LO1597P1fXM6zjJeDZ5DBogdFu1PkD5XIHqNTx248m/5IbxQK/RsqTf2Ey7zN1AK2MI/I5+dT7EwxdQcpzYy2pt27FnUbAZ4EFbddKukL22/aAfaGfeWgY6KhepRffp0Voog8Y6MRcv7Qj5BIO0yyJTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyAnlv3m4shEtFSJ4Juoonl4/n3TdtIdb9i4bAmQSIk=;
 b=FxUquFEI6lemRBNeyvGY3STDOv0UocwTLQnY2JdXi8tIvKqp0BKZuR9A40iAIQOP/eG622CLRpdgH1L1LHQB0Xe71Mh8TysQ3EftAKO3Uzwl2BS+sx4kZkKYunEx9UQGRSpC0Cs7MjblpLfXNfkqcrSVOK2TvTUw/3wXczifoos=
Received: from DM5PR06CA0044.namprd06.prod.outlook.com (2603:10b6:3:5d::30) by
 MWHPR12MB1855.namprd12.prod.outlook.com (2603:10b6:300:10e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 13 Dec
 2021 19:34:47 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:5d:cafe::59) by DM5PR06CA0044.outlook.office365.com
 (2603:10b6:3:5d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11 via Frontend
 Transport; Mon, 13 Dec 2021 19:34:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Mon, 13 Dec 2021 19:34:47 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 13 Dec
 2021 13:34:46 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: Only overwrite serial if field is empty
Date: Mon, 13 Dec 2021 14:34:01 -0500
Message-ID: <20211213193402.96278-3-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213193402.96278-1-kent.russell@amd.com>
References: <20211213193402.96278-1-kent.russell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50fee8eb-0bf0-4875-efa4-08d9be6f9f63
X-MS-TrafficTypeDiagnostic: MWHPR12MB1855:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB18554AF47187844D35A8403485749@MWHPR12MB1855.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GjYW94sYSAcoy9Q/ysd7l31ksxZLQ1XLkEMm+3JWxmeYjPtXO0uiB94u4o4RoWnMw5P7nnlGt+Bv4rbPE79DxxnyKPx1Z+S223S++L7rZHkm9xnabCSrgHM0QhFmawiJDYC8puFz+iXjhHFxDOi8kK6HVQzIhZ0Zm69DdtZQD9U68KROcsPDMCj3U/wkC9l3Cb58G/yn5pW2FiVx/6XRfAD/Labs9ORdcrv0iRhHGWRXV5XxmRKkZQjSzCjuvXX0acRB+xPI217FjlKHBxIwC70NMTDlvqwLC6MwcXpKPdO3FYIpzH+9fgat1rcg1mR3W/h541ozS+x18XgGE38uXK2NGQDqWx/Vf1SeGoiTTA+pJ74YbNcyGkibbpkXH5cLgj/ixrnVJrwroL2QHa20X6x5nldiMf2p9XVKm0su64yreZ+lbLHGe9VFO5at+khudot8Mwu0q4+ELiJFxl2OPQPzYe/GNSrE0P9lo50aKaraZNclx5hZMT4tO0XUtgkAURS7kP+crdD54ZT8RIkpanUH+6kJ9l3jnIB+rX5SB/iIMKYfGc8TBUH17MB0j6V+kI4i7fhUEpcIw5N80YsvFgzjRnPpKIcjfYYxX8Z7mQjYhIKRtMRu4EsRrTXkaxYty9EsTcPthNn+Jv8taxGsegTk4Rq1b6jauZgnPcYhXfSRTRyoMBCpj+cDscggIdShDF+8cmwrbVDTKffYhIwr5PJSK3HE2bsOWumnunsKvtsGhZ0/5x7rmOL/54etlNdLVrxKTQclD24chfTkiK8eO4mHnU9FTMheBu8BRDQGA2I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(70586007)(26005)(5660300002)(70206006)(40460700001)(16526019)(426003)(36860700001)(7696005)(81166007)(83380400001)(86362001)(2906002)(356005)(44832011)(8676002)(4326008)(336012)(186003)(8936002)(6916009)(508600001)(82310400004)(36756003)(2616005)(47076005)(316002)(1076003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 19:34:47.3551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50fee8eb-0bf0-4875-efa4-08d9be6f9f63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1855
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
Cc: Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Aldebaran, the serial may be obtained from the FRU. Only overwrite
the serial with the unique_id if the serial is empty. This will support
printing serial numbers for mGPU devices where there are 2 unique_ids
for the 2 GPUs, but only one serial number for the board

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 6e781cee8bb6..dfcf9a53e5ea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1615,7 +1615,8 @@ static void aldebaran_get_unique_id(struct smu_context *smu)
 	mutex_unlock(&smu->metrics_lock);
 
 	adev->unique_id = ((uint64_t)upper32 << 32) | lower32;
-	sprintf(adev->serial, "%016llx", adev->unique_id);
+	if (adev->serial[0] == '\0')
+		sprintf(adev->serial, "%016llx", adev->unique_id);
 }
 
 static bool aldebaran_is_baco_supported(struct smu_context *smu)
-- 
2.25.1

