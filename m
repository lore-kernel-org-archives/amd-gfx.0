Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D646C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 07:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D215210E90B;
	Fri, 21 Jan 2022 07:36:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4490110E905
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 07:36:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Th5qfR+A96OIIf2nDqJd0uc67ieXqNGuLzyWieo4yFZ1Mk/t5lelcvYLo4HqpgdaHYF/3LyTBaSuaMOm3t5Tl90l7lrbHRVGRJJMjq2RRDvbZ+TmPLV/ikFgiF/bTBrbibcts4nggjFgVwCxGjWOtg8GQJq3lxSxcKSYUOzR2H7+PdKa8XHNwIpjiztuTzv9JnAPVddAvSbuTb0dulU/iING964pY8ON3feaTjrwXIdSnAOA+k7mNXqr4u79VCiIQD4nznCaDt5xdnTMMMsdlB2m9+hF4C4ts/1uSzkTjz/FtURqoTQSNjDrRxh6/U7g1o2M+VYR3VLa7l0RBnibnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvROK2fC/DGTqtGYeqXfQgqqzjiAMDUFVxtGFriQuCc=;
 b=ke2HP7WyxtYZyc2ZM9rHe8I/c/DbvgeCeeMIOTdS5kG+pGh8uxA9lFNlTdnGSEQWNcLOGVuykGj9ZTqrkhEU1KPVXceqKqnb5PuOBMzjMOvdIPv31qvT79AH1z6B3b99WUIydX7yw4MyDZqfXmT4maBhW2hmZMhfoP4Pv5R2JpW0bZwALpXqBS5T2bpF5+TOkvpntpjMRvzEheJtl1zvxFMX5fRG/y7XosKJU/98HaIPTYx5keEcOksuDWLEUUFX5fhPahsa/pDe/GPrQ39aKXPMOkstO4iWqQr9OuOZs+zjZZbvBj7MB9oKEOsQ/T4wrh0mSkfWzJyFINdsNV5yHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvROK2fC/DGTqtGYeqXfQgqqzjiAMDUFVxtGFriQuCc=;
 b=PRIQD2OljBdd2DV4rjUliNLzLFw/SSsVyYJW0NWdGDayTrGiK3H1DO7D9rJvMlTyrVN3UcfnBn5m8QlZGfk7k+wIQpjut4DvY8r6TU9uC1gi06B4A5auYzyez76G8KfQR7YCPX4j9Avky79bIm5IIQYPhJ0wZG/VKPRWiUmzSSE=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 MW2PR12MB2394.namprd12.prod.outlook.com (2603:10b6:907:f::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.12; Fri, 21 Jan 2022 07:36:24 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639%6]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 07:36:24 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amd/pm: use dev_*** to print output in multiple GPUs
Thread-Topic: [PATCH] drm/amd/pm: use dev_*** to print output in multiple GPUs
Thread-Index: AQHYDnE2nDxk6lug+kOca4X6IYgOBqxs05WwgABCQgCAAABfcA==
Date: Fri, 21 Jan 2022 07:36:24 +0000
Message-ID: <DM6PR12MB2619FA41919BDB49FE27A44FE45B9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220121024639.810-1-guchun.chen@amd.com>
 <DM6PR12MB2619100E7D280FDA837DE308E45B9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <DM5PR12MB246963C0644A3BD1758B55AEF15B9@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB246963C0644A3BD1758B55AEF15B9@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-21T07:36:22Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2ced341f-1b67-41be-9af5-197824821330;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa1c1615-2bb5-4593-b711-08d9dcb0ba35
