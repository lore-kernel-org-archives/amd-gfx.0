Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B54CC47254
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 00:59:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3A01206E6
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 00:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uRCpOdB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A01206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 703546E81B;
	Wed,  6 May 2020 00:59:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFC3C6E81B
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 00:59:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuoQw+FT7ErTkyZX1kNU8uieCfQqMwGkBLTT2oL1DvNZe090IW4IaF5pG99bEor6M0RaaS8XSfBUETXTLuUgIgPPlw6QhL/z43c0wxtduDyw8Pm0SXcHj3JgZy4GM4Iz/9V1dyW98aKORCZPtqsE1+VrF/40fOCHkJ0H1T+jPuBWs4JOuwxIqXJ+KUE0ajVp8vRboN778f27HnDDxbiWfAF3+twXdg+zOkGiIAGLnOCyC2lM2Y31mBjdrefqVZ+Ax/BxX/wCawDO/0nVMt/lg1rvHR+zNTQUgDUQgBfc39sMRH87tueXqtkRDJav40mOZrliLrVErVoPt76387lA+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bj7meatZNKHbGyO6Xw6V0wJUfzyUeI/wnWsKauRF4co=;
 b=Z+LYGSu6BISfvlubzZOAwEqND/3BSZ7bIp885DmiPRbijU3vMv1X1fvzNdUJdCfbAPyOg3hP2ANRoQ10MEFhONiE82YW1l55fO97it+wK9CrnVwnZSekb0wydUH5nUl7JHogKu9n5beITEJxQmYvZSfGfwBiNKXPTSRQNbf/FOF35MB5IDSMyS3kuzhza3FWAmpWfeAanjwIbRNiowlmy+3hKnZs9/er9KJE65ddK+sfUrDzIzFLWtlOs81IRTPPnOjrchGQnbwLd1wfkEqDYLOoZw/gWepJ7J4GENMrJR/0BidUIaxgmeaGoIi9Bnc8xW3mKp1WSJ8uhHvxVoUoKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bj7meatZNKHbGyO6Xw6V0wJUfzyUeI/wnWsKauRF4co=;
 b=uRCpOdB+sj+PrsenRIRQUazUfWoTiGFlcBHj2pen8BXt3cVDTaRpC3leG3HTznWdNLMAogLs8AylecrBWkxhTMYy4qu9HRdn4SRS3Jm4aBhbUx1de9ZXLs1Cw0zvapH99YN9MCOx7yEZ1h5pQ+/h5ce7odwSJ6xjDFGUQ3BybAM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2413.namprd12.prod.outlook.com (2603:10b6:802:2b::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Wed, 6 May
 2020 00:59:31 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 00:59:31 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: Use GEM obj reference for KFD BOs
Date: Tue,  5 May 2020 20:59:11 -0400
Message-Id: <20200506005911.21544-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::40) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.211) by
 YTOPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Wed, 6 May 2020 00:59:31 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 07bc9c11-88fe-4167-15d8-08d7f158bc3e
