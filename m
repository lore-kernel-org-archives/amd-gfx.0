Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B30C36014
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Apr 2025 20:58:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEFFF10EB4A;
	Thu,  3 Apr 2025 20:58:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OhjBm/ET";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69EEE10EB4A
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Apr 2025 20:58:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUotoaecIfdZuDPgCtMRo+hepMIMQSoORL2K6YApk12pPjxim1+7IY7C1ckLMyBd4IKgAcP2LtOW/pKbs3v4BfSEKxtaf1OSxi7aTS/6UVepMA28s0mohDr/UQGn4TIS4nomxvvOjr17meN5VhS0zlMjT7cUTq88Al8N1H7J4bXGLgFmXF8U6/EC4nk+ommNGWWjkhVFhGwPygoFjymheN72F96WYlAebGelKJQUtDKuKc7cZ01XaP0tGMTq7WsVHPIobDdqzFGlp0AC8hsPhytrt/6akn++r8B6coMQ+yza5h28sDU1XfOekKRBrM0wNkWkilsbDBGp3o80oh3KFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3W/I9SCIlM402kPWQxVXN2eABdvLgXHBxDwPNAYnag=;
 b=olcDfzI7BqEp/XDju/6cPAGAuwUXKg6quE1LpzePne7FJksemGRN51Q8g2TAN/f1Vg72vQi5NoyslqjRmxPk+eeHAWyf1LYGYm1yOH2w0nyB0sxgeeLL1GCwbtJlWOEJ3bXkihnfBcwtMYg3ABQ5iZu/mG1gIsSVuKyI3HA7Ngl0ZelE0ul8Vc+sGmdrx6Vgbv+coGIwhNK7ynf+zYwZzvrV6R4GfAYRMBU9QKwkluUqCgokrczAeHMbLBVLwQBLBTlgfWHdhfqiy8cXE/FtwXXRu32+w0VabKsfR9wpA2Vl2Dcjgef+5bw3SNB6pVmHGm5UJ9cTbRBt3hP0qvmRRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3W/I9SCIlM402kPWQxVXN2eABdvLgXHBxDwPNAYnag=;
 b=OhjBm/ETQdZmIw44QzdcxJV5VesVaVNQHOW8sxkkJ0ZrNVr9/tQM19Nqr645OwVQIees8vsPjVUejA8FMwHfhyIxzOyYcEaW8p/A0f5mA2lDEaDu3Kt8Hi3e0LsctdiKmVXkBXYYW9D3BRzzA7XauZr5AXcFQgVg0V04tZy3Z8s=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SN7PR12MB7451.namprd12.prod.outlook.com (2603:10b6:806:29b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 3 Apr
 2025 20:58:29 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%2]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 20:58:29 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Li, Roman" <Roman.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>, "Li, Roman" <Roman.Li@amd.com>
