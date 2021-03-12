Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C846CC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 14:35:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88EE864F59
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 14:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EE864F59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 488AA6F635;
	Fri, 12 Mar 2021 14:35:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE4966F635
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 14:35:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCZPu51zXKm1c0ZHB0L5/URmndDk07cwkSFqNqp8hbEigNGBNcPAyT53iVC/eSc3h2kiU4glcm/duzisTfRBBv7AoEfbzv49Z7sF9gHT+PyA/at4BwVmPe+Dgr9OZMYu+u0nigtGHVCObBl2whA4EN/Pcdei0UvbcrxF7pQnb6XB7B4XOvm1dxWYbSe0kGd8zmUkgNLBgwsjF6mcwAN4pOLXGenyIPhaIJR382zwdkMPKlZ3ftlrRREONGGMfMZrgTC6LknYbRzmpLuCwQYMI/6TC5M9ZqDka/wEdhOYA8vEzUbofvnZkT56Syt+8NsAKBxbv+0x4QiU3tXVQP72rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsYzTjYr7VlYNJJn7bj8GDZG8NM9Sl0gLKjov9m2Amc=;
 b=MJ8H9ikWG1l6OaVQNNgdUQQ1/yQT2Vy6JvmgWzwUhrovz1xkywx736+uRO/EFb8M7C3UxLPh1XPjOPsGCJ0Y+JGgBvOft0J3S0NglvjHQ1PKs2/KRoueTu1Lt+Vm09QtAR2oeuHS192x6Krzuy95HqXgM2g0HYqJxnosGx41W5rwN94MYwims5cuejPKydVR5JRqSYce4Nh/QuxIIbY4DD6jL3kBqdxancl6qpnSoq/EaG2sH8/UFqh0WC9KVLCUeB0xQDCNDQ2CWogQaTlUlxinoMe5iZUWTDHfrejOqnlX23g79gEl123ITH351m+K0GpZcPpAmXRv7SpgZQFI1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsYzTjYr7VlYNJJn7bj8GDZG8NM9Sl0gLKjov9m2Amc=;
 b=ct+vO1uKED08In8NTbPW2Q3k+U8Q0BF8fTZrQex5Dv3BdyHDW6OneVpSo8uMb+WgELvNsHM3TqCjt+xOMrSo/KYN6NIaySQgFLG2MjC6cD6TkQfR6tERFZdqdG3EKdrujMckQ+y9brdeKAMfTeR0LDSrw0aCSYNnf36ieAbOyrc=
