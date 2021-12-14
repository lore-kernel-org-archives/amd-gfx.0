Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377F6C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 03:38:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F84F10EBA2;
	Tue, 14 Dec 2021 03:38:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1261310EB9B
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 03:38:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRY/QVNT0aIU1cWbjx0afZ92S0tiZcBxIw0l9E2ePHwONH8N2BL/Wp1vkY1xLRJvP8OshEsnJ3HqqaRiFTbbZvc3LnerxB2kGM3OqnX2aTtA8qDFPzhxF94Q/HRSlarEmWS805kbxIWIKC4yv3Tnzm9Sqb2dEbI5nXA8MkXFEWFPMCzeWWstNjPvld9bh2ysy48smHti0uqCoIc4hjAWSXK+SHyPaHGKn+vt+FB82h981nlDhCGpz0jA/x8F0A6NYUgiMzzYOnzlfZMtuRMh/a58ZAV3pledpQjg/lEPayCJba73NV9YK1MuHKzw7AyIQzj/SMUqrsOOb0kHagbV8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ono3sO5zGw0trZRf0dcWJTaaRziEhz5bPlaBSZnLHzo=;
 b=YBVnwZ5F+SFgmEkbTl9872+50P1OsfCV8GbSpnQV5klLxthOgWYreuqKSu7RtZG3BpkUwq9wFViaPgsg6gEJIXTdEFY+mequgN5ofvUeCixOHjcNaCk29cxHShE+g40rkCl04dV0A8b6R196vjnveDhgSgPOHCNEOLp6MqM6jhmpfmvem/iSvDavQdpsnp0oW9bo9eHlOrqs/IWFv+cFV6KacDQwvVVeVnNdeb9vIOMq8E0TO8PdgStNHfBUy0hF7MGyRLhekQNVJciCDL63bLg3vEwIG3/2CBlS2zZ6sMr3yR3XZ3KwvbiLgLQdH8BD2X4+MOFoIiMsIkxw5ZEXAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ono3sO5zGw0trZRf0dcWJTaaRziEhz5bPlaBSZnLHzo=;
 b=mLUlTkyrtMJyQZV5o2mqSonrS+nTGv0x5wXqDy6w9AjSfbRjyR1LIB7enEqScTiwI2wFYResUjSpNO2yDuBSZghLbYaveSmW6c7culPp+M1TX1tvUux9pEL4pGAD/4OBrbK/lI3VA5DZ2WtcKvwKxtcTQ5NdrsHBLF+gnR0zwZw=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3769.namprd12.prod.outlook.com (2603:10b6:5:14a::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.16; Tue, 14 Dec 2021 03:38:41 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e%5]) with mapi id 15.20.4778.017; Tue, 14 Dec 2021
 03:38:41 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Russell, Kent"
 <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdgpu: Access the FRU on Aldebaran
