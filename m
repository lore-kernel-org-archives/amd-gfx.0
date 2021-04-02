Return-Path: <SRS0=/zhQ=I7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E56C433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Apr 2021 06:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0202161104
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Apr 2021 06:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0202161104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6C3A6EE0F;
	Fri,  2 Apr 2021 06:44:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E13AC6EE0F
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Apr 2021 06:44:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O287wXjYUzHZV+eum60UmaYCqPrqAzKoTdoBrZqZz0bRk9XC2xvyfTXG6cuYCrFdPFXW697I4dSKbAM7QbfRTRUv67KkBiVwPfc2ydLc0Vz3iO8hlyFVswSJD5Lrv8OeFk2/UUWOoIBZMRjHmMmGl2loPby6/vauQIJyNvbiteyJcWJuFwW0yyL2HlfNjFOiy9ifTDLa3+RRNqIyhf7/jJGtqX2lzxx8iEFHppbKGNfiUg1ifHd14JkjewSo7Vw1Aw6U2tCBEUa2Znzse8RopOc0vBe1OUzu6Wd1PM5zDsuYO4nTuYi9zpP//4kWvdNcLKZQDXnpzztBPw6+oAVCVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hcUlETF++1iyH7z5GDcpuAyr8e6wYp0EBWYObBIv50=;
 b=CEk6Ymccs2Mr2qODFZ6v+QkXIcySbDNcjsnVp0jNSSlh5spESJAQMurFsxDPpaQqbQuBMl3CBnSFAZmoMbQeW5+QUJym57r+IJLQcTyMFWuMQHPtuYHnqXAhb3wzbOt4RfNd+9aghoSPmos0f0eOwsbTfRi8SIdJCN4th8qnDJKaN3paq+cevxzGnMKElbw/9C36kgQ0ijVlDOKJXgi/kuiJ7zyQIEa6v9dqXjeiuUyyimv8eay5TmYE3Wrjay4uXiSPb59z7ZJ4IW6eW2z/RbuB/89/KRGGc8VDs5Q1sB9F+POuaS++m3clzQuHGv23shjMa/bZpuG4U5b94a2fcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hcUlETF++1iyH7z5GDcpuAyr8e6wYp0EBWYObBIv50=;
 b=iRSGh2tAW//SvMmEJI94+izHkADt9AGC9uB0+VMvFbe061ZHQNP0QKtWMqZe+iVyXeKm1CZuF1XkOn+5told0QDFtaSjDOrd2RQrqf7sPAog5eW6kj4OMsL5asl4PV0Ltln7e1CsTlXVNm+AHJiTPDF7bJLU246byuJdhawlGEA=
Received: from DM6PR02CA0068.namprd02.prod.outlook.com (2603:10b6:5:177::45)
 by DM5PR12MB2568.namprd12.prod.outlook.com (2603:10b6:4:b5::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Fri, 2 Apr
 2021 06:44:13 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::e) by DM6PR02CA0068.outlook.office365.com
 (2603:10b6:5:177::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend
 Transport; Fri, 2 Apr 2021 06:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Fri, 2 Apr 2021 06:44:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 2 Apr 2021
 01:44:12 -0500
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 2 Apr 2021 01:44:10 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, John Clements <John.Clements@amd.com>,
 Dennis Li <Dennis.Li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/11] drm/amdgpu: do not register df_mca interrupt in certain
 config
Date: Fri, 2 Apr 2021 14:43:43 +0800
Message-ID: <20210402064345.14093-9-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210402064345.14093-1-Hawking.Zhang@amd.com>
References: <20210402064345.14093-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c9a8a9a-ce70-4990-6fc6-08d8f5a2ba50
X-MS-TrafficTypeDiagnostic: DM5PR12MB2568:
X-Microsoft-Antispam-PRVS: <DM5PR12MB256834A8BD2A795A4CCC4EB8FC7A9@DM5PR12MB2568.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5wlzaFut6SsmYdQGLV4AuivPhV5knSZiVk4cWycdMPfrof0SiCfmWP/jvx/UJ47wo+zM1BSBEsh2pp9WAvoWmS509+CgNo33rwNNbWnaSX7jBiR1E/ojBqgkDOtFV5MjXLL4StWQqAh8AYU+mPNzepCGoNVhAmxlXMcvzkBEvzBQ81gdlk02dGNO4W86E4Bu92BxJg6PCautB7vALxRqUOKLYOKHvB1r6cOKZYLBQmaFui9QdDArMFHd+l2tznIkrr4HT7vJucVgNbx0Tv5CCacTncWDxy6A5ZfMu5YWSUIidwPwIQqAcmDptls8V4wILE6WgMmRqRECgZEfyOGl6SqJZ0GdmkIrnfUda+j8tnjg2+7BBgU0FXumZiZf2U6YPUm9l3d5KnCfeIrpsz32Z3+Tyo1RHuAXS1VN1fSnMBJc2Yk3614rbAIqn/BvCQ88biMTNNZHTNaFvV29XbfufkR7kc15uSwwkDBkjKn9BpXLQhejLM1VUfWqISufn7iY2lijCxyBCJwV1xBsfhY2Ir74YqoakDTz9qBO0TahWbGIiZMjdpL4HibOupk/LuHMJNq3ZALQYmKUd6PZquuj0wUfV6YGWOasD//E1ktIbJWCyEyCxebsGIJNk1X2JqrQdAlOJd+IXThF3jzd7+u4d9/V3Q+ZXyCIVWTgpifq6byIb1AL//MmSLC6dtK8qn7/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966006)(36840700001)(6636002)(83380400001)(1076003)(5660300002)(26005)(110136005)(316002)(81166007)(82740400003)(2616005)(336012)(426003)(8936002)(8676002)(6666004)(70206006)(2906002)(186003)(36756003)(356005)(86362001)(4326008)(47076005)(70586007)(82310400003)(478600001)(7696005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 06:44:13.1346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9a8a9a-ce70-4990-6fc6-08d8f5a2ba50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2568
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

df/mca ras is not managed by gpu driver when gpu
is connected to cpu through xgmi. gpu driver should
register x86 mca notifier for umc ras error
notification

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reivewed-by: Dennis Li <Dennis.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index c353254ea5dc..27f692904791 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -653,7 +653,8 @@ static void gmc_v9_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev->gmc.vm_fault.num_types = 1;
 	adev->gmc.vm_fault.funcs = &gmc_v9_0_irq_funcs;
 
-	if (!amdgpu_sriov_vf(adev)) {
+	if (!amdgpu_sriov_vf(adev) &&
+	    !adev->gmc.xgmi.connected_to_cpu) {
 		adev->gmc.ecc_irq.num_types = 1;
 		adev->gmc.ecc_irq.funcs = &gmc_v9_0_ecc_funcs;
 	}
@@ -1510,7 +1511,8 @@ static int gmc_v9_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	if (!amdgpu_sriov_vf(adev)) {
+	if (!amdgpu_sriov_vf(adev) &&
+	    !adev->gmc.xgmi.connected_to_cpu) {
 		/* interrupt sent to DF. */
 		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DF, 0,
 				      &adev->gmc.ecc_irq);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
