Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25858C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 04:27:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0D13224D3
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 04:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D13224D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F9FC89AC3;
	Mon, 11 Jan 2021 04:27:07 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700048.outbound.protection.outlook.com [40.107.70.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5959889AC3
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 04:27:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBBadHG0jqRDfpUrGt8QeeVriA55xrnsnLAZodPydKuhP1X/g/8mCMTf81rkJMno4NsIka+zSi0MAcMzkqbce6NwRT44v+sk0Cnx5lVG+AxlYRS4P6OYtakvNbIg+tBDN4n8KwYTx7hQG2nac6kA01mJ1nHFECz8amS5rfdhgTUdMk6wypoBFV7Uro0q/MDXl2ML7ZvzjVeHhB8XaWgOuhbNfC8X7SE2ZcGEwGy0urTiSfDa7okgl+6ElFbFdiwMACkjnNC2BqpUbdcaNqx4BBxISwSXHafPvrwphBis3xVZ7HFI94ZGkNJ7xrX+tPDIH8fV/fPf+b9xK4WZkI+jzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eI8gSt8RgMbq3Jpn4i+upgSlP5v4n7nUQLoNplifatk=;
 b=DG/sdlAfVLKA90czDGtvHo+LHzjrh+oB5IK4nKjrXCXJW8RWei88R8m1Umjvw98Y5YEaU2Md1TJtd129M3jB6UinRnuIVXZKg7rGYXgb0Ymxf81KA7i3d9BvW2YzTmtO4cTpjEidZxU+ugTR5j38Zo33MqVsprQWhKv+/5GLiBTztdhAZb1dtbuG8/u9AAKBoA0ZUAvi45H/SeboF7Lnrvcibbpq+0EQ1khx1J4BiffVZd0GhT0IGZQvKafo8/44xGlxenIcnQECnY7cvRG80iafy2QmjPnItu8PZ0uTK8sme6Ehr2dIoVglVZzGNGqVPYiVXIhyGztU0s78TC44JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eI8gSt8RgMbq3Jpn4i+upgSlP5v4n7nUQLoNplifatk=;
 b=Ea+G6HyLR4gtSPq4E6nZX97klGr6Ol3rkGfCtuQ1PnrYIbcx+wt/th6ht6CDcoqdN3jynNbfsj4oQ7ahoAd78VBdgDx7YVI1TZrDeR9oJsaU+ckwBJ5Z2fB0FwneOxELo8yNO4ft1V7wvfQgWoY37gRDAeQCnCE9b0ta0o2iUAQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1792.namprd12.prod.outlook.com (2603:10b6:300:114::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Mon, 11 Jan
 2021 04:27:00 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 04:27:00 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 2/7] drm/amd/pm: enhance the real response for smu message
 (v2)
Date: Mon, 11 Jan 2021 12:26:09 +0800
Message-Id: <20210111042610.2234748-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:203:d0::28) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (180.167.199.189) by
 HKAPR04CA0018.apcprd04.prod.outlook.com (2603:1096:203:d0::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6 via Frontend Transport; Mon, 11 Jan 2021 04:26:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 92e98f39-baa9-4d18-97e3-08d8b5e923f0
X-MS-TrafficTypeDiagnostic: MWHPR12MB1792:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1792D8923969831752EB80B9ECAB0@MWHPR12MB1792.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e5bEumuNvNQIk9GaysWHXkApMzYt8Mp3urTCkLa3ALEOQCQPyzaDlMEy5QjEpydWP0IaGTAQWL3bSAVXZfdrSTVFE4nptSWLi+kxbG+weJAOxvVTwkBaKUjLQlsCeUn2B3AANng/P2myU4rlb9TdK9X0YNNb0QN+DN2kizc3qmeUEei3CSTAvTn/EzTvOWt0S/b1u+I9ja8LTYK78PCC4ZaA1VEyPLX7j4I1LKlEt7r0WWpP9d1mmXBZE9x7VLvkITG0E6xQbV/KRfHc0Nc0QIWH38iBajaEIaH5mJWKohzUs+BRoK7HOtOdN/wTFnKZnZfktl7jWP+AvQHZzENneL8eh2VxfbiTK0od5Xaj+W509P33sGcv6iHiZHaWkjGojugeTkI4/4iWSYUbTTFKMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(316002)(1076003)(66476007)(54906003)(66946007)(6486002)(5660300002)(66556008)(15650500001)(26005)(83380400001)(16526019)(956004)(8936002)(6666004)(86362001)(4326008)(186003)(478600001)(2906002)(7696005)(36756003)(52116002)(6916009)(2616005)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Rmtu7qQhzFbDXRx9FGJxB9Fiue7CVB8y1WAT6xJL2fmKfDxtkG7BiAKwfGja?=
 =?us-ascii?Q?TTTc7Lq8JpQyvVPSxp2hfBlGnuJswTFyZhEOxD4CFkfpvy/53hmEJgStyulM?=
 =?us-ascii?Q?zmlRIdngq6XPiAojgKMiVeoMZDLjMn8/GDSjvxFYnGub23UG4F3ZsUHU2r/t?=
 =?us-ascii?Q?mk9DSyz2Rs5YpnUcbf7cLhxRcDbM89vPQsMqfl+Q65+xauwEj2m0LTl64OlM?=
 =?us-ascii?Q?BrFHhrh9KMVqUx+IGzlPAPKhP142n0QpFwN2cJu/pNbmlgAw2vmhjN9PosFR?=
 =?us-ascii?Q?n0kJtuiMKi4m1MeMwJzRbprjJ46qp6mBmRDQfUAXDifgC17ETP7IU+JqWKHs?=
 =?us-ascii?Q?SKB2jXSvjapOOHDVGNwTm2BQqPwh8fzB9qu70/XFG44il48k5AhiN89IxWpI?=
 =?us-ascii?Q?zRkyd5JtKqWJBHbqoPD0RdNoEFlpPvj94rhHUMdrr18KQR/khMqjXQZO2RfA?=
 =?us-ascii?Q?zB/CIGOEaD7rNU8Stzfv/1DKLzc+0BOLjnZ5uFbS3oB27hkD5DKtC098kaW8?=
 =?us-ascii?Q?w1TggY2q+29UaaLRRcXttlXfiP/2yHIcsf7A3NGCiZ5A2Y3zhqaDK9MA4M8t?=
 =?us-ascii?Q?VIJH8J5ClAAFC6kXNZ+bbTKaTdICxous7jNK0uK6rNSSs7QYixe5witk5O9r?=
 =?us-ascii?Q?+32+ZV3h5zDOuLNoAR6Zk3jSvWCN0LWY+ZEk5Pv5le+OqQnmFvIEOS73R46G?=
 =?us-ascii?Q?AEm6qEsk9hiddBwpDA60rUcGKcjCTUzalaEj5DMuBz4MOoc281FI5bznXUNs?=
 =?us-ascii?Q?civxhzlb8qPAL0tDOdxMqqUbV4AIAc9ua/vFA8xhQ/fJxludqBTV7Re3f0sz?=
 =?us-ascii?Q?Op/3sivHSsumc5wPIIC9iVk0z9B2HOmlbXaXDAKhHpfdrTPHyc1zhY7/wVdm?=
 =?us-ascii?Q?ZUtYPPMnwBV2MeSjzN5vTFYSxJM3a3J8DekFGCKzN+GWUm87YPGO0CWxGw1B?=
 =?us-ascii?Q?YmIMRvUZE6xs5O10Q/INHDbw4veZAsFzU1DMtf21ACT1AJQAbak5k3wDI2Ub?=
 =?us-ascii?Q?INqN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 04:27:00.6633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e98f39-baa9-4d18-97e3-08d8b5e923f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Dh5ZGdGZmN5U/S0g2f3+qLxSv18i9IAE+BT2Qi0eaO2uqEs73/MiChQ4lcVBYegLFgw0qvr7CQ0agM4Q9Ec2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1792
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
Cc: Xiaojian Du <xiaojian.du@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>, Xiaomeng Hou <Xiaomeng.Hou@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The user prefers to know the real response value from C2PMSG 90 register
which is written by firmware not -EIO.

v2: return C2PMSG 90 value

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index f8260769061c..59cf650efbd9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -92,7 +92,7 @@ static int smu_cmn_wait_for_response(struct smu_context *smu)
 	for (i = 0; i < timeout; i++) {
 		cur_value = RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90);
 		if ((cur_value & MP1_C2PMSG_90__CONTENT_MASK) != 0)
-			return cur_value == 0x1 ? 0 : -EIO;
+			return cur_value;
 
 		udelay(1);
 	}
@@ -101,7 +101,7 @@ static int smu_cmn_wait_for_response(struct smu_context *smu)
 	if (i == timeout)
 		return -ETIME;
 
-	return RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90) == 0x1 ? 0 : -EIO;
+	return RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90);
 }
 
 int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
@@ -123,7 +123,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 
 	mutex_lock(&smu->message_lock);
 	ret = smu_cmn_wait_for_response(smu);
-	if (ret) {
+	if (ret != 0x1) {
 		dev_err(adev->dev, "Msg issuing pre-check failed and "
 		       "SMU may be not in the right state!\n");
 		goto out;
@@ -136,9 +136,9 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 	smu_cmn_send_msg_without_waiting(smu, (uint16_t)index);
 
 	ret = smu_cmn_wait_for_response(smu);
-	if (ret) {
+	if (ret != 0x1) {
 		dev_err(adev->dev, "failed send message: %10s (%d) \tparam: 0x%08x response %#x\n",
-		       smu_get_message_name(smu, msg), index, param, ret);
+			smu_get_message_name(smu, msg), index, param, ret);
 		goto out;
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
