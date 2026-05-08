Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344A0CD3427
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 03:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BE8510E2EA;
	Fri,  8 May 2026 03:14:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eS+tp8Au";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E92210E2EA
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 03:14:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRHPrpmEe73zcD6ajLa3rWGsDZRMUBg9xMoWgIT+A0uQLIsAq4FDHJf4/gMMFb/fYeLq3zXd1JjTMe+epPOwJKU7PLuvMujReLJmdEI16b3JFzLTjzlqBFMQDdg/3tD36WBUapIks7zA0ttcdu/1PkObOPpsIGahfzX00LnFBNj1HfibcPLpDzj+u+xwx8h2kgkMlPyLmNTq/zamPg0nOafjLiT7X+3BmCe4ZVYs1QFXGiSkQ1FkD1syJNCypa6nmwqlvM+A8Yq/QDW0/slSe/vpWrHf35lFrElTN5fiujsJSzo+CWYIJMPsEnffV5PkIN1Qlci0tROhx0wOGnZ68A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2zTR7i05917cVK4HnLE/HY4Q8plu4kcvFUYdNTmqrA=;
 b=UiXhnFLul2UJzX/beVoAXC39i+yCcBSL00dCTpJhXEpWgkouQSn6Jb3idUVVL7QW56N7GV3kgJ6xDIIHCqtAe7nGJW+xSL7VQfWycSAKS5b3zV5GTzE5c5h8jwmyPpr62aTV09VuVs4D2sc9uDbadfZNagQ06AFaJ+8AiGxlEXV9cL3kYpfhKMSFKvmoVxbcuKLSAusAdgyInIM9WahB8dbGdTHrF2f+eDisZvRB2PYGgqKo7KdwC4i3d5iB2mqgrBd5ZI00YBfAcI5QjorEgU88Lswsgoxaa3J1cf6MPwj0mtNIwCKeukGl8ehn4TX3Lq7K/cvmTOW357vnvDFqHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2zTR7i05917cVK4HnLE/HY4Q8plu4kcvFUYdNTmqrA=;
 b=eS+tp8AuWn5STzFTJ8aWFMpxsgMSMCSZoLp7HFZkg6phMmY/ISqvqf5hNYzrdunpeXZTA4gYCCGZksve+DFuy2CL61XpWqDgixPMnGQCrZ7wAWV/SE+EV8AUfWkl9MKktTqv9f+Scx5f0U1aIXe9T2kAqpV00C/9+pdhZ5IBq1U=
Received: from BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 by IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 03:14:12 +0000
Received: from BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d]) by BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d%2]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 03:14:11 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Xie, Chenglei" <Chenglei.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chan, Hing Pong" <Jeffrey.Chan@amd.com>, "Luo, Zhigang"
 <Zhigang.Luo@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lu, 
 Victor Cheng Chi (Victor)" <VictorChengChi.Lu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: bound bad-page list writes to allocated
 capacity
Thread-Topic: [PATCH] drm/amdgpu: bound bad-page list writes to allocated
 capacity
Thread-Index: AQHc3jAdk3K7++MxI0Ka64HOhLGnVrYC/3IAgAB0g2A=
Date: Fri, 8 May 2026 03:14:11 +0000
Message-ID: <BN9PR12MB5306BE73CDDAAEDA37B3A0F1FC3D2@BN9PR12MB5306.namprd12.prod.outlook.com>
References: <20260507144449.25778-1-Chenglei.Xie@amd.com>
 <SJ1PR12MB6121C866664DDBE850559F22803C2@SJ1PR12MB6121.namprd12.prod.outlook.com>
