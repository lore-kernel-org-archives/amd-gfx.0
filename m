Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73D7C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 11:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56696223C8
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 11:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56696223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2AEC6E1DE;
	Tue, 12 Jan 2021 11:36:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC3DC6E1DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 11:36:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyD4bTO0F12TPBUaddFxKnKmrJjXWbFAfRQblXrZPSypkhgmNWB/8fmrIBSWko7mAzXlexX+RCExRoqPRHEnn62IBql+r+PIs1yC9gImZqOm2VF6OTC+6mei9x8+RnJdHYZl9FthH7X6i0ENkZn1E3R5To8ANAkmJNmKdokJBoo2yV2ANqavpcNHubnU7jxiJCDOTowsAuAG18AV5vQpNAWiPtEEbZ1b59TCd8cA+BaaDhKumKV342OITe9ueoLwjCUn1S7Pyg3q1qouCCd7FaJR+zxJyWmbHm8wy4i9U7CZzqYwIeVeEcZzW0xjY9ECyo+z/J23yyA2bVB73e3/3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNlokguUm6HjE1+SYyUhqeesJCc2be/m4QcZ61iWafQ=;
 b=hpEgihPM2ImryX+awAzq9eBTxlTEzqEnukVfsUH40dFcqzAgNHE3ggNHFdCXBByPZ1kbWdpvZluvlpz7VwCH2JjpCbCdV/YLAn9sadvzv5/47D4i12wdcVDBz6uzhbh45VsC2uRiXQ3vBbImmhkz93cm9e7fKo14uE2uLer9i/lKlrWSgBd4marTi68itvkgC3GcIVkgPmsl1u8xIcd5YJdLbbZ1VbTIRm/5XQw7kZVwxiBdBzdU3VOCATwbEWhVv1WbikDJaM69WgkvGdfX8iF4MluWHf5a2qEGKfDdoM4jkk8Qgf1ctxHOJOeMg5V6FQekC3FMK8inCfc6tAfQAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNlokguUm6HjE1+SYyUhqeesJCc2be/m4QcZ61iWafQ=;
 b=r5yQqA+zvtcCzhtNDTCcDGmRnGOwEbwbyB8hARI/Kqh9YDB1SQv6axa9BKHZppP4Uw9Owpof2qX6KrMNkZpYqUqWE/G4E64toc/xHkMmauXfN+OTgy+r1jv8H06Dfdnft0fTHOvGH0oMX8szEfaSIY4NVtmk5wRujY8gZ+HGfXQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1124.namprd12.prod.outlook.com (2603:10b6:404:19::10)
 by BN7PR12MB2660.namprd12.prod.outlook.com (2603:10b6:408:29::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 11:36:04 +0000
Received: from BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::7cc1:989:4a2a:ab1e]) by BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::7cc1:989:4a2a:ab1e%10]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 11:36:04 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: support the function to change power profile
 mode for vangogh
