Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CBDC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 07:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0501F10E36D;
	Mon, 13 Dec 2021 07:21:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAC9010E36D
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 07:21:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UP3aUEgqcT5LCw96Q/ZMMjq1YXpF0N1B9y2+oTWpY4x1ykZwzWUQkcbcXSDUwVxKEpUCmewxPc49nNV/WvXfKZqZItJI2MUZ0lq8J3cZ67P+CTTJ0iipJsgWpnnUtcTZqELTCkLMD3u+jrLZfZbbnaiLcJ2PDYgpHcgJ/HvMOvzct4DJmXOqm8Qb8SdC9B140cfjWc9UVdnnfPKmDqeF1GtqNdKc5N/yl3vF5raBM1qng2Q29A1NmoJUO/W7d2B+NBUO8WCMa4UXW5wvLmdOLSz1hXtF4+rSxfVKfOSQTbQA6/A8C+AiJygIqeN9T3zknuCcZmPwzKZMzH5ESZc/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NVlknDMd/5dk6Yc8q+Z+OtJN79nR3IVzjEjHsX37WI=;
 b=GOIVaU8ldLd4/2lyQ1+P3xQpRHpttuM8JRYcTpriCqoFIHdTOpUgzLRKtHMFSDtqwDqyuBb4fE/JTJApFyBKbRzJy36bJA7uolxtTyIMACkTSrvSuEBmQ/iG8SYy3tAMsTdBamWMZ+Ye+JIZ46PzTKYHXEejsA1MgJHcHOU+1INGqYXtv3d8wstkBQvm6VkAWYVjpg/+UE6c9NIJUrjfPdthB2xym8hryEaBM82OHOX66y08A/lrg5oAj13l3uXD2HaAgCRFnc35/SNUj3JlhA2zglF9TTmgoWIb/4eFIruQNxV8LrrzoSRpbOURj48MHIMe3ONsJNyC7r+ie1676A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NVlknDMd/5dk6Yc8q+Z+OtJN79nR3IVzjEjHsX37WI=;
 b=y9g7ePxP9rrPX1W5mSNE3/TnWfGqnh2PRCn9T2sX7EC6WTWIK/qRPGyfO6+DZPZGJEVpnUAW7Jg7zBoiMTtRpJi7JzqQcsurO2eX35uoDMYmkp04jBJJ4/Mkn3qqgSEDsTZujKqj8+c3zC7Z33iEDed6/sk7zOuroyjdusPKfIU=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1644.namprd12.prod.outlook.com (2603:10b6:4:f::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.12; Mon, 13 Dec 2021 07:21:01 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 07:21:01 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: move smu_debug_mask to a more proper place
Thread-Topic: [PATCH] drm/amdgpu: move smu_debug_mask to a more proper place
Thread-Index: AQHX7+RIHqsmmsPhMEy5uNUMGefWHKwv7jqAgAAV28A=
Date: Mon, 13 Dec 2021 07:21:01 +0000
Message-ID: <DM6PR12MB2619D0996B34E343DDEDC906E4749@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211213054241.773719-1-evan.quan@amd.com>
 <DM5PR12MB246976396E09AB78B215FEC0F1749@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB246976396E09AB78B215FEC0F1749@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-13T07:20:59Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=65b7bfc3-d2be-48dc-9ed9-d9cdfffc7448;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac80be48-4385-46dc-6681-08d9be091e0a
x-ms-traffictypediagnostic: DM5PR12MB1644:EE_
x-microsoft-antispam-prvs: <DM5PR12MB16447EDFA8B704E99C1D201DE4749@DM5PR12MB1644.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zxqtt0A5wMtb45WY49gbSqVw9pwqh1do46LNLkYjKRiRCrt/KlB02UayMyt1No4m965q7iEio9vVJcTEXzxHyxCtBrBw7IIMMuT0r7eu6+WERfbT7FJanF0kZI6FmA5UV8kEzgnQu3WKwPhH6cg75/uqYb1WtGA10kkk9SKfy6l2wv2TC6HwaRq+YNENCaPYfwWcs0QAnJvZdJ5gMBQseklATn42xlJsSUID/XIjRhygm+HQ8Yc5B/c9W3aKQx8zlpY5S00yYWhdpYJw2Vjhk6MHW0lBp/UzBRwdsJ511tsS+0vcJ0h6vH6JSAZW6BGx29nWJvuyJBo9p/31GV51JtwUG8NOD13FjZ57meKGqX9X5uwPMnV8VYB6saOoO1JDaNhTP4eHFvFvlpPPtBVYf1BRd/UNL90q3HN/8K/wplmebPLD648H+atU3w3BO5mBS5/C46/HV1X8gFZmHmZkUDRIasFEZ+Jft4XboQRaA6keg39quYqN73WNrvQr1v49tvfO3Y3jEoEliiGKCaTqCts+XYRK+SJD4w3u3zQrJmiF6ExOuFy4DV+B6GsHd95/kPRExa4UaDJgfcWxTbM4//QtnXLx7fEKbIqsNT6in5g7h0ADt7v3bRfLF2RWXPQaYbvjItvmNJESURoQyU4EkX8cVuWdnpA5wjjwwinPWDiMUJ+yLwW1hcrX7nPyiCNW87a1UJImwAXwSQPuuPt/fA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(7696005)(5660300002)(316002)(66476007)(9686003)(66446008)(8936002)(33656002)(66556008)(53546011)(186003)(26005)(66946007)(2906002)(4326008)(64756008)(52536014)(55016003)(76116006)(122000001)(8676002)(83380400001)(86362001)(110136005)(38070700005)(38100700002)(71200400001)(6506007)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+URmDrQluOte+VnM+Xk2cqnsgEC1nFyGLNzVai+f9lUYAOpT9ymlAurm7xzz?=
 =?us-ascii?Q?5XY6wUmpKkMmbe4Jtuw4W56MjgiC6kBmfjMaOhWFoItVKn16aPh3aqw1kzrZ?=
 =?us-ascii?Q?A6EbyPLQ8sqkUn6eb3Xi84b0NWbHu/R6tzBY2Zu2YlIf5mnN3/oFlOI61Q7G?=
 =?us-ascii?Q?AYUhmGNXf+vlmlhavq1JOo3ilqu9NCIJzJZkoihunhAyQgYkGbCteElZ3Wgw?=
 =?us-ascii?Q?bHZM8jrByx9W4ejqg5b7w2UWdppMhdd1j1AGerQtQKMrZOp9iJ5Qp74qGT5X?=
 =?us-ascii?Q?AthKp0xuHqdvlThaEVHXbKY4NyceQkIMO7DbEKAnlo13r2xK5H99rZitYecL?=
 =?us-ascii?Q?KeMc8T0ogl+vQGKO6uTHomBYZN/AaIZcQ0QmcpjpDLZZ2RGfa1QMX0ju9fL5?=
 =?us-ascii?Q?OkFltUZrkLhJ3fkrEGzblWqSsJAwmHCy4X0Q5AdR32ukwg/C1PNYkIpUV/6+?=
 =?us-ascii?Q?CIyBlp6+q8wn+cbVJ3TFv/VPbNUyZV6buC3PdeOIKPFZRtLUw2pKzqrv4VtX?=
 =?us-ascii?Q?thjhqE3qFDXaxT/UIk49EvXx1Ta/sfb6VlupW4Lqe6R6VRnLjliNmDaQpThb?=
 =?us-ascii?Q?H7HDdaoSDjWJXwVwRG+raK03O3ptLcbEkMGroLIexMWC0FBT9AFy6rwPuQNE?=
 =?us-ascii?Q?OUWi2Q+voR7/0X9J0fXF36HZUebv8/YmKgSi3Xr5JpyR1GSGMoat9SRoqAiz?=
 =?us-ascii?Q?oAIZwjZ4r+yTgYupeJ1SsTdLbu2UyElZ40CsYLvODNOmO3Pgcj5lQMEUu0CF?=
 =?us-ascii?Q?WVnu8dGUIJLLXRel/lInqfjcQA8U/TM0livcdt6Hz/S4RjHgedWy9LKbYBtx?=
 =?us-ascii?Q?8FYxHrMvlSd3BpuyB5ttlwCoEvwjE3axbxTogawASz6jg4xYTiFeL9Yqo2Ge?=
 =?us-ascii?Q?GFtGHUiBTw2F7O9luXC5cLbkz4eXQ13DHfUs7lK/CrteUib9MF5wC4D2Ufn7?=
 =?us-ascii?Q?BVGHqMCTnN5GaBr8VGMkTBz+FeP/47TFJ+luvBquavOywFSGVlFjc5iZVi07?=
 =?us-ascii?Q?Bj0NfsuTVGXZ127M+QqaDUic6H9BB+XhczXURVFwVymD+Qjy1TH44Cq3mFRD?=
 =?us-ascii?Q?KlS3579+RMfTLODMRSQpK7xYQw1zPyXOPZ+AgfmH90pGLKLmGUawuuZKGAde?=
 =?us-ascii?Q?A/DwwcJTlvC4nig3mj2f9Gy6Rv5v22HIyknmGexM5E9EsTxIeVNz1I3zpN2E?=
 =?us-ascii?Q?zHKIfnD6Tsf5v6jKZyOuR5LYC74cmaR+VTIk8165/9F6ejLTHByyymTCB/2J?=
 =?us-ascii?Q?7Kp7605gWInTbaW7Lhzw4oEfoj8iuoGzclRzCli0V1RVPc4tvJflcjFJlkEi?=
 =?us-ascii?Q?dy4qHxZagrutkujfQmmt90dCa1/T96FCKsolNIl1hOrfZtB7gvTAvkJLF+Oo?=
 =?us-ascii?Q?N6jzbldCEo38ojIP85q0GNH2f+bNrrgLNo9v0apb6VI4zeXwLIvwk4he4WwZ?=
 =?us-ascii?Q?f0IqL2Ohsyfu/EEzWyzhz1V7j4V+T7ZQ5Ux4Ybp9lpMiUv9ljiGGjGLoX2oS?=
 =?us-ascii?Q?QWcDUdZir5TJM+wLncIhwcNjtDwzck4HlpxYc+tlnF46/aWvdxkmdaoKtH1+?=
 =?us-ascii?Q?DjqyEyWFvd4TearzCgU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac80be48-4385-46dc-6681-08d9be091e0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 07:21:01.7007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mnABb2uazG+in2CLWYuz14asFm80RfOhmyVhXCoNfcspvv6lMLlgpasz7qnQhCr+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1644
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

[Public]

Updated in V2.

Thanks,
Evan
> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Monday, December 13, 2021 2:02 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: move smu_debug_mask to a more
> proper place
>=20
> [Public]
>=20
> -	if (unlikely(smu->smu_debug_mask &
> SMU_DEBUG_HALT_ON_ERROR) &&
> +	if (unlikely(adev->smu_debug_mask &
> SMU_DEBUG_HALT_ON_ERROR) &&
>  	    res && (res !=3D -ETIME)) {
>  		amdgpu_device_halt(smu->adev);
>=20
> [Guchun] As we have set an 'adev' variable, we can replace 'smu->adev' wi=
th
> 'adev' in each function directly.
>=20
> Regards,
> Guchun
>=20
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan
> Quan
> Sent: Monday, December 13, 2021 1:43 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>
> Subject: [PATCH] drm/amdgpu: move smu_debug_mask to a more proper
> place
>=20
> As the smu_context will be invisible from outside(of power). Also, the
> smu_debug_mask can be shared around all power code instead of some
> specific framework(swSMU) only.
>=20
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I1a0e1a436a51fc520a47b3fb28cde527d4e5eb6e
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 7 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
>  drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h     | 8 --------
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c      | 9 ++++++---
>  4 files changed, 14 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e701dedce344..9ceb8f3e73de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -811,6 +811,9 @@ struct amd_powerplay {
>  					  (rid =3D=3D 0x01) || \
>  					  (rid =3D=3D 0x10))))
>=20
> +/* Used to mask smu debug modes */
> +#define SMU_DEBUG_HALT_ON_ERROR		0x1
> +
>  #define AMDGPU_RESET_MAGIC_NUM 64
>  #define AMDGPU_MAX_DF_PERFMONS 4
>  struct amdgpu_device {
> @@ -959,6 +962,10 @@ struct amdgpu_device {
>  	struct amdgpu_pm		pm;
>  	u32				cg_flags;
>  	u32				pg_flags;
> +	/*
> +	 * 0 =3D disabled (default), otherwise enable corresponding debug
> mode
> +	 */
> +	uint32_t			smu_debug_mask;
>=20
>  	/* nbio */
>  	struct amdgpu_nbio		nbio;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 9dfccb20fedd..ee1cc15c6f09 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1619,7 +1619,7 @@ int amdgpu_debugfs_init(struct amdgpu_device
> *adev)
>  		return 0;
>=20
>  	debugfs_create_x32("amdgpu_smu_debug", 0600, root,
> -			   &adev->smu.smu_debug_mask);
> +			   &adev->smu_debug_mask);
>=20
>  	ent =3D debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>  				  &fops_ib_preempt);
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 12e67ad9a3b2..2b9b9a7ba97a 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -482,9 +482,6 @@ struct stb_context {
>=20
>  #define WORKLOAD_POLICY_MAX 7
>=20
> -/* Used to mask smu debug modes */
> -#define SMU_DEBUG_HALT_ON_ERROR		0x1
> -
>  struct smu_context
>  {
>  	struct amdgpu_device            *adev;
> @@ -573,11 +570,6 @@ struct smu_context
>  	struct smu_user_dpm_profile user_dpm_profile;
>=20
>  	struct stb_context stb_context;
> -
> -	/*
> -	 * 0 =3D disabled (default), otherwise enable corresponding debug
> mode
> -	 */
> -	uint32_t smu_debug_mask;
>  };
>=20
>  struct i2c_adapter;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 43637d55fe29..b233d9d766f2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -257,6 +257,7 @@ int smu_cmn_send_msg_without_waiting(struct
> smu_context *smu,
>  				     uint16_t msg_index,
>  				     uint32_t param)
>  {
> +	struct amdgpu_device *adev =3D smu->adev;
>  	u32 reg;
>  	int res;
>=20
> @@ -272,7 +273,7 @@ int smu_cmn_send_msg_without_waiting(struct
> smu_context *smu,
>  	__smu_cmn_send_msg(smu, msg_index, param);
>  	res =3D 0;
>  Out:
> -	if (unlikely(smu->smu_debug_mask &
> SMU_DEBUG_HALT_ON_ERROR) &&
> +	if (unlikely(adev->smu_debug_mask &
> SMU_DEBUG_HALT_ON_ERROR) &&
>  	    res && (res !=3D -ETIME)) {
>  		amdgpu_device_halt(smu->adev);
> [Guchun] As we have set a adev variable, we can replace smu->adev with
> adev directly.
>=20
>  		WARN_ON(1);
> @@ -293,13 +294,14 @@ int smu_cmn_send_msg_without_waiting(struct
> smu_context *smu,
>   */
>  int smu_cmn_wait_for_response(struct smu_context *smu)  {
> +	struct amdgpu_device *adev =3D smu->adev;
>  	u32 reg;
>  	int res;
>=20
>  	reg =3D __smu_cmn_poll_stat(smu);
>  	res =3D __smu_cmn_reg2errno(smu, reg);
>=20
> -	if (unlikely(smu->smu_debug_mask &
> SMU_DEBUG_HALT_ON_ERROR) &&
> +	if (unlikely(adev->smu_debug_mask &
> SMU_DEBUG_HALT_ON_ERROR) &&
>  	    res && (res !=3D -ETIME)) {
>  		amdgpu_device_halt(smu->adev);
>  		WARN_ON(1);
> @@ -343,6 +345,7 @@ int smu_cmn_send_smc_msg_with_param(struct
> smu_context *smu,
>  				    uint32_t param,
>  				    uint32_t *read_arg)
>  {
> +	struct amdgpu_device *adev =3D smu->adev;
>  	int res, index;
>  	u32 reg;
>=20
> @@ -372,7 +375,7 @@ int smu_cmn_send_smc_msg_with_param(struct
> smu_context *smu,
>  	if (read_arg)
>  		smu_cmn_read_arg(smu, read_arg);
>  Out:
> -	if (unlikely(smu->smu_debug_mask &
> SMU_DEBUG_HALT_ON_ERROR) && res) {
> +	if (unlikely(adev->smu_debug_mask &
> SMU_DEBUG_HALT_ON_ERROR) && res) {
>  		amdgpu_device_halt(smu->adev);
>  		WARN_ON(1);
>  	}
> --
> 2.29.0
