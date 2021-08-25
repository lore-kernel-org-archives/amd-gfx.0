Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD25AC432BE
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 20:50:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7083A60F92
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 20:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7083A60F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA8156E420;
	Wed, 25 Aug 2021 20:50:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E4506E420
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 20:50:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZqXirMF4P3poAr2KWDnBKDBXXuFZsp2d+JFqFfsq47u3bpeZNOOu71Taxj6vXi5hAd1HOCbZdHW4s0zqrZv3coQejLGYexiuorKFJcctPu1WSdLsv7WOkKsESiFfQaXSWfAdcpZBkWIebRJ+dGsz/cyhQJLYQFzXco2x7jCgY4bHLA0LqZgpm5ASRyLJibZWuwAyrOnLY19LM+soYaY7+QVhjwcRjauyEBMHlaPwE7Yskd9lO1k7d7xj+zPLvI1NbYhPpcu5lTgiaKJNNgjRpIpQ5OWPQ7Fx4x3Xm32ptYmDQOvwgiv/fJnZQiy8ThSEOIxcccUY5MbOOmAKfD7ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSA3xb9akJIe/f59X3rwXH9iGtLItKuO2W0F9jXHYYM=;
 b=TxrBI8YqfqYawC9h1yqGM3W1gbItqDlMcIf7UOhO60WBxgn27HlsLKtYMVhXqV1sIhaSWzRyjbufxO7oH5TXT0RMtn9k+4G93HpXFKEepB9okKfYj7P3YXmqn3Krf9rSBWuJhpWI0LJ6wXSpkw6nNFNkk8EaK2okRPVXJPFQ6rLJLhGfMjcffbreM0EOJj8AMTRRcg7SeVeghxwfizW6xPJjMdVnUpSulwh66WH2XvrjTPVxlA5ojzoi35q1cZTb8iSYalVd/Bv43LmPfCPAJf4a+PjXHcg9wnCeAJJ+Qy0NB81609YtPUbeMW7fsKu/5rJ6eQYm2fkyfI9dzPE7JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSA3xb9akJIe/f59X3rwXH9iGtLItKuO2W0F9jXHYYM=;
 b=1xqxJ0DKqT0i57GA/B/nZcT5L8lMTnFdRCPBo/iFYghx9Lv7D51Z/Kp+PyAXr7+JLg9g48iiS91vQW87KG3fBcakb768YLdnrY2HNzaxKfRx6+DrvUQ3dwsVZCjL495L27/KPUs3QMgfGQjuuGI4/w9wGCBQwfj+4+Bpa8vlkZE=
Received: from BN6PR1201CA0012.namprd12.prod.outlook.com
 (2603:10b6:405:4c::22) by DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Wed, 25 Aug
 2021 18:18:33 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4c:cafe::23) by BN6PR1201CA0012.outlook.office365.com
 (2603:10b6:405:4c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Wed, 25 Aug 2021 18:18:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Wed, 25 Aug 2021 18:18:32 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 25 Aug
 2021 13:18:31 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Luben Tuikov <luben.tuikov@amd.com>, John Clements
 <john.clements@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <Alexander.Deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Fixes to returning VBIOS RAS EEPROM address
Date: Wed, 25 Aug 2021 14:18:11 -0400
Message-ID: <20210825181812.4359-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91482fe0-eca7-4f90-2241-08d967f4bf25
X-MS-TrafficTypeDiagnostic: DM6PR12MB2778:
X-Microsoft-Antispam-PRVS: <DM6PR12MB27785C1E216FDD12820899A899C69@DM6PR12MB2778.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /VSKHk1DZf/uswXnbUbzDqGTr1i6O8P56hRDCJli3cm3BcYtI8wDvDLCLMsIaJnoEd4qLg+vW+CZdb/ty1qf6CZTiToMHTulmLZQcnT2ZyFNTro7z8WcEyLZvpk3bq/f9HqDhmUX8mmq/h9SmeffkmKAFW9Oc+/kJIH8LUAxMO8b8lGUUB2tObOwEcHxm7YS1YS5DwpOzCqQ2YRE82FGhyCpkjGSBo452WCpQPp4ZXl0STYQCkC/EFlyp2sA2W8ITH4kL3KJQM4F6Xjrr9HAm3qxzH9Gz34owU9gj7TH9hWagyW0vXLXHpWi0h/XqID3DU7TK6kyqcZyzKpT2ygFg28jVEXk2ZPRZKo6K6niJuONNuBIoXa67JBfguVj7em9RZWMyXj0FXpBZ/K4kwuRewORnOydD90vXiuxlHy3Lkyb/5kbnfFhmqzG9nKnQTvjMlSb9Ko6QJ00n72dJBJly+d5naJrGxOcf0kOySAFiZ5fyg6GXYU0i8UO4f4/GzZ6+rR05vORrlesoHS2kXCsSyKH0wqgDh+MUFRPAMHWxR1zis568qzg96FOieaZOXJbxPcSxLOWMwU9W74hGwcewDvCuY3wwybC9lXw+WlmO4FsjQWEbn9VqAEbVyPViPSegafXOb/SSX78PmyBVdp4VjDnwVc9ebg1MuwF0k15x8zdpaK0IquTBErMSlCLnIz7pHO/ZGR6+Ry0O+HkVaK4nbh1t2SWUhlsNpNq+H28MnE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(36840700001)(46966006)(47076005)(7696005)(44832011)(2906002)(36756003)(6666004)(86362001)(186003)(4326008)(8676002)(82310400003)(26005)(83380400001)(336012)(70206006)(36860700001)(426003)(5660300002)(2616005)(8936002)(16526019)(478600001)(316002)(6916009)(1076003)(70586007)(81166007)(356005)(54906003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 18:18:32.5759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91482fe0-eca7-4f90-2241-08d967f4bf25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2778
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

1) Generalize the function--if the user didn't set
   i2c_address, still return true/false to indicate
   whether VBIOS contains the RAS EEPROM address.
   This function shouldn't evaluate whether the use
   set the i2c_address pointer or not.

2) Don't touch the caller's i2c_address, unless
   you have to--this function shouldn't have side
   effects.

