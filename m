Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEEDC77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 06:24:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C160310EA8E;
	Thu, 27 Apr 2023 06:24:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B491610EA8E
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 06:24:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YX1le646REDHTN/TN8sCLCBzfP2W4DAItCruWV5UT95GqcwF3YaTK/3lc/ocM4ywcLR/mIaolDmIc7qXAPID8K8yOASngzCQxcxrOYH2pExy+jaDMCf805BJT0IG+QFe9U4VqphwLjAj8KsnbFtgssfstQ69BFwGCehapJMyo/ydy0O0nw4q0ZIsoPlVUjg7xjVivASY4tGF+nBTJzTDal52K5QoI0c2xs8BTeSUpOAyOosS89rDhTi6q6mdbPntvrQ3myJFItlOew5sRcfTioVFeOLbeNDp55P6IukyZsCyw6PTvOOxmW/H0HFcvz96qMpfRlq1c9SBly/lZfwWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cERXJLNG/wYCFBVKsgjCqEdGTUJksftkD1qczMeocX8=;
 b=nHsmdHE1ihuIDQyWolKqValA7J3W0hyc/hId5shb3YiELy7cmYtwo+q/cAxGJ8mXXaNY/J554Rq0vA7xg1HdtE3D42dEVcUcPLpsPxw7a2v5wUQQ1dNKjr2UZbGvB0MXPwLQwfgytQnOuhSRYatxsFnxGvrDo0AW+Qrbc8rEfkZHzWT6pw1lrqRsr0T3BQXaT01S8HOJXvO9TKoufyjnlHayvSgBuhwQRHMCBAjwjWqrHPYIKr+Ay5+PKi5Ok0xdThgeXq7yOgqhDlONnrMK95z9G9n/vf8LHdbk38Bl4syALSCAPSB6TD5Z9Vcx8sLE9w/XgBIey1CrssmMoOTgJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cERXJLNG/wYCFBVKsgjCqEdGTUJksftkD1qczMeocX8=;
 b=VpKRKrvJtvCn4NKdaqoudvRbNw4NxxRa0rkfXw8qQifKJ9aeSG0CLoOdM97U7Fyq3UDA3/n0suSLK/Q3PbROvaSkbmjZXwnhCbBSoB8OVocHOmcCxf3bWhyk/Kt+V1MAXbQkbab/ekUYQ4Fz35Dx3gsWyj202RlJobosMjHXibw=
Received: from MW4PR03CA0350.namprd03.prod.outlook.com (2603:10b6:303:dc::25)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Thu, 27 Apr
 2023 06:24:09 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::86) by MW4PR03CA0350.outlook.office365.com
 (2603:10b6:303:dc::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22 via Frontend
 Transport; Thu, 27 Apr 2023 06:24:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.22 via Frontend Transport; Thu, 27 Apr 2023 06:24:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 01:24:08 -0500
Received: from horace-sm-debug2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via
 Frontend Transport; Thu, 27 Apr 2023 01:24:04 -0500
From: Horace Chen <horace.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: disable SDMA WPTR_POLL_ENABLE for SR-IOV
Date: Thu, 27 Apr 2023 14:24:00 +0800
Message-ID: <20230427062400.14032-1-horace.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT049:EE_|DM6PR12MB4481:EE_
X-MS-Office365-Filtering-Correlation-Id: de322a59-db1d-4e4b-bb72-08db46e802a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ca3SDcJDvwAwzWt9kqUuSCl0d6jDoJL/EVyqiLfF7UoiTEn4gVs1EJg4uLpA9Xoixb3Sxpyph4/wmnzoqQvflxlhhtEstdw2bLRoAeS9kWavUHQzDiFwP9ijaaC6xVIEks48VNDI6ehM2wPElI9/4C9UnB3c74PRyBnEXODz3++i1m8FNxtsj4Oux+JBJd+OfnkpI+duIhPcZ0xwGPTi7SwO6KwDQ8fkw5PcEFXn4DCr+RfgwPgaicTM8YuW0jksc+mUdMz78xVpJVN5Puv99O/4PWx9q27IqaYt95p/UiO0PU54RI9tv/d9g7EEfYghBWLTc/JhSUUdrGKT+VDqJ0MB7Gs/+ka2h5cp257Kvqzr04v8VNeF9+gkI9e7XHO0PEWggaIqbfS4qcMyf8DOx3jfroaz97leXbjN/1DmdVhktxUCxJBd6afcpUs53mvJQX13/DMaJwjqXVBT3PQhgTkkWHHr/b81Sn4IJoOjAoUEtKXT37G8e+SqkJPuN+XZBWehcIyonyWAl9xB/npiyanfoPsKv4NRK/QfkkegN/PRSUl2uBik4lNVmSAzYTiqeeBAw38fyS/2B7ECYS0/lTw0/hRcm12zgg8PcvxOlKvEhhMNT+V1Zh4KC7YAb3RfdXCi7KBubPQo50CQi1+XkHenf5gVpGfxLydOMGk5ntiRgqHXcT1Ilobl4zwQkCho9zAbUgt7BThsKlM3roGgs8W2W685Ie6QdhOqVGLrdng=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(1076003)(186003)(26005)(82740400003)(356005)(6916009)(40480700001)(4326008)(5660300002)(41300700001)(70586007)(316002)(70206006)(6666004)(7696005)(47076005)(336012)(426003)(83380400001)(36860700001)(2616005)(82310400005)(40460700003)(36756003)(54906003)(8676002)(2906002)(8936002)(44832011)(478600001)(86362001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 06:24:09.2489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de322a59-db1d-4e4b-bb72-08db46e802a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Haijun Chang <HaiJun.Chang@amd.com>, Deucher
 Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
This WPTR_POLL_ENABLE is a hardware contigious polling which will cause
FCLK and UCLK to keep on a high level.
Mostly its case can be covered by F32_WPTR_POLL_ENABLE which polls by
firmware.
So to save power, SR-IOV also needs to disable this bit

Signed-off-by: Horace Chen <horace.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index eb722830531f..3d9a80511a45 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -510,10 +510,7 @@ static int sdma_v6_0_gfx_resume(struct amdgpu_device *adev)
 		       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
 
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
-		if (amdgpu_sriov_vf(adev))
-			rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 1);
-		else
-			rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 0);
+		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 0);
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, F32_WPTR_POLL_ENABLE, 1);
 
 		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE), ring->gpu_addr >> 8);
-- 
2.34.1

