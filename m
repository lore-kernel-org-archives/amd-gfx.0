Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108B3C07E9D
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 03:46:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8C4310E1F4;
	Mon, 26 Sep 2022 03:46:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CAA910E1F4
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 03:46:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jp8SPu3cIE0xHXT/0DTCRKpycShqfTI9cECTRkFQG3ShwvXjKRQu5gkBvG9PaiSIiRmSjWrWeLNLdX50pyQ6UlcDfKrZkVTR5n+dh6fjAxYVrTfc1hIRtS9qNN6N5/TCDkwCrO9k13GA0M7LAS+8pszhogrW+JnMjpR3lYEB/6wo0e7Uz9PSgYjc8zx2mwNs33AOrUejxt/PtIJK6OMIuysmspvvgNx+QicvaNX3sD18pzfEIBRPH8AfOe2iOlqdlTZKkBqvEJStwPSYbFPOvooW8Xwvnmkmh4aBJISOR+B/6oikz5dDc71AAEQrCrngp6K7wWo1acM2FeUGqPMjvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVb1giHYK6FaPv+/2TYhkp4Mx614SPPNNel33jeIWU4=;
 b=Uz9XHqvSGxZT4+OA3bQNJWtVCgz07u7+bnLU3LaqBX913RG6p+wFaObORtrIH0z7VCmotx5qeyIx7W85EcY7TxnYHMdTN95Q3KiM+S7Pwka2q4YyTXOCTp6BAQ3oLo8KzV6ZV4EBoMNypMBjGBw5y0znFPEQPCbOYUc2PfJzgM2b+w15XLFrUSDq6Q7HoWEXRN9vQCiBuoQJBexvdE1fakIUVyvFBlyyWZ4YrKGZeOYAxS2TafvidiRhw8SC5NAUdnGB+Yu5ZwnVT6EgX6xgqFnnMsOnsCDdcjbMpmxDZTn3iHmAc7G61mlYqxQz7KGq9xJpSwZWZG3W7QlRo9Z58Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVb1giHYK6FaPv+/2TYhkp4Mx614SPPNNel33jeIWU4=;
 b=venLk0WGkjgoKWzr8V9Fh0TXGfcV1rkhnxhjGJEvx3Ki1CyrTvfQWApOd3PV4cM68PdvT2QJeD/OYDhlkl+25J4sd/DTOaQsWZgnUyS1h2bRfl+S/cgGDDk2yrOtqvRBnygUoqBu3AFfLPiPhMBKxibn7JdMBRACOYNITpxI0rA=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by MN2PR12MB4142.namprd12.prod.outlook.com (2603:10b6:208:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 03:46:11 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::25f2:ed23:3985:d9f5]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::25f2:ed23:3985:d9f5%5]) with mapi id 15.20.5654.024; Mon, 26 Sep 2022
 03:46:11 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu: export umc error address translation
 interface
Thread-Topic: [PATCH 1/4] drm/amdgpu: export umc error address translation
 interface
