Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CA0C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 01:08:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2B2B10E136;
	Tue, 17 May 2022 01:08:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96ED710E136
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 01:08:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+7tXijyvY1/wtQT2sTbO8m9yaE6f9nbeyrTQP8GGPcVzBrFKxCOizcPqXJH26PBeGs5mgpekAu1kjjvrf541ZapwH4iOYWOmvdjTve2Q/nIaWmrgGS2PnUy6VZ2A46G4l6nhirdhXsZnpw6o0Fzd9+wJ2QernRfY+QqWKlgwYUd1ve2Fn4ynJqpMnsEIQsR2vdXzXqMPjEPiVDCuwgSt0agh3tnRYh+n5UOFQZxU0Q8TUmNTeGSY8IEJOXPTJ/IrVR9N7UZacLrGGmMT5BFBR92DacKDnYTZBCj5MnBJ0rLxp6/dXmrQHW+xgDeC1a44imCtGjImCCC96Dz2t495g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjLwW4EFncyIXYAUOz4mHhsVWASUY/iliVnpu15yb2Y=;
 b=AtCRgFnL2oOTikegYSUNrKKr71fuuxExshC1ldUKZVCu0gE1OrWW57oXiSaeNlzfqSCffAt9CaM4gmANNTownhfeAp0W1chZcQrUQ1FI8r4h09R6GVCvXrKP89Mq96xOT0ibpMK2/RPLIaM9PoYXXR3dc42924lGjzAdGj+wizyc0bknLXVAxp9i7p/9iwNa6jP0t8DDHaJ6sAezFQH42Xu0d1GSlMEaZFC/K02rTJJYFux28VsFOTQI8ibKFOxvU+nk2CLwAaY0d2WGhHLN9MQx7v9y3wkxwZuyyjg+QyonvaJLcgc4tsqV9cdEyoIuKzyTpu8AmF9hsqP9FvvCmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjLwW4EFncyIXYAUOz4mHhsVWASUY/iliVnpu15yb2Y=;
 b=GZu/2SnC63pY1qhx6KqDqbVMvijP8sVIE4TuJFiz+41jy4/61Td5Symctn5Vsa2yvwLRltlupq9vTa4oJEzTNurBYoFJ3qRPhNfxm5tDItoa4J2bcF415NhkWa0XLkAts0DVTt8b/9PHSXOsqzMPGRN5bI0fnbGMQdlJcvTuODg=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 SN1PR12MB2525.namprd12.prod.outlook.com (2603:10b6:802:29::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Tue, 17 May 2022 01:08:12 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::f9e4:75ff:738d:8050]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::f9e4:75ff:738d:8050%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 01:08:11 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/discovery: validate VCN and SDMA instances
