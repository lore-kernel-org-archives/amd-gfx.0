Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6217FB5EA6
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 02:15:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 379A610E26E;
	Tue, 17 Mar 2026 02:15:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MLY/G8cn";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010051.outbound.protection.outlook.com
 [52.101.193.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1847810E26E
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 02:15:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amXBwf9K2oH7t/L1SIe8E+mLtyfJeU9B1F4wLy8dVvnWpBsUDKntITVEQlxO+DCmTyFaXTTFr5pxtyrHCH+03vGCjAfD//Ogva75BFbPTgpdSElriIM43eGOAGunlDjm6Mrv/ld83rhTtIyT8Z8kRoWer9mQXMVwv//nKwP45cVdrX9xlhjrOY5D/jLkWzABF0pBdCBgjc0CGIhzH2hFU+XeFk7rt5TfyfOQ3NA+KEJ0aQZzp9WNnCnfZ1R0yRS8j9GUXpHPwPnSiN6RNiqyVDze6evCgUnW0UTSdP1oTfcuZmHVi/Ii0h3K5tsX+6NkeIlXghNCU03P635FB6b1yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtrMOrFiyHfumsd/0U2YxFvywxErB2goppx7NrL6854=;
 b=d37OGqGb5OjzLXxhHhGN86sey2lhguWEYHI33T9uavOtht/54FMq9Y8AH336ATcNduEJAqL/iSSkOE9ffA7luHrwphlNMjzasrqbDPZ+tjjCUhnESEsyuDYjnpJSPg/6LYGU5a+JBCLT7zpzxZUnrV+Ds7coB3gamMASc8pVWj2tXLBABSZkvBoeWgewtQmbScMaENpZpAY2+lNCOuJX1DX0zQt3ZonLH9w6IbSP8Qs9jeO4AFvplnqvryuHveODuowrpoHRZw6JzzC4d6XTn1nkFxND8/YOEblYqmJjz83GFVwOLU//rzBrNzo4XRqYi9pBQw7Kx/75jZdMNAcv8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtrMOrFiyHfumsd/0U2YxFvywxErB2goppx7NrL6854=;
 b=MLY/G8cnwW6xuuGxD1uc+trMLKP+WZO9TPaoYA63Soe4zBrtFYvMCu9J6uC1943ketW1iw7e0Wf8Nix7wZVaR93pLbkBDQNs21c8abYD3kvZPWPRyhnOT3NxtS+9eEV0ZtZ9INMU9icaCetJWX1RCdbMBRzL9vsQHn1y+y2uLkc=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by SA5PPF5EA4322E1.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8cc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Tue, 17 Mar
 2026 02:15:47 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%2]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 02:15:47 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: rework how we handle TLB fences
