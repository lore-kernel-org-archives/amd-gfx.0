Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11018D10DC0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 08:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2E6F10E668;
	Mon,  2 Dec 2024 08:49:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gQzIPZKu";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57F2510E662
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 08:49:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXVusbX0EJnLjwO1w9RMKo3WjN4pJIgVlbEv5Qk3iADvSLY4qe0gmvlL79uXQ1s++ewTdXOhjQLd3Dw67ckgA1aDFtL4E4IPX84MaARNUZkBJkt/8MnZjwpjDCStKEazBoCzCgCdZvfCo3nmwmbVs0jWafqJpArkozrLvu1NH/Zme/gFLO9CiDqduaT0mU2ePoVl0EWrGPpnQr5n3Ez73tRfpyUgiIMu0KZfuLoEOG7sbdnnJBs7o6prsXNA9+MjPAzG9T/YgmGl8nfWXVlW4kpaRfWAIspQ9ysNsVK94EJP+e6Sz4o+zS4CNM1Pu7oX5g9b55wZHEAK00WYIgz61A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0GB4Mb//Us//oDurROb0XmrM4qZgD7Y8m32WajI1Vg=;
 b=VckCu/cHnB4jOuwashbxUhpXCgYZGLyUqXTL1ahs8kbtFqOhpoGsNqZ8o+gXMy7Zx8RA5VQdPRn2s0MQGbub/8CzjRWGTFuR3XDqNTGBfNxYt0W3227/yZlqURmQxh/o8GLquMjj9LtvgH8iAqUysxfUvyJ3fKJ6Yvmmc1HBnK5INg2A9A98xoqtI7TanoUVXQS0/JiXYS6j/2/vv4v2xkA997uPjrAg7WRc53Hr2yJh3zPVpx/UQ+bKF5w47DQWF7faHtUU3sOtCAXQQ1A5+OzIqXnb34Xietyf/kTgj24VLGIhepbFMq8OhSoYHtp2RC/tXsHw1entNvowlU7Ypw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0GB4Mb//Us//oDurROb0XmrM4qZgD7Y8m32WajI1Vg=;
 b=gQzIPZKuZu9ss0qR8kN90h3IHU+ugsJZAMJxehwe3QecVwl4gkJbqAJG596Ge6NzT5mJfvp+48M/C77wI4cPJJuV4k66d5JanMA318A5JwUz00uYsA03Zw51Cdv4aEnLdDaJT6cQ7o7UTVUzdqnMafo1m8aqPtSgIOIf+I/BKWI=
