Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77365C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 17:06:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40FE4214AF
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 17:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vPyC2+He"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FE4214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC0A86E057;
	Thu, 12 Dec 2019 17:06:27 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680047.outbound.protection.outlook.com [40.107.68.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 307EE6E057
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 17:06:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMIB5AZ5zUzRViHMErXMonRGP+MKizh5rH7jPoi7k4ORZXWS1i++y/Kd9EWQ//jcv0a/4n4z1yJyqz/QWZn9WAFWIsuOoB1Hf6TTd790M+hpDC5Ufah3NRDubnnrFKdic7svtrSsG5CA/hrl4RyTEACkJQqRsytgcNBtQFhMfR2eJvamiPaLKYJ7uIGNV4RLWYlmJRGMF0e8hSdQn/mu12m36vNYdDzj8KhfnFAZK+Sgw+yBmMb4K6te2HOMgH3rFs4c0NKOliAa67GKeVfIPKN5a7RF4O0qp6j5Y4KIMhgAytwjd2zCw/jnt48KEjZuoHsPpaxLKbuBEoVCz/A0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3I6mT9VrAIknChpXzuKRpTXbk1b8z6F1Gkb1g8G9E54=;
 b=llkLZOmqtxvTmeOvTwsACW23lrOfTswZ/rbENLMAPs6wSeDJmgIj5SVl6y4RS0qSBK9qTFdLkvJ1AoNZu3IhIgT5wVW7lJH95PWQSnKIY+TY5dlEJ4FV3gAHtcz6ocHub0bPZtoaG7P4V0ZZpZSYTKVscDU/AgRZup045pwyqwLrVgPNthOUi8biV1tp1nSSfqvs2zRTaKDDWqflEZ5NYi+/5Bamd7PKbHIx/c9+fUrbjF7RceFyl20m6/cySmxkS19ZhPY/9Yy2FUma30cH3zTpm34XTsEzb4mEUIY2dNut2MWZtcOfSED2wtVpNneiiTysEDunsKsLDQYYzYYY3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3I6mT9VrAIknChpXzuKRpTXbk1b8z6F1Gkb1g8G9E54=;
 b=vPyC2+He9nFJ7xhFI3aObthoPxnv5+sFWweaH4Pf4xg2FV4GsVXddtG9xEiL+Ff2U8bdvJI3/kFswJEXyClxxGU+gX+mOeeRUBi/EpAA9fOdoMl+7tx8NAwEgnspkYPf73RYm387rRTr/q58CuUCwtHll1Olfp9/38WbwFH3Gd0=
Received: from DM3PR12CA0131.namprd12.prod.outlook.com (2603:10b6:0:51::27) by
 MWHPR12MB1776.namprd12.prod.outlook.com (2603:10b6:300:113::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Thu, 12 Dec 2019 17:06:24 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::205) by DM3PR12CA0131.outlook.office365.com
 (2603:10b6:0:51::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.16 via Frontend
 Transport; Thu, 12 Dec 2019 17:06:24 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Thu, 12 Dec 2019 17:06:22 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 12 Dec
 2019 11:06:21 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 12 Dec 2019 11:06:21 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/6] HDCP fixes
Date: Thu, 12 Dec 2019 12:06:08 -0500
Message-ID: <20191212170614.24837-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(39850400004)(428003)(189003)(199004)(316002)(356004)(86362001)(186003)(426003)(6666004)(2906002)(478600001)(4744005)(7696005)(2616005)(5660300002)(36756003)(8676002)(70206006)(81166006)(1076003)(26005)(6916009)(70586007)(81156014)(4326008)(336012)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1776; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:ErrorRetry; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c223dc34-577d-48b4-0794-08d77f259d54
X-MS-TrafficTypeDiagnostic: MWHPR12MB1776:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1776CDF432F405A84BB6EC4FF9550@MWHPR12MB1776.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0249EFCB0B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9k3fbeb2a8bDFwNGXNerCJEFls6L7N4ZsLNPO/9EDW41sBmSGt83JmPs2LCVA73P/DwuJU1ctlTKcJ/90h8i/F4jLzYh/J+UOllstEq+Bojwgr8JAbWUBtYO4MzvDlYrUqXT9FpH971rN/CwOIBtQBtXwD2DUaMJoaWVFsMER7OxG/iscHXRXOyYBqZTikdjSEml+j8hGAxNwzlbXwJWyghoL3Kd4ycZveSoCgEI2emnBYI8JCIjZqJ41Ck61Ouyzuqq6GPOx6cIYWgH2kspEVnzh/lZVPR5l4K5pXE0o86H7NaV+6TErAogN7UTvA0PQChImL30aeQ5wlnV6XIO6OebOSqCiw9qkWaOEn203a6JWZVlGAUpVPaCDnQ2+tB10Aaw//G73yQ/folqIU7+I2kdm7bbRIKkxzD1jksx9RCkrxbLqCSIjAH0ocoZ6sNd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2019 17:06:22.4690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c223dc34-577d-48b4-0794-08d77f259d54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1776
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Summary of changes
*Fix return codes
*Fix some displays failing authentication

Bhawanpreet Lakha (3):
  drm/amd/display: fix psp return condition for hdcp module
  drm/amd/display: Fix hdcp1 create session
  drm/amd/display: Return correct Error code for validate h_prime

Jing Zhou (1):
  drm/amd/display: rx_validation failed resume from sleep

Michael Strauss (1):
  drm/amd/display: Add delay after h' watchdog timeout event

Xiaodong Yan (1):
  drm/amd/display: add event type check before restart the
    authentication

 .../display/modules/hdcp/hdcp1_transition.c   | 20 +++++++++++++++----
 .../display/modules/hdcp/hdcp2_transition.c   | 17 ++++++++++------
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |  7 ++++---
 3 files changed, 31 insertions(+), 13 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
