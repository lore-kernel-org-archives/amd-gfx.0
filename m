Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABB7C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 15:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9C66134F
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 15:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EA9C66134F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B4FE6E0C5;
	Tue, 19 Oct 2021 15:13:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FCD86E0C5
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 15:13:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1YC9QCjIHYrFHJDx2xP8RgFKsreFA7efvIe3OGv0+fjmjKxUWEuKgQpzBiZ4piLehJAdeZzwKyAb8+V79oxt6mZXVDzDzBbtcEx7Yu/jxmBd+IEek/jjAY9GZRRla+j2juP/F9onuFqa7WY6o7+HCMSyDzGpDDl1yhWhsJbVdYGZNztgklAp2j28GTxrweSPJ8OkfjKFUbaR3Ee62F2YB7maldadRZ69Tk6DBGmOuUSuo1BhG/6d1d7mR+mqasb3JZvEb/jCpFWTwZG5yefY9e18xrQj8UT4kyK1XA+IYgJF+75j/r0tmNLqIAWiOl0EhJB1qgszJwyL+mCbtE4RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbP7FkQVEXkS+b+ZVDCGrRTlOFgHzNM8W36ZFbpZef0=;
 b=hqVcFN6Mx88MJAfB1+gsv6gRJWypHgK2goEyncs2P7L6+lfo10VfZdgpLNdiLify+s+2FQ9B4Rd4D2Te9uvw8Ppv7l4VKBr4xSujets67vywLaLySb2a5QJ5aJMIsv1QYlUw7IM5cCoV4ZXhH/bRra2p95igllKTN5yj8wGqkGrMwRRcp9MnJQboos6NUivL3NBNQmtPgIElqDPO9VtThMbtH9IeqZ4/1XeEkajCbySMerQ044dlRX31Oktip9ckT6vh5gQQrxmXIdFNduSv0dPyL9X/jyhbyh2ATrS7jRvJBXtGmjsNZYSshl6r6VXQeodhkHqbxPSgb4wT88RPiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbP7FkQVEXkS+b+ZVDCGrRTlOFgHzNM8W36ZFbpZef0=;
 b=OgbCso4LzG4pJgI2caTJjiz2QItKXbIBp0KGIrvZ0jK66/+ApFsvMTneETal5m+gCZluYqv8g0dbIN4ptyJsMzY1oThD/weUN7DZg5KHGQxw06yAT8uk5JiKF7tNHcc5ay20g6JeDSHLzOfV8hep8AoON/Al6BI98jmB2B70bZo=
Received: from DM6PR11CA0046.namprd11.prod.outlook.com (2603:10b6:5:14c::23)
 by DM4PR12MB5118.namprd12.prod.outlook.com (2603:10b6:5:391::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 15:13:18 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::f6) by DM6PR11CA0046.outlook.office365.com
 (2603:10b6:5:14c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Tue, 19 Oct 2021 15:13:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 15:13:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 10:13:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/vcn3.0: handle harvesting in firmware setup
Date: Tue, 19 Oct 2021 11:13:03 -0400
Message-ID: <20211019151303.291103-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24ebf3b3-b966-4458-a221-08d99312fb5b
X-MS-TrafficTypeDiagnostic: DM4PR12MB5118:
X-Microsoft-Antispam-PRVS: <DM4PR12MB51189CD36A82CD30E74ACEDAF7BD9@DM4PR12MB5118.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uRZbfSihJWOHFq7Pq78CjY36Gj50EbfTtdJ3fhNCBT6PEl+2BPpco/hbZ20K1/6qZ5fKIe5ckzuaFXqMQ8rIdO70POzV8P80+29k14dgoL7dP7JU9X7NXySyRbgyVI/Egz+jroi+CjMuYLb/6mTnVP7uKouc/3/MPEPLd4VGZn8zWg6lR1rUCX4OQz74adDillD4S40lQPu/XttYOo7kOJrrwmXf+p03Y/19UXr6BRghn5a2Txdq89JM+YqNE5letuBNR0KUE30DMkS6loCes/AGvO87tmSEKO6gBo14EUejRZN54EWq0zcsC2wD8Lo9LmLy9o0SZ8ynV+bQWRd/ph318tzyfxJGNy4k+eqGFpesDUHGniTjckP/KQ5gWMiz4y97yHOpyZsyqsxNRWduXodHrw9MzTgLIIO/kUXIcRA36rbQ60mbcWRHx4TZegcJf6oaarj6Zywa8+HssAipdVvN9hUbtm2O2Mwx+F5e0cfVybl2Sbak7O1lVJNUxvrbaVq3J/K2C4nFoRC72eqFQRaZRSr/XQnP2cHtmtvxdiEXq1d2gdTMZaYruOmeHLopxJKI+WCuImJVKDV7kjdPYmwVo5+2L1Asj0xdI5EMWE8v38Dta3bpU4ECJzoIuxdEu+Z3eTtr8ekjW3aiyDLbsn4DU3wxf9sUtMrxOZqwCXhwelBM5KpYasHowCriOULiofhJk6bwhbO8v6dMx9WFoW7k/C5P148yYsTM98ACEUQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(316002)(26005)(5660300002)(83380400001)(36756003)(6666004)(2616005)(81166007)(8936002)(4326008)(426003)(186003)(508600001)(2906002)(82310400003)(7696005)(8676002)(36860700001)(70206006)(70586007)(86362001)(6916009)(47076005)(16526019)(1076003)(336012)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 15:13:18.4677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ebf3b3-b966-4458-a221-08d99312fb5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5118
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

Only enable firmware for the instance that is enabled.

Fixes: 1b592d00b4ac83 ("drm/amdgpu/vcn: remove manual instance setting")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index dbfd92984655..e311303a5e01 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -123,6 +123,7 @@ static int vcn_v3_0_sw_init(void *handle)
 {
 	struct amdgpu_ring *ring;
 	int i, j, r;
+	unsigned int idx;
 	int vcn_doorbell_index = 0;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
@@ -133,14 +134,16 @@ static int vcn_v3_0_sw_init(void *handle)
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		const struct common_firmware_header *hdr;
 		hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
-		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].ucode_id = AMDGPU_UCODE_ID_VCN;
-		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev->vcn.fw;
-		adev->firmware.fw_size +=
-			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
-
-		if (adev->vcn.num_vcn_inst == VCN_INSTANCES_SIENNA_CICHLID) {
-			adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].ucode_id = AMDGPU_UCODE_ID_VCN1;
-			adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].fw = adev->vcn.fw;
+
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+			if (adev->vcn.harvest_config & (1 << i))
+				continue;
+			if (i == 0)
+				idx = AMDGPU_UCODE_ID_VCN;
+			else
+				idx = AMDGPU_UCODE_ID_VCN1;
+			adev->firmware.ucode[idx].ucode_id = idx;
+			adev->firmware.ucode[idx].fw = adev->vcn.fw;
 			adev->firmware.fw_size +=
 				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
 		}
-- 
2.31.1

