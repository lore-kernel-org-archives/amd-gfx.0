Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EE3C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:50:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E87B20714
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="voOkMJOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E87B20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 676456E21E;
	Tue, 28 Jul 2020 07:50:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C9B26E21E
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 07:50:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnUwhCHJME1TVlgiqTwgx0QXQrzq/N+c7Xj/3lyj5cIR5gwn2SzcyuQod9UIT5QSHPJaNu1Ox2pE8175Vn/Vh7KoW7xrczzOqmHyT2KcUI4XlXzGF9vbigpnRsl22wudTVdWaIVW/Q33qxGIZSzLLJFX6arvxr5W1FPOfEA9MJZNY3UE1N6OK3dU1hGHof0CTMOI2duqTMP/IxWYA6TMU1+nk87dPv2/jalTio09MfH6J57JIMRA8zXoNZZOdUZdsugWwf/7aOk/+p9j4SCj+y0bnKlDCLCpjOUi4Dqi70ROsd8dSmV8lJCxLOLetkXkuBMWpNDbQwvrmV73JVxUrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yi+sRLE1xGo5dFmeHTm/jQT49xouAWAum0AZGFynPv0=;
 b=dKpEkbZfxkjS8xIxkRR/pwHytPRHxIztp6Fkaz8DXHpBP4ublboUZ1ohmEcqMXOjdziIP3vgibchfemtw/APLIX/evNPBfWfxf+FmLrK7d6WaJ8w6yU5kWomRmOH4TKZe4YXuradmegOHsk1kR96gDo3hZr8A6vUmAILNjfpQ+KycswfGHosHdcGh8YLi3/IgXg7j84ovOBCV6Oq040yGUJkLoEuKoxGRihKHzOTi4LK+lmyLb/MSxdoby9FL89ChMcdNWfcdpkYSSN+24MXQnLnqpIfMMLmq8jdHEa7j/XS+roLEo37KXYt9a+QBbskgod1wxj+4uyrrtHrEOu2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yi+sRLE1xGo5dFmeHTm/jQT49xouAWAum0AZGFynPv0=;
 b=voOkMJOzYe/akSEgZnhIKbbHhnDEpV1WWptjqd4nABMe2MOK96QcskVLAR14bG9cuO52SS/dnxn1jGV7dR08LWBrXkltdT+SjnHpVny3OdwARUMV4KQZPQ4SiLsgLbp1FSsPpc+y1Qx8NpWe8b4IB1p6e7sByO1fKG1OGhI2V2w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1752.namprd12.prod.outlook.com (2603:10b6:903:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 07:50:18 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Tue, 28 Jul
 2020 07:50:18 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, andrey.grodzovsky@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com, stanley.yang@amd.com
Subject: [PATCH 07/12] drm/amdgpu: break GPU recovery once it's in bad state
Date: Tue, 28 Jul 2020 15:49:29 +0800
Message-Id: <20200728074934.12490-8-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728074934.12490-1-guchun.chen@amd.com>
References: <20200728074934.12490-1-guchun.chen@amd.com>
X-ClientProxiedBy: HKAPR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:203:c8::9) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HKAPR03CA0004.apcprd03.prod.outlook.com (2603:1096:203:c8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.9 via Frontend Transport; Tue, 28 Jul 2020 07:50:15 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e7f1dc7c-ba78-4014-61b9-08d832cadf16
X-MS-TrafficTypeDiagnostic: CY4PR12MB1752:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB17527054308EC9651570C748F1730@CY4PR12MB1752.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wr6EBg5h/e+b+oJh43cGbeYfJa3dTBaiRSRn1RO57nkEpNj2C1MXv3nTjGiSOxf6mG+lma+cEsl6hVCD5uClf0VnCzk+cIK3AD/h2XHgA+KryfrHbg1dsZSSk2ryfvYE4O1WZj2dvMOXubuANaphqiEs42SCwIcVTAmYr6Ik/PJpkdGGj+1bi44hOVYJn+RuaRv/Kb2oP55WmMTjZsWBuynDNIde03pFEW9rpi1Ia4o+bqoG/Ky33DpTeNs2fwnjR5/t28amOpb3uej3dZidajIPhshqX7bxhkzKajxpzccS2bYvu/AARx/66UfZYz702kahThs6d2Y+af0K8PF5SKon1TRMDadwuXX9w77hl6DAHdlUmjzwowC4/gVBBvO/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(2906002)(956004)(2616005)(1076003)(6486002)(66476007)(66556008)(4326008)(6636002)(66946007)(52116002)(478600001)(36756003)(44832011)(86362001)(83380400001)(316002)(6666004)(16526019)(186003)(26005)(5660300002)(7696005)(8936002)(8676002)(921003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: kbxWvgwUuf0o1nNKOkeUocGrjyPBxuvhvG8B7LeTQ/iAEqmVYjyk83c6GS4PdixCZwZesyo/tT1v9NBS2w+wsv0HP//XWoxIaM8omXlkY5FYfetgX4z3R7Dhy7MBtE0aNe8vF0v0LJfelvEe8N9Ugj5BlRUKH9G5yzbs0fl0sphJyzosO4DQaIj4CmZJaDuoQ/oThuUqPlMViht7Jx06SZ7GTgGoNag7KzvhcsewytiV4uKM7EhEcUmD+KjNanW3fMkDGINRm5qz7/0ZrREHZBOoas14Isv0PfYbdaCQQNJulJPZs/w/hvHl7AYUDQ7Czlkm/BAws+EohIw/GdE//3/Zs0Rb4JRzU0v7X2wZXOjgod2VQjY7C95s7qFwHLiS/B5sxHyvPe0UiqTKBHBOyDnofzZE+uRZZUaV0BV3P7US8NM1lRasmSNRC4MCW0r6KJCvnfJPs9QnC4ob8OTi2a1H4n99AgDQgK7s+0ZgDwnCokQjcvI2cY1+zJJiDe3J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f1dc7c-ba78-4014-61b9-08d832cadf16
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 07:50:18.3242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vN16JrAcM2MmER+M6YjJ6A2cVkFSejC2ODZu4WVHiBSuC8gU7aq+hKzG4fCCDTkW6DCYaQ2iCC4dVQtYBjxNiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1752
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
index 3c4b9127660d..dcb84f2ca078 100644
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
