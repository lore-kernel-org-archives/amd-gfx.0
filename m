Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F74C61DA4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 02:33:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19A2410E065;
	Mon,  6 Mar 2023 02:33:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB5F510E065
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 02:32:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cScmgqhSicA3on0YeB2ZFfZK2v9pq5xI+oY6nFPXJ/TNyhnPRPtyxTiW26QmRJe8qk0DXjSF2UUxnA6faniOlfFyx5c1EDs9vALjQ/AaOmZqFEYIse+uatUlNQVxEoHR4koXn1sLxdTD/JCigNYYCVJBwpd1i5q5b107dcfqRWdCqiBFSXMIE+eBvwHkaTQ6oCX3tOA9Jkdn3I0B0xEUcMczOr4wYkxJuMAl1eRxwf2bpd5up3P2w5srk2G0zLVc+0/rL1Nm8/2q2I1w16lLwMMhK5r+w8OL0R3kRc4YEUCVhaDvA1BfkY+8dqZJmj4zH0ELZZ8Lxlp7i9a6z5B2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M41dDcKkQIGnq8O0svTYATw3jy82gNhhn/RnTKbMVzE=;
 b=N+kz6rnt30kzzE5jLeXn5bkTt6FHuqhVXCuCf0q/8sm6ewBye+uC6HGBSi1hfL1BIzVgHuySrQNOF+gZnyFuXdnQqQ79zAZtPcqAEcpBB32yRe084hDjf/rKXbM2yAAgfuKy9X3LUX4gNUdJR1/fO+nZeSOnmtOwpb88gle/1FWFbJM23xgr/EiGmoKTOaqIFtMiZ8u686g0lH3G9dHLv9fHmB5nSOE8P56Pk0zN7STWzu1ptXl+d0+RX5APizORyeWkcCwaqXo14yCa9fIZglwAh5KyXlNtantXpBXb1K2QwpJJTJSwVqJehfi1wMp0K+b5yIXZ0PQ1MYAo+Hf6ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M41dDcKkQIGnq8O0svTYATw3jy82gNhhn/RnTKbMVzE=;
 b=zzKEyZL5hMRcZgQI5kW/XSfZvXDlLANbrZXe1yenHmsO8LG5Fs7g2CaFfPMqklPM4/b/XIYHAEiwupp7lwYBYlu9vy7qbJRprm9CClmJmNr0ufttC8IzFgqAxlvZzJbT9a9vhOVRfqSIwCVMVO4Uf8uDMXd2xMIVFAIL6yIbdrA=
Received: from BN8PR15CA0007.namprd15.prod.outlook.com (2603:10b6:408:c0::20)
 by CH3PR12MB8548.namprd12.prod.outlook.com (2603:10b6:610:165::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.25; Mon, 6 Mar
 2023 02:32:55 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::16) by BN8PR15CA0007.outlook.office365.com
 (2603:10b6:408:c0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 02:32:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.14 via Frontend Transport; Mon, 6 Mar 2023 02:32:55 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 5 Mar 2023 20:32:53 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Candice Li <Candice.Li@amd.com>, Thomas Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 04/11] drm/amdgpu: Init sdma ras block when ras is supported
Date: Mon, 6 Mar 2023 10:31:53 +0800
Message-ID: <20230306023200.29158-5-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230306023200.29158-1-Hawking.Zhang@amd.com>
References: <20230306023200.29158-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|CH3PR12MB8548:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b959ad5-afb1-45e0-39de-08db1deb17a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BCXqO2UnJxkOlUfnObdlzSVnBRE+p4sEgK60LEv9GIC+Bq2OJlXnFcymvLncQ+6asmgkiSDypeS7nf0QZRzbXPltk3TKZqKAyaZswkqQmvrqwjCNfBYCZRMyLZ1jTQcZYvT/+/jODQMTJC7a+wQdg62aTRNUhkdKgX7pA+EaySworee3SDLO8gpmIJ3gNFXdslxjN5J77+9Zuw1EY4ia82W3mov01dNihXii/vD6ZUjopTnTTnTNYoo6lkw5Yv3UPQST5nd+G1aQOC5dPj40FDZJgq+W9L3nZUm/OkFQXNsTAcgL7Tq4eoMz7RUSlwJtGbi8Z7gaVoJk13KjnTDjPvqqhmsBl6oPJzoa1mm+pEB3UB6VqAVlDidvtX/HPVWh1oMqwGsR6NNZvjiL6QnzJ7i3YzgawMhnCFQhJy0Ji652entyLpF9Z/l2YzppQUbZlqaMfWzFrI7wQT99oOMsdpTu4oMn7szD4HXy9nheEwloPSCd8tW3WYYKK0KDuJJefzw4FchiJ67e5bdGHG+mFuCbAmwCzLmSsblR/4WRNW8zI+daXc7XU52qIGmOfWmluWWYrfkzsmU00OEKvPYXtFfRK87e0C+oq+RyhZjbwVSnCYMC+MAuV3RndCxCTyOL0zYopmd5NfGWngjGlq6mTNsmvJ5fkeDCxsCeclGIfAdDoOLEutAZ/Eme46G+mAnB2bDADeqkbfSsdM6CyqS/sp8HlYZ79V4oNHHyeJteur8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199018)(46966006)(36840700001)(40470700004)(1076003)(36860700001)(426003)(36756003)(47076005)(82310400005)(83380400001)(356005)(40460700003)(86362001)(40480700001)(81166007)(82740400003)(16526019)(186003)(26005)(2616005)(336012)(70206006)(70586007)(41300700001)(4326008)(8676002)(2906002)(8936002)(5660300002)(110136005)(478600001)(7696005)(316002)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 02:32:55.4074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b959ad5-afb1-45e0-39de-08db1deb17a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8548
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Initialize sdma ras block only when sdma ip block
supports ras features.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 9 ++++++---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 9 ++++++---
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index b5affba22156..805c6605b43a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1851,9 +1851,12 @@ static int sdma_v4_0_sw_init(void *handle)
 		}
 	}
 
-	if (amdgpu_sdma_ras_sw_init(adev)) {
-		dev_err(adev->dev, "Failed to initialize sdma ras block!\n");
-		return -EINVAL;
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
+		r = amdgpu_sdma_ras_sw_init(adev);
+		if (r) {
+			dev_err(adev->dev, "Failed to initialize sdma ras block!\n");
+			return r;
+		}
 	}
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 1b04700a4d55..9bf221cc07b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1338,6 +1338,14 @@ static int sdma_v4_4_2_sw_init(void *handle)
 		}
 	}
 
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
+		r = amdgpu_sdma_ras_sw_init(adev);
+		if (r) {
+			dev_err(adev->dev, "Failed to initialize sdma ras block!\n");
+			return r;
+		}
+	}
+
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 40e6b22daa22..4613d73c2535 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1281,9 +1281,12 @@ static int sdma_v6_0_sw_init(void *handle)
 			return r;
 	}
 
-	if (amdgpu_sdma_ras_sw_init(adev)) {
-		dev_err(adev->dev, "Failed to initialize sdma ras block!\n");
-		return -EINVAL;
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
+		r = amdgpu_sdma_ras_sw_init(adev);
+		if (r) {
+			dev_err(adev->dev, "Failed to initialize sdma ras block!\n");
+			return r;
+		}
 	}
 
 	return r;
-- 
2.17.1

