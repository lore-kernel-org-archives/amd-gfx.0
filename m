Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7273C47093
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD24A61C46
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD24A61C46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A5026EDAE;
	Wed,  2 Jun 2021 16:50:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76EF56EDA8
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zidyle9Gh5w8+e8wtILnCIdKAPcnEv6bp5J88lLQD1Cozmrtwvcu1ibOWugR4N75ql2G9YvmFYqX2g8BiT+U5+qW6PWuHOAFpWCc6LitqWibIy/RXs4AKPSmdmLjuHk1KZA3bQsjU2b2KKhLXyYQ4qa0c86kn5s68Y/CLOj+yrZiUem8cEl62mpsNMm3QSKOjvSP73g254QYIyHQAOYL6MWBZzLl5M7IUw1GZF8BVtduMZa+MeuFn1t94WQvLs9n3OAuWXtZQk+amKP1uQjOll2OUktAacXEOhV/iihIYDHRcSD+7oybtXg6ErAb2GyHtPY0Dm4pzcOeSAaPkdZ9nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccycEFyBY2iaJwS7vk59hcyM0K6i8J4WghTT/6bw8IM=;
 b=eKaJa0TGDzq3sEEKPb9yLtmqIINxLjMfwjzLyP628UI3ISxVFCLNCYxkRAdraxsMLI5k7suAwbyOa2YQW7dqOhLGsqI+knii5EhC77t6c8MGnY0jM+YNJUaDB4aGeYREUpYdAjLGBu/B5e3n6+44SBnlY21MLvf+IuqejGqJkJkvy1Hei5M/93bsHWDLUqEYs5diKj41rnfyTZkXLlvZVZ2S2iG2EAjUzKNvL6YbvVUy8gr5GMwjBKO+Ze2biniAPOzFHsCkCcmhAIOTbMIokhCt4LQnw0G4/hVB+ygtcx42hz7p8BG3MRpcP4z7yc7ZWmFM6sy+EnFkYchXOAJMrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccycEFyBY2iaJwS7vk59hcyM0K6i8J4WghTT/6bw8IM=;
 b=w5bd6IpU2KmKKtPEVeLgnNHaMHmLi5PNsE9q3js2nPeLJzrDYnpbB5s+pBoEFdVwKm/zg+7feJ+HufHFIgW4lccXSj+1hVibbB2XkdfVPAgb1hR6S2S5855iFN5uyKXsLIMZcEqYNFIvTzc6WWw3VmZ0VYBnVVflwJSn16DnxDw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:50:32 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:32 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 44/89] drm/amdgpu: enable vcn dpg mode on yellow carp
