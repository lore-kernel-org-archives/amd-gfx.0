Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA16C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 08:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D4BE10F88B;
	Wed, 11 May 2022 08:44:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7372B10F044
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 08:44:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdHYTYPg6egOABuTtyUO19ypShLXiQucJHT1nD75vaGkXSpTa4IFTO8HcULAux8LU2RZuQM7cDNDrgpBttW9IpMigeX8Nwg7Q+sUbWMX0WzB8wpOwm5JHRNgNnNfjRGp0az97xTGjC0yELVyWISAsU6NNEDV2hdT3Pxxv/HZUoTPQ3mLb1gIMkuB78kokby2t0f7yJC6KYmbO6nMeeDGN5ks1Xhjx0DOC+pIGfKuiHyEWPxFv8eNwU8l+8h1H1PMEz++O1oFOEZ6HxtkeBHyNbxv289IoEDUBpAsVrwPSJqn7KwrZ6CW9MeiF4Yc93PAcyKLhdmDKjWwIXl9ecpizw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Gt2VzwLlQtdzDfv0r6lpcZ2IybILYHumjycSYquy1I=;
 b=cyOIYRs9i6Ci9BCcUCWuUw/RoXgfGIf85CAf2h3i9O/VeSCp9hKMB3TxlVAI/RBIs9gzwZDIgIXsR9EcKA/R5vCbF/asB58S0FY+fX64M1UHcJXMoo8I7HyRg95vBVnGyud6nedrV84qo/RYRN8PgsnvEjqPo4aWv17o/I0IH3SSIDLADu7yrtnr/LiAVHAX5Qvy+ruCkwvhCLVX0R5X60r0rGd8ZLjOt1aCUzmff/V4Zrstugs98Gj5kCF6KYow/f8VWHAiD7uf8LKyh6CePuKshjtvXeNl0lFOysHzc4zFCWpYUCgPXMS0R0P5vAuTNTwEcV1Kc/M3zUecBrhRkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Gt2VzwLlQtdzDfv0r6lpcZ2IybILYHumjycSYquy1I=;
 b=O1aSlcHpH5hm7LcfcS/cmTAUIJDLmNtBancS8wQeWCQyjKpjxVDG2XJDcw7ZIk2eoXN2Hmnkewa5sdjHlgrtDntyUHXA0xpi6/0XlT+I35bg+F8DLd5y6DbBAMuwn569iWgM42x2AvVlHPqluZ3qpIcODJl+w5RdGHUIDNPPfhk=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 MN2PR12MB4584.namprd12.prod.outlook.com (2603:10b6:208:24e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 11 May
 2022 08:44:15 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::9c68:a1fd:1445:49ad]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::9c68:a1fd:1445:49ad%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 08:44:15 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDEvMl0gZHJtL2FtZC9wbTogYWRkIHNtdSBmZWF0dXJl?=
 =?gb2312?B?IG1hcCBzdXBwb3J0IGZvciBzbXVfdjEzXzBfNw==?=
Thread-Topic: [PATCH 1/2] drm/amd/pm: add smu feature map support for
 smu_v13_0_7
