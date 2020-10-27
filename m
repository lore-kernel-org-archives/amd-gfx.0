Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341FDC4363A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D47206DC
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ky0LUaEO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D47206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 431366EB33;
	Tue, 27 Oct 2020 09:05:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F18F6EB33
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 09:05:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fluj2HS4ZBar/PQVBvh63vU5hycvafAPMrW+apIbh39tMxrDTZSD7L0wq68qrXIGiQqNw3sf0kAik5C8YGTt3X7A6wFjTrY5SxN0YPcOaJ1PIjGuys+UximEuIv6WQx19Ja6YQqMAYbyRK8P+6U0drMZlxryr2If8yr1okdbYH7uxcStZjtjY1K9XzsL6hUlPQEooyJrvLhUi5h+9WsDJbVyJO0RoSnnmLwrQqUjoSuHg400RXBRwTgAXzg3Q0Q37IHW2DcS57NS+AuLS6uIJpN3u9pFntPlc4enlSufOBXBEaMWcezK7NN0vaD4bAsT0Dp5hzJDHjL+/Co+BbfwzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXVIbjMINQ1j5M5leas44fpK4v7jNl7NJJFuUGnG7cc=;
 b=ecoIUrzsjw8uROgrqFRJDEXFCxzBSIYTJ7XaPGAhQ4r6w6GWWoAp1LqUSPGOmhjJdYqDeVVZYak88ByzeasPuuMXx+BWWhD2yuQuTgrZoeQDfdLd7JgyPBpIT97O1lSOwBJY0o4QD2D9LDMPeWEX5JLvqpgTYTDbYMWq6VnITBJbQenWS2v4GG2K8uLMSrAWFCZ3cgGAV8QJDveOnvu9u7jlfrxtjAU2jJkSl9AVJc58mZHpMeYioBmqjCAqOD82Ox4oYVnjLXN1M9J1eRXBOxzyf6WWEiFadm+Nkuc2xeUilobmZgebQiFGZEW0gM5/KigQsxOIRA7N6PwqTXFs6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXVIbjMINQ1j5M5leas44fpK4v7jNl7NJJFuUGnG7cc=;
 b=ky0LUaEOBkaMhV/Khvfe3ThaU8tx8cdxNogyIQ0IZoeLOGUbdGq7Bmy34kLQvSCLKUOd0RB9FVau3qxQAwXYwl7JFpShbZLNmEyeMCf7ydqwrXDxV2jrgIUHYwwwq1Ph40y2NCJR5mxFBCVDh8H0ytz+4N/ot5U9zjr20u1Nkm8=
