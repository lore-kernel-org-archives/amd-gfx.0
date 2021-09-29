Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE57C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 17:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E30D61440
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 17:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2E30D61440
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE5676EA88;
	Wed, 29 Sep 2021 17:45:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39A396EA88
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 17:45:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWi3svh2BkxRWAzJw9AVL5d6Hy0rzRnLCm1MUm3HE2w25Tb0jiQht7J2LBkefM5AVzckDKUM302ZWkuGVncq+0vY5i9q7koqxK6APYPyevfjqRS9oSBQOH1l5e3T5ByYKM0YZDCQoRApG/H81adVfQjrUh8vZ+NSZjC8CobQmgN0He/LZ604/K6SwgSrU2MyPaD4y50niijRISfGExXunaegql2sJZSzjhaAcr5dr0TtGgakY0g+WHyA+I9E8LjQVsF+sHdkGbitEBWy3cB/gL7ZRIs/M2tIwvULat8baG9dgcoHV3foUWV9L/vTQmi5F2mhXoNY/XnsxzdQ6X5D4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=xugBFOY8kWQgM6WOp/PfH/puhPZ5B9CNxvBfT48aw+k=;
 b=W7BRljGXdttSr4TTm/z2XZ+ftMq25+hJBgqqaKM9rP5zdA1yrCdf91TJdzZhA157gD1/zeCXFZIvdk/Dq8zoW+Q1Usg4U+CnxTHpD6C2+VUGHBeSqqfOO4Rp8WLxmU4U5liAHmzbyyYNL9X0NSQ+DV2Fiu7OayEhm561caDLwXSGDNz854biQiCwzo50oLCASzzTLsU2N8/Dcu0QNjlrENGTSyLQ7S1H2LGNRiChFPvoXSglgA0T/vNy6unQ9XMTLiWI57a5blIFOiMoop/uLkUrAq5AKanfqg1Zy6vprPaYkuSRH8uhoC8tQSiGho4LmLpJvQrhlCANrY/eoCPEwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xugBFOY8kWQgM6WOp/PfH/puhPZ5B9CNxvBfT48aw+k=;
 b=TZn5N07Rr1PNnzOnIDFVNBW3l2A1VTmBdV5i4nV1wEO9GI0qDaawDZ8UnlxPFwfk16x0soyNCp0ItLuHPtvKkt5+y9TgFk62GUFmdq6IokrTiEn7JsVynLTETUwj6z4jklb/Tt0RMZneG2uVQ1Ju1z4fgFz8dT6YNGT0QhSeQXI=
Received: from MWHPR19CA0019.namprd19.prod.outlook.com (2603:10b6:300:d4::29)
 by MWHPR12MB1901.namprd12.prod.outlook.com (2603:10b6:300:113::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Wed, 29 Sep
 2021 17:45:33 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::bd) by MWHPR19CA0019.outlook.office365.com
 (2603:10b6:300:d4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Wed, 29 Sep 2021 17:45:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 17:45:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 29 Sep
 2021 12:45:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: consolidate case statements
Date: Wed, 29 Sep 2021 13:45:08 -0400
Message-ID: <20210929174509.1640343-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44fac8be-6268-4e51-39b9-08d98370ef70
X-MS-TrafficTypeDiagnostic: MWHPR12MB1901:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1901D9DAB09B84E547DF0449F7A99@MWHPR12MB1901.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9UAANJTre0eBZFgDacyeHG5+2KOm6foZ7VwF9Rs9t7DnGgdgzyBOK7fcCgHG3RwMvO+dXStjYyW995hGgRsCRXaViDNUQlYVdZgU6FN41KSRzoh1A4SIZ7I/N2NAh9S3Nrdsm1+rwUNJBweFOIVbiB44pV2UJ7W/Hh5BDfTFPIHmrVRNNzRRUMoC5a1hU8YlvwzF+j8UL3SNzUrOqYafA6+RQstxOWIBGrvdshGsrmdvsDPz+HmZ56C2l1n30hNX/Gzm+qJsK8hYc/I1tQ/bBFyPgVYlpgBkOzwS7+cu4ARQOTAYax+xXA+B3Pb0X/ZPRJp8gMw8MRX+7DBIQoJkN51SfoxqEk3hbWirqECpsFoKcNjV9KPdVPQJ9+lnemmViEbGoMRLBxxvLEibBp41mpmlHzD7HLPggOUqNFZ0NA1JTgRPbsCTBSy5xsi8Vl+SzYJ0hXK0w2UN30nhcVra8wE9KeV3XR9AhvvECN7EhQ+fAzQvQjtSTimebC9DNhBSOTNWk6uDTe7rClyQbOhwtXiOLxsG0ImR69+AgduEgmdJ7zwdAAZR5Na0C64ggyR+SCMoGHXIVtMGb3cfskCw1MaFk0nNUuhJyAl+hu87/EZHJXzNME1zFT8hH0W9R0pZM1NSB93/Q0/yfGihXwoJfvKUK8vHEthcDpSKesB+lCuim47GpKXrx7Y/h4cRn5z2RNQmqzXhMfaXQMU2VP7ToZOIqVuu2khCoL1i3CzMeTk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(186003)(2616005)(2906002)(86362001)(426003)(47076005)(36756003)(16526019)(70206006)(6916009)(5660300002)(4744005)(26005)(356005)(4326008)(8936002)(8676002)(83380400001)(6666004)(336012)(1076003)(7696005)(316002)(82310400003)(81166007)(36860700001)(508600001)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 17:45:32.4871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44fac8be-6268-4e51-39b9-08d98370ef70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1901
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

IP_VERSION(11, 0, 13) does the exact same thing as
IP_VERSION(11, 0, 12) so squash them together.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 382cebfc2069..aaf200ec982b 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -216,13 +216,6 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 	case IP_VERSION(11, 0, 7):
 	case IP_VERSION(11, 0, 11):
 	case IP_VERSION(11, 0, 12):
-		err = psp_init_sos_microcode(psp, chip_name);
-		if (err)
-			return err;
-		err = psp_init_ta_microcode(psp, chip_name);
-		if (err)
-			return err;
-		break;
 	case IP_VERSION(11, 0, 13):
 		err = psp_init_sos_microcode(psp, chip_name);
 		if (err)
-- 
2.31.1

