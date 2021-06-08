Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB61C47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 15:28:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB22610F8
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 15:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB22610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AFCD6EC1E;
	Tue,  8 Jun 2021 15:28:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D4146EC1E
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 15:28:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsHxYqxpBOTIE78PPCEDyBP2EzJNXhj3abOsdQKtlKlnGVpchQYl6ao9dpeNUWMyajbb5uXHn+QATDGGEnTIJrf0RixnHMFH+l40WKTWMlA6wcyp+d15ezPnuwfSsPihUIJmN5a7HQwJ9+Wa/WfIHrpOdLO2jyyRFUCCtPeFpIh2hlEm/avLIwCQcinixWfcbIasgS+QScvops3oH4tnaEMncA7phisXnDyDrFkuKf9yCHWZjnB0k+bdkjcLZp7eyx409AULwWJwMm8XOWBS2ZjHnSqqASb85FAvYp9yOTS9EwlOmj/AITgfN4CtF6qZ3aW89F5bAXc3JvnyEOGyhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bmTGGo10f2TUl4ekK5JLCjiSUMVHCoXX6DmrmZtNsg=;
 b=jhuSpXV4k1auy6ptA2Ph5IEJlWY8zp1kaLUN3lFd5eY2D7UVhXXsE+TiC0eSRnAcmbDaEDfCwnQccG+UGaJI5aGxhnWFY2PXLTWh95QdR+zw+tUjIsVyW5agFKzqLZxgSNJiZGOeNSpPVwjANXen0Cy8cGbw2UwAjgFPNSk0Eou7uachF3Dt1OfugBng9Irs+WQwda/Uc84tffz135j4ou8X7pRk18QnG9USexzbBfOqbUE1K8fqzqZgrRqsZyQWT2+08fJl7sL6yqvLtB8D1vB8DJuZgt4XBjw2fCsytdGSrQsdmtP9VlprSw2u7oPS7jDQfSqhZEALYCWPNqD8Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bmTGGo10f2TUl4ekK5JLCjiSUMVHCoXX6DmrmZtNsg=;
 b=cw74B0NEOFfYBCr5SQS84aR9nt84PGA9mhox189CZ3UIuYWKz0gx5ZvQwYe4t3Gh3ERydZF7E9sSPBHlq+ICjxLjt5rTuCEpvk0JDXOT9rKn5k0iXudb/D+k0kkN9fkFRydJWHFuNftktxA5jre77tudntMPT+XTk0fi5nYgp3w=
