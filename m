Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A452DC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 722FF619F5
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 722FF619F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 256AD6ED29;
	Fri,  1 Oct 2021 14:41:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A9C86ED29
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 14:41:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doxzdBgf5r23cysW4T43psJzpetxqHfN+L2LXgqN/wy9WNWkHSvybjT64Cx8HotKqjkobDWzXVKgXfUAlZSRDDf2btn5nOW5Mt2XMgMgTdQlobtyi+cVp6t4YbH9hEEigcAu32Fbdk/ZdKYw5/4EQrXS1UZUcXuy079mV3F30wqvWDjvu4SzqaB7jhAjeyj1Ca/zG6q95VenXgBUEhhyIjchqFFtn5LKdTafpfl6HdVmGtC88kdT9F80mTN70SnU6nDr3b4qYREO0xJHTtMl5HhzAGFYW0rGjkIVhn5UBus1hJGooXaAS5SW5lCNSS+zRKiY4h+5pgaydZCwFe1w8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=li9PeQ1r74eZmklXHLRN1bQEX4kjD1i1iiJYBuU/n2c=;
 b=HixKKtO+t1E2JahGXFWm5QJ05QjltDvE9kjPNtKUxtEY2eYd0SuPeJgZh3QeNUdT3yUQxv7piBUGw/r28L603aaw1zTazcoxGrXt6WjpI/4ibzJj4L+VLuYMBPElKAFmlF0imyyshH75bLwa8ef7kfqMzxidAgAUVx9z8gTS+iYy9d3AuXa2R5n5wlgrgYAdRBnWFwloLpUKdnJbLvW2Kj++jr7teZMdNmq/DXb6LVH5R1c3eJvCWLcujKPsKLSkWhOijH5Cj+ib8zc3S7AUZlhDvJp6Gf3osSiTlpMvoMK8DxU8BIaLgPlheFqMGll6eEreO2DVQtEG5H8KtzgGWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=li9PeQ1r74eZmklXHLRN1bQEX4kjD1i1iiJYBuU/n2c=;
 b=oPbbR9+2u9OQVTky2LKUos4TDGeyZI6vJYvvy+VHZhIsskh4rgYg5BMeE4+cbuMnIougxrhjmla7lEUxoDY7Ymuk2U69fSPfECw6j1maLDhyMAlyJ6t1m9Z4KFVJbWnyXswe7NV1OKmZlyNIguyKbEIpgt0oZErRwfw+NpsOPUc=
Received: from MWHPR19CA0017.namprd19.prod.outlook.com (2603:10b6:300:d4::27)
 by BL0PR12MB4899.namprd12.prod.outlook.com (2603:10b6:208:1cf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Fri, 1 Oct
 2021 14:41:51 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::2c) by MWHPR19CA0017.outlook.office365.com
 (2603:10b6:300:d4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend
 Transport; Fri, 1 Oct 2021 14:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 14:41:51 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 1 Oct 2021
 09:41:46 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 11/14] drm/amd/display: 3.2.156
Date: Fri, 1 Oct 2021 22:36:17 +0800
Message-ID: <20211001143620.192679-12-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211001143620.192679-1-solomon.chiu@amd.com>
References: <20211001143620.192679-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4fc0099-3b9f-40c4-163d-08d984e99b04
X-MS-TrafficTypeDiagnostic: BL0PR12MB4899:
X-Microsoft-Antispam-PRVS: <BL0PR12MB489921B65AC846AC512F6DD197AB9@BL0PR12MB4899.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oCYpAMGOnOVlF3c7p0wfp35bHyKNlOl2NYqLNtRzyXjkMr9NFsAieEbWzBtyqvmksRHWM2y1oBd6L+yCO1isn6p+13CCINMHbykywrTal3Xbc5Iw7delDGwQ58FVvq3GM2fif3uaC+/WprGk4soHnVbEAeyzfIHnkapWm4/KL/utJccrjiCf49dxZPJSHQCr/LOdfT71fDmZszrcGnqvT//o9ZywQGnYzrXhvNXJuLWeY/ZsLqn2ObZto9bcD/KAFJrBWIcnRdN66yoRvv9nSJeYpXE8kF8i2ws0toQC6cLwlxgc3+Rg1oxw88JI32h/Vo0F8zUJFtoovnEGDPRyzHgq7yDpwAPdgJybQgFEKQcTBvb2aLXVD1VJ/xYZlkAEiYVrvhTGR82X1nrfDsF4BJtqbRf0SY7zX+9KgM/RkYYr617srIUjciSOZJ2WsUcOKDS2yv0/BoQMteP7FJEI0jZY/QJF7vcHD6XPVONJoSsAEood7yrtlR99OiGAo//3CcG8P/F5UfX4q6DHt/grYUdkYhvExDbtNEeuYnekgMRo/lBuuSQzEmFfH/apAVXl95fdPB22KhbPl56cgOKYirvwz1Y4i4PaZ2jmLOylQJTf6uG5CcFoXNZcjOHkpyD4/d2SKL0D5XCICfrhzuDWupBTGM4dePMoJkvOS+3QxzCKxOXuzJASYg0/89wjUAWseRog8oZjGPCSWLtwtTziZddFi36DD8UR/W11mfmUU1g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70586007)(4326008)(6916009)(316002)(83380400001)(81166007)(36756003)(356005)(336012)(70206006)(2616005)(426003)(1076003)(6666004)(508600001)(47076005)(36860700001)(26005)(2906002)(186003)(8936002)(16526019)(82310400003)(5660300002)(86362001)(54906003)(44832011)(8676002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 14:41:51.1056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4fc0099-3b9f-40c4-163d-08d984e99b04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4899
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

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- New firmware version
- Fix DMUB problems on stress test.
- Improve link training by skip overrride for preferred link
- Refinement of FPU code structure for DCN2
- Fix 3DLUT skipped programming
- Fix detection of 4 lane for DPALT
- Fix dcn3 failure due to dmcbu_abm not created
- Limit display scaling to up to 4k for DCN 3.1
- Add helper for blanking all dp displays

Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5ffe2a41258f..204bab6f82ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.155"
+#define DC_VER "3.2.156"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

