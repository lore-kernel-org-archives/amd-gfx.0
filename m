Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC76C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 14:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D78896112D
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 14:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D78896112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73FE06EA73;
	Wed, 13 Oct 2021 14:51:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCE566EA7B
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 14:51:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqx8QIRkBa3Qzb2jQ10KCzB2TXohKO0cDDN/oWOrpaHPNzfXATSyKHopKgGbCU2MIw6AMKgaJ1YsKMA9IS2A/8Fm9EiZoWtTbxYS7HHO3Oy9VjdWzQuuHYDoSBkdMwQdHYUSPtEbF7riDzEIiSEYIc8YqHXLHcEYIes5Tp/qk5z25wIGK20ZVJKePLYvu8JRR3oMkThqmeSJdrSK9VftAS3yk6vMBVzYBThSo9zsH/ixdGDKMPMfkWfVZDRbzaXyDVpuLZuBN2y+EonOfqfyh32h5AGFipilU3InxJZiCgJVlj7UKNZeWJLvU+jkPiyrQgDmpp6h0/Db3sx7JiR8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFVvVj34jLU+S2PW1XoAEN9oEwJFlYyi9j+KVWyG2Po=;
 b=ngE445IghQXPI+K0XcLk3wy6CGAwBzl9B/VhX5NYBRSkRCawwTA9m5IhX58EOaydwbLBa90HGbSMV6Riq4Z5+cMTLpazJWhwOHLIcsN4tlPXIr3/3gaxDKKKznzXWzE3/wB9RTnmiV35oFGxeqcJUggIlV9l4N/SJ4/oZSbQuqK3bKqqxU/nlpPC641gyH63oPLZVUgq+qAT1gozO6tSeuF5M0tJ2ch8YBiWY24SBLci3IEfI/QX0R66pFPUc43NoW3pkoteJwpd6RmuLPbdPf1pWFVEowadx6Q67eLy9rsR0GbHN9LQw6C8cFb71YnFHNi7A7M9cFgchl/3Egxv8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFVvVj34jLU+S2PW1XoAEN9oEwJFlYyi9j+KVWyG2Po=;
 b=pLQ7+DuVFL+YlHRPWlDYk/R/JXeNto+Gyi2EmOy2LDdsy4295VjRe0geZi/h5u/Pn0qxwFNMDwlIYBup46WuRTN7RZb/skHnHCiWBuVutviFscp2JXmD6NrWGQc60yOLnR8sEYlSBwyG8al0x+Y6PQzsRHAFxl84MGjwW/jqQPY=
Received: from DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26)
 by DM6PR12MB3225.namprd12.prod.outlook.com (2603:10b6:5:188::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 13 Oct
 2021 14:50:58 +0000
Received: from DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::545:e133:60d8:d646]) by DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::545:e133:60d8:d646%7]) with mapi id 15.20.4608.016; Wed, 13 Oct 2021
 14:50:58 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Tuikov, Luben"
 <Luben.Tuikov@amd.com>
Subject: RE: [PATCH 1/5] drm/amd/pm: Slight function rename
Thread-Topic: [PATCH 1/5] drm/amd/pm: Slight function rename
Thread-Index: AQHXv9/81v2abUSeukWlqlzDb31Y6qvRA30g
Date: Wed, 13 Oct 2021 14:50:57 +0000
Message-ID: <DM6PR12MB3324B58464F55888B4D1FF5285B79@DM6PR12MB3324.namprd12.prod.outlook.com>
References: <20211013031042.53540-1-luben.tuikov@amd.com>
 <20211013031042.53540-2-luben.tuikov@amd.com>
