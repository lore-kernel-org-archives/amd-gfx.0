Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FF0CDB474
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 07:06:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78F5410E58B;
	Fri, 20 Oct 2023 07:06:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 146F410E58B
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 07:06:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlhQ/zDHJ7/Gx2zHgvxybi1SWRXXVFHiB0x3iLS8lDIm+oxpTcPdhZVnorlBZCNq5WWZUya4JU8IGJiKco+TnaL+XNDOENR3GPLKLY4yz7NHIc5fTs/2wxr1KRyVxMUH4396nT2EibbSTZv0FLcUXS4FiEJ7rVSYKOfOQ6zxw993b9Ox5vY1vmLUFt9bM9kcZLaC6QmKwLYReh76wq/iCiXoU70W91gDydzh8LIqTmzOapGZAltrzY6CJslkio/PM6AqCJnZ75cIK5+wv5kNdZRjMFhT6xRO7xPJDOWun1FzrAlXet2t8t33Fzs5p70ChBG1Xmnpyhce2g9z2WQhxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gzodgtFvYlSIQPTXx8RgTN6Qxh6xnTpbDCuRWqy91c=;
 b=TvTX16vCyBez2XeBeecjRVeNBTzpobMG5RczFT3JJDTMNYVWA1O58o5LHDIrtP88mEepCZ8d9T1mcjv6fz+HAdAbq1wl4evg2moNNYj5PgbyTvHEdGHwYtRLfRGE0tY8RKERRtMchMjOVt6CvcWhp4oxJA6f7rbLKcjBtnzABncH1qnTd93vmQ0h6lTF4sAa1LjcoWwyXu+qt1MpU+YFGRJCjCpxZ+YjijRQECxs8kpHJbamGf45fkPun1Pt4LayHTrCs61kI4+oT2bGP32m//Djpjpg0DeaN5cxO6hKFRKpO38CD2s/Z3JOhIQ00EXG9EfR+TF3OPhxVW2Z3/9DFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gzodgtFvYlSIQPTXx8RgTN6Qxh6xnTpbDCuRWqy91c=;
 b=Fqaxw4urAMif+cGiQUyg6ZP1n+MNNT0YiNFc87P/yWCPmxVXqNNwkOH1JqnPt3lT9yCiKyum5XK7gRI8qHXzsrpqjSK0QCx7o13l1n9vrRvrmGC38/CKtmLp9e8eRLCRasdKaSBKB0GU/btHdpLa8m2lMV13QVaNoNoPN+bYSx8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH0PR12MB5465.namprd12.prod.outlook.com (2603:10b6:510:ec::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 07:06:10 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091%7]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 07:06:10 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add a read to GFX v9.4.3 ring test
