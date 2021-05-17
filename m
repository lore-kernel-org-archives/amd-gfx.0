Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7C4C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 09:18:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A185C61042
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 09:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A185C61042
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E2116E1BB;
	Mon, 17 May 2021 09:18:32 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2067.outbound.protection.outlook.com [40.107.100.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B85A6E1BB
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 09:18:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlC1xSTwRn1PK1sTR+EGoGn71z9PSjM2PyFhDQj+8I1Pg8PD1IXDyLYq1zThBPGhEkymODrFjudoCArC/C4vk827NKUcVtQQMzzL3mOs779IYczyTwR/lYjMs2XRkst81hTS5MRXpvBStTakQfWkl3pncrc37A2TsNNjhqJKSROmwBTbCYE90AS6flr8f9VCPgVyT/dBhzACWet/fBGeWF7qEEeq/eWGDpWWnUVnf7jwRwOE08qOtmQC64TMzTYbWbBJs2HyC1U9vtksCmvLD+FNnxjPeP5eTUkIIOHVuKqTST0Zxd2DyeP1q2sVgGRrdW/zMSQ3Zo0Kaei2iKGFNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NL1Eko9vcf+hERLWvTzDk1qLvkhcmZUWjoXBb/Oo6r4=;
 b=LapXdfapATReKn/8JRE0LEZdFDrcq132/8L083OWZB+AW9YV6Qy7gmqGK1dH7qEiqTncwBR3lR3gkz5K1V7uT9PKv4l3/XuQErX7LS26DXH6x2gAF33LweC/r5uvt8h3doA33oWZraWhtfVbP3KH9VM0YEu4qAJyqPpJjbr0kMTvnB0rGo8cZAw+pd3qRQ1cATHPEDVeiYIyKiCiZmM+1jcBwol1stIPkwVQTo8FbRvZL4LQv9wXs990g4guSQpB8gZ1dPsS+98nRB50L7SFFU6cLmAkdcdYaKmFkM/jcZPPJquAyRTZIZUd9hlOXkuxhTyQZnckk2A68TSYBbevoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NL1Eko9vcf+hERLWvTzDk1qLvkhcmZUWjoXBb/Oo6r4=;
 b=PcN7N54YzTIy1qFgUs+GR4yuHXPQbperQvQpiqA9hnaECQf4wVdcfDOiKH47zT7zIhQZd+DKwUQMdDJkskjRzRhbz0evk41iEkoaz2f3mThO0wiTtKCBwFL7q8Ay0o1YhA0m59GCcgu/Mg7G3RNu6/q+IjNliVgr6s1WJbZCs+s=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5426.namprd12.prod.outlook.com (2603:10b6:5:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Mon, 17 May
 2021 09:18:25 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::6d0f:e659:2a89:c67b]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::6d0f:e659:2a89:c67b%6]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 09:18:24 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 2/3] drm/amd/pm: Fix showing incorrect frequencies on
 aldebaran
Thread-Topic: [PATCH v2 2/3] drm/amd/pm: Fix showing incorrect frequencies on
 aldebaran
Thread-Index: AddK9+XE91DitEyBTVy9IQVRlPxVPgAA0FOFAAAVvpAAAG9gqA==
Date: Mon, 17 May 2021 09:18:24 +0000
Message-ID: <CO6PR12MB5473CEABC5D3D131D3724D71A22D9@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <CH0PR12MB5348E7FFE856A134DBCA8DC6972D9@CH0PR12MB5348.namprd12.prod.outlook.com>
 <CO6PR12MB547376F1D510AA412933FE48A22D9@CO6PR12MB5473.namprd12.prod.outlook.com>,
 <CH0PR12MB5348737B01AF5474B4AF3C5E972D9@CH0PR12MB5348.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5348737B01AF5474B4AF3C5E972D9@CH0PR12MB5348.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-17T09:18:23.580Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbfd0757-ec9c-4794-c0d3-08d91914b95a
