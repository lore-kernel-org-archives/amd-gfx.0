Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143C8C7EE23
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 18:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76DCF10E24A;
	Tue, 30 May 2023 18:19:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20B8F10E249
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 18:19:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ny8RXQBQcSOIAhOtCBBiMNn7rp5QdKT3/wyUdMn+KRs6rCKeSd7djFqZYZJ7Fr/85ByL8rKapT0LhCeUZtwfkaZwRjmPOxGj4XH7WW2iqBd6MEns6ORdSNdzwvaj85vxVc6B28Nn4aV09tEGCkIN8yMvKqlyigck5lX7f39Q+LWHKHJ4chaNK6+eRSriq0VTfBnIKmW2NvmQONxD9luxi8bK9SoWBrCIuEBE6Vb0Qqk6l4DqydVy7plnnQ6PHU/1ce4xBAygIvpTR/2xbE0Zqr9rihextb0gPxSz7O0T3K3lpi4xQUw0pSN10OCICzn8XdB0yPy0vTyer9IaLDt0qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muX6VGs6se0r85W5sNHRQHkGQFxKb4jH0p/jHm0FKSg=;
 b=Ytp98YVBrBnFC/s1vpYu1W0sxBV7MIqS9xf9boWEzB2yzJrmF6/iglwUnYNeK45OU1WRFIjSbbr0BHC0fOKuv5DV4q54QFNYz0j4pasJkDYBBKmwDY41d3fb8m2WBOoyI5IMMbGYxQv5DYXDZ4KhauFLQ7YYkjFqxIVvrFOjMkG/KETSiB0uFO0yZkmGI9DPBMAHouNKqqJYbhvBYHYnENGvY+esBbUDPf2PMMf9MijONDLeFk2pAmUtoeWMrlGH6oAR57UVJfz+WNyHjTkpIh1va125MQ0XJRbNE49dZsUAFmia60+KivccuvePRNdqmMfgxK9NNOHGvtqUGcVRRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muX6VGs6se0r85W5sNHRQHkGQFxKb4jH0p/jHm0FKSg=;
 b=326YR6qaLKW38oezDjD1w9RoYngbN6saza0wb3EG5kCaXMoT23EH2Vj0TwnXPNkr/VfKb0/f6dTVv4HgO7uO58DXC3PepbrepOtEkdNXOypX+qaLIFckGkdoekVwqhl4t5xcbjDbt46RfWiOvntTMspC69/OPtwdMZhpOd4MVSk=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CYYPR12MB8751.namprd12.prod.outlook.com (2603:10b6:930:ba::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 18:19:18 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527%5]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 18:19:18 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 1/2] drm/amd: Disallow s0ix without BIOS support again
Thread-Topic: [PATCH 1/2] drm/amd: Disallow s0ix without BIOS support again
Thread-Index: AQHZkx+fEuCfTGHpmkuMETcUQUBT869zH0GAgAAATXA=
Date: Tue, 30 May 2023 18:19:18 +0000
Message-ID: <MN0PR12MB610183E9EC20D68FE3670D24E24B9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230530175301.231070-1-mario.limonciello@amd.com>
 <CADnq5_M8XdDsyn0q-mM4CfFoMHH6g54VP_SG4cNztEYAwwB_hg@mail.gmail.com>
