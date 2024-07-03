Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D23C30653
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 08:22:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AAD810E75E;
	Wed,  3 Jul 2024 08:22:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GaohjEL2";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3B3C10E75E
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 08:22:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TertfLB7TqDazXZR1dCJAckS65E3pfqrzDKNSIJL9y6wldQEaKiajXwVULNJVJ4Okqyxm3DFM4M951S6LTlerpAcIdYZXhEuy9lEXr9vG2PYqvtbwcsov4aOsEG35G/5vRCQjfkJYuRn4i0FxWpBD2LZAeUD6SuB/RbLNZZOmJ7V8V4o/GAYYxLN/CsaHO+uPx5QvELTKbnddGJreSWfl61ttefMRcXorlYFQwZabaZ5+4LPZlMhdbpz2sdHgE5owa11QMIVsOS12oUKEtTntbjLiccMyCJZtSGKDDHCQgK2/Uc57dP0DvxGFLGPtWr6RSlhIS4liUWZeG7238HSkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4P9si9F4DUFS8QJFkWqR/MRHbeqH/ApO4ZvCTGt2VLU=;
 b=MfHA9Xg+rxpP/aN9X7gH/xbUf3YhMg2orFs3/xtpiV8QsSYLPy9S6GFVsR99DaxwDpCED3S9S8j1ywYi7GmxC8tT+jLoiNnCucoNhP01EvsNvRUyggtWZKLGDRoBlYfgJgpkh3xZnAW0H2Qil0LDVXw0Mq/0uzZ/ftO0LCwtWkfi91oGk0d2iGlj+/nzyQPrPcxY8wcsLeQc9PrUvYmjkAJ2LsmoTiZs0TlielV4ptkNS96oR081ryJzziwjNrtCwDgKbOqah6CfnCeVFZQliHb0yJeDnrKHUr7erJ8BnAlk4LzBC5exFJRMTaRmICUw/ekRgztn0jzmF/dRcca0xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4P9si9F4DUFS8QJFkWqR/MRHbeqH/ApO4ZvCTGt2VLU=;
 b=GaohjEL2ww9q5G8gw6y8RqCMMErFOTKhiugl2d/nHSvJUL4NFX+UXqI2Mwk7BLjv7msZ4nY6YScLwtX7eYFjeWaAi9YrsM4ASrY52oPwTDrH71bvytHAsLPz2V2KPn2jQF1Gh8Xv2Z1iUFW/W54rVvYvwG4uvYAtZZJ4Ndd9Og8=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DS7PR12MB5983.namprd12.prod.outlook.com (2603:10b6:8:7e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 08:22:29 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 08:22:29 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 2/4] drm/amdgpu: add ras POSION_CREATION event id support
Thread-Topic: [PATCH 2/4] drm/amdgpu: add ras POSION_CREATION event id support
Thread-Index: AQHazQ0ob1wv/e3/zUKjlMuIoysbYLHkqPUA
Date: Wed, 3 Jul 2024 08:22:29 +0000
Message-ID: <PH7PR12MB87964A528D72ED8AB6113241B0DD2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240703055200.1610956-1-kevinyang.wang@amd.com>
 <20240703055200.1610956-2-kevinyang.wang@amd.com>