Received: from DM4PR12MB5374.namprd12.prod.outlook.com (2603:10b6:5:39a::11)
 by DM6PR12MB5536.namprd12.prod.outlook.com (2603:10b6:5:1ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Tue, 8 Jun
 2021 15:28:40 +0000
Received: from DM4PR12MB5374.namprd12.prod.outlook.com
 ([fe80::dd20:3f66:e06a:2297]) by DM4PR12MB5374.namprd12.prod.outlook.com
 ([fe80::dd20:3f66:e06a:2297%4]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 15:28:40 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>, =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=
 <ckoenig.leichtzumerken@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 1/1] drm/amdkfd: use allowed domain for vmbo validation
Thread-Topic: [PATCH v2 1/1] drm/amdkfd: use allowed domain for vmbo validation
Thread-Index: AQHXXFlHc0rdXiMVlUCwrXI5L/s446sJ/gWAgAAFmwD///aJAA==
Date: Tue, 8 Jun 2021 15:28:40 +0000
Message-ID: <656B99E1-1579-4BBF-900F-813823FD0760@amd.com>
References: <20210608112714.50475-1-nirmoy.das@amd.com>
 <915174f0-0341-6465-5775-4220de577720@gmail.com>
 <b1c3b109-38d3-cda3-a733-147f904c038d@amd.com>
In-Reply-To: <b1c3b109-38d3-cda3-a733-147f904c038d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.49.21050901
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98ed6ede-2b62-4f05-7e4c-08d92a921813
x-ms-traffictypediagnostic: DM6PR12MB5536:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB55369FDB3AF5C19B9A10AB7480379@DM6PR12MB5536.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ITdX8NyMl2z9VCOEVv6YrSotB+h9hZ0rb0mZC682GcxYt2eF/3HnB/2lPOiu5V3paRfT7RdaBd/chG4XGrk9CNSwLE1NjMiQ6pv6jPUe+5OJGz32OWO14KXKzYeo50GR8Tv+r+jmvEbixtHq3j1jDDVeeT5eeuh5kvIiF3E0YFZrzKFbNqIsisr1Flz9DxAPh9wAytWTXM4OzfiDU6DOy7OYAn7IMNyFdkZpipKRbPcGrkDRzzchILLRtqy0m8lHNwlamgOem3NE1TskHQpucVJ6/lSFbHmTFD1EWjHzzPcu/7l4iijDws44jv4Q48sIy8BXTUFIC5hR7uHkdPhCFPFpIxXhNWIo9SWLojyFwp7u9Vxl/+wvzWX9WFk467IjXCUYkC2PkVsOOAedp6YT9wz+NNXpKPUGxuL5ypf694uOXvTXBuRhRfbP9bcoAyAIKVuEcBARzJ7ukGOiSUThTNpJfxNh7y5xj+Syfdj9NhCjyp9R5yKfP0+S2jhWlvT/FLtvcyTvjBsYg10dZ/rH3UHBAu2zPyj1OvQYXUKctFmDUm5D+oXM56ZzPkvXHU941zuCZzfNmvJr/vNLoTc33fJWfBZPjYvwwK4ur0watKGDAGMLjXKl65mUsZzKyZEcLEfa4MzQVP2gYxGaMf7BCocsEmYj9qh6pqG1Y+LooFoaZyObEvcnNbmXQCUVHo2K
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5374.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(6512007)(64756008)(26005)(8676002)(66446008)(66574015)(122000001)(66556008)(6506007)(110136005)(33656002)(53546011)(6486002)(186003)(54906003)(36756003)(5660300002)(4326008)(38100700002)(2616005)(83380400001)(966005)(8936002)(478600001)(76116006)(71200400001)(66476007)(45080400002)(91956017)(66946007)(86362001)(316002)(2906002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGRycnJHeFZSaVhEdnJtWFRqSldaZFQwMW9zNHI0TDFyU3BHYjEzYnlWVVpw?=
 =?utf-8?B?RXFDWkMwV1pBUUFKaTduNnMxRUtBSW1OMjlscmc5djZuUWNKVXhIZmdkc2lH?=
 =?utf-8?B?QTVEQm5pTi8xS010cFkvQUVYYXdXRXdzVzB6Wmh3Wkordm96aFhPVVpHRDVW?=
 =?utf-8?B?VmNoTTRkV2ZCVzhVZzFiaHZpcDBsaVBFOGVDVFJqZlZRS0k4RW9KeWtqdHhj?=
 =?utf-8?B?SVYwaEpFZFlXR0loNUVMYUdqL2dzT3NtSWZWek5nVDVRcGprajZNZzZjbUFa?=
 =?utf-8?B?c3gxZnN4UXFCQmp4VENjajJSdENZWEM2UCtDYVFQd2VOZVIyYjdvVTRtYUF5?=
 =?utf-8?B?Q3FnamlKR0ZVZkU0d1N0ZEtqOXRrMUNTMEVpZGk5QVgzTCtXYWxyZ3dHQjRq?=
 =?utf-8?B?QTIyMHZHS0xFWVBCVHhka2YzMTltVjV3eDFaY1oxV1RtWW93ejFtaFZMdmNZ?=
 =?utf-8?B?R0tQVXE5Y2VrY3gwVG50UTk4RGhkeWFQU01xZVNlYk5EREVSNTRUWmZPYkV1?=
 =?utf-8?B?WGVGelZCNVBOVElobzRza2Qwb3QweEYvcDNTUHQ2eGlLYU04OEV0U1VCQUNI?=
 =?utf-8?B?cmlwSS9qYkJyRGs0Mm5Va1dEcVFuK2ZIbWhySUdRbEgxL3l2b3Z2Nzd1Y0tV?=
 =?utf-8?B?UHRIK2IxRVlLSXl2emFOSUtPaUI5QmlkZXNSUHBud2liY0ZLMllWZTNqTmFY?=
 =?utf-8?B?RUI2YWFpVHBVRmhWelNaNjF6OHkzN0VaR21ac3Y2RlFPWnJqU25WcUtVYytZ?=
 =?utf-8?B?WHcvb0V0Z2ZUK2Q3bm1tSTJkRnVrdnh2eUFrcndFck54YVcxalo4VnFiY2la?=
 =?utf-8?B?ZkhWMVZXcFVVZVNZT05oUElJbi9xaFREWGZ1UmlHaTExUXk2UUZOVlBYVzd5?=
 =?utf-8?B?T2Uzb2xRekh5MnBDSFppSE01RUpyMEVqS2VaZ0tWQVQyWEEzdzlVSFNUVkkw?=
 =?utf-8?B?eVQ3VXZtZDlIVDNRck8vNnhuSSs3Y2QzREQxS3hDaXo0TXRYcnNVa1JpL1o4?=
 =?utf-8?B?bldzUENCZGR4aUNqbnZNSG1OZm90MmoyUUZ1SW1oWXFCeUxhUzZIU3RvZTFs?=
 =?utf-8?B?U21US3dWTFRpeWxnZk8yQmlmRGpRQUlwRnNUS29Uc05wV3pzeVpFeGc0aGRv?=
 =?utf-8?B?RnVHN2FRbFNNS1AvTFFjT05BUU5ncGpnSXJ6Y2NiV3k3ek93TUdiVE1JSWVH?=
 =?utf-8?B?NFFlTVdockE2VzVQemlZRVRIS0I1SDFXQS9NMy9GZWV4Y3djUGU0YVBlcWxN?=
 =?utf-8?B?OU5wL1JPYmNxdWJlL2s1ZTRxS2F1N21jaCtoOXQ1UHZWSHJqbjM2bXdBcURp?=
 =?utf-8?B?RENBRGdnS0hOcXlVcmxKbzdCK1BVQ1BBYkZCMWZKblo2NTFEaXJPN201ekR2?=
 =?utf-8?B?WllTL3hOekJhQUdCcnF2bGJvazlPSTJMcUFjTlgyTUJmMyt0a2ZjMHBCTCtE?=
 =?utf-8?B?WG92dEZ5ZS9scU5vNWN6ZURGSlBFMW9JbHlhRHUybHlrYWZZYkFvYlRubGI1?=
 =?utf-8?B?MEN2eERKYUxVRVFWbkpJT21tNzFwdnhQWDRGaG5yYmN2M2xWNUJMZE1iQ3NN?=
 =?utf-8?B?aTBjNWpaanR3NTFhMzdSV2FjUENteGpndEsrZDRXanlzZ2NJL080dW9uTmRS?=
 =?utf-8?B?aGRSNll3MC82SFYrQmhaWDdBYldDMWp2cklKVEUwamhXVjJxZVY1Mkd0MVF5?=
 =?utf-8?B?TUVvS1FORXFWT1ByMVZYbEJNM1kvUjd3Ynlma3lweHNHUndZWTVhUSttNHUz?=
 =?utf-8?B?eFZNWUlDaUs1akhWVW5CdlRqMEdhUEpsU2ZDTVVpY09IWDB5Vzcwb2pERGM0?=
 =?utf-8?B?ZTdwcEMvY3N6YnQ2YWZTUT09?=
Content-ID: <9EE80A019C609E4B83481DB75D884C1D@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ed6ede-2b62-4f05-7e4c-08d92a921813
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 15:28:40.5883 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jS6IBPJtl1/nY9nnxM56SlvLhtYXCOZExGMHuO6ZFRXZBrmYuytkQqz861vVr4aH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5536
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgTmlybW95LA0KDQpXaHkga2VlcCBhIHVudXNlZCBwYXJhbWV0ZXI6ICtzdGF0aWMgaW50IGFt
ZGdwdV9hbWRrZmRfdmFsaWRhdGVfdm1fYm8odm9pZCAqX3VudXNlZC4NCg0KV2hlbiBJIGxvb2tl
ZCB0aGUgY29kZXMsIHRoZSBvbmx5IGxvZ2ljIGNoYW5nZSBpcyB0aGUgdmFsaWRhdGUgcGFnZSB0
YWJsZSBibyBpbiBhbGxvd2VkX2RvbWFpbiBpbnN0ZWFkIG9mIHZyYW0gZG9tYWluLiBDYW4geW91
IGV4cGxhaW4gd2h5IHZhbGlkYXRlIHBhZ2UgdGFibGUgYm8gaW4gdnJhbSBkb21haW4gY2F1c2Ug
YSBwcm9ibGVtPyBXaGVuIEkgbG9va2VkIGF0IHRoZSBjb2Rlcywgd2Ugb25seSBwbGFjZSBwYWdl
IHRhYmxlIGluIEdUVCBkb21haW4gd2hlbiB2cmFtIHNpemUgaXMgdG9vIHNtYWxsIChmdW5jdGlv
biBhbWRncHVfYm9fZ2V0X3ByZWZlcnJlZF9waW5fZG9tYWluKS4gSXMgdGhlcmUgYW55IG90aGVy
IGNhc2Ugd2UgcGxhY2UgcGFnZSB0YWJsZSBpbiBHVFQ/DQoNClJlZ2FyZHMsDQpPYWsgDQoNCiAN
Cg0K77u/T24gMjAyMS0wNi0wOCwgODowMiBBTSwgImFtZC1nZnggb24gYmVoYWxmIG9mIERhcywg
TmlybW95IiA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZyBvbiBiZWhhbGYg
b2YgTmlybW95LkRhc0BhbWQuY29tPiB3cm90ZToNCg0KDQogICAgT24gNi84LzIwMjEgMTo0MiBQ
TSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToNCiAgICA+DQogICAgPg0KICAgID4gQW0gMDguMDYu
MjEgdW0gMTM6Mjcgc2NocmllYiBOaXJtb3kgRGFzOg0KICAgID4+IEZpeGVzIGhhbmRsaW5nIHdo
ZW4gcGFnZSB0YWJsZXMgYXJlIGluIHN5c3RlbSBtZW1vcnkuDQogICAgPj4NCiAgICA+PiB2Mjog
cmVtb3ZlIHVud2FudGVkIHZhcmlhYmxlLg0KICAgID4+ICAgICAgY2hhbmdlIGFtZGdwdV9hbWRr
ZmRfdmFsaWRhdGUgaW5zdGVhZCBvZiBhbWRncHVfYW1ka2ZkX2JvX3ZhbGlkYXRlLg0KICAgID4+
DQogICAgPj4gU2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPg0K
ICAgID4+IC0tLQ0KICAgID4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ft
ZGtmZF9ncHV2bS5jIHwgMTUgKysrKy0tLS0tLS0tLS0tDQogICAgPj4gICAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCiAgICA+Pg0KICAgID4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMg
DQogICAgPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZt
LmMNCiAgICA+PiBpbmRleCBkNmNiN2NmNzY2MjMuLjAyMWYyNTA4NTc2MCAxMDA2NDQNCiAgICA+
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMN
CiAgICA+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dw
dXZtLmMNCiAgICA+PiBAQCAtMzQ4LDExICszNDgsOSBAQCBzdGF0aWMgaW50IGFtZGdwdV9hbWRr
ZmRfYm9fdmFsaWRhdGUoc3RydWN0IA0KICAgID4+IGFtZGdwdV9ibyAqYm8sIHVpbnQzMl90IGRv
bWFpbiwNCiAgICA+PiAgICAgICByZXR1cm4gcmV0Ow0KICAgID4+ICAgfQ0KICAgID4+DQogICAg
Pj4gLXN0YXRpYyBpbnQgYW1kZ3B1X2FtZGtmZF92YWxpZGF0ZSh2b2lkICpwYXJhbSwgc3RydWN0
IGFtZGdwdV9ibyAqYm8pDQogICAgPj4gK3N0YXRpYyBpbnQgYW1kZ3B1X2FtZGtmZF92YWxpZGF0
ZV92bV9ibyh2b2lkICpfdW51c2VkLCBzdHJ1Y3QgDQogICAgPj4gYW1kZ3B1X2JvICpibykNCiAg
ICA+PiAgIHsNCiAgICA+PiAtICAgIHN0cnVjdCBhbWRncHVfdm1fcGFyc2VyICpwID0gcGFyYW07
DQogICAgPg0KICAgID4gVGhlIHN0cnVjdHVyZSBkZWZpbmUgb2YgYW1kZ3B1X3ZtX3BhcnNlciBp
c24ndCB1c2VkIGFueSBtb3JlIGlmIHdlIA0KICAgID4gZHJvcCB0aGlzIGFzIHdlbGwsIGlzbid0
IGl0Pw0KDQoNCiAgICBSaWdodCwgSSBtaXNzZWQgdGhhdC4gSSB3aWxsIHJlc2VuZC4NCg0KDQog
ICAgTmlybW95DQoNCiAgICA+DQogICAgPiBDaHJpc3RpYW4uDQogICAgPg0KICAgID4+IC0NCiAg
ICA+PiAtICAgIHJldHVybiBhbWRncHVfYW1ka2ZkX2JvX3ZhbGlkYXRlKGJvLCBwLT5kb21haW4s
IHAtPndhaXQpOw0KICAgID4+ICsgICAgcmV0dXJuIGFtZGdwdV9hbWRrZmRfYm9fdmFsaWRhdGUo
Ym8sIGJvLT5hbGxvd2VkX2RvbWFpbnMsIGZhbHNlKTsNCiAgICA+PiAgIH0NCiAgICA+Pg0KICAg
ID4+ICAgLyogdm1fdmFsaWRhdGVfcHRfcGRfYm9zIC0gVmFsaWRhdGUgcGFnZSB0YWJsZSBhbmQg
ZGlyZWN0b3J5IEJPcw0KICAgID4+IEBAIC0zNjYsMjAgKzM2NCwxNSBAQCBzdGF0aWMgaW50IHZt
X3ZhbGlkYXRlX3B0X3BkX2JvcyhzdHJ1Y3QgDQogICAgPj4gYW1kZ3B1X3ZtICp2bSkNCiAgICA+
PiAgIHsNCiAgICA+PiAgICAgICBzdHJ1Y3QgYW1kZ3B1X2JvICpwZCA9IHZtLT5yb290LmJhc2Uu
Ym87DQogICAgPj4gICAgICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBhbWRncHVfdHRt
X2FkZXYocGQtPnRiby5iZGV2KTsNCiAgICA+PiAtICAgIHN0cnVjdCBhbWRncHVfdm1fcGFyc2Vy
IHBhcmFtOw0KICAgID4+ICAgICAgIGludCByZXQ7DQogICAgPj4NCiAgICA+PiAtICAgIHBhcmFt
LmRvbWFpbiA9IEFNREdQVV9HRU1fRE9NQUlOX1ZSQU07DQogICAgPj4gLSAgICBwYXJhbS53YWl0
ID0gZmFsc2U7DQogICAgPj4gLQ0KICAgID4+IC0gICAgcmV0ID0gYW1kZ3B1X3ZtX3ZhbGlkYXRl
X3B0X2JvcyhhZGV2LCB2bSwgYW1kZ3B1X2FtZGtmZF92YWxpZGF0ZSwNCiAgICA+PiAtICAgICAg
ICAgICAgICAgICAgICAmcGFyYW0pOw0KICAgID4+ICsgICAgcmV0ID0gYW1kZ3B1X3ZtX3ZhbGlk
YXRlX3B0X2JvcyhhZGV2LCB2bSwgDQogICAgPj4gYW1kZ3B1X2FtZGtmZF92YWxpZGF0ZV92bV9i
bywgTlVMTCk7DQogICAgPj4gICAgICAgaWYgKHJldCkgew0KICAgID4+ICAgICAgICAgICBwcl9l
cnIoImZhaWxlZCB0byB2YWxpZGF0ZSBQVCBCT3NcbiIpOw0KICAgID4+ICAgICAgICAgICByZXR1
cm4gcmV0Ow0KICAgID4+ICAgICAgIH0NCiAgICA+Pg0KICAgID4+IC0gICAgcmV0ID0gYW1kZ3B1
X2FtZGtmZF92YWxpZGF0ZSgmcGFyYW0sIHBkKTsNCiAgICA+PiArICAgIHJldCA9IGFtZGdwdV9h
bWRrZmRfdmFsaWRhdGVfdm1fYm8oTlVMTCwgcGQpOw0KICAgID4+ICAgICAgIGlmIChyZXQpIHsN
CiAgICA+PiAgICAgICAgICAgcHJfZXJyKCJmYWlsZWQgdG8gdmFsaWRhdGUgUERcbiIpOw0KICAg
ID4+ICAgICAgICAgICByZXR1cm4gcmV0Ow0KICAgID4+IC0tIA0KICAgID4+IDIuMzEuMQ0KICAg
ID4+DQogICAgPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18NCiAgICA+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KICAgID4+IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQogICAgPj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5v
dXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFp
bG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wNCU3QzAxJTdDb2FrLnplbmclNDBh
bWQuY29tJTdDNjJlNGIwY2NhZmFkNGUzZDExMGIwOGQ5MmE3NTUxODElN0MzZGQ4OTYxZmU0ODg0
ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3NTg3NTA1NjQxNjA4MjUxJTdDVW5rbm93
biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJU
aUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRhPW91ZkkyZElZczZHeDBF
RnVQRVBnTDBlWWs1anJoc053UGJ2RGY4ZUJKJTJCayUzRCZhbXA7cmVzZXJ2ZWQ9MCANCiAgICA+
Pg0KICAgID4NCiAgICBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXw0KICAgIGFtZC1nZnggbWFpbGluZyBsaXN0DQogICAgYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNCiAgICBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2su
Y29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJG
bGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTA0JTdDMDElN0NvYWsuemVuZyU0MGFtZC5jb20l
N0M2MmU0YjBjY2FmYWQ0ZTNkMTEwYjA4ZDkyYTc1NTE4MSU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTEx
YTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzc1ODc1MDU2NDE2MDgyNTElN0NVbmtub3duJTdDVFdG
cGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFo
YVd3aUxDSlhWQ0k2TW4wJTNEJTdDMTAwMCZhbXA7c2RhdGE9b3VmSTJkSVlzNkd4MEVGdVBFUGdM
MGVZazVqcmhzTndQYnZEZjhlQkolMkJrJTNEJmFtcDtyZXNlcnZlZD0wDQoNCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
