Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2D8C433EA
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 08:34:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A1A2084D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 08:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AfFAnBIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A1A2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AED16E864;
	Thu, 23 Jul 2020 08:34:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CD816E864
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 08:34:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aM4wzFD1xBn4kDu/R51oZEJEZ/xYYfVuBix2S8m5dKg5YJtLh14F3cHKv0vdSK88wP8OHIH60Fao76gYccGNPYUNzK4abqPcAvOXdIUKeiLWa3vFcv3wkqF6v1UuvNoXe8LAfFTN/ELHV2n/Po7dh8aoLt61OVTx7uUoaRRMMnot74FHdkJQHpdkoUw8RagaFfjwMcYQHNQBVmqTrILJhKC758r/u7B6ISnoZMAgKtRdSa3601lPKRsZUnDJxfdS/kGxmC6Xs55dsaAi3WPmsuheFSwJZFNqiEIozhbzmdHudUsmrpM8CpEVQx+BOnGzpFz/tCLNZbQcOwP/9YulCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWltthFwWUU+EbjoJ6N/FDPQQtYn4B+rNjURzNYI7GQ=;
 b=bm3nccbE5d3et1WE6VIxePb/HsfpU0Ts+BJqs/LbyvSuZTwxy6tS5wdyu15gZcx1KMRUF9BNhxiqRbqRArU0URqB0X/fFTJpNgt5PzOoTUEUyDUpwZxzDmOfdQq+BiLzmNpo4twTJn8HErE7VgqchKpgMmz8H72BrcCJatDY+750356wXCI+i5NiCEA/CfwdWS7iMJ7aUspG6iiJ7iccvDtxHU8Pf7J/74ASary8U/8SnxRI+TZMC7Q6dg3hCf1RN5Zf6ba2NCPV6GlSXw3Pg28tFKTrDCvH7tcllbMSzw3mhH+5e4GJD46ITFiix7uxUNaLiViPdhz8ilt3gfar1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWltthFwWUU+EbjoJ6N/FDPQQtYn4B+rNjURzNYI7GQ=;
 b=AfFAnBIgi4CFifIBpY1RAlxni5oDj4O/CEujZwHwFZsrSrqH4s3XWCY8PsTEAXh2uD8pz5FLkgqC0mOEPjpx+cELV7/wKtCEWPCsoCic5xlNpdLSOpjMPTH4TNH3a8/2fkFhRo97oOCVA2LJVhLfH5QKddxJFk+7Qkl7iRasofQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0005.namprd12.prod.outlook.com (2603:10b6:903:d1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Thu, 23 Jul
 2020 08:34:26 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.024; Thu, 23 Jul
 2020 08:34:26 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, Stanley.Yang@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com
Subject: [PATCH 6/9] drm/amdgpu: schedule ras recovery when reaching bad page
 threshold
Date: Thu, 23 Jul 2020 16:33:43 +0800
Message-Id: <20200723083346.8743-7-guchun.chen@amd.com>
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
 15.20.3216.21 via Frontend Transport; Thu, 23 Jul 2020 08:34:23 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2cbc9793-bf13-43ec-d3ea-08d82ee3354d
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0005:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00058C5BE4E27C8E2792A394F1760@CY4PR1201MB0005.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ecdSgPe5iFrJ0pXuR8jYk3lpejF8w51NaxyXmDa4Y4hH6VRlXc3jdm6ojYdLqYIrOu6ievh5uRHr+YXRwo2lIN2fmUw2LSjA+6DyIsKymLDjds71X75VeGtX7JDWEgoNgIte62NKoHegTJlYLSm02peKjQgSJnQ0vAdEQHpsSqWGSq4DA54nU+ho70+Xv+1MjGY6RlDeuBmVsd0mUkcc0di0WF0cyQu+ahEeK8vS/xQa6mu2/qkxBdd/KsKktwWyrTFSKg9qz9xwbuM3BwkVf468wsFLAYpmbF/QSkLY4YspymJtwsHpHasi/7MvHRnw45gDKErSMKJziibMa54aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(8936002)(316002)(2616005)(36756003)(2906002)(16526019)(186003)(8676002)(6486002)(44832011)(4326008)(956004)(26005)(7696005)(478600001)(52116002)(5660300002)(66476007)(66556008)(66946007)(83380400001)(1076003)(6636002)(86362001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ctxDjY6dcg65f3/DoDriP3XsBljF1ZlCSDNQuSMPGTDiPwFLkVaL57PGht1lY0rqszJDCaMX4zSVVv05Y4CaIEvs3xW73UaTXkxAma3qkJpwt1gygTJcV54gAtx3S6tAEkJDZ339kqi7NTEaxcMw79X1yoGOgbuwtH2RtnqSkmSN+bp/Y6bJNErtQcRwhBvUP/+9N7obzlRNWsf+lrc0yexxSBuxFnIfSdqpGb5uofVqKO8lhip6Vk3IE7bdF9dHjWjBCX7v6Fe9QgKJZ1f8xui6G/WQ+vrBcj+wRZue1OT7DJSw3PMxtGe1p3QFxZEzuP31iUND1GtXXYWk32j3Nebw+7GVmFdLE+3VsdA4wA7nYhoSb/u3PNDBnjM2u5J9HaEnsWXJlPdx0o4z6fQCoX0xS1kgmF0w75oEynpF3MfPm8MZk2E0q+hdJzaepoTZadKMF2aTTVchue4ZezNRYBudv5ECmxCn6kR00gaFPZzWZ1hyf+g2qYf61MUAnR7G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbc9793-bf13-43ec-d3ea-08d82ee3354d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 08:34:26.4619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qse4Wr1qZFpNEgBQkhHUM0/WMClJUfvZGMAFub/JIpDxQjTxn/dubWPFjjMBVUfmiD4gW047DqeSLM8bOoKNJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0005
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
threshold, ras recovery will be issued to tell user.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 36 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 3f1b167afe6b..0cd594c74bff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -395,8 +395,10 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
 	int i, ret = 0;
 	struct i2c_msg *msgs, *msg;
 	unsigned char *buffs, *buff;
+	bool sched_ras_recovery = false;
 	struct eeprom_table_record *record;
 	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
 	if (adev->asic_type != CHIP_VEGA20 && adev->asic_type != CHIP_ARCTURUS)
 		return 0;
@@ -414,11 +416,29 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
 		goto free_buff;
 	}
 
+	/*
+	 * If saved bad pages number exceeds the bad page threshod for
+	 * the whole VRAM, update table header to mark one BAD GPU and
+	 * schedule one ras recovery after eeprom write is done, this
+	 * can avoid the missing for latest records.
+	 *
+	 * This new header will be picked up and checked in the bootup by
+	 * ras recovery, which may break bootup process to notify user this
+	 * GPU is bad and to retire such GPU.
+	 */
+	if (write && (ras->bad_page_cnt_threshold != 0xFFFFFFFF) &&
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
@@ -494,6 +514,20 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
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
