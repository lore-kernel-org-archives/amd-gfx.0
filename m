Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFCCC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 01:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E7FA10E1B3;
	Fri,  4 Feb 2022 01:08:43 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2070.outbound.protection.outlook.com [40.107.212.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01F1310E1AF
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 01:08:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V89vghMqupvYVTPMdrwWU1aQu98SXtnszWVU6MEKEzGpuAM1nAy79Qz0S4Rz8CiqR0dTcOVdx0lNKD+n09SfvkgUmVe+w+NtMYV2NvE5jG04LfYDaWONAAtebyHGmSPqd/LFUhXOWfixzsz2YmcykOpETaHBEeMhv2Umus1Z/yWWe1GDNxTzoZ7tPUR/VtrjMVLjxmcZiEpmSqvFGcpnSwL9Jl3nlupoo220CCMnt7ux7fwgNeTrUHxnFsfv+opd2MLr3N5UREIEOtOXZBlgLoqGjKD1wEMkix3TbpvNNvBpoPDo5z5XyoUEyBX2BTUw1fZ91BH0jgdhOeeu15432A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2zZ8MqgFwyRJvmk7ongC58oubZw8F1QFVoirntXGsg=;
 b=fpbISAJXZJptMEQa/CpQa9iIewDNu/eYwHCm1xFRUal9pgM8FGP1ctrWqMUCb+gS7TJaTJr6+2KPaH5X54xsRPWvW/tpMH8hiMcvMyHuogRvLKJTf1vHLC8kQlcpjqLSzsJx2aFmSAbhyafhBaTb9rqXMGGi7NScA/y9oWYZpFYhCSrn7P7x8i5LjqNBs+msoWXI1wOFOPa9GLIbNQDzhcyQfXLCv6MpPmvMut8w1mYoG8CqcMGxtxKrQaW3NYUbLSW0FkJCMIfbSG3ScMSri4F7zP9y7ao5fjlbna3rU888Jt0SHHdlLNrgIgdrYrGk8o9JhmEyzYlFnVpUcKYAmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2zZ8MqgFwyRJvmk7ongC58oubZw8F1QFVoirntXGsg=;
 b=XmfKMs9ID5/55SAkR0o/4Go4VTvRrfvBBpZN+5CkDVBUki5g55LY/EF5F6WI5riCKCAAdVGyFjUhPHvjjXPklIlHl/Mv9PgyyT4hXo2YBkzqNAEFPdLtB5xJ8JUsKPaMQG45bSNsuNeWN0gYzR0xs2PJ/NOGv94t7rMV2ZFeUqw=
Received: from DM3PR11CA0001.namprd11.prod.outlook.com (2603:10b6:0:54::11) by
 DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Fri, 4 Feb 2022 01:08:35 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::7f) by DM3PR11CA0001.outlook.office365.com
 (2603:10b6:0:54::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 01:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 01:08:35 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 3 Feb 2022 19:08:34 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: Nerf "buff" to "buf"
Date: Thu, 3 Feb 2022 20:08:19 -0500
Message-ID: <20220204010820.250829-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.0.3.gb23dac905b
In-Reply-To: <20220204010820.250829-1-luben.tuikov@amd.com>
References: <20220204010820.250829-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e52582f-179d-4eab-2f02-08d9e77ade6f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3163:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB31635A5711BF3B9D9B58686099299@DM6PR12MB3163.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wk+oYC4bCD6sNf1QjXmcW2EUno6tPVZ5MV9ljRcL/oBytKWEVIU+qHfEVDFwFTs8lP2uRMLompATotFtHDwf0O9BifqvQ0e3IJjKGf07o5hsTBsfeyvyWLreA1MJkHotkKigduOELI9Ow6NujOzfMDtlNkYL9LYQmL9S9VL8othbsbRKvR+5dm9t6IBIKVkcELHxB9ATdeOclvVTvlBhTlKurSleZP21W7AZzUDH7sQ0Cz31chS3Zb5gKCOc77O+KuiIJEDBs5UA7/SO0fI4aGiYUGBLZFBOChR/WC4mB6x4qjo9INnLzsM6QIGq9BUWG2k+7N8gEMfLXGGbKFt2Rw2L7sOvvln6JqAxaezEW6rfIRk+CdcUnmYy8GadNissDdGfRYSnYIJYtcKiV3YVYCMJJa8EFkK11BxObWmFem19oDujdSWtW+c4DKA/DqgAtoiX75wD3D6d7muf+/5tceTnYbwOFK86nbhAJwDS5YQiBCFs4LjzSu/eJRuWetf13jowDGk4/G1UMCMsBZ+bwryo+ccIm3Rb9hQGHFW+NMnfF+nCVpuxMiF8VhrxyrTf/NeIySQvOj74fKyd/+/MYa+j1WGnxqt/PtAt/NFjIht/ice22oYRw83vlxBiQKcxN3+NK2cMMF671WSpKNPgJwkH6XsSoCjBBSLogHb0Zsb6HRD0vGQqXkqraH46VO0WsabIdTBkLaCyfT/0h9xpmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36756003)(16526019)(8676002)(336012)(44832011)(5660300002)(47076005)(2906002)(82310400004)(81166007)(8936002)(4326008)(70206006)(70586007)(426003)(2616005)(1076003)(26005)(356005)(6666004)(6916009)(186003)(7696005)(83380400001)(54906003)(36860700001)(86362001)(40460700003)(508600001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 01:08:35.2397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e52582f-179d-4eab-2f02-08d9e77ade6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3163
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Buffer is abbreviated "buf", not "buff", which
means something entirely different.

Cc: Kent Russell <kent.russell@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 32f38d0dd43dd9..e56d2c79b444bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -77,11 +77,11 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 }
 
 static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
