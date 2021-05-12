Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AE7C43460
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85B2561419
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B2561419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFD336EC7A;
	Wed, 12 May 2021 17:32:07 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2077.outbound.protection.outlook.com [40.107.100.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 995476EC6F
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:32:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcPVkGtusV0b/hEms6AaXATiH3IsL3tROspRVMo/qhDqdlg6PwNwQC/xE7tyPNEuh/L/5s1nyMpNHxmpNBxiX3S06maE28YQoI9qvG4XSq7p/5XkKJFBUiNNJrHcJkq3TsdWFFWpkXnaYKPJFIyEpQSNqVD4NiFMZYK96qBuA4zkLwAegcLrBFZSp5VPglPhTBbIghCfERQW6MeDlcz+rpzSOpCY6H0isCPN9bJDSLnuBJDpt5pM/jkuC1PfL70uUg8FB/rEsnCXuxeowLtOQ6NFUQC4WVN5hs6tMmP8UTXmTZ3C5oJ+fi/CXSPNAe0JYXWjbHOGICrp1kpTofmTkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sORHcEvpVIgCBjsO30eqjq+n07bdtdJxvCt6L/3XSEE=;
 b=RsN5shbZgbdUqhFyn4k+9jff+O+OJaHOWEeuW9A7IS5rUicAgHc0HFlOsZDWqtkHCgUtxsXhcV484YNsxXoq7aIDFdTCutXjIFxWUiPJT7Og6ZLwAv/1Sly6v0Cxt6IdcNmNn+6QOwxlajXMNBEo2Nt9Nxa343NzlbiC4+PZKtL/Y1gjKjeSokITyVEEkWXVFxXQfrD0djldSEt8gNm/1/Ob8YFxh5+8bYP3PIRfAoHHaZmi4pR20O+vu0llXsMsy0RhuSe+80hkGHPt7/fAf4iFbe48j8WNXA2x8m52oxpPl44ZqYKOAalk9bqQn3SWSUqrFCjGFVzhCaSJOH9I0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sORHcEvpVIgCBjsO30eqjq+n07bdtdJxvCt6L/3XSEE=;
 b=MHWF7BbVsXPycerVpYbk9uuivj028xfBBe/A5hd6LLbu3tqTINsNVrOmsNdSz66Jll7MKiZ+psFstqt4iLKcWO0ObqNKnH57wmKhYSFuaZLLYoojT9nLL/yeQtPlTos67zosd9eP8ffUs0oHCTjY84Qo+KUGLM60Y8xoDmJdvWQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2564.namprd12.prod.outlook.com (2603:10b6:207:49::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 17:32:05 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:32:05 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 32/49] drm/amdgpu: enable mc CG and LS for beige_goby
Date: Wed, 12 May 2021 13:30:37 -0400
Message-Id: <20210512173053.2347842-33-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7cb1e80-b9eb-412e-f6e3-08d9156bc9e4
X-MS-TrafficTypeDiagnostic: BL0PR12MB2564:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB25644AC769E7CE44B6C36101F7529@BL0PR12MB2564.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EQPhbvw4uy4dXpfviAmJD/YLynl7FRrkDPKeGbWln05UJ+d5foP5hrOB/r0EvXhKiV633OHpgkgd14cx8Fjrl7d+jCiRwF6Ht04yR4A++9gvzhviWvTJigK4wRfdF8oC0rO4k/YWvUMcF+d/9/ZavPJJtrZDy2qHkT2sBwjuw7JvHipLCblyDq3a5LdpJ58sxoWrgxlL/SlQn8+Dc43tX8DQBkPvn/B7Q+/7kMfp+9Fk1XHzjIPSfbIDJmEz46NJwlinbFJz60/1at/5cGerJVMdbgdsozwc8pfE332h+/ADtwCNvBqnAEIEOeuYJNH/jAcQGj4tP/NLGWnqUW3DgRcjzfmN7dm69NGf7P5Tg5dTfM/eGgxKWVqzDGQBV/j4Cl+dfmh6xAaFczN21CigpFmYK/mCNuFlHou5nXWuJOGOa5bSJCEMdItF30pG+C5kMqd5ktMO7nIQkahcgbubEa4CFrZGufkAcm8rv6Qsl1LCMjvlYb3p2jkSBjbQA0WdzH07Vo/gMNfqoG9iBDCHrkVuzZgcm3nOJmh8zeqE1mUSdfFstv3frrm8G9AGgToGKGkNlWtO1RzNCaNcJxxn24hICfgAdR2CMY8t7Ai+LsDwvd6vzm5tQK50waeD9WJ74rxMnx6WsSCc4gGd2Plj6EPspk3ffXsA8QKPt411NGN3WrXaJS4danmb9MmPtikV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(5660300002)(2906002)(6486002)(1076003)(66556008)(54906003)(83380400001)(186003)(316002)(38350700002)(38100700002)(52116002)(66476007)(2616005)(66946007)(16526019)(6506007)(26005)(956004)(86362001)(8936002)(8676002)(478600001)(6512007)(36756003)(4326008)(4744005)(6916009)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?eQqqU1fb46Jlp+NdSRbduFy7wIHgEf6fKoAvjObFuOpycQR/nzWRXshrqRZR?=
 =?us-ascii?Q?4LLMO0m5Yao78s0ydejxzmSDNvtEhTV5kzi1EhhtLSf6V0xfjqCNIfFll1mu?=
 =?us-ascii?Q?5vDNIFCGZ4/DmQZF38quoTurhA7Q/7JD0uOJNXVDgOKNDBAkwFS4olccBc3M?=
 =?us-ascii?Q?3x4nteszKD1ERTXsWOieEEx6zQnoWELXgCA4ureEYqJYLrgVJTvx13EYSBDr?=
 =?us-ascii?Q?W8Fmgt/Xo3S9IFirXVWYkRsMvCn6Dztu2NjFAC6osRI6g5EXPWsHYtAgGiPD?=
 =?us-ascii?Q?mahc8XCMSnAYXb2wvkHdgSolinnV6QVUXKxTAKpIRZMjrxVEMSayYGpaUqIE?=
 =?us-ascii?Q?l5t39tLOOonShrt2K/h4VdLsVeeDQTbCmmgjsRzsgBW+tAoLbc+Lg3sKY7Ky?=
 =?us-ascii?Q?hkltDiP6WzzmAi1y5vblp7Swd0sNuQjnqYLdiO3GVLwsvNqRNKfD5TZCPYLT?=
 =?us-ascii?Q?Zod6nlmtp8Yvq2hIZnAJ0xmk669q0yfJh0d1l3Xalf5B74urYRPUv8NpbVTQ?=
 =?us-ascii?Q?KMC9ZN0CTl0UIeGaobESCAY6mTf5JKSeWzVOLbgWt/Ehxcup7l4Oh8mEDlCD?=
 =?us-ascii?Q?+5f+fnXLR2dXNYqIazIXgeoaWDvmRpd/MZYpXTrIDl0cJfYyp0ZMKe0fPRUi?=
 =?us-ascii?Q?Fi3ZiyiNAwgs6jnm6hl89fIW8X8tGMpEqAQf7GS0NETrnYt/oQNByCVKVqGi?=
 =?us-ascii?Q?IAY4iQBZjwVozVWgLrwVaPDuMbn/q/wkQrf/kzwHM668xhY7MkJEBIr2/End?=
 =?us-ascii?Q?99+8ZfuWorvRaqZ8wVd9wkt66SH3SVTXiJSybBk6CSG1NQdZzJ3pVJYs9aBt?=
 =?us-ascii?Q?DRgCzMd0T+eW1s8Jc/2WY6RRwSy5BIq7X3babo6pXO6oxA2QiAPMHySZ16CK?=
 =?us-ascii?Q?fgU88rcFTXlUlrvtwZ3K9ImE/RmGkHLRt3HFGk+fweX9HYDN07aSpXbUMBRf?=
 =?us-ascii?Q?jZtzd322Isj2v6p1Z+BjeJcVBDdcs2mtgH9BMKV+WsQJ05I6+lxCUsWnv9al?=
 =?us-ascii?Q?a9SmYmKlmBfbEuy4KoThjrYWxoB0KUaJY3U9AAd/Lj7tTWrprTs6yhjloLrO?=
 =?us-ascii?Q?OEko8zaKUy52BpK44mYS8hte5B3VC3UmUDsp2PBgnG+q77wJ4VCwwboCqscA?=
 =?us-ascii?Q?NJ9eJEaQSU+vu+/KP0euxGnfN+tYDM8/T1hYWOPuh6ocNl/0TlFoF+MhwIyh?=
 =?us-ascii?Q?CSW2FHoMGUEB645fKVYjABvnynMYqD/tYfyoMYN8qD1Li7jngrGtoRysa56V?=
 =?us-ascii?Q?/xNVRJ3Paq0qwVVo2JPm17wkwuvADsToWxT+pCq9HYc7zvJ65VR/uJTmBhza?=
 =?us-ascii?Q?/Ne5JBzXMj/nGiPXHVOXDgsL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cb1e80-b9eb-412e-f6e3-08d9156bc9e4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:34.5024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78cew9Kkl/HxOvynXBIt0l0DEdZsDgfhZa0t83GZbJJ2lulgAxcLMrlARnBrHMNoRjKqPQAor5I5uBD+63OE6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2564
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Enable mc CG and LS for beige_goby.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 1fb8691e08d4..bb516eea8101 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1174,7 +1174,9 @@ static int nv_common_early_init(void *handle)
 	case CHIP_BEIGE_GOBY:
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
 			AMD_CG_SUPPORT_GFX_CGCG |
-			AMD_CG_SUPPORT_GFX_3D_CGCG;
+			AMD_CG_SUPPORT_GFX_3D_CGCG |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_ATHUB |
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
