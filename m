Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7918C369D5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 12:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DBA710E4D4;
	Mon, 28 Apr 2025 12:54:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P42V3y6B";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04BBB10E4D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 12:54:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahA8zj/7Oh+OHAh9yP+HE1UCHX88xkH7kncsVIVAn5/iZBJzoFTTQRUuR+VtXA51E+Kl2lj1/V5vFXC4GaEN96yj86r2uZuN/1d+DZY5GZs3jvDC1al91/wOXIwobV5l6KXw8JBnAKvpFhOoyQ5zI2N3ACc7ZYmyYVUWC0daZiYEM6IF41E3aZPYj5u/HFZtXBEZ0cLbmVXUIQmnvtXB9edM6HY9G99H07xGL5wekKGD144bQsxNPkz9K7GdYR3E9iMj3xBdGSII/FciPQ9gtmdxX/jgn3q/J79WfbT1n21LCEoEPeKzdigKOQC5wnbi5/k79IdyiDZAVdkBNsc0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTWDLdSOA5WzTBuZuNu23wRyLyctjxkMeKxE4jS8DJ0=;
 b=hNGOmCkGPlAa2BF87Yb6soh/T5hsY3KFqHD3p6iri6yxLHbqBrli1feH3Ixm4hRIKubhtp0n8xXxfbUOHKxiqx66n0myhoRdL1dEKAKdQlGojWdcMWy6P2lznQ9kplVviUPHt162PxzFtcF6OglCCQjLtGI0WVzEB7ck91edgGqSlN6120rFDbd5KfdNr+npCKHw1K8MeUs2mARdqoIJfbc37vuYPLRHQqOiXOZ9hWhmLPBE4GPZh08u1/TZfYj2wmkxzu2vZBM3mmrzlT7mD1El84fKiyDkyGOVs+IMsyg5QJfTMh84XfMATZDX+hV54m+q0DLMXWByQsB7zpIAIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTWDLdSOA5WzTBuZuNu23wRyLyctjxkMeKxE4jS8DJ0=;
 b=P42V3y6B/Aj0wwhq95JwxeKfpVRp7w6A0wtIEVa+Q0ryQKkf/qoo3+3oxQ3MBnL0+j7vPExIMaT3rvhJgWWIYr7oS5cRRYBBlbNr6SdlXQBBbpOIVIqsUImoHb0uZPRtcGhR5wKDiW2+8YuzlrODdt97nEbJlSbmCp90Yd0auoM=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.29; Mon, 28 Apr 2025 12:54:42 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 12:54:42 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 4/8] drm/amdgpu/mes11: add support for setting gang submit
Thread-Topic: [PATCH 4/8] drm/amdgpu/mes11: add support for setting gang submit
Thread-Index: AQHbthG5H0koO1bavESdgVVkIYMQzLO5DNdQ
Date: Mon, 28 Apr 2025 12:54:42 +0000
Message-ID: <DS7PR12MB6005435D0134A79E69DED7EAFB812@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250425184125.166270-1-alexander.deucher@amd.com>
 <20250425184125.166270-4-alexander.deucher@amd.com>
