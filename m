Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A8CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 10:55:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBAF561B29
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 10:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DBAF561B29
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D7806EB52;
	Thu, 18 Nov 2021 10:55:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17C266EB52
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 10:55:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noVNkr+5FXLSNopGZCYixYspHexw3WylV/TfHqa2yapDO1cr/U17A1wM1PTr/VvqGh3T3NR89DU0VnnDcuUN2z3/t5Zbu6gfTJ/egW0Q3xxPdqs/q1PZ9IC1OUDm+8uBh4jMS0D6A9UDV86oRVivwyhF0jWWimV0SRmMWbDd6/pdVsByZUa8b8TTMLpg4ZIsNT7NzuY2NQ19v7J4f08YnGO8kvtqlB1uvc1gwv+b+ItueKqQqJakJyXc0LpEg/HE5+63bTCLZupNayIUqgAuLEOt+a9ePEwanJfUhya7qhYfVeuRrDh1gcQDk7qCpwG5/XyJ9H6vNYg8MmVHu3XC2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZNpV4xdFS6zoaUGieRz7dZeDjarGGdXSwdoduq7s4c=;
 b=HxQndH0p+sxNaQgn6BF8VK+IfQqbBosmpoq+d7r51GTKelrBW29BNPCQV9u/msXTx78A3EH3D4SwL0l/VUTlDcSylgqt5Hq+1AsJxzaUXqspkBF8RQEVBdJ7NHu+7OfbvoBTI5jn9OEdMm3Apxe2ydaqzbEZc9CMJGb8hKrhN5JPOAivPh7zbHEnHkWYRyq7gX7i4PUhEeBoLJu/XiQD+SfL7MVLEDRm50HgDB1VOycwjh499NJ7UfNCOEKNiEG9bZt2aORqx39j/yVq2xHqKvmkT99jGb0JYFl8ASXtkoVxKcZmqZ9H5vjCFREZHsJQwhPz273jQe1R1x/snmM5DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZNpV4xdFS6zoaUGieRz7dZeDjarGGdXSwdoduq7s4c=;
 b=TAyoXqXeBM4t7vQyXekvhYYZ4RbGcIv9s/+Y6aH0kNAu/9vnGfwTBlELEMq9w7gVMzpEbrNpPAepoG9qChQmZ7CoGbkZ8uIcnqNObVH1kjMMRw0ZNgj/rFV4MGtmzDE5dXHzl9+/YPNnuRt3PclcapY+xn2a1ptV91SAlfD3Tt4=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB2796.namprd12.prod.outlook.com (2603:10b6:5:50::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19; Thu, 18 Nov 2021 10:55:53 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45%3]) with mapi id 15.20.4713.019; Thu, 18 Nov 2021
 10:55:53 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: update the domain flags for dumb buffer
 creation
Thread-Topic: [PATCH] drm/amdgpu: update the domain flags for dumb buffer
 creation
