Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F63BC433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 09:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB59861130
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 09:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB59861130
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C3FD6EA36;
	Thu,  8 Apr 2021 09:29:10 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 353E06EA36
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 09:29:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMJf5PM0KgjjDZUIf7m8xBOesAuiEgDsj0EH/gAjP2iBbSnQLwiT6JeexgVHt9JXF9+/ifv/RztJIaEjBbq5pR6IeyGOHiInw+jw4CM+doludsc1hGrIo5Fr+4NKOdq7wqIyPFpnT6MA0FECJQtdQ0ujeL56z08U1L6hkKrwb/7faabtsCNc1wY0Yvybhhh0lBYgOeaZdT03UnsLNAV9SS1GItjBZ0GqNHFKLtkeSDY0wvMHzSHqb8/aDxXKc1rnN99qIbsokH5Z6JoDF9ZPuV7isxN4svUOWAq04slV7sG3STv+Q2/92tN8kVqxzunINt+VR9Dq+YLY732wuyZbFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbi5uGKtuSrtKQmTZ+PiyjcHFSQeudkxYoQUdDvmFjg=;
 b=BxjzyZWcABNDeA+40GrrXWleHpKFnQgDc0hREZadl6lA6LHCAmYGCsgYbjeKR7JzW+fQYyADoR8cxDW1pNeVMQzMDMrphmoOkKFaDW3Jg2yoKErWpSi9jmeWBY9Y8rP7q4GgnMvs7556fx5ydAZ4n9fW06+3OEPcmmZEW/oSAk37318RzSKEW+xqZmgZ/UXLh0LfazqfHGOUhvc0GH5eokkgWozh1/vrQNSw//WsWxl9pbGcAtYLUrWCdU8a80MOwUw/P0XhG44wtFdH8gsjo5lMBh05gm5iqrHPzABDJ1hhFFGJGm7AG7NBSGXr1qEmgIU5qu0gDDyBn0qWe7w1/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbi5uGKtuSrtKQmTZ+PiyjcHFSQeudkxYoQUdDvmFjg=;
 b=uHCGq2DNvv8j8ReJlLWl5erLSykIQHvB+bBntdCdielEokz3CTl9eGOiz8bVWZTtDsbjY7514H2TIZN1YuupN5qpmMgVRqZ5M1RvY60ZXuw6iFSJulfEPWvnS952Q/qmAyyBbuMKRPmLeexW9cmzLreFOKdRVOFoGZDX3SjRB28=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1271.namprd12.prod.outlook.com (2603:10b6:903:3d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Thu, 8 Apr
 2021 09:29:06 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007%8]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 09:29:06 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/8] drm/amdgpu: Change GC register access from MMIO to
 RLCG
Thread-Topic: [PATCH 2/8] drm/amdgpu: Change GC register access from MMIO to
 RLCG
Thread-Index: AQHXLDit0RrKwB9G8U6MIM8+XyuwB6qqPvBw
Date: Thu, 8 Apr 2021 09:29:06 +0000
Message-ID: <CY4PR12MB1287ED0E9F39F3D9680AAC4BF1749@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210408053236.30762-1-PengJu.Zhou@amd.com>
 <20210408053236.30762-2-PengJu.Zhou@amd.com>
