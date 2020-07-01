Return-Path: <SRS0=Kf1d=AM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC172C433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2020 02:34:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D5B52073E
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2020 02:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LS//Au/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5B52073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 443306E39E;
	Wed,  1 Jul 2020 02:34:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9816B6E39E
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2020 02:33:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwcehtA8dMcH9zPuo0Aw/tkiKjnwCye7Np0eez5N1JyZ9FIrW/P9eUg10hfuhAcXRAK2Q61hpD6U1uu1f56eN2F0neLHiiG6eFE6+klgHiNe2j0CKNbrxreePNb5EXJLDzqttkCkNZ1ahQ9mMwutz5jheIRz4HlmlN4eO+OcP11G0Q/IdWwV30kVtaLvEAuuuo/I3dgbjmYI19WwgtCgefVA2JtZOcUywDs7jVEwTiCucia37FMj9LErIX7JQT+qzhuWZbzgTsyS58tCjwUeYMnWj88lqIa/60onH3XByZLBklt9Y0tSF4N7jHgROO0Vifp9sAi/HugqDwFHRPmjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/GYD23x9vghzjtULyph4Xf7UpKbjUflnmy71U3A4rQ=;
 b=j4kU2IWBRUgWxjGNp2+QH1dsGd+Xwf4BFPaxZ/AhrMVJ6TSGONW+ld6uvgjwyE4Oo8fZv2hV4cCeCpQcv+nCqqdBqeURCXeMkCYGLOWEJuJbqtAPkj7VfQB2KMAG9MTN43/GrPSmkhP7achr5hgh/m6frXFsA4/VcuCdJdQUi6pxGk7nkKJMS0CjnKhSfcWiAoLZGg3MRF0hBxB+9U/ToibOZaKwi/UnNDLiEYfIh+vZocB95oKoJ0YN0eA/73iVfuxfV3yLZ7AnSYgPfswyHKH37mIxk0EeLp8gcGeywLx7HzqQcH7cKdpUfl5+Nh1PQ0urCWp7ZXXI02lUD9/rBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/GYD23x9vghzjtULyph4Xf7UpKbjUflnmy71U3A4rQ=;
 b=LS//Au/WzHwK9+9+t3T18ig9Px+gL1+S255DghrEX9Sv3DOm+mCLmA2O+nZW29JKCcb+oeeDTbBUjfJyzeEJPful5xLI5ZyDR4JJKeXYSpEbmQmm8e8r0uS2SEAXc9l3uykvXwLbzNfsZY/5q0J2zM2MXxXLe6QLNZaFTziCih4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4590.namprd12.prod.outlook.com (2603:10b6:806:93::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 1 Jul
 2020 02:33:58 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3131.028; Wed, 1 Jul 2020
 02:33:58 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdkfd: Remove redundand kfd2kgd interface lookup
Date: Tue, 30 Jun 2020 22:33:30 -0400
Message-Id: <20200701023330.23118-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::17) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.54.211) by
 YTXPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Wed, 1 Jul 2020 02:33:57 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f87a3941-221c-4b42-2775-08d81d6734d6
