Return-Path: <SRS0=wnxc=QD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF65C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 08:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB78D61BFA
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 08:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DB78D61BFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D1FB6EE34;
	Tue, 16 Nov 2021 08:01:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8B416EE30
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Nov 2021 08:01:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJ65Vl/sxFbaZw9pKyleVlrTCKkOVyFI8yIzyk/p9OBXtv7O4fA6zZm2katwxabThTZuDfBmjnr9OHR3UW4fG0+ZatTmzuXGgx7wqNAOtH01u8SM2WPaDMbRZaTOuutOrQisUR80bzCmfTjqpGd7Skckr5vM54iRZEjDdAgu4UXZJOLG6iVPvNzGO/uYdG8uJ/LlTVh0eUhJTTWhMt0VROW3S+Ar7ZrAzICUZ00+yBBGmZNBG+7gahQNV7WC2oWQQO7MO9y6NK19aduPHmqolw31qWIVNSDAs9eg35SePa2D49ZkYjoQxYvFuIm1e046rZYI9jXgdcUDFDObg5oQ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BynGotyHv1U2PUIosfIFO3YRtVHyQlDraZEJnOWlP/Q=;
 b=lK3Yhjcm/VUsfAf4ebiq1JOTyn0zOFWS5nOUWD8GPv02R4K9ijF/1ML/MwOCvAX29E0br4lh43+SDoxMXLxHm7RPYFnAtA5aZWni6aahNO6T2zdrTStmcL5xcuT0yHWXXoga0qgsRdnI8S54euuillxGM9N+DV0cAueAWXwbZeYf/yaCRjEff+rrod4XYx8Hi+nBrDkOJj2a8LoTAgpwLp0kMfjlCAShhT4tbXrTofUDsA3RvaW6BUuNoYNDz2eiLTGuXr7+RJokac2Z8D3AuF7CEkIKsxkfG0Tu8h5KRZk7h4RxXe2sd64yH/8bsIfpw0zb/jZSUcqUqphtp2pKLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BynGotyHv1U2PUIosfIFO3YRtVHyQlDraZEJnOWlP/Q=;
 b=y8qorerjdjXj30XL4B8RDlyjRRTuMo1mtlCz7+7umC53o5qrifDl5g84LKtUmEmgFRc3y2Om4+rzVdKgX2ex4RZSiSbbR7QaYWZTPenQYRSVd0z5VroaUNcoHR66A1bJ/zB60FhZ6jHcOfdGp5p3eoG4QwItkyQiNUKN3HMDNWs=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 16 Nov
 2021 08:01:36 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::7cc0:c568:c7b1:d824]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::7cc0:c568:c7b1:d824%5]) with mapi id 15.20.4669.016; Tue, 16 Nov 2021
 08:01:36 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggUmV2aWV3IDEvMV0gZHJtL2FtZGdwdTogZml4IHNt?=
 =?utf-8?Q?u_not_match_warning?=
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: fix smu not match warning
Thread-Index: AQHX2r3HiXDqfG7sMEuMxCHl5zyV8KwFx3CAgAADSKA=
Date: Tue, 16 Nov 2021 08:01:35 +0000
Message-ID: <BL1PR12MB53345FEDD8066DD19DA9D9F19A999@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20211116074342.31651-1-Stanley.Yang@amd.com>
 <5666e05e-5d90-fc4c-7279-691115046deb@amd.com>
