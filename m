Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59A3C43460
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 13:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A54961075
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 13:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A54961075
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D13F26E454;
	Wed,  5 May 2021 13:06:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20CF36E454
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 13:06:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQqE9H4BLe/el5H0PJVYCY7lfL2GFphWj1KefzlAxBlyB7eJIDYO/PuLdP2xphPH7zCTc7zpdml2zVHj9jqEwf3kbG5XLE3fBVufCAfMKZA0rMzHXp9goNooaPLMrQlvRaEN4EADdYwqanb9k8Vj8ia2aKO/LghOe9ptDpvr4TV7MJ13grk0D3309jVm0ALIWBKon1gdqal3F1mYDG5MF217D/UQ9TZ0IqBPsx3V57hO3TZJEW7djoz3D3nnbMWsP+mXHEfkrjN7ZUuI66MnhdyvnJ27PcZM6TuzLTCL92EaPuBEAu7vK+UmON9PZEzeWbjGoISZllVTfYv1ldw+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baKiNYDEsJvR0VEamycCgqkyiNmW9od/v/dn7wMkI/4=;
 b=lON4KN24MedLpzxexK6Giuno42RgiSzJX8TzDc27cg4BSzAURPjUht1z4apMWAMsUMWK+ZDJ9GKqwZ1B6dbf9roJDo1wpygXk4DDdW2YEslTzpZMrUO7kghNg5X2+R2YuQGigDGltPGE2jVRGUVG7uv4LtS087Ag7CZP1jZ/6XBodDLtCasBIhrG4rIJvif+rtF9jlGryxsYwuaae34IQx4LSxSg6+1azO4p+ridsvf5JuIq4xYvmhJN2yyrAOBYSai1EG5jtDbXofR50++E6yUaGckGXCWlsFT2X7hKluXrWJYsmtTA1F9rjUzS6o5ee/jp5CNyHre1cSu6bOu6Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baKiNYDEsJvR0VEamycCgqkyiNmW9od/v/dn7wMkI/4=;
 b=TY3NCthCfmeq9eBU2P4jCx1M982p8fhlCrHenSLCtAUtCC36+vX0QPcnJqVGJfD8z3UU1f1nyVrzRledyOLOp+ZVALv+P2kLeb79Wk+Q5SUWsgJYNRkaj08wl3WDZzX9bGUfaqxOq7j+feML8z5X/q6qtjTNsXJ/9fkD7T1b32M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3839.namprd12.prod.outlook.com (2603:10b6:208:168::22)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 5 May
 2021 13:06:11 +0000
