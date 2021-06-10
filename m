Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269D1C47094
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 07:28:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3DEB613F1
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 07:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DEB613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C93D89CBC;
	Thu, 10 Jun 2021 07:28:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF45689CBC
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 07:28:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUY39XCtC3hKAZfnC5Bva7vVYJQhDoUXRvx/Sx6S87fzhNHSdZ+T6nAjYzEz1j/fHzjy6uP89rSeyNxGb7wgQmTbjIlk0C7ffpJaPkxrytUSsEtsuOllL3UZe9e+UHmZbKOpJ3rnYRHsaKAFMVIqO5Z0DITFChd8FuPkivfel6W6yNp1Vfg/RZK4BMdZLtk/KK981g3y6x4etSspkXqTWb19+h1dhPJjv2AfyRC4I2DqzW5tf6rpDSB1Yloe0Zfe9Uv8kUrY3z1xmI3bUsTRveHtjY8wfVWH2W69anugMmN+ACWxIqfT+NoCAylbGdbWAzmeU/cJo9Fv8wgoewiebQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbBiGsjOZiNceNIDX290KlpSSveVAPaTEPM8HuiRyOo=;
 b=G1dQ2fIsiWLjlqcPIo5S9CxgzGWbpmP01RrB24Ze12rQj9es+0vwo3fVaUR7g/ALD4V/EwZD8IgHR8D76rp4EVWU7n3OHhEaubWVlYP2W13dTrxgf41Bbt1lMgXLfDG2nb0TwgUullLvBORuKrCTpq1Vrft309PqtDxJJJGtd9SaW70fJkEwp/2t9yLc/L+1OhlfRbXxgFiSdkbkmts2kdLpQ7kHaZrdUYrf5Iq9hidc/fBbpbS+XmFJnwJ9eP7aa23rXrKxwBHabE/Qz/9wUzietUjdqBg+AJexnu2igaZMs5w2NTJYYkTxJMgQLU0i28wqVINi9zeUlOuo5wU4FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbBiGsjOZiNceNIDX290KlpSSveVAPaTEPM8HuiRyOo=;
 b=Rsd5D43sGlFZ1kmLvU+ykCc3v+TyCXw6GYA9qpGRaqiDNjQSuR6KSbT0Z9AN7+ja0h43lUyQpdL59f7qg8THXsccPHpaUPbaIc9yIqfGi6oxactYz38ZJ3wuXVDnkFs/fZ+1+w4EZ1/h6WvpuAaVctJ0AoMrhz02CpEhPh8eCHQ=
Received: from DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22)
 by DM6PR12MB5519.namprd12.prod.outlook.com (2603:10b6:5:1b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Thu, 10 Jun
 2021 07:28:41 +0000
Received: from DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::9d6f:2218:2f3c:a383]) by DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::9d6f:2218:2f3c:a383%3]) with mapi id 15.20.4219.022; Thu, 10 Jun 2021
 07:28:41 +0000
