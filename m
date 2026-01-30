Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47867E6BF0E
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 13:36:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5B8F10E05E;
	Fri, 30 Jan 2026 13:36:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AeJdErIA";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9286410E05E
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 13:36:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ez0OvFjHZc87/xdxnEOmCrRZcBvCTbgX9Sahlz0/P45ZH2WxUAXudRaH1G6bVqrJwAxuV1q/3Skp4MAKFIkE/LyiT+HDpheOkKNSVmLOhqrWmQJY+Vam1NrykauDu/Z7/pG2/VoXxz7r8LyD+FuJL14+Gerq2uNQVoIVEZ0/4kNSv6krXSt8elWM7tw/BTB0EGyYyc/gtFtqBD0/kWt8VqzGwe3IfG9F80HKQ+9bJJjHKFxP47Bwmb2u8Fdw8LBLFjFf2Dm4B1zLVzGgHscfkRhr8xOksE+GbWqeSEfmzKjyVNn69RBDij4DRnQrGIFVJ8JQZG8jqhVlmH3yBJuuJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzwrgkNI8ZRfdImLKE0YZ2KZwb4XtzKzq/4tYPJQ/4I=;
 b=JSqE5MFVVjyk2FQAGv6JddQyLPdGTHiS2I6O55Sss68JKCyViRDneupUvXoUA6pooVcOYV18+Qfi3I8kBXRahHmFwuJdXCTqFX3GiQw8y3jPD/66sQplWxEdnoZ11txZJwP1iJpuV9dzyRbmPlwRYjnlD2BXXyKrWecV65tWzV7GDrlyVkJ/6Llghluo0KnXeijufk4kOjoAtrkDo8X6Jpko5EgIC+6B5smFHSpoPfEtM+2ScgvgWNIE9qXnRSAn76S1h/ROHl62avsGkv4I844hom36u5OSZtErieRLCA4WggRKb0rNm3Cv9tMmw+cvcMzNdcczaKFNDm5utC2JmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzwrgkNI8ZRfdImLKE0YZ2KZwb4XtzKzq/4tYPJQ/4I=;
 b=AeJdErIAFjbRsoDT7bHJ1BxHY/vvw5dH318OGGNm7VguiOWswbYFmkGELKthkQOoRkWLJBtsPqoBcHmFBgcoSAsLJARG8epNqmrOvL0t8iHmPdJ777SAUX17hBdY+zYAkK774sMJ/chqcm829V44MdocWDuJrkwJgPuqCRgQcWE=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 BY5PR12MB4083.namprd12.prod.outlook.com (2603:10b6:a03:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 30 Jan
 2026 13:36:45 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%4]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 13:36:45 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: Rodrigo Siqueira <siqueira@igalia.com>, =?iso-8859-1?Q?Timur_Krist=F3f?=
 <timur.kristof@gmail.com>, "Hung, Alex" <Alex.Hung@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Wentland, 
 Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>
Subject: RE: [PATCH] drm/amd/display: Reject cursor plane on DCE when scaled
 differently than primary
Thread-Topic: [PATCH] drm/amd/display: Reject cursor plane on DCE when scaled
 differently than primary
Thread-Index: AQHciIrSX4sBSnW2Gkq68rw9KegCt7Vp8k4AgADXKhA=
Date: Fri, 30 Jan 2026 13:36:45 +0000
Message-ID: <DS0PR12MB6534D1B5FBAC94F08A28B92D9C9FA@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260118145741.36198-1-timur.kristof@gmail.com>
 <aXv-e37PeACx549L@atmagalia>
