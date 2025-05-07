Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F3AC369DC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 06:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5903110E750;
	Wed,  7 May 2025 06:55:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Skrsa7mX";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D97F610E750
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 06:55:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d49ycABJOe7duYk6o5OqKz81X7MCDnboWJKnny7MM2TgKaaZogtOFr2Bx+8Hggm579sdxUJM2i5I6HiXwkb+zx6z2GlT8e+9cIwfifKy+Ois3I1f21G5VM2/b+a8i+8rHPFfmIe/zWg7pY5rdILii/iQPlNQeAGEwiV1WZ0WgxkoTqHX+pqkhFaN9vEeal2l9slBhWWYuXBO1+3U0/gCs9uCxYIFaKDO59SlSjofp3+Fiqii0eCxjigP6sNT5A+E+iuSn1OubEr7rGgwP/JZs+tLqkFgiw68l0wZeeg1/UKOE9ddDeCNwJGNAEp1WB0zShOvT2jwLtZvyBsIGdldHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMpyoDCvlMkhOJel3lJZNj8SG1yFcvCHWY4d2lkFS+c=;
 b=A25x2VuDTapNNUIn3j6dp8OCQA1zDCsan+aLFY4u0eISyznSK1qIJn0t0PzV3cHboo019+Vxo6b43v+bhhr1IRQ1lWMK50qxqiHDvIOf7Fc48MTWuzC/g8Nn4EzvvjwQCYcRcxtFSt7LEy39vdB4soD7WLa3YeeUzfguEVLGTs7yWLkzLIkVX4TwG/1ZzUVnQETIbhLSF5/dkfNojcuB+WgrDpv6yk+nnlaMLh511ddfvfxb4kg/6TlOvO4BB3tV64v9AaIijTadkBd5tUFvjuFl4ZKpqzrcbzqdHbKbZgQEb5K/qUg8X8vXjS5E4k8polmkAUuqFNK4dd1GWYRpbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMpyoDCvlMkhOJel3lJZNj8SG1yFcvCHWY4d2lkFS+c=;
 b=Skrsa7mXw0UMs7+L+FKUWCQnAktnpQqfbhV88TE+73SLzpvFjZ7Y+q8Bhl29OxTOZe0bXKl+UAFdfw1ubBWM52riZ8DCQX2xxMBtvXNe7FkubeRfeReXpU1feL5KtmeXvMbpayHCme8kloN6CfRA1txs7U5qVIofIAbXMXB0KbA=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SJ2PR12MB7868.namprd12.prod.outlook.com (2603:10b6:a03:4cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 7 May
 2025 06:54:59 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%4]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 06:54:59 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>
Subject: RE: [PATCH 3/7] drm/amdgpu: add mes userq reset callback
Thread-Topic: [PATCH 3/7] drm/amdgpu: add mes userq reset callback
Thread-Index: AQHbvp/dTK1WiZ9yJ0mhNj2Da2mDvrPGvCaw
Date: Wed, 7 May 2025 06:54:59 +0000
Message-ID: <DM4PR12MB5152A6774D0989F6ED7582F0E388A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250506155900.3866874-1-alexander.deucher@amd.com>
 <20250506155900.3866874-3-alexander.deucher@amd.com>
