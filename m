Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F45C4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 21:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBDE661245
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 21:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBDE661245
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FE306E424;
	Mon, 21 Jun 2021 21:24:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC5346E424
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 21:24:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxT2uEwMlg8rq81W/dk4ExUD/r+P1QblU+M5je47C1IZn0pm5owcS9WtJlmAWxSqsNWjCMeBnEipSyba8d9uQqAJePYc1VaeAMW761F79pA+w2HtyW6FGfqyk0wwdwPtH4PqIpLG9+JjMJ1nsUCG1+2J824vxE6qSMaPLQsDVXTJzX6yHn3Cc1Y5KnWe89Kdk9bg/mexGuxnneq6F19Oc6UDi3MPtujrNny9j7QdE8Evn5pTFSE0cGoVF6nFPL15QFgZK2+YCndAP1Vi+VP+xiCqn6RdbsEkFH04IiiR7t00eT0IOpPHu5wGCGQPL9LtNU6vj6Jjm6tQ73GPxYPzVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF5CM8RF1+U/yFeSoN5LzNqrCcCLaoh/WzwWsh/ji4g=;
 b=V08N7b8+qVVjeAIUIuXjjrHQRXrL8ldPTq6br+gnMw24wNmyB4H0OkdIumZzbl9MZrgBRWZvov8UZ/uSiszfOy6Ce+EpL/0YMrxkA8UypbjopGsfjadwXCyma6VLF8r7zNsd0M4lsvRU13KX5C5ROitWKMQngr7hvQp26Xbg2WrBtRNHeFpnLbDX+LxOtnBGQrtZRcW3jlInUNUmTCwUMcCC68NG0GfpHdYvz99Z0ul7SQ0DpEdS1cbQINfPjI3jzCvdZKnQ/O+RRTOKqzUdELG5VapSMJybgy9k+B0p8mSpf0wjG+pSyMU7rtuVkc8sN54n9N1kBhJf4tIe0pDKvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF5CM8RF1+U/yFeSoN5LzNqrCcCLaoh/WzwWsh/ji4g=;
 b=Z0Qigppbf3l5OV40zcHhxL0SSFfeJKfjzQkZizc/UGZCVkymIJB4aOeo//1NNJmvXwEJgMK5red4wSP/EKRB08DLRQRo6qNnb5+LynIZKo6BRXn5Zq8QF7ApomQjpZylw/iMVuswzchSguYjGgbin5vyBfsGcpzAIJpfo45mtwA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5034.namprd12.prod.outlook.com (2603:10b6:408:104::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Mon, 21 Jun
 2021 21:24:15 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 21:24:15 +0000
Subject: Re: [PATCH 09/10] drm/amdkfd: partially actual_loc removed
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210621160423.3517-1-alex.sierra@amd.com>
 <20210621160423.3517-9-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <1087296f-bba6-48ee-33f2-95f39289be6c@amd.com>
