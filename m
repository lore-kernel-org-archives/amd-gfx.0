Return-Path: <SRS0=ZMUS=IX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C65C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 04:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4628561A14
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 04:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4628561A14
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E11806EC88;
	Thu, 25 Mar 2021 04:21:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02D7F6EC88
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Mar 2021 04:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sw74qzoSUqpicJ5M9smL8M3hCd51DHu73mkwqs4riiLacJ20BwSwvq4GkclQVDUZ0R/9uormDu1ju+8yci8tcs+6o/HQNbC/Xizd7zrQVbOQk7V4Sp8/wS95mBRet8AhFXI+FTETfGKcT9A5ID1DlDXOgyzZGGK2Z7YvV+tdlOkEk+cLu3Jjn/f3f6zgUXf1hsH++I96azis4lkbRbDnLj/+dZ6bgpwoUL1FhJ2ofvWY4yvtWRdwXFRLdSmxEk3Y5BrhOixbVVyIHklwDS3ZWE3MKAnR98RlgyL3QbgUcIU+eSPaUkKmH9sUTDxaHpFueSEx4qJS+YHDYcEPq/AReg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cseyKzcPjqZ4iUW1o0zQg0g3E2/awnnYZS8HComjvtM=;
 b=QDZsDsv/AuPUD2XynEWQDLYzIXcIEjPlWuhCi7DvmtJ9MjK2hmOvlyJGW9beh6iKpp289zksjN0AkNQRX51LW+Sp8flrc/iRRBX3gq8ryhxPNs/SqlSsVuX5isUS2tPv2pD7+GQu1HRzyrx2ZC7birWs9oKWODXMzkbOWELaG4rk9Hbly9QHGjUsZFjJbAgb/jouNM5TsVABVeYlFJBOGS3tHSnZVwXfQGYfb6B8MBTSKsusNXTfXTi5qj2NuEgzBRWSA7dJpEaS54gTQZJYi2s/PVEuK+wyYhBaZ2XovplM2TLwGxfmuAyT4b2wNcINu/6TufedsWO1M4cdhqTigQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cseyKzcPjqZ4iUW1o0zQg0g3E2/awnnYZS8HComjvtM=;
 b=HyQvOZVNRRC4mnWikS9kp04MqA+HjXee1//vYgqln93UjewJeD237pQowHr0xcDnENx7WrjprAdtOf8maHCJFMjUEvSPONdHpFG0QGxHi/nZrkBgl0qw/Uw2VX+xlqLR0h4nhMxhEAd+o6nbpjY66YnhTsCTkxFCRSwro2yKW98=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3771.namprd12.prod.outlook.com (2603:10b6:5:1ca::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Thu, 25 Mar 2021 04:21:42 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 04:21:42 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/pm: fix missing static declarations
