Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C3BC3ABBC
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 03:56:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7266510E242;
	Mon, 12 May 2025 03:56:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Oyqnkysd";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFE4510E242
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 03:56:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VvtwU2tG5Zov0fMdF3jOgL8IZynuDd/quY5JIVws/h4uS3LqIRQSr9Zcsilo1SJU+CeOEBwlVcrzeu0ReL/p0XxuaZSS5Jwp/U3rO4zYGXeom5HvZMUCxGmRYXBHQhF8zXg/lGrsipwBeBV7pyUSeOnRmrvFxr1axXS0ZUm711Jsx93wt0PB6p5pDi0ycYdUPPQWLmVopdubFCq345hPzoM7ta6rzD2ZpUNHuoY7aR/of5OcTwWDW0K1NEbxnHr4NjsXn/aoRKAXBMmDxMIY2WA15JE6TOBRrGCF1/amxAW3fROj6Tnx3qSw+7mTTItixbcaHWYfVSso7XkUOsoJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Po6hnT34AOtiHoehx7j2XM1N59IEn3eaFqX2sSSFys0=;
 b=OawzfUvjQYVPG8zQWC2czU8Lfbi4n/OSkWRYSaWPWjT4XPvRLLa+cnimIMp5jQZXgYcCV/JAh4PYVADW88kEJOY8YCgw7Q/o9v8mQogniZGyAobLe78bljiFpTdlDA6gv9rm0WzyGnx3l74z7+eStZ3KXTL4PZbidTbZMZfuiU6/kvSmczNsXxRmL4PxafjO2s7WypRqf+fCfvudEPPHHbuAZ5ulAQi9DxoYkc6h0tGZQy/5m+UlSK8DeZhxz/yCqLPt5e8OXHJ846UO7BLAVs1T8MvNXj473xiR/WWSbLBoHClRsVp5Uje9l10jQxqHrDdsgobXlDQZfqKwHciBGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Po6hnT34AOtiHoehx7j2XM1N59IEn3eaFqX2sSSFys0=;
 b=OyqnkysdWCH7/ubDmK1e889rf2KhWsahWfcSRVKAy6FKrXr9SNhJ5Ds1TiKkaWsBTtyVYkgDWc1yvA1/2Qex4vorSqVeKQVBdDM+bJnOrST+Px4ua6eqP6sUsHL4E8CLtTingOusOJ0ChDuDPxii5sLKyPxsibneSGnlVYq6J5w=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by BY5PR12MB4114.namprd12.prod.outlook.com (2603:10b6:a03:20c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 03:56:05 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8722.021; Mon, 12 May 2025
 03:56:05 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix the kernel panic caused by RAS records
 exceed threshold
Thread-Topic: [PATCH] drm/amdgpu: Fix the kernel panic caused by RAS records
 exceed threshold
Thread-Index: AQHbwCeDcjsHryC3FUim1SrQnQph3bPI0vOAgAAHRoCABYc8YA==
Date: Mon, 12 May 2025 03:56:05 +0000
Message-ID: <PH7PR12MB879699A163100AD41156942BB097A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250508144248.388934-1-cesun102@amd.com>
 <BN9PR12MB52577F161A63C9DB4C96AD49FC8BA@BN9PR12MB5257.namprd12.prod.outlook.com>
 <SJ0PR12MB696796D6657E5F2D61A47C8E9D8BA@SJ0PR12MB6967.namprd12.prod.outlook.com>
In-Reply-To: <SJ0PR12MB696796D6657E5F2D61A47C8E9D8BA@SJ0PR12MB6967.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-08T15:24:18.609Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|BY5PR12MB4114:EE_
x-ms-office365-filtering-correlation-id: 1926067b-b6a2-44ad-3ca9-08dd9108eb6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?YVeX4OAwLUKMwfAvT+1F9uroxyhHc3VIp50pc7mQYOMzteujc1mm5kwX0Xxs?=
 =?us-ascii?Q?h6BLUR+JHq8oG2Tvs06YmRnLO+xdYKYUFlS50uGye/KPk7y+HmG8jslyx+02?=
 =?us-ascii?Q?kcOZzjDLny+2rfoHLCWnu1D+pcKJisyR1TCvGIJmJs599TapnJwRKVqX9RNr?=
 =?us-ascii?Q?+cGq2pB1SOXGsXrwCjxqnWV1BYxU8sBCSRqh/Ypz2Sk7gYp0nIavDkCT11xv?=
 =?us-ascii?Q?0rBXIGv+eu2d8EXtFdFspDzkhgnqZBGXY8jpNbdUbfoQgmSUw+6yOnUEAC15?=
 =?us-ascii?Q?8N/K7hdFuhiCv2UUqlPCzn2Kz144yhLSmdUZ2KG49loaGeMLL5Rhk/WC8hWi?=
 =?us-ascii?Q?oq8yelJePLQCekv4AX7yXg/wcS34cnVcU4cdsROzsZjj/sIGIH7vtonatLNW?=
 =?us-ascii?Q?zcVln/CwTiIKhPekC7UYTXfLIJn3xbq1xe6OYVZvYlYQKM9GDK6hMTgZl/3D?=
 =?us-ascii?Q?PhXkUGzFP29T0FwCJrX6aGSjPoHbC6zYv5Xm7o5yJJsLKWsDnRsJ8Ceh98wZ?=
 =?us-ascii?Q?inxwdklHBw2s0U6oaUmGJXnQ3kEBPhlwcG+34Hlzco3TmAg6VPUyz07edRnG?=
 =?us-ascii?Q?Nl3R8o13/anWXkRsfq8mkbTXgp+pwGa8mcf6ge0Jp94XLL9x8nCsge4hQSsR?=
 =?us-ascii?Q?eRZBH2WvhpG6epj3JaCZ9es8a3ym0Np09NMQA+NtugTtwWP+Le8pdBI5wKvB?=
 =?us-ascii?Q?/AMsk/B6rtd9/kwqKTmZ0Pnq+adsl1jDMOhJEWz3YIbvaxAkEhL91fL5PgmC?=
 =?us-ascii?Q?AwcVHmkBJhBZPksS79sOPbqaXqka6lvFF7EPzATLYJe/fZOQS7/R4hbvGIme?=
 =?us-ascii?Q?gbyXDJIoWzhtxluy424swf+k28+63HOF88ZuKIMFjsv9Y0hJggcVlwbiVjLb?=
 =?us-ascii?Q?rjdwe29PAkhZGKF7mSPOyVrX63xNQ4mrkXE0ToTUVmvW7mNS/CBEI0wSitbl?=
 =?us-ascii?Q?Agczz9P7+zeLyXQd7SC224kF9jUPnnOQqsTTUp4mo4AkrpE3gBWO3fgNGCrY?=
 =?us-ascii?Q?wiDb+cM2BaZxlddtKeFHrYd/y9zRYOB+iTq+N4P0ayjvDq9WTE+cMJLnxlxR?=
 =?us-ascii?Q?luMiimRch78tL2Q21ibcUSf+6sVJdgHo5cOovynxHWRbQTEgaI8DLJV47G/e?=
 =?us-ascii?Q?gTn6Vk0GAPUwSICQQJ3/Ntn8n1Ov16gl4g5pt17lJY2cbtEjsTFwUNzjL4nW?=
 =?us-ascii?Q?wGpj1wUEjMGG95bhEaVMtUnRj149pldaiPM5pHpxlyYgdwml45j2IZe/zGx6?=
 =?us-ascii?Q?Vai6yvKKpPB0/3O/8PxteiRy3wdI2YyNpPX8GwTiOnHcJI9POckLnMPJyYhN?=
 =?us-ascii?Q?F2EoHdJhi4/OTNhuW8ch7qxUDazqJvhLCr9d1uwmQaLW4INvDurHBrTfWgw7?=
 =?us-ascii?Q?79BIH2/dvBa07pFC3EAmcqM4hYsL2gYjpZeHnA4AKgARTr/4lDll7Q5pL+qm?=
 =?us-ascii?Q?D43/tYDm7ZyExFZiBC0iOt9MuYNU9fzJkAYBsdCGdIwVszD0oU+DyBa6jv1z?=
 =?us-ascii?Q?3CwBLKLbpFAFlVU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mahXdLWHwmV8diflJxK3XsVWwvTTyi9dOvSVyygDNBdG5lhcDAz4HWzkgOlT?=
 =?us-ascii?Q?Js+yB1NhJy164cBaKZ20ts0z1QqhZ5TrakntHhjR2pzQms6SkmJBVJPMlpU4?=
 =?us-ascii?Q?ExZxCKHbPbyMBAHj50TCL6T5DLlt60NjDy4ULHkA7yIst5/hEkVTlslRrvmh?=
 =?us-ascii?Q?UhuKzvDBaNvRxvk8oAUIfuraMZWp6CTHYAKPtsMrNPfDlD7MtRiJdAzS0npL?=
 =?us-ascii?Q?U0GssGwU1ZMQPwaO3o69ZOajS941f71GjTtQDWLMg/YGAnWyS3xwwngucGFX?=
 =?us-ascii?Q?KRJqoppfeiLFkiSa5XDfosGtpo5rg2HJAUiyjYk85un+gj6Etol8hg19wpwu?=
 =?us-ascii?Q?+1F6Jmcoud9m7sGrmZvimN31XIync6U9jfGslNj97DDcle24oae7Lf3RfaJm?=
 =?us-ascii?Q?rTCC3TokBBCG9bqJXKFAQZ74e0i1QrrT56tfbycQoAH4ph2Ot0+T5ZmUq65W?=
 =?us-ascii?Q?PZVO+9DLhEZiHJnRGG0psguL0Ec+HmqfRmQUP33kvcxKm3MtsqB1wVXKf38s?=
 =?us-ascii?Q?wS6z9lWQlRdoCXMxQmYgVy8a+M5Bhw9QVPCxva/lyfpSQCYjaRkfOaYBtzig?=
 =?us-ascii?Q?4L9cDzq9yiKRI4SzvFUcs00zEeMQQN5jLET/9eZdYiMP6ZY5obdf8LF7r9mx?=
 =?us-ascii?Q?ExTDKQflT/f51TFGrgDYvhjYdZ8NXseABv43h8l7vfhhAyr1cYTnGTt/G3X6?=
 =?us-ascii?Q?c3+rc9aUU0ELPLLzgaFlJCxFd35l8OWSBUzNrnMduX5JqcKJD47CdQsfsObq?=
 =?us-ascii?Q?mKQFvBSmmjRx3P81i/JqHsNtm95QHnSPCOff5gpILvqSaNy1rjvIHvVysZem?=
 =?us-ascii?Q?geoUAczre0pQreWhWoXk+MW4yuO0nkB3dm+ZpTvSyweAdfEXognzl+cIBRC8?=
 =?us-ascii?Q?aI3ahNfcXaZn28iZaflJ8yd41ha4kIdvbjZaA+tV2Hd62XuQ+UA82Bl3UfNM?=
 =?us-ascii?Q?I29LAfl0Hf7ZR3YoCxq1TaTqflXoMIbU8YwIaO8oVyuk6NB0hX9iK7CWP7mk?=
 =?us-ascii?Q?1dtx13F4dlzeBHe7kl0ttUf7Tw9bmw9dQ82cxUWwzhzrW6KGE3sNYEZmJtKi?=
 =?us-ascii?Q?k/Mb5qnJRQQUE18VSIpX/uqY4u9DlGDnluFXsNyys14S+rMsv01bE/Rlh1Vi?=
 =?us-ascii?Q?sF+a9JDMv5bLZHz3sjjne3ldQEOsm45szXq4ac/zwVE1quFWbvZ0c5ElgGpF?=
 =?us-ascii?Q?z2YHR0yCg74s7WHSFoIiUDoY8mj0jxwjDo7qKLWAxew4f1ry5VNV1221Bj4S?=
 =?us-ascii?Q?Je6VjRtIa4SN4Cxi0Arj6SXCn76r0qBwrJeJUc37yF8CWg70UZz51bd/EBLT?=
 =?us-ascii?Q?RsD+/cqT/5m0WLOu+6t1aUw/NsiwHS+vLHl7bWy228QMXx7bKDxprsNCp3Jq?=
 =?us-ascii?Q?C3/yl7zQcBco301fZNYfl76nBWOc7o04cDpE2HTguS+Ei6RB9wc+m1CUfUGl?=
 =?us-ascii?Q?54hoipgro4Xx7ATnUZNvxNdcnCp9Y3JtUvAMd2pMh4oMNiuyD+Za1N9G4Xv8?=
 =?us-ascii?Q?CG5aSrRXuwogboU3IQXf3m4YAlXJ0ZRPTiuxSh/rhjxvfvii+7nhxF+QQG4A?=
 =?us-ascii?Q?GmzEvtgLA/DJoNgJhXQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB879699A163100AD41156942BB097APH7PR12MB8796namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1926067b-b6a2-44ad-3ca9-08dd9108eb6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 03:56:05.1788 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oisOqX9enyOeZ+ZmGfrUFx8ZaUB40+OBypcCzkvpBZrnVqeEPHdIE8Y10jKMb0LS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4114
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

--_000_PH7PR12MB879699A163100AD41156942BB097APH7PR12MB8796namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Can we check rma status before the warning in amdgpu_irq_put?

Regards,
Tao

From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Thursday, May 8, 2025 11:24 PM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix the kernel panic caused by RAS records=
 exceed threshold


[AMD Official Use Only - AMD Internal Distribution Only]

Hi Hawking,Yes, multiple warnings will occur, and the chain reaction after =
multiple warnings is kernel panic. Therefore, it is necessary to determine =
in advance whether the interrupt source has been enabled here
________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Sent: Thursday, May 8, 2025 10:58 PM
To: Sun, Ce(Overlord) <Ce.Sun@amd.com<mailto:Ce.Sun@amd.com>>; amd-gfx@list=
s.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.free=
desktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>
Subject: RE: [PATCH] drm/amdgpu: Fix the kernel panic caused by RAS records=
 exceed threshold

[AMD Official Use Only - AMD Internal Distribution Only]

+       if (amdgpu_irq_enabled(adev, &adev->gfx.priv_reg_irq, 0))
+               amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);

