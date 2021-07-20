Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD1CC636C8
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5070D61029
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5070D61029
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E29BF6E43A;
	Tue, 20 Jul 2021 15:44:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E94D86E439
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltfVP3JZM3KTeFIsnsZ7gOHXrRxMGRgCHgg5m+//E+zCtCMNArkwJVAKa5e+lmwYBrKXfxVCPfXFaLg7Io/cmh0wpQBfnvbhhMVD+mg6CN9Z/G2GAjxUQEPiv15KoJKAGIJ30fV2Q4rtxYLIGN4SY/CCd4zTzjGj6oFScNHKaMmMknQrj/rI2ue9fK1cNUWtlUUjaW+7V0IJ6WKVdB7PiTdHocm3kMR0nbTaXuRhWq1qKBBZCnKffdX/pqKXCOV9qOQfph3uOYSLjDiL6nBVpmuglHp2tJ5fssmxGyt1eMN2mygY/hYab8kP0gO3aqOPyR3Gz0CpyE+ch5GBeejVbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlnPZ5Dk8aWoAXHtkp5Gme2SsvNIG/g4iG2ihotg3m8=;
 b=C53N+7/VhmGm+wluWPlhW+3D/f6MkDPAwIFymsOkedb0kcbAZV8meUCYrUpqgPfR+1fmCkwSiFFRji4q6JMWGF8xKLwk9qAxXTwo9ewx3uppMx4vrIhqtUy6B36FOsAZ6hEjeD9jbjHEVuMG31+P/jNH7tbeY77/VvL9pesOy1qZjx+kXaUL91bbm4j1oRyqoyxK0iCOdAjkAWD3fNUltOVZkApNxs5MoTIYeLTIwhOsi8y0YjDusmjDhM/DbhlynipP26IS8XF+SYZM14YR6qoDndEK7Rr2O89pLGXP0MivFdd+uZeS59IEDUZSx+hOjaflNEZrt2BPUkPrM2E3eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlnPZ5Dk8aWoAXHtkp5Gme2SsvNIG/g4iG2ihotg3m8=;
 b=fZ3vkMFntpmA4cHINdvbOI9A6KRvbLRxvB9eVxBz4Ozg4vYD94wscR6a4Z3Z1pUcMc18hSkFiaZFuTC+jS3mgXSg5z5n/YJ1La7WLpYRPwbHH1QNXrKymHUmvVp7/Fx1Pync2T6Pf9sPLZoNGDqmw3yV9Rju8j9cl3RxeR9Alzc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5288.namprd12.prod.outlook.com (2603:10b6:208:314::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 15:44:18 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:18 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/29] drm/amdgpu: add nbio support for cyan_skillfish
