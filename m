Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AD3C36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 19:53:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC17110E03D;
	Wed, 26 Mar 2025 19:53:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dqMtNqq5";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74BA010E1D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 19:53:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTpNElXiv98QDYvifx9N71Hk0kzLwN5O8htgTz4ZYDsebzugEyEn1a1eeU0yoVn3axRpDIeRdKZu/3MrbCbC7UyAlzVtTxsOqStMtueE8kMclq91F2/tMgvlrNjcVAiHEtu3mY/mDXb1rZL5CNP+u5bJBoPMywaxMwgunREn6MgID8Y1hElZt4HYi3pep6qwgd3iMRM80boElFQwQYyuCieAKSPHMj+vsMszcTKNoeWt+dULGwgAM9u02rmUmLTaGrcSwIWrEYRup7FlVzuiGU7PmGR47cFdOoprdLky1o6bpwV9+/LUeoPIzvZ4jAmOMZNPq57FFhLJI4xtAfztCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsv08eC39Qsj325mMiUN30grE5S6Z0BcNI3yr3DRIl0=;
 b=og7MqY24lp4B6VRlK0B022mwsM/xgDBLrTmMgrHDK5cj/4D90aScqzyDRWEkaOwol3+kQxTu9Fv21wiH+UT9Mz8uL+MPQvlsfg+t/cKXG3KIN/QCDtgnH7a9redYNSnSi/3ZqQxT9WqoAZpBx9nqMbYUFTn1o5TqTJkS5rYO4rRAjIPZqty30SDFYdaWasnHZjHa0nsRmp+y2MnrER4JymmhRAiwCq7hHiluXzDHpcfghVEygtTCRh3Jx6NTI7CBI3XQeZApmpiMdra2myROeuhc1HbmfAtq+HbizOuqD+WyKI3DTtRf9Nn0Z/8YAPUwXsCC8wIQ7DV9psNMfUEGmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsv08eC39Qsj325mMiUN30grE5S6Z0BcNI3yr3DRIl0=;
 b=dqMtNqq5VDZKiDHw3hvg5RlYiYdnGUBVsh4YRKCVZFMzNmpqc4pLGlNx/I/tCaYbUr0XhXdKRBtjUaQyVJcaD+cp3IInw7UBUdxj9mg2PakNlLXh4rrvqKslTT+6V+eGmjMVQGGVCZJtMOP7Ad9joM0nUthClR0pndV3oF+b8nU=
