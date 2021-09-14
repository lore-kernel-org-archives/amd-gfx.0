Return-Path: <SRS0=i1uT=OE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F4CC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 13:13:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98AFA610CE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 13:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 98AFA610CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D99116E4C4;
	Tue, 14 Sep 2021 13:13:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48A176E4CA
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Sep 2021 13:13:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjoM9Ox9erCaPvzOqQTGOUPrkNu27sRU1PmYz278Hl8+UWEbEPzl+BHBKkaCsBWJr2pNNRbM0qwitS74df5z3sa5aNc0Bf017uy8whwsoNFwEG/IOAl6rs3RZa8fxJTOzH0lhdc9NJxrL/RskHtw8gfKeMTp0/eYsuuX615GZ8Y0fBhpHWnBG/QjtKm0uIvyF1+Cm6/Kzk31oTzlqOTimoAJNKxbkOuDS6IOxBpkC4H7gxl086wcSA4Gmh136ORYqBZdoRf6s2mRNfBHiaktyUhE0VWKkad33ZfFF6D6ocTTGHLXVN5aYKLpPvfWiEp0LPLJ/Nfh+Reus+Zo8O6Ahg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=UVPza1iPnriZ0mQw9DMq5EyfRHHseAfIg2FH7PUoueg=;
 b=CuKB6CBf+zLdK2W8qMQg1bla9c0MydZzLdQ3lW8pELzoUo/7/TiBtoCKa1dp8FVc3LkppEeLB9uQ4y6rV911FZVs27UylJfIKTsI6SCiHhsPfs9zTLLJYgBY+s4cfKJ+V3CnZ/eRAwf3BgKg18X1K+C0++s594VJ/LEISthcaA8fDo7Jj1lTR2awH6nQl3DJzudpMXt4UMvSe7rSuwijVW6bVwnnc0Ays9rI3f4pAB3HGuOP3PJXLIZdK/pHmytdrtQT9Wy8vVwWkWKQVnuLHiTjLeNK8QF8fYV5zTGFSQicRID95eECOjN2q/+9N02JTJQ65uKoc6Tg/FA2BQd+GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVPza1iPnriZ0mQw9DMq5EyfRHHseAfIg2FH7PUoueg=;
 b=5DYHTZ68Wm2g7a+QA/UTXMmEOAyfWhLQC5ijlb9nLyEA58GIOL+dgQoe/HhHmYTzjx/LzXCU9AXKZjJwryAX3cG1TlCzjAJwCEDqN4pxjACAKwgBSxJCd5i88wcENeZ8J5cAJhjJtiEcLTAv5KcdpeLzMh00n1q4B4HBsyLeibA=
Received: from BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 by BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Tue, 14 Sep
 2021 13:13:34 +0000
Received: from BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e]) by BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e%3]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 13:13:34 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Conform ASD header/loading to generic TA
 systems
Thread-Topic: [PATCH] drm/amdgpu: Conform ASD header/loading to generic TA
 systems
