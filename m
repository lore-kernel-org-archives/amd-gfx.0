Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01860C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 08:28:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B19DE61058
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 08:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B19DE61058
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 361676E0E6;
	Thu, 12 Aug 2021 08:28:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 649B36E0E6
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 08:28:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8xvg3yOOlbDXM9oZA3Wz8fmf7OnVJ8xodfN25c0TeFM/ANzdo14ZArbaq1NGR6CVqLLwSe4vGlrGf4AFnkfF/p64pKL7zGhQXoFP1oCYsDxeZqQBIu5x1ScHURCXDR2LVjHuIkL4lOXMg8jJTz+vONwdNkhobs5dR85JIXautvr3OCqFfG1pviMgs+h1RvL55opOpAttI6z1Ilzv50gKDCY/9UB/H1XoZst5ZHcz6P2D3BeLf3uqoYc44cpGwbXc17vE+foiA4ggjR+bLz930kutPo6t9n0/u/fMosqOVK165zOVh/xnh1zMv/CIrXxitlWZU4GWM+O45eNF9zPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flvRDGW8IxBsdwj712j36VXZFw+pIbX94Q4ki2mshaM=;
 b=Z1mN9j/0ESVbqFF59NzbyShUdRNOB/QhwhSEoOglvnhlTs9m8nzvaP7Gd3mG9T/4lQuxW/nISNzc3a4d/O8lAkpYVJ1lzzN9FogE1yc2dt7CKC4F5ePTQTZC+V3P5np2snEDX5rvgsrX38BLVGBHBBZRg56Ie66CQruF0z/DWMI1iW+QuQ2XgRaysBho+iycbUFZUO4855mshDWheI7ckxIaqAFQpUokk73NggYj0GjRONp62cfPts8To7Rmj44p9CQr9nLztAU2+AY8Ujz9IXG0wEfIHEe1G4dGAriU19NFPI7SoqVA8cbK0DvlNlWBK5o0fR9uIjVpEPb+17Rt5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flvRDGW8IxBsdwj712j36VXZFw+pIbX94Q4ki2mshaM=;
 b=yaPAwROEfQUxc5ONvU9QEO2uQf7qxyUN0+LsSr3wb6wOAPDegUYtgCcAH2godYbcJ86qB+UOwN17aS4Fbw42Wp7QzoG6FTzDwbUUcEh6F9dHQYC6Qx0cmjPqLJH5y8ala/zGJLw2AIdb0bnwpOitTLyCAWxm1yhfcs/Kak35X6U=
Received: from DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) by
 DM6PR12MB5567.namprd12.prod.outlook.com (2603:10b6:5:1ba::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.16; Thu, 12 Aug 2021 08:28:28 +0000
Received: from DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::4534:3524:ac2:9e13]) by DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::4534:3524:ac2:9e13%5]) with mapi id 15.20.4415.017; Thu, 12 Aug 2021
 08:28:28 +0000
From: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
To: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhao, Jiange" <Jiange.Zhao@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add MB_REQ_MSG_READY_TO_RESET response when
 VF get FLR notification.
Thread-Topic: [PATCH] drm/amdgpu: Add MB_REQ_MSG_READY_TO_RESET response when
 VF get FLR notification.
