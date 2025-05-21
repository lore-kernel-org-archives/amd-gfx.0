Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B8AC2D0CD
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 07:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3849E10E69C;
	Wed, 21 May 2025 07:33:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IExSCyFc";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA3AA10E69C
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 07:33:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQlRf8lxnFJiOLPxTElBW7uC8RVz3oieclSFy4SlOJ97Em0QIgqbwrhJOl2LFUCN9sCND12Eenu1zNzk9Wpr17YDnVA4+K6HdB95q1oiN1/6VAnzbx/2a8bASlWhz1aLh6nXo2zb2/2o4fOTCktV4S+MYQPFbcAevAQlCUOgBHafwMvVUbd/4u2B7xsCLtV/QouOzu1b5wkGejMjOGL/yAJYXWE9teqsvaVhtdOEnBBC4yzED7pfGo37+63wIQNWde85lPI+BPuMhegnIh3p9LsfBpGI+PO/qQAEUSoZgotnJBJB9Nw5uYqeY21jGfNJPOFcresmbK2YPLkgWVFfGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7Q20fa5+Sdls8Deflm8kGWBlH6sUbaFFOtbkWyCFZs=;
 b=EaADnVh2CvEk0TIbi5I33AzABWh7evfK8ccrXDe6J66AfiXFmyxZkEPGI4sQy0uWF92lp7FDZ0VcHw8MS91a57DVoVjqUxZRzOQqw4TCtC4yBFVIj33/Ckkmv6yI7zp8NeV8yKQceRNszEqJFANucH2Wr8jvKuCv2cRQQ2PSOOmNG/pbySlx/INZ0wV1pPCxDkp6ozz1l4aByvwKRcd0I0Pr17YFHISnQ/rvZUaynPUb3gFA/7eAuBIUI/rHz3963JaZM5dBwykalV96PEFXvxO7OdnjD1kigHssvuXPFzU6hyEe3Ue74r4UxyKgIYm7Y96dAyK2dj+k+j/pwkiHCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7Q20fa5+Sdls8Deflm8kGWBlH6sUbaFFOtbkWyCFZs=;
 b=IExSCyFc2lSjU/805vCmb9vFtE52KFvPr5pNJHfYm9ae1HDIkzOK/JSoIXbwAFA88RU/A33CsGFQF4IyRW7fHBTJKvYQJxeIYf76pBem8AHNYR8b3DwbFzaWZLl/ecULuwW2mymsBQsff/xWrMFTGKg5FRWtdRZVqy7IRfmEch0=
