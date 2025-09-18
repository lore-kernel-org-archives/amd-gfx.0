Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0042CAC597
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 23:38:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D5DE10E20B;
	Thu, 18 Sep 2025 23:38:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GbWRk4lM";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 131C910E20B
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 23:38:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WN2ZZWGKYCbd4JBolZalYX0HnHFBqI0V7g/116p1f6gMSXpkkxtThOb3TDDAc3oldrcIPlsk4acMrPc5P6LZT8Y7a8SYrRVZMMj98oem38o1LKFEfeQzZGGwowPY3ualXFNHHsR/YvS3/o7Nr6NreCFDDMzApg8d/VQp1LtqR11u1Hn19KHlbfzLkvfkN2g3KNyhsimO+SN/HG2i7dpczla85i08pt/ZStBn0wfvWlVG8UuKdNEIkaepdBMgPUZEfld6tn3ub6atLZJocVDh64ra0eiEOLsNsUzQWjJLKU8zHkLgypnWSVIR75U1cxqw+b37L7RTF4JZb121ugagfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNJ6DnUCQqDB8V8wI/6m3w5GqiRKMZe3cQc3GWDNkT0=;
 b=a0ZAIneF1TAvjgJE7mZ0aarN6PhulJAdAn1zKmtN0yEP/MZE6SBIOiC+g5R7k8m0LtkT+Jg54IU2CpJIFfnUcQqTcadIloSAG9K6dyTUhJt7vi+0FTu7VnGO5yt14iLypajXbWzqxw+7942d+zVd1KBWEpzZ4a2fZGYcQWnhaOvLB51W292IXzmmPZ2cDfNVBMLb2fq6sEaZzjszE8yJyQwFzURT53Enu17jpZS0QwL7JSmvPosGLwQCxjTTwktC8c4WySxhkAfdAZuwOZDIYLhjcYAFmz22z/IIgxS5OKOQsWCP3yw81QSxlS8YY/a4QqSdgNRbWUoolqmUk/t6zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNJ6DnUCQqDB8V8wI/6m3w5GqiRKMZe3cQc3GWDNkT0=;
 b=GbWRk4lMbNm0hDqO/lvydoKg5LqHhANM+Ox1JKJdhoNEe+e+jHqnnOBGc3YDp6uPc2czsks/geo97OzZw0qRdiSrl/QzrPSwLFFy/jfvVflQRdwlhhetVibpOHoFo3unukM25PdgdPPAbqCt293rSTadQJAGw41ncCnF7fwHCjo=
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by IA0PR12MB8206.namprd12.prod.outlook.com (2603:10b6:208:403::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 23:38:19 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::daf7:af35:c454:4c1a]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::daf7:af35:c454:4c1a%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 23:38:19 +0000
From: "Jiang, Sonny" <Sonny.Jiang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>, "Ji, Ruili"
 <Ruili.Ji@amd.com>
Subject: Re: [v5 1/4] drm/amdgpu: Refactor VCN v5.0.1 HW init into separate
 instance function
Thread-Topic: [v5 1/4] drm/amdgpu: Refactor VCN v5.0.1 HW init into separate
 instance function
Thread-Index: AQHcJeXFl2KXwq9S9UarpSfwkH7FNbSWtZkAgALo2eI=
Date: Thu, 18 Sep 2025 23:38:19 +0000
Message-ID: <BL1PR12MB512679175E40E6A516A7AF2AFD16A@BL1PR12MB5126.namprd12.prod.outlook.com>
References: <20250915020924.137122-1-Jesse.Zhang@amd.com>
 <DM4PR12MB515258855577C26BB8858E40E317A@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB515258855577C26BB8858E40E317A@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-18T23:38:18.749Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5126:EE_|IA0PR12MB8206:EE_