Thread-Index: AQHXjQIbwLF7dyxMZ0eUKngmEuA0kqtvjf7g
Date: Thu, 12 Aug 2021 08:28:28 +0000
Message-ID: <DM8PR12MB5478D72F9A6AD023A7A9BBCDF8F99@DM8PR12MB5478.namprd12.prod.outlook.com>
References: <20210809093644.5952-1-PengJu.Zhou@amd.com>
In-Reply-To: <20210809093644.5952-1-PengJu.Zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-12T08:28:24Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=171d441f-3a03-4dce-9aae-a8c6d8df7f2b;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c93b60a8-252a-4372-a724-08d95d6b2918
x-ms-traffictypediagnostic: DM6PR12MB5567:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB5567F86F97FBF2C32EEA0593F8F99@DM6PR12MB5567.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gs0EUFIBqRGExr9o3MkCKV7cQBCPuhvhKhh2YcO2HWOYXjyd6pXJe3sgweLDd5IpNr/sjrffQkcdJ5l9f2QlmTAA0aCuOBb7AfEGZfigkEfzeXjaBKYp16abnqSl6nYJePiHyl6XZQSxgHFXcMzyLgSJInP3oKtnJo30cDrGB9WpOrQ3mNlZ1BeB65+3ccMBOcbjH8wcjU8TMemMqLrumqqAOHT0vNyOzDPrNehgZQSjNAxQpmUHk9U/1IqdF7F2VBzxKx7XGxGSu/1PjcWyNyWRqw2ubEuhhxLfy2qykajqE6XhDRBlT9g6h7Z1gHSkEqN4uwb7QZRbMzl2OGxAvT1szUZXnlMEU0DCYS6AEzL/Ndclvpb0IXByAapTY2LadlZJsBfM7YJXfbR0TocXX3jRCY0IwPMB7t1Etq1EDEqo3TxcZGGETczZYn4hkQda8wjLf7+PE1N+noaGSpJxkHJUUlh+jMRmr1tFX0NPY0PQioLhuLq+iY3cuFxojW8eSMGvfnXsGBDsvvS22XCCENxB6y2uOg7PAHnHnfFI6uDhzNeE4nNsgCgZ5kH7i4fYtTVqMY/nytc31cyYfhtbS3sxNUugr2H9Ld46OdfBG4SwUWorzy0R4n+92bEY2LZnMz7x5s5CNC5F+S4Vsx7C98NGjg7+XLfhNiXNAYXjLFikSv0r2hT1Of6cJKsQ1QAIgLlbfWqsQq2wB808w6GjvA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5478.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(66556008)(26005)(76116006)(66946007)(9686003)(66476007)(71200400001)(64756008)(8676002)(8936002)(66446008)(38100700002)(38070700005)(122000001)(55016002)(186003)(6506007)(53546011)(4326008)(110136005)(7696005)(478600001)(83380400001)(52536014)(2906002)(15650500001)(86362001)(316002)(33656002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y/QyDQXYNkwcdbe9JCyAG/pxGTHKWyME0PjwXQdb3rE0yqE5fiZgzw5sXJuD?=
 =?us-ascii?Q?16SJMivvFmB5jg4tjKDj12zi9GsJSAAlAWdgxR3GFpgdHZJCgHVNqz136+2u?=
 =?us-ascii?Q?/QThqOQHABchZyWPQrU6xvbBpldgNI2OzIguTG+I4Aci71XISmD0NnCJJ5o2?=
 =?us-ascii?Q?RFjHWooqTZvZ1eD5ll3HiqBYpA6MKvdPvzybL1x2/hyW1UTfsOzMv9TDgbyN?=
 =?us-ascii?Q?wBKag5S/yw3+ZOb3KMxui46Ss7gVpimdjeQvZlcSGPJ1broaLqKGUsgc08S+?=
 =?us-ascii?Q?+H2PZQXuBPgrlc7VZqL+IAfc/IcPtMmjN6YDkmfmnqZFIx+6xMP2YBdtN5Lu?=
 =?us-ascii?Q?eM3u6Uo4ggzwei2X1eRTPj5rnF4mw+x7orCANLjEogwj97BL5QBLCh+PwGdo?=
 =?us-ascii?Q?+rW5Z84H1/h8xcAyXbg3h8iYEpuGj0FnyUHlCuWF+XI7Uwlb4+euTvssPdxk?=
 =?us-ascii?Q?CR1erUJ/hk2q0uOcAVZqqovRwgExsNWvQ6sOHcgAd/icPh/PMWruXrvhuKU4?=
 =?us-ascii?Q?zLMVKF2sDN39D5q2pj3iT329tv1DuxDj7eEjp3g8jPtLXCKJjsFQgKyASAN8?=
 =?us-ascii?Q?f54YOCqHXpnVLEuy7cQlPN+9ohwC7qTJzs1nGSDoneY3/NJNwZpN9UDQYuKE?=
 =?us-ascii?Q?4k9XFQ423UiCbTttyd5kGLTSZx/ugvRSSG+P2/SqY7SyiWG7+3uOmgCM5dal?=
 =?us-ascii?Q?abehGflB9uFDjCJBfcxt/TD6b4vBzhjGCMUNkcwRcsMb4UEL+iv9qgSScrka?=
 =?us-ascii?Q?3bKCU3pc+mQ/+U32YwmNjVkF1/MR4+YRwhTZMx2fvJQEt47IBzJPAXI3RG3U?=
 =?us-ascii?Q?mRd4Uy5W72bgHoWnF1jLkIWFsifLPPg0zg0FM/uJ3Cc/yohYIPNY8hjMd/fS?=
 =?us-ascii?Q?MEl+L6EJl8DN84ZpQZiyJtTrIpV5dkAQmds/ca7rBxbu90oFHTJVibkD/6h+?=
 =?us-ascii?Q?i8BZV3V7oR2oz7kGz+ddlrMceQmKeQF8HWXOXwyGaIhw793JhDO2SkA50Zg6?=
 =?us-ascii?Q?aRhyp99OQg41VhjuLQ6OKkGfhEe+BObQ57g1stQYPXoer5a6LuJLVIs87WH7?=
 =?us-ascii?Q?NSjlxwsPkMuBRO8eNQZC5ttzdLtHnWDT2g4r+QBF0FxVFxdOerqkqQ/xV6Ai?=
 =?us-ascii?Q?OTgr7mqF0hnHvXmeFPm7GwRBzQm7liVUExhY08SRULz4A/ZvNRGvNdEWNb4N?=
 =?us-ascii?Q?Vtz/WuROQSsr6LAXr8k81VpTkBFO0UHKayh3rWSRal1rvJlVl/idG/c4K7Uc?=
 =?us-ascii?Q?sIsu1YKLK7RYOIF35d6n9cqkexCC1vcexTQM78FygwgJIO5/apUl8tqtyQSL?=
 =?us-ascii?Q?WdX1oahFZvSwaUjqCZKuQgEj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c93b60a8-252a-4372-a724-08d95d6b2918
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 08:28:28.1702 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i/D1dwxvfFcH6c/C+u4tJC305yiGCF2XoCViB7CKEmtzRp59250xDqiI4xrRP3xKnI4ywiPUHO4GW3fZp45N2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5567
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

ping

> -----Original Message-----
> From: Peng Ju Zhou <PengJu.Zhou@amd.com>
> Sent: Monday, August 9, 2021 5:37 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhao, Jiange <Jiange.Zhao@amd.com>; Zhou, Peng Ju
> <PengJu.Zhou@amd.com>
> Subject: [PATCH] drm/amdgpu: Add MB_REQ_MSG_READY_TO_RESET
> response when VF get FLR notification.
>=20
> From: Jiange Zhao <Jiange.Zhao@amd.com>
>=20
> When guest received FLR notification from host, it would lock adapter int=
o
> reset state. There will be no more job submission and hardware access aft=
er
> that.
>=20
> Then it should send a response to host that it has prepared for host rese=
t.
>=20
> Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 2 ++
> drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> index b48e68f46a5c..a35e6d87e537 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -287,6 +287,8 @@ static void xgpu_nv_mailbox_flr_work(struct
> work_struct *work)
>  	amdgpu_virt_fini_data_exchange(adev);
>  	atomic_set(&adev->in_gpu_reset, 1);
>=20
> +	xgpu_nv_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
> +
>  	do {
>  		if (xgpu_nv_mailbox_peek_msg(adev) =3D=3D
> IDH_FLR_NOTIFICATION_CMPL)
>  			goto flr_done;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
> b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
> index 9f5808616174..73887b0aa1d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
> @@ -37,7 +37,8 @@ enum idh_request {
>  	IDH_REQ_GPU_RESET_ACCESS,
>  	IDH_REQ_GPU_INIT_DATA,
>=20
> -	IDH_LOG_VF_ERROR       =3D 200,
> +	IDH_LOG_VF_ERROR	=3D 200,
> +	IDH_READY_TO_RESET 	=3D 201,
>  };
>=20
>  enum idh_event {
> --
> 2.17.1
