Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085E0CEE330
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 17:00:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA00210E750;
	Wed,  9 Oct 2024 17:00:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0fIJUpZx";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0650010E78E
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 17:00:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlupzXSfMvIhPTqhNkj4zvxMpJ3JAzvTnabV76jwjl4f8i3SINtU73koUpVUtfHqYlpKMdwzuBInmfvqYIV0eRN/9mjEngbq23gQgvyy+Ds5jJlLYnnrC1xp30/dM3RWwYy5UPJrvAElGc/f33J9xxuv63VmpvfSqclkTfpLD6rn7fzAo7wK7FfOYRe8EjSlVIOOTjbCGMwVcG+elbcK/lYiVgkp7ApINkfBiZic13uQgd0A+z7NgRD69m5JmVUDrCRjaUCahKPWe/+z8QMMhowu16uJlNzGbaCWQnBiWGe44g9/Xdca2meOu98m7JRM7um2rTPgOvbHR4KnFXbVdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqI78qfEsmb6qDanaXhAqKVbth+WVFtdLqf8fe8r7OU=;
 b=Pfy4ee/9lK8MqATEYnOAzTQUw/n7LtBBdB4Z8IT/WksVfN0qIGEaW1EmrQcZQ0V29W1me2unj4H7oDGyXH4E9FCb4+XgoYq//JY5cQd/Dw7szuGEa2+wCyDOgnwVjma3gNK9cQkPWJdyuQjD65etHzvg4edFJbWzOog2bxVKVTcv8m/RrsTH+0VRulBnHcXkNuJJxNW33/LUw5TFCTzk4XJYV7GCBpk7SSbC4rIJt/Qb6yzsWYBVCVPkXQ2jYAPQvFjWGWdnEUJX3pvOlKBSN0brghBpa1EjyT0mKxeJpd5sgzdr+7LXcnWegUEtEoP1a9hAvhvlBnmE4XK2rRn1YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqI78qfEsmb6qDanaXhAqKVbth+WVFtdLqf8fe8r7OU=;
 b=0fIJUpZxX5VvZn2yVJjxh/EjMB2u15F9+CtB9h7igILuz8fq05+DZjKl98tVfM49dnUWlqqhjkCDLWkrQs9rEaCcMZsrI8kA27y2mULiv5gJRsYJRDRIFETxnPGMFgB47oBAWG8QhKbbdd10l+rmBN9ggWkZJUzrP5jXn3el39E=
Received: from CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 17:00:47 +0000
Received: from CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::9edb:7f9f:29f8:7123]) by CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::9edb:7f9f:29f8:7123%5]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 17:00:47 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>, 
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Mahfooz, Hamza"
 <Hamza.Mahfooz@amd.com>
Subject: RE: [PATCH] drm/amd/display: Add hpd_source index out-of-bounds check
 for dcn3x link encoder creation
Thread-Topic: [PATCH] drm/amd/display: Add hpd_source index out-of-bounds
 check for dcn3x link encoder creation
