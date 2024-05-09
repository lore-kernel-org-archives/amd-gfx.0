Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30586C10F1A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 17:05:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31A9D10E062;
	Thu,  9 May 2024 17:05:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yfrqD9oT";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 080DF10E062
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 17:05:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hECyXx0k24upaZXWlnQ7jlHFg+67Q1/VVcAXthzt3sUVod4bS6f4viwVdRr/hTOu5WiAREVMa7YQzoHquabcyymIjuBUXiQgDeiTavORRlepExCTu7VZoPWT/eogm23NxplZl9/lRTknVIcPzcmrqcwLb5PP2RH4rlX8WAFf7c0Ql7ZbpCIhNzL8v0Nkz+oqfsrBT37XKGa7RqBt1Xs5kOyiBU4EH8ssbsugCKBB4Muhb2CEvYjH3TkKjHJwDDGo2FEK0VsyPc/ITV6h4TxsiY0EpHDImuwlGNLUF4op7FmpOirF5UpxD9JLaot77n7yFoFNnYstC0/O/sd6hFofWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqnuDB63ltMYTv+mJAZn/9I4AdbcOD0DJe/s+23sHM0=;
 b=J+gD+cZHx+J7Fcw9uhBgu6WX6u/i85QtoP12XNFACmC42eHuujicbgH2VIsEaGB1AUcdI1iC/E0bQLtPESMeN887UCkm6okA8ad/jOGMprcaMle9HdEbbrSv7WKUgyYlMbBQYOIn4V3uIAJvB6WHAW/HdkSGKGlYBcHgTrAtNjwuzZrSRNOwyvpbEztq+WLN6MseiKonss9X7w8bLqjO8OhDc6DljEMYNp8RT4s6LXZI+fepVU/693y6l7iRgM9xxWpMEz8d5hpTxw0sPQ9t5H+d3gtn4bX5/YpGbYNSqjLkGRHqmnUgtksTjsD+hwkQA2nqzfxZsS/2nS2w1CLb4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqnuDB63ltMYTv+mJAZn/9I4AdbcOD0DJe/s+23sHM0=;
 b=yfrqD9oTM+G0449CYC04N6Jy/mzu9Urko4HvHpC2LeqApAgirUnQY3tZx9UD/ZYhLWKgSevuGClFaapAVdnH5QoEOnutptlsiPmvX44ctocFiwQRGJW8053YgkiJ7z98BPokj9ZzGj1xoroYNC5bFk/V1JOZhupiE/nnVip7BiU=
Received: from MN2PR10CA0018.namprd10.prod.outlook.com (2603:10b6:208:120::31)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Thu, 9 May
 2024 17:05:37 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:120:cafe::f5) by MN2PR10CA0018.outlook.office365.com
 (2603:10b6:208:120::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48 via Frontend
 Transport; Thu, 9 May 2024 17:05:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 17:05:36 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 12:05:35 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH] drm/amd/display: Don't register panel_power_savings on OLED
 panels
