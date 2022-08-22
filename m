Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF19C28D13
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Aug 2022 04:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3D2D992CB;
	Mon, 22 Aug 2022 04:58:38 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2064.outbound.protection.outlook.com [40.107.212.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4E6A992AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 04:58:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+iiOmrdV/1YMNbQiwsZMsM9oX3GtFTGsj6iocR6PeCsxjnDeAa1YTlf+ok404o8muu654cFXGVL8lhLBS51npSa19d1dJtfi7PmXANXNI430DAilbh9bNy5GLcqFeyFZdsAldXsJpAb2hjsdxwm9bWVf7uk9u/ncyFL+EXfo7tL2b1LlPymVJdSp5uUb16Q/n1GZWeTIDqaj4QibQWm5uTVPQpZMKGW4tI63zxaFFhlaQ4K42vgD2Jnr+KVhri09mV5Fm8orcWiX1KpUWe0srF+Ip1RQJkEhlMzJOz9vHscwRu2LI/6QJpSuNddw/vTy4E0i0tpQ9GHVaPIt0NZsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VQVlcIayA1+GQ6SBww4wcawioTham0gYZLOWkvbbjA=;
 b=mmTB683VnOss4lsE0ET2PHMnMjqgJGfRnbmxojjihvaHzJ+2RKcyX44767Q0DiSVuvkT8xtw7sCqBGP9DBFDYR2bbJ2n2NE3KuFzIOkCkpvw7Oc6tuv0HHQQoy5pCSQXHxkfWfTEd1OH9+Q7w+7HGH6paM1c+kqSbqjHz5YO2+nVC/gBFdPliDETRcj2Ntw2IkRbtFyVkIjIvoQeS04eyjPgsFUbn/gfm7PbOgxOaY46nJfAMq+W+oVVkp9bquG9zu1TdchM50L70+ysqjLd8zkK4g/vgHT3BLdZWcdmfqJw5NY9K419d2Kt+2EoAq9jk5Hzpvuclrq3uIdnMbdJrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VQVlcIayA1+GQ6SBww4wcawioTham0gYZLOWkvbbjA=;
 b=tDEDrk5h2y30x0iMsudoGVWq3AaRZwTZmbX2r+fan26lfmlezqmDzQkJ7N17QFv2LVZGN0S4pmHpqsUXjQVXqI+RQKdQWsRozGaFuOeCr5+tqkzZjPqE62QaPP0jdI5ZU2d3+MVbsW5iNJaEJmgXDTHXhQX8wF7YnQAagI+XjF4=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by CH2PR12MB3767.namprd12.prod.outlook.com (2603:10b6:610:26::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 04:58:20 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d0ca:88b0:e558:2de1]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d0ca:88b0:e558:2de1%4]) with mapi id 15.20.5504.028; Mon, 22 Aug 2022
 04:58:20 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: enable NBIO IP v7.7.0 Clock Gating
Thread-Topic: [PATCH 3/3] drm/amdgpu: enable NBIO IP v7.7.0 Clock Gating
Thread-Index: AQHYsqjW9pKjLN0LLk6/so+XJE3AEa26YdlF
Date: Mon, 22 Aug 2022 04:58:19 +0000
Message-ID: <CY5PR12MB6369D3880CA541ABAF85A9A1C1719@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20220818021732.4087442-1-tim.huang@amd.com>
 <20220818021732.4087442-3-tim.huang@amd.com>