Thread-Index: AQHXqHSinA0k60Oov0K4m31K3X0F06ujg7Dx
Date: Tue, 14 Sep 2021 13:13:34 +0000
Message-ID: <BN9PR12MB5226E8E7B82216A8117A7B90FBDA9@BN9PR12MB5226.namprd12.prod.outlook.com>
References: <20210913075434.23276-1-candice.li@amd.com>
In-Reply-To: <20210913075434.23276-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-14T13:13:32.551Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: b86d6600-0227-3427-ce76-2020043b81df
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cb03d6d-f929-4d7c-361c-08d9778174b4
x-ms-traffictypediagnostic: BN9PR12MB5179:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5179C03B36E0992E2AEAB928FBDA9@BN9PR12MB5179.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u+3CAyJg32HAh62dSOu5hjablEV4sM882FIsxrp+GdErZPFZNVliKeD9n7mxRlGJIPogkz6vKekZiKJzNDWfhUe6TG8bB/ehIHgMyY9AImiP+uEGbPBZbSNYlvFZN1pW8EOildflN5n/Iyy+45De2qtidm6B2s+vhZXV4AO7aG+e9ByyczkN4mw2skrh8OQP6m7o5+qOuDdvOJSI0GebYps2KCe/6qf/UCUFBf24a+U3xGHBrMC/TaAoDC3u3PLDqSKzKaBg7tIrndgpIktc9E+XkmvGLgh+lQEdtwBcfIbluh5uKXTAh3LqOq5ycHm7L9KTxO3O20uad4ihfWqxP7q4NZW/vEvXCanmB0zuk86hk6DQE8yHN5l7bSK3+xI3vt8+rOOJUmKRgd6dJPTJ5tVlgpn2R7pohMAxKrdgl/AmzC4d3fn72oTiAhwqWXAFZ+j0ySyemlDMGvteHTRlmfjWGcXAF4N/EJe2WLf9LfpMqbRCjpue25yxMCo+ouphUABouXL09BzM4z/8plOimhP70f0DRyCaldA7ZjF3uwTgWg084o9qEX3dlP+O8gqX4qq5brrZFXEwmp1LKJ7P0mcJ047m/e5PBzXNY1cjTo68TY6Bb/RESIFm0RlB+nK+Ub5jVYmU2YxZjmGtUALK507vGAUCSoIXSuvnEenM4ElIRXnC/+mcXOXHH7u8Hu2M0xZbP5L0W69oRr2gG4aezb6tP0Iq3QbTf9c41t1lJBY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(66556008)(55016002)(8676002)(8936002)(64756008)(52536014)(2906002)(186003)(33656002)(66946007)(66476007)(7696005)(6506007)(9686003)(110136005)(478600001)(5660300002)(86362001)(19627405001)(316002)(38100700002)(66446008)(53546011)(122000001)(38070700005)(71200400001)(76116006)(91956017)(83380400001)(41533002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qRZVz/ep2eStQwpOy1IZ3ufmIkgowbqCKSRu6Pa/5OEEDP2StfhF9K9Q+s?=
 =?iso-8859-1?Q?ya7Z84W/wetDH0s/4Ajj7bDJlRIWyL1d5Q2aO1TVZRoYhboIoeT5/mXvWK?=
 =?iso-8859-1?Q?0r6DQNo4Kdvjo+qVawpxIFPILK+ix7Kg+r8dBlG3C2ox2tXgjAikNYSfW3?=
 =?iso-8859-1?Q?Bvml3bfCZMkXjZBVcevQjB5Q0u1Txu+0GV2O9OeO43WtW1Cs0aOtaxr1+N?=
 =?iso-8859-1?Q?3xNdMo0QCb9GpiQSpBs++qx0GBItJAfzCLJNbVWTBbQeDD/mdV7RbQExr/?=
 =?iso-8859-1?Q?HR11EHL5Q0lyewZaY4IzcpAGWXieULQhYK4CpSj0Vi8bQJxCTm0pMm0b9U?=
 =?iso-8859-1?Q?rHV6asKANpmXW5zzQaeljdPexSBZ2v6duMvTnaOXljNHPh5DJ5mlgIbMd/?=
 =?iso-8859-1?Q?O5RtqZ9UBLDX4KhgSXqGd7gEyWs1T3xvgG0nYCpchIQbxMsVshFNApgbFy?=
 =?iso-8859-1?Q?4i4fpreDD6pxnVo/k5iLySR7KgtXgRaUsFS/QzLMqBjjDu1UeGPjCqcQP/?=
 =?iso-8859-1?Q?KSXXwYjQB+gODYlRUsyU0laOu5V1digGkYjheWTWJE1FV01pRJqFZms+Cx?=
 =?iso-8859-1?Q?7y+GLuQTTJ1sPZGbs9WT/AdTia8qqfNQyIm1S0WERNGCEAZWOiUyK3B5qf?=
 =?iso-8859-1?Q?3MG0/75+8SDj436dtEUmmEzcSdRfLrX0BqbaIjWlq6ECZNYrGxyvpjQdzV?=
 =?iso-8859-1?Q?cK/2dX8H0i/SKFEzgU0MfpWLSGoMNmy+18zAfSqKAZI6Cl7B0A5lVG/z3M?=
 =?iso-8859-1?Q?rw94S7xkLyD/jwzU0/XC+V4ooRZwgtWUyFcqMzpep3UKsS4uNw6IBnqbWX?=
 =?iso-8859-1?Q?2JfilOW2cuw9rBVi1ZECT2VTHZsOtIyosDPd2k32/L0pjoGtwiKHFh+ZxQ?=
 =?iso-8859-1?Q?Qv7uxyUwheyc23aBPeIQx+Cs0VmXoVoKOi82NSPxi2Ue4h8jtshdbYIaHF?=
 =?iso-8859-1?Q?HlcApUddHPezap81p9n5vSDHqz8uC9o1KcCXJajsIBkPBJo0AempQlg4qU?=
 =?iso-8859-1?Q?EaPCq4bQzx8193D7yAbz5ZWo6KOc9762A4eJxYZnSnjpMfy0eqiQI4ftQo?=
 =?iso-8859-1?Q?NCQfIoqRw8Lr3RRcBl+bkXwllyDx1dbt5caMP1mzIxh+nKZ1f2H+MoporT?=
 =?iso-8859-1?Q?oENfPIpC8kYKmJsaJzEgLwqHNuy2pC0e5Fc6R5eruIMTec8X9x2f5z54hD?=
 =?iso-8859-1?Q?kYhC3nYH5s9Px3NdrncRleEKwnJCDIjWomCC98JPdreUJfSbCsTBq3VuaA?=
 =?iso-8859-1?Q?zcqN0X+gvBd4aY1LM1Yt9kxwwk12z8Kkqry6foqUVbEogMmxe9l10Uey68?=
 =?iso-8859-1?Q?8fVMaIL2rYZH4wmZfdI3/ppqzvJv3heUhsdJGatA71cGJke2WswhFMV4oI?=
 =?iso-8859-1?Q?QGghGIsNVujzgPck+hRwQ3DPk/Lg1VzF8b4Diy7PvdihJS6+gxeYJn5djU?=
 =?iso-8859-1?Q?g/FyZY5ygpJlO7Ep?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5226E8E7B82216A8117A7B90FBDA9BN9PR12MB5226namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb03d6d-f929-4d7c-361c-08d9778174b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2021 13:13:34.0417 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +RDbinKuY1IgIkDgJKQtnYXNaakiDdZLcJflclSB2+SazEECkoB9QZ4m+LVYppUjvFXd2na+Xr1jKvk5reMBGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5179
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB5226E8E7B82216A8117A7B90FBDA9BN9PR12MB5226namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: John Clements <john.clements@amd.com>

________________________________
From: Li, Candice <Candice.Li@amd.com>
Sent: Monday, September 13, 2021 3:54 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Clements, John <John.Clements@amd.com>; Li, Candice <Candice.Li@amd.com=
>
Subject: [PATCH] drm/amdgpu: Conform ASD header/loading to generic TA syste=
ms

Update asd_context structure and add asd_initialize function to
conform ASD header/loading to generic TA systems.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 60 ++++++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 10 ++---
 2 files changed, 26 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 071dadf3a4509f..bc861f2fe0ecf6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -47,6 +47,7 @@ static void psp_sysfs_fini(struct amdgpu_device *adev);

 static int psp_load_smu_fw(struct psp_context *psp);
 static int psp_ta_unload(struct psp_context *psp, uint32_t session_id);
+static int psp_ta_load(struct psp_context *psp, struct ta_context *context=
);
 static int psp_rap_terminate(struct psp_context *psp);
 static int psp_securedisplay_terminate(struct psp_context *psp);

@@ -781,23 +782,14 @@ static int psp_rl_load(struct amdgpu_device *adev)
         return ret;
 }