x-ms-traffictypediagnostic: CO6PR12MB5426:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB5426D5C20B6DF7136F0985FDA22D9@CO6PR12MB5426.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0dlzUoXde9WB2bGDavQAbHijBYtsoBII+Vi5b1gySgwUT4m5TyksNvmboUMIz4miTx5VElhIQU/nNOrIwyn9s9UIrlkFoUn8gJNeTmVjVBmPrJSKMziV1e073WtN13DDGEaYUDHo6xQeT156i3QZ78cMuDCVJTULYhtio0UnpeGAcfAi+qG+TmEgOqoviorEk/G4jcp6Kz2jhEqCFYmTAqqb6Kp5UXdqr3qtGETlvvJDo6mMe0k6COsVimSVfCzwoKwmKC3DDjFnrMPCNYwfm13WaO9MG/AZ4l7oMplKuLfIMrJV1Qu6Nxo0FEAKYaKvZdzrO3aUy3csnVajPAdDi6Tc/zIvqWyOfNqICWjck6dvlr/004Iw1zwybYyvE5aVmmLKxp4Jl+qTx4hdcoHxRGRzDY7tNJqOLNSohZCoZrkf6KHc4bYr7e8BPOTIQC4fG3+mV/r8rjyYqqETV67OKpwWrc/3XnjOSgbBL5w+khZBUeloTosaywa/H4FXv4HtFmIPcMTfBiPMhf9g5nOqj65LS6qA+wVHejaTk9eo48wHd5EyjteI1fkH+dEHadxD1QVfezLySLIabJ31DvLj7RE3S6nEcF2NZLWjH/hgfCU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(38100700002)(9686003)(110136005)(91956017)(8676002)(76116006)(2906002)(26005)(71200400001)(6506007)(122000001)(55016002)(83380400001)(4326008)(478600001)(53546011)(54906003)(66946007)(33656002)(5660300002)(7696005)(52536014)(86362001)(66476007)(66446008)(66556008)(19627405001)(8936002)(316002)(64756008)(186003)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?8Vz3msgZReIC/53KXiC1rGFlsIZG6+gLd6vdfWMSDLYxgmE4BOam4xUOTx?=
 =?iso-8859-1?Q?FCCa0amGXZVU+9lAh+CGnp/7v2TVlXnL0eY13eqcB3qSVbivKrVno6pWo7?=
 =?iso-8859-1?Q?6z9hQzHQegLv3hGGX1z3jk3yOKnw4P0/PB+40CKSWo0dqAd2HvWC1GJBJ1?=
 =?iso-8859-1?Q?9JMpXWwCdSM7Y/G3ERp6BMkhv6trar3xSfM3IwRGyrEKydkN96OODIibCP?=
 =?iso-8859-1?Q?4/OQG7Tf9l7dv7grtztbcVx/cknkJBfz4xhKbSaeAh8B9dqCuQbW1HruiI?=
 =?iso-8859-1?Q?SHR86SgddbXlBBRKloO1iYey/hFdZMki9Km0wqsjdG7tiBMVUo3LXGpHha?=
 =?iso-8859-1?Q?miQGRsJDndHH/mcKHQuiAYyjR14fJtOy9Dlm1WQPQ1LndraGeN2ZL3wgqa?=
 =?iso-8859-1?Q?c76vzzG9wIpQ0zQhcXQJpC9dFf4nd72Lc9eAiS7BvMAATHoMypsp+Lv8WR?=
 =?iso-8859-1?Q?2E4WcNFKMbYMg7y2eQKXs74Xf4TO5E31z6v8tSUwcrDxviu/FKpogKSF/o?=
 =?iso-8859-1?Q?3+aG2TujThmxM+dXOfz1Op1BiHj1jRh/6I66EOWWFOy55fZgaZY6bsyhst?=
 =?iso-8859-1?Q?AlJm8M7A/qWwW1rXgQxyE3xxwBkC1oNMuJst3+GcpIuuPLj8ZGRfjPHJDL?=
 =?iso-8859-1?Q?1Lw1hnahodx3fG9pDrctPxTmvQah3vxJ92BuD9Omgk32mXFKgrag0VhtGX?=
 =?iso-8859-1?Q?7Wk/1J7Nrv2kI7/02Ug1cjVzqKP7r+iF6gI3F8t3WXwSMm6txxxh+dvkWi?=
 =?iso-8859-1?Q?fI7gfLWjpBcrpGUi+Ru2ZrUx2m2tLWk46xzsBK9aB/2wbGP5QH3Zw/0ybR?=
 =?iso-8859-1?Q?+y3GAY4SeH/WfWrqrYDPJHO6OfHoLTz+JHbqOrZ4CmKYN5qCuv9+wYrKpA?=
 =?iso-8859-1?Q?avdnMy6vlslXni6mjwyjUI+LaiI7ZdFIrjsNW/a/8QNvwaay0tC6sr841l?=
 =?iso-8859-1?Q?cdJHrb6mBIR/xgmMy/rfcWk+UVeqYv7TjoNKHt+ZZSy2Yi9iMoMOxICs8m?=
 =?iso-8859-1?Q?iQ7SpoALzrdJWzL2OAuVIMGbGQzzAz14n0cxfm4kd2yYAL6bUi5yeLPVxh?=
 =?iso-8859-1?Q?iDgRVfN6eduWtmTbVkriuC2o0vWR3UG0ZrmKZjJRhX6mMmVCCy/diwAgMv?=
 =?iso-8859-1?Q?ysBOHCwtIaylcFiH9PXu2jc5VF672ADCSx8sgbF/icA4oAlY2HFtK2iAZN?=
 =?iso-8859-1?Q?WtpunUiD9j8UTpg2T1U74lTAfaSMMRC7iFPsu1UOWsmjE3sPHAQbwK/Fq1?=
 =?iso-8859-1?Q?DJ0nviv0CH4HD1fUibIlcxjyDi2YuxfreR4fB41qRX62sd+c0gcTbqeWvD?=
 =?iso-8859-1?Q?O40mVF1l7oDMQ7NNlKtmwsHGJOQdeYb0iF3NNsVRDb8J4yyzq6d51G0Vjb?=
 =?iso-8859-1?Q?2wrl2p9JHu?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfd0757-ec9c-4794-c0d3-08d91914b95a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 09:18:24.6840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8PON/wyoMsISrdDm6YAdwTuyYK9v0imfYCT78z+2gfHnmKjp4VPxrYNzO3iwYEio
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5426
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1266452659=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1266452659==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CO6PR12MB5473CEABC5D3D131D3724D71A22D9CO6PR12MB5473namp_"

