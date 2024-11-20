Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31E7D6E2AA
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 03:57:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DA6410E11F;
	Wed, 20 Nov 2024 03:57:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aMI1r9NE";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D83D10E11F
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 03:57:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FzthtviInMmXDIPZ+XJ/CJcmMO327bZBE5aRHXiQgAUtaTQU7/fxTxf96k8cPNJFtvtzWg76L80NMCbhtRlz/7/Ky7N/DBN/dQL7E24ZqkvDo+3hMDndByJoZBOEODIfyQekwzmFNP0JN0S9iRatoa0VmPJDSvnw2HeDNXyM6iitJwAP4Ox0ouGr7UhkofS+WkoOR8ROGKf77P8oC9pQu7/s7/7P/2KglAk/f5E9oErrRU3nQvbK2i3zQ7YXGyqKDn5h1rG3swvN64OoCPaLmqU6MP6QcJ/+sWtUdsRoTAn3Qu6nnfAvMFiA/iBKuOXBBxCNoVbnpVVzGXkHm2OSIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebkYbsEuKpG+U2D0UNmHV0g2470/Hri1dqly9yUqyGA=;
 b=CVtwn67fn2hFyadJyQ+Br7Q17o0CzyucLMqSMTR3lFA8kXMXMxZAGJFy5eOXdBi0Y7t3N6RlnDedB7sGTlZ1Je3lhHA8OL+XapL3aGAtnIQ1KsplDtPXPNMctIgS7LVY7lbN+qOTD+1nlGv8sSlQqt1UOPsL+KBWdWkCVG7MlQtcZn1LNvbFfD/TXDgG5uojGSaEhoxnXFaYIUzypu8aeBPCLQDjDkAphLBLlXCxe6JW6MyVL7vNHpBm+ftYPSjXT6hDVvMbgS/tzCWFriaQk1c75dZlcQ+tzytlqgS+fBKN/GAdouGhO4so42r8QkMDiLCY8lTv4AIEFb14n6jOKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebkYbsEuKpG+U2D0UNmHV0g2470/Hri1dqly9yUqyGA=;
 b=aMI1r9NEDdKCX9WFNzZxmZZ0vdOvP6UFWcFZomjiAso/W6yOvdr1onZQRMsxjwKnCKsxWxZNvn/g1ayXEt/oKcGSmrefyjpncf8qYYNDWJY52p+5YTaLCbTmF8o04TEDyC9LY1NqVU/msY0CCEb2uUGlVivCKnYxXzlgqVi/DIs=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM4PR12MB7598.namprd12.prod.outlook.com (2603:10b6:8:10a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.23; Wed, 20 Nov 2024 03:57:05 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%5]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 03:57:04 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Remove arcturus min power limit
