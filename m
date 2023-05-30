Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786FBC7EE23
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 22:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB03910E433;
	Tue, 30 May 2023 22:34:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3206C10E432
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 22:34:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPkC/yDL6kp19D/CqPLzfXgyBVAL4rdqQQ8Oke5NeBJAMp6RZKkNttfiQHVlAChpZ3w8V0N2/XoVCwQsAPRVuelb4wi+o/TibXDxrSXuwwaldqO5cxaqR8Jpyd5NQBInAuLGXW6RZ6rD9XyIO+KKb4KuEgDz60mK217djN404iWELjONmfMW2Fv8lqPp5RIUxYt3ppUpIcG46XVtchh+fwzFv920zDPTDKWxOorOkbcUYlwFSKuvqW4VQY3b01CWD83WnxyLxchgVNML6ZrN3Zjq8xvDHU0/u3ZxSvmomm/PKTlB+nILBJmyGvVhc3FWtmgDI91pPVLN9BAuqnTQYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcaQjxrz6OvCxBTMZ0pSVNaxDbVc3fRPI7tD0alY4rk=;
 b=lHPILrcmH/DSJmfB3DtRU+EdJtGtsD4T9AwDu4wJMd+8qK1iR3R0zjdd6jecjq3WjvJioeZhdDdStadOlLmfiBJ0Qobirrz0iMGYWdmWQC/mduzHpH/h+7Bp4iJhSv1CK99hTQk2KfxElEEVxZ3rRLSNTHa+XkXNcbI0WpYQIPDXHzXgWiMeOnq5YuM6lgTaFW+xI5t19nk4hSslG9hhleS+WjP58cBJ0tLxts7u/usM/urkoWfpoRlaVJlO7vQRWjmbWl+HRMmroZKzwCFbbAFGJFjpWI6oI3R0//TsaWPFA97BtcWhcelCqyUCePvrMWq+OFbuhpUAG4K3hrOH6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcaQjxrz6OvCxBTMZ0pSVNaxDbVc3fRPI7tD0alY4rk=;
 b=25/m5WcRFBH9Q+9lYbZjFQKqQJkmzNJ6sBcSMdeM8ngiCZKBSB1PHGkXvYGa8MYtcJZmqk5/KgGzduaAfo4fivAle9JwiWrrnn/8GPMAW5C9nXjvprDYzx2gHjpiP3IY7vpLgplm+J11f/KtOLBJn3KchAHNKt065i23zyHtjRY=
Received: from BN0PR04CA0033.namprd04.prod.outlook.com (2603:10b6:408:e8::8)
 by DS0PR12MB7557.namprd12.prod.outlook.com (2603:10b6:8:130::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Tue, 30 May
 2023 22:34:48 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::30) by BN0PR04CA0033.outlook.office365.com
 (2603:10b6:408:e8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Tue, 30 May 2023 22:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 22:34:48 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 17:34:47 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amd: Make lack of `ACPI_FADT_LOW_POWER_S0` or
 `CONFIG_AMD_PMC` louder during suspend path
Date: Tue, 30 May 2023 15:48:48 -0500
Message-ID: <20230530204848.231842-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530204848.231842-1-mario.limonciello@amd.com>
References: <20230530204848.231842-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT004:EE_|DS0PR12MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: a515c869-e4bd-40fd-1597-08db615e135b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8pwMtKHDlhsDvqG1oVhZqIf6SaHaFM0bZMAK5SP7WdMnfNOmfRvpvwdEv7/R1clQf5nIZ21HLbByu4VJhkRni6NkuwETcXl4ViOPuA+Cja9rRGHql8W9dogYfZ0y1zPqZ1naRi+3uy9EZ6DtbYkiNCj/KVl/QnZJqL2stv+J+pxnihM3z0fuKYUNRnABN2gnI1AYEPAjkLCXKzsMvIIreqaasyBGW7JuU48A5BJ8+3su4xook6nIRVYeBWiM+jW3gsBhpQiRvf2SuL4JWLDMKfXkAKJ1SkdNXqKlqzvy38uOFi+bd6740QOhxPeIC0eyTFgF7oqQL7jUXxDhbYZJhEu1md09bJLiWVhSjSR1HSvTYUmT0CjUoLQg8ryYTVVz/XuIPSPzaIZqHdbHWj+W1kUyC4wjcTqT/GM7oKg7svjmwsudo7QZia4yOaF4xefcUaPT8iIZtlITTGEbiswicNUnWtjhWbgfC1IERgMheAjVaa2HT0ZxFu2hyLy/JDJzEpqp8jACdROinEq85E7qKeRdf8ldThoV/rbmTEXD2XBxBnwSiSNkRU7APZ7Nlf27c4jXGGpFrAokFA2cpO2y3EG12w+aa/vfTyfot9oRB1is/a1L/2kaqB8WAy1Bkp+hSggTKxI/rxK4zGIztELvBDmyypUYwHeT0L9U7aOkiWs3bIUJ2nNiAMsF8Id71wgZH3Nb9VKj0rhsgGa9/t38A2fM+qKfOV3sP369Anfd0USx+kjsE1ue9M0nxudoUvpATApR/VspMFRS97wcH0X4aPoYtBhFBl1/0FhDFFm1L6k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(46966006)(36840700001)(40470700004)(316002)(356005)(44832011)(81166007)(83380400001)(70206006)(70586007)(36860700001)(2906002)(966005)(26005)(1076003)(6916009)(4326008)(15650500001)(82740400003)(86362001)(426003)(336012)(47076005)(2616005)(478600001)(5660300002)(40460700003)(186003)(16526019)(41300700001)(7696005)(40480700001)(36756003)(8676002)(8936002)(82310400005)(81973001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 22:34:48.2144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a515c869-e4bd-40fd-1597-08db615e135b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7557
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Users have reported that s2idle wasn't working on OEM Phoenix systems,
but it was root caused to be because `CONFIG_AMD_PMC` wasn't set in
the distribution kernel config.

To make this more apparent, raise the messaging to err instead of warn.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217497
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index e1b01554e323..fd6e83795873 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1093,14 +1093,14 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 	 * in that case.
 	 */
 	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
-		dev_warn_once(adev->dev,
+		dev_err_once(adev->dev,
 			      "Power consumption will be higher as BIOS has not been configured for suspend-to-idle.\n"
 			      "To use suspend-to-idle change the sleep mode in BIOS setup.\n");
 		return false;
 	}
 
 #if !IS_ENABLED(CONFIG_AMD_PMC)
-	dev_warn_once(adev->dev,
+	dev_err_once(adev->dev,
 		      "Power consumption will be higher as the kernel has not been compiled with CONFIG_AMD_PMC.\n");
 	return false;
 #else
-- 
2.34.1

