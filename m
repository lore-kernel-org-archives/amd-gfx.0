Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78E3C77B7A
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 20:18:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09DB510E3C1;
	Tue,  6 Jun 2023 20:18:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FE0710E3C4
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 20:18:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpVtVeikQNEN01TmoApstVmXmRQiCusqeog7JeggR7sX4JvX50YJeUzKXfJr+W/w/aO2VH5gziulERHgYho/Bjr9n/BLrNDL6JnPtgOeQgy+LGw4JWmGMLC/3BXlhdHs9AOcmLS2GcOupb5boVx1c2+zi9DGqmfzpcwMA0YcGje4gaN8dKHnd4jbjBADqshseUaBJ9O2TuCsf9iTz3gfx+olk+rtZ8dzieVZm9dkkhbopcjsX7EQHlpnb9Qr5y0RdKpzpHuLHk3PFB6p4YTsnVdKKhKG2GfcroVvESGvHRX80r27Lb9vovyHp1kHO3VkypL8B4nmkJeHK7VZVHE6EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsbYD1Wspkdwe1y80kVwd40KRsDe8wR0oHTG6RaoTi0=;
 b=kyqIQ/u4iDC+xbwpx9zq7vkhC4IWyzn941xk8EQ58GrcjRJLwzg747QNVZIhv6cVSF39fVsYTMJc9HLGOV4+JAuxbgw7IpC36483FMqylm4dH6KgEw5mhetJK2WsBUdoiXhHsmyMIi3kkMSIUWVlc1E4ndnKrzTben7ZRoz7bOzEsS4vi0RHpDcg+YCvoLtckwnP9vq/h+r3/FQkSZWdBpcgFfKamttbkwIKdkB/R6oUuol6K4ERrruFnpqXurVWymPaOkAl/A6E5fghGMTlexDBLZ3XA76sZ/VTHRJ1V6i2X237cNELScwWUoTV1co0akmhHZYi7sm5n5tpGiwEuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsbYD1Wspkdwe1y80kVwd40KRsDe8wR0oHTG6RaoTi0=;
 b=RGKGVWJZQeOuxWLGXEUntLJc36vHkU0nV8K6UUPz68Q1nV6jbx5hnopZWxjswqs9nBIRe77VKdNYEcsxIobgjJ2nHnMZeuBJPg+mPJuIKedOM2Qh9nG87usmQhvhgdQ0DUkNYZTDmZCED8i6X1KrraiwJQMFFd0oOyqMZ7qAuEM=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 20:17:59 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e%3]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 20:17:59 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Subject: RE: [PATCH] drm/amdkfd: potential error pointer dereference in ioctl
