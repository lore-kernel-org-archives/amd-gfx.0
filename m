Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78E5C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 19:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C3C989812;
	Mon, 13 Dec 2021 19:34:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A40689812
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 19:34:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TP+T/hyoe2Owv8r9HEGYPnGMCcbwD9G/5hJDXs/IzfnNO4kZfHYT83RR0P+tkVQ2fqWmF0UR+ZHPmxiVVSVwIYzhloj6/i+r0voKwG9gBFNggelMKozr9sQOGFougF4g+EFbPVGOfJ1ST9b57CopCfSpj/EAKIZeEpki30GV55FYJ6EE+rHSvGUTD4pjm/3f9cvTguorEECPaYJi/7wGfjBmj2lL2zrfcUdqJEaf94nBLnYt8mJxALevQjU5yNI0lqGuD75xKuOoyDSqBHz72V8fAs7Sqml9u6ecLjDIPR3Hf7KkOl+iv0zpaLh+okLDxpMvX1m1oIEdEnq/RegTSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLt3KzNemzpKFXBI5hkOR7ROojluNQpnrdDbDpouQKA=;
 b=KOCeC4JtwQ2fgE9InxWQQVJ9Aznmdwtgoy6yfjYN+e+uf4RXz1YaqQsRPO3TenZ1f1a/aRmTjw/TfFDBqugDATvYWVf3iWbap2CVes4/m4FEiw09TATHC5iS0WwIRyKHYTGcE5wE45ux59huBqce0x1p5ZIlwF0LnFtck6jVNCH9rA7Xad7OYT84vkcZ+SQfXu7VPbl5W4rK8TVhyMdilU1Rp6dKihqGIQw5pA6/y5ilke8w6FUQ6/V2z0kyzl95yeqdGidc/RomEuTnIZ8WXAEIqZJjyM8N7+y5rEOLHcsgyXczm+VM5lFGPQBwS8x5V62zW/HILwUT0zKBc3YCXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLt3KzNemzpKFXBI5hkOR7ROojluNQpnrdDbDpouQKA=;
 b=j6fOsPo/m8yLLsDrVTumY2rl1OtL6gri3m/A6NjQbmqV4kmTQ8vWgdfm7MhGaMHnZD00/gU2zQXAkGRL/2Ey4pVuKET5L/K6BeLCXobUFv3om0WpdKI4HhGO9sY8mrVXDOj+ielSDnF4xHM78nVsQWvqC3TZ7MzN5rXnoshZMXQ=
Received: from DM5PR19CA0022.namprd19.prod.outlook.com (2603:10b6:3:151::32)
 by CH2PR12MB4008.namprd12.prod.outlook.com (2603:10b6:610:26::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 19:34:13 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::6d) by DM5PR19CA0022.outlook.office365.com
 (2603:10b6:3:151::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Mon, 13 Dec 2021 19:34:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Mon, 13 Dec 2021 19:34:13 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 13 Dec
 2021 13:34:11 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: Increase potential product_name to 64
 characters
Date: Mon, 13 Dec 2021 14:33:59 -0500
Message-ID: <20211213193402.96278-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 849aca91-83ac-4e9a-bd93-08d9be6f8b55
X-MS-TrafficTypeDiagnostic: CH2PR12MB4008:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4008AAB89CFB4C6F1371EC6885749@CH2PR12MB4008.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XTpEajuWRU01IFLsDG3+kl3t0tzuPWegKkblxRqZcMNxu3Y/s/kgVakZeCtx73LSnkk24Ur0SmtFMcjHhZZEiuCTQ5ctTMtUl7nsX4SGnW+vfVyFM2ew5rNPiiEOB6jxT3rHNTDndY40PiMPau13xLAkJUDNz2nG1gos8VQUw8DM4GL3djpVaMdwywAgs5ui+9HfYdNH57uPpbdvKVpQMWA226NtJSgmcw/7m4//WyJ6Auxef4xDWA6XlhI+s6wlQRivV3g4xS62zHNmSpJClD5Ml3j2l9brNVTpOy8ARn4XE2nw/Aw+RmM6q/2NnmvU778HvfJ8pQWr4qE1Kn2jGBoK53Np3MegmdZyrvGiToZ3T0g4IU5VI8Eh6Runz4RyoATF8CUkObcQJl48N2zLQiHYxWjQoFeJv0vDzDnH8XpR0zk3qfkolYLzToTR6Dr+uhTmJVZAi1eYcsnnCz1K62iUpMTvLVntIp+eEZD6AcrLhsCgqComFQ45qTqNOpZ50LPWqkkG3Gu6K4DLe2XCnOvCYiN9svSDbw9XESRaJhl585IELcJGkZNCU2QFYb3J6NU44wh1bBjtGBbgvs6K4RpD85mKPRnxNAuf75bP+F8g1E4PqYqFXmr0YX643ReY6jQRdT3GXy2ZFIep4NqEL13xMs/25sCT5e6ZyyxttAabm2j3SYsIiAfmU+d7W2TSL8xb0KPmOWzsoarI0t31Z6RSQtAujVJAf+QD/cgNoF2G2+nSSL5mmc07wJl/kYNZ1cajghol7t4nfc36KzzsK/wzFVghps07tE6qO6YzeJU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(508600001)(70586007)(40460700001)(356005)(4326008)(5660300002)(70206006)(7696005)(81166007)(82310400004)(36860700001)(83380400001)(1076003)(16526019)(26005)(6666004)(2616005)(8676002)(426003)(186003)(86362001)(44832011)(6916009)(316002)(47076005)(336012)(2906002)(36756003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 19:34:13.7154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 849aca91-83ac-4e9a-bd93-08d9be6f8b55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4008
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
Cc: Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Having seen at least 1 42-character product_name, bump the number up to
64.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h            | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e701dedce344..1afb3066f6dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1083,7 +1083,7 @@ struct amdgpu_device {
 
 	/* Chip product information */
 	char				product_number[16];
-	char				product_name[32];
+	char				product_name[64];
 	char				serial[20];
 
 	atomic_t			throttling_logging_enabled;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 7709caeb233d..b3b951fe0861 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -88,7 +88,7 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
 
 int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 {
-	unsigned char buff[34];
+	unsigned char buff[66];
 	u32 addrptr;
 	int size, len;
 
@@ -131,11 +131,11 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	}
 
 	len = size;
-	/* Product name should only be 32 characters. Any more,
-	 * and something could be wrong. Cap it at 32 to be safe
+	/* Product name should logically be < 64 characters. Any more,
+	 * and something could be wrong. Cap it at 64 to be safe
 	 */
 	if (len >= sizeof(adev->product_name)) {
-		DRM_WARN("FRU Product Number is larger than 32 characters. This is likely a mistake");
+		DRM_WARN("FRU Product Name is larger than 64 characters. This is likely a mistake");
 		len = sizeof(adev->product_name) - 1;
 	}
 	/* Start at 2 due to buff using fields 0 and 1 for the address */
-- 
2.25.1

