Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DB9C47257
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 18:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7799620575
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 18:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4CL8cGAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7799620575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 118FE6EA5A;
	Thu,  7 May 2020 18:54:19 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680044.outbound.protection.outlook.com [40.107.68.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78B0C6E18F
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 18:54:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAHFmf0LFkiiUcMUNOXRbI3l5ROdPbmvQ2DBarwTTn9DWiQZrX8OUFLNWoweUUoYbe9vBlhVXZCuB6WZL6TZCAp1vwiNFk9YpFrKZfSSUjLBw5p+bNoQ5wSFMKwk3xx8/uZSdcloxzqyUxfiSQqvQm4e+cOV873MSC+HRrDda91KU5QlMDznxXYy5QgUie0H9U6Imlew1hpeDMfvQVf9l6nancCGd0S3pap4EyCWLeQFvRt7iXN35PtBqOo+QZ60e2hHfyuGNO6xmgf2CDZRLmt/ZV2R9+45npNU0/SNHjTxFH5Hfuz5r7pgckfHNJn2o3GpTbXyQO2F9jRzK1dTdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=of5pFxd1R+6tAR/qZI44xBZuNvg+C9T2Cc2vR5bRlIU=;
 b=m0GkZRh0i/VLmkT7vz7u03eS8rb3m82LW2gTrU1nPiHTsni8zBdzlmmgxOnx618a3zC3RfiV4JGxsvxKwge7tg6gnlO6DLWFlPVtqD0bfN9AFYU++goCA8GdT3g2CcUg+33fYrQ1Un4S7hAn0BQkKGUWfqNy3qhhtKJMPa/+JMGyp9mJKrdAuYT+Ryyy7rbMpw/YFfOvRf3VSjCzoRvMH2Zfkifd8LBIRXCcTSMPamUO2sPnxqof+Z2NeO5RuUIi0FKeDQODb0cGMF6qV4ELLyTbRGWTkYEF7MCcK1sznH8ToNPWl2lA+qZuRGO2dR82dwp0f4KRM33SNqoylKOtQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=of5pFxd1R+6tAR/qZI44xBZuNvg+C9T2Cc2vR5bRlIU=;
 b=4CL8cGADs1F01lUOt8HbcXbQ66MAqCKOS0dj6qdOM7EzIMWcTQvBXgwxNh86EDl6CXtdd+pVQ8D507YCgJtInFfz+Vk25JaqKvDpo8fRlwssmQox4uSArT8QtpLpHaMv3xKr46Z0JK2GdxTtvw/LcuPtM5k0W6Wbt/3nEgeBgj4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB3579.namprd12.prod.outlook.com (2603:10b6:5:11f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Thu, 7 May
 2020 18:54:16 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648%3]) with mapi id 15.20.2958.030; Thu, 7 May 2020
 18:54:16 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] Revert "drm/amdgpu: Add ReadSerial defines for Arcturus"
