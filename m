Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8E4C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 18:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A25446146D
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 18:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25446146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42E886E4F9;
	Fri, 30 Apr 2021 18:16:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED9976E4F9
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 18:16:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCrEKEEZnbxyNPs4DVlMiwtUVzbTwJbUPRvG/hMpEPNe7gF3JmdezbEofIVDobH5QvbgiTQl+Df2IPy7iAoxqghxvMj2LP6pMUGXcdY0svAoFs12ZvcFXjlq/DhxJjTR17goecR4GJJyET8pxxMVlCfLLzt1NjyN+d97C8zUrvtEoevEy9C3TFWnEcpTKYzpWBOcbaDdgsCfMhn/tN3Nkdm2B+4MkIA7snpuDR1mj9jfGqXdDqiGP0l9VJRvZp8lkL+s737pJyn8QE8zIa3QMjH2x6IPoFoZXRarDCNr43BZrly0gTaqvUREG2SKrDypzwucMc8cRvcVKQf40RE0yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSnzgwpsJURFKtUtP5JQooHj4z+IUrt1xQTezH8vHP4=;
 b=gBZaTT+xDU61RRsQ/YxYTHYj3cHlupiTmF1wvREChBx4/k84Y/UB4PNX0xo6mVv6A6lHoS+qGb2ja6REENRUOVRKGR7IE+fomCMMfXUIO1qapSdREBga+ADdKS/waftNl68sEGbCBWFsDg6n0RY7UyvsvFU63tHNDRwEkAzrCN2hrInXsYJNP0VjY9Q3XGXASXdWxfTHYDAshoWVYksozBWxx080b+f/ymJFrUbez29VsgBNrJp/24H4qy5DT3icBSRkEfKniQezWzJA9SiHrpG1prlY4YXwsvKh+7W/rHNhvWG8IA6TnzfGDvIqw0Dz4kfOv+pcYHFuIjL6zDJkYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSnzgwpsJURFKtUtP5JQooHj4z+IUrt1xQTezH8vHP4=;
 b=omNEcUrXRuOXgqhZRsslXdb4i2UPv2v0mpHBUAFU9NmkHkBqcwLcyAft1tpqcycrXHNYKFXRJGyhDnW8qZcj8eGcuJXChJvUIiKhQDD4ikAW+pHb/t+2mvIswzuk1u7Hjj3fAA/u0eWMmWFvsDrVe4mApI9mFPB11RDBC8UqoRE=
Received: from DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) by
 DM6PR12MB3708.namprd12.prod.outlook.com (2603:10b6:5:1c5::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.25; Fri, 30 Apr 2021 18:16:28 +0000
Received: from DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4]) by DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4%3]) with mapi id 15.20.4087.037; Fri, 30 Apr 2021
 18:16:27 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Cornwall, Jay" <Jay.Cornwall@amd.com>
Subject: Re: [PATCH] drm/amdkfd: report atomics support in io_links over xgmi
Thread-Topic: [PATCH] drm/amdkfd: report atomics support in io_links over xgmi
Thread-Index: AQHXPNsdJwQQg7kfg0u/pLaX4dXpUarL/xkAgABdCACAAMD4AA==
Date: Fri, 30 Apr 2021 18:16:27 +0000
Message-ID: <45E8FB48-CA0D-4209-8CFC-F9CCDF9336B6@amd.com>
References: <20210429093609.71616-1-jonathan.kim@amd.com>
 <73D22904-489B-4F5F-ABDF-EC534F21D9F5@amd.com>
 <199d4259-0968-863a-d321-ef5c04643b9e@amd.com>
