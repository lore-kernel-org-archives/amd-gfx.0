Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F374C4828D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 04:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFC9410F10B;
	Wed,  7 Feb 2024 04:19:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mXeqhQEc";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C5DE10F10B
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 04:19:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZMC4S9ujzu7ekRvq/uOf2ecj/maRsoYiNlxBIa2ZzmDFwcNF1tdvGCdENh2UDvFPfh7WyVrXXOaMbj6QvfUyiS5Z4jCCwE0RP4nlz397YdhYwWf/GtqZdQl+5RVvGZgfTU4gNkPHttUKNSu16PLzc+M93RRoWMXEIjiL2AOqBISeAAWhe/kkhdDDLzmjRw4T8r1SaBMKMwXFldOI2+sOlYkIISaLt04U8QNAqGgAMR0zz73d+pmXOL46DC0kYKHk8b3p86Dy6Ex7yry61zdhzljF+X9yTMHRAoOlBEeDfKCxfwo8paI2JmQtGBUqdS6wSAHJGsp/tCdJ/XvEEEbIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ijv00KuKrYM92WAwSC+BsaEPIySH3cCkOdH/r6ChgU=;
 b=gpem6Q36s8F6tgZ7lhupWwUooW0x4DJ4jVbbQ9wxDGjebxuKHdKuVS7ZrhNbQBEenC/GyVudUe1vKas4bCZSUJh3Uqkb5O/RPhWv3NgCcDUF6phJe1ZWNl5hl/ZfDaasCh8vN8mioevTUNB1mPjphB54+3lFaujikZ01MNhdV+RAO+b+5Z/74CjJcbspi+6VLVwd9vH2JaEQwAYdwI365nX9guaIgFWO3mk5OLI2KixqubzmbZdagyE3FQtuZz9FO1asfrDrPJ6SHoouBzZQDUAIHZfyYDZdpgKt6JdJZnL7wkoDM0kwKjbpfcAPvj0keoX2cazmB9WBxe+CjPqNMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ijv00KuKrYM92WAwSC+BsaEPIySH3cCkOdH/r6ChgU=;
 b=mXeqhQEcZOeaCW4PqA6+MkiTu+DcR09mgHl2PUg2vbrBW44+a2zgBjBEV5uRQIqQxs6X72x14+A9IJ4a8i6LhlA1rJmMJwBT8+LVormUqk94QYyDhi/MOE8T8eMtFfqT+s4eCYSRyd9cnnC/MI7MooXA87j8q8JweyGbMyk8Z5U=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN0PR12MB5956.namprd12.prod.outlook.com (2603:10b6:208:37f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Wed, 7 Feb
 2024 04:19:21 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52%7]) with mapi id 15.20.7270.016; Wed, 7 Feb 2024
 04:19:21 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Thai, Thong" <Thong.Thai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Thai, Thong" <Thong.Thai@amd.com>
Subject: RE: [PATCH] drm/amdgpu/soc21: update VCN 4 max HEVC encoding
 resolution
Thread-Topic: [PATCH] drm/amdgpu/soc21: update VCN 4 max HEVC encoding
 resolution
