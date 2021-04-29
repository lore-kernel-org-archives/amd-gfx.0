Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9ABC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:54:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC686145B
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC686145B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B89B6ED8D;
	Thu, 29 Apr 2021 07:54:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BEF06ED8D
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 07:54:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEYeVUgv/AdBljWTVm7yTe5sF6zhD/4oG9/S2JUu0iVdqHDQ/ADWrjHVG5SMJdItMa97MMyNt+AbcUO4WlnpmLiyCzLJLZdts/9BhXhTC7pAC6k9bN36NwiVH8oLCs4eYuTSNV0UZC89PxzNayjNsFsXC3INy8T4xIkWJyCpohaLGB3nAoEisDr0shwnKYBAqv2N2We/CrHc0yKyECCtDOfwSQCDXO3hosMfF4A9vpD1SFYSrJEH/oseTGUODvvITNLVSGkf7e/1rS9CY77tkWcgQpfSM4tyTRCK7muHJYl1KgslW3+EgMv971brr/tWI4e5FD+k8KVzcb/o983HCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nx50Jn8r+GZMG9edeZbALTolHuhISbpyy446U5lQHw0=;
 b=fjLiJ5IopO9EhAsqn6S4kYgceVqDzF9GgEVIy2oV5HDYt4dVbmWpaYJG9Htd+kabCiLaOKufooiKBpmxF0EfLWeVIn4dlxoH+c/Wb9FrIs4gj3Wa46VOVLT13SC/cNEOy3V9cqEzyDy0bRtvZ56sZQ7fjSOfcGzY2AilSRlEHJo21xME2JBDosdoooOfWvdp4SL7uRxqF0X6a6SqC+SsaXmJiqDi76Pj0AzL/cBkitadc4gFONYqQHAABh3ZqAjANZ69Ry911i9HwtoamhIJaWwjKwiQTc58JVzIYsLw/5l5fCJnPV049jjJqlSzkcyDgxuap547zPoe9p9hUrzYyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nx50Jn8r+GZMG9edeZbALTolHuhISbpyy446U5lQHw0=;
 b=NwOHAqZ3oIMrwd9HN2JD3lAgISOz55rvv+GOoqw5uFdjFH1C2cNhfNbyUZ+QRXxKcgbdRpj3+xEbjooxK2dAyM/j4uhEcuI5koiqMupqyAKb7MtIPRdPv/jY+Dh0WYxPsKUn5T9PxOviytkvzvzxmAZMI8xyTn8ATIte+/gif2A=
Received: from BN8PR04CA0037.namprd04.prod.outlook.com (2603:10b6:408:d4::11)
 by DM6PR12MB2778.namprd12.prod.outlook.com (2603:10b6:5:50::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Thu, 29 Apr
 2021 07:54:54 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::32) by BN8PR04CA0037.outlook.office365.com
 (2603:10b6:408:d4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Thu, 29 Apr 2021 07:54:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 07:54:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 02:54:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 02:54:53 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 29 Apr 2021 02:54:50 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/14] drm/amd/display: [FW Promotion] Release 0.0.64
Date: Thu, 29 Apr 2021 15:52:05 +0800
Message-ID: <20210429075206.15974-14-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429075206.15974-1-Wayne.Lin@amd.com>
References: <20210429075206.15974-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afa58fde-ff6f-4e92-852e-08d90ae41375
X-MS-TrafficTypeDiagnostic: DM6PR12MB2778:
X-Microsoft-Antispam-PRVS: <DM6PR12MB27782A46CB241CBD62B1A856FC5F9@DM6PR12MB2778.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D3HQDsHLDqi6HJpPxPEjDwwr//mobtlRd2q5S/eSIjjDysxx10njJ4OzJEuAKzVE5m1mirV3+bhURysjXMUq3Uqtz8UXbrFPfmk0NQv3ay1SzhllKiwEjdgoVb9B3NVIeEBHFfJW+fASQjzFGNcXz7gki7JLwKeXlaYxF2HGnGmIqt25Uu6KqB9y1hDD/rWRKVTTr5eleitIDmTy1EaWXQKMHSeZvJ/BxIprWpLXNBnAEK6fFmPFXwSKizeoOoD/rXp1iDePGwE+N0dKCBRTuk6FePu9IYt3jL+1BBLSwCWwVV/eyd5dqsCtfCTId+mLat62LNdWxNarE49zaXpB9YlwYDPyHK4QD5XhFCOvJT3kfVEwtiR9rykCy62hjqBW2Bmi9yrL+Fm3Rq4xyN8XcblJc77sNesZK6A8yE6IC9KRAoTCfC+UUA9mHajZiV2My8Soc4iqO+cqnRhwG/7TRt/cwSjZ/jK8wlcUEgBGeWgb1UniyeEI6TmmFvYeThKPwBHhzIy3nuDqmu8noVjuxXoC4qH2uL7iZ9maEJaa+Cfnr7H4XWZWtYfmAak2QiXvJ9jBmcb6S7fLWA55G8m6eovlK6OFJq0UeeYZT9lp8XPbu7J8B4dUm2tbWXAkGlWUCPdv64/7ZLg7fScBuDVkkSJYh+2KiBdprmC9nzvPCWPd+i+T4p3vOPga1a1caZPe
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(46966006)(36840700001)(2616005)(186003)(7696005)(36860700001)(4744005)(336012)(8676002)(81166007)(478600001)(356005)(83380400001)(26005)(316002)(2906002)(82740400003)(70586007)(82310400003)(4326008)(1076003)(6666004)(8936002)(5660300002)(6916009)(426003)(70206006)(54906003)(86362001)(47076005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:54:54.4496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afa58fde-ff6f-4e92-852e-08d90ae41375
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2778
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 95fab1d3d7af..8df382aaeb8e 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x41548deb6
+#define DMUB_FW_VERSION_GIT_HASH 0x9130ab830
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 63
+#define DMUB_FW_VERSION_REVISION 64
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
