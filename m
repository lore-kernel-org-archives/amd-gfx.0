Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CC7C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:33:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47E8864EB9
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E8864EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B0BA6E090;
	Thu, 18 Mar 2021 04:33:50 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D5B46E880
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 04:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amDJPyTdAhTvQZ0ac25aPSz3ubnW6CopBRrrxQOlp9cp1iWcTvPp7xqo7fMrKohFj5AUg4k/N42cg5tH1yQAHWVB9CJpthphvjfFRt9R73lw2omKV/6V7EKTI1MB0C+LTVS8YvKj8Rc0rvLkGE+VCmCb5uxX7GCveCADwI3mVt67svlh9AaySR/VcMWB1XvIr4h1s0w6G1sT+WzXJHzB5b4TCYap2KWz/edMKvSyyxpwHTwBlOUC8ZE6S5ZVStlbfgYXoJAmtKzCCRhi0ri+Kh2IGJ69kReAp7hz7+ZWqHpvlWLe8fN6hFsY6tTHbSMRaU0AmxUhVr2b+je/yDZznA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0C8N7oq/w6xnyLS9PTuQAJvKTuGU7ZhCIfbvMpCfUtI=;
 b=nRuAVcCSp8lmrx9RS+NoIyOlaTF9O0ESIsw1ctUh8ys9dhoSmnNcqNjW6NR8RZmzDxlp2MifbDe3nnmd3VVriL9gNp3moPOMDlAeihwL7uzgjOhGXedaPLb1777CF+XaDwLDqEK9loSD1TEkqKjWt40KPk711St4NDKUoEPemJFLue5PgeAC6eXZwGvYd/W79NtH91XRTvVlHGLOM4LUDsY7XgHTkr/vnTkArfy1Y13psvA2LNloHRUGOjMyxy+Yiwq9Mg0emGOFMPPsn8m6IMRaj4PItHChiiFn9lIXnSeRHM54p8rPRbWOwxmTfDt/V78AsUdyJ7mx6ddCjIhFYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0C8N7oq/w6xnyLS9PTuQAJvKTuGU7ZhCIfbvMpCfUtI=;
 b=V6qRnes/4JEQ5p1WImhS7L2EsEFgVoLcD1ATYx8sY54esrriCiwI5Qkz9smkZGC8qj416t//NBA1QOeRRWU9k0XuC4Yyp3horQCTlKrT1Lgl5DJ9BOikRBFHQy+Crx6xGLxTDSzuTAadGLCyfZcPn7I5lttIqChbQkdS3hb1xrk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4016.namprd12.prod.outlook.com (2603:10b6:208:16b::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 04:33:43 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.033; Thu, 18 Mar 2021
 04:33:43 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/13] drm/amdgpu: disentangle HG systems from vgaswitcheroo
