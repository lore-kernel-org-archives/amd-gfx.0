Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9484FC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 12:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2722EA6890;
	Mon, 25 Jul 2022 12:23:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAC7EA6890
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 12:23:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpDAlBy3D3L+cdfmO0llNHi0vIUQCAFSfvrWjIWK2qCwZQrD3RpUMnMoILraYaHaizmyk7/eJD8myP7JizqmkYLcEXsXTGMm1B0zsqbkqi2ezp1MM4OmgVfwf5llKneRj/aXCvWMRPsA9a1LxRf6g2IH8a3jsZemY+cuNpCwZuBhDNQU8Kx3rnA0MFA3IQr2ui62XYfWjgCGag3xWm0zbKPHmJkyEXwcIWmZtLSnoaFCFzq5pCK/r1obB/Q4Bb4MQXTnpd3g21dqrBFf47h975bLBCiliLEQv2lG3VGznwQabNv2VQFIeCJGuCxHlP4HHH0oEDa8RhihDCfT2IBnxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0prnVKysK1wP8VAdweh+XXA8kPbVWEn22Fk0GQhf+g=;
 b=JI2ycIHlThrZB1cpBu6nCwkAYswxEhbzKCs78eR3xkAhLuuyXph9mOL3jT/uaamMpsYdBwzqHyTsQjzz+hT6Mo66607La3/QsoDRcPXZm2XPzxjXcIcRUmvlpt25PpeMVpBxnzyJQjXXWKMi5+2GPoeJzMfGPRMZ1bEVQAg7HbhFCEcUWM/C04Gh8C2JjoWD02PguZyht7q+hJj9NZP6aUP1d9D8bMd4UeafXwhYCfYK5rHWeubJlA4nEBAbZ2n3Ie5MtNVXO7PtGfGwFHdrXOVPk79TecaffR6aOeEJ0Bs+mflas+IeFGzMBRMXBsxS915LtPLKn/XhF0gFWunAWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0prnVKysK1wP8VAdweh+XXA8kPbVWEn22Fk0GQhf+g=;
 b=AY0P/GatDUTVv9P7Ne0qixunzFOley/4j9TZtr3Ma0e/f357EfAmGm15HYtMr8CACYNdLldeykwm0/VceY2M5Q+ji4aPedAWuHev1DadlJHAPNGrEkZ9J2SiN9+RHGXCqZ5SWeQSfejZYqUkhnleVUFz6ieB3PVfMuJ6uz2n+1Q=
Received: from MW4PR04CA0053.namprd04.prod.outlook.com (2603:10b6:303:6a::28)
 by IA1PR12MB6650.namprd12.prod.outlook.com (2603:10b6:208:3a1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Mon, 25 Jul
 2022 12:23:53 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::40) by MW4PR04CA0053.outlook.office365.com
 (2603:10b6:303:6a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.23 via Frontend
 Transport; Mon, 25 Jul 2022 12:23:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Mon, 25 Jul 2022 12:23:52 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 25 Jul
 2022 07:23:51 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: Allow TTM to evict svm bo from same process
Date: Mon, 25 Jul 2022 08:23:15 -0400
Message-ID: <20220725122317.24606-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3924cb9e-99e9-4022-4731-08da6e38898a
X-MS-TrafficTypeDiagnostic: IA1PR12MB6650:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k5vA8nX2TnMA+HZ0l+mzf4ja+lOwGfPJNP21W1sP8VOBNqsbhKDmLH4+UNkawGmkZJ88JOADHdgHWsZVz/gm+mc7oqqoqEo2Q8edYhP3X8woSY9fyhgr7RW11HmOsG2P0r91cSQT6MoNjfdcttaz25s4jVnzwkrnubybTkpT2LKXx74V8Gl4y0bqfFkpbWvne6k14N56B4CjNkQ0SHJgH8uavtWVlnGbSxVXUitR9PENFC4peHj+Rr5OfSB2sy683Zdoyis3pIpkUnJfM5r/GQswDUVWip1Y+lUl2M3gk4+z0sTcVA5XHDTz2wG026ynDMqXW0REwktynSJBHNi8UJ04KQvRUfIbKrPwy+VMB5HyK9/ZAMEumYRf8CAuNZA6JsWxB5Acmw/yDlpjlDSGHbCkqlb/Y0NakUOA6uG+QLluRIece0jlnpW2owF5WunGASKeL5ii6bgEL/lHzx7F80hJBMkBmElEVkCvIZ9gtpzFEhWMdRWvxNz1QDMp9uFmDbzlgCxcfTAhSpZM2ulKr0w80CntMsrdXca3oj8vnTPvYb42vGqNWkZdtcP3vmU8mgFALzTWOtqabQ1R28JHa5tbqsQOCmV6RnWW3pjqgorrOfcu3zdSiYcBHaRdHZHnNoT8PWQ71PwTNHrTuh8+eITQRLZsSmxz4eBUTBSHMu4tlXSDV/LSDWm13M4BWZpfelq3BYoF028nHwfl8lKZDJeV/k1dHvmb227ZoBeJzV+IgNZfeFPo4/0yWMq2XFy6pM747C8j8qd/ldp3POev7jTHQGB7l8y+b3O1cv9/DmH513o5KQ+KAquWhpQBfMFL+3xmAeDWOcH/ocB1JqA3eg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(396003)(40470700004)(46966006)(36840700001)(54906003)(5660300002)(8936002)(36860700001)(6916009)(36756003)(41300700001)(4326008)(70206006)(316002)(70586007)(8676002)(478600001)(7696005)(2616005)(186003)(47076005)(6666004)(426003)(336012)(2906002)(82740400003)(1076003)(40480700001)(83380400001)(82310400005)(356005)(81166007)(26005)(40460700003)(86362001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 12:23:52.9236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3924cb9e-99e9-4022-4731-08da6e38898a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To support SVM range VRAM overcommitment, TTM should be able to evict
svm bo of same process to system memory, to get space to alloc new svm
bo.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index 1d0dbff87d3f..e8bb32f4ca14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -159,11 +159,14 @@ static void amdkfd_fence_release(struct dma_fence *f)
 }
 
 /**
- * amdkfd_fence_check_mm - Check if @mm is same as that of the fence @f
- *  if same return TRUE else return FALSE.
+ * amdkfd_fence_check_mm
  *
  * @f: [IN] fence
  * @mm: [IN] mm that needs to be verified
+ *
+ * Check if @mm is same as that of the fence @f, if same return TRUE else
+ * return FALSE.
+ * For svm bo, which support vram overcommitment, always return FALSE.
  */
 bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
 {
@@ -171,7 +174,7 @@ bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
 
 	if (!fence)
 		return false;
-	else if (fence->mm == mm)
+	else if (fence->mm == mm  && !fence->svm_bo)
 		return true;
 
 	return false;
-- 
2.35.1

