Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA107C77B7D
	for <amd-gfx@archiver.kernel.org>; Mon, 15 May 2023 10:40:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FEA610E1A0;
	Mon, 15 May 2023 10:40:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6110910E1A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 May 2023 10:40:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBUHmPHo3EC88TenTNmx3i2KhVVhjpZ8FUVOSW8yURTN7lLxWs2VmGfzc3E+wCyEiz0POBICZPvSk4JYogf+C2OL0Zdl39qH5wch0JiVH2IT8qoRlcacSVQTO7P2UrwLHTmmXOW/03H1r505AIMO8nlRGofSNbSzpjKwWrUTbQGwU1dbv7uNH6XpTX27+pGixxIh8eX21GhgIYHnLo+V4GACrwtdubk1Vmz5PnYL3/6GJ3JB1BwH1n5YHviXDKdQWePSIjL7/1lEp/NKIvDMRsCgwbS19SdPIVjGGPNcZHIYvhgAhZliv23Lse3++Z3JFBywoFeW1OCoq0pb2DHv3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmbhCngG56BlZyMbtFEpz9gU8u2d0Pc/sdBY/6irArs=;
 b=RGaUzZP4gkiE2jVHgtpUqfPz17obZJeqW1YgQ1i121X/w0YhLWpEPfpzetjgNX0KU6FJEm8iqioMsALV21l61aNgvr4li6EpB1JJudE1BBe5K2hEgohQUN9EeQS2OSLmbyP//+pYar2YcFfuMPggIrGt4Kg35M88gdoQqp38QbOpw86VKYCZ6gpPprmTta4rSgdc2gnRo1FQYrFfji9rVDAf6Hv2H8vVzAKozR5eVqYmEs/j36SuvQjAvPdtD9OqZCfyXNV9Ww7iGMrV6Di003r1R2tJ3OKs2Go5Zrlh1IMSVJv/Llzi+kMCfZcFeLoJObeTdlMgtoOdScOXYTiW1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmbhCngG56BlZyMbtFEpz9gU8u2d0Pc/sdBY/6irArs=;
 b=hlaLFmopTtupOfvc47jegahCuWqps+AbzMgbAW2BMN4mMfDt8anzHoIhgDVgNaedULaw5S54eeVNtgutmpWnndhtHmx8anGQcyGTd95AlQRr1AnZLy+q1GNwSZX/d6yO4spr73ewzU/IKnqI9Q4616srsYiiWNgAsGGghU3MASM=
