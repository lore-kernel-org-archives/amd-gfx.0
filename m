Return-Path: <SRS0=DKNW=LW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0AEC2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 09:27:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 881E661C43
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 09:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881E661C43
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37F856E3AE;
	Mon, 28 Jun 2021 09:27:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 770336E3AE
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jun 2021 09:27:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTekpt9VBTfEGFKeGICu1gVaqDKe3wlCnAVwynpMNad2Oj6SBxj8D6rTMASrgG5eX3SIP108SZfaZ4Mz0kl0z5bPIDX62+fihjCGqtlKBycOt8xaLoYW1dnGCaFyV8z3AO9gkCaBiQrcRCNg7ax1pAiqY+7DZ83aIwJq8AQmOczeVu7LJSaO1x96TSl0xukTkPohYVNjDj7rOK2q2E0Opzi2ZEssqEzkThbzMPq2BDaiqihyWWyOjexLhUEgfBaQix9FowApQLCKY27CXhCEfEuIcy6vaL4HU1QvMUt4GgmBF7SnUiKXzThD/VWdch3EXaQsMA2y9yZlFO+o5S1Reg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Dwqw4uPYEaII/JipD5jXPbD48UHOQ4+fkKo/U3kbzg=;
 b=TjICi3XfsClPgMXrWl6rP7zy6qps4s2A7IZNs60gqXBWZkWmFhl8bBNSNoM5qT0evAXgxR2qpzo5mbEJ7OeQkLAaXUxns+A4sH44w9S7A4NwQPGKjbmOpzEvuVk6gXCuAVXxG9G9lPYFGCoXFsF5118lcK/YZSLCcXe4zztvDOSu7Qcz/Qch37BPKE8DycmMLQA7b6KyxLXPYmXck/foz7P18z1o6WcAfLiQ7S+OmXS/VMKnpqhmOu/ZDcPE79BPA+Zt1sObRcMTfHL6z4RdLbcWWvzGC5HP5JZMbtNQBdM3zhyDa1Q5qsrF3ZmAzh/7wy65rUmUv5ZxrJ0odTFR7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Dwqw4uPYEaII/JipD5jXPbD48UHOQ4+fkKo/U3kbzg=;
 b=IEr6bVyGf366PasN6Sb6gF6/32jLjtd9KwYi6xcQ2uFjrolueSIjYvJGYEtNUvXEPlbqz1+8R9huy5Hspub8IkjsaoaI7f6KSq+nGPmbvk2uNKDi1ku4cnlW6BjsTeOryQTRM1ajIwoZfVjobyYD5yblz4sCa1vDQTGf5V616aU=
Received: from BN7PR06CA0040.namprd06.prod.outlook.com (2603:10b6:408:34::17)
 by MN2PR12MB3487.namprd12.prod.outlook.com (2603:10b6:208:c7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Mon, 28 Jun
 2021 09:27:51 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::b0) by BN7PR06CA0040.outlook.office365.com
 (2603:10b6:408:34::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Mon, 28 Jun 2021 09:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 09:27:50 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 28 Jun 2021 04:27:48 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <rodrigo.siqueira@amd.com>,
 <aurabindo.pillai@amd.com>, <harry.wentland@amd.com>, <tianci.yin@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amd/display: fix incorrrect valid irq check
Date: Mon, 28 Jun 2021 17:27:29 +0800
Message-ID: <20210628092730.4722-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9bc25cf-e33b-46e6-8e13-08d93a17000d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3487:
X-Microsoft-Antispam-PRVS: <MN2PR12MB34875E43991C15B3C6F06CDFF1039@MN2PR12MB3487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:374;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ipf/ISeCE1ARMeHxt+arzJeRrYiviVH48mkygqf9LwVdVO8JHwbmfZfPFtSFq0a4c4gFrwo6NFBZReyhKkdDU8BsIu+9bL8nwH/XQELgu4G0UohuNThZIF6WMKymTpY7YxOuXByMMmkZDrMAllKQEDu6Wb8r766JwuW9smbXgBabjt7ncvKvmOeb7KeeYLzKTGsGn20Tjl+Ap0Eimu7ZQvWHCj+GaKGrfortVnaR/C3+abMZTZGHa33TqMVvfhH9k2m8z7LMZGmFNJIJq8Y3w+TF+iJM9IYHF5Xpf2veDWPl/vWjyOEkV9xGeWEDWuVKLJ4E+l4DKuuMLruX7EhtcHWXZHIstl/Sy+FTP4/J+99qLNS8QCfl4FLbkMhnKxzHzWda5sOmWoQ1kUb8nYg5KQDUD7LIemGw0FKW83Qtvp3ZiURniVBOtwKByzx8fGJmdg+JnkA52xKdwDk4eePHdAYWxCoxqDA4QLdObBpEMD8XOL9dB1TETkeEzXFtDEWnNZqrtVQvGBn6FNVWjRyWbV41g3mp/93BxRw4K2cjwI4d8/PHTg+7sfoQfpz4DeZio9m4iiOdl5fG0JESy/Ssu0i8dlaKvLY+opbdqHwXYBkKwtmvshjqI0tKqd65xfpGz8hG77nd98OjTRftpMLCBtLVcBLrg0kc+UHBkH98OqcqOx3dBJg+9GY5BEMDmsl5WQ9LdgZWqU9ocIzLOdOvutuSVipoAZQMOnezr/GbvSgAoK1EaSzPwL6B3XGSeGk6sVHbsjjorkS6ibelrtr88w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(46966006)(36840700001)(86362001)(83380400001)(26005)(4326008)(356005)(478600001)(16526019)(2906002)(81166007)(186003)(36860700001)(6666004)(82740400003)(7696005)(70586007)(5660300002)(2616005)(1076003)(36756003)(336012)(110136005)(47076005)(6636002)(82310400003)(4744005)(70206006)(316002)(8936002)(44832011)(426003)(8676002)(49343001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 09:27:50.8653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9bc25cf-e33b-46e6-8e13-08d93a17000d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3487
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

valid DAL irq should be < DAL_IRQ_SOURCES_NUMBER.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/irq_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/irq_types.h b/drivers/gpu/drm/amd/display/dc/irq_types.h
index 5f9346622301..1139b9eb9f6f 100644
--- a/drivers/gpu/drm/amd/display/dc/irq_types.h
+++ b/drivers/gpu/drm/amd/display/dc/irq_types.h
@@ -165,7 +165,7 @@ enum irq_type
 };
 
 #define DAL_VALID_IRQ_SRC_NUM(src) \
-	((src) <= DAL_IRQ_SOURCES_NUMBER && (src) > DC_IRQ_SOURCE_INVALID)
+	((src) < DAL_IRQ_SOURCES_NUMBER && (src) > DC_IRQ_SOURCE_INVALID)
 
 /* Number of Page Flip IRQ Sources. */
 #define DAL_PFLIP_IRQ_SRC_NUM \
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
