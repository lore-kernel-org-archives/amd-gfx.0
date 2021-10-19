Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EADC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 03:22:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C18F361260
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 03:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C18F361260
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 633AC6E123;
	Tue, 19 Oct 2021 03:22:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EE716E123
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 03:22:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2+PdOUOLofqa3DLDCgs+lOC+6GAgQbyhhUtFdRQMc8VdBbRHMuhreLYJuJG3snlto2ITHYW1sJCQ3cktJHJwTGoTkgt25we2sSC4YPUOUxoiUx1I/JrkasGcvJKeR/WPELzWdq0fFXDokFeFKRTgdlCneJrUDfAlblJLaI7m7MpSagWz3Qzjqigbp84j6b7iFUAFTaU7DFlvITYqZwX8pmODssE787DnTFMSH+qFb8zKJMNBPPHi4SpUOU/MSxag2GrPUPOuwMZ8HZX+5c0ZrgCI2B3doJwMxbNm/6AzWyYjdQVe/2TwnbeBJSn4HtZiZ8LxJIKZpDj8Hz+dDvlCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxlY33me9g3CrQPwjBtjy3mfegTvYJI7hmq4AV23m+s=;
 b=TYb+MddwJaeRupQvmtKHsPYCHASnrUvTJ0HKY1+i73017Pc5J5RabmOmuv46K3tduQEUmWUPVgTtJZlK7O4DXeb4gZ+sIU4CnGYUV0FKq27oHVjRLvTn5PD8+R67jppy5ukpx3rexvtFksxGYKDGwlofiAerfGUues0mbMveKYZPItMWADtVU3DoH/Qihum+6ryV/wgcfqyMG01Y0F82CrsSH/NQ1Fd7+uDyKBN6rGUYzPMyYUZZwRHKl5LIO6ULQ6VDt1WsPMYYprgAAJVLJcyWnttC7Pif4QgMy1AL+6pqSOLKYDWSaqoCxw1TZ/lYzO7OqsmRjG8G168OMFJYkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxlY33me9g3CrQPwjBtjy3mfegTvYJI7hmq4AV23m+s=;
 b=gmY+C07r9p+TH3ZqAbst6h9r/nZZzdp9EbPZlGdGoOHPvwqKjk1fu+FnGMEsSrS9nQgtNs+4QnpqXHC0QNrQc3kxI58qSW+V6MJ/Ejmtak7chDBcgcFAEhQLkajT4LsRL53v6qXfLoZhBJ+Aiq1RsZB55PQMW3km8sR36u4wBcs=
Received: from MW4PR04CA0109.namprd04.prod.outlook.com (2603:10b6:303:83::24)
 by BN6PR12MB1219.namprd12.prod.outlook.com (2603:10b6:404:1c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 03:22:53 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83::4) by MW4PR04CA0109.outlook.office365.com
 (2603:10b6:303:83::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18 via Frontend
 Transport; Tue, 19 Oct 2021 03:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 03:22:49 +0000
Received: from aaliu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 18 Oct
 2021 22:22:46 -0500
From: Aaron Liu <aaron.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Ray.Huang@amd.com>, Aaron Liu
 <aaron.liu@amd.com>
Subject: [PATCH] drm/amdgpu: support B0&B1 external revision id for yellow carp
Date: Tue, 19 Oct 2021 11:22:32 +0800
Message-ID: <20211019032232.2202316-1-aaron.liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0176a58c-32a0-4b40-c75e-08d992afba6d
X-MS-TrafficTypeDiagnostic: BN6PR12MB1219:
X-Microsoft-Antispam-PRVS: <BN6PR12MB121901C2C361192C5345CD5CF0BD9@BN6PR12MB1219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kEgkddcYoiRfbOs7M6OAsr0MZFX/5yeBq92zU/2pwu8mtqkmzo5Edy8GZ/unpTxwpCCCNeXzVoZ3YCUTtaUKTKrATeJfbutYe8Fq6o2gNwrHHStmn+0GieBvqLhXkXbZPegWHjK4PEuy/FQgmNY30OMVjCy6i3DdDjYBd2wJXW6dn0wF3NQfdIW/gubStgDTSyIrX70Epf0fdv7eIGqVutJOgJ8JRB/iEQGNbXNGZdErajDTko+TC5zwa2Gmb90vvI3Pj1ogA3FpE21YTKew0ZSNXuR9UHCTafVlq6UKHVO/v2m/RUmbKPTmAMw7NToCL09/SCbkt3AO8/0xpkclsWDjrhJ4Ku8aTv9WNoy2gB2fhp3/0peDDygiwdQeLSK4imXbBcsPv7gXONxjvXDDcwunfqwO+pX6YJTPta9uTd6gKF8mMcbvGAvrcegxx6ji7ctATKDNcalgQoIWQOhLAU8rXOxFZFXZm0ZLRH5sHseDIm9XRGglb2+jGOWrQZaX5UrqbigQTbd+psVpK77s4xQVZ4jMZihM6inx4lNGbsdm99SkjuykoO4lg3hRZMAH64eMxTbpI41TAXhs6KwHciv6d9S6UBqQjvCvpftIpY649ri8V/34WyFRjUAMfuTcHGbdfmmU0/3SfXHIa7uiiHpv/t1AxVQsD04huNWhkJ3+InXXBQrxutZLh1aC+oHjtSSDwXjkiColGkJEXrBS8k05HyzF9sXn8tbtixbwyHU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(4744005)(356005)(86362001)(186003)(44832011)(5660300002)(426003)(16526019)(81166007)(82310400003)(8676002)(4326008)(47076005)(6916009)(83380400001)(336012)(316002)(36860700001)(26005)(2906002)(8936002)(7696005)(6666004)(508600001)(70586007)(70206006)(2616005)(54906003)(1076003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 03:22:49.2845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0176a58c-32a0-4b40-c75e-08d992afba6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1219
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

B0 internal rev_id is 0x01, B1 internal rev_id is 0x02.
The external rev_id for B0 and B1 is 0x20.
The original expression is not suitable for B1.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 898e688be63c..5166a1573e7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1248,7 +1248,7 @@ static int nv_common_early_init(void *handle)
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG;
 		if (adev->pdev->device == 0x1681)
-			adev->external_rev_id = adev->rev_id + 0x19;
+			adev->external_rev_id = 0x20;
 		else
 			adev->external_rev_id = adev->rev_id + 0x01;
 		break;
-- 
2.25.1