x-ms-office365-filtering-correlation-id: 157a24df-c9ea-4509-6930-08ddf70c72e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?nOo/BufpW4HZJdACW/Bjx4ciTaln/nxelrcIwKGkE+ZC4DiAdgVvqJ+bqXZy?=
 =?us-ascii?Q?gdOHJNMRzHAjMpKU0cAxQ+hplTH8FtRUi6dWkieSH5WlyMwbsmzsyxpcaLRQ?=
 =?us-ascii?Q?EDNyZkR7ZRtAyI9uaH7LqeYclmCuwgdlFnJG5cSRGzA1jjNha9qWSEqZxdzw?=
 =?us-ascii?Q?eutpfn7wlAWj+ikR+i5KBNK4Cw0EMp4No9nr8AURneeb7y3xj3K66m4e9184?=
 =?us-ascii?Q?x1FyuxeoTEVoYiTp129PPksWSkRIFLPQ8LsJeQMCqvatMFlANLH/Px0kroq/?=
 =?us-ascii?Q?bQQ4+Hu5bw8DHEa3M1UC60Ch+PvsXO7F7w86+V67Tmjxg4osuMRk1n9oYnvi?=
 =?us-ascii?Q?SmY5iEDXZlMJqh+BQL74B62o8120/oZ81l41AjvYtITyi9G77n/2XUxnquLQ?=
 =?us-ascii?Q?li+5ewFVXVlmPrdpiVOQsgyuQsSgOEpG5CmmuNjrg5HHLiE5KX3ohS10fAic?=
 =?us-ascii?Q?62QEiLT/mSenzEWj2Un6oMogSQs9nY0/SdNyI4S8kcluXdISMj9Un3ch1WuZ?=
 =?us-ascii?Q?iVjsiv7YpIZbUvZ7yczZQF18hTtcimwB/e7+PmlaAWP7RKMLzai733+sohx9?=
 =?us-ascii?Q?c2YjnezbEAAQZIsjo/0egFuR/sIltqJayE9XZZSBCKXSQ3SdvFMUc02ixPXY?=
 =?us-ascii?Q?JzXJLXDIkwl9oywCSu0eLZfC5GA4QsT6GWnJ2QufFD7oGOkXbDxikVXckUbd?=
 =?us-ascii?Q?WJKZoOCZHWiSdvSPuOn7f9as3omcYc3r9IsiPkGtqgDDO+jD8M9ABmTHFL7F?=
 =?us-ascii?Q?sPhChMW6WyNtY8SoM1T1TWrUnFJxgURtz97h3eLbD43aj3Snc6VdUIBpKi5F?=
 =?us-ascii?Q?fwFHcvtch0gWY5VLSvXa1YXeAqoseRCZ2zRwIWEtIueQ2E6WgFjSnw2Y2sFn?=
 =?us-ascii?Q?vHmMoJi2F6TyRZoJZ0gPAtwUQfEWBnJxS4rl773o2u/VOBf2WSTdwNMARkMA?=
 =?us-ascii?Q?Rz3wKNB5aWOsTjv2QQuUuRXdQShpt+au8IS2S6wfMI8GlppSqlLVhGkfkNUH?=
 =?us-ascii?Q?6zgZUOrxUz9LuwHxcjK1Qq9y2I+PyiDicRcAurdZTiGtV6eVgcXIOwTFahek?=
 =?us-ascii?Q?CjC1klD7TGGfujWwnFqiEF/b2IVACt2lnM2Lf1XRgNGDmDJ7pT9jBKFoTiAD?=
 =?us-ascii?Q?ZPzzgNcxpKnq4O7VU/Z2h7qoIr7eaTlZMqWYRKv/jPtyW4v94Sp4Uc7pZMDk?=
 =?us-ascii?Q?lHoLD2PtnZ6Tz6bSsIweKGYCa7mUTaeapnYvsgosGFcbMfVOv1woZ5pM1Oqn?=
 =?us-ascii?Q?pyBMzC7fXwZ1BjFuVhbHUb1UpV/Jdpg9z+w41Sj/xeX5iMie77/clxPfS+ia?=
 =?us-ascii?Q?/wemIJ4ufEOtlqWZ5IAqbyHAic6TPaalFFjqvitEZspf14nAczvu54+pbIMO?=
 =?us-ascii?Q?oSJ+bAdD5VO+YBsRVpQoDqzLx9189IdNolD53jqMQTlu+sAX2CCd11uNr3rt?=
 =?us-ascii?Q?kwMUglxFuYwebKUo+HEGIYRkD0Hh3/GQjYiH5UzMJpzkYwykUzHlEQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aUhApkGHpnAEim014qovgg+QrsO/kKHzAM64zEF1/mO9Y0cVHsRaD2h2qbN+?=
 =?us-ascii?Q?kmc2P4+Vw+/JnDOEXRqzFra12/jMKsJuuYZhsRbVoz94lMuDLC8X9hXjnjz3?=
 =?us-ascii?Q?lt4gghF83IsVfQcY6ewvFNAUAQwHDWtRWL7SikhHFRwYzmB3GIOrtMQVN0zN?=
 =?us-ascii?Q?khNW4Lvr6WKGMffRR8SOR5qqFxVg0X0Eo9/eq3S1w2cBnw3JVtYf2RJ2l64a?=
 =?us-ascii?Q?uv6tfZgMt5rpnHrRDVSkmohXy39VsI8c5IeSAurwuSlRTKmf5kg85kDPxKA7?=
 =?us-ascii?Q?L656ADKj8jcIllRGD558/5kn3js77h/OzDzdKvgYGORUQPEorfmx3FCjCDvR?=
 =?us-ascii?Q?T+KMZmU7red/IDRdF759Fs+JOBSEp/sFRT3KthHBYQYIgdern807IHkeRAA7?=
 =?us-ascii?Q?mgGHeKQMinc/1byHrmRSnNA136nu178mzeVL7i6eCiTJHcBjHzTWwKb6FsYn?=
 =?us-ascii?Q?TzaZp82k9yGYgLh/Td3qgptHVutAfwbAmhALcs7RT+ZwGZCaEQf05HZiMlg+?=
 =?us-ascii?Q?D4/R9uV3vguyzYJhIJVTCVKXLT2vsH2V7Hgb9ZfHYUY72QcVUhjaCbmUJZ2C?=
 =?us-ascii?Q?4UEKorLONU+fWMTAwAikvK7PuXPd3dQsPdz9QmDTuj49/ps03G37k2kEu+c3?=
 =?us-ascii?Q?V7gsMAAWTDFph3qKyhI8Gi+zpJ8FBur4uNPT2Nt5R9Pjwbcl/xr4d1wPVqL2?=
 =?us-ascii?Q?j3/C9gnHGYFdCyoQhh0xtxcl3x0Ar3FnW+obaebsAGrBk5Cm55Mwr0ZBikdn?=
 =?us-ascii?Q?LbeweMaPeUiHKQf7lSn8h/VPc/R55yFp78U5OmqV2DtSZyogbvRPEZdeN1Av?=
 =?us-ascii?Q?eWxvBMuCpGABWLaEWAmINXGbrvS4L6ATCE7y3QBiGOq8RYJswFqoZRPWG9W6?=
 =?us-ascii?Q?4g5Rv0JlTBHlQNC8JJTMPvB04Os1F0yRqP0me6ZShp5w/PxeDZfsoFdFnkxJ?=
 =?us-ascii?Q?jQi6OrcIhjNw7kLBAE5FQ9MfOmuI+l1GJzv+uTiq7RGBu5n07u4q9MjMvPsE?=
 =?us-ascii?Q?Kt7atNKCPpidB3AtrMJji8+vPM5fNVFgmTa/WZEpYlUNkV13WWApbUo0cCkD?=
 =?us-ascii?Q?9ZkGPGt3JJwnk8adoVjx0VAOHoUEIQoDtKzOTGsONwPEDkUIzLuNfV4VJM26?=
 =?us-ascii?Q?r5tb7Z+BUiM8FyR3p8jYfTaTBkZM8ei7vklOVL2+cm4Whvnrhw5q2Rbl2x13?=
 =?us-ascii?Q?HbRM2MK8WesqjGX7v1aHLKNOtXsimE8tuG6y0+UZAgxW3YsyqnvZuY5JhZbs?=
 =?us-ascii?Q?MseuUkTlWWNg6QZmhxXDrv5IkIST71B4YR3W1HQxFN7DtgZi9tCdBx+NK+wf?=
 =?us-ascii?Q?92LFBHisowIkKKaRyK6mRfru2jrHT55qcI+ziHRWILCnMfbkly3Rwj4loW4v?=
 =?us-ascii?Q?o9bt9RiOX4sKzPNHTvpIvVgBK/8FN2pG0Cyz8A1ObDK2yam6CfrcmiTbIlNj?=
 =?us-ascii?Q?yBUjhKoz2eVKOMBjksT+Zyj9YQm8aeLIAbA08ap0Sjspo0oEz48II+TM4QVs?=
 =?us-ascii?Q?StEvoCMQgHROLTdEEHSsTQNsivfVxolKDK0xvpYJQfhw1sax2RV9uud4DymH?=
 =?us-ascii?Q?uNJeSbxZbluCnFkkMEw=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB512679175E40E6A516A7AF2AFD16ABL1PR12MB5126namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 157a24df-c9ea-4509-6930-08ddf70c72e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 23:38:19.5371 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AIyhK90cPYukSoLOjyN4TOawXEDadLvoYzMUZChX1MSMhdtmo6xEPMmD4YX3pUgC2ZhFnOUBy4BDaBGECZ2Mjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8206
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

