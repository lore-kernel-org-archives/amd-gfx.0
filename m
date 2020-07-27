Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C49C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 10:57:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F892070B
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 10:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wHpE9p/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F892070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B520389D60;
	Mon, 27 Jul 2020 10:57:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0CDB89D60
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 10:57:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdonJ9/glVa+ZIFS/zQXrwGcCEh5NgktWVCcD5fIQuyjKx3n4K0dshWinJuMVvvpH/eC0/1FdxF000nR+bqZcUFFeh81FBacs2M3G8UhnpozAmlajif0tps3qu0+vlfLqov1RNQraRD5t94gePH/L+lm9fvg7Dy3XRXtV6Ab2vIrw97DuB3H10znnGiQvyyBcYO0mSP+UdAJyPQCJfjGugarssK9OBBQNwcjvuHil3ouFDbXAUlufKQOn+aVR7koc+/QtpUYUnDRHmu53ogVyHVl+Fi96koNCaeNmmjY+6JuSGdCy8bDqJQLaatBJWvpEhuAuTtNBs7VbzSv9hGCsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+xmT31w97WqkDGQCINv2goc5t1RnH7tbwGijENsfkE=;
 b=kC0ZNEr+/tV+N2cBvG9KShtkErgEWbEKqK26HF7dpzKf6s8/9c60EaH447/eBD6VJXmoPecKXsMatHwBYbzrloEo6LPlrm9QERgIjuYatYeAbaTRQz3dC+7YLm5nx+t93Ji7TkOReSU6XubbwPOSuSYGU4WptAdvPyP6svtQc2LxO+g7C0nFWA2C+JngFyxcBqKOSALU+Qsv86zz2wv1O9JrkpkyhCB+EpfJGot5QAtVI+cwaBguU7pv68Uxcjty42vvt20MppfAnT0HFYBHv03sR+let27lrwScn0SmcUVJNtZKWbFwwU6BoOwj49mUFW+mDwF5jymJoNyrTPHCSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+xmT31w97WqkDGQCINv2goc5t1RnH7tbwGijENsfkE=;
 b=wHpE9p/2IydpkGquAUrNpCJ5uVLoz1lqjrUrvO5WfB+WYYiTjKEcj4eK6NDHFNEy2a5lHW0ploiIQQjfYX3EGtU66D2xFW+7E/g8TMo1eS6PNlICobo+U0ich2AUPa69+vFB0bJJCnGyA16O0zdC5wwH+P21kGdXZEpDdRWA8zY=
Received: from CO2PR05CA0004.namprd05.prod.outlook.com (2603:10b6:102:2::14)
 by DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 10:57:34 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::1e) by CO2PR05CA0004.outlook.office365.com
 (2603:10b6:102:2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.10 via Frontend
 Transport; Mon, 27 Jul 2020 10:57:34 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.25 via Frontend Transport; Mon, 27 Jul 2020 10:57:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 27 Jul
 2020 05:57:32 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 27 Jul
 2020 05:57:32 -0500
Received: from chengzhe-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 27 Jul 2020 05:57:30 -0500
From: Liu ChengZhe <ChengZhe.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm amdgpu: Skip tmr load for SRIOV
Date: Mon, 27 Jul 2020 18:57:20 +0800
Message-ID: <20200727105720.401290-1-ChengZhe.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c03e28d0-91ef-41a5-1ffc-08d8321bddd7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4251:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4251E31BA158FDDB87BAAAAC93720@DM6PR12MB4251.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L6Tk1ONwQGTCaDaKar0JpDgIu5Eo3w9njxQW9w+kdB0ozAvbplW96Hm81dPsftefbhvYod4ky/Y2D7D/cdNVNeP4F0WZ8yKv0vcJBuoOpxHbcrxHTRN8+deoboZt7E96yCtVhkS3H3drHmrkAySwdM4sqB+OnoAOlq4UZftO6tOIKrZj9VsUMLAxRXHjCfq3p+URfuv+p1FflpPhq8cQE+EFPjJfHUywPZ8pADa32z7sNXga4nyYgArnZPCAkabZeue60Dc082vLaNjaGmI1OchagH4yIkO376AyXJH6mehjCorUtT3K7qSli1KP7thkQ6TgTlUegGWhoACwBYABXDnCKm6r8gsfxqXq5E4LCI9fUaWcDJQbxgFkgS8aaxIOiwDel3CL+ir6R9/AV+opng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(46966005)(5660300002)(478600001)(82310400002)(6916009)(4326008)(8936002)(82740400003)(81166007)(70586007)(8676002)(70206006)(1076003)(2906002)(7696005)(356005)(186003)(26005)(54906003)(47076004)(6666004)(2616005)(426003)(336012)(316002)(86362001)(83380400001)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 10:57:33.8595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c03e28d0-91ef-41a5-1ffc-08d8321bddd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei
 Xu <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 root <ChengZhe.Liu@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: root <ChengZhe.Liu@amd.com>

    1. For Navi12, CHIP_SIENNA_CICHLID, skip tmr load operation;
    2. Check pointer before release firmware.

Signed-off-by: root <ChengZhe.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 40 +++++++++++++++++++++----
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a053b7af0680..a9481e112cb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -193,12 +193,18 @@ static int psp_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	psp_memory_training_fini(&adev->psp);
-	release_firmware(adev->psp.sos_fw);
-	adev->psp.sos_fw = NULL;
-	release_firmware(adev->psp.asd_fw);
-	adev->psp.asd_fw = NULL;
-	release_firmware(adev->psp.ta_fw);
-	adev->psp.ta_fw = NULL;
+	if (adev->psp.sos_fw) {
+		release_firmware(adev->psp.sos_fw);
+		adev->psp.sos_fw = NULL;
+	}
+	if (adev->psp.asd_fw) {
+		release_firmware(adev->psp.asd_fw);
+		adev->psp.asd_fw = NULL;
+	}
+	if (adev->psp.ta_fw) {
+		release_firmware(adev->psp.ta_fw);
+		adev->psp.ta_fw = NULL;
+	}
 
 	if (adev->asic_type == CHIP_NAVI10)
 		psp_sysfs_fini(adev);
@@ -409,11 +415,33 @@ static int psp_clear_vf_fw(struct psp_context *psp)
 	return ret;
 }
 
+static bool psp_skip_tmr(struct psp_context *psp)
+{
+	bool ret = false;
+
+	switch (psp->adev->asic_type) {
+	case CHIP_NAVI12:
+	case CHIP_SIENNA_CICHLID:
+		ret = true;
+		break;
+	default:
+		return false;
+	}
+
+	return ret;
+}
+
 static int psp_tmr_load(struct psp_context *psp)
 {
 	int ret;
 	struct psp_gfx_cmd_resp *cmd;
 
+	/* for Navi12 and CHIP_SIENNA_CICHLID SRIOV, do not setup TMR
+	 * (already setup by host driver)
+	 */
+	if (amdgpu_sriov_vf(psp->adev) && psp_skip_tmr(psp))
+		return 0;
+
 	cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
 	if (!cmd)
 		return -ENOMEM;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