I'm under the impression irq_enabled check should already be included in th=
e amdgpu_irq_put. Is that not the case?

Regards,
Hawking

-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com<mailto:Ce.Sun@amd.com>>
Sent: Thursday, May 8, 2025 22:43
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Z=
hou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Sun, Ce(Overlord) =
<Ce.Sun@amd.com<mailto:Ce.Sun@amd.com>>
Subject: [PATCH] drm/amdgpu: Fix the kernel panic caused by RAS records exc=
eed threshold

kernel panic caused by RAS records exceeding the threshold when load driver=
 specifying RMA(bad_page_threshold=3D128) 1.Fix the kernel panic caused by =
disabling the interrupt source before it was enabled 2.Fix the memory leak =
caused by the device's early exit due to rma

The first reason:
[ 2744.246650] ------------[ cut here ]------------ [ 2744.246651] WARNING:=
 CPU: 0 PID: 289 at /tmp/amd.BkfTLqYV/amd/amdgpu/amdgpu_irq.c:635 amdgpu_ir=
q_put.cold+0x42/0x6e [amdgpu] [ 2744.247108] Modules linked in: amdgpu(OE+)=
 amddrm_ttm_helper(OE) amdttm(OE) amdxcp(OE) amddrm_buddy(OE) amddrm_exec(O=
E) amd_sched(OE) amdkcl(OE) xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat=
 nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user =
xfrm_algo nft_counter xt_addrtype nft_compat nf_tables nfnetlink br_netfilt=
er bridge stp llc overlay binfmt_misc intel_rapl_msr intel_rapl_common i10n=
m_edac nfit x86_pkg_temp_thermal intel_powerclamp coretemp ipmi_ssif kvm_in=
tel nls_iso8859_1 kvm rapl isst_if_mbox_pci isst_if_mmio pmt_telemetry pmt_=
crashlog isst_if_common pmt_class mei_me mei acpi_ipmi ipmi_si ipmi_devintf=
 ipmi_msghandler acpi_power_meter acpi_pad mac_hid sch_fq_codel dm_multipat=
h scsi_dh_rdac scsi_dh_emc scsi_dh_alua msr ramoops reed_solomon pstore_blk=
 pstore_zone efi_pstore ip_tables x_tables autofs4 btrfs blake2b_generic zs=
