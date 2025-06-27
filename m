Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3FAC7EE31
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 09:37:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9218910E997;
	Fri, 27 Jun 2025 09:37:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HWn/kUKW";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBCCF10E997
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 09:37:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGn0Xdz3ydQLGWBQagL9GlHJlu0NQkWz29zTnqxXBU6ydvxfAOqEd6XJauLj6Cd93RQjYRmVIPWe/AocIHMRL3E3f0RCv8Zj3msTF9y+98gI0EQNoDLt8p1Rj3sOjXRkI9mCPR9otZ1NpW74jpaYNkeIzcAW7mAWBkoxn0qaUOaXj/kYCXwkO7CpOfY6XoCyotEK8mkhL0ey+G5rWXJ2ys0P3fgN846flmh5A1bRhV7ZIRA9oOK2nXshpWNj11TQuyvZd7ESOBrinW9X9OuiRqiVO1B0fAEi49C0NXQ+NzwHcHpGyULAaZyej4M6+JlH1Xoql2A2LvM7Ox1d02UzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFx3GTy/a+0fEtsKtX2o9nkZtTv+UjyGJvUJWU9t1jY=;
 b=VjcZfs9kh07dpZjBUsJXCrdULDX2jWNW5UrOrYK81xyYYioybB3hjOG2X0VVQAIx97NtyvWX9TfthauJ5u2SSs6ojGfnvSy5z22R3pUvutXEQ528is0cOujS3v5ZmHARZiDcucnrOZwfoPRjwuidMHiTtVhH0pN/DyV7EW+8F8B5saEO105yxz6pO0belmPfXa5+Qprv/8UH31l/bob2BTTs10WlXVri5TWAHlWJW5Z8hAwXgWvcR+CZZr7DIJ9ZVvRUPaRCTLAt5IHtqd+47krOqHTR12dn96/6mzFYg8KJOGl74ryewpLaIWUethmxa0BrR0UVZRh5rSr39S5X3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFx3GTy/a+0fEtsKtX2o9nkZtTv+UjyGJvUJWU9t1jY=;
 b=HWn/kUKW8pbnT2li9n3UIGODZG/oDVwyN5CGSMFqjfIdaFSwvEmgEilNEEULgzdvFhfUUAdr3hQXsVAhsIcHZsSgljoGdmLUAHWukHEQOkLh9EZWDCrpSUkjQ6ya6eE9z0awOdsEi6b+9DrkOrWj0R6HPLyVvoRzg/KwzpsM4fk=
