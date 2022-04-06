Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB98DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Apr 2022 18:41:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A99010E1A4;
	Wed,  6 Apr 2022 18:41:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B90310E1E2
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Apr 2022 18:41:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9XBBLaLJFg3sLITGeaJIKabaLARZMR/h/i0UQH11Xs0u8mUFXmFjS6+YtfW1P4CVX4dMXvYjQ8XjXo+fBp6JMVTTwNrDC1oB3RMMGcZ74GVOJDUzHLzAG8LGsED+7mtpDrx95oKTfQqh3u9YQO+RDK8ZzclZc/aRcRhnWoGHcpvCEaX9NANDozWlOvJQnUTkTSLSyUelGEcujFER+XjH8/8yNRUmlNMsbj9RpSL3hFQ0UIdN5h1LGYTWvuunVlvaUlRRks5HGbCY9lF10VALK5f1Vj7LIMCJLodDKJrXNuRtRWns57TrbP/O8d7VuRP/PtUZpBvGzuSh1pvJus04g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asB8E7hmUuP45mSyDZfjl3/3r9XL7dIkGPqaZJxJ0FA=;
 b=fkl0trjySqnkH6VzQUmvv2YFuT9ibt9Be/dtSMZ0ueAubeRZGFjQsH2GgR2fig3/4HA6YmfBAkrQozmGLArhaaL5UbdoaswQ0xfg2VyV2u+6xFgTFLCuwD9pkBlZ1aCOwlcBjhvyjN09Z8UgW/mGPQXcRIsce6vQCmGVpSdqqNj6UVbSneo9vQLjnNmHi2eRshrlFHh/LGXBQ+O8DUWNJeNjwJA9g/8SmITmw/D6pbj3pTCCYmsUhLXpEcDBtLshCK60sM/XQ3mjrPFE061aDngYM9J7vDqxGWaYlwO14eDmenRcJTbYB6xOwh9dKLLz76Y65JusWXDKPD6Uv7AuAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asB8E7hmUuP45mSyDZfjl3/3r9XL7dIkGPqaZJxJ0FA=;
 b=uiLMmJ9DqFzgmkXeVxlW7yoDImDJxhVBASSi4pDwOGl+arcQBLrILLI458pGaue2gc2GftC9zDMJo9QIvYzkgYzmPrQTitwjk2SrUDvah4eJvyfUKRvrLUpONl53I7Tj3PXqgN5OomOGGutQo6eC8rkjV7Jl4ly5I/G0O9HATM0=
Received: from DS7PR03CA0078.namprd03.prod.outlook.com (2603:10b6:5:3bb::23)
 by BY5PR12MB4888.namprd12.prod.outlook.com (2603:10b6:a03:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 18:41:34 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::f2) by DS7PR03CA0078.outlook.office365.com
 (2603:10b6:5:3bb::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21 via Frontend
 Transport; Wed, 6 Apr 2022 18:41:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Wed, 6 Apr 2022 18:41:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 6 Apr
 2022 13:41:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix VCN 3.1.2 firmware name
Date: Wed, 6 Apr 2022 14:41:20 -0400
Message-ID: <20220406184120.540874-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bff4bc1a-c0b8-427a-a4bc-08da17fd12b3
X-MS-TrafficTypeDiagnostic: BY5PR12MB4888:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4888EBC5FD9EA48FC178E83AF7E79@BY5PR12MB4888.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KjTRNmZbOMpnU98YVdHYa7ECVG0GVGSa7OIdICWhsP3MNASu2HTVPt7Y7eCB15gxCMb07hLaoV1kKlUX+3heDIOIHOeJd9Wlv8MUQ3lt+h8hKgi01rc2az5A1o+pAKH7zFjht5VUGHwy/keTo33Qfw3LdLIEVGj48dKILyqFRNWqI5y1evcB+4dkRzikIKMprcObeeQWEfd+adKqAEaODNQHXmoieU/OTb3CjIgK6fYj78BlSp6nTqu0lOFQljGhByjC3ngpOGJmDmyCQN444afQUswAkd8S1XtSck2AD1xfUdpb1D+QYACWITLmIGX0YM4nRq/b/fE4VZomF1/RC1+KLCrSWytxIPZqh9aZr11qqYL8FVuLCtA1cxkDdL+LsILi6kZmu3Sz8E2WSfYPkMdbYSrkTjXqSlLpqdrfO9XpmBjKgQshhllqiqzqPm8DlJQTCHxdTQKhX7ViqG/3CJWV/ReX6hq91TROvEcGE2REOMURZEUbLWm2M08yLnOmlZ80ZtJ0Pm6vqhAi8o2sax+PYrrnkjLUTAHysZkQdrwMW6rwzs5PHQrwF55xvbeKzyiR7OQQIr5OR52n9UpTtoTK3fSJrcQ1eBRrd+mYEKMdoy+CXqIvbdKpe5SLIqR6NK7voMR1bIPhahvJZ9mv1YHSNGW5D85tRDdRSaZhg8Fur1AG0CMQ/gAT64UZTp0OReXYKxviIqcC45SaJP6IxPw/ildqgjfRryx9UyBD1gT3qfVzeM40/utwvzBL+9x9McymmUOeJ4NjTFvbRm7k0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4744005)(82310400005)(36860700001)(8936002)(86362001)(4326008)(70586007)(5660300002)(47076005)(316002)(2616005)(8676002)(6666004)(7696005)(36756003)(426003)(26005)(508600001)(186003)(336012)(1076003)(70206006)(16526019)(6916009)(2906002)(81166007)(40460700003)(83380400001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 18:41:33.3180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bff4bc1a-c0b8-427a-a4bc-08da17fd12b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4888
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Drop the trailing vcn.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index f99093f2ebc7..a0ee828a4a97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -52,7 +52,7 @@
 #define FIRMWARE_ALDEBARAN	"amdgpu/aldebaran_vcn.bin"
 #define FIRMWARE_BEIGE_GOBY	"amdgpu/beige_goby_vcn.bin"
 #define FIRMWARE_YELLOW_CARP	"amdgpu/yellow_carp_vcn.bin"
-#define FIRMWARE_VCN_3_1_2	"amdgpu/vcn_3_1_2_vcn.bin"
+#define FIRMWARE_VCN_3_1_2	"amdgpu/vcn_3_1_2.bin"
 
 MODULE_FIRMWARE(FIRMWARE_RAVEN);
 MODULE_FIRMWARE(FIRMWARE_PICASSO);
-- 
2.35.1

