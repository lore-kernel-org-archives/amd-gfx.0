Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F99C76196
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Apr 2023 08:14:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CEE410EB0F;
	Thu,  6 Apr 2023 08:14:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D9F910EB0F
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Apr 2023 08:14:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNXMmBGMUrNQaohenrjYDEaQCZ1UShay+kyNSGXCcu48KX0iUNfY+jOHSGGDv4aT1W2zF0y7N6pTIkzfwWWti8eNUsVsxinw2uBgTbdaT6E+Ehq66K1++eISw8sK8ufKt9m6kQoNNCbREEMA50DEnxuh0UKyKSNx8e+OtQH7/iksqtpd5jvdIPdnJi7KJKQj7Cletqf4YLbqsQp2SLpaFeZlr4qsa7X4B8fYiwJyLdXrwkoaiqnePrpI5T1UlHnJe1R5ve9H1OJmdX23HDfjLqcD+VPeA6kvg75tVS01ieXzDPcvHGdKrFiRpXino/b3G3sJxwAqBpfBH8dkQWYGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsLNW9aKLMNH62HMcTEav+eSEkNXPt9lp4+eviWQEK4=;
 b=lfIiftW/jk0w0Rh6RfePiPAVU3/nJ7tLC7PeyNhKiJ/ixASF4dDHVEJil47NEnjCVUO0mv1gNkHGamolXCKJZptQMAbrx9dauuflywxCcnt9du7wFlNrjnr5kfWSAnSeshlP5N40Wkwl5xhDQFaTVY8nxNgyLTXVNzANJZ3aAjtH8pjjPAVzCM5gpSqARAwghNopbyzBaOwSVVrOu6pwS0ri7mN61NabiPrrb8zLvobOkN1bCS9EAI1rcBpz9KNqFyvQ8EcRjTA1pLylx3wg8QV0s9m2IQb7F7hdv0isMz2FsME4uqvIQV2I9toIhXHSnFy5uY+w2ac+VyYk/nzgeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsLNW9aKLMNH62HMcTEav+eSEkNXPt9lp4+eviWQEK4=;
 b=nBNJ5nNnC53T9DICBkyrTgaNxIi+RS+BZGgYxLt6EZUmwHVMQ9rVwVDaUew4Pi1MeZuEosofsrZ2EA0iBOnBWHvm7B81dpA2XF9VHDEryS5S7JU36auXwdleNPBDpvrI9Hhoyshazy8EccVON1Wvi8KnIlr/eEZyX99NG53jCz4=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by PH0PR12MB8173.namprd12.prod.outlook.com (2603:10b6:510:296::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 08:14:21 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::ed05:6d43:7df0:5af1]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::ed05:6d43:7df0:5af1%3]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 08:14:21 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Li, Lyndon" <Lyndon.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix sdma v4 sw fini error