Thread-Topic: [PATCH] drm/amd/pm: Remove arcturus min power limit
Thread-Index: AQHbOvr7Dva0z0UYMkmLY0KZ1uBr4LK/imPw
Date: Wed, 20 Nov 2024 03:57:04 +0000
Message-ID: <DM4PR12MB5165BA9DBBF85F46B30DFE108E212@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20241120031537.3398907-1-lijo.lazar@amd.com>
In-Reply-To: <20241120031537.3398907-1-lijo.lazar@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c833ca31-8b33-4788-8c59-38c9538e49db;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-20T03:56:27Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|DM4PR12MB7598:EE_
x-ms-office365-filtering-correlation-id: f6f06711-aae1-4e18-fe47-08dd0917657e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?G0/IyMTr9BysirchUBJQLHZDuIK0rYT1tjU3ZZWIy4nftxsKPBNoP7N/v3aW?=
 =?us-ascii?Q?RSXKOARMTcpPK5flkIEiIdz36eWPulogjmv8TkKRyUNwVf2f+GCLL+XUtkmf?=
 =?us-ascii?Q?Eo5m3fxL3KcTYzEtMGCBrg2bSPp+usqSIvUoGgE5F+iLP+NpI31N/yKQyJV+?=
 =?us-ascii?Q?vNdVFsMY7x/+I2US5uPMgc6JzGRWs6aGsyVbfNgiXuhF5xMDRw8kL2CoB8Pu?=
 =?us-ascii?Q?d/YYXNR2JQq87nHYKSVYn525wGxAn8Eq4+lHZ2Trpennx4Cwd4xOkM7+TzDH?=
 =?us-ascii?Q?PYUYD4psnsCQhQ/gQfPOFy7DK9sAnVmH5lpXhdhpobnzbby+gACjYSImQN8K?=
 =?us-ascii?Q?u04FKKLBUOK1rxVRu1jYlm6Hh91UmU1g+24cXQvLkO0PrDH7iS8E00+HVATD?=
 =?us-ascii?Q?rJWLRRU6aPzvpVSbqiKRWhzzLIn9XVeJ/R9x2XxxSrPicaubNYARnxmeLnd7?=
 =?us-ascii?Q?NsJh23m6YJklDAijG5MlCS7QyQU8F3eB4F9qxGBwTRWQrL+dKQB1D+1ONIr2?=
 =?us-ascii?Q?7cjdSiZmrJ7etj+ATReYebXS50N1wpTk/6IRSv7Z8v16rgxvSfvpgTiFibCD?=
 =?us-ascii?Q?PAo9SvWR5g4Y7MdHtlLYmkVAyUJMqzmHkUDV82wz6RJZPYKcgi9/i6Zh2KNd?=
 =?us-ascii?Q?hRVKbehg1y2tl9qEXjrR/IzopKzDnAovMm7Thl7sUdR4BD5HEGcNna4Kk0mV?=
 =?us-ascii?Q?xJ6DjXT026Goe99Fnq9EHXXTSw3XB6FA0VtIuIGrCFKX5ACxNUrs0YnFruHN?=
 =?us-ascii?Q?ZkiPfvMsCRMmY48Tt3Z3Olfaiot+Vdm+oprBt+jIrvociCUnS2SplWVObJtL?=
 =?us-ascii?Q?YaqWAeeuoymJIyy1EsghA5FLAtnjZvNiq1gFveHs5AIOLT5NwztXmBOnHlPd?=
 =?us-ascii?Q?YkExUMp+u1ce0nv66jVAfceaYCO77SiyjIo913N9hj96AaiC1TXFaiUnnp+P?=
 =?us-ascii?Q?Kc/fTr+0OrvNFz94U/iUBPjzYp/tlpYnzPyNUE/QDIf2++X8K112AJD4cCT/?=
 =?us-ascii?Q?37xkbhZaF03R2RrsHLdDHckgNGFj5LcMlEcZvMEg/i+/MiLAQ12kiIDk40ea?=
 =?us-ascii?Q?qBd4b4jQ2xuNHxOf199WJQoBaoYU/tCsOAQF05oWflWXkCuzO1oPn3nKMLWj?=
 =?us-ascii?Q?3KnHXzEiCCXpbSVV/HxmBNRzqlZVLox9/1ZFMLcFr5nVHpyfYJrSjVs3VL4r?=
 =?us-ascii?Q?hLcaC9dhKZpRZfGyymNqc5mtsZF8dFVgpZR1Mcn9fXYC5+d84uG7a/3kTfAO?=
 =?us-ascii?Q?FS+2LQXituSBET76zQ++u1IbttTbau1Th4SHqOgBlmkmmUyIAB8G/LegCVF7?=
 =?us-ascii?Q?ciKu8PNaNLyVYsEwPeuH73DGzX432qspPEDBgtGWpA6FaIEnOmfHjlshImNj?=
 =?us-ascii?Q?bHHqC5o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cCnXWFXP0BNKpAu7XGxWOJ0vuiQECTM+RmynVEI8IeOqqaQpCd85CYqslSFI?=
 =?us-ascii?Q?trUiL1h7wabka2klK0r0KXXOzxxilIRN+DUFXwOUUCHGsfg+kpwg3OIlehyl?=
 =?us-ascii?Q?vu5AAwmRQsQqPBorGp37BGF3KUiKgSFAX6NVc9iILALKqb2s4ExW9rmW7WTK?=
 =?us-ascii?Q?VBKAVWqpL6Ia9eJmqS8MLr6xEaMtZ6deGXNCXcZooFoBmfJ6Jc5slv+oCm2Y?=
 =?us-ascii?Q?s3enJ9f8tsFNMtPITQSPl6hYkDBYe7yTze9RkgoM9RDS0X/RcM3dI70aeBnW?=
 =?us-ascii?Q?Ew32W16IefXa+CT03eOeNUe2KFtV+3XA8rtKne5y9XR0cRlUOrhB9fsdYdA1?=
 =?us-ascii?Q?6w209E9yolxsjWk7cKg0zo13XaCzvzjDDEWC6gEnDlk1Mu8zULYfJJsLZ3Ch?=
 =?us-ascii?Q?TMmJ6X148Eay2hKUMIXmM5zUvS8eehC2eWphUjvEoccg7phBLx7Cz/o0Kx8F?=
 =?us-ascii?Q?pX3dqk4+jdIcihI1U2YEGDSmSmVqZjqi5WFZyR3mh9HgJ1H/vqRvsW2gVZfo?=
 =?us-ascii?Q?dEn7vHT9odawH1+45PgVKVHxlH8ZvoR12UuIDNqTah5GvR+ys5+4qvlJZtoq?=
 =?us-ascii?Q?EQL7Jg4buL9n9+p4akEZ1Aj37O6l1VWLi2/8GTSEMRL580nwqlphMLFInf+r?=
 =?us-ascii?Q?//sK3QUK/nFYXjNdAOA+aVr6gbEeBeuEAJzJy0vutKEHH1jkdll//8XkSxbx?=
 =?us-ascii?Q?sj97UlKUB56vZgPqrBHCZtdGOnNxLZtfaR5RWe59ptGcTJVvePgD53ZwhYF8?=
 =?us-ascii?Q?LVuqLcqEetCOs8bWmUCVrzEWxGlmog9d7ZXsHUo4Ggj4lIvNe5B4wFC17a5t?=
 =?us-ascii?Q?Q2k16PkpJ+gyLjS+U2Q/gdSzKD2g56Vp8DIox42wPYODw+NYGnDTEsxxgLNU?=
 =?us-ascii?Q?puHQ8AWlVs5ilTG5mENaA6UbR96ODiVaT4ORmoCzCz7F15XJq3hHHJfX2ZCb?=
 =?us-ascii?Q?9vJH6xiDqz4FITb2eoKinlINiq4Py62kZvOF8a56pv7260v43iGZ5k9F0xx8?=
 =?us-ascii?Q?vBImMuSvsnTI4kREpCwlfUw2C4qAuaH10XVmCNHQ4O9lsq46DrqkTlyscaqP?=
 =?us-ascii?Q?0M81k5Pzx7gEKOFJSL07vQZwkTzX8k2NFr9Lqrg6lfPO9cShvBaP1vKR/6ei?=
 =?us-ascii?Q?mRIihBWuJehRiobeeS52+yhUYjeJlHkQuFW+fOxgLq3+I0c35oO9Jc2Iz3k5?=
 =?us-ascii?Q?uqG5j+6YsD6PLvC7rjOL6hV4VGRQ31pDxTlapFI1j6KHFwGsIH9AFPqMT/55?=
 =?us-ascii?Q?oGvYH0AyfKAAECwnwJgXNWv9kZGyqvZ/UHmC8a8PxXI74eRM5JjQQznPoM8g?=
 =?us-ascii?Q?IteBWpP489n6FWBSvf3MIZeNIw6Spt8s7eYPe5IFq5oqgDCsR0IDq/hs03oq?=
 =?us-ascii?Q?mrvxWAPJOI98kDoR79EI9gXQF7RBzSEaCrVl0jZXLcy6EuJVMH7AXOU4OxMR?=
 =?us-ascii?Q?chZ74QyuAOswgKrs/Go9DKmpsJ/3+Ce9KTc1dKPN+GFznTGUbhl3x9RrVIfW?=
 =?us-ascii?Q?rnJYh4ZuB9W6Wvc19cz93QKpeVu+P6MAo3as1WKxsWsxbfBLyFZqOjnL3NmS?=
 =?us-ascii?Q?OMbxwOxoNP1iZ0L5cGc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f06711-aae1-4e18-fe47-08dd0917657e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 03:57:04.8067 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fVmp1VO7l33UFGs4LxHfbZuS7UWLV7uGRVeZzj0g5Vv1JuZ+rrHlriGSwOmrt1aC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Kenneth Feng kenneth.feng@amd.com


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Wednesday, November 20, 2024 11:16 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: Remove arcturus min power limit

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


As per power team, there is no need to impose a lower bound on arcturus pow=
er limit. Any unreasonable limit set will result in frequent throttling.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 4b36c230e43a..12125303bb79 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1344,8 +1344,12 @@ static int arcturus_get_power_limit(struct smu_conte=
xt *smu,
                *default_power_limit =3D power_limit;
        if (max_power_limit)
                *max_power_limit =3D power_limit;
+       /**
+        * No lower bound is imposed on the limit. Any unreasonable limit s=
et
+        * will result in frequent throttling.
+        */
        if (min_power_limit)
-               *min_power_limit =3D power_limit;
+               *min_power_limit =3D 0;

        return 0;
 }
--
2.25.1

