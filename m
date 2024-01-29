Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80AAC47DDF
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 06:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5491011226F;
	Mon, 29 Jan 2024 06:48:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 088E6112462
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 06:48:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAh6Ge+O/Dnh0WigeWSL/KISJtiaxfAbipTqXK3ComHxpH5wqdPj0EsKqkVdsZD/077nrzdG5HwgWW7s0thzo/xQAoEbx4HQXKVwEyszcgwGJPpf3iY+IIfLkWP7nZFky1UfS84ASJiiJDskTNRFLfAY6SSBxXeAHkMHxp0ceoArmllSuscqBLwHxCg5zr/uzDEck7lRelrVZjB+upcRnZ4E6SCrYBm8lBcLqG6Ymu4+FJSFu64Le/06SC9aPtghvitYSVUMvM0LwU0/2Shh8viFDlEGt2jb/jsyitylVYCrTR+IkXSTDEON0nLnqs4vYE6yGFSMl5U6p33tg6bnwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZ5gDfX3x6tsnVk7OUry46fVqsu87p41sA4ubB6jO98=;
 b=GywNUA6mEGcXdxX4Xupc95EX1KKoky99pdTw9shFLWFxhdIv8v47CA/W/3HcU14GTPJNY1iP2A9oCTsZPT1RHIHRdB/CiT8etIZsZM6WQQOPKdgcVAuuEYWdbdT64KsnzBUA18n6N5BpWeoeWsVxyvNfS2qdKJbEQmUuRDF6WXAoRmwFMMRCHu4NEq5ABNH45x1KjLLgg+VsOjPvGREIU99RmbmC5DQKds1xn1ozhoSmZy52HOfK69faqASqrqbWieFMBaYtry2oBqjftLDEJztOshaYpMdPcWtbIXaqPGfn3yEEmpfAbmsTVAXPiI4ea0qJB3bREmXHUwsNz2lWRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZ5gDfX3x6tsnVk7OUry46fVqsu87p41sA4ubB6jO98=;
 b=RsJF20bMQaSSgpdioZQ63uUyZ0Jo1vIRqGjnurvz0WzIQBdHBpMN41G4Srdbmvq8hGBkxu/sS3IqDxgRNdM9RbrZi05jwFOjTj826i3hijN6AlzpM1gIkIeTF6SwjhcEwC/RbsieYUePRC4mcC2I8Sfy9LXVL5TylI8LxYw056Y=
Received: from CY5PR15CA0137.namprd15.prod.outlook.com (2603:10b6:930:68::17)
 by DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 06:48:24 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:930:68:cafe::c3) by CY5PR15CA0137.outlook.office365.com
 (2603:10b6:930:68::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Mon, 29 Jan 2024 06:48:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Mon, 29 Jan 2024 06:48:23 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 00:48:22 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix the logic error when init mec fw
Date: Mon, 29 Jan 2024 14:48:08 +0800
Message-ID: <20240129064808.1424881-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|DM6PR12MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: 4add1ae7-a9bd-489d-486f-08dc20964a01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y0gQmRuAZXGExMn9ZSDvySoNNAJZVEZFU/sCXvLK1xT4HVya+WHm6liJY8n+uWD5kZHIVOLWQRXEapy1mTQxafw+b9jRSjPKP+pbaCzxRyyFa+AH6sqZWKX9cpk1po3I7+Pfr45GllSYLon0RdOeahnmEhj4cfI+W7d7RhK+mGXkUHoKswpELs1T5Kky+y6otBfIzIItykOoJow195yklwqQgo+5lIG9b6Wb+qD3wfZdcXidV3+RJb90rHpi23DSRW/i7/y4Wnvt0GQq5t8afVi1mvBIJ70VeR7XwtB5ag3mex23ktOZdqA//DwWONDkj9MQ4qtgNsIE5cuy41L8enpAonpDRj/vGy1GZy4hmElgjCKJZG6HQVyVhTMBHqf/AAqz9HhEeOB5Jw/uoOIPouAU00KLeeWYyrVW15DM6FEqLsBtSHLKKIaTkZSdDVOVHgQUHZZ5sl3VTINjNm0qdKmDdR/6zBvOuMd90PaS0aZXKaCY92OhrfGF5pz4LZfqA0B9PIRGPEKNNFO5cXfC4J29ete+/S8Pg71+DZtWnXBavr0fgBJxZOXYvpRIyM7AUwcmTOigNaiZy27aMbbXQ4Fo7l8zdZYwBypvlsYV33MJmjjOoFIzKomDolRqBhb5fN3yXmhj5GOCuIApK8pyWZq2Fid9CMWdfnGNIYaJk/hNCVrvQx7qKOHKNYbF4ZbYZrH2mhEgPbFJSSG8TYejU9w0EIBHWh7CFlTgSBvbmEGkOPS/SVmngRxern5TwAkaT/pP9TEhWLSB9octJ2RtpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(46966006)(36840700001)(40470700004)(41300700001)(2906002)(4744005)(5660300002)(36756003)(86362001)(83380400001)(70206006)(70586007)(54906003)(316002)(6916009)(47076005)(478600001)(40460700003)(40480700001)(6666004)(7696005)(426003)(1076003)(2616005)(336012)(16526019)(26005)(356005)(4326008)(8676002)(8936002)(81166007)(82740400003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 06:48:23.7611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4add1ae7-a9bd-489d-486f-08dc20964a01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201
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
Cc: Alexander.Deucher@amd.com, Ma Jun <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove redundant code to fix the logic error and potential
null pointer dereference if gfx.mec2_fw is null.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 057d7f3b8ce0..3395b83e969e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4027,8 +4027,6 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 		err = 0;
 		adev->gfx.mec2_fw = NULL;
 	}
-	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2);
-	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2_JT);
 
 	gfx_v10_0_check_fw_write_wait(adev);
 out:
-- 
2.34.1

