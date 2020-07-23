Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071E9C433EB
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 08:34:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE1A72084D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 08:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1uXrfGE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1A72084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0D856E86A;
	Thu, 23 Jul 2020 08:34:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBA676E86A
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 08:34:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Squ05r2nTlV9vANxi8Aej00EAduvDH16c/tRz28tNf5fqfC6YY4Gba1TGk2U0+9OIBhoDtmY4OrHTQev3GkMsM1GDENPRw50Wb12OKdvnAgxncv3DpO53uTakoYwuobMyO782iX8EIuFfRGQgOizYIAfMd99nKjCP2gvCUTf4xrwNumbe6UaqA/yF8lKS6WEicsqZm5YL1ky5vw2NF6VkhrDf/cJe5bUaiIar0T64LkDmyMK5oEEj5xw7HkZxOYzYFXdO7VpgfINRmYsKLPCqWZegraHie93Ma2/NNkkmUR9YPZ+vaJ8IE6y+G6BDFQKhjtIRDpRLIJ9bzSVYYsBUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzzR3KkUxXP27u/sdaUnOaAbImjTFmp8V5uL5cML000=;
 b=DSmfC3QoB9f+xd0jVRFBCjEGGClwf2//m+kViP6PviqLibhKsNVPGDmMvLzzEDSAh/gdF/oHPxqQPiaW8eJSHw/trUz9E90MBioYO5j7bGiRwDXb3be3btEbzC0sVGY5sd+/mKE6alziQol4OjHdfpgasv3m2jhgoi6ZafCCNbLUC5w+REcK+IfMXVXnIOXR3MIn2tGphF4eIwKHCg3IMEzTAxXDZR2makM6nUgJddzJBaJgm0ZUhl15srdZRT5TUqtSE/4z2K6aJb9BLKW/xknnWuo13BQu6bH0201aUcKMUM5cZ1dGZQ38hbjWX5b0VsgAwJ8DTkrgnqUfyWcwFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzzR3KkUxXP27u/sdaUnOaAbImjTFmp8V5uL5cML000=;
 b=1uXrfGE1LdSHWamsnG1EA+22g3b2s2FvphZ/5sZW0SRpHOY85cJt9X+ljz3OXoiduUoWhOE18j5LWYuUcsfU5eLrfFTBGiYUe2TCvrIeKtvL46bCu9FocCSy/bgcXmsUfTIpc9FTlt7y1ijyb6jn9MopNSTLrOOzfUZT0bhg/xs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0119.namprd12.prod.outlook.com (2603:10b6:910:1e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Thu, 23 Jul
 2020 08:34:30 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.024; Thu, 23 Jul
 2020 08:34:30 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, Stanley.Yang@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com
Subject: [PATCH 7/9] drm/amdgpu: break GPU recovery once it's bad
Date: Thu, 23 Jul 2020 16:33:44 +0800
Message-Id: <20200723083346.8743-8-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723083346.8743-1-guchun.chen@amd.com>
References: <20200723083346.8743-1-guchun.chen@amd.com>
X-ClientProxiedBy: HK0PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:203:b0::21) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK0PR03CA0105.apcprd03.prod.outlook.com (2603:1096:203:b0::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Thu, 23 Jul 2020 08:34:26 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e88f1b27-c557-4e4c-289d-08d82ee33770
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0119:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB011900DAC53E166C4988F587F1760@CY4PR1201MB0119.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r4YRTUuCxWV8Lg+ZYGz8mnfHKLvumpGsNJv3OVEVdIG/hLTX08ec/9yUSjRvRACo35d8fJ4UihAMOnRZS7X3RKyCGYkJ9169PDBV9vCwd8YvaUJt6xLUCSvUKx//olcBLlBukKkW2JopYUkMG9X4QTeQDoDJzVyQpxqwHspS9i2mMLSsDH52pY46cAxpQNXnxMbX9d7oGTF7Zl079lY6++0itguFjaZE88A3djgjAkzkJcNllqyutMKtF4sML8ZaU1a5tbSTu7vyuZ4UVerl+Lbd3EySj+d2lEnWr9CaYHc8wPhMIwTfT0WfBKQUejYnopaC2/crY5MFaJJJAC0MXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(478600001)(2906002)(86362001)(52116002)(7696005)(6666004)(6486002)(6636002)(8676002)(5660300002)(4326008)(8936002)(316002)(83380400001)(36756003)(66946007)(66556008)(66476007)(956004)(2616005)(26005)(1076003)(186003)(44832011)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: BA4+WQ4WCUHjKu6QuhzIk2IHAGy0obUeaKjWDfSgQV8cwToLrZhmwOB4GNo0Vb8I9jgI6OWvvqRdM73+ZQ/DAL6niqwK6QPXiug1xn+BgXzclIDDjZFNoCreg1ywKUn9736Wj84h2aibZHEa+KxR5XZWSecGAwyXgA3eIqTPCkDTjCjksitYE3vx/Cgts5h5OZuWALlESbtb2NrvytnhxyAcUhoB7aA3fPsmtyS1pK/DeVoVBuoNYdcy5n/UCUgFbKoj5e3gYd9bXEjmXAOd8roPsTWA815zzu5l0XVVxKSuRwq3ZKSICQ1vCgLFXR+lC6JPHZVTWSCLtWFQdj7B348BjUrTd8gBQ3SS7hqZ4G1DKBqpfK4f7tkaQ6vcUtPl3zj1CUSGJQDPNZErWJYnGXey2ii0KgENoOC3L4bLvcXXC/PtrBM//UA1FUqMCZT5iGUDlhV1vWCIskjYuDBtiYvWrgxcOMMi82aQI99u67EZU06JoxUFQh54abMhhiEu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88f1b27-c557-4e4c-289d-08d82ee33770
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 08:34:29.9294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yx6TiJBL6OYRpNmUcP365hLX2i6AIYHrRhsmq1ek8y2Dn33SyzaUDGkwlXPrvYYTLTMbcMVrSgDmE+EwSDydug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0119
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When GPU executes recovery and retriving bad GPU tag
from external eerpom device, the recovery will be stopped
and print GPU retirement message for user's awareness.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 17 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 13 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  2 +
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 43 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  3 ++
 5 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 882f8a0964a5..771c4e6b7a0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4139,8 +4139,20 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 
 				amdgpu_fbdev_set_suspend(tmp_adev, 0);
 
-				/* must succeed. */
-				amdgpu_ras_resume(tmp_adev);
+				/*
+				 * The CPU is BAD once faulty pages by ECC has
+				 * reached the threshold, and ras recovery is
+				 * scheduled. So add one check here to break
+				 * recovery if it's one BAD GPU, and remind
+				 * user to retire this GPU.
+				 */
+				if (!amdgpu_ras_check_bad_gpu(tmp_adev)) {
+					/* must succeed. */
+					amdgpu_ras_resume(tmp_adev);
+				} else {
+					r = -EINVAL;
+					goto out;
+				}
 
 				/* Update PSP FW topology after reset */
 				if (hive && tmp_adev->gmc.xgmi.num_physical_nodes > 1)
@@ -4148,7 +4160,6 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 			}
 		}
 
