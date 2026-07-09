Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95808C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 09:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 144B010F4AD;
	Thu,  9 Jul 2026 09:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yQ9FN1cQ";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2B5310F4AD
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 09:57:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xeFJt0z3REWonAPLrcb3cIbKZ2jYpSwh+QblXljFGLMKMfxCDMQu+hiFUuKRvxROpXfbzR1l2LmoG4raeAN9SxyYTM7xRcu6IboZNk0F6nHAw06+HOMK2lJLExdV1ZwYD4MG7Ig82+TEut0Ys0VUD1l74BXNizTq1IlHnZwO9n8fupU0QU45cYndnLAapr7GOh4qgTfDLHZtDtpoNyXjxOgCaTWZ/k8cSWFBQ9ZSBJ5NPTQCluyLjK+Qj8AceeZiekAn2zPfY+lh0zA8NuDpsLvk+2v6qlAaOKrghgBJDkME3/lzG5taMLDn8M2+tKI/A4son/mNfMkQcXCT590YKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70NnmBEjOcBHOjnRLVT0lGkCQSxVvTIRJoducUvF+48=;
 b=aZdDUgyGZ3sekj6w5fW7WzISaKTvdq3IIb7LiTfbu85og838lAVS1J6G6k/8V6sMGGr5F4pDOQczbR9pmNaPnKDmZ7p/JcHn6hpl4UU2AjPTCxBwVJzJr2KeiU7MAd/S4375h2a7Ue3rfX3s5gF4hivgzQwD21sKdHtJbp4xo6FcOQJKVyrEg5flG03oo1MhPaMmOjO/izw2BKUdKtW8K/SJQE3tVWtOPHdSarW1OZA4L9xWdT4qcTWof0cSDDryK7v1wRDorET0/XfM04DcgEHH08l/CC4fbDUtiJQzqp9oWf6UQitvPbQJW4KVMp/6pTV4f97QP2SMU2EtR0JolQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70NnmBEjOcBHOjnRLVT0lGkCQSxVvTIRJoducUvF+48=;
 b=yQ9FN1cQj2EUmgN7csHwTygvFOr6qI/TXe84VeDsBMaZkzHGcY0e3KWnnsaUY4XiOeCx4mLHYo0x0jnt5Dr4FomaK/dHJoTzuxdb+WA2+/zpI9ilH6kB1lxo5ArXTXCl5j03PwaWHGO+zQpU09G4a/0ypyBo0gyB6aTn1fMhTok=
Received: from DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) by
 MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 09:57:49 +0000
