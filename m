Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FB1C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 19:47:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E79E10E268;
	Thu, 14 Dec 2023 19:47:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81AC210E268
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 19:47:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nr7y3LPDP2+2QWgeFj5a/0nQIqEKSjMySpamTWFHYwr+/o/lRDVI2lFUchKqkN8ShSt6LZY7njg7skg+nHsZXHlE6dtXK+g1u5kKK6LA5A0mE8BivsBWruNlcyd+xfXcCapUI758o/Yi5BTo7Udvf+fZt5wG7FV1GGJt6TGpGNV5MlrLLp0GjYN9r2r+yLIrLtd6jwHNA4ZVjJ5odAmCI0xdFGCG7nTLJO1j89/Q7Besb+mSmu6QZgNmP/0qE/3ElJll8NdUdoPz57A6zu6YWmgjrRCesOSpbSmIVCayGtw+qPVbHYDQTzVcLlDMO1hcPCUu/J4FvANTsqjfZX35dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTibdApTyAQSzKGC6zQn0KT36AjxVYMm97F3bdIUiWU=;
 b=IxTIo6A4+kkqegnsifbqEaCv1wJtZRPS4GzVdr7ooXImuTGxY14q4UMx/ojp2fPkPnj/r2Cc6rylaJojcLgCgB6fi5HBF/IErY4kLelChkd7hJmy+V4X/3DyR/dLxtsGwqDiXa0FX4dXfHMyGmUoprVOtUqXutkzYbX1UCzowUntC6rGHx/Uz4tu2jv7CpArOatXLQK9MRe8GCwrgaD/kxp8oFQ7FGo7BsBMpAuEfLKyVoQusj1PqgeYi2olNEWcy6zq5WFKy6SxxiswyVVhKzDVgRLi+qDsLrgj4GC8sYkMijbuweNXDE8Usif8ziSZW44z1mhgPnP+HgYrsC9mMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTibdApTyAQSzKGC6zQn0KT36AjxVYMm97F3bdIUiWU=;
 b=TQj9keauJ1JR4zWfGIhKG3txP+nBV/JLfxa65xzSGoVyCxKqjfkGU8gvx5PwBOSpGJQnJzTdicL1N5fLVJPrIzx2AEBORurWDpvMOn0yJ8KvkJX0YDMkuXkxMyOQfl7ft2o9pNURLz5Y66kJwwoj+H5a3jWiZFx+k7P1wSSKAdA=
Received: from BYAPR07CA0108.namprd07.prod.outlook.com (2603:10b6:a03:12b::49)
 by PH7PR12MB7185.namprd12.prod.outlook.com (2603:10b6:510:201::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 19:47:40 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:12b:cafe::f8) by BYAPR07CA0108.outlook.office365.com
 (2603:10b6:a03:12b::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Thu, 14 Dec 2023 19:47:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 19:47:39 +0000
Received: from OriUbuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 13:47:38 -0600
From: Ori Messinger <Ori.Messinger@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Enable GFXOFF for Compute on GFX11 V2
Date: Thu, 14 Dec 2023 14:47:25 -0500
Message-ID: <20231214194725.136840-1-Ori.Messinger@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|PH7PR12MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: 36755f18-e136-4ca8-4e1e-08dbfcdd87d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G3/L+d7gbC4dYeeTaU3fDxSh/S/UXe60RkmAWOEQlNLyWEeDjs6GUbfOK5bzET+Sxek/pOU5+ZFs236dzY1XAZMeHbbKB3aWufbvA0giULhcd8ggbeDiLm/9gk7Nz+f0GecKbh5XzkllYit+uVv8tglSBEkng8FgX8VUjK/nqmOhuNpcDYku2Mz3QYVRnHWg5OZbpOh8B0jJXyqlXowrW+SiKV2uSlWjfW0+gnhgWzLfWhBqxGCzR9LHGysUMHR/io4fWL5OSk/8kniZljl7/zX+7a3mqZYXaW5cWRLeGDVuxesLa3OUisPUX9ly3NHlKM+IPJv4WyE4X21NlRMk0jQeaxOuYvTWV8RuGd0PkgAOIUF1bRiIatd9Te+n1EIs0+uchRwyP46rltZ+b7XmC4VfJWOUhn66YYsd1IYtynuDxtGDm1bGplTDNTPvAwJtFhlNcK4cwF2BvKw0zFWDWpfTQiVLQIsf53EQo/IFCYqDdVhDSeKqh2I94BstLO5+1yO6e202DznFTIpPg72sxN+O0K74c0AjxFVp6KNsrsibbibCFCWYFS8KFqQoD7FfireEYMQQw/9cFrBQZbmgTrQJvBut1C3ea2AylRxNOudmwQE2zd/+RZtsMuPpQPEbm1WiXiy2H/zNkYdq0bIqmXd0zsZPjEK23wVDQJQmAVYRR/WkIH8c5MCB4Zu1RWcKBIwq+ZmvRs613655/8olYAJqwnI/P8DGlcEfOU5++MoPGdtN4KaBYYFtkQbKYk5PzTwJ2mJD/UUJuPu0eeBAkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(8936002)(6666004)(4326008)(8676002)(426003)(336012)(83380400001)(478600001)(40480700001)(2616005)(47076005)(16526019)(26005)(70586007)(70206006)(6916009)(316002)(36860700001)(7696005)(1076003)(5660300002)(2906002)(40460700003)(356005)(82740400003)(81166007)(41300700001)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 19:47:39.8501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36755f18-e136-4ca8-4e1e-08dbfcdd87d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7185
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
Cc: Ori Messinger <Ori.Messinger@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GFXOFF was previously disabled as a temporary workaround for GFX11
due to issues in some compute applications.
This patch re-enables GFXOFF for GFX version 11.

V2: keep GFXOFF disabled on GFX11 if MES KIQ is below version 64.

Signed-off-by: Ori Messinger <Ori.Messinger@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 067690ba7bff..6586b00c3b2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -695,10 +695,8 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
 void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
 {
 	enum amd_powergating_state state = idle ? AMD_PG_STATE_GATE : AMD_PG_STATE_UNGATE;
-	/* Temporary workaround to fix issues observed in some
-	 * compute applications when GFXOFF is enabled on GFX11.
-	 */
-	if (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 11) {
+	if (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 11 &&
+	    (adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK <= 64)) {
 		pr_debug("GFXOFF is %s\n", idle ? "enabled" : "disabled");
 		amdgpu_gfx_off_ctrl(adev, idle);
 	} else if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 9) &&
-- 
2.25.1