--_000_BL1PR12MB512679175E40E6A516A7AF2AFD16ABL1PR12MB5126namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

This serial is Reviewed-by: Sonny Jiang <sonny.jiang@amd.com>


________________________________
From: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Sent: Tuesday, September 16, 2025 11:11 PM
To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Jiang, Sonny <Sonny.Jian=
g@amd.com>; Ji, Ruili <Ruili.Ji@amd.com>
Subject: RE: [v5 1/4] drm/amdgpu: Refactor VCN v5.0.1 HW init into separate=
 instance function

[AMD Official Use Only - AMD Internal Distribution Only]

Ping this series.


> -----Original Message-----
> From: Jesse.Zhang <Jesse.Zhang@amd.com>
> Sent: Monday, September 15, 2025 10:09 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Jiang, Sonny
> <Sonny.Jiang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Ji, Ruili
> <Ruili.Ji@amd.com>
> Subject: [v5 1/4] drm/amdgpu: Refactor VCN v5.0.1 HW init into separate i=
nstance
> function
>
> Split the per-instance initialization code from vcn_v5_0_1_hw_init() into=
 a new
> vcn_v5_0_1_hw_init_inst() function. This improves code organization by:
>
> 1. Separating the instance-specific initialization logic 2. Making the ma=
in init function
> more readable 3. Following the pattern used in queue reset
>
> The SR-IOV specific initialization remains in the main function since it =
has different
> requirements.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Signed-off-by: Ruili Ji <ruiliji2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 27 +++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index 9c281ba6bced..3677ea9ffa43 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -253,6 +253,23 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_block
> *ip_block)
>       return 0;
>  }
>
> +static int vcn_v5_0_1_hw_init_inst(struct amdgpu_device *adev, int i) {
> +     struct amdgpu_ring *ring;
> +     int vcn_inst;
> +
> +     vcn_inst =3D GET_INST(VCN, i);
> +     ring =3D &adev->vcn.inst[i].ring_enc[0];
> +
> +     if (ring->use_doorbell)
> +             adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbe=
ll,
> +                     ((adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> +                     11 * vcn_inst),
> +                     adev->vcn.inst[i].aid_id);
> +
> +     return 0;
> +}
> +
>  /**
>   * vcn_v5_0_1_hw_init - start and test VCN block
>   *
> @@ -264,7 +281,7 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block
> *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
>       struct amdgpu_ring *ring;
> -     int i, r, vcn_inst;
> +     int i, r;
>
>       if (amdgpu_sriov_vf(adev)) {
>               r =3D vcn_v5_0_1_start_sriov(adev);
> @@ -282,14 +299,8 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block
> *ip_block)
>               if (RREG32_SOC15(VCN, GET_INST(VCN, 0),
> regVCN_RRMT_CNTL) & 0x100)
>                       adev->vcn.caps |=3D
> AMDGPU_VCN_CAPS(RRMT_ENABLED);
>               for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -                     vcn_inst =3D GET_INST(VCN, i);
>                       ring =3D &adev->vcn.inst[i].ring_enc[0];
> -
> -                     if (ring->use_doorbell)
> -                             adev->nbio.funcs->vcn_doorbell_range(adev, =
ring-
> >use_doorbell,
> -                                     ((adev->doorbell_index.vcn.vcn_ring=
0_1 << 1)
> +
> -                                     11 * vcn_inst),
> -                                     adev->vcn.inst[i].aid_id);
> +                     vcn_v5_0_1_hw_init_inst(adev, i);
>
>                       /* Re-init fw_shared, if required */
>                       vcn_v5_0_1_fw_shared_init(adev, i);
> --
> 2.49.0


