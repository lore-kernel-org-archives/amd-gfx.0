Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301A3C369CA
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 07:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C86B710EA41;
	Thu, 17 Apr 2025 07:29:57 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com
 (mail-psaapc01on2130.outbound.protection.outlook.com [40.107.255.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E310B10E9FF
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 00:43:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zg/5X4znwo7uPcTrTSiXHjTa5+ZSLD7isv1D1NsfIxk23QqsU+/uygKpnZ7yFTFIjI3RM9lWfcwNm06PULB+3KoSTBbADBY7TvMO70yGjKRmKEsDT9xp2mAEYWz71KaxJ5ZWwdfpzt8LH5O3cDRy0iV9JHXMzuQuoN+h2TV3cDth9Gns2Y3bLvbR3hKc+4TDfwVfnE3OEpTkkIKgYbNhjnqxMvdnvWrP2KUc5OxecwmNxMR2kWqZXcc5R0ucPTggUhEtN4QXdNwUspFQiAp/zNsIScqruYYa9VmhhVRZxa4GVn4VBYcLjvZpn3sHMBWMMFU9/d4ghfGdJklnodx06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhLYbD3841rKWsNUz8YKcg6SUCkdsAQOo5JZWQtwuTs=;
 b=ZkYmx03FTfCrNCxH6ECz7QmhB15rt/Jo7NDwToulJI8VeDjcR/oRsJxRa6qSqSaabpLqMD7kD+mnhbupqMBOD3jc0d01oB12PUPYfNFFND8ZTaocePqUNGklv4PdfzK+htbpISFp8+x5SoUF2Y7pF3A7nfR0Sr4auYpB1PQwkJWfsruS3TWPkPc8LCzvByEXoDKlC8BGC/7NsopLpu4J2ExEkG/bNzyU75ZoSDzcH3UfoagfAZeFIzW3zKWO3mkv0XVrdJeJmKgfpWXPnWiDt0F2tfMxbCC/OCe3DmopCYEfCUj49XMu6igWsSa6XY1Bc4K/LiGQHUU5vTRnCDEevg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB6925.apcprd06.prod.outlook.com (2603:1096:101:1eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Thu, 17 Apr
 2025 00:42:56 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8632.025; Thu, 17 Apr 2025
 00:42:56 +0000
From: Fugang Duan <fugang.duan@cixtech.com>
To: Alex Deucher <alexdeucher@gmail.com>, Alexey Klimov
 <alexey.klimov@linaro.org>
CC: "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "frank.min@amd.com" <frank.min@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, "david.belanger@amd.com" <david.belanger@amd.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>, Peter Chen
 <peter.chen@cixtech.com>, cix-kernel-upstream
 <cix-kernel-upstream@cixtech.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtSRUdSRVNTSU9OXSBhbWRncHU6IGFzeW5jIHN5?=
 =?utf-8?B?c3RlbSBlcnJvciBleGNlcHRpb24gZnJvbSBoZHBfdjVfMF9mbHVzaF9oZHAo?=
 =?utf-8?Q?)?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUkVHUkVTU0lPTl0gYW1kZ3B1OiBhc3luYyBzeXN0ZW0gZXJy?=
 =?utf-8?B?b3IgZXhjZXB0aW9uIGZyb20gaGRwX3Y1XzBfZmx1c2hfaGRwKCk=?=
Thread-Index: AQHbrjQsyP3jhAPl60GLV5n21BS/cbOlnd8AgACKPQCAADjdgIAApZ2g
Date: Thu, 17 Apr 2025 00:42:56 +0000
Message-ID: <SI2PR06MB504138A5BEA1E1B3772E8527F1BC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <D97FB92117J2.PXTNFKCIRWAS@linaro.org>
 <SI2PR06MB5041FB15F8DBB44916FB6430F1BD2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <D980Y4WDV662.L4S7QAU72GN2@linaro.org>
 <CADnq5_NT0syV8wB=MZZRDONsTNSYwNXhGhNg9LOFmn=MJP7d9Q@mail.gmail.com>
In-Reply-To: <CADnq5_NT0syV8wB=MZZRDONsTNSYwNXhGhNg9LOFmn=MJP7d9Q@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB6925:EE_
x-ms-office365-filtering-correlation-id: 17e43475-922f-4688-805d-08dd7d48cb78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZjhBZ0o3ZTdrODVQL000c1dnR09zMGlRbURlU0FZdVd1RzIvWVJVZFJRWmND?=
 =?utf-8?B?SFprRytzV2xncCtvL2pBWTNjVCtQZmxuaVk2V2dOZUREbE9IbUtJYWVqN1ZY?=
 =?utf-8?B?UHhYbDMrRGYrZTQxYUV6eDZuTWlQcExoQUJWUUIzSzdVb3lYbXhheFl3Y0tq?=
 =?utf-8?B?aGVLK2JKdld5TFlqYUJMOGtLUm1tZ0RjYzNEUkYvSHlnYmdNY0RJRko5V2kz?=
 =?utf-8?B?RnVqa0UxaTFZRGlJSUVTU293OHdjZU1SSmxxSFk4NjkwSGtWWHhvQVAxRmpk?=
 =?utf-8?B?d29NaTV6VEsxL3c2dUxsMWwydDIwYmZMR09nUFI0d2ZvWHpISE9yUDlvT1U5?=
 =?utf-8?B?eUJvYnJ6eEZUOWV6OVExcnc1a3dkbzBlaDZHUUtqNzdkRmVXbm1HQXdYUVpq?=
 =?utf-8?B?YVh4Rk91TEhWek1DOWV0Ynpmd2lzclRIMzRyYjFQTXR5YUxmOGZMbVVxU3dK?=
 =?utf-8?B?bEtkZ25UYUdjanJyMFVJRlFtdWxUUXA5bms3a2o5ZEl1aUxCSjBjS0RPZGFV?=
 =?utf-8?B?YnVBMTNqZUY4dGR5YWpTSVdmMWJtUVo5SmRxSGRNU0pyWGl4NXVBM2EwTmt1?=
 =?utf-8?B?azVUZ2lTL3V2WnRFdFFOb0xJbDB3WGxqb2N0SW4yTXlPMXE4RkovTi96cXJV?=
 =?utf-8?B?MzFPWGVvS3RldE16ZlRQUlRsWkpNVVZ1Um1HMG5FelNxL1NGQWhKUmFJV3NU?=
 =?utf-8?B?R05Vd012L1JmdDJ0VGJZY21rQWl5Q3R1KzNlNkJQaFllZGhyVjZRUlJSeFNJ?=
 =?utf-8?B?dGhTQ21LN3puVURCb3hxbzZNR2dmV1JPc1lockdTSk8rUCtVb2k4UzM5OU51?=
 =?utf-8?B?R1ltRG9pU1IrbXdob1hDQTcwQkNxNGZzV0tjTHJjUFJiRXp2ZjQ0eC93NEFH?=
 =?utf-8?B?OXBzcmE4WjRVR05YMklOREw4OWR4SDIrRFhJZFByOFJlU2VGVjZmNWdDaDZr?=
 =?utf-8?B?QUNFNlZpdDAzMGZiK0ZrNVBUYUcrSTBtc2xZcStIVWlqanYyQndBTzVPTVVN?=
 =?utf-8?B?dGtqZW04NVNiSFJ1YmpCL29uK0RHOXdBOEF6MkExRlUwS3VaYU9jRU9QNnJr?=
 =?utf-8?B?SFRGUTNTK2ZxbWFBS3Z2NWxzVTExK2tvNUp5MFJIcG1ONGwxYVcvZ2k4SXVq?=
 =?utf-8?B?Uk1XZE1mQ21OWHUwYU15TXpyd2xVdm4rNzVGejZuajU1c29oY2dlZ0hwbnJJ?=
 =?utf-8?B?NDRWNDBqK0xkeTBkVnNjTDVzWEdYNDd2eStPVHFON1YvRmxNZ2cxMVNwZHha?=
 =?utf-8?B?cGNJZnNaQTFtUGVUNEtqMkpXSlRPTkg1N2JNaGVPeFd3VmtiWHc1NG1mS3Nt?=
 =?utf-8?B?UHhmcktqalpuK0oyZlYvQWV4UUJwT2FTMFJ0Z0xIMGJLTnZhQ3VwQUZNc2Ur?=
 =?utf-8?B?NjZnYSt2YnJONG9neEUxVTBtcVBqMGd3OGkyMjkvWjZsZGkrUWNZMG9NSHNK?=
 =?utf-8?B?dXZTNDRNa2h3RUkvbWVXZHhPSzBWd09wWU1haENzQVl2QjlBK0dIc2NkQTg0?=
 =?utf-8?B?VU5tRW1ub3p5UndqdGROMjAvMmRBb2QvWHFnL2swalgzMFkycURPQmJOSEdG?=
 =?utf-8?B?S3lNekVKUTBYajhWbXNxSGhlQW0wSVN1cVgwMzdBenh4cVFoUUxKa2ltQTFx?=
 =?utf-8?B?L3J6NGJMZSt4akFtL3pqeUUwYUo4SUNNVHhoS3g3S3lYeGdiSlBOMk5IQ1g0?=
 =?utf-8?B?ckd0ODZCSC96Z1UxYnBOMTNZcEszaDVVSEtldDcyTk9yajFEUkd4Qk12MG93?=
 =?utf-8?B?QzRLZjRuNWd2S0ZISkE4anFldmJ5TUpncHFqbXc2ak1YUDBsQ1M0N01vYzB5?=
 =?utf-8?B?RklNTm5zVFZBMUcweTRmamo5dnh4b01MdVNaTm8rUGRUclV4UitOcms1eW1z?=
 =?utf-8?B?SnZBMFoxckM0THQ2ZzA2WG9QekJ6WEIxTjQ2RXFyYnJLVUNNcnp0ODlVZ2ZV?=
 =?utf-8?B?bTNLdW8zNU42cjBBSkhFeUpFTklWSHhkNEpoQTdXaG9CUG96eE1FVk5IZDh6?=
 =?utf-8?Q?P+swpydlSzJ01UobQ7Rxug4Fy+nZsU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1MvcVg4bHN4RWJmK0RSZHZRVE44UGh3eU5hU1QzWDU3YmExNkFnUE1COWlQ?=
 =?utf-8?B?YU1ESTJLV2JaYTNYdWQ4T25GNXhQMzdYSnlFYUVxbXNqNHlRM3MyV1VjYnBL?=
 =?utf-8?B?SW9OQUJadjB5MUYyd1FFUXJNSTIvMHRQZ0cwRDEvZzFmTVZTOTkzYXZTVkdy?=
 =?utf-8?B?NUg3VmxHemJsWVhqQmkydXBIWTBaZFdQd0hqMHNEVU1PYU9KNHppS01nNWZG?=
 =?utf-8?B?d3VDRHBWdk1MSWVmWjFINHNpOEp2WnhVSHljMmNHWWQxZkNYQTlDWWdMU2J5?=
 =?utf-8?B?bkVTbWtuZWFITldSOGk1NUMrWHJDREtWbWY3MENVc0Q3TTRMTEdDaWh4OU01?=
 =?utf-8?B?WHEvNlR1Wi94MWRYLzBBdVVXMGRPVGJuVUJaTlM0dzFFY3JOMWZreUtoVmhJ?=
 =?utf-8?B?UnZQeEZsRDdTL01QSTl6YWVZSW9CdVlTSjBVUi92dnBBVWdQUWFJUWZEblRH?=
 =?utf-8?B?WVlRK0trYkR5cXdySXpUNXRRTWVWOUc1cW5zWFRZUGlvbkk0Wld2eGRIQk5D?=
 =?utf-8?B?b3RvNXpVMWdiU3JEajNiWUhPUnd4OElaZ2hQOXZ0NEZtdjRJZWdHMHgwM215?=
 =?utf-8?B?cTA2VG5KbmQ2REpTczE3VzVVOTBkRGl1MndWMUkyVlNFb2JBNXI4eFFZQ0gv?=
 =?utf-8?B?VHRoQVJsSWpVMlFyS05HVjRBdjl1MVc0S1czYUprakg4dmErOUFoQmlkMnRL?=
 =?utf-8?B?MjBFMGh5RWdZNmtSQ3diZFJSN3JLY2ZtYk8xSEtxYlR2VStDNnpQcmNpMk10?=
 =?utf-8?B?WWNkc0J4ejhHOERIL2tpOGlub05lMjIrMFJLMWdiSVdvVjNuZXhuRUpwWGR3?=
 =?utf-8?B?VVFGNE5MeWhvNlozMGNXWlZOVHlFZHdPaXRvZTFDMTNPQ1d4TU02Ymx3RkZv?=
 =?utf-8?B?RkdnZEVYdUhDR2ZKM1JYUU80eHRRdzRMNGlIbnVyMHV0RXhwZEFoMjhsTjBq?=
 =?utf-8?B?Y2ZVZnJmdVFwTEdaT2RjTlpOV3FtTzU2OHJUMVVoZHE5dDdUczVCTGRPVERa?=
 =?utf-8?B?dk5XeVdyU29wbkpkOTNSVWVSMlRTTERJTmg0YU1hWmE1ODA1ekc0cHFQbDV2?=
 =?utf-8?B?bkVIYk42UkcyUDhsQWtSQWgwWXV4T2FLeU9hM0JmeWxQdTBYb3lWRytWckxx?=
 =?utf-8?B?NnRzTDNONElaMHJUQ1laZTJUQk5HcVlGV2VaYlI0VVFka280enBzeVdHTk9Y?=
 =?utf-8?B?b0hLUmp3UWRFNjVvRUNyQmFrUnlEQ0I0K0NveVlKVUd4RXBCN0pRNktETWs5?=
 =?utf-8?B?WDdZMmlGNzR1L0VGbllScEY4WUZZVXRqVlU5czljZnlLek9pSy8xclFrYStX?=
 =?utf-8?B?dmNCSE0ybWFTZFRKcytYQnZyTWtDb0QwNTFINm5mTW5BQUMrTEI0QWwzcDBB?=
 =?utf-8?B?YndtQzYyVjhsNHBSQ1ZTc1dLZWJuUnpMUmpRODBGRlVBbzd3TDR1cGNkMzhL?=
 =?utf-8?B?OVozR1QxU0ZSdVg3Rk5lUTdId3M4VGJsV3NDajlVVytDYk9RMHZBZ0JpYlBh?=
 =?utf-8?B?TUU3Y1FOYkRVZXV1bWhtSXpzRHlYVFcvQk5VdVlXd1JMSC9mNC9SNys2aFFM?=
 =?utf-8?B?UE1IRnBhb1dhRlMzbGZWdVFhM2tmT1c3TkUxWFhjcFJiZ3E2cTk0a1VySEor?=
 =?utf-8?B?akV4REdSZUs0cHZCcFU0ZnVtb2tzeWNKR0JvbUMvOUVoNGtGQVp0MnZWNXVq?=
 =?utf-8?B?czZzQXQ4MXF0V1pEaDVrWG82TXVWeFZYeFNZdDVXdWJXT21yWUVWVjY4V3Uy?=
 =?utf-8?B?VHRKeE5yRDV0M0J5emdwRkZkOUVnYm1GMW5xT2QySG9Vc3BNL3FsR3NPcXIv?=
 =?utf-8?B?eStnZm52SHlPQ0M2QmNSWk95ZDF4OW5RMFcwamgwaUt5Vno5bUNlUUNIa0dv?=
 =?utf-8?B?V2xLRlgxMWNQbDU4ZUVTckNkWWdKZ0NpYVQ1UkNOczNhUlFaSXZ1TWRGYjl0?=
 =?utf-8?B?SWVsdVlETG5IeXljSUVTdEV1L1VTbU5aSy9vMTAyV0RSSjAzK3kyV1l6Zldm?=
 =?utf-8?B?Y0lSYmRiNzdJd2tDNkZLcWhSMG1URTRvcEcvNkRubUdNanZDNStXMlpLUVVX?=
 =?utf-8?B?UVIrSTNycnkwTkxXTzdYbzkwc1RTMjkzejdGWUcwSSt6V1h3emZIOHUybkRn?=
 =?utf-8?Q?G29hePwslk8IeJOSbiq1MxIu1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e43475-922f-4688-805d-08dd7d48cb78
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 00:42:56.0952 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hJnKJx+47gRiF0vldYxixmv5JSUyfpikeSNJJBKbQnF2dNCxSXm5gKVrdXHDtWMjFBTjkz+1584dE0treBk1uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6925
X-Mailman-Approved-At: Thu, 17 Apr 2025 07:29:56 +0000
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

5Y+R5Lu25Lq6OiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4g5Y+R6YCB5pe2
6Ze0OiAyMDI15bm0NOaciDE25pelIDIyOjQ5DQo+5pS25Lu25Lq6OiBBbGV4ZXkgS2xpbW92IDxh
bGV4ZXkua2xpbW92QGxpbmFyby5vcmc+DQo+T24gV2VkLCBBcHIgMTYsIDIwMjUgYXQgOTo0OOKA
r0FNIEFsZXhleSBLbGltb3YgPGFsZXhleS5rbGltb3ZAbGluYXJvLm9yZz4gd3JvdGU6DQo+Pg0K
Pj4gT24gV2VkIEFwciAxNiwgMjAyNSBhdCA0OjEyIEFNIEJTVCwgRnVnYW5nIER1YW4gd3JvdGU6
DQo+PiA+IOWPkeS7tuS6ujogQWxleGV5IEtsaW1vdiA8YWxleGV5LmtsaW1vdkBsaW5hcm8ub3Jn
PiDlj5HpgIHml7bpl7Q6IDIwMjXlubQ05pyIMTYNCj7ml6UgMjoyOA0KPj4gPj4jcmVnemJvdCBp
bnRyb2R1Y2VkOiB2Ni4xMi4udjYuMTMNCj4+DQo+PiBbLi5dDQo+Pg0KPj4gPj5UaGUgb25seSBj
aGFuZ2UgcmVsYXRlZCB0byBoZHBfdjVfMF9mbHVzaF9oZHAoKSB3YXMNCj4+ID4+Y2Y0MjQwMjBl
MDQwIGRybS9hbWRncHUvaGRwNS4wOiBkbyBhIHBvc3RpbmcgcmVhZCB3aGVuIGZsdXNoaW5nIEhE
UA0KPj4gPj4NCj4+ID4+UmV2ZXJ0aW5nIHRoYXQgY29tbWl0IF5eIGRpZCBoZWxwIGFuZCByZXNv
bHZlZCB0aGF0IHByb2JsZW0uIEJlZm9yZQ0KPj4gPj5zZW5kaW5nIHJldmVydCBhcy1pcyBJIHdh
cyBpbnRlcmVzdGVkIHRvIGtub3cgaWYgdGhlcmUgc3VwcG9zZWQgdG8NCj4+ID4+YmUgYSBwcm9w
ZXIgZml4IGZvciB0aGlzIG9yIG1heWJlIHNvbWVvbmUgaXMgaW50ZXJlc3RlZCB0byBkZWJ1ZyB0
aGlzIG9yDQo+aGF2ZSBhbnkgc3VnZ2VzdGlvbnMuDQo+PiA+Pg0KPj4gPiBDYW4geW91IHJldmVy
dCB0aGUgY2hhbmdlIGFuZCB0cnkgYWdhaW4NCj4+ID4gaHR0cHM6Ly9naXRsYWIuY29tL2xpbnV4
LWtlcm5lbC9saW51eC8tL2NvbW1pdC9jZjQyNDAyMGUwNDBiZTM1ZGYwNWINCj4+ID4gNjgyYjU0
NmIyNTVlNzRhNDIwZg0KPj4NCj4+IFBsZWFzZSByZWFkIG15IGVtYWlsIGluIHRoZSBmaXJzdCBw
bGFjZS4NCj4+IExldCBtZSBxdW90ZSBqdXN0IGluIGNhc2U6DQo+Pg0KPj4gPlRoZSBvbmx5IGNo
YW5nZSByZWxhdGVkIHRvIGhkcF92NV8wX2ZsdXNoX2hkcCgpIHdhcw0KPj4gPmNmNDI0MDIwZTA0
MCBkcm0vYW1kZ3B1L2hkcDUuMDogZG8gYSBwb3N0aW5nIHJlYWQgd2hlbiBmbHVzaGluZyBIRFAN
Cj4+DQo+PiA+UmV2ZXJ0aW5nIHRoYXQgY29tbWl0IF5eIGRpZCBoZWxwIGFuZCByZXNvbHZlZCB0
aGF0IHByb2JsZW0uDQo+DQo+V2UgY2FuJ3QgcmVhbGx5IHJldmVydCB0aGUgY2hhbmdlIGFzIHRo
YXQgd2lsbCBsZWFkIHRvIGNvaGVyZW5jeSBwcm9ibGVtcy4gIFdoYXQNCj5pcyB0aGUgcGFnZSBz
aXplIG9uIHlvdXIgc3lzdGVtPyAgRG9lcyB0aGUgYXR0YWNoZWQgcGF0Y2ggZml4IGl0Pw0KPg0K
PkFsZXgNCj4NCjRLIHBhZ2Ugc2l6ZS4gIFdlIGNhbiB0cnkgdGhlIGZpeCBpZiB3ZSBnb3QgdGhl
IGVudmlyb25tZW50Lg0KDQpGdWdhbmcNCg0KDQoNClRoaXMgZW1haWwgKGluY2x1ZGluZyBpdHMg
YXR0YWNobWVudHMpIGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24gb3IgZW50aXR5IHRv
IHdoaWNoIGl0IGlzIGFkZHJlc3NlZCBhbmQgbWF5IGNvbnRhaW4gaW5mb3JtYXRpb24gdGhhdCBp
cyBwcml2aWxlZ2VkLCBjb25maWRlbnRpYWwgb3Igb3RoZXJ3aXNlIHByb3RlY3RlZCBmcm9tIGRp
c2Nsb3N1cmUuIFVuYXV0aG9yaXplZCB1c2UsIGRpc3NlbWluYXRpb24sIGRpc3RyaWJ1dGlvbiBv
ciBjb3B5aW5nIG9mIHRoaXMgZW1haWwgb3IgdGhlIGluZm9ybWF0aW9uIGhlcmVpbiBvciB0YWtp
bmcgYW55IGFjdGlvbiBpbiByZWxpYW5jZSBvbiB0aGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBv
ciB0aGUgaW5mb3JtYXRpb24gaGVyZWluLCBieSBhbnlvbmUgb3RoZXIgdGhhbiB0aGUgaW50ZW5k
ZWQgcmVjaXBpZW50LCBvciBhbiBlbXBsb3llZSBvciBhZ2VudCByZXNwb25zaWJsZSBmb3IgZGVs
aXZlcmluZyB0aGUgbWVzc2FnZSB0byB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBpcyBzdHJpY3Rs
eSBwcm9oaWJpdGVkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVh
c2UgZG8gbm90IHJlYWQsIGNvcHksIHVzZSBvciBkaXNjbG9zZSBhbnkgcGFydCBvZiB0aGlzIGUt
bWFpbCB0byBvdGhlcnMuIFBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQg
cGVybWFuZW50bHkgZGVsZXRlIHRoaXMgZS1tYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgaWYgeW91
IHJlY2VpdmVkIGl0IGluIGVycm9yLiBJbnRlcm5ldCBjb21tdW5pY2F0aW9ucyBjYW5ub3QgYmUg
Z3VhcmFudGVlZCB0byBiZSB0aW1lbHksIHNlY3VyZSwgZXJyb3ItZnJlZSBvciB2aXJ1cy1mcmVl
LiBUaGUgc2VuZGVyIGRvZXMgbm90IGFjY2VwdCBsaWFiaWxpdHkgZm9yIGFueSBlcnJvcnMgb3Ig
b21pc3Npb25zLg0K