Received: from IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10)
 by SA1PR12MB9492.namprd12.prod.outlook.com (2603:10b6:806:459::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 07:33:41 +0000
Received: from IA1PR12MB8405.namprd12.prod.outlook.com
 ([fe80::2b09:e2:1ee1:5fea]) by IA1PR12MB8405.namprd12.prod.outlook.com
 ([fe80::2b09:e2:1ee1:5fea%7]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 07:33:41 +0000
From: "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>
To: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Ma, Qing (Mark)" <Qing.Ma@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Deng, Emily" <Emily.Deng@amd.com>
Subject: RE: [PATCH v6 3/4] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Thread-Topic: [PATCH v6 3/4] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Thread-Index: AQHbyJcsayPw/qQo8E28GYMn4KCcl7PZ+q8AgAD/OACAAboTUA==
Date: Wed, 21 May 2025 07:33:40 +0000
Message-ID: <IA1PR12MB84057CB20B1F14652093BF38A89EA@IA1PR12MB8405.namprd12.prod.outlook.com>
References: <20250519082038.21459-1-guoqing.zhang@amd.com>
 <20250519082038.21459-4-guoqing.zhang@amd.com>
 <e75c26e4-8011-4e49-9e2d-d354dcf7358b@amd.com>
 <4f3c7a86-c89a-429d-8ec1-5db7a0d12c6c@amd.com>
In-Reply-To: <4f3c7a86-c89a-429d-8ec1-5db7a0d12c6c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Christian.Koenig@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=56c6e62d-cf5f-4422-be02-d2933819fa17;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-21T07:33:00Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB8405:EE_|SA1PR12MB9492:EE_
x-ms-office365-filtering-correlation-id: 70f9479b-c022-421b-6431-08dd9839cf05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?P7cXu6Hg+p9J5wvPN5oNs/+D0Y6WqyCq4IRk4xeqhJ4WnMJ2CiplZ7ksc8?=
 =?iso-8859-1?Q?kQHiKSqVF/CVcSj+khs8qVK65CsvSxdb+zoosYfcKzt94agrnko1wxkiMz?=
 =?iso-8859-1?Q?5Riq8U81CfBAxEyQC4s6GcfLUhzjSfS6mM5dymuM+VbV9LOZWU7zBz6U4d?=
 =?iso-8859-1?Q?DgRRptlcUNyGHatJYIJn9cJOqoSHSdAd+06VnLR41KhxE6GMjYQuS4pw8J?=
 =?iso-8859-1?Q?l0Fx3xLy1oYXAhTEhivIyPalM6imkVGA8DbdX8GEYXgtagB74xJqWfuCh6?=
 =?iso-8859-1?Q?dpYtI3Wgrd16m5EDUdsVF0OnaL9xqSKiSHr/zbwSlA0KDUbRCqqdh6IKf3?=
 =?iso-8859-1?Q?FORtMIFWFwAMfKlGTUQ43MsA4eBFJme5OGW7wu+NLpgjsstYaX5gR9RkKX?=
 =?iso-8859-1?Q?btayiPdf50I4P7Xm1+ffy9sD3hQQIL7kFWw/jgItr1lhigUEM0i6V/qnln?=
 =?iso-8859-1?Q?arF9Q9WFrgW3BJw2MHXObcTBJStiSuyDBREenqTWBzDepkneX5F6AISw3d?=
 =?iso-8859-1?Q?3dJqj/5yVcIHYvDuC9tB+oDgrF1VPSKBdoXcj76ZyyHqYIEwQUZ1Jou4J+?=
 =?iso-8859-1?Q?hqGFPnAzVHVFu1MhI9NpidVMQMTUBwwXrSuX7OQ02I2nTMraFTf22bRBai?=
 =?iso-8859-1?Q?dJW1P7AEE6Ga5aEg5eu81AjaaN1TFkmTpTQrUltUMHxr2C7H/FDfkbtpgu?=
 =?iso-8859-1?Q?ajmU7M7DkMWuZFkQTOGeeAaF49WP9jfXJW4GzxBe4UJuHQYdTYyNl1JYdG?=
 =?iso-8859-1?Q?oUWwG0yTfnaLAcNPP16B/b0ol8wp1HgZzeOiHHZ0sAGtk1tSjdr8imURub?=
 =?iso-8859-1?Q?/3AAhNbWYvDJ3ePDdUHanYh2zsGZwravkOzIWaR/3XszsTTJbTV3xsOeDg?=
 =?iso-8859-1?Q?uhbWNW0kGsqU9veIh24D8HJlP3GyqTmWMDZhFVMCbYhfZMNKcUm2jYfrHn?=
 =?iso-8859-1?Q?GDOxmZnGeXCZ7JQnQFLoUz8lIB2e1LRJ0pbB/589oaHQrmVH5U+LEmPU3H?=
 =?iso-8859-1?Q?3gpOk6lNKTCpBa8D638pKbme1BqINVwLXqRSc/mL4DAAHBnpW8guwxZgIs?=
 =?iso-8859-1?Q?ZntWuAQ9YFWeJ0tM6yiPqOW4tE91lUaZsZkLpy5S/HUhkDGk5UpDwvgPPZ?=
 =?iso-8859-1?Q?R6/whLPbVhHGoKM80IZmn0qziWyqvam2K8iRqSDsjt5mhxqoVPlhv4N0Fg?=
 =?iso-8859-1?Q?4Q0QKlvjleyluWbCKUYqkYOqNWIa653QzR+9Qd6+zgY0mCkmFBaiOy/gwN?=
 =?iso-8859-1?Q?i7eQQ2h2FMK1B5J1oRnlWUKaN1GJM51kGntgUHzVDV/1ky2NaTBct4sUHS?=
 =?iso-8859-1?Q?vIH+gpB3mmZYFS81hFdJDV3Nctwh4ZQkPd/vVJzF29owi9ne4cIur6096K?=
 =?iso-8859-1?Q?8LSLD8oVlmMlDh39ScF36xIEVdHuL5syxB6hmuB87zCrvMu+0PTC7VFBnH?=
 =?iso-8859-1?Q?Krm+dGoudz40HfcA5qG8mSuLIF5NIM5w0F2eUlFMWfS79ROn8sHWhDyVKi?=
 =?iso-8859-1?Q?VUz5ZkP7vbg1f8T63QzVjk448Ji85HRc80qgSUveToHyd28oBBwhKnT4/X?=
 =?iso-8859-1?Q?KtVD3mQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8405.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MnR3u/eVbTaIjJQi5c9wPaixu6xkJS+FXXMUDPc/LPmRB++7FVURaL6AOj?=
 =?iso-8859-1?Q?Yj8X65dW8XPL7SDmRrK2/cgZWS6WtjDVSqx082nqW41uiqMAyl8zaYOemY?=
 =?iso-8859-1?Q?DogpE3ZefHf5Hll2H6Xdw2cEec6zODW4UooZ40U/1P3r7o3TTwmn6kPGuI?=
 =?iso-8859-1?Q?hcSkAbR7sUzFm+n7hGvsWZErTzBygAhvUpt5oBYdIcJIKCCzeikFl0x4S+?=
 =?iso-8859-1?Q?m4//cC4a6ruAhuRCONm0IjcCKAjkq4eUWyP+CC4WQHI1E1Dwrb922vnS4m?=
 =?iso-8859-1?Q?iPUh7w2S1P88yapVTMDHNFznRZmQYW61pLU1FOSfIWDtpvqQNzQvM0ojSg?=
 =?iso-8859-1?Q?bGl3PFkjDaLc7RZX6qVRK0A8z5JBQyHwfqcOYtO9n80ILwMV/qsjMUnl3Q?=
 =?iso-8859-1?Q?bavlvOEntXMqh5hWJF10WNHlSG2Rgj/srC9nzz17Lyq3QgzE1TsiEXAwnm?=
 =?iso-8859-1?Q?N5xJ9k9I0lBB/WVimwdpEI5WzS1hbJPC12yk29DIuWaj1kQGk4R/Rq/ANM?=
 =?iso-8859-1?Q?E6FDTWVC9L8vl8ftC8EiWPH6HFoO7Nbd7I6nDiup2QBGZ/FLJrRFahHlvy?=
 =?iso-8859-1?Q?iIosme0oA3ULiEtTlB/j/ZZWv/Sa4Z5YBGo9W+qFdUlsDh0OgKRDE3xSUI?=
 =?iso-8859-1?Q?e6hkd2uDdHR96EAtBRrf/DOtlxRkaHOOuwkUSw+fhJoQL8j/ng3wEf6+oK?=
 =?iso-8859-1?Q?gQKKzoTQv3TcaD1h0O97+9Qkq//tV5BDS4xhU9QOesJPhiEahWOlawh4K9?=
 =?iso-8859-1?Q?sp5mXkoztgd5F3fkZ+JsDNl2KSbS263xMpfq+LAxBXnCB3VeQw6FJUxTrr?=
 =?iso-8859-1?Q?7U+leZKSWvCJn6ZKkqWiPlFVftRpiNJMEZjbcyCgllYkXdIuaKbIssqhl+?=
 =?iso-8859-1?Q?sr5BWBWo9kh/S32GLqTzYi9RMzGcgWDZKZcPV/iZrguOhC9eKEbrHL1nTT?=
 =?iso-8859-1?Q?CYxwyEn524XVPT3+rk8srkEsKz6mYm3mJKvzqsNQFazFduIMZVEcwx7ErN?=
 =?iso-8859-1?Q?rjXdXrD7BP96I0cDJ03PqSGZrRLEikqOGovsJN5fVJnG0ty6cpbPRMBIeL?=
 =?iso-8859-1?Q?bv7zqD3at9KUyyN0tC5ZsXglnDVFF2+4/PAo4Tt50IP2Dqe6zho2hqNWbZ?=
 =?iso-8859-1?Q?yG1sEUTdq25xGerViTVFhcCCsTee/oDivplmHbpBSz+D1xZhNl5//jJtWU?=
 =?iso-8859-1?Q?00sqkj3Lwseuaqj2xo1bb59BolAflzZjRRqLoe70sr42VtkjPwcNFAbT++?=
 =?iso-8859-1?Q?BoXRVriEm6wbUbQNhksIpGDwfn9sENTXFtUBxa70wldJSeatQ2FLxKFJJ2?=
 =?iso-8859-1?Q?sMnpXc144H8ZiHbN8pFUx5MIQ+6KpHqrNylwMrqONXEuDAYrqxLzTLgd0+?=
 =?iso-8859-1?Q?iES5Zpzx7wSmvLUTCv1qFthp559KMVqWQy7X+VCmHCEkqHj+ZJxtnlmrTk?=
 =?iso-8859-1?Q?Vb2Qrzjv/+vogLw8rslkq/nKi44FTD86ffUHQhK16VQxF2mnGXhl+IUh7+?=
 =?iso-8859-1?Q?BhsiEbk37rmoVV4AMgMUq0gu0aXVOEw8me81Ji2gIw3Bcltx9Gg/uCKfQx?=
 =?iso-8859-1?Q?c2H38s3h3aCJQhmyjk4yEq0qI1HWhx5/ugVkmhS92boGU76uor6NjMcjLP?=
 =?iso-8859-1?Q?BntBl+BHlHotQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_IA1PR12MB84057CB20B1F14652093BF38A89EAIA1PR12MB8405namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f9479b-c022-421b-6431-08dd9839cf05
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 07:33:40.9949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c7ywN3bg7UXCuIJRgb+G20wDXJB5MOwyfk4ka8xfdoTYzfm9boXEhrX546djo2w/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9492
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

--_000_IA1PR12MB84057CB20B1F14652093BF38A89EAIA1PR12MB8405namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Ping... @Koenig, Christian<mailto:Christian.Koenig@amd.com> kindly pls revi=
ew and feedback... thanks you very much!


Rgds/Owen

From: Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com>
Sent: Tuesday, May 20, 2025 1:11 PM
To: Koenig, Christian <Christian.Koenig@amd.com>; Zhang, GuoQing (Sam) <Guo=
Qing.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhao, Victor <Victor.Zhao@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com=
>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Owen(SRDC) <Owen.=
Zhang2@amd.com>; Ma, Qing (Mark) <Qing.Ma@amd.com>; Lazar, Lijo <Lijo.Lazar=
@amd.com>; Deng, Emily <Emily.Deng@amd.com>
Subject: Re: [PATCH v6 3/4] drm/amdgpu: enable pdb0 for hibernation on SRIO=
V


On 2025/5/19 21:57, Christian K=F6nig wrote:
> On 5/19/25 10:20, Samuel Zhang wrote:
>> When switching to new GPU index after hibernation and then resume,
>> VRAM offset of each VRAM BO will be changed, and the cached gpu
>> addresses needed to updated.
>>
>> This is to enable pdb0 and switch to use pdb0-based virtual gpu
>> address by default in amdgpu_bo_create_reserved(). since the virtual
>> addresses do not change, this can avoid the need to update all
>> cached gpu addresses all over the codebase.
>>
>> Signed-off-by: Emily Deng <Emily.Deng@amd.com<mailto:Emily.Deng@amd.com>=
>
>> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com<mailto:guoqing.zhang@=
amd.com>>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 32 ++++++++++++++++++------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
>>   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 10 +++++---
>>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  |  6 +++--
>>   5 files changed, 37 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_gmc.c
>> index d1fa5e8e3937..265d6c777af5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> @@ -38,6 +38,8 @@
>>   #include <drm/drm_drv.h>
>>   #include <drm/ttm/ttm_tt.h>
>>
>> +static const u64 four_gb =3D 0x100000000ULL;
>> +
>>   /**
>>    * amdgpu_gmc_pdb0_alloc - allocate vram for pdb0
>>    *
>> @@ -249,15 +251,24 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_devic=
e *adev, struct amdgpu_gmc *mc
>>   {
>>       u64 hive_vram_start =3D 0;
>>       u64 hive_vram_end =3D mc->xgmi.node_segment_size * mc->xgmi.num_ph=
ysical_nodes - 1;
>> -    mc->vram_start =3D mc->xgmi.node_segment_size * mc->xgmi.physical_n=
ode_id;
>> -    mc->vram_end =3D mc->vram_start + mc->xgmi.node_segment_size - 1;
>> -    mc->gart_start =3D hive_vram_end + 1;
>> +
>> +    if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
>> +            /* set mc->vram_start to 0 to switch the returned GPU addre=
ss of
>> +             * amdgpu_bo_create_reserved() from FB aperture to GART ape=
rture.
>> +             */
>> +            amdgpu_gmc_vram_location(adev, mc, 0);
> This function does a lot more than just setting mc->vram_start and mc->vr=
am_end.
>
> You should probably just update the two setting and not call amdgpu_gmc_v=
ram_location() at all.

I tried only setting mc->vram_start and mc->vram_end. But KMD load will
fail with following error logs.

[  329.314346] amdgpu 0000:09:00.0: amdgpu: VRAM: 196288M
0x0000000000000000 - 0x0000002FEBFFFFFF (196288M used)
[  329.314348] amdgpu 0000:09:00.0: amdgpu: GART: 512M
0x0000018000000000 - 0x000001801FFFFFFF
[  329.314385] [drm] Detected VRAM RAM=3D196288M, BAR=3D262144M
[  329.314386] [drm] RAM width 8192bits HBM
[  329.314546] amdgpu 0000:09:00.0: amdgpu: (-22) failed to allocate
kernel bo
[  329.315013] [drm:amdgpu_device_init [amdgpu]] *ERROR* sw_init of IP
block <gmc_v9_0> failed -22
[  329.315846] amdgpu 0000:09:00.0: amdgpu: amdgpu_device_ip_init failed


It seems like setting mc->visible_vram_size and mc->visible_vram_size
fields are also needed. In this case call amdgpu_gmc_vram_location() is
better than inline the logic, I think.


>
>> +    } else {
>> +            mc->vram_start =3D mc->xgmi.node_segment_size * mc->xgmi.ph=
ysical_node_id;
>> +            mc->vram_end =3D mc->vram_start + mc->xgmi.node_segment_siz=
e - 1;
>> +            dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%ll=
uM used)\n",
>> +                            mc->mc_vram_size >> 20, mc->vram_start,
>> +                            mc->vram_end, mc->real_vram_size >> 20);
>> +    }
>> +    /* node_segment_size may not 4GB aligned on SRIOV, align up is need=
ed. */
>> +    mc->gart_start =3D ALIGN(hive_vram_end + 1, four_gb);
>>       mc->gart_end =3D mc->gart_start + mc->gart_size - 1;
>>       mc->fb_start =3D hive_vram_start;
>>       mc->fb_end =3D hive_vram_end;
>> -    dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)=
\n",
>> -                    mc->mc_vram_size >> 20, mc->vram_start,
>> -                    mc->vram_end, mc->real_vram_size >> 20);
>>       dev_info(adev->dev, "GART: %lluM 0x%016llX - 0x%016llX\n",
>>                       mc->gart_size >> 20, mc->gart_start, mc->gart_end)=
;
>>   }
>> @@ -276,7 +287,6 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device =
*adev, struct amdgpu_gmc *mc
>>   void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgp=
u_gmc *mc,
>>                             enum amdgpu_gart_placement gart_placement)
>>   {
>> -    const uint64_t four_gb =3D 0x100000000ULL;
>>       u64 size_af, size_bf;
>>       /*To avoid the hole, limit the max mc address to AMDGPU_GMC_HOLE_S=
TART*/
>>       u64 max_mc_address =3D min(adev->gmc.mc_mask, AMDGPU_GMC_HOLE_STAR=
T - 1);
>> @@ -1068,6 +1078,14 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *a=
dev)
>>       flags |=3D AMDGPU_PTE_FRAG((adev->gmc.vmid0_page_table_block_size =
+ 9*1));
>>       flags |=3D AMDGPU_PDE_PTE_FLAG(adev);
>>
>> +    if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
>> +            /* always start from current device so that the GART addres=
s can keep
>> +             * consistent when hibernate-resume with different GPUs.
>> +             */
>> +            vram_addr =3D adev->vm_manager.vram_base_offset;
>> +            vram_end =3D vram_addr + vram_size;
>> +    }
>> +
>>       /* The first n PDE0 entries are used as PTE,
>>        * pointing to vram
>>        */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_gmc.h
>> index bd7fc123b8f9..46fac7ca7dfa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> @@ -307,6 +307,7 @@ struct amdgpu_gmc {
>>       struct amdgpu_bo                *pdb0_bo;
>>       /* CPU kmapped address of pdb0*/
>>       void                            *ptr_pdb0;
>> +    bool pdb0_enabled;
> This isn't needed, just always check (adev->gmc.xgmi.connected_to_cpu || =
amdgpu_virt_xgmi_migrate_enabled(adev)), make a function for that if necess=
ary.

