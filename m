Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF98C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 22:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1445810EAEE;
	Wed, 26 Jan 2022 22:58:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2664410EAEE
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 22:58:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYJnOZu6weBEzNQ3xH7CH+kGOJTo0c5ckiLLlu5KzgSNpZGu5KUuq22B6nOPzQGEZ01kUGg8DdlH5xAXaqAEL8G8ZzFwOyyH+BFU4Rh9TaBZZN6YWJUztPgUo9TtkYKDze+cijOMu4baeoUhrjlA4P/FSLIp515z2Ev8vxenzfuDmoGqp48h4N3WM+XdJikNQmGcfi/rRdEsKEwGAhfJgG7gYEMsKZcg/mpNPZlzFVY9sBMyJRn5kjUIHu3xtvRUBP9h69vya6DBFgGXeLM21v8epcw+yLBc6hJuwXghyp1mEE5wQMMwEbEtr4yUfO/EBlSljnuVyfmBdyPzJ/eiWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mj9+GHiRz0QiM+FBjsdjQ3NE3x9Z5X0N+d5kpJ/gnPA=;
 b=imAer8XQRCuXVtZ1J9g/xozcphgQ73g+C0+7XDQl7K6t0A/7mzvdpKrYnJd1ha3cRzS3itA+yEQRskjLGJvO+HEjhnvDgIVICcihz4ASlsWubqFDXi2db77g443Q2IesP4nwp7VJtjKoMNzIXK1whN6vy3jbn0emqaJuxwcHzeadW++T9DD90LCV03ei/zpLLzi8AFCOdxql1YsUxsQaRvHhhzfFMsv0RP8wocWIIJxHgkZnNb2E4ESsVSan0MY9GHEI+0yF+5N7FHqIkJBpB7rZ6Ph3EdOMo31yOBCHywCi87de2bp1b//LPBOZ12TtMKbCu78NOO+6pHDVrr1Ygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mj9+GHiRz0QiM+FBjsdjQ3NE3x9Z5X0N+d5kpJ/gnPA=;
 b=FNHmc9mUvmtD0TKiF1rmvbW5cifN/DcK2xk1ubiKZJ/fAFIf2fsTxtJa90yPkJ0LnKF8mDIOFMggbTbtsdOtskokwnUtHJgruceyJxMvSr99uPdSeX4hbMY87SRDoD/mqACMj2VGo9Ut3nOacz1KFMq2XPeM9e1KsyPhUyQh58U=
Received: from DM5PR19CA0014.namprd19.prod.outlook.com (2603:10b6:3:151::24)
 by SA1PR12MB5669.namprd12.prod.outlook.com (2603:10b6:806:237::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Wed, 26 Jan
 2022 22:58:24 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::d8) by DM5PR19CA0014.outlook.office365.com
 (2603:10b6:3:151::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Wed, 26 Jan 2022 22:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Wed, 26 Jan 2022 22:58:24 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 26 Jan
 2022 16:58:21 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 4/4] drm/amd: Only run s3 or s0ix if system is configured
 properly
Date: Wed, 26 Jan 2022 16:58:31 -0600
Message-ID: <20220126225831.16732-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126225831.16732-1-mario.limonciello@amd.com>
References: <20220126225831.16732-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7a251b9-5c0e-46bc-ac0b-08d9e11f5b44
X-MS-TrafficTypeDiagnostic: SA1PR12MB5669:EE_
X-Microsoft-Antispam-PRVS: <SA1PR12MB56696AA5FE48933A0504405CE2209@SA1PR12MB5669.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pbmYDxLbIKWWn3amALgq+S6+eXoPIEs8utx1QgM8DAjZKQkeQ+5hUhauQ1TStvXwHb8AnLJpEAT4ONEvZuSF4jgswB1s4Ho3TQ6DwaAqjye7qU3DApzcjby4NERelAOT1I2DDsZjuisanBf3OniPK3zGmn0sIr/p92TB66qUzI/1qwjGAhhQJHDM2anx8vcX2eIIQl7WYqlUmFcIru4ZQ3VCUNbAiTczLVEa2KkEgd7RAV/6Xi+beeOUkudNxE5iIicTAO3OHOaWgjh3LrI/KD0m+vQlAH6VtYgJ2ZHzjrNKn4iHPgTd2lYJXruHHZgQjqfx9ZSZTJCf5XsB/TNSA0qA8BpjT60SBw8cCMmKYatrz1IkxeviEjhXtcJiJNEOdGjTX368g0qmxzAOekGcJWmWxQOHFAJV3S1dYmotyofXqTd2N2H5KlTECE3hSz9veXorw5ecKZD9nfMFK9En2iLDeSo5xHUzEioppW9nFPIYbSO6CYdGYnAqcISpZykX7r8j9eEHEZ/MPs+ANIdbazbTZ1iZti5IuwxCA4De6AWOinhxzUGUzggjEzqC6r59a0YRxomNn7/srTL+T2/7F4XbKhKDfBvl6w9zzKodKm++CyQG0t63gKGcw2TQnAjmz2ro6pPtIzyPgXd2OI25YeS0QfTAzvfMzR+feWJDbn+j4SzdDZYaOTG4aJCoRmaD0DPAlOHMWO2FcJCdcmsLbVwNz1bI2lKFt1oSu2tJs5hW/eQZjnSK+mm66Yiz24Cv5UBiG2xN0LjwxOLSU4akcfIcPPEbxCZZ38lfW5rZtqap9Ga2XFlHbqZT3zocV+cAaA0wMP+hSHSbH/EpCh4ZBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700004)(46966006)(4326008)(16526019)(336012)(6666004)(86362001)(356005)(40460700003)(81166007)(316002)(36860700001)(426003)(7696005)(83380400001)(70586007)(47076005)(44832011)(8676002)(186003)(82310400004)(36756003)(1076003)(508600001)(26005)(5660300002)(54906003)(6916009)(2616005)(70206006)(2906002)(8936002)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 22:58:24.0005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a251b9-5c0e-46bc-ac0b-08d9e11f5b44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5669
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
Cc: Prike.Liang@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This will cause misconfigured systems to not run the GPU suspend
routines.

* In APUs that are properly configured system will go into s2idle.
* In APUs that are intended to be S3 but user selects
  s2idle the GPU will stay fully powered for the suspend.
* In APUs that are intended to be s2idle and system misconfigured
  the GPU will stay fully powered for the suspend.
* In systems that are intended to be s2idle, but AMD dGPU is also
  present, the dGPU will go through S3

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5->v6:
 * Move code into prepare vfunc and use DPM_FLAG_SMART_SUSPEND to skip
   suspend code in incorrectly configured systems.
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 922accdd4246..3e581f35f19d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2289,6 +2289,7 @@ static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
 static int amdgpu_pmops_prepare(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
 	/* Return a positive number here so
 	 * DPM_FLAG_SMART_SUSPEND works properly
@@ -2296,6 +2297,13 @@ static int amdgpu_pmops_prepare(struct device *dev)
 	if (amdgpu_device_supports_boco(drm_dev))
 		return pm_runtime_suspended(dev);
 
+	/* if we will not support s3 or s2i for the device
+	 *  then skip suspend
+	 */
+	if (!amdgpu_acpi_is_s0ix_active(adev) &&
+	    !amdgpu_acpi_is_s3_active(adev))
+		return 1;
+
 	return 0;
 }
 
-- 
2.25.1