--_000_CO6PR12MB5473CEABC5D3D131D3724D71A22D9CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

ok, it is fine for me,
and some code blocks need to have a blank line to match kernel coding style=
.
with that fixes,  Series is

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, May 17, 2021 5:04 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.c=
om>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: RE: [PATCH v2 2/3] drm/amd/pm: Fix showing incorrect frequencies o=
n aldebaran


[AMD Public Use]



Hi Kevin,



This case is for determinism mode  - there it uses the max frequency passed=
 and min_clk is the default min clock.



Thanks,

Lijo



From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Sent: Monday, May 17, 2021 2:32 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.c=
om>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: Re: [PATCH v2 2/3] drm/amd/pm: Fix showing incorrect frequencies o=
n aldebaran



[AMD Public Use]



Hi Lijo,



+                                                             pstate_table-=
>gfxclk_pstate.curr.min =3D min_clk;

+                                                             pstate_table-=
>gfxclk_pstate.curr.max =3D max;



min_clk and max,

it seems it is coding error, is right?



Best Regards,

Kevin

________________________________

From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Sent: Monday, May 17, 2021 4:39 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; W=
ang, Kevin(Yang) <Kevin1.Wang@amd.com<mailto:Kevin1.Wang@amd.com>>; Chen, G=
uchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; Feng, Kenneth <Ken=
neth.Feng@amd.com<mailto:Kenneth.Feng@amd.com>>
Subject: [PATCH v2 2/3] drm/amd/pm: Fix showing incorrect frequencies on al=
debaran



[AMD Public Use]



v1: Use the current and custom pstate frequencies to track the current and

user-set min/max values in manual and determinism mode. Previously, only

actual_* value was used to track the currrent and user requested value.

The value will get reassigned whenever user requests a new value with

pp_od_clk_voltage node. Hence it will show incorrect values when user

requests an invalid value or tries a partial request without committing

the values. Separating out to custom and current variable fixes such

issues.



v2: Remove redundant if-else check



Signed-off-by: Lijo Lazar lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>

---

.../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 65 ++++++++++++-------

.../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  6 ++

2 files changed, 46 insertions(+), 25 deletions(-)



diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c

index 5d04a1dfdfd8..d27ed2954705 100644

--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c

+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c

@@ -78,8 +78,6 @@

 #define smnPCIE_ESM_CTRL                                     0x111003D0

-#define CLOCK_VALID (1 << 31)

-

