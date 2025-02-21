Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC88BC021AA
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 06:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 587F310E146;
	Fri, 21 Feb 2025 06:46:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uR/8WVC1";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF60310E146
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 06:46:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iwo+pQLP+VNLY+trt4UkBclJzK0GYIvJvF2sJCkBTBOrFef5oM9+wXn1yHuvpqKXxYzViAdErf+tOy43mkdKE3dyACJ/UVhpRcP+OMGrspW+mj0/Wq4ngQEHdEta4MZ6C1xIas/kzLD8kQ1JHMojwSEW0d0z2Udtnp0YHn5vzDbErLRkw9GO/C5Oyw6EwGLCKH5OeXgeB7Q9Cpo1yVX0VpjrfKtfv2y/2qfNqI477yoAl8FDVFyDqsxkDxbV1YAaKkeXlMUKLpojfafnr4qCKsq9WzlBqTI/dhc0HStFLjuvKPyxpnTpbzcWIjYOexINOnq7zvDF7MQNnG8UGIJigQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61SqkoXUdZndxVC5SGPhVazaesKC873WhpsHkOZIJJo=;
 b=eHXl3PWsxQMnNb01tG3rq4oJp1DxOspkjuUJP3kS/Dg4HJxRTx55/gWIQBGNeMAMKGs5L2T/m2uGcKXMzGI8znyTTNinznSqQAoz3ZncFXnQYOX17DwAZ3rVhfsLZsInO4FoAiPdIvY3V0Q/8NCcvFhgyEgJKeOjg36AggNZzUGDY+YWqngTZBVCieVhZd62J8P/zJl/6E7s1aVvyeTvUgK/jgM9steX4asUvnMt79SLtRKf/p8/3jD2zMNTsUNGFRG6LduMHTbQbar2RO63FsmLuSpMJ2jxxQedMuC4jIV8tITV8CqTRBT2I1bnFUqZjvLhm5j8jsPt3RkIzHSTmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61SqkoXUdZndxVC5SGPhVazaesKC873WhpsHkOZIJJo=;
 b=uR/8WVC1Qwjp2fMaQWrrYvCaf/gFPSbv2rzlKZcoBsg9uar+J6RjyVIdFQ4JwlNWg2coPqxnVJ5LIj40wZ2kesyAzdZ7yORh7Bskd+BcjOeedy3kndw3feIbQzioe5b4f0LANhafZ8o7XqumezbQgtp3WqWDmF8ekrrjmw2g/2E=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 06:45:52 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%3]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 06:45:51 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>, "Zhu, Jiadong" <Jiadong.Zhu@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>, "Prosyak, Vitaly"
 <Vitaly.Prosyak@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Enable per-queue reset support
Thread-Topic: [PATCH 2/2] drm/amdgpu: Enable per-queue reset support
Thread-Index: AQHbfqUiexQ948raQE2ivyVTx2oRhLNRWWKg
Date: Fri, 21 Feb 2025 06:45:51 +0000
Message-ID: <CH3PR12MB807461B879AACBBEC58C137FF6C72@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20250214055534.3249909-1-jesse.zhang@amd.com>
 <20250214055534.3249909-2-jesse.zhang@amd.com>