td_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xo=
r async_tx xor raid6_pq libcrc32c raid1 raid0 multipath [ 2744.247167]  lin=
ear mlx5_ib ib_uverbs ib_core ast i2c_algo_bit drm_vram_helper drm_ttm_help=
er ttm drm_kms_helper crct10dif_pclmul syscopyarea crc32_pclmul ghash_clmul=
ni_intel mlx5_core sysfillrect sysimgblt aesni_intel mlxfw fb_sys_fops psam=
ple cec crypto_simd cryptd rc_core i2c_i801 nvme xhci_pci tls intel_pmt drm=
 pci_hyperv_intf nvme_core i2c_smbus i2c_ismt xhci_pci_renesas wmi pinctrl_=
emmitsburg
[ 2744.247194] CPU: 0 PID: 289 Comm: kworker/0:1 Tainted: G           OE   =
  5.15.0-70-generic #77-Ubuntu
[ 2744.247197] Hardware name: Microsoft C278A/C278A, BIOS C2789.5.BS.1C23.A=
G.2 11/21/2024 [ 2744.247198] Workqueue: events work_for_cpu_fn [ 2744.2472=
06] RIP: 0010:amdgpu_irq_put.cold+0x42/0x6e [amdgpu] [ 2744.247634] Code: 7=
9 7f ff 44 89 ee 48 c7 c7 4d 5a 42 c2 89 55 d4 e8 90 09 bc bf 8b 55 d4 4c 8=
9 e6 4c 89 ff e8 3c 76 7f ff 8b 55 d4 84 c0 75 07 <0f> 0b e9 95 79 7f ff 49=
 03 5c 24 08 f0 ff 0b 75 13 4c 89 e6 4c 89 [ 2744.247636] RSP: 0018:ffa0000=
019e27cb0 EFLAGS: 00010246 [ 2744.247639] RAX: 0000000000000000 RBX: 000000=
0000000000 RCX: ff11000150fa87c0 [ 2744.247641] RDX: 0000000000000000 RSI: =
ffffffffc2222430 RDI: ff1100019f200000 [ 2744.247642] RBP: ffa0000019e27ce0=
 R08: 0000000000000003 R09: ffffffffffe41a08 [ 2744.247643] R10: 0000000000=
ffff0a R11: 0000000000000001 R12: ff1100019f22ce60 [ 2744.247644] R13: 0000=
000000000000 R14: 00000000ffffffea R15: ff1100019f200000 [ 2744.247645] FS:=
  0000000000000000(0000) GS:ff11007e7e400000(0000) knlGS:0000000000000000 [=
 2744.247647] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [ 2744.2476=
49] CR2: 00007f3d2002819c CR3: 0000000006810003 CR4: 0000000000771ef0 [ 274=
4.247650] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000=
 [ 2744.247651] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000=
000400 [ 2744.247652] PKRU: 55555554 [ 2744.247653] Call Trace:
[ 2744.247654]  <TASK>
[ 2744.247656]  sdma_v4_4_2_hw_fini+0x7a/0xc0 [amdgpu] [ 2744.247997]  ? vc=
n_v4_0_3_hw_fini+0x5f/0xa0 [amdgpu] [ 2744.248336]  amdgpu_ip_block_hw_fini=
+0x31/0x61 [amdgpu] [ 2744.248776]  amdgpu_device_fini_hw+0x3bb/0x47b [amdg=
pu] [ 2744.249197]  ? blocking_notifier_chain_unregister+0x56/0xb0
[ 2744.249202]  amdgpu_driver_unload_kms+0x51/0x60 [amdgpu] [ 2744.249482] =
 amdgpu_driver_load_kms.cold+0x18/0x2e [amdgpu] [ 2744.249913]  amdgpu_pci_=
probe+0x23e/0x590 [amdgpu] [ 2744.250187]  local_pci_probe+0x48/0x90 [ 2744=
.250191]  work_for_cpu_fn+0x17/0x30 [ 2744.250196]  process_one_work+0x228/=
0x3d0 [ 2744.250198]  worker_thread+0x223/0x420 [ 2744.250200]  ? process_o=
ne_work+0x3d0/0x3d0 [ 2744.250201]  kthread+0x127/0x150 [ 2744.250204]  ? s=
et_kthread_struct+0x50/0x50 [ 2744.250207]  ret_from_fork+0x1f/0x30 [ 2744.=
250212]  </TASK> [ 2744.250213] ---[ end trace 488c997a88508bc3 ]---

The second reason:
[ 5139.303446] Memory manager not clean during takedown.
[ 5139.303509] WARNING: CPU: 145 PID: 117699 at drivers/gpu/drm/drm_mm.c:99=
8 drm_mm_takedown+0x27/0x30 [drm] [ 5139.303542] Modules linked in: amdgpu(=
OE+) amddrm_ttm_helper(OE) amdttm(OE) amdxcp(OE) amddrm_buddy(OE) amddrm_ex=
ec(OE) amd_sched(OE) amdkcl(OE) xt_conntrack nft_chain_nat xt_MASQUERADE nf=
_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_u=
ser xfrm_algo nft_counter xt_addrtype nft_compat nf_tables nfnetlink br_net=
filter bridge stp llc overlay intel_rapl_msr intel_rapl_common i10nm_edac n=
fit x86_pkg_temp_thermal intel_powerclamp coretemp ipmi_ssif kvm_intel binf=
mt_misc kvm nls_iso8859_1 rapl isst_if_mbox_pci pmt_telemetry pmt_crashlog =
isst_if_mmio pmt_class isst_if_common mei_me mei acpi_ipmi ipmi_si ipmi_dev=
intf ipmi_msghandler acpi_pad acpi_power_meter mac_hid sch_fq_codel dm_mult=
ipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua msr ramoops reed_solomon pstore=
_blk pstore_zone efi_pstore ip_tables x_tables autofs4 btrfs blake2b_generi=
c zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq asyn=
c_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath [ 5139.303572] =
 linear mlx5_ib ib_uverbs ib_core crct10dif_pclmul ast crc32_pclmul i2c_alg=
o_bit ghash_clmulni_intel aesni_intel crypto_simd drm_vram_helper cryptd dr=
m_ttm_helper mlx5_core ttm drm_kms_helper syscopyarea sysfillrect sysimgblt=
 fb_sys_fops cec rc_core mlxfw psample intel_pmt nvme xhci_pci drm tls i2c_=
i801 pci_hyperv_intf nvme_core i2c_smbus i2c_ismt xhci_pci_renesas wmi pinc=
trl_emmitsburg [last unloaded: amdkcl]
[ 5139.303588] CPU: 145 PID: 117699 Comm: modprobe Tainted: G     U     OE =
    5.15.0-70-generic #77-Ubuntu
[ 5139.303590] Hardware name: Microsoft C278A/C278A, BIOS C2789.5.BS.1C23.A=
G.2 11/21/2024 [ 5139.303591] RIP: 0010:drm_mm_takedown+0x27/0x30 [drm] [ 5=
139.303605] Code: cc 66 90 0f 1f 44 00 00 48 8b 47 38 48 83 c7 38 48 39 f8 =
75 05 c3 cc cc cc cc 55 48 c7 c7 18 d0 10 c0 48 89 e5 e8 5a bc c3 c1 <0f> 0=
b 5d c3 cc cc cc cc 90 0f 1f 44 00 00 55 b9 15 00 00 00 48 89 [ 5139.303607=
] RSP: 0018:ffa00000325c3940 EFLAGS: 00010286 [ 5139.303608] RAX: 000000000=
0000000 RBX: ff1100012f5cecb0 RCX: 0000000000000027 [ 5139.303609] RDX: ff1=
1007e7fa60588 RSI: 0000000000000001 RDI: ff11007e7fa60580 [ 5139.303610] RB=
P: ffa00000325c3940 R08: 0000000000000003 R09: fffffffff00c2b78 [ 5139.3036=
10] R10: 000000000000002b R11: 0000000000000001 R12: ff1100012f5cec00 [ 513=
9.303611] R13: ff1100012138f068 R14: 0000000000000000 R15: ff1100012f5cec90=
 [ 5139.303611] FS:  00007f42ffca0000(0000) GS:ff11007e7fa40000(0000) knlGS=
:0000000000000000 [ 5139.303612] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033 [ 5139.303613] CR2: 00007f23d945ab68 CR3: 00000001212ce005 CR4: 000=
0000000771ee0 [ 5139.303614] DR0: 0000000000000000 DR1: 0000000000000000 DR=
2: 0000000000000000 [ 5139.303615] DR3: 0000000000000000 DR6: 00000000fffe0=
7f0 DR7: 0000000000000400 [ 5139.303615] PKRU: 55555554 [ 5139.303616] Call=
 Trace:
[ 5139.303617]  <TASK>
[ 5139.303619]  amdttm_range_man_fini_nocheck+0xfe/0x1c0 [amdttm] [ 5139.30=
3625]  amdgpu_ttm_fini+0x2ed/0x390 [amdgpu] [ 5139.303800]  amdgpu_bo_fini+=
0x27/0xc0 [amdgpu] [ 5139.303959]  gmc_v9_0_sw_fini+0x63/0x90 [amdgpu] [ 51=
39.304144]  amdgpu_device_fini_sw+0x125/0x6a0 [amdgpu] [ 5139.304302]  amdg=
pu_driver_release_kms+0x16/0x30 [amdgpu] [ 5139.304455]  devm_drm_dev_init_=
release+0x4a/0x80 [drm] [ 5139.304472]  devm_action_release+0x12/0x20 [ 513=
9.304476]  release_nodes+0x3d/0xb0 [ 5139.304478]  devres_release_all+0x9b/=
0xd0 [ 5139.304480]  really_probe+0x11d/0x420 [ 5139.304483]  __driver_prob=
e_device+0x119/0x190 [ 5139.304485]  driver_probe_device+0x23/0xc0 [ 5139.3=
04487]  __driver_attach+0xf7/0x1f0 [ 5139.304489]  ? __device_attach_driver=
+0x140/0x140
[ 5139.304491]  bus_for_each_dev+0x7c/0xd0 [ 5139.304493]  driver_attach+0x=
1e/0x30 [ 5139.304494]  bus_add_driver+0x148/0x220 [ 5139.304496]  driver_r=
egister+0x95/0x100 [ 5139.304498]  __pci_register_driver+0x68/0x70 [ 5139.3=
04500]  amdgpu_init+0xbc/0x1000 [amdgpu] [ 5139.304655]  ? 0xffffffffc0b8f0=
00 [ 5139.304657]  do_one_initcall+0x46/0x1e0 [ 5139.304659]  ? kmem_cache_=
alloc_trace+0x19e/0x2e0
[ 5139.304663]  do_init_module+0x52/0x260 [ 5139.304665]  load_module+0xb2b=
/0xbc0 [ 5139.304667]  __do_sys_finit_module+0xbf/0x120 [ 5139.304669]  __x=
64_sys_finit_module+0x18/0x20 [ 5139.304670]  do_syscall_64+0x59/0xc0 [ 513=
9.304673]  ? exit_to_user_mode_prepare+0x37/0xb0
[ 5139.304676]  ? syscall_exit_to_user_mode+0x27/0x50
[ 5139.304678]  ? __x64_sys_mmap+0x33/0x50 [ 5139.304680]  ? do_syscall_64+=
0x69/0xc0 [ 5139.304681]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 5139.304684] RIP: 0033:0x7f42ffdbf88d
[ 5139.304686] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 b5 0f 00 f7 d8 64 89 01 48 [ 5139.304=
687] RSP: 002b:00007ffcb7427158 EFLAGS: 00000246 ORIG_RAX: 0000000000000139=
 [ 5139.304688] RAX: ffffffffffffffda RBX: 000055ce8b8f3150 RCX: 00007f42ff=
dbf88d [ 5139.304689] RDX: 0000000000000000 RSI: 000055ce8b8f9a70 RDI: 0000=
00000000000a [ 5139.304690] RBP: 0000000000040000 R08: 0000000000000000 R09=
: 0000000000000011 [ 5139.304690] R10: 000000000000000a R11: 00000000000002=
46 R12: 000055ce8b8f9a70 [ 5139.304691] R13: 000055ce8b8f2ec0 R14: 000055ce=
8b8f2ab0 R15: 000055ce8b8f9aa0 [ 5139.304692]  </TASK> [ 5139.304693] ---[ =
end trace 8536b052f7883003 ]---

Signed-off-by: Ce Sun <cesun102@amd.com<mailto:cesun102@amd.com>>
---
drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c |  4 +++-
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c   |  2 ++
drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c   |  4 ++--
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c   | 15 +++++++++++----
drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     |  6 ++++--
drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c  |  6 ++++--
drivers/gpu/drm/amd/amdgpu/soc15.c        |  6 ++++--
7 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_fence.c
index d4f3fb3519c8..1166093d2b5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -614,7 +614,9 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *=
adev)

                 if (!drm_dev_is_unplugged(adev_to_drm(adev)) &&
                     ring->fence_drv.irq_src &&
-                   amdgpu_fence_need_ring_interrupt_restore(ring))
+                   amdgpu_fence_need_ring_interrupt_restore(ring) &&
+                   amdgpu_irq_enabled(adev, ring->fence_drv.irq_src,
+                                      ring->fence_drv.irq_type))
                         amdgpu_irq_put(adev, ring->fence_drv.irq_src,
                                        ring->fence_drv.irq_type);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index cb7991362b5d..6f24e95c9112 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2496,6 +2496,8 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
         amdgpu_vram_mgr_fini(adev);
         amdgpu_gtt_mgr_fini(adev);
         amdgpu_preempt_mgr_fini(adev);
+       amdgpu_doorbell_fini(adev);
+
         ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GDS);
         ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GWS);
         ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA); diff --git a/d=
rivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_=
xcp.c
index cd6e4c0b94da..e970a1427fe0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -719,10 +719,10 @@ void amdgpu_xcp_cfg_sysfs_fini(struct amdgpu_device *=
adev)
         struct amdgpu_xcp_cfg *xcp_cfg;
         int i;

-       if (!adev->xcp_mgr)
+       if (!adev->xcp_mgr || !adev->xcp_mgr->xcp_cfg)
                 return;

-       xcp_cfg =3D  adev->xcp_mgr->xcp_cfg;
+       xcp_cfg =3D adev->xcp_mgr->xcp_cfg;
         for (i =3D 0; i < xcp_cfg->num_res; i++) {
                 xcp_res =3D &xcp_cfg->xcp_res[i];
                 kobject_put(&xcp_res->kobj);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index dcc6752c3ece..dd0a2cfd85cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2379,10 +2379,17 @@ static int gfx_v9_4_3_hw_fini(struct amdgpu_ip_bloc=
k *ip_block)
         struct amdgpu_device *adev =3D ip_block->adev;
         int i, num_xcc;

-       amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
-       amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
-       amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
-       amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
+       if (amdgpu_irq_enabled(adev, &adev->gfx.priv_reg_irq, 0))
+               amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
+
+       if (amdgpu_irq_enabled(adev, &adev->gfx.spm_irq, 0))
+               amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
+
+       if (amdgpu_irq_enabled(adev, &adev->gfx.priv_inst_irq, 0))
+               amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+
+       if (amdgpu_irq_enabled(adev, &adev->gfx.bad_op_irq, 0))
+               amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);

         num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
         for (i =3D 0; i < num_xcc; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 59385da80185..05599c253e24 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2513,10 +2513,12 @@ static int gmc_v9_0_hw_fini(struct amdgpu_ip_block =
*ip_block)
          * are not enabled.
          */
         if (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
-               amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
+               if (amdgpu_irq_enabled(adev, &adev->gmc.vm_fault, 0))
+                       amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);

                 if (adev->gmc.ecc_irq.funcs &&
-                   amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
+                   amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC) &&
+                   amdgpu_irq_enabled(adev, &adev->gmc.ecc_irq, 0))
                         amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
         }

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index 11f9c07f1e8d..60f5f3b367d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1615,8 +1615,10 @@ static int sdma_v4_4_2_hw_fini(struct amdgpu_ip_bloc=
k *ip_block)
         inst_mask =3D GENMASK(adev->sdma.num_instances - 1, 0);
         if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
                 for (i =3D 0; i < adev->sdma.num_instances; i++) {
-                       amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
-                                      AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+                       if (amdgpu_irq_enabled(adev, &adev->sdma.ecc_irq,
+                                              AMDGPU_SDMA_IRQ_INSTANCE0 + =
i))
+                               amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
+                                              AMDGPU_SDMA_IRQ_INSTANCE0 + =
i);
                 }
         }

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index c457be3a3c56..5a60cf679307 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1338,10 +1338,12 @@ static int soc15_common_hw_fini(struct amdgpu_ip_bl=
ock *ip_block)
             adev->nbio.ras_if &&
             amdgpu_ras_is_supported(adev, adev->nbio.ras_if->block)) {
                 if (adev->nbio.ras &&
-                   adev->nbio.ras->init_ras_controller_interrupt)
+                   adev->nbio.ras->init_ras_controller_interrupt &&
+                   amdgpu_irq_enabled(adev, &adev->nbio.ras_controller_irq=
, 0))
                         amdgpu_irq_put(adev, &adev->nbio.ras_controller_ir=
q, 0);
                 if (adev->nbio.ras &&
-                   adev->nbio.ras->init_ras_err_event_athub_interrupt)
+                   adev->nbio.ras->init_ras_err_event_athub_interrupt &&
+                   amdgpu_irq_enabled(adev, &adev->nbio.ras_err_event_athu=
b_irq, 0))
                         amdgpu_irq_put(adev, &adev->nbio.ras_err_event_ath=
ub_irq, 0);
         }