Thread-Topic: [PATCH] drm/amdgpu: Fix sdma v4 sw fini error
Thread-Index: AQHZaF91W7YBg/UFJUaAsAXu9Hc1W68d7r/A
Date: Thu, 6 Apr 2023 08:14:21 +0000
Message-ID: <CH2PR12MB415280023D9306CE48AA78BBFE919@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20230406081142.1426354-1-Lyndon.Li@amd.com>
In-Reply-To: <20230406081142.1426354-1-Lyndon.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-06T08:14:15Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=534748de-2247-4455-8a8f-72c389cc7c08;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-06T08:14:15Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: f8c525e8-7cc5-41bd-b61e-0e4de5ae5f60
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|PH0PR12MB8173:EE_
x-ms-office365-filtering-correlation-id: 89e33682-b320-43aa-d496-08db3676ece0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jy5cGMY9Ll5AeBLCxMtX/0L9L6Q7hiDCi8RDyszJXkRCaCLvCLFtwjfvlRA/cEZ46RMhpAopVmTcc5yUD/vmovXdJ2tLI/BB5rZx8iXR85R9ytvWWYLNu39rcPWGTZm1adPn1DvBCCIoAjuxhq9XdTdBR/eZlO0zT2Aewf0WHx9+g/9uqwwdOH7fLvYsO2mkhdjrgFchiy0/9zmSYv65OCyWA8hdN+IWzf/g7ykHDx8fZHcDpivmBczdAEpl+ZW6n+QC9aYeYxjaqKwxx5Kj1RrxGquAjxwbovRqsBmGhRyXnrH44yDCAGNU8HuM6ZKG/+OXW5eJ5hwpMoPGGY+YpJ2lgJvExRl2dxxUX19ymBHfX1jKQ2U3Z/5zCZ5fooxT4QvwtkwsTaBmN82GKDLgULdq4ShzL5oj0Ywwty1Om9DW6D63oVty7w6g/K4mAvmnWUqs/vLVa1sa41i/2+HuMXkGA8hh6AkQZTodzAkCAj4SOfo+Bp1Cyeb2lAT3tctaOZjSXeQ+dPNaafsdhzhKB5wsz10dEs4n9I3QEtpolKIF+QqSnKdWtPXcd5m0X86cnP22cEA27i4B276nsL1QiwJvHA+nA+HK3sUtwrjVnbCYuNBNNkO08w43/e8GOTk7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(83380400001)(478600001)(26005)(186003)(54906003)(316002)(71200400001)(6506007)(2906002)(7696005)(53546011)(110136005)(9686003)(66556008)(33656002)(38100700002)(122000001)(52536014)(41300700001)(64756008)(86362001)(66946007)(55016003)(8936002)(4326008)(8676002)(5660300002)(66446008)(76116006)(38070700005)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ksWKJ6a9pJ87fOkI51pHTlnDbXHdtLbaoRxhmcjD3L1uFd7u0QS6yc4iBOBj?=
 =?us-ascii?Q?poF386NwN6muzSPlZn0iQ7+KlXI8t6vsVJGQhnyeEn9HEHuzdiAgI3OOMZ6Z?=
 =?us-ascii?Q?o3O9Q4bDi3yo2CIfgc0kadRQOVWS2H+L/Gpgo98xo6r8CCMYMydBArwFpeVC?=
 =?us-ascii?Q?b6YkFr6OPljbzL4uptdLTiRUrUS+2LiScoWwjTEalHUsUDtMLyE4RZxPJ97Q?=
 =?us-ascii?Q?qGAlnYQCDMIyguDEVZ9xfcg3T8WvFAD3tyjyMt5+yqzbp/kKRIPA5POMGwYC?=
 =?us-ascii?Q?SNCJQMejBKjBazBrMN7U9jW9XKiixV6p0Twbd31dAU02qc43msE9RtAmAQJo?=
 =?us-ascii?Q?9ziZS/6SZs6i6IrjtZPSjq51j6cRiwymaiCFdG4SVfNzEZ1dt+qwKT5bDgN9?=
 =?us-ascii?Q?TTt1FMpuWmqWFh9LrrJQ8r2YkJa6cYFrqMhWHP07/CB4VkezpcCSbcYua0a7?=
 =?us-ascii?Q?N/+v/MEb1QTx9GHMnT9rJM4Yjqx4icPljPLqjxDpi38qDZhlZ7pJ1Lc2u7+0?=
 =?us-ascii?Q?3nvjtT7BU7TMc7idaT9HBaUO8A+2KZNhcqUUP75GuRa9TTuFouFH4wGKlXYl?=
 =?us-ascii?Q?RoJrzOrx9Op0FhkhQbKAIPVvuuWcMIE+q3civ2ynRbVd7t80ZKmrxp9Zsgao?=
 =?us-ascii?Q?oVYYJwnEbkix7cIrbwdWlwVxVFEUxmzbvHjyWLtdmenoZxES/Dd7wdjQVSyM?=
 =?us-ascii?Q?HnGNCCQoupjxbSXb7H2tE+RSn1GcvJbBd0srxvJA4gSR+DX6lRACOGW4xYG+?=
 =?us-ascii?Q?bgjj6N6Llk4Vq3AwOTWJKRGFTLrH5V6q92K57opOKWzUF0F/l0nz3BH2rEd+?=
 =?us-ascii?Q?q3eB6FqYCLd595+oKQU5ocR/ctDFTc00mNhXDe/51EzsBXiAatURGNCJNIXp?=
 =?us-ascii?Q?mqQZbG61T1j1DNKBs/4OP2lp75I+cGP3DDBdcwKlSjANUm7xFkaOXwehp+Q8?=
 =?us-ascii?Q?Uqx3BrXGGlfXRhhl15xJnWJuXYUfhkWUWRXi2RUszaG+7xlTUVjldDDo3kpW?=
 =?us-ascii?Q?Qt45QMpeU9d1JWCrcDB8lqhkdy0cLjITNp/akFEv7HYFjl7cb3coPad4umm9?=
 =?us-ascii?Q?GoeW3MnjXxF3ptbyAg6dCq+nfvOK6j46ofMMwQF3h+sQAmgPFrLPJTNk5CGY?=
 =?us-ascii?Q?HtPupoU0Pa9k6yYI7iA6NDXeC1ykDBprATyWeLvtKYx1gXscZTWRqIlAw3MO?=
 =?us-ascii?Q?FAA6Gh43MgrsSyTyd4ZLxdzIznW0yQsIJD6mbdWqdY8TPjDfcYxIsjPxC0lg?=
 =?us-ascii?Q?W0uvie/Q6Kr7y5TORvtRK0UXoX+oNffsoKjoBu6fb5+dg00qdB6TvF+8se4K?=
 =?us-ascii?Q?9uIp+pg9ittJMprZDjkWmuujDYNkbEIu3t2hkNqBdccTwUzPXUpGGYOWzZy2?=
 =?us-ascii?Q?i1VgpXPqDdtG/zkwtxvnKM1uaJ6Jd2rnVc28DhjGr98xtJg4ZPLCXC12rBQj?=
 =?us-ascii?Q?tcUjpisWOFFvm0e8OF0kHIuwAO/cnCivnsP4suMZdZrc2Heb5ycFDLDGnvmI?=
 =?us-ascii?Q?CJgIPj4FhW83Di9+t0XOb/nKjkiSekZqeH6+t8AsvvEQ/+6mlX8ej9Dn6LeK?=
 =?us-ascii?Q?yQWCsxG9bUJ6GODoS20=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e33682-b320-43aa-d496-08db3676ece0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 08:14:21.1117 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +UQH7Z11xqXVR/uQKX5qmN430M28qFvRHQWdjhoHWjxKLOe17xqWVH5HO36DRLo1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8173
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
Cc: "Li, Lyndon" <Lyndon.Li@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: lyndonli <Lyndon.Li@amd.com>=20
Sent: Thursday, April 6, 2023 4:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Gao, Likun <Likun.Gao@amd.com>; Zhang, =
Hawking <Hawking.Zhang@amd.com>; Li, Lyndon <Lyndon.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Fix sdma v4 sw fini error