In-Reply-To: <SJ1PR12MB6121C866664DDBE850559F22803C2@SJ1PR12MB6121.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-07T20:09:32.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5306:EE_|IA1PR12MB8517:EE_
x-ms-office365-filtering-correlation-id: e1eee4e4-3447-4f9c-45a6-08deacafe084
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: /DlLNu/K7PUfSuH7fK6oXY+VQRfoLphUJTGYgvgBQuAK4X66HakpoHU7ZXfloaPNrNjfWT2R1H0UtTraaFLhDQV1wyvOz3wjj7a1zVMXaPBKzTjmoKMvKy6W/hgezwd1YFnFKb7OfZY5yWfzDXnEIww/2aQd/9RRWI2ZmmiArPWoNoilMtFeniJXvLaO5YL7iiGjh3ciZORq0Qf4dC2CDSenriYb6WdgL3QnnLRvfeXM+Ve9/pIN7m3jopFa/QdwfiY5DJ35ZWfczpEiMgKnYAxlg1l3MAB5rMOdhtDyVYaILL+wjKivqRTwLRxYi+2VlCbQns72oM00woL/LkqfH2qz+GB24yZ4pQgnCCMIqemAcMuW5Qu7aHbSBEktMkWGIsTEQax+cWyZ8Lw6Thi3QqC6o7YbuOuGze3tNAhk8gsIpevbtNbfaDKYdYIzAeYYwkheyAJjlyPk3f8XblISEpFus5tN7NnkhwB8XjJX7SoxtBCGUhdqY+La/4axTQxVc5/Z5aSEkT2C14hizLHUmUSQU5XlRQTWHniG8mj0UJrhs+4UOP/OVbY1JuguxnekH+2sbwpv2MmGyC/QxgIRgas1GwjGZekwH07GJc2fuB5zwEapR61MwGhnAdQs7qv6Gnmao1ynPPeGhDuCshcE9XtFVxViykBS9C30yHwVJubLX5DDKakMkVCN5CutjN9QnzcHwHWRe6G351jbUEdvyuSfp7wdsQrjctODzyoba/sKgxwVrwFEMmDScRXgcsha
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5306.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pV2T9krrg5oCvV7wpNCVAKo5Qj+HUlTpu/+7wwaGygwxDAQlrcewoD2wDLwL?=
 =?us-ascii?Q?0RR0ByxdxkUvBACkWQ513hZtKFebPmqak9b2OlyC5kaRlaE5ZskJCSwZ4jQB?=
 =?us-ascii?Q?zs+WxDXLg8+cxtI4eRjgr/DBEgWEvPSZpoaeF9Xczq/i0WeO8frEWnHbeDBu?=
 =?us-ascii?Q?GQVQMy6NfkBI2upOdtzKEGl1YGqe4zYh2ayI4F+Efjy3C8IanKX5TasZlIlC?=
 =?us-ascii?Q?24xivYYccXmIkt0+wW8AtjDg6zMGXzRjA8VykUAqo/l5G2eZZ/2x60NrXDBe?=
 =?us-ascii?Q?qF0F34zdI25xdd7CcX44OfOaYJw4psv+nfeGNhryxtIaOiy3KcZBljnRDN7D?=
 =?us-ascii?Q?mxJY4p3f1dZB5yt3C3riIVT8N1+i9ny9MbSDczsZBjJUIcpPLVzF1fDINjwt?=
 =?us-ascii?Q?K8blDoNCbIx6aJ3rbDFHHFOAh15oRZtoGqKXlq4/pKcMjjCKzk5YZTyfiRbs?=
 =?us-ascii?Q?CVkjQARMVuC0mchOpw3BLCeAwmfmgvPfr873A7T+ZWiloWB88mzXzmHq1NcF?=
 =?us-ascii?Q?9d4suxew6MEzixWsyC1bqzFAO7I4r+Dkua8Cx7pGQAXrqrzaooAm8j/6u7uq?=
 =?us-ascii?Q?P1ixDvI5+rhgckYNWEyms7M361AEEKtk/ikLeOeQt2Xw6boHbjYMcDX11wFN?=
 =?us-ascii?Q?B3ETMUOJnqosZa1AsiPSPCYVtqbLHlLzZ36t/yo3hnhE5Oc/ppiEBJfme67Y?=
 =?us-ascii?Q?VfkJsPpekZpAaNG7O+FGRXZavH65rjLJZUIR9njsVYU2kxy7VyEsycQDfkM9?=
 =?us-ascii?Q?VloTuRwwX0WYgf0KuPXxxq4j50x/mzRBM8edihFRGYoZo9YfMdr8i5ViRQEO?=
 =?us-ascii?Q?E4kjQBVQ8dEfq+zSREDw99GvtrBrE5RGxpRZpsMwvyAltMxKpE8KjHRYXlga?=
 =?us-ascii?Q?cDHp105VDrQqa8FW5g33Y0Y9Fd60HGPVuSYL/393I+WwisvCPEejChSkUJBE?=
 =?us-ascii?Q?Qdc+J8x2IYPc4zLFwefku+xuxcBO9gGEXwytzmaR6eh65jgK/sHJ3YdmRZZ2?=
 =?us-ascii?Q?Z9kMTGQ6mC26grRs+0ltkAIpPsqeacSs0zsMr0sm8xbxH4ZSTAp9eGU5CeMi?=
 =?us-ascii?Q?OyCfw/o3lND1dEPha/9LqEMy45z3ymV6oVdBQCb2WsVz8wUH39ri+Qg3LOnp?=
 =?us-ascii?Q?9uhSVHmKYTAafd9T0KZJwAbY40muFMRW4T8r35Gr/uguEx2lQsCWy32CPSON?=
 =?us-ascii?Q?9ToQ3IIs3TavPsdmqUG7ku8fROK3dNGycgq7SxijtTG4uC6VX5maj09GBVLi?=
 =?us-ascii?Q?4Zy49Kpso5r9hT1LRCsFJklFjMxZ30Fn19Wem6cFSjMoZG6bX/M6PiUInNJ8?=
 =?us-ascii?Q?gICzCYmjC6Uh6ZNBLZvYuKmfY5AZ5tYMBDhpnwjYIxx1aqKYnVWI3rwL1J1S?=
 =?us-ascii?Q?KsH+BXXDe/jKMaryyMZLBdqe0kImpdmHbfLJKzwOwYa3Xb5XYopnojwzHEX+?=
 =?us-ascii?Q?CVa0dD6YFdOJ73I+aSoXvuBbptjkFvwRbninZqFvvB2R5RV0wN0sdTiODhH0?=
 =?us-ascii?Q?05aD7qAu90LnCCDQB2iW7ykgcSDBRqb1LiL08wcVEwE8sJJ/IyY5kmMtmXDu?=
 =?us-ascii?Q?zH2wc7j0+ZDoj9wOqYY/G62bQrwlkD06f45zRF58J6t+X/8ga+wGyJKx8mT2?=
 =?us-ascii?Q?EIIHMpmtI8/8Eg9YIJU0iIL1Fr41nQ5sazkR4vJaTHfjeCsWD6jm3zTN95ND?=
 =?us-ascii?Q?8HfOYKwXiNVMMxFD1Ya3Br5eals48OgowX+/Flu05U3gX84g?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5306.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1eee4e4-3447-4f9c-45a6-08deacafe084
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 03:14:11.8729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WdSHnpaSadGweG+XBgpZPu6VICs87BKtgb84lxHj74c0cxMPtpUZVDxWfQH7yH10YHHSUPH6LDGtZb5y+YB84g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517
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

