Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5F1C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Dec 2021 02:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28A2310E117;
	Tue, 28 Dec 2021 02:44:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D09AB10E117
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Dec 2021 02:44:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqPgewk5CgkYAMpGhVhy/PyZ4DlxCWAdoGj15gU52wHi5CaD2HZE6Ob9oE9W8ui0R0Kda6kyy4rEx9eYBPV5y0zUl2mfa42DGk7iUES8TVzGU222T0u3yax10HBLlMx2beROck8zYlq2aUdtHfzgRTyJ1VnJojRFPWIxTsukMWBZh3jLtg6GRh3a4CRxWsQz5uK1cjkMQrVQ/ALH6rY17iGRVJ3EZPy9i+cGW/XwJfXQcQKNGP++4jiSkVeo52/n8KxrzdQABKNyQo0Z1X/ybxUlCbJoaamjJ0ez4eDIJ/098uPMPBgD+ae3VB6GOpbXFMWlskqJismcF6Zyu8cwvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fE16cjM5aiHAaf+WE2gMzu+HbVWaoSX3a5456xh9L1M=;
 b=baEaOvqJyiJWqFge8dESWDGBavolYfYAnFEdxonTwQCeHk5oJLIDpzsaiyETKhPxxxjps8DHDEhHsFi6U/znjeiwKQRfv5N8ifm4Rrj/3tpe7ZL2+IPyCUvvfEPeDSXZrUyRqR8+9qsDknuopr3QLigYGA5hWidZjRSdo3RLMov1pvu7JjXRoE31JUE0wIWfe/DJQ1ij/OzEE+CyrFYBwm4Yl00NIT+ACQlSbskaEOQQ5zjEQSfRl18VM+XQs33EIPG4MfYPw4LvOpzkomhE0MTrnptLBVmiR6Cfu2d73ANc+v2ixrK0nMP0z36/UdQvYaxiAhPZ/7JXqLCa2w57xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fE16cjM5aiHAaf+WE2gMzu+HbVWaoSX3a5456xh9L1M=;
 b=dJp6CDL4Frmow7ez81qhCB6+qkavPh/pRSFXU9vWKYr3nyC69iXRCgtU8T4tlckfdMW8AhYRkVsJOoXS4/esAoQA+n8ftHe5UMwl35P8HBiodY9ZtIjDx0c3gFtg7GCaBzvIKfHp55y5NqEPHVzOTM7O1zpp4oAiQEIENvsRerQ=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4959.namprd12.prod.outlook.com (2603:10b6:5:208::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.19; Tue, 28 Dec 2021 02:43:35 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e%5]) with mapi id 15.20.4823.023; Tue, 28 Dec 2021
 02:43:35 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: no DC support for headless chips
