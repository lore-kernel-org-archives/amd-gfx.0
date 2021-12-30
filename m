Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BED0C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Dec 2021 10:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29DB610E339;
	Thu, 30 Dec 2021 10:01:34 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2064.outbound.protection.outlook.com [40.107.101.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D87810E339
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Dec 2021 10:01:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVlZKJNRJ0QSgq85jqD9tEKJOH+D10GAdrwdtsvy4yQ9GvCYyqxR8KzxqjGYkdTJqJq+/HLHPUdhN9pDwhUNG6+wadlEZ5CCHSVEe/DHAulq7lgONVYY3aPUkRzwFVpeEEMWA6DaijQisLb4nW/CMMPUFZoOI+9aVx69MhovFA3CL7mA+nD/C70hY4F3xL2qj8hCbNCle4wZoA8tAqOjpdo2/6aKKRL3UD4jmGbGRba/3V817l18pvra6qIYem0b6RnK9UPFIagMZk2YhgeUdRox1zR7Q7DZbPE98yLb0jgtsEX+3eosNwrGj1/HcB33BDhHdRcRe3oGFqEG4WHt4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Mdj3mZLmPMI4epAmuHxsFdi3pVuu3HhIsOldeW25jI=;
 b=LC7g4fj/X4+adcn3QnTe5GsXNPc+ugxQ+lwv+/K+WPeICmD1Sn4gAptu9+SXBS6mnj6tYeXapycXYplAFMqhNI4k4kPN5ReTKFUKu7bFOcFMA7rwqk2iO6GJ5MyKnbbohu1Hs2phveD48BNHR3vKidIJJnAvaPrnrswaBeoif8JNNUa1j1QxWqOHE/jCfKkKEpzGmaEMpfBAX7oWmq/YixhLfEAb47ZoS+jri+c7dqXS8/9u8BGjsTQTQKq+S8eLH80d+kvQfcxGAmWpCiX7vvviG2T7nFIqyroUY1zsR8zJ+j5qLknS0JWfb90OP2eZ0Lcxzkkqaa2x3PQobLvvLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Mdj3mZLmPMI4epAmuHxsFdi3pVuu3HhIsOldeW25jI=;
 b=PrAWTxG+RbpqMYedUwvUICJtqNxAZZYMhD+kSTpI8XFOehXVJ9RJLs+oOol/xvVMTJcBW1T/M+WFfc16YWo7kVzy6noqacNEKM15dLs8Gg7NL7RphkPkw3EHZVfS9LSh+KwGkaKeQx7s0XSaOihxb4ZPsjmMgQJIMziblNYwnJY=
Received: from DM5PR18CA0083.namprd18.prod.outlook.com (2603:10b6:3:3::21) by
 BN6PR1201MB0002.namprd12.prod.outlook.com (2603:10b6:404:ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13; Thu, 30 Dec
 2021 10:01:30 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::aa) by DM5PR18CA0083.outlook.office365.com
 (2603:10b6:3:3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14 via Frontend
 Transport; Thu, 30 Dec 2021 10:01:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4844.14 via Frontend Transport; Thu, 30 Dec 2021 10:01:29 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 30 Dec
 2021 04:01:28 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: keep the BACO feature enabled for suspend
Date: Thu, 30 Dec 2021 18:01:14 +0800
Message-ID: <20211230100114.2171135-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbc63a9b-01b6-4419-287e-08d9cb7b5a00
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0002:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0002D2D18CC3165D82617EDAE4459@BN6PR1201MB0002.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rgSJPBITZAs8N3Nf/pNXEAvlVCnN6aVnHSSRhVFg6b1iWrJRIP/ElaAHf+dlv5MPyvsj1S6ZwoadX7Naw2Y/Iaak1wJrC7PWhiNKGng+bGAFjBvmSqZ2oIsx6c/wgTMEeTtQqQMZfG7KojJF9IOwW+/Ky+PR+xgkfoBs1eET5A3hCfmHuxj8451zvdKQGd3TbWuRvI7ioo1C7oh7XzvasDkWgGakQBSBTREeGoSJ5zO5FcLrzSK4pLsLMAQd7nVnak713KsUiX/kvolZw7a7CnLcKS9TIZNz6X414uUXH7WfVL+8PjpKzX3qvfKuYovoyaglK45F77BAYypLHBdJQNV38tqKQjjTOwi1U21GHowYzUY1ezH4bhQFWMG8aGpcOltG+X0PemoP1+cLzvxNGITgWPpjjXT1if9nu7XzC0ysKU2jVxIDUIWYd48xn2It02sQQD/B0BaC+c7XmSLonzmBe8nYYxiV7WYY+W9jXrdohqXsYzb9zGXyxcQFC9RnJmM5QePWGKyf9FeD2dabW6xX+1s8JB2z9SzVVCJVm89VCmar/xHl83EoPEYhJaSj6BgUeW9xAgEB/xc22whg4OXTfCnHiAb0dg2dBIMeswfyCRLomGb/W9vwq6j3lRyRsx0OtGXJuuvEJhhJiKIQyoUMUEQkt3zqESKcf/P5Rs7KAzaOellh7bUVwMpvZMLUsEI4KmhsGrBZFXCo2gzSIr9aumPS5XrBuegQQVbSj9OkSwL3AjuMZX/JxSv+UuMo10wLa7eqW72685/IxK87jzebXiIu38jJvwiQZ4uvZKg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(36860700001)(70206006)(70586007)(2616005)(508600001)(2906002)(8936002)(8676002)(26005)(426003)(6666004)(16526019)(86362001)(82310400004)(1076003)(186003)(4326008)(40460700001)(5660300002)(6916009)(336012)(47076005)(7696005)(54906003)(356005)(36756003)(316002)(83380400001)(81166007)(15650500001)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2021 10:01:29.9917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc63a9b-01b6-4419-287e-08d9cb7b5a00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0002
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To pair with the workaround which always reset the ASIC in suspend.
Otherwise, the reset which relies on BACO will fail.

Fixes: 50583690930d ("drm/amdgpu: always reset the asic in suspend (v2)")

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I39ed072af16e34ef1e1c16b50ace6d46fbc388b9
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 4d867778a65c..7628be2f2301 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1308,10 +1308,16 @@ static int smu_disable_dpms(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
+	/*
+	 * TODO: (adev->in_suspend && !adev->in_s0ix) is added to pair
+	 * the workaround which always reset the asic in suspend.
+	 * It's likely that workaround will be dropped in the future.
+	 * Then the change here should be dropped together.
+	 */
 	bool use_baco = !smu->is_apu &&
 		((amdgpu_in_reset(adev) &&
 		  (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
-		 ((adev->in_runpm || adev->in_s4) && amdgpu_asic_supports_baco(adev)));
+		 ((adev->in_runpm || adev->in_s4 || (adev->in_suspend && !adev->in_s0ix)) && amdgpu_asic_supports_baco(adev)));
 
 	/*
 	 * For custom pptable uploading, skip the DPM features
-- 
2.29.0

