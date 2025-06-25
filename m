Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C08EC77B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 02:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 537CC10E078;
	Wed, 25 Jun 2025 02:14:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tm4Bd8y9";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54EC810E078
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 02:14:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xezncKLvq3iaHn+U+JsSoj3I4hmlgnSykXEuBYTNgOPip+h50lNefMieHTbpJSCfMwulOEaWqzAHdOwIjAufv6ukp6arwUYUi3J9hxS1+ITGLwPel8FDeL8L1D+QpaHOS3zoclBmx+ZilTr79OQyw/DLcL2nNcIf6PrSTCQ0J/oYECDZjBe21idfMWpcAXVY1QkY7BXgXxS+ESEVGux/c6cBihdXfHzfHBMAu1sIjBbo3V/4n4b8mfcfIORVU25HCij8yEqs/xAVq0RO1vffT+qMZ74ROLzLDWRNQMJW81m1zPrJIyDZyrW5IaqEyPXUGwRPSORHek7Wkjurn2n/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmaEXUzmVzWPWEfaWuHxMrkZ5YCuyrbH09kU4CPATqE=;
 b=qtTLi7+YRaLZ2T8hXFMEVcL/yTeSYmjHclTT/Zkhbn3rIn+OH4E1RrQ7eWGDslqzLkAoiEqLWbw7ZzJnsrXYjxlmfHLx56HC9/TsUrHc/3e77y1yIEUQB4y2XKfkZkVN2ok1cfD7YEYlCnwSmHvPOQXljPkNB6iJC4sflr4D5I2kwVHA26zFVzVYS+XOjICT2CIiQfanXgsBze1PZfvPmFA1mdqeiTUO7U/jm8bby5/+gZJOPJ8K+ZkU950vHFl1PG43wlFIMige/iJaaPbZRTl/vneq4uw4PhiwIon9cljlBw8QgaOXMWQ9B8nVhuWSgOJZbKEWovYuVURPbRWAag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmaEXUzmVzWPWEfaWuHxMrkZ5YCuyrbH09kU4CPATqE=;
 b=Tm4Bd8y9cnPAnvAL/hGRjnDZhpwO65pcMmXx5hj+fhIU/jlLOi9OhAh6Q4ZBvq3RC3RdF0AGyDfztaYZ89SZ7CSTOvhimKGyEjCrxOQzsFtydIireaoJIJ1EhRSpLK8m6Rr2NDcFPaQD/sKj8c7BAfC8eKg5OPa143NguPXowDw=
