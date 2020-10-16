Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2126EC43467
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:29:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCF1A206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="j1GbqjQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF1A206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D07E16EA8C;
	Fri, 16 Oct 2020 03:29:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DEEC6E9BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:29:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqKVIAgipV1lRdGVgYpZs8ZR74O+zMFQrpJZCvV9aw4U4PzNjQun489WRIUbxfR8f7VHNU2fmiifq5h3VrIineEMb++/jABDdup4pWMjdm6RhQ1jZkkj7qZeC5ijFb0j2L7/4owkQTapAoJ+FiC6uPKSB4vYs0/yH9GV2TF4mCnu6dDYHQMLivs3vtd92c44BbzXozxkQq55Ce8oIY2vxj43ggUuIUunKnvNkBamq46jf68M9GBLNf2qsCgh26lG/ASfPxaROSZkHhHgkqQy5nIjLUOn/NctjRaV91+PHG79TzVGmWRYt8NQUE+aYFlZQPLYg8yzjEm2JAWZjsvo4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zN7VR2DDnz9n580gvPfLUDHhk/BaGuOIX5JiVCmjPk=;
 b=gjzrU3uGcY5FxzHwIer4XXDR+yJGB0ZTazSPIc8EdOAv41rU6eddc6Tj/NTgOMMzpu0aigBgQ68IDOAmpU3EQD4QMOPhciReKYYhEdD82684A5/DmQDkX6Yv6sTEDFgsqlazNQlXdMq/hGAUvAvkQLWFL8sT/xuXwF51VCSzc0waF5BJlg8eub+sdNHROmew/dZX2roM4Jc1JgXoRhXijF/BXrlwmEvyJeYJhKxXx9/PdZQZQBjpKyHNlqSBQqfqqV7JQSSARbr0FAX6wfUQdotG7hV2Fm3qnQvumfcdnU3ctsBwwafUbj9+4glDYZVWGKbPdCnyfg7t+3AMNakEOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zN7VR2DDnz9n580gvPfLUDHhk/BaGuOIX5JiVCmjPk=;
 b=j1GbqjQ1qHIyU3EOeASePoriSb6JKiJDes66X4XaxjZt33CsEsAKp71M0wdBybUgusBAmYT2ubhXJ/+BE9mcZcN8Slgzsv1YjpxK2v+ctL24VAdr+aHaC9WXw1ZNnk3gYr11tL/abyZ+Twlr9Pf3CRhizI+WLm5cN/Hx8WTXzP4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:29:04 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:29:04 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 36/40] drm/amd/pm: fulfill the Polaris implementation for
 get_clock_by_type_with_latency()
