Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20A3C433E6
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:33:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B117B64EFC
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B117B64EFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E08BB6E888;
	Thu, 18 Mar 2021 04:33:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1A276E882
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 04:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lq3N5RAE6JowvkB0WsY7f3A/6XM1oqzDHlwpHvBJvBhUsm03BwoMB7E7tOvg7R9oJhfwO4KJKUp2jDn8/0SNfthdSH/eOEPn1Ut7It91jhIOp85BzU1h+3AArkCn31i0u5B+aBWq4KbLrFnwD5esp/y9HbKpvSl/w0GbWtWlUKK1yk+tU1ZlNx4kmxss4l0cYdJHB/g6Eb3HbktYprLE2hfYGnRUD15NORHnnKLE0waUlWgAyRJKJR68U7WPn6vxyii4z2DVhaqEfju5KeVrLJ+kv3dQeDMJ2aP7rIQ2LOi6ysxHKpHL9dty7sQCbU+/vB8m2dvuEUegrMaNQ5Zwag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97CRxezhJULD5Lw04eZH00ALln3/C1xyLkt2mRRApew=;
 b=QArTSQSG1TiT7xJ7C62WDwiezDNodRjWwEyBup3tT+gJrWFtgFW3np3udW/HNAKnnH/IqbIrQE24+6bsg9207oHNcIVvzprCzibB7PvSyuX8BhCBtk+Bif6uqRbFndL4Tcahg3O80zo/vDg74KOQvC2IGiQYGrv+5eLFPibP42UC5kbz9afDo++a6jKQlRLI1X1Sow6rjV80B1RzXBKWn7CWrVAiNsaMYFAFQKvq8wBpR3SXFkir4460Bnz35pGAuR2+1zh6MNxghoe03/NjU4LHI7NcXNHLXZbt9UzvGMlxAVz8180KKr5/Vt8988II4AKTpO6/ADje1SiFKtZw7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97CRxezhJULD5Lw04eZH00ALln3/C1xyLkt2mRRApew=;
 b=olBfoNwMeyVz+K4jqWjpdSE5mNOUCrM0aVYU9wZN7tWqV+7aaZLmnyIz9cNjH+THYM+lVMh5UAvC+JzL1WpEmmJB3z0IAMxTOHjRZK9BiXkGuLBbMH+FoxjwiCbw3ODKJ/TRTUXBofK8rOFBxkjJ/ulDbzjhew5uLEUD+KrY8y0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4016.namprd12.prod.outlook.com (2603:10b6:208:16b::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 04:33:47 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.033; Thu, 18 Mar 2021
 04:33:47 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/13] drm/amdgpu: update comments about s0ix suspend/resume
