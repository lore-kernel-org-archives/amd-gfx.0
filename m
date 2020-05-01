Return-Path: <SRS0=mrdw=6P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAA4C47256
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2020 14:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB0720757
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2020 14:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PjWdiGcR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB0720757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 671086ECB1;
	Fri,  1 May 2020 14:22:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAD1E6ECB1
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 May 2020 14:22:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HV/mEivClfVeNeLsG5ctGjhekps5WfbwFDkb6PM7IMavjBbMNtUfJE72+9mP2fNAgWD7YYyqJfyYDdhqEBAVzu/oSF7Bi6dc3QH/o16XC26O1h9255qsCqlOjhzzbZtFQ53pjgJYEfEalK2jMfgxZSmS7+GZ2J6kvdZnuvX+KiZ31u7VHuIp9+/FHd5AwWd7zWFB96HMz+kEmOovMj6lcClS0K1Yt6kImIr1VJsndE4J56VxSoX3E/D4p4nOEs2XUCuv+f/vBdf1A3Be+tJVrpzxEYwN4Sy5ft1hg5QZoQkew4Z2AT4goc5B1k1n9FHR7I4XX+XolQx1SRU6Bng0Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ckYn1PPSpJ2ci4ws3EOqWdTehBkFTgzGcASRx6EL5o=;
 b=HY/MyDeVITFIaDHxCr4vy2nqTV5FX+mFS9ttgJjwGr+QnmYjudCjAXdWWYRkrdIZEvjhOtEKIOjJCfKO0p/I3LvuZNIUaU89kqcSpx90WeCnX2aCL9g3beJw5J2wvj99rWCABPGPBfMJpxOvqPRXRGHlti+WjtXOnIRX0aW+CRvCu193D2cKJDZWzQJhz4/OrSeZcSzP56gZ+cMV3k9V/WMAAVcxK7gxkRFq9AcruuSokBEEjeV0msj3DcuAXQ71j7WLceq4S6cHUAdAGonmi3YFxqqi9Z0vU8tKsYrOCGNZI9iFJXPpbSOuNrv47SSqlxIZMyCBeaJbMsipP0m22A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ckYn1PPSpJ2ci4ws3EOqWdTehBkFTgzGcASRx6EL5o=;
 b=PjWdiGcRom67XqwX69K0x3IuxslphiwpIDf9+vWDEwLTRqUkx+JpymMT3ivOs/zqdakIisKdeic7cy1BD5NicV5Vh5kJ+jZmRDC+CZJKbmV1i5PyFSsNwosCRtIoy6VQOLfZb4esEAWrlv5OMlJ1i5aq5BDruH+Nq5fVyDD6ICk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2382.namprd12.prod.outlook.com (2603:10b6:802:2e::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Fri, 1 May
 2020 14:21:53 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2937.028; Fri, 1 May 2020
 14:21:53 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: Take a reference to an exported BO
Date: Fri,  1 May 2020 10:21:27 -0400
Message-Id: <20200501142127.14202-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::41) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.54.211) by
 YTXPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Fri, 1 May 2020 14:21:53 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b4f9ed73-4d23-4ec8-c756-08d7eddaff16
