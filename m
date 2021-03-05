Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E586C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 12:51:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 355D360233
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 12:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355D360233
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9A2E6E1EC;
	Fri,  5 Mar 2021 12:51:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA0B66E1EC
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 12:51:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsfDrXLc6hreT8aQS2VodAJiVuwuxnPU/ZOwedS1oe6jdD53QvvKFfNbw+mlIvex5PxZvJwCkvy5vFgPeEj/LK8WAOcpJnILlHaKzMwlFTnugzv93gFJOaVh6rZyfB4RPwNTwoBWyhvPC8Ld9BjNBFfp3kw9p+Ub1jSA3IFRgFCu53eGhntkuBgxnvviJnwrstRmiSNIUCK7Rzx+cAks7dMBG998yJgBRu0wXukG6nQu6L4fSBKypKXjCs/kkdzE5wc1Dm10RfLVyTOKzR3UMDGRRdiTXvFMCHM0H9BhXQu8YNr0wYyVHj6Bc+fG+Ze3usWiQmBjzzuzsNQhnFmqrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkTgNdE4JykhzD7jHjGyfLISn+BGacLIUPH005jWj3o=;
 b=BMvdvc7cVkpQ1qc3vLvG+QFL5s7rOAlrwjT960jeRpizri9Xk8Z3ZtMSwM1x/aI3dPsxTpm8UCn/4no+14q9nrL3APpdjy4aMZG66SpMSgqbMAWdxTGNEK35v1EQM4C1a2+hXL0msuMmZWfNbpF0XtAZWvHKZ8lqMcWCEyFF4rJWmNkG9o19OrqktGwh8y23JQQRERdEdyRPtqyhjZWV6TgVe4jV5bAeXK//WhD6mqamA1N22JmnQnA6ld8trryJXq66sqcbsAMgm7hfuUNE2n/VuZNyrkR7m/4p9rpJaP8UvlN+BUwzq4Da74Sy1mUEpdVto+5c+ptz2OSqdAKbyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkTgNdE4JykhzD7jHjGyfLISn+BGacLIUPH005jWj3o=;
 b=xCqUkwJhQu32zCpWkd1S4HAyLQLJejUHHJ4lstXWGZZAUEHcA9yAa5KZOxt0uPo5W/vT+lFHMkhemzzByl/OjX5hCi3HmBSB4fvTwxgmHkIMnV2p49rrmaX7qLWgF95BQxNFxQENjPRXiBz9Lx+oX/EwPlToiiCN0myDo6BaEpw=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Fri, 5 Mar 2021 12:51:15 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53%5]) with mapi id 15.20.3890.029; Fri, 5 Mar 2021
 12:51:15 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove ECO_BITS programing on gmc9
