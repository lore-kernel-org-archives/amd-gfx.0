Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F455C77B73
	for <amd-gfx@archiver.kernel.org>; Sat, 27 May 2023 14:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DF6410E122;
	Sat, 27 May 2023 14:25:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABD1810E122
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 May 2023 14:25:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gmp5Mm9VmGxsLbhs3Nitgo3xfj4k9mbKJb9GP56tMc3eyplGcW6yra9nyuWE+vr/H9EDiUOBxYCOkqNzcjb2PzyJUq7e+gpy3A2Fb3fA4Omz6coHygACt8wQrIX8Z4Ke1+Wq+ihA/ZKl0vm8/YdEHnh12LgYS/cwmqcxmbM9uI8FG5fhGiN9FkDC8tIX02buuEM35qhDpsOVg8zi5LknOnriaMIPLHxmODMyfjIqwqlizsfTKfbnY/V3G7D9VmXNC6oC37JsnOp2oic1RXyqbMjK+c7m8LXrLiAy2O98kQKbSBqxGOkpQWeeWq9PIoTohCkwyaHiuPpf5qmi+LmjFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpLIfNT8agHvjSn4IOqhedG0S2PvPKJh/QNKk6J8ZDM=;
 b=ccd9l1lSf6BvbNYR51BsOT8M8xwnCeXvmhVU1oT5mQ1ZnJleLqFRar2rMZcwyCmqfnbUoW77B85SICmvbNsRrNyLB33TkY7IekFLquCoxeZkVMZeDW+Cl6OEzFlVM0aJEpD1A2QRM2ua+vdpgwUaPw/iczhCKRamn4Iey2CSwFSx0gi3dt1hrcYTs31rQrlH57XAw7dYExOfUa5QkEAgg2gpI5zmSbRaJEqHPsaWZEYvLwexecdGoq0noGDofIT8qLDagi9UYtQqi0f0v3qqIY+tXBSd1s1O7L/sS+I4yr3J+8/5/n6Iu1dw1ba7im/RUn0BxsPMypnXsCdYzuaiHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpLIfNT8agHvjSn4IOqhedG0S2PvPKJh/QNKk6J8ZDM=;
 b=0FP8z+rHLiVaE0DeCLyBo//DS7HWlsjOaQqYIg+THsSi/JkaU14UgaCu2MqbnMjfVAMPIK1Osam0LP9dPcXqm0NxgTBkhdwGl4X+I1ZL/H1nAfOFKCJ1zZmQQRANdFnYlxtubczZDWIdqzIxxBOzzZsJ/M1I+OJnPgyjXEttJmI=
Received: from BYAPR08CA0068.namprd08.prod.outlook.com (2603:10b6:a03:117::45)
 by MN2PR12MB4318.namprd12.prod.outlook.com (2603:10b6:208:1d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Sat, 27 May
 2023 14:25:23 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:117:cafe::c1) by BYAPR08CA0068.outlook.office365.com
 (2603:10b6:a03:117::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21 via Frontend
 Transport; Sat, 27 May 2023 14:25:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.19 via Frontend Transport; Sat, 27 May 2023 14:25:22 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 27 May
 2023 09:25:20 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: Add missing kdoc entries in
 update_planes_and_stream_adapter
Date: Sat, 27 May 2023 19:55:03 +0530
Message-ID: <20230527142503.1465145-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT016:EE_|MN2PR12MB4318:EE_
X-MS-Office365-Filtering-Correlation-Id: c1eb45a3-5e49-4355-b88a-08db5ebe3507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RnHmxZBl3TqcbXAs4iDLNs472O3jODVxfVfAQKlFSX0HQR3h12uMBMDpmL47tIBb2t7un94UCv6qLwy1ncVxFyfEMJuavHp3zN2mumATKyYp+p7ent0eFIBxL1XzpCrIRoFb6B5r8DIoVwKAgGnqEUTLKdQUjRCmF+6eXojDtP0rPym2Yf2VTSQixtePP+TCpjNbYs9YgxNylYOVxIIQTY7zGx2iiQkfN5Yn6/oqbrCoAkP1DEg6YVYOF9uNHSENbhp05kWEmy+QSNAypQT5ESa28sQGv9xWgw6Id8hPfT1BFdon76NCAnzWWdHmXa/Or8LdYbsoNEgF0LcCkVDS0t+6EMDae6eGw+WKg2igviT9bMW6HLmSdnvZZMajbHFtD0/OUIo41Ms0xxvFwgaqMe2QsWYqKGM4YsXrH0xKAWy7jaQj4TV5PE6vxCpRtBivXEuoSameMLVjCXj9Z1Ga2Y14rzxveO79LdPyDeaZ6j0KmsQiVqJKGSqu2H24t/Y2aib88phcR64QF8qSscz8wYyPwHZ6ntz7NBRCDRTFbL8s+H/aLIPr/bMp0ga6StxofdbkWybcyMnR+/+5ZKyIZTVMq3T/ruqYYO/mCpvDhHwqdwEZKUg0yClztkCQx6LaazU/4I7zTcx+O+Ve9SkcBGflOqDhPYeFMLNr+wGD2ahXE+EmeWjvvLPpSoR1vLNj3r01tS8oFnaCN26JiePMKj3bw43fTOsIXbMSS2Zicz8J/IECCD8J0o5SAXOMpReDmAEBbVOMO69PSIPszbWDgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(6666004)(40460700003)(316002)(7696005)(41300700001)(8936002)(8676002)(47076005)(36860700001)(15650500001)(86362001)(2616005)(186003)(16526019)(82310400005)(2906002)(83380400001)(36756003)(5660300002)(1076003)(26005)(44832011)(336012)(426003)(40480700001)(70586007)(70206006)(110136005)(54906003)(478600001)(356005)(81166007)(82740400003)(4326008)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 14:25:22.8146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1eb45a3-5e49-4355-b88a-08db5ebe3507
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following gcc with W=1:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:374: warning: Function parameter or member 'dc' not described in 'update_planes_and_stream_adapter'
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:374: warning: Function parameter or member 'update_type' not described in 'update_planes_and_stream_adapter'
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:374: warning: Function parameter or member 'planes_count' not described in 'update_planes_and_stream_adapter'
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:374: warning: Function parameter or member 'stream' not described in 'update_planes_and_stream_adapter'
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:374: warning: Function parameter or member 'stream_update' not described in 'update_planes_and_stream_adapter'
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:374: warning: Function parameter or member 'array_of_surface_update' not described in 'update_planes_and_stream_adapter'

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a69f4a39d92a..90de0d37f1d2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -364,6 +364,14 @@ static inline void reverse_planes_order(struct dc_surface_update *array_of_surfa
  * adjustments and preparation before calling it. This function is a wrapper
  * for the dc_update_planes_and_stream that does any required configuration
  * before passing control to DC.
+ *
+ * @dc: Display Core control structure
+ * @update_type: specify whether it is FULL/MEDIUM/FAST update
+ * @planes_count: planes count to update
+ * @stream: stream state
+ * @stream_update: stream update
+ * @array_of_surface_update: dc surface update pointer
+ *
  */
 static inline bool update_planes_and_stream_adapter(struct dc *dc,
 						    int update_type,
-- 
2.25.1

