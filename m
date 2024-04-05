Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0CEC67861
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Apr 2024 15:26:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A276A113C49;
	Fri,  5 Apr 2024 15:26:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A117Upor";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2113.outbound.protection.outlook.com [40.107.220.113])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15965113C49
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Apr 2024 15:26:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmGtcqwhFLJum1jmnh6gS4nT5JINkkLKle3rDMu4zs+xeE6jYfolsbU/IOu3uL7OkTaMuiCP5ph+k9cky3DLoPNOgiAlnVrnY85GB1jDK3ZWCMIxhxUaKZwqaVAGVR6lQsJRLoYFjXRfR2HogW3Xgc5KoO9QOJpctuQJf7h7R3uTu2WHQ2Hn+g7NdKlNnJjKarsXpuTELjSOFFkgYwjCPbjifKzqm9hKRiDZbpaEiMlqXJV3EQdBqg32YdQl4FC9j7dfLOqfn6JjQ8fdFWfrM7KU7EXjgB/TUDJeaAw3S/heoalSbFIKVRg+eKGEbaIVu/X/5KX7XrSbj1AgaZV4kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFhkeLrZUw/+XErKQlWkP6Jv5ycz2tqRz9sSwJlDcVE=;
 b=ePnhQjbEp0DY0TJasOsdzBGfU0mNKr2eR+RZLFwIkJjUZR20v5MX9sklyNJueUn7lJkhCsxG7MSUvUQqwDHmoRBj/2+FqdEmsJvoSLeCd6DUJB/usJJz4FIkigTR+g+6vx1Ab9OgFPuPNzjrw4Gp6wHBTthN6KqHkzxBsBPcGe9uFAPlL1Pjp5QFzRJ6G6neSKEzPu2VljdUZ4Gbx5BXAkUr8MAyOMgAayXqlpDTCbiGI46DODMFd6NcNFt3IvzrCdZbHMw3gvaSXMEd/rSTOzQsO5e6stab6e3UYpQynKBYR5ALaFD4Ggb0xiDw6lFpan7sotGBJPZVOZ3MZLqwKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFhkeLrZUw/+XErKQlWkP6Jv5ycz2tqRz9sSwJlDcVE=;
 b=A117UporsElHsIN2e+qdgt0lYUKnrWoozWPiqkcCD73D0gFA+Yp/GKloMex6iFjwE4hHJcAs5IKjeI19otj98eQcBgEGFngi4ug7ENQwBLb0Mk1fCrtcuijZALTzLqpVYlF+CDN1A+2yBYV3ptM+EzISNRi6tItLlqHBwoSlqwc=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 15:26:27 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::7451:c058:bf5a:aa26]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::7451:c058:bf5a:aa26%6]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 15:26:27 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Sharma, Shashank" <Shashank.Sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Sharma, Shashank" <Shashank.Sharma@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Yadav, Arvind" <Arvind.Yadav@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix MES HQD masks
