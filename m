Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6AAC388F7
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 05:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0037A22277
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 05:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dkk121JJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0037A22277
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A95576E4AD;
	Tue,  3 Nov 2020 05:54:45 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760078.outbound.protection.outlook.com [40.107.76.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5204C6E4AD
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 05:54:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Me90hfmU+cKfJl+R1jBAaD9gXvogepkcdwzJHONBM7Y8JzHD71i9vK+2fQVsXLQNHO8rB0oNHgZsyAoFEkyKCNTzgE3Xh+GtX+BS3Iv3QyjD8HwxcSRUBlJcdoYpTuRwU38QYFTzZX1NRHfdYFsgp1r7OVU2UR/azHieWXEwZvNKok2tX3wQBKg22AzGRWvx4W7tb44dw7XNXAacO75kAaxS/ttPwNocowgopE/ZMbhfFE1GzlWCoM2eXYKbA4nkxyFVEvHzgk28hbJkqdYnf/CkhkvjP2NNWdaRusoKhvlJeUX+44/Z90jxv5J3kkBIP3YwqJgZQb9hyom2MjYNyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hrihSYu7UNqGPU9v55J+CGEoG7lS15ixdZbQ5/MgXA=;
 b=Fcy3G/eX3RUFGYib/NMPhzmnHBw8DHx8FxO3THQMKKilw6iI2Y1e3ls+L4PSqaypY7NDNtPeSdjoA8Q53cQpUSdjZ27K8ryZ6afPii9nvWbi6oZiU6dax8rvI0xnO2lOz3seH3xUncpYVOwLtWvUSpERaaWR4736Tan8IDcnlPhGX6tAAqJT/ERXzSj/vdh97F3hEo0IquX0V2znQcCRctPX2SYt3M1/qjQmzTxomcmATZp276/VZJof5q8ZSbaC9rSvg6Z2/Ex1Ym9AAVmVQ2eNYN6/R9DUTXi6llPK8yG3cZIwUZmRymn+W1ioP5wfxha0ExcMpvSFH10Bdh0qXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hrihSYu7UNqGPU9v55J+CGEoG7lS15ixdZbQ5/MgXA=;
 b=dkk121JJX13k6OH91GF3QmGLI5/5grQp1KlExDl/H6FgcAq7w4S30HHIpltexcE7RaBCz24PAWeCcjfXxp5r6rApZh2OBSfufBUcCVPQLP5OySlEBotBSp91Lqf3d0y0cYh2ACd9zMkVeABS1piaLrNrsRirj3XOUddSILnBY48=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3293.namprd12.prod.outlook.com (2603:10b6:208:106::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 3 Nov
 2020 05:54:43 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::69f0:f749:3d9b:362]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::69f0:f749:3d9b:362%4]) with mapi id 15.20.3499.031; Tue, 3 Nov 2020
 05:54:43 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/swsmu: correct wrong feature bit mapping
