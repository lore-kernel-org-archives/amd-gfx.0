Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD31C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:34:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C380A64EB9
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C380A64EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F90F6E884;
	Thu, 18 Mar 2021 04:34:00 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C0696E87D
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 04:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GT0CEKRLJ/u+ppJ/fga1RlvaSVs+5gXrdAbQU9/QlSBreREzs5fehOFlozog+xAHC/OJv0e2RX4Ubl6u65jUbJDs6kyRY0G1Ym7+f95ZHUuXr8kTff6BEZwuzaMuMF8RElbOFrcHQZ9slH10RaFJ+jWy8gyTbI2xSKMujAfGiSq+ZFu6Ppy17w0+NQ1gBACOA2DPczejgyqVxXva15rzASu1ytrcvTlfhOW681DkGM/Anwy8WAbiF5WtxxnOoDX/ywX9I/kAnKVly1Vb2S0t+q1B+qe5evV7icCCWezyYuDuRpG4mlZkiCC6s5T7bUBrFrDuQzmisgpe9grjjthX7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dxu0gHyeb4kiNNven5XJ2yGZW8l+c05gjmff15K84jc=;
 b=WILvqvwldvJN6bq20K9c59O1PI0gJKXEuWu0NDAd+PyqpYexoOJ37ZqFpyWySo1QZy4Vch7j1PJvC3DGWjbYUVzkIhPjpQFrUFH2xMm2jjEIGT2RWwTtySi2koZgfN+YtgjJw3fXnSxy9VZCyEh5ksp2cQnU1Tx0cqN337fmzcpJIXskuVbXfWdHXg29+Z02+oLzvTIbMhDE7VxzeGGOqVP48DOUieOV8FyHyxlf6jhrLkof9+XAlPLa4RAuoPVFHfmjwHsjz7JQB/FoQxva5P1kmlEj2DNWraFwhiukzW7UNk8j3tXoMWSg+kFS4oJYh/uabneTb3T85z3WLjm4sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dxu0gHyeb4kiNNven5XJ2yGZW8l+c05gjmff15K84jc=;
 b=PfbcnlaLmjRo65hENXDGnGlN20wM0Bky1Gugt7N2LLD/DexVDO7vL/4obQ3oFnwppUMolD4uzW9/il6liurUZLVjom8n/cWpPFA/AeVSXvUX7WzHT3o/aKqK/SjFonWCgd8rMN03feehQfYRmgGbD/sV6IeWjdsLfDOP9uT2iOs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4016.namprd12.prod.outlook.com (2603:10b6:208:16b::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 04:33:44 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.033; Thu, 18 Mar 2021
 04:33:44 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/13] drm/amdgpu: rework S3/S4/S0ix state handling