In-Reply-To: <20210408053236.30762-2-PengJu.Zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-08T09:29:01Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=6d4a5eb8-533c-4159-be0f-9a974f6b6301;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d9d33e8-0852-404b-92c6-08d8fa70c1cd
x-ms-traffictypediagnostic: CY4PR12MB1271:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB12718383B37E635C254BDB75F1749@CY4PR12MB1271.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:510;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vBTtqbqvmeueSGwLWnOLSlw2NBrrvl+ohsHkg85TdkdDOJJlij+cFsIE4dFuRAOnCid1t3kSfeCZhojwDoI/oydhMnWCaUiR64LsdMj8oSeOk3JU1RVU370FMBKu2Nq40JwrZELAT9QYUa6yUsv798cThsWe6krVk5aBXXJQvPYiGRvrDTdSBsMvNHqgzU8q5oVNBaeo2WlYNeFdcQV8OH/t0yBcBJwbcjOBb1ve3NxN2OM1R1uQMxAcJtFcnGoCbAckIvfAjJRP8mA7KgRV2dRzz2RcKXVQYTIDWukCqZJnayBZyKA2JBgblZ/7vpnI69dCXp4qY9ouwl8Sy51XvPCqBXgZDbiXqewsUXncXsVUtYvJ6Ae7Lwbwl7Ln8TRs4u5LtYocu78gYEGyCMEzArjXiuVq1nc3Xlz4f09MlPH9Lid/nvpznTFK8dCxb2pIhILloFb4pBUw1qVTSzrxS965DZkTlUfGeSn1IEDp4ScB2+3d0WcIwMhFGJAsDS4YC8HMwgZzNnYntEkJABy2Vo/VJfnSImT0e971ODPJWchFmqMsD3O6+7QNAbjtFcgQE3umJ/T4lZyxHWRItoKsk258rZgoeqwIUJWAtPoUy5ttNYPok+p7H7vbsT4JB/1WVv5ofrVkunzNeXNleam3uWsjehN0x0pM/t/CVOJ+WxKraktMv1NLH5q9n+ypr1Cj91+Aw3EJWyNq1MKi87oqrg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(6506007)(86362001)(26005)(38100700001)(52536014)(53546011)(30864003)(66476007)(64756008)(71200400001)(7696005)(110136005)(2906002)(45080400002)(66946007)(66556008)(9686003)(33656002)(478600001)(76116006)(8676002)(8936002)(316002)(4326008)(83380400001)(55016002)(966005)(66446008)(5660300002)(186003)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TWEmbDAjnxFT9+gkeasjFKf3wMTKj6IUd1KBJ5r/GINPPMLZd4UcZnIlO9K/?=
 =?us-ascii?Q?bXlkL2z8f0D8jBlDWpK0a2TgterPaaloOaqSDrHftpVz9nw5NspAMVJ0gjNN?=
 =?us-ascii?Q?+djysZLdJYlbOaZ3iuQntXOhvY5pIkhomQZ56V1mRdPJuk2W1snHGOrv94yr?=
 =?us-ascii?Q?jjKOnox5t+C3tJ5AJDY9JEMyWk2yHfaIb66YhDcWOqyNeadsEbnMI0BrwxnP?=
 =?us-ascii?Q?utE+dZnDKwHjvIfR74Rgb5VZVqHjstCYPOuwj/XE3EOnkvG2P7kfgAB4A92q?=
 =?us-ascii?Q?rJrex2/ZmRJ2cNYMi3ulqWsFn7NLlkKo9pB4EIb/o/h8Q+lnQzPqkFGbq1QK?=
 =?us-ascii?Q?A6k53JZSgTVakDs1AG2XQTF7eyEyR/LYVxRc+WDtIoInQRoc6MO6R7KGBp3D?=
 =?us-ascii?Q?mpXPylqak77C7TAPF4UBujc6LbWM7qXyhCkawJ3ywAX0wDFJozzo3Aub06Xv?=
 =?us-ascii?Q?UjRVcPtT98rMSfn2gg19miYN4LWz0VZVtDMtchtI+a+/KZZFJgUzkuhqd2nR?=
 =?us-ascii?Q?zoWQ92ihnf0/NIyGFq+sWP8JbD/lNpQ4fXJyNRO5exKEFlB42aF/HS9zNSk6?=
 =?us-ascii?Q?/9yvVKaz+GlEpXnQnN1NIBEaFSQhM5/hcFU/86tixBhEi72BTGvnQHVw81d2?=
 =?us-ascii?Q?w9mp3T/t9ox6KMeDyMg8lKDL4jLPuMKSE8tlCzDxnY1EPvJSp/OIY98ycWwG?=
 =?us-ascii?Q?xIuMJhUMhY2ongam/Dt6yF27+jrPucGNObVNrsshyYpaiqUhfmzVaqT7ynpU?=
 =?us-ascii?Q?qe//+0UregtUDhWU2EkEIiLG20QsyanSOfHKLsgX6vOCxNdYuaYsTeF+IIHP?=
 =?us-ascii?Q?el6gyBVMx+Z06L9EL5VmoxgE62WY32RL6x9E/zhzN5FeyD32kEYiIDGIkZZE?=
 =?us-ascii?Q?kkZaeMwobb3hZ/rC5ua3/lQ05dwtyTx61pvJ+K7UZ0SS62NdPUr8NYrzrBH4?=
 =?us-ascii?Q?yFDdWPrVfP7NM7siOTWEC4gZZScPqTvPG4W/Pf+eoua4jHCyD4YaJ9lgDMVk?=
 =?us-ascii?Q?uMAqYawKbxRorXfrxXXBZBi+TCg3zLFLXqoNd/+PDxWnU1K+TFITvk2KvyAF?=
 =?us-ascii?Q?r7+NcDmJsF8p4Li7AqWZAcf/8t0M9dB9ID/mM1PVUF70kdOQQekWOhllTx+6?=
 =?us-ascii?Q?zYAo03hhVK4VbWQn2Osmg3aT62cGqbLK4+djrHDaFUypUarpRySqPHC3jGLj?=
 =?us-ascii?Q?wmHRgGt2iFFNwGdlOISr0qH4aEJ00QtkvygSGzKG5FsXu2IGIWCAehYObD74?=
 =?us-ascii?Q?+zXIAOZ9uE4yyJmaOM2J+20mXaAn9TLmAPxyFEcCZz17mwp+ER8pxXvfQ7qI?=
 =?us-ascii?Q?CCAkyiCimQOE/lZyLpzYhpYI?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9d33e8-0852-404b-92c6-08d8fa70c1cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 09:29:06.6102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Kdihotd3YBlxQ5MeVtq8juTpLEFfyMh7Sis/IC+7HGDZdxyskKoy+CG5IQejo5Uc9nXmSmES+F058+9ynok3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1271
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
Cc: "Jian, Jane" <Jane.Jian@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi Peng Ju,

Before merging your patches, it's suggested to conduct a full test in BM mode as well to avoid regression, as register access is changed.

Another problem is, it seems the subject of patch 2, 4 and 5 is the same. Can you please modify it respectively a bit to be more specific?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Peng Ju Zhou
Sent: Thursday, April 8, 2021 1:33 PM
To: amd-gfx@lists.freedesktop.org
Cc: Jian, Jane <Jane.Jian@amd.com>
Subject: [PATCH 2/8] drm/amdgpu: Change GC register access from MMIO to RLCG

In SRIOV environment, KMD should access GC registers with RLCG if GC indirect access flag enabled.

Change GC register access from MMIO to RLCG.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  38 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 205 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/nv.c               |   2 +-
 3 files changed, 124 insertions(+), 121 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 62aa1a6f64ed..9394dbf504de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -96,8 +96,8 @@ static void kgd_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t vmid,
 
 	lock_srbm(kgd, 0, 0, 0, vmid);
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmSH_MEM_CONFIG), sh_mem_config);
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmSH_MEM_BASES), sh_mem_bases);
+	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmSH_MEM_CONFIG), sh_mem_config);
+	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmSH_MEM_BASES), sh_mem_bases);
 	/* APE1 no longer exists on GFX9 */
 
 	unlock_srbm(kgd);
@@ -161,7 +161,7 @@ static int kgd_init_interrupts(struct kgd_dev *kgd, uint32_t pipe_id)
 
 	lock_srbm(kgd, mec, pipe, 0, 0);
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmCPC_INT_CNTL),
+	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCPC_INT_CNTL),
 		CP_INT_CNTL_RING0__TIME_STAMP_INT_ENABLE_MASK |
 		CP_INT_CNTL_RING0__OPCODE_ERROR_INT_ENABLE_MASK);
 