--_000_BL1PR12MB512679175E40E6A516A7AF2AFD16ABL1PR12MB5126namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
This serial is Reviewed-by:&nbsp;Sonny Jiang &lt;sonny.jiang@amd.com&gt;</d=
iv>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Jesse(Jie) &lt=
;Jesse.Zhang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, September 16, 2025 11:11 PM<br>
<b>To:</b> Zhang, Jesse(Jie) &lt;Jesse.Zhang@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Liu, Leo &lt;Leo.Liu@amd.com&gt;;=
 Jiang, Sonny &lt;Sonny.Jiang@amd.com&gt;; Ji, Ruili &lt;Ruili.Ji@amd.com&g=
t;<br>
<b>Subject:</b> RE: [v5 1/4] drm/amdgpu: Refactor VCN v5.0.1 HW init into s=
eparate instance function</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - AMD Internal Distribution Only]<br>
<br>
Ping this series.<br>
<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Jesse.Zhang &lt;Jesse.Zhang@amd.com&gt;<br>
&gt; Sent: Monday, September 15, 2025 10:09 AM<br>
&gt; To: amd-gfx@lists.freedesktop.org<br>
&gt; Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Chri=
stian<br>
&gt; &lt;Christian.Koenig@amd.com&gt;; Liu, Leo &lt;Leo.Liu@amd.com&gt;; Ji=
ang, Sonny<br>
&gt; &lt;Sonny.Jiang@amd.com&gt;; Zhang, Jesse(Jie) &lt;Jesse.Zhang@amd.com=
&gt;; Ji, Ruili<br>
&gt; &lt;Ruili.Ji@amd.com&gt;<br>
&gt; Subject: [v5 1/4] drm/amdgpu: Refactor VCN v5.0.1 HW init into separat=
e instance<br>
&gt; function<br>
&gt;<br>
&gt; Split the per-instance initialization code from vcn_v5_0_1_hw_init() i=
nto a new<br>
&gt; vcn_v5_0_1_hw_init_inst() function. This improves code organization by=
:<br>
&gt;<br>
&gt; 1. Separating the instance-specific initialization logic 2. Making the=
 main init function<br>