Thread-Topic: [PATCH] drm/amdgpu: fix MES HQD masks
Thread-Index: AQHah2a3haoH0EOAF0CHp/bcNQ9/X7FZwCEw
Date: Fri, 5 Apr 2024 15:26:27 +0000
Message-ID: <BL3PR12MB6425A4F95DE5309A5C9FB6D3EE032@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20240405143616.704-1-shashank.sharma@amd.com>
In-Reply-To: <20240405143616.704-1-shashank.sharma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=158cf44e-e5ec-486b-829b-614c7d4f7742;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-05T14:42:21Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|MN0PR12MB5714:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h8+C0y2RkfqLeB9VVM//5jJeLt6Oy7ppRfnp09WoUttMTG1wrWOKkX/xCiM//znXG3JupR4PVmtR3lXAsmciR8LDrAePMqrcFN4DU9ciQ7g4XV5P0g1odkTkFcsOP03fNAFuP1UUwr/ovN4cEGBjcAbeGoxFPlhhvDBsPBFiCGZmAZOe/5PBBG/vP95Ew1h8tJkldUO48+vT9APEmeFdbsZ5Xf2nMfM6P//z1WpM+EYrxcnujmIPsH9gbqqUDul/eeuztMrLgEVM/pB9bTAFQ4mQIvgr46j3Ba0I1wlkUGqZLXPxf+tLniiZIOlxuGt8mlfUdEaKPDgQbJCvF+KuKcQiBHnOCmXZ8dqxyYM6RGaWsDb4aKXhsRrVdFLWlmVweG4Ba64Iz7kPqN6dx9wd9qUqKb5dPmgABfsqmxsHeNg/FcMVDHdfqor0f6QZESwqXxBFrJN7tNAHXw5h/1avKrMMFitBNLYh/XnBnpwPbh+c3CAXaEp50xhZi1m1HCcImm/HeZTDUU/2kStl9D1DDw/uhnqq6+hdRovH9hMr43SAcH5ZJ3C4npxVi+g6nO0+TGqGsBkeKL/mNkzYs8IFOFUuui/Toy180L4PLGJwrJEdzKeRm5EmUe693eOFQIb8qskKqb53yqcmjtniwcFvkcmPIPds2by+3a0ROQKKSCo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXg0L2ZGOHpKcUJZMFloclorQVoyUmRCTlJReElJdFRuaW9PcG5lVHg0endE?=
 =?utf-8?B?OUdvV09QNkpKem1kYWUvRDl0a2hRMjlvS0g2SWtqdFN0Uk9PaTJFbXo2MENC?=
 =?utf-8?B?U1RLOUEzTXkrb04wTUVpZkZBL1o5NE4vdXhMNkVNZWRTeGZDc2RLNU9mSWl3?=
 =?utf-8?B?NVV5YTU4TzVaTlU0ci8rMzZjNXo3WGRGUnFYdC9HUTMrTTNGWW1hZFV0cTUy?=
 =?utf-8?B?alJ5NWNlY1dDL3lUQS9uZGhNb2xDZUQ3Sm9VVVg1UHMxeDN4bGhrRFZ6RzM5?=
 =?utf-8?B?K0ozckJwZGthOUlSU0E4MEdEaGRRNXNTY2pSN2NDeUltWnFrdE50YVdyejU4?=
 =?utf-8?B?enlmcDR5V2FJbW11OUlHWkRjLzZsSnhUNFZPQlRxUmhwVVdVNDUwNHdHd1Zw?=
 =?utf-8?B?WndQUG5WVWlLYmpNYVZPajlRZ2xWS2dCR3hwYzN6Z3FYcDZyTGYyVmc1UWNW?=
 =?utf-8?B?Q3VXVWQ5RGlrUmQrVmxrTUNWdzF6djEzSnVPQ1N3NWhTUVYyNmxFTGwzcHdW?=
 =?utf-8?B?M1M0YjE4RDk2eExiKzBNeUhiZ29TaUREQzBNOFBubnFSYVMxbG9zZ2YrVFFF?=
 =?utf-8?B?dkpYM0JzUm5mOGZUNm1KWFc3VnRaUDBKL0xPcXE5RUErMStTZkpjczNvVzB0?=
 =?utf-8?B?Slhacjdhd0c3eGxidHdQZlg1NlJxelVLRzZLbDRFU1BuR2twZHdlRGZleEoy?=
 =?utf-8?B?akVNeDI0MVNnYWZoNm5TdE11L01zMjhNZjZvUUZuVmxiUm81a2c5SXJ6SWdl?=
 =?utf-8?B?cm5wem9uMTRsY2hZWjFFbUlGS2E0MDQwOTdYQ01sREVPcnVUUHlNM01uRVhk?=
 =?utf-8?B?S21RZlFtWDFHaTNHZ0UvNjl4RzNRTzBrOXVsbU5HWjM1QXZYM0xXS3ZuQjFi?=
 =?utf-8?B?NXBZdGlKRjR3UTYydHh3S0Ezd0dNV3EvZlljRS92YzVINy9lM0wzcGpCcEQ3?=
 =?utf-8?B?VDlZN2l4ZTVjYkRpeFlkMW4wVS82SE1NWStQenhNaTgxdkd2M2NIVGFubGZh?=
 =?utf-8?B?K05IT1J6S2syQzlUS2l4cW40b29mWFBQcmVXY2JmQTZ0M2tUQ01pYWtCaGlM?=
 =?utf-8?B?Q3JWZkFhaTlOQjlSdkhnNW5PbzZTOXl4bVRxWWdzS1N0T2lQVTRHMSt6c3lJ?=
 =?utf-8?B?US9HciswM2pLTWZjNU5aMGRmVUhZWGlhTktCRGhncE05ay9JWU5JVFBhUDdQ?=
 =?utf-8?B?U3lZbEV0N3Z1Nmp4UzJVcFMwTUVSeUkxRVZjeEFpOVNaV0cxNGhKTVo0enBR?=
 =?utf-8?B?eEtNdGhnL2lIWEx0ejVCMFZMVmxRa3FWTXVtT3d1NWkvVzJtSG9sV083SFRQ?=
 =?utf-8?B?TjIxeUdpUkt4T1lBNnRrdzJScTBCOFI5ZXZxcTZieVBvU3V3MzRKNHIyTlE2?=
 =?utf-8?B?ZmQ2NmNNTG96elhoK2hOL2wyNmg1dUM4U3lhYlVwSVdyWTJnN1llMlJJcTZW?=
 =?utf-8?B?a3NBcmIzbmdBYWdTVUpsVVpuelBuVnpYSE5BU2RvUmMwSE51ZkdzSyttQk1H?=
 =?utf-8?B?OGtNeXFOTnRlaVVSN2syZzBQVk1tN1FKejErNE51ZU16Nm5hNHVBQjMxelFK?=
 =?utf-8?B?ck9GcThrYkRuZmFOZ3ZaUHNuQVA1ZmowNzhMZGQySGtzTUlqMlJUMnlzVWJG?=
 =?utf-8?B?eGtzellBOUJBL3A5UnF6R2tEby92c2ZJYnczNkRiWk45YjFZbFNUVkV0aWx1?=
 =?utf-8?B?dmNRa3puUFVrSFFsa3RrTnYydTRDbGw2Ky8vS25tSXByaFBsT1o1Z3RRNzYz?=
 =?utf-8?B?QXpWbUYrbTViSDZ6Tmw2VTlLZFlGUlRTc21kL2FreXVLa3Y2Wnp3V0VlK0wx?=
 =?utf-8?B?YytsL2ZwWTE4Q0FMSXY0bmdVbDgwYWl5VTdVbkVnRGhpUnAvM3IyM1hNYVF1?=
 =?utf-8?B?akNwbmxIMVpxemc4U05JUVRabktZMHZYL3UwdVdxZkJGSkZ4dHYzNVNJODh5?=
 =?utf-8?B?UmsvT3Fib2toL0J5SHRQSVJBRmxlRTNtWDBZQW8rbXkzVjNrWGdvTkYzRllH?=
 =?utf-8?B?RllubTZUZ1A1bUhocHJDc3hCdnJnZHFaNHNMNlZQdmxWWVduV2hEdkdvN0V5?=
 =?utf-8?B?TUdaR1VJWm9pSXRQeHBkKzlGMnZsQWNRZmZlUXcyaGRhcHpTWTlaZTh0OHNB?=
 =?utf-8?Q?CFuk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 687a1ab2-ee7d-41e2-204c-08dc5584c31b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 15:26:27.6714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+nlpULXR0Wx/yU4BPvhNRB3qWNcIzjFylba7WYkNMJl2R1Pq7uR50JNKX6sSfKLeemrFPo6rD8L28XSpxsiCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZz4gT24gQmVoYWxmIE9mDQo+IFNoYXNoYW5rIFNoYXJtYQ0KPiBTZW50OiBGcmlkYXks