@@ -245,7 +245,7 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 	/* Activate doorbell logic before triggering WPTR poll. */
 	data = REG_SET_FIELD(m->cp_hqd_pq_doorbell_control,
 			     CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_EN, 1);
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL), data);
+	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL), 
+data);
 
 	if (wptr) {
 		/* Don't read wptr with get_user because the user @@ -274,17 +274,17 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 		guessed_wptr += m->cp_hqd_pq_wptr_lo & ~(queue_size - 1);
 		guessed_wptr += (uint64_t)m->cp_hqd_pq_wptr_hi << 32;
 
-		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_LO),
+		WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_LO),
 		       lower_32_bits(guessed_wptr));
-		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_HI),
+		WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_HI),
 		       upper_32_bits(guessed_wptr));
-		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR),
+		WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR),
 		       lower_32_bits((uint64_t)wptr));
-		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
+		WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
 		       upper_32_bits((uint64_t)wptr));
 		pr_debug("%s setting CP_PQ_WPTR_POLL_CNTL1 to %x\n", __func__,
 			 (uint32_t)get_queue_mask(adev, pipe_id, queue_id));
-		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1),
+		WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1),
 		       (uint32_t)get_queue_mask(adev, pipe_id, queue_id));
 	}
 
@@ -294,7 +294,7 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 			     CP_HQD_EOP_RPTR, INIT_FETCHER, 1));
 
 	data = REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1);
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE), data);
+	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE), data);
 
 	release_queue(kgd);
 
@@ -497,13 +497,13 @@ static bool kgd_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_address,
 	uint32_t low, high;
 
 	acquire_queue(kgd, pipe_id, queue_id);
-	act = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
+	act = RREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
 	if (act) {
 		low = lower_32_bits(queue_address >> 8);
 		high = upper_32_bits(queue_address >> 8);
 
-		if (low == RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_BASE)) &&
-		   high == RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_BASE_HI)))
+		if (low == RREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_BASE)) &&
+		   high == RREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_BASE_HI)))
 			retval = true;
 	}
 	release_queue(kgd);
@@ -551,7 +551,7 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	acquire_queue(kgd, pipe_id, queue_id);
 
 	if (m->cp_hqd_vmid == 0)
-		WREG32_FIELD15(GC, 0, RLC_CP_SCHEDULERS, scheduler1, 0);
+		WREG32_FIELD15_RLC(GC, 0, RLC_CP_SCHEDULERS, scheduler1, 0);
 
 	switch (reset_type) {
 	case KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN:
@@ -605,7 +605,7 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	}
 	retry = 1000;
 	while (true) {
-		temp = RREG32(mmCP_HQD_DEQUEUE_REQUEST);
+		temp = RREG32_RLC(mmCP_HQD_DEQUEUE_REQUEST);
 		if (!(temp & CP_HQD_DEQUEUE_REQUEST__IQ_REQ_PEND_MASK))
 			break;
 		pr_debug("Dequeue request is pending\n"); @@ -621,11 +621,11 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	preempt_enable();
 #endif
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_DEQUEUE_REQUEST), type);
+	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_DEQUEUE_REQUEST), type);
 
 	end_jiffies = (utimeout * HZ / 1000) + jiffies;
 	while (true) {
-		temp = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
+		temp = RREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
 		if (!(temp & CP_HQD_ACTIVE__ACTIVE_MASK))
 			break;
 		if (time_after(jiffies, end_jiffies)) { @@ -716,7 +716,7 @@ static int kgd_wave_control_execute(struct kgd_dev *kgd,
 
 	mutex_lock(&adev->grbm_idx_mutex);
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX), gfx_index_val);
+	WREG32_SOC15_RLC_SHADOW(GC, 0, mmGRBM_GFX_INDEX, gfx_index_val);
 	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_CMD), sq_cmd);
 
 	data = REG_SET_FIELD(data, GRBM_GFX_INDEX, @@ -726,7 +726,7 @@ static int kgd_wave_control_execute(struct kgd_dev *kgd,
 	data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
 		SE_BROADCAST_WRITES, 1);
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX), data);
+	WREG32_SOC15_RLC_SHADOW(GC, 0, mmGRBM_GFX_INDEX, data);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 85a6a10e048f..376c92b1f938 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4490,7 +4490,7 @@ static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
 		adev->gfx.config.sc_hiz_tile_fifo_size = 0;
 		adev->gfx.config.sc_earlyz_tile_fifo_size = 0x4C0;
-		gb_addr_config = RREG32_SOC15(GC, 0, mmGB_ADDR_CONFIG);
+		gb_addr_config = RREG32_SOC15_RLC(GC, 0, mmGB_ADDR_CONFIG);
 		break;
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
@@ -4820,15 +4820,15 @@ static void gfx_v10_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
 	else
 		data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SA_INDEX, sh_num);
 
-	WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, data);
+	WREG32_SOC15_RLC_SHADOW(GC, 0, mmGRBM_GFX_INDEX, data);
 }
 
 static u32 gfx_v10_0_get_rb_active_bitmap(struct amdgpu_device *adev)  {
 	u32 data, mask;
 
-	data = RREG32_SOC15(GC, 0, mmCC_RB_BACKEND_DISABLE);
-	data |= RREG32_SOC15(GC, 0, mmGC_USER_RB_BACKEND_DISABLE);
+	data = RREG32_SOC15_RLC(GC, 0, mmCC_RB_BACKEND_DISABLE);
+	data |= RREG32_SOC15_RLC(GC, 0, mmGC_USER_RB_BACKEND_DISABLE);
 
 	data &= CC_RB_BACKEND_DISABLE__BACKEND_DISABLE_MASK;
 	data >>= GC_USER_RB_BACKEND_DISABLE__BACKEND_DISABLE__SHIFT;
@@ -4925,8 +4925,9 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
 	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
 		nv_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
-		WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
-		WREG32_SOC15(GC, 0, mmSH_MEM_BASES, sh_mem_bases);
+		WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
+		WREG32_SOC15_RLC(GC, 0, mmSH_MEM_BASES, sh_mem_bases);
+
 	}
 	nv_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
@@ -4936,8 +4937,8 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
 	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
-		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
-		WREG32_SOC15_OFFSET(GC, 0, mmGDS_OA_VMID0, i, 0);
+		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGDS_GWS_VMID0, i, 0);
+		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGDS_OA_VMID0, i, 0);
 	}
 }
 
@@ -4954,8 +4955,8 @@ static void gfx_v10_0_init_gds_vmid(struct amdgpu_device *adev)
 	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * vmid, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * vmid, 0);
-		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, vmid, 0);
-		WREG32_SOC15_OFFSET(GC, 0, mmGDS_OA_VMID0, vmid, 0);
+		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGDS_GWS_VMID0, vmid, 0);
+		WREG32_SOC15_OFFSET_RLC(GC, 0, mmGDS_OA_VMID0, vmid, 0);
 	}
 }
 
@@ -5036,8 +5037,8 @@ static void gfx_v10_0_get_tcc_info(struct amdgpu_device *adev)
 	uint32_t tcc_disable;
 
 	if (adev->asic_type >= CHIP_SIENNA_CICHLID) {
-		tcc_disable = RREG32_SOC15(GC, 0, mmCGTS_TCC_DISABLE_gc_10_3) |
-			      RREG32_SOC15(GC, 0, mmCGTS_USER_TCC_DISABLE_gc_10_3);
+		tcc_disable = RREG32_SOC15_RLC(GC, 0, mmCGTS_TCC_DISABLE_gc_10_3) |
+			      RREG32_SOC15_RLC(GC, 0, mmCGTS_USER_TCC_DISABLE_gc_10_3);
 	} else {
 		tcc_disable = RREG32_SOC15(GC, 0, mmCGTS_TCC_DISABLE) |
 			      RREG32_SOC15(GC, 0, mmCGTS_USER_TCC_DISABLE); @@ -5067,13 +5068,13 @@ static void gfx_v10_0_constants_init(struct amdgpu_device *adev)
 	for (i = 0; i < adev->vm_manager.id_mgr[AMDGPU_GFXHUB_0].num_ids; i++) {
 		nv_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
-		WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
+		WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
 		if (i != 0) {
 			tmp = REG_SET_FIELD(0, SH_MEM_BASES, PRIVATE_BASE,
 				(adev->gmc.private_aperture_start >> 48));
 			tmp = REG_SET_FIELD(tmp, SH_MEM_BASES, SHARED_BASE,
 				(adev->gmc.shared_aperture_start >> 48));
-			WREG32_SOC15(GC, 0, mmSH_MEM_BASES, tmp);
+			WREG32_SOC15_RLC(GC, 0, mmSH_MEM_BASES, tmp);
 		}
 	}
 	nv_grbm_select(adev, 0, 0, 0, 0);
@@ -5688,8 +5689,8 @@ static int gfx_v10_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
 	int i, r;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
-		cp_status = RREG32_SOC15(GC, 0, mmCP_STAT);
-		bootload_status = RREG32_SOC15(GC, 0, mmRLC_RLCS_BOOTLOAD_STATUS);
+		cp_status = RREG32_SOC15_RLC(GC, 0, mmCP_STAT);
+		bootload_status = RREG32_SOC15_RLC(GC, 0, 
+mmRLC_RLCS_BOOTLOAD_STATUS);
 		if ((cp_status == 0) &&
 		    (REG_GET_FIELD(bootload_status,
 			RLC_RLCS_BOOTLOAD_STATUS, BOOTLOAD_COMPLETE) == 1)) { @@ -5727,7 +5728,7 @@ static int gfx_v10_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)  static int gfx_v10_0_cp_gfx_enable(struct amdgpu_device *adev, bool enable)  {
 	int i;
-	u32 tmp = RREG32_SOC15(GC, 0, mmCP_ME_CNTL);
+	u32 tmp = RREG32_SOC15_RLC(GC, 0, mmCP_ME_CNTL);
 
 	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, ME_HALT, enable ? 0 : 1);
 	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, enable ? 0 : 1); @@ -5740,7 +5741,7 @@ static int gfx_v10_0_cp_gfx_enable(struct amdgpu_device *adev, bool enable)
 	}
 
 	for (i = 0; i < adev->usec_timeout; i++) {
-		if (RREG32_SOC15(GC, 0, mmCP_STAT) == 0)
+		if (RREG32_SOC15_RLC(GC, 0, mmCP_STAT) == 0)
 			break;
 		udelay(1);
 	}
@@ -6022,9 +6023,9 @@ static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
 	int ctx_reg_offset;
 
 	/* init the CP */
-	WREG32_SOC15(GC, 0, mmCP_MAX_CONTEXT,
+	WREG32_SOC15_RLC(GC, 0, mmCP_MAX_CONTEXT,
 		     adev->gfx.config.max_hw_contexts - 1);
-	WREG32_SOC15(GC, 0, mmCP_DEVICE_ID, 1);
+	WREG32_SOC15_RLC(GC, 0, mmCP_DEVICE_ID, 1);
 
 	gfx_v10_0_cp_gfx_enable(adev, true);
 
@@ -6098,10 +6099,10 @@ static void gfx_v10_0_cp_gfx_switch_pipe(struct amdgpu_device *adev,  {
 	u32 tmp;
 
-	tmp = RREG32_SOC15(GC, 0, mmGRBM_GFX_CNTL);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmGRBM_GFX_CNTL);
 	tmp = REG_SET_FIELD(tmp, GRBM_GFX_CNTL, PIPEID, pipe);
 
-	WREG32_SOC15(GC, 0, mmGRBM_GFX_CNTL, tmp);
+	WREG32_SOC15_RLC_SHADOW(GC, 0, mmGRBM_GFX_CNTL, tmp);
 }
 
 static void gfx_v10_0_cp_gfx_set_doorbell(struct amdgpu_device *adev, @@ -6110,7 +6111,7 @@ static void gfx_v10_0_cp_gfx_set_doorbell(struct amdgpu_device *adev,
 	u32 tmp;
 
 	if (!amdgpu_async_gfx_ring) {
-		tmp = RREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_CONTROL);
+		tmp = RREG32_SOC15_RLC(GC, 0, mmCP_RB_DOORBELL_CONTROL);
 		if (ring->use_doorbell) {
 			tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
 						DOORBELL_OFFSET, ring->doorbell_index); @@ -6120,7 +6121,7 @@ static void gfx_v10_0_cp_gfx_set_doorbell(struct amdgpu_device *adev,
 			tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
 						DOORBELL_EN, 0);
 		}
-		WREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_CONTROL, tmp);
+		WREG32_SOC15_RLC(GC, 0, mmCP_RB_DOORBELL_CONTROL, tmp);
 	}
 	switch (adev->asic_type) {
 	case CHIP_SIENNA_CICHLID:
@@ -6137,10 +6138,9 @@ static void gfx_v10_0_cp_gfx_set_doorbell(struct amdgpu_device *adev,
 	default:
 		tmp = REG_SET_FIELD(0, CP_RB_DOORBELL_RANGE_LOWER,
 				    DOORBELL_RANGE_LOWER, ring->doorbell_index);
-		WREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_RANGE_LOWER, tmp);
-
-		WREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_RANGE_UPPER,
-			     CP_RB_DOORBELL_RANGE_UPPER__DOORBELL_RANGE_UPPER_MASK);
+		WREG32_SOC15_RLC(GC, 0, mmCP_RB_DOORBELL_RANGE_LOWER, tmp);
+		WREG32_SOC15_RLC(GC, 0, mmCP_RB_DOORBELL_RANGE_UPPER,
+				 CP_RB_DOORBELL_RANGE_UPPER__DOORBELL_RANGE_UPPER_MASK);
 		break;
 	}
 }
