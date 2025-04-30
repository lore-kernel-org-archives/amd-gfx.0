Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19873C369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 10:30:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A593910E010;
	Wed, 30 Apr 2025 10:30:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0xqkffVa";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17FA810E010
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 10:30:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxA4x9oH5QFzi3M81Fcyb9YIDN8KRp0QLOcLdcyGCXtPqorFJm5cYRGkJrR9lrFeODhz0xXGKI6eqpKKlE12UtC+ncq2/TAMz2fBbnqm0pPyiSJ+egaAQOLNAyHU5Vl9We18fhEYz/Sy5TZIq46i5u31zVj7H75TTRyKEYuyMQ1V2tXODy8q13Fx8EBudWV1vIdjzvfQ39KG/8WwpaSKFVu3jv3P14pFWOTp8b9KwJvZGCHdNL4mKONOm1vMUXQo5gwUP5YhweVcfUf7S2jA6rCtaOQnhWMgoTuEBnjPOKaT2Hxt8HT3tSvfSU9nKcfiTfISq/jKec1q3k5mc4XGRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsDt5yBUPSQaks3UQBrTHKi4XDb5eDWjuxQDRx9zYa4=;
 b=j2dxnQTqH0Zb1ANP0aBA0ixJF/ptibsG55tk+e0i7Ympf/CD+NHOdprtfw+izJxefSa9QZGanKFVD0ApqBhhn6hKxwgmkJvCLVK8P3eyQoNj2iDWSPf91B3O8SP7Wt8dFNcxE3pa5RMlblThV4qGVXAYnumvPN7DGJ8mmV1ajRlMwWVHRw+r8T6/DIS1FlIUwXxAAxkd/vAQ0oV9zNPYs3Sd+sjKlhd/5NerdOECFVcU4OS2eE2dkua9iuxscOysemEtT1wUi+gmBnpBsNTtfjMaTv5Lmo7Sd73syC0qoEQUD1l8YMzMkGw3G5GoAefqQhR9I0dvjDrt27/e1OIKJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsDt5yBUPSQaks3UQBrTHKi4XDb5eDWjuxQDRx9zYa4=;
 b=0xqkffVadOvC5HUy63GZK05ACytiUdps6AunsV+pCRngLcqxsDJ382qpFKmSL0RoxCojGLRKEFJ33YMwwgr7wzxLa6wzY3J/Q+/YFHDVqXKzzwubS+dWkFuZ3pp8Di0ZzI8LBwH50XEhD54019Ub+8C0/JyNvZTLFvTbuirfnH0=
Received: from DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) by
 SN7PR12MB7420.namprd12.prod.outlook.com (2603:10b6:806:2a7::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.19; Wed, 30 Apr 2025 10:30:44 +0000
Received: from DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba]) by DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba%7]) with mapi id 15.20.8678.025; Wed, 30 Apr 2025
 10:30:43 +0000
From: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 =?Windows-1252?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
CC: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>, "Zhang,
 Owen(SRDC)" <Owen.Zhang2@amd.com>
Subject: Re: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Thread-Topic: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Thread-Index: AQHbrSrMwUAwzOUgZU6XmBWROciIM7OmUzmAgAqRErSAAUWPNIAG3YiAgAMSuIY=
Date: Wed, 30 Apr 2025 10:30:41 +0000
Message-ID: <DM4PR12MB59371BD09A8FCA16D24B7289E5832@DM4PR12MB5937.namprd12.prod.outlook.com>
References: <20250414104655.336497-1-guoqing.zhang@amd.com>
 <20250414104655.336497-5-guoqing.zhang@amd.com>
 <0a885441-fea1-4ac7-aef4-9761f24b2b33@gmail.com>
 <DM4PR12MB59376B41F123C09AB3DDDF7EE5BA2@DM4PR12MB5937.namprd12.prod.outlook.com>
 <DM4PR12MB59373CD6217D0B56CBFA09D1E5852@DM4PR12MB5937.namprd12.prod.outlook.com>
 <bb36cfc2-fbbc-4128-9ebf-dd574c61d950@amd.com>