Thread-Topic: [PATCH] drm/amdgpu: rework how we handle TLB fences
Thread-Index: AQHctVfv0/u4rwvVlEG7eZdW6j/IDLWx/E2w
Content-Class: 
Date: Tue, 17 Mar 2026 02:15:47 +0000
Message-ID: <PH7PR12MB60001CB3EBC142F17E334066FB41A@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20260316151636.1122226-1-alexander.deucher@amd.com>
In-Reply-To: <20260316151636.1122226-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-17T02:12:52.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|SA5PPF5EA4322E1:EE_
x-ms-office365-filtering-correlation-id: 551f8c18-c698-4b40-8c42-08de83cb1a0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|22082099003|56012099003|18002099003|7053199007;
x-microsoft-antispam-message-info: Sbp05jdGLLX/4Pil2aX8DqlO7fDtHVNKyBNe3IOBWfiwZdMWNzpuhpQyZ5lkG82P/57ardBUFLl14oLPGAL38XycJLYgnEr3ghN//6hTJvhxOA4Vy9qfgniJUWFoYbRN2AJxkk7pcbyflEfr18I3/JKybCn3twdUU+8y5/+xysgEoKMidO60vTQ5rjtE3EHtB/6oUQ7TUmbACxqUq5ABmuc8hNQJGCx3P0W5qWwzBvm0Jg9upnvPjKJGIxBbXuUlmRp3Rr6kLuKtcnIwhlZtnNDwsBqHMQ5UW9vQwnYb6l+qzUHzMfM9jmonH8T36kwPZcOeG6dFt4jILIvGusjetyWZvT5LAMuyGt65R3IhgSWXA6mENEuYKyQMkgJXqsHt1UlB2jQSDckbKruMBUpOTGeUyzGkdksGRyb4zy5Y6FKfReRC8PHVIWVjSXInYnKKcK7jq4CuPJap8hRAF/WzNRecL+m0/L0THhnD8S0/xn5PsDU0v4Sba7ebBTQ1l+MR7y7o8NuYQtyTurX5w8gMpQFIuqp+El4ONbZOgCk4CPAns0ldnNB249R5ZDSaRs+c2to7x85dYNFn4BRe73QQ9vnc1zvbIjvYHMKIKoUyUnLBlZmRgQNtugwcAHLyqRWc3V8kJZZq4MA5vyyNKhIlIMWw65JOuq1nhw4ZDiQoXYyLGtBVwPjJRLbvBJn48rDHdFqP70hDm6p+pobsIPZYEmrGZ3d0iXFkppmuzKaGM6RWXfTWxFmNG6T3vYK92hMO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(56012099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFZVU1FNWnV2aW5aVE83aDh2dnZ5UVo4U0szcFkycG5PeHcxMEYwRHVKYUVl?=
 =?utf-8?B?bkdweitZdXR5eHg3YUNCUjVzU21tRGQxU2twVmR4SDUzOGJKeEJDWFVBWnpl?=
 =?utf-8?B?UU1oZlZUWThqclJSRzNyU2dMMWtObmVZM1pZajRKdE1pSGYvQ2FMZXd0bXdp?=
 =?utf-8?B?ZTZsZk9ORDVJRitqOTJCZkZpdHM4VWFEbVBRU296cnovSUVwcXdGMExrU2Fj?=
 =?utf-8?B?VEtlZHZrRlZIckt0U2RzMm1kTSs4V3cza29CNFllclNMYTFkNVFSanhwM2xN?=
 =?utf-8?B?MUUwREJ1NXM4TEJ5VW1wcE9NVmNMaXJCaXlQOVRJYmZYRTNqZThadmFtbEZn?=
 =?utf-8?B?SlJhKzR4OUhqTnRtd1Nkd2haazNZb1VIcWJtV0Q3c1kzc3JnNDFaODJmRmt5?=
 =?utf-8?B?T0ltRFhEZmQ3cWJVOE8xQzBlSW1OVVJoaU8xWXlTV2VNTldGTmZZSHR2Umpv?=
 =?utf-8?B?UjFkekV3V0FDU1hqWURoZnU4RzN5MXVKcHY0TFNTOXY1MVF4eHdVNTA2cDFx?=
 =?utf-8?B?UzZva2FNdWVILzUramxZdDNqTThlaFI3cnhaeWdSa0V4TEJEQmk1SHhGUWov?=
 =?utf-8?B?ZWtVYTVFKzl5U1lyMUQ5VytEejRYTldSU1QwMEhxNCs0WVBsT1M1cFdSNFNp?=
 =?utf-8?B?VlJCRXgwTXlXd20yTFY2eWFVRkhxRGE0dU5XY0JCQ1RraVZydVBFQ1cySktS?=
 =?utf-8?B?bS9PQ2NFY3ZGMWJ3QU95U2c0QlhSN0lBRXZyR0h5QTQwZEtUakl5UDlJQUVR?=
 =?utf-8?B?Y2g5dGp4SllTWURTdmF0aE9WUGw0SmppMXp2d2k3b1lHMlZtVE1IZ3BrbGxx?=
 =?utf-8?B?VnpJU2MzNlZLZmhmK0hBUzQ3N0NkUzVKbW40TExqYzlCUUFFdHZTeC9xVEhL?=
 =?utf-8?B?N3c4anNHZHQ5aEk0TWN6TGFhNXo1NTJOdjBHdlA5M1loVGdQWHR5dWJ5SkhL?=
 =?utf-8?B?K21vL1VGOXRlRjVFdkliZHdESmFTWW41dm9aYWUyZTNEeGI2NDloY2dEaFl3?=
 =?utf-8?B?Ti9UVUhhb0FJWnlYK3NKL0dGbkVxekNPYkRKU2diVzdrdUlodkduR2I4Y1FW?=
 =?utf-8?B?NmsvSmcvM2tWS2lsTVBZVURoeUIrQkhiUGFCYm9pNzE5UTNUNGpiSUtKNDV4?=
 =?utf-8?B?Ri9kOE8wRmhPenpBUnVUYzRyQ29hNGZEeHFneGhMT3hwc0pXb0hCWWMvbmJK?=
 =?utf-8?B?T0EwZkxsSExhMnE4enl4VHpRRDhqSDdiOENma2J0K0ZJMjBXZUV3YithSFRI?=
 =?utf-8?B?U2hvNlUzMkUyMVY4WHkyN2w3NHBQQXlsd2IvSnkvM2pFbHVqMXJPSlU5VEZl?=
 =?utf-8?B?b082ZUN1SVkyekxEcGlkSFUzWlA1WEZiVWV4WHpMWm5OR1BQcSt0YThpOXRY?=
 =?utf-8?B?NGZvNU44WUxJNXlvdXFBVDhwRHRCK2JjbmVOeHpsa0V5UVpLM3BPdXVPNTVr?=
 =?utf-8?B?SWxUK0RXbXpyQ29jeEJvdmttbC96R1VhaEJhMnpCYnNVa2JnVTIvMSsySjlj?=
 =?utf-8?B?MDNHZjFZcDZPUkFBellnQmpxYnBVeURuc3pNYmNnZXpzcE4yREFhb2tPQ1BC?=
 =?utf-8?B?RGU4Sk1CWEpTN0lCUHRwUnFXTkcwaG1LT3pNR1F0bFF5dWdQUVU1T1gxaFVB?=
 =?utf-8?B?TXkyT1paNTR6dFZHTWM5dG43c2pML2t4MlBnYktVQmhmaUM5aGk5SlU0bUtE?=
 =?utf-8?B?dTdNYi9RUUVNUmYzY0FMZWdRTjBocFVsc2NWZWt1d0JBcUtKV3lMYWVmWTBS?=
 =?utf-8?B?eFc3MHZQUGFIN2h5QXdwNWF2d0k1am5mZFphWjUvWVA5UDRlTFpkQmZLMzFI?=
 =?utf-8?B?b0dyT0VlRkFxdE5oKzZqYm5OcTRVNkNta21raVdMRlA4ZGNPVFFnNXE3VjBi?=
 =?utf-8?B?dW1oSDNzNDFSSWxrdWJ6MkJSZHVrUG96MWJKMm9ZMFEzcDNYckR4Q0hLWWI4?=
 =?utf-8?B?bVpDMFZoS3grSTFrclI4R0Z4b21pWVltMERSVVlZYzJKWnB0WnZaZWwrVVhk?=
 =?utf-8?B?ekwzVDhQS1FCZ0tzNm9rWUM1WFpmSjJSYzhJbDBQUlQ5YUZLV2lvZkFWL0k1?=
 =?utf-8?B?VXhwL3REYUp4MGpMWm9WNzFxTjhxTnA3SUxiNjBObHNtL3FNSmN3bVhOUmRB?=
 =?utf-8?B?ZDF1VWhCRnV1NVZVNERRM1BTTWx3b1Q5Ym16aXBNMDdZMWxJNDRmbVFZYlhl?=
 =?utf-8?B?SmxScjg4Y3R0Myt6bXpGek01TGZnQ0tyd2FweHI3Um56SWU3SSsxdVovS0wy?=
 =?utf-8?B?ckJ4OU55SzdIKzRPL3FZQVpBM2NkRjVoZFpVWE9VMWNGSXQ1c2x1TllSbVFj?=
 =?utf-8?Q?vF0ma2TAPJSfv18Ozm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 551f8c18-c698-4b40-8c42-08de83cb1a0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 02:15:47.1606 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oLZbAEZm/6iyBQoi6pPEPrtYsQ3LoSrLTZmnGBjK+aoBnYSZ0JuvFWbBF4rethMO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF5EA4322E1
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

