Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2516C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 03:56:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 625A461412
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 03:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625A461412
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 203196E456;
	Fri, 30 Apr 2021 03:56:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC3876E455
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 03:55:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fe0mwOFLEb+Rh6FbZY0w0HNpYiF5hUM6A60kcxJBJ7Youjzu+aB5KRdPGViOuO3U4uBtDdckhSr11I6UFn5oIKpl5TpD9/CNGvDRCwj7DfMVB79Ohit2lROX/Rv2V0+jTg6TZ8oY+Sg/6M8XV0pvzMCme9sTNyfqoL8AhxaWRMzrdTgmvNcZseYJLunXM4F6estb0UTFJOQhx4puFW7SZR5hwpmf/lztmGqRhHrQDlA8MbWOu/75KRF06KlF9tCVwXM/a2S4JMLXdsND47LMOVHS5GB8rxYm2FFIOW6EgyprXeDHVL9pteKmGOXqosAv2OYM5J6bPYXAqZ1qMjqkpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sr+dnBHxV6PuXnFOqLpwRXetCB8BfyOIWwxy/S0tBTw=;
 b=aLTlIb+OPsVh9LfWlfKNTFsVu8WnacqK/IOwbgIMtJtq6MRpxjOmSlAp/nOiuXRyiA6s/gO345QegYDheT+v+AGrspAoQ9ZLVscVdzA5UWthZ/7tqDSg55J4dnG7cOdRhUNHYZmpXHYiclE+7hfRNefLhxtkMOPU9oe4k9xNmT36e2sn6115QXwCnhyIPnQUN7ugE3Otrx7ZM4x6pP3c6GlYqeI8AHrfFXw3fxML4nLnh5symQFW6rwR3UDL16vtJ5rGJrCDFNnnQDEjCx9U4v1tuUn0dtHnnpQGFrph9cMWUIaYrIlgMVyC2f9vIgh0kXMZY/TLangpWobk655bwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sr+dnBHxV6PuXnFOqLpwRXetCB8BfyOIWwxy/S0tBTw=;
 b=FGuLtI9bsvgVUD7ZBcMVijSar9tF4IcsQDcsOZ61uLLE9nutIu0NcUAjOkIB7EyxqvS8YjsfgiyHehjlJEz/blusLNsTMmNhRb9eyWWKaX0Wf3oHvD/F7LrTO7yGTRExCBgBdRfHGUYaCG7tzq6XP/DVWDhD1EqZT+CQSv0qm4g=
Received: from DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) by
 DM8PR12MB5397.namprd12.prod.outlook.com (2603:10b6:8:38::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.21; Fri, 30 Apr 2021 03:55:56 +0000
Received: from DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::4172:11d4:b0d7:63d6]) by DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::4172:11d4:b0d7:63d6%6]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 03:55:56 +0000
From: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 12/12] drm/amdgpu: Refine the error report when flush
 tlb.
Thread-Topic: [PATCH v2 12/12] drm/amdgpu: Refine the error report when flush
 tlb.
Thread-Index: AQHXPOI9804nj/Kqf0iF+u51YMgICarLW+kAgAEThYA=
Date: Fri, 30 Apr 2021 03:55:56 +0000
Message-ID: <DM8PR12MB547899AE02DCE1DBA3C58BB8F85E9@DM8PR12MB5478.namprd12.prod.outlook.com>
References: <20210429102644.31172-1-PengJu.Zhou@amd.com>
 <20210429102644.31172-12-PengJu.Zhou@amd.com>
 <ec0ac02e-565d-39f4-ea91-f4f59e8efbb7@gmail.com>