--
2.34.1


--_000_PH7PR12MB879699A163100AD41156942BB097APH7PR12MB8796namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
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
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle21
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Can we check rma status before the warning in
</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans=
-serif">amdgpu_irq_put</span><span style=3D"font-size:11.0pt;font-family:&q=
uot;Calibri&quot;,sans-serif">?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">Tao</span><span style=3D"font-size:11.0pt;font-fami=
ly:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Sun, Ce(Overlord) &lt;Ce.Sun@a=
md.com&gt;
<br>
<b>Sent:</b> Thursday, May 8, 2025 11:24 PM<br>
<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.free=
desktop.org<br>
<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Fix the kernel panic caused by RAS =
records exceed threshold<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:blue">[AMD Official Use Only - AMD Internal=
 Distribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Hi Hawking,Yes, multiple=
 warnings will occur, and the chain reaction after multiple warnings is ker=
nel panic. Therefore, it is necessary to determine in advance whether the i=
nterrupt source has been enabled here<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Zhang,=
 Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zhang@amd.com=
</a>&gt;<br>
<b>Sent:</b> Thursday, May 8, 2025 10:58 PM<br>
<b>To:</b> Sun, Ce(Overlord) &lt;<a href=3D"mailto:Ce.Sun@amd.com">Ce.Sun@a=
md.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Tao.Zhou1@am=
d.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Fix the kernel panic caused by RAS =
records exceed threshold</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:blue">[AMD Official Use Only - AMD Internal Di=
stribution Only]</span><span style=3D"font-size:10.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div style=3D"margin-top:5.0pt">
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ir=
q_enabled(adev, &amp;adev-&gt;gfx.priv_reg_irq, 0))</span><span style=3D"fo=
nt-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></spa=
n></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gfx.p=
riv_reg_irq, 0);</span><span style=3D"font-size:10.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">I'm under the impression irq_enabled check should a=
lready be included in the amdgpu_irq_put. Is that not the case?</span><span=
 style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">Regards,</span><span style=3D"font-size:10.0pt;font=
-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">Hawking</span><span style=3D"font-size:10.0pt;font-=
family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">-----Original Message-----<br>
From: Sun, Ce(Overlord) &lt;<a href=3D"mailto:Ce.Sun@amd.com">Ce.Sun@amd.co=
m</a>&gt; <br>
Sent: Thursday, May 8, 2025 22:43<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zha=
ng@amd.com</a>&gt;; Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Tao=
.Zhou1@amd.com</a>&gt;; Sun, Ce(Overlord) &lt;<a href=3D"mailto:Ce.Sun@amd.=
com">Ce.Sun@amd.com</a>&gt;<br>
Subject: [PATCH] drm/amdgpu: Fix the kernel panic caused by RAS records exc=
eed threshold</span><span style=3D"font-size:10.0pt;font-family:&quot;Calib=
ri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">kernel panic caused by RAS records exceeding the th=
reshold when load driver specifying RMA(bad_page_threshold=3D128) 1.Fix the=
 kernel panic caused by disabling the interrupt
 source before it was enabled 2.Fix the memory leak caused by the device's =
early exit due to rma</span><span style=3D"font-size:10.0pt;font-family:&qu=
ot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">The first reason:</span><span style=3D"font-size:10=
.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">[ 2744.246650] ------------[ cut here ]------------=
 [ 2744.246651] WARNING: CPU: 0 PID: 289 at /tmp/amd.BkfTLqYV/amd/amdgpu/am=
dgpu_irq.c:635 amdgpu_irq_put.cold+0x42/0x6e [amdgpu]
 [ 2744.247108] Modules linked in: amdgpu(OE+) amddrm_ttm_helper(OE) amdttm=
(OE) amdxcp(OE) amddrm_buddy(OE) amddrm_exec(OE) amd_sched(OE) amdkcl(OE) x=
t_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conn=
track nf_defrag_ipv6 nf_defrag_ipv4
 xfrm_user xfrm_algo nft_counter xt_addrtype nft_compat nf_tables nfnetlink=
 br_netfilter bridge stp llc overlay binfmt_misc intel_rapl_msr intel_rapl_=
common i10nm_edac nfit x86_pkg_temp_thermal intel_powerclamp coretemp ipmi_=
ssif kvm_intel nls_iso8859_1 kvm
 rapl isst_if_mbox_pci isst_if_mmio pmt_telemetry pmt_crashlog isst_if_comm=
on pmt_class mei_me mei acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi=
_power_meter acpi_pad mac_hid sch_fq_codel dm_multipath scsi_dh_rdac scsi_d=
h_emc scsi_dh_alua msr ramoops reed_solomon
 pstore_blk pstore_zone efi_pstore ip_tables x_tables autofs4 btrfs blake2b=
_generic zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_=
pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath [ 2744.2=
47167]&nbsp; linear mlx5_ib ib_uverbs
 ib_core ast i2c_algo_bit drm_vram_helper drm_ttm_helper ttm drm_kms_helper=
 crct10dif_pclmul syscopyarea crc32_pclmul ghash_clmulni_intel mlx5_core sy=
sfillrect sysimgblt aesni_intel mlxfw fb_sys_fops psample cec crypto_simd c=
ryptd rc_core i2c_i801 nvme xhci_pci
 tls intel_pmt drm pci_hyperv_intf nvme_core i2c_smbus i2c_ismt xhci_pci_re=
nesas wmi pinctrl_emmitsburg</span><span style=3D"font-size:10.0pt;font-fam=
ily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">[ 2744.247194] CPU: 0 PID: 289 Comm: kworker/0:1 Ta=
inted: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE&nbs=
p;&nbsp;&nbsp;&nbsp; 5.15.0-70-generic #77-Ubuntu</span><span style=3D"font=
-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">[ 2744.247197] Hardware name: Microsoft C278A/C278A=
, BIOS C2789.5.BS.1C23.AG.2 11/21/2024 [ 2744.247198] Workqueue: events wor=
k_for_cpu_fn [ 2744.247206] RIP: 0010:amdgpu_irq_put.cold+0x42/0x6e
 [amdgpu] [ 2744.247634] Code: 79 7f ff 44 89 ee 48 c7 c7 4d 5a 42 c2 89 55=
 d4 e8 90 09 bc bf 8b 55 d4 4c 89 e6 4c 89 ff e8 3c 76 7f ff 8b 55 d4 84 c0=
 75 07 &lt;0f&gt; 0b e9 95 79 7f ff 49 03 5c 24 08 f0 ff 0b 75 13 4c 89 e6 =
4c 89 [ 2744.247636] RSP: 0018:ffa0000019e27cb0
 EFLAGS: 00010246 [ 2744.247639] RAX: 0000000000000000 RBX: 000000000000000=
0 RCX: ff11000150fa87c0 [ 2744.247641] RDX: 0000000000000000 RSI: ffffffffc=
2222430 RDI: ff1100019f200000 [ 2744.247642] RBP: ffa0000019e27ce0 R08: 000=
0000000000003 R09: ffffffffffe41a08
 [ 2744.247643] R10: 0000000000ffff0a R11: 0000000000000001 R12: ff1100019f=
22ce60 [ 2744.247644] R13: 0000000000000000 R14: 00000000ffffffea R15: ff11=
00019f200000 [ 2744.247645] FS:&nbsp; 0000000000000000(0000) GS:ff11007e7e4=
00000(0000) knlGS:0000000000000000 [
 2744.247647] CS:&nbsp; 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [ 2744=
.247649] CR2: 00007f3d2002819c CR3: 0000000006810003 CR4: 0000000000771ef0 =
[ 2744.247650] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000 [ 2744.247651] DR3: 0000000000000000
 DR6: 00000000fffe07f0 DR7: 0000000000000400 [ 2744.247652] PKRU: 55555554 =