@@ -6265,7 +6265,7 @@ static void gfx_v10_0_cp_compute_enable(struct amdgpu_device *adev, bool enable)
 			WREG32_SOC15(GC, 0, mmCP_MEC_CNTL_Sienna_Cichlid, 0);
 			break;
 		default:
-			WREG32_SOC15(GC, 0, mmCP_MEC_CNTL, 0);
+			WREG32_SOC15_RLC(GC, 0, mmCP_MEC_CNTL, 0);
 			break;
 		}
 	} else {
@@ -6279,7 +6279,7 @@ static void gfx_v10_0_cp_compute_enable(struct amdgpu_device *adev, bool enable)
 				      CP_MEC_CNTL__MEC_ME2_HALT_MASK));
 			break;
 		default:
-			WREG32_SOC15(GC, 0, mmCP_MEC_CNTL,
+			WREG32_SOC15_RLC(GC, 0, mmCP_MEC_CNTL,
 				     (CP_MEC_CNTL__MEC_ME1_HALT_MASK |
 				      CP_MEC_CNTL__MEC_ME2_HALT_MASK));
 			break;
@@ -6378,12 +6378,12 @@ static void gfx_v10_0_kiq_setting(struct amdgpu_ring *ring)
 		WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid, tmp);
 		break;
 	default:
