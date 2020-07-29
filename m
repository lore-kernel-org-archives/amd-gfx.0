Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C25C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39DC320663
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Q/BAIOMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39DC320663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02C7C6E435;
	Wed, 29 Jul 2020 02:57:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7768A6E43A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 02:57:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kq46sMNJQOuM7Wo+n1AloZLaVUIvlNxbkyL5FpGfBNbS4/qillOKHbfRCjsxFQBHSYef1wOkohKgc0YUeW8ymcurCyRSFLpMDF3aJJgLCjeePdWJ6dDv41+QSDO1vQaLjQ1j5QAS88HGfaRuxPZgjnP6vIhjE2Ytrykn6H4Dlfv/7kvPhD7pWXonav2pEfa7fZ5j0cmJAGBzusY9nIWsCQFF9GaJ50e4abotbY22fh0G0rVAJWztn2rymfBhWT8kDka7rZd6kCpX8KG5cYF4cZW/thTDlnHyKJhPma/MRlv/uYKB/n9BIocj/eAMQlbwVpWcfLSl73pvDExfeSAm4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1D6tvSHd4cW6GEDfsiOAmMdcRDLUFnYAfEdkwddn94=;
 b=jOKKHHPG/Q0Tk0w+MfY5wJjibhnhOxY6x1/2GKGAT1TF0iAjam0yx/ilBo3C2pGBmsNPfe+S7rblqVEUdyjaUqAcCxaGNWBOj8NO6DiebfSSoq8oonpbm3fBajRBdAIHUUB3p0+kQn+VhDiIT6Jsu7T0Wg4EBXQzMbIkQphwcjKF/DW9xn8illpWv+K0Jr6UZSOnK2zeakmAUtLGIwALGCVzzy2GCnh/684d75YV6XQ8gQx95G1y0+Oqh1/v8i0G6JJ8bDz98/QnJfaNKn5QnG0RkxJlJbLp1eEVsbuo26C/kvN5qTyEwGganKbaCb9+XBSwDFEUn36yKR5+DcrJ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1D6tvSHd4cW6GEDfsiOAmMdcRDLUFnYAfEdkwddn94=;
 b=Q/BAIOMpB8fZ9ZYL/ljYzjs5x4a1Oa0hVM4j3k9d+XEbHpP1qxC6XAHThACA6zczLXiWWyvUNIdhb+4lbPhxBc4t/WgWhCM+xmye/CJvSEBoAJQL3B66vIqa3HXI4VGfgCxx3a7R97+WDSnoetv2DjZuUayNzy4/pRlPYBhMRR4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1285.namprd12.prod.outlook.com (2603:10b6:903:3e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Wed, 29 Jul
 2020 02:57:11 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Wed, 29 Jul
 2020 02:57:11 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, andrey.grodzovsky@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com
Subject: [PATCH 06/12] drm/amdgpu: schedule ras recovery when reaching bad
 page threshold
Date: Wed, 29 Jul 2020 10:56:23 +0800
Message-Id: <20200729025629.19355-7-guchun.chen@amd.com>
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
 Transport; Wed, 29 Jul 2020 02:57:08 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 13bf4358-86ba-409d-3c0e-08d8336b16df
X-MS-TrafficTypeDiagnostic: CY4PR12MB1285:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB12859ACDE0EE96BCEC166483F1700@CY4PR12MB1285.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PFQGRl9bXTGe46Q42SewXquDmtvrn/wuiwMZxOJWUImGfvXShd+0PYzzt53+fHUed9oCe2cfFQz/86USbBHxUha/6KDK0vcG+OS12F+W8aDu2lzJ7ecaQKsRtg4iHsZxJTdGM+GAZHcg9s9xM9Ttpxlh62pNXV6eMgCg2u9tRwKxeRvAHZeAIDNIYXLIK7BsLNGAPerczIowFk0wZfAe8qznesOt1FlVKz2BIKnBeTh4SMD0C01IlfA6ZCONFzdFz79tsHQE8adyP1Po89VR3a0V2qNESVNpqUcMXS1LFh/SVaoxD9LnBBq3Af1jV8xDqGncf7SxdKnQi0f7gNma/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(26005)(2906002)(66946007)(6636002)(52116002)(66556008)(8676002)(86362001)(66476007)(186003)(7696005)(16526019)(6666004)(44832011)(36756003)(5660300002)(4326008)(1076003)(316002)(8936002)(956004)(83380400001)(6486002)(478600001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: XkYtfCnY8Z+LERskKt8JLBmvHaiN0k3wCcnVQVE+j1gzz9etzChPjjywfBMvZjeDzEl5d+DFa8wIF21iYE2q1R2/UV9k9LTqROZXexSe02h+QcrLKyWnkA7Cs/t8XkGgNcN5hdu9Viq/ZzrsehkGAIZYa6n9g+8n4G9uJ0qQH35aumULluPzGrrxtvyndnPbTSsri9hE1FJ/amsFM4TRZlk6jjirE3nTqzKC4wIcbN4VNdc6g2QSevAuqjLtLSTsB+ev1qGRJBEV6KD+PUYlppR+HdvMr6oUXZbol8ZZg0NqCBMWLBBAj/SMXXiPJrFMtOeB5xaVUvHTAOqKwE59463uygdD5G9/ayQIyC+h3+wjobR2fycw1NZsWi/WlzurtIHsawXWFaHewOP1WosVf9Y80E3xhkv4ApiR+ImZFSOdQ7TdVwl/pgVW1vyvrLuA54NliTZrb1Dz78ZHDzyxnPCVYLSFxGDEXsi7xV+FQndRENsddE3DRUYWQIB/2Xsf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bf4358-86ba-409d-3c0e-08d8336b16df
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 02:57:11.3210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngsndvzhWxyCl2S49I2BAM1+Tq1FQ+zwB2lWDMySZh4rEPA9+D3Ro1F8ThHbRzrkOkY6SO8yZ1udqMD8fEq8HQ==
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
