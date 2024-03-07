Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2B6C5475B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Mar 2024 03:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09FC410ED8D;
	Thu,  7 Mar 2024 03:11:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="egVL/ZOA";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8F3610ED8D
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Mar 2024 03:11:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibDy68StZ0v5fcLc6OLWQEZRU1PT4uOfDmFQ2bgLEd83rcUXd4u6taN8nN++B53g5Q30lbnVB79QZ2iaUXmSiYmRQhAWY26Yaob+JupE52kjpCEAomwY/i05bqB+MJOAlJXsY5k0/CdprdbSiJL9AXWoMQF6YqW0RiBAdJSatJBQJlkfqSEnr3zRl52hPAIMqcAbOjV+pvxAJtTGlHGl1N3IkaW9V7SI+rSPEaOKZ5Erouv7q3jDD1HfkcRgFp2xTuyb8mPK7XKB9N/ghdAnaNKUw+hygDskbuUrEgQnkt6gwKY34mXfsW8WQZ2duWmxHKy2SCLGErM2jjrQ1T+mcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmqN89hX/bkC2E1ABNv0z9WnYDyu9+9YeBEw5Zqluno=;
 b=L/5CMiX32suJQ7bm4eN3C5+otaVya9/+UIbVQgf8K31MaxmLGxtZZSxWFiCO1jSano7GieNDHJ+d8BCLu1PYemCujsL+X7vAuXnXcMmbYdedpgMn/lLL5yVXkHhSReGuBVpmr9o6njUC2ChJNDRwD8yBNG1Z2EsKKDNWapeM30O5kwTd4/PDA1k9A7hjp4ejeSjQVKpGI+LKvjHEsaMksGooAM3jSvqukzW4MjKtEq1XRWkOlScRqPkN8Wej9tx68AU/uKlSG5+QBgQnyxcK7ut8Hcpd10GxdlYDNms/R88jRnukfegkhVGitt83a9xbJ56nXLXKPyAK7pCRRKY7cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmqN89hX/bkC2E1ABNv0z9WnYDyu9+9YeBEw5Zqluno=;
 b=egVL/ZOA6/ectkvB1w2qJLsIFhwuyWtETU+hWOVarCxcxHG5s4+0W5xX02nrBKJyrYUVHwq8G4PLGyHJAz+d2uw+/so54nROGQep3rRZMy6VjBdVqFCprNcCkQl+50qYN2QMuFnlfjoN082PDb0Lktfcuum5fa4XmjGNWCVYy2M=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 03:11:25 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::2a98:ab5d:ad21:8b19]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::2a98:ab5d:ad21:8b19%5]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 03:11:25 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix mmhub client id out-of-bounds access
