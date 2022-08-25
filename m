Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A77C28D13
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 12:54:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23B2110E1C2;
	Thu, 25 Aug 2022 12:54:52 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94C3610E1C2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 12:54:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeXI+BB9VOQITLEtLMzq7XfTFZnp9Z1Ia8HozQk3dowhy4k1JretwOjbBtEeDC3Zqq8Dl2VAf5JrXtNUszWmku4jY3Jx3PP0agYL9nLPSISThcOJ+ZLfQOSXoc7vC0ferNY/eK3yW/4T3/NBsIuikm/ddGUAxERG2HyuAAfQHcwvx8XPKvODu5IFlMC8dhuI7pBNAf9AsFlHt5cWtWNDE0uNS5IzduQlfEyXtVSovVKuc9GrWFQubDZbKUglMfir2TiMa928j2F01qGXMGVXmzFDNBFPfeV2ZNFpm7oVb+1QhONG5YYpoc8yKZiY8BccRAWNoOxfZY44X6RvSeugxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgvnTlAKA9n+GszFVo09Pqeeo5rcnOXWkdzEsFC4mA8=;
 b=CmXyKOLpScCBf2dXHc4tqZlq6meso8sj526cE590bs/v4WMEy+dgRF+GN7yDM4HZXdZozvyyKNLPzhZASqFrQv6ksg9wXN7uDXm9qbF7GeBcBRJ9jTL0Nu2KUkGadn2T8WDMrd2F2UJ7mhDgyUPFvXr1f85Eiol5KiDQb6ZwYYild43mzYM+hZYImU9UQUrxszwCwLaOzWwhoDnfnr+hc+7KtxPLHkAaDCHtVKXIvZoackseC5KNkHnkAfFyA+DHfLBko5z1njw1WVebSH3fD9A32COspnbyE73SPxCJClaWezrSjt40qUKepkRP5LxuabaKHmP7kC07ImDW8eSi0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgvnTlAKA9n+GszFVo09Pqeeo5rcnOXWkdzEsFC4mA8=;
 b=AlSzMFFWJL23Fic0ZW1zA0MfCnnVdIKDVknN2l7B8yJ3Wn1NWJUYLS0HVZlJ+vSAktb7nZUJWOnup2MWtb30xDzlCswZZYFtOXwW0Z4rg+RUBEvm7XQL0tRTczd1dTL5O8ropSKJp5KWRj5OSw07YIXg/qSrJdoeImNcBD0R2tU=
Received: from DM5PR12MB1308.namprd12.prod.outlook.com (2603:10b6:3:76::7) by
 CY4PR12MB1206.namprd12.prod.outlook.com (2603:10b6:903:3b::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.18; Thu, 25 Aug 2022 12:54:47 +0000
Received: from DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::5097:87be:3557:c681]) by DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::5097:87be:3557:c681%5]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 12:54:47 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Handle potential NULL pointer dereference
Thread-Topic: [PATCH] drm/amdgpu: Handle potential NULL pointer dereference
Thread-Index: AQHYsLzZTS2TJPBDNkGN/BMXH268U62/jwIAgAANeICAAALpQIAAAnjw
Date: Thu, 25 Aug 2022 12:54:46 +0000
Message-ID: <DM5PR12MB1308E2A5CC5682F7DA944BFD85729@DM5PR12MB1308.namprd12.prod.outlook.com>
References: <20220815153123.138156-1-kent.russell@amd.com>
 <DM5PR12MB1308B61FF812A91CA0FC77EC85729@DM5PR12MB1308.namprd12.prod.outlook.com>
 <4f4292c0-7841-a955-c07c-1eb8f1aa9293@amd.com>
 <DM5PR12MB1308A8C9A177803B3FF55D9185729@DM5PR12MB1308.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1308A8C9A177803B3FF55D9185729@DM5PR12MB1308.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-25T12:54:45Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a0c47242-6dbf-467a-9b62-8ac9a9a179fc;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 031b24ae-5d76-4e20-9c93-08da8698fd54
