Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB6FCDB470
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 07:59:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83C6110E9BA;
	Tue, 23 Jun 2026 07:59:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h07yepLO";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012010.outbound.protection.outlook.com
 [40.93.195.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE7DD10E9B6
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 07:59:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSmG5TGPkx51Yu5ysazXfbTC7hklYgDDb0h9cXNug5bzOilqGKn+xqsu2xcmQNWxNC78aADWm9NKzaWxY/Zdxr6gZYljJHMRmVzpffxSAEK6vog754OBnU2ZcwiDYMcUMStPfVoTYUEbNXeEEMU0QzlurSy5o8wCVKkre3fYMg+bYT2rPinIOHdjuQJgD+EcSYdXbWXTdH0ayniHFm4aLXb947L68uZJFo7W9S/p7LlzJizE7Fw9DTkpDrt6lNLPSbJhRLBhD8aJrljx9fCWBTZC1RHKmyxzTrYfKxVrg0WFDCJdDeXs4YkNS2rMfpy+bnnjFDiah6hW54oc+sQTjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u79yQNZEhdFAZ+9fmvbVSUvk4gxbK3fKsHNPmPkqEus=;
 b=QnHgHcS1Z0awkAzxt4qnIjMchjgR88Io1egb0N2l3wNhmfZX+Vw38uVTkQ/GHOmh/f/NpaGa6CWrlynhvtQP8hnoUjio8hij1LYYFat8DNYKYojZZrKX/32kFFisSyFOz/5JfENRhCR2UT4DaKCSV4FI0rdjtpNLcTD0S5EyNsUvjzN2tS5Zkhnk88qa8jUwcXe12Uk4/Rfis6/u/9su4iUQ2upI9nS6ugvrxF1gBwvsT8RZlR4ftWFPZWmlupnHu5JF4AX/r5FpwyZQM/y6LlGIUVZSd5FK3E0k7sQnDVFXoXMskiZ/qKXAUi74uIdd8ohdJjyOp87HgVL/FhixvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u79yQNZEhdFAZ+9fmvbVSUvk4gxbK3fKsHNPmPkqEus=;
 b=h07yepLOBxKA3HvtpnFCXc5smfw1AwmTvtJjjdmfmZNfGSxXNWZ+oHloEGgQ05r8hoau8YLqBuOW3N4JpaVSPdL2o+8bnzsLk0R60qUyTbE1rTO7tdLbz1yI5A0Hk5Dy0aNuV0MolbDE75UPFcjZTi1rzBPOCQ2bCM4fzQJtoaw=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SA1PR12MB7294.namprd12.prod.outlook.com (2603:10b6:806:2b8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 07:59:02 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 07:59:02 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Sun,
 Ce(Overlord)" <Ce.Sun@amd.com>
Subject: RE: [PATCH v1 2/2] drm/amdgpu: fix resource leak on ACP reset timeout
Thread-Topic: [PATCH v1 2/2] drm/amdgpu: fix resource leak on ACP reset timeout
Thread-Index: AQHdAuO7ZoQJ4s+uT02rMYfwfqkxLLZLxnyg
Date: Tue, 23 Jun 2026 07:59:02 +0000
Message-ID: <PH7PR12MB87964B7689BFC0C84CB3FCC8B0EE2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <5db799323a211d12937f69a1ba28d3c740bf2569.1782200200.git.cesun102@amd.com>
 <59a681f3168143ef939bdd806a2b30ea4be441d5.1782200200.git.cesun102@amd.com>
In-Reply-To: <59a681f3168143ef939bdd806a2b30ea4be441d5.1782200200.git.cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-23T07:58:52.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SA1PR12MB7294:EE_
x-ms-office365-filtering-correlation-id: cc27b34a-4f37-4138-7bdc-08ded0fd4a2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 9/ipuRWfQZ90ORY2p1g4aAxEJMARJoQKg8bxOe3aB+X/T3kkmregcHOaP9cjiSg5y5XVrVHdvmLfEMB62QqL79shQbB+3vm0fkRYZDNLCyXY3nydTMmnKHAsBIc81K/yjypt3eUIhvnyFJgGfgQxsHtS3IV/cAglc1tNaW5CZPV5iIObTV+eWdEqEZW0iN1To2PiPIg8JGPqfRO8WGc18RJGlQZVvsj++AgzD3AHJ7WLL75qkfA154r7NIkOqLVn82mB6zOpy5mcxFe0uTXhFG+GEP2lWFLoydaSl7Jt0iazdeWNhWAOz1EPxrPnaN87vJ8twX0l+cUYb5HB4TtHWQyFWirtu77UPRj1Hp4QzrAokBcAK4eNG99YbHy+Uun/j7lzSRN2I7jeA/MEOtVsnoFLMQ2JUpK42aMXA0gr6/A83FUjAqJ96lrmnipQhn0UaU5ZorIoamvlmOoBR2/9cFgpzQlu8Y3jJsC0d9sIxEkGUag3MKWBPtbRRmZObfKOUqcJCZGGMvzHot7ZvKDFRQpirxqTeh8lvgm2UDoO6PRWcpKFwmFCae8hTVqDdjKMEPp7z5ttHVKk8lQ2Yrrp2jqqUfzH3E6kWSWa6ElkCvY0kILBoHqoMpCeOoijl30X7wtKLXHjUG0FLsj2ausUwFl0Rf5i/R8xPTCc4jjLc6xLt3JXky7goxyRbR1MSM1EJroQrZM6QF9LRlr5nIueIe/h1WyB0r+RmbeQ1dXRRWY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vR3uTDTSlfCTbt2aiXKd1qH6z7vaWgVyDl+rnEjCuXKwN3tPD9bXFshnzQnh?=
 =?us-ascii?Q?OP1g4McmRDEegbG1VEhON5gsnEjKyILnQjFvQB/hlOiDnKWFkh5SwGzMLJeo?=
 =?us-ascii?Q?aCn4lxdvF5eWLsQEHxYPhjwY65sM/5RB7mGdHgEoSEYVoZJIVmvv1lzEtzdM?=
 =?us-ascii?Q?EYXAbsyZP2GjaXnnHZOVnNdv1fjLgxIylXWnqdzCUVnJKdaaLo77pNYK6W3b?=
 =?us-ascii?Q?8JtfemXOg2pJ/kT9xVUQn2WKVN5OoLcqcxJNTcnJNgQA50oVvVDMGloWYWj0?=
 =?us-ascii?Q?GcoMyJFKki2aG1fC4AUVmYitACIFfFfALsCWnaEQ66ai3wG11Jenoh1bPMBA?=
 =?us-ascii?Q?WtxVVbCt2kXNfhBwApiwScxfHCwYlTRVE57PoT6bOIqYP+EtLtuv979mHw1q?=
 =?us-ascii?Q?7P9IwIJpwz9B52gcTtZI2J3v1VxDQfdVZzoTY3C23MfrvWQZOUMkXpaG21V2?=
 =?us-ascii?Q?ih4iUDiRRrysqzKL5WCYjhN/JshcYWElYsqoVB2tf3ER8N97RinI722+SJ77?=
 =?us-ascii?Q?8aoXBJiRbIxC30l65LdZn09UW4v4AiNo4EiQnBsplbyawtxrM/l09bc3W5rp?=
 =?us-ascii?Q?4m71EA2JWfTUuoOiEBQcnVhylGD0oFgKDjmOiSQtA+vQP09MCMvRypzcAOGS?=
 =?us-ascii?Q?yGldtO1KfwJzymK/3QBM3/JSqkNE8XgfIDybfPNH1RpDbanXiKWWVvrIUztd?=
 =?us-ascii?Q?3Szn4yxtCZlj45igll1R7skB1KJq+hp1tBrjG1zNr8jXPSaj61ujuTziVHUk?=
 =?us-ascii?Q?2zj7qHgPDD8KcJGNIlHbO7tRK7i0oDTDF5C37rR+rog/QESIEzcc6kS0kmRH?=
 =?us-ascii?Q?idnspzCnwoB8saUBjGJUPyXUlxb/fETYAt//MW4X1XJiBN3RI78CpPs+6c1/?=
 =?us-ascii?Q?MUXQ4NrcXXpZiZcxlOpcuEGbkHYLmgVHRDVPkV0Wg9MqVAbaV31C780SNyH+?=
 =?us-ascii?Q?O50nGJizh80tYAm45ajLsVd4H2jx6BBWVydy2BwRRj1lxvziZzvcVa06BpLL?=
 =?us-ascii?Q?yQAwh1sKKQBnwCZrnCcTgRo3dOkWzAj8ut3BJo+C/sZtkBVdTBD2ypiY6AG1?=
 =?us-ascii?Q?JnpKXrMzkQBkD0uTBvfYZk6SGc/9QvFIurT4CrCqHvRsYmHneR5SbZ6fpRvn?=
 =?us-ascii?Q?mc6iYF52+UJWyQarPrdV/YTTKi47TnhEZcPnRm6f1kHDQOhkTNFJ8oZvAeZZ?=
 =?us-ascii?Q?FduCspu1SWQJ+VHS2dbpcz+fqjixOZDTLCCEoNi9oXmqcptn3ivwMlt6OPFu?=
 =?us-ascii?Q?JYdRdEXjB8YRY+CJ88AbYbGYAkbWe/VLj5K54Zy17BmDEsXTnIg4poSBNfU0?=
 =?us-ascii?Q?9TVRp/KPnO53Rqf6jCyEBiilfJuWFulMLaMYDX/y6YVUDnAsBWuYtg+hSI3W?=
 =?us-ascii?Q?RIxRezSCOMGw80QwQvz52iezUtexNSTByirmOQ/+xcxskhv4W54dY9hlDRY1?=
 =?us-ascii?Q?1mO10MiUdzwUI59A3Uv141/U7z09I1p2c/Qx8rMWcK6W8xDJxBD7s/pDLXsw?=
 =?us-ascii?Q?wbOrQiUH3Tdr1pgHmYoBmxIWoFsTtE3RQDhLciyG6vXp/WXJOYT2jyPJISri?=
 =?us-ascii?Q?db7e2/4pB+bzqyEzloRQaAYB2ef1XrIlxhTs4dnijhvVgm3I8REcnNhjd3qN?=
 =?us-ascii?Q?ONqEwe6R21gkAM31i79MObemoFMj+djWqXjP8wcR1dfZZf/6J1nj7RDnlYXF?=
 =?us-ascii?Q?jfsKoes/gYhvqsnw3td9MxncHG7ZXp5SfkZMnaMnFmSfD+p3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc27b34a-4f37-4138-7bdc-08ded0fd4a2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 07:59:02.2416 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UJsVJqOP8Sx1Kvw2ZJ9upvD7HgSmFnS2J5nW8oyRw6uMBCrqskLa3wnxmWu55gs/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7294
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

The series is:  Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ce
> Sun
> Sent: Tuesday, June 23, 2026 3:39 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Subject: [PATCH v1 2/2] drm/amdgpu: fix resource leak on ACP reset timeou=
t
>
> When ACP soft reset poll times out, original code returns early without
> cleanup, leaking MFD child devices, genpd links and all ACP heap allocati=
ons.
>
> Replace direct early return with goto out to force run all cleanup logic
> regardless of reset success, preserve timeout error code for caller.
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> index b0db0834bfff..1d77d0cd3ec3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> @@ -510,6 +510,7 @@ static int acp_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       u32 val =3D 0;
>       u32 count =3D 0;
>       struct amdgpu_device *adev =3D ip_block->adev;
> +     int ret =3D 0;
>
>       /* return early if no ACP */
>       if (!adev->acp.acp_genpd) {
> @@ -531,7 +532,8 @@ static int acp_hw_fini(struct amdgpu_ip_block
> *ip_block)
>                       break;
>               if (--count =3D=3D 0) {
>                       dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
> -                     return -ETIMEDOUT;
> +                     ret =3D -ETIMEDOUT;
> +                     goto out;
>               }
>               udelay(100);
>       }
> @@ -548,11 +550,12 @@ static int acp_hw_fini(struct amdgpu_ip_block
> *ip_block)
>                       break;
>               if (--count =3D=3D 0) {
>                       dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
> -                     return -ETIMEDOUT;
> +                     ret =3D -ETIMEDOUT;
> +                     goto out;
>               }
>               udelay(100);
>       }
> -
> +out:
>       device_for_each_child(adev->acp.parent, NULL,
>                             acp_genpd_remove_device);
>
> @@ -564,7 +567,7 @@ static int acp_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       adev->acp.acp_genpd =3D NULL;
>       kfree(adev->acp.acp_cell);
>
> -     return 0;
> +     return ret;
>  }
>
>  static int acp_suspend(struct amdgpu_ip_block *ip_block)
> --
> 2.34.1

