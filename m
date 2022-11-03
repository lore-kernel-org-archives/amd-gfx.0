Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E52C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 15:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B179610E2A9;
	Thu,  3 Nov 2022 15:12:17 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EDA510E2A9
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 15:12:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnzJj7gh5qN5IEWAvue1CiFq67klu5xvieZCNG8yIob87YDn1DmvBzb/MNp/QItMpg0mym9DI7KMtHBR9wO3D0P+VyBNaVDyobi8E3QJ91THwBhfxKT/1GPEfjiEdkfvAaKwdLt9xQHm+RK8UDC1bmo/s1OHbXJ6Br7febCQDfJ8gEAcOVtRdY6sNvOph0VRn9okC7um231KWS0vCaFt/YZDOyrO9Ibmw873CI0lrgJnReZ/EdSfcxTqlgNu2n4nZxuay5UZxZ0YX2HR7HJoPKEW93yV5fRLHqw8lqEsnBJFzUNz1UfDpXG93TNamRdqOlFlPx7oowoF5NxvU9kXvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIN33sxh2vSHt1ypUh5HolVGUDNyWCcoch72xscffWk=;
 b=L3tpqV288RY/HqcWO8BHSWFtG2wJr2A9nfdTBBjr8g6iLso1580+F/94Se2/7P2Wx6CzhrtLILZGCwrn1NP+7jVTJF5KoJPgy5VhmXqu8eOBXTjhS1H5jtx6DLQIY/QtzmEvIeDK5JpSr+sMcDtIlSMT2zjEaFmPWXy27q7gazf7eBNzuloXTXA8di7s8S1tLgn+D5bMdEpX8hsfaYf9Kd3ShYY3Q0R3nLJhCxx2UZJe8ZOt301NmYNsonc9IWU6zPjIbD2GxVC0RWjONMmIaT498qxq+mkA8B9UwqtnRCK1Yu+AlwOlBlCTerr63WbkW3aOu5EWM+87kSWMPaF1Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIN33sxh2vSHt1ypUh5HolVGUDNyWCcoch72xscffWk=;
 b=5fmOaWaaibIEfLgQpBfU8tHgVnSfmylYCSUd6KuoR/7THr2/fw+9ySOucjoHrx3cT5ZV19zx8+sMfwXZJpp+UK4OFVjgiGIbM6aaJW5Pvg50SMuVjpvLTHA9Z/2jpjZSNTUK9o5jOnIayLi2W6QpUAngFAWdEb0PcczJ7jJEoQA=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by DM6PR12MB4500.namprd12.prod.outlook.com (2603:10b6:5:28f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 15:12:12 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::3bf0:6f5b:fe42:4149]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::3bf0:6f5b:fe42:4149%5]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 15:12:12 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH v3 3/3] drm/amdgpu: remove the DID of Vangogh from
 pciidlist
Thread-Topic: [PATCH v3 3/3] drm/amdgpu: remove the DID of Vangogh from
 pciidlist
Thread-Index: AQHY70zux7noSmTCp0ivefPliGJR2K4tLdqAgAAfDwA=
Date: Thu, 3 Nov 2022 15:12:12 +0000
Message-ID: <DM4PR12MB5278F7A57EE5C325251E95969C389@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221103062056.2162715-1-Perry.Yuan@amd.com>
 <20221103062056.2162715-3-Perry.Yuan@amd.com>
 <CADnq5_PhdXH90vo01f8zbGnwzQzy-tBtJn_+J9eO+HXO-vsChA@mail.gmail.com>