In-Reply-To: <bb36cfc2-fbbc-4128-9ebf-dd574c61d950@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-30T10:25:39.2988847Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5937:EE_|SN7PR12MB7420:EE_
x-ms-office365-filtering-correlation-id: f4f38917-c968-4e05-e402-08dd87d20ff5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?tHkuIqKhsJZgJNxnsH0sCGb+LLWAPRNSsZLGO5CYBBMQF4dVTvMjcpP9?=
 =?Windows-1252?Q?Ns+9zc4MHeU8xas7AnSJM0OZ7pmKubs0NA00KEGzuUnISdBEtKg77W2R?=
 =?Windows-1252?Q?cb7JI/yDQcPnPIgVp478vuV4BcLGZdUQoKY/pd+raqtuejVCH0Fzb1tU?=
 =?Windows-1252?Q?7Awf/KPAsxoihXu/idgfDGBJqFsg9I4JkgtQae6H95Q9ywp7ChQnAqoX?=
 =?Windows-1252?Q?32/Rx6610qK+0jRsNdtriarzlresKqwFI6b54hDCfWbJtTPYrzVKGLCz?=
 =?Windows-1252?Q?dKPiNmy87qBKFiEzzZqbv82RLDqufiLsbrIB3EaPq5BPsKFXwAZQt8yM?=
 =?Windows-1252?Q?t0shCR1uIhwkenWfYLkbJOcI7tySSbqzNvPXJdfXeO8HFG/+hTaVbvYt?=
 =?Windows-1252?Q?RzbM5XTDcOy0Wlm/IKTomVU/8WDi3TU6BZsDvcGZyhB7TLWEvXZXaVno?=
 =?Windows-1252?Q?X7TROuxx233OMgVaZC1JU4AoOoo6wEVYsWcKqVSQI3ZcHJFsG+z1pKuc?=
 =?Windows-1252?Q?1JPGNi+y0TPtI8/E+ab3Zu7ZVnbq5P9ytE5r4m0KcJ3h78WgEyy5USq0?=
 =?Windows-1252?Q?zqVbPqaq0KySG87WdQFfD0/XjN3aRggn3rJCWZlmOOIWKQbvOxJlCXWN?=
 =?Windows-1252?Q?pP1J4DU52Rc7/9wvjngs8OQ1PeyzTE/80Pzpu3YM2cjjlHb5tuaewm6p?=
 =?Windows-1252?Q?XB+b9C0XkWCrDE7fe4E/1oJAqYP5WVI9oaarKQGn3fUcylHNXeR9x28v?=
 =?Windows-1252?Q?UZGDehHLRcpsWLZVTJsZrG/+05xmlgngVUqO1iZYyObG0eNqKKjrnoDE?=
 =?Windows-1252?Q?thuj1IEm0wl2PFnyGN1ZJo5j5ZKmJoY3zW2KfiS1NDVpl7xbrHYO0cQU?=
 =?Windows-1252?Q?r1F5+1irnGXzfI6PKQKY+27kOdQkptNiR5tQX6pnaot5dIL3Ppgr+Ifv?=
 =?Windows-1252?Q?c/tf8bFQitH0EiEiYpLSRxCME/WjYWUQzGeln1o6E56oWl5oris9ICGn?=
 =?Windows-1252?Q?tt/gtG9TqUl6imLbwZzMqPPljxiSdYWxPgiPjceUg3h2oAJmRiJ1wLAf?=
 =?Windows-1252?Q?fgRiSRCjumvxM9Y2iB67M5mGSy1zu+Liow2qZZUpWFFMU5ln4ux4Jmc7?=
 =?Windows-1252?Q?jShwxLNBN7sgRrsLaBtgLMCa2FlgyJknWbl5mhLFpQ+7Yde0QdYm/aYP?=
 =?Windows-1252?Q?x8WaxN98faapMTtmt4lvvtDftx4tjXBPxJXy41XpkHIOJ3rx8P84IHJH?=
 =?Windows-1252?Q?91RuF7NM9dVNbFV4x90vrCLUIPXUVvKZ+OVDR9prECMJMCvyCjQBXEum?=
 =?Windows-1252?Q?A6Fz+B66mfqaIwB6BPoui/Bevw2zzgwssSfgQ35ti7t9W8irrKQEAJm8?=
 =?Windows-1252?Q?Pg1X9sC/7XWumxO4RvMMgkh7yfKocP6ivHBSav6cnZ301OuaIXP9EfiL?=
 =?Windows-1252?Q?ye/Xzm/K6Gw7ANhGcgTxfJ5KpeZRbdF/nf9fz1HdU2fnZW1JtiEukBOG?=
 =?Windows-1252?Q?MhX3v6uqdt4DyKfQo6lcOPr9TBqUS+zvkWF9lmkPp31RqyLEOITst6Dj?=
 =?Windows-1252?Q?KEhW9DNlhK9ADt71KbNFs82FgLEgXP5c+h7UxYlUqK1HrXNjSAA7rQD/?=
 =?Windows-1252?Q?7Mw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5937.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?V4MNy11HnucTDRYy5FyhC7/uaUVjaygTLczE/OYIzSYMlo4Iqb+7NAIH?=
 =?Windows-1252?Q?cJXiDHVZewc6w+qprb8y2QAKgP2PLXmmGUifrPtQ8ORmx5bnTTW2J5t1?=
 =?Windows-1252?Q?8H35Ncies+FKcIaHEyOdQBVmhiDabDZvREJfFJSjujXOzcgdUeswdLX3?=
 =?Windows-1252?Q?RzfQp/yQU9vwyW9rfmk9PQA779UQvrfrEH7EWRns1jv2tRXuurUTHRcG?=
 =?Windows-1252?Q?NQIKDHhcMhuQ4O1gSjDRV84tkG702UZBCdrS7vdjMMFVkdbrXrGhuuIP?=
 =?Windows-1252?Q?wAxVlVV+6W9nTlE1L6e4+33ZB5IELIg/8/K7bfV70FnzX0GbnWxDHA7a?=
 =?Windows-1252?Q?8Yly71uWr+ezv9tli0PVCpcFIZuaXM+6d7czeeLRd/JkAml0hgiMpkXJ?=
 =?Windows-1252?Q?zyU9MkX0ncfRfjTeDORTQwsUyyiNjTNT5oXPpsTGH+tMJKDA8e+4txaD?=
 =?Windows-1252?Q?EFbOQcAxbxcGZOHlc7JSUehfj8Mo5s3RCfDmZO/7a+HgqlGVnoZJEqf1?=
 =?Windows-1252?Q?WuIYjxVSPCtiDB+y3t+Ya19ppxHhk7TJjELg77v3BEsGv6xamjckC2ux?=
 =?Windows-1252?Q?rA4whDHxB5op0FYrzCWx32XC9xFFChtaJNIJxVSrDDxwd9heKWpJ68Cp?=
 =?Windows-1252?Q?7oNV35lqFe8FyLBsKpUrteN6Zz9jhP4ZQ4GUbGAwBmxmR6Qg6bn7EMhD?=
 =?Windows-1252?Q?frdiCVVNQpTBl+i4jo7ePWd0gw+wRtekh6e/QM6FUGmX88Q407ivIRVr?=
 =?Windows-1252?Q?OBE6GC/FWSAT9hvu9k12gzL2DhH1AhVF5BGoemIWpa1WTu74fxeqBXuz?=
 =?Windows-1252?Q?atEotD7e6ZJ6POmiaWzh2cGrEiGi+rQXtZh1XhsNoCNh10M8FAabQpNR?=
 =?Windows-1252?Q?5XuMAy3Cb+W53u0b6z+sG4/lIcnBbSiHIg/V6hlO0aEgo3vgZSm6jA4H?=
 =?Windows-1252?Q?q8vKAjceUYSV+hYJI59kaZmukDcYQfr283xYnTX7Qy19KDZJYtGQ4CRI?=
 =?Windows-1252?Q?DVYsEo7LspJJSua+f7vh7paEH/5DOE9sQVMwY5vI/RlMGCQwuo2Pappc?=
 =?Windows-1252?Q?n3AEJecc/TiQphlGc2ZqO2kpVypfzb/+tRRU3aKABktEl0KY4JMZq9S3?=
 =?Windows-1252?Q?gRVJmw5qtoivw6sPOqLFZqynJo+Tvn94jiCRJiSAZcEATSYKd4UqQ/oI?=
 =?Windows-1252?Q?FNYUcPmWhXo8g1bhWoaQ3oG0i68bcVzBwkOcK2eCfbp2nEeFycTtazkW?=
 =?Windows-1252?Q?xCG69K3Rqs+qbIODjXqOvaRzLhU6LuiqxBWpVoMJl2FYKa+3wbI0XkKM?=
 =?Windows-1252?Q?BG25oSpmHJtLP0Yddb1jmeW4qI30S5YE2pHiG08BoGXVAcAKmH7aZYKg?=
 =?Windows-1252?Q?FNUe7j8SznQXBMWbpo5uwYB/z7cL0fTW0OOsjd+VbcDFf1ul+b4M6WNN?=
 =?Windows-1252?Q?e9jb4eMFhAyxZS53XU6E8Y5ELy1hXyH6B+3tX5iiBKZSP98ISQPBwRoU?=
 =?Windows-1252?Q?YB66e6WBD9vWK8wEpT3Lm/3p2GFuKeyLNTukMLMbAxv2J+WTdKKAcWK8?=
 =?Windows-1252?Q?+fS6EQ1dEl9uqSvEig9FEDMdJWFYBKmaJXQR1m9ToK2Gn5ITQXru3q4p?=
 =?Windows-1252?Q?b3cJi1RQ/jEptpsDCdvLjjGaBW+9uxc8KgQs9/1qaQGg2qrEXeB2fmwU?=
 =?Windows-1252?Q?nde73Dkhm91md4xqVT04G1XJTLrH8MKQ?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB59371BD09A8FCA16D24B7289E5832DM4PR12MB5937namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f38917-c968-4e05-e402-08dd87d20ff5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 10:30:43.6661 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fUEplqtC++eQJuex0bhfguVL1nbxYssrkkWGLJfsJms2T/DrEAvr+8sdcANqAyAzm63OSJMLv+I0mnRPMlyNmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7420
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

