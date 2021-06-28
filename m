Return-Path: <SRS0=DKNW=LW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D139C2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 09:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17F2661C51
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 09:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F2661C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF6496E40B;
	Mon, 28 Jun 2021 09:50:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D71F6E40B
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jun 2021 09:50:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrXYp8oYjF0oMXzblBxIByGqUZR5c+QEG98RWkM03tb8EZXZ5sjn2XxFaCuJ5phvhW+JLz1y4O3Kf4sX6KzAsrqNmmtwfqBoPGc9kqf4PHgJSx1hATXpvIGWlTXDfDTsQez2iGRmyH2lndzxg5tIp3QKKCI+AHLKpuO8ZOQqvIiyEBEcNPw8wghO3AC8b4XliycDP7KkYERKAULENGX5Z/0AqT215iGRCNJNoRDpK+52q4XIYP6eAV3IBgUlw7QIIw5pkVdG6oUVaBLbVdOJSBF7oFdCBcCobsF92OMwm2EwoY8IQuOYfg7oCzHqtPFXa+YIJeOmQDF8XdmWMAHbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNDfGs+X5I5VNPiwWwfvNjKvxKyZidCO9R+WVJgFN+w=;
 b=JlGcjvVeKOCbiVF1C3sGdRlkPhwAsTna+YWPf+nj4cXyj7lnxnGEuegHLnHkRq9ey3mNDgZjW21fVGCuj2734TMkX0V21d2392CUcTJg1XQebo9x4pYAMDMhQJ/xwIuzc40M92IKqJt18HXlLxeYvtibuOJQ7tMFy/pQPJbIh+E/L1BaNBb3DJw5Ae2Zaui7j1/wig+msFQYrraNbw11EcoGMQwal0z+4XTeElpE1kjW8di0FOkfZT1XydepUiaHdFvRMkMTWl+RrChAHK8RNzf77owh63H6kjAB8WoUhNDTjZQfGXmPhQUeAw1aXTGHarbaiolvMsyv6FbsjzluAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNDfGs+X5I5VNPiwWwfvNjKvxKyZidCO9R+WVJgFN+w=;
 b=YajCllmePjFmWraYtsB70+G2guEIR7LIzbYmnl2n7lAouiO0Drs5SPth/7ZMUgx1iGqndFKCreztVHHF+QRZKP0fK378LifUCC04CSaHGfZvUMtKAYF9ltT5notM67hnfUqXs4d+ydTcpFDiBspzRu/HEj1AZa9VElZGR9yyscM=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.20; Mon, 28 Jun 2021 09:50:38 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4264.024; Mon, 28 Jun 2021
 09:50:38 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Siqueira, Rodrigo"
 <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Yin, Tianci (Rico)"
 <Tianci.Yin@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/display: fix null pointer access in gpu reset
Thread-Topic: [PATCH 2/2] drm/amd/display: fix null pointer access in gpu reset
Thread-Index: AQHXa//kgpCJWYCrCUKS60Qd8ynOy6spLb9g
Date: Mon, 28 Jun 2021 09:50:38 +0000
Message-ID: <DM6PR12MB26193E53A87433C718E38BE1E4039@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210628092730.4722-1-guchun.chen@amd.com>
 <20210628092730.4722-2-guchun.chen@amd.com>
