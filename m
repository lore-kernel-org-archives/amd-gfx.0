Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C400DC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 11:44:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 593F66E8A7;
	Wed, 24 Nov 2021 11:44:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84BE26E8A7
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 11:44:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOniZJu8T2ze3NwyHYQkXvZDISTj5xvNRTAGOFd+g3K1YUOxJv4aSJd9wpLqsng1FazDmj4hcIitVU9A5/Mskh/ubq+dn8h9I6zlwQMkZvqZ/YRuk+GBvHM9neghnw4D+YwWta+6IzoiUrYQHdFU7gQw3ad/CBpSKLZT98eHAc0XIJ7Y1BZcet3LpebEs5GIG8BVlCDasuU2gX9SU/thyZcbrWZCd6H/xP/Gz0ef3NnF8TVI8IHpIecSEKBJgOIgj3jhaPloeoB3PqqzMlFHPdwUyxJU9mOPgRVJoFX0OzYzu2XACsK/NIk/KVgsGNC4Wrwyus3FgrRsvaG4uBbi3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyCv29QBLkn6CJomONNJzeBJYMyZWu3+UfSdVIzTqaM=;
 b=EH0dQU2BLVcNLNTuFSyW/WYwYlKFapa1uS5HDEhKsM/gmC5iRFBK5Eqa5882f6y681iTIh2v3ZjA0715tphm+LFUz9ESa/UhrrUMj4024UJ29Z8svUhZeaRkODNFpfbgU/A2dFIs/lNXXe2te4MLxsh0uFvNrATRZStIchs77+7FunNmUEch7FJwf0X9nymbJviFt7msiVT2soMmEukxS09pc5Q+8r6TOgGza7A6v0/oFP3GUVlhwGHICSNpiPgXikQNAOEInw2S+vmzMtXMGy9nAAUsOhac3XG42Jbxz5/K7tajiI/s89mrCLNr9WI7fT2HxlIxOj4IDZ9AGmZgqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyCv29QBLkn6CJomONNJzeBJYMyZWu3+UfSdVIzTqaM=;
 b=PQ1fZg+de4oE6naXhdymIDBGcbs3EtReJiGQgB6s3fmFuG79MnQ/1uy065DeKAOe+JAC1HKUXW/d+a7HfxVO3t5DrFVu+N/27WfT8MYatvs+HYpSIibj+mN/zj6e4D8DLjgfSbpGCHg9hY7h8pOPBRbfpWCzLjAtoimMLqxjlig=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5307.namprd12.prod.outlook.com (2603:10b6:408:104::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Wed, 24 Nov
 2021 11:44:12 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::2919:f0f6:40a9:e1c0]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::2919:f0f6:40a9:e1c0%7]) with mapi id 15.20.4713.026; Wed, 24 Nov 2021
 11:44:11 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Skip ASPM programming on aldebaran
