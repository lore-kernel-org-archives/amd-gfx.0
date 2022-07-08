Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0A7C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 03:22:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FC2011B81F;
	Fri,  8 Jul 2022 03:22:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3854111B81F
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 03:22:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hd+DfHHJfz7jRZHCX9JwfKq/Id1M9sYFmKY82WZuogLrQfgF/X/8t1rrBl0W6hgCZ4j99a18iy+nEh91dhm6peD7PLpUJCnrhUWl+qQaIlvPlZVNwlQqddFumuFYa9AUr1c5EDbO3DVaRchHlg27XLeOASvOwsX/HVDs07bhkiuq357zG7vNbg0a0fHXkJJtguRWrXnfdUkY+wF6dZVC/7zqAu4efhatkd45cgne7+KTh1WOuxY11bpExzXPu9EensEjArFw2OBgpkhN8hSk4ZtgAVJva1+I4Z8SCFpVn6DE9fP53MhBcTRr8BWfinvYx305bz6sgtEuOr41i6ikeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+sBFhybdZk9U/sVNQ+s5v9cU+bi9KvA8+CPe8dlvc4=;
 b=QF+7NAuYKom0flrexfHyQnpTxrKh4UsVm45uWkD4JQW7EjhByijcW8n9dpac9MdOKRqRn1uqEEIh6gKbgdnZ/PUUEd22QiHcREVAT/FT4tWcoOvat4sTWrCzvbAwaVPL7KXCsV29z3znh3fU/Ht8RSeYnlPrcI1wSP5s0yGYW8VY37ufLAXm81xxFzNlkzrC54vH0p+h6wgu1lhwTOo9YoNCwWnairraWAtUpLlCL+WNsS7gXNq7MHRHw4fGY96jFdMA6beUY6PgEKsqSk+W0xg/wglhBuZPVihqT4ib2lyewJUQzbnueXfxIIPRUdV2UVdQdCHPldAg0R/s/aMANg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+sBFhybdZk9U/sVNQ+s5v9cU+bi9KvA8+CPe8dlvc4=;
 b=WZtKGNZInUtIM1NSu/TknRDGOaq70Tt/yHLIm1cp4M2+A6GgDwsOLRUoRUgpyf5uPwmJq39kotgCenY2F+Bo7MRUmmbJsBnBNDGyXn/EWshtyHvcWI8lvTnH/bUzT3WYHUXOhJNvYBzG2LYozOHChC7pdB2T1LtDy4q8wQfrap8=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 MWHPR1201MB0029.namprd12.prod.outlook.com (2603:10b6:301:4d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19; Fri, 8 Jul
 2022 03:22:37 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5ca4:efdd:b7b0:53c6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5ca4:efdd:b7b0:53c6%5]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 03:22:37 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Revert "drm/amd/display: disable idle
 optimizations"
Thread-Topic: [PATCH] drm/amd/display: Revert "drm/amd/display: disable idle
 optimizations"
