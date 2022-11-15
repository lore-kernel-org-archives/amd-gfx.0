Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2557C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Nov 2022 18:02:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB4D410E08C;
	Tue, 15 Nov 2022 18:02:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0CCD10E08C
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 18:02:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAA8QqybfSgqfV27vLzrL6K+UsI6QhIbuHADKL3mPvhigA7soa+lU3Z9Fz0UysGdiVxhC9DUnqF4LBLGbC98Vj/oMHbWdkpT6l27mkA4XeYAaDqrECpNg0kg8jYBKyNTruOuxIlPV5dWisrbpgI+yc/71Z4LoeT/qn7236Y8QeaaevY9nk64xFR8gg76Hj/A9xSvKxW1jF1fBVI6d2L4RSr7Gpnjus0+ejYqNpHejjsw+Ns52NXOTYlOr7HiP4KUqu/lUU/++6dP+GSE+UoTxLbU6uHCCqvxcjjQpLICNvkb1anLXRBPYnFK2oCQFbRqN61nle6Zo6/vRmDsz2mQag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFlpYAIIg+gDCstI1q2CWgjiBFoRwNLb5EM0nEFzByA=;
 b=URSz2d2qjAb+9vwtbImpYrXYAOjS0hMwvFi+ZhkI7RcHjCo8NXp5ilPcXIJ5GKhZtHsoGT9EWNy/qNHvRkdWjlpKWxgEK5geDOXywUyzqQRsY+N5wPqpVnM+XRN9cymHuICG6Am4yuE+ANOGQw+fp600BAuZDSRzHZVFX0+q9n4vkJeG3VXj5AlMVXC0bSn2p/vfRLv0SD6qgeYYajj+J40yLwMhO9Sn9pDuUxXSwo663DrkDIPGgt3Axd+btfgJvbR29GirP2MxIHHeQZxCsRBtNzgzmIj1J83R7pDna84njX1gX6jA3WIVRp1hMIZi6SfwrRPy8q4Onclk3FE3/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFlpYAIIg+gDCstI1q2CWgjiBFoRwNLb5EM0nEFzByA=;
 b=N3l6Z4MQ1UeTSnicfMp6rHqFec9nP0kj1QiR7okcHuiFPyQ9bL80Z0YWl1Ovo8dJQqzsNNCv5d09mFzyA8L3QehfctBRZAZL9iKhkwCKtnYRXp1pH/cxm0r+hhnuDWMpfthquVhjQl/ufWAYDQUgojLr8dcxk5hWZfK+5CmW92o=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH0PR12MB5371.namprd12.prod.outlook.com (2603:10b6:610:d6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 18:02:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657%4]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 18:02:08 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Li, Roman" <Roman.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Rizvi, Saaem" <SyedSaaem.Rizvi@amd.com>
Subject: RE: [PATCH] drm/amd/display: Align dcn314_smu logging with other DCNs
Thread-Topic: [PATCH] drm/amd/display: Align dcn314_smu logging with other DCNs
Thread-Index: AQHY+G0R6PmpKai7kkKRGynCK+KzHK4+6itggAFa4gCAAAKn0A==
Date: Tue, 15 Nov 2022 18:02:08 +0000
Message-ID: <MN0PR12MB61012DEA5F98F7F51BD8CD09E2049@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20221114210701.23185-1-Roman.Li@amd.com>
 <MN0PR12MB61018FC7358247F0A2D476E9E2059@MN0PR12MB6101.namprd12.prod.outlook.com>
 <BN6PR1201MB008440D72339B49E7E576CF089049@BN6PR1201MB0084.namprd12.prod.outlook.com>