static const struct cmn2asic_msg_mapping aldebaran_message_map[SMU_MSG_MAX_=
COUNT] =3D {

               MSG_MAP(TestMessage,                                        =
          PPSMC_MSG_TestMessage,                                  0),

               MSG_MAP(GetSmuVersion,                                      =
       PPSMC_MSG_GetSmuVersion,                                            =
 1),

@@ -455,12 +453,18 @@ static int aldebaran_populate_umd_state_clk(struct sm=
u_context *smu)

                pstate_table->gfxclk_pstate.min =3D gfx_table->min;

               pstate_table->gfxclk_pstate.peak =3D gfx_table->max;

+             pstate_table->gfxclk_pstate.curr.min =3D gfx_table->min;

+             pstate_table->gfxclk_pstate.curr.max =3D gfx_table->max;

                pstate_table->uclk_pstate.min =3D mem_table->min;

               pstate_table->uclk_pstate.peak =3D mem_table->max;

+             pstate_table->uclk_pstate.curr.min =3D mem_table->min;

+             pstate_table->uclk_pstate.curr.max =3D mem_table->max;

                pstate_table->socclk_pstate.min =3D soc_table->min;

               pstate_table->socclk_pstate.peak =3D soc_table->max;

+             pstate_table->socclk_pstate.curr.min =3D soc_table->min;

+             pstate_table->socclk_pstate.curr.max =3D soc_table->max;

                if (gfx_table->count > ALDEBARAN_UMD_PSTATE_GFXCLK_LEVEL &&

                   mem_table->count > ALDEBARAN_UMD_PSTATE_MCLK_LEVEL &&

@@ -669,6 +673,7 @@ static int aldebaran_print_clk_levels(struct smu_contex=
t *smu,

{

               int i, now, size =3D 0;

               int ret =3D 0;

+             struct smu_umd_pstate_table *pstate_table =3D &smu->pstate_ta=
ble;

               struct pp_clock_levels_with_latency clocks;

               struct smu_13_0_dpm_table *single_dpm_table;

               struct smu_dpm_context *smu_dpm =3D &smu->smu_dpm;

@@ -703,12 +708,8 @@ static int aldebaran_print_clk_levels(struct smu_conte=
xt *smu,

                                display_levels =3D clocks.num_levels;

-                              min_clk =3D smu->gfx_actual_hard_min_freq & =
CLOCK_VALID ?

-                                                                smu->gfx_a=
ctual_hard_min_freq & ~CLOCK_VALID :

-                                                                single_dpm=
_table->dpm_levels[0].value;

-                              max_clk =3D smu->gfx_actual_soft_max_freq & =
CLOCK_VALID ?

-                                                                smu->gfx_a=
ctual_soft_max_freq & ~CLOCK_VALID :

-                                                                single_dpm=
_table->dpm_levels[1].value;

+                             min_clk =3D pstate_table->gfxclk_pstate.curr.=
min;

+                             max_clk =3D pstate_table->gfxclk_pstate.curr.=
max;

                                freq_values[0] =3D min_clk;

                               freq_values[1] =3D max_clk;

@@ -1134,9 +1135,6 @@ static int aldebaran_set_performance_level(struct smu=
_context *smu,

                                               && (level !=3D AMD_DPM_FORCE=
D_LEVEL_PERF_DETERMINISM))

                               smu_cmn_send_smc_msg(smu, SMU_MSG_DisableDet=
erminism, NULL);

-              /* Reset user min/max gfx clock */

-              smu->gfx_actual_hard_min_freq =3D 0;

-              smu->gfx_actual_soft_max_freq =3D 0;

                switch (level) {

@@ -1163,6 +1161,7 @@ static int aldebaran_set_soft_freq_limited_range(stru=
ct smu_context *smu,

{

               struct smu_dpm_context *smu_dpm =3D &(smu->smu_dpm);

               struct smu_13_0_dpm_context *dpm_context =3D smu_dpm->dpm_co=
ntext;

+             struct smu_umd_pstate_table *pstate_table =3D &smu->pstate_ta=
ble;

               struct amdgpu_device *adev =3D smu->adev;

               uint32_t min_clk;

               uint32_t max_clk;

@@ -1176,14 +1175,20 @@ static int aldebaran_set_soft_freq_limited_range(st=
ruct smu_context *smu,

                               return -EINVAL;

                if (smu_dpm->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL) =
{

-                              min_clk =3D max(min, dpm_context->dpm_tables=
.gfx_table.min);

-                              max_clk =3D min(max, dpm_context->dpm_tables=
.gfx_table.max);

-                              ret =3D smu_v13_0_set_soft_freq_limited_rang=
e(smu, SMU_GFXCLK,

-                                                                          =
                                        min_clk, max_clk);

+                             if (min >=3D max) {

+                                             dev_err(smu->adev->dev,

+                                                             "Minimum GFX =
clk should be less than the maximum allowed clock\n");

+                                             return -EINVAL;

+                             }

+                             if ((min =3D=3D pstate_table->gfxclk_pstate.c=
urr.min) &&

+                                 (max =3D=3D pstate_table->gfxclk_pstate.c=
urr.max))

+                                             return 0;

+                             ret =3D smu_v13_0_set_soft_freq_limited_range=
(smu, SMU_GFXCLK,

+                                                                          =
                                       min, max);

                               if (!ret) {

-                                              smu->gfx_actual_hard_min_fre=
q =3D min_clk | CLOCK_VALID;

-                                              smu->gfx_actual_soft_max_fre=
q =3D max_clk | CLOCK_VALID;

+                                             pstate_table->gfxclk_pstate.c=
urr.min =3D min;

+                                             pstate_table->gfxclk_pstate.c=
urr.max =3D max;

                               }

                               return ret;

               }

@@ -1209,10 +1214,8 @@ static int aldebaran_set_soft_freq_limited_range(str=
uct smu_context *smu,

                                                               dev_err(adev=
->dev,

                                                                           =
                    "Failed to enable determinism at GFX clock %d MHz\n", m=
ax);

                                               } else {

-                                                              smu->gfx_act=
ual_hard_min_freq =3D

-                                                                          =
    min_clk | CLOCK_VALID;

-                                                              smu->gfx_act=
ual_soft_max_freq =3D

-                                                                          =
    max | CLOCK_VALID;

+                                                             pstate_table-=
>gfxclk_pstate.curr.min =3D min_clk;

+                                                             pstate_table-=
>gfxclk_pstate.curr.max =3D max;

                                               }

                               }

               }

@@ -1225,6 +1228,7 @@ static int aldebaran_usr_edit_dpm_table(struct smu_co=
ntext *smu, enum PP_OD_DPM_

{

               struct smu_dpm_context *smu_dpm =3D &(smu->smu_dpm);

               struct smu_13_0_dpm_context *dpm_context =3D smu_dpm->dpm_co=
ntext;

+             struct smu_umd_pstate_table *pstate_table =3D &smu->pstate_ta=
ble;

               uint32_t min_clk;

               uint32_t max_clk;

               int ret =3D 0;

@@ -1245,16 +1249,20 @@ static int aldebaran_usr_edit_dpm_table(struct smu_=
context *smu, enum PP_OD_DPM_

                                               if (input[1] < dpm_context->=
dpm_tables.gfx_table.min) {

                                                               dev_warn(smu=
->adev->dev, "Minimum GFX clk (%ld) MHz specified is less than the minimum =
allowed (%d) MHz\n",

                                                                           =
    input[1], dpm_context->dpm_tables.gfx_table.min);

+                                                             pstate_table-=
>gfxclk_pstate.custom.min =3D

+                                                                          =
   pstate_table->gfxclk_pstate.curr.min;

                                                               return -EINV=
AL;

                                               }

-                                              smu->gfx_actual_hard_min_fre=
q =3D input[1];

+                                             pstate_table->gfxclk_pstate.c=
ustom.min =3D input[1];

                               } else if (input[0] =3D=3D 1) {

                                               if (input[1] > dpm_context->=
dpm_tables.gfx_table.max) {

                                                               dev_warn(smu=
->adev->dev, "Maximum GFX clk (%ld) MHz specified is greater than the maxim=
um allowed (%d) MHz\n",

                                                                           =
    input[1], dpm_context->dpm_tables.gfx_table.max);

+                                                             pstate_table-=
>gfxclk_pstate.custom.max =3D

+                                                                          =
   pstate_table->gfxclk_pstate.curr.max;

                                                               return -EINV=
AL;

                                               }

-                                              smu->gfx_actual_soft_max_fre=
q =3D input[1];

+                                             pstate_table->gfxclk_pstate.c=
ustom.max =3D input[1];

                               } else {

                                               return -EINVAL;

                               }

@@ -1276,8 +1284,15 @@ static int aldebaran_usr_edit_dpm_table(struct smu_c=
ontext *smu, enum PP_OD_DPM_

                                               dev_err(smu->adev->dev, "Inp=
ut parameter number not correct\n");

                                               return -EINVAL;

                               } else {

-                                              min_clk =3D smu->gfx_actual_=
hard_min_freq;

-                                              max_clk =3D smu->gfx_actual_=
soft_max_freq;

+                                             if (!pstate_table->gfxclk_pst=
ate.custom.min)

+                                                             pstate_table-=
>gfxclk_pstate.custom.min =3D

+                                                                          =
   pstate_table->gfxclk_pstate.curr.min;

+                                             if (!pstate_table->gfxclk_pst=
ate.custom.max)

+                                                             pstate_table-=
>gfxclk_pstate.custom.max =3D

+                                                                          =
   pstate_table->gfxclk_pstate.curr.max;

+                                             min_clk =3D pstate_table->gfx=
clk_pstate.custom.min;

+                                             max_clk =3D pstate_table->gfx=
clk_pstate.custom.max;

+

                                               return aldebaran_set_soft_fr=
eq_limited_range(smu, SMU_GFXCLK, min_clk, max_clk);

                               }

                               break;

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c

index 0864083e7435..6b3374432e1d 100644

--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c

+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c

@@ -1626,6 +1626,8 @@ int smu_v13_0_set_performance_level(struct smu_contex=
t *smu,

                                                                           =
                                        sclk_max);

                               if (ret)

                                               return ret;

+                             pstate_table->gfxclk_pstate.curr.min =3D sclk=
_min;

+                             pstate_table->gfxclk_pstate.curr.max =3D sclk=
_max;

               }

                if (mclk_min && mclk_max) {

@@ -1635,6 +1637,8 @@ int smu_v13_0_set_performance_level(struct smu_contex=
t *smu,

                                                                           =
                                        mclk_max);

                               if (ret)

                                               return ret;

+                             pstate_table->uclk_pstate.curr.min =3D mclk_m=
in;

+                             pstate_table->uclk_pstate.curr.max =3D mclk_m=
ax;

               }

                if (socclk_min && socclk_max) {

@@ -1644,6 +1648,8 @@ int smu_v13_0_set_performance_level(struct smu_contex=
t *smu,

                                                                           =
                                        socclk_max);

                               if (ret)

                                               return ret;

+                             pstate_table->socclk_pstate.curr.min =3D socc=
lk_min;

+                             pstate_table->socclk_pstate.curr.max =3D socc=
lk_max;

               }

                return ret;

--

2.17.1



--_000_CO6PR12MB5473CEABC5D3D131D3724D71A22D9CO6PR12MB5473namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: calibri, sans-serif; font-size: 11pt; color: rg=
b(50, 49, 48); background-color: rgba(0, 0, 0, 0);">ok, it is fine for me,<=
/span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: calibri, sans-serif; font-size: 11pt; color: rg=
b(50, 49, 48); background-color: rgba(0, 0, 0, 0);">and some code blocks ne=
ed to have a blank line to match kernel coding style.</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: calibri, sans-serif; font-size: 11pt; color: rg=
b(50, 49, 48); background-color: rgba(0, 0, 0, 0);">with that fixes,&nbsp;
</span><span style=3D"background-color: rgba(0, 0, 0, 0); color: rgb(50, 49=
, 48); font-family: calibri, sans-serif; font-size: 11pt;">Series is&nbsp;<=
/span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"background-color: rgba(0, 0, 0, 0); color: rgb(50, 49, 48); =
font-family: calibri, sans-serif; font-size: 11pt;"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"background-color: rgba(0, 0, 0, 0); color: rgb(50, 49, 48); =
font-family: calibri, sans-serif; font-size: 11pt;">Reviewed-by: Kevin Wang=
 &lt;kevin1.wang@amd.com&gt;</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: calibri, sans-serif; font-size: 11pt; color: rg=
b(50, 49, 48); background-color: rgba(0, 0, 0, 0);">Best Regards,</span><br=
>
<span style=3D"font-family: calibri, sans-serif; font-size: 11pt; color: rg=
b(50, 49, 48); background-color: rgba(0, 0, 0, 0);">Kevin</span></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Monday, May 17, 2021 5:04 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Chen, Guchun &lt;G=
uchun.Chen@amd.com&gt;; Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH v2 2/3] drm/amd/pm: Fix showing incorrect freque=
ncies on aldebaran</font>
<div>&nbsp;</div>
</div>
<div lang=3D"EN-US" style=3D"word-wrap:break-word">
<div class=3D"x_WordSection1">
<p class=3D"x_msipheader251902e5" style=3D"margin-right: 0in; margin-left: =
0in; font-size: 11pt; font-family: Calibri, sans-serif;margin:0in">
<span style=3D"font-size:10.0pt; font-family:&quot;Arial&quot;,sans-serif; =
color:#317100">[AMD Public Use]</span></p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
Hi Kevin,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
This case is for determinism mode &nbsp;- there it uses the max frequency p=
assed and min_clk is the default min clock.</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
Thanks,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
Lijo</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<b>From:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt; <br>
<b>Sent:</b> Monday, May 17, 2021 2:32 PM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Chen, Guchun &lt;G=
uchun.Chen@amd.com&gt;; Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2 2/3] drm/amd/pm: Fix showing incorrect freque=
ncies on aldebaran</p>
</div>
</div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:#317100">[AMD Public Use]</span></p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
<div>
<div>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;background:white">
<span style=3D"color:black">Hi Lijo,</span></p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;background:white">
<span style=3D"color:black">&nbsp;</span></p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;background:white">
<span style=3D"color:black">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.curr.min =3D min_clk;</span><=
/p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;background:white">
<span style=3D"color:black">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.curr.max =3D max;</span></p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;background:white">
<span style=3D"color:black">&nbsp;</span></p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;background:white">
<span style=3D"color:black">min_clk and max,</span></p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;background:white">
<span style=3D"color:black">it seems it is coding error, is right?</span></=
p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;background:white">
<span style=3D"color:black">&nbsp;</span></p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;background:white">
<span style=3D"color:black">Best Regards,</span></p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;background:white">
<span style=3D"color:black">Kevin</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"margin: 0in; font-size=
: 11pt; font-family: Calibri, sans-serif;text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
<b><span style=3D"color:black">From:</span></b><span style=3D"color:black">=
 Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar@amd.com</=
a>&gt;<br>
<b>Sent:</b> Monday, May 17, 2021 4:39 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;; Wang, Kevin(Yang) &lt;<a href=3D"mailto:Kevin1.W=
ang@amd.com">Kevin1.Wang@amd.com</a>&gt;; Chen, Guchun &lt;<a href=3D"mailt=
o:Guchun.Chen@amd.com">Guchun.Chen@amd.com</a>&gt;; Feng,
 Kenneth &lt;<a href=3D"mailto:Kenneth.Feng@amd.com">Kenneth.Feng@amd.com</=
a>&gt;<br>
<b>Subject:</b> [PATCH v2 2/3] drm/amd/pm: Fix showing incorrect frequencie=
s on aldebaran</span>
</p>
<div>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
</div>
</div>
<div>
<p class=3D"x_xmsipheader251902e5" style=3D"margin: 0in; font-size: 11pt; f=
ont-family: Calibri, sans-serif;">
<span style=3D"font-size:10.0pt; font-family:&quot;Arial&quot;,sans-serif; =
color:#317100">[AMD Public Use]</span></p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
<div>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
v1: Use the current and custom pstate frequencies to track the current and<=
/p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
user-set min/max values in manual and determinism mode. Previously, only</p=
>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
actual_* value was used to track the currrent and user requested value.</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
The value will get reassigned whenever user requests a new value with</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
pp_od_clk_voltage node. Hence it will show incorrect values when user</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
requests an invalid value or tries a partial request without committing</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
the values. Separating out to custom and current variable fixes such</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
issues.</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
v2: Remove redundant if-else check</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
Signed-off-by: Lijo Lazar <a href=3D"mailto:lijo.lazar@amd.com">lijo.lazar@=
amd.com</a></p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
---</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
.../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c&nbsp;&nbsp;&nbsp; | 65 +++++++++=
+++-------</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
.../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c&nbsp;&nbsp;&nbsp; |&nbsp; 6 ++</=
p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
2 files changed, 46 insertions(+), 25 deletions(-)</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
index 5d04a1dfdfd8..d27ed2954705 100644</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
@@ -78,8 +78,6 @@</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;#define smnPCIE_ESM_CTRL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 0x111003D0</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
-#define CLOCK_VALID (1 &lt;&lt; 31)</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
-</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
static const struct cmn2asic_msg_mapping aldebaran_message_map[SMU_MSG_MAX_=
COUNT] =3D {</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; MSG_MAP(TestMessage,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp=
;&nbsp;&nbsp;&nbsp; PPSMC_MSG_TestMessage,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 0),</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; MSG_MAP(GetSmuVersion,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MS=
G_GetSmuVersion,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1),</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
@@ -455,12 +453,18 @@ static int aldebaran_populate_umd_state_clk(struct sm=
u_context *smu)</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.min =3D gfx_table-&gt;min;</=
p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; pstate_table-&gt;gfxclk_pstate.peak =3D gfx_table-&gt;max;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
state_table-&gt;gfxclk_pstate.curr.min =3D gfx_table-&gt;min;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
state_table-&gt;gfxclk_pstate.curr.max =3D gfx_table-&gt;max;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pstate_table-&gt;uclk_pstate.min =3D mem_table-&gt;min;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; pstate_table-&gt;uclk_pstate.peak =3D mem_table-&gt;max;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
state_table-&gt;uclk_pstate.curr.min =3D mem_table-&gt;min;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
state_table-&gt;uclk_pstate.curr.max =3D mem_table-&gt;max;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pstate_table-&gt;socclk_pstate.min =3D soc_table-&gt;min;</=
p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; pstate_table-&gt;socclk_pstate.peak =3D soc_table-&gt;max;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
state_table-&gt;socclk_pstate.curr.min =3D soc_table-&gt;min;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
state_table-&gt;socclk_pstate.curr.max =3D soc_table-&gt;max;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (gfx_table-&gt;count &gt; ALDEBARAN_UMD_PSTATE_GFXCLK_LE=
VEL &amp;&amp;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;mem_table-&gt;count &gt; ALDEBARAN_UMD_PS=
TATE_MCLK_LEVEL &amp;&amp;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
@@ -669,6 +673,7 @@ static int aldebaran_print_clk_levels(struct smu_contex=
t *smu,</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
{</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; int i, now, size =3D 0;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; int ret =3D 0;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct smu_umd_pstate_table *pstate_table =3D &amp;smu-&gt;pstate_table;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct pp_clock_levels_with_latency clocks;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct smu_13_0_dpm_table *single_dpm_table;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct smu_dpm_context *smu_dpm =3D &amp;smu-&gt;smu_dpm;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
@@ -703,12 +708,8 @@ static int aldebaran_print_clk_levels(struct smu_conte=
xt *smu,</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; display_levels =3D clocks.num_levels;<=
/p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; min_clk =3D smu-&gt;gfx_actual_hard_min_freq &amp=
; CLOCK_VALID ?</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; =
smu-&gt;gfx_actual_hard_min_freq &amp; ~CLOCK_VALID :</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; =
single_dpm_table-&gt;dpm_levels[0].value;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; max_clk =3D smu-&gt;gfx_actual_soft_max_freq &amp=
; CLOCK_VALID ?</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; =
smu-&gt;gfx_actual_soft_max_freq &amp; ~CLOCK_VALID :</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; =
single_dpm_table-&gt;dpm_levels[1].value;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; min_clk =3D pstate_table-&gt;gfxclk_pstate.curr.min;</p=
>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; max_clk =3D pstate_table-&gt;gfxclk_pstate.curr.max;</p=
>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freq_values[0] =3D min_clk;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freq_values[1] =3D max_clk;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
@@ -1134,9 +1135,6 @@ static int aldebaran_set_performance_level(struct smu=
_context *smu,</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;&amp; (level !=3D =
AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM))</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_send_smc_msg(smu, SMU_MSG_DisableDet=
erminism, NULL);</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* Reset user min/max gfx clock */</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; smu-&gt;gfx_actual_hard_min_freq =3D 0;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; smu-&gt;gfx_actual_soft_max_freq =3D 0;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; switch (level) {</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
@@ -1163,6 +1161,7 @@ static int aldebaran_set_soft_freq_limited_range(stru=
ct smu_context *smu,</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
{</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct smu_dpm_context *smu_dpm =3D &amp;(smu-&gt;smu_dpm);</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct smu_13_0_dpm_context *dpm_context =3D smu_dpm-&gt;dpm_cont=
ext;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct smu_umd_pstate_table *pstate_table =3D &amp;smu-&gt;pstate_table;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;adev;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uint32_t min_clk;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uint32_t max_clk;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
@@ -1176,14 +1175,20 @@ static int aldebaran_set_soft_freq_limited_range(st=
ruct smu_context *smu,</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (smu_dpm-&gt;dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUA=
L) {</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; min_clk =3D max(min, dpm_context-&gt;dpm_tables.g=
fx_table.min);</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; max_clk =3D min(max, dpm_context-&gt;dpm_tables.g=
fx_table.max);</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v13_0_set_soft_freq_limited_range(smu=
, SMU_GFXCLK,</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
min_clk, max_clk);</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (min &gt;=3D max) {</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(smu-&gt;adev-&gt;dev,</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Minimum=
 GFX clk should be less than the maximum allowed clock\n&quot;);</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if ((min =3D=3D pstate_table-&gt;gfxclk_pstate.curr.min=
) &amp;&amp;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; (max =3D=3D pstate_table-&gt;gfxclk_=
pstate.curr.max))</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D smu_v13_0_set_soft_freq_limited_range(smu, SMU_=
GFXCLK,</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; min, m=
ax);</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret) {</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx_actual_hard_min_=
freq =3D min_clk | CLOCK_VALID;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx_actual_soft_max_=
freq =3D max_clk | CLOCK_VALID;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.cur=
r.min =3D min;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.cur=
r.max =3D max;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; }</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
@@ -1209,10 +1214,8 @@ static int aldebaran_set_soft_freq_limited_range(str=
uct smu_context *smu,</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; de=
v_err(adev-&gt;dev,</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to enable determinism =
at GFX clock %d MHz\n&quot;, max);</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt=
;gfx_actual_hard_min_freq =3D</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; min_clk | CLOCK_VALID;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt=
;gfx_actual_soft_max_freq =3D</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; max | CLOCK_VALID;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-=
&gt;gfxclk_pstate.curr.min =3D min_clk;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-=
&gt;gfxclk_pstate.curr.max =3D max;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; }</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
@@ -1225,6 +1228,7 @@ static int aldebaran_usr_edit_dpm_table(struct smu_co=
ntext *smu, enum PP_OD_DPM_</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
{</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct smu_dpm_context *smu_dpm =3D &amp;(smu-&gt;smu_dpm);</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct smu_13_0_dpm_context *dpm_context =3D smu_dpm-&gt;dpm_cont=
ext;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct smu_umd_pstate_table *pstate_table =3D &amp;smu-&gt;pstate_table;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uint32_t min_clk;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uint32_t max_clk;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; int ret =3D 0;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
@@ -1245,16 +1249,20 @@ static int aldebaran_usr_edit_dpm_table(struct smu_=
context *smu, enum PP_OD_DPM_</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (input[1] &lt; dpm_c=
ontext-&gt;dpm_tables.gfx_table.min) {</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; de=
v_warn(smu-&gt;adev-&gt;dev, &quot;Minimum GFX clk (%ld) MHz specified is l=
ess than the minimum allowed (%d) MHz\n&quot;,</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; input[1], dpm_context-&gt;dpm_tables.gfx_table.min);</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-=
&gt;gfxclk_pstate.custom.min =3D</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; pstate_table-&gt;gfxclk_pstate.curr.min;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
turn -EINVAL;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx_actual_hard_min_=
freq =3D input[1];</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.cus=
tom.min =3D input[1];</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (input[0] =3D=3D 1) {</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (input[1] &gt; dpm_c=
ontext-&gt;dpm_tables.gfx_table.max) {</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; de=
v_warn(smu-&gt;adev-&gt;dev, &quot;Maximum GFX clk (%ld) MHz specified is g=
reater than the maximum allowed (%d) MHz\n&quot;,</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; input[1], dpm_context-&gt;dpm_tables.gfx_table.max);</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-=
&gt;gfxclk_pstate.custom.max =3D</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; pstate_table-&gt;gfxclk_pstate.curr.max;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
turn -EINVAL;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx_actual_soft_max_=
freq =3D input[1];</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.cus=
tom.max =3D input[1];</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
@@ -1276,8 +1284,15 @@ static int aldebaran_usr_edit_dpm_table(struct smu_c=
ontext *smu, enum PP_OD_DPM_</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(smu-&gt;adev-&g=
t;dev, &quot;Input parameter number not correct\n&quot;);</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_clk =3D smu-&gt;gfx_actu=
al_hard_min_freq;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_clk =3D smu-&gt;gfx_actu=
al_soft_max_freq;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pstate_table-&gt;gfxclk_pstat=
e.custom.min)</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-=
&gt;gfxclk_pstate.custom.min =3D</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; pstate_table-&gt;gfxclk_pstate.curr.min;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pstate_table-&gt;gfxclk_pstat=
e.custom.max)</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-=
&gt;gfxclk_pstate.custom.max =3D</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; pstate_table-&gt;gfxclk_pstate.curr.max;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_clk =3D pstate_table-&gt;gfxcl=
k_pstate.custom.min;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_clk =3D pstate_table-&gt;gfxcl=
k_pstate.custom.max;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return aldebaran_set_so=
ft_freq_limited_range(smu, SMU_GFXCLK, min_clk, max_clk);</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
index 0864083e7435..6b3374432e1d 100644</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
@@ -1626,6 +1626,8 @@ int smu_v13_0_set_performance_level(struct smu_contex=
t *smu,</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp;&nbsp;sclk_max);</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.curr.min =3D sclk_min;</=
p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.curr.max =3D sclk_max;</=
p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; }</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (mclk_min &amp;&amp; mclk_max) {</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
@@ -1635,6 +1637,8 @@ int smu_v13_0_set_performance_level(struct smu_contex=
t *smu,</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp;&nbsp;mclk_max);</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pstate_table-&gt;uclk_pstate.curr.min =3D mclk_min;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pstate_table-&gt;uclk_pstate.curr.max =3D mclk_max;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; }</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (socclk_min &amp;&amp; socclk_max) {</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
@@ -1644,6 +1648,8 @@ int smu_v13_0_set_performance_level(struct smu_contex=
t *smu,</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp;&nbsp;socclk_max);</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pstate_table-&gt;socclk_pstate.curr.min =3D socclk_min;=
</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pstate_table-&gt;socclk_pstate.curr.max =3D socclk_max;=
</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; }</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return ret;</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
-- </p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
2.17.1</p>
<p class=3D"x_xmsonormal" style=3D"margin: 0in; font-size: 11pt; font-famil=
y: Calibri, sans-serif;">
&nbsp;</p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CO6PR12MB5473CEABC5D3D131D3724D71A22D9CO6PR12MB5473namp_--

--===============1266452659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1266452659==--