[ 2744.247653] Call Trace:</span><span style=3D"font-size:10.0pt;font-famil=
y:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">[ 2744.247654]&nbsp; &lt;TASK&gt;</span><span style=
=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p=
></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">[ 2744.247656]&nbsp; sdma_v4_4_2_hw_fini+0x7a/0xc0 =
[amdgpu] [ 2744.247997]&nbsp; ? vcn_v4_0_3_hw_fini+0x5f/0xa0 [amdgpu] [ 274=
4.248336]&nbsp; amdgpu_ip_block_hw_fini+0x31/0x61 [amdgpu] [
 2744.248776]&nbsp; amdgpu_device_fini_hw+0x3bb/0x47b [amdgpu] [ 2744.24919=
7]&nbsp; ? blocking_notifier_chain_unregister+0x56/0xb0</span><span style=
=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p=
></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">[ 2744.249202]&nbsp; amdgpu_driver_unload_kms+0x51/=
0x60 [amdgpu] [ 2744.249482]&nbsp; amdgpu_driver_load_kms.cold+0x18/0x2e [a=
mdgpu] [ 2744.249913]&nbsp; amdgpu_pci_probe+0x23e/0x590 [amdgpu]
 [ 2744.250187]&nbsp; local_pci_probe+0x48/0x90 [ 2744.250191]&nbsp; work_f=
or_cpu_fn+0x17/0x30 [ 2744.250196]&nbsp; process_one_work+0x228/0x3d0 [ 274=
4.250198]&nbsp; worker_thread+0x223/0x420 [ 2744.250200]&nbsp; ? process_on=
e_work+0x3d0/0x3d0 [ 2744.250201]&nbsp; kthread+0x127/0x150 [
 2744.250204]&nbsp; ? set_kthread_struct+0x50/0x50 [ 2744.250207]&nbsp; ret=
_from_fork+0x1f/0x30 [ 2744.250212]&nbsp; &lt;/TASK&gt; [ 2744.250213] ---[=
 end trace 488c997a88508bc3 ]---</span><span style=3D"font-size:10.0pt;font=
-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">The second reason:</span><span style=3D"font-size:1=
0.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">[ 5139.303446] Memory manager not clean during take=
down.</span><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;=
,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">[ 5139.303509] WARNING: CPU: 145 PID: 117699 at dri=
vers/gpu/drm/drm_mm.c:998 drm_mm_takedown+0x27/0x30 [drm] [ 5139.303542] Mo=
dules linked in: amdgpu(OE+) amddrm_ttm_helper(OE)
 amdttm(OE) amdxcp(OE) amddrm_buddy(OE) amddrm_exec(OE) amd_sched(OE) amdkc=
l(OE) xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink =
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo nft_counter =
xt_addrtype nft_compat nf_tables
 nfnetlink br_netfilter bridge stp llc overlay intel_rapl_msr intel_rapl_co=
mmon i10nm_edac nfit x86_pkg_temp_thermal intel_powerclamp coretemp ipmi_ss=
if kvm_intel binfmt_misc kvm nls_iso8859_1 rapl isst_if_mbox_pci pmt_teleme=
try pmt_crashlog isst_if_mmio pmt_class
 isst_if_common mei_me mei acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler a=
cpi_pad acpi_power_meter mac_hid sch_fq_codel dm_multipath scsi_dh_rdac scs=
i_dh_emc scsi_dh_alua msr ramoops reed_solomon pstore_blk pstore_zone efi_p=
store ip_tables x_tables autofs4
 btrfs blake2b_generic zstd_compress raid10 raid456 async_raid6_recov async=
_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 mult=
ipath [ 5139.303572]&nbsp; linear mlx5_ib ib_uverbs ib_core crct10dif_pclmu=
l ast crc32_pclmul i2c_algo_bit ghash_clmulni_intel
 aesni_intel crypto_simd drm_vram_helper cryptd drm_ttm_helper mlx5_core tt=
m drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec rc_core =
mlxfw psample intel_pmt nvme xhci_pci drm tls i2c_i801 pci_hyperv_intf nvme=
_core i2c_smbus i2c_ismt xhci_pci_renesas
 wmi pinctrl_emmitsburg [last unloaded: amdkcl]</span><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></=
p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">[ 5139.303588] CPU: 145 PID: 117699 Comm: modprobe =
Tainted: G&nbsp;&nbsp;&nbsp;&nbsp; U&nbsp;&nbsp;&nbsp;&nbsp; OE&nbsp;&nbsp;=
&nbsp;&nbsp; 5.15.0-70-generic #77-Ubuntu</span><span style=3D"font-size:10=
.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">[ 5139.303590] Hardware name: Microsoft C278A/C278A=
, BIOS C2789.5.BS.1C23.AG.2 11/21/2024 [ 5139.303591] RIP: 0010:drm_mm_take=
down+0x27/0x30 [drm] [ 5139.303605] Code: cc 66
 90 0f 1f 44 00 00 48 8b 47 38 48 83 c7 38 48 39 f8 75 05 c3 cc cc cc cc 55=
 48 c7 c7 18 d0 10 c0 48 89 e5 e8 5a bc c3 c1 &lt;0f&gt; 0b 5d c3 cc cc cc =
cc 90 0f 1f 44 00 00 55 b9 15 00 00 00 48 89 [ 5139.303607] RSP: 0018:ffa00=
000325c3940 EFLAGS: 00010286 [ 5139.303608]
 RAX: 0000000000000000 RBX: ff1100012f5cecb0 RCX: 0000000000000027 [ 5139.3=
03609] RDX: ff11007e7fa60588 RSI: 0000000000000001 RDI: ff11007e7fa60580 [ =
5139.303610] RBP: ffa00000325c3940 R08: 0000000000000003 R09: fffffffff00c2=
b78 [ 5139.303610] R10: 000000000000002b
 R11: 0000000000000001 R12: ff1100012f5cec00 [ 5139.303611] R13: ff11000121=
38f068 R14: 0000000000000000 R15: ff1100012f5cec90 [ 5139.303611] FS:&nbsp;=
 00007f42ffca0000(0000) GS:ff11007e7fa40000(0000) knlGS:0000000000000000 [ =
5139.303612] CS:&nbsp; 0010 DS: 0000 ES: 0000
 CR0: 0000000080050033 [ 5139.303613] CR2: 00007f23d945ab68 CR3: 0000000121=
2ce005 CR4: 0000000000771ee0 [ 5139.303614] DR0: 0000000000000000 DR1: 0000=
000000000000 DR2: 0000000000000000 [ 5139.303615] DR3: 0000000000000000 DR6=
: 00000000fffe07f0 DR7: 0000000000000400
 [ 5139.303615] PKRU: 55555554 [ 5139.303616] Call Trace:</span><span style=
=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p=
></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">[ 5139.303617]&nbsp; &lt;TASK&gt;</span><span style=
=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p=
></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">[ 5139.303619]&nbsp; amdttm_range_man_fini_nocheck+=
0xfe/0x1c0 [amdttm] [ 5139.303625]&nbsp; amdgpu_ttm_fini+0x2ed/0x390 [amdgp=
u] [ 5139.303800]&nbsp; amdgpu_bo_fini+0x27/0xc0 [amdgpu] [ 5139.303959]&nb=
sp;
 gmc_v9_0_sw_fini+0x63/0x90 [amdgpu] [ 5139.304144]&nbsp; amdgpu_device_fin=
i_sw+0x125/0x6a0 [amdgpu] [ 5139.304302]&nbsp; amdgpu_driver_release_kms+0x=
16/0x30 [amdgpu] [ 5139.304455]&nbsp; devm_drm_dev_init_release+0x4a/0x80 [=
drm] [ 5139.304472]&nbsp; devm_action_release+0x12/0x20
 [ 5139.304476]&nbsp; release_nodes+0x3d/0xb0 [ 5139.304478]&nbsp; devres_r=
