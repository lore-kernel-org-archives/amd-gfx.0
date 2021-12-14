Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B73C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 03:16:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28CBE10E813;
	Tue, 14 Dec 2021 03:16:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ED2610E813
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 03:16:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8Jz2wDpMpi4/2OU8qjJUUfH0Fn7t3+/XMnQkjIb67JtZvlHDHUlakKtFZ0nEGH3l4hVRPT2PlNCd55Q6OkElv479EnuJuzrI0Y7vKBYQqAr4C6WvJmmSbzbBfBtecaeptC3NOThFZyrGMripO6QgH/ucDDyxgH2noxXmDGLJlmRF+PAWHM0KRzq9GoCBiNN2QYEyWjoSuI9kI0AEmlGzH3vbVhFYsGoatznlyWLHuO7VXbTB4oUJa4vUgUcSC1rFuQuu2b6vD5NQJwGjry0Fm9GdIyot5giYf8YZ4W4tsrrvQpn9guyAR4yAnICGLLKoXIW4v9TPkajQQDl8VC4Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPgqPMJTu31m3h+xL6dOF46g7yfCfSYW5Xwo5+gNfl4=;
 b=Jn5gqa4cYz1JsF3Wak/s5lD96wCYR5rtC2gsGrshxv2TVG11tfvpK+qnsGplfQF+w3ELx9mjn4S+HiMvaTzvmS6uNklIzANmJfIPCHy1PNNNY0Ba75BEHH6JG3ai9SHJc/zgLQDfz0078/SGs4SaGbGmxZLRBg9/BBwkjJfr2HSaxHI/Iq4Q5GrvPNakgNN4enwF7lNppGvwHI9pMHypm5Y48zKRtmy33n16EetMn1i38BomoL5x8YZqD04CgXCeOa1LzUFz4ZT8gzhObT+afPhWbvrrB5Y4m0hwFMra4sbQi24BoJCJbsRMMAUYpOKEwS9R3cBQzaC/2IdiUihLLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPgqPMJTu31m3h+xL6dOF46g7yfCfSYW5Xwo5+gNfl4=;
 b=C0nF0MVN0wsyp14VIPvq/qvlLSNpYxuho3fMHp5EAKV9lLNWAG/jFZ4/sYc3eWwyHObnPrmctYi33gNZgXhqpeGLSykoD0JFTc1mA+275aCqFjcwxIb0kpv0ALPQQ4MZhfg+TGMxjauAAM0IDna/Ens9vY53oVFpMEe7kRv2nqM=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB2892.namprd12.prod.outlook.com (2603:10b6:5:182::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Tue, 14 Dec 2021 03:16:52 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e%5]) with mapi id 15.20.4778.017; Tue, 14 Dec 2021
 03:16:52 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdgpu: Access the FRU on Aldebaran
Thread-Topic: [PATCH 4/4] drm/amdgpu: Access the FRU on Aldebaran
Thread-Index: AQHX8FiFJ0cmjAHNmUSSO7lZpleR6awxUPZA
Date: Tue, 14 Dec 2021 03:16:52 +0000
Message-ID: <DM5PR12MB24693785E4E9F4543D5D60EBF1759@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211213193402.96278-1-kent.russell@amd.com>
 <20211213193402.96278-4-kent.russell@amd.com>