Date: Thu, 9 May 2024 12:05:24 -0500
Message-ID: <20240509170524.34811-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|MN2PR12MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: 4435e0b1-8cc9-4444-8eca-08dc704a3ea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+E60rcRwWRSxVaEIy21M3+ODVTcduV5jbxRcviv4h7yrntnUB8EwnfkcY9+D?=
 =?us-ascii?Q?ur951YWS30bxHKGLkxC33NjRlOaeYDdalhjbQDmn/rEZHSFL/DylKLPPJ1TK?=
 =?us-ascii?Q?7vj4fnt0Ywh8NZ4WupJpIUxsbX7vSfoTsPm3iagxZ6z8G5OMXv5fBbbWdn3k?=
 =?us-ascii?Q?xDCnkysWFkAgM+6fQI01NS1aGNsWTH6dwc/zJHWGXW62NLlqQQxYcJL2zOXj?=
 =?us-ascii?Q?mLKPJbT9/H0F10emIw1Hc30SJyjQXHddJoz2PyJQqzEgRMl0vO5a4c0wqKuV?=
 =?us-ascii?Q?eHdYEejEKhuHZmrCnzLyO/b5K/RPRlE90Q+4R+cKV5VUbXfUQ/E6G63nKk4p?=
 =?us-ascii?Q?Z7gkcV1VtDXlwfDuEK3O78jUxzEZdgvt+6Qf2nwDBGYNv5x9qHsk8gPz3J1B?=
 =?us-ascii?Q?Ak1ksVWfVE2qVWPGncWpjgheseJ81Opda6hqJBdj6gJrypVxXzkPrqB/goPz?=
 =?us-ascii?Q?dkA8UWdp034jz3KYSbx0kUnRSBSRLJJcJQz3+WfaXqrwhfyVbO3sM8YCCXcd?=
 =?us-ascii?Q?z64HWCt6DT75IQSy6F6QA066WCwXdO8RzBOMwVBWJDpoIkmm5ySF5EAPmmVB?=
 =?us-ascii?Q?DHiMtAmWKWHBHR2wy0mhodmbp5qq/aHzf8UcQ2cB2D8fl68osON+EbaHEkS5?=
 =?us-ascii?Q?+5yh3v52cNMBo5sh/B75HErMOeLU5ci+w0xzCJ67/4FbFw8wL52Gh/V9w/W6?=
 =?us-ascii?Q?dul89Ogv3dMknAlgdJ7f7bEif+hvRD4QO9SE4O+it68gAuoJoiAN7Uxd/wxt?=
 =?us-ascii?Q?JCGoll0Y4Ou62kzR6gtwIFImoV7daYvJlmsg7gXGDbtf0brKQ6B655hILUpu?=
 =?us-ascii?Q?th8HgS7Fi2vt6w+ewuyTasfW0EmCJkDXcOWhWxA3WoQ8QfU2ltT9KNRZjsWN?=
 =?us-ascii?Q?mxhkICMwZvjMGyJ3kTK0/9ZpuVSNBxXtkynfXHRrkWknNuvsuP4KFdkp5bfn?=
 =?us-ascii?Q?/fZmw9AvT0uqlrb/2k7/SrbHqXnhr60TDKtnJWeNAQrCkBxr2l991UeKn38Q?=
 =?us-ascii?Q?ytBkPhZ6g7NH1Q1JeuAAeFVSM42c8DTWL7m+e6lwunQAorTBdoRgFnpkYWVa?=
 =?us-ascii?Q?gGqodTiKc9taYIDrTsBHptLQYeN8VwyafwrHMSfoVA3ORV7VX1oVbKHZ8LRg?=
 =?us-ascii?Q?MUWab+8XXDr8wdUSL9xiLJHuxmzPIPZ+Zav7YQDHlwtR2W/MGM8sW4DhxR8G?=
 =?us-ascii?Q?Wnfpa8P4RXrrjp7bAqa7B/Joplp8vLDYWlEQLR2DtRMDenLxtHsEE2Tx6pv3?=
 =?us-ascii?Q?bYtWm9VB+vCwcpcajKE2KmZSUHxPSfv6AYl/lX8Y/Ci2l2UlZoXIaZ27EnTh?=
 =?us-ascii?Q?Nm4UUQ9Eyy+u8zWMfDteCXQr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 17:05:36.0580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4435e0b1-8cc9-4444-8eca-08dc704a3ea8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333
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

OLED panels don't support the ABM, they shouldn't offer the
panel_power_savings attribute to the user. Check whether aux BL
control support was enabled to decide whether to offer it.

Reported-by: Gergo Koteles <soyer@irl.hu>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3359
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 29 ++++++++++++++++---
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3054bf79fc99..ce2ec857b8a6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6532,12 +6532,34 @@ static const struct attribute_group amdgpu_group = {
 	.attrs = amdgpu_attrs
 };
 
+static bool
+amdgpu_dm_should_create_sysfs(struct amdgpu_dm_connector *amdgpu_dm_connector)
+{
+	if (amdgpu_dm_abm_level >= 0)
+		return false;
+
+	if (amdgpu_dm_connector->base.connector_type != DRM_MODE_CONNECTOR_eDP)
+		return false;
+
+	/* check for OLED panels */
+	if (amdgpu_dm_connector->bl_idx >= 0) {
+		struct drm_device *drm = amdgpu_dm_connector->base.dev;
+		struct amdgpu_display_manager *dm = &drm_to_adev(drm)->dm;
+		struct amdgpu_dm_backlight_caps *caps;
+
+		caps = &dm->backlight_caps[amdgpu_dm_connector->bl_idx];
+		if (caps->aux_support)
+			return false;
+	}
+
+	return true;
+}
+
 static void amdgpu_dm_connector_unregister(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
 
-	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP &&
-	    amdgpu_dm_abm_level < 0)
+	if (amdgpu_dm_should_create_sysfs(amdgpu_dm_connector))
 		sysfs_remove_group(&connector->kdev->kobj, &amdgpu_group);
 
 	drm_dp_aux_unregister(&amdgpu_dm_connector->dm_dp_aux.aux);
@@ -6644,8 +6666,7 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
 		to_amdgpu_dm_connector(connector);
 	int r;
 
-	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP &&
-	    amdgpu_dm_abm_level < 0) {
+	if (amdgpu_dm_should_create_sysfs(amdgpu_dm_connector)) {
 		r = sysfs_create_group(&connector->kdev->kobj,
 				       &amdgpu_group);
 		if (r)
-- 
2.43.0

