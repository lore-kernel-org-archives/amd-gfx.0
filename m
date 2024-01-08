Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F7AC3DA6E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 22:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E360D10E30A;
	Mon,  8 Jan 2024 22:32:33 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BB1810E30A
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 22:32:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbgKrSs7Qf/mzGXTpP6ND0cFB8xdG109p1MCBqkqJXeBacOJ2Oyxfp7Sqa+iyzOY0tuiZWLZ67AkM66Vhyp1M6hLYfO1qVM1LeiBfnAtCT+eQKqUgjAZqDoj5HtndBfWZY3rlbOiu1IZel5LEqr1jfS05Q7cH4kArWu9nbhbwCHiEbOAiYU1t1ytwLsXU7OKfAN7GJnhUV40Vf9h5E7GPmL0ejKBQMB6U5JksW/JIIoMhxZGbzlSMWgUr9uRa97zOrvgaQt33rz5A6vvkCo4XOrvdzY6ZI//QYdQdXKkw/amyl+ZdT5ifq8zfE7v0CESaAmIoMr9VGEXPILtZ9hOqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jGwYcMs7f3j4zneYw6HClsvEUvnP62Lm/ahz0CuOKo=;
 b=cuUnGgJdz/4KFQTGlLkXlBJqO4Ek/TgTxhpheU4Svz7Xvxc3GY3lkyjlxYZ3LKkIpwsq5GZ+7mrbW5SpmdTiLdWo5cdUEzsAzzCC2VnjSSmUGOOkLzErDMGzNWFPC8NYgn0DQCAjCnUV1UoBRYz1KIvU5z/vBbwMEiiS5zEcYKp9Ama5VbTjPpHyKI075tLBSTNyXgcne9N1J7C1Jgi+DL9sfJs+njNp0N9ypzcxi8Qek1kJAqpiiDUCtv0HP9ofsj/94/AEKn6vrts7kmNCqemDKUhFoD3jC8+EuzE+IstIztcngUuxIFy4I0hG3wftPC5qYviDzqoME8gpZKY6vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jGwYcMs7f3j4zneYw6HClsvEUvnP62Lm/ahz0CuOKo=;
 b=xPoi2cQVnSxxUh04nlQeMdSkqwM1qcdGe4NkhtC5OELBTq7byxjPaQ2CxS/sg+B4UKV/zMRgIc7yLCSgDVNAMImPxLu67zlw5+hVQvp3mHSbAAzWls+lHL08CTW4wSLDmq1H+1lzlebWtp7kxIoL4efhvMCX8H9cAMxes270m9M=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 22:32:27 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a952:d50:fdc8:fc95]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a952:d50:fdc8:fc95%7]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 22:32:27 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Alexander Koskovich <AKoskovich@protonmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: Documentation for RGB strip on RX 7900 XTX (Reference)