-		tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
+		tmp = RREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHEDULERS);
 		tmp &= 0xffffff00;
 		tmp |= (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-		WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
+		WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
 		tmp |= 0x80;
-		WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
+		WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
 		break;
 	}
 }
@@ -6405,25 +6405,25 @@ static int gfx_v10_0_gfx_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_mqd_base_addr_hi = upper_32_bits(ring->mqd_gpu_addr);
 
 	/* set up mqd control */
-	tmp = RREG32_SOC15(GC, 0, mmCP_GFX_MQD_CONTROL);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmCP_GFX_MQD_CONTROL);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, VMID, 0);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, PRIV_STATE, 1);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, CACHE_POLICY, 0);
 	mqd->cp_gfx_mqd_control = tmp;
 
 	/* set up gfx_hqd_vimd with 0x0 to indicate the ring buffer's vmid */
-	tmp = RREG32_SOC15(GC, 0, mmCP_GFX_HQD_VMID);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmCP_GFX_HQD_VMID);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_VMID, VMID, 0);
 	mqd->cp_gfx_hqd_vmid = 0;
 
 	/* set up default queue priority level
 	 * 0x0 = low priority, 0x1 = high priority */
-	tmp = RREG32_SOC15(GC, 0, mmCP_GFX_HQD_QUEUE_PRIORITY);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmCP_GFX_HQD_QUEUE_PRIORITY);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUEUE_PRIORITY, PRIORITY_LEVEL, 0);
 	mqd->cp_gfx_hqd_queue_priority = tmp;
 
 	/* set up time quantum */
-	tmp = RREG32_SOC15(GC, 0, mmCP_GFX_HQD_QUANTUM);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmCP_GFX_HQD_QUANTUM);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_EN, 1);
 	mqd->cp_gfx_hqd_quantum = tmp;
 
@@ -6445,7 +6445,7 @@ static int gfx_v10_0_gfx_mqd_init(struct amdgpu_ring *ring)
 
 	/* set up the gfx_hqd_control, similar as CP_RB0_CNTL */
 	rb_bufsz = order_base_2(ring->ring_size / 4) - 1;
-	tmp = RREG32_SOC15(GC, 0, mmCP_GFX_HQD_CNTL);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmCP_GFX_HQD_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BUFSZ, rb_bufsz);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BLKSZ, rb_bufsz - 2);  #ifdef __BIG_ENDIAN @@ -6454,7 +6454,7 @@ static int gfx_v10_0_gfx_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_gfx_hqd_cntl = tmp;
 
 	/* set up cp_doorbell_control */
-	tmp = RREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_CONTROL);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmCP_RB_DOORBELL_CONTROL);
 	if (ring->use_doorbell) {
 		tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
 				    DOORBELL_OFFSET, ring->doorbell_index); @@ -6472,7 +6472,7 @@ static int gfx_v10_0_gfx_mqd_init(struct amdgpu_ring *ring)
 
 	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
 	ring->wptr = 0;
-	mqd->cp_gfx_hqd_rptr = RREG32_SOC15(GC, 0, mmCP_GFX_HQD_RPTR);
+	mqd->cp_gfx_hqd_rptr = RREG32_SOC15_RLC(GC, 0, mmCP_GFX_HQD_RPTR);
 
 	/* active the queue */
 	mqd->cp_gfx_hqd_active = 1;
@@ -6491,36 +6491,36 @@ static int gfx_v10_0_gfx_queue_init_register(struct amdgpu_ring *ring)
 	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_WPTR_HI, mqd->cp_gfx_hqd_wptr_hi);
 
 	/* set GFX_MQD_BASE */
-	WREG32_SOC15(GC, 0, mmCP_MQD_BASE_ADDR, mqd->cp_mqd_base_addr);
-	WREG32_SOC15(GC, 0, mmCP_MQD_BASE_ADDR_HI, mqd->cp_mqd_base_addr_hi);
+	WREG32_SOC15_RLC(GC, 0, mmCP_MQD_BASE_ADDR, mqd->cp_mqd_base_addr);
+	WREG32_SOC15_RLC(GC, 0, mmCP_MQD_BASE_ADDR_HI, 
+mqd->cp_mqd_base_addr_hi);
 
 	/* set GFX_MQD_CONTROL */
