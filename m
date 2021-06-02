Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB7FC47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 943D561C46
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943D561C46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BA316EDBC;
	Wed,  2 Jun 2021 16:50:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 328716EDB5
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1SKUTwpyFlIeCwxI3KeZPsn78FcQ4u8mBceR0ZGcsT0JLZwD+5h722uMXIMGkQTQPnsMxFkE6wdxcKp3wusS8NYnHyAHmRYZEf0QOOUw2AimrFMNTD9ovhZqhD6fEQ+CABB93cmtwGV1Fz8oBUQn91UVYKiGE9Y31IoN5M2OaLFeujpBub6+dSGSMBGzwD63Z+Ot1gkXalDiAzZSYTFuskYCGN5XD+uzzXDlLVjC4q9J5jTOh+TUJlCP34E5hj7eNYlM0JkPjgSY/9pd4lKh3PS/VgxibLJv8v9E2qFevOLc9RDPtnhgJ8IIcRQutuyLB8PRuz73mLZFI3tXu17QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhncoga9COVm9kv0DSceoWAc5njU4L0mn2FSbkfvZ5Q=;
 b=NSvvq7o5TyctV3sjflw+SIKsH7UiKybMMn4EHHoDbOERJ1edXbSPa/P++qMt4+Rsh/4CSScIIopRpCkpqp8qQGNZU29FAD+xzW0aUuxfjk/6PLNxM8gAJ3RReObET2XGkeIHDIuY5r2AGDAnFwQ4eVo82LJz5eLsmNBz84mJsdnFdd4geHRlhVQFtGRCrE6MF1XDklK7JIGP7ENJq3uVVIdzGQTzHEvCmpgnEHM0YdPQbZ2HFm8UUjtedn4LnxxRvvdCfWjJ602QDbn+yyhfz+bYGes1Xe6hR4u8i18t0BqevKPVGwLh1rTf+bGGne6zithb9MreIXIu0EyNrFVqJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhncoga9COVm9kv0DSceoWAc5njU4L0mn2FSbkfvZ5Q=;
 b=dhFUpIKMDmRri3OvxT5C76FCBMqLF9mjSXPgPcq5CuBMiVbsMBHtHsJtwaZ+4Eff4m3LSZDeEOgGiPC6hGeJ0QquIIfYUe93FqbVm4tJ0XrcabEIh4+eDvsqAKiGqul8Iw2vOgYUjuc+QcHJR2uT/M//oqZsjipQQlth8SAo+eg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:50:37 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:37 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 54/89] drm/amd/pm: implement is_dpm_running() callback for
 yellow carp
Date: Wed,  2 Jun 2021 12:48:33 -0400
Message-Id: <20210602164908.2848791-54-alexander.deucher@amd.com>
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
 Transport; Wed, 2 Jun 2021 16:50:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20db180f-2a3e-45f4-5456-08d925e67911
