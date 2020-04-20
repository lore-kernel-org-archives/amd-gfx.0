Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066A5C3815B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 10:17:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE19321744
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 10:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZcK6Ov9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE19321744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D46F6E4EA;
	Mon, 20 Apr 2020 10:17:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34B926E4EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 10:17:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgZU8fKIYOjWQ9S5YXPiYL6u2P0AZ42Wmw0h9GEdisaUu/yKBk65RsmFZZyCOs8wntULfu4FLyQwLRLsMnlGPin/IxjPDsIEsZwFMCRPaLrJT8UpMVjjKNCtyKXT2IbaljO93+mRaQz5X8ZWtNjP08oa4g9rUXkXj+rOpxshXv/vIKNTxun1baZgx7kZOOEMdkx5MZLOZGx/yhQFb7JBjgw9oFTw2y8xx3J/Q7xw3BmbqV015YM74mr2ZKwTgy4akxHidj6MoCps1dY7Ds0JkkO1bXo5VPSaveAuBGw8iOXS+WlxGI1ayFbCuBFKXK1pCFAf2sFQjFxqVmksaOIOUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oC3z2/vFSzFDhOtQgexwmanT7V+bfK/dNfnseaiRZN8=;
 b=OrxmNLRM417Ox/WUdd2akLOc8iufS43tU4qyvG3W1Mq5oopbTxWyCOoCsZ/OJ0K1CYJRL/J8LuWxQo1on8j+3WJxt8gErcaXoJkaIpxbqGBI/PUI7Nh6FH/D7itmSEVxYf6URg/A8GrLgOd4iiTCZOXAaExTwSbc5Xad9P9bgZb41HlEi2hRC+GwmLBIDpaJghfnxXrdZsSgKHt8lRcHrwgWmlaTIkBcMC63Bl47nfDOy0fNAqsKPoFHF54tbX5IWDlq7OhcdhCIErvfBtvl70xX/1yzDr9jqQ9Jligp2nIsPXHWtUkiHrIm4daupv+gHVj8iUL4W4NUVl3lqMXLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oC3z2/vFSzFDhOtQgexwmanT7V+bfK/dNfnseaiRZN8=;
 b=ZcK6Ov9dKUm18qcCv534mlwDAMHpF2rZ24JDH/66vy+XYKyJINNvIFrHSbcDVYDaPpl17Yvc8zf5VDmfEbyTlRRjxyauAPMscUi08IIckLlJDWjRBh7d3RLKG/mHXZw6a5Ucw0uYQQOSp/PVHXgmo13LHl1YDI2oU7xNktZ5TRg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3225.namprd12.prod.outlook.com (2603:10b6:5:188::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25; Mon, 20 Apr 2020 10:17:32 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 10:17:32 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 John Clements <john.clements@amd.com>, Guchun Chen <Guchun.Chen@amd.com>
Subject: [PATCH 6/8] drm/amdgpu: add helper function to init sos ucode
Date: Mon, 20 Apr 2020 18:16:42 +0800
Message-Id: <1587377804-3836-7-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587377804-3836-1-git-send-email-Hawking.Zhang@amd.com>
References: <1587377804-3836-1-git-send-email-Hawking.Zhang@amd.com>
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-All-Series.amd.com (180.167.199.189) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2937.6 via Frontend Transport; Mon, 20 Apr 2020 10:17:30 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 167edef1-7c20-4769-1b4a-08d7e5140995
X-MS-TrafficTypeDiagnostic: DM6PR12MB3225:|DM6PR12MB3225:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3225B0706F74DEDF84396AC4FCD40@DM6PR12MB3225.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(26005)(2616005)(16526019)(956004)(316002)(186003)(6486002)(6636002)(2906002)(86362001)(478600001)(6666004)(8676002)(36756003)(4326008)(5660300002)(66556008)(66946007)(66476007)(7696005)(52116002)(110136005)(81156014)(8936002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +9bfgcUHOKOyRo/VekmliMlp1/TTsvAnrF9TkS7QhoubNQKeFYVp40ww0M7T7zNMUCmg0Q4Pf+BE+CvsolNnVS3UWEbytsdo5HcE0D2Hi00AEN+qqVwVPTBox0mnFue9AYxMejc3lBBP18grhl2puuVsPJDmfZCq6s75L1VCZ1PFaXH48FxRdhfNpC4Bg1LquRfpznt9/f5nBCPu8oPUl+qh1Gj2nXPiPpefi69FPcYcdgfAuJz0zhLrVO8BtjfssR6aXqhapniabfd4JE+jEYJGzvTdawoWR5YCyU7rJpSOw1wh7I6pKotfJbzA9/BuVQwCvTmgJSPtF9DV7zkdU+1a/ubhUeBtqNqlsXIgZ401/n6fSqIldPkCBkf3yOmqSu3aRhtfLcjPNq+ZgeCRRnAT3fGYptmDwlltme0b984jMBLl4i7qIxZjxft6MJiI
X-MS-Exchange-AntiSpam-MessageData: ZRsJ0hiRg2VGlSZR4/nyGJFA3n5RS6Cnph7mNXkV0GjArlDAzvOD7HzhCWRAUoKZwCpL2cEBbskjEZlX14y4mAqDQL12HpdbugADoxj6z3AEq6KAeyw1VWMMZE5JwhyArYOOxFEcvw5Zu8v2Qk/iRA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 167edef1-7c20-4769-1b4a-08d7e5140995
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 10:17:32.2453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Ku5EF12kPx8VuSmJGclR+3wAE37y000mEtd4wWw/t9ujO/zCblWJA9BeqhroiueQyH+X2yvQQ7XrHLv5vSAOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3225
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

driver already had psp_firmware_header struture to
deal with different layout of sos ucode. the sos
micorcode initialization could be common one.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 70 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 +
 2 files changed, 72 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 3656068..730f98a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1876,6 +1876,76 @@ int psp_init_asd_microcode(struct psp_context *psp,
 	return err;
 }
 
+int psp_init_sos_microcode(struct psp_context *psp,
+			   const char *chip_name)
+{
+	struct amdgpu_device *adev = psp->adev;
+	char fw_name[30];
+	const struct psp_firmware_header_v1_0 *sos_hdr;
+	const struct psp_firmware_header_v1_1 *sos_hdr_v1_1;
+	const struct psp_firmware_header_v1_2 *sos_hdr_v1_2;
+	int err = 0;
+
+	if (!chip_name) {
+		dev_err(adev->dev, "invalid chip name for sos microcode\n");
+		return -EINVAL;
+	}
+
+	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sos.bin", chip_name);
+	err = request_firmware(&adev->psp.sos_fw, fw_name, adev->dev);
+	if (err)
+		goto out;
+
+	err = amdgpu_ucode_validate(adev->psp.sos_fw);
+	if (err)
+		goto out;
+
+	sos_hdr = (const struct psp_firmware_header_v1_0 *)adev->psp.sos_fw->data;
+	amdgpu_ucode_print_psp_hdr(&sos_hdr->header);
+
+	switch (sos_hdr->header.header_version_major) {
+	case 1:
+		adev->psp.sos_fw_version = le32_to_cpu(sos_hdr->header.ucode_version);
+		adev->psp.sos_feature_version = le32_to_cpu(sos_hdr->ucode_feature_version);
+		adev->psp.sos_bin_size = le32_to_cpu(sos_hdr->sos_size_bytes);
+		adev->psp.sys_bin_size = le32_to_cpu(sos_hdr->sos_offset_bytes);
+		adev->psp.sys_start_addr = (uint8_t *)sos_hdr +
+				le32_to_cpu(sos_hdr->header.ucode_array_offset_bytes);
+		adev->psp.sos_start_addr = (uint8_t *)adev->psp.sys_start_addr +
+				le32_to_cpu(sos_hdr->sos_offset_bytes);
+		if (sos_hdr->header.header_version_minor == 1) {
+			sos_hdr_v1_1 = (const struct psp_firmware_header_v1_1 *)adev->psp.sos_fw->data;
+			adev->psp.toc_bin_size = le32_to_cpu(sos_hdr_v1_1->toc_size_bytes);
+			adev->psp.toc_start_addr = (uint8_t *)adev->psp.sys_start_addr +
+					le32_to_cpu(sos_hdr_v1_1->toc_offset_bytes);
+			adev->psp.kdb_bin_size = le32_to_cpu(sos_hdr_v1_1->kdb_size_bytes);
+			adev->psp.kdb_start_addr = (uint8_t *)adev->psp.sys_start_addr +
+					le32_to_cpu(sos_hdr_v1_1->kdb_offset_bytes);
+		}
+		if (sos_hdr->header.header_version_minor == 2) {
+			sos_hdr_v1_2 = (const struct psp_firmware_header_v1_2 *)adev->psp.sos_fw->data;
+			adev->psp.kdb_bin_size = le32_to_cpu(sos_hdr_v1_2->kdb_size_bytes);
+			adev->psp.kdb_start_addr = (uint8_t *)adev->psp.sys_start_addr +
+						    le32_to_cpu(sos_hdr_v1_2->kdb_offset_bytes);
+		}
+		break;
+	default:
+		dev_err(adev->dev,
+			"unsupported psp sos firmware\n");
+		err = -EINVAL;
+		goto out;
+	}
+
+	return 0;
+out:
+	dev_err(adev->dev,
+		"failed to init sos firmware\n");
+	release_firmware(adev->psp.sos_fw);
+	adev->psp.sos_fw = NULL;
+
+	return err;
+}
+
 static int psp_set_clockgating_state(void *handle,
 				     enum amd_clockgating_state state)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index a763148..7fcd63d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -387,4 +387,6 @@ int psp_ring_cmd_submit(struct psp_context *psp,
 			int index);
 int psp_init_asd_microcode(struct psp_context *psp,
 			   const char *chip_name);
+int psp_init_sos_microcode(struct psp_context *psp,
+			   const char *chip_name);
 #endif
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
