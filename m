Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48431C47092
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FFFF61C39
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFFF61C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 477F26EDC6;
	Wed,  2 Jun 2021 16:50:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02ED16EDAC
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYBR+BooANv+/jPKCLXfvruUQpGjt1NENCuwOQtnmBGsH7rSlg8cm2JPShNmCXSTfNk4UJ3dG3gDVRkhIXoiRsvwwojAZMvzWzefdhKPKZ7UgKlQfd3shFYgmB9R8McWm4skrUpqKmRZgQWSZ/6xFb3RMC9UEH5zSUDUa23qap+MUXqNyLs+/VyqCeQ6e69Nbw8YxhWFaEyLSONfRTjDo8ySoJfffs4DCLFAkhuhGPHQ00z+FFIArl0Ha4pacMDg27ch4Pj0wLlvLs7+YJzixEe5BNf0exyYkZz8ANECsmDADJmwnrGzrgz9BAH3DbU48AqqBNx31gcCmSOh37MCVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Exm11zMUxpVXrwNAQSGui7OzLRA63FPb4bBoDTZ/6Q=;
 b=M5FWnoiLwvz9EhtVe65oZfSCsughKAXWqT6M0vNRvfgMWVjhFDFKV13Bd1e0GNGmJlOM9o0+AG4utocWBXJQf7DAfhfT9GRpT0EYvQZJd3SeTxHb2b8IZ21gHg1U39Bswhhoh1sVRyB/TptWlQjbZ7ns2MaPhGLvkWc8GudLG338OLf2PscLqBbsJd1fatjFnHZKOXI1dOIYgiAW8KSysqzjIWrYiJgOL574Kna2VWE58z33udZe5wJh/hzz30MTr9CIU/XAqaeygi/lkBXkAOXuyDLafePhJ+3paz3MgNONi6yIaRvMnWNaCQCHiTwPw5d7DujS93t0ylTVobQGFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Exm11zMUxpVXrwNAQSGui7OzLRA63FPb4bBoDTZ/6Q=;
 b=5nWEf3Ak9U/k2yCwsC5TFqvljIYzyZveLJ49GNN1CYTFtssQQ1IB8Ul3IjxtE67A/vZHDZwumkHZOuBJwPBT898EyQbzuEJlU4YgXRBX2gF4htRTANqMPDhTwKYOkWeDOB/4hmZBMz5mbdCB3StqDhjyYFg06USgZU8E0qIe4nw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:50:39 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:39 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 57/89] drm/amd/pm: add PrepareMp1ForUnload support for yellow
 carp
