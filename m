Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0944DC48297
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 20:07:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E820112DC8;
	Tue,  6 Feb 2024 20:07:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fww/EXuX";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62659112DC8
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 20:06:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRfINwGrVwHG03I6FgRCP774usSuQn0MRejWdDLeBJ6BPDvi2Q2MFgU/SfKnfIj+D7DMLGUtipnCxne1W2cOFsbNh7DbxlCledOHYBsxvSbDLwh5B67PpzyIcLmc1vd8I+FKp5SiutO9GMquuyo09XxlhlVEZ4GsLxnDoQ/IKY0v/fguUlIvogF532cho+7QE+4TKntO2qU1m5CH48MEYJ/MG3omxladTBQjqkSSyQr44LUCRQPHHGON7JDHJR0eu9w81d30s+SgGBOpbYc9HvaGmeETKvj+ULkYvmeZSHpFhIO0+6j1B2WOLBVMoNufXFQWazSLO6j4D6t7GRJycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EZq7NhwAAFDgPwWy2/COaQO2kX/O3OzZzjUDHVpL0c=;
 b=G9oLQcx50mJxJ8M9STIfbZ0KdpFfL2uqmnWPA9ADSFJZIFf+PXCvfUQUqKomtxaPVRuT6hhS1I4Wx/FMrB3tDL+zkGF79gLFffzfAWPP9OULoJlc5MtBRLhHLzltT6FLSnRUynhpJIOJiMSzeiqWVpjQVRMnTacBUf64E4ZIznz6zF1+QTiDkonJbbJMuypo27aXvHat4Z2g8OaxAeYTApIPNKLczA4tXtAdcZ6A2LQjAYMckxugx+GVaUdQaFrcGbUlpmmnCkylJxcrA5TdUfs2i9FJQwgjM1eFX++VdSXIbcW51ASkVF2ZzQEMSezrdL9chiWVCN7bSn15wHAJqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EZq7NhwAAFDgPwWy2/COaQO2kX/O3OzZzjUDHVpL0c=;
 b=fww/EXuXO40gBbqDp/txRRxzMtm7sDNsmIIu9nOxKAm05JOYaIdAHC/I+ne7/x/VFiadNT8xbsZJe2tRzaLgVHUMk9XB5mlbQ0uqIXo66jQPxRL32hom6MudtfU+9n36qYkHlX/CmN9+MQGxGvupY0w5o+Yl2Y5IJiD6zeVlZuk=
Received: from SN7PR04CA0185.namprd04.prod.outlook.com (2603:10b6:806:126::10)
 by CY8PR12MB8194.namprd12.prod.outlook.com (2603:10b6:930:76::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 20:06:57 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:126:cafe::90) by SN7PR04CA0185.outlook.office365.com
 (2603:10b6:806:126::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 20:06:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 20:06:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 14:06:54 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: support rlc auotload type set
Date: Tue, 6 Feb 2024 15:06:39 -0500
Message-ID: <20240206200639.1670753-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240206200639.1670753-1-alexander.deucher@amd.com>
References: <20240206200639.1670753-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|CY8PR12MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: dd1c97fc-fb93-42d5-8977-08dc274f2bbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6X53yytNWsQHuexKDdknL9+YVGNovOqYjr823WvAehRDophvZvn0hz3nuV5OMy9n0X8LRSy5oLNzz0CbCNTluDx4vzRJR6Nr1bp5OQKuijJ9j9ssRlSwFVHWAzRJc27RSdJiSNDoIQiY5oKBCzlGG2nNpEeQeal+nIVBKQo1vC0X+uLfC9zqJ7PqiSFZhePqwk37meV8gcE3696LKl/XtNr2aNSaU6piOlsRMF6iexhC/SxpaPuYDosXrwjZXh6MwBAY7PqCnLGb+UVJBtHlzMEUcvc1xBjUVnp5K2fLoyBiFYsjxGvQEEoaF/9bHP+Tx8Qz0UhDftKHHUIylaKp6i7c90fnaBMAmx+ro+Sc7T+tlVLMIv3Ppsz9xGpFFJX7H7Qx/Xv0dRfUtodgve1O+9emzgDg7RFy/BxYyDIwfNeWBtBvaqEXc+V1dE3PPYf7OUHyLiUPiVgoOXgYo+C+9+yDKWShCEZFSiyzw8zHiwBVd5tXXjeuOKXKFDOpF2Efc4MD2YBirOEpAM3HPRP5gCH78LSr1HNHuR6RBP+RZfjv7wua1EByKDaHtAhxevblLg29OOxzNOeSZ7m+mEZ47607lF6NoIfjjOAl5WFxTOA1XWzAohLdKbwvgkd5t5knu2KcWnfB1awbdltiEH26cZPeepOebLT0+GjNS6NWPT/o7ORebYXSl21IK+VZ603H+xHSiv60pYr+TYKdk3o2fMjUuG9YXeo8ciCnaFPxnVHNnoQfC5kbdse+21lV8B4C5ca9qeOa9cuQ/vDpwmtqYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(1800799012)(186009)(451199024)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(8676002)(41300700001)(54906003)(70206006)(70586007)(6916009)(4326008)(316002)(8936002)(4744005)(5660300002)(356005)(2906002)(47076005)(7696005)(82740400003)(6666004)(36756003)(36860700001)(86362001)(26005)(16526019)(426003)(2616005)(81166007)(336012)(478600001)(40480700001)(1076003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 20:06:56.8884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1c97fc-fb93-42d5-8977-08dc274f2bbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8194
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

From: Likun Gao <Likun.Gao@amd.com>

Support to set fw_load_type=3 to use backdoor
rlc autoload.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index afa3ac931638..2ab01b18d62e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -556,6 +556,8 @@ amdgpu_ucode_get_load_type(struct amdgpu_device *adev, int load_type)
 	default:
 		if (!load_type)
 			return AMDGPU_FW_LOAD_DIRECT;
+		else if (load_type == 3)
+			return AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO;
 		else
 			return AMDGPU_FW_LOAD_PSP;
 	}
-- 
2.42.0

