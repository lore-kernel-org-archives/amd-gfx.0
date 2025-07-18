Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EAEC83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jul 2025 10:09:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A91B10E93F;
	Fri, 18 Jul 2025 10:09:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EtJubQVy";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEB4210E93D
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 10:09:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WS6WqO6FyCZ4NYWHpvjJW3i41IF0LJshu9jGHVxU5ZtlObcGZtL9wdO2mwf/EnsfmGrwDeEuvw1LTBWz6k1CR80Fzo1Xt6EN+duWi9K6MlcHUYMabgZKhwd6MXW796fWB16eSQ5ZC4yUQMeSIOBwQUHeY/hm0Gtq2dIpTCRlfJZh9jDUVlMscjDSD7f5TPQTGQSxayjYDM3cVqN/CXS1KZdVt8kAynboZzX2gyYSJip8SRQqEZ6St2Q/FVzjTvzepEMFWNz47ddCOayBQML1qYA0FM5IaZKgfaOHvwO+zGK+vmYqWRyEEuGh3jjkI732n1mo63QyNdjovhkdj1WJ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwZ74GPtwvHx7k7SMeVEcXQSSDGKvgQ2SPhLrhNt6sA=;
 b=kK8lKq6dMQD3oRWo73g46OD4Szhjb8q58y8yKVV4ZzzbHvYlkYbXDbSmpXwffJSTve1dRZb5Ksxpcd+kxGeRrtpAiTnEINtig7yMFiOUKgdZDplUHwA6Pa2fwb6hVW3kHY9+9KXgxsVXEFFxUJfR/40aOnT8dCTjPjMMT+ssiVy86T8dhCFuCiEdytr0unHlBRDP9tw7EZTa8bvcLp5UtaELTs8NUzvMdxGOvYxhHPPeZBAWhSNLB4bUp1p4bViQrv1PgK3DrvGE2pYlzk6pn11vUeAPT+qAhTsMclPky1EaNR2n/UN+UuZXwmWcMw5+c1/HFM02v0eUpBKE3zFBpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwZ74GPtwvHx7k7SMeVEcXQSSDGKvgQ2SPhLrhNt6sA=;
 b=EtJubQVyzxqvVvGXjxQuddN7Nv4B11KFF8x7GiXPiQxl6yBgIDXM4NPvf/6ZVFHFmTO3uVdmFR0O1lRn+m95DBe3N8/CWz5zM9o3C2grSuoqyOB0Q7OQJEvITAV10ld6mqpdyuGCmuBxaIxZb52Jw4C2cMM9PTta83abPaRSgrY=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 IA1PR12MB6433.namprd12.prod.outlook.com (2603:10b6:208:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 10:09:25 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8880.034; Fri, 18 Jul 2025
 10:09:24 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu/gfx12: set MQD as appriopriate for queue
 types
Thread-Topic: [PATCH 3/3] drm/amdgpu/gfx12: set MQD as appriopriate for queue
 types
Thread-Index: AQHb9p04P26Dd/kdc0SmoYQQbz4x1bQ3RyaAgABW1IA=
Date: Fri, 18 Jul 2025 10:09:24 +0000
Message-ID: <DS7PR12MB600532AE46C2420CFB949E60FB50A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250716220115.3872837-1-alexander.deucher@amd.com>
 <20250716220115.3872837-3-alexander.deucher@amd.com>
 <c78b9083-cdf2-43fb-ae29-dab1544b03de@amd.com>
In-Reply-To: <c78b9083-cdf2-43fb-ae29-dab1544b03de@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-07-18T09:23:26.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|IA1PR12MB6433:EE_
x-ms-office365-filtering-correlation-id: ef1b27c2-05ed-4159-6f34-08ddc5e32c5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Z2Y0eVNxSXZmWlExa3AvSVc5RWxVMzAveng2bVJ3QjM4cFNMSkZqeFlLRFpL?=
 =?utf-8?B?YWdVMFhxN08zcnpuNzZlWHhmaGJLTlgxenhhN3BHeTdLWmVmVENiUGIvdE4y?=
 =?utf-8?B?SlV4SlRDbmNGS0tvNjJvb0VjOTZxUFI5YStDVkc3Y3Q2dWRhODcxcXBSdWFj?=
 =?utf-8?B?T2ZvSStMMHlZbW5yZlF6KzVlZEhUS2diZ1RsYVh6NGU0UXZGMkt0Umw2dVJo?=
 =?utf-8?B?SjQ5bXVNQXhJZm1FOVk2VVVoWEs5UUd3anlSSHFvRGVVMXBRL3BNZnJ3STJv?=
 =?utf-8?B?TG9nczNtWi9rMEdnZHQzbmFpRzc5eXFEZTRwelM5OEZ2RGNIS1Z1VjE5Zm1o?=
 =?utf-8?B?M0Fha0ZlTjJpT0NzY0RTaW1LVnM0M0huUTgrRVdwMDFjK0Q2ZnZYU1BQY3E4?=
 =?utf-8?B?K2hDeVNzN1Y0R3FLc1Z6VG91d0hWVzRpNW5xTjlMeldDdkVFb1p4eXhqenlN?=
 =?utf-8?B?OXJJOS9vQkF2bERiWFFZelVQc1F1NXY1M25Gdk1GVm02OHdzVit0Q1AweE55?=
 =?utf-8?B?Tm1vTkR5dEZha0JwQ1M4VlRHbVdnOW1OVkJWWUd0NU5sdG5kNDZPbnZJT2pG?=
 =?utf-8?B?RStuN2FGZUtZVVpJL2h5V1FDMHE0dG5qTGtKVXlKZ3BQNUdyTHpidTdzREVw?=
 =?utf-8?B?VHllRmJQa2FEZWs0SXBYTkkvamtXNFBnUjhHZGRqcDZ5NTdTc3lISUxJWGdm?=
 =?utf-8?B?eGdqSzZpcEE1R1l6cEtYbEJGdmhvbjhrc1M1eVNWNDFGWHBvOEowM2gzYlU4?=
 =?utf-8?B?OTNmeDAwMGRUQy9YbGtNTjdZa1dQWFlIKzBuWkdvV29MUjRPcDZjblRSL0N5?=
 =?utf-8?B?TVd2Z25SdDZUSldVdGVtc1JPaFh4L2tBeU1BdUs2b29aVDdsZXRKVkRWMCty?=
 =?utf-8?B?SFN4U2JISmRQMTVqaWlrWFNuQ3hRc28xdks1Z1hFTHNqMTBML3c3RkxxVDQ5?=
 =?utf-8?B?ZU1YTlV1WU1kWTdCVVhzemZXL3NjR3Z0blM3ejdDNDBaRklTVnBVK2ZnQVo2?=
 =?utf-8?B?U1NEV3RXNFcwaERKQVQ3K2FsQzRxRU5hVFFXSjlVV2RNZUxsdU5WcEJMMkUx?=
 =?utf-8?B?K3RzUEE5OUlaajMwY29IRmRxZm5CMlBQSjkwZzBaV3JTM0xoQ0w3VVgrV3BY?=
 =?utf-8?B?ZXZscy92NUZ2NjgrK2xOMjMwWkphYjRIYnRpTUFQN085b3ZVV2VhYVVES3Ra?=
 =?utf-8?B?aFdIWDY1aXNXWnAzcXk2UHdoS2FuU0xUVlhsZktKMGFRaHRnVXpVT2JGVVdO?=
 =?utf-8?B?N2pjSlZueDRUOU94UlFYd1JGWmc5KzhaQjJ4aVV1Z0ozU3VkNFU5ZlZndVFk?=
 =?utf-8?B?OWZEa3ZpNFlycHNoZnVJanRZQWJGUkt2SVJDeUdKUEJtR3RmR0EzMVU2VXRF?=
 =?utf-8?B?dlg1YkxxWTJtMlEzNUc5S1Bsemk4YXgvczNNNjk2OWFtUlVqY3JpVk9qQk5T?=
 =?utf-8?B?YnFjRkx4Q1FxZndualZtRmtnUjZNbnR1STl2ODB6Vk5kajRvd2JHKzBFU1JL?=
 =?utf-8?B?MFVybnUzL2JIMG8wYlVzc1dYMkV4aE1xc1hubDVETXFsZ1A5ZnB4a2U0aDNY?=
 =?utf-8?B?WUhOMlkxVWxKcUVpMUZORDRNV1FLRzhaWkJGbHpLY3RQSkd4aHlwQjZNTWFE?=
 =?utf-8?B?MnhRTUF6eC9QdE1XUlRsbTNlcjdnNU9Xa2pCQWpxVldHR3BDOWpuUXZtb1BX?=
 =?utf-8?B?WGMrRll5dDRybnhMNVRZT0ZDVUYvanJzeWxpTC80OUMrdHFmazNFZ29UeWlj?=
 =?utf-8?B?K3hrbFEyTjFYSW43NWJ5aCs0Ung2Nm16UUxqZkxTOUZPa044M1g5TytnUmlJ?=
 =?utf-8?B?QWZqZGZlZGx5NVJjZ0tIZ3Zld3N4d0VrMjlOZ1pyZHh5cmNST25XdHZrTk5q?=
 =?utf-8?B?cjhidXhBb3ZOSG92MDExd2g0bGxxaWhFWEtyaC9YQW4wQkRuZ1VlUUl6Z01U?=
 =?utf-8?B?RmtJS0VWMXFRV3F2RXFjd1M2bHhGYnZYbXcySEtYa1hORkNhL1RLSHFQMWNJ?=
 =?utf-8?B?d2dwZkhzZFhnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFprNWRxaGsxaVdlWDM0NEt1LzV4ZG9Ra2VLWTNqRk5Gejh0cHJGU2YxN1p0?=
 =?utf-8?B?NU1IVHJSbzNNaGppdCtaV0pUQVVSenRNUFA5cGcvZWhzTGN3bk52TW83YWlH?=
 =?utf-8?B?N3ZoMCtYcW9ybGFPZ3ZzU256dVZDbjkvcFBVNHhVYk5uaGw4bGxXZ2tQSWt0?=
 =?utf-8?B?ZmVaWlpWUEN5ZlFUQzJJL0VWUlJsS0p2NUM1TnFNcHc1SjhiMjhWTFA0alYx?=
 =?utf-8?B?UWZ4a015MEVmUG9oOStjRlkwNHVQL0lRL2VwdlJyUUxraUtNdlYvRllJMCtQ?=
 =?utf-8?B?SFUwZ2pHSlNWL2dZZHNkRlNaWlNEdzdxby9BOThWWnJMRjEzV2J2UjhDWXQr?=
 =?utf-8?B?NmRPK2VXeXM2dTRKbEwza2ovUyt2QW5mZytUcUhMVytTWnBPVlBUaXVNTWNk?=
 =?utf-8?B?SmZDcWlmdnlwMTFmVk1PZG9sRmVDbi8rOE4zaW1ZTGYwbEdNT3BhZUxDRVVa?=
 =?utf-8?B?eWNEVFlZUVVsSW0yQzFXSmxiV0hDZ1VUaXhyS2l3STh1ak9QdFRBVjVldjgz?=
 =?utf-8?B?Z09yam5HNVhPL2FPQ3pPVGRyRVRwQ2xEMU81OWhNZDVWenIxaTNYOVAxcjFI?=
 =?utf-8?B?am4vclNoY2VpbUcxcWpGY3FJYng1WFBmQURnbFU5NW1SMC9GNHBlRG9XNDQv?=
 =?utf-8?B?WFFQZ29oVWNXTUtEVytjOExWQjdiMGdVb0Fyd0orUnRFc3NYSkhuZUZkWnhC?=
 =?utf-8?B?Z2VRTG5MdVhxcHJkQXJoWFV0Y2RaeU9rb2NEZ2FMVzNtc3hkdkdOd082eXlT?=
 =?utf-8?B?QVRXS2JKVVpiSGJIYXNPRlNVTVZJNGRXemNlUWw2WFFHY1ZoMWZ6Si9nOHV1?=
 =?utf-8?B?VFJqR1lXeDQ5MW5JRzZZdmYySnU1SGJHdS8yYzZoVzFIaWxlQzF6NTl6d0V6?=
 =?utf-8?B?ZFB5NUdQNG9neFNCRWNRaEYxdVFzdVhEMW91RFp1dWt3bGdaZUxBQU9wS0w4?=
 =?utf-8?B?bVErOTBUU3VpYy9NWXpzQ1hscVVhU3RLSmFudW1sbjVOL3F5c3NuR09qeXVs?=
 =?utf-8?B?MzRJSGN0TE90MDA5Rmh6L2xYUGR0UGxITTZlS1FGQXNTV1NtRDdKTUk1M1gw?=
 =?utf-8?B?WGN6dHhRZDlsZ1V6Z3N2N1QzL2t0Y0Q0NVdPdytzMnZSSnEvT1Y5eGVhWExN?=
 =?utf-8?B?U3lMZFg1bWNYVXg2QURIQkZsRC9tcGdIYlViMDVyY1J2Y1hSUXZ0dnJQMkRj?=
 =?utf-8?B?ZTZWSkxoWk1VUnd5Mi9tV1cvSlVMUUhqZ05vOHJRRHd0RnN3WkJBVUJLZ1RL?=
 =?utf-8?B?YWZCTFdpYnE2WEZ5clZYRVgzMHZyUjl1TC8vdmgzU2RHMG9DUHBYbUlGRDVD?=
 =?utf-8?B?VS9UeXRicnNCZllkQS9raDdxSDdQY0lBazk5RC9ZclUyYVk3QXpKWnhBb3NH?=
 =?utf-8?B?LytNUEpPU2NycjVxejd4OU1HWW04ek1rMUtsdVI1akl6Ym5pM0ZmQ2hWdEly?=
 =?utf-8?B?NklOVnA0aXdBWVFoQ05jZnBqUzhBOFo3dWNQcTd2WjQvd2pWL05Kbzk4NEJB?=
 =?utf-8?B?Qk5hMXllNExreUY2Smc4MURPa1Zydk0xZy8rWnRyclBEbENuZElWSzh1MTVJ?=
 =?utf-8?B?SVNMR09vbVFFclFUSlpSakJmcDcrUWQ2UW9oM0VFUlllakxpbTFuL2hnWjdR?=
 =?utf-8?B?Sks3ZlZmY013ZlBma2pGR2RkMGlnLzY4NlY0RGV6bkI2WWFrd1BjOGp4bnFa?=
 =?utf-8?B?NWpuaEN3NXhGdnpLRjZSa2Q1aUZvYVYrc2xhUHBjZnVRUkNhMkFYZjBwb2Mr?=
 =?utf-8?B?Mk9VMVpPYlN4UGIvRUhSa0RpcjZpa0FjdGJVdTQzeUVnTXZWRnBVVzJDQ2Yw?=
 =?utf-8?B?VHVJcDl3N3JiNWQwRi9oOWsxemlOdlJZQjZZem1KOGdsaGV3UHhUMTUwUVRV?=
 =?utf-8?B?WVZCM21VclpPd0pybXhJb0YvUzArL1htVThGZUxZL2JRT2hybHBnT1E5bUcy?=
 =?utf-8?B?U0taQUNQT0JUMzhkSHFXaVAzalhQM3dnUmM0a3Uwa3h3Q3VwdXpMWFA4V1dC?=
 =?utf-8?B?ZW4xWlF1a1h2bUg4SitFY2c5MkROMk1NWityQUw5OXYwU25ieVZyQ25lNWJL?=
 =?utf-8?B?clNweTlPbU00K285ZHhXM3l6UWc3ZjgyUFB0NHZUTUdlZHE3UnNjTllGZHFz?=
 =?utf-8?Q?11o8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1b27c2-05ed-4159-6f34-08ddc5e32c5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2025 10:09:24.8737 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I9tQ1Yy7mfsXqLfcNm30nQycJhgEkL/5DSoCGzb8l4/vrR3HFXwD54XhkI8Bw8r8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6433
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

W1B1YmxpY10NCg0KV2hhdCBpZiB3aGVuIHRoZSBrZXJuZWwgcXVldWUgYW5kIHVzZXIgcXVldWUg
YXJlIGVuYWJsZWQgYXQgdGhlIHNhbWUgdGltZSwNCnRoZW4gaG93IHRvIGhhbmRsZSB0aGUgY2Fz
ZSB3aGVuIHVzZXJxIG1hcHBlZCB0byBhIHF1ZXVlIHRoYXQgaGFzIGJlZW4NCmVuYWJsZWQgcHJp
dmlsZWdlZCBiaXQgYnkga2VybmVsIHF1ZXVlPw0KDQpSZWdhcmRzLA0KICAgICAgUHJpa2UNCg0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJv
dW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgTGF6YXIsIExpam8NCj4g
U2VudDogRnJpZGF5LCBKdWx5IDE4LCAyMDI1IDEyOjEzIFBNDQo+IFRvOiBEZXVjaGVyLCBBbGV4
YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcNCj4gQ2M6IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFt
ZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy8zXSBkcm0vYW1kZ3B1L2dmeDEyOiBzZXQg
TVFEIGFzIGFwcHJpb3ByaWF0ZSBmb3IgcXVldWUNCj4gdHlwZXMNCj4NCj4NCj4NCj4gT24gNy8x
Ny8yMDI1IDM6MzEgQU0sIEFsZXggRGV1Y2hlciB3cm90ZToNCj4gPiBTZXQgdGhlIE1RRCBhcyBh
cHByb3ByaWF0ZSBmb3IgdGhlIGtlcm5lbCB2cyB1c2VyIHF1ZXVlcy4NCj4gPg0KPiA+IEFja2Vk
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+ID4gU2ln
bmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPg0K
PiBBIGNvdXBsZSBvZiBuaXQtcGlja3MgZm9yIHBhdGNoIDEuDQo+DQo+IFNlcmllcyBpcyAtDQo+
DQo+ICAgICAgIFJldmlld2VkLWJ5OiBMaWpvIExhemFyIDxsaWpvLmxhemFyQGFtZC5jb20+DQo+
DQo+IFRoYW5rcywNCj4gTGlqbw0KPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nZnhfdjEyXzAuYyB8IDggKysrKysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEyXzAuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3YxMl8wLmMNCj4gPiBpbmRleCA3MjIwZWQyZmEyYTMzLi43M2EwNGQw
N2JiNDk0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
MTJfMC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMl8wLmMN
Cj4gPiBAQCAtMzAyMCw2ICszMDIwLDggQEAgc3RhdGljIGludCBnZnhfdjEyXzBfZ2Z4X21xZF9p
bml0KHN0cnVjdA0KPiA+IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHZvaWQgKm0sICAjZW5kaWYNCj4g
PiAgICAgaWYgKHByb3AtPnRtel9xdWV1ZSkNCj4gPiAgICAgICAgICAgICB0bXAgPSBSRUdfU0VU
X0ZJRUxEKHRtcCwgQ1BfR0ZYX0hRRF9DTlRMLCBUTVpfTUFUQ0gsDQo+IDEpOw0KPiA+ICsgICBp
ZiAoIXByb3AtPmtlcm5lbF9xdWV1ZSkNCj4gPiArICAgICAgICAgICB0bXAgPSBSRUdfU0VUX0ZJ
RUxEKHRtcCwgQ1BfR0ZYX0hRRF9DTlRMLA0KPiBSQl9OT05fUFJJViwgMSk7DQo+ID4gICAgIG1x
ZC0+Y3BfZ2Z4X2hxZF9jbnRsID0gdG1wOw0KPiA+DQo+ID4gICAgIC8qIHNldCB1cCBjcF9kb29y
YmVsbF9jb250cm9sICovDQo+ID4gQEAgLTMxNjksOCArMzE3MSwxMCBAQCBzdGF0aWMgaW50IGdm
eF92MTJfMF9jb21wdXRlX21xZF9pbml0KHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlICphZGV2LCB2
b2lkICptLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIChvcmRlcl9iYXNlXzIoQU1ER1BV
X0dQVV9QQUdFX1NJWkUgLyA0KSAtIDEpKTsNCj4gPiAgICAgdG1wID0gUkVHX1NFVF9GSUVMRCh0
bXAsIENQX0hRRF9QUV9DT05UUk9MLA0KPiBVTk9SRF9ESVNQQVRDSCwgMSk7DQo+ID4gICAgIHRt
cCA9IFJFR19TRVRfRklFTEQodG1wLCBDUF9IUURfUFFfQ09OVFJPTCwNCj4gVFVOTkVMX0RJU1BB
VENILCAwKTsNCj4gPiAtICAgdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIENQX0hRRF9QUV9DT05U
Uk9MLCBQUklWX1NUQVRFLCAxKTsNCj4gPiAtICAgdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIENQ
X0hRRF9QUV9DT05UUk9MLCBLTURfUVVFVUUsIDEpOw0KPiA+ICsgICBpZiAocHJvcC0+a2VybmVs
X3F1ZXVlKSB7DQo+ID4gKyAgICAgICAgICAgdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIENQX0hR
RF9QUV9DT05UUk9MLA0KPiBQUklWX1NUQVRFLCAxKTsNCj4gPiArICAgICAgICAgICB0bXAgPSBS
RUdfU0VUX0ZJRUxEKHRtcCwgQ1BfSFFEX1BRX0NPTlRST0wsDQo+IEtNRF9RVUVVRSwgMSk7DQo+
ID4gKyAgIH0NCj4gPiAgICAgaWYgKHByb3AtPnRtel9xdWV1ZSkNCj4gPiAgICAgICAgICAgICB0
bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgQ1BfSFFEX1BRX0NPTlRST0wsIFRNWiwgMSk7DQo+ID4g
ICAgIG1xZC0+Y3BfaHFkX3BxX2NvbnRyb2wgPSB0bXA7DQoNCg==
