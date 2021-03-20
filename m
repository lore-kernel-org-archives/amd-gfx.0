Return-Path: <SRS0=4T84=IS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21907C433DB
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:19:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7B786196F
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B786196F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 929006EB1B;
	Sat, 20 Mar 2021 04:19:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DAA66EB1B
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Mar 2021 04:19:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpF5nEj7bcSJ7Z4+7eGiKLuw1mZT1K5/pYIWGejKlcCw7RLPszvCURujGnPw1vrpaYzhueVQtOzLxilIel1pi6Wdbjgsh/H9onOL77NRUvttpfdYIXVNotx8cN1uirvCDQ0EnyQZnwpDXk7IAfuZ1S6g0KrDGh/GfsTKMlp9Yd0gfOb0D5baq8y39Lh8VQAE+7Uif6+QgESMu/5xb/y7PB70hTdNcvykCYJIKbxAseIFz/SOmD2PXu94n2z2e72U9v+4d6V6wFjl9nJAYjoNmYy1O+bvoS2CK9K+GagK8gEhA6tdKKIzmyNU5996dL+6PYwuhhnq+Qvg50GWGOBbuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59hPhAiWdtwMkY+4HkIfRANfRF+Z+uS/w9cytSDwfeU=;
 b=F8SJjdRGJFXzESr5COmlGOjJlgtLWvUOvgNidfVR+CmHc3eKI9y3WL1gdAkMO4X2XMLUbjPKyBiouRP6A/wrLkL8/Wng+kjNSqhJK8/LxOYtg8ZyfVVdMn+v5z97KSWTrVd8LDjDaMCkJDa2tMK6aLhIydkz4oBpR9P+VAtC0D4sYreJJEXxigEDGnNwJnGh+xTOgTJBhGYlT8spDwNPxN4KDvCtbKVYc19x+R/oJhGfVlpd31kLxAq9Wam5ybmRaVB81KvQEPL6EPyLqBWLvXMrhcj5ItZ2odNwUwloravWjvyq+M9t7YTHwKZ3oI2Gyda/r53RCfTZ5nfacOpd/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59hPhAiWdtwMkY+4HkIfRANfRF+Z+uS/w9cytSDwfeU=;
 b=hzbpaeIYPd4K8XkZW2uxzqiqaiUqoPf5nF6nfyYykTf5IMqp2g6jALANlsCe5vv82YG7Jsy+9Ov4vu7VCquiJI1g0yaEjnXwzWPaKsI0IzBoOrUa/pdbquxAjnhJ0JOVvUufZE+zqmk6sl4P45+mGtdAV6va7lxVPsxqUSvlegw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2605.namprd12.prod.outlook.com (2603:10b6:805:6a::11)
 by SN6PR12MB4704.namprd12.prod.outlook.com (2603:10b6:805:e8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sat, 20 Mar
 2021 04:18:58 +0000
Received: from SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1]) by SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1%6]) with mapi id 15.20.3955.018; Sat, 20 Mar 2021
 04:18:58 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/14] drm/amd/display: revert max lb lines change
