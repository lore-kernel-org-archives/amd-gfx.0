Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82720C4321E
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Dec 2022 09:43:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51D8A10E0A6;
	Mon,  5 Dec 2022 09:43:07 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB80B10E194
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Dec 2022 09:43:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGD4K3nsU3uBPY4jgbPoRLSoMEhSQFVJSCt5xKJH7muzHKE60C06a2XpTrrHCXg8Vz/Ze4ua1mWVhVgUZDJ+lEG1pMZtP00F1biddQjm0mFHv5AuUkFpkTydt/Yk3pqmlwYQS7bI4nq/7AdF+ZxxGAQnDhhHqndT7oKW9EkX4O90FOBhrZZZ4oYQJaUEkwcmHFER1NEhdYY1b68OYO6698wMFYVfrXY7JJcW4G/YNtIIc0Y8horRpU4bcmbdhElmjCvJMW2F6GFkoBVodPJMp+4PnxjAG12GnLmqnmDKv8yu5s31vjg5WvIBzlytvdV1XM+uwCfXJpyucRrhzFtoEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8KvI2g5i9tTn/cF/P6uHuj9lrizhGbYJdXG4kRdoLo=;
 b=MLTvvYLjNdNuhzE7t8Gsg16ecKZO1sOSDMACDeeG5n28QtEabflZCTYfTY5sIZpXp00k1dAg2WPBVKZJyx9RNFAV7lV0N4VawfjNQfrS86cozAaDZWOSujTqUhi2WrBPmzeniUSub06EG8/y5CKolmrkM/cjNPxFvovSeksjGCdGi5DV3zchLqNf7hfONkYIRV4Jv626xS7TtU2fr/y9mREsE+enVV3QgNtji8H0n73iZKlAIDHqbpBlHPeHNnG1ezC4NNn05TWxBG+2PxYyn9BUxNWE6tgHHju+NSIpMGuytCeab5DT7Iq93bd/7b3F7EqNaNvGzxGQTnZT/7YlsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8KvI2g5i9tTn/cF/P6uHuj9lrizhGbYJdXG4kRdoLo=;
 b=afQ7x+y0HwH4v7QnZVmnAAqkszQ+StRLZDkFs3CGB1S+Su4xMwjscWagIdZCgzLHLGNb6IzRUPRBvC+jskE87q+Vw3BJfTvqaLMhc1rt0hWOpFNmPjfIsb48cEeFz04iv7uAcfIXcBsj5HCxclCsiqv8wmUr5rRgKOVMC6fW0Lc=
Received: from BN9P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::35)
 by DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 09:42:58 +0000
Received: from BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::e8) by BN9P221CA0018.outlook.office365.com
 (2603:10b6:408:10a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Mon, 5 Dec 2022 09:42:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT069.mail.protection.outlook.com (10.13.176.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.14 via Frontend Transport; Mon, 5 Dec 2022 09:42:57 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Dec
 2022 03:42:55 -0600
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: add tmz support for GC IP v11.0.4
Date: Mon, 5 Dec 2022 17:41:26 +0800
Message-ID: <20221205094126.2190885-4-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221205094126.2190885-1-tim.huang@amd.com>
References: <20221205094126.2190885-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT069:EE_|DM4PR12MB5136:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f0d2d8-e610-4b8b-7c56-08dad6a5177f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FcrOhg52gNF05wx/2yEc0LOC7kQOohgUy0+3B5YbZtCpQnzoSu2ue3Cv1mZipracAP4njEdUdVGxY5UDI504GRpYZXvKrvK0ehBViHzXIV2rJxfmyvjEsDX2ocLwhAscauaLvKuOcG+Mx1t6tSEyTdh4QW4toJtiU3jE1zg7lbB3fUVfEvgy9qtpbi25bQMRNGGsFigc7VoZw+DLAQL03VrzF/+7nLjgxk3TLbUTFRWJykrVhdon1UOkmm0CAUMRKD/IAYonZ3Y03z3VFxNFfyjwxSUfG1UX8DAnd0ey5SeNgmJ+thhpaV+ZyRr3IAD2azN6RxteK9kPxzL24WSCWebdYJmtoyBVffu633ESR8BX0yTa82l30IldsnRcK9DBxoUkozAXo2k9QIJy1CDGR2V+xxf/X3ow1L9rhemVl9k2HVSapXZ88jdxiggQ29DT7XMtc6TghfTlMADHlH70PVWNRFTc+gEzHZrRCW1yAlzmsc/Qg/Rn73OZkm2NRfJpeUkQT8EXF0R9etNYXtA8x7O8eQ8k3OUCOX5QzI4bA5dXgava9ho3dYVuedBbr2O0wXHE6kjSaiMxnQYAANArWJndvjQEZnv6fbyPJkBUU6KAqeoPlC2Li1L1XvQyi8anzkm0uF9nm4N4LMPr6yhVdxFh9JStf8PFOqDpuxiBgT26NviFiFCQ+gp9OcfqPslBW5om35kT0B/1CIh316NUAc0cmzPmOUJDGtnwQlp76dE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(7696005)(82310400005)(2906002)(44832011)(336012)(4744005)(2616005)(4326008)(316002)(8676002)(70586007)(40480700001)(70206006)(8936002)(6916009)(36756003)(5660300002)(47076005)(86362001)(426003)(186003)(54906003)(41300700001)(16526019)(1076003)(40460700003)(26005)(478600001)(36860700001)(6666004)(82740400003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 09:42:57.8056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f0d2d8-e610-4b8b-7c56-08dad6a5177f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5136
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, li.ma@amd.com,
 Xiaojian.Du@amd.com, Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add tmz support for GC 11.0.4.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index e970e3760cec..02a4c93673ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -549,6 +549,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	/* YELLOW_CARP*/
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(11, 0, 1):
+	case IP_VERSION(11, 0, 4):
 		/* Don't enable it by default yet.
 		 */
 		if (amdgpu_tmz < 1) {
-- 
2.25.1

