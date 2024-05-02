Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D74C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 19:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EC8F112652;
	Thu,  2 May 2024 19:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="csS5hPWt";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB386112652
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 19:16:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeOu+XuJuX3SkdBs+zY0b6atB0pCdwftYT6DL4rTmrjW6sGrb+XrLfTlRLl+9mXQLKH88JUlVcVg/yGId2LV9H/2/IXF5+CLRmRO/FMp7+h0k1X+4JnVQVFJfpdmXq6xuEZxU7LoB9QQ59udRvUEpwHGr1g/+IUOMUVAO1cTX4qGVDpvcFXUzaHp6mbnO9ADyLsCD4SbmMbQobSVw/ug28rgYZPDOJpuwvbfPclY4R1b5l/8jM5vhxWc3cSgBN1zOqtM0uQIw3oqbVt321aYRNf5MbgENEwB1DQXiMtNAgRcZFlqSt1Pg0AYpVn5y6sSgM5nBNielqf18j8iEWbZmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZ6H1R+nXOJ2RBpGMoUXYelW/W/5PvwEN8mypvNVyzg=;
 b=ctdqPvW4/z3pPFZpgi+vf1USXSO2OrgEgWtyMrbiFcA1EgwtLRjU5XSHoP+RPitjSHVznEQrvYbzRP1Yp23SQcetWKGCP/pA8dw4kmQ/n4J5tECdbKeSrBu+9hZ4sCHNntft5KC1d7IsV5owNfG9tYDHqcCt3A6DKbP15GP65x/Xi6sCnASHAp1PkdQB6+k42cu243O3gKicL2MlodOExs+ZgojAy58kMEf7YfN5VEkV91KYDoW/ibuKWlT/tnJrwqpj7sqsfS+t5pB0dL5oTXVKs1BfM3mdTKDNC9kygncG+Vo42pYixkLzwwCwWE6K8wGkyeGh4fRVCkVYM15udw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZ6H1R+nXOJ2RBpGMoUXYelW/W/5PvwEN8mypvNVyzg=;
 b=csS5hPWt535CdbzeLAuhKWy5sU5cz7BEGKx2ftQ7DwvpoYZccMC+SCaR1LoxBXhoRGKlUArpfAiVoJvkVIOBd4s/RN6IvN3PJroUfsQ+8DaiypAtmM5pr4PdCKaz9Q1d/+l5ZcGM31YKMRJlQTSPyRMFCJKkj3xTqTMDmFHkIL0=