--_000_DM4PR12MB59371BD09A8FCA16D24B7289E5832DM4PR12MB5937namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi @Koenig, Christian<mailto:Christian.Koenig@amd.com>,

Thank you for the feedback. I have revised the patch according to your sugg=
estions and sent out the v2 patch list. Please help review. Thank you!

mail titles of v2 patchlist:
[PATCH v2 0/3] enable switching to new gpu index for hibernate on SRIOV.
[PATCH v2 1/3] drm/amdgpu: update XGMI physical node id and GMC configs on =
resume
[PATCH v2 2/3] drm/amdgpu: update GPU addresses for SMU and PSP
[PATCH v2 3/3] drm/amdgpu: enable pdb0 for hibernation on SRIOV

Regards
Sam

From: Koenig, Christian <Christian.Koenig@amd.com>
Date: Monday, April 28, 2025 at 19:30
To: Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com>, Christian K=F6nig <ckoeni=
g.leichtzumerken@gmail.com>, amd-gfx@lists.freedesktop.org <amd-gfx@lists.f=
reedesktop.org>, Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Zhao, Victor <Victor.Zhao@amd.com>, Chang, HaiJun <HaiJun.Chang@amd.com=
>, Deng, Emily <Emily.Deng@amd.com>, Zhang, Owen(SRDC) <Owen.Zhang2@amd.com=
>
Subject: Re: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on SRIOV
On 4/24/25 05:38, Zhang, GuoQing (Sam) wrote:
> Hi Christian,
>
> Thank you for the review and the feedback.I will update the patch accordi=
ng to
> your feedback.
>
> Please see my 2 inline comments below.

