Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE04C2BD09
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jul 2024 02:54:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A204E10E02B;
	Tue,  2 Jul 2024 02:54:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uVYRkJxB";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B77310E02B
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jul 2024 02:54:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGit5g+2Mde+FPxIgXGjJKhziBKODN4FxuUCPHtsdGRirlAt7pBsaJ086d92j6LKZbSW7SX/QPyL7ocVrHH337N2pAJ9wKPhobZV/TwfnhgjZgNwPNCCgIkdPxTcFZkQEqaCEVA3kxdpLR2ZGgCRSPlOW+YWFl2nD0JB/zDXSeMO3mzBBXURpg28QH/g2vK40Goobww8AVhI4SNVO1TqEdMvp3bxHpOwVBNlO1ftyFUERfQSjA9uSNIx2gEYKLK4GN21975SemqWn15p2BLrEIvLZa0phO04mlIfzUJajfpZPpWYmJU5grJQ9FWFeB2ubIjsD+7TzFW5Ht+GmGXD5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNOKOdDr+TxDGorhwpXvEX9PEheNF2Km6aGTvBoWGDI=;
 b=jzZ2bEb0jNJkjzosD2C/JdLnNzQqlwGHRsochtXXDFvJAbVWNGSvCmrjIcwcYpPub7jflFhYJns4Rpa+ErDhAf8OfN+HF4BNMF9T/jp+6DTLix6EqSbTMtv7KhpIjidaEyhaVWsUzVRiGbu8QHd4DX2BbT5Qwu9NWfEcyvSWXnKmIRGGt40KCbBaj0j0YD/oJn3NiGKudmmpkjJuzbvJJ8jYOtyii50Zz4Z2akb0vFf2zsRdHPfO2B2uGtUE5wypPehhSHRnQMLUUIvtHg4ow6PSphHsaWjg9aZ3f3sndPW4+vEhQyXbRsTn92wVUQ4jTC9N91rjW0WlZIgHs/bLPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNOKOdDr+TxDGorhwpXvEX9PEheNF2Km6aGTvBoWGDI=;
 b=uVYRkJxBEPfbnvxEmxPCsIUGP8dGk7Zb4c1U0vDpMEo2VZS84ClUCIInw7cjh+2gB5214iqIgw3H7qcWoXnAsO7ft1C/qnEW1QBVmCU0R9DdmrNFu9EoJ3feTvUtklNxDrsh7VMr7FFNZ/FsCZOQ8V6whL3z0TPeTrW8CuTbM1w=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by IA1PR12MB7639.namprd12.prod.outlook.com (2603:10b6:208:425::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 02:54:28 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%2]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 02:54:28 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>
Subject: RE: [PATCH v2] drm/amd/swsmu: enable more Pstates profile levels for
 SMU v14.0.0 and v14.0.1
Thread-Topic: [PATCH v2] drm/amd/swsmu: enable more Pstates profile levels for
 SMU v14.0.0 and v14.0.1
Thread-Index: AQHay6OvO3dqy0Ieq0+pWCltrAlZQLHhvFfAgAAdd4CAAOAqUA==
Date: Tue, 2 Jul 2024 02:54:28 +0000
Message-ID: <CH3PR12MB8074D58744C605AFBA2CECF7F6DC2@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240701104354.507531-1-li.ma@amd.com>
 <CH3PR12MB8074E005B23BD9557179384FF6D32@CH3PR12MB8074.namprd12.prod.outlook.com>
 <SJ1PR12MB6075255F6AE1FC133B1F2E12FAD32@SJ1PR12MB6075.namprd12.prod.outlook.com>
