Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE58C33C9E
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 16:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB1AC208C4
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 16:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pnoJVKix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1AC208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7D186E03F;
	Tue,  7 Jan 2020 16:41:21 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680060.outbound.protection.outlook.com [40.107.68.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E16A6E03F
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 16:41:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dwl9fNGWzDvk7ZCuZX6ux4noRsH3eeXg0MIdm/EjG2o1zd9+JVBwWOAV/ATZhLpB/93L/4oIJs2QPvng4Rq7rtfyhs/z++cZ7GzkQY19o4Lyfvo8kIoIokSBSHYJkDWOXax7ctctRx8DrQOPyelmbPsyKueXtWsoZaVJb/bGickRewSG/YM40dT2KfCw8+bAMeQ4W3etuCwcWDjxXihC4mo/fqWRteoHzrsHi5SCwYHaBh7WrwI8ANzpxS/Wm7JYZ02LdAgt3p1W9v2kJ4RV10Q5EyW5sG+MScpeKedLKBsak/aueNzEojkZ6+e3M1Qr+dtjhr0fCYB6Nqck0Ql69Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFAlnvoi9JU97cBXVpq+YkqLR564dHSpipVqXNIPwMI=;
 b=ZJe+P8ihGRuBFWwT9rvtwtor+xdQ4agC1BzP88nqv9DIprT/h+nWCDTovGompzte8az9h1R9wxM8DI0DqS2lZ1S2PvZlf6Sd6xysJbgSPQuSS8xTR8jk9X+sVtWym1c4VRG0zE1V0ymeQTZLgfcAFqPZgHsD9n0KBg4JfR4FNk+PLqHbnBLCCMRyydNB0gjwJVsvjzjwT4Qa5PYlJ/ojg1TxeWqC3ItLY1MMXUgPnqejsZ0Ld2C4TaFx8FSMceRb6tePcTY1w1g1rw4iy5Wx6RtCrWDyxT03b1G++SkrXsEorHBIEU9mk+hCNH0fW8tXiqw0923FKfpInou8BVr98Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFAlnvoi9JU97cBXVpq+YkqLR564dHSpipVqXNIPwMI=;
 b=pnoJVKixXsq9O7FQ6N2qKCSKiJHRvrXqrdWb9Zk4t7anaogPRbL+YLeZHwJbNaQwtF5My6tMZuaaiCanQt4my+RcSxILtd7okwEv2YJlMETcMjDiQqbnPid80JhQZs5efGEL9gKiykWQXZJdMYvi16SbshY1KpbEPr8CcFf7AxA=
Received: from BN6PR1201CA0002.namprd12.prod.outlook.com
 (2603:10b6:405:4c::12) by DM5PR12MB2486.namprd12.prod.outlook.com
 (2603:10b6:4:b2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12; Tue, 7 Jan
 2020 16:41:17 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::207) by BN6PR1201CA0002.outlook.office365.com
 (2603:10b6:405:4c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend
 Transport; Tue, 7 Jan 2020 16:41:17 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2602.11 via Frontend Transport; Tue, 7 Jan 2020 16:41:16 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 Jan 2020
 10:41:15 -0600
Received: from mlipski-pc.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 7 Jan 2020 10:41:15 -0600
From: <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Check return value of drm helper
Date: Tue, 7 Jan 2020 11:41:12 -0500
Message-ID: <20200107164112.6481-1-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(396003)(376002)(136003)(428003)(189003)(199004)(86362001)(316002)(6916009)(2906002)(2876002)(8676002)(36756003)(8936002)(54906003)(81166006)(81156014)(7696005)(4326008)(1076003)(2616005)(5660300002)(186003)(336012)(70206006)(26005)(426003)(70586007)(478600001)(6666004)(356004)(16060500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2486; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d046efa3-0f9b-4963-40d7-08d793906a66
X-MS-TrafficTypeDiagnostic: DM5PR12MB2486:
X-Microsoft-Antispam-PRVS: <DM5PR12MB248663617D54011126BD5774E43F0@DM5PR12MB2486.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 027578BB13
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OikQurocKxFUezL/Ou/fDEm3qAW6PeUscjCJJN+Zbm27mk4JUQsqTFwdrfLpkyBKdAMffmNRTGbxJFkKtSxqcHS0Bq0/e8v7Ad/CNKToW9dtiSbC4JOwBEgPEfTaoi9aK+rh/rgPSPQvP6KlyemMlxvpFz5yXa3y+39ETU7WxSyApoeiRIIVaeGoP4KC+1zfZaNMYU0fMVIDUuvrWRAsGNUl199GIwy9NqtoRiWisUU6U6ImCv60b3QA1PJnThvwojnMDHHfI98q6XA3y8zCZUHklzj5pSoiwiDKz2hQGOR0JXYBt6Snj5t72P9xleySMSB8v/8K1dlr6Jh2JYxfZfjP+wbUc2iWGsh2ltuHn5c9MqYvZLATZOY3L/H3OWjOJKNsCf5citLD8lMXZLTPMdwIkx6dZRB2qaMXEJvV4W1MEkH0iuKDEeQz7jG3qUGyPcxw2J7uRMDTmSlofxg9XNtH0CCAyWv8dVU6kZV4X2T3pwzk7VgnL4LnGJxnWms8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2020 16:41:16.4903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d046efa3-0f9b-4963-40d7-08d793906a66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2486
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
Cc: Alexander.Deucher@amd.com, Mikita Lipski <mikita.lipski@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mikita Lipski <mikita.lipski@amd.com>

If driver fails to update update VCPI allocation during
compute_mst_dsc_configs_for_state - fail the function
by early return.

Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 99 ++++++++++---------
 1 file changed, 54 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 35c8b1469f4c..7911c5dac424 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -621,37 +621,41 @@ static void increase_dsc_bpp(struct drm_atomic_state *state,
 
 		if (initial_slack[next_index] > fair_pbn_alloc) {
 			vars[next_index].pbn += fair_pbn_alloc;
-			drm_dp_atomic_find_vcpi_slots(state,
-						      params[next_index].port->mgr,
-						      params[next_index].port,
-						      vars[next_index].pbn,
-						      dm_mst_get_pbn_divider(dc_link));
+			if (drm_dp_atomic_find_vcpi_slots(state,
+							  params[next_index].port->mgr,
+							  params[next_index].port,
+							  vars[next_index].pbn,\
+							  dm_mst_get_pbn_divider(dc_link)) < 0)
+				return;
 			if (!drm_dp_mst_atomic_check(state)) {
 				vars[next_index].bpp_x16 = bpp_x16_from_pbn(params[next_index], vars[next_index].pbn);
 			} else {
 				vars[next_index].pbn -= fair_pbn_alloc;
-				drm_dp_atomic_find_vcpi_slots(state,
-						      params[next_index].port->mgr,
-						      params[next_index].port,
-						      vars[next_index].pbn,
-						      dm_mst_get_pbn_divider(dc_link));
+				if (drm_dp_atomic_find_vcpi_slots(state,
+								  params[next_index].port->mgr,
+								  params[next_index].port,
+								  vars[next_index].pbn,
+								  dm_mst_get_pbn_divider(dc_link)) < 0)
+					return;
 			}
 		} else {
 			vars[next_index].pbn += initial_slack[next_index];
-			drm_dp_atomic_find_vcpi_slots(state,
-						      params[next_index].port->mgr,
-						      params[next_index].port,
-						      vars[next_index].pbn,
-						      dm_mst_get_pbn_divider(dc_link));
+			if (drm_dp_atomic_find_vcpi_slots(state,
+							  params[next_index].port->mgr,
+							  params[next_index].port,
+							  vars[next_index].pbn,
+							  dm_mst_get_pbn_divider(dc_link)) < 0)
+				return;
 			if (!drm_dp_mst_atomic_check(state)) {
 				vars[next_index].bpp_x16 = params[next_index].bw_range.max_target_bpp_x16;
 			} else {
 				vars[next_index].pbn -= initial_slack[next_index];
-				drm_dp_atomic_find_vcpi_slots(state,
-						      params[next_index].port->mgr,
-						      params[next_index].port,
-						      vars[next_index].pbn,
-						      dm_mst_get_pbn_divider(dc_link));
+				if (drm_dp_atomic_find_vcpi_slots(state,
+								  params[next_index].port->mgr,
+								  params[next_index].port,
+								  vars[next_index].pbn,
+								  dm_mst_get_pbn_divider(dc_link)) < 0)
+					return;
 			}
 		}
 
@@ -700,22 +704,24 @@ static void try_disable_dsc(struct drm_atomic_state *state,
 			break;
 
 		vars[next_index].pbn = kbps_to_peak_pbn(params[next_index].bw_range.stream_kbps);
-		drm_dp_atomic_find_vcpi_slots(state,
-					      params[next_index].port->mgr,
-					      params[next_index].port,
-					      vars[next_index].pbn,
-					      0);
+		if (drm_dp_atomic_find_vcpi_slots(state,
+						  params[next_index].port->mgr,
+						  params[next_index].port,
+						  vars[next_index].pbn,
+						  0) < 0)
+			return;
 
 		if (!drm_dp_mst_atomic_check(state)) {
 			vars[next_index].dsc_enabled = false;
 			vars[next_index].bpp_x16 = 0;
 		} else {
 			vars[next_index].pbn = kbps_to_peak_pbn(params[next_index].bw_range.max_kbps);
-			drm_dp_atomic_find_vcpi_slots(state,
-					      params[next_index].port->mgr,
-					      params[next_index].port,
-					      vars[next_index].pbn,
-					      dm_mst_get_pbn_divider(dc_link));
+			if (drm_dp_atomic_find_vcpi_slots(state,
+							  params[next_index].port->mgr,
+							  params[next_index].port,
+							  vars[next_index].pbn,
+							  dm_mst_get_pbn_divider(dc_link)) < 0)
+				return;
 		}
 
 		tried[next_index] = true;
@@ -769,11 +775,12 @@ static bool compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 		vars[i].pbn = kbps_to_peak_pbn(params[i].bw_range.stream_kbps);
 		vars[i].dsc_enabled = false;
 		vars[i].bpp_x16 = 0;
-		drm_dp_atomic_find_vcpi_slots(state,
-					      params[i].port->mgr,
-					      params[i].port,
-					      vars[i].pbn,
-					      0);
+		if (drm_dp_atomic_find_vcpi_slots(state,
+						 params[i].port->mgr,
+						 params[i].port,
+						 vars[i].pbn,
+						 0) < 0)
+			return false;
 	}
 	if (!drm_dp_mst_atomic_check(state)) {
 		set_dsc_configs_from_fairness_vars(params, vars, count);
@@ -786,20 +793,22 @@ static bool compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 			vars[i].pbn = kbps_to_peak_pbn(params[i].bw_range.min_kbps);
 			vars[i].dsc_enabled = true;
 			vars[i].bpp_x16 = params[i].bw_range.min_target_bpp_x16;
-			drm_dp_atomic_find_vcpi_slots(state,
-					      params[i].port->mgr,
-					      params[i].port,
-					      vars[i].pbn,
-					      dm_mst_get_pbn_divider(dc_link));
+			if (drm_dp_atomic_find_vcpi_slots(state,
+							  params[i].port->mgr,
+							  params[i].port,
+							  vars[i].pbn,
+							  dm_mst_get_pbn_divider(dc_link)) < 0)
+				return false;
 		} else {
 			vars[i].pbn = kbps_to_peak_pbn(params[i].bw_range.stream_kbps);
 			vars[i].dsc_enabled = false;
 			vars[i].bpp_x16 = 0;
-			drm_dp_atomic_find_vcpi_slots(state,
-					      params[i].port->mgr,
-					      params[i].port,
-					      vars[i].pbn,
-					      0);
+			if (drm_dp_atomic_find_vcpi_slots(state,
+							  params[i].port->mgr,
+							  params[i].port,
+							  vars[i].pbn,
+							  0) < 0)
+				return false;
 		}
 	}
 	if (drm_dp_mst_atomic_check(state))
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
