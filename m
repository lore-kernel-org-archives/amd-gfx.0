Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08030C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 10:20:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9475206B7
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 10:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SRZ36n5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9475206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 620EF6E973;
	Tue, 17 Dec 2019 10:20:22 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B886F6E973
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 10:20:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZXirkwAJbgkZQytNt+2YoANcc5SZ47gLYG4eBHkBfh5ag9WYqHSNgyCHF4lX+i6TQf7PP5N6tmX0Nt1jNohc23UsUbUwTggQZ/nj1SZiOO60qYTl3OrhTGRUG6rhh6nVQm9ZZ8ccOJgShoZX2W+5c0Z8tuxfQ2hNuJw/wrDtJhiIi0mUDFtWTiLaY0a9dwsFGrHhoMo8wL6GFzF2zr94sjr19iGngxx5GB9fyyOabjfZLOTsmLliKXQEMrJcO9B42UYkOmPWG5f3f4Hnz4/6IhB62heLg7SVB76M53lqXblA5zJhe5MGIwoVUQoYUwuCS+Hcjoass1VWKe/u0mnXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v74XddAOqpgnbKIkbmfDO6CZZZ6Jp5akKM0ttTj2Fb4=;
 b=nRLvLQtePQyawvnJmfyYlVo0g2O7tbHmYcqKukwHl6A7BwgsuKxxL4SE6V64M216H5nVpPy1grU+cxlHfoq7OLLVRMPW3cRJ6KXim3WoYGKh7XN1ng4AmnnWDmw3mk4FeB2vBxABSFbQMfFcB79uVH71AyuGtNKYXjODFH/s3pfvgP2sbSrFuUJF9Tsxm8S/Ar83qr4bLvfkgVEMdq9oxcqMCJAp9gpm+udiZLbssEvO9HAfr+iUnN8r4iV1H0GuEIHS1S04u+fUeMuhMZG2WzSCvdbiq+bM26K1/nWMjWEBhn5DGbdKrpZdud32e0WEEDTnJ4uaiWcXDozZUg3nbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v74XddAOqpgnbKIkbmfDO6CZZZ6Jp5akKM0ttTj2Fb4=;
 b=SRZ36n5Mkh15+m/Wk0I4TcbNgyxQs2BbHf5Jz3hsFnnaak2EO/SsLI55vRDipkUXw4pegCMTquLL7AjNRQxoWO70oPg9XjH1IsJMDTf5ehMGgeSMnlkxCLxQqdaTfD4Yo58hyYPGK3Wm2xOeA+cGzSedUEAipIdPiimr3StGcpk=
Received: from MN2PR12CA0008.namprd12.prod.outlook.com (2603:10b6:208:a8::21)
 by BN6PR12MB1346.namprd12.prod.outlook.com (2603:10b6:404:1e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.18; Tue, 17 Dec
 2019 10:20:18 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::201) by MN2PR12CA0008.outlook.office365.com
 (2603:10b6:208:a8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15 via Frontend
 Transport; Tue, 17 Dec 2019 10:20:18 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Tue, 17 Dec 2019 10:20:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 17 Dec
 2019 04:19:59 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 17 Dec
 2019 04:19:59 -0600
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 17 Dec 2019 04:19:58 -0600
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR of SRIOV
Date: Tue, 17 Dec 2019 18:19:54 +0800
Message-ID: <1576577994-12874-2-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576577994-12874-1-git-send-email-Monk.Liu@amd.com>
References: <1576577994-12874-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(346002)(136003)(428003)(189003)(199004)(4326008)(6916009)(336012)(26005)(36756003)(478600001)(7696005)(2906002)(316002)(5660300002)(186003)(2616005)(81166006)(8676002)(6666004)(356004)(8936002)(86362001)(70206006)(70586007)(426003)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1346; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4fdb235-aa49-4431-8b9d-08d782dab706
X-MS-TrafficTypeDiagnostic: BN6PR12MB1346:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1346E3B92F07C7829008E04584500@BN6PR12MB1346.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 02543CD7CD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MnwyGlH23anfeO6MKmMw6pVTHsYq8O8gNH7puVT+93Iy62emjPICiRnq5Qev/qeNOckgjjd4qyVtfFXhtrmOPJ1LBObC8Dejavot7nw0+Ccys+B0bbhE1/Lmg/nB4wsloQPTjAwU0wqXUTOQKkYiAfgf2HIhhKl1yVeXpRVVEfdNiCEgGad2D+qdWsSaZpBVleG+rQIveo+hmnlHmHvVmJ0rEnQitFZFTmZqP0gDaLzOwRWA0ZPswJtSfeoSjgu08BMrsEqXYy7X0VUQAr2uYU3xPas9zAkmLAgdhyIfs8ymweFsLxM1eqBx5AENVuzPlR/h6OgAGCqRH7qcRvrw6GnkjgnrPtwWMmcrbt16s3abH9RqRocR0UXkG4SR10CtWXiq+O08iX1/oYmw7pkl7vJfQiGyvVYqUReYWQ1NjBKu+4HOAtq1dHebC7QOMiFr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2019 10:20:17.9744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4fdb235-aa49-4431-8b9d-08d782dab706
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1346
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

issues:
MEC is ruined by the amdkfd_pre_reset after VF FLR done

fix:
amdkfd_pre_reset() would ruin MEC after hypervisor finished the VF FLR,
the correct sequence is do amdkfd_pre_reset before VF FLR but there is
a limitation to block this sequence:
if we do pre_reset() before VF FLR, it would go KIQ way to do register
access and stuck there, because KIQ probably won't work by that time
(e.g. you already made GFX hang)

so the best way right now is to simply remove it.

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 605cef6..ae962b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3672,8 +3672,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
-	amdgpu_amdkfd_pre_reset(adev);
-
 	/* Resume IP prior to SMC */
 	r = amdgpu_device_ip_reinit_early_sriov(adev);
 	if (r)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