Date: Thu, 18 Mar 2021 00:33:13 -0400
Message-Id: <20210318043323.3989-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210318043323.3989-1-alexander.deucher@amd.com>
References: <20210318043323.3989-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: MN2PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:208:23a::29) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 MN2PR03CA0024.namprd03.prod.outlook.com (2603:10b6:208:23a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Thu, 18 Mar 2021 04:33:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9830b7c3-a98b-4f7d-d51c-08d8e9c70314
X-MS-TrafficTypeDiagnostic: MN2PR12MB4016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4016F907232270FDCE8AC91AF7699@MN2PR12MB4016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vavHdwNqDARjQLNcq9NBwXHFrkoyJczkx3gv9sXxLzf71H1YyGtua4eBA+nfhkBh+G2SEULqYWksmqKuUkY8EmObsDmO75LrksyPlmfvyLHn5/wx11n8ip2s8jLY5WO1Ka8UTIwta0q5cIqP/+V0ViwtD+EqN5U6wTfs50ictUp9JsfkrsAtfB+duuN/s1bKo7W2R+1k/QQY+kzPmdWtLLIhBbYJ+BPhlSWGum+swTXOHzynkG4jAnupflkyCUgyDAerp4aTG+DOZT+1YTI0VOv2DbkfoV3uUH3BSpSOOrMNwrrySu1hCVeuGvYOn/spCL8VGP3JIgYgEYwYuU8qM+LVdG2um+kIfk1ekyEcrvH+mLS6XVqfWDvCEMznqxF7/rQYU5IA60rAC58c1PoXb56ia9ynVwNDTpn4DNDmDV3L2Hi1Fe6rurWcFXP5aykUoFsR64/4oACtxNR7nES4Yd5NiRCA9TrmJ+KYa0U0ZDX1Gx9uTGLiAzj255O5mxrCDoq2rQMPYqhVoBMFd+XYaHAq+iR6W/0IiewpX3r+7iyFtJioibXqiGDnMBcPxQDJbMsjwuSC5WEYSJtqNxtfNDsx2ZK7VZmt/tDRk/NpkqoLeCydY5w772a168Fey9EyiL5ar8V8WtUQqCoyQ4xISA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(316002)(5660300002)(52116002)(1076003)(83380400001)(8676002)(66946007)(478600001)(38100700001)(86362001)(8936002)(16526019)(69590400012)(4326008)(6506007)(6666004)(186003)(36756003)(66556008)(66476007)(2906002)(6486002)(956004)(26005)(2616005)(6916009)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Av4nrUXRd1n2olugp1QE2jH3PnAWjDBToN18PapZ4FaO3FJri32bkkGoR3h4?=
 =?us-ascii?Q?sI2ai3yM/Qcd+26okfn6O3pZQrsZfUhLkIUmRnmH3e7G7b2GmZ5ZBBRb4Vym?=
 =?us-ascii?Q?dtzV3jCFNQ/LOhihn3DsLXJl21AKxKZzzQzXNzyfpfnl3c6nP9GsjxUDsUff?=
 =?us-ascii?Q?1eH0WtTNVtamXEzVlJZp57E88dyyLWRnJQ17m2Ak8ElwoBJk3EvryexLMHxE?=
 =?us-ascii?Q?83YxJ3DqbY00maGZVsehn5fnF2Lt81vYg5iLNKoY62/y0Xk4lOo583ssq+LJ?=
 =?us-ascii?Q?1s92nxRXa75gPOfTg9dqJGBWQj2skQsJ5ATRtEypNCzvEdSrFcRbH3Q/+eSB?=
 =?us-ascii?Q?uQOUfxsV0BBzBCDsv40CTdzNGs00mnBk95s46++HSXoXmDiP6lEoNJ2QyJjd?=
 =?us-ascii?Q?xkV2YKffyXds8GikSBeRljfFhh3yeODl0HiSBdFx8o+XK+8dVfAFAVM8BMBt?=
 =?us-ascii?Q?5ooIy0x/6+BABPIdgJ5r3DPgIo5B+9Psd/GZGjvctB21z5w7CXDdjdo26F9m?=
 =?us-ascii?Q?rhiHLuz2s4ASQTl0xhK3zpUkEKPt9tDT+cMlwHj5bKcLfeyihbfuqUo+0UOU?=
 =?us-ascii?Q?j23GTXmfbst0lOt5dFF3eGq+Q9myW8nDVL7vnzokWKjwTd+TgOkZrUj4mAIN?=
 =?us-ascii?Q?3NZPnHPr/Oc8rcUI4/J7X8HhAtSiP6Ffv15PbOaoqisrwz9uSAHF4c/8xhFv?=
 =?us-ascii?Q?TdPv/ufo1BI/LcANQf548JyYe+LSUpetvWQti1MqEfPclJyD7f8v8ymsimfd?=
 =?us-ascii?Q?rcU+x4Xt99PQ1rUbm1kl+Kz2aPR92bcA/JWp8kPhSY0vZNDVULB0YRqSsw1z?=
 =?us-ascii?Q?xSTJ2yDYN0Gr4fg//Nxt1TnnfDCdbJI1DxRS6dnXW2hq5FiklP5Diebz0JZZ?=
 =?us-ascii?Q?ZuZ6zxrAOCohNgs+9l2sDpaWdlTPQOc2r+kE+cfL8Y6+OSSSMZrJLHVlluDH?=
 =?us-ascii?Q?cW/CstpA8F9VCO0q2bYqhIqtJq063WXPvIT87+iZjkDIW+KdA1DHuXzA/Q4Y?=
 =?us-ascii?Q?DJnlhMqWhjWFtGmOJNF9HUiU4uscgtD4M1I+q1tu54naO/bFLHZrSDmAKpO8?=
 =?us-ascii?Q?e5C3ZM2zDTRUdOAbQ6FIbMg4IkoIgxFI3fZ+2qzRCWXFn1DYfwYoRDE6E7jE?=
 =?us-ascii?Q?AtADCv35eAKDfeLUr10OPhMnrwpo7CKQn9PYVMuzvwenC9jq4fclYTpNLjmJ?=
 =?us-ascii?Q?OJCxGSMP0to4JJtVwhn958+u9XHDNGlj09U4z0XNSCcgGEVz7m72buo2T6xz?=
 =?us-ascii?Q?uaSaC0xCyfMSFHEv9YcOVXj84dd2HSFoMl+6sLJ8KV7V0efLgPxGby3Azyvq?=
 =?us-ascii?Q?UEiFd+ue7/SuLgBt7FBMAqEq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9830b7c3-a98b-4f7d-d51c-08d8e9c70314
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 04:33:43.4765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9uksK+gP4E8XbxOHGvVX3z2UKYCHXZLA9Vfzy//5mQ9P2kFgQNSpYuZADw0msXOkS7+HkSj7CIPrHDKyvV95pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4016
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There's no need to keep vgaswitcheroo around for HG
systems.  They don't use muxes and their power control
is handled via ACPI.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 38 +++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 34 ++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  9 ++---
 4 files changed, 35 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index efe6b5ca5185..569c85419f76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1275,8 +1275,9 @@ void amdgpu_device_program_register_sequence(struct amdgpu_device *adev,
 					     const u32 *registers,
 					     const u32 array_size);
 
-bool amdgpu_device_supports_atpx(struct drm_device *dev);
 int amdgpu_device_mode1_reset(struct amdgpu_device *adev);
+bool amdgpu_device_supports_atpx(struct drm_device *dev);
+bool amdgpu_device_supports_px(struct drm_device *dev);
 bool amdgpu_device_supports_boco(struct drm_device *dev);
 bool amdgpu_device_supports_baco(struct drm_device *dev);
 bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0f82c5d21237..a984ba6634fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -212,18 +212,18 @@ static DEVICE_ATTR(serial_number, S_IRUGO,
 		amdgpu_device_get_serial_number, NULL);
 
 /**
- * amdgpu_device_supports_atpx - Is the device a dGPU with HG/PX power control
+ * amdgpu_device_supports_px - Is the device a dGPU with ATPX power control
  *
  * @dev: drm_device pointer
  *
- * Returns true if the device is a dGPU with HG/PX power control,
+ * Returns true if the device is a dGPU with ATPX power control,
  * otherwise return false.
  */
-bool amdgpu_device_supports_atpx(struct drm_device *dev)
+bool amdgpu_device_supports_px(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
-	if (adev->flags & AMD_IS_PX)
+	if ((adev->flags & AMD_IS_PX) && !amdgpu_is_atpx_hybrid())
 		return true;
 	return false;
 }
@@ -233,14 +233,15 @@ bool amdgpu_device_supports_atpx(struct drm_device *dev)
  *
  * @dev: drm_device pointer
  *
- * Returns true if the device is a dGPU with HG/PX power control,
+ * Returns true if the device is a dGPU with ACPI power control,
  * otherwise return false.
  */
 bool amdgpu_device_supports_boco(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
-	if (adev->has_pr3)
+	if (adev->has_pr3 ||
+	    ((adev->flags & AMD_IS_PX) && amdgpu_is_atpx_hybrid()))
 		return true;
 	return false;
 }
@@ -1391,7 +1392,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	int r;
 
-	if (amdgpu_device_supports_atpx(dev) && state == VGA_SWITCHEROO_OFF)
+	if (amdgpu_device_supports_px(dev) && state == VGA_SWITCHEROO_OFF)
 		return;
 
 	if (state == VGA_SWITCHEROO_ON) {
@@ -3197,7 +3198,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	struct drm_device *ddev = adev_to_drm(adev);
 	struct pci_dev *pdev = adev->pdev;
 	int r, i;
-	bool atpx = false;
+	bool px = false;
 	u32 max_MBps;
 
 	adev->shutdown = false;
@@ -3359,16 +3360,12 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_register(adev->pdev, adev, NULL, amdgpu_device_vga_set_decode);
 
-	if (amdgpu_device_supports_atpx(ddev))
-		atpx = true;
-	if (amdgpu_has_atpx() &&
-	    (amdgpu_is_atpx_hybrid() ||
-	     amdgpu_has_atpx_dgpu_power_cntl()) &&
-	    !pci_is_thunderbolt_attached(adev->pdev))
+	if (amdgpu_device_supports_px(ddev)) {
+		px = true;
 		vga_switcheroo_register_client(adev->pdev,
-					       &amdgpu_switcheroo_ops, atpx);
-	if (atpx)
+					       &amdgpu_switcheroo_ops, px);
 		vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
+	}
 
 	if (amdgpu_emu_mode == 1) {
 		/* post the asic on emulation mode */
@@ -3575,7 +3572,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 failed:
 	amdgpu_vf_error_trans_all(adev);
-	if (atpx)
+	if (px)
 		vga_switcheroo_fini_domain_pm_ops(adev->dev);
 
 failed_unmap:
@@ -3635,13 +3632,10 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 
 	kfree(adev->bios);
 	adev->bios = NULL;
-	if (amdgpu_has_atpx() &&
-	    (amdgpu_is_atpx_hybrid() ||
-	     amdgpu_has_atpx_dgpu_power_cntl()) &&
-	    !pci_is_thunderbolt_attached(adev->pdev))
+	if (amdgpu_device_supports_px(adev_to_drm(adev))) {
 		vga_switcheroo_unregister_client(adev->pdev);
-	if (amdgpu_device_supports_atpx(adev_to_drm(adev)))
 		vga_switcheroo_fini_domain_pm_ops(adev->dev);
+	}
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_register(adev->pdev, NULL, NULL, NULL);
 	iounmap(adev->rmmio);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 60fba0454368..cfa73ff292d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1410,9 +1410,7 @@ static int amdgpu_pmops_prepare(struct device *dev)
 	/* Return a positive number here so
 	 * DPM_FLAG_SMART_SUSPEND works properly
 	 */
-	if ((amdgpu_device_supports_atpx(drm_dev) &&
-	    amdgpu_is_atpx_hybrid()) ||
-	    amdgpu_device_supports_boco(drm_dev))
+	if (amdgpu_device_supports_boco(drm_dev))
 		return pm_runtime_suspended(dev) &&
 			pm_suspend_via_firmware();
 
@@ -1501,7 +1499,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	}
 
 	adev->in_runpm = true;
-	if (amdgpu_device_supports_atpx(drm_dev))
+	if (amdgpu_device_supports_px(drm_dev))
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
 	ret = amdgpu_device_suspend(drm_dev, false);
@@ -1510,16 +1508,14 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		return ret;
 	}
 