Thread-Topic: [PATCH] drm/amdgpu: remove ECO_BITS programing on gmc9
Thread-Index: AQHXEZ9p+bPsgPmjMk2unqhiqB60W6p1WIQQ
Date: Fri, 5 Mar 2021 12:51:14 +0000
Message-ID: <DM6PR12MB407548DAD45BDCB050FF2DEAFC969@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20210305091006.65628-1-Feifei.Xu@amd.com>
In-Reply-To: <20210305091006.65628-1-Feifei.Xu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-05T12:51:12Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=f7fa7741-d34d-4002-93b3-b75e7eb37330;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 28cd3487-0912-4bfe-80b7-08d8dfd55cce
x-ms-traffictypediagnostic: DM5PR12MB1163:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB116326D9E2F9D2EC9B38298CFC969@DM5PR12MB1163.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C4qYQFnniHoewedXZi0ap3ZUcbZ6yCifUHMLBvgLtXKWCQaTfv37VgRt/ywecwHec0l7u+tkS0qI/tP8K7w7UZKHDqal3XDtrYqtAcCj5Srd4xODMnndcQc5b4/N7EzZoOB8jpoIEP7nDUJg20bufY/3I3rdMT27m4WJYmnJPSdPf0XgC8J/jW3fWzDrt0QkxvujwMB9mWlyopo0SZXKpsmpL8n679jf1qa4GM+OnnpC7x62/T1lNlM82B+ePVRI4crCdE5qYRXo+fPRVdrOewng5Yc3GPBpBZDPwKBzz/vA0D+2/evUdPx+h/LYVBtPk2sUd9nGcAqkcCbvUfRVaAEu+4evO1AC7H7AFfaq6ksGy5INXRFceV07Pfwv6jbMmgpaUtTgYrYAUL3J1RmNwPejKMNWGy2jxCdfYE2YGqqWom+vwA173nh/92JWnlXwJb4aE8xLxtr1XVt8o9Ecf/edhQ6Xwx+v1VYKtkSFxdkz5o2lEbsDbxL+Hp11c5E6JmqE7o5GPj7JcH/nd4ePNf7cI2W+4oc4z8BIctOWuWP0WTH4OoE0bIwHj0AkJ27S
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(5660300002)(8936002)(52536014)(9686003)(66446008)(66946007)(66556008)(76116006)(186003)(55016002)(66476007)(64756008)(71200400001)(8676002)(4326008)(478600001)(86362001)(2906002)(7696005)(316002)(110136005)(26005)(33656002)(54906003)(83380400001)(53546011)(6506007)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ZHddWNLLlgIFp4Vlkc+1/duIdpyoVFrlZ6nWY2VDghSm1VtsrbVivk5dOXc6?=
 =?us-ascii?Q?c/CuxOilCT2KZdSH/fhd6gNfhibLckUsceK0W0weP0n8HCblXRV1HpC8ntOt?=
 =?us-ascii?Q?BaQ8JNpVWt4NIvhTDIWVMfIgmso5C8deQPajr4g/ct4X/EjD9fPlWjgI2WI/?=
 =?us-ascii?Q?lU6jGMyx6OvETBfrQgWp0XSAJBmMjI/J/gWnGjvtMHA7wsoqF1c+Lxio7/u0?=
 =?us-ascii?Q?lcyMFpx0UkWK1k/wHKqoHDI2P+eg8adOu65mTnRfcu4PhTIjgpIcGS+HyTcq?=
 =?us-ascii?Q?yQqP1t/Pm3PlINQmHOFVN8grD2UvhUA+gmDAvN4sIXeZQmxiAA1Db1c/ygyy?=
 =?us-ascii?Q?UYwt5Ls/2wzx5fpREkMS3S23pGR0gefrOEFAKAHfX9sLOtzcdXrAH0zNQy6c?=
 =?us-ascii?Q?ARskKC0fxQscLRLD/r82lLkhZkejmLd40llvd8fzGD9sImqOp7Z/DqH/tRjB?=
 =?us-ascii?Q?shyr8abTf0zD4DuMd2+I3ufZp6VJADQi5ItUl04WryqCzCWntmdQ2T4aNju9?=
 =?us-ascii?Q?ZKiHTaXnOEU9e/yYnWa7ZjALCviUVHPBKxPk9QGbAWD+bpR1141Xiqe5GkI8?=
 =?us-ascii?Q?XjNlImzY/7YzaoCS2gT6KyaRM+TEPpqR60EeZlTM7If+j/axBU1FM+eqnr3t?=
 =?us-ascii?Q?BZbleN827acVefrUs3Olqmo+5OXRL+ilk9I8ppJlyIwPZL+L7HkVtZEbRcRX?=
 =?us-ascii?Q?gENuKBfCY8gDUzHqqYlJFRP7V53RThdkeseXlh3T2cf9Pr0meaKgdeUGZJp4?=
 =?us-ascii?Q?lmmDaWqRwsHkig9lSUfZJN0+dTqChjOAwidTT8Mr2pJfJHBzSe14gv1Qn4cQ?=
 =?us-ascii?Q?5IOzg+z1ozor2kgXI85Y9ERS1oL9HK3RX6/3qSGtjwJBjQqf/rjLiTLr/Uns?=
 =?us-ascii?Q?XwMQZU4bm2cRXJmB0R60LxuAM8nBDWisDWPsLKqdNyzYONsrLwD0fQBh4oim?=
 =?us-ascii?Q?2ibVNBYLZO74xz/dGh8z6Qp6Tny70cd+JdkOdWsiJ3rVh24xFL5bceDHVIJs?=
 =?us-ascii?Q?Aswm78F5BtyDUYDlIsSPFmOOcbM/P6IlQyPzLFxVJkIvvX3muDdGhuyiFlkI?=
 =?us-ascii?Q?19zOYu4AexlBHStUa57YNeK75Dq08NlbZd69M/HwL2MjeMNWb3TzB931v/El?=
 =?us-ascii?Q?afiTIYmO+BZpcSb8lifoF0rfkvAhI2hQxxNFA3TVslsno86t4bTJh+Ik8d46?=
 =?us-ascii?Q?vSMZP76gu1hOJr1xjM7EilOgwj3yKovWwwTY4LgdYrT9I8t7qw/RS9NLOGjI?=
 =?us-ascii?Q?VlSLnnbvjtGdBiWR1ctC84F5o9IU6Sg80R6s79RYUoOpwUJHkYc4Jazs6OC8?=
 =?us-ascii?Q?gDwCIlBGnPjhy0Gjhi3CYcyZ?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28cd3487-0912-4bfe-80b7-08d8dfd55cce
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2021 12:51:15.0004 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b02QXUHa9poQv3FQd5jCytjWm/yWf7t4yIuak58P5SzAe2/nJ7w/rL6KdnoV0Frvm1nnu19JZESuQIo5yEVF2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1163
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
Cc: "Lin, Amber" <Amber.Lin@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Jin, 
 Anna" <Anna.Jin@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Per discussion, please work with Anna to identify the potential risk in SRIOV guest driver (VEGA10) before pushing the patch. Thanks.