Subject: RE: [PATCH 00/16] DC Patches April 02, 2025
Thread-Topic: [PATCH 00/16] DC Patches April 02, 2025
Thread-Index: AQHbo+o0JgLmSsdQy0WrRW6eB4AtWrOQybpQ
Date: Thu, 3 Apr 2025 20:58:28 +0000
Message-ID: <DS0PR12MB65347B522664EA0A233A73CB9CAE2@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250402161320.983072-1-Roman.Li@amd.com>
In-Reply-To: <20250402161320.983072-1-Roman.Li@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=bd1ca0d5-26b2-4307-a762-ffa1df19a6c2;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-02T19:53:11Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SN7PR12MB7451:EE_
x-ms-office365-filtering-correlation-id: 1ed9d6d5-bcf6-492d-5b6b-08dd72f24919
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?j36NqlJIiddHFh2Mebprw7gjY0imgK1g7CnxXuj5I+Ahk//+Gouxf932Zj?=
 =?iso-8859-1?Q?pcxTD0wBDLcHIVH9nJyIRmASw89zEMojOxU4+JxReZPfroqkgN20tAU8Vk?=
 =?iso-8859-1?Q?mxSwu3+wyLm6+7VKrWsBVLCAwHggzyzeJCWsF+sfD1UQSNqvvAAvp8FPLM?=
 =?iso-8859-1?Q?JdBwVl88z/zpS1227BD7qZgXd1QZVnhnlIw95zDqfK1qx7wfEGx1e3L1xc?=
 =?iso-8859-1?Q?r/M5XGY/mRjbRzpjZz1AoVxVvecaOUHIxpMwHurENsa3+5SYUfQGiU1PkV?=
 =?iso-8859-1?Q?0k00PFG2QQVWo3Q2tviw0YaNLpo1+Mm3haa7IDaEwFwmQxIbZM77tED7/R?=
 =?iso-8859-1?Q?93XqRP7YmHpaaiYgDmeLgQisS7fCNj+06kUGol+pFs+fCifoZ2P+lQ/Th5?=
 =?iso-8859-1?Q?TLog3z8yRI3l7HI6SqCSOwlIlXPXqIfePS2H7NZKf+rQMdq8Gm/5GANliR?=
 =?iso-8859-1?Q?+sjRXa83AF75+6tAcst1WijMBfuib5wY/Fsr8WKrXtPPFym1rVP/3PLRTD?=
 =?iso-8859-1?Q?GBGyGWm1ak3LbF7A4vwW/A+m2aK92t/i1H9BKjk60lBMtvF+b1NrMvq8vu?=
 =?iso-8859-1?Q?N450BOpx11oAg1Zir1g0JWqNoicVU6JKiduir4UcGm4gyeLL2qkNIWP7o7?=
 =?iso-8859-1?Q?RPn19o4t57MIXcAAaDPSd9dTAGsj+YWNWwSCSQrFgcaE8rACGlyz62YWCv?=
 =?iso-8859-1?Q?VJD8nGNxKlWgNOvhlxRfJALJM6yElX7VGRHzkyk2UPbuSu8vbW9tIG0Hni?=
 =?iso-8859-1?Q?ouRPBg189bDYhlwk+GuLZa2IKCznjSib2ymWu9SBQa2AvMfletfNRKhUN4?=
 =?iso-8859-1?Q?PpIPreDeIlt6AjTUCzL1mRiJR9Jpha3gK2sEVvrEXANBTEY5EuXFADBNnp?=
 =?iso-8859-1?Q?OKSNU/Ep+REgsPFHvehIsBL1EQuJNgOKZN5Qk6PpXu4KrylhPTEq6mU4hi?=
 =?iso-8859-1?Q?w2jgJeUtCdhIX8KfdfcvIzvhO829HkthoXXwkEGlRlPIGjEWZggslGOtAZ?=
 =?iso-8859-1?Q?vkJ7yUvgMmMkU6SieSWVPMP7wjF38+AV54Cl670Ox9NJYZ8Q5Lt75FML2e?=
 =?iso-8859-1?Q?hf5QdL345bLNGC89BYMOQ5SUH3CNlcrTXjJpjilokoOmi0vCPf42Gshj27?=
 =?iso-8859-1?Q?3/l5hbHOTdQrPRwNN+vbGYGRwx19M+6pJH9ZbgsxNm7CbIvhEQXZJWN+ox?=
 =?iso-8859-1?Q?QdHWJpFsL4Jv5O10UdnN4xhdDzSgOGgQb1aVpYk2amibEFCcLQS8TWst2z?=
 =?iso-8859-1?Q?mXGtOmfcQMnXzMKQwlrwWjqYOrRX92PaxOyaWcjIedA4g0LKV4Dlx49ell?=
 =?iso-8859-1?Q?kXHdH4tz7cwx9Pdv6RdLpn8RzBBuO5nCHB4iEZNH18anBl1bgUJOabCOTN?=
 =?iso-8859-1?Q?wuT0/ITvALMauxxabv/pZXhjM0fzKAQEnUyZsPm+VR/xtzseS9eT7bUD/n?=
 =?iso-8859-1?Q?qVu6f1Lj2fjSUAj5tJ0jIAuYqnHP4jMnG5kywGhQdfiEvpvNTmjq7rs8xM?=
 =?iso-8859-1?Q?Glqfps4yjuDwHyanxchTjg?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yADyuM1NKu0OXRTlKkzCMj4M4XYB0H68+pAc9za9+pk5uEgDXWeHD5Zx07?=
 =?iso-8859-1?Q?vC/uk2TTn/XzIgr3zqfXSy754JD8bd09u5SxOl08XRp3oKs6cJEq70G6p9?=
 =?iso-8859-1?Q?mQEkVwU9lmrW88B+m9VDrCsgKjbZzz6e8Bz9K8ArsiLs6JkY6/Z3WWk+Tu?=
 =?iso-8859-1?Q?Q1gTdLtj810ItoZAyo06ZmjqzhCM+3XHKUHB4LVJWi6WPvXzqmIH87yW+W?=
 =?iso-8859-1?Q?PivmUOyS7RuvLUEnhEWw4WepypHNl8fsSXop8xc+ubmezCGGb0bvHCfk0B?=
 =?iso-8859-1?Q?1aRjK1QaKXMjYIj/DcPb4o/MYECQ7aQdnGF8VZaJ0HC3krwFDZkeVmoeiq?=
 =?iso-8859-1?Q?zo1D3lZmq4VDOS+WBfb92Ai4dkjhD3fHxWEs+WIsY3VlhACS2F3N7HELV9?=
 =?iso-8859-1?Q?CSTMk2olaVzZ7Ol+B7ewk3l23ovJdM0Jff5jTk8jGEst9Svjb4NW51gmX1?=
 =?iso-8859-1?Q?SKQv895WflSxqeKi+iHHoDV21QoLCDcKIYST8Yv/8RHQP0FbRk3W2fmym7?=
 =?iso-8859-1?Q?6PhunuP+RkeedQ+DGbYQBe9k9ejQHnnkIMx0IX4iHA7AVvxSaJZOx7PRh7?=
 =?iso-8859-1?Q?GClLUPPGDKs67W8nbSzcxe3+B/trYfTjPydkYZ2JTFpi1XebEGUzQsSpeP?=
 =?iso-8859-1?Q?65Rv9+j7spALZfTMPzQpCqLNznVO5kc6bYSYJx6r2+nu1yigqih3n6piWh?=
 =?iso-8859-1?Q?hVm5RM1xAz2PFWy/9YDlDN9kub7+tcEKS1xaLM4Ml7GNf0ib4qIh6lrR6X?=
 =?iso-8859-1?Q?RJ/wWPoZLSOwgnguyt6XLTpAP4BxPMtR/DCy6bPuz8dQmiJdQ42Hdnls4G?=
 =?iso-8859-1?Q?E6Hop7+ghbJfPq2LWEsgQO2hvc9CE8n88u+3+eFeuKQT+xkRTZFEGML0qq?=
 =?iso-8859-1?Q?As8/r9GLPO4712UICUM3C/PbQ5FNzJexWeXDbJXCh9AfprlCvbVb65dGH5?=
 =?iso-8859-1?Q?7WgSpiLQWYv+PnimpaSbxhyAmyboxBSzCOjNB0h+CWiVMHutm4S/tqukzX?=
 =?iso-8859-1?Q?bb7auuV7vFjwztzXRvz3ocxq4fpY8WMCAYgCzyPAw31AF8zY6e36s8c4JT?=
 =?iso-8859-1?Q?VaFnwaxxueO0HIFxj6IYCezn7ikMzPbUCGX5qWGwn1tSvAK9WDVDvmrMYr?=
 =?iso-8859-1?Q?k8uuxTPrsmojrp9/ZFJrNK3BEzfJ5GIguN/vHSMYWyIFj8m+tJEd2Kg5Cy?=
 =?iso-8859-1?Q?Xeo2fgBm6RALkLfW7W7jsZTTKJ8rAwfFQ2XGYH2FZGjixUOrrVWhChwp+b?=
 =?iso-8859-1?Q?xs0aCJc9TvoYG6ngdQxsW8OMoZ1jMn9c90BpNCTkdbL8BUI6HnjjiJAcJv?=
 =?iso-8859-1?Q?Sa372o546/9/FahrR+G4QFRvXVgh4eugeabK4Bfk2gLJuFoloYEZ/Xunb0?=
 =?iso-8859-1?Q?/XDk1V9yc4R4A7kNtSTmoGStezvo2CKPjn3TLnZo2eIEBK378nWvQr/vyu?=
 =?iso-8859-1?Q?GcZIKaTqIRI382Myq2maZzxjDuG0ic9iytgHlflFcm2SeUSeyHUWOssz+E?=
 =?iso-8859-1?Q?N/9HUjxVtYXfVgz+Fg/hDnIwt7qa8TvUS8QOrCICyM0GQSrSnn8KGoN/+1?=
 =?iso-8859-1?Q?Axamaxtad82Ge5+X8yNfpE4h5a8BtG/C21O5SQcjvSvHdsR1li2COuzRQt?=
 =?iso-8859-1?Q?BzySkPmm3MCJs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed9d6d5-bcf6-492d-5b6b-08dd72f24919
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 20:58:28.9909 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eYrGDrRjpcKfSur9fcC0PhPBxwhuVGktOaCqHbbPHiAufPs/nIxc6tmcMqol996r3a5Fv7kSuaDtXfTmmE3b+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7451
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