Received: from MN2PR12MB3839.namprd12.prod.outlook.com
 ([fe80::c14f:8ae9:c5fd:212c]) by MN2PR12MB3839.namprd12.prod.outlook.com
 ([fe80::c14f:8ae9:c5fd:212c%5]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 13:06:11 +0000
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: set vcn mgcg flag for picasso
Date: Tue,  4 May 2021 14:57:26 +0530
Message-Id: <20210504092726.15498-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.157.251]
X-ClientProxiedBy: MAXPR0101CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::22) To MN2PR12MB3839.namprd12.prod.outlook.com
 (2603:10b6:208:168::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arun-Mandolin-PCO.amd.com (165.204.157.251) by
 MAXPR0101CA0060.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Wed, 5 May 2021 13:06:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2ddc63a-ad56-4795-df0f-08d90fc68e0d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4253D851CFECB19BAF0A22CC9D599@MN2PR12MB4253.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /veOeZ7hxO4lXDUH3CMrTzUwq4rjYKZAo/YjXBbwyH3/urMk4BzqPi0SAfTkiRhuQ+nRNwELzF8khHWAGzUvxJ9Z4zbkBlxv5WJ+O6CayGCxyOwwtjVsSCRJWc0h3FhD0z4QbN0dsu423ol1t7KT8IoVEVUlvrBzJQuJW6r++9kFzZc2w/kLLtkfKiSYvcpHfRXWQHAzidrxcyp6RUshkh39xTxs5fYgpLztOn5aoz/mVDuDgp6yD0UlTTUldBpGWAsJ7hvGkzoOMpkTIO5jFVD/4sKFCgcsAudggABxixCksqisQyPtchDu+5z9YFL6UAWs86zav3c/qcvALSw6X+TaUpygt9sKLaR0ASwX8CkUeoXY38d5U0zFROSsDTYLzQ8oN67GgVgtfwfduIh82WVwykPeeK1zZ+6lK97oRFWLpUFCg9RbyotF8HIDNyCbXtIuo/r+qpoMRgCULENn/SJvq21hjkorDgsnKqWiqgfAni8wb+XgqXVEffyNjbVn1fiZRBXeOWinWEkdnlG2gmNJwOzmzuAq/xitRQZJ6qPXF4nYdnHHmw4jqXdX8vp8KkL9okyeALMz9RigDNG7yXozVYZ8Q/eY4xNnG0w5xikqMlT2fHKgmUWy5LUh3Bwe322JvEeM/MVY2UgsVhTx38AWvptpi2kUZnM6m1UjHU0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3839.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(6916009)(16526019)(186003)(83380400001)(54906003)(6666004)(38100700002)(38350700002)(7696005)(2906002)(956004)(26005)(66476007)(86362001)(6486002)(4744005)(2616005)(478600001)(8676002)(316002)(36756003)(8936002)(4326008)(5660300002)(66946007)(1076003)(66556008)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CufmZrkm2rdwtuZylLAwfAAWsDWRhbvWuXkvVTa+JWdCe1ca3/eVDkmB9m38?=
 =?us-ascii?Q?RqQfKwKOXWj+h05oOD21E8o4iUM2E9T+bS/z4bgMZEENDzddeFgYW7x84spL?=
 =?us-ascii?Q?bfJa/pnO++/bDyjrBxP5GxwNgF6aH30wmyWYI69XjnSxdz00fLJG/6xicj4P?=
 =?us-ascii?Q?HjCsCxZCFn1cWYErTXyHYAtqU1YdIkn/hjS0KexwPuy8P9F81Y1+vwo+cVof?=
 =?us-ascii?Q?taxmRPWojiWFwETc3nW+EMqNSqU58zpavixBzfo1mP91l6NwJtuVmHDhQUfx?=
 =?us-ascii?Q?pRV5LNBPuyurFeP3ly/YWBX004ULPxHaLDGBY/oFw0aJmdbjudCdCOlF38hw?=
 =?us-ascii?Q?ZM7fE0/TJkoEgGJFVmbH6/nwO4g/tfqqa5yhBAfBpXeLrvRO5FXf5MJHHzM5?=
 =?us-ascii?Q?9l32Z75iQepCzxUckTrVWtwVY8NfB14fyuclXm8pOg/SDSgPme5k9ZDLzUv1?=
 =?us-ascii?Q?7GHFCkZd2PPJrvstUPeC+dOLAo4k3cNtOnhlzWX+qJZ4L06X+wKK6XYfJQUe?=
 =?us-ascii?Q?sdxvvqLeRI2WKgojs5VPfGOqTGIEQKZFWoJ87oWRiamUvuL3aXnoVeapF8qg?=
 =?us-ascii?Q?T+ExCSeww4WQxmfrtoqR/h1kBHQDDoKpFuOcjjR02htaUkIWD4HjNHQwTXS3?=
 =?us-ascii?Q?s06B59b3k40GPjk9AUmJ7PcYOLOjZfFW5dJ0fYqPUwnQagvXGWWhT18EoZwP?=
 =?us-ascii?Q?gjQh++i50r0k1EkSnNNVn++64kKVORX+VzY2TKVCjV3ZH8Oc5asJ9t3L+way?=
 =?us-ascii?Q?ehEVz5dMByIqDp5MuOhoJ2T2YbpDzPwheSDssmtAcfRwspiCbhXnBxf5nHsY?=
 =?us-ascii?Q?grG18bndAnTYclxJFbRvUFxmWK3OAEaRA34cTm26BuOtVBVACXJnUlPHIjp7?=
 =?us-ascii?Q?+8ypMEA1yYUT2jnbsyYJemdCMNjBjHhiRiLvfU3WnxynJAvstWBNyWiw2CwE?=
 =?us-ascii?Q?4TPLiOekt3h02F13kZRzxr7vjkUkBQrKYzv9kvZNHdTYv6M7sADQR5QusAHF?=
 =?us-ascii?Q?Oo5pvbGdOUyMbNUVYeb/GOByLkaDq7mYcnZm4d5kKLVuhTJ9dgNOm58vOwfN?=
 =?us-ascii?Q?ktEhtDmnbc4/ewJaI3g4OJL1fSThR2rTAHLNMsH4azeSyLV1h9iA0jYE6fAJ?=
 =?us-ascii?Q?499a/x/N4qPqAkHCaQ7EhAsn8/UfC6YGGKKvD9nN0rZputJOvF9pPD3I/+b3?=
 =?us-ascii?Q?3EPMgCAx0mDXJczcT/VVe6nOLR6n2gExs4dVExL1noi1awIFYbq7ESFWgIDu?=
 =?us-ascii?Q?rhp47lecXqFD9pPKHelN5AhsavukjlLXyBsE69D+ELH+OeNtEgMsqtsLptQs?=
 =?us-ascii?Q?NO1ohjsIavOsHDIum0teawDB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ddc63a-ad56-4795-df0f-08d90fc68e0d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3839.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 13:06:11.4248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwsD16k+V8CBsyWL7EPrq1Ssh76AjiSzMcQ70Z9OcwJNqtmFWZcE7jlDIx9OE8ShCU7zRHxitPbJPPS4BRdCDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>, Leo Liu <Leo.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sathishkumar S <sathishkumar.sundararaju@amd.com>

enable vcn mgcg flag for picasso.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 28e9f6b726a6..e3f42ad1e6bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1401,7 +1401,8 @@ static int soc15_common_early_init(void *handle)
 				AMD_CG_SUPPORT_MC_MGCG |
 				AMD_CG_SUPPORT_MC_LS |
 				AMD_CG_SUPPORT_SDMA_MGCG |
-				AMD_CG_SUPPORT_SDMA_LS;
+				AMD_CG_SUPPORT_SDMA_LS |
+				AMD_CG_SUPPORT_VCN_MGCG;
 
 			adev->pg_flags = AMD_PG_SUPPORT_SDMA |
 				AMD_PG_SUPPORT_MMHUB |
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
