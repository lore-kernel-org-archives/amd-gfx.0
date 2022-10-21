Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF6FC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 02:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ADD810E54B;
	Fri, 21 Oct 2022 02:51:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67EEE10E54B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 02:51:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MB/rJTfVilu95g5q9fo5nLqt3RJ1eKYHgxYht3MZDD1Wrp6N+dn8h6H5s3xr3fKk2nZs1OcLg0hIDvv+wYj4echydVoqIECsEE5648zTEmYmV2K0nQr4OoWObzoGqaOb4pCXHov5XZ/lePh7W/gCIHZurkxxyxKoNHQgCIh07RwxFImKK94sT/N8lHtYPD1BELi+0iyGpfP3IcAIsWjRe0Tk1DwbhCDKWFDIYrqSzQv7Qfdc6fCiAn5V3L5NM+2p7fdlQS5gLBAb6pDZ8JR99dwBSmSj8yxAyHu8WJNDsCkYE9alqzgsQfwMYvTNjakDigByeZ1x2Kfn0zHa/Q21UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIOY/DqkQvjQu9qNKHK/sPvt/FMob9Lg5tpRV5vz84s=;
 b=M8BnWpvX+eVElMw0jgMyw2IA9kBSrmk3gzKm+o4+fw2PFE23/1f3uXlh8gnDIgyv4Kl/DZTIla6XWxX/KerhRfBrmgTuF1kuCk+e6nOU9u6mLLxsGT9C5zZe0NmVGe7lGjvT4Xwd0rLL6ARcbnEnDjV5iFVgCP5uwNp792SH5sUi4wzGeC92lALd9YBmg0b/TmFXqX1Gi7Ixfru2LpbDQ/PUMApY6wjzVq9dzURJTiAM/mIV33wH1axy2B+qcTYqyPeLKdfLeaPzRRZCUOXvHAOqzNzaLeRdvGfqsWhL1jJdl5tJEwWSahm4xCX0vdSW7C8RU/kJ8U450Q8t+Fhg5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIOY/DqkQvjQu9qNKHK/sPvt/FMob9Lg5tpRV5vz84s=;
 b=EVi7bta+aO0mYoGpcsVVBzItEJT6oLv2cWzT7Q6FUH8gESHLJWTB2xdLTlPRqHxSnkQFa8BXVjHjDDwRpaaTJacA+dSJ5jJiLtMrBCWDgHYhN64ju1SCLvED+IJ2rnZkdq02K2urb69NR1jsIBiY1RY+6gLpaMI5nPdynUWkKY8=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by PH7PR12MB6396.namprd12.prod.outlook.com (2603:10b6:510:1fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 02:51:16 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::c573:5276:735:34f1]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::c573:5276:735:34f1%7]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 02:51:16 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: remove ras_error_status parameter for UMC
 poison handler
Thread-Topic: [PATCH 4/4] drm/amdgpu: remove ras_error_status parameter for
 UMC poison handler
