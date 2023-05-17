Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C005AC77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 12:56:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CEEE10E410;
	Wed, 17 May 2023 12:56:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07D4210E410
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 12:56:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjTviOLWtvpAaM+4HY+HTQbDyuMW0pSdeXpmP64OA9Qcpk5fRZCtVKuCliNw3zfXPxx017HWIbd6moPuQGN0u8Fo0PBYrjGQzmWL1Qej0ekLcSBOQD47wiuQ/tIktzOotkZ2JYGQ1scXiZBx+DQQkiSDgcXy45yFhFX0Y0zAcvjCPbtjm2PAUUi9yM+OZb6lkNFVf9lDlk3bm7gVq0EAVoEGl5FJAoKYSRI+hEt4bl8a0RbBO09CwOQFmHGTaxrurhEU9w0lLQ6XwR2yFTv7G1pSY+lSklYiWi+gFkw06g6tnhdBXSlXSbW3a2SDk2cqKA5fQ89AMUGjeTF3xjgbrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iossgm+qapIfsQlUp9WSk04rGfN765b6/caGiqkKfFo=;
 b=WYaGBddO1ysAMUWlt8PN9m1V8b8mRSSeesyEV2Cl47GzkXJ55IidVtdxxGKdt38rVZoKxfWX6Yho//2IqI15+GKkeJx8gHhpX8u4AXhLI/4ajC3IW0wSJFS9lH24KhK5s7baTZhTMR5w4NsSx/ZP4oaUks0aoJpg6udxD0U0VoAvrVPkdqf9CIudSkF0QHDX02tR+eUTAFzakXdbm0IRzJI0RmrzJQOxHbQwXdFd1sOKrDb6PBebLk6+6cH3kFTH/1hOgpLNFNiR4aKuffne/+33dW3BmRJvDKgB0XvMG+uLQ9Q5siz5JKpaDf5hM5E5zFFUJMZV5GgMfUWcP/U4uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iossgm+qapIfsQlUp9WSk04rGfN765b6/caGiqkKfFo=;
 b=eqSQZ8grqVn+1piyGONY3XBre9OFQti6QniQ2kjzfnwbDAcwkjc1REvoDFIn5UMR5VZzgJdi4AxDXEoB5w3Cd0exu/EeEpLqxkhJtGhCcUmMR1x5jXsn1qDrc54Nfwzq6DYP4ymWH+PqWf3YJVgiaYV0EXTdHfShHN1XoSI8bTA=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 12:56:23 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2%4]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 12:56:23 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix warnings in amdgpu _object, _ring.c