Thread-Topic: [PATCH] drm/amdgpu: no DC support for headless chips
Thread-Index: AQHX+0TcU1RE1HlJAE2cusriE6lKqKxHMsVg
Date: Tue, 28 Dec 2021 02:43:35 +0000
Message-ID: <DM5PR12MB2469E6B52638F375CF44DEA3F1439@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211227171141.1503210-1-alexander.deucher@amd.com>
In-Reply-To: <20211227171141.1503210-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-28T02:43:26Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=83163d15-9aaa-4089-b0c8-c2207e901d2d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-28T02:43:30Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: c670e469-d30c-4e74-a97f-91def4374f8c
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b582f934-305f-4c6a-204f-08d9c9abd878
x-ms-traffictypediagnostic: DM6PR12MB4959:EE_
x-microsoft-antispam-prvs: <DM6PR12MB49592076D4912182D8CFE2ABF1439@DM6PR12MB4959.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:576;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bKNwNb6xOiq4ymG3alXnbmPiKCWHsqYD92fNGYWKWMKTLjXEsKYFUaD6ET/V6jUFPlRLfjMLbJcAzJdP+LU7eGhnL6u1uIZmkzaPPrbPTrpgaC/hsjM6E8GDFItf3H7hJV4zhKi2/7wC0ef6S8iDZ2UxvI+vcY4xZttdJL8M0Kj1HTOaaX1j1+8NRQ7tYnKk8pP46wWuWtxDRbKanD7IWQK5auYMOrg1b5B65qYWG7XHGIfIAd5ewMVFsgY3jU3pe1IFp3WxaLHtoNhhl1gFVRDC9nRIlnKoiOkvQudshwb/mYwfXH/nlUu8bne5iSKG9GDjTy7U0fOYCIKkOffLhEqcUu/pswHExhaE9IF/ENBSYdLN0pqhABX5CPl0k7gDGCuLwyxUqaWsVtWfwyZlCyUGGIyRz8jkazdVXdwjOJ+5M7xjvk1hqH5GQDevqItLpZ2CiTvcHrrEJL57daVdJuctJKC96trdSeJiEfjPqmutEirk7U859hdQtQy9DBep94SXcumzpj4r68ZUbpi9TxlmkVoIPDo2I3vYEvax4KrzDsHlAs1GHBAKYS3+xiQqKYRj8j7Q+vrXCMl4foE+g3SEpdrljxqcLmJ+itEu5PMGrR7MeNuiAmZNksYYuwbk3Oyj9OE2ymLiilh34BJRdEmC0Ony3vDqbpyE0J+juKs0NUEumBs27gGUus5oehDXRRCgiMQCAlRZ5LSXPRDkZA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(8936002)(53546011)(8676002)(38100700002)(122000001)(7696005)(52536014)(38070700005)(26005)(186003)(33656002)(66946007)(86362001)(66476007)(66556008)(76116006)(110136005)(71200400001)(54906003)(316002)(83380400001)(2906002)(4326008)(55016003)(508600001)(5660300002)(64756008)(9686003)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lc5wOupKbHFw674FsxOwyR3qEgeGl76hEEaPMX1YonbchGU53WYUVwMOYGkI?=
 =?us-ascii?Q?i2vHr2A4rglQePnaatBRXPg4kFxM4ymQ57Pf026St189qj1MLPYJSG81GA1M?=
 =?us-ascii?Q?0ZS6BprQqG3wrwOpC6Q4rsSNBiAtztKjuQ7io4xRbRxM406TZG4hFQXjGvOL?=
 =?us-ascii?Q?2M3Dq+I+vYugVAan6Uv46HMD3TGmDNPuwonfaiG6Z/KupGPuBkbBgoBuQPp6?=
 =?us-ascii?Q?+sd8VxJBQsPmGR4vYZ+E6Jo7qoFEm8JDiGXs6b0FZmxWZAx7WojecqECDpDM?=
 =?us-ascii?Q?5bXHiVlAuIeuzQpD7o5Ff+RDJcvIaO6aC7+cZulBvHqkYfupC/sKDflVkEaU?=
 =?us-ascii?Q?zkNJLxVHWyFastfTKwXfet7Olkqngb75ZFjOw6oX3S2w36CUfv8mXKBY64Xs?=
 =?us-ascii?Q?XmPA416NAYr88tCvqQQe1mkxXoi2vMUw17RQOZLCYg9Jgdtr/u6HYH52+/Vf?=
 =?us-ascii?Q?oYzK75g9ugIIISi6/mPb7jh27q5OYf1F3kqm/NR45v/HSIfBSv50rWmMssQs?=
 =?us-ascii?Q?nV3MJbcwUoejiPZzt82Y/oyDkwyP9vaLScXZQPrYDcYGINlqnDQ8VIRXB3KE?=
 =?us-ascii?Q?p0oAEvDOfnAxEfctWSFb/9kzIp0yYnHoL8yvKXNG7RKHaNKRThhmj6sGwcwB?=
 =?us-ascii?Q?mzkDLbxQ5s913JbMzxtoBkzBwLl8FSFdyGRx5+JoSU7Mg3CA8QY1OghOC492?=
 =?us-ascii?Q?AueHl1J8v77sS9czCWD2pCQX7prpbF8Kf10Mhek302ZzoK39dHyIckQjnihl?=
 =?us-ascii?Q?PAcm/nTcjfvdiCtJjLhDPVUAnisOVdgagbJgvJ7lw0XIPPlEt5UDjXZCN+bS?=
 =?us-ascii?Q?s+oF1pUgaom9wv0b/ZZSfOufFa1MCe7sVx7IKkE01o6rlKs3AItCeUTXSVe7?=
 =?us-ascii?Q?20Z7t6fuLcka+RS5YvNJzxQNrYn8dpBflbXTh1SnYvHtHemMc9C/GdqQqx5r?=
 =?us-ascii?Q?L3yywN0znTwEkUgufzRatHHFgdKqJYWi4/2lnzNwxC2eZ1vS3Svgfmp3iL6V?=
 =?us-ascii?Q?Zyu/hu6w2NGz12hyz91FNMmhN+6lxRZ/M5xlT92kdntFarn+wd9mGzD8nPDN?=
 =?us-ascii?Q?td8rJmTwm0v3Xufj9qXTamr20Yo3KO3TGpvFGnqsYinfayqfdMKQWYBp9fs4?=
 =?us-ascii?Q?nRo085+xk5sdKD7xXI1XFOOk6/nmoOaP/TLR4d62DSkz+v7XtsKI+rev9oAa?=
 =?us-ascii?Q?x8+ckfL5Wi4AXbZfXme8BydweS0Lozq1Khbou2SX2LNsgS7T4VEWS4MzfI7w?=
 =?us-ascii?Q?SUeNW1A1KqLzPYpSC6o/jBiaepkaN/6JxLMffytUE0EWWHUAndNzEvetsD9I?=
 =?us-ascii?Q?wDkNuplPgYzklknTF3YFc1MzBIaLznM/IhtrL9LzSaHdvwxtujZtR2r0Dhkp?=
 =?us-ascii?Q?AEXIrOM36VrjRbvzHXlpwzFnW3+8ZKsv7fKMMureq2ld+rULpZur9oemwT2e?=
 =?us-ascii?Q?2gqUCqz2ilkWE9cUiCXjakZNVHtF0YWV+SOGbop453i2vgBDrea9f9Z3XYFG?=
 =?us-ascii?Q?YjaBQIIygnIygMRVkXIzZHdO/Saiu19eFfOh7c8ccTETvOsNyrGwMXX3F79O?=
 =?us-ascii?Q?W2cRZ1Ku3RmgT8DaMni9nredvVXG58JAZCYwISni5wU8YQb7H9nCNQJN5wTY?=
 =?us-ascii?Q?OKBV/oq3wphH+a7FInytZEw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b582f934-305f-4c6a-204f-08d9c9abd878
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2021 02:43:35.6884 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MSxIT7NXbxRxY5Ub+vNevWn84CZylwlFoqx/QzCoTim7q436vdOyT4qpPXvXIM+dARdGGGlMdcAQaRnVIv6sIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4959
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Tareque Md . Hanif" <tarequemd.hanif@yahoo.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, December 28, 2021 1:12 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Tareque Md . Hanif <tar=
equemd.hanif@yahoo.com>
Subject: [PATCH] drm/amdgpu: no DC support for headless chips

Chips with no display hardware should return false for DC support.

v2: drop Arcturus and Aldebaran

Fixes: f7f12b25823c0d ("drm/amdgpu: default to true in amdgpu_device_asic_h=
as_dc_support")
Reported-by: Tareque Md.Hanif <tarequemd.hanif@yahoo.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 9dc86c5a1cad..694c3726e0f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3166,6 +3166,12 @@ static void amdgpu_device_detect_sriov_bios(struct a=
mdgpu_device *adev)  bool amdgpu_device_asic_has_dc_support(enum amd_asic_t=
ype asic_type)  {
 	switch (asic_type) {
+#ifdef CONFIG_DRM_AMDGPU_SI
+	case CHIP_HAINAN:
+#endif
+	case CHIP_TOPAZ:
+		/* chips with no display hardware */
+		return false;
 #if defined(CONFIG_DRM_AMD_DC)
 	case CHIP_TAHITI:
 	case CHIP_PITCAIRN:
--
2.33.1
