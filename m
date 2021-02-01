Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C6AC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E649C64EA2
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E649C64EA2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8206E6E0B9;
	Mon,  1 Feb 2021 15:33:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C5496E0B9
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 15:33:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UohaRF02JPdarKTfu5g0UqK5hxJbK1gyJZZ4/76SjQDv7xbw7LySg7RaAaXprQlVLVSI8NHSSNfqp3i/zfg37/CzwXU0GOt0z/ls/XZaJLGrgwTMNNIsVrG8px4r6NzWRKTYQ2O3jMC8GIZ9umip5OxC9ceaDyIyHdIZ/Icc8zp/Od/HoSL6taoQ/f3o+DUBCVICM3KzxwxRSSHi/Qq2b+ak9zBBJq69IPtBpX5wFt1bcPpMJzea34iKu9x4X/4XKeLO5IKxMGqceAbuaKSa2iuAhcurdx5LKz8Pb7c38Up6IKuwiID2zNPHR7ojXHHP2FVCxVz3DqOJi+zS3AYV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1ZTiNItQY+XBWwfWyVtuETwI6M3KprM1r75rkZ6zPI=;
 b=OIqcFLpbfb6g0GXXM2C7tHLvsfEXCcJvyx0R+OsDCCFL9DT87c3ylgHTIefUgmzGyKt7y+JTP/yNRaQQeJl5JnUyEFXhY9Xq2IUbWN1ePjX3KI6H/D/vddsH9/8CKQp8V5Q3Fi6K64dL8Rg/HcLpt0/vcJmNuW414vJaMLPb0S1aB2d+iX9yLiEMtLS6Eiv4N84461jSZyAfqYIdzXL5V7b7VGxiIkmNhqccxsTcxxeQecVpFxuDTPimHu05hm8R8S/qhinI2pM7b5/R2c1uZuCXpVm0UrvRbKm9IALW8m8bJSguATjqdd5tPkimOqQcoug5KCwfajEz0WBcjcL5TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1ZTiNItQY+XBWwfWyVtuETwI6M3KprM1r75rkZ6zPI=;
 b=ERH62gjBLCKUq5fZDUwwIy23He/dkxUb94/FeuzjrLCTI1a/wPvsVYEDveXke0vztcXvQ7G+0X4uxK27Sz7JCl5V4Q+1sW8/hHM5RKASXRnMAL0UD5aMBsn/k1WW10HgKBxTw0Kz/qKz0/Jw0JEF6N28wvIT2THstva0xuR6M3s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4909.namprd12.prod.outlook.com (2603:10b6:5:1ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Mon, 1 Feb
 2021 15:33:31 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3805.027; Mon, 1 Feb 2021
 15:33:31 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 1/4] drm/amdgpu: cleanup ring priority assignment
