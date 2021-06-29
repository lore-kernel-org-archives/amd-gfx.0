Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1113C11F66
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 07:49:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8145561CD7
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 07:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8145561CD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45DE089708;
	Tue, 29 Jun 2021 07:49:33 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2046.outbound.protection.outlook.com [40.107.96.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19BBE895D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 07:49:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3bpO0xCa6S9eD2PYztj5JZNq5KowfZTjLcj61tX92jl3R//ORVns+sQAxzDUgPf9c1dhjjQFeNhZEWqWFiyhIVM1IMbxiH2LII/k/fi7LkE+6U52KnAPwx+z6vdi8gVO9AsiZezfNKZ43B8CaQMUl7G45Z+1bh6pG8ApkqwNGZbXuSj7u5ZowpS7VB0bfoq8LFNe2AR5wfytXKt03F0GFTpvEXbFRaMJCJZRaRxXVIWDexFXoP2Mx9YLfMBqPYBrGt0jmtZMpgUwKOtcjPSJWAniGJTtm6LfWlXIx0DPgnYOLhD49sdtOQdTv6IsY80l8rNTA1mFUyZIVdR1Yp1uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfiU2Grt1gZbF02unzY99ucCy0+FuPAUAWEsRza8kqk=;
 b=igJ2e3zZFgXWLJoGUIVXve1fgmuSb7ObmKbylHWQPNQyoNSwPCm/X/BLHHepmzsa/Jt0jZGOn0oLjh+IKE3qkAK+4Pf6b/564zPVjd2A8yNNdzZQvsoFBGvo6OAMQ3+A50ojwJp9tcuCz+SlU77t0L2p467MJHrH2exHXw+DNN4AYqcRBOosm4IPy4ISdrwZwYGgq5vQm1tjTjHzD6O/s1Gv7B3p9KMQWOacu69t/fde0+HEErYIuBxzH5qqJVLpgiCnD0pcwd+3shUf5e9//QCCXmfN1xv6vWug5z2mCjE5EW0pp64fIKOCHcSFwyA8JBXCIvD28nV2rh6HB15dxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfiU2Grt1gZbF02unzY99ucCy0+FuPAUAWEsRza8kqk=;
 b=fsz+pk6AeLQrh4kO33LxEImTm3NgemSEmenNcerJB08VTOu3Bc7n0VkNKatZzd3xReL0GJbwz5EoLaLm4HbOe2kZPujPTufCkx+DRgJIJ/thmQ+YCG70K9b0SjfZJGcKjgukhrx6iYKFJy2l2rm1tr8bDFJxcH7NUsUeoFM8/aQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 29 Jun
 2021 07:49:28 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%4]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 07:49:28 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: free pasid early before converting a vm
Date: Tue, 29 Jun 2021 09:49:14 +0200
Message-Id: <20210629074914.4114-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210629074914.4114-1-nirmoy.das@amd.com>
References: <20210629074914.4114-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.118.245]
X-ClientProxiedBy: PR3P192CA0009.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::14) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.118.245) by
 PR3P192CA0009.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.19 via Frontend Transport; Tue, 29 Jun 2021 07:49:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c69afc5d-35da-42a2-4121-08d93ad26c3f
