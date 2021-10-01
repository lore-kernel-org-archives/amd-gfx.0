Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86D3C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 08:21:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9AD61A57
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 08:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B9AD61A57
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00C806E50D;
	Fri,  1 Oct 2021 08:21:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 047EA6E50D
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 08:21:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/V+NxqLJotpVKzZQma5LaQs+I2CjjjtgGzGMBEDIyQGm9aSACZox051xzL9YWu6EQ7AVpOBrwfnLG95YNymp6iVmmAkXgaYEeqk+oFeWvBkRHDWaiwXrN/u6gEwumCJrmF2hcUgIbkZV8q8t2fpIpRM1F7t0wOcHMUc7CN80YyYUatV0yGFBGGD2J1Y2PBoxCBBPvafYGm7uZourthvYmkdzXGH447/sL29Eh4pHpZ6/BAydRQf4/gCalOR7CicfJajWTxLWU3+03BGBeGuBmfWJtG3X3M0+HRIy3ipMWhH16zzbGu9uRl+O63xLOALo/mYvUhW+cqvP+UFp4cwxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xq8RfgNETQz79pUz9OzoP3+EG+7L8BnpFqgAzJqRN/k=;
 b=b6LpT86TxwAzC1WhRdZr5my5AyZKvzeLdckWre480KOHn7MiBRhBVV+s+kZbrRnsQevZ9G0hgG8PTQBjGrlPxsbnXYn59VQFVhULjUxfbFZZEhnbxC5KK/wS2aU98W4f8pELAH14btT4y4BAXXjLc12G1iyy4E4J3AGG1pEtVdenA96JQBnLQLAEQ5lZUn0ykZNCO51tTUYd1LuRXqtfRLRNbe83CjvNuNWCdPlILI2iJWctCFRw9QLl6PXE2Q7JSyeYD5QWBLpKdLCMlSnXfHDJQ07s8syemenscw7vit04azg52oTOBaA33rEaJRgDQo05/S8MNEW4kMsAP9F43A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xq8RfgNETQz79pUz9OzoP3+EG+7L8BnpFqgAzJqRN/k=;
 b=ix5mWGh0F1aReIdn2yBWJp1GnJkVXqAqpLBvZsm+yeotmMdruqm1dUKcbSZ4MTkXskP3tlRl6PIoITGOZYZT8DNBupoBbxT2bhIzqNj2Ewx6SL5VEDQDFyzEcplrqZquYNtGwTLKyy3KCcjx8QH9cDlgciEYwSMmRX0JMe7kJ8M=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3276.namprd12.prod.outlook.com (2603:10b6:5:15e::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15; Fri, 1 Oct 2021 08:21:26 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::bd0e:e376:6277:8109]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::bd0e:e376:6277:8109%6]) with mapi id 15.20.4566.017; Fri, 1 Oct 2021
 08:21:26 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add missed write lock for pci detected state
 pci_channel_io_normal
Thread-Topic: [PATCH] drm/amdgpu: add missed write lock for pci detected state
 pci_channel_io_normal
Thread-Index: AQHXtmgcFP6hLZvNJE64Efk6FSBEOKu9aU0AgABjvXA=
Date: Fri, 1 Oct 2021 08:21:25 +0000
Message-ID: <DM5PR12MB2469D34B746A0C1927906879F1AB9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211001020000.14501-1-guchun.chen@amd.com>
 <b7febaef-5442-1503-d743-24a6c50fa179@amd.com>
