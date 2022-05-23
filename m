Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B8CC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 23 May 2022 10:37:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEFCB10E96F;
	Mon, 23 May 2022 10:37:33 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2048.outbound.protection.outlook.com [40.107.102.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D19010E6EE
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 May 2022 10:37:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCQBssQhQdNZPTybe3WQL5UCqUTTtIY76Gm/rwtuu3n4KvVkgR9rYZdL9cQJvbyceOY9ri0eJ+0y4mpupzUjg6N87SUsPNMkjIeFbbzDCmRwr/ozPpbShB8zwIPBqSY6wgW2Ho6VGOe02nLTDX2ip3DMJzDHn+0aWxNY7jKDnXrt//6UPDPP3zA/jip+bhP1ujdBaxxpD0+lC2dbt1FqTNNtde8y1qCscDy3BjZ3HRM7xbbqYgayjSToaoNFBBnnVTwVv57bjLWcfkQkdl8i/blhh5Pg9sZPOCzRmNdufWQlQziIkGDleohQeiFjT7DEsRz2zSyAM/zYB0hcqAZ+qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPxrqrZv64pbuHdIwmlisgS/V/fq6IAEgE7sUd9lfy8=;
 b=jfIkRVBEMJEXrQ6K0ExV7V6j02NxsLhufQVJkzbaSyd/Je/IsbabdhP1MVUKpVsAt+032M7CBbaYEzxtDArEhae5tdCwS/qrFf3KVNVzMaEj1IxIiigBcK0HcZ7vjcfO8uRBB4DbZJkVdDj1CQx8DHJtyyZXdnYAGdLccQOZzyVHPrqi7GID62k5N5e74KUCUciibfbXG8Q7pk4Qhd60/2l9OcSUsssFBTp6yJN8J8FEAxTTGrofMtSRhU0X93zXKeRLGbeopgFP7Y5DnCwmP7IczIIBfqq3cv9w7gkFedWRYZJOivIn/uX370VSNZmk6976/Nr/4BqR+PSm2h4Yuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPxrqrZv64pbuHdIwmlisgS/V/fq6IAEgE7sUd9lfy8=;
 b=dCzhiPLViEisSoDTdZcvJf/gATu9VVyBj7Nfy4PJNOAsblZRhOt7CYzZGl8/KKf8b7RC786yqm/fMa7G1SajdYsWe+fVux78o0PmS6JHvTymg/0JOBVZB6rxzia5S4UrmdqKKy4HwOHdkFfg4gcl5RW4mqtLmxBv5OALe1b20dE=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.21; Mon, 23 May
 2022 10:37:29 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::d504:b18d:6b58:cf8d]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::d504:b18d:6b58:cf8d%7]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 10:37:29 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIFJldmlldyAxLzJdIGRybS9hbWRncHUvcG06IHN1cHBv?=
 =?gb2312?B?cnQgbWNhX2NldW1jX2FkZHIgaW4gZWNjdGFibGU=?=
Thread-Topic: [PATCH Review 1/2] drm/amdgpu/pm: support mca_ceumc_addr in
 ecctable
Thread-Index: AQHYbn2BKH5Qv7utikGdWXz97s22eK0sJtsAgAAW/7CAAAcQsg==
Date: Mon, 23 May 2022 10:37:29 +0000
Message-ID: <BL1PR12MB533465DDC9B1BB06EAF269049AD49@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20220523081701.32456-1-Stanley.Yang@amd.com>
 <CO6PR12MB5473FC663AE752AB2C3C284D82D49@CO6PR12MB5473.namprd12.prod.outlook.com>
 <BL1PR12MB5334742D96EE471C414BB0839AD49@BL1PR12MB5334.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5334742D96EE471C414BB0839AD49@BL1PR12MB5334.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-23T08:48:47.7290000Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de2760f1-97a7-49ee-653b-08da3ca83c62
