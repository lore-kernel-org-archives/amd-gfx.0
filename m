Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1009CD6E56
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 12:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C85E113308;
	Mon,  1 Jun 2026 12:58:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yRDs58hd";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26C5B113308
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 12:58:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9p42gWHRGlmmejxxrkLKFEv0jAmmftS/D+51oTeKileheJDRIEOajN42c91j6Ll5cU/cpq57JbcJAXfCfCUCvQjffe74koMyUh8B93/4uSW8Zn26HR2H57n8M2gcQ+kbiHwt6uuUNIUhH7VxI5G8kGg6VS830YZ3MERoYnOnohUvfjDyhGn7G15D4ZKFgpM7+ft2VJKFmJUv4ZQ3ROsueFcit6ixrON4ayuwl2ZlSoi0iuA0aKETkMnfdrYZDXMkq9Ox4qMMm3zLN1Jc+1D6W/etO9dpKICUc2qyAbEFGfqOkIulLYuoedIuph9pNHBArSSq5gXC+SY4EG8xmXc7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ii/b+GIrPBtcDwZf1/Fxzt9zQ8mYL9F3yuT9WzzrCYw=;
 b=Z5TEtXaXaQzjPHteH5wqcGYkhYv9ZUEwyp/+TJfesKoQVziia6nOKF+zn4imeSDDzw4S+S47t5s0dpJYH1J75b+j7RABshhsHnSMywpSFqy0HrLWmNKAXMocUUwrOz9MoInUbD2MrHQKfx0CekLQ/UlRuRzZm6QvHvI2i8FU6Qgi+Qt8Rw0boL2NfU/HS1VgmEhLpDqs4i+Qn3DUQMNR44heZRTH9op7zX8v9Nq7gYg6gFFLuKvippo15kOw7lEaeXPD90kTWAjIr00Nx3ygMfvrt/oT4VQrBEBXhFMrvDtXYMOYGcsm0yKI/7Kr24bHfk78tgQk3SotZSU/crDtTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ii/b+GIrPBtcDwZf1/Fxzt9zQ8mYL9F3yuT9WzzrCYw=;
 b=yRDs58hdV6vjSDRcgNlvfTVtXV+5LrgdGy+DdSq6/GsTPUpXN+Y4O7nSBDUsMusXwW7x58OYgWUbytoonR9kkViD1OvkSh9fcoLy2yT2dVeB68t/BYsY93svUtEX9ZtxyUuKbdUV/31bgUbp1nMlkR32rJkefU7f1za/wyp2nsM=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.23; Mon, 1 Jun 2026 12:58:54 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%6]) with mapi id 15.21.0071.010; Mon, 1 Jun 2026
 12:58:53 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Wu, Ray" <Ray.Wu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Lin, Ping Lei" <PingLei.Lin@amd.com>, "Chen,
 Chen-Yu" <Chen-Yu.Chen@amd.com>, "Wu, Ray" <Ray.Wu@amd.com>