In-Reply-To: <b7febaef-5442-1503-d743-24a6c50fa179@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-01T08:21:22Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=3f7a7e19-3aed-46d0-8d2b-bad5e06279b0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c487bc7-4136-4efa-925f-08d984b4761c
x-ms-traffictypediagnostic: DM6PR12MB3276:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB32767766938329A0158C5047F1AB9@DM6PR12MB3276.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q/SdGGrFNlpdbQu+0qQ6W48nQQ1WVuYu30Z4487pi8opdvLJBNyY0uZkvHaCCm84PlLorrc8GlYJeonSaOSS0vbjHgK7IGeD7dRFfkNonTFved2LXi1qV/9ix1/NGg3YgoEyAMLgkh2WLj5XQRHpmuHqf6QTom7PVtF7NqBvl/iVnvCsLL+bGSEhqbJDm9gCkyuTIkCyPW3cXhUV7FrRNBoJOlhY2Abn/s9xbtLmmM6wxhCnXbaYnsipqtIDu8tI54F6hmVCod8BUz6OI7H16xXfN6nlethW6AllVOvdHKK5VEuWujbJtW9Ek4W1FniBlz2MDfrFxslB3hzVsAc74s1rwVeTI5XTpZI1T9SNs13nqB620FllxI6ELRj7ItNbDHfoAgz2Pl9WZ+Mc+doMRv7hU4nLbYPWddy/+HVsRfTsynKiSBLAgxHmzfFf8yF+SeXSrbDGArHU0KsG6nFj4vYmHRp7WcgV+GKtpeC7EXc+RkG5N+9SiKOyYhabLKXu74alsvLVf5RO73r3St0IIsWZvSjQD5Hens6VZQRGU7Mz56HaNZH+KrjHtjwaUiSplQtdySbYdTMHjp6WE2CJgNpNzf3tMgyLzqDHj2CHIfAQO/pJcVhNs06bHjLn2CInmNdQw9pO4oYtBNP5Q2xtn8m6W62GW3qxn0xSS426CdewANCiH4Kcirw795gqK4svYhXxhWCSJm/89Dju6aAMaA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(66446008)(6636002)(316002)(71200400001)(66946007)(66476007)(66556008)(64756008)(6506007)(53546011)(83380400001)(86362001)(76116006)(33656002)(2906002)(38100700002)(7696005)(8936002)(52536014)(5660300002)(26005)(122000001)(9686003)(55016002)(186003)(8676002)(508600001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmtZVzBPQXMwb3ZtRXdDUHFnTHFPSkZTV25Jak82NCtDU29HNzdMTm1lb1NQ?=
 =?utf-8?B?cDREREM2eGhseXNPSkovcW1zUWppZVVaUGFDU0VrVTJGalVVN2FsS2xOZjRU?=
 =?utf-8?B?VWEzTS9zbklNUTVDYkpkY3BtaDFTMmxtVUNCWXUzWEF1MVRQby9TNi9YNjkr?=
 =?utf-8?B?NVJ2ZUc1TExWRklpWWk0WjU4ZStGd2ZnMmNsbmZHRURlVzl6aUpyMG8zak1h?=
 =?utf-8?B?K2lxWkNST3ZLTUtlTC96eVk0UUk4U1dWZ3hlazBnK3BRTlZjeVNVeVVNOTVK?=
 =?utf-8?B?cG5TVFJ3MG1CQWpTR0ovaGVLVlp3cldHbkE0SEhSenZNZXBRTUxaZjNCdWtJ?=
 =?utf-8?B?K1E1eVhKSWhvNndhbDd4cDNISXFVR1RteWIvSjZmUHVGcFRKM0dpcWNINVVG?=
 =?utf-8?B?UlI1WnpsUVVjelhtQnVka2VuTU41clhzdFJuVFpXTzlaQzFqMzVMWEg3RERJ?=
 =?utf-8?B?aWN1SVc0bmFnWVdFTlhUdVRFZjA0TlpsVjJzc2FvN1NDMDFqMWZGUHlJTVlp?=
 =?utf-8?B?REpQMDZWUFEwcCtXLzlYN1d6SmMraU1KdmVTVE1TQ0dHZ09rSktCZ3pZUUNB?=
 =?utf-8?B?MzR5Z0xTV0F5VnRXME8zRmdaS1JOMnVKV3ZXYUNqUmlJWXJHVUxvREdBanlL?=
 =?utf-8?B?dUFHSk1PcHY0by9VckxZanhQMDlEUlJLQ0RWV1g1elJKbko3SnpsSXk0ZDFZ?=
 =?utf-8?B?eFl0MmI4UTg4bWJDOHA0RXNtQlFQMStKdEg5YzN4SkhZRWJPL3J1U2RPZDBW?=
 =?utf-8?B?bzZ0WG5xb00wUDRTWWpobnNRdGlzbEltQVYyckViVUQvMXBiWW10M1VDSk1B?=
 =?utf-8?B?Zy9hTmNkODExUXUwS2dIV3Q4VWp0cWhEMVZlSXprajJiQWxKS3dhYTFsUVNa?=
 =?utf-8?B?VWJ5YWJsenFoOWJ4NnZ0bDVGVGM1UnYxdWduYVZEWjY5S3RDd2VFZlExWTVs?=
 =?utf-8?B?NVpyeWlZQzA3ejhyWDUyQ2ZrZ0VneUw0dTJNVm9UTThXZmJpTUNoaUx1MHFL?=
 =?utf-8?B?MXhHQVBmQXkweTdseDdnUEdlbTJiSGtsQXVBaTcrYlVPZ1ZReXhDdGUyRjZR?=
 =?utf-8?B?LzhNK2wzUDBLbnp5VWdMQ3VVTGZYUHc0S2ZPNkpiei9rU0pmclpVRG1sTjhE?=
 =?utf-8?B?UEIyMWlSd3M5blNYamJIWkVMUUgwYStRV0x6ZTdPd1lSQll5UmJ0ZnNxVjJ0?=
 =?utf-8?B?d3FsbVRVdkNrUmpKQ1RCSGhJcThBUm81QzJ0SVMwaWNLd0FUV3RlOVgxekJT?=
 =?utf-8?B?cDljYjMxRHJIcFlwdDkxUWVYZWJZenVDUUd6TXQrekxxQjBXL3dCT0xLdktQ?=
 =?utf-8?B?M1lBSXROT1llUXE0WEwrc2NYSzNvekN6dWx6bzBIYkFJQk56dEJLNEdFVWxU?=
 =?utf-8?B?TCtMcFcxK2JCRXJCTmhkN24wMkh3RDVPTE1qa2ZzVm4vRHBOSE1uamo0L3Va?=
 =?utf-8?B?QUM2Zzd3cDVSMDRUOFY3WDQ3dm1GNlVYT2dlQkxrMHdZeFEyTTlTQW4yQ2s0?=
 =?utf-8?B?ejJnWnVxUFN3eGtJNDV5bDlaOHBoeTBVZEIybzQ3REFhQWVlZmowN1NxRHk0?=
 =?utf-8?B?anlHL1hidmFMNUJDWjl5cFhnVjNLT3NMeEZteWxhOTk2c244aURoVzQza3do?=
 =?utf-8?B?UG9TZ1VIUnFST3lETEZSWUttVWVrWFhQZ3M4R3ZGdjIwd1pKSEIvOUFHUjNF?=
 =?utf-8?B?NVFoeG5uVUhwV3czZlQ0aFJIdTZvRUZLUGRzWGNUQWY3WWprWDdtQWNYVzR1?=
 =?utf-8?Q?4XNRTt/dUHuZ9K7JlT8v52CbYX5dmfzvGHGIRNB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c487bc7-4136-4efa-925f-08d984b4761c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 08:21:25.8640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n3jPStXztJ2BAO8iGmQ4KMuQIrg8uShul0wTS3fhayTVqeVHBIf7cSIaswesrDccCYO5BJdC+QEP5U+YHsnyvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3276
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

W1B1YmxpY10NCg0KSGkgQW5kcmV5LA0KDQpEbyB5b3UgbWVhbiB0byBtb3ZlIHRoZSBjb2RlIG9m
IGRybV9zY2hlZF9yZXN1Ym1pdF9qb2JzIGFuZCBkcm1fc2NoZWRfc3RhcnQgaW4gYW1kZ3B1X3Bj
aV9yZXN1bWUgdG8gYW1kZ3B1X3BjaV9lcnJvcl9kZXRlY3RlZCwgdW5kZXIgdGhlIGNhc2UgcGNp
X2NoYW5uZWxfaW9fZnJvemVuPw0KVGhlbiBsZWF2ZSBhbWRncHVfcGNpX3Jlc3VtZSBhcyBhIG51
bGwgZnVuY3Rpb24sIGFuZCBpbiB0aGlzIHdheSwgd2UgY2FuIGRyb3AgdGhlIGFjcXVpcmUvbG9j
ayB3cml0ZSBsb2NrIGZvciBjYXNlIG9mIHBjaV9jaGFubmVsX2lvX25vcm1hbCBhcyB3ZWxsPw0K
DQpSZWdhcmRzLA0KR3VjaHVuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBH
cm9kem92c2t5LCBBbmRyZXkgPEFuZHJleS5Hcm9kem92c2t5QGFtZC5jb20+IA0KU2VudDogRnJp
ZGF5LCBPY3RvYmVyIDEsIDIwMjEgMTA6MjIgQU0NClRvOiBDaGVuLCBHdWNodW4gPEd1Y2h1bi5D
aGVuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgS29lbmlnLCBDaHJp
c3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IFBhbiwgWGluaHVpIDxYaW5odWkuUGFu
QGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+
DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBhZGQgbWlzc2VkIHdyaXRlIGxvY2sg
Zm9yIHBjaSBkZXRlY3RlZCBzdGF0ZSBwY2lfY2hhbm5lbF9pb19ub3JtYWwNCg0KT24gMjAyMS0w
OS0zMCAxMDowMCBwLm0uLCBHdWNodW4gQ2hlbiB3cm90ZToNCg0KPiBXaGVuIGEgUENJIGVycm9y
IHN0YXRlIHBjaV9jaGFubmVsX2lvX25vcm1hbCBpcyBkZXRlY3RkLCBpdCB3aWxsIA0KPiByZXBv
cnQgUENJX0VSU19SRVNVTFRfQ0FOX1JFQ09WRVIgc3RhdHVzIHRvIFBDSSBkcml2ZXIsIGFuZCBQ
Q0kgZHJpdmVyIA0KPiB3aWxsIGNvbnRpbnVlIHRoZSBleGVjdXRpb24gb2YgUENJIHJlc3VtZSBj
YWxsYmFjayByZXBvcnRfcmVzdW1lIGJ5IA0KPiBwY2lfd2Fsa19icmlkZ2UsIGFuZCB0aGUgY2Fs
bGJhY2sgd2lsbCBnbyBpbnRvIGFtZGdwdV9wY2lfcmVzdW1lIA0KPiBmaW5hbGx5LCB3aGVyZSB3
cml0ZSBsb2NrIGlzIHJlbGVhc2QgdW5jb25kaXRpb25hbGx5IHdpdGhvdXQgYWNxdWlyaW5nIA0K
PiBzdWNoIGxvY2suDQoNCg0KR29vZCBjYXRjaCBidXQsIHRoZSBpc3N1ZSBpcyBldmVuIHdpZGVy
IGluIHNjb3BlLCB3aGF0IGFib3V0IGRybV9zY2hlZF9yZXN1Ym1pdF9qb2JzIGFuZCBkcm1fc2No
ZWRfc3RhcnQgY2FsbGVkIHdpdGhvdXQgYmVpbmcgc3RvcHBlZCBiZWZvcmUgPyBCZXR0ZXIgdG8g
cHV0IHRoZSBlbnRpcmUgc2NvcGUgb2YgY29kZSBpbiB0aGlzIGZ1bmN0aW9uIHVuZGVyIGZsYWcg
dGhhdCBzZXQgb25seSBpbiBwY2lfY2hhbm5lbF9pb19mcm96ZW4uIEFzIGZhciBhcyBpIHJlbWVt
YmVyIHdlIGRvbid0IG5lZWQgdG8gZG8gYW55dGhpbmcgaW4gY2FzZSBvZiBwY2lfY2hhbm5lbF9p
b19ub3JtYWwuDQoNCkFuZHJleQ0KDQoNCj4NCj4gRml4ZXM6IGM5YTZiODJmNDVlMigiZHJtL2Ft
ZGdwdTogSW1wbGVtZW50IERQQyByZWNvdmVyeSIpDQo+IFNpZ25lZC1vZmYtYnk6IEd1Y2h1biBD
aGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAxICsNCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kZXZpY2UuYyANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2
aWNlLmMNCj4gaW5kZXggYmI1YWQyYjZjYTEzLi4xMmY4MjJkNTFkZTIgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gQEAgLTUzNzAsNiArNTM3
MCw3IEBAIHBjaV9lcnNfcmVzdWx0X3QgDQo+IGFtZGdwdV9wY2lfZXJyb3JfZGV0ZWN0ZWQoc3Ry
dWN0IHBjaV9kZXYgKnBkZXYsIHBjaV9jaGFubmVsX3N0YQ0KPiAgIA0KPiAgIAlzd2l0Y2ggKHN0
YXRlKSB7DQo+ICAgCWNhc2UgcGNpX2NoYW5uZWxfaW9fbm9ybWFsOg0KPiArCQlhbWRncHVfZGV2
aWNlX2xvY2tfYWRldihhZGV2LCBOVUxMKTsNCj4gICAJCXJldHVybiBQQ0lfRVJTX1JFU1VMVF9D
QU5fUkVDT1ZFUjsNCj4gICAJLyogRmF0YWwgZXJyb3IsIHByZXBhcmUgZm9yIHNsb3QgcmVzZXQg
Ki8NCj4gICAJY2FzZSBwY2lfY2hhbm5lbF9pb19mcm96ZW46DQo=