Date: Tue,  3 Nov 2020 13:54:12 +0800
Message-Id: <20201103055412.19169-2-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201103055412.19169-1-kevin1.wang@amd.com>
References: <20201103055412.19169-1-kevin1.wang@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR02CA0149.apcprd02.prod.outlook.com
 (2603:1096:202:16::33) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-u1804-kvm.amd.com (58.247.170.245) by
 HK2PR02CA0149.apcprd02.prod.outlook.com (2603:1096:202:16::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.19 via Frontend Transport; Tue, 3 Nov 2020 05:54:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 996e210b-3cde-4026-202e-08d87fbcf5dc
X-MS-TrafficTypeDiagnostic: MN2PR12MB3293:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB329386AB9046D6790F32D523A2110@MN2PR12MB3293.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:317;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hPYUDVYYjroQql2xV/Kmkxwmtk3hlXRnyZvnenvNPJ6Oauwa7NfKXz4rk0Lv7gJtVP+/lAWw56sVJB701o7vArD9+Ek6Y7IZwVmFbJAtrsbLOVYODfKp9m2lMSN67eIhbhmBUvyfzo1VEhBEMOZ2JhG+4Il3MSrZHQbX5URyRoj2uVa1zedWEA35pDbfbLyaL1dYPGRkhRk206WPagAvMVfEeOUuSSump01kqSfeynV2m9350XbiuHC3/0pV2u8q/aLG9vjEyP4nCx4PDvuXYJqQP9fytFwZsuN+e5r1f/VdBPBmtg+3dwOigILG9MbDXH8XK7I0+XqmFEI0A21K3G28rIF6r6QR8ix44wKW5RCkUGHavzRyG2cSeXLhUxyt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(66946007)(478600001)(186003)(16526019)(8936002)(66476007)(316002)(26005)(6666004)(6916009)(5660300002)(66556008)(956004)(4326008)(6486002)(2906002)(7696005)(36756003)(52116002)(83380400001)(8676002)(2616005)(1076003)(86362001)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /1dBl1TTVnyYXzbn8PJkr96l6+NhIarKzQLKCiPFCa/uYuoJlnw0wNnomvnvHg+ASb8DI7MgIfeJwCoLeBajGAE7h2vfnid97U1g2kOJTx+GfcEcPsZaKIYgajJdZpzxqPMGpdWtY55N2lYgN9V3CwjwC9aulyhxze2DvCL4cP8do+sEEjwkyHgLABTqaSlmlpLc8lzoC+3QQ9I2iQHZ3vMBGvk/zmYMjYo8LvMauJNhHVi616zNb2Yzi6NrPxvqp1EbRAUETEpEejvpmyU1V/b652IIVQbJ9KALMvWbFOfSqrY8vR/ii2BNMwUfZyDk6JxTDZ3UkhlRDX6GdShwpSrReKrjlM3q0QhbqIXFOWpphu65VrSD9lDBKkd/kor1YqFzXbQLOljM9BETda5aNqDebU4cKuExPVWBx3tbkgSmCheR76YWLAuAA/3bKdXU0nCrWye+4nwjNG6NoWfaHoGVImlDLvqetzVBE3bEN2dswYXWx0mdnMbdI7f4ESsMvZcw+SX/LSZPp2vjQZlkSkKLfpS4LRSVRNzrSAmH/oe38VonTngBWdp2Ecv+Ni734Ooz9pX2el+W/QDCetSKP6cig3JBJ4o8CO6u+Sb/YUylqE3vZJvfTWPpVRwtQeW6jrKyVCZ3GXztb3omS0XX8g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996e210b-3cde-4026-202e-08d87fbcf5dc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 05:54:43.0607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rb/MOoullrEj1K/U5wcp39jWFwg4QGHoqXoADhP9Cug9tdKt4MBoWLbgbQi/x28j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3293
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
Cc: Kevin Wang <kevin1.wang@amd.com>, kenneth.feng@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1.
when smc feature bit isn't mapped,
the feature state isn't showed on sysfs node of pp_features.
2.
add pp_features table title

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 27 ++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index c30d3338825f..92b2ea4c197b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -431,10 +431,9 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 				   char *buf)
 {
 	uint32_t feature_mask[2] = { 0 };
-	int32_t feature_index = 0;
+	int feature_index = 0;
 	uint32_t count = 0;
-	uint32_t sort_feature[SMU_FEATURE_COUNT];
-	uint64_t hw_feature_count = 0;
+	int8_t sort_feature[SMU_FEATURE_COUNT];
 	size_t size = 0;
 	int ret = 0, i;
 
@@ -447,23 +446,31 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 	size =  sprintf(buf + size, "features high: 0x%08x low: 0x%08x\n",
 			feature_mask[1], feature_mask[0]);
 
+	memset(sort_feature, -1, sizeof(sort_feature));
+
 	for (i = 0; i < SMU_FEATURE_COUNT; i++) {
 		feature_index = smu_cmn_to_asic_specific_index(smu,
 							       CMN2ASIC_MAPPING_FEATURE,
 							       i);
 		if (feature_index < 0)
 			continue;
+
 		sort_feature[feature_index] = i;
-		hw_feature_count++;
 	}
 
-	for (i = 0; i < hw_feature_count; i++) {
+	size += sprintf(buf + size, "%-2s. %-20s  %-3s : %-s\n",
+			"No", "Feature", "Bit", "State");
+
+	for (i = 0; i < SMU_FEATURE_COUNT; i++) {
+		if (sort_feature[i] < 0)
+			continue;
+
 		size += sprintf(buf + size, "%02d. %-20s (%2d) : %s\n",
-			       count++,
-			       smu_get_feature_name(smu, sort_feature[i]),
-			       i,
-			       !!smu_cmn_feature_is_enabled(smu, sort_feature[i]) ?
-			       "enabled" : "disabled");
+				count++,
+				smu_get_feature_name(smu, sort_feature[i]),
+				i,
+				!!smu_cmn_feature_is_enabled(smu, sort_feature[i]) ?
+				"enabled" : "disabled");
 	}
 
 	return size;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
