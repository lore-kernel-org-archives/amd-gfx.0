Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDABC0018C
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 12:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D89F10E72F;
	Wed,  8 Nov 2023 12:58:10 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39EA710E72E
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 12:58:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guoH6JYZJd+ADxklewF1IBfe315tpdGQ+hfEzqjoR3hfgQEbL4FaWy4edRpppQ9kiCQe/oYkbk0DQkhnvq3h5GBOmN/KuJ4Ji/lzgz3KjrnvgfbQDdbkD9lDL7ra7xkTPYBYwT1451Ouu6VEuR4gfIoJLTKxifmFn0OIo6ziTb0w+C+ZShLkFwvFTla9Cx0lRXThlbAU19GF7n7rFvFJpAUXlcCnb4nuGwsT9gxT9zSRNgtsGTTytnMZfUOSL1gwleDGWUEfaxn/qxS+HbwYdDV2Uxt5ZPFKUB0ZAU80a6fFSIWYN+04pSyWVxxiLa2YXB+Dtr1YNxMdYmq6hWtyMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uST7QHwBVpP0heMO81GLL0D8O01eU3F0UyxcmtvZT+0=;
 b=UtDDeE5hbx4OJVQkB3rk8q2mUnkTT6B3D43B1Adk3EAu0AJad0cWTsJoiWD/eMy2qpXwC2Y3fDdHJbqEfQ72psMrf+BdLcvTV/9Xo3/6TRrC169bcgoE+cKBsQmCw/BvUFBRBOnWaSiRrCxWnrC+FuPbfBVwLUNwp6EmarR9K9Upv2dirzEC8+BvxI5z11lTYx4fayZiycxSx//PPNGddp/AqBvmJWp1L/+0IlgVgNYIdvbdfTAsW/gZbkxtb9QjLp7iOXbqZUhSxn78zF0zlM4WrrZZ75GYDebIcdu57xqMUQf1MUofYGqzncnDOY1b51mYEaHH+QzEosxkCw4Eng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uST7QHwBVpP0heMO81GLL0D8O01eU3F0UyxcmtvZT+0=;
 b=pcdpCMy700lfb33kIj1Ut3HMKvsv4afMk/89NE1AMQQ72ygo9Eg9J8HbdHyHXZdwXv3+8RhHVIzEVugj6vEYeFF0L3Hv6lv1VtJZDqWBVwbgrktr8dlBrhRJU6cGb2yiS7Y1fJBiXp9vU4Tdmf/luU9r0zHFTS/pTCasCsUYfyw=
Received: from SN4PR0501CA0115.namprd05.prod.outlook.com
 (2603:10b6:803:42::32) by CYYPR12MB8656.namprd12.prod.outlook.com
 (2603:10b6:930:c3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 12:58:05 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:803:42:cafe::2f) by SN4PR0501CA0115.outlook.office365.com
 (2603:10b6:803:42::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 12:58:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 12:58:05 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 06:58:02 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/7] drm/amdgpu: disable smu v13.0.6 mca debug mode by default
Date: Wed, 8 Nov 2023 20:57:32 +0800
Message-ID: <20231108125735.2497856-4-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108125735.2497856-1-kevinyang.wang@amd.com>
References: <20231108125735.2497856-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|CYYPR12MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: cddd0121-871a-4077-b6b3-08dbe05a5957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mSU/wV2qNFP6AGLmERFtB09InZMtBzNxtDXap0PVJiTmL+tNAtEIM+lVmmAku/1f+3AQkNRY0PbeAYi+W03FK5xQIAQTDel6GDpo1t02DI4ssCk7dCRbrSnX/n9xDm65X84i6NaB5Lo6oBA8o96hufyryafUIgS4mo+/bJY0cHocjt9ElsFZ6C5eB43uI2nx28PLL/xbr+tYQKbvba1gA8T7FEEyHtZAsMJiNkZLahkYbzTh8HIvhkVwL+NvW2UDP2ej5zohKyTsfHZZwgJHt9eFH7/8HsTHjHNF23pifWtuwSDb4LYX7S6lpyrwLpxsEAjeSLwTr//Entdl9w1iXP8bIq/dqXPgty06us1VMTUzCPgMUeEhQ2TGG2y+b1cwf2dCYV+yKdSMeeDZt74isigXhCtnZ7g/k3Ej14O+GmWzNJ310DZzzTsmUXuanJsUfmiFE/sVARck6bX11NuvVnl/jG5Yi/fmfhyjs5LmvGp5SbdG5cceu6Ozwgk83RgHvU4ur6V/IwX0S82VQ+lRclgAeOR1rVn793BhrOG66hBJ6eypVBAWj9vtjvRmgBZj7MF4nxVDRrso6JyCXERTNgfKpJbG5zqKzPs8XqDOiPXg4n5R5hp/ys7PpnbtKjyIeXuDkXWMB6W2RH0OZl/1P27N4YlI4qqW5JgMBAXTZ0qBvySTV4VLkNdZYiLJLuzEr881BbKbS2kb0BU2KxWA9SBtU98URVS2FFouycEDbykGLtRtHWjrRMAHKe4rGGrmPdMnqUz9TKC5NYgRASZtrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(1076003)(2616005)(426003)(336012)(40460700003)(70206006)(70586007)(82740400003)(26005)(478600001)(36756003)(16526019)(54906003)(6916009)(316002)(6666004)(7696005)(4326008)(8676002)(8936002)(2906002)(356005)(40480700001)(4744005)(47076005)(83380400001)(5660300002)(86362001)(41300700001)(36860700001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 12:58:05.3187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cddd0121-871a-4077-b6b3-08dbe05a5957
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8656
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
Cc: Yang Wang <kevinyang.wang@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

disable mca debug mode for smu v13.0.6 by default.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 5167331e140e..509023afff77 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2294,7 +2294,7 @@ static int smu_v13_0_6_post_init(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 
 	if (!amdgpu_sriov_vf(adev) && adev->ras_enabled)
-		return smu_v13_0_6_mca_set_debug_mode(smu, true);
+		return smu_v13_0_6_mca_set_debug_mode(smu, false);
 
 	return 0;
 }
-- 
2.34.1