Thread-Topic: [PATCH 4/4] drm/amdgpu: Access the FRU on Aldebaran
Thread-Index: AQHX8FiFJ0cmjAHNmUSSO7lZpleR6awxUPZAgAAE5XA=
Date: Tue, 14 Dec 2021 03:38:41 +0000
Message-ID: <DM5PR12MB2469E1497AC1CDE2E586F8A2F1759@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211213193402.96278-1-kent.russell@amd.com>
 <20211213193402.96278-4-kent.russell@amd.com>
 <DM5PR12MB24693785E4E9F4543D5D60EBF1759@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB24693785E4E9F4543D5D60EBF1759@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-14T03:16:28Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7f4e7385-27b9-4909-bf3c-1d032d7d88a5;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-14T03:38:37Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 5644ef15-d53b-4c62-a089-37ce2414ddcd
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31382182-38a7-470a-8603-08d9beb3390c
x-ms-traffictypediagnostic: DM6PR12MB3769:EE_
x-microsoft-antispam-prvs: <DM6PR12MB37694C87B437AB97A384E059F1759@DM6PR12MB3769.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K1RoSBIzJEKPO2sISvSCGiUHCldXAJ1sdim27ZVXCOwHj85i+5w1fKPr3G15RwFY/UZaFr0M95PTeQleu+gN9H5hXvremNkDEItLq1xyhUbpNrasDj7ovK/a9TALisDCj1LJ6aeOKv84xSmV4Haf8Liz3yUJ7Pl6BN9fGoyYvAFY1wRAvjw2z0E7HhtX79uKbxwbTEA6SQhftJyrY27Zl/Vliuy7fGskKPXyO8o6TLsOchmNaiUqWLNYyMs9tdKECriwNN7/gTLFnG83jlOJEb2ETRvbbLkTUTLOKPujkVhs37zXv69nGZxPTf1ywo1vmuwSZx6Tc8NCD6GEgctfPbM96WqLZxLuQS5vJODdTuRdqL1kwmRRJQYYMjsj7M27IZGbKdwKl9j91NOaJuLOna9Fw4/sQQpHK8tAmAol8Jx+fLmGPrZ1iEWxDPCr8B9xGcm9VB3g9GULT0WpayW/NbQ+kSwO7KgzfMwHRjgjlo7mSjXHzEelIhZlpZuVYzdTgLM6au3QYOcUu3g4AFhmorcgY+B+M8MVmYeGMI8zCJBL/u858+w/pGkKRUEO0lnI5vSfhFE82dbllo2C2lYeaR4Ps0aLpvHZt3WIrMv9LXzE3vungZPD6u2rfo9DZOpglaEwzfbbwgzXSNoSIROfTSLgFyQ6XO6xuCbwTaeg/50lNAasAliZ/mYOZiDvt6TtaqGSYwdc1hOMxjL6md58uA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(38070700005)(110136005)(316002)(4326008)(8936002)(71200400001)(508600001)(2940100002)(8676002)(186003)(7696005)(5660300002)(55016003)(76116006)(26005)(53546011)(6506007)(66556008)(64756008)(66476007)(66446008)(33656002)(86362001)(66946007)(122000001)(38100700002)(9686003)(83380400001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zbcWzh03qJE+PdyxO3cxyfOUdQ91zHh0/QtOcM+TroTrpTP0QTrH8VGfA1oR?=
 =?us-ascii?Q?F1lJ7Mt9kZbor33FGv16r64tczRuTSJ0N+6H6ztOaUItx1dYhXhJ5WhEzXQY?=
 =?us-ascii?Q?uuBx24NjbGs5uXescKzmLf/afoXSuCBbi8pnzE1+7ZWMPEQTWoaGrOxbCNI9?=
 =?us-ascii?Q?U2dgs9FOOguNmsrR5HNN+ybL3ZklxoBEqPRqp2oSqjDmZdCK9CszGB5e4HL3?=
 =?us-ascii?Q?qCgMxXoT3r00wgrDI5q8TYAjfRgKq/spKW4DyiqoUuES1kwhgGgwUQ49NQfh?=
 =?us-ascii?Q?oGkRk8kKNrw8L46dLGdtS8WvFvd5y9T3BdwHoC3SyxE8dYZ3E4qW/RgAO1ma?=
 =?us-ascii?Q?3INdL7UnRL/GUnnilIlEltKnksii1oLDWRqe1DA4FXBaUjBxrlA8VBy+iaHN?=
 =?us-ascii?Q?g//yDG5aLINAfun7DNtmBNVW7O/cFYJ7hd40KYCUFLwfJ2FPJWrgwnu/8EQo?=
 =?us-ascii?Q?U9U+edSG0je06KTHQNK01rFuKvc3H9ilRLKNLkpP6RSvrpHgcx/RKrZBGBVc?=
 =?us-ascii?Q?Gy9L+hH6nr7Aj/FmSIgwDY87db9di0nOEcwbjveEHC8GUQLfRbn7IUlzOXzy?=
 =?us-ascii?Q?phcCq7RBxLY+4TPRP3UupD0GJ7KgRNwCg9Vd9V83xdIXIIuhB3h6T8fE/pX/?=
 =?us-ascii?Q?yyhUCiAL7AtiAN6cvq/y3YHADw2b9mSn3Cnu+d7EJd05onpKOGzLbLnxxcMP?=
 =?us-ascii?Q?V6Mrg2NnFCXTU4bMHj8AC7Hvn3VpnFaJuB4d73cugx3yWMrNSAh5fTaCzoOL?=
 =?us-ascii?Q?xwDvwbIHBpPvpRjx85b4SqlOD5wlqdu/86w7ik/lbz5yuY79Z5H+6oz2QGWD?=
 =?us-ascii?Q?RF8do7kg6Wq7Tw8Aw+pbr/eRsarMSihfcHbhVvQcM6ftqg93iQlrsAy8EM2M?=
 =?us-ascii?Q?R95pHY6+k86pgwgsFSegkj0QL8VKzLD2Tg2SrSVMcKK3xZAkOn1eJ8ceKU9J?=
 =?us-ascii?Q?NgcVJiRn39bVKSWL1l3HBaNuiAczODnxix28pxt17m9xcfUNQeCjUZISu8tr?=
 =?us-ascii?Q?cnV7d2IcW0dFT/6/irJiIfEdwk4reJgdK8eGxzkFBLAXGBu/LpQTX8G6kqcV?=
 =?us-ascii?Q?1c14Xm1v/2iaN6PYafZXC4QRDsO2L8gUuEGJxgwD+NVdXmz8MMgvvkDf3O+u?=
 =?us-ascii?Q?o7ZbxHcPMDlXCMNbq9F1trRSR5ovp1ivUGS+GOJ6PLVJ7UNG4dYsZ5Cbh7Q0?=
 =?us-ascii?Q?/pVuSN+/BXhLQE3vMZlzX9ROD0u4wU1nEfR89uvo1nOd7m8zxFCy+soXXgLs?=
 =?us-ascii?Q?FYPWjakuFCQTEPq0muf+HOa56+xaEtYaOEyuOKxGwhqu7pLizP+55PPw8mHl?=
 =?us-ascii?Q?0RK2zSQhPY2t+LMvs/UxnBiqcxDvx3PD5fQWGcvbvgK1TLP76naNzePeFGf3?=
 =?us-ascii?Q?JiurcpAmHlWnkUcub4fFJ4GaT5Vf3CCG5fBOkWO2YgYYZSNcC71cQ0cG3Lil?=
 =?us-ascii?Q?EKeij1wRlGiB46xCJz4WlFcKxt19sGJxOw1w7SBygBJLvSCn24vEV+WqJubP?=
 =?us-ascii?Q?ClTTvNqhJLvpylOdCVSZGU7EB1MbQgcbaDHeFBrIskeeSusY7se4LwJ1ljSL?=
 =?us-ascii?Q?AfrTaPK+DKGfhZnNBMaCCCIsmUZOZZnli7zT6o1rrh0qvA0dVwHE+1GG+tyb?=
 =?us-ascii?Q?AebsxwFuEegBn0Oj1gtX2AM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31382182-38a7-470a-8603-08d9beb3390c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 03:38:41.3618 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CCok4hFNJTebFzi1wR2axPXZKb6DFSVKhfQXVvITWMFZSiKFHx1KIVxR8g0UtKC7r7IfNdWRT1AKkXQq+ofJHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3769
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
Cc: "Russell, Kent" <Kent.Russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

BTW, does FRU exists on all the Aldebaran SKUs?

This patch acks FRU's presence when it's Aldebaran. So if some Aldebaran SK=
Us do not have a FRU, some i2c access failures will be observed during boot=
 up. This is not friendly to user.

Please check Vega20 case we talked before, and there are some more strict c=
hecks for FRU on several Vega20 SKUs.

case CHIP_VEGA20:
		/* D161 and D163 are the VG20 server SKUs */
		if (strnstr(atom_ctx->vbios_version, "D161",
			    sizeof(atom_ctx->vbios_version)) ||
		    strnstr(atom_ctx->vbios_version, "D163",
			    sizeof(atom_ctx->vbios_version)))
			return true;
		else
			return false;

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Chen, Gu=
chun
Sent: Tuesday, December 14, 2021 11:17 AM
To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Russell, Kent <Kent.Russell@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: Access the FRU on Aldebaran

[Public]

+	if (adev->asic_type =3D=3D CHIP_ALDEBARAN)
+		offset =3D 0;
=20
 	if (!is_fru_eeprom_supported(adev))
 		return 0;

I assume the logic should be adjusted. It's better to put the asic_type che=
ck after is_fru_eeprom_supported.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kent Rus=
sell
Sent: Tuesday, December 14, 2021 3:34 AM
To: amd-gfx@lists.freedesktop.org
Cc: Russell, Kent <Kent.Russell@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Access the FRU on Aldebaran

This is supported, although the offset is different from VG20, so fix that =
with a variable and enable getting the product name and serial number from =
the FRU.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fru_eeprom.c
index b3b951fe0861..124376b666fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -56,6 +56,8 @@ static bool is_fru_eeprom_supported(struct amdgpu_device =
*adev)
 			return true;
 		else
 			return false;
+	case CHIP_ALDEBARAN:
+		return true;
 	default:
 		return false;
 	}
