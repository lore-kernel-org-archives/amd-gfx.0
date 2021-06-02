Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D25C47097
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C92E61C46
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C92E61C46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C5936EDB9;
	Wed,  2 Jun 2021 16:50:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D71E66EDB5
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+p87DHUvNL7GuAVR7XBOcqZK90a2R2SXTBwdQbyB2G4jwCmoyKKcCIo63mQ30TVbZFHI0+OYnSG8i6ip2cEKvmBGDBa2N4Wa18QZQFCB3h2wgiUQw7+RGNQlO7LSzDjaHSWVmaq1DzAmYAVag6g8dIuASNr96M7LQj2e3i3jXVoiEvKQuSiy5nuT9TDmODs6vVf2JEYsnxKwm6BkkkyIddjs9JAd2UgYYdM15OY69snxyHcGh8q6/Jp1mZUbnmYsJmZPb1Y8QbjuXXrnREAvhpJIJ6sRAMR8K+5+BfjYgF/fTKVm35uJAKpDnDeMISM2AqxCr3LiJx9PO4dkwdPIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWpMd9fSUlC/dyNSGEjEBkjwNJ/AndPjFh6Kl4WURp8=;
 b=hMT92slnCF+7yZsqIVzhsdxsf131ELyhe5083UuHN366W/nZt69bLWLjtCg2UG7VIkEJYkBw/kYbh4Dgb8/hqL2BtnXEy+QcDCXK9tyY+USXVLqihCtmnYJ+TmIvMnG6v4vkPrcVVpQ38w2myu2tqsncrnVRAEnOiLRkrqwRGNS8YZKd8UIfwtKbgX1cRVjwj0rhiu2/fdqSP+ebgmllKh0co1D0Fg+2k9zxrY2mGgSFDTp1hnJINeUi/D+K/2OrTG8zkjwE2Xua7A4WBH6KbSqPS+5j43k2CZPoNIJ1jvO4eNXarxIfWIw3EVArQFWKL1oHOQf0KS1NB27RvqFOPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWpMd9fSUlC/dyNSGEjEBkjwNJ/AndPjFh6Kl4WURp8=;
 b=oX5A0p1Msc8HGLCGLxlQ8X25wmD98RDGCng8604I1m75DC5h0ucqM7FBUrJj2u0BBiFGgdkbi5+rvn1tE40jvHTextJQQOang6S+37zR1H2XuPamY+kpzK2MvQeDgNODzPfaOwAc/A7YvllHl1Lbn9oscVOApMe1S21GMd0xyJ8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Wed, 2 Jun
 2021 16:50:37 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:37 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 53/89] drm/amd/pm: add feature map for yellow carp
