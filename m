Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A686CD8CA1
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 15:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00C7910E079;
	Tue, 10 Oct 2023 15:02:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E34A510E079
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 15:02:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOUpl+fX673ytpzAVBNzMEOFPafHIvckMf38cW3e387QlrU52kwHljfMWFrInWrCJK3tIVjdNtMkeppKC3uAhxCrF47U47/k+3ETBfYsZtD6HL+TlDXsXEePigucLSmZAuOiaU9/5HEne03NVbUoXL5rZLrsXeIOGskZT0ru63wrTCfX4Zp9yhso/dJCFfKIOcnIT9lKn+JuSo0RRtdB0qL13v8U60+h2BTwB5w7lwZgc/Ech4OAs7eCkaIolQoJLLBa8UvFOXGPo+mWygngE4Soy5/SPOLhESBZ4SC1GmR+gu/JRsCHi8J+EKpHXGbmXUwd67SYQEY9xxnH/QLjrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZeNGzt203/eKeR7l56uQo7Hf/GC3W/uw6eAX6ILIJc=;
 b=aPclNpsOkjy3iNRMW3oFMWZX07yntO7gRDzylIILlmwDFFN10uzN0o0jLi+0iPH6r8LtbQJhF19Rn/YDatKrnKNUCOr3ol65qVtSVVs4hawL6L0CJTXXb3Z0vjc6F7r9ZXHJg5ACkYNNLUpGrkfvU5B7f0d3bfU4RttmcrnI7oekCDWgfoHwYABuAqEZssLuJ3bd50nETQGTv6+75jqamJp7QdDdkvvoJkXTSFORbUhcppQ0zpVmlrJ5vxtiFCWIhS/IAZHJuVHOzfynoaGY82WilyrTuRnEiyTIdOjFGBvqBcII8Y/9Vlg0Ez159CRau/eFbH9c3ErP/YiCgvRrwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZeNGzt203/eKeR7l56uQo7Hf/GC3W/uw6eAX6ILIJc=;
 b=vOhMK/7RrCluB95JifPw0Ovz3QVWUowdfdZhT+g7GCWHHjs+jrZfQaTvDpHeXNahiSiGPfPjY6cCyZx0mWv7RuvDGfeRpZghkESxsJRq45+TGDD7TQJUh/rkOKkKA5pDXm1dAq7UgdvoqgSQrO/wGoEam2ewq0Y+i8Tgv6DAXNo=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 15:02:22 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2%7]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 15:02:22 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/swsmu: update smu v14_0_0 header files and
 metrics table
Thread-Topic: [PATCH] drm/amd/swsmu: update smu v14_0_0 header files and
 metrics table