Received: from DS7PR03CA0295.namprd03.prod.outlook.com (2603:10b6:5:3ad::30)
 by CY8PR12MB8364.namprd12.prod.outlook.com (2603:10b6:930:7f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 08:49:04 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::86) by DS7PR03CA0295.outlook.office365.com
 (2603:10b6:5:3ad::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 08:49:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 08:49:04 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 02:49:02 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, <stanley.yang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: add ACA support for vcn v4.0.3
Date: Mon, 2 Dec 2024 16:48:49 +0800
Message-ID: <20241202084850.1960341-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202084850.1960341-1-kevinyang.wang@amd.com>
References: <20241202084850.1960341-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|CY8PR12MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 922489df-4365-478f-9857-08dd12ae2d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iSryI4LvBooB9xCpQAJsjqeXR1q2kpDdBHsAkg8FKWbhKwRD2UZCe6k8COcl?=
 =?us-ascii?Q?WW4gyTsxb3xoQ6fjIXdAZyPKaf3Rvx3Mw7cU8MGl3yeh0GebwqJl7FlKdgz5?=
 =?us-ascii?Q?wAvbdJLPGQCDbSfKSlszzOG4wruMQ9BdYYRger6SLAwsFMEfK9f0cHPH+nyV?=
 =?us-ascii?Q?AcCwyALn5uGWH3kea0ju+sqd6nDDWUzE7M7IvZA/ir7VlOuYZN2WB9A7ot3I?=
 =?us-ascii?Q?kLuzp2oXoKZCXkHclADZwpyY28eF8bhryC26xFE6WqB6D9Xc57ATL1YIGh4C?=
 =?us-ascii?Q?UNJ8bBAam5x58ofE41v10pntkF5SO+4dDTs/VRlFJECVoFNbZd9Ev/+AQegF?=
 =?us-ascii?Q?6RHR1Ulx9FaIH4Vi9snvEPlBDQ1hDWLVQMnmaDo0EVOEzmu03kVi99agcJTH?=
 =?us-ascii?Q?J2bJqP5KOcXt/Cv1YddfPlmAI3Y/Ri0k2Z7kRIH6wNkrHfPSiJSjDYNvqBLO?=
 =?us-ascii?Q?n+fx2LnHAale9R0qMJsuxggH/Iu+sP5gbemNO2S+gW6DZWJXn9jxG3Xp4vib?=
 =?us-ascii?Q?RFUUsnBDN6nlMPUV73Nx6MNuFkbUVU90kR4RbICuZPLC5KmlPkqd6WCWfgtf?=
 =?us-ascii?Q?l0dN44dIJvm5sAdn/L1ihugf3jYr+tOOG6MBkI1nKc8dO9ykSwJPoAILSBBe?=
 =?us-ascii?Q?e4ZC/QjRUbXxTagTDpF5nO5qZAVA9+AerPk0Kx5eVCsJoGfMC/KXgUWfJbB1?=
 =?us-ascii?Q?CFHb+CIVBTSFp75R4MuZ/uIDDD0Shg11R+b0PNoXAcTFUEwAOMKlgvny9IAe?=
 =?us-ascii?Q?lZbvY6WG/w7qgYc8MVFnFS0slZofxuKSSLgNU1t96yBGikCCE3MvbJnOvw/z?=
 =?us-ascii?Q?p0wV6h8p2nzXmKcGHdqWrxNhGe3nz1juJiNEij5wM7wHgjTW4OSm0qX/7PDM?=
 =?us-ascii?Q?Tm2k9PkrKco5JrLrO616G4uZimGTxoLZG07fyeVvXrLMbA+jLJLHbhqLFw2S?=
 =?us-ascii?Q?aguXZ11bVUoTyGVlMCKPnbRU9u8MwQIAToHv0ezl/pvI7NS1+o6SHtcZ2bR3?=
 =?us-ascii?Q?c00diHpHGnpkwymqxZ6sRmZqBS+Kw7OMZnJJm3ia++RA1pyZanWogT0nmTn3?=
 =?us-ascii?Q?V/4LQurwqvVn4It1JLzHmxhjnH4ABfFR4UMbJLEN2nxSdgT08luEF22FYavV?=
 =?us-ascii?Q?wvdpiQ6Uvkaqs5rgdsBaFkV2whzStsQ5ut6TE0ot7Lk6BCAVwz3WZwQ560Cw?=
 =?us-ascii?Q?EW2M/cnbg12ZQFWGHr7LS8phzs8ItPjyT0c1yJtZGhxoBPWqmkVVB52fJa+j?=
 =?us-ascii?Q?3mbrOJaB6/8pKR0/qpSjc/YlWXloVeJMUWrTNkQ3wXeaBHtvdU+Y9RC+ncMf?=
 =?us-ascii?Q?ZdIfpkwEJsbEqJU2N0i6AXVfaGSOp/s6SPBpx1COCEAK3HIm28ztc0+HyiQ6?=
 =?us-ascii?Q?ZtvH1C5qXBXXuxdDDYWL6l+3QSJvXr8SLglrFn6rCA7Y5oqUvKG1OjOBV/Yr?=
 =?us-ascii?Q?qO+SlOCNixh13UiiVHbpLlAg31klyI29?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 08:49:04.7809 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 922489df-4365-478f-9857-08dd12ae2d3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8364
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

v1:
Add ACA support for vcn v4.0.3.

v2:
- split VCN ACA(v1) to 2 parts: vcn and jpeg.
- move mmSMNAID_AID0_MCA_SMU to amdgpu_aca.h file.

v3:
- split JPEG ACA to another patch.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 85 +++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index b23a69fabe3a..eeade7366e82 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1915,9 +1915,94 @@ static const struct amdgpu_ras_block_hw_ops vcn_v4_0_3_ras_hw_ops = {
 	.reset_ras_error_count = vcn_v4_0_3_reset_ras_error_count,
 };
 
+static int vcn_v4_0_3_aca_bank_parser(struct aca_handle *handle, struct aca_bank *bank,
+				      enum aca_smu_type type, void *data)
+{
+	struct aca_bank_info info;
+	u64 misc0;
+	int ret;
+
+	ret = aca_bank_info_decode(bank, &info);
+	if (ret)
+		return ret;
+
+	misc0 = bank->regs[ACA_REG_IDX_MISC0];
+	switch (type) {
+	case ACA_SMU_TYPE_UE:
+		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_UE,
+						     1ULL);
+		break;
+	case ACA_SMU_TYPE_CE:
+		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_CE,
+						     ACA_REG__MISC0__ERRCNT(misc0));
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+/* reference to smu driver if header file */
+static int vcn_v4_0_3_err_codes[] = {
+	14, 15, /* VCN */
+};
+
+static bool vcn_v4_0_3_aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank,
+					 enum aca_smu_type type, void *data)
+{
+	u32 instlo;
+
+	instlo = ACA_REG__IPID__INSTANCEIDLO(bank->regs[ACA_REG_IDX_IPID]);
+	instlo &= GENMASK(31, 1);
+
+	if (instlo != mmSMNAID_AID0_MCA_SMU)
+		return false;
+
+	if (aca_bank_check_error_codes(handle->adev, bank,
+				       vcn_v4_0_3_err_codes,
+				       ARRAY_SIZE(vcn_v4_0_3_err_codes)))
+		return false;
+
+	return true;
+}
+
+static const struct aca_bank_ops vcn_v4_0_3_aca_bank_ops = {
+	.aca_bank_parser = vcn_v4_0_3_aca_bank_parser,
+	.aca_bank_is_valid = vcn_v4_0_3_aca_bank_is_valid,
+};
+
+static const struct aca_info vcn_v4_0_3_aca_info = {
+	.hwip = ACA_HWIP_TYPE_SMU,
+	.mask = ACA_ERROR_UE_MASK,
+	.bank_ops = &vcn_v4_0_3_aca_bank_ops,
+};
+
+static int vcn_v4_0_3_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
+{
+	int r;
+
+	r = amdgpu_ras_block_late_init(adev, ras_block);
+	if (r)
+		return r;
+
+	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__VCN,
+				&vcn_v4_0_3_aca_info, NULL);
+	if (r)
+		goto late_fini;
+
+	return 0;
+
+late_fini:
+	amdgpu_ras_block_late_fini(adev, ras_block);
+
+	return r;
+}
+
 static struct amdgpu_vcn_ras vcn_v4_0_3_ras = {
 	.ras_block = {
 		.hw_ops = &vcn_v4_0_3_ras_hw_ops,
+		.ras_late_init = vcn_v4_0_3_ras_late_init,
 	},
 };
 
-- 
2.34.1

