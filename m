Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8146DC43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 13:59:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 127E310E5EA;
	Wed,  8 Jul 2026 13:59:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T/7dd5Iw";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010029.outbound.protection.outlook.com [52.101.56.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AC6510E5EA
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 13:59:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vziMnrAo86HcKc7QVBDVzHGBHY9sJOAHMon21PFrbrC1yfCGI5J370oVIlgeP68SAfy5AxHxrqLSDUmdcpGXtmexeclxS+KBCR8vMOs4KwN46XV0OxcDo/mFeSMMfUGB9OlEKNtxqHrYR7ixeBummD0LuDuZZ1fSsMcHfup2KhMZrN7uF5WFsgYiLJWR0VTMkZD1V2dwdDshnXTgrbzH25skrftt1CU4YCs/AXCD2C4SxhTyaObQ1FdRwjUuXQTM3cYUXLHitWOKnQjaLRViqp2k0jDfFQdVZzpBqN2rEyqPLmXKjR4nby53KvkKDzlTEO594611AhLVorm3f3t4ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpkbmQBOmJbnUbBNITLExqdH6IJmusPulzwb95wZU/Y=;
 b=LPtroEFeO3urC6Zm7Jt14wDaqTbAVrZ4OXn0WpfNMf0CmvHgdXxQ1dN/fyczvlZVyOqmrnQtG4vI4Wd9vDbQ5J1v1v/S1RBR9qzUQXTBVJggICztuuXetklOh/0ENAo0vdy8C8MDJImBtqdLNzF4gDD9h2Q8VabFHkUGKRLF9oihBJp7FFL3427g83MdFoQmCd12gPprd+kRoMdQTwaybQgXzLHH320/3UFAltT7G5bFu5/hCIKDwI8ujvl8Hu4meZJXAawVNb/S9y7qX8yOZdWoXTOuuwEjfh88nFH/XsmzdXfydO2No9SlaINWEL72nQu1tTeVVyyw0cNMowQHCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpkbmQBOmJbnUbBNITLExqdH6IJmusPulzwb95wZU/Y=;
 b=T/7dd5Iw89qkjrR+i2Cw0d2VXJOHUQc8VrXaVSgeVCduoF39IzBRPoGtpPc2rn1EtVmKoDibV0LlXQ9ljX3YX05JLpr6iEi9nRRzIhuVepWx8KVuhBBr/4q5B6AR0GLfIdq2FHMJbjLfkCaOUkfN7ie0rSv4xBC0/OIqlVnLy1Q=
Received: from CH0PR12MB5139.namprd12.prod.outlook.com (2603:10b6:610:be::9)
 by IA0PR12MB7721.namprd12.prod.outlook.com (2603:10b6:208:433::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 13:59:10 +0000
Received: from CH0PR12MB5139.namprd12.prod.outlook.com
 ([fe80::8715:80d8:e0b7:7bb1]) by CH0PR12MB5139.namprd12.prod.outlook.com
 ([fe80::8715:80d8:e0b7:7bb1%6]) with mapi id 15.21.0181.014; Wed, 8 Jul 2026
 13:59:09 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/6] drm/amdgpu: disallow gfxoff around gfx/compute/sdma
 KQ reset
Thread-Topic: [PATCH 4/6] drm/amdgpu: disallow gfxoff around gfx/compute/sdma
 KQ reset
Thread-Index: AQHdDh3AvMWGjfNghUm1UJ+FWIBQR7ZiL8sAgAF2GoA=
Date: Wed, 8 Jul 2026 13:59:09 +0000
Message-ID: <CH0PR12MB51392C204D64BC4663A27850F7FF2@CH0PR12MB5139.namprd12.prod.outlook.com>
References: <20260707143420.2104857-1-alexander.deucher@amd.com>
 <20260707143420.2104857-4-alexander.deucher@amd.com>
 <4730132e-8bd0-44c3-b639-3fb9e7f3c86f@amd.com>
