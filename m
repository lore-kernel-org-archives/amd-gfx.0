Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14CCC54E58
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 01:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51F3010EB96;
	Thu, 21 Mar 2024 01:30:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ig9D2DJW";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D29510EA29
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 01:30:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIj6orcjjVYqkBwznvjzWOwtEC4LrVn5wxBV/SUq3zh+FilYdcIlGYyo4lZNjh1kt/JYC4iH/R5h6WiNRLNds2PEcy/p+bsO6C31ZOQ6UPPpUqd+IC/luZguPn6nCN1z1PgrO3fVmpvtz+dNJHlrd7POUV0ofHNlMpe35QkVS6ELUICpbcIHZX7XsoMV9D9fE2C9UI455c8Oqa26ElTa1UKGTn33AYaqwocgb5HBIfZR6p0TrQlF4frMtp21cR4oKZN0PKM9CswoV73c7JPx192q5F/N2aUMrPN23UOdujLTKfSd7c6ItH9B5JO/wsRK379dn0qz6BCMSXFmirHrbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNkP0aVj/nBCWxrG7piL/9q/PTTW/Nw1kEFJR8O7MXA=;
 b=ktcDAyDCqQAjdNTrg/2cCcg1sYSsZzfO8TABvrZFATt1+tvMCjS1B6WZ49mdv/iiIoGU2AUih40c6KxCkx471/7BmybKJJ6fNfrgq12WjaKoyX3I/iwd6oasIZqSDZQ5ToLmy1PtgvN88O3O6OQCgtkjhJEcTafjl7gUQ91xcrbYXNxJhP9EvqjfY8Wq9+t0EnHMhloEdrJQ818zLTvgjCB3TedTt47mYD1iAcmEG3088bJ1Bcmtl0jC5+7/WA8Ect2GhiSGTMYOVPS2bS4a0VTXJxqZelCFDKsHeZhegUV1i5MEn8sEILddoO4Zg/pd0rzrRxEqBDZPYx/z9it/PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNkP0aVj/nBCWxrG7piL/9q/PTTW/Nw1kEFJR8O7MXA=;
 b=ig9D2DJWZ4eAMOj3Jy2Ucg8RQ46sJNWbirVYpt7+TfZTwIqBTG+rSSADrr5ViZ/nxqWhKxVKYy+z5l3zYoJkfDs2/Q9n1u65J8BOSurs+pgiSnOWlaj/VDpKTnwmLOng6efnFYNfLLcgogrGH9eMk4Q98/eoML9B69/UyjhdwQk=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by PH0PR12MB8006.namprd12.prod.outlook.com (2603:10b6:510:28d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 21 Mar
 2024 01:30:27 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::ffd9:2592:5d85:ef60]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::ffd9:2592:5d85:ef60%3]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 01:30:27 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: fix TLB flush after unmap for GFX9.4.2