Date: Mon, 21 Jun 2021 17:24:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210621160423.3517-9-alex.sierra@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::34) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YTOPR0101CA0057.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Mon, 21 Jun 2021 21:24:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 845a75b0-9661-4a1e-e38e-08d934faeb90
X-MS-TrafficTypeDiagnostic: BN9PR12MB5034:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5034D4B4D718CFCB71D7835C920A9@BN9PR12MB5034.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pjywP7WTxMplajgHlmipItRsG7DO/jLHvV3YgolmpYwRsMCd6cIEr8CZxfoY4hLr3vHkC/HnK3zdpk7bT/6N0fQteH9lZUxK5Mirlx1Avwpk6wNgAz0K+ArNTWzICorHoq20KJFujZoAVVGzZ5O1AvxHGwEcso0HUyp5rovAfuu/xaq5bLiElQTlTU0t37FC1BYkzbnfPaD6QRrRR1DdzhH2csFU8VHkLi/VV7LcSCtpkOacaQAEvWJj9/ncRgdfonmYHeM50GRFcvpsPHat3F2WJuc8oPujZcS4X16M72l662B4zHf6KcvcLHeuyrHN42uH672T82VzX7tqd4pSJO3dcxsOkG+aXOUh0glCUndjNgzagkXJ3MMsVlXr8r5nxw9Ypgv9+1jzqIAp38697fNpM5QpX6ppmOYarXrwM56qimxxacMei26b/fkoep0K+C0tvK1fiWN3vujn9ruOCuMuJBE+ZMTmfccGE80NmKxOvy8Tz5EE2hHDqESOuNUFVxr2rkBCuCyIR9e9AVpeuXvpB5IUk42wqKr9iwPS5dCAzVHKNoCROKBLuf0KmlnfGcoDVoynT0/Yrw9uK9Doc5GE/EN48hbAazTVAVPrl+m7L+rWkkU5l/lXZqpgzNiG485mYWyC9QdHwM+IRX6rssE5MFSwT20RxRExYSvLRZ/2UsWp7u4n20XGHI9IBj77
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(66556008)(26005)(66476007)(53546011)(66946007)(5660300002)(8936002)(36756003)(16526019)(2906002)(8676002)(956004)(2616005)(186003)(31696002)(31686004)(38100700002)(36916002)(316002)(16576012)(86362001)(6486002)(44832011)(478600001)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEx6WXQzeGF4c2o2aUdCMU5BZGg2VnplUnVxR2ljd3h3NzNYZHl6TUU0b0V2?=
 =?utf-8?B?VzY3QWlrSlhCRjhVak54c2RhOGxxZi9XUFVmVXJmZjNndjA5dVZ4VDZ5UVNs?=
 =?utf-8?B?aU8vWU5JZzhTZnF1blRHRm50M25aaGlac1o4M056YkVERzJKbkxzTGxaMENr?=
 =?utf-8?B?bmc0b2tXMkNrdnMzdWVjZmtVeGtnUWhtd2h1WktVMXdYU3JJTGtZZE5hQ2c2?=
 =?utf-8?B?eXJnRGRBbi91WnM3YTBQb3NQdEU5bSt2Tk9jdVliVjJMZEhDTmhzc3N0YlJi?=
 =?utf-8?B?cFlIeGxTTzBnQkFxR3Bnd3EwZzBBTnkzMDgyZWFSUlhEWU9uU1FzZDBuMVBh?=
 =?utf-8?B?UU5xS3dNbFIwOWxHL1RNWHFHVzlyT3E4QnhSTWFrRVNYYzFFa2t1ekdwbzd3?=
 =?utf-8?B?VDhmczNUVFNVVEpKcS9pUjBFaDVPcjFSc2M3NW5kVWJrNk5yY0Rob1JxK2k1?=
 =?utf-8?B?TnVkV3NCNm0vbUtxVW5FREZaWnRNQmtTT2puVi9CNVQrTW9jYUQ4eW5IVUdU?=
 =?utf-8?B?bHpTTFNZamZyakcvZzZVVTZKN0hjUnFGbG1zRlIzU3dYUmpiVW1XdXRKTEl5?=
 =?utf-8?B?aEFkRlBMMVcyQzFrbFRQT1lZcjdHYmloRyt0a1RyQlBsSWx4WmtjSTVEYXlK?=
 =?utf-8?B?aUVzVnZteStScDRITjZiVTNXeUtxak9iR2xYclF5M2tzU3FPenpWb1NydzFV?=
 =?utf-8?B?UDNDcFlRV2w1QTk1Qm1RK0J6Z0s0a21YeSt6YjhvRU1zWDZ3OU5zYXRucm9x?=
 =?utf-8?B?SGN2dVJDdFpMaGNaOVA3R2hrUnFzOVhlMnN5WWFuaEYwN2xyR0pxU1FxbGhI?=
 =?utf-8?B?YnhNZ1NSZkZ6YVVIdTE2Nm9laXRIUkVFdlA2TlI4RWJPOTBPa3Q3ZEM3TVFt?=
 =?utf-8?B?UXNENGhQU2RqQW1NTG9wSEpmWFlaL1oxUFpqREZaUmpybytRdEplQTl5ZUMr?=
 =?utf-8?B?aEtRNUtZbnNPZE1TOTVRNC9LMWRqbmtYVUNWLytWYnBsRkJ4K0FjczU4aU1U?=
 =?utf-8?B?a0VjV1lDQ2ZYYlFNbGpsQnlhNHFOazlCVmQ0YTEvRGhoZzNBanNWcHdrcFVi?=
 =?utf-8?B?NjVyalZYU2d5NHZndVRhQldlV1A1ODd3ckNjZzNkNUlCMUhnaW1rZ2JJTXE3?=
 =?utf-8?B?WmhpSTR6aGwza216dGlMV3lac1FMNk9UN3dBaFBqVFZoTXhtZy90aU1nU3Rh?=
 =?utf-8?B?R1RiTzVmakczQWYrLzhXMTdoZCt4SWZZZU9HSUxsN1FaNnJGVkcrMXFocjNW?=
 =?utf-8?B?REhkalRPb2xsdTN6ZjJWajdxOFBNVDdVL1FpREVsRitqbkQrQmZYbzdhaDRk?=
 =?utf-8?B?MXJUdzlYZXp2N3lIVlpObXg0emd5NEtvbVB3ZVo5QmN3czVmamM3QWFibVV0?=
 =?utf-8?B?ano4SStQQjJLcE1kRmVKWUorbXBhOHh1MWw5dnRtM2ZBQU1Tc0pFYzhmMVp2?=
 =?utf-8?B?NzVDZjVWdHQ1dEorQ3JTVlc3VjB1Uno5Y0lab0ZqUlFuSE1Jb0NOUHpza3Zi?=
 =?utf-8?B?U0VXa21RT2lHTU9nQzBXdWE3aElVQjdYWEd0N2hsOE5uQThXUXFmMmV5SS9V?=
 =?utf-8?B?dEdmb3lRQWZ5MXlpbnBhaHpqRjRNcC9iYjlSaVc5ZzZ4dktBVGY2Um1Eb3NQ?=
 =?utf-8?B?b1dZYXBiNUZhZzkvV0lkbXVVU0xrYUdObXRpZ3BRWnFxTFY0eUsvRGdKR0g5?=
 =?utf-8?B?S2tzd0ZKSi9NNklvVEUvbnU4VktRd0FCb0QrT3pFVCt2TEw3c0UwcEZzY2ln?=
 =?utf-8?Q?zt7x3jHtVk/19sHygJgf1Wo++nQMoPZhATKgGSx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 845a75b0-9661-4a1e-e38e-08d934faeb90
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 21:24:15.0475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E0ax7+ZiI86np3R6CEnwdxD7cKvlPNT3Y3o2L6ZWGnVvYWk00M6NS5Neow9E1xTimqTjDHEVPHeN2vNlLu+oww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5034
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