Date: Thu,  7 May 2020 14:54:03 -0400
Message-Id: <20200507185403.5114-2-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507185403.5114-1-kent.russell@amd.com>
References: <20200507185403.5114-1-kent.russell@amd.com>
X-ClientProxiedBy: YTBPR01CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::40) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YTBPR01CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.27 via Frontend Transport; Thu, 7 May 2020 18:54:15 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fb030058-e790-426e-f80e-08d7f2b80a71
X-MS-TrafficTypeDiagnostic: DM6PR12MB3579:|DM6PR12MB3579:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3579C7F1BDE31F726C3426AA85A50@DM6PR12MB3579.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:117;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gZ451xdpHobaRUPQGkcGFiZZ+9HtS3F2LgTH0m2Z3w9cyf/5yE1TFco3k+kTjFy6+y0uJzMbzC0bLdP3TH4rRz6XOq6MLn0WoHpXD/kRRahE7ZJWi7VjR/yXl7F2dEXZgnSyyh3FU87S4cZzZ8PNJvtEcNpm0W+fpNZKxsWoQ3j7biyBRtlKuL+/sfIpRDLDQWv3Rx254Gqj+N57Vu7ovMjpFhUUW4Y4Jf0Xs47jyXn+NX0KOvqwKT21aGdKHL56/f4sDD1Bj1Fo7GYietzEVTLafGi+r31kkHZuJ2KYfIEdtGlZjzeBxMWPptXyguNb83iRdkGkrePcpgPC+2tGuvHNds0f9IOZr+7h/h3gh1aRWahr4nxN4gqIzmL9qrfTSYqr1a7OTBshkus1rEjPylr1uRhItNnLyUqPqdF5eyY2YFBgmc9at4SbGizbCRdPtprJg31IOjkJTP4MO1ixyASGvLAckLpWrQM/pc8WGeLJKDziaV9+k0vFxV1VnQPYKFShigmrAt9LgQPUKMYK+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(33430700001)(4326008)(316002)(66476007)(6486002)(66946007)(6916009)(2906002)(86362001)(83290400001)(44832011)(2616005)(19627235002)(83300400001)(8676002)(8936002)(956004)(83320400001)(83280400001)(83310400001)(16526019)(186003)(5660300002)(478600001)(66556008)(52116002)(7696005)(26005)(36756003)(6666004)(1076003)(33440700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: XK1dDFkGHy8NM/ciuqD2cBGM14Ik1/H9wNMF4aIdTH80y1BJfbSgA2fq70HUEIVThxBayDuuFjq3ecnGbDuFQqR/KDBOPP/VUm8paoSogAgNIKJe92DLjz4agiZ1pksUjbGwA14tacj8zct1VIkVqimktviCteuVvcEFQ5EqirzFw1rJNuJmA0KnWvHh8lCFBNnzTu7PTXaEUaPbxCNqtXc3Hv2ALKV92Ze8V7YVm6pW56em/dcf1Ox61Zp/rEGTKJx1UtpGG1j1a9DlZ9CO6beH0BKDNwBp9/ZcUKfsNCzRVzvcGxXstRAXIQzDKoIZpaS3MmlWrx4pzwhtikq1EDo8kH7sYR1FwWvx7pAXjArU2J46RnwpKfN5M8c870oYNBqTHWfuEIhJE5Dprvd3aW48/bPOp0tjfUDy+Pq6EhGz6y/NB1D9LN5PFvPyG6b3KftbkANHEvomiUw6zwnAIer6XghJy6QR1YA+Ct436HtrphMWszp9DlUl/8DK41BK4qcAnT3m1Bmr+a19zaLuZMaGzHwRsEDgUt/Xg/GOx7VjzSpRNYE00Vib9T0PqMjqMZj1zJiTkcNvOLoEpc/etjtqvRZG5GgSsxGViF9mL9bm/GAnOAyNQgNelSkI9G1M+2nQKul39971+NIMO0b3yoynHRAaA/PfpxoaVxxzMYMZpG3wL3GrFHp1ZwQvLvyPqo9KxF/hUdrQADb50hz+RO0/rmAGIyeCec4m74fBeeBth8Tr4izeaEqqC7kSZ0b7mrVygBYOjWiymGrXaWmipNZO+UHMXyWqO50yY4it5AE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb030058-e790-426e-f80e-08d7f2b80a71
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 18:54:16.0629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXV1rBz2etKRzmSSkLKJ6nPfDHHxJGVk5XO0Xc8bxEhcip0PgE+MogpHRMGJFYFLsY0yKCMMyNWo3fACCbjp5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3579
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

This reverts commit a0d4939d8616fab676699dab8ba3cbe519d4a8e9.

SMU does not support this on Arcturus right now

Signed-off-by: Kent Russell <kent.russell@amd.com>
Change-Id: I50efa3695570302231986d56c2351aac331726ca
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       | 2 --
 drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index e98d92ec1eac..1c66b7d7139c 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -128,8 +128,6 @@ static struct smu_11_0_cmn2aisc_mapping arcturus_message_map[SMU_MSG_MAX_COUNT]
 	MSG_MAP(SetXgmiMode,			     PPSMC_MSG_SetXgmiMode),
 	MSG_MAP(SetMemoryChannelEnable,		     PPSMC_MSG_SetMemoryChannelEnable),
 	MSG_MAP(DFCstateControl,		     PPSMC_MSG_DFCstateControl),
-	MSG_MAP(ReadSerialNumTop32,		     PPSMC_MSG_ReadSerialNumTop32),
-	MSG_MAP(ReadSerialNumBottom32,		     PPSMC_MSG_ReadSerialNumBottom32),
 };
 
 static struct smu_11_0_cmn2aisc_mapping arcturus_clk_map[SMU_CLK_COUNT] = {
diff --git a/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h b/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h
index b426be7c76c6..f736d773f9d6 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h
@@ -116,9 +116,6 @@
 #define PPSMC_MSG_DFCstateControl		 0x3B
 #define PPSMC_Message_Count			 0x3C
 
-#define PPSMC_MSG_ReadSerialNumTop32		 0x49
-#define PPSMC_MSG_ReadSerialNumBottom32		 0x4A
-
 typedef uint32_t PPSMC_Result;
 typedef uint32_t PPSMC_Msg;
 #pragma pack(pop)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