Received: from DM4PR12MB5748.namprd12.prod.outlook.com
 ([fe80::6c62:e99c:480d:2729]) by DM4PR12MB5748.namprd12.prod.outlook.com
 ([fe80::6c62:e99c:480d:2729%2]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 09:57:49 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, John Olender <john.olender@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Remove vbios bounds check from
 pp_entries_max()
Thread-Topic: [PATCH] drm/amd/pm: Remove vbios bounds check from
 pp_entries_max()
Thread-Index: AQHdC52ZpVyGCwlSn0y4D/0mrYcqe7Zj2PoAgAEh3vA=
Date: Thu, 9 Jul 2026 09:57:48 +0000
Message-ID: <DM4PR12MB5748B149AA0BB0C5CE58BD3B8EFE2@DM4PR12MB5748.namprd12.prod.outlook.com>
References: <20260704101120.674980-1-john.olender@gmail.com>
 <CADnq5_ODf=T4VD9_RptQaEtJr5Zinsom8jW8GJL56GN6shvJsQ@mail.gmail.com>
In-Reply-To: <CADnq5_ODf=T4VD9_RptQaEtJr5Zinsom8jW8GJL56GN6shvJsQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: john.olender@gmail.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-09T09:55:13.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5748:EE_|MN2PR12MB4126:EE_
x-ms-office365-filtering-correlation-id: 22f9f13f-bc85-49b5-a14b-08dedda0889a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|38070700021|3023799007|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: E9Sn8egS6EvL0IcHgcdFZFGQFQSFFr+YwPpK+LMaM2a1lUGCr9HBp+2HjdEmjwqkjH3S8kpuXeRODFYIUnUAU9kqtGaEkL8WWeGhLe8pgbhw7dEnrh10j22a+uKPmSB4VdxEMhds1JW7Au2sgDgq3mkoQD8zTZ3sidB0BKAmVxqji0eW1k7K8oP8Xo1VvjmCmvg0SEVwyTMBqfMNtUXasI+lUl74BS0I2GRrt8Y5bhPlqc1vPWuGZa0zzR0Ey8CiTcJOQwFSKoxsdXYn9JcUQ+usQgDPjimN+eMKniuEXyG8RvY9WVnGDSZqrtNvP8tMvet8eqlIedPmUO9WnVwBgmZabYgGiuYPEAk2ZbD8XZYyz3VAMWAQ9xrJOhU7y70tmp3SBiVVN4lchQRGyQ8D9Fs7myS6JnVOVXmwvPzyCuM26ouYZvzgTfZKu+O+llcSovR8BKNqTYwScA3T/y7HdsFTCWNfopZd4d3xMrjYHoMXiZhXhimW7NBMLsNmijOI/ubcPdlphQKZAVTRCK9ukNQOAaDwwFJu9OHryUp/McXmC97BTelDu1G4tTgdAMtQ8GLXZlsvLQEcmgH5nmCfdWQp0NtPQCJJyWDqj63P7qx+66qhL+hv5Zxagr4PcgcgOOTbTBlPagi5O+206tIaUJa8vkXBVI6ZX5qL0/vmUkxy1gqIPqzqO7QfZ3Bj4DciL7jfRd7gLnYoiGUKczDJ8ldkyIqh8JLeM2bbh98uuVQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5748.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(38070700021)(3023799007)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0ZFVXBUTjBpS1ZoRk02SExzVndkUzdIZm9BY1JSVXhETEY3UG1MaHJobnlR?=
 =?utf-8?B?dmpxcmJEd05tS0FvUWNDbnNBSUZOamN4WDdrVHlGYzJsZkJ6MUtXOEI0RHFG?=
 =?utf-8?B?SSsxUFN1YVZRc2xtTnlRaTZzSndKRk9LTWJYMG96WHNCWnNROWJQSHkvZVND?=
 =?utf-8?B?SzZKVGZaK1l6dzBMMGQycW9hVlVYMXovZUIxR3JxL3V4NXJ2cGk3cktneFhF?=
 =?utf-8?B?WXNhZ1NWK1I2eS9GQzVNTksxN1hoSFliMStKOHQ0VU4ySkNxV2F2d2k4RG9T?=
 =?utf-8?B?RTJLMFhFOVMwbGVpMkdER1E5R3QvSTRXanFOMDFWUUN5SWpTOGN6bUxIV3g1?=
 =?utf-8?B?cG5GYW94bGwyZ3EzTXlHUnZ6QUtiSEtrcnpCY0RYb0tWU0ZBUHlGeVpKdytE?=
 =?utf-8?B?RnNXSis0bktraEhXeCtKYWxRWDJESXJoSm14Qnh0N0twdWFYNHJremNjVEJZ?=
 =?utf-8?B?UVhjNnB3enZiWDU2VGRpL1NwUDJCMS9ISEFHVTZGQml1RVo5cjBtZ3RVU2tx?=
 =?utf-8?B?SU1MREd5UjR5aW1DblZHMDdFdm1UcVJZaTVsNno5OG5aSHA3OEZNMzREU0Rp?=
 =?utf-8?B?cUZRR3BrWktySUJnMFJKN1JDTFVHb2Jpak5qdzRwRkVyY2JXQkdJMzBheHBP?=
 =?utf-8?B?dG9oUklwTEJqd3Z4WXhnSmYwNFo5d29ZQ2gxbENNeGZaUVN3YWJrNmFTU3la?=
 =?utf-8?B?L2Y5aWViMXVTdC9FWUtTZXFRWHR0b0pMc1QyQ3VHVGJNL3hpQk4rQUVrT2ZE?=
 =?utf-8?B?U1ErNTkzWStVbHdWVVBXUk13SkQ1cG5iK21mSFZPUSt4d1R4VWhUTDBjc3Jm?=
 =?utf-8?B?ZGFJQVg4WUZVdHhwWGluQW45SWlqZzg0eTY0ZWVsY2d1NGk2blhKdGoxSmxZ?=
 =?utf-8?B?WU5FaHBPL1ExVnBCaXUvTzR2UitnVFFGSTdLV3BRc1lZdGdBYjNnTFVvZFNV?=
 =?utf-8?B?WGZTMjBaMlNoaDNjMlNYUC9sTWx1QlNHSTUzMk44dFdDb0I5ZFg2Vm04am9C?=
 =?utf-8?B?VGNPbXFydTUyMjd0STR1MDRrWmhicDZWRWZEa3ZVUFdGS1IyWiszdWpSRklP?=
 =?utf-8?B?T3puTi9OZFo1MUU4YkVVYmQyYVFQTTI2RkJlK1dIKy9LL3pqYTB2bFhoaDhy?=
 =?utf-8?B?RG9MRlNzUVdQZzRvcDN6Z2kzNEJNMHpxU1VUa29VVzhMK0ZMMkJqeEsrSXJH?=
 =?utf-8?B?YXJIR25FNXB1cmtBSEl3RXA4VmVTN2pjVzZxYWJjR0lQMFZ1SUIrVkdraVA4?=
 =?utf-8?B?WUdqZWFKZURzalh5YmRyNnhIOTU5Ky83ck41S2xUNnVuMGZhUHpXWkQ3UEhB?=
 =?utf-8?B?VlJGbzRTNERKdjhEdk1jMCtsb0hhZmkzMVIrV3k5aVRnRStaRy8vQlJ6UXp5?=
 =?utf-8?B?MVUzSGFNOVcyamo5dVp1SVdxOWVoZm1VM2thajZtYloydGh6ajY4WWNVYXZZ?=
 =?utf-8?B?NmI1R21wdDJCMEhoak5iM2ZiWWV6Um16SkxKZlhRbWxGWGVQSDc1ck5sZmlC?=
 =?utf-8?B?RTdDcFRUTXhVQlVqNnREKzYzdm44eXl6cFhOZWR0L0ZLN3VCSnJaTGQrQXV1?=
 =?utf-8?B?WDBqNVRhY2ZJaXlwTDUrLy9walhDczBqQ0JiMGhsVzlkWHZyaXRURlA1TXRz?=
 =?utf-8?B?MjNGUkxOTFkrMTF1RDg5N2c3eHQwV0RpVGpNMlNYZHdwT01DQzJLeEhBM0NW?=
 =?utf-8?B?aVNLU250Qml4TXFlV3BZZm9uMllsKzI2NjByYmtZZVpla0IyK1FxdFNRQUd5?=
 =?utf-8?B?ZTFXT1d1WEVrOXNZUTdLZTY5NUNBM2FxOE9EYm03R3ErTnIyaTVWU2phMzkr?=
 =?utf-8?B?N1FNQlpKMHZsamtjSEFVSG1pZ21LeTIzMm1KM2puN08xTUE5eSsyMXB6K1Bs?=
 =?utf-8?B?WXJkUnJrVENHeHlmdEE3S1FnRmZpTmRBTHVnYVBCN1M4QlFrMUU3V1l4TzZl?=
 =?utf-8?B?akozSDJUajNwc2lkcTVIbEgyaWVienNmaVdUMVlpdjMxUzJKbDFGbXFyMy9a?=
 =?utf-8?B?ck5EaHo0OHhEWm9ySHBzemlRM3BMcjQzRDVaNjMwQXBOUUZVRlhqcFhNaXM1?=
 =?utf-8?B?dy81UzFyZXJPTHVZdnFQM3ZHZjRKSituZ01ZTWcwendhNitPUXVBRmJKVEky?=
 =?utf-8?B?R1ZBQnlCM00vbnZLenZrQjRIM0x5VDI5M1VqVEI3QTZjTnZxb2taWDZDUTV2?=
 =?utf-8?B?VGdqZVVDenBBMENRWFNEWWIyd1ZPUHNwOW40U283dHpXVmI0UTRZdDk3SmVt?=
 =?utf-8?B?REtHZFkrV0d2ZGpoNkdwU1k0SWtVUUI5MXl3N3prUGxXdUtyN3dLTC81UHJw?=
 =?utf-8?Q?dy+4cP6QhkDXvZvjf6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5748.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f9f13f-bc85-49b5-a14b-08dedda0889a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 09:57:48.8985 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cgt/gIgwyqf6xQy3l2LYnFv55302tAt5Lv/xY73cMh1cMwNtZKQwVeMWiOAxkSbMYz/+VW0NDeBRMUbz1bxwRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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

QU1EIEdlbmVyYWwNCg0KSGkgQEpvaG4gT2xlbmRlciwNCg0KR29vZCBjYXRjaC4gSG93ZXZlciwg
IGFzIEFsZXggcG9pbnRzIG91dCwgcmVtb3ZpbmcgdGhlIGNoZWNrIGVudGlyZWx5IGRyb3BzIHBy
b3RlY3Rpb24gZm9yIFZCSU9TLXNvdXJjZWQgdGFibGVzLg0KDQpJbnN0ZWFkIG9mIHJlbW92aW5n
IHRoZSBjaGVjaywgY291bGQgeW91IGNvbmRpdGlvbiBpdCBvbiBoYXJkY29kZV9wcF90YWJsZT8g
V2hlbiBpdCBpcyBOVUxMIHdlIGFyZSBvbiB0aGUgVkJJT1MgcGF0aCBhbmQgdGhlIGJpb3NfZW5k
IGNoZWNrIHNob3VsZCBzdGF5LiBXaGVuIGl0IGlzIG5vbi1OVUxMIGEgY3VzdG9tIHRhYmxlIHdh
cyB1cGxvYWRlZCB2aWEgc3lzZnMgYW5kIHRoZSBjaGVjayBjYW4gYmUgc2tpcHBlZCDigJQgc29m
dF9wcF90YWJsZV9zaXplIGlzIGFscmVhZHkgc2V0IHRvIHRoZSBrZXJuZWwtc3VwcGxpZWQgdXBs
b2FkIHNpemUuDQoNCmlmICghaHdtZ3ItPmhhcmRjb2RlX3BwX3RhYmxlKSB7DQogICAgICAgIGNv
bnN0IGNoYXIgKmJpb3NfZW5kID0gKGNvbnN0IGNoYXIgKilhZGV2LT5iaW9zICsgYWRldi0+Ymlv
c19zaXplOw0KICAgICAgICBpZiAocHBfZW5kID4gYmlvc19lbmQpDQogICAgICAgICAgICAgICAg
cmV0dXJuIDA7DQp9DQoNClRoaXMgZml4ZXMgeW91ciByZWdyZXNzaW9uIHdoaWxlIGtlZXBpbmcg
QWxleCdzIGNvbmNlcm4gYWRkcmVzc2VkLiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgaXQgb2sgd2l0
aCB5b3UuDQoNClRoYW5rcyAmIFJlZ2FyZHMNCkFzYWQNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
PiBPbiBCZWhhbGYgT2YgQWxleCBEZXVjaGVyDQpTZW50OiBXZWRuZXNkYXksIEp1bHkgOCwgMjAy
NiAxMDowOCBQTQ0KVG86IEpvaG4gT2xlbmRlciA8am9obi5vbGVuZGVyQGdtYWlsLmNvbT4NCkNj
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRmVuZywgS2VubmV0aCA8S2VubmV0aC5G
ZW5nQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+OyBLYW1hbCwgQXNhZCA8QXNhZC5LYW1hbEBhbWQuY29tPjsgTGF6YXIsIExpam8gPExpam8u
TGF6YXJAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBX
YW5nLCBZYW5nKEtldmluKSA8S2V2aW5ZYW5nLldhbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBb
UEFUQ0hdIGRybS9hbWQvcG06IFJlbW92ZSB2YmlvcyBib3VuZHMgY2hlY2sgZnJvbSBwcF9lbnRy
aWVzX21heCgpDQoNCk9uIFNhdCwgSnVsIDQsIDIwMjYgYXQgNjoxOeKAr0FNIEpvaG4gT2xlbmRl
ciA8am9obi5vbGVuZGVyQGdtYWlsLmNvbT4gd3JvdGU6DQo+DQo+IFRoZSBzb2Z0X3BwX3RhYmxl
IGlzIG5vdCBjb250YWluZWQgd2l0aGluIHRoZSB2YmlvcyB3aGVuIHVzaW5nIGENCj4gcHBfdGFi
bGUgb3ZlcnJpZGUgc2luY2UgY29tbWl0IDNjZmU0MzM2MzA1MDggKCJkcm0vYW1kL3BtOiBVc2UN
Cj4gdXBsb2FkZWQgc2l6ZSBmb3IgbGVnYWN5IGN1c3RvbSBQUFRhYmxlIikuDQo+DQo+IEZpeGVz
OiBlMzBiM2UzYWI1MWFkICgiZHJtL2FtZGdwdS9wbTogYWRkIHBwX2VudHJpZXNfbWF4KCkgaGVs
cGVyIikNCj4gU2lnbmVkLW9mZi1ieTogSm9obiBPbGVuZGVyIDxqb2huLm9sZW5kZXJAZ21haWwu
Y29tPg0KDQpSZW1vdmluZyB0aGlzIHdpbGwgZWZmZWN0aXZlbHkgcmVtb3ZlIHRoZSBib3VuZHMg
Y2hlY2sgZnJvbSB0YWJsZXMgcmVhZCBmcm9tIHRoZSBiaW9zLiAgSSBkb24ndCB0aGluayB3ZSB3
YW50IHRvIGRvIHRoYXQuDQoNCkFsZXgNCg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQv
cG0vcG93ZXJwbGF5L2luYy9od21nci5oIHwgNCAtLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBk
ZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93
ZXJwbGF5L2luYy9od21nci5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkv
aW5jL2h3bWdyLmgNCj4gaW5kZXggN2ViYzEzNDQwMjNmZi4uMTkwMjNhODUwZTg4MiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaW5jL2h3bWdyLmgNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaW5jL2h3bWdyLmgNCj4gQEAg
LTgzMywxNCArODMzLDEwIEBAIHN0YXRpYyBpbmxpbmUgdWludDMyX3QgcHBfZW50cmllc19tYXgo
Y29uc3Qgc3RydWN0IHBwX2h3bWdyICpod21nciwNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBjb25zdCB2b2lkICpzdWJfdGFibGUsDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc2l6ZV90IGhkcl9zaXplLCBzaXplX3QNCj4gcmVjX3NpemUp
ICB7DQo+IC0gICAgICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKilod21nci0+YWRldjsNCj4gLSAgICAgICBjb25zdCBjaGFyICpiaW9zX2VuZCA9
IChjb25zdCBjaGFyICopYWRldi0+YmlvcyArIGFkZXYtPmJpb3Nfc2l6ZTsNCj4gICAgICAgICBj
b25zdCBjaGFyICpwcF9lbmQgICA9IChjb25zdCBjaGFyICopaHdtZ3ItPnNvZnRfcHBfdGFibGUN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICsgaHdtZ3ItPnNvZnRfcHBfdGFibGVf
c2l6ZTsNCj4gICAgICAgICBjb25zdCBjaGFyICplbnRyaWVzICA9IChjb25zdCBjaGFyICopc3Vi
X3RhYmxlICsgaGRyX3NpemU7DQo+DQo+IC0gICAgICAgaWYgKHBwX2VuZCA+IGJpb3NfZW5kKQ0K
PiAtICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ICAgICAgICAgaWYgKCFyZWNfc2l6ZSB8fCBl
bnRyaWVzID49IHBwX2VuZCkNCj4gICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiAgICAgICAg
IHJldHVybiAodWludDMyX3QpKChwcF9lbmQgLSBlbnRyaWVzKSAvIHJlY19zaXplKTsNCj4NCj4g
YmFzZS1jb21taXQ6IGUzY2M4YzEwOGY5YTkxNzI4ZjlmZjZlMjRjYmYzYjQxYzU4YjhmOGINCj4g
LS0NCj4gMi40Ny4zDQo+DQo=
