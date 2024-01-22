Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B6DC4725D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 05:29:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BBAB10E4D5;
	Mon, 22 Jan 2024 05:29:03 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06A3110E4D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 05:29:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBcMGEhAAjnsAFzUW5Ci2d2M9RfYC/H9UGCdJpkC6dvlf9lurGyQ5FzynovMmEADxz0srtrF6lwdDKVQnXO2cDJ4Z6IJNB1EzLpvWdvoX/2PvqroTAEQXEz1UqoUjmLAH1mmDegiT/VqljxLcWQ5NJWT3U3OIqSVyVP58pcqcDwB7qWB2A5FeM0aHgJHVi72SqF8ljUg7vVhYlbZIKYjXVF54COAdb1S+Q34EKy0m7qw7dBTV15L26iLuzNznO97xUcDsQTGrXtkz5Fics4iemqAT3PHsDkmEo1wxWtiofIlkhz+iSpmU4YvrhLRj5MA/we0X4DfWNYpaFTsbSq3jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWCo4juEHUWovM8Xfr8xUi1sjJOiIxzTZpHe5NFT61I=;
 b=Hir+cFMP44/GIT9g9hxJclStRP8o+XdZgwPIg9hfG0NwjKto03Ig9YNBaU+pyjHHKyc4eMHrkOZTrWxA1D7/LI2n1z4pwuCjIW2RiZ4OVBG4bAou5z5TZpgZ+uzPNf7lgNK6jkHs77aiv/Dr5MnaJgK6KsYi2+lnnnz6T4lYC0DrLT1gCV6dL5Qzuc0S0gOXsVMAQqTg6/v7C+dszWne4qSc++x97uE71/wbwWj+dp9jEgy1XRU0eFQhSDtIm/hjn6gpDf0i8JMeKoElqdrTO0+OVLkrYonXuchFuafOP/u6zvRl90VxMyS4mDUyTtt8DoqzSoYAXvhXWKGIHlKibw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWCo4juEHUWovM8Xfr8xUi1sjJOiIxzTZpHe5NFT61I=;
 b=NbNWviC2/V97CwxedbFJxNNAZg+ryrJViAkO9STTWNWmoEetRndJlitnAXO0qIazH/3LxrljzfrekhWb6mnxhOwCJfh8LW5otEtZL00PSiLu+Vf5Sv4GJjEyTeJV+tQLamcBcnsUMFB1p8yvxZMQItrFdPljBZgC8sGB2tB1f7M=
Received: from CY8P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:930:6b::10)
 by MW5PR12MB5600.namprd12.prod.outlook.com (2603:10b6:303:195::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 05:28:53 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:6b:cafe::a4) by CY8P222CA0019.outlook.office365.com
 (2603:10b6:930:6b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32 via Frontend
 Transport; Mon, 22 Jan 2024 05:28:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Mon, 22 Jan 2024 05:28:52 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 21 Jan
 2024 23:28:51 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: skip call ras_late_init if ras block is not
 supported
Date: Mon, 22 Jan 2024 13:28:34 +0800
Message-ID: <20240122052834.2995698-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|MW5PR12MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: b452be65-b476-44c6-e9a0-08dc1b0b0584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JbFJS82uvhfSUusAQoOzH4LDioXU/CnDBXnsk+WBsAsR5nwNr5DkxNeq2PwtGR9AvQrAm1Sw5Sj+BveTswWoEP0LRAnBZNulszG2PspY/RkiDkjTpU7ylmw91a7aFIxnFS6ZoZlqjYv+S2+3568n+HrADz2GUwW2WLpyIk3InN8UMqAi9xnQo/x8SNyPin7fu12Mjpmqg9q0QVWKc9MZ0ZOUugysrzzCvvc/D/p53yrz+lmWpCy9pImkVzDTu+TbTZ03gfqK7pROCoYZXCuiTtpsdeJYagLPpIDyJ6F6H2JscsLNGIsFydneVH5w9SZhxlv+FRBh036qYfJDFMfNR/bJuepPRHWhqNZoCWWTQHkdQxBAYY+VjpYtNqv7S8X/o8OZyX33dmHWHSvNbS0cHaVlNrgBc3YIqKhPTQY5QpxUeL1JFx9ccvG9m2YbF/Xm7WTV/C+JqIrL4hLj7xQdBAUwg42wPgXU8oklezUTcbjDp4TxhZLpfiE5qYghJN4Xd7sCSSCyTqp6RvMhR2wiNPB7Pv5EL/ZwinyHs7XiBvpB3uxXdRSEc5gXShiTYHfuZOo7b1sW/2gTlEw0C8BDNzCALE4BLkGw68WKV4pPkfstivgtbIlmP+g9UUVoGn8JXqhuO11f9A5yv+tiL63mpuD0a4AgHAZQGlv0TEhUVb5ZgtsmHgzPsKstvinGhrQ+vTRZ2jmDiGbbZkkHbsTnU5Ow6YbGmfcgyDs8ZjybvFLuSIPdRe+HR439u72KDVpejCcKplkXA6piVEcdWZ6tFHRLBNoHyFAQTjKSsepyc8ZsW9rW73CLArYWKeUwxfAE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230273577357003)(230922051799003)(230173577357003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(46966006)(40470700004)(36840700001)(82740400003)(6666004)(7696005)(8936002)(8676002)(86362001)(4744005)(2906002)(5660300002)(81166007)(70206006)(54906003)(6916009)(36756003)(70586007)(41300700001)(4326008)(316002)(356005)(478600001)(16526019)(26005)(336012)(426003)(36860700001)(40460700003)(40480700001)(1076003)(83380400001)(47076005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 05:28:52.9861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b452be65-b476-44c6-e9a0-08dc1b0b0584
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5600
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
Cc: tao.zhou1@amd.com, Yang Wang <kevinyang.wang@amd.com>,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

skip call ras_late_init callback if ras block is not supported.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index f4fcb008d7ba..61ba7cd8345d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3346,12 +3346,15 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 		amdgpu_ras_set_mca_debug_mode(adev, false);
 
 	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
-		if (!node->ras_obj) {
+		obj = node->ras_obj;
+		if (!obj) {
 			dev_warn(adev->dev, "Warning: abnormal ras list node.\n");
 			continue;
 		}
 
-		obj = node->ras_obj;
+		if (!amdgpu_ras_is_supported(adev, obj->ras_comm.block))
+			continue;
+
 		if (obj->ras_late_init) {
 			r = obj->ras_late_init(adev, &obj->ras_comm);
 			if (r) {
-- 
2.34.1