From: "Chen, Horace" <Horace.Chen@amd.com>
To: "Wang, YuBiao" <YuBiao.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: reset psp ring wptr during ring_create
Thread-Topic: [PATCH] drm/amdgpu: reset psp ring wptr during ring_create
Thread-Index: AQHXXNvhN0K1NWw8V0qNMm/IzYxFY6sM2rKA
Date: Thu, 10 Jun 2021 07:28:41 +0000
Message-ID: <DM4PR12MB507207057E1BF5A20E53C6EEE1359@DM4PR12MB5072.namprd12.prod.outlook.com>
References: <20210609030145.1215878-1-YuBiao.Wang@amd.com>
In-Reply-To: <20210609030145.1215878-1-YuBiao.Wang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-10T07:28:37Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=e152133e-c718-47dd-ad2e-00009689150e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-06-10T07:28:37Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 49008e4c-ce4f-43fb-994b-0000c2ae0d39
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2a77f9e-3022-4130-c0ee-08d92be15f1a
x-ms-traffictypediagnostic: DM6PR12MB5519:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB55191B0AE38ABCAA025EFE67E1359@DM6PR12MB5519.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ga4ycHQMGqcIS1S+ZmdruVthU8tHa+No93Lf3iBKrG9/yojx4tQ4E3coyPYAp1oFTti/qxb9hdLI7DNhvpEhmGcaeMBziYMP/6SfblPkdOIm0d91I2UwmlJ/6VQnrC83yoN+A0ELEOny5VbpMg0rotrRWr19Q6Pp8maIw1zMwKV3Rg/mk9Jew3ajqrYCzP17XzYxmDxLFgEeHezd3uDg2YPeakFtyJfKob2zEVoeZYyEpc9p7PW+6ioZBTcchQsx9ozbBLGU4fK8IK+aECwc/tumXsUWq/qMsKzpVEExGNYHA4AmcAxN5sLzW5VSKISF/xaqGb6WBUD9bMKx0kEev16z2mALGR2XkVFPKEpGRBmQ+S2SqlEtOd+Y7Ly+R4J2nu36/lIN9SaAyI4P3vTO4t+1alrQThl4bm1fenffCGVffMHmUmkd2Kb5RbaZ1bObSnQlLvMAt2jOCZkGhWCd+bt4niL/YBqc9Pf+HCNdImUlOwWdmjapO9Uvwz6yybcZzmjWfJlBp8UZ0BrWqrxEL2n/PZIM8MiRnNq3iH9wRhgnyAf+ItUVjJkz2zzFdpiWawuG+puYvwlTLu62KqxhHLTilvPdM1Wooo0gl1IPv41z+c+yr3lY0o9+yZhE0XW1x0xVtIhu6JfBtz57qxCO2A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(76116006)(66946007)(33656002)(9686003)(8936002)(7696005)(6506007)(86362001)(26005)(53546011)(45080400002)(83380400001)(66476007)(66556008)(64756008)(66446008)(478600001)(186003)(4326008)(55016002)(2906002)(966005)(316002)(122000001)(52536014)(71200400001)(5660300002)(8676002)(54906003)(38100700002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nw5l1/7sc6ZoZivyaO7v/s6PPuZlqGIpBXR8OzpUqu8a4zTxZ9vAZfYT8stA?=
 =?us-ascii?Q?8cOtkeDA/+SO0pjblh4sqYbWpYPXKRO0qtSkWCaiqoz4cjkpqs9yksatMpVB?=
 =?us-ascii?Q?gtn5sLn3ap1zQ2PaGMTybBTG1ZavVeWygaIagQYx0AjOeabXlDexqlflVpB0?=
 =?us-ascii?Q?ebvAz98lyf7kOH2wCh3DeS2V5L6wQJu1LrMAhkCxBtDEzwEdveOBqa6AGRU5?=
 =?us-ascii?Q?Yfjap2SdYDxmyYmqyfHRMXBxaHSJz0MySsYP8ksBlv3oAFUg6wuHKiu+Kah/?=
 =?us-ascii?Q?UtRM0VoNH9CX73dO+NSKXbR8w2mFw9/BJIuB+a4Q5A/OqydRvegtNoXs+GyZ?=
 =?us-ascii?Q?0OiOZucdaGE2Xhr4Chlp4Fobuno9VXmOPZIj37sb13niA3Xwt80yPblWlfyN?=
 =?us-ascii?Q?jftX0RT59KI/9ZwlVAdVFzosM7R+Ko/BX8btmSSf5weuHYH5hsURMuwVpDzZ?=
 =?us-ascii?Q?2+SKpjG6sLSQhg55MO/27RuDbt+zLf14wLNoWwnPg5ZdrOj8IIVFyo4bmaPO?=
 =?us-ascii?Q?4yHcMF6vcwhEBl1sX4viqTV+DbYtVXxqSV0mF5qzsflbbORrL6y3MfgTeEEY?=
 =?us-ascii?Q?IJ6MMBi7XKu5zndITqrUGqKzGB4o3Hz2noQof14xHLkw3A6Z8srotEHJyJkw?=
 =?us-ascii?Q?wUXHIOmgfvABQLK7MJRQijfeHlMsydy/cQAXz1NgiYNvmj+zMeITiWlz/CXF?=
 =?us-ascii?Q?rIr0IlWD7+kHBbwYNpCYzBflMBx9ao5fenmN1MGPi7pQ9dbyOex72R4cHIzF?=
 =?us-ascii?Q?4aH8gC4f1uLCMsN9Tg43PyXUrc5xjOszG8UEYS/oIhw0JD5W9/nIziOqJEbq?=
 =?us-ascii?Q?B2oB9Rt10sZeo0bz0h7L5XV7MK162Uyrw2TCoKCYFncMmptJcM6tybiQnDLL?=
 =?us-ascii?Q?HYJtbqmV4oQVD+MpKkmwDZaWCzKINjha/yDPUVESZoZMF0Ur1jdd6p5X5FKt?=
 =?us-ascii?Q?9GeCmvqMM6lgi5dM4b53yguJKHB+ztMjDYJLGBBSNCwEib8eein7cfELFSIT?=
 =?us-ascii?Q?bCeRjDLJ0++iwGvUbDTjCl6UbwFVIqfJY9cQOYibXUde5kCNbLYW3rh7mI5H?=
 =?us-ascii?Q?7thFLH4eiA4LdSyps9EoUZGVZxln8XjGPzWnaxW+5E/L9/xg5sDFb4+cXdKF?=
 =?us-ascii?Q?ZFwbokqA9lxjBByCHoMzsun+IFvJSB0O4mZW1+Z1WvMDtT4vtf4A9DIWFOBt?=
 =?us-ascii?Q?tWVs9kp+IoJqC4ePCHXUD5prAFXEcW2pwJVlVkTTruu8yeT1/59GIznVq4hq?=
 =?us-ascii?Q?KYtrCz17nMvwSgiGAbKlQRDZFD8KiGRa0Xy7ZpoRuGR3S/jDArV6Q3n5+3S8?=
 =?us-ascii?Q?4fpBqN5Ph1oxNLnM+tvhfKPh?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a77f9e-3022-4130-c0ee-08d92be15f1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 07:28:41.1596 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oNKn4LMQY3Men0JRJD3uAB8y+vYNw3CU1s9kN34lfQILMiVKggcI27lLHd20tVJI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5519
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
Cc: "Wang, YuBiao" <YuBiao.Wang@amd.com>, "Grodzovsky,
 Andrey" <Andrey.Grodzovsky@amd.com>, "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Horace Chen <horace.chen@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of YuBiao Wang
Sent: Wednesday, June 9, 2021 11:02 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, YuBiao <YuBiao.Wang@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Xiaojie Yuan <xiaojie.yuan@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: reset psp ring wptr during ring_create

[Why]
psp ring wptr is not initialized properly in ring_create, which would lead to psp failure after several gpu reset.

[How]
Set ring_wptr to zero in psp_ring_create.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 1 +  drivers/gpu/drm/amd/amdgpu/psp_v3_1.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 0fd1ed918627..3e6218799a0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -468,6 +468,7 @@ static int psp_v11_0_ring_create(struct psp_context *psp,
 	struct amdgpu_device *adev = psp->adev;
 
 	if (amdgpu_sriov_vf(adev)) {
+		ring->ring_wptr = 0;
 		ret = psp_v11_0_ring_stop(psp, ring_type);
 		if (ret) {
 			DRM_ERROR("psp_v11_0_ring_stop_sriov failed!\n"); diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
index 908664a5774b..be05d9cbd41e 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -231,6 +231,7 @@ static int psp_v3_1_ring_create(struct psp_context *psp,
 	psp_v3_1_reroute_ih(psp);
 
 	if (amdgpu_sriov_vf(adev)) {
+		ring->ring_wptr = 0;
 		ret = psp_v3_1_ring_stop(psp, ring_type);
 		if (ret) {
 			DRM_ERROR("psp_v3_1_ring_stop_sriov failed!\n");
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Chorace.chen%40amd.com%7Cf0c4d8c71e76407bef2008d92af30323%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637588045485244771%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=eozuFP5rS0dwOstJwqjeMWA%2BbhXAfjFDMRi1G%2FISzFI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
