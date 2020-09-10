Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00979C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 19:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68F3320795
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 19:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Wo9pQ+41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F3320795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B35156E175;
	Thu, 10 Sep 2020 19:07:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B05A46E175
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 19:07:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixwv7PWyqbhzkP1KBdBU5xIATKn5LQo9wFkdMZR08pIOPkBW4VHCZZuBpGI2wrlGkzHajbRx2PH3THZd4lTxUA4+X/Zmr1NP4wLv/bX7ifbO/RuMfnwGA47U4zdUHEN4idadjXuC86AS8+Yx3SnKYUlcpr5dOPdr/WRukcMHljvejkQWbDZh3pS3mMsMGGmrtKm/ra8oawGqEUnlElwr/cSgEfxSZc/Q5ZubY+VsbteRiDk+1nAsVrS+RdRyCAxolLidyDFyGBMogfNEh3PpzvdplttGmp3YKbMkqo5i0M2A3z5tTitBsumYRwRbsLpPHzOS4nQlQndAU2x1yYq8Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEVFinvwEGv8Jucnn0p6cZNXKEusJTQH10WrV7Q1Tvc=;
 b=BjzId+iyNoeH9sOveso0DPJ6f2E685Qp/OsagUIOGVGOLLEWXZoe+caTSvoeTH81JluQR6QNRoSZ4/WSRTqrE36HIkwiBQnWslXRJ3qL+m060Pnb4gdXk4ByqY4GiPV3iTw+WpOsqaa6Dpfv7kaipYH6Jneq0XHCx5XGlzlao+yqQ3qVfpt4dn2sSRZLCWRafqR/cwRv6qrEcfUcthVYTzkGCRvMi0Tn+6Ou5DLDbaLJCD/g8nVKC8knqkY60WVxJONIiG7ZM9E6KWGHZ2l8KDwZRmhoiiq0a1fOaboOSb06I/P2S5qbPPE1KjcDTUID2ITUT7vaFjEwGRoE88lP1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEVFinvwEGv8Jucnn0p6cZNXKEusJTQH10WrV7Q1Tvc=;
 b=Wo9pQ+41EaXiUIaBJKFksRyHed0SdIKfZ9TfXo9JpbyLLQi2nNO8gl1Umk17kCIZbj2adSu+f+FJxaf8Q9he9Uj1B/JGrEdX2grhgs+iR6VcXt1kYQb6z8xJjkmm2YW5Nw1SyWWr9dMP8HxgRDowtcb0TE0kmlD/k+2cFWektZI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2446.namprd12.prod.outlook.com (2603:10b6:802:26::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 19:07:23 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 19:07:23 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdkfd: Use a new capability bit for SRAM ECC
Date: Thu, 10 Sep 2020 15:06:53 -0400
Message-Id: <20200910190653.31339-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0068.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::45) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.211) by
 YTXPR0101CA0068.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 19:07:22 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 91778feb-9d83-4db4-cd38-08d855bcbf90
X-MS-TrafficTypeDiagnostic: SN1PR12MB2446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2446A56E5D64D80D917B59D292270@SN1PR12MB2446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6iBBRArL4oqeKVL+ndxToF3745ve02ity0SE+T2gHWotaUDXMTXge8NvspDk2pjozUu1HwGUax5gbxcHkDyMhjSqTMsPS0X+kmFDWdZA5X3cLp4OatFn+DS9VvuW80RJx0kH6xFEUcJmI+Doso+F51uZB1xFR3dt5RU0kajw+Sj9cSfAX/04vN9SHDBc0Um33p8DA8y2IXJgrQhf9Ld56uuQ2OQ7vzyZWJ71/pDUpCV9GwsaRZQE+nJeJXmMk+26Zc3IAO81f4Xbr5yIC9IqseAXZjcp70oBALU+2dO7GR5B2RTCC8XIsBRKfN+FTzPzgFX9euuKUE0eDFX/fkZiLGoqMG9El0xrDZdDf3F0LA9y3GTuiZ3eOR2F8vEopIT+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(6512007)(5660300002)(52116002)(316002)(1076003)(26005)(6506007)(83380400001)(4326008)(6666004)(956004)(36756003)(8676002)(86362001)(66946007)(66476007)(6486002)(66556008)(6916009)(8936002)(2616005)(478600001)(69590400008)(16526019)(186003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 9IHaHfpF/GFdtOS+I2nfSNvaRVSy83vZskXuJ1jVoVGajTJNWlGvmfL/6rPNrrhm76mkEEc3V724AVIsUxYbiqJnYeU+4lUhjnzcEtlgHRGgCFrtfWc61/nTAes5MimLsaWeumh9/MJcbFmUMXkUoykO7R0+XX/PB/qQ1s3rIUeorFzkqZhlljGmE+fZ8y0vC8lQUu+A2KURXhUps2/01jILA7ixPLu0nJaOOjfk7Upj946WMFRbumRpChDRmNLK4Cl1eW2y+Gt7CApsd/SKVdZl1Wf1iPZ5kgEEDS9PEiR4HD6XkTYl0+d8LTu5LgaTr2q7pxr/4XqUqApBE1WwGuN07D7kWrEboeMBaU86hUVGSbMZTYpjWKiwejova6lHn3JQTIXIj3SMkelWgMEXBpeglstN6AdDIMucS/DdLBzWkuXbWxPuC0sLli7lPipqfntOhFNxpi3yIIOt3MqMmQz4/mx0/xYVoAl8sJFVurJe18Lj43c2vqbiu/wtitbPBTx4eRoTVxG93Kqn05pQVQr5JdLc5xF4W4N6QoU2ygJyllTm1yN2sUXNIM5F5gV5G5WfBqD2Ew5torSVuuQO2VFVQ73D+mZV2hHp/pq8PRqSh3yb+ttQ/ltjBQYh6bFqlZNfouUbI/wYzaxXR4Ygow==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91778feb-9d83-4db4-cd38-08d855bcbf90
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 19:07:23.0714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3Eu76vuFCAitwa+13MnhG2UFSidjaBshNOluPr7HFOoJJU/foMfcflgf/m+lSHlLZgcDpSyMB5ZF0z10NUgvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2446
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
Cc: Stanley.Yang@amd.com, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Existing, buggy user mode breaks when SRAM ECC is correctly reported as
"enabled". To avoid breaking existing user mode, deprecate that bit and
leave it as 0. Define a new bit to report the actual SRAM ECC mode that
new, correct user mode can use in the future.

Fixes: 7ec177bdcfc1 ("drm/amdkfd: fix set kfd node ras properties value")
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index 326d9b26b7aa..690cc561955c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -47,13 +47,14 @@
 #define HSA_CAP_DOORBELL_TYPE_2_0		0x2
 #define HSA_CAP_AQL_QUEUE_DOUBLE_MAP		0x00004000
 
-#define HSA_CAP_SRAM_EDCSUPPORTED		0x00080000
+#define HSA_CAP_RESERVED_WAS_SRAM_EDCSUPPORTED	0x00080000 /* Old buggy user mode depends on this being O */
 #define HSA_CAP_MEM_EDCSUPPORTED		0x00100000
 #define HSA_CAP_RASEVENTNOTIFY			0x00200000
 #define HSA_CAP_ASIC_REVISION_MASK		0x03c00000
 #define HSA_CAP_ASIC_REVISION_SHIFT		22
+#define HSA_CAP_SRAM_EDCSUPPORTED		0x04000000
 
-#define HSA_CAP_RESERVED			0xfc078000
+#define HSA_CAP_RESERVED			0xf80f8000
 
 struct kfd_node_properties {
 	uint64_t hive_id;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