x-ms-traffictypediagnostic: PH7PR12MB5712:EE_
x-microsoft-antispam-prvs: <PH7PR12MB571258F30C7F91EFD8AA18CB9AD49@PH7PR12MB5712.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E77MdeFQMinI4N4JiEl8plG8HasXClhErka1nYQgYuX8keBwvNMF6A3W982s4DGPi6HaLWBx2Crh/zXeUF78D3i3jRYtjVLY5ZsebbqVO6f5wq3Ehfl8OMbHQaPZVUA5vpEDayRr1r+QqRI+2TYwswk70W3OWvv6FmaYEE7yRUR2+2whM6jPm/MkwH6TuFa4TbqyoSutw/kcB4PvdEyHkqmBb7lPFDbzvx0Q40yuHFaa0B1draPGg+iv9xz2hCizmJ4QA2UhT0xPnc+BfjnZHe83MNcvOUiRxxaLSYqeHleFzPTsd8sP+rlpoca2Fn1lSd9ZYxLCwNeJ4U7ZddZQQrIaOLpWxi17hovWWfvd5jq0BnDP9UlvIqTxYwd5f8JfGkYrME69zhNt09xN/6xlyvkSrxJIIvXKQlNcmC6sKXZAjrIaHNPqJuXg1hBRY6XuUlCRdmtbxRBfiCI/1VeQiBcJXz/EBey2ZsQLjoqJZZbx1VmU1RauETPfgmD7GmLlx5pemL0oZmd0gCRJ29xFZhEgrVALnhxnd3BUcC5YzZB1gJYRusIxk4ioO+fxZUzEv9fXSfzfBtrOGxvDv9UgFvpYr5KeD+MTwPfcDmPZqsa/OjDm2K4u16z9pZI4ewNEbqLfsyGnPUNPAT2J/fK2nnpgEukkCQsHs/ncCEQiDWl2jtbzhZN/RAGzxKTnKBoFPx7I2agLfOW5I59prmw1nraqHR/9XWNjdvMd/OZnq5s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(66476007)(66446008)(64756008)(86362001)(91956017)(76116006)(8936002)(52536014)(2906002)(66946007)(122000001)(921005)(30864003)(5660300002)(38100700002)(38070700005)(110136005)(53546011)(71200400001)(7696005)(316002)(6636002)(508600001)(2940100002)(83380400001)(26005)(9686003)(224303003)(6506007)(55016003)(186003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZnQwSmp4NSt0c2Q3d1R4V0ZONURwaXFjTzBoOTZKNStYeFFibFpva3hIenZQ?=
 =?gb2312?B?Z084NWZsNXBkSGJsUlltMlVRZDV5K2Z5K1BRcXlrQStmYnZKdzE1N0t6R3o4?=
 =?gb2312?B?MTFvQUZ4bUgzVEdRQkd0VER1TENndUdKN2hDd0x4QVgvMC9PeDdOQ21pSjZy?=
 =?gb2312?B?M05XTU8yQUhNcXRKc3hST3VWdXphTXlXZzcxZDV1K2RPajVYb1B6SXhJN3VF?=
 =?gb2312?B?WEcwSHkvV0wxVmlISU45aHRnc3cvbGJzVkVDcGV5Qnh1Q1JpWjhhVDZJSGhj?=
 =?gb2312?B?M1FqcSsxRVB4d2xRanMrTkp4SEp0MVFFNHRFaWVsdDRKRCt5VWxHZWxSQ1RU?=
 =?gb2312?B?QzFvL1BpSkpUVmw4MmJGVGo3cVlGYk1yZDVVRzJ2R1hSemcrTEpYVzQ4UUQz?=
 =?gb2312?B?TE0zNnZ5L2JZSTFHSVRTbjJXYzdmM3lDL0lsSUFuMmU5d2w2alVMUk5IZ2Na?=
 =?gb2312?B?YUJPZk0xdGdLRDBPYzZsQ2R2cDFZM1U3UkFLUkxBMUl5ODFWVVNlMWtQZE5M?=
 =?gb2312?B?dFpvWnZpalR1WHNSakFMMmhWZ29UQ3QySUlpM085MS9nYnVLRUh3dzFSTXJK?=
 =?gb2312?B?citxZGRGc1RXalROajQrWVRyakQwLzR0R2lCajJnSUV1ZExEN0p5RW8rdHhE?=
 =?gb2312?B?bExvN0xmNnFxVlBkV1QzTyt2U212SEEwS0tnTE90aDZEQTVlUGxXak5KQVpD?=
 =?gb2312?B?QklRdGhkdTk4b2FtYzAyRks1cTdJaGRURU9aRU5JU0NDRnRvZDZOWlBLUlJx?=
 =?gb2312?B?N0Q3N3YwMVZnTHNBbDhsM3JEVjU4UlJDdnVkdTZScFFscFRqSVQzWnNVNjlR?=
 =?gb2312?B?cWxZbzYzVCtUVm1sOWxGbDlOcWdqVVh6VVF6SkRQTDhmREhzZGJhZlBSVnUr?=
 =?gb2312?B?aEt4QzFqQU8xVzNoWGVIRDI5SVZmWndmTjdoUUVTcXZmTTRUcnVLOEU3R3lk?=
 =?gb2312?B?QXhheHFGQU14MGprNUN0V1hra0hPUTVLS1pHWklNZFZHN0lPUUtQMFhDaHhS?=
 =?gb2312?B?M0g1NXBjQnhCRSsyNkhtVXZKSUorU2FkUEdoR2IreVl0S2VjVnFWYkVXYmdi?=
 =?gb2312?B?K3Bqb0tCcWhTMXNSeDBOOFA1OEIrSEJ4ai9NZWFhMkpwVFpuS3UxU3lqUmpk?=
 =?gb2312?B?UnJ1ZkNsQlhIanBNRnhFV0xpWVI3elBPYW91cC91WjNNMW5TYmtqTXpEcGJp?=
 =?gb2312?B?K2hCL0d4OFc2QjNxMlFZTkF1a1VSOHpxVWNYa1l3UHZ1MXhybnhpTjVaTnZm?=
 =?gb2312?B?SitTUDBwdWJ2elRJQVNjVEtDMDBmTTdXb0ZKWGFQZjRkSityaHZzUEZxM3BJ?=
 =?gb2312?B?RWpFRjBELzhtQjBwZTVVbHl0WWU3TVB1VVRWU3ZTNnlLNVJpd0hwd283RVhZ?=
 =?gb2312?B?M01XajMwRktFbUhSNVhRbU9UaE05N3hpYjNmUVN2Q2QwaEplY2dIeEZxQUg0?=
 =?gb2312?B?UUJDQXBROTNkMXZDVk96OGcraXVwTzcyNEczYlNBVnZTUG8yTG4zUnJQOUxv?=
 =?gb2312?B?Y3kyZjA2eG9vdWk3a3NOSVg1MUhwUm1ZM3B4NkhEb3lOL0l1Vm9kRUJJUTdo?=
 =?gb2312?B?MXNPeU5xL09pZEtIb2dRclNNd08xVzF0ZGVUanZwTk5DS0xrcTg0QXRMVDB4?=
 =?gb2312?B?RUp4bVQ2OVpXWk9WK1Z0azlkV2IwQmxJVGJOamVkc2Frblo4TTFFZ1l6R2Vj?=
 =?gb2312?B?dW1IL1d5Mit4SVZLRjJxSDZiZGo0b00wam0waHVORHdxa0pVUEtSUUdocFE4?=
 =?gb2312?B?VXpSak1JbnlOWW5JZWg0VFYxRVZRbG4zakFMWk0xNCtmQnpOYUltcnZIdDAv?=
 =?gb2312?B?ZVY5UzE3eGhDY2lWT1MrQ3FYUnFWM1ZvZGJ1cThsTFJnWHdibFZ1YzU5ODBt?=
 =?gb2312?B?NVI0S0ZEQTVmUWdxN0x6TmJHc3VGa09SL25EYUhnWUFVbUxYVmk5ajNKMlZl?=
 =?gb2312?B?T3FFZi9UekdSaE04enlRNngzc0JUbW5VZDN2NGJHZHNyaEZqckFzdldRVWNl?=
 =?gb2312?B?bDVwNDNUVlFYVEsvYmxuMzQzc3gyWW1HZU9lYXBIWU0yUUxZa3hXL0tVYmpL?=
 =?gb2312?B?VUJuS3VJdzNGV1NoSHZMTSs5U1k1SDJCbDNUNzd4WGRJR3FvYUZUS3UzckRN?=
 =?gb2312?B?OUNqdExKK3NyNGVvSkpSU01CbmNqUlp1b29ZU2xVd3BzdzBzbmpTM3V5M284?=
 =?gb2312?B?ZnAycHoveVVxQjlWTERZYXQxMHFRMFJzSExyWnBZMkVHaHpCaU5JQW1NaGxK?=
 =?gb2312?B?MDVkV2EvVGwyL3BRM3hvOUpqakh3K3ZOaTZyMExMaTh4UU9kSDQvU1RTOWEx?=
 =?gb2312?B?TXF6ZEVsQkN5aE1KZkNQTXhybzNrWWxWRHAvZFEzdFBEVzdLZVpySS9YUjMz?=
 =?gb2312?Q?ZYOptSDJUOcz+nuY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB533465DDC9B1BB06EAF269049AD49BL1PR12MB5334namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de2760f1-97a7-49ee-653b-08da3ca83c62
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 10:37:29.1126 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EFfb0s40ZSkCqUUevhKLcYw/Usv/Y3+caPYIOrC249YSbHRe7b34Rf5f+/xN9KP5fJ0okx/g/MCfYWr6aFwm1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5712
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

--_000_BL1PR12MB533465DDC9B1BB06EAF269049AD49BL1PR12MB5334namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KW0FNRCBPZmZpY2lhbCBVc2Ug
T25seSAtIEdlbmVyYWxdDQpIaSBLZXZpbiwNCg0KUGxlYXNlIGlnbm9yZSBhYm92ZSBtYWlsLCB0
aGFua3MgeW91ciBzdWdnZXN0aW9uLCBJIHdpbGwgdHJ5IGl0Lg0KDQpSZWdhcmRzLA0KU3Rhbmxl
eQ0Kt6K8/sjLOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
PiC0+rHtIFlhbmcsIFN0YW5sZXkgPFN0YW5sZXkuWWFuZ0BhbWQuY29tPg0KyNXG2jog0MfG2tK7
LCAyMDIyxOo11MIyM8jVIM/Czuc2OjE2DQrK1bz+yMs6IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZp
bllhbmcuV2FuZ0BhbWQuY29tPiwgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcgPGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiwgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdA
YW1kLmNvbT4sIFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPiwgUXVhbiwgRXZhbiA8RXZh
bi5RdWFuQGFtZC5jb20+LCBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0K1vfM4jog
u9i4tDogW1BBVENIIFJldmlldyAxLzJdIGRybS9hbWRncHUvcG06IHN1cHBvcnQgbWNhX2NldW1j
X2FkZHIgaW4gZWNjdGFibGUNCg0KW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoN
Cg0KW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEtldmluLA0KDQq3orz+
yMs6IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQuY29tPg0Kt6LLzcqxvOQ6
IE1vbmRheSwgTWF5IDIzLCAyMDIyIDQ6NDkgUE0NCsrVvP7IyzogWWFuZywgU3RhbmxleSA8U3Rh
bmxleS5ZYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgWmhhbmcs
IEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IFpob3UxLCBUYW8gPFRhby5aaG91MUBh
bWQuY29tPjsgUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+OyBMYXphciwgTGlqbyA8TGlq
by5MYXphckBhbWQuY29tPg0K1vfM4jogUmU6IFtQQVRDSCBSZXZpZXcgMS8yXSBkcm0vYW1kZ3B1
L3BtOiBzdXBwb3J0IG1jYV9jZXVtY19hZGRyIGluIGVjY3RhYmxlDQoNCg0KW0FNRCBPZmZpY2lh
bCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc8
bWFpbHRvOmFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+PiBvbiBiZWhhbGYg
b2YgU3RhbmxleS5ZYW5nIDxTdGFubGV5LllhbmdAYW1kLmNvbTxtYWlsdG86U3RhbmxleS5ZYW5n
QGFtZC5jb20+Pg0KU2VudDogTW9uZGF5LCBNYXkgMjMsIDIwMjIgNDoxNyBQTQ0KVG86IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPG1haWx0bzphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZz4gPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPG1haWx0bzphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZz4+OyBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29t
PG1haWx0bzpIYXdraW5nLlpoYW5nQGFtZC5jb20+PjsgWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFt
ZC5jb208bWFpbHRvOlRhby5aaG91MUBhbWQuY29tPj47IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBh
bWQuY29tPG1haWx0bzpFdmFuLlF1YW5AYW1kLmNvbT4+OyBMYXphciwgTGlqbyA8TGlqby5MYXph
ckBhbWQuY29tPG1haWx0bzpMaWpvLkxhemFyQGFtZC5jb20+Pg0KQ2M6IFlhbmcsIFN0YW5sZXkg
PFN0YW5sZXkuWWFuZ0BhbWQuY29tPG1haWx0bzpTdGFubGV5LllhbmdAYW1kLmNvbT4+DQpTdWJq
ZWN0OiBbUEFUQ0ggUmV2aWV3IDEvMl0gZHJtL2FtZGdwdS9wbTogc3VwcG9ydCBtY2FfY2V1bWNf
YWRkciBpbiBlY2N0YWJsZQ0KDQpTTVUgYWRkIGEgbmV3IHZhcmlhYmxlIG1jYV9jZXVtY19hZGRy
IHRvIHJlY29yZA0KdW1jIGNvcnJlY3RhYmxlIGVycm9yIGFkZHJlc3MgaW4gRWNjSW5mbyB0YWJs
ZSwNCmRyaXZlciBzaWRlIGFkZCBlY2N0YWJsZV92MiB0byBzdXBwb3J0IHRoaXMgZmVhdHVyZQ0K
DQpTaWduZWQtb2ZmLWJ5OiBTdGFubGV5LllhbmcgPFN0YW5sZXkuWWFuZ0BhbWQuY29tPG1haWx0
bzpTdGFubGV5LllhbmdAYW1kLmNvbT4+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcmFzLmggICAgICAgfCAgIDEgKw0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dz
bXUvaW5jL2FtZGdwdV9zbXUuaCB8ICAgMiArDQogLi4uL2luYy9wbWZ3X2lmL3NtdTEzX2RyaXZl
cl9pZl9hbGRlYmFyYW4uaCAgIHwgIDE1ICsrKw0KIC4uLi9kcm0vYW1kL3BtL3N3c211L3NtdTEz
L2FsZGViYXJhbl9wcHQuYyAgICB8IDEwMSArKysrKysrKysrKysrKy0tLS0NCiAuLi4vZ3B1L2Ry
bS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wLmMgICAgfCAgIDIgKw0KIDUgZmlsZXMgY2hh
bmdlZCwgOTggaW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmggYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcmFzLmgNCmluZGV4IGI5YTZmYWMyYjhiMi4uMjhlNjAzMjQzYjY3
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5oDQor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmgNCkBAIC0zMjgsNiAr
MzI4LDcgQEAgc3RydWN0IGVjY19pbmZvX3Blcl9jaCB7DQogICAgICAgICB1aW50MTZfdCBjZV9j
b3VudF9oaV9jaGlwOw0KICAgICAgICAgdWludDY0X3QgbWNhX3VtY19zdGF0dXM7DQogICAgICAg
ICB1aW50NjRfdCBtY2FfdW1jX2FkZHI7DQorICAgICAgIHVpbnQ2NF90IG1jYV9jZXVtY19hZGRy
Ow0KIH07DQoNCiBzdHJ1Y3QgdW1jX2VjY19pbmZvIHsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL3BtL3N3c211L2luYy9hbWRncHVfc211LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL3N3c211L2luYy9hbWRncHVfc211LmgNCmluZGV4IGE2YTdiNmMzMzY4My4uOWY3MjU3YWRh
NDM3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMvYW1kZ3B1
X3NtdS5oDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2luYy9hbWRncHVfc211
LmgNCkBAIC0zMjIsNiArMzIyLDcgQEAgZW51bSBzbXVfdGFibGVfaWQNCiAgICAgICAgIFNNVV9U
QUJMRV9QQUNFLA0KICAgICAgICAgU01VX1RBQkxFX0VDQ0lORk8sDQogICAgICAgICBTTVVfVEFC
TEVfQ09NQk9fUFBUQUJMRSwNCisgICAgICAgU01VX1RBQkxFX0VDQ0lORk9fVjIsDQogICAgICAg
ICBTTVVfVEFCTEVfQ09VTlQsDQogfTsNCg0KQEAgLTM0MCw2ICszNDEsNyBAQCBzdHJ1Y3Qgc211
X3RhYmxlX2NvbnRleHQNCiAgICAgICAgIHZvaWQgICAgICAgICAgICAgICAgICAgICAgICAgICAg
KmRyaXZlcl9wcHRhYmxlOw0KICAgICAgICAgdm9pZCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAqY29tYm9fcHB0YWJsZTsNCiAgICAgICAgIHZvaWQgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKmVjY190YWJsZTsNCisgICAgICAgdm9pZCAgICAgICAgICAgICAgICAgICAgICAgICAgICAq
ZWNjX3RhYmxlX3YyOyAgLy8gYWRhcHQgdG8gc211IHN1cHBvcnQgcmVjb3JkIG1jYV9jZXVtY19h
ZGRyDQogICAgICAgICB2b2lkICAgICAgICAgICAgICAgICAgICAgICAgICAgICpkcml2ZXJfc211
X2NvbmZpZ190YWJsZTsNCiAgICAgICAgIHN0cnVjdCBzbXVfdGFibGUgICAgICAgICAgICAgICAg
dGFibGVzW1NNVV9UQUJMRV9DT1VOVF07DQogICAgICAgICAvKg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvaW5jL3BtZndfaWYvc211MTNfZHJpdmVyX2lmX2FsZGVi
YXJhbi5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMvcG1md19pZi9zbXUxM19k
cml2ZXJfaWZfYWxkZWJhcmFuLmgNCmluZGV4IDBmNjdjNTZjMjg2My4uMjg2ODYwNGVmZjQ5IDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMvcG1md19pZi9zbXUx
M19kcml2ZXJfaWZfYWxkZWJhcmFuLmgNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dz
bXUvaW5jL3BtZndfaWYvc211MTNfZHJpdmVyX2lmX2FsZGViYXJhbi5oDQpAQCAtNTIyLDYgKzUy
MiwyMSBAQCB0eXBlZGVmIHN0cnVjdCB7DQogICAgICAgICBFY2NJbmZvX3QgIEVjY0luZm9bQUxE
RUJBUkFOX1VNQ19DSEFOTkVMX05VTV07DQogfSBFY2NJbmZvVGFibGVfdDsNCg0KK3R5cGVkZWYg
c3RydWN0IHsNCisgICAgICAgdWludDY0X3QgbWNhX3VtY19zdGF0dXM7DQorICAgICAgIHVpbnQ2
NF90IG1jYV91bWNfYWRkcjsNCisgICAgICAgdWludDY0X3QgbWNhX2NldW1jX2FkZHI7DQorDQor
ICAgICAgIHVpbnQxNl90IGNlX2NvdW50X2xvX2NoaXA7DQorICAgICAgIHVpbnQxNl90IGNlX2Nv
dW50X2hpX2NoaXA7DQorDQorICAgICAgIHVpbnQzMl90IGVjY1BhZGRpbmc7DQorfSBFY2NJbmZv
X3RfdjI7DQorDQordHlwZWRlZiBzdHJ1Y3Qgew0KKyAgICAgICBFY2NJbmZvX3RfdjIgIEVjY0lu
Zm9bQUxERUJBUkFOX1VNQ19DSEFOTkVMX05VTV07DQorfSBFY2NJbmZvVGFibGVfdF92MjsNCisN
CiAvLyBUaGVzZSBkZWZpbmVzIGFyZSB1c2VkIHdpdGggdGhlIGZvbGxvd2luZyBtZXNzYWdlczoN
CiAvLyBTTUNfTVNHX1RyYW5zZmVyVGFibGVEcmFtMlNtdQ0KIC8vIFNNQ19NU0dfVHJhbnNmZXJU
YWJsZVNtdTJEcmFtDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9z
bXUxMy9hbGRlYmFyYW5fcHB0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEz
L2FsZGViYXJhbl9wcHQuYw0KaW5kZXggMzhhZjY0OGNiODU3Li5lNThkZjk0OTBjZWMgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL2FsZGViYXJhbl9wcHQu
Yw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9hbGRlYmFyYW5fcHB0
LmMNCkBAIC04Miw2ICs4MiwxMiBAQA0KICAqLw0KICNkZWZpbmUgU1VQUE9SVF9FQ0NUQUJMRV9T
TVVfVkVSU0lPTiAweDAwNDQyYTAwDQoNCisvKg0KKyAqIFNNVSBzdXBwb3J0IG1jYV9jZXVtY19h
ZGRyIGluIEVDQ1RBQkxFIHNpbmNlIHZlcnNpb24gNjguNTUuMCwNCisgKiB1c2UgdGhpcyB0byBj
aGVjayBtY2FfY2V1bWNfYWRkciByZWNvcmQgd2hldGhlciBzdXBwb3J0DQorICovDQorI2RlZmlu
ZSBTVVBQT1JUX0VDQ1RBQkxFX1YyX1NNVV9WRVJTSU9OIDB4MDA0NDM3MDANCisNCiAvKg0KICAq
IFNNVSBzdXBwb3J0IEJBRCBDSEVOTkVMIGluZm8gTVNHIHNpbmNlIHZlcnNpb24gNjguNTEuMDAs
DQogICogdXNlIHRoaXMgdG8gY2hlY2sgRUNDVEFMRSBmZWF0dXJlIHdoZXRoZXIgc3VwcG9ydA0K
QEAgLTIzOSw2ICsyNDUsOSBAQCBzdGF0aWMgaW50IGFsZGViYXJhbl90YWJsZXNfaW5pdChzdHJ1
Y3Qgc211X2NvbnRleHQgKnNtdSkNCiAgICAgICAgIFNNVV9UQUJMRV9JTklUKHRhYmxlcywgU01V
X1RBQkxFX0VDQ0lORk8sIHNpemVvZihFY2NJbmZvVGFibGVfdCksDQogICAgICAgICAgICAgICAg
ICAgICAgICBQQUdFX1NJWkUsIEFNREdQVV9HRU1fRE9NQUlOX1ZSQU0pOw0KDQorICAgICAgIFNN
VV9UQUJMRV9JTklUKHRhYmxlcywgU01VX1RBQkxFX0VDQ0lORk9fVjIsIHNpemVvZihFY2NJbmZv
VGFibGVfdF92MiksDQorICAgICAgICAgICAgICAgICAgICAgICBQQUdFX1NJWkUsIEFNREdQVV9H
RU1fRE9NQUlOX1ZSQU0pOw0KKw0KW2tldmluXToNCnRoaXMgdGFibGUgbWFwcGluZyBpcyBub3Qg
bmVlZGVkLCB0aGUgcmVhc29uIGFzIGJlbG93Lg0KDQogICAgICAgICBzbXVfdGFibGUtPm1ldHJp
Y3NfdGFibGUgPSBremFsbG9jKHNpemVvZihTbXVNZXRyaWNzX3QpLCBHRlBfS0VSTkVMKTsNCiAg
ICAgICAgIGlmICghc211X3RhYmxlLT5tZXRyaWNzX3RhYmxlKQ0KICAgICAgICAgICAgICAgICBy
ZXR1cm4gLUVOT01FTTsNCkBAIC0yNTUsNiArMjY0LDEwIEBAIHN0YXRpYyBpbnQgYWxkZWJhcmFu
X3RhYmxlc19pbml0KHN0cnVjdCBzbXVfY29udGV4dCAqc211KQ0KICAgICAgICAgaWYgKCFzbXVf
dGFibGUtPmVjY190YWJsZSkNCiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQoNCisg
ICAgICAgc211X3RhYmxlLT5lY2NfdGFibGVfdjIgPSBremFsbG9jKHRhYmxlc1tTTVVfVEFCTEVf
RUNDSU5GT19WMl0uc2l6ZSwgR0ZQX0tFUk5FTCk7DQorICAgICAgIGlmICghc211X3RhYmxlLT5l
Y2NfdGFibGVfdjIpDQorICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07Ow0KKw0KDQpba2V2
aW5dOg0KDQphZGQgZWNjaW5mbyB0YWJsZSB2MiBpcyBub3QgbmVlZGVkIGZvciB0aGlzIGNhc2Us
IHRoaXMgdGFibGUgaXMgb25seSB1c2VkIHN0b3JlIHRhYmxlIGRhdGEgZnJvbSBwbWZ3IHRvIGRy
aXZlciwNCnlvdSBjYW4gY3JlYXRlIGEgbGFyZ2UgZW5vdWdoIHRhYmxlIHdoaWNoIGNhbiBzYXZl
IGVjYyB0YWJsZSBkYXRhIGRpcmVjdGx5Lg0KDQplLmc6DQpzaXplID0gbWF4KHNpemVvZihFY2NJ
bmZvVGFibGVfdF92MiksIHNpemVvZihFY2NJbmZvVGFibGVfdCkpOw0Kc211X3RhYmxlLT5lY2Nf
dGFibGUgPSBremFsbG9jKHNpemUsIEdGUF9LRVJORUwpOw0KDQpCZXN0IFJlZ2FyZHMsDQpLZXZp
bg0KW1lhbmcsIFN0YW5sZXldIDogIHRoaXMgbWV0aG9kIGlzIG5vdCBmb3J3YXJkIGNvbXBhdGli
bGUsIG9yIGRyaXZlciBuZWVkIGNvbXBsZXggY29udmVydCB0byBnZXQgdGhlIGNvcnJlY3QgdmFs
dWUsIGlmIG5ldyBkcml2ZXIgdXNlIGFuIG9sZCBwbWZ3Lg0KDQogICAgICAgICByZXR1cm4gMDsN
CiB9DQoNCkBAIC0xODAyLDcgKzE4MTUsOCBAQCBzdGF0aWMgc3NpemVfdCBhbGRlYmFyYW5fZ2V0
X2dwdV9tZXRyaWNzKHN0cnVjdCBzbXVfY29udGV4dCAqc211LA0KICAgICAgICAgcmV0dXJuIHNp
emVvZihzdHJ1Y3QgZ3B1X21ldHJpY3NfdjFfMyk7DQogfQ0KDQotc3RhdGljIGludCBhbGRlYmFy
YW5fY2hlY2tfZWNjX3RhYmxlX3N1cHBvcnQoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpDQorc3Rh
dGljIGludCBhbGRlYmFyYW5fY2hlY2tfZWNjX3RhYmxlX3N1cHBvcnQoc3RydWN0IHNtdV9jb250
ZXh0ICpzbXUsDQorICAgICAgICAgICAgICAgaW50ICplY2N0YWJsZV92ZXJzaW9uKQ0KIHsNCiAg
ICAgICAgIHVpbnQzMl90IGlmX3ZlcnNpb24gPSAweGZmLCBzbXVfdmVyc2lvbiA9IDB4ZmY7DQog
ICAgICAgICBpbnQgcmV0ID0gMDsNCkBAIC0xODE1LDYgKzE4MjksMTEgQEAgc3RhdGljIGludCBh
bGRlYmFyYW5fY2hlY2tfZWNjX3RhYmxlX3N1cHBvcnQoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUp
DQoNCiAgICAgICAgIGlmIChzbXVfdmVyc2lvbiA8IFNVUFBPUlRfRUNDVEFCTEVfU01VX1ZFUlNJ
T04pDQogICAgICAgICAgICAgICAgIHJldCA9IC1FT1BOT1RTVVBQOw0KKyAgICAgICBlbHNlIGlm
IChzbXVfdmVyc2lvbiA+PSBTVVBQT1JUX0VDQ1RBQkxFX1NNVV9WRVJTSU9OICYmDQorICAgICAg
ICAgICAgICAgICAgICAgICBzbXVfdmVyc2lvbiA8IFNVUFBPUlRfRUNDVEFCTEVfVjJfU01VX1ZF
UlNJT04pDQorICAgICAgICAgICAgICAgKmVjY3RhYmxlX3ZlcnNpb24gPSAxOw0KKyAgICAgICBl
bHNlDQorICAgICAgICAgICAgICAgKmVjY3RhYmxlX3ZlcnNpb24gPSAyOw0KDQogICAgICAgICBy
ZXR1cm4gcmV0Ow0KIH0NCkBAIC0xODI0LDM2ICsxODQzLDcyIEBAIHN0YXRpYyBzc2l6ZV90IGFs
ZGViYXJhbl9nZXRfZWNjX2luZm8oc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsDQogew0KICAgICAg
ICAgc3RydWN0IHNtdV90YWJsZV9jb250ZXh0ICpzbXVfdGFibGUgPSAmc211LT5zbXVfdGFibGU7
DQogICAgICAgICBFY2NJbmZvVGFibGVfdCAqZWNjX3RhYmxlID0gTlVMTDsNCisgICAgICAgRWNj
SW5mb1RhYmxlX3RfdjIgKmVjY190YWJsZV92MiA9IE5VTEw7DQogICAgICAgICBzdHJ1Y3QgZWNj
X2luZm9fcGVyX2NoICplY2NfaW5mb19wZXJfY2hhbm5lbCA9IE5VTEw7DQogICAgICAgICBpbnQg
aSwgcmV0ID0gMDsNCisgICAgICAgaW50IHRhYmxlX3ZlcnNpb24gPSAwOw0KICAgICAgICAgc3Ry
dWN0IHVtY19lY2NfaW5mbyAqZWNjaW5mbyA9IChzdHJ1Y3QgdW1jX2VjY19pbmZvICopdGFibGU7
DQoNCi0gICAgICAgcmV0ID0gYWxkZWJhcmFuX2NoZWNrX2VjY190YWJsZV9zdXBwb3J0KHNtdSk7
DQorICAgICAgIHJldCA9IGFsZGViYXJhbl9jaGVja19lY2NfdGFibGVfc3VwcG9ydChzbXUsICZ0
YWJsZV92ZXJzaW9uKTsNCiAgICAgICAgIGlmIChyZXQpDQogICAgICAgICAgICAgICAgIHJldHVy
biByZXQ7DQoNCi0gICAgICAgcmV0ID0gc211X2Ntbl91cGRhdGVfdGFibGUoc211LA0KLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFNNVV9UQUJMRV9FQ0NJTkZPLA0KLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDAsDQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc211
X3RhYmxlLT5lY2NfdGFibGUsDQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmFsc2Up
Ow0KLSAgICAgICBpZiAocmV0KSB7DQotICAgICAgICAgICAgICAgZGV2X2luZm8oc211LT5hZGV2
LT5kZXYsICJGYWlsZWQgdG8gZXhwb3J0IFNNVSBlY2MgdGFibGUhXG4iKTsNCi0gICAgICAgICAg
ICAgICByZXR1cm4gcmV0Ow0KLSAgICAgICB9DQorICAgICAgIGlmICh0YWJsZV92ZXJzaW9uID09
IDEpIHsNCisgICAgICAgICAgICAgICByZXQgPSBzbXVfY21uX3VwZGF0ZV90YWJsZShzbXUsDQor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTTVVfVEFCTEVfRUNDSU5GTywN
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAsDQorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzbXVfdGFibGUtPmVjY190YWJsZSwNCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZhbHNlKTsNCisgICAgICAgICAgICAgICBp
ZiAocmV0KSB7DQorICAgICAgICAgICAgICAgICAgICAgICBkZXZfaW5mbyhzbXUtPmFkZXYtPmRl
diwgIkZhaWxlZCB0byBleHBvcnQgU01VIGVjYyB0YWJsZSFcbiIpOw0KKyAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIHJldDsNCisgICAgICAgICAgICAgICB9DQorDQorICAgICAgICAgICAg
ICAgZWNjX3RhYmxlID0gKEVjY0luZm9UYWJsZV90ICopc211X3RhYmxlLT5lY2NfdGFibGU7DQor
DQorICAgICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IEFMREVCQVJBTl9VTUNfQ0hBTk5FTF9O
VU07IGkrKykgew0KKyAgICAgICAgICAgICAgICAgICAgICAgZWNjX2luZm9fcGVyX2NoYW5uZWwg
PSAmKGVjY2luZm8tPmVjY1tpXSk7DQorICAgICAgICAgICAgICAgICAgICAgICBlY2NfaW5mb19w
ZXJfY2hhbm5lbC0+Y2VfY291bnRfbG9fY2hpcCA9DQorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGVjY190YWJsZS0+RWNjSW5mb1tpXS5jZV9jb3VudF9sb19jaGlwOw0KKyAgICAgICAg
ICAgICAgICAgICAgICAgZWNjX2luZm9fcGVyX2NoYW5uZWwtPmNlX2NvdW50X2hpX2NoaXAgPQ0K
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlY2NfdGFibGUtPkVjY0luZm9baV0uY2Vf
Y291bnRfaGlfY2hpcDsNCisgICAgICAgICAgICAgICAgICAgICAgIGVjY19pbmZvX3Blcl9jaGFu
bmVsLT5tY2FfdW1jX3N0YXR1cyA9DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVj
Y190YWJsZS0+RWNjSW5mb1tpXS5tY2FfdW1jX3N0YXR1czsNCisgICAgICAgICAgICAgICAgICAg
ICAgIGVjY19pbmZvX3Blcl9jaGFubmVsLT5tY2FfdW1jX2FkZHIgPQ0KKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBlY2NfdGFibGUtPkVjY0luZm9baV0ubWNhX3VtY19hZGRyOw0KKyAg
ICAgICAgICAgICAgIH0NCisgICAgICAgfSBlbHNlIGlmICh0YWJsZV92ZXJzaW9uID09IDIpIHsN
CisgICAgICAgICAgICAgICAvKiBzdGlsbCB1c2UgU01VX1RBQkxFX0VDQ19JTkZPIGluZGV4LA0K
KyAgICAgICAgICAgICAgICAqIHNtdSA2OC41NS4wIGFkZCBtY2FfY2V1bWNfYWRkciB2YXJpYWJs
ZQ0KKyAgICAgICAgICAgICAgICAqIGluIEVjY0luZm9fdCBzdHJ1Y3QgdG8gcmVwb3J0IGNvcnJl
Y3RhYmxlDQorICAgICAgICAgICAgICAgICogZXJyb3IgYWRkcmVzcyBhbmQgdGhlIHRhYmxlX2lk
IGlzIG5vdCBjaGFuZ2VkDQorICAgICAgICAgICAgICAgICovDQorICAgICAgICAgICAgICAgcmV0
ID0gc211X2Ntbl91cGRhdGVfdGFibGUoc211LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgU01VX1RBQkxFX0VDQ0lORk8sDQorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAwLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c211X3RhYmxlLT5lY2NfdGFibGVfdjIsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZmFsc2UpOw0KDQotICAgICAgIGVjY190YWJsZSA9IChFY2NJbmZvVGFibGVf
dCAqKXNtdV90YWJsZS0+ZWNjX3RhYmxlOw0KLQ0KLSAgICAgICBmb3IgKGkgPSAwOyBpIDwgQUxE
RUJBUkFOX1VNQ19DSEFOTkVMX05VTTsgaSsrKSB7DQotICAgICAgICAgICAgICAgZWNjX2luZm9f
cGVyX2NoYW5uZWwgPSAmKGVjY2luZm8tPmVjY1tpXSk7DQotICAgICAgICAgICAgICAgZWNjX2lu
Zm9fcGVyX2NoYW5uZWwtPmNlX2NvdW50X2xvX2NoaXAgPQ0KLSAgICAgICAgICAgICAgICAgICAg
ICAgZWNjX3RhYmxlLT5FY2NJbmZvW2ldLmNlX2NvdW50X2xvX2NoaXA7DQotICAgICAgICAgICAg
ICAgZWNjX2luZm9fcGVyX2NoYW5uZWwtPmNlX2NvdW50X2hpX2NoaXAgPQ0KLSAgICAgICAgICAg
ICAgICAgICAgICAgZWNjX3RhYmxlLT5FY2NJbmZvW2ldLmNlX2NvdW50X2hpX2NoaXA7DQotICAg
ICAgICAgICAgICAgZWNjX2luZm9fcGVyX2NoYW5uZWwtPm1jYV91bWNfc3RhdHVzID0NCi0gICAg
ICAgICAgICAgICAgICAgICAgIGVjY190YWJsZS0+RWNjSW5mb1tpXS5tY2FfdW1jX3N0YXR1czsN
Ci0gICAgICAgICAgICAgICBlY2NfaW5mb19wZXJfY2hhbm5lbC0+bWNhX3VtY19hZGRyID0NCi0g
ICAgICAgICAgICAgICAgICAgICAgIGVjY190YWJsZS0+RWNjSW5mb1tpXS5tY2FfdW1jX2FkZHI7
DQorICAgICAgICAgICAgICAgaWYgKHJldCkgew0KKyAgICAgICAgICAgICAgICAgICAgICAgZGV2
X2luZm8oc211LT5hZGV2LT5kZXYsICJGYWlsZWQgdG8gZXhwb3J0IFNNVSBlY2MgdGFibGVfdjIh
XG4iKTsNCisgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQorICAgICAgICAgICAg
ICAgfQ0KKw0KKyAgICAgICAgICAgICAgIGVjY190YWJsZV92MiA9IChFY2NJbmZvVGFibGVfdF92
MiAqKXNtdV90YWJsZS0+ZWNjX3RhYmxlX3YyOw0KKw0KKyAgICAgICAgICAgICAgIGZvciAoaSA9
IDA7IGkgPCBBTERFQkFSQU5fVU1DX0NIQU5ORUxfTlVNOyBpKyspIHsNCisgICAgICAgICAgICAg
ICAgICAgICAgIGVjY19pbmZvX3Blcl9jaGFubmVsID0gJihlY2NpbmZvLT5lY2NbaV0pOw0KKyAg
ICAgICAgICAgICAgICAgICAgICAgZWNjX2luZm9fcGVyX2NoYW5uZWwtPmNlX2NvdW50X2xvX2No
aXAgPQ0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlY2NfdGFibGVfdjItPkVjY0lu
Zm9baV0uY2VfY291bnRfbG9fY2hpcDsNCisgICAgICAgICAgICAgICAgICAgICAgIGVjY19pbmZv
X3Blcl9jaGFubmVsLT5jZV9jb3VudF9oaV9jaGlwID0NCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgZWNjX3RhYmxlX3YyLT5FY2NJbmZvW2ldLmNlX2NvdW50X2hpX2NoaXA7DQorICAg
ICAgICAgICAgICAgICAgICAgICBlY2NfaW5mb19wZXJfY2hhbm5lbC0+bWNhX3VtY19zdGF0dXMg
PQ0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlY2NfdGFibGVfdjItPkVjY0luZm9b
aV0ubWNhX3VtY19zdGF0dXM7DQorICAgICAgICAgICAgICAgICAgICAgICBlY2NfaW5mb19wZXJf
Y2hhbm5lbC0+bWNhX3VtY19hZGRyID0NCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ZWNjX3RhYmxlX3YyLT5FY2NJbmZvW2ldLm1jYV91bWNfYWRkcjsNCisgICAgICAgICAgICAgICAg
ICAgICAgIGVjY19pbmZvX3Blcl9jaGFubmVsLT5tY2FfY2V1bWNfYWRkciA9DQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGVjY190YWJsZV92Mi0+RWNjSW5mb1tpXS5tY2FfY2V1bWNf
YWRkcjsNCisgICAgICAgICAgICAgICB9DQogICAgICAgICB9DQoNCiAgICAgICAgIHJldHVybiBy
ZXQ7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVf
djEzXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wLmMN
CmluZGV4IGFlNjMyMWFmOWQ4OC4uYWYyZDg0YTE2ZjNlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzAuYw0KKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzAuYw0KQEAgLTU1Miw5ICs1NTIsMTEgQEAg
aW50IHNtdV92MTNfMF9maW5pX3NtY190YWJsZXMoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpDQog
ICAgICAgICBrZnJlZShzbXVfdGFibGUtPmhhcmRjb2RlX3BwdGFibGUpOw0KICAgICAgICAgc211
X3RhYmxlLT5oYXJkY29kZV9wcHRhYmxlID0gTlVMTDsNCg0KKyAgICAgICBrZnJlZShzbXVfdGFi
bGUtPmVjY190YWJsZV92Mik7DQogICAgICAgICBrZnJlZShzbXVfdGFibGUtPmVjY190YWJsZSk7
DQogICAgICAgICBrZnJlZShzbXVfdGFibGUtPm1ldHJpY3NfdGFibGUpOw0KICAgICAgICAga2Zy
ZWUoc211X3RhYmxlLT53YXRlcm1hcmtzX3RhYmxlKTsNCisgICAgICAgc211X3RhYmxlLT5lY2Nf
dGFibGVfdjIgPSBOVUxMOw0KICAgICAgICAgc211X3RhYmxlLT5lY2NfdGFibGUgPSBOVUxMOw0K
ICAgICAgICAgc211X3RhYmxlLT5tZXRyaWNzX3RhYmxlID0gTlVMTDsNCiAgICAgICAgIHNtdV90
YWJsZS0+d2F0ZXJtYXJrc190YWJsZSA9IE5VTEw7DQotLQ0KMi4xNy4xDQo=

--_000_BL1PR12MB533465DDC9B1BB06EAF269049AD49BL1PR12MB5334namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
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
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:DengXian;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;" a=
lign=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">Hi Kevin,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">Please ignore above mail, thanks your suggestion, I will t=
ry it.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">Stanley<o:p></o:p></span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;font-family:=CB=CE=CC=E5;color:black">=B7=A2=BC=FE=C8=CB</spa=
n></b><b><span lang=3D"EN-US" style=3D"font-size:12.0pt;color:black">:</spa=
n></b><span lang=3D"EN-US" style=3D"font-size:12.0pt;color:black"> amd-gfx
 &lt;amd-gfx-bounces@lists.freedesktop.org&gt; </span><span style=3D"font-s=
ize:12.0pt;font-family:=CB=CE=CC=E5;color:black">=B4=FA=B1=ED</span><span l=
ang=3D"EN-US" style=3D"font-size:12.0pt;color:black"> Yang, Stanley &lt;Sta=
nley.Yang@amd.com&gt;<br>
</span><b><span style=3D"font-size:12.0pt;font-family:=CB=CE=CC=E5;color:bl=
ack">=C8=D5=C6=DA</span></b><b><span lang=3D"EN-US" style=3D"font-size:12.0=
pt;color:black">:</span></b><span lang=3D"EN-US" style=3D"font-size:12.0pt;=
color:black">
</span><span style=3D"font-size:12.0pt;font-family:=CB=CE=CC=E5;color:black=
">=D0=C7=C6=DA=D2=BB</span><span lang=3D"EN-US" style=3D"font-size:12.0pt;c=
olor:black">, 2022</span><span style=3D"font-size:12.0pt;font-family:=CB=CE=
=CC=E5;color:black">=C4=EA</span><span lang=3D"EN-US" style=3D"font-size:12=
.0pt;color:black">5</span><span style=3D"font-size:12.0pt;font-family:=CB=
=CE=CC=E5;color:black">=D4=C2</span><span lang=3D"EN-US" style=3D"font-size=
:12.0pt;color:black">23</span><span style=3D"font-size:12.0pt;font-family:=
=CB=CE=CC=E5;color:black">=C8=D5</span><span style=3D"font-size:12.0pt;colo=
r:black">
</span><span style=3D"font-size:12.0pt;font-family:=CB=CE=CC=E5;color:black=
">=CF=C2=CE=E7</span><span lang=3D"EN-US" style=3D"font-size:12.0pt;color:b=
lack">6:16<br>
</span><b><span style=3D"font-size:12.0pt;font-family:=CB=CE=CC=E5;color:bl=
ack">=CA=D5=BC=FE=C8=CB</span></b><b><span lang=3D"EN-US" style=3D"font-siz=
e:12.0pt;color:black">:</span></b><span lang=3D"EN-US" style=3D"font-size:1=
2.0pt;color:black"> Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;, amd-g=
fx@lists.freedesktop.org
 &lt;amd-gfx@lists.freedesktop.org&gt;, Zhang, Hawking &lt;Hawking.Zhang@am=
d.com&gt;, Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;, Quan, Evan &lt;Evan.Quan@a=
md.com&gt;, Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
</span><b><span style=3D"font-size:12.0pt;font-family:=CB=CE=CC=E5;color:bl=
ack">=D6=F7=CC=E2</span></b><b><span lang=3D"EN-US" style=3D"font-size:12.0=
pt;color:black">:</span></b><span lang=3D"EN-US" style=3D"font-size:12.0pt;=
color:black">
</span><span style=3D"font-size:12.0pt;font-family:=CB=CE=CC=E5;color:black=
">=BB=D8=B8=B4</span><span lang=3D"EN-US" style=3D"font-size:12.0pt;color:b=
lack">: [PATCH Review 1/2] drm/amdgpu/pm: support mca_ceumc_addr in ecctabl=
e<o:p></o:p></span></p>
</div>
<p style=3D"margin:5.0pt"><span lang=3D"EN-US" style=3D"font-size:10.0pt;fo=
nt-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only -=
 General]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:=CB=CE=CC=E5"><o:p>&nbsp;</o:p></span></p>
