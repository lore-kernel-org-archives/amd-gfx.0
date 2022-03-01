Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95618C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 18:08:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C58310E6A8;
	Tue,  1 Mar 2022 18:08:27 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2056.outbound.protection.outlook.com [40.107.102.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5980F10E6A8
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 18:08:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5PTxDjnOjZPM2qCRvIsAqXKyXKno06ii2/fJ4OsOsVegXGH5Vs1JBf2gd9Lt1DnPLhArIsDHMeU/Puked/t38C2jaFLdf5Nr226Jb8X/fHlIkPKjjW+QghnH0+fqhPXFOWPg7n7AJuUJePCUkxlIPqsB6KhCqzzvYJzqTP1Fr2gz0J3ajJQk1SkPw9WzWBHTEr0tDCEYcQydxINVxczMe8lBV7oKv50wZoiQAnYcmZ4SfFo2ApQsVJy8fwZZv/ALbqW/aiLvhqP/enTekG6bmIV0yKiiIrR3Df3wsqTuT86rw11D3OkMV1xadsqXNFsEttrfgTcKR+52iPb1UD9+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6VzwmqlrC5wYgGJKAbPRfFLFf+fVk4N4xYkzYS7moI=;
 b=bzw9nzrVoW2JC6jtSu/QtcHWLSGJGjFwOdcScBaBz6AwddAsgJk4mhgz8oSNszTxoqNWiBb79JymdrNg4z48w6Sylh2EfO0WCh77L9WwyulpkcTi/FFxTKR1BcZPItFaL7FVnFxNhR7EaW5oETmsvCrXTpmEtwrZs6byI3nJ0qNZtMrvMGjwiAS3R2nldV4W/IuRe0YlM9KfgvQmKFIioEc3jQf1+XydlCM1hSLqR3Ze6iOfVhdQKqKkZpdnoKnPRvPfWRx0acXksbE6+E9yTTLgxN9DI86gHkHeGpBSSiBkR3lPVriinmIEeYy72thaGkujIztcqvp5UXZ6iKm1ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6VzwmqlrC5wYgGJKAbPRfFLFf+fVk4N4xYkzYS7moI=;
 b=ZiH2ik+y+87tBdTCBbVhb38dOjVdiCsd+pZ0P6MJm0fv+ogQ1Kv4ozW4uqgyDjnvQ6++KWgU0DjjqrX+YCDJo/KsJZHr/owvSLD4Rx40DO3otyYyF2d05GAQ1V7IJK91oyUqp60SqE614qR+tT+0z96jubwf3MevX0OOamXG0Y8=
Received: from DM5PR15CA0026.namprd15.prod.outlook.com (2603:10b6:4:4b::12) by
 BN8PR12MB3329.namprd12.prod.outlook.com (2603:10b6:408:61::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Tue, 1 Mar 2022 18:08:23 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::3e) by DM5PR15CA0026.outlook.office365.com
 (2603:10b6:4:4b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 1 Mar 2022 18:08:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 18:08:22 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 1 Mar 2022 12:08:18 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Bump minor version for hot plug tests
 enabliing.
Date: Tue, 1 Mar 2022 13:08:00 -0500
Message-ID: <20220301180800.1781042-2-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220301180800.1781042-1-andrey.grodzovsky@amd.com>
References: <20220301180800.1781042-1-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2415547-4657-4aea-95e0-08d9fbae7954
X-MS-TrafficTypeDiagnostic: BN8PR12MB3329:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3329A74E32CE0BF2FFA3DCE9EA029@BN8PR12MB3329.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ixAYH/E6uzEta8NWVSapK6kmUu9x3yfm+EhfOTPyhQ3SKIRnIvZfWmJMw1+iR1Fvba/H8UT7rbaSKc1NiFZkn/pHVGOA4nJ/d8p3JA3D2B5CD7YYXhagwr4xGxY8o1pwF6qgXUYJQgjIxl5tTCC1Q5JbAa1RJQUog4XZ5taRBk8bNuy3C7CHnZAt5NTae2UvTALAIcBCCANWNFH1jeeoKGgZp+WcGeuCsbl0EaDWTCHPrJzNVPC3lzpY1H4PSBlmyjOigUDKApFqmYpgIyXheTFpKBlci7D06THXwcXxpOYGzC3Z8UFbPDan2RmDq8/3/AULyzCqiiS0iII6xP/e5MgdhDYQkDy3rGYl6+IF1+sOS1VIlgs4Cszkbqnfw4jbfOP6v6ihTMKlrMEEzj7XMtZn5+vght5xYY5sj/3p1GabnrOjMxKlRa/51S1gb58qPaPJiENHEyKGbY2IKgUTSq57ynp5C5LjCv9LoVGtdQV4vLOV/pNHV3rFFKcwrZ4ujfmAnHSeD6ErONZ+RE33yrcMDoOPNEMPh5lZJa3giJdXmWtsTJgOIsscy6dHRiPJUSeR5wjzQrSz1mJk/o+vhaQh/VP/EqbyC/Yg0gF9sg4idAqSlQjjqrQmLKTDhqUEeye9z2kycUQ5G3MEPxgx5rIgbNk8hqHkeYEldMW0Pp0JWZAfEvYX0CzTv290lWdI2KExl0ND7oX+YAOBmyayA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36756003)(86362001)(8936002)(8676002)(4326008)(70206006)(70586007)(36860700001)(426003)(47076005)(44832011)(2906002)(508600001)(966005)(5660300002)(40460700003)(316002)(6916009)(6666004)(82310400004)(7696005)(356005)(81166007)(83380400001)(54906003)(2616005)(26005)(1076003)(16526019)(186003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 18:08:22.7009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2415547-4657-4aea-95e0-08d9fbae7954
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3329
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
Cc: Alexander.Deucher@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This will allow to enable the tests only after latest fix
after which the tests passed on my system.

I tested on NV21 standalone and Vega 10 and Polaris as
pair with DRI_PRIME.

It's possible there might be still issues on ASICs i don't
have at my posession but that that the point of enbling
the tests finally - if other people during testing will
encounter errors they will report and I will be able to fix.

The releated merge request for enabling libdrm tests suite  is in
https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/227

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 415ecf8b2e05..be4adda8d674 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -100,9 +100,10 @@
  * - 3.43.0 - Add device hot plug/unplug support
  * - 3.44.0 - DCN3 supports DCC independent block settings: !64B && 128B, 64B && 128B
  * - 3.45.0 - Add context ioctl stable pstate interface
+ * * 3.46.0 - Add context ioctl stable pstate interface
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	45
+#define KMS_DRIVER_MINOR	46
 #define KMS_DRIVER_PATCHLEVEL	0
 
 int amdgpu_vram_limit;
-- 
2.25.1

