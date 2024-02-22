Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C77C5478C
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Feb 2024 10:17:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77CAF10E7DE;
	Thu, 22 Feb 2024 10:17:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SRFPpWVp";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A621910E7DE
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Feb 2024 10:17:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUrmK2ViTswdXYCFXA0SUqvBqpth7dZnBa4B4GsMG/K5IWTzh46+mXdmWp1EONxAWXMkbX2MEXONMjk+qMzSz9WbgMhJm+qg1xrcDBm6S4co/K9u3odTbaDqVvdsgX/EFy3/O7CC8xLmQk2HEOudro5BL67gMnQq0qJ+htSq6RTwdxwuiRsw96ZyF0ufwFU7bCKmoJZK1pXhhaz5AaH22A3Te0WiOQlvb7o7/Gi49qF2oVdk9bhrdwpT5PYXJK0YnbUbooNBA7o/fQObQlclfUKXl8VzRIsYe9gp/3srvpTKbF3DkiaKJamwWkeh3z65d81k8hP7FT+j9ZJgPhalAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuVWWWhM30EtZyE4hPEq/FPWnW7gqJmxdlXQAQxBXAI=;
 b=e0HIrz15hfcMCPd6Fl0zzW0ls4ruiz0qY54gE8jKL26uFHBrJdTybIRHcdAGQPlj+SunnG8C+UO7/Uo5YrLdapXJw4qQ7sSEQLkvuCMEE9kKsfqHwqZ1kRwzd0hKmycEUWvwERwK1kTm9X9VPvsj35+z4WMxPs/cOj05DGWVljC4ait+Kp97wI3MFKmM4Zdqm/eRXImWsTsZHhkVw7xCWQr6l70FvkehiVdXre0RPN0lYH4cR0ggIOf/qkjc/8cv58H70vnogE9wVDyjWaIeDYzz7S8C+0LtOQiofUc6sBVise2Udhb628cb1R+6QMda02sLutbxyoGdkAjOP/kItw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuVWWWhM30EtZyE4hPEq/FPWnW7gqJmxdlXQAQxBXAI=;
 b=SRFPpWVpMpAMxkTCKrb1BJU7C0UyiVNTzsSmPhI4uDhblZFWACFdTCP24ejD6EfIlf/gdUfbNuWl+qMfJlpUA1aNiSulQdbZXWTJPZwPNu3UKzcq9ajDIHcYLt/vbU6YMcodzPnPHylyxJHLNxZcMOeqkqp1jZKxH1g6qUKCsC8=