X-MS-TrafficTypeDiagnostic: DM4PR12MB5088:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5088F3DFB865201B4AA9158A8B029@DM4PR12MB5088.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w4v7gNPjF+aQbaeAWruhwco+C3E2K22JMofHa1j9/Dp8iaolKPjroultTRyjKfGbcnxSVztte2SdUkBHOLWyJj6ejxdWRbXL1lCxnxWPfuZMwwyO5VJhLTT3r0WTYvPM58WaaaY6RATD/5MOzqt3YpQ6x1AY3uLOwFFPAwmSwaGmkOUvfB3zPEI9WY9bHgZXHcAR0EOfMEVQAv4yfl7lUWm2KvZdL1+lgjE2Ncrd0FReNceQX7ucSs4/XI0yC6EmnKhL+fvbc2LVisQZeiZekCMK2qLUK1nawjxlKWg3twW8OGCEnThchKkrJc3cEicclkl05W+yxkuDp3oxxMp8000rGtL22mqW68PfGsoaIeoI5zrKTZmyPaVIo61AnG/6XdaK9ErV28Z0ZZ+djyroV+cxKYXM6yFXLnqskHw+AfcLUc5kclr2000gN50cve/SbZ1mIHbiSI9QSa12adJWqNHRk9vjOiWNisvzweqqU5T/SGl2/r5bBRc9fzSiR+DsSRTwV2XnD2e4Gmvq7XsU00mmO2u0lj5nf/ZrFqMNn2t/2QPETdIsgr+PaSqVwi692qhlTtNOrTE1QcVPvn6Lfk0anqhtbBmMH0pGJfEvTZkWn6yIJ8Yg2jtSMMipXQ2nyin0Oc+8FoWaY/LKFXJWriKsL6pSiKadfvA6TiUUeCBCkwV4mMuyKm4QC2Ev1F/LudPRXAvbX9aAhJ7BPea50w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(52116002)(6486002)(44832011)(8676002)(6506007)(316002)(8936002)(4326008)(6916009)(16526019)(186003)(956004)(6512007)(26005)(2616005)(478600001)(38100700002)(66946007)(1076003)(38350700002)(6666004)(36756003)(66476007)(66556008)(5660300002)(2906002)(86362001)(4744005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fwRasiqh6lzHiKeryaIvGlZ1cmLrLUVavBEyDgCtV56rd19H8sD9WHkJ83P/?=
 =?us-ascii?Q?cojH5/VyIImWSIE3AvoIJAY0ygYSRcMWZnoBg+rrS5GgiRDcga3XP/HDiZKB?=
 =?us-ascii?Q?+MP6E+o6ABJKQvI1V9ZFqnrcOL5ecDa77LjwYPpjczDm7M7y0YMYk1P16rsg?=
 =?us-ascii?Q?pEgY4OW6TwdNDBahB22hn3Iu23jDwDpn7hxeIaOnyLkny5hsdi9YbUg5BZg4?=
 =?us-ascii?Q?wUvh/JYE6r/4FtixpyQcyAF6JPFs3MJc9tx/PPcWwJ0aFGDMuY3ensMmjy6D?=
 =?us-ascii?Q?aigcq0YtEjt3fezCBqXRRda2B2PilR0AUN4QUovicl+Kttok3VtpYDtxopse?=
 =?us-ascii?Q?Ibg+OkGHQUzI/mJ/aZBSofFUmldCE8/+964Me8ccwEgWzMVeCAaXJSDCeEoC?=
 =?us-ascii?Q?UaXBlNUtkvKv1yVxqTQovOiAR8tKAeKiCqSVSBfXFEYyToJBfIsfMCksqLtc?=
 =?us-ascii?Q?1LPHF1xJcrw1pjOL6eG1sniJiJKOeTovCo0iUEWjaNTro4sU9nY1QeD2H3Oi?=
 =?us-ascii?Q?/BYIy34oMt4h8bWNdXWdV+vrUPhV/ppBpy2cBL4baD8qZk0Nrsu3zcerrT/W?=
 =?us-ascii?Q?bKsCzMC+1oQarwByMcY4B/pZt0wVSqOEeN+W6GTJJ0X4O6ZyIQDsPbhRFFrZ?=
 =?us-ascii?Q?7d2afb9UxKGOhjmPB9ie8LlPL9UOa6lm9arhpWRVkQXYoQhO8De6OQTncfXf?=
 =?us-ascii?Q?gOvYC9dVwvTgYKi++DSXn4g/hm/O6LnDPevyYasRJ1vlNmvxOsItaQuo1iGN?=
 =?us-ascii?Q?DlQV52zfkkeXYaNwxSIYZFc+KIKsnhtRJhxQWIKxaXjdHVY4gNIdmIjD1eYh?=
 =?us-ascii?Q?lM3l7lgupovAzWr9q6byJeTTlh5yjYYFJXRCPSPSkrCJVpRGk+ZGgSPxSL6c?=
 =?us-ascii?Q?P5TSc7OdEw9uuZnmHgZxKf/a5fMNv11nsEWJ5BM3Fvw3PpU2Fi35PocedMLa?=
 =?us-ascii?Q?uERXazTAg8f0so+Z+OFGTs66CJpNGN0Kg3nlG9hHWvZFICV3OiraYNX89fiq?=
 =?us-ascii?Q?LJ50lucM8Yri++21dBvCcmbKGB9V3VD1HzWugoVPwTOkj7AjvG+rN2IfmDrs?=
 =?us-ascii?Q?7VudJUAiHwx3FJE8zA8GM3AtZErsFG1CFGlfmqovp5+XvvMaMUS5Lp5y2ob5?=
 =?us-ascii?Q?87oPoDQVrgZOfhbXVKMUKqYHydz5B2gnlBDI7LBn3QNGDYsj1mvlyv342Im/?=
 =?us-ascii?Q?hs/U2nUNAhgDlqsXh7I7Y3GD8133aKaoBvP5RYLZ0qUfIdZENSQ40w73qDWC?=
 =?us-ascii?Q?nE1ptbVLIsafJ6z/sENFh5V+XGXr7Gael2NhrChWTtLADQTLzTokVb87r6yc?=
 =?us-ascii?Q?vGZ6IdfSdjg2JaByASqJB1RY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c69afc5d-35da-42a2-4121-08d93ad26c3f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 07:49:28.5892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djCf4ym0w9CGeKvEeym6JMU/VACqR7HLkFY9IoS9Cakxqo0JurxfRgLoy016mR+3hLWmoruQ2C57Ll72AeyQaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5088
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
Cc: Felix.Kuehling@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VM code should not be responsible for freeing pasid as pasid
gets allocated outside of VM code, before initializing a vm.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index f96598279593..5a9006aabec7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1287,6 +1287,14 @@ int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct kgd_dev *kgd,
 	if (avm->process_info)
 		return -EINVAL;
 
+	/* Free the original amdgpu allocated pasid,
+	 * will be replaced with kfd allocated pasid.
+	 */
+	if (avm->pasid) {
+		amdgpu_pasid_free(avm->pasid);
+		amdgpu_vm_set_pasid(adev, avm, 0);
+	}
+
 	/* Convert VM into a compute VM */
 	ret = amdgpu_vm_make_compute(adev, avm, pasid);
 	if (ret)
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
