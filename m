Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12B8C282D0
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 09:10:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5200D10E9B8;
	Fri,  7 Mar 2025 09:10:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z4xeUn7E";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49A4210E9B8
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 09:10:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPIpDzStwcJrUIjQ4zHg7NPisEJo2GJbOnc1PQh1urn8XkJo6OSln6FKwRbZ+irThTHif2iFEVMyZd/2kwiqjszbe9W45GS+YAZgz83YqbaKQg3W0iPT26RRH9w+YMokceRQV31BB0I6OO6/So1F+jIQW/irHjVUCjRh0udC6DQ7BnbGcxaCJS2nSlDm+fUaRf9HxAqE/EhN07q9r1BZSApdAZbb5z2+ZTqtE7ze2mp88s5KX5BiJ/uHCmO2hyG2+/n0UdsBAawqLkYMnaKF/wes9h4c0E3G+OMcRRsk0IAucQKWX2nVLk0FYXPPHVebBqRnbU+EKEgt/kuLrGUnog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+BYehO+cMvJlfyARMKwE8ZNKAmzcwb/0oG3Yt58NGQ=;
 b=Cu2B9DOqocC8QK7T4QpPXsRZ73VMwSfhJNUb1EUKB70poVboN20H1g2NslVPnSYexIkcMMtzcEz8eVRUUCE+Ui1eybma9P3AtSLX7zD4pWkQerETfQcQ8B8SRTop8IARYYIVlYYWcrpaA1g4tRhUsXEvB0LfWFXVYaLlKoiE7UlCWrK8B3LbzLcewwC5Sfh8ao/Kn23seKtF3QGtkQON25oXHqjKEs0OV6LkdMp/34hfckTNN6sg2TU/EGVO14QaWHtolmI5caYlAZoem2sHzYODCHYAq2/c1Ef7/pi3PPG4dtgFHFqqrgw2zDvDHxOOga+h1XHiIvVBcbqpeTMWGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+BYehO+cMvJlfyARMKwE8ZNKAmzcwb/0oG3Yt58NGQ=;
 b=z4xeUn7EY9VvEBjreTi67nedTxHa0nnzjI8bLXAbRb/udJU0VjKplM5eNSD+34hp/stM6PDzXnur57hxgl5BbUWxQfXmJskTZS/Eyaotaqr49NISbydq5SGaQuUlCtMW3QDcfbaMq97z1CYV8jopLejTc3ME27R1RpEk290XAyg=
