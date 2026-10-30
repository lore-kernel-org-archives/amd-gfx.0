Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C42606A31D
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 06:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FEwE7Y+G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 413A7112664;
	Fri, 30 Oct 2026 06:59:53 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010064.outbound.protection.outlook.com [52.101.61.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DA61112661
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 06:59:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7nyHH1Evz1fPRKYu9KLfLD4KZ95gaWYLpdn5p+3FdJF9/gVOw9tajjnGW61Q7rL9P7r0rkKA9+/LiAoH3ohhnlVFKWCVGEBYJm5tO5Pqpw5muy8oLqbYFFZPzYNXuoc3Yit+d8kXvHF1S9wRowHtDamqVN16y8PmSHbZNgQY16R9TRX9Cx2GZCD0eww/x7rYm8apQnGntGLsQxBO5ORUC4uqOVSFMi8KzYrVu0n+6itHBwqQ8rgEIpCjbQEndwZNq6vX9TTJXutVBeTMWdMcNidilnUj73yBqh88aI1WID2CutwfJAhbYaOhfP4ClDgxosY4PUuj2HKpy0Q8x+6cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQl5VIX4DFmJuv0l3iFccc7HM1RDOEf3k//IJ06xUL8=;
 b=j09hWyH48h+o9Lad40PwFjFRo5Je6iQaDK9AFAg7oDo/JJyI2t4Pu5vXws4JBzoNO/64FaUPnXZHL6i6HZ3QuDtSUV6xRKh+Osx1DKosh93DqGW4ertOJkLFSGV2Muyo4SP4L5HEQwQtNWGlviFJsKRlA3+GgBiO0yiALi4rwSKY6STm7pAFeqqlHTg/MXi6gNWouSmUsqEEcWIo6GdRybsFCGFLZM58xe/kgN3tTFvkPbKdiLfixEJdFG66B2SKT6Ww4nQh5yaweTglJ01sY+Ea7WioM3gmahlMUJ3h5kgCNXmAniDM4qoQnbtVHg+/BxE1S6GZ19wiP7RvwzWf2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQl5VIX4DFmJuv0l3iFccc7HM1RDOEf3k//IJ06xUL8=;
 b=FEwE7Y+GIHgW/LLECxBhE3M4PXcM5UfJZOUiHM1vE88xGXsijsdk3hXnLK+FhMmxAizShrvOe6X1IwXfb/N4IyYaezlkO4a30HQqPCgViprJhyK147Ypa4DXKab1xgqXpnnbRqgwnE2NqNyAYPbskR4k3v7yKraazwVNLFI9/w0=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by PH8PR12MB6676.namprd12.prod.outlook.com (2603:10b6:510:1c3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 06:59:18 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%4]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 06:59:18 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Prosyak,
 Vitaly" <Vitaly.Prosyak@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>
Subject: RE: [PATCH 1/8] drm/amdgpu: save VKMS modeset state from the system
 PM path only
Thread-Topic: [PATCH 1/8] drm/amdgpu: save VKMS modeset state from the system
 PM path only
Thread-Index: AQHdYslY4oWsTTGxN06xVKpQj4wRt7cSPgvwgAKzgICAAH8ccA==
Date: Fri, 30 Oct 2026 06:59:18 +0000
Message-ID: <PH7PR12MB600070A05D08147B3BC68D27FB6D2@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20261023083422.3049246-1-Prike.Liang@amd.com>
 <PH7PR12MB60006BC07B279A62753C9F4EFB6F2@PH7PR12MB6000.namprd12.prod.outlook.com>
 <835e1b39-9e39-4bb4-868d-3aecc242dac2@amd.com>
In-Reply-To: <835e1b39-9e39-4bb4-868d-3aecc242dac2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-30T03:02:35.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|PH8PR12MB6676:EE_
x-ms-office365-filtering-correlation-id: 92d8a73a-5842-48eb-90ba-08df3653513b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|38070700021|4143699003|11063799006|56012099006|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261022075727099003|261022105027099003|10067099003|261021123027099003|261021121427099003|22082099003|18002099003;
x-microsoft-antispam-message-info: NXIKqpbqaMC4/dYk7JbKrCUUnBxWTl7Clk4hGX7lDu+rWg09s748vrYLBuCYWg8F0IMTmdvPxRxr2SqKVJm4zNEYBkxwz8ITB1vCYsJncF4A2KDl/pPOxYWitfJkypV+rDWbsRY6UaVJDJ7/vcJU+C/9nWHoHKaC4qhM+Bt7AAp9xIjXpPp9wuIagN8ntO5lhjOHIjc+IeJFyNZTHTmxdRU9klfmMyO50HJp5DI8QqHdCgJhLW584cVba0bgaAwXluN4lCdXglSBxmPC2mf/wvmZnBg0LlzTy+zTrRmTSvOa5XhsFkPdbYH1brvMwprgSX6qzG2lNWrszanaLe6nbmGA/YuCn+CqbMrg1YO3HX/mDDVtPdDCLR10/qRNrSAuCD14rhHSSTAunkGYxFSBcF+2KlgYu1cc0PC1rvMO63gli4JRksH9RpDwMU2cNJp7pLxRvdQinXd+s1yHmxuUC5LyuI4S/sXduEcXr5tSIVbyEx5VCQr3TpwKe9aBsBseyj6oo1JHHCMeOLkKYy0iqT1/rF3JXlM/FDRHCA4elnbQSO/KE33nUMuZyamWZDS8aCtPcdlVhLG+7DVChfpJhoTrtM8v9AJYqdvivogsfc2vKqiZmH+p+dUUaBa1Cy33Hmnx6vVZfRPIpf34g+BI9La0iR6lefFZI5MWULBWz4WMJ91BGYyXIeqGEizTuzVjHtv0dSj9hpIVCAeHsPp/kY3XW4x8GWy0t2hyZtgf9S8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(4143699003)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261022075727099003)(261022105027099003)(10067099003)(261021123027099003)(261021121427099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlNLVUwyaWZ5TXJFQ3J5a040bWJnSlIveVJ3b1ZwTkZ0Mk9OYi9tQTZQZXZY?=
 =?utf-8?B?L1dvek95SzkrMWZLcWduNkFxQWhKRWFjL2R2Vm43MnVyNUs1aytZaHdLRTdy?=
 =?utf-8?B?SndLV3MxalVTdGUwNTNld3g2RklEQjJHOXZiYzZSQnRlcVdmL1kwOGVjMFZW?=
 =?utf-8?B?YndkcEtlRWZlcHJ5a1dJVFlNaTV4N21RdFczOVhpV1N1b2lrN085OWlGcVor?=
 =?utf-8?B?RFRIUVRYY0FCVnNud1ZWYThxejU2b2p0Zkl2TEdBOVhBRy9IcnIxVG1zK3FI?=
 =?utf-8?B?cnllSXZmNXNOR2lmNmUyTDlGN3dpZTJseUY0dWNlVk93eGdxYjZWYVZzbWRT?=
 =?utf-8?B?WGJuemZDZkxsR0RFSk1EdkRRR24zZFJORTVScDhadlVmVDRna3BuT1pzZzVv?=
 =?utf-8?B?R3J3VjVWOVNNY2NIYnRJUjZ0THBCZVkrS3RWQUJYVWM4YjkzQW45YUFVZzdw?=
 =?utf-8?B?YVh2aitCRUFISWxDUkMwWTNnYTJpUk5ZUThNUXZHU09CTTdldkRVeWVkM1R5?=
 =?utf-8?B?a0VOdDJpWnh0L2g3aWo4Q204ZzNDb3l2M21FLzRROHRlODFoZWJ0eFRMSXoz?=
 =?utf-8?B?bjk4ZXFUNGRKVXBmdFpsM0RnWDcya0tpY3kvd0lMRUZrbXBVUWpSSzE3UW42?=
 =?utf-8?B?L0RFMTV4ZThsQmdLV2NLNFlHcXV2YjdlRjFaS0diamp6SDJxUjNhQnF1YnN2?=
 =?utf-8?B?cjNlQ25jTGIvZHBOVXNxL0Nya1pSWW02TnVnTU95Q1BNa1lwTG90UmdNU2VO?=
 =?utf-8?B?M283Nlh5QzhsbkhUc2Jkd0puaEM3eldaVWRvWVZ2cndIMU9SYjU3MnUyWlVp?=
 =?utf-8?B?ZDRqQ0YvcjVjd3FwckUydFVFblQ1NWJjdFVmR25yZDZLdG40bVhjUmx6WnJ1?=
 =?utf-8?B?b3A5QXRlcE5oSlhodTV0elliUytUemhhSURJYmIwNFhIRHNjSmZKZXlKVmk5?=
 =?utf-8?B?YWxmQmJXZE0vQnJhV1lGWDlmRk9VWmF1TG96NGlHaWNRb3NNMXAweDE4S3FW?=
 =?utf-8?B?eTJWTUFMeDdGeTRpdStia0hDNkNCWWNETnJpTXhWeG1haHpMRWpmV01MUzFy?=
 =?utf-8?B?Ylp2M0JvakZiaUtKaEF4cDU2Q3Jxc2YzRDVIdlJhZlJmU3JlRWpscWY3T0xy?=
 =?utf-8?B?M25CUDRYTnBEZVJkMWZRcmFNZ2lLZC9oUHdydU0ybjRuVE5ld3JlSEpQMitU?=
 =?utf-8?B?TExSUzR4QTBoTTBOVFFYRHRUZDA4Smt3dnV1N25jbmZMc1lpL1V4YlhTTkxn?=
 =?utf-8?B?QWNQTzNFbCs5bVNzQ2VrblcvWVBvWURsUHJ3bktqd2NCZ29vU2orL1FQWjNT?=
 =?utf-8?B?VGhRdzVTekcrY0NTUEw5Yzk5U2grQU1nbEVxMTQ4eHpsdVp5NmJxVEpXaGsx?=
 =?utf-8?B?VUMrUmUwN2M4TEs0SzNwaFRtdmtuc2ZhZDJiVDlUR3lGNkxzdHZsZkxKRjZi?=
 =?utf-8?B?UEhCNWFrNC95QnlSc3hQUVRNeUEvNFlqS0lkZ1RqMUVjSm04dWR2SFlNd1Vw?=
 =?utf-8?B?U0NtVDdiQUZnWGRRakllVjUzWExzV01kN284SG5oS2xkZEpNN0pGaWZXN09U?=
 =?utf-8?B?WEMxeitZcXJna2hGRlhnZzVFV1NxL2tObWVaU25XSkhod3k4ZkNiMGtKaitK?=
 =?utf-8?B?MTNuOU5xWmNyMkdSNURuTWdCaHZKL2FXL25nakZQR25sdTRMcDU0OXBZOXB1?=
 =?utf-8?B?UGQ5Zm9nWHBaT3N3YlVZT2wrbVBTRVZWYTZHcTZFTkQvWGZMWm1ZTjBqNlNL?=
 =?utf-8?B?TlZldCttaGtSWVZGbG5xeXZhVkFJS1pBYWJ6ZVc0VGpJZ2htdUxzcXJYWWJv?=
 =?utf-8?B?Mlh3ZXRrSE56T0hKZzVqWUx1dEJZQ1ZIUG5yTlFVQlV5UGVmRUJUbHI5ZHFH?=
 =?utf-8?B?ZCs4M05ZcFVnbmlPMU9RMys2aWo2elA3dGppQjZGcWpOcUlUd1IxZ2JCOWRQ?=
 =?utf-8?B?L0pGVEgwTXptYkxqWUp5KzkzS3VjZXV2Qjg1WTUybEtIVTNqaFp1RFgvWFZk?=
 =?utf-8?B?M3I5OWhiSUFUTEwzK0RrdzQ1MjJ1NUtMQ25SNXhJVjFZWWZHRUJCbUc3WHBI?=
 =?utf-8?B?blBWYTFteXVGYkp2cUhlTzN3ekFiMTNxdkFaMXordUlmR01yeWwvcW5zZUx1?=
 =?utf-8?B?bk5EZEx4amlYeHY0eDMvd3R4MHA5QnFlZzlYaG4wOXFYWWJqTXl0RDdPd2tE?=
 =?utf-8?B?a1A0SnVMUDRTd09VT0piMW55ZEZyMVU4SHdvQmFaWDV4NWZZd0hYUmhkdzFr?=
 =?utf-8?B?cW1YVWh6MldIVDFneHdqVkJEeHNmR0RLZS9yMWNkM3UxQU95eDFuMWlWalZG?=
 =?utf-8?Q?+gHiC1lt+k6TEP4Ppg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d8a73a-5842-48eb-90ba-08df3653513b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2026 06:59:18.2530 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2AC2mkPmBrliOHqUEESvxoVLSd4vgHdPuLSLtC9T40qNsZZAqqiKvG+3LG6sVBye
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6676
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QU1EIEdlbmVyYWwNCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxs
b0BhbWQuY29tPg0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgMzAsIDIwMjYgMzoyOCBBTQ0KPiBU
bzogTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJA
YW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+
OyBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPjsgUHJvc3lhaywgVml0YWx5DQo+IDxW
aXRhbHkuUHJvc3lha0BhbWQuY29tPjsgTGksIFN1biBwZW5nIChMZW8pIDxTdW5wZW5nLkxpQGFt
ZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS84XSBkcm0vYW1kZ3B1OiBzYXZlIFZLTVMg
bW9kZXNldCBzdGF0ZSBmcm9tIHRoZSBzeXN0ZW0NCj4gUE0gcGF0aCBvbmx5DQo+DQo+DQo+DQo+
IE9uIDEwLzI3LzI2IDIxOjE3LCBMaWFuZywgUHJpa2Ugd3JvdGU6DQo+ID4gQU1EIEdlbmVyYWwN
Cj4gPg0KPiA+IEFkZGluZyBNYXJpbyBmb3IgaGlzIGluc2lnaHQgb24gbW92aW5nDQo+ID4gZHJt
X21vZGVfY29uZmlnX2hlbHBlcl9zdXNwZW5kKCkvDQo+ID4gcmVzdW1lKCkgb3V0IG9mIEdQVSBy
ZWNvdmVyeSwgd2hlcmUgdGhleSBibG9jayB3YWl0aW5nIGFuZCBhbGxvY2F0ZQ0KPiA+IHJlY2xh
aW0gdW5kZXIgcmVzZXRfZG9tYWluLT5zZW0gYW5kIGNhbiBkZWFkbG9jayB3aXRoIHVzZXJxX211
dGV4Lg0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiAgICAgICAgUHJpa2UNCj4gPg0KPiA+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBMaWFuZywgUHJpa2UgPFByaWtlLkxp
YW5nQGFtZC5jb20+DQo+ID4+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAyMywgMjAyNiA0OjM0IFBN
DQo+ID4+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+PiBDYzogRGV1Y2hl
ciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3Rp
YW4NCj4gPj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IExhemFyLCBMaWpvIDxMaWpvLkxh
emFyQGFtZC5jb20+Ow0KPiA+PiBQcm9zeWFrLCBWaXRhbHkgPFZpdGFseS5Qcm9zeWFrQGFtZC5j
b20+OyBMaWFuZywgUHJpa2UNCj4gPj4gPFByaWtlLkxpYW5nQGFtZC5jb20+OyBMaSwgU3VuIHBl
bmcNCj4gPj4gKExlbykgPFN1bnBlbmcuTGlAYW1kLmNvbT4NCj4gPj4gU3ViamVjdDogW1BBVENI
IDEvOF0gZHJtL2FtZGdwdTogc2F2ZSBWS01TIG1vZGVzZXQgc3RhdGUgZnJvbSB0aGUNCj4gPj4g
c3lzdGVtIFBNIHBhdGggb25seQ0KPiA+Pg0KPiA+PiBhbWRncHVfdmttc19zdXNwZW5kKCkvcmVz
dW1lKCkgYXJlIElQIGJsb2NrIGNhbGxiYWNrcyBzaGFyZWQgYnkNCj4gPj4gc3lzdGVtIHN1c3Bl
bmQvcmVzdW1lIGFuZCBHUFUgcmVjb3ZlcnkuIENhbGxpbmcNCj4gPj4gZHJtX21vZGVfY29uZmln
X2hlbHBlcl9zdXNwZW5kKCkgYW5kIGRybV9tb2RlX2NvbmZpZ19oZWxwZXJfcmVzdW1lKCkNCj4g
Pj4gZnJvbSB0aGVtIG1ha2VzIEdQVSByZWNvdmVyeSB0YWtlIGNsaWVudGxpc3RfbXV0ZXggYW5k
IHRoZSBtb2Rlc2V0DQo+ID4+IGxvY2tzIGFuZCBkdXBsaWNhdGUgdGhlIGF0b21pYyBzdGF0ZSB3
aGlsZSBob2xkaW5nIHJlc2V0X2RvbWFpbi0+c2VtLiBMb2NrZGVwDQo+IHJlcG9ydHM6DQo+ID4+
DQo+ID4+ICAgIENoYWluIGV4aXN0cyBvZjoNCj4gPj4gICAgICAmZGV2LT5jbGllbnRsaXN0X211
dGV4IC0tPiAmdXNlcnFfbWdyLT51c2VycV9tdXRleCAtLT4NCj4gPj4gJnJlc2V0X2RvbWFpbi0+
c2VtDQo+ID4+DQo+ID4+IFZLTVMgaGFzIG5vIGhhcmR3YXJlIHN0YXRlIHRoYXQgYSByZXNldCBj
YW4gbG9zZSwgc28gdGhlIHJlc2V0IHBhdGgNCj4gPj4gbmV2ZXIgbmVlZHMgdGhlc2UgaGVscGVy
cy4gQ2FsbCB0aGVtIGZyb20NCj4gPj4gYW1kZ3B1X2RldmljZV9zdXNwZW5kKCkvcmVzdW1lKCkg
aW5zdGVhZCBhbmQgbGVhdmUgdGhlIElQIGNhbGxiYWNrcyB3aXRoIG9ubHkNCj4gdGhlIGhhcmR3
YXJlIGluaXQuDQo+DQo+IEFzIHlvdSBtZW50aW9uZWQgd2hlbiBwaW5naW5nIG1lIHRoZXJlIGlz
IHRoZSByZWNsYWltL2ZlbmNlIHJlYXNvbmluZyB0b28uIEl0DQo+IHdvdWxkIGJlIGdvb2QgdG8g
aW5jbHVkZSBib3RoIGluIHRoZSBjb21taXQgbWVzc2FnZSBhcyB3ZWxsLg0KDQpZZWFoLCB3aWxs
IGluY2x1ZGUgdGhhdCBhbmFseXNpcyBpbiB0aGUgY29tbWl0IGxvZy4NCg0KPiBJIGRlZmluaXRl
bHkgZG9uJ3QgdGhpbmsgd2UgbmVlZCBhbGwgdGhvc2UgYmxvY2tpbmcgaGVscGVycyBpbiB0aGUg
R1BVIHJlY292ZXJ5IHBhdGggYXQNCj4gYWxsLg0KPg0KPiAgRnJvbSBtZSB0aGlzIHBhdGNoIGxv
b2tzIGdvb2QuDQo+DQo+IFJldmlld2VkLWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGlt
b25jaWVsbG9AYW1kLmNvbT4NCj4NCj4gSSBkbyBoYXZlIGEgc21hbGwgbml0IGJlbG93IChmZWVs
IGZyZWUgdG8gZml4IHdoaWxlIGNvbW1pdHRpbmcpLg0KPg0KPiA+Pg0KPiA+PiBTaWduZWQtb2Zm
LWJ5OiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPj4gQ2M6IFN1biBwZW5n
IExpIChMZW8pIDxTdW5wZW5nLkxpQGFtZC5jb20+DQo+ID4+IC0tLQ0KPiA+PiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDE5ICsrKysrKysrKysrKysrKysr
Ky0NCj4gPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmttcy5jICAgfCAx
NCArLS0tLS0tLS0tLS0tLQ0KPiA+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygr
KSwgMTQgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPj4gaW5kZXggYjc0ZjkxMzZhYTJlLi40MDZjNWYy
ZmJlZTEgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYw0KPiA+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGV2aWNlLmMNCj4gPj4gQEAgLTQ1NjgsOSArNDU2OCwxNiBAQCBpbnQgYW1kZ3B1X2RldmljZV9z
dXNwZW5kKHN0cnVjdCBkcm1fZGV2aWNlDQo+ID4+ICpkZXYsIGJvb2wgbm90aWZ5X2NsaWVudHMp
DQo+ID4+DQo+ID4+ICAgICAgICBhbWRncHVfcmFzX3N1c3BlbmQoYWRldik7DQo+ID4+DQo+ID4+
ICsgICAgIC8qIFZLTVMgbW9kZXNldCBzdGF0ZSBpcyBzYXZlZCBoZXJlLCBuZXZlciBmcm9tIHRo
ZSByZXNldCBwYXRoICovDQo+ID4+ICsgICAgIGlmIChhZGV2LT5lbmFibGVfdmlydHVhbF9kaXNw
bGF5KSB7DQo+ID4+ICsgICAgICAgICAgICAgciA9IGRybV9tb2RlX2NvbmZpZ19oZWxwZXJfc3Vz
cGVuZChkZXYpOw0KPiA+PiArICAgICAgICAgICAgIGlmIChyKQ0KPiA+PiArICAgICAgICAgICAg
ICAgICAgICAgZ290byB1bndpbmRfc21hcnRzaGlmdDsNCj4gPj4gKyAgICAgfQ0KPiA+PiArDQo+
ID4+ICAgICAgICByID0gYW1kZ3B1X2RldmljZV9pcF9zdXNwZW5kX3BoYXNlMShhZGV2KTsNCj4g
Pj4gICAgICAgIGlmIChyKQ0KPiA+PiAtICAgICAgICAgICAgIGdvdG8gdW53aW5kX3NtYXJ0c2hp
ZnQ7DQo+ID4+ICsgICAgICAgICAgICAgZ290byB1bndpbmRfdmttczsNCj4gPj4+PiAgICAgICAg
YW1kZ3B1X2FtZGtmZF9zdXNwZW5kKGFkZXYsICFhbWRncHVfc3Jpb3ZfdmYoYWRldikgJiYgIWFk
ZXYtDQo+ID4+PiBpbl9ydW5wbSk7DQo+ID4+ICAgICAgICByID0gYW1kZ3B1X3VzZXJxX3N1c3Bl
bmQoYWRldik7IEBAIC00NjE4LDYgKzQ2MjUsMTAgQEAgaW50DQo+ID4+IGFtZGdwdV9kZXZpY2Vf
c3VzcGVuZChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCBib29sIG5vdGlmeV9jbGllbnRzKQ0KPiA+
PiAgICAgICAgICAgICAgICByZXR1cm4gcjsNCj4gPj4gICAgICAgIH0NCj4gPj4NCj4gPj4gK3Vu
d2luZF92a21zOg0KPiA+PiArICAgICBpZiAoYWRldi0+ZW5hYmxlX3ZpcnR1YWxfZGlzcGxheSkN
Cj4gPj4gKyAgICAgICAgICAgICBkcm1fbW9kZV9jb25maWdfaGVscGVyX3Jlc3VtZShkZXYpOw0K
PiA+PiArDQo+ID4+ICAgdW53aW5kX3NtYXJ0c2hpZnQ6DQo+ID4+ICAgICAgICByZWMgPSBhbWRn
cHVfYWNwaV9zbWFydF9zaGlmdF91cGRhdGUoYWRldiwgQU1ER1BVX1NTX0RFVl9EMCk7DQo+ID4+
ICAgICAgICBpZiAocmVjKSB7DQo+ID4+IEBAIC00NzE3LDYgKzQ3MjgsMTIgQEAgaW50IGFtZGdw
dV9kZXZpY2VfcmVzdW1lKHN0cnVjdCBkcm1fZGV2aWNlDQo+ID4+ICpkZXYsIGJvb2wgbm90aWZ5
X2NsaWVudHMpDQo+ID4+ICAgICAgICAgICAgICAgIGdvdG8gZXhpdDsNCj4gPj4gICAgICAgIH0N
Cj4gPj4NCj4gPj4gKyAgICAgaWYgKGFkZXYtPmVuYWJsZV92aXJ0dWFsX2Rpc3BsYXkpIHsNCj4g
Pj4gKyAgICAgICAgICAgICByID0gZHJtX21vZGVfY29uZmlnX2hlbHBlcl9yZXN1bWUoZGV2KTsN
Cj4gPj4gKyAgICAgICAgICAgICBpZiAocikNCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgIGdv
dG8gZXhpdDsNCj4gPj4gKyAgICAgfQ0KPiA+PiArDQo+ID4+ICAgICAgICByID0gYW1kZ3B1X2Ft
ZGtmZF9yZXN1bWUoYWRldiwgIWFtZGdwdV9zcmlvdl92ZihhZGV2KSAmJg0KPiA+PiAhYWRldi0N
Cj4gPj4+IGluX3J1bnBtKTsNCj4gPj4gICAgICAgIGlmIChyKQ0KPiA+PiAgICAgICAgICAgICAg
ICBnb3RvIGV4aXQ7DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdmttcy5jDQo+ID4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZrbXMuYw0KPiA+PiBpbmRleCBkNmI1MWIzZjIxNmIuLjZkZTMzZjE0ZDkwOSAxMDA2NDQNCj4g
Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZrbXMuYw0KPiA+PiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmttcy5jDQo+ID4+IEBAIC00
ODgsMjQgKzQ4OCwxMiBAQCBzdGF0aWMgaW50IGFtZGdwdV92a21zX2h3X2Zpbmkoc3RydWN0DQo+
ID4+IGFtZGdwdV9pcF9ibG9jaw0KPiA+PiAqaXBfYmxvY2spDQo+ID4+DQo+ID4+ICAgc3RhdGlj
IGludCBhbWRncHVfdmttc19zdXNwZW5kKHN0cnVjdCBhbWRncHVfaXBfYmxvY2sgKmlwX2Jsb2Nr
KSAgew0KPiA+PiAtICAgICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGlwX2Jsb2NrLT5h
ZGV2Ow0KPiA+PiAtICAgICBpbnQgcjsNCj4gPj4gLQ0KPiA+PiAtICAgICByID0gZHJtX21vZGVf
Y29uZmlnX2hlbHBlcl9zdXNwZW5kKGFkZXZfdG9fZHJtKGFkZXYpKTsNCj4gPj4gLSAgICAgaWYg
KHIpDQo+ID4+IC0gICAgICAgICAgICAgcmV0dXJuIHI7DQo+ID4+IC0NCj4gPj4gICAgICAgIHJl
dHVybiAwOw0KPiA+PiAgIH0NCj4NCj4gV2l0aCB0aGVzZSBjaGFuZ2VzIEkgd291bGQgc3VnZ2Vz
dCB5b3UganVzdCBkcm9wIHRoZSBjYWxsYmFjay9mdW5jdGlvbiBlbnRpcmVseSBmcm9tDQo+IGFt
ZGdwdV92a21zX2lwX2Z1bmNzIHNpbmNlIHRoZSBmdW5jdGlvbiBqdXN0IHJldHVybnMgMCBub3cu
DQoNCk9LLCB3aWxsIGNsZWFuIGl0IHVwIGFuZCBiZWZvcmUgd2FudHMgdG8ga2VlcCBpdCBmb3Ig
cGFyaW5nIHRoZSByZXN1bWUgZnVuY3MuDQoNCj4NCj4gICAgICAgLnN1c3BlbmQgPSBhbWRncHVf
dmttc19zdXNwZW5kLA0KPg0KPiA+Pg0KPiA+PiAgIHN0YXRpYyBpbnQgYW1kZ3B1X3ZrbXNfcmVz
dW1lKHN0cnVjdCBhbWRncHVfaXBfYmxvY2sgKmlwX2Jsb2NrKSAgew0KPiA+PiAtICAgICBpbnQg
cjsNCj4gPj4gLQ0KPiA+PiAtICAgICByID0gYW1kZ3B1X3ZrbXNfaHdfaW5pdChpcF9ibG9jayk7
DQo+ID4+IC0gICAgIGlmIChyKQ0KPiA+PiAtICAgICAgICAgICAgIHJldHVybiByOw0KPiA+PiAt
ICAgICByZXR1cm4gZHJtX21vZGVfY29uZmlnX2hlbHBlcl9yZXN1bWUoYWRldl90b19kcm0oaXBf
YmxvY2stPmFkZXYpKTsNCj4gPj4gKyAgICAgcmV0dXJuIGFtZGdwdV92a21zX2h3X2luaXQoaXBf
YmxvY2spOw0KPiA+PiAgIH0NCj4gPj4NCj4gPj4gICBzdGF0aWMgaW50IGFtZGdwdV92a21zX3Nl
dF9jbG9ja2dhdGluZ19zdGF0ZShzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrDQo+ID4+ICppcF9ibG9j
aywNCj4gPj4gLS0NCj4gPj4gMi4zNC4xDQo+ID4NCg0K