In-Reply-To: <aXv-e37PeACx549L@atmagalia>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-Mentions: ChiaHsuan.Chung@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-30T13:36:12.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|BY5PR12MB4083:EE_
x-ms-office365-filtering-correlation-id: b19ee425-f599-47c8-1625-08de60049c93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?a9l1QXwsp1nVxHuG+dHqbD9R+pq0dGzr1v9a1sfkrLSvwsdW3MAzyNRO87?=
 =?iso-8859-1?Q?EISXe5/KqUEInEuTXipHPCkbDpKT0GAS6nG57ApzJCELK7HPs2zm+ElxBX?=
 =?iso-8859-1?Q?mBIeY00SFZI5ZR6jC3QMmyATM3MPGPzA6HwEsSVoj8xDvSg1YqjQw4qkDC?=
 =?iso-8859-1?Q?q/7+CzJZQIU/NE8izWHdtW08WljW4Gtmx3pkzF0pjSl1LLc9YxHJ+Mo1bQ?=
 =?iso-8859-1?Q?yz3R25hZcqs6PZpfjxT+BYhzvGjDyARWf5ZwJcw1hZL6Z5rcn0eZ+Y2dkI?=
 =?iso-8859-1?Q?MqOf8zm5XZbSdAq2/lig6NWsT35MjVQsysjAMAsD9DkXu5FYlVKV2STsGy?=
 =?iso-8859-1?Q?vft5rTwBdFRdpwg29tvAuIyufnxk1UpZ7VHAJRV/fE3ANZyUxSuumsfqAv?=
 =?iso-8859-1?Q?+e4rtsPK9wAgz/8wCgNv3S7CtUZjI+zuVZmaxmSk9HUVXgES/OTjVauC0s?=
 =?iso-8859-1?Q?JFDzfH3Z5J/6T5LaKatAZ7owFk1rXVOXllHnt1LmOixG/qJD2VtSO+RgB1?=
 =?iso-8859-1?Q?vJ1IXk6UN8343tZVSmqoxCrgD3wMsOiqzLwmQS66829q+cmdi2qX3Dzu1p?=
 =?iso-8859-1?Q?W3MXBcGC2LOH+rvweFKpLrmivJioNO1A+Yjcj9Rsw+ykA+5ZR5f1pNvGG/?=
 =?iso-8859-1?Q?IX1bK3uAL4y7VQo/+aNeuhn9azCJWMmVGtgUdIPGB0jv/00Vi6yB7k3sv/?=
 =?iso-8859-1?Q?YDMPJkZ61jLBy8JzyZZwuE5YW4xU5kegtBHiOcgIe0dRumA8UWfXtqTqTo?=
 =?iso-8859-1?Q?X4ow6Hf8c4SAlrf/dbLgiqwypsQCbphD3qnYIPChXyxtyOdNsW6VRfJXhq?=
 =?iso-8859-1?Q?Cok4RksG+Oe7WvwZwrROYjFTf223dNTxV/nEjAt35s2Tu7tzzCCfcCLfX9?=
 =?iso-8859-1?Q?OTWx2O8859CK3N2QBCgtKaxDWkHQv8dQMwcYXdBUcroIP+GjALiFH4TUBk?=
 =?iso-8859-1?Q?7L05QnK0dW7x243x/6qSw6f8R6fCbZ/mKmG+8aoUCg3wVSMDRt72R9KJT9?=
 =?iso-8859-1?Q?DGQw0W5uKX0GMFyrCboDDn0RbRbyuMGeIxxXEY7jyzgDWWGbLkFqFBdNz/?=
 =?iso-8859-1?Q?2uxSqXSxCsc+xnO6uMgK4tY+AVnqyuncXTd/VRu/DvK0DoV1A0iTwqFIQg?=
 =?iso-8859-1?Q?eh9gzrXk8uILUujyw2PVgZ1UFkPGCASWgQkbqcATNWQnueVXrLfQfKkFZz?=
 =?iso-8859-1?Q?GiZnQG5bByPUSPqQLHCL1uQt8G1Yt2cfgj140IihZkzIIBK8vtfOK1XI4G?=
 =?iso-8859-1?Q?zz6aWnsEckt6I5YriMshoav/ohu8YLp6uvE1N5c2UUCxTys8LYIu1knlIV?=
 =?iso-8859-1?Q?GG1kLAS8vASB898CVLGPkuTtfhXtz/twUvzYzrBl9vaxM93W/xG71IOfnH?=
 =?iso-8859-1?Q?SoXpx7+Uz+OYG3QpSYE2dybEQK5xL/0VOm/8D/qgrJLn25YVESCCUgRFqF?=
 =?iso-8859-1?Q?f3h+HORfDngtstl732CZRuAWmg5JGOI96dvHKmsxxOONB5jB1kzN2Cl7Fs?=
 =?iso-8859-1?Q?f6lD47cNjEJ9LOau77/82kDkSmysSB37GGvM6QWJkF7VZ2/0ppdShJpcPO?=
 =?iso-8859-1?Q?Q+JmrTZUqUuAB2VxNC1wdJsS6QYtZv2KUEcc+ZvhUX58XDyMQtSDE73NMe?=
 =?iso-8859-1?Q?yrxGjjswEEq0X4i7qv7jZ/+f05sSzzRaps?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WCDfrIBN4saLa6KXklqk8Yc41dR7stNDGQC5XeLVaqTeTTzyRXdlrvJK2v?=
 =?iso-8859-1?Q?1VPa5gEQ1YeajhybLPt4wvi8e540A8AE0Fp2YpkqTBXLbsJpAHtR30IZtP?=
 =?iso-8859-1?Q?5KgWAg3gAUVRdrPDZwNIOxhdidrNjMfCNjbzS+3H5cEWlc1V/nR+KG2im5?=
 =?iso-8859-1?Q?Zb7g0sMOjDRuHarcf2ARoN2efp/aqQBLJqH5P0RIsAJ51ZV9Gh6WdMXZ9m?=
 =?iso-8859-1?Q?IiRVeU690ZSFcaf111gfeORmkqcQ/iBc7mqOIICmpcB0If/7HuuEvpcEhq?=
 =?iso-8859-1?Q?3NSAqs44LY4ixl4kBdcz4E+BI37P8D9iOJZRH3YaFw0U/DFiCljMDG+Guq?=
 =?iso-8859-1?Q?x/UpivvEx0DTc7YVimSUfrQBtqom0Y0dFuvEoVLjIG6SvJdLWO8wJH+zOD?=
 =?iso-8859-1?Q?loIPpl7l9OydMOKH944y5a+3H043qZB9AHBHrJR/hJ1fQLqSlOuqm+aeLg?=
 =?iso-8859-1?Q?FYk6jWpNHXVUZyBtVQaFxcfgnRVZoEXPqbPPY2nQQ4QsKAc+4J+j048V9R?=
 =?iso-8859-1?Q?ogV8/DsQ7+VZQ9hhQTz6tij6zKLJd1z9X4zJ0OpDUUvlaylFUQ69oEdOTK?=
 =?iso-8859-1?Q?GBPvDIvmWfw670cs0p5QOdXl5PAvIMykSJ4oXwOI50kO+AU7om2qQO9vqY?=
 =?iso-8859-1?Q?aaXH+uaAY/3eUrXFYiEQX5H9jEVHe3LdeHH81IVOrfP7pItKvqB9BgEf3+?=
 =?iso-8859-1?Q?I+9NYDXjhiGI6ZJymhN5zD5EBcBQvggHC/D3wgaYRpR4ozezdR7A+NV5aC?=
 =?iso-8859-1?Q?hWHVH6IkoHDzwNVQoRnJ78yoewOsKQ2iffanrnycI8ubENBSDbf/ssnKlq?=
 =?iso-8859-1?Q?/sS9DSHuJENMxA2OPT2R6QM4T3VvJ92BPVTt6zsGX0npHGQRECV46S0p1m?=
 =?iso-8859-1?Q?0vHHkgG+oflO/xLew9reuYb6ymLBjr87tceSWuH5PnWCUfISd5WysLFlri?=
 =?iso-8859-1?Q?KCbbiEFCIuZf8T2CDbocpI1L8f/C3m5KpDff5xiwsH/cpN5jbkRYdVEeyp?=
 =?iso-8859-1?Q?vyuNAOQplMMz+oea0btCcV3PbyGvkoQ98+T6dz+nA+IQ4EdngSkOTONJJI?=
 =?iso-8859-1?Q?FSLrCY4nx2ek1ME89jecGp2BPURrhLomWWhNiwUODc4jHgEY6Am7d4vnuC?=
 =?iso-8859-1?Q?PGySLtbgkjUm9ObvOVP235QxxIOdb/UM6F0R8lzpADOqGFVMf0HcsKjCCJ?=
 =?iso-8859-1?Q?ixBRxrYmSbJnqtpLAxwT5ZdfTVle9vk1EPGcnDQMGDilrVxSPO+2LKUi2G?=
 =?iso-8859-1?Q?M82ALZGQ6ZPT2ZOxS+f8HcQOyTbY/rEOiXhQWbzgWLAcYhWCKga0ysT6CU?=
 =?iso-8859-1?Q?QrvPVqDyHGECri7X7WepyNcAnwfhfMm5xp4ytelBjfhPWf+eZzUjt2RLX3?=
 =?iso-8859-1?Q?e4G10FUfvlOEJWpdIoLkk1jCYnhz7XTppqYwMk/ILzDfAu88i+gfE89Sdy?=
 =?iso-8859-1?Q?wj+6e1dZeA0iPjmFKDJME/PuwT3OEblxofjxSOcv9hDXO7JD3ALuqiwGBY?=
 =?iso-8859-1?Q?7Lxdivk2bdlK7gf9U0MltbJKYDroWkzlxv84l8ZjAsTpL1JETB/bnnq0qX?=
 =?iso-8859-1?Q?bavpcuu9CsY/0EhKMlDubUAU7U5l8VsXPU557vgzsDzxqeScwx5eIeMDxM?=
 =?iso-8859-1?Q?0CVqbcI8X945A4Urngu6ZVJl0fkUZDKYtf3DXaCRWYghvCAqxzK2YWlVMI?=
 =?iso-8859-1?Q?mISYaB8E6EtGncGEU8O25Ru2Sd03XdUp0HVb0xpMcZIPFIC/jJLDFN3t9q?=
 =?iso-8859-1?Q?JszkqOjyihtcs0/X3inI5MdkRUzwy/oVezlDZMzC448Gdt?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b19ee425-f599-47c8-1625-08de60049c93
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 13:36:45.5752 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j23deS7PkEZ4gbR6yaoyIrXXNWf95568hGSEHP8oMm8mQA6O7aW5mDTVt/jGusC7gYf929ffWKU/fxnpPnI2ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4083
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

