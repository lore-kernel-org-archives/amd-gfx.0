Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE214C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 03:36:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 845B560C3F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 03:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 845B560C3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA2346E235;
	Thu, 12 Aug 2021 03:36:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B800C6E235
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 03:36:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpvuqJHRCHFevzKtcjCF69EC4++ZlJ7eEfIKRZ+DsAHCYeYiNtbCbFBU4vK+5V0yb6SrOnYZKCEqaz3pwwldKy4nQVbYmQyxVh/81LE17AuPxsB75c7bJZN7+QIJaIMDUR6RwdV+sdQ3t7z8AaPRTU4ClCi9CpPwEFhA3emNicAqRshiuT16YZfadtneAXpGRzYkF5Saf9OMd3eYAmoRXHfzqHxbLKjF5K28RHGqekm37CXPIMfLg0Shzr22SSTKemRruYb6UX99OfMRWTmilOb7hbBBr2uNx2XWM03dL7vjn5z8CyOLbRbIWqultEGA1dgdwSVTvM+ANSuw+kJTiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hH5TNlYMcfCMXQcD+X0dbWMxGNQPUGhZqbA0ndliKkM=;
 b=X9jNqd0tpav1BrbzvTY96ZSaZYYcjjLaSy8WeiKF2NKxiq48dGy/6wsCwhYOY8SZFhQv8EjDauRuPu1EnBbAXyC9iv+JY9etjxakVtBGw44PFTg4LrjECxO1Y0CFhFKOS6RuLygdNWNRhGZwjU0uPjcz1kYdMm6VNG4gZlw0p4s8beJAoa+EMoBCwRPSrOkhpJsxzOA5+SG0w9b2MlHrnfrfL2TW5yPVzrdL7Pg/NV5bbV54QsG+YFn4IYvQFP/lmvcwQccwl8Chv5lWtPkobL3ZUzz1+jUY7+GpbsWoZJXL3uLM9rQHgVdECQS0lQmeIGnLI1kk49cv2oYsawW+0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hH5TNlYMcfCMXQcD+X0dbWMxGNQPUGhZqbA0ndliKkM=;
 b=TaujcfvS4iYa9QbKL/HutECIOE4P8qRLWNlxmzAAshXwVRm5zz4csYSf51nvxU6m8aJ4p9egxBHzEqGTD01ckhw7SzL+Qj4st5+YUAG2IUnEtEYWK2AaM+XlYQtalKpN4JiyOF+WjN5DGxryhSZlFJpgN3bFe1lRMIcLnMp3qCI=
