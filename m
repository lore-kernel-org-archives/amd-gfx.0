Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC99FCD6E7C
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 16:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71F2310E688;
	Fri,  5 Jun 2026 16:16:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="efIldAkN";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012050.outbound.protection.outlook.com [52.101.48.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B30B10E688
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 16:16:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrlsUn/OUJVFUe1ZW/H+10nWDjO8MNwoBRxd1mPucz0G2ZD/9xpsFnJe6bEdVl5txG+91WxcHnNt3dJ5B31drNkdsvL30gSiJmMoFxNA/F6mYsmVncBXwcWmP5gvxfV/Oo63XK9NvNtF9apLOfiCwWWvQVtgCQzlgT79dAZmcIm1sfjA9YNWSOcKQjMlY+xtudhOeuld4S/GPVY6WQTSh/qIfyk+0CjOC0z0b1Y868eAOpKrSDd16zUHhBaaXgO6u4UzRJAXKSGohULOAgtK+Yd5P/a/xMH4uW2Er5iMxH2vxEVsuVMJMkY04o5pRkqH3JlSpUV1Fk+IN+IGrJMk/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=im4B0AQO8AfAIm/bPSnhVeXOBT7LxHM8Pw33K5sGSsk=;
 b=BejyRNijtio7hcZ8sQZcaRUnWEZ/HU6sysBFLeHD+25V9RR7GF4UoGoBxubz7CDE4EehES2rSHJXbl4hp4tPqB0JlWrjEWbSAAtU76hbs8mJyfPPW01JbF/WunwuTHm6khvskuQ/ch3QxdwdMNtj6XMLuFh80C50E18IMOmOMetkLesFOf84zZ9RXHOZUnpCzwl3n8QwHdhrcVNFdc3cV7yna52+l6KaHoBR2xi13CHwN70Sn8fAI5i+1KMjKAYVZMhpkNLBs0qAHnGFJ8hmncT4zC6BJqMmaz0xTf8+tA5zZxdIbbzFRcaz19TZrUJAyU2Z1poebvi96MoJI+4SKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=im4B0AQO8AfAIm/bPSnhVeXOBT7LxHM8Pw33K5sGSsk=;
 b=efIldAkNh85ThQXVDXmhXAY9vzGTEb+fWQys8XneEXslnQzQs8nv5wy6p0ePPnDe4muPmuw3bTkzjuQEfDh+KozDbuf4aQhMOUOqvJE+IEF0u8zmtx8Ax/9sihUasQbVzC3KRyCn1uryEiwQDAbDcYgYjqQkw6GWnWD0H9ppjTo=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by DS7PR12MB6168.namprd12.prod.outlook.com (2603:10b6:8:97::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Fri, 5 Jun 2026 16:16:12 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 16:16:12 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Francis, David" <David.Francis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Francis, David" <David.Francis@amd.com>
Subject: RE: [PATCH V2] drm/amdkfd: Check bounds on CRIU restore event id
Thread-Topic: [PATCH V2] drm/amdkfd: Check bounds on CRIU restore event id
Thread-Index: AQHc8sBCM0w9lO9hqkeOOkGU8u4YirYwJn4Q
Date: Fri, 5 Jun 2026 16:16:11 +0000
Message-ID: <BL1PR12MB5898702AB07A4ACB83CF919885112@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260602184652.2614456-1-David.Francis@amd.com>
In-Reply-To: <20260602184652.2614456-1-David.Francis@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-05T16:11:42.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|DS7PR12MB6168:EE_
x-ms-office365-filtering-correlation-id: f11a37b1-e5ad-4e70-2ba3-08dec31dc2ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|38070700021|56012099006|11063799006;
x-microsoft-antispam-message-info: zCJGxRz/bkeSuwMAtHAMXnlQmBAfK9CJ+yXkkSiqZiRGx2pNeJ8RJhkuziKde5weCnTiG5tJukhvY1MMDjnwEG94hQ5tc37/Hc76vAIU0MPGWyOG1t8RLsuJUWeKn26E0az3h4TyUVKFxu2DwabhZdeXGnjFp+cWamqErE/w/Zz1YsUu3NJwC4Njwuvdz02J8KsIFU61eN0yxQKsLnsK5Q4RhNB9PN5+tuUVoBUkgCuNy0XC/NmZsvS7lOjP6+1fa5E0If+XgxfiDTnyAJiduEGUz+9kaIupDxItvHU0U7ZzsQGCtPEJCl4Z+LEsBt/O1MOxYx/ZuvYBRBf82NusrhvJMhkyQB9RwSoX0akfVhwpTxB1kIB5kNnrcGLJuJXEWSvXldgYKV9u6pNLhPta3gtlVyDhq0kPiCoZhKtqTucrcdxj4rRTu6sy90Ra9ZSN7LeobCywDsg1Il+50VkwA3YeRhAQbf+QYGo+j4oPZaHpzUDuakGsx50nv940SFhDegYEpyGNtE9WCgQL7148f1Hsi4peTpcALpfUk+oZ2yxsDhLDDSGXoQXRntm1KPBU5LnO36iT4AGZxa2T7s5Baeln7JpIrxpA08JTqhe+iel8Za9S+6SP+NPKQ/3vTzbOavnZ44h2jjKkS0CzRN0IKOvpkBa33fg0emHzamPO9aysC0RybwfIDZZzmrlTNEpggq+yg3xLTMe94LDz6CaWHMjwZjK7glTtAaC6zqtk3VjKFEdPKs+0d6acgL4VkK10
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/mwEbDDTg/grdpDNKqdSwSzyNtmLgm3CcoLuunG8k3FeiiIJ7vR4+za/qr4R?=
 =?us-ascii?Q?K07IjtzqjRMEL0BwJSnWYu0f+eCdT1ln/adNuB+wnokZJ5Xb2vCDEN9h7fT0?=
 =?us-ascii?Q?j0RAJ4y4Lus5IBXt3yfjEJJ2AL1DorN+ArD+9f2x49rGIWARmvceuzp8JFNT?=
 =?us-ascii?Q?iXeXZ0Ss+WILd7gkb9yjT7WY9cW8B6hSdaH4v5NjV2wBaJnOfigVzgGUjuaK?=
 =?us-ascii?Q?hL1YCwrRoA9DPcGUrDKDPjfMC19MmoxBVf7Zt0dkZPEefSZKLBR7HGH2Qv87?=
 =?us-ascii?Q?J2DOMGI065FzHbCeegFPjK9QdAUOqK7V2eklL0Jman4Xj8h9j+uX7Yl/0Kmp?=
 =?us-ascii?Q?DYVtd01TeAiBVAUrzgKs9yxPG/rFzMGiOv+ujMvASWOQcHf3tmmhItmgzXPN?=
 =?us-ascii?Q?b0Ptscxfx3RcyDWWRZ41lZ8B5fcYhk+bQk8eXWqAhDjcDE1siXVoq6w4U0np?=
 =?us-ascii?Q?IdDF/EwSCY7JL5j5VOi0i/CF5Gm8dl/7cYiPMpY3VFRJh53lfKcK3aX+sJV7?=
 =?us-ascii?Q?e63gTv82ZW3GgfAj50fH+kMn0KG0kia5sdi3he1wLyh7mJA7CckJWO/6QgsM?=
 =?us-ascii?Q?p3IQmmzJWiHgk689qQI78NFEAIQWeY9+Jx/l14DxKHUiRMsITLI13H4phbXT?=
 =?us-ascii?Q?x5iujzcnpmhWmo18dtAD2dRjKQQyVTOUTB4RuuP3qrWk3NMlLIp30Fzwi1EX?=
 =?us-ascii?Q?bIauqeyNJhhRUfr9XzlqW5VYq0TzmzcrkGbacDUW7iUAZzEwXeJc9EyeU6vN?=
 =?us-ascii?Q?Bz99xPJrTHG9IAEYwJ6kGz5BL3gsu+quhfaxdinx+2+pPmB0OJ0E3V3IBsB8?=
 =?us-ascii?Q?7slA2oDJfhl3aPHnDm4S6TJhEe5h6XyMJF4SsJeHH1kXnEwYjBfUuDTpdfG7?=
 =?us-ascii?Q?UeAxwjCn3EPC9st00G3G1PFI5bBIZuhhL3nGLoQXC5eBcx4xfrVm6Cx8JFr+?=
 =?us-ascii?Q?rSogHIN0jk5wTkefUwM4VlJHo2aLT927j1FUUkS0yxcljypsGOCOqCdRsFM9?=
 =?us-ascii?Q?dCODs8IqXAzXfauYVMCQ3xtPjBQMMmWrA1BMFt10cZ4HCotfWYha3CtpCWPO?=
 =?us-ascii?Q?JCIh174Fmqv/qsLTiwiDiJPsdH5bSyqoFh7twTCz5rGvYmLMnfw0Zjqe9btF?=
 =?us-ascii?Q?+p0dpqcL0Cm1r3mL0jXRfwgkhhaebMnLS6PklfsgtGa4EIQgZf4TCOtRx2AT?=
 =?us-ascii?Q?bECZFe8i+HrLplA8wYMpA33F+5D+GeH0QBLP+Cot6j61t+yluG6NnTbKXRpR?=
 =?us-ascii?Q?tMyTY30zIL85wIIszOlxdNHQ2mE7og6de7QizCMp6WQCg71KfTHmMPlc4ue7?=
 =?us-ascii?Q?91uBeImWxcXWmLixXu4cKsKq3BwimbcTaU1PTA4LNqyMqGZhikoRV+iWFaqC?=
 =?us-ascii?Q?JIB6b91ye/PJFlx5vczwdJVV6RrJp1nsz46hYRfLb9PJdaVjOjorNOCwANqv?=
 =?us-ascii?Q?aZhS1EgFx12aLt+RdL7x8N7K4W1Mh8roQjyst7ji89r2uJylSrrbYV4V63qy?=
 =?us-ascii?Q?sWzIwKPbJEMhFNMkfpApPkYFzvinuHhXrtiQzL8FQ1Cgfn3M3PE6bz5f5Zb0?=
 =?us-ascii?Q?ZbIPHRgpRCae00HcHUTgOT1t1QVDL8HtXZ1UD+Xf43XIXNVuOZArH38qP+MI?=
 =?us-ascii?Q?vNR9TBMiBxPN4sactfDUxEErDRqPXCSzv1ehkAQhGTWropAikNZF8hBuAoX9?=
 =?us-ascii?Q?p3k5fBe9kggN6/jqh2WhPvrF+Mo6BOS2dPhYvzi7b/MKh2x/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11a37b1-e5ad-4e70-2ba3-08dec31dc2ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 16:16:11.9023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y0yfHHCBWMrWb+obWP+mnTnzffEg4XxcvCuu5e7uXikfyFIvs9WuXXoFlxZUUceT9xhWDjXVYdxLKhq/c1Rpcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6168
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

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of David
> Francis
> Sent: June 2, 2026 2:47 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Francis, David <David.Francis@amd.com>
> Subject: [PATCH V2] drm/amdkfd: Check bounds on CRIU restore event id
>
> The valid amdkfd event ids go from 0 to KFD_SIGNAL_EVENT_LIMIT - 1.
>
> During CRIU restore, ensure that the provided event ids are
> in that range.
>
> v2: No need for lower bound check since idr_alloc rejects negative
> inputs
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index e9be798c0a2b..850d6befeb6d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -107,6 +107,9 @@ static int allocate_event_notification_slot(struct
> kfd_process *p,
>       }
>
>       if (restore_id) {
> +             if (*restore_id >=3D KFD_SIGNAL_EVENT_LIMIT)
> +                     return -EINVAL;
> +
>               id =3D idr_alloc(&p->event_idr, ev, *restore_id, *restore_i=
d + 1,
>                               GFP_KERNEL);
Not sure if I'm being nit-picky, but if restore_id is negative, then idr_al=
loc will return -EINVAL. That -EINVAL will go back up to the create_signal_=
event call, which gives a pr_warn of "Signal event wasn't created because o=
ut of kernel memory" , even though the issue was bad input. Mostly, I'm won=
dering if we need to add something in dmesg if idr_alloc fails for that rea=
son, since someone could end up spending time debugging OOM when the issue =
is an invalid param.
Or is a negative restore_id indicative of OOM?

 Kent


>       } else {
> --
> 2.34.1