In-Reply-To: <20211013031042.53540-2-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-13T14:50:56Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=abf010d3-33a5-496c-a56e-17f18e0d2d09;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cea90dc-00f0-4639-5288-08d98e58de09
x-ms-traffictypediagnostic: DM6PR12MB3225:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB32255ED94ACB64336E65592485B79@DM6PR12MB3225.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wJ7dfZoOMquT0fn/IEV+6RYjhq7eI6+5Ozz1HgTPSM9MWcSVHBK62X71M+kP05CzY6Uf0nkmFxO9LncmIXO6z37QZXfGv/5okdKoEyzqQ9rwiVbe5dvX/ffwfBY9tzfz+OBQJseZNNn+fa7RXnEe95+vvLqjUITNwPgR70UPMIR/4nB9sYk7i3LXZcMPzvybxLSBR33e+fbY2SeR35AonDof7xm8OyA5LH1RUcUssgZAxy3Pf8OQzyEXtkpVbdtQXJTna1EMkKi7EDa97Kpk4a/553nJXso9W5l551jigua7Bznuyj8Q9ecgqTfppo/BL5NO+tdboYumvIGDQuNrvblHnR2Z3k6b12nPy/1MgR5bvveetDbmnmlos9kf0Nwa0yHpxBs3tPGBzKnFm5jziI9NgZAyeMG/xo0+oqm1LyAG6KtYBehsKpZZMQiz5GF0YX22mdtBTPUWqUjgJIBt7lq7vFqsOKWCgZprHQkYzAvzRSDieORicSRKVcr2zYQ7NEHhTSp2gj3oAved5Z7iWWGLAkyakjzTFshZ/sVEJX63bDRoYk2HNVOezU5a7JAqlnWKqgZWwL9MVIfiHgA5XUHA4xLCD0nC9dccizl2IIA4PQwboj+hDHXYxfA5JBPE2TtLwDch0gbCHYirdoN5VkZzozZuiH5mbU263JSYZFMGUf9SuQ0qa7sphIgB1pzEa8nA/b0JIJCfHTJY8rrZkw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(122000001)(83380400001)(8936002)(33656002)(66476007)(6506007)(54906003)(52536014)(66446008)(66556008)(71200400001)(508600001)(64756008)(66946007)(110136005)(5660300002)(38100700002)(38070700005)(9686003)(316002)(8676002)(55016002)(7696005)(86362001)(53546011)(2906002)(4326008)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S0+M3KPsTa3KT1Kgh46hgLDNkv1kivnuEowtN/zy22rQMlByQMLJ2RWrz1p/?=
 =?us-ascii?Q?Sm9CZaIQFEjc1b9DdItvYaBpAue68pMfwCRkq4mvwf02tfTFEQMnzyGNGigb?=
 =?us-ascii?Q?wOFLyLLdE4s+4GEvBfZUtu34wLF4mScoNjhXNp7yy8TMaT9iXkVPhMd8T41m?=
 =?us-ascii?Q?3kk/d+PF/9cGhM4l3CBIpu8BRHOz5vNb9gO+oJDY1SR1/TZEptcY7M3SY8kG?=
 =?us-ascii?Q?h90MwNSuF22KlBl0J1bsBxNQKW9MygGL/geJbiIHKVodjr3tFijElVtvUvJF?=
 =?us-ascii?Q?rjUh3TvyqfoniQ3xskUXGAjok/VPN+ByqMU5fg76jgyTcPyisO7OjxXn5lyj?=
 =?us-ascii?Q?ymeZtGYC9vq5dij239A2vOifEd5UVkrZKIYTBWQnHT6Sp3DCml0zjkcKMnR0?=
 =?us-ascii?Q?6h0U47pxepR3bZ4JkXJ0uE+/B47uHRpaX7VqH97oDJOe5vzlmQ/j690ECqyR?=
 =?us-ascii?Q?pGqQ7hSV9L6LYsDl8chMR5I/3HD3y+Pj2K3hNsVoEUSxgz1DO0ue3XeeToIJ?=
 =?us-ascii?Q?l3SdS8Pq5WaI9F66vrRGb7VFeMkbvd+WS2yBC45CpYh7h0fBIB91hg/5LNF2?=
 =?us-ascii?Q?fng6VCC/7xPgDU21bCo8+q+QAWdrmPfuV8/pt//lr44myz0bRk3RVnKlXUtY?=
 =?us-ascii?Q?8xBnuVsCEMhpKnR+4NLgQ9N/3rENwDMmovtInRIGGZXxVRoo/9lQkDXcQ6/j?=
 =?us-ascii?Q?qqmWMryou6wBQd70ykQAoNAKjrMnWndvCOnkxuakkI/3TRpN1FHMHuEFwNEe?=
 =?us-ascii?Q?8+jUrJ24nr6Hbf2Lm1cv8lMWzOw3ji0+S4yc5TFSRqRMCPLh5AkVDlBpy5VW?=
 =?us-ascii?Q?Si05oymasnArdNpYL2qNfXTB1HzHh6jDlU7rRDqQbBsoXPXej1hbGAjHlM6H?=
 =?us-ascii?Q?MqLUtO6GLQoUiIwr/hII0alx9X2+alH8GSru1GNHw8/REixbX9ALXyj0Vu1R?=
 =?us-ascii?Q?XJDuQ3fPFqvy5/2K3SSvF1Ydc6Ch77QgBMmS9ANVZv89qlAuGdUhJoPBa8Ui?=
 =?us-ascii?Q?Li9wa0OMvn5AXQhyoYGf8N35pbEHBS1TTSagaiyomtZiRO1hRQAWMnb8dEhT?=
 =?us-ascii?Q?6HBi/78noY4fM2HPKbl60x8MGiuMyh9gLw54h06ddla+OE1Ce2uwGJvd+sxv?=
 =?us-ascii?Q?/FDfFpU4QIBw24aNrO+Z5iZDI++X3+wRzXSpcVTj9Y7eetZXrYyO/zQE4T38?=
 =?us-ascii?Q?0hCN98wQ3ng+mrzQmkF+mbXOcq5E99wwvPr5TE0QoudOs5/Xnelo5oJjZk8O?=
 =?us-ascii?Q?Kwfh9qGOKdn6gRxJsAp3ZiJuG963vBP3CLIAe15U2QDS9onGsNFyOH5RrAbP?=
 =?us-ascii?Q?nrYFyHphQKgG1nMB9iaHox3EOipmP2ZxsCbGNBq5yxBH/uQmfBnWvPc3kFPF?=
 =?us-ascii?Q?2GPYckcauEoBN674EmfkW1CBm12Y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cea90dc-00f0-4639-5288-08d98e58de09
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 14:50:58.0836 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Md27zANGvJDInW7NMdKSX0jnK2/AJbVoCvLkGVCa8SORDYBD0eQcKlau+HaEfZs+6AXAWThYqPEmmEvnr8svgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3225
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