In-Reply-To: <BN6PR1201MB008440D72339B49E7E576CF089049@BN6PR1201MB0084.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-11-14T21:10:25Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=db96694a-48f2-4a3b-a61c-ab539de75e9a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-11-15T18:02:07Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: ff4f1759-a066-4cff-9dc1-faf1551338a5
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CH0PR12MB5371:EE_
x-ms-office365-filtering-correlation-id: 5f705dfe-4257-4c18-3e18-08dac7338333
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hht9vwl01cNXn9YIIymU+YyhcaLjplUEBwJVtbHdVlgZPZpYzJaKQnXIBKodA7Oyk+c46lniOTDA8BzBOb9RsKCax9oEs+I+JELZ5ZKfEciv00775mRmTlQtkqf24tYUIOtUgb7R+hE9F7Tf+nJGRA5/fI3m+5XfnQDMuXJRj+QEu6bbHBnFEqnOUsTIfu5rCay70S6toJLpj1k3YwwOAv0q1v/x5VOHYidzSQAPLtfCZDcvpOC+sTCRQFEQHhg5kdrgChG3DlfNG/rpK2bIDZwmuDljMH6z1SlBfzuZyXlfFTrzdDYr4gYpEMAaysWMEQVof6WoNhOgWBJyoR62I0YGf1+ih/iDZMFb7Jt1Lfc6XWLQwrAIinQI+XUJeCZlMQtDmtUeXP73xCvfke2syeuWxMWYViioqDGJZJhLl3DKbg2U7NxD2eP7xvfQLR3phyEm4HVI8C3sqLy8X0XmZz7iZEz9pFYup6bIBURTb/oQDT9f24C8FJN6Meyv/Wck8MMwetiXJDUUQYhcCEJnkm9WTReQbHTrkLppli452fYqLeeXEEkYtXzwdMEmtHTQyecM5SBrdPq/0lkepEnuk040bPXySit3mg4VbjYPXGswDyCtWqHJO1sXjLHm819A7nUVsFoQHMxVlSR3FobRuIeovubsvxMmV3tEMT+4FfmqUGZSmW49ctH3IY2O18vQhr2nOXqUPm0QS7/5f9NTs9iZj6qE8TBB1WSoGnUQze3hyoWcXPmGnl5YPeEVQONYTwEKY+dwsNmGulllxdR/Ag==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199015)(186003)(71200400001)(83380400001)(53546011)(6506007)(26005)(6636002)(7696005)(110136005)(9686003)(33656002)(478600001)(316002)(55016003)(86362001)(38070700005)(122000001)(38100700002)(2906002)(8676002)(41300700001)(66476007)(64756008)(76116006)(66556008)(66446008)(5660300002)(8936002)(66946007)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bTJwxHXnvBnRRh3nB+jSxSokUIkIuf50j3uMRp7w7mU4nZ8eOUoEmszn+vSO?=
 =?us-ascii?Q?ZrFD+CoPymTD2QgsvLhm3Uwd5R3L/9C1eEWN098ssGwJggsX43hpOYCkZ6JV?=
 =?us-ascii?Q?VnJEU4t/BAd0cRK/KqvMetAOOQ9ciKy/Ea0GleReIRqz9R1hvxYsMznvfvWR?=
 =?us-ascii?Q?miHQFDc/WqmYCCvSBJucl35wZXMkRdSlgth4TneYzbTH50FyMj70CYDXQpg/?=
 =?us-ascii?Q?mSKHIczyHBwQ80cyC2wCrEjq6hxSSGl4kqfiTGu197DnyQHftKO2BPfRtK/T?=
 =?us-ascii?Q?cFWW1sAUhsop8a9Ny+scjzPjYBQijj/UHfFCbpZxCTYtn+23wE7OAW1llW4R?=
 =?us-ascii?Q?Jmvg6SIdySl2AwQXzrE6iarDgyk6cN7CAH2zXHHYe/xtrJ8dKXreWfyP6XnZ?=
 =?us-ascii?Q?AvDqbYNcFcm7TwhdAMBH94vmviit6l+qO/+v8tkuCVcDzOxNGC2ntcUDAjHU?=
 =?us-ascii?Q?oDbK4aKiIEJEfM6fWwH9shRRtBX8GR2mtnf1sLYlCkNXKrAufVuAANy5mh9B?=
 =?us-ascii?Q?0s1oHGq2sxFUb+iSIIXwxNl7DlahdEC7fOnwo1iXKWJytDSI/BQAdL76hCZh?=
 =?us-ascii?Q?fxnNRE3vWu2lNNdaQj0Z+5UnxRZbZaRY7il/cblpSX0CGLnWCNQg2UZyoBYt?=
 =?us-ascii?Q?UDLZLDTv2IjrQeM22Z4LaV/dbJ/xOzjk4I7UciG+CVGvaJ8DR2KQ+CLMfsVU?=
 =?us-ascii?Q?wRmAJV3OY7fKKxWm01samu7XsOtmV8Bd/2tws9FIcG5eCvoJqW8Mte5F9AOi?=
 =?us-ascii?Q?QTew7bl0utnVTKlNNjbn8rDRFctn81BRI4K859ICdTJzYwqyg75c06VqyUHM?=
 =?us-ascii?Q?glY5vqmWMfJ9OhyQPTaJ5c3IjVyvQp4p+7sbY7bym5RSiSiP5KtzG9BVP5wp?=
 =?us-ascii?Q?3yp5txkanwBcfgtqLX069LeQX4d2BK39+++yZuCcFeMvUfAAgVE+T8Pv1zeh?=
 =?us-ascii?Q?k4rkkyF6dGTuKJSm70J2zOFZXFTxpv0m4hPIAlzHF2MAopx0qgqhcUiuXHtj?=
 =?us-ascii?Q?i8MOc7krthenC0d7WqdXuMDfk91nJf19uHgJbabw4PSRcl2mWao9HNRFe4yb?=
 =?us-ascii?Q?icBUGU5qO0OlFR4yCmKqiGTwGEMJrz6OIIvZNoOUy0dX3srMQ/0aZ0LEWySc?=
 =?us-ascii?Q?4GgshdJmtPTRnJaT8Qew+Uqa53+p5knUXfXoJEew86jKRX8vXy9aSWERLkpY?=
 =?us-ascii?Q?BvVWX/AZuFCZlEiXOha0OkJU2HdXplD4fvjkKx8ci7g4bAQHyQE+IGMCa9HI?=
 =?us-ascii?Q?oCXIzPu1CfuJUvTlFp7yfYGE2Ng8sWfNVfDzXZZAYrgdn7QgD7ShE4RHpW29?=
 =?us-ascii?Q?CLluw9cv/BfQz7KV4oKBQpBH2UUiDXyAahuL6f7RubSag1VRd01PcP/v6/32?=
 =?us-ascii?Q?4S4KgTxP4LbBZhPlDksEJ9q7N+vrMFLXC5H5WPMt4yuLPNEqJV1zsS8bDigx?=
 =?us-ascii?Q?q9gn3DLgAjWqM9bllENqQZZazSg0qZYhrPMbG3TpeUPEXbTWbRx7Dhl/vXGx?=
 =?us-ascii?Q?5W2olfOpEVr2HsPzRfvzYW9bMfgPwi6iRKdtaDLcp5hycvUGYwzazDCtT6yk?=
 =?us-ascii?Q?3GHiW34zBBbnrJ8g8g4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f705dfe-4257-4c18-3e18-08dac7338333
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 18:02:08.4310 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 27gD0wffToSgfsGlvm8lVKWar1orXJJY1GI1dCZYpvIuEDO1TvbhB8UxlZCen0tpTwLGPS44l15weJndkIwqbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5371
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



