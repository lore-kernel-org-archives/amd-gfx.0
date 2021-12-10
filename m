Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E859CC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 02:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4580089F71;
	Fri, 10 Dec 2021 02:15:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A68689F71
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 02:15:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyAc/chWRyiJZwi/EcgP+DCNOsTfnIqmEXesr/cxo6cAorTlTGahxkFVpAQR+v+pWjBINX55Xej0/7g+Cq6dw17sKL1eDPZzuslZ16POIo8ogph2CDou3QJQTWtSC9zmfbl7lLDmW0cbxHk9RxFV35D17Y/rS2tp+EaLbtFs/zzHizvbLqe+PanDGmrBJODvwmWTn39M62vhXJg811WlpjRz2u4pRR9xVw7eRwa7XfYCswcO6Q8fG336oh8WZpsqzSr7dK8qT6dUDKANiGVmaQWLKb5+TzwxxrTqnSE5U7QBzPUEXmbwst1TNCQXIaNmwp9UYhzxa7H4WCsZjTJtLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vgbRSu4bGpmM+0O8Ap6WDS+WOVU+ezWiZ2gbcNNszM=;
 b=F7Q8QnIw7W3f7ioW8P5rpuNTV/UI9fprqv4fJZxtIjFL1fLJcnIZDEg9uwEozkdeBcQLRF6qyYZrbvfHGDDgyr1wqkJfsC2AyYRCdHru1x/MD0Rty7bN6hu/BKDBMKHCiCV57PbzESvn9uABAGlOdBPpTA2r+rZtxrHCeGvYMleNlA8AmIE+HT4kxM/l9v9nLWHqqT3AejOv8s04f9YnKeyp7ooCibg518d8JAYefH5j/0lysrjZ4WbsSx2V4Chu60XrbvcCxC9YsOrU+Nxoc/t3vfnVp6dVBtuQzV9LdsIWKrMUw5uKfTUSvqWCIM4HdPPXRIIEtwQlRvWq9KT8vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vgbRSu4bGpmM+0O8Ap6WDS+WOVU+ezWiZ2gbcNNszM=;
 b=IpY7y0hJ6eoaJfnvAJNXpFuXhZkmC0wyOh5WFrjwb90CzXxtE0+oV5yRpDvOqZ7cnn5qaLl2LqgPJQqKoKIU+chA6ppPpOAtNdAX3aWRi74msBePYwgKvDQjpdMz+lBVrFHx7ftRuGz5zlsgsAGDLfZhXDp0/f8qF2S8jWu4uJ8=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3468.namprd12.prod.outlook.com (2603:10b6:5:38::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.11; Fri, 10 Dec 2021 02:15:28 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4778.013; Fri, 10 Dec 2021
 02:15:28 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: skip gfx cgpg in the s0ix suspend-resume
Thread-Topic: [PATCH] drm/amd/pm: skip gfx cgpg in the s0ix suspend-resume
Thread-Index: AQHX7R1XpSff+IvoCkK78mE1XsMx3awq/G8g
Date: Fri, 10 Dec 2021 02:15:28 +0000
Message-ID: <DM6PR12MB26191BB3561752438A0F6DBBE4719@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <1639014681-16853-1-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1639014681-16853-1-git-send-email-Prike.Liang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-10T02:15:26Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=12c50368-775e-4617-9f0a-e1c60f0750b3;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a9a4100-8958-491e-61c1-08d9bb82ef4b
x-ms-traffictypediagnostic: DM6PR12MB3468:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3468E94EBE82D44979B19EE3E4719@DM6PR12MB3468.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q0FLrURcFFKq/RsGkuAegMJME+JIf+zEhV6Vemif04KddcuqlAzcrSfpNEmDcmp/0wUtPd6MvlMJfGXLbEYb54ITNY9GdMTs7FzE1S2ovcygr362/IkCGp3n/VtLKFHQywnlg1B6nn5CXImJYZ3HggvzAUOfI9cDdUnuwL8wFxREoBdpUNg7AzSXyoI/51cyrrrZ7ZDLSdVoqCkdbkiORN4n7Pyr4U6mvvY2xGFr196WJOUPGJ2RWIGByDuGb1byzy9Npp6nX9DfqKe0Tfa07Ne63dAt2cPXjEiOzb4evbAKcvPT1LnPrU09Ui0c63JP1PRaquQjfcGp9dFqLuyCu30mVuvRO4pr32knD6Mkp+SP5t41qr7uy2siMuZINtTmv7SpZqnD9EY/5Nfx3xI1uHIO+Cda5+PdNCgadIhQBvPP7prQtvQfEJ99KDC0wWDSxrs1UsFgiS5KkToELMJe+0cSZ58eU3nomdkqRNCupAwM2N9gnqcfjJmfMKZntVRSO0cKzIsLX5XU9WVDkqiBmNYHas1Md2/W40XlqndZtiBpce5vUgXsgCJeuXU+jk2QCOgG1665mOptDX1KHVhjNIehH6DZ5droCj7cBjuLCRTP6b28cmLg846B3WrJINwK6cGApMbWF2z/HVk29Zn4TS9HNkPlEH4keKb/qXLzGxgvaJcKDPyqSpCvuGaudUQbcioZCM6p9YAM34eZI9RfGamrOBhX/ViRMP4OIc7y5HY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(71200400001)(38070700005)(110136005)(54906003)(76116006)(2906002)(316002)(33656002)(8936002)(8676002)(52536014)(83380400001)(55016003)(26005)(15650500001)(508600001)(6506007)(5660300002)(53546011)(122000001)(4326008)(66556008)(38100700002)(64756008)(66446008)(86362001)(66476007)(9686003)(66946007)(186003)(7696005)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a0N3Yw6I/rIcteZcB+ezg3URuuMsXoiJSa4diSfG2u3biuYddizGYCEjxqx7?=
 =?us-ascii?Q?HaM+eF7Oqd6RkEHOQftIn3QZjhSZSPO0OKk/1SWHGU6e01avY+OifqkTUyCK?=
 =?us-ascii?Q?ex09VdmuoiWQNueopc5bbLtVX79zLypp8Ds627HEj610MdCc1wz3tjQQJexf?=
 =?us-ascii?Q?sQRW9LGhHFJzS1yHxyAFsxiop6dZ/w0CxNby9+ZLCxet0e5ok5GeKHBDur+R?=
 =?us-ascii?Q?plF8GfF3jDJsUvgvR6/vqi82jWOYESMzr1iKF7G9VvI/mq6tx9Mz8SSQQMIa?=
 =?us-ascii?Q?KbXKA82pa9+nQ0sSBhQrMLBgiGGpqrDaYoYT3GW+xZVLAD2uZ51LJkz0yp1Y?=
 =?us-ascii?Q?qClmWkIrQmBpQGp5hbMad7IfLUPLM+0X87sX3i71/2qRws0lwsm7mUeXAF13?=
 =?us-ascii?Q?NTnNzfYuZu1znxVthZiQsA0ZD6nzjeO+Xw8BU/4Kkmev2opltbyqVO8F/4th?=
 =?us-ascii?Q?/hewQaJFw1vE1a6IPFt9SzBoD0OfNgb7LgCiVr2BN97pgODh9NHfz+xaL19F?=
 =?us-ascii?Q?4et4WVLvFdnBPphJ5Mg44V+K6DvnS1gdjJXj/VigpTqSXgjNyyV976xOtB3x?=
 =?us-ascii?Q?x3j5iRlqrd/RTIl+j1Bnp1Wrij0G96A1bnfbUcKMN0ydHdLf9jDAkkup62aQ?=
 =?us-ascii?Q?RtABWdnym+kv4O5VLstcyA0+RHDvgxfllPaRLOVoc6g1g4XWSz8zwVsOSbvd?=
 =?us-ascii?Q?aujvv7xDtxq6DExza+g+pZ81VMPa1rDrbm7FyoaQVOjMMpBmWHLFBwgb5toy?=
 =?us-ascii?Q?K62HBrK36FreP1NrezaQOKIU3yDDGkLQ9pVQQ0qOaUPk77C0Bhdh83m55j/p?=
 =?us-ascii?Q?e670fccoHlK++AD+XFdlimDA1cKBC4s59WjMALjLWaG+/KjC/CG8xV1twdLd?=
 =?us-ascii?Q?3I7hsIwDupi2kLu5wtXxBu8VwPVWnyMP1yaWi1MfzFPElel+FOy/VZ2zveTl?=
 =?us-ascii?Q?/5RHibjgqBNbgODwUtpB+kbVus5gMjkJ5T1WHmMBG8hnSQWJkyIcMF1mji1P?=
 =?us-ascii?Q?qXSk4KOISL7jbhEQR5evzT+ILr0jpXc/iDybRvYKT4BAxpu1x5P3suiOJCnl?=
 =?us-ascii?Q?nsLfk5Q5FtoHHeiOsUoygcx+Df4JeZ/EaM0kzzYUM9Gc+1JbBTMisnHhm7e+?=
 =?us-ascii?Q?YMP5csehp8sJGVhm18AunkqfAV2Rq1SCBJwLMGw+LcIwqDiHnxpDAQKtvwQG?=
 =?us-ascii?Q?L26mzfIZqT+4W6jyeoclfVOk0bBLLwVIcuWxO0/OQJEPvp3DD0olJ5rtcNs9?=
 =?us-ascii?Q?b2kPiydd+4SdvMkGXZe8flm3z51x3YNcsIhdJoZhdwxIn21RU2c3MpBUxHkU?=
 =?us-ascii?Q?/S98Yho1IgB0m4wVsivDrQnOYiw9yIDDQ8Sfdzf/ejlGJCpe3ehDDS/xNp9H?=
 =?us-ascii?Q?4JnofUKhBhG0rbga0R/QnodhOkn4aJTIBUhk/qfk4Y+LgRni4R+Dczu/2Jxs?=
 =?us-ascii?Q?WaJxlFzCM/VXHZK3aSrRIfbyUtqa93jf3NqMnTysG6O98sR/hfkTxIqJpUy7?=
 =?us-ascii?Q?g80rUVG1WQ2xcmM9zzy42iSDcMPCLJ8xpa3ODXrSjMMq+NVjNQ/ZlKaKtYlW?=
 =?us-ascii?Q?ICzUvNE5yJO4TBFdcw4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9a4100-8958-491e-61c1-08d9bb82ef4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 02:15:28.3104 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VQ441JUIcHuzA93f3lDSpRY+w8/zacIe31H2vB7epBSTaKK/26z8alXlm6KpM87U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3468
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liang,
 Prike" <Prike.Liang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Prike Liang
> Sent: Thursday, December 9, 2021 9:51 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Limonciello,
> Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH] drm/amd/pm: skip gfx cgpg in the s0ix suspend-resume
>=20
> In the s0ix entry need retain gfx in the gfxoff state,we don't
> disable gfx cgpg in the suspend so there is also needn't enable
> gfx cgpg in the s0ix resume.
>=20
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 5839918..185269f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1607,7 +1607,8 @@ static int smu_resume(void *handle)
>  		return ret;
>  	}
>=20
> -	if (smu->is_apu)
> +	/* skip gfx cgpg in the s0ix suspend-resume case*/
> +	if (smu->is_apu && !adev->in_s0ix)
>  		smu_set_gfx_cgpg(&adev->smu, true);
[Quan, Evan] I was wondering can we move the "!adev->in_s0ix" into the ->se=
t_gfx_cgpg(for now, only smu_v12_0_set_gfx_cgpg() supported by Renoir) impl=
ementation?
Also, considering this is only supported by Renoir, we may be able to drop =
the "smu->is_apu" check.

BR
Evan
>=20
>  	smu->disable_uclk_switch =3D 0;
> --
> 2.7.4
