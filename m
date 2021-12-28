Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D433C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Dec 2021 01:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF29A10E127;
	Tue, 28 Dec 2021 01:54:44 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4845810E127
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Dec 2021 01:54:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMvD4dne8ykDNVqgSwVsNT2l/B1m5uY38g1xSuQ5EGrWi+Ba84wsZnbBzlksH8vcQk3s1yt6RgkLgR/vmXRrFEoHphA81FeP3OPM48n9fSidwgCA8q21M9SAy7HbCMM4ZZqDJmNZh2/i25/1uRHYR/dQRV5WJ/PgpwcDPc3vc548xQkFF6bs0HwQ+ZBwUsFRKgINpRMYz7L4AbMs3rjMhPhYonYP3jjUlmnhk2CxlzJFruQ0KJS1sc1rxtxUydX2fLFJdl7IFKCHsBJm2fI6sgRUaiZfoAK67I8ac32nsqGRBCY3vqAqMnlxud8Awf4wNAol2+U3PdTnAxf/xNH7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dkbk+ldoVjERXoXwIcCOrUOp5T5QhK8VW5rrAygCM4=;
 b=Cg+rN/qpphepxDZi+jn+i88UzHGNwUC+nhaahKLP1WQ+ohHb2ALKeesbiFsCVbkzU15yQYMKZdBoOtoPw8gkrM6ozRtszb+7/HUj7iPU/wjdjvOs7j4VoH6N7MqvaQVrfa0cI4FyKhIB3w+3r0r+nR89/X+hNCK4xnoNslq9bF+ImOybl3ryKfv7p6HBU40duO2Ma/di/+CVqNGQ1AUKGWFJzqMgeOo7TZGFUIeQe3RBg+6WGmq7J3oFl2kiPmxoKdRw/lKcEQPT0UWmjTID+w/kCz6WwpTxI3PYAsl9j49rIlIegHFojGH95bpFLBiLinzZED8OnL8wi7iL0kIiUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dkbk+ldoVjERXoXwIcCOrUOp5T5QhK8VW5rrAygCM4=;
 b=aujs1dcML+3UugTvL8kDFMAybLZnVzu7KpwfE2ikH/P2RGx71jmkd7XPpPqTs6izKtiRjZCjqNfTdmL4nQCadQ3SM68SdhAK7fq6he4BCsWQoRYpQHKnIoBDVhcasKSW2tre8e04cEdR6OlA5EpMTade8fnJi9n4d7l6oTBmqdk=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2828.namprd12.prod.outlook.com (2603:10b6:5:77::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.19; Tue, 28 Dec 2021 01:54:42 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639%6]) with mapi id 15.20.4823.023; Tue, 28 Dec 2021
 01:54:42 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: no DC support for headless chips