Date: Tue, 20 Jul 2021 11:43:36 -0400
Message-Id: <20210720154349.1599827-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720154349.1599827-1-alexander.deucher@amd.com>
References: <20210720154349.1599827-1-alexander.deucher@amd.com>
X-ClientProxiedBy: MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37)
 To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d02ccb75-311d-4b5c-b8d6-08d94b953c1a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5288DA2ABEA69146EB23144EF7E29@BL1PR12MB5288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:175;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zf1A2qmCWA3zOAGRu3bWh05ZajIbqP8NDM8yyzTW1B91VWIQqdRRmtVptJwcBdXjZSF6pB5N2FPl9NXmz0/mRFDqxktXn3qy+CYOaUN+x9tTPHmnltPm3yUytttk9aJ9uTBQnpNyBd2xaSRp/lDLoPSLZ0awTGEHLHpVIRrflGpyvTorSuGWlG+WujuzCwJEe3M1PtYNMgT0yI0/POrPegPjPwNiIfBbtf3S8ttuASl9DQm2jZXXZ4uVwbLE4PnyN8LMXUiNVcF/KClqQ/mBaT0PmNRLYjWgJuIWYOH48kTRzX7+ljEdTpRiOszZASlznA8Lf0BrjiR1qzCdrAiOTQH+lBPGd3lOdBHpkt5TZnXBH1pCZ0HGqXUiyS836V8IT4jEbrDLh++LNTBKc3hepx5+88u6Q8cd4+LoaofsSeSXrTALTIGItfc2X+RsXVNXQG/agnrbwoX6jVRY+ICQ7KpBPtTfc+Okm3JLJ8nVUZvq/wK8VZ0lWNAAcbbw3Y7JVmdS6Bb50/JX6Bo+YZD26NFcExOkQMmUPcomPwzsfE4jxN30lNzbqR/DdBJ68CgRoznJ+HohHSBhAn+W3dhPYo0ENLpNOu460yL5R6XWMKKhHsooDUmbjG4cRhTub+17FxfVgvCK0LWLdBv43ryUhA2XoNs+RrWUu6mbGIkExC9FDm5LxNy7L3sBZywnkybCCh7VAoQAoCs/wlvKZk8CAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(6666004)(66946007)(66476007)(54906003)(1076003)(86362001)(4744005)(2906002)(6486002)(38350700002)(38100700002)(83380400001)(8936002)(316002)(478600001)(36756003)(66556008)(6916009)(26005)(186003)(5660300002)(8676002)(4326008)(956004)(52116002)(7696005)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OTPUjzTPDHiP8SsixH5eUQMRkWTMkbBDK7S+o0jBKWNsF82wTtn7avFSzkmg?=
 =?us-ascii?Q?SfRFoDCpL06RFHLeiIzoID2cLZYy+iFEQTN0tGNFZ07FG2vo6rw+pJBT3j8m?=
 =?us-ascii?Q?XCrP896vl+LTGbaOb6uTjCpUnC3wR7/lLVVCqcO4B9zUDbxTf3Y8Z3dX9V2V?=
 =?us-ascii?Q?sjeOFBr4WW1j+bZ/uhPk2ik5WCosDyZmm0Rdl7PFdjv51BBc5WbV+/asRdL/?=
 =?us-ascii?Q?GD6TCnZRje4l8MzgZn9GNRKb2PzAWbjAoy6EJHmQe/3QUxK4K7VREANdCO/D?=
 =?us-ascii?Q?hYGFdOnp4ETbyGuX+/JKC/JrCuKFR3bRx9AHyxrxVrJYM6+h4WzZwVBMOMlO?=
 =?us-ascii?Q?rwcit0CQkrJsfVHVFmtlxGUrQWRMRGGriwFX56xCMtDc5NOBegfwgYrO6NIw?=
 =?us-ascii?Q?gGaMwADUeRAOSuAesBwL+NPGlom2+xpzjLxX+lAGUZcq/L9YIFhhI6Hi6V/V?=
 =?us-ascii?Q?TjofZAalsUNxfd5bm7R70zsKmS0cqg2GODdj4BystckqY6EoqzrGtmE9+BjQ?=
 =?us-ascii?Q?CxfLa/5X1yUuCJpZh/QHz/1Nu4H8jPk4zs9M6yJyecbxEV8bTRiBh8vmHpVs?=
 =?us-ascii?Q?KOATNKoG1OE+KOkitLH6n2I0vFUt6tkfvFyREVOzKS2s7QOFBkDDGUfPQttm?=
 =?us-ascii?Q?ljPoaqA8tJurf1Lq7COa6wa6Z9O51mmrKIovU2RfjlG201rNzAC22c6eXXRz?=
 =?us-ascii?Q?p6b9I6MrxC+9JLq4KMTMMFwvr6kJ9S9UM1UDJkXUifcZAv8dnpeDjLY/2eVR?=
 =?us-ascii?Q?75zUDwTh2lqD+SCYwwhIKSM6x5p07Ju6vsHPNG0+liqI1aaz0vWwJx5qIjcK?=
 =?us-ascii?Q?ouY5Fo/scTR7UDrvTSlprh1xQauj8GP+ZD8r7Vr4XsvwnlOfu7a8SBw15u32?=
 =?us-ascii?Q?UR93UdSmmmvpqqcgPbhaYtcwiCSij7W4Kx6EoIpnLsa7V8BCkffHoPvBUXUC?=
 =?us-ascii?Q?0xdbtKKYLO0jPvddDosOig1AhTYDuJU09gDX2qL1v0UJ3K8MXEUOZnLwE+Vt?=
 =?us-ascii?Q?+i6HA/jV3FndJmYFQNljsU3tqpWCrrQgAYJWbLGmF6yzjTSvLsUCfP0j6pB6?=
 =?us-ascii?Q?7pMBcTZarXmS3Bb0Igik+fo4kZAdpr/d6uRBg6oRVmifGuTF+WFeEYbYBZGG?=
 =?us-ascii?Q?9+KpaNqPOP4nRoh6ueG4ANJ/6OU2VX1il+MM3O3HknC+VeiL5DjVPeL7Md8T?=
 =?us-ascii?Q?LU1S8JptejSHyf3t/U8fHTRG2ucxgAxDg2Fc1qqddo9AjQggIbGYa9w5tvum?=
 =?us-ascii?Q?XQjFziGgnmgOuLTPFSW+2FY8p1ni8+0bg0UvMdijEUkpZ/3cR1B53IqEUtXD?=
 =?us-ascii?Q?YoUxfseuxaG7fTxpyWmL+MDc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d02ccb75-311d-4b5c-b8d6-08d94b953c1a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:18.3087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQ6PAFR0B1Qrn7K2dnDTdvyV9q3MAkUfEYt4qnreLI3viKpS/6atxdZV3p4EwYF3nXj4Ks4B/orQN2fo5Y4qOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5288
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

nbio version is 2.3.

v2: Make it more explicit (Alex)

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 41eb97e7b47c..c79b8b5311ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -836,7 +836,10 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 {
 	int r;
 
-	if (adev->flags & AMD_IS_APU) {
+	if (adev->asic_type == CHIP_CYAN_SKILLFISH) {
+		adev->nbio.funcs = &nbio_v2_3_funcs;
+		adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg;
+	} else if (adev->flags & AMD_IS_APU) {
 		adev->nbio.funcs = &nbio_v7_2_funcs;
 		adev->nbio.hdp_flush_reg = &nbio_v7_2_hdp_flush_reg;
 	} else {
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
