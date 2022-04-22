Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89664C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 10:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 080A510E6F4;
	Fri, 22 Apr 2022 10:22:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E54010E6F4
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 10:22:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVJnrvgeWRz+SylubgXk5SrS8ZPZlG1qsgJ34hzX0uNca3LgTMD7jtkpZnxPTJhwJMCCfOvqbozNGciatZ4rJqISUmeWrt7V3jqOHA7s+Uu3wDtZrTpm/iRFWXznLh5Vpdy6ar0PvtVRcD7FYb2BlT0nZjB8rtqF4ddazHAK5cUE+shUMdqrnEXu6PXjmoHmElOAxcLyrVQSG0AbWvilGjFaYyzjlKmlM4+izecxjN6bjlz7ARt0lKYJh6SsBYs/g3uCXehtzBqWUuYxVBFdmi7zVy84RfLjlF2JI+v+JAJSq0n+82/6UwRJWmeFE3DxYJhNgZEgluQs7uym3oCU9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0PBSyY48oVVfygK3gtz+uLcoUY8b0W3ZPOZ7d7EsTI=;
 b=ScIqOp+Pionxc51Esj+e/OS8zRtKdTWz6L9DY0NKHUymPLdP+ACBgNiWfafD1TPQaPh5/mbMC0z2gq5RmAVH5jG/bGmK8trUZOdG+1AkooR43EKdzXj3jVKhfS5GcADx/ViJZ+8EPjCjeKGmzL/9uN8rMC0dNRcy0OrEh0FAp0KX74E+nM8JezhOZrPDdpaWXaWdWiZrqKzxwd+yMRLzImiYraYs7R+hYapD3wqfXe5Z/1ykWBQjaUOeClQfwrdkYoBa228RWOTMRfom1aHisjTbC+H6qFZ+gkukT7ExCWUbuxbiBlOxAy3nWLQnKf6ZXX+JImPdcEtkt0DTb9Nlqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0PBSyY48oVVfygK3gtz+uLcoUY8b0W3ZPOZ7d7EsTI=;
 b=iUhz7yiw+bOE+F46BBMysdsATLAt7lsnMdaxYs9YNX2MROG6UxV4/N//GiesUYp8cjj3JU+DoT7jVeh7eteoYiMn2zbvOZn5yDxZa4JrxciMH4AjVJRPuyOEJrdrPEmJCXpSIvuOfpPYa5/Tf5SPTAHo8C6XuxqXt4xHi43suuw=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 22 Apr
 2022 10:22:26 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::8558:f9a2:7eec:cfa3]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::8558:f9a2:7eec:cfa3%6]) with mapi id 15.20.5186.014; Fri, 22 Apr 2022
 10:22:25 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: control baco sequence by driver on several
 SIENNA_CICHLID SKUs
Thread-Topic: [PATCH] drm/amdgpu: control baco sequence by driver on several
 SIENNA_CICHLID SKUs