Received: from LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 09:10:47 +0000
Received: from LV2PR12MB5774.namprd12.prod.outlook.com
 ([fe80::9dda:b8b4:caea:5204]) by LV2PR12MB5774.namprd12.prod.outlook.com
 ([fe80::9dda:b8b4:caea:5204%3]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 09:10:47 +0000
From: "Zha, YiFan(Even)" <Yifan.Zha@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
CC: "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Chen, Horace"
 <Horace.Chen@amd.com>, "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>
Subject: Re: [PATCH] drm/amd/amdkfd: Evict all queues even HWS remove queue
 failed
Thread-Topic: [PATCH] drm/amd/amdkfd: Evict all queues even HWS remove queue
 failed
Thread-Index: AQHbjZGQfLiNCD41lki5W0f0SJthLLNlQLqAgAIkK9w=
Date: Fri, 7 Mar 2025 09:10:47 +0000
Message-ID: <LV2PR12MB57742F35070256D43D131F23F9D52@LV2PR12MB5774.namprd12.prod.outlook.com>
References: <20250305054215.566473-1-Yifan.Zha@amd.com>
 <34d25887-a5ec-477e-ab4d-602458472042@amd.com>
In-Reply-To: <34d25887-a5ec-477e-ab4d-602458472042@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-07T09:10:46.967Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5774:EE_|MN2PR12MB4376:EE_
x-ms-office365-filtering-correlation-id: 29773ccb-1a42-41da-1a53-08dd5d57f2df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?2Yk7EQOdRMCbijiuNwDwFcSwoKQiXhqNxp0QDZ9TH6Hc2zAOcJq+W1s0yP?=
 =?iso-8859-1?Q?Jwl1NtWDKJkfAUkAhITTxYJon0jqKRXv4kqsJwPDvgd5Az2OrkQmBPzQmY?=
 =?iso-8859-1?Q?1R/HKaIj/qs6pm9asWWAqENwFHp+ej1F2FSCyUn9Po/gbxbniYX5kpVTdl?=
 =?iso-8859-1?Q?MNk5QHhqnhYctic2LyPrCFHzV1iwRfNl94xUTm7xPG8KkD+Aw22pnGCRZj?=
 =?iso-8859-1?Q?Ekm0azFsO8ISKvJSZJqszqT5f126MO23+0nbrN3UiiA7UmguiSzebWzhtm?=
 =?iso-8859-1?Q?vFDZGcxTEdM/a7KrrDPT1iwWNud1dYqZsCwefaub7/u0A6iEsLLeT9ex69?=
 =?iso-8859-1?Q?es9jwhcNeE3wWJNQHgmr+eHHiT+iQDusEi3pRe9IIBo0zdYsPix/U7RPMw?=
 =?iso-8859-1?Q?U8T1Qy3ntVMZwG76Fuzly6a3BPkFalRzVytQbxF05hSrDQAYl0cgMAkfcD?=
 =?iso-8859-1?Q?E3rkse/jrV4vNK4wlRIFntvShTDhSXZolMrVvyyGGGmPMnNFILFGTPODu6?=
 =?iso-8859-1?Q?Q94IWcPin7uhO03/NeMTCQxYIbiPe+NCYSNGSdAM8zPi58PJU/KLspnIf3?=
 =?iso-8859-1?Q?FGAKKuyAXwJUTf1uUZJ1EZz/FR8U3TFAifyyts3tf28OPa1ehXkrf4l6uR?=
 =?iso-8859-1?Q?/wHUVY21F7N6MmTO8bw7lc7xeGtE5kU9/IAU1mF9BR6YXeTFW59/TqOjQN?=
 =?iso-8859-1?Q?EP6UogXcSbbZVIHJldEtUu+xpwLXK6IdOvGkPC5st/ULKtl6pkVQu0c22R?=
 =?iso-8859-1?Q?rLVD0b0xUqFLBuEr83NN5gL6d2ByR29qmHtVI6EJoirjXsUuhdnFrAn5wF?=
 =?iso-8859-1?Q?GlmxuVZwxH+t7018jTuDJblq2cmrEC/PDFEqlibSZayLwJKnCbSdTeOe3p?=
 =?iso-8859-1?Q?k/IsybqMemvDQJaG96pCw0JFFMjfeblip3wAIjpeP98hPHrQG/VkT+/27U?=
 =?iso-8859-1?Q?a6+sdvzUf1CQhjNMQ/t7HgMQEOJ0N88FdG+p+hBl5Wz4wI8tCykCzF9GJu?=
 =?iso-8859-1?Q?54uMTr3Kkv+DzDs68MvJlebcrEKT/Wi+4LpI4qSUjCS9D8ZO1y/ddrTY+g?=
 =?iso-8859-1?Q?LGLFiV8HIfpPoRB8puRZDr2cNe2olTYUQMdJZ2jiVOwkO8kXr62+Obh30V?=
 =?iso-8859-1?Q?LAxzFb/p2sOjsfG1l4eFzx9HUInl+x1h9/K1kKNy/D54vWz0wCMbSMmTKR?=
 =?iso-8859-1?Q?N93hdrDTTuA90YOl7cdMkzLiR885/3V2FmevM6CjcK7lj7YBzxLvQ5wRgv?=
 =?iso-8859-1?Q?3UQq0Y8626drT88XU4NS6pbye5CFkDZ68UTCaaMJad1xGpD4ZPEExQPpcV?=
 =?iso-8859-1?Q?B04csyw2OSMEB0SFzZ1DHtrmLlqqigyelJlA0pnfrS0LksQWQNBZ/Ris37?=
 =?iso-8859-1?Q?lbZy5cyG4hI78Ce7lUkfRorh4rjg+MPBpKJbiDKfhOqLkoDKGovVH3e2EK?=
 =?iso-8859-1?Q?hLHt/o5xCCrjgAgyYHsHG5JZ95Z0KQu7FfA9pEwFpQut1Wd2mGbv7Tjnjq?=
 =?iso-8859-1?Q?9x5oKQxyo7/k4dxcq8kdSo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lFKSma0XlWcvKtH+iyNtnU7NakR+v3AH/XT7YCnIDfxJQqwMjKej2kEILj?=
 =?iso-8859-1?Q?8whhjLTe4wZGIpw52prWsnViwTPekt64N6Kh/x3zpIXO3H3gWuVm+6cqWy?=
 =?iso-8859-1?Q?0A2E+XI2KY6bqmKfuZhO0B3xs6RTbA9IaNUIFaOSHg6JrawPTUqwXVUqWd?=
 =?iso-8859-1?Q?vSDCaijvHBQQQsLpw3HTjFDfA76V80kDK0i8A9cmqbwFdko+lWCZ3MI0VA?=
 =?iso-8859-1?Q?h+MBZOCbIzPgIJZj+cRYNdOFXJOBdID1qUoNotbhL6ZOpGtW7+Kr8VnUw7?=
 =?iso-8859-1?Q?qncEcmtssn5JiElSC4YBH/cuQPe05XgVqQGNfl5WVQDc54G9LNipC+yF8S?=
 =?iso-8859-1?Q?0njiZqPeMhmKPqi9uUnJYj8ghhCUrFECMoomxBsCcUkFOLGZEUDwE6g/8i?=
 =?iso-8859-1?Q?UynR87VBOjS/On7SJDfxQ7n9egQmWl+WKNIhfiZzJ787Hvwr13V1r0SEgT?=
 =?iso-8859-1?Q?HQuYLeKH2ZiR5uHlTjV6VEjEJ+ba+B/sRH1SowWlv2xP+Lt49MAU3VeH5I?=
 =?iso-8859-1?Q?H7elHM4Nfw+HmCstUkpXezMfAfzAlAA32hVgQV2JPcgx0L3vQiqVCTz0xK?=
 =?iso-8859-1?Q?nlUNLlXoJm3tAN0HyPqFD4cLs2737uDoZJa6n/cyPOjfpUTV89WW+2VcT7?=
 =?iso-8859-1?Q?jKy3xbuDxAe40e0kLPxSXUzbS9+0qtkQp2Ks0rJRcIGGwUxzbod+B1jHGx?=
 =?iso-8859-1?Q?trC+VyIWOB9dnxC5rd3iQ3v0zcOHTJg8yPA4B6g3rwCLSNP/DRQ8ze87wV?=
 =?iso-8859-1?Q?7PGPodK1NhHqzhwNUpwPGjr6K241fZ+ckkObx67g1qGN5HC3r3xy1djcf0?=
 =?iso-8859-1?Q?tPgI7gcY2V4paGuSWjoMR0prdB6LC4Njy3+TLlgUAvn82w+OSfyuufBJaX?=
 =?iso-8859-1?Q?3o0gDwTH7X9CyRd8Ulf310ACqyjhqMA2RrJi+yHJMSHb+sLOqoSoyGrtIY?=
 =?iso-8859-1?Q?Mo3K2qk0UUlf2vXxUhjAP/lnPANaWI1pkq+ejLKsUXDC9KZnrxjBYVpyqs?=
 =?iso-8859-1?Q?3LQcBcLYvmJRgm/kXqK4koiraFosw8jRYjzTj5HyPa7nxsFexJ6AsJl8yx?=
 =?iso-8859-1?Q?1ORRmYPfynxC0Lfzh3WoVwOqY+UcI4SRd4l5l7PLKesFugQ/MtRgyK/9kC?=
 =?iso-8859-1?Q?GZjFEBkK5Nzc7A1TbgT8RgCK7Fh/PLH2+U1ZIF2oExpjKzNuu3R6x7Spqu?=
 =?iso-8859-1?Q?5hPZUp4BJ3euWyW9n7tt/pin15lc259UkuEzZwV04Fd6v3HbtaApTk1MMF?=
 =?iso-8859-1?Q?+p8+PTcQywj2NZUvlbqsnA9u8zI1SiqW6bMQQYUXPi/oAapDZhqGS1lZNo?=
 =?iso-8859-1?Q?IawuSzYfSF5PSvWAPn7JCBE8g0RED0qexnouKsxgIKv5sQnl7YhgdDieN4?=
 =?iso-8859-1?Q?6sqfU+BO03xiXCDFO5M5PSPGQOLIjHJvfDhC+3XIp8fWm+JwRlOp2OeE1t?=
 =?iso-8859-1?Q?sFYnRcXJ0WTpeVKZ46DcNx1/xPN4l1N55tYu0dHkaW09Nqf9Hj8ZDXeOWD?=
 =?iso-8859-1?Q?ef/PoJ5JpwgBFctLkIL8Ljjln0ddpa2oMpeWtp3Vu2ypUsbu7DGPyS5A5n?=
 =?iso-8859-1?Q?y4Jo8vymi1UwKdCOrsEj9ixNdD/EDsHXRXecV35EQbswFu7bvvvz1V5SNq?=
 =?iso-8859-1?Q?Ofhe6HIwTHH3Y=3D?=
Content-Type: multipart/alternative;
 boundary="_000_LV2PR12MB57742F35070256D43D131F23F9D52LV2PR12MB5774namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29773ccb-1a42-41da-1a53-08dd5d57f2df
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 09:10:47.4127 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OeVmc7k+3mY252oTlLa2GYu9TKmBdT7FDMIfWvf7d2lyM+LPtQndAWUDHg+XKbUR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
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

--_000_LV2PR12MB57742F35070256D43D131F23F9D52LV2PR12MB5774namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Felix,

Thanks. Patch v2 is submitted. It should make sure error returned even if r=
emove_queue_mes is success.

Could you pleas help to review it again?


Thanks.



Best regard,

Yifan Zha



________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Thursday, March 6, 2025 8:23 AM
To: Zha, YiFan(Even) <Yifan.Zha@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com=
>; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Chang, HaiJun <HaiJun.Chang@amd.com>; Chen, Horace <Horace.Chen@amd.com=
>; Yin, ZhenGuo (Chris) <ZhenGuo.Yin@amd.com>
Subject: Re: [PATCH] drm/amd/amdkfd: Evict all queues even HWS remove queue=
 failed


On 2025-03-05 00:42, Yifan Zha wrote:
> [Why]
> If reset is detected and kfd need to evict working queues, HWS moving que=
ue will be failed.
> Then remaining queues are not evicted and in active state.
>
> After reset done, kfd uses HWS to termination remaining activated queues =
but HWS is resetted.
> So remove queue will be failed again.
>
> [How]
> Keep removing all queues even if HWS returns failed.
> It will not affect cpsch as it checks reset_domain->sem.
>
> Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index f3f2fd6ee65c..b213a845bd5b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1223,7 +1223,6 @@ static int evict_process_queues_cpsch(struct device=
_queue_manager *dqm,
>                        if (retval) {
>                                dev_err(dev, "Failed to evict queue %d\n",
>                                        q->properties.queue_id);
> -                             goto out;

Is every subsequent call to remove_queue_mes guaranteed to also return
an error? If not, you need a way to make sure an error is returned if
any queue failed to be removed even if the last queue succeeded.

Regards,
   Felix


>                        }
>                }
>        }