-	WREG32_SOC15(GC, 0, mmCP_GFX_MQD_CONTROL, mqd->cp_gfx_mqd_control);
+	WREG32_SOC15_RLC(GC, 0, mmCP_GFX_MQD_CONTROL, 
+mqd->cp_gfx_mqd_control);
 
 	/* set GFX_HQD_VMID to 0 */
-	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_VMID, mqd->cp_gfx_hqd_vmid);
+	WREG32_SOC15_RLC(GC, 0, mmCP_GFX_HQD_VMID, mqd->cp_gfx_hqd_vmid);
 
-	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_QUEUE_PRIORITY,
+	WREG32_SOC15_RLC(GC, 0, mmCP_GFX_HQD_QUEUE_PRIORITY,
 			mqd->cp_gfx_hqd_queue_priority);
-	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_QUANTUM, mqd->cp_gfx_hqd_quantum);
+	WREG32_SOC15_RLC(GC, 0, mmCP_GFX_HQD_QUANTUM, 
+mqd->cp_gfx_hqd_quantum);
 
 	/* set GFX_HQD_BASE, similar as CP_RB_BASE */
 	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_BASE, mqd->cp_gfx_hqd_base);
 	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_BASE_HI, mqd->cp_gfx_hqd_base_hi);
 
 	/* set GFX_HQD_RPTR_ADDR, similar as CP_RB_RPTR */
-	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_RPTR_ADDR, mqd->cp_gfx_hqd_rptr_addr);
-	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_RPTR_ADDR_HI, mqd->cp_gfx_hqd_rptr_addr_hi);
+	WREG32_SOC15_RLC(GC, 0, mmCP_GFX_HQD_RPTR_ADDR, mqd->cp_gfx_hqd_rptr_addr);
+	WREG32_SOC15_RLC(GC, 0, mmCP_GFX_HQD_RPTR_ADDR_HI, 
+mqd->cp_gfx_hqd_rptr_addr_hi);
 
 	/* set GFX_HQD_CNTL, similar as CP_RB_CNTL */
-	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_CNTL, mqd->cp_gfx_hqd_cntl);
+	WREG32_SOC15_RLC(GC, 0, mmCP_GFX_HQD_CNTL, mqd->cp_gfx_hqd_cntl);
 
 	/* set RB_WPTR_POLL_ADDR */
 	WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_LO, mqd->cp_rb_wptr_poll_addr_lo);
 	WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_HI, mqd->cp_rb_wptr_poll_addr_hi);
 
 	/* set RB_DOORBELL_CONTROL */
-	WREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_CONTROL, mqd->cp_rb_doorbell_control);
+	WREG32_SOC15_RLC(GC, 0, mmCP_RB_DOORBELL_CONTROL, 
+mqd->cp_rb_doorbell_control);
 
 	/* active the queue */
 	WREG32_SOC15(GC, 0, mmCP_GFX_HQD_ACTIVE, mqd->cp_gfx_hqd_active); @@ -6665,14 +6665,14 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_hqd_eop_base_addr_hi = upper_32_bits(eop_base_addr);
 
 	/* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
-	tmp = RREG32_SOC15(GC, 0, mmCP_HQD_EOP_CONTROL);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmCP_HQD_EOP_CONTROL);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_EOP_CONTROL, EOP_SIZE,
 			(order_base_2(GFX10_MEC_HPD_SIZE / 4) - 1));
 
 	mqd->cp_hqd_eop_control = tmp;
 
 	/* enable doorbell? */
-	tmp = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL);
 
 	if (ring->use_doorbell) {
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL, @@ -6702,7 +6702,7 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_mqd_base_addr_hi = upper_32_bits(ring->mqd_gpu_addr);
 
 	/* set MQD vmid to 0 */
-	tmp = RREG32_SOC15(GC, 0, mmCP_MQD_CONTROL);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmCP_MQD_CONTROL);
 	tmp = REG_SET_FIELD(tmp, CP_MQD_CONTROL, VMID, 0);
 	mqd->cp_mqd_control = tmp;
 
@@ -6712,7 +6712,7 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_hqd_pq_base_hi = upper_32_bits(hqd_gpu_addr);
 
 	/* set up the HQD, this is similar to CP_RB0_CNTL */
-	tmp = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_CONTROL);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_CONTROL);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
 			    (order_base_2(ring->ring_size / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE, @@ -6740,7 +6740,7 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_ring *ring)
 	tmp = 0;
 	/* enable the doorbell if requested */
 	if (ring->use_doorbell) {
-		tmp = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL);
+		tmp = RREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL);
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 				DOORBELL_OFFSET, ring->doorbell_index);
 
@@ -6756,17 +6756,17 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_ring *ring)
 
 	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
 	ring->wptr = 0;
-	mqd->cp_hqd_pq_rptr = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR);
+	mqd->cp_hqd_pq_rptr = RREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_RPTR);
 
 	/* set the vmid for the queue */
 	mqd->cp_hqd_vmid = 0;
 
-	tmp = RREG32_SOC15(GC, 0, mmCP_HQD_PERSISTENT_STATE);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmCP_HQD_PERSISTENT_STATE);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PERSISTENT_STATE, PRELOAD_SIZE, 0x53);
 	mqd->cp_hqd_persistent_state = tmp;
 
 	/* set MIN_IB_AVAIL_SIZE */
-	tmp = RREG32_SOC15(GC, 0, mmCP_HQD_IB_CONTROL);
+	tmp = RREG32_SOC15_RLC(GC, 0, mmCP_HQD_IB_CONTROL);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);
 	mqd->cp_hqd_ib_control = tmp;
 
@@ -6796,94 +6796,94 @@ static int gfx_v10_0_kiq_init_register(struct amdgpu_ring *ring)
 	WREG32_FIELD15(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);
 
 	/* write the EOP addr */
-	WREG32_SOC15(GC, 0, mmCP_HQD_EOP_BASE_ADDR,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_EOP_BASE_ADDR,
 	       mqd->cp_hqd_eop_base_addr_lo);