Thread-Topic: [PATCH] drm/amdgpu: fix mmhub client id out-of-bounds access
Thread-Index: AQHacDoKLADP/nlH0UeXwhut0RqsU7ErmElQ
Date: Thu, 7 Mar 2024 03:11:25 +0000
Message-ID: <CY5PR12MB6369E21D1B58474E7A179834C1202@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20240307024854.2244635-1-Lang.Yu@amd.com>
In-Reply-To: <20240307024854.2244635-1-Lang.Yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=10a8599b-aefe-4a19-b41f-362f094ecfe4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-07T03:05:55Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|BL1PR12MB5755:EE_
x-ms-office365-filtering-correlation-id: a47e99be-0a8e-4888-89c2-08dc3e544603
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XKoPkzv+cp/SBp2K2scgiuZhGqtk9qGoN+XGrPQZdnI4qAXlp7mpovRVhMifqzwHmRbTCj7RksTuA+1aYIa5M5zcF1BBnF6r3Vz2Hg6TUUMtkVt31ScgeP0FdoVLVc5Aoo/5UaKUOsgmMQqneYF4tkGq2EppiC2Hd6jedg7CpiouQsxRljHZuDznim98EsJh0Veqf6zfbOh1Oa/rMOJmfMZmUBz5e7YrMHtYQRd29XBqBN9JfCztl7XdR+z5YzFi/KDG0nF2OChqx3JNv0LSwgpw0TucUm2t64fWPMH8CCCUwgJpgIxcpukJFyAGdJxTk5nHq3pSjpArqNzTgfhFEdbvYuNBbcNE5/okIunCj672yqT5n26T4+F6Q0a/srviHx5HKjQpblRP//MntMF4QbQmSnPE65lRq72B5DWv/5X9KiojoA1p/htlqoThhGltzXs2Y97cb+usahZRiq+fhk5MDrwcS/4shZhOMMWrLp+6QkxkvF8ceTdtvrXW2lh5O3OegdnrsmGWRtt8JaLokFKGPQ/Lxb0SINW3V3T/PDanDFc7uMaz0bDo68AcDR2j7mgFIlpZBvs+iSwGOHNQvQ4+5m6Ff6h78byzaHb33fdIsaAAnYBsWQsJd2Rkgd9Kye62DYfySGZt1HH/g7bav4fNvZk1sqBuQzExISo79e465s1O9/pe2Hahn134kGknocDxsxk01ajW4so7pPwGlNncOs0OvfwrOaPaThdxjQc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5iuHADExa651eej1kMci/tbTH5pCgLDet6P5RFPTJ1/8znW9NJq+YQwSWc6U?=
 =?us-ascii?Q?0u3ObYjoH8uXVb98kyTEv7h/Txsdy099NsKL5nDc1Yx+PV3xX2DlmHEcUm8k?=
 =?us-ascii?Q?FxZ+FJ/BU313iX8sqErUIfHtUhzXCG/0MsZFT6NgvECA//HElkK4+LQlHA8y?=
 =?us-ascii?Q?vVH65AEFCfFeNr0+GB7odfn/glK9wQjRruEzm7Bfkes1Msn9OILljvXiDSI9?=
 =?us-ascii?Q?zRR66EuWNgrAxwg6tuLu0r4XghjKqZUDGqWeTyYFFMCQKSnwyQ7tS5nL9Y19?=
 =?us-ascii?Q?y++GIvUY68pYPJrrgt8olMglWrgri57lMbQvZcmXWaclb9cf66fBfWkg1QcP?=
 =?us-ascii?Q?RrhXBd1xOCBzqVUJ0xnw4vO6wiL2EU60wgcLpMEGYkZPI+qnry7P6NRpWqoa?=
 =?us-ascii?Q?Amky7JlgT+UKbiZ8wP32yxd2/0eMjKDaOlKcZlTUvDj05CsYWDQpFfB+C4yd?=
 =?us-ascii?Q?d5rvoHjdywzY3ZdUTJ9EG4qDxtqO7VHLHFKp6iOZWCaFkWY8tyIDFB588j7k?=
 =?us-ascii?Q?d2kspPP4FLyJFvl7IUyGfR9HQFbR2Q9vB6D+CGoZrf+hdAv3wPoBgzVgpT2r?=
 =?us-ascii?Q?Z6bbtKxX41mSYDGZbRfvMMdbxH9JX0T+j4C1aA09vE0vlwpk3dQ3UkScxVur?=
 =?us-ascii?Q?59aI0IFsvuaeGelmo+35WNMCq9mZDRk36sH8alF1uTuI/nqgNGE6sC22fopS?=
 =?us-ascii?Q?iraJgmCKWzini/HUibf2EGqx4REx8a4jtncP9+qNpQ231Xe0NJtXbuDuC3/x?=
 =?us-ascii?Q?dFIsJ743pKayAbO6xesQgX8dyfgkX3DEy3HycgTsqTL6T7HOKDXpKuJNC4ug?=
 =?us-ascii?Q?nYRHNhovUNAoqGLAAWNjPusRBrzhq7P/WDIqL23LXtVTPRc56V76e8n1oYBY?=
 =?us-ascii?Q?B8PFL5FREPH1vNh8CfnbygFiFA0CSj8y8jc75pOiYUqKcy913ZS3uqaYue06?=
 =?us-ascii?Q?9fQZMTps3Gbm2dBRGu9SHa7jAAmTam1i0BYmPAYcX2hHZvlNDTZyN9MWU8cf?=
 =?us-ascii?Q?mJu+4dtts0ro62V7mHlv/ThpwIASBm6U+EQhXhhhsdClGmabAEoHH0UhbPaW?=
 =?us-ascii?Q?FZsrHh+oyFponLk5QurzB9jDo3XUXW7jE6gFx6GD9jl0+yZm/lIoJqzviij7?=
 =?us-ascii?Q?FTlSPTWM5j0a5r+3P9Jimg69jUJixc27ah2qtOgg1FO61M5YGnRT4c5Qxvuu?=
 =?us-ascii?Q?JHNEk3ihdIzIoRD54aROc4tEWUi+ZqCSQYx9GzI8K6E45jUkdZnovknui1R3?=
 =?us-ascii?Q?3Qr8MSOpaNhDn7l5Die+tK9f+8ceUyUksWna83P7cFKDLFL/c7Rq+0AvncYk?=
 =?us-ascii?Q?k0PHw5s2n/3hh3l74wTV41dTxBRKSDVy1WZeDuhXAfTu8aRaCoAoUai6BH3V?=
 =?us-ascii?Q?82YXKESfmHBj40SxIhoUP/I+liP6PwsLbYY56u+Su4ZWb3WsbN7vOCVLE3o/?=
 =?us-ascii?Q?ADUE/vRpOPie1hIQXTNbHiPCSamJ+4/+F4k+ouiZOZa9C0GElBHtruyFfd17?=
 =?us-ascii?Q?3Uwshpr1JyuNyxlBVCP0aDu27PfZ+E/PgT3PZPRkFuFDgNulpjqkchLa3oHB?=
 =?us-ascii?Q?TLN01PufC6AWSKFGcJA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a47e99be-0a8e-4888-89c2-08dc3e544603
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 03:11:25.2315 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g4XWN0VuNcnjQk8vezspubVUKIGmbWFX0Mz3XatEs5I1ubZ7cKtB/HnlK1tmU0je
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755
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

Can we just add cid 0x140 "UMSCH" to mmhub_client_ids_v3_3 structure ?

-----Original Message-----
From: Yu, Lang <Lang.Yu@amd.com>
Sent: Thursday, March 7, 2024 10:49 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Yu, Lang <Lang.Yu@amd.com>
Subject: [PATCH] drm/amdgpu: fix mmhub client id out-of-bounds access

Fixes: aba2be41470a ("drm/amdgpu: add mmhub 3.3.0 support")

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v3_3.c
index b3961968c10c..238ea40c2450 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
@@ -99,16 +99,15 @@ mmhub_v3_3_print_l2_protection_fault_status(struct amdg=
pu_device *adev,
        switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
        case IP_VERSION(3, 3, 0):
        case IP_VERSION(3, 3, 1):
-               mmhub_cid =3D mmhub_client_ids_v3_3[cid][rw];
+               mmhub_cid =3D cid < ARRAY_SIZE(mmhub_client_ids_v3_3) ?
+                           mmhub_client_ids_v3_3[cid][rw] :
+                           cid =3D=3D 0x140 ? "UMSCH" : NULL;
                break;
        default:
                mmhub_cid =3D NULL;
                break;
        }

-       if (!mmhub_cid && cid =3D=3D 0x140)
-               mmhub_cid =3D "UMSCH";
-
        dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
                mmhub_cid ? mmhub_cid : "unknown", cid);
        dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
--
2.25.1

