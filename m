Return-Path: <SRS0=hrZh=AL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEBBC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2020 10:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC8A20771
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2020 10:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WgJqSZP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC8A20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD5DB6E071;
	Tue, 30 Jun 2020 10:31:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA6106E071
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2020 10:31:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6/VsvbBU3KLFha46q6OKG2dzpqc5jBr4d8emaYqjguX3ujs1gnnf9+/AXRhPgE8aBZDsuqJsJCoFvt9BHeMqko8zwsUEEKjeBpGmOsN/n5vRpZrqLXhD28XUSBe7va7ime6kOFrZECCr8iXkQ1a0QEOU4ii34E61cN0mYJoCr7KMgKVzPj8oXZs0IO/yIQBsdJ2mvKrCgkD8p3/HoIqIgvcKSc5K/HbJvM0qo1qMVR5wFG615WyW6ihFHvzbo6wpxmHMq6pJMzcvN3Hc2S1an3FcwlaUQy1VeY1aWMYSzxAmMY8cS6lN+9nOIeSkurNRJ6/YnBc6RiAG1hufo8kcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0wJcDAb5ZJPyOIfZUdYH6h88u0X9IulaFIox7ECmH8=;
 b=OPtd1aCIWfu8jKT0xjV2zkE+GFe15QWavA+r+CXKgfTmej5R4e58XTzMEu20CtRRJXZcCMEtR6FiGPXP1llSmqH8++roYJw34IR3UtJbLiaqVqc//4g1PxQp/Mh/VOfCRP+oFyBWrUX7f+6EFOz257vie7xIV5RTZpiTZ8BzI+jFCrFms247PwArBQ59HQOpCbr8py7X8Mgd7m+3/6/8PpAPJd0U3XjVOksEJmkgDGKq0SUOPaE7YmZbyw00Fli1diNYETi/e2e5/j/JTFK6gIkUgBnnVozFnf/Fvvaybb2s5DNRE7CoMc2AMjGV7emLPk1n9clYUUbcNNcuMdCH5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0wJcDAb5ZJPyOIfZUdYH6h88u0X9IulaFIox7ECmH8=;
 b=WgJqSZP9aKQMB0vqtK3FINtm9YKkqG+cOL6mX1dq7A1gQiiMYZxWVODWkZsfeTX7NvH/GzdCyKcQ7fGokO2wLbdGvA4ya9hkeNiBKlyTtdi7WOk8K20POIoCfWl+7sTHZqOA/qVlMX1S5qbFrkslLQqwzxdkrFxf+2ZER2C4568=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3770.namprd12.prod.outlook.com (2603:10b6:5:1c4::19)
 by DM6PR12MB2795.namprd12.prod.outlook.com (2603:10b6:5:41::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Tue, 30 Jun
 2020 10:31:46 +0000
Received: from DM6PR12MB3770.namprd12.prod.outlook.com
 ([fe80::20e2:909d:12d:3d23]) by DM6PR12MB3770.namprd12.prod.outlook.com
 ([fe80::20e2:909d:12d:3d23%5]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 10:31:46 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: add TMR destory function for psp
Date: Tue, 30 Jun 2020 18:30:51 +0800
Message-Id: <20200630103051.1206401-2-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630103051.1206401-1-ray.huang@amd.com>
References: <20200630103051.1206401-1-ray.huang@amd.com>
X-ClientProxiedBy: HK2PR0401CA0021.apcprd04.prod.outlook.com
 (2603:1096:202:2::31) To DM6PR12MB3770.namprd12.prod.outlook.com
 (2603:10b6:5:1c4::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.242) by
 HK2PR0401CA0021.apcprd04.prod.outlook.com (2603:1096:202:2::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Tue, 30 Jun 2020 10:31:45 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2752830e-27ba-4815-f4b9-08d81ce0ca37
X-MS-TrafficTypeDiagnostic: DM6PR12MB2795:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB27952969A79950EF38588B97EC6F0@DM6PR12MB2795.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SNunNmt2IPHNxNqKRQV5kNkrSVc5evJI7a4qqbV4gj9/c0wvI1HFSLi+BriRbAvOCmJTcjHGq1ZAZMyaYORYB1qJvWsfk3QCS4Hb3gN8m8tDlL88tz1MqIOWExPTUiRDg25VcVDhZPPy0rbl2S/5PpQy8rzM7qDeymAwk8NSRpmW+gK2WTJTTc0r66L1Zeju5dvSPHAlij5+j2VMNmNAQR8HzmQTPsfKNUbU5EWa8cySGgDohnICoA2sZrOfe8ehB4nVlL0ifzXCTfZmfDhDrfEMaU7xvWFcS96VGKIT1svhrSqv6nNsgNB2vXnjHYJU5s3EU6v1tg43kw7z1p5fog==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(52116002)(7696005)(6666004)(6916009)(8936002)(5660300002)(478600001)(86362001)(2906002)(8676002)(2616005)(83380400001)(26005)(1076003)(186003)(956004)(316002)(36756003)(16526019)(6486002)(66946007)(66556008)(66476007)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: FOIlg+ubBtethC1cwwiqsulXdDr4/DclrDOqIVZmv6uaWYgzgnBj2jxp5zA8X/kz+GTtF2NR5YSnkwonusz5ZCY/2pC4vcjosem6ZRZW6ivpOokDSde/NjCcT1JkEmFhudqPZOEcMoEEfmOlEI+uJHCOHxZKa8KtsYHd+7fAOH17bwt188s6aHXnNVczxuxsRWpZtuszCXV42W23DK9RgdbvXweM5ToY276hYdGrJKyuV0sVFMCEiq4cjr5FRPPTMCbSqVVYyI9fw7Y+LYXeG/YhkG/bVCkmAnw4ZfiDOLQOmcvO4rY+3CXsAhdqIASdo5txNABMsaIhkggNby0X8SH4WY/FSqG21vIcQq0QPAa+4EGJE0zlOxZeY97zaiHwk04elrlTEoAMdfQBv/tqwuGbRygZymnIuHFitImxKNHyfpay9Ao7/8L1rwq3JO5gmf0Wfldpo03Qj5QmMPAjPOaGtVqLlrnhZzdAQW3Wgr1gheAqTr6pjIBUyYbvH21h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2752830e-27ba-4815-f4b9-08d81ce0ca37
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 10:31:46.6370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMZNNMOfnRlq+YOFCNIruJZF1HTJuLV5vWOe/X8quK/MgVDj05OP4So1yYZ0nhHweKZVnpBC0JMoT9dvF7WIQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2795
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
Cc: Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

TMR is required to be destoried with GFX_CMD_ID_DESTROY_TMR while the
system goes to suspend. Otherwise, PSP may return the failure state
(0xFFFF007) on Gfx-2-PSP command GFX_CMD_ID_SETUP_TMR after do multiple
times suspend/resume.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 57 +++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index e57a53d5ca96..23ebb50b1a19 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -430,6 +430,52 @@ static int psp_tmr_load(struct psp_context *psp)
 	return ret;
 }
 
+static void psp_prep_tmr_unload_cmd_buf(struct psp_context *psp,
+					struct psp_gfx_cmd_resp *cmd)
+{
+	if (amdgpu_sriov_vf(psp->adev))
+		cmd->cmd_id = GFX_CMD_ID_DESTROY_VMR;
+	else
+		cmd->cmd_id = GFX_CMD_ID_DESTROY_TMR;
+}
+
+static int psp_tmr_unload(struct psp_context *psp)
+{
+	int ret;
+	struct psp_gfx_cmd_resp *cmd;
+
+	cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	psp_prep_tmr_unload_cmd_buf(psp, cmd);
+	DRM_INFO("free PSP TMR buffer\n");
+
+	ret = psp_cmd_submit_buf(psp, NULL, cmd,
+				 psp->fence_buf_mc_addr);
+
+	kfree(cmd);
+
+	return ret;
+}
+
+static int psp_tmr_terminate(struct psp_context *psp)
+{
+	int ret;
+	void *tmr_buf;
+	void **pptr;
+
+	ret = psp_tmr_unload(psp);
+	if (ret)
+		return ret;
+
+	/* free TMR memory buffer */
+	pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
+	amdgpu_bo_free_kernel(&psp->tmr_bo, &psp->tmr_mc_addr, pptr);
+
+	return 0;
+}
+
 static void psp_prep_asd_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 				uint64_t asd_mc, uint32_t size)
 {
@@ -1866,8 +1912,6 @@ static int psp_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct psp_context *psp = &adev->psp;
-	void *tmr_buf;
-	void **pptr;
 	int ret;
 
 	if (psp->adev->psp.ta_fw) {
@@ -1883,10 +1927,9 @@ static int psp_hw_fini(void *handle)
 		return ret;
 	}
 
+	psp_tmr_terminate(psp);
 	psp_ring_destroy(psp, PSP_RING_TYPE__KM);
 
-	pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
-	amdgpu_bo_free_kernel(&psp->tmr_bo, &psp->tmr_mc_addr, pptr);
 	amdgpu_bo_free_kernel(&psp->fw_pri_bo,
 			      &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
 	amdgpu_bo_free_kernel(&psp->fence_buf_bo,
@@ -1939,6 +1982,12 @@ static int psp_suspend(void *handle)
 		return ret;
 	}
 
+	ret = psp_tmr_terminate(psp);
+	if (ret) {
+		DRM_ERROR("Falied to terminate tmr\n");
+		return ret;
+	}
+
 	ret = psp_ring_stop(psp, PSP_RING_TYPE__KM);
 	if (ret) {
 		DRM_ERROR("PSP ring stop failed\n");
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
