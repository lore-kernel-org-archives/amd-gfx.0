Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21C2C4828D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 18:26:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB505112D4D;
	Tue,  6 Feb 2024 18:26:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lYfA53lD";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D4E1112D4D
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 18:26:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CymKqBB9qsfrXG7J263rCRbbEEN2+rRg0BLA4jADiFQUhtv780be6+6Qvkwv97uFx2CdmtCX6tzC7erh/vhBxsyz8ruEsuM5j18lKbsx+VHzrxwu4y0piS6ncdUvlu9qA2chzmcswnxGr0LUDoB0n3cFKdCYFl0GQm1GUWywTOW6UtrwFWy//Ifiwm1D4eml+OP3cnOQ/KvUx+WdnCJ6pNygxmo5Km6tj8M22WZjbHBmKWrEKOyDkEsQPXPKibLJjuE55HfEjXq/9+sY6F3tnT8bEQyQb6/MDLNhrstEMCc/M9NhgN2e+APgtX1zfUDbDdNodMAPXBy0n4S3AUl6/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9/Dth7Rq21ufNxQBAVtD+7mEwE8C0LiTAngKqt/V50=;
 b=NHuCoNfHIK13PfpHMJgt+w7pbRPC2toZ9VLs/yhk5h+lzX0357y3iBW2VLjuCk2ojZvMIdrlxjUBDNDNVlGXW+TZDxsaQ94P4Xxu+ddIB8TVNKvnv/mPorMCYFGdBJzNQ5tEuASFkLwlDYTsI7woDgqch+LaavVr5Cfny89QlAcKYRrFcu1Kcj1Io8cR2mveIa8qXdFfJqW3SJ+3a1XUU6HJpvvS5dV+YzxM/Jp+tntCfXRv/sCn6xXI0vrlmb1qTHRCestdQpKAb68NF7hG2AfKeGhNuiX4V+6+ykKsDOuYxK7NF58GeZe+6Jv5OvsPv9EFmFjA7x1oOCEOnbS2Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9/Dth7Rq21ufNxQBAVtD+7mEwE8C0LiTAngKqt/V50=;
 b=lYfA53lD4O8TPVj51eMKkZCq3tThr7xTtYxdhxLC3PIgeOFCUxg/TrvrAF1FVlMxQ/cni8oPBGcl3pAHk99Hz35ty/Q/03GF7dz8/IwNZqIwGYDFsJnpoQXXyvaRGSw2vmCNwr53ZKFLVCn9IpfpOv9agDpS0Im8wmNPNJnGJJ8=
Received: from CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 by SA1PR12MB8885.namprd12.prod.outlook.com (2603:10b6:806:376::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Tue, 6 Feb
 2024 18:26:23 +0000
Received: from CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::92fa:88b3:a796:2c8c]) by CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::92fa:88b3:a796:2c8c%5]) with mapi id 15.20.7270.012; Tue, 6 Feb 2024
 18:26:21 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/display: Implement bounds check for stream
 encoder creation in DCN301
Thread-Topic: [PATCH v2] drm/amd/display: Implement bounds check for stream
 encoder creation in DCN301
Thread-Index: AQHaWK8mHukneBz9REWzwbgKaBf1T7D9oFBw
Date: Tue, 6 Feb 2024 18:26:21 +0000
Message-ID: <CY8PR12MB8193B3B8DD2AE375A0EFA88589462@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <20240205023449.2542171-1-srinivasan.shanmugam@amd.com>
 <20240206034648.2957318-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240206034648.2957318-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=452fd5d0-f7af-472c-a938-43bfdfdff131;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-02-06T18:18:37Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8193:EE_|SA1PR12MB8885:EE_
