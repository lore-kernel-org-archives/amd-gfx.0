Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DCECD8C8E
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Jun 2026 13:38:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDFAB112E35;
	Sat,  6 Jun 2026 13:38:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wkqzDkk9";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012036.outbound.protection.outlook.com
 [40.93.195.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BC86112E35
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Jun 2026 13:38:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFXIUpZqkfXwh7mMHHrMNkNWCJLW3l7jS/pMJUqNQekfQ9Z7AewcF1LORGIUQEmBIvf8cBF7/C4hfRr4/aJY/Z2yfi81Vw8g0aB1I/QJ+v8WXhLcfnYS5OXdpsu0ch0iBX8MV0qsvZRz+PFRZ/jg41oQRxV/UEOqUfdTdcY3Qm9iSM1YhgyFhTX41Ezj7jjzDVkrFU3XWDqMUlziFPMK+ItYo/e6LAtqbm28673uVR6aJroPi/GWvZEHbaP3tgrS+swQfqcmDa7UiSlqpDrIwU9sdqut6AUY5UFAN2wqETk0ajNM13pBDj3eBfHnaN7jT1ZrVa+Uyhipnm/zxUhBdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ne2mGsytGtz3wjjQ5lagAHDYb7pPtc5oSvxqs5ZXuOg=;
 b=boJPPGRAZXkupDgZPogYxPCUXHIrsMq7RNABbVFTzIucg4FIcuyokgXRr9MHW5leE3iZrELjRqzJQK+ePDDoe+Ix3eQtkQDD835YU8ola+z6LfsoztGAP3PM3RrTZVjNEwjD9+4owIwX17Gk5xC60NObMlnJGLR4vdH1cuFNA93Up+HTQRQDhHJfqn58UWN8eTad85J1wID2V6sK3YstqgSzhcbCU3WGp6VFnwSau5JeGC11RRsgAAJuTcRKjhImkqECbhaJ6sjmzB2+OPrPXV08FBs0bnhaxBlEHYgrVAb8R3UdFDMy1ZYGOtn/+ZTVnFnfSAlX71Kp4WC9nh9OcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ne2mGsytGtz3wjjQ5lagAHDYb7pPtc5oSvxqs5ZXuOg=;
 b=wkqzDkk9rHMrt/P+69UPd8lH9IqdFIbozIIP26weLH1Q7GtVuvps+wp+/RnUGcWONSarcF1Yo/gZmtX+WELcGyd1yHwuLE9C3oTBzo5V1WVzdvFmlMILOkCHpMf7Az+GEP5NwaB9BH8Z6HqG9s5hwe/HJcyE3pjQiqYSQ04w4G8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Sat, 6 Jun 2026
 13:38:45 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0092.010; Sat, 6 Jun 2026
 13:38:45 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH v1 1/2] drm/amdgpu/ras: added RAS EEPROM device support
 check
Thread-Topic: [PATCH v1 1/2] drm/amdgpu/ras: added RAS EEPROM device support
 check
Thread-Index: AQHc9bjUggY9jq91KUmzUkyDiMaG2bYxiAuA
Date: Sat, 6 Jun 2026 13:38:45 +0000
Message-ID: <BN9PR12MB5257F5D7B21B7FE6CF7CB242FC1E2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <cover.1780752510.git.cesun102@amd.com>
 <117a42d9579afd04366a096c2322021cefb34736.1780752510.git.cesun102@amd.com>