T24gMjAyMS0wNi0yMSAxMjowNCBwLm0uLCBBbGV4IFNpZXJyYSB3cm90ZToKPiBhY3R1YWxfbG9j
IHNob3VsZCBub3QgYmUgdXNlZCBhbnltb3JlLCBhcyBwcmFuZ2VzCj4gY291bGQgaGF2ZSBtaXhl
ZCBsb2NhdGlvbnMgKFZSQU0gJiBTWVNSQU0pIGF0IHRoZQo+IHNhbWUgdGltZS4KPgo+IFNpZ25l
ZC1vZmYtYnk6IEFsZXggU2llcnJhIDxhbGV4LnNpZXJyYUBhbWQuY29tPgo+IC0tLQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21pZ3JhdGUuYyB8IDEyICstLS0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uYyAgICAgfCA3MSArKysrKysrKysrLS0tLS0t
LS0tLS0tLS0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgNTQgZGVsZXRp
b25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21p
Z3JhdGUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9taWdyYXRlLmMKPiBpbmRl
eCBmNzFmOGQ3ZTJiNzIuLmFjYjlmNjQ1NzdhMCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfbWlncmF0ZS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX21pZ3JhdGUuYwo+IEBAIC01MDEsMTIgKzUwMSw2IEBAIHN2bV9taWdyYXRlX3Jh
bV90b192cmFtKHN0cnVjdCBzdm1fcmFuZ2UgKnByYW5nZSwgdWludDMyX3QgYmVzdF9sb2MsCj4g
ICAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXY7Cj4gICAJaW50IHIgPSAwOwo+ICAgCj4gLQlp
ZiAocHJhbmdlLT5hY3R1YWxfbG9jID09IGJlc3RfbG9jKSB7Cj4gLQkJcHJfZGVidWcoInN2bXMg
MHglcCBbMHglbHggMHglbHhdIGFscmVhZHkgb24gYmVzdF9sb2MgMHgleFxuIiwKPiAtCQkJIHBy
YW5nZS0+c3ZtcywgcHJhbmdlLT5zdGFydCwgcHJhbmdlLT5sYXN0LCBiZXN0X2xvYyk7Cj4gLQkJ
cmV0dXJuIDA7Cj4gLQl9Cj4gLQo+ICAgCWFkZXYgPSBzdm1fcmFuZ2VfZ2V0X2FkZXZfYnlfaWQo
cHJhbmdlLCBiZXN0X2xvYyk7Cj4gICAJaWYgKCFhZGV2KSB7Cj4gICAJCXByX2RlYnVnKCJmYWls
ZWQgdG8gZ2V0IGRldmljZSBieSBpZCAweCV4XG4iLCBiZXN0X2xvYyk7Cj4gQEAgLTc5MSwxMSAr
Nzg1LDcgQEAgaW50Cj4gICBzdm1fbWlncmF0ZV90b192cmFtKHN0cnVjdCBzdm1fcmFuZ2UgKnBy
YW5nZSwgdWludDMyX3QgYmVzdF9sb2MsCj4gICAJCSAgICBzdHJ1Y3QgbW1fc3RydWN0ICptbSkK
PiAgIHsKPiAtCWlmICAoIXByYW5nZS0+YWN0dWFsX2xvYykKPiAtCQlyZXR1cm4gc3ZtX21pZ3Jh
dGVfcmFtX3RvX3ZyYW0ocHJhbmdlLCBiZXN0X2xvYywgbW0pOwo+IC0JZWxzZQo+IC0JCXJldHVy
biBzdm1fbWlncmF0ZV92cmFtX3RvX3ZyYW0ocHJhbmdlLCBiZXN0X2xvYywgbW0pOwo+IC0KPiAr
CXJldHVybiBzdm1fbWlncmF0ZV9yYW1fdG9fdnJhbShwcmFuZ2UsIGJlc3RfbG9jLCBtbSk7CgpD
YW4geW91IHJlbW92ZSBzdm1fbWlncmF0ZV92cmFtX3RvX3ZyYW0gaW4gdGhpcyBjYXNlPyBJIGd1
ZXNzIHdlJ3JlIApyZWx5aW5nIG9uIHRoZSBzdm1fcmFuZ2VfcHJlZmF1bHQgY2FsbCBpbiBzdm1f
bWlncmF0ZV9yYW1fdG9fdnJhbSBub3cgdG8gCm1pZ3JhdGUgVlJBTSBpbiBhIGRpZmZlcmVudCBY
R01JIGhpdmUgdG8gc3lzdGVtIG1lbW9yeSBub3cuIEJ1dCAKZXZlbnR1YWxseSB3ZSB3YW50IHRv
IGdldCByaWQgb2YgdGhhdCBwcmUtZmF1bHQgaGFjay4KCgo+ICAgfQo+ICAgCj4gICAvKioKPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5jCj4gaW5kZXggM2IwNWJjMjcwNzMyLi5lYmMx
YWU3ZTUxOTMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2
bS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5jCj4gQEAgLTE0
MjEsNDIgKzE0MjEsMzggQEAgc3RhdGljIGludCBzdm1fcmFuZ2VfdmFsaWRhdGVfYW5kX21hcChz
dHJ1Y3QgbW1fc3RydWN0ICptbSwKPiAgIAo+ICAgCXN2bV9yYW5nZV9yZXNlcnZlX2JvcygmY3R4
KTsKPiAgIAo+IC0JaWYgKCFwcmFuZ2UtPmFjdHVhbF9sb2MpIHsKPiAtCQlwID0gY29udGFpbmVy
X29mKHByYW5nZS0+c3Ztcywgc3RydWN0IGtmZF9wcm9jZXNzLCBzdm1zKTsKPiAtCQlvd25lciA9
IGtmZF9zdm1fcGFnZV9vd25lcihwLCBmaW5kX2ZpcnN0X2JpdChjdHguYml0bWFwLAo+IC0JCQkJ
CQkJTUFYX0dQVV9JTlNUQU5DRSkpOwo+IC0JCWZvcl9lYWNoX3NldF9iaXQoaWR4LCBjdHguYml0
bWFwLCBNQVhfR1BVX0lOU1RBTkNFKSB7Cj4gLQkJCWlmIChrZmRfc3ZtX3BhZ2Vfb3duZXIocCwg
aWR4KSAhPSBvd25lcikgewo+IC0JCQkJb3duZXIgPSBOVUxMOwo+IC0JCQkJYnJlYWs7Cj4gLQkJ
CX0KPiAtCQl9Cj4gLQkJciA9IGFtZGdwdV9obW1fcmFuZ2VfZ2V0X3BhZ2VzKCZwcmFuZ2UtPm5v
dGlmaWVyLCBtbSwgTlVMTCwKPiAtCQkJCQkgICAgICAgcHJhbmdlLT5zdGFydCA8PCBQQUdFX1NI
SUZULAo+IC0JCQkJCSAgICAgICBwcmFuZ2UtPm5wYWdlcywgJmhtbV9yYW5nZSwKPiAtCQkJCQkg
ICAgICAgZmFsc2UsIHRydWUsIG93bmVyKTsKPiAtCQlpZiAocikgewo+IC0JCQlwcl9kZWJ1Zygi
ZmFpbGVkICVkIHRvIGdldCBzdm0gcmFuZ2UgcGFnZXNcbiIsIHIpOwo+IC0JCQlnb3RvIHVucmVz
ZXJ2ZV9vdXQ7Cj4gLQkJfQo+IC0KPiAtCQlyID0gc3ZtX3JhbmdlX2RtYV9tYXAocHJhbmdlLCBj
dHguYml0bWFwLAo+IC0JCQkJICAgICAgaG1tX3JhbmdlLT5obW1fcGZucyk7Cj4gLQkJaWYgKHIp
IHsKPiAtCQkJcHJfZGVidWcoImZhaWxlZCAlZCB0byBkbWEgbWFwIHJhbmdlXG4iLCByKTsKPiAt
CQkJZ290byB1bnJlc2VydmVfb3V0Owo+ICsJcCA9IGNvbnRhaW5lcl9vZihwcmFuZ2UtPnN2bXMs
IHN0cnVjdCBrZmRfcHJvY2Vzcywgc3Ztcyk7Cj4gKwlvd25lciA9IGtmZF9zdm1fcGFnZV9vd25l
cihwLCBmaW5kX2ZpcnN0X2JpdChjdHguYml0bWFwLAo+ICsJCQkJCQlNQVhfR1BVX0lOU1RBTkNF
KSk7Cj4gKwlmb3JfZWFjaF9zZXRfYml0KGlkeCwgY3R4LmJpdG1hcCwgTUFYX0dQVV9JTlNUQU5D
RSkgewo+ICsJCWlmIChrZmRfc3ZtX3BhZ2Vfb3duZXIocCwgaWR4KSAhPSBvd25lcikgewo+ICsJ
CQlvd25lciA9IE5VTEw7Cj4gKwkJCWJyZWFrOwo+ICAgCQl9Cj4gKwl9Cj4gKwlyID0gYW1kZ3B1
X2htbV9yYW5nZV9nZXRfcGFnZXMoJnByYW5nZS0+bm90aWZpZXIsIG1tLCBOVUxMLAo+ICsJCQkJ
ICAgICAgIHByYW5nZS0+c3RhcnQgPDwgUEFHRV9TSElGVCwKPiArCQkJCSAgICAgICBwcmFuZ2Ut
Pm5wYWdlcywgJmhtbV9yYW5nZSwKPiArCQkJCSAgICAgICBmYWxzZSwgdHJ1ZSwgb3duZXIpOwo+
ICsJaWYgKHIpIHsKPiArCQlwcl9kZWJ1ZygiZmFpbGVkICVkIHRvIGdldCBzdm0gcmFuZ2UgcGFn
ZXNcbiIsIHIpOwo+ICsJCWdvdG8gdW5yZXNlcnZlX291dDsKPiArCX0KPiAgIAo+IC0JCXByYW5n
ZS0+dmFsaWRhdGVkX29uY2UgPSB0cnVlOwo+ICsJciA9IHN2bV9yYW5nZV9kbWFfbWFwKHByYW5n
ZSwgY3R4LmJpdG1hcCwKPiArCQkJICAgICAgaG1tX3JhbmdlLT5obW1fcGZucyk7Cj4gKwlpZiAo
cikgewo+ICsJCXByX2RlYnVnKCJmYWlsZWQgJWQgdG8gZG1hIG1hcCByYW5nZVxuIiwgcik7Cj4g
KwkJZ290byB1bnJlc2VydmVfb3V0Owo+ICAgCX0KPiAgIAo+ICsJcHJhbmdlLT52YWxpZGF0ZWRf
b25jZSA9IHRydWU7Cj4gKwo+ICAgCXN2bV9yYW5nZV9sb2NrKHByYW5nZSk7Cj4gLQlpZiAoIXBy
YW5nZS0+YWN0dWFsX2xvYykgewo+IC0JCWlmIChhbWRncHVfaG1tX3JhbmdlX2dldF9wYWdlc19k
b25lKGhtbV9yYW5nZSkpIHsKPiAtCQkJcHJfZGVidWcoImhtbSB1cGRhdGUgdGhlIHJhbmdlLCBu
ZWVkIHZhbGlkYXRlIGFnYWluXG4iKTsKPiAtCQkJciA9IC1FQUdBSU47Cj4gLQkJCWdvdG8gdW5s
b2NrX291dDsKPiAtCQl9Cj4gKwlpZiAoYW1kZ3B1X2htbV9yYW5nZV9nZXRfcGFnZXNfZG9uZSho
bW1fcmFuZ2UpKSB7Cj4gKwkJcHJfZGVidWcoImhtbSB1cGRhdGUgdGhlIHJhbmdlLCBuZWVkIHZh
bGlkYXRlIGFnYWluXG4iKTsKPiArCQlyID0gLUVBR0FJTjsKPiArCQlnb3RvIHVubG9ja19vdXQ7
CgpJTU8sIHRoaXMgaXMgdGhlIG1vc3QgaW1wb3J0YW50IHBhcnQgb2YgdGhpcyBjb21taXQsIGFu
ZCBpdCBzaG91bGQgYmUgCmNhbGxlZCBvdXQgdGhlIHRoZSBwYXRoIGRlc2NyaXB0aW9uLiBIZXJl
IHdlIHVzZSBobW1fcmFuZ2VfZmF1bHQgZm9yIApnZXR0aW5nIFZSQU0gYWRkcmVzc2VzLiBUaGlz
IGlzIHdoYXQgZW5hYmxlcyBtaXhlZCBtYXBwaW5ncyBpbiB0aGUgZmlyc3QgCnBsYWNlLgoKUmVn
YXJkcywKIMKgwqAgRmVsaXgKCgo+ICAgCX0KPiAgIAlpZiAoIWxpc3RfZW1wdHkoJnByYW5nZS0+
Y2hpbGRfbGlzdCkpIHsKPiAgIAkJcHJfZGVidWcoInJhbmdlIHNwbGl0IGJ5IHVubWFwIGluIHBh
cmFsbGVsLCB2YWxpZGF0ZSBhZ2FpblxuIik7Cj4gQEAgLTI3NDEsMjAgKzI3MzcsOSBAQCBzdm1f
cmFuZ2VfdHJpZ2dlcl9taWdyYXRpb24oc3RydWN0IG1tX3N0cnVjdCAqbW0sIHN0cnVjdCBzdm1f
cmFuZ2UgKnByYW5nZSwKPiAgIAkqbWlncmF0ZWQgPSBmYWxzZTsKPiAgIAliZXN0X2xvYyA9IHN2
bV9yYW5nZV9iZXN0X3ByZWZldGNoX2xvY2F0aW9uKHByYW5nZSk7Cj4gICAKPiAtCWlmIChiZXN0
X2xvYyA9PSBLRkRfSU9DVExfU1ZNX0xPQ0FUSU9OX1VOREVGSU5FRCB8fAo+IC0JICAgIGJlc3Rf
bG9jID09IHByYW5nZS0+YWN0dWFsX2xvYykKPiArCWlmIChiZXN0X2xvYyA9PSBLRkRfSU9DVExf
U1ZNX0xPQ0FUSU9OX1VOREVGSU5FRCkKPiAgIAkJcmV0dXJuIDA7Cj4gICAKPiAtCS8qCj4gLQkg
KiBQcmVmZXRjaCB0byBHUFUgd2l0aG91dCBob3N0IGFjY2VzcyBmbGFnLCBzZXQgYWN0dWFsX2xv
YyB0byBncHUsIHRoZW4KPiAtCSAqIHZhbGlkYXRlIG9uIGdwdSBhbmQgbWFwIHRvIGdwdXMgd2ls
bCBiZSBoYW5kbGVkIGFmdGVyd2FyZHMuCj4gLQkgKi8KPiAtCWlmIChiZXN0X2xvYyAmJiAhcHJh
bmdlLT5hY3R1YWxfbG9jICYmCj4gLQkgICAgIShwcmFuZ2UtPmZsYWdzICYgS0ZEX0lPQ1RMX1NW
TV9GTEFHX0hPU1RfQUNDRVNTKSkgewo+IC0JCXByYW5nZS0+YWN0dWFsX2xvYyA9IGJlc3RfbG9j
Owo+IC0JCXJldHVybiAwOwo+IC0JfQo+IC0KPiAgIAlpZiAoIWJlc3RfbG9jKSB7Cj4gICAJCXIg
PSBzdm1fbWlncmF0ZV92cmFtX3RvX3JhbShwcmFuZ2UsIG1tKTsKPiAgIAkJKm1pZ3JhdGVkID0g
IXI7Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