Pedantic tiny thing:

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Luben =
Tuikov
> Sent: Tuesday, October 12, 2021 11:11 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Tuikov, Luben
> <Luben.Tuikov@amd.com>
> Subject: [PATCH 1/5] drm/amd/pm: Slight function rename
>=20
> Rename
> sienna_cichlid_is_support_fine_grained_dpm() to
> sienna_cichlid_support_fine_grained_dpm().
^You would want cichlid_supports_fine_grained_dpm . The function is correct=
 below, but anyone grepping git logs would miss it.

 Kent

>=20
> Rename
> navi10_is_support_fine_grained_dpm() to
> navi10_supports_fine_grained_dpm().
>=20
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 7 ++++---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 7 ++++---
>  2 files changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 71161f6b78fea9..0fe9790f67f5af 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -1231,7 +1231,8 @@ static int navi10_get_current_clk_freq_by_table(str=
uct
> smu_context *smu,
>  					   value);
>  }
>=20
> -static bool navi10_is_support_fine_grained_dpm(struct smu_context *smu, =
enum
> smu_clk_type clk_type)
> +static bool navi10_supports_fine_grained_dpm(struct smu_context *smu,
> +					     enum smu_clk_type clk_type)
>  {
>  	PPTable_t *pptable =3D smu->smu_table.driver_pptable;
>  	DpmDescriptor_t *dpm_desc =3D NULL;
> @@ -1299,7 +1300,7 @@ static int navi10_print_clk_levels(struct smu_conte=
xt *smu,
>  		if (ret)
>  			return size;
>=20
> -		if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
> +		if (!navi10_supports_fine_grained_dpm(smu, clk_type)) {
>  			for (i =3D 0; i < count; i++) {
>  				ret =3D smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i,
> &value);
>  				if (ret)
> @@ -1465,7 +1466,7 @@ static int navi10_force_clk_levels(struct smu_conte=
xt *smu,
>  	case SMU_UCLK:
>  	case SMU_FCLK:
>  		/* There is only 2 levels for fine grained DPM */
> -		if (navi10_is_support_fine_grained_dpm(smu, clk_type)) {
> +		if (navi10_supports_fine_grained_dpm(smu, clk_type)) {
>  			soft_max_level =3D (soft_max_level >=3D 1 ? 1 : 0);
>  			soft_min_level =3D (soft_min_level >=3D 1 ? 1 : 0);
>  		}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 15e66e1912de33..3f5721baa5ff50 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -1006,7 +1006,8 @@ static int sienna_cichlid_get_current_clk_freq_by_t=
able(struct
> smu_context *smu,
>=20
>  }
>=20
> -static bool sienna_cichlid_is_support_fine_grained_dpm(struct smu_contex=
t *smu, enum
> smu_clk_type clk_type)
> +static bool sienna_cichlid_supports_fine_grained_dpm(struct smu_context =
*smu,
> +						     enum smu_clk_type clk_type)
>  {
>  	DpmDescriptor_t *dpm_desc =3D NULL;
>  	DpmDescriptor_t *table_member;
> @@ -1084,7 +1085,7 @@ static int sienna_cichlid_print_clk_levels(struct s=
mu_context
> *smu,
>  		if (ret)
>  			goto print_clk_out;
>=20
> -		if (!sienna_cichlid_is_support_fine_grained_dpm(smu, clk_type)) {
> +		if (!sienna_cichlid_supports_fine_grained_dpm(smu, clk_type)) {
>  			for (i =3D 0; i < count; i++) {
>  				ret =3D smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i,
> &value);
>  				if (ret)
> @@ -1235,7 +1236,7 @@ static int sienna_cichlid_force_clk_levels(struct s=
mu_context
> *smu,
>  	case SMU_UCLK:
>  	case SMU_FCLK:
>  		/* There is only 2 levels for fine grained DPM */
> -		if (sienna_cichlid_is_support_fine_grained_dpm(smu, clk_type)) {
> +		if (sienna_cichlid_supports_fine_grained_dpm(smu, clk_type)) {
>  			soft_max_level =3D (soft_max_level >=3D 1 ? 1 : 0);
>  			soft_min_level =3D (soft_min_level >=3D 1 ? 1 : 0);
>  		}
> --
> 2.33.1.558.g2bd2f258f4