Thread-Index: AQHbGlceuWYUgN++NEiqAO48hoUMdLJ+oe8Q
Date: Wed, 9 Oct 2024 17:00:45 +0000
Message-ID: <CY8PR12MB819353238F036A65320158A1897F2@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <20241009142518.548229-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20241009142518.548229-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=c00d6b1e-b38f-4b26-9c14-0a3c81ede82f;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-10-09T16:50:19Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8193:EE_|IA0PR12MB8349:EE_
x-ms-office365-filtering-correlation-id: 08e03d9d-49dc-432c-d52f-08dce883ead4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?/RBbuT584yAt3cLSvrcWJO9BfSZjVNktxMpukv+Xh/o8ezhjHTRx9L44GV5Z?=
 =?us-ascii?Q?vH08MwuMLNAE76zx4yG0w5Q0TCqVEsfBwc4fMNkm6p+fI2xKMmx1bfbV4jr8?=
 =?us-ascii?Q?3c+SF+6ouhf+yRbnvfWiLnyZoe8MrP2xQMPvJytL6UuUdzEK8C2qN3uRynJ6?=
 =?us-ascii?Q?Or46LlC4KpBAWydD+uXoOnxzCU4xg8I4w+9e3DJJVaghnGh+nApU9WJuKTZz?=
 =?us-ascii?Q?dMrO2jv9oClj5gVqlpOGMkevFPZ4dSAbJdK+DxsA+oEn/sKd0UeGO1OYy3Co?=
 =?us-ascii?Q?3o2AFsFhpwf94ogw2R8mmqiM80ToVorkd6va8GnafN3lZFxa9s1o45RPpRQ4?=
 =?us-ascii?Q?jvmKqCe3Io0kBgg6EAJXit+K8OZqyLhM+eU/LSQ29NANVZ0ALzl5WPpthSO5?=
 =?us-ascii?Q?Q3vKJVKP6dP8CHwzbY0tymw+6YVd+mRAqgGjnCB9q+0Jcn49dW9YOAhR6Hir?=
 =?us-ascii?Q?2rFiylhzwnOSBFi8mteCqWkggOzs7xmbBuWfRX0TL/DdWXJppHzA2cIi7HKH?=
 =?us-ascii?Q?Spb6pcUui61vbHzKb+OQHO0EsAXZT3heZ2fOcKmDYo3znHGa2pOKNDqm/kAw?=
 =?us-ascii?Q?ubxShnlkjZCoOA4QxsfIbKIambgi9TLhtDB4NymAoVPFckP2vsxWnApT+cjc?=
 =?us-ascii?Q?8OzfSEirEfxBz9JodByAoIOGlBE17WTEUdW++rdYX9BOHQRJd94vYgzNOQyu?=
 =?us-ascii?Q?6ofN/5LiQLMCLWqwUEbrfV+LFg8UE4XRD2igRxM7UwSJ0fZXMRDEpVIe/GG7?=
 =?us-ascii?Q?7ZiFaf/vZbFW5SzjpL993YuatwZ6I41S4naj5+VWIs7a583GRkVHxRRWY+hb?=
 =?us-ascii?Q?g+YSeBCXa6/8armBpMtGekKXD/TjDsi4ww5+SVAX9dpyBaLhz4OoAyoq781y?=
 =?us-ascii?Q?w42O6Ko5B19dEI5QCX/VUWCC0l5twdSQcxgv6DOfsMVjIIEV/vtFL/ObYw4Q?=
 =?us-ascii?Q?qGwqVPaog4rnvaWfPG1uI8SM0EdxwshXq8QoZelVgehdt4mtRQbnH8AHUOa8?=
 =?us-ascii?Q?8YCY6arvrLrUf3yjL+vih5r5FoGMhDrpJ3vNgk/a3NYDYhS+wOZaYqzAu/sD?=
 =?us-ascii?Q?novsosW8m8G08c2Rw7/Kx87bbc1etuQ4JgILLKg/kfJ20g+IlaWuU0aMC/IS?=
 =?us-ascii?Q?eMiNtwX384oEXyfK28UwGTJkY4D+on13TXF0TxDZEaajqdRJfDzfQxxa0zwB?=
 =?us-ascii?Q?NSms/IHzkuh35VWBQjgZoaFXTdmQxhChr0/oYRjiPpYYdgZfoprlHELJtxeI?=
 =?us-ascii?Q?5mho77tLm7Cgdo0Tye28YCB2bw4b7o/nUsHWHK7dtj8vZJ6rAAJjfN9gwYPe?=
 =?us-ascii?Q?neJEdEcuzKlPnhMulrvytclH8Pl2HQbyK9vBHAeefBYx9A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8193.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x1PqrTqYYmOh9etfVKMQSPziQmQgkNWKA1QmKPMpGyQAF6jOui9trWi0mM2O?=
 =?us-ascii?Q?ODN3BCrC5JViVHMCHZFtB722rsj4stDQu6EW0YgJrA/mTDU/Bl8Nquit782K?=
 =?us-ascii?Q?T+AqTM+TuWCfVTI5uQvd0qtgqmagbKPzpB+/hmqn3tNeAq54r4VI94PL7JwN?=
 =?us-ascii?Q?PLXbyCczdh8gw8ROJq5zU/ouCzki0WKkgKgZpKg0xgBRxTvYHJXzL1k/EiTF?=
 =?us-ascii?Q?K1VKFYX8mPp0xXQfSF75QNCqLXE+pGc7brh+CJlAPVRZrYC/IVc9DGLU2hkv?=
 =?us-ascii?Q?+6t1L9IVrDkfFR9AfZZ8emwziXmdxhh7vU9h1skH8T8Skr7uyogOtYYDGK2s?=
 =?us-ascii?Q?+NMODw/NDLH2XjifUenq7/jwSPOBIAUIAwFi/MQ2tdFzNrspcV5gG+lmauQ2?=
 =?us-ascii?Q?0VC/OfP8YT+bWX/SamXwNFOzwA0lq7xOq1GhBygYKoRQpOwZKd6jTt7JTjrb?=
 =?us-ascii?Q?pirDDQS22sVq93yfiR24hap9KPfc9Lo8U9Sa74Eip4g9c70DaFj5CJ6N7NjC?=
 =?us-ascii?Q?nQoX75HYp1Pypg9/hmK/nvZefCIhLfjWSOP3ehY5pEfxeNZc2qi+B7cpzSN9?=
 =?us-ascii?Q?rm/9EpliQ4cpznWmSEk/TYUqLgnDreRXMANIJh0LFpijfxzGgwdBx5rQUpNP?=
 =?us-ascii?Q?rROBNxHN/x50NZZw+GpijuO+DuDdxCVOAaLjKjqIPDgvi1/O+H2yR0PAPXVE?=
 =?us-ascii?Q?4N7u36HPBB6/e+6rh9XxcGuTpjvXBSC49+sFYfoh/0TWwW4p40lrbNOksImD?=
 =?us-ascii?Q?Su0a2kmnta6D0CVzWG0Te7GP3XhNQM5d1m6IzwiHaZ1RvpTfoRG8GTUlTouk?=
 =?us-ascii?Q?EIOUu5piDp82lIhXekxocSWFk54TR2WRJ0ExYQS62b3J0c+OMN0xOmWSvxYL?=
 =?us-ascii?Q?ultt7kmVYcBblCXFtNDEYmsqIFkO/gVYKxmfaWX7cpcPLIHO/+vhJuug8jTK?=
 =?us-ascii?Q?ESQNLJ/yO3ObsgyrRM9cqkmhIShxiaKKvohXnpbxszXm2ECyug9RfhtInMEW?=
 =?us-ascii?Q?HrHrA3ijN8uChD3aq34sS/+FMRB6/w7RveMTfJIj/n+Y1lzUoUaFpNJKu5Eb?=
 =?us-ascii?Q?+7IfxFnQLUy4ZeDYVAhN2niECeV12NL3Bu7KsF2CZ07BRz/mLZR/C6goeoW+?=
 =?us-ascii?Q?qPD4ATq2FbZSP6E9shwWLnOy+J0Z+l/tNLu+KCmj+nX2k3IyVZiGE4TWfE11?=
 =?us-ascii?Q?Ca/ge829FaIHWhQJX3LKriFwqtQXipDn3lRbtJnjOAYtPtJUqgIgD+d0Cf0a?=
 =?us-ascii?Q?tjwgugyEAhHCslU9IaoFk5XMrZM66AbrL2zBzRK/avVvwF8s26KgbkYWeO05?=
 =?us-ascii?Q?Zi/MOq9HrtK897RruU9hJ/mzZMC5nz5jEfq+IB4u4tv+aNMFGprUprOvJnxn?=
 =?us-ascii?Q?0/oliYFX53dYPFhdnzoyN6/Gg0vQFT+GRiBAxk9GpKS0fti6OOMFsP8QGFyj?=
 =?us-ascii?Q?d/w3qmnuIVcPlkpmYlxcsqfpTi6F+b29qJcQH7kCeSH7je7Cg/7TdUKJj4Au?=
 =?us-ascii?Q?ZHB9B5kKGaEsdJkLNdtREImzkCdBTPMY8FqM7m5WgERR7xcZx7SDYOePUmwN?=
 =?us-ascii?Q?7E4reMmwscTEkiKE+zY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e03d9d-49dc-432c-d52f-08dce883ead4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 17:00:45.7421 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PKoDouemDi00fzsD2kwiZBUEDVIyNlh9dkxs38zy+KHm0FAzKFSc4nlASB8sEI+n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349
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

