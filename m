Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2A5C77B6F
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18E1D10E051;
	Thu, 30 Mar 2023 19:18:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58DD310E051
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:18:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Paz5Y6yDI+o3uLytaSAWvGeIFyLTpDtcpltLeNbhKHm8szz0pTo6NljnpZ5Wgn3ophS9dqmEzJiGXFwCjyzUoqWFVahCqrFFh7C2AJI3MAS1dChqdFeMKxZo5w0FXNYFzHJtVCFDYmnGnqGa+mHswsOIABy5OmnukrUb45/jb+zgcak8X3//otkp7FFcSAjCNBOjRa5Ok8r52dwwLbPxRxIOi7gCTD9z19xh5gvI87zl20HYHSD2aPLEoFKiKdrIp5mjvtDtI6/hcA9LEXSWnCbe4i98vuSkISD23E0ttC6QQ39ZrBrILETSiGsxFMkDvuKA6qSeHBXN8SV6//bObg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9/dR1qaQO4/hzI2/AIO67tYl7ti92uDQs4tgM2OQMI=;
 b=QEbomNFrSdB859iVJxt7mSfY6I0tMtUVthl8/Ii6Zjje89Aj7sk59opoEnWKlCC0XYEBxcVjPci566pAvigrDmS3s1c0iLOs8KKckHbtFfmXK4njyd07av8m6tJfTgmlKY1n8EfcwRQtzXTCzx4OCx0ZiJ37xL/dCkbGqvYpeBkXKJ20OrQ0LtQ1UNFZeEsd/4rhIVN5ZJLuBHd4FcV3yKYXycBUf8xRkrgFMSUEPNt/gB6H0owpsLoryJzZm5wSUBYu8alUgWWH8mG1qzHQYoL6PaAU+OjNJIqjxvMkfAWpyUN1ZHCHnrUpr6WYWz3rQfroCo0Ll8OhSIBaoTUalQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9/dR1qaQO4/hzI2/AIO67tYl7ti92uDQs4tgM2OQMI=;
 b=HJs3H9AC8nFoQXMHmgsQ9B/TVutCx8ls5UDXJ35d//k67rKHEz6eUoXJBAZQtZwTh6rFbBvHjnRikHn0uv+ofyVd0wWF8iduM8vKAz2NAu7tS+7onB8f/ah2xwSV2AYVnBV+t2+lYDAF7Key1l88RT3tXVh16I7N2PiprMVS1E8=
Received: from BN9PR03CA0863.namprd03.prod.outlook.com (2603:10b6:408:13d::28)
 by BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 30 Mar
 2023 19:18:04 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::f2) by BN9PR03CA0863.outlook.office365.com
 (2603:10b6:408:13d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:18:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 19:18:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:18:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/13] drm/amdgpu/UAPI: add new CS chunk for GFX shadow buffers
Date: Thu, 30 Mar 2023 15:17:40 -0400
Message-ID: <20230330191750.1134210-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330191750.1134210-1-alexander.deucher@amd.com>
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT063:EE_|BL3PR12MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be3d36b-586e-4b83-3158-08db31537cba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7J7kfzWLZ5+pyrnASe37iNxpueybIrj3NXhYB5e8i0YPAgHorOpsvqj79vA/dveghEB93+UDjm55zsWbSCGTEOixi9W7jsHuaGs/CIGiK9jKICKGzNAZr3Bl4Tdh3u0MvewTeHBwokHYGtuYDs1effZrg/H1eQUzdq+eqDcICJsPFoWVbi3+NiBD7pOHdWS4wR6ffCcPVbkgCqnI+VrsWll/CHzHb9ty21W/IEyXJcDwX+xpwkoUl7s4eJpD+r/2T2vGpHrdsXvZHsuaJDkzoNIMe+E1MljUd28+Qu6veeS9IspsCL+s4tuORw9wH/hrCfFPcVAjmyZleQqlrYJwX1BCAhExhsYd1IuF0sYtOzON4zO1bdWmJqc85OMNymMrFBrjWax6LIlpPjErWIupV/1nhOxQWez2p92mD8k2HXEutbbg+tkpNfJDsMUJVt5HNlQqMCdXW37C0ykFjTXAUYFcfsYBPnLM4UJvctt3cvQTRsRB/OxFUCVUTNLUz6vHPl3WrkX4Q9XkHq/zCwfjutANTQh7cXkBA8um1bGviK4EyjtjZPObW6/9SbY5f6tvlOMm0O7PVXozNTtKUmo6lbUzRQ6DFHfkg/2MbGz/EugdUXVKZhntZCXVuB7qX25qZB7uL+y5+gt2sseLfquNpwQmByQPh/e4H89WiiLNLUNxdrB6ytLJygSeoq6pxcDIhLBFPGIEt+PQ5sanjT6kwd2E1V2qkNtlQ9w66lK1WU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(2906002)(356005)(86362001)(47076005)(8676002)(36860700001)(16526019)(1076003)(70206006)(2616005)(186003)(5660300002)(6666004)(336012)(40480700001)(6916009)(4326008)(478600001)(81166007)(82740400003)(66574015)(316002)(7696005)(26005)(40460700003)(36756003)(70586007)(54906003)(82310400005)(41300700001)(426003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:18:04.7212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be3d36b-586e-4b83-3158-08db31537cba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6425
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For GFX11, the UMD needs to allocate some shadow buffers
to be used for preemption.  The UMD allocates the buffers
and passes the GPU virtual address to the kernel since the
kernel will program the packet that specified these
addresses as part of its IB submission frame.

v2: UMD passes shadow init to tell kernel when to initialize
    the shadow

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index b6eb90df5d05..3d9474af6566 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -592,6 +592,7 @@ struct drm_amdgpu_gem_va {
 #define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES	0x07
 #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT    0x08
 #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL  0x09
+#define AMDGPU_CHUNK_ID_CP_GFX_SHADOW   0x0a
 
 struct drm_amdgpu_cs_chunk {
 	__u32		chunk_id;
@@ -708,6 +709,15 @@ struct drm_amdgpu_cs_chunk_data {
 	};
 };
 
+#define AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW         0x1
+
+struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
+	__u64 shadow_va;
+	__u64 csa_va;
+	__u64 gds_va;
+	__u64 flags;
+};
+
 /*
  *  Query h/w info: Flag that this is integrated (a.h.a. fusion) GPU
  *
-- 
2.39.2