Date: Thu, 18 Mar 2021 00:33:14 -0400
Message-Id: <20210318043323.3989-4-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 29a53e66-46bf-4757-e210-08d8e9c7036b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4016FE6ABEB08525654FE897F7699@MN2PR12MB4016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rxchgfc4HHk0Ef6qJSflW2LAOhLkjBl183fh98rt0BRj9MY5CDd3NAVZGCyB87o/12zxZa9LAsMk2BAJSi5/IvjoZUZBj3hqDlmzn13hsi+o+XuQyr57pRklP99PCO9w6KBo5LGe6qbg6zABHayZjW2Exw16T8chnAksMydMYVA89kpt2cgewdDe0J/nXTSXE1RXuRbspGm9r3Wsy5hS0sSpOt0p2NJ5YhkUSUFpLsAIJsZCPYuyTYcXz3G6vSXMtDhFnN954ongHBfJojw4Z4Egc/ujLixBva9+ZIiClunZUHdmz+zovZttEVrjNl60ikBfTcrr3PURlKapjEk4uXVS+MYUCvMv9/bEAve/9oLQxFXqbFpTZpMCyKcOWiExPFBOKOIYcICBVbAzeuXBDcDKjW5owmEnShRz1Zc2hvQi4FkhEnbVNZ5yisMSsjf2EXBzHm0vZz2o0vQciQVOe11iZuDsV/MpnFUA3sMwpjxkHho6eXRIcbkn56Gfcxvh98eDoeGfYOa+jjETzUwZjDZ8MPd78eeURB7SLYpHWJbbyh65Va81V56VJiWDdFUK1od819S5TBJULZ5V3EtdoB9bkVQq+/tsMtevnVJWTTMMOVVp8BSfLKmlZ8XPAypty56giWs2RcQyHpXQwYVq3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(316002)(5660300002)(52116002)(1076003)(83380400001)(8676002)(66946007)(478600001)(38100700001)(86362001)(8936002)(16526019)(69590400012)(4326008)(6506007)(6666004)(186003)(36756003)(66556008)(66476007)(2906002)(6486002)(956004)(26005)(2616005)(6916009)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SxWP4/M5mF9Gc0RFAC0pNNTgH7SZqQwPgZloKmONawKIXQIrsMdgWaKmcsXN?=
 =?us-ascii?Q?cKpw35VRV96PXNcCddOsmnY8peyNEc6WoO7onwCGTSBMuJIU9cpigxj3DOvo?=
 =?us-ascii?Q?d9nS6sGJhS+z7FrzeZhP3/coYkPtZVB/vg3SiQuaRjl3NsK+rQQ8o69rDYow?=
 =?us-ascii?Q?rE1c3hlJNHDv84tQuD4SHUnMO668mkvDyEbmLAysbdROIE40lS4TUVIaE1Ah?=
 =?us-ascii?Q?rqwT5YXRULMW2yAvc6NKaJF+rn1RhTr5jW1fNlweQGWTWxyeqCw5GU1zuctV?=
 =?us-ascii?Q?etPA8V3lOmyCr/2xM14zU8Y96QOCfknH2OT9EdPINUuTrlxJa0yCr42qDIx6?=
 =?us-ascii?Q?4e0wwU9UQxvJrNl6xTYpnw+w3FkN6aM9XAQ4hf9vI9NIVxjEO/e5AySmogb2?=
 =?us-ascii?Q?XhDnIBJihAftoY1aAA/h1y3IyTo4JDrsBD+18ZvSqOFdgCAjvp6IAYGWj5K0?=
 =?us-ascii?Q?qqUoYXrcsrO/Z21JPumBnM7tdDpchrvoOkq/CCfyBMb1LP2VGTmCVpKLC7jl?=
 =?us-ascii?Q?QUh3g9Lx8EG1O0Er7UEQRqGeUxMekX8aHJfw2sU5t17U+9d7rk4vufKmdfX1?=
 =?us-ascii?Q?K/3AfZGypl+ENS8sMALmBqvXhD9flR6yDnWlG35QUla9yZZSOwE02PNUjOyZ?=
 =?us-ascii?Q?QQodifz6892GUXdw6pXPWUI8haNZfTJs/JWUUiyv80sllEdC6Gby/D/5kYFR?=
 =?us-ascii?Q?uXqn0CWxjEwg/NZvps+ZcOLx/xa/O8BTilv5yJE5pV3H17Olq1ZTOOpiz90S?=
 =?us-ascii?Q?/F/epSXmXEey+2b4kz3mB5mYq7Ku3WzguAUek7QUvr3Ap+4qVKBygnrD1uW3?=
 =?us-ascii?Q?2STMf4mlVBu1csyjv8YweoeydRzqe4ldEPhiwA5CB/VlwL5a9eSO2OCZiPnK?=
 =?us-ascii?Q?BpVUdP3Q7J2TqaEK1RmcJK2wjMRRtBTRHf3CjHXGc619t6QC3vR4iU9Knn3i?=
 =?us-ascii?Q?K9ubeWKlV3Gcbmf+agL+wRtHRO5dWIN1EfUY5vNY3qQyB5DDMal797OggNgx?=
 =?us-ascii?Q?besQEEuX9gGKGXultW5KXATJ32iAkhaDHhOG2O3X+sAWTJSIw0xRqbX2INFR?=
 =?us-ascii?Q?8cAIqi/rof1dUpRSPlfw+hEbKuqgeZlYLehWFBvMOrOs6JXghtfocnKI35il?=
 =?us-ascii?Q?e7XEys8P4wGKhclOvOLQ48YXIeROnYAGjC3E7UiaG3djXzeSgV17pHXpeK9K?=
 =?us-ascii?Q?hws539UfplyRmqkqdFrg62ySSFl7pF41l8Q0RAUvw/XGL2oBYBXEZ3fB6WsM?=
 =?us-ascii?Q?TxRJlJBCpwtVDIropWCr6jfyGJMEAQHOM1cnnHuwjR/hY8u1G+FsY2CP8LLe?=
 =?us-ascii?Q?KnIt6E7pt37cqjSUbxquTBnU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a53e66-46bf-4757-e210-08d8e9c7036b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 04:33:44.0091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNWYPUUU2qXpj6AECXnYAiMfM7Q8hmorBdgFiI5ouwSUBChKuKFd1Nr3enMi+E7PH7LrD/afi8gLq++W+ei2hA==
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

