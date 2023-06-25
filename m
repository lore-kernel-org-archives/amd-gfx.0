Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69D1EB64DA
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Jun 2023 01:42:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B87CC10E044;
	Sun, 25 Jun 2023 01:42:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DC9F10E044
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jun 2023 01:42:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUheD61m3XnOYi7OKH3IjF+Fdj1dxbg0idQhobDWbOxZxbkeLHryT0jAoG+Xuv04LGAEI30CgZUV23mke7ZQhSowpJ27Tz8aWYufim/Qy+Y1ptWceCKydmw8TomK2c16eQkOgAgBai/allqvVm/aWBjK4xChloqsZmiZJ7EWC5GAHzMH2Kc6PNZQiGvK6fCi6AL56ue83JI1n5lSHdDHiOkGTXBC1MKfUTY6uSiZ6izQVhVtAO3CNVWR/ALUhAl0C4Q/kDkWkXTjqlSJ3JUgP9Rtj5GJ7nrPshq75HJ2xHFYIE5IxAtdQlRvYU5O2akVvNpcbarey+uuKnwW8EAjzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cX4ndlSJPbvSjPOfuoOxgpX42JmKVfcY8D0PCDnCRg=;
 b=R0ePnojczkGNnguiANpP2X5IwotGpMX2Xgz6o7HofkHfzvAMuZfWQcNYKKzyhYmQ/taihhDMw5jknw/0L6ga+iVgms6evIpCWwLQXP3ily3XDlwHEybGQ23tk1MoJitKyG+RK2hpFC7LfptqmEUgY/a8YoHEURmk5kjLHcBaP5TPFoI1HMYG5ZEcAypRuIUvS8m1wf256DmfswrbPi+aENDoO9LgkKHLLCBXGRrhMICHeI1ASBY/ZlBu0YSpTbGkB9oa75Jp70An37JC01e2OvrZjidDEXo2P7OICLn5+DSmgQtIncZNveJhtQ0MvyVIq+nvZZX7EMI38qsoyATa6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cX4ndlSJPbvSjPOfuoOxgpX42JmKVfcY8D0PCDnCRg=;
 b=BO+n+g07fslS8fFeo1DWB1iWIuOvSRheyAkzAS5bHlBPkCzjYCLx2GOQctU+ucZ+gcn6ujM6eVNPwiiopXRgoGpE9ZE6lAlRiAx3JusO6upVY1wS/cUM6jIK/kM3Ug7lwNCHWlOFZokLi8OcvozFM1+UeS1yyqr/gLogKRtLe9M=
Received: from BL0PR12MB2465.namprd12.prod.outlook.com (2603:10b6:207:45::18)
 by DM6PR12MB4926.namprd12.prod.outlook.com (2603:10b6:5:1bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sun, 25 Jun
 2023 01:42:27 +0000
Received: from BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::913:ccd7:a696:649b]) by BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::913:ccd7:a696:649b%4]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 01:42:27 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, Ben Hutchings <ben@decadent.org.uk>
Subject: RE: Possible missing firmware
 /lib/firmware/amdgpu/sienna_cichlid_mes.bin navi10_mes.bin for module amdgpu
Thread-Topic: Possible missing firmware
 /lib/firmware/amdgpu/sienna_cichlid_mes.bin navi10_mes.bin for module amdgpu
Thread-Index: AQHZpFaBbgpvoWoueESeZFENG407Sa+YmEYAgAIq2/A=
Date: Sun, 25 Jun 2023 01:42:27 +0000
Message-ID: <BL0PR12MB2465CE4DE4AE99B58DF6B79DF121A@BL0PR12MB2465.namprd12.prod.outlook.com>
References: <168258140711.32181.12062781302326675605.reportbug@atzlinux-arm64>
 <2e6faab830d01849a8eec6871d66787db455864e.camel@decadent.org.uk>
 <CADnq5_OXO8emTUa8A6SAWpnpbfZCOT3QHaj5J1iQKCi2h1vdew@mail.gmail.com>
