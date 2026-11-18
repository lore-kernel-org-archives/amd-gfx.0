Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1CC606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Hg90ru0a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E116B10E6AE;
	Wed, 18 Nov 2026 07:52:42 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010035.outbound.protection.outlook.com
 [40.93.198.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4094510E6AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 07:52:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSVVmTlHVQf8o1UO6FI5I0U8UkKbu1kNRjYERXm+y4y6ywn7jrCD0/DncBBM9BUzEAHn2aHC9ViGd5+5QcFoLSTRbc2IlF9M7smsIYXrZgb56dc3yLs7EFUuxReLw9Q6hJXU83LPZGWauC1D8t8VPaexxQNQXnkhuFzOv3YancJpb0BmgWxMS91C5m+iAONwn51tJEV4J9ItvF7Cvn9ajzFuR5nm0AVP2AbC8YAV70X0DmYoIz7PNXtwJzyysEra9WwnzzK0KKmVOjVdqVCRbOIudEEHtrRCCzsyAl/3X0XsgLHEVptEs9yGk2OLG79ZgnUqnpDXdJzD5aeqOVRJpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqaa7qBw60JuAaMy17S3DY1OQ1mKGJrMlvR4PnNxBig=;
 b=oBgnAJw1yZWMhcC2ulEhm6As58vaXcG09pk3sSe8GIIScRxtlRbykNZ+Gc/Rcw7p2wAirFjMLmKjAfj7DwsMgBDsnBw7El//kiY+aBJ6VWZR4EiJjxvA4P9W3wUIL7F7e2Vjq7LGCRD4nM8JUQRD+1HMr29jOFJo5FwUfkME0K5J8LYI+Q3ALgQHvPSbRwX6W6mrA8aUT3wB81AAoQXoSnMsK1qVH9En0mGtLJUMojIpPgDObMvfliUOf6AsvpZZrZD9Cvgtn5u+5/01W7BaERf8YzHNtR/YZj+IVRFT/pRXYI/jYnV478OK2CqePeDgYR3hY7jOP4XOe36Qk7GqxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqaa7qBw60JuAaMy17S3DY1OQ1mKGJrMlvR4PnNxBig=;
 b=Hg90ru0a8Wh7kpMydDJy8xwm9+ypMyl5lU3vAzDysN3gVZfEhX1AXrwmKaKnWyDbbM7shmbZLq3VPFJhANeJ/IgDTDCZpSYVZHZAQcuzPEKy/O6deP+8RhvQOKoFVMXkWC7zA5354IBMALZfO9YbjFeBQkcQphZD4P/o5cxwbBk=
Received: from DS5PR12MB093474.namprd12.prod.outlook.com (2603:10b6:8:47e::24)
 by DS6PR12MB600903.namprd12.prod.outlook.com (2603:10b6:8:4d2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 07:52:33 +0000
Received: from DS5PR12MB093474.namprd12.prod.outlook.com
 ([fe80::ac8a:80e9:b544:ddb0]) by DS5PR12MB093474.namprd12.prod.outlook.com
 ([fe80::ac8a:80e9:b544:ddb0%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 07:52:33 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Fix SMU v15.0.8 energy accumulator
Thread-Topic: [PATCH] drm/amd/pm: Fix SMU v15.0.8 energy accumulator
Thread-Index: AQHddy07qE7RSGzmSEWXAleIDLa5UbczdR0g
Date: Wed, 18 Nov 2026 07:52:33 +0000
Message-ID: <DS5PR12MB09347401F878BC6B82B3477D3C8E7A2@DS5PR12MB093474.namprd12.prod.outlook.com>
References: <20261118071927.2149652-1-lijo.lazar@amd.com>
In-Reply-To: <20261118071927.2149652-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-18T07:52:18.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PR12MB093474:EE_|DS6PR12MB600903:EE_
x-ms-office365-filtering-correlation-id: a7654989-a698-4822-1551-08df4548e77a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|261009223027099003|56012099006|11063799006|261102123227099003|261021121427099003|261021123027099003|38070700021|10067099003;
x-microsoft-antispam-message-info: Ml3xGCR0LsREEHkV/NzTPj+8+gwxCJnlxGD9qmLMMVEY9mqfHEdd3Ld2d9QM85TOioWGvLz3AMr9cEH4Hla2s5oLuH/2nZmXYlHf4vZYDkplJ/U+3hvkryua9nshofnrddS9Uliy1e1ZVNMVgek8Dxbg2dnSYFfMGDYU9ZrRqG1VxHm2YoI0vG2r0Ios/BWewKMb2iVuuP1NMOwdngUbv3aOPVgVvCybtdEnBfW2qbYuEPVEFfFhT75MRAvXOnMc26ccQD13E/D+vPVgW23ZR7OKQTpP0mvOIuLiZ0nd5vVrRFVQl0G0YXV+xLFz4CAbgcsJ4CO6I55KpuJF4XuG5piJ08ITYaAeSzaPUKbE8S7kwaLgt9+gR7scaWT56DOszqqzDf65/+89zhYaV8kZjCcFmWV5tXrWK7Zuz2Tu4y4cffhh9HMMxx6DHkhm+GQDFBO/zksCMj5tVHUApjx+SOiWybwIYqJIkPYbJg1pVKjWzpixpn6J9L2X6xnprngSb6ULw2azZALJufdkI48V4vCiGxwxhZCSDFoFaFeLxjLpmPChWEaRo3/uFDivmnecli/nJRzggFSXnEp/dOuJBoMMlwTYtx8TZCNfYNG9IH6nII7rnLJiFsayCu81b4JmBAIPvBjtNbXAs3k29SYKxBRzOXuwogLb8xILU/UtJoe2MKHtpaZ7z++JM1gb9hDTUzphUUEYj4w2PZTPxqRWwPjfEmcLs9CpPFZyNadR64s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PR12MB093474.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(56012099006)(11063799006)(261102123227099003)(261021121427099003)(261021123027099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YzYsuTCdYrostHgFoUODPrEJk+QxPjvneiPqwyEcMSgxN+/2R+WfarczYUnI?=
 =?us-ascii?Q?/KcF+u0+HFot565W2C4xARMTfk0xxkAEudntAB69pEjh8BK47jr2jAQwlFea?=
 =?us-ascii?Q?mjx+IJTauUNkscFk9Zz84purxhkfmJkGs3qCT6rcEoyHuYQmtLxPQjAe+jc/?=
 =?us-ascii?Q?VfupLfyX3hkxKuPJFU6mTuXL27BiLeIM8RmOkzDLHyQLKs+b6U+TbMvFv5Z8?=
 =?us-ascii?Q?tAilAcwN02b/odOcnx/zjaf8/K07U9Ip1o+e6Y8ei4c039/F4rMUNlsWZ14S?=
 =?us-ascii?Q?FU41KUSoM36txLYBmfoHY5b8uCKHDXnOfk3Mk0XwKSVQ8XzlQK5iGHfueg3h?=
 =?us-ascii?Q?IoT4VNobYE4IHh4sB7/Fb8bYuGGb3e5lMA/BuLTQryps8xtYgop6LE2QIW9k?=
 =?us-ascii?Q?41qE7qzZ2/Z5NZs3QocBmqSNvstowWe+ENwtzoMPLb4wJLB4xUvHJO5ffxmk?=
 =?us-ascii?Q?g2C+XORvuZKlJR7YUSWTws/sNR8Kmd2j0WCPIMswnCZHbIITt6BdWXXTl7QW?=
 =?us-ascii?Q?H2EPDnOo5mFAjCT/Jps2BFHmuucofLP2Hfp88tODZDtvgsZZ3p+GlGF7Dj1S?=
 =?us-ascii?Q?9Zhh2dbAHIReQA4lV27ozifLDn7KUZx39hv5r9fwiHvQ1jfY8zPndf7y4kf3?=
 =?us-ascii?Q?7dGvtnvVR9i1F7WF++DBIEcaDcngITwcmQgkKp5BVlxB2hRHom+1yj5EbEiV?=
 =?us-ascii?Q?2J8WmaVJM4vDYZREaUjDNY6L9Pwqvd78RlCedrhfmkjBYulO22O/4aT/tMO2?=
 =?us-ascii?Q?CH4qUYseq2mRSnD+lHEBWnrrX/5DpVhm+boKFsQbaZ7Urn7OyXtJA+DFyq2P?=
 =?us-ascii?Q?QlqAGmJGXTdcGUtMu1/e9BI+0aMPmkVQXl2MEX3UO8kf/9p8/dE2sEGml6FG?=
 =?us-ascii?Q?YS10/0ucKTy/3J0XhB2jMUCgJU8+lOVXiG8VDtr+k+b8caPV3WxDzKRhn2Ds?=
 =?us-ascii?Q?KZoz/2fz7oKmb/6v6tlfXnlEdOrhDTNqGHv85NSJF6okyCynieZisdidcXWH?=
 =?us-ascii?Q?CmOKCU9LDzWNI4hxIA6zCeuleEWx7J7UMBD//0Q47AalhpAFNJI9AF1q1yaA?=
 =?us-ascii?Q?AxibbZnZVgHrPXx8mbxXLDaOslSvOIxocD9FpPdyvApYazb+7eHClfnjpr2y?=
 =?us-ascii?Q?vYPbK1Bvj23WJc+VxV15Kog3YKivAL9Y9EyrRpNn6bU94Iw1K7WFgolpBojM?=
 =?us-ascii?Q?d5x36yIAKnXqjpreZ+Jt0STxnNLN5MahV/x1u528lWH76FBFK4FxJadQToRM?=
 =?us-ascii?Q?MDDz0I8/SzDFJSjdz4rOhhMLMjuQ/LOkQOqkjqAPraUqeWp7MHq+7rL6raY5?=
 =?us-ascii?Q?smDA529EG9Ic7BSbrzzLRFY0TgcVfO+y4PKayhG2ErF93fGxuV/Aqdo5EaaV?=
 =?us-ascii?Q?dI9cChjp1CdSoSRUnUQL5TkqDiE8l+oBv1qHX0Mhqh9CS6kJ6mbDg8/Txoh5?=
 =?us-ascii?Q?7pLR8yTZzAyqJnpQl7Y0jtaHJsgF5G6Ze4wOxP4Q4WUcI/GRDKcq9swFtHJp?=
 =?us-ascii?Q?tJq6O8AQNeKmvBuYk2x5+Dw4EqLZbPfCcxjjSt5fRQv6eNJRYarToKCHchdB?=
 =?us-ascii?Q?KvS0Q4X3dT4jN/0ThSaCDOELHOF7so4bzOtbMIM5Njcg0xcFRf44W4wb5YtV?=
 =?us-ascii?Q?ANLh++1hjAHCJ0V0lvqBBsLEVnntMchkgZ08J/Ej8QmqwKurnWk9E1ZTzqhu?=
 =?us-ascii?Q?uHczl8Zi2bH8cby7HMN+2mR1mYGJXhhZ8t+qPL2o3ccMdVNR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PR12MB093474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7654989-a698-4822-1551-08df4548e77a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 07:52:33.2384 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9wPK80VXtogZoW852/RV7dy4Z+LeTAqm9i2uNHqZpWa0JYqGwAd56LrcEglXkiIZgEkHnnG73ocncFU5w27PuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB600903
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, November 18, 2026 12:49 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Fix SMU v15.0.8 energy accumulator

The energy accumulator is a raw counter in 2^-16 units, not a Q10 fixed-poi=
nt value. Report the counter as is.

Fixes: d1168b8cfbe6 ("drm/amd/pm: Fix metrics formatting in SMUv15.0.8")
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index a9cd1837239f..051aaa203fe1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -1966,8 +1966,7 @@ static ssize_t smu_v15_0_8_get_gpu_metrics(struct smu=
_context *smu, void **table
        gpu_metrics->mem_max_bandwidth =3D SMUQ10_ROUND(metrics->MaxDramBan=
dwidth);

        /* Energy counter reported in 15.259uJ (2^-16) units */
-       gpu_metrics->energy_accumulator =3D
-               SMUQ10_ROUND(metrics->SocketEnergyAcc);
+       gpu_metrics->energy_accumulator =3D metrics->SocketEnergyAcc;

        for (i =3D 0; i < NUM_XCC(adev->gfx.xcc_mask); ++i) {
                xcc_id =3D GET_INST(GC, i);
--
2.49.0

