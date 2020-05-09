Return-Path: <SRS0=XXlo=6X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427E2C47254
	for <amd-gfx@archiver.kernel.org>; Sat,  9 May 2020 08:06:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EEC62184D
	for <amd-gfx@archiver.kernel.org>; Sat,  9 May 2020 08:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IHYJHCWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EEC62184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4B526E2E2;
	Sat,  9 May 2020 08:06:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAECC89AAD
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 May 2020 08:06:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAF8+WrF4utZ617yl3LeycHyAhzfOF4mYMoCe0ciUuNKbSc7JFdI3j3p9dnsOGF5303Tn/4J4X+/vMDWTlOwL0VHRlK9VdR1lxEnoFmZtXBCRjRZ1rqeEz3ApGlHZYDTGw6KXOjm/Qd4rOU7dqagl0mFk1G4ZefVmlY5aKJ1uV/xfoqL74lXPczcwQYDd6vlK6/06pkT3onygg6eA/+heme8i/58haRUf+kjt4tipjYeSH62WOwGdLoMrL8Dbvkugsq9vD9y3HvgC7ty/n0ufKXCU54fqcDvT8K/9/+J6HXh0eS4FCjQOaaWDc+WouU4H82UcF2TLrFNQz0BlTVhDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7IEZUysjFSJh534aQkX03l0G2xQrU9NyZHxF5LG8bQ=;
 b=TrkRyBJ+O+J/+ngdY+0lRxjfMWbIJ+0h8+rb7HJnbHJKCh8PTRW3+F2KlOO3/SiCCa2pcElFdnmxkTUVJQXaqk8OGHuzZ0my+OokK+AhbDa+SMtoBMz0CB6evAxnAziZ7bwVZbROK4TmEw0Zvv99Qb+8L+T8NA+Aj3Y9+XsshxMc2hs4aqDa3nilX2w15jL9TRODyoAtdFBrR/hQaUsLOBlUvnV353HhUQfdSHzSZdXUEIoT78WmsAOs8ErcKAw2iGsw3n6bOizCLiIsIA2Vno3mKt0l1s1nPRcIov2Ot7s7O0FiopDapdKNgdrwcorI24ScrLqUOjHQhel/z/Urqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7IEZUysjFSJh534aQkX03l0G2xQrU9NyZHxF5LG8bQ=;
 b=IHYJHCWhG+XKl/Xf/GOtdG6dB/hMddDasx+nKEDQ2gIiX7IV7cGFmxRGJnvvG2gDXr0TiH5iGHkPkCHmwryrjNECUbUX35cMwswqBIA0zIPUo4ofA2DOKz3jrkKsRakM0Yr3KPFZqNDEfM+GV70cBlN3qC5/Rbnssynm1NnI3xI=
Received: from DM6PR14CA0044.namprd14.prod.outlook.com (2603:10b6:5:18f::21)
 by DM6PR12MB3995.namprd12.prod.outlook.com (2603:10b6:5:1c6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Sat, 9 May
 2020 08:06:39 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::bd) by DM6PR14CA0044.outlook.office365.com
 (2603:10b6:5:18f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend
 Transport; Sat, 9 May 2020 08:06:39 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2979.27 via Frontend Transport; Sat, 9 May 2020 08:06:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 9 May 2020
 03:06:37 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 9 May 2020
 03:06:37 -0500
Received: from guest.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sat, 9 May 2020 03:06:36 -0500
From: Jane Jian <Jane.Jian@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/powerplay: skip judging if baco support for Arcturus
 sriov
Date: Sat, 9 May 2020 16:06:33 +0800
Message-ID: <20200509080633.4506-1-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(46966005)(33430700001)(70586007)(1076003)(426003)(336012)(6636002)(86362001)(5660300002)(478600001)(8676002)(33440700001)(36756003)(8936002)(6666004)(70206006)(26005)(186003)(2616005)(7696005)(81166007)(82740400003)(47076004)(356005)(4326008)(82310400002)(2906002)(54906003)(110136005)(316002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6b717ef-fa3b-4698-62a4-08d7f3efe685
X-MS-TrafficTypeDiagnostic: DM6PR12MB3995:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3995C88DAD045FDF2C4DF329FFA30@DM6PR12MB3995.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 03982FDC1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hq5dqFPG7KwjIKXO66tw3tEEWMLyIRxgreqshnrHJ8AePzAm2mB/m+7/1NXcqHEOlYhgyKgEkbzJNMf1+plOmPONeJkr0HKSSGe3TO0vlqFcxSqltdu016GwJii4EAmuX6JC5ZeN6b1eSZLM7+lZJHjd8VhJVjihyKJoMY1Mh0zl1XoWLZFgP+N6jVBaMvrX3HYAPneICCuIDr3WgA10vBdI+VspoJEeorI2mglGNI1/uCNidOBAX8/XohqnzbXK+iVGNTwDexGgvyXAOQJqy2KQkG+hbb+/eVu6ttHP+vF8qx3rsJTiNMmDXJe/JTI8pU2QaT/jiVLn+Fe277SAEjPlxgibTU1QZlPLFR6W14Rax4OCLNSxrZ/THA5EahaN89XsJfop9VpAJMTMLSAiSpDcRwy2hz2OCy9Hjwm7RmAbSO1CiAh+LlD5Mp7h21+4wiNugSY4kpQ/s3crZDJrNPO8npNDT2XI0UpUcGcuMgPrnPiyrEjD0WBPbSc4k7fgVD//X0rkvSSXzfq+8qonKw1fl4f/2EoWS7Jdz7T7LOVzKK4whFypi7pF/QUgecy4dZGR55dICfS1ZgQCXsA3iw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2020 08:06:38.5469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b717ef-fa3b-4698-62a4-08d7f3efe685
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3995
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
Cc: Frank.Min@amd.com, Jane.Jian@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

since for sriov, baco happens on host side, no need and meaning
to judge is baco.
also, since kiq reads strap0 in here, if kiq is not ready
or gpu reset(kiq resume) happens after this read, would fail
to read and wrongly set baco as true(1).

Change-Id: Ib67f837edfbf09263133d5614f6dbb890cf27b12
Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 1c66b7d7139c..cfae4bcaf32e 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2251,7 +2251,7 @@ static bool arcturus_is_baco_supported(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t val;
 
-	if (!smu_v11_0_baco_is_support(smu))
+	if (!smu_v11_0_baco_is_support(smu) || amdgpu_sriov_vf(adev))
 		return false;
 
 	val = RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