Date: Thu, 18 Mar 2021 00:33:20 -0400
Message-Id: <20210318043323.3989-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210318043323.3989-1-alexander.deucher@amd.com>
References: <20210318043323.3989-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: MN2PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:208:23a::29) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 MN2PR03CA0024.namprd03.prod.outlook.com (2603:10b6:208:23a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Thu, 18 Mar 2021 04:33:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da6579b8-7bd2-49f5-6053-08d8e9c70579
X-MS-TrafficTypeDiagnostic: MN2PR12MB4016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB401614BAA0F8BD65D033FF21F7699@MN2PR12MB4016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/E9bxPcEC6LD2WRvnVHRoBYSj9LSXvbP5tHUYO0fAv3eq6u1aF0sbxzye+M/dC8s71EsfCK2nzZYckncqfBv63Lr5TfJ3Rfh2Fa+C4F9y2f0qodpceUXG79kHK+E2CWNERLi21O8JNCUvWVZBKVm+GCEyTB7hQ3oHrdN0o/be4jiEQ1NEQsgPNWMObW6xwBFOJ5/eYO6qrms6qY6qau/Dz0SYhJIV9sv/KaIbdNfmPZKOvYCPtcypR6E8CRpMFJj9gXcvPooKHuQ0396zLocsV6VmigA8FLNBs340mjROh33Tbs1tjkUu5MBxuF6YpcSVqm+tbACDnUmXY3CaQ1vsVWPuBWb3zHTO61EKHtxYzhJYLDYb1aGoK5+MFzM5Fpzn6z8B4AwWjBdl1+7xO1cDX/jdrwK1ig7oumVLzwRIEHN7WBYdffTaDBQ9xfliefTF6q4wFoUIndhxfeHYjjH/21UV4zrkTNPpYHZyZPcbqa6HatpWh7dOeJIc4lA5PKxBLJfYqUEY4jF7A+9LcwGnHvVy+lRJgeZfV17j6Na4BTU1vP1Qm6eExy3Pz7ZjYe1o0rq35jjiyIsMui25624dwyBf/u7pu21AfdD2KlX8F93ta7hmafaVSVzkJ7YXI/LDHo+Xuknen3Zb9rm95CCYgGAKfNZI3R1ZNX5gwRaYnrIAz4Ut1+VVKwE0/zh0vE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(316002)(5660300002)(52116002)(1076003)(83380400001)(8676002)(66946007)(478600001)(38100700001)(86362001)(8936002)(16526019)(69590400012)(4326008)(6506007)(6666004)(15650500001)(186003)(36756003)(66556008)(66476007)(2906002)(6486002)(956004)(26005)(2616005)(6916009)(6512007)(21314003)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?JTJ1xbr+nLEYROdHuiWWIH42t+l+yNn3mFP+AhAZJlhErl3/e0UDCjYmAaqH?=
 =?us-ascii?Q?KHSPY/2s1mrcqFnVpyJRQ7hGlwJbmS8qgQEyxWCe5uRcBkQNcuAJ3Hcde0KA?=
 =?us-ascii?Q?uXxijNzHUaP32QkZgDaZPzJrxI9NoSbhIr0lHk7ct9+eLCXJxw9dy6OgqSS8?=
 =?us-ascii?Q?oHX3ilcHvLXNFCG3zuFtsgQtlMGwGnyWeJ9/YRD+bPe7eCp45aq59n+fHTNi?=
 =?us-ascii?Q?Dv4LFHEBHB3duN6d5orfFrCBHaMrvmMh83Eu/qDxinL8buuu2Ud/9DwyLtrV?=
 =?us-ascii?Q?A0M7gw2K7EIuWbyCoDRCjG/znPRBCjrxbASEHZWBGcvOjFpVq+tqaiSN9/RK?=
 =?us-ascii?Q?Lob5nrs+YPeD3AJ8OUdFug9O641BLTNE0+T8Rj4mvYD1/Srq8s+p0kenW3JX?=
 =?us-ascii?Q?i4BgEhd/YLggUNr/VP3vjtVKQqD6/bc0LAfmK1D/gw+z6Ly1JrH6r01Huf94?=
 =?us-ascii?Q?pSdlCWjpoyOxCQ+rS1kE9s4vbr0Ctrx94dqrO53iDqgdzzgLHld9v+2R9YAL?=
 =?us-ascii?Q?1GHJtoVHXB3o78fN6/r0LnrYpM2KL4tWPSDek6iedWX5lQ0A43REIXC1zu7O?=
 =?us-ascii?Q?x/tVPOCTZXhpnJ9r1zy13l01SrbyM1s89xbzX4pzymk+H/bO13N21BxNPx/z?=
 =?us-ascii?Q?Vzn44z2KbOBdcbGt6XHZdcP0eWKioJ2vj3NFcJDibMGvujyo9Zbi/syNgNfh?=
 =?us-ascii?Q?FO3jFZ+6ewSdUqzBkZku6t9aYfGxTLEhT09st8De9rxsFNEB7ay9+zlbbqvm?=
 =?us-ascii?Q?4aCnweXuytLqagw0H8kaNgEFZbLksLK6HA1OQPzRL8FF8Mn2hOuynAGSCCB2?=
 =?us-ascii?Q?Rui/vw/zbrOWrH1fJtOde/e+8K+Sk20jBu/b0vEfctEIS35AYgxQVlA9KRJi?=
 =?us-ascii?Q?nizVoBv7MnLkqTBP7zWwqO9NmucPFGJ/ehmdnL1/rtn0l9arPYyB/IZN5kCy?=
 =?us-ascii?Q?F6k9lpjKG72wOp7IjIg6XxPk5q+cjPkrk+pRETgqVQZOEZ9XQf3PcRifmsjJ?=
 =?us-ascii?Q?4SSr+3IgtgDaOHv8XmvwJATBrlqKNYhGjg0lQMQ2h0ebzSQQmDhn9COogvUS?=
 =?us-ascii?Q?Ls9+qHO+23mdRBFUojW7kxUrmRy/usYa5II4UkXU57Ny73d88OAPD+q86EHO?=
 =?us-ascii?Q?h7QCBikOchY3mQc7zYH1tpc4GpB/m0SiQZ3W9OQ3onoc7Q+X97LJwVngil06?=
 =?us-ascii?Q?d9hY1XReDrYQridH4b3awI7swZnmF/HeQjBBq5GGfPvx/cyGU5hsAu2bb8vE?=
 =?us-ascii?Q?7TYTgQnab8/fj2gjQnsMZ5vBKe21ncK8aK7P0uDpJEnnomgdV2XVV8XJ54l8?=
 =?us-ascii?Q?Bh7C+SSwqev7yvhF/8nMW2/d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da6579b8-7bd2-49f5-6053-08d8e9c70579
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 04:33:47.5297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yE316iIqNrOwMzEw+O8Fvv1I5NeOT4Ab65FZcn3LZ+LI3n5g/BGfohnIble1vfETpP7D5UIe84kEWehVnXzzSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4016
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Provide and explanation as to why we skip GFX and PSP for
S0ix.  GFX goes into gfxoff, same as runtime, so no need
to tear down and re-init.  PSP is part of the always on
state, so no need to touch it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a84d93ced407..a6f4b52ec796 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2725,10 +2725,14 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 			continue;
 		}
 
-		/* XXX fix these remaining cases */
+		/* skip suspend of gfx and psp for S0ix
+		 * gfx is in gfxoff state, so on resume it will exit gfxoff just
+		 * like at runtime. PSP is also part of the always on hardware
+		 * so no need to suspend it.
+		 */
 		if (adev->in_s0ix &&
-		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP || /* breaks resume */
-		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX))  /* breaks suspend */
+		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP ||
+		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX))
 			continue;
 
 		/* XXX handle errors */
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