In-Reply-To: <20240703055200.1610956-2-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c1b98192-2aeb-4d8b-8dd3-fb8214140b43;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-03T08:18:05Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DS7PR12MB5983:EE_
x-ms-office365-filtering-correlation-id: d3150473-e63a-4f89-11ef-08dc9b394772
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?mm0CkBfAoBaWvIeBnqn0V70LrBSQ9k3JPlCRoZvGlDQzLS2qTObhCE86+9ID?=
 =?us-ascii?Q?yPDTBAtqEYFH3XtaVJcmCOs09Fq5rO7odTtnJypqUki/8dzAlw+HQqsare5l?=
 =?us-ascii?Q?0QKdI4uKHPZo61AVWIY2PhqmQrwGqW1rWNZkGfhbit0uJWEs3JS5zEdGuEja?=
 =?us-ascii?Q?e8CAnns9HJgzmiCNH9r27jd/p6b95edu4XAflZKNQHz476pZkB9Z8OJkz7e1?=
 =?us-ascii?Q?QCgS2PkTXthOO6jqdG7G0WRqzELFFsc6lE5WhenJ1e6wx1YX4fRVElIhBSBB?=
 =?us-ascii?Q?q9wJ4vaTpu+i0eU9tKUtK8ywmCOdIK3BmGX3fBQojcy8/nTs5TuaQcWRZiMX?=
 =?us-ascii?Q?wwwr2665lCKHYr8HDytqk9elVjh5gYAkcASwCvkKq6j+FJflwnZNOa8JwozX?=
 =?us-ascii?Q?6aH7CJyzuIxUhDstPxgnC6taGuDgy6FTvc6ZutAEH8xdYKLPlJf8EvSvnPce?=
 =?us-ascii?Q?MHRmGJN6DUwatqsNwbJHQAoJVN2eZaUOn/RI5gMRTV0k1YjJsLRs843umaCH?=
 =?us-ascii?Q?KVqZfQ1UQDUzEO5iyzArZqPGtK9dpOI6bImp6V+QtOzG9F8dRZaTlEAe6JY0?=
 =?us-ascii?Q?1s9jot16wbxaYFGOob/I4BtchCC+Fd8z/spJduENVYmJaOCCCnAQ1eBSrNQE?=
 =?us-ascii?Q?iKlTY0s3ediMEkMSq0SegVBeraZ1jQkD7xdaMRlkYk4ZHI+tbsiRqv3a+4XU?=
 =?us-ascii?Q?/68wNH6wfqGIe9O2/Mu3qvn7XMQAB8/HfHjbAU/JaF+i7Ku8QRGLtIYZRB8o?=
 =?us-ascii?Q?JlSyKxILt0GshzH8xqX/gENYSkEMTp+7mIlThO5exytj8K9hrsou7NCmiowf?=
 =?us-ascii?Q?mxrr0dF6f6VEdPE6CkF4ZCvyEoFs3XwHolfX3N4wlP814ljXztopkfY4nLds?=
 =?us-ascii?Q?LiqP6ylKZAdfdeaYd/a+nRZNXXAcfl9SshPO9PzszCl1bNsI8qYcQaeE4Ywh?=
 =?us-ascii?Q?hBRWR/w392IWCiV7VXVTJI9nTHs0jUtTlNhxvfKNZEzS+1baacfg+zN+Ib0H?=
 =?us-ascii?Q?PBPc2up9d9YUB22hYzhhhRH6crni0ydTXhCDwKIQP0Y4oC1tk9xfTeiurMps?=
 =?us-ascii?Q?TUtLYdzWCUVgHmUMXjamnwKmJ/IvN0RXXCTla2vq0xXL9yeyk3V28j0TwIZP?=
 =?us-ascii?Q?bax6nlSTAMWLHs+JO3zLtRhcMzDrjubz+EJxoPVhcGTczyQRslRVGZhSdysz?=
 =?us-ascii?Q?JC+I+f4ZECJ/Oz1ubBTQPLHNylt4YqiZDqZqRbtu/rHnzBFUQuv5pMhpbcF3?=
 =?us-ascii?Q?/jTFnlUYLE2y/1GcCeFsExiIhhqziPHJygirmC4ZXGdZE0ZA8I33zirjvQ0t?=
 =?us-ascii?Q?48hKwES8UAemEryBXLg2GN5iC71D7dQfcFxfV0suoM8Ygpnmd2rmAPwqwqn2?=
 =?us-ascii?Q?4vLrb+9ACme/Wfj73vRFhpyxQC40E5OMOqGyenwAC/BMtG3t5Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NEnme8zbC3TrC5BCyhbTuMkaXQzyo1+mL0I1gM9dG/acSz7l8V+oSdThTBfo?=
 =?us-ascii?Q?VRrwNmxu9MFMAyYLilV+SPVa7SAh3HG86FmJdN+sTdxZkiKIbmrt0KdT/Of0?=
 =?us-ascii?Q?un90bWJ1oL35Pwc1IB6YM85Mfm0Ohzt6FPx6VoTcuRwWoBhwRY8uYdpSKeW/?=
 =?us-ascii?Q?SKhPJiuhAMh+1swD3hIa+LgzprC2xg9q8YR2oEjHMkjLkWU9IDp2yV3tXmB3?=
 =?us-ascii?Q?HI/QwzK1EHMlZ7vry42rKeVlZXgm3F/HWLRk/BeAH2xkbopVN9exPv6fONln?=
 =?us-ascii?Q?YFyxqwcr3TTu3v8dVcgop7XspUE/3SlaoOH0G1RCllPj5SK9f+0LoIFwFYu8?=
 =?us-ascii?Q?rVvWgAdYNhoYQUMrO630+BjXQieryHD4Jymuxxse0zJUyEoTrxPlKHk65F7Y?=
 =?us-ascii?Q?UznBB3t7QzYWAOpc3GyuwNlvsq/2cnWeLLKRjn+GxnjolnCs2ZZCsQOMGO7g?=
 =?us-ascii?Q?Bj9mA5inC9SAw1k+xOQUsyy+3gOSr8cgql/EU9LNUaGUcO/Ffo69CmbLFivY?=
 =?us-ascii?Q?AyD602id/bQSzlxCH8pkCVQUQJsPWruu/lKn5oxruFSH4/KA+oJi2EGDlWOp?=
 =?us-ascii?Q?exIT7H0cYmqj8xPT+h7918nur2vjAKwe0lxOFlX0ig5uUO+ZZmLRmlA4/Qi2?=
 =?us-ascii?Q?41GT40WbQQIJRya/d4slpIGpv6nSAq/9Jh9gr3mlaqoi5bW8xBnObJkTxjvk?=
 =?us-ascii?Q?/bdDpMuXXmYCc7wnJBDK69kiZ7vjVhl5/Fy8A863tlOweDozUYFPjKrsmOSR?=
 =?us-ascii?Q?K6ckjY9V2sjEspy8z7yo5/FExTPZRSRNZnDxxh0+9ZVhEmBB/UZsomP5SuTJ?=
 =?us-ascii?Q?RmXJrapqAtpjOfzAIUu/AY6JmjcL2wQbuMeiiBV0d4po6mP1DrcvXdbV0JMa?=
 =?us-ascii?Q?6Dr0K3z8F3sXdJq5eaITHNzlTVKsWg6Vs9L8o+02XzX+QHz7c92Xgtue3WT2?=
 =?us-ascii?Q?m2OVSRYhtM7Iq09cZdVR5bfrkLM5AjmDsCNDCV8AF5tLln5Jpt3KeX7+jKQX?=
 =?us-ascii?Q?ZFsVv0TalwZxPS6+ywabjtycH87tLc0vu1cSy3Qd3aXrqKfhxSBqzPS0dh4/?=
 =?us-ascii?Q?XELpyC/y8FlBOeoXY4Lq6m3vvnQsFKtguOwnRAPUJC6BSwSS4uUMx+Nr5REv?=
 =?us-ascii?Q?XvS69gbWi06j9eeCpE0AQu+y34vNd5N9u6ZJTdI9t9g+LEH01CJ5Ehyd0Bj9?=
 =?us-ascii?Q?KNxM95K8GhtHPGmq6CoHW3A2kYFm3tVvX2c6+PRlhUAgeFDndBkTiFiFt+VZ?=
 =?us-ascii?Q?Aze8RIkhK+aHOCykX2yxvX9FhHWjvmLU5VHuldQXNMxtpNAkY8k4YK/LfudJ?=
 =?us-ascii?Q?Uxfu6pIqzG1vHuK3jPpzyjqWCL/sce5xdYd08C4Q9VXcEHBu2j+xzpwjVKTK?=
 =?us-ascii?Q?Oyywxi2jQrj+FTL+tjCM//My9nHH5vA5+l3ohQbGjAwVr6CNtc5Fw/x35I5A?=
 =?us-ascii?Q?CN60y3Wupxs9AIC6VWCx+xBx4hXgCKXcz9eoHqd45LIhkJtWGPNLsUJWGQOh?=
 =?us-ascii?Q?HCoLQcSL+zsGM1rQHHtJSvocYgJABe5FYUftkAJmdgrPo4iqB35I1n2gHVy9?=
 =?us-ascii?Q?BrlwcL76CmyGdPk65wY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3150473-e63a-4f89-11ef-08dc9b394772
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 08:22:29.3279 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WrN9UPinYEfxpHt8nJQXOfcX2Uk/8m43/SNAVV+Z1mIwWEIfEBXo4o7TOuWB98Zm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5983
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

> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Wednesday, July 3, 2024 1:52 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>
> Subject: [PATCH 2/4] drm/amdgpu: add ras POSION_CREATION event id support
>
> add amdgpu ras POSION_CREATION event id support.
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 17 ++++++++++++++---
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
>  2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 45ac82a34d49..8a98611d2353 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2116,8 +2116,17 @@ static void
> amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
> static void amdgpu_ras_interrupt_poison_creation_handler(struct ras_manag=
er
> *obj,
>                               struct amdgpu_iv_entry *entry)
>  {
> -     dev_info(obj->adev->dev,
> -             "Poison is created\n");
> +     struct amdgpu_device *adev =3D obj->adev;
> +     enum ras_event_type type =3D RAS_EVENT_TYPE_POISON_CREATION;
> +     u64 event_id;
> +     int ret;
> +
> +     ret =3D amdgpu_ras_mark_ras_event(adev, type);
> +     if (ret)

[Tao] do we need to add warning message here?

> +             return;
> +
> +     event_id =3D amdgpu_ras_acquire_event_id(adev, type);
> +     RAS_EVENT_LOG(adev, event_id, "Poison is created\n");
>
>       if (amdgpu_ip_version(obj->adev, UMC_HWIP, 0) >=3D IP_VERSION(12, 0=
,
> 0)) {
>               struct amdgpu_ras *con =3D amdgpu_ras_get_context(obj->adev=
);
> @@ -2889,6 +2898,7 @@ static int amdgpu_ras_poison_creation_handler(struc=
t
> amdgpu_device *adev,
>       uint32_t new_detect_count, total_detect_count;
>       uint32_t need_query_count =3D poison_creation_count;
>       bool query_data_timeout =3D false;
> +     enum ras_event_type type =3D RAS_EVENT_TYPE_POISON_CREATION;
>
>       memset(&info, 0, sizeof(info));
>       info.head.block =3D AMDGPU_RAS_BLOCK__UMC; @@ -2896,7 +2906,7
> @@ static int amdgpu_ras_poison_creation_handler(struct amdgpu_device
> *adev,
>       ecc_log =3D &ras->umc_ecc_log;
>       total_detect_count =3D 0;
>       do {
> -             ret =3D amdgpu_ras_query_error_status(adev, &info);
> +             ret =3D amdgpu_ras_query_error_status_with_event(adev, &inf=
o,
> type);
>               if (ret)
>                       return ret;
>
> @@ -3964,6 +3974,7 @@ u64 amdgpu_ras_acquire_event_id(struct
> amdgpu_device *adev, enum ras_event_type
>
>       switch (type) {
>       case RAS_EVENT_TYPE_ISR:
> +     case RAS_EVENT_TYPE_POISON_CREATION:
>               event_mgr =3D __get_ras_event_mgr(adev);
>               if (!event_mgr)
>                       return RAS_EVENT_INVALID_ID;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 88df4be5d122..1343cfbc913b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -432,6 +432,7 @@ struct umc_ecc_info {  enum ras_event_type {
>       RAS_EVENT_TYPE_INVALID =3D 0,
>       RAS_EVENT_TYPE_ISR,
> +     RAS_EVENT_TYPE_POISON_CREATION,
>       RAS_EVENT_TYPE_COUNT,
>  };
>
> --
> 2.34.1

