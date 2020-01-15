Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67E0C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 16:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 862AD214AF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 16:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rEgxC59O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862AD214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CF576EA4F;
	Wed, 15 Jan 2020 16:53:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75E276EA4F
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 16:53:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7+k0bmR0+TJTcLnED/HwjyfFARQjHl9wB0Y0/I3tG6pXy2Z/UD6joGtXhGe+7cTmOSC+Ti1Zeurxosictd7dj87luRVWquLBVwLEnezlenlohjzVk8ZKLVKNSz98g2TflUgZsgt8eCzvz0fHBKRPp1dvkF1C2I7rN3M1O5DsEfzUgz/9M80GxVTsyNVSZflq+xD0jGoElZpJnm6hJ8AkF/HvrJdUelJDJGhSe9vN7EZS/f+hJVkkykOyBJ/Xval+h7IxpakNIJ3cgLI8l9KtnBsQqWAUgER2HSQGA2AXCuCoqEqtojjWITgXq2HspSrjlASijca9Av1hZ0dA5QcDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/g0BcSC7WWLKOS7vhC8hPfP/9loVwQ07SIyC4CZhm4=;
 b=UTG41dQDN97VA7iCDP1GoFIlZvleCLDlRMr4XA4taEiRnqNsp3qqxvG99ZrnhEXGl+2o4AR7mfW9j6zxvJUyn9SVx9zc/GmSr3lIN4rsEOBN6zzch/xQx6SPokhDBiqnxxcOpRIMb+yE/ObqbdHTuD9FPK10NudPN3BUQL73Vr6RnOjh1GrLhn3QS6c9vau0D93eJ8F0YZ28LBI/h2xZSn/ww8IdrojjohDeLFMh7QLcvINlsYeGjwn5a9Bi4V1HQjOZ8elLYSMaNnkI4HjG3Urw84yJNQPDX33JvOBrHW+9D99Gznax8H6GA/7DDBw6ImeE/FaPZ/jj1/EwcQbTFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/g0BcSC7WWLKOS7vhC8hPfP/9loVwQ07SIyC4CZhm4=;
 b=rEgxC59OpOCUmoI9L8kRN+/JRvCOaYiFEPDfIDf7CYUUFdMPVVOnNu1qk9PNDJB2WH+WkjKMRW9fOkub3Keg4pYX68B2qKj4HVFhhdDTH3UOZv7x5HbXXPuL+wcHLxhPfA46oXyIUcjTJsZsn940kGi78i/lSc190WSgWtyBNjU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB3430.namprd12.prod.outlook.com (20.178.196.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Wed, 15 Jan 2020 16:53:52 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2644.015; Wed, 15 Jan 2020
 16:53:52 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 3/6] drm/amdgpu/vcn: move macro from vcn2.0 to share
 amdgpu_vcn
Date: Wed, 15 Jan 2020 11:53:43 -0500
Message-Id: <1579107224-2471-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579040596-12728-4-git-send-email-James.Zhu@amd.com>
References: <1579040596-12728-4-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::19) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from work_495456.amd.com (165.204.55.251) by
 YTOPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.20 via Frontend
 Transport; Wed, 15 Jan 2020 16:53:51 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 44b49e77-e82f-464b-1444-08d799db7fe7
X-MS-TrafficTypeDiagnostic: BYAPR12MB3430:|BYAPR12MB3430:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3430653D1C569C9CACE585DAE4370@BYAPR12MB3430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-Forefront-PRVS: 02830F0362
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(199004)(189003)(8676002)(956004)(2616005)(6666004)(5660300002)(66476007)(66946007)(6486002)(81166006)(66556008)(26005)(8936002)(4326008)(186003)(36756003)(16526019)(2906002)(316002)(52116002)(478600001)(86362001)(7696005)(81156014)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3430;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qhMm3L4CQx6Sb86Fem38+uVdovXuzWxaFZ10uosJOvET0yS5+QtcBTVAm3j2C6GWL5Z1yf4Jt23Zln3gWYQYaMIOjfuCOPRKPlTs3i3gd41N23iJHPUlM7fC1lSu6yykTlLM8tFRcfTZHsaZWFCLQmBUB1tbCR8K7ZEDg2NSfqD9qE7+RmPegCM0bG3t1RAnb/+T7EZrfjKpP2UY746CYR53OHQyiUdEU4He/29r7iFoQ+7mGJm1MVqZWHvQG/rUqdNYKYVJYG+yiNSHery+7iFsDaYAWIXuRxweuGdIxktMwToSG8uvjx1c8H5EfE9Fb30dLquyJaHRh+Vy67t4dtyn/vGr3nusIqUNf6/K+RI/zCpuuIqg+XgUL5LoR6424C93eyVlyKzB1RY5vH4aUwjE3/+g6BKXAz5jsBOwLgoP05LNDmQSsCzH+8HsdCj8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b49e77-e82f-464b-1444-08d799db7fe7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2020 16:53:52.3479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3fY/lIHckP2GgrupZLtF3/mDXvmJRmVW8/b9GVwrPdjCHc07eYjZz/1K3N5onkr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3430
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move macro from vcn2.0 to amdgpu_vcn to share with vcn2.5

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 5 +++++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 5ce13c0..c4984c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -57,6 +57,11 @@
 #define VCN_VID_IP_ADDRESS_2_0		0x0
 #define VCN_AON_IP_ADDRESS_2_0		0x30000
 
+#define mmUVD_RBC_XX_IB_REG_CHECK 					0x026b
+#define mmUVD_RBC_XX_IB_REG_CHECK_BASE_IDX 				1
+#define mmUVD_REG_XX_MASK 						0x026c
+#define mmUVD_REG_XX_MASK_BASE_IDX 					1
+
 /* 1 second timeout */
 #define VCN_IDLE_TIMEOUT	msecs_to_jiffies(1000)
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 9ff59ac..f4db8af6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -47,11 +47,6 @@
 #define mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET		0x5a7
 #define mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET			0x1e2
 
-#define mmUVD_RBC_XX_IB_REG_CHECK 					0x026b
-#define mmUVD_RBC_XX_IB_REG_CHECK_BASE_IDX 				1
-#define mmUVD_REG_XX_MASK 						0x026c
-#define mmUVD_REG_XX_MASK_BASE_IDX 					1
-
 static void vcn_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_0_set_irq_funcs(struct amdgpu_device *adev);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
