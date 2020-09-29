Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC007C4727F
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 11:31:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68F5623E53
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 11:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2DeB/Hw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F5623E53
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 044F26E19C;
	Tue, 29 Sep 2020 11:31:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D56C6E19C
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 11:31:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQZAHFIjOjiVXpLSUyUv11A+xQjnGu2f2wd2AdcYcsSXC1I3FI3yMBgyOsQoJdeDq4Pi1L4R/A+N05sn45JZQipjc+P/+C6zJY0yjSa5oYD5mZq19cy1GrtyVdQCqe+lh+2N9/aIbQSATiu0sSMg7CkIdd8MyThHjSKfRVshTBC6U7tTZvRe/HWEBO0iWbV/zjG7Ubjcm8Cxa1+hRC7DorLRPMAoNWTnm7DHyrR1mXDjL/kF2pRD//oUYuwUhoz3ZeO5dj7xfqkUDTEtFhopj19jk7KpJNTvHGMU7qcYyC71eCuoW0Wg8Pgv8SsN8+68p68l108hzHoIMGM1CWgktw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLt55UJWV+N8pegshXZl9fscAhuZBUwIqBMrUn9cc2A=;
 b=c4LpsZKJbWl3R4n3xg5tTUAa6n24d1CR9jhW3JyQnREqlGnZPcjrS+ZxFiueet1cONkOsMts9Sd7PAJIirbL/aJI6U90ilJcusANN/e7q4QYPzVPt9whQ7yfCAhccWXifQMF60nKXedNdWWX/e2rIQFC7H/BZ/ZjpRMntZeEmay6KAEKkNpKog9WyE9Delrbq3mJK8b6U1kE5SN0Dczt6MVUKOpxn/61xqewW53Gi2qDl5kc4aK3ECv62kmU3ERweMoeefwpArzTkkMWr2lupwxWxcZZUrE1Y196CTmww/gRTzF7pTnVBhl4V2lf8zDLFi/QVkY7c2fXw0v/eKjcKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLt55UJWV+N8pegshXZl9fscAhuZBUwIqBMrUn9cc2A=;
 b=2DeB/Hw1qjJ+AyMYVD9TgoqgxZnq8CMO4NrrWgfC7qHsNPquFD3F5yhhx387DmdhFNAWWQGwyn+K9kJD0qtZCRhSX78xrdLKZ7NnH9Y3nqtz1XHB/KC64imnt3hSFUZVTKixeMHkJdrkRmgncEIb0JdwJMM9iBhmDlXtsOe6ROw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB3724.namprd12.prod.outlook.com (2603:10b6:5:1c9::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 29 Sep
 2020 11:31:54 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1%4]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 11:31:54 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Use SKU instead of DID for FRU check