Received: from DM6PR17CA0010.namprd17.prod.outlook.com (2603:10b6:5:1b3::23)
 by PH7PR12MB7209.namprd12.prod.outlook.com (2603:10b6:510:204::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.40; Thu, 2 May
 2024 19:16:19 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:1b3:cafe::3e) by DM6PR17CA0010.outlook.office365.com
 (2603:10b6:5:1b3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Thu, 2 May 2024 19:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 19:16:19 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 14:16:18 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Tim Huang
 <Tim.Huang@amd.com>
Subject: [PATCH] dm/amd/pm: Fix problems with reboot/shutdown for some SMU
 13.0.4/13.0.11 users
Date: Thu, 2 May 2024 14:15:52 -0500
Message-ID: <20240502191552.31905-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|PH7PR12MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: 894bd031-a004-4e48-7121-08dc6adc58c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m7L4YAbf9T+nlxjZhYKqHhbz7Zc2XI9tU2mESuGpfyIE4JiwoHWNcAgKUrX8?=
 =?us-ascii?Q?WfyrzS5EhhFTn1WV8KVwe3hJ4Xbu53WSx7a6wBDv04bhyEFPgMex4/GNZfrG?=
 =?us-ascii?Q?Qi4Atd5IkOr9ekvN66abigGOSPZbI7ifHReE6wV/0osLuF5XNVvZFcXSMVtX?=
 =?us-ascii?Q?GvmhiwYTWURwaE0w1BE9b7fpWxhMeZPa7dXrYGdwPwy9I60RQiZVq7gG5qU/?=
 =?us-ascii?Q?ttc5fXPw6lgUCNjRLfUCNuWSBSPYaIxnfPDMULAgJWNB5cmiOS1JMxhL6KZs?=
 =?us-ascii?Q?Xece+QgFNyQqfPPnIwQbMhWvte0x5go+4uCixvZ9+R0cZ3QGPd4FqyaHXCzr?=
 =?us-ascii?Q?LM4SFFifcRfcbAb2F9vr7cD3MiHgIn6lzt2akyeIiFDKqCiTSgW8LouGNE9Y?=
 =?us-ascii?Q?lZWyZF8QXb+H8rUTTZbvZFJolH/t9lDxmiI4tbf9f+CrcKvpokR95+1421fE?=
 =?us-ascii?Q?U6TMxq0MUJlNtRf3FK6NbTmnQha+BqyL3KQnJpCZ4tyfYqSv1gmGETEgpAC2?=
 =?us-ascii?Q?tb80B97dbHowx0HK6hdpbSL8a2yVIcKXRonWN2eYnQvE6igTDrgTyPXkGgrw?=
 =?us-ascii?Q?tWnK+apFMT1VV05kNdLHyeKP27Nf9JrRFCrk2zrL3s+mBl02UvNWCQiSzgpr?=
 =?us-ascii?Q?yEBHBlF2ClEJzklTZk3V3Vucss9mQRlL3oppT8jlwA2shAdOvexjVuhziOY6?=
 =?us-ascii?Q?he82ENN4b4N9XAJdB9k5eVPiIKuE2eGrq8S0sIUDFQMcaqTJEnumnevz5IRe?=
 =?us-ascii?Q?17+3QkQQkNbhnhXTC13fnDxkBLum0ahlrJAvhU4va1jNg4TLzvXJTODWSLHL?=
 =?us-ascii?Q?dvahf2lbDrhI+5VPHHwCrKevCHBao4smMh2IMsPGPMwTp0vEmBJIcHKAbxwH?=
 =?us-ascii?Q?6AQJkdE8Xl/d2FaknuF7n1iC3zew88QQ/UuAiqrXiCL+nTbFYJX8IrC6OXR3?=
 =?us-ascii?Q?lDHvKeDK+3I3dZA6Xj3V9dLOV8Prroob8kap0WiAiAzXQnOLqNdFustrTEQ2?=
 =?us-ascii?Q?iaAa/u5lQtAVQCel49rRCwfHVf6hfaD84ARJZqHV2kGDD11WKtNiYsSRypde?=
 =?us-ascii?Q?A1f1uEOlQE0y84I2aPfIbt0Y+FtRSuCABtYlvzxQT6z1NXdx+J3idU7vpBTv?=
 =?us-ascii?Q?PIIeM4GbphtADrxzofpVq6H5CfxLrxEKebZjokGnlG/ruECXDiUPvoQO6Gyy?=
 =?us-ascii?Q?xjjHhTu9HZBQ3Bfei83WZwSpOrRBH9VA2GiCkuQEkwn2xsfPJDbwYTgS8+UX?=
 =?us-ascii?Q?gooJ0W4AkJheotMeW4yOELljwkahSSorx7uEGVybf0qpJHckn8zt5uUIu13e?=
 =?us-ascii?Q?gJWFcX8+uK811FKp40hoets0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 19:16:19.3473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 894bd031-a004-4e48-7121-08dc6adc58c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7209
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

Limit the workaround introduced by commit 31729e8c21ec ("drm/amd/pm: fixes
a random hang in S4 for SMU v13.0.4/11") to only run in the s4 path.

Cc: Tim Huang <Tim.Huang@amd.com>
Fixes: 31729e8c21ec ("drm/amd/pm: fixes a random hang in S4 for SMU v13.0.4/11")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3351
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
I tested this on SMU 13.0.4 for ~85 cycles with this script, BIOS 1.1.0.2a and
didn't observe any hangs.

```
#!/bin/sh
echo test_resume > /sys/power/disk
i=1
while [ : ]; do

  echo "Starting cycle $i"
  echo disk > /sys/power/state
  echo "Ending cycle $i"
  i=$((i+1))
  sleep 5
done
```

 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 949131bd1ecb..4abfcd32747d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -226,7 +226,7 @@ static int smu_v13_0_4_system_features_control(struct smu_context *smu, bool en)
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!en && !adev->in_s0ix) {
+	if (!en && adev->in_s4) {
 		/* Adds a GFX reset as workaround just before sending the
 		 * MP1_UNLOAD message to prevent GC/RLC/PMFW from entering
 		 * an invalid state.
-- 
2.43.0