In-Reply-To: <20250425184125.166270-4-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=175608ad-d04a-4c94-a81b-a241edc403f9;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-28T12:53:14Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|IA1PR12MB8309:EE_
x-ms-office365-filtering-correlation-id: 8d16e05b-39b4-4bcc-4a7c-08dd8653d83c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?5k+ogrV2fEHGpD3BKr0zBsyVYBQLbZ+nKhOyi+jnNjxgFQx2UlC+BKYKF5Im?=
 =?us-ascii?Q?aHPpBXpiLZUlER8kHX1dQ4f3LYauw1KipyQ6kLZGE6M2CISohNQXfB7aid0X?=
 =?us-ascii?Q?ua5GQGOKSNCypJjsOhsSE1x843Cm2C3JOpTjT9KTCvhtIrFSiq5GOlkdYqfd?=
 =?us-ascii?Q?M+wNQrTRRoOgTzsa0q9UgMTPj4GIHx6+vFqJ976Olmic5+zpUpZnJuPSeFYU?=
 =?us-ascii?Q?hsHsvD0RJDu4sW8YQ5Rj2cDmKuAQZE0ZKhilJPYtKhCKGaCE+2skuNdV886s?=
 =?us-ascii?Q?fD0zlVWYlDrtSbBQIElm74JdjWVch4HuS8N97MBZXIg/Bc9S9L0byfK31HzJ?=
 =?us-ascii?Q?2sZ/PjYjbCzhSDwYUXhj28vRPsGPJcRHBEADSrHjk3DgFM1ev6vZ0kV8awUH?=
 =?us-ascii?Q?OxZ2AxzcH+uUagwwHsufj0D5Dwel29YHJap9rKJppMyilMPQgmE6RFRet8eb?=
 =?us-ascii?Q?L2YPZErogM4cgY5UszBrLvf5R2GAvUwpFAII4FzftoXlj0VcnV8/y9vlu3bB?=
 =?us-ascii?Q?4JzTiVu0XXbLP2JsDSEHiGFsBUvT0WGWeAWB4hGz6vs8VStWY0tEOMJhmta9?=
 =?us-ascii?Q?AeSVH/vMGUXomLQOZdEZ8mMDYUN+xnx/tZcsoPvEuwrQmyhoT1BpV9uIKTGI?=
 =?us-ascii?Q?RG7a2tJGruq+iyw11/U+IOcCx8HK1U3lpC9arP7HC8JGkKSMBLH6U8SOVlk7?=
 =?us-ascii?Q?VIErPIv9wuEMVhvb0GhKFqg4eypuVV+V/laB1xB3JWuPoQRZeHXkM4Y2a7qD?=
 =?us-ascii?Q?5UiZRood39skWPCOndMePts5P0+lF4YxHVsa+NaDNYvHsihwAAAtlMKOvWFx?=
 =?us-ascii?Q?ygb3cDRzYhY1EcRK46AIQm659403EqhtqcXSxAe+bKcDX3OM5JVg2cA2IDmS?=
 =?us-ascii?Q?Ob6/vM2zv/WXMjWuMd+M9QV6YJ1+lBH7Yqbzr+cLrggKEvl4O7Gry+DV/Kz1?=
 =?us-ascii?Q?x+NK+iepc2TudmeHzGbt08edyqLaMTdk5IDyInW1m7USYTWXLhpevaSGpZAE?=
 =?us-ascii?Q?R4Qa0homNaqlJDo4KymA+fzPvG2k6dwfBgWu2Y2tWmcpcnbBFBkE39pOsG8p?=
 =?us-ascii?Q?1gT39bsbovQLnia4qSwXkcCxRwYQqXHqIMX/ZznK7mxKZplZaCfhfpXpXCyJ?=
 =?us-ascii?Q?sJ/wY/etZtFihxA++Jh1d67vjCClSoocYnC7Le20eFZx0to6MnRfzcvS1EWI?=
 =?us-ascii?Q?N15hhfpBfuDEaizSwEsonfKp+qqxi29NM/ju/VpnFDy85oNn2hdWjtFfR1Wn?=
 =?us-ascii?Q?KLaJVP+zC7smKn8HMJPgz/BWh1/5/xaFk9dRHDbbwjyoRTuLWbLAmMqOf/et?=
 =?us-ascii?Q?Dp/fH8oOZn+ZOk2wE+nOvzLYqDoOh/rwd9Dan4QdZVD6OWTedJMJmesGefsu?=
 =?us-ascii?Q?lspM0mXYLiO4NbHQAZBJi+sLr7hf/La5DknXoa0RhoTcbca44NNbmiHgDnkb?=
 =?us-ascii?Q?zycWHz17sclsUcOD7o4p1xp59AxVTlL0VoK1qq7DZvM7e85NjKcySgNgPuVa?=
 =?us-ascii?Q?NxhboYm0R3ifQPc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xd2zejM3M45MyR1bB8ole7eqBlKHtDo/3KUlCS2Zs/dc1X3bJD8IT48rxknV?=
 =?us-ascii?Q?i0frj8pwqnag0zegQPG2pFyZ4RaznvN0cQ2bjSAdfkwnbyW9dXRiD0JvwLZ0?=
 =?us-ascii?Q?eOxg6bO+3KgDDzqT7PdNuJmS7b76oyoShxKyoOe4aefGgjdPC3Tnm3BswX+h?=
 =?us-ascii?Q?u+JMO9izwpdf4/Rs309ECm/EsW11wPik+ftbxcqbE358lyvTaFfooMQwk3f1?=
 =?us-ascii?Q?nRv2tdOoP81o2nQWZq61ZFAZ3VSYz4pjE8C2tW3wNmCxMBOFEuPoGpJmfYfh?=
 =?us-ascii?Q?IqNSrKEjMDF4tyiAMgN1S4WuDYOA84s/kBS8/2pD8m+zTBXIufcG9I4LLFZ7?=
 =?us-ascii?Q?WGuN/mdZHQjAbRJmeS8YEQNcMDpk9O1FIyAmTuf691Dkn7597z8B26VUPGr+?=
 =?us-ascii?Q?wTJCnacj5YAb3V4gMECttwmMW7v/fXMjbVWlQ7VOdH1+fWKzZ4AdUlXpmMZc?=
 =?us-ascii?Q?dnZ6NxMS2OuOuBYqXxY0uVUorCnh7oEOQliTny1lS6UqiWKN+5/A+R1wxuTZ?=
 =?us-ascii?Q?tkrQSnL7daE50K+d5EgrR03VEZosSw5UyAXqzEmZQNMTjrRXKzAjXi3a57FP?=
 =?us-ascii?Q?+DfkTn47fS5QHYIVWhGjANFWuafRHAYMncXKo2Md72cIz0H0xzq4Cwp3sC4z?=
 =?us-ascii?Q?RTocIPGfZw2Ebv/dhRAKgDAR8exOkEovKp7YXeqIPqfPis57fUGOYCXnwM34?=
 =?us-ascii?Q?SLgMhFrVBDv1hoB0hdQQQ4/4Mb6clNorb7SZLVuwRmM2jTftVhd0ym5IVppZ?=
 =?us-ascii?Q?SJ9yx0ejFN5Bteo/azm6Dfn92tD5ktHCnouYO4gyHtg2jnaaUfWP0P0JiFRU?=
 =?us-ascii?Q?TLMPPubdP5ppPVD5haQqVh8Ai6U2v/LBbZdBlMLcg0w3J7H4zGKLVmINSbBc?=
 =?us-ascii?Q?9O/EwKG0MRKQOj+AggMuopqOW3r5EbLaC+Oaa6x4yJtjd9HrAr0HIgsFIDuK?=
 =?us-ascii?Q?LjlZIlYVtEW5ySX9UlZbLwi3Q4fs2tAhOY89rzKeiYaRXBUmtVD7qYvmNtAU?=
 =?us-ascii?Q?Vphe1vZmq9+f1qwC3vloy4xip788h0Z9RMlbraWjEZzvzqCTNLviJkLecSpj?=
 =?us-ascii?Q?y/MjIT1hpzusbkCcB5S8L+V49lACmjlWS6W3ssP1fJnqIyKi+U6ta9CsGY8V?=
 =?us-ascii?Q?u0RBu+iqaUeB2Blsz+++82SAOwUaachF4Tfds8DZilXm2c4lLnkdrRaaOc92?=
 =?us-ascii?Q?3RC4Sjn4dZTz7xP9eYf9Fc7j2sazCVBsShYKL+2S9sD/FBibQ41j4rsOFTjC?=
 =?us-ascii?Q?kaw/tRx9anyDNbNU3HThpv2wfRGil1F1qhW0cfoEISdhPKTnjyoejQkPeT8D?=
 =?us-ascii?Q?aUS0JgDdcfuo50O49lNVzf4ENh7fBdo/dOyZ8AXvxwZJwoDL0e8qtqxn1tku?=
 =?us-ascii?Q?JbyZwNXjqiz/5aWekikc843Sm6ftyGpsoMldAf9FE5GKvfJwjf0c2pstrUrr?=
 =?us-ascii?Q?f1YegabAFWlkA+uMxkU7rJPdZ7fOzMThFl301wy17i39OqdcAyMCiuXBtq6W?=
 =?us-ascii?Q?lsShtReb+rrdd18Wgn4w2d2ehhUTm0hbc8uNkbGcm9mF242jvbnhpTSfeVWm?=
 =?us-ascii?Q?Q4j6P2IO3UbmsZpWjic=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d16e05b-39b4-4bcc-4a7c-08dd8653d83c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 12:54:42.4086 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c6xG1+AVHC4cOwkx/uY71zjgM/XirRRjWkZIgpy3WnY8NS+mz+DWmlSAcIzQMk3S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309
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

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Saturday, April 26, 2025 2:41 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 4/8] drm/amdgpu/mes11: add support for setting gang submi=
t
>
> Enable a primary and secondary queue that schedule together.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 8a31bd81bcb9d..df4aa6ad6a29e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -783,6 +783,27 @@ static int mes_v11_0_reset_hw_queue(struct
> amdgpu_mes *mes,
>                       offsetof(union MESAPI__RESET, api_status));  }
>
> +static int mes_v11_0_set_gang_submit(struct amdgpu_mes *mes,
> +                                  struct mes_set_gang_submit_input *inpu=
t) {
> +     union MESAPI__SET_GANG_SUBMIT mes_gang_submit_pkt;
> +
> +     memset(&mes_gang_submit_pkt, 0, sizeof(mes_gang_submit_pkt));
> +
> +     mes_gang_submit_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> +     mes_gang_submit_pkt.header.opcode =3D
> MES_SCH_API_SET_GANG_SUBMIT;
> +     mes_gang_submit_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> +
> +     mes_gang_submit_pkt.set_gang_submit.gang_context_addr =3D
> +             input->primary_gang_context_addr;
> +     mes_gang_submit_pkt.set_gang_submit.slave_gang_context_addr =3D
> +             input->secondary_gang_context_addr;
> +
> +     return mes_v11_0_submit_pkt_and_poll_completion(mes,
> +                     &mes_gang_submit_pkt, sizeof(mes_gang_submit_pkt),
> +                     offsetof(union MESAPI__RESET, api_status)); }
> +
Please use the MESAPI__SET_GANG_SUBMIT type to get the API status.
With that fix, the patch is Reviewed-by: Prike Liang <Prike.Liang@amd.com>

>  static const struct amdgpu_mes_funcs mes_v11_0_funcs =3D {
>       .add_hw_queue =3D mes_v11_0_add_hw_queue,
>       .remove_hw_queue =3D mes_v11_0_remove_hw_queue, @@ -792,6 +813,7
> @@ static const struct amdgpu_mes_funcs mes_v11_0_funcs =3D {
>       .resume_gang =3D mes_v11_0_resume_gang,
>       .misc_op =3D mes_v11_0_misc_op,
>       .reset_hw_queue =3D mes_v11_0_reset_hw_queue,
> +     .set_gang_submit =3D mes_v11_0_set_gang_submit,
>  };
>
>  static int mes_v11_0_allocate_ucode_buffer(struct amdgpu_device *adev,
> --
> 2.49.0