In-Reply-To: <20250506155900.3866874-3-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e0038dc6-579b-4c79-b084-e3829d280944;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-07T06:53:12Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SJ2PR12MB7868:EE_
x-ms-office365-filtering-correlation-id: 9d9e59db-cdcd-4a44-0491-08dd8d341581
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?eHBJRWFRWUQwOWJSMHhKTXd3M1JOOTFMN2Rla1BwMGdqS05IS000OGlMZ2NR?=
 =?utf-8?B?a01sVnFnbzhrdUFIUVczSFFlZkdBV0wwYU1IaEhweTkxSTZnMVB6VFRkdzQy?=
 =?utf-8?B?Q3FIUmNuNnd5eTYweVdtUGlRQWEvWG1OaHgzeHVYUi95cElSSVBDemJZLzQx?=
 =?utf-8?B?UXYrQ3V0b280eEkrdlVta3ZZUXFtYlAzdlFWSjkvN0VWc3lhRVV3OWdCNFU0?=
 =?utf-8?B?TnpDL2dXTXRRaXVFazVQVEpBNGtkQzh6VkorUEtkSWpuTXNFendBNnJuQjB0?=
 =?utf-8?B?NWFmK1l1djNyVDF6aDhsaWpVdktJMGhvb1M4SmFFMGY0eW5lQmtSaERiUUxF?=
 =?utf-8?B?Y0dzTWttemk2bVZUTjJ0c3ZRYmtjVkZlTEVONkRjcnorQ1FMNlk0YXk2Q0ll?=
 =?utf-8?B?U1dabm9EZ1VWN01iTTQwVDNNVlhyanFNK2xiTzVsY2V5YmRmN3JjMGhlTG82?=
 =?utf-8?B?OW0rYmhHWjVLZVdiYkJNaWpqWG0xcUxqUEVvTHMwRHNtL1BkcmVxVzJzS1Ft?=
 =?utf-8?B?KysyaWVLNkJpU0NBUEhoalBIT3hxMjJoTytDb2tlRVBIV043dFNyc0s5b2lt?=
 =?utf-8?B?OG8zKzBGWlpTWXhHb2xJQlpjdDI5WTR1b2FGMDlvUnNXK0NVNGFYam4xdlNq?=
 =?utf-8?B?cG5UK1orU3NDMkJVL1g3OHo4d004RW9xTFIwY2p0Wk5YYzY3b2wyTmZROW4z?=
 =?utf-8?B?L2FuS0piTkxJcGdSbWNuNWplazdJWGg4QjZrNTZPKzg3cFFsaFBhdk1ab3JI?=
 =?utf-8?B?elhzMmhzYlYySGNTYlNPWW45UUEwQlhyLzBBTVlrVFhhcS9HaWNET0VUekdS?=
 =?utf-8?B?L1VCNlpxbVdPbGVJRDNkcmgrZnNIdW0waWlvbmNYaDVoeFdTbUNUYnF0WDVZ?=
 =?utf-8?B?M2VuRjhHVzcyK1Znd29CaEgrWXVQTm9abytmU0xiNjFlZmo3MmNkVUxLUm1h?=
 =?utf-8?B?YmxhVEZKcHdwZ2V1alJlOEdGeWZ3UndVNGFLWHpXODgyaTVhNTRVOTM3eVBz?=
 =?utf-8?B?bHFoUis3SEJydTFsdmllMDdkVlFSRU1nTmh6bVNwelgyMzl2d2MvZVF4dVB5?=
 =?utf-8?B?dFRNdUtwS3BHZEhlZGhDVTIwcnZzUmpDc0daTkFPWHEyR3hZTVJsckcyb2JJ?=
 =?utf-8?B?NlVIZEU3N1RpaHNTUHA2bWZsR1B5eGZDTDZKWHJlUVNvc3ZObzZ1ZWNoOVEz?=
 =?utf-8?B?OHZ6NzY4NCsrVGtQM3o5bjZMY2s5SFRFSG56OXhLWVZjd0FiWjlSeFoyL3Fh?=
 =?utf-8?B?Y0REek9EVlVDYnB2cG1WMVFxZWJ0UlpibTdGU01QazE5UEdUaWprb0tEcGtp?=
 =?utf-8?B?TytjcHQ0MWdKK25hZGxJYzVpN0VZbjNrWWZKcUJNTkVzV0RHYkFYa3lEL05P?=
 =?utf-8?B?OTRDbjhRNWhjMUI4NmNNU3F2cXJNMnVIZXhFMWd0MnBHUW1kOUY1TlFwZXhR?=
 =?utf-8?B?eUpYWGVBT0MwV3V4L3hSTVRXemVEQ3RhK2NOMy9hUWVMOEVTRkJCVERRTE1Q?=
 =?utf-8?B?aHJ5bnZDVnhuTjhnUEdDQ0pxUlJNU2prZlBjeThlajArT01lR1gwZ2djT3Vm?=
 =?utf-8?B?WVNTVE01eU8vdE5tNjdTNU5qMWhiV1JHeEJmMVJBd0o4WG50bzdMUGdqTGNE?=
 =?utf-8?B?SFhQdkF4YlY2aUxCbkJEYTNVdG90OEhrYWNrM2pCZmZxYTNCc0NOSUxFUFhO?=
 =?utf-8?B?eFRjUVJ6ZFFlTnk2azhSb20rU3VTVlptYWliUWg4TzhYR0c4WURsWENwcTFV?=
 =?utf-8?B?SXR5UitBZU9kVWlLWkJxanF1dU9HZ0U4NFJRdFFtSjdHNkJoeHZ5a3FEMmhY?=
 =?utf-8?B?QUhaeFlyMHVFVGdvcHNyb0dDa29zVThid1ZqLzFjeTl2RjU2RStyVklUc2gv?=
 =?utf-8?B?WjhDTUhKeWpFVjN3V1V0Nk14RnFMMWVsN2JJWmNSc25Bd1Y1dktkUStQTGlX?=
 =?utf-8?B?ak9lUCtTallrWVBBMXVwTEI1REMvcGJSYytXOHVZL042MjhVM0FiZFRQK1ln?=
 =?utf-8?Q?IoD6tmMSJF0jxtX4CsdZbJAWMOtidU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEh0bnBtdFVGYk9YK2R6Yk83eFBoVTUrTXhnOXVWRHkybUs0YmZmMzgyM3h5?=
 =?utf-8?B?TlJjYWQxUEc1Uzdyd1Ftb04vdHM5ME5GNFNhN1huSVNhbEh3cmgyWXloVVJw?=
 =?utf-8?B?UnNHMjBFdXB3VWs1RTZOOUR4czhQbjhwZDBRYlhGeEIxaEhHV01DZGY3cSts?=
 =?utf-8?B?R2FXZCtGOGJhN2w3Q0srWWV1ZVlnRzFrdDVyV0dFSFNTUlVFMzdWUkdZdUcz?=
 =?utf-8?B?V2U0NWV0NGFaa1hJeE1NMUVUc2wyTlh3QTZqT2ZiUFFhMjlhR0hSMGVYeER0?=
 =?utf-8?B?dis3UklnN01BeUtUM0VsTFcxbU1MSkRkaDc4ZlZaQWVkQ05CVXd4TE5qa24z?=
 =?utf-8?B?bm91dDZiLzB4eEF3aUtZK1ZjOEd5aG51UEJ5SkdpTEJpZ2trSFBXdUw4cVB4?=
 =?utf-8?B?RkFScnVVa2R1UTFqNnUwd0lZYWpvYkEzdmUwUk0zQjl2RG02YjVXUk5sbXRr?=
 =?utf-8?B?YTNmOGswQzFaUGpTbXdLYjdKQjF2MWdWWEpqb2NPbktyNFcwY0h0WE5oKy8w?=
 =?utf-8?B?UG9jOWl0Vy9ZeEdZN2h1dUJyZFEzV0xqWmk5Z0xKdHZlYUl3TlJDb3BCVnEx?=
 =?utf-8?B?ZHRQZEcxSEtrSG5PQnZvYXhJRjFvcE5KU0JrRDlwc2dRYkJSa2E1RlNLeDB0?=
 =?utf-8?B?WnMzL2xwWUxLcGdISjJud2tBV0w4UFdobkM1ZnR3SkEycDgxNTJqcWJlZ3ZY?=
 =?utf-8?B?cTd0bmpLQTdFMHVkL0pvS05SQ1ZIY1JYaTJIanc2NjVld3hCUGp2MlArazV5?=
 =?utf-8?B?WEFSNE9TMFJuakYxdllsREJUZjBmSHp3dFJvblFrVmYxT0RZM0FqTmVSVWRk?=
 =?utf-8?B?eHorVDV6YlNBK2pUSzVRRUxxUjc1Qk0xTW5UVnJBSHZ0UjNMTy8reDVEYnk5?=
 =?utf-8?B?aXhJdm1zNzY0bklxWkQ5M3VPMDZsS0pjcDVWOUR1MHI5YUFFaFpJcURnRWU2?=
 =?utf-8?B?YjQ4UTRrd2FqeTkzMnhlYVNRTW00QjRqbVkyS05pSmhrSkZQbDFJSFBldjRx?=
 =?utf-8?B?R0xyTU1lK3czbG5ZNFNkdjhYTVhYWGgyaHhNMUNjYWFsM3Y4MU8yblJEL1NY?=
 =?utf-8?B?elU3VUdvYWM3d1ZGMjlpeFNYTUxWQUZDV0l1RS8yWnl1dDA2SjkyVXpLTzM1?=
 =?utf-8?B?bVgrQmN2YVQrQkpoMDRNWkZxMWxaanZyazdqaDNScVgwc25FSExpdHlDK1pK?=
 =?utf-8?B?ekVkSVBXbUVKdlh4cmJVY0lxNExSZjA1VU4rZVRhL3BYd05kTUdMdzB0c2Iz?=
 =?utf-8?B?ejgwWDc3K2RBaGh2bkRVcFdVYnpDVzY3aE9hWVQ0L1BISTlFSEhGQnk3QVBB?=
 =?utf-8?B?anFLTEtDczNHc05GNDR5Q2JLQ0pYdnppbnJXaVZPcWFyNnpHS2FsLzZnTDRh?=
 =?utf-8?B?Nk9jZkhZT1pVeVYyV3NVTkxXdEEwSyswS3dNSklmNFplaDNCS08rNll4RjNN?=
 =?utf-8?B?L3ZuZzloTkI2S0gxbFY2eEFQYkthYVdJbXc4MWxnTVpIZ2VuYnhvNEMxamRD?=
 =?utf-8?B?alBjYXNIeExhQmxnTU8vdnUweFZGQnVZQllZTU5tSk14TXJUU2tWQUZ1MVVa?=
 =?utf-8?B?L1JwYmJjc25GNWJTbjZ1Vjk0eENiYlcxMEFLRjRUc3g5UTdML3hoVG9GemYx?=
 =?utf-8?B?NW5zSmE3OG9pT3pYbm1KbG1EZ2NNTlNkZ3pvK2F2Slp6cUUyMEp3VXZQeGo3?=
 =?utf-8?B?a0hwa3I4UFphUjU5ZUdZRHlNNkNFRjdKQ0c0U0s2SG9HMmdpN3hyZUJTekRz?=
 =?utf-8?B?Z05FdjF1bDU2WWlSWTAxWjI1ck9aOTgvY2dBRmN1c21ocGZ6UjlwL3NoQkw3?=
 =?utf-8?B?bjlQK2YwN3Q1K3g3NXAwRHl5eEJiSW1LbjNHbmNhRWlhM1pTMHVhYVhwbGx2?=
 =?utf-8?B?WDRWUDgraXM4UVdHWWxQeGZPVGNBRm9hbTJXaXlzQkd3R09NaTJEMjg2V0No?=
 =?utf-8?B?VUszQy9JMjhvYlIxd3FDek05d2twOEVGczArTGZUWkRPOUhSVzN5aFlPelBH?=
 =?utf-8?B?eGdPbHM1RWZ3Q1ZSZnM0V0tKcGJKNWRQVmlLVmJmSWxROEdXamp2ZDBHSytW?=
 =?utf-8?B?Z0dKUWxLbWRnNERwMVY5N3Bzd2RWU0dSVzkvMVc4aFJBeDRCUm5Nb2dlYWtG?=
 =?utf-8?Q?SVvI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9e59db-cdcd-4a44-0491-08dd8d341581
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 06:54:59.4451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OGlyfUu3B2hOYDxQjXP7OVi+y5cQ6/ch4x0+Qqr9qZnhOmFqZUvXC0gsjBSBa8yvh4V4ovkc4Tb90Cr3XeTVbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7868
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91
bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBBbGV4IERldWNoZXINClNl
bnQ6IFR1ZXNkYXksIE1heSA2LCAyMDI1IDExOjU5IFBNDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcNCkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgS2hh
dHJpLCBTdW5pbCA8U3VuaWwuS2hhdHJpQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0ggMy83XSBk
cm0vYW1kZ3B1OiBhZGQgbWVzIHVzZXJxIHJlc2V0IGNhbGxiYWNrDQoNClVzZWQgdG8gcmVzZXQg
YSBodW5nIHF1ZXVlLg0KDQpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPg0KUmV2aWV3ZWQtYnk6IFN1bmlsIEtoYXRyaSA8c3VuaWwua2hhdHJp
QGFtZC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVl
LmMgfCAyMSArKysrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0
aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3Vz
ZXJxdWV1ZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3VzZXJxdWV1ZS5jDQpp
bmRleCBkNmY1MGIxM2UyYmEwLi42NTBmZGI2OGRiMTI3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvbWVzX3VzZXJxdWV1ZS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVlLmMNCkBAIC0zNDcsOSArMzQ3LDMwIEBAIG1lc191c2Vy
cV9tcWRfZGVzdHJveShzdHJ1Y3QgYW1kZ3B1X3VzZXJxX21nciAqdXFfbWdyLA0KICAgICAgICBh
bWRncHVfdXNlcnFfZGVzdHJveV9vYmplY3QodXFfbWdyLCAmcXVldWUtPm1xZCk7ICB9DQoNCitz
dGF0aWMgaW50IG1lc191c2VycV9yZXNldChzdHJ1Y3QgYW1kZ3B1X3VzZXJxX21nciAqdXFfbWdy
LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGFtZGdwdV91c2VybW9kZV9xdWV1
ZSAqcXVldWUpIHsNCisgICAgICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSB1cV9tZ3It
PmFkZXY7DQorICAgICAgIHN0cnVjdCBtZXNfcmVzZXRfcXVldWVfaW5wdXQgcXVldWVfaW5wdXQ7
DQorICAgICAgIGludCByOw0KKw0KKyAgICAgICBtZW1zZXQoJnF1ZXVlX2lucHV0LCAweDAsIHNp
emVvZihzdHJ1Y3QgbWVzX3Jlc2V0X3F1ZXVlX2lucHV0KSk7DQorDQorICAgICAgIHF1ZXVlX2lu
cHV0LmRvb3JiZWxsX29mZnNldCA9IHF1ZXVlLT5kb29yYmVsbF9pbmRleDsNCisgICAgICAgcXVl
dWVfaW5wdXQucXVldWVfdHlwZSA9IHF1ZXVlLT5xdWV1ZV90eXBlOw0KDQpEbyB3ZSBuZWVkIHRv
IHNldCBtcWQgYWRkciBhbmQgcXVldWUgd3B0ciAgaGVyZSA/ICBsaWtlIHRoaXM6DQogICAgICAg
IHF1ZXVlX2lucHV0Lm1xZF9hZGRyID0gcXVldWUtPm1xZC5ncHVfYWRkcjsNCiAgICAgICAgcXVl
dWVfaW5wdXQud3B0cl9hZGRyID0gcXVldWUtPndwdHJfb2JqLmdwdV9hZGRyOw0KDQpUaGFua3MN
Ckplc3NlDQoNCisNCisgICAgICAgYW1kZ3B1X21lc19sb2NrKCZhZGV2LT5tZXMpOw0KKyAgICAg
ICByID0gYWRldi0+bWVzLmZ1bmNzLT5yZXNldF9od19xdWV1ZSgmYWRldi0+bWVzLCAmcXVldWVf
aW5wdXQpOw0KKyAgICAgICBhbWRncHVfbWVzX3VubG9jaygmYWRldi0+bWVzKTsNCisgICAgICAg
aWYgKHIpDQorICAgICAgICAgICAgICAgZGV2X2VycihhZGV2LT5kZXYsICJGYWlsZWQgdG8gcmVz
ZXQgcXVldWUsIGVyciAoJWQpXG4iLCByKTsNCisgICAgICAgcmV0dXJuIHI7DQorfQ0KKw0KIGNv
bnN0IHN0cnVjdCBhbWRncHVfdXNlcnFfZnVuY3MgdXNlcnFfbWVzX2Z1bmNzID0gew0KICAgICAg
ICAubXFkX2NyZWF0ZSA9IG1lc191c2VycV9tcWRfY3JlYXRlLA0KICAgICAgICAubXFkX2Rlc3Ry
b3kgPSBtZXNfdXNlcnFfbXFkX2Rlc3Ryb3ksDQogICAgICAgIC51bm1hcCA9IG1lc191c2VycV91
bm1hcCwNCiAgICAgICAgLm1hcCA9IG1lc191c2VycV9tYXAsDQorICAgICAgIC5yZXNldCA9IG1l
c191c2VycV9yZXNldCwNCiB9Ow0KLS0NCjIuNDkuMA0KDQo=
