Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFB4C47258
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 05:59:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF512113952;
	Wed, 31 Jan 2024 05:59:36 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 990A7113952
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 05:59:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvZAefm/saLg7Aa+Dlu5/JqosCDK/Gc9dv/XGNzdILP+1LMLYPbYYuilSsVRTF6ZwOPddz3K404xmjqQIjabflJ+zkQIkC1Il4JNBZzbwyoiiVrT2v8hWpNeYh0NeGuOOyDWusN9FvuqCG0WbeFKFGHwjWUf05sjTfMFtQAwRuKePA96nGkxiqPeXKvck5mhL8OCyATfCnHE2qJOI41d1b4xnNkDrREWlUX1Fin9TUck+03F3IeE21J2AkMS/51UtjLEYFkPiAsmhAFw5zzwiT6TdJ+JZjcajXU3mnMoW49kwboazqoRuhhwom+fUaoGPAiPf6WFxxFLrazZ+sgpNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYGCXdTuQShiueDCpojTVbzkotZNqHSHplR/MnEC6LM=;
 b=jC3CXWNXMZ/Xyez9VglZCwpEY8MclXtIsnW/0gcBNYUcHThwj14S2HFpomt/EtazAqTbZZkbSwnb43BpMg+r/KWOsGb8gIQ3jQMo6G19jggFLQ30A6Gb4hNI2Q/HpSoCNP96Dq1UB3ahzHQQRuI7jaaEzXMRGcx1xWS9SyUwv8TNU/7/3NrFbnk3lyrzOEzVi1UgoRlNZY3eWb9sIAyTlbt/jzQElIgLL8jPbjPVoDCicDKXe/Wg9rcCw0aoIKrGNWdRdT4DnnviG4FoVIfuF0uYYaYDUe3vJPd3115Y3ZIjw8xKKM5ba2RPzUDAJsO8bIl0TTgiG0qZvqkOfHSqYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYGCXdTuQShiueDCpojTVbzkotZNqHSHplR/MnEC6LM=;
 b=UvURIAZb8eIMtoROm1SIb0oKaQ3YeQpdDD1Z2omFUSEFhXbfgGNJpyDoNgemyM1fAqaJqgO7J9tva3e4lqE1I5ODf+9xOadTQ6Z3KN5/lvGdgVi6VAmUip7gsG04eXSal/qg3T/my8fk4a2Y2nJfK81LHv2/YGRoDXFlIJOO94c=
Received: from BN9PR03CA0122.namprd03.prod.outlook.com (2603:10b6:408:fe::7)
 by LV8PR12MB9083.namprd12.prod.outlook.com (2603:10b6:408:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 05:59:28 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:fe:cafe::b7) by BN9PR03CA0122.outlook.office365.com
 (2603:10b6:408:fe::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Wed, 31 Jan 2024 05:59:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7270.0 via Frontend Transport; Wed, 31 Jan 2024 05:59:28 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 30 Jan
 2024 23:59:26 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/pm: Use inline function for IP version check
Date: Wed, 31 Jan 2024 13:59:03 +0800
Message-ID: <20240131055903.1454962-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|LV8PR12MB9083:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f0a1ef8-2b6f-4108-de0e-08dc2221c945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k6JQMBh5JQQSfzOMb82nWVRqz2sMpmE3e1FlVW9RTkgsc9EvE26r8y2JQqzfHVjFKmgQvJxS6wXL8qLL6IqcCTChZ+YvFycr2oVYadCSnLwDTmTBfunhUkdLWjqOvDhJ6WhCgxc1PHlX1mge2MAoEXBTALAnbFApG+rsA++pF80su68Rw/wteEdp2Csq9Y2teaLAV0i4fTeIolsmHCWgUNQwdpB+6SKkkVcL2XQsMd64une+WdwRVA0UpkSVIu5fuYqg/R67LfOc3BwhHqTxRYHySbjCdhzo4sbOv5cvqrgRrMvpXce31pjjAfRoUB+2oq1dNfW89uWIrAvIPihpzLVHgL9Q7HdFJHkz0iEunFKYmBcPN+OdG2DtOgAF+Bh7lBEKGdSVP9tGbTUm/PLdTY9VxW4Xq/wVlccn8OWfuKJan9GE87Y9hjMlaRutKBUGsjFGZ0iWCICF2E0xgCy4WdKHTJ/Sw4LCZyCyBpCvAo+bYbhSG8hi/eTz77Z2gzlID4Gj8zYT6s1kr1G64muMytDMEOWCdIdGjHogO4mUoWI7UYs1/B0YsmfxqmiOCSFJ7gkBaHLlTAGwA4FC6pDm0l3uRvPmHZzvfp1/2Mn1dxN7CScW07KEAiww+xgqjVNfGte1gmY2DDcFwHVcwYknTAwfQMLX1yBUB1LMTBUcIS4K3h95wgeVp0F3DDFIrGNG92++JHJ+49+FnaUtnLoNTLNLwuvy2tGCnvRCkiiLR7DbRP8ztspx2cpn4C5o6YuwtvbAsCscS9kAytsfW98Csw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(8936002)(8676002)(82740400003)(26005)(4326008)(7696005)(47076005)(36756003)(40460700003)(40480700001)(316002)(54906003)(6916009)(16526019)(70206006)(70586007)(83380400001)(5660300002)(356005)(4744005)(2906002)(1076003)(2616005)(6666004)(478600001)(336012)(426003)(81166007)(36860700001)(41300700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 05:59:28.4894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0a1ef8-2b6f-4108-de0e-08dc2221c945
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9083
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
Cc: Alexander.Deucher@amd.com, Ma Jun <Jun.Ma2@amd.com>, Kenneth.Feng@amd.com,
 kevinyang.wang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use existing inline function for IP version check.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index bc8bd67c48ac..9c72c36260ff 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2944,7 +2944,7 @@ static bool smu_v13_0_0_wbrf_support_check(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	switch (adev->ip_versions[MP1_HWIP][0]) {
+	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 	case IP_VERSION(13, 0, 0):
 		return smu->smc_fw_version >= 0x004e6300;
 	case IP_VERSION(13, 0, 10):
-- 
2.34.1