Date: Mon,  1 Feb 2021 16:33:18 +0100
Message-Id: <20210201153320.59415-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [93.229.32.223]
X-ClientProxiedBy: AM0PR06CA0089.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::30) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.32.223) by
 AM0PR06CA0089.eurprd06.prod.outlook.com (2603:10a6:208:fa::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Mon, 1 Feb 2021 15:33:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: adce3db2-effb-4711-b927-08d8c6c6bb0b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4909:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4909453B44E850AE0872AF368BB69@DM6PR12MB4909.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v1lJXYCFKMOVMlDkKGH53gbdvz7ZZKno8LfKSpmxfs1RYE+2/4v/nTV964YbbgNQAEFbDSrLy5wiri/r7HEOk+9N1gapORLHb1iXzH+r4pI5v0gV8L1uATtrxGdzJSLILYfZrNiBTiIDhwMPmPO/MyquPVeJPrbSI1Zsl7fTIIjH8/9NDDsxmkz1Q8v5U3TtL7zsuiRW/pQswzJsfngV+W4ErIWl0V3spr+eYjTn5joZsaWUhOn/xmrI3FtrbwaJnCVvXdQvvJfGV4YmHWp4hVbivUI7wmAA9xcEQx7CDaReN5PJyMWEdk1JFg7fpEkLKLaFqF4Uf8xKwOp7r++YXvXA+537FWyYZamcwmTCoZYtoedknPlaRrefBBoRqXM8WRAyQkaH2+nuZXR6iR7ZMBlFkJfii4S5gX3xVEFBe1kgrBJ5jve7+QaxP/jo3cwz1uygqpJ6kU+wuK06WQJJcj2DDgwHnx+TW6kqdi75lfGUXsQnhOVEkKc/GpHV4tVsBn2TzP4BT6PVwMIIEXnuOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(26005)(956004)(2616005)(86362001)(478600001)(6506007)(6666004)(6916009)(186003)(6512007)(16526019)(8936002)(6486002)(2906002)(4326008)(52116002)(8676002)(44832011)(1076003)(36756003)(316002)(66556008)(66476007)(66946007)(83380400001)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?oscERW+3aOr2+D1RSFN5CwE/GxfUGW/9tHpaP2o7WqhI+akp9lo6wBSFEl2b?=
 =?us-ascii?Q?3HRl/bWPGhJcFIhMbzgjFT8gEurewVI4dvT4VBtJUB2ral3KFHpe3aa1GKwD?=
 =?us-ascii?Q?oIdwKWEqr3o9Tpu5mT7ug+pwPOQ9DxKgoqsX/f/1mT8eOqwKZcMpufBMSjbb?=
 =?us-ascii?Q?TJ/b2uS1kAefg36hLTkplKz8ivKbkOYldJ8iSh8oVfLdg0j3NR/9PznnYBX/?=
 =?us-ascii?Q?W5fyRrk79+Bu5gLw88nFejHhjFwA9TLwTJvYKm4rZynjwQvD8Z+GT9Y+mEN8?=
 =?us-ascii?Q?dDJjeV5cIMGeqTt8w/uJhbY0K9GizsS/URAYj/cEPlOaATV//59MHKssMLUU?=
 =?us-ascii?Q?26247vov3DAoo54UW3L9GPl3KBWbL9Q4tDEyvg1OOP6cbxHz342leg3a0orY?=
 =?us-ascii?Q?rc4J1tXxy6cPFjE0Y++9QEasffJ5O+Q/nGSQzGPDBt5vYX6v6HEg5SB7uOWI?=
 =?us-ascii?Q?WMckewrTTRATWAxs96QOm7f9JMoEIJqW0krjfoZjamjN4PiE3EUL7/9QmizI?=
 =?us-ascii?Q?lSOiyPh1Yzs2BbAKOAjLy38uFnWNK7TbBE8vJB+4fA0xcQyPD7uUJVFvoTpz?=
 =?us-ascii?Q?mW6M2Gb96ZzD0IQuNqmB0KIlijcJXSTGQ47ch9doRKnS0v/8fLTg4jomeILq?=
 =?us-ascii?Q?C60SQPEC6sWiT8XAXg+pyOb8WtrVb0M8XrmrxTbNRfpHquu/kYZPl+ugjIzJ?=
 =?us-ascii?Q?wUUYs0AFWp3fFb7OuGTz0uIkJfDWlBQQXFhIVEq09O0JvZXtv22tq8zeox44?=
 =?us-ascii?Q?3GrJiYSA1pLl7kwkU+ihSEDww/LL4E6U2pa6MX5Nm8kibkIJGFBzNPv3UxB8?=
 =?us-ascii?Q?3Pb15V3lBBOx13GqyXhJJ//bp35hiBa59z1oqSxlkzbr0Sd9/OWE1BlRfnb/?=
 =?us-ascii?Q?XybCerii3HuCSRBTVCCUTdnpzNUpU/ZZnG83oz6b1xlywJX6RAopdLyWGTLS?=
 =?us-ascii?Q?/K/VRU3tqR2L4rx0jl0AVKZgQlnFfKiX6lx1U2kJXayHS1pKTLvyJ7wJBa08?=
 =?us-ascii?Q?04S6Wrqrb/F3xE3oWdXF3UHqnjubcPrT9mv6UfD7nlVuKqgH2l6txJhL/icl?=
 =?us-ascii?Q?xLXqz+BT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adce3db2-effb-4711-b927-08d8c6c6bb0b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 15:33:31.8466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gg8grZBCNu7/dhe7j1nK15HuCnVv1+4IaftKwpEQaq8lpyDGAZ1pFP3rhRW2jPMyjipJr/bys1e9D46N7yBk6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4909
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
Cc: Alan.Harrison@amd.com, Felix.Kuehling@amd.com,
 Nirmoy Das <nirmoy.das@amd.com>, ray.huang@amd.com, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Assign correct hw priority for compute ring. Also we assign
ring priority at ring initialization and it remains unchanged,
so we don't need ring->priority_mutex anymore.

v2: remove ring->priority_mutex.

Fixes: 33abcb1f5a17 ("drm/amdgpu: set compute queue priority at mqd_init")
Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 1a612f51ecd9..c45d9a3f378e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -258,8 +258,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	}

 	ring->max_dw = max_dw;
-	ring->priority = DRM_SCHED_PRIORITY_NORMAL;
-	mutex_init(&ring->priority_mutex);
+	ring->priority = hw_prio;

 	if (!ring->no_scheduler) {
 		hw_ip = ring->funcs->type;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 7112137689db..a831003c2d53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -244,8 +244,7 @@ struct amdgpu_ring {
 	bool			no_scheduler;

 	atomic_t		num_jobs[DRM_SCHED_PRIORITY_COUNT];
-	struct mutex		priority_mutex;
-	/* protected by priority_mutex */
+
 	int			priority;

 #if defined(CONFIG_DEBUG_FS)
--
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
