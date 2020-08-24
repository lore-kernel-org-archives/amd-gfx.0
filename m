Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B07C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 14:40:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C79302071E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 14:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vr9zJnUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79302071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CCA96E286;
	Mon, 24 Aug 2020 14:40:16 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690044.outbound.protection.outlook.com [40.107.69.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01CEA6E041
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 14:40:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCuYuQIt8SeD1y0mC1MqhZQNND1CeWsIau8v3rWqR1V6qNp4/vBPgqXTy6krwRdZAz0G5Uie5ykZSx1E8rtpOMwndkyHsy70qce+Km1bLDVE8aqnz96s9Bt2KiwwqhPEbN5JVBn4N141Gbfp5LvQOpC1PbcEzMc6T9spJFqKfaguLY6BnUvccPuiYJq3e1NbJebav4ptgKvsQIEr7/aBdiyl8StdRfvXmLuiw6VNWK0ZWA9aml8Io8YTGLA4FeKbKyn+akpkHkdYXxDfHu6Be6crIvDou0V3zHF8+tcawlYT31cec/ObvVU/NQdg+xC1jA2qmCalG9aomJhoPTF5gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ewui+YuA26aaoRF53a0dmMFwBO2uH/6LYn+6BEeHwo=;
 b=CEbHKUy1xk0hn+XW5R+eO4IlYWpN1IRwjueXXnwrTYxfChnu5+Gf9MAJ5ezuUPGwXlCSDVg2vJqZCgXqyQpsRUIPu6dXbWQe4359GFnc+7lstzmjdJK2/Czic058kejEPQGsHWX27RDuX6YljkHFbdrZ8GlhlHr68fPI7jKA3hrqIQ3FTVH6Yn2UxAC3B2y14wDEHHCoXgeMrPXw8Gl/GPI0tK4YgnIcvWFWFwCSeBr3e8s/UATPtiQqZKOnzEgEAVcreeMWoxt8Z1nJ8zXmLHhOcNIYkD3vu5xv0a5AQpi5BhoQG+rLNJa3TMM8mglxUOjiWlkwGH/5I+Q1tJrYCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ewui+YuA26aaoRF53a0dmMFwBO2uH/6LYn+6BEeHwo=;
 b=vr9zJnUz+/Ksy/QGjtv+BvkOMuLE8Ld7BNynEu/PKeZ3N7it+Mj1oa5tmrBZYxQqIVYD1vixu/7RRSKsBNzkE9u/syttnP6pAt8pLqoqrPtC1sy0uXLN8ZH0N1+wtRw8x0ZtSC8iPCe+ui6jqiEQbFd8kgFzM8h9yohu+1plHWQ=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Mon, 24 Aug
 2020 14:40:12 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 14:40:12 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdkfd: call amdgpu_amdkfd_get_unique_id directly
Thread-Topic: [PATCH 1/2] drm/amdkfd: call amdgpu_amdkfd_get_unique_id directly
Thread-Index: AQHWeiHmD818KyC3JEmz/m5sLElXB6lHVJvv
Date: Mon, 24 Aug 2020 14:40:12 +0000
Message-ID: <MN2PR12MB4488BDB1836F9836C1AFAA6BF7560@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200824142117.23684-1-Felix.Kuehling@amd.com>
In-Reply-To: <20200824142117.23684-1-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-24T14:40:11.880Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b72d8281-5780-4780-1791-08d8483b9bbe
x-ms-traffictypediagnostic: MN2PR12MB4469:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4469481EC8FE06A012FD6D89F7560@MN2PR12MB4469.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jvY4dBOeRjSlAd0yVpnwLItEdZyV9uGONzOHyZ3Jgp+J/a8gpEzANNgj0KQE9HCck6A0cMYoP/vJKUxDqVvF69yN0jGGNpEb+4Pzt8yzpqOAnvLI+khhet8g6vlTWBDGuGOLX9KraZPNS6HOfMN4gYXijG2gZJhNcoqy8uIitwCq+aHo1L0m4xZV19iSM898+nvKlFhKpOwuLs3LutgIwbyNGkyHveGolReyWXCWnYRlfl4VpIMwt7QqTwx+Z7vgYlxJ74jO6YbG86Y9RDd75xhvot/sPtfKlNdKbWkmcQI9J6Cls4jeOPnYwREJ/V0TMvRxpiLotOJHceEniqphVuzH2XZoHxuNUa7qo/LBLsQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(4326008)(45080400002)(52536014)(110136005)(316002)(33656002)(66946007)(66556008)(86362001)(186003)(64756008)(54906003)(66446008)(53546011)(5660300002)(66476007)(7696005)(76116006)(26005)(8936002)(478600001)(966005)(9686003)(2906002)(83380400001)(166002)(8676002)(55016002)(71200400001)(19627405001)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 2zJL3aNHNJdeAbCkh/uyxGYkuBG8N6/Byjr5M4DnbmyzgaA/kuwYkQu91LxKdAyenHVleqMjCxuFTdcYacYFE0boRA/kcGjiXHLjJv3+bFyEh3q9x5x57go6qUHWT3xINsuAaIElPPGOrn9v3TAmPcMOMzOKMR+R0ir/ZAEHxnL4fshViuNdipCvb2p9LkHfBZTY1mALEj9vUBZMuVXsw4KlPrIyhg5FNskYNdG/r602tOVPuwBtREtOMdXUQN+xczFEZMlVrq2jvaId4/klXPeHkw7xZI55r480ZjIDKT9WiR0Yve+7/LgwiZBXWPw+ASFNC45q3F/957OcESsiiJJgrJo8KtUtUouk98ZwswXyiu7IOxOfjqHYUf9gF+PRksOChR0y83bPtPGfHofpVPq+r93lLOe9kUIlapoatTrkbjeJZfoy1zTicYDYc6SER3FqHijUgz668fTpl8T2PBD2aN1GJIppWN5/BnW+NPmb2vV95I9U7iIpd8X3wUBomj0477/X0PoU3hVWnuIcMXX8N74o+W0bUXi1eOb9NMUF/NyizihQyzDUPYAAk+kvrcEExhiRBwQyuzkvRGbfmicAUOmkXgfOttt+LIGq2eSkJaOd3ze3XLQpIAf9YYAlCnhw/HWzzE+65kq1Tl5gjQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b72d8281-5780-4780-1791-08d8483b9bbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2020 14:40:12.4399 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stL2FkiwFeXXGFkWKM78itpQbRYqA4u2JRWRF1IJI8WPqP9wn2zpWd8eo95uV1D0mSjv9ma1oG+vcZ+dMrpQLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469
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
Cc: "Lin, Amber" <Amber.Lin@amd.com>, "Shikre,
 Divya" <DivyaUday.Shikre@amd.com>
Content-Type: multipart/mixed; boundary="===============0932871740=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0932871740==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488BDB1836F9836C1AFAA6BF7560MN2PR12MB4488namp_"

--_000_MN2PR12MB4488BDB1836F9836C1AFAA6BF7560MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Felix Ku=
ehling <Felix.Kuehling@amd.com>
Sent: Monday, August 24, 2020 10:21 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Lin, Amber <Amber.Lin@amd.com>; Shikre, Divya <DivyaUday.Shikre@amd.com=
>
Subject: [PATCH 1/2] drm/amdkfd: call amdgpu_amdkfd_get_unique_id directly

No need to use a function pointer because the implementation is not
ASIC-specific. This fixes missing support due to a missing function
pointer on Arcturus.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  | 1 -
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            | 3 +--
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h    | 4 ----
 4 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index b872cdb0b705..cef2ed767299 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -778,5 +778,4 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd =3D {
                         get_atc_vmid_pasid_mapping_info,
         .set_vm_context_page_table_base =3D set_vm_context_page_table_base=
,
         .get_hive_id =3D amdgpu_amdkfd_get_hive_id,
-       .get_unique_id =3D amdgpu_amdkfd_get_unique_id,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 64fdb6a81c47..e5592548b588 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -729,5 +729,4 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd =3D {
                         kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
         .set_vm_context_page_table_base =3D kgd_gfx_v9_set_vm_context_page=
_table_base,
         .get_hive_id =3D amdgpu_amdkfd_get_hive_id,
-       .get_unique_id =3D amdgpu_amdkfd_get_unique_id,
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index b15b620e731b..5ffd03685722 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -715,8 +715,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
         if (kfd->kfd2kgd->get_hive_id)
                 kfd->hive_id =3D kfd->kfd2kgd->get_hive_id(kfd->kgd);

-       if (kfd->kfd2kgd->get_unique_id)
-               kfd->unique_id =3D kfd->kfd2kgd->get_unique_id(kfd->kgd);
+       kfd->unique_id =3D amdgpu_amdkfd_get_unique_id(kfd->kgd);

         if (kfd_interrupt_init(kfd)) {
                 dev_err(kfd_device, "Error initializing interrupts\n");
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/=
drm/amd/include/kgd_kfd_interface.h
index a3c238c39ef5..017f97394344 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -214,8 +214,6 @@ struct tile_config {
  *
  * @get_hive_id: Returns hive id of current  device,  0 if xgmi is not ena=
bled
  *
- * @get_unique_id: Returns uuid id of current  device
- *
  * This structure contains function pointers to services that the kgd driv=
er
  * provides to amdkfd driver.
  *
@@ -291,8 +289,6 @@ struct kfd2kgd_calls {
                         uint32_t vmid, uint64_t page_table_base);
         uint32_t (*read_vmid_from_vmfault_reg)(struct kgd_dev *kgd);
         uint64_t (*get_hive_id)(struct kgd_dev *kgd);
-       uint64_t (*get_unique_id)(struct kgd_dev *kgd);
-
 };

 #endif  /* KGD_KFD_INTERFACE_H_INCLUDED */
--
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7Cf72e48fa1b804fd1a9bc08d84839073a%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637338757068577923&amp;sdata=3DGVcMLE70p%2BNa%2BfG=
IVokWqYOMCa2R3LXEBfoM0DWVC38%3D&amp;reserved=3D0

--_000_MN2PR12MB4488BDB1836F9836C1AFAA6BF7560MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Felix Kuehling &lt;Felix.Kueh=
ling@amd.com&gt;<br>
<b>Sent:</b> Monday, August 24, 2020 10:21 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Lin, Amber &lt;Amber.Lin@amd.com&gt;; Shikre, Divya &lt;DivyaUda=
y.Shikre@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amdkfd: call amdgpu_amdkfd_get_unique_id di=
rectly</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">No need to use a function pointer because the impl=
ementation is not<br>
ASIC-specific. This fixes missing support due to a missing function<br>
pointer on Arcturus.<br>
<br>
Signed-off-by: Felix Kuehling &lt;Felix.Kuehling@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c&nbsp; | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_device.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 3 +--<br>
&nbsp;drivers/gpu/drm/amd/include/kgd_kfd_interface.h&nbsp;&nbsp;&nbsp; | 4=
 ----<br>
&nbsp;4 files changed, 1 insertion(+), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<br>
index b872cdb0b705..cef2ed767299 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<br>
@@ -778,5 +778,4 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_a=
tc_vmid_pasid_mapping_info,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_vm_context_page_table=
_base =3D set_vm_context_page_table_base,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_hive_id =3D amdgpu_am=
dkfd_get_hive_id,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_unique_id =3D amdgpu_amdkfd_get_=
unique_id,<br>
&nbsp;};<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
index 64fdb6a81c47..e5592548b588 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
@@ -729,5 +729,4 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kgd_g=
fx_v9_get_atc_vmid_pasid_mapping_info,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_vm_context_page_table=
_base =3D kgd_gfx_v9_set_vm_context_page_table_base,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_hive_id =3D amdgpu_am=
dkfd_get_hive_id,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_unique_id =3D amdgpu_amdkfd_get_=
unique_id,<br>
&nbsp;};<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c<br>
index b15b620e731b..5ffd03685722 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
@@ -715,8 +715,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kfd-&gt;kfd2kgd-&gt;ge=
t_hive_id)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfd-&gt;hive_id =3D kfd-&gt;kfd2kgd-&gt;get_hive_id(k=
fd-&gt;kgd);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kfd-&gt;kfd2kgd-&gt;get_unique_id=
)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kfd-&gt;unique_id =3D kfd-&gt;kfd2kgd-&gt;get_unique_id(kfd-&gt;=
kgd);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;unique_id =3D amdgpu_amdkfd_g=
et_unique_id(kfd-&gt;kgd);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kfd_interrupt_init(kfd=
)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(kfd_device, &quot;Error initializing interrup=
ts\n&quot;);<br>
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/=
drm/amd/include/kgd_kfd_interface.h<br>
index a3c238c39ef5..017f97394344 100644<br>
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h<br>
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h<br>
@@ -214,8 +214,6 @@ struct tile_config {<br>
&nbsp; *<br>
&nbsp; * @get_hive_id: Returns hive id of current&nbsp; device,&nbsp; 0 if =
xgmi is not enabled<br>
&nbsp; *<br>
- * @get_unique_id: Returns uuid id of current&nbsp; device<br>
- * <br>
&nbsp; * This structure contains function pointers to services that the kgd=
 driver<br>
&nbsp; * provides to amdkfd driver.<br>
&nbsp; *<br>
@@ -291,8 +289,6 @@ struct kfd2kgd_calls {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint3=
2_t vmid, uint64_t page_table_base);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t (*read_vmid_from_=
vmfault_reg)(struct kgd_dev *kgd);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t (*get_hive_id)(st=
ruct kgd_dev *kgd);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t (*get_unique_id)(struct kgd_=
dev *kgd);<br>
-<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;#endif&nbsp; /* KGD_KFD_INTERFACE_H_INCLUDED */<br>
-- <br>
2.28.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7Cf72e48fa1b804fd1a9bc08d84839073a%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637338757068577923&amp;amp;sdata=3D=
GVcMLE70p%2BNa%2BfGIVokWqYOMCa2R3LXEBfoM0DWVC38%3D&amp;amp;reserved=3D0">ht=
tps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.fre=
edesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexan=
der.deucher%40amd.com%7Cf72e48fa1b804fd1a9bc08d84839073a%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637338757068577923&amp;amp;sdata=3DGVcMLE70p%2BN=
a%2BfGIVokWqYOMCa2R3LXEBfoM0DWVC38%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488BDB1836F9836C1AFAA6BF7560MN2PR12MB4488namp_--

--===============0932871740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0932871740==--