X-MS-TrafficTypeDiagnostic: MN2PR12MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4534147A700FD9BA76ABAD48F73D9@MN2PR12MB4534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eIn8Q3QlrCMvGYh3HDMagpa21dPwcuc8JqyUWS2qHlC4QaEoQF9B3jvrZ140RdMC+D1KQMZypmy9s3psnFG2+NHZsJy6iLAy5FOaNbukaXTW84paTEqsK1y12PaErjdeJbUQFnLEEGPawdkOKgfJS6c6SzgJP5gpOFtXQcvIVH8g7KbjWV6LYUDgny/ngbDyaX96ZsCo0GUqMKxUepGjf4rpMDXx6VHCi68iJCIdd6TGHBnXjffjcdfYyV31kwENbM9I29Q88NWRXXSTsGq5lVqrgAvqLYzJtPRFsVqCl1SRNOmz6ZJ4thBEfA4k3tifi6ESuIps3zi4ZTc2/mmXDH8+I7ozylB60pw/LmKLF8skB0YS5LM/2aI8qmbviXT3YCJ+bbUlr9f/JHcJrY3sdKfxJLTB55ZAygPHssGTxar8SganYRrjoWHDsBFjxgwf3XLZDgoazWNfRp2vs6a46Qkzl8qJ12MWK/ZqbDKY1/IXdP1bFJU2lf6OFevAgnpraHysPsvYY7pszY2Zrq3JY7e5bmweX0Qpp2moveAYZcZFtL5sswrAcpsFFB7h7ICgVF8hdUuKItxIYhfUvjV9tZUxCNldSwJShwqHUAMCFgcBCMiZ0t4YUd6ft6zX9KXVFMQ53NaPsVCoIj8qkmsyfEZGTMRM56Pe/IGCH5LE2/7ve1F3Ljd5NhZ0xTfU71ha
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(1076003)(8676002)(2906002)(8936002)(4326008)(2616005)(956004)(38350700002)(478600001)(38100700002)(83380400001)(66946007)(66476007)(66556008)(36756003)(54906003)(6486002)(52116002)(6916009)(316002)(6512007)(6506007)(16526019)(26005)(6666004)(5660300002)(186003)(86362001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ER8dGr0V7a/QGJphzO1lZeXeh8Vw0B3zp33dPIJRAJbzr4qrbRygT9+Bg/fM?=
 =?us-ascii?Q?LmFLgXr002QZ7FLsWqmhBAWCtRBzRUpydl6G2f08RzDSaXFD9z1Ute6Q5Lfh?=
 =?us-ascii?Q?tt6pNiX2Z4ksq60QbwVtmpp7MVbRG0P6F5tLJgeKcIbeu4i/0lmv9rVUJ8zy?=
 =?us-ascii?Q?qqd8Mb6iWrbDVgVmvrrRi+N5W+xZUr6PHE4C0Vw214N+c012ti+VBFzpr58e?=
 =?us-ascii?Q?+8JMhAkg/yCEd7PwQvuBqTDzSUhi00LyXLJf0XYF/RntynIQrJzvjz3JZVfe?=
 =?us-ascii?Q?mT33YW3Q3N+Pqt4yXs3E6hOYkGwCo/ziNwTfohnIcI56saMlLamG35xhFzcU?=
 =?us-ascii?Q?r40YsHc/UpI3zzaiTsOxzSeMQpts69y5Cih6YdzTTosqOvAAHSmJ0YB/wLVs?=
 =?us-ascii?Q?TyUaMh0gZTD+qRc6LRNAai+/edzCSBtwHb//qussQDSWCa6hFcd9vNGpjXsJ?=
 =?us-ascii?Q?lwJAlVnLjCd56aH68348nAlT0u13h5qn27MvpX0DoQJL/DD1wrUxi87KRNFS?=
 =?us-ascii?Q?aJF5hjZVKLiDklwB757M2WrspX1u/XaI1Sn1dVqat1QSwiI6Y3fqCJuQV+1L?=
 =?us-ascii?Q?/hbhCA1tVNKnIdHPD/rxhQCRs2KRwDNfUkg6br5RQZnbKAp+vg1IffYlBck9?=
 =?us-ascii?Q?tNjZYZq2bzOH7iN4qdaCCnzYdLIPLZMyOG3cBNyba0+aL9fy9wunhMGXzFB9?=
 =?us-ascii?Q?royYf9juTL57z64Q5st7soPW6rn1CaTv4IP1TMK+Sy5ksSZIIu3IUsNi/Y02?=
 =?us-ascii?Q?dUvmNDy2S0ttZ5M1aCLU0v1Q+vFBcyLJoPbHMKVwDU5TN4r6vOJLYymIvt07?=
 =?us-ascii?Q?sbpYh1i+guYQKDz5DKGToDpWWAQGhNC4XELXEsLe4gNBA8GThqF8z2k8zofZ?=
 =?us-ascii?Q?4RnDGwmBtOxqb+Q+j2DFd3YrddnhKpi3J1/oeez3hq311iaRJ9D1wlp7CiA9?=
 =?us-ascii?Q?srlaEKLMrLiiFlRjFo3yICjCdGkL199i3E0a7tBov/8IJPeTjMCqI2TQt+eO?=
 =?us-ascii?Q?oxGh1Bx3F7DlsE9XnELAWOE/nBWVRVP+RY6ROVCmdvCta1hcNXXvBjaM6cs4?=
 =?us-ascii?Q?+r7AasHE79KXbkyDBn1nx9NFFx9geVkYabnPOPKUFF/sX3za+qukYRzg/XM0?=
 =?us-ascii?Q?mawM3si+OhRfXKKAExVQ0FrGj89cbQcl4lwn8qhkmt+Iwt1HrX3qhsoN7Pib?=
 =?us-ascii?Q?cAk/CwEJY7deiv+iQAGaoYFGRsnWvoKfdVZNNSZ/JE2ewN3xwGWJv/amvMI/?=
 =?us-ascii?Q?lv0kOs0uPYKWkGP0/r6w5D9QSMv+d8gYEp9XP2hsU/bVBQ3Z8Dv2Ug7Yo5CG?=
 =?us-ascii?Q?YFDByJNd0+MwbfZ8xwRdqNNj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20db180f-2a3e-45f4-5456-08d925e67911
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:05.5033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Eo4rF+r+D8weina88YBm4Ystz9rKoyp/NWMSsgdG7zWo/7ImsofG9sNmY++mB4bBZmwZGgTssEpjtLUmz7KlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
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

Implement function to check if DPM is running for yellow carp.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 30 +++++++++++++------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index ff75f18c99a3..935754e0de95 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -42,6 +42,18 @@
 #undef pr_info
 #undef pr_debug
 
+#define FEATURE_MASK(feature) (1ULL << feature)
+#define SMC_DPM_FEATURE ( \
+	FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
+	FEATURE_MASK(FEATURE_VCN_DPM_BIT)	 | \
+	FEATURE_MASK(FEATURE_FCLK_DPM_BIT)	 | \
+	FEATURE_MASK(FEATURE_SOCCLK_DPM_BIT)	 | \
+	FEATURE_MASK(FEATURE_MP0CLK_DPM_BIT)	 | \
+	FEATURE_MASK(FEATURE_LCLK_DPM_BIT)	 | \
+	FEATURE_MASK(FEATURE_SHUBCLK_DPM_BIT)	 | \
+	FEATURE_MASK(FEATURE_DCFCLK_DPM_BIT)| \
+	FEATURE_MASK(FEATURE_GFX_DPM_BIT))
+
 static struct cmn2asic_msg_mapping yellow_carp_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,			1),
 	MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,		1),
@@ -198,18 +210,18 @@ static int yellow_carp_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 
 static bool yellow_carp_is_dpm_running(struct smu_context *smu)
 {
-	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+	uint32_t feature_mask[2];
+	uint64_t feature_enabled;
+
+	ret = smu_cmn_get_enabled_32_bits_mask(smu, feature_mask, 2);
 
-	/*
-	 * Until now, the pmfw hasn't exported the interface of SMU
-	 * feature mask to APU SKU so just force on all the feature
-	 * at early initial stage.
-	 */
-	if (adev->in_suspend)
+	if (ret)
 		return false;
-	else
-		return true;
 
+	feature_enabled = (uint64_t)feature_mask[1] << 32 | feature_mask[0];
+
+	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
 static int yellow_carp_post_smu_init(struct smu_context *smu)
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