X-MS-TrafficTypeDiagnostic: SN1PR12MB2382:
X-Microsoft-Antispam-PRVS: <SN1PR12MB23828D03CCAE7BE35F8C037592AB0@SN1PR12MB2382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-Forefront-PRVS: 0390DB4BDA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99ByhYNWsFgABnUmdzSoKFiLr/yyY8VAqJWIGPQUcHwq9fq4ufcqHA/3WetxVZw8kU6wycGWzAwGyudsIYhnCm3hZbJq2qhWGzyqoVytmykhWGfyOginSlDQSwOryZJT1cN0cfZqzwkkmkoSDdOH1jSHa/emH1flh9dCOdhmvF+9t/uMAs4K9mK9zh1VjW+f4vz0TwxbAEvUTtbzr0TaebRpGWYET2WG4ZIqkVSq8pOocHQwknpW2pLjzZRn1BZ1sWyFSHA0HaHc2EFbM3/gBon+Q7w0TV9FHGWzQ6XsTDuFWZUOzA+I7IaAgy9vt5Y7UnERvsA9clbW9YonLkysztY+hwnjKnWLnfgKxNIeGXGyM+g/adX8L7DU3+jq0dv0Hh6afFYaZVPoLKbO8UmfZtiAUaucJUKeafarH8h/cPpNeN0tgilT0npbDJ4LBu7TjJ1x1WAitrcpmuFUy78fv3HW+G5/aJGJDIIblzHPe7BixIgIQTAWOGfG/yOOBVSR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(66946007)(26005)(186003)(6512007)(16526019)(6486002)(6916009)(316002)(6506007)(52116002)(4326008)(69590400007)(66476007)(66556008)(6666004)(478600001)(1076003)(36756003)(86362001)(5660300002)(8936002)(956004)(2616005)(8676002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: uGM93C5DgkWTGMacKM4IqMuv5xg0w8Wx9aWi9ijb3IQpOq/f4Iz4yMS/yWqYF2yAmiQ9mGeHkq7ps6Msk/jvv+cJaAQf4xf09dAPg8N8nEOlghrXH+waMSSIjoN8RDdLKfCAl8SlfDU9qwdDaVX/03Sfk9uJlQbk9GBl2axhJfEkp7+C7/eyVY1jBuIdM2UK3TkiKG0sBf9Dh+r1Fq9egGcEtq8BkM5K0ozzWnr1gD8Od/YISkRxO3ZoRaGD4Sum6koKLuyJT/ZUYYzfdI32r7jYtEXXdjA1LaQPSjFJ/CVOBnQHAktM2V5zG42p67IpoaI8dx9J+13lKAQ6sxlzMNXRUyukqJ+lOBk2teVuYpDDNd7LzeC8GafdFmE8VQHE3CU3IUXuDnqUCAp8KoKXQV36i+VhSAC3ZkRicuonHyBSOLObff7KsVltt4acjOBaiPcsi9ix55CHSIep5X9wAXNI3XXj6ffXgUDn16981z8+LeSxtY9T89Nx7hoAD+BJ4pjVuPnSdEbKhGIghgXbbZbZ+mjzsjeY8/3M0dZ46dANyt4OGp9AIg2lQ6yjluGTsU0Xy9yicp1CtFtX5PNXeVc9a4xXdd6zwAvlHSqq6QHT/alc6PNjV+eiaOSAHWu9j3NBQG1mXPKJ5csSQ94KCqvrafmNzfz1iQw/o6Fc3IF7Yce0ObiiUvE11/c+pbptgjFPd7ht88PggSvgo4bIjU7ApwMjg+4enuePM8f5lWyfNCOiBGnUIAlPQq4n5Q4Q+x6HUF5GU13sWsdeMgyn2KWXRycm5om74RPavDRY9OM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f9ed73-4d23-4ec8-c756-08d7eddaff16
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 14:21:53.7489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFAFw6u4JQ7qji0XV4JaBdpcpGlDnu70QKPkhLQiqnwpwS7uLAS5QSrcYfDxV2W3OTUOeZMXlqVJNADtvm3Cmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2382
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
Cc: Felix Kuehling <felix.kuehling@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Felix Kuehling <felix.kuehling@gmail.com>

That reference gets dropped when the the dma-buf is freed. Not incrementing
the refcount can lead to use-after-free errors.

Signed-off-by: Felix Kuehling <felix.kuehling@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index ffeb20f11c07..a0f9b3ef4aad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -398,8 +398,15 @@ struct dma_buf *amdgpu_gem_prime_export(struct drm_gem_object *gobj,
 		return ERR_PTR(-EPERM);
 
 	buf = drm_gem_prime_export(gobj, flags);
-	if (!IS_ERR(buf))
+	if (!IS_ERR(buf)) {
 		buf->ops = &amdgpu_dmabuf_ops;
+		/* GEM needs a reference to the underlying object
+		 * that gets dropped when the dma-buf is released,
+		 * through the amdgpu_gem_object_free callback
+		 * from drm_gem_object_put_unlocked.
+		 */
+		amdgpu_bo_ref(bo);
+	}
 
 	return buf;
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
