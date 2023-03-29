Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD31C77B61
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:25:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97BB910EB3E;
	Wed, 29 Mar 2023 15:25:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DCBD10EB25
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:25:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nND7a7jl0A4OFfL0IxOjJpQzadsErdSsFEIiL+ct5zHu/RR6srfPvCxsK4Aa5XEdfEh4Tq3vynsugcOuDndEhuT40XytUNSQEkCbPXlUoFMAZaERpdSJ/3Iau4fv3kj5ldt6ZPSHWbtiQNd1zbwf2vj88AC1Hsh+mvl81+wt9Ft/02KuRQm7wf9dEgvTR3ahtM82ZVymq6Y0sfDRuxQY9LkK8Bv+CF/790Og/6Wts3B+Xsom4jqFTkRlyoZ4/IUti0cbpEWlTduUxt6rSqPKr5SHf8KxCwdnZyOEb1pfIZW+LhtPCkU+DDZZwh4N9kxfN5kUBYHzGyHngXrpvf6RiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pJzRDdEHUokjZtOU8RGfsTcRv0qQQII312HSeaI0Kk=;
 b=EtA14P2JffOyMsyZK81CrbHo8iS266p3v2U9KfixPC5UA1M3d6c4EFm3hSrNWuz5mAT3M6a2iajWOcV7IwZuvQIQ54ZkCDyxOjvN/t8JnoXW3cRvkJe8vmGhvuDfmbpaHS7r4S8A2rRBfFHQkZLfY7Bt+JN9kPUPB77FFeKQwf+LR1sVDqGwB3e5RlIUn1htphym2xV5XUgQvDUws2vMTOUfGFQ6B/yyTPGiQwzwaqPwv8upWxL7D2jqXjsUMvpS2ReapvcNi+QNGgdUzWB91k1Q/VtedCvyLnnf+ngxKaZ/tXDotzU3/qjHUaigOIEBwyoqmhHbx83vkoTJ3cAxBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pJzRDdEHUokjZtOU8RGfsTcRv0qQQII312HSeaI0Kk=;
 b=w5XwmCbeXrVRFigjfdmMQBa9+EG2bB8n53oYtVQB1fnTDJrijY13DgMVZFh6e1chpOqiIzrK975saJSEgw0huWV57WQtvFJLpPS3BMfkeqcs53Mj15KXebw5R72cnpRvg1fUCtG3mRZVgvaLvdVP9gfbg6eS8CZVfLNfiYkeO64=
Received: from BL0PR02CA0121.namprd02.prod.outlook.com (2603:10b6:208:35::26)
 by PH7PR12MB7843.namprd12.prod.outlook.com (2603:10b6:510:27e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 15:25:40 +0000
Received: from BL02EPF0000C402.namprd05.prod.outlook.com
 (2603:10b6:208:35:cafe::fd) by BL0PR02CA0121.outlook.office365.com
 (2603:10b6:208:35::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 15:25:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C402.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Wed, 29 Mar 2023 15:25:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:25:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/13] drm/amdgpu: add support for new GFX shadow size query
Date: Wed, 29 Mar 2023 11:25:18 -0400
Message-ID: <20230329152521.1980681-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329152521.1980681-1-alexander.deucher@amd.com>
References: <20230329152521.1980681-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C402:EE_|PH7PR12MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: ef42521a-d285-4510-2ffd-08db3069dad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ppPq0JF4621Lf/Mib6DL8I1rPKFEVI6a9UScrFTdv3DESsmoroYJNRkm+AKJhiDh9mbJWQeu0zomPFPBQ13CbmN3OsmJI0kgl0qqY2Czdte97bzIa31P1nJD9WNgIDCtyFUU+CeYfJrjp1fX1xqyumEr68gjluX/9nVIaGcA2QoVhX2h3x2PKX1T1V4SCpHnFxLhYEUWuRu6fLaplsXOvZbwWS9q4pDSlOvPp52eLXSP6/8EUtTP4QJI3OWGeUwtEY33KNd0imK+DUUSuA/9LwZ24qUS2WaaSVoe9FTYgal+rmKqvmkFD+XgtSOpuQFnzpOBci3vdmIpBQWkN8BBdeWuckPqQmkeIJtBI5RBFCQO+UlWgBUWwH0XP5qlij6HyBUuyZsftOuoet1jjfguCpg2KsdyWgGC0IlE5+gk6t1IMD2Qoqaocuvq3809WwfDavTr3H70clo0eifbI+1MuXytySL/GihtwBrjEnaGT7oWji5BOhn9el/iqJCf+tAknn4A4UMS0gLJN40Cxuv0aOvfCTTYLloCEHrV/zKJ1y5iw+eqcBl1UdxmlulMTjy3oRX798DRNyE30pNkOqzhjOH8yzwRUhi2pPelANXqUuPwzMo2PFnjKDU8MeMoY58ZEDbqZ2OI7f9plq0Oq7cRtPeCugLP7x6v9LI7qATX1MhXsN1UrRU3Ezn5ebyb9hVmWdr8vxNubYbHIgL6uwYxlW5Ns2JhJQKEJm9y5TENorE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(36840700001)(40470700004)(46966006)(186003)(478600001)(6666004)(316002)(16526019)(26005)(1076003)(336012)(426003)(47076005)(2616005)(7696005)(40460700003)(81166007)(82310400005)(40480700001)(8936002)(5660300002)(86362001)(82740400003)(356005)(70586007)(36756003)(4326008)(70206006)(6916009)(8676002)(2906002)(41300700001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:25:40.3495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef42521a-d285-4510-2ffd-08db3069dad2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C402.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7843
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use the new callback to fetch the data.  Return an error if
not supported.  UMDs should use this query to check whether
shadow buffers are supported and if so what size they
should be.

v2: return an error rather than a zerod structure.
v3: drop GDS, move into dev_info structure.  Data will be
    0 if not supported.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 0efb38539d70..90738024cc1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -876,6 +876,20 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		dev_info->gl2c_cache_size = adev->gfx.config.gc_gl2c_per_gpu;
 		dev_info->mall_size = adev->gmc.mall_size;
 
+
+		if (adev->gfx.funcs->get_gfx_shadow_info) {
+			struct amdgpu_gfx_shadow_info shadow_info;
+			int r;
+
+			r = amdgpu_gfx_get_gfx_shadow_info(adev, &shadow_info);
+			if (!r) {
+				dev_info->shadow_size = shadow_info.shadow_size;
+				dev_info->shadow_alignment = shadow_info.shadow_alignment;
+				dev_info->csa_size = shadow_info.csa_size;
+				dev_info->csa_alignment = shadow_info.csa_alignment;
+			}
+		}
+
 		ret = copy_to_user(out, dev_info,
 				   min((size_t)size, sizeof(*dev_info))) ? -EFAULT : 0;
 		kfree(dev_info);
-- 
2.39.2