Ok, I will update it in the next patch version.


>
>>
>>       /* MALL size */
>>       u64 mall_size;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/=
amd/amdgpu/gfxhub_v1_2.c
>> index cb25f7f0dfc1..e6165f6d0763 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
>> @@ -180,7 +180,7 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct amd=
gpu_device *adev,
>>               /* In the case squeezing vram into GART aperture, we don't=
 use
>>                * FB aperture and AGP aperture. Disable them.
>>                */
>> -            if (adev->gmc.pdb0_bo) {
>> +            if (adev->gmc.pdb0_bo && !amdgpu_virt_xgmi_migrate_enabled(=
adev)) {
>>                       WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCA=
TION_TOP, 0);
>>                       WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCA=
TION_BASE, 0x00FFFFFF);
>>                       WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_AGP_TOP=
, 0);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v9_0.c
>> index 59385da80185..04fb99c64b37 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -1682,6 +1682,8 @@ static int gmc_v9_0_early_init(struct amdgpu_ip_bl=
ock *ip_block)
>>               adev->gmc.private_aperture_start + (4ULL << 30) - 1;
>>       adev->gmc.noretry_flags =3D AMDGPU_VM_NORETRY_FLAGS_TF;
>>
>> +    adev->gmc.pdb0_enabled =3D adev->gmc.xgmi.connected_to_cpu ||
>> +            amdgpu_virt_xgmi_migrate_enabled(adev);
>>       return 0;
>>   }
>>
>> @@ -1726,7 +1728,7 @@ static void gmc_v9_0_vram_gtt_location(struct amdg=
pu_device *adev,
>>
>>       /* add the xgmi offset of the physical node */
>>       base +=3D adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_se=
gment_size;
>> -    if (adev->gmc.xgmi.connected_to_cpu) {
>> +    if (adev->gmc.pdb0_enabled) {
>>               amdgpu_gmc_sysvm_location(adev, mc);
>>       } else {
>>               amdgpu_gmc_vram_location(adev, mc, base);
>> @@ -1841,7 +1843,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device=
 *adev)
>>               return 0;
>>       }
>>
>> -    if (adev->gmc.xgmi.connected_to_cpu) {
>> +    if (adev->gmc.pdb0_enabled) {
>>               adev->gmc.vmid0_page_table_depth =3D 1;
>>               adev->gmc.vmid0_page_table_block_size =3D 12;
>>       } else {
>> @@ -1867,7 +1869,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device=
 *adev)
>>               if (r)
>>                       return r;
>>
>> -            if (adev->gmc.xgmi.connected_to_cpu)
>> +            if (adev->gmc.pdb0_enabled)
>>                       r =3D amdgpu_gmc_pdb0_alloc(adev);
>>       }
>>
>> @@ -2372,7 +2374,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_devi=
ce *adev)
>>   {
>>       int r;
>>
>> -    if (adev->gmc.xgmi.connected_to_cpu)
>> +    if (adev->gmc.pdb0_enabled)
>>               amdgpu_gmc_init_pdb0(adev);
>>
>>       if (adev->gart.bo =3D=3D NULL) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/a=
md/amdgpu/mmhub_v1_8.c
>> index 84cde1239ee4..18e80aa78aff 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
>> @@ -45,8 +45,10 @@ static u64 mmhub_v1_8_get_fb_location(struct amdgpu_d=
evice *adev)
>>       top &=3D MC_VM_FB_LOCATION_TOP__FB_TOP_MASK;
>>       top <<=3D 24;
>>
>> -    adev->gmc.fb_start =3D base;
>> -    adev->gmc.fb_end =3D top;
>> +    if (!amdgpu_virt_xgmi_migrate_enabled(adev)) {
>> +            adev->gmc.fb_start =3D base;
>> +            adev->gmc.fb_end =3D top;
>> +    }
> We should probably avoid calling this in the first place.
>
> The function gmc_v9_0_vram_gtt_location() should probably be adjusted.

mmhub_v1_8_get_fb_location() is called by the new
amdgpu_bo_fb_aper_addr() as well, not just gmc_v9_0_vram_gtt_location().
mmhub_v1_8_get_fb_location() is supposed to be a query api according to
its name. having such side effect is very surprising.

Another approach is set the right fb_start and fb_end in the new
amdgpu_virt_resume(), like updating vram_base_offset.

Which approach do you prefer? Or any better suggestions? Thank you.


Regards
Sam



>
> Regards,
> Christian.
>
>>
>>       return base;
>>   }

