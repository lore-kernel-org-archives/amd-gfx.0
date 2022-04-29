Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DE8C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 18:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E476E10F8A5;
	Fri, 29 Apr 2022 18:02:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D137D10F892
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 18:02:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrDKISGHk0VMbF4rbcDxlNRTsBMXUK2zwe9D+zo/sBCrsjm60wXN7Ah+k7j1P7lgBtYxKRzr9bL/bqNP6YtE2cMBGQYDLKc6PILaS7eTbP54yUvu5X0mXc/mx37Di2c7yQh4mkFArPUevCRc85cg5hbHFiETZK8ez5JTiFG8k+briN7+Mq9CeE55Rw5WFpKSKCgpUNWkko+A3OGvV3yyOaSZJVioY19Um+68e8y5F0XNETlKkcEFh7cv7lQlqe41b1DY83nutJ6K9Y2SFynkdqyJyrH3PCzSQW3N+UzlDdjnijIKEKm5K/Y9sIE3QREp5/CWoJYMhiTE8cNJENBmAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFtEbLJe1xlI2xAqLZM6gjSxX8w9kMRtQ47SGo0pcm8=;
 b=i1dzqglCIUsRtlhco1V5ZvPkuZCmDDj/8/KQMUW1MW6rWJU/++nnWwr6Zrzc12R9r1XiFAMD69z7qqI+G3Hq3ifR8+J93Mq6JyNhfudbP3F2Hx7PiQSMSYLGtE9uGI92ITopKz7G61ZILGE4END7nSjb6iZpLiZodLzlQkq2c2lf6qsGrReXFDArfsTYMnayqvKAjcyFzwHLxUuyHXWDOAi80n6eR7liERyxB3bW8DJoItympNQcUVeSKT0IhCcFoAEcfACXnY/RxXJUaY7wmVxiD19JHz1ICHoAtm3A6hwPjdwE02NQ9aHrPU1MwBulqRSOCSC7eLhO9Z3uSVHHXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFtEbLJe1xlI2xAqLZM6gjSxX8w9kMRtQ47SGo0pcm8=;
 b=5Bas8v6RTLwzlzNj/MHNJvfV+e18KRDC+pdbj7w8z1jSsgbtbG3mASfn5+5NFN/Mk6TBwr9fk6/z0fVfMLP6vfdBoZ+ERjYUlpstjnpklmJJ/HhOdBsngO8ZrGwyhSvDicTCalXgVUCKXg26hHUBugbZTi+XmffiaAWFMEgT2vA=
Received: from MW2PR16CA0013.namprd16.prod.outlook.com (2603:10b6:907::26) by
 DM6PR12MB4652.namprd12.prod.outlook.com (2603:10b6:5:1d6::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Fri, 29 Apr 2022 18:02:46 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::19) by MW2PR16CA0013.outlook.office365.com
 (2603:10b6:907::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.26 via Frontend
 Transport; Fri, 29 Apr 2022 18:02:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 18:02:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 13:02:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/29] drm/amdgpu/gfx: refine fw hdr check fuction
Date: Fri, 29 Apr 2022 14:02:06 -0400
Message-ID: <20220429180226.536084-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429180226.536084-1-alexander.deucher@amd.com>
References: <20220429180226.536084-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4898776-372a-4d8d-b6a9-08da2a0a76eb
X-MS-TrafficTypeDiagnostic: DM6PR12MB4652:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4652FA59FE88729CB17D119DF7FC9@DM6PR12MB4652.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /m8qRaObL/flV4dr5JC86KxhuH/PAooMNYchwptCTzYo8hdtm0R3wbAcBtxcWkL3ejHV2WiTuyM9rY/E4/f9LdqOeo6iVjLT5YjDuWX7lq4eglwpni1UhGBqZ5jsaVtw0vDpQuarXf+TmnmO+BVCqT69/YxUozotDaMCX+kzQjSYhGSAENo3oSSJs8yDitjQxxiTmG1Ae93ClFNqFkFfgCytFVoSKnBypFWr0Oqpx/+G0mU4Qf3pWC94ZTB3NmgphkPHxf30ccsHtJoPJzMOtopvfPhtEDc2uACQDp9OrICrLAJdOsozoPm7Lg3exqnXGi2fjd2V+eygm6k7A48aF6GLgUTYbYiOZ3z7V3pRmZA+F5qkX9SCWKjvBnKoGIiBxnLX/cg8lu+veef4W8HFEYZgrNbejpCw35gUmqrar7n1OvdnijyG5qyQEIYviaSu/7HNvG/+N3VRDFNwVlGdXVeinqe5YO1IWZLylaTcoSW8/BmUNPdyjdBqNI2sRkafmR1clLGw+BeHBbAND9W/UIFnseLasrBqtMirrx1iXSwwqpfcBBiOn6i/tpIFggTuPq65xGLhCL+ZrlJOUfABDrGdVUeCxJLR5puEMsn88fm8Mi0as7XdgvzzD6TVUAlUDwg5/YhVZ0buYPOytnylxpy9rkH5pC63cptBko5enPSmTM4C38VErIj9qz1XOqiRHq3EZFPz7D8CsFJY8Xzo7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(7696005)(186003)(5660300002)(36756003)(16526019)(2906002)(70206006)(36860700001)(316002)(83380400001)(8676002)(4326008)(6916009)(70586007)(8936002)(54906003)(40460700003)(336012)(426003)(2616005)(86362001)(47076005)(508600001)(82310400005)(81166007)(356005)(6666004)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 18:02:45.7670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4898776-372a-4d8d-b6a9-08da2a0a76eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4652
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Wenhui Sheng <Wenhui.Sheng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

The return value of function amdgpu_ucode_hdr_version
doesn't make sense, so change it to return true when
fw header version is match with passed in parameters.

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 89bf746fe96a..86fe9da72e6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -428,8 +428,8 @@ bool amdgpu_ucode_hdr_version(union amdgpu_firmware_header *hdr,
 {
 	if ((hdr->common.header_version_major == hdr_major) &&
 		(hdr->common.header_version_minor == hdr_minor))
-		return false;
-	return true;
+		return true;
+	return false;
 }
 
 enum amdgpu_firmware_load_type
-- 
2.35.1

