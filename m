Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCCFC4828F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Feb 2024 15:21:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C7BE10F601;
	Fri,  9 Feb 2024 15:21:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oiZgX0h1";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71B5A10F5FF
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Feb 2024 15:21:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghY7DmGbWVqkTOxSrXkWLbqXzCU57Lkn7XjwvJcvJmRo/cF8/oMqnwS9FsYgdtZitVbGswVAeMOokqKMvvEvcIEnuiYfM8tEs/VbV7uCHWK6EGEqzm6eOqM0RN039KG7h4k8ERW9b1//lK76l2IFk9Czhwrwv+m7bcwB2di8KT79GdifNvgtDaVtMeopPBELz1Jfj4sRaQ+XmmHnTuQoqzgjcgafmNSbmx8fQaa/E6riu3m9GvmB1q+Max3wdPwRFdjDlb7kVTRU9Y72ENPLdotPsiFxD35gJp/Pg3niwLzD3itXqhf3rpBN2JJyEFrwxd49aiPNhJR5TOYJZS7dnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLZhuhudMt1PmKjrEiGvBBXWW211zBrUFmIu2GYgPOk=;
 b=mdTYWLmpVaybP5oG3QSMIvk3k8/xXOqAD0Dz4e1Nbcau+zC4hO43YA3tkc3BaugCWaEio2UkGVqvPysjtDc3YMZ5sMfowtaKP1OiucrTDxdRa+oNfqjQ5uVFR7Rqe76Ya9WdlfNC92e9b1Uq62QaB/dK0D/XEZFUpxFMI6ebnyF7BvLxQsuyLqGZCQv+JwWV/yw2MpyEUTc9fpkaUFJUFxKTDhOoIq+Cr1CqAQEOxIGDg6l42BRViRcyARl4g03dhK9js0qfdEHQR39mJ4Mdt2KQ6utcAAYw3qMDtNckKfR5EM6Inmp8X4MMSD/MEPTOT20Xtl7N3jvi1I6oaEUCcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLZhuhudMt1PmKjrEiGvBBXWW211zBrUFmIu2GYgPOk=;
 b=oiZgX0h1+99lCYxhBubG/6GTvywj6u+rBMVqVkG/0cErdKuqprYARpRchoXnYofKY+FaO3wNoaMke5fgAGY9v7htSWOy6rQ43LykmW3+o7RBLSOIsz0W7XeGSB4MjWpnAHFWesmMNAWVK4VtP7v0iZizuRwGvLJ6AAqJjbtddg0=
Received: from CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.11; Fri, 9 Feb
 2024 15:21:22 +0000
Received: from CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::92fa:88b3:a796:2c8c]) by CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::92fa:88b3:a796:2c8c%5]) with mapi id 15.20.7292.013; Fri, 9 Feb 2024
 15:21:22 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/display: Fix possible use of uninitialized
 'max_chunks_fbc_mode' in 'calculate_bandwidth()'
Thread-Topic: [PATCH] drm/amd/display: Fix possible use of uninitialized
 'max_chunks_fbc_mode' in 'calculate_bandwidth()'
Thread-Index: AQHaWYHnflJViqZlDEifXsl2/LdOT7ECGQJQ
Date: Fri, 9 Feb 2024 15:21:22 +0000
Message-ID: <CY8PR12MB81938C3D4863D755F47C2A21894B2@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <20240207045501.3344729-1-srinivasan.shanmugam@amd.com>
 <20240207045501.3344729-3-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240207045501.3344729-3-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1fd05d51-c0e7-4d7e-ae3f-3e4883a5c8e2;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-02-09T14:41:50Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8193:EE_|SA0PR12MB4416:EE_