Thread-Index: AQHYzy3a/S4f7pw7PU+Vm6yOLJhmJK3xDhSAgAAC1jA=
Date: Mon, 26 Sep 2022 03:46:11 +0000
Message-ID: <DM5PR12MB177061E51222235AB1825F0BB0529@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220923092112.14141-1-tao.zhou1@amd.com>
 <BL1PR12MB533452B53F1C09D704ECBA239A529@BL1PR12MB5334.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB533452B53F1C09D704ECBA239A529@BL1PR12MB5334.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-26T03:15:20Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=40607ca5-5af3-4dcd-9893-41cb1e9dba75;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-26T03:46:09Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 99b6b283-71dc-4c85-9ab8-85a2e519ed72
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1770:EE_|MN2PR12MB4142:EE_
x-ms-office365-filtering-correlation-id: 8a6584f9-bea7-4280-b111-08da9f71a744
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JMiDcpE6774mDpSjBQSr6ipeZdFMfZmzsQ4ZOu6LjRj3PLPhMfry5Yy2JDj4S6T5oOUH40idi+p2iChOd2HyGzfgabaCwnM3M77QHtlLuVgoGbC6eNgEs6teGkQxCWOQeS2ky7zidkysal5x3+DsHZ5Jxv117JtgQv7UKiKRaGZbaY9gR53v3kaDYrBgs1rRr8seOj2gZOfSdwYWEc1mME7Wh11sYKPKe39cMM8gjYqVUXM0gasvTqvNs3TNG1hiD4EqSM+txAxAdgtXsw797c8X0bIvqKzmvW7wYXS7K+UIxVbmfNdsmglhUVXILCHiuHSds7OL9RAcOTTaLYH0fBvdsBjI8PUnnFLutvyQQ5dMgI0aRAYlRj8Ku/C6bwU0nPWuTCeGo9n73lHJ3waojF1IqwQofAnJfWZTf8emMu2mZVt+Y37VmQjsZ6iIvG7KmN0LU5tP+BfvTPIkZCxSjI3dmZblrswsIc7vGUY39SVs/nwxj0KOVPi6Qdul+4z8/+69R0Hpu4eYQzU9qKvpTLk20clwWkcrmZHE6UuC2k/eQRvd5RVFa3HgmLtcTgF5w0ERivhfrwuOP1ZofU/iO/i3SkVItrpAO5GqhZe1eEY1jQvHUcxvA5wtcWQdYnxeMADpA9wgDgJV5uH5Adhnm63htlSiWonnjoovaV6yufW+6F28nfZiljngtHK8mWYD87RjIGmoWfndGInlmg0ZrA8oncROJG/5z1nXX7ubHerHu991mYVI7QiHCugc2L4YeVrWXzt6ZB4tDnbRurKzUg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199015)(2906002)(186003)(83380400001)(38070700005)(122000001)(38100700002)(55016003)(86362001)(76116006)(66556008)(66476007)(66446008)(64756008)(66946007)(8676002)(316002)(478600001)(6636002)(110136005)(33656002)(8936002)(52536014)(53546011)(6506007)(7696005)(26005)(9686003)(5660300002)(71200400001)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O4S/BIOF6WFEkS0hzrFRHJiB34LFnDO5ioJyVv5ycRlxqwbFPa5iRtzV/6eR?=
 =?us-ascii?Q?uEXhHc+qcJqqkRnotlTk7eHzImyoMQnMXoubX1drkFI9/i3LtTDghb3IdQje?=
 =?us-ascii?Q?3JDqNRmK6tyKcxWPRyLYq5iRh4jC4P8QNfa8RpxExi3vXp54c6h6GnWyjF/D?=
 =?us-ascii?Q?5Y0g4kGF7xviQSSov3DFIoU7WYbEtS4sLebgXgR8KZocAv0A4nMBCkErqsq+?=
 =?us-ascii?Q?8w37o9L/eRM+UQsZApOzWIcsosRTDyPAEm6W2KVVRAaWd5ek70ti1snaG3TM?=
 =?us-ascii?Q?L5J3pYqt6Udm6FbQw4K1LVAA0ulQz+o9fRkvymcOkMbg4bWcTzs/Pmfljiv3?=
 =?us-ascii?Q?Sw41uaKhewRQHHTWD46sCGR9XM1+sj1eKJ9hkqvv1dSs0p3C9tpLTB4gKk9G?=
 =?us-ascii?Q?h62tOYb1ib1SAdJD9kxk5x7pENF4vM9G98LoSrkVyjfE6VUdZdsQPM/mMUe8?=
 =?us-ascii?Q?pGUWLc2kKLYF2bTzmeFye+2BNm9rHPcPov1pUGF7QAFc+fh+QEQTu7gh4s/b?=
 =?us-ascii?Q?ytNU1PcEbIRIx3gfbCoESGZwkJOs/Gx21HUMhuJiyww1IM6yBa/RTCKLPhhd?=
 =?us-ascii?Q?WAqXw7KZo8KJNufXfJcvj2bO+8UkcQUdSkyd2QB1o8G6BlsPfD0Kp3ET9bEZ?=
 =?us-ascii?Q?zrDLfTDZYUi72mKiHgDalb7H1kKGclH+5aTVPA7ABNssgBlN/QdRmTg4Pdhu?=
 =?us-ascii?Q?Q0HGMt5cTfguT7AaSMhMU+iie98RNmIU4B+u4Q3ylCiUsJME3yz/mjjpQZgr?=
 =?us-ascii?Q?dapyumbcLFAjLQlSde6500r4wYi77nURU+AFplMJHU3VWEzHT7UIhcCLk6P0?=
 =?us-ascii?Q?4YBO0PXApDaQg6DueDDUu+/a5Z6DUZ/IFJt/2QaNebrV4t56Xys+VgPZFGjZ?=
 =?us-ascii?Q?vFaNVxyxmKAztEfHEXT2xL25g4C6ZU3EF6gV471mM/JJ/wRsXSeDLJgoFxb9?=
 =?us-ascii?Q?VCSk+EM3Kh+FgkU6np/mYifoWlNbUcIQqO4BUEJ+dG9fFqWjZ3TCHQqtCCgK?=
 =?us-ascii?Q?xHtYnylzeB+E7NFAkU7u7jCwa7bteh/whZcMZaQwVkpsJPum681FHerNouWt?=
 =?us-ascii?Q?W+3H2YqjJKO1FOBAFC/xpzHjIrg+tfECqJmtlYshrvj2kGA+aXWEsUs3MyV8?=
 =?us-ascii?Q?2kifaLkHGqJj8mb/mWLqov1iyeSWxhmznbBWajVVfew/SMP/I6wApxx+KKy4?=
 =?us-ascii?Q?Jw9FJp8V4aCyb8bXi08gt6g+ZxWOLU7fmJG9H5b2c9jVjNSysw2QujCwJugw?=
 =?us-ascii?Q?G/BOrzkf1s/qSwlvYcpghty+fevzMUDj1ap5xJUna2enk5ScGEBIRtIbLbLE?=
 =?us-ascii?Q?6GJlteKYyLaJSVw0dJwi/3xYgWKSydJOh5WCyFXFEc7sKw97DcQ3bN1dz91c?=
 =?us-ascii?Q?ouverSezOWUHQjO99T+Iy9OQPE5vjORIOz6PjwVUtuisBVr1wkoJWI9/r/ux?=
 =?us-ascii?Q?caQ3ZOe5LY+ryIsGWZ2ycK36cnQXh4yGpdrNRqHJGNlQ/wUfhC3zcX7TZiY4?=
 =?us-ascii?Q?rPj2PyFGPAk3Em3mh3LU8DmhJFCfThzuZDk5TXUtJewpnO2zLK+ScxUrWOI1?=
 =?us-ascii?Q?BJnfWRquaJCrVKAMOWg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6584f9-bea7-4280-b111-08da9f71a744
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 03:46:11.2607 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VXr8GkpTSyC/ZuycaVh7e3yXUHbo/MMjoG9PFm/s+W1F6t1/6rO3tLSvyARgDnTN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4142
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
> From: Yang, Stanley <Stanley.Yang@amd.com>
> Sent: Monday, September 26, 2022 11:15 AM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; Zhang,
> Hawking <Hawking.Zhang@amd.com>
> Subject: RE: [PATCH 1/4] drm/amdgpu: export umc error address translation
> interface
>=20
> [AMD Official Use Only - General]
>=20
> Hi Tao,
>=20
> > -----Original Message-----
> > From: Zhou1, Tao <Tao.Zhou1@amd.com>
> > Sent: Friday, September 23, 2022 5:21 PM
> > To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> > <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
> > Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> > Subject: [PATCH 1/4] drm/amdgpu: export umc error address translation
> > interface
> >
> > Make it globally so we can convert specific mca address.
> >
> > Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  6 ++++++
> >  drivers/gpu/drm/amd/amdgpu/umc_v6_7.c   | 11 +++++------
> >  2 files changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> > index 3629d8f292ef..31fbefaaf676 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> > @@ -22,6 +22,8 @@
> >  #define __AMDGPU_UMC_H__
> >  #include "amdgpu_ras.h"
> >
> > +#define UMC_INVALID_ADDR 0x1ULL
> > +
> >  /*
> >   * (addr / 256) * 4096, the higher 26 bits in ErrorAddr
> >   * is the index of 4KB block
> > @@ -51,6 +53,10 @@ struct amdgpu_umc_ras {
> >  	struct amdgpu_ras_block_object ras_block;
> >  	void (*err_cnt_init)(struct amdgpu_device *adev);
> >  	bool (*query_ras_poison_mode)(struct amdgpu_device *adev);
> > +	void (*query_error_address_per_channel)(struct amdgpu_device
> > *adev,
> > +						 struct ras_err_data
> > *err_data,
> > +						 uint32_t umc_reg_offset,
> > uint32_t ch_inst,
> > +						 uint32_t umc_inst, uint64_t
> > mca_addr);
> >  	void (*ecc_info_query_ras_error_count)(struct amdgpu_device *adev,
> >  				      void *ras_error_status);
> >  	void (*ecc_info_query_ras_error_address)(struct amdgpu_device *adev,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> > b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> > index bf7524f16b66..0f1b215653f3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> > @@ -452,9 +452,8 @@ static void umc_v6_7_query_ras_error_count(struct
> > amdgpu_device *adev,
> >
> >  static void umc_v6_7_query_error_address(struct amdgpu_device *adev,
> >  					 struct ras_err_data *err_data,
> > -					 uint32_t umc_reg_offset,
> > -					 uint32_t ch_inst,
> > -					 uint32_t umc_inst)
> > +					 uint32_t umc_reg_offset, uint32_t
> > ch_inst,
> > +					 uint32_t umc_inst, uint64_t
> > mca_addr)
> >  {
> >  	uint32_t mc_umc_status_addr;
> >  	uint32_t channel_index;
> > @@ -540,9 +539,8 @@ static void
> > umc_v6_7_query_ras_error_address(struct amdgpu_device *adev,
> >  							 ch_inst);
> >  		umc_v6_7_query_error_address(adev,
> >  					     err_data,
> > -					     umc_reg_offset,
> > -					     ch_inst,
> > -					     umc_inst);
> > +					     umc_reg_offset, ch_inst,
> > +					     umc_inst, UMC_INVALID_ADDR);
> >  	}
> >  }
> >
> > @@ -583,4 +581,5 @@ struct amdgpu_umc_ras umc_v6_7_ras =3D {
> >  	.query_ras_poison_mode =3D umc_v6_7_query_ras_poison_mode,
> >  	.ecc_info_query_ras_error_count =3D
> > umc_v6_7_ecc_info_query_ras_error_count,
> >  	.ecc_info_query_ras_error_address =3D
> > umc_v6_7_ecc_info_query_ras_error_address,
> > +	.query_error_address_per_channel =3D
> > umc_v6_7_query_error_address,
>=20
> Stanley: According to patch#3, it's better to rename
> query_error_address_per_channel to
> covert/query_error_address_at_specific_channel due to the channel_instanc=
e
> and umc_instance get form the mce structure, using per_channel may cause
> misunderstanding.

[Tao]: thanks for your suggestion, I'll update the name.=20

>=20
> >  };
> > --
> > 2.35.1
