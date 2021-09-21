Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC25C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F372361184
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F372361184
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D5896EADF;
	Tue, 21 Sep 2021 18:08:35 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2087.outbound.protection.outlook.com [40.107.95.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1108F6EA9A
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdifgOr8RaXVjiXIkWALfNiZVOCmgxKq5+S6pvUHjeowymQRV4jpJ18KeBGaL84C+NxWeLge1+4TJG7GxfKtNqFJ1DAZ9DyI9SjsvEdWeo56jaN9Clnl4lUDdbdtHuoQ188WXtqOi6ko6kJqJE9qF5cXXkoFVHWYCS99xxgVJluUNoS1UG2mHGLRh214EdbANEzD1yvSUzwRZgZQbfrkoDXssXaWzgIbDUWGyY3/e1+8TbcvQH6A7eFKmbIIbSrk3bp9dXLWRQzAKoM5mLbG7R70MsHbQiilJnLvPO8Oea6j1pQ/AyBo00CrlrLun0abLVV162R8hNtmcSc9AIburQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=OPMIRu+XfdZ+hhyOEHU5yz1lTZriwLlr/3YeY4Vg3RY=;
 b=PkpIf+WCAYMaz0q9aEPxNyQDzo1AHME1V0F062VJTwbWSG2R2+UcAgPk1Rd+0z51p1az7b5GYEseRVyiLAyXqXHdFaPANNgYmlvdo0NKpGEQQcnofCBCyogI3T1Hc2Q9iRkINZOvz4sBupUxM9N2s3R+A+cbQNKzULITUTQiXmUOKp/HuuxOsaJB1bqKus90UvprEYxNlWrLCbI8dQxeaPAWMfS9d6Ds9/+spVvIPEB7G1Q1bD+IOyB81vfwX99jOgnb6otWoo344IyNW+IbTu6ANhus74Nosn0ggVmh76F/Pvewb46vn3tcn2cZ2nHDFPEN2t7DHwkGCJQ0SKwsWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPMIRu+XfdZ+hhyOEHU5yz1lTZriwLlr/3YeY4Vg3RY=;
 b=4biOj3gBZ87o+mDKsgYTKBQxNUZGAu9Rm9zcEvZsgU7zJ5IJa8D70fHBWMP1Sz9gi5qD/dYKHkH0zdQwQU6nf74lRO4Qe2bBtYxgOWs4a9qy8iw/ZznPE6fHWHvARRlzL8Lz/zE/YX8Bjvd+sxQ0i4gNjVvmm+PXh2cIirw8EeU=
Received: from DM3PR14CA0140.namprd14.prod.outlook.com (2603:10b6:0:53::24) by
 PH0PR12MB5497.namprd12.prod.outlook.com (2603:10b6:510:eb::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Tue, 21 Sep 2021 18:08:08 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::f4) by DM3PR14CA0140.outlook.office365.com
 (2603:10b6:0:53::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:08:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:08:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 58/66] drm/amdgpu/ucode: add default behavior
Date: Tue, 21 Sep 2021 14:07:17 -0400
Message-ID: <20210921180725.1985552-59-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c36f998-4a0c-49ed-cfd1-08d97d2ac424
X-MS-TrafficTypeDiagnostic: PH0PR12MB5497:
X-Microsoft-Antispam-PRVS: <PH0PR12MB5497B1AD648C60BEC99C3139F7A19@PH0PR12MB5497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4O2IORBG+Ce6CZX1yNFHDrrOjbfBH3DmWECMTQx3CF34ZdI4fFkt+LwJ7mGBBiW/dKWSTk3mrenoy9lBFXNcUaZKUEfa/+oHuYpaEBKYwWzwP37okD42ckWFW+axQPezz/g/WPE7L/II5yNB7AmT9Va7Kl4RCutplB0/nRhlExruc7f4gInJRDGcD4PEn8mhx9zWaMDdIplvWbgzPQxdkioU9mRRauZoCag7R6GQlIxPLelKvMFGBVVywXB4n1Rmjm4/KZpNI/r+hEUp/NOz5Lxs+gwgzcfJmx5I+hTTjM9Fwu6lGuprL2N/PZLBai8waUZPCghV8TMIhUD9gDC3Gd1Fwow9FHaLZyHidLcU/IRBI/73nQvS3waQY/v+eQcW2JcPu/1TYpE9/t3CT0RqezFyixnoqKqYQk/Yj6nytUNRT+hbkynocvYHPMYuMvjgoXyS1GwLliXWf0UNvSytd93E89By2F8BusyYYvfSyauvGs8paryWd7ra0VPjNxqLfhO4ky1Nel1Elz1FyP35pdPcKXuwMB0NrQzqE7kAV+2VVK/t/NPfMIhH93awIyf2ruMliDvBj53tyH8c+dO9gtsJrtoJBwTXSueOMwoVbUapDhB6P6L4/AiL7e1prHCglKUSzJacCqIYOc+hPKnPZut4bMRROSYAaxQpNKJJcSn0KYo3AHkQaLP+CYELVma9nNLV0ZqF2/24CSrm9MSDnjLliAnCiRdSQGS/I51Qqgk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(16526019)(36756003)(83380400001)(186003)(5660300002)(7696005)(508600001)(2906002)(316002)(356005)(82310400003)(47076005)(86362001)(8936002)(426003)(8676002)(26005)(4744005)(2616005)(4326008)(36860700001)(6916009)(81166007)(6666004)(1076003)(70586007)(70206006)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:08:08.1681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c36f998-4a0c-49ed-cfd1-08d97d2ac424
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5497
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

Default to PSP ucode loading unless the user specifies
direct.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 527d67ded8a0..0c3127f37686 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -416,10 +416,11 @@ amdgpu_ucode_get_load_type(struct amdgpu_device *adev, int load_type)
 		else
 			return AMDGPU_FW_LOAD_PSP;
 	default:
-		DRM_ERROR("Unknown firmware load type\n");
+		if (!load_type)
+			return AMDGPU_FW_LOAD_DIRECT;
+		else
+			return AMDGPU_FW_LOAD_PSP;
 	}
-
-	return AMDGPU_FW_LOAD_DIRECT;
 }
 
 const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID ucode_id)
-- 
2.31.1

