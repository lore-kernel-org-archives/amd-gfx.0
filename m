Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B506C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 19:27:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D5EE10E505;
	Tue, 18 Jan 2022 19:27:40 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2054.outbound.protection.outlook.com [40.107.212.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FEEB10E515
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 19:27:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaubvORvTW5kgFiyzDK9TSjeYl0rNxik01rcPZu1WFynMjRlh4M7UY8CDz68dp/NERRuU6QeG0Wv4A94WLe9GI9NhGXf7Jzjga/3YxftbsFBr6r9O0Ye2g5807ay82yHRQXMntwH3E4PiXWkpqsTKbPTT0LkmdObautGo6GWIdriJTy1L20msXShqZun5SIvQk2MChip3bu+Gdto2OquaDlUOtQQT6T4Dyx+x8JtOiu+UbvGEX26zi6rcEjxh1518jdY5qzragVxJf7O3frdBClc9tEsItbwHAiAjkDMvIXLK3E0DaMt0TeMLKu9GCNrnbPoKnFHLAiJ5iay7VdjJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vMqesvVfFdOCJTZCMg8bfPeyVCr+zT8fwXJwqrehyg=;
 b=aa6fFdq2k8eV5KHBImf451m1w5fiMgvVkTEdd1Vs6Jn7cf82P5iwAa7cWn/6ao0chQ+wzp5UNx8i6J3x2VKCAglFRgaHYFzp4ZfRoQ5oXBYwhkZaKy0/rNGjJ7E8sDvLl/NWraJJJWzwIaO0DK5I43G+1g7zeH66ngsfSS0uhEiX/ist5i39FjSvfBCSxQgvLnwpCO9QGhzgy2cDUBAjaamlhJTxfBdULUnFQ/nKXdNKGiy9ZHfwGCL4qU5X64DpLqpf0MfnB7HlrWVNshhw2IPZBmxfg3PgOffmwuImDp4JUBepIWkdKUAsRQH/2T6yfwPWt96adi56NuEbQPJO9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vMqesvVfFdOCJTZCMg8bfPeyVCr+zT8fwXJwqrehyg=;
 b=O1rmGQF5xH3efMJU19nSutnChwX0x0kP3/VEBluLALbLtmkg1a/fXBDJVVJFcPUYDQL7Vr42h2rsflRooUMMTHcNXFz1AxuH0BdQUzKrX8jlBpOUKU6w5R8023eA8bUzp/RaEgOK69W0pL/O9tE95J5/lMCPbsGx+rf4pFpeKMY=
Received: from DM5PR12MB1308.namprd12.prod.outlook.com (2603:10b6:3:76::7) by
 DM6PR12MB3081.namprd12.prod.outlook.com (2603:10b6:5:38::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7; Tue, 18 Jan 2022 19:27:34 +0000
Received: from DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::b975:de48:9987:2ea4]) by DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::b975:de48:9987:2ea4%11]) with mapi id 15.20.4888.014; Tue, 18 Jan
 2022 19:27:34 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Arcturus
Thread-Topic: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Arcturus
Thread-Index: AQHYDIa4ORsuzb3KLE6PNJvT3KPleaxo+eMAgAAqyoCAAATR0A==
Date: Tue, 18 Jan 2022 19:27:34 +0000
Message-ID: <DM5PR12MB1308EAE234EBFD55B3374B3085589@DM5PR12MB1308.namprd12.prod.outlook.com>
References: <20220118161552.11122-1-jinhuieric.huang@amd.com>
 <CADnq5_OVpDd7O+q=9N8j14dwa-+2PqKjmDvKv6JkQGiiuQDYSQ@mail.gmail.com>
 <2f7705db-d5ac-3e7c-a991-79634c0b9f8c@amd.com>