x-ms-office365-filtering-correlation-id: 94b4d060-c4dc-42d7-d5e9-08dc27411e6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lidHqTrbdiTGWWML3oh5BTKMm0E3NryAxwaEoHa5dXlSGWJdRwIv1iNQbNdV7ewSX6dUCuCyNqAWpjue4oQVvjaCi+uejK8XFb5ve5gkncZ5uiJwZVo++mmuLUF9sp0l3tJCL1S78Ht/6cK/7ZXg9lFE3zy4ur6Xyw5zxPE6mWwyuTnzbbEqNLofAIraHIk7stm2ccm9M6+SOhuBiJ1LZrA0FPIYIO7GcmefRolyXxWZkcydgcINMciZ3VxFinoITFN38ZF6IL2N1Eb52wkqD9t+U4O1rzUVUjKYaCh6U+RMmjG//JwT8fDwypbv6aQXpPvhqAE88vlWWC+TmTW10JjBOwIH1xsb2b5pzoaViluChrPjvzIViwK3qvvM4/JuYF6oXZeLK4SKhETwuxjppLF1D/TfY7XgaXU8qmDbLJ0Xi9ezA2QaOWjuihEsJ0BasD2ESNb6GuBYp0oiKlywVX9s2IndadQT4/Ky4FrLRkbCmikGObEzNGMcNMQ+RuXafyVzcismlmSWdUA0++vs+XFjoCGyoT6d4lsI5nSL2QikLrNePM+Dq5MIHsHlCWeKo2qsbMqNTxjIiNC0T67v3mk+0jkbla76oSpZql4nHYEkkcRx57w9tclELhhn5d5A
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8193.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(376002)(136003)(39860400002)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(110136005)(6636002)(83380400001)(316002)(122000001)(55016003)(76116006)(38100700002)(6506007)(26005)(7696005)(9686003)(2906002)(5660300002)(66556008)(53546011)(478600001)(71200400001)(86362001)(66446008)(4326008)(64756008)(66946007)(8676002)(52536014)(38070700009)(8936002)(66476007)(33656002)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pNYUfc/G1MFMYzMPXIoNELjniFga68Jw74g8QAGqFqspHmR5rB2WBOkLm1Nq?=
 =?us-ascii?Q?ZCOuIxqjneUzEuTRWxHLMl1DRhNDxIqT5cOV/BU6eWBq6ZDMx+/uXApgof/l?=
 =?us-ascii?Q?xVR2f6wCKbNvszA8ZD/Q/WxiEJ4DlKNg3H0ulHprowtOoKrAQw1DAan2hh2p?=
 =?us-ascii?Q?aI+WMHBUfNFdPv5PzwyZ1pGC1Bc0owWIawRtIB+RiVcQBHeNH3eeLahWpNnd?=
 =?us-ascii?Q?JR3dBekw4Kr/wM7+8l85u1pMe0/vIdUOIpe6UB6IifqmGaMDpgQfKsf+lqQi?=
 =?us-ascii?Q?rO5gY7Gly0YCjdGfEk2oftDBhSX4HHe0IkH/pIi6QH8YXgIn+V7HwgG/eXu0?=
 =?us-ascii?Q?xoT6d6g/co7qg78iTkiyF3sqiaMWpCgWXXnreWyZNwk2nQWEw8ID1uwTajFU?=
 =?us-ascii?Q?TN1mIwbckHx40vdbtOzCGVNQMqbtf2s7+WGfcUa6fhsLbiooNVKxyjQcjyQJ?=
 =?us-ascii?Q?4j8+A/65NWHLLk7hlMPbdlJZeTdbopS0hpQ4LF710kxxyS3/gBPH5Ei/J1am?=
 =?us-ascii?Q?y7AssLr2/P5iLp+CMKPQrU9kl54/G771jGvNF06OChEK0/W1EDhDfUJOZIoW?=
 =?us-ascii?Q?CsprwXT89N8T+wmBteFNinqkz99J8iLey1rApE+hGfiIuS0ti+yU3qRCPhaG?=
 =?us-ascii?Q?BHBCrX4KYmDP0YE2foLEr60W8GSJ67FKnMnwD7CALPJvex29+XM3pTmX2jtW?=
 =?us-ascii?Q?xxaRIBI4NzZ9KPAH0Z7df15Zg97a3rJz5KgU5bA0r438l3GKiQgxA62mzXkB?=
 =?us-ascii?Q?mWnPDWD1+Iwm8ZWi9rQ+cW6z8YXahKb8tWVNZ2T/EkwYeks0TM+nYZw6qHO2?=
 =?us-ascii?Q?fQR0vT0SS0fSsQ/s6uQNJx5tIg+u9m4Z5KqTKINYEvUC1loKw5M//Ays9ghF?=
 =?us-ascii?Q?K/mjjcLGnxF8P2Uj9hqwqIo4WWB/SyRZdXOLZxLufY97+9jgYxX1MaDfHwO/?=
 =?us-ascii?Q?VFF6SKvXhNP3nyQaVrB9RJJkYlBNQIPRMXVD3BSft2AKhcxRC7CTKg7Y7e9Y?=
 =?us-ascii?Q?I4eWlKb7KSa8sRL2uTcDzdEgAJENKIHpo84ZBZlPN5nmk9fN+O7xeh+FEMQc?=
 =?us-ascii?Q?AwZWZz2lRVsnfXCqkx2v8Ao7GLUrMoqxoEHgmkUZw951F5ofuY61RALEdGd5?=
 =?us-ascii?Q?8jWJYPMK+OnYMy+lKw1V74t19rGRjKcyeTbbhqotCGevZ0qF9cgezb1W3nVK?=
 =?us-ascii?Q?hZEvE4mEUvSy+R+NjTaILxQMWlCTUVyioENkmMWwbistCYxuagJJ0IWtFiTL?=
 =?us-ascii?Q?SUrDsxniQ2Bwx9SIfOa0fR49QDY5KAGky9nddWhRoLGbLwK5r4PdNd8KqVQQ?=
 =?us-ascii?Q?w2WQzjAp6xElCwvB+q3ssoA8RiDuiS8Iidx0MQJia9BW1XnFPzw9x7ygOSjz?=
 =?us-ascii?Q?W96ORrWSAfqy53UHAfvqQgGaTJuvXjy3J3WLvzQbGLs4VKtF4pSag6yNjPMA?=
 =?us-ascii?Q?EXYK4P0f98pIS0l7/ZZgsbrAnrkxMz4tK/rHFy+CDqoTV6lZhXtbh+ZJ5ZNa?=
 =?us-ascii?Q?JlWKshX2yikzjN0zH84l4N3m1eMDPxvCacBDpccShTA9BbT1cNQGvf9y6UV2?=
 =?us-ascii?Q?7ZNEiLbijoEeXHcbY64=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b4d060-c4dc-42d7-d5e9-08dc27411e6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 18:26:21.6620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tThejSgLxKZ2U45mF9gdAQ9NLaY1mH9znyUsVrxPyN4841Y64mjl6nZDiD0OVaiN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8885
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

