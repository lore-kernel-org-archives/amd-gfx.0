Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36724C38A24
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 12:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA1BB20735
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 12:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0WG2wsuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1BB20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93C936E12D;
	Thu,  7 May 2020 12:38:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1C716E12D
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 12:38:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1tLhkhTIB6gAS+i6v0NkHpAtx2sbwFKoPO0Ov9u0l0qBHhn84PRdFCxkRGGaIsJHrVVqk+MELZPAViP+pZcENPT4NmJHNS0ua07wmbpjVNWSdewk63N6puHg+C0biOUypPZpc93zoMlwkyzPKYkzw+UWZIPQbnpowGC2pWI4AkKHcVcTvXVVCMTZ0O9+565tek9KQ1k7tEdjAKXWnqpHkg66k9I3biu43LQD2lRgG3SayAeUrTr3izD5TwJpz8BeXCXWZH2rMpr7Z2TPucXxsjP+1Sqhw/DQm6mDrBAk3h+ASyVyBKd9+7iPVuOAyy8CCogAVQNIcDvvVUpiUveuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsCmFJ/EB/LJJH+ykft+59GTTpyDl+8wjxBetfPsDyM=;
 b=bRP94wDeN8pwNYkIHRFYHSsuk/WV6XA+vThOs01X/SDvhD4neV4T8pK8oynI9Rt5NxahjqqTZ6Zm1BEYjfFkj87LpTFG5l6jYUI/qy7JWM4OT90UbfG1r+GHAEqBqRKMMbzAfcPgIoiwbk4kmv5mQpU5sJAaZj3VpFct/yFOGlWlRlgFilTM1tMacJGHVW3VNMPpRqReB/XK3f+zo0ZMS3fZrU5dgS31+mpmLoxjn7Ju2hc9sKdDgM5FgCDSgBp4dJ//EYJLV0ukgfEoI8u3zN4F8N2xAGcjxZYFykVA75m9UImZvH07NPtYdgipSdPsIOHciSzTk/l6mUlNym7ngg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsCmFJ/EB/LJJH+ykft+59GTTpyDl+8wjxBetfPsDyM=;
 b=0WG2wsuqfC3BH8kI64NGWgAEBMHpQJRDsI0kdmxPZdLq4mvrRrLp9tbeKtx6V5FXEEBmchGC7G2XqwSTMX1xO/+s9beqdlBdwul+kB1WR3UG+ZOlyGv84qnOuzzvVsPEf0MUGJ/oaNfh6En3rPl+DfPQivm86CEu0kxUFMJGwYs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1674.namprd12.prod.outlook.com (2603:10b6:4:11::15) by
 DM5PR12MB2408.namprd12.prod.outlook.com (2603:10b6:4:b9::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.28; Thu, 7 May 2020 12:38:18 +0000
Received: from DM5PR12MB1674.namprd12.prod.outlook.com
 ([fe80::c0af:ab9b:b8de:7c4d]) by DM5PR12MB1674.namprd12.prod.outlook.com
 ([fe80::c0af:ab9b:b8de:7c4d%4]) with mapi id 15.20.2958.030; Thu, 7 May 2020
 12:38:18 +0000
From: Tom St Denis <tom.stdenis@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: add raven1 part to the gfxoff quirk list
Date: Thu,  7 May 2020 08:38:04 -0400
Message-Id: <20200507123804.8376-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: BN6PR08CA0059.namprd08.prod.outlook.com
 (2603:10b6:404:b9::21) To DM5PR12MB1674.namprd12.prod.outlook.com
 (2603:10b6:4:11::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ws.amd.com (165.204.84.11) by
 BN6PR08CA0059.namprd08.prod.outlook.com (2603:10b6:404:b9::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 12:38:17 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1a2a354d-b996-4ba8-c788-08d7f28384be
X-MS-TrafficTypeDiagnostic: DM5PR12MB2408:|DM5PR12MB2408:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2408E8333F978445E9246472F7A50@DM5PR12MB2408.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mkkTCooH2DIAEkx/7wRgtk0WRPiUSK0mP2ojDg1rmBGfcSydy5GanF3dgNGA2UIlIlsAS01yAPtW1Wzj1b7SZxJ6lQIv6nQN+6bK/xTn6ScE//YWWtcQAJouIRBWQ/yjbkSRegD4Cjt4n1u7LgBas18h0ajGsBezs17SlCNwH27fveeYTmiLrt4TNs9HFd5Y/SsE243vscIrXwF8sjUuet6wudRf0MnXeA9bU1FjNPB0BZofOWGec+K6NBvzEVndSo9Gl+dYNfOwMFkvt5A4aaR4stBz3O31rc1RGBtv4Lo53SAo+ONMdehnH2MTFFb8cll2UqpBU/TismHXGtQ5ZsiNQYZItduShwZ1zKpszQs5VKrgt7NsfMlKKS3kwsPHvirkdO71slrLGcZ7LqlW1KodEGjrSCzkzNYhnb/OFRp61N30bmWmQnejp2X0gWdRZFztpyqkjSVwBkPGYmk7iUVprp8V/JdUUuAU6JSEtc4ejUbzpbzQdfGgiPrZl/gPnSU7jzXeakQhdiKYmSSKkdNy/BRgnQpUcKk6RSwmOV+cgVmaiapauSUKu4ZdQchzGAjiP/VLmzyjfKJHFCtbueRVtP19WqkWYyiyUU9v7X0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1674.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(33430700001)(186003)(16526019)(8936002)(7696005)(4326008)(6916009)(52116002)(86362001)(26005)(33440700001)(83300400001)(83280400001)(83320400001)(83290400001)(83310400001)(966005)(66556008)(66946007)(1076003)(6486002)(5660300002)(66476007)(4744005)(2616005)(956004)(8676002)(6666004)(2906002)(316002)(478600001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: wGR5CJCDxpzcK113aFbnoFtMfPvv4sP681X80w0t0qvReDh+Crv+tHMh2hcXx7MyWVYt3AVnASfIgHoeGjW+TJNaTY5IL3fKCRuxKVAvzvi0G8SGDuKE2/Sk9P3WOKuKT/HFitiA8Ecjq/crLRmjbQolaI+44y+IrLU8R0U50e+Z3hjQzjHlbxE735IIBPd5nhwgJCcxq504ehyRWmgn0Besxu79EVa/NgbfwyqVfGkuOttr/Mo7cHlpaxSfQ7WCdbWmeeYCkmlGwg+7WTw80PaSKgev4nD00JXHy9i4gr9XwP1rnIYSYnrueUg+tY8HE2ycdTzYP97ye5jlRz/oHP7XG/PiMpuhqGMca+jYCSlbn0xFELljsDq/ooR63/HiqFuFZyF87baP6FRgcSFTUioELhlAhicYxX7AluCLqZ/4QWtVTY+LjziA1kPgQhWkt2D5Qk+Ji90QpeUjzqmgKqVoaI6HBgLvNt5llWK21PeBKgLNr80ZLPIh2cS4MuZWtdLaXDSi5XniBem5BnGBenmfT/BsAkwCnFrVpGIzrvx9yrzgd6WfjsPacEdMrQHNlKyMzSulwgNkssJkeG0T9zZ684KRKuiDLanln96lGuzFNygBrSkHh3sFAkR+376mnyioFkUVUS06OM+uGvqtnugGGl9QrrFjlg8eEOmtn/G8KrCphwpgZhB3g9VwXxLyuIzr50ZcnZdZVTTmy7Paxp/Og0O9MboTGgpy5YTFGSXcL4UPL0TTTtdOteRcmDwt6Fynwc9kyGk/OTJPSBQrHAxvvspD/C4E5Cr2dAQWCTY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2a354d-b996-4ba8-c788-08d7f28384be
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 12:38:18.2815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rORqotVYcf6/w5g5ej+nV3vWp4EDcEz1ccBQ37B664feLq0aUo8Jpsl2Q70B5meLqFB0oamJZRXFD24bYBeQDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2408
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
Cc: Tom St Denis <tom.stdenis@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On my raven1 system (rev c6) with VBIOS 113-RAVEN-114 GFXOFF is
not stable (resulting in large block tiling noise in some applications).

Disabling GFXOFF via the quirk list fixes the problems for me.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index fbd54d347d91..1573ac1f03b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1233,6 +1233,8 @@ static const struct amdgpu_gfxoff_quirk amdgpu_gfxoff_quirk_list[] = {
 	{ 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc8 },
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=207171 */
 	{ 0x1002, 0x15dd, 0x103c, 0x83e7, 0xd3 },
+	/* GFXOFF is unstable on C6 parts with a VBIOS 113-RAVEN-114 */
+	{ 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc6 },
 	{ 0, 0, 0, 0, 0 },
 };
 
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