IEFwcmlsIDUsIDIwMjQgMTA6MzYgQU0NCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQo+IENjOiBTaGFybWEsIFNoYXNoYW5rIDxTaGFzaGFuay5TaGFybWFAYW1kLmNvbT47IEtv
ZW5pZywgQ2hyaXN0aWFuDQo+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBEZXVjaGVyLCBB
bGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBZYWRhdiwgQXJ2aW5kIDxB
cnZpbmQuWWFkYXZAYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1OiBmaXgg
TUVTIEhRRCBtYXNrcw0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9t
IGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9uDQo+IHdoZW4gb3BlbmluZyBh
dHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+DQo+DQo+IFRoaXMg
cGF0Y2ggZml4ZXMgdGhlIGV4aXN0aW5nIEhRRCBtYXNrcyBwcmVwYXJlZCBkdXJpbmcgdGhlIE1F
UyBpbml0aWFsaXphdGlvbi4NCj4gVGhlc2UgZXhpc3RpbmcgbWFza3MgdmFsdWVzIHdlcmUgY2F1
c2luZyBwcm9ibGVtcyB3aGVuIHdlIHRyeSB0byBlbmFibGUgR0ZYDQo+IG92ZXJzdWJzY3JpcHRp
b24uDQo+DQo+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+
DQo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IFNpZ25l
ZC1vZmYtYnk6IFNoYXNoYW5rIFNoYXJtYSA8c2hhc2hhbmsuc2hhcm1hQGFtZC5jb20+DQo+IFNp
Z25lZC1vZmYtYnk6IEFydmluZCBZYWRhdiA8YXJ2aW5kLnlhZGF2QGFtZC5jb20+DQo+IC0tLQ0K
PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21lcy5jIHwgIDMgLS0tDQo+IGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTBfMS5jICB8IDE1ICsrKysrKysrKysrKysr
LQ0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjExXzAuYyAgfCAxNSArKysrKysr
KysrKysrKy0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9tZXMuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tZXMuYw0KPiBp
bmRleCBkYTQ4YjZkYTAxMDcuLjdkYjgwZmZkYTMzZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21lcy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9tZXMuYw0KPiBAQCAtMTQ4LDkgKzE0OCw2IEBAIGludCBhbWRncHVf
bWVzX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAgICAgICAgICAgICAgICBh
ZGV2LT5tZXMuY29tcHV0ZV9ocWRfbWFza1tpXSA9IDB4YzsNCj4gICAgICAgICB9DQo+DQo+IC0g
ICAgICAgZm9yIChpID0gMDsgaSA8IEFNREdQVV9NRVNfTUFYX0dGWF9QSVBFUzsgaSsrKQ0KPiAt
ICAgICAgICAgICAgICAgYWRldi0+bWVzLmdmeF9ocWRfbWFza1tpXSA9IGkgPyAwIDogMHhmZmZm
ZmZmZTsNCj4gLQ0KPiAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBBTURHUFVfTUVTX01BWF9TRE1B
X1BJUEVTOyBpKyspIHsNCj4gICAgICAgICAgICAgICAgIGlmIChhbWRncHVfaXBfdmVyc2lvbihh
ZGV2LCBTRE1BMF9IV0lQLCAwKSA8DQo+ICAgICAgICAgICAgICAgICAgICAgSVBfVkVSU0lPTig2
LCAwLCAwKSkgZGlmZiAtLWdpdA0KPiBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192
MTBfMS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMF8xLmMNCj4gaW5k
ZXggMWU1YWQxZTA4ZDJhLi45MjE3OTE0ZjgyNGQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L21lc192MTBfMS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L21lc192MTBfMS5jDQo+IEBAIC0yNjYsNiArMjY2LDE5IEBAIHN0YXRpYyBpbnQgbWVz
X3YxMF8xX3F1ZXJ5X3NjaGVkX3N0YXR1cyhzdHJ1Y3QNCj4gYW1kZ3B1X21lcyAqbWVzKQ0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICBvZmZzZXRvZih1bmlvbiBNRVNBUElfX1FVRVJZX01FU19T
VEFUVVMsIGFwaV9zdGF0dXMpKTsgIH0NCj4NCj4gK3N0YXRpYyBpbmxpbmUgdWludDMyX3QgbWVz
X3YxMF9nZXRfZ2Z4X2hxZF9tYXNrKGludCBwaXBlX2luZGV4KSB7DQo+ICsgICAgICAgLyogUGlw
ZSAxIGNhbid0IGJlIHVzZWQgZm9yIE1FUyBkdWUgdG8gSFcgbGltaXRhdGlvbiAqLw0KPiArICAg
ICAgIGlmIChwaXBlX2luZGV4ID09IDEpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4g
Kw0KPiArICAgICAgIC8qDQo+ICsgICAgICAgICogR0ZYIFYxMCBzdXBwb3J0cyAyIHF1ZXVlcywg
YnV0IHdlIHdhbnQgdG8ga2VlcCBxdWV1ZSAwDQo+ICsgICAgICAgICogcmVzZXJ2ZWQgZm9yIGtl
cm5lbCwgc28gZW5hYmxlIG9ubHkgcXVldWUgMSAoMTw8MSkgZm9yIE1FUy4NCj4gKyAgICAgICAg
Ki8NCj4gKyAgICAgICByZXR1cm4gMHgyOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW50IG1lc192
MTBfMV9zZXRfaHdfcmVzb3VyY2VzKHN0cnVjdCBhbWRncHVfbWVzICptZXMpICB7DQo+ICAgICAg
ICAgaW50IGk7DQo+IEBAIC0yOTEsNyArMzA0LDcgQEAgc3RhdGljIGludCBtZXNfdjEwXzFfc2V0
X2h3X3Jlc291cmNlcyhzdHJ1Y3QNCj4gYW1kZ3B1X21lcyAqbWVzKQ0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICBtZXMtPmNvbXB1dGVfaHFkX21hc2tbaV07DQo+DQo+ICAgICAgICAgZm9yIChp
ID0gMDsgaSA8IE1BWF9HRlhfUElQRVM7IGkrKykNCj4gLSAgICAgICAgICAgICAgIG1lc19zZXRf
aHdfcmVzX3BrdC5nZnhfaHFkX21hc2tbaV0gPSBtZXMtPmdmeF9ocWRfbWFza1tpXTsNCj4gKyAg
ICAgICAgICAgICAgIG1lc19zZXRfaHdfcmVzX3BrdC5nZnhfaHFkX21hc2tbaV0gPQ0KPiArIG1l
c192MTBfZ2V0X2dmeF9ocWRfbWFzayhpKTsNCj4NCj4gICAgICAgICBmb3IgKGkgPSAwOyBpIDwg
TUFYX1NETUFfUElQRVM7IGkrKykNCj4gICAgICAgICAgICAgICAgIG1lc19zZXRfaHdfcmVzX3Br
dC5zZG1hX2hxZF9tYXNrW2ldID0gbWVzLT5zZG1hX2hxZF9tYXNrW2ldOw0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMV8wLmMNCj4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9tZXNfdjExXzAuYw0KPiBpbmRleCAyNmQ3MWEyMjM5NWQuLmI3ZGNk
OTM2YWZjOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3Yx
MV8wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMV8wLmMNCj4g
QEAgLTM2MCw2ICszNjAsMTkgQEAgc3RhdGljIGludCBtZXNfdjExXzBfbWlzY19vcChzdHJ1Y3Qg
YW1kZ3B1X21lcw0KPiAqbWVzLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBvZmZzZXRvZih1
bmlvbiBNRVNBUElfX01JU0MsIGFwaV9zdGF0dXMpKTsgIH0NCj4NCj4gK3N0YXRpYyBpbmxpbmUg
dWludDMyX3QgbWVzX3YxMV9nZXRfZ2Z4X2hxZF9tYXNrKGludCBwaXBlX2luZGV4KSB7DQo+ICsg
ICAgICAgLyogUGlwZSAxIGNhbid0IGJlIHVzZWQgZm9yIE1FUyBkdWUgdG8gSFcgbGltaXRhdGlv
biAqLw0KPiArICAgICAgIGlmIChwaXBlX2luZGV4ID09IDEpDQo+ICsgICAgICAgICAgICAgICBy
ZXR1cm4gMDsNCj4gKw0KPiArICAgICAgIC8qDQo+ICsgICAgICAgICogR0ZYIFYxMCBzdXBwb3J0
cyAyIHF1ZXVlcywgYnV0IHdlIHdhbnQgdG8ga2VlcCBxdWV1ZSAwDQo+ICsgICAgICAgICogcmVz
ZXJ2ZWQgZm9yIGtlcm5lbCwgc28gZW5hYmxlIG9ubHkgcXVldWUgMSAoMTw8MSkgZm9yIE1FUy4N
Cj4gKyAgICAgICAgKi8NCj4gKyAgICAgICByZXR1cm4gMHgyOw0KPiArfQ0KDQpUaGVyZSBpcyBu
byBkaWZmZXJlbmNlIGJldHdlZW4gdGhpcyBmdW5jdGlvbiBhbmQgdGhlIGNvcnJlc3BvbmRpbmcg
ZnVuY3Rpb24gd3JpdHRlbiBmb3IgR0ZYMTAuDQpXaHkgbm90IG1ha2UgdGhpcyBhIGNvbW1vbiBm
dW5jdGlvbiBpbnN0ZWFkPw0KDQpSZWdhcmRzLA0KTXVrdWwNCg0KPiArDQo+ICBzdGF0aWMgaW50
IG1lc192MTFfMF9zZXRfaHdfcmVzb3VyY2VzKHN0cnVjdCBhbWRncHVfbWVzICptZXMpICB7DQo+
ICAgICAgICAgaW50IGk7DQo+IEBAIC0zODUsNyArMzk4LDcgQEAgc3RhdGljIGludCBtZXNfdjEx
XzBfc2V0X2h3X3Jlc291cmNlcyhzdHJ1Y3QNCj4gYW1kZ3B1X21lcyAqbWVzKQ0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICBtZXMtPmNvbXB1dGVfaHFkX21hc2tbaV07DQo+DQo+ICAgICAgICAg
Zm9yIChpID0gMDsgaSA8IE1BWF9HRlhfUElQRVM7IGkrKykNCj4gLSAgICAgICAgICAgICAgIG1l
c19zZXRfaHdfcmVzX3BrdC5nZnhfaHFkX21hc2tbaV0gPSBtZXMtPmdmeF9ocWRfbWFza1tpXTsN
Cj4gKyAgICAgICAgICAgICAgIG1lc19zZXRfaHdfcmVzX3BrdC5nZnhfaHFkX21hc2tbaV0gPQ0K
PiArIG1lc192MTFfZ2V0X2dmeF9ocWRfbWFzayhpKTsNCj4NCj4gICAgICAgICBmb3IgKGkgPSAw
OyBpIDwgTUFYX1NETUFfUElQRVM7IGkrKykNCj4gICAgICAgICAgICAgICAgIG1lc19zZXRfaHdf
cmVzX3BrdC5zZG1hX2hxZF9tYXNrW2ldID0gbWVzLT5zZG1hX2hxZF9tYXNrW2ldOw0KPiAtLQ0K
PiAyLjQzLjINCg0K
