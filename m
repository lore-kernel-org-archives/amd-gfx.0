Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 597ACC4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 05:19:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E950F10E081;
	Thu, 18 Jan 2024 05:19:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CC9910E081
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 05:19:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmqbFNys3HzxaUlFR5UZt6yE0RriqHhlU+yqPGBqlE8XUlcj/tzHbqjihs1nSMQUjKTZJul2Fu/EKa5CCze1pVoQkBIvcQXF7LJPG52k2uDB/yx9XNteJLCi2ydhUN1PYH36emITtJnQm3NdjqmXpvCoXFHVMblzIPB2QjkWTFTuta1MfmpUVsOdQym31oXPEcdPz4/HeV0FSlPS2hCc0S3AN9lI1pfaK6WDNrpXYqwDJNU7gfBVNhOk2AUVY1EP/52HvG/ud7s6dr1Ffaz+86hq2Svajddp+7lQqQnGffm/ukTEIk7ow+uOTuShFeJAw5ffrQk/yyQZ5jGJvn79vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPRZxs3flELwUBdolhI3/3bzS0L+ndpidj9f1ZAoPys=;
 b=Id20tsOz8U2Y0H44jIRAtXUoCpe0rBlPxt+GAshfZ+/UG6nb5bbY5IFLcxGy281Bpxd3ebCccNguUYFyc3v0fURQM4UHcW6rR5pvc4Y9S5IVfrN4u+J0A2QRJWmQYaag7QQAE8cm05MevB0ud04gbggJ8biyxKvLe0NNnqRRDnkoIZcE95tnaE6kXlgSKi/qQGhEG1VGRH/H++lA2tAN6FDz9XxODvMsW0UfAr6sxJkTZWaWmgrWCBl3Xknoc3XmQ78Hg63JoVnixDJZ8tj1yrjhUR+w545f8xmgEPsWFbm3SQKdSp4JQIJz2Lm6cPfHOcWV5E1DTwPErI7pIozZnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPRZxs3flELwUBdolhI3/3bzS0L+ndpidj9f1ZAoPys=;
 b=YvgdSVctXDwbJgb0Ev53itL6gsne9FaqFi+znX7lpBa2OkJK/9oEoFWDx6jOpahASW70pSXM/bA7CoKW2bHe1aAvfBIVXyLHK+xDSmTC1fFAtT14GlO246oofbVU8s2HW03Y+1eNXrTYB1NaSFbJCiPxZvDi4UBVJDocpSzrFek=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SN7PR12MB7132.namprd12.prod.outlook.com (2603:10b6:806:2a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 05:19:06 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790%5]) with mapi id 15.20.7181.029; Thu, 18 Jan 2024
 05:19:06 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: enable amdgpu smu send message log
Thread-Topic: [PATCH] drm/amd/pm: enable amdgpu smu send message log
Thread-Index: AQHaSb49gsit4sRGTEK+SM/ZleI+hrDfBpkAgAABeyA=
Date: Thu, 18 Jan 2024 05:19:06 +0000
Message-ID: <PH7PR12MB59976B3676304A477A471D2382712@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240118032654.1950540-1-kevinyang.wang@amd.com>
 <869ce8c6-cf1a-4747-be92-89b9c14832f0@amd.com>
