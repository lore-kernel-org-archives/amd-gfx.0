Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AF2C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 09:05:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAC2410EF05;
	Tue, 18 Oct 2022 09:05:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DF2E10EF0C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 09:04:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apEyE9UsMxd+cdkg3K2jPCWbiXJf96TtoMvqfSaJTw9Ku5uUPijsZ+I7TcijYNsjb4gy/pMTaf/Fiik+JLZHTEPzUosdOXgAmSHSdomAzs1+RBaExYBuw72fNlJvg6tjghXDxUBRLB74Fu3uXjsK/z3q+8HGvYUQAM8XuC0jstKvr4eS9myJJoOrBv2r+rNUZZMvOR4BkPFxWJD9Pj+cC1JL5R+Wvza1lhYXF+lfrFS41NY9/xHEFpL80QRAvaG9Ui/KXWpqQcSX/yKE5A3W83BslVvwuExCebu8S7d8fz+zpGyhvGL/1ZgZuWOkKFI2YPD53b9LJvgZmkbtQQYHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iNMRgj7HHd/xKfpCgnjcBIJvOMXes7lBotJZ40y9/U=;
 b=n/jmEGgapm4LwsQxmdgrrERNw7kXS3OMUsW+Qo81YXI9N0FQ9KfH3Zb9vJc+YadPRARpDkbviKtPQaRTnBizlwpsLHaO91ITZkPt/jUyWb5gKMtdi59v3qNSmhPP/ubtgV5FYXlVAkb2npJ80RKRDbHUIHz6uXp/mFztJLP+x0v29y6e0uj1fA9u/a1sGqmblM7kLT/CAfXnRWu9S1hubOPtVBtWs7kOgmmb6r5mYrxZ1cxStweLxaDFry17tKJZgRUAq02vVxc7VP7p4QRBPrKp1zC69gu0c1NGLWFllPLv74w3AC7N7NtlGlfnYVtgggAb7+q/XpPcXblRFVAFCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iNMRgj7HHd/xKfpCgnjcBIJvOMXes7lBotJZ40y9/U=;
 b=kbI2ybeYB9Dxng1eQsoJcdKqJrpeV5n8xshDTc2eTNQiOpo9TpHDA/dS0p7wsgcGalOoGb4k/2DIMM/A+tsLPd6QJL2RAHSMQRuCdHDYUFlMd1DmiLdC3WOhQYsqT1DDrBatV2+qbD3x1JJUD97pt49qEdz/qsuCHgTpTt3Mtlk=
Received: from BN0PR02CA0043.namprd02.prod.outlook.com (2603:10b6:408:e5::18)
 by MN0PR12MB6078.namprd12.prod.outlook.com (2603:10b6:208:3ca::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 09:04:47 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::d3) by BN0PR02CA0043.outlook.office365.com
 (2603:10b6:408:e5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32 via Frontend
 Transport; Tue, 18 Oct 2022 09:04:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 09:04:46 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 04:04:44 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix for BO move issue
Date: Tue, 18 Oct 2022 02:04:09 -0700
Message-ID: <20221018090409.1888-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|MN0PR12MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: 8627fdca-5821-498f-fafd-08dab0e7ce31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z3X5pXnc98FsAc8OCSXa1OD+v+1G9SWr6GYF1eOiOzwYrbnAx1e+ll4i02tLzyVe9kFMSVaug+/Ho2X3sazTx895F+58/NQw0890De0t62w8JA5jZa5DM4gHvS7bwdkjnfHh+lwuTuYfkZ8r9cc7IURcgPTj3uGFbQYhabFJ7SkhnWAHQG7gsaqYR23XQOGJBQPDM6tTpRStRf1+5/QTjkV4O12aoeXcXX8licobNtSK7fYEx6j9Sj6FKyTQxV+bym8MGyJr1+tuc5WGmUTxP3iidzR2NqkMYjiGi1sCvkaN4mg7Pn+RYljduAhPlfDZyFD5XIHL71zw0lKRM9JQgRSCAsqKNXGbQxHqFxHQqLcFx6IZ/sbfDi+OZ4kVZbTkQvSEhd2GXHNpOmvRO/rmUSQ0Y3Q8Vz21JTMhNf1Na467cd5pSkBjQiAfMBLe+8EQKXXNPvXUlZh8OVUvReLoL9mM64sNCDMTdUQjI6s7pLfLUSrjWlgQ7wsm2IhSljHuHcOqihwYUrnTeRlTMdjti1Z7N1NFp5JTXcFxpxTEWgH5W+ZI3bFdMeQcHZkk+3HgV4haDjQ6Am+hEq7E8X1+zfpN5fBqcixlEqqEhQomyznRCECaFRezXWkC2n52XSXVRfszOLCuKGeF/Bo+Sp3zVIOJWMq/9svlFZyqYcdUbq2/GV+499h0bQoxQGg5Mxud0aaB3G5AlvuQqiYZCmnxwOjiK0FVC4Yg4MX7UB89J1IitK78K0ev6aQv2B0k1Bh28TSPct4vUhBHtlOfzbldml2biI21d7hLrWW//BeX+cr6g4208mcj7m6sP30KAw0x
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(36840700001)(46966006)(40470700004)(7696005)(8936002)(41300700001)(26005)(356005)(83380400001)(47076005)(36756003)(82740400003)(426003)(40460700003)(81166007)(5660300002)(2616005)(36860700001)(1076003)(16526019)(82310400005)(186003)(336012)(2906002)(54906003)(478600001)(70206006)(70586007)(86362001)(316002)(40480700001)(6916009)(6666004)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 09:04:46.9193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8627fdca-5821-498f-fafd-08dab0e7ce31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6078
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
Cc: alexander.deucher@amd.com, arthur.marsh@internode.on.net, airlied@gmail.com,
 christian.koenig@amd.com, Arunpravin Paneer
 Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A user reported a bug on CAPE VERDE system where uvd_v3_1
IP component failed to initialize as there is an issue with
BO move code from one memory to other.

In function amdgpu_mem_visible() called by amdgpu_bo_move(),
when there are no blocks to compare or if we have a single
block then break the loop.

Fixes: 312b4dc11d4f ("drm/amdgpu: Fix VRAM BO swap issue")
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index dc262d2c2925..57277b1cf183 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -439,6 +439,9 @@ static bool amdgpu_mem_visible(struct amdgpu_device *adev,
 	while (cursor.remaining) {
 		amdgpu_res_next(&cursor, cursor.size);
 
+		if (!cursor.remaining)
+			break;
+
 		/* ttm_resource_ioremap only supports contiguous memory */
 		if (end != cursor.start)
 			return false;
-- 
2.25.1

