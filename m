Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18B9C76196
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 09:38:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6148E10E0A8;
	Tue, 11 Apr 2023 09:38:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 257A010E0A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 09:37:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJ3GO5+/azRp6+Ta87WwxfqnG3/nmDQBDuKBk2ivixorO0zL+cR7lrFMEbwVZpA57rHHylpB/fE5X+zAqR2M5gpBsl8jlm5SGF6RDAd+D0AgysC2apThAJqTDgS2qa7SFXmoruK9st+P0Ip6dd5rh+NYBYNMNB+Ln9jQAu+uKGkOKZ8us1hmheiDstxLiTo8YY+R9bDR4bJztCPGqsdT+47On1UoVglfLg4zmLa2a31ENrr7GDtH+aZ2pAHOjqi08HJKEtugZGmrUQ2lI/7u8qaBURZ9oxqS3Pz/vKeUXu4o02wg/WbsIkjg9iqvthrLpCexavAyGFWrXhsRsIuBzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31y+QKZmc+xF1zjlJouXnjxTgMgFVFgr2JC7b7ounJ4=;
 b=O6eBAB9dcj5t84D3tYgA1PcYGOmE4czoA0gFy/1+ZvqXMIoCO+jsfY2FKU6ft39JWD587rf8Td4KIcg6HyuLr+C2nSriwEAjqZIsqzI3IoH6j5RQ/aqv+rzUb3UQbnVKVeNzZEktY9g4p4F5c8Mvf4S4Ww66EiyqfJsj4pjVBQ79e91RiXHM5kftKQj2TMpOx2bSzuBK/2ovrXo+1CaXUkYEEeTN0Jfu5skoCz9lmDY7klAy/IgWrWenBHLpUfmLRIzVTI/1DuNYyjRL3LSy05l2Hrn5TQVf3u7KnkaGVJSE7hpvbZXuIFAEUgqYeWrXjR2Fqqkf3FFpDR0qXrJbKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31y+QKZmc+xF1zjlJouXnjxTgMgFVFgr2JC7b7ounJ4=;
 b=ThjjKFAih0wUdjbBZZqDFSh8fFarsYu9xTYGxKIP/jh+I5ZPRA82kO/sxrFCKRyofbufhPnXCwBhLE/Awiv69RQIssXSdssGBVD5HxP3GevWFWNu1tBPIP7KgC1RLAZ3hmSKEMnseMdVzQ0+Q4V5ySqB+JWkQSDYdXU27Pm1+Ys=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ0PR12MB8089.namprd12.prod.outlook.com (2603:10b6:a03:4eb::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Tue, 11 Apr
 2023 09:37:54 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6%5]) with mapi id 15.20.6277.035; Tue, 11 Apr 2023
 09:37:53 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Subject: RE: [PATCH Review V2 2/2] drm/amdgpu: correct ras enabled flag
Thread-Topic: [PATCH Review V2 2/2] drm/amdgpu: correct ras enabled flag
Thread-Index: AQHZbFiXluOgypcD60qmosUadOHCQa8l2Uqg
Date: Tue, 11 Apr 2023 09:37:53 +0000
Message-ID: <BN9PR12MB5257EDF45570B2244366F7EEFC9A9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230411093241.4644-1-Stanley.Yang@amd.com>
 <20230411093241.4644-2-Stanley.Yang@amd.com>
