Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB26EB64DD
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jul 2023 05:29:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B5CF10E097;
	Thu, 13 Jul 2023 05:29:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5792910E097
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jul 2023 05:29:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBm+bS/3W4ZwzNvPw8UuPpY7/ZrC73I01EEbL5h2DhXxK6IapPgRsmczD1RayqLDSnj2aq5OEMe6D9+4DiqVt3lBd2gFK0zh5dbfJAqY7sNiue2F86qKzATz0zud9pnWFgjAp6TB34vKYkrKEPMsZU3+3sNzgY/Xn0S4xUll+jMH68GbG36+feMpMX1PuZbQ1nopBQHZlPM69w3uTdhTd+1H7VOJRKeZWrB2JIkLjZ+mYEKuKLEeVgkrcnpXpvc7KfBwyDU6u6/y4l6YpSr8Lfi6khESF9/nxQu8DojTevokMyNGJZ20Fiaqqb99aA/IpE8ajSM3zlVyoJUa10WF+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9dS3I71w+e1pkCMXg/u5SrlJxF5dkwKpUWPCXYD+tw=;
 b=W+4c7m2vUGYvzuOdvoldAeMrUbSiHIVIZkNlSpk4EJs9xlVRoHxy8m/148a380bEWE8kcunzrshBg9SzXW+Ok5572ONXQQYbX48zNWr5taBduLF/RZk/OhE47mFMdjtjVTW+B+kvuo2NoQH493owvRzr4xJRBJoXe1X8u4bnHC6qDlZXizos2j1/WGYT9Gio+FZOSzTDKElq/oBQc5KOfTSvLL6ofX3DXai221BRdXSLCjtGj1XXdtW4l6LP2riSPK1aiWXa2/l8wwGqjbhA7/3dSyD8winlfZ646Km+rxildFwMFqOUmbo8GwKdoNebmn7Ue06rdHh5m047Gadtkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9dS3I71w+e1pkCMXg/u5SrlJxF5dkwKpUWPCXYD+tw=;
 b=CPRZp2sDVpDrgzCNUiDpYT9nRFjCLXzJOPYhxN3k1/eucd5UHlzOiuRKt1Ju+sziXghoNMkj1o2I5U/oR7/4GBzZsRZeC/ZRsaO3+JhuAN8qLWmJnb2dAY5eiH5ffPOR6MUTyE+jJqefTvzP5vlvGaL3vWnNj5KPjlJyK8cghjc=
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Thu, 13 Jul
 2023 05:29:21 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c141:bba7:6b43:8c13]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c141:bba7:6b43:8c13%6]) with mapi id 15.20.6588.022; Thu, 13 Jul 2023
 05:29:21 +0000
From: "Gopalakrishnan, Veerabadhran (Veera)"
 <Veerabadhran.Gopalakrishnan@amd.com>
To: "Jamadar, Saleemkhan" <Saleemkhan.Jamadar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Olsak,
 Marek" <Marek.Olsak@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, 
 "Liu, Leo" <Leo.Liu@amd.com>
Subject: RE: [PATCH 2/2] Revert "drm/amdgpu:update kernel vcn ring test"
Thread-Topic: [PATCH 2/2] Revert "drm/amdgpu:update kernel vcn ring test"
Thread-Index: AQHZtUnH7ETImi95+UyycO5IUNQv6a+3KsWA
Date: Thu, 13 Jul 2023 05:29:21 +0000
Message-ID: <BYAPR12MB2693A1D082763531D8CED8CCFA37A@BYAPR12MB2693.namprd12.prod.outlook.com>
References: <20230713051948.3952921-1-saleemkhan.jamadar@amd.com>
 <20230713051948.3952921-2-saleemkhan.jamadar@amd.com>