+@Chung, ChiaHsuan (Tom) as he's running promotion next week.

Thanks for the heads up Siqueira!

Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com


-----Original Message-----
From: Rodrigo Siqueira <siqueira@igalia.com>
Sent: Thursday, January 29, 2026 7:45 PM
To: Timur Krist=F3f <timur.kristof@gmail.com>; Hung, Alex <Alex.Hung@amd.co=
m>; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; LIPSKI, IVAN <IVAN.=
LIPSKI@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Le=
o) <Sunpeng.Li@amd.com>
Subject: Re: [PATCH] drm/amd/display: Reject cursor plane on DCE when scale=
d differently than primary

On 01/18, Timur Krist=F3f wrote:
> Currently DCE doesn't support the overlay cursor, so the
> dm_crtc_get_cursor_mode() function returns DM_CURSOR_NATIVE_MODE
> unconditionally. The outcome is that it doesn't check for the
> conditions that would necessitate the overlay cursor, meaning that it
> doesn't reject cases where the native cursor mode isn't supported on
> DCE.
>
> Remove the early return from dm_crtc_get_cursor_mode() for DCE and
> instead let it perform the necessary checks and return
> DM_CURSOR_OVERLAY_MODE. Add a later check that rejects when
> DM_CURSOR_OVERLAY_MODE would be used with DCE.
>
> Fixes: 1b04dcca4fb1 ("drm/amd/display: Introduce overlay cursor mode")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4600
> Suggested-by: Leo Li <sunpeng.li@amd.com>
> Signed-off-by: Timur Krist=F3f <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 655c9fcb078a..3e1ba5521f2b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -12262,10 +12262,9 @@ static int dm_crtc_get_cursor_mode(struct
> amdgpu_device *adev,
>
>       /* Overlay cursor not supported on HW before DCN
>        * DCN401 does not have the cursor-on-scaled-plane or cursor-on-yuv=
-plane restrictions
> -      * as previous DCN generations, so enable native mode on DCN401 in =
addition to DCE
> +      * as previous DCN generations, so enable native mode on DCN401
>        */
> -     if (amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D 0 ||
> -         amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(4, 0, 1)=
) {
> +     if (amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(4, 0, 1)=
) {
>               *cursor_mode =3D DM_CURSOR_NATIVE_MODE;
>               return 0;
>       }
> @@ -12585,6 +12584,12 @@ static int amdgpu_dm_atomic_check(struct drm_dev=
ice *dev,
>                * need to be added for DC to not disable a plane by mistak=
e
>                */
>               if (dm_new_crtc_state->cursor_mode =3D=3D DM_CURSOR_OVERLAY=
_MODE) {
> +                     if (amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D 0) =
{
> +                             drm_dbg(dev, "Overlay cursor not supported =
on DCE\n");
> +                             ret =3D -EINVAL;
> +                             goto fail;
> +                     }
> +
>                       ret =3D drm_atomic_add_affected_planes(state, crtc)=
;
>                       if (ret)
>                               goto fail;
> --
> 2.52.0
>

Hi,

This change lgtm.

Alex, Dan,
Could you include this patch in the next week promotion?

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>

Thanks

--
Rodrigo Siqueira