Hi all,

This week this patchset was tested on 4 systems, two dGPU and two APU based=
, and tested across multiple display and connection types.

APU
        * Single Display eDP -> 1080p 60hz, 2560x1600 120hz, 1920x1200 165h=
z
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
        * AU Optronics B160QAN02.L 2560x1600 120hz eDP

The patchset consists of the amd-staging-drm-next branch (Head commit - aa5=
4fdb0e4492fe4c688b40cb79114aca205920a ->  drm/amdgpu/gfx12: Implement the g=
fx12 kgq pipe reset) with new patches added on top of it.

Tested on Ubuntu 24.04.1, on Wayland and X11, using KDE Plasma and Gnome.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>

Thank you,

Dan Wheeler
Sr. Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook |  Twitter |  amd.com


-----Original Message-----
From: Roman.Li@amd.com <Roman.Li@amd.com>
Sent: Wednesday, April 2, 2025 12:13 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Mohamed, Zaeem <Zaeem.M=
ohamed@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>; Li, Roman <Roman=
.Li@amd.com>
Subject: [PATCH 00/16] DC Patches April 02, 2025

From: Roman Li <Roman.Li@amd.com>

Display Core version 3.2.328 summary:

* Add DCN301 specific hubbub init function
* Optimize custom brightness curve
* Correct SSC enable detection for DCN351
* Turn off eDP lcdvdd and backlight if not required
* Use DMUB Fused IO interface for HDCP
* Extend eDP-on-DP1 quirk list

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Ausef Yousof (2):
  drm/amd/display: wait for updates to latch before locking
  drm/amd/display: dont disable dtb as dto src during dpms off

