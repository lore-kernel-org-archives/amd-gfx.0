Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A9FC001B0
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Aug 2023 22:06:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4BF710E134;
	Mon,  7 Aug 2023 22:06:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EC0C10E134
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Aug 2023 22:06:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNMpB0jjbqi43IYuFvQQYApk+a1aCnPbyqqADyjkOU6BBR6X5muFsi8vmFY8iw1w51N7LpNwaxHSKsEXTvOJn4JUynWkxLJP13cGx15qYcwDn03hoEl4EAC6qcv9DrDNGGfm6PW2vr2XQMaGESUof4YKpT0kWuthLA+wNsuNWSPEiyO9LEy8ddk5dtjZUQha6TE8zzHwf0pTLEl4Vt2BfRVqbOyLj5ZnCMq2iy84Bevx22hW2jXMdijFAshbrrV/MX/UbRxdCilbEXP/cW6wMU6r4HFY4C5VUg7gLbiPHEW61xyyDyAeDjFYf1S7M/+XpmdRlPvIRfHNommCnSBkPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egItifF7JHL9JTf5Mu2G/mTWjBObxwTYTDIOgg3g1fc=;
 b=obyOEjQg3rAlWxFxWhLDjG7Gg32XTBi7BopTd2ro5E2qjz282Lx7B/mOSu6qWgWov5/3YMiTy6MHgPgOp+P0jynqpB42lInR8AP1YmD/st3jbCx48oJ14ihcWanSe3wEVopv3QQraCiqOylKgpMBy2+3NCQL2JsdqLZ69YZ8CsNMtO/46nrCaJy6eW61NsHPgwFyxE8YJ9IC2UG75TlqN6hAPUUiAuG0ulgNAxDUn4bPr7Fwe4NZdbuiZaja44tdpGBjYA+wRdXZWaVxOE8+bH2omSol6ViMI8CG2r+09RHX/UYJNxq6rKSfOneyp1rGYsgR6i/lSq7z7Zi4RfUDFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egItifF7JHL9JTf5Mu2G/mTWjBObxwTYTDIOgg3g1fc=;
 b=Os+SZx2WrXCBET86ZZV8KRvVzkpR1oAFUrghoJn2Ols8xALYEXBEwxHrKTPMot2W9cwRlDxwshSXzEJxca8agzz89Z6ILjqEjVwnCBmp4R9UPyuFMn8SNgyuqrSA/L6qZvjRg+NVh/DdFlGuCurqLVvmjGdAG3HnhlxPZCoKf98=
Received: from CY5PR16CA0006.namprd16.prod.outlook.com (2603:10b6:930:10::35)
 by SN7PR12MB7131.namprd12.prod.outlook.com (2603:10b6:806:2a3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Mon, 7 Aug
 2023 22:05:55 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:10:cafe::32) by CY5PR16CA0006.outlook.office365.com
 (2603:10b6:930:10::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Mon, 7 Aug 2023 22:05:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 22:05:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 17:05:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 3/5] drm/amdkfd: disable IOMMUv2 support for Raven
Date: Mon, 7 Aug 2023 18:05:43 -0400
Message-ID: <20230807220545.1320198-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807220545.1320198-1-alexander.deucher@amd.com>
References: <20230807220545.1320198-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SN7PR12MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 93465b6b-7f32-4aa5-7943-08db97927aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Pk8ZSIZ548s+q8P6McZgzLauVjon7BsSRITAFGp29l+4LwQy36QLmySpBRdicfs2cKMsuNJczWy09FTj8xl6I4dQsdJaNlSTpPeNfaDgfwUIl2mzVAO5LpXAuowKciARDBLTW/4uuFsZv3bPSe3Pc6fKxspWZ5sZq0lB/1eObdwyX/RD0QkLf2go/5XYzQFwd91jd6jyAs0QEGOq4TUxUl78HjrNynOW4UKpiYitWLj9F3uJCjVnXmhNkURpSvnd29QWyIZ2lFDpeqmukwaMze14xW6KGnDRlWRQOmjH9xYa0/VPuF1Z5II4fSim1UpbibMlKMJ6CrwplIk59FrgyTtU4vFI+/05KEfdGhYHXxOfFZsfKxWZFHvbVJrWDovdfosPHJhdB/XsEgfDIXJppoKe5UMvWp2s4epiPl2idqEYRg/9ZpXwqP9RnUNMpFtkmOcRH/uATe3SQfaBliQg9TyAnOMzQ7F8Sw6wqY1GnYIjCHcTjAbD43Z9cKEpSS9hSkHuqpiaavLbsiv7pkRi8J5IUa4jnIx6rJ3RgrBiGxF+ydHmMWULm9ugPS+3R8Nvp1BwGv7PVWktgkHydzo10hyt8aBUjHUxQ/gWWAo/dzGAfhpzLE+XNPfODxAltvtDPLShbDYhQNTqOS89Q5GQphY3K3+Na9iPTzOxzlHl8bC9/3mZtWDd6chQeqJLqrDCnx/0SEYZnvkr+AjmpLqdO9LrPLt7CZEwKsGk7qOejNXCEh47t2R6ZC55WuWZ1mMoB5KRBcn4GZza91o4s5tug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(186006)(1800799003)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(47076005)(6916009)(4326008)(2906002)(70586007)(70206006)(7696005)(336012)(6666004)(16526019)(83380400001)(5660300002)(36860700001)(41300700001)(8936002)(316002)(8676002)(40480700001)(81166007)(356005)(2616005)(426003)(478600001)(82740400003)(36756003)(26005)(1076003)(86362001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 22:05:58.0869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93465b6b-7f32-4aa5-7943-08db97927aa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7131
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use the dGPU path instead.  There were a lot of platform
issues with IOMMU in general on these chips due to windows
not enabling IOMMU at the time.  The dGPU path has been
used for a long time with newer APUs and works fine.  This
also paves the way to simplify the driver significantly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 44d87e04677b4..c5f5efe08df40 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -195,11 +195,6 @@ static void kfd_device_info_init(struct kfd_dev *kfd,
 
 		kfd_device_info_set_event_interrupt_class(kfd);
 
-		/* Raven */
-		if (gc_version == IP_VERSION(9, 1, 0) ||
-		    gc_version == IP_VERSION(9, 2, 2))
-			kfd->device_info.needs_iommu_device = true;
-
 		if (gc_version < IP_VERSION(11, 0, 0)) {
 			/* Navi2x+, Navi1x+ */
 			if (gc_version == IP_VERSION(10, 3, 6))
@@ -293,7 +288,6 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			gfx_target_version = 90000;
 			f2g = &gfx_v9_kfd2kgd;
 			break;
-#ifdef KFD_SUPPORT_IOMMU_V2
 		/* Raven */
 		case IP_VERSION(9, 1, 0):
 		case IP_VERSION(9, 2, 2):
@@ -301,7 +295,6 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			if (!vf)
 				f2g = &gfx_v9_kfd2kgd;
 			break;
-#endif
 		/* Vega12 */
 		case IP_VERSION(9, 2, 1):
 			gfx_target_version = 90004;
-- 
2.41.0

