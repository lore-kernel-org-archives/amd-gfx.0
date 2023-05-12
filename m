Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D71C77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 12 May 2023 21:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEBA810E2C6;
	Fri, 12 May 2023 21:44:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8799410E082
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 21:44:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwQgkT7GC4MP0FMQMlLwoWg9HP2+aBGEQlqfnSiz4b/+LQ6jsyQsLKXHna2tjVuR4+HaHjSkQInCBuxlgbyeCtrcbQUNlKL08DaYOnWW2kVRQjA81tshjsJEg+JSYNtN0fiVN06qFlnhkfTylctfVnZ98ueqRGVIn07jRn0nlD1Ri87UexU/GrX2EBlsWpBeX9OXmfsHWV1AI3L1MZjwqcOKu5Ov2pBPJucaEqq6gN0zmOL/e7ARItPIZugzBr3utVg6y/VDvu9rhJnwvUlPnTxWrCtQzFDRh4pviO0L3piQDchwifdAnjdckS/5ARGI/PTZCjL5qU76joPcAYwLSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbMBX7RdcEH4yEwEpFtHN5XAe47fpZ9XhrX3kidTXS0=;
 b=P+PX0GxF8LQnfriMMuEJwji7mwlS7+jxhEMy+9bo1hPiFWW1vW+4we6790Lc+zJgvE97LF6ERyEZHox2m59fjBVmpxYlVnT6lmTupZj0Ys6gq0kvMphLjB7WAPv4826OuwrqjxcxKYpKe0maDs6HCdL64vu4fYtiVz7HCEJw8GfAyHrSvfmsumhnnEzLSlKIwGp1CgscgZSiD9IEqUDj5UprfyYHkxBNaUiT7Vwgskt88AxKJ8DCn8VDUWu0+vJPi0wsR1plxG3YCyWdUj7f3FJ9J6qwC6xMWjk4Td9rmo6cO2chlJEMBnyNxatsSg9cP77U2fg+ZCyzQ9tw8ErA5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbMBX7RdcEH4yEwEpFtHN5XAe47fpZ9XhrX3kidTXS0=;
 b=RuwDhOb0pMOWPNzPE6wnRsVAvS4u0U0D+yzVX7qv43YiBuQlgDpshU7RG9bN0YeBgDXqJ9pqXUGFsA0t1fyo14Rkx9vR207OTazBVOWwOGtvvYdKjJ9MvXqO3gfOEz6ZcXXlh8oH/KZMv5s5ieT4y5F4LFql0Oab1H0eyrYR3xQ=
Received: from MW4PR03CA0271.namprd03.prod.outlook.com (2603:10b6:303:b5::6)
 by DM4PR12MB6568.namprd12.prod.outlook.com (2603:10b6:8:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Fri, 12 May
 2023 21:44:18 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::78) by MW4PR03CA0271.outlook.office365.com
 (2603:10b6:303:b5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24 via Frontend
 Transport; Fri, 12 May 2023 21:44:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.26 via Frontend Transport; Fri, 12 May 2023 21:44:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 12 May
 2023 16:44:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/10] drm/amdgpu: add RAS definitions for GFX