In-Reply-To: <20210628092730.4722-2-guchun.chen@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-28T09:50:34Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=db906175-4c4e-43b6-8d88-a484e522ca44;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9eca708c-b985-4370-0b4e-08d93a1a2f24
x-ms-traffictypediagnostic: DM5PR12MB1835:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1835701B73AF4C3230858E6FE4039@DM5PR12MB1835.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aK+KUhF6e47OHf116/WR1Zi+7fnC4WGdfg2KXdKHDWW5VOxSPw/9gBu383qkAQAkmtnxNFTdKQsm7zZqUtNK8PeA/+EH9OzMHRXQcXCAQ7APBpUxkTp434CVJemuZkMPHfqsQWUgNzkre1H5BYgqfSvg/4XKr6lBHN+mu8gr9mLnnh2DPqNbIG4mOupmdUU7uE5opztj8QwKq8WOu5uIDONEqKQxvBCumjuI2/JlrGRuZx+oasEUccwGbJwut/Y5Fz5JZYwpwu6jH/Przs7uDTrJ/zUSb2hp+REX0uFlNJQ6Tgm4tJWZ6aUjXMixOp/DfH6VZydFWt78sFrjBrFY0toxqRay0p812D8XIXovBI3+y8i5Xryl1sDJnJRvEGmAWXA35NTpWpsuTkzPn/Aj1z1RR/rCEttrNOOPhN/ok8uyIEjWRORARw5vPKyG1QXK7+nIR1+IFr7WCCXNX/OQn5hCpcKWrXcXTBWD8zm1dQmK8ukCHWqBKLa0ecuC8d8FHbrQhslCa1Z8VCPuILaRRPO9Yklu8v/u8gHY8RnCHYe+vMdHVpCSq7f2wSFqZwvTT0vZtAhLbTqCJrCNuzLFVZm7L7NW2hOAVou2rT/IzJgTi26JFGBjA/bJjydxmQm4L9nd9wGiaU6lQUbsh1VL45B2dPZ62IfHb5W5zeH2vzyeF2v62Lg8fPTSZbmn7aIPkNpP2WRVFRb0ihgnbVIz66tvop7TZ6jk1VlQg5pR8Z4OGE81zG+1doa9Phoj2vapsWDokbDTKEL7kozvSOXN2A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(83380400001)(8676002)(55016002)(8936002)(33656002)(9686003)(86362001)(921005)(66946007)(52536014)(186003)(45080400002)(66476007)(122000001)(71200400001)(316002)(26005)(6636002)(7696005)(76116006)(64756008)(4326008)(66446008)(966005)(53546011)(6506007)(66556008)(38100700002)(5660300002)(478600001)(110136005)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hmKxKJ5Kd75vfjFxqG22Qb6FGMS2DtaBAHksagXeBDzVO71Etf0wAlGdz9l/?=
 =?us-ascii?Q?KKnhpT4b5S14uLRg6nh8ga2mbHh0YJp0urLqwmVP6F2MIKLaZDw3dghjulsV?=
 =?us-ascii?Q?QWckQ/8qhN1yL698OyCFDGCi6hh+3UzezgzVV61p2npQpqQtspHcfUhJvltc?=
 =?us-ascii?Q?KBF/l2ASreyUbMRLpqNsdP/qKJd49VcxOtiB8XBCUU6CwHShLjwZ++z+/zSk?=
 =?us-ascii?Q?s6R78T3R6MuxDkzLEGoESRZAxLY6RYtSC/NaeIGgQdeVq5LRPrU5hGOO6V9V?=
 =?us-ascii?Q?BVvR6wNF9Jy5SW9TfIKlpHWUEluGSUij0TOP3LCkWLRgNGwwSMUIfJYy2lIz?=
 =?us-ascii?Q?I+55f5nvTgyMpN+vhfMQYNIeVebggzWe9xWcGeni8AoPiOifSK+41uVK/2ha?=
 =?us-ascii?Q?KtoJCfnTlpDlCXvcFKhH03wZ8jjO90jAW6FV9Th540XHCg2xUomODfU2e5+c?=
 =?us-ascii?Q?4J1UUBSJXjyfVYvWqFssVSP5iMrI4tWWJyyW0PVfk9w89x7vdKVSl4GfyEMQ?=
 =?us-ascii?Q?049gxTtD4UTf6rtbjk/XRvPWOZKr1E2c/ErrmpjW3EarhIwqkHVuCWoym7so?=
 =?us-ascii?Q?vs9vksYd6bYMKvJ3Q677lkZFGYB20m1Nomjptm4/whKOgDjCLupDO9rIiI1k?=
 =?us-ascii?Q?j4419ngTvZ6sDVKlLvoYk+jpWpbnZNs66Ty+M9uVhHNczSPl8gwTQr33K0b/?=
 =?us-ascii?Q?oLynW3hHOEDZzolZdSYyyEaLghOvTzQ06VeNQ6duwfd7Yh13ogF1fY+NsEyN?=
 =?us-ascii?Q?eOoDSfMuZBrRnNFvi4E+rhqzsM4v9+YmAdWvmHDFsAyTBehMUhvbRMry8+BJ?=
 =?us-ascii?Q?winqPf/r6sQVmBXCFzf+9H1mJ8+wjVs659uheUEfW6EbNVNjENseFuKpu8w4?=
 =?us-ascii?Q?hj8jdBUIYj9+7Qocvh7aC1Y9RMfOFYWxd2ZDs3f+otE2e03TV8TZetvz6eig?=
 =?us-ascii?Q?hiyMGNH/U3WnfKClwtLkfQJnO9slf7iydHDEQhVIKdIVi4qUBmwOAR0yXeXW?=
 =?us-ascii?Q?Yos/wIKhFFavXRBVfSWn+rRIF+HpzSCYAmdUXZR2R0PR9YrVoLnAn8XgeY76?=
 =?us-ascii?Q?wZico0BBXS3UsMiRUaxHUq7ZALmNTBdGMci4DRQhSIwc6C7ck3MQHf3dkNXJ?=
 =?us-ascii?Q?DdnY0CDDiNdizWEV85GCXZwikXHuWMn43SJJi/ePuNMd1myWUK7QxDYxG9l8?=
 =?us-ascii?Q?mg3VHoywnMTuOm5BY1USh+2GZX1dH2jY4doVDVi1mxFhN7YFr9I16P5/cMjn?=
 =?us-ascii?Q?9B9QV6nNQOCeaIC1dHMDLOUR/B2Kue9HyuLZfZ/2SDgfWfVyO2vCkX9/6znh?=
 =?us-ascii?Q?iWPkpIAvYNrWoX9OLKpRoVQr?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eca708c-b985-4370-0b4e-08d93a1a2f24
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 09:50:38.2298 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CA03IHsaQOM6y3yvvV9Unc7i98JC1nmfYJjg4jOlMYtmVDVZfbEtetit+vfuJu5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1835
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Series is reviewed-and-tested-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Guchun Chen
> Sent: Monday, June 28, 2021 5:28 PM
> To: amd-gfx@lists.freedesktop.org; Siqueira, Rodrigo
> <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>; Wentland, Harry
> <Harry.Wentland@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH 2/2] drm/amd/display: fix null pointer access in gpu reset
> 
> During GPU reset, when receiving a DMCUB OUTBUX0 interrupt, DAL code
> will set it to be OUTBOX interrupt and sets hw interrupt.
> However, OUTBOX interrupt is not registered yet, so a NULL pointer access
> will be executed.
> 
> Call Trace:
>   dal_irq_service_set+0x30/0x90 [amdgpu]
>   dc_interrupt_set+0x24/0x30 [amdgpu]
>   amdgpu_dm_set_dmub_outbox_irq_state+0x22/0x30 [amdgpu]
>   amdgpu_irq_update+0x77/0xa0 [amdgpu]
>   amdgpu_irq_gpu_reset_resume_helper+0x67/0xa0 [amdgpu]
>   amdgpu_do_asic_reset+0x219/0x260 [amdgpu]
>   amdgpu_device_gpu_recover.cold+0x8c5/0xb64 [amdgpu]
>   amdgpu_debugfs_gpu_recover_show+0x2c/0x60 [amdgpu]
>   seq_read_iter+0xc2/0x450
>   ? do_anonymous_page+0x22c/0x3b0
>   seq_read+0xf9/0x140
>   full_proxy_read+0x5c/0x90
>   vfs_read+0xaa/0x190
>   ksys_read+0x67/0xe0
>   __x64_sys_read+0x1a/0x20
> 
> Fixes: 85465bd6dc6e drm/amdgpu/display: remove an old DCN3 guard
> 
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/irq/irq_service.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
> b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
> index 5f245bde54ff..a2a4fbeb83f8 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
> @@ -119,7 +119,7 @@ bool dal_irq_service_set(
> 
>  	dal_irq_service_ack(irq_service, source);
> 
> -	if (info->funcs->set)
> +	if (info->funcs && info->funcs->set)
>  		return info->funcs->set(irq_service, info, enable);
> 
>  	dal_irq_service_set_generic(irq_service, info, enable); @@ -153,7
> +153,7 @@ bool dal_irq_service_ack(
>  		return false;
>  	}
> 
> -	if (info->funcs->ack)
> +	if (info->funcs && info->funcs->ack)
>  		return info->funcs->ack(irq_service, info);
> 
>  	dal_irq_service_ack_generic(irq_service, info);
> --
> 2.17.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C338ed5d1487e4834
> 76e908d93a1706a7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6
> 37604692835538651%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
> GTl5TKifsVpzCiccc%2BXmqnooa1grUmGjyPmMTCN1zmI%3D&amp;reserved
> =0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