&gt; more readable 3. Following the pattern used in queue reset<br>
&gt;<br>
&gt; The SR-IOV specific initialization remains in the main function since =
it has different<br>
&gt; requirements.<br>
&gt;<br>
&gt; Signed-off-by: Jesse Zhang &lt;Jesse.Zhang@amd.com&gt;<br>
&gt; Signed-off-by: Ruili Ji &lt;ruiliji2@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 27 +++++++++++++++++--=
------<br>
&gt;&nbsp; 1 file changed, 19 insertions(+), 8 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c<br>
&gt; index 9c281ba6bced..3677ea9ffa43 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c<br>
&gt; @@ -253,6 +253,23 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_bl=
ock<br>
&gt; *ip_block)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; +static int vcn_v5_0_1_hw_init_inst(struct amdgpu_device *adev, int i)=
 {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int vcn_inst;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; vcn_inst =3D GET_INST(VCN, i);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ring =3D &amp;adev-&gt;vcn.inst[i].ring_enc[=
0];<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;use_doorbell)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;nbio.funcs-&gt;vcn_doorbell_range(adev, ring-&gt;use_doorbell,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev-&gt;doorbell_ind=
ex.vcn.vcn_ring0_1 &lt;&lt; 1) +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11 * vcn_inst),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vcn.inst[i].ai=
d_id);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; /**<br>
&gt;&nbsp;&nbsp; * vcn_v5_0_1_hw_init - start and test VCN block<br>
&gt;&nbsp;&nbsp; *<br>
&gt; @@ -264,7 +281,7 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_blo=
ck<br>
&gt; *ip_block)&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D ip_=
block-&gt;adev;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int i, r, vcn_inst;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int i, r;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; r =3D vcn_v5_0_1_start_sriov(adev);<br>
&gt; @@ -282,14 +299,8 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_bl=
ock<br>
&gt; *ip_block)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (RREG32_SOC15(VCN, GET_INST(VCN, 0),<br>
&gt; regVCN_RRMT_CNTL) &amp; 0x100)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vcn.=
caps |=3D<br>
&gt; AMDGPU_VCN_CAPS(RRMT_ENABLED);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_inst =3D GET_INST(V=
CN, i);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =3D &amp=
;adev-&gt;vcn.inst[i].ring_enc[0];<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;use_doorbe=
ll)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;vcn_doorbell_range(adev, r=
ing-<br>
&gt; &gt;use_doorbell,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((=
adev-&gt;doorbell_index.vcn.vcn_ring0_1 &lt;&lt; 1)<br>
&gt; +<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11=
 * vcn_inst),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ad=
ev-&gt;vcn.inst[i].aid_id);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_v5_0_1_hw_init_inst=
(adev, i);<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Re-init fw=
_shared, if required */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_v5_0_1_fw=
_shared_init(adev, i);<br>
&gt; --<br>
&gt; 2.49.0<br>
<br>
</span></font></div>
</span></font></div>
</body>
</html>

--_000_BL1PR12MB512679175E40E6A516A7AF2AFD16ABL1PR12MB5126namp_--
