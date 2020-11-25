Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9598FC5519F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 04:32:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1268E206CA
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 04:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lGmJ2gTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1268E206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 166166E500;
	Wed, 25 Nov 2020 04:32:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FE406E500
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 04:32:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzQHIi+u53dhBWNm0sHqbirPPFN+ktBUaxiSibg/P/sf37e+boc84MPCmv+ZrK/LDUBwCqeJEAvdC6f86two0Gu9oF+k71PiWy9KT3s28ERa1e9oGaRiLG6n2qQT8oGtHpZXbaylWmjkOWCE5Z0YoV7uclWzvuTRv5fpdlqDpumQ5dfMeifdNJCJBSrutn+3hlXIOvNtNM3eTSjQKrcc31CyA6YD1MdiuCwStOvCAZHMHGrKnfUWgfY7BAzVn9JYayasUVlP8btQxFOx2aXfONn4qkWpvS1uOFZ/wOLjSIMbZXkpNpzHJk9mDdj1IA/d8tKCzviZwuvH5B62er4xrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DlJ7hLKAsTrYV43+hmiUZW3qxwfSqYRqL4B2rNkQXU=;
 b=NfU2apqe+07LWdiZ2njTMZWgz0OpWXFi5JV0nDPwC1qZFFJx3wABGbgublZnVqfnNJXpGqKG0eVrI9T6V2Zpo2jv7VDtvMCeKdj4/UI/q5aoo7tnqI7WiJuJOVWn6W0o7ocfp0w/vBNgRnP3ofe2zCdsXorVSNDjke0yguWnjo+15hPf8NeqlyMOd/NZvxlxAJz90ji0/oiZchF5pYMbFKH92bv6PmeRoZRA3OaXFFv7/9twu84AESj1txunxbeHH2zJXUlchbubg1ExQbkkE85rgJQscR2t4y3fbM3VXaDmP8LBhVOeiRBWltuZbD+rJAB7lOcs++GMy8bWvsWtBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DlJ7hLKAsTrYV43+hmiUZW3qxwfSqYRqL4B2rNkQXU=;
 b=lGmJ2gTVzl823M4KSOVSUnjR0nxr06CASQe8SrP5VIvA4Hj7Z7cQ+kGVG1sa/XsMT+iNAwNDE3hUFPkAw6aob2NFWvIJ2+h3hpLGaRmNwVVk3xVqB4SpoEnAJk7/fxWHcjNYFNZdeo2wVNfK9hioSVwP9dnEZW6BVQ+G43/uvWA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3117.namprd12.prod.outlook.com (2603:10b6:208:d1::22)
 by MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.28; Wed, 25 Nov
 2020 04:32:27 +0000
Received: from MN2PR12MB3117.namprd12.prod.outlook.com
 ([fe80::7ccd:6ebf:40e7:7039]) by MN2PR12MB3117.namprd12.prod.outlook.com
 ([fe80::7ccd:6ebf:40e7:7039%7]) with mapi id 15.20.3589.030; Wed, 25 Nov 2020
 04:32:27 +0000
Subject: Re: [PATCH] drm/amd/display: Extends Tune min clk for MPO for RV
To: Harry Wentland <harry.wentland@amd.com>,
 Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 nicholas.kazlauskas@amd.com, hersenxs.wu@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20201124155508.2096060-1-Pratik.Vishwakarma@amd.com>
 <393ee532-7690-ce76-4b36-75a65656173b@amd.com>