-				  unsigned char *buff)
+				  unsigned char *buf)
 {
 	int ret, size;
 
-	ret = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addrptr, buff, 1);
+	ret = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addrptr, buf, 1);
 	if (ret < 1) {
 		DRM_WARN("FRU: Failed to get size field");
 		return ret;
@@ -90,9 +90,9 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
 	/* The size returned by the i2c requires subtraction of 0xC0 since the
 	 * size apparently always reports as 0xC0+actual size.
 	 */
-	size = buff[0] - I2C_PRODUCT_INFO_OFFSET;
+	size = buf[0] - I2C_PRODUCT_INFO_OFFSET;
 
-	ret = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addrptr + 1, buff, size);
+	ret = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addrptr + 1, buf, size);
 	if (ret < 1) {
 		DRM_WARN("FRU: Failed to get data field");
 		return ret;
@@ -129,7 +129,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	 * and the language field, so just start from 0xb, manufacturer size
 	 */
 	addrptr = FRU_EEPROM_MADDR + 0xb;
-	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
+	size = amdgpu_fru_read_eeprom(adev, addrptr, buf);
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU Manufacturer, ret:%d", size);
 		return -EINVAL;
@@ -139,7 +139,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	 * size field being 1 byte. This pattern continues below.
 	 */
 	addrptr += size + 1;
-	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
+	size = amdgpu_fru_read_eeprom(adev, addrptr, buf);
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU product name, ret:%d", size);
 		return -EINVAL;
@@ -156,7 +156,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	adev->product_name[len] = '\0';
 
 	addrptr += size + 1;
-	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
+	size = amdgpu_fru_read_eeprom(adev, addrptr, buf);
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU product number, ret:%d", size);
 		return -EINVAL;
@@ -170,11 +170,11 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 		DRM_WARN("FRU Product Number is larger than 16 characters. This is likely a mistake");
 		len = sizeof(adev->product_number) - 1;
 	}
-	memcpy(adev->product_number, buff, len);
+	memcpy(adev->product_number, buf, len);
 	adev->product_number[len] = '\0';
 
 	addrptr += size + 1;
-	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
+	size = amdgpu_fru_read_eeprom(adev, addrptr, buf);
 
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU product version, ret:%d", size);
@@ -182,7 +182,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	}
 
 	addrptr += size + 1;
-	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
+	size = amdgpu_fru_read_eeprom(adev, addrptr, buf);
 
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU serial number, ret:%d", size);
@@ -197,7 +197,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 		DRM_WARN("FRU Serial Number is larger than 16 characters. This is likely a mistake");
 		len = sizeof(adev->serial) - 1;
 	}
-	memcpy(adev->serial, &buff, len);
+	memcpy(adev->serial, &buf, len);
 	adev->serial[len] = '\0';
 
 	return 0;
-- 
2.35.0.3.gb23dac905b