Fix sdma v4 sw fini error for sdma 4.2.2 to solve the following general pro=
tection fault

[  +0.108196] general protection fault, probably for non-canonical address =
0xd5e5a4ae79d24a32: 0000 [#1] PREEMPT SMP PTI [  +0.000018] RIP: 0010:free_=
fw_priv+0xd/0x70 [  +0.000022] Call Trace:
[  +0.000012]  <TASK>
[  +0.000011]  release_firmware+0x55/0x80 [  +0.000021]  amdgpu_ucode_relea=
se+0x11/0x20 [amdgpu] [  +0.000415]  amdgpu_sdma_destroy_inst_ctx+0x4f/0x90=
 [amdgpu] [  +0.000360]  sdma_v4_0_sw_fini+0xce/0x110 [amdgpu]

Signed-off-by: lyndonli <Lyndon.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c
index b5affba22156..96b0c3d42346 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1870,7 +1870,7 @@ static int sdma_v4_0_sw_fini(void *handle)
 			amdgpu_ring_fini(&adev->sdma.instance[i].page);
 	}
=20
-	if (adev->ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, 2, 0) ||
+	if (adev->ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, 2, 2) ||
             adev->ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, 4, 0))
 		amdgpu_sdma_destroy_inst_ctx(adev, true);
 	else
--
2.34.1