Date: Wed,  2 Jun 2021 12:48:36 -0400
Message-Id: <20210602164908.2848791-57-alexander.deucher@amd.com>
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
 Transport; Wed, 2 Jun 2021 16:50:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1b7c0f2-f59f-4da8-bfe2-08d925e67a2b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB453499DCDD9AA72D01697376F73D9@MN2PR12MB4534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GG1E8JiKEjK5myiEJatlSbo928e5NAB1ooCbgs5kkpikx3BLiS5PF0oAqIcqjVXXP66U8LqDGjJYix5kWFxIMhAL6+i0fMuMPWcZp3Je60+NFennjigD5+HA8g6Zgz6mn9lc/N4PVsT35I3Ghjw1ZK6k4gVH2/bZzC2qsF2523NvUoqHLouLJ3ZOUgFhTW0oWux7mKEEOGj8CbX7dVc0hokwnzYdVOI2w56E4UTVumTCV5MxRm8Yj5CrDLnFDHaox8Y9Sz1HDpOHi6sym98y55eNqDwk/k/scQ28yp/vy6kdfp6jP0vCe0H998gQqyI4XKiR6x7JBCQlA3uBoop3vN7QXJtf2sRjuq+G5H1Ks8tAx85VEWvn34DcL2JP0wUoQhCt5IqL0oiVM3Ug3+T/oJHQm8oAjU0foHAgUeUUyL+mudux0wd201CkFrXNK4cRAjk+TePinjKok4lSCQ8y8htebt9OAs46CI+3mAusU0rkGS2jLRkrLThjrWpoKE/LOt1Xmfl+qrAs1MB5ajhHDNvmkuOVB2eYudmadey1PzUmFx+SaTWV2PfAyLaW6gJNdswjjOEK+jSAsCRYmZfVdsUF3qY3zKhlRnA66hjxyFr4FA6aziP4N0b/2sS6yZrz1kzTvqPdRpqsHw6LY/80kkCxDgCxc9UDP36PLNHfeuf6xaT3WyrFL6WDvKGRzUdd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(1076003)(8676002)(2906002)(8936002)(4326008)(2616005)(956004)(38350700002)(478600001)(38100700002)(83380400001)(66946007)(66476007)(66556008)(36756003)(54906003)(6486002)(52116002)(6916009)(316002)(6512007)(6506007)(16526019)(26005)(6666004)(5660300002)(186003)(86362001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4Sdn6Pw+Q4v7x+fOWOqwWASR92U5KnEx9R2NVaO39Ywp/Rea9NxSvSSFAMLh?=
 =?us-ascii?Q?cbozDt6PJI8P+/BPHMr08TK1ez/j9UTUToSphPgzxBtb2q7cf+FtAqlhRNAv?=
 =?us-ascii?Q?8NvDEn7O/SC0ZQDz9Qlm+qBaPAff0xpdNrqXlUC3OTWttQzyO8GkYjGS5n/n?=
 =?us-ascii?Q?CTISrei4KKxzKt7zMjefjyGoJo/2454dyI6HcdE9rjyvgSFSuW5LDJDSVarX?=
 =?us-ascii?Q?slFtdiSC8pa0OptBRZJ8vmuUnJk+I7oqbmTt9RVogWlFQsTeCEaSBJbStC4R?=
 =?us-ascii?Q?6CKzp4VIxg/trJC9XQ+WEfnEK1yeCw2qQRuvayCdkTHqHKPta4+eW6rYQ6lN?=
 =?us-ascii?Q?250V3XXMspzF6HR6dOTxk1FqfjQBvvUZMFIYw7pcMS7ADtyoIHDdbCd05sS7?=
 =?us-ascii?Q?MX+kVZd4dAxlaztKDRPiX5J1NgW6Ht3yaSZqunud55Tsg5zznNNDoLpvmC1Y?=
 =?us-ascii?Q?/L3eGoBd2q0C/QPVwx+jwuFzu8GpypDDXc104OXNuSHS5hEu9KL41PQPr2Ja?=
 =?us-ascii?Q?Y0xtdWeGI2efcvC8C+cHUmWxXGuu9GHwRcIcEhMTJoc7oEkfJX2U27KRszb4?=
 =?us-ascii?Q?1x+l4SdArPae+3TkyRCB9NA/fyn0/ED2GGJe2LmPBenn+s6aIDKb2SSDQ+LO?=
 =?us-ascii?Q?minb0hUUziiCS0n++6urFIB3HXbToxQYvuh/npFfHNTn2fWF3rnyonZ9yZXv?=
 =?us-ascii?Q?FhfasDXhwOBB9bX2WBkTnBh5IolK81YJiN4lgNQs50JyETUrIyeHgwL9CcEz?=
 =?us-ascii?Q?9OpYg0V2REQPegkZ3MjK49NqyYadJdtt8htm9faHgoFUbNVV4RrFsKaP1UHj?=
 =?us-ascii?Q?UzbUoJCJuW4Izr3vrlwY3HmyMMdrY5Ps5DPJcrU7BStS/alf9Qz4zPXN/8In?=
 =?us-ascii?Q?hVfxrwnW5tlljpd685YB0DA4xr9pLF5WihaTq8v9hbemqEQqDrRvtRWKVqYF?=
 =?us-ascii?Q?D9azus+ZBw5aBgTD5h/3qWT3AAKwrfHujih4O/AtEDNbv+OZTjtk5b+KMq3S?=
 =?us-ascii?Q?v8XD6oxYXKA6tXl6XZBzESE6I9jEitKn6et+lOkdN4aGmbnXUvQY6peMWqGK?=
 =?us-ascii?Q?c+I6meDJ2/Mjefv6/jC3lBmfiH0+5pcc8XlePRUHso2LmixS/lJGq2DoloJj?=
 =?us-ascii?Q?S5OwGle8sByf0SGrTmE73TZ9UBHUC791NDVB53P7Vho4vs5TqOEPDd30r8i7?=
 =?us-ascii?Q?5QVkJIbjle4/+FxgMZC+2aC6cYTwJE9ziN1M5DXmy/y9ANgYFiI0UfncY4Jo?=
 =?us-ascii?Q?XiRxhg1k8Z12NO64YFKRJjs1LCWtFQDC76FKmiAll8gqtxRPmugU20pV7oo0?=
 =?us-ascii?Q?a40uyeiw8YqOoPweZQ0Et2fI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b7c0f2-f59f-4da8-bfe2-08d925e67a2b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:07.6051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDUpHPJ6NqyrZzlAGmViK+C9gAVZ06EieiHDEdjosAhCio/ZehFlnvxUvC5cIIrtYzm/PlVNCviWUGcVyJKilw==
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
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

Driver needs to notify the PMFW when the RLC is disabled.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 8e09811f56ee..d9b3cb7d7ca5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -65,6 +65,7 @@ static struct cmn2asic_msg_mapping yellow_carp_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(PowerUpVcn,                     PPSMC_MSG_PowerUpVcn,			1),
 	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,		1),
 	MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify,		1),
+	MSG_MAP(PrepareMp1ForUnload,            PPSMC_MSG_PrepareMp1ForUnload,      1),
 	MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddrHigh,	1),
 	MSG_MAP(SetDriverDramAddrLow,           PPSMC_MSG_SetDriverDramAddrLow,		1),
 	MSG_MAP(TransferTableSmu2Dram,          PPSMC_MSG_TransferTableSmu2Dram,	1),
@@ -183,6 +184,9 @@ static int yellow_carp_system_features_control(struct smu_context *smu, bool en)
 	uint32_t feature_mask[2];
 	int ret = 0;
 
+	if (!en)
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
+
 	bitmap_zero(feature->enabled, feature->feature_num);
 	bitmap_zero(feature->supported, feature->feature_num);
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
