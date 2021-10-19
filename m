Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223B7C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 17:51:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2F966103D
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 17:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D2F966103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 561F56E1A5;
	Tue, 19 Oct 2021 17:51:07 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2060.outbound.protection.outlook.com [40.107.101.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B00B6E1A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 17:51:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxvM3Y0Cl40ZxvgWrx2OcFsKY6biKbcuCiZSMwFi11MIL+nGgyNFdd2NF5IXUXoOaiWB1K7vhhRSphWD0VIn8lXFSdYxUlNf/74R8mrCV/9m4Q8WrjMyGp0yj8FxWdwqIQFARKHxZmHYel5/jrPTuPqhssWG3RFrZ+hefxcACeoGynDoDtBvYexJMWK6ypOgebRbNSBxeh5RsaY5zkb3tEweUJKO5GiTTrLoto5c7MzmlJn7t5sQoYxmWQjKxvWGAkQY+RjMisPCVOOPo6hyygxYKaQOSO/mTH1mQH9xMRrHPlVDX2re6A3EloI7gzp6wRmfQwlmVR4Q4IFpagXvCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxBtces2jXeTKxtTyPxXdnj/Vx8M1iuucIpc5Pgglyg=;
 b=Y4uRZnF2N2gGTq8OgopufD97Q3+ZAw13UsnSKa/07yYaEhDrApxET4Jiq+1voPlXksj76DiFOAjOz+fg9wTd0tPpvGf1lwVdjNwGzDUUDlCR28vdEtnHG8JY2zU10FXSi/GrYQpQ/CHs77M8haSCu2JY5SwApzWkM+tcGJdGfT2+OPAwDqP+oD2XXUgixszw07ETyRE9rc3KU+MrklE59MXijmg39f0ZnCW/qwvfqqnm0N9s2TqdtUSWwvG/lqKIjQoLPSEWH5TsDUQJDLb9piXp4WAISHJU3GVDLI4d7da5jBt6Q03+s4IscWauQE6ByE8/7YEONuyD3Ous3aq8JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxBtces2jXeTKxtTyPxXdnj/Vx8M1iuucIpc5Pgglyg=;
 b=oi+BHaW7a7Q0tqgwZfdr8OIYq9FgZuFANlBofIiq7Qldyaf3yTHUYPVGhsfku4Lr3NhgX+3nS0m05XMEWWKPBfGkE/1dEsuqonq7jpgycAfI7teaz5UIsuyByfVzRmvlRjVKn48UmtzBrMUvxNfCe9jgoYcOUg+/9kGiJxJ2364=
Received: from DM5PR17CA0052.namprd17.prod.outlook.com (2603:10b6:3:13f::14)
 by DM6PR12MB2875.namprd12.prod.outlook.com (2603:10b6:5:15c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 17:51:03 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::59) by DM5PR17CA0052.outlook.office365.com
 (2603:10b6:3:13f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Tue, 19 Oct 2021 17:51:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 17:51:02 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 12:51:01 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kent Russell <kent.russell@amd.com>, Luben Tuikov <luben.tuikov@amd.com>, 
 Mukul Joshi <Mukul.Joshi@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Warn when bad pages approaches threshold
Date: Tue, 19 Oct 2021 13:50:47 -0400
Message-ID: <20211019175050.934527-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d444b01f-92d2-4702-d94c-08d99329048f
X-MS-TrafficTypeDiagnostic: DM6PR12MB2875:
X-Microsoft-Antispam-PRVS: <DM6PR12MB28756671162F0E93105EFA0785BD9@DM6PR12MB2875.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AiMxcTWadjl1BtHl0x20ywN7a7BdOfYBktKeREhWFUt8zWPed4zogLLhvU8ifvM52IW1incPJVeqYM43CT/XAAh+/RAc1zJ82O4NQreQTWwEMlOH1aTE6J9s5y/w7Lf8Y1VC5lNzjGody39Vu4/wNOTE5R6nLxAg58hITNzjSQyvtPjT5Qkd/L/3KjBgWr0AkmtdX1guAZcC7hH3GMzXqQcyjMT3f+2Jvd6TlZKmdgT6pxBjZgSybwShmMNgnlcVKBZKk6GVIHg0/yWkAy7gXOvtVhCmgqXMZDbHnoMfBd+Hx50e9sMePjdC3GKvi4aJLuIQOkHsXFsKTloX0bg/2f0AXzYSU1aif7aEElIX1u2PYNlTLQNiTxnxDSiaD9O/6XO3Fsu/sP0xIyMqMF1o0OXBdXVvTRpOuJXKXb9jiqb/0V7KL2MsmsRFAlfZrMrmmW6JUYShBUKOsWFTpLrrc0fdwC1uHwTMZqG6qAAPxECIzHWPXafrhSXkaoum3JcVZHv9jTVnGYAQqI3vEDn9EBn6cvQHS1n4lPn3kGv9wi9IWRA1wDUaj1A7yfVas0ik3n/di1JCJvXkxG0jW+kMbNaT84Z9uKJvz9QoBefz1zpy5rIexpOVHxdqK4VKCHYi3bAe4z/e+SUwZvgue6IW2n4IMP/bD9Vm71vxqT5nrPJpJplo2ZOMYdd1Q/lDNJEOE4Sv2b3po5lCLKxSjFlytBgvgLRBgKhOJlKd4e7MVBc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(426003)(336012)(8936002)(26005)(186003)(16526019)(8676002)(1076003)(44832011)(70206006)(2616005)(47076005)(508600001)(54906003)(316002)(5660300002)(36756003)(36860700001)(86362001)(6666004)(83380400001)(81166007)(2906002)(7696005)(70586007)(356005)(4326008)(6916009)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 17:51:02.8374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d444b01f-92d2-4702-d94c-08d99329048f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2875
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

Currently dmesg doesn't warn when the number of bad pages approaches the
threshold for page retirement. WARN when the number of bad pages
is at 90% or greater for easier checks and planning, instead of waiting
until the GPU is full of bad pages

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Mukul Joshi <Mukul.Joshi@amd.com>
Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 98732518543e..8270aad23a06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1077,6 +1077,16 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 		if (res)
 			DRM_ERROR("RAS table incorrect checksum or error:%d\n",
 				  res);
+
+		/* threshold = -1 is automatic, threshold = 0 means that page
+		 * retirement is disabled.
+		 */
+		if (amdgpu_bad_page_threshold > 0 &&
+		    control->ras_num_recs >= 0 &&
+		    control->ras_num_recs >= (amdgpu_bad_page_threshold * 9 / 10))
+			DRM_WARN("RAS records:%u approaching threshold:%d",
+					control->ras_num_recs,
+					amdgpu_bad_page_threshold);
 	} else if (hdr->header == RAS_TABLE_HDR_BAD &&
 		   amdgpu_bad_page_threshold != 0) {
 		res = __verify_ras_table_checksum(control);
-- 
2.25.1