Set flags at the top level pmops callbacks to track
state.  This cleans up the current set of flags and
properly handles S4 on S0ix capable systems.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 10 +++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  8 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 30 +++++++++++++---------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  |  2 +-
 4 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 569c85419f76..c03463d614e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1030,13 +1030,9 @@ struct amdgpu_device {
 
 	/* s3/s4 mask */
 	bool                            in_suspend;
-	bool				in_hibernate;
-
-	/*
-	 * The combination flag in_poweroff_reboot_com used to identify the poweroff
-	 * and reboot opt in the s0i3 system-wide suspend.
-	 */
-	bool 				in_poweroff_reboot_com;
+	bool				in_s3;
+	bool				in_s4;
+	bool				in_s0ix;
 
 	atomic_t 			in_gpu_reset;
 	enum pp_mp1_state               mp1_state;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a984ba6634fd..1859bc06ed70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2656,8 +2656,7 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 {
 	int i, r;
 
-	if (adev->in_poweroff_reboot_com ||
-	    !amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev)) {
+	if (!adev->in_s0ix || amdgpu_in_reset(adev)) {
 		amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 		amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 	}
@@ -3737,8 +3736,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	amdgpu_fence_driver_suspend(adev);
 
-	if (adev->in_poweroff_reboot_com ||
-	    !amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev))
+	if (!adev->in_s0ix || amdgpu_in_reset(adev))
 		r = amdgpu_device_ip_suspend_phase2(adev);
 	else
 		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D3Entry);
@@ -3772,7 +3770,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
-	if (amdgpu_acpi_is_s0ix_supported(adev))
+	if (adev->in_s0ix)
 		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D0Entry);
 
 	/* post card */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index cfa73ff292d5..5438a4d3d517 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1334,9 +1334,7 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
 	 */
 	if (!amdgpu_passthrough(adev))
 		adev->mp1_state = PP_MP1_STATE_UNLOAD;
-	adev->in_poweroff_reboot_com = true;
 	amdgpu_device_ip_suspend(adev);
-	adev->in_poweroff_reboot_com = false;
 	adev->mp1_state = PP_MP1_STATE_NONE;
 }
 
@@ -1425,15 +1423,28 @@ static void amdgpu_pmops_complete(struct device *dev)
 static int amdgpu_pmops_suspend(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	int r;
 
-	return amdgpu_device_suspend(drm_dev, true);
+	if (amdgpu_acpi_is_s0ix_supported(adev))
+		adev->in_s0ix = true;
+	adev->in_s3 = true;
+	r = amdgpu_device_suspend(drm_dev, true);
+	adev->in_s3 = false;
+
+	return r;
 }
 
 static int amdgpu_pmops_resume(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	int r;
 
-	return amdgpu_device_resume(drm_dev, true);
+	r = amdgpu_device_resume(drm_dev, true);
+	if (amdgpu_acpi_is_s0ix_supported(adev))
+		adev->in_s0ix = false;
+	return r;
 }
 
 static int amdgpu_pmops_freeze(struct device *dev)
@@ -1442,9 +1453,9 @@ static int amdgpu_pmops_freeze(struct device *dev)
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 	int r;
 
-	adev->in_hibernate = true;
+	adev->in_s4 = true;
 	r = amdgpu_device_suspend(drm_dev, true);
-	adev->in_hibernate = false;
+	adev->in_s4 = false;
 	if (r)
 		return r;
 	return amdgpu_asic_reset(adev);
@@ -1460,13 +1471,8 @@ static int amdgpu_pmops_thaw(struct device *dev)
 static int amdgpu_pmops_poweroff(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(drm_dev);
-	int r;
 
-	adev->in_poweroff_reboot_com = true;
-	r =  amdgpu_device_suspend(drm_dev, true);
-	adev->in_poweroff_reboot_com = false;
-	return r;
+	return amdgpu_device_suspend(drm_dev, true);
 }
 
 static int amdgpu_pmops_restore(struct device *dev)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index e722adcf2f53..cfcac110ed84 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1337,7 +1337,7 @@ static int smu_disable_dpms(struct smu_context *smu)
 	bool use_baco = !smu->is_apu &&
 		((amdgpu_in_reset(adev) &&
 		  (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
-		 ((adev->in_runpm || adev->in_hibernate) && amdgpu_asic_supports_baco(adev)));
+		 ((adev->in_runpm || adev->in_s4) && amdgpu_asic_supports_baco(adev)));
 
 	/*
 	 * For custom pptable uploading, skip the DPM features
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
