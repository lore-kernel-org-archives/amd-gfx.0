Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12BAC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 07:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 373B610E9E3;
	Fri, 11 Feb 2022 07:40:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 124EE10E9E3
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 07:40:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6ejFwoJ7yfCuDU9iTaMtH3hFsBWupyNTZX9SJau3rnaGya4qLwEaF25w3AeZRvJfcqFyxijOp2dRdjPPYX1eoMlrypunrLedr5CT69ExEYuFTAmdf8crxHz0+ttzKUM7vfkXCDspSP0fh+jGJiedcMaowLu3CIl9jJuKOUjZxDLNMtCM7ZY8Y/UA3HEaGW+bnQKN9MIsMS8nDWHOUBe/reEZBvheQ2mRnrOb7kE+Fk21kCbscj+sB+tlJOksTEwJhBCfs6AsMcbFJES33IUfqY0J7sYWIQfrycDQhKwzcj5Fd9Z12S7BsuzgBgv7sgagHgXg1iiZMw69jLYtyRAlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIOLslL6ma7v7WFHJcvKMMMyxPl5MB6RAdZzV/g9/6s=;
 b=IC0GpBUOFXtqcKz1lDj+PT9L+Is0HbWtF0OTEJdZfu9XjHD7vRLf8ofRmbP/0QOT52QxyoNByAZ8Eq0wfLv8iXQqFUg5kn33SXquQALVaKlS5sjfyi1e0U17FN3jSenE5ZxNr6nSQ19LpEMY4o2aGpmmQRgGiLVZUi0cORrmEnL7bV3TXd071qBrfn+vKHYoMF36i0llM2ZgyAZzdsqIBgjlmQp6GDZTSop2z+bDq/CgQPtVFcTUGENIGzPN7BqVOTYRBjDUwNr30INm/9C990IlWrKazrL4OPReM0MCPRUkfT9ifvsPBxJSnan1pYqC3lF1pVBOBaPjadKpB/TbpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIOLslL6ma7v7WFHJcvKMMMyxPl5MB6RAdZzV/g9/6s=;
 b=F4TNbtfDCph0V1J1wvAkgLDFoWTGI51ldbzNfzgjL2bX3pjkjrjEpAJq2ZUi1ykfiYlgccwp0R7lVeLqxh41ahWy54NhWdXDq4Tilk5UbFMSFkfCzucBSibRy9/bbQUdRVcLiZHukhQLTkCskFRE88H1xn0VibfHMUTUyLjfxXI=
