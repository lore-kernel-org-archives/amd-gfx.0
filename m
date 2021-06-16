Return-Path: <SRS0=JvQD=LK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE71C48BE5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 08:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E0A610CA
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 08:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E0A610CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFEC26E52D;
	Wed, 16 Jun 2021 08:36:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B7CF6E52D
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 08:36:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvXbdlfXkD8u8z8dhFXXdkpW9fConQbj5SCOK6iWRNPgKVWBieJa4Gi4UELCnwByRDWRW2gDVvPc2/uNilYpmG01owPW962ig+xJn6R6OAGfq9IPKADW2qtxeC88GI0DximSi4DkiTh8sDiNPS+ssCfMTcV7gTcPF99IsK0lUhZSGOWuJ/bWZM6uUFVa83tpid2NCVk0yXAXAtpYPWZbVR4W3WBhhaiIW8tu143G43XjM4R+GbU71cFxfVPqXNLwnCWDzkb9nVM59uD+Xfc4T9f2KD9hJDKIRGmDckgMVaBirdj92x6f5Zo0tqXFk1A2SawKvZpu4NjDcUNBjV9I2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldf0x3m7ZFW7DAtIx2RzxOo+rOic5sseIwdX3OYUh5A=;
 b=GaksLm7UJDHpCpfOoa9wXAvcyRKfG7l7NpwVxiZ/XOF15G5L1Q4JT6jtWEYKuGmE14HhjRgkB47TL9Aky68FkE8llvR1dXc3s08gO8MHT+9Lud90f59qHMp/LzGV4KSLdqjeHXPjllNKobFBSycdnTUwof4TrLN4/2mnGEq13MTe8B9srpz8k+VxN1kvcxJc9ebr01qDogV6raLBu6loUoXSl3uIr3mVuBikU8FwN1P4TPforteZTY/c2HLBiYnB8KB1nwdGNs1QXreo5i9heejgWiTCuvL5SVym8apP+HyWnSSwdufaCMsXnH1t9e+VQ/ipdkUpFsl8HOTthHdpDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldf0x3m7ZFW7DAtIx2RzxOo+rOic5sseIwdX3OYUh5A=;
 b=giUPEmboBiThwbTUtHC9LoKytGU7BSLPyGBg55BDzlbD+a9MwQfRaF2wxmUBe0bh7jcrezAvo6lpyMLdYw5ZctpVOXJDsh0gFZoHTcxJ9w5pp+GytXCchdByZwoOtsSkSoNqUQn7UIEmkwZDauea8olbzlnJTrvvUUr4MFHMU18=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM8PR12MB5477.namprd12.prod.outlook.com (2603:10b6:8:35::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.19; Wed, 16 Jun 2021 08:36:52 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::2091:3f28:3f68:508]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::2091:3f28:3f68:508%6]) with mapi id 15.20.4242.016; Wed, 16 Jun 2021
 08:36:52 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Set TTM_PAGE_FLAG_SG earlier for userprt BOs