Subject: RE: [PATCH 00/41] DC Patches June 1 2026
Thread-Topic: [PATCH 00/41] DC Patches June 1 2026
Thread-Index: AQHc7N9MX9RyssjS1U6hTP821g3tPbYpslng
Date: Mon, 1 Jun 2026 12:58:53 +0000
Message-ID: <DS0PR12MB6534EAEF1E4DFC8B554257909C152@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-06-01T12:56:58.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|DM6PR12MB4090:EE_
x-ms-office365-filtering-correlation-id: 4405272d-c862-4636-c9c8-08debfdd88cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|3023799007|6133799003|11063799006|22082099003|56012099006|18002099003;
x-microsoft-antispam-message-info: CfTh7zNU4DWn1IqUQnx0mCm4Ef1zRh/346Nvp7mZKNyVqTQazskSJltWtKcnDgrzIkdgMQouZCYbzikezKfsirjGqRHCd9KXzk5BiRVcHEEJpauJAtYdYeZG23VFnTqKmT5dmuS8Cfp9UXS1bsdVttm2if4gK32N6BUzT5adnxbVvEwp07FVuUM4wc3XVNH6C6lCFk6DTUbqU0knRWiikkmnrJHzrjdRTMoYbWh22hdUEqGtZuaeefRnZKkxrmoO51BUetpPO0PpXS/YA4wJ9zZAjF89QpUwssN4b/5h89gof8fLjGcjrbCvoaZyvhPiXCL4ZiHV7LDk4Rfg2pGIGoQaJdOFdgK+c10uTvBafk+yl9fkPjOvdxiNI0uTYvgLmqkj3wKoq5TFsgN70s5SoiMFcNbkyw3Ro0vnji+NtYVe+33pMVFZnLpU7PP5HhUcwAGpiPanJWHelJzXRw3b31V/RCMOCAtINSEmXCLGqp9yOE9s/BTLDCwGr6DHDlH99yOEjr5ILcAKeLZ7OZKxs14psPOHZTw/tWXHojvX+ZnHrJ1COEMiZkHgEoiGR0z4F5u0SEtDwRx7rLG9PgfX7U2YS6e0o9il+V4aoaBxRZS7xLxlevE+tfP/hoK/Jy1woDcwgHLVZdBHiTJgpVCHbcZUziHr1L//xZbr1eXfwKGYWa6yTY+6/o0HX9Wd1MwKJgJJ/MeE/SN+2qmMC7HwrGOyQppLpj0GxdX3eNmp84Gb1zgWJWPMLn9noUwDVNj/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(3023799007)(6133799003)(11063799006)(22082099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6l89FdDf1RxzGIBUQLZzmyVGHqpEIHorj+Zj8XwbyGt9d5+QCBZxiRuz7d?=
 =?iso-8859-1?Q?2a0BFcn8YbShi+/3K2rFx8UP6zw+KiwGPk8Mhb4POiklWY8rU8+oJHU9Yw?=
 =?iso-8859-1?Q?kpKWzupfYN8RsgkiqCwMn76vat1F2fvhP/i1AFlsZ+MOav4y4Btnp6sJf5?=
 =?iso-8859-1?Q?lUr1uhmceaL4qhSj5KawIrjIBoTNnMIcBlUBbjKEfuw1e29IDCVOS6HDKk?=
 =?iso-8859-1?Q?AyJh1LRdbXIxfgPxk37ligeNNNvz/YUjapgcWTmKvELbRVM6FV++KBtd+q?=
 =?iso-8859-1?Q?ikAW4UpIkl7MLGzNnULrYQMONcg70HsHCfpYU+7jexLjvoPevJqmq3Avzl?=
 =?iso-8859-1?Q?1G5HuOkO9ZaTO2RZKzpS2awdLUq4k2yrysXaKy+WULxGHqiq9CyllNKXy+?=
 =?iso-8859-1?Q?SfDD2TbsFw3l8tB4U5LYX/nYsbvk6UsyXR7xwI0I4kY21Xzafy/4hfJHGz?=
 =?iso-8859-1?Q?0F530jqnJZopL6lY19g9+ZWJZu1v695HSCCSe0hjBmupQ5JAKtffmdk5RS?=
 =?iso-8859-1?Q?0Q4OcwYkHvnVKh980mh2ynrfp6sjJmRy5arfs6tptBCcIfxMUjcZhL7lB0?=
 =?iso-8859-1?Q?Fv6+adeqQEM/rAR59pYFRZr+FWRfGvJgsI3WrDSLliMRAqv4sdNv8dI1Ls?=
 =?iso-8859-1?Q?rhKqQM/DJg+LqVz6B9AaxSqWT7YanM0Nj8pddE8K0HeJFL3bEZCn1W0h6T?=
 =?iso-8859-1?Q?nnguSvs8haECTfs09inuQw8HMp/7mNbrjkVsUDeUaXQaep++LqeNCKHu3v?=
 =?iso-8859-1?Q?TtBb/Qk808ZMguy289tl9BxPT8pgwYE7LjHGFfElK2GI1OMZv54c8VJp/P?=
 =?iso-8859-1?Q?1MP8bEC7liX9H2PhCV/jNKQRtzr214icJcYJ5sZ6dQFQ5mDkjStSqZU+4a?=
 =?iso-8859-1?Q?Q5TlHuwoUk1QqOKKZNyaeKcPi+IGRWyFOrz+LErcQWiGYeG9psujLVf6Vu?=
 =?iso-8859-1?Q?YwMxI8Ti4u1T9luUv6p+YE+kLTOn/n257k8adBCBMvmEQdAAT0a4c68YJ5?=
 =?iso-8859-1?Q?SQ13mkhbjVddF2DGeMliJmwYVSDpw+Grzscr3kOOhGCR4uSYuicqEI/Di0?=
 =?iso-8859-1?Q?KKgrn4ET/hLeH7gJ+5OlXQLWXCkUVhDfds4QdqDeByu3Vk/3tiHR7Oa8s1?=
 =?iso-8859-1?Q?fS+cg5W/AA21wMrsoNYrwq2Ap9ow4iib9JjU4wbpBCMKlK4IOeprgMFws6?=
 =?iso-8859-1?Q?jj2BnbLxendazWfjP7yOuNdSav7URWLdQID1QcfrqADMKc317/qGXKp3PC?=
 =?iso-8859-1?Q?8UZ1lhHiro1I3n8a3TuL3b2HoySQn7mNBqASYGkvCq8tWuI5HnpnI+egRZ?=
 =?iso-8859-1?Q?Ds+1kf0ZY2a0bKFvRoj9FA9O3ESZLnPADFo+wMzcFT7WLHlUno0rb+MA5c?=
 =?iso-8859-1?Q?z2acS7ueHatzTeOs474pI9wseHM+PpxnhUuz/gOHgttKGL2IWhm6N/i/Xr?=
 =?iso-8859-1?Q?QYfFxuUJ7PJjS7ou6cQjOJeTiNUG4k+AbcFOAOzGV+04mvYeYvEt7WSxDC?=
 =?iso-8859-1?Q?/1ii+EmW/HSVx/J5XuxW3yjae+7j7c6kpuzm8LFFeAzbYm3r7yT9MmPQjM?=
 =?iso-8859-1?Q?lRtKsxaeMKA7RIN4TJL7n4D5QQUG3FhIlCTz6YUNm+lCSeAIpDwz+qGWP+?=
 =?iso-8859-1?Q?Hf2DJJhITrYKofs1c19hHo+qUxfxPTcL58EhoMPqLmPOiIwK7SR+PE+op9?=
 =?iso-8859-1?Q?mYcNm1FIND/tlaCcY90Rj0lWpyJUTNz135mXwo4GPUscjqNmaHMbwXEJEX?=
 =?iso-8859-1?Q?FGtrHCRzuozo8TXfBnXspEewTjs+Rf5WjyBVbPiyETq3ZX?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4405272d-c862-4636-c9c8-08debfdd88cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 12:58:53.6759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T1k5W+N5kY+eBSYXGzICmZuGnsMDUowsiBkk8djs+0d/FXoJUUugDDybpxYJKqHlQF3ce/wyIY0cXzgrWiBy2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
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

