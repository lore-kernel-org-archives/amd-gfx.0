Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB75C77B7F
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 01:43:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2626810E31D;
	Tue,  9 May 2023 01:43:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B98910E31D
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 01:43:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOddfH95gHZljqAGpJMjBIWdBbm3bHrTKBU2/fqjbZsmMWz0kRTZSO/lZjPfKuGaf+0ZxX0v86iKaspLTbWjHpIdQrb2jbwH9cX2Cxo5d3hiShiK+X+72aYmrC4A2fPYAAKw0trZCsmuvvCHWZZglWONrQiDiFsAuZB39CNuCn/UTGmW/SZvFVf+NPhDWMNKRyET4p3E91oaENBrJ9MGbL2ghByIenTFKhY2bXhjjkmQteoSu0xy19Htc2vl/ykk4BRGnbGSNbYkZb+Z1NXLjgNt+MKyAb5BuMDLZN2a71KCxgq0S56SOwxxdhMvP4V1NCKZdJ/cjrXMATymGA1/SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epEbjpZM7wsF9G/3Yr8We5yFig96wKljw/9ErBskrlI=;
 b=OEdNf6Fk3PqCXgmPQn7BwZOp0otURivkkjn4tHh6VfvdTlpZJTyh7ZZpu/eCpcyLYuXCmK3zmiCYHiOHAzCSfMQdRlRZb+h7P2KFZyery+4JBGSa2mRiW5k17vZk10BiuQO88/Og45jfXMMP9ZUDZ3Ro9+1SsxTg1SDPjEk3PJWKIc+iAUYX2s0igjuK+RH5vj3vQOnlvx2QcskOOxtbmqvPUKH+WkZRur5e9dNBqhwlh6zVnO0YmF1cPN3zt8LqCU4UQy5xKowCnPkhav7/28Tguz9/bth2Lz5eKX0H4b3hZ6Gt6xkApD53o83OnjmHw7RjiRJl1eBYviXqVYxD+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epEbjpZM7wsF9G/3Yr8We5yFig96wKljw/9ErBskrlI=;
 b=j3frxhX6gUjDb70hS+IAKv+2ZWnl8rog2LrahdNmd5UPEYVp4R/z9AqnQh87eoDQGWqoX7WLy+2hM1f4sI9JsUQmw4Xs7qWnJuZ1xVOqci9NeWw/0M5hhbxE5KQ1+dwD053N9zAIO1xndHN5KVVLF9jUlFTw0DlzTGBpcQPJ9Jo=
Received: from MW4PR03CA0149.namprd03.prod.outlook.com (2603:10b6:303:8c::34)
 by SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Tue, 9 May
 2023 01:43:07 +0000
Received: from CO1NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::5a) by MW4PR03CA0149.outlook.office365.com
 (2603:10b6:303:8c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32 via Frontend
 Transport; Tue, 9 May 2023 01:43:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT073.mail.protection.outlook.com (10.13.174.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 01:43:06 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 8 May 2023 20:43:03 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>
Subject: [PATCH] drm/amd/pm: avoid potential UBSAN issue on legacy asics
Date: Tue, 9 May 2023 09:42:33 +0800
Message-ID: <20230509014233.2101573-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT073:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b14a24-edf7-4bfd-3803-08db502ebccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 57n8c4Ckn1afy3AMCTWxeKCkJVlK1PkbeGq8eOuesgQ879K3ad6XAoS9JgMW1ZH2Xegn914+kZ/h3Svd6lXb6BDFEy0HVGbKyGOZjGx5PYw5zRXyfv0Q8bJR6/ynnuUegglsu+pWspItSSR7vip1yed5HdocXebOvSyzbqwRS3GF9lCr3aroVMyuwfr1DBI8G2LCPRnN2GFgasBVrEYE0wzAQABD589XtiuYlMXfUfCctvMuW5pG9HSYEE4JP8+1y/KvXde6RXdQrhem/Yfjwl8DPeVn2nN1FnaK9jGRUWhg8SoIMxsOON93/2FTvnMf66vcwfnvEwPVgKW213rQT3JAE2BqIkOT/WHVQGlpx/N1Tge/EHqep2NjXgoFCFwliNw2hIIC40y8YW1RR7NGKkxuUDMZKp4TFMN9qZs4itrXPRp0ySdYAsAAoY176hJEQe3sDpCbUyVqkONoz4k81a50l9UcJ43BOjs7mJ/4y/rOq01iJZv82o1oNkhlmL37jvcTZXzLbo6Ykuc/Kj58TRid0IHH4g/U8L/vRJ2Dy7wsBsfX4UStB93mrxtFDiuD7tMuZHQ7BF2tP0qpecHRqQDBEyojVprTrt3GZzhG3o6GtwD2uODSNN6zI/m60Re5nlljdW2X+2PfeBc/h21Uzb2/1+ll9AcCIG7FGVHAeh/7ue9mk4/mP3pNDNh9HQNcnJq9Q8QRiYbSa9vx0SGHmvdjhQefHeEQcGXR/EiFvIeyovSTs0QZS6rScGBqloGM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(4326008)(5660300002)(110136005)(44832011)(8676002)(8936002)(41300700001)(6636002)(70206006)(2906002)(70586007)(478600001)(316002)(6666004)(83380400001)(40460700003)(7696005)(82740400003)(1076003)(47076005)(36860700001)(16526019)(40480700001)(86362001)(336012)(36756003)(426003)(2616005)(82310400005)(81166007)(186003)(26005)(356005)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 01:43:06.7778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b14a24-edf7-4bfd-3803-08db502ebccd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Prevent further casting on chip MULLINS/KABINI/KAVERI when calling
amdgpu_dpm_is_overdrive_supported, this can avoid UBSAN complain
in init sequence.

Suggested-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 86246f69dbe1..ccd3ea89eacf 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1467,8 +1467,14 @@ int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
 	} else {
 		struct pp_hwmgr *hwmgr;
 
-		/* SI asic does not carry od_enabled */
-		if (adev->family == AMDGPU_FAMILY_SI)
+		/*
+		 * SI asic and chip MULLINS/KABINI/KAVERI do not carry
+		 * od_enabled, as its pp_handle is casted from adev.
+		 */
+		if ((adev->family == AMDGPU_FAMILY_SI) ||
+		    (adev->asic_type == CHIP_MULLINS) ||
+		    (adev->asic_type == CHIP_KABINI) ||
+		    (adev->asic_type == CHIP_KAVERI))
 			return false;
 
 		hwmgr = (struct pp_hwmgr *)adev->powerplay.pp_handle;
-- 
2.25.1