Thread-Index: AQHZ+4BiZxHd3I9yB0qnIh2njwJLjLBDHlSw
Date: Tue, 10 Oct 2023 15:02:22 +0000
Message-ID: <BL1PR12MB5144A11E2324A4983F688C84F7CDA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231010134730.458857-1-li.ma@amd.com>
In-Reply-To: <20231010134730.458857-1-li.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=c17a744c-ffb5-4d79-96cc-67d5d0936877;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-10-10T15:01:46Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS0PR12MB8453:EE_
x-ms-office365-filtering-correlation-id: 69df087b-3b7a-4a66-7fdf-08dbc9a1e7ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RkhpH3i0bo26c22vRZB8epTw0dNEdrRwm9HpruItAax+UKGxf6GfTQ3hP9AeeU4P8TzfxLuj5zm+cU7O38BXP0GyEWg+TTCXXkV0xQePXHm2y0vqvbrXqSAj2/89w5pG1TgqX8FE9xa4somUVQbZ+Ov8kuWIHTAhwkUtZLfdBBMjNRsnjs2MqnrzXlON8hmwZEtBfbZFnwUsJlFAC0nZeztJ3Zw+D5On2FVmQLyW/IB8TJEVO6lHDAesvgqmDZb44Zt8qIApelQj9MXfRcEL81iya/4dHdEchv86cCsGx85lTPATNyJ2Iwl7FyebbTB5ivGK4gfYJGMUSua8QzHo17BTE0lXQHJkkNalZ23xY4Xu/YVH617GAYbEEYZeg3rEmqpH5BTfsI27J4pKeBd3ZXCmhMDE+8nfvxhDEsrYD4T08tLW7xloM5q0iey6BR4SHJOUfNLiKagHttyS4dav7yktvF1m79z55vzPZwAR4JMiCldFrl/n6eM5of/wxnDX86tmxIwWkgwiSviFZ48NEqYKHvUAsZD3/J+1sBoMqQfJfLIfmPerOuSncj3fxiUzmLOAA3YLCOPY3o5KpPyycxLEDyECafbwdxuu3l4deGbebULi/ACiWLTzxC7gVkzt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(76116006)(110136005)(8936002)(8676002)(5660300002)(41300700001)(4326008)(316002)(66946007)(6636002)(66556008)(64756008)(66446008)(66476007)(52536014)(15650500001)(4744005)(2906002)(122000001)(83380400001)(38100700002)(55016003)(53546011)(9686003)(86362001)(26005)(478600001)(33656002)(38070700005)(71200400001)(7696005)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VNfHabJ3wsQti6YHBIVswT3/3YdK0ULDSh4HHmVuuIQ8woRXT0gtfpd7iZ6m?=
 =?us-ascii?Q?y+rfOe2b8h4ofcKZIJ3RqkpXho6IJnhvMyGGGDupCWT/x5wwx6Q18Hm67ZS2?=
 =?us-ascii?Q?LbzOt3KC0X1SExlucFGa9PZaSeNdWJXIcS6K2fjsQ+zm/frzaCQsfwxL9aCS?=
 =?us-ascii?Q?9EFHuAk/I9/e5D0fIYG54ZgIoxRwdWAibGea6DNyPtKLk9mBQ6STgHq9QTay?=
 =?us-ascii?Q?dplX9ZkYv6EU7VvaWklvUDJOJePB8GQ6r9LiOGlcYtITun9pp24hxcS2eNMC?=
 =?us-ascii?Q?NZwvfIBZ0T9LavB/KY8rM3CZh6fmZDebd/L/mP+WhP+6AqbMSZrr2hpFPwmd?=
 =?us-ascii?Q?Wc5zvOXNs9/423iCAcjHPlmyAU/ti1YnfDfsLSXAeBXm33lKk9grsMUtX9/h?=
 =?us-ascii?Q?h228Ka52OlVgAdOPi2B9Ny7ajPoEI9SlVsf2ymFs4Nu/bMFa6tmtLkHJa8mL?=
 =?us-ascii?Q?yi/d8O3AspSzUkddKkj4KS6YQoc0w82BlASi3+JjgTv/KbiAulwdNrPmu1b0?=
 =?us-ascii?Q?nh9rWdYQbUs5wQhT6dL38AQ9vFO1dcqtgYfaaYgFseZJRdD7oir3dzHzUKF+?=
 =?us-ascii?Q?e3ZdaPsgKVCtheS/r+URq57/318rrWRnqV/2ke1LmzeLKwAC1WMiyH8UOrqV?=
 =?us-ascii?Q?DHbF7YyUJzOKDQ4YsMwMQ96xBINphppxaJyWi2x+tPo/CiDsdR7KeQ+rVNyW?=
 =?us-ascii?Q?nF3SlOpGrv9lGXOIKy4zClw3z0Ci316BJy29JkbCY6Vkm4sIaDsON8l0zmyM?=
 =?us-ascii?Q?PHTF29SjX8MZ9IGjxHjT324sp2lTzYV7lKYiM1WKpCmSqJTPZGvH2jbktpyc?=
 =?us-ascii?Q?FNR6sHsDym2Kby1GPOJDMgHniAZCXr6KYV7hjRZ5QD+THjCfx0gaCr30AZ6z?=
 =?us-ascii?Q?vKzUJjH0WCoLSM34sPfqkEpfu/dTYswOdkiA38bxJsaxGWwfRftRQMdHk2MZ?=
 =?us-ascii?Q?ToNxEKFQSn493RzIChjmw5JUsqMhX2N8jQuf+u1sR4a02V5rCuN6ViUqFBzu?=
 =?us-ascii?Q?yHvVvb/m5psWWyIwshgLKHduGTxBf85/h6SNkuSKduQMTFmQwxijyj+o8aWZ?=
 =?us-ascii?Q?b1Pm0JXP/Ex2xuPjtSUyMqvd/bpHfbCqfVmxZO3+VlUP2kcVJ+qeDjMbLxhT?=
 =?us-ascii?Q?sNsCMxYMHarbYZIOAggMEQxyHeWmSuBD+l9JLHA/6Mxmw/jnscOnamG6+r1m?=
 =?us-ascii?Q?zIeD9WWCZe9ewvvDD7IA7n23oBKH1PRcC7zXg4/zSGIGQ3YFDo8oj5h9+4M8?=
 =?us-ascii?Q?3/COF5FqsuUyT9xJlD1lWv6xKppiYK3VAn8O4FTf3e14ufbFxnOdGuFYltNw?=
 =?us-ascii?Q?XOI6lv/BbhsvR/LmpGADair67um8VV4jdXvckiYpi1gtwipMnqss+6xv+2ig?=
 =?us-ascii?Q?Chd8QQRIj6fbBffuU7GdULjvt9pk8uEAGUyzmMjKa0ANVFJUjw2dPDH75YMJ?=
 =?us-ascii?Q?EKma+P/9NvP8ysW8MaCDsy8Y50BlXXmB699XIcbIESMyctLchp+qYK2CPMRB?=
 =?us-ascii?Q?6CotLfQNOg+sEzFmflAaholC5JQnC6Hy4ol7zUFDpo5UaozhbPv9LmBE+Twl?=
 =?us-ascii?Q?wViucXexfPiAOX/0jQU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69df087b-3b7a-4a66-7fdf-08dbc9a1e7ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 15:02:22.1096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 33/BhV7csHuuMj204GtpaXm84+OR7UzBs44h3vfS2lXys0XJSJaFFFp6BWfu8i5kCnZ9dziz/FYRYRBL1N4uLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: Ma, Li <Li.Ma@amd.com>
> Sent: Tuesday, October 10, 2023 9:48 AM
> To: amd-gfx@lists.freedesktop.org; Feng, Kenneth
> <Kenneth.Feng@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>; Ma, Li <Li.Ma@amd.com>
> Subject: [PATCH] drm/amd/swsmu: update smu v14_0_0 header files and
> metrics table
>
> Update driver if, pmfw and ppsmc header files.
> Add new gpu_metrics_v3_0 for metrics table updated in driver if and reser=
ve
> legacy metrics table to maintain backward compatibility.
>
> Signed-off-by: Li Ma <li.ma@amd.com>
> Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

