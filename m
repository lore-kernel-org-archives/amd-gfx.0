Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A504CDB474
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 10:26:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C6DB10E599;
	Fri, 20 Oct 2023 10:26:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C595310E596
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 10:26:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PendWmz1YkHTAWWbTz9nzoB/KAu3BdB5cJ9XzDRHgVYSLAT53hAdDC58zNpV01EKxIhiNKbl291iv0To4Z/634L7G+F0nOLMjgNeZlzAAYVbae5VoirNPV9xZFm2Y09kcaOFdZwsgPGdLVtZlFq+Je09+iA+Mwmc7FXoWPUEf6zqXaKALLADVZg/fm3wTgx9L2h6QbaFoCEBJZ2DqqjsWyS0W2CcxKYM60FUbNIr6hlJ2SNmlgu+CTPz8GfHluJ5XpFMz3yMG94cnMUyg6lAZir0VvBEVGDibge4WTn5REoa7g+fGycDqgBtuCXSAVTh6w9F/SHm4Ip9XS05Fs0SGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+W9v3QSQVxyqHQoESfqBBstTi0moMNXXfPLKxz0YbI=;
 b=im9kxFXS6Sq6mFwlD/G/ujZmiucUWPMnadDuGSXhWRhdy8spsrdFX/paKzW6s+07yYsJMLKqSiiZLApVQmKpA9zWZAHwe0dFUydyN/ocrwavAnSNkp2qmAy1UGNRqd6fz3yQci3wtIgQLWZj0AKy38Wfsfi6NM2BZllmqoKFgLNmP6w6DIxF/IlcpndBkWZMidH+AUJ9dMM9uz1C1TF+rp0Jlp7GD5A45c0yEZ/oJI+whMkVhlO034TZh0aqlMxNBPSfJxCcB9irvSLzdmyezsFivTwB9XPKB9YczjjbJzFa84iNuGP7KxboqAtxQg569++JN3aZlaeoZWJ03Vi3iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+W9v3QSQVxyqHQoESfqBBstTi0moMNXXfPLKxz0YbI=;
 b=GvsbcDARyhMVT4TqZ6ga/9XgoNpdosc0TXjounGPVDFFSdugGXbQi6RQY6LRdjheti99z4Jhv24ydNBFvR4q6s79+B/ztFPul+MFS4kghNlWDBMTDNS/JhRqFENJ7623YweQQ8beYRElGqBE0Ts05yayUMKEukZ1IrlTmECp8Ic=
Received: from BY5PR20CA0006.namprd20.prod.outlook.com (2603:10b6:a03:1f4::19)
 by CY8PR12MB7148.namprd12.prod.outlook.com (2603:10b6:930:5c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 10:26:40 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::9b) by BY5PR20CA0006.outlook.office365.com
 (2603:10b6:a03:1f4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25 via Frontend
 Transport; Fri, 20 Oct 2023 10:26:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Fri, 20 Oct 2023 10:26:39 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 05:26:37 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable RAS poison mode for APU
Date: Fri, 20 Oct 2023 18:26:28 +0800
Message-ID: <20231020102628.29419-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|CY8PR12MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f6d859-6d58-4e2a-d7ee-08dbd1570bfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eGzRAcB/UQRG56a6qYPWPWa4+czdXdCNqXbN9eMUKSQnsIgNCL0LGDHs0QZAO1sF+vTOwSn87otRaz3ouILHnSrPWpGVrlkZYFwzwaUejsxIKx+XnQUmUM+wPzQGaFcNPSvLB34ZxoXaqD4kkWSMKzUGUqXjFE91begeGt7Pd4gN+OTVHxwHnmfQfZUrqfKa6TMT90fSHUE1sRVwtheIlnUvDGL0Jwamb9SDzhzk0CNU+46NF7Pv1cNs7ggcgWFLBqEil0++lKeAR6O7DSMp2jykUZk5l4VQxGddnX72APeXLv5o6JMv0BOV/NRF+nrw/3NBKNJo4lviEzEX6AFuV7cUMTgidemOiAO0WzAibXynnccRL6fmRg6YxGg15A5Zs8cxljqtmOVcOXhm98NOUySr6ybWxpfJ72oXhPTngvHFSN+/h59RT1sHodEMJsqWns6Vc5v9x6YkfwEZYkd3tPoq4blSXwslECdmqlAJ6GFZoFUWivc5+DcaUxneVWjwq7wU+ekgsxcAG9C1h4N/r5/ddxNssnkcJBANkNDMGm8LpmEnZ2ZZ+bC/YuMOMqVx6D2SNhoHKCTXrMBrggWShjXSn1WreQ+LJwx53/zLJenjfH+0ESlOsqzG6cjntrEtSWeTBlp723A0rDFLHB2vUQxB7Gi/fDHa25K2EyqC1BhSKzivRTU6vNVSSuUq8GbJgF4Tzpo2ZJXt4CJe3rFfM0+cn1Pt9PexSFpeHiQCsg/Bx/g8IEz4nIa8crBuxLC3xKzIE3HSD6UU0A5Ze9Uqrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(82310400011)(1800799009)(46966006)(40470700004)(36840700001)(86362001)(40460700003)(70206006)(6916009)(316002)(70586007)(6666004)(8936002)(8676002)(478600001)(36756003)(41300700001)(7696005)(4326008)(4744005)(2906002)(47076005)(40480700001)(5660300002)(36860700001)(336012)(2616005)(356005)(426003)(26005)(81166007)(83380400001)(16526019)(1076003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 10:26:39.4843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f6d859-6d58-4e2a-d7ee-08dbd1570bfa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7148
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable it by default on APU platform.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 95c181cd1fea..a41cab0a2f9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2710,7 +2710,8 @@ static void amdgpu_ras_query_poison_mode(struct amdgpu_device *adev)
 		return;
 
 	/* Init poison supported flag, the default value is false */
-	if (adev->gmc.xgmi.connected_to_cpu) {
+	if (adev->gmc.xgmi.connected_to_cpu ||
+	    adev->gmc.is_app_apu) {
 		/* enabled by default when GPU is connected to CPU */
 		con->poison_supported = true;
 	} else if (adev->df.funcs &&
-- 
2.35.1

