Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D37CC282DD
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 16:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EF462070E
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 16:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GIlf+w2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF462070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA2D36E0A0;
	Wed,  8 Jan 2020 16:17:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E1896E0A0
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 16:17:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQdjvBdlAH852cB1I/uD0WufCLvfSshbQoAowZ1rZOmtGqW6wChYDzZth4g6ONfEwe0bemrzC/eeqZt9gz4Z8BW3JE2bW2XjsTceHs0UN2ADtPnhCvwUudbmaLEEwrczzeshaIxYyf5QqFqrcnck0pwsi4ydijZeQCTvvf79MsIGxHu9dYhxjNB2RIWi0d8WHO8yidrdE5EaDowMsAikod86MlWhEcRWzQ+sF6N6QMovM4wqhDofAiEDTtlaP/VLlMifx0GZHMrKECQ/+OYJiZXUP9IyK7ehkfT+9e4Iw7IhjznozK0wL+VGosSA9+b+38drkSZcqX/SEdE9IwD8sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMLn1TvLXYfhsfL9T+0r8FJPOfO2HUcoU3m+aeJ+rII=;
 b=lt1jIfekA+xOPGoyKmFoCY7dk1msYN5Wmt7G7znCM6JC6nbCEPyy3+b3F3fRFHoWdmEEQH2gcN7jv5zZvbZZcg46IGZ/Bfr4wjXpCGqfTvNOypTah347DhJGbHzKAuyfW2nDbKu1Zks9dGEa5vG/LCRUA691sp6PJDi2/BwDL+U5vWYMihV5TWGUHTLWMlzC9ugehNLJBVKZwcy/HkFUJO8XQ/NXoQRt4/1etpjq1ZdKF9S2TseEUhY0/sVmeY57Pae0VPzEMKEThAI7v/OeVU3MtHV4dNWYwF8KoB/CVSMY8ajw0919VKANhp18k3a4ZsD2+NEJ7yk4elDSn97Dsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMLn1TvLXYfhsfL9T+0r8FJPOfO2HUcoU3m+aeJ+rII=;
 b=GIlf+w2CYxhrxr1TU63DV0eWYjCbe+zRri3nddyt+rl9qwZHv1OA9tGKb7wvEkFUid/NyHn6OrytFeTfK1o4rTcMMGjNFpYfAjE1cLSPUaa8qATpb3u/1ccBjYsieHQZuwo/pYtmX5ltnQbB0Q8lWoYGzKobugsPT9muzi1RVps=
Received: from BN8PR12CA0028.namprd12.prod.outlook.com (2603:10b6:408:60::41)
 by BYAPR12MB3607.namprd12.prod.outlook.com (2603:10b6:a03:dd::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9; Wed, 8 Jan
 2020 16:17:54 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::204) by BN8PR12CA0028.outlook.office365.com
 (2603:10b6:408:60::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend
 Transport; Wed, 8 Jan 2020 16:17:54 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2623.9 via Frontend Transport; Wed, 8 Jan 2020 16:17:53 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 8 Jan 2020
 10:17:53 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 8 Jan 2020 10:17:50 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, 
 Dennis Li <Dennis.Li@amd.com>, John Clements <John.Clements@amd.com>,
 "Guchun
 Chen" <Guchun.Chen@amd.com>, Tao Zhou <Tao.Zhou1@amd.com>, Candice Li
 <Candice.Li@amd.com>, Gang Long <Gang.Long@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: add ras_late_init and ras_fini for sdma v4
Date: Thu, 9 Jan 2020 00:17:20 +0800
Message-ID: <20200108161721.7727-4-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108161721.7727-1-Hawking.Zhang@amd.com>
References: <20200108161721.7727-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(428003)(199004)(189003)(26005)(70586007)(70206006)(498600001)(4326008)(7696005)(186003)(6636002)(426003)(336012)(2616005)(86362001)(5660300002)(6666004)(2906002)(81156014)(356004)(8676002)(36756003)(8936002)(110136005)(1076003)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3607; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8b6feb2-e5f7-483b-dd74-08d7945650cf
X-MS-TrafficTypeDiagnostic: BYAPR12MB3607:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3607B238C6C4333F49B58064FC3E0@BYAPR12MB3607.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-Forefront-PRVS: 02760F0D1C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ye6Mz+O6W7CBxiPCCb0Mzue5OMsfp3/uMZzX0dSeVse00nefloiRyrJ2cvuOoCqI+J2kj04rJe4LEe6GZxlOXhjcmON5yRVmJKglr5451/AbULT48tY2LqWQdES1Kz7JL1I1WAXv5FdPdHCyu+xThepfY/Q8RRdRbtvi4purwWyOJdCTpHgqJ509tcmM84y7v9Z5tUAlER9awNIQu9xTdgSrforKZRrsgvm87PyU24Z4smnSIOwBhkUUe8MVLEG7MAYhnWccccGf2l4OzDrUFY7ccddKZJrssQAWP+3tKpmp9Z6MovrIOp1W8yK0cDqWpKw0X4J0QC86OktzFCoGmtSUj4BR8923bEK5ji6t41N2B3tN9tU0aBRph+6h3ayTRNc9EpbrCLntnHwHfaWH4uOUQ83z8nq/ntbW+fK0TWchcFKS2PuNwCH2XWsJgRDd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2020 16:17:53.9082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b6feb2-e5f7-483b-dd74-08d7945650cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3607
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

move ras_late_init and ras_fini to sdma_ras_funcs table

Change-Id: If3a6c0defde4d23f81d2ff7ff79daa98a732efde
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 3 +++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 6 ++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 9e87a97f81fb..ee0ca996da0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -51,6 +51,9 @@ struct amdgpu_sdma_instance {
 };
 
 struct amdgpu_sdma_ras_funcs {
+	int (*ras_late_init)(struct amdgpu_device *adev,
+			void *ras_ih_info);
+	void (*ras_fini)(struct amdgpu_device *adev);
 	int (*query_ras_error_count)(struct amdgpu_device *adev,
 			uint32_t instance, void *ras_error_status);
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index a00b85934b04..fd20594b6d6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1803,7 +1803,7 @@ static int sdma_v4_0_late_init(void *handle)
 		.cb = sdma_v4_0_process_ras_data_cb,
 	};
 
-	return amdgpu_sdma_ras_late_init(adev, &ih_info);
+	return adev->sdma.funcs->ras_late_init(adev, &ih_info);
 }
 
 static int sdma_v4_0_sw_init(void *handle)
@@ -1875,7 +1875,7 @@ static int sdma_v4_0_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int i;
 
-	amdgpu_sdma_ras_fini(adev);
+	adev->sdma.funcs->ras_fini(adev);
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
@@ -2565,6 +2565,8 @@ static int sdma_v4_0_query_ras_error_count(struct amdgpu_device *adev,
 };
 
 static const struct amdgpu_sdma_ras_funcs sdma_v4_0_ras_funcs = {
+	.ras_late_init = amdgpu_sdma_ras_late_init,
+	.ras_fini = amdgpu_sdma_ras_fini,
 	.query_ras_error_count = sdma_v4_0_query_ras_error_count,
 };
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