x-ms-traffictypediagnostic: MW2PR12MB2394:EE_
x-microsoft-antispam-prvs: <MW2PR12MB23948A1CE987F5D8C4868896E45B9@MW2PR12MB2394.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dzuGI4FEa5jS0lN1h3B4Ut2hZ6Q6393SnWYGbL536AwUP3fxX6lIs6IYQzcMfUngNQLn53AIg1dhA6OWAe8ZlayCENnMQLNip2WcX/7w8vmX6Lt2cJolltmSiunYKjG46boz0Oh8Z8gKw0ljzOSbd/i65ZDW+1OptdtVreJvsmJd8xZbsZIjtm7ctrVhs27Ru/oUj40Ysv8xSdWEvhBd9TCcNyL05zoaLnyefDYV9K0HDsxHJFI+0XGwABvsQpqeDyxtdaKR4kS4Rn7RRetxgKP98IVGgWTcImlsfI+kUJmqAShowHyWuewVz7SAPiXk7rXy/Yzlbm7m0Ws18MfbZV9yM8DAxOI0J3Ryj5brV7KKhMGhk+PCWbcs3jDl/k9pAQVyz9xHhCSgiMZ/DpeNmMFC65O50jwbMmfK3rHRHvWu/FQlasD3F4UQcYyVYEwYwJQdIep53Zl2e8uVuI2xCdNwFJaceoP1PBYVECSIRNBlkUFXFkLBxUpL2VL8JjTsAk0A8RI5Ki9P6hbNlfBP3++LG8Aoa1DDBxjf9PhFyLvx3ON6BiG5v734zEe615+dGnJDlgGMKrKWuf7OndMZ/O7jsq4zHo2MF0TSkKRgu2l/pgBjjFsk8tPMi+FykPoDUjvbDdQJ9yRx4cTXHqeJxOtfe2oYopZK08w5+fakOiUmMg14/aZwb9US0tpIPrz4SHkGGISopLOVNi1DmRgBY7Y9ah4wA/9qu3iqNBzC2fs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(122000001)(53546011)(71200400001)(33656002)(9686003)(8936002)(7696005)(64756008)(66476007)(76116006)(66946007)(110136005)(66446008)(52536014)(2906002)(5660300002)(6636002)(83380400001)(38100700002)(921005)(186003)(55016003)(38070700005)(316002)(8676002)(508600001)(86362001)(66556008)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?55gGgpB5ybIvABvOUVZwXw5LcBlf7Vh+T4XFhfTaAOhWNKfnFkZNwA11Y5QD?=
 =?us-ascii?Q?PY6AVBOcvPJcSnFqTSTPeOSeH5ulqXLEiDf/EVJfeJassXrOAS8+ltm3URSW?=
 =?us-ascii?Q?+NPwmhW5IiqOowV4OMcE7QocbkRSpzgX/TtHWUfarXQlJ0E9bmCAH+r/g9qB?=
 =?us-ascii?Q?yTmuNy9KvqVNgPldzEKdzNi4WqnaM7ZRvMEteRqHIye5jC+uJ/OadgfF3eJU?=
 =?us-ascii?Q?n/FhC+zNvFwfeQSZCvsQ68HWbym6LAXS2xoWZZ9SaLjK5A6of65MRn9kNqeT?=
 =?us-ascii?Q?fPDO3lBfVFKPbT0Y6VG5OwTNRKmajAbLQT+Zm2IP3uTU49Q39J2OzJlRomxe?=
 =?us-ascii?Q?M4aJ10vIDjDPTsmXXd3CgFCJCI9tacgL1EKUve2OON27JquSqLsjDftuxdXv?=
 =?us-ascii?Q?PF7++vmcnfw1hXBaMejm8ac2jRFOR6x2TE/RxhPWXSYplzMXe2BYJc1lyfUY?=
 =?us-ascii?Q?J3pO5aNJ0SJhCkHXQjO1I5pUKCsybqyjJUQAbEHapmmF62scu1PO3LwBB7tS?=
 =?us-ascii?Q?E3oXViI8s59aQ2VyIFj7qRikUFxrvpELh2Nt4OSCEDtMH9r82GEGZkMyCMzx?=
 =?us-ascii?Q?Dj9Bozvp4uOmbE42VQjPeOqqGb+HgLwXkml7pbksDDgOH6o+Td2HgTAHaEEu?=
 =?us-ascii?Q?vTKH4y+YeLVUcf7suFpjRUM5mArvEnkwrKJ5gv5Qtq93s/I1EbWOW/P+K3CO?=
 =?us-ascii?Q?/eQBOWPuI8g1KbzKh6lcN51O9PtFbfNiBBBUv23nFCIupriNEasoq35o+OlZ?=
 =?us-ascii?Q?jeksIm69uPOcVgQkSwP90AA1L/g5pvlv4oSzIMP5GxDR9dbu4nk6LrtvjzIr?=
 =?us-ascii?Q?4GtOSSudFfvuB7oZNUjl5kJGx++Wm9vzoDwZssBlaWRXKpSwOIO+WBjCpq+D?=
 =?us-ascii?Q?V09+9VI/SbAHALxMUNLJ/ER7eFeF39XXBuDQNZDaVL5tVbtfntZi85myokFd?=
 =?us-ascii?Q?3Qt+oslXL61OQky0m2gxHJxQn+dDdggA7Q7pvyjiJ7f76bHBbAwqF8ilLb6n?=
 =?us-ascii?Q?tJhG2fnfzOV8yRep6citE7BfgdvBj7mBy3DWfWVDMkttaJ1FBdKobbdXS4MB?=
 =?us-ascii?Q?c18wgeWhi/QYKLatPMvsnZMh0BaO8PDdEY6y7x3IJXJVrSeDyfDk4BeZeU6H?=
 =?us-ascii?Q?pvQdVrslcDXvhNA+1DqSAjEGWHcBcR6V+diuQ23WQhqD2RjG8UsO5Gzhx4Me?=
 =?us-ascii?Q?nbWhsT5Stzcy4BsFyts7azTQJRlHmGgm0OzT+xUgAspn03cvahA4QmW3SGnc?=
 =?us-ascii?Q?L3+Pk1vTUANpq5vEtHfN0LMxiznCVvyQKcxavUeALlWmFLUNhEcYBYcejf+N?=
 =?us-ascii?Q?DqntxvKqY1AV2bkB/LSO9A8UpKBM+XUF5O1A2TOf3oa9fi7gg5edakGsel46?=
 =?us-ascii?Q?uio/xUB6H6b9JDbFrN1y5VDLmR/WnMEwQJWID6wwKy0LLzk7M5qNUhjiuOXp?=
 =?us-ascii?Q?6PUMGOremdZG4EIlaw+wvMvjZkyBLNj9BgYxbDiNv7ABKJuqV3/E9f8NN9wS?=
 =?us-ascii?Q?AedjsFZ7Wa2zy1xdll25Qq8kmQ6lNWrxkdMl8Cg1ZBfQTKQMhfZxPbyTNwlt?=
 =?us-ascii?Q?tA9vy0GR63i2W8RcZms=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1c1615-2bb5-4593-b711-08d9dcb0ba35
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 07:36:24.4666 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pa0y0Nt3oEIWl4r04YOD3kwC16efxGw7UDeYHZs0mycTJZBmkFGR6fsBwnlXLji1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2394
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

