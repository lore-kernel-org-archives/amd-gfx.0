Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D176C0015E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jul 2023 14:51:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15F1D10E02C;
	Thu, 13 Jul 2023 14:51:11 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF5F310E02C
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jul 2023 14:51:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRmEm2TI9RP8f8JrEJ9vcIDlr835Lgk7Bgdx22NsLVAj27Sc7MJMnWN43ntrjU8isLZ7Rs3taJns/VMC1Pkeao87W+tbNFGxLpmWbzN4zg1wqgcxDzAke4OmTofGc+SVzmHmbeVx6CcIF9qJieiv01zE315UOVa7uLvhzrOT+AI8FUEIM8s64+4jw9BY4fHave2zG+c6SUT6KOssg7nc7rwC3PRbqWlEQOPL7wWfGRQgLUPNUyfRKeNrFrxfXgYoBFETTjlS3FJ6/NLTWhmwpFacarUvW99Kg5LNNu3kzno7kGARVK/Q+AMkrrP78VazRO/Y83OiJfe4nXPN2/9+OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giXCThLinGT9M4gfCHLLxafKCyp6NrmaeOOGaR5C3nc=;
 b=dDcDwqt1oSnOL1bLtWDBYwxA4vSKemSe1q5gVBOnS7YZPdA92S1AChvtqHJdQuWZhsrTOO3v4U9Et3u6Ju7PDGGy+H6CK7tFnW4pcihZkFdeVJlVHUIwckbrdbd1R+rZ5oqyw6XwG0bSoR8QRlb+HHfH2hieK8CNhWkzhqEcWByjYJ0unIDjGWcOOFhwtMju6raYEO4baezvGqo5X36XJUQyO7Mkk9Jcg6nOxpgIxoZnXbNJzpPoYHX7k4IIJt77APEj3tZzaWHWpQs8xAWSNHcg13ZRYwXjijN9LcU0WIOfZWd6FCVT6b2d1DDw601+QyavGIf21w0slcaHszea2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giXCThLinGT9M4gfCHLLxafKCyp6NrmaeOOGaR5C3nc=;
 b=mZal+Xbp+Cregkc6DbPlQVrxpAeAt0eyZnJ78L3c4iEd0FQ0WCsC0Fxkvd3E6Q8Vz/6W53Mr0acZMtXxlt06ftNMtMTH9u0REzDn0JAnykfmnAM7/birHynBfMk3fybS+KWVBdGTszhW1KCaRWov9XZVO88LLLCPlnjNXBzXxTc=
Received: from BN0PR04CA0095.namprd04.prod.outlook.com (2603:10b6:408:ec::10)
 by DM4PR12MB5135.namprd12.prod.outlook.com (2603:10b6:5:392::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 14:51:01 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::4b) by BN0PR04CA0095.outlook.office365.com
 (2603:10b6:408:ec::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Thu, 13 Jul 2023 14:51:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 14:51:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Jul
 2023 09:51:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Jul
 2023 09:51:00 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 13 Jul 2023 09:50:58 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>, <YiPeng.Chai@amd.com>, <Candice.Li@amd.com>
Subject: [PATCH Review V2 1/2] drm/amdgpu: Enable aqua vanjaram RAS
Date: Thu, 13 Jul 2023 22:50:55 +0800
Message-ID: <20230713145056.54876-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|DM4PR12MB5135:EE_
X-MS-Office365-Filtering-Correlation-Id: 547ca211-0ba8-4bba-f66d-08db83b092f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oI3dSK6rQdd3nacswxRqSsK6/ZwxA0m+tJ9ecLTwi5478H6mdsJZNqLWWYrjB141mLFJGLKQZYO957bTBRnoFsT+fd6Ov3aGYnhq7Ir5pPAlB7zcWPO9z/vx77FtFJ+6awXMBNVnmePohY6indcELJBrKgOt968qK70XsW+e7+w47OpgwJysLuOr3HP0TpOibMDgUqg/UFjequM2OhGUFKMBZIQsw37ZBegUitG69OaJARC893FIILt6AvWYW4fFEfRgpHe/cSTXOODXEOaSTDe5kPaZddvm4GwWM6El3EsHk1NMoczC54Z0QFpFG4r9EaRBVNezQKDR1vrA5vq1fmwQvyfR8or7x/nFGJ6tmTYY1F7pfW5sCayKWi+5TOuaKcWMB3kyNIylEJFc/QlV6Ke7I3nWmZukP6+IdaLWJ7Mz/C/QERcyQq1tToJt64rMqBH8P2ZOEsCqR6YsIDJFgJeRTCZAcRVf3znuCvF8clcbmSLNAJi9ilrn25rns9IFETJup1HpNMJExykB/gMATi3SySkqz3b/55uGG0cjoDIAZRXhfGANxJG1ZMJPP8ihmgpvImRhAYTPgsTeUYZF1j3uF5zi35EIVQmRiZUI0wtaagkoDzJcvVJVJmxeV6Zp0IhiVFtj8miTTopnvlO0N7VsenBLkfkc6W/Y2p6fxVLyfFkJxrAGigfSLDgGZDiFSLoOuL/5510IkUN9KmNLgwDWCoUrqlC33TW+X/6f6y7SoIM1Wk/pHKtXOj+FQKKsdGFuXaKkLZHgqQWvMyQ0fw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(8936002)(8676002)(36860700001)(47076005)(2906002)(426003)(36756003)(4744005)(2616005)(82740400003)(356005)(81166007)(86362001)(82310400005)(40480700001)(1076003)(26005)(5660300002)(336012)(186003)(316002)(110136005)(6666004)(70586007)(70206006)(6636002)(4326008)(7696005)(41300700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 14:51:00.5860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 547ca211-0ba8-4bba-f66d-08db83b092f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5135
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable RAS for aqua vanjaram.

Changed from V1:
	Split the change in amdgpu_ras_asic_supported into a
	separated patch.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5371fbd3fe17..8673d9790bb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2422,6 +2422,7 @@ static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)
 	if (adev->asic_type == CHIP_IP_DISCOVERY) {
 		switch (adev->ip_versions[MP0_HWIP][0]) {
 		case IP_VERSION(13, 0, 0):
+		case IP_VERSION(13, 0, 6):
 		case IP_VERSION(13, 0, 10):
 			return true;
 		default:
-- 
2.25.1