Public

Hi all,

This week this patchset was tested on 4 systems, two dGPU and two APU based=
, and tested across multiple display and connection types. This week was al=
so the last promotion test ran on Ubuntu 24.04. There won't be any testing =
this week as we had a holiday this past Monday, so the first test on Ubuntu=
 26.04 will begin next week.

APU
        * Single Display eDP -> 1080p 60hz, 1920x1200 165hz, 3840x2400 60hz
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multi display -> eDP + DP/HDMI/USB-C -> 1080p 60hz eDP + 4k 144hz=
, 4k 240hz (Includes USB-C to DP/HDMI adapters)
        * Thunderbolt -> LG Ultrafine 5k
        * MST DSC -> Cable Matters 101075 (DP to 3x DP) with 3x 4k60hz disp=
lays, HP Hook G2 with 2x 4k60hz displays
        * USB 4 -> HP Hook G4, Lenovo Thunderbolt Dock, both with 2x 4k60hz=
 DP and 1x 4k60hz HDMI displays
        * SST PCON -> Club3D CAC-1085 + 1x 4k 144hz, FRL3, at a max resolut=
ion supported by the dongle of 4k 120hz YUV420 12bpc.
        * MST PCON -> 1x 4k 144hz, FRL3, at a max resolution supported by t=
he adapter of 4k 120hz RGB 8bpc.

DGPU
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multiple Display DP -> 4k240hz + 4k144hz
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60hz displays)
        * MST DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60hz d=
isplays)

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to)
        * Changing display configurations and settings
        * Video/Audio playback
        * Benchmark testing
        * Suspend/Resume testing
        * Feature testing (Freesync, HDCP, etc.)

Automated testing includes (but is not limited to)
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The testing is mainly tested on the following displays, but occasionally th=
ere are tests with other displays
        * Samsung G8 Neo 4k240hz
        * Samsung QN55QN95B 4k 120hz
        * Acer XV322QKKV 4k144hz
        * HP U27 4k Wireless 4k60hz
        * LG 27UD58B 4k60hz
        * LG 32UN650WA 4k60hz
        * LG Ultrafine 5k 5k60hz
        * AU Optronics B140HAN01.1 1080p 60hz eDP
        * AU Optronics B160UAN01.J 1920x1200 165hz eDP
        * Samsung ATNA60YV02-0 3840x2400 60Hz OLED eDP