<div>
<p style=3D"margin:5.0pt"><span lang=3D"EN-US" style=3D"font-size:10.0pt;fo=
nt-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only -=
 General]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:=CB=CE=CC=E5"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi Kevin,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span style=3D"font-family:DengXian">=B7=A2=BC=FE=
=C8=CB<span lang=3D"EN-US">:</span></span></b><span lang=3D"EN-US" style=3D=
"font-family:DengXian"> Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;
<br>
</span><b><span style=3D"font-family:DengXian">=B7=A2=CB=CD=CA=B1=BC=E4<spa=
n lang=3D"EN-US">:</span></span></b><span lang=3D"EN-US" style=3D"font-fami=
ly:DengXian"> Monday, May 23, 2022 4:49 PM<br>
</span><b><span style=3D"font-family:DengXian">=CA=D5=BC=FE=C8=CB<span lang=
=3D"EN-US">:</span></span></b><span lang=3D"EN-US" style=3D"font-family:Den=
gXian"> Yang, Stanley &lt;Stanley.Yang@amd.com&gt;; amd-gfx@lists.freedeskt=
op.org; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao.Zh=
ou1@amd.com&gt;;
 Quan, Evan &lt;Evan.Quan@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&g=
t;<br>
</span><b><span style=3D"font-family:DengXian">=D6=F7=CC=E2<span lang=3D"EN=
-US">:</span></span></b><span lang=3D"EN-US" style=3D"font-family:DengXian"=
> Re: [PATCH Review 1/2] drm/amdgpu/pm: support mca_ceumc_addr in ecctable<=
/span><span lang=3D"EN-US"><o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p style=3D"margin:5.0pt"><span lang=3D"EN-US" style=3D"font-size:10.0pt;fo=
nt-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only -=
 General]</span><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;color=