X-MS-TrafficTypeDiagnostic: SN1PR12MB2413:
X-Microsoft-Antispam-PRVS: <SN1PR12MB241387D810EF4F2B759D7BEC92A40@SN1PR12MB2413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KF0cciLakFSCL7LQ6/95pN9ltuxmmeu0qfva8sTLfCL8kLwp/qOWdGPVq8XvMHzX0AlwNQPvc0F0kQ2xiQ4MATHGybJc5qSW1bzkvn5801Gc1V18ztpt8lb+wjLP7tcvWCI1+F5XEV0EGVgcEN3b1wygDrljgiyvugo6GWX9hO0Cg3A4msAuGpP335u5HDBCgIKMRGu9fMDhGdPRfbJm+Zthqkiv+ixkxO+v9Na5JxvWz4XtYDt7Nbv2VnqfLppn5Zz86ssScajI1rWCE6h5gvq3Su+l8q+TvgquTVcVB90eauwHxSBu4BNGaEAWXFLS+aijI8mF0hRE+0RLtnISLZbPWNGIov9EE/oTogHPgNU9T/548lL5D2FONjsG9JEL3MFIDgWeNgURqukDFZiBICC7kCowIklDoPXTIx9SqWWpn58YWKjIBqaX4NeeIr45hso0feeDXjSLoHv2QdD0MJVXXQpBVUK0lI/T/c3bCoanCHyatVXN3+HG1KJJJg/wgw65DnKJcqxxrt99n87jkv44eZk+22M+5aSMpAHCp0XY88Kummtq58et02LGaEi6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(366004)(39830400003)(376002)(136003)(33430700001)(478600001)(5660300002)(33440700001)(69590400007)(6512007)(86362001)(66556008)(6486002)(66946007)(66476007)(26005)(6916009)(6506007)(16526019)(316002)(186003)(52116002)(2906002)(36756003)(956004)(2616005)(6666004)(8676002)(1076003)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0FvaGyJYpQWHygttGzCcn7azZjTjVMuEGs6eEtmH4vM+rIRNi3ftT4IWOM1Vp7RvVk6wnKHdidVAVzdm5ycKR1qnjjkJ372lq/HvGs7mxvVnCPOM3jSxUjoe71NLOK1GTc8f5Eivq0b9jywGNWmqLXZWYew5Jx/+45SfD0LdSjuyd1eggheOvhT+l/+6NWDV8HutSIClqoMucqfpMQUo3a0lR3tXvBF2qxbl7OqTEzpJ5sZ8pY86rI0srvnUOHVI7nBI0BjFL9hd6DnWQdQMb7XRNXcFajPqqsWOdnMuxyXSmVrBhgDgZ2tHHDXK7XjW7PkDBgYyrIatBjWY99e3lt1SgTpOADahNogrOh1YiPk5O2GSJTv8R7dgLC3SgTMWMujMYvhu81V3qPHZPW1Hj1fC7Lxc/Pxe/RpNJtP1MRxjUEz16fDxaptu+4Mnf2mDBzdJE74jSCGFg3VcKhlsm8W2wE9kYRnwc8brxEwm/irpslVbNtkmhb452LtqhA5vN0b/Al5sQOSQ2xIqmNyIRcPLd4hWsm060gveJmxCmCBCbc/9Sq2Zqb5uBPJbjoSHqcd3V0G8R94uumflA8/KP97cOJvSgUHWDFIuHds+0BUemRVaq27MyG1zk4lNb6FNX2bAYpq08qAHGPMXE3g4kdhvfQbR9r51ZW8bYW/VT/U1a2+PG6lgu69SVQWUltdylYKFvBW8W3Fa9Z2Dt/KDSozCD69YyL8swdEdfADQEXdzrypOfFSEwqSmG4HY+ezGowRABRaeN3ae6Kklrjs/SptgxCTjKLCdBXVTj3bkR90=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07bc9c11-88fe-4167-15d8-08d7f158bc3e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 00:59:31.7294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYvrLnr90TMbsutI36wOT+se0ZSRDWWXoBy3DSdVzMkm9BoNxdL5JRcFUoZfUCnH4kM9tOAfuUq5m5U/ygcG/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2413
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

Releasing the AMDGPU BO ref directly leads to problems when BOs were
exported as DMA bufs. Releasing the GEM reference makes sure that the
AMDGPU/TTM BO is not freed too early.

Also take a GEM reference when importing BOs from DMABufs to keep
references to imported BOs balances properly.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Tested-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 1247938b1ec1..da8b31a53291 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1354,7 +1354,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	}
 
 	/* Free the BO*/
-	amdgpu_bo_unref(&mem->bo);
+	drm_gem_object_put_unlocked(&mem->bo->tbo.base);
 	mutex_destroy(&mem->lock);
 	kfree(mem);
 
@@ -1699,7 +1699,8 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_dev *kgd,
 		| KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE
 		| KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
 
-	(*mem)->bo = amdgpu_bo_ref(bo);
+	drm_gem_object_get(&bo->tbo.base);
+	(*mem)->bo = bo;
 	(*mem)->va = va;
 	(*mem)->domain = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
 		AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
