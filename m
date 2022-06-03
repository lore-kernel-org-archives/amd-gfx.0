Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B67C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 10:35:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00BCC10E2C1;
	Fri,  3 Jun 2022 10:35:04 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2053.outbound.protection.outlook.com [40.107.96.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7123810E2C1
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 10:35:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbWS9h8WH8CeJwax7ozRls2dUPnlvv54fJ+5hbts4l+yMkWbZMnpQKSnghD4TzS7sE15ME7jp1g3RuZ7WuTdHxh3o/k2NGK4pXJ2q0X0PiJBavPLvD37To4ePm8vFHJ0bzBiB1aXiWHz0V+vyps6hS9CnFfEzjtHsIu6nshOimF/7Mglc3fP/ABi/Ux5y2K6i43WH4XTCv/r/9A9OTo8frmPjfLDf2JIeRn4pJ9vupHFEm52y+LpbvhYx+TVenB8wn7x5FYtzHkzPQIyRUe6F1I7KaPJh8LtQepXY+dDMTbby6SsIhrW4vqDHH/DuhHRIRZVnmdcKZ+8nEqYvArHYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vt8PI19YwAeN2kmSIjITF+A3/BOC4nSaecfFJtzJaH8=;
 b=DwUND1VO3UdwADLdiW+sVe88Wc9KG9XTD+iZCcAiim8IOx3OhLDx8kj6idmNGFyziM0srdzhXd48yg1jwz6B4+oD9ObugXG74Ge1ue0usCiFRz5BxLzzNg6H/ORuoD54fRskA86nxza7xK1zwHfBfF5Kx1pA1EXVOsbLIx0YG8GxOTYW4TBxyAODP7CqybzfAoOJUir4z3OwTWEROl++3zVHcyYe4jS/FY28XR3QLBmubBmrnnyOF3M74expbcYsCj4xMWJOa2XpmOMN4qupenAmIFh5IYI0Ddg1GgACLkiDVoQlZCs8iaUkK2BygmqSjqt5nKrUsrDL3qdh6l0B/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vt8PI19YwAeN2kmSIjITF+A3/BOC4nSaecfFJtzJaH8=;
 b=iZJE2sD7oY/p+rTrOqHXqRYetxQmSGUMqKLgmv9zyQtrWwxsm4IScVKKFkmQUjz7ZZVv0iI98UZxdHEHcrNmvSYZzi7ZSF449yi1MkUVJqgEmhJKAEfxMR+VK/77x/8VPyke/NkQPu3GWMSA0Ep2qohCkXsNDZeMCSiqKXcO2v8=
Received: from SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 10:35:01 +0000
Received: from SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::58d8:1b61:8bdb:2824]) by SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::58d8:1b61:8bdb:2824%4]) with mapi id 15.20.5293.020; Fri, 3 Jun 2022
 10:35:01 +0000
From: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amdkfd: Define config HSA_AMD_P2P to support
 peer-to-peer
Thread-Topic: [PATCH 1/3] drm/amdkfd: Define config HSA_AMD_P2P to support
 peer-to-peer
Thread-Index: AQHYdRBCHnT7eRwDy0eFerquRq5ZSK06swoAgALNvmA=
Date: Fri, 3 Jun 2022 10:35:01 +0000
Message-ID: <SN1PR12MB2575EF9DC47E5CEF86ADB9ABE3A19@SN1PR12MB2575.namprd12.prod.outlook.com>
References: <20220531170237.809884-1-Ramesh.Errabolu@amd.com>
 <f6d7a96a-1550-8513-8590-ebeb79943d08@amd.com>
