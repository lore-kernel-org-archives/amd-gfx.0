Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B51DC38A2D
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Oct 2022 17:10:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A625810E481;
	Mon, 24 Oct 2022 17:10:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6440D10E481
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Oct 2022 17:10:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZzAzJygaBwgwop8IltVPRW9XMD5RgGx/xOtJ10kQSRsB2Sr9ai+s95s+aOd9Y5r6egE+81Uxq1snNyv3ySfb0PWA0AV2HsE4xtylJKQnzaCJtHS36dv42WiCjECA4Y5tLwJHUZIlMZPgDCsl4XWxMKCgClEOnItFy10MowG83uAlXHWkTi3Xl2dF+FD2nCst6tz5DAOjpT9uZxFncCr+/aEcT3TrbeMJpmvvH92UJVBxLYp/sPVhtv5g01+iw02dRfOCbsjKItGB4SfdXpnIT9PdM02ic+2weY5UyX9GFjSY0qe1XonUmz0nojhxT3JCLi58LQKVq0j/Pt1Cw2sxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRMDqSWY3MwrKzs5CABChqUUJ6HIOe4bKUVi4ukKVaY=;
 b=Xg+3lDTfDaMgDPvFqhdB9Acus93XTFzS7QI9PZCer4tvfZhEcn6MM1gWpaRWiD6g2fhnrqUZsVFG3JTUV+QcKPYca1E90RaUtIo1ZZKxFuI24T8n0RglqAG/8LnHnK/cx+20WhoQ3JNjmjYs+HlizsCqejMbHQqGNK5qzPvknJP29FFq8bp3gQrISbMeNMquZmzyNKZ9XHuQiv60EhA4ll1TqyhYlcJVhEpQV4hd0IxiggwvoMyzocuk350px8Zoy02HfawUshcSMVlY9WQ+pzvLXHRmkLtu87L6VfwKWxNBzKsdKkqnKMkAgIm/juqJ9mJxIh8hvKl0a09bpXDT3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRMDqSWY3MwrKzs5CABChqUUJ6HIOe4bKUVi4ukKVaY=;
 b=y/5dGUFn8afWk9ReaODrQdoqZ+bG17B3ADpIZ2ip0c2HgDJEDOYuwoqWYtfljyqRqx85w7opJ9XJ19PzTYV5Jmg0td5I+3UR3xMSvd/crrLwauDJ6GxGFtwMr6cFG3eXPVCEvAZuiSeaafsdbMKLo6qFvDZocqfBQbZR5y3Cq48=
Received: from MW4PR04CA0193.namprd04.prod.outlook.com (2603:10b6:303:86::18)
 by DM4PR12MB6663.namprd12.prod.outlook.com (2603:10b6:8:bb::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.21; Mon, 24 Oct 2022 17:10:38 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::36) by MW4PR04CA0193.outlook.office365.com
 (2603:10b6:303:86::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27 via Frontend
 Transport; Mon, 24 Oct 2022 17:10:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Mon, 24 Oct 2022 17:10:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 24 Oct
 2022 12:10:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix documentation warning
Date: Mon, 24 Oct 2022 13:10:22 -0400
Message-ID: <20221024171022.2270903-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT023:EE_|DM4PR12MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: f09710d2-9406-4f5b-9f07-08dab5e2abfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NM1uOQuXwBzCaVEKZMuT4MUGbPwQ2HPVUsZks9riJ9nUux5WKRKim8kJEzXj+bitslQ1uuYQAP4Eiesx6RmQfuiId4eOkiUAKQVajcEcZF1r0qkhswUbpvfgRTW0axU9eeBqs7xyEeoHadLh2HNJyOZosTjRMnHmA6dUzF2flhTHrDl49TaeZqVRMKs10R9VX8sEv6vDGl6RsAZFqX+hA+sfKPllWSTaALoj2k0sTyzSb5plzLvZmt9HwnXwVo/hnbAfV78itugslbENo50V5+UPHb/9E8HbIzxavMxHeb208ctqhBNlZWURgR5EXnZGPoTDoB+3OCDonh5C0vgQsEtCi54VkYeOKj36fuOvSYzalFs8jOg9flCetmVtgnWV0NjNjOa3HBM709UkTS12Czf8opRuOGNneIbDJTVRW0l08I1MMNvU2sB+CCRpyUAC+pFjlaVhbuR9CtOFmZI6n3XBWMbesnUN/8VaBBkm1xpLw0f1zZnbbXaOH8MKFPU75env519WUUQLGPxvRWYH429kZG7kyX4dUKtAipo+UrmIgipFLSMOeFmxBSU81Vjy+wdDkvi/L4Ovzi7z8TtbONrTHGqRLY+7RG/nfZqui8UYZuOmTOQhOxUO6YKPFKrepzuKqwV31xuGiH9MwkjqQAejxc5pnfQf42Dz2U2yFHO3SaHWDPfO9v5eA8scn7jwYfLb/I+/+Hz4s/lBrWFCoGwIVGKJgq5qDQHZ82AIvqD0fDk/5Cv9zoWq4t5Ky9Yqa4wLxZbJc9dkIKXz+Tpvj81yqG4+j9INybbHbJQcehixU6bg1ZI4UTU2hIu5toDO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(8936002)(5660300002)(82740400003)(41300700001)(82310400005)(83380400001)(40480700001)(6916009)(54906003)(2906002)(81166007)(426003)(47076005)(70206006)(336012)(478600001)(7696005)(356005)(16526019)(1076003)(186003)(36756003)(4326008)(8676002)(70586007)(86362001)(6666004)(316002)(36860700001)(40460700003)(2616005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 17:10:37.7414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f09710d2-9406-4f5b-9f07-08dab5e2abfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6663
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

build htmldocs produced this warning:
drivers/gpu/drm/amd/display/dc/dc.h:1275: warning: cannot understand function prototype: 'struct dc_validation_set '
The word "struct" was left out of the comment.

Fixes: f4a59996c408 ("drm/amd/display: Include surface of unaffected streams")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index bd7a896fab49..e4e41f2e5054 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1269,7 +1269,7 @@ void dc_post_update_surfaces_to_stream(
 #include "dc_stream.h"
 
 /**
- * dc_validation_set - Struct to store surface/stream associations for validation
+ * struct dc_validation_set - Struct to store surface/stream associations for validation
  */
 struct dc_validation_set {
 	/**
-- 
2.37.3