[Public]

Inline.

> -----Original Message-----
> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> Sent: Monday, February 5, 2024 10:47 PM
> To: Li, Roman <Roman.Li@amd.com>; Siqueira, Rodrigo
> <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
> <SRINIVASAN.SHANMUGAM@amd.com>
> Subject: [PATCH v2] drm/amd/display: Implement bounds check for stream
> encoder creation in DCN301
>
> 'stream_enc_regs' array is an array of dcn10_stream_enc_registers structu=
res.
> The array is initialized with four elements, corresponding to the four ca=
lls to
> stream_enc_regs() in the array initializer. This means that valid indices=
 for this
> array are 0, 1, 2, and 3.
>
> The error message 'stream_enc_regs' 4 <=3D 5 below, is indicating that th=
ere is an
> attempt to access this array with an index of 5, which is out of bounds. =
This
> could lead to undefined behavior
>
> Here, eng_id is used as an index to access the stream_enc_regs array. If =
eng_id
> is 5, this would result in an out-of-bounds access on the stream_enc_regs
> array.
>
> Thus fixing Buffer overflow error in dcn301_stream_encoder_create reporte=
d
> by Smatch:
> drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn301/dcn301_reso
> urce.c:1011 dcn301_stream_encoder_create() error: buffer overflow
> 'stream_enc_regs' 4 <=3D 5
>
> Fixes: 3a83e4e64bb1 ("drm/amd/display: Add dcn3.01 support to DC (v2)")
> Cc: Roman Li <Roman.Li@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  .../drm/amd/display/dc/resource/dcn301/dcn301_resource.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git
> a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
> index 511ff6b5b985..4a475a723191 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
> +++
> b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
> @@ -999,7 +999,7 @@ static struct stream_encoder
> *dcn301_stream_encoder_create(enum engine_id eng_id
>       vpg =3D dcn301_vpg_create(ctx, vpg_inst);
>       afmt =3D dcn301_afmt_create(ctx, afmt_inst);
>
> -     if (!enc1 || !vpg || !afmt) {
> +     if (!enc1 || !vpg || !afmt || eng_id >=3D ARRAY_SIZE(stream_enc_reg=
s))
> {
>               kfree(enc1);
>               kfree(vpg);
>               kfree(afmt);

Reviewed-by: Roman Li <roman.li@amd.com>
I don't think the part below is necessary.

> @@ -1007,10 +1007,9 @@ static struct stream_encoder
> *dcn301_stream_encoder_create(enum engine_id eng_id
>       }
>
>       dcn30_dio_stream_encoder_construct(enc1, ctx, ctx->dc_bios,
> -                                     eng_id, vpg, afmt,
> -                                     &stream_enc_regs[eng_id],
> -                                     &se_shift, &se_mask);
> -
> +                                        eng_id, vpg, afmt,
> +                                        &stream_enc_regs[eng_id],
> +                                        &se_shift, &se_mask);
>       return &enc1->base;
>  }
>
> --
> 2.34.1

