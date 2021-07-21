Return-Path: <SRS0=ovQZ=MN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F75EC12002
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 13:09:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F377E6120A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 13:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F377E6120A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A810B6EB89;
	Wed, 21 Jul 2021 13:08:59 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2083.outbound.protection.outlook.com [40.107.96.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5F0D6EB89
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jul 2021 13:08:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvYHkUeOeCMagn4RHzsCXy3V9354C7FBdpiQRp4IIYOUqquNvFfSR3fpOyLsmhlBh/Apa6PUIOOScsdST6U972ZEG3Vfebh0G6tKMmJK4k5L9NLgpv5clvhDdl89p+YiDM38K/1hrkULL7UsVY+freCRsZZiB2m+G6fgfaKsh82e2IbRfcW0Q5VXVjmOrao3jwOflgB8TjrXiC5D/lv+oySPjqApYBNjcsRfR1G20rZ4cX+ipRBJbHRQLIyD375RFOAOl8OweZV6puNtQpt8llFL3B36O5A0dN4PYD0AyxdqcrNrSY6krbioyLRmHKITwcblbSkh4bmJFfdFp9+MRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H216oDHiOe54LqBlPagYesI0CnF4jvCKdlFq7tDTCaY=;
 b=abQkga2QKLxQgNiQULfV0+W63Mb+29/fsjYZ7C1talF4wQxH9Zxfgwb6mBsk2B8I5L8E/nraFyilbXl3hdjtnJjGZDtXr+t0o4XO9cfsRqf89MyEauDpAft7BZQk8X3OmpAmxRCVuJ2KS9CM96hLengd93qFh+QcwX/3RVLYk3mF9+NAr4nP2ZMvNzjo1CiHynlpGfa2Josm8yovCZz+vHiRvsOQUmeHygJSoaGDCp580bDthniUF6o+Li9tIu8kiud73q+RatpZMvqU0mfIZcjBDsn6qZEsNGiu5D6nHY9/BHttc07AWiHzuxLfoRH70ghvlFh21Tn6gR117cOg2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H216oDHiOe54LqBlPagYesI0CnF4jvCKdlFq7tDTCaY=;
 b=n2ms6kVIef7dGNnwwhOInuXw0yKioJ/HUOasTEsWzJOBF3UCikYqpMcOEdS87VQt5tybj5tFWmbaQpWAKcTueb3BDhtjHkZOIZp1rviVH9cQTYM/+7X4FTt5k8wOxynhJZF3hAzoLEWeSEcpaKUCG9B0fgF/IeX08BrNTJR4aLs=
Received: from BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 by BN9PR12MB5099.namprd12.prod.outlook.com (2603:10b6:408:118::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Wed, 21 Jul
 2021 13:08:55 +0000
Received: from BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::d863:def1:2b7e:fc89]) by BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::d863:def1:2b7e:fc89%7]) with mapi id 15.20.4352.025; Wed, 21 Jul 2021
 13:08:55 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/amdgpu: add consistent PSP FW loading size
 checking
Thread-Topic: [PATCH] drm/amd/amdgpu: add consistent PSP FW loading size
 checking
Thread-Index: Add+JxtSggMbDXtWTTiVTdkZ8hDnjgACmPCd
Date: Wed, 21 Jul 2021 13:08:55 +0000
Message-ID: <BN9PR12MB5226E5AC96FB5A73C174CDBDFBE39@BN9PR12MB5226.namprd12.prod.outlook.com>
References: <DM6PR12MB464965C048F9B8FD46E5CAEF91E39@DM6PR12MB4649.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB464965C048F9B8FD46E5CAEF91E39@DM6PR12MB4649.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-21T13:08:50.352Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 387cc60e-8c8e-4a26-7882-08d94c48b1ab
x-ms-traffictypediagnostic: BN9PR12MB5099:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5099C32016667716AFC5C99FFBE39@BN9PR12MB5099.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z1X/3rWFUMwSHu0DEbCujsCwtVDJHC6UfRrw6Pqn0NUy8gHL7FRErp/Eetr5e3uSas7kkWciqlAMKqp08NfcHLqQgNeMRzpIr8r1JyFu6KLYOZTYw2jyODvjxfMUxViW7yqs0gWmVTqVwchCmNAxNPnennFTernDIc+kL5z4uyuYjWvavZIiVGiTbPTHFjSRxjjsH+QSCWF24wE6Em4/5u8XugY/4etGi6PNWJe52yZynVofWKfARpovYm97V5yqswrRsdDwE+s/0umAxmcXz+Of1zx7EjRrD2JUC94jHPYhxMvD/2WNpn8+lGbnFNshKBSuhGgCLMxl188lEq9aOPhbYJGTDu/ZkUQUHZ3Gf99M85RTHB5eJJwFUFuk3Hi7S4GmVaSX55AlNnPZDdH7XWALO7gNqo3WTtdwl6xVxkR8QvoQ1gDsGctt7IF5VmnbhM7iQHEjGXMg7Db5wlYjWZczkza9Z8DKSlNrA6fFxg/t/OEF0xhyry6aqfXmlTnmmaA2Z5YA+/mdYeIsiP6SuGWTInQEKEjWs619/ZqvLHNVNPA5e8JeEwgWd6F1/URMUrVLbKVtqeTnaiPRDSbpvZ4qInQL3cSmukjHdPy2/nYL5zUMR1zn7GKfkK/ysbbxKtr048fY+MSVpk1yqbaJ9e+5Jyx177wvLtu55HLaT7KfN7CeBKloidq/z1vUkTck0XzD7Ff9cxR3w5w90LuQsw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(110136005)(7696005)(53546011)(6506007)(8936002)(2906002)(52536014)(8676002)(64756008)(71200400001)(186003)(38100700002)(30864003)(66946007)(122000001)(66446008)(66556008)(66476007)(316002)(76116006)(91956017)(19627405001)(83380400001)(5660300002)(55016002)(86362001)(478600001)(9686003)(33656002)(38070700004)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jGku8lDUny3c0esS8zfg98YVSeX353yzyyV6UWrSD+63rhJ6A4sMWxGTsg?=
 =?iso-8859-1?Q?7qlWgHjyJn/6+f17/oT4WucSbQ2VS8Dm0ymNJuVniTAH840KdB9fAvGTWG?=
 =?iso-8859-1?Q?jYE3ixIPTpZ/+8jZmPf2TRoLtRXmemiaN6FB1paoXtm52NajmHvx9XMwoE?=
 =?iso-8859-1?Q?6aah+8RumbAOcLHKqS6ECxq9UFfN4GLmvKFVbA22jua5szBkU/U4RgZddc?=
 =?iso-8859-1?Q?3N5DSXXqnySO4CdyOBWQwVO5XstPHVQAvaP4LzhPPGdTmNOtoEYDeqg3KG?=
 =?iso-8859-1?Q?EPqCwndrFfGRFIOc1U7RHyIQo1vmdNca5dBdCb6gFxNOgLFwvNcO46tXBV?=
 =?iso-8859-1?Q?+neCDBc7lr56nEGQCg8Tv/XkSCfqSjicDZ0CWc1s61DhE/UTpNC1aCx0bN?=
 =?iso-8859-1?Q?tQBNZOo7BMDHvhtaWdFP12S+GsGu1FHZ6GcGu6Heek4uD8EGScj2y1ovWB?=
 =?iso-8859-1?Q?jNMJ9xcJP1HQHno9QkciXnqbJNhmMDNw0FrmJ2dR/ckdKamHQE1N6+ZJH3?=
 =?iso-8859-1?Q?+1V5c7iQbXEAnqB/UNnGb5qqiAtoW7qy1M8m/eq9K9dVLKcaEUSeXvri5y?=
 =?iso-8859-1?Q?FJKDltcqohGLX0iYezvx4kuDe0peLTZKhmcUh/I6zYDEY2ctY2gs6xACl1?=
 =?iso-8859-1?Q?TsR34jej/951lQT2iRleX//ustH22b0u9o0HRJt6Z/TnLGC9RE0JrAHko6?=
 =?iso-8859-1?Q?m4eKUbVqlyiiMqebCgUdzj02w3zVJGcH8wndJNXLF7Zn0JjKkuMvxhYzvx?=
 =?iso-8859-1?Q?fkVUZb8ETk4iQ1EjdK6dxfQDAvbrOwD55ckOSL/x44QIsKGaj48zhOO7fZ?=
 =?iso-8859-1?Q?nW6o98TcFevZETbPFMz86EuTCcm+xSG4EYXFimGWcfco0slF5RMfBNBQkj?=
 =?iso-8859-1?Q?nIVyetoFm3q1N6rdQJLI+Y5jlSvWLJ2XLYfSW46AXJGa+jr/JPwCdTRqf6?=
 =?iso-8859-1?Q?2CdTwe2PGjhEBACg5N1KRbqHdVLqqUF0Urlrv02WzWzGdByf9pq3cizVU6?=
 =?iso-8859-1?Q?iWZn7An0e1sfBPE/DnjPDE3IQtjtS93UHJanB5fMyHQ+L8ZDbjUkvDCslG?=
 =?iso-8859-1?Q?z5LuDFWptqyeR7rhma+WpnUfrieuB+JX2bKqeU4R5E85unFALYdUTicJDh?=
 =?iso-8859-1?Q?mEA4u9W3HSy2CPgs9HjAB1Z74rcdLkHFepHjmA3ChNfR5tlQLtb9Qm/TIQ?=
 =?iso-8859-1?Q?chBV6JEip+8j1r4pcNO4hcKW8/VfXWpAqnUg+xnK3QE4VBEo7qM1caL4UU?=
 =?iso-8859-1?Q?+XS9VY1vtHZ6AIX6DQqs2d2ZTHaGnVVXtHkvrgiZpERkNz9exIGm/iEcYT?=
 =?iso-8859-1?Q?i5nfz2q+bG0WXY6sNDOr1LR6Us4dcnUJWEA3JhqpT/MfKKYyi2vL7fQRVa?=
 =?iso-8859-1?Q?j/8GjMVn0hvbiAIm+GedELTdFcS3RfgNr7cK0aKuAyYzVGJXbxRkY=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 387cc60e-8c8e-4a26-7882-08d94c48b1ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2021 13:08:55.0681 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IhKenXcOVceTyu/TriWM+/6KwptxleN9REX7W7jrkj+cCTDUsrTGZkmNoW1RLR3b7eEdmyHAtywvBukj/ekpPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5099
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
Content-Type: multipart/mixed; boundary="===============2079931086=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2079931086==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN9PR12MB5226E5AC96FB5A73C174CDBDFBE39BN9PR12MB5226namp_"