Thread-Index: AQHYVi4GRcxsF8qOKkK4+c0MiY51kaz7uSPg
Date: Fri, 22 Apr 2022 10:22:25 +0000
Message-ID: <DM6PR12MB2619C1D0827BA71B92250473E4F79@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220422094729.2264-1-guchun.chen@amd.com>
In-Reply-To: <20220422094729.2264-1-guchun.chen@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-22T10:22:23Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=86286fbd-be74-43b8-8dc8-21c9111d5180;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25a63cea-80fd-4d35-1d94-08da2449ff09
x-ms-traffictypediagnostic: LV2PR12MB5967:EE_
x-microsoft-antispam-prvs: <LV2PR12MB596770490521222BF9D8CD6CE4F79@LV2PR12MB5967.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ildJ5+UZ1Vc7x2pIUZ9c85+8GfcP7UAvhVclt0nDQqtDpu4jg5+fmOD3YMN8zAqUO1sv30D/tbZGYqx3lQhWkLAPV0BdXjoSaifxol11wvOF5ve8q/mcMRlXysiAb7wNFhqTUgSihiIzjbPZPADDwfPSszIyZ7DllaJ6bpq9jxRyxTchx5MavRmUF9ogR29MJNNprfa96lDD7yIp95VvC36GBXVocHJ6LUCHKd3G0Kvje5pDWHu+5p/IRBJBLSwAeLz527xd8+UN+7+4flRTNmUvNokGuqAE3Xt22HbsQLOg1fA5VZwEViqcs42/4+/YRq0tk+90kiUL8EDuGBC/JHP5JXaE8uwANySAG/m6uO231R9n3JfgtN2u1+/QAVgpUXkETxf/LqFw8XkPAvs13oUk4+8TRMWBsp6Bo4JDzJCOREVxXPVJGTh7BuEtBY2Ratoyjo07koD+JragPKzgDX6HNplt3gIvHE7/t8/z2+uO6ULRFHr8sQIHEeswG7dBtmZft5CcE0uv9j2wGKJvFtytBARC8oFS2xqSS4YZ4PpkQd5OK1BSQX0GD3xkII3XBlzV5fQKk//Y9PMwGnOI3Nv7WEjTRkbw+ZJ3+WkiP/1jgymfU2KwHEVw4RGNwD4jEy4+WLchVd8FDb2c1vQ1UnU6Eaa18fyGk4nBo4/JBzfbiJIDgeZGtFRoEz2DiSoVLBBgcPcGYHcmNlvMp7WCCzx4rW9G+Hq9rWANe9mHgg4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(6636002)(33656002)(53546011)(83380400001)(26005)(6506007)(316002)(2906002)(8936002)(9686003)(5660300002)(55016003)(66476007)(66574015)(86362001)(7696005)(38100700002)(71200400001)(52536014)(8676002)(76116006)(921005)(66446008)(508600001)(38070700005)(122000001)(64756008)(110136005)(66946007)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KzVrfvCK3vyQnEwl/YiPP1EAfJo7OOF4vN3ckq0JSFatlT5lZYMpucy5jOYr?=
 =?us-ascii?Q?Jw7bRNjSlpKLGQzXYqwN/i5LdZl6fJt6jYVa8iAFJSuaManKWe/pspaPDpB+?=
 =?us-ascii?Q?AmuhXNvdk8mKKC6ssEb8Eu8fJNWxoi7N+vSEg5jp7pUgFGQ85Pqv5UuZQ36L?=
 =?us-ascii?Q?VuKZO0pKaWvYmnyUZfNIG8+YU4CzdjE9RSMZX7JzY2HTJzn9CwWcUqCOoeDF?=
 =?us-ascii?Q?cMop6KUIUG96CetVVKIHX6U3dmKDBJ7KPJDYtLGuRWwMGX/F4aK+uAIuooQI?=
 =?us-ascii?Q?WgXnKJ/4jxv2JgHw00ccbkT0osJsOYKiePGikBGHTdbm57LEyvO83o4yjMo4?=
 =?us-ascii?Q?tl1Y32es5RFRjg1bAUqSm/w3I2ZHiZ8uY9XzxqI7P1GmbK2cmRuFliSRok2z?=
 =?us-ascii?Q?jni4/J8w0Pqqb42b5pRyzaX1/ECNRNtILfqhMUHIso4v+jNL85Yr+7ZiE20X?=
 =?us-ascii?Q?WdQCqXEeZJjc4Zs/jHlESp/F8L6Osesz9n3D2YShMrrhITcb/271Xkcizb/c?=
 =?us-ascii?Q?Dlr5JV/2hIoxmGkKgJSBQzSY8UL/rUd5SF+nvPogHFUAeSzyzfOJ2OdPlD33?=
 =?us-ascii?Q?SH0Y+d6/wfCCQJMa3N2nLprdLe2qIuLF6hzRIZD4vYzAxDPRd/eJ+2Okp6Ca?=
 =?us-ascii?Q?kAwS4Ifmd9Kxx4fp0MJf4Ms8hK+QrpAhuedpmXJwEG9r8sCG7+vCG9HVfYCY?=
 =?us-ascii?Q?dE8Qh/cn4dsVGq4DP4rFFt4ZhRDv4kLSMsSOvUcfACXYJ34mszLusn1bZOHP?=
 =?us-ascii?Q?3pBoguNBkrAsZqJSe6nsKoJSSJNCKm24SIxYUdvtogK/wXyAeEgo5LTFD+Yy?=
 =?us-ascii?Q?oxUM85PvcAAWlyLptfUxu77wIps0F8bO4YPRw+djY33zxtASlsfcc2IYOJM5?=
 =?us-ascii?Q?4fkpguoJkckh5/6MHdzgrrJT+Jl8uwHI8Qp3/GtseF3gZH7zL9jXlYastpMm?=
 =?us-ascii?Q?6Az00315aclgxS2Xwfyzfclj+o36UMITQej3CXIblFuEHx5GLQB/5J4+YahV?=
 =?us-ascii?Q?bNUw/CRBM7EEFDi/ZMF+zNQOT0XAFjg7HexAT2MB7e5+GRnarCNM9RtgrBhK?=
 =?us-ascii?Q?rPodHQaMsbVUupLk1YLBJchxYIJ83Bg9Obdd+J6YQuJ/h8EDkvdhlhOEZkfG?=
 =?us-ascii?Q?iWQfi5mR5Mf1WOCQa8q/9EhQXB/kDnRAJsFyXUEPuCtwgHBLW0wGKxPBV5Nv?=
 =?us-ascii?Q?4NuXXlDUolb2J+TDAIWqZt9r7zs9rtuO2CjnnVHyaDyZsvTTD9CA2pjjjyiJ?=
 =?us-ascii?Q?8ZGHv6RO+Q6w4tuALcWS38amDOKzwOZEs75sjb9xOd7uNBk430w+MbESnEO+?=
 =?us-ascii?Q?TSmSnU6pJEOqUMK80PiIW2nemz70oSaqZZzkP911lZvOnxptYxMgBmARu9zA?=
 =?us-ascii?Q?8kdWxM+ObSBAq7tDKLEgwW0uCaxUvIYPEXkSD/yLI9wlOgxWwNgmeVer23Ia?=
 =?us-ascii?Q?cM+fut0fHm3c1h2ImnQlMJLB0oe62f42dAaKVMGqGihD/EdEYjqdtugYhsCQ?=
 =?us-ascii?Q?pWD6FPfyMYM+ITfGk+moOUgantjR/++9c2ULKAp2fDjjx/cUcTdlpYVLqwCT?=
 =?us-ascii?Q?Vd9967S/imCa/JnfpZ1viMcvUZaKluiEo5lUwZdygU3jkC9XE88b5lG2CoVk?=
 =?us-ascii?Q?OSbDoHqAnqWbUrL4TfSinGgxN2BLp0gXj1CQBP5OB5FdU9hZOShvN7KXAzHE?=
 =?us-ascii?Q?4XPZyjt2vhnfX4J4WBNzb8xZ43Juox7fCh0G3gVKOGm5rWWE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a63cea-80fd-4d35-1d94-08da2449ff09
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 10:22:25.5877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D2r1YSPnTWcaaGA65vzeS5l4xdZbZa62no6UtX13Z2aj1IJmttYU5mFMs2JIbGxp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967
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