-static void psp_prep_asd_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
-                               uint64_t asd_mc, uint32_t size)
+static int psp_asd_load(struct psp_context *psp)
 {
-       cmd->cmd_id =3D GFX_CMD_ID_LOAD_ASD;
-       cmd->cmd.cmd_load_ta.app_phy_addr_lo =3D lower_32_bits(asd_mc);
-       cmd->cmd.cmd_load_ta.app_phy_addr_hi =3D upper_32_bits(asd_mc);
-       cmd->cmd.cmd_load_ta.app_len =3D size;
-
-       cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_lo =3D 0;
-       cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_hi =3D 0;
-       cmd->cmd.cmd_load_ta.cmd_buf_len =3D 0;
+       return psp_ta_load(psp, &psp->asd_context);
 }

-static int psp_asd_load(struct psp_context *psp)
+static int psp_asd_initialize(struct psp_context *psp)
 {
         int ret;
-       struct psp_gfx_cmd_resp *cmd;

         /* If PSP version doesn't match ASD version, asd loading will be f=
ailed.
          * add workaround to bypass it for sriov now.
@@ -806,22 +798,13 @@ static int psp_asd_load(struct psp_context *psp)
         if (amdgpu_sriov_vf(psp->adev) || !psp->asd_context.bin_desc.size_=
bytes)
                 return 0;

-       cmd =3D acquire_psp_cmd_buf(psp);
+       psp->asd_context.mem_context.shared_mc_addr  =3D 0;
+       psp->asd_context.mem_context.shared_mem_size =3D PSP_ASD_SHARED_MEM=
_SIZE;
+       psp->asd_context.ta_load_type                =3D GFX_CMD_ID_LOAD_AS=
D;

-       psp_copy_fw(psp, psp->asd_context.bin_desc.start_addr,
-                   psp->asd_context.bin_desc.size_bytes);
-
-       psp_prep_asd_load_cmd_buf(cmd, psp->fw_pri_mc_addr,
-                                 psp->asd_context.bin_desc.size_bytes);
-
-       ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
-                                psp->fence_buf_mc_addr);
-       if (!ret) {
-               psp->asd_context.asd_initialized =3D true;
-               psp->asd_context.session_id =3D cmd->resp.session_id;
-       }
-
-       release_psp_cmd_buf(psp);
+       ret =3D psp_asd_load(psp);
+       if (!ret)
+               psp->asd_context.initialized =3D true;

         return ret;
 }
@@ -859,13 +842,13 @@ static int psp_asd_terminate(struct psp_context *psp)
         if (amdgpu_sriov_vf(psp->adev))
                 return 0;

-       if (!psp->asd_context.asd_initialized)
+       if (!psp->asd_context.initialized)
                 return 0;

         ret =3D psp_asd_unload(psp);

         if (!ret)
-               psp->asd_context.asd_initialized =3D false;
+               psp->asd_context.initialized =3D false;

         return ret;
 }
@@ -903,7 +886,7 @@ static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd=
_resp *cmd,
                                      uint64_t ta_bin_mc,
                                      struct ta_context *context)
 {
-       cmd->cmd_id                             =3D GFX_CMD_ID_LOAD_TA;
+       cmd->cmd_id                             =3D context->ta_load_type;
         cmd->cmd.cmd_load_ta.app_phy_addr_lo     =3D lower_32_bits(ta_bin_=
mc);
         cmd->cmd.cmd_load_ta.app_phy_addr_hi    =3D upper_32_bits(ta_bin_m=
c);
         cmd->cmd.cmd_load_ta.app_len            =3D context->bin_desc.size=
_bytes;
@@ -970,8 +953,7 @@ static int psp_ta_invoke(struct psp_context *psp,
         return ret;
 }

-static int psp_ta_load(struct psp_context *psp,
-                          struct ta_context *context)
+static int psp_ta_load(struct psp_context *psp, struct ta_context *context=
)
 {
         int ret;
         struct psp_gfx_cmd_resp *cmd;
@@ -981,9 +963,7 @@ static int psp_ta_load(struct psp_context *psp,
         psp_copy_fw(psp, context->bin_desc.start_addr,
                     context->bin_desc.size_bytes);

-       psp_prep_ta_load_cmd_buf(cmd,
-                                psp->fw_pri_mc_addr,
-                                context);
+       psp_prep_ta_load_cmd_buf(cmd, psp->fw_pri_mc_addr, context);

         ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
                                  psp->fence_buf_mc_addr);
@@ -1051,6 +1031,7 @@ int psp_xgmi_initialize(struct psp_context *psp, bool=
 set_extended_data, bool lo
                 goto invoke;

         psp->xgmi_context.context.mem_context.shared_mem_size =3D PSP_XGMI=
_SHARED_MEM_SIZE;
+       psp->xgmi_context.context.ta_load_type =3D GFX_CMD_ID_LOAD_TA;

         if (!psp->xgmi_context.context.initialized) {
                 ret =3D psp_xgmi_init_shared_buf(psp);
@@ -1450,6 +1431,7 @@ static int psp_ras_initialize(struct psp_context *psp=
)
         }

         psp->ras_context.context.mem_context.shared_mem_size =3D PSP_RAS_S=
HARED_MEM_SIZE;
+       psp->ras_context.context.ta_load_type =3D GFX_CMD_ID_LOAD_TA;

         if (!psp->ras_context.context.initialized) {
                 ret =3D psp_ras_init_shared_buf(psp);
@@ -1539,6 +1521,7 @@ static int psp_hdcp_initialize(struct psp_context *ps=
p)
         }

         psp->hdcp_context.context.mem_context.shared_mem_size =3D PSP_HDCP=
_SHARED_MEM_SIZE;
+       psp->hdcp_context.context.ta_load_type =3D GFX_CMD_ID_LOAD_TA;

         if (!psp->hdcp_context.context.initialized) {
                 ret =3D psp_hdcp_init_shared_buf(psp);
@@ -1630,6 +1613,7 @@ static int psp_dtm_initialize(struct psp_context *psp=
)
         }

         psp->dtm_context.context.mem_context.shared_mem_size =3D PSP_DTM_S=
HARED_MEM_SIZE;
+       psp->dtm_context.context.ta_load_type =3D GFX_CMD_ID_LOAD_TA;

         if (!psp->dtm_context.context.initialized) {
                 ret =3D psp_dtm_init_shared_buf(psp);
@@ -1727,6 +1711,7 @@ static int psp_rap_initialize(struct psp_context *psp=
)
         }

         psp->rap_context.context.mem_context.shared_mem_size =3D PSP_RAP_S=
HARED_MEM_SIZE;
+       psp->rap_context.context.ta_load_type =3D GFX_CMD_ID_LOAD_TA;

         if (!psp->rap_context.context.initialized) {
                 ret =3D psp_rap_init_shared_buf(psp);
@@ -1842,6 +1827,7 @@ static int psp_securedisplay_initialize(struct psp_co=
ntext *psp)

         psp->securedisplay_context.context.mem_context.shared_mem_size =3D
                 PSP_SECUREDISPLAY_SHARED_MEM_SIZE;
+       psp->securedisplay_context.context.ta_load_type =3D GFX_CMD_ID_LOAD=
_TA;

         if (!psp->securedisplay_context.context.initialized) {
                 ret =3D psp_securedisplay_init_shared_buf(psp);
@@ -2419,7 +2405,7 @@ static int psp_load_fw(struct amdgpu_device *adev)
         if (ret)
                 goto failed;

-       ret =3D psp_asd_load(psp);
+       ret =3D psp_asd_initialize(psp);
         if (ret) {
                 DRM_ERROR("PSP load asd failed!\n");
                 return ret;
@@ -2616,7 +2602,7 @@ static int psp_resume(void *handle)
         if (ret)
                 goto failed;

-       ret =3D psp_asd_load(psp);
+       ret =3D psp_asd_initialize(psp);
         if (ret) {
                 DRM_ERROR("PSP load asd failed!\n");
                 goto failed;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index cfd7ac976cd1e6..f29afabbff1fbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -39,6 +39,7 @@
 #define PSP_FW_NAME_LEN         0x24

 enum psp_shared_mem_size {
+       PSP_ASD_SHARED_MEM_SIZE                         =3D 0x0,
         PSP_XGMI_SHARED_MEM_SIZE                        =3D 0x4000,
         PSP_RAS_SHARED_MEM_SIZE                         =3D 0x4000,
         PSP_HDCP_SHARED_MEM_SIZE                        =3D 0x4000,
@@ -140,12 +141,6 @@ struct psp_bin_desc {
         uint8_t *start_addr;
 };

-struct psp_asd_context {
-       bool                    asd_initialized;
-       uint32_t                session_id;
-       struct psp_bin_desc             bin_desc;
-};
-
 struct ta_mem_context {
         struct amdgpu_bo                *shared_bo;
         uint64_t                shared_mc_addr;
@@ -158,6 +153,7 @@ struct ta_context {
         uint32_t                session_id;
         struct ta_mem_context   mem_context;
         struct psp_bin_desc             bin_desc;
+       enum psp_gfx_cmd_id             ta_load_type;
 };

 struct ta_cp_context {
@@ -331,7 +327,7 @@ struct psp_context
         const struct firmware           *ta_fw;
         uint32_t                        ta_fw_version;

-       struct psp_asd_context          asd_context;
+       struct ta_context               asd_context;
         struct psp_xgmi_context         xgmi_context;
         struct psp_ras_context          ras_context;
         struct ta_cp_context            hdcp_context;
--
2.17.1


--_000_BN9PR12MB5226E8E7B82216A8117A7B90FBDA9BN9PR12MB5226namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<font size=3D"2"><span style=3D"font-size:11pt">Reviewed-by: John Clements =
&lt;john.clements@amd.com&gt;</span></font><br>
</div>
<div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size: 11pt;" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Li, Candice &lt;Can=
dice.Li@amd.com&gt;<br>
<b>Sent:</b> Monday, September 13, 2021 3:54 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Clements, John &lt;John.Clements@amd.com&gt;; Li, Candice &lt;Ca=
ndice.Li@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Conform ASD header/loading to generic T=
A systems</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Update asd_context structure and add asd_initializ=
e function to<br>
conform ASD header/loading to generic TA systems.<br>
<br>
Signed-off-by: Candice Li &lt;candice.li@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 60 ++++++++++--------------=
-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 10 ++---<br>
&nbsp;2 files changed, 26 insertions(+), 44 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index 071dadf3a4509f..bc861f2fe0ecf6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -47,6 +47,7 @@ static void psp_sysfs_fini(struct amdgpu_device *adev);<b=
r>
&nbsp;<br>
&nbsp;static int psp_load_smu_fw(struct psp_context *psp);<br>
&nbsp;static int psp_ta_unload(struct psp_context *psp, uint32_t session_id=
);<br>
+static int psp_ta_load(struct psp_context *psp, struct ta_context *context=
);<br>
&nbsp;static int psp_rap_terminate(struct psp_context *psp);<br>
&nbsp;static int psp_securedisplay_terminate(struct psp_context *psp);<br>
&nbsp;<br>
@@ -781,23 +782,14 @@ static int psp_rl_load(struct amdgpu_device *adev)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-static void psp_prep_asd_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t asd_mc, uint32_t size)<br>
+static int psp_asd_load(struct psp_context *psp)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd_id =3D GFX_CMD_ID_LOAD_AS=
D;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ta.app_phy_addr_=
lo =3D lower_32_bits(asd_mc);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ta.app_phy_addr_=
hi =3D upper_32_bits(asd_mc);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ta.app_len =3D s=
ize;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ta.cmd_buf_phy_a=
ddr_lo =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ta.cmd_buf_phy_a=
ddr_hi =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ta.cmd_buf_len =
=3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return psp_ta_load(psp, &amp;psp-&gt;=
asd_context);<br>
&nbsp;}<br>
&nbsp;<br>
-static int psp_asd_load(struct psp_context *psp)<br>
+static int psp_asd_initialize(struct psp_context *psp)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If PSP version doesn't =
match ASD version, asd loading will be failed.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * add workaround to =
bypass it for sriov now.<br>
@@ -806,22 +798,13 @@ static int psp_asd_load(struct psp_context *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(psp-&g=
t;adev) || !psp-&gt;asd_context.bin_desc.size_bytes)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd =3D acquire_psp_cmd_buf(psp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;asd_context.mem_context.share=
d_mc_addr&nbsp; =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;asd_context.mem_context.share=
d_mem_size =3D PSP_ASD_SHARED_MEM_SIZE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;asd_context.ta_load_type&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; =3D GFX_CMD_ID_LOAD_ASD;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_copy_fw(psp, psp-&gt;asd_context.=
bin_desc.start_addr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;asd_context.bin_desc.size_bytes)=
;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_prep_asd_load_cmd_buf(cmd, psp-&g=
t;fw_pri_mc_addr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;asd_context.bin_desc.si=
ze_bytes);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_cmd_submit_buf(psp, NULL,=
 cmd,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;fence_buf_mc_addr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; psp-&gt;asd_context.asd_initialized =3D true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; psp-&gt;asd_context.session_id =3D cmd-&gt;resp.session_id;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_psp_cmd_buf(psp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_asd_load(psp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; psp-&gt;asd_context.initialized =3D true;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
@@ -859,13 +842,13 @@ static int psp_asd_terminate(struct psp_context *psp)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(psp-&g=
t;adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;asd_context.asd_initiali=
zed)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;asd_context.initialized)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_asd_unload(psp=
);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; psp-&gt;asd_context.asd_initialized =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; psp-&gt;asd_context.initialized =3D false;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
@@ -903,7 +886,7 @@ static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd=
_resp *cmd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ui=
nt64_t ta_bin_mc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; st=
ruct ta_context *context)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd_id&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
GFX_CMD_ID_LOAD_TA;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd_id&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
context-&gt;ta_load_type;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ta.ap=
p_phy_addr_lo&nbsp;&nbsp;&nbsp;&nbsp; =3D lower_32_bits(ta_bin_mc);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ta.ap=
p_phy_addr_hi&nbsp;&nbsp;&nbsp; =3D upper_32_bits(ta_bin_mc);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ta.ap=
p_len&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=
 context-&gt;bin_desc.size_bytes;<br>
@@ -970,8 +953,7 @@ static int psp_ta_invoke(struct psp_context *psp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-static int psp_ta_load(struct psp_context *psp,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; struct ta_context *context)<br>
+static int psp_ta_load(struct psp_context *psp, struct ta_context *context=
)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *c=
md;<br>
@@ -981,9 +963,7 @@ static int psp_ta_load(struct psp_context *psp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_copy_fw(psp, context-&=
gt;bin_desc.start_addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context-&gt;bin_desc.size_byt=
es);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_prep_ta_load_cmd_buf(cmd,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;fw_pri_mc_addr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_prep_ta_load_cmd_buf(cmd, psp-&gt=
;fw_pri_mc_addr, context);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_cmd_submit_buf=
(psp, NULL, cmd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;fence_buf_mc_addr)=
;<br>
@@ -1051,6 +1031,7 @@ int psp_xgmi_initialize(struct psp_context *psp, bool=
 set_extended_data, bool lo<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto invoke;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;xgmi_context.conte=
xt.mem_context.shared_mem_size =3D PSP_XGMI_SHARED_MEM_SIZE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;xgmi_context.context.ta_load_=
type =3D GFX_CMD_ID_LOAD_TA;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;xgmi_context.=
context.initialized) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D psp_xgmi_init_shared_buf(psp);<br>
@@ -1450,6 +1431,7 @@ static int psp_ras_initialize(struct psp_context *psp=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;ras_context.contex=
t.mem_context.shared_mem_size =3D PSP_RAS_SHARED_MEM_SIZE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;ras_context.context.ta_load_t=
ype =3D GFX_CMD_ID_LOAD_TA;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;ras_context.c=
ontext.initialized) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D psp_ras_init_shared_buf(psp);<br>
@@ -1539,6 +1521,7 @@ static int psp_hdcp_initialize(struct psp_context *ps=
p)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;hdcp_context.conte=
xt.mem_context.shared_mem_size =3D PSP_HDCP_SHARED_MEM_SIZE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;hdcp_context.context.ta_load_=
type =3D GFX_CMD_ID_LOAD_TA;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;hdcp_context.=
context.initialized) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D psp_hdcp_init_shared_buf(psp);<br>
@@ -1630,6 +1613,7 @@ static int psp_dtm_initialize(struct psp_context *psp=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;dtm_context.contex=
t.mem_context.shared_mem_size =3D PSP_DTM_SHARED_MEM_SIZE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;dtm_context.context.ta_load_t=
ype =3D GFX_CMD_ID_LOAD_TA;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;dtm_context.c=
ontext.initialized) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D psp_dtm_init_shared_buf(psp);<br>
@@ -1727,6 +1711,7 @@ static int psp_rap_initialize(struct psp_context *psp=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;rap_context.contex=
t.mem_context.shared_mem_size =3D PSP_RAP_SHARED_MEM_SIZE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;rap_context.context.ta_load_t=
ype =3D GFX_CMD_ID_LOAD_TA;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;rap_context.c=
ontext.initialized) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D psp_rap_init_shared_buf(psp);<br>
@@ -1842,6 +1827,7 @@ static int psp_securedisplay_initialize(struct psp_co=
ntext *psp)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;securedisplay_cont=
ext.context.mem_context.shared_mem_size =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; PSP_SECUREDISPLAY_SHARED_MEM_SIZE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;securedisplay_context.context=
.ta_load_type =3D GFX_CMD_ID_LOAD_TA;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;securedisplay=
_context.context.initialized) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D psp_securedisplay_init_shared_buf(psp);<br>
@@ -2419,7 +2405,7 @@ static int psp_load_fw(struct amdgpu_device *adev)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto failed;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_asd_load(psp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_asd_initialize(psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;PSP load asd failed!\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
@@ -2616,7 +2602,7 @@ static int psp_resume(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto failed;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_asd_load(psp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_asd_initialize(psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;PSP load asd failed!\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto failed;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h<br>
index cfd7ac976cd1e6..f29afabbff1fbe 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
@@ -39,6 +39,7 @@<br>
&nbsp;#define PSP_FW_NAME_LEN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0x24<br>
&nbsp;<br>
&nbsp;enum psp_shared_mem_size {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PSP_ASD_SHARED_MEM_SIZE&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PSP_XGMI_SHARED_MEM_SIZE&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x4000,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PSP_RAS_SHARED_MEM_SIZE&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x40=
00,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PSP_HDCP_SHARED_MEM_SIZE&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x4000,<b=
r>
@@ -140,12 +141,6 @@ struct psp_bin_desc {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *start_addr;<br>
&nbsp;};<br>
&nbsp;<br>
-struct psp_asd_context {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; asd_initialized;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; session_id;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_bin_desc&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bin_desc;<br>
-};<br>
-<br>
&nbsp;struct ta_mem_context {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; *shared_bo;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sh=
ared_mc_addr;<br>
@@ -158,6 +153,7 @@ struct ta_context {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; se=
ssion_id;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_mem_context&nbsp=
;&nbsp; mem_context;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_bin_desc&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bin_desc;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum psp_gfx_cmd_id&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ta_load_type;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct ta_cp_context {<br>
@@ -331,7 +327,7 @@ struct psp_context<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct firmware&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ta_fw;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ta_fw_version;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_asd_context&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; asd_context;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_context&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; asd_contex=
t;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_xgmi_context&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xgmi_context;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_ras_context&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_context;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_cp_context&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_context;<=
br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB5226E8E7B82216A8117A7B90FBDA9BN9PR12MB5226namp_--
