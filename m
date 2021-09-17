Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFA3C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FB67604E9
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2FB67604E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A66D06EE8C;
	Fri, 17 Sep 2021 19:26:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88B316EE81
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 19:26:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dbj3daLX8YkbGAQDnjQc8vLlRnYLtW/7HiZ2iLwKyGedfy3teH/duk2dCgOBlKv2MoHTSfNKLXYHyw9R8QNNZZV+JpFgOP//Gqf55thnvXdmLih6KnKkjXv02OTPR8qboqH59gPMN0A4JBPStXNXLxf7OmPRNG6uH7lIdbiAMuQ/Qkfes+qi1/YckKlpn8siTGBWuvZDhMdhQX8C4JxEV9zyJPNDNaFnERQ98eJdZNAo3NYY8LvGdbGxm0EoyG6pAsl28u/xBwTKwLpcBuipVVoXHUo8QHub9wWdEvOXI9j4fq2uzzMkZfXAC7ihxKQa1/cCoxtg6f0RVBi2PIH+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=vsg2/C4dT9sgxnzrSB16KC/ywIp4MAXUjS9k/Xfas60=;
 b=HToGP3Yl4jXXMAPakRB7G530sGtT9Y6aqS3117VNOWekyuE2zmJNIKiPIZC8inC3vKaOlP0ykwpimwyWJHKv85Cf545p+Cn4s7n8UZzistKh/zecSNgdEK+yy4QMvVHk77B7Q2W61+GrbdhA4eR4qpkCbXGze/jAg4SlpBvnLHmFbTJ00z+5v2OgUEriZhIIt4Jji3xarRHjIsZEvR150BZnJrudnlTTIv26rZp8m8DpmkhlN4KrUlnEaYkEedr3FYx6VGCzqH3SxN9V1QErJkHgQugc3fyWk3Vjiu/Zm9qqvCv7kvj8PodZc/ycAweOm9/C8e3AXVlUdcorpxFyCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsg2/C4dT9sgxnzrSB16KC/ywIp4MAXUjS9k/Xfas60=;
 b=4Un6jnxzBi15VVPt2Kv2lG0ErbQ9xfqW7itkH7FY17Hn/n/9hTO4jFmJbj2x4NavC3RtLEUAPLjOKyV8iU/rf0lYKp8unxqucPTZAag9yl6Tfr4FmSQDJ3trNMnKJ4RGjcQQTAXnt8iFkggzPvD96wRznF+c36UAw+Vq5C/PK/M=
Received: from BN0PR02CA0036.namprd02.prod.outlook.com (2603:10b6:408:e5::11)
 by DM5PR1201MB0012.namprd12.prod.outlook.com (2603:10b6:3:e7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Fri, 17 Sep
 2021 19:26:05 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::fa) by BN0PR02CA0036.outlook.office365.com
 (2603:10b6:408:e5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 19:26:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 19:26:04 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 17 Sep
 2021 14:26:03 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Hayden Goodfellow
 <Hayden.Goodfellow@amd.com>
Subject: [PATCH 18/18] drm/amd/display: Fix wrong format specifier in
 amdgpu_dm.c
Date: Fri, 17 Sep 2021 15:25:24 -0400
Message-ID: <20210917192524.3020276-19-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
References: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8f110b7-ac1e-4ecb-1800-08d97a10fdff
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0012:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0012A7CB21BC77B9C1B2E63E98DD9@DM5PR1201MB0012.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MfrxNsjkd8t30T+6aoQnIAz2XbsMaWDt2iBmYjexWWwUpSSi6lpteWjHh7ntRfJ6a/lD8A2iSC+5kr8LwKb4KP0p/LygRFiy7Xh7VCUloCr6yjKVmVuCoAUJNQEj4dyVG1lYJthqCjOVXXVHShdiNG+No/BN34P1AXlGamHNDD95D6c49zyVgPgCbQEHSi9Qd8VvC0jdVSO91E8tovZxAxcOp6m/wO8biOVDg6WukB3lzoJdnVK8+kqpe5hq4ttEJU7UlBIMXEOL2LZZvkSI5nvypGY9NEdsT2gc+bkx7SYKzhzEkwMLIOz6Yz6i/mnR5qqNS7t+vNEjQlbUgNrdsOcs5gEsyTqTFcBhmjDkC6wFCeRFwdfNag0S0BUBf53kCHwgokRFdERCvQNdmIxid8GbeiEdmVLyHqZWI7iXC7nDclUm854plIc7AcRCxApAfCtKxe/WWyUgK01xUk/PllFeDRrLVpGp2nhD/Y5ACggT7Yo+qp5srdwEdPVOQKBQhPlH2wCQ/+mXOQPFMwvku7Cl6CD8Kmbu1AMYxNssdkOGFain6U+yXboFjNQXQBqR/ZN2hTsj6FTRhoR7pMawXiZqMHMVkjX9Zgq400mQKmP202NbiZ2a3XzSvEsVtoboDjMv49ggqIhaXInEQIEtGir98nYzAV28Cbc8jKSZitDPE76jnmqXO1fjj+ONwXUk0z4Q47TAj6DcQloLlPdIWa0hLl4nwUjnb62DUzBCGf8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(36840700001)(46966006)(426003)(2616005)(86362001)(26005)(186003)(1076003)(336012)(6666004)(82310400003)(47076005)(83380400001)(5660300002)(8676002)(70206006)(8936002)(70586007)(36756003)(2906002)(54906003)(6916009)(478600001)(316002)(4326008)(82740400003)(36860700001)(16526019)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 19:26:04.8624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f110b7-ac1e-4ecb-1800-08d97a10fdff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0012
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hayden Goodfellow <Hayden.Goodfellow@amd.com>

[Why]
Currently, the 32bit kernel build fails due to an incorrect string
format specifier. ARRAY_SIZE() returns size_t type as it uses sizeof().
However, we specify it in a string as %ld. This causes a compiler error
and causes the 32bit build to fail.

[How]
Change the %ld to %zu as size_t (which sizeof() returns) is an unsigned
integer data type. We use 'z' to ensure it also works with 64bit build.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Hayden Goodfellow <Hayden.Goodfellow@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 85d1304b8236..9da46fe12498 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -760,7 +760,7 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 			do {
 				dc_stat_get_dmub_notification(adev->dm.dc, &notify);
 				if (notify.type > ARRAY_SIZE(dm->dmub_thread_offload)) {
-					DRM_ERROR("DM: notify type %d larger than the array size %ld !", notify.type,
+					DRM_ERROR("DM: notify type %d larger than the array size %zu!", notify.type,
 					ARRAY_SIZE(dm->dmub_thread_offload));
 					continue;
 				}
-- 
2.25.1

