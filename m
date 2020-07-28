Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F34FC43445
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:50:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7282A20714
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1Il6zmOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7282A20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E5B06E1F6;
	Tue, 28 Jul 2020 07:50:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC7A26E1F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 07:50:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsV2P3+fpyCnskHecW0dN52obT14Xk2FXMoJoQZHYOt5XLFIZF6ZJGTPsKJEMdaCKpWcWszsqsB5HoAKL/fhHmoWKg9OpAt4eebzZbcE3Qi8CeMXtFsO9ZJgB9nM0tcI3ob1SUr5fQE5OkU7D1mFm5RW0FeSSjqPBS6KHACjHyDH/klC69MkrP39PjJrB0j9/Gg04ANT8ydwGNGw8ohi286j9pH2Pqd4WXxlSrY1dVk41lYqQoUzfoIzhASGXicrsCHoNsfAWPJ15LE02Rzulp2VQGT5142Qn0RA+coKcSaHwHhDcC1RnduH1sY2rvY1V7N21hXcgzrnL9cNWDpbAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRp1HYdIcCVXpRh6E1Qa/uQIun2frT9PU1oKUQrCPwQ=;
 b=gMJbDTU7Bq1fr6Ddw+DxoQi8lfqhU99of3NdPb/wSCvxOR6a9rqZVVpu21E6cDYPbrQF06TkhATK3nm0tda4RBVGUBapF8RVn0yrCWjiNl79a9TNb9p2k+KNqrKNyd1s1k5XvaedKeY21wrPI1OcZc82wnos++ayBX79vEyHMWVCQMb4o0QA+ZhaXBiD67LZOidUUFtwbR+YF1uKV6NWa0IATRR/gyzsRHUGhtDC3ksHrzokXywBTLvi2LTQxLr9EFwlxN+3YyTIZRwI3lbWmN+KWGVh3mq9kG1odzY880IwszL41aScumUCR6UJMpUwf/UCfsfk+VJccEGGujVf9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRp1HYdIcCVXpRh6E1Qa/uQIun2frT9PU1oKUQrCPwQ=;
 b=1Il6zmOHoFjIL69BTpkspaWC2hfe5nr1t25m+mNFjR7+9cnD60VokjmC++L4zkbV2ar7Wo8IO59PadRv+fAn0oemkLF7eS9tGpe+mXpz+jRd+HnJhiHRIfV1kjccJHriBl7WFEx1WCPOifhEquxz4e9elXd++56NfjNTGDVDSXM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0120.namprd12.prod.outlook.com (2603:10b6:910:1c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Tue, 28 Jul
 2020 07:50:36 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Tue, 28 Jul
 2020 07:50:36 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, andrey.grodzovsky@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com, stanley.yang@amd.com
Subject: [PATCH 12/12] drm/amdgpu: reset eeprom once specifying one bigger
 threshold
Date: Tue, 28 Jul 2020 15:49:34 +0800
Message-Id: <20200728074934.12490-13-guchun.chen@amd.com>
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
 15.20.3239.9 via Frontend Transport; Tue, 28 Jul 2020 07:50:32 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 165b0f26-4aed-4cd7-abf6-08d832cae986
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0120:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB012062B42A947491138F8771F1730@CY4PR1201MB0120.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: clGUcEf9MoZeJq+egFfTtTxUOr6XkA0s50xmEce3RtkktVGaVEBDIUczTPlub3iJr6hAJsasexia8dIXJpjVZhwKrsoQkV/bzZhLBTr4O4jetsWE0PH9url8E8lDfWOXNKDIKmHKUKW2OLMVc5ETnGjmItH7POK+X4hGb5RJD4hhzsqkmvyj54eCJ2TXShfqKdhU4VJm7RdSUadpz91GOSgn3jL53kMd+pkdaf1PLwF8AaVQnYKpw+fy4LRlpjEzTF+ejOWEpcAX8xiFeGalM6WR3qlsG0iJQa4+QP72MllOAOR6K2I1T9spe7fIGDJw7V61+AESBON0+ERb61rA0Tl1tM54AsRNmKibBfe9mHQ9dlmSO/G02uFepX8fmCscK5HoVT2Pdgc7NgutCQynrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(5660300002)(44832011)(6636002)(1076003)(2616005)(478600001)(26005)(186003)(16526019)(8676002)(86362001)(83380400001)(2906002)(52116002)(66946007)(956004)(36756003)(8936002)(66556008)(66476007)(6486002)(7696005)(316002)(4326008)(135533001)(921003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: puykIZe77lp5o62kpufHBwvI20pNIcPXhlQPVJyl0BLRe2HrReQI+zgX9huPc5mM0H9n+JccLYXaY34cXif3unWTlx0poMPdv/Ok+muOgXXaDJ7qBBPedlZ1n52Irs2StVO/KvIqqBKBt6k4SiVL0gKUDC1/9XqnNBLfJCPiZ1s/0PuKTnH6i8gz3zYmEiehxACDnAH5dZT7O9cJYdqwlbTX+YNkvZGz4iq8t59UAQfZHq1SufzEgZp9rUnEbHuxF18GcddLzmQfQOsidvvgBnvo1yQYTnTawJNshhvQVEIp6/SK8TgUTm9UqB9HFEhFK3UEta+1Fz/01m+8fOkFCl9ckLrm89c7T0j1OgF33syzj9Vv17L+Dc6UnDKuA91X4mIOr4U0ttjZe3U8xYjv2vu5Yc4Evib3M6dI1srvkB6NWGaWAdKlQYKkHDql3V1UYjmD67J2JJv6kdqFaWoAyWQzl5w7Fs9apatEiiGn99boD8W4EFYYR85vo3HURmfq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165b0f26-4aed-4cd7-abf6-08d832cae986
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 07:50:35.8303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1TkCqB9T04nI5oBx6uwdAArsDtTPgqz4V40pDjVq6R/VYPLK2rAR2RUpIkZXmE7VA/deJqCmJe2ARMEArP2pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0120
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

During driver's probe, when it hits bad gpu tag in eeprom i2c
init calling(the tag was set when reported bad page reaches
bad page threshold in last driver's working loop), there are
some strategys to deal with the cases:

1. when the module parameter amdgpu_bad_page_threshold = 0,
that means page retirement feature is disabled, so just resetting
the eeprom is fine.
2. When amdgpu_bad_page_threshold is not 0, and moreover, user
sets one bigger valid value in order to make current boot up
succeeds, reset the eeprom data and do not break booting.
3. For other cases, driver's probe will be broken.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index be895dc2d739..02933050081b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -248,6 +248,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	unsigned char buff[EEPROM_ADDRESS_SIZE + EEPROM_TABLE_HEADER_SIZE] = { 0 };
 	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 	struct i2c_msg msg = {
 			.addr	= 0,
 			.flags	= I2C_M_RD,
@@ -287,9 +288,15 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 
 	} else if ((hdr->header == EEPROM_TABLE_HDR_BAD) &&
 			(amdgpu_bad_page_threshold != 0)) {
-		*exceed_err_limit = true;
-		DRM_ERROR("Exceeding the bad_page_threshold parameter, "
+		if (ras->bad_page_cnt_threshold > control->num_recs) {
+			DRM_INFO("One valid bigger bad page threshold is "
+					"used, reset eeprom.\n");
+			ret = amdgpu_ras_eeprom_reset_table(control);
+		} else {
+			*exceed_err_limit = true;
+			DRM_ERROR("Exceeding the bad_page_threshold parameter, "
 				"disabling the GPU.\n");
+		}
 	} else {
 		DRM_INFO("Creating new EEPROM table");
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
