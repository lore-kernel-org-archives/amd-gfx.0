Return-Path: <SRS0=2cAG=FA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0CAC63777
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 21:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD5B820B80
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 21:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2LwFynj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5B820B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2653C6EACC;
	Thu, 26 Nov 2020 21:47:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBEFE6EACC
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 21:47:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ml5eDgM2ny7xBbI9XulpM+Z+JGDD8B2DF4snUZn+tnDQvfAVOMdn17Yzbh9KtkrgTcgAnAB/GcGc/eMYJ+1LUmMqb4jt9pVxhI7HKy+Z9ot8DnRfTsqVtXkFBOIoFmKfz5rYmK6/Gohtz6FXyiR9USgMR3LM86uIahw8rYjiSvGToCpUypob5pWVMBDOLOUepisYjrfkqx61L+bml5CcjMmXnCOTtaHZFncMBt1H0OdTnHJ8uqWJlwyIFxqBgkmwQFiAxsCidPJhpTeZxW0d/U/rYpFBZZqbZ/+4NaSkJ71fhA15tPyeheKvsj4/p5IfZXZiIZBM+lzriAZrbpZglw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUo13uBf7F3b6Wv464idO3Mepy6zoqYptqAEHyJbw1A=;
 b=VVrWZNuGsm5OF0FD4Yn1/QXbWt3JOWRljoYQfen2sYrw+0f8E6nVddEfOQOZ0yeK216AU0CZIlAoGhEGul19P35D2Vld6EmJWrTEvUe/ANTZJpqnT7fRyn7mzDnRPsuK9/VNp8Ct9bcHP8UU5earPPNsPPLtwHfB2ENc6bgF1PuFcy6XZzxVncuigFG4otvevrTq/ZNFw1No4H8UzxEbjyToFQsxd8v8MIh4NRSYayIkGQhi3SIbNI9Vl548JIl7jBkz1hl9y9EKOUk4OzJ5d5Dki8cdooUh9qsLDFG2tOBbOa4vNuLcmtxHVCJSdrbs1uCUSncJ9/W5BFxZv/X77w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUo13uBf7F3b6Wv464idO3Mepy6zoqYptqAEHyJbw1A=;
 b=2LwFynj4ar1buBbNvmLuPQXQxcEYv47MVjZnTvxizX7OFlgk/yGrGOVf6glpGTBL7a/sAu1KcTroTn7KOcyHpRyE6O7wSFCUCionEsbTK0c3Wvuhgd9AcKv/2fPYn/a3qJrcMCXncrPvlXIvgMk7Pi3Pv6HFlelCVLcGNGfQ+Pk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1939.namprd12.prod.outlook.com (2603:10b6:404:107::12)
 by BN6PR1201MB0083.namprd12.prod.outlook.com (2603:10b6:405:54::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Thu, 26 Nov
 2020 21:47:46 +0000
Received: from BN6PR12MB1939.namprd12.prod.outlook.com
 ([fe80::f8f7:573f:9fae:e40c]) by BN6PR12MB1939.namprd12.prod.outlook.com
 ([fe80::f8f7:573f:9fae:e40c%11]) with mapi id 15.20.3611.023; Thu, 26 Nov
 2020 21:47:46 +0000
Subject: Re: [PATCH] drm/amd/display: turn DPMS off on mst connector unplug
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20201126195036.310979-1-aurabindo.pillai@amd.com>
 <6c21448a-11ee-3b14-b72f-d56f7ac09d2e@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Autocrypt: addr=aurabindo.pillai@amd.com; keydata=
 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
 Gul9w6KOPkCni6aOWdaa4kvIZpWBE+E=
Message-ID: <c075bdcd-1670-e94b-b5d0-db8336d22a14@amd.com>
Date: Thu, 26 Nov 2020 16:47:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <6c21448a-11ee-3b14-b72f-d56f7ac09d2e@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR19CA0120.namprd19.prod.outlook.com
 (2603:10b6:404:a0::34) To BN6PR12MB1939.namprd12.prod.outlook.com
 (2603:10b6:404:107::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.3.110] (165.204.84.11) by
 BN6PR19CA0120.namprd19.prod.outlook.com (2603:10b6:404:a0::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20 via Frontend Transport; Thu, 26 Nov 2020 21:47:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 44b7b646-24a6-4715-453a-08d89254e946
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0083:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0083B19F6AD7D4FB135FF1028BF90@BN6PR1201MB0083.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QR1xl4KaBEkY28lu5ErgAvy0ypFr4MPjQroSxGwMe6dPANqpcoadS9V75A4WcOMvo1FA8jVikKdBmOAsvOaZwk9mLHEmIcdzHHh4AgmW0YqfMhBT4LzfsEZIvnv1zPvvlZND+ZCL9jmkniOs9GWet4fLsd70yhV3gBOmRBfNsdW+RO0JYWCa+SvtvB8omRGKRYPuxABSfQoX56cQKUinaVEyGPzA0qpwT9IHn124uDGDdTUaByubjcYzNxxGUJibS9/5TdW0RHsYS991/yi9XJIF9/BhJhYMs1DEcUO2aoUl6V1ABik6IX990hG/TbpyfLPGOn2EV1ODXgsgQ+WBkk4XZ6KVKNYmnC5l0IyX0AxK9gvFu8WqcTt+X5PHdgP+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(52116002)(16526019)(4001150100001)(53546011)(86362001)(5660300002)(4326008)(6486002)(31686004)(8936002)(44832011)(16576012)(186003)(316002)(66556008)(26005)(8676002)(956004)(2906002)(2616005)(66476007)(31696002)(83380400001)(478600001)(36756003)(66946007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NytUcWRwNDNlZXMyNnZBL2FIRmZzRGJPUTZYQ2RJVmJZVy8rSG0xRjhyWGhx?=
 =?utf-8?B?Y2NUYURNYjI4RzgxZFlFcHZIR2FBR1FTajJVNEdqNTlPcnB0K1RhY3hVTW8z?=
 =?utf-8?B?aEtmcDhDb3h1cEFaQ0l0SjExZFJYNmdIUHYxb1AvL2JmVWUwdnI3V0RjeW9j?=
 =?utf-8?B?SXFPaTNxZGNWQmRXa3NHa2hOMEJXdjVNZHNvVThMeXkySEwvaEQzVVBQQ1NV?=
 =?utf-8?B?eHM4aXFXbkdUM0psQnRuejR1TXdzaWhlenFGbGZ6OVR5eDc2ZHNhYk5YTjQy?=
 =?utf-8?B?NGJIREg3VEFWSDdjeDhuaGpOU1RWQXdKWnBFOWI4bVo3S3U3NkRKNDJNS01N?=
 =?utf-8?B?c01vTXdYOExGVndxV0QvM2pqV1lwaDB2S2tjV095ZmVTRFVZL0dWbGV6S1Jk?=
 =?utf-8?B?amdzR1ByUWxCMEJReDAzMm1vN0plVnVQcW8wbnNTRzZoUGF3eEw3QkpNRWZ5?=
 =?utf-8?B?ZHljc2ZqVFBKL00vYS9pL215MVd0bjNuT3VtelR5TkJGb2lVRlBsYjIyWVlU?=
 =?utf-8?B?bzA3T2NZeXRIS1RYWlFacGtyM2xWL2kwN3o4ZWJON2tIR2wvMi9PSFJOcm80?=
 =?utf-8?B?UFBiUityS2RueFQxeHZYeFRVb00rTTVFNnkxZWcyNGIwU2k0dGFIbVN4Nndy?=
 =?utf-8?B?OXd1Y3l2VWgyWFpCL09FalZJbnlaRDBWaU00eFVSU2EvZXo0WXJKMk05Nkht?=
 =?utf-8?B?T2UwZjNOZjNOem5kSzd0dnNNTk1WMktSNERETUh1MEJ5Y0o2ZVlJNU42OENK?=
 =?utf-8?B?aFlDQkNoNGRoVnM2eldEWXBiTGlzT3hINWhRRkM5UnZzRWFtQXNvTWJaOC9Q?=
 =?utf-8?B?bjRYejc0d1BaVFRNY0Q4YlA4M2xsb251UHZzMEFXam5aMjljMXFJTElEZm04?=
 =?utf-8?B?b3UxT0htTUNPT0pjYm1qWERWK0Ixd3pqQU9wLy8xTUlFZWIyQUk1TXUzRVBu?=
 =?utf-8?B?NU9XVEYzT3FoOUt5cDdJK1IzbGlYRnIwOFd1RFJ1d0hsbnRJai9OUEExak9S?=
 =?utf-8?B?ZTlJbzhUZE1LOE9ybDdvaU16MUtzdTZlMGZxd3A3b2YrcTFFVXdKaUc3UUd1?=
 =?utf-8?B?TC81aUJvS0wydXNzS2djakxNQnZVTnEwcXR1WmxITVpodWZzQ2ZidjJ5aTNi?=
 =?utf-8?B?U3BpeWdOcitiVWZCNVgvdWdGRkZaaDgxM002bHRreUJxNFJrTkF1emlmdFY4?=
 =?utf-8?B?Syt4cTFuV2FKR2VIM0NqNWdLT0U5b0h6OUczZ3JjRXJVa2tnMk1YTE4rQ01M?=
 =?utf-8?B?Slp2QVA4R0FEekNQK3Y5emUvbkVmSGRpeFZFQ0FQNHpNWE9jd0tveE1aNU55?=
 =?utf-8?Q?BZ98j6yBAKGEGLbOH7HJ5bWtQ6tbnnUKt6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b7b646-24a6-4715-453a-08d89254e946
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 21:47:46.4028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ha4aSkWHX1Se1rG4gCW2jBjFLxHnq9AGxYary3eEI/5sOcDjvvHbzwrjuxW2OSjEgvcKAw4PQFicfHI1C4LUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0083
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
Cc: Bhawanpreet.Lakha@amd.com, Harry.Wentland@amd.com, Eryk.Brol@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpPbiAyMDIwLTExLTI2IDM6MTEgcC5tLiwgS2F6bGF1c2thcywgTmljaG9sYXMgd3JvdGU6Cj4g
T24gMjAyMC0xMS0yNiAyOjUwIHAubS4sIEF1cmFiaW5kbyBQaWxsYWkgd3JvdGU6Cj4+IFtXaHkm
SG93XQo+Pgo+PiBTZXQgZHBtcyBvZmYgb24gdGhlIE1TVCBjb25uZWN0b3IgdGhhdCB3YXMgdW5w
bHVnZ2VkLCBmb3IgdGhlIHNpZGUKPj4gZWZmZWN0IG9mCj4+IHJlbGVhc2luZyBzb21lIHJlZmVy
ZW5jZXMgaGVsZCB0aHJvdWdoIGRlYWxsb2NhdGlvbiBvZiBtc3QgcGF5bG9hZC4KPj4KPj4gU2ln
bmVkLW9mZi1ieTogQXVyYWJpbmRvIFBpbGxhaSA8YXVyYWJpbmRvLnBpbGxhaUBhbWQuY29tPgo+
PiBTaWduZWQtb2ZmLWJ5OiBFcnlrIEJyb2wgPGVyeWsuYnJvbEBhbWQuY29tPgo+PiAtLS0KPj4g
wqAgLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHwgNjMgKysr
KysrKysrKysrKysrKysrLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNjIgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPj4gaW5kZXggZTIxMzI0NmUzZjA0Li5mYzk4NGNmNmUz
MTYgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0v
YW1kZ3B1X2RtLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9k
bS9hbWRncHVfZG0uYwo+PiBAQCAtMTk4NCw2ICsxOTg0LDY0IEBAIHN0YXRpYyB2b2lkIGRtX2dw
dXJlc2V0X2NvbW1pdF9zdGF0ZShzdHJ1Y3QKPj4gZGNfc3RhdGUgKmRjX3N0YXRlLAo+PiDCoMKg
wqDCoMKgIHJldHVybjsKPj4gwqAgfQo+PiDCoCArc3RhdGljIHZvaWQgZG1fc2V0X2RwbXNfb2Zm
KHN0cnVjdCBkY19saW5rICpsaW5rKQo+PiArewo+PiArwqDCoMKgIHN0cnVjdCB7Cj4+ICvCoMKg
wqDCoMKgwqDCoCBzdHJ1Y3QgZGNfc3VyZmFjZV91cGRhdGUgc3VyZmFjZV91cGRhdGVzW01BWF9T
VVJGQUNFU107Cj4+ICvCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZGNfc3RyZWFtX3VwZGF0ZSBzdHJl
YW1fdXBkYXRlOwo+PiArwqDCoMKgIH0gKiBidW5kbGU7Cj4+ICvCoMKgwqAgc3RydWN0IGRjX3N0
cmVhbV9zdGF0ZSAqc3RyZWFtX3N0YXRlOwo+PiArwqDCoMKgIHN0cnVjdCBkY19jb250ZXh0ICpk
Y19jdHggPSBsaW5rLT5jdHg7Cj4+ICvCoMKgwqAgaW50IGk7Cj4+ICsKPj4gK8KgwqDCoCBidW5k
bGUgPSBremFsbG9jKHNpemVvZigqYnVuZGxlKSwgR0ZQX0tFUk5FTCk7Cj4+ICsKPj4gK8KgwqDC
oCBpZiAoIWJ1bmRsZSkgewo+PiArwqDCoMKgwqDCoMKgwqAgZG1fZXJyb3IoIkZhaWxlZCB0byBh
bGxvY2F0ZSB1cGRhdGUgYnVuZGxlXG4iKTsKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybjsKPj4g
K8KgwqDCoCB9Cj4+ICsKPj4gK8KgwqDCoCBidW5kbGUtPnN0cmVhbV91cGRhdGUuZHBtc19vZmYg
PSBremFsbG9jKHNpemVvZihib29sKSwgR0ZQX0tFUk5FTCk7Cj4gCj4gWW91IGRvbid0IG5lZWQg
dG8gYWxsb2NhdGUgbWVtb3J5IGZvciB0aGUgYm9vbC4gWW91IGNhbiBqdXN0IHVzZSBhIGxvY2Fs
Cj4gaGVyZSwgREMgZG9lc24ndCBuZWVkIGl0IGFmdGVyIHRoZSBjYWxsIGVuZHMuCj4gCj4gSSB0
aGluayB0aGUgc2FtZSBzaG91bGQgYXBwbHkgdG8gdGhlIHN1cmZhY2UgdXBkYXRlcyBhcyB3ZWxs
LiBJJ20gbm90Cj4gZW50aXJlbHkgc3VyZSBob3cgbXVjaCBzdGFjayB0aGUgYnVuZGxlIHRha2Vz
IHVwIGZvciBhIHNpbmdsZSBzdHJlYW0KPiBoZXJlIGJ1dCBpdCBzaG91bGQgYmUgc21hbGwgZW5v
dWdoIHRoYXQgd2UgY2FuIGxlYXZlIGl0IG9uIHRoZSBzdGFjay4KPiAKPj4gKwo+PiArwqDCoMKg
IGlmICghYnVuZGxlLT5zdHJlYW1fdXBkYXRlLmRwbXNfb2ZmKSB7Cj4+ICvCoMKgwqDCoMKgwqDC
oCBkbV9lcnJvcigiRmFpbGVkIHRvIGFsbG9jYXRlIHVwZGF0ZSBidW5kbGVcbiIpOwo+PiArwqDC
oMKgwqDCoMKgwqAgZ290byBjbGVhbnVwOwo+PiArwqDCoMKgIH0KPj4gKwo+PiArwqDCoMKgICpi
dW5kbGUtPnN0cmVhbV91cGRhdGUuZHBtc19vZmYgPSB0cnVlOwo+PiArCj4+ICvCoMKgwqAgZm9y
IChpID0gMDsgaTwgTUFYX1BJUEVTOyBpKyspIHsKPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChkY19j
dHgtPmRjLT5jdXJyZW50X3N0YXRlLT5zdHJlYW1zW2ldID09IE5VTEwpCj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+PiArCj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoZGNfY3R4
LT5kYy0+Y3VycmVudF9zdGF0ZS0+c3RyZWFtc1tpXS0+bGluayA9PSBsaW5rKSB7Cj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHN0cmVhbV9zdGF0ZSA9IGRjX2N0eC0+ZGMtPmN1cnJlbnRfc3Rh
dGUtPnN0cmVhbXNbaV07Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gbGlua19mb3Vu
ZDsKPj4gK8KgwqDCoMKgwqDCoMKgIH0KPj4gK8KgwqDCoCB9Cj4gCj4gV2Ugc2hvdWxkbid0IGJl
IHJlYWRpbmcgZnJvbSBkYy0+Y3VycmVudF9zdGF0ZSBkaXJlY3RseSBpbiBETSwgaXQncwo+IGVz
c2VudGlhbGx5IHByaXZhdGUgc3RhdGUuCj4gCj4gSSB0aGluayB3ZSBzaG91bGQgYWN0dWFsbHkg
aGF2ZSBhIG5ldyBoZWxwZXIgaGVyZSBpbiBkY19zdHJlYW0uaCB0aGF0J3MKPiBsaWtlOgo+IAo+
IHN0cnVjdCBkY19zdHJlYW1fc3RhdGUgKmRjX3N0cmVhbV9maW5kX2Zyb21fbGluayhjb25zdCBz
dHJ1Y3QgZGNfbGluawo+ICpsaW5rKTsKPiAKPiB0byByZXBsYWNlIHRoaXMgYmxvY2sgb2YgY29k
ZS4KPiAKPiBOb3RlIHRoYXQgYW55IHRpbWUgd2UgdG91Y2ggY3VycmVudF9zdGF0ZSB3ZSBhbHNv
IG5lZWQgdG8gYmUgbG9ja2luZyAtCj4gaXQgbG9va3MgbGlrZSB0aGlzIGZ1bmN0aW9uIGlzIG1p
c3NpbmcgdGhlIGFwcHJvcHJpYXRlIGNhbGxzIHRvOgo+IAo+IG11dGV4X2xvY2soJmFkZXYtPmRt
LmRjX2xvY2spOwo+IG11dGV4X3VubG9jaygmYWRldi0+ZG0uZGNfbG9jayk7Cj4gCj4gUmVnYXJk
cywKPiBOaWNob2xhcyBLYXpsYXVza2FzCj4gCj4gCgpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcu
IFNlbnQgYSB2MgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