Please make sure to always CC my work mail address, otherwise I will only t=
ake a look the next time I work through the mailing lists.
>
>> > index d90e9daf5a50..83a3444c69d9 100644
>
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>
>> > @@ -287,8 +287,14 @@ int amdgpu_bo_create_reserved(struct amdgpu_devic=
e *adev,
>
>> >                goto error_unpin;
>
>> >        }
>
>> >
>
>> > -     if (gpu_addr)
>
>> > +     if (gpu_addr) {
>
>> >                *gpu_addr =3D amdgpu_bo_gpu_offset(*bo_ptr);
>
>> > +             if (!adev->gmc.xgmi.connected_to_cpu && adev->gmc.enable=
_pdb0) {
>
>> > +                     if ((*bo_ptr)->tbo.resource->mem_type =3D=3D TTM=
_PL_VRAM) {
>
>> > +                             *gpu_addr -=3D amdgpu_ttm_domain_start(a=
dev, TTM_PL_VRAM);
>
>> > +                     }
>
>> > +             }
>
>> > +     }
>
>>
>
>> Please NAK to that approach here. The GPU offset should still point into=
 the mapped VRAM.
>
> This change is to change to the default GPU address from FB aperture type=
 to
> pdb0 type in this centralized place so that I don=92t need to change ever=
y
> callsite of amdgpu_bo_create_reserved().
>
> Could you suggest a better approach if this approach is not acceptable?


The whole code is completely superflous. When PDB0 is used the vram_start i=
s adjusted and you don't need to do anything here.

See function amdgpu_gmc_sysvm_location(). You probably need to adjust that =
to have a static setup instead of using the XGMI node infos.


