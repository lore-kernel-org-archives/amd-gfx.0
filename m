Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014F4C4707A
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 21:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B435B613EC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 21:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B435B613EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A6836F922;
	Fri, 21 May 2021 21:19:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 090646F91F
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 21:19:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7V+h6aTKz68aTVwFwPpGpce6hPOLqWfaYWLmbIoI+MarRbpOMnbdCyZhTbUg50byvdUrSS5TzCDRGxmeXvmpmnzbWe+oQJRFk5ZmXLbN99H2dQ03hvP6DC74HRPE1ft2jBJWj7dDhVgwKu5xmpMAMa1VsywgVLI3XfisORHXnqe1PxUefI4FQXGnq8lu8jNRRJLU44Ib4foVYPdhkx9qhVh/ZadB16xYkDS0Qoycunzf92safHye8Fnli7tXeTFM3d1Z3UWkPffRrTM1MOEBjkO9aR3DpFEk2mxF0EDy132OGLJ7d4b/vT0Bw0vIPvZq72MHyGW/1wpb58wbfO4AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSDJzTZmrQBPxDfjlsde27TXfmdg31UElGZWHaHvFEc=;
 b=AJI2CxqURHQHYBT+g/PgbirK8nl8IhbA8tiYytzvP8GHZRA9Kp5SjfrLUHSRwjVd+QYzSLN6hKn0PW9qrqHJXuePob2XqTLTSl4REuOy0ASoJxaeHq+6NPhlrPWIxGY4rrZmZFZqeqK2YC6KHNK6l47DlHixSruwYkYDz4xRcn4nE6vZdcGlxHZymEYb2nRyak8OWS5UHrD02NiqLczF0aFWOztAHhhRj5Y+RXC/S+kM2HYwFYAbWEQfVls/WihvviceuKCGyspi9PWNjkdCZZZv6edmtmR7NAg6TCOq8bFKdhaOR2INPl0yvWq/5bNy47RcFxYMN9xPS+qaRIs7xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSDJzTZmrQBPxDfjlsde27TXfmdg31UElGZWHaHvFEc=;
 b=uhnuxavQlPZqbPMT+avIXSZF5IpZAFnUM5GCLDiozzZS7xUYjI4TePInM18b1qQCFTZH5p/AEsHlkgzAvBf3PVboGKfuI1VWzmLUgR5Oc0E6dVroS4gy2LF6G7S6GDSd/fT78XTAR0sWSvEQudGNIJCKY9m0Yapy7p9uQGORqdY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 21:18:58 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4150.026; Fri, 21 May 2021
 21:18:56 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: Fix RAS function interface