Received: from BN6PR1401CA0001.namprd14.prod.outlook.com
 (2603:10b6:405:4b::11) by MN2PR12MB3662.namprd12.prod.outlook.com
 (2603:10b6:208:164::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Tue, 27 Oct
 2020 09:05:04 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::98) by BN6PR1401CA0001.outlook.office365.com
 (2603:10b6:405:4b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 27 Oct 2020 09:05:04 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 09:05:04 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 27 Oct
 2020 04:05:03 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 27 Oct
 2020 04:05:03 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 27 Oct 2020 04:05:01 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: remove redundant GPU reset
Date: Tue, 27 Oct 2020 17:04:52 +0800
Message-ID: <20201027090452.3598-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb8ae679-2ebd-4284-156e-08d87a57648f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3662:
X-Microsoft-Antispam-PRVS: <MN2PR12MB36622F7C2A35E8FB3CE0BEE4ED160@MN2PR12MB3662.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7o409mrYuXxbLnBvYewyP2t39GPkZeZ1fjSLQndW14Z8/Az27+0QATOEtDpEWDUDydNmXL3FL42keauaM8Q/nE8/Pd8ef8TXzHPdvTXlfCRENz16pDiVIMbOqPy2B8EO/iGSdVegHYtcda0O/I/xEHP1gg18W1E17zbRPVpDCHIzVMvcP7HzQHJks72Oo1PXQmnl3TJNUVPDG/wWPRXHp21eqic0gFC6v5rcODFoFa8gdOCOSqZpTS+8RI2NKEKR6AgeKCF118QI64gkyaxwRccAGejVX5OQhnemTyCQ39QH/56jxFcdYSY3WGDzhoq9YKPT0oXWDn3JyYFFmR8TtkXg6ygYwIflFjtCaNKkXAxonuwThkJ9v/lw9JVTDNWQbYJH47DhqUiDZBEdgpeekS5gawtyIsWzo3Dbdv9n0YI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966005)(70586007)(478600001)(336012)(86362001)(26005)(2616005)(82740400003)(7696005)(426003)(4326008)(8676002)(316002)(6636002)(36756003)(8936002)(110136005)(47076004)(356005)(186003)(70206006)(2906002)(1076003)(6666004)(5660300002)(83380400001)(81166007)(82310400003)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 09:05:04.0337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8ae679-2ebd-4284-156e-08d87a57648f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3662
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Because bad pages saving has been moved to UMC error interrupt callback,
which will trigger a new GPU reset after saving.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h        | 10 +---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 16 ----------------
 2 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 0926c0770d7a..7c39d706e6d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -33,7 +33,6 @@
 
 #define AMDGPU_RAS_FLAG_INIT_BY_VBIOS		(0x1 << 0)
 #define AMDGPU_RAS_FLAG_INIT_NEED_RESET		(0x1 << 1)
-#define AMDGPU_RAS_FLAG_SKIP_BAD_PAGE_RESV	(0x1 << 2)
 
 enum amdgpu_ras_block {
 	AMDGPU_RAS_BLOCK__UMC = 0,
@@ -513,14 +512,7 @@ static inline int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
-	/*
-	 * Save bad page to eeprom before gpu reset, i2c may be unstable
-	 * in gpu reset.
-	 *
-	 * Also, exclude the case when ras recovery issuer is
-	 * eeprom page write itself.
-	 */
-	if (!(ras->flags & AMDGPU_RAS_FLAG_SKIP_BAD_PAGE_RESV) && in_task())
+	if (in_task())
 		amdgpu_ras_reserve_bad_pages(adev);
 
 	if (atomic_cmpxchg(&ras->in_recovery, 0, 1) == 0)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 695bcfc5c983..c3710c591b55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -479,7 +479,6 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
 	int i, ret = 0;
 	struct i2c_msg *msgs, *msg;
 	unsigned char *buffs, *buff;
-	bool sched_ras_recovery = false;
 	struct eeprom_table_record *record;
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
@@ -517,7 +516,6 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
 			"Saved bad pages(%d) reaches threshold value(%d).\n",
 			control->num_recs + num, ras->bad_page_cnt_threshold);
 		control->tbl_hdr.header = EEPROM_TABLE_HDR_BAD;
-		sched_ras_recovery = true;
 	}
 
 	/* In case of overflow just start from beginning to not lose newest records */
@@ -603,20 +601,6 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
 		__update_tbl_checksum(control, records, num, old_hdr_byte_sum);
 
 		__update_table_header(control, buffs);
-
-		if (sched_ras_recovery) {
-			/*
-			 * Before scheduling ras recovery, assert the related
-			 * flag first, which shall bypass common bad page
-			 * reservation execution in amdgpu_ras_reset_gpu.
-			 */
-			amdgpu_ras_get_context(adev)->flags |=
-				AMDGPU_RAS_FLAG_SKIP_BAD_PAGE_RESV;
-
-			dev_warn(adev->dev, "Conduct ras recovery due to bad "
-				"page threshold reached.\n");
-			amdgpu_ras_reset_gpu(adev);
-		}
 	} else if (!__validate_tbl_checksum(control, records, num)) {
 		DRM_WARN("EEPROM Table checksum mismatch!");
 		/* TODO Uncomment when EEPROM read/write is relliable */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
