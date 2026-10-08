Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E855CA600B
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 12:42:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD6DA10E81C;
	Thu,  8 Oct 2026 12:42:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uM03TGd3";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012016.outbound.protection.outlook.com [52.101.53.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F16F310E831
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 12:42:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhYrj88fh4gozdd9amQVvf7V0ZMmqrAnJuyaq3VVqi/ihGeEUJbEtP67+WshhwUtcggJgaHqhlwhfnTO6nTJsm+e+zeMNbXStbPJVyvQWSNxAUHAa85zU5JiQtqEMbzdX+aMXoKoNPDAX1I1ot8LFYrfkIreUqhya5Mc8zewsCk/nLXOfrpHjuVWx78OuZkuCdJR1A4iUz8xurF4f0Fotx4e8Tk4Er+qSY+FMbg6BvuBJCIUfvYH4/WfDpJNIp6PZMHiL2oMaRyLZp+BOmEMLaslc5GCBBlMvmr4b3qu0CL3PmCo+tsUdFOKBKGzyVvZrdjgSAHI1pbtqB2EHGeF3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RpE5k/OOh9pRMIq9Owgdg+8dnp+clm3Hc6xf8Cotj0=;
 b=Eho/t0I8bgDysiINF/BXCBXG+ToKICcKW+3Ky0+YhKZdTPAjyQPesSEY+S9dCEv0oHUD2gY6GIO/mU0rmE2+B4P6Exn3yUqbLuj/nYnzPSmLtm+MHQJC3GeiaOxyfU/sIAsWXIfFlF208dO59e/3saLoTUqm/x7lLKbnaQmqdCCyQ8KRZx02ECA9qQkKuQRz9vd2elumde9uEGIgch/p1iLSq7t0KrUSqw2z3+0XXsFXG5GOoXrz6Vy9JHdb8zC1uq+kNezSy8P0jbdqMDf40UMpyPTr3HwAq7gfVQ4GtEI6Qz1/pV1/hrixubczPXZjVvr+8li8kFMLHM1jCCOXIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RpE5k/OOh9pRMIq9Owgdg+8dnp+clm3Hc6xf8Cotj0=;
 b=uM03TGd3YAIwtx8BA2s5RnEmnpc59PYEuhKB+GH75W//izrXSdol8N34R1JyMdnRvYGIDXqt6g7GW1SZk/k9DcWgMgFxTwVAEvtB8GpxlI5aI8oYG8Uq5gjlvPIvj/31//oJ79TNk8xfkdnJEr65UKor8uRn+DIVtySN+O3mw14=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by MW4PR12MB7000.namprd12.prod.outlook.com (2603:10b6:303:208::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 8 Oct
 2026 12:42:06 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%4]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 12:42:04 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Prosyak, Vitaly"
 <Vitaly.Prosyak@amd.com>
Subject: RE: [PATCH v2 09/14] drm/amdgpu: defer JPEG and VCN idle work across
 GPU reset
Thread-Topic: [PATCH v2 09/14] drm/amdgpu: defer JPEG and VCN idle work across
 GPU reset
Thread-Index: AQHdT8U/OFtQTBjuH020GWqQmH3vt7bznoUAgAAEbACAAAA28A==
Date: Thu, 8 Oct 2026 12:42:04 +0000
Message-ID: <PH7PR12MB6000ADDBADE18139E2B7401BFB932@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20260929034650.2393125-1-Prike.Liang@amd.com>
 <20260929034650.2393125-9-Prike.Liang@amd.com>
 <0375ebd0-df28-437c-b6b4-47f06d4d1a24@amd.com>
 <5ff3175a-a8fb-49d4-b40a-36ab460f8ca0@amd.com>
