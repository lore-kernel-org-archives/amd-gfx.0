Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25957C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 02:30:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE95C10E71C;
	Tue, 18 Oct 2022 02:30:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02AFC10E71C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 02:30:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqbLQ48VpTh7AEbbrEUmQTZHxnlGzL6oSHZR4/Cbt++mjWX+68PeLpwsJM6B3lDJ/bxnDGt3qqpmZIeZ1KADbHoeSUYZRC745I0fdjdxrRgRK8Od/GX1CTl6HEzZTaUYyVdCfbQzHlkuEIeFqyI1QztnIFt6hp96/KIOsorGa1Hk+YHXON/SiBVNR3sKpdirt8YJyNBl6fRPLJWGSYP5eWYbnoRmfYTp2AymmvbXl3wD/CO3rTlG4EQSUS3G+jKJ1KbyMk0519wKLqJTkGlb/2/KQBJbEDj05hQfmT/WVzALl7OZWor1F5xTXSt24m/7r++IBWjOgqK6U4Axqu5h5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oN5O8CAH8+D3ovz4auiJmA0me9ac8fE43VlwAbC8s7M=;
 b=ZJw+ZnyR4p6Ez2YvVsXgc0TfI0AN7rdfQKf6mXSxZZaAonDTldQwHeN794aWZlb41sVGooLTM8vWijOI0Txzg2bXWJgEhY3VBmyjyGeL6w6ZxLRW7Ph7kPYEfnQt92LUuXYjgKSQEv5H5ducz9DXYeA+ooM0lq3t9HuDgjkxivaszEqT4kwa6VoWRDtc3vzHS8xJMZ/ilw22w6yAn1Kto/MLzOmLDPYRFE4ateGrIziuTYkuBUf+RYg+zdWrinjsWQeJBWye5qi7oZNc9aF5XQR4EzGsH9hFPyDtJKJzQtuLwh5PZ3rLsJqAREaiN4zPA9iK6JtmTVjbsIYvKKWttA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oN5O8CAH8+D3ovz4auiJmA0me9ac8fE43VlwAbC8s7M=;
 b=pYKl+xgAIG+tJfVZ0EcxrcW57YXQZpmA5d4Rw4pIVdrnV6J3jb/cWGrBH9OHNGY6iILEF7cYdEANCmAdaKIlS6e65wBQ1CYzMxGaT7ZoxKRjcM17yrX7eWMAYNyjHJCADwRFdJFnlNGrb/yf/yAyjxiiPkxsuqkfku1wTsDynOc=
Received: from MW4PR03CA0233.namprd03.prod.outlook.com (2603:10b6:303:b9::28)
 by MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 02:30:24 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::f7) by MW4PR03CA0233.outlook.office365.com
 (2603:10b6:303:b9::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Tue, 18 Oct 2022 02:30:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 02:30:23 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 21:30:22 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Update ras eeprom support for smu v13_0_0 and
 v13_0_10
Date: Tue, 18 Oct 2022 10:29:57 +0800
Message-ID: <20221018022957.18790-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT034:EE_|MN2PR12MB4255:EE_
X-MS-Office365-Filtering-Correlation-Id: b55ea4a9-dc65-4924-a3d4-08dab0b0b60e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R4EDCzWvp3KnC+RP9T5E0A4TCATHp1i9j50jaFfGBDYYKeyslGM+wu+L/e+/ssa5idprNqzcCGYNwzNqyv/qDlI8vVKjxd19BV80XdT3ZRaushIP+5/UYxvxzgpZHoKUEiez/pFaoEKC1uS49rS+rldIl001hOMlwhvAWH7tSLcM8TENdoCzUM0MYa0fJQn6tKLHVmvHnl8kmIl2Bf3qoq8OQLIu5giwVLX99N3WCdBfCApqZgvEbciSUvI4JlEcT3lCTrNNrIAU3F5tA57aU5AX3ECcD6vw5O/0J+QRV2Ka+YECFJIUZONrHSSM8ZrE4/Gp4CMo+hAOYsFCy6p7gnEl/yhM1sQI50wjyvztOGCT6R45edfJtq+V/xbPGdNVYAqC2FAg4MkSxacN/yP4GqYALh5KLT8BiO9qetieQVAG0mjTEuYbauLL9xddGDghJVfRfL/V+aPgS4tVrqSYGbcRqxDhnzdGzoSx53rPWsZotKwnQeB07MbOhiPqNXXgDcSlVLdA+DzKFbQEj9UTCvfb7Ne+dYMkKW1AOTgio5eBITHmpNfg3X5MwBlglh9lxIwaay4R+RqG+M2gA/uLZl14w5se++zs6h6jPxY564iFwMfF7iRrh4GK26UveTdj+HPo9Nr5FlIQMhc3xO9kqCR4rS1TGzEqGZvGovAc+AJDcJx2X09jL0S5BNvyVoRIQ196Z7qRGUX9+AUrYsx0NDpdHoVl86XAQiUewJ3/IxZqj+QIA/fZUKzhwnhVSYhZSDrvofJLiCwnHJO8JwvthvTULldrcfch12pcFn4/ddOttE06qy61eC9BdTTm8HGI
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199015)(46966006)(36840700001)(40470700004)(36756003)(36860700001)(86362001)(336012)(4744005)(44832011)(2906002)(5660300002)(82740400003)(47076005)(2616005)(426003)(16526019)(186003)(1076003)(81166007)(356005)(316002)(7696005)(478600001)(26005)(6916009)(70586007)(70206006)(82310400005)(41300700001)(40480700001)(4326008)(8936002)(6666004)(40460700003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 02:30:23.9929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b55ea4a9-dc65-4924-a3d4-08dab0b0b60e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable RAS EEPROM support for smu v13_0_0 and v13_0_10.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 84c241b9a2a133..7dc39154822c50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -90,6 +90,16 @@
 
 static bool __is_ras_eeprom_supported(struct amdgpu_device *adev)
 {
+	if (adev->asic_type == CHIP_IP_DISCOVERY) {
+		switch (adev->ip_versions[MP1_HWIP][0]) {
+		case IP_VERSION(13, 0, 0):
+		case IP_VERSION(13, 0, 10):
+			return true;
+		default:
+			return false;
+		}
+	}
+
 	return  adev->asic_type == CHIP_VEGA20 ||
 		adev->asic_type == CHIP_ARCTURUS ||
 		adev->asic_type == CHIP_SIENNA_CICHLID ||
-- 
2.17.1

