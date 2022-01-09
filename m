Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE4AC433F5
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Jan 2022 10:27:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C42B10F25A;
	Sun,  9 Jan 2022 10:27:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67F1910F25A
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Jan 2022 10:27:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYNjyBXrLTVIaERI+xj2usJk+H+lXIxNRf80FU0xjiAxPOf0ljX7ndMJtspGE2nrezc0V4cjfNLxLRW5pkqjjv4YRcQHxvovlRyd06EBDvKWsh++xlKkiJIGgesQuIBtPwCv1wQ3O+lmX4Xy2+f53LdfHUT113X0vNDXjMGA42xXeVBVi6uuWYCDA5UBgBSFhHddvZFWiGXVWevW9WBEUTvFyVnmQlUN6re6hCmVpuPitaac/NmwslSPhkHuANFKKwybnddubQCumOHIzlHVXZbYC+3b5ctnG/qLlAOhSjLbGGQV1tlmXas8GmrhqyF+7UFXj53M7AKmqBys8stgTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/ibq/x3mtfeHk0/1tLT9lKNFaK+MZaBUV9wbmL9Ppw=;
 b=RTsAa6MVlhY9CCqNJdgun1GAYaFk0hVUZriMSRabyBQotY49WmGdiTqqCkCXZa7fkCaohbUsWDVmuU7Rmgcaqn0BOi4nsDsGCAqmVDxz6hIwl0GMqt5Er58k/Bjuyw/1CYoOSdV8Vd/ojMZZDwcuH9qc3LNUDN6SNrOGyC0keW7UsTRyGrm8M1vJ0JnU+cTe/dLTainUFHoHD/3b92v9fefGl9R4SnIJENlhTt7sCIOkFKZ26JkLIdQx+Ee5/NbIaz+tiEO0Zcm7WXwzfZ5fbok162GkiQ2OW1NaKBWfIRFnxgVPceAlqw3cCNmpUyEIxvbS9rrJvDZuOs3gd6f2zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/ibq/x3mtfeHk0/1tLT9lKNFaK+MZaBUV9wbmL9Ppw=;
 b=BhfYbaiL6dPMH6NedIYC5RzKB/SWQXNmeMA+HbrSLGJ+bwr//n9aQVOJ8DAS3cwfl7Dg3t5S924gCkWSWQqLEu4OoO4Q1W4SRtV+ecpUpLxPvO66fMqT3mW738WbOaDoFFHqF+qFoDqZFNGC7TXVUdAUCHsa68DMah86tzJoGpk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5114.namprd12.prod.outlook.com (2603:10b6:408:137::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Sun, 9 Jan
 2022 10:27:19 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f124:4f19:716f:e18]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f124:4f19:716f:e18%6]) with mapi id 15.20.4867.011; Sun, 9 Jan 2022
 10:27:19 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "StDenis, Tom" <Tom.StDenis@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Add pcie indirect support to
 amdgpu_mm_wreg_mmio_rlc()
Thread-Topic: [PATCH] drm/amd/amdgpu: Add pcie indirect support to
 amdgpu_mm_wreg_mmio_rlc()
Thread-Index: AQHYA782vPatll5F50u8MqRKJHI2b6xZoXEAgADdJlA=
Date: Sun, 9 Jan 2022 10:27:18 +0000
Message-ID: <BN9PR12MB5257EA84DCA357DCEAEA8E88FC4F9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220107120740.1041489-1-tom.stdenis@amd.com>
 <CADnq5_Puzsx67iFTxzitLCQ0EOBUm0Db-dn2Yj-N8XTNVWbGeg@mail.gmail.com>
