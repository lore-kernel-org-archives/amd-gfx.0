Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9831C47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 09:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE04F60FDA
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 09:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE04F60FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6109F89144;
	Tue,  8 Jun 2021 09:58:22 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2042.outbound.protection.outlook.com [40.107.100.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81B446EB9E
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 09:58:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXMuH7cEyGYmClrDOc3p7m638Hgfj+baSgGG5lXhdlBzEi7sy/rnV13F+7ASVdizvxKx2YvJzYZZ2SnYWuywvVsBJkJP/gv7R6fTUFlzpQUD2Xy26CEjDt8CPdBtbtHKBIlOxrDFuUAcsWUDzR1MJg7brezA0CFtXAkQLVouvQGHU6n37n19GTw5AdiJhWpfiP6veNkaadY80ccpbE3mHl2w2Qk3/kf9Ah+zp9Siz6SGPugs1n+Gfuoac0rPxojjhek5TwrSDm2zMXAPmSCeibBhOXWkQCvY+qLJgK6cT955cxz0pUmVw5ZXqQq8vGk4eIc5/WdAi1qoSywkDTjEFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmPX7wL/i6dkfsMvN3IiIl4p0xNMFo4LUjWzHfR6834=;
 b=aS03cFZ3pAxgFbbByhAHqfIgKsaQc8cJRgO2+SiQpj6KGtFQswPOAJrG/8OZZX1Q5aHm+ur6ulJqoaHWpybDKIYpBoMW889HGHzqGTOYmO7wd+QyY5hk+cCFKw8pQswsFOzhE27tDjjLndv5cNvR49Jcq5zuVg7KtWYYCv56IDk0OTyV+SmS7g6JCnDUiEyuOwBlGCN968uvJ/HggIRBw9w8+zegov+rQi0HuQ7qgN16x7DKtQTG3wbRVkbtIrPx7V6IK7qyzLC9W4mj5bbNY+0i5UWMg5ny211yrnnMnSKaXG4jmeOcJUakXrm7/gtsHCToeIzovxyBY0fYnY58iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmPX7wL/i6dkfsMvN3IiIl4p0xNMFo4LUjWzHfR6834=;
 b=qs/VgIGnFSkkoZ3I0sHoc3ZMFI5/Za80OmPHaNy6CIMgzoDmE0z/XHokLucs3EVfQ2SO1PVpGG8nu1PCU+7opFZBZj9+/o4ThMu1FiMcj7DFTovPXBawcDk2thhqTADFGBn9iEW/SRMNUoqVxltZm33Wclt36Aizf+uWqVqCHJQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21; Tue, 8 Jun 2021 09:58:19 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.037; Tue, 8 Jun 2021
 09:58:19 +0000
Subject: Re: [PATCH 1/1] drm/amdkfd: use allowed domain for vmbo validation
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210608093213.8269-1-nirmoy.das@amd.com>
 <63f66fd0-7162-ea31-41e3-1f145d8a6ddd@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <192dab49-1a3b-5874-2f41-995073c0706a@amd.com>
Date: Tue, 8 Jun 2021 11:58:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <63f66fd0-7162-ea31-41e3-1f145d8a6ddd@amd.com>
Content-Language: en-US
X-Originating-IP: [2003:c5:8f2b:6400:c449:165a:413d:7e84]
X-ClientProxiedBy: AM0PR10CA0077.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::30) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2b:6400:c449:165a:413d:7e84]
 (2003:c5:8f2b:6400:c449:165a:413d:7e84) by
 AM0PR10CA0077.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 09:58:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bff994f-4c26-4cd9-56bc-08d92a63f1a7
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5445FFB46323D24DD7FAEB1B8B379@DM8PR12MB5445.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8A+0HLR/j1JJ3OgiaU5E6uMv7xOAaWBSj/K2U4zrvwpkoYCRm2u4lnUdEKOLV/o7MonfPpXgRyLPIlrfbKF2OKmGKSbW9j4wGdCs7Fulotgc1T79l3L8rEkmKMloGFQenM5aTIVXGa0AeUeaZDDXqzmGqihnCFhRbK1Xl75wv+bRnlIyyvk5JbbGOE2xakbvzol8Nsn0knETNkHlGqiD5ZBxvlOcka4mvoY/zFYgVtlKmP1Sv9mIZ0VSD4UbVrB09YAXFa0jMXkvQfCzdxAh05QNVFeteHiksNPR1NHhBPFB3EUuG/i++KbNVunFkxClm9erCnORCILzAG65vktjMfdfMdNHUQTsQqaQ2gj0HmQTnXrANcMR2aH868XulNP2N9c0iMCNCL70fwi1aHrLkgAqAbzXhHAe2nw6WJ8USv0/KjuIh70n+0LcWvqYh5WV/8k9dNt4uGQCFcX2I7s68/ORKeOEZSHViwAJvhPPg/sHmpARblLeTyHrRe6VPDdFR97ljNVMQrCQC+o9BSnCeO+xbIJ9rKnwORlScnAmBWxopnE7ooOZ2zBI4PWo4YmvJP26lH70VlbQx0OKWKlIHr88QJzlS+sycUq2DmHqr3FOU+MS0Dcbvu2vsrWEGm08w1kotKsTq9PYOXgenbbM1lOU+hQr5pGg45cjQnh4kQXUCJlyqxijMhMfCK4JbPV8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(8676002)(53546011)(2906002)(316002)(4326008)(31696002)(52116002)(86362001)(31686004)(5660300002)(478600001)(6666004)(66476007)(66946007)(66556008)(66574015)(36756003)(6486002)(2616005)(83380400001)(16526019)(38100700002)(8936002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SC9mUkswL28rN3oybnhGUldDSmNBN01jLzZtTzB5eldrMGhyaWNFM1l3NG90?=
 =?utf-8?B?OEF2V1k0TmVGeCtqelJZOERYWnRtc0w2L21TeElxWWNCMG44am83ZmQ1OGR1?=
 =?utf-8?B?UnArR3M4SWg3WUdWRExRMGNmUzdUb3k2VGV2WWpjdmRXK1lad1V4ZG9NejVK?=
 =?utf-8?B?QS9sTkNsMUNEelg3QkM5UGFYbjJueHMraHpwZ2pZeW1WbmtVOEZER1VVVGx0?=
 =?utf-8?B?WGM1b3FHVnlMbG9pRE9neHlKYkJLd3daT2RUajJyZG9peEZzM3AzL1FscnJJ?=
 =?utf-8?B?NXU4Q09MbHFpM0dpL1R6bXE2YU5QTlU2dU83eFhoYWlyUW1CeXRlMnRDWjFJ?=
 =?utf-8?B?ZmFNWXIzYmN1ekFKdWpJWmVjNVgvSFFpeXhwUStKYktDV08ybHZZVUlBVjc5?=
 =?utf-8?B?bWNRekE2ZjBIVW5Xa3E0RTVjRXJnVjAyMTlBRE5OQkRuQ0Q1dTdaZy9GY3p1?=
 =?utf-8?B?SVYwb1BsTTlaYURHdHJZdFo2OFltdDZUVlErWGJEemJtZXU1dEcxRkxIN2FM?=
 =?utf-8?B?dUJ1UWZldUwzdE8wYlo3NFRoWHNuVXVMVEw3RnBqRmNLakp4SUJyQjVVdFhQ?=
 =?utf-8?B?VmZGR2ZXV2NYN3NJTXV6TCtNMTgxSmxlTVJpeCtaQUhsYlh1NUp6c0diTUdT?=
 =?utf-8?B?TE5yR1FxcUlmMG9rQ21JbkMyM2tDbFFrOEVqZGtTaEdld25EMW02WmxkUHpq?=
 =?utf-8?B?d0JNLytKRlR4cGxIRzlkMnJwblNlVDRCN1YvK1VKak84NnE4ZE1DWDRwTDZE?=
 =?utf-8?B?RU81QzFNMW5BZDVOZnEvK3J5WWt4bktrZUFGTysxa2pVczAxdlJTaUJiRndF?=
 =?utf-8?B?WVkyV1NjejkveWh4REtxYkd0clVJUmwxbnNXcUVZRm9nNEhRd0NUMU9weGR6?=
 =?utf-8?B?SDMvei9xdEg0VnA4ZEdObWp4MVRrTUZCM01uYlJUSC9KbldzOFh1NGE1KzVL?=
 =?utf-8?B?bWhIN3phQkdYL2NXWjJpUk80VCs1Q1p1UGdBK0tzSTZQWGlkUXpSTVF5OVo0?=
 =?utf-8?B?bDRuQkxXUXBKUzNmZTlMb1VBQit2cmdEeVJaMUtjNENJS2ZFQ3ZuV1phVkxq?=
 =?utf-8?B?ekoxaU5kVVVHOEJCZ0dWWXZsZkhBSG5mb2ZTYi9hbVhwaXBkN0xhbFMrRVl3?=
 =?utf-8?B?RFFzVjRtWEs1OEhDMHlpSzdROG9BOUpvVksvbEFXR2hBRU9MVG9VVzBzZ1ZD?=
 =?utf-8?B?WUVPY3FNTVExQTJURWZ2aW05d29nMEExTTFReDk2dmJ6Q2lpcnFLOXd3M0Nk?=
 =?utf-8?B?LzYxZ2VUZ1NQTEV0elpjdXZCWWdMNzdFNGdTdG5Pcmk1d2szL3JpQlRBVVRp?=
 =?utf-8?B?Szh5S1dKTDJnWCtvVnc1VUNKZzBPZFZmUm9RZlN0SlRxcXYvdFBjY3gveXJn?=
 =?utf-8?B?YzljejJERnZLS3Q4RmUvZmxCYVBteStuMWUyQmVzOFNUYnR2dWNOa2ZZZ1Az?=
 =?utf-8?B?NVJ0OTRHT2l3bzdERm5xM3RGSGhqcXF4U1RjbzNEMW5McWJQV283RDRLaU5G?=
 =?utf-8?B?RGc2ckNUb1VIcFlibmJpelpON0pKMDc1YWNGZzJXWCsrYnBDRmVTazdiUGhG?=
 =?utf-8?B?R05Kd3YwN3c1THFNbEdSSGUra05OcU9FU2pFazRJUG1BSXVGbTc1b21ZWGFO?=
 =?utf-8?B?NjREVEUzWG5tcFF0SGJCZ21wVjJXL2ZTZ1lKcFpLZU4rblhid1NOc3V4Kzh5?=
 =?utf-8?B?WHY0ZUg0em9kQVJhU3NYZ3hCT0JkcWhOMEF1OUlRMjJQbkU5VkRQYWszazNo?=
 =?utf-8?B?V1l4MnAya29VQ1pTMnpZVTg3T3R4WGx3dWkrQjVLckVra2U5Z1NpY2Z2Q2w0?=
 =?utf-8?B?Mm9uNW40OExTM2ZrUnJhcyt6WjgzSXVFT09wcXE3NllndkxMM2YvblBKVW51?=
 =?utf-8?Q?FZRIZz0FyCn6D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bff994f-4c26-4cd9-56bc-08d92a63f1a7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 09:58:19.5165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAbmFhDVhFbExlW9rJpUkTqV5rZMlkiejPSxzv1yB+w+WOaCw5qYsB6OzkDJYXdFD05LnEFzkpwSIMw4EutjMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5445
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
Cc: Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDYvOC8yMDIxIDExOjM3IEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDA4LjA2
LjIxIHVtIDExOjMyIHNjaHJpZWIgTmlybW95IERhczoKPj4gUmVtb3ZlIGZpeGVkIGRvbWFpbiBh
bmQgdXNlIEJPJ3MgYWxsb3dlZCBkb21haW4gZm9yIFBUL1BECj4+IEJPIHZhbGlkYXRpb24uCj4K
PiAiRml4ZXMgaGFuZGxpbmcgd2hlbiBwYWdlIHRhYmxlcyBhcmUgaW4gc3lzdGVtIG1lbW9yeSIu
Cj4KPiBBbmQgSSB0aGluayB5b3UgY2FuIG5vdyByZW1vdmUgdGhlIHZhbGlkYXRlIHN0cnVjdHVy
ZSBhcyB3ZWxsLgoKCkRvIHlvdSBtZWFuICIgc3RydWN0IGFtZGdwdV92bV9wYXJzZXIgcGFyYW07
ICIgPwoKClRoYW5rcywKCk5pcm1veQoKPgo+IENocmlzdGlhbi4KPgo+Pgo+PiBTaWduZWQtb2Zm
LWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMgfCAzICstLQo+PiDCoCAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMg
Cj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4+
IGluZGV4IGQ2Y2I3Y2Y3NjYyMy4uYTQ1ZWFkZmJmNDE3IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMKPj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4+IEBAIC0zMzYsNyAr
MzM2LDcgQEAgc3RhdGljIGludCBhbWRncHVfYW1ka2ZkX2JvX3ZhbGlkYXRlKHN0cnVjdCAKPj4g
YW1kZ3B1X2JvICpibywgdWludDMyX3QgZG9tYWluLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAi
Q2FsbGVkIHdpdGggdXNlcnB0ciBCTyIpKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1F
SU5WQUw7Cj4+IMKgIC3CoMKgwqAgYW1kZ3B1X2JvX3BsYWNlbWVudF9mcm9tX2RvbWFpbihibywg
ZG9tYWluKTsKPj4gK8KgwqDCoCBhbWRncHVfYm9fcGxhY2VtZW50X2Zyb21fZG9tYWluKGJvLCBi
by0+YWxsb3dlZF9kb21haW5zKTsKPj4gwqAgwqDCoMKgwqDCoCByZXQgPSB0dG1fYm9fdmFsaWRh
dGUoJmJvLT50Ym8sICZiby0+cGxhY2VtZW50LCAmY3R4KTsKPj4gwqDCoMKgwqDCoCBpZiAocmV0
KQo+PiBAQCAtMzY5LDcgKzM2OSw2IEBAIHN0YXRpYyBpbnQgdm1fdmFsaWRhdGVfcHRfcGRfYm9z
KHN0cnVjdCBhbWRncHVfdm0gCj4+ICp2bSkKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X3Zt
X3BhcnNlciBwYXJhbTsKPj4gwqDCoMKgwqDCoCBpbnQgcmV0Owo+PiDCoCAtwqDCoMKgIHBhcmFt
LmRvbWFpbiA9IEFNREdQVV9HRU1fRE9NQUlOX1ZSQU07Cj4+IMKgwqDCoMKgwqAgcGFyYW0ud2Fp
dCA9IGZhbHNlOwo+PiDCoCDCoMKgwqDCoMKgIHJldCA9IGFtZGdwdV92bV92YWxpZGF0ZV9wdF9i
b3MoYWRldiwgdm0sIAo+PiBhbWRncHVfYW1ka2ZkX3ZhbGlkYXRlLAo+Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