--_000_IA1PR12MB84057CB20B1F14652093BF38A89EAIA1PR12MB8405namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
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
	{font-family:"Microsoft YaHei";
	panose-1:2 11 5 3 2 2 4 2 2 4;}
@font-face
	{font-family:"Microsoft YaHei";}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:blue;}
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
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif;color:blue">Ping&#8230;
<a id=3D"OWAAME01E8261B08740759D04BBF623CC8D2E" href=3D"mailto:Christian.Ko=
enig@amd.com">
<span style=3D"font-family:&quot;Arial&quot;,sans-serif;text-decoration:non=
e">@Koenig, Christian</span></a> kindly pls review and feedback&#8230; than=
ks you very much!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif;color:blue"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"color:blue;mso-ligatures:standardcont=
extual"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif;color:blue;mso-ligatures:standardcontextual">Rgds/Owen<o:p></o:p></span=
></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif;color:blue"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhang, GuoQing (Sam) &lt;GuoQing.Zhang@=
amd.com&gt; <br>
<b>Sent:</b> Tuesday, May 20, 2025 1:11 PM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Zhang, GuoQi=
ng (Sam) &lt;GuoQing.Zhang@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Zhao, Victor &lt;Victor.Zhao@amd.com&gt;; Chang, HaiJun &lt;HaiJ=
un.Chang@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;;=
 Zhang, Owen(SRDC) &lt;Owen.Zhang2@amd.com&gt;; Ma, Qing (Mark) &lt;Qing.Ma=
