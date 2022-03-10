Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813D4C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 14:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E064B10E4B8;
	Thu, 10 Mar 2022 14:15:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01B1810E4B8
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 14:15:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKlxexs31Dw+WXG+qHitkAQl1XieAIX+zHdyXgjNTJjsV2mWnVXVt4uoBb8fo39bJUA8/ibIos5itY+26ubZJc1HRfUbiuVChWBaJ+lLlEZIEQfLgrQFrS4ojHMxYExtNw0V6E6YJcd5iJuZZ2UVYoL8/xN0feRW/HpULTusk18wdRrIxukwpAdyVf3fcY2SmBgVLx8yrwgzo9XP3zDE/G7dNdSBI5i6+pY0wzPejzX4PT2/1u/FbfMlN4xB4nKzgFHrWUD2jkc0EViwK40hI1OUybfA8iv3CYEubLWlp700MzsuFevmp/qGxxJzcRAvcGd+QYLe7dnu4go8zozvBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFYoPmYdDX4sUEGEtpZkehDpI64NdGgDlGACInxjKr8=;
 b=PGA6hrSEFUrFQeZSz2Plr4qLZtJe4Hgtu2IPOiv0/xrIWu6osXFLTnxU78C/1jwecPe1512y64D2gz36Y6Q0JfmqQrxWsPZ9tFV2PjkG+J1Cy/8Y+sT2wRUT62ErQgjbnLt+q4Q+uELPHmh6sf60npWbGvn0zcEDA+/dO+W9EVe4yYPq6e1l80hakUpjtH3esH45fT4jKJDL8H2M+JclbAz7Je9ojkJrayH85lI5AhknamdI1JbH/w8Lg0tQBpAcpqrjpXEUwHP0v2vIyxEl2Stg/uTp0dMRIV4/bSjPglhvUxVUKJ2rTulf+8eefEzb9Bbc0vCTGLQgDXiB3C46+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFYoPmYdDX4sUEGEtpZkehDpI64NdGgDlGACInxjKr8=;
 b=TpaPxzFP5qWxwkk+SKO7PDtQP7MqMjDynZM2ttKcne+lOMza8weHa0YLyo6NzWMzTW9VORM9zQK6fUKAskWymc0Ah0JiAL+zFxbQpVMlHGYrtL7isUB+IlzNl9hqF4xAwxe2Yf9HM4bvAvTjArbYXq2zrtToh60Psfsd7IXpdOU=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 CY4PR12MB1335.namprd12.prod.outlook.com (2603:10b6:903:37::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.17; Thu, 10 Mar 2022 14:15:29 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::ac69:d13c:c740:947b]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::ac69:d13c:c740:947b%5]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 14:15:28 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amd/pm: use pm mutex to protect ecc info
 table
Thread-Topic: [PATCH Review 1/1] drm/amd/pm: use pm mutex to protect ecc info
 table
