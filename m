Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550CAC0015E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 19:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C9BF10E4AF;
	Wed, 26 Jul 2023 19:32:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A6F810E4AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 19:32:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gpfs35wZGZ+A/lyLzBjTiSrtPjVK/nVF9f3K8G1QL+pg9XNyk09XBX6uEg0ExTrl1Wv1VMgJULUQBBCFhvwqco4/1pJ6HNVQ93D+SvIXKHBqV6A4fhwk1YK/7BPxL89aV87K0UUsmglktRZ8NJJF8neuwSysRgioe+v1v8az1WskIW73oj2NbCQdgMSxHMkpaprmVc6gRC2gHzGfRFQBwwsduR9+XnLLlgYq8Iq9UT/g89oF6gOGxOSsGld+fRCqKC0ilbVmdvlKQI5/ufKzHrml/AAL88lhQlFe70NEdvqaGWrkMPEUlmSSlviDTtWYO5wab6ivsJD9jq/kqPJwDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHJMM+xXYXX9a8RETaD72X0VSnyvQZJV4ASsJk+Z8sE=;
 b=hAWl11GbtkQ79QAh9xMihcy/oNpRnRvvTDgQtMQ4CbNw3qOqYG4qtJdtTjHJWvCSN+rYcBFZobNnsrZPF3a9DIIq2UV1PtZoqrj+BnYJy50yxBNXNU4RcthqbiMEmgelNfqCHZbP5XG2vvkmzNOu2e/ZxLYyMyyxYZbukWw9Px9VSgE+u8AwO0nelZP+pbg+AFJcrM3jQNvgX0UC0kIBhUrXqr6nDlyeelyT93w+aleOuu+xHTB0h8IDR0ZX2bHrfKnbHhHSlXMMTx2A1VX6GnufOmHOfwUVTuH8e3pf9P1/fVoQXVg2eYwEOXFSq3rfCn23SA+39kRDvmfs6drrOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHJMM+xXYXX9a8RETaD72X0VSnyvQZJV4ASsJk+Z8sE=;
 b=JOlsCkExnuU0SlNIX9GZ58KXsRMWvpilsMf5xmVH+1Oi1vVuE+0OD/VCGvpwCSoJTvPom6YIrTHrWkBPnVEJa+QNGSrsgExoHKaZ9b9v/QDc7cw7BHPBawjBr5HCo30ft2/gDnyOC8K2j2roHGB8ThtY3UdALi1cwLfuj16ac6E=
Received: from BN9PR03CA0287.namprd03.prod.outlook.com (2603:10b6:408:f5::22)
 by BL1PR12MB5094.namprd12.prod.outlook.com (2603:10b6:208:312::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 19:32:01 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::7f) by BN9PR03CA0287.outlook.office365.com
 (2603:10b6:408:f5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 19:32:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 19:32:01 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 14:32:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 12:32:00 -0700
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 26 Jul 2023 14:31:59 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/7] drm/amd/display: Temporary Disable MST DP Colorspace
 Property
Date: Wed, 26 Jul 2023 15:27:43 -0400
Message-ID: <20230726193155.2525270-5-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726193155.2525270-1-aurabindo.pillai@amd.com>
References: <20230726193155.2525270-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|BL1PR12MB5094:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ec94e9-2642-4beb-d8bd-08db8e0efc01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6sG8Np6tyUWhZmCvA5y2ryMXO/Bksh7b+wm0MsCq+HU09EQeIDpMXUwr7v4EeToF2HLbvL1+W/s9NH+cHudPtePOf5LuYHCljd7Vze+JNWsXwNsWRk0MyUmoYfSRlhJracsGSJicBZkeMkFej0Pzpy2JYKF2w/vVMqt7HkQjWLsOLc6gkDhcBHWfhsef2SnTGCeF2LDEhRSH+rmuz4Fo/qWDgqzpAwsLL5ijO4rz8hqtjdUN5VRTjNtgm2npyJdw06FTdK62j9SF7THQXIx1/kYRSJsIP3ygz5bA5AA6lClRDwGz8GOOALtqZSfJw2tEEng+kU22udJ8VnKPbX+eQTS0Z63u+ON91f00grWFi8U2+iTpD2E+/PJQj6m8XcQPLbEzSWz5d9LU5o4i31R9Q1VSc3NLWZ2qr567np30KExgp8VZ3giZ6m5sjB4+MyUwA7QgX4+oL7IGuNMzgJyMr20olSu69yEOEtErf9/krQlgx2POalUm8/1ZJ4gcw/ybskDoYn56aLZzt+jBghKS+Z8+9WdLr8wPLoPePVjHNajYhK1BauBdfUZcnxdZMiYOTdz4Q7f8yyxTp3+tCHMQ4DtTr18KWbqcUC6YyConTnMjCfwSURcqoD4X7li9arLxFypfRGYOe6H95DtC0uEX8ygbbDGJLOkqmcNlU6cEQklQSGz9PfdRt3jjC1JFMq6HXhKALNnULOtvObgJEb8MKbx4UndSbF28fQyMenoPSokf5CloATeLyaPHsd7f7t4ot3AsXEfAr1TskITg8H6Frw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(47076005)(478600001)(54906003)(86362001)(70206006)(70586007)(6916009)(81166007)(4326008)(316002)(356005)(40480700001)(186003)(1076003)(336012)(82740400003)(7696005)(6666004)(26005)(40460700003)(44832011)(5660300002)(8676002)(8936002)(41300700001)(2906002)(2616005)(426003)(36756003)(83380400001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 19:32:01.1254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ec94e9-2642-4beb-d8bd-08db8e0efc01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5094
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Fangzhi Zuo <jerry.zuo@amd.com>,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <jerry.zuo@amd.com>

Create MST colorsapce property for downstream device would trigger
warning message "RIP: 0010:drm_mode_object_add+0x8e/0xa0 [drm]"

After driver is loaded and drm device is registered, create
dp colorspace property triggers warning storm at
WARN_ON(!dev->driver->load && dev->registered && !obj_free_cb);

Temporary disabling MST dp colorspace property for now.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 77d970a2ee69..f88a7c0ce8f3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7309,7 +7309,7 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 	if (connector_type == DRM_MODE_CONNECTOR_HDMIA) {
 		if (!drm_mode_create_hdmi_colorspace_property(&aconnector->base, supported_colorspaces))
 			drm_connector_attach_colorspace_property(&aconnector->base);
-	} else if (connector_type == DRM_MODE_CONNECTOR_DisplayPort ||
+	} else if ((connector_type == DRM_MODE_CONNECTOR_DisplayPort && !aconnector->mst_root) ||
 		   connector_type == DRM_MODE_CONNECTOR_eDP) {
 		if (!drm_mode_create_dp_colorspace_property(&aconnector->base, supported_colorspaces))
 			drm_connector_attach_colorspace_property(&aconnector->base);
-- 
2.41.0