-	WREG32_SOC15(GC, 0, mmCP_HQD_EOP_BASE_ADDR_HI,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_EOP_BASE_ADDR_HI,
 	       mqd->cp_hqd_eop_base_addr_hi);
 
 	/* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
-	WREG32_SOC15(GC, 0, mmCP_HQD_EOP_CONTROL,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_EOP_CONTROL,
 	       mqd->cp_hqd_eop_control);
 
 	/* enable doorbell? */
-	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL,
 	       mqd->cp_hqd_pq_doorbell_control);
 
 	/* disable the queue if it's active */
 	if (RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1) {
 		WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 1);
 		for (j = 0; j < adev->usec_timeout; j++) {
-			if (!(RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1))
+			if (!(RREG32_SOC15_RLC(GC, 0, mmCP_HQD_ACTIVE) & 1))
 				break;
 			udelay(1);
 		}
-		WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST,
+		WREG32_SOC15_RLC(GC, 0, mmCP_HQD_DEQUEUE_REQUEST,
 		       mqd->cp_hqd_dequeue_request);
-		WREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR,
+		WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_RPTR,
 		       mqd->cp_hqd_pq_rptr);
-		WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_LO,
+		WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_LO,
 		       mqd->cp_hqd_pq_wptr_lo);
-		WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_HI,
+		WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_HI,
 		       mqd->cp_hqd_pq_wptr_hi);
 	}
 
 	/* set the pointer to the MQD */
-	WREG32_SOC15(GC, 0, mmCP_MQD_BASE_ADDR,
+	WREG32_SOC15_RLC(GC, 0, mmCP_MQD_BASE_ADDR,
 	       mqd->cp_mqd_base_addr_lo);
-	WREG32_SOC15(GC, 0, mmCP_MQD_BASE_ADDR_HI,
+	WREG32_SOC15_RLC(GC, 0, mmCP_MQD_BASE_ADDR_HI,
 	       mqd->cp_mqd_base_addr_hi);
 
 	/* set MQD vmid to 0 */
-	WREG32_SOC15(GC, 0, mmCP_MQD_CONTROL,
+	WREG32_SOC15_RLC(GC, 0, mmCP_MQD_CONTROL,
 	       mqd->cp_mqd_control);
 
 	/* set the pointer to the HQD, this is similar CP_RB0_BASE/_HI */
-	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_BASE,
 	       mqd->cp_hqd_pq_base_lo);
-	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE_HI,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_BASE_HI,
 	       mqd->cp_hqd_pq_base_hi);
 
 	/* set up the HQD, this is similar to CP_RB0_CNTL */
-	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_CONTROL,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_CONTROL,
 	       mqd->cp_hqd_pq_control);
 
 	/* set the wb address whether it's enabled or not */
-	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR_REPORT_ADDR,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_RPTR_REPORT_ADDR,
 		mqd->cp_hqd_pq_rptr_report_addr_lo);
-	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR_REPORT_ADDR_HI,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_RPTR_REPORT_ADDR_HI,
 		mqd->cp_hqd_pq_rptr_report_addr_hi);
 
 	/* only used if CP_PQ_WPTR_POLL_CNTL.CP_PQ_WPTR_POLL_CNTL__EN_MASK=1 */
-	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR,
 	       mqd->cp_hqd_pq_wptr_poll_addr_lo);
-	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI,
 	       mqd->cp_hqd_pq_wptr_poll_addr_hi);
 
 	/* enable the doorbell if requested */
 	if (ring->use_doorbell) {
-		WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,
+		WREG32_SOC15_RLC(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,
 			(adev->doorbell_index.kiq * 2) << 2);
-		WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
+		WREG32_SOC15_RLC(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
 			(adev->doorbell_index.userqueue_end * 2) << 2);
 	}
 
-	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL,
 	       mqd->cp_hqd_pq_doorbell_control);
 
 	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
-	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_LO,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_LO,
 	       mqd->cp_hqd_pq_wptr_lo);
-	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_HI,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_HI,
 	       mqd->cp_hqd_pq_wptr_hi);
 
 	/* set the vmid for the queue */
-	WREG32_SOC15(GC, 0, mmCP_HQD_VMID, mqd->cp_hqd_vmid);
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_VMID, mqd->cp_hqd_vmid);
 
-	WREG32_SOC15(GC, 0, mmCP_HQD_PERSISTENT_STATE,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PERSISTENT_STATE,
 	       mqd->cp_hqd_persistent_state);
 
 	/* activate the queue */
-	WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE,
+	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_ACTIVE,
 	       mqd->cp_hqd_active);
 
 	if (ring->use_doorbell)
@@ -7118,6 +7118,9 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)  {
 	uint32_t data;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* initialize cam_index to 0
 	 * index will auto-inc after each data writting */
 	WREG32_SOC15(GC, 0, mmGRBM_CAM_INDEX, 0); @@ -7185,7 +7188,7 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
 		/* mmVGT_TF_RING_SIZE_UMD -> mmVGT_TF_RING_SIZE */
 		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_RING_SIZE_UMD) <<
 			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-		       (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_RING_SIZE) <<
+			(SOC15_REG_OFFSET(GC, 0, mmVGT_TF_RING_SIZE) <<
 			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
 		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
 		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data); @@ -7193,7 +7196,7 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
 		/* mmVGT_TF_MEMORY_BASE_UMD -> mmVGT_TF_MEMORY_BASE */
 		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_UMD) <<
 			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-		       (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE) <<
+			(SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE) <<
 			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
 		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
 		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data); @@ -7201,7 +7204,7 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
 		/* mmVGT_TF_MEMORY_BASE_HI_UMD -> mmVGT_TF_MEMORY_BASE_HI */
 		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_HI_UMD) <<
 			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-		       (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_HI) <<
