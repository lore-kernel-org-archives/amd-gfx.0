Return-Path: <SRS0=iszZ=JR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B7EC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 06:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58759611C9
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 06:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58759611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AD5289D8D;
	Tue, 20 Apr 2021 06:55:14 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750057.outbound.protection.outlook.com [40.107.75.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 267C989D8D
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Apr 2021 06:55:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbceMmll38w4rZ/vXmOa3iUh7s5N4lkHH8LQCcXKcW9rh1LPZ3H0Hun6uzlbHuQt5FDvP8XgL5TX/iYksix6a1v5HUJNf2phy29ho+auIhycPDlxuL0ZJ72OOEeryT+A2RVcJQ2j9yYQf0HY5fHGMwQQbu6sAdQz29VcYHEZhyj6zHbp9PalXlCDBDhwpYk7vOASamjpxQoxx7g65WiNCR6gAzPyuILJUq6tnlEjr93sH2DdnYL2NyB0H6R0dCKoCg2Dizn8MP18BADI9sKRvYbvGPXWcviVXTW0Nugp4N+ASc2invMq+OdT6aGXH/QNoNVKtkaPaNzW2MMk5O0j9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+hzFuRKeaCckkcD9ypBZK4rsvAPQzfaqeVDbElZI+4=;
 b=J+erKK9CcVa+LRuCEJhRc6QJ1l4BtNi4y4c9GUIE+W4BJBOzUGuQFRC/873EPz3shrecX8DyPc3WN49sYrRKmBd1NnDX8px3ftViPAyf5Wt2CuFOrFugG9kPZHSq0ouTpuwWMOKUP/EQyv7G/6WS6xhzFo3La1nFK6PSwY0zH9ClEQv4QfWka+Z3kylDYx8NuumqyVtdsPoQELEQ8Kpv7pMuq7oMa7sO6k0BGL3PF0RMm+czEXy7QiLlwrmlQVawLNGrZk5EYfRir+xT9fMpWIWvBMuWfs0LIW1rwOXik5Yr+XFSgo8Kng8IU8cn+gKLjgoCI+Vgt0hWDaKvZ02D2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+hzFuRKeaCckkcD9ypBZK4rsvAPQzfaqeVDbElZI+4=;
 b=1NU6qR5pz5ECzCqhT0gWgDiGX8c/JXjHrYlV4epo12pC4ljcSos0iiwjSYOeYyJ0GnPzlR5IAhv87kP8eGLqP9Atm2G9Yrjm9xzzjsHfDKpA5dcfoUAd2YMjmhf+HIqh4j5sZLJ0STjgFH6lZLQJmNNdXATQ/iq6Ycs8lvv9MG0=
Received: from DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) by
 DM5PR12MB2582.namprd12.prod.outlook.com (2603:10b6:4:b5::37) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Tue, 20 Apr 2021 06:55:10 +0000
Received: from DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::3cf9:ffa6:9371:feee]) by DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::3cf9:ffa6:9371:feee%6]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 06:55:10 +0000
From: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add mem sync flag for SDMA IB test
Thread-Topic: [PATCH] drm/amdgpu: Add mem sync flag for SDMA IB test
Thread-Index: AQHXNYw4fBcJclscOkmPDzaq+sFxnaq89LiAgAAAbMA=
Date: Tue, 20 Apr 2021 06:55:10 +0000
Message-ID: <DM6PR12MB28128F8024704AC7C877B55190489@DM6PR12MB2812.namprd12.prod.outlook.com>
References: <20210420022340.365464-1-Jinzhou.Su@amd.com>
 <a5be6441-625f-3605-0ed7-c2cec03c9a18@gmail.com>
