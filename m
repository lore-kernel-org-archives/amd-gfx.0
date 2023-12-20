Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7843DC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 09:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D134310E21C;
	Wed, 20 Dec 2023 09:49:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FE3410E21C
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 09:49:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWMDVv40Es1KrhdeaUkOSBrx7ePWzn6O97RLulBlYVzOzxPGn+Tm7jkTwtKkBY+98TI5AJ2XFtgjeZfNHw7kD80mVcCCEuRnTuHvNKGEMk9CVzLGpDcVYLZIzsNQBpbiSOv8C9dlQQoRJ7q9Iq93rClC9ekULbqnpdnRvUxmPQoqXtzoSIuVU4jUh9HFlX5hlpI0XM4VnI073aNo5q9VvMuwkbGfIMqJvKzGTXjAMFt7oB1UEztiaA50cwKkz37Z5oUUTjDB1pr4bFL3Dr34ygebbzW/YJV0QZlPDYqv7IsPyB9Rz4dLrHCDwpcDM2vlLVOI3i664M4MuYdl/giubA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVFJl40voGa8e4FOx8d3wi80nBzuWXM+I3ADTwIOEpU=;
 b=Truz8BPmnBT3g8d1xtLUVkkDAhEIShWXYr7dTxOKF3ouBUpO9IUITm7JxB4IRAnvw1/0QgNx9bXLppR27FPWPlox/sJrOy3w3b1mut0QksnUb1K9XTlTG7xxABcn6VgZGCAm4g2talXzIUG+GmkgrbpZCVDTyS9nOClxOXcBErkqTB8EZSuzk4ch7gNnP0XRMJCuBhSuUl6x0Shzrn3dRfRebusb2Erfoc/aZ7uhNGEO8hbluNQHSI0SpjBzbG6IYS6+khHttKQUBMtpCGeo35hy6SB3DHs2nr40o+1+BtTzYN1GG1DWT6O2T2jjLpuDgI7krLEwrdX1Z9NM3aVz4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVFJl40voGa8e4FOx8d3wi80nBzuWXM+I3ADTwIOEpU=;
 b=MkPhZWctktP1in7ZnmUM4rLaR7zQC0B/tk7PxzRjvyd3siWQFXnpSgSYIz5+VLNDIJm2lgywkmi3D4KoE53jAHhcFYMM9A8yYhdzgShApJ1g4urDnSNDx49ODGTPCJ0KUchWzNGDfJN2lm+rmgY7jMgOVLPCDaen3xv5uelM09w=