>> > @@ -1719,6 +1723,14 @@ static void gmc_v9_0_vram_gtt_location(struct a=
mdgpu_device *adev,
>
>> >  {
>
>> >        u64 base =3D adev->mmhub.funcs->get_fb_location(adev);
>
>> >
>
>> > +     if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.enable_pdb0) {
>
>> > +             adev->gmc.vmid0_page_table_depth =3D 1;
>
>> > +             adev->gmc.vmid0_page_table_block_size =3D 12;
>
>> > +     } else {
>
>> > +             adev->gmc.vmid0_page_table_depth =3D 0;
>
>> > +             adev->gmc.vmid0_page_table_block_size =3D 0;
>
>> > +     }
>
>> > +
>
>>
>
>> What is the justification to moving that stuff around?
>
> vmid0_page_table_block_size is used in new code in amdgpu_gmc_sysvm_locat=
ion().
> See the call sequence below.
>
> gmc_v9_0_sw_init
>
> - gmc_v9_0_mc_init
>
>                  - gmc_v9_0_vram_gtt_location,
>
>                                  - vmid0_page_table_block_size =3D 12, **=
new
> location**
>
>                                  - amdgpu_gmc_sysvm_location
>
>                                                  - use
> **vmid0_page_table_block_size**
>
> - gmc_v9_0_gart_init,
>
>                  - assign vmid0_page_table_block_size, **old location**


That is noteven remotely corect.

See the code in gmc_v9_0_vram_gtt_location(). You use amdgpu_gmc_sysvm_loca=
tion() when PDB0 is allocted and you use gmc_v9_0_vram_gtt_location() when =
it isn't.

But adjusting this function here doesn't make any sense at all.

Regards,
Christian.

--_000_DM4PR12MB59371BD09A8FCA16D24B7289E5832DM4PR12MB5937namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-CN" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Hi
<a id=3D"OWAAMD5EB853895CF064988F720901BE37DA9" href=3D"mailto:Christian.Ko=
enig@amd.com">
<span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decoration:non=
e">@Koenig, Christian</span></a>,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Thank you for the feedback. I have revised the patch ac=
cording to your suggestions and sent out the v2 patch list. Please help rev=
iew. Thank you!<br>
<br>
mail titles of v2 patchlist:<br>
[PATCH v2 0/3] enable switching to new gpu index for hibernate on SRIOV.<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">[PATCH v2 1/3] drm/amdgpu: update XGMI physical node id=
 and GMC configs on resume<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">[PATCH v2 2/3] drm/amdgpu: update GPU addresses for SMU=
 and PSP<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">[PATCH v2 3/3] drm/amdgpu: enable pdb0 for hibernation =
on SRIOV<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Regards<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Sam<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">From:
</span></b><span style=3D"font-size:12.0pt;font-family:&quot;Aptos&quot;,sa=
ns-serif;color:black">Koenig, Christian &lt;Christian.Koenig@amd.com&gt;<br=
>
<b>Date: </b>Monday, April 28, 2025 at 19:30<br>
<b>To: </b>Zhang, GuoQing (Sam) &lt;GuoQing.Zhang@amd.com&gt;, Christian K=
=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;, amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;, Deucher, Alexander &lt;Alexander=
.Deucher@amd.com&gt;<br>
<b>Cc: </b>Zhao, Victor &lt;Victor.Zhao@amd.com&gt;, Chang, HaiJun &lt;HaiJ=
un.Chang@amd.com&gt;, Deng, Emily &lt;Emily.Deng@amd.com&gt;, Zhang, Owen(S=
RDC) &lt;Owen.Zhang2@amd.com&gt;<br>
<b>Subject: </b>Re: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on =
SRIOV<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">On 4/24/25 05:38, Zha=
ng, GuoQing (Sam) wrote:<br>
&gt; Hi Christian,<br>
&gt; <br>
&gt; Thank you for the review and the feedback.I will update the patch acco=
rding to <br>
&gt; your feedback.<br>
&gt; <br>
&gt; Please see my 2 inline comments below.<br>
<br>
Please make sure to always CC my work mail address, otherwise I will only t=
ake a look the next time I work through the mailing lists.<br>
&gt; <br>
&gt;&gt; &gt; index d90e9daf5a50..83a3444c69d9 100644<br>
&gt; <br>
&gt;&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; <br>
&gt;&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; <br>
&gt;&gt; &gt; @@ -287,8 +287,14 @@ int amdgpu_bo_create_reserved(struct amd=
gpu_device *adev,<br>
&gt; <br>
&gt;&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_unpin;<br>
&gt; <br>
&gt;&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt;&gt; &gt;&nbsp; <br>
&gt; <br>
&gt;&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (gpu_addr)<br>
&gt; <br>
&gt;&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (gpu_addr) {<br>
&gt; <br>
&gt;&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; *gpu_addr =3D amdgpu_bo_gpu_offset(*bo_ptr);<b=
r>
&gt; <br>
&gt;&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (!adev-&gt;gmc.xgmi.connected_to_cpu &amp;&amp; adev-&gt;gm=
c.enable_pdb0) {<br>
&gt; <br>
&gt;&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((*bo_ptr)-=
&gt;tbo.resource-&gt;mem_type =3D=3D TTM_PL_VRAM) {<br>
&gt; <br>
&gt;&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gpu_addr -=3D amdgpu_ttm_domain_start(ad=
ev, TTM_PL_VRAM);<br>
&gt; <br>
&gt;&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt;&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }<br>
&gt; <br>
&gt;&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt;&gt; <br>
&gt; <br>
&gt;&gt; Please NAK to that approach here. The GPU offset should still poin=
t into the mapped VRAM.<br>
&gt; <br>
&gt; This change is to change to the default GPU address from FB aperture t=
ype to <br>
&gt; pdb0 type in this centralized place so that I don=92t need to change e=
very <br>
&gt; callsite of amdgpu_bo_create_reserved().<br>
&gt; <br>
&gt; Could you suggest a better approach if this approach is not acceptable=
?<br>
<br>
<br>
The whole code is completely superflous. When PDB0 is used the vram_start i=
s adjusted and you don't need to do anything here.<br>
<br>
See function amdgpu_gmc_sysvm_location(). You probably need to adjust that =
to have a static setup instead of using the XGMI node infos.<br>
<br>
<br>
&gt;&gt; &gt; @@ -1719,6 +1723,14 @@ static void gmc_v9_0_vram_gtt_location=
(struct amdgpu_device *adev,<br>
&gt; <br>
&gt;&gt; &gt;&nbsp; {<br>
&gt; <br>
&gt;&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 base =3D adev-&=
gt;mmhub.funcs-&gt;get_fb_location(adev);<br>
&gt; <br>
&gt;&gt; &gt;&nbsp; <br>
&gt; <br>
&gt;&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to_=
cpu || adev-&gt;gmc.enable_pdb0) {<br>
&gt; <br>
&gt;&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; adev-&gt;gmc.vmid0_page_table_depth =3D 1;<br>
&gt; <br>
&gt;&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; adev-&gt;gmc.vmid0_page_table_block_size =3D 12;<br>
&gt; <br>
&gt;&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; <br>
&gt;&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; adev-&gt;gmc.vmid0_page_table_depth =3D 0;<br>
&gt; <br>
&gt;&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; adev-&gt;gmc.vmid0_page_table_block_size =3D 0;<br>
&gt; <br>
&gt;&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt;&gt; &gt; +<br>
&gt; <br>
&gt;&gt; <br>
&gt; <br>
&gt;&gt; What is the justification to moving that stuff around?<br>
&gt; <br>
&gt; vmid0_page_table_block_size is used in new code in amdgpu_gmc_sysvm_lo=
cation().
<br>
&gt; See the call sequence below.<br>
&gt; <br>
&gt; gmc_v9_0_sw_init<br>
&gt; <br>
&gt; - gmc_v9_0_mc_init<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - gmc_v9_0_vram_gtt_location,<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - vmid0_page_table_blo=
ck_size =3D 12, **new <br>
&gt; location**<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - amdgpu_gmc_sysvm_loc=
ation<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -=
 use <br>
&gt; **vmid0_page_table_block_size**<br>
&gt; <br>
&gt; - gmc_v9_0_gart_init,<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - assign vmid0_page_table_block_size, **old=
 location**<br>
<br>
<br>
That is noteven remotely corect.<br>
<br>
See the code in gmc_v9_0_vram_gtt_location(). You use amdgpu_gmc_sysvm_loca=
tion() when PDB0 is allocted and you use gmc_v9_0_vram_gtt_location() when =
it isn't.<br>
<br>
But adjusting this function here doesn't make any sense at all.<br>
<br>
Regards,<br>
Christian.</p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB59371BD09A8FCA16D24B7289E5832DM4PR12MB5937namp_--