In-Reply-To: <20250214055534.3249909-2-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=724f0133-5a94-4a8d-af95-122650348d90;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-21T06:39:20Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|DM6PR12MB4220:EE_
x-ms-office365-filtering-correlation-id: 48f74770-ce3e-4afe-9272-08dd524361c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?QT5m0RoFKYfhb7aYBXRbXIDYtraO7V4mWZKci5cikAHVRWcBurGMNi6xJgKH?=
 =?us-ascii?Q?78xGNpHrRVE0rsy6jzTzOrlAvJYTc03oxKaJBvbQWE2MNxV8KXXRnmFvlx1V?=
 =?us-ascii?Q?8hwHvFh4wHAHakQgeBXGja/wwtVe9aC7pt341RnrOnwovywTzvw2ZTaiOupk?=
 =?us-ascii?Q?ujQQb3cpem1Vw5tMJyYIj0tHWXqEloPrMtOwt3U6KdiCFmJ2g9G2qXJL9khC?=
 =?us-ascii?Q?qrsSNWfTuS30keHEtoAhasF+fS1e6zNu0uMT6g7FWkQ/tap/jTsLudQYZSFl?=
 =?us-ascii?Q?NkRAxcVunpBaNMGZNIwSCJ8Y4HGD6MC2JuuB32K4ZV+NXbMvV9oSmnekIcyd?=
 =?us-ascii?Q?aHO+KrQS8Vxot8sa2xR+IJu1JHJzgVIeE1Ncaa062p94M8HSNDW1RrrWq87s?=
 =?us-ascii?Q?BEuK15kHoyNablHdrlabSg/TKQp5XpWRkutrexn7kIQ4wr2zdcXYqHZC9JVM?=
 =?us-ascii?Q?b9KnBtbajDbcm3HfUUVHdVBMKPRvkJLtWobU3WsbhqzTCEpzW9JfTJZRweNY?=
 =?us-ascii?Q?9LzsptbYttDKypr5Wktqfl8AcVXc2iR4IUGtteAkTNfRtro2RbT5zMQEkFbC?=
 =?us-ascii?Q?xBx/9RSsZDQ6sZNStGHlaaLC0U22HHSjJrkmzj+tZjzRQuPStL/hr5NS6nc9?=
 =?us-ascii?Q?C9QwB4Az2iog32uy2/ZbbRDCnGG0LlfbWxBTJQtVvlAgd723TSq4O0m20qD1?=
 =?us-ascii?Q?Qe8vxolpfG5sfOyxkYMKqCVnRiYr1L+tEbPTXatNEx+9/Xui2kx/Ssbadamu?=
 =?us-ascii?Q?9yuM3NeCp6PDvWJdHpvSWpzeLgpZmbcaEbUN93SlRoeTXJCZSfo4F51m8+w1?=
 =?us-ascii?Q?s9Ot48oMpAq5ivXlYY5owJ7i7ABoP9CmZr3wGtnOlEUqDrmW+NSOqkeiF5mW?=
 =?us-ascii?Q?k/EInX3YZTuoaDNKAxumH+LHTBTZxUV0BlQrOrdpNl3ZFIfYWR1tPjDtelnb?=
 =?us-ascii?Q?JTRuaIQT/8fStablMpQWOTOfw5puX08GLLiWvmT7jxz1fJ6hWC3Rqxarp5I+?=
 =?us-ascii?Q?ukR7/Famsc/aEeE6ob3Ma7qLy9nHVZyM47nk4O9Ovi6hm+f8EnjV4858uPqS?=
 =?us-ascii?Q?HwCq5t/MUvAFlkNYDhOBqd22FAHXIj9Mb0d5XAWSU0smXRAJqlKofqiiMlqh?=
 =?us-ascii?Q?4rU70BFtP+9TJJKVwcu+NCj6vIQiuJUb/EMPBKgV5aiJkfBz3Kq8ffJUJe90?=
 =?us-ascii?Q?1gIzSIcOcVniDlCLaZXuYmK7WHk08xN3lPcxicuInCp9Vugsq8VRW/TqIscw?=
 =?us-ascii?Q?eO1H97byIi0TYbSd9dePgzmqfX76dR78wp3prIZfLr19Ya9zMuFSZfqAmUjO?=
 =?us-ascii?Q?m02OyV+AJXbYmixFJV8CWgE6HO6U+bjXvrx9H3X0lAaPlvZ52aqRRtR6+zxx?=
 =?us-ascii?Q?t9BwN6A7RTyvJPgayPQ1zpNmJtgZWpP79H+maFSGyeZ86D/ZAUhTQc2nTISV?=
 =?us-ascii?Q?BlYBtgq84DKh9vqKV/teXvbY8fXyk/9U?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u7TBbeFakfQjDwXo8w/N2OdgDCBTLEBgJJPwx9l4bBIU71hShFIYOBhcc9kP?=
 =?us-ascii?Q?/42xzQE4ixCYE8QjS/h49SMYSefkfyxQY6VZ6Q7H47c8HNtKHJvR13En14Zg?=
 =?us-ascii?Q?kfGPbF9aR7m04tG9VpJGU4MbnsH38TinZcDvL6KZbwhi8OPUR2H+raeESvtF?=
 =?us-ascii?Q?69ie/L0QDA8hoJS7IC//NpNmuDw200SO6O2QZGR3rGXrmVzxJfCU0CUeRcY8?=
 =?us-ascii?Q?J1JQHr4CEeReu52u9exFPiiIE8pfWzDbE0qM0A0XoifPkzjmRsiqo4fldzLd?=
 =?us-ascii?Q?LZL2qaMS6rdrrXb/vPM3yZuN6hfeABbqbiH2zyHdo/b/wuGwD2kzS0NksRN9?=
 =?us-ascii?Q?iA9h21V6pQALk1mMeqIIKDQ3qpyIlEX0dPokLRz5xyTnkgiZVmVYcAGtICJd?=
 =?us-ascii?Q?8XehlWpu4FpwT9G1LMwGSP0U2A+0TgjpKnAhAqvTtjqoXD2LayV8M8FC2yVG?=
 =?us-ascii?Q?rxcCW5c0qhm1FQ6SU6VnUIdS6TTi1DYHhCIRGCl7LjJSePXxayU6lh0ECCgh?=
 =?us-ascii?Q?WzscSqq5xl8GUrzYHCBlTBUHc/Epxslp4AAuUEEW0qJPZe7Ah2OvUHnPJ7cK?=
 =?us-ascii?Q?fVccI/LKAAiMYtAXojgk3k5b7+tMF7JDpi6fGsStvi73WOqtmzfVwRE4s/on?=
 =?us-ascii?Q?xbUvicjYlHIG4Hz4TPhvAfxbbMrcCRvI+kWa2pPRrKSbUej/vAx7Zhl+WVWC?=
 =?us-ascii?Q?Oo76qc0HBThuISNOKeSlp3HuNGfLV7HEAxxTDVCd81WpEenAu2YuokHTzwRI?=
 =?us-ascii?Q?BsUkMXb68HUrR2R0VexI5OY4PsATWmD8Q7sno79gq+YzBboRs3mNOBcZntKb?=
 =?us-ascii?Q?SDwtzSbeinPuJbCgTqZHNBTaYZ/AiqoOSUWtJfW69QS4zzz7Fy7MQJ7zvwiO?=
 =?us-ascii?Q?1n0/pY5/MD8lk0YSN3JaRBhSD4yH9K2Ymo5uN1aomHsPthViPk+zi6T+6YUZ?=
 =?us-ascii?Q?P2nli7LDFr6u2dqa6dqt9vEq8S8dn4G/vWPNQGP5/vzbwSndAPl0R/2+Zzek?=
 =?us-ascii?Q?SO0w2zlxAfxxq6Bn+GLwGGQGnGO8Z69Dj9LW6JyZjtJ9+p12FO9y0qCgRWot?=
 =?us-ascii?Q?lt42p702tMGNTNjGLJkp23heJ4FXIV2/zwPBxjty7HZxNewHddxVXYb+OhYG?=
 =?us-ascii?Q?VRzijkq2xWxP+jLiQfTA4XmbVXzsf55w0IX8sL1Ck4PAQju/fgXzMpl5wdst?=
 =?us-ascii?Q?DT45SGoL0wG9r8F6u62wHnH2NB1JyugPVpszcE35lLvbNV39ljTu/6DsmxLk?=
 =?us-ascii?Q?Z2padBYw2Vo9f0tKpQnM3GbZAbyUVWUFniWt2OddRVxYk4+dyXBSNw97tojM?=
 =?us-ascii?Q?loa91h0xLR08ah7CQZCwDlT2aYzG7gAzgwWw/4bzViYqhoOqMz4shLbdr6Ns?=
 =?us-ascii?Q?QEVRzanQR1zqZOXmuaqHZC7J763mZEMDp7LrneThLRVxxmOo3ENGfSNdi+Jx?=
 =?us-ascii?Q?jn303krSBr4gbF1OikipI8gaGoR8HIn/XDawQyEu50HESJ4BwmlK+OomZiiU?=
 =?us-ascii?Q?vhKanv2U6sCXYq7Ju/h21rFp+8vNpse/6F5+mdLSvoyvIvkguBtWXAu+dLza?=
 =?us-ascii?Q?gUKeF32AMB/IPI65100=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f74770-ce3e-4afe-9272-08dd524361c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 06:45:51.2613 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2+/NslUVTzvGOe7GSJ9krIEsVUYDuxTMieR/OBEho6qpBVqQXI/CUhIaljEdoHzeHqthTj93GxmXYWcZfcsxlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Jesse,

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> jesse.zhang@amd.com
> Sent: Friday, February 14, 2025 1:56 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Prosyak, Vitaly
> <Vitaly.Prosyak@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: Enable per-queue reset support
>
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> This patch updates the SDMA v4.4.2 software initialization to enable
> per-queue reset support when the MEC firmware version is 0xb0 or higher
> and the PMFW supports SDMA reset.
>
> The following changes are included:
> - Added a condition to check if the MEC firmware version is at least 0xb0=
 and
> if
>   the PMFW supports SDMA reset using
> `amdgpu_dpm_reset_sdma_is_supported`.
> - If both conditions are met, the `AMDGPU_RESET_TYPE_PER_QUEUE` flag is
> set in
>   `adev->sdma.supported_reset`.
>
> Suggested-by: Jonathan Kim <Jonathan.Kim@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index b24a1ff5d743..e01d97b96655 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1481,9 +1481,10 @@ static int sdma_v4_4_2_sw_init(struct
> amdgpu_ip_block *ip_block)
>               }
>       }
>
> -     /* TODO: Add queue reset mask when FW fully supports it */
>       adev->sdma.supported_reset =3D
>               amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].rin=
g);
> +     if (adev->gfx.mec_fw_version >=3D 0xb0 &&
> amdgpu_dpm_reset_sdma_is_supported(adev))
> +             adev->sdma.supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;

So, we do not have SDMA firmware version dependency here, correct?

Tim
>
>       if (amdgpu_sdma_ras_sw_init(adev)) {
>               dev_err(adev->dev, "fail to initialize sdma ras block\n");
> --
> 2.25.1

