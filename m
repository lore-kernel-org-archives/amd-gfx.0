Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C72E7D0A2
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Sep 2023 19:18:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9876F10E149;
	Thu, 21 Sep 2023 19:18:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0234610E149
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Sep 2023 19:18:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItISTCvTD0CUhiWNJZmMFrZr+DdjqEEyrCFNfnR1VBze9i1+928jCOtzaVIC/La1O0XJPoC8PE+JMywkH+fRx/kUzeX7piAC7gPwvqqpoujci7rkbmLBoVg5VKPAvWqoHF/IEcXZeBtwYKZ6+o3tzaDZhcizTZ8umJ58IUgXDRSDnbUpqOpYcEDFz416N4yJWI+fd2YfuN9KJXWxwu2kq5feEq9QnjvWctrB4U5pry8bwqbNvVd50ya6NiHdN4hz9ELp1Rpl+MmMuaeb8sIICZEFppupHBKHuzfIMjFon4+tZvC+XOaZ2dm5Q0NDtCWwuTSE/gy38zq9Z4U0kHG29g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iomdxFfiatwpULez+TKsXNAul58rGmnPPBeY3nPokQ=;
 b=SM6jcPhqEJkjB5D8g/Zq4UjR9nWmfViYYnGQqdk8173atosg8E7mkdjW0Rg/ofpaoWmRI1fcQ3Jo7APSQ48SwKwMPNtKCsFFtkH1KpjEL/8usJTaQy6WHxuiwISDb6uRBELZ5i1rmIxXKf7yV99VFnIay2yr0O9dgFgspNe9S/6SJG+GQ/NjKTeSQH5r7+G+7cHW8I/tMdWldzdjXzd9vuNi4XLVdzMrYFb76Nwmh9IUz51NaqjnW79XAALk+zSdVc1MaifLVZ3a8MVy/zBsJ63GMQxQAnQ73jG5tTCR4y1cBhp8xWhdwDjHVn/vfP7JNikcJ4injcpJw1QfjuJJjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iomdxFfiatwpULez+TKsXNAul58rGmnPPBeY3nPokQ=;
 b=lJ/+9hZWy2OCi/bKM95rZA50BcrQn6l97g3MMa9MKQ8etmvWj0gmhEFnDGdvL2FPlNTMS1U6Ll8XTUDl5qkEITFVyUf8xgH5J466r8IBbvNTM4iCAWKrLeqXU4o1uWKN4os2ipmHr6NXE+NbwbQJAD2Qg0SYANG+o6jjbPBUoow=
Received: from MN2PR18CA0030.namprd18.prod.outlook.com (2603:10b6:208:23c::35)
 by BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 19:18:46 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:23c:cafe::bc) by MN2PR18CA0030.outlook.office365.com
 (2603:10b6:208:23c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Thu, 21 Sep 2023 19:18:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Thu, 21 Sep 2023 19:18:46 +0000
Received: from david-X399-DESIGNARE-EX.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 21 Sep 2023 14:18:45 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: not to save bo in the case of RAS err_event_athub
Date: Thu, 21 Sep 2023 15:18:25 -0400
Message-ID: <20230921191825.528262-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|BY5PR12MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: 5255c922-2660-441e-a54d-08dbbad793f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bu/ojnveBu6ks43SWbj7sMPdvz4+dbsaxzjPfwmCf+EMz8/O7f7Y/m5L8nvIh6ZJyPz3NGyzBNf/ZIT9XY8T2UbDd18WG9bk0HKQqp+6jVk/p+p1xZoQ9hmfyetegs3D5PtrxwErPOhCmaO5/CCfLYg+wThwoSTSxgbMlwEZu76phK1+VG/fHhQfMwwjHqfsbA4IWKvVgqw3UhJNOQ9VS904HFS/TVUedldeMp/a7PeWELe8cvLl2gmZ1O2AeiLoVpmAosa01yLbX1QeqLjTNHPirKJzkeU2fABykeW7bsIXMJG2B94Daazdlv4/2AHP5y3LSC/gJuWN2Hq/DUN4Tf4VVtD6+c9H+mGsOVyGJDUuhn15IOvj9btf7vaSFGQNJSGwM/6FnbsYGkkIzX2okqNOxGZYhNuiqJ57oUr8+QiNdekZ0xKS7lQh4LElGGI8OsD/j07g1K9xeWFqPTQSpSs/yhNE5UWn0C2RwkLc86rzzm0PEy7gFbBF4sZGHu8gDXEIMod3s+zCik0QbA75AiWhDQA+/5ZnI/wwp/WikHxZulLmq4k7EBv0miPfMjOsXhbUpSDOIBcGnNSZwYJ4IEPJkAMYPm9vXxvAcdWDpwEUm9VUCo3NCCjMJAVrExxFFMCOsQLKthaOuqL5NTEymbwUXo7TVc11rE3kV/ppWgIDiFosDphos8HBsmLxldHXAeQVDvQEet8wgITJa1CHpp/f7LnQh7K4AyUgFaCdkaqdUkvRuMpuEYFbsdhaa8BtiezfXNrk4CYISlPQeI58hA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(82310400011)(1800799009)(451199024)(186009)(40470700004)(46966006)(36840700001)(356005)(7696005)(82740400003)(40480700001)(81166007)(2616005)(70586007)(70206006)(86362001)(478600001)(6666004)(47076005)(426003)(336012)(1076003)(36860700001)(40460700003)(26005)(16526019)(5660300002)(4326008)(8676002)(6916009)(316002)(8936002)(54906003)(41300700001)(2906002)(36756003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 19:18:46.5894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5255c922-2660-441e-a54d-08dbbad793f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131
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
Cc: alexander.deucher@amd.com, leo.liu@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

err_event_athub will corrupt VCPU buffer and not good to
be restored in amdgpu_vcn_resume() and in this case
the VCPU buffer needs to be cleared for VCN firmware to
work properly.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index c93f3a4c0e31..f4963330c772 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -294,8 +294,15 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev)
 	void *ptr;
 	int i, idx;
 
+	bool in_ras_intr = amdgpu_ras_intr_triggered();
+
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
+	/* err_event_athub will corrupt VCPU buffer, so we need to
+	 * restore fw data and clear buffer in amdgpu_vcn_resume() */
+	if (in_ras_intr)
+		return 0;
+
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
-- 
2.34.1