Date: Wed,  2 Jun 2021 12:48:23 -0400
Message-Id: <20210602164908.2848791-44-alexander.deucher@amd.com>
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
 Transport; Wed, 2 Jun 2021 16:49:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71e5c622-b5fd-4537-4401-08d925e6753f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB453471F41DDAAB5060636D17F73D9@MN2PR12MB4534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UpFB8BBiS+2adHbZL4KgY6E4NL7PCv2UtQhjn+XzSaHlFJmRw3rzKHqEHnAVH2ZBCaTzyyBdVGWhR+XMdP1IVAd9q1Hgudb/U/N208qwktD2gLhJuX8AmH+1u+9+aoNcio6iJM7svq4refXnBDTeB1h+/VjbbKtdfwsF6EgWNyVusKVu8Mq7BAGpSkGjDb6nHZRky3QHjBNOV0RC6idDjGYhY9uPqpi/lYBdLiAVDNTvZlYRvTbn7/n3U/WUSDqErWXBx/zM2/QTG3U953Zghu+EAfPbJUQXT77+MtrRWJWoLKXRaBftIN5fXRgSfa3qQdtRj1n1LHsW0V0BOPDiTDtMbzIwTbBpROwu1p5hEFteQ0OB17SMTmEU2utZfBtRclGH0JEco3DJDHUkzt0uoiwPjTOa13pQhXId2FrJsJlaI2Yi3jKaCZIWzy9YugD3PX99WghrVqStNymxmrfkBW30FzT9AER9MhylmWyZdM+TQoMV6X+1TeZrMTNQSOhDU4WCaS4W0eFXoTCub/orCU+Ze5l2BMaxt60kijygasEmxmrzm6l/jMBwhEFNhws5u4BYrHly+ZWnZlaPUEgBfZcRqFNID6jmmWMbCIiqgQpkOhYAAsmWNH2h9hwrWBNll94tklFCca+bPfmtDMG6zqJ3sm+itqseVQs5eibY+g6a3nulpNa4S6qWLDBmYGSr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(4744005)(1076003)(8676002)(2906002)(8936002)(4326008)(2616005)(956004)(38350700002)(478600001)(38100700002)(83380400001)(66946007)(66476007)(66556008)(36756003)(54906003)(6486002)(52116002)(6916009)(316002)(6512007)(6506007)(16526019)(26005)(6666004)(5660300002)(186003)(86362001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KqUzJqH1OEavnYqEW9FvWWuL3KpkFIDJToytU7qnhBqKDjLF9t1KB94ZYNAh?=
 =?us-ascii?Q?Fkf2zBmywFj13+YFFWqWWgKdufac7U5eHoVe+wLK/32RF+xGIsz7IIpwjhT/?=
 =?us-ascii?Q?QiyRlmpSompOF+kD74TQmQYLxDiFCY8WbToXD0bOTJ0EZJWQ/wtd5aEI70vW?=
 =?us-ascii?Q?eFu3pXTuVTOssgPz4EiPzR8etuY9R/PbeK2IXDBZq2m9Iq50UGz3pg/GYNKV?=
 =?us-ascii?Q?0mNW8AFKPW11tgJ0k2F/7+6tZTUJuPQSBZW/UhwPeqRrim668gjdhTapgInl?=
 =?us-ascii?Q?ov2qHe4KrUtzavOVkMa0KX0Xc0TR4i4ge8xWV601wwM7aObBGxVw/vf0CPWu?=
 =?us-ascii?Q?q1qVTNn7unfYHiNYwiMDixhcXGKhcgtjO4Jl3WHLBGmgRAHL6sVCp42acQSI?=
 =?us-ascii?Q?+6hOFsY2yF/0Q/VFCWkI93opzHs2MmoB1Uxdt9xuwTmR4Dlkanh4Nz2+TTht?=
 =?us-ascii?Q?42TUxj424awbV81lH52154rdmp+entVHKCRIlvWMMeWSF6ZqOGh0VPuMg0Hb?=
 =?us-ascii?Q?B7BvqQAnJ3C8tiNnK/5qp+MsW7xDaiz8AvR7neoIgZ4eeoiXhgt2MSYS6THu?=
 =?us-ascii?Q?+CZ5bM1C2eKS9aurve86FMRRH2Z6R4ckz/NJEzkeFj5wzFPJwuocUnjRdgVa?=
 =?us-ascii?Q?PBHs6Xc3KuD0kRCZroXGQYHdy0ELcDU8+mvGEeW4EnbmGIprWuNtIcARpZ9U?=
 =?us-ascii?Q?R3l3r3UkGOFkKx3k5/wIOgqllD8baIqPyWOP49Jfh55V16fPAFXFyejDquD+?=
 =?us-ascii?Q?qt+ycukNMX17PqKFiFBQXX2SV2WezUa535UOl7Da4ql5pg1UCBZO+wSqVgxU?=
 =?us-ascii?Q?lUKZ1mhy+uzzC/j2A5v/eX1L66ndJiT/A8rtKrlFz8twTpvTR6E8SXCMxweg?=
 =?us-ascii?Q?7PGm8EvvP5xV9J3Mrx0EHLik7bCNlrhPMqvFs/EiQ1rk6FO00YZWO/5ISc/Y?=
 =?us-ascii?Q?ofx4xp3GU0jI0sYBS7lZYVivzcHU5zPgC3nU9rCqBU/L7/wEki44CkefsxK8?=
 =?us-ascii?Q?met6mb5i0WNc6Y0dGccxkb1WkzxOoDfVFFSszIw/efmxgy/Tj6cUHFnkUBOm?=
 =?us-ascii?Q?a9s0QGwadwR26hQZ960RttuCE0xYjlqJ2rmgOELAGJijUGaIkQ7x4HjxYrah?=
 =?us-ascii?Q?P8EMZyfAaYh0i3F0gz+3qhEudngmdMaRENUCJDnKu0DA0Wt3R/o94NtWQ0lU?=
 =?us-ascii?Q?+l5wXceVw9rIPMFKCKL0mff55E9MWNZMavWGhMCA6rodmqB3MtjAeh1MkTXF?=
 =?us-ascii?Q?+DH8nnxFvU0AWtFEVadRe6M5vDE9Ju1e3TmyUiHx2vGlbZlUc9s8nSFOKE3I?=
 =?us-ascii?Q?slOAtge9HOb4aGNg+qbduaNF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e5c622-b5fd-4537-4401-08d925e6753f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:59.1522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +w6YiKgTyLsO2H08n2uABSJJ7LNNvDl/2Vhizn8BRGkcO8roJ23kUJQeGlaYE80/0oC6kasroF3cd12hqQNZug==
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
 James Zhu <James.Zhu@amd.com>, Leo Liu <leo.liu@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Enable vcn dpg mode on yellow carp.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 90e50f90e346..4c49708aa9f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1345,7 +1345,8 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_ATHUB_MGCG |
 			AMD_CG_SUPPORT_ATHUB_LS |
 			AMD_CG_SUPPORT_IH_CG;
-		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG;
+		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG |
+			AMD_PG_SUPPORT_VCN_DPG;
 		adev->external_rev_id = adev->rev_id + 0x01;
 		break;
 	default:
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