@@ -91,6 +93,10 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *ad=
ev)
 	unsigned char buff[66];
 	u32 addrptr;
 	int size, len;
+	int offset =3D 2;
+
+	if (adev->asic_type =3D=3D CHIP_ALDEBARAN)
+		offset =3D 0;
=20
 	if (!is_fru_eeprom_supported(adev))
 		return 0;
@@ -139,7 +145,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *a=
dev)
 		len =3D sizeof(adev->product_name) - 1;
 	}
 	/* Start at 2 due to buff using fields 0 and 1 for the address */
-	memcpy(adev->product_name, &buff[2], len);
+	memcpy(adev->product_name, &buff[offset], len);
 	adev->product_name[len] =3D '\0';
=20
 	addrptr +=3D size + 1;
@@ -157,7 +163,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *a=
dev)
 		DRM_WARN("FRU Product Number is larger than 16 characters. This is likel=
y a mistake");
 		len =3D sizeof(adev->product_number) - 1;
 	}
-	memcpy(adev->product_number, &buff[2], len);
+	memcpy(adev->product_number, &buff[offset], len);
 	adev->product_number[len] =3D '\0';
=20
 	addrptr +=3D size + 1;
@@ -184,7 +190,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *a=
dev)
 		DRM_WARN("FRU Serial Number is larger than 16 characters. This is likely=
 a mistake");
 		len =3D sizeof(adev->serial) - 1;
 	}
-	memcpy(adev->serial, &buff[2], len);
+	memcpy(adev->serial, &buff[offset], len);
 	adev->serial[len] =3D '\0';
=20
 	return 0;
--
2.25.1
