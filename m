Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCA5C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 18:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9665B10E780;
	Fri,  4 Feb 2022 18:48:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0008F10E780
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 18:48:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3HUSgzj3gTH/etN3JMLdVVWi/LAiUQoqp+CQhBZ+KnNnQdn83i/8z9HGfTozUaV2ZUdTn1Gtlo54bOcGTk50qomqN9zUI8IKQyf6J4+wLUsF+hBiXeSB/gV8rlP7uFLmysuTjV0rcIiphbYqvdaDXn77nu3vy8PHu+fHj0oOhGxRTdaqHNntZTRv4sAWOZZqp5Y84FuxwN/ff19Ti+8ZfnVSHJeee63hhYMFqfaUe8jU4KBOkRt/Pvn6tfOJAzztTuNiDSiANlqhEPLorlCWOT+ObLRZFuEUHzNr9A/HZJ9Z1w1M16VdHvE3sZ1PfUv38ZkS2MRO3MCNcEK9NX9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwrOR8yaBQJDgqedvjuemrKwbM4Zr84p2KFRUrGLm7s=;
 b=BLBhjGm0FkC9gXpYG0Dkg4gXHd6VyOv1hxcgdJR+lVicadJciMdBt4VOfcOebF8xgZLWua/POb9KeHN7pOXmSPpP++Y+w2mgzAJaK52DP/iKH/yUF5xlQnPJNhwr5MA8IGIj1nZVnDfTzfIsi0j80jp+FR+/3vSH/XV4bu1nl/ylbX3Mpk0b6AcyCjDAuil+8WFEMBq91V5YFUmXnZmx87XTdgN1DrhsTSQkOURViBj+CkXiy0pKxKD0GNTLvIHZHeg2Mh3Wau+pR3U3vyfO9wMHaXjA84wmygqeReeDyDeu+/Z+3M9u10zYuuMzX9KyTho1+GjRwXzfFE/iak531A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwrOR8yaBQJDgqedvjuemrKwbM4Zr84p2KFRUrGLm7s=;
 b=OEz9ZiTO1GzS0GywFy6Iq9+Ely2fcsH1rYaLJDom7JjTtY7IqSr8wMgKxCaSP4h9JnBFzaac49ugdRxJS1083tTLq1cp9Zsc2vpxJq69VVsJtR6I+8J1Cuzxrdbo1Dt6xea17VrCmKFQud5RyLsR0gmUQT+kSjbZrHFJ++d2EgY=
