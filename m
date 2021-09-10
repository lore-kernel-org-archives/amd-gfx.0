Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88E1C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 00:38:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 643DD6109F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 00:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 643DD6109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAD626E946;
	Fri, 10 Sep 2021 00:38:48 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2078.outbound.protection.outlook.com [40.107.100.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F17C6E946
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 00:38:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odc2r33Rc3rBjdhM6Hw0ckotnatppjiRPJMYmV+UdKrtvhaw14okHs5ziT77ZzdKY6mrYQGrxFF5MafTx+8ufFkNZOp2ItVOsnEjABr+93dPJz4tzJCuVew+eYGHxkc/WtfncuEKQHQLRC57sOOxndCvGh88T1X0cVd6PGwEDlt0fV7okpHHOEAt/LOCYXrNvnOhj0cBg2YfClgglsQW3ULiy7HcyizsQ6nRarjfXipusWKmiioLitp/02orSoUrvXkegRUCKEml1T8tv1NQuno75fsLh77Itk3JGkUdqaBmhc0HFZ3Xhycskki4dtQ5OiivY9ayD/uINxsqvep36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=frKYIx4Y+dYMqnUsHuxclKQSVAaxWcR/ovg9Af533M0=;
 b=cXGs1PP7V8DbeMe3z7bQOltTWAJk5P6hePBOB3V4OeMMMfljxZP+FzSNEDKeDbfveK7vQ1ISdht/X14B2qC/SOvnyt8XwZekIacR4qSFD9UFrDYqP+56GYd7a0dnrVXdddZCRk0EprJNblBmMkBaxnYzDBedamOyf9mYuLOijd5cG2bfrsdJWHKRAamDrLpnckkGofInkSnQSno2g69lSjFkMj9LOOuZboEUxC6WIlz8bn/uwBjaFOMlspRxoLaeHy8mfs8gqdHXOFA3+4cBp8Y+FYdKRfwpOqoi2qLBofDCs4LxkiIiVpHKtYI1wlg9eKnakV0tpdcBv8/B6w/gdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frKYIx4Y+dYMqnUsHuxclKQSVAaxWcR/ovg9Af533M0=;
 b=i+zL2JIe5FBip/Wmr+zT9bJs2pbYPtMhrVcRCo9JqsgvqNruJ2Bq9Ce+lQtPp521uQpDtEuoJjUpX9hPNaVJOf2VMHy0f+6jq3PYc6Jy6TYw9NbTF0DcERhwk/SjnU3cL1d3bg5IJcae4juKz+MvNXKerTp7CJnmVjNemDTQA24=
Received: from DM5PR13CA0006.namprd13.prod.outlook.com (2603:10b6:3:23::16) by
 CH2PR12MB4295.namprd12.prod.outlook.com (2603:10b6:610:a7::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.16; Fri, 10 Sep 2021 00:38:45 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::7a) by DM5PR13CA0006.outlook.office365.com
 (2603:10b6:3:23::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend
 Transport; Fri, 10 Sep 2021 00:38:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 00:38:44 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 9 Sep 2021
 19:38:42 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, xinhui pan
 <xinhui.pan@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Increase direct IB pool size
Date: Fri, 10 Sep 2021 08:38:25 +0800
Message-ID: <20210910003828.4013-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f707feb-f374-4833-ac7f-08d973f3582d
X-MS-TrafficTypeDiagnostic: CH2PR12MB4295:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4295349D459D3CB02048747A87D69@CH2PR12MB4295.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rn3vnC7PY4O4DfB+zpZkiX7XtgDuI9cuZKrjhRPS+nnmdLNlS1qwS8FPvNk4hT8ecTQMs5i4+/zzLsrKif6/mgolUdLRDBlbJq3TRzToZNvk8rT0FVGuJ127F9xS4mI26sEo8g/yo4yAdBEHipDXrRmeV+c2yT8SeR+z6IhXuWGCau0SxIKIOs3L3shpC+Pi5qvvQVQWoVwpBPMXpAHDMa3CqF4fXtkTahHwPBrbXtxL5AejmVcgkQUgDRMrXsvJBVHbdBlklKihN6X0SMcJ6IzbTM/J4N6qVMODr/pK4lTZi3iTEWZY80e0bpjRfK8hEwPVw4G6+qGmsAaIg80IgkgufBsG9GdTvcnLDX+j4pKPpF53aPyWT7cc2SXJPm+bdmc3bBI1x15HLoq0I3reTAB0hIgm4J0NeFVcnDbjQYl543yMhiKI7NuawwacbNL4cFqQQCn9egcaE75LsBwCe3BtOy1YfWRVqpsgFSwWUNdnfl9ANlOIrIkidjvmjUZ5Qd3FgJtUn+m6S77uwTOnm+y5BYSzp/vjXqlSj20f5asCR8hfVPeHWCj/SIsV69ZVP9yLKxICHz3K80RYOvpvtPMptYvU2CoxdS+oHKQcZKGDItUfJnKd3RqnkYyE8SB1yjctdYZfk2rpGXg8IhvXPoyPP9z6flvBlUInUAE+PPSlXrWvGlawVaw46P5agpq4P6ETF/qKs7oCNuq3+ouMbB9AMZiCiAtBiDSTOXJygE8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966006)(36840700001)(82310400003)(7696005)(8676002)(54906003)(70586007)(186003)(1076003)(336012)(82740400003)(47076005)(4326008)(70206006)(356005)(81166007)(316002)(2616005)(2906002)(5660300002)(86362001)(4744005)(6916009)(16526019)(6666004)(8936002)(36860700001)(426003)(478600001)(36756003)(26005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 00:38:44.2331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f707feb-f374-4833-ac7f-08d973f3582d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4295
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Direct IB pool is used for vce/vcn IB extra msg too. Increase its size
to AMDGPU_IB_POOL_SIZE.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index c076a6b9a5a2..9274f32c3661 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -307,13 +307,9 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev)
 		return 0;
 
 	for (i = 0; i < AMDGPU_IB_POOL_MAX; i++) {
-		if (i == AMDGPU_IB_POOL_DIRECT)
-			size = PAGE_SIZE * 6;
-		else
-			size = AMDGPU_IB_POOL_SIZE;
-
 		r = amdgpu_sa_bo_manager_init(adev, &adev->ib_pools[i],
-					      size, AMDGPU_GPU_PAGE_SIZE,
+					      AMDGPU_IB_POOL_SIZE,
+					      AMDGPU_GPU_PAGE_SIZE,
 					      AMDGPU_GEM_DOMAIN_GTT);
 		if (r)
 			goto error;
-- 
2.25.1