--_000_BN9PR12MB5226E5AC96FB5A73C174CDBDFBE39BN9PR12MB5226namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: John Clements <John.Clements@amd.com>

________________________________
From: Li, Candice <Candice.Li@amd.com>
Sent: Wednesday, July 21, 2021 8:24 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Li, Candice <Candice.Li@amd.com>; Clements, John <John.Clements@amd.com=
>
Subject: [PATCH] drm/amd/amdgpu: add consistent PSP FW loading size checkin=
g


[Public]


Signed-off-by: Candice Li candice.li@amd.com<mailto:candice.li@amd.com>

---

drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   |   8 +-

drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 108 ++++++++++++----------

drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h   |  32 +++----

drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c |   2 +-

drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c  |   2 +-

drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    |   4 +-

drivers/gpu/drm/amd/amdgpu/psp_v11_0.c    |   8 +-

drivers/gpu/drm/amd/amdgpu/psp_v12_0.c    |   4 +-

drivers/gpu/drm/amd/amdgpu/psp_v13_0.c    |   6 +-

drivers/gpu/drm/amd/amdgpu/psp_v3_1.c     |   4 +-

drivers/gpu/drm/amd/amdgpu/soc15.c        |   4 +-

11 files changed, 96 insertions(+), 86 deletions(-)



diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c

index 66bf8b0c56bb..c239de0ace4f 100644

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c

+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c

@@ -373,8 +373,8 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_=
firmware *fw_info,

                            fw_info->feature =3D adev->sdma.instance[query_=
fw->index].feature_version;

                            break;

             case AMDGPU_INFO_FW_SOS:

-                           fw_info->ver =3D adev->psp.sos_fw_version;

-                           fw_info->feature =3D adev->psp.sos_feature_vers=
ion;

+                           fw_info->ver =3D adev->psp.sos.fw_version;

+                           fw_info->feature =3D adev->psp.sos.feature_vers=
ion;

                            break;

             case AMDGPU_INFO_FW_ASD:

                            fw_info->ver =3D adev->psp.asd_fw_version;

@@ -389,8 +389,8 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_=
firmware *fw_info,

                            fw_info->feature =3D 0;

                            break;

             case AMDGPU_INFO_FW_TOC:

-                           fw_info->ver =3D adev->psp.toc_fw_version;

-                           fw_info->feature =3D adev->psp.toc_feature_vers=
ion;

+                           fw_info->ver =3D adev->psp.toc.fw_version;

+                           fw_info->feature =3D adev->psp.toc.feature_vers=
ion;

                            break;

             default:

                            return -EINVAL;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c

index bd079979d5a3..14ade5dfef75 100644

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c

+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c

@@ -510,9 +510,9 @@ static int psp_load_toc(struct psp_context *psp,

                            return -ENOMEM;

             /* Copy toc to psp firmware private buffer */

             memset(psp->fw_pri_buf, 0, PSP_1_MEG);

-             memcpy(psp->fw_pri_buf, psp->toc_start_addr, psp->toc_bin_siz=
e);

+            memcpy(psp->fw_pri_buf, psp->toc.start_addr, psp->toc.size_byt=
es);

-             psp_prep_load_toc_cmd_buf(cmd, psp->fw_pri_mc_addr, psp->toc_=
bin_size);

+            psp_prep_load_toc_cmd_buf(cmd, psp->fw_pri_mc_addr, psp->toc.s=
ize_bytes);

              ret =3D psp_cmd_submit_buf(psp, NULL, cmd,

                                                          psp->fence_buf_mc=
_addr);

@@ -542,8 +542,8 @@ static int psp_tmr_init(struct psp_context *psp)

             /* For ASICs support RLC autoload, psp will parse the toc

              * and calculate the total size of TMR needed */

             if (!amdgpu_sriov_vf(psp->adev) &&

-                 psp->toc_start_addr &&

-                 psp->toc_bin_size &&

+                psp->toc.start_addr &&

+                psp->toc.size_bytes &&

                 psp->fw_pri_buf) {

                            ret =3D psp_load_toc(psp, &tmr_size);

                            if (ret) {

@@ -722,18 +722,18 @@ static int psp_rl_load(struct amdgpu_device *adev)

             struct psp_context *psp =3D &adev->psp;

             struct psp_gfx_cmd_resp *cmd =3D psp->cmd;

-             if (psp->rl_bin_size =3D=3D 0)

+            if (!is_psp_fw_valid(psp->rl))

                            return 0;

              memset(psp->fw_pri_buf, 0, PSP_1_MEG);

-             memcpy(psp->fw_pri_buf, psp->rl_start_addr, psp->rl_bin_size)=
;

+            memcpy(psp->fw_pri_buf, psp->rl.start_addr, psp->rl.size_bytes=
);

              memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));

              cmd->cmd_id =3D GFX_CMD_ID_LOAD_IP_FW;

             cmd->cmd.cmd_load_ip_fw.fw_phy_addr_lo =3D lower_32_bits(psp->=
fw_pri_mc_addr);

             cmd->cmd.cmd_load_ip_fw.fw_phy_addr_hi =3D upper_32_bits(psp->=
fw_pri_mc_addr);

-             cmd->cmd.cmd_load_ip_fw.fw_size =3D psp->rl_bin_size;

+            cmd->cmd.cmd_load_ip_fw.fw_size =3D psp->rl.size_bytes;

             cmd->cmd.cmd_load_ip_fw.fw_type =3D GFX_FW_TYPE_REG_LIST;

              return psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_a=
ddr);