Thread-Topic: [PATCH] drm/amdkfd: potential error pointer dereference in ioctl
Thread-Index: AQHZmFGxX+LRUXzXNkmuPdqXWFEJKK9+NRpw
Date: Tue, 6 Jun 2023 20:17:58 +0000
Message-ID: <CY8PR12MB74357AF31E90D50B5F0A86218552A@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <ZH7vfZnpMMsGKEOq@moroto>
In-Reply-To: <ZH7vfZnpMMsGKEOq@moroto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c64db08b-a15b-4dde-8c79-1ac4ed7e006f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-06T20:09:59Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|DM6PR12MB4435:EE_
x-ms-office365-filtering-correlation-id: a77c829c-7e10-4f0e-9af3-08db66cb1f26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q8a57YJPKdyazIbNjzynn17x/RsQ9kW1dV0QuVZffqaiEukkEM7Sm+AcFBi5eybaTWg+n4+KOyD+b1bpeRXZpvAVm58anLn2nVn7HVSQCYmWco3GWPhIwf6UEzew69qzmGFKNZm7CGw2ttAI3xcqQFqrjiTVEwvVf5L6/SoEe5XIS8xCItme+XUGX3IGEEvXwAXuIQ5OVs5zSg236WhF8HUpOshv2lockxydskGdDC7qc3tKaFI+6qsbiFZUEPJjoMXzik3Jismo/PTeu/b4Y+6cUUmCCA/8et6h2AGZs3wp4mN47D1dOJ9V5Xm8DOQ76KCEeudp4iAV5htFnZ5dDHt0gXX1dCjuMCyekEcx+UGx54bIDmKvrxoIrQmXnhOArrLNNyaII24PY5e7LR+fpZ/RXpVoWa2cgKLGPdcC/siLiY/z1bAFklXr0afyrEXRE/bu8d6M8oepYX4dxha/RSOY2ndi9zRw0MhkNEhlCXymguS34Q2kDv4E0owHlWSud+34lIzhev89X3PXXASGFFFALzE0MhUaMBi7HJ6XRFLdyuVPE8Y6yo5ilxFR95ACeGitFwE5HO7caLNAuaSqUAUcxUSNvMfB0yzOZj8/dvSHTr+fr5z62KYUkfPZZ2E3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(9686003)(53546011)(38100700002)(6506007)(41300700001)(7696005)(26005)(83380400001)(186003)(55016003)(71200400001)(478600001)(54906003)(64756008)(122000001)(66476007)(66446008)(76116006)(4326008)(66946007)(316002)(8676002)(66556008)(52536014)(6916009)(8936002)(86362001)(5660300002)(33656002)(38070700005)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WSF2LCKBDW5B3cmoT3DmSfQbrgSTgyGYxTMolIFxDEj49fR10a7HkFXC5yPe?=
 =?us-ascii?Q?hnyEXi7NOg+AyRbtOsNUukPhP86BLEaDxa9sQxZYUYe0wcyjzZu3LByElyCV?=
 =?us-ascii?Q?BwPyIiuv5xkVLqZU/hQc5lcVmdNCAxO+qlY6DZqy6jI3jjvJnZx6Q96PibrG?=
 =?us-ascii?Q?fZWwtoDLqDN7CfHFBBB1764Dxkqz15QwV7fzFkQyN5YRDs+n/dqoY8DdeDWS?=
 =?us-ascii?Q?axtigmHHUMTIrRDaGVe8NbcfthHKqq2MVhfKNrAOcKRCUhOZ1EkEwdQ+uWDi?=
 =?us-ascii?Q?VEZQxKZQjvTXuDh6xIJKmMrwltyzVsbdt9hvVPTDPYjsKtL6inpOIm/CEI3z?=
 =?us-ascii?Q?UZqRvz/OHXp/0rX3SvygwIUJ9Ma6/OyeRdSozF88MFcz3UPMZkMcDsvuqbQA?=
 =?us-ascii?Q?/dieww9kpi0WAS4QtxLpe/AJnhD9e21NBCb4N40UG7OjDfHhxLPJtsVFmomB?=
 =?us-ascii?Q?Rzyyer3VnLfUGb17TjSTGCCxWu570CHt6gApi7YuxOwxhlAzyBp5udxryk03?=
 =?us-ascii?Q?OFflHOZLynJ8we3KUptD1eLT11kk5SSvzi3xkxhCFmif1UkBfiRPCdVdpWOr?=
 =?us-ascii?Q?0rWD5DM4lAY9QjzGLGIXNXjmCcBTX8rpzuOyrWZ3th3X984eZsGOqqgNT1sN?=
 =?us-ascii?Q?ncy17KhuWquFyJ4sjGGhOiZmziJs2pOVS7P0+OgcSYeGuyQ8em0decnyD3x5?=
 =?us-ascii?Q?6u9jcBEOCFp7jG2ZiAFBtHAghit5xB2EyBbNVWUO+W4AHKaQIjhO92mGoOFE?=
 =?us-ascii?Q?pQzsVVpdEb2kEufZ9bFaY8zRW8SV9Ib+7vF6GTXaEU9lO3bxkXXhNly4Fe0T?=
 =?us-ascii?Q?Gk6WHJW3phzcGgc0g6W2d7vZiBGPzfH7JyycSYyyORQb9pLbnL2TDA2OOXkw?=
 =?us-ascii?Q?+ibc2j6gxi1i6FdzvciEvMYUpW3vTzGsGNvcf+WNrJQLrPJUQePn+lCM7e+3?=
 =?us-ascii?Q?qw4NDoec7zMCDJojlA8WUu4o4rdra8MqKQtsdRQocgYBCWqcPPaPyQsqyxhQ?=
 =?us-ascii?Q?HWC2YZ6SVSm2LB3+/BOuAWRvvriFKyk2czOQIOEREsY2OoqIJsWpOjhGXwq9?=
 =?us-ascii?Q?VHNcnDXsyIMlkJXM/Ds7Pi/EvI1XTy4RYIE+uwHF0mGbFCuQXLRS6jTcL2Bv?=
 =?us-ascii?Q?7kgFtV2DJnA6KMWBf1VzDjPNChIXueFCV0czEIgXFL3QzIuFQf4Ez2jlH84/?=
 =?us-ascii?Q?9QWCn/kzuDzwks23ndEU4ZDUiSnNRhYVtS5S4kLZuF/daavSmqaD9x2BZFKf?=
 =?us-ascii?Q?FFcSvxY0ODqt1AD4lgQxBSctYYOpMzsyFzbvPYEnxi538r+RuHRoWeTp5Lqq?=
 =?us-ascii?Q?OUN4DEEHsB/icKP/nOzMAoyy/ZA5HI8XbUWWfewgqIfn7F9Mzxs70KPR4bDS?=
 =?us-ascii?Q?s+XtT01LbdWkowuo3ijHg4S6gy9Lf4iu3HQIBFeRm8ncbZheanzDcF2CkZpQ?=
 =?us-ascii?Q?kty2gHozcKLQhUlz14/jSNzurGDYSeiQRkUohpNSKQVMxu0rkvowKMgt1om6?=
 =?us-ascii?Q?ajEguqk4+v8Hyo9k0D2TtsKcHQiZxqdNhbwOhyxPnwzjWozuAfIY+9Eudbjn?=
 =?us-ascii?Q?vdMEkrKalr1Fv7LkhUI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a77c829c-7e10-4f0e-9af3-08db66cb1f26
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 20:17:58.9487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ujNfzT/l0kMQuFrCvpSOa+KuxEa8NkRY/dXiUeuY8qDJp0ZCRBc2VYzGyJvEWofy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, David Airlie <airlied@gmail.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@linaro.org>
> Sent: Tuesday, June 6, 2023 4:34 AM
> To: Kim, Jonathan <Jonathan.Kim@amd.com>
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David
> Airlie <airlied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>; amd-
> gfx@lists.freedesktop.org; kernel-janitors@vger.kernel.org
> Subject: [PATCH] drm/amdkfd: potential error pointer dereference in ioctl
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> The "target" either comes from kfd_create_process() which returns error
> pointers on error or kfd_lookup_process_by_pid() which returns NULL on
> error.  So we need to check for both types of errors.
>
> Fixes: a42e42c4e3b1 ("drm/amdkfd: prepare per-process debug enable and
> disable")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thank you for catching this.
This looks good to me.

Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

> ---
> I'm not sure how to compile this code or why I'm seeing this warning
> again after two years...  Very strange.
>
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index fc385000c007..6a27b000a246 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2920,9 +2920,9 @@ static int kfd_ioctl_set_debug_trap(struct file
> *filep, struct kfd_process *p, v
>                 target =3D kfd_lookup_process_by_pid(pid);
>         }
>
> -       if (!target) {
> +       if (IS_ERR_OR_NULL(target)) {
>                 pr_debug("Cannot find process PID %i to debug\n", args->p=
id);
> -               r =3D -ESRCH;
> +               r =3D target ? PTR_ERR(target) : -ESRCH;
>                 goto out;
>         }
>
> --
> 2.39.2

