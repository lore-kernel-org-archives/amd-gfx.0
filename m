Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03836C3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 19:07:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EB1810E30A;
	Mon, 15 Jan 2024 19:07:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50B9A10E30A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 19:07:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZKl5fgec0FniwbSaB87uxFJaP88nlf5i/HyNHZrBHXCMH/4xOzC9C0/vNXz/i+OR/HoUkU+4mnkhL35V/uaQeAMHAkigeRlHZi1/QM6eyEl9A0VOpe8vHaDRZeVorUvFvxAUOVLk7XNKTdeZtb97pnbL4B6C/IUX8HZ4uB4tV4HDY+iWgGmWLeNtwwr5xyRc9zQbYZEtvn4aCg06PmuG2920swQC6JYVe1TKJg/l7ze/OENr/DZXHn0NTNy/3Wg7zgI2skwWjmQnKGMTdqbVm2BwJS1nDNmPB24f0il+cADVW3VlhTSzTgVLpM2vmZKDjUOHgOjxZDCNbGguMLXjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWS50BzVKlcsWxYc6GFjPKdOV1S6cKwr3/uXvua6JXw=;
 b=O7i+sMBQ3Y/rIgx/AvjL3ES7jffx5j7e2UydNQ32HR048NHr1wWpkGEw/H49vwO/vG83ybYXlYsMtpQTBFk9bazjgWsoRRWtgI9XR4hsYqXmlBqIVUrPQJ8+3sCp08piaXudeLcV+cV/98yT+HglA3s634LZ6zwOtvTUzijnj2CzecN6ijI3+gC6q24VJIJTBsgrNZDaIPnoezaRPV8reRHKcpq+UmHH/HQVhzoiF4/RasIFRTKvbzA/+RevfYcoaPXOJhpWxTn9ZJlf+OmPLY19f0DdHwWrn1Q8ASITXnPTirX5897N1cSK37997sXwa2Ka4iWtrBECUImYEJYZgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWS50BzVKlcsWxYc6GFjPKdOV1S6cKwr3/uXvua6JXw=;
 b=StSFPee2bVeYFg1PKL/Uo7Kn6oi1ieE8/M4vEwhudntRP3EYZJTJL2KplCSpBFITMyNFkApyjghqHjjR2LTEC9XQwoSvuKKFKOg6fhb4ah8s09AS7oxB/g8ID1MSAfloBt9rxMaKqKpnNNOnOs683YLZvVyvH/UEUIX8TPvkKCU=
