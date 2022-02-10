Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BA3C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 14:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1A5510E875;
	Thu, 10 Feb 2022 14:04:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2DDD10E875
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 14:04:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uu6ZqYZjIuMRmxfcUsZDBj0ykfb+hRylf0LLr1ghWmucCdF/TYby5yZU6xTsgkZyTNC5VaVtuiBlGb0EFOpUizbR8cCV7Lu+SggGINZJbnhXK02Lxgx4hxc0Sl7I5aVyReALuX+Hfhi+2iW5qZP2L8AeBs6mQVwD5ENLh4Dv6g7nABlsSJRv4NLqenydeSEf5uFVD5rK9bU46SnQbRHnnezrFJl22FiVRXsBgfwYglHZFf64hXK12777qZZAmjpRBYVg8wvO0MGNWLSAa3JDLZDFz2PCqHYFK/JJ/NbRPR5mhY+hdg3PtbKwhk3vceqTeSUZy7JHJviB1IjQG/B7mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXxj0foFuSJzG0QGDgzxXjEmJAQy+7o/adfSagXjhcQ=;
 b=TGNipUMG0koYqbB4otJlIfz54e3xvizvZGvYyAmz8xw3beeZeeulx4vxSoHoW+wvynXwlrWBkE/hWO+0wBqPhoGx/zI7vk1hZ4QXVZ5SSQZjbdxNhDSNjDCa2nf4gArBxpQ9Ex+oliKF6fXt4/5s1fqceMgAbW0EowyhpNw1yT1Rh5cgQ97kpgvwvvF13o/DBm+qh3wWaZgYdCPnm7LkBtaUXogaTEeE0cF2zFf5+ayvbu9iObc7Bq4bhSlv05FxQAzgxQP5YvVYFxb1tVj2qahT64o2AEul15QiGVWOSXxORqAuG/Buv42ZW8sd+wXl6Gr0YZwMMiZY6SdWXjtjhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXxj0foFuSJzG0QGDgzxXjEmJAQy+7o/adfSagXjhcQ=;
 b=G9NkcZDWUvGW1r0fXUbD1ms/y5AcmCgkAx1GJk+jrvS1B9VVtDSU1TCP8NSjTczfvoZqIw3bawxuA3IiXky4O0As8MbHKjs1nyPRwCRg0Iz4qDxmOmW+QTG5CL+0O4OQSDz6G1c3iRyO/7NuDK8K161CcbsFgAnmXekgHkB28bY=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM6PR12MB3211.namprd12.prod.outlook.com (2603:10b6:5:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 14:04:48 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 14:04:48 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Mahapatra, Rajib" <Rajib.Mahapatra@amd.com>, "Liang, Prike"
 <Prike.Liang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: skipping SDMA hw_init and hw_fini for S0ix.
Thread-Topic: [PATCH v2] drm/amdgpu: skipping SDMA hw_init and hw_fini for
 S0ix.
Thread-Index: AQHYHoMU8Guv8NP4lkmx1o/laTSQ/ayM0Lrg
Date: Thu, 10 Feb 2022 14:04:48 +0000
Message-ID: <BL1PR12MB5157740FA3CFB17B93165A19E22F9@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220210133507.5954-1-rajib.mahapatra@amd.com>
In-Reply-To: <20220210133507.5954-1-rajib.mahapatra@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-10T14:02:47Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=eaa7132c-8ab3-4c77-a99b-8d45e74fbcb9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-02-10T14:04:47Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: f3aa5cfc-9471-40d4-a449-c3e817be675d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 797ff174-7b19-426c-907c-08d9ec9e4c89
x-ms-traffictypediagnostic: DM6PR12MB3211:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3211F6F189AD4B3E5333E6E8E22F9@DM6PR12MB3211.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:862;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eZEDu2Zm7MaE4dqAh+xqxheZ0whg/QVjismcryyklkPqOSDo+a8K0bdxSqUAsv0nlieU8cGR7e9IcPDoPnc+yROqYhV0rr29r96ZS5KTb2/xU62Co/2Km/n2WEGqjOlSxJqRS2ph9iZsnEK5RstC4Yop+ZNUUHQACxMBW5WmEDz4V6cq2xstNeFhvFAtYeerqyZyotIteClYVig4bFsGKWQiHS4XoKOdISyF3Z2dycR1h+WsiGLxXTMNssuTyg9gCtHbdj5a7i5pRaYj0K4cMILx4D5oOwUALCq7SY/0RiyTIzFhJMPjk0lgfWDtbJTNAGDSpRRGdBd9s4RX3pfIDM/4BqcndWKwvCm2o2STPqFa35M/eIgc+1aDCnxuOAW6k6jlv1zprcC3xt8yXKtaGZfMVNhMiDUWt4K/fe+UbAMv7PpYhkZLH0UBdAKGqLyJiFzXtr0c/KIQbwi14ozBxm/ZuFZuWsZihvFIrVRnrMqeULlYV7BKJ3TM8T/6+6lQgaCzEfOM0OzqJjA6143eK4VsgTtdY7AKYPqgij1MMGBsQKRRw/kueVdD1/a0RVO8sB5E+bCCV6FXgC/HnjcWN4C6tFxBEOA5JXBu/yjL9EYa0CoWwjIVDJxuKY6qyzwaO+qhxAMG+n8g2Jw41rVyHT5lAnjhUZ2veFIoGiASryJMUyzmy4Ff0j+225QM6FqAdb1w90Y30J+zZo1ixq/bFo6sCFtgdB0yl4yvN2Eowcg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(64756008)(4326008)(86362001)(6636002)(71200400001)(66946007)(52536014)(53546011)(76116006)(33656002)(66476007)(55016003)(8936002)(6506007)(66556008)(54906003)(83380400001)(110136005)(9686003)(8676002)(66446008)(2906002)(186003)(5660300002)(38100700002)(122000001)(7696005)(38070700005)(508600001)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z4Z9gQyVF/k9r57UW4XOxF5Dd+T73opQhthnmoPkev5sWo3wh0HwBH34SFKN?=
 =?us-ascii?Q?NtTi1ty6NwXI71Bii9I5AptjovHbL9176mEw3UTnh58qqzhmWQG+cbS21GS1?=
 =?us-ascii?Q?O4FkoNFfBL20QHlNQQMHlaodmA0VAnfZ+14Qw8c8v61eJBpLfc8uAPXT6iNJ?=
 =?us-ascii?Q?45q/XNuIMOojLpobv3bALA9/NvzGSQITG0/V5otqT/YEbXw3d6fWvpLRizUZ?=
 =?us-ascii?Q?mk/fyVP4sQRwqefMOf1R9d6lk2lX8Am9uu5CVKM0YZSCeArunILxesyRDjDf?=
 =?us-ascii?Q?LiYi+JpSEbYH7PNOehNwwy1n39+7IOmd7GgLCaq8F607zFKRvuSjvM6w3UvT?=
 =?us-ascii?Q?2/yKYZb+mL4XIT1Owu04cId/Cum3BC/sLZokRNW3jQ6BkJcPxIs6U1uuUgJO?=
 =?us-ascii?Q?mwKasexEeokUCXUN2PLmudj2mQNuLO+eAOCC85bwyH3BaruPwaEFWzSYt2vO?=
 =?us-ascii?Q?6SG7UFHW3soVkFXFoLd3BzumRm7L1LPoKrds62QPQKs0k6tLk2/40O9waVhQ?=
 =?us-ascii?Q?Mg/Ia5sAdOcQkVMmZYnWDGMYShPXO1F63ajngF3cI4arpgiHK480jPzsjD0I?=
 =?us-ascii?Q?o0y80XDtZySmhid9lK/6Ood5PrcKeQLH1FtHMvc5/pCbbB18c7Yk3MRp24Ys?=
 =?us-ascii?Q?3OAOZuN/vJDg0SoDfSPhBU6xNMLaclK3sn8SNNe8cTAZ6+/QzBuqoge2MWLS?=
 =?us-ascii?Q?dM5dXRvHwjWjmd8pIEQ3HNzomjzWHde2SOkd3CyK7Qh8DvZVVGL+rrWIhzvQ?=
 =?us-ascii?Q?JiA0h3KO/v050bhR1ynQyb6Snk7omO5pb/4yF0gqLAkP4lY5bb/oQz3AbJhS?=
 =?us-ascii?Q?/wNDmtQSbhJrd3UqdC9uyfqIJAYntBLiIoiBba4pqJC1dKZ2lPso3DOx66Cv?=
 =?us-ascii?Q?FZcHo08EhblbPzAIMFSwX6fyU4tE17Kwo1vHw1VYSn99TpLDPxxcrW0kwOpp?=
 =?us-ascii?Q?sZ77QNLOaVGWgUoPBjqUESU+g6pkEUe2+dOBZ5BxCfU+vqzvcDQlg/btFKml?=
 =?us-ascii?Q?REfhMetIsYTCHqB/v13Eigu1xTbwJw9nEA1/Rz02npQr3RPFuigeu5E/bGfh?=
 =?us-ascii?Q?oJ/LPhrH7RsQ2t2GqSJJtHv5ZVVuMVXDW2n7k/Bdu4jTaG8bb2rRmPSXUoYp?=
 =?us-ascii?Q?hKEGIOyanHv+cPDG96TNyTjFuiLpcNYKVG1+dlJ4YRraxEHPteQd67S3TDEz?=
 =?us-ascii?Q?gAuxRR2thheMBV6L6vE7U/dp2E2FGo9bnzo11Kz9QCs5LCDbRh6PdbN0xeVG?=
 =?us-ascii?Q?6Y9sbn51E/vAaYeGSwVwOmHZEeNy9XeoUh1rdx1hXEHHRStrgdJLIEo2G2TW?=
 =?us-ascii?Q?cAzsn5J0P3t9TcRDV7OJMxCJREPT87wIXfVrJSMdNpOQieXxKRV9BXsoolwa?=
 =?us-ascii?Q?qnNWrNUFpaJvnrGckSuxiJhSVlyHqrqrKkEqGjBqAA/oWHBD5Ths51ZJ3vKG?=
 =?us-ascii?Q?Ewf2q6I9Ygg8hrjJ70UG9+Y0z8QBPougBRvi+gWIWpyVTTC9PeAvmdpfo9nM?=
 =?us-ascii?Q?80+eyNjb1kz6gvIpH1chFYdliBz6rnQrEbIYfOHPDSlxhRkvCsscUHGtKXCA?=
 =?us-ascii?Q?lV49QmNrw0wQebCG2djY7vV9+w8te2ADUQUU8KXRxXPHN9bqqYZnoK3PKcV3?=
 =?us-ascii?Q?Ky6HhGIUKpRtIc4pbjVC0CtL11vVz4EOy8nEnPwTdl9S10viHNWFktqSZ1P4?=
 =?us-ascii?Q?heYfRA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 797ff174-7b19-426c-907c-08d9ec9e4c89
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 14:04:48.2082 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aVvWKltbsyyrm9v43C+oVsHhMURyokF3CMFZFA/g74nQapBK0241s1gc5kW4bSn1nit4JNLSUgd3/seOP5ahnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3211
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "S,
 Shirish" <Shirish.S@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]



> -----Original Message-----
> From: Mahapatra, Rajib <Rajib.Mahapatra@amd.com>
> Sent: Thursday, February 10, 2022 07:35
> To: Liang, Prike <Prike.Liang@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; S, Shirish <Shirish.S@amd.com>;
> Mahapatra, Rajib <Rajib.Mahapatra@amd.com>
> Subject: [PATCH v2] drm/amdgpu: skipping SDMA hw_init and hw_fini for S0i=
x.
>=20
> [Why]
> SDMA ring buffer test failed if suspend is aborted during
> S0i3 resume.
>=20
> [How]
> If suspend is aborted for some reason during S0i3 resume
> cycle, it follows SDMA ring test failing and errors in amdgpu
> resume. For RN/CZN/Picasso, SMU saves and restores SDMA
> registers during S0ix cycle. So, skipping SDMA suspend and
> resume from driver solves the issue. This time, the system
> is able to resume gracefully even the suspend is aborted.
>=20
> v2: add changes on sdma_v4, skipping SDMA hw_init and hw_fini.

This line in the commit message should be "below" the ---

Besides that the code is better.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> Signed-off-by: Rajib Mahapatra <rajib.mahapatra@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 06a7ceda4c87..02115d63b071 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2058,6 +2058,10 @@ static int sdma_v4_0_suspend(void *handle)
>  {
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>=20
> +	/* SMU saves SDMA state for us */
> +	if (adev->in_s0ix)
> +		return 0;
> +
>  	return sdma_v4_0_hw_fini(adev);
>  }
>=20
> @@ -2065,6 +2069,10 @@ static int sdma_v4_0_resume(void *handle)
>  {
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>=20
> +	/* SMU restores SDMA state for us */
> +	if (adev->in_s0ix)
> +		return 0;
> +
>  	return sdma_v4_0_hw_init(adev);
>  }
>=20
> --
> 2.25.1
