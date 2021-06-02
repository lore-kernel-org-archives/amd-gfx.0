Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079CEC47093
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3EEF61C39
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3EEF61C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43EEC6EDB2;
	Wed,  2 Jun 2021 16:50:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B26A6EDA9
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VK0NFDleqOJ56+mL++zb/5lSTdIf1xEBJ5SgXbVFFtrjKVOwc8bhAvfcF/PcEb91zBakmhBj9H4/Uy4RFBlrcpNynOUnuBmq/Q4R/Krb+Z4zIVavZjYHttF0+JE2SPr1TKumGybguDPfWXlqoQCYAtoSl0HQKrZHmwb9L8UczQ+uFcSGqg5YG6pZeJn8xxeu3NXdG8xEgWRjRPY03L8X6rAqqVv2AOOa+K29PwumsmHwdyC5o2qYSTDwklcx88zvUHp5DshKois+lCseq5TCRAkk4kkUsoz3He7HjiGN54v/RwA+/U46bwpZIXn5KGBWWes8JuAoRa36RRKtpDt3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yL2mP5udkSEKvVc9k5mBYYvW2gYYAK6wGnEgL8gwKUg=;
 b=nQ3m+e/u62OV9eE7BDBZIW1K/cS3c630wECht2hguoGt3+6kE9kzkXhyUuYGwwVFuxQAuWlFQMw4pKrQQ5UaU/iLnCxH/FbuC43Ecf53kJ3od3SEv0Jqegs7qZKafeU7Jmwm0gd6NwnAbTlij3PE+HlcLRMz8B0JKge/uX1u+Lj2L1/i9mF1mpnNJJCtaZO+bEXBcBBiKVwAe/3OY7HvFI/dMGUMaKt0V1USZ9I7FMR2KMrMpCrQF1IxZxuds4kyjLz6FhPpx8Q1d0K523N9NqcudcjGrpzH1QeV6SdKVJ9//y7UMhNmn5WdVu6pIBoeJ6GqLviCJHiJFs9lLNXDkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yL2mP5udkSEKvVc9k5mBYYvW2gYYAK6wGnEgL8gwKUg=;
 b=wt1zjBudOmIAx48C3Rc6gwxvEKUZa7Lnw7g5IXGkuW+guwE0y41eFc0ANJOGyeXDxI3HpsDwkZ9X1dwIL0IJH9NAlv5a12n3YzE/p6MitZkJxY3yJf6PlhlyUbDwN1lhId3QTp8m3gOOMmIq415ZJwfHgvlAxxDAXzUUe5OrYos=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:50:33 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:33 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 48/89] drm/amdgpu: add timestamp counter query support for
 yellow carp
Date: Wed,  2 Jun 2021 12:48:27 -0400
Message-Id: <20210602164908.2848791-48-alexander.deucher@amd.com>
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
 Transport; Wed, 2 Jun 2021 16:50:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6facca4-bb86-4495-4fed-08d925e676de
