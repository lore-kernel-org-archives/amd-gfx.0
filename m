Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93883C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58B2C64ED1
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B2C64ED1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F93F6EB58;
	Wed, 24 Feb 2021 22:21:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10A186EB5C
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfsRuUqJVsPWQKEGBoqbBMT/ql9ukJyY4zwC85vpoYO4581HJ5cLOz9AtkmRoHtks6+thqwIVxup8OtdGP2JxmFyN8TwFT1N4H9nyvg5byFLEpTqXQGDiUKhd8EFKFo83StsmBahw0zheUgyUiddGnjOssbBH5fl03C7k2b04Iz4IArYgaQKTrwv+8I6joIRVS3TxsX0VSQgrMSFztRe9LlKiD2HeoOWhVRi6H5o0ZkWwyEYk+kA09Yrucs7qL1mefo7lQqYfkQfCsfJeK/u3VcboH6Xfy/5JBrjrsftBab19vKBYfH7oDHALW10q150y508LRg5BMIztEGixjzMfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTLtw5GDdFMe8OChtAumi/AZEPpQPdRmhPvBDLwIqSw=;
 b=H06DM0o5HOcDVZ8fY33SPU1x7bdkxD8ncpUR4iYUxLI4UqgG04Ynii7Geixi8HlQZzsQZ6LdM4QyRo3rFwK5UkyS7v4PE3XCBqUHm8g6iKam0qdFCh9OfFAzqYXOdHLUqD9ANfNkfCOw39lh7ykd2nAe11FzuezQDZsEOr2jCDw4VV0vympVSstCPUZj1Dv2Vt9oUTrM/MDfegb3vg6Efpq3QJxgrJsFmfn8HGgJJOduy43EvxYGBVx+xc5GpLPa0S0b0bBy7omwEU4DmaX8cN6JY0pViY5tn/Aoit/IqWkAaZLDPV6b9aoaHZIZKHA98lpwgoIzYWPbBXtKqpqqQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTLtw5GDdFMe8OChtAumi/AZEPpQPdRmhPvBDLwIqSw=;
 b=AIiHJBL+87VVsLNiRn+icVL59NlSiFuGg0Oe+HSzUJd58gKJbh/d3py6JdLbJ6hU55bArDovszgEaayaZzljjcI3WMwsN5lARef8HGaJ7Q8+Z5xP/Vefm2uexmFgbas27LD3LZ2U2EHTpSlw0YxsIwe2wYksFtbTwdoAW0lQ3GY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:10 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:10 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 092/159] drm/amd/pm: Add support to override pptable id for
 aldebaran
