Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74468C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0925206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="u1p6ISM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0925206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C7456EA78;
	Fri, 16 Oct 2020 03:28:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99FB56EA7C
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:28:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xuz+7si44WZR7M5kFVqHY4DGSn2rTTLPXxfMqZBDMAnZo0Z4Kk9wIeCDqKZ6iA9iiUs0J5IISLzMXU88wZMLJBoB5rattsPM+YQGLffv3/Bh8TArJNm4kcEpOXPvQzEBlNeI5HkPm+ab6bP8hB4k39Qx8+Qii8pz4fkVAKlRx8SXZ2CMbmYibZhur1c3+UZ20k9xrOpL8JzDKe9QfwqvpTZTnYVGLiE0mX3RAS7mTEE7oA9VSQ6QkVAGYI0JUpDKmKavC+NbhAttSIUjLKeSdrmtkguXvGhE+EGPaxnAB1tB3PlYUVr0xwbYN+diAx7LQ+0mPEPEUfFFsrBs19mhRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CR/C8ZsOsfdraQmV6QMLUq+Q3Y15Or2HCQ/RXVuXTt0=;
 b=ZHZZX7ch15/OpjBShQMbkZU58gIf6Yevb/3rugdyUjwT7IQ2K6gci+yV3tevkg6nWaSe6T0FhRQcu5DGh2yeoG3rI0wTh8HNsnxW5Dyrr84yKMTRhwhjsZowP/rFUGtnah3k1PNdu41qqVqoBXzuoEKnR0JflZJBVDqIP1SuoK8XCU8Hrk3b6sbmDhemUFcESDysENmLfnmzlb0XtLNmquIEeSXrEkiH3rMPPsD+73UippBxwtd/GGvhzTr4sJ7yo8jjeWQ55YANOZdo6GX9yk4Y2Madl+yNpRaBDORRL1Tp0mDQ2cY53RD4KLHQ4ByqAhRAyEwj4bXHdRJ8MZpFMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CR/C8ZsOsfdraQmV6QMLUq+Q3Y15Or2HCQ/RXVuXTt0=;
 b=u1p6ISM3oA7G1TQ58irWgY6V3IaRDdhMHShf6q1ajzw56HvPIi8EEH/YTz+CbuPSBC508+24s2d+3W50f3l0ibrZ7YeAXJpFid5takEZWApvlmgjT/kHyciqN6lipcqyxwRrG8GRfBSJ5x1W3wxy0itSqBdMQClpMIp+/mTniGk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:27:59 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:27:59 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/40] drm/amd/pm: drop redundant efuse mask calculations
Date: Fri, 16 Oct 2020 11:26:27 +0800
Message-Id: <20201016032652.507-16-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:27:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0b1cb33f-56fe-4681-d903-08d871837aed
X-MS-TrafficTypeDiagnostic: DM5PR12MB4680:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB4680B06C215CBEE6C0B996BBE4030@DM5PR12MB4680.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tH9GJN5+boki8TedH+6/zD/mcCbehUkPRkDMQMTIwzhTPJblLhmjfpV7w8khUowUkQfDxOmBHSx+AbKSwxVNgqpc90dbSAcAnt+2Hs6BfOjRcTrCCNVOCqKqeeWed4N49gK1vOZhjejrP72nFHGtzE+lgD/3069Nh+XvV5+qYKDv338J3e33ZC/PNFLrFgfJ7yRbB8lev6PF51PvcwkSBc6l+FYf1Y50dV9TQiA3qtYRvZsdTcnr/qPmrMb/h1CNn869wW0TWHm7BHv99WCAEEQRkp9LKjN/VklWt1EQk9pgtpEjkuXDfKCZoLHHDgHDCfToPgc25clJFoo+eBN+AOgVlv4syKgdcUo4N1YHjxieOKItN9jDnfoJDZNvDclm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(478600001)(4326008)(83380400001)(6666004)(36756003)(316002)(34490700002)(66946007)(6916009)(5660300002)(956004)(66556008)(66476007)(2616005)(44832011)(186003)(52116002)(7696005)(86362001)(8676002)(2906002)(6486002)(26005)(16526019)(1076003)(8936002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 5bGiWjFBmwUTo+A1W2Xl9Ry7sWH8GEcFTJ91G2naNS4XOqriixZ690w6hSEYqT7oUV3Utu4ybmr8uBfBnC8Roh5EWZHYStRIxW57B7DJ6fnkn1SWQdiOyx1kUNJMaKMCQuWlIip6W12mV6X6B31N7gn9cbTMk2u1oAYvxOT4kH6J1+8ek6XTUUdCAjWqUJns/2S/xpqO53W5Wa0OEwUJZeN3654u6PAWu4MA6RrinXMNQUUUY/2YEC+UbYaoOql3DHqBHMe2TiVFwnsDbTvClMLitzzS4orS9dk2lxWCV550glqZGmRXDhPi5BvHM2rJH3ZBc8y96sPx0GEqjFfFAal4lW65dY0FJb+ZqAvjropwlazP7Jn7IN5i7nPAO2p/2FNRGGvkoFTBWYRFmRbhrFoB1J+Fri/IPL+4mJGYX0cXrhINPIHXLtFTZD3Pvrk2/PYsTcv47ihA8xBYv6015cmYq4jdA0+bw1dHUC28NYvPFqShzD9vbJoWstBlbmtVmCV+EK4Y+hy3f2ARyuStF4t397nbA5Vyz5eWmqKOs/2ZU4Lp7U7FUY9JMZSi2jxudWrzEnkNRcolI9w+ug5Tw2IHgWl8TB+n4nSivYFMYw/scyj4sMP5gxbhGjI7OzpXjng9PxYF86L+/5vS9bCw3A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1cb33f-56fe-4681-d903-08d871837aed
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:27:59.1176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBi6UPrWdJ8Ih2Ft8fD3Eqa8ySzi74ROKoGvGbDZCxXBP4xVzd2BVtBufYj04uMB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4680
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

By moving that in atomfw_read_efuse().

Change-Id: I532e2a5095d6cf533c93ee4382f1434a5265f802
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c    | 8 +++++++-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h    | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c  | 3 +--
 drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c | 3 +--
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
index 01dc46dc9c8a..1bde79dd30c9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
@@ -1295,12 +1295,18 @@ int atomctrl_get_engine_clock_spread_spectrum(
 }
 
 int atomctrl_read_efuse(struct pp_hwmgr *hwmgr, uint16_t start_index,
-		uint16_t end_index, uint32_t mask, uint32_t *efuse)
+		uint16_t end_index, uint32_t *efuse)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
+	uint32_t mask;
 	int result;
 	READ_EFUSE_VALUE_PARAMETER efuse_param;
 
