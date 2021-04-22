Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707BDC43461
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 13:45:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F251761459
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 13:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F251761459
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 903EF6EA93;
	Thu, 22 Apr 2021 13:45:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA1176E090
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 13:45:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZulsUBj1D6lI4s1EJ0i2MmuNI+EZ5VrkAeRwBe9hsJKs/0BCYS+4jAgpYBzZWSd6egWC9uuLUH+MYKjqywZjEig1hdizSFjgpd1UHd2kjcIRnDEdLdk69HcGJyqpJYuCMB0kLdg0SAFL5q0sNxvTdplB9Nn3vra+0djTu9tQFG3VsIiRVQADxy01MF+3ZQ1iID2iuVWSlAjpJradEpdqCjU+CsQtYWnbEvyIYoX72bT7kgLfcHnNv5B+Oau8y/wRl2NqD4o43h4A+422OfFk7yE8WnBQTWxK6aPs6YvTc9O7rnVqFFYhw8nd8zgRuEap8d23TDf2LQrNgv739SHQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOguZOOgT0pTCcf07bwLwJby3SzbbTlX9aAK8DMG5J8=;
 b=Rqn3DcL82XO59Mxf4UWT/a7JfJppM1ZaD95WlqdUagbWTIOdsubFDktR8jVkD132hySY4jO4K7ED7nJA+NvLIk68Mw6T2yIaxRZiOnpKaIe0AI5cfW0hPyJyM7bDlTlJfBAf0HM27Fm5EEFSFZGAGbDjBkGw574lUVpApw8IH5JVvoqNFeb+U7KpoPkmdGSIQ63/FI1TJoYka1h0u54/XTPSX/m0X8uTpdzK7k+/m7prxCv5q6YVyiIN7fsjM8UjcEfAfKYqwKeACJmHtcwmTOSaOjPYuv/04hfP+/CMort4x1g33GfcOj7E3/OnM2C9LxNoM9Izn0kzyKeRDgZZxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOguZOOgT0pTCcf07bwLwJby3SzbbTlX9aAK8DMG5J8=;
 b=ND6smmPyuJFR/cjVAiCcwjgcezOPKnP5ZgMTo7hGgpYOS+KmoNKeAGalqijTulFEs6csPEbgQ57Tsbdm1cIYOn0Y9ddM+YRAJhhamNf8lyeiOP4xZkU/NLiTV9b83c4AAwMsxExRUYth4gCHfgTkKatCbXxBIghssmBbwweOTMs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1416.namprd12.prod.outlook.com (2603:10b6:903:44::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 22 Apr
 2021 13:45:04 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4065.022; Thu, 22 Apr 2021
 13:45:04 +0000
Subject: Re: [PATCH 3/5] drm/amdgpu: create shadow bo using
 amdgpu_bo_create_shadow()
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
References: <20210422123545.2389-1-nirmoy.das@amd.com>
 <20210422123545.2389-3-nirmoy.das@amd.com>
 <5716d5b7-2272-e4b3-bf6f-ba9c0a2ff1ff@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <a2a3e0f7-92a3-fcab-859d-174331e892f4@amd.com>
Date: Thu, 22 Apr 2021 15:45:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <5716d5b7-2272-e4b3-bf6f-ba9c0a2ff1ff@gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN9PR12CA0005.namprd12.prod.outlook.com
 (2603:10b6:408:10c::15) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.6.1] (165.204.84.11) by
 BN9PR12CA0005.namprd12.prod.outlook.com (2603:10b6:408:10c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Thu, 22 Apr 2021 13:45:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00904b27-c41e-48e0-2d7d-08d90594d54c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1416737F64859A3DACF991608B469@CY4PR12MB1416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PwvxKW2I7aLbHbWeAfYLqNvoHX291gMWGlDgChadDAxtVRQ0ZdOxtMBuMdXXB1a/TDhpHb7xnkCuRbOIDa3/o/ZLbIwYiBZN90qykzA8ahZSD/W/ZU8ymmjuQwvE8Ln5U2zuQK9BDFcUN82pblL86sLaJQc8DwOyM6pFOlcxDXKJk1yxl3hDdrNVaujm77l2Yxjfls+13x7MF8hdLJlaNvgDph1uhYCuA4ng2DTAZMzWr45BLbavizLgTzvVt6eT9TWRW52h/qSAF3vFkivi7km2y9KrTbwnjnxd+fU2GgDwfciRCwOVZStDYVARQJPr21UqV4VmbdRTO09L5cRUL2iRArXaiSEGkuCxmISy/JDBuIkketVeDMdNHDo7EhiiGEGgOlCzUwGvNWb9paDqaVDBMTdcXz1ylbZ8o9UTZhtpx1F+67+3vJX13yf3wHAcAh7hX6O/DXArMDx6uJvJja51sd0EyowdUOBizNUuMWP8cHhxhFyPG2LX2J3ht8xj3pJ/l2zn9fDLFFztymKvSxSNnx4u82Z7e8ef065hTmklaO09HHuiQfbqgtVcacT5qfcFzhecYEydgrhws8RY99DZWKbOwQFAVmwQDLFDWttZdkIdu3J9IU0QMDU6TFBEVzy1sARz6xeLL1HmJ2P0ZxBciMgEo3SvX3YaLQwbUxLDU3RslwZSc9RtH0S7NuQkwriOunJpUvvwvxA0ddBLfCpn8TMqTW3FhI12sYYmEeI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(346002)(376002)(366004)(136003)(396003)(52116002)(53546011)(38350700002)(38100700002)(5660300002)(66556008)(66476007)(66574015)(26005)(4326008)(6486002)(2906002)(36756003)(110136005)(8936002)(316002)(8676002)(186003)(16576012)(478600001)(31686004)(16526019)(83380400001)(2616005)(66946007)(31696002)(956004)(6636002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VG4rd2tnZkhaSzBOUUpaMDhuZTZIVVRTNGdvb0lxV2hDVitDYmt6TVdrMFo3?=
 =?utf-8?B?UzFac3JBNTVyc0NwL2l2aUw1aUFYS1hXenk4ZmxLRFc0bXNWWHhFZ09XbXhj?=
 =?utf-8?B?TUxJNysvcmNob0ZqVXdSeU01UXpNbWdGT081SmUrejBORG0yVmZnNWw4Ny9E?=
 =?utf-8?B?V1JmZDJLT0tsWTZ1enB4dGhJN0QwUHViMCt3Ty9RbkFQdytjWjd2djRXakJk?=
 =?utf-8?B?NU1xa21RMVRnWkZ3TTQyZkt6b0M4TDVlRThyV09XSVVjY3grRjJvNEM3YXZ6?=
 =?utf-8?B?RGVGUnB2TzBxMThnYzE5YjRmaEZVL0c0b3NhN1BnWkZOMEtaTnhuWlhRMDdq?=
 =?utf-8?B?SDEwbS9WdUtYYnU4VWFSWkNiWk1IOHpoZlJGakV0RlRma08rdGNMZXFFajRV?=
 =?utf-8?B?V3pwYWhlMWxwSmQ5WHdCTHJLVXlUYU4zNWJLczFEaVlYVU9abktkRWwyaWZT?=
 =?utf-8?B?d3k3emxkdWJCZC8yV3BrUHhPV2gxSG5EbHdVT0F4TWFFM0tyTlZNb0lyZDZ5?=
 =?utf-8?B?MnNoVTJOYVNuMFN3STFDZEw0MTBaaUlLSDZqMDJKaG1YanN5UDJVNExyUkRI?=
 =?utf-8?B?czJtdFlCeUlqNk0zY0JXZTdHN3krREFzb1djeUlZSlZmMTlvVU9KMUdFcXRp?=
 =?utf-8?B?T3NhUnlZSjUyeXBROWNhc1Z4c3FQQ3lHQ2YrM05Bb1BIMUVRdGppYWg2UFNJ?=
 =?utf-8?B?ejZOTE9FM3ZTLzZ2dGpCM3k1enBFeE5qblh1ZUIvWmRqVGxYNUdHWGdvdnVU?=
 =?utf-8?B?bDAvSEYvRXlsMUx0bjhFa2xwcDQ2bHNSK3BsdStaZVlZOFNkU2R0Vng4SUxy?=
 =?utf-8?B?MjJkS0xjTGtyYnc3ZSt0b1dnUVVEamFBT1J5ZzFBbGY3VzlTSXpjbkFBY09I?=
 =?utf-8?B?MUI1Z2lselNKL0YwY3J6cXJ3SENTa0JLa3dBeFo4TVdPYnVvc2pZWllsZy9W?=
 =?utf-8?B?dkxNVHlwZ2ZWZ20wbEJmSGtIS1ZUVW9DMm11Qk4rUjRDWithRHZwQi9DbDVK?=
 =?utf-8?B?VG1tc2MvbWJUcFFpNm5McHhCVEZhWkNVZEhJM3ZqcndoNGtBdlNYSTFxRFJL?=
 =?utf-8?B?NU9hTE5pN25lV3NweVRQdk5zVXJROFltNmZqbXJ1cGJVSHhvQXBIajZhVzJT?=
 =?utf-8?B?SFJzQmpCRnl1aGhUMjZySlpZNlVncHFVdVpja3JUZjJwVE05VnhONHFpK29Q?=
 =?utf-8?B?azhFckhKVDBpY0pzNXdaZHlYbEwzODZvRnphUWZzOUZuS1dIZW54NUxHVFpF?=
 =?utf-8?B?a0hTaGNxTmxzWlhpUVpIQTIvSkd2VUxxVVVOREY1U2xXM2p0MEhjRmQrUUxt?=
 =?utf-8?B?MlNEcDRFcEtDWE5ycDB5TVg1cE0weEhEV055Y2I0Z3FlWUcvSFFRampqVGZN?=
 =?utf-8?B?ZmVRVXV4em51QXZsZlh3WDBhWHNpV1VERmZBY0U5NWVkbjVXNVcwQzhGMXFK?=
 =?utf-8?B?K1paSTBUdmFtU1hBbXpyUUJKR1RmTmFhMWFtWnovMHNJTHZuc05VRm9rbkcy?=
 =?utf-8?B?akxOSnprcnd6UjhuMzhRU0d4dHZLS2MzeDhFYzFlNEI3ekw3YkVvMmpnR2kx?=
 =?utf-8?B?Z2ZBblZDRzlwMWdQNlBpTS9TMnhtMzRyeDdvUUhoNGtYdjNTYWZwNUdlTmVw?=
 =?utf-8?B?RW5EQkhqYUFiMHZGRTZSVWdweEMySDdWSEdZY0cxZVNBa3Y2OEJEUkZCTTdX?=
 =?utf-8?B?MVYra2FPSG5YYzNsWFd2UlhPQlJkLzRJOXE5MUhkNFRKd1pyeGtuaGcvMWt5?=
 =?utf-8?Q?zAVR4taiijG9XffkVRE9o7tt7jrgMymJoRwdQ/H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00904b27-c41e-48e0-2d7d-08d90594d54c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 13:45:04.3103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hT26sD9IZX7zv44l5Y2zGvnRBinGnGuN9SUr6cFv92m/MFqcKGRkvpUcBW8ePuxV/gBJWG/YjF20loXOonpbdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1416
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDQvMjIvMjEgMjo0OCBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAyMi4wNC4y
MSB1bSAxNDozNSBzY2hyaWViIE5pcm1veSBEYXM6Cj4+IFNoYWRvdyBCT3MgYXJlIG9ubHkgbmVl
ZGVkIGZvciB2bSBjb2RlIHNvIGNhbGwgYW1kZ3B1X2JvX2NyZWF0ZV9zaGFkb3coKQo+PiBkaXJl
Y3RseSBpbnN0ZWFkIG9mIGRlcGVuZGluZyBvbiBhbWRncHVfYm9fY3JlYXRlKCkuCj4+Cj4+IFNp
Z25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KPj4gLS0tCj4+IMKg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgNzUgKysrKysrKysrKysr
KysrKystLS0tLS0tLS0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMoKyksIDI2
IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmMKPj4gaW5kZXggNmYwYTYwMTFjYjNkLi4wZTFkMDhhODhmNTQgMTAwNjQ0Cj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+IEBAIC04NTAsMzUgKzg1MCw2NCBAQCBzdGF0
aWMgaW50IGFtZGdwdV92bV9jbGVhcl9ibyhzdHJ1Y3QgCj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYs
Cj4+IMKgIH0KPj4gwqAgwqAgLyoqCj4+IC0gKiBhbWRncHVfdm1fYm9fcGFyYW0gLSBmaWxsIGlu
IHBhcmFtZXRlcnMgZm9yIFBEL1BUIGFsbG9jYXRpb24KPj4gKyAqIGFtZGdwdV92bV9ib19jcmVh
dGUgLSBjcmVhdGUgYm8gZm9yIFBEL1BUCj4KPiBCZXR0ZXIgbmFtZSB0aGF0IGFtZGdwdV92bV9w
dF9jcmVhdGUuCj4KPj4gwqDCoCAqCj4+IMKgwqAgKiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2lu
dGVyCj4+IMKgwqAgKiBAdm06IHJlcXVlc3Rpbmcgdm0KPj4gwqDCoCAqIEBsZXZlbDogdGhlIHBh
Z2UgdGFibGUgbGV2ZWwKPj4gwqDCoCAqIEBpbW1lZGlhdGU6IHVzZSBhIGltbWVkaWF0ZSB1cGRh
dGUKPj4gLSAqIEBicDogcmVzdWx0aW5nIEJPIGFsbG9jYXRpb24gcGFyYW1ldGVycwo+PiArICog
QGJvOiBwb2ludGVyIHRvIHRoZSBidWZmZXIgb2JqZWN0IHBvaW50ZXIKPj4gwqDCoCAqLwo+PiAt
c3RhdGljIHZvaWQgYW1kZ3B1X3ZtX2JvX3BhcmFtKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LCBzdHJ1Y3QgCj4+IGFtZGdwdV92bSAqdm0sCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaW50IGxldmVsLCBib29sIGltbWVkaWF0ZSwKPj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvX3BhcmFtICpicCkKPj4gK3N0
YXRpYyBpbnQgYW1kZ3B1X3ZtX2JvX2NyZWF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwK
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwK
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgbGV2ZWwsIGJvb2wgaW1tZWRp
YXRlLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfYm8g
KipibykKPj4gwqAgewo+PiAtwqDCoMKgIG1lbXNldChicCwgMCwgc2l6ZW9mKCpicCkpOwo+PiAr
wqDCoMKgIHN0cnVjdCBhbWRncHVfYm9fcGFyYW0gYnA7Cj4+ICvCoMKgwqAgYm9vbCBjcmVhdGVf
c2hhZG93ID0gZmFsc2U7Cj4+ICvCoMKgwqAgaW50IHI7Cj4+IMKgIC3CoMKgwqAgYnAtPnNpemUg
PSBhbWRncHVfdm1fYm9fc2l6ZShhZGV2LCBsZXZlbCk7Cj4+IC3CoMKgwqAgYnAtPmJ5dGVfYWxp
Z24gPSBBTURHUFVfR1BVX1BBR0VfU0laRTsKPj4gLcKgwqDCoCBicC0+ZG9tYWluID0gQU1ER1BV
X0dFTV9ET01BSU5fVlJBTTsKPj4gLcKgwqDCoCBicC0+ZG9tYWluID0gYW1kZ3B1X2JvX2dldF9w
cmVmZXJyZWRfcGluX2RvbWFpbihhZGV2LCBicC0+ZG9tYWluKTsKPj4gLcKgwqDCoCBicC0+Zmxh
Z3MgPSBBTURHUFVfR0VNX0NSRUFURV9WUkFNX0NPTlRJR1VPVVMgfAo+PiArwqDCoMKgIG1lbXNl
dCgmYnAsIDAsIHNpemVvZihicCkpOwo+PiArCj4+ICvCoMKgwqAgYnAuc2l6ZSA9IGFtZGdwdV92
bV9ib19zaXplKGFkZXYsIGxldmVsKTsKPj4gK8KgwqDCoCBicC5ieXRlX2FsaWduID0gQU1ER1BV
X0dQVV9QQUdFX1NJWkU7Cj4+ICvCoMKgwqAgYnAuZG9tYWluID0gQU1ER1BVX0dFTV9ET01BSU5f
VlJBTTsKPj4gK8KgwqDCoCBicC5kb21haW4gPSBhbWRncHVfYm9fZ2V0X3ByZWZlcnJlZF9waW5f
ZG9tYWluKGFkZXYsIGJwLmRvbWFpbik7Cj4+ICvCoMKgwqAgYnAuZmxhZ3MgPSBBTURHUFVfR0VN
X0NSRUFURV9WUkFNX0NPTlRJR1VPVVMgfAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgQU1ER1BVX0dF
TV9DUkVBVEVfQ1BVX0dUVF9VU1dDOwo+PiAtwqDCoMKgIGJwLT5ib19wdHJfc2l6ZSA9IHNpemVv
ZihzdHJ1Y3QgYW1kZ3B1X2JvKTsKPj4gK8KgwqDCoCBicC5ib19wdHJfc2l6ZSA9IHNpemVvZihz
dHJ1Y3QgYW1kZ3B1X2JvKTsKPj4gwqDCoMKgwqDCoCBpZiAodm0tPnVzZV9jcHVfZm9yX3VwZGF0
ZSkKPj4gLcKgwqDCoMKgwqDCoMKgIGJwLT5mbGFncyB8PSBBTURHUFVfR0VNX0NSRUFURV9DUFVf
QUNDRVNTX1JFUVVJUkVEOwo+PiArwqDCoMKgwqDCoMKgwqAgYnAuZmxhZ3MgfD0gQU1ER1BVX0dF
TV9DUkVBVEVfQ1BVX0FDQ0VTU19SRVFVSVJFRDsKPj4gwqDCoMKgwqDCoCBlbHNlIGlmICghdm0t
PnJvb3QuYmFzZS5ibyB8fCB2bS0+cm9vdC5iYXNlLmJvLT5zaGFkb3cpCj4+IC3CoMKgwqDCoMKg
wqDCoCBicC0+ZmxhZ3MgfD0gQU1ER1BVX0dFTV9DUkVBVEVfU0hBRE9XOwo+PiAtwqDCoMKgIGJw
LT50eXBlID0gdHRtX2JvX3R5cGVfa2VybmVsOwo+PiAtwqDCoMKgIGJwLT5ub193YWl0X2dwdSA9
IGltbWVkaWF0ZTsKPj4gK8KgwqDCoMKgwqDCoMKgIGNyZWF0ZV9zaGFkb3cgPSB0cnVlOwo+PiAr
Cj4+ICvCoMKgwqAgYnAudHlwZSA9IHR0bV9ib190eXBlX2tlcm5lbDsKPj4gK8KgwqDCoCBicC5u
b193YWl0X2dwdSA9IGltbWVkaWF0ZTsKPj4gwqDCoMKgwqDCoCBpZiAodm0tPnJvb3QuYmFzZS5i
bykKPj4gLcKgwqDCoMKgwqDCoMKgIGJwLT5yZXN2ID0gdm0tPnJvb3QuYmFzZS5iby0+dGJvLmJh
c2UucmVzdjsKPj4gK8KgwqDCoMKgwqDCoMKgIGJwLnJlc3YgPSB2bS0+cm9vdC5iYXNlLmJvLT50
Ym8uYmFzZS5yZXN2Owo+PiArCj4+ICsKPj4gK8KgwqDCoCByID0gYW1kZ3B1X2JvX2NyZWF0ZShh
ZGV2LCAmYnAsIGJvKTsKPj4gK8KgwqDCoCBpZiAocikKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVy
biByOwo+PiArwqDCoMKgIGlmICghdm0tPmlzX2NvbXB1dGVfY29udGV4dCAmJgo+PiArwqDCoMKg
wqDCoMKgwqAgIShhZGV2LT5mbGFncyAmIEFNRF9JU19BUFUpICYmCj4+ICvCoMKgwqDCoMKgwqDC
oCBjcmVhdGVfc2hhZG93KSB7Cj4KPiBCZXR0ZXIgZHJvcCB0aGUgY3JlYXRlX3Nob3cgZmxhZyBh
bmQganVzdCBhbHdheXMgY2hlY2sgaXQgbGlrZSB0aGlzOgo+Cj4gaWYgKHZtLT5pc19jb21wdXRl
X2NvbnRleHQgfHwgYWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVKQo+IMKgwqDCoCByZXR1cm4gMDsK
Pgo+IEFwYXJ0IGZyb20gdGhhdCBsb29rcyBnb29kIHRvIG1lLgoKClRoYW5rcyBDaHJpc3RpYW4s
IEkgd2lsbCByZXNlbmQgd2l0aCB5b3VyIHN1Z2dlc3Rpb25zLgoKCk5pcm1veQoKPgo+IENocmlz
dGlhbi4KPgo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKCFicC5yZXN2KQo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBXQVJOX09OKGRtYV9yZXN2X2xvY2soKCpibyktPnRiby5iYXNlLnJlc3YsCj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBOVUxM
KSk7Cj4+ICvCoMKgwqDCoMKgwqDCoCByID0gYW1kZ3B1X2JvX2NyZWF0ZV9zaGFkb3coYWRldiwg
YnAuc2l6ZSwgKmJvKTsKPj4gKwo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKCFicC5yZXN2KQo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkbWFfcmVzdl91bmxvY2soKCpibyktPnRiby5iYXNlLnJl
c3YpOwo+PiArCj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAocikgewo+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBhbWRncHVfYm9fdW5yZWYoYm8pOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gcjsKPj4gK8KgwqDCoMKgwqDCoMKgIH0KPj4gK8KgwqDCoCB9Cj4+ICsKPj4gK8KgwqDC
oCByZXR1cm4gMDsKPj4gwqAgfQo+PiDCoCDCoCAvKioKPj4gQEAgLTkwMSw3ICs5MzAsNiBAQCBz
dGF0aWMgaW50IGFtZGdwdV92bV9hbGxvY19wdHMoc3RydWN0IAo+PiBhbWRncHVfZGV2aWNlICph
ZGV2LAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJvb2wgaW1t
ZWRpYXRlKQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV92bV9wdCAqZW50cnkg
PSBjdXJzb3ItPmVudHJ5Owo+PiAtwqDCoMKgIHN0cnVjdCBhbWRncHVfYm9fcGFyYW0gYnA7Cj4+
IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9ibyAqcHQ7Cj4+IMKgwqDCoMKgwqAgaW50IHI7Cj4+
IMKgIEBAIC05MTksOSArOTQ3LDcgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYWxsb2NfcHRzKHN0
cnVjdCAKPj4gYW1kZ3B1X2RldmljZSAqYWRldiwKPj4gwqDCoMKgwqDCoCBpZiAoZW50cnktPmJh
c2UuYm8pCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4gwqAgLcKgwqDCoCBhbWRn
cHVfdm1fYm9fcGFyYW0oYWRldiwgdm0sIGN1cnNvci0+bGV2ZWwsIGltbWVkaWF0ZSwgJmJwKTsK
Pj4gLQo+PiAtwqDCoMKgIHIgPSBhbWRncHVfYm9fY3JlYXRlKGFkZXYsICZicCwgJnB0KTsKPj4g
K8KgwqDCoCByID0gYW1kZ3B1X3ZtX2JvX2NyZWF0ZShhZGV2LCB2bSwgY3Vyc29yLT5sZXZlbCwg
aW1tZWRpYXRlLCAmcHQpOwo+PiDCoMKgwqDCoMKgIGlmIChyKQo+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIHI7Cj4+IMKgIEBAIC0yNzg1LDcgKzI4MTEsNiBAQCBsb25nIGFtZGdwdV92bV93
YWl0X2lkbGUoc3RydWN0IGFtZGdwdV92bSAKPj4gKnZtLCBsb25nIHRpbWVvdXQpCj4+IMKgIGlu
dCBhbWRncHVfdm1faW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdw
dV92bSAqdm0sCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgdm1fY29udGV4dCwgdTMy
IHBhc2lkKQo+PiDCoCB7Cj4+IC3CoMKgwqAgc3RydWN0IGFtZGdwdV9ib19wYXJhbSBicDsKPj4g
wqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvICpyb290Owo+PiDCoMKgwqDCoMKgIGludCByLCBp
Owo+PiDCoCBAQCAtMjg0MywxMCArMjg2OCw4IEBAIGludCBhbWRncHVfdm1faW5pdChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAKPj4gKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtLAo+PiDCoMKgwqDC
oMKgIG11dGV4X2luaXQoJnZtLT5ldmljdGlvbl9sb2NrKTsKPj4gwqDCoMKgwqDCoCB2bS0+ZXZp
Y3RpbmcgPSBmYWxzZTsKPj4gwqAgLcKgwqDCoCBhbWRncHVfdm1fYm9fcGFyYW0oYWRldiwgdm0s
IGFkZXYtPnZtX21hbmFnZXIucm9vdF9sZXZlbCwgCj4+IGZhbHNlLCAmYnApOwo+PiAtwqDCoMKg
IGlmICh2bS0+aXNfY29tcHV0ZV9jb250ZXh0KQo+PiAtwqDCoMKgwqDCoMKgwqAgYnAuZmxhZ3Mg
Jj0gfkFNREdQVV9HRU1fQ1JFQVRFX1NIQURPVzsKPj4gLcKgwqDCoCByID0gYW1kZ3B1X2JvX2Ny
ZWF0ZShhZGV2LCAmYnAsICZyb290KTsKPj4gK8KgwqDCoCByID0gYW1kZ3B1X3ZtX2JvX2NyZWF0
ZShhZGV2LCB2bSwgYWRldi0+dm1fbWFuYWdlci5yb290X2xldmVsLAo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGZhbHNlLCAmcm9vdCk7Cj4+IMKgwqDCoMKgwqAgaWYgKHIpCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycm9yX2ZyZWVfZGVsYXllZDsKPgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
