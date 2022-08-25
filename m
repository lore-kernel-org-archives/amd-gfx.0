Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498C1C04AA5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 11:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5979B11340E;
	Thu, 25 Aug 2022 11:45:32 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B096911340E
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 11:45:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcznH1aVtcTcpLQImKrqn3x4lQvhE0p2ynNa6dtV9TPBPwwJ5+WwJq/uofwbIKvdQ+3+0hcndVUgmNMbE3WDmwgMZ9+jfC1L/Ypov0Pej2PJ0c8pIz18QT1M5Xh+jwpndg2X62WxIrMWE/DyRQEapFfikf62BtYdGK0Jr4fScdi9iBOFil9kkIrxR9pDW61Pt/pKLFl51NXynS0Z9S9yBVDoGDv6skPBj0SH1RWg/yN+W2z3I75A8z/c8pUyxLEPvIhyHlV8OC3VYVSUFVYFfHEZoh2BBKsqIBBOJwmFIUzF1aLnMQC9dzY0ngGwjbjLsMmggjlKLNnrlWUEx9Koiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ks+05fhargt9jUUUFQ953Vr23igdJwJJCD9tOgIFjF0=;
 b=GbKfAVZ/ZEANT7wRgP+eMBjoiH33igZUumXYQQ8JEnHQ/SGTCm5nYmqjYWFXVikHvmbhOz+SIFNOMSilR/vw1OgohiaQxOEFHqqOXxXNpd7Kdhv00l1SDtSqwEwZISG8W+U9H05NlBd9D4SX6ikeERx9YwLLbyMvFWMCWGGzW4klbNTqq7x0fA5/pQZQKqIQr4hP8o6pXJvKZ/bdVnZPROIlEXUxCZo4VEamTG7CXI4DCVcH3Z1fR6I5dZqcfmJpyeBy4wI0vdg+n5pAKvTX0b5ZFbuqZNqANjjmeQBR613n1YVz+DJQ4ox1sHx/KB9W8wKtev+Kk/t+XnEbso+1Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ks+05fhargt9jUUUFQ953Vr23igdJwJJCD9tOgIFjF0=;
 b=R71SKS0i6wOs/xQ+EMgZGofHPd+7IgMuvdbmnvTozUYnhHjYmW4ZfN4kUtFDPK81b0BTM+HGmySN7v0WSahQIrRusQJCNtvmfPI6TMf8UAmbXOpiLEdTeSMWu+Zv2XaNNh4tbM0rb0a0nKTrGIkg4iW9QO2LziagOO7WSMST2/w=
Received: from DM5PR12MB1308.namprd12.prod.outlook.com (2603:10b6:3:76::7) by
 MN2PR12MB4797.namprd12.prod.outlook.com (2603:10b6:208:a4::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Thu, 25 Aug 2022 11:45:27 +0000
Received: from DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::5097:87be:3557:c681]) by DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::5097:87be:3557:c681%5]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 11:45:27 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: disable FRU access on special SIENNA CICHLID
 card
Thread-Topic: [PATCH] drm/amdgpu: disable FRU access on special SIENNA CICHLID
 card
