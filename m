Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F18AC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:57:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 060B720663
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="e9KgAvCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060B720663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB4176E439;
	Wed, 29 Jul 2020 02:57:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC26B6E435
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 02:57:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQc0tDD2JQXQx3MlaUfOuK9u/WIiVnPT3drDzX3f6Dleb4TlWZQrTuJQxL6doJ4b730Tt41VpuvmtV+vZtXpTf27P1dNXTkdZMFGHdJA33bMc2tKQLxt499MbCsrxA59+gL/9Im20FGtWmQ2RqlZBNvGA6QBstOzmniY13YfwKmTYP2X9lp/ZDlY8L3BIVwSyrsiUZA0jhnzsYewP7BVTI9KJvK+xgK4BvsaxGk3410Fv+aJlYK9PZfA2YaPxVP4wYtK+1Gygx21wRwDICa5ffDIoJAPqyvuRpXRiM5Qeodj+pmxHWQhZ3hG8TfsgUBTqzUt0yiCoZZIiI82ydS4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpAZ0RPpkXbNZvxnHFkZJ63Sm7xKk2M0P80eNSkbfZk=;
 b=WcRHRd6BXd2aCJHbP+JT2K/MfRsgFs+UzQj8ZMBJCV93hdO1goJrQWYMYQIdRkP73r9MuMyutdB1j9LxpKJc+FiYUDO0hvE5FIGC2/wshGZHGGVUn8X6RutDCr3Fp3+0p/6jMm4Ra/uw/lK19tIj208ZURmf+jfaaGyl7cBBH+snG7k8Apzgsi5YTFe8Ytzx+kjVhN3TITZ4yDEvbH3NwcuAlgyS8O4YbOjOuie9r3N70glBZWr/MwzDYmp1LOM7avGfOjlRW4yqUTfW4KwX9qt44UB4S9g2aDQR1rQRvBG4A5vyOqIyB38gHe9NmcXiq3xMX1WhbrVLjPIkdcGXQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpAZ0RPpkXbNZvxnHFkZJ63Sm7xKk2M0P80eNSkbfZk=;
 b=e9KgAvCV+bHeoEX9Pm8xXvEFdrBdESF/r2LgOMctYPq4+/V3DGr0YiKfHEpKO9FFTjLdnXdlHBO0Jq/xMx+DRMuAlQ5/bBm87ynpFWXfDRsFLf/KZGdxY0TB8yYg6e2IS3U5UKVyGt1wsQm6QeFD1ZKEn6NxnXZwzPNJ15Qf8k0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1285.namprd12.prod.outlook.com (2603:10b6:903:3e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Wed, 29 Jul
 2020 02:57:08 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Wed, 29 Jul
 2020 02:57:08 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, andrey.grodzovsky@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com
Subject: [PATCH 05/12] drm/amdgpu: skip bad page reservation once issuing from
 eeprom write
Date: Wed, 29 Jul 2020 10:56:22 +0800
Message-Id: <20200729025629.19355-6-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729025629.19355-1-guchun.chen@amd.com>
References: <20200729025629.19355-1-guchun.chen@amd.com>
X-ClientProxiedBy: HK0PR01CA0066.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::30) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK0PR01CA0066.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Wed, 29 Jul 2020 02:57:05 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb05eb6c-8aa3-4abf-0c08-08d8336b1517
X-MS-TrafficTypeDiagnostic: CY4PR12MB1285:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1285E843748F86E0B7CDE43AF1700@CY4PR12MB1285.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sQaBGgqxW+qONsYoh09F3hI6rMwRSszJxvYrXnBCdiPtLBJrVCmhRzAPs0WOKSy8U4uSuWtUl6C6gA97vs/ZMb+czSm/3Ksosbm8uBmbh/vEz9dgcEGZ5tXsSwzafKN3nYzg929ssI8fLcxkPm1hFEsIors21zmJYQPXCrYG7lz+vXPYO9oisoERfmMDBegu7UPvr/KOQjj9Dh4nzPVu7flSAF8/lYwh4OTJ1H0U+ivo5pIOzaDwnQ27qQo7RTLGsgcwxT7AnUqADbXW/thnxtsXGNfKaGLx5dUwB6iYgwxVV/KXv2p3zApJoOPEeHwMv04Ba1C0/BpKmk3CouW7nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(26005)(2906002)(66946007)(6636002)(52116002)(66556008)(8676002)(86362001)(66476007)(186003)(7696005)(16526019)(6666004)(44832011)(36756003)(5660300002)(4326008)(1076003)(316002)(8936002)(956004)(83380400001)(6486002)(478600001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: KK/G7fcGkC/83a0PuyEzV1f6HqubziNnzgCiX2tYX2WsdK95BefEgfMJjrmWeExyAstVjYQhAhU1p08/kut6o6PhE1MI+toPXjrRVvNHfM/stwfYBe5fDvCKRVAyz0zn1c1L6ZX+/UoPBM9DuB6SWdJOyk72ruaIatM6bRhxF1sPde97xzg+wfrTbl390WqhoBGBNFyV7wmf2bfKe0QrcAQA7SCBiXBJHH9oyB6w8OyM7O429rBLWyMEZ5B9cVlpIprDQjCJV8ijtpuNxMDJFhWDiTRAsdRWMKn7hmoIju9XP+B5UB4XwPvcB1yIudf2lvSsjrpFmkMbaDse9hTuRQNzY+cydUYk9wYiqx7nuBn+DYpxfNxaLBbp7C38gTdd7EWiKCpbJxTDdAt+SEXFJV8Mflm80em6VsM3TeTfpm3UKD86GDBr80X+ifcSXgBeBKg/uF3aB/hNvuU8ROVF8rRQZXH1pURUZDoLoWxIc7lLqiSuJARsTC0NYfhssQYf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb05eb6c-8aa3-4abf-0c08-08d8336b1517
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 02:57:08.3793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0e4xo+sk0I3wqh7EKEqfgcoM3KOsQ91rVRJcpUgJSPx6HzsMJy7aRIef6RxhdUalfkgjsfpQukyEA+gkOSORw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1285
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Once the ras recovery is issued from eeprom write itself,
bad page reservation should be ignored, otherwise, recursive
calling of writting to eeprom would happen.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 14 +++++++++++---
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 67d9d65b069e..64ae0742f385 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -62,8 +62,6 @@ const char *ras_block_string[] = {
 #define ras_err_str(i) (ras_error_string[ffs(i)])
 #define ras_block_str(i) (ras_block_string[i])
 
-#define AMDGPU_RAS_FLAG_INIT_BY_VBIOS		1
-#define AMDGPU_RAS_FLAG_INIT_NEED_RESET		2
 #define RAS_DEFAULT_FLAGS (AMDGPU_RAS_FLAG_INIT_BY_VBIOS)
 
 /* inject address is 52 bits */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 4672649a9293..cf9f60202334 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -31,6 +31,10 @@
 #include "ta_ras_if.h"
 #include "amdgpu_ras_eeprom.h"
 
+#define AMDGPU_RAS_FLAG_INIT_BY_VBIOS		(0x1 << 0)
+#define AMDGPU_RAS_FLAG_INIT_NEED_RESET		(0x1 << 1)
+#define AMDGPU_RAS_FLAG_SKIP_BAD_PAGE_RESV	(0x1 << 2)
+
 enum amdgpu_ras_block {
 	AMDGPU_RAS_BLOCK__UMC = 0,
 	AMDGPU_RAS_BLOCK__SDMA,
@@ -503,10 +507,14 @@ static inline int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
-	/* save bad page to eeprom before gpu reset,
-	 * i2c may be unstable in gpu reset
+	/*
+	 * Save bad page to eeprom before gpu reset, i2c may be unstable
+	 * in gpu reset.
+	 *
+	 * Also, exclude the case when ras recovery issuer is
+	 * eeprom page write itself.
 	 */
-	if (in_task())
+	if (!(ras->flags & AMDGPU_RAS_FLAG_SKIP_BAD_PAGE_RESV) && in_task())
 		amdgpu_ras_reserve_bad_pages(adev);
 
 	if (atomic_cmpxchg(&ras->in_recovery, 0, 1) == 0)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