3) Correctly set the function comment as a
   kernel-doc comment.

Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 50 ++++++++++++-------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 8f53837d4d3ee8..97178b307ed6f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -468,14 +468,18 @@ bool amdgpu_atomfirmware_dynamic_boot_config_supported(struct amdgpu_device *ade
 	return (fw_cap & ATOM_FIRMWARE_CAP_DYNAMIC_BOOT_CFG_ENABLE) ? true : false;
 }
 
-/*
- * Helper function to query RAS EEPROM address
- *
- * @adev: amdgpu_device pointer
+/**
+ * amdgpu_atomfirmware_ras_rom_addr -- Get the RAS EEPROM addr from VBIOS
+ * adev: amdgpu_device pointer
+ * i2c_address: pointer to u8; if not NULL, will contain
+ *    the RAS EEPROM address if the function returns true
  *
- * Return true if vbios supports ras rom address reporting
+ * Return true if VBIOS supports RAS EEPROM address reporting,
+ * else return false. If true and @i2c_address is not NULL,
+ * will contain the RAS ROM address.
  */
-bool amdgpu_atomfirmware_ras_rom_addr(struct amdgpu_device *adev, uint8_t* i2c_address)
+bool amdgpu_atomfirmware_ras_rom_addr(struct amdgpu_device *adev,
+				      u8 *i2c_address)
 {
 	struct amdgpu_mode_info *mode_info = &adev->mode_info;
 	int index;
@@ -483,27 +487,39 @@ bool amdgpu_atomfirmware_ras_rom_addr(struct amdgpu_device *adev, uint8_t* i2c_a
 	union firmware_info *firmware_info;
 	u8 frev, crev;
 
-	if (i2c_address == NULL)
-		return false;
-
-	*i2c_address = 0;
-
 	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
-			firmwareinfo);
+					    firmwareinfo);
 
 	if (amdgpu_atom_parse_data_header(adev->mode_info.atom_context,
-				index, &size, &frev, &crev, &data_offset)) {
+					  index, &size, &frev, &crev,
+					  &data_offset)) {
 		/* support firmware_info 3.4 + */
 		if ((frev == 3 && crev >=4) || (frev > 3)) {
 			firmware_info = (union firmware_info *)
 				(mode_info->atom_context->bios + data_offset);
-			*i2c_address = firmware_info->v34.ras_rom_i2c_slave_addr;
+			/* The ras_rom_i2c_slave_addr should ideally
+			 * be a 19-bit EEPROM address, which would be
+			 * used as is by the driver; see top of
+			 * amdgpu_eeprom.c.
+			 *
+			 * When this is the case, 0 is of course a
+			 * valid RAS EEPROM address, in which case,
+			 * we'll drop the first "if (firm...)" and only
+			 * leave the check for the pointer.
+			 *
+			 * The reason this works right now is because
+			 * ras_rom_i2c_slave_addr contains the EEPROM
+			 * device type qualifier 1010b in the top 4
+			 * bits.
+			 */
+			if (firmware_info->v34.ras_rom_i2c_slave_addr) {
+				if (i2c_address)
+					*i2c_address = firmware_info->v34.ras_rom_i2c_slave_addr;
+				return true;
+			}
 		}
 	}
 
-	if (*i2c_address != 0)
-		return true;
-
 	return false;
 }
 
-- 
2.32.0