+			(SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_HI) <<
 			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
 		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
 		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data); @@ -7209,7 +7212,7 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
 		/* mmVGT_HS_OFFCHIP_PARAM_UMD -> mmVGT_HS_OFFCHIP_PARAM */
 		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_HS_OFFCHIP_PARAM_UMD) <<
 			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-		       (SOC15_REG_OFFSET(GC, 0, mmVGT_HS_OFFCHIP_PARAM) <<
+			(SOC15_REG_OFFSET(GC, 0, mmVGT_HS_OFFCHIP_PARAM) <<
 			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
 		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
 		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data); @@ -7217,7 +7220,7 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
 		/* mmVGT_ESGS_RING_SIZE_UMD -> mmVGT_ESGS_RING_SIZE */
 		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_ESGS_RING_SIZE_UMD) <<
 			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-		       (SOC15_REG_OFFSET(GC, 0, mmVGT_ESGS_RING_SIZE) <<
+			(SOC15_REG_OFFSET(GC, 0, mmVGT_ESGS_RING_SIZE) <<
 			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
 		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
 		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data); @@ -7225,7 +7228,7 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
 		/* mmVGT_GSVS_RING_SIZE_UMD -> mmVGT_GSVS_RING_SIZE */
 		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_GSVS_RING_SIZE_UMD) <<
 			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-		       (SOC15_REG_OFFSET(GC, 0, mmVGT_GSVS_RING_SIZE) <<
+			(SOC15_REG_OFFSET(GC, 0, mmVGT_GSVS_RING_SIZE) <<
 			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
 		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
 		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data); @@ -7233,7 +7236,7 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
 		/* mmSPI_CONFIG_CNTL_REMAP -> mmSPI_CONFIG_CNTL */
 		data = (SOC15_REG_OFFSET(GC, 0, mmSPI_CONFIG_CNTL_REMAP) <<
 			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-		       (SOC15_REG_OFFSET(GC, 0, mmSPI_CONFIG_CNTL) <<
+			(SOC15_REG_OFFSET(GC, 0, mmSPI_CONFIG_CNTL) <<
 			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
 		break;
 	}
@@ -7882,7 +7885,7 @@ static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 	if (amdgpu_sriov_is_pp_one_vf(adev))
 		data = RREG32_NO_KIQ(reg);
 	else
-		data = RREG32(reg);
+		data = RREG32_RLC(reg);
 
 	data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
 	data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
@@ -7890,7 +7893,7 @@ static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 	if (amdgpu_sriov_is_pp_one_vf(adev))
 		WREG32_SOC15_NO_KIQ(GC, 0, mmRLC_SPM_MC_CNTL, data);
 	else
-		WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
+		WREG32_SOC15_RLC(GC, 0, mmRLC_SPM_MC_CNTL, data);
 }
 
 static bool gfx_v10_0_check_rlcg_range(struct amdgpu_device *adev, @@ -8875,20 +8878,20 @@ static int gfx_v10_0_kiq_set_interrupt_state(struct amdgpu_device *adev,
 	switch (type) {
 	case AMDGPU_CP_KIQ_IRQ_DRIVER0:
 		if (state == AMDGPU_IRQ_STATE_DISABLE) {
-			tmp = RREG32_SOC15(GC, 0, mmCPC_INT_CNTL);
+			tmp = RREG32_SOC15_RLC(GC, 0, mmCPC_INT_CNTL);
 			tmp = REG_SET_FIELD(tmp, CPC_INT_CNTL,
 					    GENERIC2_INT_ENABLE, 0);
-			WREG32_SOC15(GC, 0, mmCPC_INT_CNTL, tmp);
+			WREG32_SOC15_RLC(GC, 0, mmCPC_INT_CNTL, tmp);
 
 			tmp = RREG32(target);
 			tmp = REG_SET_FIELD(tmp, CP_ME2_PIPE0_INT_CNTL,
 					    GENERIC2_INT_ENABLE, 0);
 			WREG32(target, tmp);
 		} else {
-			tmp = RREG32_SOC15(GC, 0, mmCPC_INT_CNTL);
+			tmp = RREG32_SOC15_RLC(GC, 0, mmCPC_INT_CNTL);
 			tmp = REG_SET_FIELD(tmp, CPC_INT_CNTL,
 					    GENERIC2_INT_ENABLE, 1);
-			WREG32_SOC15(GC, 0, mmCPC_INT_CNTL, tmp);
+			WREG32_SOC15_RLC(GC, 0, mmCPC_INT_CNTL, tmp);
 
 			tmp = RREG32(target);
 			tmp = REG_SET_FIELD(tmp, CP_ME2_PIPE0_INT_CNTL, @@ -9173,14 +9176,14 @@ static void gfx_v10_0_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_device *
 	data = bitmap << GC_USER_SHADER_ARRAY_CONFIG__INACTIVE_WGPS__SHIFT;
 	data &= GC_USER_SHADER_ARRAY_CONFIG__INACTIVE_WGPS_MASK;
 
-	WREG32_SOC15(GC, 0, mmGC_USER_SHADER_ARRAY_CONFIG, data);
+	WREG32_SOC15_RLC(GC, 0, mmGC_USER_SHADER_ARRAY_CONFIG, data);
 }
 
 static u32 gfx_v10_0_get_wgp_active_bitmap_per_sh(struct amdgpu_device *adev)  {
 	u32 data, wgp_bitmask;
-	data = RREG32_SOC15(GC, 0, mmCC_GC_SHADER_ARRAY_CONFIG);
-	data |= RREG32_SOC15(GC, 0, mmGC_USER_SHADER_ARRAY_CONFIG);
+	data = RREG32_SOC15_RLC(GC, 0, mmCC_GC_SHADER_ARRAY_CONFIG);
+	data |= RREG32_SOC15_RLC(GC, 0, mmGC_USER_SHADER_ARRAY_CONFIG);
 
 	data &= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_WGPS_MASK;
 	data >>= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_WGPS__SHIFT;
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 46d4bbabce75..ce04bc6dea21 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -363,7 +363,7 @@ void nv_grbm_select(struct amdgpu_device *adev,
 	grbm_gfx_cntl = REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, VMID, vmid);
 	grbm_gfx_cntl = REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, QUEUEID, queue);
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_CNTL), grbm_gfx_cntl);
+	WREG32_SOC15_RLC_SHADOW(GC, 0, mmGRBM_GFX_CNTL, grbm_gfx_cntl);
 }
 
 static void nv_vga_set_state(struct amdgpu_device *adev, bool state)
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C9e628852384f415ddc6508d8fa4fce53%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637534567965620338%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=EsW5cOaqgQZuuDzDBCarklQkivOUKv%2BVwTyXZQsz%2FwE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