+	if ((end_index - start_index)  == 31)
+		mask = 0xFFFFFFFF;
+	else
+		mask = (1 << ((end_index - start_index) + 1)) - 1;
+
 	efuse_param.sEfuse.usEfuseIndex = cpu_to_le16((start_index / 32) * 4);
 	efuse_param.sEfuse.ucBitShift = (uint8_t)
 			(start_index - ((start_index / 32) * 32));
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
index 76ed2e413594..ee14635dfadf 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
@@ -300,7 +300,7 @@ extern int atomctrl_get_engine_pll_dividers_kong(struct pp_hwmgr *hwmgr,
 						 uint32_t clock_value,
 						 pp_atomctrl_clock_dividers_kong *dividers);
 extern int atomctrl_read_efuse(struct pp_hwmgr *hwmgr, uint16_t start_index,
-		uint16_t end_index, uint32_t mask, uint32_t *efuse);
+		uint16_t end_index, uint32_t *efuse);
 extern int atomctrl_calculate_voltage_evv_on_sclk(struct pp_hwmgr *hwmgr, uint8_t voltage_type,
 		uint32_t sclk, uint16_t virtual_voltage_Id, uint16_t *voltage, uint16_t dpm_level, bool debug);
 extern int atomctrl_get_engine_pll_dividers_ai(struct pp_hwmgr *hwmgr, uint32_t clock_value, pp_atomctrl_clock_dividers_ai *dividers);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
index ecb9ee46d6b3..fef9d3906fcc 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
@@ -318,13 +318,12 @@ static bool fiji_is_hw_avfs_present(struct pp_hwmgr *hwmgr)
 {
 
 	uint32_t efuse = 0;
-	uint32_t mask = (1 << ((AVFS_EN_MSB - AVFS_EN_LSB) + 1)) - 1;
 
 	if (!hwmgr->not_vf)
 		return false;
 
 	if (!atomctrl_read_efuse(hwmgr, AVFS_EN_LSB, AVFS_EN_MSB,
-			mask, &efuse)) {
+			&efuse)) {
 		if (efuse)
 			return true;
 	}
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
index 0ecc18b55ffb..38a5cdcf5896 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
@@ -1495,12 +1495,11 @@ static int vegam_populate_clock_stretcher_data_table(struct pp_hwmgr *hwmgr)
 			(struct phm_ppt_v1_information *)(hwmgr->pptable);
 	struct phm_ppt_v1_clock_voltage_dependency_table *sclk_table =
 			table_info->vdd_dep_on_sclk;
-	uint32_t mask = (1 << ((STRAP_ASIC_RO_MSB - STRAP_ASIC_RO_LSB) + 1)) - 1;
 
 	stretch_amount = (uint8_t)table_info->cac_dtp_table->usClockStretchAmount;
 
 	atomctrl_read_efuse(hwmgr, STRAP_ASIC_RO_LSB, STRAP_ASIC_RO_MSB,
-			mask, &efuse);
+			&efuse);
 
 	min = 1200;
 	max = 2500;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