In-Reply-To: <CADnq5_Puzsx67iFTxzitLCQ0EOBUm0Db-dn2Yj-N8XTNVWbGeg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-09T10:27:15Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=6127dda4-f657-47df-a689-57a54c834276;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 345905cb-61e0-4b43-2d6e-08d9d35a9d5f
x-ms-traffictypediagnostic: BN9PR12MB5114:EE_
x-microsoft-antispam-prvs: <BN9PR12MB51144FB891C45A65DFEEA086FC4F9@BN9PR12MB5114.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cHqh/ckT3h/DO8Wh/agp9366mTPLCXhezO9OnFtNgzmJ53gqBN1MPn+P6zExw90M6HHNB1lzg0Q0HQrDfX+qQcIq7lPLJDwYXK2hdEhCJApukHyMW+YI+9Xy0LABezPwai/cjBeaCZeRwiELH/VYlXOFDdSI5BINYBw2rW7c5jvGQD1o7qyhSuLyscOhPZAzBpvf+GZ/+0JudGia0jnO1uhXStTh918BQq34QPNfMEZ1CsJwpefMlLT+P4EFn3EvFL8PpDqeRxgvhrvS4i2r7DaOdUrVsVAbJkUKbd+IFpe15L6Amok/QoRXNdbUkjD3bmkZdo0pRNi/ncxdxU4hWlZm3Fgp0Z3nB3e1W5+Q+ldamTkOCZcCmJZbxdfsemn33osE5EtEl7NTDUSJICbXQuNjTRSPCKjYTBxsBAIdx1h8gNVg1Cujy99knCKwob0wFN14BcatcA5Zs9zdagDSLNPvx2QFtdll7GSTUBBWJ9bpVOxL8TD/NM6yJlYTqRzDJm/ULwwvwPGaqcMrWQaO1nOI5AulgRWP8YXwJhF5sRLOT8yFYxOMm1MpYkIOkOcf/O95Qzt0v5J6OM69SjAqDbSUgfF7zFTCl1Qqz0JVLIKTvjONi5hkshQ1snja95cxrtx5YukzPd13APJ+NnQfJxJccZuZ5kOjCn/8wnQJlxguMe4pSLn4ZkquH5MLjEqjAKXz+sYkL7IAdqaCiRv74w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(186003)(110136005)(71200400001)(26005)(8936002)(316002)(6506007)(8676002)(53546011)(6636002)(5660300002)(86362001)(33656002)(2906002)(4326008)(55016003)(508600001)(66946007)(64756008)(66556008)(83380400001)(38070700005)(76116006)(66476007)(7696005)(122000001)(52536014)(66446008)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkxGOU9SWVNtai8xeWJuZG9KTlZIQUFPeit2TFM4NnpvTEpKUkZnUlgvOFN5?=
 =?utf-8?B?WjVLMjV0aUFJUUhhaUpaeW1wckp3NFM2b0prM3YxbHoyU1NweUh5elF1WFFB?=
 =?utf-8?B?WXVFdkZmSDlBeFNUYTkyVTJoeGZjWm5MdHFKNlhzMi9UUWdXNXlsbW9HQ3E2?=
 =?utf-8?B?WUlZamcrVVNTS29id1V6bGJVeUpGMU8ySkZZVkNCcGVvd1pOcG9sZUhtUi9W?=
 =?utf-8?B?YXliWWN0bUFTamtJeUNkc2xNaWJnUkd5dVpzR0dQTmdTUUhkTE5DcnJPUHB0?=
 =?utf-8?B?VXJtSHVrQ0M3aVErQld0K01pelE3cUJFWGFaWXkwOUNKNHp0MDltamxhUS80?=
 =?utf-8?B?MWJuNUlzTUs2M05oU2NmWGgrYjFJM283eisya0VUckttNTRkWGdiZjRhVjlk?=
 =?utf-8?B?U0prSk5DVDNZUkVGU3NrVUxkUFpEcmlZdDhXNmxqZEJ0UTcrRDB5Y0V2cHZm?=
 =?utf-8?B?QjFUSC9UenpPZk9sb2xsRkpCQkhYdldFUDB5Q2dmRWsxYVVKd3o2VjZIWVVO?=
 =?utf-8?B?dVVBZUxkbXNpcWNqbVdyTXYwUXo0ZE5Qc0lnWXNYcUVsVzRGMm1GZjdmdERq?=
 =?utf-8?B?ZEVuNzZuYi8xZEZ3cHhaUWJJWTEwdWRrM3F4OE1DcFZkZ1VaT3RZbHBTanFa?=
 =?utf-8?B?YklWSm8rQTBveldLZHlybjZCZVlTSk5pSlJyVS9ESHVXVTY4RlN3NXZNd3ZT?=
 =?utf-8?B?cnVRMnBBN0NacWdGcWtQZVo5V2NQVkRnUTY3dGhZR0Zwb1IyY2dSUlozRDdH?=
 =?utf-8?B?aDV5dDAxREtJTzk2bGRWVkRoNG9TMGg2cmk1aWRPZ0RLYTJuU3lTM2hlSkR2?=
 =?utf-8?B?bG5LRlRuUi9wWDBQb0E4NE1BbTYrSzBNd1FxYXlUUnlJQ29FS1hWS0E5dFJ4?=
 =?utf-8?B?bXNSSVBzTHZBdzhXT3BLU1pZdXFTRGZMMWRnTVVHZVBzZmdDaVZRQkZLYUVU?=
 =?utf-8?B?ZHRJbHc5ejBtbFRIRjZKRTYyYk1GN216TDYyS0xMT0ZCL2EyM24vR0ZPTWtF?=
 =?utf-8?B?b2w2eXFCZG5xZlF0YU9reFRXTTNOK1lhbjNIaWErcmphRzhTSkdtZU9RUmZi?=
 =?utf-8?B?dUU3Z1hJT2U2RjBtYnAvaFE0T0tFekY0WkVaZHU2TDVmeFpCU0EraEVRRWxn?=
 =?utf-8?B?ZGpkQmUzZHpId2VpaWhwRTlRd0ZranJOeGhBTUJQZll6TTNxaW5NMEl2Y1Zh?=
 =?utf-8?B?UklKR09ReUw5R0Z6dUJ5QXFVc0xsc2lRTEJFQ2c4WVpSZXZPUFdieFhFTGRa?=
 =?utf-8?B?U0NLUHh1UHR4UWdOSUluWUh3UmFhQ2dRN3ZHMEVMUnQ3RTB3ajIwdWtUbFhK?=
 =?utf-8?B?VjNQbjZUbERXc1RJRGp0RE45SEtuVFUyc2s5Q1hrS0l3QVJiSDJFY2ZWemJk?=
 =?utf-8?B?L0NpUUsybm1MRXFHb3ZCYkwydkV2b2FwYy9yQXg1L1AwSVFNcWkxMGRvVnVn?=
 =?utf-8?B?VzFYK3NjZFhqY0kvZDlUTFdzOEFmUllIaEpKa0Z5UzdXZ0hnMXl5MW1wenIy?=
 =?utf-8?B?OVIvWVJzRGtIdUhLRUJkNXNDVmxIR2g2ZHdzb2h6bDRhcXE5VjNSTysxQlgy?=
 =?utf-8?B?UUEwTU94a1Q2dFhEYXduS1VwdGRSUnJRaUVJWTdreXNLQzhpUG5CNXlwM2VU?=
 =?utf-8?B?RzN5RG9xaXNHdlVBcXMyZ0hZSDZVb05Ba2RXQnR4bXVRcFl6REtwSjd6QmxZ?=
 =?utf-8?B?b3hPV2RzbDlpMm1YZTVWWkJDblZGQ3MrRlhRSjc0L1lyNmVmOFVyWVZVaHZS?=
 =?utf-8?B?UjgxRGhwNE0xK1ZSTGVTSGllSnRDWWZ0Tjd0VitlZGhaQTRpcGh5YkdhMW1x?=
 =?utf-8?B?UzlQVXVnTmRLZVhmRlhVK21yQ2RPbkg5SVo2ZjBBQkVDcHFLeEtZa096UWJ0?=
 =?utf-8?B?N3k5amY3TTZsd0JLSlJVRm9YRkZFQXBvTEN0K2RGZkZzRVg3YXFZTTFJUXBy?=
 =?utf-8?B?OVJncXNNRFBreTRqMUtIa3BUUThKTTRNc1kveVNTd0g2dE4yWUhGcWtHb083?=
 =?utf-8?B?RmFNUUdRb0k0Qnk3NlltdHJYWXpoSFh1dTVXdzcySm12RjVmc2toR0lnUUFC?=
 =?utf-8?B?WkJ3U1B1TTN2UXZXbkVaTkYzZEZMVkxYd0R6MG5FZ0VvWUFsdWFFNmpLSUVG?=
 =?utf-8?B?U1RwL3hLKy8xdG9OQ29zQ3hZTEs0Uko3QmlDNG9qMkNoWHBZUnFGandubEVW?=
 =?utf-8?Q?M9hoiOWuMFYHASNVmXXUlM8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345905cb-61e0-4b43-2d6e-08d9d35a9d5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2022 10:27:18.9151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6b6cvc/l0oZBPbcBBCE0G3OHpCsRlltouY8ntA2Hpw7VCMmWPVhKk7fSG4h0IfejgGLBOX8R4kMkbY0pB46NNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5114
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KUkUgLSBBY3R1YWxseSwgZm9yIG9sZGVyIGFzaWNz
LCB3ZSBzaG91bGRuJ3Qgd2UgYmUgdXNpbmcgbW1JTkRFWC9tbURBVEEgcmF0aGVyIHRoYW4gdGhl
IHBjaWUgaW5kaXJlY3QgcmVnaXN0ZXJzPyAgT3IgaXMgdGhhdCBoYW5kbGVkIGFscmVhZHkgc29t
ZWhvdz8NCg0KSSByZW1lbWJlciB3ZSBjaGVja2VkIHRoaXMgd2l0aCBodyB0ZWFtIGJlZm9yZSAo
bWlnaHQgdHdvIHllYXJzIGFnbyB3aGVuIG1ha2UgdGhlIGNoYW5nZSBpbiBhbWRncHVfZGV2aWNl
X3JyZWcvd3JlZyBoZWxwZXIpLiBUaGUgYW5zd2VyIHdhcyBpdCBpcyBzYWZlIHRvIHJldGlyZSBt
bUlOREVYL0RBVEEgYXBwcm9hY2ggZm9yIFNJIGFuZCBvbndhcmRzLiBQQ0lFX0lOREVYL0RBVEEg
c2hvdWxkIGJlIGdvb2QgZW5vdWdoIGZvciBpbmRpcmVjdCBhY2Nlc3MgaW4gYW1kZ3B1IGRyaXZl
ci4gRm9yIHJhZGVvbiBkcml2ZXIsIG1tSU5ERVgvbW1EQVRBIHNoYWxsIHN0aWxsIGJlIGtlcHQu
DQoNClJlZ2FyZHMsDQpIYXdraW5nDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTog
YW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxm
IE9mIEFsZXggRGV1Y2hlcg0KU2VudDogU3VuZGF5LCBKYW51YXJ5IDksIDIwMjIgMDU6MTMNClRv
OiBTdERlbmlzLCBUb20gPFRvbS5TdERlbmlzQGFtZC5jb20+DQpDYzogYW1kLWdmeCBsaXN0IDxh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9h
bWQvYW1kZ3B1OiBBZGQgcGNpZSBpbmRpcmVjdCBzdXBwb3J0IHRvIGFtZGdwdV9tbV93cmVnX21t
aW9fcmxjKCkNCg0KT24gRnJpLCBKYW4gNywgMjAyMiBhdCA3OjA3IEFNIFRvbSBTdCBEZW5pcyA8
dG9tLnN0ZGVuaXNAYW1kLmNvbT4gd3JvdGU6DQo+DQo+IFRoZSBmdW5jdGlvbiBhbWRncHVfbW1f
d3JlZ19tbWlvX3JsYygpIGlzIHVzZWQgYnkgZGVidWdmcyB0byB3cml0ZSB0byANCj4gTU1JTyBy
ZWdpc3RlcnMuICBJdCBkaWRuJ3Qgc3VwcG9ydCByZWdpc3RlcnMgYmV5b25kIHRoZSBCQVIgbWFw
cGVkIA0KPiBNTUlPIHNwYWNlLiAgVGhpcyBhZGRzIHBjaWUgaW5kaXJlY3Qgd3JpdGUgc3VwcG9y
dC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29t
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8
IDQgKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
dmljZS5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0K
PiBpbmRleCBjMzhlMGU4NzA5MGIuLjUzYTA0MDk1YTZkYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBAQCAtNTUyLDcgKzU1Miw3IEBAIHZv
aWQgYW1kZ3B1X2RldmljZV93cmVnKHN0cnVjdCBhbWRncHVfZGV2aWNlIA0KPiAqYWRldiwgIH0N
Cj4NCj4gIC8qKg0KPiAtICogYW1kZ3B1X21tX3dyZWdfbW1pb19ybGMgLSAgd3JpdGUgcmVnaXN0
ZXIgZWl0aGVyIHdpdGggbW1pbyBvciB3aXRoIA0KPiBSTEMgcGF0aCBpZiBpbiByYW5nZQ0KPiAr
ICogYW1kZ3B1X21tX3dyZWdfbW1pb19ybGMgLSAgd3JpdGUgcmVnaXN0ZXIgZWl0aGVyIHdpdGgg
DQo+ICsgZGlyZWN0L2luZGlyZWN0IG1taW8gb3Igd2l0aCBSTEMgcGF0aCBpZiBpbiByYW5nZQ0K
PiAgICoNCj4gICAqIHRoaXMgZnVuY3Rpb24gaXMgaW52b2tlZCBvbmx5IHRoZSBkZWJ1Z2ZzIHJl
Z2lzdGVyIGFjY2Vzcw0KPiAgICovDQo+IEBAIC01NjcsNiArNTY3LDggQEAgdm9pZCBhbWRncHVf
bW1fd3JlZ19tbWlvX3JsYyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gICAgICAgICAg
ICAgYWRldi0+Z2Z4LnJsYy5mdW5jcy0+aXNfcmxjZ19hY2Nlc3NfcmFuZ2UpIHsNCj4gICAgICAg
ICAgICAgICAgIGlmIChhZGV2LT5nZngucmxjLmZ1bmNzLT5pc19ybGNnX2FjY2Vzc19yYW5nZShh
ZGV2LCByZWcpKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gYWRldi0+Z2Z4LnJs
Yy5mdW5jcy0+c3Jpb3Zfd3JlZyhhZGV2LCANCj4gcmVnLCB2LCAwLCAwKTsNCj4gKyAgICAgICB9
IGVsc2UgaWYgKChyZWcgKiA0KSA+PSBhZGV2LT5ybW1pb19zaXplKSB7DQo+ICsgICAgICAgICAg
ICAgICBhZGV2LT5wY2llX3dyZWcoYWRldiwgcmVnICogNCwgdik7DQoNCkFjdHVhbGx5LCBmb3Ig
b2xkZXIgYXNpY3MsIHdlIHNob3VsZG4ndCB3ZSBiZSB1c2luZyBtbUlOREVYL21tREFUQSByYXRo
ZXIgdGhhbiB0aGUgcGNpZSBpbmRpcmVjdCByZWdpc3RlcnM/ICBPciBpcyB0aGF0IGhhbmRsZWQg
YWxyZWFkeSBzb21laG93Pw0KDQpBbGV4DQoNCj4gICAgICAgICB9IGVsc2Ugew0KPiAgICAgICAg
ICAgICAgICAgd3JpdGVsKHYsICgodm9pZCBfX2lvbWVtICopYWRldi0+cm1taW8pICsgKHJlZyAq
IDQpKTsNCj4gICAgICAgICB9DQo+IC0tDQo+IDIuMzIuMA0KPg0K
