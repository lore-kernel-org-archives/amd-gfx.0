Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660C9C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B29F2076E
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NPDK8Yap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B29F2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08C776E43A;
	Wed, 29 Jul 2020 02:57:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 907726E43A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 02:57:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNJzrqmQkMY56xekgu8EEAQVniUD2TAP7+wuHyzEVshnpefM6mSJn/h4fsi71Ux9+pK2Eo4zUSzMvMT01DfhQyaZDD2+NKP5Q4gBIrtWPeYKbIDdB1tUYbwF5owQX72/a2LUARCkM9IIbSLZkRk/XvJitFR9IYhROH7uzhfK320XaaVb9W8WM+X8jn8p9YPIBn24G28UZdlgPyDsPm+oWiFOWEZa9KTXI9H7RIVgluWUlSTVnFAyadmpRLTBy70i7Zv8FI11+Q6Dk4LOv7XWnHYbHL7BOxfTIp4+cVZ+8onzfswoZD0Ml0ZqPIXCNqD3+Qfe4wburnxQxp9b1eEyXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zj3tNRXCYZ/MM3m8rZBpm+0re3G4dc22krAjlTLLBfM=;
 b=JdWPW5KN3umlIsSUSnWaUlY+eFnK9aLW9nHgeFKS4h8VO5Kb6KNPGwvr5nhByuq3rE1wBbPZrtv5AUBLTtzPvIv7GrXMKE+ocPGPpuUwunQklNhiL/7flTtCqJ7L1573HIOVz4+kXKNfTXYYRCFi40BaMMCTv+QyoDvnBKzYMgY4kAk74RjmLVFCyQ1VgPvw7nSMg5pTpyVQ2+7DtTU4NHx3HF/FxC2+JGXRAPkKQJkfkFk6/zeHOgz9qVfmqUaEVDYUHmz9hQbQdxN8ekRxLZp8Pgq5aPcFS4+SD6TwNPcnBlh/16FwrJqgKKvJOpAKrujJgSB07wifv9yFbnlqJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zj3tNRXCYZ/MM3m8rZBpm+0re3G4dc22krAjlTLLBfM=;
 b=NPDK8Yap+TP0vOj/UEJ9BtllOYg4FAS14FNSiUorwIzgk1rDDn+naJIYaE2FPPj/fEsblQw65uIcIf/JW5ii+nRK1ljE5DPIcQeWknvODLpBefiG5SAF6xobZSQgMVtrFnM9ETpETTzGMSwcmjzFbaprB6do8d4rACZHeQ9HynI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1285.namprd12.prod.outlook.com (2603:10b6:903:3e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Wed, 29 Jul
 2020 02:57:14 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Wed, 29 Jul
 2020 02:57:14 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, andrey.grodzovsky@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com
Subject: [PATCH 07/12] drm/amdgpu: break GPU recovery once it's in bad state
Date: Wed, 29 Jul 2020 10:56:24 +0800
Message-Id: <20200729025629.19355-8-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729025629.19355-1-guchun.chen@amd.com>
References: <20200729025629.19355-1-guchun.chen@amd.com>
X-ClientProxiedBy: HK0PR01CA0066.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::30) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK0PR01CA0066.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Wed, 29 Jul 2020 02:57:11 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8dd3bbc3-0e1f-45ce-5252-08d8336b18a1
X-MS-TrafficTypeDiagnostic: CY4PR12MB1285:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB128508A9E77192E230FD5374F1700@CY4PR12MB1285.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E0lKSA5AaTVV5cAppTVn/09nkNUom5gko7NLpYRBXVJzS8jyLkJmF/pcS6Ayb9mphytGax+K12Yq2I1bD4kEKj0c+eAgLQPHvrN8KbVUFvFr8IlVPtakkQB9p0yP3V0MyJH7llSI+UumhnO8Gc1bLHkVzT01aUstp3bRKxchVxZh3BAthKH45JwMwEyQQh7NKKW1R305wC4hueIi3Hiu6DzRek49WBkTagdDKu894BUk8iDxpcftuwZFaTZiDE/BfsQh1TdGmvHs0yLlgoDwJxoTSmAxvlsXpkXXZIpTZnyNvTAssjJYDqOYWo/OaEty27xIJ6xX12GQ1J/fBtBCfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(26005)(2906002)(66946007)(6636002)(52116002)(66556008)(8676002)(86362001)(66476007)(186003)(7696005)(16526019)(6666004)(44832011)(36756003)(5660300002)(4326008)(1076003)(316002)(8936002)(956004)(83380400001)(6486002)(478600001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: CM21gmp16SHoNjhqT8rMHWm8M/aatUDm+HY9DsMdzBPAvN0mSWueEjPtwTgaIJ9k8OndY3BI6XOi0rRcSJjefsm5Uc8iCtpZJVb472B5CeePPJwhVDIiVu7Fnhn4r+2H1jkxgSmcGPGI/J+0OKcYOds8VQYUBWhGi3QJAL66YKnYy8TT+UdmeivIctDJbpd2F822N7b9/2IZ1eH/FRS/whjSI247xyt65sfoiakJCrqfC6JOxgLTi7Ssu4uSarekLIjHcdVXow+YpOJGlAVQ9QoZnB61riUdFBSQAHPfAgdWI4zueu6RrBackskVrqYM+N9uAPzP3QFKfzNatfoZVo91f0eY+rKylQToORKkSgyz8B2yRDhk1zw/1Q3tUoHjdlz1sxeCMBgtRQpEMUEZtgrVlV+j88lpun5B30lUJdfdscurGtKP9S4dxeYuetYIQGTaqRxnSllfP53Gjwsu/llT/1tBVTZAKC9AWFE6KKOOqFfTAiheZ7H7ug3rapEJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd3bbc3-0e1f-45ce-5252-08d8336b18a1
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 02:57:14.3296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: boAyZSwdiAMJMVnUyQdVOH7wuzWZxRRiXMuq0co2HIvEUJ87xTOcSG1s4Bm47ttTcvKCOaCXd4gvFqYHhge4Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1285
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
from external eerpom device, the recovery will be broken
and error message is printed as well for user's awareness.

v2: Refine warning message in threshold reaching case, and
    fix spelling typo.

v3: Fix explicit calling of bad gpu.

v4: Rename function names.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 20 ++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 16 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  2 +
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 40 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  4 ++
 5 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 30af0dfee1a1..c893d9adbab7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4139,8 +4139,23 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 
 				amdgpu_fbdev_set_suspend(tmp_adev, 0);
 
-				/* must succeed. */
-				amdgpu_ras_resume(tmp_adev);
+				/*
+				 * The GPU enters bad state once faulty pages
+				 * by ECC has reached the threshold, and ras
+				 * recovery is scheduled next. So add one check
+				 * here to break recovery if it indeed exceeds
+				 * bad page threshold, and remind user to
+				 * retire this GPU or setting one bigger
+				 * bad_page_threshold value to fix this once
+				 * probing driver again.
+				 */
+				if (!amdgpu_ras_check_err_threshold(tmp_adev)) {
+					/* must succeed. */
+					amdgpu_ras_resume(tmp_adev);
+				} else {
+					r = -EINVAL;
+					goto out;
+				}
 
 				/* Update PSP FW topology after reset */
 				if (hive && tmp_adev->gmc.xgmi.num_physical_nodes > 1)
@@ -4148,7 +4163,6 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 			}
 		}
 
