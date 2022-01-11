Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439F0C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 15:26:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAECB10E16F;
	Tue, 11 Jan 2022 15:26:39 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2042.outbound.protection.outlook.com [40.107.96.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E88110E16F
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 15:26:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QO/5QY4kCDTnjc7wJVtvws7cfL7t/M3DJo3xMgSJaFNUwuaZYGxQhoz9UHK1KQxYP9LAOqt8EwmtxUPpWQO34zn8DrgDTsgIuNXf+Z3AErtqau2+ahQobbDPpT9WiU6a12GWYJaomsYxbbTQALqqjkwdQj6ynChHYtMkZRHcC77MhQmjSaR0rccb1TTKQDmAn8Zl0sQHIIhs5c6UtdNq9JDSK50Xe7OkL4UAgOpkUBfZny6KAFb1l/j4hw93SszcDG3WZZuJBOaPtJSOya1YWx+GO5otUusOqfLd38nruP4Kg9ogXjrQejuI3yvK7PIw3pD5jdW+nGnvv3MEDpe7hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6va+5X81nZdZMHZxsnJNxr46XjkNQkSGscdm2S7wa0=;
 b=FA+yzaT9pRoAtINdeq3Jh6nkKKNamuQcAfoApQoMYkQbk4fvmw828vB0R3RrGQDc7RsG9U+7z+gorBXLmbrbNFow/v7VPNj+liHUZ1WIow/7g/NoSPdkIrkhtFO3/DOivDfcSCEaSWPnxl7zFY+lcy9LWvbOycB8oE+/iHrVrpQ6xRGTyMHTCGiakaoxfSQwHhSBGs95TDTLw9CMZTeyo1aFSNOtVw6TU6mjKwOYHLpVlSgy4u911G+AZHENzBEH7J1ocdDp9AkAXfCfm7N1CxOxgqmvxUC0CWKy31g0enqh4ASWWJtgsbH+wj3CNoH5nLuelPE5OSdcVc5do8yphQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6va+5X81nZdZMHZxsnJNxr46XjkNQkSGscdm2S7wa0=;
 b=RW7pBxHeTEkB3NIz/kTNhmTXW24QG38mg1oyZNcmP+rmioVZvSpi5HLQe4yOBJAzAdV+jeIj9HhWoqP41lFYMuYGRY+qEtfCNa3jeSTK54oAW36ghU+ihhSCnWnxSrvXZT3FD+BMhyEuBhjm+YdVLM1Grk3+6blBbYMzcIBglLg=
Received: from BN9P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::28)
 by MWHPR1201MB2524.namprd12.prod.outlook.com (2603:10b6:300:eb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 15:26:35 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::e) by BN9P221CA0005.outlook.office365.com
 (2603:10b6:408:10a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Tue, 11 Jan 2022 15:26:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Tue, 11 Jan 2022 15:26:35 +0000
Received: from ETHANOL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 11 Jan
 2022 09:26:34 -0600
From: CHANDAN VURDIGERE NATARAJ <chandan.vurdigerenataraj@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Enable recovery on yellow carp
Date: Tue, 11 Jan 2022 20:55:31 +0530
Message-ID: <20220111152531.3761987-1-chandan.vurdigerenataraj@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 447bc74f-0c14-4748-0393-08d9d516c131
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2524:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2524263C8DF0EC9FF680D4E596519@MWHPR1201MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AK1G28B+/DOs2GYf7kQ638iL+nbaGkKPupuPdfaBrbzonItyzVPsko2YeJMDV6tAa7DNqUXzIAZ/aJVDrX1Hm//G8PbcIWC9k+UhmvMsSVKEAAhpTs9RY7Q4VPc7+EFAcd0ZBM1CEoXzc0TpMT5Jprb5D6YC3gV76+wPGUDRveK3+I+RNdEpoiPLKI/IUjXb3uK07my3F1XQ0JICuVjognvrh8BYihyqHCnhDzFMSCKliL5Epi6A8tSah2PFEgDpey2dkJ5nHrFlsi6zIo/tsfiec83xvdHr2Nhn6DbEowFAt1O478+Gk5bb2dwICsJZG2rJsb3XT28lVN4fn9vPmrgv23GaE39MDCWvLzWcJ4I6d37MXZuKIIoX6OaPZanGuKGKyuiUmZ41uDdXnYDWrLo5DZrwG82z7Oayo0/R6gxEiu4s99CGg6f1RVYsWcgukkQ8w9Cx658GgDtWdGJIceLLvA+zTqvRes8k0XDEneUl/hYGNLwylgam2BiMHw9FWCcCIUp4Aw+wrugEbIKuJJQOwVDvZK2W5htUpzHW1ofp9CSUp4Gw9yRDDINIbC7/IE8wk7fqtkMnLEZtMh4nkzxBQQ5cLBr5fAEBcImkW5OryXMqIV6Ex1YsYNz4CeFXj2d73l1/nnCu/vV5mj9ApjfMHvbcb5G5MSkudZyG+XL707UmA5Ql4UfSaoeiIgWZQMH8c1XsPnDAbVjwFCZXRuJUXNI7ZPBcew74F/ojRx1iCbKXkiecFNUDpfvylitakslEIork+juvA7RyK72Ch6olBppNkgAoC8cHZ9y3Q6I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(16526019)(8936002)(8676002)(6862004)(2906002)(508600001)(4326008)(336012)(5660300002)(6636002)(40460700001)(47076005)(36860700001)(36756003)(6666004)(2616005)(316002)(1076003)(86362001)(4744005)(82310400004)(37006003)(54906003)(186003)(26005)(7696005)(426003)(70206006)(70586007)(81166007)(356005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 15:26:35.6378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 447bc74f-0c14-4748-0393-08d9d516c131
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2524
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
Cc: CHANDAN VURDIGERE NATARAJ <chandan.vurdigerenataraj@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add yellow carp to devices which support recovery

Signed-off-by: CHANDAN VURDIGERE NATARAJ <chandan.vurdigerenataraj@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f0fc015bd11e..2f519cbe7af9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4473,6 +4473,7 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 		case CHIP_BEIGE_GOBY:
 		case CHIP_VANGOGH:
 		case CHIP_ALDEBARAN:
+		case CHIP_YELLOW_CARP:
 			break;
 		default:
 			goto disabled;
-- 
2.25.1

