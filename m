Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0B4C433E6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 02:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E47FD2068F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 02:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rHRMyySJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47FD2068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A031C6E125;
	Wed,  2 Sep 2020 02:26:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65E2D6E125
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 02:26:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqHBc8UM5DB/NiK+WYqTNhILQf3UyhyucRH/8pNuyhe8f7al7oOHP0RjmcEpOI7j/LWIWbwzvZcVUq9kOrrLKQyAcpyN0EVqYz2OZPHNBSmZzHPhtqGTqle7M9ksHyxuRhy+Z3KwdtwMoQgS7B0kCx6dVk/v6tGakzYcBB5Lwkl46p+DeGQL+Nw9VybZs0SasfuxZHiNe3sGYlxAlktTUkgfDbTa4jLFwHVYUTPDT/QM7RCgFDA71JA3cFP2M9z9zE72Gi3pcMzbxWylBlAIFxD2e8j4aSlq+o0HniZgnJ4A78OdBXyLkI/uDDV1p66loTjiEQ3iz9XUo6gJceQnuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOEbb2hOuQ8QcLpHXwpSYSbqZGSw3LusDTwZMJ+uiJQ=;
 b=ceuogOX79364RbUgY7Fqd8EJB8W0nlNVzQ9F9sxQfzNCWTYoVjHAM5IhT9aAPeF61turqS7otzX8mT4oNdriQPqCIcBIHcAjzFbpyK1/K8I5CAIbPEWxyRbtdqAsUUDd8HYImbehfhUVFfJxgxf60LKC6BGVL2GjR6jSq3OMHd2pOuLTAWcsSCtRSXtYDznnTaLXK3gQVUKY3GI93eRtai6cV9eQbTcA8j0tZlZUMbSAl1yvoAZix747Kk1ZrfCSt+oigZCAayC2NsSJ3hyt2KnAXmXY2/hN5eIF1wTASGct0c8gB4+kkp2wOuDBqpr5IdDc3sP1paDCMS8S3talfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOEbb2hOuQ8QcLpHXwpSYSbqZGSw3LusDTwZMJ+uiJQ=;
 b=rHRMyySJUCmZdMbw0eGQbLDSfNrXZ3XkZoBS2PPtjYehWDbmUk7UJqYWI1SnMs86xDsu1LxpEdeY5bQI8CSfNVOng7jNKVGnB9V5VYyUk+4oISjCOt0gE7nlrBI6zBlznQ7HFNXZQ3w1PkuH4y17Mu3ukp9JSLA4F1TF61Qs4rY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31)
 by DM5PR12MB1883.namprd12.prod.outlook.com (2603:10b6:3:113::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 2 Sep
 2020 02:26:03 +0000
Received: from DM6PR12MB2938.namprd12.prod.outlook.com
 ([fe80::50a9:7a6b:e4a3:6569]) by DM6PR12MB2938.namprd12.prod.outlook.com
 ([fe80::50a9:7a6b:e4a3:6569%5]) with mapi id 15.20.3305.034; Wed, 2 Sep 2020
 02:26:03 +0000
From: "Changfeng.Zhu" <changfeng.zhu@amd.com>
To: amd-gfx@lists.freedesktop.org, Ray.Huang@amd.com, Bhawanpreet.Lakha@amd.com
Subject: [PATCH] drm/amdgpu: add ta firmware load in psp_v12_0 for renoir
Date: Wed,  2 Sep 2020 10:25:44 +0800
Message-Id: <20200902022544.24308-1-changfeng.zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR03CA0054.apcprd03.prod.outlook.com
 (2603:1096:202:17::24) To DM6PR12MB2938.namprd12.prod.outlook.com
 (2603:10b6:5:18a::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 HK2PR03CA0054.apcprd03.prod.outlook.com (2603:1096:202:17::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.5 via Frontend Transport; Wed, 2 Sep 2020 02:26:01 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 10eff02c-97b0-4da4-f233-08d84ee78a02
X-MS-TrafficTypeDiagnostic: DM5PR12MB1883:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB188372B730CAB143AA278AC4FD2F0@DM5PR12MB1883.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d+4O1eryfKVuD0fhtllxsRGCYKrDF+h/mUfcEAN3ZD3lJzqE9RPMY2APrDZz0MngoQI3KDi4tGCXcKZc8SDVyTcTaucJEJzzNdKZeqh9WhjcaV0G+YzDus+D+OltYM6lrzDY5S0XRSsmIFFEGJFLaUP6R5aFwVJiJ5XqrV3wyp7ZzD8rNILQ3SDs7kzclwM/GMB54m7rAHW2sFgdwXlmhGSSFEBh6LA6Gk3JpIPxOBugC9fx4Eyen8mmZGoPTeCkIdtbsmDTpPVKkbC1HIwckGgw1jGhZTWeesHH3H+hbV+siYBFMYvzXJZmY6nGl6hPb2spXDtH3C37Ty+xOLY9/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2938.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(66476007)(186003)(26005)(4326008)(16576012)(478600001)(36756003)(6486002)(86362001)(66556008)(6666004)(2906002)(1076003)(52116002)(66946007)(956004)(5660300002)(8936002)(83380400001)(316002)(6636002)(2616005)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: LaiGTgF3sHi2noK5kGaUxB9iafRazoWUGsrTIO1b8CWAVqaaSEXTOX8WDD0AC26/D5dX7Jn7TaR8+9urdSt1MmQIMnWCeTnU1X9KCL+CAEP0MVz69ON7XzdRB/Xx1oC9W8rLdPYakVaZWwb1j//WHsbZEc1qSdfae5EvxDYS80SkBuZenPi2L4621PqrJQDLieLLR6rsJKc1aR82AhJrVokF8UpzACaMxQ7fr9u0tV/sjkpkI3NU0+0SIeKHDdEfz/u3E7+zXU+UHo4wJ0MzuaiCoxcOxz1Q0mUvsD3maVN7IN47jYPI+p7V61KPcENlYxFMsH7l13q13CNgAtS4PTmliNbEmLolHAy1l8oB81YyTRa6qYV3FiCK0XA9KQtBp7JoE6PUB5PdSEUF0Au2a0VrdR8Pa74msRZLPYvZHtt6Eh37AGmZnlN6Z6wLCA9Y0pn7K85sqOplDpgoqKU9hbMkAWBVYSSa+Zoh8inGKS+VAm6B9B+gPNQt2riYx2myU5UYZs0S1jlrupv1giM54e2ZBt2qbmoVEgg5OiZPjHRnhpMfidzbFBfQNg7NVn8qdg7i0uXCpNlyC+YnYk4rwyuLEKK+RVGgjiMB28CrBkSRuBxzaYmbCBonJIMyeE5JZl9OrEleILc/5EPR8dDKBQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10eff02c-97b0-4da4-f233-08d84ee78a02
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2938.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 02:26:03.5654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUNNLZi1X0VW//frMteRK1dQqz3Fmw9dSq0CjB+ytSxzh5srHySF+flscFPr3ixPN9G1hXcF888FzaTyRbh15g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1883
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
Cc: changzhu <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: changzhu <Changfeng.Zhu@amd.com>

From: Changfeng <Changfeng.Zhu@amd.com>

It needs to load renoir_ta firmware because hdcp is enabled by default
for renoir now. This can avoid error:DTM TA is not initialized

Change-Id: Ib2f03a531013e4b432c2e9d4ec3dc021b4f8da7d
Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c | 54 ++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
index 6c9614f77d33..75489313dbad 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -38,6 +38,8 @@
 #include "oss/osssys_4_0_sh_mask.h"
 
 MODULE_FIRMWARE("amdgpu/renoir_asd.bin");
+MODULE_FIRMWARE("amdgpu/renoir_ta.bin");
+
 /* address block */
 #define smnMP1_FIRMWARE_FLAGS		0x3010024
 
@@ -45,7 +47,10 @@ static int psp_v12_0_init_microcode(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
 	const char *chip_name;
+	char fw_name[30];
 	int err = 0;
+	const struct ta_firmware_header_v1_0 *ta_hdr;
+	DRM_DEBUG("\n");
 
 	switch (adev->asic_type) {
 	case CHIP_RENOIR:
@@ -56,6 +61,55 @@ static int psp_v12_0_init_microcode(struct psp_context *psp)
 	}
 
 	err = psp_init_asd_microcode(psp, chip_name);
+	if (err)
+		goto out;
+
+	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ta.bin", chip_name);
+	err = request_firmware(&adev->psp.ta_fw, fw_name, adev->dev);
+	if (err) {
+		release_firmware(adev->psp.ta_fw);
+		adev->psp.ta_fw = NULL;
+		dev_info(adev->dev,
+			 "psp v12.0: Failed to load firmware \"%s\"\n",
+			 fw_name);
+	} else {
+		err = amdgpu_ucode_validate(adev->psp.ta_fw);
+		if (err)
+			goto out2;
+
+		ta_hdr = (const struct ta_firmware_header_v1_0 *)
+				 adev->psp.ta_fw->data;
+		adev->psp.ta_hdcp_ucode_version =
+			le32_to_cpu(ta_hdr->ta_hdcp_ucode_version);
+		adev->psp.ta_hdcp_ucode_size =
+			le32_to_cpu(ta_hdr->ta_hdcp_size_bytes);
+		adev->psp.ta_hdcp_start_addr =
+			(uint8_t *)ta_hdr +
+			le32_to_cpu(ta_hdr->header.ucode_array_offset_bytes);
+
+		adev->psp.ta_fw_version = le32_to_cpu(ta_hdr->header.ucode_version);
+
+		adev->psp.ta_dtm_ucode_version =
+			le32_to_cpu(ta_hdr->ta_dtm_ucode_version);
+		adev->psp.ta_dtm_ucode_size =
+			le32_to_cpu(ta_hdr->ta_dtm_size_bytes);
+		adev->psp.ta_dtm_start_addr =
+			(uint8_t *)adev->psp.ta_hdcp_start_addr +
+			le32_to_cpu(ta_hdr->ta_dtm_offset_bytes);
+	}
+
+	return 0;
+
+out2:
+	release_firmware(adev->psp.ta_fw);
+	adev->psp.ta_fw = NULL;
+out:
+	if (err) {
+		dev_err(adev->dev,
+			"psp v12.0: Failed to load firmware \"%s\"\n",
+			fw_name);
+	}
+
 	return err;
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