Received: from BN7PR06CA0067.namprd06.prod.outlook.com (2603:10b6:408:34::44)
 by DM5PR1201MB0009.namprd12.prod.outlook.com (2603:10b6:3:de::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.20; Thu, 12 Aug
 2021 03:36:14 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::10) by BN7PR06CA0067.outlook.office365.com
 (2603:10b6:408:34::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend
 Transport; Thu, 12 Aug 2021 03:36:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Thu, 12 Aug 2021 03:36:13 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 22:36:11 -0500
From: Kevin Wang <kevin1.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <kenneth.feng@amd.com>, <frank.min@amd.com>,
 <hawking.zhang@amd.com>, Kevin Wang <kevin1.wang@amd.com>
Subject: [PATCH v2 1/2] drm/amd/pm: skip to load smu microcode on sriov for
 aldebaran
Date: Thu, 12 Aug 2021 11:36:26 +0800
Message-ID: <20210812033627.1241847-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23526c5a-553c-4891-cb43-08d95d4255a9
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0009:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0009F046D26B5AE99B8BCF5DA2F99@DM5PR1201MB0009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Gpjwl+9Pe9Y7X+na52StExvDwhE7Z5prlPqu4rOt86fbztBEGrV4tp6DvaR0nsvMo2Dyf1VhzWE/SQmSG8fWBzMqqY4+f2/qzYsOG9jN0ObFsbNp0Emz6+4s2JS6dUKGW9f2w6oEcoZ/hQFTxHeSQTwDpRXb/iUB7wbNxItXVRv/vQn2+JuIaBru7GtJI00+EurDXMe6riXIaYaI/wY8OGOheBPjKEmVcKZkW8VTz8GEnIqhSnolCa3sb+/GQIwj50ytCAXhxmeGfrM25Opc3KAM4M0cueKHp4DCi6Hm7s6rTDGaQBcUwSdPy3b7Fn8TH2oBqnt4F7Cat5HeTRPDSB4QNc3CMSQMxTusuXF9F/kPTPbz9Ctyt0jXKQCJoEMRhS6YR3GNNUCiN3SCQUsndU4ok2J1VZ64OzKZNyLMCW3FfVVdpWPd9tZY6B8HPsix06GY5Mov1qVKflx5rvAOhG4yX86fRgFhW0McqfJFAYcm2Pnc9UAJtxGYIksqqJ+EKenQbgwyH7db+JamZD70HpM3eDTIq3Qe0n57Yt9iADnFfxOUs1rBxXRtyJeww9HfmyqsHQZaHZU6q3b9Tnqa/kaJa0GOQRsmfkdm6Wo4wi8O6SjmR7Pixi/x4J6yHqhe1+/bm9NpXssO+6oi8W0LpbfiJTUvq/aDvfixK7w07g02525HtuQCH8JWUtz4teWhaD9uZD2QlaJDh4ciHZQB58fDKOEst+X9TwGh3F090HSOa/nIiHKZUF/PE+bDIWIAdZYnqWjtgxedvu/NpQcww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(46966006)(36840700001)(70586007)(70206006)(8676002)(2906002)(26005)(8936002)(47076005)(86362001)(6666004)(356005)(7696005)(16526019)(186003)(82310400003)(83380400001)(4326008)(36860700001)(316002)(81166007)(1076003)(34020700004)(82740400003)(478600001)(36756003)(5660300002)(6916009)(54906003)(2616005)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 03:36:13.5611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23526c5a-553c-4891-cb43-08d95d4255a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0009
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
1. skip to load smu firmware in sriov mode for aldebaran chip
2. using vbios pptable if in sriov mode.

v2:
clean up smu driver code in sriov code path

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 41 +++++++++++--------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index a421ba85bd6d..ebc081dc01cd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -85,6 +85,10 @@ int smu_v13_0_init_microcode(struct smu_context *smu)
 	const struct common_firmware_header *header;
 	struct amdgpu_firmware_info *ucode = NULL;
 
+	/* doesn't need to load smu firmware in IOV mode */
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	switch (adev->asic_type) {
 	case CHIP_ALDEBARAN:
 		chip_name = "aldebaran";
@@ -273,34 +277,38 @@ int smu_v13_0_setup_pptable(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	const struct smc_firmware_header_v1_0 *hdr;
 	int ret, index;
-	uint32_t size = 0;
+	uint32_t size = 0, pp_table_id;
 	uint16_t atom_table_size;
 	uint8_t frev, crev;
 	void *table;
 	uint16_t version_major, version_minor;
 
+	if (!amdgpu_sriov_vf(adev)) {
+		if (amdgpu_smu_pptable_id >= 0) {
+			pp_table_id = amdgpu_smu_pptable_id;
+			dev_info(adev->dev, "override pptable id %d\n", pp_table_id);
+		} else {
+			pp_table_id = smu->smu_table.boot_values.pp_table_id;
+			dev_info(adev->dev, "use driver provided pptable %d\n", pp_table_id);
+		}
 
-	if (amdgpu_smu_pptable_id >= 0) {
-		smu->smu_table.boot_values.pp_table_id = amdgpu_smu_pptable_id;
-		dev_info(adev->dev, "override pptable id %d\n", amdgpu_smu_pptable_id);
-	}
+		hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
+		version_major = le16_to_cpu(hdr->header.header_version_major);
+		version_minor = le16_to_cpu(hdr->header.header_version_minor);
+		if (version_major != 2) {
+			dev_err(adev->dev, "Unsupported smu firwmare version %d.%d\n",
+				 version_major, version_minor);
+			return -EINVAL;
+		}
 
-	hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
-	version_major = le16_to_cpu(hdr->header.header_version_major);
-	version_minor = le16_to_cpu(hdr->header.header_version_minor);
-	if (version_major == 2 && smu->smu_table.boot_values.pp_table_id > 0) {
-		dev_info(adev->dev, "use driver provided pptable %d\n", smu->smu_table.boot_values.pp_table_id);
 		switch (version_minor) {
 		case 1:
-			ret = smu_v13_0_set_pptable_v2_1(smu, &table, &size,
-							 smu->smu_table.boot_values.pp_table_id);
+			ret = smu_v13_0_set_pptable_v2_1(smu, &table, &size, pp_table_id);
 			break;
 		default:
 			ret = -EINVAL;
 			break;
 		}
-		if (ret)
-			return ret;
 
 	} else {
 		dev_info(adev->dev, "use vbios provided pptable\n");
@@ -309,11 +317,12 @@ int smu_v13_0_setup_pptable(struct smu_context *smu)
 
 		ret = amdgpu_atombios_get_data_table(adev, index, &atom_table_size, &frev, &crev,
 						     (uint8_t **)&table);
-		if (ret)
-			return ret;
 		size = atom_table_size;
 	}
 
+	if (ret)
+		return ret;
+
 	if (!smu->smu_table.power_play_table)
 		smu->smu_table.power_play_table = table;
 	if (!smu->smu_table.power_play_table_size)
-- 
2.25.1

