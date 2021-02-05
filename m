Return-Path: <SRS0=LS4N=HH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273B7C433E9
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 22:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE0DC64F9C
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 22:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE0DC64F9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6058B6F50A;
	Fri,  5 Feb 2021 22:03:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3856C6F509
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Feb 2021 22:03:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKmceIXrwcstcC5Rcbx8P7hmt8H/vRG4cPu/BiwLOYFUvVtNjvAbxEQKEbEML+ha8cRo3BiLaG5CanIhODOxekLBoeZSzB1BYyQlGUx/gjBNdU9qi6yTzYbBy8mDhNqhGHgjtbf2QURoYNl+lHVWX1m97Xn8+WNln1WgQvoy2XXq2sAY+E22IX/juS/RtItgpvFJc4m7GHNvHl9FtR4S3lkg5fSu9Ew1lTkB4fFXXaF3A/e6YYl1X8JMulHnCJgM5edNH6aF2mrs3iHJuALaIvq9pj8fDxv7JEnDelaoHXslXdmRwV3l0awKky+3NZL441ZwH7nLPcQ2u+Kq6n7lzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uf4LZYvmQMP/hHIref68URK/A8bvQlaHro51xi1+CC8=;
 b=NTquY3CKEJsqPj2XXcTMAG1WkgCHt83a3M5ihDeq9KXAmWPPiN7ply07tvH0lhTeLws5rje5VfSTvt7h4OZh/8dpYt8UQf0TotaFxJwqB7Yl5SVigTW0r1z6wSLg6DQA7vQuzDNEDQ7GQ5059PIwuT74bA89KDxYkD3OCuu+FatEzyNBQm7BGFVuYUJ17h+52aaIaTgZGNcy4Y9H97F9lfffuqdXde3n8HtMVD1Z8IlbPvI3ycyMnE+eZ5kAZO3JXsjl3hM1sVOelmngKYQVlWDo3D+pTEw3Rrkjz7JgLKpJpVNFyMfo1gOqlgZtAOyrtJUh+zW1XKegAAzijF8Xfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uf4LZYvmQMP/hHIref68URK/A8bvQlaHro51xi1+CC8=;
 b=OSHUv1ddfU/iazQzqGTAVHcjPU974VysMOaF2NWw+ALOwH/VjwZbSoT6LB3FHAgCWUEZdcQVoMN0TUz7Wt3a3xxUl5q1iXYp2+NnD0zCqCwyBQVyxq1xu5Lvi1vpwraxqrTG/Xoq5Q78f38/akt3kSit0luvGYRYO3vJ5IGsdtc=
Received: from MW4PR03CA0028.namprd03.prod.outlook.com (2603:10b6:303:8f::33)
 by BY5PR12MB3971.namprd12.prod.outlook.com (2603:10b6:a03:1a5::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Fri, 5 Feb
 2021 22:03:19 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::57) by MW4PR03CA0028.outlook.office365.com
 (2603:10b6:303:8f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23 via Frontend
 Transport; Fri, 5 Feb 2021 22:03:19 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 5 Feb 2021 22:03:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 5 Feb 2021
 16:03:14 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 5 Feb 2021
 16:03:13 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 5 Feb 2021 16:03:12 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/11] drm/amd/display: fix type mismatch error for return
 variable
Date: Fri, 5 Feb 2021 17:02:48 -0500
Message-ID: <20210205220250.1871069-10-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210205220250.1871069-1-Anson.Jacob@amd.com>
References: <20210205220250.1871069-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57fa673c-2055-45de-5352-08d8ca21d82c
X-MS-TrafficTypeDiagnostic: BY5PR12MB3971:
X-Microsoft-Antispam-PRVS: <BY5PR12MB39718B791D87425D82184581EBB29@BY5PR12MB3971.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qt/k/TT9dM2yjKZx4kbEhb+VAaF92IjA7YOhhdKir6IRO1NEvcxqygs1lO6ud+4dcTX489u5LFjeiOsEQHfF+1BOk9rGud/8m72/UgssBuFVWzwZ0mcZttk2pD6TgAwboHj6dNDWjUBhIFklMt6Hlk+JbEmjE7Xg1mr2otbTpiUTgX3KfwASU50WC8ZfygLRP9fVO1kWrvzg69lP/pNNfYV68ET6MX6084m1k4xlzA6WJaBFX/jFLWuc4A73rH2zJGeaGiGf9qQ7gRBfUyya97Ga0Mnb3tmu9OaSt0EDK2DLG6jWvNNchpi/ftKrhaN7J1UxODqDJ+oRA/CxMgkiTF3WqXA2O/kq4V7TmMK9ADF+lLYsDlpgXZyo3hC5PfGdGKpOdW9LchBh7iZvUvpKaMIk4SHW/26/wScp6gXSPV13QrQTcqgHlfzToZLUFOxsz+eMZqQzYTmAc9OhaW9vkYNPEpH0qW4aHFKIL4euUE1x1sKlrQVgplYSXVa84HI0hQkCeSLYllVuseyKI7iQXQ0MmLthrLA6C+Iqk7YdLH7025GbHgdSzxbP9/NqghPm0LDfIZtYOMyBQhNahXrZ7mypBm6t0GzT+sz7mKFXRZNwN74kVyU55EcIc3TKdJh0Uaeq02qqaHnnuXuQrnZ1fTHeaqC/QoBHI5OtqZHVXL8zuwfGYmfQ330dInWW8EaF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(36840700001)(46966006)(26005)(426003)(7696005)(70206006)(83380400001)(86362001)(1076003)(70586007)(2906002)(8676002)(8936002)(2616005)(186003)(336012)(356005)(81166007)(36860700001)(82310400003)(478600001)(82740400003)(6916009)(6666004)(47076005)(54906003)(5660300002)(316002)(4326008)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 22:03:18.0761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fa673c-2055-45de-5352-08d8ca21d82c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3971
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>,
 Bhawanpreet.Lakha@amd.com, Dale Zhao <dale.zhao@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dale Zhao <dale.zhao@amd.com>

It is possible for ret_vsnprintf to be assigned negative value in
error cases. As an unsigned variable, negative values which
are stored in their 2's complement form gets treated as a positive
number. This will led to treating bad cases as good ones.
eg: -1 gets stored as 0xFFFFFFFF on a 32 bit system

Signed-off-by: Dale Zhao <dale.zhao@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
index 7f4766e45dff..e8b6065fffad 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
@@ -47,7 +47,7 @@
 
 unsigned int snprintf_count(char *pBuf, unsigned int bufSize, char *fmt, ...)
 {
-	unsigned int ret_vsnprintf;
+	int ret_vsnprintf;
 	unsigned int chars_printed;
 
 	va_list args;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
