Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC34C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 09:10:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 670D81129F6;
	Wed, 12 Jan 2022 09:10:05 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 835DB1129F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 09:10:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laSaGG2ZIfKzfFH0Jv+Z7nAP3FUTtXz0RTLoMxfkB4drB5OcqJzoCMWyBb1K/Jya0Ek8nS5uO+Vv5A8SyNO1Vk8Cbk9/y9xSHZmYSaqxSStpmCmQPmRI+L3mNAp7ITr/zBKnKwoVy3x3tvH6lCJQYRc5Es9ys8OfeKdu0/50aKg4JHZHBNEZ61ulZws7s6LKUHAkiiSYWzwns5qcK7Ch+cU9wSB36LLdn2Ro7wnTE9K43ICU9icu2S1RZ7NuM8jUoK3CCY3/3R0SXyMEscpuKR0VUs68C4ReOFg6Rbo0WYxFPln8kw+2q7fEU+V2v1kklg0Cj6UOSWwqEh0Wppb5iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Nt/QwF03XfMlNYQmxH5oYIsrNiHlHiq5gsukpyoDiM=;
 b=JMX0sxV5p/lxymUIADBueV0YiNDhNRU+4NzuzNDpai588ttQyy4B0mSWDZARoYz9aKvhzhPBOgR8Hz3DdMmp0+HFPb3idg2svZQWDjU4+/UAiCdWkaNJZLgUbNpd/Wix9oSJacp60Qa+HFFeaClOPn9WNF5vr63922Bwi7fLDq0js7ZqYgtFr4mx9onP2FLUScSDSagQWyDU7Wjyr4ytdCDBqLouDyVf1Z6ggMeL0tjfedAyV2G9CmK/SZ/Fd6OiJcR/Pn9tS97sVM2YvP2oKquLl3UT655GmLgIEn1Wxq8TKOJbswsmn8TMaZRzb/oHCIf9tAnNDehOmtgk03xoOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Nt/QwF03XfMlNYQmxH5oYIsrNiHlHiq5gsukpyoDiM=;
 b=CtfN15SnMsELCDpLdAf8WRQl1obHBRuj/4j8iEwbTtvOoKQwdNxEirCrzVTSJpGB1seqyJYeuWMkKcoSUmy3CVtnvRY0nmEeDJrJBOLgUsM4sg7UHGrd83CkuFxuvXO8TyoSSPOvpzEfC26grCGabwpu01Wwq5nuumDupo2L3Ok=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by CY4PR12MB1384.namprd12.prod.outlook.com (2603:10b6:903:3d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 09:10:01 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::68f6:f42b:2c29:7f94]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::68f6:f42b:2c29:7f94%6]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 09:10:00 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: Add a filter condition to restrict the SW
 ras function to be registered only by asics whose hardware supports
 the ras function
Thread-Topic: [PATCH 1/2] drm/amdgpu: Add a filter condition to restrict the
 SW ras function to be registered only by asics whose hardware supports the
 ras function
Thread-Index: AQHYB4jPAidvhBcew0aj498n0z4xV6xfDXQAgAALrQA=
Date: Wed, 12 Jan 2022 09:10:00 +0000
Message-ID: <CH2PR12MB4215E77C0DDDE8ED63DBF8A9FC529@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20220112074802.2867813-1-YiPeng.Chai@amd.com>
 <DM5PR12MB17700A1500D5CF6D796F7BECB0529@DM5PR12MB1770.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB17700A1500D5CF6D796F7BECB0529@DM5PR12MB1770.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-12T08:27:37Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=17f849cc-f2e6-41df-b2a7-e496fcf15c77;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abcbefe8-6f3e-4d9f-bc84-08d9d5ab4fea