Thread-Index: AQHY45KM7t96yQGbmkmH/8IWlJEMWa4XBdkAgAEhWPA=
Date: Fri, 21 Oct 2022 02:51:15 +0000
Message-ID: <DM5PR12MB17700209CC7330CFB2A65E8EB02D9@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20221019081150.31773-1-tao.zhou1@amd.com>
 <20221019081150.31773-4-tao.zhou1@amd.com>
 <BN9PR12MB52577A091E6ABE7D897CC8F5FC2A9@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52577A091E6ABE7D897CC8F5FC2A9@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-20T09:29:46Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0d3c6c90-131d-49b7-b1b9-df1aea2103fb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-21T02:51:11Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: a80714ae-11c2-47ac-8853-eb0476368889
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1770:EE_|PH7PR12MB6396:EE_
x-ms-office365-filtering-correlation-id: 0e60303b-718a-4693-7147-08dab30f1f7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xl8Ng0lWnbsil6SfI/I/6+5xu+eAYujmGG135dZrONnhK8764EBlrc1Am7RzHyvW9Jz2QNGQA/xvMaY/vo/FcgKUp2pSZfqImyFqf/SD37PijVosbJRxwS/NTDMzB1cJZ5D+3D9HNeSRgZ866Cfcg2nGxWkJD/c9ou1Q9TQ+cXRQHUe04v10vEfZLueQKdxITHSeQQfr8ArjThR7v+t3b/UdJBfiKjvNkWyaIB8W3FI3+4g2jUs7JRNNEcdzDd0EwOCLD8Hm25HApLZCntBfiycxnQcyFtLmlslqQhFwwuplYOhRcg2c8luD1C9y94yUwuTcEDdGvXvKlzOkUbQihG9amJCTEFW9nSZmHQk8HxW5hjrykkxwmqXx/d1FrBja938Sbdg/FME/wFR+Un5gV96HEiOpSXdrgmtv6SJJwsc5k91mWM46mhWgoqain0DmamO4sBwgq4wh3B3Fr+3qm5wmZEZhUBOfTrWj4X/f1cDlkRvu2am87RqMwXUzrbdJYn5gnsPGBU6CggxNtPRKjbGPMPtYDCjpXfYUw+NINAyFe9iIK8U/LRrot/JcaGdu7TeS9PpccwGBPTFblnytDdH0Cpw92QFuKtFOqTejmFpG60srUCSYpi/epLhU5e4C9pMS/1mTtYAz0sIcZnn1edhwmMP6TM2JlbWvpwqLr8BvTXKnQsGYw2U2PDrjIeGtUbW1MhOOzBEIpSpIAxXcuUpJA7VtT502e7VpWebpkdDwjqLh902naPAkJ2ZLpLEOw8EtRzlzBnspbGjBURR5mg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199015)(122000001)(8676002)(478600001)(38070700005)(38100700002)(71200400001)(86362001)(110136005)(2906002)(6636002)(26005)(186003)(7696005)(6506007)(41300700001)(53546011)(66556008)(66446008)(316002)(66476007)(52536014)(83380400001)(66946007)(76116006)(33656002)(5660300002)(9686003)(8936002)(64756008)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1SMS/CuSnJIP8+zHe2gQJmdT2Me3MQo/awwSjUbrLd/a6qcoMOClCOkF+pIW?=
 =?us-ascii?Q?mQtlLFDnifg4Ky0p5DzUJTSg7Qytxq5Mn/Bq3LeXwnObvVMXXMKrIaKTsepV?=
 =?us-ascii?Q?6hS3z/V0HdtOl55z8GOeCiMwazT3NnFbAHydRewJXt3oVVF+l2bLRdv/Z92b?=
 =?us-ascii?Q?ggNxxC+vVOU1AKcAm2l5raRHsftAdT1qvm4QsRWzb47+bL1lN0G+Cw4WRxcn?=
 =?us-ascii?Q?X9svokf+YkJ45qxJ4lT/F95oOIIf4K8inlLBQhbgIb8cxk0umN/0t4PQTEFR?=
 =?us-ascii?Q?o/fZ5V1aq8ZYeT9IDcSU3M+eyKIZ5O8VZ38bgKSN2jmb/4p6JzPx9XMYQCBD?=
 =?us-ascii?Q?5tKPb3kFFMHxPue34EeBgoWLnbhc62ojmkkqWBG7ScGDi+0xnzprFqCIZQxm?=
 =?us-ascii?Q?hijwu3ABpAfccDaSkBvf6GruoO7d8LQ7RakbQ/0vFrX4JMaLdV2wUnRgIap8?=
 =?us-ascii?Q?qAjC9ucSUc05OzvkoG3sR+ALDJNJnenNc+7ov+HJ4NrqdwFccJ49g1IiUtth?=
 =?us-ascii?Q?+n2skt3rOwAt8go5qy01985XGzkraeAzI19qVl+/C7XuK4iAn0mvmbI80CC3?=
 =?us-ascii?Q?g5B1ssipIVGT6lsnXppD/zkN1kpX+KzPBjLKqBH/o7tSkADj3jiQ9KaOv7Qs?=
 =?us-ascii?Q?LUHHJCLdtY2Qk9uOxEO4pWGXEoA7EcL3VNckp3/IN/aYPYLQ1uCd5BtvOIKg?=
 =?us-ascii?Q?yUHEfDaEBF/aFzT2lABL6w1YzSe3/X7kwnkO4OGSmaZqfaf8E4pSiZeQhoy9?=
 =?us-ascii?Q?8NH/F+UbQmRiPj0Ewo/aKXimFEl61wDT9U76/yu5D052KXDess9bHUT3L9ds?=
 =?us-ascii?Q?8HMtyMO8V9z9EL+pcMPs0g/R87hw+KhLj1PVGAcMgSBNbn0pupVRrbsQnQdO?=
 =?us-ascii?Q?MBDfG1NUN7gwXzwyN8zoteeCIF2UvGAA7KZiANLIgdtRAS8MAUnjjOhgpcvv?=
 =?us-ascii?Q?XA4ryZlKy49XyPU1PBbmdxL4S+C1MUQkSXM+VmMSXwAgAkZ631L92D2rFSVl?=
 =?us-ascii?Q?aJuLyHAMqa4+7PreUlT8djZa3DS3/ujzZdPdHLO/v0fUID2BFtmnQNN9MbRw?=
 =?us-ascii?Q?YmzyXYhf7WsWs924TI7ABocjkDirvcYWncK4jVxQVX6CEpOpdakHlV5bLolB?=
 =?us-ascii?Q?og90nslycQ0QQKG+BSX9GaxZp0BdJBB+hG+pCo7zVbrEN/iNp7NIMa+guCmH?=
 =?us-ascii?Q?e9ilMt0DYKHQ9gPlk7xhdgu1uwQFacdYUp2shp/aPh+cVryNEkXZxYC4rJ22?=
 =?us-ascii?Q?POkapa7bSR1SPaEuYpfcfv8Iw87kZujKo5RBqiKS00wfLam3TWw4V1xwMlxz?=
 =?us-ascii?Q?+Uv9LfYNhlSyXmFehWQUxKpZWWyJJ5PKeYQ1+Yy8yk4hQcjYj9iuYYwK0+Fk?=
 =?us-ascii?Q?+j9KOgFQAy6wZb0EtHzruulk4doWGD6rMhORb8mepv/a8BEdL8pfdebn2Vdw?=
 =?us-ascii?Q?QqIva/tOrtGuPsyHIUY//P+/ZD4IWMqVW3bt6oattxecF3/ZqUH0MwvOG/tH?=
 =?us-ascii?Q?cmz3rlzIOgtDCP28Q49hwDshVi6HwYee0Gh27tp+QfEBnUfaohNeKUZYjAbT?=
 =?us-ascii?Q?qAMQ6ji5qig1lvfBgKc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e60303b-718a-4693-7147-08dab30f1f7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 02:51:16.0320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M/64PDfNmjcK3dBF/cJ4OsOma/fvxyH69rpHkcyyiMZQ/YfaS5Z9pXcYIR0Fxi69
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6396
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



> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Thursday, October 20, 2022 5:30 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; Yang,
> Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li,
> Candice <Candice.Li@amd.com>
> Subject: RE: [PATCH 4/4] drm/amdgpu: remove ras_error_status parameter fo=
r
> UMC poison handler
>=20
> [AMD Official Use Only - General]
>=20
> Might squash this with patch 1

[Tao] This is a refinement different from patch#1. Both ways are OK but I p=
refer leaving the patch alone.

>=20
> Regards,
> Hawking
>=20
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Wednesday, October 19, 2022 16:12
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 4/4] drm/amdgpu: remove ras_error_status parameter for
> UMC poison handler
>=20
> Make the code more simple.
>=20
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  4 +---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    |  3 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c    | 16 ++++++----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h    |  4 +---
>  4 files changed, 9 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 0561812aa0a4..37db39ba8718 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -753,9 +753,7 @@ bool amdgpu_amdkfd_have_atomics_support(struct
> amdgpu_device *adev)
>=20
>  void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device
> *adev, bool reset)  {
> -	struct ras_err_data err_data =3D {0, 0, 0, NULL};
> -
> -	amdgpu_umc_poison_handler(adev, &err_data, reset);
> +	amdgpu_umc_poison_handler(adev, reset);
>  }
>=20
>  bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device
> *adev) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 28463b47ce33..693bce07eb46 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1561,7 +1561,6 @@ static void
> amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *  {
>  	bool poison_stat =3D false;
>  	struct amdgpu_device *adev =3D obj->adev;
> -	struct ras_err_data err_data =3D {0, 0, 0, NULL};
>  	struct amdgpu_ras_block_object *block_obj =3D
>  		amdgpu_ras_get_ras_block(adev, obj->head.block, 0);
>=20
> @@ -1584,7 +1583,7 @@ static void
> amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
>  	}
>=20
>  	if (!adev->gmc.xgmi.connected_to_cpu)
> -		amdgpu_umc_poison_handler(adev, &err_data, false);
> +		amdgpu_umc_poison_handler(adev, false);
>=20
>  	if (block_obj->hw_ops->handle_poison_consumption)
>  		poison_stat =3D block_obj->hw_ops-
> >handle_poison_consumption(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index dd1b1a612343..c040c9104521 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -179,27 +179,23 @@ static int amdgpu_umc_do_page_retirement(struct
> amdgpu_device *adev,
>  	return AMDGPU_RAS_SUCCESS;
>  }
>=20
> -int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
> -		void *ras_error_status,
> -		bool reset)
> +int amdgpu_umc_poison_handler(struct amdgpu_device *adev, bool reset)
>  {
> +	struct ras_err_data err_data =3D {0, 0, 0, NULL};
>  	int ret;
>=20
>  	if (adev->gmc.xgmi.connected_to_cpu) {
> -		ret =3D amdgpu_umc_poison_handler_mca(adev,
> ras_error_status, reset);
> +		ret =3D amdgpu_umc_poison_handler_mca(adev, &err_data,
> reset);
>  	} else {
> -		struct ras_err_data *err_data =3D (struct ras_err_data
> *)ras_error_status;
>  		struct ras_common_if head =3D {
>  			.block =3D AMDGPU_RAS_BLOCK__UMC,
>  		};
>  		struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &head);
>=20
> -		ret =3D
> -			amdgpu_umc_do_page_retirement(adev,
> ras_error_status, NULL, reset);
> -
> +		ret =3D amdgpu_umc_do_page_retirement(adev, &err_data,
> NULL, reset);
>  		if (ret =3D=3D AMDGPU_RAS_SUCCESS && obj) {
> -			obj->err_data.ue_count +=3D err_data->ue_count;
> -			obj->err_data.ce_count +=3D err_data->ce_count;
> +			obj->err_data.ue_count +=3D err_data.ue_count;
> +			obj->err_data.ce_count +=3D err_data.ce_count;
>  		}
>  	}
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> index 659a10de29c9..a6951160f13a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> @@ -83,9 +83,7 @@ struct amdgpu_umc {
>  };
>=20
>  int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct
> ras_common_if *ras_block); -int amdgpu_umc_poison_handler(struct
> amdgpu_device *adev,
> -		void *ras_error_status,
> -		bool reset);
> +int amdgpu_umc_poison_handler(struct amdgpu_device *adev, bool reset);
>  int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
>  		struct amdgpu_irq_src *source,
>  		struct amdgpu_iv_entry *entry);
> --
> 2.35.1