[AMD Official Use Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Friday, April 22, 2022 5:47 PM
> To: amd-gfx@lists.freedesktop.org; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
> <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH] drm/amdgpu: control baco sequence by driver on several
> SIENNA_CICHLID SKUs
>=20
> Add a quirk to switch baco trigger sequence from armd3 sequence
> to control by driver itself on several SKUs, otherwise, SMU will
> fail to be resumed from runtime suspend. Will drop this after a
> clean solution between kernel driver and SMU FW is available.
>=20
> amdgpu 0000:63:00.0: amdgpu: GECC is enabled
> amdgpu 0000:63:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is
> not available
> amdgpu 0000:63:00.0: amdgpu: SMU is resuming...
> amdgpu 0000:63:00.0: amdgpu: SMU: I'm not done with your command:
> SMN_C2PMSG_66:0x0000000E SMN_C2PMSG_82:0x00000080
> amdgpu 0000:63:00.0: amdgpu: Failed to SetDriverDramAddr!
> amdgpu 0000:63:00.0: amdgpu: Failed to setup smc hw!
> [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP
> block <smu> failed -62
> amdgpu 0000:63:00.0: amdgpu: amdgpu_device_ip_resume failed (-62)
>=20
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 19
> +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index b7320ecf4934..494a42c253d8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -2246,11 +2246,25 @@ static int sienna_cichlid_run_btc(struct
> smu_context *smu)
>  	return res;
>  }
>=20
> +static bool sienna_cichlid_baco_trigger_quirk(struct amdgpu_device *adev=
)
> +{
> +	/*
> +	 * Add this quirk on several SKUs to control baco enter/exit by
> +	 * driver instead of trigger baco via BACO_SEQ_BACO in armd3
> sequence.
> +	 */
> +	if (((adev->pdev->device =3D=3D 0x73A1) && (adev->pdev->revision =3D=3D
> 0x00)) ||
> +	    ((adev->pdev->device =3D=3D 0x73BF) && (adev->pdev->revision =3D=3D
> 0xCF)))
> +		return true;
> +	else
> +		return false;
> +}
> +
>  static int sienna_cichlid_baco_enter(struct smu_context *smu)
>  {
>  	struct amdgpu_device *adev =3D smu->adev;
>=20
> -	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
> +	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev) &&
> +	    !sienna_cichlid_baco_trigger_quirk(adev))
>  		return smu_v11_0_baco_set_armd3_sequence(smu,
> BACO_SEQ_BACO);
>  	else
>  		return smu_v11_0_baco_enter(smu);
> @@ -2260,7 +2274,8 @@ static int sienna_cichlid_baco_exit(struct
> smu_context *smu)
>  {
>  	struct amdgpu_device *adev =3D smu->adev;
>=20
> -	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
> +	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev) &&
> +	    !sienna_cichlid_baco_trigger_quirk(adev)) {
>  		/* Wait for PMFW handling for the Dstate change */
>  		msleep(10);
>  		return smu_v11_0_baco_set_armd3_sequence(smu,
> BACO_SEQ_ULPS);
> --
> 2.17.1