Charlene Liu (1):
  drm/amd/display: turn off eDP lcdvdd and backlight if not required

Dillon Varone (1):
  Revert "drm/amd/display: Fix VUpdate offset calculations for dcn401"

Dominik Kaszewski (1):
  drm/amd/display: HDCP Locality check using DMUB Fused IO

Kevin Gao (2):
  drm/amd/display: Correct SSC enable detection for DCN351
  drm/amd/display: Add DCN301 specific hubbub init function

Mario Limonciello (6):
  drm/amd/display: Optimize custom brightness curve
  drm/amd/display: Adjust all dev_*() messages to drm_*()
  drm/amd/display: Move PSR support message into amdgpu_dm
  drm/amd/display: Remove double checks for
    `debug.enable_mem_low_power.bits.cm`
  drm/amd/display: Add HP Probook 445 and 465 to the quirk list for eDP
    on DP1
  drm/amd/display: Add HP Elitebook 645 to the quirk list for eDP on DP1

Sherry Wang (1):
  drm/amd/display: rename IPS2 entry/exit message

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.5.0
  drm/amd/display: Promote DC to 3.2.328

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 241 +++++++++++++++---  ..=
./gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  16 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  56 +++-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  13 +
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |   4 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |   8 -
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  |   4 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |  41 ++-
 .../display/dc/clk_mgr/dcn35/dcn351_clk_mgr.c |   1 +
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   8 +-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.c  |   6 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  38 ++-
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_fused_io.c  | 144 +++++++++++  drivers/g=
pu/drm/amd/display/dc/dc_fused_io.h  |  31 +++
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   8 +
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |   9 +-
 .../display/dc/hubbub/dcn301/dcn301_hubbub.c  |  34 ++-
 .../display/dc/hubbub/dcn301/dcn301_hubbub.h  |   3 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   5 -
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 122 +++++++++
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |   7 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   8 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   2 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   2 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  44 ----
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   1 -
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   2 +-
 .../display/dc/hwss/hw_sequencer_private.h    |   2 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   4 +
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |   3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/optc.h  |   1 +
 .../link/protocols/link_edp_panel_control.c   |   2 +
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |   1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   6 +-
 .../drm/amd/display/dmub/src/dmub_srv_stat.c  |   4 +
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |   1 +
 .../display/modules/hdcp/hdcp2_execution.c    |  53 +++-
 .../display/modules/hdcp/hdcp2_transition.c   |  48 +++-
 .../drm/amd/display/modules/hdcp/hdcp_ddc.c   |  73 ++++++
 .../drm/amd/display/modules/inc/mod_hdcp.h    |  38 ++-
 42 files changed, 934 insertions(+), 168 deletions(-)  create mode 100644 =
drivers/gpu/drm/amd/display/dc/dc_fused_io.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_fused_io.h

--
2.34.1