:black">&nbsp;</span><span lang=3D"EN-US"><o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 lang=3D"EN-US">
<hr size=3D"0" width=3D"100%" align=3D"center">
</span></div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"color:black">From:<=
/span></b><span lang=3D"EN-US" style=3D"color:black"> amd-gfx &lt;<a href=
=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">amd-gfx-bounces@lists.fre=
edesktop.org</a>&gt; on behalf of Stanley.Yang &lt;<a href=3D"mailto:Stanle=
y.Yang@amd.com">Stanley.Yang@amd.com</a>&gt;<br>
<b>Sent:</b> Monday, May 23, 2022 4:17 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;; Zhang, Hawking &lt;<a href=3D"mailto:Ha=
wking.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;;
 Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Tao.Zhou1@amd.com</a>&=
gt;; Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com">Evan.Quan@amd.com<=
/a>&gt;; Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar@a=
md.com</a>&gt;<br>
<b>Cc:</b> Yang, Stanley &lt;<a href=3D"mailto:Stanley.Yang@amd.com">Stanle=
y.Yang@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH Review 1/2] drm/amdgpu/pm: support mca_ceumc_addr in=
 ecctable</span><span lang=3D"EN-US">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">SMU add a new variable mca_ceum=
c_addr to record<br>
umc correctable error address in EccInfo table,<br>
driver side add ecctable_v2 to support this feature<br>
<br>
Signed-off-by: Stanley.Yang &lt;<a href=3D"mailto:Stanley.Yang@amd.com">Sta=
nley.Yang@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp;&nbsp; 1 +<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |&nbsp;&nbsp; 2 +<br>
&nbsp;.../inc/pmfw_if/smu13_driver_if_aldebaran.h&nbsp;&nbsp; |&nbsp; 15 ++=
+<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c&nbsp;&nbsp;&nbsp; | 101 ++=
++++++++++++----<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp; 2 +<br>
&nbsp;5 files changed, 98 insertions(+), 23 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h<br>
index b9a6fac2b8b2..28e603243b67 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
@@ -328,6 +328,7 @@ struct ecc_info_per_ch {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t ce_count_hi_chip;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t mca_umc_status;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t mca_umc_addr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t mca_ceumc_addr;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct umc_ecc_info {<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h<br>
index a6a7b6c33683..9f7257ada437 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
@@ -322,6 +322,7 @@ enum smu_table_id<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_TABLE_PACE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_TABLE_ECCINFO,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_TABLE_COMBO_PPTABLE,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_TABLE_ECCINFO_V2,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_TABLE_COUNT,<br>
&nbsp;};<br>
&nbsp;<br>
@@ -340,6 +341,7 @@ struct smu_table_context<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *driver_p=
ptable;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *combo_pp=
table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ecc_tabl=
e;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ecc_table_v2;&nbsp;=
 // adapt to smu support record mca_ceumc_addr<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *driver_s=
mu_config_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; tables[SMU_TABLE_COUNT];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldeb=
aran.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran=
.h<br>
index 0f67c56c2863..2868604eff49 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h<=
br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h<=
br>
@@ -522,6 +522,21 @@ typedef struct {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; EccInfo_t&nbsp; EccInfo[AL=
DEBARAN_UMC_CHANNEL_NUM];<br>
&nbsp;} EccInfoTable_t;<br>
&nbsp;<br>
+typedef struct {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t mca_umc_status;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t mca_umc_addr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t mca_ceumc_addr;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t ce_count_lo_chip;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t ce_count_hi_chip;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t eccPadding;<br>
+} EccInfo_t_v2;<br>
+<br>
+typedef struct {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; EccInfo_t_v2&nbsp; EccInfo[ALDEBARAN_=
UMC_CHANNEL_NUM];<br>
+} EccInfoTable_t_v2;<br>
+<br>
&nbsp;// These defines are used with the following messages:<br>
&nbsp;// SMC_MSG_TransferTableDram2Smu<br>
&nbsp;// SMC_MSG_TransferTableSmu2Dram<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
index 38af648cb857..e58df9490cec 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
@@ -82,6 +82,12 @@<br>
&nbsp; */<br>
&nbsp;#define SUPPORT_ECCTABLE_SMU_VERSION 0x00442a00<br>
&nbsp;<br>
+/*<br>
+ * SMU support mca_ceumc_addr in ECCTABLE since version 68.55.0,<br>
+ * use this to check mca_ceumc_addr record whether support<br>
+ */<br>
+#define SUPPORT_ECCTABLE_V2_SMU_VERSION 0x00443700<br>
+<br>
&nbsp;/*<br>
&nbsp; * SMU support BAD CHENNEL info MSG since version 68.51.00,<br>
&nbsp; * use this to check ECCTALE feature whether support<br>
@@ -239,6 +245,9 @@ static int aldebaran_tables_init(struct smu_context *sm=
u)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_TABLE_INIT(tables, SMU=
_TABLE_ECCINFO, sizeof(EccInfoTable_t),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SIZE, =
AMDGPU_GEM_DOMAIN_VRAM);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_TABLE_INIT(tables, SMU_TABLE_ECCI=
NFO_V2, sizeof(EccInfoTable_t_v2),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SIZE, AMDGP=
U_GEM_DOMAIN_VRAM);<br>
+<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[kevin]:<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">this table mapping is not neede=
d, the reason as below.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; smu_table-&gt;metrics_table =3D kzalloc(sizeof(SmuMetrics=
_t), GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_table-&gt;metrics=
_table)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
@@ -255,6 +264,10 @@ static int aldebaran_tables_init(struct smu_context *s=
mu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_table-&gt;ecc_tab=
le)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;ecc_table_v2 =3D kzallo=
c(tables[SMU_TABLE_ECCINFO_V2].size, GFP_KERNEL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_table-&gt;ecc_table_v2)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOMEM;;<br>
+<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[kevin]:<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">add eccinfo table v2 is not nee=
ded for this case, this table is only used store table data from pmfw to dr=
iver,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">you can create a large enough t=
able which can save ecc table data directly.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">e.g:<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">size =3D max(sizeof(<span style=
=3D"color:black;background:white">EccInfoTable_t_v2), sizeof(EccInfoTable_t=
));</span><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:black;background=
:white">smu_table-&gt;ecc_table =3D kzalloc(size, GFP_KERNEL);</span><span =
lang=3D"EN-US"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:black;background=
:white">Best Regards,</span><span lang=3D"EN-US"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Kevin<o:p></o:p></span></p>
<p class=3D"MsoNormal"><b><i><span lang=3D"EN-US">[Yang, Stanley] : &nbsp;t=
his method is not forward compatible, or driver need complex convert to get=
 the correct value, if new driver use an old pmfw.</span></i></b><span lang=
=3D"EN-US"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -1802,7 +1815,8 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_c=
ontext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sizeof(struct gpu_m=
etrics_v1_3);<br>
&nbsp;}<br>
&nbsp;<br>
-static int aldebaran_check_ecc_table_support(struct smu_context *smu)<br>
+static int aldebaran_check_ecc_table_support(struct smu_context *smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int *ecctable_version)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t if_version =3D 0x=
ff, smu_version =3D 0xff;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -1815,6 +1829,11 @@ static int aldebaran_check_ecc_table_support(struct =
smu_context *smu)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_version &lt; SUPPO=
RT_ECCTABLE_SMU_VERSION)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D -EOPNOTSUPP;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (smu_version &gt;=3D SUPPORT_=
ECCTABLE_SMU_VERSION &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_version &lt;=
 SUPPORT_ECCTABLE_V2_SMU_VERSION)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *ecctable_version =3D 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *ecctable_version =3D 2;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
@@ -1824,36 +1843,72 @@ static ssize_t aldebaran_get_ecc_info(struct smu_co=
ntext *smu,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
smu_table =3D &amp;smu-&gt;smu_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; EccInfoTable_t *ecc_table =
=3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; EccInfoTable_t_v2 *ecc_table_v2 =3D N=
ULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ecc_info_per_ch *ec=
c_info_per_channel =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, ret =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int table_version =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct umc_ecc_info *eccin=
fo =3D (struct umc_ecc_info *)table;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aldebaran_check_ecc_table_sup=
port(smu);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aldebaran_check_ecc_table_sup=
port(smu, &amp;table_version);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_update_table(smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; SMU_TABLE_ECCINFO,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;ecc_table,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; false);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info(smu-&gt;adev-&gt;dev, &quot;Failed to export SMU ecc ta=
ble!\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (table_version =3D=3D 1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_update_table(smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S=
MU_TABLE_ECCINFO,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
mu_table-&gt;ecc_table,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f=
alse);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(smu-&gt=
;adev-&gt;dev, &quot;Failed to export SMU ecc table!\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ecc_table =3D (EccInfoTable_t *)smu_table-&gt;ecc_table;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; ALDEBARAN_UMC_CHANNEL_NUM; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_info_per_cha=
nnel =3D &amp;(eccinfo-&gt;ecc[i]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_info_per_cha=
nnel-&gt;ce_count_lo_chip =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table-&gt;EccInfo[i].ce_count_lo_chip;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_info_per_cha=
nnel-&gt;ce_count_hi_chip =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table-&gt;EccInfo[i].ce_count_hi_chip;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_info_per_cha=
nnel-&gt;mca_umc_status =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table-&gt;EccInfo[i].mca_umc_status;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_info_per_cha=
nnel-&gt;mca_umc_addr =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table-&gt;EccInfo[i].mca_umc_addr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (table_version =3D=3D 2) {<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* still use SMU_TABLE_ECC_INFO index,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * smu 68.55.0 add mca_ceumc_addr variable<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * in EccInfo_t struct to report correctable<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * error address and the table_id is not changed<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_update_table(smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S=
MU_TABLE_ECCINFO,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
mu_table-&gt;ecc_table_v2,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; false);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table =3D (EccInfoTable_t *)smu_t=
able-&gt;ecc_table;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ALDEBARAN_UMC_CH=
ANNEL_NUM; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ecc_info_per_channel =3D &amp;(eccinfo-&gt;ecc[i]);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ecc_info_per_channel-&gt;ce_count_lo_chip =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table-&gt;Ec=
cInfo[i].ce_count_lo_chip;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ecc_info_per_channel-&gt;ce_count_hi_chip =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table-&gt;Ec=
cInfo[i].ce_count_hi_chip;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ecc_info_per_channel-&gt;mca_umc_status =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table-&gt;Ec=
cInfo[i].mca_umc_status;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ecc_info_per_channel-&gt;mca_umc_addr =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table-&gt;Ec=
cInfo[i].mca_umc_addr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(smu-&gt=
;adev-&gt;dev, &quot;Failed to export SMU ecc table_v2!\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ecc_table_v2 =3D (EccInfoTable_t_v2 *)smu_table-&gt;ecc_table_v2=
;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; ALDEBARAN_UMC_CHANNEL_NUM; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_info_per_cha=
nnel =3D &amp;(eccinfo-&gt;ecc[i]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_info_per_cha=
nnel-&gt;ce_count_lo_chip =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table_v2-&gt;EccInfo[i].ce_count_lo_chi=
p;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_info_per_cha=
nnel-&gt;ce_count_hi_chip =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table_v2-&gt;EccInfo[i].ce_count_hi_chi=
p;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_info_per_cha=
nnel-&gt;mca_umc_status =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table_v2-&gt;EccInfo[i].mca_umc_status;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_info_per_cha=
nnel-&gt;mca_umc_addr =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table_v2-&gt;EccInfo[i].mca_umc_addr;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_info_per_cha=
nnel-&gt;mca_ceumc_addr =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table_v2-&gt;EccInfo[i].mca_ceumc_addr;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
index ae6321af9d88..af2d84a16f3e 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
@@ -552,9 +552,11 @@ int smu_v13_0_fini_smc_tables(struct smu_context *smu)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;hardco=
de_pptable);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;hardcode_ppt=
able =3D NULL;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;ecc_table_v2);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;ecc_ta=
ble);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;metric=
s_table);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;waterm=
arks_table);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;ecc_table_v2 =3D NULL;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;ecc_table =
=3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;metrics_tabl=
e =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;watermarks_t=
able =3D NULL;<br>
-- <br>
2.17.1<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB533465DDC9B1BB06EAF269049AD49BL1PR12MB5334namp_--