Date: Wed, 24 Feb 2021 17:17:52 -0500
Message-Id: <20210224221859.3068810-85-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 702e6d8c-7eba-4925-c366-08d8d91261ed
X-MS-TrafficTypeDiagnostic: MN2PR12MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB404663B16014BB57676DF3C5F79F9@MN2PR12MB4046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y+TOrFv49gKNz6AwQ10931WHDm796AFHb3DMVl5LAy0ew4qjQQyBgPI4F34FfVzHbpXwIqIASxM5L42bG3G3ON/tF3IvqBuh1jgbNlTQPLNKqDljkIdX4YmgOCkiw5edsCTx+MWFFm8Hs1mBWUrih3QFrcbkSg4n6tvz9H+vAOJ7PrjRLv9jxopHwQMSWDBwkOwAEAUvzoL3uWBzwH1bDjK3Yl1XQNjCmpjnbsWs7ATAnGE4+uLBebcx/68LFWEWkFlSfvR7QJgH8hxpwrMftA+CjXYoKrDX0GqBJEtVoz50ozHyDJYZW4UowM5m3YN2a33i20zhQ+OJ5ytpBKZO8StH1iKHTyufMAz1BLJBELgqn7PUbTaTXkUE4k8PeBQrYVMj4yOwwEiTHD3M9G8FhU0ivap+xEcfSRhOudZ3Tj+JpfKzjgmgG5BDjyv0d8Bx/k2k5sEX2V5R0V/4lTiTjSYuWttCqmiGtlwnAFLBh7rYukxqgsVGBLP8Z6PzWUt7Pgxb/u5IpR6zDC281ywKJw1XUu0j5KzRJ/G0P03/ehTw2OU9eWIpnhzPQzrvVrFnhzIrK4zHSsxh8ndOMmPmug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(83380400001)(86362001)(4326008)(956004)(2906002)(6486002)(2616005)(478600001)(69590400012)(6916009)(8676002)(8936002)(1076003)(6512007)(66556008)(66946007)(5660300002)(66476007)(26005)(6666004)(186003)(52116002)(6506007)(54906003)(36756003)(316002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8ZrXC+N6AOQSBkiihNMWhoKjRPseI6G5QTwKaLX/OC15hlj9uq9bESvI2mEy?=
 =?us-ascii?Q?vPPAfWvmvavqp2ML8NUB+BkLL4ixE87Un9lZ5AOs7ZJhCxtF2T2qFxWhr0mI?=
 =?us-ascii?Q?sv2WjbkdzPwdJ1oHsoqB2FPd5VLonx427kHZFwIp4RUWHxuswIvtW5OxIwQP?=
 =?us-ascii?Q?J9ooxGNM1DoCzO67ZRJoZ/tO3xhObDxowcmTcvcFfC2fLTHsk3SWz3yx73d9?=
 =?us-ascii?Q?NabisPBebHe92bps9e72+OIWZktCerOOKeeHW12ntriEhF01fgxYurifF9zD?=
 =?us-ascii?Q?NAtYxS8q5MpOJJxCQrdWzun8X1/z06fbBCu66oGFviqPg5O62osMQPwPqjOp?=
 =?us-ascii?Q?u9QDF+Aru4dYlOcl32TgIMTi2LqKkKC8WApziY0P1JPy3TyPc5GPmivbRQya?=
 =?us-ascii?Q?bgHCAwLEya2yy43si+NKdO5THUDphbEmyK7I93/KlqiTmXdKFU914sqzen45?=
 =?us-ascii?Q?qQOA+WG4LFDyaPSnOQevqjL43Zk34GhJU/FF2GR+4jAG23XaMvkIQJAFi5Op?=
 =?us-ascii?Q?hiJ8+zqPAcaOtThmoZ1ALEU1hohP4ux0V90DfV8P/51kND8pkDpEwU1FqQa0?=
 =?us-ascii?Q?JJhvPi9dvabr8ldbzOoFt5xkJw5xAWqkTMxPbSFRJXQffv1p8UvcEJ2SiKt0?=
 =?us-ascii?Q?vqFxCzypIClijP6+jeK5g44zc0pAPQXglektZeKMgUiOwvdOomOKM8D8/pAK?=
 =?us-ascii?Q?y5GnzWVLAVsddzCAMLTLskk/fjIY6+jo1WgNhQ4KROESfvpvJvbW6BjA2ZJN?=
 =?us-ascii?Q?OeKCYnlnubrwnbz1LrB7FWvjPVU+x/m+6hVkOwSstvTNV8eKHeViJoJlC2KF?=
 =?us-ascii?Q?IRXI0xxCr2VH+qNiJYjFHaNUGPktUW4x1Gwg+ugJ0lLADbRUNuDWYj4oGOJG?=
 =?us-ascii?Q?8aeWO+vw058Bn1F3NuP3h17TcVz4FVjVP322EzDnwGFJJgSEM4s2johmPgfe?=
 =?us-ascii?Q?vE3RDt0jQ5srpKbco2f8kWgZaHBBIfpNouvwtLRE78oLmK07n8qXAGZdLdGN?=
 =?us-ascii?Q?RglNrBMFuM4mPPXJzAo5XRT4d1I4LPwso1gWhwhsW/zFu0tNVmfcvwUGa9Ys?=
 =?us-ascii?Q?57yJhPKWGj+TlVnlJIsoUnK5BOjDxCfKAk9PwIM/FfepqxtqkfLGzCRoHwUp?=
 =?us-ascii?Q?LbubvDyb9HCb33Bz7KoiiSCPxNr0ovxx+Izt2SADGiqo0x/3zufuKyhu5zKE?=
 =?us-ascii?Q?vTPH33b6y9pswzph+UKwTh2/0D6APV01fRZ8TZhQ/tquod5jNPF3AEkwbytF?=
 =?us-ascii?Q?Dfm3Vtx0AAZzclcyWU/GcUvDn2bhIKozOzKioUt6iXJfg32NhaHuo/afEldF?=
 =?us-ascii?Q?y3tjcZmttDU8QVmEcSvlSdkn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 702e6d8c-7eba-4925-c366-08d8d91261ed
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:25.1174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TzBrvBVbKUeA1+Y/QsRqOp4+niHn2CTgEZiJDk0iORIRZsNtcKnAf8OT81XH6GzwGQBLRK4cC8KFUMMp07AYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <Lijo.Lazar@amd.com>,
 Kenneth Feng <Kenneth.Feng@amd.com>, Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Temporarily force to use BU PPTable defined in VBIOS. Add support to
override PPTable defined by module parameter.Add FW reported version to
kernel log.

Signed-off-by: Lijo Lazar <Lijo.Lazar@amd.com>
Reviewed-by: Kenneth Feng <Kenneth.Feng@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 7589cfe86f54..e6c25a5814e8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -216,6 +216,9 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 		break;
 	}
 
+	dev_info(smu->adev->dev, "smu fw reported version = 0x%08x (%d.%d.%d)\n",
+			 smu_version, smu_major, smu_minor, smu_debug);
+
 	/*
 	 * 1. if_version mismatch is not critical as our fw is designed
 	 * to be backward compatible.
@@ -273,8 +276,13 @@ int smu_v13_0_setup_pptable(struct smu_context *smu)
 	void *table;
 	uint16_t version_major, version_minor;
 
-	/* temporarily hardcode */
-	smu->smu_table.boot_values.pp_table_id = 3000;
+	/* temporarily hardcode to use vbios pptable */
+	smu->smu_table.boot_values.pp_table_id = 0;
+
+	if (amdgpu_smu_pptable_id >= 0) {
+		smu->smu_table.boot_values.pp_table_id = amdgpu_smu_pptable_id;
+		dev_info(adev->dev, "override pptable id %d\n", amdgpu_smu_pptable_id);
+	}
 
 	hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
 	version_major = le16_to_cpu(hdr->header.header_version_major);
@@ -564,6 +572,7 @@ int smu_v13_0_get_vbios_bootup_values(struct smu_context *smu)
 	return 0;
 }
 
+
 int smu_v13_0_notify_memory_pool_location(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