--_000_LV2PR12MB57742F35070256D43D131F23F9D52LV2PR12MB5774namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hi Felix,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Thanks. Patch v2 is submitted. It should make sure error returned even if r=
emove_queue_mes is success.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Could you pleas help to review it again?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" id=3D"Signature">
<p>Thanks.</p>
<p>&nbsp;</p>
<p>Best regard,</p>
<p>Yifan Zha</p>
<p>&nbsp;</p>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:11pt; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling@amd.com&gt;<br>
<b>Sent:</b> Thursday, March 6, 2025 8:23 AM<br>
<b>To:</b> Zha, YiFan(Even) &lt;Yifan.Zha@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;; Deucher, Alexander &lt;Ale=
xander.Deucher@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br=
>
<b>Cc:</b> Chang, HaiJun &lt;HaiJun.Chang@amd.com&gt;; Chen, Horace &lt;Hor=
ace.Chen@amd.com&gt;; Yin, ZhenGuo (Chris) &lt;ZhenGuo.Yin@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/amdkfd: Evict all queues even HWS remov=
e queue failed</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText"><br>
On 2025-03-05 00:42, Yifan Zha wrote:<br>
&gt; [Why]<br>
&gt; If reset is detected and kfd need to evict working queues, HWS moving =
queue will be failed.<br>
&gt; Then remaining queues are not evicted and in active state.<br>
&gt;<br>
&gt; After reset done, kfd uses HWS to termination remaining activated queu=
es but HWS is resetted.<br>
&gt; So remove queue will be failed again.<br>
&gt;<br>
&gt; [How]<br>
&gt; Keep removing all queues even if HWS returns failed.<br>
&gt; It will not affect cpsch as it checks reset_domain-&gt;sem.<br>
&gt;<br>
&gt; Signed-off-by: Yifan Zha &lt;Yifan.Zha@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 1 =
-<br>
&gt;&nbsp;&nbsp; 1 file changed, 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/d=
rivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; index f3f2fd6ee65c..b213a845bd5b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; @@ -1223,7 +1223,6 @@ static int evict_process_queues_cpsch(struct dev=
ice_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret=
val) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev, &quot;Failed to evict=
 queue %d\n&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; q-&gt;properties.queue_id);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
<br>
Is every subsequent call to remove_queue_mes guaranteed to also return <br>
an error? If not, you need a way to make sure an error is returned if <br>
any queue failed to be removed even if the last queue succeeded.<br>
<br>
Regards,<br>
&nbsp;&nbsp; Felix<br>
<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_LV2PR12MB57742F35070256D43D131F23F9D52LV2PR12MB5774namp_--