Thread-Topic: [PATCH] drm/amdgpu: Skip ASPM programming on aldebaran
Thread-Index: AQHX4SdgMnBck6j0B02jmObfmS5bvKwSjq7Q
Date: Wed, 24 Nov 2021 11:44:11 +0000
Message-ID: <BN9PR12MB5257107BDF2D45A93BE04306FC619@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20211124113503.116178-1-lijo.lazar@amd.com>
In-Reply-To: <20211124113503.116178-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-24T11:44:09Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=37957e67-778b-427c-bccb-517b0b152b3f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d906ee72-5229-4989-4052-08d9af3fbbdb
x-ms-traffictypediagnostic: BN9PR12MB5307:
x-microsoft-antispam-prvs: <BN9PR12MB53071E03B699D4F0204C7D4AFC619@BN9PR12MB5307.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: usLbJfJYxj6adGb9ALNCZ+bvPJfwsIFdrTOxsTjfh3+MAJQIbB9vJIwtJw3JZ0Usd/qYWDY6oM/E/IiWuah0A0QAzgtS7hzFyvbw4SPvLdr08rUUd2ngqsyRbjMVpFtVRiMy+cgeU7/0nEquao5iMOwyIT8ZwieB7NcdF9c4yMr90qcLumZZtfBWSBbt9TmZ7doclkzR3LYOUtWbZTQrM8kVZCvGwQ9ks9NBcPMFjWK5VUgKSL/B3jHZ75bFWUTUSxy/22Tvcv8tVxRqAIz6Vh0T9IIwtEe5XgPXLnl0KRZANVzE8EfM4kOyt8O5l8h/kSYaqgs1i63a997/y2pFzg0ig4euLeYrGLBug5Z3cGRTGxz3K3dHWr0onBxRvvtWC1VaUB2ms47lIIWToipx5cKIIWp2TO2PRpBdC187geFO2sQ7LM/lTPrKYQA9+ei3RQa/SQmchCXCxLgekQB0yQHKGqz/1SmVADADj9RaqqiA+X4nBV3bbAxkQ+KzhLwnaYksvFxsLTWb/IVQio05ZvZoiLZ6cOF6F8LJRrWD6VedALWQLEIg1KdJN5zlUqc2Z+ZYdMt5p119fPPFaDdgdRm7lJydDiCJK6mD4m44oco6S7Nc1ZJ9AlX4CTXHTx9z8wZW0SqA1TeWUM2xPkYORf7sfQcEG2rjOqieemEVgrHCeYV//RwsYi5lJ68A/gt5VGxro5FeqnVsDC6RPRPqcg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(6506007)(76116006)(38070700005)(66946007)(71200400001)(8936002)(7696005)(5660300002)(53546011)(9686003)(55016003)(86362001)(54906003)(8676002)(26005)(52536014)(186003)(122000001)(110136005)(38100700002)(508600001)(66556008)(83380400001)(33656002)(316002)(64756008)(2906002)(66446008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ryGYBrdEHb48iVSoqlSCjiFeWYxEIAjj1rfV7dAFPFoIkG18sVJtyLmv7w+P?=
 =?us-ascii?Q?9ma5dWlhbPAsCFfNiqgx92LWlvcYviyfyneYNHdlcjYpBjviIdPlQhoFrvoa?=
 =?us-ascii?Q?PAzEI2NJRrnCEmjcJUH5hMFf2cTBw1cgLrnrx/onWaMHkfwzcu8fguFEkCq2?=
 =?us-ascii?Q?SwBUNrLt6BeWrCjjys0GMLg+EiG7UdkHfbyHbm5i0YL9zPICEa20Qw3YB+GZ?=
 =?us-ascii?Q?iK2l6Y0SBkQiO2Fazd+gS6aJJRK6VuiePeT5lR5uAyT/wzBGtszAaXbiIEdb?=
 =?us-ascii?Q?Q1iiiolO3aUBTw/k0VRiH80BJeScMCpSQQR2mYPDRE7/ynNfqHCoaP4hVrBo?=
 =?us-ascii?Q?OHtidUq0PwJ0/Osi60PoI9UsxkQDMp15xrkph9RpvBEJYZw0/znOa9jEUIvV?=
 =?us-ascii?Q?vwOAxteqbmbdwmgfU/cTrg+dqUNlLLgvqWDisW/VTUiBvetGvlj4/Xrac4zt?=
 =?us-ascii?Q?i1byA1Q3xNeAPwu9uOuCSjA5bM37HNeKdJCsx/KfaxOgUsh5dTAqG6ArW811?=
 =?us-ascii?Q?63gfzXfij8SoK0/2rMwc+K1HaAIPQUYGp2rUKt1ndsWyI52KG8fezY7nKBoC?=
 =?us-ascii?Q?yWOV4QVbmE1Y6WBaohqguQtCY767PcZ1JTLlnf0mcujzZZuBvaJpC6oIMGKf?=
 =?us-ascii?Q?3x43r0K+JSBK9k37f23QtSciMK3BA+AMIAW6gvz4jHw+FjE569tzEuPaEcaK?=
 =?us-ascii?Q?jyorzjqeV1ej4Q7DgUEP2eGnSIBe4zflgd3CCYl8NTcJeYGAQu/f/v06/0DA?=
 =?us-ascii?Q?VPkI+F0049wSBBMVfMX3IYUScFPiPKatEdR7K3yNLex+bGL+ZsBSA6NJHWeI?=
 =?us-ascii?Q?2ApHHUNUCgn8+PlzeQR/LRP800pjfEcjynZvjDyVgfwTNQPbqQMI5tOKa6w0?=
 =?us-ascii?Q?KIHJRnUncLdx4Bk7AtrAYQiVCVerv81JM1nzBOOOQ6lig4hKpVduwT3lk8LQ?=
 =?us-ascii?Q?Eha8Nsogx3BWE1qgXU3mZmhy3R5KmTXm4ihNQrEIj4NiFvMJEGPyUIIe23ay?=
 =?us-ascii?Q?J30Ko6HB9P3aejUOGoE8OPcM9aq0Apbdw4vAPyKyCkIY8awDJoO8gWprnxgb?=
 =?us-ascii?Q?oMBYzBl3rCuHTE1EnhV+5Tm/tGqp7imP5d0CgODJwmK/MU2jLzwqGtLYC3uF?=
 =?us-ascii?Q?E7mGJxc6GpJgnt11N6KE9EOBzPWwRh3BsD1i5804X7C4X/2VYEpNRo/8TbgR?=
 =?us-ascii?Q?VuHuWNC7RZ/W5dSve0RumnYAXkBD+EEmnjmiduBO7CXxzzYd+7KcZCdiT+hM?=
 =?us-ascii?Q?il2CK6HF/CBVNeRNaXkcduq5tnrwGXxnuYQXQWvjNKju2k3yUd8UcnTJVGe7?=
 =?us-ascii?Q?31bypdXS5Naq4TDHSsMDk8xVYgS6sWX083noDDT5/lr4fTadu6xAvvcy2w5j?=
 =?us-ascii?Q?m9WMjunBSLKvAJ8JHnmG/rtKaqtO/c+KK6t2d6vuKO1qUyOZQbIdF/2Fyk2e?=
 =?us-ascii?Q?vYB+ah+ZyiDBjnOfSsgOGUk10bSTCQ7pYr4kAUNgMh2SWkuczmq+Ygu5VdL9?=
 =?us-ascii?Q?yrGdjkLn5ZjwfOWAWq+fbZjzwM8KEknqdSXgb4QZPJzCogmH6Kyc+AKJS2ZB?=
 =?us-ascii?Q?lKtTnbyRj8nH84njCjuvaoeeqdpP8Ti3LApQpKlucPK0Wo+7rH1YIHhCKLP/?=
 =?us-ascii?Q?7RRFm4Wmfv0mB8qULmYZdvY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d906ee72-5229-4989-4052-08d9af3fbbdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 11:44:11.7113 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V97PvKs0rRQUwRzURLPGR+jfoxVA6aVL9K9jgZ2Xm5yygc6oJZizWzcQkcrmSAPh8ARHUG7TDJ9bdM8nF0HDhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5307
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
Cc: "Pawar, Ashish" <Ashish.Pawar@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>=20
Sent: Wednesday, November 24, 2021 19:35
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Pawar, Ashish <Ashish.Pawar@amd=
.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Skip ASPM programming on aldebaran

There is no need for additional programming, keep the default settings.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_4.c
index e96516d3fd45..dc5e93756fea 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -694,6 +694,9 @@ static void nbio_v7_4_program_aspm(struct amdgpu_device=
 *adev)  {
 	uint32_t def, data;
=20
+	if (adev->ip_versions[NBIO_HWIP][0] =3D=3D IP_VERSION(7, 4, 4))
+		return;
+
 	def =3D data =3D RREG32_PCIE(smnPCIE_LC_CNTL);
 	data &=3D ~PCIE_LC_CNTL__LC_L1_INACTIVITY_MASK;
 	data &=3D ~PCIE_LC_CNTL__LC_L0S_INACTIVITY_MASK;
--
2.25.1