Date: Wed,  2 Jun 2021 12:48:32 -0400
Message-Id: <20210602164908.2848791-53-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:50:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fc7e9be-7f27-4d7a-1346-08d925e678b2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4487:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44871AD26B2846F7AA0BA19EF73D9@MN2PR12MB4487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kHKIg6381VNPEs63cdOnBEkktRmG6USv3D0Qn3SUwqlKhWI6BOHAIkX1C5iVr8CKRixjGEnCppxZsyJhMyGzFKu8Ocv1U6O8V6iJ1KshR6uNHdMdNqqQTEztbOEiLS5eEaCG0Jr8gxt17Q4x/ilUbSdXYf1Zz/2Vu/dqmLJnthfSJfxsK8GkyFbYTQmiwhkc2kW15yY0NsTG851BQ2rfFuwu4rO+mafphtARW98vj6cy58Bf/kFAYRvTQ+RmZPKthwq9Lh8WqViafa1vdA+Vwurco9TMcoqtljIW+ucbBgLZns5B18xfxPR2dPPUGCl1BtTFaYKpmDVjHd7X8OOqHNPOrN6F2d5X1KjUa/FTrCpzRUr2sC6Q0ne//9Ie7TKmOBUpjxefEOa8T5p4w+7IpBTZPKK04TnqxW4qp5Z7m1zlxhMsF5UpRzfHs/D3/HqOIewhjQ19Wt8yW8hA7WFrxjrzTq4CQq+Iv8LDNvF3wq2znMyHIetLCcpZZ8ZZanTP4kx6ZcZiq1Uuym1uXM2729LbnX30rlwnrYRuG4AHpzIWS10I3sAD7ilIFePC7bNILwHsBAFbFxthgjaMWj4/sLoXlNIuJ4CyHYei3c5nDgFkm/A4e9sYHkdbCkMgY7eCuA5LIXnMwn2JxaqpyVrl82MCaV79gkSDrHsGECFP9SQt4YfwSD5vLRHL+nvXqLgc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(86362001)(54906003)(1076003)(8676002)(478600001)(6916009)(6506007)(2906002)(38350700002)(8936002)(316002)(6666004)(36756003)(66476007)(52116002)(16526019)(186003)(26005)(83380400001)(5660300002)(6512007)(6486002)(4326008)(956004)(2616005)(66556008)(38100700002)(66946007)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tYws1Pmsx1lv4tF+ZkqKkmjoY+u+hueYI3KEBEy8AzyXQyOxkPDPvy5ZKX7b?=
 =?us-ascii?Q?SPcg66h5LJ80uPMkdFEwU93wFGPAxHZv9R5vIvW2xO6yM6OT0aVY9/Pp/P7y?=
 =?us-ascii?Q?ihjEVXP7boZHoEO7mB2B+xuyB44KiweToep1O2AsQUTvQifZZ8yY8JneBEMZ?=
 =?us-ascii?Q?YJczbYRHSwzTGPWmpBJyH6JjJIylkHCQpS2TYxADDA7u7jyvPkRAXXFcGhh4?=
 =?us-ascii?Q?K2KaIBroQZR19dlxWvxYUEEw6URWDu7izzJxt8YFiaBRNh/hCKW8sVmA921l?=
 =?us-ascii?Q?6OakwcOhGeFBnwy/Zs7GU9Pc8untbY22Iq3oUuH9LHE3uyT1FUUrCZWKvap8?=
 =?us-ascii?Q?n84pfhvYnvfb5AyWQKFt2YF89c21OYIIyA6e+EKn7FotFUEplRsKw8g7oqBg?=
 =?us-ascii?Q?aVCzN0fDgqmYyOKpqawKndj82JXJulJZgW6nAT/WZ6k/2G/pXVZXoQ4e9MgV?=
 =?us-ascii?Q?57c4HJumQsVD9bDJrsVIsAUp+W36XA+XYMpuGyOHuiy1SUGt4Ujj5vc3kQts?=
 =?us-ascii?Q?mVWMPha3w+afcqRR4yo3Kza3x9Xrgp3HM4b1yuzk/xIspoWXcykekPfFCezG?=
 =?us-ascii?Q?b3/POFTsyf/XH+/B+aL6JDUNW7ng/se13GRY8o7rRoVmLw6b/YsLC+0FlcOl?=
 =?us-ascii?Q?UH+uPWXKrNgg11FLRT4xpZPcKUUiKFnR1DEATnzTW+BA1nDbA1oqlvn19G7O?=
 =?us-ascii?Q?gS3g7fS2QrqG/9OvNKt1MJooSfmiL9Y/38qcTBq8vKr9oJFThrJilQyjkYZU?=
 =?us-ascii?Q?Q2m1zCjAB6I756JS6wWp4ACv/M1jDb0i6b5LF+IXDoj0prQsZ8p/lZtwaf+Y?=
 =?us-ascii?Q?nE010+GZpxDns6BeTeSFKYkTT3AvKdtY/2J+e+LpinsmC645VKT4XRuuBd8u?=
 =?us-ascii?Q?FZ/p3rzFRh5Ih6MT0g1uGH3wnoSOZnGgxHRdsFDjropRDA02u1NiuE+8eomU?=
 =?us-ascii?Q?7jSP7CxPFmI2f7Hqt9ASNl0YhqfZhWApsuHHqGrKuhVWj0+KrqBqzmavrOCU?=
 =?us-ascii?Q?uf0W4jqnA9oCFzDKiL/a8Zgcm/NSRWz/Xs5hXd1C0YgN44FJN8nbaiKSiIG+?=
 =?us-ascii?Q?yyLT7qqTeN9nEb79GgMt097SYmtY110lBR3m4mPdV5fkWYNgTXcaC02p51H/?=
 =?us-ascii?Q?Wc7BcOs2sJWuV8S/Wsx5bcDrzi7V9Ei3quL3cUonLKmNgAqpSvkoXqYev+dD?=
 =?us-ascii?Q?7sTzPNORCSMT6BFImITAZw5VvupqY/FgR+g1IJIs9P/y61d709pMJOk+JrYn?=
 =?us-ascii?Q?mWtr+G+OOrXFwU8o5bBVd8PqEIWr98puQ6aC+ApRn4Z4wRqkaSD/Hq2vmOCa?=
 =?us-ascii?Q?kHN2IBiiEbd4pfnF2uiEFIJf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc7e9be-7f27-4d7a-1346-08d925e678b2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:04.8910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpQEouOf0ttl5DuemFCaJ0m58VRI3tX11kUS/rfq0B1rIUTJRNvVVvlxVH6O6yqn8oXeLvwGVtmzeQXZtkp+fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>