AMD General

Best Regards,
Thomas
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Xie, Che=
nglei
Sent: Friday, May 8, 2026 4:13 AM
To: amd-gfx@lists.freedesktop.org
Cc: Chan, Hing Pong <Jeffrey.Chan@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.c=
om>; Deucher, Alexander <Alexander.Deucher@amd.com>; Lu, Victor Cheng Chi (=
Victor) <VictorChengChi.Lu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: bound bad-page list writes to allocated ca=
pacity

AMD General

Hi team,

Could anyone help review this security bug fix patch for https://ontrack-in=
ternal.amd.com/browse/SWDEV-589525.

Thanks,
Chenglei

-----Original Message-----
From: Xie, Chenglei <Chenglei.Xie@amd.com>
Sent: Thursday, May 7, 2026 10:45 AM
To: amd-gfx@lists.freedesktop.org
Cc: Chan, Hing Pong <Jeffrey.Chan@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.c=
om>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xie, Chenglei <Chengle=
i.Xie@amd.com>
Subject: [PATCH] drm/amdgpu: bound bad-page list writes to allocated capaci=
ty

PF2VF bad-page data can provide more entries than the VF-side bad-page buff=
er can hold. amdgpu_virt_ras_add_bps() copied entries without checking rema=
ining capacity, which can overrun the 512-entry allocation.

Add an explicit max bad-page constant, validate pages against remaining spa=
ce before memcpy(), and make the helper return bool so the caller stops pro=
cessing when the buffer is full. This preserves normal behavior while preve=
nting overwrite from malformed or malicious input.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
Change-Id: I924d2b5e369bef007eb1577f287a2274ec83d5a9
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 53 +++++++++++++++---------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 6974b1c5b56c2..8ac808d70356c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -283,14 +283,12 @@ unsigned int amd_sriov_msg_checksum(void *obj,
        return ret;
 }