In-Reply-To: <2f7705db-d5ac-3e7c-a991-79634c0b9f8c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=65c1e6c8-4af0-4b91-bf01-7bc4d3538cc9;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-18T19:26:21Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fa0e975-a0e4-43bc-d813-08d9dab8940a
x-ms-traffictypediagnostic: DM6PR12MB3081:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3081F592B4858590F62E755C85589@DM6PR12MB3081.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /bwTDpTl6HCX1D82hLX1999iuXy90q4y1WCNTAIJGUMK0B4jJ5vhI83njpbrcGNuxEqJKd4LluvlP42OPCMF7laPMwrXY4p5bbqUGCKliJw4MPdO3hlfPXzhE+W6FMmde6TyVPt5Pspq5XxZj9yxNM86RZPbcV71nxCtjKNZP2iXg/fR9pxX3sHgvXdwfBQKo0yw7l6P8lnPpsaODPTLVx21PMu5dQpWsExvHTDdJLmCvGxs/LhY80X92qP+6vA39w3mAOGsrAvYd64P9O+3k5r9hZyjXLAdEXq6x1hdYqcYvVJHqnevO8f22L8TU6vuz3Jy4fScPVwz5dyLyFNdXV009izwEPcAANFRM7KVpmZMpp1sXIawZW/2JR4iBf0NaN/+/wXClhbrO5ItT3Ux3FKg44Bh/n0L8ccddBIJIHodq5wnS0Oa87OJXP3PaZsxMCtIck8b2RpMnR9c3y66tgUy2SWx4lFZZDs6cSzt5thfwAF304PoNRekDTG2gZFShdww2bG3mPlSm96FPhPKbWf7DusRwDcl7q/4lbitEhU4hQoc/qNPLT1b+udyr7WdBMfca7YwlVTri+QQFYsnLkEBYi+MbN5Stwm+0Va6FDmorPv8j6ozOMPFJpIhs87KZNeQat1O6jd2KDnZva+a3K998HhDoXdU19ezaJ9p95LnwYv3f5UbF5rywnn9mBUzzhobzRfnhwSRa/OEA1SZLJ3+QdweZdndeAkBjWZBmpI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(186003)(2906002)(86362001)(33656002)(110136005)(316002)(55016003)(38100700002)(122000001)(64756008)(83380400001)(52536014)(5660300002)(8936002)(66446008)(4326008)(66556008)(7696005)(8676002)(9686003)(66476007)(76116006)(66946007)(53546011)(6506007)(508600001)(26005)(71200400001)(16393002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0gxdlB3amdhVVQ1dkFqNGNXblFwU3NDSEZCVkZiUG44dmdFUm5CVStGVEdV?=
 =?utf-8?B?eTVDUkRsNGRqUmxvMGpLa3p4Z1VjbnpCcURuVGc1UTk2bEtRV1JIUzBQUFNw?=
 =?utf-8?B?ZjRqUVU4Wm1IT3R1REREcnB1aUlNMGJIYVZwTHljdkJNZ2tvZzdtRVNsc3Nh?=
 =?utf-8?B?cUxYN3p6OHpER3JkL0lhT3lHdHhzOTV3ZTJsV3NSaG9QdWJuem5DTHNrKzZS?=
 =?utf-8?B?Y3BMV3lmcHJaQktIbFkvOERYVi8vcXFHeEJ5b2o4V3IrdEd1U3dXS3lmUTRL?=
 =?utf-8?B?Uk8zcWZsdUFrVTdYUWh3ZjBqclNoQnZRQ0Zia1EwSEs4VnFXRDdROXZwYXhz?=
 =?utf-8?B?cVp3QWR0bDJwWVRRcjBTOW5NT1kwVjlNSGtwbGpZdXE1UkVKTEpCeWJNMUFi?=
 =?utf-8?B?d29BVDRTeCtXd0MyR2VCSVE3Um1UdFhuZkNNLytRZURzQVJ0RVJPcU1WNUd0?=
 =?utf-8?B?OFpkMGc5RWJhTDZvNGM3N2tMbFpQTTJKeU5WVnFpekd3WnBiRFdCakpReG8w?=
 =?utf-8?B?bFIvQmdWcVdMcHdlOGRzdnlYMjc5Q1VhdnVkbU4wMUdvTCtON0RoTnJXNEhZ?=
 =?utf-8?B?YnlJaEc4QTNud0dBbUd0bFpmNFFvN2p4REh4U3JZN0ZFd1JtamVkSE40NFlt?=
 =?utf-8?B?RzIzSCs0NTJrdmhIWkVYOVo4dngwUENha2dmWUNWQ0VrL0dRb0cvbFJJc05N?=
 =?utf-8?B?d2RYekx3WmY0ZER1eUJzeEh1YkE2bmx4bi9KUXltV1hReGdiYmdmbmdrYTR6?=
 =?utf-8?B?bE13T0xoaU82cDBOODBaZzZreW1QLzgrL1UrVjVwYk9jTG9JOEhRMWpUM3hr?=
 =?utf-8?B?NEp6ak1LUG4vVHhSZENBVmZ0NUtQNHFUUkFxT2RnY3dERCtlaGJCUkJjZEtJ?=
 =?utf-8?B?Z3p0K0pVUkNvN29FM3R6dHZVaHJ4Z1c1am9vSTJERzJacFduOHNwVVc0Z2x2?=
 =?utf-8?B?a2Nna2xod0JnZFZpdFViUXc4WFBxVzVuYUs2WnNZQkgyR3NsVXpUQU9JbkVN?=
 =?utf-8?B?aXVhckwxSDBTVE1TZ3B4K2hmSlNwbDJSWitsR3dDNURXd2JCZHdqcUpwbTlp?=
 =?utf-8?B?MmxrNEhNVWJ6NjZadG1zeWlPZlFRMXByZFludEc1UVBRYUplR3QrVklpZGtq?=
 =?utf-8?B?TWpiMWpCMDg4eVBKTVl2RUVObnVsMUhMVUovRHpoQ0dxSW9ydFNVMFFKQmlW?=
 =?utf-8?B?K24zSHdkL2pSTzFrM2taZFBnVHRySWpOSmZ0Wis3Y1pETFVsbmJMQ08yb1ND?=
 =?utf-8?B?c0ErVWVteG1QWFZPMjNPVVZvYU96QnovZm5qZ2FGRkFmRmF6c1NlbnJLMWYy?=
 =?utf-8?B?ZEs0alIyd081YUVUSjlhbnVpbXhvZ1VNbnJRc0J5eGdIRitYK0JNU1pMeG1F?=
 =?utf-8?B?VDJGSVcvSTJKZWlVWkFwTWhNVit2VCtJQVVYcjRsOVJsOFN1ZHljQU9vR0Nr?=
 =?utf-8?B?blpHNUhmMlNucXlWaExCdklhNUFrNVFRbFJ0cGxDdnhNcnNkZzRLQUxQMjcv?=
 =?utf-8?B?djdvbkd4aEJYbmlFS2FlN2o2d1hQdWlYZThDYjhUR2pRSG1ORDZ1NHlnRTFD?=
 =?utf-8?B?UGRnYWZoMHdDRlJHN1IxWmZWTXRSVUZVbXlHSE1PVVZqbGJTM1Z3bitDT2ZB?=
 =?utf-8?B?VE5nMVJlMjdRczR2enp0SEtmTGRKQ2Z5V2Evak1oUUozRk1xazFTTnFUYXdN?=
 =?utf-8?B?aG03VSs2WUtOWXp1Mmx4NXpsdXJVUWhmei84QnhQUll1Mnl0ZVp5ZXhYcjZu?=
 =?utf-8?B?R1ZUTHZieDI2VGhsZGVpcS9EN08ybkZqcVVnSUxWd2Rrd09FalRIMEdGRDZi?=
 =?utf-8?B?LysrMWZMS0pkaHZOZEdKR1g3TDg0VExvcktEZ05hVXJ5dWRNTldidFBEeFBD?=
 =?utf-8?B?Uk0yelVtVG8yODMwZ3pTcForaEVxSDJzMDA0MGVrbVJTcE9aNndMRnY3Wm9D?=
 =?utf-8?B?azZ3a2VjYTBWMTY0SHBYcU51M1pxSU1nK3RUWUgwa2tnRVM1WkRvOEFseHNs?=
 =?utf-8?B?R05MMnlzd0FybmxYdHJZM0xBdFRWa1lDVlpEWDV0ZGc1RUsyTzdENHdiNzJa?=
 =?utf-8?B?VFliZXhKZDRWdm0zUUJXR21xZEhpTmNoRTM2cmRVa3k1emNFOE1LOVNGTC8x?=
 =?utf-8?B?NExqc2FOVUhQcS9aZHU1V0g5VnBESHR3S0huNjZUSkRWOWEwWisyVmZaVzU4?=
 =?utf-8?B?Qmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa0e975-a0e4-43bc-d813-08d9dab8940a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 19:27:34.0805 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LnaHKIkt7O3gJYxRV+/MQqczM9PmWbapv2MSuXUpD1dZK2cMPX9W/jGjhNR+hc57P8PKhH5TiV4WavYbIZ5ONg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3081
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSSB0aGluayB3aGF0IGhlIG1lYW5zIGlzIHRoYXQg
aWYgd2UgYXJlIHVzaW5nIFNETUEgdjE3LCB0aGlzIHdpbGwgY2F1c2UgaXNzdWVzLCB3b24ndCBp
dD8gU2hvdWxkIHdlIGNoZWNrIHRoYXQgU0RNQSB2ZXJzaW9uIGlzID49MTggYmVmb3JlIGVuYWJs
aW5nIGl0PyBPciBhbSBJIG1pc3VuZGVyc3RhbmRpbmcgdGhlIGZpeD8NCg0KIEtlbnQNCg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5j
ZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgRXJpYyBIdWFuZw0KPiBTZW50
OiBUdWVzZGF5LCBKYW51YXJ5IDE4LCAyMDIyIDI6MDkgUE0NCj4gVG86IEFsZXggRGV1Y2hlciA8
YWxleGRldWNoZXJAZ21haWwuY29tPg0KPiBDYzogYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGtmZDogZW5h
YmxlIGhlYXZ5LXdlaWdodCBUTEIgZmx1c2ggb24gQXJjdHVydXMNCj4NCj4gVGhlIFNETUEgZml4
IGlzIGdlbmVyaWMgYW5kIG5vdCBpbiBhIHNwZWNpZmljIHZlcnNpb24gb2YgRlcsIHNvIHdlIGRv
bid0DQo+IGhhdmUgdG8gY2hlY2suDQo+DQo+IFRoYW5rcywNCj4gRXJpYw0KPg0KPiBPbiAyMDIy
LTAxLTE4IDExOjM1LCBBbGV4IERldWNoZXIgd3JvdGU6DQo+ID4gT24gVHVlLCBKYW4gMTgsIDIw
MjIgYXQgMTE6MTYgQU0gRXJpYyBIdWFuZyA8amluaHVpZXJpYy5odWFuZ0BhbWQuY29tPiB3cm90
ZToNCj4gPj4gU0RNQSBGVyBmaXhlcyB0aGUgaGFuZyBpc3N1ZSBmb3IgYWRkaW5nIGhlYXZ5LXdl
aWdodCBUTEINCj4gPj4gZmx1c2ggb24gQXJjdHVydXMsIHNvIHdlIGNhbiBlbmFibGUgaXQuDQo+
ID4gRG8gd2UgbmVlZCB0byBjaGVjayBmb3IgYSBzcGVjaWZpYyBmdyB2ZXJzaW9uPw0KPiA+DQo+
ID4gQWxleA0KPiA+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEVyaWMgSHVhbmcgPGppbmh1aWVyaWMu
aHVhbmdAYW1kLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIHwgOCArKysrKy0tLQ0KPiA+PiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMgICAgICAgICB8IDMgKystDQo+ID4+ICAgMiBm
aWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dw
dXZtLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZt
LmMNCj4gPj4gaW5kZXggYTY0Y2JiZDk0M2JhLi43YjI0YTkyMGMxMmUgMTAwNjQ0DQo+ID4+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPiA+
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMN
Cj4gPj4gQEAgLTE4OTIsMTAgKzE4OTIsMTIgQEAgaW50IGFtZGdwdV9hbWRrZmRfZ3B1dm1fbWFw
X21lbW9yeV90b19ncHUoDQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRy
dWUpOw0KPiA+PiAgICAgICAgICByZXQgPSB1bnJlc2VydmVfYm9fYW5kX3ZtcygmY3R4LCBmYWxz
ZSwgZmFsc2UpOw0KPiA+Pg0KPiA+PiAtICAgICAgIC8qIE9ubHkgYXBwbHkgbm8gVExCIGZsdXNo
IG9uIEFsZGViYXJhbiB0bw0KPiA+PiAtICAgICAgICAqIHdvcmthcm91bmQgcmVncmVzc2lvbnMg
b24gb3RoZXIgQXNpY3MuDQo+ID4+ICsgICAgICAgLyogT25seSBhcHBseSBubyBUTEIgZmx1c2gg
b24gQWxkZWJhcmFuIGFuZCBBcmN0dXJ1cw0KPiA+PiArICAgICAgICAqIHRvIHdvcmthcm91bmQg
cmVncmVzc2lvbnMgb24gb3RoZXIgQXNpY3MuDQo+ID4+ICAgICAgICAgICAqLw0KPiA+PiAtICAg
ICAgIGlmICh0YWJsZV9mcmVlZCAmJiAoYWRldi0+YXNpY190eXBlICE9IENISVBfQUxERUJBUkFO
KSkNCj4gPj4gKyAgICAgICBpZiAodGFibGVfZnJlZWQgJiYNCj4gPj4gKyAgICAgICAgICAgKGFk
ZXYtPmFzaWNfdHlwZSAhPSBDSElQX0FMREVCQVJBTikgJiYNCj4gPj4gKyAgICAgICAgICAgKGFk
ZXYtPmFzaWNfdHlwZSAhPSBDSElQX0FSQ1RVUlVTKSkNCj4gPj4gICAgICAgICAgICAgICAgICAq
dGFibGVfZnJlZWQgPSB0cnVlOw0KPiA+Pg0KPiA+PiAgICAgICAgICBnb3RvIG91dDsNCj4gPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMNCj4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jDQo+ID4+IGluZGV4IGI1
NzBjMDQ1NGNlOS4uZWY0ZDY3NmNjNzFjIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMNCj4gPj4gQEAgLTE4MDYsNyArMTgwNiw4IEBAIHN0YXRp
YyBpbnQga2ZkX2lvY3RsX3VubWFwX21lbW9yeV9mcm9tX2dwdShzdHJ1Y3QgZmlsZQ0KPiAqZmls
ZXAsDQo+ID4+ICAgICAgICAgIH0NCj4gPj4gICAgICAgICAgbXV0ZXhfdW5sb2NrKCZwLT5tdXRl
eCk7DQo+ID4+DQo+ID4+IC0gICAgICAgaWYgKEtGRF9HQ19WRVJTSU9OKGRldikgPT0gSVBfVkVS
U0lPTig5LCA0LCAyKSkgew0KPiA+PiArICAgICAgIGlmIChLRkRfR0NfVkVSU0lPTihkZXYpID09
IElQX1ZFUlNJT04oOSwgNCwgMikgfHwNCj4gPj4gKyAgICAgICAgICAgS0ZEX0dDX1ZFUlNJT04o
ZGV2KSA9PSBJUF9WRVJTSU9OKDksIDQsIDEpKSB7DQo+ID4+ICAgICAgICAgICAgICAgICAgZXJy
ID0gYW1kZ3B1X2FtZGtmZF9ncHV2bV9zeW5jX21lbW9yeShkZXYtPmFkZXYsDQo+ID4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIChzdHJ1Y3Qga2dkX21lbSAqKSBtZW0sIHRydWUp
Ow0KPiA+PiAgICAgICAgICAgICAgICAgIGlmIChlcnIpIHsNCj4gPj4gLS0NCj4gPj4gMi4yNS4x
DQo+ID4+DQoNCg==