In-Reply-To: <5666e05e-5d90-fc4c-7279-691115046deb@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-16T08:01:32Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=c90b0df0-f570-4cb3-8756-513c96884cbe;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-11-16T08:01:32Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 4b7a9c52-2fa7-46c3-a07c-1bbc27f92b52
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bccc7fe6-36b5-41dc-c1ee-08d9a8d74fdf
x-ms-traffictypediagnostic: BL1PR12MB5128:
x-microsoft-antispam-prvs: <BL1PR12MB512803422209D5E924D9B1C99A999@BL1PR12MB5128.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0GTacYcW6jUKCeQ04xsmRK5kPZQHzRZhGAVvvABBhSi7QGCRnF+bD4zQ+wcYelb0sDSvLlwIULWkHlgTlCKc1ggC+4owZNFwHXKflAhLoorQ8dNmMLGLkplxpdrmfJJ5lBYkW1prT/2wCNmQ3LZKYYxor9ZAIjVU+tfsZtQ5PHz2x8u6CzdVkMFLqQNM3Ub8uJWY6/NR3ihP9qEVQUMA/AmwRdrENdSHrSu5hvWzDXovjYwGv09mgYZIXXqPLo2/UaxRcBPeOOm9eqhdzGRJBQEb2KJPMTeVFbPOFGM8mIdzOxYLGk+zy60w81etoNazmZgT1Ac0lH7BSRBkq3cND4Js+24jtRqW8EXxQxcFONFFz6axPyZW5ED5nQ1HcDa8rOqcUhfWzADsYjmjBpS5WVgaV6A5tL8WU9QJ/oY0URCFM11Nro+1ocfYuRF4rT5JR+vI6+6JrUG5sPlc6DPow2VeFsVKVOgAo0gr7tQlNCTUnxOI7cgnUc64wOsRf3U1ENbOeSZV9sFP6UddhR4VRg1mN01lDca5vhWKbeLoORrpFQRlMPS5M52wwx3zKMSjmfvmaNl/fxUSj/HIcZE+wNCtHK0j+DNOQ9IUf/bKQagdO7gacZyvLGqvpynQ1tj4h2MGFRhPnconXXrQJ4CKWL/79CsgQ3elqc/jgvX6wZG9qiH9AiQ6KsnN+hgmMyUXrdolkkmn2ivzRz3jCKIioq/6nWR9xJ3xeNP2g+p6y/M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(921005)(55016002)(52536014)(83380400001)(71200400001)(66446008)(64756008)(66556008)(76116006)(66946007)(66476007)(508600001)(33656002)(2906002)(316002)(38100700002)(110136005)(122000001)(6636002)(9686003)(186003)(224303003)(7696005)(53546011)(8936002)(26005)(86362001)(6506007)(5660300002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZW91ZXl6aWdpR2lEdHdIWmpIQUg5T0UrYlRxaFdESVBZU0gzTkNpSnVaRDRF?=
 =?utf-8?B?cVQrRHJzUjBIaDh3WWRNSGZuaTQvcDlHWm9SZVlhRW1wbXJXTFhVMnAxTmtH?=
 =?utf-8?B?QnNLdmxqOFJjVEtwL0VLWGJ5K2pGV2VYT3hpbjVJWU03K0FnOXFJdnQwNFF4?=
 =?utf-8?B?M2hWcjlLQ1RURUNnUXlXdWhYb0RxTitURElEM2Jsd3RFcWRLcnhmcDJxbFp6?=
 =?utf-8?B?MTIwT29Xc295SjFaNm0rTzZSQkdseS9UbEZvNnIrTFIrOWlabXFNOXBINm5O?=
 =?utf-8?B?bm1tK0MyZTkyaFF4ZHN2d0wyRHE1dTM3ZEJZOVJBVC8xcUFCa3l3elBOc0k0?=
 =?utf-8?B?TTFJaEc2bVN1MExlbDZGZ3FTSk1xc3k3ZWVkaWRVd2o4MmVZSFRocFhpb2lm?=
 =?utf-8?B?MitvQzlEZk1jOTBESG5DY3FxV3kyREljdnpKVFh6aGJmODJ1WkpTRVdzcG5C?=
 =?utf-8?B?c0VSbm9XbVJsL3ZuTHZZTW1lN3FkMkJFT0YyMDBlNTBVbERsSmVSRWtXeFRw?=
 =?utf-8?B?UjRKRVoyQ1lHZmxGRDdYN1NodGpqcWp5Mk44eENuc1FsMlhtNnl6Nkg4MFhE?=
 =?utf-8?B?TXZuU2paVWdUekt3cWZBUGRMVXZyZGdzSVhhaU8xbjBqMWtQOUtJOUk3RWZM?=
 =?utf-8?B?eG1lN08vWnlPQ2NSWjV6MVdEWFNING5PVGoxUEswNEw3VE9XMDdpRDhsZ0JB?=
 =?utf-8?B?MlNORktvUEZHZllWZ01hZjI4VFNBVUt5YXd3RGd0WGQ0dXllRFhJcGthS0Rw?=
 =?utf-8?B?RWR0M24xNFFiWmh5V2o4Y0Y3dm4wa0oyK0ovRDRybk0yK0tzY2E5cU94aml4?=
 =?utf-8?B?dHgzT2JDYXZaOEh6dFRPNkxacmFBSnNGQ214TWdWdTd6SWRRYy92OWwrWTdR?=
 =?utf-8?B?aW5UbkR1cGF1ZTVwc1pWNVVHVmpuWHd6emJqM0hFUUpTc3lGTE5WQTJNN01O?=
 =?utf-8?B?Njl6bzlsZzhtQjNYd3NUbGFkWkdVaWY4a1E3RFVxeEFqa0Uvd2V2d3MwR1Fn?=
 =?utf-8?B?aGlPTGkyVlZkcmwrRmpwSWNpQThvSmo1QWhjTGdKQWhMTFhOM3JUbFVpVWRO?=
 =?utf-8?B?Z1B1WjA5QlgrT2pRdHNGTUpUSHlmOUU4dGZyUG5iOHdCclZuUGNOelNPOFky?=
 =?utf-8?B?SHdSSUVVcFRnMitpbTBMNUVWZHgzSjRlaEk3aWNLak40d2U5Z1RWcVg1bHBl?=
 =?utf-8?B?UjBobGpuVkpRdUNGbVhITUNUQlRmYjQ3V1ZVdHVOSVVVblYxcExKS2x5amdO?=
 =?utf-8?B?YkFsRU5BK05WQlQ5TEsrZWQ2TVJxcU9ROEdhaG1MV2ZablB0a1M1dXN1QVRq?=
 =?utf-8?B?Tnh6ZjJubW5JaFFVeVkzMjlPdXZBUE5Eemt1YWVDYkIzQ1pGK2VYbXpOUlJZ?=
 =?utf-8?B?Y0cxTjFqVGVuTWdsNnplZ3VHTnNXNnBoaTNuTDcrL29SR0lqNU12c3UwN0wv?=
 =?utf-8?B?MGZUaS9oUEZXOXQwanBTUlhPTHErdXVrbEFRZ1dHVzBJMlpiQ2JMK2ltdlpt?=
 =?utf-8?B?bW1sZHVzdWUwRldnYy9EbXRkR0pyZE00TjhUc2wySXE4VkVsbDhXcm1tc2pY?=
 =?utf-8?B?UGVzK2NFYjRGeUowdHMyS0ZMZ0xDYkVJSFRva1NhYVBkVWhrZlJTeGFYUm5s?=
 =?utf-8?B?WGwvTTdpd3hVNlFXODdhc2FTVHdPK3VuN3lPWmdLc0ZReTdrUXNCeVhTRGRQ?=
 =?utf-8?B?NDRodjhLUmhLWUs5dTUzeU03TXBpSUd5eXpETFZPYUtIaUw3R3RlOTNnRmFj?=
 =?utf-8?B?QkpQM3UxMCtuS2RwaTArb0daa25HTlMrZ0JrcEg4KytlUkxKUVRnYmlRRGR4?=
 =?utf-8?B?Qm93Zkp0YkhJYkNaUVorWkxJaExUM0hBVXVUemJ0N3A1NjZFWi9iNWhrR1pj?=
 =?utf-8?B?T2V2bnhMZVlpN1hNZTl1YkhLdXppN0djME84eHIvRTN6ZmJRYTRDZHBuSXBz?=
 =?utf-8?B?TXVCZW9heHFleDZZcjlETHVYU29BQzQ4bjF1RVhpclNIZ1hROXRrRGJOSFBj?=
 =?utf-8?B?OVhLWUlpbDN4bXg1Y0Fjd1FjOXhQaHp5bUhOZktIbjZ4aDJ5Ykd1TUYwbTVo?=
 =?utf-8?B?bThieUp6VWJZT0JSVUVxdEpwS2JndkcybnFDVjI4Z3hmL1B1SnBnc2hxWHZq?=
 =?utf-8?B?RDZURS9UalBPMmFHQkZoMklGaFh0b0tkVS83MDBaR2R5V3lBMEc3WVU3OExQ?=
 =?utf-8?Q?JWVf+njWVYQKlhHPdI7qySA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bccc7fe6-36b5-41dc-c1ee-08d9a8d74fdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 08:01:35.9362 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2iNiSwAoLwplKkL6wAMZZR+7VWWen75inxqJHH33h3E9k1QgnZZ4u4i8SXWa5L6Pi+6qWl6HDINR5vz9rDckrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KVGhhbmtzIExpam8sIHdpbGwgYmUgdXBkYXRlZC4N
Cg0KUmVnYXJkcywNClN0YW5sZXkNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bk
uro6IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+IOWPkemAgeaXtumXtDogVHVl
c2RheSwgTm92ZW1iZXIgMTYsIDIwMjEgMzo0OSBQTQ0KPiDmlLbku7bkuro6IFlhbmcsIFN0YW5s
ZXkgPFN0YW5sZXkuWWFuZ0BhbWQuY29tPjsgYW1kLQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnOyBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsNCj4gQ2xlbWVudHMs
IEpvaG4gPEpvaG4uQ2xlbWVudHNAYW1kLmNvbT47IFpob3UxLCBUYW8NCj4gPFRhby5aaG91MUBh
bWQuY29tPjsgUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+DQo+IOS4u+mimDogUmU6IFtQ
QVRDSCBSZXZpZXcgMS8xXSBkcm0vYW1kZ3B1OiBmaXggc211IG5vdCBtYXRjaCB3YXJuaW5nDQo+
IA0KPiANCj4gDQo+IE9uIDExLzE2LzIwMjEgMToxMyBQTSwgU3RhbmxleS5ZYW5nIHdyb3RlOg0K
PiA+IHVwZGF0ZSBzbXUgZHJpdmVyIGlmIHZlcnNpb24gdG8gYXZvaWQgbWlzbWF0Y2ggbG9nDQo+
ID4NCj4gPiBDaGFuZ2UtSWQ6IEk5N2YyYmM0ZWQ5YTljYmEzMTNiNzQ0ZTJmZjY4MTJjOTBiMjQ0
OTM1DQo+ID4gU2lnbmVkLW9mZi1ieTogU3RhbmxleS5ZYW5nIDxTdGFubGV5LllhbmdAYW1kLmNv
bT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vaW5jL3NtdV92MTNfMC5o
IHwgMiArLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvc211
X3YxM18wLmgNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vaW5jL3NtdV92MTNfMC5oDQo+
ID4gaW5kZXggZTVkM2IwZDFhMDMyLi4yZTM1ODg1YzcyODcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvc211X3YxM18wLmgNCj4gPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL3BtL2luYy9zbXVfdjEzXzAuaA0KPiA+IEBAIC0yNyw3ICsyNyw3IEBADQo+ID4N
Cj4gPiAgICNkZWZpbmUgU01VMTNfRFJJVkVSX0lGX1ZFUlNJT05fSU5WIDB4RkZGRkZGRkYNCj4g
PiAgICNkZWZpbmUgU01VMTNfRFJJVkVSX0lGX1ZFUlNJT05fWUVMTE9XX0NBUlAgMHgwNCAtI2Rl
ZmluZQ0KPiA+IFNNVTEzX0RSSVZFUl9JRl9WRVJTSU9OX0FMREUgMHgwNw0KPiA+ICsjZGVmaW5l
IFNNVTEzX0RSSVZFUl9JRl9WRVJTSU9OX0FMREUgMHgwOA0KPiA+DQo+IA0KPiBUaGlzIGlzIG5v
dCBhbiBpbmRlcGVuZGVudCBjaGFuZ2UsIGl0IHNob3VsZCBnbyBhbG9uZyB3aXRoIGEgY2hhbmdl
IGluDQo+IGludGVyZmFjZSBmaWxlLiBQbGVhc2UgcG9zdCB0aGUgY2hhbmdlcyBpbiBzbXUxM19k
cml2ZXJfaWZfYWxkZWJhcmFuLmggYWxvbmcNCj4gd2l0aCB0aGlzIGFzIG9uZSBwYXRjaC4NCj4g
DQo+IFRoYW5rcywNCj4gTGlqbw0KPiANCj4gPiAgIC8qIE1QIEFwZXJ0dXJlcyAqLw0KPiA+ICAg
I2RlZmluZSBNUDBfUHVibGljCQkJMHgwMzgwMDAwMA0KPiA+DQo=