Date: Sat, 20 Mar 2021 09:46:46 +0800
Message-Id: <20210320014656.23350-5-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210320014656.23350-1-solomon.chiu@amd.com>
References: <20210320014656.23350-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HKAPR03CA0030.apcprd03.prod.outlook.com
 (2603:1096:203:c9::17) To SN6PR12MB2605.namprd12.prod.outlook.com
 (2603:10b6:805:6a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HKAPR03CA0030.apcprd03.prod.outlook.com (2603:1096:203:c9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.9 via Frontend Transport; Sat, 20 Mar 2021 04:18:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8d413ddf-e9c2-401d-88fd-08d8eb57484c
X-MS-TrafficTypeDiagnostic: SN6PR12MB4704:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4704D602FB940F0E4FFF03A497679@SN6PR12MB4704.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: amaG+QApqjq6NruwC/p/jB/D14F/UduFB3TCEIt8GcDCSUKY0dsemgSNTHKFZ6zMP4IBxPjUG/5umXeXS69KJcKx06tlCS8Rz3g/goM6nZuQoqgshWiH9oYnOjGBWY+BBUSZijaClCdMKwDpyI92fya9ulChZDTa5jyhcMg9OTA1YKg3KdRU0eC5fklQGy6VX3962RW4b+XKMtTy0vWzzpQCksErKywvs8EWHWLoz2nhreGTczBByPuhSNsH0D5DmWPowegqg7NDNbabbNhG+p9z3+53M/4WXhvmBN4hubljggR0vDt/3BJFX6WNqeM3ZQuR+aV/N1bQAVrBZM2w5PGDKZVkpPiZJ8fvP5HyKOqQN8TBCAILv9vBRBVbHbiPK+QncnW0wOV/dvn/iGklvrMX85LMBrBF+B2AECbBD71WFlKiKKOO0mjwGdqD0OO8MDDLIhEhOIZbp9as8PLxuPyBC27S7wIt9MdRHpkg5BHxBnJyoOsqXpsDa3U0LyuRSK0dqRooxAIMB4v4Cek9M4iAtqmMrSwOgkEnfvabgvmMlR6a01UJT+rS7ludA4j3d49I58PdYJcBCgBJcF612xkwhj2fPYPbajJleTMavKoMp+1sjRXk0S+K9XSCKipotWzQUA0gRZPAucdpM43m+EbXlqd0+LlNCRbeXUmp99M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2605.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(8936002)(6512007)(44832011)(6666004)(26005)(478600001)(4326008)(8676002)(52116002)(38100700001)(36756003)(316002)(86362001)(6916009)(6486002)(1076003)(2616005)(54906003)(83380400001)(5660300002)(66556008)(66946007)(186003)(956004)(16526019)(66476007)(2906002)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?w6TjNBxMPCvfFkvKZb70+ZddD5PaBzxVn+27J/WaFOw3rbsBTxjuYJP3OyG5?=
 =?us-ascii?Q?hinpqanoWJ2BlumP0XEBaFqiPolSrDNYwQSdZWP0FazMBhKALTNgNGwuUE8Y?=
 =?us-ascii?Q?BOrCdCo/dW+D857pkoeQtl1+iEYdqT41mcuCsCI/2UGVBKnX8AovRUxp6ApI?=
 =?us-ascii?Q?+fvl3YOid/zegILeDfcvWpObTtjk1GViNje+5uhUJ8s3hkVjp/YLwiA0H0s3?=
 =?us-ascii?Q?vpLASNkS7xRYTEVwAdSqqxA8OhfrhN7A/MuUJUmd4K2vuCqIdbPdrOwNxZSo?=
 =?us-ascii?Q?o4UydVo2rC9GcIjXWW0OTkAOdycCMIRGkizFI2PqMAsIsIVL5vqy3+pF41/w?=
 =?us-ascii?Q?T6yunO3te0Mob1j4a9xMoV0qrJBl/GCH7/kwHGPStfsGVux4oZZapulUmd03?=
 =?us-ascii?Q?WNXld4F/j9VNIvhmrVW2DUbOWXCeRK9pswIEcAqcKb/HNx/Mh4ujRB6P32p9?=
 =?us-ascii?Q?R29k74cfQkAnKxzoGy8xny7WvbyDCde+4nTUetykTP7BOX83CCDy8A3pkIz1?=
 =?us-ascii?Q?BlndOirjZ+IdJZQcQZ0wjO0ZZrquYu67SZbCd1lmr6cvpp3FSBU22+Rlvq+7?=
 =?us-ascii?Q?WNaxw4QK8z/dlloUuwqtUFcOSVhwcH1xR0HR/ho72WIyyQBbgRcz/O1kIxjI?=
 =?us-ascii?Q?6LlD7j3lOEDgfGujiE2lkzhF77CpNZvqHMO1Qe0YO9on3/Hs6xdrqRVL6CWC?=
 =?us-ascii?Q?85+OC5/HFnD76EBqJ+QRy5Je8RKSY3U65BGOg7bAjsJ6tht8+hQtcaiNxPcm?=
 =?us-ascii?Q?GXXb/D5lZLkWo5T6JEWeSkzDSzzT4cfri7cBG9Y3XcOKFUNMJPjI7fwIQqFb?=
 =?us-ascii?Q?Jw6ESypOm1GHinDVKqqOXARIhebn61Tvf7Xke/5vYS/rNE2f7hqodVbkDLaa?=
 =?us-ascii?Q?KWVFFcvxmqRNUa6ymanr8L7oLYg6LzL3zecYqNIsEXscyIQaXoN3W2NtblYA?=
 =?us-ascii?Q?/aUnbub4vaZsC8ofwX2ZAZK31vsS153eVgbBSNBLhRTFQ3XIOnKMgGZjFGqw?=
 =?us-ascii?Q?v164/bU9Wj56ddT1xreclhT5KwVBE9cJqgmaq0EsjHYGDWtIDBRuVlE35NAK?=
 =?us-ascii?Q?bChrCfU4DpwvLLG//swdOIXJ650yZITUlY0TSszFxtBp7Ki5a5TKOAdqw0Tb?=
 =?us-ascii?Q?koIvkuV81xz+wiymEyM1pR9whLakuPtjpnWwjDn+hsDsvxrwyluZRZubWNYj?=
 =?us-ascii?Q?KrkIUwtMK4DSA2SlZmFNpv8JYk9ng6kMKKaYTNiyAo+469N4sKH1yCmrGRSg?=
 =?us-ascii?Q?RTClEKL9DSL0U3XKkfPMtq/j/tjixsJiZ8E15qCQm6bQttDGX+FxVdsdlYVJ?=
 =?us-ascii?Q?bvPOt+jHGG0F24BLWrDtq4PG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d413ddf-e9c2-401d-88fd-08d8eb57484c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2605.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2021 04:18:58.3151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xmjs0cgHoIMLiM6a53Y9DMknjD0BC872xBhqxiRbmuMNtXq0c3KI8afCZEmzQy+yJxKADf3Xbhpq07jEwAyFPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4704
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Eryk.Brol@amd.com,
 Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Eric Bernstein <Eric.Bernstein@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Some hardware revisions do have a max number of lines limitation
not honouring which can cause pstate switch underflow.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Eric Bernstein <Eric.Bernstein@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c   | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index d079f4e491e5..0b1000d782a8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -82,7 +82,7 @@ const struct _vcs_dpi_ip_params_st dcn1_0_ip = {
 	.meta_chunk_size_kbytes = 2,
 	.writeback_chunk_size_kbytes = 2,
 	.line_buffer_size_bits = 589824,
-	.max_line_buffer_lines = 32,
+	.max_line_buffer_lines = 12,
 	.IsLineBufferBppFixed = 0,
 	.LineBufferFixedBpp = -1,
 	.writeback_luma_buffer_size_kbytes = 12,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 2307b3517821..b8acad7acd94 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -112,7 +112,7 @@ struct _vcs_dpi_ip_params_st dcn2_0_ip = {
 	.is_line_buffer_bpp_fixed = 0,
 	.line_buffer_fixed_bpp = 0,
 	.dcc_supported = true,
-	.max_line_buffer_lines = 32,
+	.max_line_buffer_lines = 12,
 	.writeback_luma_buffer_size_kbytes = 12,
 	.writeback_chroma_buffer_size_kbytes = 8,
 	.writeback_chroma_line_buffer_width_pixels = 4,
@@ -180,7 +180,7 @@ static struct _vcs_dpi_ip_params_st dcn2_0_nv14_ip = {
 	.is_line_buffer_bpp_fixed = 0,
 	.line_buffer_fixed_bpp = 0,
 	.dcc_supported = true,
-	.max_line_buffer_lines = 32,
+	.max_line_buffer_lines = 12,
 	.writeback_luma_buffer_size_kbytes = 12,
 	.writeback_chroma_buffer_size_kbytes = 8,
 	.writeback_chroma_line_buffer_width_pixels = 4,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 7123151ed60f..8e3f1d0b4cc3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -114,7 +114,7 @@ struct _vcs_dpi_ip_params_st dcn2_1_ip = {
 	.is_line_buffer_bpp_fixed = 0,
 	.line_buffer_fixed_bpp = 0,
 	.dcc_supported = true,
-	.max_line_buffer_lines = 32,
+	.max_line_buffer_lines = 12,
 	.writeback_luma_buffer_size_kbytes = 12,
 	.writeback_chroma_buffer_size_kbytes = 8,
 	.writeback_chroma_line_buffer_width_pixels = 4,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 263c2986682d..4a5fa23d8e7b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -120,7 +120,7 @@ struct _vcs_dpi_ip_params_st dcn3_0_ip = {
 	.dcc_supported = true,
 	.writeback_interface_buffer_size_kbytes = 90,
 	.writeback_line_buffer_buffer_size = 0,
-	.max_line_buffer_lines = 32,
+	.max_line_buffer_lines = 12,
 	.writeback_luma_buffer_size_kbytes = 12,  // writeback_line_buffer_buffer_size = 656640
 	.writeback_chroma_buffer_size_kbytes = 8,
 	.writeback_chroma_line_buffer_width_pixels = 4,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 0fbdfff87835..10c1884e3d30 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -116,7 +116,7 @@ struct _vcs_dpi_ip_params_st dcn3_01_ip = {
 	.dcc_supported = true,
 	.writeback_interface_buffer_size_kbytes = 90,
 	.writeback_line_buffer_buffer_size = 656640,
-	.max_line_buffer_lines = 32,
+	.max_line_buffer_lines = 12,
 	.writeback_luma_buffer_size_kbytes = 12,  // writeback_line_buffer_buffer_size = 656640
 	.writeback_chroma_buffer_size_kbytes = 8,
 	.writeback_chroma_line_buffer_width_pixels = 4,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 0723e29fd42e..a928c1d9a557 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -101,7 +101,7 @@ struct _vcs_dpi_ip_params_st dcn3_02_ip = {
 		.dcc_supported = true,
 		.writeback_interface_buffer_size_kbytes = 90,
 		.writeback_line_buffer_buffer_size = 0,
-		.max_line_buffer_lines = 32,
+		.max_line_buffer_lines = 12,
 		.writeback_luma_buffer_size_kbytes = 12,  // writeback_line_buffer_buffer_size = 656640
 		.writeback_chroma_buffer_size_kbytes = 8,
 		.writeback_chroma_line_buffer_width_pixels = 4,
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