Received: from SJ0PR13CA0178.namprd13.prod.outlook.com (2603:10b6:a03:2c7::33)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 19:53:13 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::e) by SJ0PR13CA0178.outlook.office365.com
 (2603:10b6:a03:2c7::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Wed,
 26 Mar 2025 19:53:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 19:53:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 14:53:09 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 26 Mar 2025 14:53:09 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Austin Zheng <Austin.Zheng@amd.com>
Subject: [PATCH 05/17] drm/amd/display: Set ODM Factor Based On DML
 Architecture
Date: Wed, 26 Mar 2025 15:49:02 -0400
Message-ID: <20250326195202.17343-6-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326195202.17343-1-Jerry.Zuo@amd.com>
References: <20250326195202.17343-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f23b6ae-903c-402b-09cc-08dd6c9fd774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yMOV9QMh23o4HyLGjdYRxCqigs6RINzZJC/MnG3/pcZTFIt4ut3pooIoTeHS?=
 =?us-ascii?Q?UaC+55u0tMsOjRO0Vv2NsJCjX/QDl1slls8x5HKPmTS5ZtqpVta22WH9c13X?=
 =?us-ascii?Q?EcQjskSezk4dxmvPtJuo5L8q+Z7+FE1/WgekE5E84PCz/w2Xa7UX8n9x53dS?=
 =?us-ascii?Q?HKz0BWlNwzo6HCh6eTE+DuMh7jwCnYFsn5nX29/ceOZyvunXlxsEH5AIdDtX?=
 =?us-ascii?Q?wVGrTQJf6rk2FuP+o0owgSx7TnNnniFJ3E4hW0jhzsNHP+LOvYYsTtz9pVRw?=
 =?us-ascii?Q?1fmUGHb3ZiyGTmFaidFbnjGu+Anr0J7cUVKKTgdSF0LIpVNvxM2m2WNVdi+B?=
 =?us-ascii?Q?b3WH6V9lhFyFg8aQ531rAnbZDBp9qcxQB7aIy8/pyLur1CQ6PXd1cjgU7TjS?=
 =?us-ascii?Q?Oz9gXVrdAszcLxv/H44ZW0oyFuGrray5NJB+C0jU4QrN6bYSRCx+mVXEQBiC?=
 =?us-ascii?Q?fpzpIi0tDFTw1QJ/wqUSKW69iBE/Hdsn7AmGd98ZKG8VTYBcPUHw1Xp/AoSj?=
 =?us-ascii?Q?Ip4YgGvYN0SSMHx+A+f3cxBjAXEdoZc9myytEUt7dMguSJ7gygfpHMKhbJJm?=
 =?us-ascii?Q?j/vHUzQ1wWUKYxAUpUguv6gwRRVxxgsEKei+VcYLLaAm5k7FeFilptFo1DDz?=
 =?us-ascii?Q?sDrMSQOLrozmlHIcfkiws3RBcZVC7bwIlb6JAV7wSE4NYNI1YWTHuOm1CXSp?=
 =?us-ascii?Q?WXM8pPxJTfbIYzEAfYYwA03p3XEBapC8LbJgYvXx4m1BayDkki+Nd51dgnsp?=
 =?us-ascii?Q?a5zvz9zFYIuSnY5DYJYBvYjw70bvYsXPt/H55kT99fJAeIhNR2rjYdKhhb9O?=
 =?us-ascii?Q?A02KNEg5VPBcLnsCVgr79pcoR1NvSXSEwr7yhuiPtQpLIdmRDF7YJ0KYR1l4?=
 =?us-ascii?Q?HeuSzJfJv/A0HcNxujssxvs36BEilw+m2yJRTnXaXg82ldpgmEj+knMO2Pb4?=
 =?us-ascii?Q?R2A9MkpuGDNu/YObfMGmsz3AvB02T+iM/V3VE9kxKWqw6qutV98jBcb4HuAs?=
 =?us-ascii?Q?D5fJJbFHYxcFhN19sf15XLe60ucRZthS9zd+WgbrmmivDfK+cjr37+10U9ak?=
 =?us-ascii?Q?OQbotoOUN/aT+SsbfE0BDPqVFrAE8BcB6TtQG5MVWw6i0pIENgJgUm91RdcD?=
 =?us-ascii?Q?fQlnKppdKA4NyMDKtZrrL6IGr2Tkk8jg79jlnrfgq4lvyWqXf9XiNyL92boR?=
 =?us-ascii?Q?itgPg2m0YRxP3If9f0m3dy2I4nUdjq5hj2DefWx5uGEXxE9yNhP3/osTAJud?=
 =?us-ascii?Q?o49UpmVemOh+RSJfhug3A0LSS3k+alqnf8A8e6rFTK+L0whiZ0B0IvAbbuUI?=
 =?us-ascii?Q?MBjO8ZQVVP4JnsJKa5FEU+vUoRBx80uzj8c/GGDhE0x3MB2NCSdfDxla+bhM?=
 =?us-ascii?Q?hqAlI2IKN7K0EKnXONeiEl9AvxWPkp6UNz69f8O1a0dME5uXisBcStGsmyup?=
 =?us-ascii?Q?dCD4SBF37rSCSjI/aZXU6pXVBNnwb+wXVIWGjpoVlr7eGsg8ZBY9nnafxpLf?=
 =?us-ascii?Q?5Xf5HN5E0ytieBU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 19:53:12.5065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f23b6ae-903c-402b-09cc-08dd6c9fd774
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Austin Zheng <Austin.Zheng@amd.com>

[Why]
Mapping of ODM enum is different for DML2.0 vs DML2.1.
Configs using DML2.1 will incorrectly trigger an assert meant for DML2.0.

[How]
Use if/else to seperate logic between DML2.0 and DML2.1.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index a966abd40788..5f1b49a50049 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -1082,22 +1082,22 @@ bool dml2_map_dc_pipes(struct dml2_context *ctx, struct dc_state *state, const s
 		if (stream_disp_cfg_index >= disp_cfg_index_max)
 			continue;
 
-		if (ODMMode[stream_disp_cfg_index] == dml_odm_mode_bypass) {
-			scratch.odm_info.odm_factor = 1;
-		} else if (ODMMode[stream_disp_cfg_index] == dml_odm_mode_combine_2to1) {
-			scratch.odm_info.odm_factor = 2;
-		} else if (ODMMode[stream_disp_cfg_index] == dml_odm_mode_combine_4to1) {
-			scratch.odm_info.odm_factor = 4;
-		} else {
-			ASSERT(false);
-			scratch.odm_info.odm_factor = 1;
-		}
-
+		if (ctx->architecture == dml2_architecture_20) {
+			if (ODMMode[stream_disp_cfg_index] == dml_odm_mode_bypass) {
+				scratch.odm_info.odm_factor = 1;
+			} else if (ODMMode[stream_disp_cfg_index] == dml_odm_mode_combine_2to1) {
+				scratch.odm_info.odm_factor = 2;
+			} else if (ODMMode[stream_disp_cfg_index] == dml_odm_mode_combine_4to1) {
+				scratch.odm_info.odm_factor = 4;
+			} else {
+				ASSERT(false);
+				scratch.odm_info.odm_factor = 1;
+			}
+		} else if (ctx->architecture == dml2_architecture_21) {
 		/* After DML2.1 update, ODM interpretation needs to change and is no longer same as for DML2.0.
 		 * This is not an issue with new resource management logic. This block ensure backcompat
 		 * with legacy pipe management with updated DML.
 		 * */
-		if (ctx->architecture == dml2_architecture_21) {
 			if (ODMMode[stream_disp_cfg_index] == 1) {
 				scratch.odm_info.odm_factor = 1;
 			} else if (ODMMode[stream_disp_cfg_index] == 2) {
-- 
2.43.0

