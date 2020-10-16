Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB777C43457
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 09:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 007DA21D40
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 09:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sU/doiPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007DA21D40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4795F6E104;
	Fri, 16 Oct 2020 09:07:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F35876E104
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 09:07:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYdsSTnVChsX0MBzQaliALClmp+iylN+pt8/BZPKAc7XBdWyP2m+FOtsD3zIIqngVqoUkpiOgzc1ytLL8/Erd/FID6q8tTeT9oq2QwXrpuM3nVqh9NvCy30n0SA7qicLKKDg+kr+o+8+fR/GKlDAU+z9qu3f3id5PLlWsVr0qNl/UYKJl4ctUduOjm8rftB0U9iTf15pK5VQDNagL9r/faOxwvL05NimBx13JhZSUujpjnADYSjIB2IZ5G2I6NtsqW8zd41cDCuCWsWdgq0nZlrzzW4YZ6ica7m2TTAW3KqbMp9RdCFz3eSQVX/uLCQLCeh3A24VO4R8rlMHwV63fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hrihSYu7UNqGPU9v55J+CGEoG7lS15ixdZbQ5/MgXA=;
 b=GmIZgA/Rf+o7R9ilnEGJzO6n0nZIuFVkoJ44C89ctZrdBJCx1HYdpEZTaROgswqh/LwT/f4nOdVJ76B0vJeTdhnVh/44uci0J8zPsBc6KNnyLPJBODCCPX7WwjhoAAgUS1k0NquQi24fmGYlUSZSNXGvQUaP0+5E4WOpuPNGioCCS7DKZjU4wYcrfJEptPaP3xaZVJzeiL4R7zSOMB7zxhq2CWanOqe1UsRQbhPosUj0jYsl0uwcLJATdzgrtUOxqxhif60qYTiTLJikz/Qg/yGFhptudPu0z6JtClvpgixpPTiWdU16hJd+YhR3Wv5KbXXD91y1Ix19MvUcy/uPqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hrihSYu7UNqGPU9v55J+CGEoG7lS15ixdZbQ5/MgXA=;
 b=sU/doiPiQSJo3QEmTieKIXLffc0duAG9MEuBCALqZ+IL30peB728FHvlyomkt/7LRCs0J77CYkNg/zDn4c+h4yEPvSeS8mzHaGp6yby9r3vl9BL29nDVN+IEybsj5HvdnbLV1Dat9mDRsbyiJ8YRvSmFFiVzLz11RAVvRxwgzlU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3392.namprd12.prod.outlook.com (2603:10b6:208:cb::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Fri, 16 Oct
 2020 09:07:25 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::69f0:f749:3d9b:362]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::69f0:f749:3d9b:362%4]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 09:07:24 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/swsmu: correct wrong feature bit mapping
Date: Fri, 16 Oct 2020 17:07:03 +0800
Message-Id: <20201016090703.16600-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR03CA0054.apcprd03.prod.outlook.com
 (2603:1096:202:17::24) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-u1804-kvm.amd.com (58.247.170.245) by
 HK2PR03CA0054.apcprd03.prod.outlook.com (2603:1096:202:17::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.6 via Frontend Transport; Fri, 16 Oct 2020 09:07:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e459082e-b1b2-4d97-4ad9-08d871b2e5b7
X-MS-TrafficTypeDiagnostic: MN2PR12MB3392:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB33926F21BBF9FCB24111DE5FA2030@MN2PR12MB3392.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:317;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F7TORfK03h07nozaTKJHFJOa33mGBzmmkifOBlhUh6aO17t2fmTJmBtmlLep8wVGytKMj3SXgO66Icu4ayz8f9trat5vQ6+uCn7QVNPO8bZvSIX4ilD5Hwst6r12ZEoItQTVW+fe5YK4GrcWuug2Qwdsa5DMOuUEhFSwqESuiHRLNjRG9YgfExbEA58twNFym2Keyx8gYTRUBP5S4RwjwohWAJh3CokAkFfGKgfNaI7SUgPM+fWA4lQYrUA7RGkKMlrbI8qu7a85w/YFK5pzAA/yBJiTdUreGwt/OrtqFqjRhGzO6DzERWCNLs1DF+NZMkp1BcdE4nhwdQFRpWzMpLX2TJMfIHlliuXKLoHRaTlS6OEFdC2+F+fwBpp/7s+aXdk6GRQ6K3iOA3/JRn3DFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(478600001)(6916009)(66556008)(4326008)(66946007)(66476007)(2906002)(26005)(16526019)(956004)(186003)(8936002)(2616005)(52116002)(83380400001)(34490700002)(7696005)(6666004)(86362001)(316002)(8676002)(36756003)(5660300002)(6486002)(1076003)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: IgXYEQmcu6+bT9ot4SPKDEw48ZbkZajfREoK8TdX95c1BL7VEjBlPcBvPuEi9DohSXkKdLchcJzExkRs19/86pogqbN0VqBxR0m9NadzKfbkMk9+NS89EPP9qQhvakTImAARRB4ul1JE1PKSYpCf3V5cd75Ojm+3G3CKOI6RScCBbTY5Mf17VuNHeQIDhShuj1l/KuYnM5lwzkp+YNlj+JVb/0O5ZpY/hZx7HVWRLNCJP/nxLTiQjncp2VfoWVg1ai4ctdzeU3jLTyaq1EMFxkVep4+KCh8JtMEDPSgI4UMBuDBZQb2L6rBnhxJ3it18uHFBZFQDGC/PomCxPQRaRlxbpf870mPjjgNij9/DAM/0EDeMJ5CNxdAT2jRtqQX0UBKyFvwoY2dFEiX/VuXjkhWTovNpWU10irNYvvDQui7PpzTYXDjDu1dUftV1yA/lhHcvk7z1YQJvVrMBNPmp9wW+pONuFE+3teYfVmVRL9bKWuveTlL/P91OSe4ficzsXijyWa+mgfD0/1yd67t47DKUbSfeKuUwy/9ePP3duQRrfLxhsGLvWm6MoaSdVSYTmfCSWaCDax+BGZNO8uFJxwRj0e1geRfuf/Lyov7boj6rFGuUatLJyjaN91yKeK4EH9z6ZUxbe1Z+TCzvnJFxNQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e459082e-b1b2-4d97-4ad9-08d871b2e5b7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 09:07:24.7006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TrW9mxzEbLA23vGrYi34cYEAP7SUA1SDCZ0uV9lu2l1GCPYXRw6EYcSUdzmbw5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3392
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
Cc: lijo.lazar@amd.com, kenneth.feng@amd.com, Kevin Wang <kevin1.wang@amd.com>,
 hawking.zhang@amd.com
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