> -----Original Message-----
> From: Li, Roman <Roman.Li@amd.com>
> Sent: Tuesday, November 15, 2022 11:52
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-
> gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Wentland, Harry
> <Harry.Wentland@amd.com>; Rizvi, Saaem <SyedSaaem.Rizvi@amd.com>
> Subject: RE: [PATCH] drm/amd/display: Align dcn314_smu logging with other
> DCNs
>=20
> Hi Mario,
>=20
> Thanks for your comments.
> I replied  inline.
>=20
> > -----Original Message-----
> > From: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Sent: Monday, November 14, 2022 4:16 PM
> > To: Li, Roman <Roman.Li@amd.com>; amd-gfx@lists.freedesktop.org;
> > Deucher, Alexander <Alexander.Deucher@amd.com>; Wentland, Harry
> > <Harry.Wentland@amd.com>; Rizvi, Saaem <SyedSaaem.Rizvi@amd.com>
> > Cc: Li, Roman <Roman.Li@amd.com>
> > Subject: RE: [PATCH] drm/amd/display: Align dcn314_smu logging with
> other
> > DCNs
> >
> > [Public]
> >
> > Conceptually makes sense to me, but please see below comments:
> >
> > > -----Original Message-----
> > > From: Roman.Li@amd.com <Roman.Li@amd.com>
> > > Sent: Monday, November 14, 2022 15:07
> > > To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > > <Alexander.Deucher@amd.com>; Wentland, Harry
> > <Harry.Wentland@amd.com>;
> > > Limonciello, Mario <Mario.Limonciello@amd.com>; Rizvi, Saaem
> > > <SyedSaaem.Rizvi@amd.com>
> > > Cc: Li, Roman <Roman.Li@amd.com>
> > > Subject: [PATCH] drm/amd/display: Align dcn314_smu logging with other
> > > DCNs
> > >
> > > From: Roman Li <roman.li@amd.com>
> > >
> > > [Why]
> > > Assert on non-OK response from SMU is unnecessary.
> > > It was replaced with respective log message on other asics in the pas=
t
> > > with commit:
> > > "drm/amd/display: Removing assert statements for Linux"
> > >
> > > [How]
> > > Remove asert and add dbg logging as on other DCNs.
>=20
> I will fix "assert" spelling before merging.
>=20
> > >
> > > CC: Saaem Rizvi <SyedSaaem.Rizvi@amd.com>
> > > Signed-off-by: Roman Li <roman.li@amd.com>
> > > ---
> > >  .../drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c    | 11
> +++++++++-
> > -
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > >
> > > diff --git
> > > a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
> > > b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
> > > index ef0795b14a1f..2db595672a46 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
> > > @@ -123,9 +123,10 @@ static int
> > > dcn314_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
> > >  	uint32_t result;
> > >
> > >  	result =3D dcn314_smu_wait_for_response(clk_mgr, 10, 200000);
> > > -	ASSERT(result =3D=3D VBIOSSMC_Result_OK);
> >
> > Does this flow actually happen still?  I thought the assertion should h=
ave
> > gone away as a result of 83293f7f3d15fc56e86bd5067a2c88b6b233ac3a.
> >
> Happens or not, we don't  assert here on other asics.
> I don't try to fix any bugs with this patch, just align the dcn314 loggin=
g/bug
> reporting  with other asics.