Reviewed-by: Roman Li <roman.li@amd.com>

> -----Original Message-----
> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> Sent: Wednesday, October 9, 2024 10:25 AM
> To: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
> <SRINIVASAN.SHANMUGAM@amd.com>; Chung, ChiaHsuan (Tom)
> <ChiaHsuan.Chung@amd.com>; Li, Roman <Roman.Li@amd.com>; Hung, Alex
> <Alex.Hung@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Mahfooz,
> Hamza <Hamza.Mahfooz@amd.com>
> Subject: [PATCH] drm/amd/display: Add hpd_source index out-of-bounds chec=
k for
> dcn3x link encoder creation
>
> This patch adds a boundary check for the hpd_source index during the link=
 encoder
> creation process for dcn3x IP's. The check ensures that the index is with=
in the valid
> range of the link_enc_hpd_regs array to prevent out-of-bounds access.
>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c  | 2 +-
>  .../gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c    | 2 +-
>  .../gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c    | 2 +-
>  .../gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c    | 2 +-
>  drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c  | 2 +-
>  .../gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c    | 2 +-
>  .../gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c    | 2 +-
>  .../gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c    | 2 +-
>  drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c  | 2 +-
>  .../gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c    | 2 +-
>  drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c  | 2 +-
>  .../gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c    | 2 +-
>  12 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource=
.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
> index 5040a4c6ed18..baa4e2647dad 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
> @@ -927,7 +927,7 @@ static struct link_encoder *dcn30_link_encoder_create=
(
>       struct dcn20_link_encoder *enc20 =3D
>               kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
>
> -     if (!enc20)
> +     if (!enc20 || enc_init_data->hpd_source >=3D
> +ARRAY_SIZE(link_enc_hpd_regs))
>               return NULL;
>
>       dcn30_link_encoder_construct(enc20,
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resour=
ce.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
> index 7d04739c3ba1..d8a7c2cf05de 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
> @@ -883,7 +883,7 @@ static struct link_encoder *dcn301_link_encoder_creat=
e(
>       struct dcn20_link_encoder *enc20 =3D
>               kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
>
> -     if (!enc20)
> +     if (!enc20 || enc_init_data->hpd_source >=3D
> +ARRAY_SIZE(link_enc_hpd_regs))
>               return NULL;
>
>       dcn301_link_encoder_construct(enc20,
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resour=
ce.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
> index 5791b5cc2875..40c20b04635a 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
> @@ -893,7 +893,7 @@ static struct link_encoder *dcn302_link_encoder_creat=
e(  {
>       struct dcn20_link_encoder *enc20 =3D kzalloc(sizeof(struct
> dcn20_link_encoder), GFP_KERNEL);
>
> -     if (!enc20)
> +     if (!enc20 || enc_init_data->hpd_source >=3D
> +ARRAY_SIZE(link_enc_hpd_regs))
>               return NULL;
>
>       dcn30_link_encoder_construct(enc20, enc_init_data, &link_enc_featur=
e, diff
> --git a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
> index 63f0f882c861..daf1b65fd088 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
> @@ -839,7 +839,7 @@ static struct link_encoder *dcn303_link_encoder_creat=
e(  {
>       struct dcn20_link_encoder *enc20 =3D kzalloc(sizeof(struct
> dcn20_link_encoder), GFP_KERNEL);
>
> -     if (!enc20)
> +     if (!enc20 || enc_init_data->hpd_source >=3D
> +ARRAY_SIZE(link_enc_hpd_regs))
>               return NULL;
>
>       dcn30_link_encoder_construct(enc20, enc_init_data, &link_enc_featur=
e, diff
> --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
> index ac8cb20e2e3b..36bb26182e11 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
> @@ -1093,7 +1093,7 @@ static struct link_encoder *dcn31_link_encoder_crea=
te(
>       struct dcn20_link_encoder *enc20 =3D
>               kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
>
> -     if (!enc20)
> +     if (!enc20 || enc_init_data->hpd_source >=3D
> +ARRAY_SIZE(link_enc_hpd_regs))
>               return NULL;
>
>       dcn31_link_encoder_construct(enc20,
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resour=
ce.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
> index 169924d0a839..58a5fbcf22bf 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
> @@ -1149,7 +1149,7 @@ static struct link_encoder *dcn31_link_encoder_crea=
te(
>       struct dcn20_link_encoder *enc20 =3D
>               kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
>
> -     if (!enc20)
> +     if (!enc20 || enc_init_data->hpd_source >=3D
> +ARRAY_SIZE(link_enc_hpd_regs))
>               return NULL;
>
>       dcn31_link_encoder_construct(enc20,
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resour=
ce.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
> index f6b840f046a5..3acad708c31b 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
> @@ -1091,7 +1091,7 @@ static struct link_encoder *dcn31_link_encoder_crea=
te(
>       struct dcn20_link_encoder *enc20 =3D
>               kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
>
> -     if (!enc20)
> +     if (!enc20 || enc_init_data->hpd_source >=3D
> +ARRAY_SIZE(link_enc_hpd_regs))
>               return NULL;
>
>       dcn31_link_encoder_construct(enc20,
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resour=
ce.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
> index 5fd52c5fcee4..ce56f5d162c0 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
> @@ -1085,7 +1085,7 @@ static struct link_encoder *dcn31_link_encoder_crea=
te(
>       struct dcn20_link_encoder *enc20 =3D
>               kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
>
> -     if (!enc20)
> +     if (!enc20 || enc_init_data->hpd_source >=3D
> +ARRAY_SIZE(link_enc_hpd_regs))
>               return NULL;
>
>       dcn31_link_encoder_construct(enc20,
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource=
.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> index a124ad9bd108..a1890df29f5c 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> @@ -1039,7 +1039,7 @@ static struct link_encoder *dcn32_link_encoder_crea=
te(
>       struct dcn20_link_encoder *enc20 =3D
>               kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
>
> -     if (!enc20)
> +     if (!enc20 || enc_init_data->hpd_source >=3D
> +ARRAY_SIZE(link_enc_hpd_regs))
>               return NULL;
>
>  #undef REG_STRUCT
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resour=
ce.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> index 827a94f84f10..35acc13cb5a9 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> @@ -1035,7 +1035,7 @@ static struct link_encoder
> *dcn321_link_encoder_create(
>       struct dcn20_link_encoder *enc20 =3D
>               kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
>
> -     if (!enc20)
> +     if (!enc20 || enc_init_data->hpd_source >=3D
> +ARRAY_SIZE(link_enc_hpd_regs))
>               return NULL;
>
>  #undef REG_STRUCT
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource=
.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> index 893a9d9ee870..795f2c71c70f 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> @@ -1074,7 +1074,7 @@ static struct link_encoder *dcn35_link_encoder_crea=
te(
>       struct dcn20_link_encoder *enc20 =3D
>               kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
>
> -     if (!enc20)
> +     if (!enc20 || enc_init_data->hpd_source >=3D
> +ARRAY_SIZE(link_enc_hpd_regs))
>               return NULL;
>
>  #undef REG_STRUCT
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resour=
ce.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> index 70abd32ce2ad..0b8dc2eff596 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> @@ -1054,7 +1054,7 @@ static struct link_encoder *dcn35_link_encoder_crea=
te(
>       struct dcn20_link_encoder *enc20 =3D
>               kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
>
> -     if (!enc20)
> +     if (!enc20 || enc_init_data->hpd_source >=3D
> +ARRAY_SIZE(link_enc_hpd_regs))
>               return NULL;
>
>  #undef REG_STRUCT
> --
> 2.34.1