x-ms-office365-filtering-correlation-id: 17fa9b66-d33b-4a26-3c98-08dc2982c5ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EezFYyB/h6IcocxjpYFcX11LS4FKc3K4iUMH1BDrH0A2E0Gxn2YKAHVtVyPvJjziqHvYBPaE05SZI0K9RSI86HqeoiXW2RDiXD7a/gft2p1RD5a6smVaw6oe0LkDBQ/aG+Ks9SPzeF4zGiRlxh69f3ZHrmQAqBYEMEtwaPLSFqtAhyLGciCvp1Dbvk7U1s6xKNlhhnUqsT6KbvouTOLaxoTmLUpWOklmkmFWIWjXxJCb+4alDlzqUIMJEgt1qzdX/4eUCXdNLiikQMz6D1LzaEHMvN6YQklHu0Hfh8XjgnD0qfZeCVgCYCLV8+f5QR/YhPrzDTQIlVsCEOUnxO4AgJ4jn6RCBA6wg0qG3V1EnDDCYrUx6iRbOyDpFtz3t6/6R09pW+W9PwG/RjkHnHXxXxGW5G+rPy/o4RRlfe7kAxFoucGkXbHGtbYlNQAGZMMv0yXBqg0ATjCfMKZw6ix7xgGwrQaK8n5kgLRpklZcJneY3r3Ed0Q0v411dKbaomX4IIcMAjii2s+ReElqM7PS+3b87EPjWVNPbBUEWh0lQLq6JG3kFegf6dRY7MjzTpTOUHV2NjOdY9I6VT4o4P88ESZzyhaOsRKVsiIzE10RWhRlwT7k7GYwT6xsDD/Ywv6Q
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8193.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(55016003)(7696005)(71200400001)(2906002)(316002)(110136005)(5660300002)(41300700001)(52536014)(54906003)(8676002)(66946007)(66556008)(64756008)(66476007)(76116006)(53546011)(478600001)(6506007)(9686003)(6636002)(4326008)(66446008)(38070700009)(8936002)(83380400001)(38100700002)(86362001)(26005)(33656002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gIpJaP5/qIKgh5l34zSR8hi/VTg7Bm/TeR8/UprX0eJc4fsrsC02akWzH4LF?=
 =?us-ascii?Q?kr/YSHlgxfR4J8c/H2+ROTesUf7i1vdVEeqhyZ88x7hbF/tTlky55tKqIYXY?=
 =?us-ascii?Q?AZqg9SmDz1C6gU9foEIX3GghcJl6+Ia1ZP73gs1J+eMII2dZAY0FkJR9ozfE?=
 =?us-ascii?Q?aRpAhvIN9kVAYH9eAc5kWBEBMxRcqbZsvjJueYDcMd2PYcO99mQQsxWdLdZw?=
 =?us-ascii?Q?aw72lQFEPEkX6tDYwk43SA+ZIMouN1+uJOg4gXNeElBfNV8uKJH7H6EvG/A/?=
 =?us-ascii?Q?gG9Mq0ueyMMVJrY8VU9qGT5fze8gAnvwlY2+FE+ANKRgkAPvARR6RZn1DhA/?=
 =?us-ascii?Q?Ir+vMLyJ+3jfHKeuWOFPltaiFhe/BHQLnZpSH3XnsveTDCoQNqZ58+b+/+8J?=
 =?us-ascii?Q?sU6U/yx49EAm3FAdNicnjNfRcj1xSxRbfPNRKCYrcsSv04ZFi3LpZ2tULku1?=
 =?us-ascii?Q?EgM5sgMslyrFrVwELJjdMxq84gpkjE5QWPSHh5bIZ1sIRj7fYjCpQn2u7TdS?=
 =?us-ascii?Q?uIeMnLMGF1l+ZXycPv3k9SMXGcWLZJKjgVLq2bwiSkeOqiGFu/odvMTFhCXR?=
 =?us-ascii?Q?89fibf2ZvJJt2NKngk7d4dy4Lgi/Axd22ZfbsqHGQbZ/nU7ZRyW0GwaC9cBN?=
 =?us-ascii?Q?3hRcUd2B/O5Sflmvik1QMmIc4MN0VzjyYVc2WSMZsAvtYkG+3RXDEN1XX5dP?=
 =?us-ascii?Q?RXDUuYwVsCVsxZqPpQHeorENcqwCJm/QFhfAvWKP+biV5Qnh7laqrnkiDS5c?=
 =?us-ascii?Q?d2R3U4vzHdaK9dBqgOFFysiWeMnTFr7e+x9bN1NvrwFhPxqL2HHJE8y6eoqX?=
 =?us-ascii?Q?HU1b3YuuweNdVmWHEuy0JVmztBBbKAaIoh2mPR1MdeSAXmSGkY8LVSxsU0YY?=
 =?us-ascii?Q?FjtzPJhV5Q2/lT3tSaaFRtkE1Pts+m2GUGGz2PaeCy/0xwiqXm2n+dHX/njs?=
 =?us-ascii?Q?I2CXEnujdwgdUENgq6nI3eb0/XI/ZjPDL+fOSOGCWtNybVXr7tuamC5xkGkK?=
 =?us-ascii?Q?opCXD04F3Ad5U6UK0Z3+i0toXhiPp8ofNp/bhaFla2GhwWW1bDDf8OLj6fQ+?=
 =?us-ascii?Q?YYJOVVSjVFm8q45U4mkLJP+km1H3/6tQ7nuih4t1ORYTMKg5g9DbojG7dEIg?=
 =?us-ascii?Q?JfOFHdeNtwZND2T0Qm7cmOMg+WK7pP0SciMQEhsrvhx9C9uBbF+qJy6bS2tb?=
 =?us-ascii?Q?8jLGfSEsnBQpPxv/7CdJcFYiyMXb+DDlg8/y8pu/xozDClkeWo9p01XMPrG0?=
 =?us-ascii?Q?lIy0qALYOWhpyxwaCX9JfghgWCm6ObE1X5qn5+7mYV/ibt2GgwikM2FGfRoW?=
 =?us-ascii?Q?55w05gzNvOzqzfEuGA1N+bwJSxy2Xh6Tuqus6SlmMvlK5AlDccpCdgVT4umX?=
 =?us-ascii?Q?cepn7tAbbzp4OX8VFUoZPmBiyD8BIzyOsiTFNUaNQbK8qvWFciGM/9TK7lJp?=
 =?us-ascii?Q?3KFIMu0M6DV0jdRqECwivko1hhReCtsRdXBmNpZsgVWrl4HnrLe84ti2K+v7?=
 =?us-ascii?Q?HsgBzdARjZ2La40e3H1bexL/YD9HG1ynCyDr3+SC5OydBQCgK3eEy4s8SHfN?=
 =?us-ascii?Q?Iqwe4W7E2sAM+xPwr3g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fa9b66-d33b-4a26-3c98-08dc2982c5ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 15:21:22.2793 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /sqo6VZgD6c7d+6dnrOXTa6GEXkMaJT7j1TwKQEI6A54k3st4RaP9ILYTArUBrQI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416
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

Reviewed-by: Roman Li <roman.li@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Srinivasan Shanmugam
> Sent: Tuesday, February 6, 2024 11:55 PM
> To: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
> <SRINIVASAN.SHANMUGAM@amd.com>; Wentland, Harry
> <Harry.Wentland@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amd/display: Fix possible use of uninitialized
> 'max_chunks_fbc_mode' in 'calculate_bandwidth()'
>
> 'max_chunks_fbc_mode' is only declared and assigned a value under a speci=
fic
> condition in the following lines:
>
> if (data->fbc_en[i] =3D=3D 1) {
>       max_chunks_fbc_mode =3D 128 - dmif_chunk_buff_margin; }
>
> If 'data->fbc_en[i]' is not equal to 1 for any i, max_chunks_fbc_mode wil=
l not
> be initialized if it's used outside of this for loop.
>
> Ensure that 'max_chunks_fbc_mode' is properly initialized before it's use=
d.
> Initialize it to a default value right after its declaration to ensure th=
at it gets a
> value assigned under all possible control flow paths.
>
> Thus fixing the below:
> drivers/gpu/drm/amd/amdgpu/../display/dc/basics/dce_calcs.c:914
> calculate_bandwidth() error: uninitialized symbol 'max_chunks_fbc_mode'.
> drivers/gpu/drm/amd/amdgpu/../display/dc/basics/dce_calcs.c:917
> calculate_bandwidth() error: uninitialized symbol 'max_chunks_fbc_mode'.
>
> Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
> b/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
> index f2dfa96f9ef5..39530b2ea495 100644
> --- a/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
> @@ -94,7 +94,7 @@ static void calculate_bandwidth(
>       const uint32_t s_high =3D 7;
>       const uint32_t dmif_chunk_buff_margin =3D 1;
>
> -     uint32_t max_chunks_fbc_mode;
> +     uint32_t max_chunks_fbc_mode =3D 0;
>       int32_t num_cursor_lines;
>
>       int32_t i, j, k;
> --
> 2.34.1