Date: Fri, 12 May 2023 17:43:46 -0400
Message-ID: <20230512214351.1356254-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512214351.1356254-1-alexander.deucher@amd.com>
References: <20230512214351.1356254-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT024:EE_|DM4PR12MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: 23fd7fda-ca83-4d9e-0c43-08db533209ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R9daZ2z6uHCcagz7mH5W+F8tZUgXbOZjxc42X97KSavWPQC6vRq6A2mnc61EZXtxZaBX00yiDVRvMea3V5f/8plLJwqp6G3DvgU3WICxIF9qtFXR1Wvm7oQXrsOsIXJRwguXr4SQewFBVmDRO/tqvxaWlquFdBfeOcF74TSE5oe2KWiK+rs6zoqIBFGsdhk/MgEBP9V/VqbJN/wrGE/Mpl301Zby3BbMES9QTMRydh6oTA34LvrRIOqKM3IzNmaH/yT9Yxag4C57+rTGx+CzWBj6zUTsHu1iX4WPlU2hWbKz0pQoIN6/VgGIsIwxpEAHRnS4tQYyrYMAUwSrmDf2j7BxX4UVp8J8wP5toJt4ph8trqVX+P55S5LB1bGIfTCqvz8O6OeMu7Hxm7uI7UhZZ3bPYbc1/AWohIDbK1Zd0HWkI5Svyia1lj+aGXbw4R49JVmtBUPx7+Ah6LvXyCTjtIN9B7Wi3+FmETlCpv8lVl+HhvqWdjEtk6eCqNpqdHHL6F8H3+X2yoHqE4amtXOKtipD2yXSUQP53tH41BRFwv3ZlLt33ayGJMM4vDbn3j+mPoUvMKBPkPQEXbqkOW1WNf8sESV8S/m8zvmv96tT3CRuuATpbKHf/V/WAOhCiY8ASqLkXQwba1GQoagn2e2jP7FMPmAo+D+MUA2d5DuuosNuRKFKuDKoYatKgMI/iYQcjtVL0rFBLdOWD5yAyLqAegm8vypw1sv8+5GVBL227SiIzVOlJVu6Sm2Opgew2fIaxjImhvOYfXHJFSxMCE3p6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(41300700001)(40460700003)(40480700001)(47076005)(336012)(83380400001)(478600001)(426003)(70206006)(36860700001)(316002)(6666004)(70586007)(6916009)(2616005)(54906003)(4326008)(186003)(26005)(5660300002)(1076003)(8676002)(7696005)(16526019)(2906002)(8936002)(356005)(82740400003)(82310400005)(36756003)(81166007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 21:44:18.1560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fd7fda-ca83-4d9e-0c43-08db533209ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6568
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

Add common GFX RAS definitions.

v2: remove instance from amdgpu_gfx_ras_reg_entry,
    amdgpu_ras_err_status_reg_entry has already defined it.
v3: remove memory id definitions from amdgpu_gfx.h, they are
    related to IP version.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 39 +++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index f07117d8959b..7422db02aeda 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -75,6 +75,32 @@ enum amdgpu_pkg_type {
 	AMDGPU_PKG_TYPE_UNKNOWN,
 };
 
+enum amdgpu_gfx_ras_mem_id_type {
+	AMDGPU_GFX_CP_MEM = 0,
+	AMDGPU_GFX_GCEA_MEM,
+	AMDGPU_GFX_GC_CANE_MEM,
+	AMDGPU_GFX_GCUTCL2_MEM,
+	AMDGPU_GFX_GDS_MEM,
+	AMDGPU_GFX_LDS_MEM,
+	AMDGPU_GFX_RLC_MEM,
+	AMDGPU_GFX_SP_MEM,
+	AMDGPU_GFX_SPI_MEM,
+	AMDGPU_GFX_SQC_MEM,
+	AMDGPU_GFX_SQ_MEM,
+	AMDGPU_GFX_TA_MEM,
+	AMDGPU_GFX_TCC_MEM,
+	AMDGPU_GFX_TCA_MEM,
+	AMDGPU_GFX_TCI_MEM,
+	AMDGPU_GFX_TCP_MEM,
+	AMDGPU_GFX_TD_MEM,
+	AMDGPU_GFX_TCX_MEM,
+	AMDGPU_GFX_ATC_L2_MEM,
+	AMDGPU_GFX_UTCL2_MEM,
+	AMDGPU_GFX_VML2_MEM,
+	AMDGPU_GFX_VML2_WALKER_MEM,
+	AMDGPU_GFX_MEM_TYPE_NUM
+};
+
 struct amdgpu_mec {
 	struct amdgpu_bo	*hpd_eop_obj;
 	u64			hpd_eop_gpu_addr;
@@ -412,6 +438,19 @@ struct amdgpu_gfx {
 	struct mutex			partition_mutex;
 };
 
+struct amdgpu_gfx_ras_reg_entry {
+	struct amdgpu_ras_err_status_reg_entry reg_entry;
+	enum amdgpu_gfx_ras_mem_id_type mem_id_type;
+	uint32_t se_num;
+};
+
+struct amdgpu_gfx_ras_mem_id_entry {
+	const struct amdgpu_ras_memory_id_entry *mem_id_ent;
+	uint32_t size;
+};
+
+#define AMDGPU_GFX_MEMID_ENT(x) {(x), ARRAY_SIZE(x)},
+
 #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
 #define amdgpu_gfx_select_se_sh(adev, se, sh, instance, xcc_id) ((adev)->gfx.funcs->select_se_sh((adev), (se), (sh), (instance), (xcc_id)))
 #define amdgpu_gfx_select_me_pipe_q(adev, me, pipe, q, vmid, xcc_id) ((adev)->gfx.funcs->select_me_pipe_q((adev), (me), (pipe), (q), (vmid), (xcc_id)))
-- 
2.40.1