Received: from DM3PR03CA0014.namprd03.prod.outlook.com (2603:10b6:0:50::24) by
 DM5PR1201MB0139.namprd12.prod.outlook.com (2603:10b6:4:4e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Fri, 12 Mar 2021 14:35:38 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::12) by DM3PR03CA0014.outlook.office365.com
 (2603:10b6:0:50::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 12 Mar 2021 14:35:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3933.31 via Frontend Transport; Fri, 12 Mar 2021 14:35:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 12 Mar
 2021 08:35:37 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 12 Mar
 2021 08:35:37 -0600
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 12 Mar 2021 08:35:36 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Frank Min <Frank.Min@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: update ecc query support for arcturus
Date: Fri, 12 Mar 2021 22:35:33 +0800
Message-ID: <20210312143533.14863-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d843329c-6b50-48c4-a29c-08d8e5641af0
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0139:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0139596B70CF87BBCDE1AC09FC6F9@DM5PR1201MB0139.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ihVo53wEzkVroXnZ/PWnZcN86GhIB3rcASYYDkjoo2QX/ta1KFpLOIbOLsYLB70gPQrz5hykRolnqRVnrO36/Xi03ynzeypy7TOSLliUARzEUnyRqredCxRIUW7+9R5j2gtvdjulhixVfTu4zKbejUnKqDn+SlpxgJdcrvJMorP+V7LgC8ATFWwFiVZjGnNFtkqqGLxOcZZ/yzvH/8MUJ9BY5J9P0PIuSAYSExHgmuUmeCyH8BH4ycomMPjWwTmj0vLaeGkXl25H149jPRx3hZ4U9ayUC1Xc03f/WRUFhMBjkAx+ijnNlPpYdliVtRVf1U/bQJeQDOaanqfn3SzKpz9ItSMMkpQjvxNhboetyUCfFKK5QLpzdeOwQVcJeEOntkc+qKItt0XlnCDjoo4vJu/4oK5wZdj8b80wywi3+0hZhUdYLG+eBkJeCeXzIdJExG0tbwTUGSxridC2QFXc3EAUnztPkGwu++5QnhB3cRBeygJUL50TvfMSwdE5in2nwnvsrwnl22P+Xrr0RZ0/+9Y8nRmC+hsVXXorusNMO3SmhI+QJFo5dEEhte3lg/mA8xOs/NLR5G6ftmOniY3cc9mxCtIdtgnF27uKUejSloyQ9Jy2HIq+LxN5qgpmN8q5oeibJO/SO2+O+/ssScAZjmwPOaTf/gGcpZ3lbjTRMvouc7iR/pq2uuo9OMkMtOKG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(46966006)(36840700001)(70206006)(36860700001)(86362001)(5660300002)(81166007)(8676002)(110136005)(8936002)(2906002)(6636002)(36756003)(356005)(7696005)(82310400003)(6666004)(83380400001)(4326008)(1076003)(336012)(26005)(426003)(2616005)(186003)(316002)(70586007)(82740400003)(478600001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 14:35:38.3423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d843329c-6b50-48c4-a29c-08d8e5641af0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0139
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

arcturus and sienna_cichlid share the same version
of umc_info interface (umc_info v33). arcturus uses
umc_config to indicate ECC capability, while
sienna_cichlid uses umc_config1 to indicate ECC
capability. driver needs to check either umc_config
or umc_config1 to decide ECC capability for ASICs
that use umc_info v33 interface.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 2b5c823995f9..60716b35444b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -361,6 +361,8 @@ bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev)
 	union umc_info *umc_info;
 	u8 frev, crev;
 	bool ecc_default_enabled = false;
+	u8 umc_config;
+	u32 umc_config1;
 
 	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 			umc_info);
@@ -372,19 +374,21 @@ bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev)
 				(mode_info->atom_context->bios + data_offset);
 			switch (crev) {
 			case 1:
+				umc_config = le32_to_cpu(umc_info->v31.umc_config);
 				ecc_default_enabled =
-					(le32_to_cpu(umc_info->v31.umc_config) &
-					 UMC_CONFIG__DEFAULT_MEM_ECC_ENABLE) ? true : false;
+					(umc_config & UMC_CONFIG__DEFAULT_MEM_ECC_ENABLE) ? true : false;
 				break;
 			case 2:
+				umc_config = le32_to_cpu(umc_info->v32.umc_config);
 				ecc_default_enabled =
-					(le32_to_cpu(umc_info->v32.umc_config) &
-					 UMC_CONFIG__DEFAULT_MEM_ECC_ENABLE) ? true : false;
+					(umc_config & UMC_CONFIG__DEFAULT_MEM_ECC_ENABLE) ? true : false;
 				break;
 			case 3:
+				umc_config = le32_to_cpu(umc_info->v33.umc_config);
+				umc_config1 = le32_to_cpu(umc_info->v33.umc_config1);
 				ecc_default_enabled =
-					(le32_to_cpu(umc_info->v33.umc_config1) &
-					 UMC_CONFIG1__ENABLE_ECC_CAPABLE) ? true : false;
+					((umc_config & UMC_CONFIG__DEFAULT_MEM_ECC_ENABLE) ||
+					 (umc_config1 & UMC_CONFIG1__ENABLE_ECC_CAPABLE)) ? true : false;
 				break;
 			default:
 				/* unsupported crev */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