Date: Fri, 21 May 2021 17:18:35 -0400
Message-Id: <20210521211836.4839-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.1.527.g2d677e5b15
In-Reply-To: <20210521211836.4839-1-luben.tuikov@amd.com>
References: <20210521211836.4839-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::24) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0085.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Fri, 21 May 2021 21:18:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c60f01c-b9a1-4faf-be04-08d91c9e0b13
X-MS-TrafficTypeDiagnostic: DM6PR12MB4516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4516BAF219C752718E82D9A699299@DM6PR12MB4516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aBr6ljGFuS/qJrEXK8ZARZL0ZZ6G8f4jEbGQYNJmSTehTKaiwZG9XHOTafpN/bt9iVILSAj0Ayl6ia/1os9TMGdbGQ8uli85MJDjta2dn3Z5QjLSYTX2VsRpgRnVugDbI2nkqlCvacAxqD7zZN38OXcErtR2a1zH+CquRGwYHQ199LoCz5ANzro6kyXef4XHvhxW5FWMZpp5j4TfaMI8rPDNMYW3UMMU0LRHgs/G5RGd0AcuDs/30h6PVIHGE5o3ISc163VLeyrjXJ+lN/GaI/Lm7QliqUUYwIOYg6gsbU42KUc0QAqrvYA2yFsRfGTWxG5Gtk6iYfuH/sY6KnbMYN2/lBff+9ldCLlEMqvzUg+lt64WMzia0+drBHU0KoQJVbh2NciFaseM4GXS7VsoTgNfr+MeheMRRGp0wKGP6EQL1DASnI3GJrO5qgaEfr06DNbUClspvSJVoDNkFOSDDt+Mb98wJxBZUXIsYaN7cLTuID6wy8+rfZiqsNyJft+EE3R09nKzAat0E2wzzWAOkQyO2e0IJ3D6jN67KfEiuVXhrM/huUMWcxXrmsOYpuokGwuj5mG1fmpVu5449qxn86KeVCzC7l0Un5ySoNqCWceQWU75yIdeEpdDI8gclQby17RRNXGJ5JmzKdZZjG5A/qKOOGgYYBlUNm796fQdN3bv5usA3Cdsb79sE96ItjvV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(8936002)(2906002)(8676002)(6916009)(1076003)(186003)(54906003)(66946007)(26005)(83380400001)(66476007)(6486002)(66556008)(6666004)(55236004)(6506007)(6512007)(316002)(38100700002)(52116002)(38350700002)(16526019)(2616005)(956004)(86362001)(478600001)(4326008)(5660300002)(36756003)(44832011)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NADGHPRTfMvv89fcYp8KuiNE0P5JoljiDXuhHBfP2TwtrWjHa85G57rfqHdy?=
 =?us-ascii?Q?mjsHZn14fYdQ+DJ0eV4jDUPUQYKvk2neCjCgEQ+fvimKvmaIRyob0lCqXNFb?=
 =?us-ascii?Q?8a4KaAmPr91u4Ufj36+AjLuHHhuFm2IxMT9mFG6UOYvFQ3dD/JywSBHjI2pO?=
 =?us-ascii?Q?/jxBMlkVcQ6RX+fHhNpqeRjqmzjjyCyq9b0U3DoUSTOF6MPeTHXd0FqR5Kh1?=
 =?us-ascii?Q?+B1ZmA2iH8I+QWTPNhGu3HAIW7fXbPak0FLd8ObGfuQB9Hm60pQlaRf1G+zu?=
 =?us-ascii?Q?gdjkwooY9cPp1Sv7fEZRQaemdPo1fk3aZe15WcQCy9RlnB0q43s9e/tDabwr?=
 =?us-ascii?Q?ZOqTOV4RFdiKPg3KBnERd/P0orq1bH32efKKResGBHXbchmsgmyt2Wr18bzs?=
 =?us-ascii?Q?X2bwNSHopbhs00om3gXyAdMsn7UoE6LY6bL0xVINhboTkto8s4uOPKlsA2Fp?=
 =?us-ascii?Q?bDZSoAD+DURlGcCLfAKAkxflzS0mnJFklKwvXrf6Egl7VWmd6ww3PVgx4Udt?=
 =?us-ascii?Q?3ciiIFUF8hFFTz4ZIhA0mTAIZqwO47IzKK3UFr55uRuO8f8C7MKF06V5XaeJ?=
 =?us-ascii?Q?Q7DNfW63eKasHoI4Lk9SgJCyoDEKbJ+hdW4tAnzyCqR0uf9tNHrT2BSMsvpY?=
 =?us-ascii?Q?gmo3/eOfl4HhuS7Uq/bH3Rfr2Owod1WusKKik3U+P4tBCIoIP4bfKNa3PVao?=
 =?us-ascii?Q?6bt/44qilBdB11oXu6j+uQCihvOsr2TzPPIE1N52mWgOihsO3BGYQtqP4yRd?=
 =?us-ascii?Q?OtYvx1M2+h37cnBCzB9MEXEkFGi37pbcRDfKKPWU4hZYSe30AVLsImCaEbTN?=
 =?us-ascii?Q?Q2qF6CAgvUHkNmmf7nLASvufiApCQcubvVbcXhTk2NA3uMS3TNTkvZE3Tyhv?=
 =?us-ascii?Q?beQF+7k0/gRXFVR+dOFIMW5kG5P/9fVJtzq6837YPnBuM77aIEv/3BfQfQmb?=
 =?us-ascii?Q?vHmZ9VwvOP95rvn4JE5q6MLyxaU/qCeM/ROnuNOi93SA88eTy/YSh+kGiPU5?=
 =?us-ascii?Q?gMPeJVq8t5zNR9uWTVXnsUDHvrjkWUSsDU3ooXpYBwdGlhv/hfl9PP4aVE/4?=
 =?us-ascii?Q?5jZTfoz+ZYW+8OWbJRePWFvqTwbZXvwXE83Q1kdA4P3S9jRt5ogQrwtGb7Jr?=
 =?us-ascii?Q?zbWxzPpoHYpEOibSMVFY9hNgPy4f8khCnKm3dUe4npTpYVTNNWWKD3HJU0T4?=
 =?us-ascii?Q?gmWHuYIsNr01NK3v9T8LTk9FPHdNcPUiYmpymHrvygKTfKoPz4OLYZ9tQ9am?=
 =?us-ascii?Q?wvmh+X8nIbdea8fzSosu4nL0PdR0r8kw8n6pKLPUkUw6YdrGdZR5ZwGbxBEH?=
 =?us-ascii?Q?WWx6vffeeTlrdB2MmszAPYN9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c60f01c-b9a1-4faf-be04-08d91c9e0b13
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 21:18:56.7058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICDaQgKP/1mMRHfgVGhAH+GTL8eqFJQuSd3qB0Js/VQUwZIZ2zx0SMpoDDmZAPys
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, John Clements <john.clements@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The correctable and uncorrectable errors
are calculated at each invocation of this
function. Therefore, it is highly inefficient to
return just one of them based on a Boolean
input. If the caller wants both, twice the work
would be done. (And this work is O(n^3) on
Vega20.)

