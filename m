Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31012C7EE24
	for <amd-gfx@archiver.kernel.org>; Tue, 16 May 2023 18:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18E6A10E07B;
	Tue, 16 May 2023 18:15:48 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6B6A10E355
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 May 2023 18:15:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+nUDDU1DR4p2rbI7ZZWil9g6DriICHRSlQ4a5WkqvBjXxSEemKpqSEYW8JKhD7S7nNvOHZUKrozxEralPtDnDKeDFwISgvydiV19X1C/HlJPA5V2k0ZcCJ3txPDLU4AeKHXbKLR2Ab08Zt46U2ptrV1es4CpUT+aCceD2aEvU6K+zPWz6OhM+wJu3+1MdqMtd3sljOVu58JyYUbD6XlJwUZVpxS7SukjCcxJ2X5uHEs2bMR7GjR2uoR1nQo16HbdwhZe85WfDQBvoo96seonAfqvsJLg7ZwQ6JqLdP/RL4F93XKhJ2SnBw3xXvN5aXMlsr7BH19ZT75jfgopCze3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htoLw9IEQmhq9DM1LYEdlCguMlZZqZPsz/eUIsWd4PU=;
 b=JcuTFG5P6MFUlqAgYgTZXd94kQhPjb5hZedi5tQM6vUMXoYmRfesIBKRwfvZnK9B5ZSKqsOTm9syamXLWRgPFlOcaHc0JdbcHcfcCN0vD3rehLhgzMi2sIHztVZ0DTD8a3Er4YM02u10cwPRNEkAoVFUorYQXtOWJWdVO98ioZnfitkM9S+GaIB+94h3CqDbOVWx820AfVyFGNpDpfMOVVXvOjOxoPOr9rswlWT7QOB9EhDqiSOERHPlIlwKNaNfXPdTW8UIbLzrOd76bRwna0l26D4hf0FHT8ZOLta0iqyXK/6l66lAeDoupT7lh0lN4upaRB7/kQME7SFE9cTj4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htoLw9IEQmhq9DM1LYEdlCguMlZZqZPsz/eUIsWd4PU=;
 b=4dDdmRxgaOEMrqSO8sIKwWpbBJtglmg8Zo0dGEuGJF+AElSwp4iI0EQch+xtPjUSXERcvNrtk1DWT/8+o7NOwimZ4VVw1vl3IJDdiYS0TGuwHXsEPQqgfi5nUnxZhEOI/h+KUFbyHWnrUcEQHubpaxeBdsSJR4Dr7A60N41H6lc=
Received: from CYZPR02CA0006.namprd02.prod.outlook.com (2603:10b6:930:a1::6)
 by DS0PR12MB6391.namprd12.prod.outlook.com (2603:10b6:8:cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 18:15:44 +0000
Received: from CY4PEPF0000C979.namprd02.prod.outlook.com
 (2603:10b6:930:a1:cafe::29) by CYZPR02CA0006.outlook.office365.com
 (2603:10b6:930:a1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 18:15:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C979.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.11 via Frontend Transport; Tue, 16 May 2023 18:15:44 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 13:15:41 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd: Add safety check to make sure RLC is only turned
 off while in GFXOFF
Date: Tue, 16 May 2023 12:52:14 -0500
Message-ID: <20230516175214.3491-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516175214.3491-1-mario.limonciello@amd.com>
References: <20230516175214.3491-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C979:EE_|DS0PR12MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 403a8db6-559f-40b9-7643-08db5639908e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7QBCVGc0EM7CPtnwkrYHPxP8H7UkkK5zNlt7wAINHWIjnu3T/BRAVma9dFUtV1t45BGspRcJDMobRLHnApDrMbk9lL0LUJXnd/oCwfPWAYBYraNVJ9mMk0WmIpgTI7v0MEF2ZkPiuA9MA4dgPdiekG8JASHk49qx6kjbBq3y8stVO1Fg9n1LP83i/MgO2QENguJ78vXx9VijAKrAu+un9Y+LRQ7q1kqYmZ4GLUXQ5+E54hdP7VkMSTbf3yPzYvko+PV/IVPGejca+/l8vceSppV3jxvpUOQMZShzsdgyvY+/CNA1/RzMLXWbu2CsI2fbHmdDkvNJcMEkVcxuf92bTosn1lH/f5yGRiB0m9XGGFEkqozYJCj3eNss5QWqP78L8D6k4K6lisDjdnYEZ2NAKqq2bkcb15lQa+wb9f6XUfneXojhTJHypb+nVsS/fSmnvB99679E1DarQcLcvpnYVPUIIWSz/ALuTazJ0gCtgGvuQT1Za4T4Qmd1Z6Suk5JjpFJM4HBPqC8mP1rWaYrP2RnrcQpOm6FMQo+0ujvU3EibEiOtAWSqn+/eE+eArxPLbN4ISKw2L+/FVHQsWm/c2s5OgQavtnTEck7EqGV+AvzhjiPVYLy/5LB+udpVgfp2pcddw5biEA1dj6gP7R1WrnhIuar5FlYgVcw4ls222Tfpaxr6TSfWbUIJvxob8u2DFzGU8SSNf5FUGVA7NxvBkuUeN5vDNu0K3vH1LCrc4Nt97urPKZ3gcRUY6yARBpmYk/rgDgbVSdMemx5Gf1DW0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(86362001)(36756003)(7696005)(54906003)(316002)(6916009)(4326008)(70586007)(70206006)(478600001)(6666004)(40480700001)(82310400005)(5660300002)(44832011)(8676002)(41300700001)(8936002)(2906002)(4744005)(356005)(81166007)(82740400003)(2616005)(336012)(426003)(16526019)(26005)(36860700001)(186003)(1076003)(47076005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 18:15:44.0499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 403a8db6-559f-40b9-7643-08db5639908e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C979.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6391
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
Cc: anson.tsao@amd.com, Tim Huang <tim.huang@amd.com>, Juan.Martinez@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>, richard.gong@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On GFX11 if RLC is stopped when not in GFXOFF the system will hang.
Prevent this case from ever happening.

Tested-by: Juan Martinez <Juan.Martinez@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index dcbdb2641086..f1f879d9ed8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1766,6 +1766,10 @@ static void gfx_v11_0_rlc_stop(struct amdgpu_device *adev)
 {
 	u32 tmp = RREG32_SOC15(GC, 0, regRLC_CNTL);
 
+	if (!adev->gfx.gfx_off_state) {
+		dev_err(adev->dev, "GFX is not in GFXOFF\n");
+		return;
+	}
 	tmp = REG_SET_FIELD(tmp, RLC_CNTL, RLC_ENABLE_F32, 0);
 	WREG32_SOC15(GC, 0, regRLC_CNTL, tmp);
 }
-- 
2.34.1

