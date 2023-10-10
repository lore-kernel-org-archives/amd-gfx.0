Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A960ACD691B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 09:44:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A2EF10E1BD;
	Tue, 10 Oct 2023 09:44:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1937E10E1BD
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 09:44:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yod2EXxcWiaJZtxtICSTISADSn+nhVQ3XCxSTKmnwjCmCYd8IEjRLDJ20n7Q3UYlWl796N6JS0l8xr/sHFYeTWVuEKykekK/pwls9eM1rqp6xRUdbJq+BpM9fnz1kEJMH2qijfXLYMWcy9fyu5lq6GUNgU7zfV5Akvjq6W7kb+eSRqFjNQR/L5mIM/1YkUvoUy+fxYeZ6lb1F4M0YegN6DopgYsp+swdgOUJiUO6JUh/+Gwa+lyWr8sHVR0OahcRQYR5O5P/+97cihalzh8onGUfY5p04yO34zj1cJM0/CCRqQ2M/RoW1ndsJg9wj7vXHQ0NwGuAZ2aGIeE+Z4WezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8/J2OoO+71mHqOxddD0v+xAO+GvnFPVZ7x4D0oA1bg=;
 b=B02pxVI0+ebeQ1nQRMXZ0AVSXLNXm6vBG/xVobJZwpRfs0s083VYzk3DK2+s7Z4hEWLhR72Ygt9pl1NgoUMjVGQZasYLGhYxitKQzQka7jBLscNiTfVBZMlaRr+PbiQXqm/yesojU4fJ8Tu8lSl93od2THamuarBYcdxvyvjlaQo5Bczy5rxSK+jL7tdofsCifk6gcQKpPC0tJxjBv59oZy8u0yYV4ziPY2NyAUIYcX+oUGKlc6rghiapk8k/BF8RPtPf9QkMmyQ6Mcn6u5kw/OKJuWTruG1UGZ8igqKjcU7VglPEAERUDvab1527HRhPeCVgCa9AN272UFF63ZnDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8/J2OoO+71mHqOxddD0v+xAO+GvnFPVZ7x4D0oA1bg=;
 b=IN9L/RIde7VVu/Dzy7iIcY2oyd65HNop8slysiZUtjXFT0qY7Bc24TNHNeTkjpyH7y+T9KfC0dsYuiDV8TkxLyv3GIyowhtSdyGwwe8D/mkvUSVp34VDHwbqLLZb+ZDy/F2bEJPRkMwJck03T8d5GOBGefTbteUJJBfIfjE+F70=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by DM4PR12MB5120.namprd12.prod.outlook.com (2603:10b6:5:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 09:44:04 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::dcd1:7d96:fd8a:ba35]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::dcd1:7d96:fd8a:ba35%7]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 09:44:03 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Recall: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb
Thread-Topic: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb
Thread-Index: AQHZ+15NDCJE1opfl0CoQTwF2jtwrw==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Tue, 10 Oct 2023 09:44:03 +0000
Message-ID: <CH2PR12MB4152126877C745B781665960FECDA@CH2PR12MB4152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|DM4PR12MB5120:EE_
x-ms-office365-filtering-correlation-id: 3ea01301-2ef9-4b8b-4609-08dbc9757057
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uSV0o8QF1bYrSNVKMOjZCoKCN58On9WWJ2/s01pVz8+afL91vVbICcWeveV0wWKFPXZ0B/nuEo7hzsAtG60H70LxMlCljxumSvxQEF5MDW7K22gCG2KSsqHHfHk6v9/iOumJU3Jxxplwidwz9Le57sHQLh5nIUMGHcGad52XZPqkSpDmHJQfhFaWo6qzDiSmkILD35JHX7jpp6P9qZY2YpHkqSIctfeBlvkAOyaLi9rpbtbCnw2tbrjnoocTpgfMr0EORC4QTXNGHz1fG/tG9L96Hpn5AHHfe1V1kJ7xA2ac9j9U/o544Xeg14ets0vZqyyXGYcVYYs0x5zAmhmFcHSNNhUlbCDxrHNsTK0riq2EYGdGyZi4UHcK36Ip/QN7ll69GsIExSBSorDJLw2oEjBCpUhUObpADtEC6dDnfXBgVj+ui/dLg73JKive3/Q2/5/ncmg2N8QwJLGCzR4Ra2BC/T1sbJNpFs49M0nf4fj3t8F++M38+JImnlJYaAPLage2GmRVEv06aL5HmmZckPgqNRFOeGXqzeRwHtLHXGisjVGH7VOFGRRUfX1jdipRHTaIkP7rFyD5tk+Yf44+0xdyfxskdvSuFfoQYMu4Fn1b+6MNvnAjsXjnheZ1QHRo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(39860400002)(366004)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(83380400001)(26005)(38070700005)(66946007)(66556008)(110136005)(54906003)(64756008)(66446008)(66476007)(316002)(76116006)(33656002)(41300700001)(558084003)(38100700002)(4326008)(8936002)(2906002)(8676002)(122000001)(52536014)(5660300002)(55016003)(71200400001)(6506007)(7696005)(86362001)(9686003)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?onCBGjmJsqIt3U6tbFgU0z++mqVUPcoQK+gJyBbWpAss2HtiWMbtrdckbR?=
 =?iso-8859-1?Q?v2Ys3SdHqo27s1kqvF4x+Pko046BF/KNNhOoVZ4iAghRG0b4kCyAFHGS5V?=
 =?iso-8859-1?Q?LxVCYg3bDNR/SkG0oJPuO8o2Yd2BtoOr08pZ5ho0EETjxQ9uB4lTXMbXVx?=
 =?iso-8859-1?Q?q8ySXHuig+TDZ/EAZ2SnPP8AYZGDoxP4Qv6AArgd+Prs+4ILxt3AYDHUo0?=
 =?iso-8859-1?Q?VqAtEjsS/m3Htd+xBn9OVKzqLhpndwVRZzIM1eU7dH8KuvKS71RT2vpyeE?=
 =?iso-8859-1?Q?ZIX2gCtsmtU+qg34KPacd+K6tm4cJB1HeqmhV4FMW/JzvLyWklA3DnkpvM?=
 =?iso-8859-1?Q?PmXA6cCyeqycqM6/6p4Ey8S1ulnJ4Q4I3vJ36CP2kSdCfmhf6r7/aqSORg?=
 =?iso-8859-1?Q?2+9MA3LNZyWm+1fh2JVDjkAejG/F01NpRypRWR9auXsEtMNNw+fq5bLqnf?=
 =?iso-8859-1?Q?q5Dn5qshbM1OVva0thrgwpzq4ucndu7Cl++Gvot6Wh+e8qW47aj5rBAit6?=
 =?iso-8859-1?Q?esCU2s0XsL+DS1z+9KaCs3Vd5yBWugyQSaoopejIIIdlel19vVH/CFXUqc?=
 =?iso-8859-1?Q?C1HiHGR2K+7mmIeTk6RWeXov8Jb86Zg2oiw+nT0GlbDjFCUH3yxbbJbkFv?=
 =?iso-8859-1?Q?BqkXeduaP2Ca5pbEuc2FxSKP+aBwlb7FVEX1EzlVFyFmvuVXrd1fSNSsKK?=
 =?iso-8859-1?Q?h0jUVoIo1QaGn6BvJVC/VbUR5hj90sBKid4qgsPPrfqsKiZCV5BS8ivgOl?=
 =?iso-8859-1?Q?7JiJW7jHhC8fJ7i0C/EDb9kYwMQoEJvmQKVXRct7H2eMFaMUgLyO5LdBLu?=
 =?iso-8859-1?Q?rB54kFwg/XXoEdZc2OsvZSkjjFnyLbPdvYUBytza30wPQxAI8ja/FHy0ar?=
 =?iso-8859-1?Q?Z+ox3roBxDIjLnFTsMUZO5+weyLt0h6hwN8ZLMhAVWUuEXNHXoNUngGCss?=
 =?iso-8859-1?Q?vrgX64UIpUoiz/KfufPS+ZT61kgChDXREy/DKR3J3hYL+rR7ZS0PHKiwD/?=
 =?iso-8859-1?Q?kaaeU6KLzOK1Xk4IEvfyFaxMZucAK8pxORZKjFvfdeGYBf6Go0DkAWTMTH?=
 =?iso-8859-1?Q?TC5GoaQKwclV2Q7iuMoIsoYBNG1cgOsVUJilE/4qYdcsVpSL5beE5D3FEO?=
 =?iso-8859-1?Q?bfqZQsS5p1knaHcPD+ZLVYwTWqv5li+rWIGLOKPDC5xAa6Gt+7EDeBDQzE?=
 =?iso-8859-1?Q?YyH1Bh3dfi30HSN/+EVQnUR8ithX+viUbxZLEGSgAHECZZSRZokgJJcjlN?=
 =?iso-8859-1?Q?VFoft3TN/ar+UchTumzNxoo3H4zoacnilcu401gAUjaF/WkYAcG1RJV8zW?=
 =?iso-8859-1?Q?a+KtYPWGVCHwVudS617+WyE5moXD8wonw7lyqKpHAZHUb2aTriYSqK+WWM?=
 =?iso-8859-1?Q?6iXhPZBj4HVesquc4yJb6GkGoSDfvQ6fEkNt0lf3zL9Vwp1UgkkBlaCVVW?=
 =?iso-8859-1?Q?xf5kM5R6ZGJJkgM8rzO87mp8NM538F5tOPlY8lzhOWQA6V5i2zuIjno80S?=
 =?iso-8859-1?Q?jlpu0KtiX4Fbs6eqYAG1CTeP5RE5h5SJWDurHHYyZqCEVXuSnErgvJ7s6z?=
 =?iso-8859-1?Q?vMMuZrWploiheYIPK9YKfi0x4WAUjbQ05deN4XQjkyojhs/X5Bzg4jprKl?=
 =?iso-8859-1?Q?HQF2IxUBlEvMo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea01301-2ef9-4b8b-4609-08dbc9757057
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 09:44:03.6151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ub5hjteaGNDfXqfpfSEYs39dZNz/6O9w1YMs/JTCn+/Mi32uI6BMJAWqpsh7xhOT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5120
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Xu, Feifei would like to recall the message, "[PATCH] drm/amdgpu:Check gfx =
poweron when skip flush_gpu_tlb".=
