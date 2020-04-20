Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237DCC3815B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 10:17:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8CEC21744
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 10:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cKxU1q7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8CEC21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2AC26E4F1;
	Mon, 20 Apr 2020 10:17:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA00F6E4F1
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 10:17:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OViMvbejVaEceUMeoPVTXoBZEP1AbqnGSi3Pm9HRCEjbbZO4LrQPGTbxSBToGMcAN+/itMIwrCSCnNy9Yb8NQbUMP57HXCwEkCOQH9pf1Hnwr62BTObDadwm8JItoGPTCjjgUkPP0EIdWl9Jrw/K1lg7mRQERc0koyjuQcvzO7JvzKWsfNGM3wbmcbjDRP0qUcGlXI9al+LjWBOcVwdf67mwTHpRjumbvt+xH1JM2VuosOIkHMW9wWDUpsozcjsfG+gNoC7OIT55/HqjK5ffnrHMqmBYfx0Mueqczsg88jGA8z0F4cqIc0BejmMp1yxCxmKrpzNAgbm5FCGXClnpgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VNwQpDMuu2naUKQm0CIKyzHE78AuCedaFpTp1jZEPQ=;
 b=bW+Sp9psbjRgScf5/fFEVKyjRCNw9JgH/RDk85YQDFLfW77CeD6gdykDtNgv1Tmeo8nknqYYgkAVusmmKZAl53FQoIDVfhdrYu1wp83qovjTnrBmo+70PNiMF95v+UNL3THPQSmmCFvsZv3Uff+xOJQyJwog07N6urVEuj9nbikZT7rsYfXD99ULwIMwO8pcHFrjepUGL5cuqG2c0ELqA25KIzpqk4Id9sp3XCt9TUUsV0tDm3ULvqn7jdt/uNi9cIS8q2P3XasE5QUtO2KwhRpDiSpinev/hpUWWkSaYI9E7NMYk/8BnS92l3S8wxh35kY6bzkoRgesHbHz25sSAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VNwQpDMuu2naUKQm0CIKyzHE78AuCedaFpTp1jZEPQ=;
 b=cKxU1q7aYpbGzbSk3LVQYnHRe7xDKimDb7GkawIGSqNQbDcpyHPziNO3XMcFuaQBZfJiWDxpS8NP9aPigNhPNMypZoB0Wfuvcg0DAefcjpp0lRkoglteeeZj2sxB3L6N2HoRh8yulI42UJUZPyv8YXuJKp5LuTUKbt/rfl7Kfys=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3225.namprd12.prod.outlook.com (2603:10b6:5:188::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25; Mon, 20 Apr 2020 10:17:25 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 10:17:25 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 John Clements <john.clements@amd.com>, Guchun Chen <Guchun.Chen@amd.com>
Subject: [PATCH 4/8] drm/amdgpu: add helper function to init asd ucode
Date: Mon, 20 Apr 2020 18:16:40 +0800
Message-Id: <1587377804-3836-5-git-send-email-Hawking.Zhang@amd.com>
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
 15.20.2937.6 via Frontend Transport; Mon, 20 Apr 2020 10:17:23 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e207bc83-95bb-46a0-5036-08d7e514059c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3225:|DM6PR12MB3225:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB322505086448687B7C3E674FFCD40@DM6PR12MB3225.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
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
X-Microsoft-Antispam-Message-Info: +7LQr0w3g0I5Qhcusi1rHudKbG1EEALg9PTX3SzPGGzX/hfS1qAj85/UsBqYcnoDJKlsuU2yXtP207gG2e2ibhxwPuFLW1Q1Debzl6bc/6bnKh79nog31xqShEMjA3KyIKTGwR66kHxZt+U6bUGRCdhIgXCp2ispXyJbf/54G2IfZfO630asrW9Uok/dGBDOnPtUbHOKpgnr9dss3pl48lrQaACNUMSGTlL2xV15oPaGJgwm3zt7CR0OacXxDkcRBt6uziH4AekmBSVJHw6M6iVXK+pOFs+rRiFA/TuumWOvUPIO0nkvJjjlsl9YBbZOMvAk3v9pqnyplbNAm2uj6rdAg2jIzni8eEKlMT2eN+0ZQz1LqXmdvkPQoieNdB3WcSPyNnrssnn8MT0f1Yqibvz4LeATtNGc+P33/5DjcOut0XXxvWIJsLlsZLOe171A
X-MS-Exchange-AntiSpam-MessageData: lfrvBIHxZa9QzwCWKKpso/6y0ILZH9sC3WyDvcpN1Nle1VKCdKkvgsAX0RbQwJ4RTe6wdVg3jUe7uel6jntqz9JU3feQl8v3iO6CRb/CFo7gv5rnIuI0DYnxBmc5vWFszz6KbRMAODlWd/+H2MtUng==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e207bc83-95bb-46a0-5036-08d7e514059c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 10:17:25.4781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcPACYs4V0aWBcvHMbur+QrRBAuCkXIUI4DsH44Gniu74OXnMH5DDViArUqPPj1QcwXAjF4Kfmbu1vy3MkTSKQ==
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

asd is unified ucode across asic. it is not necessary
to keep its software structure to be ip specific one

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 36 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 ++
 2 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 7797065..3656068 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1840,6 +1840,42 @@ int psp_ring_cmd_submit(struct psp_context *psp,
 	return 0;
 }
 
+int psp_init_asd_microcode(struct psp_context *psp,
+			   const char *chip_name)
+{
+	struct amdgpu_device *adev = psp->adev;
+	char fw_name[30];
+	const struct psp_firmware_header_v1_0 *asd_hdr;
+	int err = 0;
+
+	if (!chip_name) {
+		dev_err(adev->dev, "invalid chip name for asd microcode\n");
+		return -EINVAL;
+	}
+
+	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_asd.bin", chip_name);
+	err = request_firmware(&adev->psp.asd_fw, fw_name, adev->dev);
+	if (err)
+		goto out;
+
+	err = amdgpu_ucode_validate(adev->psp.asd_fw);
+	if (err)
+		goto out;
+
+	asd_hdr = (const struct psp_firmware_header_v1_0 *)adev->psp.asd_fw->data;
+	adev->psp.asd_fw_version = le32_to_cpu(asd_hdr->header.ucode_version);
+	adev->psp.asd_feature_version = le32_to_cpu(asd_hdr->ucode_feature_version);
+	adev->psp.asd_ucode_size = le32_to_cpu(asd_hdr->header.ucode_size_bytes);
+	adev->psp.asd_start_addr = (uint8_t *)asd_hdr +
+				le32_to_cpu(asd_hdr->header.ucode_array_offset_bytes);
+	return 0;
+out:
+	dev_err(adev->dev, "fail to initialize asd microcode\n");
+	release_firmware(adev->psp.asd_fw);
+	adev->psp.asd_fw = NULL;
+	return err;
+}
+
 static int psp_set_clockgating_state(void *handle,
 				     enum amd_clockgating_state state)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index f8b1f03..a763148 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -385,4 +385,6 @@ int psp_ring_cmd_submit(struct psp_context *psp,
 			uint64_t cmd_buf_mc_addr,
 			uint64_t fence_mc_addr,
 			int index);
+int psp_init_asd_microcode(struct psp_context *psp,
+			   const char *chip_name);
 #endif
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