[Public]

Sure, please go ahead.

BR
Evan
> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Friday, January 21, 2022 3:35 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Lazar,
> Lijo <Lijo.Lazar@amd.com>
> Subject: RE: [PATCH] drm/amd/pm: use dev_*** to print output in multiple
> GPUs
>=20
> [Public]
>=20
> Thank you for review, Evan. I will submit the patch with modifying the
> commit message a bit to align the indentation. Hope it's fine to you.
>=20
> Regards,
> Guchun
>=20
> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Friday, January 21, 2022 11:38 AM
> To: Chen, Guchun <Guchun.Chen@amd.com>; amd-
> gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Lazar,
> Lijo <Lijo.Lazar@amd.com>
> Subject: RE: [PATCH] drm/amd/pm: use dev_*** to print output in multiple
> GPUs
>=20
> [AMD Official Use Only]
>=20
> Reviewed-by: Evan Quan <evan.quan@amd.com>
>=20
> > -----Original Message-----
> > From: Chen, Guchun <Guchun.Chen@amd.com>
> > Sent: Friday, January 21, 2022 10:47 AM
> > To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Quan,
> > Evan <Evan.Quan@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
> > Cc: Chen, Guchun <Guchun.Chen@amd.com>
> > Subject: [PATCH] drm/amd/pm: use dev_*** to print output in multiple
> > GPUs
> >
> > In multiple GPU configuration, when failed to send a SMU message, it's
> > hard to figure out which GPU has such problem.
> > So it's not comfortable to user.
> >
> > [40190.142181] amdgpu: [powerplay]
> >                 last message was failed ret is 65535 [40190.242420]
> > amdgpu: [powerplay]
> >                 failed to send message 201 ret is 65535 [40190.392763]
> > amdgpu: [powerplay]
> >                 last message was failed ret is 65535 [40190.492997]
> > amdgpu: [powerplay]
> >                 failed to send message 200 ret is 65535 [40190.743575]
> > amdgpu: [powerplay]
> >                 last message was failed ret is 65535 [40190.843812]
> > amdgpu: [powerplay]
> >                 failed to send message 282 ret is 65535
> >
> > Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> > ---
> >  drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c   |  4 +++-
> >  .../gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c    |  4 ++--
> >  drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c | 11
> > +++++++----
> >  drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c |  2 +-
> >  .../gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c   |  4 ++--
> >  5 files changed, 15 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
> > b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
> > index 93a1c7248e26..5ca3c422f7d4 100644
> > --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
> > +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
> > @@ -208,6 +208,7 @@ static int ci_read_smc_sram_dword(struct
> pp_hwmgr
> > *hwmgr, uint32_t smc_addr,
> >
> >  static int ci_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg) {
> > +	struct amdgpu_device *adev =3D hwmgr->adev;
> >  	int ret;
> >
> >  	cgs_write_register(hwmgr->device, mmSMC_RESP_0, 0); @@ -218,7
> +219,8
> > @@ static int ci_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t
> msg)
> >  	ret =3D PHM_READ_FIELD(hwmgr->device, SMC_RESP_0, SMC_RESP);
> >
> >  	if (ret !=3D 1)
> > -		pr_info("\n failed to send message %x ret is %d\n",  msg, ret);
> > +		dev_info(adev->dev,
> > +			"failed to send message %x ret is %d\n", msg,ret);
> >
> >  	return 0;
> >  }
> > diff --git
> a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> > b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> > index 47b34c6ca924..88a5641465dc 100644
> > --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> > +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> > @@ -87,7 +87,7 @@ static int smu10_send_msg_to_smc(struct pp_hwmgr
> > *hwmgr, uint16_t msg)
> >  	smu10_send_msg_to_smc_without_waiting(hwmgr, msg);
> >
> >  	if (smu10_wait_for_response(hwmgr) =3D=3D 0)
> > -		printk("Failed to send Message %x.\n", msg);
> > +		dev_err(adev->dev, "Failed to send Message %x.\n", msg);
> >
> >  	return 0;
> >  }
> > @@ -108,7 +108,7 @@ static int
> > smu10_send_msg_to_smc_with_parameter(struct pp_hwmgr *hwmgr,
> >
> >
> >  	if (smu10_wait_for_response(hwmgr) =3D=3D 0)
> > -		printk("Failed to send Message %x.\n", msg);
> > +		dev_err(adev->dev, "Failed to send Message %x.\n", msg);
> >
> >  	return 0;
> >  }
> > diff --git
> a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
> > b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
> > index aae25243eb10..5a010cd38303 100644
> > --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
> > +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
> > @@ -165,6 +165,7 @@ bool smu7_is_smc_ram_running(struct pp_hwmgr
> > *hwmgr)
> >
> >  int smu7_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg)  {
> > +	struct amdgpu_device *adev =3D hwmgr->adev;
> >  	int ret;
> >
> >  	PHM_WAIT_FIELD_UNEQUAL(hwmgr, SMC_RESP_0, SMC_RESP, 0);
> @@ -172,9
> > +173,10 @@ int smu7_send_msg_to_smc(struct pp_hwmgr *hwmgr,
> uint16_t
> > msg)
> >  	ret =3D PHM_READ_FIELD(hwmgr->device, SMC_RESP_0, SMC_RESP);
> >
> >  	if (ret =3D=3D 0xFE)
> > -		pr_debug("last message was not supported\n");
> > +		dev_dbg(adev->dev, "last message was not supported\n");
> >  	else if (ret !=3D 1)
> > -		pr_info("\n last message was failed ret is %d\n", ret);
> > +		dev_info(adev->dev,
> > +			"\nlast message was failed ret is %d\n", ret);
> >
> >  	cgs_write_register(hwmgr->device, mmSMC_RESP_0, 0);
> >  	cgs_write_register(hwmgr->device, mmSMC_MESSAGE_0, msg);
> @@ -184,9
> > +186,10 @@ int smu7_send_msg_to_smc(struct pp_hwmgr *hwmgr,
> uint16_t
> > msg)
> >  	ret =3D PHM_READ_FIELD(hwmgr->device, SMC_RESP_0, SMC_RESP);
> >
> >  	if (ret =3D=3D 0xFE)
> > -		pr_debug("message %x was not supported\n", msg);
> > +		dev_dbg(adev->dev, "message %x was not supported\n",
> > msg);
> >  	else if (ret !=3D 1)
> > -		pr_info("\n failed to send message %x ret is %d \n",  msg,
> > ret);
> > +		dev_dbg(adev->dev,
> > +			"failed to send message %x ret is %d \n",  msg, ret);
> >
> >  	return 0;
> >  }
> > diff --git
> a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
> > b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
> > index 23e5de3c4ec1..8c9bf4940dc1 100644
> > --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
> > +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
> > @@ -126,7 +126,7 @@ int smu9_send_msg_to_smc(struct pp_hwmgr
> *hwmgr,
> > uint16_t msg)
> >
> >  	ret =3D smu9_wait_for_response(hwmgr);
> >  	if (ret !=3D 1)
> > -		pr_err("Failed to send message: 0x%x, ret value: 0x%x\n",
> > msg, ret);
> > +		dev_err(adev->dev, "Failed to send message: 0x%x, ret
> > value: 0x%x\n", msg, ret);
> >
> >  	return 0;
> >  }
> > diff --git
> a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
> > b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
> > index 741fbc87467f..9ad26c285ecd 100644
> > --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
> > +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
> > @@ -115,7 +115,7 @@ static int vega20_send_msg_to_smc(struct
> pp_hwmgr
> > *hwmgr, uint16_t msg)
> >
> >  	ret =3D vega20_wait_for_response(hwmgr);
> >  	if (ret !=3D PPSMC_Result_OK)
> > -		pr_err("Failed to send message 0x%x, response 0x%x\n",
> > msg, ret);
> > +		dev_err(adev->dev, "Failed to send message 0x%x, response
> > 0x%x\n", msg, ret);
> >
> >  	return (ret =3D=3D PPSMC_Result_OK) ? 0 : -EIO;  } @@ -143,7 +143,7 @=
@
> > static int vega20_send_msg_to_smc_with_parameter(struct pp_hwmgr
> > *hwmgr,
> >
> >  	ret =3D vega20_wait_for_response(hwmgr);
> >  	if (ret !=3D PPSMC_Result_OK)
> > -		pr_err("Failed to send message 0x%x, response 0x%x\n",
> > msg, ret);
> > +		dev_err(adev->dev, "Failed to send message 0x%x, response
> > 0x%x\n", msg, ret);
> >
> >  	return (ret =3D=3D PPSMC_Result_OK) ? 0 : -EIO;  }
> > --
> > 2.17.1
