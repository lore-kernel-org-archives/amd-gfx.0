Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413F9EB64DD
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 05:18:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6BAD10E64D;
	Fri, 11 Aug 2023 05:18:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32D6710E64C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 05:18:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOcr43tQNhJ3II6lyFtRMHz9rCtXylv4cS/NxnJnSxJWDbuYH6RTSbcoUgRnp4rI1mpyKzQDilWHw6BLl9tqbDhZub4TjN2IWBf1RbMjj4UJh3JdXNV+l5sn8F98AJOmZfuae9n47cHPPNQI3TnytnugJVFdLPzADm9rrap5V3uqSB+6g/E24EZNaSE1a5G3HjR4ZvThvoZgKJRpbzWTWuvrbjzy3KgBUF4f8wZ8bIJETSqnDqeMzd60hqIqmmfkwjuP4gis2Q/Wkt2u+taggGVkJafAqX8CTCt0n2B3o9b/UEqYn4CP61NuWuQwOKO6NbhAwiuCFWKwXPin8cigJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csICt14PtnaX4BUihmE1hA8tv4WIrzNimaTFWh4qS48=;
 b=PfyX5QPKmt54DMpAcm4j0eqfkBjaxIq3ti8WugpKBwR4OyF+3a+Spi3lS+Tn7a/wysCJMLuCPKgHkiyyZff5Y/SzwCwfaGCLeEvMsOa0N0sOYAP4g+xlV3sdy9+ooyisoSn1Xdji5CGXZx9c7B65G7G6EtcQBu/vhoRN46f3itw4Vp5UhNy4Xp9syfGgFjw2foOm1YzFKqGImyOtDNyFKNvi86huigfWsx4RFlhvWMtMfYnVcH/mwf7x2zc2XAbXGj7D0U9Edr7zq8T1VUdB1Lc864vt4wBJRUcLkveX1UNhRTJ4EZDLdS+aDC1FjQblVf9q1EyOl0+iCjY4UM2X1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csICt14PtnaX4BUihmE1hA8tv4WIrzNimaTFWh4qS48=;
 b=HsbP9rcY+N9KWAcyP+IzXjTBBP3ykInMZXeq194sku72q84uAWLbA7EUrak/MSp4ePOXN4o7LFAxrbpCaiCfhWqVSo48VOpJwhV0ZnyhnQWaUGMdklFm/MpyqQEzedsl1x4tZTBsxL77pTL8nhTjinXw3zZqjPc3Z9z4q+YQCyg=
Received: from MW4P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::24)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 05:18:49 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:80:cafe::c6) by MW4P223CA0019.outlook.office365.com
 (2603:10b6:303:80::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Fri, 11 Aug 2023 05:18:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Fri, 11 Aug 2023 05:18:49 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 00:18:46 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: Add bootloader wait for PSP v13
Date: Fri, 11 Aug 2023 10:47:55 +0530
Message-ID: <20230811051756.653422-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811051756.653422-1-lijo.lazar@amd.com>
References: <20230811051756.653422-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|DM6PR12MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c42c50a-bacd-4a4a-cd06-08db9a2a7222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8djbTXWqDRGnG0znrkmsQto+A/7CUhjd1R3kAffa86bCS4W8ynvGxqgvRBgV46fgzVG6gnjo+CYFN6XJC6HVu5/4e1xmHJGrZq+JOxPm383aKIpUxoIV9EghAn5mYkh+nItvU5HGPTgitpLu96bfaDatUfTnfa2yVb00mEqoIvJ4Q/3n04mTZEBorovb+b10gMnA+H08exjwWQtnhGF+GJQOQD1jZPqOjSRssz4KbxllXdX0K1WuTsDeSnttAWxZky3R3ZZDefhbBGZmlSsLE5Ehm257kyukPtofjzVLWhEVe8Wi4r985KScT0mSQZzBWnjTlxThtSNmdG+DlIIaErqCjh93WYKVfqd64x+gUgHNnWcaWsnH1xsIW01kLYNLARYRbThJmECZ+r9mHNTh9jsDOUbA7KmMFExqwQc6DimpFyM1Ca9P7k+R8WyVh5bpfMJFaOdwoLt34GqxAMtCVE6DFIILosYHN6gmD0Ra1pfnMlriOlfXbm9KvsbvPJKFSWKXuBXhhTBvwk1btAhdwpkAvRFHugTIVUCApjqjDH/T+76ECzRxPTDTdFqQTuqaQgBAnqLNzBHj9fY5YWt1XI6M3q4Oyi+V6iR+ei3+Q8CxhAzQLY4T8mgQXAXeC7Dn5WG5TB0HKdMtrDnUdGCE/40Gv5qxkjrp3SB9Oyvep+Jf2LXC6/UmXnZ23LZbIdNtkRiP7MnfoDcWYdDmHBGRvl+VmQDGZKQwP9KsWkIAU7MNlXSbbDuwtHBvC+fLkBtB5Tz1ggd72b6GRskAuj7viw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(1800799006)(82310400008)(186006)(451199021)(40470700004)(46966006)(36840700001)(6916009)(4326008)(70586007)(70206006)(41300700001)(316002)(36860700001)(54906003)(336012)(26005)(83380400001)(47076005)(2616005)(426003)(1076003)(16526019)(40480700001)(86362001)(81166007)(356005)(82740400003)(40460700003)(7696005)(6666004)(36756003)(478600001)(2906002)(8676002)(8936002)(5660300002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 05:18:49.5838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c42c50a-bacd-4a4a-cd06-08db9a2a7222
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, Asad Kamal <asad.kamal@amd.com>,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Implement the wait for bootloader call back for PSP v13.0 ASICs. Only
for ASICs with PSP v13.0.6, it needs an additional check for VBIOS
mailbox status.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Tested-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 28 ++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 10b17bd5aebe..d2a88bc630d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -133,12 +133,35 @@ static bool psp_v13_0_is_sos_alive(struct psp_context *psp)
 	return sol_reg != 0x0;
 }
 
+static int psp_v13_0_wait_for_vmbx_ready(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+	int retry_loop, ret;
+
+	for (retry_loop = 0; retry_loop < 70; retry_loop++) {
+		/* Wait for bootloader to signify that is
+		   ready having bit 31 of C2PMSG_33 set to 1 */
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_33),
+			0x80000000, 0xffffffff, false);
+
+		if (ret == 0)
+			break;
+	}
+
+	if (ret)
+		dev_warn(adev->dev, "Bootloader wait timed out");
+
+	return ret;
+}
+
 static int psp_v13_0_wait_for_bootloader(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
+	int retry_loop, ret;
 
-	int ret;
-	int retry_loop;
+	if (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(13, 0, 6))
+		psp_v13_0_wait_for_vmbx_ready(psp);
 
 	/* Wait for bootloader to signify that it is ready having bit 31 of
 	 * C2PMSG_35 set to 1. All other bits are expected to be cleared.
@@ -714,6 +737,7 @@ static int psp_v13_0_fatal_error_recovery_quirk(struct psp_context *psp)
 
 static const struct psp_funcs psp_v13_0_funcs = {
 	.init_microcode = psp_v13_0_init_microcode,
+	.wait_for_bootloader = psp_v13_0_wait_for_bootloader,
 	.bootloader_load_kdb = psp_v13_0_bootloader_load_kdb,
 	.bootloader_load_spl = psp_v13_0_bootloader_load_spl,
 	.bootloader_load_sysdrv = psp_v13_0_bootloader_load_sysdrv,
-- 
2.25.1

