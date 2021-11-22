Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1CCC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 15:25:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC78789B4D;
	Mon, 22 Nov 2021 15:25:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A69089B4D
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 15:25:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWs/Wdbi6qfY+Hmk7S8XGXb0kDn1U3FQNieF0TIsQ23G3hloXtQeqInTYNVvIAezsqOkYhc4JxzaEGv+Bn6J+Yz/Cuy4IN7qsBWfG12l2akyztUJrTbxOQnZVkYD/jZ71qU11ngDiCvaLtFfd4qUpS+I66nhbvlbG7Ng0sHFqoKFjJSKPURcL4yZINEku5baAeLlVSdP4uRBVBBWJumPpdti9J34cxWTPq7rqdlGZTLDnlJ3rUcepBY+dqZprmXQhuIPccfQWLzpCyoYBMz4JdHWgHoVqSZWKklMB9Pko+criT9zAZND8izt8hwaryuRZ8GcFz2DMiR6SUn4i7QrTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fke6wycRPUHQqGkfjPDFpAXwDDAHxYQzv9vgDG0svJM=;
 b=AO7vIOhPjsq9Y3iMywhOGWA+qwbYU3NRJcghaCkabld87UXA1Cpgw8NLz2GtAAnuXTrdmVvd9a1P+84+Mk1RdBmKzDxWzQtP4a5lLx63T7MJBQDQwgL3SbXiclJKjS+dfEg4SZ0Y7c9RWKyUGzG7W7Xim6CsMIefdqDeJCJ1IMm0hrlnv9FZRESSPhPOPc3qtjk3rVM9Kw/r4E7+Eo3nKE+5vbH3gOR4S/qYeP8kMZXMO3K+h/fdCJwY/UuwEcUIs4Xul7avx90sN+WJ6Z2LlToKYb7qNkRoH5AQPpcUQCGRWfBS0KT5gHOhX6nf8OQs4yPbCe/YXBNrq4d4obWe/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fke6wycRPUHQqGkfjPDFpAXwDDAHxYQzv9vgDG0svJM=;
 b=G5YcEHEW9eAiJJk2ZE9MKeZsqxIGGjABRcMrbJZVWvP4fnngUbANOmxuE4PR6XHmGzscj5ETmW8q/M7h9xTBpOum43Dm3ikUyEwwzf+R7QtiJ36cFk8YQTQiVSVb8GXmuOqnaT4DKaT036zYi1NE9DtD571EZVk/MSywgkfJ43Q=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by DM5PR12MB2471.namprd12.prod.outlook.com (2603:10b6:4:b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Mon, 22 Nov
 2021 15:25:08 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::cc36:3d1a:7e4f:154b]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::cc36:3d1a:7e4f:154b%7]) with mapi id 15.20.4713.025; Mon, 22 Nov 2021
 15:25:08 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 2/4] drm/amdkfd: add kfd_device_info_init function
Thread-Topic: [PATCH v2 2/4] drm/amdkfd: add kfd_device_info_init function
Thread-Index: AQHX3X8wIbQKMfKTxkyx0jA/W5l/pawLW2mAgAAFnKA=
Date: Mon, 22 Nov 2021 15:25:08 +0000
Message-ID: <DM6PR12MB30673775BED4A5783F78129C8A9F9@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20211119195258.2173551-1-Graham.Sider@amd.com>
 <20211119195258.2173551-2-Graham.Sider@amd.com>
 <7a682c56-817b-2658-b370-19875e3fe06e@amd.com>