Received: from CY5PR15CA0227.namprd15.prod.outlook.com (2603:10b6:930:88::25)
 by PH7PR12MB6884.namprd12.prod.outlook.com (2603:10b6:510:1ba::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Mon, 15 Jan
 2024 19:07:52 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:88:cafe::1a) by CY5PR15CA0227.outlook.office365.com
 (2603:10b6:930:88::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26 via Frontend
 Transport; Mon, 15 Jan 2024 19:07:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Mon, 15 Jan 2024 19:07:52 +0000
Received: from jc-d.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 15 Jan
 2024 13:07:51 -0600
From: Jay Cornwall <jay.cornwall@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Use S_ENDPGM_SAVED in trap handler
Date: Mon, 15 Jan 2024 13:07:33 -0600
Message-ID: <20240115190733.1483942-1-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|PH7PR12MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: f933f8cc-414b-4cee-2bd3-08dc15fd45c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G+5sXoEO6WMWdho2DFAU7M0TVxjD412/sdEnCJ3juHkH/TtY17/7ZLcQ6LEEFLTTM7jzh/8HBE69zJoOameOGa4ts+u9f2TyRL5T1htgn60udK4iNPQuehzkjW7ll27P63uh786Kew6lypYUFQ+qSJrS0CoLtUj1mb5g2e6HZSJbeOAdKGXhKF06HQq2aSCocEnQJjqn6opRitwdFkerlANzoQQqbSO4jmoTMqyjubP6FF862Ddxr9fqr9hSHaYyWOLIxiVKEV4CFk9ddg7n0/AHcyl+gSbT+yPR69GuYD9eDmBwwHHJZegEfbijCRXIsULAVOzxc8noHAth3h5hpNaTZtv46g0j6MNxhuDA8QiagUPCSD2EfnV08MUsj7uEUi9XC8PJ+Dve0BcBB2Fm6D0KndV9tJfN4bboLqReAS3kFIif9POiZE74fVZgqWDmiSmIaKM7oYfwtcns84vVpNvCM192TSybTKYfZKVhwZnk+GUEdX3T0Bre0dTrF+7Q4O+9mlsH6Eh5R2hpyhbkCicrz8zuGCSjCRtNBmnFn1YWIjggx5R1di1LuFt9ngtm9ofTdKdiKCqB4ieFoZ/0p0lW+pIokwm42pG6lIV1A/bhpaTLCtA+x5cclF/67vJdlUqaUnh98ZC0VzseC0wVLGefQCc2kR5lXu3Yyt3BkJIoPhB/4b7IrexElLEAu3XgdRAySywkmMfOaQVP+xIwG9vbkrQZ5nD9hyt1iybAQ02/dEMwnvjKDG3/dAMX6/KcUsz1Yk7+1UsuxtxaZGEY5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(83380400001)(426003)(336012)(36756003)(26005)(41300700001)(82740400003)(356005)(86362001)(70586007)(47076005)(16526019)(70206006)(81166007)(316002)(2616005)(1076003)(5660300002)(7696005)(4326008)(6666004)(36860700001)(6916009)(8676002)(44832011)(8936002)(2906002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 19:07:52.0354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f933f8cc-414b-4cee-2bd3-08dc15fd45c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884
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
Cc: Jay Cornwall <jay.cornwall@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This instruction has no functional difference to S_ENDPGM
but allows performance counters to track save events correctly.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h     | 14 +++++++-------
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm |  2 +-
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm  |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index df75863393fc..d1caaf0e6a7c 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -674,7 +674,7 @@ static const uint32_t cwsr_trap_gfx9_hex[] = {
 	0x86ea6a6a, 0x8f6e837a,
 	0xb96ee0c2, 0xbf800002,
 	0xb97a0002, 0xbf8a0000,
-	0xbe801f6c, 0xbf810000,
+	0xbe801f6c, 0xbf9b0000,
 };
 
 static const uint32_t cwsr_trap_nv1x_hex[] = {
@@ -1091,7 +1091,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0xb9eef807, 0x876dff6d,
 	0x0000ffff, 0x87fe7e7e,
 	0x87ea6a6a, 0xb9faf802,
-	0xbe80226c, 0xbf810000,
+	0xbe80226c, 0xbf9b0000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0x00000000,
@@ -1574,7 +1574,7 @@ static const uint32_t cwsr_trap_arcturus_hex[] = {
 	0x86ea6a6a, 0x8f6e837a,
 	0xb96ee0c2, 0xbf800002,
 	0xb97a0002, 0xbf8a0000,
-	0xbe801f6c, 0xbf810000,
+	0xbe801f6c, 0xbf9b0000,
 };
 
 static const uint32_t cwsr_trap_aldebaran_hex[] = {
@@ -2065,7 +2065,7 @@ static const uint32_t cwsr_trap_aldebaran_hex[] = {
 	0x86ea6a6a, 0x8f6e837a,
 	0xb96ee0c2, 0xbf800002,
 	0xb97a0002, 0xbf8a0000,
-	0xbe801f6c, 0xbf810000,
+	0xbe801f6c, 0xbf9b0000,
 };
 
 static const uint32_t cwsr_trap_gfx10_hex[] = {
@@ -2500,7 +2500,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0x876dff6d, 0x0000ffff,
 	0x87fe7e7e, 0x87ea6a6a,
 	0xb9faf802, 0xbe80226c,
-	0xbf810000, 0xbf9f0000,
+	0xbf9b0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
 };
@@ -2944,7 +2944,7 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
 	0xb8eef802, 0xbf0d866e,
 	0xbfa20002, 0xb97af802,
 	0xbe80486c, 0xb97af802,
-	0xbe804a6c, 0xbfb00000,
+	0xbe804a6c, 0xbfb10000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0x00000000,
@@ -3436,5 +3436,5 @@ static const uint32_t cwsr_trap_gfx9_4_3_hex[] = {
 	0x86ea6a6a, 0x8f6e837a,
 	0xb96ee0c2, 0xbf800002,
 	0xb97a0002, 0xbf8a0000,
-	0xbe801f6c, 0xbf810000,
+	0xbe801f6c, 0xbf9b0000,
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
index e0140df0b0ec..71b3dc0c7363 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
@@ -1104,7 +1104,7 @@ L_RETURN_WITHOUT_PRIV:
 	s_rfe_b64	s_restore_pc_lo						//Return to the main shader program and resume execution
 
 L_END_PGM:
-	s_endpgm
+	s_endpgm_saved
 end
 
 function write_hwreg_to_mem(s, s_rsrc, s_mem_offset)
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
index e506411ad28a..bb26338204f4 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
@@ -921,7 +921,7 @@ L_RESTORE:
 /*			the END						  */
 /**************************************************************************/
 L_END_PGM:
-    s_endpgm
+    s_endpgm_saved
 
 end
 
-- 
2.25.1