In-Reply-To: <CADnq5_OXO8emTUa8A6SAWpnpbfZCOT3QHaj5J1iQKCi2h1vdew@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=0035c9eb-057f-41de-9bad-c2d582a5d239;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-25T01:39:42Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB2465:EE_|DM6PR12MB4926:EE_
x-ms-office365-filtering-correlation-id: 20cb003f-cef9-4191-dbb3-08db751d6ecd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fRw/3W3xWXERyuzhKkqyc3doaAHoIYqCWTRhI0JueNyEuLWYI+kg8pcDiRgeBOfITSgQH+WAD9MfuCJJI1CXOkVP0XWCwF9xJykwMGWq5eiVgWfd8TIRymfks/0aS42+zndBliXNLS8x+hUEvJ2kQqUXYrkc3+ClX3Wwvi4WA9nxqa1sSSpmIToGfDXEVmixS23Ui0XbqxDsfK9v/zUorIyGS/TAswaNaxxNeFRzmwiXqBu0ZKcbtrBMUPGgqkU8zn47kOyAoQ7nzMtTMB3rkCGpVwjik8drQTFiBD+niGidcpWAgej1jBTygNaff5KhN0Z41k8gu3Ao3Km5wiwcVGpxvU1BrceatMmK79bR6ZjibXHvfWBodE9l00CNr7jfRgf1suQZCieyVwV2ZeoinUK+xtw2caa+gbRbXPxRiohZ27v8+4MR5heYtXlanG+RxkPCe6V8lD4q82jZNma/Qv+lA8plDOyZI2RkMtnzfLq15FUeBjbC3BcBChDeNlY3kVHLoqaEgdzkg9P7V/RsXLL2k3WGNcnwRGT3sqLwZTjhUnzEJvWCtJGT5ysXXCn2PLHxeCFByOTOk6DrrxHQjrmbfCoj408ado/N7rdUJNrSZ24rTdGB/fvRZZfERfdV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2465.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199021)(478600001)(7696005)(71200400001)(54906003)(110136005)(83380400001)(53546011)(6506007)(26005)(186003)(9686003)(2906002)(5660300002)(52536014)(33656002)(38100700002)(122000001)(76116006)(4326008)(66946007)(55016003)(8936002)(8676002)(41300700001)(316002)(86362001)(66476007)(66556008)(64756008)(38070700005)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aG1XclFsaEszNy93STRrNXk2WjJTQTg5Nnk2QTdMSll3VHRuempGY3M3aGEv?=
 =?utf-8?B?bVBNNGZ2UGxqcFBwdG9MQzJzMndyOWhOajVLaEZPajk4RjBGZ2RBUGk4Z3VK?=
 =?utf-8?B?QXYxeGxsOWdXWHBIYWNFWndTcDRUL00rZmt5K1Y3VS9Ha3JpOWJtWjA5dkFN?=
 =?utf-8?B?bXh2ckc3M0xpM3NBS1FlZEFmdzBHbEhsc1dlVVhNMTVSL1RZdmkzNlU5a3dh?=
 =?utf-8?B?T1IyTnFEQktVVkZmWWwyQjZjRXgybGFwN2tIejVYTkFNdTJMcWxEVVBlSi90?=
 =?utf-8?B?R0J6N0ZBck93SDlKUEhvVG43UE5NNXZOVW0vV0NLTmdQYmgvOVJTaitPNHJ2?=
 =?utf-8?B?dzJWQzFVSnNNRnUyRHd1OXd6TDRLa3V3OUdUZFh6bVlnQkUxYWIyN1Y3dUFu?=
 =?utf-8?B?ZTByQ3d0bXZDUEhTVHFwQWF2ZlgrMEk5YTRKMW50djNzN2p6QzVURzYxQ3ps?=
 =?utf-8?B?OThITlRSQ2hMSld1aGxEUXpUaUtLQUVTQTJWMGpjNWhMM0JZSnp3WGkzdjFo?=
 =?utf-8?B?VVVUK1o4SFVGSTlpRnhoTFovZHpYSXdjMUdyWWVHZnR1UU9GLzNFY1Zlb0Nw?=
 =?utf-8?B?bm42dVI5M1B0OEtEZ2pwdWVoT0R6L1RmbndhWUlway9BTGtjYjYySFE5TzRq?=
 =?utf-8?B?UFUzRXdONU90d2JtWS9pVzRYa3E0ZVoyNnlrdUhGRlgzdWJxOFAyU3ZDYWYr?=
 =?utf-8?B?Wlllc2kxWGFNTkJhZWRrejVKY2p1akxNS0poK1VLeFFidXJxTmFMUlJrNWU4?=
 =?utf-8?B?YXBVdVBWMmtKdFdmbzdxTmlCc2VrckxQZ2kySHBWNDJ1MnVjRCtnbjB0cFhp?=
 =?utf-8?B?d05WLytRejJ5eVlxd3F2K2RBL0lna2ZOWUs2YXR5bytLUEhxOXBGVFJFNkh2?=
 =?utf-8?B?OHpVZ3RpaW52Q2NKNm0wVFdOQmVmeHF0SGFFajAwR2hIRElYcjhOZnZyd1NO?=
 =?utf-8?B?aEZwZUFoVmM4UExwOHNHVEFKVGI4VXNFMzZFdUwrNGhyYnBhVktTdG9ta0Q5?=
 =?utf-8?B?VjNvb3ZCQ21SRXg2M2psY3JjeXNsdUhqQWtDWGJtak5IZ2VFeHpqLytBQml0?=
 =?utf-8?B?K1NvMlN0ZmJXeFBrV2szNmxuSU5HL1U5VUhNVFFJY0tiQWxwWllQRkc3cGMw?=
 =?utf-8?B?OU9rc1A3VUZNazNhYitDOTduL3dNN2k0TG01M21zdDJFRm5UMjFyeFI0dzJa?=
 =?utf-8?B?NjhlZ0M4cG1Cd0RFMkJYM1ptMUNuWmFhMW1tK3dJb1JiZjYwYSs0OVJBbWhI?=
 =?utf-8?B?TFZzRk9PZ2NTTDhPUUxWbUp2dkF6NVF1dnVKbDY4eTgrR3M0cklBSERoL1Bq?=
 =?utf-8?B?ckFuWWlqS0M2Y0hjVXhpM1V6SGRtV3VQZ0gxREVSTGxKTFBNVW1WdXFkbG42?=
 =?utf-8?B?UDRtZ2lOcDdjdTg2ckpMdHVGd1JPYmdVMjFnUkZoQVVOc0hoOGRWV1FYcW9Y?=
 =?utf-8?B?MkZFSURBQ01KTVlrRWc4TXZPbmp6WXRSSXdkcEpMdlpoSDZJV0xvbVFwdG4v?=
 =?utf-8?B?K2J2SjdmN3RDVWVTdXJ2YjNCQzVVZE5nWFdTVWVUMHQ5eWRxNlNNMU1mSGZC?=
 =?utf-8?B?TUd2SFhPa0cvbGQ0Qk9XelA0UTg2R0FOTFZsTm1OL3FtTU1JUEVlRFR6c21a?=
 =?utf-8?B?Z1VLakl1WWdubU5uNnBaYWpYdFJlV3dpQk4xZkM5dDdkUTUydkJjNGtHSjFG?=
 =?utf-8?B?N3Q2MUhPT09qMi9kcFJ0dEk0eGh4QkFVRFJYOVorR2JlRkxnWGwyT1BQdTNl?=
 =?utf-8?B?cDRBS3BEL085bE1ZZzFqbVpubHNzQjcvOXUxMnNmY3B1d0VGUkRlVkFhdTNG?=
 =?utf-8?B?UlJUVHR0TG52V3o2QW5XZjB4WHVzWEpoNHFCbHE4WmEyd1Fmc0xtZEJOK3RI?=
 =?utf-8?B?UzU2dUFKTXJhRDZxbEZlMTJwYUErcWJ6VGN6YXhWS0VIOEJkQThiWFREUk5q?=
 =?utf-8?B?d1NOVjh3ZklHNWptV2RGVy96THpqenMzZUJRVm02eVFzUDNJVG56eGRPOHVq?=
 =?utf-8?B?ckF5Sm1KVXUyL1liN2xLNFcvRk84TjcvRmZTYVhiSzNRdnRaR091UmdpcUJq?=
 =?utf-8?B?TGxsS1h5SDRSWUlJUi9xbEdoZngrTStHV3B0SWNrT3J3Uk0xUFRqZ0NXYmJF?=
 =?utf-8?Q?3BzU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2465.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20cb003f-cef9-4191-dbb3-08db751d6ecd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2023 01:42:27.6378 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vMI6mj3O8tQ4O1zD6+lo84ap1E9kOqdNC8yWEJprpH2nSqzt0jfgdy3bzwP23ZPQVYaQbCvGkBF0UC79deNr2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4926
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "1034903@bugs.debian.org" <1034903@bugs.debian.org>,
 =?utf-8?B?eGlhbyBzaGVuZyB3ZW4o6IKW55ub5paH77yJ?= <atzlinux@sina.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4
IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQWxl
eA0KPiBEZXVjaGVyDQo+IFNlbnQ6IFNhdHVyZGF5LCBKdW5lIDI0LCAyMDIzIDEyOjM0IEFNDQo+
IFRvOiBCZW4gSHV0Y2hpbmdzIDxiZW5AZGVjYWRlbnQub3JnLnVrPg0KPiBDYzogeGlhbyBzaGVu
ZyB3ZW4o6IKW55ub5paH77yJIDxhdHpsaW51eEBzaW5hLmNvbT47DQo+IDEwMzQ5MDNAYnVncy5k
ZWJpYW4ub3JnOyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTog
UG9zc2libGUgbWlzc2luZyBmaXJtd2FyZQ0KPiAvbGliL2Zpcm13YXJlL2FtZGdwdS9zaWVubmFf
Y2ljaGxpZF9tZXMuYmluIG5hdmkxMF9tZXMuYmluIGZvciBtb2R1bGUNCj4gYW1kZ3B1DQo+DQo+
IE9uIFdlZCwgSnVuIDIxLCAyMDIzIGF0IDExOjM44oCvQU0gQmVuIEh1dGNoaW5ncyA8YmVuQGRl
Y2FkZW50Lm9yZy51az4NCj4gd3JvdGU6DQo+ID4NCj4gPiBPbiBUaHUsIDI3IEFwciAyMDIzIDE1
OjQzOjI4ICswODAwIHhpYW8gc2hlbmcgd2VuKOiCluebm+aWh++8iQ0KPiA+IDxhdHpsaW51eEBz
aW5hLmNvbT4gd3JvdGU6DQo+ID4gPiBQYWNrYWdlOiBmaXJtd2FyZS1hbWQtZ3JhcGhpY3MNCj4g
PiA+IFZlcnNpb246IDIwMjMwMzEwLTF+ZXhwMQ0KPiA+ID4gU2V2ZXJpdHk6IG5vcm1hbA0KPiA+
ID4gWC1EZWJidWdzLUNjOiBhdHpsaW51eEBzaW5hLmNvbQ0KPiA+ID4NCj4gPiA+IEhpLA0KPiA+
ID4NCj4gPiA+ICBXaGVuIEkgdXBncmFkZSB0byBrZXJuZWwgNS4xMC4wLTIyLWFybTY0LCB0aGVy
ZSBhcmUgZm9sbG93aW5nIGVycm9yDQo+ID4gPiAgaW5mb3M6DQoNCkp1c3QgdG8gY2xhcmlmeSB0
aGF0LCB0aGVzZSBpcyBub3QgZXJyb3IgaW5mby4gVGhpcyBpcyB0aGUgY29tcGxhaW4gZnJvbSBy
YW1mcyB3aGVuIGRldGVjdGluZyBmaXJtd2FyZSBtaXNtYXRjaCBiZXR3ZWVuIGRpcmVjdG9yeSAn
L2xpYi9maXJtd2FyZScgYW5kIHRoZSBmaXJtd2FyZSBuYW1lcyByZWZlcmVuY2VkIGJ5IGFtZGdw
dS5rbyBkcml2ZXIuDQoNClJlZ2FyZHMsDQpHdWNodW4NCg0KPiA+ID4gVzogUG9zc2libGUgbWlz
c2luZyBmaXJtd2FyZQ0KPiA+ID4gL2xpYi9maXJtd2FyZS9hbWRncHUvc2llbm5hX2NpY2hsaWRf
bWVzLmJpbiBmb3IgbW9kdWxlIGFtZGdwdQ0KPiA+ID4gVzogUG9zc2libGUgbWlzc2luZyBmaXJt
d2FyZSAvbGliL2Zpcm13YXJlL2FtZGdwdS9uYXZpMTBfbWVzLmJpbiBmb3INCj4gPiA+IG1vZHVs
ZSBhbWRncHUNCj4gPiBbLi4uXQ0KPg0KPiBUaG9zZSBjb3VsZCBiZSBkcm9wcGVkLiAgVGhleSBh
cmUgbm90IHJlYWxseSB1c2VkIGJ5IHRoZSBkcml2ZXIuICBUaGV5IGFyZSBmb3INCj4gYSBmZWF0
dXJlIHdoaWNoIHdhcyBub3QgdWx0aW1hdGVseSBwcm9kdWN0aXplZCBvbiB0aG9zZSBwYXJ0cy4N
Cj4NCj4gPg0KPiA+IEkgc2VlIHRoYXQgdGhlIGFtZGdwdSBkcml2ZXIgaGFzIGhhZCByZWZlcmVu
Y2VzIHRvIHRoZXNlIGZpbGVzIGZvcg0KPiA+IHNldmVyYWwgeWVhcnMsIGJ1dCB0aGV5J3ZlIG5l
dmVyIGJlZW4gYWRkZWQgdG8gbGludXgtZmlybXdhcmUuZ2l0Lg0KPiA+IE1vcmUgcmVjZW50bHkg
YW1kZ3B1IGFkZGVkOg0KPiA+DQo+ID4gTU9EVUxFX0ZJUk1XQVJFKCJhbWRncHUvZ2NfMTFfMF8z
X21lcy5iaW4iKTsNCj4gPiBNT0RVTEVfRklSTVdBUkUoImFtZGdwdS9nY18xMV8wXzNfbWVzXzIu
YmluIik7DQo+ID4gTU9EVUxFX0ZJUk1XQVJFKCJhbWRncHUvZ2NfMTFfMF8zX21lczEuYmluIik7
DQo+ID4NCj4gPiBhbmQgdGhlc2UgYXJlIGFsc28gbWlzc2luZyBmcm9tIGxpbnV4LWZpcm13YXJl
LmdpdC4NCj4gPg0KPiA+IElzIHRoaXMgZmlybXdhcmUgaW50ZW5kZWQgdG8gYmUgYXZhaWxhYmxl
IHRvIHRoZSBwdWJsaWM/DQo+DQo+IFllcywgdGhvc2Ugd2lsbCBiZSBhdmFpbGFibGUgc29vbi4N
Cj4NCj4gQWxleA0K
