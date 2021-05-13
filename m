Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4C9C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 18:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF2EF6100C
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 18:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF2EF6100C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69C8C6ED9D;
	Thu, 13 May 2021 18:42:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 339E46ED9D
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 18:42:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxV4niyc5bCxSacHM1ZhG/piBAegUA1CE9wFRu1Ns9lnNpOyPlncbQ6j+vidpsB6q3ZKjpUr3YE/WDmzXxhCOv6z8/TiC77luyGrsj64q4CkqU/yfguqgix+l0paWYK2eYDSEMkHct5IrANS6bAzdhG/F8iP8KkjTwzLJy/bVlaiKG6mLKvFEsDQaYvFhp2oPn4pDmnFtD80OZbqeLoYLvmY8Ae+fi+nVR+cCC6QQKICu8XsWxW/IxvPiExA/5ERY3+HXygSdnuvAdHLvhB9t4B0ltW9Os44thf3wh1T5uyRGlOpervLx2f6wJj87eHPfRsERMtqdfCefxZ6jGMW3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gc6UlRxHDfGqx9W/m0qpCydMhpLk8hL55x3GOIH5gfc=;
 b=TJO8QrLbcOGH/Vvwjlg2nS2pVXIqOClB1LSnUG9IbrgOc9vqnXz+yRwWFFXqcLkkRAcbhPb6GRIGIWNmNpaziaeAkgDfraVRm8S+hZzJ5ESpxr86S+eLOoqkszJ5yXXGe4uv8x/vdzDUkfKmpaBI5/ToK6jvl57FWxoUKRzCF25fftiiGhb3DtCLPRjv7kLKoro7y9t7hTqWLSsg1fCAmiwRaP5vks49bubGJfHhglzOqYVWyFyd8eZJeYH32q3D0j245WXf0vqEge4m4aTKSwwQdCTPqjadh6KI4T/whTbBp9yzw5NAqU14UosjF879703l7VQyUwLAVsWhSJUekg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gc6UlRxHDfGqx9W/m0qpCydMhpLk8hL55x3GOIH5gfc=;
 b=so+ebZJJn499PIT8LqEF5jPo3QdQCtvgg9NLPsXwe0c0oM6t64yJQ7X3EhBWv/NeqIalxxZ+Mz7sdw08MUtz5wKiHD3AlMr9l0lgnudwZ17MswUBKBNUSRe2E3V9uxZJxZiriDa/bTPaqg0XQhOWSN1zWXjGbtNjyepK7HyZc2o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4093.namprd12.prod.outlook.com (2603:10b6:208:198::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 13 May
 2021 18:42:03 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 18:42:03 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/nv: remove unused variable
Date: Thu, 13 May 2021 14:41:39 -0400
Message-Id: <20210513184139.502126-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: MN2PR08CA0028.namprd08.prod.outlook.com
 (2603:10b6:208:239::33) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR08CA0028.namprd08.prod.outlook.com (2603:10b6:208:239::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Thu, 13 May 2021 18:42:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccf46844-22f9-4d9a-703d-08d9163eccec
X-MS-TrafficTypeDiagnostic: MN2PR12MB4093:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4093F08EE33F6452C4A736D5F7519@MN2PR12MB4093.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:421;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lQ+YJIdDQjAM/RH3WrF7LfI/HVozydNViZQ8K/u/QiH1OK+Wc4WpNbXIq2g0GAYP028DOLttruWnAB9JfgEJQ7ytXtfjsriGzHGIXmKREC49Dg3nQuV4yaSzEehKu0X3vD4r8mg1wY8qv6kBdEn5d4ALRU0SswQYaJ6GlA1Xzj/IgcPfXJ8UtKoCrCRqNdxV9HYUefCuNgJD+jOjNze1SIdfaRo/ZXMi5UlzwQltPXaCoF26wsNBn1uzhgpn1i5Qn/PjrshO4zD+PXvHqJDAZ/pL8PSeO/mBo+z4E4JApmoMVIYbPx2PhPykcZCAOvCHGzBsRDYYfz1TwtEX0P17LwfgFz5Jo0mJqs+llKsNyZh0PDmz9hLy9Iy65nBrqycqX9ZrHnvAWg6t4Go4PF9dxc3TCseXoHhYWvw32ZaRVE5PhpunaWnQ05TDwqqvkmIkqm/53vFx9TjlfNfpo6UCXxmPC2LK0d0m9OTeF1/D2WV0wfWNCizkMOt1yALLBINZlacPyu8Pe98EJw8vMaRh626TWoEKo98/oIi5NKKgnvEOpHSWiAtH0hnb1LaPfxvkHm8pthESZ4A5kWsHUtyrD6nvXyUnxklSq6g7mKfL9EdGEAGAiyTflWNfcVDIpI6KPWC6DrL/tJBmWrD76agt2ueAlwNx21Gjrj0b0ZP8gqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(39850400004)(136003)(396003)(38100700002)(38350700002)(8676002)(52116002)(6666004)(5660300002)(2616005)(956004)(86362001)(54906003)(6916009)(36756003)(4326008)(26005)(478600001)(16526019)(186003)(2906002)(7696005)(4744005)(66946007)(66476007)(66556008)(6486002)(316002)(1076003)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gds2F4Q+hLMHM7aVzSpgOS42Z0Y5YyKyGuYa/Y1lmys3KgFvJOrcqxNWWowR?=
 =?us-ascii?Q?Z0GTjzYalLMQQqCRJNIN8gVyOozG5YD4TroZTXU3h7iyU4+qppLuJR5SlVvV?=
 =?us-ascii?Q?6HpEkcPeoswKjC1RwjzesOX57SaZR1TQxNrCTUBkEJknZCaNJ6QTxfnYzVG/?=
 =?us-ascii?Q?UC7Vyl6AiGtvJSKxhZwLmwQTK5iZjOB55F+MH+0PcmDxe3LtjzijiGZ4Y9L3?=
 =?us-ascii?Q?utkzPPuD6cU1BnKOyOcc2x8soxv7cgn5v3eFX2CPa59J0C9ssfUagy3JFP9S?=
 =?us-ascii?Q?+g9v0Vx19QZEe5p1/BG3uV5NeKcZyicJgoD0Mj+6LqcSUkwqdOEdBh+DQqd0?=
 =?us-ascii?Q?PgDZAFaL+1x9Gc68jyQaz0UGADh2RSeNpQ/nzBstiYioseDDEJMY+6znGt0p?=
 =?us-ascii?Q?V8HZzA+95H2eAliog07xDh1YW3la5iQ2U6A0hrXtF9Kyxn0//6qYZzc72Jce?=
 =?us-ascii?Q?TAYyv9t1i9oy9EDFO/1686Tbkhk86zfoJM5ksqrs5qJfoGxVlufKxF7ab1nS?=
 =?us-ascii?Q?QYt4KryKeoDKDxIFD7uhkyTkPpA6T3T123Fq/XcyI0KDcqsNgSf8/bUvsFND?=
 =?us-ascii?Q?rYPU6xJ1q45KT/ScHV38cCKK2PH+kqYsbu3lBQbHXiNdgg+8bZnYafqmgsgm?=
 =?us-ascii?Q?wjA4QHDGxJT2uE+C64+LwnTYVsTACCSk5f80LCLYhwvZOG2Cl6z8WWYP0UQD?=
 =?us-ascii?Q?G8oC7EKOAWCzgHCVcUsogLxe44iSIddoMPXPsu1tIER/6YYvGB3dlyiUZV9n?=
 =?us-ascii?Q?1Y/dm5WqtyTMl5Vc2zrqVlE69LTHvawd5eovLmClfXa07PzMdcXhuHaXFnaS?=
 =?us-ascii?Q?6ntoRHpAZgnkXilyz0y76mxNqCnFPZk6jUzOtl8EFOVUPNsOLniqSDqV7YMS?=
 =?us-ascii?Q?lwrTqhof7zfLM1MIVw2grfGIDEzUksVSpw4/5o5eZiOZoxVOB2zH3BejEmZD?=
 =?us-ascii?Q?NMZVGZ8GNvx4Rb6O4A4GPfVySWHAFHRdgz4+oPvFYAVwZQasYUM8/Yc096Lu?=
 =?us-ascii?Q?ZbIOJLX61IAaxpLcQnO4cG/P0TQeFV62D8okXDpGU0GInuAEL37JVWCRxnpy?=
 =?us-ascii?Q?4vfRzuD1dJdfBtpAzvB08ZIvmqaC9zO95AgXX5uppD5ACH4vqkpX6nk3uEQK?=
 =?us-ascii?Q?Gsg+cXFzgiLlvpoSpG5LFAPUxxBwSsZArIS0Aq5Il33SjMAu1YgmO/ZFp3n8?=
 =?us-ascii?Q?dcGSwv987G8yNwuw92brvhkLtKAHXnWVHsaygjjAKjFHVtPVjUtXwQRL+SGH?=
 =?us-ascii?Q?p1ssm5btX/4bwazeJcEFvd3QvZZ+EaYXlFRYeK8yHRQWlz2HBse84LPMTH9A?=
 =?us-ascii?Q?kM865OB5rYZzS3qRT2MQi2rh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf46844-22f9-4d9a-703d-08d9163eccec
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 18:42:03.4523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+g4kU8uJMKLrRbiIvymDUtGMNCza0KdMkOAhI5mt9U8lcN7BgoGDOuvLfNDSyZM1IPLYpUlUarwt/08F5UJBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Bokun Zhang <bokun.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove it.

Fixes: b8d598968950 ("drm/amdgpu: Complete multimedia bandwidth interface")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Bokun Zhang <bokun.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 9f74060207a4..32c34470404c 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1276,7 +1276,6 @@ static int nv_common_early_init(void *handle)
 static int nv_common_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	uint32_t i;
 
 	if (amdgpu_sriov_vf(adev)) {
 		xgpu_nv_mailbox_get_irq(adev);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