Received: from PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21)
 by SJ1PR12MB6338.namprd12.prod.outlook.com (2603:10b6:a03:455::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 09:49:38 +0000
Received: from PH8PR12MB6841.namprd12.prod.outlook.com
 ([fe80::eab3:f11d:3aa0:7d04]) by PH8PR12MB6841.namprd12.prod.outlook.com
 ([fe80::eab3:f11d:3aa0:7d04%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 09:49:37 +0000
From: "Xiao, Jack" <Jack.Xiao@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu/gfx11: need acquire mutex before access
 CP_VMID_RESET
Thread-Topic: [PATCH] drm/amdgpu/gfx11: need acquire mutex before access
 CP_VMID_RESET
Thread-Index: AQHaMl0d8cB9ZHuZR0Gsr1tkGLie0LCw1hMAgAEQ3XA=
Date: Wed, 20 Dec 2023 09:49:36 +0000
Message-ID: <PH8PR12MB68417ECCDF64B44C09248DF3EF96A@PH8PR12MB6841.namprd12.prod.outlook.com>
References: <20231219092340.1601929-1-Jack.Xiao@amd.com>
 <CADnq5_NAzBZj+SXc7iY5ZWUgxGCmt3A+PsVRRx59YWx4=toXYg@mail.gmail.com>
In-Reply-To: <CADnq5_NAzBZj+SXc7iY5ZWUgxGCmt3A+PsVRRx59YWx4=toXYg@mail.gmail.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=607958de-43c0-4090-907e-2e92cada3732;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-20T09:20:54Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6841:EE_|SJ1PR12MB6338:EE_
x-ms-office365-filtering-correlation-id: 7bee448c-e83d-49b4-7d73-08dc0140fa5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k26x827M4t5iOxo3JbX7Q+31+T6m8L06byzY5a2BzV+KmVhgdJmT6N7lqSjtCcWKC1X8LPYuyveSHD7H1LeXWdbSwemAzX1V31//AQddo9Daf4m3DQLjsJNzF1BvCjP7+qZicEPQCGN4MGwuFqoznnbcOBJqcQOjBhIuP27/jA26QVVSvmwBrMCPu9rqnacL3vKkNHfpHIjMN5F1HgVjt0FNNEv1TTy0MKvT1cz0pTV+E1fo9o2VSJNLV1+3qqDiOC5GW9aNdNxvpvrAKzaoDtf1AI3wlgH6TPK3xYIOVgqO1nL7tNwpAJ6VZWEKxEG4vXRAUNYdw5HkSiOdahK4PnuXRMjul35na6DfBWm4lOJEXO6V+hz7NKaksyihQGZ12yeL6aR297AT/M/Fuz0edzibMc0l5BZB0+C5Wn7tkqwxY8sElTYOmf/Wd2RG8eGiVtRCab7wsm7c+sbH0NQYvteIOXQtv0foPatwSldZXrSbtRM6nM+s6TFteAGIkIff89lwZHnQfPc1oN7L+doYYwq8DRrFAeRiEh0/+pFC49nD2bPOJGt5HGYzHK/4o+At47lqq0jy3KLeNzDE55LNXWMaY+x7pxvB2bit3AK1i4o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6841.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(136003)(376002)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(55016003)(38100700002)(122000001)(5660300002)(33656002)(2906002)(83380400001)(6506007)(7696005)(53546011)(9686003)(38070700009)(71200400001)(26005)(8676002)(66946007)(478600001)(66556008)(76116006)(41300700001)(54906003)(66446008)(6916009)(8936002)(64756008)(86362001)(4326008)(52536014)(66476007)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGUyYThLRnVOelhyamNwY0dncy80T2xMMEFwaDlNcjI1VVg3Sm54b2crWjFk?=
 =?utf-8?B?ejRmZU5Wd1JFMXJNNFplYk5WOVJ4N1Z3aTJGVjdmN0RvRVVmMmJmSjF0aktJ?=
 =?utf-8?B?aUJuR1UxdUE0UW8yWm00YUFLa1dlNWQ2czlnN2o3SjViRWZuWUk4UDN6Q2s4?=
 =?utf-8?B?MTJOVHBGV1hhek04M2xyNXJSbUU1L0ZxbGJlZThTVjlUL2kxWTBmb2t0cit1?=
 =?utf-8?B?V0dyemVpU2FQckw0RTNTZ3BUTGVNUzJscEJMT3JsMmYwUm1EREliZjUwZUZD?=
 =?utf-8?B?UUZ5MU4zVGd5dWlPWDI4SGtiekJKbnlTMUY3dDhSS2V6V1ZsM3RkQklUV3E1?=
 =?utf-8?B?M3lhZ2R0OTY5MC9rMjJmeGQyK1BsV0FmTW4waGRsK1ExRGNZUllONXo0TWoy?=
 =?utf-8?B?SlNTSWtpS0RpZi94VGlPSCticXFvVVBmOTUwNkExWENScjNEYkN0bHM4NDBB?=
 =?utf-8?B?R0lxY1Y1N1JvUGJCcEpUR01KZ01rSUVuZkZrZW5tL2M0b0xIdkxPUzA1ZUlt?=
 =?utf-8?B?OXRQaXVrZHdtcVVvYVhyalFKMTlMeG1kdUROZzdrS3ZpbCtWa1RTZHlyYW02?=
 =?utf-8?B?S01EcjEyVitkZG5MQy9FZFEvcEs5VTFsSjBRa2xIbVNCUVU1V2NLb3BVM1FC?=
 =?utf-8?B?Z1RpWGg4Y1BEN25Pd01Bc1g1blVTQmpmV1hDUFRZeUJ2a0tBb0dNWDZycnNv?=
 =?utf-8?B?TXE3YTl1TmVtS2tGdEltQWxpRTREcDNDQnVBVXAyZ0RUbjZRMkcrYTBjMHZT?=
 =?utf-8?B?djJVdFlCdHJ1U0VJTTc3L1l4RnZMZmhjMTVKN0U3Qkw4NGJUU0NIbXVTN1Fj?=
 =?utf-8?B?cFYyYkp5V1hQYkUwelRvaHNpK29NT0NSZmNFaHBSVURxK1JNUi8vSjVoZU1R?=
 =?utf-8?B?N1d5T1VNYklKd3ZtNTNzWlpCRms5MkNabDZycnJIa295RDBkNTlxZ2Y2WXlu?=
 =?utf-8?B?TytSYkc3QXpUYUFVZEVZZ0ZSSUk1VS9ta3JSZXZzMmpRRW55U3FxQ08yUTNu?=
 =?utf-8?B?VnpOMEJPeGIvSkpad2VnTktDRE1xV2pTZGUyTjhMbHl6bXRmUkYxMGd0eVRi?=
 =?utf-8?B?d3FySWJlbnN1SGkwZWJmOEs0bmFFQ242ZlJWWHBNVGQ4S1hWM2pZR2V5TjRT?=
 =?utf-8?B?WC9ML1RtdVhUM2tOL24rWFU4U1VQZ1NPZGo1UG14N2lRcTVQUEVBeVdsRm5h?=
 =?utf-8?B?d3pTb0dJUXZGZlhnZ1M4bVpKaGV5QkFQUUIwQmNWTFBDcWVPLzd4ZVprOVQ2?=
 =?utf-8?B?Y1NnRitSVFdDZzByWHg4RmFZVkpzVUxiZks4bkVRK05DdktCVGhVK0xiV2ky?=
 =?utf-8?B?Zmk0c1Z0Tkxka2JUSTdFL2JRV0pKc0lDTjJKTkVrSWloUnlrNXBDUmdoTVcv?=
 =?utf-8?B?SmpDTDEyUkxrZlhwN1Z0T3VGYnJKNzNNNnJjeCtEa2xqLzJIQlJtcWYvS3pC?=
 =?utf-8?B?WnBSYkVoczBzaTZMYk1zQnVaQW1WMzJIZGdETEppSE05TThzYm5wNTlzYnB1?=
 =?utf-8?B?TktWa01ZR1VuN3hFd0dtYjdtak5UaWllWFZvdVlYVVN0VGtKa0NBcjdFYzl5?=
 =?utf-8?B?U1ZhdkNGNjF1bTNXSG9mK3J4aVBjemVOeDY5dytLU1I1ekNtZ1JxWS9WTkFY?=
 =?utf-8?B?NXZUYTR4eFZCbjdDbVFYSVU0ZURQY3RDYTNSU25BMzFhb0p0NG5IN0orM3U1?=
 =?utf-8?B?R1ZLbHlRc0U3eEpCV011UHhBdmpxRFFDM3dpaDNEeE1PTmQ4NEpmUEZkMWhp?=
 =?utf-8?B?a3Z2dnkxMUpFanFrYWg3eTJnNmlhQkhUOWJkY3kwa2ExQ1JTczVnVXFoc2xM?=
 =?utf-8?B?a3pzNE1vdFlIRmNEcEtYek9SWmU0Z3BUYk5RRUFuOTdLdG9jOTlXY1I0c0pY?=
 =?utf-8?B?OXRmcWtlL0V0MHRUa2tSc1BlVjFvUVJpTW1SRlphVEhvUzhoclVrTzYzUWZ5?=
 =?utf-8?B?TVFGVzRkNFc4dWt0VVNOS0NsMFZGZG9rWHhuUzExN1IvSmZEZmlGcnp5TnJi?=
 =?utf-8?B?dmwyeVo2UG1HV3N1Z2cyN1FRd2l6WGV5VEVZL0E0cE9KYkRKTGRqRWVRak5X?=
 =?utf-8?B?anRrTXBDcnVQbXBEc0pDeWFaYUdRQnNFSWlPb0hRcVE0U242cDVZb3JYWVhR?=
 =?utf-8?Q?cWiY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6841.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bee448c-e83d-49b4-7d73-08dc0140fa5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2023 09:49:36.9519 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 84T1rwdRB22j9Bh1PwFnJ12BvsvEaSE9beLvIrJZnyrWLFSyzGpzYEh4oXS10XjH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6338
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
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkl0J3MgYWxyZWFkeSBwcm90ZWN0
ZWQgYnkgdGhlIHJlc2V0IGxvY2suIEluIG15IHVuZGVyc3RhbmRpbmcsIHNvZnQgcmVzZXQgc2hv
dWxkIG5vdCBydW4gaW4gcGFyYWxsZWwuDQoNClJlZ2FyZHMsDQpKYWNrDQoNCi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNv
bT4NClNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIgMjAsIDIwMjMgMTowNCBBTQ0KVG86IFhpYW8s
IEphY2sgPEphY2suWGlhb0BhbWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnOyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBaaGFu
ZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0g
ZHJtL2FtZGdwdS9nZngxMTogbmVlZCBhY3F1aXJlIG11dGV4IGJlZm9yZSBhY2Nlc3MgQ1BfVk1J
RF9SRVNFVA0KDQpPbiBUdWUsIERlYyAxOSwgMjAyMyBhdCA0OjMw4oCvQU0gSmFjayBYaWFvIDxK
YWNrLlhpYW9AYW1kLmNvbT4gd3JvdGU6DQo+DQo+IEl0J3MgcmVxdWlyZWQgdG8gdGFrZSB0aGUg
Z2Z4IG11dGV4IGJlZm9yZSBhY2Nlc3MgdG8gQ1BfVk1JRF9SRVNFVCwNCj4gZm9yIHRoZXJlIGlz
IGEgcmFjZSBjb25kaXRpb24gd2l0aCBDUCBmaXJtd2FyZSB0byB3cml0ZSB0aGUgcmVnaXN0ZXIu
DQo+DQo+IFNpZ25lZC1vZmYtYnk6IEphY2sgWGlhbyA8SmFjay5YaWFvQGFtZC5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMV8wLmMgfCAyMCArKysrKysr
KysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykNCj4NCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5jDQo+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMV8wLmMNCj4gaW5kZXggYmRjZjk2ZGY2
OWU2Li5hZTMzNzBkMzRkMTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92MTFfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
MTFfMC5jDQo+IEBAIC00NTE4LDYgKzQ1MTgsMjIgQEAgc3RhdGljIGludCBnZnhfdjExXzBfc29m
dF9yZXNldCh2b2lkICpoYW5kbGUpDQo+ICAgICAgICAgICAgICAgICB9DQo+ICAgICAgICAgfQ0K
Pg0KDQpXZSBwcm9iYWJseSB3YW50IGEgQ1BVIG11dGV4IG9yIHNwaW5sb2NrIHRvIHByb3RlY3Qg
dGhpcyBhcyB3ZWxsIHVubGVzcyB0aGlzIGlzIGFscmVhZHkgcHJvdGVjdGVkIGJ5IHRoZSByZXNl
dCBsb2NrLg0KDQpBbGV4DQoNCj4gKyAgICAgICAvKiBUcnkgdG8gcmVxdWlyZSB0aGUgZ2Z4IG11
dGV4IGJlZm9yZSBhY2Nlc3MgdG8gQ1BfVk1JRF9SRVNFVCAqLw0KPiArICAgICAgIGZvciAoaSA9
IDA7IGkgPCBhZGV2LT51c2VjX3RpbWVvdXQ7IGkrKykgew0KPiArICAgICAgICAgICAgICAgLyog
UmVxdWVzdCB3aXRoIE1lSWQ9MiwgUGlwZUlkPTAgKi8NCj4gKyAgICAgICAgICAgICAgIHRtcCA9
IFJFR19TRVRfRklFTEQoMCwgQ1BfR0ZYX0lOREVYX01VVEVYLCBSRVFVRVNULCAxKTsNCj4gKyAg
ICAgICAgICAgICAgIHRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBDUF9HRlhfSU5ERVhfTVVURVgs
IENMSUVOVElELCA0KTsNCj4gKyAgICAgICAgICAgICAgIFdSRUczMl9TT0MxNShHQywgMCwgcmVn
Q1BfR0ZYX0lOREVYX01VVEVYLCB0bXApOw0KPiArICAgICAgICAgICAgICAgaWYgKFJSRUczMl9T
T0MxNShHQywgMCwgcmVnQ1BfR0ZYX0lOREVYX01VVEVYKSA9PSB0bXApDQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGJyZWFrOw0KPiArICAgICAgICAgICAgICAgdWRlbGF5KDEpOw0KPiArICAg
ICAgIH0NCj4gKw0KPiArICAgICAgIGlmIChpID49IGFkZXYtPnVzZWNfdGltZW91dCkgew0KPiAr
ICAgICAgICAgICAgICAgcHJpbnRrKCJGYWlsZWQgdG8gcmVxdWlyZSB0aGUgZ2Z4IG11dGV4IGR1
cmluZyBzb2Z0IHJlc2V0XG4iKTsNCj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0K
PiArICAgICAgIH0NCj4gKw0KPiAgICAgICAgIFdSRUczMl9TT0MxNShHQywgMCwgcmVnQ1BfVk1J
RF9SRVNFVCwgMHhmZmZmZmZmZSk7DQo+DQo+ICAgICAgICAgLy8gUmVhZCBDUF9WTUlEX1JFU0VU
IHJlZ2lzdGVyIHRocmVlIHRpbWVzLg0KPiBAQCAtNDUyNiw2ICs0NTQyLDEwIEBAIHN0YXRpYyBp
bnQgZ2Z4X3YxMV8wX3NvZnRfcmVzZXQodm9pZCAqaGFuZGxlKQ0KPiAgICAgICAgIFJSRUczMl9T
T0MxNShHQywgMCwgcmVnQ1BfVk1JRF9SRVNFVCk7DQo+ICAgICAgICAgUlJFRzMyX1NPQzE1KEdD
LCAwLCByZWdDUF9WTUlEX1JFU0VUKTsNCj4NCj4gKyAgICAgICAvKiByZWxlYXNlIHRoZSBnZngg
bXV0ZXggKi8NCj4gKyAgICAgICB0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgQ1BfR0ZYX0lOREVY
X01VVEVYLCBSRVFVRVNULCAwKTsNCj4gKyAgICAgICBXUkVHMzJfU09DMTUoR0MsIDAsIHJlZ0NQ
X0dGWF9JTkRFWF9NVVRFWCwgdG1wKTsNCj4gKw0KPiAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBh
ZGV2LT51c2VjX3RpbWVvdXQ7IGkrKykgew0KPiAgICAgICAgICAgICAgICAgaWYgKCFSUkVHMzJf
U09DMTUoR0MsIDAsIHJlZ0NQX0hRRF9BQ1RJVkUpICYmDQo+ICAgICAgICAgICAgICAgICAgICAg
IVJSRUczMl9TT0MxNShHQywgMCwgcmVnQ1BfR0ZYX0hRRF9BQ1RJVkUpKQ0KPiAtLQ0KPiAyLjQx
LjANCj4NCg==