Fix this "interface" to simply return what it had
calculated--both values. Let the caller choose
what it wants to record, inspect, use.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 23 +++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  5 +++--
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e3a4c3a7635a..ed3c43e8b0b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1043,29 +1043,36 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 }
 
 /* get the total error counts on all IPs */
-unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
-		bool is_ce)
+void amdgpu_ras_query_error_count(struct amdgpu_device *adev,
+				  unsigned long *ce_count,
+				  unsigned long *ue_count)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_manager *obj;
-	struct ras_err_data data = {0, 0};
+	unsigned long ce, ue;
 
 	if (!adev->ras_enabled || !con)
-		return 0;
+		return;
 
+	ce = 0;
+	ue = 0;
 	list_for_each_entry(obj, &con->head, node) {
 		struct ras_query_if info = {
 			.head = obj->head,
 		};
 
 		if (amdgpu_ras_query_error_status(adev, &info))
-			return 0;
+			return;
 
-		data.ce_count += info.ce_count;
-		data.ue_count += info.ue_count;
+		ce += info.ce_count;
+		ue += info.ue_count;
 	}
 
-	return is_ce ? data.ce_count : data.ue_count;
+	if (ce_count)
+		*ce_count = ce;
+
+	if (ue_count)
+		*ue_count = ue;
 }
 /* query/inject/cure end */
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index bfa40c8ecc94..10fca0393106 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -485,8 +485,9 @@ int amdgpu_ras_request_reset_on_boot(struct amdgpu_device *adev,
 void amdgpu_ras_resume(struct amdgpu_device *adev);
 void amdgpu_ras_suspend(struct amdgpu_device *adev);
 
-unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
-		bool is_ce);
+void amdgpu_ras_query_error_count(struct amdgpu_device *adev,
+				  unsigned long *ce_count,
+				  unsigned long *ue_count);
 
 /* error handling functions */
 int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
-- 
2.31.1.527.g2d677e5b15

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
