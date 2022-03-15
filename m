Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A2AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 19:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2064610E0A9;
	Tue, 15 Mar 2022 19:07:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4FEB10E0A9
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 19:07:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWYGpep4HL0yShoXIlux3uGlQePDGPS1W1KI6ne5nE9iF/XkpjYXjnpHposd7ByyEda86WvN7ps61tuahslE8F35KPo0MA/fSP5Uy7rpjKJJiHCjRHZdueWxP4Ce6deOVzboEF1Ag/otQON+IiOC8efBM6uXN/2G5Zb8ssxM3Pgs5DBn+c7Yn+DgqktppMQpJaJW5TKUWzCyw9kFK2UxeCOX6X03H9EnOMdcTM4Df4VDZRZwxPRniD2dnyNKDvdKAjBTeeLSORr+dKgHNoVy4jSwtOoaxB7V29kJUa0vHogSCxQ62IzELC5J838a9dtL4McxE2b9WzSrlj8pa0LUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoCMFLhaydiojkr+AGseRyM0LEOm2b/VmtZJFIrg33U=;
 b=Z7SN3ZfCbE52j0Oj7AQJZO3Ojl1S8/Xvy0cP3x1MYKAvNfLAm9k4MzyPpLDZzjA/ggqtqZb70eWoq6B5s1x5sb5rBmDWk46GOY9ATd+hZn+zriOeXV1opPwj0Y2VtmbBcurHLOdzpiZjdGAKqGAncQAX+O1nr3aJK5xcdYP9ZmWnr/Iij8+7v5wB58vsgDQScomm74UaxQFsa+UQnONQ6O2xS5TnI65wL4CF9SkHt2nHp78scgS7i4+oZXyEoarn9YHY3gypZINd98l4mKPlKAmHc29A6bRcsfmW1Ty2zS7Vr1V+T6AEqCgcJUT1gkloijJSoKrKTTMjrZhfwx05kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoCMFLhaydiojkr+AGseRyM0LEOm2b/VmtZJFIrg33U=;
 b=WOuAfm7wbNgaR0NMh4TJSm4nynf8IyfSZAhbnLqgEp32zsLOKe+XUcdu7ao4/hFyK9hlUWyXE4K/sO07Y6RG3i5jN8UGdiZ+/iNYAyuRJNJrjlD8E6sL4mXs4OgaVTYdOpG1oUem+b2IQPiiuDtDdhQdc4nLBUVmsjiTl6cIuMY=
Received: from BN9PR03CA0033.namprd03.prod.outlook.com (2603:10b6:408:fb::8)
 by MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Tue, 15 Mar
 2022 19:07:27 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::bc) by BN9PR03CA0033.outlook.office365.com
 (2603:10b6:408:fb::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24 via Frontend
 Transport; Tue, 15 Mar 2022 19:07:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Tue, 15 Mar 2022 19:07:26 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 15 Mar
 2022 14:07:26 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 15 Mar
 2022 14:07:26 -0500
Received: from elitedesk-aura-ub.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24
 via Frontend Transport; Tue, 15 Mar 2022 14:07:25 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Add USBC connector ID
Date: Tue, 15 Mar 2022 15:07:25 -0400
Message-ID: <20220315190725.2454655-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 384dcbce-72ab-4b30-4c65-08da06b70ba1
X-MS-TrafficTypeDiagnostic: MN2PR12MB4032:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB40322BDC40B103EA95FA56428B109@MN2PR12MB4032.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c66qlk6qmSzVtcaw9RkdGR1/2ppVLHRKTEtBnFdKlfK940g4H+8SKnSP6hi52iHajkaR4C35HH7dUOLMFMpjIcWPpZwCVBuCDDN89+zHpOFXGItS9Jc6bIQvgHtWlN1sGJWkRYWD9Ph2k4VPd8ARgH09ckEaXLku/kafjeGOCCNWR6tICQl+VZAXKMCjLE3LL6r+Uehihay9QefA97/0CH0gg09a9p47fMZMaZrj9b6+KwnVmWEWZLMtKfbJjwTkNUR5DjIf5pmCZNzF7ln1j8ATiB5AWbiVM4tJ2j/RxJhRO9n9MzarZnhes5kHUo7AlKDXr0fEbfAPFWDL1YjVYJCl9PS1T3lpUSUMTOeaIEkZfOPGWnxQj45IO+3VBfX2TgVKOxAKdHa3+9K/sk9InCOZgfOrnIQWn3SrPWBLEDZ3q48xtvelTa/oxq8DnegMo9w9bfF8Lsbj+H6EJRWL0Bl87aJOh2OKeOh0vPwgSRoZZYKKKCySbyMTf4LN7iOj2oZYM+jDxFFod/euF/4KaG0uxBuy2HGRMDvToHS/0oy0kTy4ESULE8OisBDVw140fiTxoOJ+qNw9ewNrZP2JgAxfegqC4vaJ9IPqd+aJ9dQuxCQgAVq2GGGIWfePDiJ/YUXSdtt6Yl5DYIpFRLhiJ6uuYCWftAqegozSylQBoKK/b5v2byIGkZKc31UpKMu3H3568gc6SiiYw5CdhlHD8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(83380400001)(86362001)(40460700003)(82310400004)(356005)(8936002)(5660300002)(81166007)(508600001)(8676002)(4326008)(70586007)(2906002)(70206006)(44832011)(4744005)(36860700001)(1076003)(336012)(426003)(316002)(26005)(186003)(36756003)(2616005)(54906003)(6916009)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 19:07:26.9623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 384dcbce-72ab-4b30-4c65-08da06b70ba1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4032
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
Cc: aurabindo.pillai@amd.com, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How] Add a dedicated AMDGPU specific ID for use with
newer ASICs that support USB-C output

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/ObjectID.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/ObjectID.h b/drivers/gpu/drm/amd/amdgpu/ObjectID.h
index 5b393622f592..a0f0a17e224f 100644
--- a/drivers/gpu/drm/amd/amdgpu/ObjectID.h
+++ b/drivers/gpu/drm/amd/amdgpu/ObjectID.h
@@ -119,6 +119,7 @@
 #define CONNECTOR_OBJECT_ID_eDP                   0x14
 #define CONNECTOR_OBJECT_ID_MXM                   0x15
 #define CONNECTOR_OBJECT_ID_LVDS_eDP              0x16
+#define CONNECTOR_OBJECT_ID_USBC                  0x17
 
 /* deleted */
 
-- 
2.32.0