In-Reply-To: <20230713051948.3952921-2-saleemkhan.jamadar@amd.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=628ace21-023b-46dd-8243-afed59a93640;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-13T05:27:10Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB2693:EE_|DM6PR12MB4283:EE_
x-ms-office365-filtering-correlation-id: 6442aabf-3e27-4317-0122-08db83621ccb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FWx3M9E/SU2qVD7W9yTakTWTtPEdUNZuba3ZbPOyMBtyUn1yObAPH1Lgp7ZNst/ODvyST6y4EAxkEOlMjEJSQ3iy8NMZtIiyTPEDvt4lFNcMYTWghfRDFH/HjedKGX8Ui/wvLSVBx2x3jpBwlkWlVRZF2GYqKv8qwTAdxfCa9NN1tC4MU81MQ2O3mqzdI9hXjeyTVcjgR74ZIexxz2ve+OFxHLKI7/Kyq25LsHtNpW/Rt2jo/MkPoiQJZ+mU1/etnStNtHNch9HQQ1HMNDo+qXFW66TPqXohdKqT/PDIcTZaefHF1geWKOEbjo5otxmpBkL8cA5zASAjnNn5TGDlU8SpDc3VvP+5fOo1fbyeowqK7gO0TUqqAux2Xfuvp/ar2nar8ymO+OknIWhQXIjCzD1fbgeub29WHxkkwCAJzYbMM9BqPyPBKP3Sq0UiGXcvWGdrR6mDPeUbvkgjLTrA1eqb7RmMNFhhW/3zWXwGFJjnEtqHqSDnWeKSExQR2AEmEFKXWaacGTr7nBIFpQuNm1uE9TLelDgNvHthg4HFDQSnoY/5de6FXunJdLib17lrNvMvfEQ9tMxuFoLBq3BiRIWQNeH2Ef+Z/cNceitk15X3E8PVOENobpNJivilTrXD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2693.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199021)(8676002)(8936002)(83380400001)(33656002)(2906002)(15650500001)(38100700002)(38070700005)(122000001)(6506007)(86362001)(53546011)(52536014)(26005)(5660300002)(55016003)(186003)(316002)(110136005)(71200400001)(4326008)(66446008)(66556008)(66476007)(64756008)(76116006)(7696005)(66946007)(6636002)(41300700001)(9686003)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ib42Ca87ssMZVaMfrEGskY7jlSPhVPWV5g331IiJe+qaFabc6qnaPvTj51X+?=
 =?us-ascii?Q?FtDQ14aCaY+mc/p3xwlJQGS3Svc60bTPVuHf6zam5MybB9m2RO6xx4OMeeGG?=
 =?us-ascii?Q?RTh/0vZhVFydr1S1Mbhn7mmeCZK2iSxg9l43w8GRTLXRrod8pbdvjRKI/nhF?=
 =?us-ascii?Q?k6bpleZAYVLIBf790oVYY/8Ryl/lwx7aDOh6Tv+sO+3iytK/kb+KSRa5cRqJ?=
 =?us-ascii?Q?T1r2cgRQrJ0tT6+Uhxi99LFdpi9WMNKVIrXm+hU71yuye5ItURBxRxLacFCg?=
 =?us-ascii?Q?D0S3N6AMOA5VLCrg0XpVNnyenosTsLNzwr6B2lYSbhFrTPi1vX7Po2afTBHt?=
 =?us-ascii?Q?TcQRLN3SKBKYSOY9Ok28+0BnIlXzlx1nzbF5G4p9bZP4ViKfw0Jy3wUY6VmJ?=
 =?us-ascii?Q?+RtX3S2hT4xREQcuc5tT5LzBkPC28Xe6rEP0xKPLXgFOkBB7FpIrFyXdI3xJ?=
 =?us-ascii?Q?9bnPRO2azq9RgwTM285RqvEMZYp8MNR7cxBPhgnuVNVzeLXyZNjOxf9Uy811?=
 =?us-ascii?Q?0I8rpbNlpE3DDu396fTgOMYJHyc8HRQj56yZfFNUjjsOjNEbPA3XBJaYP6kN?=
 =?us-ascii?Q?mL4jm2VUhgpCILERJN/zuqWJsjsJtVgEHqC/9Gd2ugli0wl73MwFrKiLce+X?=
 =?us-ascii?Q?FdxyAKDkfNdTTDSYMlrXIecCgiW4jc2rLmRTBWVu+vUpKlEFOWsJShpd9Pm/?=
 =?us-ascii?Q?mJEt88XpqhXNrSZ3R7UF5s5U5rSRhzcu7lbGye3q/sWoP2yRSM7ChomGs/FJ?=
 =?us-ascii?Q?c3wqsjZ/nxBihid3M+Qjc8E7vdP/nfNzBFqSSAquX9lhUefS0Osj9OHuEDYi?=
 =?us-ascii?Q?I9qXEDOObGZ0q72QzgOTvA9ptlqsjrCGjMNqfFTaBDwV1vCss2FDR2eM2pEd?=
 =?us-ascii?Q?hoggelliSkoBzCzHHY11rZl8+pJncr51/sw8d4nWJfF8kxea3A+NFNyupci2?=
 =?us-ascii?Q?KH3a9gonoACy2psCJNOPpXSDmZzqCI2IUk5x7U7cd0y1CoQIxjiFoTIUkNvO?=
 =?us-ascii?Q?m5VsQpoZiVZtd6pQ3gr9fZ5JIzcYmcWiAX6hv7Qerin+iFocGwKo/XHHmvc0?=
 =?us-ascii?Q?Dup5Nl3VtArJrS3dRA1FpK3YvIWEwvB0NCKLQJ6cWI1UYaSFa1l39VMj2GGg?=
 =?us-ascii?Q?gp8rjJIpm/Y8ogrhsf7r8SASRMFFUNZR/1+/2y9tB//hXdP/MM0Mm9w4uJdC?=
 =?us-ascii?Q?JkUI1lnV4GycR/oliaQvg2B5TDclIU47dXeCFLfBvDSwTFdbJCwFADnESlfT?=
 =?us-ascii?Q?/hQTs9irkv4pmnVjbBa2jwWJJixh/x5mD9qTMIdx8w/6GWd1HgyRkmHAkAiU?=
 =?us-ascii?Q?BbiyqQujBNoCygJu8mmUvv3pOVqqQhyD//ie718vVt8O4JtOXP+RQg5fmdPJ?=
 =?us-ascii?Q?nAjmQvVs1CGTtZbpipO8tt5S04YMtnSlfKtiq8tBJmYaeIsP7yUtP0gK9SYR?=
 =?us-ascii?Q?56eBPUSj5Lf/TUKlIMSJGCF003vJCpbVdBo1w2Rdqs/nSENAkTElLq68mvwi?=
 =?us-ascii?Q?DIucTgTvIm7bhJAF+PUCOhw7hrpt68T/5AkdR7rfCDNQCNYhaj1J40nhG9Pt?=
 =?us-ascii?Q?0m7WUeexd/yCgK4SQIo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6442aabf-3e27-4317-0122-08db83621ccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 05:29:21.5700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ns5cXjy0xvtKLdIYzFnfTdL+9tzxrfGNKwrpF04Y52HzyPkB0bf6ZAjy6vYKcAdb459Jl0NqkDwZS6pJnQEhNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4283
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
Cc: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

