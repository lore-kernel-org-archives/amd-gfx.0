Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC87C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Mar 2022 07:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CC1F10EA8B;
	Fri,  4 Mar 2022 07:25:17 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2064.outbound.protection.outlook.com [40.107.96.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A965710EA8B
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Mar 2022 07:25:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNyILmXwOYZv1x+VErtMUy23wn4GI7Xoa8aw+LdLMymIKU6NXwwYIZEMjvvWaSGEeFGpuVU+spn2b9JXZX2gm9C4Jo9Z+BeVbyx1t3fhlnec1RtcZiLqLe/iNxL59wqUF4ECiSjbOat0XJMJf1ZJUfqNDGn19joQClnx3clD70uUly6mNaBfHY+zmJw7ht940RFHyhNZDLfwHXoC9tx7PNObb6GYSB2oBBv4brXLsYg/lwJ5CrnSGwGBZms+KCI1udVIJNSpw432f7naaCtqkmd8x4aZhwJPRXE0q+ba392EP4X1rtbfe0L8Rk6USvtXERzA2gz6Zg6SUGpHdSlwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhP2q0/m/yjd65Z1+WPhnHVKnAYoNWHGI3DLy5dvd98=;
 b=gjLPegwSqx/QFNG90fUJjAX8gZBCGWLVYIX+/niu9q6K3VFmHC7XgGQjCyZ5CdNG4i1Dw8dyBrgZzj2kb6It5nctvr7suehPNAJg/OiLkQnOIf9QMIk+04PY8jjoScqlTxnIh95J1V3+Tc+GqwmEHROLk/465QgM1s6qUzxCkh6cfwoFdCrBECG4iT/CVcMEGaJVmOip87yOmzRpKhdHr+3rA5ZF4fnzzSOV2zbhsJ7f1YDoMb+O/tDum/JGLjWFlAQJVwP4hCcvRn54JefIMY8J+77zSoTCkzyRHGucbW4KhF2N3v64JF62H3AZN5hiAQ1m9JBKW4heRv2DTVROXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhP2q0/m/yjd65Z1+WPhnHVKnAYoNWHGI3DLy5dvd98=;
 b=dqYTUtqrbrSs0y6grH9kq200/20FklgoGd6kOSxxHMW9vZriMChXzkP0Nh60/cdo9CR70Ws18GsYXevmX53M3silmJ+JbV4tqQ5oMsoZqPTpZ1nfagemitWpZKtuS06I8ZgxwxtvFDt+I5VIW0+3a2I6OcEC2JcsziwguvfY6Vc=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by CH2PR12MB3911.namprd12.prod.outlook.com (2603:10b6:610:2f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 07:25:12 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 07:25:12 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Joo, Maria" <Maria.Joo@amd.com>
Subject: RE: [PATCH Review 2/2] drm/amdgpu: message smu to update bad channel
 info
Thread-Topic: [PATCH Review 2/2] drm/amdgpu: message smu to update bad channel
 info
Thread-Index: AQHYL5QyApeRU8fzyUiTEBks8E/USqyu0a3w
Date: Fri, 4 Mar 2022 07:25:12 +0000
Message-ID: <DM5PR12MB17701C46D8C671153650EE0DB0059@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220304065037.1050-1-Stanley.Yang@amd.com>
 <20220304065037.1050-2-Stanley.Yang@amd.com>
In-Reply-To: <20220304065037.1050-2-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-04T07:23:23Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b99439a1-f43b-40fb-8104-6723e04f2942;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-04T07:25:09Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: b00ad7c1-f2a6-4c12-84d0-4206ea77b452
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9fa048e-e54e-4292-bef7-08d9fdb01ef0
x-ms-traffictypediagnostic: CH2PR12MB3911:EE_
x-microsoft-antispam-prvs: <CH2PR12MB3911450F9EF00B80FDD1DF74B0059@CH2PR12MB3911.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZTY8ZNxwIN6f3FmZM2zlPBOmXlLvOmlXCGzIr71Fb7ctEwPCECi2setdhwr4LPNtW8ogNYhS/I8wcp9Zb3QFtdqOpreHxX02S4iJXlavVPfBa5d2GF8pl55ubaX3ip15K8QXAwrPkjzU2+SmWK3M6blNUugduE42AM65NSzVgfJlwMmLCiiAcK57FQz6lZIW2sEQy2mz7Lq2h7hK4Cld4CNURJphpZ3B/MdoQk+ECOPk8J2lUpQvqxpbeUa6Bzdg4pUCjIaLVB/6NJcZiyNse28NYDRMXEvUeGdUZilogC+TKhXQS2EpptXGR1JOWosN7EWGWQ9XwxO6SbgcwGyksQzlcSfuzFvp6suNWH2FBIEcEb3TFiOOpmBKFXaWbX1liw8mqwCz1dmvj53YNW6ilkXrjJlwE+OVrtTs25Yao9RB3dA8ljSNkbBWdQw6VX1DyBcq0WyjwAAtZXTIRB42atu1PI8xARK5233TAieQzrOmBhjHao36kdYHJPDRyLnzmim59Zcb/wz4V7GN332ebmjXzb60QqvMhNbiAM+rpXgDCP7292/4nqIfPEOexx2lP40ODS4m++D31lPRi5642zkutokCLecxMLO+SnfMZmggDwSrOOzWPEbD1QeZ1zjTrc4HYZtSqFiyaf6zzavk6dKk7xrarHnA6L9hHrlkiWTzHUdYbxP5rKvKEjESejn4xx2Ta2CNM9MkgMZ6Pn3ieA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(52536014)(4326008)(110136005)(6636002)(26005)(508600001)(5660300002)(38070700005)(2906002)(8936002)(86362001)(71200400001)(66476007)(66946007)(66556008)(76116006)(8676002)(64756008)(66446008)(316002)(6506007)(7696005)(9686003)(53546011)(15650500001)(122000001)(38100700002)(33656002)(186003)(55016003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Pz3QJBpD1xotfdKSUVy20xEUXKjtlO4iZX4kq5YAuUA7lwIDPyIk/FO0EZZ5?=
 =?us-ascii?Q?8CFub01biTcp13OvcjgatnSeSE0L7OPXcUzSq04Iibdd5gTFOgZYZieGXU+D?=
 =?us-ascii?Q?igYLVKW7xMY4z5uUTADIlSdMVWFhta1t9Q50RCnDSbiSLVFjKrjGrsjtR796?=
 =?us-ascii?Q?o5J7uJNu4nvLN8InLeZqq8n8wdk8Z/V22M0MYuFivy9vmrBWhDZOKLJNb+ON?=
 =?us-ascii?Q?k0psOMsUR1rDl/7L80pKsfMmPt7y7XOMcRfwM1D9IcVYR7P2Gr37D8MPchK6?=
 =?us-ascii?Q?Kfw/C+by4fWiFuldLfLx75it8DKyzOqxUxp5xZXAtX5Ic7ll/GQTE+wiEMc2?=
 =?us-ascii?Q?yrctxzTUszFpSxJYtO5PUrDNjq1DwEGNmfGDdDxmGbtyz3pZUGu2TnGpd1zu?=
 =?us-ascii?Q?QwaZ6rXMDcvaVc9YP2sSlReZvQws8R3t+zB/GPvbsSp9I3kx49Ggti66XXRG?=
 =?us-ascii?Q?ZMKQmCrSJ/NbC+8ztXlqTaMzquc/kSZ5NAKvnNqKsPdPLI4Acg+ZDkUkMv+i?=
 =?us-ascii?Q?38OK53WkB4Ei2qUxZDj0YhtXQDxWReZO47P2jQLj3NGDeJUY2HWC25wsypcD?=
 =?us-ascii?Q?KRvgBpcDpGF+BYYpIInJgdxzXgMQYssWi/C3aNF+5CfBXK/ajfbVbk5pIwpw?=
 =?us-ascii?Q?D+H/LXOJMuYmdXMfXBK1Qn0VNonCJ3dwg0g2cxISEVy2A1i0Uo8WLyHwn6wN?=
 =?us-ascii?Q?l45/fXkTjJtfaweSSkwQkPyNi5zgXVInfNtUTSxu38VI6UrkUZtpGF33baOj?=
 =?us-ascii?Q?wp6NPY4NrrOuMH4tR8QktncqDWvby8JMg7OIhDhm3+fHt4J2CFdpvCgLvtN9?=
 =?us-ascii?Q?955zovNXGIxnVF9hn06SZH8Zm1NhTZkAgrNDfHvc0SEv77hLCnj+rUjiXlsx?=
 =?us-ascii?Q?eN9EB47MMaMv+dP0o/fStkM8umQUCHx5grUu1jml8TR+6UeGLB7iq8FZbc1f?=
 =?us-ascii?Q?9CFuwy/ZvviR7WTmE9PEt2tGYrCHq1zHc1p91b9Sl7oLam315IWYEeTvvTrd?=
 =?us-ascii?Q?XH6qfdgsBZnpjGNe7M+JMDN4gg0vK9VWyKKWEutVYlDAznrz8TIHp9dU+nW0?=
 =?us-ascii?Q?oP3pVcXBY64aucmvaXC2Jy3PWyrC3n+i7bfc0yt7P+N5kG2sczH/1voCYLaa?=
 =?us-ascii?Q?sjktUc9YEOfzUQC3lcrFUMCflChRi2icNL8Cu2tx/y3B8TD/sA/8ie2ikyZu?=
 =?us-ascii?Q?ln2M9PTmEjI4YjtwDCfRV2ZsowMLg1IJWVngfvON2eefHzhFkb9eJiZPtfIm?=
 =?us-ascii?Q?BnjJOPUASeV8Wq3IN9K4Ejp92WJBv6rbVCNhAkc4/0lO+wFqpTqckSw4I9b6?=
 =?us-ascii?Q?j5a+S64D+2UqgJxQHPUVpPXtDdNdQatwIL5G9miflWFhIR4g0LFu3IGEt1AP?=
 =?us-ascii?Q?Jv/ofsDpOr3K/ElvqTd5ga+/yUOt3a44N/mBs8E2y+idW6or4XThv+al0Z0+?=
 =?us-ascii?Q?RyFUNZcE4h/X0uDKRYSSx+rE0G1ET1gDuzlvzt4MV+5d8Abxduwd5qp800Kg?=
 =?us-ascii?Q?QuitSHDen0U2ZeNo5XUQW90Z7FHONEGqRJNgVoJIYyfXeLi/myqtxxlcIjyd?=
 =?us-ascii?Q?78Ktl+s1EDzLDJ6Md+Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9fa048e-e54e-4292-bef7-08d9fdb01ef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 07:25:12.0426 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P+huMHvUIAMWo+SpPEB0jFXWE6Qr9D8H2uvnbN6cwFzT+0TtP6o1WwYAtgUoX3+/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3911
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

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Friday, March 4, 2022 2:51 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Joo, Maria
> <Maria.Joo@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 2/2] drm/amdgpu: message smu to update bad channel
> info
>=20
> It should notice SMU to update bad channel info when detected uncorrectab=
le
> error in UMC block
>=20
> Change-Id: I2dc8848affdb53e52891013953ae9383fff5f20f
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  7 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  3 +++
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 25 +++++++++++++++++--
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  4 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  5 ++++
>  5 files changed, 42 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index d3875618ebf5..f9104f99eb9c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2068,6 +2068,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device
> *adev)
>  	mutex_init(&con->recovery_lock);
>  	INIT_WORK(&con->recovery_work, amdgpu_ras_do_recovery);
>  	atomic_set(&con->in_recovery, 0);
> +	con->eeprom_control.bad_channel_bitmap =3D 0;
>=20
>  	max_eeprom_records_count =3D
> amdgpu_ras_eeprom_max_record_count();
>  	amdgpu_ras_validate_threshold(adev, max_eeprom_records_count);
> @@ -2092,6 +2093,11 @@ int amdgpu_ras_recovery_init(struct amdgpu_device
> *adev)
>  			goto free;
>=20
>  		amdgpu_dpm_send_hbm_bad_pages_num(adev, con-
> >eeprom_control.ras_num_recs);
> +
> +		if (con->update_channel_flag =3D=3D true) {
> +			amdgpu_dpm_send_hbm_bad_channel_flag(adev, con-
> >eeprom_control.bad_channel_bitmap);
> +			con->update_channel_flag =3D false;
> +		}
>  	}
>=20
>  #ifdef CONFIG_X86_MCE_AMD
> @@ -2285,6 +2291,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>  		goto release_con;
>  	}
>=20
> +	con->update_channel_flag =3D false;
>  	con->features =3D 0;
>  	INIT_LIST_HEAD(&con->head);
>  	/* Might need get this flag from vbios. */ diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 7cddaad90d6d..9314fde81e68 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -374,6 +374,9 @@ struct amdgpu_ras {
>=20
>  	/* record umc error info queried from smu */
>  	struct umc_ecc_info umc_ecc;
> +
> +	/* Indicates smu whether need update bad channel info */
> +	bool update_channel_flag;
>  };
>=20
>  struct ras_fs_data {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 2b844a5aafdb..ad5d8667756d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -265,6 +265,7 @@ int amdgpu_ras_eeprom_reset_table(struct
> amdgpu_ras_eeprom_control *control)  {
>  	struct amdgpu_device *adev =3D to_amdgpu_device(control);
>  	struct amdgpu_ras_eeprom_table_header *hdr =3D &control->tbl_hdr;
> +	struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>  	u8 csum;
>  	int res;
>=20
> @@ -285,6 +286,10 @@ int amdgpu_ras_eeprom_reset_table(struct
> amdgpu_ras_eeprom_control *control)
>=20
>  	amdgpu_dpm_send_hbm_bad_pages_num(adev, control-
> >ras_num_recs);
>=20
> +	control->bad_channel_bitmap =3D 0;
> +	amdgpu_dpm_send_hbm_bad_channel_flag(adev, control-
> >bad_channel_bitmap);
> +	con->update_channel_flag =3D false;
> +
>  	amdgpu_ras_debugfs_set_ret_size(control);
>=20
>  	mutex_unlock(&control->ras_tbl_mutex);
> @@ -418,6 +423,7 @@ amdgpu_ras_eeprom_append_table(struct
> amdgpu_ras_eeprom_control *control,
>  			       struct eeprom_table_record *record,
>  			       const u32 num)
>  {
> +	struct amdgpu_ras *con =3D
> +amdgpu_ras_get_context(to_amdgpu_device(control));
>  	u32 a, b, i;
>  	u8 *buf, *pp;
>  	int res;
> @@ -429,9 +435,16 @@ amdgpu_ras_eeprom_append_table(struct
> amdgpu_ras_eeprom_control *control,
>  	/* Encode all of them in one go.
>  	 */
>  	pp =3D buf;
> -	for (i =3D 0; i < num; i++, pp +=3D RAS_TABLE_RECORD_SIZE)
> +	for (i =3D 0; i < num; i++, pp +=3D RAS_TABLE_RECORD_SIZE) {
>  		__encode_table_record_to_buf(control, &record[i], pp);
>=20
> +		/* update bad channel bitmap */
> +		if (!(control->bad_channel_bitmap & (1 <<
> record[i].mem_channel))) {
> +			control->bad_channel_bitmap |=3D 1 <<
> record[i].mem_channel;
> +			con->update_channel_flag =3D true;
> +		}
> +	}
> +
>  	/* a, first record index to write into.
>  	 * b, last record index to write into.
>  	 * a =3D first index to read (fri) + number of records in the table, @@=
 -
> 684,6 +697,7 @@ int amdgpu_ras_eeprom_read(struct
> amdgpu_ras_eeprom_control *control,
>  			   const u32 num)
>  {
>  	struct amdgpu_device *adev =3D to_amdgpu_device(control);
> +	struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>  	int i, res;
>  	u8 *buf, *pp;
>  	u32 g0, g1;
> @@ -751,8 +765,15 @@ int amdgpu_ras_eeprom_read(struct
> amdgpu_ras_eeprom_control *control,
>  	/* Read up everything? Then transform.
>  	 */
>  	pp =3D buf;
> -	for (i =3D 0; i < num; i++, pp +=3D RAS_TABLE_RECORD_SIZE)
> +	for (i =3D 0; i < num; i++, pp +=3D RAS_TABLE_RECORD_SIZE) {
>  		__decode_table_record_from_buf(control, &record[i], pp);
> +
> +		/* update bad channel bitmap */
> +		if (!(control->bad_channel_bitmap & (1 <<
> record[i].mem_channel))) {
> +			control->bad_channel_bitmap |=3D 1 <<
> record[i].mem_channel;
> +			con->update_channel_flag =3D true;
> +		}
> +	}
>  Out:
>  	kfree(buf);
>  	mutex_unlock(&control->ras_tbl_mutex);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> index 6bb00578bfbb..54d9bfe0881d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> @@ -80,6 +80,10 @@ struct amdgpu_ras_eeprom_control {
>  	/* Protect table access via this mutex.
>  	 */
>  	struct mutex ras_tbl_mutex;
> +
> +	/* Record channel info which occurred bad pages
> +	 */
> +	u32 bad_channel_bitmap;
>  };
>=20
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index 85da6cbaf3b7..aad3c8b4c810 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -97,6 +97,11 @@ static int amdgpu_umc_do_page_retirement(struct
> amdgpu_device *adev,
>  			amdgpu_ras_save_bad_pages(adev);
>=20
>  			amdgpu_dpm_send_hbm_bad_pages_num(adev, con-
> >eeprom_control.ras_num_recs);
> +
> +			if (con->update_channel_flag =3D=3D true) {
> +
> 	amdgpu_dpm_send_hbm_bad_channel_flag(adev, con-
> >eeprom_control.bad_channel_bitmap);
> +				con->update_channel_flag =3D false;
> +			}
>  		}
>=20
>  		if (reset)
> --
> 2.17.1