elease_all+0x9b/0xd0 [ 5139.304480]&nbsp; really_probe+0x11d/0x420 [ 5139.3=
04483]&nbsp; __driver_probe_device+0x119/0x190 [ 5139.304485]&nbsp; driver_=
probe_device+0x23/0xc0 [ 5139.304487]&nbsp; __driver_attach+0xf7/0x1f0
 [ 5139.304489]&nbsp; ? __device_attach_driver+0x140/0x140</span><span styl=
e=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:=
p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">[ 5139.304491]&nbsp; bus_for_each_dev+0x7c/0xd0 [ 5=
139.304493]&nbsp; driver_attach+0x1e/0x30 [ 5139.304494]&nbsp; bus_add_driv=
er+0x148/0x220 [ 5139.304496]&nbsp; driver_register+0x95/0x100 [ 5139.30449=
8]&nbsp;
 __pci_register_driver+0x68/0x70 [ 5139.304500]&nbsp; amdgpu_init+0xbc/0x10=
00 [amdgpu] [ 5139.304655]&nbsp; ? 0xffffffffc0b8f000 [ 5139.304657]&nbsp; =
do_one_initcall+0x46/0x1e0 [ 5139.304659]&nbsp; ? kmem_cache_alloc_trace+0x=
19e/0x2e0</span><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&q=
uot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">[ 5139.304663]&nbsp; do_init_module+0x52/0x260 [ 51=
39.304665]&nbsp; load_module+0xb2b/0xbc0 [ 5139.304667]&nbsp; __do_sys_fini=
t_module+0xbf/0x120 [ 5139.304669]&nbsp; __x64_sys_finit_module+0x18/0x20
 [ 5139.304670]&nbsp; do_syscall_64+0x59/0xc0 [ 5139.304673]&nbsp; ? exit_t=
o_user_mode_prepare+0x37/0xb0</span><span style=3D"font-size:10.0pt;font-fa=
mily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">[ 5139.304676]&nbsp; ? syscall_exit_to_user_mode+0x=
27/0x50</span><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quo=
t;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">[ 5139.304678]&nbsp; ? __x64_sys_mmap+0x33/0x50 [ 5=
139.304680]&nbsp; ? do_syscall_64+0x69/0xc0 [ 5139.304681]&nbsp; entry_SYSC=
ALL_64_after_hwframe+0x61/0xcb</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">[ 5139.304684] RIP: 0033:0x7f42ffdbf88d</span><span=
 style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">[ 5139.304686] Code: 5b 41 5c c3 66 0f 1f 84 00 00 =
00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 =
4c 8b 4c 24 08 0f 05 &lt;48&gt; 3d 01 f0 ff ff 73 01
 c3 48 8b 0d 73 b5 0f 00 f7 d8 64 89 01 48 [ 5139.304687] RSP: 002b:00007ff=
cb7427158 EFLAGS: 00000246 ORIG_RAX: 0000000000000139 [ 5139.304688] RAX: f=
fffffffffffffda RBX: 000055ce8b8f3150 RCX: 00007f42ffdbf88d [ 5139.304689] =
RDX: 0000000000000000 RSI: 000055ce8b8f9a70
 RDI: 000000000000000a [ 5139.304690] RBP: 0000000000040000 R08: 0000000000=
000000 R09: 0000000000000011 [ 5139.304690] R10: 000000000000000a R11: 0000=
000000000246 R12: 000055ce8b8f9a70 [ 5139.304691] R13: 000055ce8b8f2ec0 R14=
: 000055ce8b8f2ab0 R15: 000055ce8b8f9aa0
 [ 5139.304692]&nbsp; &lt;/TASK&gt; [ 5139.304693] ---[ end trace 8536b052f=
7883003 ]---</span><span style=3D"font-size:10.0pt;font-family:&quot;Calibr=
i&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">Signed-off-by: Ce Sun &lt;<a href=3D"mailto:cesun10=
2@amd.com">cesun102@amd.com</a>&gt;</span><span style=3D"font-size:10.0pt;f=
ont-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">---</span><span style=3D"font-size:10.0pt;font-fami=
ly:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c |&nbsp; 4=
 +++-</span><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;=
,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp;=
 |&nbsp; 2 ++</span><span style=3D"font-size:10.0pt;font-family:&quot;Calib=
ri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c&nbsp;&nbsp;=
 |&nbsp; 4 ++--</span><span style=3D"font-size:10.0pt;font-family:&quot;Cal=
ibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c&nbsp;&nbsp;=
 | 15 +++++++++++----</span><span style=3D"font-size:10.0pt;font-family:&qu=
ot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&n=
bsp;&nbsp; |&nbsp; 6 ++++--</span><span style=3D"font-size:10.0pt;font-fami=
ly:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c&nbsp; |&nb=
sp; 6 ++++--</span><span style=3D"font-size:10.0pt;font-family:&quot;Calibr=
i&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">drivers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 6 ++++--</span><span style=3D"font-size:1=
0.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">7 files changed, 30 insertions(+), 13 deletions(-)<=
/span><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-=
serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fenc=
e.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c</span><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></=
p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">index d4f3fb3519c8..1166093d2b5b 100644</span><span=
 style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c</sp=
an><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-ser=
if"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c</sp=
an><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-ser=
if"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">@@ -614,7 +614,9 @@ void amdgpu_fence_driver_hw_fin=
i(struct amdgpu_device *adev)</span><span style=3D"font-size:10.0pt;font-fa=
mily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!drm_dev_is_unplugged(ade=
v_to_drm(adev)) &amp;&amp;</span><span style=3D"font-size:10.0pt;font-famil=
y:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-=
&gt;fence_drv.irq_src &amp;&amp;</span><span style=3D"font-size:10.0pt;font=
-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fence_nee=
d_ring_interrupt_restore(ring))</span><span style=3D"font-size:10.0pt;font-=
family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fence_nee=
d_ring_interrupt_restore(ring) &amp;&amp;</span><span style=3D"font-size:10=
.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_enabl=
ed(adev, ring-&gt;fence_drv.irq_src,</span><span style=3D"font-size:10.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; ring-&gt;fence_drv.irq_type))</span><span style=3D"f=
ont-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></sp=
an></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, ring-&gt;fence_drv.irq_src,</span><=
span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif">=
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;fence_drv.irq_type);</span><span=
 style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.=
c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c</span><span style=3D"font-size:=
10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">index cb7991362b5d..6f24e95c9112 100644</span><span=
 style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c</span=
><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif=
"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c</span=
><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif=
"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">@@ -2496,6 +2496,8 @@ void amdgpu_ttm_fini(struct a=
mdgpu_device *adev)</span><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; am=
dgpu_vram_mgr_fini(adev);</span><span style=3D"font-size:10.0pt;font-family=
:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; am=
dgpu_gtt_mgr_fini(adev);</span><span style=3D"font-size:10.0pt;font-family:=
&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; am=
dgpu_preempt_mgr_fini(adev);</span><span style=3D"font-size:10.0pt;font-fam=
ily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_doorbe=
ll_fini(adev);</span><span style=3D"font-size:10.0pt;font-family:&quot;Cali=
bri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+</span><span style=3D"font-size:10.0pt;font-family=
:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tt=
m_range_man_fini(&amp;adev-&gt;mman.bdev, AMDGPU_PL_GDS);</span><span style=
=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p=
></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tt=
m_range_man_fini(&amp;adev-&gt;mman.bdev, AMDGPU_PL_GWS);</span><span style=
=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p=
></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tt=
m_range_man_fini(&amp;adev-&gt;mman.bdev, AMDGPU_PL_OA); diff --git a/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.=
c</span><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,san=
s-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">index cd6e4c0b94da..e970a1427fe0 100644</span><span=
 style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c</span=
