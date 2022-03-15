Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAADEC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 07:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 527E410E416;
	Tue, 15 Mar 2022 07:11:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 815D710E45A
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 07:11:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsLxGMRy3/TnpueaJsPZoTulMiAYFxBUMAp4zaWwBDmdTsmFkZD7YaZc/I2XE7Ic5ZG+cJvp74giNEd62tgCndFNdGcX0PJ3C/rEuOz03swUrDepjmjR5LnlqNo/Re6ytTeb/B5wePRJO1SJPXW41NoDArm6D2owXZmVeousifjEKmsQ2nz55X1w1Ez+112hRcxAMJmi+WIPnbk3rLLAt7Yx1NanXjD9kX7wRPAUfilg3hJkUsNdonksRzSgFvVUynmtwW14aKAmwyowkjrJqubvk2rSTgPlmVlO4GaoBEISE9BqDS9qEegI4ir/lyEXL5NpTTB/x11O+/YPIulEpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbtwxoNDlivPGx3SCmNeNaJ9W0G6Ot7odAccDWayLTI=;
 b=DB7ciqyoz7v0tR8Ccjgjl63lD6YxncCiXZ5BSh4HEM4j714+9is5SBrc7zst00xDoqagG/lrz9x9aQ14Pfs+W0AQvIsX76Y0+yWnwrVgi/xpOZPJps60nekf8qPtQgFL9AJiUeYYgwzOyoi9VQ9DaODspcKGQa9LdZlt1HlQ0YCjYUZQpSNVdYbgnaJWMV/3i+DnTOdcnSbOR+AKxNHiODnHDBcU6P5expKUGVIxCif/8+2dzeD4A5EUlJQYJx6sBI9YZ+JAckNekiFcJJdfj2FS5mLOhOKBT6DB39jdYXJ7Null5F4ryjwLrG+Jtd1dcDN3pMqgxZNpppLzuQG2Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbtwxoNDlivPGx3SCmNeNaJ9W0G6Ot7odAccDWayLTI=;
 b=YMS+it3sF2u1SA76RIvwXr38kRpVQl1cID3ORGBlb9M5++hCSoax621be0icUlhVXpR2U/fAuYnunyQq0WnAEn9ysh8pzgzIucwzmnDEYn6sEqxSoyfq6kG9eatwtfEDWKqrkHbV37awXY/hOFjyhxcZYVp46u4FRsEBC//2V9Y=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by CH0PR12MB5060.namprd12.prod.outlook.com (2603:10b6:610:e3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Tue, 15 Mar
 2022 07:10:57 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 07:10:56 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 1/3] drm/amdkfd: update parameter for
 event_interrupt_poison_consumption
Thread-Topic: [PATCH 1/3] drm/amdkfd: update parameter for
 event_interrupt_poison_consumption
Thread-Index: AQHYN3GknN/IshHMAkyY9P1AqinGR6y/MsAAgADVHlA=
Date: Tue, 15 Mar 2022 07:10:56 +0000
Message-ID: <DM5PR12MB1770A35880874B713BB5856EB0109@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220314070326.21828-1-tao.zhou1@amd.com>
 <564e2d26-fbf1-64e6-aa29-e17aad6cb5b8@amd.com>
