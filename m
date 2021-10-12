Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D512BC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 20:57:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88C0460720
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 20:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 88C0460720
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25FFF6E9CC;
	Tue, 12 Oct 2021 20:57:05 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2084.outbound.protection.outlook.com [40.107.96.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0BBA6E9CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 20:57:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrDZMbjSoRUFweoiOUsCXMKoGTARh3sNhF37Q7emae809xx0orsCQG/fLg8q9xvepSkSPSQyJfn+HPJBkRElXoUWvl2WmRb2yNVU5fWuuIVasveAIVImmk/B6jkFzhDpSZyuE5SBJyxUCRJwlt4atDBtehMOiiN0ovpEYmpd0v1zs6i/Nbph8XdM3Srg+IstTpo0OBftCqE7or7AaSDcWVyjzBLA5IYjdLNBgBfGZKzL7YE04HVCQRWvlCK6BCFI62x2kjAZIRDaJHavhaR2QCEGIy5imrzcRS8JyF6H0/i/ZgbKSS4Iu2MjipC+Z/84DDYmk5npMqENoqGOCC8BUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCPD4dOjm5JPp7Ij9wPfCGdrBEHciiZBz5Jg3E4yuq0=;
 b=bxeQy1QHpR6vJ9kpWqddV+IXOLIBZDBC0A2melK7A1SXJrN5OVuc+wq+Qn48gJl59ANDFz6D+lNepZW9W5roGwiqhvhMUD7XpWtgeXxsCS+JSFoF3ejA+yK5VJgRyC4FZcYNVf/skavpnjZav8Z5nf/UWkBHU27DXEKiTtPTjn4o5/eoGFgK3lUjw7JF5lbbG7fxU1V7FmUA5jtYLgHaRcj7UOvFmyv1PLhDjoR6VjxyFwTGJY4za340h0KBxJ6GWNmYfWde3ALxU8DA5eyN8V0BRIO8iWJxtQ2oE/sFUfXd9AUo6nvZ3yhAZL53cDwBrDGIvbOeDBMars2gkE4Ucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCPD4dOjm5JPp7Ij9wPfCGdrBEHciiZBz5Jg3E4yuq0=;
 b=SI14v/lazhBiNWlUoAhPBDEkea1nzyrjdHDfLZ2YRK6YME6re2mKS4kjiz7Wdbp9KOVfs12aVOfPyCD9fE4+VyxGkMIVBXmsTVjFLze52aenWNg+dBVged4ku367gpirUskwxJEgZhs3Et9jxIFVvNz+jTo22lk8nMSJbLiHUTI=
Received: from DS7PR03CA0316.namprd03.prod.outlook.com (2603:10b6:8:2b::17) by
 SA0PR12MB4478.namprd12.prod.outlook.com (2603:10b6:806:9c::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.19; Tue, 12 Oct 2021 20:57:01 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::56) by DS7PR03CA0316.outlook.office365.com
 (2603:10b6:8:2b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24 via Frontend
 Transport; Tue, 12 Oct 2021 20:57:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 20:57:00 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 15:56:59 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kent Russell <kent.russell@amd.com>
Subject: [PATCH] drm/amdgpu: Warn when bad pages approaches threshold
Date: Tue, 12 Oct 2021 16:56:50 -0400
Message-ID: <20211012205650.570388-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edb6e9cd-9b08-488d-95fe-08d98dc2d649
X-MS-TrafficTypeDiagnostic: SA0PR12MB4478:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4478E31575B8E3C1D7ED4EC185B69@SA0PR12MB4478.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XEQVR2QpuUgMhmPxABtuIjaFp0nQF3HqiDVZnwpD6L3hNN47ricMbrr4pOzZUlYydWPY4g64QAKCig8nZAjbkWM6TRzOdY1ZP+KxnaoT8yvpqIS23pA1TywByDOLAK64WsqX9CMyqh4DD4gmTiSs1nldQENJ08CGWeGqOGHY9MCU7A6uBqBmCRO2ls+zGCxQfbKV5vaFvkY6fv+Xfv7y5ztU5GUlKrBkAMXYxzarbguwedNGfqmlh4yuiQfoNhB3AqkrSnsNDI7uzE7KmH+VJMSmo6/WaKeh/BZ9ISlb/L2b9yg3paVfTsap92+19T1OcWmEQGxB6z5fez8T2TCnSe9FUwtHpETnkrAGpfWSE0FsjaQ+yd3w2virDesRjoZDVafmGuacQnz+NcFsJHWc6NIV+vnqgLx9rbS70LGE1D5i6rTvLl+YTdtZZDDkyBz3TPH3TVkekMiv00px1Z+X4hcqBX42t0cXSM/PG/Y6ukFSevSOnM92duBkrLffrdeBNb6dSE5eOX80O2AaNEv3dNu8VzkERMSulkJls9/cJewDWkfLIIGqeV+NG8Z/3RdaTY30d6ifzn5jGWbCUYBN5VN9rYUYHGBAcJnWsojOvoTijbVZ57Kxlcvo24NTUQC3h8ikrWaAj6IWD8W++I5aJqcDOZ0lOO577302zh2EK66/53+ltzDfj+OTr4xxien5Zq/rtpaFiJNe34x6s32fzMenYKlUGitWD5qrCotgAk0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(508600001)(82310400003)(316002)(36860700001)(336012)(8936002)(36756003)(8676002)(426003)(1076003)(5660300002)(44832011)(2616005)(47076005)(6666004)(83380400001)(2906002)(7696005)(6916009)(356005)(70586007)(86362001)(16526019)(186003)(81166007)(70206006)(26005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 20:57:00.7144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edb6e9cd-9b08-488d-95fe-08d98dc2d649
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4478
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

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 98732518543e..eda823294dc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1077,6 +1077,8 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 		if (res)
 			DRM_ERROR("RAS table incorrect checksum or error:%d\n",
 				  res);
+		if (control->ras_num_recs >= (amdgpu_bad_page_threshold * 9 / 10))
+			DRM_WARN("RAS records:%d approaching threshold:%d");
 	} else if (hdr->header == RAS_TABLE_HDR_BAD &&
 		   amdgpu_bad_page_threshold != 0) {
 		res = __verify_ras_table_checksum(control);
-- 
2.25.1