Thread-Index: AQHYZPVYkC6LF8xfi0qCudfjSURGRa0ZXGt/
Date: Wed, 11 May 2022 08:44:15 +0000
Message-ID: <DM4PR12MB5165C44485151A7B491F33028EC89@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20220511050928.735909-1-KevinYang.Wang@amd.com>
In-Reply-To: <20220511050928.735909-1-KevinYang.Wang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-11T08:43:20.9899292Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9dfb2975-2774-4bd9-fef8-08da332a6dea
x-ms-traffictypediagnostic: MN2PR12MB4584:EE_
x-microsoft-antispam-prvs: <MN2PR12MB45847DB8FE540AD1F39D58338EC89@MN2PR12MB4584.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iZ+B4rxhEynkJMZRVnyxyfqRvU/tRp6ZgRpnc6Qlru4CI4PZ1GKupQFnFdRgp5dJsfqQ3NrJuettGtmmiz8mXeX9nLWwkg4fnNLKBtwX5YBwW5JPwg4EeZ/7OVwIccxbB1wnE7skGm7UGCk0QpjtH1fmLz3kbMlJfk4Ko8CehpaSdmsW5kdY+h2s7nVNbxhrsRMsaE5gRBFcuXcHVLaK0FkHCZbkiBpYQQ9+fLKj/Gu87fDe6rKCPqs+tRyj8qOUzIyMVwLhmp8pFrb6MI+l2iwYlOKUkEurIa2NOJMKATfrfaHFg6TmjZh0AgPawYRcx6RWsqa+VRXVC/mUEPrev8ds8J1EfXVPe7Q6Bt6JfBH6/wOf4hYfJGs/AlPDCUW8ThTHADo9y13BWUma+4nFEC6F3Nq0wgu7porJG+wiOfVUOIFazwhqjUcDut2RK3QdhmzWErHE4gmICI4XRrPnAvOFnhZz9c2zxTZl2UsWTU+LB1+8CLaUH+u8n77CXD9Nbjs5VuWxDlPLPnSo4v+fTZCUR6N108wy0EvejvqjbHA7TXj8Do2+hV51bxOpx8Uwy1Wiw9yFccn0Xaugu7TOv4HsC5ykW4yaRkT1L0Z4LbtdmSgoJLC7VQBxkUrDT72wWaVupXYmEd0IpDK0iFD7rSKqK+AMc9OXOJQYyAlq/HfyuOL5esRdXHbGB9UgYjovz6dJ5SmS33hTfnLcCe5SlA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(66556008)(66946007)(66476007)(4326008)(86362001)(66446008)(64756008)(76116006)(508600001)(71200400001)(122000001)(5660300002)(316002)(110136005)(91956017)(52536014)(55016003)(8936002)(83380400001)(38070700005)(26005)(9686003)(186003)(224303003)(7696005)(33656002)(6506007)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZjBQSC9NeTZQMFBlalpKRWY2TGJ4UWFQTTV2ZElQL09WZ0dKRFhxazFMR0Yw?=
 =?gb2312?B?czNCWUNhMTR1YWdJZ051eklaU3Y2bE9pWk5RcFBVKzQ3alF3Yk1Td1pGaldo?=
 =?gb2312?B?VUlUSi9uRTZKNCtWTm1SSEZjdFJuYyt3NnM3MDJRUDNEVSt1RERGZEhpbDRi?=
 =?gb2312?B?a0pSYS9La1hwRFdNZFpGbnBxSEl2ZFV4b0xHVWI1TllHa3FJb1NsVUIrdUFR?=
 =?gb2312?B?U2pGTWJwY0FoT2VCZjBHWktMUkVjeDRQYkRZUmxJampXYzNYZU9tRlpHOVA1?=
 =?gb2312?B?bG9SN1h0eW5maENqSUxUS2UrSElycjJkL2Z2TW1Ob2tXcmVRdXhzUGY5ZjdI?=
 =?gb2312?B?VXNZM0ZNRW1lWGxWVTFRRm1Wd0FGZVBWODBtODNBaDE0LzZwS1g0cXM2cUkv?=
 =?gb2312?B?SU5tVXJzSDM2UDlUNW9jVHBYOVRaVkJOVnpwV2s3SWxNUG02d2tYdzRWeHAr?=
 =?gb2312?B?TDNvclRLUGhCS0w0UDQ5T2JiZklKdTNqWHR3d0c3N25zTCtYZjlTc29IWkd6?=
 =?gb2312?B?L2sxejFNeWhBRTFJOHlRbzlMMEtDbEZVSG42MDFMOU5zMS9haWZLcU5HcDJP?=
 =?gb2312?B?RFpYNno3NnBCQ3hFcC9wM1VTaEo4RkdjSFBZNkhnZHlRMXZLTEhDWUlzMDdt?=
 =?gb2312?B?NVptOVpnWWkzT0RHdXo3dkhETit6VjRuVnRIdWdsY0hvV1ZzOUhCMk10VzVj?=
 =?gb2312?B?TmZ1S1h5N3NJdkhFcmk0U2s0U0NGaXNTakp0aUlLb1ExOW16OEc3T2JDNG5J?=
 =?gb2312?B?NklmTG9uNkxSMlpRS2NabFB3aUpCWDAyNEV5WXZJcXNRdGpRckJwTTJEM0Nr?=
 =?gb2312?B?Wm9aVlRVTDB5Q2g1N0E5MEtHSzk0Vkc4b21FVHF4Y0dWRG5NU1FBOG9OdGxL?=
 =?gb2312?B?ZTliQitVSkFiMWRGeFBRNzVpa0srQmV5dDlFTFJYZWRpK2ljck1ScTdrZ1Ux?=
 =?gb2312?B?aUZUcVlOS2NZVWdXc2w0aHZ4MzdHWHQrUUpMdk1Ga3BNS2NWeTVkODR5SjYy?=
 =?gb2312?B?QlRBeDNLc2kyTkxBVTdaamtOZzB1MXRxT25HWnJsR2V2NVNrM0xCaTIwWnc2?=
 =?gb2312?B?Z3J0OHdBL210eVQ4ZVNCNiswR1RzbUdRcmJ6OGxLTEMvREdRdUo3VU9VSFNM?=
 =?gb2312?B?SnF4Zkt0WUp3SU40NUNmYzNXY0JOQXN3T0UveFRicFNIMUdqMVkyVXVueXhG?=
 =?gb2312?B?bTBndjJXS0IvaVlUTDZrcnpNNGJWMmVwZlRuNU5pZVpRdmR4VW1Dem15aUZF?=
 =?gb2312?B?aG01djNRUVo5TytTVDhVNHBSRmQ4cVRrSTB6U3B6Wm9aUWtoSGZtdlZuYVRU?=
 =?gb2312?B?MG4wSnR1M2xpQ2FHc3pWU1FOTzJ0bWhOeHVHWmZOVkdTTDZpdjhsbXZuOEpE?=
 =?gb2312?B?SjhQVzhRYW9BT2VuLzA5Q0NTUlRjZ3M3T0JRQkZWZmVmUFErUXBmUVFESkRu?=
 =?gb2312?B?M0NUbzI1cW9Md1Y2d0NzdUR0NE81Y2NlaG9kSnBCK1MyUVVrOTdxUmdFRVk2?=
 =?gb2312?B?aFdCMDNFdUhZenpDZVVCaWNvOWgybjdMMmdCUUpPNDVsc1dDVkJaNXFXR1ZX?=
 =?gb2312?B?QnUybGhJMk91VFRQb24xY1FKTTNNalNiSGUxbHZxNm9IckVlNC8xSzdMNFND?=
 =?gb2312?B?NTMyK1Rmaml6TzlBa2NScmJHRi9wT0s1RkZZNFBTZ0p4cmRVVUV3TW00a2N1?=
 =?gb2312?B?TTJydmxtbGRwZUJISHBqZFg1Q082enlMVTBkOWI2akFRR3VXV0VpK3dYbFFz?=
 =?gb2312?B?WGFFeHRaSm1ObDVDMEdhMHkrdjdnZCtyRXltaFprb2ZjYzY2VGp5Q1A3QUVD?=
 =?gb2312?B?MXBBNXF6TUlBWVVBcnJDb1VpaGJ1Z29UejNSQU16ZFp3SkpVT0ZtK2hBenVj?=
 =?gb2312?B?d0liWXgzZ0F2cTRIekZ4MzhYNThUM2pqVlVFbFVIZFZQMFVzemNpd1ZGdEhX?=
 =?gb2312?B?THZYWjZyeUVKMmF5VmcrQWF1eWNEVlg1aEVlZFh0cHVFZFcrVWRRU0xJamJs?=
 =?gb2312?B?Vk5GNUJQcHU3K09TRkg4NFBweVZmeG1LWGVTYnArZUZ4R1MxSEJxcGF6R0VV?=
 =?gb2312?B?eVRoWGhXL3dXb0k4MGdpNmQyZEJ5cU0raVB3aFptWDlNeG5QUUdhQ3o0Uzhx?=
 =?gb2312?B?QVpDbUJGeWlDb1kxUUtsMWlkb1JKTVZBM2RHNS9XUUY0aVY1M0lrRGR2T3p3?=
 =?gb2312?B?N1ZNY09CTHJPVXR5QSsycHNDZDdxK00zTm1KT1g5QmhkeDA4RGVFcVVTTUlL?=
 =?gb2312?B?M0phQmRJZFlzcksrOENVVzRQQmJyMTIwVExHWjNvdnhZd3ptY0x6azVDNzNY?=
 =?gb2312?B?NjJNUnF4S2d3SFZUeExPUnFFY3dYaTI4S0ltd3VseVJjdnp1bVFVdHgyRENY?=
 =?gb2312?Q?zyVXHG9gA9tGGZyA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5165C44485151A7B491F33028EC89DM4PR12MB5165namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfb2975-2774-4bd9-fef8-08da332a6dea
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 08:44:15.1794 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8oiG/6H9muKnwV/NSIFhZmLcoN5vFQeHAQwHLWK5VLFY1PUCnzmpJVMG6JH6s8rj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4584
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
Cc: "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB5165C44485151A7B491F33028EC89DM4PR12MB5165namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClNlcmllcyBpcyBSZXZpZXdlZC1i
eTogS2VubmV0aCBGZW5nIDxrZW5uZXRoLmZlbmdAYW1kLmNvbTxtYWlsdG86a2VubmV0aC5mZW5n
QGFtZC5jb20+Pg0KDQoNCkJlc3Qgd2lzaGVzDQpLZW5uZXRoIEZlbmcNCg0KDQq3orz+yMs6IGFt
ZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+ILT6se0gWWFuZyBX
YW5nIDxLZXZpbllhbmcuV2FuZ0BhbWQuY29tPg0KyNXG2jog0MfG2sj9LCAyMDIyxOo11MIxMcjV
IDEzOjA5DQrK1bz+yMs6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIDxhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZz4NCrOty806IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcu
V2FuZ0BhbWQuY29tPg0K1vfM4jogW1BBVENIIDEvMl0gZHJtL2FtZC9wbTogYWRkIHNtdSBmZWF0
dXJlIG1hcCBzdXBwb3J0IGZvciBzbXVfdjEzXzBfNw0KW0NBVVRJT046IEV4dGVybmFsIEVtYWls
XQ0KDQp0aGUgcHBfZmVhdHVyZXMgY2FuJ3QgZGlzcGxheSBmdWxsIGZlYXV0dXJlIGluZm9ybWF0
aW9uDQp3aGVuIHRoZXNlIG1hcHBpbmcgaXMgbm90IGV4aXRpbmcuDQoNClNpZ25lZC1vZmYtYnk6
IFlhbmcgV2FuZyA8S2V2aW5ZYW5nLldhbmdAYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG0vc3dzbXUvaW5jL3NtdV90eXBlcy5oICB8IDIzICsrKysrKysrDQogLi4uL2RybS9h
bWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wXzdfcHB0LmMgIHwgNTggKysrKysrKysrKysrKysr
Ky0tLQ0KIDIgZmlsZXMgY2hhbmdlZCwgNzMgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvaW5jL3NtdV90eXBl
cy5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMvc211X3R5cGVzLmgNCmluZGV4
IDNmNDBjZDZlNDE2NS4uNzk5MDUwZWE3NTE1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9wbS9zd3NtdS9pbmMvc211X3R5cGVzLmgNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG0vc3dzbXUvaW5jL3NtdV90eXBlcy5oDQpAQCAtMzY4LDYgKzM2OCwyOSBAQCBlbnVtIHNtdV9j
bGtfdHlwZSB7DQogICAgICAgIF9fU01VX0RVTU1ZX01BUChEQVRBX0NBTENVTEFUSU9OKSwgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBcDQogICAgICAgIF9fU01VX0RVTU1ZX01BUChEUE1f
VkNMSyksICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICAgICAgX19TTVVfRFVNTVlfTUFQKERQ
TV9EQ0xLKSwgICAgICAgICAgICAgICAgICAgICAgXA0KKyAgICAgICBfX1NNVV9EVU1NWV9NQVAo
RldfREFUQV9SRUFEKSwgICAgICAgICAgICAgICAgICBcDQorICAgICAgIF9fU01VX0RVTU1ZX01B
UChEUE1fR0ZYX1BPV0VSX09QVElNSVpFUiksICAgICAgIFwNCisgICAgICAgX19TTVVfRFVNTVlf
TUFQKERQTV9EQ04pLCAgICAgICAgICAgICAgICAgICAgICAgXA0KKyAgICAgICBfX1NNVV9EVU1N
WV9NQVAoVk1FTVBfU0NBTElORyksICAgICAgICAgICAgICAgICBcDQorICAgICAgIF9fU01VX0RV
TU1ZX01BUChWRERJT19NRU1fU0NBTElORyksICAgICAgICAgICAgIFwNCisgICAgICAgX19TTVVf
RFVNTVlfTUFQKE1NX0RQTSksICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQorICAg
ICAgIF9fU01VX0RVTU1ZX01BUChTT0NfTVBDTEtfRFMpLCAgICAgICAgICAgICAgICAgIFwNCisg
ICAgICAgX19TTVVfRFVNTVlfTUFQKEJBQ09fTVBDTEtfRFMpLCAgICAgICAgICAgICAgICAgXA0K
KyAgICAgICBfX1NNVV9EVU1NWV9NQVAoVEhST1RUTEVSUyksICAgICAgICAgICAgICAgICAgICBc
DQorICAgICAgIF9fU01VX0RVTU1ZX01BUChTTUFSVFNISUZUKSwgICAgICAgICAgICAgICAgICAg
IFwNCisgICAgICAgX19TTVVfRFVNTVlfTUFQKEdGWF9SRUFEX01BUkdJTiksICAgICAgICAgICAg
ICAgXA0KKyAgICAgICBfX1NNVV9EVU1NWV9NQVAoR0ZYX0lNVSksICAgICAgICAgICAgICAgICAg
ICAgICBcDQorICAgICAgIF9fU01VX0RVTU1ZX01BUChHRlhfUENDX0RGTEwpLCAgICAgICAgICAg
ICAgICAgIFwNCisgICAgICAgX19TTVVfRFVNTVlfTUFQKEJPT1RfVElNRV9DQUwpLCAgICAgICAg
ICAgICAgICAgXA0KKyAgICAgICBfX1NNVV9EVU1NWV9NQVAoQk9PVF9QT1dFUl9PUFQpLCAgICAg
ICAgICAgICAgICAgICAgICAgIFwNCisgICAgICAgX19TTVVfRFVNTVlfTUFQKEdGWENMS19TUFJF
QURfU1BFQ1RSVU0pLCAgICAgICAgICAgICAgICBcDQorICAgICAgIF9fU01VX0RVTU1ZX01BUChT
T0NfUENDKSwgICAgICAgICAgICAgICAgICAgICAgIFwNCisgICAgICAgX19TTVVfRFVNTVlfTUFQ
KE9QVElNSVpFRF9WTUlOKSwgICAgICAgICAgICAgICAgICAgICAgICBcDQorICAgICAgIF9fU01V
X0RVTU1ZX01BUChDTE9DS19QT1dFUl9ET1dOX0JZUEFTUyksICAgICAgIFwNCisgICAgICAgX19T
TVVfRFVNTVlfTUFQKE1FTV9URU1QX1JFQUQpLCAgICAgICAgICAgICAgICAgXA0KKyAgICAgICBf
X1NNVV9EVU1NWV9NQVAoQVRIVUJfTU1IVUJfUEcpLCAgICAgICAgICAgICAgICAgICAgICAgIFwN
CisgICAgICAgX19TTVVfRFVNTVlfTUFQKEJBQ09fQ0cpLCAgICAgICAgICAgICAgICAgICAgICAg
XA0KKyAgICAgICBfX1NNVV9EVU1NWV9NQVAoU09DX0NHKSwNCg0KICN1bmRlZiBfX1NNVV9EVU1N
WV9NQVANCiAjZGVmaW5lIF9fU01VX0RVTU1ZX01BUChmZWF0dXJlKSAgICAgICBTTVVfRkVBVFVS
RV8jI2ZlYXR1cmUjI19CSVQNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3
c211L3NtdTEzL3NtdV92MTNfMF83X3BwdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3Nt
dS9zbXUxMy9zbXVfdjEzXzBfN19wcHQuYw0KaW5kZXggMDA5NjRiMzcyOGZlLi43YzllMGJhN2Fi
NTAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92
MTNfMF83X3BwdC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3Nt
dV92MTNfMF83X3BwdC5jDQpAQCAtMTMxLDE0ICsxMzEsNTYgQEAgc3RhdGljIHN0cnVjdCBjbW4y
YXNpY19tYXBwaW5nIHNtdV92MTNfMF83X2Nsa19tYXBbU01VX0NMS19DT1VOVF0gPSB7DQogfTsN
Cg0KIHN0YXRpYyBzdHJ1Y3QgY21uMmFzaWNfbWFwcGluZyBzbXVfdjEzXzBfN19mZWF0dXJlX21h
c2tfbWFwW1NNVV9GRUFUVVJFX0NPVU5UXSA9IHsNCi0gICAgICAgW1NNVV9GRUFUVVJFX0RQTV9H
RlhDTEtfQklUXSA9IHsxLCBGRUFUVVJFX0RQTV9HRlhDTEtfQklUfSwNCi0gICAgICAgW1NNVV9G
RUFUVVJFX0RQTV9VQ0xLX0JJVF0gPSB7MSwgRkVBVFVSRV9EUE1fVUNMS19CSVR9LA0KLSAgICAg
ICBbU01VX0ZFQVRVUkVfRFBNX0ZDTEtfQklUXSA9IHsxLCBGRUFUVVJFX0RQTV9GQ0xLX0JJVH0s
DQotICAgICAgIFtTTVVfRkVBVFVSRV9EUE1fU09DQ0xLX0JJVF0gPSB7MSwgRkVBVFVSRV9EUE1f
U09DQ0xLX0JJVH0sDQotICAgICAgIFtTTVVfRkVBVFVSRV9EUE1fTElOS19CSVRdID0gezEsIEZF
QVRVUkVfRFBNX0xJTktfQklUfSwNCi0gICAgICAgW1NNVV9GRUFUVVJFX0RQTV9WQ0xLX0JJVF0g
PSB7MSwgRkVBVFVSRV9NTV9EUE1fQklUfSwNCi0gICAgICAgW1NNVV9GRUFUVVJFX0RQTV9EQ0xL
X0JJVF0gPSB7MSwgRkVBVFVSRV9NTV9EUE1fQklUfSwNCi0gICAgICAgW1NNVV9GRUFUVVJFX0ZB
Tl9DT05UUk9MX0JJVF0gPSB7MSwgRkVBVFVSRV9GQU5fQ09OVFJPTF9CSVR9LA0KKyAgICAgICBG
RUFfTUFQKEZXX0RBVEFfUkVBRCksDQorICAgICAgIEZFQV9NQVAoRFBNX0dGWENMSyksDQorICAg
ICAgIEZFQV9NQVAoRFBNX0dGWF9QT1dFUl9PUFRJTUlaRVIpLA0KKyAgICAgICBGRUFfTUFQKERQ
TV9VQ0xLKSwNCisgICAgICAgRkVBX01BUChEUE1fRkNMSyksDQorICAgICAgIEZFQV9NQVAoRFBN
X1NPQ0NMSyksDQorICAgICAgIEZFQV9NQVAoRFBNX01QMENMSyksDQorICAgICAgIEZFQV9NQVAo
RFBNX0xJTkspLA0KKyAgICAgICBGRUFfTUFQKERQTV9EQ04pLA0KKyAgICAgICBGRUFfTUFQKFZN
RU1QX1NDQUxJTkcpLA0KKyAgICAgICBGRUFfTUFQKFZERElPX01FTV9TQ0FMSU5HKSwNCisgICAg
ICAgRkVBX01BUChEU19HRlhDTEspLA0KKyAgICAgICBGRUFfTUFQKERTX1NPQ0NMSyksDQorICAg
ICAgIEZFQV9NQVAoRFNfRkNMSyksDQorICAgICAgIEZFQV9NQVAoRFNfTENMSyksDQorICAgICAg
IEZFQV9NQVAoRFNfRENGQ0xLKSwNCisgICAgICAgRkVBX01BUChEU19VQ0xLKSwNCisgICAgICAg
RkVBX01BUChHRlhfVUxWKSwNCisgICAgICAgRkVBX01BUChGV19EU1RBVEUpLA0KKyAgICAgICBG
RUFfTUFQKEdGWE9GRiksDQorICAgICAgIEZFQV9NQVAoQkFDTyksDQorICAgICAgIEZFQV9NQVAo
TU1fRFBNKSwNCisgICAgICAgRkVBX01BUChTT0NfTVBDTEtfRFMpLA0KKyAgICAgICBGRUFfTUFQ
KEJBQ09fTVBDTEtfRFMpLA0KKyAgICAgICBGRUFfTUFQKFRIUk9UVExFUlMpLA0KKyAgICAgICBG
RUFfTUFQKFNNQVJUU0hJRlQpLA0KKyAgICAgICBGRUFfTUFQKEdUSFIpLA0KKyAgICAgICBGRUFf
TUFQKEFDREMpLA0KKyAgICAgICBGRUFfTUFQKFZSMEhPVCksDQorICAgICAgIEZFQV9NQVAoRldf
Q1RGKSwNCisgICAgICAgRkVBX01BUChGQU5fQ09OVFJPTCksDQorICAgICAgIEZFQV9NQVAoR0ZY
X0RDUyksDQorICAgICAgIEZFQV9NQVAoR0ZYX1JFQURfTUFSR0lOKSwNCisgICAgICAgRkVBX01B
UChMRURfRElTUExBWSksDQorICAgICAgIEZFQV9NQVAoR0ZYQ0xLX1NQUkVBRF9TUEVDVFJVTSks
DQorICAgICAgIEZFQV9NQVAoT1VUX09GX0JBTkRfTU9OSVRPUiksDQorICAgICAgIEZFQV9NQVAo
T1BUSU1JWkVEX1ZNSU4pLA0KKyAgICAgICBGRUFfTUFQKEdGWF9JTVUpLA0KKyAgICAgICBGRUFf
TUFQKEJPT1RfVElNRV9DQUwpLA0KKyAgICAgICBGRUFfTUFQKEdGWF9QQ0NfREZMTCksDQorICAg
ICAgIEZFQV9NQVAoU09DX0NHKSwNCisgICAgICAgRkVBX01BUChERl9DU1RBVEUpLA0KKyAgICAg
ICBGRUFfTUFQKEdGWF9FREMpLA0KKyAgICAgICBGRUFfTUFQKEJPT1RfUE9XRVJfT1BUKSwNCisg
ICAgICAgRkVBX01BUChDTE9DS19QT1dFUl9ET1dOX0JZUEFTUyksDQorICAgICAgIEZFQV9NQVAo
RFNfVkNOKSwNCisgICAgICAgRkVBX01BUChCQUNPX0NHKSwNCisgICAgICAgRkVBX01BUChNRU1f
VEVNUF9SRUFEKSwNCisgICAgICAgRkVBX01BUChBVEhVQl9NTUhVQl9QRyksDQorICAgICAgIEZF
QV9NQVAoU09DX1BDQyksDQogfTsNCg0KIHN0YXRpYyBzdHJ1Y3QgY21uMmFzaWNfbWFwcGluZyBz
bXVfdjEzXzBfN190YWJsZV9tYXBbU01VX1RBQkxFX0NPVU5UXSA9IHsNCi0tDQoyLjI1LjENCg==