The patchset consists of the amd-staging-drm-next branch (Head commit -> 2f=
689def76af155a850fa9b2693b12973953c062 -> drm/amdgpu: fix calling VM invali=
dation in amdgpu_hmm_invalidate_gfx) with new patches added on top of it.

Tested on Ubuntu 24.04.4, on Wayland and X11, using Gnome.

Tested-by: Dan Wheeler <daniel.wheeler@amd.com>

Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com


-----Original Message-----
From: Ray Wu <ray.wu@amd.com>
Sent: Tuesday, May 26, 2026 3:01 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Lin, Ping Lei <PingLei.Lin@amd.com>; =
Chen, Chen-Yu <Chen-Yu.Chen@amd.com>; Wu, Ray <Ray.Wu@amd.com>
Subject: [PATCH 00/41] DC Patches June 1 2026

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

- Enable DCN 4.2.1:
  * Add register header files for DCN42B
  * Add DCN42B DC resource files
  * Add DCN42B DMUB support
  * Add DCN42B code to DC and dcn42b_soc_bb to DML2
  * Add DCN42 PMO init_for_pstate_support
  * Enable DCN42 PMO policy and pstate pmo
  * Enable DCN 4.2.1 in amdgpu_dm
  * Enable DM for DCN 4.2.1
- Add no_native_i2c codepath
- Add amdgpu_dm KUnit tests for:
  * amdgpu_dm_psr_set_event
  * dm_ism_dispatch_next_event and additional ISM functions
  * amdgpu_dm_colorop
  * color LUT functions and transfer function helpers
- Enable gcov coverage for amdgpu_dm KUnit builds
- Extract dm_ism_dispatch_next_event and transfer function helpers
- Refactor amdgpu_dm_initialize_default_pipeline
- Clean up PSR helper functions
- Fix gamma 2.2 colorop TF direction in tests
- Handle aux_inst for connectors without DDC pin
- Fix DP_PIXEL_FORMAT fields & update clk_src for DCN4x
- Avoid DPMS-on for phantom stream
- Change default driver setting for "Force ODM2:1 for eDP" policy
- Add DC_VALIDATE_MODE_AND_PROGRAMMING condition check for force odm2:1
- Check for sharpening case when calculating max vtaps for scaler
- Add DRAM table fields to clk_mgr_internal
- Enable frame skipping in 0x37B
- Bound VBIOS record-chain walk loops
- Clamp HDMI HDCP2 rx_id_list read to buffer size
- Clamp VBIOS HDMI retimer register count to array size
- Reject gpio_bitshift >=3D 32 in bios_parser_get_gpio_pin_info()
- Use krealloc_array() in dal_vector_reserve()
- Fix NULL deref and buffer over-read in SDP debugfs
- Fix out-of-bounds read in dp_get_eq_aux_rd_interval()
- FW Release 0.1.61.0

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (12):
  drm/amd/display: Enable gcov coverage for amdgpu_dm KUnit builds
  drm/amd/display: Add KUnit tests for color LUT functions
  drm/amd/display: Extract transfer function helpers
  drm/amd/display: Add more color KUnit tests
  drm/amd/display: Refactor amdgpu_dm_initialize_default_pipeline
  drm/amd/display: Fix gamma 2.2 colorop TF direction in tests
  drm/amd/display: Add KUnit tests for amdgpu_dm_colorop
  drm/amd/display: Add more KUnit tests for amdgpu_dm_ism
  drm/amd/display: Extract dm_ism_dispatch_next_event
  drm/amd/display: Add KUnit tests for dm_ism_dispatch_next_event
  drm/amd/display: Add KUnit tests for amdgpu_dm_psr_set_event
  drm/amd/display: Clean up PSR helper functions

Charlene Liu (1):
  drm/amd/display: Add DC_VALIDATE_MODE_AND_PROGRAMMING condition check
    for force odm2:1

Chuntao Tso (1):
  drm/amd/display: Enable frame skipping in 0x37B

Dmytro Laktyushkin (2):
  drm/amd/display: Enable dcn42 pstate pmo
  drm/amd/display: Add DCN42 PMO init_for_pstate_support

Gabe Teeger (1):
  drm/amd/display: Handle aux_inst for connectors without DDC pin

