Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9761CC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 197EC64E06
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197EC64E06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA6BC6EC23;
	Fri, 29 Jan 2021 21:28:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A4D26EC23
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 21:28:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igAs2oY3h4885SMtOixLTfjhY3RiUCWqHehI4ntdTXvGVOdl0Cj9QaiB1FW+Cq+IJzXi7oymH2XkpJJ7/2fcpv4rV1+rddw3l0QXGuruW4dOni7oh8Piwe3heIHp+t/XJGEKkoPlDODvGRcwLMcbLcFLzzECXyX5o3GlfWWaBXVpuC18cst9f/KtHrAvmfQI0HSCBTgCetiAZ2Kr4enwAwj9sDo06isJ/nZv9xe39jXlooBkcu4qcgiNY/3KfAKizAHJR9oM9649ucgLlgxRiPtTQt85hZZuNV82stUwJ5o/+sPX+DlqNJJHVwcgkjrBYHGTeyrKEN8Q98oVndEbZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCY3mU/Az6iqCrQPyMkl+w9YJJ9agy4LQKgRHIs4QWk=;
 b=ITPVg4qbS7etmHZhrWRe6bc133lEyyZWU8d4WYn+l4E1kL0D18nhNcu0snUlHYW22uGGP5Eko/4QGYuht48eFk8KEdVATT4iVv2GozW4h6O/0wIcCUuigTFs98CDsMmOjRt9wwoW29gSfthEnTkSWzLo+5JqITPvY+33fA4AQn8PFe6PopaiCLrGFHWUEet1gOWBFADNsONk2A2w+8LEJ+2YzhpkdhxtmE/n11gvKwWGWaRR8wSXlCVsRRytWYgGzwMnIEgSGHnBNUGFbpovHsTFLyrxcBcpE7r1Zzd6jy9Sk5J76DVHXuGBKUd+Bkbt5Vbn5hqsIv7ck+3jyAc0qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCY3mU/Az6iqCrQPyMkl+w9YJJ9agy4LQKgRHIs4QWk=;
 b=X7xnva1CGCzEdD+28aFDKMG1VxxOzGmNlcF/AgbGz4vYmxjJCON0J+RyZo42QFgujRXvFHPUOmLmcle9q5gYNnPwAAz+L1nV1lDALcGNkXp52lj4/y31XnikpMpmAc70a28d5RYCdDOLqn5mA1Fd8wlggPEIVGlDAFFoxHxwMc8=
Received: from BN6PR03CA0092.namprd03.prod.outlook.com (2603:10b6:405:6f::30)
 by DM6PR12MB3228.namprd12.prod.outlook.com (2603:10b6:5:18c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Fri, 29 Jan
 2021 21:28:16 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:6f:cafe::10) by BN6PR03CA0092.outlook.office365.com
 (2603:10b6:405:6f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Fri, 29 Jan 2021 21:28:15 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 29 Jan 2021 21:28:14 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:13 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 29 Jan 2021 15:28:08 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/27] drm/amd/display: 3.2.120
Date: Fri, 29 Jan 2021 16:27:35 -0500
Message-ID: <20210129212752.38865-11-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129212752.38865-1-Anson.Jacob@amd.com>
References: <20210129212752.38865-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e462d190-8a68-4cac-b4d0-08d8c49cc935
X-MS-TrafficTypeDiagnostic: DM6PR12MB3228:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3228B908794FA9D6789BA99CEBB99@DM6PR12MB3228.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mMpTTSvhVofDdKCD8oQ8B18wIZG4tVbNBsFHYTkDA5LUugvbFpfnrDd1Q5hokMzzWw6HXU7Web7//y1WaaIdaITT679ci4cxP/gF9FMlFnBuKaRNhFUN8fqN78NukgiRyrxJx8XwEa+0L3aba+WsUYh6PqeJmAsXdlEDYFho+e3+iTtC8AxsgpxWXH+8W7h13ROBAFrdw+sDQ8uOEu3cI9xBpP10rb76CDF1S0+57TNZjtnLpfX7VBDNkGsMy8v0UdUCRAfa1x59fTcrVv0wDuj3aOvjjuD9T3tvb4shEEyvbaerkD1LeqvGCWHJ+GQq1bNCePUDlEV9YUwkkZ+UraPMDx0mrnASFUDgpj/SeoHwNa+deXw5ES4y4oa307ECZEEZBrkf71cZK2K0tD9gTiU/i29bEinLVeYS1piFcAO54cJxqk+vkzSX9SNKUMy9hYLvej3V1Oj2NMdJWdQ6CXVP9murdzGVaOSU0w6UyuWO7njEvhVpokWiBY4rYwJE8/VeeikzlVpjtqfZPKY16O8ZTAb+Jg/uaRPE3vSkTKPIFLWVs1seiQK2mOegjdmbgnXfH07pSAaC3TwqbCtQT/2AnGNF5Qyj5SJcLeVKruw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(46966006)(2616005)(47076005)(1076003)(478600001)(426003)(4744005)(83380400001)(336012)(7696005)(6666004)(81166007)(5660300002)(2906002)(6916009)(4326008)(316002)(82740400003)(86362001)(54906003)(356005)(70206006)(82310400003)(70586007)(36756003)(186003)(26005)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 21:28:14.2157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e462d190-8a68-4cac-b4d0-08d8c49cc935
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3228
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

This DC update brings improvements in multiple areas. In summary, we highlight:
 - Fix display detection on HDMI ComboPHY
 - Drop SOC bounding box hookup
 - Fix DPCD values

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f8aad222dc1b..ecd354bfac52 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.119"
+#define DC_VER "3.2.120"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