In-Reply-To: <CADnq5_PhdXH90vo01f8zbGnwzQzy-tBtJn_+J9eO+HXO-vsChA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-03T15:12:09Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b5b0ab6d-ca0c-4f46-8b5f-34e00f0fde68;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-11-03T15:12:09Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: d1ebab35-c99a-4b10-99cb-14ad059b387a
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|DM6PR12MB4500:EE_
x-ms-office365-filtering-correlation-id: d734215e-9337-4a9d-af50-08dabdadc8bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MUH+xgQtradHEJgH7Fz5uFTdpYozDP+S2fTlwxgTit49dSxb5cKpifJrOhv6NP87t5rejtS3RKWPb0ebih2wkVdjHqI9jrhnuCUl9TI5zjLRsrcMzTF+lbz7A2T3rBabUW+1fASuXEFyt0lmCM0MYFX1N6hYqhangog2BWWR3DjnC+jFNknSjAuc5IgOZAre/TCvcwEr/xaJY53MsibwuEVS/VPKdiUq21ewIg1O9jTKwh3kC+PlBRFpI5+Rt5fLSY85S7nB0gpwNvIFqsD0VQacNIiHxHA9dOU2zXer/oZPO3Mb7gp9QYhFjA2wrFQgkK1fWbyHYjBvFT42g4NCZdFZk3E35kqLMf6jhBOPeJ35SfuKoyIRyimUlcGDQJ80FeeXoUFFydUZaquHrXLsn7itExHX4GhADDbU7SFq/LJHpEAiiL2BZ0TxEDGGVXnQ2eOD+thcNovGZuCExTML5ioZ3bMDGDnWRIkAGh0kS2EWu/o6fNhkRBJtEaaY8iRRkL6C/xbAgTfu088XyOZa9yRDAURRMCz99rtdYjuCVjwkvXW9cV5nbwlX5ktQq3fDnOEcWLO9n+a5JKG9trQUj/1s2Niw9tTS8Yxf0uyHN765MkptU4XZ0UoTtZVRyPhNFtcWv2RvPSxSy1cl/hDkWGCpI+3DnTLJWaN7VQFbVCQLqrMxFK+XWuPwp/XdzafG8I8WS4mIeV21PAivTm0BwPxZ4RwlKrq2egKv0T9pbdG9vZQH1fXe2q7rTdjcLlCjR367xtlSZ1KAh/yFjszEAA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5278.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199015)(66556008)(66946007)(8676002)(66476007)(66446008)(478600001)(4326008)(76116006)(64756008)(186003)(5660300002)(54906003)(38100700002)(316002)(2906002)(71200400001)(6916009)(122000001)(83380400001)(33656002)(38070700005)(41300700001)(53546011)(7696005)(6506007)(8936002)(86362001)(55016003)(52536014)(26005)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUE1LzNMZDlNaHN5V1d2WVpkYWdkZk9DZDQrc1UzMmpDQ2phZkR2T0JJa3A3?=
 =?utf-8?B?dUZiajNnS3g0bTFrcDNqTW11RWloZGN1YmpYYmdxUERHbzI5bzBURk95QWFi?=
 =?utf-8?B?YmJ1K3pTMHhUaHYzc1dxREw2Y1kzQXREM1ArSVYyVWwzMmd4SVBqaDZtbktI?=
 =?utf-8?B?cVU4ZDBxSCtPWGt2d1owT2tKdjI4YkZZV0hrY2tSMlNNajZTVFFiSWQ1cG1l?=
 =?utf-8?B?UE9nK0RhTE1SWEhtZTRpU1hNZnZyaHlYWHYrU3dtN0NMMlRqR3RuVllaTHc1?=
 =?utf-8?B?d0hHQlpad0NMN3ZYUzZmc1B4b0J1MlBVRFZiNFlFOHcza242a2R0WGJ5cVVy?=
 =?utf-8?B?bU5FbzlMVS9oVWR4RFcvYXowNmlodjRZS2U0dEZjbEFmQUZKdkpWTzl3Y0tH?=
 =?utf-8?B?RnhWQXFyWFVDV1RMcTNEckNVeFFoV3N2d0crL3BsMDNFRG9NOGsvMm1DTFRM?=
 =?utf-8?B?MktENFFBQjlwdGora3lXWVBWeEp4WUQ2ckxMeG1CejdpN2tUcW1sdUNkaUhS?=
 =?utf-8?B?SFRBZWNUMlFtTGtVTnY3aHRUSFRKV2JGd0hlRGUweEtabm9KK2FOVERPUXNQ?=
 =?utf-8?B?NmwrMklEb0RBMUVSVVAyc2xkWlZMRElzK3FwbmdJQWYxbVBoNEpsU08wR2NM?=
 =?utf-8?B?M3R4SHpRNGJVV2ZLeXBhblBVZmMrK091TnFxYTNVU2gyL3VTY2pPWEJWUndN?=
 =?utf-8?B?K2dUaUtkOU5Oem5oRVF6cVBHWUdENXppNjVIbGoyUUwxc0V1ZXI4bzdnUExN?=
 =?utf-8?B?cU4rTUxkdGtxVmhmbCtNcVViOUlsc0VOYnVoUnZVRC9jSEtVd3Q1aHZ0WnQr?=
 =?utf-8?B?QkZGWURTemF3dHRmUWpJNVFmcVRjZnhNaVNRSTZqblkvaWRRMVFyNDBWZjRL?=
 =?utf-8?B?bHdLWG52clFCZzNSRFREaWwzYXZ3M0JYMjNnTEFCUGRrZGpjdlh5UGh1KzBK?=
 =?utf-8?B?OFBDVm0vaXVrRkJwS1ZrMzJqcXhHUWU2ZWRQYXlEdjIyOGk3ZEpXdW5nQmpz?=
 =?utf-8?B?STlORFg3WGx1ZFBvZ2JqbVI5MHNwVERReklaaFduMG1GMzVrQnhLQlNUc1gw?=
 =?utf-8?B?V09kc3l4NUR4bnBvWCt4WWdQZ0pXRTlDcW13Yjlib2NEdXR0VjJpTUVwbm5x?=
 =?utf-8?B?TCszbWZlNHEvcHE2WXMxa0xKUWJlUllQYkd5bUFRc3p1TWZSeUVMTTZQQlhi?=
 =?utf-8?B?NjA1bWZCaTEyL29XWm15aTZJc0xKQmRmZHZ6Y0YwcWVseGtHMmlkOTJiZ1FU?=
 =?utf-8?B?Z3k0WlFsT0pyUWUwK1Iwdi9IRHhTa1Vjb2FpT2hGM3J0QTB0cG5tanliUG5G?=
 =?utf-8?B?OXR5UjBQMWF0dldsa3cvejdKeUt0RlRsZ25OcTVOMm8rUjRudUlTZ1ZTMkRJ?=
 =?utf-8?B?ZE10eFFYaG91Y002Tm0wYzZ6TFdSNTlBR0VpSG8yZHlXYis2eENWK09nNE1j?=
 =?utf-8?B?ZVdmKzFyS2ROZjMwcHc0VnJFLzhMc2RlcWt3WWFRVlcyZ2xqaXl6aFRTeVNj?=
 =?utf-8?B?Z045aVFOODlsMDE2YTNjNVJtOGR4ZnRkVVdlNFlHWGtPamFuUHhOOTEwVlh2?=
 =?utf-8?B?S1dqaFp2enFhQ3FEaFdGQWhMenBTajdhaDlKcDBtMGhsZHBBQ2xmdmNVemdL?=
 =?utf-8?B?dFF2SXoya24xZ2FvWmIvS0JkVVkxSUptaGYvdTc3VDUrL00xNUVYUzVlTmY5?=
 =?utf-8?B?djZIZXRIMmV1emxSckhqem5RNDdLdWpXTlJGK21yTWxrMzc4Z0JMTzRpbE52?=
 =?utf-8?B?RGF5MHk0Q2hacWgyTHdMWXBvdHZNTjhrVUVrUnVvbUU0L1RiM3RPUFdiUkpY?=
 =?utf-8?B?UjE3ZVNzcGltdVhOY1U4THVMUXRBN2J1ZkVYVHZIczlRZ1dUampYL3pkUVZi?=
 =?utf-8?B?WlJoQ0VPRitDOHNEV0ZyUG1aOUNuL0JNYk9LRjFwaFZ2NjdoTmNvZ3hNVlpY?=
 =?utf-8?B?cml0VkdmOURqM3dUODFBS1N0M2FBTDRwUjhRRDV1TUQ1Mmd4SXVzaWVTZHhR?=
 =?utf-8?B?WWp5a3dEL1JvdHJ6aGNHdXZrcnQ3NjN5S09BYU5jd0xBakFYbUdZYzFCQ2lh?=
 =?utf-8?B?R00rdm5zbzVVNFVqZXRxWi90emw0ZjJpb1ZoYTVSZ1lONHlydi9vWHdVelA5?=
 =?utf-8?Q?A0UU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d734215e-9337-4a9d-af50-08dabdadc8bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 15:12:12.0875 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /3i7M7IAw78F892Ao/Zm/fy8OrrCKQ8uSleFtSkW3z23lPgyoITDhWPgtrBuJR/TrA/dtx994yei4Bpq427UJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4500
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Huang,
 Shimmer" <Shimmer.Huang@amd.com>, "Liang,
 Richard qi" <Richardqi.Liang@amd.com>, "Liu, Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEFsZXguIA0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJA
