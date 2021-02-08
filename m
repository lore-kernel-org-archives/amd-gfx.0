Return-Path: <SRS0=WKN7=HK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2875C43332
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Feb 2021 10:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2045A64E8F
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Feb 2021 10:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2045A64E8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F20A6E850;
	Mon,  8 Feb 2021 10:00:57 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700063.outbound.protection.outlook.com [40.107.70.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8736A6E850
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Feb 2021 10:00:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLGtPVzRLqDMf57w3WRZyavhADlE5GLX5ba9ss8G7Au67dgkSBjc0/Z25ydr5cDKaxGG/HD9MEM5o1gjzV2Rmq75qCHqcHdHF69Aa6avysZT3sToSqs/QSErZkx5DiTj0uRy2olwV+Xtq2Advr0P9ILRvbFi5w798eATftOzSaIVSqe8kEc2+Hu0hlndA7L7rl/Ac1SlM6VR5KfnFExyXBO0e4y36g7DhJ+hllYr6I3KFtioxRrPJEC/avvzMdP/YUaaRK+fWefAqV9LK1rVU2wJIqKaoPl3ne6xDzmRkeb+S7bf9rlIimlRyqhiXMxRRY2FElGFIP59wuenURo1kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euy9iE15da/MG6eCAept88OkdcknYWctsfbjpFJFh0s=;
 b=X8TIi4wsJbx6LW2yKbRQlFca9TIqMLA8TuMkYQVJtRLQ3oi4qlU8NmBWPNtPMYh8vEtNxi4wX4En/Omh4rPDFWbAVB4nL228wYQxsPdZT+ZdoZbmdl8pvvHBzNRj3n53IsnJJPUzx0ptiRUYwsXJkBJJi/SZ0IIAM7+LiWQIPZaNoSZvFRK5VGMHXtzFW7qoH9Cylb3fOgXFBrNI20L9oCdoou/W9lQB6C6OGtLkdQ+PAsIdQya4NGpb3HMPmSr/RJI1iZlNSUsu1CCUKXufij5Ch3nx9A/Sa7EJStg16SniXgnLfHStsOcP5tQJQZ1GAySx8/etP2O1JGm+mAa3eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euy9iE15da/MG6eCAept88OkdcknYWctsfbjpFJFh0s=;
 b=AxKGRTuDpmAgKLZOKw9gwY3RyuqoKCek3s7hrzyIMVGRl4yZPGkKdOia1YoXHm0zWuV58Bh1HMp3TD8a/MZ/hMLjedqlaY4PjR08GLODeMwGO44jJ1aG4Hg2tBMlPIGrw85FMaFCt32osPkU3j9R36jMOYYZGLH/0eOkPyUOONA=
Received: from DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20)
 by DM6PR12MB2844.namprd12.prod.outlook.com (2603:10b6:5:45::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Mon, 8 Feb
 2021 10:00:54 +0000
Received: from DM6PR12MB4170.namprd12.prod.outlook.com
 ([fe80::382a:bab9:3e67:acac]) by DM6PR12MB4170.namprd12.prod.outlook.com
 ([fe80::382a:bab9:3e67:acac%7]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 10:00:54 +0000
From: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: extend MAX_KIQ_REG_TRY to 1000
Thread-Topic: [PATCH] drm/amdgpu: extend MAX_KIQ_REG_TRY to 1000
Thread-Index: AQHW/d3CShcRJw8T+EGB+PZj41pn4KpN/b4AgAAH4zA=
Date: Mon, 8 Feb 2021 10:00:54 +0000
Message-ID: <DM6PR12MB4170DCA058C4A96998CC8BFBF88F9@DM6PR12MB4170.namprd12.prod.outlook.com>
References: <20210208054555.23421-1-Jiawei.Gu@amd.com>
 <13337a59-f698-a91b-5662-1673e14a3cd7@gmail.com>
In-Reply-To: <13337a59-f698-a91b-5662-1673e14a3cd7@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-08T10:00:40Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c16a9624-24eb-4d3f-aa6c-d7b64e18d068;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 12b3fb50-d8c4-452e-d961-08d8cc186cc6
x-ms-traffictypediagnostic: DM6PR12MB2844:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB28449184228BC73A6B5C91B3F88F9@DM6PR12MB2844.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D/vU3oX5vZWcPA72HVUwBi1mxrgLAnS5lFGcTT6toHJXxErUpWJ0kRh5PjAB+GtkiGR+gYpTItHm3if/EGRBoPCq8ONHKEyDAtr79onHMJ3eLTRP4pA0EQ0GSXkjtYiJOeG0IDDg3zdqxXHsjCUZDtG4TXnXodxz8U5LpZG1O7tUJhP9dQPnMZWh2mtM7LNU+5Ts06RpE2pSaQFooNhd8A6V1NVlwlLCUf5/d4AeIpLbYPWzv2gLclna/RsjaA/hozY+N4VFIz+Lwe0p34SqgHQ7LLIbIumjyl/DKcg4ioyvscqwtftsR6El22aW5YO7/OCkItIzGNqWyMctCNUsZjkCb0QsBw4zMHWPJuvTW3lF/Hgjn6nSdBNw2O9ymOnAY05ZlG2+ZWFIugznE8NwHAb9FzfjemCvCL77CgMx7hOqjfMpQLxBLIpkV1SGBrgXn1U12fBm9begA3oMssk2mzAqL0gtQXHsnQpDhxzAxf98t5YtojRp88v/IkK5BIISQuoxfWme4O0Eq8RjL5767w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(316002)(83380400001)(66574015)(86362001)(76116006)(7696005)(52536014)(33656002)(8936002)(186003)(55016002)(9686003)(478600001)(2906002)(110136005)(66556008)(66476007)(71200400001)(26005)(64756008)(4326008)(66446008)(8676002)(5660300002)(6506007)(53546011)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?MEVUaXdzZzlVUEY0MitaZCttMXBrU0ZJK0xscVByV0I5ZnowNXllOGJGdExr?=
 =?utf-8?B?S1hwSTQwakg3R0REd0dWM2h3MFpuaWhTSHFLNmc2cTlCVVJmOTFucjJ1S21r?=
 =?utf-8?B?SW13NDhacExZZWZsaDJtdlFPdml6SWxxV0hyZHpKVE9iUm56bmprd2VwUjJE?=
 =?utf-8?B?RTU5MkdYV3dLMFlmYkFKUVI2OXpwVEZyN1RWbGZJQ3N5NGNmVFJsT20vQ3ZI?=
 =?utf-8?B?U2NRMEVDRytCYStKSGZyS2NFOEhUeWdpMVR1ODZaM01iVTE5MUxXcm8wS2VJ?=
 =?utf-8?B?YzIwT28veTA0bmRNa0RtMkJxQkwreHgzNTNPeVNPSkNWNTNUWE56REdQTG43?=
 =?utf-8?B?cDg1OVQ3YWpHcWVuVUQ5ZDc3SERBTm9nQjVGRndDZ1lHeHpWdXlCY2tmN1p4?=
 =?utf-8?B?QmpxazN4eW9kOXl4TWhGRmIzNzZ1bm8vYXRpVHhHN3N5Rmw3alZ2Ti94RmZj?=
 =?utf-8?B?QnY4YnpHdXBMYkRJelVtdG12Uk9Iczl2MjU5RUp5TEZqdnZ2UkRtZkJpMGtV?=
 =?utf-8?B?SmJ1UUk1SHhRQ0E5TjlwUkhBKzhYQjZBQnQvVVJabDZHTVBVNFZkV25QSTB3?=
 =?utf-8?B?dXRsNXhCY1FWMnJ2SHoxRnE4M2VyUTRlSnIxUDJSVWdiZWxzL1JZREpVK0Q2?=
 =?utf-8?B?bmFac2RZSGtjUnpKWG5INzU5WE82TFgyMWZBZDdaQlFTOW03OHNaSVBrVlla?=
 =?utf-8?B?REJtSGd0ZGlqRUhGakQzT0QzaFhkTGpTamhmTkFaMlR4YmdoL2FPMmVGK0VS?=
 =?utf-8?B?bUw2RG5HRFFQVDJkSzd1OVJEbkZxRS9NaEVkdTBZMkF2ZkkrMllMWWtDa2Fw?=
 =?utf-8?B?WkxubEcyOXBTY1NVTkQyeHNRbDdmUm9mNVR6elhoMXFxZzRyamYzNUhuNEJv?=
 =?utf-8?B?b0JIcmw1dGZ6N2s3amxEN3FQTHJ3c1pBblpnMjhjRWJaN21WYXNtc2JqNFI0?=
 =?utf-8?B?NklGUGE0ZHlaaWVpd3AzNFN6R0RLSTZoWHZnekVHRDgyc3dhaWNQaXU0Tklu?=
 =?utf-8?B?cUNCK2FrZXNhSzhpS0xxSGc0S2s2aHhTUjIrVlB6ZXRwWEk0WTA1ZVRRWGlt?=
 =?utf-8?B?dEFibndPazZKdkFKbjRONWErSDRJaHZQV3N0Sm96MWN3TTMxWXUzVE5ZNDJv?=
 =?utf-8?B?SnlFbllLNjRZeFRDT256T1dBYjhFTzRDV2EwTmdoYURwalQzaUVSeGFPMlAv?=
 =?utf-8?B?bkMwM2dyVGxIcFBzb0hyZkNsU01EeTVaNWJvWXdLYTU1NEp3U2FoVW5tbzY1?=
 =?utf-8?B?bFN6WGFHUFdnMCtZY3VpYlZQY1RtZEluTGJ1MFVyTlhtZkpsVWExZU9IbnVs?=
 =?utf-8?B?a2t0UDZCWHlSekE3SjI0a1hqWm5SQjZGVWZSK2xPVnNEZW1oS0FMb293M1Bl?=
 =?utf-8?B?dmhlS09yYlo2UFJXdVJ0UTlRL01vQXVJZUp0YmpxcEplSUgyZmpucUFISHpV?=
 =?utf-8?B?MGpXNktFWDdZZ2tIeG9ObUNXT0cwOThRSG5kdks0WHVROEJzTmdiYXdxL3h3?=
 =?utf-8?B?UFUraDlGNTA4Uzk1aDJaaFJGeHFBeGwwaVRJeVBEU3BXQ2VvUG0xc1hqVEV6?=
 =?utf-8?B?QS9PeENqYXlhMC9RZVc2RTVTNit4akZ3RFBXTTlCRWZsTHZkcHgxZDZ4SUU0?=
 =?utf-8?B?TENXbEk2UWMzOCtYZmFTZWRRblArV1lJVGtIOXVxajRibjlsamZMUHU0Z1Vo?=
 =?utf-8?B?eGtUQXJFTXJiejkrL1kycHFaUmptQ0FINXZIdm1sWitzUWVEbEkyOWpjQTVj?=
 =?utf-8?Q?n8slegEPbEouEnpupJ4F2EUlJnnxonrPDjvkyp/?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b3fb50-d8c4-452e-d961-08d8cc186cc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 10:00:54.8122 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JRUrKbeZzAdgkiNINiky972FzBgBpmqr7tJi+pSRLhjEDETGeTX06OFuzCtkE9raY4MqGfThydy+Lc0PCGNY4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2844
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpI
aSBDaHJpc3RpYW4sDQoNClRoYXQncyBob3cgbWFueSB0aW1lcyBpdCB3b3VsZCByZXRyeSBiZWZv
cmUgZ2l2ZSB1cC4NCkFuZCB3ZSBhbHdheXMgc2tpcCB0aGlzIHJldHJ5IHJvdXRpbmUgaWYgd2Ug
YXJlIGluIGludGVycnVwdCwgc28gaXQncyBmaW5lIGZvciBpbnRlcnJ1cHQgY29uZGl0aW9uLg0K
DQpCZXN0IHJlZ2FyZHMsDQpKaWF3ZWkNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiAN
ClNlbnQ6IE1vbmRheSwgRmVicnVhcnkgOCwgMjAyMSA1OjI4IFBNDQpUbzogR3UsIEppYVdlaSAo
V2lsbCkgPEppYVdlaS5HdUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
CkNjOiBEZW5nLCBFbWlseSA8RW1pbHkuRGVuZ0BhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRD
SF0gZHJtL2FtZGdwdTogZXh0ZW5kIE1BWF9LSVFfUkVHX1RSWSB0byAxMDAwDQoNCkFtIDA4LjAy
LjIxIHVtIDA2OjQ1IHNjaHJpZWIgSmlhd2VpIEd1Og0KPiBFeHRlbmQgcmV0cnkgdGltZXMgb2Yg
S0lRIHRvIGF2b2lkIHN0YXJ2YXRpb24gc2l0dWF0aW9uIGNhdXNlZCBieSBsb25nIA0KPiB0aW1l
IGZ1bGwgYWNjZXNzIG9mIEdQVSBieSBvdGhlciBWRnMuDQoNCkluIHdoYXQgdW5pdHMgaXMgdGhh
dD8gV2UgYWxzbyBuZWVkIHRoZSBLSVEgZHVyaW5nIGludGVycnVwdCBoYW5kbGluZyBhbmQgdGhh
dCBsb29rcyBsaWtlICp3YXkqIHRvIGJpZyBmb3IgdGhhdC4NCg0KQ2hyaXN0aWFuLg0KDQo+DQo+
IFNpZ25lZC1vZmYtYnk6IEppYXdlaSBHdSA8Smlhd2VpLkd1QGFtZC5jb20+DQo+IC0tLQ0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oIHwgMiArLQ0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmggDQo+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1LmgNCj4gaW5kZXggNjM5ZGIzMmMxMzgzLi5lMGM3OTdhNWY3Mzkg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+IEBAIC0yODgsNyArMjg4
LDcgQEAgZW51bSBhbWRncHVfa2lxX2lycSB7DQo+ICAgDQo+ICAgI2RlZmluZSBNQVhfS0lRX1JF
R19XQUlUICAgICAgIDUwMDAgLyogaW4gdXNlY3MsIDVtcyAqLw0KPiAgICNkZWZpbmUgTUFYX0tJ
UV9SRUdfQkFJTE9VVF9JTlRFUlZBTCAgIDUgLyogaW4gbXNlY3MsIDVtcyAqLw0KPiAtI2RlZmlu
ZSBNQVhfS0lRX1JFR19UUlkgODAgLyogMjAgLT4gODAgKi8NCj4gKyNkZWZpbmUgTUFYX0tJUV9S
RUdfVFJZIDEwMDANCj4gICANCj4gICBpbnQgYW1kZ3B1X2RldmljZV9pcF9zZXRfY2xvY2tnYXRp
bmdfc3RhdGUodm9pZCAqZGV2LA0KPiAgIAkJCQkJICAgZW51bSBhbWRfaXBfYmxvY2tfdHlwZSBi
bG9ja190eXBlLA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
