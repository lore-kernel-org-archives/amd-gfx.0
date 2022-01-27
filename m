Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC8CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 17:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60F0210E269;
	Thu, 27 Jan 2022 17:24:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2EC010E269
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 17:24:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9QmLklBk+fAzmDyJa1BwL8NLz5skKjtLmvdR54lFlXviCJZF2u/HVYU+CgNWmkdW0lcyH5bGD3Um3MJIuzLjWXG/fDeuav9ahxTOiAAuKLfBW4jaKBTby7XRCHHF8VGsfvBIbvPF1L0BkMTYCExzx94u7etLzhdUgMnbLraMckis0HkxwQLGIo605S5daP53bPyD1Vg+31ficjVFnjbvXNdh7urPpjIgbnKkGFcHOCI7GlDSZ1Qc7KPkdFHENo8ImOgU0chJMySFNwzamuOJodRALzWY+z3+el8V6rN8n1of+7TD/P5gzVPSFMprkqXt8JR6FRgirScstwreY+bwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISjbu9m3Bm0FZbX/gEQwZrE0jPbL00qRGUGLk/jW7AM=;
 b=bmNJsYHJieuBgtZo9Nk/X8NAOWZI/VqfWfZLXsfGvttM/sHcb4s7zONPcUHpJh7ft/vKgEBH9xeTFcBcc1rfEgpTAJzVFo9oSzHPk5rrKDr9KF7dNqThcNCGCRhGj2UTUauLorcftcpET8wSuaugQv3sb5/lNa1Tiahm8oPPLvpjFHpU6RpQDduitZO+1V6qxvaXPUcgTJR9nk4NzAakeGg9H1xkfxTILBMjVza/2QbOZKp/3UV7wSBHwz8nKZwq0cS09IkbNsVHsq+i4ORNqmvFthGS5ezmJbvJagegQNxHezQPAoch9STltUNQGUedWLSbvZGMr09aDdxB0swipw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISjbu9m3Bm0FZbX/gEQwZrE0jPbL00qRGUGLk/jW7AM=;
 b=f5tFdZdeo6kGW6HNstvj4HqFk9zKMXN3gWGwM64aAsNWwFuCzrHXg4VrvHpCD10xsWY9g3w2CxjIzWS41xMo5+xbAzPlexp9INh1kP9ff1Z+JD9t6VgTKIxSxA5PEgVmLr5B+aeDgkgcsnybZUsWBO74cFYfPz2QzbSbEpkJxkM=
Received: from MWHPR13CA0044.namprd13.prod.outlook.com (2603:10b6:300:95::30)
 by MN2PR12MB4096.namprd12.prod.outlook.com (2603:10b6:208:1dc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 17:24:07 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::b5) by MWHPR13CA0044.outlook.office365.com
 (2603:10b6:300:95::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.5 via Frontend
 Transport; Thu, 27 Jan 2022 17:24:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 17:24:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 11:24:05 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/swsmu/i2c: return an error if the SMU is not
 running
Date: Thu, 27 Jan 2022 12:23:53 -0500
Message-ID: <20220127172353.280369-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127172353.280369-1-alexander.deucher@amd.com>
References: <20220127172353.280369-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b9d4498-e1a2-4cbc-a04f-08d9e1b9d2b8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4096:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4096859ABE9543B5FB3AE238F7219@MN2PR12MB4096.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qpxr2Pgq56t6YpJr24lj6isWREE70SKq+Lzz8iIDw7MC7bXvjsq23XIrjtrX2/zzNWfexdMBguIEqJbfwmbgdciIf45PjetO2zO0cSMRhMObdXK4A94xh+0MP6fo1Iicm8fm+sfE8/Irh2doJBYCoORt6uBK0WwsECDN27xVSzBnPuyh4SQ069qUfOgbylRgiS9Uy8fKHSdxivDnk0iSRXOSeJqBjgaDI6a5gu59OOA5UWezaxvpc5Q0P14Vs/Ro/Sns0YSHS6X46A45DHX3w9QCREbrDlZe439Aiazr+Xm8x1eYCXeqqQH+gYr51/5MnTJ06YkXPj5sxc+gIkGj/xzEtr/7V1FJGMBQbFHmyQpTatxSwOi7yfEzBPVS/QOFF56ek4OalYkAjMIFhjbCV9Q9/oPuaIRXb9Yvpt7OgMaOeNFxwfJ+uqnQvfqKdhfEITQu9I35IU/G0kQY7IvDUTfQQEljitYRqwxKAfQqXovVp2SmkSIZrnXJJHRzNgX118hrPDJaDfXL4d+fm81s3QIHJv6LO4Irs2iztXdTNxXR4w4nE6HLeKg/KnafQLA830QzfzOtt12pb1YYn052eRyJmf9S4J65YUv28YAfFFXQX/THWVzXbQ1IImFO+Rjls47YBXU6fl89k+oWmO6H4R9uY9nr7GyqOOW+PvT1x7kreCbtJ7ajGkqKak8hrEXLnOzAg5lGS5fa3MjspYkyCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(81166007)(508600001)(356005)(70206006)(6916009)(5660300002)(70586007)(86362001)(54906003)(82310400004)(4326008)(2906002)(8936002)(316002)(8676002)(7696005)(26005)(186003)(16526019)(47076005)(1076003)(36860700001)(6666004)(36756003)(40460700003)(336012)(426003)(2616005)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 17:24:06.8119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9d4498-e1a2-4cbc-a04f-08d9e1b9d2b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4096
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Luben.Tuikov@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Return an error if someone tries to use the i2c bus when the
SMU is not running.  Otherwise we can end up sending commands
to the SMU which will either get ignored or could cause other
issues depending on what state the GPU and SMU are in.

Cc: Luben.Tuikov@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c      | 3 +++
 4 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 2c78d04d5611..bc20d0da4393 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2070,6 +2070,9 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
 	int i, j, r, c;
 	u16 dir;
 
+	if (!adev->pm.dpm_enabled)
+		return -EBUSY;
+
 	req = kzalloc(sizeof(*req), GFP_KERNEL);
 	if (!req)
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 84834c24a7e9..47a75f9c453e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2754,6 +2754,9 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
 	int i, j, r, c;
 	u16 dir;
 
+	if (!adev->pm.dpm_enabled)
+		return -EBUSY;
+
 	req = kzalloc(sizeof(*req), GFP_KERNEL);
 	if (!req)
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 651fe748e423..bca622ca9af4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3449,6 +3449,9 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
 	int i, j, r, c;
 	u16 dir;
 
+	if (!adev->pm.dpm_enabled)
+		return -EBUSY;
+
 	req = kzalloc(sizeof(*req), GFP_KERNEL);
 	if (!req)
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 8c02adbf446a..08415de45e16 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1473,6 +1473,9 @@ static int aldebaran_i2c_xfer(struct i2c_adapter *i2c_adap,
 	int i, j, r, c;
 	u16 dir;
 
+	if (!adev->pm.dpm_enabled)
+		return -EBUSY;
+
 	req = kzalloc(sizeof(*req), GFP_KERNEL);
 	if (!req)
 		return -ENOMEM;
-- 
2.34.1