+#define AMDGPU_VIRT_RAS_MAX_BAD_PAGES 512
+
[Thomas]   This may not be sufficient. Suggest switching to a dynamically g=
rowing allocation instead.


 static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *ade=
v)  {
        struct amdgpu_virt *virt =3D &adev->virt;
        struct amdgpu_virt_ras_err_handler_data **data =3D &virt->virt_eh_d=
ata;
-       /* GPU will be marked bad on host if bp count more then 10,
-        * so alloc 512 is enough.
-        */
-       unsigned int align_space =3D 512;
        void *bps =3D NULL;
        struct amdgpu_bo **bps_bo =3D NULL;

@@ -298,11 +296,14 @@ static int amdgpu_virt_init_ras_err_handler_data(stru=
ct amdgpu_device *adev)
        if (!*data)
                goto data_failure;

-       bps =3D kmalloc_array(align_space, sizeof(*(*data)->bps), GFP_KERNE=
L);
+       /* GPU will be marked bad on host if bp count more then 10,
+        * so alloc 512 is enough.
+        */
+       bps =3D kmalloc_array(AMDGPU_VIRT_RAS_MAX_BAD_PAGES,
+sizeof(*(*data)->bps), GFP_KERNEL);
        if (!bps)
                goto bps_failure;

-       bps_bo =3D kmalloc_array(align_space, sizeof(*(*data)->bps_bo), GFP=
_KERNEL);
+       bps_bo =3D kmalloc_array(AMDGPU_VIRT_RAS_MAX_BAD_PAGES,
+sizeof(*(*data)->bps_bo), GFP_KERNEL);
        if (!bps_bo)
                goto bps_bo_failure;

@@ -361,17 +362,27 @@ void amdgpu_virt_release_ras_err_handler_data(struct =
amdgpu_device *adev)
        virt->virt_eh_data =3D NULL;
 }

-static void amdgpu_virt_ras_add_bps(struct amdgpu_device *adev,
-               struct eeprom_table_record *bps, int pages)
+static bool amdgpu_virt_ras_add_bps(struct amdgpu_device *adev,
+               const struct eeprom_table_record *bps, int pages)
 {
        struct amdgpu_virt *virt =3D &adev->virt;
        struct amdgpu_virt_ras_err_handler_data *data =3D virt->virt_eh_dat=
a;

        if (!data)
-               return;
+               return false;
+
+       if (pages > AMDGPU_VIRT_RAS_MAX_BAD_PAGES - data->count) {
+               dev_warn_ratelimited(adev->dev,
+                                    "RAS WARN: bad page buffer full, count=
=3D%d pages=3D%d max=3D%d\n",
+                                    data->count, pages,
+                                    AMDGPU_VIRT_RAS_MAX_BAD_PAGES);
+               return false;
+       }

        memcpy(&data->bps[data->count], bps, pages * sizeof(*data->bps));
        data->count +=3D pages;
+
+       return true;
 }

 static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev) @@ -44=
3,20 +454,22 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *=
adev,

        memset(&bp, 0, sizeof(bp));

-       if (bp_block_size) {
-               bp_cnt =3D bp_block_size / sizeof(uint64_t);
-               for (bp_idx =3D 0; bp_idx < bp_cnt; bp_idx++) {
-                       retired_page =3D *(uint64_t *)(vram_usage_va +
-                                       bp_block_offset + bp_idx * sizeof(u=
int64_t));
-                       bp.retired_page =3D retired_page;
+       if (!bp_block_size)
+               return;

-                       if (amdgpu_virt_ras_check_bad_page(adev, retired_pa=
ge))
-                               continue;
+       bp_cnt =3D bp_block_size / sizeof(uint64_t);
+       for (bp_idx =3D 0; bp_idx < bp_cnt; bp_idx++) {
+               retired_page =3D *(uint64_t *)(vram_usage_va +
+                               bp_block_offset + bp_idx * sizeof(uint64_t)=
);
+               bp.retired_page =3D retired_page;

-                       amdgpu_virt_ras_add_bps(adev, &bp, 1);
+               if (amdgpu_virt_ras_check_bad_page(adev, retired_page))
+                       continue;

-                       amdgpu_virt_ras_reserve_bps(adev);
-               }
+               if (!amdgpu_virt_ras_add_bps(adev, &bp, 1))
+                       break;
+
+               amdgpu_virt_ras_reserve_bps(adev);
        }
 }

--
2.34.1