In-Reply-To: <20220818021732.4087442-3-tim.huang@amd.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-22T04:56:47.6183253Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f21b1483-6936-496a-0505-08da83faeef2
x-ms-traffictypediagnostic: CH2PR12MB3767:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bskHpXYLzCjhxd1tVRG477ZxKaGIu0SBqwGmIJ1HPhJD73PoeITY5mCZ7T+jb0bq/XLhjjgzVgUuYR3MeqyqtDFFNrzzIWjox4OhqZ/V1IHlxJyEm62T1x+6wkkDpSzM17mZRPls73CBJS2ThFG1M29U5mnJ/fOCtTEJu1l2zP/clEFb9LbC7zOUTMLCtE41uJGElMofN4kc4ZwqgK9FON/dd3dvlHEnurhLJ2I4+Iapm+/plVB+yyMa4HQURMFxeFE3/lT6e1+a4Kjjxs16lNR7CPi8UY0NYPqDlxpZP/Oidhnfhz8R/ttqYmqhgkoGbD9ldhWcx4AfaAxd7GeTA4DoPcWOaLDSXfFcMRC2YQne3ap4zNRdLytoQuMhoOpZB+GSmm3cpTjuFrhHiJ7pI28cbxt/oAppxDudHUhwXjkXaPCD6g1mRiToyoQu64zdpfeSIi9Ml4J1FVMkqaIoXNToabpCnQCruITC464/i+N8pQmyEjvBheweDymKCAcKw7OE3kdOpkhf2aGCuMDWkrR+fUh7ZroMs/DA1AIyM/HmSSu4gON8/XnBsUdZN5kMcwaergS3l9b43bai9aATbxeWke6xhYUwY/8bxcIqWpUuP5tg+iormPgpzF9LvcLhVHNn0Z0/n8B+murEvoZaPNeCW0oHH/cuMcOZyHLQpT8X7b79D9H/Bx3Jyt/LDwCLmE9Sm9H7kKHfrM7TLKQjmIggNkzd6d+HUgrkYq1gd9HkSnG7AENqcgNLNvf2TNIrMNE85BBzRnChS/QpmD56Jg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(38100700002)(122000001)(316002)(38070700005)(8936002)(86362001)(52536014)(8676002)(64756008)(2906002)(66446008)(91956017)(66556008)(66946007)(66476007)(76116006)(5660300002)(4326008)(7696005)(9686003)(6506007)(55016003)(71200400001)(41300700001)(478600001)(54906003)(83380400001)(186003)(110136005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZDBuQ0d4VWNIOEhxU3ZpaVRNQXZ6VDVQSUVCMXovcU0wMjF5ZUJUOWNoWXM2?=
 =?gb2312?B?R3VISlgyclJZMkg3WFRIckZxdzB2TnU3dDJRZzRTL1pjKzVKVGRSYnhwb2Fo?=
 =?gb2312?B?WEpBb1VBOVpYTGZacTd0OUFGcHJPZnVRbzZ5KzJ2RWdyN3VveTFPQ011Q0Nt?=
 =?gb2312?B?RjZsQTd1WkJqMHNOTjJzekF4VFk0TWt6WU1ZNWgrSmI5aEtXRGRsbU4wdlE4?=
 =?gb2312?B?OTZjbzU0WnBGMXVtQUo2czBKM1RDajZtYmhwTjlUVm9UVG42M2w1YThsbEhQ?=
 =?gb2312?B?UU8wamd3OHFmTVg5QWRXK082Qk0yUlNlei90WjFsUVdHOWFRK01nbWdqQTJS?=
 =?gb2312?B?MURMQ2FobGFoMURZdnNiRm5wUU1lTkFvazFqZDliYlkzME51cm9MNkl4anhL?=
 =?gb2312?B?MVc1MGlHUU1UeC8rZ3JkNkRqaWhIYmx1T1dGcXpmcTQybURLa1lVWGdjNlNy?=
 =?gb2312?B?UFJWVHlUL3g5cytzUEhkT20xQks0OXMxWTdBOEE1YjdteEM0WHJZN1JJZGEr?=
 =?gb2312?B?NzVJNFQreDhaZnIyanBGY1dPUnVTcHNybHZkQkVWdjhBeGhia0JYelprM0Jr?=
 =?gb2312?B?bHFRQWpTWWttZmYva3FXbUgyYnQ5VnNRNnJxUTFQcVVhVjRmeDI1M012L1Zv?=
 =?gb2312?B?MlI4ZTd4V3FEM2NKeEhhb0VZNmtxUFpobmIyRWtPbG1aWW5DYm52V3k5WVBW?=
 =?gb2312?B?WWoxRWMydDhmR3hEaWhSU3hQSjlVK2lsYlVtd3VhVmdhSWZSUWRYYW9HaVQy?=
 =?gb2312?B?R0ZsQXdKdkdQUGNkU3V5VktRa0graEJCN1p1bGVSMG1CSmdndEFMUzVkK3BK?=
 =?gb2312?B?UUtXbzdUdkpOaklBK0pGcUhnczJEKzRRVURReDg5ek5zMXMxUDJQTzRac2E2?=
 =?gb2312?B?ams1dTFHTXV4eU5Zci9TU09KNGhYK2pic1RXcVkyWkdaM0FqdXVOK29zSkVJ?=
 =?gb2312?B?UUNWTEJCWlFOWHY1OERadG5ESEdHKzMwVU4veVRzazFpbWZ6U2NIYkx4Njdh?=
 =?gb2312?B?ek41ZS9oMWErRm5PK2tQRUJBd0RjTXowSzlOMzFpOVhBNVNkdW5OaVVCZGFs?=
 =?gb2312?B?R2owUW85V1FZSXp2REpHVWlTNzA2ZkZjOFhZSTg3RzBLM25yZ0NZM0dZVE9z?=
 =?gb2312?B?LzdyS3BodXhRaXdKK09WcjBZbzRMUmFtdmtsOEljbzluTCs1dnplYnZVeHl2?=
 =?gb2312?B?ODhxalIvSXZRL2pxNFhUK0FpNFppUE1xQy8yZkZrUDAraW0yUVJwR21wVS9q?=
 =?gb2312?B?YzFTcDZiT0p5Y3luT0tGb0lqTVhmbWRxK04rejE2OE1NcTdyVnd6YWpYNjls?=
 =?gb2312?B?RmpZODM0YUsvNjlrN0lCbmhKOXE1aDRBeXJ5VGhmcDM0OGtpZDg4VzNnWWN3?=
 =?gb2312?B?eTEwOXpWQzgwcks5d1NwSTZscHFoNU51ckw2dVIxOUVwakN5ZmlmbVduV3NW?=
 =?gb2312?B?VmNldHc5dVcxcDdMekVZbFBmSDFPU2I1NGUxTkJQNnJ1OCtOVE9MV3NUVG51?=
 =?gb2312?B?bEhqYmRaaE93aThPZEZ6dVNBMHZZNGsxN2hJakE1cDdHS2cvNDA2NzZSNFU0?=
 =?gb2312?B?TTJNZklmekNTQmNLU3pFSWdjSnB0ZlZZZ3pIaTVVOFM4a0Qwci9lMVJ1Ykk5?=
 =?gb2312?B?V2VkZVB1UHJqbFVCZU1PeXpGL1VFcm1yK2poakFQemkzbzBvR0pBYXovUXN2?=
 =?gb2312?B?TFFCQm50UWZoMmRRQzNYS2NYQ2VVTlpvK0tLc3pQRm1YS3hhS3FwdWdEcEM1?=
 =?gb2312?B?RUIzNXJlMWRReUthQnpjY0FjeWo4OW1lS0hKb0x3TTVWNFppSzUzU09tSmdP?=
 =?gb2312?B?YzREdmF6ZGtLU2lyS1NXbk40Y2RVRVFkSlBMUnhiQTRpd1loMzQ2OEVMeklY?=
 =?gb2312?B?NG1ldEUyZkk3WUJoU2U1OUIyZmplZzJYTGt2OXVQOHVpMGVlOFdmT1Y4dDBT?=
 =?gb2312?B?cUUrWlBtRmpnUzJJKzBhMHdSdldJQ3lkV0QwQjArV1ZpY0w4MTRMM3Z3OUhm?=
 =?gb2312?B?Y1JVS3BPR0x6QVNLZjBLN2dqTFUrTFJsVmJZYUxNNFlLVE9qc0dUMFViaGYx?=
 =?gb2312?B?YUllQzFiS2w1MnVPdzFRUWs1V0o4TFc2Nk15STZTY1hHTjE5V202ZjdDL2p1?=
 =?gb2312?B?cTFtc2J1NzlxaitNN05ZRTg1WFVSMVlRQVVBOXJVeStpM1pTTUVmbjd5aDU2?=
 =?gb2312?Q?zAycA0zgLAmCdUL3JyVV30VKCcdHIyBOU01BrxEVgTql?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB6369D3880CA541ABAF85A9A1C1719CY5PR12MB6369namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21b1483-6936-496a-0505-08da83faeef2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 04:58:19.9934 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8TlstyUkLFuuUgmvl1+VaTX8QQ8VQv2MkCYnEEF45Ic767lUmB6Y6CuvYu7m/rp3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3767
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Tim" <Tim.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CY5PR12MB6369D3880CA541ABAF85A9A1C1719CY5PR12MB6369namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoaXMgc2VyaWVzIGlzOg0KDQpS
ZXZpZXdlZC1ieTogWWlmYW4gWmhhbmcNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
DQq3orz+yMs6IEh1YW5nLCBUaW0gPFRpbS5IdWFuZ0BhbWQuY29tPg0Kt6LLzcqxvOQ6IFRodXJz
ZGF5LCBBdWd1c3QgMTgsIDIwMjIgMTA6MTc6MzIgQU0NCsrVvP7IyzogYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPg0Ks63LzTogRGV1
Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhhbmcsIFlpZmFu
IDxZaWZhbjEuWmhhbmdAYW1kLmNvbT47IER1LCBYaWFvamlhbiA8WGlhb2ppYW4uRHVAYW1kLmNv
bT47IEh1YW5nLCBUaW0gPFRpbS5IdWFuZ0BhbWQuY29tPg0K1vfM4jogW1BBVENIIDMvM10gZHJt
L2FtZGdwdTogZW5hYmxlIE5CSU8gSVAgdjcuNy4wIENsb2NrIEdhdGluZw0KDQpFbmFibGUgQU1E
X0NHX1NVUFBPUlRfQklGX01HQ0cgYW5kIEFNRF9DR19TVVBQT1JUX0JJRl9MUyBzdXBwb3J0Lg0K
DQpTaWduZWQtb2ZmLWJ5OiBUaW0gSHVhbmcgPHRpbS5odWFuZ0BhbWQuY29tPg0KLS0tDQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMjEuYyB8IDcgKysrLS0tLQ0KIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MyMS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc29jMjEuYw0KaW5kZXggMWZmN2ZjN2JiMzQwLi45ODJjMTI5NjQ4NzkgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MyMS5jDQorKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9zb2MyMS5jDQpAQCAtNjAzLDYgKzYwMyw4IEBAIHN0YXRpYyBpbnQgc29j
MjFfY29tbW9uX2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQ0KICAgICAgICAgICAgICAgICAgICAg
ICAgIEFNRF9DR19TVVBQT1JUX0FUSFVCX01HQ0cgfA0KICAgICAgICAgICAgICAgICAgICAgICAg
IEFNRF9DR19TVVBQT1JUX0FUSFVCX0xTIHwNCiAgICAgICAgICAgICAgICAgICAgICAgICBBTURf
Q0dfU1VQUE9SVF9JSF9DRyB8DQorICAgICAgICAgICAgICAgICAgICAgICBBTURfQ0dfU1VQUE9S
VF9CSUZfTUdDRyB8DQorICAgICAgICAgICAgICAgICAgICAgICBBTURfQ0dfU1VQUE9SVF9CSUZf
TFMgfA0KICAgICAgICAgICAgICAgICAgICAgICAgIEFNRF9DR19TVVBQT1JUX1ZDTl9NR0NHIHwN
CiAgICAgICAgICAgICAgICAgICAgICAgICBBTURfQ0dfU1VQUE9SVF9KUEVHX01HQ0c7DQogICAg
ICAgICAgICAgICAgIGFkZXYtPnBnX2ZsYWdzID0NCkBAIC03MDIsNiArNzA0LDcgQEAgc3RhdGlj
IGludCBzb2MyMV9jb21tb25fc2V0X2Nsb2NrZ2F0aW5nX3N0YXRlKHZvaWQgKmhhbmRsZSwNCiAg
ICAgICAgIHN3aXRjaCAoYWRldi0+aXBfdmVyc2lvbnNbTkJJT19IV0lQXVswXSkgew0KICAgICAg
ICAgY2FzZSBJUF9WRVJTSU9OKDQsIDMsIDApOg0KICAgICAgICAgY2FzZSBJUF9WRVJTSU9OKDQs
IDMsIDEpOg0KKyAgICAgICBjYXNlIElQX1ZFUlNJT04oNywgNywgMCk6DQogICAgICAgICAgICAg
ICAgIGFkZXYtPm5iaW8uZnVuY3MtPnVwZGF0ZV9tZWRpdW1fZ3JhaW5fY2xvY2tfZ2F0aW5nKGFk
ZXYsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdGF0ZSA9PSBBTURfQ0dfU1RB
VEVfR0FURSk7DQogICAgICAgICAgICAgICAgIGFkZXYtPm5iaW8uZnVuY3MtPnVwZGF0ZV9tZWRp
dW1fZ3JhaW5fbGlnaHRfc2xlZXAoYWRldiwNCkBAIC03MDksMTAgKzcxMiw2IEBAIHN0YXRpYyBp
bnQgc29jMjFfY29tbW9uX3NldF9jbG9ja2dhdGluZ19zdGF0ZSh2b2lkICpoYW5kbGUsDQogICAg
ICAgICAgICAgICAgIGFkZXYtPmhkcC5mdW5jcy0+dXBkYXRlX2Nsb2NrX2dhdGluZyhhZGV2LA0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RhdGUgPT0gQU1EX0NHX1NUQVRFX0dB
VEUpOw0KICAgICAgICAgICAgICAgICBicmVhazsNCi0gICAgICAgY2FzZSBJUF9WRVJTSU9OKDcs
IDcsIDApOg0KLSAgICAgICAgICAgICAgIGFkZXYtPmhkcC5mdW5jcy0+dXBkYXRlX2Nsb2NrX2dh
dGluZyhhZGV2LA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdGF0ZSA9PSBBTURf
Q0dfU1RBVEVfR0FURSk7DQotICAgICAgICAgICAgICAgYnJlYWs7DQogICAgICAgICBkZWZhdWx0
Og0KICAgICAgICAgICAgICAgICBicmVhazsNCiAgICAgICAgIH0NCi0tDQoyLjI1LjENCg0K

--_000_CY5PR12MB6369D3880CA541ABAF85A9A1C1719CY5PR12MB6369namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div dir=3D"ltr">
<div></div>
<div>
<div>
<div dir=3D"ltr"><span style=3D"caret-color:rgb(33, 33, 33);color:rgb(33, 3=
3, 33);font-size:14.666666984558105px;display:inline !important">This serie=
s is:</span><br style=3D"caret-color:rgb(33, 33, 33);color:rgb(33, 33, 33);=
font-size:14.666666984558105px">
<br style=3D"caret-color:rgb(33, 33, 33);color:rgb(33, 33, 33);font-size:14=
.666666984558105px">
<span style=3D"caret-color:rgb(33, 33, 33);color:rgb(33, 33, 33);font-size:=
14.666666984558105px;display:inline !important">Reviewed-by: Yifan Zhang</s=
pan></div>
</div>
</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>=B7=A2=BC=FE=C8=CB:</b> Huang, =
Tim &lt;Tim.Huang@amd.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> Thursday, August 18, 2022 10:17:32 AM<br>
<b>=CA=D5=BC=FE=C8=CB:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.=
freedesktop.org&gt;<br>
<b>=B3=AD=CB=CD:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; =
Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;; Du, Xiaojian &lt;Xiaojian.Du@amd=
.com&gt;; Huang, Tim &lt;Tim.Huang@amd.com&gt;<br>
<b>=D6=F7=CC=E2:</b> [PATCH 3/3] drm/amdgpu: enable NBIO IP v7.7.0 Clock Ga=
ting</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Enable AMD_CG_SUPPORT_BIF_MGCG and AMD_CG_SUPPORT_=
BIF_LS support.<br>
<br>
Signed-off-by: Tim Huang &lt;tim.huang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc21.c | 7 +++----<br>
&nbsp;1 file changed, 3 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c<br>
index 1ff7fc7bb340..982c12964879 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c<br>
@@ -603,6 +603,8 @@ static int soc21_common_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_ATHUB_MGCG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_ATHUB_LS |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_IH_CG |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_B=
IF_MGCG |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_B=
IF_LS |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_VCN_MGCG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_JPEG_MGCG;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;pg_flags =3D<br>
@@ -702,6 +704,7 @@ static int soc21_common_set_clockgating_state(void *han=
dle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versio=
ns[NBIO_HWIP][0]) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 3, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 3, 1):<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(7, 7, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;update_medium_grain_clock_gat=
ing(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =3D=3D AMD_CG_STATE_GATE);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;update_medium_grain_light_sle=
ep(adev,<br>
@@ -709,10 +712,6 @@ static int soc21_common_set_clockgating_state(void *ha=
ndle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;hdp.funcs-&gt;update_clock_gating(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =3D=3D AMD_CG_STATE_GATE);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(7, 7, 0):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;hdp.funcs-&gt;update_clock_gating(adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =3D=3D AMD_CG_STATE_GATE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY5PR12MB6369D3880CA541ABAF85A9A1C1719CY5PR12MB6369namp_--