Thread-Index: AQHYt8re3CJ37EORFkKbJePGiPtxx62/gHCw
Date: Thu, 25 Aug 2022 11:45:27 +0000
Message-ID: <DM5PR12MB1308A9805F748409E4D8441A85729@DM5PR12MB1308.namprd12.prod.outlook.com>
References: <20220824150351.247048-1-guchun.chen@amd.com>
In-Reply-To: <20220824150351.247048-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-25T11:45:24Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0e00596e-24e4-4253-80e7-95ebba8b7d08;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9112cb77-ccfd-4937-97c4-08da868f4de9
x-ms-traffictypediagnostic: MN2PR12MB4797:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fUKFNOgCEaio4tstR3DcQ5kQhsOrGkrtWIpGgtu/vBN+g04rM1RGCtwg3wvWVuYMnJIOURucjiUIJH0/zCf4mywm/7KiX3q1ES58M/AlVH+RBqcsuzI1Yrmzv4bnRL36IQWJ+X/HeGNz+hvJUXBHJtPhblTbWJwO0nqr3VG3/LhopI4/L4/usAeuDgoe0BuX65DOPhr+NatQr2bhC7czXa3R45cDaz9Hgt8k+dBsyMYLX7Daou8fTPHqx3/6UEGPfe/p4OQpBll3Xg/a9QG/sHZbV6Ioe42zMq++vu1vVYRts7wAK1R3Qb4Q1zCs0RYFAfqAPf2NMrE6USuRIS70MRxjh9gGkuvlsMkfqIvFcirEFCxutPFZqziK2FqaQTl/xQ0u6I+N34i4HErQ+niD21SgDenHT5HSjd/GhnBNP55FQ3h/EirDb+OGiQliQ6Nu7dQT+jxJ3Sy17P238VEaSPu8Jw3IttFesVTJvR/wr0eecwQOYt6uosI1BTlWhNEYSi78g+6UTiP2eGQSup/S3U9beCANYoBVMCMcsCxdYBLWIfROdFjUZNNsX+KIaEt94gD7mlHRYdrcfpaJfXij2Zjl+3XWalffcR5wB2iY8P3ZfbS7zQV04wscNLHBGL34cLfkhraVkHU7ejmWqBdbZjad9sU8bezKbRlSk42cQt6DenAbOOYpHzS8DyBjLn5RCIn2861Do1CpMAlvdq6utyCcXjS9+2EjT8Yr60amiyO/FZlX65Q79B4xwXqJOi25PXB+pZorPYeYq/6fbL5rFw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(478600001)(52536014)(110136005)(6636002)(2906002)(186003)(76116006)(8936002)(33656002)(8676002)(66556008)(66476007)(66946007)(64756008)(66446008)(316002)(6506007)(7696005)(55016003)(71200400001)(86362001)(41300700001)(53546011)(5660300002)(9686003)(26005)(38070700005)(83380400001)(38100700002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fnE5gvf7Ow59lQro0HI8JMxlVVe29/G7Zas85DqVuzGkyUcDM8llzNWcO+Se?=
 =?us-ascii?Q?OMZI3Zvs56cPlsVegjePMMhUhBbPCXzWu3XdcBcY0MoC+eVyoQav2AYgDxSz?=
 =?us-ascii?Q?AVedZzaE7ptEUMWv2nlChB5eEOxIyw+SDrMX32Qz5GTVPE6glWTtdHWL1/sx?=
 =?us-ascii?Q?xRwbAW15vwHO0gwVsXy9RQgS+KxqFEJd5zjz8eiYHioaVzfZ02v6PXD23RRD?=
 =?us-ascii?Q?3Pe5KOXCPM+pmZiUd7brEp52QOJ4/TOsJWiLRxjUTWPv/4Z6IcPVxkAlcIKs?=
 =?us-ascii?Q?P7mRuz6SaChcxj7PsMybP4iNNevXRIiG+aLrmO1cKm1bTzXL+P6RSbM/9RNh?=
 =?us-ascii?Q?RYAaVOhY0QMvRwpKEfM91QMNg1H7Cj1AruE4MRbqvZ/FUaXeyFGuL1uFpfh1?=
 =?us-ascii?Q?RLiHg7vvZ9USlEYzbdBG04qvt4T5y1N+LsRgfW1Zwzy3Ltk178HHXDE3MUhB?=
 =?us-ascii?Q?sJjBEsXDAwIWB0GCOr//0Fm8xkLXadbG0xj5JkPmklafy9w+tQtLB8yNKNTb?=
 =?us-ascii?Q?EV/Zy/yBuy+V+jg1HEK/VOtkFRHziA9rQew8Lzwb8EhLDa7pAHN22l44PKOv?=
 =?us-ascii?Q?VO1laNM2Nj8twLlCMeDkvTkxDaS2NNG52SNZ9R4eAVOkMPR/rTSk8pktBzEc?=
 =?us-ascii?Q?c3aMXm+Q0J+5imDGGo5q8jpgSyXXbJgen3HxyRMYrTdBW10qYQzZSPsMAwOs?=
 =?us-ascii?Q?dVecKXzDXZJNCTG37ISWtmc9rs0J+FZnjHBc6IGHADEUseRsSNvqwwMbexzF?=
 =?us-ascii?Q?/BmDAQ+6nl4jFUD5PyV4/96/a1YQvIZJRUAmAomIvlN9LgcwFhX4S0tWPmiO?=
 =?us-ascii?Q?FaJzZep+ojc+YC60NmgjAnY2vXpDggNDuZYDCwSurJ+iC2xf4L1Pc3LgABwp?=
 =?us-ascii?Q?6Ef/ttKdEYi9djpA+5aNIp4a4KcFw8yrG9T+/96pcw/nb5z6bwXCJE0MUruY?=
 =?us-ascii?Q?lQARZ0NjNCIUi/8Z1+HhLJaU4XhkvtXmB2Qnh64WhP32RDkFx6D649aDqyNL?=
 =?us-ascii?Q?PQxH354KARBGwZRQj0x+p9c1z+HqCrW+9kCX5ecBzyWjdzZ7XwkYB4DVe8i+?=
 =?us-ascii?Q?53A80oscUK9b2sIM9N7bm44xaUKy8BiwPeolkZzvubdCG/ZNAsbiJXXGj2p2?=
 =?us-ascii?Q?Pu0gqw+WdgpefmqX7qPbjBj0GEBNStwTVIAMETKGbcz09pCyI9CHTCvaF0TV?=
 =?us-ascii?Q?hIm5Kkv2x/E3UxjiU/csCsFCMJdJKKeOk0SBgS3KyS3/JaR81OAUwQ7UBEkz?=
 =?us-ascii?Q?GKRlI/OLtnT8MaquhGLQ+FjaFUpWk61Z/zKi8B6Vqq+PTSPTytMyrXlqsBDO?=
 =?us-ascii?Q?v0OuG7TkUko5qZIr3/8Ov0R15PcSZFp+pfnO7qM5iLFaUkNt2HGsEZFztVpq?=
 =?us-ascii?Q?3vDJPycr5t8+TF/QC6NnXivRfgzXyssmr8SGYPfTz8le6KRO+DN4qmp2B/w7?=
 =?us-ascii?Q?HBMSdoF4wP42sWNfZO8QRfrROynij0DYMUJCHPvw8aKOTLXpcH7IGhk2iR0K?=
 =?us-ascii?Q?Oy7hLifelZ2fNG2yN1VJ120K8xRvZ+dMnyONOeGuhlmc01ZaJbtPHY6ngTue?=
 =?us-ascii?Q?SU2bXdtW/rVRbbASXsc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9112cb77-ccfd-4937-97c4-08da868f4de9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 11:45:27.1789 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mTvQFKZuqHsAQeBfgLnCZ3sYZf0NXg0dKFxigVFUaq5BJSr+u2yqXxVXOwB6JaLDLKI9MtSCB1GsBEp4n9u6iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4797
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

[AMD Official Use Only - General]


Reviewed-by: Kent Russell <kent.russell@amd.com>



-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com>=20
Sent: Wednesday, August 24, 2022 11:04 AM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Russell, Kent <Kent.Russell=
@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: disable FRU access on special SIENNA CICHLID c=
ard

Below driver load error will be printed, not friendly to end user.

amdgpu: ATOM BIOS: 113-D603GLXE-077
[drm] FRU: Failed to get size field
[drm:amdgpu_fru_get_product_info [amdgpu]] *ERROR* Failed to read FRU Manuf=
acturer, ret:-5

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fru_eeprom.c
index ecada5eadfe3..9d612b8745aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -66,10 +66,15 @@ static bool is_fru_eeprom_supported(struct amdgpu_devic=
e *adev)
 		return true;
 	case CHIP_SIENNA_CICHLID:
 		if (strnstr(atom_ctx->vbios_version, "D603",
-			    sizeof(atom_ctx->vbios_version)))
-			return true;
-		else
+		    sizeof(atom_ctx->vbios_version))) {
+			if (strnstr(atom_ctx->vbios_version, "D603GLXE",
+                            sizeof(atom_ctx->vbios_version)))
+				return false;
+			else
+				return true;
+		} else {
 			return false;
+		}
 	default:
 		return false;
 	}
--=20
2.25.1
