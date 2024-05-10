Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC20C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 06:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3764010E152;
	Fri, 10 May 2024 06:52:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OQEkfZnE";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 244DE10E152
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 06:52:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRkR7o1NJWSPbeKCKNFkucAVzeq20LmLC1ezlH+HZVRxk2ujvL05m5voH9TKPEJkA9SCqKi+9jW2gzcfn93S3Ha6dgv23SRUAgLdS2cjKnHcRVhO5WqxV9wh5IXZ3Fs6z5Tmg0VowLKKlVdV93kkzC9ksTac2AgcwHaJB+8F9/Oq6GpXs/Yj5tkbvllNmojIZpQSWHbiQFdEnWbrktVJjArzERjnNEmWcug/rGz9nhgD2Qec/ubTRJq8y1y1xeWefRtmiywnHnm/Ef0AtCCf3rOBEgCZa+e5W3zE83yq/faIJ4Hy42P+Qx4SptIf9JtfkvDPUeyBqCza8VMnUNE5BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYWg9EX+3UyyEvyWd340Bjkwg4QbNfpmx9mzLcmH0oE=;
 b=Q5ntsKovO+JUSsJg1rCuBZWFg/XclaIdQ04jIyYIPbPcVimrA1vo1R5NAZmA6qBvkvWxZOyIHTJMiPlcug6cHXJZi80S3p5wHkLfSHU9PENTPsJdS9iaJY9ML2rt9oKFDBodOMTKVTEe4UjZvNemHzHWSy6eCWGANgPmUjxzLZs2ulvr0UsLPzUN3/8UaT8G2GTHCtLVErMsAFXuswL64XyYy0Nm1SZ0FOaYvI31sD3Ytz70kaw447AzCRwbNy2rGCo1i0GTb3LJPWYNnH0GL8aiiOhA+bzBbPjSDwN5/uvPYjhSNMohlXmY/Yj9h3GI99a5yy9cDPG2iJU6nOJSVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYWg9EX+3UyyEvyWd340Bjkwg4QbNfpmx9mzLcmH0oE=;
 b=OQEkfZnEUYnMQrSQDGYTUXhQW5AQYlUWrkrd06ClvOvwQqeP/i+ecx+qn+WtOyibRU1ZK8cgg4Bo1IXlMybeDs11BKETpDka9bwkksKrl6EWMFxFpP6A+h+ipzGMQENAgppWFx2oeaYiVmE8bA2FCeGcwUzTZEYXSXcQSw7J8QQ=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by CY5PR12MB6324.namprd12.prod.outlook.com (2603:10b6:930:f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 06:52:44 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 06:52:43 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 22/22] drm/amdgpu: clear the warning unsigned compared
 against 0 for xcp_id
Thread-Topic: [PATCH 22/22] drm/amdgpu: clear the warning unsigned compared
 against 0 for xcp_id