In-Reply-To: <199d4259-0968-863a-d321-ef5c04643b9e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Jay.Cornwall@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.46.21021202
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d746e54-b138-4d8b-e9d8-08d90c041286
x-ms-traffictypediagnostic: DM6PR12MB3708:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3708849AA0673118676FCEC6805E9@DM6PR12MB3708.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zl/Twe6dQCyN441Dja2kZpU7rpX0j1stnQJUhA8nBadZa1+xpmbqQ7iD4izkOn/ERQO8O1mgmgAhnJ5dblwQLIoCYdBSMEZ9WvQIB3PIUca+V82kT8SBYhHxmRmNJozz5aXmNP5CUIA6m35K5az6WjTiH1QnXiQZFas8vfu2VeRL6BYVrlR0zFW1NNWXAcTyqrZJnwcI5UhEyDk+xASs3FUg8J4GVEqC2ANIgX/va21jkYuiXpYNA8yFCAYqqJeyZJnwvHofXlrPzekqNQP3aBKLZ3SaxHvR+Ifa/6tWe0ZJCnFdwtOovMI8SoAXoDlTHOHWXIVbV/2kXU+Buva/GDlyQp7dWBFxLYMNdNzDLbEw+pAS6B4pcDLZnrUReV2cJLtbrNk1GEJTfK3XYgqRAjpH3kuHs0MQo/QiwiBbN79ewjiI6pyJhB722oaxDtjGBUcSlCWucLdktMPtbVFtPJQz3NEZ0GNaccifPKhP6fhvK1HzNSBGbgVWf4AQyXI0D8PrbezhXCZeYSB6Zgb0Sk+rUTMDVJDPmnp7w/uNps4syMAc5NhMv2KAroRi3WHeOhDSyj7KG4udl1kN1FNgR/i9P97/cgq0rjlaYKVeBfyLuV+eecKBzY9GLgFiHXniMQXvkwuBfAqfQpQRpajE/7mnW7ztane6VgKZe9xG26Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4732.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(122000001)(8936002)(53546011)(33656002)(26005)(2906002)(38100700002)(2616005)(110136005)(6506007)(5660300002)(186003)(71200400001)(316002)(478600001)(66946007)(36756003)(6486002)(66446008)(66556008)(64756008)(76116006)(86362001)(66476007)(91956017)(4326008)(83380400001)(6512007)(8676002)(6636002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?a2lsdHVqbmJnZHg0TXhWTUxDY2JMUDFtbjlqRWQxT1lkcFhFWk03OS94YVVk?=
 =?utf-8?B?NUsrMjBMWVJ0Q2pac0MvNm8zamxyK29ORGZrYnp2YVU1RWtRK0pJcDVhbWM4?=
 =?utf-8?B?TFkzZm9ObUVZdlhZaFFIVXhNNlN6MlExNWl3bmUxSFQydlVFVlh3ajhHaTFB?=
 =?utf-8?B?ekY4Vk9QR1VDVWJaR1ZtZ0x6amZ5RWpmOFFKK3Z4eENPQS9FenBsZHJtVXZ3?=
 =?utf-8?B?Z05DQi80a1Bza29HT0JuVmdqMUlZMTBOYWtWWHY4SnBHbG5OdmNrSlduWHNy?=
 =?utf-8?B?bk0vOG1XeVU4ZENiT29iV3lRWWprd0ZPZHRsLzNSRlRoWWtUQ09VdVZLVDl4?=
 =?utf-8?B?NkdoSlpBSUhxUlo0cnBhcTl2bjB1RitDWEpmQWF6NUl3U0hROEFhN2JpVEZU?=
 =?utf-8?B?S0RxTHY0MzE5SHcyc3pHVDNZL21pclhKcXcwaDBMTWlXdXRya0t1ZjN6RFlC?=
 =?utf-8?B?TkVMWmFJN1p6ZHAvOXBLblNyTm9jS1ppcFJtZk11THJtU29SSkJDYTVuV3ox?=
 =?utf-8?B?UUg5YzJ2ZFd5VG9TVHlWeTJ4Uy96UUVVcG1LcnVDZStFN1plR2k2WFBRZWox?=
 =?utf-8?B?MWpXY3lBbmhhWFV0SXNIQno0bXMzWTE3cms2WHk0d24yQ3RZbkEzQUdNSFd2?=
 =?utf-8?B?b3daRnhUWEFwVHRQeXRGblRLbWZSYXdxamtKekp3bXFnVmtFZVJzaGIyalM0?=
 =?utf-8?B?cExKaWhpZGR5ZzV0NWI2TFRBVG1RNzJBaXRzMXRwbE94ejl0bHJaUHlwU1VC?=
 =?utf-8?B?NURheWtRaUY2MHJnSmpvSXJQcGxRUXB1SDBweTR3ZEtzMTh6a05tNGR4U0Q3?=
 =?utf-8?B?OFpzaG5XUTQ4YStPbHo2NEJldTBOU1Brd3Z5Y25ZRDZJdVdzR0QyUXhZVTNB?=
 =?utf-8?B?bEZHVHJ3U2lsa3RUd0o5NVB6Yk0wb3gyRGNKdTlkY1p3UXRPcUZBd2Z3VzVC?=
 =?utf-8?B?M2lGZnd1cW5sK3dQRnk0emNBYnBsK0w5WFFZZTBuNHo5Und1RHh2bjhqVVpz?=
 =?utf-8?B?ckJFZFNHZ1RKeXM5aVZDMU1POWhiK1VBRzNhcy81K09xeENVajc5VVZIMm9h?=
 =?utf-8?B?ZENBaWJpVGZpZk14eWl0d2o5T0N2NFY5NGpjQW5HWktrcExpRmlTWllmaVRI?=
 =?utf-8?B?a3B3QnJmcUo2elc2R21ITnBJVHFXaHNmYWM3dlFjRzE1UFYzeWNwUEJrd2dJ?=
 =?utf-8?B?T0FFT1VZczJ4OWhZck03NWxlR0xEbyswUDMwZzdESmp1aytYWE00YzFPbExY?=
 =?utf-8?B?WHU0WVFtdis0dWFOb1hXdmNpSlJFNXhUbXpadTNmL2I4blpRZEtMaHRzV2RV?=
 =?utf-8?B?aHJhNVZqbjh4aFhJTXpqMSs2YXlKbVdMeTZGbmFxcTExTkFudDVMTjZiNVlY?=
 =?utf-8?B?UDVhZFQ0WHNhOWFETmVhaVVid0J3MXdHV25PQ2RBRGQ2S1lGUUJVM3c3dy8w?=
 =?utf-8?B?eWJoQ2FZK2I5VXRzbFczaUp0Y25SWG1Wc3NWNnZ2NExiNkN6dDM4RXBnQkg5?=
 =?utf-8?B?UzJIVy9YQTV6c3R6cW1DVzRmSGtPdytyUDJsQkVVaDJtOGFyOU9nR3JEb1BZ?=
 =?utf-8?B?VllUMmFoVWUvMmdtSUpLcW1jLzFPSkYvb3BxSFVwSGNXNEdIRG5ITzhXYjNl?=
 =?utf-8?B?NFdYRW9mT1QzYUhZRkhNSHdyZEMrTlhzb1hWZkgwTHhPOUJwSjhJWEtBWWpB?=
 =?utf-8?B?V25paGoySWF0UUp4WnBRMlgxb0sxV1RETFA5RTZNTUg5UzZCNEtSYWg5V1U5?=
 =?utf-8?B?dHQ3Wm1aUStNcU44aG9NZ2lQY2ZLREM5bmFnOUJtNDNrRGVnQVVpRS9OREUz?=
 =?utf-8?B?UUtDM2lHT0VmanF3L0NGUT09?=
Content-ID: <0F07A363831BDA42B0681D8D7D05DA6C@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d746e54-b138-4d8b-e9d8-08d90c041286
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2021 18:16:27.7391 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DNg/ZavjPfGjTSJMCmRtlwUZSHO4i5VZEZzZxZEH4zOCNcCaDJPgLKZsAoKAaEcU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3708
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
Cc: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U29ycnkgSSBzaG91bGQgYmUgY2xlYXJlci4gDQoNCmRldi0+Z3B1LT5wY2lfYXRvbWljX3JlcXVl
c3RlZCBpcyBzZXQgdG8gdGhlIHZhbHVlIG9mIGFkZXYtPmhhdmVfYXRvbWljc19zdXBwb3J0IC0g
c2VlIGZ1bmN0aW9uIGFtZGdwdV9hbWRrZmRfaGF2ZV9hdG9taWNzX3N1cHBvcnQuIGFkZXYtPmhh
dmVfYXRvbWljc19zdXBwb3J0IGlzIHNldCB0aHJvdWdoIGZ1bmN0aW9uIHBjaV9lbmFibGVfYXRv
bWljX29wc190b19yb290IGN1cnJlbnRseSBpbiBhbWRncHVfZGV2aWNlX2luaXQgLSBJIGRvbid0
IHRoaW5rIHRoaXMgbG9naWMgaXMgY29ycmVjdCBmb3IgeGdtaSBjb25uZWN0ZWQgZGV2aWNlcy4g
Rm9yIHhnbWkgY29ubmVjdGVkIGRldmljZXMsIGFkZXYtPmhhdmVfYXRvbWljc19zdXBwb3J0IHNo
b3VsZCBhbHdheXMgc2V0IHRvIHRydWUuICtAQ29ybndhbGwsIEpheSB0byBjb21tZW50IGFzIHRo
ZSBvcmlnaW5hbCBhdXRob3Igb2YgdGhpcyBjb2Rlcy4NCg0KVGhlIGNvZGVzIEpvbiBwdXQgYmVs
b3cgcmVmZXJzIGRldi0+Z3B1LT5wY2lfYXRvbWljX3JlcXVlc3RlZCB0byBzZXQgdGhlIGlvIGxp
bmsgcHJvcGVydGllcy4gSSB0aGluayB3ZSBzaG91bGQgZml4IGFkZXYtPmhhdmVfYXRvbWljc19z
dXBwb3J0IHdoaWNoIGlzIHRoZSBzb3VyY2Ugb2YgZGV2LT5ncHUtPnBjaV9hdG9taWNfcmVxdWVz
dGVkLiBPbmNlIGFkZXYtPmhhdmVfYXRvbWljc19zdXBwb3J0IGlzIGZpeGVkLCBwYXJ0IG9mIHRo
ZSBjb2RlIGluIGtmZF90b3BvbG9neS5jIGRvZXNuJ3QgbmVlZCB0byBiZSBjaGFuZ2VkLiBDdXJy
ZW50bHkga2ZkX3RvcG9sb2d5LmMgaXMgdGhlIG9ubHkgY29uc3VtZXIgb2YgYWRldi0+aGF2ZV9h
dG9taWNzX3N1cHBvcnQgYW5kIHNlZW1zIHdlIG9ubHkgdXNlIHN1Y2ggaW5mb3JtYXRpb24gZm9y
IGdwdS1ncHUgaW8tbGluayBub3QgZm9yIGdwdS1jcHUgaW9saW5rIHByb3BlcnRpZXMuIEJ1dCBJ
IHN0aWxsIHRoaW5rIHdlIGZpeCBpdCBmcm9tIHRoZSBzb3VyY2UgaXMgYmV0dGVyIGJlY2F1c2Ug
aW4gdGhlIGZ1dHVyZSB0aGVyZSBtaWdodCBiZSBjb2RlIHJlZmVycyB0byBhZGV2LT5oYXZlX2F0
b21pY3Nfc3VwcG9ydC4gVGhlIGNvZGUgSSBwdXQgYmVsb3cgaXMgd3JvbmcgdGhvdWdoLCBpdCBz
aG91bGQgYmU6IA0KSWYgKCFhZGV2LT5nbWMueGdtaS5udW1fcGh5c2ljYWxfbm9kZXMpDQoJciA9
IHBjaV9lbmFibGVfYXRvbWljX29wc190b19yb290KGFkZXYtPnBkZXYsDQoJCQkJCSAgUENJX0VY
UF9ERVZDQVAyX0FUT01JQ19DT01QMzIgfA0KCQkJCQkgIFBDSV9FWFBfREVWQ0FQMl9BVE9NSUNf
Q09NUDY0KTsNCg0KUmVnYXJkcywNCk9hayANCg0KIA0KDQrvu79PbiAyMDIxLTA0LTI5LCAxMDo0
NSBQTSwgIkt1ZWhsaW5nLCBGZWxpeCIgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+IHdyb3RlOg0K
DQoNCiAgICBBbSAyMDIxLTA0LTI5IHVtIDk6MTIgcC5tLiBzY2hyaWViIFplbmcsIE9hazoNCiAg
ICA+IEkgdGhpbmsgcGFydCBvZiB0aGlzIGNhbiBiZSBkb25lIG1vcmUgY2xlYW4gaW4gYW1kZ3B1
X2RldmljZV9pbml0Og0KICAgID4NCiAgICA+IAlyID0gMDsNCiAgICA+IAlJZiAoIWFkZXYtPmdt
Yy54Z21pLmNvbm5lY3RlZF90b19jcHUpDQogICAgPiAJCS8qIGVuYWJsZSBQQ0lFIGF0b21pYyBv
cHMgKi8NCiAgICA+IAkJciA9IHBjaV9lbmFibGVfYXRvbWljX29wc190b19yb290KGFkZXYtPnBk
ZXYsDQogICAgPiAJCQkJCSAgUENJX0VYUF9ERVZDQVAyX0FUT01JQ19DT01QMzIgfA0KICAgID4g
CQkJCQkgIFBDSV9FWFBfREVWQ0FQMl9BVE9NSUNfQ09NUDY0KTsNCiAgICA+IAlpZiAocikgew0K
ICAgID4gCQlhZGV2LT5oYXZlX2F0b21pY3Nfc3VwcG9ydCA9IGZhbHNlOw0KICAgID4gCQlEUk1f
SU5GTygiUENJRSBhdG9taWMgb3BzIGlzIG5vdCBzdXBwb3J0ZWRcbiIpOw0KICAgID4gCX0gZWxz
ZSB7DQogICAgPiAJCWFkZXYtPmhhdmVfYXRvbWljc19zdXBwb3J0ID0gdHJ1ZTsNCiAgICA+IAl9
DQoNCiAgICBUaGlzIGNvZGUgaXMgYWxyZWFkeSBpbiBhbWRncHVfZGV2aWNlX2luaXQuIEknbSBu
b3Qgc3VyZSB3aGF0J3MgeW91cg0KICAgIHBvaW50LiBBcmUgeW91IHN1Z2dlc3RpbmcgdGhhdCB0
aGUgdG9wb2xvZ3kgZmxhZ3Mgc2hvdWxkIGJlIHVwZGF0ZWQgaW4NCiAgICBhbWRncHVfZGV2aWNl
X2luaXQ/IFRoYXQncyBub3QgcmVhbGx5IHBvc3NpYmxlIGJlY2F1c2UgdGhlIEtGRCB0b3BvbG9n
eQ0KICAgIGRhdGEgc3RydWN0dXJlcyBkb24ndCBleGlzdCBhdCB0aGF0IHRpbWUgKHRoZXkgZG8g
b25seSBhZnRlciB0aGUgY2FsbCB0bw0KICAgIGFtZGdwdV9kZXZpY2VfaXBfaW5pdCkgYW5kIHRo
ZSBkYXRhIHN0cnVjdHVyZXMgYXJlIG5vdCBrbm93biBpbg0KICAgIGFtZGdwdV9kZXZpY2UuYy4g
SXQncyBjbGVhbmVyIHRvIGtlZXAgdGhpcyBjb21wYXJ0bWVudGFsaXplZCBpbg0KICAgIGtmZF90
b3BvbG9neS5jLg0KDQogICAgUmVnYXJkcywNCiAgICAgIEZlbGl4DQoNCg0KICAgID4gUmVnYXJk
cywNCiAgICA+IE9hayANCiAgICA+DQogICAgPiAgDQogICAgPg0KICAgID4gT24gMjAyMS0wNC0y
OSwgNTozNiBBTSwgIktpbSwgSm9uYXRoYW4iIDxKb25hdGhhbi5LaW1AYW1kLmNvbT4gd3JvdGU6
DQogICAgPg0KICAgID4gICAgIExpbmsgYXRvbWljcyBzdXBwb3J0IG92ZXIgeEdNSSBzaG91bGQg
YmUgcmVwb3J0ZWQgaW5kZXBlbmRlbnRseSBvZiBQQ0llLg0KICAgID4NCiAgICA+ICAgICBTaWdu
ZWQtb2ZmLWJ5OiBKb25hdGhhbiBLaW0gPGpvbmF0aGFuLmtpbUBhbWQuY29tPg0KICAgID4gICAg
IFRlc3RlZC1ieTogUmFtZXNoIEVycmFib2x1IDxyYW1lc2guZXJyYWJvbHVAYW1kLmNvbT4NCiAg
ICA+ICAgICAtLS0NCiAgICA+ICAgICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Rv
cG9sb2d5LmMgfCAyOSArKysrKysrKysrKysrKy0tLS0tLS0tLQ0KICAgID4gICAgICAxIGZpbGUg
Y2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQogICAgPg0KICAgID4g
ICAgIGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3ku
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jDQogICAgPiAgICAg
aW5kZXggMDgzYWM5YmFiZmE4Li4zMDQzMGFlZmNmYzcgMTAwNjQ0DQogICAgPiAgICAgLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMNCiAgICA+ICAgICArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYw0KICAgID4gICAgIEBA
IC0xMTk2LDYgKzExOTYsNyBAQCBzdGF0aWMgdm9pZCBrZmRfZmlsbF9pb2xpbmtfbm9uX2NyYXRf
aW5mbyhzdHJ1Y3Qga2ZkX3RvcG9sb2d5X2RldmljZSAqZGV2KQ0KICAgID4gICAgICB7DQogICAg
PiAgICAgIAlzdHJ1Y3Qga2ZkX2lvbGlua19wcm9wZXJ0aWVzICpsaW5rLCAqY3B1X2xpbms7DQog
ICAgPiAgICAgIAlzdHJ1Y3Qga2ZkX3RvcG9sb2d5X2RldmljZSAqY3B1X2RldjsNCiAgICA+ICAg
ICArCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2Ow0KICAgID4gICAgICAJdWludDMyX3QgY2Fw
Ow0KICAgID4gICAgICAJdWludDMyX3QgY3B1X2ZsYWcgPSBDUkFUX0lPTElOS19GTEFHU19FTkFC
TEVEOw0KICAgID4gICAgICAJdWludDMyX3QgZmxhZyA9IENSQVRfSU9MSU5LX0ZMQUdTX0VOQUJM
RUQ7DQogICAgPiAgICAgQEAgLTEyMDMsMTggKzEyMDQsMjQgQEAgc3RhdGljIHZvaWQga2ZkX2Zp
bGxfaW9saW5rX25vbl9jcmF0X2luZm8oc3RydWN0IGtmZF90b3BvbG9neV9kZXZpY2UgKmRldikN
CiAgICA+ICAgICAgCWlmICghZGV2IHx8ICFkZXYtPmdwdSkNCiAgICA+ICAgICAgCQlyZXR1cm47
DQogICAgPg0KICAgID4gICAgIC0JcGNpZV9jYXBhYmlsaXR5X3JlYWRfZHdvcmQoZGV2LT5ncHUt
PnBkZXYsDQogICAgPiAgICAgLQkJCVBDSV9FWFBfREVWQ0FQMiwgJmNhcCk7DQogICAgPiAgICAg
LQ0KICAgID4gICAgIC0JaWYgKCEoY2FwICYgKFBDSV9FWFBfREVWQ0FQMl9BVE9NSUNfQ09NUDMy
IHwNCiAgICA+ICAgICAtCQkgICAgIFBDSV9FWFBfREVWQ0FQMl9BVE9NSUNfQ09NUDY0KSkpDQog
ICAgPiAgICAgLQkJY3B1X2ZsYWcgfD0gQ1JBVF9JT0xJTktfRkxBR1NfTk9fQVRPTUlDU18zMl9C
SVQgfA0KICAgID4gICAgIC0JCQlDUkFUX0lPTElOS19GTEFHU19OT19BVE9NSUNTXzY0X0JJVDsN
CiAgICA+ICAgICArCWFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKikoZGV2LT5ncHUtPmtn
ZCk7DQogICAgPiAgICAgKwlpZiAoIWFkZXYtPmdtYy54Z21pLmNvbm5lY3RlZF90b19jcHUpIHsN
CiAgICA+ICAgICArCQlwY2llX2NhcGFiaWxpdHlfcmVhZF9kd29yZChkZXYtPmdwdS0+cGRldiwN
CiAgICA+ICAgICArCQkJCVBDSV9FWFBfREVWQ0FQMiwgJmNhcCk7DQogICAgPiAgICAgKw0KICAg
ID4gICAgICsJCWlmICghKGNhcCAmIChQQ0lfRVhQX0RFVkNBUDJfQVRPTUlDX0NPTVAzMiB8DQog
ICAgPiAgICAgKwkJCSAgICAgUENJX0VYUF9ERVZDQVAyX0FUT01JQ19DT01QNjQpKSkNCiAgICA+
ICAgICArCQkJY3B1X2ZsYWcgfD0gQ1JBVF9JT0xJTktfRkxBR1NfTk9fQVRPTUlDU18zMl9CSVQg
fA0KICAgID4gICAgICsJCQkJQ1JBVF9JT0xJTktfRkxBR1NfTk9fQVRPTUlDU182NF9CSVQ7DQog
ICAgPiAgICAgKwl9DQogICAgPg0KICAgID4gICAgIC0JaWYgKCFkZXYtPmdwdS0+cGNpX2F0b21p
Y19yZXF1ZXN0ZWQgfHwNCiAgICA+ICAgICAtCSAgICBkZXYtPmdwdS0+ZGV2aWNlX2luZm8tPmFz
aWNfZmFtaWx5ID09IENISVBfSEFXQUlJKQ0KICAgID4gICAgIC0JCWZsYWcgfD0gQ1JBVF9JT0xJ
TktfRkxBR1NfTk9fQVRPTUlDU18zMl9CSVQgfA0KICAgID4gICAgIC0JCQlDUkFUX0lPTElOS19G
TEFHU19OT19BVE9NSUNTXzY0X0JJVDsNCiAgICA+ICAgICArCWlmICghYWRldi0+Z21jLnhnbWku
bnVtX3BoeXNpY2FsX25vZGVzKSB7DQogICAgPiAgICAgKwkJaWYgKCFkZXYtPmdwdS0+cGNpX2F0
b21pY19yZXF1ZXN0ZWQgfHwNCiAgICA+ICAgICArCQkJCWRldi0+Z3B1LT5kZXZpY2VfaW5mby0+
YXNpY19mYW1pbHkgPT0NCiAgICA+ICAgICArCQkJCQkJCUNISVBfSEFXQUlJKQ0KICAgID4gICAg
ICsJCQlmbGFnIHw9IENSQVRfSU9MSU5LX0ZMQUdTX05PX0FUT01JQ1NfMzJfQklUIHwNCiAgICA+
ICAgICArCQkJCUNSQVRfSU9MSU5LX0ZMQUdTX05PX0FUT01JQ1NfNjRfQklUOw0KICAgID4gICAg
ICsJfQ0KICAgID4NCiAgICA+ICAgICAgCS8qIEdQVSBvbmx5IGNyZWF0ZXMgZGlyZWN0IGxpbmtz
IHNvIGFwcGx5IGZsYWdzIHNldHRpbmcgdG8gYWxsICovDQogICAgPiAgICAgIAlsaXN0X2Zvcl9l
YWNoX2VudHJ5KGxpbmssICZkZXYtPmlvX2xpbmtfcHJvcHMsIGxpc3QpIHsNCiAgICA+ICAgICAt
LSANCiAgICA+ICAgICAyLjE3LjENCiAgICA+DQogICAgPg0KDQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