Z21haWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMywgMjAyMiA5OjE1IFBNDQo+
IFRvOiBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPg0KPiBDYzogRGV1Y2hlciwgQWxl
eGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgTGlhbmcsIFJpY2hhcmQgcWkNCj4g
PFJpY2hhcmRxaS5MaWFuZ0BhbWQuY29tPjsgSHVhbmcsIFNoaW1tZXINCj4gPFNoaW1tZXIuSHVh
bmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBMaXUsIEt1bg0KPiA8
S3VuLkxpdTJAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAzLzNdIGRybS9hbWRn
cHU6IHJlbW92ZSB0aGUgRElEIG9mIFZhbmdvZ2ggZnJvbQ0KPiBwY2lpZGxpc3QNCj4gDQo+IENh
dXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBV
c2UgcHJvcGVyDQo+IGNhdXRpb24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBs
aW5rcywgb3IgcmVzcG9uZGluZy4NCj4gDQo+IA0KPiBPbiBUaHUsIE5vdiAzLCAyMDIyIGF0IDI6
MjQgQU0gUGVycnkgWXVhbiA8UGVycnkuWXVhbkBhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IGNo
YW5nZSB0aGUgdmFuZ29naCBmYW1pbHkgdG8gdXNlIElQIGRpc2NvdmVyeSBwYXRoIHRvIGluaXRp
YWxpemUgSVANCj4gPiBsaXN0LCB0aGlzIG5lZWRzIHRvIHJlbW92ZSB0aGUgRElEIGZyb20gdGhl
IFBDSSBJRCBsaXN0IHRvIGFsbG93IHRoZQ0KPiA+IElQIGRpc2NvdmVyeSBwYXRoIHRvIHNldCBh
bGwgdGhlIElQIHZlcnNpb25zIGNvcnJlY3RseS4NCj4gDQo+IEFzIGEgZm9sbG93IHVwIHBhdGNo
LCBpdCBtYXkgbWFrZSBzZW5zZSB0byByZW1vdmUgQ0hJUF9WQU5HT0dIIGVudGlyZWx5DQo+IHNv
IG5vIG9uZSBhY2NpZGVudGFsbHkgdHJpZXMgdG8gdXNlIGl0Lg0KPiANCj4gQWxleA0KDQpTdXJl
LCBJIHdpbGwgY3JlYXRlIHNvbWUgZm9sbG93aW5nIHBhdGNoZXMgdG8gcmVtb3ZlIHRoZSBDSElQ
X1ZBTkdPR0ggcmVsZXZhbnQgY29kZS4gDQoNClBlcnJ5LiANCg0KPiANCj4gDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBQZXJyeSBZdWFuIDxQZXJyeS5ZdWFuQGFtZC5jb20+DQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyB8IDMgLS0tDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiA+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+ID4gaW5kZXggNDI5ZmNkZjI4ODM2Li45YzMy
MzQwNWUzYmIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2Rydi5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ry
di5jDQo+ID4gQEAgLTE5MDksOSArMTkwOSw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2Rl
dmljZV9pZCBwY2lpZGxpc3RbXSA9IHsNCj4gPiAgICAgICAgIHsweDEwMDIsIDB4NzNBRiwgUENJ
X0FOWV9JRCwgUENJX0FOWV9JRCwgMCwgMCwNCj4gQ0hJUF9TSUVOTkFfQ0lDSExJRH0sDQo+ID4g
ICAgICAgICB7MHgxMDAyLCAweDczQkYsIFBDSV9BTllfSUQsIFBDSV9BTllfSUQsIDAsIDAsDQo+
ID4gQ0hJUF9TSUVOTkFfQ0lDSExJRH0sDQo+ID4NCj4gPiAtICAgICAgIC8qIFZhbiBHb2doICov
DQo+ID4gLSAgICAgICB7MHgxMDAyLCAweDE2M0YsIFBDSV9BTllfSUQsIFBDSV9BTllfSUQsIDAs
IDAsDQo+IENISVBfVkFOR09HSHxBTURfSVNfQVBVfSwNCj4gPiAtDQo+ID4gICAgICAgICAvKiBZ
ZWxsb3cgQ2FycCAqLw0KPiA+ICAgICAgICAgezB4MTAwMiwgMHgxNjRELCBQQ0lfQU5ZX0lELCBQ
Q0lfQU5ZX0lELCAwLCAwLA0KPiBDSElQX1lFTExPV19DQVJQfEFNRF9JU19BUFV9LA0KPiA+ICAg
ICAgICAgezB4MTAwMiwgMHgxNjgxLCBQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAwLA0KPiA+
IENISVBfWUVMTE9XX0NBUlB8QU1EX0lTX0FQVX0sDQo+ID4gLS0NCj4gPiAyLjM0LjENCj4gPg0K
