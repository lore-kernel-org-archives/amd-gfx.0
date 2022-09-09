Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E07ECAAA1
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 22:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC91910E0DF;
	Fri,  9 Sep 2022 22:45:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34F2010E0DF
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 22:45:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Az2b5s7FRvwhcCYsqgXvlYAVYgrryYeNkwmY+gxepKaR06AfeSVNBw/flKr+XXOmou3DH9kQByHHsduNaDQu+xCjGLD3oRBbPTnpQ51XFEC09Gf2EesdhGT3QVNTmCXM2Ww96Fnq+uvJRjFVWlh7ivgIbZarrVop4ebkACp4ygcW1DqqzUqwjiX+Wlxh7x2O95VUma2yC5Wwu2BhN5qccvNhCsAX5edAReu6ADRGEs9oZN8ZpHB2dF2hx4IWTKjHer1P7zsGA2etM7xEiHxk54PNUO6DmLLVz3Lt0X13cWOxQQqwOJtck8wzLU2ZPa4xSV4dUhjfhEjWhWyjKalEFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSKAvBev4kurmE0PVlYgRQSGeW4/KVx48z3K0ybi4XU=;
 b=N4YY9E0LTP7pq3mMd9iRvTS3o6W55+CoDwuL1Gj5c4yUCEmhS8PatxPCTq3wsvO8qaezQkXgqEWoohtJzKFXT5ztvBw7toWC6fApnxxGf4N2G6CH9j/U8HnNgbWvn101V2CGRUsgTrhoBRZBLlt58rbaHeH72DUUV39R7N0WXE3LnX9Al+WnOy9alNH9pEGdp3mJAUg9j4vYEf4336/z9q8buy+Y7T1fXNzNsRu6RyhvWLqflJMx7lxMsGbrHgXNAZtpp5D8kkTw0Vi+9NrAhLt93fg1T27aQSC58apUxvJioj8QSKGQlGiX8siWJ95RT0+ihKFncYxcRc17qXMaeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSKAvBev4kurmE0PVlYgRQSGeW4/KVx48z3K0ybi4XU=;
 b=Ncw6aKRdgOwrFbSS3UlIJPlR+w/i0NO26K997t/TGGdVcY54Rw5FllKBw5+SVl2o7keIv3Sv1ipc3TtitmmyBDz1n3O0BwSwf3RapabLb8MKkKL0KaE2rN1hVFeJHTjeG9BrbdcwlkfKgu8cNdc52sOGs6DPKcznrfXFyEXEAHU=
Received: from BN0PR04CA0184.namprd04.prod.outlook.com (2603:10b6:408:e9::9)
 by PH7PR12MB5853.namprd12.prod.outlook.com (2603:10b6:510:1d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Fri, 9 Sep
 2022 22:45:31 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::d9) by BN0PR04CA0184.outlook.office365.com
 (2603:10b6:408:e9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Fri, 9 Sep 2022 22:45:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 22:45:30 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 17:45:29 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add EEPROM I2C address for smu v13_0_0
Date: Sat, 10 Sep 2022 06:45:16 +0800
Message-ID: <20220909224516.5738-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|PH7PR12MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: 7260800f-337e-413d-081b-08da92b4ffd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QhdVBzk+tNLkudgyLLSccd6tYt17Rgpk0d3yy8BoZ0DDj37/ZZqYhM8F/iUOsWo5TjKxVcKssF4r8aflePcu0TtBGHpSPukkE2zRuR1Qx58S+VAcHsKZQBm6j0BtiZ/w5oBlZp2/DckQKLdOkXLKugyjTsj0bGvBVTr65oR2NSct31DvkNelwsMtbW1fLi1SMSs0Bw51B0z1JtaSgn/mqqzbvDonkvUs5j/njybaVQUW2I7/+4wLG7+ZExBKBIt3ozld5ikqP0khRI9kfXa5rehzGOi0E1PM6LylErNPKZ69CTbv+dt4b0aD9Vk+c96W+pRLnRbh0mmQN+ZZCRjwtAYauBGGwsBa+1TiGvgjSv9fgZhxw3H3fZ0CegML/KZSLpe8WQyzKlK2EPKeN8FNmTBjd8hhjHbX384twXq5j0w51MZbnSMtjgd+rfznSIOOsQU4AeR6DYi4/lLTik3pC5k7qrshiB3gC3vNs+jei0UTLbhL9G86DHLp0KXn15x8USr6JUvtwDCMwSncDlac7s6x7K/y42hZHp2GWHMMddprzDQdBiPVPJphS15wf/sUKBSlpUhii0U5AfDroNJhDsxL1kAl0Q7d2sF1HG1qL4BwQrRjbwCKfHSwCuhKLDFYclQiZo/2TKqwlc5IfSbv2h8E8L6Zl4xgSlSzKb31Kzj0SdjZ4peY2xmnc+ozItHyZz8Kc30o5DerZnNjjpcHpEwPVjMtsFjVL8nCAuQuXnKev9k5EtsIy65c6o0rs1q5gTTqQXNvWTspboq5/WHO/LvygH2oWidPntL+CjI2LlM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(39860400002)(396003)(376002)(36840700001)(40470700004)(46966006)(36756003)(2616005)(336012)(47076005)(426003)(16526019)(186003)(1076003)(70586007)(5660300002)(70206006)(2906002)(6916009)(316002)(40480700001)(8676002)(44832011)(4326008)(8936002)(82310400005)(6666004)(86362001)(7696005)(26005)(81166007)(356005)(478600001)(41300700001)(40460700003)(82740400003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 22:45:30.9379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7260800f-337e-413d-081b-08da92b4ffd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5853
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

Set correct EEPROM I2C address for smu v13_0_0.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index c4283987bb1e89..84c241b9a2a133 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -38,6 +38,7 @@
 #define EEPROM_I2C_MADDR_ARCTURUS_D342  0x0
 #define EEPROM_I2C_MADDR_SIENNA_CICHLID 0x0
 #define EEPROM_I2C_MADDR_ALDEBARAN      0x0
+#define EEPROM_I2C_MADDR_SMU_13_0_0     (0x54UL << 16)
 
 /*
  * The 2 macros bellow represent the actual size in bytes that
@@ -156,6 +157,15 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
 		return false;
 	}
 
+	switch (adev->ip_versions[MP1_HWIP][0]) {
+	case IP_VERSION(13, 0, 0):
+		control->i2c_address = EEPROM_I2C_MADDR_SMU_13_0_0;
+		break;
+
+	default:
+		break;
+	}
+
 	return true;
 }
 
-- 
2.17.1