In-Reply-To: <20230411093241.4644-2-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5cba6f3b-9631-4bbe-a045-5a0f1e94de0c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-11T09:35:45Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ0PR12MB8089:EE_
x-ms-office365-filtering-correlation-id: 4b4a74f4-6692-464a-ca7f-08db3a706c83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kDjUgP/GlXl9ZFMn7AEmSNiO/W1RYiij170leg9zwBH8b5On9ClLXyDNxwzdsWmaqkOV4A1hIOcxvkAsvQwYOkwC1PAdY8hXDNnIuo/MxyabqVLzZigxQom0ohBWV6L1hQsexUpWKPFclVkMZxfMDHewgTro15W6k6bmg6zjC7zR0aoioLnFwCVfEyrYHHpr+SW6PEtMVAGJh9/4o8wMBPXp59LW7wiDLyqw/9/Ni5UC4N5DxL4CmprL68t2JZ3rh+OxZqre587ASJ1il0nLE/8qVg8xZt2hPuLFwV6HFJvuODgeFtlLwzSTEyeS/q102p+YKcuZAsc3QvWfaCBTScjj4p/YFx/GaGzhqPEIqqRbKa2SkmZEFQLBjyCdyeb2+kVeOyYJyotbty7aj/2fnVWeXlDkdCN8dMXWX7FIJUhNbfeuFMjeGTYM/fPJCmrGBsUnueRtebdCOSciZxINNnFLC5Y0hv4+FBNqrXKpJhNVm1e56idmfE86MgdoHwTbgW8zdox5OgXn0L0bToZ/CG83GqEEl5cy6uCwre7N4zqzmNUFDGPCJ9MP4597TvfbiF/IH5kmIAk6hlHv6rOV4gSa9swBzxniequ3D1N1gmaz8ZZURf0GWwzquY4IAAEP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199021)(38100700002)(33656002)(122000001)(64756008)(52536014)(38070700005)(2906002)(5660300002)(55016003)(8936002)(86362001)(76116006)(66476007)(41300700001)(4326008)(66946007)(66556008)(66446008)(8676002)(83380400001)(6506007)(6636002)(110136005)(53546011)(9686003)(316002)(71200400001)(7696005)(186003)(478600001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I4z2LIRv5ip+vL9SwqbcbIA14UocN1XqAKqe64GWcfzDPdz4TBweid37XWL9?=
 =?us-ascii?Q?ciu2znfzDQM9SJSjbkP+Px3Z+vJdiESvZ3g9jngyr8MKijy1kt7XKrPZAd/i?=
 =?us-ascii?Q?SAOJDyLpWVmT8PC+qe19jrhRzFBpcWpmPjxnCJ0jqIo/4NZ0UZdDnkXWMmNE?=
 =?us-ascii?Q?Ah6IfeSppAVyC76ALfaOHCJK8ClbL8xPJJ0lkhAlv5FfoZfRmNF1z++DRXYE?=
 =?us-ascii?Q?jkjqiAsE1bNcmeV/PHS6MtPRY13KWZAZWl4sG/oshd8cTm5GSRK9T+l3PrEB?=
 =?us-ascii?Q?WjqD0dR61sYYDcTl9SCPwX2dnHeqGtebQVrI7/X1opkfQCKXgHcMU/SWadL5?=
 =?us-ascii?Q?7w5yLOZXjODi3pTOE/xq2gqkapvT/YFCUkg9QicvLet5nPpxs4ZKeGMaFRLe?=
 =?us-ascii?Q?iH5RxpVYdh10kGXc/9p4NkjktUGRtdMYpDKFg6eCnk0UHHBxALd8CLYnUgQW?=
 =?us-ascii?Q?2UuQxg45Z9twqXgSOmjEjG4BnwIlh2sF9HV38UIx17X1aTOl15Qc5r6Q38AK?=
 =?us-ascii?Q?ntcnx9VuU21py/zBOUWSf2UUCuP1tQfThBMEaEGfojJ+brHZEUXx4ADONQ1F?=
 =?us-ascii?Q?5Qo8bt2k4j5OVNHYaCz7j85EvmWqq2L1v1oryZh9XqFoukYW6jeY0SrFuNzc?=
 =?us-ascii?Q?TmWZIxTkviy7WSFcoGW7/YP0WYEmRvaGz0E69VQdAlZ21PXFRGJ/B1X7DXji?=
 =?us-ascii?Q?lrqwjrFGX7lzH5a1X0hP7vNagbxy1AElF3fLo8Kr8Qxr1xm2JbX2OdLEYmux?=
 =?us-ascii?Q?NS3ohUG15BixA2XOeXXmPLTx+dRp5RkxmV8TS+aBQTs7lPWz7x10wMf4J7PA?=
 =?us-ascii?Q?kaw9vWFO/cbb82TY5r1Qbx/epaNW78pgko0JaoCOz7zaeT4zZ1OFIgswtX86?=
 =?us-ascii?Q?0wzXw1inLyujV5vVBuPVtaO+lslAsdVSkzO5GuaE4+G4quiG20Oij+heYxcX?=
 =?us-ascii?Q?Y8WbqN1ik6nmgpND6V50BZm/7J/D2x2eZYU2guJ3O1JIjr0auqHcqREe0OVQ?=
 =?us-ascii?Q?/9GKpYchBkk40z1Vqo9OFd1rLKFtgj1rKjPK+nIh/gvEAFN9RMVcwJPkWZGZ?=
 =?us-ascii?Q?hnoKxfCi6ffwUZLYZLMHaLOORuIf7AJyxdrUT/rnFe0vGwUkdW9M1SFt2CiR?=
 =?us-ascii?Q?WqKugtVyr4Qgu97vDodBMG7YgvVVKVqXGIL+H1BQLPyPaX3K97fWXpU5C34i?=
 =?us-ascii?Q?bsnZqHKPS3dWX2nYRK/TnkuwyHWoDSdoBONOpa9QuwTuRnhm954w3pNz920e?=
 =?us-ascii?Q?ATDYKZsXhVp2xKecs4zbgsQ0iJLXoFWQoXoWHWffMWHZyML3Rx1EgY6L1Jrr?=
 =?us-ascii?Q?M9ri203DlfASlbZmqVGjAf2eUuSuXVlKv0ue901WRpOu8Kv3PEY8/RsecDW0?=
 =?us-ascii?Q?lYM+msimfZSVWDbyneCacz4bLXPuJjNjs5aBSNwDmOQyS5A0o+d7jgrq/6Cq?=
 =?us-ascii?Q?mww+hEzvx2+FR+MuEhHSp2KK7DHcu1If8Q/iEPeM3tYg2EQ3fSlQnG+WPk6K?=
 =?us-ascii?Q?PoJ1IIium3Q0yWXPCC+JWi5i44sv9ES59guWViToImBXlzmB68/VeGHketJF?=
 =?us-ascii?Q?gIbw0Lz5WeJppU8DIjavTUEsZWp38F8IjPuuwEIE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4a74f4-6692-464a-ca7f-08db3a706c83
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 09:37:53.3897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ozS3KhSc3dVYtS4ulnJ+Lu2KcK7ICEJ3Fao0T4c+5wa7zotfru3R0gltD6z/MMvqRJ9lVPRO/khmbDYPLki3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8089
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

You might consider use ! adev->gmc.xmgi.num_physical_nodes, apart from that

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Stanley.Yang <Stanley.Yang@amd.com>
Sent: Tuesday, April 11, 2023 17:33
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Zhou1, Tao <Tao.Zhou1@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review V2 2/2] drm/amdgpu: correct ras enabled flag

XGMI RAS should be according to the gmc xgmi physical nodes number, XGMI RA=
S should not be enabled if xgmi num_physical_nodes is zero.

Change-Id: Idf3600b30584b10b528e7237d103d84d5097b7e0
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 4069bce9479f..c2c4d978896c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2430,6 +2430,13 @@ static void amdgpu_ras_check_supported(struct amdgpu=
_device *adev)
                        else
                                adev->ras_hw_enabled &=3D ~(1 << AMDGPU_RAS=
_BLOCK__VCN |
                                                        1 << AMDGPU_RAS_BLO=
CK__JPEG);
+
+                       /*
+                        * XGMI RAS is not supported if xgmi num physical n=
odes
+                        * is zero
+                        */
+                       if (adev->gmc.xmgi.num_physical_nodes =3D=3D 0)
+                               adev->ras_hw_enabled &=3D ~(1 << AMDGPU_RAS=
_BLOCK__XGMI_WAFL);
                } else {
                        dev_info(adev->dev, "SRAM ECC is not presented.\n")=
;
                }
--
2.17.1

