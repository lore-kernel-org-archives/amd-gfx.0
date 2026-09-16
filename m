Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A8DC88E77
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 09:31:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5DBA10E803;
	Wed, 16 Sep 2026 09:31:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sa5GlA2K";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32B5A10E803
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 09:31:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBsvuSa9DIXIqx/CJrrJOIQ7bgolGFPQlk6nzr5U6kT0pDgJiR7p1OtraIrUEHz9gjTaKEiczKlutSQ5w3TtT94RcX67Uowc97DSWKin571PwGAiXrmUWvpwEtimSmNNMmL+zcoT7UWqX5UpCMEAbyPyfOybrKiTXFcnqF+PDtaOqecY3QMtecyx4YvOurlqsd3uRtVKqmzknU4Qk3BoIlLGWkQXHRhi7HHMd/0UdBxdX+EpQTtcr2zKU3v5q32BgaIbtRqUqsZjINYchjD7TcjV79pGITKA556BVJ8HczLRnoPaELtDrY23XIPNdu2X+LHiJPb+BgPEDm9RDnY7ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIA9cTBkDpW/DLX8HIsjJCzh1sON5F3HxFLY4c5VGzE=;
 b=CzchCax9nFVw3J/QK3AyOy8woqJjMmK/oRcgfj73RFhq751WKWV8Ipn8R7LfNHnrAC+2T52zncMVUvHWaKlVVjai+NjEXAGRx3ZA1vq1FWr/LubV7UbFHvTFEUvdhi+froehu/A2iRYrrCjb1UqDaApp7It4ra+cgdoHyt8EIZDOkfE6RvlXU6aolA2aegKTfWH6FUG2epyj33gp3ffvoWZfOYsOf5nDl453cYZKtGUp4QYZ1CNBS3B4le6+eS1Yed3N7glcO335oWWZnmo2ZVw63RkfISLrJ6qIpfhEU/t+4K4bFCYZsUmVHKhQqPEzXBR+Z649kgqnBMvi9E60kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIA9cTBkDpW/DLX8HIsjJCzh1sON5F3HxFLY4c5VGzE=;
 b=sa5GlA2KLkcjSS7x3ubM4CPhLewf047tNsxHxBUdCK428YSQTO0SBswQ7sgnWT5Kh3uLFceenhdUejjeCH0edx1vKihsBHCiaCR7bYzITJ8iQ77jPCOBIpvy9H8hmxn0vjoXaUtWHbc1/EvHlgm4nBayIrj3y9tN9h2jnuGI1pc=
Received: from CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5)
 by CY5PR12MB6300.namprd12.prod.outlook.com (2603:10b6:930:f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 09:31:05 +0000
Received: from CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85]) by CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85%2]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 09:31:04 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip ras error reset in gpu reset only when
 uniras is enabled
Thread-Topic: [PATCH] drm/amdgpu: skip ras error reset in gpu reset only when
 uniras is enabled