Date: Tue, 12 Jan 2021 19:35:29 +0800
Message-Id: <20210112113530.28540-1-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR0302CA0002.apcprd03.prod.outlook.com
 (2603:1096:202::12) To BN6PR12MB1124.namprd12.prod.outlook.com
 (2603:10b6:404:19::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-MyrtleD.amd.com (58.247.170.245) by
 HK2PR0302CA0002.apcprd03.prod.outlook.com (2603:1096:202::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.3 via Frontend Transport; Tue, 12 Jan 2021 11:36:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9a9c86ab-4cf8-44c4-da72-08d8b6ee3f04
X-MS-TrafficTypeDiagnostic: BN7PR12MB2660:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2660F269DD10DA9635C41FB4F1AA0@BN7PR12MB2660.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VSB5JaRJzCoKsPJepavL6cp9wReYVGDEW4HccGyH7LbFlYZzg0scQTvSt7JQ7z3L8xEtu7b+oY6s/pQN5VDBK5GUjcCTnlhat9Ftni/vU0bpD/bHKHXCmpyS9+99Y/ymOH7Pk90i/stZSDh9B81rvJrvb9PiFbzyvMWKGE3I0S/oEBIGL8xLh/C3brZnJxWlqyUeeICbPaNt37VqnRE5mzrftQv9Niw8DDso/4uRBR+ADRJZNN8GIlQTl7SZGNUE6+sgmlU7y/mMYq2Yb6qvNTFqATKRFAUPa2t9SLbYZG7KCgSntZRNb+zCZX6nQfyxmfwGSK1BICuvTWBz1zoKeVPs7AusvVNTgoqb5MssAlSO4ZmI/15Aq8j1MS3VZT+9BznHw7P8t0cjxsS84B/Bzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(66946007)(6486002)(186003)(66476007)(7696005)(316002)(52116002)(4326008)(16526019)(83380400001)(26005)(5660300002)(2906002)(478600001)(86362001)(6666004)(8676002)(1076003)(6916009)(54906003)(956004)(36756003)(8936002)(66556008)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+GAhloUhLl5c2D7ZVNkxXtfvPRcLO34pdLkNASHwzrzQwlswqqRDNkx6WoBs?=
 =?us-ascii?Q?ZfSFLkKRXaQPtNzbqowHVYc89tDkMqq5Qqq6cam2bUPot0SUaBYnaR1cTLvP?=
 =?us-ascii?Q?zFDEkAhD2eSrpUdtU/nXc8d9xYfplVMrRpXF2B6abKxFZvSH5kGp696N9Gr/?=
 =?us-ascii?Q?A+N7wPjhxwXI7pCFttnT4TMZdO1S0/GPxil1YYfikPy8Wn1sTNvTGi+iXU+s?=
 =?us-ascii?Q?VFg2CN5nE0j0TydToCgg3xZACkvusCf68CJ529fYoJOwrCgJP2zvtmWXspL4?=
 =?us-ascii?Q?mDpGj5eF87fHaY5WOZtCx9jTLf2FvQvwtbwtT28pmJhw3R8IYDaCZ6qKcu0e?=
 =?us-ascii?Q?Nuq9WSgRl6bsWSFQzuQFKVqnF0q0XyuMltpma03oFWfVNJk8uGUBBGwzkj2u?=
 =?us-ascii?Q?uoMpktbUkSIMm/u+R9a/G4ZJGsW86GDG/6Il7jqXZF2QlIK8W/0Ls0Rxt2ue?=
 =?us-ascii?Q?US2JsRmumHyzE7WJfxb+mhSlPceU/Kbym7di4dJV8J9YMu7sE/6FS2rQE+4r?=
 =?us-ascii?Q?d8+UCYKxoyqd/aUHujWRGlIUztMXereYPWO357hqwjYj9ptK/iIgJn+0POMy?=
 =?us-ascii?Q?1jyhRUHS/cSRR1LMM9/Ex2ogWq9oZ+eITb+q2o/V9gLR3ULAy0ENiY4I9uiq?=
 =?us-ascii?Q?C8GZ2hSYsqp9qBdowJgGNxCidm150MPLaQmSZFVCMsw3KWtK8U2f/p+bSQdR?=
 =?us-ascii?Q?JBzcE177+pYTsrPslZ1LHgYa/PoIYWA3omTk8Qdl4DQtz/+DCSS6VnvFbWsI?=
 =?us-ascii?Q?q9UnkxKoO7Sw4rWtQJpi7JoxpNK73Sa33HFZgrULhi09Ceq4enUbkufsUF07?=
 =?us-ascii?Q?19NSnKJ03Dusc+cDF7tEL7rmHTux+9j586OTd0dZrNVN/QHSBSF7Ge8s1dT8?=
 =?us-ascii?Q?UHdFFA4/wofLaVaiRQPQhxqslbgfhKZ4S0/TRh8F4ROe1LArlWXiLUlPaPAH?=
 =?us-ascii?Q?LFUGuPssCCOuMzfcw7pFdLHWg6DMFPt8AnnXBzcX/OqbreldgYBOYRRgEdLY?=
 =?us-ascii?Q?DFn1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2021 11:36:04.6560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9c86ab-4cf8-44c4-da72-08d8b6ee3f04
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3LcGC4zfp70xPPeLkqK9o3tSxhQClKeSCrEa456K7YHUlHpeNwGDXLrapVjfvI8U7LnYErHN8vx2bGn04bJz1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2660
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
Cc: prike.liang@amd.com, evan.quan@amd.com, ray.huang@amd.com,
 Xiaojian Du <Xiaojian.Du@amd.com>, dan.carpenter@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaojian Du <xiaojian.du@amd.com>

From: Xiaojian Du <Xiaojian.Du@amd.com>

This patch is to support the function to change power profile mode for
vangogh. Vangogh supports 5 kinds of power profile mode:
"FULL SCREEN 3D", "VIDEO", "VR", "COMPUTE" and "CUSTOM".

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index a38433ed3a72..a092b71ff1ec 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -178,6 +178,14 @@ static struct cmn2asic_mapping vangogh_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP_VALID(DPMCLOCKS),
 };
 
+static struct cmn2asic_mapping vangogh_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
+	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,		WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
+	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,		WORKLOAD_PPLIB_VIDEO_BIT),
+	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,			WORKLOAD_PPLIB_VR_BIT),
+	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,		WORKLOAD_PPLIB_COMPUTE_BIT),
+	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
+};
+
 static int vangogh_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -725,7 +733,8 @@ static int vangogh_get_power_profile_mode(struct smu_context *smu,
 {
 	static const char *profile_name[] = {
 					"BOOTUP_DEFAULT",
-					"FULL_SCREEN_3D",
+					"3D_FULL_SCREEN",
+					"POWER_SAVING",
 					"VIDEO",
 					"VR",
 					"COMPUTE",
@@ -765,6 +774,10 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
 		return -EINVAL;
 	}
 
+	if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
+			profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
+		return 0;
+
 	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
 	workload_type = smu_cmn_to_asic_specific_index(smu,
 						       CMN2ASIC_MAPPING_WORKLOAD,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
