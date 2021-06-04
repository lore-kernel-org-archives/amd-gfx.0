Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44296C4743D
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 16:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0643960FE7
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 16:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0643960FE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B83056F61A;
	Fri,  4 Jun 2021 16:41:46 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2058.outbound.protection.outlook.com [40.107.100.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A7216E2E3
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 16:41:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECR+COTHjiMRDhLKrm+xJbPjmOOvRi/EohAQFKVbfK7tj4+1Eu2F0RgnnwiDDTZLODgefWryyEWUSYR/wQBZrmJnPV6SCznxZ8vOPXqt60zOCu05nPAb8aonw6EaKK7Mgi63sSTSkxfhdRB3gBtA5bexL8DsTGVl1xldieT4fPwdO0JcnUflicwsdSQF6g2Ky5BUwaFwC8dRUDBYvwLLA5BUT38XjoQ10XJWf/1G7gSb2xek/kHsZ7YsmigHRy7fK6ITTknm2TEA3i6Vhw5hjsOH8sGGAAw/NjlUkhgYdVEXMqL3WNH1UpsPgFgRe7Ttr5tfdnfnX49u+/ZMW3ns9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GK18JbrDYfQtM2Z28f5bCKnHwUTjT+w0+eFfGTfM8w=;
 b=L2Pvac9MA/mk2j05vghIUdxCQFaZ9g6wAMuVphoOTl6SSoMcoVMyWx4peDXm1YcDyoL+0OQ8dlXoqAbH0hd5C2R4Xa9S0Sv6s7crQYSZVN/xPioUyF/VNZytUJjStX6ywnwqGjbvxSExAmzQeZUIqBfIbTpFxkxwzvG2HMUlLuckv6fqw3eui2ubSLZs6ZEmzMHh5Zp9xPwr4ZKa3/cxWapPyIU3be4N/76dHMI4lwDXbCLtS/SblPJLtx9sPSxWzBUImKyBIkjZLPqL9vUfbHTxTu3KTvy5tftfFHHTIv2PkTJqqvBawftE/LT91HC5pdoFKQS4IJ3m3lMXnWcLow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GK18JbrDYfQtM2Z28f5bCKnHwUTjT+w0+eFfGTfM8w=;
 b=RcaxHahw8d5QI6t0M+Z9DX2D0RbpeSaKcPPbYjwvp9R6Qf+ZfLvZ2bI81zOOUerEPggp6v7+6Q4z85K3EFbrk8npgypKr3sqlzVk8f9wG4yDbvewaiLH0GTVfRwtMDl2LX5f3y8N4AsUZUBhlkixxDnYM+yaH7BCSInpV7lx40g=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4453.namprd12.prod.outlook.com (2603:10b6:208:260::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Fri, 4 Jun
 2021 16:41:42 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%9]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 16:41:42 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Khaire, Rohit" <Rohit.Khaire@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deng, Emily" <Emily.Deng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhou,
 Peng Ju" <PengJu.Zhou@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Modify GC register access to use _SOC15 macros
Thread-Topic: [PATCH] drm/amdgpu: Modify GC register access to use _SOC15
 macros
Thread-Index: AQHXWWAXD+1ZzwHG3ECc2pNipVMc5KsEDiWm
Date: Fri, 4 Jun 2021 16:41:42 +0000
Message-ID: <MN2PR12MB448897BAA9409E1D8389EF63F73B9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210604163826.21693-1-rohit.khaire@amd.com>
In-Reply-To: <20210604163826.21693-1-rohit.khaire@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-04T16:41:41.704Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f304119b-b4b8-4e13-13f8-08d92777a22e
x-ms-traffictypediagnostic: MN2PR12MB4453:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB445342C6CBAC404BC8554DC7F73B9@MN2PR12MB4453.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dwXaZsKPcdnbZNb9zhOdSkJVU86esEuhqVq4JG9TDH4HnStwd03YTmSvYtnQP+c7LCz6biIZHbCClx83bHMqhJIbbrFhjGdUt6LE5UpEVAp7nUNX/2Afc0EgICIXbSgyPEFDEvU8WFQuF7M4F2Jc3NhhTSv2bxT28JQtan0+4FVQJY6jc7I8XWziU3tEW3Dzr5WHHxb4l7WHGvkWJ8v7UrrfYFLRVkECS4BhNn8W/M3EoD29O7KBbKZLKU8iTVr0PtThp1A51iQ/iiTJtJELcl7iISAa412Jk0nVq5MoWOgbQ8P/V3xp2KTxXNZBwbDVqU1O+/r/y+JWu0fm1yHmLKk0/zP8h8rGpqlF5oSmEVVAk0UoJ1lpx4hSrCAvlYwd9hQDTC+ROGxOXB2lptLv7RALbOPsUaN8rWTvFhviNwGKwAjTgiVRrJvoJzFoaCYhCnQyaPWJLqFxnSKSODSNGlP3QIXPEofbx0xTMgSrB4k6MThwXL2wlvSGUNnYu2uMWbJv4bgWC3lCttBEORnS3MjhhPxjMPAZpjtiOrSQM5ha2SPRLWYYSDKzlkTqICGbP79RoYQyeCgJQTpF24xbMHc8AJBbSSV6guOG9FWfyjdUR6Uf1gwVWTzqDuNiE7YqpVYaJ131h2xAmleeCGZQGw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(396003)(136003)(366004)(376002)(346002)(19627405001)(38100700002)(5660300002)(478600001)(122000001)(8676002)(8936002)(921005)(76116006)(55016002)(9686003)(66476007)(66556008)(66446008)(64756008)(66946007)(83380400001)(2906002)(7696005)(316002)(26005)(6636002)(4326008)(110136005)(186003)(33656002)(54906003)(52536014)(6506007)(71200400001)(86362001)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UnNGtuCm3Otmpsc+OLTNmExetTXSTRG0ZOERXMT1/HMHcBaSV9n0LKgWC5QX?=
 =?us-ascii?Q?wqBMjg+dLUFmg9ld+k8zJRzxxTYVQjDiz02eu7piYzy+0x4h6EKNr3L6Vnmn?=
 =?us-ascii?Q?ycKdWHNKEsLkCJVDtK401DHa+TzBw+XSNQeVZe/sq2p/OPgGr7V2SfpybCeB?=
 =?us-ascii?Q?adSZPtxuyatu6NFwQsFZ34f7QZ9/1RK5UHE1nQ1NBsjuYGUOxWBdagbdo1pT?=
 =?us-ascii?Q?YhWk16V+nk3+l9xpeuUbt37c6Bw9CGRbkziAin6SBF8H7tV71raz+y/B1DM4?=
 =?us-ascii?Q?4UEDY8mUmRbOFH3kyqmw2y5LaTP/467qrr6KSMk8kIpy7SYl4s76TyP9aIVj?=
 =?us-ascii?Q?T/GueyWLt9p/2gUwJTrR1qkEdpuZbI/p6EhB1Zz0CxodsOuzRBYKaVSpvsan?=
 =?us-ascii?Q?OhhuUVptbOhlnlwvjq50CwfoJBuz2qbmiCpFGi869rzwzPT0zALSrncaVmy1?=
 =?us-ascii?Q?T6hn3j0Hg3FqzrdN+eNZz+tWa6rEge3kI5GEYbfOj+Cf7zWlmnp1+ezSqmT+?=
 =?us-ascii?Q?5PIbMMm1Ku3ghh6b04QW+iZqNHbLVS6+eE3zgNpz3z6Hm32mCEfEr7zPnMgJ?=
 =?us-ascii?Q?hTWWumCSw0oPa2mkTbmHHBkRn8ndTHkF5IaIagrFU6zrsXGiMxnvSES6gu8f?=
 =?us-ascii?Q?J0K1UsYPek8ZE6l9a7gdOHUuhHdmbpWFgotJnfvmqq/O/B8+lcyffiBjsD2I?=
 =?us-ascii?Q?cljHs9mY7mAiCDN/Om4cNzdUDVmr0hWNn83hWW5UqL67DN/UxIjZSovcNsLI?=
 =?us-ascii?Q?g3QmMumcK76+0JHHn4U0WQUtutCMCMUJmDO/4UYx4tj/kVGTjdXyrB2aFTck?=
 =?us-ascii?Q?WwjmJSbhdD9M1iiQ7/hsQmiJ1zoVjjowSgk+IzzsarfyAwBWJbXiWIu2rb+H?=
 =?us-ascii?Q?EUrY2EUGhmU/QeX3xXPNlzmJbWDziieYfkopvbHMgKYwdj78K+kgWkUud4+I?=
 =?us-ascii?Q?drKEVW8nNzrzOGkXYOzh99rhWUw/PTzrxWMk/PFoO78FzX+0GcDdAy8K2lQr?=
 =?us-ascii?Q?e7Cd+p6lpjsftmhNPvcPBEvxpGTsl07Rita/Dq5TRrWdKTck1uGiJcvAGWy7?=
 =?us-ascii?Q?NxjzE+4Krl8eugvHx8hPhslTUW+wt++uCl7K0J3w9IO/CtTi133smCBneOIO?=
 =?us-ascii?Q?rRSBRXJLmS1wXGIUu1PgpXdyTtLrsXG4YrY1gf4SzZsadaoT5w/dpRKhFhkH?=
 =?us-ascii?Q?Ap6HZn6RazUWOrNKqO8ig5uVxaTKWKSQu5tW6DgrYfDhfbvSUhYNJAD7UNzj?=
 =?us-ascii?Q?zwsUBSETroby/yYLABJjQw7BQWa2+ZD03Zogjw2yndbDjUNW3SH6oL3bUAxa?=
 =?us-ascii?Q?o8uak5Lr1Ui1N+LN1dkx1keC?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f304119b-b4b8-4e13-13f8-08d92777a22e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 16:41:42.3622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d/SQCYROPlg+vAnHV829uX0wILmUg61ZZ92j7fd5Mh8vopiox6p4QKc91nMOycz7Ngm/QQ9CsOHy/9hzrBZ7wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4453
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
Cc: "Ming, Davis" <Davis.Ming@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: multipart/mixed; boundary="===============1344065299=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1344065299==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448897BAA9409E1D8389EF63F73B9MN2PR12MB4488namp_"

--_000_MN2PR12MB448897BAA9409E1D8389EF63F73B9MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Khaire, Rohit <Rohit.Khaire@amd.com>
Sent: Friday, June 4, 2021 12:38 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Deng, Emily <Emily.Deng@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhou, =
Peng Ju <PengJu.Zhou@amd.com>; Chen, Horace <Horace.Chen@amd.com>
Cc: Ming, Davis <Davis.Ming@amd.com>; Khaire, Rohit <Rohit.Khaire@amd.com>;=
 Koenig, Christian <Christian.Koenig@amd.com>; Khaire, Rohit <Rohit.Khaire@=
amd.com>
Subject: [PATCH] drm/amdgpu: Modify GC register access to use _SOC15 macros

In SRIOV environment, KMD should access GC registers
with RLCG if GC indirect access flag enabled.

Using _SOC15 read/write macros ensures that they go
through RLC when flag is enabled.

Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  | 42 +++++++++----------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index d39cff4a1fe3..1f5620cc3570 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -95,8 +95,8 @@ static void program_sh_mem_settings_v10_3(struct kgd_dev =
*kgd, uint32_t vmid,

         lock_srbm(kgd, 0, 0, 0, vmid);

-       WREG32(SOC15_REG_OFFSET(GC, 0, mmSH_MEM_CONFIG), sh_mem_config);
-       WREG32(SOC15_REG_OFFSET(GC, 0, mmSH_MEM_BASES), sh_mem_bases);
+       WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, sh_mem_config);
+       WREG32_SOC15(GC, 0, mmSH_MEM_BASES, sh_mem_bases);
         /* APE1 no longer exists on GFX9 */

         unlock_srbm(kgd);
@@ -129,7 +129,7 @@ static int init_interrupts_v10_3(struct kgd_dev *kgd, u=
int32_t pipe_id)

         lock_srbm(kgd, mec, pipe, 0, 0);

-       WREG32(SOC15_REG_OFFSET(GC, 0, mmCPC_INT_CNTL),
+       WREG32_SOC15(GC, 0, mmCPC_INT_CNTL,
                 CP_INT_CNTL_RING0__TIME_STAMP_INT_ENABLE_MASK |
                 CP_INT_CNTL_RING0__OPCODE_ERROR_INT_ENABLE_MASK);

@@ -212,10 +212,10 @@ static int hqd_load_v10_3(struct kgd_dev *kgd, void *=
mqd, uint32_t pipe_id,

                 pr_debug("kfd: set HIQ, mec:%d, pipe:%d, queue:%d.\n",
                         mec, pipe, queue_id);
-               value =3D RREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_CP_SCHEDULER=
S));
+               value =3D RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
                 value =3D REG_SET_FIELD(value, RLC_CP_SCHEDULERS, schedule=
r1,
                         ((mec << 5) | (pipe << 3) | queue_id | 0x80));
-               WREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_CP_SCHEDULERS), value)=
;
+               WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, value);
         }

         /* HQD registers extend from CP_MQD_BASE_ADDR to CP_HQD_EOP_WPTR_M=
EM. */
@@ -224,13 +224,13 @@ static int hqd_load_v10_3(struct kgd_dev *kgd, void *=
mqd, uint32_t pipe_id,

         for (reg =3D hqd_base;
              reg <=3D SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_HI); reg++)