Thread-Index: AQHaooVuu5arDHWxm0mwfig+zp+AurGP/F6w
Date: Fri, 10 May 2024 06:52:43 +0000
Message-ID: <CH3PR12MB8074AE962B2254FEC257FFC8F6E72@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-22-jesse.zhang@amd.com>
In-Reply-To: <20240510025038.3488381-22-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ffc19712-ebea-40bc-a2e7-e89bb6ed2754;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T06:10:07Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|CY5PR12MB6324:EE_
x-ms-office365-filtering-correlation-id: a6bf4b42-7a4a-40c2-0784-08dc70bdcb00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?tDg1AzS0GFRh7AlVOxxMDOOrDHTBF1y4dP+cG6T+IB9apSKQ/CUXVfEmm9?=
 =?iso-8859-1?Q?IQqxAthWN8TJbqtThj1N7biVIik2AlLq61rDnM9lr7/TQd799h69OByJXC?=
 =?iso-8859-1?Q?SsBlL6G0a2MfXrJhTFbtHBjrDokO3gqKHsV7gLslmdCtNTwvbPlZ++NnSw?=
 =?iso-8859-1?Q?Nv0ofx+PpTcVgEQu3ISlEXv5lfTEMrqj7prD41GKV7GsdF5h+mV8aiDUWT?=
 =?iso-8859-1?Q?c1DXNV2F1OTKwoh/bumVaByVi2jtrABS6UEagJq5a5z4PveGaryzSFBfsL?=
 =?iso-8859-1?Q?1Ktwj1hEDTusk4pQYFvcY8YCC8VMb6NDgt9+mfLgoDRbRmNPqr4lR8RTF3?=
 =?iso-8859-1?Q?rHfLcxJHB0ywR2FCvzA/m1vTYQ+WCxT0Yz5GAlj2EXXs67AbNFL6jW6TiH?=
 =?iso-8859-1?Q?Kd+HjfYG1/FClxfIVRNxnfmrTOsSM+MFbR4r/a+4N91i5H04C8zyD7jKZh?=
 =?iso-8859-1?Q?IkDK0Ms1f2gdxFQMACX1fmkR4qIM6pSb+QQ+zO9uqxOn6z4kuG/bsj50Mu?=
 =?iso-8859-1?Q?HNsjIskRTa77Jg6MAKXShcbZp24U2mP3+BtilXUNky3MTjYKo2VH053Ocv?=
 =?iso-8859-1?Q?SdE+jE378PpzrAxE+C6eagHXAyAq0bv97TyelZ9ktF6ku2lwt2w1bLIAQ6?=
 =?iso-8859-1?Q?eTTF5VgOf6e79Z0NE7VtN1WP140k9liJJQohoVvV6FLLyVZ5o5GorHTdwb?=
 =?iso-8859-1?Q?p7xAjdh4ISu+lzKlJLXxDIC05QxlqN74SwkxwtUWD9eA9dBcCzCbm6zDyW?=
 =?iso-8859-1?Q?BrNzvixgHy4Q/fxIXGKlrn0V8ngkKvh7dSE6fGrY+aoQwWs9CFcYrTfG5F?=
 =?iso-8859-1?Q?leXQR1FrmTcLR1EVRWtFyH1kp+t4DOEqaDloaiEASKVu4fP+ZapKkSg222?=
 =?iso-8859-1?Q?z7ayPEWsOe6VJApnGEEB/gbYV66/gykq6Oz2+1b2FamnnSDPmSRuIWnfqo?=
 =?iso-8859-1?Q?WxlggExKzNJwkBBD1tEqjXJ08Pc9olEZglLUFT3wltwkvE/NZw3Wv7zi+K?=
 =?iso-8859-1?Q?drDFrGTcJ6tPxRlOLosXpVpWQ8greygm0RsWLvJCbTwd4Y2F1cHogmpWWH?=
 =?iso-8859-1?Q?mH+5o4Ek3+EjNDdgVhfHraKFQ3INJzDwNa51BLksTRly4Bqwoj2vZiDYWz?=
 =?iso-8859-1?Q?b2nL5v/GQHD8VZ+EyMMGM548QP9JSLBaYD553sSJwG7gPY3FieOjciiKNx?=
 =?iso-8859-1?Q?XHf4mu79OMb8gnpgcYF2HwWx10xrzFuD5eZ8rZEyDvxAeEMbR+KgD5bfBL?=
 =?iso-8859-1?Q?wksSEFj2LTXtJ5pqsv9abDl5r0fxDvZMZ51mDL7ThIyh5avU5hDYjlPhZF?=
 =?iso-8859-1?Q?7INC7Ucfej/plaPi61W0Ge677BkaOLyVbyO9ni1Fw7fNRCVhdGY5elAeq8?=
 =?iso-8859-1?Q?TBXmIYUJE8YNoKQw+TVq5fVhZzWg8qUw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?D6dIKO5x+8jt+fYJzaFJymqW39AgPoYE+C+b1bxKuGuXNLLApxS2Bt45t3?=
 =?iso-8859-1?Q?UNhKdCRe6RAXVC2vW2I2X0csKyYHnq5tYGv4LEvDH6HOnMd8vbtIaOoNt0?=
 =?iso-8859-1?Q?DuuoxtkLDtea39x8+ABYpAya2MeIxHh7oQBhhZEIgYxE9Ev+zDYluIM+Ms?=
 =?iso-8859-1?Q?NAkSQ8Rhqcg4afDuLJ5OixIJLi8uUjK7X0bdxC5MLC+F1p/jKH7LmSK1eF?=
 =?iso-8859-1?Q?vpJPR2aZkDd6mxHu1N4fChrOt3znmM7Hn8xuloJ7QtBtFY5Ohi24JF95fy?=
 =?iso-8859-1?Q?XAAKVpdHOfMN4g8bGMVbYWO7aWsoGAPKKJksJVFuB6YB0Yl5FbODGFmxLt?=
 =?iso-8859-1?Q?v3dgTNWd5gP5TLwjrrhTUG3shBNY1DpLpxDtKKtrALl6jjLsjqVhHNs90J?=
 =?iso-8859-1?Q?fvSHgkqD+z928jBM1lor84jO0H9iI2BNcKbTpujhY+QyFmDGlGLe0NEo3U?=
 =?iso-8859-1?Q?gakzCLVFRA/L9SVYXcZuY6U2wNcuvO0wQ/kZQfFl/JB2RI/s4hyLUdPrhI?=
 =?iso-8859-1?Q?Oe57cCE1dwT9O7fhBnd7S+k0+gCqHSBLOAKV8bkzmSCcnOI+vus89X8XPf?=
 =?iso-8859-1?Q?KEasy81UmbUXRxxkOliPOIb5NteVr2LsLxtj1dC9TJEHxJrL6nP9Azhnov?=
 =?iso-8859-1?Q?S9RvHGjmQg+y2sn3jV2Ss/rYLQC8kXXEGD4JTgA27hj+tzB3REQL7pH8Fg?=
 =?iso-8859-1?Q?lTo7Xfo3CSNZoG4xdVGcj3tJFz5US3MRIc0BRGKnnwoD8hzwwpjM1NPvnT?=
 =?iso-8859-1?Q?1Awatcj/KTXSaS0bjz+zSOLnE7CRGHXSaB3WclylFDReztzRT2kYMvhVlq?=
 =?iso-8859-1?Q?xXIqG9aUw0ZcO1c0JzifwpHqVfSkjYrZL9fgRcaTELgFZtac6gto9mWYd4?=
 =?iso-8859-1?Q?x1AXq0fLEN34aNm3mDuYe+l+k3+MVhNegw7Th+f+vmpIsTy4Tt6dP0PUyv?=
 =?iso-8859-1?Q?AgsDB3qDXrVrHQCUo2WQyk2wjLzNiBQVqFAhO1xruXMj32tAftyAe8IXnl?=
 =?iso-8859-1?Q?vfZyklavvXkBBQHf8ykn86/Yh7xYyRRhmmmvFPojlqGfamw/wNVMPbDvhR?=
 =?iso-8859-1?Q?HGHYtJOx+mAeqduH4t19vWBvvS4JffdJ/VueYRhWJRpXD50smOIk3afo0U?=
 =?iso-8859-1?Q?cDNi+ucNe0bP1dyUDJbl/axUr3kskveEgGEiBMU5/gSBmmZgurpL6w0LeA?=
 =?iso-8859-1?Q?IZbODKdHcOUchJ+SAFHxaaJQVuiE/Kh9aPq1d4bZFFeXhMXhh/U+ndxT3s?=
 =?iso-8859-1?Q?RhWfqLh73yWf4b3SJWPB6FTSYCOwafhziOVv5GvO7VD3+h1Q9/vAjwrXO+?=
 =?iso-8859-1?Q?Qc2fQnrE2KBDBb9fm99xrYhbVH2u30oQO5wftf0EDLu1X8lveOUpQ3S8pt?=
 =?iso-8859-1?Q?l00DUCnFUyiceBqYFRS35DjhrGyJNfwLBbE1eP+9BISdSONvoP/lfLkoks?=
 =?iso-8859-1?Q?sRRzMv+nYLHvqYBy/bWXQOKMTDHHAnFC+340oiaVB3VQg2uj6S5w2kn19m?=
 =?iso-8859-1?Q?1ZRvnq9r47ej8amJrPJvuZRSQh44WIl9cUm2mKjRNv4DJGeHKo805E3KHJ?=
 =?iso-8859-1?Q?+8gevZ0YXUI+VYqNT7jmYcBAs2qBSwlVG0Ov85FxDw1t+DZfdAEkA9T6bI?=
 =?iso-8859-1?Q?8TnCWDc3V7lWFLjczzgUoEXYRiDwa4g/+n?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6bf4b42-7a4a-40c2-0784-08dc70bdcb00
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 06:52:43.6348 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XCWbUhdqN33SEdcysgnkkdqZ0tHD2P+AF4t4zkc4j0Gn+DrIoCp6lIZ0K/BQNZ0C9UPJX6Bq9QMzy3fzwkCWoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6324
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

This patch is,

Reviewed-by: Tim Huang <Tim.Huang@amd.com>



> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Friday, May 10, 2024 10:51 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 22/22] drm/amdgpu: clear the warning unsigned compared
> against 0 for xcp_id
>
> This greater-than-or-equal-to-zero comparison of an unsigned value is alw=
ays
> true. fpriv->xcp_id >=3D 0U
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 977cde6d1362..66782be5917b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -618,7 +618,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void
> *data, struct drm_file *filp)
>                       return -EINVAL;
>
>               if (adev->xcp_mgr && adev->xcp_mgr->num_xcps > 0 &&
> -                 fpriv->xcp_id >=3D 0 && fpriv->xcp_id <
> adev->xcp_mgr->num_xcps) {
> +                 fpriv->xcp_id < adev->xcp_mgr->num_xcps) {
>                       xcp =3D &adev->xcp_mgr->xcp[fpriv->xcp_id];
>                       switch (type) {
>                       case AMD_IP_BLOCK_TYPE_GFX:
> --
> 2.25.1

