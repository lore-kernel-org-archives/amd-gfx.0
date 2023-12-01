Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69855C07E97
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 07:38:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9605810E7F7;
	Fri,  1 Dec 2023 07:38:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D73210E7FB
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 07:37:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTNnhqanpbnOBmSdfDwwas+riq3xEUNyU8yLc+GM+szDvMm5p+YWEaYIZ2tqy3UT2JhpZQxVDnZySi315URnq8uCzs3WtRLPyslSmpyWunqhsEwajvK1EaOvHfkdh31Rrho+ueMx+RrQkXUAy1KEAIhIXebjcMj4mGXY1xbW8QQQCX8oQxqaV8Vj3xfnR58FGUKS+93W+SN7QSFMlCVWJb8MVK7g+VI5cEN5bWogFeGsPfl9XdGcIckR8EZRrsX7acwssXZDngUsj52m2q4ACBFzxcXaFMyvYxkT64uz6OdmoYp2VYt9a2xDJ16zFrPF0FkNEvQ7aDwbt6z+lWdcwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBuWhJB2M4eRAlF/+zmFQcV+DuDzudQVwecFIjYhijQ=;
 b=gTMMUDOIM28+EgQSa5WffvRzN0lkcZjGx1nGvSISjv1gRKrBwqqbqMC1Ig1zH0eLocmebuZG9PAYncHMdh0l7wVm17TrT+eUQgCmPGZnw9ODqCoi3XytIm9HqSnCyo/L7MjBwaBHl3iYiGFYYF0MfxnVedNluZ077NbSBPp2dGVrJUdRW415w9y2tiI5XK07dLmnjL9JnDxmpIfqH8A50CZir1xeNWVtcNKMVKsCGcallDXv0CQaYWnwmPDEOQxRFr7dmowoy9lghARCFn5XyEXX2DCsAN6b77bKUZfmLcmCPkReqBxlAQtOFyE5fh6tdBqRWxRXP1O4DigGE4OOlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBuWhJB2M4eRAlF/+zmFQcV+DuDzudQVwecFIjYhijQ=;
 b=5osPGnC6niBkVUe7ycFt5lbu5qnt3d1pOtYw8EkkZJJg/1T3EnwbHM6zEKECKcG3oGKqdNrDGccCMH8L0uuMoFCwQ68BmJ9rtkijvNJgYU4v48XA75hy9IV72qU+m4/h9ZMe0LSvpDg2odLt1Hrrf9Y8EXL8mt5VrEBew1UlQxU=
Received: from DM6PR14CA0071.namprd14.prod.outlook.com (2603:10b6:5:18f::48)
 by SA0PR12MB4541.namprd12.prod.outlook.com (2603:10b6:806:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 07:37:30 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:5:18f:cafe::64) by DM6PR14CA0071.outlook.office365.com
 (2603:10b6:5:18f::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23 via Frontend
 Transport; Fri, 1 Dec 2023 07:37:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 07:37:30 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 01:37:29 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: Avoid querying DRM MGCG status
Date: Fri, 1 Dec 2023 13:06:36 +0530
Message-ID: <20231201073636.1190113-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231201073636.1190113-1-lijo.lazar@amd.com>
References: <20231201073636.1190113-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|SA0PR12MB4541:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f19c1fc-da4d-4658-9fd8-08dbf2406010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9+PvDP8kvtVMhCIfnGO1tUXSP8SZF0IUZSByoFAiJG5ViQ8Lns2ZT95uP5TwgyaiPvfRdVPnWGBqQpkeW3f3yUrdPBduhC1kFl6RbWeNT+UK+hQ1dyDQA1TdGbBfihscJufnosuRvxLC5E6dK1Tprg8Auvziku67tBqH0P40z6k6PVW0ZnzDbs28DTu7pVtdNK12GATKHpDaUrU4RLE/IINeohPHPknfvSLxTfQip0MU59AfsZGwk4y6t9A/5y1Eq6yTifaOe8q4E2xJjy2TButVMJ3p/lYXYjaOdyEOeozMXGX9X0ddViLRkhxL2B0fo9FdM/sNibzQDd7GuRBqWFSi7WwItOf9cAYfmX5B14qDBvPwh12EBKGI6oynPkMwOeMau8NtIbmtxNkd5iorvW9LzQLRJlqguSok0PjViXAt6+AoILDKfmzCkg2JgZocS5nbWf9yf1jtgkwuI1xKtPtFpYzlop3sdx89TpDRt0CAhiGypXAJ6CdWNtxARyIgVHw8GS9fakXrrMCFH5SelYlcsg+4FTI57I5epJTu0ZO70bhL9C78LY6TW7eA9mzxX1CQCYIdobhwrYXxT/B9ZhNWz04ateMnjpk1yqiKJcC/toqNSKZlRoW0Dn7VYZxoxHBYklpVheWSYi2ygqt5zOoxansaubaa+p86E9noawoN4+0b1Vo4hUyfbbkNjRGYAu1JQTn1CAtrZWFOGJZ7HajjgA0HdSeUE7PObfDJVPGKQj8aAafjV31Tbc3EA2bAEiFDZrJS5x++pVOiXGR3vQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(46966006)(40470700004)(36840700001)(7696005)(1076003)(81166007)(47076005)(40480700001)(356005)(82740400003)(83380400001)(26005)(16526019)(41300700001)(36756003)(426003)(336012)(36860700001)(2616005)(6666004)(5660300002)(40460700003)(4744005)(2906002)(54906003)(44832011)(316002)(6916009)(70586007)(70206006)(478600001)(8676002)(86362001)(8936002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 07:37:30.5806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f19c1fc-da4d-4658-9fd8-08dbf2406010
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4541
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MP0 v13.0.6 SOCs don't support DRM MGCG.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 9043ebf1e161..15033efec2ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1430,7 +1430,8 @@ static void soc15_common_get_clockgating_state(void *handle, u64 *flags)
 	if (adev->hdp.funcs && adev->hdp.funcs->get_clock_gating_state)
 		adev->hdp.funcs->get_clock_gating_state(adev, flags);
 
-	if (amdgpu_ip_version(adev, MP0_HWIP, 0) != IP_VERSION(13, 0, 2)) {
+	if ((amdgpu_ip_version(adev, MP0_HWIP, 0) != IP_VERSION(13, 0, 2)) &&
+	    (amdgpu_ip_version(adev, MP0_HWIP, 0) != IP_VERSION(13, 0, 6))) {
 		/* AMD_CG_SUPPORT_DRM_MGCG */
 		data = RREG32(SOC15_REG_OFFSET(MP0, 0, mmMP0_MISC_CGTT_CTRL0));
 		if (!(data & 0x01000000))
-- 
2.25.1