--_000_DM4PR12MB5165C44485151A7B491F33028EC89DM4PR12MB5165namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:=CB=CE=CC=E5;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:DengXian;
	color:windowtext;}
span.searchhighlight
	{mso-style-name:searchhighlight;}
span.apple-converted-space
	{mso-style-name:apple-converted-space;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span class=3D"searchhighlight"><span lang=3D"EN-US"=
 style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color=
:#070706;background:#FFEE94">Series</span></span><span class=3D"apple-conve=
rted-space"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quo=
t;Calibri&quot;,sans-serif;color:#070706;background:#FFEE94">&nbsp;</span><=
/span><span class=3D"searchhighlight"><span lang=3D"EN-US" style=3D"font-si=
ze:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#070706;backgrou=
nd:#FFEE94">is</span></span><span class=3D"apple-converted-space"><span lan=
g=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-=
serif;color:#070706;background:#FFEE94">&nbsp;</span></span><span class=3D"=
searchhighlight"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family=
:&quot;Calibri&quot;,sans-serif;color:#070706;background:#FFEE94">Reviewed-=
by</span></span><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:=
&quot;Calibri&quot;,sans-serif;color:black">:
 Kenneth Feng &lt;</span><span lang=3D"EN-US" style=3D"color:black"><a href=
=3D"mailto:kenneth.feng@amd.com" title=3D"mailto:kenneth.feng@amd.com"><spa=
n style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;colo=
r:#0078D4">kenneth.feng@amd.com</span></a></span><span lang=3D"EN-US" style=
=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black=
">&gt;</span><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<div>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Best wishes<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Kenneth Feng&nbsp;<o:p></o:p></=
span></p>
</div>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"col=
or:black">=B7=A2=BC=FE=C8=CB</span></b><b><span lang=3D"EN-US" style=3D"fon=
t-family:&quot;Calibri&quot;,sans-serif;color:black">:</span></b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
> amd-gfx
 &lt;amd-gfx-bounces@lists.freedesktop.org&gt; </span><span style=3D"color:=
black">=B4=FA=B1=ED</span><span lang=3D"EN-US" style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;color:black"> Yang Wang &lt;KevinYang.Wang@amd.com&=
gt;<br>
</span><b><span style=3D"color:black">=C8=D5=C6=DA</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black">
</span><span style=3D"color:black">=D0=C7=C6=DA=C8=FD</span><span lang=3D"E=
N-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">, 20=
22</span><span style=3D"color:black">=C4=EA</span><span lang=3D"EN-US" styl=
e=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">5</span><span =
style=3D"color:black">=D4=C2</span><span lang=3D"EN-US" style=3D"font-famil=
y:&quot;Calibri&quot;,sans-serif;color:black">11</span><span style=3D"color=
:black">=C8=D5</span><span lang=3D"EN-US" style=3D"font-family:&quot;Calibr=
i&quot;,sans-serif;color:black">
 13:09<br>
</span><b><span style=3D"color:black">=CA=D5=BC=FE=C8=CB</span></b><b><span=
 lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:b=
lack">:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&q=
uot;,sans-serif;color:black"> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lis=
ts.freedesktop.org&gt;<br>
</span><b><span style=3D"color:black">=B3=AD=CB=CD</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black"> Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;<b=
r>
</span><b><span style=3D"color:black">=D6=F7=CC=E2</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black"> [PATCH 1/2] drm/amd/pm: add smu feature map suppor=
t
 for smu_v13_0_7<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-size:11.0pt">[CAUTION: External Email]<br>
<br>
the pp_features can't display full feauture information<br>
when these mapping is not exiting.<br>
<br>
Signed-off-by: Yang Wang &lt;KevinYang.Wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h&nbsp; | 23 ++++++++<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c&nbsp; | 58 +++++++++++++=
+++---<br>
&nbsp;2 files changed, 73 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_types.h<br>
index 3f40cd6e4165..799050ea7515 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h<br>
@@ -368,6 +368,29 @@ enum smu_clk_type {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(DATA_CALCULATION=
),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(DPM_VCLK),&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(DPM_DCLK),&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(FW_DATA_READ),&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(DPM_GFX_POWER_OPTIMIZ=
ER),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(DPM_DCN),&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(VMEMP_SCALING),&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(VDDIO_MEM_SCALING),&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(MM_DPM),&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(SOC_MPCLK_DS),&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(BACO_MPCLK_DS),&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(THROTTLERS),&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(SMARTSHIFT),&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(GFX_READ_MARGIN),&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(GFX_IMU),&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(GFX_PCC_DFLL),&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(BOOT_TIME_CAL),&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(BOOT_POWER_OPT),&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(GFXCLK_SPREAD_SPECTRU=
M),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(SOC_PCC),&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(OPTIMIZED_VMIN),&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(CLOCK_POWER_DOWN_BYPA=
SS),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(MEM_TEMP_READ),&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(ATHUB_MMHUB_PG),&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(BACO_CG),&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(SOC_CG),<br>
<br>
&nbsp;#undef __SMU_DUMMY_MAP<br>
&nbsp;#define __SMU_DUMMY_MAP(feature)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
SMU_FEATURE_##feature##_BIT<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
index 00964b3728fe..7c9e0ba7ab50 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
@@ -131,14 +131,56 @@ static struct cmn2asic_mapping smu_v13_0_7_clk_map[SM=
U_CLK_COUNT] =3D {<br>
&nbsp;};<br>
<br>
&nbsp;static struct cmn2asic_mapping smu_v13_0_7_feature_mask_map[SMU_FEATU=
RE_COUNT] =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [SMU_FEATURE_DPM_GFXCLK_BIT] =3D {1, =
FEATURE_DPM_GFXCLK_BIT},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [SMU_FEATURE_DPM_UCLK_BIT] =3D {1, FE=
ATURE_DPM_UCLK_BIT},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [SMU_FEATURE_DPM_FCLK_BIT] =3D {1, FE=
ATURE_DPM_FCLK_BIT},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [SMU_FEATURE_DPM_SOCCLK_BIT] =3D {1, =
FEATURE_DPM_SOCCLK_BIT},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [SMU_FEATURE_DPM_LINK_BIT] =3D {1, FE=
ATURE_DPM_LINK_BIT},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [SMU_FEATURE_DPM_VCLK_BIT] =3D {1, FE=
ATURE_MM_DPM_BIT},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [SMU_FEATURE_DPM_DCLK_BIT] =3D {1, FE=
ATURE_MM_DPM_BIT},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [SMU_FEATURE_FAN_CONTROL_BIT] =3D {1,=
 FEATURE_FAN_CONTROL_BIT},<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(FW_DATA_READ),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(DPM_GFXCLK),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(DPM_GFX_POWER_OPTIMIZER),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(DPM_UCLK),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(DPM_FCLK),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(DPM_SOCCLK),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(DPM_MP0CLK),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(DPM_LINK),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(DPM_DCN),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(VMEMP_SCALING),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(VDDIO_MEM_SCALING),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(DS_GFXCLK),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(DS_SOCCLK),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(DS_FCLK),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(DS_LCLK),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(DS_DCFCLK),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(DS_UCLK),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(GFX_ULV),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(FW_DSTATE),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(GFXOFF),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(BACO),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(MM_DPM),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(SOC_MPCLK_DS),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(BACO_MPCLK_DS),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(THROTTLERS),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(SMARTSHIFT),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(GTHR),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(ACDC),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(VR0HOT),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(FW_CTF),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(FAN_CONTROL),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(GFX_DCS),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(GFX_READ_MARGIN),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(LED_DISPLAY),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(GFXCLK_SPREAD_SPECTRUM),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(OUT_OF_BAND_MONITOR),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(OPTIMIZED_VMIN),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(GFX_IMU),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(BOOT_TIME_CAL),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(GFX_PCC_DFLL),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(SOC_CG),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(DF_CSTATE),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(GFX_EDC),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(BOOT_POWER_OPT),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(CLOCK_POWER_DOWN_BYPASS),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(DS_VCN),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(BACO_CG),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(MEM_TEMP_READ),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(ATHUB_MMHUB_PG),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(SOC_PCC),<br>
&nbsp;};<br>
<br>
&nbsp;static struct cmn2asic_mapping smu_v13_0_7_table_map[SMU_TABLE_COUNT]=
 =3D {<br>
--<br>
2.25.1<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB5165C44485151A7B491F33028EC89DM4PR12MB5165namp_--