Thread-Index: AQHYNId2BdMU26Fc506qanvzXPOwiKy4qVuA
Date: Thu, 10 Mar 2022 14:15:28 +0000
Message-ID: <DM6PR12MB26191FEEAFADCA1CE0D31FF1E40B9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220310140214.2562-1-Stanley.Yang@amd.com>
In-Reply-To: <20220310140214.2562-1-Stanley.Yang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-10T14:15:25Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d95e13fb-5c8f-4e4c-b270-fcc5db7f2851;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c361e7e8-1f72-47ac-9ca1-08da02a06dfd
x-ms-traffictypediagnostic: CY4PR12MB1335:EE_
x-microsoft-antispam-prvs: <CY4PR12MB133599B362DBC26DEF790D9CE40B9@CY4PR12MB1335.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PllSYhieDNENiYM2Kz9PrpxsNa9mKu3lAOsHKe3gft/o2GZws2hdkvGeC8ncp2AFFZ+g15gFNPQIuUIw/7AlkLDVz5l79WjzxfXTthTq9gT88wxNDcmrW7ZqJSKaJ8zvVyqNp0VmWmTtEdH98Y7yTGET+98o4+USsfmonSndBVlkEKOAWST1/snM253fb8aChG2a4SAMPcTDxhucsiq2Oeus/oupYuRsuuKRspFcjvnOcudBu/lQEZWo7nsKwlDivXg1qJQZSzcWvLkFOejV6W+FvuRc/qwEm0i2hYd7fj0UDF01yPBqd6Sbn89AJsWGhJ31+agcXj3ABRrKDuHTHtV3bm/WKFxwVrHvrfmZJrttwo7xvgA4916WByIExuggNVLzs/zg+fVEYbvmweza/jvafw4SeBdeaPYRSScLIAKWSrcDAoO0sGAmfUGFjnIszyfOmMMW5/UuiSN57JZmGyUsXywmkD9mssF93anE/keN4yhHSYb84bCrCPnM4v/poqUQEv+jKHxV7Y2yYXRhXJzfLGn9tIFY6n8Y70FPnAQ3iYpqxNlLrZyChBFgyDuz4cN2LgQHdWMukgYZapNrYNmgurU/5P2NrAAkqa17ViHfjQBnaVkvB7LPDh+ndOzli6Slc9J2nq6KbCRoMoGRgjeiA56ZxsbbtHjta8OgiMDpwHBoZ2FbIAXqD8lCfgORKZo5julxNZFLfPz9PhiCzQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6636002)(4326008)(52536014)(5660300002)(66476007)(8676002)(66556008)(66946007)(64756008)(33656002)(76116006)(186003)(66446008)(2906002)(8936002)(110136005)(316002)(38100700002)(122000001)(86362001)(508600001)(38070700005)(71200400001)(55016003)(7696005)(9686003)(6506007)(53546011)(26005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pD6EZPtgWIZd/eWy5IIRgPTb0QB/r7qgf1kPyPv894zpPTEGaB3dIEvqisbh?=
 =?us-ascii?Q?V2Pa75e5YPLJwLgr9hEt40YFSUW8PY6Du59g+E4Wgqarwc/V9TqQMuhQ4Xmo?=
 =?us-ascii?Q?mmyKcFxr+scxhwlo8XGK9aDXT7Nyk6pTWmnrESEN4erd0OaR9Lq7oOFLm1yD?=
 =?us-ascii?Q?fIKWK1FVNlUESITUfjqhIcSc6nIZl8orrFOc54e6bUVzKKWH6lyXiQAfkJL5?=
 =?us-ascii?Q?Ftg/5Rxz5cFjf5plrdJA79uelIlAYWpIxMb6kyMgGir1Wo5gFkPXkRudQKJe?=
 =?us-ascii?Q?X7caH0h65vppNfFy4DwRQfpqE+QY30L7uXy/qlmxwX+IjrXV5naTF//jmMZs?=
 =?us-ascii?Q?LhosLZ0VB/XNZFI4pl5RCuXoNBMhZuyVYZT1n4jCqzjSWg2mgIJxUVdb6x7W?=
 =?us-ascii?Q?v53Y4cMk+ZcXBsbGqg+Nx2+pR9WLfrw7RzHvLdGA2c9XOKBPVnjPpfat3r1G?=
 =?us-ascii?Q?d9iGaAcLf5HCW3WtV0T1jsNbdSS/QgfpCe7k0cRtHROkI6Y5opriAPBtBABO?=
 =?us-ascii?Q?4vyOa2NySJPEvDUhYJMdwadkKBlfxhOUUWR7gl3ZhiA/xpX9AWG5NEhhFcNS?=
 =?us-ascii?Q?9eUQ7bIHePT42ApBdxKUbE97DthogSoKFqkcSmQeDtwDaHDb2t8CxFCwcuZV?=
 =?us-ascii?Q?hZmR1C0SrVf3SqD/CzmaFLxf4cZNQ78/R50Ly0jRAO97ah2rd+3U9flqCrBe?=
 =?us-ascii?Q?gzFbLVXrLn8KRj92MYcydsKfPengh295sOFM8xBVHDfydq7tgwdgw/N6m2Zu?=
 =?us-ascii?Q?Y1kgjcinWSMGBgYZK2d2RYXZ5+xB39gRZMAnNh90DakfSTIvuuJ4cJE9QmYh?=
 =?us-ascii?Q?O5w/VUuSPTbBBnrhECtPuv94ubCpMEC+st6xt8yIM+pwHjtssfAf+032ZxFa?=
 =?us-ascii?Q?DQzQLrKaixLYLPQSthe0oYJBbIvY1Uzt5pFifVT5t/Ky5bCYCNK6CTHgsOfi?=
 =?us-ascii?Q?q94S0aMRxij5RZwFMIceSCARF4ARz4f5yCRxGUmPPh/8VepsALBpeXmO7CDj?=
 =?us-ascii?Q?3ljm4N/VAcHuc0MU/GRURXD2HfP1R0I80kMByzvU7mfRxEe1YgERvWhU8hSN?=
 =?us-ascii?Q?SFDeMt2eWEfTF/2eCXOHrK5l1nnLCCv3js1ipdYel5bKDhWMBFPybp6A+LG7?=
 =?us-ascii?Q?syU9LoVaSrIowuyGKBTKt92YdnM6TreJvQAiZFCIKVJ/wflCJiENKayaYHiN?=
 =?us-ascii?Q?kR3Hg2q7RHValBCclWsUeQjui1X1TzO/iNDdWRzpM2qG8t5ESazjWj71TnVQ?=
 =?us-ascii?Q?LiwS1Vx+M2VVQnCqrqcNynhW/8gC3gQkZhUkfRtBdozCNaCTTNlE9iGUrQp8?=
 =?us-ascii?Q?pODbzJMpi6w7H7wEt4UeG9Ul88RNk6cYU5Q2iKBmtt0VAmOPuE0sQQR4aftY?=
 =?us-ascii?Q?YA/OcWottiSHVpC1yyg0LiYlx5PsBt/qyCDe7iwCl9la6aoR9F49SQO52SS6?=
 =?us-ascii?Q?dWSxa43ZNQ0ZxJdto/EU3otQHzDn47sfntTy3YOUihZhIF2z+3Nhq5/6HsU6?=
 =?us-ascii?Q?vpEopRX5QY1Nm0R+9c4mODi05/00GbRcMauSNDUUPJqi/bWUsCBjS0k05iAP?=
 =?us-ascii?Q?D7wz69sNJt9V0vIfr8A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c361e7e8-1f72-47ac-9ca1-08da02a06dfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 14:15:28.7519 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aTF7p0udCM5YN0UXLbcg3pLAaG3uNYVvU9mj172L5adj8gi+LNPvWO5qqFccd+qA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1335
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Thursday, March 10, 2022 10:02 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li,
> Candice <Candice.Li@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amd/pm: use pm mutex to protect ecc
> info table
>=20
> Change-Id: I6afe0332cbb20528648c38665264930d6b091c2f
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 9a892d6d1d7a..89fbee568be4 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -643,11 +643,16 @@ int amdgpu_dpm_get_ecc_info(struct
> amdgpu_device *adev,
>  			    void *umc_ecc)
>  {
>  	struct smu_context *smu =3D adev->powerplay.pp_handle;
> +	int ret =3D 0;
>=20
>  	if (!is_support_sw_smu(adev))
>  		return -EOPNOTSUPP;
>=20
> -	return smu_get_ecc_info(smu, umc_ecc);
> +	mutex_lock(&adev->pm.mutex);
> +	ret =3D smu_get_ecc_info(smu, umc_ecc);
> +	mutex_unlock(&adev->pm.mutex);
> +
> +	return ret;
>  }
>=20
>  struct amd_vce_state *amdgpu_dpm_get_vce_clock_state(struct
> amdgpu_device *adev,
> --
> 2.17.1