In-Reply-To: <4730132e-8bd0-44c3-b639-3fb9e7f3c86f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-08T13:52:49.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5139:EE_|IA0PR12MB7721:EE_
x-ms-office365-filtering-correlation-id: c208c71d-c43a-4dac-5592-08dedcf9153e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|18002099003|4143699003|3023799007|56012099006|11063799006|22082099003;
x-microsoft-antispam-message-info: iqej8Eyk9dmO1EF4mlcOlwGgXmcq5/UkBsthdKpv5d/LTks119JAtDcczHBC5r2kw5lHBEWUYqZ1ygzK7ERlMJYFEWImIbmXVoC8Ll6IL2PE/UK31Ys0Q/f75GExhn92nU83hsjNKu34cNVPQer8rlYnQY7UaxkkvYNpx7vG0kXRvI7fY1fAaFVzdDhOqy2Wg2XgW5tYQSR9ieV5kTAQOu7LY6UK7KSUMwJDmJf49NPSck4rx9XkIg9EAkbKKWAD8DYd5EaiJ5u+Hnru+1VS2EJQS4LEkhmXeP6URFXggHDIcrJ/OmBoCx2b3xdMfSw0hHPoNHpjogCfb/EgdzjMj+0L2pb045n5zHPYB7KhQSgh+/AEmY/g/JxhKKqcq6J0xQEWjaAeTesguYvczgyCQBa+g4isUUkuBNUplcmRZvPC9IDKTY9LG/W1xtBNMQJvt8m3yeeNH3ui+PphRNsZBTB2wUkWn6kjE/lTCQTALs4B33z1dF+aLvQsYogogq4RyYB35NvZPRtsiF2MpCaIVp19qyYtL9TMdCN5/wIbGAL3YcbEQwY6bZfvSJNH3+nXpTy9bQkv0IC07cuNxok+6i8EjS9UjVulltPrUKinLMgAn/Y68CL6WZ8dNg51KieV3n9gmD4VrTc58Ci80StDEJoTSrMDBhwCcoNEGoxGsNentvjdggBa0QeHLUvuUauPVkk/gyX7qwFArqSBrIPrbuVNhjzraXtW91N1BPpwBGs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5139.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(18002099003)(4143699003)(3023799007)(56012099006)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SE9oT2d1bTNnUUFmWElrcmNlM2srQUc3dGpiTlQzM0E3Ui9HVGliaFVlWWsz?=
 =?utf-8?B?TlZZMk9tbnlTL0pQc25vN2crSDRtWHpRd2VDQU94bGxjbWxRcVdhaUpSMVl6?=
 =?utf-8?B?UmgwMVBlS29BVHE0Z1FONHZMNFRVTVIzNjJpbzZOUDVOa2REbDg3NzFRWm5J?=
 =?utf-8?B?Q0Z0ZzIvV2JMOWRNYWhRR3VJNDlUUTVIdGlDU1o0Vjd4NVRTclV3em91a1N2?=
 =?utf-8?B?QW5NZ1FmMXY0TDVkc21LeVNTZUpyUGZGcEE3NkR4MFJxaVYzbGdGbUpTa2dh?=
 =?utf-8?B?blZzK1lHQnpOZEMvT0FoTjJNMXY2aS9HNGtwQkFNa2wrZHZ5Y0tNak83WEt6?=
 =?utf-8?B?REhrVXJ0U0RJbk5CeDk4RmRDR25lbnBmMVo5WUJBdkd4WTVYcXVpZGRLQldY?=
 =?utf-8?B?TStBNmt2ajk1SFkzOEhGYzYyZnA0MTVnaHhxUmZoczJWa2d1S3VIamprb2o2?=
 =?utf-8?B?UzVBN05UTDVkanh5Mk15MWJtaktiY0YwbW54THVNOXRUbHc3NlVvR3I2T0R4?=
 =?utf-8?B?NFUwQmt4TWNWd0tWbGp4WndLU1IwOTcxZWc5Tk1zQXhaeGtKT0tFMGU1bDE2?=
 =?utf-8?B?TWpROCt0L0lVQkdaaUZ1OTlRQUlLYUI0Y1l6Q0o2VC9QMTY4SGZzVHJrd1ZY?=
 =?utf-8?B?NTY4RW1rL25BZkRGeEVkK0o0Z2RTb1Y4cWJQRUo0OEtoYW9QS25RbStaNXpH?=
 =?utf-8?B?bkdHTXU2dlc2eW5UL0Z1NzFyQWZoRURkbFc4cnU1YWpBNTNqNS8xdHhWbVpV?=
 =?utf-8?B?ckZ4L1ptVmpEejA1bUQ4N0hzYnlUWWU3cXRXZ09tQlB5NDkxWjhuUzF1WnY5?=
 =?utf-8?B?Nm43Q05yR1pDOWNPQ3R1SVBISDRncXlMNXlnQXkxZno4cDZjREhwa1Q5cGhk?=
 =?utf-8?B?SngvVU9YR0xKQUx6V3prOERhUm1Yb1R0K0N0Wi9jVEJoL1dhcXMzVEt6OExy?=
 =?utf-8?B?K2dGcWlqRXZRcnZWVDEzenRyVHNFVm5DL1JsZFBNT3duWCtFdFhqOWxWWi80?=
 =?utf-8?B?RlZtWEZOUEovY2gxelN6M2pQY3MzV0FZZG9TOUl6c2hzNWx4VUVzdDQ5UGRy?=
 =?utf-8?B?NnhZNVdsQU5Kb2I4RzNwYnlGZk1mVDMrVGp5TGpjdDNmb2tic3ZNM3NPVTdk?=
 =?utf-8?B?RzA3bU5hUDVkcDhuTFFBVjNxYlRIN1FybzJ5NUpiRFJWUkhJTEZTSzNDRnpi?=
 =?utf-8?B?eW84cWxoSHZ5aFlmbGprZFhTTVhrd0Q3VHBLTFYzU2RCNTVKdHdWUUtkUXNY?=
 =?utf-8?B?bUlkekJjalpUR3NsalBXUSs1RTNCRHBkZjJTdnJqSk41SFZSUDJ1dFlCRWZG?=
 =?utf-8?B?MnUrRTdvZ25UUkc3MVZGeUtKOUZvbGVKdVEvTzNUckMxM0plajJWZ3JRVFo1?=
 =?utf-8?B?YThMTGJ6RHBseWZMektpSGRCQzJhQ3RBTDlDdmhxQyt5U3FSQjMzeG5VVDZG?=
 =?utf-8?B?dHByUDlUNW9BaEtxQzBWamZydUN1b0JjRDhIUnBaUHZmOTJDRk1QVDhkZjVR?=
 =?utf-8?B?RThjUmp4R0VSdVlxTEhWUlk5elBWcWhGcSs5cjZDWDFSWWlVdHN6c1NhWGo1?=
 =?utf-8?B?alo2c09jKzh2UWwrNHVaMUtVc3ZFelBPR2N0ZStDUG9mQjROMDFPdlhTb05Z?=
 =?utf-8?B?bUliYjc0ODh3bnNuOGl5R3l2Y2o0K0dPNVpLb3pQUVNMeWl5SFdvNE0zTHJo?=
 =?utf-8?B?cjRZN1N2ZDVGeEJtazlzVm9Tamk3N0k3WUFRU0JTaytORk4wNzJyU05XcHM1?=
 =?utf-8?B?aEZqck11YWNrbGhJZVdPak5wYlQ5T0VqQUJ2akdyS3FNUVFmblBOUXBVTHJk?=
 =?utf-8?B?OFdTRUJrU2RXZjA5N0lLdXE0ZlZhVnNFOGNSTmxlNWZUM2lVNkdWSVR5a1BF?=
 =?utf-8?B?T2kwTDhORWdRN3RGYTlCajhNNHczTzFsTkVESXA1bXhiNmFIK3MyeXZ5U1E2?=
 =?utf-8?B?em5sQTU3Vk1tTnRaZVZhZGRaU3FITEFnSGhKTy9YSGxwdDB3UHpRTjFoRm9N?=
 =?utf-8?B?VEJURnVzM0hDQUY4c1RQSzZhQisvZ3ROeWJnREZDaHkrYm9uNzJSZEdDRjVo?=
 =?utf-8?B?OVFBeFQvemJtN05zK3k4ZStDRDlFd2NGYW1kOEY5SlZDMk93U2FuUHVzcHph?=
 =?utf-8?B?encxTTlBSCtreEMvUUJ2ZTdBcDZ6VUhYVGd6S2I0anc5b0pkUUMwUGwwZHVE?=
 =?utf-8?B?cXU5ZHdoaUNqS1RLNWxLcFRTM1paUHYrWDNVY1pGZkZDak03bElRMGxzVkY2?=
 =?utf-8?B?TlFYUjE3Q2I4VHZ6bzZ4dWVFaHFobjRoOElaVEdlYlNoUE50ZlE4Mkd3YVJQ?=
 =?utf-8?Q?mHFLbRyvuns1zdFF6y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5139.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c208c71d-c43a-4dac-5592-08dedcf9153e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 13:59:09.4265 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wxU1bxhwz6csrwrlWcmx7svguuGapdX53Lut1pM/ekRMkdgCnVpWMFPJNHAqeRPYFKSXf2aFrtLpxTdi0GeWug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7721
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXph
ciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDcsIDIw
MjYgMTE6MzQgQU0NCj4gVG86IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJA
YW1kLmNvbT47IGFtZC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIDQvNl0gZHJtL2FtZGdwdTogZGlzYWxsb3cgZ2Z4b2ZmIGFyb3VuZA0KPiBnZngv
Y29tcHV0ZS9zZG1hIEtRIHJlc2V0DQo+DQo+DQo+DQo+IE9uIDA3LUp1bC0yNiA4OjA0IFBNLCBB
bGV4IERldWNoZXIgd3JvdGU6DQo+ID4gSWYgdGhlIGVuZ2luZSBpcyBodW5nLCB3ZSBzaG91bGRu
J3QgbmVlZCB0aGlzIHNpbmNlIGl0IHdvbid0IGJlDQo+ID4gcG93ZXJlZCBkb3duLCBidXQgd2Ug
Y291bGQgcG90ZW50aWFsbHkgaGF2ZSBhIGNhc2Ugd2hlcmUgYSBxdWV1ZSBjYW4NCj4gPiBiZSBw
cmVlbXB0ZWQsIGJ1dCBkdWUgdG8gbG9naWMgZXJyb3JzIGluIHRoZSBjb21tYW5kcywgdGhlIGZl
bmNlIG5ldmVyDQo+ID4gc2lnbmFscy4gIFRoZSBlbmdpbmUgY291bGQgcG90ZW50aWFsbHkgZ28g
aW50byB0aGUgb2ZmIHN0YXRlLiAgUHJvdGVjdA0KPiA+IGFnYWluc3QgdGhhdC4NCj4NCj4gT24g
YSBzZWNvbmQgdGhvdWdodCwgaXMgdGhpcyBhIHJlYWwgY2FzZT8gSWYgZW5naW5lIGFscmVhZHkg
Z29lcyB0byBvZmYgc3RhdGUsDQo+IHdvdWxkbid0IGV2ZXJ5dGhpbmcgYmUgcmVzZXQgYnkgZGVm
YXVsdCBvbmNlIGl0IGNvbWVzIGJhY2s/DQoNCkknbSBub3Qgc3VyZSBpZiBnZnhvZmYgd2lsbCBh
Y3R1YWxseSBlbnRlciBvciBub3QsIGJ1dCBjb25zaWRlciB0aGUgY2FzZSBvZiBhbiBJQiB3aGlj
aCBpcyB3YWl0aW5nIGZvciBzb21lIG1lbW9yeSBsb2NhdGlvbi4gIEl0J3MganVzdCB3YWl0aW5n
IHNvIHRoZSBxdWV1ZSBjYW4gYmUgcHJlZW1wdGVkLCBidXQgd2hlbiBpdCdzIHJlc3VtZWQsIGl0
IGp1c3QgZ29lcyBiYWNrIHRvIHdhaXRpbmcgc28gaXQgbmVlZHMgdG8gYmUgcmVzZXQgZXZlbiB0
aG91Z2ggaXQncyBub3QgaHVuZyBwZXIgc2UgYmVjYXVzZSBpdCdzIGZlbmNlIHdpbGwgbmV2ZXIg
c2lnbmFsLiAgRm9yIGNvbXB1dGUgcXVldWVzIGF0IGxlYXN0LCB3ZSBwZWVtcHQgYWxsIHRoZSBx
dWV1ZXMgaW4gdGhlIHJlc2V0IGhhbmRsZXIgYW5kIHRoZW4gcmVzZXQgdGhlIGJhZCBxdWV1ZXMu
ICBJbiB0aGVvcnkgdGhlcmUgY291bGQgYmUgYSB3aW5kb3cgdGhlcmUgd2hlcmUgZ2Z4b2ZmIGVu
dHJ5IGNvdWxkIGhhcHBlbiBhbmQgdGhlbiB3ZSBtYXkgYWNjZXNzIGEgR0MgcmVnaXN0ZXIgdmlh
IE1NSU8gd2hlbiB3ZSByZXNldCBvbmUgb2YgdGhlIGJhZCBxdWV1ZXMuDQoNCkFsZXgNCg0KPg0K
PiBUaGFua3MsDQo+IExpam8NCj4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYyB8IDggKysrKysrKysNCj4gPiAgIDEgZmlsZSBj
aGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9qb2IuYw0KPiA+IGluZGV4IGI1YzJkMWQ0ZDg4MzkuLmM4YTFhYTg4YTlk
ZTAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pv
Yi5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jDQo+
ID4gQEAgLTEzNyw3ICsxMzcsMTUgQEAgc3RhdGljIGVudW0gZHJtX2dwdV9zY2hlZF9zdGF0DQo+
IGFtZGdwdV9qb2JfdGltZWRvdXQoc3RydWN0IGRybV9zY2hlZF9qb2IgKnNfam9iKQ0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgc19qb2ItPnNjaGVkLT5uYW1lKTsNCj4gPiAgICAgICAgICAgICAv
KiBTdG9wIHRoZSBzY2hlZHVsZXIgdG8gcHJldmVudCBhbnlib2R5IGVsc2UgZnJvbSB0b3VjaGlu
Zw0KPiB0aGUgcmluZyBidWZmZXIuICovDQo+ID4gICAgICAgICAgICAgZHJtX3NjaGVkX3dxdWV1
ZV9zdG9wKCZyaW5nLT5zY2hlZCk7DQo+ID4gKyAgICAgICAgICAgaWYgKHJpbmctPmZ1bmNzLT50
eXBlID09IEFNREdQVV9SSU5HX1RZUEVfR0ZYIHx8DQo+ID4gKyAgICAgICAgICAgICAgIHJpbmct
PmZ1bmNzLT50eXBlID09IEFNREdQVV9SSU5HX1RZUEVfQ09NUFVURSB8fA0KPiA+ICsgICAgICAg
ICAgICAgICByaW5nLT5mdW5jcy0+dHlwZSA9PSBBTURHUFVfUklOR19UWVBFX1NETUEpDQo+ID4g
KyAgICAgICAgICAgICAgICAgICBhbWRncHVfZ2Z4X29mZl9jdHJsKGFkZXYsIGZhbHNlKTsNCj4g
PiAgICAgICAgICAgICByID0gYW1kZ3B1X3JpbmdfcmVzZXQocmluZywgam9iLT52bWlkLCBqb2It
Pmh3X2ZlbmNlKTsNCj4gPiArICAgICAgICAgICBpZiAocmluZy0+ZnVuY3MtPnR5cGUgPT0gQU1E
R1BVX1JJTkdfVFlQRV9HRlggfHwNCj4gPiArICAgICAgICAgICAgICAgcmluZy0+ZnVuY3MtPnR5
cGUgPT0gQU1ER1BVX1JJTkdfVFlQRV9DT01QVVRFIHx8DQo+ID4gKyAgICAgICAgICAgICAgIHJp
bmctPmZ1bmNzLT50eXBlID09IEFNREdQVV9SSU5HX1RZUEVfU0RNQSkNCj4gPiArICAgICAgICAg
ICAgICAgICAgIGFtZGdwdV9nZnhfb2ZmX2N0cmwoYWRldiwgdHJ1ZSk7DQo+ID4gICAgICAgICAg
ICAgaWYgKCFyKSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAvKiBTdGFydCB0aGUgc2NoZWR1
bGVyIGFnYWluICovDQo+ID4gICAgICAgICAgICAgICAgICAgICBkcm1fc2NoZWRfd3F1ZXVlX3N0
YXJ0KCZyaW5nLT5zY2hlZCk7DQoNCg==