In-Reply-To: <564e2d26-fbf1-64e6-aa29-e17aad6cb5b8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-15T07:07:48Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=46dce29b-62e0-47d5-a3b1-f28e27a8836b;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-15T07:10:53Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 7cf4a176-928e-44a8-ba3d-0122206535b9
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fa67394-59c1-433c-d4cc-08da0652f37a
x-ms-traffictypediagnostic: CH0PR12MB5060:EE_
x-microsoft-antispam-prvs: <CH0PR12MB5060A9925583542A9FA53C00B0109@CH0PR12MB5060.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uZJ4vw1v198hbS4FYmBGnjfl8938nVsJz7wFrowO6i6oo2jPdEY6QeFIingu8JZlXLw3ILgVc84QIrm+DSMoHQHUAuM7gOLgnHORam1Mf1PADQPP+UWvVyGKadXlBFlGUvxhSd3qs4w/kESyYKFkwEblyEv/m+UZAyZZmi9Xlib2z06to/ozYaCv8yTgya9jiJxhpcoEXLpyuGoY+Bhih33PoeeRTkhCDk44K43ChZK5MfSwwdp4owZV1UArCjcv+XzgDc67pvCozQP+KeXcD7XtTaJbXtYEW0+5rjx9SAXz06QlcZfGdCm0FcEUWwYOKRAA6BKVu80q6t0Lxo44seRtPwX6xdsxoCjYNTod8GrS4NmT6HF5X6cOuLkpr48rzZIP4RBzjUEpsVn+buEfEJFKM1aG6IBzkb18faACQHLW3E8RBuyzwchjSuNdwHzbZDFuBU4iHxUJVXo/G6ztM/dCni1nZWs5VxGoBXiuRI7HZTNZZGKGuVieZU0Lb+zs1yXOcguebnptoPZa5xb0lS+iiNHPeJ1TqJOLszOdj/P7oM+dY2WcWSok3PIbDkksYuF1hhpZmdyJS/1Pc78zSZAVltXbUOfsETv13fvKZbigRnggIwZuorAcXGzXg4l/Xin6OoE8VW+XKH1AD4b0o7P5/6T9oHiVZYNG4cf7OUyuH7IjXFFrYETUaVmZJvlZFHNksEVjiD/LWvImwrgJCg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(52536014)(15650500001)(86362001)(38070700005)(122000001)(5660300002)(38100700002)(55016003)(186003)(26005)(110136005)(83380400001)(9686003)(7696005)(6506007)(53546011)(508600001)(66446008)(66476007)(66556008)(66946007)(64756008)(76116006)(8676002)(316002)(6636002)(71200400001)(2906002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGJNKzRkdHE5TDJna0ZZNTRiSk5kZGlrbjVFUVlGWlg4SUljNE5QUVdjamxY?=
 =?utf-8?B?cjBXNFJMR1pZZkVzV09RYmNZVjZCaFNJN3B0NGtvYTdKd1EyU0JkYXZuRVFw?=
 =?utf-8?B?eFEzY3dBaXI4VkpuMnNHS0pvd1I4SHhEZXJzRnNDRzVua3l1dzVkZnpxL2FR?=
 =?utf-8?B?cEZ4dUV3MGZjVys2VFZvRGVBS3hwZFJWYWMwcVhXWkZJNTRHSERZMXJoTHhX?=
 =?utf-8?B?TDUrczU1bTNPWWhDQzcybDdPTlQ2M2luR0xvOHJqcUc1RVp5d3NaYnZLMXJw?=
 =?utf-8?B?RnhDekZ5aEp6Q0tMdlovWkpGaVluSXdlN3VtdFVCSExDbEkwcXUrRXZFMi9x?=
 =?utf-8?B?eGRVc1N0MWV1L2ZIa1c0RUU3ZDE5aHNaWStoVGNnRTZkTDl4R0FyOTdXTkoz?=
 =?utf-8?B?L016cStDM2VUMlprS3VFS2srMEZoZ1JqRk9TNWlMd2lhazJPbmw2aXdIY29q?=
 =?utf-8?B?cVlFUEZ6YVRBcDJRalh4dUtEcWJ1UTZkRCs2UWs3Q3B6SlRCN1I0U2QyQWt1?=
 =?utf-8?B?NjN1Y0p1N1FaSVphdnQxbTV3NGJlQWw5cUhscFJ4dktMVVJjeGxtT2dMWUto?=
 =?utf-8?B?eGM4eGV1UXNpKzIzWkpMYVNJWCtIdFVrN2dFNkZLYlV3RVFtSmNOT2Ywc1Ey?=
 =?utf-8?B?cGJwaU4vNTEreUM3MWZOWmdHeEk0R1dDOHZYSm9qdm0vc0lDTEx3Q0VQRU5H?=
 =?utf-8?B?aFVvR29ueTNmUXVkYTRVWmk3LzJHdmhCRk52MngzMmQzR0IvalBqQ1lod0hr?=
 =?utf-8?B?elkzKzhyNnU4bW1IalJITm90Wnl0WUl4eE5FTGZHTU1ZQ2RWZnBUYWhicThD?=
 =?utf-8?B?TE4vSjA0QWQ3OUhmY0tnbFVtQ1FTeUdNa0tWQ1VMWVp0TVBSUEhlT3l1b3FH?=
 =?utf-8?B?dnY0djB3QUovOVZRaE5USmF6VEhDeVg5OTlYbFl0SXNlV1FpdW41NDBKVEFN?=
 =?utf-8?B?UkJxUllFenI3MXowNUlUUVI3L2Vsb1JNZVVwMEhHVDVmWlRvNGV4VERZK0s4?=
 =?utf-8?B?MXBGUUFRZmRyeTh3R1NjSUwyMmxHWDJQMUM3NWM5VkE3VDVySFM4Z2x0eVhl?=
 =?utf-8?B?MkwzbHdJNndFYUlveldIQ2NPN0dSUnpsQTVjcy82TUZQYjBoVEcvQThCRHZU?=
 =?utf-8?B?YTg0dDBlSTh4LzVqb3NtY2QydUp4SldHZXY5VndDTUE5MkozTVl5ajJ5OWpk?=
 =?utf-8?B?YzVCY3dMSWxlNU9NSXNpNkVlczdCNGxIUXZyR2tOUm1iQk4rSHVva1dEUHZ0?=
 =?utf-8?B?SnBETnRucXE2M29oUVZiZDIzem14RmhDYzBGNGp2TGFRdW56RjRtRHZ2bWNG?=
 =?utf-8?B?NDQvMWd5MXZyUzBodnpYWkVCcFg0aHNzM3hJbUpnTms2ZlREVWFwcTZhWDJ0?=
 =?utf-8?B?Vm43bEVwM2Q0U3NzV1JVREJ3ZHo3RkNoUUJQVXJSeHdpYzVVVUd6bTFHM1Vh?=
 =?utf-8?B?cC9lSEFlTytnVVk0aE9CS0RycGEydyttYkN0Zi8wZmtpS3JGWkJBUkNBQzhU?=
 =?utf-8?B?ZEFrT1VBOHVBcWxSTDhRd1JxVVBDaDEybkw3UmFaL1pySk5ET0gwaUc1Zy9K?=
 =?utf-8?B?R0ZvLzRTazdtSVJiT3ZkTG1wY3ZiRGxnRHNneE5MMVZ2amMxSW5LZFY5S1ZF?=
 =?utf-8?B?VG1CS2VsLzRWSUhtMkxtU01NaGpUQThaQmtuZzRnR3pSRTB0Y01ibUJCd1Nk?=
 =?utf-8?B?eWlYV1NoQjl6czRpeUhic2ptT21uamxPVGh1a1ErekNGZ0s1RmtLM25aU1NR?=
 =?utf-8?B?M1ZFZ3RuU2dURXNaZEM2RE5USmU1NUdLRWhFSVlhK0c4eGMyUEhTZUJIUjc4?=
 =?utf-8?B?TGliT3NSd0g5MnpRS2MvSDJmOUFwZi9FL0pnRSt1RWJLWUtRMkEwaXdHZDF6?=
 =?utf-8?B?bDFNOXRsRTI0dVdrMmlFNjZDOU5EeHdmM2tqVnFTbUlJNGdvbzZRR01vbEVS?=
 =?utf-8?Q?q59QzT80aJQUn+C3hpgL1FhA3xdbc+gP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa67394-59c1-433c-d4cc-08da0652f37a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 07:10:56.6157 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FLny4TsWzDM9Wzmx0uyNHiKjwBS7orpFFgrykWFKJ9BWUg/l99NahstvG1K+8W7w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5060
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPiBT
ZW50OiBUdWVzZGF5LCBNYXJjaCAxNSwgMjAyMiAyOjI1IEFNDQo+IFRvOiBaaG91MSwgVGFvIDxU
YW8uWmhvdTFAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBaaGFuZywN
Cj4gSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgWWFuZywgU3RhbmxleQ0KPiA8U3Rh
bmxleS5ZYW5nQGFtZC5jb20+OyBDaGFpLCBUaG9tYXMgPFlpUGVuZy5DaGFpQGFtZC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXSBkcm0vYW1ka2ZkOiB1cGRhdGUgcGFyYW1ldGVyIGZv
cg0KPiBldmVudF9pbnRlcnJ1cHRfcG9pc29uX2NvbnN1bXB0aW9uDQo+IA0KPiBBbSAyMDIyLTAz
LTE0IHVtIDAzOjAzIHNjaHJpZWIgVGFvIFpob3U6DQo+ID4gT3RoZXIgcGFyYW1ldGVycyBjYW4g
YmUgZ290dGVuIGZyb20gaWhfcmluZ19lbnRyeSwgc28gb25seSBpbnB1dHRpbmcNCj4gPiBpaF9y
aW5nX2VudHJ5IGlzIGVub3VnaC4NCj4gDQo+IEknbSBub3Qgc3VyZSB3aGF0J3MgdGhlIHJlYXNv
biBmb3IgdGhpcyBjaGFuZ2UuIFlvdSByZW1vdmUgb25lIHBhcmFtZXRlciwgYnV0DQo+IGVuZCB1
cCBkdXBsaWNhdGluZyB0aGUgU09DMTVfLi4uX0ZST01fSUhfUklOR19FTlRSWSB0cmFuc2xhdGlv
bnMuIEl0DQo+IGRvZXNuJ3QgbG9vayBsaWtlIGEgbmV0IGltcHJvdmVtZW50IHRvIG1lLg0KDQpb
VGFvXSBzb3VyY2VfaWQvcGFzaWQvY2xpZW50X2lkIHdpbGwgYmUgdHJhbnNmZXJyZWQgYW5kIEkn
ZCBsaWtlIHRvIHJlZHVjZSB0aGUgbnVtYmVyIG9mIHBhcmFtZXRlcnMsIEknbGwgZHJvcCB0aGUg
Y2hhbmdlLg0KDQo+IA0KPiBMb29raW5nIGF0IHRoaXMgZnVuY3Rpb24gYSBiaXQgbW9yZSwgdGhp
cyBjb2RlIGxvb2tzIHByb2JsZW1hdGljOg0KPiANCj4gIMKgwqDCoMKgwqDCoMKgIGlmIChhdG9t
aWNfcmVhZCgmcC0+cG9pc29uKSkgew0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGtmZF91bnJlZl9wcm9jZXNzKHApOw0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJldHVybjsNCj4gIMKgwqDCoMKgwqDCoMKgIH0NCj4gDQo+ICDCoMKgwqDCoMKgwqDCoCBhdG9t
aWNfc2V0KCZwLT5wb2lzb24sIDEpOw0KPiAgwqDCoMKgwqDCoMKgwqAga2ZkX3VucmVmX3Byb2Nl
c3MocCk7DQo+IA0KPiBEb2luZyB0aGUgcmVhZCBhbmQgc2V0IGFzIHR3byBzZXBhcmF0ZSBvcGVy
YXRpb25zIGlzIG5vdCBhdG9taWMuIFlvdSBzaG91bGQgdXNlDQo+IGF0b21pY19jbXB4Y2hnIGhl
cmUgdG8gbWFrZSBzdXJlIHRoZSBwb2lzb24tY29uc3VtcHRpb24gaXMgaGFuZGxlZCBvbmx5DQo+
IG9uY2U6DQo+IA0KPiAJb2xkX3BvaXNvbiA9IGF0b21pY19jbXB4Y2hnKCZwLT5wb2lzb24sIDAs
IDEpOw0KPiAJa2ZkX3VucmVmX3Byb2Nlc3MocCk7DQo+IAlpZiAob2xkX3BvaXNvbikNCj4gCQly
ZXR1cm47DQo+IAkvKiBoYW5kbGUgcG9pc29uIGNvbnN1bXB0aW9uICovDQo+IA0KPiBBbHRlcm5h
dGl2ZWx5IHlvdSBjb3VsZCB1c2UgYXRvbWljX2luY19yZXR1cm4gYW5kIGRvIHRoZSBwb2lzb24g
aGFuZGxpbmcgb25seSBpZg0KPiB0aGF0IHJldHVybnMgZXhhY3RseSAxLg0KDQpbVGFvXSB0aGFu
a3MsIGFjY2VwdGVkLg0KDQo+IA0KPiBSZWdhcmRzLA0KPiAgwqAgRmVsaXgNCj4gDQo+IA0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogVGFvIFpob3UgPHRhby56aG91MUBhbWQuY29tPg0KPiA+IC0t
LQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2ludF9wcm9jZXNzX3Y5LmMg
fCAxMyArKysrKysrKystLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9pbnRfcHJvY2Vzc192OS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfaW50X3Byb2Nlc3NfdjkuYw0KPiA+IGluZGV4IDdlZWRiY2QxNDgyOC4uZjdk
ZWYwYmYwNzMwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9pbnRfcHJvY2Vzc192OS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX2ludF9wcm9jZXNzX3Y5LmMNCj4gPiBAQCAtOTEsMTEgKzkxLDE2IEBAIGVudW0gU1FfSU5U
RVJSVVBUX0VSUk9SX1RZUEUgew0KPiA+ICAgI2RlZmluZSBLRkRfU1FfSU5UX0RBVEFfX0VSUl9U
WVBFX19TSElGVCAyMA0KPiA+DQo+ID4gICBzdGF0aWMgdm9pZCBldmVudF9pbnRlcnJ1cHRfcG9p
c29uX2NvbnN1bXB0aW9uKHN0cnVjdCBrZmRfZGV2ICpkZXYsDQo+ID4gLQkJCQl1aW50MTZfdCBw
YXNpZCwgdWludDE2X3Qgc291cmNlX2lkKQ0KPiA+ICsJCQkJY29uc3QgdWludDMyX3QgKmloX3Jp
bmdfZW50cnkpDQo+ID4gICB7DQo+ID4gKwl1aW50MTZfdCBzb3VyY2VfaWQsIHBhc2lkOw0KPiA+
ICAgCWludCByZXQgPSAtRUlOVkFMOw0KPiA+IC0Jc3RydWN0IGtmZF9wcm9jZXNzICpwID0ga2Zk
X2xvb2t1cF9wcm9jZXNzX2J5X3Bhc2lkKHBhc2lkKTsNCj4gPiArCXN0cnVjdCBrZmRfcHJvY2Vz
cyAqcDsNCj4gPg0KPiA+ICsJc291cmNlX2lkID0gU09DMTVfU09VUkNFX0lEX0ZST01fSUhfRU5U
UlkoaWhfcmluZ19lbnRyeSk7DQo+ID4gKwlwYXNpZCA9IFNPQzE1X1BBU0lEX0ZST01fSUhfRU5U
UlkoaWhfcmluZ19lbnRyeSk7DQo+ID4gKw0KPiA+ICsJcCA9IGtmZF9sb29rdXBfcHJvY2Vzc19i
eV9wYXNpZChwYXNpZCk7DQo+ID4gICAJaWYgKCFwKQ0KPiA+ICAgCQlyZXR1cm47DQo+ID4NCj4g
PiBAQCAtMjcwLDcgKzI3NSw3IEBAIHN0YXRpYyB2b2lkIGV2ZW50X2ludGVycnVwdF93cV92OShz
dHJ1Y3Qga2ZkX2RldiAqZGV2LA0KPiA+ICAgCQkJCQlzcV9pbnRyX2Vycik7DQo+ID4gICAJCQkJ
aWYgKHNxX2ludHJfZXJyICE9DQo+IFNRX0lOVEVSUlVQVF9FUlJPUl9UWVBFX0lMTEVHQUxfSU5T
VCAmJg0KPiA+ICAgCQkJCQlzcV9pbnRyX2VyciAhPQ0KPiBTUV9JTlRFUlJVUFRfRVJST1JfVFlQ
RV9NRU1WSU9MKSB7DQo+ID4gLQ0KPiAJZXZlbnRfaW50ZXJydXB0X3BvaXNvbl9jb25zdW1wdGlv
bihkZXYsIHBhc2lkLCBzb3VyY2VfaWQpOw0KPiA+ICsNCj4gCWV2ZW50X2ludGVycnVwdF9wb2lz
b25fY29uc3VtcHRpb24oZGV2LCBpaF9yaW5nX2VudHJ5KTsNCj4gPiAgIAkJCQkJcmV0dXJuOw0K
PiA+ICAgCQkJCX0NCj4gPiAgIAkJCQlicmVhazsNCj4gPiBAQCAtMjkxLDcgKzI5Niw3IEBAIHN0
YXRpYyB2b2lkIGV2ZW50X2ludGVycnVwdF93cV92OShzdHJ1Y3Qga2ZkX2RldiAqZGV2LA0KPiA+
ICAgCQlpZiAoc291cmNlX2lkID09IFNPQzE1X0lOVFNSQ19TRE1BX1RSQVApIHsNCj4gPiAgIAkJ
CWtmZF9zaWduYWxfZXZlbnRfaW50ZXJydXB0KHBhc2lkLCBjb250ZXh0X2lkMCAmDQo+IDB4ZmZm
ZmZmZiwgMjgpOw0KPiA+ICAgCQl9IGVsc2UgaWYgKHNvdXJjZV9pZCA9PSBTT0MxNV9JTlRTUkNf
U0RNQV9FQ0MpIHsNCj4gPiAtCQkJZXZlbnRfaW50ZXJydXB0X3BvaXNvbl9jb25zdW1wdGlvbihk
ZXYsIHBhc2lkLA0KPiBzb3VyY2VfaWQpOw0KPiA+ICsJCQlldmVudF9pbnRlcnJ1cHRfcG9pc29u
X2NvbnN1bXB0aW9uKGRldiwNCj4gaWhfcmluZ19lbnRyeSk7DQo+ID4gICAJCQlyZXR1cm47DQo+
ID4gICAJCX0NCj4gPiAgIAl9IGVsc2UgaWYgKGNsaWVudF9pZCA9PSBTT0MxNV9JSF9DTElFTlRJ
RF9WTUMgfHwNCg==