In-Reply-To: <5ff3175a-a8fb-49d4-b40a-36ab460f8ca0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-08T12:34:22.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|MW4PR12MB7000:EE_
x-ms-office365-filtering-correlation-id: 05425fde-6b6b-4ad1-6ecd-08df25398eab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|18002099003|22082099003|38070700021|56012099006|10067099003|4143699003|11063799006;
x-microsoft-antispam-message-info: 5KE5vHVSduI4xmVISO/RTMAZtY4fvDtDQCMrCRkzK658TQyh8hvssg5R6HtzWxJRvZlj4Obd2HQU87MCG65m1LB7caKDagDPWpZjNPUCe/IniumCoU5i+5mhtrFblVjJPo7CIxRjZO2sVn0shAY/s5++dIw5r0zHcrBqItQzyDERehLELIbYxNy57d01wuN9cuNMbH96V38LrkhOW/09L/ivsTZruX50RQkpgtPWIo1ODhqGHDTyF6E/hMU8x8ILMupp8elkkPDTjrnjldBLlBaMFPZcETzwAjmNAzqSBJ+jhhLkFYVFcXltx+j+bugxMKCp/LF/F89k96sqO6dtthVUPrsUYwkVV53EdAD5L0ww4vU3yhd4Yw1zZWxfFEoJ1fSFxjqQ55gEVJCPfcbT7vMWEZYKNW9K2xFdT0FkOcfW+eAdgsG2WYrEHvJuzjWOL4Fxx3chqqLQLLXVnlnELBiROEMusDTey3j40UnH1p46tIm1fdOQE0ly9fOflLpTh+U+jR8zeDnD5UfW1auChfbKNVlzcMORKlClQchY9cDbLO9XK6IgVjCb0Jupb8dGZgoc4Ppge1RTNGimAun5Ev6o77+vabJUp6ZJ53bTKZPsAljstTb1kIxh4QdHeXy1haN7CDKCk2e2Odt44zpFjpHY1yeDn4Pc4jLM/kMlr+1yK0pcpXk5SoB8rkihLvVi6R1nvH+7R13y6/fNK8reqoIsKCD3FwMt3rdgP1SWzlE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(38070700021)(56012099006)(10067099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEZheVhmQnA4TUhLeDRVY01GV3pqSWlBai9HUndPOXR2WXpKV2NWbFNzS3VN?=
 =?utf-8?B?QTBHZWhvM0w3ODhydzRqdkExbDcvcUFDd1ZJQndJMFlRWnExRGhpUVFhdjlH?=
 =?utf-8?B?bDJkcGY5VTVhaUsxWkFLc1VvNE9GNXJHU05kcCtWQjFKd0gzMUtaK2VhSkUv?=
 =?utf-8?B?NCswQlI1dUJzQ1dRRi9WbXVNT0tLMXV6ckFVZVV6Z2QzUWMvK3VkRUY5RUs1?=
 =?utf-8?B?czdqMEdzK3pUcHVJRWF1Mzh3dXp6cC9UNkgxeEdqUjZSc3NydGR6QkUyY1JE?=
 =?utf-8?B?VzlwWW5EYUlJNUhjR1JYTG9zbkR6bjh2V2cxK09ZZy85VnpnNFFjR29kMzls?=
 =?utf-8?B?OHZSTEZqN05GRzI5SFQ0a3VySzBvZndCRnVTbTB6clFrbWFON2lCNExxa1Vv?=
 =?utf-8?B?SmVBNzZwOHJBRzFGdEdMRzZBVFQ0bVJqeVFadjhMTGNQWHZNZ2JzV3p6Vmxr?=
 =?utf-8?B?YXFVeXdOSXc4RTV5V0xBZVRJaTR2LzJLREUwUHNJVmRybEtqdXN2d3YwUDVH?=
 =?utf-8?B?dEp2UWlsSXZvVnJIbVZpOXVsc2JyQTRRN2RjeHQvdE9ZMlNpV0pWWEg2Uzht?=
 =?utf-8?B?UTdzY3JWMWxvZGRoNk9CNUdmeEI4TndSRDVLdGxKKzdnMTFQYVF3ZjltL3pq?=
 =?utf-8?B?dGNWQkU2TDFzU3lXM3cyNlVaVk40aWo3Sjdzb1BicG1aWFhuZFJkWEVIcWUz?=
 =?utf-8?B?dW5DY25VZWhGbkN3eEFrTzBjanE2aXJLendpQnpOR1RzSnkwZ0VicHlFNWdW?=
 =?utf-8?B?bE9nUkQvZ2J3b0pIWFNibGliOWJOSzNIU3hJOHk5dklPaVdnZzZrQUw0TTN3?=
 =?utf-8?B?R1d3YlhiREx5d0pxbEJ5NGpkZE9oY3AySndoUGIzOE1MRkFlOXhuUGt3dmQ1?=
 =?utf-8?B?UXNZenVMejRaZTNMRGprelpWNVRtTjhqek51VDYvR1ArRGtJcEpGdGUwMFZq?=
 =?utf-8?B?ak1NcDlKU2xuNnNPajlKQ2o5STRFTEVMODNqREpNV0QxdEtRRFZxbTVnSnFa?=
 =?utf-8?B?VUxYMGRZZ05USmwwWmEvZWJHdWVVS1ROaHV2MnNPREpvVVg5R0xpcEZIeG5p?=
 =?utf-8?B?bWxVUzVxeTZHRzF2dDFleGZUYW13dFdSaTVRdmV3aWs0a09QTCt4S0NMd21y?=
 =?utf-8?B?R3lGN0lMUVhqOHo3dStHZ0JkSzhWL2t6bndXbklidVZCSFJwNmxFQ2EyaG9k?=
 =?utf-8?B?M2g0MHZQejZJTGtHSE1yUTBQSzVCaVNBV0J5RlZWZ0lXblJSMkpxcjIyM1FG?=
 =?utf-8?B?dWFENW1DQmZ4YjAxcXN4bmZianQwMlZOZmF1eWl5T0ZMSFNHMlNRcysvUGdy?=
 =?utf-8?B?MHh1UmlLNVRTMGxaaDhBVVdoZGRGclpkWkp2MTdmN2JSV3dTNS9UWC93aWUz?=
 =?utf-8?B?K0FqZ0hib1c2WG1Cckd5QUkxTTROOWt6Q2l5Q053dDhDT3RlK052U0E0U1Fv?=
 =?utf-8?B?UFA1eTZnRE5WODJYQmplOFk5TjhJTTUzSlFmNDljeGo2cm80aW1PZFY5QXVC?=
 =?utf-8?B?YVhtWE94bSt1SjcxY2dpaXdhcENSQ3hTU2FqR0RxcWZmcks1RzlzZ1FJd2h1?=
 =?utf-8?B?YmZpYVBRUm9BZTR6RnNZdE9ZaW9qQ0NOek84NFpMVTV1aDBUdHFMaTJDTkVL?=
 =?utf-8?B?MmdndHVlZXQ2emx4RndnQkdYYTNTMFdMM3B6K2ZiSjI4MUxCVHJYa2lxUHBH?=
 =?utf-8?B?S1N6NEtCdE5qcHVXZzRuU3hnUE5yemlMNTJnYXZ4aTFrbXREZXREMHVOYld1?=
 =?utf-8?B?d3AzL3RrUlRqYXV1RlMzN0FhZ0NKRDJndnVkSVhDSG1kencxcDdoSVpHNGl2?=
 =?utf-8?B?dkh2RzNPcHVhVWNLbjJkS000b3EvdXV1MCtjU2s4SnUwRGg4elhuOTFIRlFi?=
 =?utf-8?B?M2REdDkwMU5ubEZ0aEdsbEJucHl4TW00SlltTlBiMUZkZTFmcnMzQzZTZWZJ?=
 =?utf-8?B?TnNmeHZhOE40SkFhazV2RUtoSDJuU3UxRitSVDZiTkxqUWQ1R3lMbEtQZ09O?=
 =?utf-8?B?TDVkL205UkhXdmZJNzEwUkhPSXN1UHBCc3RLQ2lzVGFKaS9RZm9GeDE0V21q?=
 =?utf-8?B?M1pjcm5pSUMzRThSV01OT0djaTlxK3VlUXVmK1FXZmxhRmVLVXNpaXVWMVZs?=
 =?utf-8?B?by90aTFwRWxNeEMyR0NSaUJPcDJZWVIzRmNVbGtiNTFwcTZTenl6TXZPbklw?=
 =?utf-8?B?QWpNczIyL1RIQ0N5YUJnamcycnAzY3VKYjY2K3F2UURHZ25iT2dQNUJIVFRa?=
 =?utf-8?B?bzg2cXBGN0RTODF5NmJBQTJUeFNQSnJ2RjhBRHZpU1lnbVdXKy9FNjJjMXlO?=
 =?utf-8?Q?Dlj2pfUcpQDP6YowwF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05425fde-6b6b-4ad1-6ecd-08df25398eab
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 12:42:04.6655 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OGj8UifDeZ4ui0eh6hFQv54kZQL0c+6ndCkAW7hSiMyMn2zZRBJ51IR05xLft5nE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7000
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

QU1EIEdlbmVyYWwNCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdA
YW1kLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgOCwgMjAyNiA4OjM0IFBNDQo+IFRv
OiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPjsgTGlhbmcsIFByaWtlIDxQcmlrZS5M
aWFuZ0BhbWQuY29tPjsgYW1kLQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBQcm9zeWFrLCBW
aXRhbHkNCj4gPFZpdGFseS5Qcm9zeWFrQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djIgMDkvMTRdIGRybS9hbWRncHU6IGRlZmVyIEpQRUcgYW5kIFZDTiBpZGxlIHdvcmsgYWNyb3Nz
DQo+IEdQVSByZXNldA0KPg0KPiBPbiAxMC84LzI2IDE0OjE3LCBMYXphciwgTGlqbyB3cm90ZToN
Cj4gPg0KPiA+DQo+ID4gT24gMjktU2VwLTI2IDk6MTYgQU0sIFByaWtlIExpYW5nIHdyb3RlOg0K
PiA+PiBQcm90ZWN0IG1lZGlhIGlkbGUgd29ya2VycyB3aXRoIGEgcmVzZXQtZG9tYWluIHJlYWQg
dHJ5bG9jay4gT24NCj4gPj4gY29udGVudGlvbiwgcmVxdWV1ZSB0aGUgaWRsZSB0aW1lb3V0IGFu
ZCByZXR1cm4gd2l0aG91dCBoYXJkd2FyZQ0KPiA+PiBhY2Nlc3MuIEtlZXAgdGhlIG9yZGluYXJ5
IGVuZC11c2Ugc2NoZWR1bGluZyBldmVudCwgaW5jbHVkaW5nIGZyb20NCj4gPj4gcmVzZXQtdGlt
ZSByaW5nIHRlc3RzLCBzbyBvdGhlcndpc2UgaWRsZSBlbmdpbmVzIGV2ZW50dWFsbHkgcG93ZXIg
ZG93biBhbmQgVkNODQo+IGRyb3BzIGl0cyBwcm9maWxlLg0KPiA+Pg0KPiA+PiBBIGJsb2NraW5n
IHJlYWQgYWNxdWlzaXRpb24gd291bGQgZGVhZGxvY2sgd2l0aCByZXNldC10aW1lDQo+ID4+IHN5
bmNocm9ub3VzIGNhbmNlbGxhdGlvbiBvZiB0aGVzZSB3b3JrZXJzLCBzbyB0aGUgd29ya2VycyBt
dXN0IG9ubHkgdHJ5IHRoZSBsb2NrLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBQcmlrZSBM
aWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pwZWcuYyB8IDcgKysrKysrKw0KPiA+PiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYyAgfCA3ICsrKysrKysNCj4gPj4gICAyIGZp
bGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qcGVnLmMNCj4gPj4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfanBlZy5jDQo+ID4+IGluZGV4IDk4ODdhNGY5OWFlZC4u
N2IxMDI2MGFkMGQ0IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfanBlZy5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9qcGVnLmMNCj4gPj4gQEAgLTExNCw2ICsxMTQsMTIgQEAgc3RhdGljIHZvaWQgYW1kZ3B1
X2pwZWdfaWRsZV93b3JrX2hhbmRsZXIoc3RydWN0DQo+ID4+IHdvcmtfc3RydWN0ICp3b3JrKQ0K
PiA+PiAgICAgICB1bnNpZ25lZCBpbnQgZmVuY2VzID0gMDsNCj4gPj4gICAgICAgdW5zaWduZWQg
aW50IGksIGo7DQo+ID4+ICAgKyAgICAvKiBSZXNldCBtYXkgY2FuY2VsIHRoaXMgd29ya2VyIHN5
bmNocm9ub3VzbHkgd2hpbGUgaG9sZGluZw0KPiA+PiB0aGUgd3JpdGVyLiAqLw0KPiA+PiArICAg
IGlmICghZG93bl9yZWFkX3RyeWxvY2soJmFkZXYtPnJlc2V0X2RvbWFpbi0+c2VtKSkgew0KPiA+
PiArICAgICAgICBzY2hlZHVsZV9kZWxheWVkX3dvcmsoJmFkZXYtPmpwZWcuaWRsZV93b3JrLA0K
PiA+PiArSlBFR19JRExFX1RJTUVPVVQpOw0KPiA+DQo+ID4gSXMgdGhlcmUgYW55IG5lZWQgdG8g
c2NoZWR1bGUgdGhpcyB3b3JrIGhlcmU/IEJlaW5nIG5vdCBhYmxlIHRvIGdldCB0aGUgbG9jaw0K
PiBpbmRpY2F0ZXMgdGhhdCBhIHJlc2V0IGlzIGluIHByb2dyZXNzIGFscmVhZHkuDQo+DQo+IFll
YWggYWdyZWUuIFdlIHNob3VsZCBqdXN0IGJsb2NrIGZvciB0aGUgR1BVIHJlc2V0IHRvIGZpbmlz
aC4NCj4NCj4gU28gYSBzaW1wbGUgZG93bl9yZWFkKCZhZGV2LT5yZXNldF9kb21haW4tPnNlbSkg
c2hvdWxkIGRvIGl0Lg0KDQpUaGlzIHBhdGNoIHdhbnRzIHRvIHNjaGVkdWxlIGEgZGVsYXkgaWRs
ZSB3b3JrIGR1cmluZyBwcm9jZXNzaW5nIGEgZ3B1IHJlc2V0IHByb2Nlc3MsIGFuZCB0aGVuIHJl
dHJ5IHRvIHJ1biB0aGUgVkNOIGlkbGUgYXQgdGhlIG5leHQgc2NoZWR1bGVkIGxvb3AuDQoNCg0K
PiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo+DQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gTGlqbw0K
PiA+DQo+ID4+ICsgICAgICAgIHJldHVybjsNCj4gPj4gKyAgICB9DQo+ID4+ICsNCj4gPj4gICAg
ICAgZm9yIChpID0gMDsgaSA8IGFkZXYtPmpwZWcubnVtX2pwZWdfaW5zdDsgKytpKSB7DQo+ID4+
ICAgICAgICAgICBpZiAoYWRldi0+anBlZy5oYXJ2ZXN0X2NvbmZpZyAmICgxVSA8PCBpKSkNCj4g
Pj4gICAgICAgICAgICAgICBjb250aW51ZTsNCj4gPj4gQEAgLTEyOSw2ICsxMzUsNyBAQCBzdGF0
aWMgdm9pZCBhbWRncHVfanBlZ19pZGxlX3dvcmtfaGFuZGxlcihzdHJ1Y3QNCj4gPj4gd29ya19z
dHJ1Y3QgKndvcmspDQo+ID4+ICAgICAgICAgICBtdXRleF91bmxvY2soJmFkZXYtPmpwZWcuanBl
Z19wZ19sb2NrKTsNCj4gPj4gICAgICAgfSBlbHNlDQo+ID4+ICAgICAgICAgICBzY2hlZHVsZV9k
ZWxheWVkX3dvcmsoJmFkZXYtPmpwZWcuaWRsZV93b3JrLA0KPiA+PiBKUEVHX0lETEVfVElNRU9V
VCk7DQo+ID4+ICsgICAgdXBfcmVhZCgmYWRldi0+cmVzZXRfZG9tYWluLT5zZW0pOw0KPiA+PiAg
IH0NCj4gPj4gICAgIHZvaWQgYW1kZ3B1X2pwZWdfcmluZ19iZWdpbl91c2Uoc3RydWN0IGFtZGdw
dV9yaW5nICpyaW5nKSBkaWZmDQo+ID4+IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Zjbi5jDQo+ID4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3Zjbi5jDQo+ID4+IGluZGV4IDE3ZGI3MjY0MjY5ZS4uZjg1MWE2ZWNlYTFiIDEwMDY0NA0KPiA+
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMNCj4gPj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jDQo+ID4+IEBAIC00NzAs
NiArNDcwLDEyIEBAIHN0YXRpYyB2b2lkIGFtZGdwdV92Y25faWRsZV93b3JrX2hhbmRsZXIoc3Ry
dWN0DQo+ID4+IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiA+PiAgICAgICBpZiAoYWRldi0+dmNuLmhh
cnZlc3RfY29uZmlnICYgKDEgPDwgaSkpDQo+ID4+ICAgICAgICAgICByZXR1cm47DQo+ID4+ICAg
KyAgICAvKiBSZXNldCBtYXkgY2FuY2VsIHRoaXMgd29ya2VyIHN5bmNocm9ub3VzbHkgd2hpbGUg
aG9sZGluZw0KPiA+PiB0aGUgd3JpdGVyLiAqLw0KPiA+PiArICAgIGlmICghZG93bl9yZWFkX3Ry
eWxvY2soJmFkZXYtPnJlc2V0X2RvbWFpbi0+c2VtKSkgew0KPiA+PiArICAgICAgICBzY2hlZHVs
ZV9kZWxheWVkX3dvcmsoJnZjbl9pbnN0LT5pZGxlX3dvcmssDQo+ID4+ICtWQ05fSURMRV9USU1F
T1VUKTsNCj4gPj4gKyAgICAgICAgcmV0dXJuOw0KPiA+PiArICAgIH0NCj4gPj4gKw0KPiA+PiAg
ICAgICBmb3IgKGogPSAwOyBqIDwgYWRldi0+dmNuLmluc3RbaV0ubnVtX2VuY19yaW5nczsgKytq
KQ0KPiA+PiAgICAgICAgICAgZmVuY2VbaV0gKz0NCj4gPj4gYW1kZ3B1X2ZlbmNlX2NvdW50X2Vt
aXR0ZWQoJnZjbl9pbnN0LT5yaW5nX2VuY1tqXSk7DQo+ID4+ICAgQEAgLTQ5OSw2ICs1MDUsNyBA
QCBzdGF0aWMgdm9pZCBhbWRncHVfdmNuX2lkbGVfd29ya19oYW5kbGVyKHN0cnVjdA0KPiA+PiB3
b3JrX3N0cnVjdCAqd29yaykNCj4gPj4gICAgICAgfSBlbHNlIHsNCj4gPj4gICAgICAgICAgIHNj
aGVkdWxlX2RlbGF5ZWRfd29yaygmdmNuX2luc3QtPmlkbGVfd29yaywNCj4gPj4gVkNOX0lETEVf
VElNRU9VVCk7DQo+ID4+ICAgICAgIH0NCj4gPj4gKyAgICB1cF9yZWFkKCZhZGV2LT5yZXNldF9k
b21haW4tPnNlbSk7DQo+ID4+ICAgfQ0KPiA+PiAgICAgdm9pZCBhbWRncHVfdmNuX3JpbmdfYmVn
aW5fdXNlKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykNCj4gPg0KDQo=