In-Reply-To: <f6d7a96a-1550-8513-8590-ebeb79943d08@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-03T10:34:07Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6c03e08c-ed56-44ab-8fad-ae9bccacd8c2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-06-03T10:34:58Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 4abd6812-3471-46c6-bffa-a4413d183f99
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe0f7fd2-8a1a-40ca-4fad-08da454cb6d2
x-ms-traffictypediagnostic: MN2PR12MB4253:EE_
x-microsoft-antispam-prvs: <MN2PR12MB4253DE4B767B3CF2055CDC89E3A19@MN2PR12MB4253.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RumofBAdrmoGAGcA308DFKbEwtBX1QmPAwGvnfzFoTEDmRELSkENqmA1Oq3OcPb3h7RNvphfYbzzeZt1hP0Pwssk54s+HqjXJFOFqfgH+VYMS0fJ8m0sqVJFHYno8ASHjg1m31AyeS+Sjdox0IT6XTK3CMaaLPyfDs7V6IMdgi6nwXpnukNUAi5B8lHWdVm7iJuec/H2cGSLBkHBQth5HfXYhNXPlWnpKAI14zMoLCQcN3+jneSUSgvdP5qoS1+VAvBPKO7bA+WELhnTN9PEzpxtc9XsbYmmI5zHUcFnmpB7DdXaeXaHDilsSbyZKv1wLgI63GFC3eB30CoygkyS29ibNHJ5ZJqrA3HrG+JPoYvTSNd0kN3Oxs1+K5lN7i1ewVR+wqV5KE3WaM4+lC1KFH9mEueCNwBthKvWOoPxH858qrhKsK2qhkPmmfIn8VOhZ8h3GIxp65B1IAYdqM7kDFQKkQIHsxMYlUkN9pNFbK8mfLHHvYHDqvymrEInQS79FHs8SXw+VMHeBr0IR5+hlCPBdFzdu6L5YDr7kZ8X9Wl/RhG8gVbkLMtVt1xc36WdaLgidvYBFP6woLAYKwGa0B/vQTpPViI9yJ9DTqHikBbxHJezgwgxN+BlWJ2bwP0U+BnI3X799LLUBgM+jMFsS9IvUt6uu2K6dVW6IRqqhsUe2mSpHt6gHoAxJK+ubD+OY2Ir++7RV3ZBUDXom10LUw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2575.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(64756008)(52536014)(8676002)(122000001)(66446008)(66556008)(38070700005)(66946007)(66476007)(76116006)(110136005)(316002)(33656002)(55016003)(38100700002)(6506007)(53546011)(83380400001)(7696005)(8936002)(2906002)(186003)(5660300002)(86362001)(26005)(9686003)(71200400001)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0J4NE5vVy9wU1JETTgrYmxoRjlKeXoxQ29YVTgvUktIbE9aUFlDQkdjQVB1?=
 =?utf-8?B?Sll4YVUzKzRuUXpISzVwbGRtVHhDUXZtbU1yYmxLblNVcldyemZsL3JXUUxK?=
 =?utf-8?B?ZCs4MGY2WkpJd29FN1BZcU0wcGM4djdmMys0a1MrZTNPSjl0S3RoRjVzeWdT?=
 =?utf-8?B?dnFoek9QUVhrYUlKenFkR09jZFhUdThEV3V4VExmV3N4SzdlUmk0VUJKdUw5?=
 =?utf-8?B?V3hzNzZIWTVuZEFsclVsbnd4UUNHRXl5ZHpJeVUxZ1IyM2NqeWlsamtOYWZw?=
 =?utf-8?B?L1RSeDl5c2xKUDJKVGxzZVV1Q1BpKzZ4SFA0NHZFVlJsaDBBQTlIcERwWW5G?=
 =?utf-8?B?eTVmV2tnd3p2K3NMbStmRlBZQzhxMnZDaWRuZU0yUDM1N201QU1DUFd6SVVa?=
 =?utf-8?B?Y3lNek5QKzFxbjBYNHFBYUdqQ1BwWktwZ2U1Z0lkUXIrQzBYWVhoNm5wOGJ6?=
 =?utf-8?B?WER6MTM1RGgxRDh4Um5lM28yQndJS2pWcm9aZHFNbGJyR2lRUW5lNk1QQlUv?=
 =?utf-8?B?THlCbzFUaGE1UnBnTlI3Y3ZIY3gyaDV3Szl2bmxtampCSmU5ajBxQUFwMEpJ?=
 =?utf-8?B?cW9qcGo3NnR4Nm8vV21BMWpwblJwdy93b0YrNEYveE9TS1UyN2pVVjE2U2lk?=
 =?utf-8?B?NmhLY3ZjRjdCZ1ZVMnJBby9SRmQrdHVJSzJFTHVld2xSaDBBRmxHRElvK2p1?=
 =?utf-8?B?bkloR3RhMmdlL3AvZldWa1dNSjZ0bXpQTVhBWFQzWU9mWEJ3Ylg5TzZpbnlO?=
 =?utf-8?B?QS9rM3NyS2ROei81Sm9ON1hKOVZ6YXM2YzJ6cHlHbmNPaGd6S0F3YkFXUDBw?=
 =?utf-8?B?QmdvZExpSnFzaElYQnlaV09MdjdiWVhOKzhpY0FEbmxWN0c5b0JsNHdPV3A3?=
 =?utf-8?B?NG4weFRUcjdLMkR5UU9CY0xKRTFzK2tzMy84NjR6U3cxclRWVTZXMWRtWDFs?=
 =?utf-8?B?Nld5Qm02bG9vdFZSdUlKU1dJUFM2RVBTb2JxUE1iVWk5VTVTbGVjbGVFY0VQ?=
 =?utf-8?B?dWhYajFneExPN1NQczRjWlBjRUsrQTllOHU3a2lXY3MyYkloaW40K2pBYVBW?=
 =?utf-8?B?cG1zaXNlajhabHVmVkZzUk93YU84SDZoeEN2bXhTYjhYcEtMRzJFQTBmTnRv?=
 =?utf-8?B?b1BXK016YkRLZEVhWnkwaTBobXp2ZE5mL3U4bThjdW9odWxMZFJQUUp2aGJU?=
 =?utf-8?B?cExTM1pxYW5wQ2RCNUJ0K3I5YWs2bGlpMXBWVmYwdStUZlZZSi9XSEd4Z2pj?=
 =?utf-8?B?eGNMUkRDeDE0Y1NZMTgvK1lud05sMHRIZG1ldGVvbzhCVWx2eUI2RkY5SDJs?=
 =?utf-8?B?YlcxRXF3WGN4dmRTS0tBT3FWNzRIS3BPaXJxc3p0aTd4K0FMUlFyVHkzajVZ?=
 =?utf-8?B?d0VuaWU2ZmpQYVpxaGRrUVFGRjVtWWpHS2RudUsvYnQ1MlFXSGZBMEdIUDdl?=
 =?utf-8?B?NUNBK04zT3dsSXVBaTNzRWpSdmw2eUlMRVIwNHU0MFoyaTB3aGd6dVQxbW0z?=
 =?utf-8?B?TWhEdlFPYUJOMUpBalZhQVY5MVJ3M013emVIQXlMdkFvQ2RwcEtqTDhMc2Zi?=
 =?utf-8?B?U2g1SC81N290Q1dPbEhIS0YrdGVlaHJ2THpGajE4a1ZiQUZsUE1HanZIV0F6?=
 =?utf-8?B?ZFQ3ejMzYnphWWt6TVRWeEx6Yzl5RHNrSVVvSTJHM0xFZzVEeVg3UC84Yk1n?=
 =?utf-8?B?d1dwZ0Q5ZTJ5ekh6Yk1kQ1hqekE1K1p0ekhZVXlubzV0clRNdlBiRncxRGVv?=
 =?utf-8?B?MFE2UnRud1ErbUxlbWt2QkpuNnF4cnhSWEtaejFDYWdnbFRNK0loK05rWFF1?=
 =?utf-8?B?aWk4UXJ6bXJQR1Q5bWd0WURHNDhnazRTeG5mUTBWZDVpc0xINXpoMW1YSnFM?=
 =?utf-8?B?S2RRSmNFOTBFS0JEUHVTTWhpSy9kZy9iZlBnS3VtV05xRC9lVWw1NnBGUDZC?=
 =?utf-8?B?UTVaeVJKeHR4WUladnRCZU44SDk0ME43TVZsNjFZamp1Zmc1KzFQZExlM2xI?=
 =?utf-8?B?Mm1uSHlmK2pUUlExdmwyYmZVcExleEQvcGx6Z2d1SUhDYTJPRThRYndZZytH?=
 =?utf-8?B?WkRLZzkrOUpPRFVzNm9IU3NQbVRSZGxZRlFRVk8rNWViQkh3Y1BFVXpTQnF1?=
 =?utf-8?B?a1ptK3psNDFIaGVGZWt6Qk1ScDdVeUNIbHpGZ3NXRmt1c3c4Q0RsdnUvdWJC?=
 =?utf-8?B?ZTE3bHVsVWNqUVBJbVVDSkQxTkRxYjJ5SDVXSjU4cXc5M1E0TzZTTmVQeDNn?=
 =?utf-8?B?T25zT2p0OWVFd2NpNmZ5MFBoa0M4enU5bmp3bGh6Q3B2SittSGNYQmtVbTU1?=
 =?utf-8?B?RE8wdzJIc3BkWkxhaVM5K1JpenlLQWVEMm1DT2FQWE1jMHdxclpSUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2575.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0f7fd2-8a1a-40ca-4fad-08da454cb6d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2022 10:35:01.2945 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XzqoDtoGw5uV8CG96ZDW4DzutjI7jYpCHfqIikKTw3otRsSwy+LseM8MIyOrmKumuaiwpyaL+TkgzMk8YjJMow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClVwZGF0ZSB0aGUgYm90aCB0aGUg
