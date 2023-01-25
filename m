Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D41CC27C76
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jan 2023 19:31:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE81210E105;
	Wed, 25 Jan 2023 19:31:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CE9710E105
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 19:31:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKuZfyKiVsGQvecB6eJT2fFcC61t/N+tTjFFNFuCO0o0YtCA5lsMYFpDlmd/bPrT76meCT9+iPA8LVE+MqxHesCuDwC92xqE5nQynt6TT9zvQuim0ts37Fu3vNl78elzYP2ThQkerw0awA8h9SwjI8ttD38YNqoYTas8hf1kMrCdrJZw2bJpJr6xkBp6QEyw40Nmeyk20hjCwU1Dj+l0SnWUGwEIUiGbjng/FCIvkzeQ2xY0zYBVYiWOhSnEO5nF94E9Pk8L8Vf7xbONcJb9B/nhUgE5zoOjBu+0qH7BFsOiJPCI1JAUfKcMHgmHqCEH7LCrRSvslnWTgQgAVhLcKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5DoI84HMyaDw02ek+VgRQLGaW3fhpNFyEkvDDJhIgQ=;
 b=V/PWkxNPJ2gZunMuazk17Ya1GgB2VtDv5JScyxkpCpTQsRTyMEdUXTD5fvCSFwVYf52zI3w4v1YOSyBwZiEaTtYnU4jfz20oduoc8TjqZbOAG0EwgCzhB5Q5MLGyJj2BTlcxdm9LQhzP3LswSWmzQTwR0ICnsIbDDwFLb0pSqYTY+6CwBqlvXAebPfIzNrtEaatAs0UVQGTExL27ZvnrLH6i3mi9wQksMlZmthvFjLt+Mm/AZ1uEQHGlA9/dndpDBRqsCYUQdix/LQr58jpYc12iyH1jgyq4WKw83ZbTk0LJQztzYzKvxpzDVNVqNo9wRJsFmPeA5zvIZxPHiBZNLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5DoI84HMyaDw02ek+VgRQLGaW3fhpNFyEkvDDJhIgQ=;
 b=E6sQ347uM/TMlAXHoDm4He0pc/8a92UVBwwiWtmM2zBRT4sbWTStAPJnzJSIzAAb8qjHhfvspyAexOtTLXlARFgvTUAXq/1ebdb2SZecQgGJ6NvT1ndliiNg1g6GJCU6UIghN/f0Tmtjx00L5U+YLlGPvkLx4bmRB/4sONHut+I=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 19:31:31 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::b55:1f51:3e18:2a39]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::b55:1f51:3e18:2a39%8]) with mapi id 15.20.6002.028; Wed, 25 Jan 2023
 19:31:31 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Sider, Graham" <Graham.Sider@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: update wave data type to 3 for gfx11