In-Reply-To: <SJ1PR12MB6075255F6AE1FC133B1F2E12FAD32@SJ1PR12MB6075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=69874521-6139-458f-8dea-2e810a4966da;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-01T11:28:35Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|IA1PR12MB7639:EE_
x-ms-office365-filtering-correlation-id: 70c5f2aa-237b-40e8-f4a9-08dc9a424a40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?e6BeGdyazLqZjfGNfyWOzIPO0fOMA3QjLGEpAEVKffDunIrxzq+yqoqmGnXe?=
 =?us-ascii?Q?uaJMx0d4dS+Xn1s66fs+wx4SxuTwiYuQzkZ6ipoflyAob7d3OYBnfqwwKuWe?=
 =?us-ascii?Q?tx3gwaXWE2hjqXNCF2+xPGNsR41rYBAt/8Bm0l1G8Z4YIl87+sEtUIq3jcyj?=
 =?us-ascii?Q?XScnoqGbN9c6M8+j8ZhqqthGs/8ApkNj6NIOyCT/S6DOHZZsBJEmbS9h0N3G?=
 =?us-ascii?Q?9U097DDKyPe1Voq6ABXa810hG7GVDCFvtE3i+LZlAFVYsvUe4a7xlwZuhV9I?=
 =?us-ascii?Q?NXj8/CQn4agWt9+kGmKB6FyKw6nnhxgJgBXbnRkoCmjJCMg++w900qcUHNZk?=
 =?us-ascii?Q?qMoKy1kCAkGK0gUGDAkbG6qf8AzTNXzKa1GCe/1i8R1rRMDCnClv/VhYvjmC?=
 =?us-ascii?Q?6Jl98L/ayjbyUMshnxewGS5F0Y6Nkfmxg3Ycsg2oCNaZp+BTq3S5+K6ErX9f?=
 =?us-ascii?Q?U1JOq6YVSj8xPoFUIANeO4iyetsXsyUyxBsb4D8r0l/cupFg/+kWqG7quYqS?=
 =?us-ascii?Q?TqMBmUHk4kC17sswLwTYU2qCCOsJyWuC76aQSk9KjbGWjemSKl8SwrkeZMUB?=
 =?us-ascii?Q?AjFDy0gEShMJa38c6qo1XIsW5Fpp1ag2iDJBT6Qva1wxctYzmP2wsPQO5ZTw?=
 =?us-ascii?Q?TrhA7sTT/8bXpON7r+7O9sQPBNLr18lZ0Ft5dHbXMe6fWBs9sRuUmuMGcnrr?=
 =?us-ascii?Q?mjRGLA0ZddhnYvlq6l7j2rtbr1yZGAw8GUA3xaTtciei54oLjEChRA1JrDAV?=
 =?us-ascii?Q?ttk5opyWFQczShIyX+7KaVk3GkIdOMNVw8ka/EV+tXeborA1a7tPiIm/K4M8?=
 =?us-ascii?Q?YtAXFyGdZ414XeJSY412/Yoax86VeiLS9/qZunQkUh/KkifvtzBe6utyY8g5?=
 =?us-ascii?Q?v6+sxkBWkWzY9Xi4SCRfO7y9gTN9yyaKLz3UeHvMiuT783S9hxVBxW8Ds7oY?=
 =?us-ascii?Q?P8UyQwnOXfSC7WqFCwsffHbDIODHZWBXbZXNfFwxcG/7pGxZrXu2315Wcdnp?=
 =?us-ascii?Q?z0W4S1OVu1NiEuHQtdnnTHQOwie1LRIYsu1nn2/DVwtAU8m6j7J42cLgm0NS?=
 =?us-ascii?Q?JFBykNBtrmjZZboxTbx5Z/mCbaXdoYmqxS6AKUovwqc4Rs6yhTsynZG78cuN?=
 =?us-ascii?Q?U4pqmQkdsZBQUpul4JUfs/mioOYShNi8Hst425yPGD/TJmiQUWIRkyxF4ysC?=
 =?us-ascii?Q?otMZ9xw2A60GglVD0pGDsSc2WUHDDhx6qGrxYqKJudkYugJzWb8xVNvXHtsK?=
 =?us-ascii?Q?0O6WUVtnMoUrPaYmwATIrwojUmMe8XhNf8CBnJf+2hPGFX3U9ny6Wc2sZpfg?=
 =?us-ascii?Q?WHJTo+mN49MldzZDHOIhTrGwTA03FDXnNE/y+9qa7+11t5AAA8OkW/GXpTWD?=
 =?us-ascii?Q?JlCE7Hbo1NXy3K0tSyKDb6B+fesjCaYzx8oFxYyo7eFDwhF6lg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zq0L9J8k2c3m2KK2VoWDx5PjwqIVNDLGuaaV9CDvy+lovjjQGwZZmp1IWK3g?=
 =?us-ascii?Q?7gtynvEGK9D00C6hFkwnPDa7F1VOEkA2JLlDIyCC1l6pfNiG0KrsMSLIGwpN?=
 =?us-ascii?Q?mdXhydQ3huaRtyb+zlpmEKL2/eXMW9D9CEL6ffrUn3h+8JNc1mVMJTF0d2s/?=
 =?us-ascii?Q?8YjLMX0xQdeyaqykqyVwacoQnYmVMdrLQcJ81P0TacO2UsWcsO4S9CD0p/d7?=
 =?us-ascii?Q?YA7hVUUJEIj6Zgkkg8IbKjI3W6SXhxjK/N8hyL7YHVbwRsgNIjQsBSTvd+6p?=
 =?us-ascii?Q?UORCMcVd2SWrn78aGEF3EnUjRSnCer1/M2l9KdcOLKnUEgnb9wkh4nSwSLug?=
 =?us-ascii?Q?hCEH3k6eB3suAjdhMYhuS/yOj+9fm304XiMVUcPmU5vnYqUICCDuyHci+Twy?=
 =?us-ascii?Q?SKUZYIwTGVCB/ZuYzoqDQIPjnFJwlTO864wE26E5asGFWC5yFZBmwAS1udO5?=
 =?us-ascii?Q?/sJQ6PF3TxIf3m2caGMrNTy+QgQc+xodyI1ulivmYlTRiba/8kHhA88aPZul?=
 =?us-ascii?Q?8DtCaj7RTp1x3cTMIP04MHM6GN8WxqYDOllvW6zWyh+Eiagaqd5ol5ZeTDL3?=
 =?us-ascii?Q?CCnR839rNzrtXLKpsB3zCc7kNb/dN815LqeFbe2C1T2kMOrYwI9pYG0yVzlI?=
 =?us-ascii?Q?SXyHUupGskUVR81t0SOVdubynJfuYfZ4pV5ELP2O5lpsNfokhDChVd52F+jk?=
 =?us-ascii?Q?HMCB+wapenbcGC/cHnSDpBrHyenMQhrlVVfUuEkm7UfQvjNG4+F3qMNO49zq?=
 =?us-ascii?Q?GYSo6iOlTZ84Mus0DCnjdkCkbDtpWKWtYwQ4Twwwf2EJFOdNMzhZoImHCzFn?=
 =?us-ascii?Q?I4sC3gsiqLoZOM2dxUCHl16nnXUuoHKkxndNRIswG6yOLMMpbbB9d8dNLvsS?=
 =?us-ascii?Q?Km2wA4MVLCcQoGnmKajcHAibiol2LMGGAybrn7geT9LfX4mDE7k7VUipll9c?=
 =?us-ascii?Q?nMZyMcX58pRT/0/tPo/qO0n4T0wHCC0HTj2bZByO3WE4bKb6Xj8deK0xNynv?=
 =?us-ascii?Q?Olf1ZyMc9wWIUeDJqojIwz8yjXVIIpoPC4OUJU7mKPXA5M4xygg+TtuK0U1k?=
 =?us-ascii?Q?gwHgMkY4wmKGMSRFJEhJWiaGXRbmqPyLCF3wZ8Bu02bcgvjq9/4svoESqoHF?=
 =?us-ascii?Q?2zofQxBO9Sk3ksoo1KLJpadYXFA6TOv9tpAgeJdsL1r2zfCijdRQ1xuBI1z4?=
 =?us-ascii?Q?Rv9gTkSZwFMtzm0SvwowQe40l12IxSxZX6RqPsaSs8LMSrv9hlS1W6YG/Qhq?=
 =?us-ascii?Q?ZgxQHMjttAEn0osUEHqT9if714F4dyLur42aI2NDKGnGIws6xsrEnAR4VRoa?=
 =?us-ascii?Q?cp2UXY85D2wc5GEO2V8wjILHl91aJdUwdtQATgIvjPEbJI8YlZeYjSeQnm/S?=
 =?us-ascii?Q?oGD4uereLLBb3JybOF/cQsMG4iT+y1KbqUh12CxfAy8yaBZZRLfyBAbXnd+p?=
 =?us-ascii?Q?lSGsX3OodX3OWhKv+dbgJgmi/n+TUimFAZKwYF0DRiwkzIf8CfRaLHqkya+n?=
 =?us-ascii?Q?Ue0Pkou/vOf86Tqf4W+ClzCVQO9//Sp7bixt4hbL2eOnMcNmt0K6pDzvqAoQ?=
 =?us-ascii?Q?xYDjhvum6GrCftdss5I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c5f2aa-237b-40e8-f4a9-08dc9a424a40
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 02:54:28.3603 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v3HkhWbyHYIOS1qsHnxEFZD0hma2XHKubaKItldAP0tJIVeW7G1PvsHTzygjZ2CFw1h7J1tVUADkomzP3N3gFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7639
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

