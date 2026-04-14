Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4E2ED7B8B
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 08:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C80410E5A6;
	Tue, 14 Apr 2026 08:43:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r6ekc7wy";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011053.outbound.protection.outlook.com
 [40.93.194.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0506010E5A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 08:42:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1qNcjb3O8x8y7dxiL3Y/bPL1H+ogCzWSA2M9XlwXiEEms2AsHCzNcic6vDJxIiGjL6UDLWnYGyzmGI21351gx3dMXo8LPA9/1jBkxSM4Px2b8Cm6ymdbMmOLwVeHXJFCEGOT767ovRZ+lbztOZ92kXA6J+6NRBk+FxdFkjEwY9jkjRUzIgB32MbNN3AgCrSA2MRkz+jLY9Bqv9IN/TLeaEFs+kmje5hsbnNE+5hLJQItVKuZjit2oKnGjgyh383YiBMnZGTIujGUJtgFHJXRwKLk+FHmVY+IoRrqeZvxYm7q5yYsK+AgVDTC291YMiGC1mWI9mDCeo6SRs7r8M5pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfISsM5UZj4yCVyQ4cwUPfn4YG8bbSaO1fxahBN9Vl8=;
 b=azlCnlsb0vVQpfoZMh7V7m/iX6vq0wvTmjBW8Tt4tQxxF/Zeh5LpeJ+7ujlmpuOG7lLQMzH9pXY0YMIxGRnsgUB8q/cCNZT2eUILGCvCM481A8JYh0gYpPt3OzPbbBDjsnO43l+WdtBee7ersCzEK1AbtFrT8LgneHz/CIwjz82HzrqIdawtNKimb7qai/uDDzbAgXFG/rB1ifXLS2QAVkPVbF3E5P/+y4I5460gS5xACEEuIxdUo1ns+/mel9sE5YWpCJ2TgdiBym1kiQzne3zVQbQHAxPfTgaW4kogpnVB1WxwdVZcCecMvc/yRmzm6MJXV9HlgrhoNqeggPZy3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfISsM5UZj4yCVyQ4cwUPfn4YG8bbSaO1fxahBN9Vl8=;
 b=r6ekc7wy+yaPD3EWRZCKQ5S4xY4d807DQQgQZKS02Hsq9WAoHjywVMDHJUW0NGR+RBYvSyILa1tCjsQPOeFDRVED5abWDcAhlgabg6y5J6IL4t76LnuXJX/ziBE0+3/Q+8UemAM6p1vf+Ko6wlNVQGhr8r0o8LUeDMCkbY+DWkg=
Received: from CYZPR05CA0043.namprd05.prod.outlook.com (2603:10b6:930:a3::25)
 by LV3PR12MB9234.namprd12.prod.outlook.com (2603:10b6:408:1a0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 08:42:55 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:930:a3:cafe::69) by CYZPR05CA0043.outlook.office365.com
 (2603:10b6:930:a3::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Tue,
 14 Apr 2026 08:42:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 08:42:53 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Apr 2026 03:42:49 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <error27@gmail.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>
Subject: [PATCH v2] drm/amd/pm: Fix mode2 reset ACK handling on aldebaran v2
Date: Tue, 14 Apr 2026 14:12:36 +0530
Message-ID: <20260414084236.2333815-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|LV3PR12MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: bb9be7f7-16f0-470f-4230-08de9a01d167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: xFTM+p+AptXrMvxCwt4WqeOyOih74IsZi8KBD/6Dtgdmc4Z/3yWkDL7cavQvVzpw+8LupTG0WBFE3OjBKGMRN1KmxpZBA2x7aU/OQsjYOzaYYlhtah7U2b6C+HtTB1X8X5M04+fz2M+LOk01vcr0ah4Rl57ulBT2Dg+cWCVwOUhob453VDDNtw6PjTD/oYX5nFf13w5pnkg58P/pKUXEv2KBIA2GqAv8jDQ7ibr/aC/yI8RpzkvhS3M+ynqPiIEZXDQZLvuja/0311vzGJBPJ/GIcKVs0MQGsuugWKBEVaxx9YZ0sDtOtqJmnMfvWeo/B90d1keLC2BXxI6m5NwR6lpBTdE8KFZQ4WvO1RvC2DZxVxiGC+tOSWWCQ9h7hvt+nhn0hkGM3HzkhUFwZcBl4XqsuJoOJqAia/UHAmgS+I4pMp+xV/stzO5kXQH6J2pHkq1kRQhno8lAZ7LAZeDneZfPohp7LuX7ChluC5eRgakJVbE58uZlByn0rCIUxre1ssRXL4gD+QrDT3JihzI+bCZzhU+r/k8WpMouZRXBOQNbIuZ+iN25c3LmPKpZFNIkOrrOLB41tO38CSElxML3EwNqeGocdp3nHeizajuJYQvwDzGsth4XOa5N17Ayj2CRLY0zwdCiAS9bPZSu+F6ni+QbKXFvr03HWMgKeXWruOcDwkodxbG9jrLPD3vBinl2NDDp9dPqv+cbsospabMDFd+JOIUKifjVjdzYAabP7C0RY63NZtIahV3TzZeXaq7AMKuDCWgyqVkA9UcXREN2zw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9GO5c7GiLKOppZ2YGdoryJ5BA/lRW/AqB7YAkmqjkp5DrcEqgHPBraI8GquLrLFpbnJiwPdBaODLSoAdz7B3gPI6bKMPLXO1H4L6zjIlgpP47n4fVg7fDyklUZ1e7xxLQO+0b68l1lo/MIfTbgLc3TtK65EHRJaFCE57A1uAQgrlPGdP/hFEgtHhAchQQaGelR6H7WiCaSR+F7+jokFoUJJd/zfCl9RoTt+Y4nmArFLrckCQi67rwVuScprHOjKory7vyqlBxKd0cQ0YQyHTGsSykiymTEp63zlb3h84qop1CH/gv4POpIHHoqkuXXtup0fbDs9pkG1K08s26uZ/4/eKut4mkHRVrjm+F0L80A0LBbM3QhhGSOoC0o5Xn38dtvmGiVrN1LeJTOvY4V7IwqMw7ZpxnCqWU09GthWgLCCSCQIZYJK10GjIM42o7PlV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 08:42:53.1605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9be7f7-16f0-470f-4230-08de9a01d167
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9234
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

aldebaran_mode2_reset() sends a mode2 reset message and waits for
an acknowledgment from the SMU.

The current ACK handling is incorrect.

The wait loop runs only when ret is -ETIME. But after a successful
async send, ret is 0. Because of this, the loop is skipped and the
code does not wait for the reset acknowledgment.

Also, the code checks for ret != 1 after calling
smu_msg_wait_response(). However, smu_msg_wait_response() returns
0 on success and negative error codes on failure. So checking
against 1 is wrong.

Return -EOPNOTSUPP when the firmware does not support this reset
message.

Fix this by setting ret to -ETIME before entering the wait loop,
checking for ret != 0 after getting the SMU response, and returning
-EOPNOTSUPP when the firmware does not support the message.

v2:
- Update ACK check to use ret != 0 instead of ret != 1, since
  smu_msg_wait_response() returns 0 on success (Feifei)
- Remove unnecessary handling for ret == 0

Fixes: e42569d02acb ("drm/amd/pm: Modify mode2 msg sequence on aldebaran")
Reported-by: Dan Carpenter <error27@gmail.com>
Cc: Feifei Xu <Feifei.Xu@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 259e5a13c1bd..cb7cbbccb875 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1847,6 +1847,7 @@ static int aldebaran_mode2_reset(struct smu_context *smu)
 		amdgpu_device_load_pci_state(adev->pdev);
 
 		dev_dbg(adev->dev, "wait for reset ack\n");
+		ret = -ETIME;
 		while (ret == -ETIME && timeout)  {
 			ret = smu_msg_wait_response(ctl, 0);
 			/* Wait a bit more time for getting ACK */
@@ -1856,7 +1857,7 @@ static int aldebaran_mode2_reset(struct smu_context *smu)
 				continue;
 			}
 
-			if (ret != 1) {
+			if (ret != 0) {
 				dev_err(adev->dev, "failed to send mode2 message \tparam: 0x%08x response %#x\n",
 						SMU_RESET_MODE_2, ret);
 				goto out;
@@ -1866,10 +1867,9 @@ static int aldebaran_mode2_reset(struct smu_context *smu)
 	} else {
 		dev_err(adev->dev, "smu fw 0x%x does not support MSG_GfxDeviceDriverReset MSG\n",
 				smu->smc_fw_version);
+		ret = -EOPNOTSUPP;
 	}
 
-	if (ret == 1)
-		ret = 0;
 out:
 	mutex_unlock(&ctl->lock);
 
-- 
2.34.1

