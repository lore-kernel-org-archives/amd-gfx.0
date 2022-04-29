Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73DFC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FA6110F2A7;
	Fri, 29 Apr 2022 17:47:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4B2E10F23A
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRqDxsf3ID+8I5NZImB716QAR4Bih/yt9JEi51DogRFI5/o8NUWXl3yLyBrmgOEdK80ZFLe6EolFK6T+a1gcKhRPHiP1x1Vq3swiWvl3vpzP2naXWFO1jQIAB+ahG4n5ekiR6dRM0HDdmKvgvHCyQUEARXXkmu+o9DTnxHHxYRI9r9xImo9D0Vs9FrGr7mwWnsfkrzBEov2hJlS9xYOTv1BMdDy5TituPrMSNJadT1mVuq79hBMppRJ++Q02i+X6DUxe3AeDRX277DMrUDvSl9h4rF0QsUAxZ4VhrqBhZLKTZ3iySTDqQEaxdm3j72cqKxKxiBrdVF7Yxnznr6D0VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27TUBESe1CHlf1IFE+5kq5xN61nd9enlr+FqT+1xAHI=;
 b=IC8G4NQEz/IrvBPMXk2aH6PXCfPjPozLQUFsveEN8WZw5mGMCY0wAAL40zil3OC8bVZyMuFlkAa06MXM2WcwZtjENgCJxM+Q0FtP511lCPLDrsqf3DwvNeHTLZ3G4sRKIGqiftmY2xgNxDhw6QdEW0bZqcQkqnHkD7mjDQwzTacqzvgV6cfeZkcx0hHoMLZwIQVZijQqiind24pRwNluKBio/zn3eiquQ3Jlt2zlu7PsrggZWGH1EwKH9lNmD7aUnVX6IAydU290vRN1n0XuPTmXmpPP980RrIdb6V7MRh0dl4qPkOAf3I9p5Ul2MhlcOKVbHICXmh5R3+dQbd2bgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27TUBESe1CHlf1IFE+5kq5xN61nd9enlr+FqT+1xAHI=;
 b=zApu4kkkDN0TshaiHgHGXvkkRtgVZppRCVW08ToLU7Q6m/jzHxMYwI1SjI16BFZUtRteSNpSTni8flGOqHUO54OsZ/nSEeoz08ceE4VmJG08rgvq9gYmRscZ4gkevAooNfMPza4+n0SFxWCGKM2/0rRfPkp6YRkp5iDvXE9WK7U=
Received: from DS7PR06CA0020.namprd06.prod.outlook.com (2603:10b6:8:2a::21) by
 BY5PR12MB4998.namprd12.prod.outlook.com (2603:10b6:a03:1d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 17:46:51 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::c6) by DS7PR06CA0020.outlook.office365.com
 (2603:10b6:8:2a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/73] drm/amdgpu: don't use kiq to flush gpu tlb if mes
 enabled
Date: Fri, 29 Apr 2022 13:45:34 -0400
Message-ID: <20220429174624.459475-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7363482-a72b-4295-1a05-08da2a083e0b
X-MS-TrafficTypeDiagnostic: BY5PR12MB4998:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB499842EF729C59B02A355E1CF7FC9@BY5PR12MB4998.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J5twDKShQEk8BbEhIGfihFYKKFNA3ak/YIO8XahaZbuDXuscCTKuYMIPfWbKo5qVnY1p/QiH+GzRHMhAY0PT1Tvkvlg/ibRioINJGpwS7ziQGhEvZ69W4vFQ3jUxsZP2zSW7s0+LKNITiBpCYKl+k2gS5MiekUIT9yp36hoZnJLU5M4zCHyDPUX6V5ATLicZi/Za2P56BVED+9ZRs4O309hVVRLzbkGH0hbdbHNgpDPV0MYILjKfEYyaJL7qlHJ1M7/3k6MnoHQsvjP1KhJr8xkukQZZiJ6XV89TR6qGnFNG29BwE1ZPvJrbDBw8HFkjLzzF47PSjqnnHAGLVJHns5KEjc3AoCGjyvNn0KVm/ND0UcrFklNmOAH9t8TpZ46mHzJpzNATdtOPO/M9V6qfA890Hr/Mg+6bOSmm1k41vxqFrRZeNeQt0g6QndljYlBIjVfUn6Y+Ki7NHaShdV9JyYf0AqBx3jYVE07KD5evPGw7necWHw7JsCW2nT4hVFauPaQ4CD3MWb1b18z9RrXvWXfAb9SuLDgNB7q4EhUXXl3n9os9J4ik58Fcpt6rlJZMA/soyR6Z0BHfcdUMLr1tZRAS9ibqgf3heK6p1Q33p7gniN9HgrUPLu1sKBYxGFrhL3UIwL2SqSuz27pHSQZI5jN8ti+fkv6ZIK38qWmKehxXcXdh3DlOJ3YKWEF8zOFmcGyMnkZxRrfnw5uPxYjCbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36756003)(508600001)(8936002)(82310400005)(36860700001)(8676002)(70206006)(70586007)(4326008)(316002)(356005)(54906003)(81166007)(6916009)(6666004)(2906002)(2616005)(26005)(7696005)(1076003)(186003)(16526019)(66574015)(336012)(83380400001)(40460700003)(47076005)(426003)(5660300002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:51.4428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7363482-a72b-4295-1a05-08da2a083e0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4998
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

If MES is enabled, don't use kiq to flush gpu tlb,
for it would result in conflicting with mes fw.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 9b4a035a5bf1..b8c79789e1e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -328,7 +328,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	/* For SRIOV run time, driver shouldn't access the register through MMIO
 	 * Directly use kiq to do the vm invalidation instead
 	 */
-	if (adev->gfx.kiq.ring.sched.ready &&
+	if (adev->gfx.kiq.ring.sched.ready && !adev->enable_mes &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
 	    down_read_trylock(&adev->reset_domain->sem)) {
 		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
-- 
2.35.1