From: Pratik Vishwakarma <pvishwak@amd.com>
Message-ID: <858f7cc8-77c0-9955-d164-e644b84cfb5f@amd.com>
Date: Wed, 25 Nov 2020 10:02:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <393ee532-7690-ce76-4b36-75a65656173b@amd.com>
Content-Language: en-US
X-Originating-IP: [106.200.200.37]
X-ClientProxiedBy: MA1PR01CA0079.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::19)
 To MN2PR12MB3117.namprd12.prod.outlook.com
 (2603:10b6:208:d1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.6] (106.200.200.37) by
 MA1PR01CA0079.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20 via Frontend Transport; Wed, 25 Nov 2020 04:32:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d4dc9b2c-b6be-4ef7-94dd-08d890fb1d0a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3022:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3022923B169AA6D8580E8E3D80FA0@MN2PR12MB3022.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7i43GsXwqdT9hd/TY981Bt/wEz4+EhpJgYsxTkO6nTXeo0PbhNEjKSRlp+z94Z+SaCH+swgfmSTk90EQNREPAp8wK2XOt6z75pTznSKNycoWYs37LubM6AtBrjKK4ncYlIxL10NQecSKG5lfQpJRv/skYEV3Jp5GCqvw8++eQq1qoKxocJD9mcbqftAicLZivlPO6dOWc89T1OWDMrQNW5AbWBKT1P8fhU1vZXyzvsNvd1cxhkPWjiPSakVHcbHeKgtUg3DhUo4kE65RuVOgUc63n4Vm+WRgv0yVeb6GZvR+1XwuPlFa3cX7/f4LH5A9Xh4pZoMTuSSzaJRDVnQBJgEjNIvZC07kazW6HSCFHcy/eC4i8281nqGOC4TcRsqA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3117.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(2906002)(8676002)(8936002)(36756003)(31696002)(6486002)(956004)(2616005)(110136005)(1006002)(6666004)(16576012)(316002)(31686004)(52116002)(83380400001)(26005)(478600001)(16526019)(186003)(53546011)(66946007)(66476007)(66556008)(4001150100001)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZjQrTWhvOERvVG1iUVZ0amQvZCtOQ1c1UWJqS0srclI1SUNCUXh1SE5iZFV3?=
 =?utf-8?B?UU9uT0UzLytuWkQ5L25YeVdIbVR2aVdEYVBQNmtrenVyT08xRGg5d0duVFN0?=
 =?utf-8?B?dVIxb0tORW1jekZmSHVpV3lxdXZjbm8wMTEvSkhmRUpaRTlhdklPMGxzWVE0?=
 =?utf-8?B?eU9xbldSWWRxRTNpOE9mZWZGRkJ0ZE84b09ZT0ZCSnJEaXMxZ05mQ3RPRVhz?=
 =?utf-8?B?NDY3eXI0Um9xVExuK3ByTWFjQ2VJMks5SnROQXV6MjBvNERlYUJvR3Y1M1dR?=
 =?utf-8?B?eWw0N0Nyb2V4VXN0TjZFKzc0WGdrcXd0MUxZL3pNRVdmMjBRaE45N1ZNbnVx?=
 =?utf-8?B?SGU1bGcxeHRBcEE3bkR2d1dmZTFDeGo4bE4wOFhtMHBwWkVPbk9KTVo2Tnh4?=
 =?utf-8?B?Sk9FSG83QXlhUWpyeS91aGE5ekZ0ZW01NUorc0l5b2hCMEFuTDdnRmF6Z001?=
 =?utf-8?B?cUhiTjA1U2QzTDV0ejdaSktoeXF1SkZtRnpnL3dZbkhiL1lDT0xlSS82ay9I?=
 =?utf-8?B?M0dJNXpuMUo1QjFpMHlEZEovMTVIaUpsNHY5dFR2VExBekExa3VTejIvUi9W?=
 =?utf-8?B?Y1BhbXgvUDAyQW1MeDBMcDg2N2lZcUw1cXU3aVNxcC9acFhFeEFQL1hFZFcw?=
 =?utf-8?B?RUFiTXJEckdQS0N0Sm16amV1ZzFNMTY1dmJpT3I1eFp3Z2JYM2l2NFV4dEQ0?=
 =?utf-8?B?akRTSlM4UUVVUS81WXIwN2NIK1l2V24rVHU4VDZqUTlhNW5ieXNPWDU2NFZa?=
 =?utf-8?B?M0FZc2dudlZqV09GY1ZCdWlOUnFyMW9jYW1SUGk4T0lqblFmdGt2NEZrc1Q5?=
 =?utf-8?B?a1E3S285clBVWFBFNzhLL1RJdjJ1d0xsRjBNckF0cnhJUHVlc2k1Z1lpOGNq?=
 =?utf-8?B?UmdwTzJDMmZwOXAvWkpjZGJnc2pwT2ZCWnR0NVhZYmgydlZhUEJ0S2NYVi9Y?=
 =?utf-8?B?ZHVrQkh0QXJMMDJ0MDhzdkZiUkpXS3hBaWZVam9xUUxyK2lNRnpZYzZCdjBP?=
 =?utf-8?B?VHQxVWd6VUpGNnhDWk9NN0JnbXVER29aelJTTmRvWkpsVDNkMjlLckd1cmpp?=
 =?utf-8?B?ejlLK2FydkFIZXRBNjY4cVY4R2d3a0V1TFZyVkxkRXZacEl6Szh5VTB6TGEv?=
 =?utf-8?B?L1NPTVVmNTFEcXFVZko3UEtpdTZVWDM0K2plb2VRTHlrYUNUbTdOTEgyNFpq?=
 =?utf-8?B?cEU2dEtsWm85d2JHcmVjaFBodUtGeGZBS3FvSWQrcmE1b3JDT0dtdzIySklE?=
 =?utf-8?B?RGRLejNnUExmMW44WHJuZ2NXOU1rZ0RRNll3STh0cVJTMkliUmFoY1VEYysv?=
 =?utf-8?Q?vWL+Nt4wtNaOjaDq9lTUOGG5Qh3rp21tfe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4dc9b2c-b6be-4ef7-94dd-08d890fb1d0a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3117.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2020 04:32:27.7095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gX31zT3Rg02wlZzh3DHHz4WP720i46siRxPXEB/EsNEzC3YZfzV0tkb8f/kH+MNYXpAZOsDgMf5Iyo8a2ZjMbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3022
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjUvMTEvMjAgMTozOCBhbSwgSGFycnkgV2VudGxhbmQgd3JvdGU6Cj4gT24gMjAyMC0xMS0y
NCAxMDo1NSBhLm0uLCBQcmF0aWsgVmlzaHdha2FybWEgd3JvdGU6Cj4+IFtXaHldCj4+IENoYW5n
ZXMgaW4gdmlkZW8gcmVzb2x1dGlvbiBkdXJpbmcgcGxheWJhY2sgY2F1c2UKPj4gZGlzcGNsayB0
byByYW1wIGhpZ2hlciBidXQgc2V0cyBpbmNvbXBhdGlsZSBmY2xrCj4+IGFuZCBkY2ZjbGsgdmFs
dWVzIGZvciBNUE8uCj4+Cj4+IFtIb3ddCj4+IENoZWNrIGZvciBNUE8gYW5kIHNldCBwcm9wZXIg
bWluIGNsayB2YWx1ZXMKPj4gZm9yIHRoaXMgY2FzZSBhbHNvLiBUaGlzIHdhcyBtaXNzZWQgZHVy
aW5nIHByZXZpb3VzCj4+IHBhdGNoLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBQcmF0aWsgVmlzaHdh
a2FybWEgPFByYXRpay5WaXNod2FrYXJtYUBhbWQuY29tPgo+PiAtLS0KPj4gwqAgLi4uL2Rpc3Bs
YXkvZGMvY2xrX21nci9kY24xMC9ydjFfY2xrX21nci5jwqDCoMKgIHwgMTkgKysrKysrKysrKysr
KysrKy0tLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkKPj4KPj4gZGlmZiAtLWdpdCAKPj4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvY2xrX21nci9kY24xMC9ydjFfY2xrX21nci5jIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9jbGtfbWdyL2RjbjEwL3J2MV9jbGtfbWdyLmMKPj4gaW5kZXggNzViODI0MGVk
MDU5Li5lZDA4N2E5ZTczYmIgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9jbGtfbWdyL2RjbjEwL3J2MV9jbGtfbWdyLmMKPj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2Nsa19tZ3IvZGNuMTAvcnYxX2Nsa19tZ3IuYwo+PiBAQCAtMjc1
LDkgKzI3NSwyMiBAQCBzdGF0aWMgdm9pZCBydjFfdXBkYXRlX2Nsb2NrcyhzdHJ1Y3QgY2xrX21n
ciAKPj4gKmNsa19tZ3JfYmFzZSwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChwcF9zbXUtPnNl
dF9oYXJkX21pbl9mY2xrX2J5X2ZyZXEgJiYKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBwcF9zbXUtPnNldF9oYXJkX21pbl9kY2ZjbGtfYnlfZnJlcSAmJgo+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBwX3NtdS0+c2V0X21pbl9kZWVwX3NsZWVwX2Rj
ZmNsaykgewo+PiAtIHBwX3NtdS0+c2V0X2hhcmRfbWluX2ZjbGtfYnlfZnJlcSgmcHBfc211LT5w
cF9zbXUsIAo+PiBuZXdfY2xvY2tzLT5mY2xrX2toeiAvIDEwMDApOwo+PiAtIHBwX3NtdS0+c2V0
X2hhcmRfbWluX2RjZmNsa19ieV9mcmVxKCZwcF9zbXUtPnBwX3NtdSwgCj4+IG5ld19jbG9ja3Mt
PmRjZmNsa19raHogLyAxMDAwKTsKPj4gLSBwcF9zbXUtPnNldF9taW5fZGVlcF9zbGVlcF9kY2Zj
bGsoJnBwX3NtdS0+cHBfc211LCAKPj4gKG5ld19jbG9ja3MtPmRjZmNsa19kZWVwX3NsZWVwX2to
eiArIDk5OSkgLyAxMDAwKTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLy8gT25seSBpbmNy
ZWFzZSBjbG9ja3Mgd2hlbiBkaXNwbGF5IGlzIGFjdGl2ZSBhbmQgTVBPIAo+PiBpcyBlbmFibGVk
Cj4KPiBXaHkgZG8gd2Ugd2FudCB0byBvbmx5IGRvIHRoaXMgd2hlbiBNUE8gaXMgZW5hYmxlZD8K
Pgo+IEhhcnJ5CgpIaSBIYXJyeSwKCldoZW4gTVBPIGlzIGVuYWJsZWQgYW5kIHN5c3RlbSBtb3Zl
cyB0byBsb3dlciBjbG9jayBzdGF0ZSwgY2xvY2sgdmFsdWVzIAphcmUgbm90IHN1ZmZpY2llbnQg
YW5kIHdlIHNlZSBmbGFzaCBsaW5lcyBhY3Jvc3MgZW50aXJlIHNjcmVlbi4KClRoaXMgaXNzdWUg
aXMgbm90IG9ic2VydmVkIHdoZW4gTVBPIGlzIGRpc2FibGVkIG9yIG5vdCBhY3RpdmUuCgpSZWdh
cmRzLAoKUHJhdGlrCgo+Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChkaXNwbGF5X2Nv
dW50ICYmIGlzX21wb19lbmFibGVkKGNvbnRleHQpKSB7Cj4+ICsgcHBfc211LT5zZXRfaGFyZF9t
aW5fZmNsa19ieV9mcmVxKCZwcF9zbXUtPnBwX3NtdSwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKChuZXdfY2xvY2tzLT5mY2xrX2toeiAvIDEwMDAp
ICogMTAxKSAvIDEwMCk7Cj4+ICsgcHBfc211LT5zZXRfaGFyZF9taW5fZGNmY2xrX2J5X2ZyZXEo
JnBwX3NtdS0+cHBfc211LAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAoKG5ld19jbG9ja3MtPmRjZmNsa19raHogLyAxMDAwKSAqIDEwMSkgLyAxMDAp
Owo+PiArIHBwX3NtdS0+c2V0X21pbl9kZWVwX3NsZWVwX2RjZmNsaygmcHBfc211LT5wcF9zbXUs
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChuZXdf
Y2xvY2tzLT5kY2ZjbGtfZGVlcF9zbGVlcF9raHogKyA5OTkpIC8gCj4+IDEwMDApOwo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB9IGVsc2Ugewo+PiArIHBwX3NtdS0+c2V0X2hhcmRfbWluX2Zj
bGtfYnlfZnJlcSgmcHBfc211LT5wcF9zbXUsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5ld19jbG9ja3MtPmZjbGtfa2h6IC8gMTAwMCk7Cj4+ICsg
cHBfc211LT5zZXRfaGFyZF9taW5fZGNmY2xrX2J5X2ZyZXEoJnBwX3NtdS0+cHBfc211LAo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZXdfY2xvY2tz
LT5kY2ZjbGtfa2h6IC8gMTAwMCk7Cj4+ICsgcHBfc211LT5zZXRfbWluX2RlZXBfc2xlZXBfZGNm
Y2xrKCZwcF9zbXUtPnBwX3NtdSwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgKG5ld19jbG9ja3MtPmRjZmNsa19kZWVwX3NsZWVwX2toeiArIDk5OSkg
LyAKPj4gMTAwMCk7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4gwqDCoMKgwqDCoMKg
wqDCoMKgIH0KPj4gwqDCoMKgwqDCoCB9Cj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
