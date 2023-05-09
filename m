Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A526BC77B7C
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1891210E3DF;
	Tue,  9 May 2023 22:06:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8228910E3E1
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:06:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5QdKLgJY5Km8NlhZd6zqMbsuLwPylMLG8zxFPnir/1g0lmm27Fu0TwBfdEayehAGn7WmTIDBiLsXqDdTvp2GmHWGo3Jnc4HXmmgxDY4k5his4krWqYO6cEo32WWG3tA5M7P2/4Jht8L9i8bb2VGHDJMFWAjpOFrBoPdVH2xFjdoMd5Q7Xju1PkPsvUP6jrqJqLNYGTH2r39+0P9fi5p4YV0nzXZ3gh8rtpUp0YTihVc6G7/Ns1QUB9dQhijdQtCYknttmgvcBRzSD3Opl6+OzkX6eeYUoX9ZWqY+ep0nsJ2qQwDnU6CIIn2rMDd5wZ4Y1Xztq3tc7t7X/B01664kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYKr/ooJ7/PA5hYtGhf/KYHzuWWoxIDt6XkIwlyn9qs=;
 b=kX5hwpg6H79Zyln6s0XFC0MGkH6QUZCBt6UWd9BrBG3tC/YG4/mVhK4kC5/y45YD8UM2ZwK56El9bMjZvSkQlpvnOHEApEIt/Tkxr4SHyA8pERSeQbmwZ3NJjswrlc1ZCBm1P+liDA5kNojCBBODlviwAAK202ijNX6YRhl2YXUdd2jvQyVJuMU5IhE77XlRlDb5CktuRv4KIRBJfdetWJ+dKos+zIF+mETRx+98bacpqdy3FtKaW5X8HWmJ78muL13wlHbMCATz7S3aNvqOUzny/TM3PZMm59UJAqC7p3afJE1ZnHrr/KmU1gSdYgXdv8QwrUBZfv0/m1lUqJEeUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYKr/ooJ7/PA5hYtGhf/KYHzuWWoxIDt6XkIwlyn9qs=;
 b=pZoh5SlQI2ir2duJLiEhb5re9mISKYGsFrI/BvI2coQqVofdmQs0CrTGriBF6rUi3LU3rLEotucWX6mglherjssPOZ5ehBci7gnbsf4MpW58sgoT2+MTojynWBrIceV1Bex8eDjd+K1qIbYt1CWYVBXjNHJDDSTMmA/dRVtDHmw=
Received: from BN0PR04CA0063.namprd04.prod.outlook.com (2603:10b6:408:ea::8)
 by IA0PR12MB7553.namprd12.prod.outlook.com (2603:10b6:208:43f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:06:02 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::88) by BN0PR04CA0063.outlook.office365.com
 (2603:10b6:408:ea::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:06:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:06:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:06:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: remove irq_get return value check in
 gfx_ras_late_init
Date: Tue, 9 May 2023 18:05:45 -0400
Message-ID: <20230509220545.474998-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509220545.474998-1-alexander.deucher@amd.com>
References: <20230509220545.474998-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT027:EE_|IA0PR12MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 30a54ec7-4e88-4cf9-5e37-08db50d993f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b+1h2xhuq1E8ONRTuP7oRsGcEgoIoSWKmECR78zAVw9tvS6A/Eu1NQJIBlaQWG7G5V/jN4vV8bxuTvc1B+vhKbgcTvMOO5jbPgWUVTBy8QU5FOa2WbRzSZgVJNh2bQ5nZnhBsUpim4GqD8bssTXKgnq2tEDj8NMvh4KLgaHgVI8XWSWhgsf9rF4ynjTRSYTzvCWcqefxUXpCVMdWertMQZhI1aKJ1vNzzpSqcXhj/DUUSdYgd1+OiKJK9pt1Y6EcfDesj+t04kuOWYOtWL4ouXBmY62kJRmexnwePVXK4ydkHUq5sQQZiiWmGGc9oKkHI1YqO1Sqrk93hrVwohmdnGWHmY2R+MUJIQx7lLqLfL/mWeEVQER9TVeVvL3IixXjigq3otkktagEJckAWXoN+aED4+I4ERmGG1cRPFj69nv3FjeH6KixR7F2ptUeR2IAVnQpaQc2DN6BrEEKJOSBX5fQ+pdAXlMreEYaLcwY59GD0svhgWG4FhCo0i+CXpmUG9wFT0brsocLKYC47HcC3qcjulMeYtlNVxDzEQnjk2UY1V2kJFYYa6xsPX06++Q0O562a+FR/LyhYgcvuiHGPTgU7GLl7PAWq13gRf2LP1WlwyA5BqlH3oWqzXKfobWeh5ezdqnkv9395MxHlgo1idYWziPvZGqdY1iMpIfJNE5gtuV6S9XfW+sIsN7FGhwbasNsh3cjml4g7MhbamrulzjthPaI4hZ3U2X4C2wtPfs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(26005)(1076003)(47076005)(40480700001)(336012)(83380400001)(36860700001)(36756003)(2616005)(426003)(81166007)(82310400005)(82740400003)(186003)(356005)(40460700003)(7696005)(16526019)(41300700001)(316002)(54906003)(8676002)(2906002)(4326008)(5660300002)(6916009)(478600001)(8936002)(70586007)(70206006)(86362001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:06:02.3307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a54ec7-4e88-4cf9-5e37-08db50d993f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7553
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Not all ASICs support GFX CP ECC irq.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 5218d4837656..dc0e5d18a0cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -786,17 +786,13 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 		if (r)
 			return r;
 
-		r = amdgpu_irq_get(adev, &adev->gfx.cp_ecc_error_irq, 0);
-		if (r)
-			goto late_fini;
+		/* Not all ASICs support the irq, no need to check return value */
+		amdgpu_irq_get(adev, &adev->gfx.cp_ecc_error_irq, 0);
 	} else {
 		amdgpu_ras_feature_enable_on_boot(adev, ras_block, 0);
 	}
 
 	return 0;
-late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
-	return r;
 }
 
 int amdgpu_gfx_ras_sw_init(struct amdgpu_device *adev)
-- 
2.40.1