Thread-Index: AQHX3FYwbXdqocvnqEyZyARXch35BqwJHOqQ
Date: Thu, 18 Nov 2021 10:55:52 +0000
Message-ID: <DM5PR12MB2469BE551972288C3FEA80FBF19B9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211118082713.2326928-1-evan.quan@amd.com>
In-Reply-To: <20211118082713.2326928-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-18T10:55:50Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=da7e09d4-8ce9-4753-80d8-b7624ece24e7;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7677ffc0-d3f0-4ed3-0722-08d9aa81fd9f
x-ms-traffictypediagnostic: DM6PR12MB2796:
x-microsoft-antispam-prvs: <DM6PR12MB279696AF63DBDB4E93CA3DC1F19B9@DM6PR12MB2796.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /ai71QViQGUNwcOPVKNmy/sWeRyhhepM3Xhtzji9yIpM83muudr7gsvfycusaIF3f0ASjW04tViqRZkvy9EkW1lq8+1YVaCU4Nsx465ISLpK7BWTqMxSo+A9fKtfFjJzxfW/XsUEgDPJgh+RcoVXpXETsg62NVmghc2L6KUuTjuB3aA9gcUQH+owj7fr2Th6GPps4CMaWJ4F7jlv39z5XTWpfn/EirSj3/I61Ea6IplzgA6ZxUlpOfOixvMKFB4bpbpHHUVBi0hV9X6RRKDJcsm8GL/NyNmx8OJWbe/GUDLDB/i2VsroCNFmWWWyyNu9cCyASbOTQIY6TaVNg1JdTioGncN4Hx/8lwIHuGcXWcYK/uMClX/9G9CayB49zhX25hJrH9hDIUWuUx7n11k9R3Yv4K9mtkLp++Mr3REf17f/8bdgB6Yd0LIhMRWb/jEODEcE/EHQZrux3b9b2iRjlzFsPY41CyQT14JZVo37y1yhKKCpPOD/MZb5oolvAyR3GI2433Ixi3qJRpewMplbt7ZJfXRWDguY/SkmZuKY5RvEA43j3B5HX4V8OVn+a74ofGNdgNlO/kyZxKBdtmtNP3xSMfpFtDP+Hanaby412aiC4vLan2PxCXsMflxYDDKVVWKrJEKbWDYKCC7M8B48oLsYBZQDVGTTVChMBNlH6avBCro3YGmQe9tB8TMVlfLiNGjs8QjzWsvxDfqPvFDrLA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(26005)(66446008)(54906003)(53546011)(66476007)(76116006)(71200400001)(6506007)(316002)(9686003)(55016002)(2906002)(7696005)(508600001)(186003)(64756008)(66556008)(83380400001)(110136005)(122000001)(8676002)(86362001)(38070700005)(5660300002)(52536014)(38100700002)(4326008)(8936002)(33656002)(15650500001)(66574015);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnUrZ1hBRzZPRXpxSjh1eGgxMmN1VXBOKzZ3K0RHaDhaT3BaSXZuc2Y2TUZo?=
 =?utf-8?B?ZDVYcnA0UTExWEZMa0FPeTVvb0dLdUhSVVJzTGgvbHJSOHBnY2FXOElxRVM5?=
 =?utf-8?B?Q1Q0YldCeDd5UEJBU3VRSUtYa3FtSTlrejdJa0pFc29Od1lzZmZaUlNSK3BG?=
 =?utf-8?B?czlKL21wVzgrM2ZnUTNHWFM3cS9RN2ttNzczMFU0SW5hOEM5L29YQUVodGpU?=
 =?utf-8?B?NFFDZU5FWTYzUTR5dmdJTU1vYmZWVElCUUxCSlU5cUlDbU9ONlJENlU3Nk1F?=
 =?utf-8?B?akxuTlFTR09Za0UzbGJLeFVXT0h1Sm41VWovSTRUNlNldVJXbnJFNDBLWWFo?=
 =?utf-8?B?VDB0OTRlajlBbU5hMEczWklNaUZLTTBURnhLcW5od1VRVjQzbmtNRkVDRnc0?=
 =?utf-8?B?cUlua00vRG56ME5YdXNMR2pHdWVhZTU3QkNEblUxVmt1QS95UEp0VkxuRGVt?=
 =?utf-8?B?dFJKQ0ZkVjlCUG90V0RWU085OEZDWkZwd0ZDOURSUHZoOG9EaDMrTDNpODlv?=
 =?utf-8?B?bTZvN2V2cUZSRVI5ZThwazI0MEJ1ZXE3QTNoVVlyNGZxbmkwbmx3aFh3ZTlG?=
 =?utf-8?B?RWkzSjI4V3ZpRmVpZEUzSGJQMmtUTUR6MmNVS04zbDdjbzBDYnRxQ2lWbnpS?=
 =?utf-8?B?UUlsaksrVURxdGVUWUlaRWs0ZlpwWWhZdnBkY2pZWXA4QUhkblRBei9rZWtI?=
 =?utf-8?B?NlREZFhjdElXNGduWEZvT3BlNFMrek9MYWRNN2dlMUVVZ1VOcW9FREVabk9C?=
 =?utf-8?B?Y2tBdzhwMk5IK1lZSkRMYXBxaklxT1o0b0VZZno3R2xJeFN5NENZU3lKbDdW?=
 =?utf-8?B?MW9JQ0RoVW1DVmxMa2dZNlMyb2g3TDRvSklhQVhUM2txaDQ4M04yeWwwSmRW?=
 =?utf-8?B?NFVLMmpobEo4clNMU3d4Zk1UQlNzZ1FLZWpoL3laL1NFZFBnL090alFicE5N?=
 =?utf-8?B?M0JTMTJGMUkxYnBkUmFPT3krQ0RHQllobTdiZlZ4cldlTHhtcGpMdlVaZTdv?=
 =?utf-8?B?dkR4d2c2RVcvdkpzbEZweUZpYkNsN2g0bHFtNnd1MzVxaVJ3cHZIOENrTEZ4?=
 =?utf-8?B?ZnpHZzc4VUpOekZ6NVVaQkw0Y1BleUE3Y0Nha0E3dndGZ1JINHdINXJZN2VV?=
 =?utf-8?B?S1BsUW9PeEZHQUxkY21NV3lKM2hDVmtyalhqSXFxenZqSzhXeHp5S05FMm1T?=
 =?utf-8?B?VjBGR1ZaTkFEYkp3U25MbzR2WThQZFRadGduYVYwTDVFeDFEZ3hQQklWMEJY?=
 =?utf-8?B?dEx5ZE9ORDlPcmhZKzdpYksvdEZDTC84K3oxWjVPdkR6N2RtNGd1ZTJtK2x4?=
 =?utf-8?B?c1E3Z1RGWmIwR1I3dGpCZU0vdWxMSE4raFB3ZUVSaEhBYU5rZThxd3MyRjZK?=
 =?utf-8?B?anlUQTUzMkRlZDJoYjMxMVJhMS9aZjU4S2ZMRjIzcTFLdWNwa2xBaWVTU2h4?=
 =?utf-8?B?dFp4SGtINDBKMjFIa0FpcUVnNU5lU2xQNTdTUFNGWXBsdEtuMHhJellDZjVK?=
 =?utf-8?B?cGFiVllSZFR6OSt1cDZ0ZWtZWXdadmI5UUFRTmVuK2lmWW5FNEdCenBseDBz?=
 =?utf-8?B?d3M4MnlQamNsWW5UZFhnZ05yRWtydW40REpBQ25CWm5TS2RoNnFkdVhrblRk?=
 =?utf-8?B?dDNJdTRYZ3QvUDNsWGRyUjl4bmxDTmNjR0svMVB0cUVFN3lxQmFpaFhXdTc4?=
 =?utf-8?B?dll6dDZZSzcyRjFWQWRCUFdCT0VQYUg3ZnpmNzBpT3ovYW1DckN0NFAvV25w?=
 =?utf-8?B?OSs1eEsxa1M3Z1hSMHlKSHVDamc1eGFhVkZuV3psSWUyWE84dTZrK2Z2U0d4?=
 =?utf-8?B?TFh1Q08vQk0zNm04akxpRkxaMVRrMmdLUnBWdzJkSkVzQ2tsRTJBMWJ5Vytr?=
 =?utf-8?B?a1FMWlV2VFhiU2l6d0VoaStzRkxmNE9PYkV2blQrYXBNeDYvenhQRy8yd1BX?=
 =?utf-8?B?cXJJemZjSVNUUEc2UGNRQzBjaUxTUUFKWjl6NUUrQXN4MDhJMHFhMFRCZC9L?=
 =?utf-8?B?a3lFaDFydW42UkV3MWI0d3dmNkl1a0pJVWtvc2ttU0xvMnlpREFxemhLKzMx?=
 =?utf-8?B?bXlvYzJCazBBMFFLUktnK3puQlBFb1UxaGR3TE9mRXZFVHpHaElSNnpJYXlr?=
 =?utf-8?B?Mm1OZzcyblpKVzQ5TVhwQlhhdTd3a2l5eVNaSGhMUVR5YVZVS1FucW8zT25D?=
 =?utf-8?Q?AXOjC+O/l9rpuyR0s+e59Xo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7677ffc0-d3f0-4ed3-0722-08d9aa81fd9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 10:55:53.0327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PeVxwub+74+9yV+8n2WIfLflfSSwR4REtSX9k7yP9FVKYu4+LzkhpV36g7EsXjRsLoiy/XYMYNEvbXaLd+Rnmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2796
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KUmV2aWV3ZWQtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29t
Pg0KDQpSZWdhcmRzLA0KR3VjaHVuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9t
OiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhh
bGYgT2YgRXZhbiBRdWFuDQpTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMTgsIDIwMjEgNDoyNyBQ
TQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogRGV1Y2hlciwgQWxleGFu
ZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFt
ZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KU3Vi
amVjdDogW1BBVENIXSBkcm0vYW1kZ3B1OiB1cGRhdGUgdGhlIGRvbWFpbiBmbGFncyBmb3IgZHVt
YiBidWZmZXIgY3JlYXRpb24NCg0KQWZ0ZXIgc3dpdGNoaW5nIHRvIGdlbmVyaWMgZnJhbWVidWZm
ZXIgZnJhbWV3b3JrLCB3ZSByZWx5IG9uIHRoZQ0KLT5kdW1iX2NyZWF0ZSByb3V0aW5lIGZvciBm
cmFtZSBidWZmZXIgY3JlYXRpb24uIEhvd2V2ZXIsIHRoZQ0KZGlmZmVyZW50IGRvbWFpbiBmbGFn
cyB1c2VkIGFyZSBub3Qgb3B0aW1hbC4gQWRkIHRoZSBjb250aWd1b3VzIGZsYWcgdG8gZGlyZWN0
bHkgYWxsb2NhdGUgdGhlIHNjYW5vdXQgQk8gYXMgb25lIGxpbmVhciBidWZmZXIuDQoNCkZpeGVz
OiA4NDQ2MTJlMTE0OWQgKCJkcm0vYW1kZ3B1OiB1c2UgZ2VuZXJpYyBmYiBoZWxwZXJzIGluc3Rl
YWQgb2Ygc2V0dGluZyB1cCBBTUQgb3duJ3MuIikNCg0KU2lnbmVkLW9mZi1ieTogRXZhbiBRdWFu
IDxldmFuLnF1YW5AYW1kLmNvbT4NClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+DQpDaGFuZ2UtSWQ6IEk0MDNiZjdhMGIyNjVjNTY0YjVmM2Ez
MzQzOTk5NjcwZTVlYjg3Y2E2DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZ2VtLmMgfCAzICsrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9nZW0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYw0KaW5kZXgg
ZDA3YjZhZWJjNDQ5Li4xODllMzJlZTdhNmUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9nZW0uYw0KQEAgLTg4Myw3ICs4ODMsOCBAQCBpbnQgYW1kZ3B1X21vZGVfZHVtYl9j
cmVhdGUoc3RydWN0IGRybV9maWxlICpmaWxlX3ByaXYsDQogCXN0cnVjdCBkcm1fZ2VtX29iamVj
dCAqZ29iajsNCiAJdWludDMyX3QgaGFuZGxlOw0KIAl1NjQgZmxhZ3MgPSBBTURHUFVfR0VNX0NS
RUFURV9DUFVfQUNDRVNTX1JFUVVJUkVEIHwNCi0JCSAgICBBTURHUFVfR0VNX0NSRUFURV9DUFVf
R1RUX1VTV0M7DQorCQkgICAgQU1ER1BVX0dFTV9DUkVBVEVfQ1BVX0dUVF9VU1dDIHwNCisJCSAg
ICBBTURHUFVfR0VNX0NSRUFURV9WUkFNX0NPTlRJR1VPVVM7DQogCXUzMiBkb21haW47DQogCWlu
dCByOw0KIA0KLS0NCjIuMjkuMA0K