Received: from PH0PR07CA0067.namprd07.prod.outlook.com (2603:10b6:510:f::12)
 by IA1PR12MB8555.namprd12.prod.outlook.com (2603:10b6:208:44f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Fri, 27 Jun
 2025 09:37:51 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::c0) by PH0PR07CA0067.outlook.office365.com
 (2603:10b6:510:f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Fri,
 27 Jun 2025 09:37:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 09:37:50 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Jun 2025 04:37:49 -0500
From: ganglxie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, ganglxie <ganglxie@amd.com>
Subject: [PATCH] drm/amdgpu: refine ras error injection when eeprom
 initialization failed
Date: Fri, 27 Jun 2025 17:36:31 +0800
Message-ID: <20250627093631.252367-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|IA1PR12MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d5f0d44-5009-4528-fc54-08ddb55e48bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rZgNujM+mxsH+6eD429bFJUdzfsGEto0vnhabWbCDi/rnOI0LE/cqzm0A20T?=
 =?us-ascii?Q?7kQdwC9VmrQT+LZvBZBjUeBFviefBkKySplTalabXPWCiyRMZh1EWPQWOIqo?=
 =?us-ascii?Q?L6pwaDPFtNDGs/EZjCJXz5b9lh6tCV8REV8GfW0dnu814QNe9Wv6xK1F8Uil?=
 =?us-ascii?Q?j1mQjSRk7VkII5kIlGkK24296EdoQ6tBzx8OV+K2dgIOTaTWfPlp7zF1m5Kg?=
 =?us-ascii?Q?08//QYAynDErMN8SNvKpxe6qZOgIsWD4DOgs9OVVPRwzTWmq7oPv/tmViaZ1?=
 =?us-ascii?Q?v0OuVxyAUQwb90PV4ZEqw4n2omLkhWHnqHfYNMOrGPMUBCs5MvFMZ/p/EWQ8?=
 =?us-ascii?Q?+gUS9V8bfwMGghYKyjH2jam9e7MBc0y4+atXtBa7tTa+4VDMp+cXkX75aTmU?=
 =?us-ascii?Q?M/VzdT7vnRMUmMQI7Z6m6ac/Vx+hqZ0/gJ92/xoAcTJNwBC4njq3kkHzz/JU?=
 =?us-ascii?Q?TTN3oUNe0eksTXtMa40ejiO7r9MxbC12A08H9VBXJTHPLvAoqAsS6lMiH89I?=
 =?us-ascii?Q?TPpZA+a0HO0gBUYxg38d9Ller6l8xWsC+zJ8WM8Rujbco0AJ38qj5BtWGKQ+?=
 =?us-ascii?Q?xCn9yWEIb7mh4tERqQZ9EX5RgAbAyihwf9k71bfmQqWZaUgTj4VpkW3FWGi4?=
 =?us-ascii?Q?yM/eRGKv/N9BsprCKlr3JbDLt5KwrSz3Kqx349FBoNu8TseeV7Pub9QN4PBs?=
 =?us-ascii?Q?ebEPlqmpUPajXe50tb/wr1sY/ZZwDPJ6rXF6Y3S+VProLaeNUPV7SOQ+l48V?=
 =?us-ascii?Q?lAnh1atzYhlEXpL8EIdJbH/m5gDWqNjZjdQNGURG/bXy7pEbDc1PK3tdTUkN?=
 =?us-ascii?Q?s0+5ftCceC/R+aDUnIMEit1cicc3eCj5lIAvm8m1+0FBSYX8CpVpX43R0+V+?=
 =?us-ascii?Q?IhOxi7k5RymvMhQNY5IhK+XFrSe3j3mtW2SbwFvScWuxcwR2MRASHU3Wv+e9?=
 =?us-ascii?Q?tY38sxme7U/uPd4fafI+h6gMhVbFI34LQBnStRuRLAvQVGhYXm+lkehsOlHF?=
 =?us-ascii?Q?+Cp5mDCTiMpgwebFnBpldd/gp9WCas3XGexDZHrAzfYKRRpftt6NGIEMkXUy?=
 =?us-ascii?Q?6We5Kj/PJfSmCdKdBMI+pMUXvymtXKLPZiAFYAxMg+4EjVtTw49xcXiv558F?=
 =?us-ascii?Q?9BDgQFC5GZEoF8o/tbjL3Zrr6Q1B3fxyID6m5KXBqq/raP0ZN0KEmB+dVbvF?=
 =?us-ascii?Q?FqPlEm2+tSQtE+OItRkYV47Yz/BNL56VeyuVXLyMe9g0GrAFX2LxJXPnwtw/?=
 =?us-ascii?Q?rzla2aF+N4X7gZxzMiCNhof1+IpMAJSBkIbtL1KOclRc/hdpAwjWt0YN/Wo4?=
 =?us-ascii?Q?e0FXxGr9qWh7uXdnIxkuNP7uQL058qamRiwJp3++wtG+lU5crKa86yEzgX2A?=
 =?us-ascii?Q?oFRtmgW5LXYdYggMYDI5MEtrVJAUH0MrztJGRypCOUmUk/R/iXrEZkdGYQyY?=
 =?us-ascii?Q?lMfwNZpkwOG3FfuzseAi7mPDestdiBCJA9FrHBYo0YXGCkS2hoU8V9xHNull?=
 =?us-ascii?Q?m7ClLe+Xj8XYxZUbG9+/X7/vo1xFrCeV5W2c?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 09:37:50.7563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5f0d44-5009-4528-fc54-08ddb55e48bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8555
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

when eeprom initialization failed, we still support ras error injection,
and reserve bad pages, but do not save bad pages to eeprom

Signed-off-by: ganglxie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 22 ++++++++++++++-----
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 ++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 514b56e5d8ba..d24567787f9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3009,6 +3009,15 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
 		return 0;
 	}
 
+	if (!con->eeprom_control.is_eeprom_valid) {
+		dev_err(adev->dev,
+			"Failed to save EEPROM table data because of EEPROM data corruption!");
+		if (new_cnt)
+			*new_cnt = 0;
+
+		return 0;
+	}
+
 	mutex_lock(&con->recovery_lock);
 	control = &con->eeprom_control;
 	data = con->eh_data;
@@ -3502,8 +3511,7 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 
 	control = &con->eeprom_control;
 	ret = amdgpu_ras_eeprom_init(control);
-	if (ret)
-		return ret;
+	control->is_eeprom_valid = !ret;
 
 	if (!adev->umc.ras || !adev->umc.ras->convert_ras_err_addr)
 		control->ras_num_pa_recs = control->ras_num_recs;
@@ -3512,10 +3520,12 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 	    adev->umc.ras->get_retire_flip_bits)
 		adev->umc.ras->get_retire_flip_bits(adev);
 
-	if (control->ras_num_recs) {
+	if (control->ras_num_recs && control->is_eeprom_valid) {
 		ret = amdgpu_ras_load_bad_pages(adev);
-		if (ret)
-			return ret;
+		if (ret) {
+			control->is_eeprom_valid = false;
+			return 0;
+		}
 
 		amdgpu_dpm_send_hbm_bad_pages_num(
 			adev, control->ras_num_bad_pages);
@@ -3534,7 +3544,7 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 					dev_warn(adev->dev, "Failed to format RAS EEPROM data in V3 version!\n");
 	}
 
-	return ret;
+	return 0;
 }
 
 int amdgpu_ras_recovery_init(struct amdgpu_device *adev, bool init_bp_info)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index ec6d7ea37ad0..35c69ac3dbeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -114,6 +114,8 @@ struct amdgpu_ras_eeprom_control {
 	/* Record channel info which occurred bad pages
 	 */
 	u32 bad_channel_bitmap;
+
+	bool is_eeprom_valid;
 };
 
 /*
-- 
2.34.1