W1B1YmxpY10NCg0KV2UgbWlnaHQgd2FudCB0byBhZGQgYSBUT0RPIHRhZyBhcm91bmQgdGhlIFRM
QiBmZW5jZSBjcmVhdGlvbiB0byB0cmFjayBhIGZvbGxvdy11cCBjaGVjayBmcm9tIHRoZSBLSVEv
TUVTIHNpZGUuDQoNCldpdGggaXQgb3Igbm90LCB0aGUgcGF0Y2ggaXMNClJldmlld2VkLWJ5OiBQ
cmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCg0KUmVnYXJkcywNCiAgICAgIFByaWtl
DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDE2LCAyMDI2
IDExOjE3IFBNDQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1
Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJp
c3RpYW4NCj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IExpYW5nLCBQcmlrZSA8UHJpa2Uu
TGlhbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1OiByZXdvcmsgaG93
IHdlIGhhbmRsZSBUTEIgZmVuY2VzDQo+DQo+IEFkZCBhIG5ldyBWTSBmbGFnIHRvIGluZGljYXRl
IHdoZXRoZXIgb3Igbm90IHdlIG5lZWQgYSBUTEIgZmVuY2UuICBVc2VycXMgKEtGRCBvcg0KPiBL
R0QpIHJlcXVpcmUgYSBUTEIgZmVuY2UuDQo+IEEgVExCIGZlbmNlIGlzIG5vdCBzdHJpY3RseSBy
ZXF1aXJlZCBmb3Iga2VybmVsIHF1ZXVlcywgYnV0IGl0IHNob3VsZG4ndCBodXJ0LiAgVGhhdCBz
YWlkLA0KPiBlbmFibGluZyB0aGlzIHVuY29uZGl0aW9uYWxseSBzaG91bGQgYmUgZmluZSwgYnV0
IGl0IHNlZW1zIHRvIHRpY2tsZSBzb21lIGlzc3VlcyBpbg0KPiBLSVEvTUVTLiAgT25seSBlbmFi
bGUgdGhlbSBmb3IgS0ZELCBvciB3aGVuIEtHRCB1c2VycSBxdWV1ZXMgYXJlIGVuYWJsZWQNCj4g
KGN1cnJlbnRseSB2aWEgbW9kdWxlIHBhcmFtZXRlcikuDQo+DQo+IENsb3NlczogaHR0cHM6Ly9n
aXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvNDc5OA0KPiBDbG9zZXM6IGh0
dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0vYW1kLy0vaXNzdWVzLzQ3NDkNCj4gRml4
ZXM6IGYzODU0ZTA0YjcwOCAoImRybS9hbWRncHU6IGF0dGFjaCB0bGIgZmVuY2UgdG8gdGhlIFBU
cyB1cGRhdGUiKQ0KPiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPg0KPiBDYzogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDQgKysrLQ0KPiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaCB8IDIgKysNCj4gIDIgZmlsZXMgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+IGluZGV4IGI4OTAxM2E2YWEwYjYuLjQ5NzQ2NGY1
MGVhN2QgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+IEBA
IC0xMDQxLDcgKzEwNDEsNyBAQCBhbWRncHVfdm1fdGxiX2ZsdXNoKHN0cnVjdA0KPiBhbWRncHVf
dm1fdXBkYXRlX3BhcmFtcyAqcGFyYW1zLA0KPiAgICAgICB9DQo+DQo+ICAgICAgIC8qIFByZXBh
cmUgYSBUTEIgZmx1c2ggZmVuY2UgdG8gYmUgYXR0YWNoZWQgdG8gUFRzICovDQo+IC0gICAgIGlm
ICghcGFyYW1zLT51bmxvY2tlZCkgew0KPiArICAgICBpZiAoIXBhcmFtcy0+dW5sb2NrZWQgJiYg
dm0tPm5lZWRfdGxiX2ZlbmNlKSB7DQo+ICAgICAgICAgICAgICAgYW1kZ3B1X3ZtX3RsYl9mZW5j
ZV9jcmVhdGUocGFyYW1zLT5hZGV2LCB2bSwgZmVuY2UpOw0KPg0KPiAgICAgICAgICAgICAgIC8q
IE1ha2VzIHN1cmUgbm8gUEQvUFQgaXMgZnJlZWQgYmVmb3JlIHRoZSBmbHVzaCAqLyBAQCAtMjU3
Myw2DQo+ICsyNTczLDcgQEAgaW50IGFtZGdwdV92bV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X3ZtDQo+ICp2bSwNCj4gICAgICAgdHRtX2xydV9idWxrX21v
dmVfaW5pdCgmdm0tPmxydV9idWxrX21vdmUpOw0KPg0KPiAgICAgICB2bS0+aXNfY29tcHV0ZV9j
b250ZXh0ID0gZmFsc2U7DQo+ICsgICAgIHZtLT5uZWVkX3RsYl9mZW5jZSA9IGFtZGdwdV91c2Vy
cV9lbmFibGVkKCZhZGV2LT5kZGV2KTsNCj4NCj4gICAgICAgdm0tPnVzZV9jcHVfZm9yX3VwZGF0
ZSA9ICEhKGFkZXYtPnZtX21hbmFnZXIudm1fdXBkYXRlX21vZGUgJg0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgQU1ER1BVX1ZNX1VTRV9DUFVfRk9SX0dGWCk7DQo+IEBAIC0y
NzEwLDYgKzI3MTEsNyBAQCBpbnQgYW1kZ3B1X3ZtX21ha2VfY29tcHV0ZShzdHJ1Y3QgYW1kZ3B1
X2RldmljZQ0KPiAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0pDQo+ICAgICAgIGRtYV9mZW5j
ZV9wdXQodm0tPmxhc3RfdXBkYXRlKTsNCj4gICAgICAgdm0tPmxhc3RfdXBkYXRlID0gZG1hX2Zl
bmNlX2dldF9zdHViKCk7DQo+ICAgICAgIHZtLT5pc19jb21wdXRlX2NvbnRleHQgPSB0cnVlOw0K
PiArICAgICB2bS0+bmVlZF90bGJfZmVuY2UgPSB0cnVlOw0KPg0KPiAgdW5yZXNlcnZlX2JvOg0K
PiAgICAgICBhbWRncHVfYm9fdW5yZXNlcnZlKHZtLT5yb290LmJvKTsNCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oDQo+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmgNCj4gaW5kZXggYWU5NDQ5ZDViMDBjZC4uMjVkMTc2
ZDEzNTBlZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmgNCj4g
QEAgLTQ0NCw2ICs0NDQsOCBAQCBzdHJ1Y3QgYW1kZ3B1X3ZtIHsNCj4gICAgICAgc3RydWN0IHR0
bV9scnVfYnVsa19tb3ZlIGxydV9idWxrX21vdmU7DQo+ICAgICAgIC8qIEZsYWcgdG8gaW5kaWNh
dGUgaWYgVk0gaXMgdXNlZCBmb3IgY29tcHV0ZSAqLw0KPiAgICAgICBib29sICAgICAgICAgICAg
ICAgICAgICBpc19jb21wdXRlX2NvbnRleHQ7DQo+ICsgICAgIC8qIEZsYWcgdG8gaW5kaWNhdGUg
aWYgVk0gbmVlZHMgYSBUTEIgZmVuY2UgKEtGRCBvciBLR0QpICovDQo+ICsgICAgIGJvb2wgICAg
ICAgICAgICAgICAgICAgIG5lZWRfdGxiX2ZlbmNlOw0KPg0KPiAgICAgICAvKiBNZW1vcnkgcGFy
dGl0aW9uIG51bWJlciwgLTEgbWVhbnMgYW55IHBhcnRpdGlvbiAqLw0KPiAgICAgICBpbnQ4X3Qg
ICAgICAgICAgICAgICAgICBtZW1faWQ7DQo+IC0tDQo+IDIuNTMuMA0KDQo=
