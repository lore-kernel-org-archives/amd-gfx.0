Return-Path: <SRS0=j6k1=2N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F09FC2D0C0
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 20:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55DD520709
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 20:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LmLm7h1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55DD520709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22BF889EAC;
	Mon, 23 Dec 2019 20:46:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2B2389EAC
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2019 20:46:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCxOL5BjM+VGgkQqxcGGhGUtUhmQJGFzP9J3Te9vOn5GfSw3QDMTKx6an7kuSli3FuAsB6O0QKoTH8JhNsDRYHowR4omTJU67f3Z9EWdYvPZmwhMEXmLxUOVzm6gcbHc1ED/5jXzSw/6SRMVovvnVqgHixiSFg9uMRyDS+mpeKxSg9ju6ux0lDHpUIIQyvXO7V/E9j1u2n/qWxNZ1qjgeu5+5KCrDj9HsNkPzOWxa0qaUOCjJ7ABu7NV4HmVDjx9PewunXUPUOD+5I6Gqg+/FTHh/DunV9gkUQ6RjdgZzEfFqadJDp3rW9A0C/tl696vmyhck9W2LXCkQ2FpZRbH7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBQMk1yX8inh6AcvRcc6e54ToY79ZOzYr27ucP8o78c=;
 b=IoDqeCFiu2aquqRKoa9CHLSMIimFGyYx626bSaZvD/IsO35pHOwuxyPJGwzTXmabQepV7JMzHC1CNobZRdXsGGzp+LH8TJkGxn6EaBwJ4xz7671B9QFY/Yf4Z7D/RUTP5/lz/gBUkcRB+3feKnJcAKhPle+BSGvjmMYG6UcJtKdCRXiBtjnz/Hjmebqqk4PDb0ZYyYaTOr2SMLFgcc31/ifjEDkaQtFaRsULTuG6q/tdQ4afn5QZOQP1YjRUZNjXaNTJ5+KBsGHIpcQ2uB9ldf8Zd4am1XB4s+Mlh7Ni75s1eiAX9+wYq82dU3QVeOLVLrhS43gIw5G5aZj8DRIs+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBQMk1yX8inh6AcvRcc6e54ToY79ZOzYr27ucP8o78c=;
 b=LmLm7h1O+3mreySFGbp+s6tKwQgQoCJ54hUKqMyec17Ymp/MwPPWrgSAVcPfWRju0qmH/bGjTIheYxnbfYx9PIa7XesqI2mYk38pnqBYLG3sxGpydyBJVoEdpHnb6hHVB4/h7ledGoVr6x1TlN0p+ChPQxCt3hJCLLOwpNH50I8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
Received: from DM6PR12MB3466.namprd12.prod.outlook.com (20.178.198.225) by
 DM6PR12MB4057.namprd12.prod.outlook.com (10.141.184.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Mon, 23 Dec 2019 20:46:30 +0000
Received: from DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616]) by DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616%7]) with mapi id 15.20.2559.017; Mon, 23 Dec 2019
 20:46:29 +0000
From: Zhan Liu <zhan.liu@amd.com>
To: amd-gfx@lists.freedesktop.org, zhan.liu@amd.com, hersenxs.wu@amd.com,
 Wenjing.Liu@amd.com, paul.hsieh@amd.com
Subject: [PATCH] drm/amd/display: Don't disable DP PHY when link loss happens
Date: Mon, 23 Dec 2019 15:46:17 -0500
Message-Id: <20191223204617.2174-1-zhan.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::33)
 To DM6PR12MB3466.namprd12.prod.outlook.com
 (2603:10b6:5:3b::33)
MIME-Version: 1.0
Received: from a.amd.com (165.204.55.250) by
 YT1PR01CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Mon, 23 Dec 2019 20:46:29 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 263c9cd6-d4fe-4998-d7a1-08d787e92fdf
X-MS-TrafficTypeDiagnostic: DM6PR12MB4057:|DM6PR12MB4057:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4057BE1B10DBD58D7CD534619E2E0@DM6PR12MB4057.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-Forefront-PRVS: 0260457E99
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(16526019)(81166006)(316002)(44832011)(81156014)(8676002)(2616005)(7696005)(52116002)(186003)(6666004)(6486002)(26005)(6636002)(66556008)(86362001)(66476007)(66946007)(36756003)(956004)(2906002)(5660300002)(478600001)(1076003)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4057;
 H:DM6PR12MB3466.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H1D/WJP/j6Vt3Qx/zTtd63zg4vPm2U5+d3Ks+aFKnJVUknFl4/fP/OWHuyPbqnZ+qe4vSJn6YL1VfnjJTbrVjQJrgtw00vO//dFQvXxi4fZHk5XL5T+pdHsn6wMCrawuHgwjVfOUtm3ABcKMUYsMThH/hfNED5ktpdxnW8yOtdabp5SsJEJymDmx+VrVIerAHn5EoNOSoXvEthPy9NaPrv06DwpFZ27LvJuYVVKkYjmG8kDAQRpwx9Tuh2VLC3wSw7tUgnqWB1VeURj0zW9sDiEuoRy8potyaL/9jm4E0KBKWy/zwcvky5YpWvFkEorJRA2FPMnpRmCW9aDTl+ZqunBLDPrvQa1nUcbd2osHrAGlIxDaI9fQIkRPaFM5L39siTi18bCv5Wpi38HjOztbIOQkO8AqHHkgHbcidmIaQPA4Q9H8rZX67gZ2nSH0iTNg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 263c9cd6-d4fe-4998-d7a1-08d787e92fdf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2019 20:46:29.8861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KtTj9eQUB5MwfbQ1+n58hPcsmxKxqFjyC4w56VnQoReTIilHN/ZD92wzky0DwBpF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
There is a use case that link loss happens accidentally,
and we need to recover that link loss as soon as possible.
Under this circumstance, DP PHY will perform link training,
then try to recover the link that's just lost.

However, if link PHY is disabled by code here, then
DP display will never come back again.

[How]
Don't disable DP transmitter and its encoder, even if
link loss is detected.

Signed-off-by: Zhan Liu <zhan.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 38b0f4347383..49f48d432923 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2876,7 +2876,6 @@ bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd
 			return false;
 
 		previous_link_settings = link->cur_link_settings;
-		dp_disable_link_phy(link, pipe_ctx->stream->signal);
 
 		perform_link_training_with_retries(&previous_link_settings,
 			true, LINK_TRAINING_ATTEMPTS,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
