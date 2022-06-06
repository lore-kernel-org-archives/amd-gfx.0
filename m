Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863F3C43334
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 03:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D86C10EF79;
	Mon,  6 Jun 2022 03:11:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86EA510EF79
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 03:11:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5XB16S3km5zsxYzW0pLkxNSWxrtprCRL5Jcu+Iknurni2qVdfd85fd1JWjmkNu2lagOapMXJPYcTeNZUhNmRIVc30HDdkHPnvQSjDQZrUxM/zJKKOWZqCJqXGy25jTtfM5RPMu5Of+q+Khp2q+Md3hTMsZ8hVN7k+YkrqFblNehDtEmCTTUFSWa1+AQweF37p5RKEOByf0rJruMoR/3Df/spA+63r+EivEU7vVM6oVn3pBCJVSLwqgXnUwn5SoJQNxnKSI/Iu8L+l6qXqCg1yJEzLTHTbQA1c+CBVpxwH6ZWzRPdUTSm3O65ewuYgC/9vo7+R1yLTGebIboS+UQZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0YSDggyawQcuMqAgm3+5Nk2Ju8WqgeEAB/VvXRV1yA=;
 b=N3wU5SsIsiEJfOHd0HMj3eMM6bSvzPjfcJHWZKju/Px2BX49+kZX1RLLMqGoX5O3RlkspDvAELlyD9vnhhkisUEZIpbrEChunMAvrYAwZyi60ygmuh+4wqosCu2qH47ozRM9YG4GpV6IunYUzdDC9pEhoVdXKsThTjLE8mDB6jV0z+DEp60StFpSqPpdYBotXG0OL/0ZmrbG6RSqW8KlpoZoI6JkWTxC8C+s+qVh9r4TlqBfwEovasqGJ28/x+RrAD9sWjlfqI1SK0jJNRjMHSNpwClKL1rPN7FQ5zh+SHRTeS+ovgYc40j8ZvVcdTPhLqoM4PX4bbNhzs7U+f3VDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0YSDggyawQcuMqAgm3+5Nk2Ju8WqgeEAB/VvXRV1yA=;
 b=ywrYjJ3nRCAX3iYKS6CS8Xs4850NcckiCLpyv17Uu7ZTZHEWtUOaoW36AOEZJaGuCCdlb2lzyiK4JdrURGXePPH+iuuLFGL1QLV3jvj7tOkbyLArjxma2mJmskURKiHdOyAgcFXNsNM56GsPthH7rq0dwwRu2hixi4tQC5sAtpQ=
Received: from MW3PR05CA0010.namprd05.prod.outlook.com (2603:10b6:303:2b::15)
 by BN6PR1201MB0209.namprd12.prod.outlook.com (2603:10b6:405:4d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Mon, 6 Jun
 2022 03:11:51 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::d) by MW3PR05CA0010.outlook.office365.com
 (2603:10b6:303:2b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.4 via Frontend
 Transport; Mon, 6 Jun 2022 03:11:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 03:11:50 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 5 Jun
 2022 22:11:47 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 2/6] drm/amdgpu: avoid to perform undesired clockgating
 operation
Date: Mon, 6 Jun 2022 11:11:20 +0800
Message-ID: <20220606031124.1818265-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220606031124.1818265-1-evan.quan@amd.com>
References: <20220606031124.1818265-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5864d5a3-00cf-4314-f7ff-08da476a4c94
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0209:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB02099D4F5F4605BFD79E37F7E4A29@BN6PR1201MB0209.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P6AydbpOCPaynl8he2Evgxs201D6PDaR9JiacfUbWP3bJYqnmoqCeaTyDF1bqhx1UidUfGO1BkaET2EWbqv4tb4vaqWZ8mwSBiCRoqHuU9uwVybC0HuAOEGLOLozE8B8Pk1XGNLQjYZ86OZyIWmS9I0TE0xgdsskn6eKX7uMqAW2zYSb8OlzMp2HKyE+3uW2dflmXNkm6wgkcz0nXIMO3YixV6UoUleHLVIy+gbDNNbIer1MmqH4LZo6KWb/K+q/cevsAoU/xvb9VLV9VNoJ2oqENm3GYTitL8mTh2gMOtXKbnM0ds0vKnBK31uh3OaTL//slKSIVBk9cbhUGVMvJSo8JCwYAN5+iXPNM2jLeEQK2dkyNXars9NB8ASp2uarR2hdXMyuUyUDMkEjSrL7ZVUb8PRlGDH+s2AfDkU7CWbTjbP8gAFJoREsy1ISqxsHdCPq+ksARrivpDKsLOcnIyK3wuctOeor9ntudTPwvZ6JSNXcFaK7rHQikwLelelylaczcgeP90fSJId4AgIieSdqOX/lUi/8yp8sztATxzB773pAY5xN0ds0zmje0sdVIlnrU2Qna9Rx/SBiAx/6KOWjaua8gAu70UJgItKPz4szaQU6ofMv24tfj802HXsFJm6NLWjcb3/rza73kI775yzZCJmJdpVX06cbuxqjKM/lNOR/PemyEHSiuplWxWAf0Xx21g1AYDUVSf/JJYmvDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(5660300002)(47076005)(426003)(336012)(6916009)(70206006)(1076003)(16526019)(186003)(2616005)(8936002)(44832011)(508600001)(26005)(7696005)(36756003)(70586007)(83380400001)(82310400005)(6666004)(81166007)(356005)(86362001)(36860700001)(316002)(8676002)(4326008)(40460700003)(2906002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 03:11:50.1408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5864d5a3-00cf-4314-f7ff-08da476a4c94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0209
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
Cc: Alexander.Deucher@amd.com, Likun.Gao@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make sure the clockgating feature is supported before action.
Otherwise, the feature may be disabled unexpectedly on enablement
request.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ie20e6c5975c2a0af40dc52189e3df97161300117
---
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
index add093b9aa79..35894ee92dd8 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
@@ -240,8 +240,11 @@ static void nbio_v4_3_update_medium_grain_clock_gating(struct amdgpu_device *ade
 {
 	uint32_t def, data;
 
+	if (enable && !(adev->cg_flags & AMD_CG_SUPPORT_BIF_MGCG))
+		return;
+
 	def = data = RREG32_SOC15(NBIO, 0, regCPM_CONTROL);
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_BIF_MGCG)) {
+	if (enable) {
 		data |= (CPM_CONTROL__LCLK_DYN_GATE_ENABLE_MASK |
 			 CPM_CONTROL__TXCLK_DYN_GATE_ENABLE_MASK |
 			 CPM_CONTROL__TXCLK_LCNT_GATE_ENABLE_MASK |
@@ -266,9 +269,12 @@ static void nbio_v4_3_update_medium_grain_light_sleep(struct amdgpu_device *adev
 {
 	uint32_t def, data;
 
+	if (enable && !(adev->cg_flags & AMD_CG_SUPPORT_BIF_LS))
+		return;
+
 	/* TODO: need update in future */
 	def = data = RREG32_SOC15(NBIO, 0, regPCIE_CNTL2);
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_BIF_LS)) {
+	if (enable) {
 		data |= PCIE_CNTL2__SLV_MEM_LS_EN_MASK;
 	} else {
 		data &= ~PCIE_CNTL2__SLV_MEM_LS_EN_MASK;
-- 
2.29.0