Hi Li,

> -----Original Message-----
> From: Ma, Li <Li.Ma@amd.com>
> Sent: Monday, July 1, 2024 9:14 PM
> To: Huang, Tim <Tim.Huang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>
> Subject: RE: [PATCH v2] drm/amd/swsmu: enable more Pstates profile levels
> for SMU v14.0.0 and v14.0.1
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Tim,
>
> > -----Original Message-----
> > From: Huang, Tim <Tim.Huang@amd.com>
> > Sent: Monday, July 1, 2024 7:32 PM
> > To: Ma, Li <Li.Ma@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
> > <Yifan1.Zhang@amd.com>
> > Subject: RE: [PATCH v2] drm/amd/swsmu: enable more Pstates profile
> > levels for SMU v14.0.0 and v14.0.1
> >
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > Hi Li,
> >
> > > -----Original Message-----
> > > From: Ma, Li <Li.Ma@amd.com>
> > > Sent: Monday, July 1, 2024 6:44 PM
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
> > > <Yifan1.Zhang@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Ma, Li
> > > <Li.Ma@amd.com>
> > > Subject: [PATCH v2] drm/amd/swsmu: enable more Pstates profile
> > > levels for SMU v14.0.0 and v14.0.1
> > >
> > > This patch enables following UMD stable Pstates profile levels for
> > > power_dpm_force_performance_level interface.
> > >
> > > - profile_peak
> > > - profile_min_mclk
> > > - profile_min_sclk
> > > - profile_standard
> > >
> > > Signed-off-by: Li Ma <li.ma@amd.com>
> > > ---
> > >  .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 138
> > > +++++++++++++++++-
> > >  1 file changed, 131 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > > b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > > index 3a9d58c036ea..72fca481dec1 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > > @@ -65,6 +65,10 @@
> > >
> > >  #define SMU_MALL_PG_CONFIG_DEFAULT
> > > SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_ON
> > >
> > > +#define SMU_14_0_0_UMD_PSTATE_GFXCLK                 700
> > > +#define SMU_14_0_0_UMD_PSTATE_SOCCLK                 678
> > > +#define SMU_14_0_0_UMD_PSTATE_FCLK                   1800
> > > +
> > >  #define FEATURE_MASK(feature) (1ULL << feature)  #define
> > > SMC_DPM_FEATURE ( \
> > >       FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \ @@ -818,9 +822,11
> @@
> > > static int smu_v14_0_1_get_dpm_ultimate_freq(struct smu_context *smu,
> > >                       break;
> > >               case SMU_MCLK:
> > >               case SMU_UCLK:
> > > -             case SMU_FCLK:
> > >                       max_dpm_level =3D 0;
> > >                       break;
> > > +             case SMU_FCLK:
> > > +                     max_dpm_level =3D
> clk_table->NumFclkLevelsEnabled - 1;
> > > +                     break;
> > >               case SMU_SOCCLK:
> > >                       max_dpm_level =3D
> clk_table->NumSocClkLevelsEnabled - 1;
> > >                       break;
> > > @@ -855,7 +861,7 @@ static int
> > > smu_v14_0_1_get_dpm_ultimate_freq(struct smu_context *smu,
> > >                       min_dpm_level =3D
> clk_table->NumMemPstatesEnabled - 1;
> > >                       break;
> > >               case SMU_FCLK:
> > > -                     min_dpm_level =3D
> clk_table->NumFclkLevelsEnabled - 1;
> > > +                     min_dpm_level =3D 0;
> > >                       break;
> > >               case SMU_SOCCLK:
> > >                       min_dpm_level =3D 0; @@ -936,9 +942,11 @@
> static
> > > int smu_v14_0_0_get_dpm_ultimate_freq(struct smu_context *smu,
> > >                       break;
> > >               case SMU_MCLK:
> > >               case SMU_UCLK:
> > > -             case SMU_FCLK:
> > >                       max_dpm_level =3D 0;
> > >                       break;
> > > +             case SMU_FCLK:
> > > +                     max_dpm_level =3D
> clk_table->NumFclkLevelsEnabled - 1;
> > > +                     break;
> > >               case SMU_SOCCLK:
> > >                       max_dpm_level =3D
> clk_table->NumSocClkLevelsEnabled - 1;
> > >                       break;
> > > @@ -969,7 +977,7 @@ static int
> > > smu_v14_0_0_get_dpm_ultimate_freq(struct smu_context *smu,
> > >                       min_dpm_level =3D
> clk_table->NumMemPstatesEnabled - 1;
> > >                       break;
> > >               case SMU_FCLK:
> > > -                     min_dpm_level =3D
> clk_table->NumFclkLevelsEnabled - 1;
> > > +                     min_dpm_level =3D 0;
> > >                       break;
> > >               case SMU_SOCCLK:
> > >                       min_dpm_level =3D 0; @@ -1268,13 +1276,67
> @@
> > > static int smu_v14_0_0_force_clk_levels(struct
> > > smu_context *smu,
> > >       return ret;
> > >  }
> > >
> > > -static int smu_v14_0_0_set_performance_level(struct smu_context
> > > *smu,
> > > +static int smu_v14_0_common_get_dpm_profile_freq(struct smu_context
> > > *smu,
> > > +                                     enum amd_dpm_forced_level
> level,
> > > +                                     enum smu_clk_type clk_type,
> > > +                                     uint32_t *min_clk,
> > > +                                     uint32_t *max_clk) {
> > > +     uint32_t clk_limit =3D 0;
> > > +     int ret =3D 0;
> > > +
> > > +     switch (clk_type) {
> > > +     case SMU_GFXCLK:
> > > +     case SMU_SCLK:
> > > +             clk_limit =3D SMU_14_0_0_UMD_PSTATE_GFXCLK;
> > > +             if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
> > > +
> smu_v14_0_common_get_dpm_ultimate_freq(smu,
> > SMU_SCLK,
> > > NULL, &clk_limit);
> > > +             else if (level =3D=3D
> AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK)
> > > +
> smu_v14_0_common_get_dpm_ultimate_freq(smu,
> > SMU_SCLK,
> > > &clk_limit, NULL);
> > > +             break;
> > > +     case SMU_SOCCLK:
> > > +             clk_limit =3D SMU_14_0_0_UMD_PSTATE_SOCCLK;
> > > +             if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
> > > +
> smu_v14_0_common_get_dpm_ultimate_freq(smu,
> > > SMU_SOCCLK, NULL, &clk_limit);
> > > +             break;
> > > +     case SMU_FCLK:
> > > +             clk_limit =3D SMU_14_0_0_UMD_PSTATE_FCLK;
> > > +             if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
> > > +
> smu_v14_0_common_get_dpm_ultimate_freq(smu,
> > SMU_FCLK,
> > > NULL, &clk_limit);
> > > +             else if (level =3D=3D
> AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK)
> > > +
> smu_v14_0_common_get_dpm_ultimate_freq(smu,
> > SMU_FCLK,
> > > &clk_limit, NULL);
> > > +             break;
> > > +     case SMU_VCLK:
> > > +             smu_v14_0_common_get_dpm_ultimate_freq(smu,
> SMU_VCLK,
> > > NULL, &clk_limit);
> > > +             break;
> > > +     case SMU_VCLK1:
> > > +             smu_v14_0_common_get_dpm_ultimate_freq(smu,
> SMU_VCLK1,
> > > NULL, &clk_limit);
> > > +             break;
> > > +     case SMU_DCLK:
> > > +             smu_v14_0_common_get_dpm_ultimate_freq(smu,
> SMU_DCLK,
> > > NULL, &clk_limit);
> > > +             break;
> > > +     case SMU_DCLK1:
> > > +             smu_v14_0_common_get_dpm_ultimate_freq(smu,
> SMU_DCLK1,
> > > NULL, &clk_limit);
> > > +             break;
> > > +     default:
> > > +             ret =3D -EINVAL;
> > > +             break;
> > > +     }
> > > +     *min_clk =3D *max_clk =3D clk_limit;
> > > +     return ret;
> > > +}
> > > +
> > > +static int smu_v14_0_common_set_performance_level(struct
> > > +smu_context *smu,
> > >                                            enum
> amd_dpm_forced_level level)  {
> > >       struct amdgpu_device *adev =3D smu->adev;
> > >       uint32_t sclk_min =3D 0, sclk_max =3D 0;
> > >       uint32_t fclk_min =3D 0, fclk_max =3D 0;
> > >       uint32_t socclk_min =3D 0, socclk_max =3D 0;
> > > +     uint32_t vclk_min =3D 0, vclk_max =3D 0;
> > > +     uint32_t dclk_min =3D 0, dclk_max =3D 0;
> > > +     uint32_t vclk1_min =3D 0, vclk1_max =3D 0;
> > > +     uint32_t dclk1_min =3D 0, dclk1_max =3D 0;
> > >       int ret =3D 0;
> > >
> > >       switch (level) {
> > > @@ -1282,28 +1344,54 @@ static int
> > > smu_v14_0_0_set_performance_level(struct smu_context *smu,
> > >               smu_v14_0_common_get_dpm_ultimate_freq(smu,
> SMU_SCLK,
> > > NULL, &sclk_max);
> > >               smu_v14_0_common_get_dpm_ultimate_freq(smu,
> SMU_FCLK,
> > > NULL, &fclk_max);
> > >               smu_v14_0_common_get_dpm_ultimate_freq(smu,
> > > SMU_SOCCLK, NULL, &socclk_max);
> > > +             smu_v14_0_common_get_dpm_ultimate_freq(smu,
> SMU_VCLK,
> > > NULL, &vclk_max);
> > > +             smu_v14_0_common_get_dpm_ultimate_freq(smu,
> SMU_DCLK,
> > > NULL, &dclk_max);
> > > +             smu_v14_0_common_get_dpm_ultimate_freq(smu,
> SMU_VCLK1,
> > > NULL, &vclk1_max);
> > > +             smu_v14_0_common_get_dpm_ultimate_freq(smu,
> SMU_DCLK1,
> > > NULL,
> > > +&dclk1_max);
> > >               sclk_min =3D sclk_max;
> > >               fclk_min =3D fclk_max;
> > >               socclk_min =3D socclk_max;
> > > +             vclk_min =3D vclk_max;
> > > +             dclk_min =3D dclk_max;
> > > +             vclk1_min =3D vclk1_max;
> > > +             dclk1_min =3D dclk1_max;
> > >               break;
> > >       case AMD_DPM_FORCED_LEVEL_LOW:
> > >               smu_v14_0_common_get_dpm_ultimate_freq(smu,
> SMU_SCLK,
> > > &sclk_min, NULL);
> > >               smu_v14_0_common_get_dpm_ultimate_freq(smu,
> SMU_FCLK,
> > > &fclk_min, NULL);
> > >               smu_v14_0_common_get_dpm_ultimate_freq(smu,
> > > SMU_SOCCLK, &socclk_min, NULL);
> > > +             smu_v14_0_common_get_dpm_ultimate_freq(smu,
> SMU_VCLK,
> > > &vclk_min, NULL);
> > > +             smu_v14_0_common_get_dpm_ultimate_freq(smu,
> SMU_DCLK,
> > > &dclk_min, NULL);
> > > +             smu_v14_0_common_get_dpm_ultimate_freq(smu,
> SMU_VCLK1,
> > > &vclk1_min, NULL);
> > > +             smu_v14_0_common_get_dpm_ultimate_freq(smu,
> SMU_DCLK1,
> > > &dclk1_min,
> > > +NULL);
> > >               sclk_max =3D sclk_min;
> > >               fclk_max =3D fclk_min;
> > >               socclk_max =3D socclk_min;
> > > +             vclk_max =3D vclk_min;
> > > +             dclk_max =3D dclk_min;
> > > +             vclk1_max =3D vclk1_min;
> > > +             dclk1_max =3D dclk1_min;
> > >               break;
> > >       case AMD_DPM_FORCED_LEVEL_AUTO:
> > >               smu_v14_0_common_get_dpm_ultimate_freq(smu,
> SMU_SCLK,
> > > &sclk_min, &sclk_max);
> > >               smu_v14_0_common_get_dpm_ultimate_freq(smu,
> SMU_FCLK,
> > > &fclk_min, &fclk_max);
> > >               smu_v14_0_common_get_dpm_ultimate_freq(smu,
> > > SMU_SOCCLK, &socclk_min, &socclk_max);
> > > +             smu_v14_0_common_get_dpm_ultimate_freq(smu,
> SMU_VCLK,
> > > &vclk_min, &vclk_max);
> > > +             smu_v14_0_common_get_dpm_ultimate_freq(smu,
> SMU_DCLK,
> > > &dclk_min, &dclk_max);
> > > +             smu_v14_0_common_get_dpm_ultimate_freq(smu,
> SMU_VCLK1,
> > > &vclk1_min, &vclk1_max);
> > > +             smu_v14_0_common_get_dpm_ultimate_freq(smu,
> SMU_DCLK1,
> > > &dclk1_min,
> > > +&dclk1_max);
> > >               break;
> > >       case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
> > >       case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
> > >       case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
> > >       case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
> > > -             /* Temporarily do nothing since the optimal clocks have=
n't
> been
> > > provided yet */
> > > +             smu_v14_0_common_get_dpm_profile_freq(smu, level,
> > SMU_SCLK,
> > > &sclk_min, &sclk_max);
> > > +             smu_v14_0_common_get_dpm_profile_freq(smu, level,
> > SMU_FCLK,
> > > &fclk_min, &fclk_max);
> > > +             smu_v14_0_common_get_dpm_profile_freq(smu, level,
> > > SMU_SOCCLK, &socclk_min, &socclk_max);
> > > +             smu_v14_0_common_get_dpm_profile_freq(smu, level,
> > SMU_VCLK,
> > > &vclk_min, &vclk_max);
> > > +             smu_v14_0_common_get_dpm_profile_freq(smu, level,
> > SMU_DCLK,
> > > &dclk_min, &dclk_max);
> > > +             smu_v14_0_common_get_dpm_profile_freq(smu, level,
> > SMU_VCLK1,
> > > &vclk1_min, &vclk1_max);
> > > +             smu_v14_0_common_get_dpm_profile_freq(smu, level,
> > > SMU_DCLK1,
> > > +&dclk1_min, &dclk1_max);
> >
> > We should not need to set the VCLK1 and DCLK1 for SMU v14.0.0.
> >
> > Tim
>
> Li: Sorry, the change in V1 is missing here.
> There is a "else if" condition in smu_v14_0_common_get_dpm_ultimate_freq:
> +       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(1=
4,
> + 0, 1))
>                 smu_v14_0_1_get_dpm_ultimate_freq(smu, clk_type, min,
> max);
> +       else if (clk_type !=3D SMU_VCLK1 && clk_type !=3D SMU_DCLK1)
> +               smu_v14_0_0_get_dpm_ultimate_freq(smu, clk_type, min,
> + max);
>  This will avoid to set VCLK1 and DCLK1 for SMU v14.0.0 and v14.0.4 Or us=
ing
> smu version as condition is more reasonable?
>
Thanks for the clarification, I am ok to add the check here to avoid settin=
g the
VCLK1 and DCLK1 for SMU v14.0.0 and v14.0.4.

Tim


> Thanks,
> Li
>
> > >               break;
> > >       case AMD_DPM_FORCED_LEVEL_MANUAL:
> > >       case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
> > > @@ -1343,6 +1431,42 @@ static int
> > > smu_v14_0_0_set_performance_level(struct smu_context *smu,
> > >                       return ret;
> > >       }
> > >
> > > +     if (vclk_min && vclk_max) {
> > > +             ret =3D smu_v14_0_0_set_soft_freq_limited_range(smu,
> > > +
> SMU_VCLK,
> > > +
> vclk_min,
> > > +
> vclk_max);
> > > +             if (ret)
> > > +                     return ret;
> > > +     }
> > > +
> > > +     if (vclk1_min && vclk1_max) {
> > > +             ret =3D smu_v14_0_0_set_soft_freq_limited_range(smu,
> > > +
> SMU_VCLK1,
> > > +
> vclk1_min,
> > > +
> vclk1_max);
> > > +             if (ret)
> > > +                     return ret;
> > > +     }
> > > +
> > > +     if (dclk_min && dclk_max) {
> > > +             ret =3D smu_v14_0_0_set_soft_freq_limited_range(smu,
> > > +
> SMU_DCLK,
> > > +
> dclk_min,
> > > +
> dclk_max);
> > > +             if (ret)
> > > +                     return ret;
> > > +     }
> > > +
> > > +     if (dclk1_min && dclk1_max) {
> > > +             ret =3D smu_v14_0_0_set_soft_freq_limited_range(smu,
> > > +
> SMU_DCLK1,
> > > +
> dclk1_min,
> > > +
> dclk1_max);
> > > +             if (ret)
> > > +                     return ret;
> > > +     }
> > > +
> > >       return ret;
> > >  }
> > >
> > > @@ -1520,7 +1644,7 @@ static const struct pptable_funcs
> > > smu_v14_0_0_ppt_funcs =3D {
> > >       .od_edit_dpm_table =3D smu_v14_0_od_edit_dpm_table,
> > >       .print_clk_levels =3D smu_v14_0_0_print_clk_levels,
> > >       .force_clk_levels =3D smu_v14_0_0_force_clk_levels,
> > > -     .set_performance_level =3D smu_v14_0_0_set_performance_level,
> > > +     .set_performance_level =3D
> > smu_v14_0_common_set_performance_level,
> > >       .set_fine_grain_gfx_freq_parameters =3D
> > > smu_v14_0_common_set_fine_grain_gfx_freq_parameters,
> > >       .set_gfx_power_up_by_imu =3D
> smu_v14_0_set_gfx_power_up_by_imu,
> > >       .dpm_set_vpe_enable =3D smu_v14_0_0_set_vpe_enable,
> > > --
> > > 2.25.1
> >
>