Date: Thu, 25 Mar 2021 12:21:15 +0800
Message-Id: <20210325042115.1104668-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210325042115.1104668-1-evan.quan@amd.com>
References: <20210325042115.1104668-1-evan.quan@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0075.apcprd04.prod.outlook.com
 (2603:1096:202:15::19) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR04CA0075.apcprd04.prod.outlook.com (2603:1096:202:15::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.26 via Frontend Transport; Thu, 25 Mar 2021 04:21:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 508fba3e-9540-467d-4b3f-08d8ef457e2a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3771:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3771F9850C54AE4121213C0CE4629@DM6PR12MB3771.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ahg7W9seZUHY/msNgz7FrHu4+SZCFusdjQRS4i94gkfbxfg8/AWSK6KEELfb24eEBZcAjnQ+QrD7hQIdi1Yjr42H/Jw8DBq0b0GJFij3M3HmBz2QMotbhGYwKCfEGjvYxMdTXYQ4hTWMfKEvV6N1osqNXhFZ1RMU6oyp2VXdoxeZYdtEICs8O9Q1p/k39wxoPg+of3GrqphOdQr9S46kDm2TssjV1lJrRavR1beuSJJQpf0d8+BihvtjLKx2HEkQW5BHzbjNdqzvbpLyHm43kK+3kh/yZnsQhJAlAr5kZ06bmYUUwcsQv9hNjLt+V3qxd7LOzFgW56ua2w2gbpH3S9DcYG2Nq4YLfTMLC4WMVUnJ+dPktl9a+cadfhgRQS7k0enFl0TFS5uQ4H237PfxdEvnYZ/Qu1kJ2HCEIwRfQEtzwNl64fViEPmH0fC43yYp6+Ao1jR1iQHdIEUuf/D6qu9tEtYlo1kMURxWabZl4tm8RES+l+vnXqn3uNvjXKkd0coH3PHqbSHS4/1ljY+tthoFS4vSmgN1VsIZ/84V3ud6lUQOWNGlrHTfdk2X2sxUYp3sa1HHK1Ragrge42Q0pXOl6LGV8y2IyoDQIU012Yv+Ix59u62bSvdxzVGX0SGrQUm/e8zQckP0Pkk9XO6wabUJJqdLoKhd5mO7OWNzTDk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(83380400001)(66946007)(4326008)(478600001)(1076003)(2906002)(6486002)(44832011)(186003)(66476007)(2616005)(66556008)(316002)(26005)(5660300002)(956004)(8676002)(16526019)(86362001)(36756003)(52116002)(7696005)(38100700001)(8936002)(6916009)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6XL+9vwz0dh/VJDOsnds2lGs9g+Y5EgkxhL+NXV3Dfn6UmUBTLr0DS1TgZDQ?=
 =?us-ascii?Q?UAU1VWDd+5BAohBzxZCUrybBL3peijyyH7Usr4eL//etehnZpSYkQ93iDzBI?=
 =?us-ascii?Q?RdST3iqndpKIN8XO9GZTnndFaBP6b8nn7K8Z9WbaXTiZU8Yh8ZLeMIIgg++f?=
 =?us-ascii?Q?x6nYoeedqBvL/FGUlj9mJbbzlgDYqEwOKE84eNZTU+pMDETZ64Bex+ai2wv5?=
 =?us-ascii?Q?MelYS4RxPU3XFA/gFwPtPqOH2EUF77LvoJ/rQWuNT0nqGx/FN4xs/HuY3vTE?=
 =?us-ascii?Q?TtP9OHAz3rw9rH6OP71qSz2rP6nMhCl7eVpGlRPScJH7ZMATTDJLBQSb1SZ2?=
 =?us-ascii?Q?gg+TrCOea12hoUNUMWQbxYbEYQvGrCiZ0tUgD1mHsSJu/T6ZTkswaDn7AOJA?=
 =?us-ascii?Q?/CFhOvE2iWFgNdFg2mS0O9OBUKC54f5Ze0/czD3qOp92uuUh4LXGxk3K0qCa?=
 =?us-ascii?Q?tjdzx2l/gM/eKYIz553XGUC4cyc1e79b0Br+/RLEH+9lP5VeRbDdCNEcyyHr?=
 =?us-ascii?Q?CnpCvakwpl7MDIHyXBFKZtIIzjeXaaLMiJyVQZnOshj711l/HSWGH3Uechro?=
 =?us-ascii?Q?5Q/8CJ1fFOFqMOrlsvrGLbqvoXjFCNZT1JGNLLNN3X4ZIgM4u/H4tLyLXY20?=
 =?us-ascii?Q?gMiSGbcS8+JTOva5mof7UNNPD/ACik59/Fq/wul0JALhx6+5D40vuphV4mTi?=
 =?us-ascii?Q?gryU1I0Otel7Yv0DGHD6pLgitKM0bK1gFTqNw4VJUMWF5/AgT3b74wd/H7BA?=
 =?us-ascii?Q?nZxOBp8HonCG0NXOWF3k7cCp01bcoTARlTnoreSevXHNS13kTQ5JgXLK5DjW?=
 =?us-ascii?Q?EGVVePPhpmJ8vetEPseqxY8GKr4wiGb+xt/QaEsv3ItYeG1eE9fSpe13iRBP?=
 =?us-ascii?Q?bNYZ6Z+QwNeY77nMKzKOSITtLz5bs++4J5A7tCBfxCl3XPmtLjuA4caNQuR2?=
 =?us-ascii?Q?DmQZlKcQPVCbtkY85vfr086HNlIlsuo1eOGTLxyr0Kdoui1U67hsHm9rsHop?=
 =?us-ascii?Q?D/4REIwDy0IgndLbV8Prd0lcSNPAejXP2z2NYOsH91CzWUHoSaqgD7jgxLJx?=
 =?us-ascii?Q?qqXuhKyWQpEYIyHrjvwOnMkyJYzBoAG11Xj/Fkp3FrxJVsZxPTW05xWlBMIA?=
 =?us-ascii?Q?Dnje7avWt+2tdqJzH9FtLlxLToGicA8v6T92D6l6oAYSh0Uma2IZWOGpOJTt?=
 =?us-ascii?Q?6ulpAkSKHMWMenjPJqdozDtcy1XvkFlbgKyZNykBXPBRFgWsIjFiECO6GVLl?=
 =?us-ascii?Q?31q+SOKW2onLmouEeev14yxRyzLFLvQvsGsPZeJR/uOIkXYCUbD8LTwNOwSH?=
 =?us-ascii?Q?4hJbcD62+u/0Jpt98zb22kDD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508fba3e-9540-467d-4b3f-08d8ef457e2a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 04:21:42.4046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++ATrn7oltwd0oYjqEj+96tVxqV2inAq3xqmqaSR1SIjCTKSCYpacnOjw8KcloNY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3771
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add "static" declarations for those APIs used internally.

Change-Id: I38bfa8a117b3056202935163935a867f03ebaefe
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 3bbe0278e50e..e136f071b4f2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1467,7 +1467,7 @@ static int smu_hw_fini(void *handle)
 	return smu_smc_hw_cleanup(smu);
 }
 
-int smu_reset(struct smu_context *smu)
+static int smu_reset(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	int ret;
@@ -1715,10 +1715,10 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 	return ret;
 }
 
-int smu_handle_task(struct smu_context *smu,
-		    enum amd_dpm_forced_level level,
-		    enum amd_pp_task task_id,
-		    bool lock_needed)
+static int smu_handle_task(struct smu_context *smu,
+			   enum amd_dpm_forced_level level,
+			   enum amd_pp_task task_id,
+			   bool lock_needed)
 {
 	int ret = 0;
 
@@ -2147,7 +2147,7 @@ static int smu_load_microcode(void *handle)
 	return ret;
 }
 
-int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled)
+static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled)
 {
 	int ret = 0;
 
@@ -2466,7 +2466,7 @@ static u32 smu_get_fan_control_mode(void *handle)
 	return ret;
 }
 
-int smu_set_fan_control_mode(struct smu_context *smu, int value)
+static int smu_set_fan_control_mode(struct smu_context *smu, int value)
 {
 	int ret = 0;
 
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