In-Reply-To: <117a42d9579afd04366a096c2322021cefb34736.1780752510.git.cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-06T13:38:22.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA0PR12MB8895:EE_
x-ms-office365-filtering-correlation-id: ad41b3e1-7c2d-414c-8df2-08dec3d0ee5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|38070700021|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info: 6tSRtei+hAUUg1vgvmcIdz+LjoMcOFULcNeQJe9TIYKqorsvNNJ08iu0jBbGFKlSdZzE6dROG9BIJF0u1r0T2FDuhfSKVxOfDTXeOcxeEpT/sC6AFcL2GU3Xj4aF1LpDfu/KcOPQMR64dHcdNq/0LELL9RF10Ng2OGuPBHvgpXf8AknKdODGCUl6+3fhypByELP9xSqkalQkVUyFaaUK6t3OyeeyTuDr2zdW6tRAksRQtHKOMa10od4pD1xFNXe60z9SeXdOk0FU99aJGE28ktoQwJZ0QmcodnQHKyuS7bGq4jhhKv3zw+5zbL9jFbQEKvEE/0La8YRUPTdbkbNCMYOzauguGQuT0NvU7+P6VVg0FkxyhSwieStKjeJyeXuAQO0e4/UgDkfMHCbFODDqBwRwbSt0yoda1SNwhjtwhCF4+XtpDWEGnPupaazWEgeNp+G6Kydk6vNufW9krJWa/ft6Tg4+el6coPfeS7LyQctOtqb8S+IZ+MOM0LBBDnCAtpsXchZkm7mu1TOaF0JhAjscXn3wxMqyDS+OCcTiLS9xbEe0vS6tJuTKtUcWp6ah6vmlMQLc1tm06CTcqmeOl8jEY8ND1cDyrKf+Gx/YHO1nymu4R5pWJx20ZPA+QTQce7U+mRq9lIanid9IgpnpRy2Agfd9SeW0+ZKxtKdU/Bs96jFqD5SdcdRvh4ANADEbOAevRYgfqDlQFidt7upwVzUfxokNH99ia4x0Cd7UtfVIhQLYGvfQtDNzxak6iKfT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w8sS7PN/5D5zcGIdg+mnvKtp12bnGwmEHj2eEZzX4lPDr4lYQXjI0Ra6rU8g?=
 =?us-ascii?Q?rTWofN2TgYJFH9Sx/YuRcvKmIPxmtx9XAU4png42yfp6vtCM7uftWLcv8JeX?=
 =?us-ascii?Q?cxSZ3xCcdZtM9EEZ5pZyBoJy2PtzPxHi/jV0lB/Oo0XVj4kJ3YmjTBSJHOiA?=
 =?us-ascii?Q?nKNKXpNCd7Enl64z8vaknXErFGwBJA8Y8ceegvoNL2JuHfFvXbHoZJZ6wjyK?=
 =?us-ascii?Q?UGOOXcgN16OSEShSrSKee6qznD8NwXSC5VYoq8dWlGnW9llgun9oFZZxtt7K?=
 =?us-ascii?Q?thHLJPjylHYi6P1Qd/Rv2VobrcKZsByqXfdJ3oeRF0zWhnU1PDVk9QgPGW6p?=
 =?us-ascii?Q?HG3xTPmSoOMh/h5dTvfaPNzDa6jAtQJxGd0IZmU6of/VdZnTvdk3a0NAGHtY?=
 =?us-ascii?Q?0AHHFflVqLBYEIlLO+CY7caJDHZzAfkId4ZHemy4cSepdVXBSg2HFOklF/96?=
 =?us-ascii?Q?YRdAjClko4zTDI3S8EclEaOcAozYMN0ahevqTIXTA7SEymOSzJwkgzAeIbWW?=
 =?us-ascii?Q?JS4a3q4GWk6x3CtGNpiiLuCItwMKdsiZH5IB//fWfv5eWHPAShq7VT8NZINi?=
 =?us-ascii?Q?Xnl31miad+RFloAUReDfGEsspYjFw4+LoApDOGLqxXv42mhy+Ze7lGoszDye?=
 =?us-ascii?Q?vkPVLQDGGdSRxkW6MOnrQeegE6EQmB8e0A7gJvjHt+YYNXmv0+hh+yzTBlxx?=
 =?us-ascii?Q?jARiV/OeLRONFnipuIRkYFSa3ByDBUPVDD5/rDHG4+UCyp/DlQGSrZA1C9if?=
 =?us-ascii?Q?w8o9/rV9EasLRmFJAdgHi/080S0jTKCpedWcjHDmPWQk6qPxiHsi1rRYAtvL?=
 =?us-ascii?Q?PcKxqzeDgwdnnEEFl2G7wtkVsDBGRmLhCCWKbg0T+sczdulyB465wsdgi18w?=
 =?us-ascii?Q?Z/+9DbbyV4Qpmm5RMRyukw94O8z5VvW681up/zTDd9n4ofIyMDpJKpcWaNxb?=
 =?us-ascii?Q?dkzfA3+9zUVl4Og3/oEPQhEj+YhG2LM08qrHTgBBeg3n4ZFzrNO0Viw5cW4U?=
 =?us-ascii?Q?+92AK0GP4KeBDsIJTv6If0ppu45U+61FKhilp0l2t0CaZtgEeA1veQyh46fp?=
 =?us-ascii?Q?gDcBnz2AYho7JoGrdqn2bk/tkLyxU0jJXoebachFhJ1pYJO9g5642Fhd27dI?=
 =?us-ascii?Q?5+seu8T1i0zxkFxJQpXBd8Qy+KjJp62vH7IPUUgFD/8l9KWPCy27s47UIQTX?=
 =?us-ascii?Q?PsPDG/VoeEZSvQUTLtoGHY3AzfJT7PLPC4+cU9kWgbaScO8nXoI7IvOT9eoI?=
 =?us-ascii?Q?jxOepX4pLOli6dFm/1gLgearHNYTV2Y6EjaOIQL4rl34dny+cXjknslIF4Tw?=
 =?us-ascii?Q?AqV1/FLLiotxDF588V1HLy1pFK4yc3e8k4XCA9detn3cJsW5SQX/hqjNapSX?=
 =?us-ascii?Q?0IkPQZpXlKWB1z9ZdqTHxZfft4FIDZBvMlF9vUsjnnvel6JZOxspEkGwxGgs?=
 =?us-ascii?Q?LHNwoHxTVfRb7FIGFlStOIZsNS5V156En56dcd7HAqvzxyD8x2Nqx2kz5VHi?=
 =?us-ascii?Q?Fl3+LyVyv7s01bCWWyPYSY3TiDvZJJVJu5V4WJMkaH0LXpfe2Cl+FCzfQYYy?=
 =?us-ascii?Q?PX7TYDZWt8cWDJRN4isu4JrM2twSuW/hrGj+7pIDEU0mm/RXm677XVIbkiOF?=
 =?us-ascii?Q?kRbKrumnIBSisOw0bfzp+Htr8iPjm5Z9KLKEMLkOpRWLK+0R8/7Q0QHvjugv?=
 =?us-ascii?Q?uAazQ39nWS0kbi3ZHU0AU3twlSlN7xOM24Fyhi/zxF1sKSk5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad41b3e1-7c2d-414c-8df2-08dec3d0ee5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2026 13:38:45.2350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pf0X6mZPv7IsUWHXBEVGaRlm7/OnMNzYjEi4QwvLpfrPdH2eLdt+ye+6qc2IEaLmJpncS1mnDy9y6cajj/Ionw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8895
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Saturday, June 6, 2026 9:31 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Sun,=
 Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH v1 1/2] drm/amdgpu/ras: added RAS EEPROM device support che=
