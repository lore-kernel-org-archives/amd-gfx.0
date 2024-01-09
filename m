Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6249C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 10:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5665710E6D6;
	Tue,  9 Jan 2024 10:15:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77EF910E6D6
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 10:15:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhMRMmVpIesNZUQwOOo/jkdU0ouJ3EpalU+wNaWz6wlIJa2mFHkrNT1JkLLxJuB5Ldp3XqnfH3gR0MlRwyjQ94sXZH3LAFu+IgS8kT4T0HX/MhA9B78f11l/Wg9QZKfXifj9Q9xCJ2jqsizYNJUCY4oVbku+5JCyzirVCdElK8AUTrX15W1H1QDEAwG9SzbkrnM1nxOIwDwAlMugbfZ4cmEEz3Ex+Cnnufj1cL7oeWX7yI9lmvnyycB72pVcMeNalj+XUPtURoxY1F6dYChB8iHoUfBR9IUZHE48mcoCTtA6B0NT8G/SxJVTO+t+peZrwes2jeUKzxNevzaCqA27vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xS23vPtIR4gCD+upDop3jODAdJNfphTye3xmiyiDKs=;
 b=lNiwQ4vtM5Ce/Hy06T/BT2e8vkkx2GAhkmd+UBL1pb5DqakMQGo9OMy2YtXhGAN/AhYSbXVSn3zLWAznj1VmiTK3j2PE8OKwwmef2vgEsU9Fk7K3ES9xgXngxlS3vJdfypOk2329fKVBg0Bg6SDd8ra/qRNStdobgDvJDpNQ6nKvE4pugoHLZOzD9fi04je+NhHE+GpeLUJXspK3YSJMRtmTRtIx+W38yDJukk0Js3HCX3D/7lzhsiDMGqEI6+sQ5C9fWiKo3fm34V+Ve7a3QPA/abLMfgKEkwRZHLzNwftP6Xp8hSD86iF0i48OuGOtM7SnMuVZI4yNSF1nHUXYzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xS23vPtIR4gCD+upDop3jODAdJNfphTye3xmiyiDKs=;
 b=e3wlwbC7hhOlplu2Mp4g+qMJCYCcZ4Tin/PuwSGSySqQWGAvJ5z9+9zVGWRLwvQKh+P0luBYSOXu1yh6KfpcyRTg9nCLPMoZK71YVM8xWb9DSGoaRvgWpc79Q3sacV+n83YmJjhw4mI/HfzoSrgQFEJqers8gBKhF+i+IwjvDHY=
Received: from DS7PR05CA0025.namprd05.prod.outlook.com (2603:10b6:5:3b9::30)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 10:15:07 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::f8) by DS7PR05CA0025.outlook.office365.com
 (2603:10b6:5:3b9::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.15 via Frontend
 Transport; Tue, 9 Jan 2024 10:15:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 10:15:07 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 9 Jan
 2024 04:14:32 -0600
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: move debug options init prior to amdgpu
 device init
Date: Tue, 9 Jan 2024 18:13:59 +0800
Message-ID: <20240109101359.28362-3-le.ma@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240109101359.28362-1-le.ma@amd.com>
References: <20240109101359.28362-1-le.ma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|DM6PR12MB4090:EE_
X-MS-Office365-Filtering-Correlation-Id: 9751856a-a712-4d2e-b69b-08dc10fbdaed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4VE/4y+84dK7OSQfjstJX6wSIrc/PBy+oCldmLyUqJkayWkloJMbID4UHVNL3qZrJy534hVdyEUOucUNe6VtMeWdfyxvYAby2AnNPLlMFB6Mbjvt9DoFIqsbZfOG4ZRbOJElU03hYaFgvRym2sjUqDGoxQ7VklrtHFiy4u9HEkmoT7QzSb8TDpjOUmEF+QVEyGqxp6GkCG0gmNebwkXnsc2tT+6qklPjjlsESu6gwZgVRfh9YTxwhiWa6pvNj5Tlx028NRQTF/VJvNndfM8IFHHwrsUCH5Aq7IYfCD6f0+dlMPggtza1QTlnpK4eQqGekY8DZlq6TxwTBfkOD1S0US5nZzUj/wll20DWu5Dx5MhFp9PyI4sMB/9N1QHdnBbNRwD/RQEkmpgOy4jQTpY0qk/ECl9FX3ndDLbxS7jyNw6xIE7Vgisag6cmeDslY+TDuIIMXXBiLOVoJHOVJ7thcuVz7o9CFlbrEyhs6PBquiTbpFPRb83w1fkzVwFmFG3FYv+T641EpXKlDjxPbr0dCyccmH1cF4egYJPpvs23OvViCPezPkeWxMHzevBmEUbJu4TYPs6hvwHpS+PkGMcPpp0DRUQc+MSUSZHYfZGvsHS+IXPXgsxZbHOzBFTcKapzYSdqT824B+9p5nfH6zqP1y0N43g4I+E2EhxI8kUbILmhJJaMvXaQVnAV+IddbRB5Vh7ap7JVnJvSiZHrrWJ/6tQyW+aS25fSgDwXqxZ04WWj/cxZaGHSrf+S/0dL4wcNxJnkFe9dSMNkRjS2WXLJpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799012)(82310400011)(451199024)(64100799003)(186009)(40470700004)(46966006)(36840700001)(336012)(2616005)(1076003)(426003)(26005)(7696005)(478600001)(6666004)(36860700001)(47076005)(83380400001)(5660300002)(2906002)(41300700001)(8936002)(70206006)(54906003)(6916009)(16526019)(44832011)(70586007)(8676002)(4326008)(316002)(4744005)(82740400003)(86362001)(36756003)(356005)(81166007)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 10:15:07.4521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9751856a-a712-4d2e-b69b-08dc10fbdaed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
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
Cc: Lijo.Lazar@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To bring debug options into effect in early initialization phase

Signed-off-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3e0e39a1b5ba..b67ffc3a9a3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2234,6 +2234,8 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, ddev);
 
+	amdgpu_init_debug_options(adev);
+
 	ret = amdgpu_driver_load_kms(adev, flags);
 	if (ret)
 		goto err_pci;
@@ -2314,8 +2316,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 			amdgpu_get_secondary_funcs(adev);
 	}
 
-	amdgpu_init_debug_options(adev);
-
 	return 0;
 
 err_pci:
-- 
2.38.1