-               WREG32(reg, mqd_hqd[reg - hqd_base]);
+               WREG32_SOC15_IP(GC, reg, mqd_hqd[reg - hqd_base]);


         /* Activate doorbell logic before triggering WPTR poll. */
         data =3D REG_SET_FIELD(m->cp_hqd_pq_doorbell_control,
                              CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_EN, 1);
-       WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL), data)=
;
+       WREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL, data);

         if (wptr) {
                 /* Don't read wptr with get_user because the user
@@ -259,17 +259,17 @@ static int hqd_load_v10_3(struct kgd_dev *kgd, void *=
mqd, uint32_t pipe_id,
                 guessed_wptr +=3D m->cp_hqd_pq_wptr_lo & ~(queue_size - 1)=
;
                 guessed_wptr +=3D (uint64_t)m->cp_hqd_pq_wptr_hi << 32;

-               WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_LO),
+               WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_LO,
                        lower_32_bits(guessed_wptr));
-               WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_HI),
+               WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_HI,
                        upper_32_bits(guessed_wptr));
-               WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR),
+               WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR,
                        lower_32_bits((uint64_t)wptr));
-               WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_H=
I),
+               WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI,
                        upper_32_bits((uint64_t)wptr));
                 pr_debug("%s setting CP_PQ_WPTR_POLL_CNTL1 to %x\n", __fun=
c__,
                          (uint32_t)get_queue_mask(adev, pipe_id, queue_id)=
);
-               WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1),
+               WREG32_SOC15(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1,
                        (uint32_t)get_queue_mask(adev, pipe_id, queue_id));
         }

@@ -279,7 +279,7 @@ static int hqd_load_v10_3(struct kgd_dev *kgd, void *mq=
d, uint32_t pipe_id,
                              CP_HQD_EOP_RPTR, INIT_FETCHER, 1));

         data =3D REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1)=
;
-       WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE), data);
+       WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, data);

         release_queue(kgd);

@@ -350,7 +350,7 @@ static int hqd_dump_v10_3(struct kgd_dev *kgd,
                 if (WARN_ON_ONCE(i >=3D HQD_N_REGS))      \
                         break;                          \
                 (*dump)[i][0] =3D (addr) << 2;            \
-               (*dump)[i++][1] =3D RREG32(addr);         \
+               (*dump)[i++][1] =3D RREG32_SOC15_IP(GC, addr);            \
         } while (0)

         *dump =3D kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
@@ -482,13 +482,13 @@ static bool hqd_is_occupied_v10_3(struct kgd_dev *kgd=
, uint64_t queue_address,
         uint32_t low, high;

         acquire_queue(kgd, pipe_id, queue_id);
-       act =3D RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
+       act =3D RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
         if (act) {
                 low =3D lower_32_bits(queue_address >> 8);
                 high =3D upper_32_bits(queue_address >> 8);

-               if (low =3D=3D RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_B=
ASE)) &&
-                  high =3D=3D RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_B=
ASE_HI)))
+               if (low =3D=3D RREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE) &&
+                  high =3D=3D RREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE_HI))
                         retval =3D true;
         }
         release_queue(kgd);
@@ -542,11 +542,11 @@ static int hqd_destroy_v10_3(struct kgd_dev *kgd, voi=
d *mqd,
                 break;
         }

-       WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_DEQUEUE_REQUEST), type);
+       WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, type);

         end_jiffies =3D (utimeout * HZ / 1000) + jiffies;
         while (true) {
-               temp =3D RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
+               temp =3D RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
                 if (!(temp & CP_HQD_ACTIVE__ACTIVE_MASK))
                         break;
                 if (time_after(jiffies, end_jiffies)) {
@@ -626,7 +626,7 @@ static int wave_control_execute_v10_3(struct kgd_dev *k=
gd,

         mutex_lock(&adev->grbm_idx_mutex);

-       WREG32(SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX), gfx_index_val);
+       WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, gfx_index_val);
         WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_CMD), sq_cmd);

         data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX,
@@ -636,7 +636,7 @@ static int wave_control_execute_v10_3(struct kgd_dev *k=
gd,
         data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX,
                 SE_BROADCAST_WRITES, 1);

-       WREG32(SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX), data);
+       WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, data);
         mutex_unlock(&adev->grbm_idx_mutex);

         return 0;
--
2.17.1


--_000_MN2PR12MB448897BAA9409E1D8389EF63F73B9MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Khaire, Rohit &lt;Roh=
it.Khaire@amd.com&gt;<br>
<b>Sent:</b> Friday, June 4, 2021 12:38 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &=
lt;Hawking.Zhang@amd.com&gt;; Deng, Emily &lt;Emily.Deng@amd.com&gt;; Liu, =
Monk &lt;Monk.Liu@amd.com&gt;; Zhou, Peng Ju &lt;PengJu.Zhou@amd.com&gt;;
 Chen, Horace &lt;Horace.Chen@amd.com&gt;<br>
<b>Cc:</b> Ming, Davis &lt;Davis.Ming@amd.com&gt;; Khaire, Rohit &lt;Rohit.=
Khaire@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Kha=
ire, Rohit &lt;Rohit.Khaire@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Modify GC register access to use _SOC15=
 macros</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">In SRIOV environment, KMD should access GC registe=
rs<br>
with RLCG if GC indirect access flag enabled.<br>
<br>
Using _SOC15 read/write macros ensures that they go<br>
through RLC when flag is enabled.<br>
<br>
Signed-off-by: Rohit Khaire &lt;rohit.khaire@amd.com&gt;<br>
---<br>
&nbsp;.../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c&nbsp; | 42 +++++++++----=
------<br>
&nbsp;1 file changed, 21 insertions(+), 21 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c<br>
index d39cff4a1fe3..1f5620cc3570 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c<br>
@@ -95,8 +95,8 @@ static void program_sh_mem_settings_v10_3(struct kgd_dev =
*kgd, uint32_t vmid,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lock_srbm(kgd, 0, 0, 0, vm=
id);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmSH_M=
EM_CONFIG), sh_mem_config);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmSH_M=
EM_BASES), sh_mem_bases);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, =
sh_mem_config);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmSH_MEM_BASES, s=
h_mem_bases);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* APE1 no longer exists o=
n GFX9 */<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unlock_srbm(kgd);<br>
@@ -129,7 +129,7 @@ static int init_interrupts_v10_3(struct kgd_dev *kgd, u=
int32_t pipe_id)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lock_srbm(kgd, mec, pipe, =
0, 0);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmCPC_=
INT_CNTL),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCPC_INT_CNTL,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; CP_INT_CNTL_RING0__TIME_STAMP_INT_ENABLE_MASK |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; CP_INT_CNTL_RING0__OPCODE_ERROR_INT_ENABLE_MASK);<br>
&nbsp;<br>
@@ -212,10 +212,10 @@ static int hqd_load_v10_3(struct kgd_dev *kgd, void *=
mqd, uint32_t pipe_id,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;kfd: set HIQ, mec:%d, pipe:%d, queue:%=
d.\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mec, =
pipe, queue_id);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; value =3D RREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_CP_SCHEDULERS));<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; value =3D RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; value =3D REG_SET_FIELD(value, RLC_CP_SCHEDULERS, sch=
eduler1,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((mec=
 &lt;&lt; 5) | (pipe &lt;&lt; 3) | queue_id | 0x80));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_CP_SCHEDULERS), value);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, value);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* HQD registers extend fr=