Thread-Topic: Documentation for RGB strip on RX 7900 XTX (Reference)
Thread-Index: AQHaQg5xcJeFw0AC60y3NTa3oyYX3rDQfpSA
Date: Mon, 8 Jan 2024 22:32:27 +0000
Message-ID: <BL1PR12MB514454D5E625F71BB0E6A8B6F76B2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <oCYzPIgXFcQ3jdqAKY2upsY5qq23yOba06RkrzD5Bfai97jMWxGvBsaOiKi1k5oZvNg7IoJLE6jAA6BLGFXt08WbBEtdgJA4snn7khZ0JFM=@protonmail.com>
In-Reply-To: <oCYzPIgXFcQ3jdqAKY2upsY5qq23yOba06RkrzD5Bfai97jMWxGvBsaOiKi1k5oZvNg7IoJLE6jAA6BLGFXt08WbBEtdgJA4snn7khZ0JFM=@protonmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e1f90acc-dab1-405e-afee-b33bb2ff050f;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-01-08T22:23:52Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|IA0PR12MB8327:EE_
x-ms-office365-filtering-correlation-id: f3cb6047-a948-4c02-b8b1-08dc1099b175
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uqjE+TKDhwiUk6HB1VIbcIpTUEWXTTS1hSp9kp6lRp9vIbRoIIDyxyDBhxp8H3eBYlBGE9bSP78ySr87qmcW0LHI8rRc+n9Yj96e3SVhhz/HMVuRNtS4pfMTHqfMjVNbaJ3wqeymw/ACSqR8H+M0kGL0wT/yrnhid7U5yWEnzUrPqcKpmAD5cNPyeEw+413xs9JxmnUzhxCVaWlg1N+Dg5M0DZN8VjBkmi1h7mB5TkJcTXXe9eE3Fym8WaF8GNKtVgvg4mhtTNAPzCIykw2v2/8q+6UF/bm54ZBSgX4Mi+DPWu7/kOhkLTJcF/cG5E2hJRW62i5r1SzmmQsD5KN+ose5XEHZBN7y8/tpmXDHBdi7CTiUxb9FGL3KowdfPia3XRtB7dqkSWMhNHwjjgWWv01CFVrmlrgDJD9t9GVPEn15grVB04v/eM1YxInDMkGmc3cwLYFDr57nBPJanXvh60/Hfw+G2sMtKEgJEyKlA8nacSh/2J3Gua4g8p3DGelK/Msx3DJdvfoq/aYMRUhCoKkUbMbnS32azvTwaVITrnfod8aZKraMWXuymDpnsugQAvNhoqdhpDcSzzJSFEaLvy/htKLiIet24Bg9OOKt43k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(396003)(136003)(346002)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(2906002)(26005)(76116006)(64756008)(66556008)(38070700009)(66446008)(66476007)(66946007)(41300700001)(122000001)(33656002)(55016003)(86362001)(71200400001)(5660300002)(83380400001)(110136005)(316002)(9686003)(53546011)(6506007)(7696005)(478600001)(52536014)(966005)(38100700002)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXo1M1Y3bTRpWjZ4b0tSNEI2TWFDMHFUQVhtSkhubnJTWW5oOFlURkhzL0F5?=
 =?utf-8?B?SVhUekFic3kyQ1NZRzJRYjRVRlZYdGl3L3haRWNPZmdqVWtlRnlQTWtabXVT?=
 =?utf-8?B?VDd1VldZSEVyQmJRL3hLditnZzRYZ2JsNzMvcEJPTm1GNjRLMmFFSm5qSmJV?=
 =?utf-8?B?b2V3cU4yRXRwakgvRnpOekhOVGc3QnpOY25vQnd5WTZhTkl1U29MUHZONDgr?=
 =?utf-8?B?dXE4bkZ5eFByMmM4SjJFSldZS0VjYTducTZKYUVqajdqZ1lDTWh5T2l0SWtr?=
 =?utf-8?B?ODlNVG9FZjFvWVdjMVdqWS9nbUZSNEIxcVI5UWxIQnQ5QytJL3cwS29rMGdz?=
 =?utf-8?B?ekpaL1RQSWxuTEM0dmhjZHk4UFdvNTVhWnpxK2M0c3lBYjZuZXRyMGRiUS9l?=
 =?utf-8?B?RkVTOFNWeEZ6THpZNzMxaHl2TDZGQ0kyd3MzTHJCTlJTdk05QndraVpNdGwx?=
 =?utf-8?B?V3BTT0xldVJud0RMakcycUJXWi94RTY2MVk4cnU4QlB1UHZTZEJWeEZoOUMz?=
 =?utf-8?B?RzJvTWZkNGpXemwrSWVtTDR0OEYvT0IrSGdzcCtkOEl2SHNGTzdFLzFMcldH?=
 =?utf-8?B?S3M2SVZpcnZVMGNmZUtsbnhWVmFNMWg3alVPdkpNckZGcnJEZHhPWlR6bEQr?=
 =?utf-8?B?dXp0OTUyKzZFbTNva0RjRXJLUDN0TDhKZ0xIcmtscG45a3lsM2g5ZTk4dGUw?=
 =?utf-8?B?NFJpblZtU0d1T1dGMlRjNlV3eG16c0l1NWhGN0xsYS94Sk5ncjZOOVovQVRv?=
 =?utf-8?B?UTY3aDdIVUFLdkwrOUJ5QjJjS1R0cHRCeU11Z3FmYWQreUNyTXRWR2ZXR3NK?=
 =?utf-8?B?UzFzeERTSXQySXd6WS9SV3ZYNnpnclR5dTBQMVZjblJMbncyalhVT2NERlJN?=
 =?utf-8?B?bUVOM2ZKTWM4ZER6U3ZVZXZDVUs0MXNiZ3RZSU5DdnMzTzJyME5ldFhad0xm?=
 =?utf-8?B?UHVGa0lSZjdDaWdSNnMvdUFEeTJUanVzb2xESVlCN3ZGZUU4bng5NEtxTmJy?=
 =?utf-8?B?YkhUVS9xKzVCby82b3dlU2s4NmtqakRYdGkxM0tEVDZGTDROS1FLUnRsZTJj?=
 =?utf-8?B?REd5eVEyY1FPV3VrRUVWaG04bWRSVmNkR3JWOHY2QkZvc2xPWW5paFplMDhs?=
 =?utf-8?B?ZXYvUmJqQ1JVSXVaRHNpY1dqQnc3OXgwM1F3RVkrNVMrdUN5Yi83Si9ISC8r?=
 =?utf-8?B?UDRuR3kxaGl0bFNxV3k2ei83bUI4NGhuSDN4MjJRSE5uZ3ZBcWpWODg4Rnlu?=
 =?utf-8?B?SlJqRE9FTkFGN1RZRmozVVpBZUlBbjVwSG8vZXBHRWliemxhM2pxcllMbXUy?=
 =?utf-8?B?bm90bTBHbDZzUjRvRC9QOFBGYUpUbXVRQ1NtRXlQNjFocmx2cXFlU1hHZ3N2?=
 =?utf-8?B?N1NIVkxHYjZPYWdwZ3BZRCthNlZpdDRoWkE5eVpLOEtLcWp2QjJDRkw5NGRT?=
 =?utf-8?B?UXN5anMzNWJrOXQzemV6TUQ0U3JpM2tqSEwwdzBLL2JndFV2MHJ1M2VSdi9T?=
 =?utf-8?B?WHRVSlloRjhSbkx2VEpjRVBZbmpmVExuYjFjbzVTREtYL0luNnAyZkFHMXNi?=
 =?utf-8?B?NVRuUXlrcFozcVRZNlJlSXNFYmN1ZXFneUdmSFBTY1cvYkRCRVdSM2h0aStH?=
 =?utf-8?B?bDAyMFhLNjRpb3NCZiswdDZpd1B0Y3RmNm9ZdXp0aHVNbUlpa1J6dllpN0xG?=
 =?utf-8?B?VEZla1VkaW1GeERDOC9tbmZmZlV0OVJ0SVBFK3dQRjFqMU1Vc1l3WXU0UEpH?=
 =?utf-8?B?QkVwNjNEanJFYTFtV0RqZDQ4SWp6N05yRVpVajhIb2MzYkhYSXhwaGFJdng3?=
 =?utf-8?B?ZHB0K0dSK2kzdFpjbUFuaG5vSmZXK2dRNEVSZmR6bjZteVhaY2FVUCtMNzM4?=
 =?utf-8?B?NzlEVnR3eW1zVGJPWVBGVlV2RVFlWkZkd2lJTTVsRG81SDNpU0kwQkVrVW5j?=
 =?utf-8?B?dmxVcFhIMjUvRTJtOUl5R2tPekpJWVJzRjE4V0s3NWs5Ym1mVUgxSFFYODBB?=
 =?utf-8?B?NUxzTGV5a0k2NTk4aW1WejhvRTBHZVRmdktkZ0lydklXclM4OTRXR0lna1BY?=
 =?utf-8?B?L3dYYURXL0hJZjY4ZkQzVEhScWNmZ3o5Nm0xclY0MVZubVQvYmNRSFIxVEo1?=
 =?utf-8?Q?xUsU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3cb6047-a948-4c02-b8b1-08dc1099b175
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 22:32:27.2549 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: auJuJpWVkIRIQ1tkMQVbKoQ3ceuCXOTefWkiaaP+28Gr9NU9NIjJ+/sXlMIOHIKKH5Bmy2+ol87jz9IKTEfwZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4
IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YNCj4g
QWxleGFuZGVyIEtvc2tvdmljaA0KPiBTZW50OiBTdW5kYXksIEphbnVhcnkgNywgMjAyNCAxMTox
OSBQTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDogRG9j
dW1lbnRhdGlvbiBmb3IgUkdCIHN0cmlwIG9uIFJYIDc5MDAgWFRYIChSZWZlcmVuY2UpDQo+DQo+
IEhlbGxvLA0KPg0KPiBJIHdhcyB3b25kZXJpbmcgaWYgQU1EIHdvdWxkIGJlIGFibGUgcHJvdmlk
ZSBhbnkgZG9jdW1lbnRhdGlvbiBmb3IgdGhlDQo+IFJHQiBzdHJpcCBvbiB0aGUgcmVmZXJlbmNl
IGNvb2xlcg0KPiAoaHR0cHM6Ly93d3cuYW1kLmNvbS9lbi9wcm9kdWN0cy9ncmFwaGljcy9hbWQt
cmFkZW9uLXJ4LTc5MDB4dHgpPyBJdA0KPiBsb29rcyB0byBiZSBoYW5kbGVkIHZpYSBJMkMgY29t
bWFuZHMgdG8gdGhlIFNNVSwgYnV0IGhhdmluZyBwcm9wZXINCj4gZG9jdW1lbnRhdGlvbiB3b3Vs
ZCBiZSBleHRyZW1lbHkgaGVscGZ1bC4NCg0KSXQgZGVwZW5kcyBvbiB0aGUgQUlCL09FTSBhbmQg
aG93IHRoZXkgZGVzaWduZWQgdGhlIHNwZWNpZmljIGJvYXJkLiAgVGhlIFJHQiBjb250cm9sbGVy
IHdpbGwgZWl0aGVyIGJlIGF0dGFjaGVkIHRvIHRoZSBERENWR0EgaTJjIGJ1cyBvbiB0aGUgZGlz
cGxheSBoYXJkd2FyZSBvciB0aGUgc2Vjb25kIFNNVSBpMmMgYnVzLiAgVGhlIGZvcm1lciB3aWxs
IHJlcXVpcmUgY2hhbmdlcyB0byB0aGUgYW1kZ3B1IGRpc3BsYXkgY29kZSB0byByZWdpc3RlciBk
aXNwbGF5IGkyYyBidXNlcyB0aGF0IGFyZSBub3QgdXNlZCBieSB0aGUgZGlzcGxheSBjb25uZWN0
b3JzIG9uIHRoZSBib2FyZCBzbyB0aGV5IGNhbiBiZSB1c2VkIGJ5IDNyZCBwYXJ0eSBhcHBsaWNh
dGlvbnMuICBDdXJyZW50bHkgd2Ugb25seSByZWdpc3RlciBpMmMgYnVzZXMgdXNlZCBmb3IgZGlz
cGxheSBjb25uZWN0b3JzLiAgVGhlIGxhdHRlciBidXNlcyBhcmUgYWxyZWFkeSByZWdpc3RlcmVk
IHdpdGggdGhlIGkyYyBzdWJzeXN0ZW0gc2luY2UgdGhleSBhcmUgdXNlZCBmb3Igb3RoZXIgdGhp
bmdzIGxpa2UgRUVQUk9NcyBvbiBzZXJ2ZXIgYW5kIHdvcmtzdGF0aW9uIGNhcmRzIGFuZCBzaG91
bGQgYmUgYXZhaWxhYmxlIHZpYSBzdGFuZGFyZCBMaW51eCBpMmMgQVBJcy4gIEknbSBub3Qgc3Vy
ZSB3aGF0IGkyYyBMRUQgY29udHJvbGxlcnMgZWFjaCBBSUIgdmVuZG9yIHVzZXMgb2ZmIGhhbmQu
ICBodHRwczovL29wZW5yZ2Iub3JnL2luZGV4Lmh0bWwgd291bGQgcHJvYmFibHkgYmUgYSBnb29k
IHJlc291cmNlIGZvciB0aGF0IGluZm9ybWF0aW9uLg0KDQpBbGV4DQoNCg==
