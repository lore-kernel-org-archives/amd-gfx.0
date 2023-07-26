Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FAFC001DE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 07:18:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADB4810E418;
	Wed, 26 Jul 2023 07:18:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60D0C10E0BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 07:18:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGxqmLoFLrO2JoaoVMsMv754yMp5E5BiN2prqwcgAdIzzUG3N4p03ogIXlnZTBASkAhTJUstX2fD6XHjeKHe4tb17/Cw2hUrgLWEHEOUZrLYKqrLEXYlZd04a1hmmxsI98btAAEHFp7XSAvMkEab+n4xoy31v5HEcpI3Be86+58zA8oohz/q3T6bv+FOfOcBwMazQM/w5LyXJNBr/smEIa6CUARFQIIsATrWEHvVmV9dsJ52SRQjy26mCRwyg/9GuIqsUwVcM1e+IFJcaCkPuijhKyZXmui4HVISy9e/MWsMtEW8NpUqoVrl+Q3k3R0oIuKyVCRaQ/Tjb3PT2gc+Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhaNYNGjNKIPNDEJm9ruyCjMfmv26zP4K6bt4ViNez0=;
 b=gQ7403g7ybFJ+odz06IsJxHmVJdbwOA9ZQq3U+qVwym8XgmlxNW6r/CNgNxGo9b5BTp9OxflhFThxVFezBaDatmjlM/mYS3rUiWoUK4cYfZBvwECl9bT4XknHm5qfKAuLCPHjzCgvaSqXGw+pu4v8fk2L8n9aCDXFtG7TiixYke71x0egNeHDoCltgpPVAJ6BSLai7eTxmDR7PD++7mPZp5wQKSE56dtd8y/2v2/5hEdOBKfSzTW71sqRek+DWIqz/fC596cI9yIIgePUivNdgNs4x78HdArsA8SImCEu4vV64umhOxiJ9/sTwAnuygoMMekBznKG/723Wnc7m1ywA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhaNYNGjNKIPNDEJm9ruyCjMfmv26zP4K6bt4ViNez0=;
 b=yc2ysAaeGbCrWKRM+jv/u2r9McXYjLOzR6QLCptncEVwlzyahbNnSRcpLuc7+NdnNtWp0IDMM4eURbSj9sTjEETm4wx0gn71zFezdkQyIK+948LNkTiQFYEpISyCfaGhqnln9Z8OQ1ONegfmmaAO+RP2jVRVMHgQ7dJ9wbb66+w=
Received: from DS7PR03CA0178.namprd03.prod.outlook.com (2603:10b6:5:3b2::33)
 by IA0PR12MB8839.namprd12.prod.outlook.com (2603:10b6:208:493::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 07:18:03 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::54) by DS7PR03CA0178.outlook.office365.com
 (2603:10b6:5:3b2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 07:18:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 07:18:02 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 02:18:00 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH] drm/amdgpu: Fix unnecessary else after return in
 'amdgpu_eeprom_xfer'
Date: Wed, 26 Jul 2023 12:47:45 +0530
Message-ID: <20230726071745.2453891-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT057:EE_|IA0PR12MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: da656619-bd2d-4f96-baa6-08db8da8731d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: epLqq4GFNXJ9qAiDbNK+JWU/Ua64qTrM4PoHAqX3vunx698xW6ebd8CQOBRlEITeigSxNUNxZQ37mUb2dO3VwgaivHQ47HE5bFauQfQPP1UQ7vBHOfENRSipemiCfdY+6MKY6EzX/hbm3gciY/L6yqgu9MtdDlKcKEtCtFVyRsz4zs3rNxKLIeeU7F9T15tVdEerhTLvch+QhVKhCTWNdom4j6b3v5Rp7NZD5PihzyROFCIcHcGdeYeUl5AEqOC7EEB+TC3Beb7uCsHobezil/C1B3kfnVJ9UH3/DCTnU+oUs0Zfar6QyYVEhodg0bgioWgf8H/k4GJpSqyzM376YVkA7pEWbLeUFV06Yx4kulAtb7tzZik4s6Nmb9F6t8lwSfRpHDrcJ3s29ly3iPdHcPEoTQfohyIt/IM1ogCrvsONU0k9OqY6NUSeZ8VuWMUqr/rMCIAvhHsYVJGY5Kbb5wxFLdUalaC559H7cTmQAUqKCAAeuRioDRkfzxLyhC1G+NgLIihxnO5ndeAWA4w9pJr3lopxWmmVgxh4ST411oxu6wTqCuudoJVO2V+9J2cxTC5F0R6oFONVEWEyFG6l0pRQ2WtrtRxhNkd/0Nhut6+WJMHSyHt+bDpDH0LB+aBD3JZJoS4ReUTNfpJriC/Dvram5kHELrb+qFhGqBFRUcm4Om/F0Ke65bOMWt+6Rvkln0KcdeiP7oAhO8XQjPe2bTYZNXXKESyHpZC+eUfuQRlh1lHw5MiOeKYrOjwI8lZyY8guCGXWQjPY4PqjM8ftkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(110136005)(54906003)(7696005)(6666004)(478600001)(16526019)(186003)(336012)(1076003)(426003)(81166007)(2616005)(44832011)(2906002)(26005)(41300700001)(8936002)(6636002)(5660300002)(8676002)(70206006)(4326008)(316002)(70586007)(82740400003)(356005)(86362001)(47076005)(40460700003)(83380400001)(66574015)(36860700001)(40480700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 07:18:02.7626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da656619-bd2d-4f96-baa6-08db8da8731d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8839
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following:

WARNING: else is not generally useful after a break or return
+               return -EINVAL;
+       } else {

Cc: Guchun Chen <guchun.chen@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 39 +++++++++++-----------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
index 7d2a908438e9..e71768661ca8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
@@ -183,6 +183,8 @@ static int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
 {
 	const struct i2c_adapter_quirks *quirks = i2c_adap->quirks;
 	u16 limit;
+	u16 ps; /* Partial size */
+	int res = 0, r;
 
 	if (!quirks)
 		limit = 0;
@@ -200,28 +202,25 @@ static int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
 				    eeprom_addr, buf_size,
 				    read ? "read" : "write", EEPROM_OFFSET_SIZE);
 		return -EINVAL;
-	} else {
-		u16 ps; /* Partial size */
-		int res = 0, r;
-
-		/* The "limit" includes all data bytes sent/received,
-		 * which would include the EEPROM_OFFSET_SIZE bytes.
-		 * Account for them here.
-		 */
-		limit -= EEPROM_OFFSET_SIZE;
-		for ( ; buf_size > 0;
-		      buf_size -= ps, eeprom_addr += ps, eeprom_buf += ps) {
-			ps = min(limit, buf_size);
-
-			r = __amdgpu_eeprom_xfer(i2c_adap, eeprom_addr,
-						 eeprom_buf, ps, read);
-			if (r < 0)
-				return r;
-			res += r;
-		}
+	}
 
-		return res;
+	/* The "limit" includes all data bytes sent/received,
+	 * which would include the EEPROM_OFFSET_SIZE bytes.
+	 * Account for them here.
+	 */
+	limit -= EEPROM_OFFSET_SIZE;
+	for ( ; buf_size > 0;
+	      buf_size -= ps, eeprom_addr += ps, eeprom_buf += ps) {
+		ps = min(limit, buf_size);
+
+		r = __amdgpu_eeprom_xfer(i2c_adap, eeprom_addr,
+					 eeprom_buf, ps, read);
+		if (r < 0)
+			return r;
+		res += r;
 	}
+
+	return res;
 }
 
 int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,
-- 
2.25.1

