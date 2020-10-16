Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1265C433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 09:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0325D20872
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 09:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JiW0MzbS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0325D20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DEB56EA90;
	Fri, 16 Oct 2020 09:22:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55AB86EA90
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 09:22:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsBAz2+cD1J9sHBVhJRyfmqiJyv72ibpxrWZjP4c8pbZzyhu16uyQ9pJ9UgSIxa0v+2XRsKTiKQaiNy8FJhy3/FOexnAIHvUGg4im9LacTdCPMel1AM8Q8cqP0reX7qMVC+7Dz50dMYFilJtTCm0vR3eYCw94VogSOgM1FncNvzQiamGSzkgRHCnMxqPqSgTzezomAnpT7uFc2qMgme2wrUp5PcJsCPKWyFxDXjRx32PL9rugHwS+VTcUqG3TGM+47lAvliHMTqIcC1BkWOpAxzGxDk6+fQBM/KMlmgeiiyV98UY2MK+c/HD1ebb3WCzdQGaXl1BYyXPO8Wor/oVeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAfuGvD+XY0RbrokxHolWO6GaQZUlw5CFPnRCxOKbRA=;
 b=gsE4ZprZG4KRYlihzTQGqDeIe86DHs0Ct41m5JOPeGTRLva3YDN3odYx8GWSPhbuBy/BwKNd81PGU49LzeJXfg2C7FoWWjq/rxYIhL6hLyg36+w5i5iDacqahXQ7ycuraOTCcSB7OgTzVDz9Ef3Ks9vjzDOZA1/PbJfyvCXARQ6XaBMVi5cyVGQ0vPGm22G10VJsPwwfw8BONhoXaiXXPIIoOEPBNUUPOuAzMSCag3sdjk/2y+kPbIN29oBAma21i7BsttxiCnnkUEBauJ9oEPJ46RQ81WojPRfBhYatk2Kbh/zklp7OKq3b35TzTnFDHXJ3Wf+p/SdcWjFBtsesFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAfuGvD+XY0RbrokxHolWO6GaQZUlw5CFPnRCxOKbRA=;
 b=JiW0MzbSdK36yJ49YPuvD/QCdUFqvlQtdDuVu5TbbjhF/fhgqqGMeMdRk7kguXy8byWPRXJXR8GFXwPzfHZ9nl0cZuMEpxbkc8jyYdj8GTuDpBQVIfZ02b0A84aXEW3Xl1u0R+swtjmgAb+NycDK3FKoowOQEA17RxVqzui+5sQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB3128.namprd12.prod.outlook.com (2603:10b6:a03:dd::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 16 Oct
 2020 09:21:58 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::2c68:c110:d658:f219]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::2c68:c110:d658:f219%5]) with mapi id 15.20.3477.021; Fri, 16 Oct 2020
 09:21:58 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: update amdgpu device suspend/resume sequence
 for s0i3 support