Thread-Index: AQHdRbVIEFWwe29e+kStCcNm5BqunrbQ8L0Q
Date: Wed, 16 Sep 2026 09:31:03 +0000
Message-ID: <CYYPR12MB87292B57BDCECD29DA715A96B0B92@CYYPR12MB8729.namprd12.prod.outlook.com>
References: <20260916082741.112057-1-cesun102@amd.com>
In-Reply-To: <20260916082741.112057-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-16T09:30:57.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8729:EE_|CY5PR12MB6300:EE_
x-ms-office365-filtering-correlation-id: 901214a5-d18b-4137-980c-08df13d53a7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|38070700021|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: CWotXCJFSObs8tB0upvK0bITFE1+vyAF9G1o+C6jZSk1792O/dG9G5yQ+5HCXjgnxI2Malgvm1vC8FSVg95Xo96BFQWa5ekCKsN18ShsW+wcqzwn4P0bCJJLQUpGhujllMa+YZT4DhAGHPASnVqHvhfHZpsldwAtpCpKlPwfvhnfgV0QFXuwpPg30fzM+YavEZggtcUOKfu+9H2mN5GVb0PEHB1MJCFzACHc5UA3HzXNgU+93DKNNAxeNFycQOMKGJ2yEQK6sgiiEp9VaPHVAF3Du+wimvoUQ9qxAA8OWT0DArWTKRb1Y5fL5W7larHPQEmilWpZT6nr/8vXgPaZo/jKgqmUOOe+2D4wzBEjyqctY/aX3EEzRdB9MUWpP7i9t9x/Q/Sru2hhcDQqn9qIrlqf5pWktderJUdCtIxCHV8jZo9dfrJU4/LeElLjjs9BwtWu1AVulQSTYtZlEo/xD4cFGOffuxCZjSTmWuYLHmFKkMwLBW7zDKrBoGEqM2xkyT8mxw9Wl5lybWzxB1Q6JHVBEKuRxtoXtIYPWM1zXSPyB2f5kQIYn8gb/6+NicQZVBKc6BxBWLGb9D0zJGzxC21HGkCQ4ahY1UexllgNBqqMuEgTJV04Xok4jVt3WuxSBVwpIWW06PZbc8HW4oEOTddFuxDNBYAz+Pf7TMuEc9AcTIZNZw58e52KVqoWMJmdrwPwtt2nx71/gGaNBAOwP782fDsk+6FbPhs3z7e+/f0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8729.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(38070700021)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IlYNIIF+qWEHTw9Hu+QvV2DoWWot0jPFJXZsg56bH4eUTRjIQgp0ofq8pNEO?=
 =?us-ascii?Q?Mmeruw47DFNZGUvbBRr61ZaOdXJnqoNwlRdVWG6yZ+PWlSHT1OMVqpbD3APF?=
 =?us-ascii?Q?iDy+sEJe+MbyswcxjemtOA7vazhsha1FLGJ5nZesaLE4F3kSTDvprkRxCrSn?=
 =?us-ascii?Q?PBUV7Bjf7XqMxoABDEJ4Vz6WsSnfQ9Zl9HNBOMw9OZRhgXLC7/X+4LDsuUme?=
 =?us-ascii?Q?ZYrd59oQN9Lxoyyzba6bjdLlJE2P0+C0s8wEWNpz14AwDCySjHO6vXV98ITN?=
 =?us-ascii?Q?8822q1eRz1s44jwjxds0cFKIKrnVm1VEodFKL3oPFtKUjJNWxLTzN4VvHMhU?=
 =?us-ascii?Q?D0QfYgIyKMDzae/gzAzVoZSgWl5DbzZ1rDKO/NUtn2iDA2i6500p5O6pwR1a?=
 =?us-ascii?Q?qnJ+RQn1vXB7pbecoCKO1MeAfdMW8OxKJ7LMD3zdZazvycPbWF5VFjadEqLX?=
 =?us-ascii?Q?asYBFBxDOtYjiTFMLNuo0dzENaoIsOdg2vzi0CznqP9kaEEvIrEa4IsdMYmq?=
 =?us-ascii?Q?/DCJVWgdWdp+fRqiMjvT0yZscE0tm81QLSv0exRRFFHdlPmxluzz1VXTlfp5?=
 =?us-ascii?Q?8JmrdN0IG6kQCLQs/K3VfEX/kvR4r4mz2bC5ozV0pr33PmHaC7c69Gc82H9Y?=
 =?us-ascii?Q?o5ILFGTYbmdh+a2XjhZ0hOe57+D+s3MCx5U5tl2SjlPN4XnF9imuF/MWYn/1?=
 =?us-ascii?Q?C+OFleTR3deHAOHb6Ms1dgECBW5egOv3bS2MJAnAZrRaQ6sfOWEaNj/lSjxq?=
 =?us-ascii?Q?YMY9iK2nbTNVYIl741uWghG0T5tBpr2UPtbvTUxCHd1dLwuo5K1KqWk6+3c7?=
 =?us-ascii?Q?+5itEDGszwwsX9RgrrN3Q/GjqA9vPR5LL7Au9Th5Dwd296Zt2ubkCI46el9M?=
 =?us-ascii?Q?8NDH896FkdKMkENdySOtgtP6uXO5TLZsdPYStn3OjtpBAcpFdrJpqPbb0NOk?=
 =?us-ascii?Q?WBlr6eU6V0YGXz9xmwUt1pELtG6+RAuZazQC73xHjltlN+5PNdwSgbqvqcqk?=
 =?us-ascii?Q?H/fVJ+bInz8CulETGg45NtGN7n5jjen3XRS60RUWkwBzoZULoA7wkbqhJ+WY?=
 =?us-ascii?Q?eYN8By1Pz6vaGVIbVEa4h/UNNToZdCCJR9s33YOMKCRZL0ZO8/UIdMcgp4lk?=
 =?us-ascii?Q?NLePIwf30wdGHYTf5MjcQYWXYxM4SuPMeBeEyLSiuoQkOxlg1g0uJ5vGo16b?=
 =?us-ascii?Q?TBMIwc9BFyyhGiIu2aPFokwoGRV864jPnRWzSllPFQicOjRNNiMKSqpAFoqC?=
 =?us-ascii?Q?3T2/CEjH8uiNtH2ED7AMS7q4s7tyHwrjgQuU0IPlpZZxYCcmLK7xpiXPsWmF?=
 =?us-ascii?Q?dEs7oY68xm3nR/sPF0LNPONsRnhr662scPlwxQP4gZar9BNMgiCsX0JTm+j5?=
 =?us-ascii?Q?IA9RiYrgOAUIWAUSRBBWbz4PaxlqEIJVfDDt3k4WR0UK5o3Yv9uP8BYjMrEA?=
 =?us-ascii?Q?FJWmE1ZBxwzUCu3/nUY2s8FzXwGC5ODxaA8/zJbowzIaFZIuY51+hTfhD5h2?=
 =?us-ascii?Q?Djbll0PAfCUQG+YuAlY5VSibDSzBMb/f7zT5ZM+fhh05dA43zk8Y3ioJhFp8?=
 =?us-ascii?Q?1tD2s/dGmaMrClNCn/epBYSe+cgEOvCb2kI8y44708m8MA/MLEl53bhvG2Tm?=
 =?us-ascii?Q?HzK56DHW0CBbew0kNcRWRsPrypG8+Ol18ixu7xsILo3QagvGtFAE1GUX5te7?=
 =?us-ascii?Q?Atg4IjMhcu89PGK+sT+T/3W9gbehXbHzStNIZAhZNlcLOS54?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8729.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901214a5-d18b-4137-980c-08df13d53a7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 09:31:03.9665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0owEFJj2dpyhrbivR/zgKdAFtUH0bP9iXg8+NhUGQjszBr/rG+PeSb2V112jCulo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300
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