In-Reply-To: <ec0ac02e-565d-39f4-ea91-f4f59e8efbb7@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-30T03:55:46Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=318909fc-b3ef-447f-b0e2-999c03419b53;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: drm-next  
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5998b7a7-8213-4adc-ce7f-08d90b8bdba1
x-ms-traffictypediagnostic: DM8PR12MB5397:
x-microsoft-antispam-prvs: <DM8PR12MB539712DCABD9CDF8623532DBF85E9@DM8PR12MB5397.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2hOt4DKlXLOx9Qz1ZwF4KD8zyYR4QYC7DQMCd7yia6vzr0qehkMqRozZ9y6Xw4WDfZuY1x3UgSBD/uaagYMbGUkZWFu5+AN7xkCOZqTzBNy43ctXVHsZGslD6F4XRoYtcwo4HlxCjZ3SWD+n0RTQ6atZg2pymA/cS5x6qjpbPIuvWMFNjAjOfWAMFctyACChAkHTovAR7FaTCPsIHsmdCz57j4aPYRAUs33U4Fjh7KL5TMXaLU1ULMGFwFq2seBTRAXIP0QN6/q4r3EDfJZtL5y134HaRpIbAM1Hpb6/ot94x/YYIN4JmfXeEZEDXTOr5bqV5zbw3gQmIe8vrbJ/AR9zKnRnnV72VAhaajk0s6YZYuoFgVDq+kQ1FBwFWHySWPtejLFVxDAS4HMAJ7SQgP2NDDsxDXV2dlRQVG4gH3wOinXmSKCHAQ4wZ0pjwodndLs4x+oJ4WTYMmhAFYBwPBd9enAOnpYFHx5SDVBw/CqEtKErdQf2mTJ7G+k+TKJZtPrnFkCt44AGIYpQQZX9CsnDDG5P/yQDg1DmAPltC+0x9diL3bDcFVnHed3I66LOvdllbXd5+IEp2XsKFPV8SMWPWcdCdXQLNIYVH/laMeE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5478.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(76116006)(66946007)(9686003)(66476007)(66556008)(478600001)(55016002)(64756008)(5660300002)(66446008)(66574015)(110136005)(186003)(8676002)(8936002)(316002)(71200400001)(53546011)(38100700002)(33656002)(26005)(6506007)(86362001)(122000001)(2906002)(83380400001)(7696005)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?bmpGOGZGSHdMR01hUVlOa2ZCNS84aGZ0TzhiZDlXNTJqdkg5RmlzcEdvN216?=
 =?utf-8?B?S2NwdTNlRGZ2UXd0RjZsUFdWUE0wR1QxTDN4amxkV1RqelIwb2MrTmNhNEk4?=
 =?utf-8?B?WVZSY3JJOFY4UzR3cEpPRU1pRHRtM2NuVFV0YTluejF2d0w4TnQvbUlIVmVs?=
 =?utf-8?B?TGphMzJta0RTcWRXRWc4eXJWNUp5UUNtbFg0Mnl0MnN4RGk5UHQ5ZVhDeWNH?=
 =?utf-8?B?eDFZRlA5Rk12cHFRTytuWWcvZVFVMXhyZlNRUFh6elBiS3FnckN1YUNIWTRC?=
 =?utf-8?B?SzU1Z0R6UUFmdG1qRmptTzdvZlJHNjBVSkV6dTZyVkVYaUd6RWd4c1ZrWmd1?=
 =?utf-8?B?K3JJN0x1YWorQTVyLzIrbW9vTHozNi80QjRReFBjUWNzaW5MLzFPQzc0NWMw?=
 =?utf-8?B?MGZMNDFvakJYcy9Bc2hoSzY0c2x2L1F5TE02UDd1YzFDa1BHbzVyTzdYZFRt?=
 =?utf-8?B?bDgvUEFML3R5QXkyMU9oelNyeVNiTFh5UVkrSzdEOS8xOW91VmlUV0FxZEpv?=
 =?utf-8?B?T3N0YVkvcmIrNXc3NVZLK2NsOXQ0dEo0bHI2T0VwNHB4NjdMa2E1UURUbGEr?=
 =?utf-8?B?V29haUZmN3FhVnk2QUI2Q3dDUmpuWE9LMVdLTUFDYkxmbDhSck1xTmhDWHMw?=
 =?utf-8?B?R2c4amVIWVh3dzNtbWo0d1hjR1FwV3VJb2k4VnUrbmNvZ3NzM2tBdVNVTFRO?=
 =?utf-8?B?VzZQN1BTclFqS2xIZERDT21xUkZZUDVrQWxUL0p2cGVhUjRDUmlWS0JNN0Y3?=
 =?utf-8?B?RzVCaXltR1ZRdGFuSDdBdWMrS3FkZE9LL0diM0pENjhqZHlmYlVtemFnY1hK?=
 =?utf-8?B?eUFncjV0Wjdlc1VEZERib21ZMTVqOXpqNnB3Mks3ZFNCNjZvWHVhZUI0Z2Z3?=
 =?utf-8?B?RmlDMkVlcWdIQllQZ3RqL3VoajJqK01IOFpERFVKNjNSeHd0TW9iVnBTMnRy?=
 =?utf-8?B?T253TmllNy83UjFnejhFZGVBTXJsS3V0MXpqV2U3TmE2RzRFMXh6VTVKZW4r?=
 =?utf-8?B?dzdKRE11ZkJtRVZDR1pYZFR4NjB2Wm0wK05HSUlpNWgwRFc4QTc4WnM1eFdY?=
 =?utf-8?B?R2FiV3ljL1NJQklHeC9CT3lVN1VvSzRwRko4RVNyOEMvOFpOa1RabVhCS0ZC?=
 =?utf-8?B?MUYxTDVMcVdyQUFzUk9wWmZkRU1uUW1yTElBWi9GbzFaSnRMVUEySEplWkxC?=
 =?utf-8?B?RUZBaWRZMXdxeFVVWGNKM0RJdUJiZGQreUIzdW9mWnVTQlZpdk01bnFBVHBu?=
 =?utf-8?B?UFpqQ3lkUW44UFVrRm5pSVhEQll2S2NUalEzVkc4d1VVa1FXMGRxWU9wVnBp?=
 =?utf-8?B?YVJsNkxNWVFkTzlDbUhwVHplZlpWNFBLMW1nK3orK1BMVUExTFUwejNVcmh5?=
 =?utf-8?B?eTQwMUduUjVQdjhyTnpMTG1HajNVZ0RCMkJsUGV2dFJrek5mR3FyV0FCdXcw?=
 =?utf-8?B?ZVZEa3JXVFFEL1lqZlV3akVCUEp3cU8yditvelBjcHhLL1Yza3N4SkdXSVps?=
 =?utf-8?B?Y0VJWEtsRm4xK3k3Z1RnS2swYTVXUy9IS0FUNmpsN3R4T05mRGhVTzF5M2o3?=
 =?utf-8?B?V3BXWWpyQ3g5Wm50anFYZ3FPdDg2dlMvZHIyR2lqZkVWRXlkaEpSYXFVc2w3?=
 =?utf-8?B?TytpNWs4eVR4N2xJUG5kY1N5dFFvajRRT0ZPUDBPL1NLNW14V2lzYXlibGRz?=
 =?utf-8?B?bWZtM3VubDZMazRFWWtMdGFIbVZTVzZMVkkxT3dVUTBjUHdTdXV2bWJpdm5N?=
 =?utf-8?Q?NC4HAoHnPvnE4/0A2JjrgY+5zZcTTIDQ7q+Nl5R?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5998b7a7-8213-4adc-ce7f-08d90b8bdba1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2021 03:55:56.1097 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bLNDMT0TKRTpvTB4vkCpLql24LLKAiBmAmST6wAvwvM3iesdP66lMnm/gJfG14SnesgQOHXoiLSMVumykc+sWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5397
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpI
aSBDaHJpc3RpYW4NClRoYW5rcyBmb3IgeW91ciByZXZpZXcsIEkgd2lsbCBjaGFuZ2UgaXQuDQoN
Cg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLSANCkJXDQpQZW5nanUgWmhvdQ0KDQoNCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1
bWVya2VuQGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDI5LCAyMDIxIDc6Mjkg
UE0NCj4gVG86IFpob3UsIFBlbmcgSnUgPFBlbmdKdS5aaG91QGFtZC5jb20+OyBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEyLzEyXSBkcm0v
YW1kZ3B1OiBSZWZpbmUgdGhlIGVycm9yIHJlcG9ydCB3aGVuDQo+IGZsdXNoIHRsYi4NCj4gDQo+
IEFtIDI5LjA0LjIxIHVtIDEyOjI2IHNjaHJpZWIgUGVuZyBKdSBaaG91Og0KPiA+IHRoZXJlIGFy
ZSAyIGh1YnMgdG8gZmx1c2ggaW4gdGhlIGdtYywgdG8gbWFrZSBpdCBlYXNpZXIgdG8gZGVidWcg
d2hlbg0KPiA+IGh1YiBmbHVzaCBmYWlsZWQsIHJlZmluZSB0aGUgbG9ncy4NCj4gDQo+IE5BSywg
d2UgY2FuIGhhdmUgbW9yZSB0aGFuIGp1c3QgdGhlIHR3byBodWJzLg0KPiANCj4gU2VlIGdtY192
OV8wX3Byb2Nlc3NfaW50ZXJydXB0Og0KPiANCj4gIMKgwqDCoMKgwqDCoMKgIGlmIChlbnRyeS0+
Y2xpZW50X2lkID09IFNPQzE1X0lIX0NMSUVOVElEX1ZNQykgew0KPiAgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGh1Yl9uYW1lID0gIm1taHViMCI7DQo+ICDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaHViID0gJmFkZXYtPnZtaHViW0FNREdQVV9NTUhVQl8wXTsNCj4gIMKg
wqDCoMKgwqDCoMKgIH0gZWxzZSBpZiAoZW50cnktPmNsaWVudF9pZCA9PSBTT0MxNV9JSF9DTElF
TlRJRF9WTUMxKSB7DQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaHViX25hbWUg
PSAibW1odWIxIjsNCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBodWIgPSAmYWRl
di0+dm1odWJbQU1ER1BVX01NSFVCXzFdOw0KPiAgwqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsNCj4g
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBodWJfbmFtZSA9ICJnZnhodWIwIjsNCj4g
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBodWIgPSAmYWRldi0+dm1odWJbQU1ER1BV
X0dGWEhVQl8wXTsNCj4gIMKgwqDCoMKgwqDCoMKgIH0NCj4gDQo+IE1heWJlIHB1dCB0aGUgbmFt
ZSBpbnRvIHRoZSBodWIgc3RydWN0dXJlIGFzIHdlbGwuDQo+IA0KPiBDaHJpc3RpYW4uDQo+IA0K
PiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgSnUgWmhvdSA8UGVuZ0p1Llpob3VAYW1k
LmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBf
MC5jIHwgMyArKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nbWNfdjEwXzAuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8w
LmMNCj4gPiBpbmRleCBjMjU1NDExMTI2NjMuLjMzY2Q0ODc3NDFmNyAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jDQo+ID4gQEAgLTI5Nyw3ICsyOTcsOCBA
QCBzdGF0aWMgdm9pZCBnbWNfdjEwXzBfZmx1c2hfdm1faHViKHN0cnVjdA0KPiBhbWRncHVfZGV2
aWNlICphZGV2LCB1aW50MzJfdCB2bWlkLA0KPiA+ICAgCWlmIChpIDwgYWRldi0+dXNlY190aW1l
b3V0KQ0KPiA+ICAgCQlyZXR1cm47DQo+ID4NCj4gPiAtCURSTV9FUlJPUigiVGltZW91dCB3YWl0
aW5nIGZvciBWTSBmbHVzaCBBQ0shXG4iKTsNCj4gPiArCURSTV9FUlJPUigiVGltZW91dCB3YWl0
aW5nIGZvciBWTSBmbHVzaCBodWI6ICVzIVxuIiwNCj4gPiArCQkgIHZtaHViID09IEFNREdQVV9H
RlhIVUJfMCA/ICJnZnhodWIiIDogIm1taHViIik7DQo+ID4gICB9DQo+ID4NCj4gPiAgIC8qKg0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
