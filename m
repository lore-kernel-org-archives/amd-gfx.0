Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08301C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 02:10:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5AD910E23A;
	Fri, 18 Feb 2022 02:10:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05BF810E23A
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 02:10:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgtaB0RTHA1e0Y/2+czLM5VOUDhZgs8XGXdS3Y/J2HDCixvU9b9egJ8Rj+AE5hNZwx+OKz0c2F4EBrmwcN1//Wi3HbHLB3UwuJYjYYFntzvi5jhRsL4hRHsMglXzkmKbwXqM3u6maaX8/Gil0cujp0cDIh2F0X3PPJm2U3bUxr1vRbVzrV0on2IuRNlmIqedhmDX1KT9DuNg9HkBJPfNRr8nBeUOvFlulIP1jzmync3cy4iOJKzlnBvJKHXSi1H12jyw3srKKs+027ECy0humSYDk+WoEOdsqXLX7OGrvJ4Vnd1mXUPkqojUnEWXkno6EfIublqDIkFdDZsbKn8qQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzPUHCKBbM6DxiuzKwiqRuTwdSwUw7qxZbUcG5rMcE4=;
 b=Y+7AAUKs9DvZU3TeePB1yz3b0DMt8TDJSzHel/gK9pnDkCYJNbCiu3vuILZN8ifXx3bFsu0xeomgK9DuSSfsBcc7pNVbP0i2Llk/aBB0TP39F3OPjGFmjbc5cjQ5K2l2HaEejulRI8fp1fVNlGpE44AQVFsbZGLEpoBSV1x6wapnkTxhOgx+UpSwb6LBpqPACyloGP9uaPaJuAYxAgfyeKvcaXg3h2lMnbqblOgW2y4xFvtpaCME/nfZxhwYxSzPsGBMUynYyoyCYozElkWkQm1UUv1+YGEKmektxm8PzK349bXCoyTiKtEBGXUOHzN+M7/KTJsmFJsPlIyOS/gVhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzPUHCKBbM6DxiuzKwiqRuTwdSwUw7qxZbUcG5rMcE4=;
 b=p5z+1nXHzNMduAeF2Oztu1lzMhKXRPhIfW7juXopZMeceKu4Wt9PmMVA9fqNoXMgCrEYUbP3z1Xw8jUQWHbr+zOqPff3FEpBnUomwqjEQcENJ6Drg3SRp6kw650DYzp+1asfWTuSJ6OeFkLgdq0tHjAB2WamEMehBhSTxZ1xLHQ=
Received: from BN9PR03CA0309.namprd03.prod.outlook.com (2603:10b6:408:112::14)
 by BL0PR12MB2578.namprd12.prod.outlook.com (2603:10b6:207:49::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 02:10:40 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::a) by BN9PR03CA0309.outlook.office365.com
 (2603:10b6:408:112::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Fri, 18 Feb 2022 02:10:40 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 02:10:39 +0000
Received: from prike.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Feb
 2022 20:10:37 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable TMZ option for onwards asic
Date: Fri, 18 Feb 2022 10:08:17 +0800
Message-ID: <1645150097-18020-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 124dd9f2-f761-46d8-f967-08d9f283dc12
X-MS-TrafficTypeDiagnostic: BL0PR12MB2578:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB25788478B0A504A6433D115FFB379@BL0PR12MB2578.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vsObuCCHKaGSNhh66D7mTg7w5LgdjU99fsHvJMRhKL9wA1LB6Y4ZS5vW/U15ecn7zZZdVX5enrUrH3QiU7lTFbUF+cUtT005HR9+VJkvPVGTSHWkJAw04t1hRdcPLO0CNP1fud4ZpqjwMGXslXektrB7q0GgyFCQwjhfk3/qVLQ6RG46thpFst2Q7LrbC/zWNu2VUuh0eS3SRl9jY4wsD9gFmrkmo/FtLAKYmqztMCBgLyeVng39FuS1Ov9OfTvvkadmaHsKwg5zRX3Na5YkXn+piiO0uSRcylCwtvN9DBWLo+0Mw5DKb+hQhHxqECWIvl89EV2DSduKm1CTQjznV4ntPhQoloPTgSuNeKikV74kxhWIdhLsCestES3+x84KJqJsAjw5HW/aCnAU5y9Qb/ZytaSxXxKhZ9XWdtwxOFIFbx2zTx+gw4sZMSbPK5Ve7fpgzFDwj1BSUO0w5YyipiWbR1FK5yQakSQta7Nubi2VmxcgkDez8vK7+K8nnAAhfxrxH7dG5vfFHYefV8gTYDDbnUYCHEHatSFukoQo37TOpu4w+5W94tP5LyDwS7w2Ekqw5MhsDdugyuesYzEUW4Pe0R+pjy3+yp4crkUO1Ha3KIqJbV21kYygjXpyTtG4MZSAnCMQnEAPDAsNRkBusWfkAny7gydM9vkKcCZR12zWCk/2KvU//19oPQ6M1/FNb3rw6GTKRV8UzGHUxFQzNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(316002)(36756003)(47076005)(36860700001)(6666004)(54906003)(6916009)(356005)(81166007)(70586007)(4744005)(2906002)(8676002)(4326008)(70206006)(82310400004)(86362001)(2616005)(508600001)(426003)(8936002)(5660300002)(63370400001)(40460700003)(83380400001)(63350400001)(7696005)(336012)(16526019)(186003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 02:10:39.5879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 124dd9f2-f761-46d8-f967-08d9f283dc12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2578
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 ray.huang@amd.com, Aaron.Liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The TMZ is disabled by default and enable TMZ option
for the IP discovery based asic will help on the TMZ
function verification.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 956cc994ca7d..2cbb8c432168 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -581,6 +581,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	case CHIP_NAVI12:
 	case CHIP_VANGOGH:
 	case CHIP_YELLOW_CARP:
+	case CHIP_IP_DISCOVERY:
 		/* Don't enable it by default yet.
 		 */
 		if (amdgpu_tmz < 1) {
-- 
2.17.1

