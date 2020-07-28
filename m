Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C41C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:50:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BAC820714
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q8wbEU1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BAC820714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ABBF6E219;
	Tue, 28 Jul 2020 07:50:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC5316E21D
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 07:50:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hl7fHkCr5BLnW45HRzkGIDd/4m7ROKhy6R3sZTZwQBdMChIIeGH4NTPKln6ZNGlecEyQ1H+wq/YlkXkzmKUrgKj0VfKIDJDNLiDSr4zrEOh3UIW6tmwfMioUGNVn7h8nM+cs65eIgka9ic5wHrrLNF60a+OOVh41718RPY8RzRukEgcoENRTJtNMX/Oi+sMTkgGEIDo8OzztSCpY/+Sj4lw3VA73oTHjpOh5pL8Outi96h5S4l2Olu00rATT+88zhC/kOMsG7B/dC3TnfytuEJV8NM5qS/hSW+czbXs6Iqy1Kcm8RJ4wqjp1xMo4/a2/UU/WQR9/eOoJ+o63KWzhBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1D6tvSHd4cW6GEDfsiOAmMdcRDLUFnYAfEdkwddn94=;
 b=OXSSbH8jAa3UvEju3ONLQYwuubdd5SvkjyV5Lqoz+e9g8QAuL7w41pAVGFAVu/uHjhGLJTWD+p/CpZm7XYNoikP4T9XGbAx846Ve6rS1zGex5kTclbKummJzSz584Pt49MVzLC7gBEvZVdJ7TY87Us3Ko6/2SswSaupQ04N2oyJBBkbuOagIoy9B/ie/GDGZLa7f9MaqOYgnXxFXRzRHljxWGBjpSKaq9ffivxFYMHwVWveXzWScSHhakDQxsVUnOwechUe7qV+t4kt24ME2H+IGDja97USWeGJ48+/jwkMKTYCiNEyvNBiLYsKpSO/M3vVF+fExfyQf4F/X6hLY4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1D6tvSHd4cW6GEDfsiOAmMdcRDLUFnYAfEdkwddn94=;
 b=q8wbEU1kMrdExJ0z7Skzc8ELEVT1N0WQiTH6o1/0m+e2KZoSIjd05S8AvV1NR6aTKd4UTtPbFpCA2xD5ZUOQ5qPH/l7EzcD/LCGcewABSFl5cw6oozjgVK6gWRCDEkx6m02n+UYrBWU+bL7IJh3Go6+uncrWcro9BIR2HXkqchg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1752.namprd12.prod.outlook.com (2603:10b6:903:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 07:50:15 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Tue, 28 Jul
 2020 07:50:15 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, andrey.grodzovsky@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com, stanley.yang@amd.com
Subject: [PATCH 06/12] drm/amdgpu: schedule ras recovery when reaching bad
 page threshold
Date: Tue, 28 Jul 2020 15:49:28 +0800
Message-Id: <20200728074934.12490-7-guchun.chen@amd.com>
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
 15.20.3239.9 via Frontend Transport; Tue, 28 Jul 2020 07:50:11 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c73e5b65-bf53-48ed-6d39-08d832cadd10
X-MS-TrafficTypeDiagnostic: CY4PR12MB1752:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB175276550837E6844926EB74F1730@CY4PR12MB1752.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MOSaPmXbdDqB4VubHXBLG6ofAVY4MqQQ3Weeq3a0xQcs8xRZGfWJDwf3sm9RPMgID5XWWTp79G8gi4oJD708YSMdwZ6vMHn0raH/Wi9GeWDcaXv2bY21tsKuC7aakNGi6DIVCOC1zUZ9R7ru+EuZnu55VX4WdCiqITVm7mJfHb9iT5JLiTDs7CTbg3ySCBsm5eIyw4cLAXit1eigRpJM5HKMpfoF9uf6YRDymYoV0/RO2nPdaYKInYXU+shqK+xsl2peAQZAD0WP3361RrbJnJeBR6SHAZHmXnxTh94HKDjBNWGsp6MchFdmMWObIGbLpd88tDKC5wxm6v4sNeW/oro4S/Ef6PBVi4Ng5To9SbSzFhXxgqFLItXX9ERe0HFm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(2906002)(956004)(2616005)(1076003)(6486002)(66476007)(66556008)(4326008)(6636002)(66946007)(52116002)(478600001)(36756003)(44832011)(86362001)(83380400001)(316002)(6666004)(16526019)(186003)(26005)(5660300002)(7696005)(8936002)(8676002)(921003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: LfoaYJ+ANSVjM+2QKQLT2/a4vBmARWInb4Rpn1G55Z/BUqHHnHAYOqEGg1DsrM7ZJQI5WafeFcX5cBASaleumCyd/EFPKSh3aQw2lMpapG49GyQX0H+5UsFFGBgcVIbhRxhNSZ8kxZfa86NCyCt9rCtkcrLVXvP42tzfAJpNxbaYvLlz7nlD3AS0XPaXFfRJ1vEGdZr2DC37VYf3d3rb6L8SFmwCSH/O3+LPB4a68qOKZ1/QsTrEB1YEyIzCWbJxFob5mDpQlHUhHlkTIk0rqmM26boWjS3u5Kww1gULKzyDHrycsjNqifU3VsQTGEI1/O67A7GcPyhKeowz3gEEOz12M3HFD1jp8TCUKZAKAtMt+ugqeou1AwnOzqhXmZZLP97GqypjJrRyXB1dQx/Z4diSXwEqdnnM4I+3YQnE3D+OnScnObpX9M2AIKE7Jq54+x9JeKe4OFKtrniAzenR2S/RuGtd2Wd2mYZ/BDNoj5c7U27jb/eKDOn/Zz8TgDsY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c73e5b65-bf53-48ed-6d39-08d832cadd10
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 07:50:14.8808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2wysui5CrPnAnaDJ6NYXhD4a1V8A45PXnNXztRVCd4SznXjbt3L4+4TWBwO+wPSN4VLVeQcoccGlPiiproHng==
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

Once the bad page saved to eeprom reaches the configured
threshold, ras recovery will be issued to notify user.

v2: Fix spelling typo.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 37 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 67995b66d7d4..d24bf65f6dd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -394,8 +394,10 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
 	int i, ret = 0;
 	struct i2c_msg *msgs, *msg;
 	unsigned char *buffs, *buff;
+	bool sched_ras_recovery = false;
 	struct eeprom_table_record *record;
 	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
 	if (adev->asic_type != CHIP_VEGA20 && adev->asic_type != CHIP_ARCTURUS)
 		return 0;
@@ -413,11 +415,30 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
 		goto free_buff;
 	}
 
+	/*
+	 * If saved bad pages number exceeds the bad page threshold for
+	 * the whole VRAM, update table header to mark the BAD GPU tag
+	 * and schedule one ras recovery after eeprom write is done,
+	 * this can avoid the missing for latest records.
+	 *
+	 * This new header will be picked up and checked in the bootup
+	 * by ras recovery, which may break bootup process to notify
+	 * user this GPU is in bad state and to retire such GPU for
+	 * further check.
+	 */
+	if (write && (amdgpu_bad_page_threshold != 0) &&
+		((control->num_recs + num) >= ras->bad_page_cnt_threshold)) {
+		dev_warn(adev->dev,
+			"Saved bad pages(%d) reaches threshold value(%d).\n",
+			control->num_recs + num, ras->bad_page_cnt_threshold);
+		control->tbl_hdr.header = EEPROM_TABLE_HDR_BAD;
+		sched_ras_recovery = true;
+	}
+
 	/* In case of overflow just start from beginning to not lose newest records */
 	if (write && (control->next_addr + EEPROM_TABLE_RECORD_SIZE * num > EEPROM_SIZE_BYTES))
 		control->next_addr = EEPROM_RECORD_START;
 
-
 	/*
 	 * TODO Currently makes EEPROM writes for each record, this creates
 	 * internal fragmentation. Optimized the code to do full page write of
@@ -493,6 +514,20 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
 		__update_tbl_checksum(control, records, num, old_hdr_byte_sum);
 
 		__update_table_header(control, buffs);
+
+		if (sched_ras_recovery) {
+			/*
+			 * Before scheduling ras recovery, assert the related
+			 * flag first, which shall bypass common bad page
+			 * reservation execution in amdgpu_ras_reset_gpu.
+			 */
+			amdgpu_ras_get_context(adev)->flags |=
+				AMDGPU_RAS_FLAG_SKIP_BAD_PAGE_RESV;
+
+			dev_warn(adev->dev, "Conduct ras recovery due to bad "
+				"page threshold reached.\n");
+			amdgpu_ras_reset_gpu(adev);
+		}
 	} else if (!__validate_tbl_checksum(control, records, num)) {
 		DRM_WARN("EEPROM Table checksum mismatch!");
 		/* TODO Uncomment when EEPROM read/write is relliable */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