-
 out:
 		if (!r) {
 			amdgpu_irq_gpu_reset_resume_helper(tmp_adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 4c86c7a64bcc..acb8231f2052 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2200,3 +2200,16 @@ bool amdgpu_ras_need_emergency_restart(struct amdgpu_device *adev)
 
 	return false;
 }
+
+bool amdgpu_ras_check_bad_gpu(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	bool bad_gpu = false;
+
+	if (con && (con->bad_page_cnt_threshold != 0xFFFFFFFF))
+		amdgpu_ras_eeprom_check_bad_gpu(&con->eeprom_control,
+						&bad_gpu);
+
+	/* We are only interested in variable bad_gpu. */
+	return bad_gpu;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index cf9f60202334..95918d355fa9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -497,6 +497,8 @@ void amdgpu_ras_suspend(struct amdgpu_device *adev);
 unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
 		bool is_ce);
 
+bool amdgpu_ras_check_bad_gpu(struct amdgpu_device *adev);
+
 /* error handling functions */
 int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 		struct eeprom_table_record *bps, int pages);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 0cd594c74bff..d27cd5ae431a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -387,6 +387,49 @@ static uint32_t __correct_eeprom_dest_address(uint32_t curr_address)
 	return curr_address;
 }
 
+int amdgpu_ras_eeprom_check_bad_gpu(struct amdgpu_ras_eeprom_control *control,
+				bool *bad_gpu)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(control);
+	unsigned char buff[EEPROM_ADDRESS_SIZE +
+			EEPROM_TABLE_HEADER_SIZE] = { 0 };
+	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
+	struct i2c_msg msg = {
+			.addr = control->i2c_address,
+			.flags = I2C_M_RD,
+			.len = EEPROM_ADDRESS_SIZE + EEPROM_TABLE_HEADER_SIZE,
+			.buf = buff,
+	};
+	int ret;
+
+	*bad_gpu = false;
+
+	/* read EEPROM table header */
+	mutex_lock(&control->tbl_mutex);
+	ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
+	if (ret < 1) {
+		dev_err(adev->dev, "Failed to read EEPROM table header.\n");
+		goto err;
+	}
+
+	__decode_table_header_from_buff(hdr, &buff[2]);
+
+	if (hdr->header == EEPROM_TABLE_HDR_BAD) {
+		dev_warn(adev->dev, "Current GPU is BAD and should be retired.\n");
+		*bad_gpu = true;
+	}
+	__decode_table_header_from_buff(hdr, &buff[2]);
+
+	if (hdr->header == EEPROM_TABLE_HDR_BAD) {
+		dev_warn(adev->dev, "Current GPU is BAD and should be retired.\n");
+		*bad_gpu = true;
+	}
+
+err:
+	mutex_unlock(&control->tbl_mutex);
+	return 0;
+}
+
 int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
 					    struct eeprom_table_record *records,
 					    bool write,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index a2de243da31d..82757c88db9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -81,6 +81,9 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 			bool *bad_gpu);
 int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control);
 
+int amdgpu_ras_eeprom_check_bad_gpu(struct amdgpu_ras_eeprom_control *control,
+				bool *bad_gpu);
+
 int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
 					    struct eeprom_table_record *records,
 					    bool write,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
