Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B9EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9786F6101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9786F6101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D163E6E8EA;
	Tue, 28 Sep 2021 16:46:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CED2C6E8E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:46:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRVN4os8eWGoZYA8Bfe8bGMjaB5cn7CueA8VS2q8hTVNE50kcbASRsT9dzddp6dg6Uy2nsfza4E3s8q3T/O+bDkGZubzyXQ/wqmOZQjVkGhf5xsByVX4ygeMF2TVGOAZLC6d9rxQ73KTYl5CeZ6J6nhhB5Nh28M1kTefRc3lsr/MhbTE2jdqzzUCDTDWozIEmOgwC++ht4eauo+do96vIRfaX/5WK9GsTJBODER/XTOTXl57GzwaXFVI8Ivc1IJnOiDcyKiVPc+2h8MH++YAdZ7fVjn6t8ThLNfW6HH06zDmA3zyOV849ya8RylcfVlnFmz9djpjirBw6pwCgVtefA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=wmM+PupctCwp+45+VG/sv+uZ2Ig994mMWTzGWm9uDeg=;
 b=k9wsQdscdB6idtOcKc5Y4D0tulsUmtDRc1vmw9Gi/sFYOeFyt5R09pU+BiK+2ti5yYlmgBwRTkd2FL6eG8J+tUZCTkO33+/ITTcHmFsB4HNR0VS+Rs4hFgdun7/e8t/Y1a1V9oISZ0TCaZ2suNLF/mhHYKMOzzupORR9L9R+f4Qk/FFaq/Efy1Q8KuN1KyGNFcCSW5lT31ahOZ6tr7njYdrB4pbecPVjdWkfJV0uzqzuo51LF9TpmOh4M7sx/yxCKwr2P83J6AOBKYkk+T/znzX1bvGGzPpCukWHG91+sCP+6a2aHwtczTrB5b9/jhxkaIakQfEBaGPFqfjSZWteKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmM+PupctCwp+45+VG/sv+uZ2Ig994mMWTzGWm9uDeg=;
 b=vZuTL2LrWH81N6msa3u6G7UubaF/jlpykMlYdxiYLtxJD9wZcG2PEWNs2H9Z1I8PSdBECkboeOwtXUkT4Mx53b2fiSF7LeVDqk8nxxaFvTuwh4dPSL9LmBzib7X94yUctQ7TL8YKnJpyeBGcgfRFnehoEihevY5Yuom5L0fWNjo=
Received: from DM6PR03CA0043.namprd03.prod.outlook.com (2603:10b6:5:100::20)
 by DM5PR12MB1641.namprd12.prod.outlook.com (2603:10b6:4:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 16:46:21 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::3e) by DM6PR03CA0043.outlook.office365.com
 (2603:10b6:5:100::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 28 Sep 2021 16:46:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:46:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:46:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 56/64] drm/amdgpu/ucode: add default behavior
Date: Tue, 28 Sep 2021 12:42:29 -0400
Message-ID: <20210928164237.833132-57-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf613c47-6d8e-4caa-5cca-08d9829f8021
X-MS-TrafficTypeDiagnostic: DM5PR12MB1641:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1641E593C8B4A4BCF36D7BA1F7A89@DM5PR12MB1641.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9T1MYNXlgvxiqQYfyaxkcnkyG93TY9U2iVZiIgTqUYOiPHkBwSd5eiwoBnBg431bYCJ2fYb2ojlxIso65Ru3vQJ3B/f2jzTT1TojVeYrJ19jfjqUJEG/wVsw0Zolimr9xxqPIlvUSitLSTdbJcQpw8kBnHGlnxbqn8bUQvzYwRaP+3rKI54gUsXUrbO52NAwDWxrhlVtpwbXtRmnZbQkMRqTr9YMDAkQiBTpIMpapyWC1+Y0TI6thFvDRmp9AfxTqnBf1CaHdDAKGv/aj69HvH3zdEImK1AGX2ZeCT7EdImX4gvBl6RwMjN5L5/gWM7QTnHM1j0KWVEjUESs+WNH3/Wzx1/nJWNUCBoUG1PHss0j8o+KgRrVw0FQtwAlzkf3rrS2Y3WF7k6lPFEZV6G3ICLpyJb5fQfcEGTxcgkaA4UN0BhyXWBfpRmyHN23dry9MbljGnkEOEeYQP0IrpdPJ1RHtQuk1dNT3TOCDN6wxvYMg6D0XrZFUi1d+dps61m3BdEvRJrH7LqCapXBY44Cl9dWlxXq1N4fDt3FZLeXtay5ksv2BR0bUqsIR1VpN2gzgxeMHH2TFkvwUT69XSTrq6xjLoWAhMkn8jfgDRzeY8cFrUbrrDj1IKWnFvGyCAYD4z2b+f0qnWXt5tooj3GJlMDADT3TO71LdvWr9KjJ6G3/5VF38gClZ+H7Aw/paePXYVWaZkvegSueG2srgDv+oA7cspl419PjHKj4qJrJlOs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(26005)(5660300002)(8676002)(82310400003)(8936002)(186003)(16526019)(6666004)(508600001)(316002)(336012)(426003)(47076005)(83380400001)(7696005)(54906003)(1076003)(4744005)(6916009)(70206006)(81166007)(36860700001)(356005)(2616005)(70586007)(36756003)(4326008)(86362001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:46:20.9917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf613c47-6d8e-4caa-5cca-08d9829f8021
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1641
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

Default to PSP ucode loading unless the user specifies
direct.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 527d67ded8a0..0c3127f37686 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -416,10 +416,11 @@ amdgpu_ucode_get_load_type(struct amdgpu_device *adev, int load_type)
 		else
 			return AMDGPU_FW_LOAD_PSP;
 	default:
-		DRM_ERROR("Unknown firmware load type\n");
+		if (!load_type)
+			return AMDGPU_FW_LOAD_DIRECT;
+		else
+			return AMDGPU_FW_LOAD_PSP;
 	}
-
-	return AMDGPU_FW_LOAD_DIRECT;
 }
 
 const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID ucode_id)
-- 
2.31.1