om CP_MQD_BASE_ADDR to CP_HQD_EOP_WPTR_MEM. */<br>
@@ -224,13 +224,13 @@ static int hqd_load_v10_3(struct kgd_dev *kgd, void *=
mqd, uint32_t pipe_id,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (reg =3D hqd_base;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; reg &lt;=3D SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_HI); reg++)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(reg, mqd_hqd[reg - hqd_base]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15_IP(GC, reg, mqd_hqd[reg - hqd_base]);<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Activate doorbell logic=
 before triggering WPTR poll. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(m-&=
gt;cp_hqd_pq_doorbell_control,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_EN, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_H=
QD_PQ_DOORBELL_CONTROL), data);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORB=
ELL_CONTROL, data);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (wptr) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Don't read wptr with get_user because the user<br>
@@ -259,17 +259,17 @@ static int hqd_load_v10_3(struct kgd_dev *kgd, void *=
mqd, uint32_t pipe_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; guessed_wptr +=3D m-&gt;cp_hqd_pq_wptr_lo &amp; ~(que=
ue_size - 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; guessed_wptr +=3D (uint64_t)m-&gt;cp_hqd_pq_wptr_hi &=
lt;&lt; 32;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_LO),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_LO,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bi=
ts(guessed_wptr));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_HI),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_HI,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bi=
ts(guessed_wptr));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bi=
ts((uint64_t)wptr));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bi=
ts((uint64_t)wptr));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;%s setting CP_PQ_WPTR_POLL_CNTL1 to %x=
\n&quot;, __func__,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 (uint32_t)get_queue_mask(adev, pipe_id, queue_id));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint32_t)g=
et_queue_mask(adev, pipe_id, queue_id));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -279,7 +279,7 @@ static int hqd_load_v10_3(struct kgd_dev *kgd, void *mq=
d, uint32_t pipe_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; CP_HQD_EOP_RPTR, INIT_FETCHER, 1));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(m-&=
gt;cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_H=
QD_ACTIVE), data);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, =
data);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_queue(kgd);<br>
&nbsp;<br>
@@ -350,7 +350,7 @@ static int hqd_dump_v10_3(struct kgd_dev *kgd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (WARN_ON_ONCE(i &gt;=3D HQD_N_REGS))&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (*dump)[i][0] =3D (addr) &lt;&lt; 2;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (*dump)[i++][1] =3D RREG32(addr);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (*dump)[i++][1] =3D RREG32_SOC15_IP(GC, addr);&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (0)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *dump =3D kmalloc(HQD_N_RE=
GS*2*sizeof(uint32_t), GFP_KERNEL);<br>
@@ -482,13 +482,13 @@ static bool hqd_is_occupied_v10_3(struct kgd_dev *kgd=
, uint64_t queue_address,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t low, high;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; acquire_queue(kgd, pipe_id=
, queue_id);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; act =3D RREG32(SOC15_REG_OFFSET(GC, 0=
, mmCP_HQD_ACTIVE));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; act =3D RREG32_SOC15(GC, 0, mmCP_HQD_=
ACTIVE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (act) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; low =3D lower_32_bits(queue_address &gt;&gt; 8);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; high =3D upper_32_bits(queue_address &gt;&gt; 8);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (low =3D=3D RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_BASE))=
 &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; high =3D=3D RREG32(SOC15_REG_OFFSET(GC, 0, mmC=
P_HQD_PQ_BASE_HI)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (low =3D=3D RREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE) &amp;&amp;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; high =3D=3D RREG32_SOC15(GC, 0, mmCP_HQD_PQ_BA=
SE_HI))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retva=
l =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_queue(kgd);<br>
@@ -542,11 +542,11 @@ static int hqd_destroy_v10_3(struct kgd_dev *kgd, voi=
d *mqd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_H=
QD_DEQUEUE_REQUEST), type);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_=
REQUEST, type);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end_jiffies =3D (utimeout =
* HZ / 1000) + jiffies;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (true) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp =3D RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp =3D RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!(temp &amp; CP_HQD_ACTIVE__ACTIVE_MASK))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (time_after(jiffies, end_jiffies)) {<br>
@@ -626,7 +626,7 @@ static int wave_control_execute_v10_3(struct kgd_dev *k=
gd,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;g=
rbm_idx_mutex);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmGRBM=
_GFX_INDEX), gfx_index_val);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX,=
 gfx_index_val);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC=
, 0, mmSQ_CMD), sq_cmd);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(dat=
a, GRBM_GFX_INDEX,<br>
@@ -636,7 +636,7 @@ static int wave_control_execute_v10_3(struct kgd_dev *k=
gd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(dat=
a, GRBM_GFX_INDEX,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SE_BROADCAST_WRITES, 1);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmGRBM=
_GFX_INDEX), data);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX,=
 data);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt=
;grbm_idx_mutex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448897BAA9409E1D8389EF63F73B9MN2PR12MB4488namp_--

--===============1344065299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1344065299==--
