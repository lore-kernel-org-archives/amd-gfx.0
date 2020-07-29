Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141BBC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 08:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1E44206D4
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 08:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EnRZSmxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E44206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7894E6E47A;
	Wed, 29 Jul 2020 08:24:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A9B76E47A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 08:24:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KcSSWbuPIr1q7GWKf90XMUIGYPob1JAtVtj/SrEdEK7XU7kBid6zlEDaPRDYbx8gZSR/BUDiDqXtgw9S8GUDmE/L0BpBdLM10B8b4PfJA3z71SrwzTj3RAQ9TM0gHivxewbYuHEoX7mSt0QQcrsqMSiy/LcNwJE0ZnI5yhe2EQemEqKOL6Jhgz9AhB0VXytTSrod4j3b87JrB8I4rW9YzRGdw9uAFIEw6U/tEmdUHMhkDBzr/wS8HgVGgrepk24itfnPpOTEN2Q4LNEwDn8FsLn5JR7yUaR/x0+JhgQNzQ93OfiNowX6PCxleyhM2LcNnFrVN8fcNteb3qfNPaL3YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRPEtiG5bBRZ3HHOGf///ctYH3ErRourpHez3MZRfe0=;
 b=Jb6yZ4wmZP+w4sS+vc72oXbW4EpVIkh93GwhSUuAmJ4K8XTiEQfJqklqIpS4+5UxYmKVjF/FjSoT3qrFMDf+6vdEvHBTsjksvU7b6n3NFXpZSMn/mVUDgarglLRxPJvdy+29gbKJZNSw/Kb/W33fWTQgyNgi4NUfiOay11HwUwKoCkLj31sv4XfTPP1iclsRKxbhPDdos1qGwjlSJWYOBBqvSptcM52dkK8sOJAgJseO4SqxmY+IR0oZce5n3w3jg/3tSDvmpadSCdUBspfmR/VnkjVGhmurGEYsVXF1FZGDb54XeraNdabz7rBpamYZljsMR81TxCe5REh1AiTklQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRPEtiG5bBRZ3HHOGf///ctYH3ErRourpHez3MZRfe0=;
 b=EnRZSmxn+pgwQAoJVZd0j8wXnQdUq83062nsMj43MHkK0dzhf4axuCSXw/UPlTxLGzY2veuMzvYVP2CNTyYmsMKNrrUFxaMcuRDXY2baxUiwZrNBQw6LezkgtIS6yWpjRUU7EgJ/TvHa+FTdD5abkraNn97iZEOO+4oSkeq2XrU=
Received: from MWHPR21CA0060.namprd21.prod.outlook.com (2603:10b6:300:db::22)
 by MWHPR12MB1582.namprd12.prod.outlook.com (2603:10b6:301:10::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Wed, 29 Jul
 2020 08:24:06 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::a8) by MWHPR21CA0060.outlook.office365.com
 (2603:10b6:300:db::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.1 via Frontend
 Transport; Wed, 29 Jul 2020 08:24:06 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Wed, 29 Jul 2020 08:24:06 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 29 Jul
 2020 03:24:05 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 29 Jul
 2020 03:24:05 -0500
Received: from chengzhe-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 29 Jul 2020 03:24:02 -0500
From: Liu ChengZhe <ChengZhe.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm amdgpu: Skip tmr load for SRIOV
Date: Wed, 29 Jul 2020 16:23:59 +0800
Message-ID: <20200729082359.1133512-1-ChengZhe.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0024fe4-b34c-4974-df3c-08d83398c2aa
X-MS-TrafficTypeDiagnostic: MWHPR12MB1582:
X-Microsoft-Antispam-PRVS: <MWHPR12MB15827687622AEF66C51AB8E393700@MWHPR12MB1582.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OfpiB4qq9cWATF5bavOglKr7Ukk7II6wxgoo3R3aHepvZSuoiPBj9VqK9YApQbE84r1Lf/+5xtBjFLoMnyLldPjnu4aHSYmudDz1oFLqkZhrGtDLkIoP1aXS48/a5iRmWCINJJE5hUqcvZVL2hACaYFoXA/rrBGLsvJmO0ip1Tx7RajM0hA4Ejf+mRYs6hSTz22aLAfgtpssbPwfo0jSdK9mumjcMR42dKhOpqaNie5owubiTnXxlNsiRr4USUvJX9wAn7c2c+xojBzBuIe5EakfrLWabhyysqeZa7HTjC4yUArDZNmTZMaSToKZPM6bF+P9Ri47ZQXTYRBUr3QuYIFIbFYpvFJLdVsVBIiiXwi6UiQ2o4irFjK5lx7VpkQibncbl79O1vIQPW3T5+n0Iw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(46966005)(47076004)(8676002)(186003)(336012)(5660300002)(26005)(316002)(2906002)(83380400001)(478600001)(86362001)(8936002)(4326008)(2616005)(426003)(70206006)(54906003)(6916009)(7696005)(82310400002)(1076003)(82740400003)(81166007)(36756003)(70586007)(6666004)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 08:24:06.5329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0024fe4-b34c-4974-df3c-08d83398c2aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1582
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
 Liu ChengZhe <ChengZhe.Liu@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. For Navi12, CHIP_SIENNA_CICHLID, skip tmr load operation;
2. Check pointer before release firmware.

v2: use CHIP_SIENNA_CICHLID instead
v3: remove local "bool ret"; fix grammer issue
v4: use my name instead of "root"
v5: fix grammer issue and indent issue

Signed-off-by: Liu ChengZhe <ChengZhe.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 35 ++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a053b7af0680..c68369731b20 100644
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
@@ -409,11 +415,28 @@ static int psp_clear_vf_fw(struct psp_context *psp)
 	return ret;
 }
 
+static bool psp_skip_tmr(struct psp_context *psp)
+{
+	switch (psp->adev->asic_type) {
+	case CHIP_NAVI12:
+	case CHIP_SIENNA_CICHLID:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int psp_tmr_load(struct psp_context *psp)
 {
 	int ret;
 	struct psp_gfx_cmd_resp *cmd;
 
+	/* For Navi12 and CHIP_SIENNA_CICHLID SRIOV, do not set up TMR.
+	 * Already set up by host driver.
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