AMD General

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Sent: Wednesday, September 16, 2026 4:28 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Subject: [PATCH] drm/amdgpu: skip ras error reset in gpu reset only when =
uniras is
> enabled
>
> Original logic skips RAS error reset whenever GPU reset/RAS recovery.
> Add amdgpu_uniras_enabled() check: skip reset only for uniras enabled; no=
n-uniras
> ASICs still run RAS error reset during GPU reset.
>
> Commit "drm/amdgpu: retire MCA support" caused old ASICs UE test failure:
> multiple CE/UE events across blocks. Legacy RAS relied on set_debug_mode =
to
> decide skip RAS reset, while set_debug_mode is now only for uniras.
> Use amdgpu_uniras_enabled() instead for this condition.
>
> Fixes: b5b6231598dd ("drm/amdgpu: retire MCA support")
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 6b2b8acdbf9b..c65916d84683 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1513,7 +1513,8 @@ int amdgpu_ras_reset_error_count(struct amdgpu_devi=
ce
> *adev,
>               return -EOPNOTSUPP;
>
>       /* skip ras error reset in gpu reset */
> -     if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev))
> +     if ((amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) &&
> +          amdgpu_uniras_enabled(adev))
>               return -EOPNOTSUPP;
>
>       if (block_obj->hw_ops->reset_ras_error_count)
> --
> 2.34.1