In-Reply-To: <869ce8c6-cf1a-4747-be92-89b9c14832f0@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=faf9c9c7-90b1-41a1-9ae1-a17edfe5a367;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-18T05:18:34Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SN7PR12MB7132:EE_
x-ms-office365-filtering-correlation-id: bff62f53-85f9-4213-28b1-08dc17e4fe4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M2gHk4Vc07R9Oc3KiNDLsJdG/j2SrztgpQmXJQ7azgJcK3hB4jKVpKtwmh0dp06f42rV8d3uxgMIhpoeyg7ip6rFTcENOaaFdW4EMu8pn1cZPyogvUg3vu+RLfsW17IfsRMj+aPSCFA1NT6VAtb2Swiv+nCdGS1SKKxcCtnl6rALanRZ6/3TgYquGYTc8lrQgzy7iJbnTKanPZlYxc9EWRNW1KY7/asRwd8nXSFwKfmsaEMMMJpBDTABvk0go1ETbZ46JXgaXro1bWMZuIivxeeNfwZG6sKpWgW/K6qZqDF1iGd2zjPcWBZyQeBEBX/EaTOjWOQPxhX50+Y3FLvXxN5hRxnnv0OR/ggy//zoGzHDlJwR4vA9qcb2n8XSPny6AA8iz/fDTlWR+vlD7RoqBSghfKZhZzMyP+MB/WQjXHSHbKpfYZVFPeRE202+hasaC0wVxS7M1iVyR5wcmgC9TxrY4oH1vxk0GO+cR1ZH12mAi674cfmISwk9k+4BjsEuXOAmqMMYd8sdvdKHa8hQ8sXVi9PVheMnS+BVU01RqNP68b6ZeG4Iq1WnNzHqxzYD9HubErsxTDhJXv7ewchdZnNs+iTb43pguuQIcNfWig0Wl8nNlRiTzblqmRMBh0+X
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(83380400001)(9686003)(6506007)(7696005)(53546011)(38100700002)(122000001)(5660300002)(4326008)(8676002)(8936002)(52536014)(15650500001)(2906002)(71200400001)(478600001)(316002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(110136005)(86362001)(33656002)(38070700009)(55016003)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eU9RSHN2RkhrV0dtblo2dFBFZ0lmUDdiUWd1MTd4SEZLNGp5MzZ5MTl1dTRx?=
 =?utf-8?B?RFRyY2JpWUJqSW1oeWFTMVU0TXdsMFZOVHZ5RXFSVms1KzYvWm9wSXNwZCtw?=
 =?utf-8?B?V0xmNjViVGprWnU0T2hsZ1QvbEdtMHpvZktzVDFaTkdvVTN5RzJMTmZtODQ5?=
 =?utf-8?B?YXFscDRYY05TTWZRU2dVSHRvMCtYSzBlRWZwWmF5WmhYeUx3U29INmo2RW1l?=
 =?utf-8?B?SUxMSXBrbFVieWhUMW5XRWFNbTlOQWFZRjlRRWt0dU0vcm4xNUR5NkEwc3VL?=
 =?utf-8?B?MzlXc0xabTZjK0kxQ3VYenl2VEc3VUxPUnhPMFRuNVFacFg0b1FPZEhOMjl4?=
 =?utf-8?B?RHFtVCttS0c5RkdEWjMzTlM1VVkwdEJOakQ3WmhoZEhCNWk4Ym91WGppeEoy?=
 =?utf-8?B?QTEzWkJBRnBNRDJVUnREZzJpaFNFYjZuK21uT2hFS1Z6ZjM4aEo0R2VnbFl3?=
 =?utf-8?B?NVdPanpDMHFudVZKYnZ1TXZGU1l6ekFYVmRjbGhIeE8wM0VTMmpmVjg1NUUz?=
 =?utf-8?B?K2trY050T1RvdEpVTjlHVnJObTVFeitPQnltV0J2Q0dmdTJFQ0xqeFoxY1Fk?=
 =?utf-8?B?TTBhQVRkL0dna2syRFNSY3kwY3M5MVNUb04xUVdqOThMMWp4akZzU3dXU2ls?=
 =?utf-8?B?ajkvcUtYOUJzQWpBZVEyd3hOMmJWOUhvdXM5aGV0S3Y3NVAyb0hTNEVIci9V?=
 =?utf-8?B?cTZnd0d5NHpmZitPQTNmZW1MR3VEbm9EQjAwNmFHZ2pwdnc0bjEwTkowcW5D?=
 =?utf-8?B?WUNZaWVPdjNvZkdieDNlS1UybUJQWVBWQzdISEdHZ0tWSDl4TWtKa2FsRnNT?=
 =?utf-8?B?TzhQTEpodURqcDhVYzFmRGdYTFZrOXdGdy9rTFF3d0RlSEhJV1o4RWhsTkl0?=
 =?utf-8?B?VTkvcjY2bXVOVXJwREdQZERPakRUemFGaE1aVXdDbjBkZDlBUXI1Rm1yM2Qy?=
 =?utf-8?B?blVOaVJFL0tWWUpRc1dVd0Zldk91Y3JpeDhrMkdGZ0JtZ3NoM3R4QytBdXZp?=
 =?utf-8?B?bUxBTkR0Q0F3ZHExSWlhWHN3L3dxNFJJWXBNN0RXMkRQSHZKeHlZamJ5OFZG?=
 =?utf-8?B?Q3VJRU5CcTFSNFZXZUpwcEdZVmFBejJCY0lYTjhYSm1tcmZvU1U5S0xBVGJ4?=
 =?utf-8?B?YzBRV2RCaXkrTWhKNDhnNnA2QzBmQ0pDVzA2RWR2dnpML3E0Q3I3TXZhV0o1?=
 =?utf-8?B?TElJR3VNalc0Y2RkQkRzRHJRUm9JUTJYYlIyaVl3VUFmZVNJQk9Ld0txYmtq?=
 =?utf-8?B?bDRXTUFZTVl5S2hLcHJzL0puV2hvK1FpZ1FsTWxjWnVTQWRUdnpiWGY4c3dt?=
 =?utf-8?B?VU9hVmN3MjEyYTUwcUprUVZUeEc2ek9FVlMyWE5udnNsWnlqT1FhMXpmT3hs?=
 =?utf-8?B?bVlVNnArZWVSK1ZhTnp0NEwrMHB6SjFFVVA2QkxDbnJIa3dVd0UvZCtWSGww?=
 =?utf-8?B?NGVwajVJQUY4WVAwVWdhMFlLS3VzUFBGL3hla1hCVDBWVXZ2VFV4cDc0ZERF?=
 =?utf-8?B?VmEyTHM1ZlhhcHVXaUtpbWQ0VHBsNDhvVVhkL0tQVDgwbStLV09WQTJTK1d3?=
 =?utf-8?B?bnN0MytmT2VMMkVvK29TNkVOOGJNdlBNS0pQSEk0ZUswQ0g1RERnWTVtcVRI?=
 =?utf-8?B?NjEycHRTR3dDYk5ZK042SWx6OUJMRTE1UTQvSG9vZDJ4SDkwVUY5VlRzY1k4?=
 =?utf-8?B?MG5FREU4NnZPd2srYjlISFNsMjNzOWgyYlR2VGhUYXB0VEdwUHNFUUJ1Z2lR?=
 =?utf-8?B?TWJibWlka1hNRmNDWnQ5NWFqT1kzemR4dGZBR2t3T2VlNWtWOHpXQlFHTGNQ?=
 =?utf-8?B?T2hEL2tMSWQyQmt5QjNMc0R3SHhCUWl5R21OVnBJajNlMVN2K0lrN0h0RmxX?=
 =?utf-8?B?WDN4NzVqRUZRNGU5MWxVWDdYYVZPVUloU2RVc21aVXl6K1hZNitoQlB1UWw0?=
 =?utf-8?B?MHk1eS8yUU52V1BGcW9EZmpqWVBwdTNBMTlod3ZUYjhTem9zdTRnQi9tNnlz?=
 =?utf-8?B?ZHZFc1B4Z1hPR2ZyNlhMeDBSWW9VSnlEdEJpNWhoWTNhVW9TczBMRit1SkJL?=
 =?utf-8?B?Sys5cWdnTlRJYmhSZTliK2hkaksxa0tzMThXMGRZWnNPbEdVaWhhdFQzYUVC?=
 =?utf-8?Q?rKSE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff62f53-85f9-4213-28b1-08dc17e4fe4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 05:19:06.5845 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6wfoUGSX6fKZJkqhTI2UfQZXy/GmKqJImlUQyS1DmaC9Yr+7CyqeHL0QFj4DFO0N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7132
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KU2VudDogVGh1
cnNkYXksIEphbnVhcnkgMTgsIDIwMjQgMToxMyBQTQ0KVG86IFdhbmcsIFlhbmcoS2V2aW4pIDxL
ZXZpbllhbmcuV2FuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNj
OiBGZW5nLCBLZW5uZXRoIDxLZW5uZXRoLkZlbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGRybS9hbWQvcG06IGVuYWJsZSBhbWRncHUgc211IHNlbmQgbWVzc2FnZSBsb2cNCg0KT24g
MS8xOC8yMDI0IDg6NTYgQU0sIFlhbmcgV2FuZyB3cm90ZToNCj4gRnJvbTogWWFuZyBXYW5nIDxL
ZXZpbllhbmcuV2FuZ0BhbWQuY29tPg0KPg0KPiBlbmFibGUgYW1kZ3B1IHNtdSBkcml2ZXIgbWVz
c2FnZSBsb2cuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFlhbmcgV2FuZyA8S2V2aW5ZYW5nLldhbmdA
YW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21u
LmMgfCA4ICsrKysrKystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3Nt
dS9zbXVfY21uLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdV9jbW4uYw0KPiBp
bmRleCAwMGNkNjE1YmJjZGMuLmI5YTI0ZmYwMmExMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21uLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9zd3NtdS9zbXVfY21uLmMNCj4gQEAgLTM3OCw4ICszNzgsMTQgQEAgaW50IHNtdV9jbW5f
c2VuZF9zbWNfbXNnX3dpdGhfcGFyYW0oc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsDQo+ICAgICAg
IHJlcyA9IF9fc211X2Ntbl9yZWcyZXJybm8oc211LCByZWcpOw0KPiAgICAgICBpZiAocmVzICE9
IDApDQo+ICAgICAgICAgICAgICAgX19zbXVfY21uX3JlZ19wcmludF9lcnJvcihzbXUsIHJlZywg
aW5kZXgsIHBhcmFtLCBtc2cpOw0KPiAtICAgICBpZiAocmVhZF9hcmcpDQo+ICsgICAgIGlmIChy
ZWFkX2FyZykgew0KPiAgICAgICAgICAgICAgIHNtdV9jbW5fcmVhZF9hcmcoc211LCByZWFkX2Fy
Zyk7DQo+ICsgICAgICAgICAgICAgZGV2X2RiZyhhZGV2LT5kZXYsICJzbXUgc2VuZCBtZXNzYWdl
OiAlcyglZCkgcGFyYW06IDB4JTA4eCwgcmVhZHZhbDogMHglMDh4XG4iLA0KPiArICAgICAgICAg
ICAgICAgICAgICAgc211X2dldF9tZXNzYWdlX25hbWUoc211LCBtc2cpLCBpbmRleCwgcGFyYW0s
ICpyZWFkX2FyZyk7DQo+ICsgICAgIH0gZWxzZSB7DQo+ICsgICAgICAgICAgICAgZGV2X2RiZyhh
ZGV2LT5kZXYsICJzbXUgc2VuZCBtZXNzYWdlOiAlcyglZCkgcGFyYW06IDB4JTA4eFxuIiwNCj4g
KyAgICAgICAgICAgICAgICAgICAgIHNtdV9nZXRfbWVzc2FnZV9uYW1lKHNtdSwgbXNnKSwgaW5k
ZXgsIHBhcmFtKTsNCj4gKyAgICAgfQ0KDQpCZXR0ZXIgdG8gYWRkIHRoZSBleGFjdCByZXNwb25z
ZSByZWcgdmFsdWUgKHJlZyA9DQpfX3NtdV9jbW5fcG9sbF9zdGF0KHNtdSkpIGFsc28gdG8gdGhp
cy4NCg0KVGhhbmtzLA0KTGlqbw0KDQoNCltrZXZpbl06DQpPSywgIHdpbGwgYmUgYWRkZWQgaW4g
bmV4dCB2ZXJzaW9uLg0KDQpCZXN0IFJlZ2FyZHMsDQpLZXZpbg0KPiAgIE91dDoNCj4gICAgICAg
aWYgKHVubGlrZWx5KGFkZXYtPnBtLnNtdV9kZWJ1Z19tYXNrICYgU01VX0RFQlVHX0hBTFRfT05f
RVJST1IpICYmIHJlcykgew0KPiAgICAgICAgICAgICAgIGFtZGdwdV9kZXZpY2VfaGFsdChhZGV2
KTsNCg0K