Received: from CY4PR12MB1767.namprd12.prod.outlook.com (2603:10b6:903:121::9)
 by CH0PR12MB5313.namprd12.prod.outlook.com (2603:10b6:610:d4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 07:40:17 +0000
Received: from CY4PR12MB1767.namprd12.prod.outlook.com
 ([fe80::4998:7ffe:1f45:598e]) by CY4PR12MB1767.namprd12.prod.outlook.com
 ([fe80::4998:7ffe:1f45:598e%7]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 07:40:17 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: Reset OOB table error count info
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: Reset OOB table error count info
Thread-Index: AQHYHxV/dpg3BtOZfkKS0FEq2g33XqyN9wOQ
Date: Fri, 11 Feb 2022 07:40:17 +0000
Message-ID: <CY4PR12MB17671421B26949F21AD02AEBB0309@CY4PR12MB1767.namprd12.prod.outlook.com>
References: <20220211070330.32500-1-Stanley.Yang@amd.com>
In-Reply-To: <20220211070330.32500-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-11T07:40:14Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=8b9fd527-2583-4494-a1c6-a5e73f57c8d4;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-11T07:40:14Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 4945e851-e356-4494-bbb9-ea4e61901127
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50f25f21-39eb-4373-cb84-08d9ed31bfef
x-ms-traffictypediagnostic: CH0PR12MB5313:EE_
x-microsoft-antispam-prvs: <CH0PR12MB531379D636A0DF22BE61F411B0309@CH0PR12MB5313.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:541;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OGDkXET8rpAvwuKRZu7ujWXJvx8KGprJzP7fR34GyxJudoXULcM8uVJ3ODcE/lJ1/Og9dI+fYVX8YzMSiXp0nQmDsjJBTTpnB6HTzumSdbyeJOixOodh2EVbFH6JsDbMhI1IeMv8KVOeSSUsBKhnKhEkGRMbTIpYo7VR8Pr8+REg3F3xgVpPoUeywKtK3CXSznQlWz3TAX5bIOXedze1FzQL5hk+FfBr4rDCB5P0294MgzsXv6pNPoeValbmbBQZWRUywS0OGxZoIpBTT18hOTWKSO6Ltdl4EHMjviFf3j5sGeZ2CKM2Mi116LmgZHPCieKUFBlwJf75/ybn+UYeIbSbQq5hI8upywCia+/oLoGZQofarE5EyuwhZ+DxNCWTnD+LjAssJAexV/fvB37IHH3dVpfsfbjVZBU1s982RO6GNFWt0UL93oCmGXe65ILvZIAU6N9GiOlO8xDdMoN2GNV3eYBLWvCZnLke9Cf16vxOM4OrWo1MEatMK+KHonFBWjBu19aE/PbcBBdfFPTfnZR80e8QZon/8pQFgnnRp0Sek5dVC1bxOEwQTcIA4IHkH5tARQ/+i1T0m6BaIXIY6rpiXr3cXHNMB/pOY14eOLi8KfCczBb0PZV4WKDAhZcamgNYMzhL24AQDs7OGqH15fh9RO6e1GBs1esTBz3AUxbyaZXsASf9E+k9FbTDu0n1bKG+WY3Tslh0sjFVpZrfJA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(71200400001)(508600001)(110136005)(33656002)(5660300002)(7696005)(186003)(316002)(83380400001)(86362001)(26005)(2906002)(53546011)(6636002)(6506007)(9686003)(52536014)(55016003)(122000001)(38070700005)(4326008)(8936002)(64756008)(66476007)(8676002)(66946007)(66446008)(66556008)(76116006)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v4wNqRkUDu/2y+AwhH3Aos5O1Ti9SFZQFe+3r34JDBS2H53d9omIsBw+VkCX?=
 =?us-ascii?Q?XE9XXv76ZIRwUqGeEOgsK+JySNblpbwienbpZWj8G1zTf4fNovg9jAYQrBTl?=
 =?us-ascii?Q?aFdQrgTBZhJsKSy+RDxrfgx3iOn2bfZDXyuJKbYyyGY/C3Wul9mAsEzB5Aq2?=
 =?us-ascii?Q?yvDzOHCr0a4s26Oy02dFeCqPjWE/JWr3oFYG1DhTHQf3/AIFmuDlOGYlywzo?=
 =?us-ascii?Q?zQYpnbSejeZGGfFrVbRri/ZLKqxBPW4o8N8G3VCt/8RNNdQrjS8vL9chbyZd?=
 =?us-ascii?Q?W6DdvfHWubZgIKIpXNJp4r3xfDYQuw7jfvBsdbpgU+f924z2jiCra9hPzMPW?=
 =?us-ascii?Q?b1t1wpHRaA0u1/BzTyl9+PkBBbHjwSPQA7YYTad4Bemi4iLdZa7NovMJXJsF?=
 =?us-ascii?Q?XoWrso2P+b6WeUIb8Dx5dR9BAAwsluLtGK2EorlPsXrxIBJH7tmxnH84nwgB?=
 =?us-ascii?Q?OQQ7GLJemCQRH2LkJTmi/UghCWzQtO9LbbK0N/dNmLzdtM19Nd+B/ZsarlKI?=
 =?us-ascii?Q?SJ6l6wf2/0ZQakjB+OmRh4Xt/cJuP7y6oKSzJBEv6vtejOSY8bbhHdLXtK6D?=
 =?us-ascii?Q?yI4hArHNAutmxGfqxNRaB6eM7tqMZCUq6gVYXUIikzyaP3e2+6a61JOJviFy?=
 =?us-ascii?Q?kSwXQUFVr8RxPWquIeSNGYFfqCUMPDBJj19vjKBwytvqDIh6RuykD4/6kpEN?=
 =?us-ascii?Q?2WD5hoX3JS6JVemLnKiRcOblXJIghfRANLYRRChu87KyNQyDf2apUlVV6km6?=
 =?us-ascii?Q?K3ecdM5EVgaLK/KurF8/y3qw9E7ShadMfryVD0rdE6PgOM/m0kQVohjmuoFB?=
 =?us-ascii?Q?wugI3AKQmY8YDOk+X1c9GAnYzkes0XuURti+lcZUMzav2/U/BBnssQV7IrmL?=
 =?us-ascii?Q?IJZd9StiMDm1PQ1AgAal4ihynpCcA3P6k/YwDZpJQFT0aYy8rS3WIEpJyuyA?=
 =?us-ascii?Q?o1gRs/qLup6j69mBk79t/BbZbTvPIvH46P1s6K+KNg5RxVEDzVfr+jL1bsMT?=
 =?us-ascii?Q?Y3nSd0uGQ2tffnq6bUQcZe0krTui/sepFFJAZ5cYLdYm64ivbu+MJ4LZRJH/?=
 =?us-ascii?Q?40xnZA15cZaCEZgQzdlDdtM38ir83e1ACohHTGhBsTyp86xsE4bkUAoVfRIu?=
 =?us-ascii?Q?3wDSxXEsDCXXdd85aCgJw8u5Zhnlkio6Ez/KWjH1KmFW7cRun1Na043FzPjY?=
 =?us-ascii?Q?W/Fq3vVP/+VP4IzVoR476JfP39nzDGukZ4fOXUEXZOZ9bsv5fyYxQKs1+wjL?=
 =?us-ascii?Q?nIxP5RiIG25pJo4JR8w2s7qfclohkRs6aEUO+2b+dj8lvMENXGP0kCrkxBSx?=
 =?us-ascii?Q?y9rdDDKsTQz3jlUAr3SDB2iyhudqRn+Z/OWdh058HY9JVlK5lZytFoXyts4r?=
 =?us-ascii?Q?SCnirUTIVH0foSC5WHJKfajw/IReVwrV0hVrTIPo+6YijYIesaycj/PyjYzn?=
 =?us-ascii?Q?ksjOYP0cfowDj4MLngbDzZaf/8pDXElGrOCP16wncN/XUPrgwEfFi5pKRUJg?=
 =?us-ascii?Q?e+Ema8ptFnYxNjF48Tvg8R6h18YaeJ0gen/rGT8S4lGQsNgZXUOhbghLx/Yg?=
 =?us-ascii?Q?SPKMGkzHw659gDxq3vo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f25f21-39eb-4373-cb84-08d9ed31bfef
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 07:40:17.7417 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: erMpdtFOo9g/8YGn25FAmkHkhxScxM0cS0T8TyzDj0y/kNfVapTpEJn+EJFU7U7w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5313
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Friday, February 11, 2022 3:04 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Clements, John <John.Clements@amd.com>;
> Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu: Reset OOB table error count info
>=20
> The OOB table error count info should be reset after reset eeprom table
>=20
> Change-Id: I2a39e0e44b7b1a5ab7d6b4d4b73ebe48264396b7
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index c09d047272b2..2b844a5aafdb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -263,6 +263,7 @@ static int amdgpu_ras_eeprom_correct_header_tag(
>   */
>  int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control
> *control)  {
> +	struct amdgpu_device *adev =3D to_amdgpu_device(control);
>  	struct amdgpu_ras_eeprom_table_header *hdr =3D &control->tbl_hdr;
>  	u8 csum;
>  	int res;
> @@ -282,6 +283,8 @@ int amdgpu_ras_eeprom_reset_table(struct
> amdgpu_ras_eeprom_control *control)
>  	control->ras_num_recs =3D 0;
>  	control->ras_fri =3D 0;
>=20
> +	amdgpu_dpm_send_hbm_bad_pages_num(adev, control-
> >ras_num_recs);
> +
>  	amdgpu_ras_debugfs_set_ret_size(control);
>=20
>  	mutex_unlock(&control->ras_tbl_mutex);
> --
> 2.17.1