-	if (amdgpu_device_supports_atpx(drm_dev)) {
+	if (amdgpu_device_supports_px(drm_dev)) {
 		/* Only need to handle PCI state in the driver for ATPX
 		 * PCI core handles it for _PR3.
 		 */
-		if (!amdgpu_is_atpx_hybrid()) {
-			amdgpu_device_cache_pci_state(pdev);
-			pci_disable_device(pdev);
-			pci_ignore_hotplug(pdev);
-			pci_set_power_state(pdev, PCI_D3cold);
-		}
+		amdgpu_device_cache_pci_state(pdev);
+		pci_disable_device(pdev);
+		pci_ignore_hotplug(pdev);
+		pci_set_power_state(pdev, PCI_D3cold);
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_DYNAMIC_OFF;
 	} else if (amdgpu_device_supports_baco(drm_dev)) {
 		amdgpu_device_baco_enter(drm_dev);
@@ -1538,19 +1534,17 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 	if (!adev->runpm)
 		return -EINVAL;
 
-	if (amdgpu_device_supports_atpx(drm_dev)) {
+	if (amdgpu_device_supports_px(drm_dev)) {
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
 		/* Only need to handle PCI state in the driver for ATPX
 		 * PCI core handles it for _PR3.
 		 */
-		if (!amdgpu_is_atpx_hybrid()) {
-			pci_set_power_state(pdev, PCI_D0);
-			amdgpu_device_load_pci_state(pdev);
-			ret = pci_enable_device(pdev);
-			if (ret)
-				return ret;
-		}
+		pci_set_power_state(pdev, PCI_D0);
+		amdgpu_device_load_pci_state(pdev);
+		ret = pci_enable_device(pdev);
+		if (ret)
+			return ret;
 		pci_set_master(pdev);
 	} else if (amdgpu_device_supports_boco(drm_dev)) {
 		/* Only need to handle PCI state in the driver for ATPX
@@ -1561,7 +1555,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 		amdgpu_device_baco_exit(drm_dev);
 	}
 	ret = amdgpu_device_resume(drm_dev, false);
-	if (amdgpu_device_supports_atpx(drm_dev))
+	if (amdgpu_device_supports_px(drm_dev))
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
 	adev->in_runpm = false;
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 8e6ef4d8b7ee..86eeeb4f3513 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -161,7 +161,7 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 		goto out;
 	}
 
-	if (amdgpu_device_supports_atpx(dev) &&
+	if (amdgpu_device_supports_px(dev) &&
 	    (amdgpu_runtime_pm != 0)) { /* enable runpm by default for atpx */
 		adev->runpm = true;
 		dev_info(adev->dev, "Using ATPX for runtime pm\n");
@@ -202,13 +202,10 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 
 	if (adev->runpm) {
 		/* only need to skip on ATPX */
-		if (amdgpu_device_supports_atpx(dev) &&
-		    !amdgpu_is_atpx_hybrid())
+		if (amdgpu_device_supports_px(dev))
 			dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
 		/* we want direct complete for BOCO */
-		if ((amdgpu_device_supports_atpx(dev) &&
-		    amdgpu_is_atpx_hybrid()) ||
-		    amdgpu_device_supports_boco(dev))
+		if (amdgpu_device_supports_boco(dev))
 			dev_pm_set_driver_flags(dev->dev, DPM_FLAG_SMART_PREPARE |
 						DPM_FLAG_SMART_SUSPEND |
 						DPM_FLAG_MAY_SKIP_RESUME);
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
