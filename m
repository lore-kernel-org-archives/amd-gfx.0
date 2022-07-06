Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA6DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jul 2022 14:05:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4A6D10F8B4;
	Wed,  6 Jul 2022 14:05:46 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2051.outbound.protection.outlook.com [40.107.96.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E156E10F8B4
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jul 2022 14:05:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWaq0XtJWX/Ww2DcJtkZ7N2izEttnKJ4ZkX0HZhd5DeMtG2U0foRSUANASmZr+MoYiOzJeppuKpM0rhSUoirX93AZRw3cYbXOOYiDqcIB72SYxnF8KqHWbTjh3V3C7J9qdjHe3Q8Dx5xaBGvs/pFJWOzOoHy/iON5iXoipuk3a+uQJRqK+H8LfWEslcUSZUdPVL/O4lIgqmYOyBaM8J/fOHxUydsKBSnLPMMoWVmWyZPKCilhBp3gZdbWiFqOM1Iqy+ScF3xY/pPhVZh1Fn5TM80wlYZ54AI5/IiTnMhrrz4/0emnFRyqj4jyqV21BxWXw2uuXJUWPh7dfE+OiaRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glR4IF9X5MAKty/+L08JMy1n1kXWotV16VtBGjb53Sg=;
 b=WBwQbrcMSKOuCKtYr+LPrgsQAsYgq/vLzu+DuQ/lI5OcRsQwENIjozrlspfluMcmczsD8Q95bdg0Uiit6KqHfBUrS/VawnM2LpnWgB5yYYJFjHThp8EbRMFl0o57iqW5gDGHImY7YJwFymOMCVzi7srLVWxVCpk/ZffCgx/meU7/gw6qp2+JAK2gfT0i6NHpX+A74WtkrQQpgmy+pwNAiqRkmlDGFuoUCUdIKdQa7BQtGin4giOJK12ZA7dCQesE1VRz9tK+Hz4/Id9FWgj0CHzTno6WQwScRqaLZLzXJIEq3BsNNkS/DdSoINKNhmJetW7TDjzHIuiFnF9hosPegA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glR4IF9X5MAKty/+L08JMy1n1kXWotV16VtBGjb53Sg=;
 b=U5qBz9eGD3YpK0f5ncaus3MbxqtN0o4l7LgTcr9M0rLsyTyqf1E7+5MaMhlFdNAjP1ZRW7eEuGjpvKFjcM2GgJAY7ArzwW0Be0NNm6J5GStewlZT2IWK4u6RMhU4jRjWct+lWH7Ky2OIEGsCxhqtcUgBs1ha8OPLEWdPLpG5eYM=
Received: from MW2PR16CA0064.namprd16.prod.outlook.com (2603:10b6:907:1::41)
 by BYAPR12MB3349.namprd12.prod.outlook.com (2603:10b6:a03:ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 14:05:43 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::9a) by MW2PR16CA0064.outlook.office365.com
 (2603:10b6:907:1::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Wed, 6 Jul 2022 14:05:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 14:05:42 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 09:05:41 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>, Aurabindo Pillai
 <Aurabindo.Pillai@amd.com>
Subject: [PATCH] drm/amd/display: Add missing header
Date: Wed, 6 Jul 2022 10:05:25 -0400
Message-ID: <20220706140525.907320-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfdf5624-0d78-4a99-fcee-08da5f589d8a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3349:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MgPylb7AOhhgVyCEejJUPSHk/h1VmsM15kqc1sKD+r7GzQGLo3t3XAPaEfBmeFeJflDoQwyTcCzEUljfkssD8aoiLtfaUz6nhuTvE9dlrqZil5UoNLDBLnY6ZGepEymz2fqikMeTZuWtEKWEDCyqlGSLMbHWpNSVYkRVbMd87atWLMcNUWR664k2vj7KHGA83vuYIs77mVy6TOIzYelZakvMSfC8PqIFRD1uVu2D2Nn+NybeArfGpR0pxIKhSO2+PFLvsspj8hgxI49xJhqW0B4WZRjACm3C5j7qGRSx4QGR4zJ7Y3V/b4r7TF9EZSc5b84Bws98V0n68jr8fZo0m4EJHwqtL3Au7XI3oLOG5ez7wEzFce/mVy+OaPhFlD8wxhYKhEga0fWrSADdK8LIZpFyg4Y66Z9myH0M7AjiRUHSmC4k34TnM7VGrrnYczTPd4ZnJUUes+oAQkd3gn9B34j4jqPCkDSAobN5vesdL77NS20ttgegGbC/aZ3CVJnUONxRQmzpG+NakNK42CNiMNzvGKreHlBttuVb36yZ9Pzsf4CnMsAyyS9+w6f1AogTWmFXbxEUdrQb7hinXw1OGnZK8aKsVpwbfroIliUqBc+dMm8AnV7klGSa/be8DCdhdPQ5ReiHNkaX+gFlkb/dQ3DDdUDCMDNZo9/BUNm5EqeMy14AejmwCx9RzFnMMJDfsIYgK85JfJJ085c5H3VzH3SZp94fPB5Npvk6RaI9Fw3hX5k2xMF7+hlT/BpeMqgBdNnP1fzY8iR7/WwPhdz05XA0K+/0iodUvKzBAlGAJ4HcEWyJcRfHGr3ePyAaFswZY4Xq9DxwvmR8G/KYq9qkRUrCAI5mFpHsoUsky6iTpiDD+qJ/zbMIHcSjOnnWg6fq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(376002)(346002)(136003)(36840700001)(40470700004)(46966006)(41300700001)(36860700001)(6666004)(34020700004)(40480700001)(2616005)(1076003)(82310400005)(110136005)(54906003)(6636002)(36756003)(316002)(2906002)(7696005)(70206006)(8676002)(70586007)(4326008)(86362001)(478600001)(16526019)(186003)(83380400001)(336012)(47076005)(426003)(356005)(82740400003)(81166007)(26005)(40460700003)(8936002)(5660300002)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 14:05:42.9364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfdf5624-0d78-4a99-fcee-08da5f589d8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3349
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
Cc: kernel test robot <lkp@intel.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Kernel test robot reported this GCC error:

warning: no previous prototype for 'dc_reset_state' [-Wmissing-prototypes]
    2720 | void dc_reset_state(struct dc *dc, struct dc_state *context)

This commit adds the missing prototype.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 02bbc90a2c80..7586500ec87f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1209,6 +1209,7 @@ bool dc_commit_state(struct dc *dc, struct dc_state *context);
 
 struct dc_state *dc_create_state(struct dc *dc);
 struct dc_state *dc_copy_state(struct dc_state *src_ctx);
+void dc_reset_state(struct dc *dc, struct dc_state *context);
 void dc_retain_state(struct dc_state *context);
 void dc_release_state(struct dc_state *context);
 
-- 
2.25.1

