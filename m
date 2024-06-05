Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26EBC25B76
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 09:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B02E910E023;
	Wed,  5 Jun 2024 09:46:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4kFjFbXy";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BE6410E023
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 09:45:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gM03wh5ixV9tjnwRMMeZKL42tNV3MuhE9mgA/ggngMNg2oHwFSxT4lRpLHSLMJJmv80ka0eFTBqTHG+t5qDHWAmEokrJjPo8Y10ASl71Gi5VmFU/NLhCb6l0bpCx0HZzwqziL5ELvZzEs+ZckKXFMEnAJElECMKRMzbM0jeAgOTovJa+RfFakaDyABV2z0mbjHnosNaMuWIxbGBS0t6/mronRqKGpfeNtMBKB8O+djyCjxRnr76oFYWNlh8SqYRlNMWByi+DfoY0BzWPT8TOHLEFzDn/ZTsPJ4WGJMMwIB+zj/emhy49mEhIvDPL6S9cBVW5Un5JH8o/m+/46HD10g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Po9pdEO1DVKe1mcyLGMLpkdzMQKLfIbvPQxw8VrPu+Y=;
 b=hcyKE43UASdJORgOWsywLeBZ2tNKAjCohiztvAd31ZTtM+4Wm3MRqN/iIiEZOIQwFOOdWT0tsTlUdF/vygTwOfvc0gOCychZd7Lb25jTwqUZocFgPuQ69M8SZdJrUtHlB+9u0BIIbsARMcSib5y5DypL4p3h7TNCbEjgR+h3EE4CUFYZw0UCirlS/r/ZAjHb01erSouSNJTm0mDkDMwUHho1OrvsKJktwX1jVnUeAK+75NmIu8IAlSYnKhi4k56pS8Z3CxuoTUhBbYAd69sqxALpAAfo7Wq4++425zZRbgNn6WK4adpe5rv1DrhgU4AVf/Dbs7u3cy0iqtWL7PD5UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Po9pdEO1DVKe1mcyLGMLpkdzMQKLfIbvPQxw8VrPu+Y=;
 b=4kFjFbXyT2HNRKS/2hW2VjvnvnUFtrmpqcaxK0VQhc7xF1mHfjvm9wcLIlAMCxJKu+SP+8RgL/EmnbCWHrwtlry1/c7XXAFe9JNEZMSdpbvPPgOC25MFic9YpUwGGtEhQXuWZf1LURO5HBZvg6cMv83bPCS6LFUpUipGvXN25tw=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SA3PR12MB9106.namprd12.prod.outlook.com (2603:10b6:806:37e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 09:45:53 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 09:45:53 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: move some aca/mca init functions into
 ras_init() stage
Thread-Topic: [PATCH] drm/amdgpu: move some aca/mca init functions into
 ras_init() stage
Thread-Index: AQHatysux+JmOEfMOE6jEFs+39johbG46/JA
Date: Wed, 5 Jun 2024 09:45:53 +0000
Message-ID: <PH7PR12MB8796BCC45E981D30A6BEC91DB0F92@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240605093130.3045812-1-kevinyang.wang@amd.com>
In-Reply-To: <20240605093130.3045812-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bc9b74eb-3e95-4c6d-aa0d-857e62f25f62;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-05T09:45:47Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SA3PR12MB9106:EE_
x-ms-office365-filtering-correlation-id: 4f37706c-cc57-4891-fd3c-08dc85444ab8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Srq2U8EQo+1hQRtSVcDuyIQza9yJa2gtyCd7u0qStJG1uNzOapnw7VMhvFPX?=
 =?us-ascii?Q?EUQtao1tJWtEOefgzy5MoTtXMTAO52HyFbo3+o7POQhMmrvIdFYQ7ZqNuO5l?=
 =?us-ascii?Q?Ovwr/ORWw68Mvk+d4WkY+tqGd76o9Iiok6xtpnLsbMrk6ogR4z3OwclgQEMu?=
 =?us-ascii?Q?hoSKbWPzY9+uMVhAVtyMIFGBK7bEh5+X1fOUn7rh/n0EnoXHBlCh8bReNYxi?=
 =?us-ascii?Q?xOAXPeeG2yvGbXLQw2vwDCAfjda3LQOH77Rz9KSXpJKf6d+gjKtyKee+uoKg?=
 =?us-ascii?Q?txBg7yWIZO4M+I1NYJstR9xknzoO+xQwyZx8G/+JlpruoMM7RKGZF3l82MCk?=
 =?us-ascii?Q?/1323EMZNbI3RR81QGZa6ygzQZk1Zd4sN3FfOpXalowphfjFU4pXShWhzORe?=
 =?us-ascii?Q?Hx7c6ArhPjfzg+lSKBoEZHvYVAkvOnA0C+YmgkmTf/hxpgWc8H++QKMufo57?=
 =?us-ascii?Q?BUGQzbs1Hfr7KlVDgZxzjvRfyvZligfWZCa+xNF9GIiZZozlj2z6dSrHZqDw?=
 =?us-ascii?Q?gIDTbqoqz8VTple8w58M651jUTNz5Ar04uTCl7/gfSs1GP6sHj7HDWxiWhVM?=
 =?us-ascii?Q?TdHW510Zp/4gPS7Zw7hkhBKTwg5sFq1LhqHpyeHiHISdWvdFNt8L9/Onyx9e?=
 =?us-ascii?Q?VYklH7uZqSIJsA0B6He48nlqHYO4RMfhtxLRga1yXA9A/FuY3iCdRyNd7ctj?=
 =?us-ascii?Q?xx1GRlu53/2Ls9KPY5LSXZpBlEBw+TRud+oKdYdLmejFjCYA/KfVRLXFT5vN?=
 =?us-ascii?Q?yK+PYzo1iXzz/Q8ZZBRicariROhvldY/wpAJkCIyjlhuzdjO72Zta1d8oTLn?=
 =?us-ascii?Q?yLA8VUHIngz1HM+TDhEM7yv1tcgpa+lxgKHLNxTh0O4WcbyoZ4MpYabC4t9W?=
 =?us-ascii?Q?e/XLuqy1tNSMWD9U3IAHORiwBLq2ygdOGcvFp9J2CZZjE6S33c8F8VXWbCIQ?=
 =?us-ascii?Q?xzig7ObyCrsT8vqL56OO0gUALjam0IDE4HJR1ABJq6FP8IS5LOLsUPipVW/T?=
 =?us-ascii?Q?sL9aFlVi1SBsW3/b7rWMnvsjlS+AnWwu3rKZTDbJQmObMA+EwrCosp9u8KrF?=
 =?us-ascii?Q?oiSFzLuGKjGq/W3gFbWGkHWM7PZnVz9RGPqH7q/wVMPfRSsrR7wgeHg2R1zb?=
 =?us-ascii?Q?RtuCobFyCOqw16eOro1m6EnAMkmVEpuMD7kkqLqPqTCW19sIlXkYSVnmAmNB?=
 =?us-ascii?Q?J5jIyR9+LeEpg5HRFL1m5LbAi4MpXqOdlWW0N1VnV+2f9/U8JfgOxn1O1DSQ?=
 =?us-ascii?Q?OuGo6HVWXv13p/gO/8aPnTiMhXl7/VBe6GtqATAzo2+rnTosDrPZec6+cM9F?=
 =?us-ascii?Q?oAbKlXXsxwMLKgEFSQNEVJUhw0rX2wIkamP//cJsDK/i6A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?34DZ3U+CqvPiEd7w+mzxOOrQfr+zBTVyB3G+tH8YESIeN0nZkqh9Og3sONGI?=
 =?us-ascii?Q?kizL5vBxFI47HECqDnnzfq/zQlHt3FjPDnUlJJP3yPVF8i2Gx7A7xymPqWTh?=
 =?us-ascii?Q?eyJIhxDsq8mfU8JL0K2UzMEhivBd3wC/bTJWsrYto+OZHl0+eW7/QtOzfmj+?=
 =?us-ascii?Q?IVgBV5YEDCXWG47a1q2K5XxtZzd8LwtZlyT456MYQTnRDUF3u8pmTcnaJBqI?=
 =?us-ascii?Q?KpOUwTjVXVk6V+gRA5vXn0M+DrQLKMyv9zEzocFlGLKGUEJ4UAANqlGJ7sz9?=
 =?us-ascii?Q?Oa4fmaDuibUwoYrE/n5PEvy1/2dN7Uuv4AcT8n6uKX1U4LKrjtwH5e1AYOl5?=
 =?us-ascii?Q?nfBlVDkbEF0q3cwfu38oLgJfxS6xLj6jpQRxs9yI3mjGonZPk+Y26naJKQ4G?=
 =?us-ascii?Q?T2LMP5iOdKsogVyiEGQb+NR753UVAvKVxNSsw636L+M5oCTBQJcIo0aBi4N3?=
 =?us-ascii?Q?u/0TJtlSH2TlecZu4LziyfTur13nROBKQdx1apuD9FGmP1MzZmdeP//QD+1w?=
 =?us-ascii?Q?LvtXB2WrIqyYMAA8+OC3ksUiA3SvPs53CMp8jre0wSRfmDL8ZAqXAf9WBHn6?=
 =?us-ascii?Q?3FimAPFtRCaa6MUEPU9Bcl3vZv9qJsh7YlEg+ipa152kmbovAUf5TkHTfy8q?=
 =?us-ascii?Q?ybQYGv1aGzaxZ7ok8wRgZ0tyMk/NDv10QVfzpWxqbsMBOqIAnDO6qJ7PI8iM?=
 =?us-ascii?Q?+2kxGQRn7m04q3jweoB6wL9EFY25UyDtVLrb0rSkDpy0tJasXEHOSd6sUM79?=
 =?us-ascii?Q?iplHXOCQRxXzk12Hw1LxR+ycgl0GHrp0oNTUbVtOXWMGns8pdy5NOs09VRm+?=
 =?us-ascii?Q?7RZkcx8gLJ8hzaTQZPRY0pn0puHOgs1ZkT9BZgNo2oDnYFPjWvOvDMnuONvj?=
 =?us-ascii?Q?Hx/m883sRo9XQfPWB4485/JbZDc3yaKZx7K7RRMS0TDxCkZMWe7rgvU+jGkb?=
 =?us-ascii?Q?Sl7YNPNmW5j4I9fTN6Pa1duYVxcTEynZqL1/3oA0izswroaiyNFjQEIJ2k8w?=
 =?us-ascii?Q?Tc5yaHJRrEjdqv8+IDQ4g1LHSGEj8KoZesmhLUOFW/plkQlNhUzPT5L2Vkev?=
 =?us-ascii?Q?dSYiNr1BF1k3RzzkpF77OEWPrHaPjvpUIFNfI4p10uU9MMldX/1jM0f507xt?=
 =?us-ascii?Q?lTSz5hWwmTouNcYq8OvCbpW02tGUF4y4qJEkrVau9aaL2+nA0h0kMaXaU13L?=
 =?us-ascii?Q?F7lJcwTxWQODxYD//fC8u2cOXTjRK/7w/vqrFbliBM149JjBXTtIyGuO3JRi?=
 =?us-ascii?Q?dToqnAjZjWsuLxij0VkSyInzK2h9IwT57/ZoDRDNs5qCQcaJlsaKLrkW9Gr5?=
 =?us-ascii?Q?k/plpGH4Dyf0mida39sCXnmXV7QtIOGE3hiVC994iIC7BwpJxWuG3c+ialze?=
 =?us-ascii?Q?/KhmIlhaldb2Hre2hgFYC4caNcSVT6DNhzYTQY5UAkpFySu4qNfLGIFU72GN?=
 =?us-ascii?Q?ZEmlGZI9psLT1yG4oU6PwOwxjETK4eweFbFxyVmybLFCJLnmLRDOuo/QovCR?=
 =?us-ascii?Q?5bqIcbc+vSkyUbr8WYz4ZD57lkfFy051QZ0dh52s39sP3v1IC6Y+Ga9kPNrZ?=
 =?us-ascii?Q?zT7LVwSxvZXD92XaqIg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f37706c-cc57-4891-fd3c-08dc85444ab8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 09:45:53.7433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XVJO3wNeeW2O2pM1paaek1LRSLmcXmJpzSodu7Pl5HNwWccHmeTejTf+tFgm934a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9106
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Wednesday, June 5, 2024 5:32 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>
> Subject: [PATCH] drm/amdgpu: move some aca/mca init functions into ras_in=
it()
> stage
>
> adjust the function position to better match aca/mca fini code in ras_fin=
i().
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 28 ++++++++++++++-----------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 8dbfdb767f94..3258feb753ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3428,6 +3428,13 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>               goto release_con;
>       }
>
> +     if (amdgpu_aca_is_enabled(adev))
> +             r =3D amdgpu_aca_init(adev);
> +     else
> +             r =3D amdgpu_mca_init(adev);
> +     if (r)
> +             goto release_con;
> +
>       dev_info(adev->dev, "RAS INFO: ras initialized successfully, "
>                "hardware ability[%x] ras_mask[%x]\n",
>                adev->ras_hw_enabled, adev->ras_enabled); @@ -3636,25
> +3643,22 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
>
>       amdgpu_ras_event_mgr_init(adev);
>
> -     if (amdgpu_aca_is_enabled(adev)) {
> -             if (!amdgpu_in_reset(adev)) {
> -                     r =3D amdgpu_aca_init(adev);
> +     if (amdgpu_in_reset(adev)) {
> +             if (!amdgpu_aca_is_enabled(adev)) {
> +                     r =3D amdgpu_mca_reset(adev);
>                       if (r)
>                               return r;
>               }
> +     }
>
> -             if (!amdgpu_sriov_vf(adev))
> -                     amdgpu_ras_set_aca_debug_mode(adev, false);
> -     } else {
> -             if (amdgpu_in_reset(adev))
> -                     r =3D amdgpu_mca_reset(adev);
> +     if (!amdgpu_sriov_vf(adev)) {
> +             if (amdgpu_aca_is_enabled(adev))
> +                     r =3D amdgpu_ras_set_aca_debug_mode(adev, false);
>               else
> -                     r =3D amdgpu_mca_init(adev);
> +                     r =3D amdgpu_ras_set_mca_debug_mode(adev, false);
> +
>               if (r)
>                       return r;
> -
> -             if (!amdgpu_sriov_vf(adev))
> -                     amdgpu_ras_set_mca_debug_mode(adev, false);
>       }
>
>       /* Guest side doesn't need init ras feature */
> --
> 2.34.1