X-MS-TrafficTypeDiagnostic: MN2PR12MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4534986105344EBFCBC18247F73D9@MN2PR12MB4534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:478;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QlWSCkx1d4AeXvO5KqXYBQN/gjK0DWdhqDqvg5xCS9wNSG6FCllupnGtNKajDzqDTJfab9az9oUeF9hKF6VTg4Wk0JK1BJRV29Uzp418fQzH+DgR04Hvi+yWs219QavRXZRd8HuNegwTQIa+QPRUX62QV9wu+PhKa0xaZsUUbOdSKWW9VzDp8CQeh6SQPvwh5POIwFx57QndjcR8JinLLgQMsqm++S+JYz1XCwF9fu2chAEcTZEEOuiWxqmRhy77cDy/djFtUzZJ3MUAo6iwOFPWPx1jUAjPMEdcgvAieoW6gLBX9M8/1tviRKLwflAsvUI0No9Oa+jdxROi4nqWRwbJ0z6k7+uCvC/rbo3J3TQu3AUssa7N3PkSBBm2fFrYR0K80D5t8Iemu77jPqx0f6MWLC7UFTp88xJZc0SWMFHg/rl1d1LKcEy73QzUxuxB/LEq6OFKmj9659F9QGE9xwZfeqgP55H9Y77yr+Br4du4cdOn9knGfvuw2cTpkWFpiUSAQ9lEEZYAbVK3chEqN42IYJ4LWuR+5tZ8lWFXny55kXNtCfthxz1k9oj9qhfLmtRJhtyaVUGJM58fAjDHpvcJ2tcJ30wX0RBD8bl+sntmja/geYSbMvJk7HW8ijkAdtDyoZExbHJ9MdCB1B7RPzLRO01zh2ZIZbjZLztK071TG78MKxMKy+pWoxVtTrpD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(1076003)(8676002)(2906002)(8936002)(4326008)(2616005)(956004)(38350700002)(478600001)(38100700002)(83380400001)(66946007)(66476007)(66556008)(36756003)(54906003)(6486002)(52116002)(6916009)(316002)(6512007)(6506007)(16526019)(26005)(6666004)(5660300002)(186003)(86362001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Lh6cUazZZ6bSpyyXkCHKa3gqsKLSc8o9C6K0V8FbhBSGYhGUF0kpUc83YANR?=
 =?us-ascii?Q?vxPN/H148ZgJs6yUzKyVYDSQ1KNLFlYUFq2Mmup6wocu3jeyLhN7tRS6a+8Y?=
 =?us-ascii?Q?7fZyNQ6tfpcvG+mYIBa8blqyVavfH0gb6xIjL+8w2lm+avgL39gG/es/qhu8?=
 =?us-ascii?Q?W0ik99jdhZz4qM1+bZRcbFfUI1uj8Zgc45qDk/9X6temR/RtMa7AbqFPRpry?=
 =?us-ascii?Q?PZS8UEI1Kl3GSRWNWpNnl6EZ5givaB1LGqaBCYUbv7WZz5+NSlYyJl5ie2og?=
 =?us-ascii?Q?uNGkg2mkbi1AufPnPOHFnGZ6D/6XNuBZMZxo2SiLwrUnM/YCW5BtCMm7kNY8?=
 =?us-ascii?Q?7uoelEkfOYqUZe/bLLnV7q0e7zjFrZtRaHkSSEdCKQwwBxoJTDEYOemrFEUp?=
 =?us-ascii?Q?OZ6O7sZ1b0BdxPavpW3Sy9kpUnzBrlWz4jCEttpyAFUjxJ+QEMAVO3iycVFT?=
 =?us-ascii?Q?w5NQZ8D6B33CaRzp02hF+6OknthMU1oKaLOXoaRWW3zL3QXLtKnuruTDHNAp?=
 =?us-ascii?Q?eKEwsk7yAWgGysC2MgfWa+Ld/5yFcH06PeXZvTzxsQ9DxT2Hg4wwmpVzPDg5?=
 =?us-ascii?Q?bY1okz2ETLQgFtWmjOW/UBGjxDkfbC4hpoDy5l0bpBbJ3B6DEENv/LM239ie?=
 =?us-ascii?Q?ugm0VsrM2IHfBXtoi5IIOgkiIjXFAOLmOloV2Wzr5+N6x59t1COU3NxHsXBu?=
 =?us-ascii?Q?Bu3weCqoUmmnIqGKHPV2qs0g/296APK7hoZm7YUjO/7rkxd70utHm44al//8?=
 =?us-ascii?Q?pGn66SqDu9d1eh2pWrNFLyM+EVsNmDeo6Oh8ShyNxTRb/a8ZkfFO43jIOt+u?=
 =?us-ascii?Q?po8XwAXzTk2477b3Mwuf1y0Q0HlTDtxU8SUZzvJ/oQSIGNQ2xLNrAc1X2NiA?=
 =?us-ascii?Q?ojVcfo8TgVWZU2OeokAcsx+UWCNqCT75uq7Zik/KqmCZElVUEIbbAVKRH9TK?=
 =?us-ascii?Q?iGzZTCCvlMtjd8MredP/t1DHWHMKwtDspLvg/RkORkpaNP5P7dILg2nxvtI3?=
 =?us-ascii?Q?dNEGgBtjKWvx5cTgKpafgKMdAPQSNyHn5KNn0uMyfjSdfFgIGS1IHTbbbjry?=
 =?us-ascii?Q?7lpIalXacb7N+VpZ1wcw/buhIUZ2WdGj+HcPEUC/Ihshkw04+3q0899iYUUq?=
 =?us-ascii?Q?tDQFGtSAx8/jAO+SBTOLqRj3Go8eIr8kqXMdz/6TpAyvtEd7JS6MHqvEnqzA?=
 =?us-ascii?Q?rtfxG1TL5s3kexRxq/UYysbrwGz4yq7RsO6aTIYGJY7CCB2TKAh1I3gOBIMy?=
 =?us-ascii?Q?8rwJyA2MMxavyYuMznVQeHXA+20Kc2W1VJcuXT3o9G6MV6O/sHOX+SEcnCWS?=
 =?us-ascii?Q?jcJyzdCNV3rD7FlJ+2va8bBT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6facca4-bb86-4495-4fed-08d925e676de
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:01.8524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hlo82yU+ZeQeUejYqHZDaBOBNDt3IYjlzL28XfWNV213UYFq+/ZyLAzs7Ya+9cafQwzAOttRNDVSpIZam9u9ew==
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>, chen gong <curry.gong@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

Allows software to query HW counters to timestamp submissions.
This patch can address KFDPerfCountersTest.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: chen gong <curry.gong@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 4e37e219989a..2b166dcedcce 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7598,6 +7598,7 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 	mutex_lock(&adev->gfx.gpu_clock_mutex);
 	switch (adev->asic_type) {
 	case CHIP_VANGOGH:
+	case CHIP_YELLOW_CARP:
 		clock = (uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER_Vangogh) |
 			((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Vangogh) << 32ULL);
 		break;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
