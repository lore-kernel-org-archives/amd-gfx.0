Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B4EF36C24
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 06:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6517A10E0F2;
	Mon, 20 Apr 2026 06:48:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ygu7DdUH";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010002.outbound.protection.outlook.com
 [52.101.193.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E00810E0F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 06:48:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXSxI9lxNMUIb1sstiBeqcqwtPJaJ91OiVbK2sXUmxRInsyZeMdsSHDIgfogBapLeHthD1lXHouiP7v3GbegQsw3G6JQHKhsrUNV9NbWbKFoX+q1/NgxVtiqzeP9pCrjfwMghxMQfBGNCFKvDNbh6HirmjogNHHIyETpLrIjghYpQi4B+la+6WS0csnCvq01B0k92VDQGsOwDh6AtVEHE5CpY0g5qyzM8jtHNqyUKzaxRx4QusRJtPCDbVuksXTiU6iJ434aQWcDarmzIvPdwYiq5FAXTIlA1HfN8saMAT0zcBl3IWB90DG2jDc0bP0xJaTtmoJyBjXGrffPvJgeMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRElBpKR9eLkRm8D0Vdph3Qqw+4FN+Glvv59nUDwO6E=;
 b=JrbbUFO4bFGubO+Qi57qe/pKRAdMmPBEKSt4+967iZpu48cqBq4Up9E+nS/st3nRrKd458PrVsUkVhLmGTAe56jpgG41sbObdeKPbPwxsKexCIHfA1bw0OuOSRtnVUt+6kPcFka49STejLiW8/j0AxhigJgst0AbNnwj+p+CaIBFTOTvJgKPqi8z/JK4Hgtm/9pPeH/QHfd/XZwG5GDDWp0kCa9dnvGQKgCWjxs6qWj5mSVTcwVFUbxiKyPQRUZnN+B0VV7ewsU259r2TWzDz+dbiAqMcIxG7frIZ1/UbbVFcZjoFLtN7rp3TrJCIL9mkwMaUnBDgKS+hm5QKXls+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRElBpKR9eLkRm8D0Vdph3Qqw+4FN+Glvv59nUDwO6E=;
 b=Ygu7DdUHsuBBB/tzYRgmUhqRlk++7Th8DLeCRdnPRY8bxy45Du2+D4PguStBAKOqd8vCRCjiFszJd1qm2L5LvJN3ICewea/De818t6JuYp22I8OMH+M5Ub8+1wJ9f5NcKE81gfifNXVB4Qngj4G0WsOPz2hzF81v9whxkVPHid4=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 MN0PR12MB6080.namprd12.prod.outlook.com (2603:10b6:208:3c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 06:48:28 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 06:48:28 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>, "Guttula, Suresh"
 <Suresh.Guttula@amd.com>
Subject: RE: [PATCH v3 4/4] drm/amdgpu: smu: fix unified metrics handling for
 SMU 15.0.0
Thread-Topic: [PATCH v3 4/4] drm/amdgpu: smu: fix unified metrics handling for
 SMU 15.0.0
Thread-Index: AQHczcb/+l9p84T5BU6+3LQInQIHkLXnhhUQ
Date: Mon, 20 Apr 2026 06:48:28 +0000
Message-ID: <DM6PR12MB2972A7F0FD9382992AF384DB822F2@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260416173145.856326-1-Kanala.RamalingeswaraReddy@amd.com>
 <20260416173145.856326-4-Kanala.RamalingeswaraReddy@amd.com>
In-Reply-To: <20260416173145.856326-4-Kanala.RamalingeswaraReddy@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-20T06:42:12.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|MN0PR12MB6080:EE_
x-ms-office365-filtering-correlation-id: a91834e7-8667-463f-6f9e-08de9ea8d413
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: r09MItJrFkfDT/ak9uETevvTX3r/X9YTYWEG27saVTDC/NQUTfwa61cuDsIyclICPKgs6sSdh6gxy0MNCIgLK56ubb7XgAEIiUnbEl7JZqFPltun0RmFML7xXg95e7g3rGSD/rmgsxGWJNQi4q7A9kMaI4zdWHiD9LWccZ4suNLtVrhK6hMDrFcx3iVZQNG5D0lptir8qqHImA6B4g8ae82pwj96/VeOkUj9YwV/pDaX795ro5WGxY98PcMHhtl5GrqyHDotiG/H8DObfcOZT0s7SZdixI7KERQIuNFzv+XFLI6i55FKcDhUhfrrWSA5rinFbNfw9ciQYTWtkTqcBZEV6aYMyjtBjeiX2J21GcQvtC2OKnIUq9Sm4I/t8MruB11UJ7viqcDy9HdEgIDribctHk5rPlysvbC+lKzT6pjKWE3nOfYC29aejt2lbgIjPs31wzwOWAz8IBJR4RIJ3CLRtPumyH9CidW0YSuz9DngAKCKd834Ve/1rRidkfrRGDGh/XOAhhRm65EjAkkd+Y6Zl3UiLumVFtu4c7O3ZxXY3QVrS3KIXbfeVTeOhfVciKIeUWbRfz/4qYJRbSBZ6/cM8DcxD3DAfDpyAVkWwRyV7Ipm5Bfdc6LhOMwPf7g5LPu+d06VrP6LqBk29JVrOUNeos9aMU2AaeQbNb956/cpEVgerhakgLGwJsOG8QYyTUDLg2gG+IBJu3M7AVMwVtvRbgNelexaim8XdRiTZzbUE43JtTQjkFcWZk3AvXIodJrVs2ZMEYR7jrjaQVXGHdwA21OHcPG3piS+ULcRTpA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VElOeUxPWkpnSHJWZ05zOEFMRW9NQkdEN1IvSytEYzNOZGdSMmVuSWoyZXp1?=
 =?utf-8?B?WnhuT1RZWWNyVnJlU0lVblBmcDlETVdoZXVtYTZGZ1NJUDNUWkxqTjRtMlo5?=
 =?utf-8?B?ZUtzcFg4TEZTaXZKN0RiSUJJT2tyZzZnZUJ0WSs0YUQ3OWtsbnNwVWhjMEhE?=
 =?utf-8?B?YlpWak94TEJnNkFZNGZNV1ZTVnB0TGdOZkJmMlNuMVFHTXVSb0p6Z09iV29U?=
 =?utf-8?B?dk52S3lVbzkxc0hyV2JKS0RNWk9KRFdWTHdBNkwwWVA0OWhoSzdMUlZQU0pw?=
 =?utf-8?B?NFU4K2VTbWlMck5EVWh5a3JFNlIzYUJFV1JidXhKRCtMNitQNTh2VkZNdmxB?=
 =?utf-8?B?eU5vY2IrWk8xOHVzU2E3M3VZVDFxK1d6clI2TVMxbjhnMzV0NnQxL09BNXBK?=
 =?utf-8?B?d010c3FMMUtKaVJQM0E3c0E1cWVFQVk4S015WW12SEp6QlJhZVF4OXJmaHpm?=
 =?utf-8?B?allSOTZNb3c5bmNCNkd5SVo3TndZRG1oUWZZWXJpc3BpdUZ6L2FCNm1CNmZ0?=
 =?utf-8?B?WndtN0tmdTlGVGpxOXowMnJ3ekpLOGJzUjYySGltRG4yc1V2c0doOUh1RDlF?=
 =?utf-8?B?Rld4YkxVMEZLSHZGUW0rYVlBZmFIeFlLa2ZMbitwL29rUEI0YVFIMWs3T3d3?=
 =?utf-8?B?Y0FDMXRiaU5EdlZFaDE2S1k2dTE4VE0ycDJnSlpZcmFOVVFJR2N4bTV0dGZx?=
 =?utf-8?B?R1MwaXB5NnBGRXBSeDhTK2hGdFV4a1lYd2h6dVFtZEkzWWJEd0FHZDJuN2U0?=
 =?utf-8?B?d0pOTEN5dzhlVFR1Tmd5WEJONXh5YXBpSldWd1hOMWthb2gzMExyZStnZklj?=
 =?utf-8?B?WFp6R1NibXU0R2dLYUx0b2w0cEgwUUlTSWh4UE1NZ3FPQlc4U3hZVkhJTHo3?=
 =?utf-8?B?LzFBQzNna2xHOGw2THdzckgrTEN3eTFqYllJeHFETGtkNVJKMko2WVRBMFZx?=
 =?utf-8?B?Q3BqZU1TSittVnhCQ0JIZnEySnhWTEVmTVdxaXN2VGVmcjgybjU2emdIZk03?=
 =?utf-8?B?MERIM1lLNGlkSHhSZ1ZmamZ6T3kxNGdIcE5hdkZ2MXlQVmE0MzV3bHdJbDNx?=
 =?utf-8?B?MVVzMmY5aDlTYmhMTFJsSE1YWkZ4OWJ6YmlsUXd5RyttcmpaQitrTlQvb3dL?=
 =?utf-8?B?dDRTaG94QXY4c0R4cUtGS3lyZVRSdEFjcHNDekc2S1piaWl6SXBCMy9lNHRP?=
 =?utf-8?B?N0FVaGs5ZE1pZkoyVG1qTnRYalpQeFpJY3I5V0k5WTFpdG5ycENENVNzQndF?=
 =?utf-8?B?dEJMZzFuTUdzUzRtbWc0TGZOd2gxaDUvblBqdTM5MVR0K0VDYzM5Z0dDT3A2?=
 =?utf-8?B?YmJ6SHU2UWZMeXpJWXFiTmd1NDVZSFJVdTBnb09Ebk1jYVVMcjJ3M2hwUmN5?=
 =?utf-8?B?MGlKSTlqejJPMjBtUUMzQnZiSnMvYnpZOVkyM1hadG1uM21zWmpyWll0SGdt?=
 =?utf-8?B?TUxpcUNnZUFwOXJwb2J2Y3RUMXJPOXBwTFdxenhCZytSYjVUaWpYVXNiM1VP?=
 =?utf-8?B?NS9sRjNoengyM21kVWN6OGdDT0krRnpON2lCQmtsYXNGOVV5dDMrdGxySW5l?=
 =?utf-8?B?VDEycERYSmh6WnY4bnlEMGlONVRWK0F1VXlyRUZQV2YrWDRaZklBdHh2Mjdp?=
 =?utf-8?B?NWFpazE3RTUyUjJmaGhWem1LRzNLY2k0cExkTnFQQithUUZjdWZZeElrUitj?=
 =?utf-8?B?RGdyNlhiN0k2UUZwMVQrZlJNbVdIQ2tKNW5pbHgzTjRXUzZmblV2ZFJXQkJC?=
 =?utf-8?B?bUh6UEw4VGk0YmxYLzR6U25KQjZWVW1sOTdIcFB6aHVtQWpFZzN4SlBDLzd6?=
 =?utf-8?B?TGxvWDhsTFd6N2xUenU1WmpEbWVvZG9BYWNHOFZuVmgvQ3gwaDl5ZGlxWmsx?=
 =?utf-8?B?dXc4TnRXZ3N3cno0dnY0V2xySkVqYUtleU5aZ1VEQUVmUi9XZ0Q5M0RzUlVN?=
 =?utf-8?B?Uis1WGN1MzJaVmRqY0tlVVZaMDJFamNWNkZXSS90a2NiVlhHSThkNVVZMURz?=
 =?utf-8?B?Y3JlK1cvL3JoYk5PTWJJLzc4MldzWk5Id01WWjdRVVJCRHdkU1Q2dm9qTGcr?=
 =?utf-8?B?UmlmbmNRYnhXeDRINTE4bE5WWGU4NGJIcVUwNU94NjZoQk9NSHJCS1lGK0h5?=
 =?utf-8?B?eFZnTWJPVENLZE02bzF6cFN6Q2pYTWtBSC91alJUeXVidk96aU0rMTA4OG5Y?=
 =?utf-8?B?ZThhN3lDQk8vSzFuUXYwTHZCOGw2Y250NkdOL3lLTXRBVHlMTEtCQ0d3dWxQ?=
 =?utf-8?Q?Q041MpTnQWyEkJb64/iRxcsdZNn2lKdW46FDco9iQY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91834e7-8667-463f-6f9e-08de9ea8d413
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 06:48:28.2472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uq/qOLX9GyC0mC3Sg8iIbP8SPPtu40gH3xyOsVliwcPlijXb3qff3+QXRLiJCxfC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6080
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KVGhpcyBkb2VzIG5vdCBmb2xsb3cgc3VibWlzc2lvbiBndWlkZWxpbmVzLg0KU2luY2UgdGhp
cyBpc3N1ZSBjb21lcyBmcm9tIHBhdGNoICMxIHVuZGVyIHJldmlldywgcGxlYXNlIGZpeCBpdCBp
biB0aGUgb3JpZ2luYWwgY29kZSBpbnN0ZWFkIG9mIGFkZGluZyBhIG5ldyBwYXRjaC4NCg0KYnR3
LA0KSSBmb3VuZCBzb21lIGZvcm1hdHRpbmcgaXNzdWVzLCBwbGVhc2UgcnVuIHNjcmlwdHMvY2hl
Y2twYXRjaC5wbCB0byBjaGVjayB5b3VyIHBhdGNoIGZpcnN0IGJlZm9yZSBzZW5kaW5nIGl0IGZv
ciByZXZpZXcuDQpodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9kZXYtdG9v
bHMvY2hlY2twYXRjaC5odG1sDQoNCkJlc3QgUmVnYXJkcywNCktldmluDQoNCi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBSYW1hbGluZ2Vzd2FyYSBSZWRkeSwgS2FuYWxhIDxLYW5h
bGEuUmFtYWxpbmdlc3dhcmFSZWRkeUBhbWQuY29tPg0KU2VudDogRnJpZGF5LCBBcHJpbCAxNywg
MjAyNiAwMTozMg0KVG86IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBWaXNod2FrYXJtYSwgUHJhdGlr
IDxQcmF0aWsuVmlzaHdha2FybWFAYW1kLmNvbT47IEd1dHR1bGEsIFN1cmVzaCA8U3VyZXNoLkd1
dHR1bGFAYW1kLmNvbT47IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQuY29t
Pg0KQ2M6IFJhbWFsaW5nZXN3YXJhIFJlZGR5LCBLYW5hbGEgPEthbmFsYS5SYW1hbGluZ2Vzd2Fy
YVJlZGR5QGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0ggdjMgNC80XSBkcm0vYW1kZ3B1OiBzbXU6
IGZpeCB1bmlmaWVkIG1ldHJpY3MgaGFuZGxpbmcgZm9yIFNNVSAxNS4wLjANCg0KQWRkcmVzcyBy
ZXZpZXcgY29tbWVudHMgYnkgaW52b2tpbmcgU01VX01TR19HZXRNZXRyaWNzVGFibGVMb2dEcmFt
QWRkcg0Kb25seSBvbmNlIGR1cmluZyB0aGUgZmlyc3QgbWV0cmljcyByZXF1ZXN0LiBDYWNoZSB0
aGUgRFJBTSBhZGRyZXNzIGFuZCBtZXRyaWNzIHRhYmxlIHNpemUgcmV0dXJuZWQgYnkgdGhlIFNN
VSBhbmQgcmV1c2UgdGhlbSBmb3Igc3Vic2VxdWVudCBtZXRyaWNzIHF1ZXJpZXMgdG8gYXZvaWQg
cmVkdW5kYW50IFNNVSBjYWxscy4NCg0KQWRkIGEgTlVMTCBjaGVjayBmb3IgdGhlIGlvcmVtYXBf
d2MoKSByZXR1cm4gdmFsdWUgYW5kIGVuc3VyZSB0aGUgbWFwcGluZyBpcyByZWxlYXNlZCB3aXRo
IGlvdW5tYXAoKSBiZWZvcmUgcmV0dXJuaW5nIGZyb20gdGhlIGZ1bmN0aW9uLg0KQWxzbyBhZGQg
c2FuaXR5IGNoZWNrcyBmb3IgdGhlIFNNVeKAkXJlcG9ydGVkIG1ldHJpY3MgdGFibGUgc2l6ZSBh
Z2FpbnN0IHRoZSBleHBlY3RlZCBzaXplIGFuZCBwZXJmb3JtIG1lbWNweSgpIGFjY29yZGluZ2x5
IHRvIHByZXZlbnQgb3V04oCRb2bigJFib3VuZHMgYWNjZXNzLg0KDQpTaWduZWQtb2ZmLWJ5OiBS
YW1hbGluZ2Vzd2FyYSBSZWRkeSwgS2FuYWxhIDxLYW5hbGEuUmFtYWxpbmdlc3dhcmFSZWRkeUBh
bWQuY29tPg0KLS0tDQogLi4uL2RybS9hbWQvcG0vc3dzbXUvc211MTUvc211X3YxNV8wXzBfcHB0
LmMgIHwgNDEgKysrKysrKysrKysrLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNlcnRp
b25zKCspLCAxNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG0vc3dzbXUvc211MTUvc211X3YxNV8wXzBfcHB0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL3N3c211L3NtdTE1L3NtdV92MTVfMF8wX3BwdC5jDQppbmRleCBmMGE3OTg2MzE5MDMuLjhm
OTdiYzZiNjIzNSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211
MTUvc211X3YxNV8wXzBfcHB0LmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUv
c211MTUvc211X3YxNV8wXzBfcHB0LmMNCkBAIC0zMzYsMjYgKzMzNiwzNSBAQCBzdGF0aWMgaW50
IHNtdV92MTVfMF8wX2dldF9ncHVfbWV0cmljc190YWJsZShzdHJ1Y3Qgc211X2NvbnRleHQgKnNt
dSwgIHN0YXRpYyBpbnQgc211X3YxNV8wXzBfZ2V0X21ldHJpY3NfdGFibGUoc3RydWN0IHNtdV9j
b250ZXh0ICpzbXUsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU01V
XzE1XzBfMF9NZXRyaWNzVGFibGVfdCAqbWV0cmljcykgIHsNCi0gICAgICAgdWludDY0X3QgYWRk
cjsNCi0gICAgICAgdm9pZCBfX2lvbWVtICpjcHVfYWRkcjsNCisgICAgICAgdm9pZCBfX2lvbWVt
ICpjcHVfYWRkciA9IE5VTEw7DQogICAgICAgIHN0cnVjdCBzbXVfbXNnX2N0bCAqY3RsID0gJnNt
dS0+bXNnX2N0bDsNCi0gICAgICAgaW50IHJldCwgdGFibGVfc2l6ZTsNCisgICAgICAgc3RydWN0
IHNtdV9tc2dfYXJncyBhcmdzID0gezB9Ow0KKyAgICAgICAvL3N0b3JlIHRhYmxlX3NpemUgYW5k
IERyYW1BZGRyIHZhbHVlIHJldHVybmVkIGJ5IFNNVSBpbiBzdGF0aWMgYXQgZmlyc3QgcmVxdWVz
dCwNCisgICAgICAgLy91c2UgdGhlc2UgdmFsdXNlIHRvIHJlYWQgTG9nU2FtcGxlIGluIGNhc2Ug
b2YgbGF0ZXIgcmVxdWVzdHMNCisgICAgICAgc3RhdGljIGludCB0YWJsZV9zaXplOw0KKyAgICAg
ICBzdGF0aWMgdWludDY0X3QgYWRkcjA7DQorICAgICAgIGludCByZXQ7DQoNCi0gICAgICAgc3Ry
dWN0IHNtdV9tc2dfYXJncyBhcmdzID0gew0KLSAgICAgICAgICAgICAgIC5tc2cgPSBTTVVfTVNH
X0dldE1ldHJpY3NUYWJsZUxvZ0RyYW1BZGRyLA0KLSAgICAgICAgICAgICAgIC5udW1fYXJncyA9
IDAsDQotICAgICAgICAgICAgICAgLm51bV9vdXRfYXJncyA9IDMsDQotICAgICAgIH07DQorICAg
ICAgIGlmIChhZGRyID09IDApIHsNCisgICAgICAgICAgICAgICAvLyBTZW5kIFNNVV9NU0dfR2V0
TWV0cmljc1RhYmxlTG9nRHJhbUFkZHIgb25seSBvbmNlIHRvIGdldCBEcmFtQWRkciBhbmQNCisg
ICAgICAgICAgICAgICAvLyB0YWJsZV9zaXplIGF0IGZpcnN0IHJlcXVlc3QNCisgICAgICAgICAg
ICAgICBhcmdzLm1zZyA9IFNNVV9NU0dfR2V0TWV0cmljc1RhYmxlTG9nRHJhbUFkZHIsDQorICAg
ICAgICAgICAgICAgYXJncy5udW1fYXJncyA9IDAsDQorICAgICAgICAgICAgICAgYXJncy5udW1f
b3V0X2FyZ3MgPSAzLA0KDQotICAgICAgIHJldCA9IGN0bC0+b3BzLT5zZW5kX21zZyhjdGwsICZh
cmdzKTsNCisgICAgICAgICAgICAgICByZXQgPSBjdGwtPm9wcy0+c2VuZF9tc2coY3RsLCAmYXJn
cyk7DQoNCi0gICAgICAgaWYgKHJldCkNCi0gICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KKyAg
ICAgICAgICAgICAgIGlmIChyZXQpDQorICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0
Ow0KDQotICAgICAgIGFkZHIgPSAoKHVpbnQ2NF90KWFyZ3Mub3V0X2FyZ3NbMV0gPDwgMzIpIHwg
YXJncy5vdXRfYXJnc1swXTsNCi0gICAgICAgdGFibGVfc2l6ZSA9IGFyZ3Mub3V0X2FyZ3NbMl07
DQorICAgICAgICAgICAgICAgYWRkciA9ICgodWludDY0X3QpYXJncy5vdXRfYXJnc1sxXSA8PCAz
MikgfCBhcmdzLm91dF9hcmdzWzBdOw0KKyAgICAgICAgICAgICAgIHRhYmxlX3NpemUgPSBhcmdz
Lm91dF9hcmdzWzJdOw0KKw0KKyAgICAgICB9DQoNCiAgICAgICAgY3B1X2FkZHIgPSBpb3JlbWFw
X3djKGFkZHIsIHRhYmxlX3NpemUpOw0KKyAgICAgICBpZiAoIWNwdV9hZGRyKQ0KKyAgICAgICAg
ICAgICAgIHJldHVybiAtRU5PTUVNOw0KDQogICAgICAgIGFyZ3MubXNnID0gU01VX01TR19HZXRN
ZXRyaWNzVGFibGVMb2dTYW1wbGU7DQogICAgICAgIGFyZ3MubnVtX2FyZ3MgPSAwOw0KQEAgLTM2
NCw4ICszNzMsMTIgQEAgc3RhdGljIGludCBzbXVfdjE1XzBfMF9nZXRfbWV0cmljc190YWJsZShz
dHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwNCiAgICAgICAgcmV0ID0gY3RsLT5vcHMtPnNlbmRfbXNn
KGN0bCwgJmFyZ3MpOw0KICAgICAgICBpZiAoIXJldCkgew0KICAgICAgICAgICAgICAgIGFtZGdw
dV9oZHBfaW52YWxpZGF0ZShzbXUtPmFkZXYsIE5VTEwpOy8vYmVzdCB0byBmbHVzaCBiZWZvcmUg
Y29weT8NCi0gICAgICAgICAgICAgICBtZW1jcHkobWV0cmljcywgY3B1X2FkZHIsIHRhYmxlX3Np
emUpOw0KKyAgICAgICAgICAgICAgIGlmICh0YWJsZV9zaXplIDw9IHNpemVvZihTTVVfMTVfMF8w
X01ldHJpY3NUYWJsZV90KSkNCisgICAgICAgICAgICAgICAgICAgICAgIG1lbWNweShtZXRyaWNz
LCBjcHVfYWRkciwgdGFibGVfc2l6ZSk7DQorICAgICAgICAgICAgICAgZWxzZQ0KKyAgICAgICAg
ICAgICAgICAgICAgICAgbWVtY3B5KG1ldHJpY3MsIGNwdV9hZGRyLCBzaXplb2YoU01VXzE1XzBf
MF9NZXRyaWNzVGFibGVfdCkpOw0KICAgICAgICB9DQorICAgICAgIGlvdW5tYXAoY3B1X2FkZHIp
Ow0KICAgICAgICByZXR1cm4gcmV0Ow0KIH0NCg0KLS0NCjIuNTMuMA0KDQo=
