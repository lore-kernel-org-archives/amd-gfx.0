Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4C5C49EA7
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 357F860FF2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357F860FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D93EC6E2E1;
	Mon, 21 Jun 2021 17:13:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF5D46E270
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:13:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpNBgZP3LCFHLkqReGNmoKwUJ+RwJzlCQJC3i+Sr1B17pYIXuGsxFJFEra4l+8m+xVaq/TQ57YmtnEyrjYTMuNGVUlxoqGVXoI/zV6Vql7TMkMHsnUwyOT0eK4VJB2bhgUFknifIeeLi/eVocar3x0ims/QPGpbzVTiUWutiXNY6/PfEg77nJVANs6vbV0aOcbZBlloyDwr1yyaT/pGcHsfi249O6yPIVLCMZzQ1Oqj7KPwA7Gc7r37LqmmmHynpkvW/H8iG/Du3ZMp7//BbInxs10DTvfqGrMW1uajZagsgwVOivjNyS4SC/iWWbduOvYoqU3dGFJS9r4yG0zbd7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRv0aonbPoUAjbt4WJjG4XlbAvaudim56kZ0ApCtiAE=;
 b=nrm3vk0pG7aWV02xmuzU0EJGPIRJehRg+f2cJxMeyeVxJDO6jCR+OsFROewvqYWR6sYcWwIeVr39DS7WH6mBNOtueA82aUdHopb+XxFkB96uO0ZC7F3J7Ruc+U7x6YVC1yUd/IdI9GKiivCyOvuZyZxlvvJhON03qKAyRfJPn84P1H6tQGTT6ewbKNoyeBKLBVnB+qBLchvJ1OmOgVyIQLzLpQjPXRJ5dnEuYsHcVaBqOAH9RyXo8acyCpmGEB4W1TCb3t8M0PzjKrASQc+N24a8vfWxFtrYCoOXBdXcpgCqYTrdKkwZTumN89zh1KLQiTSYAECYwU7h36dqgHTUGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRv0aonbPoUAjbt4WJjG4XlbAvaudim56kZ0ApCtiAE=;
 b=GhX4ZPVNbFZDUZmuLg9gFYE7QDnFUnF9FoaLlO2Xawzz3PAb8lceFbrmRXayiEVAZIrtg1Y2mnOcoBSPZl1uSt8QnuxkL7SmNL7xVzerrP/P25LUEdXRZQbSB+jjnkhBgR9qQoja9QbEmVXXx01hBam5fJ0W7hFTGB3X2ZhqRRk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2985.namprd12.prod.outlook.com (2603:10b6:5:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Mon, 21 Jun
 2021 17:13:34 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:13:34 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 38/43] drm/amdgpu: Get rid of test function