Thread-Topic: [PATCH] drm/amdgpu: Add a read to GFX v9.4.3 ring test
Thread-Index: AQHaAyNbnLfxFPJ3WkWGI26XX5LDCLBSQVHw
Date: Fri, 20 Oct 2023 07:06:10 +0000
Message-ID: <BN9PR12MB525742D6CB12AA1785B67088FCDBA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231020070150.303423-1-lijo.lazar@amd.com>
In-Reply-To: <20231020070150.303423-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fbea1042-2d9d-4e29-90e1-37c06b7d69bd;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-20T07:05:24Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH0PR12MB5465:EE_
x-ms-office365-filtering-correlation-id: b18c92c5-e906-46a1-7749-08dbd13b09fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wpJ9IRBdmU+ZEeAK2bV0ihFYItWSkQf4rV6QS3Ftglj6jIDmsW7n6XC24DVgkustGfSBBDLzH306MKPebwzjYxIyUEhmbF00vhDjj3yeTIwFtjyQkOJf2jDloXXlbBUCGKkIPWoolrCGqlq0s26ByZckb2edNHMhFgzfUhWRB+M1kiYDbfUtNXXyvIGBJ8NNzjicJoc6t/l0c1FCKe0j9f6uIn/ha7wcC/mHjq8EkzEetkbdXs3glRq4hAO9jNIahEFVu8xyXUDyX80C3C1ImG+a97YQ7a18s1KvCPO0rJijKt7LhcwoKJoJQGLmhzvgqN1VO9CmPDggEp1XrewIlaApO64kPu+6fcJZ0T2enUiHFEvQkcqPIR0OeszKY+imt4tIzFqDaDaSyCcISdHTfsHo6ovAokNRD7/d6JN4wmiLTE83dT4OiWKdR0NZJwFz454+E0U+Oyi97iUeYg3G9lVWpflcO0+8fn1hPNbxvFUKEQagfdzwRaCwxg9BscBgcLwrOPh/e7GX0it20KEyYtfTQ/4DadWz/z5IDDAbPI+/RyLmZheuxPRwMLORBzvj0Jz3h0uKOgQq9nFJYy47+udrkrbULaB3jUPgCnzw59Mtcrh4qJg3FBTjAQJvQ9eR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(366004)(396003)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38070700009)(2906002)(86362001)(55016003)(5660300002)(54906003)(76116006)(66946007)(66446008)(110136005)(66476007)(66556008)(64756008)(316002)(71200400001)(8936002)(478600001)(33656002)(4326008)(41300700001)(8676002)(83380400001)(52536014)(53546011)(6506007)(38100700002)(122000001)(9686003)(7696005)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AVO6n3dpXzi4urRt4VXk5fl1ygJ2nqfjzM9TDhgQY/boyqGAL1qP9HBYkdQH?=
 =?us-ascii?Q?gAvT2Jvx89iIU6PJsM8RM2qzurjV3VlnDhAAoJsARVYSv5kHmbhvIpfQ0XH9?=
 =?us-ascii?Q?mbXK+EChuGR2Th6TdQWT9MWb0hHxMAxk0p8QFoDQlXSJWJli57Z2WICxcY4B?=
 =?us-ascii?Q?/LoKD+/AdflRzuwKHa7/BDQdwbr+PuTIcCQ2ylkpac+tLuGB52GvjWdrsibv?=
 =?us-ascii?Q?jajdxSU7soj6vzDQNPK2IZECh0StWplHT6DKblCwx2dVswwwEZHTMWIhKdRp?=
 =?us-ascii?Q?cf6K0axDwV3v3Pqnh762hlAB28VEt4LJ1ZvJY96ws2mzbDptf843nVqSEm8E?=
 =?us-ascii?Q?63ntc85CzQ30h3BEGKlIt9mTXw3JR9DP44nCR8Nunj2xg/gekLz4V+EE7t/t?=
 =?us-ascii?Q?gGi0ArfxDqCeY22DFrNznGxlnIBqsNGB+xwJNCrv0KX/0gOSC76/2N+LfrPG?=
 =?us-ascii?Q?3pFPNy4v1bLvm30UtRDSV10f/+K1L+mGMy4COB9wRCkMHGQtWIhZBuvUBp6n?=
 =?us-ascii?Q?30Pt7fWtXZ4rtr7wYUk5Rueh7BUeeP49MCVoGgiU5oxWN+Onesp61K8Btkzi?=
 =?us-ascii?Q?UKOJGeVV0EyU8n2CA/a5z6Wdr8OkTMgDR/ARuBC8UFTwY1bi620T2oDEeMEC?=
 =?us-ascii?Q?MlWyC/PhXVCAekzy0bnM+B8ftSzYYrFNaallj7XXlDXbka7a03P14TABNJuU?=
 =?us-ascii?Q?HPl4AY1AxAvJn0MrRTqo6g8ueMdL3n7uUPMlLP8MIkMaGoyltiSZGrXEY1vm?=
 =?us-ascii?Q?rVLFadakgtmklSqJGdihVd380Ni0HQbpXTpbLBcH0rqb1cP7VpUpdg8Yw7zV?=
 =?us-ascii?Q?GliSTQUy3tccE+n7afwcihxR1DTMlXHE/BZiM1jl3I91AQP8NAdv0sOHn1Jy?=
 =?us-ascii?Q?ChVzKF5NEU5gBC4dtufQ5FNTsiTKyWFW7iruLyAFFpaja9qXx1ZXcsu1A5qI?=
 =?us-ascii?Q?jXn06eX+6POheUbSTiHPIhe9Xnydrg76eOmDct7nuk9eAC0kcWCnFrL7t4nl?=
 =?us-ascii?Q?9cnhERpveTfyNLYt5SpwrfJVzasNBkAaQp6sUHafJyNw3iJZT8Y0yETTQUvb?=
 =?us-ascii?Q?NczEfZpY5PfqfSrKdL/2Mssc8CGqezv64R62sI98kUVDvihsntVqCICkKfxw?=
 =?us-ascii?Q?tmj8IUhxugQ7HPEQPfXfsDvTURJZ/+hHsHagrhbscXH6HlyAn+r6NEB1YygN?=
 =?us-ascii?Q?VpUDxNBK5nN4rRiCsL5QU04SemjHUrTLKh1PoUkR5QvARprn52EbUDR+Wc2U?=
 =?us-ascii?Q?o3trVcY/vWWSj7OWmW+ZAeIcF0U2BzTLMigHHvdGd4Da+k3dbFZJk8KA4RQq?=
 =?us-ascii?Q?T9N5mIJzLIvxWfdvuBEpVLRNaXkcTQ87XSFbICMDw5dDdBJrwBOxTsXLzcOm?=
 =?us-ascii?Q?VPvXINu4ulitd+1Qjrc6w/f0GWxbjHWarEaAXT8RKjdo6rDiAk0NY2SmO2Oj?=
 =?us-ascii?Q?UOwPv+1bm7hTWj4kWZX+wg/yu79geqbkxianwYsghZIrhf6+leYKXe7EUJhj?=
 =?us-ascii?Q?6hO+4n1EsD97JSYOF4Ue9/CX6OGGXaLh28Jomly300EYGzfQUDDKCFuWoTRn?=
 =?us-ascii?Q?fIyMfiZGiH5ogMMpayl80oVsusCaheO+wHmyEtZN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b18c92c5-e906-46a1-7749-08dbd13b09fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 07:06:10.3367 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5mYsHU2acHZJBZ5eCfX34qix3rf16cu1OKxxazkWC0+qSvD6X2BAgRCF4Ga89pb/WMFv+eFVUadHDxrKj45Ziw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5465
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Kamal, Asad" <Asad.Kamal@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Acked-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, October 20, 2023 15:02
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: Add a read to GFX v9.4.3 ring test

Issue a read to confirm the register write before ringing doorbell. With mu=
ltiple XCCs there is chance for race condition.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index a1c2c952d882..5861e4d0eda9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -256,6 +256,7 @@ static int gfx_v9_4_3_ring_test_ring(struct amdgpu_ring=
 *ring)
        xcc_offset =3D SOC15_REG_OFFSET(GC, 0, regSCRATCH_REG0);
        scratch_reg0_offset =3D SOC15_REG_OFFSET(GC, GET_INST(GC, ring->xcc=
_id), regSCRATCH_REG0);
        WREG32(scratch_reg0_offset, 0xCAFEDEAD);
+       tmp =3D RREG32(scratch_reg0_offset);

        r =3D amdgpu_ring_alloc(ring, 3);
        if (r)
--
2.25.1