Thread-Index: AQHYkkeNZ9r5vJsxN0KHiF1k1rklaa1zzzuQ
Date: Fri, 8 Jul 2022 03:22:37 +0000
Message-ID: <DM6PR12MB2619C89AA976F5734BA09B12E4829@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220707212129.1642908-1-aurabindo.pillai@amd.com>
In-Reply-To: <20220707212129.1642908-1-aurabindo.pillai@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-08T03:22:34Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=987c86ec-20c6-420d-8393-7464936625cf;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 043fba05-ab91-45e8-a851-08da60911b48
x-ms-traffictypediagnostic: MWHPR1201MB0029:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TSHJzCiaZPZwDJropZR8eNGOn/vbImf2gYcH1o0GZW7wZPFGu5R7wM5b5b2uGp8zqTRYqj5RFJmkd+wx/mp9p6MOZqz7gWbkH5Dpv9zurZqNamPKYltHJCSeNcrXV6Nbx/CN1aNAenLmYVhoDJrHsC5CAFnGYPQ9wNoeKcHepfvEqLVUdUhQJKd5yKzrHToIyQZxL1En4MjXQgWbxsq4eXagRanAeIYC150rY66kQMMBet0Dj5my3PDKYCINPeWQjYGXtOBtOvLGirvCdPctSovxM4kfgMnhNG5q2NlMwVXNMDf5poDRtOrDCWWaZR9DGnGMpcN9XnYjguYsEn+TMvdN4ht3lVtExe225Q8efv9nigiVsZwwfzisCmCs9QYrfQ2SjKJXWHNG6ggqXbHG8kmM2a8zzVdrQhvW37GP1Amjjpk67vGEAcX3eYRXeSPTudUn4Xj97oOAWFAan7EZlUQjREoZNR8dUVaOwfrmCbOmnXJ1rybbXPZ3+6qTb1Cum04tIrezSz15bM74KNR945itNYwqWRx2Z+nRN1DKCJjbJ2YRd/Fixg2qgzKIcid7lryxm9ApvCKpm3CcUcNiolWwseLm/SKI0kw4NqGXqoYhAKcOKo2KFguTPrzL1Ml4GcgPg/m8q0ETdQkwkLJs3HhgIm1HI68OAQb8Xwo8ePiworSlsQId6AlKA5bBIQjd02BDuPTYrTYT9Lh1lVKu8dSwEVglnc9c2OkVi0iYGKA4moY0cJyt+hF7FGbxNEhC7T5VYkOSz/k3KUSQeyBBMQijhg8aHHGuNe5c5j4QTwWtlIIS6nvoyExZQBafAmI4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(53546011)(7696005)(52536014)(478600001)(86362001)(6506007)(33656002)(41300700001)(8936002)(5660300002)(9686003)(2906002)(26005)(66556008)(316002)(38070700005)(186003)(54906003)(64756008)(83380400001)(110136005)(66446008)(76116006)(38100700002)(66476007)(4326008)(122000001)(8676002)(66946007)(71200400001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q3MqYLKQDhh5px2DcngyrEWeI1E6ccyXnbGCcq+pGNFtGmPghfE1g1h2K6sg?=
 =?us-ascii?Q?wU+bxgZ930h0KYRoLQNVwWDxfJuWzO8K9GUykCfsSevFo3bfGd+lFwF4ZPek?=
 =?us-ascii?Q?abgWUBVxpTioZqW7ZgSL+DXm43Gk19tHnRcnFKD0L1pzQ91em1C8SHdwlzwe?=
 =?us-ascii?Q?2iMc3f88SZwReNfiS8rs6M8/wREFwSkZuwxpaLJHc3V1AEmAdDPpQWL1/GJF?=
 =?us-ascii?Q?AmCFF+P9G7szGPHl7blCr86sPpjoc7SvZTdRLo0vZf1Px11nlAM/I8qBvbYj?=
 =?us-ascii?Q?BXOwZk24Ht2ETpXmwPmjwTCoh/1xIrcFIRZ/4WCVbCwH79cIqb5ZyYdMuCTx?=
 =?us-ascii?Q?69t/NsJM4recFVhUCVjOp9UFEEQcyrnnI1c6QR0xaCoFA7L7qF1pYaWj343j?=
 =?us-ascii?Q?oNdKXTk8ee6AAjH9iYMStfZrLBqYcj0qL45nbRfgfc1i4Yx1zMz6wVRZWt82?=
 =?us-ascii?Q?N3iu16DEWULtcgPNAHHFBW48jYVI2VxY8QZ6jub0x7JV2J+Aq9uDhwZBQTQd?=
 =?us-ascii?Q?wEfN4x/Enymbzb0kUH9T+2N2WPzMUX6j3VVLMKNR8I/ErqAL5aI+gFBhdXw/?=
 =?us-ascii?Q?GfxcBHQrZHSVZ1bBaqqThcRq9IKt1lBn+ZlRiYBJiFjFnEBCESs24ZHINpQf?=
 =?us-ascii?Q?qSmADAh2sZFXVuxceJINGbv5aX4OG4SnBXJ2Wn7bfDfZaKj1vG9/Ewfy7bNE?=
 =?us-ascii?Q?ZRglgttl0osfQlaKJ0ctD0KGjuRRBVGx++7noYefswrhXHE52VbsPHtZvev/?=
 =?us-ascii?Q?Ssash4IyHoUYdMOWDPnV0P5S5KVbTMtGmnU3Re+cMn5PxbOwCKRGmqNjq47Q?=
 =?us-ascii?Q?liBdeQ7T7tYbGY6v2nN2HZ9mVIsbRLSeWlsUD8m2OghbafZc6w+4SqeiZJk8?=
 =?us-ascii?Q?8YeQCo4Exv2vs8zw9mfVYv0y0Vnv/oXTKA575NHqCP4mwhU7uNw/3OQ4h8zg?=
 =?us-ascii?Q?8Tsj+Bv1GjIcIuvnutQU/gmHdPcPEk4eGCQjK01GPz7LHOLCe2DHcRlkBY1e?=
 =?us-ascii?Q?zQzUxvuSLquDOfE0heaDul1wyAvjiSt3mYzgvR/fMpndO1hjEc0f1Yhi/rnj?=
 =?us-ascii?Q?8wdJiypA6zjKbhm2lDYmUcO70pbh447B5ZstFwD33hEN1NNh9V9NgYIf1upq?=
 =?us-ascii?Q?AZt7PIqczXVMwmG+AbQ7kicl2iel3LJcqHp9PwKyLcZ7YC4h2fB5sNy8Lv3I?=
 =?us-ascii?Q?UTCULDqdyMMLR053SVfsi9ugbpTHYICig8WKwARlH5yXHf9oaFh3jXyGyjLh?=
 =?us-ascii?Q?e59Sy3vj5edmEOwIEozHyWk2Z4/m6ibRJJQJoEbaEVYL/TUG/4/dOcl/M9Ji?=
 =?us-ascii?Q?Td1bncYH2PifxLDRXMH8RJD2cXSQSTkQ3AVuPZKruE9Tbl2E3mWCLJZLN1ND?=
 =?us-ascii?Q?aVExh3zG4df41ShL5xcxhywngCWKb2pdhTjHnib6Al92Y8RRlFuFUiIxME4b?=
 =?us-ascii?Q?7icJmwfVOdr9RglbpF2ajo4MVM7k+eutGwWgScFIUnQ/jnMLgg4pXXASO5ue?=
 =?us-ascii?Q?VNSd9P0RJGfkI7M5ehgVXaN9BQNLeuN5WOHVAG5LEsdFoIIB6dP6Eu3xTLM4?=
 =?us-ascii?Q?U5/jULlpouzLDjRWtGw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043fba05-ab91-45e8-a851-08da60911b48
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 03:22:37.0304 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ayj4llUKo++1pW8VrpGgQsBFjZ5/RtN6qV1dKEqcxsjADbnnpipoQy9vVUQR9dFv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0029
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-and-tested-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Aurabindo Pillai
> Sent: Friday, July 8, 2022 5:21 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Siqueira, Rodrigo
> <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>
> Subject: [PATCH] drm/amd/display: Revert "drm/amd/display: disable idle
> optimizations"
>=20
> This reverts commit e7ef5569e71bf3fec01ea513c27c6081c0dbbc64.
>=20
> Idle optimization was disabled due to SMU and firmware bugs. Enable it ba=
ck
> for DCN32. DCN321 has them enabled already
>=20
> Fixes: e7ef5569e71b ("drm/amd/display: disable idle optimizations")
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> index b166ab187264..6e829001b53e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> @@ -972,7 +972,6 @@ static const struct dc_debug_options
> debug_defaults_drv =3D {
>  	.timing_trace =3D false,
>  	.clock_trace =3D true,
>  	.disable_pplib_clock_request =3D false,
> -	.disable_idle_power_optimizations =3D true,
>  	.pipe_split_policy =3D MPC_SPLIT_DYNAMIC,
>  	.force_single_disp_pipe_split =3D false,
>  	.disable_dcc =3D DCC_ENABLE,
> --
> 2.37.0