X-MS-TrafficTypeDiagnostic: SA0PR12MB4590:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4590CA58B151E0D2E1AD37B2926C0@SA0PR12MB4590.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I5c0Akuoj0WCLia+cjuKxant6r5BYYOs+Ki8JDvgS1ceqs9WvLJnjDxx7IBoy2G10qAF2Ydfn4dHceToSIOncVpgqry2d8MivAuo2H95L7bQk9Rzlr9KbeCai+xO/aa80oPhO582rvlJDCh3YHO2Dkqeii3h9pPmTSEa6a7o+gcc+991rVuliz4xESLOSYWvOOCnBi/tFbpxQSg8Qg0iLlbW8l93D9CD1T1z5+iJ9i6ZNZrzHhSCjhEyyeZNokoMoTFSFgSB5tcUSZMp8jP0xPMvkORAJA6rn/pCJiDdq2qMQ9jaVd4bqgLBNyehL55pMT5rqV8IAyKNrqxMfJ6su/NNiuUVoJw01RfCZ9dMz3TK3Lf9mPIC4fLLeKpoZeG8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(186003)(52116002)(316002)(83380400001)(16526019)(6486002)(6916009)(26005)(478600001)(86362001)(2906002)(69590400007)(66476007)(66556008)(66946007)(2616005)(956004)(36756003)(1076003)(6506007)(5660300002)(8676002)(6512007)(8936002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ujTwe8rWj8k6+BvBoOPRr9u1EuHjgEhyA8tEgraYVDrpr/RFI60xkdBbgiPzzKdmJ/rA2OSfGmp88IsMVMlAksTZ6YIr3HIAJV2uNCy5PafMNue+aRmYi8lxhiNYsYHnnXQ50Sbzw+xsZ+BXda7zZ34CFEpuTjyi1gSC0auIzBKcoaktDwl8ugVIOvaWhGgItXXxvKf835K9Sp41b7aNjylKDVwvkivVQucPNXqULxlDdhPkHqGr3jEp5cQA3jxVw2Al7TxfCHQ6n19Akiy1ORcI6jnzxM0Cs1lZCtFgkmdfcUIIPGfjNr82snrls4OSPjNWXHfj3D3hKJaKQC/sxPjvDOayXoULIUqgIqrMJVUuzu7aKkZZIzdQD3Xqe6J8AuHBpmStwH5hE7WYdCtwjDbeCKcTeoZ6qVS1GDDvYFZS2jfjnOqxzLgb0K1dFhf5pC6cuxmerIqldqNqVrSmEbKGtOWwBCbTWOPHyftGck0KEpb7G4hdnrbjUIJBPu9l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f87a3941-221c-4b42-2775-08d81d6734d6
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 02:33:58.0460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kT34TlZgRkLYE2FII+HKmjH5tVrFy+ECXbXZvyRYfYkwrHGPXsNXxkXy3AwWQ3Ed0Q5jCKzeqZPjJA7MER2B1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4590
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

kfd_pasid.c isn't using the kfd2kgd interface any more. Remove redundant
code trying to look up a device for finding that interface.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pasid.c | 31 +++++++-------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c b/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c
index 33b08ff00b50..2a07c4f2cd0d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c
@@ -25,7 +25,7 @@
 #include "amdgpu_ids.h"
 
 static unsigned int pasid_bits = 16;
-static const struct kfd2kgd_calls *kfd2kgd;
+static bool pasids_allocated; /* = false */
 
 bool kfd_set_pasid_limit(unsigned int new_limit)
 {
@@ -33,7 +33,7 @@ bool kfd_set_pasid_limit(unsigned int new_limit)
 		return false;
 
 	if (new_limit < (1U << pasid_bits)) {
-		if (kfd2kgd)
+		if (pasids_allocated)
 			/* We've already allocated user PASIDs, too late to
 			 * change the limit
 			 */
@@ -53,32 +53,17 @@ unsigned int kfd_get_pasid_limit(void)
 
 unsigned int kfd_pasid_alloc(void)
 {
-	int r;
+	int r = amdgpu_pasid_alloc(pasid_bits);
 
-	/* Find the first best KFD device for calling KGD */
-	if (!kfd2kgd) {
-		struct kfd_dev *dev = NULL;
-		unsigned int i = 0;
-
-		while ((kfd_topology_enum_kfd_devices(i, &dev)) == 0) {
-			if (dev && dev->kfd2kgd) {
-				kfd2kgd = dev->kfd2kgd;
-				break;
-			}
-			i++;
-		}
-
-		if (!kfd2kgd)
-			return false;
+	if (r > 0) {
+		pasids_allocated = true;
+		return r;
 	}
 
-	r = amdgpu_pasid_alloc(pasid_bits);
-
-	return r > 0 ? r : 0;
+	return 0;
 }
 
 void kfd_pasid_free(unsigned int pasid)
 {
-	if (kfd2kgd)
-		amdgpu_pasid_free(pasid);
+	amdgpu_pasid_free(pasid);
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