x-ms-traffictypediagnostic: CY4PR12MB1384:EE_
x-microsoft-antispam-prvs: <CY4PR12MB138499963548DEC560BEAC00FC529@CY4PR12MB1384.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sq/J896eNduntorOw6iKFntIJNB65cLq39ubDJJE2qhlm1uV9eXaz4E/a+cU6elJrgkRsAx9+tBfoBnxQCjk1sYWvgejUEw5ennN14ZOyW0jE4K9/18tR6Ax6BSexEMbiYu3AO/gvtanuY+yAN958xSk2hFWOIsyEpZDvJECZttGc9EjcKywqORF+jnXv4vkCj64G3MVX0N5bDHX7FQeVG5845vibvkvldWIYPdngLNmiWYDH9l1ooB0UYOTMXcK1eh10KgOE1GO5JLnZxWJ7vLl6KEewlIfWfmxWsG7056PGXgI3SkLOojVzV+j+aQACplEzwit/Ljiy1bZPiQQIyrxpaDX7uXIbM0K/OIyse8GZS81xYtZLfg6bQdepwWwR+eU+X/0QXd9Il9blEj8BQ7om8xGL+rEYQt/tMxnETYHZiy4YlNYJxgSILdDHd69Z1LVQ1nVju6OU9Z0IRMSNR2Y5YeaBUbfp0whh+iuMChrYIbUgBh/SdIuUNzS+sowl5q95DQcjOjSVoElVB2hwmBV1N3xVEK8zveoNkeQGxzGmbAVysEW1k6wxkUYkR91p/0C93mPYlOGJ/xKGXzyBeIT4jl6OaZDkCTNfdL4MKflJBBeHDGkHNqEC94D0PzNQlwGD0o+M4uSBikTszhd//dkoXCmJ5fTtIcl6SInez0E43Cl+XgQneCV2PuU+esfx2JCgOZM1lNP+IhkMGcQeQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(66446008)(508600001)(64756008)(7696005)(71200400001)(66476007)(110136005)(5660300002)(66946007)(76116006)(86362001)(2906002)(54906003)(52536014)(316002)(8936002)(8676002)(6506007)(26005)(186003)(53546011)(9686003)(122000001)(83380400001)(55016003)(4326008)(33656002)(38070700005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WxlqDgOkOeUDRDwCPpoBCEkMFrRzkjdfSnuuoRa3fvzRybdSEVQ/U+Sg2qu6?=
 =?us-ascii?Q?gOcI+mQP7wJfAN6E5ufrwC63NDI16q6VuQMb5WF9gPAnT10vaMiElUkH3GaY?=
 =?us-ascii?Q?UYz9TItuwrWv8BP1mW4Qjy+dVdMgFV60r9wSoH4HgUfmcO4MVzzUiibNdzFD?=
 =?us-ascii?Q?gmpsohleigEQB3v1KN65I38ktt33atUJnOuD2OR0QpcQM/qNSaW1cet90Zay?=
 =?us-ascii?Q?YdXIdjEtATkaF4PuZlLT0I2xaSbnByogA8ZODas2CoY+2NhaljodSjmgN4wo?=
 =?us-ascii?Q?l/j/AR58mnhTJU3hwhsB0fx1t9KsN4Ox70D6smiyGh4dGZA9GiCNTBVakPtd?=
 =?us-ascii?Q?F7umSYN4Dgk/dCCpC8mo5NWvr5puSCHsHMkEhVEhsccgcozuU/uTQm/n19aU?=
 =?us-ascii?Q?wjc3FYA9ExWxdDHbh4TDs0lerZV1sQwNDy6udxBrNF8JJ60ptLMn7mCnTI38?=
 =?us-ascii?Q?BLwkgvnqYL2YEfkNFJdg7yEQQLHKy0T/ekLkrkFv8OLPBo7eeJSTxRBqpkEg?=
 =?us-ascii?Q?X6+occ4tYEvo0YoG9awykwH4ttfN8sqePgJB30Batd1/olwjgi+RHj7NoVc6?=
 =?us-ascii?Q?s6S2VroqVDVRrAxLpp6xtzyqPvkadIVPZmlb5vtoiVW0tAfE9W4XXRmOZqCb?=
 =?us-ascii?Q?U78eXvqnq+lvUaj/4mrf1e8hho8o7ub1VjAGG/4cT5x/I//rmspiVNoKKGsk?=
 =?us-ascii?Q?beL5qQXRyDyFvxO5sc3RF4PhJ4YdppXboo8t2ga5vCMCAu0XaSUwVdIKPdiq?=
 =?us-ascii?Q?wjVQalDcevKfoLpqIF2cfoxMGVtJ1HV3ihtUu3cldS3i5OddkA4Q7yQA0udU?=
 =?us-ascii?Q?bpJ2DzdAbkuF5JafMjOG4SR89Esgv65SZYTBezuqqCqj1fjAJbN7yM9wwNO7?=
 =?us-ascii?Q?eTbzF8E4EjbovR+4PazmhhZnZIsLV1vBlV5rFOU+nqsBuG175PmV3UhvfpB2?=
 =?us-ascii?Q?KbKVwAXBC9xMT3SgkTDhJFDv1l8jxKE0BDa76uFJix+oXxBCA1ykcBb9U1gu?=
 =?us-ascii?Q?h5LA2uEa7FLX8n2USqvz8gHAf7Hh7bRUfPiq/Ut2pOHbTJ67epeHk79gJCeL?=
 =?us-ascii?Q?07PybnB3uhdcwnuExrhnrGpov7KRjfsP12U8obnLDB0S54nTQ3Kedisjza/m?=
 =?us-ascii?Q?indfGxmPSH+FQ+7K0sfDLFysLycNOZGSdSvHz7+QH0r1ykiyG4Q6gVVwX8H6?=
 =?us-ascii?Q?ept9YKzqGrialYrb53i8RVYrUD+Ouk6K75Z/9oGTyNz3IudOuxH+m8mn3f0X?=
 =?us-ascii?Q?gfWSrAuTyynrwkCL0WmcQ15a81RUfsMTrJxcfJuY5Q177928KgaE8QmOowtr?=
 =?us-ascii?Q?U3KbeoKV3AT8oclPs965vp982dMaUXDz667Xl0lJeT4XDG6Mq5nTRPfSu7Jy?=
 =?us-ascii?Q?eQ7jxOBDyLkCL59tmKNuuUxUzkrOXVkAeQdLLeCy3TiQcn4/EbAmEt+hDkwZ?=
 =?us-ascii?Q?WdXyVC5eqKhv+AHbaCLjzTGX1UcWAWvVAL2DbNeDaVWPKe1WKdQpEz7YC1YS?=
 =?us-ascii?Q?M6q9+Q4fanktVVR9kJWooISyd49swyFACnUcSALgtImzkQ4IwOz9w1bZomZz?=
 =?us-ascii?Q?yxK5SaGawDHthHivp/tJr9Upexz+jRUuV/3k8qZZZhoXDoSudBg3uBqSKiN8?=
 =?us-ascii?Q?Btr8Ik9VhyPVQDlPRQcaaUI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abcbefe8-6f3e-4d9f-bc84-08d9d5ab4fea
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 09:10:00.3875 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tUWNhl3pHbpsyg+E0QrzLRsyMIrJqf9sM7BlcA0vxxL+SLjQjVAhIil9XrOCKoj8ondxhtvpmT+tyU+mrRonLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1384
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Wednesday, January 12, 2022 4:28 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Clements, John <John.Clements@a=
md.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Add a filter condition to restrict the=
 SW ras function to be registered only by asics whose hardware supports the=
 ras function

[AMD Official Use Only]



> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, January 12, 2022 3:48 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking=20
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,=20
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: Add a filter condition to restrict=20
> the SW ras function to be registered only by asics whose hardware=20
> supports the ras function

>[Tao] The subject is too long, I think "add ras supported check for regist=
er_ras_block" is enough.
[Thomas] Ok.

>=20
> Add a filter condition to restrict the SW ras function to be=20
> registered only by asics whose hardware supports the ras function.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index b1bedfd4febc..62be0b4909b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2754,7 +2754,7 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device
> *adev)  int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
>  		struct amdgpu_ras_block_object* ras_block_obj)  {
> -	if (!adev || !ras_block_obj)
> +	if (!adev || !amdgpu_ras_asic_supported(adev) || !ras_block_obj)
>  		return -EINVAL;

>[Tao] Can we return 0 if !amdgpu_ras_asic_supported(adev)? It's not an err=
or.
[Thomas] OK.

>=20
>  	INIT_LIST_HEAD(&ras_block_obj->node);
> --
> 2.25.1