Thread-Index: AQHaWVRCIiu8cifTP02S2bq2RAQ/j7D+RskA
Date: Wed, 7 Feb 2024 04:19:21 +0000
Message-ID: <BL1PR12MB51441C6ACE336ADC0125E25EF7452@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240206232828.21053-1-thong.thai@amd.com>
In-Reply-To: <20240206232828.21053-1-thong.thai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=66e7c36b-befd-44c2-a411-0914d01c9cd6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-07T04:18:37Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MN0PR12MB5956:EE_
x-ms-office365-filtering-correlation-id: 43fba349-0f5b-4566-ad82-08dc2793f5c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /rH3wo3dWdhbtkPM9SYW9S22dojDJs3ifcklpLnGnuuNffreb/MCdKgS1yc0mfAuz5MLpMSg4ibl1fGkEXIVPg8/ZoCAc6pE4TY8ZF3TZ40AKpISBRXL3Xj/yBaYDPif/3f6FeXKstfIDXHQPuGRk5coR6c2DTQD9itUK8iZ0PxzPXekYm0lJXMpyRmG1dm/h94rt2IaPju73jbB7PUgJxXmFysRplt/rNdxNo9/86exYjmhh2qna/UWaPbuGhT6OZELihNruvj0ZGpwyxkspLc3rJ7phYufe+sVeyUJNxzSYpKOzqG2CDJj3psZfyiNg3OpjoeEOGigx+1WdGsr+Ak1GADqS0kzi9Z6/aIv5Wb5+EslEFQJYyc2St0c47+EdhhrNch6D68hsGNOVVfqBL22g3Z3hE3TJnrvXX9+OzmCOC7gV39mx3aUZOs57C7bf2SffyteZOJWPYfIEALegnXmnvazbdfBf7bV2yv7QGKUx94ZywfiDJZyRjFQQEPlEtxewGMra/IN2zNPyZl7CF3nhkUg+8cmxqZhNooHHuWnxdtxtCnQ1G+4XXNvB+ayj8KwuvLuxicv/olTwm2fHQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(366004)(136003)(376002)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(71200400001)(76116006)(966005)(38070700009)(86362001)(26005)(122000001)(478600001)(53546011)(83380400001)(55016003)(9686003)(38100700002)(66476007)(66556008)(110136005)(7696005)(66446008)(316002)(64756008)(66946007)(6506007)(8676002)(33656002)(4326008)(8936002)(52536014)(2906002)(15650500001)(41300700001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?avDejo5jSpQRqmJwMi6d6PsofSZ1UFO9OaQcuQmWTbBTLQO92XQ6DXqjKQRb?=
 =?us-ascii?Q?Z92rrADdg1PnVSDYDLpdQEVndd0PVJDY3Fz64lQEBHGW+QiD/p3yBU8/4geQ?=
 =?us-ascii?Q?UUT8Jcx2EqemvfX/ssTHg5GrNXMh2kQ9XvApKuR23u/buK/IYghlCmedPW8B?=
 =?us-ascii?Q?XKIjA2uiB6tMTT45KHZnpkiKjaOFx9zQ8nVl0+mG32oU6wfKuTNGtgk+T32p?=
 =?us-ascii?Q?QHqBdxYD+/vZ95ucuKw6nKNAkNskB6QJhWf9dCknpvwxja8Yh/vHEr7DFrYM?=
 =?us-ascii?Q?H3cyD24uZ6k8gtC8Qld+heVUCOiHh2C421Bs5l8mlexa+0vB9q766ePCHLOM?=
 =?us-ascii?Q?GhTr+UpDewEMpHEj4Alg8U4CEAMwoDdGtotpn5azGlnUXcJKhX3qm95zA2bg?=
 =?us-ascii?Q?TElbytWnGt9IvGb6RHh2kjuK95wOTsMVtBswptgOkBfv/dxHM0jUsg6ByXl5?=
 =?us-ascii?Q?SJWSkw9iO3+oQzQdg7HkyL3aC7yK7BOuFHGLsNUGxjkLLbpxde0K5C8XaRb/?=
 =?us-ascii?Q?yLWwrA/MyBG0pKT+ONt7Cffc8pnkDB5W20RebzKoJ9Rkano4aMpcXPzf7cMO?=
 =?us-ascii?Q?TcPE8CcU7DyGQR4ncNkezCfImJnXwPNc0N5DJDr7tZyrw1B12TdXACdw/jrA?=
 =?us-ascii?Q?Q3XBtD6YRX6AkyCyzRUNX/mQ2Mwg8h8nMC7PUCXG7E+szMLJxXhbAoBmm1k/?=
 =?us-ascii?Q?pJcHa6DfVl16LK0rAom9qiRIWgZhqIXv+tTsDvnudTYCHddcYXN9+C5kLDwZ?=
 =?us-ascii?Q?41VHd5NoNlz5DeKONanSnb9Op3I88EwDApHzM+OkP0b+C0EvsRgmhqPxxjQa?=
 =?us-ascii?Q?xFfWSeElEkGq6mzM9T8v7oBJiy0mHFfwGYNqcmL8+kHgMY2yWEhxgX/zZWHs?=
 =?us-ascii?Q?kahc4ZSI7ZgPus7dXrXH2DSTPgvfVV6HLelEUUzu8MEDeitIN6MG0UU6VjcO?=
 =?us-ascii?Q?OsdMGlxtM8zhF2I9bgXB2OZlspaiZosw/e0kYT9Log2vtRnShwaZMwbJAvnr?=
 =?us-ascii?Q?0qYp/XZB7Q0ikRMCrkV4cQBTVFjbASwPMesRYHKGVRJ+ZQKlmQ9Q+uwwja09?=
 =?us-ascii?Q?X3Drz3+ZbDUqnFlafzFsFRFGEbJvoAZTjqUXGcRM72XwjNFdF/3JAbTanfpC?=
 =?us-ascii?Q?U9pbmpgP97NJe9ERieX7OfE9tDSj3llxu0OWjXztoUR1cxH+1TUes0CK6vbm?=
 =?us-ascii?Q?7ID9L3kHKXmsHoeDp4p/v0BBTDisXf+2rFbaYeWjdtPWGTt09GwkvWsUr9I8?=
 =?us-ascii?Q?T48huSZSSVsbU7CAGh4AJulKpZR4vZgZSnaDEk6d2cDVP3V8cJ4pkMf3R1ej?=
 =?us-ascii?Q?oY0aeWsg3HQDLSsIqB9VHNMTyp7121oU7ukP84wUg+Cb5NnoE4POUz2pcIz4?=
 =?us-ascii?Q?zcNmEBqJyFiui2cIR/nwWBZKseVcLmE8RGT/q7Ca6N5T0AD0aZakuDKXV3LW?=
 =?us-ascii?Q?/J7C27NyJL0l+b+92rngb4NdInwbLOTU1SmZ/xxY/2i5dpB4+ygvivw4h4T/?=
 =?us-ascii?Q?4xSLtiO7m9JyV1z0UBccxUoUQ0bKMhq4pu3S3aGx8bEOBqwl11em3ZfLhORS?=
 =?us-ascii?Q?yb7L7gGBBRw0gBrBbCg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43fba349-0f5b-4566-ad82-08dc2793f5c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 04:19:21.6805 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cF3AvIrVoB/FO/E0yivZaeVh6KwlZSDzP2ghoHrAPsf3xdUA+4MpRtqEurxggGQrpOsxp8M7tanzfLIGFADsQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5956
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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Thong
> Sent: Tuesday, February 6, 2024 6:28 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Thai, Thong <Thong.Thai@amd.com>
> Subject: [PATCH] drm/amdgpu/soc21: update VCN 4 max HEVC encoding
> resolution
>
> Update the maximum resolution reported for HEVC encoding on VCN 4 devices
> to reflect its 8K encoding capability.
>

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3159

With that added,
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> Signed-off-by: Thong <thong.thai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc21.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c
> b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 48c6efcdeac9..4d7188912edf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -50,13 +50,13 @@ static const struct amd_ip_funcs
> soc21_common_ip_funcs;
>  /* SOC21 */
>  static const struct amdgpu_video_codec_info
> vcn_4_0_0_video_codecs_encode_array_vcn0[] =3D {
>
>       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4
> _AVC, 4096, 2304, 0)},
> -     {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
> 4096, 2304, 0)},
> +     {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
> 8192, 4352,
> +0)},
>       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1,
> 8192, 4352, 0)},  };
>
>  static const struct amdgpu_video_codec_info
> vcn_4_0_0_video_codecs_encode_array_vcn1[] =3D {
>
>       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4
> _AVC, 4096, 2304, 0)},
> -     {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
> 4096, 2304, 0)},
> +     {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
> 8192, 4352,
> +0)},
>  };
>
>  static const struct amdgpu_video_codecs
> vcn_4_0_0_video_codecs_encode_vcn0 =3D {
> --
> 2.34.1