Thread-Topic: [PATCH] drm/amdgpu: no DC support for headless chips
Thread-Index: AQHX+0TcbqPpiX/7ykys0sb3xY2BlaxHJMUQ
Date: Tue, 28 Dec 2021 01:54:41 +0000
Message-ID: <DM6PR12MB2619DF13DBBB81337AE40CA2E4439@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211227171141.1503210-1-alexander.deucher@amd.com>
In-Reply-To: <20211227171141.1503210-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-28T01:54:38Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=6d92d8a9-5568-4517-bf80-1afebdf93d27;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2dda16f9-196e-4e01-1554-08d9c9a503d0
x-ms-traffictypediagnostic: DM6PR12MB2828:EE_
x-microsoft-antispam-prvs: <DM6PR12MB2828E8357AA250FC6A4EA42EE4439@DM6PR12MB2828.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:576;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RFYJ9Bdyr6vrVLYz2avzflgsTsMOl8DB0c5q2QiXIn/JojgHrzSxrL2Nv4xOZk8TwGGOWFGmQV/rER/uXPiz1IpJ3GFLmfFq9ZvDLjPpj1Nt3LNDii6Z2hRsnEA3d52crtwk8XLmmgnUNOKEqetNUksxz/TeHcc8ziBXBrZYndagWvtNf/tZXx7YUSFnLTr9ZtxPpp5/4dPvMKg9byUZurznR52F7TD3XgyqkJICLRCxSmRN7Pf5I1lqH6JxZgOWG2ngdcbZcaJOAjgZvhoCaOAnQuYgLl/AWsedhQKcGDRnMHl7QtmZWA7KrmB3RbPZh0hzTQ44fLq7onYeA8qJEzgtdq+LK5ucfsyzKfocDv47R1gwNtSJ1u6bopr4klASGwLEjILZVfAeIUBjUqiGczMURKGDO63McVRFpHRW7WogmpGKzUG3dnG3TYA6na0+MB2v0WCAJ5fkjrZpWthEaYlQAmcHE9phFRYDwqIvrJ3kHjytx0s0Q/GI+eDM+CfzjkJKwVQjjEETlfU5d3ESmiNWzT5osUuCLPecd91lwEgyjiZH/glmzk/OtJbT1jY8GvJ9SqrbLY9SBf6Ge388ccDm6imPoVvnOoQu+IkFNMZJn5PZQzgH3nlLb7pOd9CIZKRWqO0/ahUkhX9j4OxQSFNjQflcBOjN8dckJxeIEMYr9OfYgTsECL/xNAOUVzl1ePKPgOZD5rOF+DBlP9C57w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(26005)(66476007)(7696005)(64756008)(66446008)(66556008)(316002)(8936002)(5660300002)(52536014)(53546011)(6506007)(4326008)(186003)(110136005)(9686003)(55016003)(76116006)(38070700005)(83380400001)(66946007)(71200400001)(54906003)(38100700002)(508600001)(2906002)(122000001)(8676002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?misiDO8jWzK1kkSYtQ7DYF8XOKKdFp6h3iqpNTp3Np6q4CQakhvA7kc/6o3W?=
 =?us-ascii?Q?uO4ZBS6l/PY0v60njxaAJW1AOH9YaXIypdCEpf2lzo/o5J/KXtR329jP66Hi?=
 =?us-ascii?Q?WZCHsVUI+Uj6cnToU8/w932I0vchw1ZKKhiNvgY63fV0PbBX2Ygpyg7ogmqw?=
 =?us-ascii?Q?RjB1c0M9IVJID6TKKxZFdCiQQ//iXbodTl15X4ny+ArJ3PxouVZaCC0PcV4K?=
 =?us-ascii?Q?uvM8gLaT6a+HdSGu1Uq4Suw1L+gtfVvPI/s+U7tVfVnyz5K6UJkYjnY3td90?=
 =?us-ascii?Q?Tebcpw+nV11B91I7T6Nf3uprqBMCI+0fKWjD33cjA9UdfMt7/sQLuw4MFVky?=
 =?us-ascii?Q?fefYHcnZq9NU8X8RW7rtAiAezmkv8GGTjqIUC9l8ViEUyDKjjFcyvCXpUmZ1?=
 =?us-ascii?Q?qXNi8rFH2kuizTJtz4knbUCX8gfGVPNR/vqc4eS7/WY5Csgmt1RHbEWDrMyM?=
 =?us-ascii?Q?xQLrwUE+U6EO4t0am9P0PfTKbmKTZqsziDEpvUMAjwxP7dJNivusFnvd8vyF?=
 =?us-ascii?Q?8fP9BoQcsDX7KEUWV7/G5Us7SfSNFFWOQ92I+yVT8mc9Hn/5MV7iI3RljhVi?=
 =?us-ascii?Q?HXu+F8gk1grlkSl7o8z/rOZgxJ+fjTTzd6HWQit1wR5NxcDlqIlQJsm8QhFB?=
 =?us-ascii?Q?9dZ52UqjVZZB3HSji5KVup8QG4yhHDzhzxmU+ExlJElr9Q9At44kHyJLjMuX?=
 =?us-ascii?Q?mo2bgVxQn4fkfcFCjxuBp9ao+kjfqbm38YdcDfkKhSspZdo+u8NFvJK+aex4?=
 =?us-ascii?Q?sdRg/QuCSCe4vdi1jv+6arL+5/I1zDXC+EctRwrTxrlQPFF9esC+SXoScWro?=
 =?us-ascii?Q?sUSTus2s6Nj7kmLTIP+X2GezmA07/I3azJU0ImEFZr6WiJtutjNlaW+v9LvK?=
 =?us-ascii?Q?lTBtwDrJJzfxk3ZDQbSRSkUBygG/QAD5kKnt9LHeIpMmREVyfc9DRi+hlRJN?=
 =?us-ascii?Q?CUFD0dTSeLzVTaYDRErghJd8KewrPg0g8LkXtLYVGDN3wvfBNiaZr2yux4Fy?=
 =?us-ascii?Q?lOjE02IRT8fsvAgUlwCDWBlj0Ty3VteHWfYDblz5KF9YhyI9cldzhebE5AnJ?=
 =?us-ascii?Q?QSUWi9ARxtfAKI86WpgPfoJrKmjgH2Dzz658x06oLmNGCrxtIXkIACk4ycz3?=
 =?us-ascii?Q?UZ6q+e1z34uMR+4ACNbRejYCDqqmr2YN/MYE3yzi3FuXrP0aDzlSGl1e6SV1?=
 =?us-ascii?Q?vbSk5yO0vVcfeJVeOHDbpeL0BiGZAl5ZGvZp6SW7nV7h1qDMrFkhCCvEU86p?=
 =?us-ascii?Q?WWzW9S9jXDw6xtvhNgRD6EM7cBau4Tm8iH7SDz+sSSjzR3Rpv1fqcpG25WEt?=
 =?us-ascii?Q?g0UalrVWfSUdS3d4be0WTkGD+Qkn1QCJ1hsBTMhYEOfIMBWlHENIJNTLVVmf?=
 =?us-ascii?Q?pw5oBgUN5CyhfOJbxuLym3XeW+O1NchcPGowk93givNvLj+T4HgySGSMkc8N?=
 =?us-ascii?Q?QdxbOc7/gh5SkY+GiKwvQJGQa0mK84ZLBh05whLULCpd7mVEtvmXuz8YJAVB?=
 =?us-ascii?Q?B4p8Xgfe3GmjfT4VvZXx0Wus1vMl/0fS73crDrTzTYttQtfyYr7iCpUVmUCi?=
 =?us-ascii?Q?8p6HMgcNWvDtRoqIKow=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dda16f9-196e-4e01-1554-08d9c9a503d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2021 01:54:41.9766 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HensG88MI/tBXhoSvf6caQHOwALA1jigvv5A8B8dOxrPWpz1UU+axTTVDlvlSBtH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2828
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Tareque Md . Hanif" <tarequemd.hanif@yahoo.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Tuesday, December 28, 2021 1:12 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Tareque Md .
> Hanif <tarequemd.hanif@yahoo.com>
> Subject: [PATCH] drm/amdgpu: no DC support for headless chips
>=20
> Chips with no display hardware should return false for
> DC support.
>=20
> v2: drop Arcturus and Aldebaran
>=20
> Fixes: f7f12b25823c0d ("drm/amdgpu: default to true in
> amdgpu_device_asic_has_dc_support")
> Reported-by: Tareque Md.Hanif <tarequemd.hanif@yahoo.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 9dc86c5a1cad..694c3726e0f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3166,6 +3166,12 @@ static void
> amdgpu_device_detect_sriov_bios(struct amdgpu_device *adev)
>  bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
>  {
>  	switch (asic_type) {
> +#ifdef CONFIG_DRM_AMDGPU_SI
> +	case CHIP_HAINAN:
> +#endif
> +	case CHIP_TOPAZ:
> +		/* chips with no display hardware */
> +		return false;
>  #if defined(CONFIG_DRM_AMD_DC)
>  	case CHIP_TAHITI:
>  	case CHIP_PITCAIRN:
> --
> 2.33.1