Date: Fri, 16 Oct 2020 11:26:48 +0800
Message-Id: <20201016032652.507-37-evan.quan@amd.com>
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
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:28:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f61fce4c-2e31-46b5-bf5b-08d871839162
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1354C20A990CB587F3FB2CEFE4030@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8wi8/6pcR3gVSaQb3LoPL9DUlV3V6dwvyGuvuRUu/MMcHLtw/9comoPbYIF2eLVDSXIggSCl9eX/gU1rOwazBpjrYx1gz+vwEDfsPijnB5Ll6M3+We7BZJsD5JqbFogqirBmGA4zDqE+/l3afjpiMpYfbeYz2a4gJgAtfIynRda8fPnM+EHfOmUj9YuiMngaSDMcmK9SciIyXvJQFVKicOjMxQQx+zkg2dG7+dWq39ry+n9dmtVD+o2Yckjhc4295jDJlWlliZCl+ePiOIbBAcUztqTu1daXxGVZZzgMJiBunQdZB984dYOgSSkxXBlql3Y/0kCNCs0CA7NghMAveSMJJxV81DeEvcvK4YQzKZ/zFNN4PrSWlPbm4SfxDb8A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(66476007)(66946007)(83380400001)(1076003)(8676002)(6486002)(5660300002)(8936002)(66556008)(6916009)(86362001)(52116002)(36756003)(7696005)(4326008)(2616005)(34490700002)(478600001)(316002)(6666004)(44832011)(16526019)(186003)(54906003)(2906002)(26005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: LHEwYipDSozNA7md8sNhBtX/2qhmUFHESZ6frie25sRZ16Ro2H9HnOgqqK7o3DLxHdjKrYEcC+Pd2VC508vq1tIBqqcFXKn6a2dA6HzUh0X8Ci2zjjZpk803AlrhkE0bbG5f6LzpNXEkhyL+REBbOW4Q2sTQtO8tw3BcK1lcotN7LgIx14QRDPKeiCv1NgCC7mKb6Sxf5QwSBkJ8cR49QyxPFmCsy+qbXtuIdyshY3IZ2PWFP+PvowPS/NiZmfrM4OdxhY69UfEPttGfQYgJfDytyDFMdR3jNInEDIOaHSoeqUaqoT90U+AGnZojOTl3yOwh3S4mPzCvbn+8evsE7qzD+TUAW5J7xOaUw61hHmPc5IqvB8ifK59nn3d1GHL6vDdX9YRRCdpMR3lNryk6xCIEe9Iwuqt6Qrc7/thF6+6HjbAQOJ+FMSE3pQRQArhcz7oO55SBZ2bqljXXj4uewqEDDlxZrKrPsArAax4KCmVBnoovRN1TDuXha8hI5q6Cqino0KvUFZiRHeCGgMbqBDx9VrCqrsV3sPrlJWDB1mrMf/XERpcf3/Uy2lEPk1fCPWFYm0UoLF00v1vWgNoHqyik9bW+286stYr7IXvAb0e5rwgZmKGebaWXzo+WuIrWIMPDbahrjSq3h7i6mC+pHg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f61fce4c-2e31-46b5-bf5b-08d871839162
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:28:36.8336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k61oqeSVzMaQxoohOC/h/gHzZuBR5r4H3n+kO0qh2oyfy8M2r13UhqlkOTiDt8ua
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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

Fulfill Polaris get_clock_by_type_with_latency().

Change-Id: I143959f9fcb218a74aabb2fbf6cd6c7b2f0716f1
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 59c199cd7aeb..3700352286c5 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5041,6 +5041,72 @@ static int smu7_get_clock_by_type(struct pp_hwmgr *hwmgr, enum amd_pp_clock_type
 	return 0;
 }
 
+static int smu7_get_sclks_with_latency(struct pp_hwmgr *hwmgr,
+				       struct pp_clock_levels_with_latency *clocks)
+{
+	struct phm_ppt_v1_information *table_info =
+			(struct phm_ppt_v1_information *)hwmgr->pptable;
+	struct phm_ppt_v1_clock_voltage_dependency_table *dep_sclk_table =
+			table_info->vdd_dep_on_sclk;
+	int i;
+
+	clocks->num_levels = 0;
+	for (i = 0; i < dep_sclk_table->count; i++) {
+		if (dep_sclk_table->entries[i].clk) {
+			clocks->data[clocks->num_levels].clocks_in_khz =
+				dep_sclk_table->entries[i].clk * 10;
+			clocks->num_levels++;
+		}
+	}
+
+	return 0;
+}
+
+static int smu7_get_mclks_with_latency(struct pp_hwmgr *hwmgr,
+				       struct pp_clock_levels_with_latency *clocks)
+{
+	struct phm_ppt_v1_information *table_info =
+			(struct phm_ppt_v1_information *)hwmgr->pptable;
+	struct phm_ppt_v1_clock_voltage_dependency_table *dep_mclk_table =
+			table_info->vdd_dep_on_mclk;
+	int i;
+
+	clocks->num_levels = 0;
+	for (i = 0; i < dep_mclk_table->count; i++) {
+		if (dep_mclk_table->entries[i].clk) {
+			clocks->data[clocks->num_levels].clocks_in_khz =
+					dep_mclk_table->entries[i].clk * 10;
+			clocks->data[clocks->num_levels].latency_in_us =
+					smu7_get_mem_latency(hwmgr, dep_mclk_table->entries[i].clk);
+			clocks->num_levels++;
+		}
+	}
+
+	return 0;
+}
+
+static int smu7_get_clock_by_type_with_latency(struct pp_hwmgr *hwmgr,
+					       enum amd_pp_clock_type type,
+					       struct pp_clock_levels_with_latency *clocks)
+{
+	if (!(hwmgr->chip_id >= CHIP_POLARIS10 &&
+	      hwmgr->chip_id <= CHIP_VEGAM))
+		return -EINVAL;
+
+	switch (type) {
+	case amd_pp_sys_clock:
+		smu7_get_sclks_with_latency(hwmgr, clocks);
+		break;
+	case amd_pp_mem_clock:
+		smu7_get_mclks_with_latency(hwmgr, clocks);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int smu7_notify_cac_buffer_info(struct pp_hwmgr *hwmgr,
 					uint32_t virtual_addr_low,
 					uint32_t virtual_addr_hi,
@@ -5458,6 +5524,7 @@ static const struct pp_hwmgr_func smu7_hwmgr_funcs = {
 	.get_mclk_od = smu7_get_mclk_od,
 	.set_mclk_od = smu7_set_mclk_od,
 	.get_clock_by_type = smu7_get_clock_by_type,
+	.get_clock_by_type_with_latency = smu7_get_clock_by_type_with_latency,
 	.read_sensor = smu7_read_sensor,
 	.dynamic_state_management_disable = smu7_disable_dpm_tasks,
 	.avfs_control = smu7_avfs_control,
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