Received: from PH0PR12MB5497.namprd12.prod.outlook.com (2603:10b6:510:eb::22)
 by PH7PR12MB8121.namprd12.prod.outlook.com (2603:10b6:510:2b5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 02:14:12 +0000
Received: from PH0PR12MB5497.namprd12.prod.outlook.com
 ([fe80::662f:f49f:2ba1:ca55]) by PH0PR12MB5497.namprd12.prod.outlook.com
 ([fe80::662f:f49f:2ba1:ca55%5]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 02:14:12 +0000
From: "cao, lin" <lin.cao@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chang, HaiJun" <HaiJun.Chang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: put ctx's ref count in
 amdgpu_ctx_mgr_entity_fini()
Thread-Topic: [PATCH] drm/amdgpu: put ctx's ref count in
 amdgpu_ctx_mgr_entity_fini()
Thread-Index: AQHb5Oj0drxJuIkp3E6Gzq913V0TK7QSEASAgAA5OgCAANoYXA==
Date: Wed, 25 Jun 2025 02:14:12 +0000
Message-ID: <PH0PR12MB54971F5A5D9BC332B1BDB9DEF57BA@PH0PR12MB5497.namprd12.prod.outlook.com>
References: <20250624091823.3963949-1-lincao12@amd.com>
 <b7fc658e-2778-48dd-8584-3f33bbcc5ab7@ursulin.net>
 <a88d5329-d500-490c-a054-7ed584322e1d@amd.com>
In-Reply-To: <a88d5329-d500-490c-a054-7ed584322e1d@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-25T02:14:12.1780000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5497:EE_|PH7PR12MB8121:EE_
x-ms-office365-filtering-correlation-id: 9f03a7dc-8236-42eb-3fde-08ddb38dfa53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|8096899003|38070700018|13003099007;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?lLSwG2dg1E26MQVW4YXguCT9n3ypzNuKFPRPrr5mkuVogcSnbUkhuTbguN?=
 =?iso-8859-1?Q?q98o3fIUkXN0rAhg5A+8pGPY5MGlKr8Yz+2fs7fMskc+++elE8t1iH4MfX?=
 =?iso-8859-1?Q?1/0aPxD1+6jFIyDTrgx32YKSR9KKTG5Z/H1Yxd/6SopECd/kxZ8emn+nkN?=
 =?iso-8859-1?Q?X8L2Ftohfygu3Wi4v9+pwD9NmX6u26uaSfEXFXSEx5afFTPZsgJS0ieJ67?=
 =?iso-8859-1?Q?8Hffaqrl6hZaHWbJk9cGC6lNg1pbEcmBJmbcs8r24gJaZMS3ihw1chv/Et?=
 =?iso-8859-1?Q?fDmJrAsxeiwNvvhsy02DXcxwy98Ol4Oog2kyYtiIKWUxFlrnt8voENXRuc?=
 =?iso-8859-1?Q?xyMouOInV6oAgytUvFY1o10Nzg2SUrdeJiNJv2qbHXmWDBnGMpESnI5mRE?=
 =?iso-8859-1?Q?oHBLN5EJp5hGGiq/TiRaxa8sKkRKPsspngAI7piDyotmChyHnO//oY1gGg?=
 =?iso-8859-1?Q?r14FXp71R1h3VWIwzZK8Fb0s3/zvAXk8VAzzyC61z4Ws6/t2ZWAIJWzn1Q?=
 =?iso-8859-1?Q?FLORagl0axs3H0VICU5yJ+iX4z4aj+yy1GeLfL5YZ00MLLrhUiWoRAr5DE?=
 =?iso-8859-1?Q?4+TWZmE8Fv5YUtT6PbxWEOVkjQTadjYLHPAc1Q9Qz1vW3xIJpkjMYLHuxw?=
 =?iso-8859-1?Q?yI/RH8iRLeS2fcHQuDLJy5HIg1IilKiAghQ0WxAyOE7y9VHELXixDFgb3i?=
 =?iso-8859-1?Q?W4oMteff/R4sXkNxfPhBZbx84+XQ7ewOgS5R+Orss9zTmKZZ9bOyCy9eko?=
 =?iso-8859-1?Q?jIdwzga/QYbb2uIsXOqz2ND7cj/vWY8Q0qFUHdNR85k6OXTOqlXbPeieyP?=
 =?iso-8859-1?Q?UovhfqtSpEv3bGimO2xEquUPEGAZWzezrtfOVdaKsyWMffe+mguqTJBQwh?=
 =?iso-8859-1?Q?Rhq1hJMp+/hr+O48zipcgL/LueIYJGXXozWYSQ3b96kILuqBcTJLp28mNd?=
 =?iso-8859-1?Q?yWSPpRtVWmvwcbr1sFMn4PRa2EZIG/O4Z+vEz4shmI+HTSP0zOMR/It33O?=
 =?iso-8859-1?Q?NWEQ1BYnqfPSz48MM1hUNYDGYwGMUQ/rDeB3308jnafctQqOSayVC22o/D?=
 =?iso-8859-1?Q?KNBZv76UhhSMndVmFiEPLPMRaglVAzkGg6Dldm4lbMUslVHcJ2U1quxtpW?=
 =?iso-8859-1?Q?pScBMhtnXfjjf3llEmnd9ysz4WNbU9onBc6Nx81UEiBEoNL6RFQ4HlRYIA?=
 =?iso-8859-1?Q?rTEl42FYbjuLy4Genr8Qxz0px8OJsywyZ2DWuiXTj//6hqPBex2qEBm7P0?=
 =?iso-8859-1?Q?TVg0Di6UNffxh5C2G9aSHDbeHi8ivABmWKjb9toq03ADgYGQctK0Dcbj2C?=
 =?iso-8859-1?Q?A0L8qGr0k6eBYpcS9FY1Z8GhZNOTXhKXcQ/dkWOnI5rWH6XVe5wAkSrTlL?=
 =?iso-8859-1?Q?S31CebH7qFSAWsL8UBgul1brv4duaiSQmCZZY8tohxqAoAI0E5ENT2BYGz?=
 =?iso-8859-1?Q?NROTMuAbCRGISImwLr7sGXUuGCeOUlg5lexY4KPurq7GD+wDxasQciVPPT?=
 =?iso-8859-1?Q?dOOFanGsVMADhsGd/LvRv6/L7TNXd5k1wkBU/0etm4FiMF0SQn9iZ8Zd7k?=
 =?iso-8859-1?Q?n+z5Ej4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5497.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(8096899003)(38070700018)(13003099007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7eV/FThgdMYm6kLjPCUpu4D4X3fMUqY6OZNQZbIq2ZGZtt/lSA2GSutCHy?=
 =?iso-8859-1?Q?sv5VmiSckN2bdOczTs5iWUeuO1nCxyWiz155cEVXfp7VfyMd/0FIWOnAou?=
 =?iso-8859-1?Q?fFCeiPUi4jcv6AlWWXAchOWIXpsn+ZDcjhJaRfD3y1RFJ3naeI3LPqotc1?=
 =?iso-8859-1?Q?tScO+NWCjJnHXaOJM3ojN+WyqR9T2LlMs2TWjrAXHFA5iTcAPA+iK/P4oj?=
 =?iso-8859-1?Q?B3dZbWA55mG1JWVN77dfG9I/ZS44xqlCFzgn+Ub/V4Z5O0ad4OhxYofxqx?=
 =?iso-8859-1?Q?huCIX4rtXWktsn3OV4q94MSyTlmrQvKHbxjm4pCbTxH8ovnMKSllRF6FI1?=
 =?iso-8859-1?Q?BkYdjRknoF6Sbje41x65wNeqvyV/xiS+kLYJ5xLCaCxiTzDw7G+Wyw1ScP?=
 =?iso-8859-1?Q?ULM2HInSzbH9X1CZn6rSebPbIUDYYkOMlH4AmvBeArdh77glPjpFDQHgxq?=
 =?iso-8859-1?Q?t8K2ulHdk8bng3dbMXdRsER+qCzF0/cT0ao7bDJIHLpfD7d2pJdvOEPAQ4?=
 =?iso-8859-1?Q?AQZ4pT+CI/TCOpnEGzsiRJoV2uKmYTqKz1olRMvPJMWYaSpcg64is/FP/E?=
 =?iso-8859-1?Q?S+buqZdZ3IodEhtVAUzr4P2dHA0ovrVUHzLLlU4Mn1S0HcSN6mqXoHQuJ3?=
 =?iso-8859-1?Q?YhFL/QxMcfRq/PCXMXe26oKsIT39C6JiiSrE/eHdM2WPetta8Ef5Xm50E6?=
 =?iso-8859-1?Q?9ci5pC3GDnPs2ObomGpfzPYAiZCWC15yqQM8RcxJr/ZCcjWGeyMnkFfGxg?=
 =?iso-8859-1?Q?D61eFFcaA2w1pwBJqumvVvVa3a1lVyuOV1Sk2yj3U05GgaW4vZwZRsXxqF?=
 =?iso-8859-1?Q?xBxnoI2emj/VTUCGjQxDiGtSpf9xAP3J4ANBBFQajPV+u1JDa/me0ym/0n?=
 =?iso-8859-1?Q?G/B2Nbn7cur51MCOP4WuZPtqJQUnQRzI4/qf7BzIq8nLgpmyUdDB5UEZAv?=
 =?iso-8859-1?Q?GiCDPcXgzLDIO3c88POgkTc5qFyntqava1ACqd/gjqGzm/uoNbvELUtutj?=
 =?iso-8859-1?Q?9jn6jXLvnsK9kJ+IOiQPpsJLgMxzoprI8PZKu4kfnKt7mSxSFFUCwLShSq?=
 =?iso-8859-1?Q?BaoKpEYsKBXPYPEWrZMVvtTJ/9A4lZJTJUB3yJf0xrwqzABd5U4wu+66cm?=
 =?iso-8859-1?Q?wwyY8UoOA8s92b9M0wzqFN3OfJt7ruPYFiaJ4k6Q/E1tjU1h5H2V8Cdtro?=
 =?iso-8859-1?Q?Ms/mQKwXozorTBZs7bMeLOI4aru9XemmEuACbbLyXhRz2nwxT4i07mYiHf?=
 =?iso-8859-1?Q?Cw10f5e3ZKt7ZfbIlde5caqoRO4SHAuEA4NYLl8QappTvOteHA1up9n8aw?=
 =?iso-8859-1?Q?kRwHRoRQ59byremhMzHuHb7dz01kMHwK4LoKr8y48E4gFI9MvtvAFeDfEG?=
 =?iso-8859-1?Q?FYmxP57OtR8nDh5qrrLTPkES/LLjvoSpIRa7io/F/fyBLVygyJ1O2mnSSb?=
 =?iso-8859-1?Q?0BCk/3/iK9/pp3nyGR8liQJxONyBqQg1D/ha4mwyZPoDREECtF90oVxtNw?=
 =?iso-8859-1?Q?TB30c1fong87zQKfcOX2Bakv8QB1xrVx9amsNrfQmzUyYRit8dLDUyYcpc?=
 =?iso-8859-1?Q?GBCxWck3Cd6kQDO9OGF1qJE2cR2tPfeuTY2e6Nc+5V9TGXFS8j4FHYcYQE?=
 =?iso-8859-1?Q?IUOrzhPw0oruY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH0PR12MB54971F5A5D9BC332B1BDB9DEF57BAPH0PR12MB5497namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5497.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f03a7dc-8236-42eb-3fde-08ddb38dfa53
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 02:14:12.7476 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q3/Wx1+5yIW2CSpO3cPbZ7I/4zN0wK5SY7/xNtdrEPoL3MVZx2LmrGKsHV6vqwPjkPQ9pFbsPcX+EhIM1s5Otw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8121
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

--_000_PH0PR12MB54971F5A5D9BC332B1BDB9DEF57BAPH0PR12MB5497namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Ursulin, Christian,

I find the upstream patch: https://git.kernel.org/pub/scm/linux/kernel/git/=
torvalds/linux.git/commit/?id=3Ddd64956685fa48358c4152d952070c8c073e5f89

May I ask if I can modify the commit msg as:

drm/amdgpu: Fix memory leak in amdgpu_ctx_mgr_entity_fini

patch "dd64956685fa drm/amdgpu: Remove duplicated "context still
alive" check" removed ctx put, which will cause amdgpu_ctx_fini()
cannot be called and then cause some finished fence that added by
amdgpu_ctx_add_fence() cannot be released and cause memleak.

Fixes: dd64956685fa ("drm/amdgpu: Remove duplicated "context still alive" c=
heck")

Signed-off-by: Lin.Cao <lincao12@amd.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Acked-by: Christian K=F6nig <christian.koenig@amd.com>

Thanks,
Lin
________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Tuesday, June 24, 2025 21:11
To: Tvrtko Ursulin <tursulin@ursulin.net>; cao, lin <lin.cao@amd.com>; amd-=
gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Chang, HaiJun <HaiJun.Chang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: put ctx's ref count in amdgpu_ctx_mgr_enti=
ty_fini()

On 24.06.25 11:46, Tvrtko Ursulin wrote:
>
> On 24/06/2025 10:18, Lin.Cao wrote:
>> patch "daf823f1d0cd drm/amdgpu: Remove duplicated "context still
>> alive" check" removed ctx put, which will cause amdgpu_ctx_fini()
>> cannot be called and then cause some finished fence that added by
>> amdgpu_ctx_add_fence() cannot be released and cause memleak.
>
> Ouch I removed the wrong one. :( Probably misread kref_put as kref_read..
>
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Acked-by: Christian K=F6nig <christian.koenig@amd.com>

>
> But is the SHA correct? I see it is dd64956685fa.

That could be because our internal branch is not yet rebased.

>
> Which would mean adding:
>
> Fixes: dd64956685fa ("drm/amdgpu: Remove duplicated "context still alive"=
 check")

And maybe CC stable? Or in which release is that patch upstream?

Regards,
Christian.

>
> Regards,
>
> Tvrtko
>
>> Signed-off-by: Lin.Cao <lincao12@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ctx.c
>> index 85567d0d9545..f5d5c45ddc0d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> @@ -944,6 +944,7 @@ static void amdgpu_ctx_mgr_entity_fini(struct amdgpu=
_ctx_mgr *mgr)
>>                   drm_sched_entity_fini(entity);
>>               }
>>           }
>> +        kref_put(&ctx->refcount, amdgpu_ctx_fini);
>>       }
>>   }
>>
>


--_000_PH0PR12MB54971F5A5D9BC332B1BDB9DEF57BAPH0PR12MB5497namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hi Ursulin, Christian,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
I find the upstream patch: <a href=3D"https://git.kernel.org/pub/scm/linux/=
kernel/git/torvalds/linux.git/commit/?id=3Ddd64956685fa48358c4152d952070c8c=
073e5f89" id=3D"LPlnk654005">
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Ddd64956685fa48358c4152d952070c8c073e5f89</a></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
May I ask if I can modify&nbsp;the commit msg as:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"margin-left: 40px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
drm/amdgpu: Fix memory leak in amdgpu_ctx_mgr_entity_fini</div>
<div class=3D"elementToProof" style=3D"margin-left: 40px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"margin-left: 40px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
patch &quot;dd64956685fa drm/amdgpu: Remove duplicated &quot;context still<=
/div>
<div class=3D"elementToProof" style=3D"margin-left: 40px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
alive&quot; check&quot; removed ctx put, which will cause amdgpu_ctx_fini()=
</div>
<div class=3D"elementToProof" style=3D"margin-left: 40px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
cannot be called and then cause some finished fence that added by</div>
<div class=3D"elementToProof" style=3D"margin-left: 40px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
amdgpu_ctx_add_fence() cannot be released and cause memleak.</div>
<div class=3D"elementToProof" style=3D"margin-left: 40px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"margin-left: 40px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
Fixes: dd64956685fa (&quot;drm/amdgpu: Remove duplicated &quot;context stil=
l alive&quot; check&quot;)</div>
<div class=3D"elementToProof" style=3D"margin-left: 40px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div class=3D"elementToProof" style=3D"margin-left: 40px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
Signed-off-by: Lin.Cao &lt;lincao12@amd.com&gt;</div>
<div class=3D"elementToProof" style=3D"margin-left: 40px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
Reviewed-by: Tvrtko Ursulin &lt;tvrtko.ursulin@igalia.com&gt;</div>
<div class=3D"elementToProof" style=3D"margin-left: 40px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
Acked-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Lin</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Tuesday, June 24, 2025 21:11<br>
<b>To:</b> Tvrtko Ursulin &lt;tursulin@ursulin.net&gt;; cao, lin &lt;lin.ca=
o@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.=
org&gt;<br>
<b>Cc:</b> Chang, HaiJun &lt;HaiJun.Chang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: put ctx's ref count in amdgpu_ctx_m=
gr_entity_fini()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 24.06.25 11:46, Tvrtko Ursulin wrote:<br>
&gt; <br>
&gt; On 24/06/2025 10:18, Lin.Cao wrote:<br>
&gt;&gt; patch &quot;daf823f1d0cd drm/amdgpu: Remove duplicated &quot;conte=
xt still<br>
&gt;&gt; alive&quot; check&quot; removed ctx put, which will cause amdgpu_c=
tx_fini()<br>
&gt;&gt; cannot be called and then cause some finished fence that added by<=
br>
&gt;&gt; amdgpu_ctx_add_fence() cannot be released and cause memleak.<br>
&gt; <br>
&gt; Ouch I removed the wrong one. :( Probably misread kref_put as kref_rea=
d..<br>
&gt; <br>
&gt; Reviewed-by: Tvrtko Ursulin &lt;tvrtko.ursulin@igalia.com&gt;<br>
<br>
Acked-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
<br>
&gt; <br>
&gt; But is the SHA correct? I see it is dd64956685fa.<br>
<br>
That could be because our internal branch is not yet rebased.<br>
<br>
&gt; <br>
&gt; Which would mean adding:<br>
&gt; <br>
&gt; Fixes: dd64956685fa (&quot;drm/amdgpu: Remove duplicated &quot;context=
 still alive&quot; check&quot;)<br>
<br>
And maybe CC stable? Or in which release is that patch upstream?<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt; <br>
&gt; Regards,<br>
&gt; <br>
&gt; Tvrtko<br>
&gt; <br>
&gt;&gt; Signed-off-by: Lin.Cao &lt;lincao12@amd.com&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 1 +<br>
&gt;&gt; &nbsp; 1 file changed, 1 insertion(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_ctx.c<br>
&gt;&gt; index 85567d0d9545..f5d5c45ddc0d 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
&gt;&gt; @@ -944,6 +944,7 @@ static void amdgpu_ctx_mgr_entity_fini(struct =
amdgpu_ctx_mgr *mgr)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_entity_fini(entity);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kref_put(&amp;ctx-&gt;=
refcount, amdgpu_ctx_fini);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; &nbsp; <br>
&gt; <br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_PH0PR12MB54971F5A5D9BC332B1BDB9DEF57BAPH0PR12MB5497namp_--
