Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9631C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 23:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DB9A10E60C;
	Thu, 20 Jan 2022 23:52:43 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2040.outbound.protection.outlook.com [40.107.212.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25E8710E60C
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 23:52:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjL6+JId2OyLVjvr7TZ1TuSiw90qKUY7y+AVXJMCHY/zJ7v0Z0oduSu/2GA6UShfCGK9lm9HMrxJaQRQzJ6K5OIhV4CNHvkSH17J1sK4zuu0MOkSgogTngLuDQCm8HYUg5rh7zOb3XP5I5vS0wbVC6DDyRvMmOSRS8jlsERpwz5PDwsXDvV1LnKr6uCNd9O2ubsU6fC63OCfGfaj2q+5idZ04UbBS4hbFRIQssktrRz7VoX7QaFRxqoA6kx/J8mF1XtFQRXYQ6bYH6rANQYQx0mbPgdqIN7idjKuZ0hS+U6nN9QEvDuqShsWLJPGp4ihhU0/0OTIorpsTprHv6Rbug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJ5ZVwbGnSBedKs/eUkyT7Ayu3R5FOcv1XEhubIkv40=;
 b=od4zQaWPGyRkxoMPQp4Wn24Jpzz1B7SKx/Z8UDY10Fnj7SKxOk/MudRN6QCGD6YeBV/eS0WPggsB4w2yLMVYLPjfXdi/5brOVNsmuhsr6k+hpC9zi/2h6aEi2cAtWRiDT2s3goWBLR9PfiFoMaIWEUQIXWImggi+CBIDBLsEzGRbSyvBqjSmGEP4aLErMgZmzSsuZcP6XYcNP1WetTrAEl/RZmpdxg37V7uXN67yO29PfYHaL7INs9jWed2QXi2+wcS3ImHr/M9X6Lg/N57UyJgIgQhfmR63t15ku7aw24iNuz4lTZ9ECIsrStTao/2VGN+LRXtwHU+pPZn+STSz9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJ5ZVwbGnSBedKs/eUkyT7Ayu3R5FOcv1XEhubIkv40=;
 b=CjLeMGzdKe6cD+550QK05G/fE2cPP/uAT0sAnjwgbiCl7r3zZXxmwiEysoe/4vRC1C6H6ffsCeFTbnrRaPq5GGEu+/DhZi1RKvbxB71+cLLe9NvP1fK1EeMo6V7oxjrL49IoFtHUQFrq8FgH/v/Gm2Q3Uc979P1KI9UpGi9TpZQ=
Received: from MWHPR19CA0008.namprd19.prod.outlook.com (2603:10b6:300:d4::18)
 by DM8PR12MB5477.namprd12.prod.outlook.com (2603:10b6:8:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Thu, 20 Jan
 2022 23:52:38 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::1d) by MWHPR19CA0008.outlook.office365.com
 (2603:10b6:300:d4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Thu, 20 Jan 2022 23:52:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 23:52:38 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 20 Jan 2022 17:52:36 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix kernel compilation; style
Date: Thu, 20 Jan 2022 18:52:27 -0500
Message-ID: <20220120235227.90683-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8326c9eb-798f-49fa-af5c-08d9dc6ff08c
X-MS-TrafficTypeDiagnostic: DM8PR12MB5477:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB5477B46926876BB5CFCECF3E995A9@DM8PR12MB5477.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tad9ldRoD8aIXj2S0IipYOFJkRXKyZu4Laax/vJp79TUNA50Et0Zwl+e/gXgM0GU3lGFJ4b2UbKxjt1d55pLT8uvmxdsv+BaozgvEcfSe8w3GSAGv9vDx5zjUk4q+er+kbgzEzaiccAMoz2pfSDwRlTozoTE7Y2gnDoK8t7Ig6nYfiRJUXDYc28UNIwhD8CMvB8z0DKZWbtupEVmqEYD9Y6zU4kLcntVsgeSD0Gm/0HacbjKPeb6Xe0+Q9mPkZNya6Ip8KgE35MDXTnhyt4BtkaraSKVJ51dVepApWFzDMZcuiMThG2vwBO83WihZ5wnvQ2sVbPR1QzIpGDxxBVXMOK9pGng1Cr+YSSu+f1d862OXZv6lCdmI5BV67qLuJR8s4d1LrmalPmK6j5smjkXyfRcu4bKdY+nM/6FSCa5eKt7MyxaAsXo1ZpQbfA41pbp4+LdYsXypqPCpWd1rJcnuUh+J2fOdL7kOPQamZrArl6oYh2lXDr8XnlbAEkzXzad4CQioLmm+eBWWHRxS0sed6QgpIKZhdoM+OyD/wKHIKz4soSQvz2mk72Xs/ezYgcpMCpxahrqtBZOGClFdAD5cM3bX2P0xi9Q3wDHqFTms9rvhxu0pnv3SmspsIbeKXZc/rxh0XCtcuiShIGZoElsQ6GPFC71gg5nl/4Fz7f5Nm6QjCKv5AUpPLAZqAIup+QHc5sKM2TdLfXGxDoGw6AJxEK+M6yPRlzdzzjgtpqGggA2i0oU/MCJuNQYgKvAsqyu70xEuN6tALgFvGQ5Iz7oH8urGVDEr/8/G0NdAh/CiSk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(2616005)(7696005)(47076005)(1076003)(6666004)(316002)(5660300002)(4326008)(426003)(86362001)(54906003)(356005)(70206006)(70586007)(81166007)(44832011)(40460700001)(2906002)(8936002)(36756003)(336012)(82310400004)(36860700001)(508600001)(26005)(186003)(16526019)(83380400001)(8676002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 23:52:38.3305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8326c9eb-798f-49fa-af5c-08d9dc6ff08c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5477
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Kent Russell <kent.russell@amd.com>,
 shaoyunl <shaoyun.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Problem:
drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c: In function ‘is_fru_eeprom_supported’:
drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c:47:3: error: expected ‘)’ before ‘return’
   47 |   return false;
      |   ^~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c:46:5: note: to match this ‘(’
   46 |  if (amdgpu_sriov_vf(adev)
      |     ^

Fix kernel compilation:
	if (amdgpu_sriov_vf(adev)
		return false;
missing closing right parenthesis for the "if".

Fix style:
	/* The i2c access is blocked on VF
	 * TODO: Need other way to get the info
         */
Has white space after the closing */.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: shaoyunl <shaoyun.liu@amd.com>
Cc: Kent Russell <kent.russell@amd.com>
Fixes: 824c2051039dfc ("drm/amdgpu: Disable FRU EEPROM access for SRIOV")
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 0548e279cc9fc4..60e7e637eaa33d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -42,8 +42,8 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 
 	/* The i2c access is blocked on VF
 	 * TODO: Need other way to get the info
-	 */  
-	if (amdgpu_sriov_vf(adev)
+	 */
+	if (amdgpu_sriov_vf(adev))
 		return false;
 
 	/* VBIOS is of the format ###-DXXXYY-##. For SKU identification,

base-commit: 2e8e13b0a6794f3ddae0ddcd13eedb64de94f0fd
-- 
2.34.0

