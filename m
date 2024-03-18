Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D98C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 04:45:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E58D10F231;
	Mon, 18 Mar 2024 04:45:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IyhQG4N0";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1D7A10F231
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 04:45:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klCgjuk0yur9IHpeAGR+/Dn+GEAL7W1zwX/EDM3A8JbVt3HgxXjo8U7OtwBUmCsxV/DLJLQpw51zHiBOAqVv/zO1XwBu5PWnnoquXih9EvwMY5t2K08U2/6QfaIL6kyzjYqkoI5oOI2u2C8+bXLYYFQ7BqBIBeM/aHm5rBKNje89EAuYBKFlrd8Ez07VHOdHwwj3wa3zm8ZzkEt5F+WoKBNa3897u/NbFe2ZW5K8XeK7erYaoYnSM5X7q3RGn4KU1Hrq1Uq4hU5HlfXpq2C63reixduCLc4Tj4bVI0TkDyIxFAb1w4pkd6FAI2VFE/U4ZfFgMqP/HbC2z8GORGjYMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUJlKkdx+sg5ZuUl9F6JCa7gOnVp1z7DeNGQ1O6a2LQ=;
 b=lnM4MYAuB5kes5U/QTNrQJuE+lFl3jV1yzw1TxP0oiyKO6PnnvZimOxnlwMnzL9woD/I3avwQwww/TrFuWVVVfGAFzbx9P/ORACFYxwSb0Dw7g9+XG9/5uam4N/QQ9c+z4zojpLN0Uo11Z8WKhAaWXAoH2fYEcPa53r6gcl9cTbg+dBJOt2T+GYesBtgwB+KIe8BGg6BL1u9PzKXagx9fn8Fw3KH2v4q3lqh+M7UQcV2xajs1Uk8OE0lr7xUM1Iey4oWOyOt1n+r58VifG9bIWdD55fsnwHRNQSNEjAft4V3dGmX8XTtDkxoLwo77ioxWDSLd+mc1UqiygvaCTCFDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUJlKkdx+sg5ZuUl9F6JCa7gOnVp1z7DeNGQ1O6a2LQ=;
 b=IyhQG4N0oG8DwOG7+90hgD4wnKxsMkl5b1TxhZ7OvNBtAQf21ao3fT6XBQaaaXJ+fu+IUMsVRcffn9crCaD7pOOpQJC++1TPOxCbcU8rX2La/BaSSIvVVcGt1nnEOTWE+hHVWM5VBqphwvHfB8GmGQpiGZwrnEtDaDw3dyM3YRg=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB5658.namprd12.prod.outlook.com (2603:10b6:806:235::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.27; Mon, 18 Mar 2024 04:45:42 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 04:45:42 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix truncation issues in
 smu_v13_0_init_microcode
Thread-Topic: [PATCH] drm/amdgpu: Fix truncation issues in
 smu_v13_0_init_microcode
Thread-Index: AQHad8IM5l+CXTvnRUifhdps5+Kp6bE87XNQ
Date: Mon, 18 Mar 2024 04:45:42 +0000
Message-ID: <DS0PR12MB78046A36A87A4DA09B833ED1972D2@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20240316165010.1378112-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240316165010.1378112-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=32e5209b-b6eb-406f-a766-02d605cb8086;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-03-18T04:41:18Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|SA1PR12MB5658:EE_
x-ms-office365-filtering-correlation-id: eeba12b8-c089-4f8c-c7a0-08dc4706449c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s7XwY7Du0UlTVqrvqPq1qAm6O1mnp85iDfTwXF/sKM3MzH2JTtWSToo1NRF2BL3DvxSsw+Q+uCoa5/DelERbFfuvV7hcIJpABvCCzLsuWOVKrPJUSwuN+wsjN7RTBg/PzvozWXXmVZcUpam/o6wvAfgV5hGvvS5vjLc5XeJRWCIj7rGvDkZZASi70hvUpcUhA5SyQ9VXmPGa3Dn1N1MMVxHXGpwCNUfic2P/kr2lsN64ldIDMvHkOgU+GpKKXGe2hkog91Mbg9rt/mqWI5uZzzoSVnho4Dvx/jzO+KrEKIime21mOMf0EoOb3LrZC4wjvyKX3PKasdTsomrU8u8PkDIawt+eCuJ/88FVKMyf24iEwCBVaGRLBrw1Oajyhs8pSiWPgGIdxQ7HCWw+csvb75cFkT8DM4hGnBGswTb19PjfwgDv7XO+p81ylWC4HJxhjPE9Im3EMT+MEbq27jwQNzyACoHuGuCeESomBUy9tFy7Y9u+2GmDFx0pE4F0rPAcrNMQutSjQHyqOTEZM6kCua5iahjcQr7gWVoUdwNbt4h4erTr4Wnug2478ZxbLmrxfqvCInZZYzbGLmg1+g5ZVZyEfJAeNRm9IT/B5bYxxRj0Re6HtQsB9JEqPIM/ArDNk941c8oMnbuciLWs+xyR/271wHTBEyMLArdncEH1SX7m0Yk1No1kY/KiRBPcBQWuox4gA/DCfZEclrVvRr3y2w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1dFSU5RWGRJZ0lnbnk4RlhMRUV2UDZ1VXBzUnhNL2x6SWJNZTUzZ0xrM2h4?=
 =?utf-8?B?dlQ2b1VFbS9GV1ZOVGtLWU4yVU1hOUhUZHdHSFVkUUFkb2FtdlhHaG1TM25D?=
 =?utf-8?B?d2Rab1RjTUhyd3pENDFSTTZKNzV4SE51MjZUYzAvZjRTS2VhdWhsMUJSVEFp?=
 =?utf-8?B?VTlzZDlhYWRHQUFrWXhQZG16NzBodU10enBUZncyYTQ4Skt5L3RlQnF3ODNE?=
 =?utf-8?B?dWZDaFI0aE1keVhHbXlwSUVyTHR2Kyt5Z0RhZTh3eHplV1M1VXFocG4zS1ZM?=
 =?utf-8?B?M1ZVdmRGOUpWdy9zTjNrU1JrTnpSRVVVbnNjLytvOWVabnRhUmdMQno2UWhU?=
 =?utf-8?B?VERqdUhpTjg0Y3d5QmFJT0RMMlprT01nR042YXF4ZVdyYWhiZHFzaVF2Ynkz?=
 =?utf-8?B?V2EvUTYxVmt3WlQyZllYN2NuZTZKVWczQVBUYWplei95Mk0vT0Zuc1l1Uy92?=
 =?utf-8?B?amxGU0RmNFN1UWhJMDRmN201MUdBZ2ppUC9kdEVmNURncEl0VlZ4U1huRHVM?=
 =?utf-8?B?Wjg0S1hjU1VMeEV4STNqaEdSdFRXSUZsazVkV3JEVkJLWTR0My9jT0pJYVRx?=
 =?utf-8?B?YXdHUXRnUWZqQW1oeGgveW1CM1lkTWkvNjB2WjlGNjJSa0txNk93K3NqRnhM?=
 =?utf-8?B?MGp5cW9FRHFlTFhKUjl4Yi9GSmNzSzIrdjRGUEZLNnFOVFJsU2d6azRCYkE4?=
 =?utf-8?B?T0lDZUMrVnhPVno4cjV5K0RpMXAwOTNrUjRFeHc1Q3puU0d1QmZlbU41amhw?=
 =?utf-8?B?c1BlSFpTQXVEWU1KTEx1eVZnNkRmQWdJS3VRcFA2L1ZvQ2ZDVkNBc2hmMDZk?=
 =?utf-8?B?TlBLZEVXVE9aNEk5S1V5dlp1VHVMZEYyQ2lpR3FEazFOamJjOWhNT0NNQmt2?=
 =?utf-8?B?cDFkaXA0dlBRVEpyR1NaempmcFp0WFo2V0RibGRtbzlmQmlON0xpd05ZdVll?=
 =?utf-8?B?b2txUHZzOU5XaW02ZURaTGE2cmJjRDZ2aDUxajNDMTdSakdJVkRmZ0hnbGxL?=
 =?utf-8?B?VWxQNVRIUjJUTzlsbFMrRzQyekVURUdQUG4rcmVBZnFqRkszdVJkZEg2NkFp?=
 =?utf-8?B?VGxtaGh5bzdzbUM0ak9XN0F1Tk80dkZqKytreis4U3V0THgvekdMc1pTOEtX?=
 =?utf-8?B?THd1YTRSOE5QZHdTZVN3UnpWb3BOeUxtKzdVSUV0VEY2MFg5Nzg1em95anNs?=
 =?utf-8?B?WVlrK0RFSktlSDI5aWNYOWk3UHdYTHV6VUlCUWlEM2pHYWJWVHVUeDNoeTY4?=
 =?utf-8?B?RWFlNzR3M1g2bkV5ZjJIbGg4UThCMjRQallQQkZVMzdiU0dYMFN5OTJtTzRD?=
 =?utf-8?B?WlRidGJSTjRleWdTQWRsV3pxV0ppRUdPNGxTcXJRVjBvbjBsTnJQMDJJTXBI?=
 =?utf-8?B?YzQxTGQvQUh6VlFGRWVFd2FmVmRZUitFbStQMU0xaHB2d0hsQVdXU2dOTmQr?=
 =?utf-8?B?MnNVTEtMd1VRMEQrREI3aHNhK2hQRDErZy85blp5LzkrYnJMV3ZuMEk3YVpX?=
 =?utf-8?B?bDVqakNncVVIMklkSmRzdXRKM1NOZTJZZVNVZzk3aWhkMVpGeEJMaVI2Tkpm?=
 =?utf-8?B?V3hnbndBRnJQSjVRaEh5QVhQY3d4MkFvb3N1TXA3ckZ1VittcUhTdFhNVDMx?=
 =?utf-8?B?bFdiWTlxcnc3aSsxT3JtaHluSnl5SEhRQXRhS2U0SXMrTEh0VXZZdk9rZStN?=
 =?utf-8?B?RVFyN2RxYk1HM056dTh6Q0VXa1RCTjhvT2daOVg3clFJNWNqUVRva1Yya2Y3?=
 =?utf-8?B?Yjd4WGZGNi9ZR2NkakdSajhxdTZzazBKQnhxeVJSLzBFd2lwcTlsR3hOaVVk?=
 =?utf-8?B?WVhoK2JhMjlwaVV0WVBNMUdwT2NJMGpmZzRIWTFONTdXZGR3NHJNcTFwTW5o?=
 =?utf-8?B?akVudk55MEtBVjdLM0tiWlBkTllqVGlDSTRnem0vS1ZUYkVGQ2VqYmRwYTQ1?=
 =?utf-8?B?TXcxd2N5UHU1emx6RktWbGkrRVFqLzlmT3kzQ0RwN0RsSFppc3Z5eUl5QVV6?=
 =?utf-8?B?VVB1TmZnaTV2aE5BSHovODZUZStTTU1uWG9VT2lnOWlRNU54QllsbE5FQWRy?=
 =?utf-8?B?ZUU5OFNEeXVlN2tjdGFTbUsveEpTVlZqK3NxN25TOVRNVkg4eVYxWlBKaDhq?=
 =?utf-8?Q?GAvQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeba12b8-c089-4f8c-c7a0-08dc4706449c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 04:45:42.6070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RFLbyoBqkhFR5WiwtlSRPDs/VnNG9YatPGI3uZ43N9c9rWYMyheU+BKP+TDf5FVF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5658
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

W1B1YmxpY10NCg0KUmV2aWV3ZWQtYnk6IExpam8gTGF6YXIgPGxpam8ubGF6YXJAYW1kLmNvbT4N
Cg0KVGhhbmtzLA0KTGlqbw0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFNIQU5N
VUdBTSwgU1JJTklWQVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT4NClNlbnQ6IFNh
dHVyZGF5LCBNYXJjaCAxNiwgMjAyNCAxMDoyMCBQTQ0KVG86IEtvZW5pZywgQ2hyaXN0aWFuIDxD
aHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5E
ZXVjaGVyQGFtZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFNIQU5N
VUdBTSwgU1JJTklWQVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47IExhemFyLCBM
aWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IEZp
eCB0cnVuY2F0aW9uIGlzc3VlcyBpbiBzbXVfdjEzXzBfaW5pdF9taWNyb2NvZGUNCg0KRml4ZXMg
dGhlIGJlbG93IHdpdGggZ2NjIFc9MToNCmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL3Bt
L3N3c211L3NtdTEzL3NtdV92MTNfMC5jOiBJbiBmdW5jdGlvbiDigJhzbXVfdjEzXzBfaW5pdF9t
aWNyb2NvZGXigJk6DQpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9wbS9zd3NtdS9zbXUx
My9zbXVfdjEzXzAuYzoxMDg6NTI6IHdhcm5pbmc6IOKAmCVz4oCZIGRpcmVjdGl2ZSBvdXRwdXQg
bWF5IGJlIHRydW5jYXRlZCB3cml0aW5nIHVwIHRvIDI5IGJ5dGVzIGludG8gYSByZWdpb24gb2Yg
c2l6ZSAyMyBbLVdmb3JtYXQtdHJ1bmNhdGlvbj1dDQogIDEwOCB8ICAgICAgICAgc25wcmludGYo
ZndfbmFtZSwgc2l6ZW9mKGZ3X25hbWUpLCAiYW1kZ3B1LyVzLmJpbiIsIHVjb2RlX3ByZWZpeCk7
DQogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIF5+ICAgICAgIH5+fn5+fn5+fn5+fg0KZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4v
cG0vc3dzbXUvc211MTMvc211X3YxM18wLmM6MTA4Ojk6IG5vdGU6IOKAmHNucHJpbnRm4oCZIG91
dHB1dCBiZXR3ZWVuIDEyIGFuZCA0MSBieXRlcyBpbnRvIGEgZGVzdGluYXRpb24gb2Ygc2l6ZSAz
MA0KICAxMDggfCAgICAgICAgIHNucHJpbnRmKGZ3X25hbWUsIHNpemVvZihmd19uYW1lKSwgImFt
ZGdwdS8lcy5iaW4iLCB1Y29kZV9wcmVmaXgpOw0KICAgICAgfCAgICAgICAgIF5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQoN
CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQpDYzogQ2hyaXN0
aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KU2lnbmVkLW9mZi1ieTogU3Jp
bml2YXNhbiBTaGFubXVnYW0gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQpTdWdnZXN0
ZWQtYnk6IExpam8gTGF6YXIgPGxpam8ubGF6YXJAYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wLmMgfCAyICstDQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMC5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzAuYw0KaW5kZXggNDgxNzBiYjUxMTJlLi5jZTE2
ZjJhMDhhNDcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEz
L3NtdV92MTNfMC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3Nt
dV92MTNfMC5jDQpAQCAtOTMsNyArOTMsNyBAQCBpbnQgc211X3YxM18wX2luaXRfbWljcm9jb2Rl
KHN0cnVjdCBzbXVfY29udGV4dCAqc211KSAgew0KICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiA9IHNtdS0+YWRldjsNCiAgICAgICAgY2hhciBmd19uYW1lWzMwXTsNCi0gICAgICAg
Y2hhciB1Y29kZV9wcmVmaXhbMzBdOw0KKyAgICAgICBjaGFyIHVjb2RlX3ByZWZpeFsxNV07DQog
ICAgICAgIGludCBlcnIgPSAwOw0KICAgICAgICBjb25zdCBzdHJ1Y3Qgc21jX2Zpcm13YXJlX2hl
YWRlcl92MV8wICpoZHI7DQogICAgICAgIGNvbnN0IHN0cnVjdCBjb21tb25fZmlybXdhcmVfaGVh
ZGVyICpoZWFkZXI7DQotLQ0KMi4zNC4xDQoNCg==