ZGVzY3JpcHRpb24gYW5kIGNvbW1pdCBtZXNzYWdlIHBlciByZXZpZXcgY29tbWVudHMuDQpXaWxs
IHBvc3QgbmV3IHBhdGNoIHNob3J0bHkuDQoNClJlZ2FyZHMsDQpSYW1lc2gNCg0KLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdA
YW1kLmNvbT4gDQpTZW50OiBXZWRuZXNkYXksIEp1bmUgMSwgMjAyMiA5OjE1IFBNDQpUbzogRXJy
YWJvbHUsIFJhbWVzaCA8UmFtZXNoLkVycmFib2x1QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIGRybS9hbWRrZmQ6IERlZmlu
ZSBjb25maWcgSFNBX0FNRF9QMlAgdG8gc3VwcG9ydCBwZWVyLXRvLXBlZXINCg0KQW0gMjAyMi0w
NS0zMSB1bSAxMzowMiBzY2hyaWViIFJhbWVzaCBFcnJhYm9sdToNCj4gRXh0ZW5kIGN1cnJlbnQg
a2VybmVsIGNvbmZpZyByZXF1aXJlbWVudHMgb2YgYW1kZ3B1IGJ5IGFkZGluZyBjb25maWcgDQo+
IEhTQV9BTURfUDJQLiBFbmFibGluZyBIU0FfQU1EX1AyUCBpcyBSRVFVSVJFRCB0byBzdXBwb3J0
IHBlZXItdG8tcGVlciANCj4gY29tbXVuaWNhdGlvbiwgaW4gYm90aCBkYXRhIGFuZCBjb250cm9s
IHBsYW5lcywgYW1vbmcgQU1EIEdQVSBkZXZpY2VzIA0KPiB0aGF0IGFyZSBjb25uZWN0ZWQgdmlh
IFBDSWUgYW5kIGhhdmUgbGFyZ2UgQkFSIHZCSU9TDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFJhbWVz
aCBFcnJhYm9sdSA8UmFtZXNoLkVycmFib2x1QGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL0tjb25maWcgfCA4ICsrKysrKysrDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQvS2NvbmZpZyANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9LY29uZmln
DQo+IGluZGV4IDhjYzBhNzZkZGY5Zi4uMjY2MTRmNWYyMGVhIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL0tjb25maWcNCj4gQEAgLTI1LDMgKzI1LDExIEBAIGNvbmZpZyBIU0FfQU1EX1NW
TQ0KPiAgIAkgIHByZWVtcHRpb25zIGFuZCBvbmUgYmFzZWQgb24gcGFnZSBmYXVsdHMuIFRvIGVu
YWJsZSBwYWdlIGZhdWx0DQo+ICAgCSAgYmFzZWQgbWVtb3J5IG1hbmFnZW1lbnQgb24gbW9zdCBH
Rlh2OSBHUFVzLCBzZXQgdGhlIG1vZHVsZQ0KPiAgIAkgIHBhcmFtZXRlciBhbWRncHUubm9yZXRy
eT0wLg0KPiArDQo+ICtjb25maWcgSFNBX0FNRF9QMlANCj4gKwlib29sICJIU0Ega2VybmVsIGRy
aXZlciBzdXBwb3J0IGZvciBwZWVyLXRvLXBlZXIgZm9yIEFNRCBHUFUgZGV2aWNlcyINCj4gKwlk
ZXBlbmRzIG9uIEhTQV9BTUQgJiYgUENJX1AyUERNQSAmJiBETUFCVUZfTU9WRV9OT1RJRlkNCj4g
KwloZWxwDQo+ICsJICBFbmFibGUgdGhpcyBpZiB5b3Ugd2FudCB0byBhY2Nlc3MgQU1EIEdQVSBw
ZWVyIGRldmljZXMsIGluIGJvdGggZGF0YQ0KPiArCSAgYW5kIGNvbnRyb2wgcGxhbmVzLCB0aGF0
IGFyZSBjb25uZWN0ZWQgdmlhIFBDSWUgYW5kIGhhdmUgbGFyZ2UgQkFSIA0KPiArdkJJT1MNCg0K
SSBoYXZlIG5vdCBzZWVuIHRoZSB0ZXJtcyAiZGF0YSBwbGFuZSIgYW5kICJjb250cm9sIHBsYW5l
IiB1c2VkIGluIHRoZSBjb250ZXh0IG9mIEdQVXMuIEFzIGZhciBhcyBJIGNhbiB0ZWxsLCB0aGlz
IHRlcm1pbm9sb2d5IGlzIG1vcmUgY29tbW9uIGluIHRoZSBjb250ZXh0IG5ldHdvcmsgcm91dGlu
Zy4gSSB0aGluayBpdCBjb3VsZCBjYXVzZSBjb25mdXNpb24gdG8gaW50cm9kdWNlIHRoZXNlIHRl
cm1zIHdpdGhvdXQgYW4gZXhwbGFuYXRpb24gdG8gdXNlcnMuDQoNClRoZSBzZW50ZW5jZSAiLi4u
IGlmIHlvdSB3YW50IHRvIGFjY2VzcyBBTUQgR1BVIHBlZXIgZGV2aWNlcyAuLi4iIHNlZW1zIHRv
IGFkZHJlc3Mgc29tZW9uZSB3cml0aW5nIGFuIGFwcGxpY2F0aW9uLiBUaGlzIGhlbHAgbWVzc2Fn
ZSBpcyBtZWFudCBmb3IgdXNlcnMgYW5kIGFkbWlucyBidWlsZGluZyBhIGtlcm5lbCwgd2hvIG1h
eSB3YW50IHRvIHJ1biBjb21wdXRlIGFwcGxpY2F0aW9ucywgbm90IGZvciBjb21wdXRlIGFwcGxp
Y2F0aW9uIGRldmVsb3BlcnMuDQoNCkkgd291bGQgYWxzbyBub3QgbWVudGlvbiBsYXJnZS1CQVIg
VkJJT1NlcyBiZWNhdXNlIHRoZSBCQVIgY2FuIG9mdGVuIGJlIHJlc2l6ZWQgZXZlbiB3aXRoIGEg
c21hbGwtQkFSIFZCSU9TLg0KDQpUaGVyZWZvcmUgSSB3b3VsZCByZWNvbW1lbmQgYW4gYWx0ZXJu
YXRpdmUgdGV4dCBoZXJlIHRoYXQgYXZvaWRzIHVuY29tbW9uIHRlcm1pbm9sb2d5IGFuZCBhZGRy
ZXNzZXMgdGhlIGNvbmNlcm5zIG9mIHVzZXJzIHJhdGhlciB0aGFuIGFwcGxpY2F0aW9uIGRldmVs
b3BlcnM6DQoNCiAgICBFbmFibGUgcGVlci10by1wZWVyIChQMlApIGNvbW11bmljYXRpb24gYmV0
d2VlbiBBTUQgR1BVcyBvdmVyIHRoZQ0KICAgIFBDSWUgYnVzLiBUaGlzIGNhbiBpbXByb3ZlIHBl
cmZvcm1hbmNlIG9mIG11bHRpLUdQVSBjb21wdXRlDQogICAgYXBwbGljYXRpb25zIGFuZCBsaWJy
YXJpZXMgYnkgZW5hYmxpbmcgR1BVcyB0byBhY2Nlc3MgZGF0YSBkaXJlY3RseQ0KICAgIGluIHBl
ZXIgR1BVcycgbWVtb3J5IHdpdGhvdXQgaW50ZXJtZWRpYXRlIGNvcGllcyBpbiBzeXN0ZW0gbWVt
b3J5Lg0KDQogICAgVGhpcyBQMlAgZmVhdHVyZSBpcyBvbmx5IGVuYWJsZWQgb24gY29tcGF0aWJs
ZSBjaGlwc2V0cywgYW5kIGJldHdlZW4NCiAgICBHUFVzIHdpdGggbGFyZ2UgbWVtb3J5IEJBUnMg
dGhhdCBleHBvc2UgdGhlIGVudGlyZSBWUkFNIGluIFBDSSBidXMNCiAgICBhZGRyZXNzIHNwYWNl
IHdpdGhpbiB0aGUgcGh5c2ljYWwgYWRkcmVzcyBsaW1pdHMgb2YgdGhlIEdQVXMuDQoNClJlZ2Fy
ZHMsDQogwqAgRmVsaXgNCg0KDQo+ICsNCg==