Thread-Topic: [PATCH] drm/amdkfd: fix TLB flush after unmap for GFX9.4.2
Thread-Index: AQHaewTDIxwsyK3I1U2rkTykcoWkwLFBaI8w
Date: Thu, 21 Mar 2024 01:30:27 +0000
Message-ID: <CY8PR12MB709934DFF6E667CB6A90E9D98C322@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20240320202459.188554-1-jinhuieric.huang@amd.com>
In-Reply-To: <20240320202459.188554-1-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e62a7faa-fee5-409f-8381-d8784b31bb69;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-21T01:30:04Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|PH0PR12MB8006:EE_
x-ms-office365-filtering-correlation-id: 5d2e9cf2-bf8f-4b48-763e-08dc49467cdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o5N6dRCgbuShveMUGiCTq/l1P6KJv6e/oXBjjkrNdhy8OqO1cMXE/TOZoDV+o+p6Q1ElFZ2Y7qBguRzsFRWvlHxdDxx7FSVQPV4uvMQtA6LvTfA71m7bBpEw78rVBGEjpaYRu14zDpRszdTqDkaWErVo0KCm8Le0vUFwQ4w2Wd9lFKrXVNDpO5vy7XjvL2nOKPZcJExzN/WZ2KJ+POM/+JoklNyTczr6k1RDG9QTA+2KBgR5j+e2ZwYo6wHwKUUpyEkClUgt2yE3U71J1/jvzkYQ8jSvUjdGBO+zWLpkvRmQXmFoHryN7wXqAHJJqlj3hY3GqgWZO3zB7/9czL1dY6WMychZCf0RWYSpjFlFCSLCJLOn/zvaq+qwbBXzVTWyJdr8024GyHbNI8urNJrkn81XN21ymKlGIqttFu/bwDLS+BJxnB0H6g5eR0XbFLxle4b7bRoqLrkesLDrJGONfKj8owuGIihGrXd/Egt6yg5WFmipv9wynB1sPwLuyU09SzTXzrbhRMho3uZPIfiuLz83qmh39NYEnjqZtZsPFxUF39uTgyIu21oooj6nt1pGdBa8qoUESPWiUja+i/+xN3vVqKhGfb/Btg5yjTiPL+e/4mf7tOAyJ/KTjnwohx92g6sXWX66Q7in6YJkpH252BcgX6lHLFZ7/KQIJbXvyDrGVA/9ELEJZf6lptuSeucru9mPbfgJY0zzFsB7AqgOSNjILNdne1PxgDIyk0VYH0s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6fZYlEzGFaH0Gmdup74hLzvbIzYyXMmnG6Sr/GMNGKX8JsCWHsCbmZDL7Sj6?=
 =?us-ascii?Q?+DXQ4kwU+VEig0w1cSjNKe6O2Dk09ZhpU4HsLshFWirwcP/rIgCSiVAlxOGP?=
 =?us-ascii?Q?d82K2EKTJU+gGWTsy0GxVec78wmy8+6FebupXUsZB8Jq1fYk7Y0KxTClKrmQ?=
 =?us-ascii?Q?2aUHksTiryJsF78AOot++L12GePfov0CNao8XhQC8BD2YBQGSosTb3etwr7b?=
 =?us-ascii?Q?tlcJUoriFg7+l19xaMe/AA+QJ5HP5Y6RwRY/Kr5PAg/Y9TwubK1qoAodz4pA?=
 =?us-ascii?Q?yWfkPjbwGBwvhkbTTIGYODDrMmPMbTlmnTPeBJAbQjn++/Z36zkabZcwDw1/?=
 =?us-ascii?Q?AtvEFBa8H4l/WO/N0tZz5BqMoKlrxQ7JGWynFj74doAWZCLNDCAD0kmYMDYx?=
 =?us-ascii?Q?uK08nwSRZCpxw1Lgq4IARJqLcVDOvjaalvavBk+AU6EwPSy6DIPQFh7qrYFd?=
 =?us-ascii?Q?ttecu/Xolp/ajiSH1VKr1eydk3nWZpecQqjdpVZmGoBBxeQy30ao4/niqnYQ?=
 =?us-ascii?Q?DgzqFp55iOvBC6Wc9l7WH5p9h2+TPJDHF4flSywylvolJBUiOjzJjOhE9Y/w?=
 =?us-ascii?Q?RFkDx6EzP51nA9UKXvAPSjHx8U/aCgDCpgCH5M3ESpkRXQ3cPDWnxgjnBNa9?=
 =?us-ascii?Q?eofbsHYsyOZzyoHiSpNJsAAdPoVnz9wirsvqzoa1dht+d/cAaxNz52PWNHud?=
 =?us-ascii?Q?FjvbDWWctFSy1VnEG0Rh99a0Grrcx57cqqTkiHuTMrIMTPnnF+bgye4yZUe8?=
 =?us-ascii?Q?P/o6fGnMbnKX800334Q+hHbJiWtVkMORLxd3U6GiI0O16GchSxqH29vuggAL?=
 =?us-ascii?Q?odUEqfEnibOAjyRAM55Fs4dEGtEr4M1S/zwwsUU+VQDFHm+NuyWyuf9Djx+T?=
 =?us-ascii?Q?lA7ntAqqs5z/qTiwrLxEVtioyMAqMQ3jQrBji0V1jFHWSSHSNtIwydCDHGi7?=
 =?us-ascii?Q?7icyRDOWpVs6rNtM6+mJU6SLUZ0Buf0c2RgvtK5lQzgbQdnS6/3Zh5nQQpTl?=
 =?us-ascii?Q?DgMVpbzxw1Slt9t1UYbij+iyVhnoSkGFAH2gCegmimGTpM0ysF3EeWfQkbi0?=
 =?us-ascii?Q?CBlI7LKCm6H1CKa3rgeMvweUDj7bAOMvFGcPqYYAhXSo5R2c1IZLn4Hay4HL?=
 =?us-ascii?Q?psrqQZ4FC2E9byWOBEuL5tETMwgUn9YPB7Odsc49VPnHZaWRFp4CCHOPQp/g?=
 =?us-ascii?Q?qaL19hDBGHy8msgASTjuxxgAGQLbw8OEInQFb1JTp8JCrC30NQoklxJ8UPYA?=
 =?us-ascii?Q?osZgZcBN6/FgPIeDioEcF29Tp8Hk9bG2C/KrpEJ14pVXgaTtuJS4wMQXX/1B?=
 =?us-ascii?Q?8kPoGbMJZQ4AWPO9btUmmUuzqUyGnaCn/OXaRAw/JgnpOu0DzWIo8azVu4rc?=
 =?us-ascii?Q?Ji7m5uiramdLiWnpC3QH//Cc2HsT/T8+lB/IE8vplS5+h9dhf8iWOFSWLDlJ?=
 =?us-ascii?Q?9Jxpq2zRGT17u57IrU0g1B12cu3L7eMVxDzhO1h0KGxKlDAHfZzC+KFoJAgw?=
 =?us-ascii?Q?91HxvkZcw1Zhf45VuOV5VZkoARKS4NAcpb3ayP7ug6O/vk3LWg0Ibc8Q02jw?=
 =?us-ascii?Q?jFjWzfVQ0JapTbPmLWA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2e9cf2-bf8f-4b48-763e-08dc49467cdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 01:30:27.0975 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DJJ2O491ZIhYHbrBHSzWkJzix25yorReTVkrQqkajt9XHxrRVUt21Y8ZmnqwjbBOp8YEmavJQc3yGrYvMXM3gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8006
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

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Eric Hua=
ng
Sent: Wednesday, March 20, 2024 4:25 PM
To: amd-gfx@lists.freedesktop.org
Cc: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
Subject: [PATCH] drm/amdkfd: fix TLB flush after unmap for GFX9.4.2

TLB flush after unmap accidentially was removed on
gfx9.4.2. It is to add it back.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index 42d40560cd30..a81ef232fdef 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1473,7 +1473,7 @@ static inline void kfd_flush_tlb(struct kfd_process_d=
evice *pdd,

 static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
 {
-       return KFD_GC_VERSION(dev) > IP_VERSION(9, 4, 2) ||
+       return KFD_GC_VERSION(dev) >=3D IP_VERSION(9, 4, 2) ||
               (KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 1) && dev->sdma=
_fw_version >=3D 18) ||
               KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 0);
 }
--
2.34.1