Date: Fri, 16 Oct 2020 17:21:42 +0800
Message-Id: <1602840103-21053-3-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602840103-21053-1-git-send-email-Prike.Liang@amd.com>
References: <1602840103-21053-1-git-send-email-Prike.Liang@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR04CA0065.apcprd04.prod.outlook.com
 (2603:1096:202:14::33) To BYAPR12MB3238.namprd12.prod.outlook.com
 (2603:10b6:a03:13b::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (58.247.170.242) by
 HK2PR04CA0065.apcprd04.prod.outlook.com (2603:1096:202:14::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3477.21 via Frontend Transport; Fri, 16 Oct 2020 09:21:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 728ed253-960b-49fb-bd33-08d871b4ee8f
X-MS-TrafficTypeDiagnostic: BYAPR12MB3128:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3128FDF0E4A2F6F962656706FB030@BYAPR12MB3128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76DL812qaL8SDTSH9CGfZnFYBo2zZKv33hFAzkxQXgiI95m8OfUO6FhH0Z2MEPOuaCYItjj+MX87KIAcCL79ipDiYtFEvizLB7h99W7tPxI32NXEptpR4pbReFyxFCGtS+gUq/PCUqCxGDybkTS1OxA2hdVwanwmuWUNS+QjP/VVtZPHFElkhznXQHG/tnf0rP7LcpeMcogc2IIZrOjzD2Oz6tpHUb5RzBibbXCWh7NuLSCmbsZS1m2W+JAE1QdTpPYd4zs/DsKUvWO5SIhDGpXeMCI5WHP2Q3FfJ/TRi+4E/3aOPvV6dUYlw3vp6hm8AqhI2FVHBNr9BjgkzJyjuGBn/4ogQuyY3hqYHWM27ODrSFTuX3KwRvYQn/BDQodh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(86362001)(478600001)(2616005)(26005)(5660300002)(186003)(16526019)(956004)(52116002)(34490700002)(7696005)(6486002)(4326008)(66556008)(83380400001)(8676002)(8936002)(6916009)(36756003)(66946007)(66476007)(316002)(15650500001)(2906002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 37juqSz40y1FB5aYgARXOmNEE7/H44Ospu1z80eMSxKnEQNZh226IneGPcc1X3tSvstaoi0OEOJKWH5KKYA3Dcx79oYW8uX1rhCPu8x0O71TH/27XqHYJsMCn6KsJ7PbwtoWJwZcl18lz5IEAFN6pldKyUQJ79xv3dAGxLaAEP2NyDDR+1MNJki2bczcxX6XdUqpackbJ3JJBe0qQvwpaMmWMkqIR7eZuD3yb9XVJWd1nuTWY/3sZBkfSSNaFWz8H8qOcwGDaaYesWNMOjLjUBX8TNUIMiWS/S0ZAQcwU+2T5SgNhdsHe+WC1vTmHGctdasYPVSelHzIY+4FW5s5zzjJD75scqBvCVvWYNTC3JgLac1BRdzdi8LVWiPYiSE5KsImMGiFFU509OLISN5dqDZ8Q/eBiVRbHi5vH+JFSEa5Y5faIcekhbyjyInN0ktcznVG7BY9HNCuvyUESCgF0QMq3uXnplfnNpiUTNulRAjIwO8Az4o/lC+d0HZtbqR0ZXp/sxYK4ic15a2PgSNOU90Mf/2T4USWF3PhXKR09wYcI71qaDncDCSo/pCUUMQaTwXCPZKNB6uiF689ZvbVG1LVFN1VbljVdoJqcF4YXp7hZTP6WDRYhG39xvBiG2xEYsoK+XzTMoFP1cqn6ELL1w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 728ed253-960b-49fb-bd33-08d871b4ee8f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 09:21:58.5453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/F/f1RzXE5hcf/ktnmM/Xocmep7dEvrEXdHUvkyv7xrHr7wit+dkvEYL9bMQUu6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3128
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- Need skip the RLC/CP/GFX disable for let GFXOFF enter during suspend period.
- For s0i3 suspend only need suspend DCE and each IP interrupt.
- Before VBIOS POSTed check and atom HW INT need set the GPU power status change
  to D0 in the resume period, otherwise the HW will be mess up and see the SDMA hang.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a027a8f..b16a7f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2432,8 +2432,10 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 {
 	int i, r;
 
-	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
-	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
+	if (!amdgpu_acpi_is_s0ix_supported()) {
+		amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
+		amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
+	}
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
 		if (!adev->ip_blocks[i].status.valid)
@@ -3459,12 +3461,15 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	amdgpu_fence_driver_suspend(adev);
 
-	r = amdgpu_device_ip_suspend_phase2(adev);
-
+	if (!amdgpu_acpi_is_s0ix_supported())
+		r = amdgpu_device_ip_suspend_phase2(adev);
+	else
+		amdgpu_gfx_state_change_set(adev, GpuChangeState_D3Entry);
 	/* evict remaining vram memory
 	 * This second call to evict vram is to evict the gart page table
 	 * using the CPU.
 	 */
+
 	amdgpu_bo_evict_vram(adev);
 
 	return 0;
@@ -3492,6 +3497,9 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
+	if (amdgpu_acpi_is_s0ix_supported())
+		amdgpu_gfx_state_change_set(adev, GpuChangeState_D0Entry);
+
 	/* post card */
 	if (amdgpu_device_need_post(adev)) {
 		r = amdgpu_atom_asic_init(adev->mode_info.atom_context);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