Harry Wentland (7):
  drm/amd/display: Fix out-of-bounds read in dp_get_eq_aux_rd_interval()
  drm/amd/display: Clamp VBIOS HDMI retimer register count to array size
  drm/amd/display: Fix NULL deref and buffer over-read in SDP debugfs
  drm/amd/display: Use krealloc_array() in dal_vector_reserve()
  drm/amd/display: Reject gpio_bitshift >=3D 32 in
    bios_parser_get_gpio_pin_info()
  drm/amd/display: Clamp HDMI HDCP2 rx_id_list read to buffer size
  drm/amd/display: Bound VBIOS record-chain walk loops

Ilya Bakoulin (1):
  drm/amd/display: Avoid DPMS-on for phantom stream

Matthew Stewart (8):
  drm/amd/display: Add no_native_i2c codepath
  drm/amd: Add register header files for DCN42B
  drm/amd/display: Add DCN42B DC resource files
  drm/amd/display: Add dcn42b_soc_bb to DML2
  drm/amd/display: Add DCN42B code to DC
  drm/amd/display: Add DCN42B DMUB support
  drm/amd/display: Enable DCN 4.2.1 in amdgpu_dm
  drm/amd/display: Enable DM for DCN 4.2.1

Nicholas Kazlauskas (1):
  drm/amd/display: Enable DCN42 PMO policy

Ovidiu Bunea (3):
  drm/amd/display: Update get_pixel_clk_frequency() for DCN4x DCCG DP
    DTO
  drm/amd/display: Change default driver setting for "Force ODM2:1 for
    eDP" policy
  drm/amd/display: Fix DP_PIXEL_FORMAT fields & update clk_src for DCN4x

Samson Tam (1):
  drm/amd/display: Check for sharpening case when calculating max vtaps
    for scaler

Taimur Hassan (2):
  ddrm/amd/display: [FW Promotion] Release 0.1.61.0
  drm/amd/display: Promote DC to 3.2.384