Received: from MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10)
 by SJ2PR12MB8956.namprd12.prod.outlook.com (2603:10b6:a03:53a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 10:40:30 +0000
Received: from MW3PR12MB4458.namprd12.prod.outlook.com
 ([fe80::5544:7553:39aa:2756]) by MW3PR12MB4458.namprd12.prod.outlook.com
 ([fe80::5544:7553:39aa:2756%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 10:40:30 +0000
From: "Xiao, Jack" <Jack.Xiao@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: fix S3 issue if MQD in VRAM
Thread-Topic: [PATCH] drm/amdgpu: fix S3 issue if MQD in VRAM
Thread-Index: AQHZhKoFOL05coUYlUC4iBeSaW6yuq9WnZ8AgASByYA=
Date: Mon, 15 May 2023 10:40:29 +0000
Message-ID: <MW3PR12MB4458CDFA10A935321578EDD3EF789@MW3PR12MB4458.namprd12.prod.outlook.com>
References: <20230512081547.1006052-1-Jack.Xiao@amd.com>
 <CADnq5_PGQG4vu+DBUmMZwK=A-v1AgTemy1Z15=GSqep5_ymvgA@mail.gmail.com>
In-Reply-To: <CADnq5_PGQG4vu+DBUmMZwK=A-v1AgTemy1Z15=GSqep5_ymvgA@mail.gmail.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-15T10:40:26Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f5b502c3-fe77-44b5-9eba-d78b7abfc323;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-05-15T10:40:26Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 0830aae6-c6b8-42bc-9420-2942a603881c
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4458:EE_|SJ2PR12MB8956:EE_
x-ms-office365-filtering-correlation-id: bc2e8c6b-e03f-4fe9-3a90-08db5530cda2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u2tpbxK5Wj6/EuJG0+spLi1NH5C+KwVSuM0lujehZXzRSJDl3+v5N5xDXD4CRpsicy2B/MBebNPnyxRgjOBSa3DLILFvGciqQHX7r4ew8/Ug1aMm5bGPWboWh9jNwvHn37Rn614Mt51b5mw9BnqK47zAg0ToZJMfxu5fS1uVVem4QW6D3UE8xqS4UiJlhPCdPeOSvKc2DpfEuFbefo+TQffpLWmAkfV6/lUbYnfT9Uk4wXHBljLu0OPz42XOVG0xXhTzkP1VKtr8la7JIiBGOBpFZ+rR1rv6q/rKhDjW8KHfJLPiZAck+tGL2P5fhQmtlZhuNjm6ct7GyubUrlKjIjf3e7FF8vPPqBW8+T+0vWKJNjJitNbITAxots1mZgteMysFs2I2K/lkyzwXlHTL7UwbhOvLGKBUtDehSs7Z8nHcL/X1GH4y0rAbRxR5CZLAphNM0Fp6G2wR69hcFZYaZyHT5GeLxcWo9g9Qy/UXAzg6jGuWgOhT1MlbQzxez7uFwniH4dFce4BcA++P5B3SuFTWWpx1bGHsmAuB5IBjmC3lVUtj19111u8R1cTzrmm/m8WFGmpqHNEnYqU0GZePgeKGcJ2/QRbUrH6iU6g1hq9Tc5DCc0grGUy+oV2W9Rl/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4458.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199021)(54906003)(478600001)(8676002)(52536014)(5660300002)(8936002)(33656002)(2906002)(86362001)(38070700005)(76116006)(6916009)(66446008)(4326008)(64756008)(66556008)(66476007)(66946007)(122000001)(316002)(55016003)(41300700001)(38100700002)(186003)(53546011)(6506007)(9686003)(83380400001)(26005)(71200400001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTlWYkk2aVBHYnlGcHJIRjdoT2JDeG9sWXdIaTc5d1dVMmxnTnBPSHl2TUIv?=
 =?utf-8?B?NUdyUXRQTnR3dlYrTEhnMGNyd3VXWFpJbDlVN1NIcGJ2ZkpQaGUxMmZOVzZ4?=
 =?utf-8?B?QXUxTFdoTEhDeFNjZW8rdWt6aWZZS2JXK3IxeUFGcjZUVis1Q3ZxTGlsbmxs?=
 =?utf-8?B?OUJJVTBrWDhQczNDTEtNcXhiSFhzZ2dJRks0TXh1S3ZYUmRUanFwMEhENzg2?=
 =?utf-8?B?WUpBZ2dPWDVEejR3bFhEdkh1TmRDaHdFMmZONUpoUFl2azNtWVB5RWFHM1FQ?=
 =?utf-8?B?SzZFZmEybWV5OVMwUldleHV4a1ozU0RpbWVCQmFSZmZBdUFZTWpMMmkrODU4?=
 =?utf-8?B?OGVVblJBM3VXL2huUFJIdmwySk4vanBFOHk2dk5jTWxXVGFNcWREWFIxSGNz?=
 =?utf-8?B?cVd3WXV6U1FSU1dJQWJaaUtTTk5UM1kwb3IwRjlpRXoxeHlqbjFRRnVsbDJF?=
 =?utf-8?B?L01iMFVSYXdyMmg4czVZL0pCZmhlaEJtdExnYTBZbUttdVpUWUxjSk10UDBL?=
 =?utf-8?B?aDFzRnlqTUcrWjhxcXZHaWlrQk9lV24xaVZ5a3VtTXZiRXJGa1RCMEl2dmVH?=
 =?utf-8?B?elZUT3h4WU1mc1pjaW1lOVhhMXpVYndWOWRPeEJtOWtDRFJobGZNN2ZmeVhN?=
 =?utf-8?B?a0NFbHR6UWdiUHZ6dDZRV2VKcVp6MUE1cFdTWHJSNUFNMWFZc0FOTW1LRmhh?=
 =?utf-8?B?dk9CZVZhN2R0Qmx0TXVMblEyQlpXS0JqVkg1amRtdVlWaFk3bmZQa1pHTmRQ?=
 =?utf-8?B?UzlrazFpLzNkU3ExR0s1Y09CTTVtTms2bVlyZEwwSjdZa2p5ek11ME5yWmtO?=
 =?utf-8?B?QVRjSG9NdWVYRldEOVdjT1VIK0dLVTEyb01hZGtyMGtDcWt4eHpzWkc2UjZL?=
 =?utf-8?B?eC8yeFdCT3RNRUpKWnJBdG9JbE1DZ3p4WmEvOXlRN2JVdU5xZXFSZ3FkbUlK?=
 =?utf-8?B?T2VWNVVWdEhJTW90azY5N0F0VFNNc2dBd0V3RG9VdjYwVTROYThiUjY5SzR5?=
 =?utf-8?B?bURHVXpDWEh5L1pIdlBLUmNmbWRDYzB6aXZEcG02SmJDellGbGkvQldIaFZU?=
 =?utf-8?B?TzBHV1hldElVQTdpSnBSVmg2S0dsclYxOXlhMzExaE1WSlNkb2taQWVzblRG?=
 =?utf-8?B?emVRZ1JTVzBINElYZElZSjdQMGNyL0VCbE5CMlNzNkd1dXdtSDZEY1NGU0Rr?=
 =?utf-8?B?OElLWXVadUFIQ2ZONjVtWnVQa05RL3JhU1ZxcWJxeHdzZjJ2VFRxTGwvUC9l?=
 =?utf-8?B?djBhT1ZFRjNXajgyaXNiekprNEhQMTVRcUQwbXNJdzhvMzE1YncwcXVwRU04?=
 =?utf-8?B?UEpEaGQxVmIzdVo0S1N2NUo4c0RJTGM1S1JSSkVkSjJ3aWdCNkJKL1lyOUgv?=
 =?utf-8?B?eC96aUc5SW9wV1o4ZDg4SHV6cXhtMnRlbVNRV1JUSnpuRVlqUThha0lCMit4?=
 =?utf-8?B?Z1F4UCtRQ2ZmSXB6ZVJTSTBJaVBtZUJ6aHM4dnZEQjlxdmw3anozcGVObnBU?=
 =?utf-8?B?bnc0QURQbHFjMitKeGkzV2c4ZEpSTVNZZmVxWFR4djN4cjRCVGdpUk5VaDIv?=
 =?utf-8?B?WEx0Mm56a1BWWDBQYTgyNWcyMkw2Qk9uNkVld0hoek9JSTVoMTlVdllmeGVv?=
 =?utf-8?B?YzZsc1h0Y2JqbDYzT0hHdmZpeFdic21rUVQzRXpBdGlPdXdFZTAzaDZzTk5X?=
 =?utf-8?B?NTlsV0QxQ0ZhUzAvaEpJaW1KbHVvMFA0RnZUNFg3cHVsU1BpeDF1L1ZQYm1h?=
 =?utf-8?B?WTQvb3M1ek53TjVjVEw3UGdrMktxcFl0V2pnbUJIVGlYU2svVmdpa2dPdTZl?=
 =?utf-8?B?MXNtYU1QaDhKYnllcnI2UjExVVpqMU1KZTZ1YmZxUVVrRkdzT3NmeHBFNGtY?=
 =?utf-8?B?Y3pTZkNwdmI0NTVyeE5TYnRYSStXWEltTG5od3FWczYxeHJPQlhLYmVFRTN2?=
 =?utf-8?B?dGpUSzg5elB2MjBCYkJDUVJGemFod3MwTGI3cXJ4ZUoxVW4xUHBRUGxOTG9j?=
 =?utf-8?B?SlpmQUZvNlE3bC9KYUpjTEpIbnhFMnVoV1lJbnpLSTFiUWIzUDBrOHdsaGI1?=
 =?utf-8?B?UzYwZStVRXFvVkpQcVZVaWZNckpkeXA5Nnhad29Vd2FxVWU1c2VuSmFCdy9B?=
 =?utf-8?Q?EyKs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4458.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2e8c6b-e03f-4fe9-3a90-08db5530cda2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 10:40:29.9680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IJq+D5G6PdPVLrHH8el/ZOZVmzQ45FwMjHL7ww6ZG395CPQ771HwkE51Ih1xBGy2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8956
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
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoZSBNUUQgZGF0YSBpbiBWUkFN
IHdvdWxkIGJlIGxvc3QgYWZ0ZXIgUzMsICBmb3IgdGhlIE1RRCBibyBpcyBwaW5uZWQgZG93biBh
cyBrZXJuZWwgYm8gYW5kIGNhbid0IGJlIGV2aWN0ZWQgdG8gc3lzdGVtIG1lbW9yeS4NCkFGQUlL
LCBkcml2ZXIgc2hvdWxkIG5vdCB0byBkbyBhbGxvY2F0ZS9mcmVlIG1lbW9yeSBkdXJpbmcgUzMs
IGFzIHRoZXJlIGFyZSBpc3N1ZXMgb2JzZXJ2ZWQgdG8gZG8gbWVtb3J5IGFsbG9jYXRpb24gZHVy
aW5nIFMzLiANCg0KUmVnYXJkcywNCkphY2sNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPiANClNlbnQ6IEZyaWRh
eSwgTWF5IDEyLCAyMDIzIDk6MTMgUE0NClRvOiBYaWFvLCBKYWNrIDxKYWNrLlhpYW9AYW1kLmNv
bT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVy
IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2Ft
ZGdwdTogZml4IFMzIGlzc3VlIGlmIE1RRCBpbiBWUkFNDQoNCk9uIEZyaSwgTWF5IDEyLCAyMDIz
IGF0IDQ6MTbigK9BTSBKYWNrIFhpYW8gPEphY2suWGlhb0BhbWQuY29tPiB3cm90ZToNCj4NCj4g
TWFrZSB0aGUgcHJlZW1wdGlvbiBvcHRpbWl6YXRpb24gZWZmZWN0IG9ubHkgZm9yIFNSSU9WLCBm
b3IgaXQgY2F1c2VkIA0KPiBmYWlsdXJlIHRvIHJlc3VtZSBmcm9tIFMzLg0KDQpDYW4geW91IGVs
YWJvcmF0ZT8gIFdlIHVsdGltYXRlbHkgd2FudCBNUURzIGluIFZSQU0gZm9yIHBlcmZvcm1hbmNl
IHJlYXNvbnMgZXZlbiBmb3IgYmFyZSBtZXRhbC4NCg0KQWxleA0KDQo+DQo+IFNpZ25lZC1vZmYt
Ynk6IEphY2sgWGlhbyA8SmFjay5YaWFvQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jIHwgMyArKy0gIA0KPiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9tZXNfdjEwXzEuYyAgfCA3ICsrKysrLS0gIA0KPiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9tZXNfdjExXzAuYyAgfCA3ICsrKysrLS0NCj4gIDMgZmlsZXMgY2hhbmdlZCwg
MTIgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguYyANCj4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMNCj4gaW5kZXggYTIyZDg4YTQxNzhhLi4xYjc5NWI3YmJm
MzggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZngu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMNCj4gQEAg
LTM4NSw3ICszODUsOCBAQCBpbnQgYW1kZ3B1X2dmeF9tcWRfc3dfaW5pdChzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwNCj4gICAgICAgICB1MzIgZG9tYWluID0gQU1ER1BVX0dFTV9ET01BSU5f
R1RUOw0KPg0KPiAgICAgICAgIC8qIE9ubHkgZW5hYmxlIG9uIGdmeDEwIGFuZCAxMSBmb3Igbm93
IHRvIGF2b2lkIGNoYW5naW5nIGJlaGF2aW9yIG9uIG9sZGVyIGNoaXBzICovDQo+IC0gICAgICAg
aWYgKGFkZXYtPmlwX3ZlcnNpb25zW0dDX0hXSVBdWzBdID49IElQX1ZFUlNJT04oMTAsIDAsIDAp
KQ0KPiArICAgICAgIGlmIChhZGV2LT5pcF92ZXJzaW9uc1tHQ19IV0lQXVswXSA+PSBJUF9WRVJT
SU9OKDEwLCAwLCAwKSAmJg0KPiArICAgICAgICAgICBhbWRncHVfc3Jpb3ZfdmYoYWRldikpDQo+
ICAgICAgICAgICAgICAgICBkb21haW4gfD0gQU1ER1BVX0dFTV9ET01BSU5fVlJBTTsNCj4NCj4g
ICAgICAgICAvKiBjcmVhdGUgTVFEIGZvciBLSVEgKi8NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTBfMS5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L21lc192MTBfMS5jDQo+IGluZGV4IDQ1NjA0NzZjN2MzMS4uNWMzZDNmNmM3ZWJkIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjEwXzEuYw0KPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjEwXzEuYw0KPiBAQCAtODg5LDYg
Kzg4OSw3IEBAIHN0YXRpYyBpbnQgbWVzX3YxMF8xX21xZF9zd19pbml0KHN0cnVjdCANCj4gYW1k
Z3B1X2RldmljZSAqYWRldiwgIHsNCj4gICAgICAgICBpbnQgciwgbXFkX3NpemUgPSBzaXplb2Yo
c3RydWN0IHYxMF9jb21wdXRlX21xZCk7DQo+ICAgICAgICAgc3RydWN0IGFtZGdwdV9yaW5nICpy
aW5nOw0KPiArICAgICAgIHUzMiBkb21haW4gPSBBTURHUFVfR0VNX0RPTUFJTl9HVFQ7DQo+DQo+
ICAgICAgICAgaWYgKHBpcGUgPT0gQU1ER1BVX01FU19LSVFfUElQRSkNCj4gICAgICAgICAgICAg
ICAgIHJpbmcgPSAmYWRldi0+Z2Z4LmtpcVswXS5yaW5nOyBAQCAtOTAwLDkgKzkwMSwxMSBAQCAN
Cj4gc3RhdGljIGludCBtZXNfdjEwXzFfbXFkX3N3X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsDQo+ICAgICAgICAgaWYgKHJpbmctPm1xZF9vYmopDQo+ICAgICAgICAgICAgICAgICBy
ZXR1cm4gMDsNCj4NCj4gKyAgICAgICBpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0KPiArICAg
ICAgICAgICAgICAgZG9tYWluIHw9IEFNREdQVV9HRU1fRE9NQUlOX1ZSQU07DQo+ICsNCj4gICAg
ICAgICByID0gYW1kZ3B1X2JvX2NyZWF0ZV9rZXJuZWwoYWRldiwgbXFkX3NpemUsIFBBR0VfU0la
RSwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQU1ER1BVX0dFTV9ET01B
SU5fVlJBTSB8DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFNREdQVV9H
RU1fRE9NQUlOX0dUVCwgJnJpbmctPm1xZF9vYmosDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGRvbWFpbiwgJnJpbmctPm1xZF9vYmosDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICZyaW5nLT5tcWRfZ3B1X2FkZHIsICZyaW5nLT5tcWRfcHRyKTsN
Cj4gICAgICAgICBpZiAocikgew0KPiAgICAgICAgICAgICAgICAgZGV2X3dhcm4oYWRldi0+ZGV2
LCAiZmFpbGVkIHRvIGNyZWF0ZSByaW5nIG1xZCBibyANCj4gKCVkKSIsIHIpOyBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMV8wLmMgDQo+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMV8wLmMNCj4gaW5kZXggM2FkYjQ1MGVlYzA3Li43OWE0
ZDJiZmQ5NGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192
MTFfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTFfMC5jDQo+
IEBAIC05ODcsNiArOTg3LDcgQEAgc3RhdGljIGludCBtZXNfdjExXzBfbXFkX3N3X2luaXQoc3Ry
dWN0IA0KPiBhbWRncHVfZGV2aWNlICphZGV2LCAgew0KPiAgICAgICAgIGludCByLCBtcWRfc2l6
ZSA9IHNpemVvZihzdHJ1Y3QgdjExX2NvbXB1dGVfbXFkKTsNCj4gICAgICAgICBzdHJ1Y3QgYW1k
Z3B1X3JpbmcgKnJpbmc7DQo+ICsgICAgICAgdTMyIGRvbWFpbiA9IEFNREdQVV9HRU1fRE9NQUlO
X0dUVDsNCj4NCj4gICAgICAgICBpZiAocGlwZSA9PSBBTURHUFVfTUVTX0tJUV9QSVBFKQ0KPiAg
ICAgICAgICAgICAgICAgcmluZyA9ICZhZGV2LT5nZngua2lxWzBdLnJpbmc7IEBAIC05OTgsOSAr
OTk5LDExIEBAIA0KPiBzdGF0aWMgaW50IG1lc192MTFfMF9tcWRfc3dfaW5pdChzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwNCj4gICAgICAgICBpZiAocmluZy0+bXFkX29iaikNCj4gICAgICAg
ICAgICAgICAgIHJldHVybiAwOw0KPg0KPiArICAgICAgIGlmIChhbWRncHVfc3Jpb3ZfdmYoYWRl
dikpDQo+ICsgICAgICAgICAgICAgICBkb21haW4gfD0gQU1ER1BVX0dFTV9ET01BSU5fVlJBTTsN
Cj4gKw0KPiAgICAgICAgIHIgPSBhbWRncHVfYm9fY3JlYXRlX2tlcm5lbChhZGV2LCBtcWRfc2l6
ZSwgUEFHRV9TSVpFLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBTURH
UFVfR0VNX0RPTUFJTl9WUkFNIHwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgQU1ER1BVX0dFTV9ET01BSU5fR1RULCAmcmluZy0+bXFkX29iaiwNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZG9tYWluLCAmcmluZy0+bXFkX29iaiwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnJpbmctPm1xZF9ncHVfYWRkciwgJnJpbmct
Pm1xZF9wdHIpOw0KPiAgICAgICAgIGlmIChyKSB7DQo+ICAgICAgICAgICAgICAgICBkZXZfd2Fy
bihhZGV2LT5kZXYsICJmYWlsZWQgdG8gY3JlYXRlIHJpbmcgbXFkIGJvIA0KPiAoJWQpIiwgcik7
DQo+IC0tDQo+IDIuMzcuMw0KPg0K