ck

Added RAS EEPROM device support check

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c   | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index ef09a6fad659..26f554a80e1a 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -142,6 +142,21 @@ static int amdgpu_ras_mgr_init_eeprom_config(struct am=
dgpu_device *adev,
        return 0;
 }

+static bool amdgpu_ras_mgr_eeprom_is_supported(struct amdgpu_device
+*adev) {
+       if (amdgpu_sriov_vf(adev))
+               return false;
+
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
+       case IP_VERSION(13, 0, 6):
+       case IP_VERSION(13, 0, 12):
+       case IP_VERSION(13, 0, 14):
+               return (adev->gmc.is_app_apu) ? false : true;
+       default:
+               return false;
+       }
+}
+
 static int amdgpu_ras_mgr_init_mp1_config(struct amdgpu_device *adev,
                struct ras_core_config *config)
 {
@@ -266,7 +281,8 @@ static struct ras_core_context *amdgpu_ras_mgr_create_r=
as_core(struct amdgpu_dev
                init_config.aca_ip_version =3D IP_VERSION(1, 0, 0);

        init_config.sys_fn =3D &amdgpu_ras_sys_fn;
-       init_config.ras_eeprom_supported =3D true;
+       init_config.ras_eeprom_supported =3D
+               amdgpu_ras_mgr_eeprom_is_supported(adev);
        init_config.poison_supported =3D
                amdgpu_ras_is_poison_mode_supported(adev);

--
2.34.1

