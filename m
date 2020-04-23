Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720ACC55191
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 09:02:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4307D21582
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 09:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Fe+IoGpj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4307D21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECE136E425;
	Thu, 23 Apr 2020 09:02:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF5A66E425
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 09:02:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Osi0Zq26u+ITP65OqHhxEENnZflFWzsNSOPHnK1v1h6UanhBY2gmxn1bvqoTSN7T6SgRm0lmioQFn/b04+Ly4qwYGHSi1jtStjJYJscV2VEIUXP1m18J7cQCpIHTo5aEz2QufAUUAaI6N9Cu5wG1L0F06Rwa0T/iwC1X9cZSWlOmKcKAdIoCH8BeXicAk8Hb04ziEcYcsRW4BaD9rfVfzjNEKLAcMVthP22XZxfqXOlX0a+B4kfiv59we6FfxKiwy7UPvgJat2eD6wNT/yDqJJZpXD9xYvqCDX7ZYF6ljzL758/vJ102y56jr8M8Gjlz1ZXp7ijv3rpR//irys17xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd5pK0P2MKsF/jO2zY0eludfH3NaflTBv6od5Zht2as=;
 b=AHVJOoh8X7YFrnsvqBOAcCrFakzW38hXifS9ZShIOyHai29g5GS617w5YQwZ27To6ikj9yTcJ5ftYgcDM+kN1IugrDcyZYl9AYIFpm47aSQMUKNgdOMrqGFIqP8UPnjdNqTA3RpR167aPig06P3LzD2pCOTtLD1z0rdgEhkxvTpvetF2XOiQAm0n/uXRgPxsIuyd/Hh6ltnrsnrlmAGZduimh0bpD+8Jo0RkXetKKFwiVM8athQSTvYaC2DSZ4ABhjxsvCzMxFAKCeH9x5c84Cnxoi2gcDWAS/mZu6vFmCGa9BMNCNXpb2d3C3H+h3J57T522KXJ6ypmmPh3X7V9IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd5pK0P2MKsF/jO2zY0eludfH3NaflTBv6od5Zht2as=;
 b=Fe+IoGpjtA/iucm7dA5SUWf8DX5WdvueAiAEl3x3r3hstoEXwB4BTh+9NywIU+vmW2XDwhvWZ++ZSN4kA3Lj3NFdiPfgZkVbF/NCMTUHrskUQV6j8KEx3eXb7vPXgIFaS9LrFhHP3NuskqnKE5k4ep1Fy/CEzNjCee6ekQg478c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3514.namprd12.prod.outlook.com (2603:10b6:5:183::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25; Thu, 23 Apr 2020 09:02:08 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.2921.030; Thu, 23 Apr 2020
 09:02:08 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: drop the unused local variable
Date: Thu, 23 Apr 2020 17:01:51 +0800
Message-Id: <1587632511-12504-2-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587632511-12504-1-git-send-email-Hawking.Zhang@amd.com>
References: <1587632511-12504-1-git-send-email-Hawking.Zhang@amd.com>
X-ClientProxiedBy: HKAPR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:203:d0::11) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-All-Series.amd.com (58.247.170.242) by
 HKAPR04CA0001.apcprd04.prod.outlook.com (2603:1096:203:d0::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 09:02:06 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eab9237b-3e2d-4365-846f-08d7e764ffe0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3514:|DM6PR12MB3514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35145F28317F76C172215FBDFCD30@DM6PR12MB3514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(2906002)(66476007)(66556008)(4326008)(4744005)(7696005)(478600001)(52116002)(81156014)(8936002)(6916009)(8676002)(5660300002)(36756003)(86362001)(66946007)(186003)(2616005)(956004)(6486002)(26005)(316002)(16526019)(6666004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J0iAZGDQpKthU3S44i5alUKPcYVHUl+PAm7+vtJp8zikQ/qZE3awB5iLcF2ywsCEm3gq//ObI878h1WOkgfxa7INilZ8AsgBwGkWU0GOL79PZFiDcODfZr+2tggJW2glwyiytxDeH4GscZqX51YmVhu2Q1Aax4EyHUkQMhQUaaCGpBfh84qt4iO4v6HxaGkqNfTS3gJP128wuxJNcboIrk1f4iHRQWYBkBpBc0mqDvYDRIfQZxyxk8seDJGFxDQkcaTD9fz5x8XqJRKSR+fH6UT1bx5wMXlCgg7sWdaNDqd/JmkQoHm+zY0/ieSP5H/Bn8awRJdg3EX1gBIkdgFEshEeD/uSUKqX0IxUOwhksxMFr/rKL3NX18E8qRzSiKV06Sn0pyoL5UUAYNQG/XJJj7IGjx2/vhUYup7XvcP7akQ9nD264pdrmW1xmEh+Skg4
X-MS-Exchange-AntiSpam-MessageData: A8MaZpUjQuW6gzQlX3CN/XAq4Fcx4C+eup75r/CUxcOVL8jl54ii2yRizaGGV2qg4r+D/vBi3AQD2EcSpFK4cVNnSwa4l6I4KfV9rMjt1Cm9D/3A327F60y1+5kHidOHmEI8+4go6bNHcLmhFlV3tw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab9237b-3e2d-4365-846f-08d7e764ffe0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 09:02:08.1153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JpvnblDbjwVgqtINNqt4s+ZaixSt7P2LJJfW99MygycX56PAPRd0cf8RvYSfzEMXYQRH/sUa5mvwtJBGmvgQgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3514
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

local variable kiq won't be used in function
gfx_v8_0_ring_emit_rreg

Change-Id: I6229987c8ce43ff0d55e1fae15ede9cb0827f76d
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 8dc8e90..9644614 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6395,7 +6395,6 @@ static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
 				    uint32_t reg_val_offs)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 0 |	/* src: register*/
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
