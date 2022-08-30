Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B8CECAAD5
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 18:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C96910E36F;
	Tue, 30 Aug 2022 18:40:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2658010E36F
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 18:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/ZIh7sJ7pW+sSNlqdzZiLx4DTera8wXbnGk0HUjuktxjb5owBCuEhV1PEGfVV/yQ83+0gI5hZZfpfc+UZ9ujcUGX1S45/dyw8skcIw8sY76Ljm8Dc5xswAYpOx1WBg3x458lTag2I4fkeWcSs9naNl42F4AeiNS9egCuPFQlTr1NpgxGRIQLn5gTkzuEN7kAUC7GYi4NlRx9gqmgUBJ68mL6QoTazh/UiHo9yrkKveqLHm6RWHYMMx6AzjgBHWohI/77+NUsI9wZzbhflan97XUZpd+t0xEjkB50FnoWIATe9aZ4ejgfQ3TIm+uL+eQmBC4fCnFFh5eRicw3wp8nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmC9gRT3gJv1Ch/02WcYoRUx8wOvDP7+N13c9Jr9xTY=;
 b=h5xdDKpjY57++g8Eb1pe6mZRNyI1NcROPdlCtIeAqJscBiKiAyCqaPrgTRHob9jnRQFtlWbBVPJzur1Iqm3NkHIDrRvZhtSJJ48D5634J8F9H29ms+QdssL78h83W7g2RAjfOqMmW9BkGXhOmcoCsFpOUzYKJR9KmggDG5hmnjKdfNVOyX0fZF7bmI+fhUDADAKs8nvhqz89VxpaUPSP3MUG/jZixxnpH7QHR/R85nDuzii9FhqyihKuyCDXM9CkjWl3psyBKJKORZ4x78EF4UO7Gbimu5vkVooEZFpt8c91g9cVdfO/vDGJCdPOnGq6pasv5kMO357Bx7gIes6kUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmC9gRT3gJv1Ch/02WcYoRUx8wOvDP7+N13c9Jr9xTY=;
 b=JRwxLli8cfEGNL+t29gOZ5nxi6p7Wy8gLMpWZOAJViqwVSlwwzdpZP/oIZDgJG32vhl8I0dEyIJAkB6uKx9fwORrWquwvVc1NmpUA3nPojuoGlB5T+VSV9HX9an14E8c0JDWpXahAPsHbJemBRvIeDrfQJBmbHSgA/s70Yb1q/8=
Received: from DM6PR02CA0100.namprd02.prod.outlook.com (2603:10b6:5:1f4::41)
 by MW3PR12MB4474.namprd12.prod.outlook.com (2603:10b6:303:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 18:40:27 +0000
Received: from DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::6d) by DM6PR02CA0100.outlook.office365.com
 (2603:10b6:5:1f4::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Tue, 30 Aug 2022 18:40:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT113.mail.protection.outlook.com (10.13.173.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Tue, 30 Aug 2022 18:40:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 30 Aug
 2022 13:40:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/19] drm/amdgpu: add CHIP_IP_DISCOVERY support for
 virtualization
Date: Tue, 30 Aug 2022 14:39:54 -0400
Message-ID: <20220830184012.1825313-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b02e7b0e-a126-422c-0d23-08da8ab71b3f
X-MS-TrafficTypeDiagnostic: MW3PR12MB4474:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QA6QSv3GnhFC9+D6VQ2xOryjmsQk5IacHhtBYPvrFdDyKN2eiZFUW0Y1aGQhA2TWEvp9DUIYPh5iUQ9LClIVWraKSrx+o+Wdmw53ye7WUYr2PsqO7PtY6NWfMuxmJktRDsKg4vGEU7oqENq2VADy5GElRq252vHvonLnSJcUYmSVK5eIfGiSnblOTezHy0vm9XHQV7wyao3qqjnO6NpU60+zq9Fa8CSRkJvQQhWi0x1I42yszYUNlkHPMUYTQubBg6FxOibOwzFrzOQScAE5t9BkIZs/XywiAswv1CLUDtMFnuCFmmAS0ZFmNbM8zbRbmYP59HR60HJTJqKBNjBU5utmFILxDbr7tWSoPnVAcX0kWg/kBiivmxaOnajU1UG60ey5Kbv2w1R8zGz5ALeh4q6K/Nz5E7RER5X9p+hMYYK42ZBXIpl/+u1Jywxvcd0+GpWhzfSZ9Fy9ukM7cGoTEh+Tnu9EcikNDOjHwWG2YqxCL8tpd37NrNA5X9bDuX2yPnfrsh7sjttCtP7+4JlmdyPV190Aailc+Db53TvYYr2z2ecSrr+idrLUMRaFVDrGz/2bkelWe1whZwi4Ykeq5pWQiWXSrmsPQD17istxHeKjROHLRm92riWKoM906MTWZctlofbjAVkGvk8FxU7zciAS/Cq28fgVsx7ywIqLlzEr3DSgICNrEyQqbXSXyduxKE/NE0ryLDDjgZBhngSFGARcRJ3G6MNzldr4vgoxQn0t/jNhJRXEk6zDnMIuhq84IN17npHs6/5SRu/MsuBFE2NIP/YxPXVNAIVEWOvM7bFMTrDiORfIfemhEwOT0sIL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(136003)(39860400002)(346002)(46966006)(40470700004)(36840700001)(40460700003)(70206006)(41300700001)(8676002)(336012)(4326008)(478600001)(40480700001)(70586007)(16526019)(36860700001)(2906002)(83380400001)(7696005)(5660300002)(47076005)(26005)(426003)(6666004)(8936002)(316002)(82740400003)(6916009)(81166007)(1076003)(86362001)(54906003)(356005)(36756003)(82310400005)(2616005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 18:40:26.6174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b02e7b0e-a126-422c-0d23-08da8ab71b3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4474
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Horace Chen <horace.chen@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Horace Chen <horace.chen@amd.com>

For further chips we will use CHIP_IP_DISCOVERY, so add this
support for virtualization

Signed-off-by: Horace Chen <horace.chen@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 9be57389301b..0707e4338e65 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -707,6 +707,7 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_ARCTURUS:
 	case CHIP_ALDEBARAN:
+	case CHIP_IP_DISCOVERY:
 		reg = RREG32(mmRCC_IOV_FUNC_IDENTIFIER);
 		break;
 	default: /* other chip doesn't support SRIOV */
@@ -750,6 +751,7 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
 		case CHIP_NAVI10:
 		case CHIP_NAVI12:
 		case CHIP_SIENNA_CICHLID:
+		case CHIP_IP_DISCOVERY:
 			nv_set_virt_ops(adev);
 			/* try send GPU_INIT_DATA request to host */
 			amdgpu_virt_request_init_data(adev);
-- 
2.37.1