Thread-Topic: [PATCH] drm/amd/amdgpu: Fix warnings in amdgpu _object, _ring.c
Thread-Index: AQHZgn8HIUhn4ZiHLU2+ned/259ueq9eeMQA
Date: Wed, 17 May 2023 12:56:23 +0000
Message-ID: <BL1PR12MB5144A295696D23D1195FA8D1F77E9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230509140307.1369211-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230509140307.1369211-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-17T12:56:22Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=27fa603b-b179-4ba9-ae92-4b14efebc236;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-05-17T12:56:22Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 50c62042-8bb2-4987-8e67-8146e1a1e0f8
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SN7PR12MB7836:EE_
x-ms-office365-filtering-correlation-id: c0e83f2e-4b8b-4878-94aa-08db56d61e84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pYIQUMf7DwYMDmyT8Zc3FPMQmPt6kr4Fm7FaRZM4hcnMnQNLgZBZ4HRRv1WXWtB3RxlLfs8Xq8rOacbuIg2DcS1w9Cijx3FGjcqC7fk2HbxcVMjOUQBgEOEFkCVv7rjleG+MRdDNaSmvzSCUFljDcIN4/H68dpK/FWndtBsub/aSFVXZC60IKcgX1JkYSYkvgEWtaEG/YCgJDcWhjRBnV/aniMtEmTHmh1n7eb6Pq440ylHs3BZc42aSW8ZYTN204w9g+Vq+yDBPNdfZvXvmP/VsEJ1OtSWxA3dRbNESV0IF4FfGduXVd/qeOHa92mIeUfMikwM2Lt0Bn761+gssBSfAgDWeU9/Qz+uSEkQOpnXSR9iheHBfIGZi/eL8hYrnH0TxjWPfyy7UIIaMU5x9pzostnYgtjOTfcOTx//DWLRWg5eThNqZZMCuG4rdSbtPZ2vDIiCEqufJ3dE2zc3g37leoNL4oLpPNyI+5XyLmE9EF69cWr3UWGyD97suUiJxzNqcUmx3/xHDighruUJNI/tkWjvhwOwYtMQLVwWYUB+POBkwPEZ/fWeXTZ2clDVGJ+AzzhuLC4/xf4Ni81TRjaunYI5xhpEmDIB+44aHAgFSV5V8xoPt/HR0In3gr9/K
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199021)(83380400001)(66574015)(478600001)(7696005)(71200400001)(110136005)(53546011)(9686003)(6506007)(26005)(186003)(2906002)(8936002)(8676002)(5660300002)(52536014)(6636002)(122000001)(33656002)(41300700001)(38100700002)(4326008)(66476007)(66556008)(66946007)(66446008)(64756008)(76116006)(86362001)(316002)(55016003)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekYrY1YxNlNJaUQzVkVYc285eEhSRmc2dHhkU0ZiYU53TzN4dHNFRHRjSlhQ?=
 =?utf-8?B?RmVrek1qY21oUkVwZ3JiYTNwNmNwSkZqTlc0Qkp1bWdWc2ZLMnNveW44TTYr?=
 =?utf-8?B?TzhwYUxhaHpmdU02TnVWcm5jQ0wvajVtL0RNNFBHQUZWcFVPaWZ3dzh4cDI0?=
 =?utf-8?B?TEdGeXFFTG1xYlpjQVVYSGFVL0xCOXRCYXhCY3A0Zkt6UDAxWEZKMkptWHp1?=
 =?utf-8?B?eTVLWm9jc09nbXhpRTU0Z3VJUG9jYnlJMTJmWFU4SFNKdGVmdStyeXFUVEE2?=
 =?utf-8?B?alEzb2xKQ3d1VVlZVEFPZjF2QnpNd2QwQVZWRW0vMjJybmUxL1J2QzVGR25s?=
 =?utf-8?B?Z2RHOFlrWEl0d0VYKzJDbFAvVXVyQ3BWd2NFelduSHFCb1BHanB1a0NiS3M2?=
 =?utf-8?B?QUZEOXNRRFljVlM4WVMyY0lnS1NFakloWTFnWXRBb3BUckJNb0ZMbEhTWFVS?=
 =?utf-8?B?V0h1RnR6QS9HS1JwSWNiZDRUbEhWejNER2xFTThmWXREZzRkOStkWWxhc3Ri?=
 =?utf-8?B?Q09vQnRYeXQrUElHUllpTFdrZ1JxciszUk9mUy8ySUdDMWJTWE1wQkZkaHRn?=
 =?utf-8?B?TGVwUlhKeUMxN20ycE5xL2pvQUdwLzcyM0JRNHBkdGxoaEQxekZTNDBpZzRW?=
 =?utf-8?B?Qm41TTlBU1Z2ZDZnenNJVkFCYUp6b3RwR3NRTkorZExrS3ROYjBQdGVaVXQr?=
 =?utf-8?B?akJQd2N1cE5aMEhNZHJaT2tXMVVPZGVKQ05uYUhuVjdZMmd4R1I4Y3l6TkUz?=
 =?utf-8?B?SjhpemxrMjBIQTl5SWRLaGdNREZMVWNpTTZGOHhIVkYzcXZoUDZ4VXN2RlZ4?=
 =?utf-8?B?b1lGVWtpRk5tMDRlWTBxWGpaL3RaUXN1Qk1LSUwvRUFHWGh5ZWhUZnoveG9I?=
 =?utf-8?B?VS94ZXRLMGNpdVpiWjAzcjh3c3hHWDJ3QS9YTW9LWVdjTTVEbTd3bjRyN1hu?=
 =?utf-8?B?ZVNia0pqRUUrRmR0Z3lCV0g5ZDhCb0VhZHNtSWJQbFdCNDZvSzN0NWdWY005?=
 =?utf-8?B?ZHlLbkVMS204Y013MlpIYUs5RmpOeWN2M3pxQVUzTDBoaGg2WEdVVSt3cFox?=
 =?utf-8?B?VUxWWXcvcDhDZXVXczVVM0EzY1ZoNGJLalVEMXlqZ0RRaXFseHlPNWMrL1hR?=
 =?utf-8?B?OUxpM2RTK2ZEeFcwQVZaUkF3bjJRWUlkYWozWm5kd2Vua3oxbnlPY0d5MDVI?=
 =?utf-8?B?ejUydHlkVGNKbUdvV0F6Y0d0OFB6N1hTa1djS29iWnZ0Sjh1cGNJTGRQYkdj?=
 =?utf-8?B?UlRQakpyK2RGRnQwMzl3UUd2YllEVDhTai9zS1FWZzQwRWRoQS9Vd0JIQk5N?=
 =?utf-8?B?cm1SeTQxT0lqMzZmYmg4QWtTZWhkZFYwQXdTcTdZamE4MmVYbUpwQkRPZEh0?=
 =?utf-8?B?ZWlSemtyVmxPNEFFN0VNWldmM0dXVGViT1BwcnYzbTZJV3g3WU4rMGhEMTlz?=
 =?utf-8?B?K2d2cVgra29KL0RBcE42cE5EM3N6VWxSYXArY3cxTVRkVlJyWHJ3d2c2K1Yr?=
 =?utf-8?B?Yk83T1l1RWpHeFVuMG14amJqWEdTZUlnOUJKNkIzUWNRS1ZWT0RLT3YzbTh0?=
 =?utf-8?B?dXRFdm5EbWN3VC91MS9JVkovakNUeUc3VGcvWGpYSkhrOTU3THZMRThCT2ty?=
 =?utf-8?B?MS9PSWhqYytmemNqcS9IWEpZeWJib2NQSmpDOGtvMmZoYWhUU05iMVhaY1hs?=
 =?utf-8?B?eVJ1TVpYMDJ1N2xnOW5ObitjNXhERjFzT2EwNlFGd2ZIcVZZaXV0L0VxWDVK?=
 =?utf-8?B?dC9qejZSM2c1MzdYVFlWeWRYYUIwWGtEOUcwV3ZIN1lJME9LNkEvZDQ3WVhV?=
 =?utf-8?B?ZXNYRnI1dkhrT3FsQ2xEQ1g3Q1l6cGFIUGdoRnQrUjFLK0VYQjR1eFVoUVFZ?=
 =?utf-8?B?YlNmaGNxQTI3ZEdqSm5MY2wyS1ZsNnJZKy90SmN2b3hrQVU4blpzTzUzK1F5?=
 =?utf-8?B?d053dytSVEJpVDYrYkxhRWM0Q2pNWWFkUXFUNVVvTXcyMHFJZlVxa2lsM0xN?=
 =?utf-8?B?YnNTRkxmdUpTWGxTNmtEWXNZdmExN21RYncra1g5NzhudTZwcm9qSytZd21E?=
 =?utf-8?B?bzgzb0dkMzFvNVFVV3Zpdm5JOXc0T1RGcjFqbVFPSXNoSU9jK0doT3hzejNh?=
 =?utf-8?Q?ezqA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e83f2e-4b8b-4878-94aa-08db56d61e84
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 12:56:23.7541 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hssUXSN7DVj7c7WLlrxa5UtR90vOSzoI311/ian2h7icsVjDPZoHkFFf9vlDpaKewUa8F3vNH7hCii/K4n2ptw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7836
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogU0hBTk1VR0FNLCBTUklOSVZBU0FODQo+IDxTUklOSVZBU0FOLlNI
QU5NVUdBTUBhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBNYXkgOSwgMjAyMyAxMDowMyBBTQ0K
PiBUbzogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERldWNo
ZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gQ2M6IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBTSEFOTVVHQU0sIFNSSU5JVkFTQU4NCj4gPFNSSU5J
VkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZC9hbWRn
cHU6IEZpeCB3YXJuaW5ncyBpbiBhbWRncHUgX29iamVjdCwgX3JpbmcuYw0KPiANCj4gRml4IGJl
bG93IHdhcm5pbmdzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6DQo+IA0KPiBXQVJOSU5HOiBQcmVm
ZXIgJ3Vuc2lnbmVkIGludCcgdG8gYmFyZSB1c2Ugb2YgJ3Vuc2lnbmVkJw0KPiBXQVJOSU5HOiBz
dGF0aWMgY29uc3QgY2hhciAqIGFycmF5IHNob3VsZCBwcm9iYWJseSBiZSBzdGF0aWMgY29uc3Qg
Y2hhciAqDQo+IGNvbnN0DQo+IFdBUk5JTkc6IHNwYWNlIHByb2hpYml0ZWQgYmV0d2VlbiBmdW5j
dGlvbiBuYW1lIGFuZCBvcGVuIHBhcmVudGhlc2lzDQo+ICcoJw0KPiBXQVJOSU5HOiBicmFjZXMg
e30gYXJlIG5vdCBuZWNlc3NhcnkgZm9yIHNpbmdsZSBzdGF0ZW1lbnQgYmxvY2tzDQo+IFdBUk5J
Tkc6IFN5bWJvbGljIHBlcm1pc3Npb25zICdTX0lSVUdPJyBhcmUgbm90IHByZWZlcnJlZC4gQ29u
c2lkZXINCj4gdXNpbmcgb2N0YWwgcGVybWlzc2lvbnMgJzA0NDQnLg0KPiANCj4gQ2M6IENocmlz
dGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gQ2M6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU3Jpbml2YXNh
biBTaGFubXVnYW0gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQoNClJldmlld2VkLWJ5
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQoNCj4gLS0tDQo+ICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgfCAxMCArKysrKy0tLS0t
DQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jICAgfCAgOSArKysr
LS0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
b2JqZWN0LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMN
Cj4gaW5kZXggN2M5Yjc4OGFlMGE5Li5mYmQ5MDZhYzU1NmUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMNCj4gQEAgLTEzMCw3ICsxMzAsNyBAQCB2
b2lkIGFtZGdwdV9ib19wbGFjZW1lbnRfZnJvbV9kb21haW4oc3RydWN0DQo+IGFtZGdwdV9ibyAq
YWJvLCB1MzIgZG9tYWluKQ0KPiAgCXUzMiBjID0gMDsNCj4gDQo+ICAJaWYgKGRvbWFpbiAmIEFN
REdQVV9HRU1fRE9NQUlOX1ZSQU0pIHsNCj4gLQkJdW5zaWduZWQgdmlzaWJsZV9wZm4gPSBhZGV2
LT5nbWMudmlzaWJsZV92cmFtX3NpemUgPj4NCj4gUEFHRV9TSElGVDsNCj4gKwkJdW5zaWduZWQg
aW50IHZpc2libGVfcGZuID0gYWRldi0+Z21jLnZpc2libGVfdnJhbV9zaXplID4+DQo+IFBBR0Vf
U0hJRlQ7DQo+IA0KPiAgCQlwbGFjZXNbY10uZnBmbiA9IDA7DQo+ICAJCXBsYWNlc1tjXS5scGZu
ID0gMDsNCj4gQEAgLTkzNSw3ICs5MzUsNyBAQCBpbnQgYW1kZ3B1X2JvX3Bpbl9yZXN0cmljdGVk
KHN0cnVjdCBhbWRncHVfYm8NCj4gKmJvLCB1MzIgZG9tYWluLA0KPiAgCQliby0+ZmxhZ3MgfD0N
Cj4gQU1ER1BVX0dFTV9DUkVBVEVfQ1BVX0FDQ0VTU19SRVFVSVJFRDsNCj4gIAlhbWRncHVfYm9f
cGxhY2VtZW50X2Zyb21fZG9tYWluKGJvLCBkb21haW4pOw0KPiAgCWZvciAoaSA9IDA7IGkgPCBi
by0+cGxhY2VtZW50Lm51bV9wbGFjZW1lbnQ7IGkrKykgew0KPiAtCQl1bnNpZ25lZCBmcGZuLCBs
cGZuOw0KPiArCQl1bnNpZ25lZCBpbnQgZnBmbiwgbHBmbjsNCj4gDQo+ICAJCWZwZm4gPSBtaW5f
b2Zmc2V0ID4+IFBBR0VfU0hJRlQ7DQo+ICAJCWxwZm4gPSBtYXhfb2Zmc2V0ID4+IFBBR0VfU0hJ
RlQ7DQo+IEBAIC0xMDE2LDcgKzEwMTYsNyBAQCB2b2lkIGFtZGdwdV9ib191bnBpbihzdHJ1Y3Qg
YW1kZ3B1X2JvICpibykNCj4gIAl9DQo+ICB9DQo+IA0KPiAtc3RhdGljIGNvbnN0IGNoYXIgKmFt
ZGdwdV92cmFtX25hbWVzW10gPSB7DQo+ICtzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IGFtZGdw
dV92cmFtX25hbWVzW10gPSB7DQo+ICAJIlVOS05PV04iLA0KPiAgCSJHRERSMSIsDQo+ICAJIkRE
UjIiLA0KPiBAQCAtMTE0OCw4ICsxMTQ4LDggQEAgdm9pZCBhbWRncHVfYm9fZ2V0X3RpbGluZ19m
bGFncyhzdHJ1Y3QNCj4gYW1kZ3B1X2JvICpibywgdTY0ICp0aWxpbmdfZmxhZ3MpDQo+ICAgKiBS
ZXR1cm5zOg0KPiAgICogMCBmb3Igc3VjY2VzcyBvciBhIG5lZ2F0aXZlIGVycm9yIGNvZGUgb24g
ZmFpbHVyZS4NCj4gICAqLw0KPiAtaW50IGFtZGdwdV9ib19zZXRfbWV0YWRhdGEgKHN0cnVjdCBh
bWRncHVfYm8gKmJvLCB2b2lkICptZXRhZGF0YSwNCj4gLQkJCSAgICB1aW50MzJfdCBtZXRhZGF0
YV9zaXplLCB1aW50NjRfdCBmbGFncykNCj4gK2ludCBhbWRncHVfYm9fc2V0X21ldGFkYXRhKHN0
cnVjdCBhbWRncHVfYm8gKmJvLCB2b2lkICptZXRhZGF0YSwNCj4gKwkJCSAgIHUzMiBtZXRhZGF0
YV9zaXplLCB1aW50NjRfdCBmbGFncykNCj4gIHsNCj4gIAlzdHJ1Y3QgYW1kZ3B1X2JvX3VzZXIg
KnVibzsNCj4gIAl2b2lkICpidWZmZXI7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcmluZy5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3JpbmcuYw0KPiBpbmRleCBhMWQ0ODBiN2ZkMWYuLjc0MjliMjAyNTdhNiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jDQo+IEBAIC03OCw3ICs3
OCw3IEBAIHVuc2lnbmVkIGludCBhbWRncHVfcmluZ19tYXhfaWJzKGVudW0NCj4gYW1kZ3B1X3Jp
bmdfdHlwZSB0eXBlKQ0KPiAgICogQWxsb2NhdGUgQG5kdyBkd29yZHMgaW4gdGhlIHJpbmcgYnVm
ZmVyIChhbGwgYXNpY3MpLg0KPiAgICogUmV0dXJucyAwIG9uIHN1Y2Nlc3MsIGVycm9yIG9uIGZh
aWx1cmUuDQo+ICAgKi8NCj4gLWludCBhbWRncHVfcmluZ19hbGxvYyhzdHJ1Y3QgYW1kZ3B1X3Jp
bmcgKnJpbmcsIHVuc2lnbmVkIG5kdykNCj4gK2ludCBhbWRncHVfcmluZ19hbGxvYyhzdHJ1Y3Qg
YW1kZ3B1X3JpbmcgKnJpbmcsIHVuc2lnbmVkIGludCBuZHcpDQo+ICB7DQo+ICAJLyogQWxpZ24g
cmVxdWVzdGVkIHNpemUgd2l0aCBwYWRkaW5nIHNvIHVubG9ja19jb21taXQgY2FuDQo+ICAJICog
cGFkIHNhZmVseSAqLw0KPiBAQCAtMzE1LDkgKzMxNSw4IEBAIGludCBhbWRncHVfcmluZ19pbml0
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiBzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcs
DQo+ICAJCSAgICAgYW1kZ3B1X3JpbmdfbWF4X2licyhyaW5nLT5mdW5jcy0+dHlwZSkgKiByaW5n
LT5mdW5jcy0NCj4gPmVtaXRfaWJfc2l6ZTsNCj4gIAltYXhfaWJzX2R3ID0gKG1heF9pYnNfZHcg
KyByaW5nLT5mdW5jcy0+YWxpZ25fbWFzaykgJiB+cmluZy0NCj4gPmZ1bmNzLT5hbGlnbl9tYXNr
Ow0KPiANCj4gLQlpZiAoV0FSTl9PTihtYXhfaWJzX2R3ID4gbWF4X2R3KSkgew0KPiArCWlmIChX
QVJOX09OKG1heF9pYnNfZHcgPiBtYXhfZHcpKQ0KPiAgCQltYXhfZHcgPSBtYXhfaWJzX2R3Ow0K
PiAtCX0NCj4gDQo+ICAJcmluZy0+cmluZ19zaXplID0gcm91bmR1cF9wb3dfb2ZfdHdvKG1heF9k
dyAqIDQgKg0KPiBzY2hlZF9od19zdWJtaXNzaW9uKTsNCj4gDQo+IEBAIC01OTEsNyArNTkwLDcg
QEAgdm9pZCBhbWRncHVfZGVidWdmc19yaW5nX2luaXQoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsDQo+ICAJY2hhciBuYW1lWzMyXTsNCj4gDQo+ICAJc3ByaW50ZihuYW1lLCAiYW1kZ3B1
X3JpbmdfJXMiLCByaW5nLT5uYW1lKTsNCj4gLQlkZWJ1Z2ZzX2NyZWF0ZV9maWxlX3NpemUobmFt
ZSwgU19JRlJFRyB8IFNfSVJVR08sIHJvb3QsIHJpbmcsDQo+ICsJZGVidWdmc19jcmVhdGVfZmls
ZV9zaXplKG5hbWUsIFNfSUZSRUcgfCAwNDQ0LCByb290LCByaW5nLA0KPiAgCQkJCSAmYW1kZ3B1
X2RlYnVnZnNfcmluZ19mb3BzLA0KPiAgCQkJCSByaW5nLT5yaW5nX3NpemUgKyAxMik7DQo+IA0K
PiBAQCAtNjAxLDcgKzYwMCw3IEBAIHZvaWQgYW1kZ3B1X2RlYnVnZnNfcmluZ19pbml0KHN0cnVj
dA0KPiBhbWRncHVfZGV2aWNlICphZGV2LA0KPiANCj4gIAlpZiAocmluZy0+bXFkX29iaikgew0K
PiAgCQlzcHJpbnRmKG5hbWUsICJhbWRncHVfbXFkXyVzIiwgcmluZy0+bmFtZSk7DQo+IC0JCWRl
YnVnZnNfY3JlYXRlX2ZpbGVfc2l6ZShuYW1lLCBTX0lGUkVHIHwgU19JUlVHTywgcm9vdCwNCj4g
cmluZywNCj4gKwkJZGVidWdmc19jcmVhdGVfZmlsZV9zaXplKG5hbWUsIFNfSUZSRUcgfCAwNDQ0
LCByb290LCByaW5nLA0KPiAgCQkJCQkgJmFtZGdwdV9kZWJ1Z2ZzX21xZF9mb3BzLA0KPiAgCQkJ
CQkgcmluZy0+bXFkX3NpemUpOw0KPiAgCX0NCj4gLS0NCj4gMi4yNS4xDQo=