Date: Mon, 21 Jun 2021 13:12:16 -0400
Message-Id: <20210621171221.5720-39-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621171221.5720-1-luben.tuikov@amd.com>
References: <20210621171221.5720-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::23) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:13:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94aa21af-aade-4639-3440-08d934d7d57c
X-MS-TrafficTypeDiagnostic: DM6PR12MB2985:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2985B19D29D5E4E649A7012B990A9@DM6PR12MB2985.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lM+axIZEyj2cHCPKGZdvN4A+72v0VoLcfQoNwxGIpo7HPv1aZHFyHglKyFbpFwLfwZwAwTnozujJuh/W2/CsSh2BLxRHiqSKw5NMH8y1B1bfMXj4uOuyiTDSXD8mtAlVIlKE8j2B4giNdIM/e91x5Hsf94uy+1uIJ4gAfGS2nxrz4KDlrPtwDMo+FG3zrmBL0OfGvNDwYVbtOgwlYsUknk8xwoXvIItLf4gThRjLZoFkxAoN7tAQlETOOs5m0HPJkNZeoYoabwoYHyt+ltY6lYwvGXsC1YttsnAc9h7I3qVy2DYdj68oNZ1gzCfKJ3LVkIW9Fgm9IV2asoGiKTf0Bsbmn1OD5NrGatfBB90hNeUrD1U4H5ntTb/WRXOil3QwuXpMSQLSBoRi5NBqnKxJBHuXJOLNYbEJxbF/QDkQQd+Z6DKEnuStIY4N8QjubgbMqy7UbViN/0QFKv4Rpkf/F/abjSzKyP8sJZ1mUz0iU7XmaDAYr1aKik6EAZWw9UXHfZ0PcNmlTodb2ogdwFBEcVjL2v9SU7GfWruA+6EXRE4ssBU9GkV6QUQZrUBkCXeV3v9ItT3t9ijqrbRoM+1zxjj0XIHmlptGOfn2B5K835g7qQWPRDIthzt5o1NGGy6fMnijxQkj8MB514R1rXWU0FXEaUVUEIFHILIto9+Zkb7oqrkB+YDgnIjX33fMj53/AXrmbwDYxFaOBLi8OC8wxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(6666004)(55236004)(8676002)(316002)(6506007)(6486002)(54906003)(44832011)(8936002)(478600001)(66476007)(66946007)(956004)(2616005)(6512007)(66556008)(2906002)(52116002)(36756003)(38100700002)(38350700002)(86362001)(5660300002)(186003)(4326008)(1076003)(83380400001)(26005)(16526019)(6916009)(69590400013)(26583001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FAYzDI6iSluQ9I1rBmBpx3FerVL9m76RMWmVMh+pxcjojApCKglJThK8B98i?=
 =?us-ascii?Q?4p6gHSwRLGU0qXaIgZ6sXunei5EY4IPiSvI/9bFTjORi2N4V3GUOf7Gwm3oS?=
 =?us-ascii?Q?cAt2K3DDza3/1YCcA69GelsOfTYS4tv/SOwBnthuLqvzIIlz3VgqOLihebIv?=
 =?us-ascii?Q?VKZsVzrEKd3FFyh1l/0yZiHt228HvDtpJl0wHplL17q+IL8jlJhG379b+AGN?=
 =?us-ascii?Q?l/cC1FdM4tjTZjx58/Qf20ha9EUwTqZ92DNAJVjw6XsQPk05R99Y15x3KOjT?=
 =?us-ascii?Q?M/diGxOuKtpBnxAArUhPH5f1bivm75FzuEC8aj4cNHMrhhN/07yuJw+ULtz8?=
 =?us-ascii?Q?LpkDr0n3juBEyVWXyP5oLiuNj7AssZ5/Ebw/PdYUNAWAdtHGFxw7wPJhASQG?=
 =?us-ascii?Q?//alvQvDqjFzAK6Zf3AgA6Tl4OP8XY9mhW1ph/AepETs+T45pHmSM9QEy88u?=
 =?us-ascii?Q?BgnqFXhnKP/bcp5X4a4LJG86qboFzsFQ44XmmOVzZZ4/ktFJ5O5n9qn0X8yP?=
 =?us-ascii?Q?IORWD+qsIqX4WuELQBfU0cyFdIudfvvPZ9wNnw6rGCCGFuYkcjijxjb6jrJ3?=
 =?us-ascii?Q?iW3FVuHuT7H6pLARskLcReHIYDMtdF5igBhzVp+zy5ZJ6cVay50AXzbOGCqD?=
 =?us-ascii?Q?18AdY4DuLjOFg+eIKmWwee4fRYyd+wZpBzCJZptxOIYZiL5r9mPgT9s8oToE?=
 =?us-ascii?Q?cx3xOozi1J8UtwKmu+TUNvsshx9dhCekdc7B5+DlUvVFIsLW0CH0VFrnda06?=
 =?us-ascii?Q?s4U/39gJDvC6f+KyLQtMzv1bSy0wa85/l6tiHEdWXONdfyP7vxSv5wABI6CB?=
 =?us-ascii?Q?f3BIwVmzwnT+77FaWiFERFURgxMqG/3qsAA2fxib4rzFacJWl5W5M5NM2GP8?=
 =?us-ascii?Q?v8H1Kg0GA51JmS0K3+NstDSbw+icH4+CAzziUoqjTjcqnYqv3bUG8VnFO0el?=
 =?us-ascii?Q?Y086atYWGc1rhaD1+3EZXrG/Lpy2/C4NRZ3uFxdyk2LE1OSWKAbBn9KXPsaC?=
 =?us-ascii?Q?874WEwZOoxPYMdl5UuHtdoK9EzDj9AIJepbeBv5HEV3l+W4nvKbhy3YvSjpX?=
 =?us-ascii?Q?qq8FAIOkLD9+9T2PmCs2bScLZOXdevWQPjG1hE2YRiZz5rvlE/OZpgTSyqre?=
 =?us-ascii?Q?+cLjVlKZWzerAxvhoK0XYvyHURD38j4165sScZ8N6G71HphGsiLq5/XQSu1n?=
 =?us-ascii?Q?IdrwJk4epCO4G72e+yNT3iWgdxGH+1EUo/HbB7IC+dR9AUcq6I98/nU2UVQi?=
 =?us-ascii?Q?yJxNvp34qZ/XqEouTIqU5bvYlOC0uh6F2K2gplpDtEpA1gzLOD/1MlXRsMTP?=
 =?us-ascii?Q?dDepZL/mW+JNJEGLRjdaKKEz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94aa21af-aade-4639-3440-08d934d7d57c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:13:05.4985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AB2kFJ44z3ydPsDrV4lf1YJrumw0kkUZARIhVU+0xWBV61buiMIMhOvGUKAxjBxA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2985
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
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The code is now tested from userspace.
Remove already macroed out test function.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 33 -------------------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 --
 2 files changed, 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 34da00ef8369bb..7522d2ca5b03fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -572,36 +572,3 @@ inline uint32_t amdgpu_ras_eeprom_max_record_count(void)
 {
 	return RAS_MAX_RECORD_COUNT;
 }
-
-/* Used for testing if bugs encountered */
-#if 0
-void amdgpu_ras_eeprom_test(struct amdgpu_ras_eeprom_control *control)
-{
-	int i;
-	struct eeprom_table_record *recs = kcalloc(1, sizeof(*recs), GFP_KERNEL);
-
-	if (!recs)
-		return;
-
-	for (i = 0; i < 1 ; i++) {
-		recs[i].address = 0xdeadbeef;
-		recs[i].retired_page = i;
-	}
-
-	if (!amdgpu_ras_eeprom_write(control, recs, 1)) {
-
-		memset(recs, 0, sizeof(*recs) * 1);
-
-		control->next_addr = RAS_RECORD_START;
-
-		if (!amdgpu_ras_eeprom_read(control, recs)) {
-			for (i = 0; i < 1; i++)
-				DRM_INFO("rec.address :0x%llx, rec.retired_page :%llu",
-					 recs[i].address, recs[i].retired_page);
-		} else
-			DRM_ERROR("Failed in reading from table");
-
-	} else
-		DRM_ERROR("Failed in writing to table");
-}
-#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 9e1e7656b7bc2a..67a7ec3e6c2296 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -103,6 +103,4 @@ int amdgpu_ras_eeprom_write(struct amdgpu_ras_eeprom_control *control,
 
 inline uint32_t amdgpu_ras_eeprom_max_record_count(void);
 
-void amdgpu_ras_eeprom_test(struct amdgpu_ras_eeprom_control *control);
-
 #endif // _AMDGPU_RAS_EEPROM_H
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
