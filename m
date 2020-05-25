Return-Path: <SRS0=Ro4j=7H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6D1C433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 279C72071C
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aLNjalFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279C72071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 025A389C1B;
	Mon, 25 May 2020 18:13:19 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700047.outbound.protection.outlook.com [40.107.70.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6866A89C18
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2020 18:13:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfqOXeMkjJpNwyGO3vL/DbTjY84NV87zitQOHSUoApwXeBbn4ehxRkrjqDVHqUeCRyaYAtiV51lcrBaMwF2AKZMvWoKoes6GJqqlo27To1r+tCw2S/L5QKO0TNXapLz/EEK7Fk8A7REnVs3YLTFgPp2ODoc4UBmL97hP9o0Pt3LwbVyhfh3rFzl3vSggaYrOkXu0sWWcmr9I2QX/Wj5NB77RNaEnDvXN/ZW/JlbWqQC/MENUbh8yoa2XhVtDs17VrOpkgD58f0CjgZgPTXjjqMfVrFODHCSi+q1XVcZtR9mtqFeVBCVqJlwJtlbaZMF22laXDpfz8+AGF5Shq/e2Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upy1nNsCwo1CBZwX9ol7kHeF4lcEmpzVILKyWFshv2c=;
 b=E75vOv2+KuUkcigU9Bz+fVG605d6IE59QSMBGLPnUBQhLSMKO4BW2yW96HVlRByWTfRqohxeZfHYecu3l4kO0mzMZwoCWrzemmSh9mvytozNUU4yobMUwTauf+CRysN5RBehBDtQzrTBR1V4R+ymOi2YoM2dYTNZfzuoEoxZVph+kjU4RjMbzFZQtD+UB9XOYu+Of8LXKWZlXDepJGKccTo/N08HXd1/81QllJ1BEAgfTa2g15GTmUvIR4VG5vjehaDOD2E9nFRSjnEHy+Bkvxtd1DFxX2s4fTmTyupCiFIWLg1xZ2z5p7qtG6JGPOICeGkf00ReVmss3uNVi1Dd9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upy1nNsCwo1CBZwX9ol7kHeF4lcEmpzVILKyWFshv2c=;
 b=aLNjalFgvuETRC1MEy6KtVK3V6R0npNczh7yY249oFsQUjDhPYaLq/NUvaPUP2lZf/yjwjGkYDDMGX0GMXjBuhNSiMAXMNkeV5epMFk4D5MS3VyoM2/oJWYNhW+13bbiDniieUzBJvbxrWAEnLDGGpfV52FlZyu2rv0chUAeKgY=
Received: from MWHPR15CA0058.namprd15.prod.outlook.com (2603:10b6:301:4c::20)
 by DM6PR12MB3004.namprd12.prod.outlook.com (2603:10b6:5:11b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.26; Mon, 25 May
 2020 18:13:13 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::74) by MWHPR15CA0058.outlook.office365.com
 (2603:10b6:301:4c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Mon, 25 May 2020 18:13:13 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 18:13:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 May
 2020 13:13:10 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 May
 2020 13:13:09 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 25 May 2020 13:13:09 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/16] drm/amd/display: simplify dml log2 function
Date: Mon, 25 May 2020 14:12:54 -0400
Message-ID: <20200525181306.3749-5-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525181306.3749-1-qingqing.zhuo@amd.com>
References: <20200525181306.3749-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(46966005)(2616005)(44832011)(6916009)(336012)(426003)(478600001)(36756003)(26005)(186003)(86362001)(356005)(1076003)(82310400002)(70206006)(70586007)(82740400003)(47076004)(81166007)(8676002)(54906003)(5660300002)(2906002)(4326008)(8936002)(316002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53d80937-5a31-455e-ae66-08d800d749d5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3004:
X-Microsoft-Antispam-PRVS: <DM6PR12MB300492760D7CF397941CD1EAFBB30@DM6PR12MB3004.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F9eawCcHRSmX9O28UVbrIpTfqZXP0/xSEGf6Zjdm2xE34rzgmDmT10mbT8s+4CGEXBAIE1+HHd4+pzwqg85eP+OuUYlW8f3oRNGE1wbTHP03HsMLUDsxI5O7UzDQunt4lPeG1V0QRZgyvaWVmpR9yb4iA3doOpY7csynOEx+SMPs6dKyDrzxKOyMyHAIANNDTsG8GmoBfWtbSsTwliE23MFWXx5j2Gc+naiHNftrcs8nu7Lp8AgfdBJb74/FWnddC65e1HN1PvT6TBI6QvBt2+r/bcPlDxm06tG7Gw+oyMbRQ0KWVggSNDBhN9lZEK+5uEuiXNCzuKJ4D4JfiS63c7eiMU/lygMcN8z05I6dynA4GhpnXen5hE5tJJtP2jMpS+YR0p7lmWSwY0xsWHU47g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 18:13:12.8045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d80937-5a31-455e-ae66-08d800d749d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3004
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Current implementation is slightly inaccurate and will often
result in truncation/floor operation decrementing an exact
integer output by 1.

Only rounded down output is ever expected, just extract the fp
exponent for this to increase performance and avoid any
truncation issues.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Eric Bernstein <Eric.Bernstein@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../drm/amd/display/dc/dml/dml_inline_defs.h  | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h b/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
index ab0870e2a103..479d7d83220c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
@@ -86,9 +86,20 @@ static inline double dml_round(double a)
 		return floor;
 }
 
-static inline double dml_log2(double x)
+/* float
+static inline int dml_log2(float x)
 {
-	return (double) dcn_bw_log(x, 2);
+	unsigned int ix = *((unsigned int *)&x);
+
+	return (int)((ix >> 23) & 0xff) - 127;
+}*/
+
+/* double */
+static inline int dml_log2(double x)
+{
+	unsigned long long ix = *((unsigned long long *)&x);
+
+	return (int)((ix >> 52) & 0x7ff) - 1023;
 }
 
 static inline double dml_pow(double a, int exp)
@@ -116,11 +127,6 @@ static inline double dml_floor_ex(double x, double granularity)
 	return (double) dcn_bw_floor2(x, granularity);
 }
 
-static inline double dml_log(double x, double base)
-{
-	return (double) dcn_bw_log(x, base);
-}
-
 static inline unsigned int dml_round_to_multiple(unsigned int num,
 						 unsigned int multiple,
 						 unsigned char up)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