Wenjing Liu (1):
  drm/amd/display: Add DRAM table fields to clk_mgr_internal

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |     1 +
 drivers/gpu/drm/amd/display/Kconfig           |     2 +-
 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |     3 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    29 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |    69 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.h   |    29 +
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |    22 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |     5 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |     5 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c |    83 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h |     7 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |    20 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h |     4 +-
 .../amd/display/amdgpu_dm/tests/.kunitconfig  |     8 +
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    |   568 +
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c  |   102 +-
 .../amdgpu_dm/tests/amdgpu_dm_ism_test.c      |   302 +
 .../amdgpu_dm/tests/amdgpu_dm_psr_test.c      |    46 +-
 .../gpu/drm/amd/display/dc/basics/vector.c    |     4 +-
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |    15 +-
 .../drm/amd/display/dc/bios/bios_parser2.c    |   148 +-
 .../amd/display/dc/bios/bios_parser_helper.h  |     5 +
 .../display/dc/bios/command_table_helper2.c   |     1 +
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |    10 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |    15 +
 .../dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c        |   483 +
 .../dc/clk_mgr/dcn42b/dcn42b_clk_mgr.h        |    48 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |     4 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |     6 +
 drivers/gpu/drm/amd/display/dc/dc.h           |    10 +-
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |     4 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |     7 +-
 drivers/gpu/drm/amd/display/dc/dc_fused_io.c  |     4 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |     2 +
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |     1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |   181 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h  |     4 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |    83 +-
 .../drm/amd/display/dc/dce/dce_clock_source.h |    26 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_apg.h  |    13 +
 .../dc/dio/dcn42/dcn42_dio_link_encoder.h     |    95 +
 .../dc/dio/dcn42/dcn42_dio_stream_encoder.c   |    64 +-
 .../dc/dio/dcn42/dcn42_dio_stream_encoder.h   |     6 +
 .../dml2_0/dml21/dml21_translation_helper.c   |     5 +-
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h  |   227 +
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |     1 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn42.c       |   223 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn42.h       |     2 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |    30 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.h  |    46 +-
 .../dml21/src/dml2_pmo/dml2_pmo_factory.c     |    16 +
 .../dml21/src/dml2_top/dml2_top_soc15.c       |    30 +-
 .../drm/amd/display/dc/dml2_0/dml2_wrapper.h  |     1 +
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.c    |     8 +-
 drivers/gpu/drm/amd/display/dc/gpio/Makefile  |     8 +
 .../dc/gpio/dcn42b/hw_factory_dcn42b.c        |   313 +
 .../dc/gpio/dcn42b/hw_factory_dcn42b.h        |    11 +
 .../dc/gpio/dcn42b/hw_translate_dcn42b.c      |   192 +
 .../dc/gpio/dcn42b/hw_translate_dcn42b.h      |    13 +
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |     4 +
 .../drm/amd/display/dc/gpio/hw_translate.c    |     4 +
 .../hpo/dcn31/dcn31_hpo_dp_stream_encoder.h   |    47 +
 .../display/dc/hubbub/dcn35/dcn35_hubbub.h    |   198 +
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.h    |    19 +
 drivers/gpu/drm/amd/display/dc/hwss/Makefile  |     8 +
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |     4 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |    27 +
 .../amd/display/dc/hwss/dcn42b/dcn42b_hwseq.c |   238 +
 .../amd/display/dc/hwss/dcn42b/dcn42b_hwseq.h |    15 +
 .../amd/display/dc/hwss/dcn42b/dcn42b_init.c  |    20 +
 .../amd/display/dc/hwss/dcn42b/dcn42b_init.h  |    14 +
 .../gpu/drm/amd/display/dc/inc/clock_source.h |     4 +-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |    21 +
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |    44 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |     2 +
 .../display/dc/link/accessories/link_dp_cts.c |     2 +
 .../drm/amd/display/dc/link/link_factory.c    |    86 +-
 .../amd/display/dc/link/protocols/link_ddc.c  |    60 +-
 .../dc/link/protocols/link_dp_capability.c    |     6 +
 .../link/protocols/link_edp_panel_control.c   |     7 +-
 .../amd/display/dc/optc/dcn42/dcn42_optc.h    |   179 +
 .../amd/display/dc/pg/dcn42/dcn42_pg_cntl.h   |    86 +
 .../gpu/drm/amd/display/dc/resource/Makefile  |     7 +
 .../dc/resource/dcn401/dcn401_resource.c      |     4 +-
 .../dc/resource/dcn42/dcn42_resource.c        |    17 +-
 .../dc/resource/dcn42/dcn42_resource.h        |     3 +-
 .../dc/resource/dcn42b/dcn42b_resource.c      |  2404 +
 .../dc/resource/dcn42b/dcn42b_resource.h      |   672 +
 .../dcn42/dcn42_soc_and_ip_translator.c       |     6 +-
 .../soc_and_ip_translator.c                   |     1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |     1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   606 +-
 drivers/gpu/drm/amd/display/dmub/src/Makefile |     1 +
 .../drm/amd/display/dmub/src/dmub_dcn42b.c    |    34 +
 .../drm/amd/display/dmub/src/dmub_dcn42b.h    |    13 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |     4 +
 .../amd/display/include/bios_parser_types.h   |     1 +
 .../gpu/drm/amd/display/include/dal_asic_id.h |     3 +
 .../gpu/drm/amd/display/include/dal_types.h   |     1 +
 .../drm/amd/display/modules/hdcp/hdcp_ddc.c   |     3 +-
 .../gpu/drm/amd/display/modules/power/power.c |     9 +-
 .../drm/amd/display/modules/power/power_abm.c |    16 +-
 .../include/asic_reg/clk/clk_15_0_5_offset.h  |    41 +
 .../include/asic_reg/clk/clk_15_0_5_sh_mask.h |    44 +
 .../include/asic_reg/dcn/dcn_4_2_1_offset.h   | 16304 +++++
 .../include/asic_reg/dcn/dcn_4_2_1_sh_mask.h  | 60622 ++++++++++++++++
 .../include/asic_reg/dpcs/dpcs_4_0_1_offset.h |   108 +
 .../asic_reg/dpcs/dpcs_4_0_1_sh_mask.h        |   412 +
 108 files changed, 85760 insertions(+), 342 deletions(-)  create mode 1006=
44 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_cl=
k_mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/boundin=
g_boxes/dcn42b_soc_bb.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_factory_d=
cn42b.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_factory_d=
cn42b.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_translate=
_dcn42b.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_translate=
_dcn42b.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_hwseq=
.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_hwseq=
.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_init.=
c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_init.=
h
 create mode 100644 drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_r=
esource.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_r=
esource.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42b.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42b.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_5_off=
set.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_5_sh_=
mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_1_offs=
et.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_1_sh_m=
ask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_0_1_of=
fset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_0_1_sh=
_mask.h

--
2.43.0