The revert patch set is looking good.

Acked-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>

-----Original Message-----
From: Jamadar, Saleemkhan <Saleemkhan.Jamadar@amd.com>
Sent: Thursday, July 13, 2023 10:50 AM
To: Jamadar, Saleemkhan <Saleemkhan.Jamadar@amd.com>; amd-gfx@lists.freedes=
ktop.org; Olsak, Marek <Marek.Olsak@amd.com>; Koenig, Christian <Christian.=
Koenig@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Gopalakrishnan, Veerabadhran (=
Veera) <Veerabadhran.Gopalakrishnan@amd.com>
Cc: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
Subject: [PATCH 2/2] Revert "drm/amdgpu:update kernel vcn ring test"

VCN FW depncencies revert it to unblock others

This reverts commit ce085b8068e1071b0068f9a5dee78c97ef587022.

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 13 ++-----------  drivers/gpu/dr=
m/amd/amdgpu/amdgpu_vcn.h |  5 +----
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index 8966ffb2f4a0..4e1256af80b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -591,15 +591,13 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgp=
u_ring *ring, uint32_t hand
        int r, i;

        memset(ib, 0, sizeof(*ib));
-       /* 34 pages : 128KiB  session context buffer size and 8KiB ib msg *=
/
-       r =3D amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 34,
+       r =3D amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
                        AMDGPU_IB_POOL_DIRECT,
                        ib);
        if (r)
                return r;

        msg =3D (uint32_t *)AMDGPU_GPU_PAGE_ALIGN((unsigned long)ib->ptr);
-       memset(msg, 0, (AMDGPU_GPU_PAGE_SIZE * 34));
        msg[0] =3D cpu_to_le32(0x00000028);
        msg[1] =3D cpu_to_le32(0x00000038);
        msg[2] =3D cpu_to_le32(0x00000001);
@@ -628,15 +626,13 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdg=
pu_ring *ring, uint32_t han
        int r, i;

        memset(ib, 0, sizeof(*ib));
-       /* 34 pages : 128KiB  session context buffer size and 8KiB ib msg *=
/
-       r =3D amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 34,
+       r =3D amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
                        AMDGPU_IB_POOL_DIRECT,
                        ib);
        if (r)
                return r;

        msg =3D (uint32_t *)AMDGPU_GPU_PAGE_ALIGN((unsigned long)ib->ptr);
-       memset(msg, 0, (AMDGPU_GPU_PAGE_SIZE * 34));
        msg[0] =3D cpu_to_le32(0x00000028);
        msg[1] =3D cpu_to_le32(0x00000018);
        msg[2] =3D cpu_to_le32(0x00000000);
@@ -722,7 +718,6 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_rin=
g *ring,
        struct amdgpu_job *job;
        struct amdgpu_ib *ib;
        uint64_t addr =3D AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
-       uint64_t session_ctx_buf_gaddr =3D AMDGPU_GPU_PAGE_ALIGN(ib_msg->gp=
u_addr + 8192);
        bool sq =3D amdgpu_vcn_using_unified_queue(ring);
        uint32_t *ib_checksum;
        uint32_t ib_pack_in_dw;
@@ -753,10 +748,6 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ri=
ng *ring,
        ib->length_dw +=3D sizeof(struct amdgpu_vcn_decode_buffer) / 4;
        memset(decode_buffer, 0, sizeof(struct amdgpu_vcn_decode_buffer));

-       decode_buffer->valid_buf_flag |=3D
-                               cpu_to_le32(AMDGPU_VCN_CMD_FLAG_SESSION_CON=
TEXT_BUFFER);
-       decode_buffer->session_context_buffer_address_hi =3D upper_32_bits(=
session_ctx_buf_gaddr);
-       decode_buffer->session_context_buffer_address_lo =3D lower_32_bits(=
session_ctx_buf_gaddr);
        decode_buffer->valid_buf_flag |=3D cpu_to_le32(AMDGPU_VCN_CMD_FLAG_=
MSG_BUFFER);
        decode_buffer->msg_buffer_address_hi =3D cpu_to_le32(addr >> 32);
        decode_buffer->msg_buffer_address_lo =3D cpu_to_le32(addr); diff --=
git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/=
amdgpu_vcn.h
index ba5fefd74197..1f1d7dc94f90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -171,7 +171,6 @@

 #define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER       0x00000001
 #define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER         0x00000001
-#define AMDGPU_VCN_CMD_FLAG_SESSION_CONTEXT_BUFFER     0x00100000

 #define VCN_CODEC_DISABLE_MASK_AV1  (1 << 0)  #define VCN_CODEC_DISABLE_MA=
SK_VP9  (1 << 1) @@ -367,9 +366,7 @@ struct amdgpu_vcn_decode_buffer {
        uint32_t valid_buf_flag;
        uint32_t msg_buffer_address_hi;
        uint32_t msg_buffer_address_lo;
-       uint32_t session_context_buffer_address_hi;
-       uint32_t session_context_buffer_address_lo;
-       uint32_t pad[28];
+       uint32_t pad[30];
 };

 #define VCN_BLOCK_ENCODE_DISABLE_MASK 0x80
--
2.25.1

