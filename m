Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59D4C43602
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 07:11:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85F5C10EE03;
	Wed,  1 Jul 2026 07:11:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="rSfOMbzm";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022099.outbound.protection.outlook.com [52.101.96.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 752A210E269
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 21:08:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BU1R0IZ+qdcU7uCCwKYMmY6ENDSy7CQhpV3ZMPdSeumkYJ1UPbCgGmPeW//ijqatrK01A6FWVJqbGmOmj6Fjjru1pfntZENi93zmDnVe/EBOa/DOE3VjlCP1ePc+Bu8FDSSk0vUdgCaT2JBC2wCYv0vIQEnhB/xh/GtDmefFr6fRflYka0jEd9CMntLUyIEEXXq4fyDjb8bAEWRUZg8Uqv7jrgQR1RYgCJ4fXOcVd3eDX3vpG3hK11N0GZS/P8LxyFV1j4cC2320zS5gi2DFe5VntG5rOAA6txLur4wmW7xpXtmn1Gw7a185q6zkWaCMNlNlMiYUlbpXRoe64sSSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2hHyOez26kpmVbCG2/oGhKzOFtimypMq0ksV1q3zzI=;
 b=pMeRiJEYYqptIZEKXAx5vkXW+qAnhfMk4vG02g5Muatl4WbbBAIW1ZQkmJOcwDC+BHwTBBHeI/kcqhzUxW/tTX2Cs4wQk8I8rXmNIzj5wENq5tnvTmZ35j1XThS0l5L3Nqwe6Ma8VGgAB+yf8NhCEQAOh2uQYSi8rcR2B91kwExW1oZhkNXd1zYu9ZTGsaqovE48HdNOia0Tdv9RImSpdgE/GthFRWhOH1E8xy3R00oWh0CU497J2Ts3r37CH4EOe2n6tXxJz2ywwhjriouPOumuG3zeYnE3toHPVhS2eM6hZdoZ3uDbZqiMEmuJr27PT/jGbuef6VXaQUojb97DLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2hHyOez26kpmVbCG2/oGhKzOFtimypMq0ksV1q3zzI=;
 b=rSfOMbzmrEhtxPRN9nF88R0z8ZXsodfKFB8KdM+zr8zJLd7s/LpG0VvjlOztce51LJJlScCPXzL782zRD9jO0q3LW4IYOQ++7SaCaEBcdBr873mOinUgG5Vxd0z7P6bsCV+Q/TA2QlsHAAQUto+LN79c5o3chOBnTq5RXaKbMkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB5604.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:25f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 21:08:41 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 21:08:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 22:08:40 +0100
Message-Id: <DJMOWCCMNNEZ.2XWS9942F7KKU@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>,
 <alexander.deucher@amd.com>, <gregkh@linuxfoundation.org>,
 <ojeda@kernel.org>
Cc: <christian.koenig@amd.com>, <arnd@arndb.de>,
 <rust-for-linux@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rust: core: implement rx580 state optimization
 engine and c-to-rust char dev
X-Mailer: aerc 0.21.0
References: <20260630205750.22673-1-breno3011alves@gmail.com>
In-Reply-To: <20260630205750.22673-1-breno3011alves@gmail.com>
X-ClientProxiedBy: LO4P123CA0483.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::20) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB5604:EE_
X-MS-Office365-Filtering-Correlation-Id: 814a138f-36b7-42ba-3a85-08ded6ebc2ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10070799003|6133799003|5023799004|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: s4OdrA0Paf7ZVkWdeJIjezUFdDaq/a6NW68VwcjueInbyiJYG/f/C1tp8c+Uj+FfFLEu2Wp8q+P0GtSVKw+luPde+9R4mqzR8rcAscW32yqaWOx05d4XNxtAZUeTfbOVnnd4M1kOKc1Al+ppDjcEervmp6CmcgU2nwwvcJfrhvgQHAmj1xYnAZacqaolsVp+vKVIvy4t8oV35KGOXcNUwu+IMXCvTO/j4IF7O+6KLbay6674/OtKg1OrVBel+KC1oLxPRSCwQCkiLAjjXJYYF+zH9/WOtW7n8bhbJkeG3ngSrFja3ymKjYFn9m9CSnPYsMq5FkkQqG0UDtcOSBZf0u3VVdINzq/WtuEDeaHfBLre2BbX4q2UxB5QzN3ipPC/xRc3VeKXk/8aqzNFzdYJ6HSyomDWHT/cjIiwOVGCVS8ITarTNePyWX7nfHyKSCubGUCf9W7A2E43vuNMyyZ26kbIVVPHBP4uOBJiYxteIQb2TzUAMQ1XwLTC6kpRMvPUXkUeCrib6WkL2rhmSC9Xx1k130N/fGOztqBFUDB1vhmY5OfVRC4kROZku5HMDQWg/1iGL2YIlKOQQyQaButo7ZWKSPHRn3okOOWYkX9/P0eEi4VbFMj1CwJXqrIIzkcC5dkRTAmT5AP/yqFmWd+U3cjmlRKC3IdG54HL4BCEb9c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10070799003)(6133799003)(5023799004)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG4rUlJBdDl1dlBCcExVWldhY3BpTWpJMVlLd3E5d1c3UGVVUTZPTWpuVllL?=
 =?utf-8?B?cjVkQk0rcC8xb2lXUGV0c0hnVmZDQUpMR2V6Wk5FQ05vdFVHZ0FLSWxJQ2pX?=
 =?utf-8?B?bnB5WGdSUFNZRUkvZlZMaUJDMTV2R21DVzN1YTB4Y3hhUDhzNzQ1VlJBZ1dS?=
 =?utf-8?B?SGpnNjRxcUk3djNkYndzSHI3MVZqZ1orMGxUM3dwdmVoNEFhUjMyYm45WWJQ?=
 =?utf-8?B?SDlaZ2x6czI3Y2Yyd2RTb1hsYU1IZ2VoNHZBVU12eWRuaU1oOHA1NUozY0tD?=
 =?utf-8?B?OHkySks1WlVSbnY3NXlSUk8yemdCT2dBV3ZacjZ2eE9NSTBzNjJUNFM1aktj?=
 =?utf-8?B?aW5UUFJTay9oNk0zb3hiU3IwOUJSOFpvYmlmdjlPSDdhUzgzMEN6TGlGUDlD?=
 =?utf-8?B?Vkh3VFUvSnBMV2VGNk1LYWZDdVB5OTlSWWpNNmt5Q3hCTVB4aFRjQzFrd3lI?=
 =?utf-8?B?SmxEOXhNL3o1dnlXQngvcjBCazFaZnFQUzRvWkVNM2RvSVR5UHI2ZThITWtw?=
 =?utf-8?B?UHNzNjNtMGE1emJnWHkxT3pwWEt4bHA4YmF2dWhMWW1nVzZRRDNwbTFPcGpo?=
 =?utf-8?B?NzZlckUySFFQQTFEcXhDTzJ2TERXeGVKckEvd3JrZi9ITHZJaGpFNHcvV2Va?=
 =?utf-8?B?dHlEZGFMdVc4bUlBVlRscFRQbDVkb0lQdHNpZHd4OXBNbEIydzFyTXVhR2p4?=
 =?utf-8?B?bmZpdDJDNDhHRnNmbm9XLzdXT1NRR0FFQUUvUnBFOXN1YnVGeTBOak02cFRV?=
 =?utf-8?B?YmxuQUtsUno3cXpKRkNkZ3F2bzFwTVBlZU1iN0h6NE8xN2NOa0s4a3VzMUd2?=
 =?utf-8?B?akc3UXVYSmlQV0lZSm96ZDZBMFh5Y1JkWHFmR0owRXcwVzN1ZGZ2WnRZZmxC?=
 =?utf-8?B?NlcyWlhSdGN6LzZ5cFBaSjZnWjBtOE9OSTZmYm1MbnF2eWs3UktxT2hqUkVm?=
 =?utf-8?B?VnYzVDRPWS9UbFBvTUhia2RJRUs5bDFkWFNRalZaeG5KTlIvT09PSWo3N3VJ?=
 =?utf-8?B?dmVsV3hESE5teGtQU2tYZzRsMFlENTkwVEJRUGdyWmVpMVFpV1J0cXZqNTRy?=
 =?utf-8?B?OVNZeTdqYWgweEdXZ0pqT01DZCt6UEtMM1Y3dW1MMEFydDUyU2pydTdVWEpp?=
 =?utf-8?B?QVBKQyszYktobHZLNkllNXRUMXU2VE0zYzBTM2NVdEZ5UG1UbndCUGNya2c4?=
 =?utf-8?B?eWQzTTBMa3QxQVNmMVlCcWp0blEwbmhFTkRXMjFGWEw5K1hNYVpwVnRwVk9B?=
 =?utf-8?B?NDZMU2Mzb0dsbCtqbTg0eEZFdERyZ3JlL05mZnJ1ZndYSXRrWWc5RXpiblVk?=
 =?utf-8?B?ZTlJay9oQ1RVSDlXM0V0dUVQdnd5RkxBY2l6cmZ5YzlicktzYnhQSkNzbHEw?=
 =?utf-8?B?Z3N3OVRGdU0zQS9VdE96MmFPb2tDZWZUZ2lSMEVKUkJNWXhxQUtOK0dDOXpY?=
 =?utf-8?B?Tk1NMGNoNHdkczBwR0o2ZXlyUVYyQ2J5R0RnVm9ua3QwUW10K3NWNE5iU08w?=
 =?utf-8?B?alU3SGthaWxqVURYRkI2SUoydFRDbjN5bmpacWZjNkVhZVlVOGp2L3NWa2w2?=
 =?utf-8?B?WmYyRjBvQmhRYUR0TWV1UU9TUFd0UU43eUlIcEJMNTFJT1Vramx3MHFQWFRk?=
 =?utf-8?B?a2FIZFI1bTRibkN4V0ZWb2c1NE40Wm5qN3kwM09IbWdUbEcwVVNMUG1DRXlN?=
 =?utf-8?B?a1J3M2tjbTdlcytvVjRrTUlKaG1uLzQ0RU85WFhnTHVsUmFOUDBjSnV0TDBq?=
 =?utf-8?B?R0RLVlhuTmxTZzRSa0FWN1ZZeU1TV1FLdlpsMUVISnprK1pyNWtyWlNzeVVZ?=
 =?utf-8?B?WVZYZ2JiRWxJODBWNGU2NkkxZXJCV1B3aUJKb1prdWVuNkZ2Tm9waUM2TFJi?=
 =?utf-8?B?a3U2RWNQcTFXSEU1WWJ2eXNtYlFIdXVXWVBvbjJNbExEemlpK2MybVE2TW5G?=
 =?utf-8?B?NFY0Slc1eDNCOWlvK1lUaWw3OTVIMURWZnFhU1FnMHdYMDhKQnJYYVA4SFNI?=
 =?utf-8?B?UzZXU0VjcHBEdWV1L1NYMlV1YW1tZU9PWU1RNlNVdHY5cXMxRUl3REVjMkUx?=
 =?utf-8?B?NWZkbUVxWnl3SmVNY1JaUVhjRTBFTEtGKzNOUUV2WjFQMFJIakdFaFNjMFZ4?=
 =?utf-8?B?U05wNU1SZTZ4amd4cHpkZ21IWjFiQ3RIVnlVM1lLVmhDejdORmtMVlhyRjF0?=
 =?utf-8?B?aFJISG5xY1VENE1TSHk1cE9DZVdxbU15NVdYZy9jeWRnQkFkak1vdVlCcS9L?=
 =?utf-8?B?ZzQxOUNXSU9BQVNKQ0VzVG1wdUZUcG82RUZPcnJpbFhuSkI1ZGVZNlljMzRk?=
 =?utf-8?B?ZTB3L1J6SHYyRFpBNkRuVS9GN04wTmVOb0RGZERHR2E5c2VkcFpqZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 814a138f-36b7-42ba-3a85-08ded6ebc2ee
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 21:08:41.0220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpqCEvqAJ9IBvvFR3rz2u5zMn9uAYrZi20j45ZKGqFMwqF7DU5QoITHgpEmH2jY1RfAq/vXaNtb2plm2aO+t2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5604
X-Mailman-Approved-At: Wed, 01 Jul 2026 07:11:03 +0000
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

On Tue Jun 30, 2026 at 9:57 PM BST, Breno Rodrigues Alves wrote:
> This patch introduces an automated indexed state mechanism to optimize
> VRAM latency and command loops for the Radeon RX 580 architecture.
> Additionally, it provides a converted C-to-Rust sample char driver.
>
> Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>

Please stop sending LLM generated slop that you haven't even build tested.

Best,
Gary

> ---
>  RUST_GUIDELINES.md                       |  3 ++
>  drivers/char/Kconfig                     |  8 +++++
>  drivers/char/Makefile                    |  1 +
>  drivers/char/alves_char_dev.rs           | 26 ++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/Kbuild        |  1 +
>  drivers/gpu/drm/amd/amdgpu/alves_core.rs | 45 ++++++++++++++++++++++++
>  6 files changed, 84 insertions(+)
>  create mode 100644 RUST_GUIDELINES.md
>  create mode 100644 drivers/char/alves_char_dev.rs
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/Kbuild
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/alves_core.rs