In-Reply-To: <20211213193402.96278-4-kent.russell@amd.com>
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
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-14T03:16:49Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 447d987e-7401-4279-8d3f-7b1e01e02c68
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 556e5432-3f30-47da-d9c6-08d9beb02cc0
x-ms-traffictypediagnostic: DM6PR12MB2892:EE_
x-microsoft-antispam-prvs: <DM6PR12MB2892E777166BFB2589F601C0F1759@DM6PR12MB2892.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UKfAmEUp/nGkTd/TfU/j2aIsCimNMPdK/Hb6FwYYhu6Rrra02leWPLuuKsa4T4lCHO3E8rZKVNS2X1OpdE7YpMBvgvpEQkIpDLUJad7PPuuRk3gwUPC6SG/KfzoUSEblcAMA+3SXtNo81qHgIOqeQV5q0KPw7uWxp4iex6gDFGujB22kU9v5NK1T+S1sY3QzPxbIq9pM7yRUjwv45i8yq0548B1RCpxF172hHbx9Kf9Fq8Ov+BzaIVPeABwgdF/c8r+smVEnVSFmeuVM681sq7pA31PBBnYpLWkTpE1zVrv7VQCg+hQyM4XJ8duiKKoz0eZGdHd4I8KjvaIJpZeLv08sZ3XVnO58e+Ho1qr3VrjTFDO+Rq/osl2cC1lAdxnBdQhVuXo59+Zngov35BJDpie/yogWEMGCIWnmYTv/vvAs4QIQuEczwjIhIb+qHMWXjFbBQ4rbVCOucwLd+v90C+6N4HZjGdbz1mkjBLzyMQIt4rYd4jgMDmMQQ4tO0PBemmu02qsy+R8NDV8rtWaUUY6bWI6DGrTnbMjmUV36lzk7499AxC24v6fM5n2GtHnLIU4/smCPx+Nu5gxTvHnbEFoR50DbsVKpaPTKEZFqlXhNPCQ2QbOKiz9ulPzE/Hx6aofHZibY5RmrbdD816GZPmVgkFoyl99u10HSmfI3weV1sLe07OiOFQBdWWmQO3BdWcYz3yPtaYMvvx8PmOC0RA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(53546011)(2906002)(6506007)(7696005)(122000001)(83380400001)(38070700005)(8676002)(66556008)(110136005)(9686003)(508600001)(316002)(33656002)(4326008)(66946007)(5660300002)(86362001)(64756008)(71200400001)(55016003)(66446008)(186003)(26005)(52536014)(76116006)(66476007)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sJeotjxjJEYdncOkQUdm1wCrY+NWeEUWi+mnw7jgkj9XYwfSoZ0j7u8w3kp2?=
 =?us-ascii?Q?TSYxu4GCMO18cr4CEalOOlRcB3yPWdVOUw9q16Bk7iHfGMeiaprfHaclpuKe?=
 =?us-ascii?Q?45aCjKRdAwTF/Nr1fcUhcnDbZB3KVw7+tM30lQn6eHxO/wkdCSInMAXsBIM3?=
 =?us-ascii?Q?/fCsGzykm0wUSizY8Iouo13gkq2zRlvvZnvPXz3uNNZxb2wjZOmvwyS5nhWE?=
 =?us-ascii?Q?+gVikVH3w3pALsoajyp4eYVF54hLXiIs88c9sF7oqJfzaWk6v2qDOyuEh4cZ?=
 =?us-ascii?Q?l8+rKBtlskthwTHGaNoRxdlc4HX1QhrbevWcN9Fqk1KlY4j8Vte9tAvT84J2?=
 =?us-ascii?Q?dyHjkac4FHkC2Y+FdKQJP+bcFEEBDjFPicREMBEGMauRbq5QFOmUHTRdI9LT?=
 =?us-ascii?Q?nPlrprHpmeLvrc2VvucmJ4SQHLUjntvENoqsfP11vS7tqYA9RP4vMomdZiba?=
 =?us-ascii?Q?Xnz0c5HGoKfCWkgMwSYE1sRv03mg7JdLrdAJtiEJ+7j1gJ25Zpo1I/L+b8E7?=
 =?us-ascii?Q?6RvywyL9KLZckv+jYldX5D7qGhwxDIGCXjQb1KhI9lTAu6xhR8TP+ZSRDDQW?=
 =?us-ascii?Q?8RZruNvRd3vvT9jVVM6BWZmM7NWrf4hA/RacsxuipXpCoEcGiQDviceecuuA?=
 =?us-ascii?Q?bQ0Sjw9rvT92STKlrPer2kWzYxhpZBYnYAIxNxm495EiqvF8z/nafRF7fm7F?=
 =?us-ascii?Q?E9ZmRZCbdgjkP9A9uekCaRlUmozNBM66+eGj1LnQpFnwrHLvkNaJRxIAt3Gf?=
 =?us-ascii?Q?LdCncA7RDuFljMBy5QhA/ydr1kPAMAKkkKiJv4DRiR2sID/oTnOOSGTVoLmI?=
 =?us-ascii?Q?3/wkO03OLdF4z7q1cH98km4yKgVq47ZfHLbvN2YpmG2bTrkjZHzHd/jRVqbo?=
 =?us-ascii?Q?Mg6mEm1QMWIr8MBt8rrRJ/tY56Tq53N1U0Xia8w2EXJUcCSneV062C6R6NZq?=
 =?us-ascii?Q?t5INkglzfQxHUmTZc2404DQjIP+0BFFCC2KhqPAffgoTsP/4OXr0dc1ccYlk?=
 =?us-ascii?Q?sU1IsjANKdxHLuTY0sprQ8rTdoFjO3D5FIB8iTGvctxZPfMSmmFf6kGKOJQS?=
 =?us-ascii?Q?IOvrerOiI7MCcSbbwXvYq8I0bZk4kUPXMPf7EnzhD6KP3t+QyX4OkWcdcXVo?=
 =?us-ascii?Q?yIUYqCG+UmLr5dkkBMryJrs0mWT4c31HSWRkzzltmmvR6y4nu3yog6HzMwUX?=
 =?us-ascii?Q?K/2zQ9cmmeFaqOJvhYIwa15vAN4ubdddSwEda0lxsRmHmiQnDWznogZ/KRTC?=
 =?us-ascii?Q?oAVcqXLAw66fwzYLvz/D+tG8G9wGicHUGFzUnh0U0iE9hwcPNgsTdvAvuitI?=
 =?us-ascii?Q?HxXxpzGNJkw1/Lh5+uCtMdCqd45xxZ6avDDnvDnm8OQFIr5Zinvz82QBflcQ?=
 =?us-ascii?Q?Im+7ylB/S5y2iP20I+pLn2rg13A5hqyG4KmoW0FULEn4BXNNJt5WqaKkoYpg?=
 =?us-ascii?Q?ntrbUI1dQyp1/TJxWuLxFL6Mb0TyZt7oybDZSyEsHlbRdvSyazKe0zBr8WBt?=
 =?us-ascii?Q?H4G1wGFNKDslVr54I6ATMmkCh9DeCOzNKeCWEGC/aYfQN3wUFm0rl5LFw8yN?=
 =?us-ascii?Q?Xix5ybioTDhWV2L+SkigpinUuYvgUsDT09Dxkym9zhIZ/bWoDFEIiT4ofZLN?=
 =?us-ascii?Q?/Cf2cjRgOYxdlpQVDKQX5tk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556e5432-3f30-47da-d9c6-08d9beb02cc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 03:16:52.2431 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ym53fHVajut7M02fAfaXQAywDjHerECTd6TJdDzxxQrUnbs1K2JtirwnzBFzGAlfcyeQJ2D3Ai3tn7REkz0UKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2892
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