@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Deng, Emily &lt;Emily=
.Deng@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v6 3/4] drm/amdgpu: enable pdb0 for hibernation =
on SRIOV<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><br>
On 2025/5/19 21:57, Christian K=F6nig wrote:<br>
&gt; On 5/19/25 10:20, Samuel Zhang wrote:<br>
&gt;&gt; When switching to new GPU index after hibernation and then resume,=
<br>
&gt;&gt; VRAM offset of each VRAM BO will be changed, and the cached gpu<br=
>
&gt;&gt; addresses needed to updated.<br>
&gt;&gt;<br>
&gt;&gt; This is to enable pdb0 and switch to use pdb0-based virtual gpu<br=
>
&gt;&gt; address by default in amdgpu_bo_create_reserved(). since the virtu=
al<br>
&gt;&gt; addresses do not change, this can avoid the need to update all<br>
&gt;&gt; cached gpu addresses all over the codebase.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Emily Deng &lt;<a href=3D"mailto:Emily.Deng@amd.com=
">Emily.Deng@amd.com</a>&gt;<br>
&gt;&gt; Signed-off-by: Samuel Zhang &lt;<a href=3D"mailto:guoqing.zhang@am=
d.com">guoqing.zhang@amd.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c&nbsp; | 32 +++=
+++++++++++++++------<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h&nbsp; |&nbsp; =
1 +<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c |&nbsp; 2 +-<=
br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp=
; | 10 +++++---<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c&nbsp; |&nbsp; =
6 +++--<br>
&gt;&gt;&nbsp;&nbsp; 5 files changed, 37 insertions(+), 14 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_gmc.c<br>
&gt;&gt; index d1fa5e8e3937..265d6c777af5 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
&gt;&gt; @@ -38,6 +38,8 @@<br>
&gt;&gt;&nbsp;&nbsp; #include &lt;drm/drm_drv.h&gt;<br>
&gt;&gt;&nbsp;&nbsp; #include &lt;drm/ttm/ttm_tt.h&gt;<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; +static const u64 four_gb =3D 0x100000000ULL;<br>
&gt;&gt; +<br>
&gt;&gt;&nbsp;&nbsp; /**<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; * amdgpu_gmc_pdb0_alloc - allocate vram for pdb0=
<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&gt; @@ -249,15 +251,24 @@ void amdgpu_gmc_sysvm_location(struct amdgpu=
_device *adev, struct amdgpu_gmc *mc<br>
&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 hive_vram_start =3D 0;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 hive_vram_end =3D mc-&gt;x=
gmi.node_segment_size * mc-&gt;xgmi.num_physical_nodes - 1;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; mc-&gt;vram_start =3D mc-&gt;xgmi.node_segment=
_size * mc-&gt;xgmi.physical_node_id;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; mc-&gt;vram_end =3D mc-&gt;vram_start + mc-&gt=
;xgmi.node_segment_size - 1;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; mc-&gt;gart_start =3D hive_vram_end + 1;<br>
&gt;&gt; +<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; if (amdgpu_virt_xgmi_migrate_enabled(adev)) {<=
br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; /* set mc-&gt;vram_start to 0 to switch the returned GPU address of<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; * amdgpu_bo_create_reserved() from FB aperture to GART aperture.<br=
>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; amdgpu_gmc_vram_location(adev, mc, 0);<br>
&gt; This function does a lot more than just setting mc-&gt;vram_start and =
mc-&gt;vram_end.<br>
&gt;<br>
&gt; You should probably just update the two setting and not call amdgpu_gm=
c_vram_location() at all.<br>
<br>
I tried only setting mc-&gt;vram_start and mc-&gt;vram_end. But KMD load wi=
ll <br>
fail with following error logs.<br>
<br>
[&nbsp; 329.314346] amdgpu 0000:09:00.0: amdgpu: VRAM: 196288M <br>
0x0000000000000000 - 0x0000002FEBFFFFFF (196288M used)<br>
[&nbsp; 329.314348] amdgpu 0000:09:00.0: amdgpu: GART: 512M <br>
0x0000018000000000 - 0x000001801FFFFFFF<br>
[&nbsp; 329.314385] [drm] Detected VRAM RAM=3D196288M, BAR=3D262144M<br>
[&nbsp; 329.314386] [drm] RAM width 8192bits HBM<br>
[&nbsp; 329.314546] amdgpu 0000:09:00.0: amdgpu: (-22) failed to allocate <=
br>
kernel bo<br>
[&nbsp; 329.315013] [drm:amdgpu_device_init [amdgpu]] *ERROR* sw_init of IP=
 <br>
block &lt;gmc_v9_0&gt; failed -22<br>
[&nbsp; 329.315846] amdgpu 0000:09:00.0: amdgpu: amdgpu_device_ip_init fail=
ed<br>
<br>
<br>
It seems like setting mc-&gt;visible_vram_size and mc-&gt;visible_vram_size=
 <br>
fields are also needed. In this case call amdgpu_gmc_vram_location() is <br=
>
better than inline the logic, I think.<br>
<br>
<br>
&gt;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; mc-&gt;vram_start =3D mc-&gt;xgmi.node_segment_size * mc-&gt;xgmi.physica=
l_node_id;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; mc-&gt;vram_end =3D mc-&gt;vram_start + mc-&gt;xgmi.node_segment_size - 1=
;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; dev_info(adev-&gt;dev, &quot;VRAM: %lluM 0x%016llX - 0x%016llX (%lluM use=
d)\n&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; mc-&gt;mc_vram_size &gt;&gt; 20, mc-&gt;vram_start,<=
br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; mc-&gt;vram_end, mc-&gt;real_vram_size &gt;&gt; 20);=
<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; /* node_segment_size may not 4GB aligned on SR=
IOV, align up is needed. */<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; mc-&gt;gart_start =3D ALIGN(hive_vram_end + 1,=
 four_gb);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;gart_end =3D mc-&gt;gar=