Got it thanks.

>=20
> > Maybe we want to also undo the REG_WRITE() call there if pulling this i=
n.
> >
> > >
> > > -	smu_print("SMU response after wait: %d\n", result);
> > > +	if (result !=3D VBIOSSMC_Result_OK)
> > > +		smu_print("SMU Response was not OK. SMU response after
> > > wait received is: %d\n",
> > > +				result);
> > >
> > >  	if (result =3D=3D VBIOSSMC_Status_BUSY)
> > >  		return -1;
> >
> > I think what is missing to clean up recent asserts is actually a little=
 bit further
> > in the code than this.  It should be part of the error flow introduced =
by
> > 03ad3093c7c069d6ab4403730009ebafeea9ee37
>=20
> 03ad3093c7c069d6a is for dcn3.1 initially.
> If there's an issue with it (which I didn't experience) it should be addr=
essed
> on all dcn3x, that reuse it,  in a  separate patch.

OK.

>=20
>=20
> >
> > > @@ -216,6 +217,12 @@ int dcn314_smu_set_hard_min_dcfclk(struct
> > > clk_mgr_internal *clk_mgr, int request
> > >  			VBIOSSMC_MSG_SetHardMinDcfclkByFreq,
> > >  			khz_to_mhz_ceil(requested_dcfclk_khz));
> > >
> > > +#ifdef DBG
> > > +	smu_print("actual_dcfclk_set_mhz %d is set to : %d\n",
> > > +			actual_dcfclk_set_mhz,
> > > +			actual_dcfclk_set_mhz * 1000);
> > > +#endif
> > > +
> > >  	return actual_dcfclk_set_mhz * 1000;  }
> > >
> > > --
> > > 2.17.1
>=20
> Thanks,
> Roman