In-Reply-To: <7a682c56-817b-2658-b370-19875e3fe06e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-22T15:25:06Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=3b7597e4-9104-4d27-b949-5e0386b0fe4d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-11-22T15:25:06Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 6eb88c69-3c26-4c27-93ac-c712c0d779bf
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8603f45f-4a8d-46f6-225a-08d9adcc4474
x-ms-traffictypediagnostic: DM5PR12MB2471:
x-microsoft-antispam-prvs: <DM5PR12MB24719441CCD44C28C09F4FF08A9F9@DM5PR12MB2471.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MrGOia+X/jhXc9tUrM+QEEbRVLKwWdchrfNzViixJCZ6mKsrsDSA3lGW9krBUKYRY5EBHwxL3TDe6ht2iDkfT3Ltq40DBaDAv0EDFnGak5CRlChjB06Di/T3bSHFdicRQam7M7Id0kn+r94+8YLpcNKF7Ccn7FoAIKQ2A9tLZ2j1tXpT+Yrm3vwiGjVRLKBowA9RYmUDR0Hg9L6XdtZEn4D3QyqGv5JDDixK3QnG6TnevUY2b5hwS5vE3V4mZGoSeMAebYmfTIBybD0bNBaMjIvhJ03Fnd2EvS1k+7hMvFYMMPeupG6EJbF6R1w4323gHzW5LQHAn3zLgHIheR2WlBsm051nPjJ9WNZUTaknvhRm3vnh5bkW/8q9ktgVYFrgF9hB8rRdDjvp71yaXuHx9gUdvfxA8jEkZa3DnPhJE9XGZRdJFG869dDxI14ThiEHe9Ql4TCvZmbKSeZqeOoEGgjWOqoQBdYrNSf0rH7mdPiaN6ZeINNB0IepWzsjGn1x0/lQF0399RMzWHL1c1WeWSETW5ADyDEnyXJP7ATOKZdlpPm5mfZ4HbWkZt75noHc41wn+Nm4LsaJ9IHIu/W9Yrw8Bj7c5+HgC4wZB4AZUhQhKLJSH2aFzPr3GoQZ0fEe93Tj1vFuc63Mg9gQTddO9uxr/jjJdj33M/GveUVZvIcUK0lF5GCwVxQfMA7Br24GcvC2zIAMFXgzFTz8xxcrDg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(52536014)(4326008)(76116006)(38100700002)(5660300002)(186003)(66946007)(26005)(86362001)(66556008)(38070700005)(508600001)(53546011)(66446008)(6506007)(66476007)(9686003)(33656002)(4001150100001)(8936002)(71200400001)(2906002)(83380400001)(122000001)(55016002)(316002)(110136005)(64756008)(7696005)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXErQzI5K3Q1MVBTSHBhQVhLanZqaDJXQytKeVpZajY0RE9JNitFZHdqbE50?=
 =?utf-8?B?dU1KNm5OUGlEc0U2YTJiTHJmT1R5eG5QeitacjAwN0dDTEpMZ1UxVU9WUXZC?=
 =?utf-8?B?SmtyVnBDNHZhdGR6R1VlUit2OElFYVNXNU9CKy9teTFlMEI5ZkJ1dkFwMmEx?=
 =?utf-8?B?YnB6V0U1ZzhnSllRVTlDVzQrOUN0NjJ5MFRDbWwrb1VsVm9DSjBBa08xenRG?=
 =?utf-8?B?OWgwNEg4cjJkd1FvclNNT0JDdzZPVVF4Z2dpNkxML3pyRVBudlo2N1JaUGJE?=
 =?utf-8?B?N3M4MUtTclNRclY4TTZuQzFNYWtDbHk4a2pYaUpiczcxWGRYSjl0dXZnVUFW?=
 =?utf-8?B?TmcwU29CUGJLckFObzZxdFFvK00yS00yakFOcUN6Ui9UaXJsWGI3UStWSk9U?=
 =?utf-8?B?Z1d5R1JaOUY5RlowdjBKTjU2Z0VhdWVTYzVlNXBaRUxUNzVLQzl1YjBxZVAv?=
 =?utf-8?B?RlN4RjNCc0NvNzZCS3dPd01Fd2NvdGlnYklCenBFRVcxNG9VcnBIUFdyMThm?=
 =?utf-8?B?QXlJdDVMVmxYMG1MWUdFVVlaR21pQm8vUkJ5M3ozbklVZnNwVFBnWUphVzRV?=
 =?utf-8?B?K1ZVVTBRNjFPS2s0TS9Fc2swaGhiWHVGR0NWNGUvOWl0UWdmTDBtNmRwalU3?=
 =?utf-8?B?UnVsWDhlMlNJNFRDNHE3cXBlVzNKalN4T1ZiWCs5NGlZTkdsTzVlc1pDQlo4?=
 =?utf-8?B?ZzFPbm5tTFMrNkF6RTNvVTkvNDVrRFU2Z3M1M3lYSWxMQ1NtS0RHbUxZams2?=
 =?utf-8?B?aWJNbGE5UmtHdGRzSFJlZTlwUWFvdHJlemk0Y2ZaZktoMGpQTWExS1FObGFj?=
 =?utf-8?B?OWtXRVJnM2xVMnU2ZzVITkoxaU0vc25kUEdpSXFhZXgvUUp1a3dnYnRWSm1q?=
 =?utf-8?B?T2dUM25MRUVrTkp2ZHl1YXJVYzRHR09nakFxVElPcUlxa2tlbG85dXk1M1Z5?=
 =?utf-8?B?SzFsNFdSOHFqMERTRTFjY3M2cDJxRmdScFM0N25LVDZKQUY2Y2E2NE0yWmxK?=
 =?utf-8?B?YWx2Tkt2aWhOZFVZOGZGWmU0a2VWMzZ1VlUvRzFmVi9jTUFnU2JqbWVPRXBa?=
 =?utf-8?B?L2crUWZZL0JFOFlUYUMyOEhxVkxsVENER05ac1BxUnVyUXRNd2lDZXBpdEc3?=
 =?utf-8?B?NzFOcjZEVy9Lb0N4VU85TFQrMk5PZ210TTZKdzAxaE44SnlqQ2hvOHZsdHlH?=
 =?utf-8?B?UUlyWFdHc2lyT3JuZjNmRDlkbTVBdHNWYnJOT1VySHJpVmtBRHZYbU9paFZB?=
 =?utf-8?B?NEt0aEpTUHZkSHNSWFNraUs4aFB4cUxTMTNheEhab1Jod2w2Q3JHd0xaaWx0?=
 =?utf-8?B?Y3lmZkk3a0EwcUZFN05TN2xDWDR6cWF3M29POVJFTStnOE1MQlcxb21sUVBo?=
 =?utf-8?B?dmt0dGhhUzkzRTRKTy9qa0szalJQNXRqQVpsOWd2cmh2L1pUeTg5WGJpNkRE?=
 =?utf-8?B?REQwbHhva1RRSFVmeTZNb2J4d2QrbUEwT3pmRUhON0xmVHZnVVQ2dmpRZ3VN?=
 =?utf-8?B?ZGQ4VU9NTUhUYmZ0am5jdTNzRWxRdjFLeC9MRXU4ZlZJeXJ2azVLa2FtcS9l?=
 =?utf-8?B?QmIxdVBwWG8rbVQ1U25pNXpBRzBvZWk3aE8zTDdmVGlIQVh0VTdPKzRNRlVX?=
 =?utf-8?B?RVpnUWlOQ1ZuM3pVQUNDeXd6aGduVmNPREppanB6SlI5RkRYMnBsdjY3UkJ2?=
 =?utf-8?B?akRnbUVJcTMzdWFEZ0NxVG1jYlVkeVREUmhxRXJQTm40Sm1BSjNjOHZjMlEx?=
 =?utf-8?B?RFVGRHR6LzhPbGxNeGRkaXJ4bFl2cTVOTGFndUNFQUI1Vk9waVpnNVFLSjJa?=
 =?utf-8?B?bng4N2tBd0RiUUE4WlJydkVxeHlaaWFUa0tLMURGL3NDN1pveFpTQnBVZTF1?=
 =?utf-8?B?cUVYRC9lQlRuTTZKRjkvWE1IaGcxMkhhQU95RTVabFFUcER0c1oxYlI4a1lE?=
 =?utf-8?B?Y2ZmanhISGdLaUwza052NW54clVMVjVNdzRwdVBLN1IxRnJ2SDNVYlI0ZnZh?=
 =?utf-8?B?MVZ6cGM4VDM1NTgweW45RE5BYnBlaVQxSkZEa1ZiY3pkOUhnK21GZjlyVzdJ?=
 =?utf-8?B?SGc4YUo2alBEc2VtTms2aTU0Q1hjWDB0NVhhaU1IcFAwT1luZWpoUUU1STZx?=
 =?utf-8?B?d2tXNnpOOENaWHE5TEJtS2hLYjdkYUh0cm1yWVVNZFg0L083RGg0ZXNIM1Y3?=
 =?utf-8?B?eWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8603f45f-4a8d-46f6-225a-08d9adcc4474
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2021 15:25:08.2601 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UPKHYejpcCTNsAifkaDZlMraqQAJHiG2N8CoKgNna2sB/v0ooDue0oFX77D7tFL8+QXsL6O3pb7AoxqZeUVVFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2471
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IFNlbnQ6
IEZyaWRheSwgTm92ZW1iZXIgMTksIDIwMjEgNDoyMCBQTQ0KPiBUbzogU2lkZXIsIEdyYWhhbSA8
R3JhaGFtLlNpZGVyQGFtZC5jb20+OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzRdIGRybS9hbWRrZmQ6IGFkZCBrZmRfZGV2aWNlX2lu
Zm9faW5pdCBmdW5jdGlvbg0KPiANCj4gT24gMjAyMS0xMS0xOSAyOjUyIHAubS4sIEdyYWhhbSBT
aWRlciB3cm90ZToNCj4gPiBJbml0aWFsaXplcyBkZXZpY2VfaW5mbyBzdHJ1Y3RzIGdpdmVuIGVp
dGhlciBhc2ljX3R5cGUgKGVudW0pIGlmIEdGWA0KPiA+IHZlcnNpb24gaXMgbGVzcyB0aGFuIEdG
WDksIG9yIEdDIElQIHZlcnNpb24gaWYgZ3JlYXRlci4gQWxzbyB0YWtlcyBpbg0KPiA+IHZmIGFu
ZCB0aGUgdGFyZ2V0IGNvbXBpbGVyIGdmeCB2ZXJzaW9uLg0KPiA+DQo+ID4gSW5jbHVzaW9uL2V4
Y2x1c2lvbiB0byBjZXJ0YWluIGNvbmRpdGlvbnMgZm9yIGNlcnRhaW4gR0MgSVAgdmVyc2lvbnMN
Cj4gPiBtYXkgYmUgbmVjZXNzYXJ5IG9uIG5waSBicmluZ3VwIG9uIGEgY2FzZS1ieS1jYXNlIGJh
c2lzLCBidXQgZm9yIHRoZQ0KPiA+IG1vc3QgcGFydCBzaG91bGQgYmUgbWluaW1hbCAoZS5nLiBh
ZGRpbmcgb25lIHx8IGFzaWNfdmVyc2lvbiA9PQ0KPiBJUF9WRVJTSU9OKFggLFgsIFgpIGNhc2Up
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogR3JhaGFtIFNpZGVyIDxHcmFoYW0uU2lkZXJAYW1k
LmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZp
Y2UuYyB8IDYxDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFu
Z2VkLCA2MSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfZGV2aWNlLmMNCj4gPiBpbmRleCBlMTFmYzRlMjBjMzIuLjY3NmNiOWMzMTY2YyAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMN
Cj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMNCj4gPiBA
QCAtNTExLDYgKzUxMSw2NyBAQCBzdGF0aWMgdm9pZCBrZmRfZ3R0X3NhX2Zpbmkoc3RydWN0IGtm
ZF9kZXYgKmtmZCk7DQo+ID4NCj4gPiAgIHN0YXRpYyBpbnQga2ZkX3Jlc3VtZShzdHJ1Y3Qga2Zk
X2RldiAqa2ZkKTsNCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBrZmRfZGV2aWNlX2luZm9faW5pdChz
dHJ1Y3Qga2ZkX2RldiAqa2ZkLA0KPiA+ICsJCQkJIHN0cnVjdCBrZmRfZGV2aWNlX2luZm8gKmRl
dmljZV9pbmZvLA0KPiA+ICsJCQkJIGJvb2wgdmYsIHVpbnQzMl90IGdmeF90YXJnZXRfdmVyc2lv
bikNCj4gDQo+IFRoaXMgd2lsbCBnaXZlIHlvdSBhIGNvbXBpbGUgd2FybmluZyBhYm91dCBhbiB1
bnVzZWQgc3RhdGljIGZ1bmN0aW9uLg0KPiBNYXliZSBzcXVhc2ggdGhpcyB3aXRoIHRoZSBjb21t
aXQgdGhhdCBhY3R1YWxseSBzdGFydHMgdXNpbmcgdGhpcyBmdW5jdGlvbi4NCj4gDQoNClNvdW5k
cyBnb29kLg0KDQo+IA0KPiA+ICt7DQo+ID4gKwl1aW50MzJfdCBnY192ZXJzaW9uID0gS0ZEX0dD
X1ZFUlNJT04oa2ZkKTsNCj4gPiArCXVpbnQzMl90IGFzaWNfdHlwZSA9IGtmZC0+YWRldi0+YXNp
Y190eXBlOw0KPiA+ICsNCj4gPiArCWRldmljZV9pbmZvLT5tYXhfcGFzaWRfYml0cyA9IDE2Ow0K
PiA+ICsJZGV2aWNlX2luZm8tPm1heF9ub19vZl9ocWQgPSAyNDsNCj4gPiArCWRldmljZV9pbmZv
LT5udW1fb2Zfd2F0Y2hfcG9pbnRzID0gNDsNCj4gPiArCWRldmljZV9pbmZvLT5tcWRfc2l6ZV9h
bGlnbmVkID0gTVFEX1NJWkVfQUxJR05FRDsNCj4gPiArCWRldmljZV9pbmZvLT5nZnhfdGFyZ2V0
X3ZlcnNpb24gPSBnZnhfdGFyZ2V0X3ZlcnNpb247DQo+ID4gKw0KPiA+ICsJaWYgKEtGRF9JU19T
T0MxNShrZmQpKSB7DQo+ID4gKwkJZGV2aWNlX2luZm8tPmRvb3JiZWxsX3NpemUgPSA4Ow0KPiA+
ICsJCWRldmljZV9pbmZvLT5paF9yaW5nX2VudHJ5X3NpemUgPSA4ICogc2l6ZW9mKHVpbnQzMl90
KTsNCj4gPiArCQlkZXZpY2VfaW5mby0+ZXZlbnRfaW50ZXJydXB0X2NsYXNzID0NCj4gJmV2ZW50
X2ludGVycnVwdF9jbGFzc192OTsNCj4gPiArCQlkZXZpY2VfaW5mby0+c3VwcG9ydHNfY3dzciA9
IHRydWU7DQo+ID4gKw0KPiA+ICsJCWlmICgoZ2NfdmVyc2lvbiA+PSBJUF9WRVJTSU9OKDksIDAs
IDEpICAmJg0KPiA+ICsJCSAgICAgZ2NfdmVyc2lvbiA8PSBJUF9WRVJTSU9OKDksIDMsIDApKSB8
fA0KPiA+ICsJCSAgICAgZ2NfdmVyc2lvbiA9PSBJUF9WRVJTSU9OKDEwLCAzLCAxKSB8fA0KPiA+
ICsJCSAgICAgZ2NfdmVyc2lvbiA9PSBJUF9WRVJTSU9OKDEwLCAzLCAzKSkNCj4gPiArCQkJZGV2
aWNlX2luZm8tPm51bV9zZG1hX3F1ZXVlc19wZXJfZW5naW5lID0gMjsNCj4gPiArCQllbHNlDQo+
ID4gKwkJCWRldmljZV9pbmZvLT5udW1fc2RtYV9xdWV1ZXNfcGVyX2VuZ2luZSA9IDg7DQo+IA0K
PiBJIGZlZWwgdGhpcyBzaG91bGQgYmUgYmFzZWQgb24gdGhlIFNETUEgSVAgdmVyc2lvbiwgbm90
IHRoZSBHQyBJUCB2ZXJzaW9uLg0KPiANCg0KQ2FuIHRoZSBTRE1BIHF1ZXVlcy9lbmdpbmUgYmUg
ZGV0ZXJtaW5lZCBieSB0aGUgU0RNQSBJUCB2ZXJzaW9ucz8gSSB3b3VsZCBoYXZlIHRob3VnaHQg
dGhvc2Ugd2VyZSBpbnN0ZWFkIGRvbmUgb24gYSBjaGlwLWJ5LWNoaXAgYmFzaXMuIEUuZy4gaW4g
YW1kZ3B1X2Rpc2NvdmVyeS5jIHRoaXMgaXMgaG93IHRoZSBudW1iZXIgb2YgU0RNQSBpbnN0YW5j
ZXMgaXMgZGVmaW5lZC4NCg0KPiANCj4gPiArDQo+ID4gKwkJLyogTmF2aTJ4KywgTmF2aTF4KyAq
Lw0KPiA+ICsJCWlmIChnY192ZXJzaW9uID49IElQX1ZFUlNJT04oMTAsIDMsIDApKQ0KPiANCj4g
VGhlcmUgbmVlZHMgdG8gYmUgYSBtYXhpbXVtIGNoZWNrIGhlcmUuIFRoaXMgY2FzZSBzaG91bGQg
bm90IGF1dG9tYXRpY2FsbHkNCj4gYXBwbHkgdG8gZnV0dXJlIEFTSUNzIGUuZy4gR0ZYMTEuDQo+
IA0KDQpKdXN0IGEgdGhvdWdodCBvbiB0aGlzOiBhc3N1bWluZyBvbiBmdXR1cmUgYXNpY3MgdGhp
cyBmaWVsZCBpcyBnb2luZyB0byBjb250aW51ZSB0byBiZSBwb3B1bGF0ZWQsIG1pZ2h0IGl0IGJl
IGJldHRlciB0byBqdXN0IGNvbnRpbnVlIGFkZGluZyBjYXNlcyBoZXJlIGFzIHRoZXkgYXJpc2U/
IEFkZGluZyBhIGNoZWNrIGZvciBlLmcuIDwgR0ZYMTEsIHdvdWxkIHJlcXVpcmUgZXZlbnR1YWxs
eSBidW1waW5nIHRoYXQgY2hlY2sgdG8gPCBHRlgxMiBhbG9uZ3NpZGUgYW5vdGhlciBjaGVjayBm
b3IgPj0gR0ZYMTEuIFNvIGF0IHRoZSBlbmQgb2YgdGhlIGRheSwgaWYgYSA+PSBjaGVjayBpcyBn
b2luZyB0byBiZSBuZWVkZWQgYW55d2F5LCBpcyBhIG1heGltdW0gY2hlY2sgbmVjZXNzYXJ5PyBP
ZiBjb3Vyc2UgdGhpcyB3b3VsZG4ndCBhcHBseSB0byBiZWxvdyByZWdhcmRpbmcgdGhlIG5lZWRz
X3BjaV9hdG9taWNzIGJvb2wsIHNpbmNlIGFzIHlvdSBtZW50aW9uIG9uIGZ1dHVyZSBhc2ljcyBp
dCBjYW4gYmUga2VwdCBhcyBkZWZhdWx0ZWQgdG8gZmFsc2UuDQoNCj4gDQo+ID4gKwkJCWRldmlj
ZV9pbmZvLT5ub19hdG9taWNfZndfdmVyc2lvbiA9IDE0NTsNCj4gPiArCQllbHNlIGlmIChnY192
ZXJzaW9uID49IElQX1ZFUlNJT04oMTAsIDEsIDEpKQ0KPiA+ICsJCQlkZXZpY2VfaW5mby0+bm9f
YXRvbWljX2Z3X3ZlcnNpb24gPSA5MjsNCj4gPiArDQo+ID4gKwkJLyogUmF2ZW4gKi8NCj4gPiAr
CQlpZiAoZ2NfdmVyc2lvbiA9PSBJUF9WRVJTSU9OKDksIDEsIDApIHx8DQo+ID4gKwkJICAgIGdj
X3ZlcnNpb24gPT0gSVBfVkVSU0lPTig5LCAyLCAyKSkNCj4gPiArCQkJZGV2aWNlX2luZm8tPm5l
ZWRzX2lvbW11X2RldmljZSA9IHRydWU7DQo+ID4gKw0KPiA+ICsJCS8qIE5hdmkxeCsgKi8NCj4g
PiArCQlpZiAoZ2NfdmVyc2lvbiA+PSBJUF9WRVJTSU9OKDEwLCAxLCAxKSkNCj4gDQo+IFRoZXJl
IG5lZWRzIHRvIGJlIGEgbWF4aW11bSBjaGVjayBoZXJlLiBPbiBmdXR1cmUgQVNJQ3MgKG1heWJl
IEdGWDExKSBJDQo+IHdvdWxkIG5vdCBleHBlY3QgYXRvbWljcyB0byBiZSByZXF1aXJlZC4NCj4g
DQoNClNlZSBhYm92ZSwgYWdyZWVkIGhlcmUuDQoNCj4gUmVnYXJkcywNCj4gIMKgIEZlbGl4DQo+
IA0KDQpCZXN0LA0KR3JhaGFtDQoNCj4gDQo+ID4gKwkJCWRldmljZV9pbmZvLT5uZWVkc19wY2lf
YXRvbWljcyA9IHRydWU7DQo+ID4gKwl9IGVsc2Ugew0KPiA+ICsJCWRldmljZV9pbmZvLT5kb29y
YmVsbF9zaXplID0gNDsNCj4gPiArCQlkZXZpY2VfaW5mby0+aWhfcmluZ19lbnRyeV9zaXplID0g
NCAqIHNpemVvZih1aW50MzJfdCk7DQo+ID4gKwkJZGV2aWNlX2luZm8tPmV2ZW50X2ludGVycnVw
dF9jbGFzcyA9DQo+ICZldmVudF9pbnRlcnJ1cHRfY2xhc3NfY2lrOw0KPiA+ICsJCWRldmljZV9p
bmZvLT5udW1fc2RtYV9xdWV1ZXNfcGVyX2VuZ2luZSA9IDI7DQo+ID4gKw0KPiA+ICsJCWlmIChh
c2ljX3R5cGUgIT0gQ0hJUF9LQVZFUkkgJiYNCj4gPiArCQkgICAgYXNpY190eXBlICE9IENISVBf
SEFXQUlJICYmDQo+ID4gKwkJICAgIGFzaWNfdHlwZSAhPSBDSElQX1RPTkdBKQ0KPiA+ICsJCQlk
ZXZpY2VfaW5mby0+c3VwcG9ydHNfY3dzciA9IHRydWU7DQo+ID4gKw0KPiA+ICsJCWlmIChhc2lj
X3R5cGUgPT0gQ0hJUF9LQVZFUkkgfHwNCj4gPiArCQkgICAgYXNpY190eXBlID09IENISVBfQ0FS
UklaTykNCj4gPiArCQkJZGV2aWNlX2luZm8tPm5lZWRzX2lvbW11X2RldmljZSA9IHRydWU7DQo+
ID4gKw0KPiA+ICsJCWlmIChhc2ljX3R5cGUgIT0gQ0hJUF9IQVdBSUkgJiYgIXZmKQ0KPiA+ICsJ
CQlkZXZpY2VfaW5mby0+bmVlZHNfcGNpX2F0b21pY3MgPSB0cnVlOw0KPiA+ICsJfQ0KPiA+ICt9
DQo+ID4gKw0KPiA+ICAgc3RydWN0IGtmZF9kZXYgKmtnZDJrZmRfcHJvYmUoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsIGJvb2wgdmYpDQo+ID4gICB7DQo+ID4gICAJc3RydWN0IGtmZF9kZXYg
KmtmZDs=