Date: Wed, 16 Jun 2021 16:36:32 +0800
Message-Id: <20210616083632.2712-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.134.244]
X-ClientProxiedBy: HK2PR03CA0065.apcprd03.prod.outlook.com
 (2603:1096:202:17::35) To DM4PR12MB5165.namprd12.prod.outlook.com
 (2603:10b6:5:394::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (165.204.134.244) by
 HK2PR03CA0065.apcprd03.prod.outlook.com (2603:1096:202:17::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.10 via Frontend Transport; Wed, 16 Jun 2021 08:36:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe1309f0-7b4d-4bbd-f569-08d930a1e3fa
X-MS-TrafficTypeDiagnostic: DM8PR12MB5477:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5477D18FD317AA27B979B59E870F9@DM8PR12MB5477.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x+YqE5YAwJruMTS30SZ7PdvnbkZx3k7WJEkFJ9pFroRvFG94tTbsv1OdBY7fezwDBknT4jp9I7vixitvRe1kU6ibaVPQ3L1vnTlbLTQHDQRiqR3D4BVsvnJWuLvmmSZ30OAoGXHESRLvSLgEY/8iwk1RNTkEhK6z/xLhBAvoxwnRpgHQFpCXeubXYS/GSXu7JD0ukuf6VJNBugGRCnysBd50q82VI71RsshhhU3JXAEdNULUZnq3uNfhUqWNOCu1eUAXjw0gTMAgyDwtgAITC8VfNe/Lm2madaebyc5D0/+prMmbrPGwJJkmA12wbK8zjaiA+C/BhcKjzwfl6H7OHKp5zoOCAGNlaMuwsDeMYdG8UtPtJWdTu4uTOUFVp7OfmNatV/IJDMfyHwMIIQmgKeUVMcLCnVF+W/pFLrZf8p9k9thCpCmcFIKiO+SrSCIv4ExOQZgTeMEKTscnLXvtlqv1Ihf2OuuQ+ypCPXGmqSRg07R3x8HgJxkIdYnj8XJiTj4qBVGX9gjsIaYYphSXhJzN4yKqydh4milr/G9doonFV5Cs1HGYydoMJHEVI7P/VGyrr5cS/E8t3aYeXBuGklqcp4hHZnkQj3gy2u2SQDnsB8fMbKJMFia+/wwdh4bUgyVV/1JSlDxh62FhMkMYOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(4326008)(8676002)(38350700002)(52116002)(7696005)(66946007)(5660300002)(83380400001)(86362001)(2906002)(66476007)(66556008)(478600001)(1076003)(26005)(8936002)(16526019)(186003)(316002)(6666004)(36756003)(956004)(38100700002)(6916009)(2616005)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?psD3F7GyqrvXSP3MnM/L3aHKpItA9CnwREjMBqctCpIhhGmGPwyQKBRB7x09?=
 =?us-ascii?Q?OyQJVAIcNuGCzh71oubqbj68SdIABOMbujjRuVkkUA8FfoDHKb0Hr+95dBd9?=
 =?us-ascii?Q?muxcMLQbBNAaYS85CIpqDZDfOnfaulb4jDlJTrAp74zcYkzLG9JLABXrsXia?=
 =?us-ascii?Q?pPh7FZ4dyYRBe/Z1lsM1SPoVcdugxSzOBaJlmmwlUet6fRhJ1CIMX465V6Ik?=
 =?us-ascii?Q?p+VC9iChKx99VlV3tBLGXBpHs69susKFNyeFsEWQqdSE7OUQFNxZxeF8V/86?=
 =?us-ascii?Q?oJJAYqKA5q82vuGZZGtsejP2eA4txU7GkSFOWi0ppWiKEkjePCQPFXRuy4RN?=
 =?us-ascii?Q?u7zJbvk5oPeh8T0zOMXp37Tn1ObQGLoELn/22lBlFecvmd3OJAsgeDe2o5sN?=
 =?us-ascii?Q?oGZlx//vVAzpFydXdR6WdOTgvpiMn+hP71YGCmLx4HnJPT5vk6irOVDtEWw+?=
 =?us-ascii?Q?XWnNCuEp70Xs4+4pDbQdd03aNOSMIv2o7ox+ToZd8IJ4WoR6Z2Um4zubgUtA?=
 =?us-ascii?Q?kvUQdWRAHbuAnkEIZOMxM9tmQU3s0VIfHtDKdudxStIk/xJSSmCFgeK+4Po2?=
 =?us-ascii?Q?Ie5SX263716PhNPxld4zyq2ensbJGlMA7fyPw44I9OB4Q4IWQHS1bgnvY3dy?=
 =?us-ascii?Q?Xfzr6d0USJ18DtKhBEHOxwY1JWBunnGt2MLzJZEiYDd+HyM6UYcIRSs+Rtri?=
 =?us-ascii?Q?fW8WK6y15XXIEwjmNgMiEgQcFPjAvQGO8Gc1L8cRbbQKwPmzXYus70ujgbSy?=
 =?us-ascii?Q?yqgUtPKX6XIJPTs1LCoGSnlaUbeacp0D/8ysE3nw2EDA+EXcjwfYTIlSFTOZ?=
 =?us-ascii?Q?qg8VKNzPm7EAKIHDxyYTbPnvJZGoYPqCIoC5XT349zx6tzFnvdNyqYk7BF1z?=
 =?us-ascii?Q?Bpf+nO/Wo5Dvi87mAbS7DUZcgODERHvKcKrCvWPMnw86TcogxTyNqR4loolx?=
 =?us-ascii?Q?5Yxuh060lq2USZbiJSDgI9A3qilolJ9zT4uAwU9t/tUypYrm3MbbPT5Ih4NL?=
 =?us-ascii?Q?Zs6xyTVpp/o48n7fCky15/z+53bQgMNk+6FbtUslJC/+cTebFa3x71n0juEm?=
 =?us-ascii?Q?rxRpzxBgw+fLnzJP0ydqutpao9fPADTafja3wKL1FCdOnQ78KU1JNMbKsHVq?=
 =?us-ascii?Q?85oTYXz+H/xiI30ByumnftWZZYGhjnWeQ4bi+G2SoDs1aKNj/WlrduKJKtI/?=
 =?us-ascii?Q?rnIg7eKyYkOytVYHc4SHQj78GGF2LVRUAh97UBlFWZldYj4m7/4O4IUMtQ0+?=
 =?us-ascii?Q?wsuW2+zSHeKkfvmOjM1EQkK04BQhlaJe96ZjIYcrIty/RGhotrPMl46TFFpD?=
 =?us-ascii?Q?yU3JmShC+p9alMI82fajwBkK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1309f0-7b4d-4bbd-f569-08d930a1e3fa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 08:36:52.4110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7/KUIf9c5D1yiHRKLL8yDx4LS2/zlseFhMVa0HH1h8QxI4INjVAI9kWXL3dq3CR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5477
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 xinhui pan <xinhui.pan@amd.com>, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Because TTM do page counting on userptr BOs which is actually not
needed. To avoid that, lets set TTM_PAGE_FLAG_SG after tt_create and
before tt_populate.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 0887942b4622..97c83164ce38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1147,8 +1147,6 @@ static int amdgpu_ttm_tt_populate(struct ttm_device *bdev,
 		ttm->sg = kzalloc(sizeof(struct sg_table), GFP_KERNEL);
 		if (!ttm->sg)
 			return -ENOMEM;
-
-		ttm->page_flags |= TTM_PAGE_FLAG_SG;
 		return 0;
 	}
 
@@ -1174,7 +1172,6 @@ static void amdgpu_ttm_tt_unpopulate(struct ttm_device *bdev,
 		amdgpu_ttm_tt_set_user_pages(ttm, NULL);
 		kfree(ttm->sg);
 		ttm->sg = NULL;
-		ttm->page_flags &= ~TTM_PAGE_FLAG_SG;
 		return;
 	}
 
@@ -1208,6 +1205,9 @@ int amdgpu_ttm_tt_set_userptr(struct ttm_buffer_object *bo,
 			return -ENOMEM;
 	}
 
+	/* Set TTM_PAGE_FLAG_SG before populate but after create. */
+	bo->ttm->page_flags |= TTM_PAGE_FLAG_SG;
+
 	gtt = (void *)bo->ttm;
 	gtt->userptr = addr;
 	gtt->userflags = flags;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