><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif=
"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c</span=
><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif=
"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">@@ -719,10 +719,10 @@ void amdgpu_xcp_cfg_sysfs_fin=
i(struct amdgpu_device *adev)</span><span style=3D"font-size:10.0pt;font-fa=
mily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; st=
ruct amdgpu_xcp_cfg *xcp_cfg;</span><span style=3D"font-size:10.0pt;font-fa=
mily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in=
t i;</span><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,=
sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt=
;xcp_mgr)</span><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&q=
uot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt=
;xcp_mgr || !adev-&gt;xcp_mgr-&gt;xcp_cfg)</span><span style=3D"font-size:1=
0.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;</span><span style=3D"=
font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></s=
pan></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xcp_cfg =3D&n=
bsp; adev-&gt;xcp_mgr-&gt;xcp_cfg;</span><span style=3D"font-size:10.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xcp_cfg =3D a=
dev-&gt;xcp_mgr-&gt;xcp_cfg;</span><span style=3D"font-size:10.0pt;font-fam=
ily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fo=
r (i =3D 0; i &lt; xcp_cfg-&gt;num_res; i++) {</span><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p=
>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xcp_res =3D &amp;xcp_cfg-&gt;=
xcp_res[i];</span><span style=3D"font-size:10.0pt;font-family:&quot;Calibri=
&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kobject_put(&amp;xcp_res-&gt;=
kobj);</span><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot=
;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.=
c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c</span><span style=3D"font-size:=
10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">index dcc6752c3ece..dd0a2cfd85cf 100644</span><span=
 style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c</span=
><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif=
"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c</span=
><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif=
"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">@@ -2379,10 +2379,17 @@ static int gfx_v9_4_3_hw_fi=
ni(struct amdgpu_ip_block *ip_block)</span><span style=3D"font-size:10.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; st=
ruct amdgpu_device *adev =3D ip_block-&gt;adev;</span><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></=
p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in=
t i, num_xcc;</span><span style=3D"font-size:10.0pt;font-family:&quot;Calib=
ri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_pu=
t(adev, &amp;adev-&gt;gfx.priv_reg_irq, 0);</span><span style=3D"font-size:=
10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_pu=
t(adev, &amp;adev-&gt;gfx.spm_irq, 0);</span><span style=3D"font-size:10.0p=
t;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_pu=
t(adev, &amp;adev-&gt;gfx.priv_inst_irq, 0);</span><span style=3D"font-size=
:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_pu=
t(adev, &amp;adev-&gt;gfx.bad_op_irq, 0);</span><span style=3D"font-size:10=
.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ir=
q_enabled(adev, &amp;adev-&gt;gfx.priv_reg_irq, 0))</span><span style=3D"fo=
nt-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></spa=
n></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gfx.p=
riv_reg_irq, 0);</span><span style=3D"font-size:10.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+</span><span style=3D"font-size:10.0pt;font-family=
:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ir=
q_enabled(adev, &amp;adev-&gt;gfx.spm_irq, 0))</span><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p=
>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gfx.s=
pm_irq, 0);</span><span style=3D"font-size:10.0pt;font-family:&quot;Calibri=
&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+</span><span style=3D"font-size:10.0pt;font-family=
:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ir=
q_enabled(adev, &amp;adev-&gt;gfx.priv_inst_irq, 0))</span><span style=3D"f=
ont-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></sp=
an></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gfx.p=
riv_inst_irq, 0);</span><span style=3D"font-size:10.0pt;font-family:&quot;C=
alibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+</span><span style=3D"font-size:10.0pt;font-family=
:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ir=
q_enabled(adev, &amp;adev-&gt;gfx.bad_op_irq, 0))</span><span style=3D"font=
-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gfx.b=
ad_op_irq, 0);</span><span style=3D"font-size:10.0pt;font-family:&quot;Cali=
bri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nu=
m_xcc =3D NUM_XCC(adev-&gt;gfx.xcc_mask);</span><span style=3D"font-size:10=
.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fo=
r (i =3D 0; i &lt; num_xcc; i++) {</span><span style=3D"font-size:10.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c =
b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c</span><span style=3D"font-size:10.0=
pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">index 59385da80185..05599c253e24 100644</span><span=
 style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c</span><=
span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif">=
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c</span><=
span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif">=
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">@@ -2513,10 +2513,12 @@ static int gmc_v9_0_hw_fini=
(struct amdgpu_ip_block *ip_block)</span><span style=3D"font-size:10.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; * are not enabled.</span><span style=3D"font-size:10.0pt;font-family:&q=
uot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; */</span><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot=
;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (adev-&gt;init_lvl-&gt;level !=3D AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {</span>=
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"=
><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gmc.v=
m_fault, 0);</span><span style=3D"font-size:10.0pt;font-family:&quot;Calibr=
i&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_irq_enabled(adev, &amp;adev-&=
gt;gmc.vm_fault, 0))</span><span style=3D"font-size:10.0pt;font-family:&quo=
t;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gmc.vm_fault, 0);</span><span st=
yle=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></=
o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.ecc_irq.func=
s &amp;&amp;</span><span style=3D"font-size:10.0pt;font-family:&quot;Calibr=
i&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_is_su=
pported(adev, AMDGPU_RAS_BLOCK__UMC))</span><span style=3D"font-size:10.0pt=
;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_is_su=
pported(adev, AMDGPU_RAS_BLOCK__UMC) &amp;&amp;</span><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></=
p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_enabl=
ed(adev, &amp;adev-&gt;gmc.ecc_irq, 0))</span><span style=3D"font-size:10.0=
pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gmc.ecc_irq, 0);</spa=
n><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-seri=
f"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<=
/span><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-=
serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2=
.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c</span><span style=3D"font-siz=
e:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">index 11f9c07f1e8d..60f5f3b367d8 100644</span><span=
 style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c</spa=
n><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-seri=
f"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c</spa=
n><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-seri=
f"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">@@ -1615,8 +1615,10 @@ static int sdma_v4_4_2_hw_fi=
ni(struct amdgpu_ip_block *ip_block)</span><span style=3D"font-size:10.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in=
st_mask =3D GENMASK(adev-&gt;sdma.num_instances - 1, 0);</span><span style=
=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p=
></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {</span><span styl=
e=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:=
p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt=
;sdma.num_instances; i++) {</span><span style=3D"font-size:10.0pt;font-fami=
ly:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;sdma.ecc_irq,</span><span style=
=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p=
></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; AMDGPU_SDMA_IRQ_INSTANCE0 + i);</span><span style=3D=
"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></=
span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (amdgpu_irq_enabled(adev, &amp;adev-&gt;sdma.ecc_irq,</span><spa=
n style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDG=
PU_SDMA_IRQ_INSTANCE0 + i))</span><span style=3D"font-size:10.0pt;font-fami=
ly:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev=
, &amp;adev-&gt;sdma.ecc_irq,</span><span style=3D"font-size:10.0pt;font-fa=
mily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDG=
PU_SDMA_IRQ_INSTANCE0 + i);</span><span style=3D"font-size:10.0pt;font-fami=
ly:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></=
p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<=
/span><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-=
serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/d=
rivers/gpu/drm/amd/amdgpu/soc15.c</span><span style=3D"font-size:10.0pt;fon=
t-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">index c457be3a3c56..5a60cf679307 100644</span><span=
 style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">--- a/drivers/gpu/drm/amd/amdgpu/soc15.c</span><spa=
n style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c</span><spa=
n style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">@@ -1338,10 +1338,12 @@ static int soc15_common_hw_=
fini(struct amdgpu_ip_block *ip_block)</span><span style=3D"font-size:10.0p=
t;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.ras_if &amp;&amp;</span><span style=3D"=
font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></s=
pan></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ras_is_supported(adev, adev-&gt;nbio.ras_if-&g=
t;block)) {</span><span style=3D"font-size:10.0pt;font-family:&quot;Calibri=
&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;nbio.ras &amp;&a=
mp;</span><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.ra=
s-&gt;init_ras_controller_interrupt)</span><span style=3D"font-size:10.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.ra=
s-&gt;init_ras_controller_interrupt &amp;&amp;</span><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p=
>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_enabl=
ed(adev, &amp;adev-&gt;nbio.ras_controller_irq, 0))</span><span style=3D"fo=
nt-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></spa=
n></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;nbio.ras_controller_i=
rq, 0);</span><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quo=
t;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;nbio.ras &amp;&a=
mp;</span><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.ra=
s-&gt;init_ras_err_event_athub_interrupt)</span><span style=3D"font-size:10=
.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.ra=
s-&gt;init_ras_err_event_athub_interrupt &amp;&amp;</span><span style=3D"fo=
nt-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></spa=
n></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_enabl=
ed(adev, &amp;adev-&gt;nbio.ras_err_event_athub_irq, 0))</span><span style=
=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p=
></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;nbio.ras_err_event_at=
hub_irq, 0);</span><span style=3D"font-size:10.0pt;font-family:&quot;Calibr=
i&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<=
/span><span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-=
serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">--</span><span style=3D"font-size:10.0pt;font-famil=
y:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">2.34.1</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;</span><span style=3D"font-size:10.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_PH7PR12MB879699A163100AD41156942BB097APH7PR12MB8796namp_--