t_start + mc-&gt;gart_size - 1;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;fb_start =3D hive_vram_=
start;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;fb_end =3D hive_vram_en=
d;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;VRAM: %lluM 0x%01=
6llX - 0x%016llX (%lluM used)\n&quot;,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;mc_vram_size &gt;&=
gt; 20, mc-&gt;vram_start,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;vram_end, mc-&gt;r=
eal_vram_size &gt;&gt; 20);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;G=
ART: %lluM 0x%016llX - 0x%016llX\n&quot;,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;ga=
rt_size &gt;&gt; 20, mc-&gt;gart_start, mc-&gt;gart_end);<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt; @@ -276,7 +287,6 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_d=
evice *adev, struct amdgpu_gmc *mc<br>
&gt;&gt;&nbsp;&nbsp; void amdgpu_gmc_gart_location(struct amdgpu_device *ad=
ev, struct amdgpu_gmc *mc,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_gart_placement gart_placement)<br>
&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; const uint64_t four_gb =3D 0x100000000ULL;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 size_af, size_bf;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*To avoid the hole, limit the=
 max mc address to AMDGPU_GMC_HOLE_START*/<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 max_mc_address =3D min(ade=
v-&gt;gmc.mc_mask, AMDGPU_GMC_HOLE_START - 1);<br>
&gt;&gt; @@ -1068,6 +1078,14 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_dev=
ice *adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags |=3D AMDGPU_PTE_FRAG((ad=
ev-&gt;gmc.vmid0_page_table_block_size + 9*1));<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags |=3D AMDGPU_PDE_PTE_FLAG=
(adev);<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; if (amdgpu_virt_xgmi_migrate_enabled(adev)) {<=
br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; /* always start from current device so that the GART address can keep<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; * consistent when hibernate-resume with different GPUs.<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; vram_addr =3D adev-&gt;vm_manager.vram_base_offset;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; vram_end =3D vram_addr + vram_size;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; +<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The first n PDE0 entries ar=
e used as PTE,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * pointing to vram<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt;&gt; index bd7fc123b8f9..46fac7ca7dfa 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt;&gt; @@ -307,6 +307,7 @@ struct amdgpu_gmc {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; *pdb0_bo;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* CPU kmapped address of pdb0=
*/<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ptr_pdb0;<br=
>
&gt;&gt; +&nbsp;&nbsp;&nbsp; bool pdb0_enabled;<br>
&gt; This isn't needed, just always check (adev-&gt;gmc.xgmi.connected_to_c=
pu || amdgpu_virt_xgmi_migrate_enabled(adev)), make a function for that if =
necessary.<br>
<br>
Ok, I will update it in the next patch version.<br>
<br>
<br>
&gt;<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* MALL size */<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 mall_size;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gp=
u/drm/amd/amdgpu/gfxhub_v1_2.c<br>
&gt;&gt; index cb25f7f0dfc1..e6165f6d0763 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c<br>
&gt;&gt; @@ -180,7 +180,7 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(stru=
ct amdgpu_device *adev,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; /* In the case squeezing vram into GART aperture, we don'=
t use<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; * FB aperture and AGP aperture. Disable them.<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (adev-&gt;gmc.pdb0_bo) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (adev-&gt;gmc.pdb0_bo &amp;&amp; !amdgpu_virt_xgmi_migrate_enabled(ade=
v)) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SO=
C15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_TOP, 0);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SO=
C15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SO=
C15(GC, GET_INST(GC, i), regMC_VM_AGP_TOP, 0);<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/d=
rm/amd/amdgpu/gmc_v9_0.c<br>
&gt;&gt; index 59385da80185..04fb99c64b37 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt;&gt; @@ -1682,6 +1682,8 @@ static int gmc_v9_0_early_init(struct amdgpu=
_ip_block *ip_block)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; adev-&gt;gmc.private_aperture_start + (4ULL &lt;&lt; 30) =
- 1;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.noretry_flags =3D=
 AMDGPU_VM_NORETRY_FLAGS_TF;<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; adev-&gt;gmc.pdb0_enabled =3D adev-&gt;gmc.xgm=
i.connected_to_cpu ||<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; amdgpu_virt_xgmi_migrate_enabled(adev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; @@ -1726,7 +1728,7 @@ static void gmc_v9_0_vram_gtt_location(struc=
t amdgpu_device *adev,<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* add the xgmi offset of the =
physical node */<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; base +=3D adev-&gt;gmc.xgmi.ph=
ysical_node_id * adev-&gt;gmc.xgmi.node_segment_size;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to_cpu) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.pdb0_enabled) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; amdgpu_gmc_sysvm_location(adev, mc);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; amdgpu_gmc_vram_location(adev, mc, base);<br>
&gt;&gt; @@ -1841,7 +1843,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_=
device *adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to_cpu) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.pdb0_enabled) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; adev-&gt;gmc.vmid0_page_table_depth =3D 1;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; adev-&gt;gmc.vmid0_page_table_block_size =3D 12;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt; @@ -1867,7 +1869,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_=
device *adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;=
<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (adev-&gt;gmc.xgmi.connected_to_cpu)<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (adev-&gt;gmc.pdb0_enabled)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amd=
gpu_gmc_pdb0_alloc(adev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; @@ -2372,7 +2374,7 @@ static int gmc_v9_0_gart_enable(struct amdgp=
u_device *adev)<br>
&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to_cpu)<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.pdb0_enabled)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; amdgpu_gmc_init_pdb0(adev);<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gart.bo =3D=3D NU=
LL) {<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu=
/drm/amd/amdgpu/mmhub_v1_8.c<br>
&gt;&gt; index 84cde1239ee4..18e80aa78aff 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c<br>
&gt;&gt; @@ -45,8 +45,10 @@ static u64 mmhub_v1_8_get_fb_location(struct am=
dgpu_device *adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; top &amp;=3D MC_VM_FB_LOCATION=
_TOP__FB_TOP_MASK;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; top &lt;&lt;=3D 24;<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; adev-&gt;gmc.fb_start =3D base;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; adev-&gt;gmc.fb_end =3D top;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; if (!amdgpu_virt_xgmi_migrate_enabled(adev)) {=
<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; adev-&gt;gmc.fb_start =3D base;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; adev-&gt;gmc.fb_end =3D top;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt; We should probably avoid calling this in the first place.<br>
&gt;<br>
&gt; The function gmc_v9_0_vram_gtt_location() should probably be adjusted.=
<br>
<br>
mmhub_v1_8_get_fb_location() is called by the new <br>
amdgpu_bo_fb_aper_addr() as well, not just gmc_v9_0_vram_gtt_location().<br=
>
mmhub_v1_8_get_fb_location() is supposed to be a query api according to <br=
>
its name. having such side effect is very surprising.<br>
<br>
Another approach is set the right fb_start and fb_end in the new <br>
amdgpu_virt_resume(), like updating vram_base_offset.<br>
<br>
Which approach do you prefer? Or any better suggestions? Thank you.<br>
<br>
<br>
Regards<br>
Sam<br>
<br>
<br>
<br>
&gt;<br>
&gt; Regards,<br>
&gt; Christian.<br>
&gt;<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return base;<br>
&gt;&gt;&nbsp;&nbsp; }<o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_IA1PR12MB84057CB20B1F14652093BF38A89EAIA1PR12MB8405namp_--