x-ms-traffictypediagnostic: CY4PR12MB1206:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R5SdpQv93kgf1eenVHCr8/kwUOG4O1tQzUR+O3iCQSiT+I9lda3e3XWQq0YcbVIy0xMaUt5EkJg769/8DUsu91h3DKr/HDhmtkGm9JXZTmq+4UOBkgevtbBsToMUYwnHvMacg6S4OkmH7k4ss7tpyudpwrBMDUwMhjTAIdSe4Tl75qdBmf3deUGfxtSWmYVAQeat4BCxi9kopjSP73ZVimf8pwN1oMk12PM3UKmIWC3mbR795uCuzZRn5f6tKqaRem0b526LA0E3oAAmbkfntLoEo6F1vlb5bMEbdtNAynEC2UAaKgabmznGP5S4CSJj6UAW5Aq4K5UA4iqCCujs+sf5muD8FxD3waveq6cjKyauSsfAI7rLZz8/ToUrhcjUUxxrzOJaibK7bSCFmo0s8DOVFFKrEpXbcYe81h8MhoefpdB8I4ODodAcxm67HQ2XPkA3ZVh0LoOntQwjGnHy4/D+v8d1qMHC+QwBpcZRr+V9qsS44f3X1tJJi488dj4BGWwg1YQUW/NCCL983YluwXbvUqWaJpGN+MRUWUNUcDEyysgr75G1kXjH9GYBHCXzhU19oB+6ndOBdzLNRENgVcg8ympZe5hS6dMMdr06hFhmQYSeh4XYu0rDvDGqPEUNSayXPkEMgoGwMBm0hWitJ9D+qlTzPK3i7hLK4tIxnRpeVNRYvKaWL9x1ALSc9ClEtmn/8ZrjO2+SPbF5mYJPIglEVTE13wvgPs8aU2XkfvUW3K5vzMwLnpLJd6XBEfiMSGHjLrPE1NlFuw1I5Huplg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(110136005)(4326008)(2940100002)(316002)(52536014)(66476007)(66946007)(66556008)(64756008)(55016003)(8676002)(8936002)(5660300002)(38100700002)(122000001)(2906002)(66446008)(76116006)(38070700005)(86362001)(33656002)(6506007)(9686003)(53546011)(7696005)(186003)(478600001)(41300700001)(26005)(83380400001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3NFWHFMbGZ0cHZtTkhmc3R4cmVIQVpRR2p6RDRzLzVGbXNMQ3ZBMjZwcnhM?=
 =?utf-8?B?VVF0Wm9OZnVORkk5WjZoMzBLTkF3S3NVT0ZpcnFDOG9aVW5KRUlNb2lQNG9D?=
 =?utf-8?B?Y25XQityQk9vYlpIaWpRcSt0REEyYzhDZ2lYMUsxNHk0V2t0U1F0cFQwdkdp?=
 =?utf-8?B?RDRIZFVKdzc0cDBqaFpDSzB6M2MxOU41S2JsSHFUYkxLMkpJU2JNcFNJR1pN?=
 =?utf-8?B?NVVvdmNra0ZYMlArdllHOXY2a2ZBZm5laTNUWWxVM2FmeVd5eElJK2pVWkU0?=
 =?utf-8?B?dTRPUG9nRWYzNXE3U3FxVXF5MDRyNFdXbUljT1BabjNkSGZCdmNxWFdOUFVp?=
 =?utf-8?B?emN6ZnRzYlUxWnN5MGRzVXRKNm82eU1mbEh3bEt2SDNnRlQ5MXN3MUxST0kz?=
 =?utf-8?B?S3Y2OG5SOFBCWUNlZC80ekRkYlYxcFZxWjJWck1BOVA1RkxqeEpTcTNmVEpa?=
 =?utf-8?B?MjVoR25kMjVRQVBmSkJabUd5N3JQd292NG5yUlNZN1pyMm9hM0dzaW5iVmpC?=
 =?utf-8?B?ZkpvU1FsSlN3enJuNEhBKzMrYXFwSTJ4bDJWVGRzRDdBcG5YQXhBNVRSSy9D?=
 =?utf-8?B?eWJ4d3RyTXI4VlNDZEJsZU92M25ZWkM5V2tPdjZVZHV6dStuQkIxMDF3Q0U3?=
 =?utf-8?B?dllwdFlGYXBQYXVENGp2b1BwbkFYYnBDVkMrOWxVd1M5Y1V4T1BKQmRwTzUy?=
 =?utf-8?B?MDl4TTZIUEV4aUxYeTVtMEpUK2NCbzBCN2tERmtvUzdSdEw1ZWRpdXZnY3M3?=
 =?utf-8?B?U2wzVG5oYUU3SjV0S0FPeU9rU1BTejU4bU56Y3ozdFRTenpHY3JTRjN3djBH?=
 =?utf-8?B?TkxHTW5UaTlQMlcyL0ZIc2xRM1J4UGMxUVJCQmtkZHBLUHZqeEhFZk43L1A1?=
 =?utf-8?B?S0tOQVRaNmFYdk9SYnNqaGJ4ajRiOEd6UnJDcU9XZHNMaGxFUjhxKzhlNmxN?=
 =?utf-8?B?WFU4Zk16TXIyU2F3Q25CZHVPNmQyZm1Sa0dtellrWVlEQ1ZJaUVyTWdqdTJL?=
 =?utf-8?B?c3ZIZG42TkY2WVUxUTdhSWg2NDNpT0Vzek44T25JcGdJOVY4VVlUbHczbDZw?=
 =?utf-8?B?Nm9jckRsOUNvWkNwYytqdUM2bDJuMEw1RDhJekNpZUVINCtKNEhtT1M0NHlz?=
 =?utf-8?B?ZHBTelFGS1RRNmVMZU9wUjJUYWtma1Jlb3diUnBaeGZNY3JNN2swL2R5NG81?=
 =?utf-8?B?clNCMDkyN2VZUmthZnZUZE5LQTZjeGVET3J6RUZFRXlHN1hvVGVlVFAxWmNI?=
 =?utf-8?B?NDduN0NTWlBwOXdlR2o3WTdVeERwV1pFbjdHaXFtZmN2RzVYdmtVV1UzRjRz?=
 =?utf-8?B?dGZheVQySWpWditwRmtmRFlNQWc5VktNbldzeUVnbVErcGpPckMyY05mNVkw?=
 =?utf-8?B?ZW5lbWRjZHFuRlI5Y0d4NDV4dFFDUDJVSTFRaUZYTFViQWpOd0dXWHlzR2h2?=
 =?utf-8?B?WXpEUWFUK2xMeFJWeTZTVlNFejBqS1g4VEdCR1pTRE1waXp0Q2crZmFuK3FG?=
 =?utf-8?B?R2MvQWpSdHVSazRGWjVONGgvRmJOOEtWQzBHREM4ZkFQSVFxZUhpU09xTk1X?=
 =?utf-8?B?Z1ZGcXNRSVRqZURmZDZubTB4dlR5SDd1TktnWVhRc3FLTzFZbm5lWW4zaUZl?=
 =?utf-8?B?Njg0YUFhQXBGY3F5OXpFbzgrREFqRVZVVFpudjBod2dlc3I3ZjhUa21JK24v?=
 =?utf-8?B?UVNNTDhiZkJuckJISmc0OGNqNitjaUFJQjdsREVYTXFFaUFyQzhKZkJyb2Ry?=
 =?utf-8?B?Wng1cnR6Qm5RaGI5NWxjLzY4d3ZEZ2F5bG1abXEvNXhyMXIzWVg2WEttOVpN?=
 =?utf-8?B?S1RxL3RuNDAwNy9vNnNKbVEyaWpQYTdnekhFM3I4c3lWeFUrblZPWkF4Y0xZ?=
 =?utf-8?B?eWdIOUg1RVJlOW1Lb2JqVFREYk1Qc1dmckhIeHZ0Rnk0TmppMjFDSlU4Z0or?=
 =?utf-8?B?aVB2YjVYZ1dhNDlWc1AzRDdxV05yT2YvWTdhMmVhV1IvRUJ5VkVEUGJsQmdl?=
 =?utf-8?B?OC8wY0ZHcWtuS0RzWU5OUEdnd2ErazJ4amNrSkF1eUp1S3hMSmNDcE5ONndp?=
 =?utf-8?B?VFM3N1hjMUs2SDNpWUtEMHRVdEN1VmJaSXZyOW9PdThvMytvcnZ3QkZzSjc2?=
 =?utf-8?Q?o0+c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 031b24ae-5d76-4e20-9c93-08da8698fd54
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 12:54:46.9209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/KNiM9CofckqXeabCsx+WuSo+FH5udYcWdXVNemzvE7hcRzCx8A66tD9G2VaWwb+sdBcXBiKIXakDLR5vjW3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1206
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
Cc: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkl0IGRvZXMgaW5kZWVkIHNob3J0
LWNpcmN1aXQgb24gfHwgKElmIHRoZSBsZWZ0IHNpZGUgb2YgYW4gfHwgc3RhdGVtZW50IGlzIG5v
dCAwLCBpdCBkb2Vzbid0IGV2YWx1YXRlIHRoZSByaWdodCBzaWRlIGFuZCByZXR1cm5zIHRydWUp
LiBTbyB3ZSBjYW4gaWdub3JlIHRoaXMgcGF0Y2gsIHNpbmNlIGNoZWNraW5nIGZvciBlYWNoIGlu
ZGl2aWR1YWwgZmllbGQgb24gdGhlIDJuZCB0ZXJtIGlzIHByb2JhYmx5IG92ZXJraWxsLiBXZSB3
ZXJlIHN0aWxsIGludmVzdGlnYXRpbmcgd2hhdCBnb3QgcGFzc2VkIGluIGFuZCB3aHkgaXQgd2Fz
bid0IHZhbGlkLCBzbyBJJ2xsIGRyb3AgdGhpcyBmb3Igbm93LiBUaGFua3MgTGlqbyENCg0KIEtl
bnQNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngt
Ym91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBSdXNzZWxsLCBLZW50
DQpTZW50OiBUaHVyc2RheSwgQXVndXN0IDI1LCAyMDIyIDg6NTIgQU0NClRvOiBMYXphciwgTGlq
byA8TGlqby5MYXphckBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNj
OiBHaGFubmFtLCBZYXplbiA8WWF6ZW4uR2hhbm5hbUBhbWQuY29tPg0KU3ViamVjdDogUkU6IFtQ
QVRDSF0gZHJtL2FtZGdwdTogSGFuZGxlIHBvdGVudGlhbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVu
Y2UNCg0KW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkdvb2QgcG9pbnQsIGFz
IGlmICgxIHx8IDApIHNob3VsZCBzaG9ydC1jaXJjdWl0IGF0IHRoZSBpZiAoMSkgcGFydC4gVGh1
cyB3ZSBzaG91bGQgZ28gZG93biB0byBOT1RJRllfRE9ORSBpZiBtIGlzIE5VTEwuIFlhemVuIGNh
biBjb25maXJtIGhlcmUsIGFzIGhlIHdhcyB0aGUgb25lIHdobyB3aXRoIG1lIHdoZW4gd2UgZm91
bmQgdGhlIG9yaWdpbmFsIGlzc3VlLiBJdCdzIHBvc3NpYmxlIHRoYXQgb25lIG9mIHRoZSAzIG1l
c3NhZ2UgZmllbGRzIHdhcyBOVUxMIGluc3RlYWQgb2YgdGhlIGFjdHVhbCBtZXNzYWdlIGluIG91
ciByZXBybyBzaXR1YXRpb24sIGJ1dCBJJ2xsIGRvdWJsZS1jaGVjayB0aGUgc2hvcnQtY2lyY3Vp
dCBzaWRlIG9mIEMgdG8gY29uZmlybS4gSSBrbm93IGl0IHNob3J0IGNpcmN1aXRzIGZvciAmJiwg
SSBkb24ndCBrbm93IGlmIGl0IGRvZXMgZm9yIHx8Lg0KDQogS2VudA0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4gDQpT
ZW50OiBUaHVyc2RheSwgQXVndXN0IDI1LCAyMDIyIDg6MzQgQU0NClRvOiBSdXNzZWxsLCBLZW50
IDxLZW50LlJ1c3NlbGxAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpD
YzogR2hhbm5hbSwgWWF6ZW4gPFlhemVuLkdoYW5uYW1AYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBb
UEFUQ0hdIGRybS9hbWRncHU6IEhhbmRsZSBwb3RlbnRpYWwgTlVMTCBwb2ludGVyIGRlcmVmZXJl
bmNlDQoNCg0KDQpPbiA4LzI1LzIwMjIgNToxNiBQTSwgUnVzc2VsbCwgS2VudCB3cm90ZToNCj4g
W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQo+IA0KPiBGcmllbmRseSBwaW5nDQo+
IA0KDQpXb25kZXIgaG93IGl0IGdvZXMgYW55IGZ1cnRoZXIgd2hlbiBtIGlzIE5VTEwuIEl0IHNo
b3VsZCBkbyBzaG9ydGN1dCBldmFsdWF0aW9uIGFuZCByZXR1cm4gTk9USUZZX0RPTkUsIHJpZ2h0
PyBPciBpcyB0aGlzIGZvciBiZXR0ZXIgcmVhZGFiaWxpdHk/DQoNClRoYW5rcywNCkxpam8NCg0K
PiAgIEtlbnQNCj4gDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJ1c3Nl
bGwsIEtlbnQgPEtlbnQuUnVzc2VsbEBhbWQuY29tPg0KPiBTZW50OiBNb25kYXksIEF1Z3VzdCAx
NSwgMjAyMiAxMTozMSBBTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4g
Q2M6IEdoYW5uYW0sIFlhemVuIDxZYXplbi5HaGFubmFtQGFtZC5jb20+OyBSdXNzZWxsLCBLZW50
IA0KPiA8S2VudC5SdXNzZWxsQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdw
dTogSGFuZGxlIHBvdGVudGlhbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UNCj4gDQo+IElmIG0g
aXMgTlVMTCwgd2Ugd2lsbCBlbmQgdXAgcmVmZXJlbmNpbmcgYSBOVUxMIHBvaW50ZXIgaW4gdGhl
IHN1YnNlcXVlbnQgbSBlbGVtZW50cyBsaWtlIGV4dGNwdSwgYmFuayBhbmQgc3RhdHVzLiBQdWxs
IHRoZSBOVUxMIGNoZWNrIG91dCBhbmQgZG8gaXQgZmlyc3QgYmVmb3JlIHJlZmVyZW5jaW5nIG0n
cyBlbGVtZW50cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtlbnQgUnVzc2VsbCA8a2VudC5ydXNz
ZWxsQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9yYXMuYyB8IDUgKysrKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Jhcy5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
YXMuYw0KPiBpbmRleCBhYjliYTVhOWMzM2QuLjAyODQ5NWZkZmE2MiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYw0KPiBAQCAtMjgzOCwxMiArMjgzOCwxNSBA
QCBzdGF0aWMgaW50IGFtZGdwdV9iYWRfcGFnZV9ub3RpZmllcihzdHJ1Y3Qgbm90aWZpZXJfYmxv
Y2sgKm5iLA0KPiAgIAlzdHJ1Y3QgZWVwcm9tX3RhYmxlX3JlY29yZCBlcnJfcmVjOw0KPiAgIAl1
aW50NjRfdCByZXRpcmVkX3BhZ2U7DQo+ICAgDQo+ICsJaWYgKCFtKQ0KPiArCQlyZXR1cm4gTk9U
SUZZX0RPTkU7DQo+ICsNCj4gICAJLyoNCj4gICAJICogSWYgdGhlIGVycm9yIHdhcyBnZW5lcmF0
ZWQgaW4gVU1DX1YyLCB3aGljaCBiZWxvbmdzIHRvIEdQVSBVTUNzLA0KPiAgIAkgKiBhbmQgZXJy
b3Igb2NjdXJyZWQgaW4gRHJhbUVDQyAoRXh0ZW5kZWQgZXJyb3IgY29kZSA9IDApIHRoZW4gb25s
eQ0KPiAgIAkgKiBwcm9jZXNzIHRoZSBlcnJvciwgZWxzZSBiYWlsIG91dC4NCj4gICAJICovDQo+
IC0JaWYgKCFtIHx8ICEoKHNtY2FfZ2V0X2JhbmtfdHlwZShtLT5leHRjcHUsIG0tPmJhbmspID09
IFNNQ0FfVU1DX1YyKSAmJg0KPiArCWlmICghKChzbWNhX2dldF9iYW5rX3R5cGUobS0+ZXh0Y3B1
LCBtLT5iYW5rKSA9PSBTTUNBX1VNQ19WMikgJiYNCj4gICAJCSAgICAoWEVDKG0tPnN0YXR1cywg
MHgzZikgPT0gMHgwKSkpDQo+ICAgCQlyZXR1cm4gTk9USUZZX0RPTkU7DQo+ICAgDQo+IC0tDQo+
IDIuMjUuMQ0KPiANCg==