-
 out:
 		if (!r) {
 			amdgpu_irq_gpu_reset_resume_helper(tmp_adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 64ae0742f385..fab6f8d6bee6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2206,3 +2206,19 @@ bool amdgpu_ras_need_emergency_restart(struct amdgpu_device *adev)
 
 	return false;
 }
+
+bool amdgpu_ras_check_err_threshold(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	bool exc_err_limit = false;
+
+	if (con && (amdgpu_bad_page_threshold != 0))
+		amdgpu_ras_eeprom_check_err_threshold(&con->eeprom_control,
+						&exc_err_limit);
+
+	/*
+	 * We are only interested in variable exc_err_limit,
+	 * as it says if GPU is in bad state or not.
+	 */
+	return exc_err_limit;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index cf9f60202334..70a6fca73617 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -497,6 +497,8 @@ void amdgpu_ras_suspend(struct amdgpu_device *adev);
 unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
 		bool is_ce);
 
+bool amdgpu_ras_check_err_threshold(struct amdgpu_device *adev);
+
 /* error handling functions */
 int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 		struct eeprom_table_record *bps, int pages);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index d24bf65f6dd7..be895dc2d739 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -386,6 +386,46 @@ static uint32_t __correct_eeprom_dest_address(uint32_t curr_address)
 	return curr_address;
 }
 
+int amdgpu_ras_eeprom_check_err_threshold(
+				struct amdgpu_ras_eeprom_control *control,
+				bool *exceed_err_limit)
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
+	*exceed_err_limit = false;
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
+		dev_warn(adev->dev, "This GPU is in BAD status.");
+		dev_warn(adev->dev, "Please retire it or setting one bigger "
+				"threshold value when reloading driver.\n");
+		*exceed_err_limit = true;
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
index f245b96d9599..f29fafea5392 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -81,6 +81,10 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 			bool *exceed_err_limit);
 int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control);
 
+int amdgpu_ras_eeprom_check_err_threshold(
+				struct amdgpu_ras_eeprom_control *control,
+				bool *exceed_err_limit);
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