Thread-Topic: [PATCH] drm/amdgpu: update wave data type to 3 for gfx11
Thread-Index: AQHZKqvbFUaK2RHgW0OMgzfPB3p6666vkcUg
Date: Wed, 25 Jan 2023 19:31:31 +0000
Message-ID: <BL3PR12MB6425E1355D3279CCCF32DAA9EECE9@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20230117194159.1654154-1-Graham.Sider@amd.com>
In-Reply-To: <20230117194159.1654154-1-Graham.Sider@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-25T19:31:29Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4af7aada-8843-4d7c-a33b-7a669273399b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|DS7PR12MB5984:EE_
x-ms-office365-filtering-correlation-id: 597d15d0-e2e9-4047-d127-08daff0ac2f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PzgJH4BTT5N63mM597hnFhD3kY8kq5mYDwtBNCl/KI0MrSUeKGd2ksmLMLnWowwYOzT+1GFgDoku2EZEHXFdZE3+G60+hUWIElCj2RGAHjQj6CFSEoLGU3XtN+Rx2JdGTKI0ZjABnkHg5mheYgT4AuobHJlijSrpVubXp9EwzVfErbz00HPbHdEuJNg0TT2usbZzpy30k0cJfgYDyTVlp2Hnkc1OgJyqG1INx7ekKbzSaCbl0nRkZ7bdd+Wap6blHYBzQK3zU/O063q0IK/rboYLyLXQMHtm+fuiRHeADVnHgGpDkOYv7qx7R9ScttCBpgwHR4n+OQ3ERL7gca9wxOSKkDHC47hQqWJO3uK2G9Kb21KiEEt/TTnC9hYoUw0Q6MzVayQp5u3blRwLfAct9caPFKOylmWFF/B1DvXfJvAg5uf6acQDfHHKchmP5e/RGNEnXbebxfIly/xMR4dODh+2xpwPMUxvSHtAqHCkz9Muv1FP2qTR0E2qGZ5x9liG1Os1UboHvpSe+G0Dlo/hTGSYPGvcih2k0r1Pg8+/mDVShJzsdJg+ewUAb/kimmqc4VgmsjaUgWWYg78QrBf7oHpnuw66BlVS8ZTTNQUMVjAI6dYQZMQleHTpVaHXgNHY6biF+Thj3udxZiJ531Oxg92VFCTaLU7nqiAoTH81cjWA/Xm+9ZB6XW0ORo+Mlziz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199018)(52536014)(4326008)(8936002)(86362001)(15650500001)(38070700005)(5660300002)(9686003)(6506007)(55016003)(26005)(110136005)(76116006)(71200400001)(186003)(53546011)(8676002)(41300700001)(66556008)(316002)(66946007)(64756008)(66446008)(38100700002)(122000001)(66476007)(2906002)(478600001)(7696005)(83380400001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ru+SbENQsgM4+1pcK2Jt+SdMAP9H/W4xCKXhyD7E/bTS2XfDUazMymf4c8zb?=
 =?us-ascii?Q?2rn21nJYtpNiCz0Kd2RAQu4u8WcgJINY/x4dbWG6vE5t4sxHz7WTySnkycTQ?=
 =?us-ascii?Q?xiZDeOh0L6kqsxCRoywTsHdfQknsHMrcWADhZeCWqgahpftoEEByFQUr6h1D?=
 =?us-ascii?Q?zsI46VDh3QvTm4muY5UaYFJfSmemEk3ReD8arJrqeCTN37hYQBQPm/H5/ydG?=
 =?us-ascii?Q?Qi4U+lhL3JitgXm6JMGAegwyQH9Ov69tyNLX4KY8iJZ1iwJXZflzWDHYt90A?=
 =?us-ascii?Q?w2UsTspoMiwrooXhPRJv56WeQjsc1olQUQDOyKwjKQ+Tj58qfPLM+fm/ZdjD?=
 =?us-ascii?Q?ZCmGSUumntKYlOs3Y2w62JtUwyr+oT1LMEk44WR9CGfGHq1PteDe6nY0zDVM?=
 =?us-ascii?Q?HjMwq2af+Hk8dQiia0oElU/HZAgFjiyZsMWDxOvGvB2AxLvPANu94d8fmNCi?=
 =?us-ascii?Q?4MX+orrf6HuTPRbMVYZWEDn+E1r7e78whYJ0YdZGs0wtt16nksKM9kw5f8wE?=
 =?us-ascii?Q?nbC2Fd7ZVx1zS9g3BFXUkVbEih/wrc1uy+Em2w2o3pQ6/XA/MXGQCd5ooRNi?=
 =?us-ascii?Q?pt75oYcoGUUDlwpgKMWIxMMDB5ysGjniaqhnGLecbIYPXIKQAR/nStiC22SA?=
 =?us-ascii?Q?iz+LWQLvkdAMSo7306+xGgyVVplAgNhTQAt3B4KjWRhUXU14QUiUPjkowjYv?=
 =?us-ascii?Q?C2hq/tk+2BuTdfA521eDKCPUSZbMLNUHZ3iRC00O0IPptgq7pKb8oeIigS17?=
 =?us-ascii?Q?vmGHW1WiTUD3//A/HDtF/aonvdZp6I1LhSqL/LE8Bp1Ee3/xQgC8xZgI5LAl?=
 =?us-ascii?Q?ybXNUcnktYRBNxNEQouhKEgQBLfY9X5djatDGXeXfsDnp4eYNbuSPjKeVKKV?=
 =?us-ascii?Q?4wAnX03kdGTkv3b1izCnF1F/jxLLW5WHY73whVd4Xh6vkdj+28P/ZTAUxaeJ?=
 =?us-ascii?Q?sKsqLzaim9/nnmGg0kFdA+GjPgiX9mNzxGcmkt1vgAVxfqEaJJOefW0FUVzj?=
 =?us-ascii?Q?24SFptF7wrw7xOuwGb7zI+cipKJ1UyoJx3TjFj+RJiR0cfxFtFBW+SXJythm?=
 =?us-ascii?Q?7tuycfU9F4W3YLpllcNfsbDKa3KARp83m7lySaiWl2ki0DgflNpGRAPI0trF?=
 =?us-ascii?Q?7JysrT1a+ezvBmVMcGNUujJMdbHtroNEypkBy2U240JABMDGQLFuZ8ED67o+?=
 =?us-ascii?Q?SWVjcyXmt9Gyg0ZK8mTOhEmrqkMxxlUb69UBqyT/4Qt+TcXvQMoEsr8CqTg+?=
 =?us-ascii?Q?GEPsgCjF86Ythu1gtvrG9o+C5VZ7cGJDxLTA5e5iybe/fBQ+FHlzFwYtKXPX?=
 =?us-ascii?Q?VVWEJj4IdxUB4KPUQZQu/LryZpDBeMszFeD5sQvfl4PetxSG060IZ0ziTGZ3?=
 =?us-ascii?Q?QonKcMx/cpmJa4fWJBU922nbAG5cb2hTEaputLTm2h2QRsFM1a805+UEP1Rh?=
 =?us-ascii?Q?Ax7O1+FsqQvZ/LHdR3F6acKJWlQi2ALZNBeI2sO6DzJ71x1Z6UfIGGbSfKsy?=
 =?us-ascii?Q?yx21vpNsp/cEkQWOKOlUVuxHG21A7I/EpM6vIghhYKBhV6NH0TgT4rZe/dff?=
 =?us-ascii?Q?qNPwxmZjrsKLGsxMTLs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 597d15d0-e2e9-4047-d127-08daff0ac2f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 19:31:31.1654 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iw0mZi88opLnmW8QJ6+EZiENhSBwOYFLdn7NbpRefRNqwAg7PMLJ6M6wvIPDTTziWmdjdmc3weMPtXT11Eny4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5984
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
Cc: "Sider, Graham" <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Graham Sider
> Sent: Tuesday, January 17, 2023 2:42 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Sider, Graham <Graham.Sider@amd.com>
> Subject: [PATCH] drm/amdgpu: update wave data type to 3 for gfx11
>=20
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>=20
>=20
> SQ_WAVE_INST_DW0 isn't present on gfx11 compared to gfx10, so update
> wave data type to signify a difference.
>=20
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index f98c67d07a9b..f821309f48c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -754,8 +754,8 @@ static void gfx_v11_0_read_wave_data(struct
> amdgpu_device *adev, uint32_t simd,
>          * zero here */
>         WARN_ON(simd !=3D 0);
>=20
> -       /* type 2 wave data */
> -       dst[(*no_fields)++] =3D 2;
> +       /* type 3 wave data */
> +       dst[(*no_fields)++] =3D 3;
>         dst[(*no_fields)++] =3D wave_read_ind(adev, wave,
> ixSQ_WAVE_STATUS);
>         dst[(*no_fields)++] =3D wave_read_ind(adev, wave, ixSQ_WAVE_PC_LO=
);
>         dst[(*no_fields)++] =3D wave_read_ind(adev, wave, ixSQ_WAVE_PC_HI=
);
> --
> 2.25.1