Thread-Topic: [PATCH] drm/amdgpu/discovery: validate VCN and SDMA instances
Thread-Index: AQHYaVFACh3vzEisrkGQqxxbdjb+RK0iQnWw
Date: Tue, 17 May 2022 01:08:11 +0000
Message-ID: <DM5PR12MB2469C6A6250AF58B769DCE01F1CE9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220516181719.1935896-1-alexander.deucher@amd.com>
In-Reply-To: <20220516181719.1935896-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ecbfc35-41c3-4ebb-1e3a-08da37a1b69a
x-ms-traffictypediagnostic: SN1PR12MB2525:EE_
x-microsoft-antispam-prvs: <SN1PR12MB25250A59DA50C3303FD16367F1CE9@SN1PR12MB2525.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tiqwCcO7BeKUwy92y8MKSejqgAMVDxX8pTTZ9ktbdrjZN8zGmvZNLulocC8Duzekf/69iuViyFaBwiqIi0oWple24Sr5j34C2PYh2EvbgiSRcU6Ve8XrDwblD0onR7HZvjHjWQ91PxVF7OW1onTAgXg4xnfJgcZQPUC369vmRM+2E7q1/Im4ihqZsV6jAL+ly654QlWqSIhX3a6KuF51svqUnqIL3tGHBpiWzc2tgDzq1iAS5aYTvjE38aantOB5rCbmncwzZxlJY4CmjFhu7yUgdfdtWLPt8QITZQX4fUcHdhHG+ZaoypTdoIx7KQHtgXB9ABEwFhj72x0zgPW3hSBuu0fzpgC32g2D5D8r1tGOIGPA0whTeOH6/WaGLnrMzJ/ic6H8moN8p9SEE1dBsPCWlDycqMmx6J5NwbRsPsNJi5HAl9JTnXHmEnnViERnvSqpFd4gTUMVGqGEdrJzwOrZJh8aXwRRvuWsPc7pNqgmJhZMLBzvoUyZrwRB+SZ9tJfPyErZ1lqtyOCoWktprhAe/jfzQFlx3hs0JmuErr3bhlCQB0XNJOI2rto/tfkerXiWwxFffnO5DdSHD9BoCp1bP8dt2i5cLrZLrhs9EfbkJwkyQHv6kuyeBaFlxxF+yw8y3/mT+C/LfTzs3pN19/z465kSMcJeR1/OP54Kno2uxSdUyA4s7aoU+mv5bxiCSS/h49W2O8tB95/OkRJQ1A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(122000001)(83380400001)(316002)(6506007)(9686003)(110136005)(2906002)(52536014)(508600001)(8936002)(71200400001)(53546011)(86362001)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(26005)(76116006)(4326008)(15650500001)(38070700005)(7696005)(186003)(33656002)(38100700002)(5660300002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+gu3vMXnlMsEOJtw7ri3A5TQwjNkk/n/8CoCTEQ0vHEt2/944lTR9QrO87RL?=
 =?us-ascii?Q?qYNtXJAkMaSoZXsffkO+XRnn75fXKFWkop7CHTN7O1PQlXzQ7/uwNyIsX9It?=
 =?us-ascii?Q?GYz6oZJDrvyNKzusTS3xlg5kYO1dfoMvdyet3b975IfpZU3+f1b+375AI4Cl?=
 =?us-ascii?Q?9rRKMxUadUgpxeX4RBdANBw0IIruhdosWwTczQCPYW1d1d5LSp8dsim0bcKW?=
 =?us-ascii?Q?yZsCLGIo9msHeQZuCUQwKyg5mh9gmf61GeYl1F8b32k1aJTezfDo1g0A+Qvo?=
 =?us-ascii?Q?vTqmbF5QZPLBGotlMlCVDpQKFOQ8PuaLMwEH+DQ//euHjT/PzMdTqtMO8LqM?=
 =?us-ascii?Q?kw3kKxOlH61oR8B7npKOx4ezQ7zID29jr9YS+JxRmkPjDtLYl5VpV6MnNVz5?=
 =?us-ascii?Q?61yyBHbEavq+b4QxScljUlmgsvrCgsqSKyWGIAEkH01hHGwub2HoMmWP284W?=
 =?us-ascii?Q?xBzn1shajpHGjRM4sJnO5Uc5yY+jjP6D7h70nfjh5JfBvSRMEmpPedeXPrXf?=
 =?us-ascii?Q?5tPcExfBXu8ybHJGLXpOJg79Kr6zjPniGKuIO9mokmRaafzMj/o0Z78ZEsF/?=
 =?us-ascii?Q?SBYPi98knLBXU0arVXjSXzNG25yoBHkGMs35mj3TpaNaENuzGvbuxROBmVDA?=
 =?us-ascii?Q?E1pV8fhGtbqaL+npsQvS9IsHOzywwQ4bYlREXWjykcuwOYZgWunx0cijB1ig?=
 =?us-ascii?Q?f1Y8FWv2XFNpRXD7MlXNg1Sy3TpJHiyYrOd5WR8d2Xx43G0UOonVccqpX6Zz?=
 =?us-ascii?Q?tE12zzVvtWT3gII6hTX0KJu3Q8p6gbcQe/hqacNjDDPbNoUPNISyzyVeUMbk?=
 =?us-ascii?Q?52KTptWaw6WlXOYTpmLAtzNNb1nwDpBF/R/Xiu9ZE2POh2RBMvjSabCQK9E2?=
 =?us-ascii?Q?TO9rdWell61G9QrFsE52z4YxCUy/BUwHy8K9hyXMkT9TKazNDjFGEft+JHY2?=
 =?us-ascii?Q?iLSSu60j0VzWt12kg2ogMzBW6iWCfjFiM2qHbHK1EhR4UvqVrqG1sztXvyWa?=
 =?us-ascii?Q?jt1mUazmeyI09Gd1w24hMImZRh+TE8Y+/g78TRj3jjYwIdvEVNZYulG5gr55?=
 =?us-ascii?Q?nlnNLm4v3GLCuesHGi8qUQv+v/rDSMghSxZ8oa2k7YeH/lPoKovHFHU8TnsP?=
 =?us-ascii?Q?e9jslj2kmcyZ2wPpzWBQjXoGlv91pX6BZLnHryx4qMKrd1pl8AswcQgxSXQI?=
 =?us-ascii?Q?69f+zxW5UOZbXS6ahQl4Em6VL+qEAHCra1J9ENx2E479I1NMPTa9NQC+9LNn?=
 =?us-ascii?Q?w+x+7AI7lnl0OLfJg0IPHksZtW29g1yt7xTSnRUFuP/6FtI2VmTc+oR/+V1R?=
 =?us-ascii?Q?fKU8Cf6BzAT5sKZkiXZiYVUy165+nnYCwC9qcot5gZwaKTEmkP+sjmTJysaP?=
 =?us-ascii?Q?1fPiH6SwHmu3l/52hVbqcyJf6GOWOY1PcRlwTYuGr8BoQnVCRw8c6H3ZaKI7?=
 =?us-ascii?Q?nkz+HikpCHd9u55++AKacp8i4PNKDz5+D37pStdLkxWKN1W79FIkBpj5p0d9?=
 =?us-ascii?Q?+idIs4bw/sZHdLdGxy14kM7CUAXyCGRKVSLZCE3oHsSbJqXMl4ZLtgXyn19m?=
 =?us-ascii?Q?1vU4aK2vyam1NIHoxXt/fbNg+9FKpVamrmh/V/MUGw2dFV97qJVI1dFv4cLK?=
 =?us-ascii?Q?6OPcmWfbBR2sJ7SpgELZO7+BoJzHqEZA66ea2pOQ9cxsZcgNe81sILslOA2a?=
 =?us-ascii?Q?QvlDAmvs5IstY7dI0hi75f1u8jh9T4pTPuZXE4e2eb0Ml3SsivLJ1OK/BBTl?=
 =?us-ascii?Q?KRFoSeb6Zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ecbfc35-41c3-4ebb-1e3a-08da37a1b69a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 01:08:11.9162 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tZJOZ+StMPgKsuYNAiyKAtZ0Q7sXp30lWMOzAqNQCX2KNTg5liAxwY0JC9Ccc5pfwvA2AEM3QlHdJ5xZfvI7AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2525
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, May 17, 2022 2:17 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/discovery: validate VCN and SDMA instances

Validate the VCN and SDMA instances against the driver structure sizes to m=
ake sure we don't get into a situation where the firmware reports more inst=
ances than the driver supports.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 1f4e07a32445..2c4f1adb5343 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1137,13 +1137,24 @@ static int amdgpu_discovery_reg_base_init(struct am=
dgpu_device *adev)
 				adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =3D
 					ip->revision & 0xc0;
 				ip->revision &=3D ~0xc0;
-				adev->vcn.num_vcn_inst++;
+				if (adev->vcn.num_vcn_inst < AMDGPU_MAX_VCN_INSTANCES)
+					adev->vcn.num_vcn_inst++;
+				else
+					dev_err(adev->dev, "Too many VCN instances: %d vs %d\n",
+						adev->vcn.num_vcn_inst + 1,
+						AMDGPU_MAX_VCN_INSTANCES);
 			}
 			if (le16_to_cpu(ip->hw_id) =3D=3D SDMA0_HWID ||
 			    le16_to_cpu(ip->hw_id) =3D=3D SDMA1_HWID ||
 			    le16_to_cpu(ip->hw_id) =3D=3D SDMA2_HWID ||
-			    le16_to_cpu(ip->hw_id) =3D=3D SDMA3_HWID)
-				adev->sdma.num_instances++;
+			    le16_to_cpu(ip->hw_id) =3D=3D SDMA3_HWID) {
+				if (adev->sdma.num_instances < AMDGPU_MAX_SDMA_INSTANCES)
+					adev->sdma.num_instances++;
+				else
+					dev_err(adev->dev, "Too many SDMA instances: %d vs %d\n",
+						adev->sdma.num_instances + 1,
+						AMDGPU_MAX_SDMA_INSTANCES);
+			}
=20
 			if (le16_to_cpu(ip->hw_id) =3D=3D UMC_HWID)
 				adev->gmc.num_umc++;
--
2.35.3