Add feature map for yellow carp.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 211cc9bf1ca9..ff75f18c99a3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -75,6 +75,47 @@ static struct cmn2asic_msg_mapping yellow_carp_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(SetSoftMinSocclkByFreq,         PPSMC_MSG_SetSoftMinSocclkByFreq,	1),
 };
 
+static struct cmn2asic_mapping yellow_carp_feature_mask_map[SMU_FEATURE_COUNT] = {
+	FEA_MAP(CCLK_DPM),
+	FEA_MAP(FAN_CONTROLLER),
+	FEA_MAP(PPT),
+	FEA_MAP(TDC),
+	FEA_MAP(THERMAL),
+	FEA_MAP(ULV),
+	FEA_MAP(VCN_DPM),
+	FEA_MAP_REVERSE(FCLK),
+	FEA_MAP_REVERSE(SOCCLK),
+	FEA_MAP(LCLK_DPM),
+	FEA_MAP(SHUBCLK_DPM),
+	FEA_MAP(DCFCLK_DPM),
+	FEA_MAP_HALF_REVERSE(GFX),
+	FEA_MAP(DS_GFXCLK),
+	FEA_MAP(DS_SOCCLK),
+	FEA_MAP(DS_LCLK),
+	FEA_MAP(DS_DCFCLK),
+	FEA_MAP(DS_FCLK),
+	FEA_MAP(DS_MP1CLK),
+	FEA_MAP(DS_MP0CLK),
+	FEA_MAP(GFX_DEM),
+	FEA_MAP(PSI),
+	FEA_MAP(PROCHOT),
+	FEA_MAP(CPUOFF),
+	FEA_MAP(STAPM),
+	FEA_MAP(S0I3),
+	FEA_MAP(PERF_LIMIT),
+	FEA_MAP(CORE_DLDO),
+	FEA_MAP(RSMU_LOW_POWER),
+	FEA_MAP(SMN_LOW_POWER),
+	FEA_MAP(THM_LOW_POWER),
+	FEA_MAP(SMUIO_LOW_POWER),
+	FEA_MAP(MP1_LOW_POWER),
+	FEA_MAP(DS_VCN),
+	FEA_MAP(CPPC),
+	FEA_MAP(DF_CSTATES),
+	FEA_MAP(MSMU_LOW_POWER),
+	FEA_MAP(ATHUB_PG),
+};
+
 static struct cmn2asic_mapping yellow_carp_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP_VALID(WATERMARKS),
 	TAB_MAP_VALID(SMU_METRICS),
@@ -648,6 +689,7 @@ void yellow_carp_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &yellow_carp_ppt_funcs;
 	smu->message_map = yellow_carp_message_map;
+	smu->feature_map = yellow_carp_feature_mask_map;
 	smu->table_map = yellow_carp_table_map;
 	smu->is_apu = true;
 }
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
