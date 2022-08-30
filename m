Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6DBECAAD5
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 18:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95CDD10E374;
	Tue, 30 Aug 2022 18:40:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 343BC10E381
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 18:40:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoZZ1FX3WBPPsiiqOLlV6AN9V4lLgWtpsBXNuJCNBRMzleoGi5TuuFlWxamlmHaCBvzPNW8uil48Na17UERHpltpH/1BsH9SN4ArvfvuHN91Wsdp27/wTfRtLvVoPMpc26RaB5jebSwuLYW5gMQ0DJ+dg+Xu/pm8I3h+GhpBgrErQHHZpF4uXzwwzsVRa1FTZf+sQmGPHiqhwUdaYClqD4cjnD+Imryxx2S/N+0e+vZS7F1Npwcy+aa7nuHV/2FcHYR0B10A0jn50Ix63Rd4CR9qsO7m/3mjYUHdgmH/K4DWJ/z72ZQwATy5P7W5LzE62j7FFkX+FLH+qh5yH/kT6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjLMDQa9uaYBGWORptDpORBVVKrXb6y71/SF1QyX9T8=;
 b=KP355QdKP89V4/HsWYI3uiGhA44BiOjOmcBooqGI4emKHj2yQ3zFFfzu4yO0k/NB5agL/SdlYqqRYO5Qq+iqTnYcyeYKgBsT8xq/50uxI+y8gWmflDTFEK3oDu+y39Vp/+X6x+YoXgqKy8OClr0+zrcUp1mhWc8EhnFPJ3tSicVK66DN1B++jVOqRfmpnkXicQ960F5NJPyrl0lMibH50hsQUjjt67Z0pKj6ULVKxSoXsSZZIao7dzJDn5jycyOjE+/1YZ7FWqZpcHDu0n1JqEzQ8cvzBRYVLBHLtnszThKlqk/lHxD4iWpkQUAGoVBbT2PWtX3/O2Evja/4sRXUCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjLMDQa9uaYBGWORptDpORBVVKrXb6y71/SF1QyX9T8=;
 b=Ay1VtdzdBjw1B47Y2/7E5ZaopDwleQ2R1c4jBnsJQZcCFHrGadvLjZBwQhwVNbeERXmzYNHJXRi8iC17B5ENnlK7novWwvnc2DYoOrXYqe0XZgb8PDNJwIA6DJjAOeFM+TYdpZqB3/U0hecdW/6S42y/1ct5LozfSnYxpiHUe8k=
Received: from DM6PR02CA0062.namprd02.prod.outlook.com (2603:10b6:5:177::39)
 by CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 18:40:37 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::4b) by DM6PR02CA0062.outlook.office365.com
 (2603:10b6:5:177::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Tue, 30 Aug 2022 18:40:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Tue, 30 Aug 2022 18:40:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 30 Aug
 2022 13:40:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/19] drm/amdgpu/vcn: Add vcn/vcn1 in white list to load its
 firmware under sriov
Date: Tue, 30 Aug 2022 14:40:10 -0400
Message-ID: <20220830184012.1825313-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830184012.1825313-1-alexander.deucher@amd.com>
References: <20220830184012.1825313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bb5b7c5-d785-464c-7d22-08da8ab721d2
X-MS-TrafficTypeDiagnostic: CO6PR12MB5394:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bxz8Xz2oJseYCFPhw8JM/NVJSdK7P9XsxJRVuSXrbCxu4dFZBYQY0vA3jfRgSFCvvjuxySs4dDvpS2Z8BnIVk6nTXkzI8oxg7h9XqgSRJLyG7f0SWJ5G9/IpacfZuTwKNRuNLZ3FNQupwQP+p/Zd4R92ZeFUVsSlBgNDtgbBm3+fq8Auxr51ukafn+exAGpwnhL9dcsD+faFhI8Z0CN36fs1DwV5wZQ5MiuICGF2bDF9FpXh5S6qmY2vvVIWqtPXQw5/g0pI8pu2RbyHX1Ezqx7bSX+d21Vdvuk9SNzF4OdOICMQheMU6JX4+0VQUhcBoHPMiLmD4yP+2AnytTAiqTqgxdV/X4jEPpwzFNvH1Qy3hOdyPR/v2uJWwxyhahro7FN7HdtlgQwD1InBW4Q3+aaBCJLPbtNmR6pITh7jVqZMhi/Z4Zrmsk7QBTziUdvVGmtnSNGu3yzWXsiQHF/fBVukymJLJmFNZV7gJBl+HlDaqaL9XFqxeFzUgAOowkpYSOLzP540AHwpCFveyvsXkYHtfr9LHF9dT65GAcNU6Jdgw0QQKmQwZclgYDqL+TeUuwJl5N4PCq8sXED60uoGX2aBVzFatVwED74vl/KCmzSC5UMBaz4CLtGMkkW5gzSZisr7t1V83U/rJAXerR2JWmLOxg+qxyRiOmwU1d7iMa4WXebStWFtBAvI/pu7PfkcJTDd6kdL7zkTi/bzZ3dFQD3v9PorQrXC8gmKr5og7npbVtkr8lIfGNM7GLh0yMODvNF01w5IVgNqTdACezR4g5kB1MM9WYBmKJ1dVdzTdfOpIneycS76cB6bSb6G04yx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(136003)(346002)(39860400002)(40470700004)(46966006)(36840700001)(8936002)(8676002)(70586007)(356005)(81166007)(4326008)(70206006)(36860700001)(36756003)(82740400003)(86362001)(47076005)(83380400001)(336012)(186003)(7696005)(41300700001)(1076003)(478600001)(6666004)(26005)(426003)(16526019)(82310400005)(40480700001)(316002)(6916009)(2906002)(40460700003)(2616005)(54906003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 18:40:37.5562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb5b7c5-d785-464c-7d22-08da8ab721d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5394
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jane Jian <Jane.Jian@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jane Jian <Jane.Jian@amd.com>

Previously since vcn0/vcn1 are not enabled, loading firmware
is skipped. Now add firmware loading back since vcn0/vcn1
has already been enabled on sriov

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index a7de2c2b0cae..e4af40b9a8aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -835,7 +835,9 @@ bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev, uint32_t ucode_i
 		|| ucode_id == AMDGPU_UCODE_ID_CP_MES
 		|| ucode_id == AMDGPU_UCODE_ID_CP_MES_DATA
 		|| ucode_id == AMDGPU_UCODE_ID_CP_MES1
-		|| ucode_id == AMDGPU_UCODE_ID_CP_MES1_DATA)
+		|| ucode_id == AMDGPU_UCODE_ID_CP_MES1_DATA
+		|| ucode_id == AMDGPU_UCODE_ID_VCN1
+		|| ucode_id == AMDGPU_UCODE_ID_VCN)
 			return false;
 		else
 			return true;
-- 
2.37.1