Date: Tue, 29 Sep 2020 07:31:39 -0400
Message-Id: <20200929113139.5069-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::17) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YT1PR01CA0108.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32 via Frontend Transport; Tue, 29 Sep 2020 11:31:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 537fd0e4-040a-4d0f-1077-08d8646b4422
X-MS-TrafficTypeDiagnostic: DM6PR12MB3724:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3724F89D7CEE076F37DE95AF85320@DM6PR12MB3724.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CTu5U4SLdhtFs4n53bYFXmVcofeqk+Wvg8/qlCS0jiFxIZIlV4ThTXkm3v+mSXrVEafaz9hzRsRduTLN9tkyk7lUmdkMxt1EB1YN0rnRpjIxrGwRxxG21yHM7SS4EzQeXCCZ5oXoMN0aSnMxuexlQunq+QM/pCePKmn/lMYTRuUoBUscwcvUgcUgPu9IVWkP3nzukGCDKaGFG9m2RvSsDdYMmj6HwmVn+K3cjdVFOvdlgBDXLe4PxeB5PZJejAHg1Af0cpJGfjPs1XnfOoKZM0oeClpd+EpF0Rf4fhi228gXEC2VWHgMRuBG45wZD4r8a3Id6QMlev4gW8iuCFXXag==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(316002)(44832011)(186003)(26005)(16526019)(6666004)(83380400001)(7696005)(52116002)(2906002)(1076003)(956004)(478600001)(2616005)(4326008)(6916009)(86362001)(36756003)(8676002)(5660300002)(6486002)(8936002)(66556008)(66476007)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: M6k/mFTU227aCxRIiz8yhSGFPVAgZ4CWdIfkYHv+vV+Bn/0AnkYa/RC49mzaJG79+RcIktoVkzcFoF6UlnyFr3lK0RqCoLQy4VnjkHaEs4lzePTSScfh+gLkzWOwOcyms8aHSAsHt9t+lskdSR1lDmwvsyfxLA3WZcRjr9n+/CPms35xp2DxiMMqniQe0StRFPXoyXP5/ZsFPNVFv/YvWoCzM0+ApqWw8gZC2Jr0FiTDtGLF/pBMEr+m4EVEfWumulimEaFUx8X0Ng40GF1IVayPy7n12QJk0mBAQ4xAs6xJYVLLWFQchhhJhybCxWhp3J4JfKu2Ut7d1+OKmGjDHJ/b/ObjTkPrOTyA/QLCahMN/Jky2hrWN2I/OwnuZVxoCe5VXJ+9BokoU5m7PUwXoa4G0OmUdh4uiQ2XMeAymVbdGm2ZmVSIcbdpzYaVnlohHc07vtzSF4tTdVMVMt3am9mZRCxCUrJlpf/exTWBoqnGeWLjbY/fE/BC/a1GGalAtaSJUStCg6oFSiRqDDtL56HtPbylth3hzinWYgJA5/4k7uC7jaf7i1TWHuc4IpUb6HoaBJkKU24Mx4RLQsfg0SOpsL3c9T+rUvt2/fVPBjbGESUemO63H/dlpIJ/wyDGGDse6w/JObbAZifg31/NEA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 537fd0e4-040a-4d0f-1077-08d8646b4422
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 11:31:54.1995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfVSSLgEzX0T9xdAydcCG4nNzGRzCV3yp43mBUh1ywLU0C1tUMd3Zsizk4JP8vxFTz5xZArtKnd4b02IZkzvWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3724
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The VG20 DIDs 66a0, 66a1 and 66a4 are used for various SKUs that may or may
not have the FRU EEPROM on it. Parse the VBIOS to check for server SKU
variants (D131 or D134) until a more general solution can be determined.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 37 +++++++++++++------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index e811fecc540f..82207b758800 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -34,18 +34,33 @@
 
 static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 {
-	/* TODO: Gaming SKUs don't have the FRU EEPROM.
-	 * Use this hack to address hangs on modprobe on gaming SKUs
-	 * until a proper solution can be implemented by only supporting
-	 * the explicit chip IDs for VG20 Server cards
-	 *
-	 * TODO: Add list of supported Arcturus DIDs once confirmed
+	/* TODO: See if we can figure this out dynamically instead of
+	 * having to parse VBIOS versions.
 	 */
-	if ((adev->asic_type == CHIP_VEGA20 && adev->pdev->device == 0x66a0) ||
-	    (adev->asic_type == CHIP_VEGA20 && adev->pdev->device == 0x66a1) ||
-	    (adev->asic_type == CHIP_VEGA20 && adev->pdev->device == 0x66a4))
-		return true;
-	return false;
+	struct atom_context *atom_ctx = adev->mode_info.atom_context;
+	char model[3];
+	int modelnum;
+
+	/* VBIOS is of the format ###-DXXXXYY-XX. We only want the first
+	 * 3 digits after the D, and if we convert it to a hex integer,
+	 * we can use switch for ease/speed/readability and potential
+	 * expandability if required
+	 */
+	strncpy(model, atom_ctx->vbios_version + 5, 3);
+	modelnum = strtoul(model, NULL, 16);
+	switch (adev->asic_type) {
+	case CHIP_VEGA20:
+		switch (modelnum) {
+		/* These are the server VG20 SKUs */
+		case 0x161:
+		case 0x163:
+			return true;
+		default:
+			return false;
+		}
+	default:
+		return false;
+	}
 }
 
 static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