In-Reply-To: <CADnq5_M8XdDsyn0q-mM4CfFoMHH6g54VP_SG4cNztEYAwwB_hg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8082ad7d-3e41-472e-a36d-9e0fb4a8a751;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-30T18:16:49Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CYYPR12MB8751:EE_
x-ms-office365-filtering-correlation-id: 9bfa4a6b-d7b2-42ab-e8f9-08db613a6249
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7lNBghjYM4dI1o94RjLLXdoEULzl9ImilbYPbL+KX9rau+JZ1mX4bXZR94vWw4zNwwYsKsvCoBp1ClXK0RyC1+yh/lkXLk8QSA/8FR9IylRV9Ihin7yvSWXKaIpqU62shFuz4/eaE09ovcIt7tppOgLbd1hbxZ4usi7q78Wwklu8bqJSlhB9D/5Oe8C026ThTGFFURzPiJRqYWgvMcPJ12ZhsCsQLVQWR93UythnswWvigBfEZdfNunIjZULFhpu0b30A8eC23WxEkwduTXIjWfvl98wxvuT/v7YBpR4bQXcAoFkLiNHfQP0/AMWQFke9oK3rKVElEkgoQnrTnsHNLMfUkK5fJ+b8Ps1DNYZUUIDE0w1lYF/yLckO8KsMDK78k7/Xj/KTx2YcVN3CQ3jhERT8aP9mgpLCSfPUYpX5HH2Cg/ZNN9CSumffYVeo3rRZxDcaMA6OQtUzEc4g1+4FgXE0kIuZX+cqqugvLl+UNfIo3h4FUIWBBskNMkiIJyoimpIJbKCR8cpu2NmaMpVnx2vdYlkyeUok1zM56jDJsrq7KPHaEf+nWzTCrlfRu7FV2SG3ranDhJkyKbeUQ9JwX/MSz3gOnFZR5tt6wcxkyFHf4ifyNCbKMBnih7WtzFe
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199021)(186003)(966005)(38100700002)(41300700001)(83380400001)(53546011)(9686003)(6506007)(26005)(66574015)(7696005)(478600001)(54906003)(66899021)(71200400001)(4326008)(66556008)(66446008)(66946007)(76116006)(66476007)(64756008)(122000001)(6916009)(55016003)(316002)(52536014)(8936002)(8676002)(5660300002)(2906002)(33656002)(38070700005)(86362001)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHdEcEpNUE9iTlg4T3h4TjBBcUY0TUV5ZkpCSm96VE5mL0JEY0ZIZXR2bVRt?=
 =?utf-8?B?bUV3QUlkdUEraStFRzJyQ2VsN3R6aWQ2VlkrRkFFdnR1Wlg4QkE1WjNrMnlk?=
 =?utf-8?B?QlZIQjBoMDJxQllDTXQraVpvV0F1QjcxZUxVb1JTb0MzOWViYWtzeG5HVTND?=
 =?utf-8?B?Umo2QU5VYTRZRWw2eEpGVWgweVJsZ3p4dTcvSStrNDlCTUF3clZwbDNOVlFJ?=
 =?utf-8?B?YnY0MXdXNXZKSURjb2hQakd5L2NMZXdPUzF0cEZ5ZHBsc2VudDMxREJEMzY4?=
 =?utf-8?B?ODRUaHdFdDUxSkZScGJ0cWlQc0hzRDhxMmxBbCtBTnRSbkFHcHp4TlZFcjY3?=
 =?utf-8?B?MFNVejNvNW1jWkU0VDBST3hYUWdMZUpwZG9kTXVuc1FtbDZtc3MrbmVpKy9E?=
 =?utf-8?B?RlMybFhqbVVxU1FhYTVaWXRXMHJpdTdsZ3QwK0k4cURzdDFPZ1E3bGhueHRo?=
 =?utf-8?B?NDlkVk0xbjNvejhPTWhVSUVidWpIeW11aTN6UWZDUWRwZzNreHlGbHV1SkFW?=
 =?utf-8?B?bk5lWEF5Y1RzSWZodHJGT09kL1cybXRtTENWRjBMNFhXZHpQdlhrc2VzYWlP?=
 =?utf-8?B?VzRWS3YxRkd1dVd2OG5oeTNMSjNUV0FQMVJiZGZVOU1GdndxNDFpSGI3RGFz?=
 =?utf-8?B?dk1DSHU4U0RTc1BLTWo0NUxONmFpbmtKeWVvTXo3ak9laUJhRVFwcnlWejlU?=
 =?utf-8?B?TnBtM0hZSlhTMTV1cTV5Nm1TdGJJdlpVczhoNnI3MGRrdTY5dlR2V1FkenpC?=
 =?utf-8?B?T2ZlRVVHZ2ZPSWFrbVg3dWZkQ3ZSMyt4anFvT3ptQjNFaDlnVGJJUk9nVVpT?=
 =?utf-8?B?eThFRXNndmc5RXBlOFJrbzMydzJuMkVHRFpRL0RxdDdMbkJHK243TUtLdkpM?=
 =?utf-8?B?S0N6Z29XT3dmbDRHZ2dsemxVL1Y1UmFzYVpkN2VJVjZHdTdUQThYMFRRRGt6?=
 =?utf-8?B?aFdHMXJmdDVneDV6aUZjVzRFazU4N1NZZkVLZFIyUTB4YUdjcGdlSmg5TUt3?=
 =?utf-8?B?TkRJSEZLaW53U2g4QlRuaVl3MVVNWjR0eUx6TUZCVFpwNkdzRE5ibVkxeW16?=
 =?utf-8?B?cS9oSlNPSVJmWW9VRExXemJ2dkFuUGtFKzJsV21VVnFMVWJtZDNkbmxUNm0x?=
 =?utf-8?B?UE1vZmJNVW12S2dTbFpYRndobUIxWGlQb09wOFBjU3M1WjlYS0xMWmNmRlU3?=
 =?utf-8?B?RVdJS1JOR2dtT3R1SDFZZW5hN294ZDRTYU4rUXprcGtaUnJ4Nk1iWlhpYzdP?=
 =?utf-8?B?SDZ2aGJQSmdQVk1Rcm1pMXZhQ3p6bmFlKytBd210VjFKaEFhZUhIQkdtdlo1?=
 =?utf-8?B?MDhJb1A1TjE2SUJibXYwbk5BYVZKbXYybVNNVDRiY3JVMUV1NmQ5UkVZT3NK?=
 =?utf-8?B?bE1FVm04UWJQV1owK1dJRFAreFp0NnYxa0VpVVh0SUI4U2wvM3NyMG1LNWxB?=
 =?utf-8?B?NzRsdTR6dm1mK0tqMkp6SGhHZXJFUzFrdytMMk0rZUxWdTdBRFBjam9USWRt?=
 =?utf-8?B?clZlTEFGR3pxdmFiUjBOd0VUVkdIRE9DeUF6TTVaY09SUUN0bmJndWZKS0RI?=
 =?utf-8?B?U2ZuR1l1SnAxVW9xWXFtdE5HL0VoUFRHekp4WVJSK0pDMS9IU0Q1WGRhek5E?=
 =?utf-8?B?VldyS3JpVElBSThXYkY3M0owd0RRRTd0T3VvNWZESmlibkVWVmN6RmovZW9n?=
 =?utf-8?B?Z0dGdi82M2d2OFd6dXFKc2F3Ym1CMVJFSHZ5dUYzQkx6QWMweG9wNTZSSFpR?=
 =?utf-8?B?aEtVMnJXa1h1WjY4SGtSbWVmTTB6TEFuVXNnU2dPTU5KWjFOUVFKM1FmNVZD?=
 =?utf-8?B?TU1tUXI3VWE4TTJrWVI1Q2hncm41QmN3VSs1SW9yYjZjYXRTd0NEYzZaemFz?=
 =?utf-8?B?bldraWlvQ3Q5blgzRlFZbk9Wd3BicUMyVVhObWxOdHVuMUtLWjI4cjc5Q2lE?=
 =?utf-8?B?QUxoelFDbFhpdkZ3MkdIVS80NzlNYWl0SkYzdXNPcEJJazlnQlE4c0RXMXk1?=
 =?utf-8?B?UkJHcUZ1aTg3K3pWQVlEZXJnRU9nZm5lM0c0QUN0eXJQd1RGR295VWlnQlhO?=
 =?utf-8?B?WUsrWUFVbzU5RUpkYkRkQmQ0RHBVcDk0ZVZSRjRBaEVTd3h1bVliVE9kZ1BP?=
 =?utf-8?Q?IKQQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfa4a6b-d7b2-42ab-e8f9-08db613a6249
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 18:19:18.7165 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +9cLBVkhjNn4Pd3igE6sidmauhkOOJe7Iz9BISE+f18M7tLrFyvVUr0oLFuMdnSq8KhaMhLXMb8Wza7qqyABFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8751
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
Cc: =?utf-8?B?UmFmYWVsIMOBdmlsYSBkZSBFc3DDrW5kb2xh?= <rafael@espindo.la>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+
IFNlbnQ6IFR1ZXNkYXksIE1heSAzMCwgMjAyMyAxOjE2IFBNDQo+IFRvOiBMaW1vbmNpZWxsbywg
TWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZzsgUmFmYWVsIMOBdmlsYSBkZSBFc3DDrW5kb2xhDQo+IDxyYWZhZWxAZXNw
aW5kby5sYT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGRybS9hbWQ6IERpc2FsbG93IHMw
aXggd2l0aG91dCBCSU9TIHN1cHBvcnQgYWdhaW4NCj4NCj4gT24gVHVlLCBNYXkgMzAsIDIwMjMg
YXQgMTo1M+KAr1BNIE1hcmlvIExpbW9uY2llbGxvDQo+IDxtYXJpby5saW1vbmNpZWxsb0BhbWQu
Y29tPiB3cm90ZToNCj4gPg0KPiA+IGNvbW1pdCBjZjQ4OGRjZDBhYjcgKCJkcm0vYW1kOiBBbGxv
dyBzMGl4IHdpdGhvdXQgQklPUyBzdXBwb3J0IikNCj4gc2hvd2VkDQo+ID4gaW1wcm92ZW1lbnRz
IHRvIHBvd2VyIGNvbnN1bXB0aW9uIG92ZXIgc3VzcGVuZCB3aGVuIHMwaXggd2Fzbid0DQo+IGVu
YWJsZWQgaW4NCj4gPiBCSU9TIGFuZCB0aGUgc3lzdGVtIGRpZG4ndCBzdXBwb3J0IFMzLg0KPiA+
DQo+ID4gVGhpcyBwYXRjaCBob3dldmVyIHdhcyBtaXNndWlkZWQgYmVjYXVzZSB0aGUgcmVhc29u
IHRoZSBzeXN0ZW0gZGlkbid0DQo+ID4gc3VwcG9ydCBTMyB3YXMgYmVjYXVzZSBTTVQgd2FzIGRp
c2FibGVkIGluIE9FTSBCSU9TIHNldHVwLg0KPiA+IFRoaXMgcHJldmVudGVkIHRoZSBCSU9TIGZy
b20gYWxsb3dpbmcgUzMuDQo+ID4NCj4gPiBBbHNvIGFsbG93aW5nIEdQVXMgdG8gdXNlIHRoZSBz
MmlkbGUgcGF0aCBhY3R1YWxseSBjYXVzZXMgcHJvYmxlbXMgaWYNCj4gPiB0aGV5J3JlIGludm9r
ZWQgb24gc3lzdGVtcyB0aGF0IG1heSBub3Qgc3VwcG9ydCBzMmlkbGUgaW4gdGhlIHBsYXRmb3Jt
DQo+ID4gZmlybXdhcmUuIGBzeXN0ZW1kYCBoYXMgYSB0ZW5kZW5jeSB0byB0cnkgdG8gdXNlIGBz
MmlkbGVgIGlmIGBkZWVwYCBmYWlscw0KPiA+IGZvciBhbnkgcmVhc29uLCB3aGljaCBjb3VsZCBs
ZWFkIHRvIHVuZXhwZWN0ZWQgZmxvd3MuDQo+ID4NCj4gPiBUbyBtYWtlIHRoaXMgdGhlIGJlaGF2
aW9yIGRpc2NvdmVyYWJsZSBhbmQgZXhwZWN0ZWQsIHJldmVydCBjb21taXQNCj4gPiBjZjQ4OGRj
ZDBhYjcgKCJkcm0vYW1kOiBBbGxvdyBzMGl4IHdpdGhvdXQgQklPUyBzdXBwb3J0IikgYW5kIG9m
ZmVyDQo+ID4gYSBtZXNzYWdlIGlmIFNNVCBhcHBlYXJzIHRvIGJlIGRpc2FibGVkLg0KPiA+DQo+
ID4gQ2M6IFJhZmFlbCDDgXZpbGEgZGUgRXNww61uZG9sYSA8cmFmYWVsQGVzcGluZG8ubGE+DQo+
ID4gTGluazoNCj4gaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvdjYuMS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdQ0KPiAvYW1kZ3B1X2FjcGkuYyNMMTA2MA0KPiA+IENs
b3NlczogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvMjU5
OQ0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxs
b0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfYWNwaS5jIHwgMTYgKysrKysrKysrKysrKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTQg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwaS5jDQo+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2FjcGkuYw0KPiA+IGluZGV4IDNhNmIyZTIwODlmNi4uYTM1MjNk
MDNkNzY5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hY3BpLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNw
aS5jDQo+ID4gQEAgLTI4LDYgKzI4LDcgQEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3hhcnJheS5o
Pg0KPiA+ICAjaW5jbHVkZSA8bGludXgvcG93ZXJfc3VwcGx5Lmg+DQo+ID4gICNpbmNsdWRlIDxs
aW51eC9wbV9ydW50aW1lLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9zY2hlZC9zbXQuaD4NCj4g
PiAgI2luY2x1ZGUgPGxpbnV4L3N1c3BlbmQuaD4NCj4gPiAgI2luY2x1ZGUgPGFjcGkvdmlkZW8u
aD4NCj4gPiAgI2luY2x1ZGUgPGFjcGkvYWN0YmwuaD4NCj4gPiBAQCAtMTQ3Myw2ICsxNDc0LDEz
IEBAIHZvaWQgYW1kZ3B1X2FjcGlfcmVsZWFzZSh2b2lkKQ0KPiA+ICAgKi8NCj4gPiAgYm9vbCBh
bWRncHVfYWNwaV9pc19zM19hY3RpdmUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4g
IHsNCj4gPiArI2lmZGVmIENPTkZJR19YODYNCj4gPiArICAgICAgIGlmICghc2NoZWRfc210X2Fj
dGl2ZSgpKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGRldl93YXJuX29uY2UoYWRldi0+ZGV2LA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJTTVQgaXMgZGlzYWJsZWQgYnkgdGhl
IEJJT1MuXG4iDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIlRvIHVzZSBzdXNw
ZW5kLXRvLXJhbSBlbmFibGUgU01UIGluIEJJT1Mgc2V0dXAuXG4iKTsNCj4gPiArICAgICAgIH0N
Cj4gPiArI2VuZGlmDQo+DQo+IFdpbGwgdGhpcyBnZW5lcmF0ZSBhIHNwdXJpb3VzIHdhcm5pbmcg
b24gcGxhdGZvcm1zIHRoYXQgYXJlIG5hdGl2ZWx5IG5vbi1TTVQ/DQoNClllYWg7IGl0IGNvdWxk
LiAgSSdtIG5vdCBzdXJlIGhvdyB3ZSBjYW4gcmVsaWFibHkgZGV0ZWN0IHRoaXMuICBJIHRob3Vn
aHQgYWJvdXQgbG9va2luZyBmb3INCnRoZSAnaHQnIGZsYWcsIGJ1dCB0aGF0IHByb2JhYmx5IHdv
dWxkbid0IHdvcmsgZm9yIHRoaXMgY2FzZS4NCg0KQXJlIHRoZXJlIEFNRCBaZW4gQ1BVcyBvciBB
UFVzIHRoYXQgYXJlIG5vbi1TTVQ/ICBDb3VsZCBnYXRlIHRoZSBzY2hlZF9zbXRfYWN0aXZlKCkN
CmNoZWNrIHRvIG9ubHkgcnVuIHdoZW4gaXQncyBhbiBBTUQgeDg2IFplbiBTb0MuDQoNCj4NCj4g
QWxleA0KPg0KPiA+ICAgICAgICAgcmV0dXJuICEoYWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVKSB8
fA0KPiA+ICAgICAgICAgICAgICAgICAocG1fc3VzcGVuZF90YXJnZXRfc3RhdGUgPT0gUE1fU1VT
UEVORF9NRU0pOw0KPiA+ICB9DQo+ID4gQEAgLTE0OTksMTYgKzE1MDcsMjAgQEAgYm9vbCBhbWRn
cHVfYWNwaV9pc19zMGl4X2FjdGl2ZShzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldikNCj4g
PiAgICAgICAgICAqIFMwaXggZXZlbiB0aG91Z2ggdGhlIHN5c3RlbSBpcyBzdXNwZW5kaW5nIHRv
IGlkbGUsIHNvIHJldHVybiBmYWxzZQ0KPiA+ICAgICAgICAgICogaW4gdGhhdCBjYXNlLg0KPiA+
ICAgICAgICAgICovDQo+ID4gLSAgICAgICBpZiAoIShhY3BpX2dibF9GQURULmZsYWdzICYgQUNQ
SV9GQURUX0xPV19QT1dFUl9TMCkpDQo+ID4gKyAgICAgICBpZiAoIShhY3BpX2dibF9GQURULmZs
YWdzICYgQUNQSV9GQURUX0xPV19QT1dFUl9TMCkpIHsNCj4gPiAgICAgICAgICAgICAgICAgZGV2
X3dhcm5fb25jZShhZGV2LT5kZXYsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IlBvd2VyIGNvbnN1bXB0aW9uIHdpbGwgYmUgaGlnaGVyIGFzIEJJT1MgaGFzIG5vdCBiZWVuDQo+
IGNvbmZpZ3VyZWQgZm9yIHN1c3BlbmQtdG8taWRsZS5cbiINCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAiVG8gdXNlIHN1c3BlbmQtdG8taWRsZSBjaGFuZ2UgdGhlIHNsZWVwIG1v
ZGUgaW4gQklPUw0KPiBzZXR1cC5cbiIpOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gZmFs
c2U7DQo+ID4gKyAgICAgICB9DQo+ID4NCj4gPiAgI2lmICFJU19FTkFCTEVEKENPTkZJR19BTURf
UE1DKQ0KPiA+ICAgICAgICAgZGV2X3dhcm5fb25jZShhZGV2LT5kZXYsDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICJQb3dlciBjb25zdW1wdGlvbiB3aWxsIGJlIGhpZ2hlciBhcyB0aGUga2Vy
bmVsIGhhcyBub3QgYmVlbg0KPiBjb21waWxlZCB3aXRoIENPTkZJR19BTURfUE1DLlxuIik7DQo+
ID4gLSNlbmRpZiAvKiBDT05GSUdfQU1EX1BNQyAqLw0KPiA+ICsgICAgICAgcmV0dXJuIGZhbHNl
Ow0KPiA+ICsjZWxzZQ0KPiA+ICAgICAgICAgcmV0dXJuIHRydWU7DQo+ID4gKyNlbmRpZiAvKiBD
T05GSUdfQU1EX1BNQyAqLw0KPiA+ICB9DQo+ID4NCj4gPiAgI2VuZGlmIC8qIENPTkZJR19TVVNQ
RU5EICovDQo+ID4gLS0NCj4gPiAyLjM0LjENCj4gPg0K