Received: from DM6PR11CA0033.namprd11.prod.outlook.com (2603:10b6:5:190::46)
 by DS7PR12MB5839.namprd12.prod.outlook.com (2603:10b6:8:7a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Thu, 22 Feb
 2024 10:17:46 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::20) by DM6PR11CA0033.outlook.office365.com
 (2603:10b6:5:190::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Thu, 22 Feb 2024 10:17:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 10:17:46 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 22 Feb
 2024 04:17:43 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <mukul.joshi@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add fatal error detected flag
Date: Thu, 22 Feb 2024 15:47:27 +0530
Message-ID: <20240222101728.135595-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|DS7PR12MB5839:EE_
X-MS-Office365-Filtering-Correlation-Id: b4651514-d17a-4cd8-b416-08dc338f83e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XpnM7WH+ylQTblVyXWVKFlsG+DnKAaUecGXYmGDKQ9Ayy4i5kZFlN7LHymeIqsXmH8b/fcrt/0PIys6y3Kv59746LUJMdUxgGjWViEc1HHuRweRFNSfeu+jo2oqy1IoAqDevwJosUCTk0dX32uySoCprXazXH3JOLm1F4qn+TYmGGu/lBb0fFYxpqRv1u4toRT39I++CjwtZa40TUd4qYM8N6UjLkBbePLQwLeFrLcfvdUXR0oEbvSY/yQOJjJvvGEt0JzcDgSdPODmK6+SRXJJMiL9a+m7q8V4JaNmUYhRibTntaTMHP7snyiEGPZEoMYyNvUZ5c1pxooTUjE9Tg19pYSDrp++qRAbiczQPEd110W4rolct5NHSWwVZpj8DoMgMSNCVv7lObNTVjkNCPkVrKZ3WKXLPtEG78iOsa3L+U7W286hzALXEOmw0ASXtBgYaF990/TtN/UnqUykcH4qLEfC6Cww1Lu7r21ZQKH0lxVSXC/EkJMP2jWb//9dOep84A9Tl9SyofblCMRiKK3QdN8oSlXgxTVMrHIwW8Up0cE1+hRV/hjJjd7ZOx7ktoTN1yJDiFGh+nblM8/wHRfjZjI7Hbs+HO5bvJzSMpF6ciRVrscMGU2KBdMhccTVd1rrUfMyyYouhlBomAfKQaUQzXNecrgrbpBmHzq7g6gs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(40470700004)(46966006); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 10:17:46.4867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4651514-d17a-4cd8-b416-08dc338f83e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5839
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

For a RAS error that needs a full reset to recover, set the fatal error
status. Clear the status once the device is reset.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 32 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |  6 ++++
 3 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1ef892bea488..d475c54c0a08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5308,6 +5308,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 		if (need_full_reset) {
 			/* post card */
+			amdgpu_ras_set_fed(tmp_adev, false);
 			r = amdgpu_device_asic_init(tmp_adev);
 			if (r) {
 				dev_warn(tmp_adev->dev, "asic atom init failed!");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 46f3d1013e8c..2c94de305c69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2439,6 +2439,18 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 				ras->gpu_reset_flags &= ~AMDGPU_RAS_GPU_RESET_MODE1_RESET;
 				set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 
+				/* For any RAS error that needs a full reset to
+				 * recover, set the fatal error status
+				 */
+				if (hive) {
+					list_for_each_entry(remote_adev,
+							    &hive->device_list,
+							    gmc.xgmi.head)
+						amdgpu_ras_set_fed(remote_adev,
+								   true);
+				} else {
+					amdgpu_ras_set_fed(adev, true);
+				}
 				psp_fatal_error_recovery_quirk(&adev->psp);
 			}
 		}
@@ -3440,6 +3452,26 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 	return 0;
 }
 
+bool amdgpu_ras_get_fed_status(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *ras;
+
+	ras = amdgpu_ras_get_context(adev);
+	if (!ras)
+		return false;
+
+	return atomic_read(&ras->fed);
+}
+
+void amdgpu_ras_set_fed(struct amdgpu_device *adev, bool status)
+{
+	struct amdgpu_ras *ras;
+
+	ras = amdgpu_ras_get_context(adev);
+	if (ras)
+		atomic_set(&ras->fed, !!status);
+}
+
 void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)
 {
 	if (atomic_cmpxchg(&amdgpu_ras_in_intr, 0, 1) == 0) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index d10e5bb0e52f..e0f8ce9d8440 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -477,6 +477,8 @@ struct amdgpu_ras {
 	wait_queue_head_t page_retirement_wq;
 	struct mutex page_retirement_lock;
 	atomic_t page_retirement_req_cnt;
+	/* Fatal error detected flag */
+	atomic_t fed;
 };
 
 struct ras_fs_data {
@@ -873,4 +875,8 @@ void amdgpu_ras_add_mca_err_addr(struct ras_err_info *err_info,
 
 void amdgpu_ras_del_mca_err_addr(struct ras_err_info *err_info,
 		struct ras_err_addr *mca_err_addr);
+
+void amdgpu_ras_set_fed(struct amdgpu_device *adev, bool status);
+bool amdgpu_ras_get_fed_status(struct amdgpu_device *adev);
+
 #endif
-- 
2.25.1