Received: from BN0PR02CA0037.namprd02.prod.outlook.com (2603:10b6:408:e5::12)
 by DM6PR12MB3004.namprd12.prod.outlook.com (2603:10b6:5:11b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 18:48:20 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::86) by BN0PR02CA0037.outlook.office365.com
 (2603:10b6:408:e5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11 via Frontend
 Transport; Fri, 4 Feb 2022 18:48:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 18:48:20 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Feb
 2022 12:48:14 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Set FRU bus for Aldebaran and Vega 20
Date: Fri, 4 Feb 2022 13:47:56 -0500
Message-ID: <20220204184756.5387-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.0.3.gb23dac905b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19abd1fd-62fb-4e7a-1587-08d9e80ee9ed
X-MS-TrafficTypeDiagnostic: DM6PR12MB3004:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB30043B7FE4F62A0BA2D7AC1099299@DM6PR12MB3004.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:317;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MnNWCflvw3oYrMCTdzNBbgbLhmGvHRnbU7ph9RM9Ork2TbIDf7F7dKYsnk+3KkoUn7XVJQMR/BRVzE3pf+sgsL+SmNz/YoufFF+PVUjo4Gv+JUBJMqBgMbRGoEXqUGWNNZAxqaQ5sXknaU1WUgmTPSDul00NJ0F2h/alb6b1diG/LUj33/++eUcHg+IQU399V/vWrzKtLWGetFr3nqc4G5TkDgzCHs/w3azFhXqYqxDd7hBS76xPd5fHUw16b8fzI4aek9+uRUlX5TUnXm14KuqucxzHW8g3iqMpai8JmTypwdNimViEDftTqDtM/zgKfiuCJnW3HziCfK1fMwjIW2C1RVv1CKczqMCQr8Tc7yECaLWmFJJRFh7WorEYcFIvd0ACTE0dAdzANm9HNMfOxSS9/AuQzsgQ4Jph4q8Kk+92zP36WuBsvKSn4/feB+n8rxGo+fqZnpgJDnw5qpvDNhGQNC8wM7RLcDU3h64hHEzitL8I94DuAgRI2+JDKCo1RZbtOB/aB07k+5UcmWxtFbNqvXrJLTZyjRJzNG7oTq5Mu4HR77xgImsJLmJTL/4NOKuB8u3CxZk0CFchIJFlO6DSoGAFSx7aUxp82LB0kG/ek8wqoHn3q13sAqC8XsxSdCBFoszESspzx7Uaab0bVLq1//H5scKOqh3nGzW9+Lq32o5GOcjAZnxm/F2VeWQCtwAxrsU1zJFgs1QSiYlvhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(356005)(8936002)(316002)(81166007)(6666004)(36860700001)(508600001)(26005)(426003)(83380400001)(5660300002)(47076005)(8676002)(4326008)(2906002)(82310400004)(54906003)(36756003)(40460700003)(7696005)(44832011)(2616005)(86362001)(6916009)(70206006)(16526019)(70586007)(186003)(1076003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 18:48:20.0669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19abd1fd-62fb-4e7a-1587-08d9e80ee9ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3004
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
Cc: Alex
 Deucher <Alexander.Deucher@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Roy Sun <Roy.Sun@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The FRU and RAS EEPROMs share the same I2C bus on Aldebaran and Vega 20
ASICs. Set the FRU bus "pointer" to this single bus, as access to the FRU
is sought through that bus "pointer" and not through the RAS bus "pointer".

Cc: Roy Sun <Roy.Sun@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Fixes: 9c6d2ba7057abb ("drm/amd: Expose the FRU SMU I2C bus")
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c         | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index 87acb089cfccd5..dd2d66090d2374 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -741,7 +741,7 @@ int smu_v11_0_i2c_control_init(struct amdgpu_device *adev)
 	i2c_set_adapdata(control, smu_i2c);
 
 	adev->pm.ras_eeprom_i2c_bus = &adev->pm.smu_i2c[0].adapter;
-	adev->pm.fru_eeprom_i2c_bus = NULL;
+	adev->pm.fru_eeprom_i2c_bus = &adev->pm.smu_i2c[0].adapter;
 
 	res = i2c_add_adapter(control);
 	if (res)
@@ -756,6 +756,7 @@ void smu_v11_0_i2c_control_fini(struct amdgpu_device *adev)
 
 	i2c_del_adapter(control);
 	adev->pm.ras_eeprom_i2c_bus = NULL;
+	adev->pm.fru_eeprom_i2c_bus = NULL;
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index ba4c9771ffc56b..3d96d4af92d97f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1583,6 +1583,7 @@ static int aldebaran_i2c_control_init(struct smu_context *smu)
 	}
 
 	adev->pm.ras_eeprom_i2c_bus = &adev->pm.smu_i2c[0].adapter;
+	adev->pm.fru_eeprom_i2c_bus = &adev->pm.smu_i2c[0].adapter;
 
 	return 0;
 Out_err:

base-commit: 24b54e10043609a55194badff58bf91189c49793
prerequisite-patch-id: d694f05bfcdf100c1d6957afa209e304dad98404
prerequisite-patch-id: b106a5bd7e0d3a7c225a767ca4384162353cca9a
prerequisite-patch-id: 77d04393fc872e4f4dd158659bd44ba40b749883
-- 
2.35.0.3.gb23dac905b

