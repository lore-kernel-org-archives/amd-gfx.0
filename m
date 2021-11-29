Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0F5C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Nov 2021 05:56:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 577286E3CE;
	Mon, 29 Nov 2021 05:56:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F4CE6E3CE
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Nov 2021 05:56:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcnIyrk+IjeLO05pd4CHiQu2jJj9mSvRxfF/ujOHoUBsEBgKjYYvQtNQGTm4HQSgRYbbk7rot9fYvAaOBEJLMTwA6gA4zazFnzdCa+FF10W+pO10Po/nP3G4TMgQChu00GAvKUGRA+wCilgcTtBtNz+Pl47V8YYNlMxFRdHaJq63gWa/JKGjkz3t6jzJhaFVV6Zk1VIV9zcOn9K/vfcJVKcxpFBnmRyl2VQaEmZAP3+F7KJyEsn6zn2kirEwWmRyjKrTuBM6Ed5a9Gis46NPVYAeiuoxgYIBmoL8tZIEVVsw/eR7NgmQ8Ps9KmzIC9k241XWyyhuflSxlU1UHt7hsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0i+MzOXI4FU1/NSBfM0ssODzVzTDNPKYvcARtY+vd0=;
 b=YtS7wY3V2znscRNwIhQDiQsWVqlsSNxzeAuclTddbGb8P8+ACghs/uICRbdqyuiKJDoLOD/GWLKY3yrskoLecAxbJW5tLqSEBpablkHcCHTmxJRvKJaGrcdU/aizBL+1lnHxyF/YMBIzJaBPYwxHnozqW6hHsD5xwURN181cmDJmKNIKTXOTaDcTdVOxJhwfAMbsnTOXNRgG706AALAqfx99UNe5V+lYIszi/p3vdVcVacMZ6YHRz2GqFzfnLbCpMJxPCJ/ik4nmKZJFHfdXhTtYGfPlR/a+usjUWTpaNjx2mOOp0Id11tyU80HDu4BZlVAyla4jOOQuS4rtWumm1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0i+MzOXI4FU1/NSBfM0ssODzVzTDNPKYvcARtY+vd0=;
 b=JBB8ZTXO1OEtrNvpqCytqxTEdFy/Oe9rie0i9fMjNKZXY44Bkt5Uq/dbPjOWTaGPrg1kMm5Fmw0f9IjKAkyj+z9oiTkMBZc7QjHLz9I5Q3oZKvmPv9Nnz/n52rEKpOKQLVcAgH1v7JmCfPM1leuvcB4S10Kki/SoQrd7iHKKl7g=
Received: from DM6PR17CA0007.namprd17.prod.outlook.com (2603:10b6:5:1b3::20)
 by MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Mon, 29 Nov
 2021 05:56:32 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::78) by DM6PR17CA0007.outlook.office365.com
 (2603:10b6:5:1b3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Mon, 29 Nov 2021 05:56:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 05:56:31 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 28 Nov
 2021 23:56:30 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 28 Nov
 2021 21:56:30 -0800
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Sun, 28 Nov 2021 23:56:29 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <John.Clements@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: adjust ip block suspend sequence on
 aldebaran to fix disable smu feature failure
Date: Mon, 29 Nov 2021 13:56:27 +0800
Message-ID: <20211129055627.7886-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 083237a7-0f85-4cb0-fae5-08d9b2fcfe47
X-MS-TrafficTypeDiagnostic: MN2PR12MB3309:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3309CF5DCF0E6BB5D97F2BDE9A669@MN2PR12MB3309.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:46;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PBUNohF2Ut4oD4VOGGm8N+JtV6lSKj9yDGbuPVfBA5JEwEknePlyC9FCNEKKzZZ/x4LE8KrUoufC5AeTnCPuqMzutJnEUXiDeqJUhjAUrU0WjaOOw1Ge4/Uklenk2WQ/MaJmC1E8SR5fL2ND+4JnewIZ7upFzQePUTp79+/kNXg6az7Be+D7XAFEnCpvstvCCRXdA1bomzqR07Nco9IcerPN3M4bMoXQGagUf1WxJwXpl0wz32XNwQsp0KNndAFNLfpLzWmVX3LBoWIaozw8wUedJ3I5L8vcUvPUdbW8kZqjTvnJuRdCqz9wZox4bSRCqbo6gxjZcRSWRgizHWlnBgmmCMuaMrZjhWrhelW5W7s8bN71CAAK6INfrS0k3EjqDaf+ghaojXRjvJC8RX2edSTUnthLd/tuxg05HlgKL4DNTT1AuY/5XapGMsMcBKzV6am5S+UYksa2FINkhvUOeDxERmUitNl7G/Q7vYBCFJWS1DnMqvENDkGgio4i2xGrbU4Qx0/cDT5hj8m3g6l5IIDrrpblYa1qsGCtIrpD4/DlJjzLgbf3BAcGbpzUf85JTKVXicykqFtNjPZSiLqEjtN+oHcql10p0+e7Tld7imn0UvOa89CNDuR4HJOX1GnXvywe/r7kdCCn0+8Vc/Ayzibui7wwBavWo5m37LXh6t5QGsX8DofOmbwPOMV+2HnTSkwouI0y/BY4wn1f/VcAohdqlBR1hXyt/hKShfijLe4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(86362001)(316002)(4326008)(186003)(47076005)(2906002)(82310400004)(36860700001)(2616005)(356005)(110136005)(5660300002)(8676002)(15650500001)(8936002)(70206006)(426003)(36756003)(70586007)(508600001)(81166007)(336012)(26005)(7696005)(6636002)(83380400001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 05:56:31.6199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 083237a7-0f85-4cb0-fae5-08d9b2fcfe47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3309
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

{
    [  578.019986] amdgpu 0000:23:00.0: amdgpu: GPU reset begin!
    [  583.245566] amdgpu 0000:23:00.0: amdgpu: Failed to disable smu features.
    [  583.245621] amdgpu 0000:23:00.0: amdgpu: Fail to disable dpm features!
    [  583.245639] [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of IP block <smu> failed -62
    [  583.248504] [drm] free PSP TMR buffer
}

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 4e3669407518..364808f3607f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1309,10 +1309,13 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		}
 	}
 
-	if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
-		r = amdgpu_discovery_set_smu_ip_blocks(adev);
-		if (r)
-			return r;
+	/* move add smu block after add smda block for aldebaran */
+	if (adev->ip_versions[MP1_HWIP][0] != IP_VERSION(13, 0 ,2)) {
+		if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
+			r = amdgpu_discovery_set_smu_ip_blocks(adev);
+			if (r)
+				return r;
+		}
 	}
 
 	r = amdgpu_discovery_set_display_ip_blocks(adev);
@@ -1327,6 +1330,14 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0 ,2)) {
+		if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
+			r = amdgpu_discovery_set_smu_ip_blocks(adev);
+			if (r)
+				return r;
+		}
+	}
+
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
 	    !amdgpu_sriov_vf(adev)) {
 		r = amdgpu_discovery_set_smu_ip_blocks(adev);
-- 
2.17.1