Regards,
Hawking
-----Original Message-----
From: Feifei Xu <Feifei.Xu@amd.com> 
Sent: Friday, March 5, 2021 17:10
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Lin, Amber <Amber.Lin@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>
Subject: [PATCH] drm/amdgpu: remove ECO_BITS programing on gmc9

Remove the ECO_BITS programing in driver on gfxhub1.0, mmhub1_x and mmhub_9.4.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 1 -  drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c  | 1 -  drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c  | 1 -  drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c  | 2 --
 4 files changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 0ab498d93e48..0cf993797df8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -186,7 +186,6 @@ static void gfxhub_v1_0_init_tlb_regs(struct amdgpu_device *adev)
 			    ENABLE_ADVANCED_DRIVER_MODEL, 1);
 	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
 			    SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
-	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ECO_BITS, 0);
 	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
 			    MTYPE, MTYPE_UC);/* XXX for emulation. */
 	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ATC_EN, 1); diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 0145d4d201cf..37b985317012 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -164,7 +164,6 @@ static void mmhub_v1_0_init_tlb_regs(struct amdgpu_device *adev)
 			    ENABLE_ADVANCED_DRIVER_MODEL, 1);
 	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
 			    SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
-	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ECO_BITS, 0);
 	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
 			    MTYPE, MTYPE_UC);/* XXX for emulation. */
 	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ATC_EN, 1); diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 816ff110a074..9099162553a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -189,7 +189,6 @@ static void mmhub_v1_7_init_tlb_regs(struct amdgpu_device *adev)
 			    ENABLE_ADVANCED_DRIVER_MODEL, 1);
 	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
 			    SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
-	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ECO_BITS, 0);
 	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
 			    MTYPE, MTYPE_UC);/* XXX for emulation. */
 	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ATC_EN, 1); diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index 65fb88d391d3..d68f3cd2d40d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -219,8 +219,6 @@ static void mmhub_v9_4_init_tlb_regs(struct amdgpu_device *adev, int hubid)
 			    ENABLE_ADVANCED_DRIVER_MODEL, 1);
 	tmp = REG_SET_FIELD(tmp, VMSHAREDVC0_MC_VM_MX_L1_TLB_CNTL,
 			    SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
-	tmp = REG_SET_FIELD(tmp, VMSHAREDVC0_MC_VM_MX_L1_TLB_CNTL,
-			    ECO_BITS, 0);
 	tmp = REG_SET_FIELD(tmp, VMSHAREDVC0_MC_VM_MX_L1_TLB_CNTL,
 			    MTYPE, MTYPE_UC);/* XXX for emulation. */
 	tmp = REG_SET_FIELD(tmp, VMSHAREDVC0_MC_VM_MX_L1_TLB_CNTL,
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
