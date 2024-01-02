Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26974C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 14:08:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4C9A10E184;
	Tue,  2 Jan 2024 14:08:30 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A700010E184
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 14:08:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFkgVU0ujOKB6GBFOCZHkXNGbtMnx3s91xhwOiKj6GQLo7fISgXibQ80qZFw9LQvh/nRpkTCdFrlGgoIh0Wsd0p5q59O1GvD5+rNKdxE31eSeTzBPjvoPzHN+0m0EtAwn6HxXW1SCtIHWnDv6f6m85H2MaUVRvlYLoxEIRHkImG0PKn3SQdAcoSM9PDQ/T7oKr+lX9HuZBYRqIdwkONCUFv7CtvOhdGVdxNKFNF4qFkIbxjMbv4E43HZYyQ3uYX2MwlJBn0rl01iagLYvSdqjJa83NIwEhUQG5QifQr09BFjYUi/M2SqRkdh+SVD/90Y3vheT0s3rSrhyZV0MHRYzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgAVzo6NDr6nRRMPejbzkZ5VRVp10MgvNxe7KLxsi6Y=;
 b=Pf4wqbcJ+aaqPIXBY53f3p/IUVn6i8A45LO8qv3g4Ee/0cnJ9S3P1VMrdIIQxG3iuUyeQPhoItFNFrYmuf15sRbQBJZHpRoXOroUUJFfai4aBhg/tiryNDM+qhSfMLmAicA8CV+SJsQcpqxdsjSgJPnyomkGVeMk92RFwdgl6Q2o4qjCGAjr3lDWbkGy5vffsv1LQdC6iS75ZUfxELhIl/A4a8szSEvvOrgthqLI2tXiGZ4nR7YRPFexH6LBg9H/SQxABlBqPR94QRmfdXg8YG+9Xg4Zdl2ETsoK3DuaahNZGBOk+pToOpl6QiT/+U09Waco/RI8Uaww+ARcDQ7SPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgAVzo6NDr6nRRMPejbzkZ5VRVp10MgvNxe7KLxsi6Y=;
 b=j1C7M9tR54C+7VIIrAkWfarnEPaij7/fpgRCdQL4WYeqotA4kGQbboUgl0BTs+1vUlEmKTLPh/77pff65X8mgwKB0ZNAbKJb0JOhnJh7jbbAuiZxmnho+llV/xh9JoIzYpoz+NfXIDJuHFeP7rfhpHCu7vxpKQUozhP96XIyaZc=
Received: from BL0PR02CA0099.namprd02.prod.outlook.com (2603:10b6:208:51::40)
 by PH7PR12MB6417.namprd12.prod.outlook.com (2603:10b6:510:1ff::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Tue, 2 Jan
 2024 14:08:25 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:51:cafe::86) by BL0PR02CA0099.outlook.office365.com
 (2603:10b6:208:51::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20 via Frontend
 Transport; Tue, 2 Jan 2024 14:08:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 14:08:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 08:08:16 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 08:08:15 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.34 via Frontend Transport; Tue, 2 Jan 2024 08:08:13 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Yang Wang <kevinyang.wang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Candice Li <Candice.Li@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: Query boot status if boot failed
Date: Tue, 2 Jan 2024 22:07:37 +0800
Message-ID: <20240102140742.23917-5-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240102140742.23917-1-Hawking.Zhang@amd.com>
References: <20240102140742.23917-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|PH7PR12MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: 7111d3e2-1b25-4e95-8445-08dc0b9c4971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L8TtfbONzdGAmBrHTZYkZ/xX4QgMztSW6xtCinjzSr5GuccbP+ddaFsD0dHEh8Iumoehjf3oX1mO6xBHJS/rgaY8kEFFV1DJ8ePC7Ds9JJhwZ5HxQClW4L6IKNKKk53OjybDk7aqppVr9kWTh3TpKiJxVwPC6dK0IoHiB8IsL6Fdv042cwTtFenGhnmzC8JnFP732IsEIOYjPRP0GJwUgEa8ccCztDx0cyNm2WEVnsRMIDDv1eL/go8UBxJNA5yyVrm5s1oBdtXLcmJvunYA4ywKoRbWQWs41POZ79ZDk1Oil5pPdysIUf0uOhfjW0ULNPoZppYaKVivr4eGA2rpgWT0YJkzB4U6L5f1xGKCRv2CT19IZpWc+SdFKIE7ATtGq70t7W3MXGKCNWVCwmOyd8XYBklFYhKUHieEewk6onpbwS3rkJ3r/BOTRZM2MZd4gD0c04Kk6BMiDxWu0zazp4dUJrn3Zqc7KmH3i9VgeihICY6W0WDyxFSp1rMCeP9ppCIM+6DNN4cY3hiYB0MCr+VU5BmSVP1xux73WwDpxggKJKxi6E3UNFc46dE6/WzsjtIBNdaiFLK9dRpGmfrsdTfrr+9//Oqz7SzDj0qiHijTd5nynLorB8LBmI3JtoyBHZfcrG79eflPqJEH7XoKxxEFZusr4I+aKRRFef6Mw0tdk2YQ8pWaHt/Gm5yNVcYFtxvUF99rPI5rEDo8tB04rdr4PqEn8PxAKqdCN6KNEUE0fg6gyQ/Dv/NZaJMTJZUukDxvdJHeX0wDIskJCLU4RQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(1076003)(336012)(2616005)(83380400001)(26005)(426003)(86362001)(81166007)(36756003)(356005)(82740400003)(5660300002)(4326008)(7696005)(6666004)(47076005)(36860700001)(8936002)(8676002)(70586007)(54906003)(70206006)(316002)(6636002)(110136005)(41300700001)(2906002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 14:08:25.4278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7111d3e2-1b25-4e95-8445-08dc0b9c4971
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6417
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check and report firmware boot status if it doesn't
reach steady status.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 6fad451a85be..676bec2cc157 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -187,11 +187,18 @@ static int psp_v13_0_wait_for_bootloader(struct psp_context *psp)
 static int psp_v13_0_wait_for_bootloader_steady_state(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
+	int ret;
 
 	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6)) {
-		psp_v13_0_wait_for_vmbx_ready(psp);
+		ret = psp_v13_0_wait_for_vmbx_ready(psp);
+		if (ret)
+			amdgpu_ras_query_boot_status(adev, 4);
+
+		ret = psp_v13_0_wait_for_bootloader(psp);
+		if (ret)
+			amdgpu_ras_query_boot_status(adev, 4);
 
-		return psp_v13_0_wait_for_bootloader(psp);
+		return ret;
 	}
 
 	return 0;
-- 
2.17.1