@@ -2129,7 +2129,7 @@ static int psp_hw_start(struct psp_context *psp)

             int ret;

              if (!amdgpu_sriov_vf(adev)) {

-                           if (psp->kdb_bin_size &&

+                           if ((is_psp_fw_valid(psp->kdb)) &&

                                (psp->funcs->bootloader_load_kdb !=3D NULL)=
) {

                                          ret =3D psp_bootloader_load_kdb(p=
sp);

                                          if (ret) {

@@ -2138,7 +2138,8 @@ static int psp_hw_start(struct psp_context *psp)

                                          }

                            }

-                           if (psp->spl_bin_size) {

+                           if ((is_psp_fw_valid(psp->spl)) &&

+                              (psp->funcs->bootloader_load_spl !=3D NULL))=
 {

                                          ret =3D psp_bootloader_load_spl(p=
sp);

                                          if (ret) {

                                                         DRM_ERROR("PSP loa=
d spl failed!\n");

@@ -2146,16 +2147,22 @@ static int psp_hw_start(struct psp_context *psp)

                                          }

                            }

-                           ret =3D psp_bootloader_load_sysdrv(psp);

-                           if (ret) {

-                                          DRM_ERROR("PSP load sysdrv faile=
d!\n");

-                                          return ret;

+                           if ((is_psp_fw_valid(psp->sys)) &&

+                               (psp->funcs->bootloader_load_sysdrv !=3D NU=
LL)) {

+                                         ret =3D psp_bootloader_load_sysdr=
v(psp);

+                                         if (ret) {

+                                                       DRM_ERROR("PSP load=
 sysdrv failed!\n");

+                                                       return ret;

+                                         }

                            }

-                           ret =3D psp_bootloader_load_sos(psp);

-                           if (ret) {

-                                          DRM_ERROR("PSP load sos failed!\=
n");

-                                          return ret;

+                           if ((is_psp_fw_valid(psp->sos)) &&

+                               (psp->funcs->bootloader_load_sos !=3D NULL)=
) {

+                                         ret =3D psp_bootloader_load_sos(p=
sp);

+                                         if (ret) {

+                                                       DRM_ERROR("PSP load=
 sos failed!\n");

+                                                       return ret;

+                                         }

                            }

             }

@@ -2997,10 +3004,10 @@ int psp_init_toc_microcode(struct psp_context *psp,

                            goto out;

              toc_hdr =3D (const struct psp_firmware_header_v1_0 *)adev->ps=
p.toc_fw->data;

-             adev->psp.toc_fw_version =3D le32_to_cpu(toc_hdr->header.ucod=
e_version);

-             adev->psp.toc_feature_version =3D le32_to_cpu(toc_hdr->sos.fw=
_version);

-             adev->psp.toc_bin_size =3D le32_to_cpu(toc_hdr->header.ucode_=
size_bytes);

-             adev->psp.toc_start_addr =3D (uint8_t *)toc_hdr +

+            adev->psp.toc.fw_version =3D le32_to_cpu(toc_hdr->header.ucode=
_version);

+            adev->psp.toc.feature_version =3D le32_to_cpu(toc_hdr->sos.fw_=
version);

+            adev->psp.toc.size_bytes =3D le32_to_cpu(toc_hdr->header.ucode=
_size_bytes);

+            adev->psp.toc.start_addr =3D (uint8_t *)toc_hdr +

                                                        le32_to_cpu(toc_hdr=
->header.ucode_array_offset_bytes);

             return 0;

out:

@@ -3021,32 +3028,32 @@ static int psp_init_sos_base_fw(struct amdgpu_devic=
e *adev)

                            le32_to_cpu(sos_hdr->header.ucode_array_offset_=
bytes);

              if (adev->gmc.xgmi.connected_to_cpu || (adev->asic_type !=3D =
CHIP_ALDEBARAN)) {

-                           adev->psp.sos_fw_version =3D le32_to_cpu(sos_hd=
r->header.ucode_version);

-                           adev->psp.sos_feature_version =3D le32_to_cpu(s=
os_hdr->sos.fw_version);

+                           adev->psp.sos.fw_version =3D le32_to_cpu(sos_hd=
r->header.ucode_version);

+                           adev->psp.sos.feature_version =3D le32_to_cpu(s=
os_hdr->sos.fw_version);

-                           adev->psp.sys_bin_size =3D le32_to_cpu(sos_hdr-=
>sos.offset_bytes);

-                           adev->psp.sys_start_addr =3D ucode_array_start_=
addr;

+                           adev->psp.sys.size_bytes =3D le32_to_cpu(sos_hd=
r->sos.offset_bytes);

+                           adev->psp.sys.start_addr =3D ucode_array_start_=
addr;

-                           adev->psp.sos_bin_size =3D le32_to_cpu(sos_hdr-=
>sos.size_bytes);

-                           adev->psp.sos_start_addr =3D ucode_array_start_=
addr +

+                           adev->psp.sos.size_bytes =3D le32_to_cpu(sos_hd=
r->sos.size_bytes);

+                           adev->psp.sos.start_addr =3D ucode_array_start_=
addr +

                                                         le32_to_cpu(sos_hd=
r->sos.offset_bytes);

             } else {

                            /* Load alternate PSP SOS FW */

                            sos_hdr_v1_3 =3D (const struct psp_firmware_hea=
der_v1_3 *)adev->psp.sos_fw->data;

-                           adev->psp.sos_fw_version =3D le32_to_cpu(sos_hd=
r_v1_3->sos_aux.fw_version);

-                           adev->psp.sos_feature_version =3D le32_to_cpu(s=
os_hdr_v1_3->sos_aux.fw_version);

+                           adev->psp.sos.fw_version =3D le32_to_cpu(sos_hd=
r_v1_3->sos_aux.fw_version);

+                           adev->psp.sos.feature_version =3D le32_to_cpu(s=
os_hdr_v1_3->sos_aux.fw_version);

-                           adev->psp.sys_bin_size =3D le32_to_cpu(sos_hdr_=
v1_3->sys_drv_aux.size_bytes);

-                           adev->psp.sys_start_addr =3D ucode_array_start_=
addr +

+                           adev->psp.sys.size_bytes =3D le32_to_cpu(sos_hd=
r_v1_3->sys_drv_aux.size_bytes);

+                           adev->psp.sys.start_addr =3D ucode_array_start_=
addr +

                                          le32_to_cpu(sos_hdr_v1_3->sys_drv=
_aux.offset_bytes);

-                           adev->psp.sos_bin_size =3D le32_to_cpu(sos_hdr_=
v1_3->sos_aux.size_bytes);

-                           adev->psp.sos_start_addr =3D ucode_array_start_=
addr +

+                           adev->psp.sos.size_bytes =3D le32_to_cpu(sos_hd=
r_v1_3->sos_aux.size_bytes);

+                           adev->psp.sos.start_addr =3D ucode_array_start_=
addr +

                                          le32_to_cpu(sos_hdr_v1_3->sos_aux=
.offset_bytes);

             }

-             if ((adev->psp.sys_bin_size =3D=3D 0) || (adev->psp.sos_bin_s=
ize =3D=3D 0)) {

+            if ((adev->psp.sys.size_bytes =3D=3D 0) || (adev->psp.sos.size=
_bytes =3D=3D 0)) {

                            dev_warn(adev->dev, "PSP SOS FW not available")=
;

                            return -EINVAL;

             }

@@ -3093,32 +3100,32 @@ int psp_init_sos_microcode(struct psp_context *psp,

                             if (sos_hdr->header.header_version_minor =3D=
=3D 1) {

                                          sos_hdr_v1_1 =3D (const struct ps=
p_firmware_header_v1_1 *)adev->psp.sos_fw->data;

-                                          adev->psp.toc_bin_size =3D le32_=
to_cpu(sos_hdr_v1_1->toc.size_bytes);

-                                          adev->psp.toc_start_addr =3D (ui=
nt8_t *)adev->psp.sys_start_addr +

+                                         adev->psp.toc.size_bytes =3D le32=
_to_cpu(sos_hdr_v1_1->toc.size_bytes);

+                                         adev->psp.toc.start_addr =3D (uin=
t8_t *)adev->psp.sys.start_addr +

                                                                       le32=
_to_cpu(sos_hdr_v1_1->toc.offset_bytes);

-                                          adev->psp.kdb_bin_size =3D le32_=
to_cpu(sos_hdr_v1_1->kdb.size_bytes);

-                                          adev->psp.kdb_start_addr =3D (ui=
nt8_t *)adev->psp.sys_start_addr +

+                                         adev->psp.kdb.size_bytes =3D le32=
_to_cpu(sos_hdr_v1_1->kdb.size_bytes);

+                                         adev->psp.kdb.start_addr =3D (uin=
t8_t *)adev->psp.sys.start_addr +

                                                                       le32=
_to_cpu(sos_hdr_v1_1->kdb.offset_bytes);

                            }

                            if (sos_hdr->header.header_version_minor =3D=3D=
 2) {

                                          sos_hdr_v1_2 =3D (const struct ps=
p_firmware_header_v1_2 *)adev->psp.sos_fw->data;

-                                          adev->psp.kdb_bin_size =3D le32_=
to_cpu(sos_hdr_v1_2->kdb.size_bytes);

-                                          adev->psp.kdb_start_addr =3D (ui=
nt8_t *)adev->psp.sys_start_addr +

+                                         adev->psp.kdb.size_bytes =3D le32=
_to_cpu(sos_hdr_v1_2->kdb.size_bytes);

+                                         adev->psp.kdb.start_addr =3D (uin=
t8_t *)adev->psp.sys.start_addr +

                                                                           =
              le32_to_cpu(sos_hdr_v1_2->kdb.offset_bytes);

                            }

                            if (sos_hdr->header.header_version_minor =3D=3D=
 3) {

                                          sos_hdr_v1_3 =3D (const struct ps=
p_firmware_header_v1_3 *)adev->psp.sos_fw->data;

-                                          adev->psp.toc_bin_size =3D le32_=
to_cpu(sos_hdr_v1_3->v1_1.toc.size_bytes);

-                                          adev->psp.toc_start_addr =3D uco=
de_array_start_addr +

+                                         adev->psp.toc.size_bytes =3D le32=
_to_cpu(sos_hdr_v1_3->v1_1.toc.size_bytes);

+                                         adev->psp.toc.start_addr =3D ucod=
e_array_start_addr +

                                                        le32_to_cpu(sos_hdr=
_v1_3->v1_1.toc.offset_bytes);

-                                          adev->psp.kdb_bin_size =3D le32_=
to_cpu(sos_hdr_v1_3->v1_1.kdb.size_bytes);

-                                          adev->psp.kdb_start_addr =3D uco=
de_array_start_addr +

+                                         adev->psp.kdb.size_bytes =3D le32=
_to_cpu(sos_hdr_v1_3->v1_1.kdb.size_bytes);

+                                         adev->psp.kdb.start_addr =3D ucod=
e_array_start_addr +

                                                        le32_to_cpu(sos_hdr=
_v1_3->v1_1.kdb.offset_bytes);

-                                          adev->psp.spl_bin_size =3D le32_=
to_cpu(sos_hdr_v1_3->spl.size_bytes);

-                                          adev->psp.spl_start_addr =3D uco=
de_array_start_addr +

+                                         adev->psp.spl.size_bytes =3D le32=
_to_cpu(sos_hdr_v1_3->spl.size_bytes);

+                                         adev->psp.spl.start_addr =3D ucod=
e_array_start_addr +

                                                        le32_to_cpu(sos_hdr=
_v1_3->spl.offset_bytes);

-                                          adev->psp.rl_bin_size =3D le32_t=
o_cpu(sos_hdr_v1_3->rl.size_bytes);

-                                          adev->psp.rl_start_addr =3D ucod=
e_array_start_addr +

+                                         adev->psp.rl.size_bytes =3D le32_=
to_cpu(sos_hdr_v1_3->rl.size_bytes);

+                                         adev->psp.rl.start_addr =3D ucode=
_array_start_addr +

                                                        le32_to_cpu(sos_hdr=
_v1_3->rl.offset_bytes);

                            }

                            break;

@@ -3345,7 +3352,10 @@ static DEVICE_ATTR(usbc_pd_fw, S_IRUGO | S_IWUSR,

                               psp_usbc_pd_fw_sysfs_read,

                               psp_usbc_pd_fw_sysfs_write);

-

+int is_psp_fw_valid(struct psp_bin_desc bin)

+{

+            return bin.size_bytes;

+}

 const struct amd_ip_funcs psp_ip_funcs =3D {

             .name =3D "psp",

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h

index f5b967b18e3f..fbbb1abf639f 100644

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h

+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h

@@ -48,6 +48,7 @@

struct psp_context;

struct psp_xgmi_node_info;

struct psp_xgmi_topology_info;

+struct psp_bin_desc;

 enum psp_bootloader_cmd {

             PSP_BL__LOAD_SYSDRV                            =3D 0x10000,

@@ -283,6 +284,13 @@ struct psp_runtime_boot_cfg_entry {

             uint32_t reserved;

};

+struct psp_bin_desc {

+            uint32_t fw_version;

+            uint32_t feature_version;

+            uint32_t size_bytes;

+            uint8_t *start_addr;

+};

+

struct psp_context

{

             struct amdgpu_device            *adev;

@@ -298,20 +306,12 @@ struct psp_context

              /* sos firmware */

             const struct firmware                   *sos_fw;

-             uint32_t                                          sos_fw_vers=
ion;

-             uint32_t                                          sos_feature=
_version;

-             uint32_t                                          sys_bin_siz=
e;

-             uint32_t                                          sos_bin_siz=
e;

-             uint32_t                                          toc_bin_siz=
e;

-             uint32_t                                          kdb_bin_siz=
e;

-             uint32_t                                          spl_bin_siz=
e;

-             uint32_t                                          rl_bin_size=
;

-             uint8_t                                             *sys_star=
t_addr;

-             uint8_t                                             *sos_star=
t_addr;

-             uint8_t                                             *toc_star=
t_addr;

-             uint8_t                                             *kdb_star=
t_addr;

-             uint8_t                                             *spl_star=
t_addr;

-             uint8_t                                             *rl_start=
_addr;

+            struct psp_bin_desc                                    sys;

+            struct psp_bin_desc                                    sos;

+            struct psp_bin_desc                                    toc;

+            struct psp_bin_desc                                    kdb;

+            struct psp_bin_desc                                    spl;

+            struct psp_bin_desc                                    rl;

              /* tmr buffer */

             struct amdgpu_bo                        *tmr_bo;

@@ -326,8 +326,6 @@ struct psp_context

              /* toc firmware */

             const struct firmware                   *toc_fw;

-             uint32_t                                          toc_fw_vers=
ion;

-             uint32_t                                          toc_feature=
_version;

              /* fence buffer */

             struct amdgpu_bo                        *fence_buf_bo;

@@ -482,4 +480,6 @@ int psp_get_fw_attestation_records_addr(struct psp_cont=
ext *psp,

 int psp_load_fw_list(struct psp_context *psp,

                                 struct amdgpu_firmware_info **ucode_list, =
int ucode_count);

+

+int is_psp_fw_valid(struct psp_bin_desc bin);

#endif

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.c

index fe601f67d3a7..8e9b1f9fa34f 100644

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c

+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c

@@ -518,7 +518,7 @@ FW_VERSION_ATTR(rlc_srlg_fw_version, 0444, gfx.rlc_srlg=
_fw_version);

FW_VERSION_ATTR(rlc_srls_fw_version, 0444, gfx.rlc_srls_fw_version);

FW_VERSION_ATTR(mec_fw_version, 0444, gfx.mec_fw_version);

FW_VERSION_ATTR(mec2_fw_version, 0444, gfx.mec2_fw_version);

-FW_VERSION_ATTR(sos_fw_version, 0444, psp.sos_fw_version);

+FW_VERSION_ATTR(sos_fw_version, 0444, psp.sos.fw_version);

FW_VERSION_ATTR(asd_fw_version, 0444, psp.asd_fw_version);

FW_VERSION_ATTR(ta_ras_fw_version, 0444, psp.ta_ras_ucode_version);

FW_VERSION_ATTR(ta_xgmi_fw_version, 0444, psp.ta_xgmi_ucode_version);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c

index b71dd1deeb2d..12a7cc2f01cd 100644

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c

+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c

@@ -531,7 +531,7 @@ static void amdgpu_virt_populate_vf2pf_ucode_info(struc=
t amdgpu_device *adev)

             POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_RLC_SRLS, a=
dev->gfx.rlc_srls_fw_version);

             POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC,      a=
dev->gfx.mec_fw_version);

             POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC2,     a=
dev->gfx.mec2_fw_version);

-             POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SOS,      =
adev->psp.sos_fw_version);

+            POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SOS,      a=
dev->psp.sos.fw_version);

             POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_ASD,      a=
dev->psp.asd_fw_version);

             POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_TA_RAS,   a=
dev->psp.ta_ras_ucode_version);

             POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_TA_XGMI,  a=
dev->psp.ta_xgmi_ucode_version);

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c

index 38738ca56786..479a57eaba8e 100644

--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c

+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c

@@ -5401,7 +5401,7 @@ static int gfx_v10_0_parse_rlc_toc(struct amdgpu_devi=
ce *adev)

             int ret;

             RLC_TABLE_OF_CONTENT *rlc_toc;

-             ret =3D amdgpu_bo_create_reserved(adev, adev->psp.toc_bin_siz=
e, PAGE_SIZE,

+            ret =3D amdgpu_bo_create_reserved(adev, adev->psp.toc.size_byt=
es, PAGE_SIZE,

                                                                       AMDG=
PU_GEM_DOMAIN_GTT,

                                                                       &ade=
v->gfx.rlc.rlc_toc_bo,

                                                                       &ade=
v->gfx.rlc.rlc_toc_gpu_addr,

@@ -5412,7 +5412,7 @@ static int gfx_v10_0_parse_rlc_toc(struct amdgpu_devi=
ce *adev)

             }

              /* Copy toc from psp sos fw to rlc toc buffer */

-             memcpy(adev->gfx.rlc.rlc_toc_buf, adev->psp.toc_start_addr, a=
dev->psp.toc_bin_size);

+            memcpy(adev->gfx.rlc.rlc_toc_buf, adev->psp.toc.start_addr, ad=
ev->psp.toc.size_bytes);

              rlc_toc =3D (RLC_TABLE_OF_CONTENT *)adev->gfx.rlc.rlc_toc_buf=
;

             while (rlc_toc && (rlc_toc->id > FIRMWARE_ID_INVALID) &&

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v11_0.c

index 21b8b6d48d8f..3eb14f7e3322 100644

--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c

+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c

@@ -288,7 +288,7 @@ static int psp_v11_0_bootloader_load_kdb(struct psp_con=
text *psp)

             memset(psp->fw_pri_buf, 0, PSP_1_MEG);

              /* Copy PSP KDB binary to memory */

-             memcpy(psp->fw_pri_buf, psp->kdb_start_addr, psp->kdb_bin_siz=
e);

+            memcpy(psp->fw_pri_buf, psp->kdb.start_addr, psp->kdb.size_byt=
es);

              /* Provide the PSP KDB to bootloader */

             WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,

@@ -321,7 +321,7 @@ static int psp_v11_0_bootloader_load_spl(struct psp_con=
text *psp)

             memset(psp->fw_pri_buf, 0, PSP_1_MEG);

              /* Copy PSP SPL binary to memory */

-             memcpy(psp->fw_pri_buf, psp->spl_start_addr, psp->spl_bin_siz=
e);

+            memcpy(psp->fw_pri_buf, psp->spl.start_addr, psp->spl.size_byt=
es);

              /* Provide the PSP SPL to bootloader */

             WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,

@@ -354,7 +354,7 @@ static int psp_v11_0_bootloader_load_sysdrv(struct psp_=
context *psp)

             memset(psp->fw_pri_buf, 0, PSP_1_MEG);

              /* Copy PSP System Driver binary to memory */

-             memcpy(psp->fw_pri_buf, psp->sys_start_addr, psp->sys_bin_siz=
e);

+            memcpy(psp->fw_pri_buf, psp->sys.start_addr, psp->sys.size_byt=
es);

              /* Provide the sys driver to bootloader */

             WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,

@@ -390,7 +390,7 @@ static int psp_v11_0_bootloader_load_sos(struct psp_con=
text *psp)

             memset(psp->fw_pri_buf, 0, PSP_1_MEG);

              /* Copy Secure OS binary to PSP memory */

-             memcpy(psp->fw_pri_buf, psp->sos_start_addr, psp->sos_bin_siz=
e);

+            memcpy(psp->fw_pri_buf, psp->sos.start_addr, psp->sos.size_byt=
es);

              /* Provide the PSP secure OS to bootloader */

             WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v12_0.c

index b0ee77ee80b9..32413c059bee 100644

--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c

+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c

@@ -140,7 +140,7 @@ static int psp_v12_0_bootloader_load_sysdrv(struct psp_=
context *psp)

             memset(psp->fw_pri_buf, 0, PSP_1_MEG);

              /* Copy PSP System Driver binary to memory */

-             memcpy(psp->fw_pri_buf, psp->sys_start_addr, psp->sys_bin_siz=
e);

+            memcpy(psp->fw_pri_buf, psp->sys.start_addr, psp->sys.size_byt=
es);

              /* Provide the sys driver to bootloader */

             WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,

@@ -181,7 +181,7 @@ static int psp_v12_0_bootloader_load_sos(struct psp_con=
text *psp)

             memset(psp->fw_pri_buf, 0, PSP_1_MEG);

              /* Copy Secure OS binary to PSP memory */

-             memcpy(psp->fw_pri_buf, psp->sos_start_addr, psp->sos_bin_siz=
e);

+            memcpy(psp->fw_pri_buf, psp->sos.start_addr, psp->sos.size_byt=
es);

              /* Provide the PSP secure OS to bootloader */

             WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c

index e1046bb3bab0..d017da3ceadb 100644

--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c

+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c

@@ -136,7 +136,7 @@ static int psp_v13_0_bootloader_load_kdb(struct psp_con=
text *psp)

             memset(psp->fw_pri_buf, 0, PSP_1_MEG);

              /* Copy PSP KDB binary to memory */

-             memcpy(psp->fw_pri_buf, psp->kdb_start_addr, psp->kdb_bin_siz=
e);

+            memcpy(psp->fw_pri_buf, psp->kdb.start_addr, psp->kdb.size_byt=
es);

              /* Provide the PSP KDB to bootloader */

             WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36,

@@ -169,7 +169,7 @@ static int psp_v13_0_bootloader_load_sysdrv(struct psp_=
context *psp)

             memset(psp->fw_pri_buf, 0, PSP_1_MEG);

              /* Copy PSP System Driver binary to memory */

-             memcpy(psp->fw_pri_buf, psp->sys_start_addr, psp->sys_bin_siz=
e);

+            memcpy(psp->fw_pri_buf, psp->sys.start_addr, psp->sys.size_byt=
es);

              /* Provide the sys driver to bootloader */

             WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36,

@@ -205,7 +205,7 @@ static int psp_v13_0_bootloader_load_sos(struct psp_con=
text *psp)

             memset(psp->fw_pri_buf, 0, PSP_1_MEG);

              /* Copy Secure OS binary to PSP memory */

-             memcpy(psp->fw_pri_buf, psp->sos_start_addr, psp->sos_bin_siz=
e);

+            memcpy(psp->fw_pri_buf, psp->sos.start_addr, psp->sos.size_byt=
es);

              /* Provide the PSP secure OS to bootloader */

             WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36,

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/am=
dgpu/psp_v3_1.c

index be05d9cbd41e..29aac7b793f4 100644

--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c

+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c

@@ -105,7 +105,7 @@ static int psp_v3_1_bootloader_load_sysdrv(struct psp_c=
ontext *psp)

             memset(psp->fw_pri_buf, 0, PSP_1_MEG);

              /* Copy PSP System Driver binary to memory */

-             memcpy(psp->fw_pri_buf, psp->sys_start_addr, psp->sys_bin_siz=
e);

+            memcpy(psp->fw_pri_buf, psp->sys.start_addr, psp->sys.size_byt=
es);

              /* Provide the sys driver to bootloader */

             WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,

@@ -146,7 +146,7 @@ static int psp_v3_1_bootloader_load_sos(struct psp_cont=
ext *psp)

             memset(psp->fw_pri_buf, 0, PSP_1_MEG);

              /* Copy Secure OS binary to PSP memory */

-             memcpy(psp->fw_pri_buf, psp->sos_start_addr, psp->sos_bin_siz=
e);

+            memcpy(psp->fw_pri_buf, psp->sos.start_addr, psp->sos.size_byt=
es);

              /* Provide the PSP secure OS to bootloader */

             WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c

index b7d350be8050..a5e085e570f7 100644

--- a/drivers/gpu/drm/amd/amdgpu/soc15.c

+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c

@@ -575,7 +575,7 @@ soc15_asic_reset_method(struct amdgpu_device *adev)

                            baco_reset =3D amdgpu_dpm_is_baco_supported(ade=
v);

                            break;

             case CHIP_VEGA20:

-                           if (adev->psp.sos_fw_version >=3D 0x80067)

+                           if (adev->psp.sos.fw_version >=3D 0x80067)

                                          baco_reset =3D amdgpu_dpm_is_baco=
_supported(adev);

                             /*

@@ -635,7 +635,7 @@ static bool soc15_supports_baco(struct amdgpu_device *a=
dev)

             case CHIP_ARCTURUS:

                            return amdgpu_dpm_is_baco_supported(adev);

             case CHIP_VEGA20:

-                           if (adev->psp.sos_fw_version >=3D 0x80067)

+                           if (adev->psp.sos.fw_version >=3D 0x80067)

                                          return amdgpu_dpm_is_baco_support=
ed(adev);

                            return false;

             default:

--

2.17.1









Thanks,

Candice



--_000_BN9PR12MB5226E5AC96FB5A73C174CDBDFBE39BN9PR12MB5226namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<font size=3D"2"><span style=3D"font-size:11pt">Reviewed-by: John Clements =
&lt;John.Clements@amd.com&gt;</span></font><br>
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
<b>Sent:</b> Wednesday, July 21, 2021 8:24 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Li, Candice &lt;Candice.Li@amd.com&gt;; Clements, John &lt;John.=
Clements@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/amdgpu: add consistent PSP FW loading size =
checking</font>
<div>&nbsp;</div>
</div>
<div style=3D"word-wrap:break-word" lang=3D"EN-US">
<p class=3D"x_msipheaderc10f11a2" style=3D"margin:0" align=3D"Left"><span s=
tyle=3D"font-size: 10pt; font-family: Arial; color: rgb(0, 128, 0);">[Publi=
c]</span></p>
<br>
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
Signed-off-by: Candice Li <a href=3D"mailto:candice.li@amd.com">candice.li@=
amd.com</a></p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
---</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c&nbsp;&nbsp; |&nbsp;&nbsp; 8 +-</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c&nbsp;&nbsp; | 108 ++++++++++++-----=
-----</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h&nbsp;&nbsp; |&nbsp; 32 +++----</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c |&nbsp;&nbsp; 2 +-</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c&nbsp; |&nbsp;&nbsp; 2 +-</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 +-=
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
drivers/gpu/drm/amd/amdgpu/psp_v11_0.c&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 8 +-=
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
drivers/gpu/drm/amd/amdgpu/psp_v12_0.c&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 +-=
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
drivers/gpu/drm/amd/amdgpu/psp_v13_0.c&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 6 +-=
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
drivers/gpu/drm/amd/amdgpu/psp_v3_1.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;=
 4 +-</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
drivers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp;&nbsp; 4 +-</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
11 files changed, 96 insertions(+), 86 deletions(-)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
index 66bf8b0c56bb..c239de0ace4f 100644</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -373,8 +373,8 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_=
firmware *fw_info,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; fw_info-&gt;feature =3D adev-&gt;sdma.instance[query_fw-&gt;in=
dex].feature_version;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; break;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ca=
se AMDGPU_INFO_FW_SOS:</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; fw_info-&gt;ver =3D adev-&gt;psp.sos_fw_version;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; fw_info-&gt;feature =3D adev-&gt;psp.sos_feature_version;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; fw_info-&gt;ver =3D adev-&gt;psp.sos.fw_version;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; fw_info-&gt;feature =3D adev-&gt;psp.sos.feature_version;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; break;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ca=
se AMDGPU_INFO_FW_ASD:</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; fw_info-&gt;ver =3D adev-&gt;psp.asd_fw_version;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -389,8 +389,8 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_=
firmware *fw_info,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; fw_info-&gt;feature =3D 0;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; break;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ca=
se AMDGPU_INFO_FW_TOC:</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; fw_info-&gt;ver =3D adev-&gt;psp.toc_fw_version;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; fw_info-&gt;feature =3D adev-&gt;psp.toc_feature_version;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; fw_info-&gt;ver =3D adev-&gt;psp.toc.fw_version;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; fw_info-&gt;feature =3D adev-&gt;psp.toc.feature_version;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; break;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; de=
fault:</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; return -EINVAL;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
index bd079979d5a3..14ade5dfef75 100644</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -510,9 +510,9 @@ static int psp_load_toc(struct psp_context *psp,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; return -ENOMEM;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*=
 Copy toc to psp firmware private buffer */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; me=
mset(psp-&gt;fw_pri_buf, 0, PSP_1_MEG);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m=
emcpy(psp-&gt;fw_pri_buf, psp-&gt;toc_start_addr, psp-&gt;toc_bin_size);</p=
>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(=
psp-&gt;fw_pri_buf, psp-&gt;toc.start_addr, psp-&gt;toc.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
sp_prep_load_toc_cmd_buf(cmd, psp-&gt;fw_pri_mc_addr, psp-&gt;toc_bin_size)=
;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_pre=
p_load_toc_cmd_buf(cmd, psp-&gt;fw_pri_mc_addr, psp-&gt;toc.size_bytes);</p=
>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D psp_cmd_submit_buf(psp, NULL, cmd,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;psp-&gt;fence_buf_mc_addr);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -542,8 +542,8 @@ static int psp_tmr_init(struct psp_context *psp)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*=
 For ASICs support RLC autoload, psp will parse the toc</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &n=
bsp;* and calculate the total size of TMR needed */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (!amdgpu_sriov_vf(psp-&gt;adev) &amp;&amp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; psp-&gt;toc_start_addr &amp;&amp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; psp-&gt;toc_bin_size &amp;&amp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; psp-&gt;toc.start_addr &amp;&amp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; psp-&gt;toc.size_bytes &amp;&amp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp;&nbsp;psp-&gt;fw_pri_buf) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; ret =3D psp_load_toc(psp, &amp;tmr_size);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (ret) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -722,18 +722,18 @@ static int psp_rl_load(struct amdgpu_device *adev)</p=
>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; st=
ruct psp_context *psp =3D &amp;adev-&gt;psp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; st=
ruct psp_gfx_cmd_resp *cmd =3D psp-&gt;cmd;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
f (psp-&gt;rl_bin_size =3D=3D 0)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!is=
_psp_fw_valid(psp-&gt;rl))</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; return 0;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; memset(psp-&gt;fw_pri_buf, 0, PSP_1_MEG);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m=
emcpy(psp-&gt;fw_pri_buf, psp-&gt;rl_start_addr, psp-&gt;rl_bin_size);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(=
psp-&gt;fw_pri_buf, psp-&gt;rl.start_addr, psp-&gt;rl.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; cmd-&gt;cmd_id =3D GFX_CMD_ID_LOAD_IP_FW;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cm=
d-&gt;cmd.cmd_load_ip_fw.fw_phy_addr_lo =3D lower_32_bits(psp-&gt;fw_pri_mc=
_addr);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cm=
d-&gt;cmd.cmd_load_ip_fw.fw_phy_addr_hi =3D upper_32_bits(psp-&gt;fw_pri_mc=
_addr);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c=
md-&gt;cmd.cmd_load_ip_fw.fw_size =3D psp-&gt;rl_bin_size;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt=
;cmd.cmd_load_ip_fw.fw_size =3D psp-&gt;rl.size_bytes;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cm=
d-&gt;cmd.cmd_load_ip_fw.fw_type =3D GFX_FW_TYPE_REG_LIST;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return psp_cmd_submit_buf(psp, NULL, cmd, psp-&gt;fence_buf_mc_addr);</=
p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -2129,7 +2129,7 @@ static int psp_hw_start(struct psp_context *psp)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in=
t ret;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!amdgpu_sriov_vf(adev)) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (psp-&gt;kdb_bin_size &amp;&amp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if ((is_psp_fw_valid(psp-&gt;kdb)) &amp;&amp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;(psp-&gt;funcs-&gt;bootloader_load_kdb=
 !=3D NULL)) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D psp_bootloader_load_kdb(psp);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -2138,7 +2138,8 @@ static int psp_hw_start(struct psp_context *psp)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (psp-&gt;spl_bin_size) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if ((is_psp_fw_valid(psp-&gt;spl)) &amp;&amp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp;(psp-&gt;funcs-&gt;bootloader_load_spl !=3D NULL)=
) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D psp_bootloader_load_spl(psp);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;PSP load spl failed!\n=
&quot;);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -2146,16 +2147,22 @@ static int psp_hw_start(struct psp_context *psp)</p=
>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D psp_bootloader_load_sysdrv(psp);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (ret) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;PSP load sysdrv failed!\n&quot;);</p=
>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; return ret;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if ((is_psp_fw_valid(psp-&gt;sys)) &amp;&amp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; (psp-&gt;funcs-&gt;bootloader_load_sysdrv !=3D N=
ULL)) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ret =3D psp_bootloader_load_sysdrv(psp);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (ret) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;PSP load sysdrv failed!\n&quot;);=
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; }</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D psp_bootloader_load_sos(psp);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (ret) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;PSP load sos failed!\n&quot;);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; return ret;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if ((is_psp_fw_valid(psp-&gt;sos)) &amp;&amp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; (psp-&gt;funcs-&gt;bootloader_load_sos !=3D NULL=
)) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ret =3D psp_bootloader_load_sos(psp);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (ret) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;PSP load sos failed!\n&quot;);</p=
>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; }</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<=
/p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -2997,10 +3004,10 @@ int psp_init_toc_microcode(struct psp_context *psp,=
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; goto out;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; toc_hdr =3D (const struct psp_firmware_header_v1_0 *)adev-&gt;psp.toc_f=
w-&gt;data;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a=
dev-&gt;psp.toc_fw_version =3D le32_to_cpu(toc_hdr-&gt;header.ucode_version=
);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a=
dev-&gt;psp.toc_feature_version =3D le32_to_cpu(toc_hdr-&gt;sos.fw_version)=
;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a=
dev-&gt;psp.toc_bin_size =3D le32_to_cpu(toc_hdr-&gt;header.ucode_size_byte=
s);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a=
dev-&gt;psp.toc_start_addr =3D (uint8_t *)toc_hdr +</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&g=
t;psp.toc.fw_version =3D le32_to_cpu(toc_hdr-&gt;header.ucode_version);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&g=
t;psp.toc.feature_version =3D le32_to_cpu(toc_hdr-&gt;sos.fw_version);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&g=
t;psp.toc.size_bytes =3D le32_to_cpu(toc_hdr-&gt;header.ucode_size_bytes);<=
/p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&g=
t;psp.toc.start_addr =3D (uint8_t *)toc_hdr +</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(toc_hdr-&gt;header.ucode_array_offset=
_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
turn 0;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
out:</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -3021,32 +3028,32 @@ static int psp_init_sos_base_fw(struct amdgpu_devic=
e *adev)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; le32_to_cpu(sos_hdr-&gt;header.ucode_array_offset_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;gmc.xgmi.connected_to_cpu || (adev-&gt;asic_type !=3D CHIP=
_ALDEBARAN)) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;psp.sos_fw_version =3D le32_to_cpu(sos_hdr-&gt;header.ucod=
e_version);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;psp.sos_feature_version =3D le32_to_cpu(sos_hdr-&gt;sos.fw=
_version);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;psp.sos.fw_version =3D le32_to_cpu(sos_hdr-&gt;header.ucod=
e_version);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;psp.sos.feature_version =3D le32_to_cpu(sos_hdr-&gt;sos.fw=
_version);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;psp.sys_bin_size =3D le32_to_cpu(sos_hdr-&gt;sos.offset_by=
tes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;psp.sys_start_addr =3D ucode_array_start_addr;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;psp.sys.size_bytes =3D le32_to_cpu(sos_hdr-&gt;sos.offset_=
bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;psp.sys.start_addr =3D ucode_array_start_addr;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;psp.sos_bin_size =3D le32_to_cpu(sos_hdr-&gt;sos.size_byte=
s);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;psp.sos_start_addr =3D ucode_array_start_addr +</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;psp.sos.size_bytes =3D le32_to_cpu(sos_hdr-&gt;sos.size_by=
tes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;psp.sos.start_addr =3D ucode_array_start_addr +</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(sos_hdr-&gt;sos.offset_byt=
es);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } =
else {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; /* Load alternate PSP SOS FW */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; sos_hdr_v1_3 =3D (const struct psp_firmware_header_v1_3 *)adev=
-&gt;psp.sos_fw-&gt;data;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;psp.sos_fw_version =3D le32_to_cpu(sos_hdr_v1_3-&gt;sos_au=
x.fw_version);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;psp.sos_feature_version =3D le32_to_cpu(sos_hdr_v1_3-&gt;s=
os_aux.fw_version);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;psp.sos.fw_version =3D le32_to_cpu(sos_hdr_v1_3-&gt;sos_au=
x.fw_version);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;psp.sos.feature_version =3D le32_to_cpu(sos_hdr_v1_3-&gt;s=
os_aux.fw_version);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;psp.sys_bin_size =3D le32_to_cpu(sos_hdr_v1_3-&gt;sys_drv_=
aux.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;psp.sys_start_addr =3D ucode_array_start_addr +</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;psp.sys.size_bytes =3D le32_to_cpu(sos_hdr_v1_3-&gt;sys_dr=
v_aux.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;psp.sys.start_addr =3D ucode_array_start_addr +</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; le32_to_cpu(sos_hdr_v1_3-&gt;sys_drv_aux.offset_bytes);</p=
>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;psp.sos_bin_size =3D le32_to_cpu(sos_hdr_v1_3-&gt;sos_aux.=
size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;psp.sos_start_addr =3D ucode_array_start_addr +</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;psp.sos.size_bytes =3D le32_to_cpu(sos_hdr_v1_3-&gt;sos_au=
x.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;psp.sos.start_addr =3D ucode_array_start_addr +</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; le32_to_cpu(sos_hdr_v1_3-&gt;sos_aux.offset_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<=
/p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
f ((adev-&gt;psp.sys_bin_size =3D=3D 0) || (adev-&gt;psp.sos_bin_size =3D=
=3D 0)) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((ad=
ev-&gt;psp.sys.size_bytes =3D=3D 0) || (adev-&gt;psp.sos.size_bytes =3D=3D =
0)) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;PSP SOS FW not available&quot;);<=
/p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; return -EINVAL;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<=
/p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -3093,32 +3100,32 @@ int psp_init_sos_microcode(struct psp_context *psp,=
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; if (sos_hdr-&gt;header.header_version_minor =3D=3D 1) {<=
/p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sos_hdr_v1_1 =3D (const struct psp_firmware_header_v1=
_1 *)adev-&gt;psp.sos_fw-&gt;data;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.toc_bin_size =3D le32_to_cpu(sos_hdr_v1=
_1-&gt;toc.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.toc_start_addr =3D (uint8_t *)adev-&gt;=
psp.sys_start_addr +</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; adev-&gt;psp.toc.size_bytes =3D le32_to_cpu(sos_hdr_v1_1-&=
gt;toc.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; adev-&gt;psp.toc.start_addr =3D (uint8_t *)adev-&gt;psp.sy=
s.start_addr +</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(sos_hdr_v1_1-&gt;toc.o=
ffset_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.kdb_bin_size =3D le32_to_cpu(sos_hdr_v1=
_1-&gt;kdb.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.kdb_start_addr =3D (uint8_t *)adev-&gt;=
psp.sys_start_addr +</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; adev-&gt;psp.kdb.size_bytes =3D le32_to_cpu(sos_hdr_v1_1-&=
gt;kdb.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; adev-&gt;psp.kdb.start_addr =3D (uint8_t *)adev-&gt;psp.sy=
s.start_addr +</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(sos_hdr_v1_1-&gt;kdb.o=
ffset_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (sos_hdr-&gt;header.header_version_minor =3D=3D 2) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sos_hdr_v1_2 =3D (const struct psp_firmware_header_v1=
_2 *)adev-&gt;psp.sos_fw-&gt;data;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.kdb_bin_size =3D le32_to_cpu(sos_hdr_v1=
_2-&gt;kdb.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.kdb_start_addr =3D (uint8_t *)adev-&gt;=
psp.sys_start_addr +</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; adev-&gt;psp.kdb.size_bytes =3D le32_to_cpu(sos_hdr_v1_2-&=
gt;kdb.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; adev-&gt;psp.kdb.start_addr =3D (uint8_t *)adev-&gt;psp.sy=
s.start_addr +</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&n=
bsp;le32_to_cpu(sos_hdr_v1_2-&gt;kdb.offset_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (sos_hdr-&gt;header.header_version_minor =3D=3D 3) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sos_hdr_v1_3 =3D (const struct psp_firmware_header_v1=
_3 *)adev-&gt;psp.sos_fw-&gt;data;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.toc_bin_size =3D le32_to_cpu(sos_hdr_v1=
_3-&gt;v1_1.toc.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.toc_start_addr =3D ucode_array_start_ad=
dr +</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; adev-&gt;psp.toc.size_bytes =3D le32_to_cpu(sos_hdr_v1_3-&=
gt;v1_1.toc.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; adev-&gt;psp.toc.start_addr =3D ucode_array_start_addr +</=
p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(sos_hdr_v1_3-&gt;v1_1.toc.offset_byte=
s);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.kdb_bin_size =3D le32_to_cpu(sos_hdr_v1=
_3-&gt;v1_1.kdb.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.kdb_start_addr =3D ucode_array_start_ad=
dr +</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; adev-&gt;psp.kdb.size_bytes =3D le32_to_cpu(sos_hdr_v1_3-&=
gt;v1_1.kdb.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; adev-&gt;psp.kdb.start_addr =3D ucode_array_start_addr +</=
p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(sos_hdr_v1_3-&gt;v1_1.kdb.offset_byte=
s);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.spl_bin_size =3D le32_to_cpu(sos_hdr_v1=
_3-&gt;spl.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.spl_start_addr =3D ucode_array_start_ad=
dr +</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; adev-&gt;psp.spl.size_bytes =3D le32_to_cpu(sos_hdr_v1_3-&=
gt;spl.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; adev-&gt;psp.spl.start_addr =3D ucode_array_start_addr +</=
p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(sos_hdr_v1_3-&gt;spl.offset_bytes);</=
p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.rl_bin_size =3D le32_to_cpu(sos_hdr_v1_=
3-&gt;rl.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.rl_start_addr =3D ucode_array_start_add=
r +</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; adev-&gt;psp.rl.size_bytes =3D le32_to_cpu(sos_hdr_v1_3-&g=
t;rl.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; adev-&gt;psp.rl.start_addr =3D ucode_array_start_addr +</p=
>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(sos_hdr_v1_3-&gt;rl.offset_bytes);</p=
>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; break;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -3345,7 +3352,10 @@ static DEVICE_ATTR(usbc_pd_fw, S_IRUGO | S_IWUSR,</p=
>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;psp_usbc_pd_fw_sysfs_read,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;psp_usbc_pd_fw_sysfs_write);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+int is_psp_fw_valid(struct psp_bin_desc bin)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+{</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
bin.size_bytes;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+}</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;const struct amd_ip_funcs psp_ip_funcs =3D {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .n=
ame =3D &quot;psp&quot;,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
index f5b967b18e3f..fbbb1abf639f 100644</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -48,6 +48,7 @@</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
struct psp_context;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
struct psp_xgmi_node_info;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
struct psp_xgmi_topology_info;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+struct psp_bin_desc;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;enum psp_bootloader_cmd {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PS=
P_BL__LOAD_SYSDRV&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x10000,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -283,6 +284,13 @@ struct psp_runtime_boot_cfg_entry {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ui=
nt32_t reserved;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
};</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+struct psp_bin_desc {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_=
t fw_version;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_=
t feature_version;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_=
t size_bytes;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t=
 *start_addr;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+};</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
struct psp_context</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
{</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; st=
ruct amdgpu_device&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; *adev;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -298,20 +306,12 @@ struct psp_context</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* sos firmware */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; co=
nst struct firmware&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *sos_fw;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; sos_fw_version;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; sos_feature_version;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; sys_bin_size;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; sos_bin_size;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; toc_bin_size;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; kdb_bin_size;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; spl_bin_size;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; rl_bin_size;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *sys_start_addr;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *sos_start_addr;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *toc_start_addr;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *kdb_start_addr;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *spl_start_addr;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *rl_start_addr;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
psp_bin_desc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sy=
s;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
psp_bin_desc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; so=
s;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
psp_bin_desc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to=
c;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
psp_bin_desc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kd=
b;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
psp_bin_desc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sp=
l;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
psp_bin_desc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rl=
;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* tmr buffer */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; st=
ruct amdgpu_bo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; *tmr_bo;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -326,8 +326,6 @@ struct psp_context</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* toc firmware */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; co=
nst struct firmware&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *toc_fw;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; toc_fw_version;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; toc_feature_version;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* fence buffer */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; st=
ruct amdgpu_bo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; *fence_buf_bo;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -482,4 +480,6 @@ int psp_get_fw_attestation_records_addr(struct psp_cont=
ext *psp,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;int psp_load_fw_list(struct psp_context *psp,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;struct amdgpu_firmware_info **uc=
ode_list, int ucode_count);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+int is_psp_fw_valid(struct psp_bin_desc bin);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
#endif</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
index fe601f67d3a7..8e9b1f9fa34f 100644</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -518,7 +518,7 @@ FW_VERSION_ATTR(rlc_srlg_fw_version, 0444, gfx.rlc_srlg=
_fw_version);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
FW_VERSION_ATTR(rlc_srls_fw_version, 0444, gfx.rlc_srls_fw_version);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
FW_VERSION_ATTR(mec_fw_version, 0444, gfx.mec_fw_version);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
FW_VERSION_ATTR(mec2_fw_version, 0444, gfx.mec2_fw_version);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-FW_VERSION_ATTR(sos_fw_version, 0444, psp.sos_fw_version);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+FW_VERSION_ATTR(sos_fw_version, 0444, psp.sos.fw_version);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
FW_VERSION_ATTR(asd_fw_version, 0444, psp.asd_fw_version);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
FW_VERSION_ATTR(ta_ras_fw_version, 0444, psp.ta_ras_ucode_version);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
FW_VERSION_ATTR(ta_xgmi_fw_version, 0444, psp.ta_xgmi_ucode_version);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
index b71dd1deeb2d..12a7cc2f01cd 100644</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -531,7 +531,7 @@ static void amdgpu_virt_populate_vf2pf_ucode_info(struc=
t amdgpu_device *adev)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PO=
PULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_RLC_SRLS, adev-&gt;gfx.rlc=
_srls_fw_version);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PO=
PULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC,&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; adev-&gt;gfx.mec_fw_version);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PO=
PULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC2,&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gfx.mec2_fw_version);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; P=
OPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SOS,&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; adev-&gt;psp.sos_fw_version);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; POPULAT=
E_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SOS,&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;psp.sos.fw_version);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PO=
PULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_ASD,&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; adev-&gt;psp.asd_fw_version);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PO=
PULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_TA_RAS,&nbsp;&nbsp; adev-&=
gt;psp.ta_ras_ucode_version);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PO=
PULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_TA_XGMI,&nbsp; adev-&gt;ps=
p.ta_xgmi_ucode_version);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
index 38738ca56786..479a57eaba8e 100644</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -5401,7 +5401,7 @@ static int gfx_v10_0_parse_rlc_toc(struct amdgpu_devi=
ce *adev)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in=
t ret;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RL=
C_TABLE_OF_CONTENT *rlc_toc;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r=
et =3D amdgpu_bo_create_reserved(adev, adev-&gt;psp.toc_bin_size, PAGE_SIZE=
,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D=
 amdgpu_bo_create_reserved(adev, adev-&gt;psp.toc.size_bytes, PAGE_SIZE,</p=
>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_GTT,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;gfx.rlc.rlc_toc=
_bo,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;gfx.rlc.rlc_toc=
_gpu_addr,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -5412,7 +5412,7 @@ static int gfx_v10_0_parse_rlc_toc(struct amdgpu_devi=
ce *adev)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<=
/p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Copy toc from psp sos fw to rlc toc buffer */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m=
emcpy(adev-&gt;gfx.rlc.rlc_toc_buf, adev-&gt;psp.toc_start_addr, adev-&gt;p=
sp.toc_bin_size);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(=
adev-&gt;gfx.rlc.rlc_toc_buf, adev-&gt;psp.toc.start_addr, adev-&gt;psp.toc=
.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rlc_toc =3D (RLC_TABLE_OF_CONTENT *)adev-&gt;gfx.rlc.rlc_toc_buf;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wh=
ile (rlc_toc &amp;&amp; (rlc_toc-&gt;id &gt; FIRMWARE_ID_INVALID) &amp;&amp=
;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v11_0.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
index 21b8b6d48d8f..3eb14f7e3322 100644</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -288,7 +288,7 @@ static int psp_v11_0_bootloader_load_kdb(struct psp_con=
text *psp)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; me=
mset(psp-&gt;fw_pri_buf, 0, PSP_1_MEG);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Copy PSP KDB binary to memory */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m=
emcpy(psp-&gt;fw_pri_buf, psp-&gt;kdb_start_addr, psp-&gt;kdb_bin_size);</p=
>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(=
psp-&gt;fw_pri_buf, psp-&gt;kdb.start_addr, psp-&gt;kdb.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Provide the PSP KDB to bootloader */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WR=
EG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -321,7 +321,7 @@ static int psp_v11_0_bootloader_load_spl(struct psp_con=
text *psp)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; me=
mset(psp-&gt;fw_pri_buf, 0, PSP_1_MEG);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Copy PSP SPL binary to memory */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m=
emcpy(psp-&gt;fw_pri_buf, psp-&gt;spl_start_addr, psp-&gt;spl_bin_size);</p=
>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(=
psp-&gt;fw_pri_buf, psp-&gt;spl.start_addr, psp-&gt;spl.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Provide the PSP SPL to bootloader */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WR=
EG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -354,7 +354,7 @@ static int psp_v11_0_bootloader_load_sysdrv(struct psp_=
context *psp)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; me=
mset(psp-&gt;fw_pri_buf, 0, PSP_1_MEG);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Copy PSP System Driver binary to memory */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m=
emcpy(psp-&gt;fw_pri_buf, psp-&gt;sys_start_addr, psp-&gt;sys_bin_size);</p=
>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(=
psp-&gt;fw_pri_buf, psp-&gt;sys.start_addr, psp-&gt;sys.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Provide the sys driver to bootloader */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WR=
EG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -390,7 +390,7 @@ static int psp_v11_0_bootloader_load_sos(struct psp_con=
text *psp)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; me=
mset(psp-&gt;fw_pri_buf, 0, PSP_1_MEG);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Copy Secure OS binary to PSP memory */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m=
emcpy(psp-&gt;fw_pri_buf, psp-&gt;sos_start_addr, psp-&gt;sos_bin_size);</p=
>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(=
psp-&gt;fw_pri_buf, psp-&gt;sos.start_addr, psp-&gt;sos.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Provide the PSP secure OS to bootloader */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WR=
EG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v12_0.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
index b0ee77ee80b9..32413c059bee 100644</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -140,7 +140,7 @@ static int psp_v12_0_bootloader_load_sysdrv(struct psp_=
context *psp)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; me=
mset(psp-&gt;fw_pri_buf, 0, PSP_1_MEG);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Copy PSP System Driver binary to memory */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m=
emcpy(psp-&gt;fw_pri_buf, psp-&gt;sys_start_addr, psp-&gt;sys_bin_size);</p=
>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(=
psp-&gt;fw_pri_buf, psp-&gt;sys.start_addr, psp-&gt;sys.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Provide the sys driver to bootloader */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WR=
EG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -181,7 +181,7 @@ static int psp_v12_0_bootloader_load_sos(struct psp_con=
text *psp)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; me=
mset(psp-&gt;fw_pri_buf, 0, PSP_1_MEG);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Copy Secure OS binary to PSP memory */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m=
emcpy(psp-&gt;fw_pri_buf, psp-&gt;sos_start_addr, psp-&gt;sos_bin_size);</p=
>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(=
psp-&gt;fw_pri_buf, psp-&gt;sos.start_addr, psp-&gt;sos.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Provide the PSP secure OS to bootloader */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WR=
EG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
index e1046bb3bab0..d017da3ceadb 100644</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -136,7 +136,7 @@ static int psp_v13_0_bootloader_load_kdb(struct psp_con=
text *psp)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; me=
mset(psp-&gt;fw_pri_buf, 0, PSP_1_MEG);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Copy PSP KDB binary to memory */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m=
emcpy(psp-&gt;fw_pri_buf, psp-&gt;kdb_start_addr, psp-&gt;kdb_bin_size);</p=
>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(=
psp-&gt;fw_pri_buf, psp-&gt;kdb.start_addr, psp-&gt;kdb.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Provide the PSP KDB to bootloader */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WR=
EG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -169,7 +169,7 @@ static int psp_v13_0_bootloader_load_sysdrv(struct psp_=
context *psp)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; me=
mset(psp-&gt;fw_pri_buf, 0, PSP_1_MEG);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Copy PSP System Driver binary to memory */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m=
emcpy(psp-&gt;fw_pri_buf, psp-&gt;sys_start_addr, psp-&gt;sys_bin_size);</p=
>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(=
psp-&gt;fw_pri_buf, psp-&gt;sys.start_addr, psp-&gt;sys.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Provide the sys driver to bootloader */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WR=
EG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -205,7 +205,7 @@ static int psp_v13_0_bootloader_load_sos(struct psp_con=
text *psp)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; me=
mset(psp-&gt;fw_pri_buf, 0, PSP_1_MEG);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Copy Secure OS binary to PSP memory */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m=
emcpy(psp-&gt;fw_pri_buf, psp-&gt;sos_start_addr, psp-&gt;sos_bin_size);</p=
>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(=
psp-&gt;fw_pri_buf, psp-&gt;sos.start_addr, psp-&gt;sos.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Provide the PSP secure OS to bootloader */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WR=
EG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/am=
dgpu/psp_v3_1.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
index be05d9cbd41e..29aac7b793f4 100644</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -105,7 +105,7 @@ static int psp_v3_1_bootloader_load_sysdrv(struct psp_c=
ontext *psp)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; me=
mset(psp-&gt;fw_pri_buf, 0, PSP_1_MEG);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Copy PSP System Driver binary to memory */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m=
emcpy(psp-&gt;fw_pri_buf, psp-&gt;sys_start_addr, psp-&gt;sys_bin_size);</p=
>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(=
psp-&gt;fw_pri_buf, psp-&gt;sys.start_addr, psp-&gt;sys.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Provide the sys driver to bootloader */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WR=
EG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -146,7 +146,7 @@ static int psp_v3_1_bootloader_load_sos(struct psp_cont=
ext *psp)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; me=
mset(psp-&gt;fw_pri_buf, 0, PSP_1_MEG);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Copy Secure OS binary to PSP memory */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m=
emcpy(psp-&gt;fw_pri_buf, psp-&gt;sos_start_addr, psp-&gt;sos_bin_size);</p=
>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(=
psp-&gt;fw_pri_buf, psp-&gt;sos.start_addr, psp-&gt;sos.size_bytes);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Provide the PSP secure OS to bootloader */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WR=
EG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
index b7d350be8050..a5e085e570f7 100644</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -575,7 +575,7 @@ soc15_asic_reset_method(struct amdgpu_device *adev)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; baco_reset =3D amdgpu_dpm_is_baco_supported(adev);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; break;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ca=
se CHIP_VEGA20:</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (adev-&gt;psp.sos_fw_version &gt;=3D 0x80067)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (adev-&gt;psp.sos.fw_version &gt;=3D 0x80067)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; baco_reset =3D amdgpu_dpm_is_baco_supported(adev);</p=
>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; /*</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
@@ -635,7 +635,7 @@ static bool soc15_supports_baco(struct amdgpu_device *a=
dev)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ca=
se CHIP_ARCTURUS:</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; return amdgpu_dpm_is_baco_supported(adev);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ca=
se CHIP_VEGA20:</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (adev-&gt;psp.sos_fw_version &gt;=3D 0x80067)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (adev-&gt;psp.sos.fw_version &gt;=3D 0x80067)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return amdgpu_dpm_is_baco_supported(adev);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; return false;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; de=
fault:</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
-- </p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
2.17.1</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
<span style=3D"color: rgb(68, 84, 106);">Thanks,</span></p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
<span style=3D"color: rgb(68, 84, 106);">Candice</span></p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: &quot;Calibri&quot;, sans-serif;">
&nbsp;</p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB5226E5AC96FB5A73C174CDBDFBE39BN9PR12MB5226namp_--

--===============2079931086==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2079931086==--
