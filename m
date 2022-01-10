Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2798CC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 23:39:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B48010E895;
	Mon, 10 Jan 2022 23:39:23 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2058.outbound.protection.outlook.com [40.107.102.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D05610E663
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 23:39:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzoftEAlh16LHLjbpXFqBsexpwfM+Dz1Jko3CBH++XxaipsBRBAsFUes1kBx2nefLZGCncodIvgOKjxOGZP7TSWCV0pkvrcYCbS91A9S+cCQ/RldspkQewCQIy+lXFvLZ558F1tH/rl1GeUIwENTpege6t2IjmJVuf4+YS634Wt7oXuy2GYW++J/gSzRDxYDRlODLMW8eyS5mvqBR35FDiDRNBlX+Kj4FGvI656xcSJClNr9Cbp0vk28CHqMAVeP9TjaBsqL6694YZ1U7TbBwV9AQB3uTWQkN/EFGJpXABcVhWehVCnhdxuRxqQMV1OCdgIz7RDlY3/HJMu4pDeJhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bN7Xm1SCkTr7cQSaavRhEOoU3eFexZDtTobh5Gxg5Sw=;
 b=WRPr/0WurWkToCqWf5zgDFOdckuRTn/Yeau0I9TFbsJSp6U/pPZaoKBPkUcAwPcy5/wsFpFbaT7+OEiesD6SSmioeGso6MHhXn6hqZX1iZc/5jC/O+OibHlDV0AkuT+hzAcbrZAspQM9imOpb5/QV3y+m7NE2ApKAdaNmzuMY0ZrHTX+a0HR9CjnZkX7VXOwgG+9FQK3xepIqMq7SjTuSMlI37KQrN1ty5XWjWkc9AETGFNoxSCVsQvtHDv97oLlwZXJ6GAszFjbQWYwGEjZHac7S57cJ58mFRfA9IoYu25Y+iLxKOlRdux9RCcSvH/Oprw9McgBFgz8Jaziid020A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bN7Xm1SCkTr7cQSaavRhEOoU3eFexZDtTobh5Gxg5Sw=;
 b=UfLPjaoyBeW9voFhNWdY6WqVKcUIoeUaPMwWmrbj4G2u300pHgB2nFVv5QUmy4uMWDU9zxnpVE4yEBGkoQl7ONF7BXolVYm2r/0B/lKpwOMzhvwnXWgHECGeQcam5mZTZOchmM+lRkKbyPDXMu03Rw3JfYDXNnylYk0wFFLq4T8=
Received: from BN6PR16CA0030.namprd16.prod.outlook.com (2603:10b6:405:14::16)
 by DM5PR12MB2487.namprd12.prod.outlook.com (2603:10b6:4:af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 23:39:20 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::e9) by BN6PR16CA0030.outlook.office365.com
 (2603:10b6:405:14::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Mon, 10 Jan 2022 23:39:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Mon, 10 Jan 2022 23:39:20 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 10 Jan
 2022 17:39:19 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Silent GCC warning
Date: Mon, 10 Jan 2022 18:39:06 -0500
Message-ID: <20220110233906.1178021-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220110233906.1178021-1-Rodrigo.Siqueira@amd.com>
References: <20220110233906.1178021-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9202351-93f1-4082-d7e0-08d9d4926c85
X-MS-TrafficTypeDiagnostic: DM5PR12MB2487:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB24871F9477CEE0439DDC399298509@DM5PR12MB2487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sMqslPFbn6gd62xWOB8NHBYG1+liJtv5g3/9YPiJBQr89GFtE+/t5vQ8LBaJGg8P5Dq0a8rgdMPcNKM1cUOnbKjGFEXvIGqesnEahu91Gdr0X4A8m5ZyLBERkmlRJPLmSD6nD4IEeLFReNG7JhIBSHz/41mADwoa3EtulNjPhkQXwAd41hK57ucx0svyGfT+0W24peJggbh1F+IExHfxIqbjFJsFFInGIZZAMKxVTpEmkpdh/LQeN8mjBlj1duS0GkworLnLGydkfgVUccBiQqQtCLK3kRHvff9VLfp15lxQRRoSHhgo3R4D4zXoDFTcryXh/ZyJMAc3Ry6glmJ6FBmy2S595G9/gPqpPhcJ4du6Jjsk/JrYADpPGuHonUj38xrf5aYEEIlvc9UF3yMfZkBZLwsd5bNT5sfsIebH18ctGaST0vjzmO3Jp5SV0BMBHZQaum9xldjy5yD+TMrzGlzlGc9fluNP2wJ22Z76LyanrEFZ3FAUSwggAEUBLkRHrlkzeZII8L+ijip7zdZTmuvHxqameBULijSzD7rEKATS3A3es0mHvNh7L/ynWGOJhIdXKHD6kReAtG+pKjaBOeCm/zPlFOonWsQmGuvFCxciTp/Ja4XIJl1a//mwSwHXMe6Sk/OTJ7qjD1fhO93irrxALscaHOOHf1/D5BtAV+6MspskmlvQ1f+UqkXyoHGuKTBYPxW9eMcr7Z/yASiK1Jcuw4Z3OlgHK5vEzGSeh4G7XCrFW9+hbVA1euLPmyyYWm0vS7zL/GM4q4VP91XhSEXUgPEnfwRc4O9Y+aVBeRo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(356005)(186003)(36860700001)(82310400004)(83380400001)(6636002)(4744005)(26005)(70586007)(70206006)(4326008)(54906003)(40460700001)(316002)(110136005)(6666004)(8676002)(2906002)(2616005)(81166007)(86362001)(8936002)(16526019)(5660300002)(47076005)(508600001)(336012)(426003)(36756003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 23:39:20.0191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9202351-93f1-4082-d7e0-08d9d4926c85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2487
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
Cc: nicholas.choi@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We have the following GCC warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h:400:10:
error: ‘struct amdgpu_iv_entry’ declared inside parameter list will not
be visible outside of this definition or declaration [-Werror]
  400 |   struct amdgpu_iv_entry *entry);

Silent this warning

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index f604a2235a9c..62f1f97ef7f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -395,6 +395,7 @@ struct ras_err_handler_data {
 	int space_left;
 };
 
+struct amdgpu_iv_entry;
 typedef int (*ras_ih_cb)(struct amdgpu_device *adev,
 		void *err_data,
 		struct amdgpu_iv_entry *entry);
-- 
2.25.1