In-Reply-To: <a5be6441-625f-3605-0ed7-c2cec03c9a18@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-20T06:54:58Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=8021bc32-b623-4352-8d5b-d9b921144a7e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75e75388-48d8-4c7c-94d8-08d903c93da5
x-ms-traffictypediagnostic: DM5PR12MB2582:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2582B936509CEE334B9FFCE590489@DM5PR12MB2582.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 34c8mwgyrX8ri/qaNNusCgsYsgQB6oJVTXt1/pAihR5xH560GAzDXtQrmV5qMz8yfwz+NY4Gf4ZrtRX+3V98GqU1sLi5rgsfNbq7SURe8YW68wfT9ObdZJudIWpaDL3AeNb+WFk1Jytdnh1PBYzowjVwK9rvsyQo2Qx+H2DEyyrtbPVPRO1LXt44PCyztz9N0xJB6n6yavQ1HoK6kdHZ6j8L45kSmclCS30/6POyli9M6uESV7L5di6sR7WMdyPVXpX1O2oCjBAYW4Yz1rtB+MYDoV6QzrYxppG8R0909owR8j5TSCbz1Y+Ay4KFr4rYoVKtLE8+QpqFqqvz8l9/bfiVmLbMmXeo666Hq3AUUeqa5zOAWTCpWcYnZHSGEcS3+SXIEJU1F7cfTer3OGGr40ar5wPNH/vuBQQJGBu++jgWZh9c4Ll93I82foRUOmi0+5DJ9PY5m6iT5DjHphFPJgsNhIHUp/Xo/RmueAYLFYN6CX01B7Q6CF5zu6KLdM4/GbMcSDRMUIoI7vo9JVMjt40VPhBGTSmQ+Hh5zD9eWprzhKsjAGFiPabxPPzi1Sr4pwUFg4ZgSKFHiOipFJxkCHYIDUJEi7TEangs3wlixjU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2812.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(478600001)(83380400001)(52536014)(122000001)(66946007)(186003)(66476007)(76116006)(71200400001)(8936002)(66556008)(38100700002)(7696005)(66446008)(66574015)(53546011)(64756008)(86362001)(5660300002)(4326008)(6506007)(8676002)(110136005)(26005)(9686003)(55016002)(316002)(33656002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?VTNNeC9Ba3RlMTI2WTR2RVlZNm9VYVYwb3hJWWR2MXpUSS9Ldk1rSDkvN2xv?=
 =?utf-8?B?UWR4WDdiNUplSmVQM0xBUWMza3NPTWhDRTBkd1VTK1dIYlpMMVBxWXVjWXNs?=
 =?utf-8?B?U2dhUlBUY1d2QVQ0a05KMW1WMjhKU1Z2NzBsNFpmTnFsK2RwMjVGVVduaGJ3?=
 =?utf-8?B?dFlGZXpUeTNNSGx4bjV1SDk1UTJZUTNWT090UWZhNWhEL2VLK01iTFBsdmRH?=
 =?utf-8?B?L1RTem1yOGc0cWRwOFVLb0lRc3BTTnZQRjBBS1BDN2thRW9IMEwwU3JmR3Jt?=
 =?utf-8?B?MjZCazFiQkFGd254SytRdVpGWFVpeE83VXRFcjVOMWF3RXpsbnNSZ2xvdVlT?=
 =?utf-8?B?TGJjSkxmY2VCL2JNdHRFUkVpQklaRHAxVklKY0hpV0l2UGRJN3Z1MjR2ZmMv?=
 =?utf-8?B?SlhRMXdvRjhjYXRkdGh4VFdnaUVrc1I4bERITGNmSS93ay93a0xwWkd6K2N6?=
 =?utf-8?B?SzNuK3FWYUlRbUFHcDZwV0NIaWxGTFdhZnNsdnAxdG5kdm93QWt2cTlyWUlD?=
 =?utf-8?B?cHVSOWk0SjJUZFp4NW00WWRYZGRTL1A4SlMwSFVjaDlMNzJOOThOQmNWekN1?=
 =?utf-8?B?bXMxaFpJMkpxT3o5alVPcVBOaVAwUmpKWUZkNEpvOFRXUDVvd0ZuU3hvbXZ3?=
 =?utf-8?B?N2N4QXhKbWtGV05LY0FGQ1VZMnpzT0pRblh6K29sdm1qWDg3b09wUXZkN1FW?=
 =?utf-8?B?OUZJWHhJUitrZkNHbDg2ZlF0aUEyOExSMVJnWHBpT2RjSyt2OVNIekRCOGU3?=
 =?utf-8?B?Y2hib3J3dnlyRmZtcmp2d1lGNlpuanpWWWc5YTlmL3lFdXJvTHA0UWlkTVV1?=
 =?utf-8?B?cXBKQXNGR2hFNk9JcW9HdXBLUW8rOHBCUWtITXc1Z21DdjZ2QXUxSjlBa295?=
 =?utf-8?B?VlJTZ1VHRS9rNGJuSTk0VGU3ZlVvQ0FjSHgrWWFKV2RMT2tZaVRyOWk1RXIx?=
 =?utf-8?B?c1RiTzlwWHRjMjNES2dhVmVaVEdUOXBpanVyYkpYY3VMbi82dHhDVnZOT05p?=
 =?utf-8?B?VGpDMTdiVmlzWVRJaWJ4S0hMSWdOQjFXSkJmQnlMQkNuR1B5QjE0MHRudWFB?=
 =?utf-8?B?K0VpekpVbUV0MzVic3k5b2dnbXZTTTdmSDNrSVY0d0p5WVRDbVkzY2lTK0VB?=
 =?utf-8?B?L3c4OGpWTEltTSt1TjlTeXZoRXdUVG5pS1RKb05KS3BlMm55NlhGWVZLVlh0?=
 =?utf-8?B?eUhHN3p4UFdSNXNyYTBKSmxjWGcyU1h1K2kzWTZpL0FuVWZMdkxDd3Y0VkdK?=
 =?utf-8?B?RjAzQThOUDZCUmdlekZOTmlEOURwSlhIQUFMOTdQNGFxOHNIRzlPbzN6UFRu?=
 =?utf-8?B?bGd2akt4ZVVzWlRPd1c5cFM0S2FGNk1oMklNZ21tcFJmcWZDdWRBT2ZnbnF2?=
 =?utf-8?B?NWI5bWx2U2VvWW5PMDJXcUtsTnFXNWEweWVFanlNb2UyUW9VTXhrREQzc3Ux?=
 =?utf-8?B?V0F0VzNuV00xVHZobWxBQXJSbW9pa0tlVXRMTXExZWJLTWdNVVIwRTFjUG9l?=
 =?utf-8?B?ZmVhRVk5K1VXMDFOM2lTaFd2Y3NBbmVqREF6MlI0MEdSajhHcVhSTWhkN0J2?=
 =?utf-8?B?L0Z2UXpLam1oMGJLeGUvbE01ZHVnSHc5bFhURGw5c3FsWEhXWmdCMU03alNy?=
 =?utf-8?B?RXNnSFVpNGdxTmwyRlR5YkZ6T3Y5TzdPT2x2Z2d0U2N1NkI5R3I4SnFVR1h3?=
 =?utf-8?B?cVRpMEdCVlZSREFEWEZMRUZNN09QOVFUMUMveldDTXFtYWFzY3lFTnEzM21l?=
 =?utf-8?Q?G9rF7DLVAs8H6C6y23CylZsgKN1saAvAMGsrMUj?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2812.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e75388-48d8-4c7c-94d8-08d903c93da5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 06:55:10.6008 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbztpRHS6BYFoy/6TSH+PPDPYiWsQHnOp319iaMeK4cVFVZcRxYdg3dsmE9RMJRsGA9rzgoPZP0+5fcu1MGUcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2582
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpI
ZWxsbyBDaHJpc3RpYW4sDQoNClRoYW5rcyBmb3IgeW91ciBpbmZvcm1hdGlvbi4gV2UgYWRkIHRo
aXMgZHVlIHRvIHNkbWEwIHRpbWVvdXQgZHVyaW5nIFMzIHN0cmVzcyB0ZXN0Lg0KV2lsbCB1cGRh
dGUgdGhpcyBmb3Igb3RoZXIgY2FzZXMgaW4gdjIuDQoNClJlZ2FyZHMsDQpKb2UNCg0KLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVp
Y2h0enVtZXJrZW5AZ21haWwuY29tPiANClNlbnQ6IFR1ZXNkYXksIEFwcmlsIDIwLCAyMDIxIDI6
MzkgUE0NClRvOiBTdSwgSmluemhvdSAoSm9lKSA8SmluemhvdS5TdUBhbWQuY29tPjsgYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBIdWFuZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNv
bT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IEFkZCBtZW0gc3luYyBmbGFnIGZv
ciBTRE1BIElCIHRlc3QNCg0KQW0gMjAuMDQuMjEgdW0gMDQ6MjMgc2NocmllYiBKaW56aG91IFN1
Og0KPiBUaGUgYnVmZmVyIGZvciBTRE1BIElCIHRlc3QgaXMgYWxsb2NhdGVkIGJ5IHNhIGJvIHdo
aWNoIG1heSBiZSB1c2VkIGJ5IA0KPiBvdGhlciBwdXJwb3NlLiBCZXR0ZXIgdG8gZmx1c2ggdGhl
IGNhY2hlIGJlZm9yZSBjb21taXQgdGhlIElCLg0KDQpHb29kIHBvaW50LCBidXQgc2hvdWxkbid0
IHdlIGRvIHRoaXMgZm9yIGEgbG90IG9mIG90aGVyIGNhc2VzIGFzIHdlbGw/DQoNCkkgdGhpbmsg
dGhlIG9ubHkgcGxhY2Ugd2hlcmUgd2Ugc2hvdWxkIG5vdCBzZXQgdGhlIGZsYWcgaXMgaW4gdGhl
IENTIElPQ1RMLg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0KDQo+DQo+IFNpZ25lZC1vZmYtYnk6
IEppbnpob3UgU3UgPEppbnpob3UuU3VAYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvc2RtYV92NV8yLmMgfCAxICsNCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NkbWFfdjVfMi5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMi5j
DQo+IGluZGV4IGIxYWQ5ZTUyYjIzNC4uZGE2N2Y0NDBiMTAyIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzIuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzIuYw0KPiBAQCAtMTAwMCw2ICsxMDAwLDcgQEAgc3RhdGlj
IGludCBzZG1hX3Y1XzJfcmluZ190ZXN0X2liKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywgbG9u
ZyB0aW1lb3V0KQ0KPiAgIAlpYi5wdHJbN10gPSBTRE1BX1BLVF9OT1BfSEVBREVSX09QKFNETUFf
T1BfTk9QKTsNCj4gICAJaWIubGVuZ3RoX2R3ID0gODsNCj4gICANCj4gKwlpYi5mbGFncyA9IEFN
REdQVV9JQl9GTEFHX0VNSVRfTUVNX1NZTkM7DQo+ICAgCXIgPSBhbWRncHVfaWJfc2NoZWR1bGUo
cmluZywgMSwgJmliLCBOVUxMLCAmZik7DQo+ICAgCWlmIChyKQ0KPiAgIAkJZ290byBlcnIxOw0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
