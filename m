Return-Path: <SRS0=y248=KD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCC9C433ED
	for <amd-gfx@archiver.kernel.org>; Sat,  8 May 2021 06:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C00B61154
	for <amd-gfx@archiver.kernel.org>; Sat,  8 May 2021 06:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C00B61154
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F7906E855;
	Sat,  8 May 2021 06:48:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DDE16E855
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 May 2021 06:48:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwdfBOuB42pFCPcUuLuCM0ALgkWxRgXB091gCLYtMM8U6qZ6zkn//kuRjLppRN3cwRqWCzpkUDAq1bu8PCQwTthScyw+QN8qO21AiL6XTfQe23ul8G/MSP9XyAX1DxmxoDiLryo53zzQRoZczdhf2FKUvm5WffGsC84u7heQ/QtMqaGeJ5zA0z7SPpdYGGzqgM7eqa/pGFTfxApHqSS2ZIiEH3NQlhXxtJYV+HVZfnhn6T9MswiobPtamfc9bCfX/Y4chil5iaAicNR2anrFgC8e1E+6Dhc0sv5AxZHrVxStXcKybLzDFfF0mS6OfY0q7Dgt+kGPuKTLzRDbFcsyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpeKo+yZyndBeNytazt9aYSkj7PgSU1k3elRQJdzecU=;
 b=OuI8jFPmK7dWYSxfeZ5liZdq4q6gQfDuLZ1n1ysRjSa3kjWU5bMdq4nTXOxWbGDXOjrikKXyLpAtWzasbE/PSmmdwOz4cQBdA4x2/mNyWcwYNo1BqbiT9FOk5TuOoealxEsOzGvwTeRRvo/ZDTWp078D88siAFLdgignAzQVDijofLpvoRIi841fes1CgMc+/yxI9hBXvUqQTed8DadBCte0+aHN1lw9BNz+/+3zfbwZIdqOSTPGGXCwalDrCzsoJlO8OYhk1MVWz82DalpFYzHcBBYCSu4wMUElaTzjYxoEwg0VZ1TcZs/NrMjxr5cKomxhmP70l2LmYNHDz0pCyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpeKo+yZyndBeNytazt9aYSkj7PgSU1k3elRQJdzecU=;
 b=lJrIOsx+emkqnnzY0EGTZHYf6Cy+gDBDb+g2XDsL/N1cEq0OIFE2QmI72eXxCJTJOLfrAL1r2XgJ9OpvRSMd1goLUOJFjmy5MSJQbQgZcSp7oTB4JWxeoMeMCpdYcFqpjOjDdL+AJFlWSWGScP/luoCKXUoeB71R2/b57uWmAHU=
Received: from DM5PR22CA0008.namprd22.prod.outlook.com (2603:10b6:3:101::18)
 by BY5PR12MB4886.namprd12.prod.outlook.com (2603:10b6:a03:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Sat, 8 May
 2021 06:48:14 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::68) by DM5PR22CA0008.outlook.office365.com
 (2603:10b6:3:101::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Sat, 8 May 2021 06:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4108.25 via Frontend Transport; Sat, 8 May 2021 06:48:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sat, 8 May 2021
 01:48:13 -0500
Received: from willgu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Sat, 8 May 2021 01:48:12 -0500
From: Jiawei Gu <Jiawei.Gu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios
Date: Sat, 8 May 2021 14:47:40 +0800
Message-ID: <20210508064740.7705-1-Jiawei.Gu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e9f45cb-0e7e-415d-2df8-08d911ed40ef
X-MS-TrafficTypeDiagnostic: BY5PR12MB4886:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4886C51266ACC265F1968B13F8569@BY5PR12MB4886.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:374;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tqpdnAiFpoV7xXttgfQK/vLUub3ECidRyM4fmkZeuQCOpsFBVaFKZ40ccsVJM6FMqHubD/oyCQ7W1fiMXp+37DrSpJz8blTyBrDTBV0tU7f/8XQyx+w+HPCWN1kP16EKfeW7IvniCDkEXU4hC44tXnC0WfSv4bZlDWTuoGOwseG3BsMRFplsVK6FRMi0bp4Qn6wXXI00pZ8C9qF7qw+QN4VpUu63i+94RynynkRIQKJ7krLoi7sOjvIjwzlg4RyBHwJDCiYIT/DuUg8/HwuSd+0n6lB1pX9SxDNbbYvafbWC7W5V2oRwjG0lGsQUpkrcUAmhv1WEF9eCu243Rb/IO7kaZv7JsLiVnCUjVElcnjjhJXONIfLlITaDQos5Yo8S2IiiNg9EgJysJsZmPJ/3yguzBCveL2nnz5HE05tZzzbKoxLIWw9fJq0sKHewqlc/O04psCJcgBMfxliV7JHMpHvYFRuyHKZ4WSXt5+2TRtYoBkE8S44oRZWj+SgtPqIhZr5kmlgpynSrDC19IKSI/nCk6HLr/7SFfDZtG5Ov4Wb/ANM/4MVyqFxb/fv7UKYML2I63ZLb3JIYiVwZ1OJbWxXU1dpg16CA1riMdScg877xeodymV6adKU+NotAshF1DmGMx/j7MMtu9c5jDYDg22zcnNmd30n65nL9KA51rkct7DR4tkG/eyrrNMY9BP06
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966006)(36840700001)(4744005)(478600001)(8936002)(82740400003)(81166007)(426003)(7696005)(336012)(6916009)(316002)(83380400001)(8676002)(356005)(6666004)(36860700001)(2906002)(186003)(2616005)(47076005)(4326008)(36756003)(5660300002)(86362001)(70206006)(70586007)(82310400003)(1076003)(26005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2021 06:48:14.2954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9f45cb-0e7e-415d-2df8-08d911ed40ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4886
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
Cc: Jiawei Gu <Jiawei.Gu@amd.com>, keescook@chromium.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

20 should be serial char size now instead of 16.

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 2b487a8d2727..1c20721f90da 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -957,7 +957,7 @@ struct drm_amdgpu_info_vbios {
 	__u8 vbios_pn[64];
 	__u32 version;
 	__u8 date[32];
-	__u8 serial[16];
+	__u8 serial[20];
 	__u32 dev_id;
 	__u32 rev_id;
 	__u32 sub_dev_id;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
