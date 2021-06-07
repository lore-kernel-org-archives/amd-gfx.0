Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C088C47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 19:42:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E61D9610E7
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 19:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E61D9610E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A78F66E9E5;
	Mon,  7 Jun 2021 19:42:05 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2086.outbound.protection.outlook.com [40.107.101.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C909A6E9E5
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 19:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYOVgEeprUROYYQmqz5lGKJFPS3F9rMHdVL+wDQ67FEojugGlT4qUYDgi/hfayKL5WNs7nygeOo2/ob+nb42I+Bijir58VUP3HvHXhw1Zr1uJ63peSPuVHZ4G/x3g5DDd949632HlZ5KIeAgInjPmnIz0kmIH6tvyqo6G0bAt2rvvSlKXHc+U1oDBY6m6pAnj1P+C2xIOKAkcZZjhbUqzrSFNu749hBKa9VyAUUrERLP28i3F3I1ZwEff9a/Il4NnygJqrhdBQ7uMRmy0icw+I153YSNLSJXrmdzQCFgnCKHonYby40ioIwPDzjx2h0RPweSMTZNAe3rtnFfiM6z2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Tjyn8yFi+MxrgF/tGfFt3nwX4qGi+WB+Qi372zBvsA=;
 b=N4nIPcfZKeBqPrL9Q0tsdYxXg9BE8f+lJP+/UPgoSMVxQ8BGbKBgXp+u7Dq0g/S7jVsLWOaRNbUaCb874AbJl82c1LQWOxqU9LCljwNSbTMWuo59ER4sWwg71bk6/+gBLr+9Ev95pGrIxzoPuCbhXHaYoBQkAt/dllwTr5Z0kptWAJIHgcXa8dMTpoGRpzueB9RBTkEqGrl2aP3F4A3Ow6EXntNFmlkEnIK9cagG1INe+71tMOBiGvyKZNUp5lj8VNVvS+7Mc5+TcBxc7T9sw/j1J42YzG6vBA5IbqM2uQPE6zg17BHUZyp3M463APFNj/xyw1x1VlbOuQR5ocjRcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Tjyn8yFi+MxrgF/tGfFt3nwX4qGi+WB+Qi372zBvsA=;
 b=Mn/bGw1fs44Zi5xg3sQR+RvVCbLDCu030z52lhlLN1mgrvsVaqMetzqCe+PghSBMCYmvnsdjc/HMrrEvBTzcNyzaZW3/LUtPei/1eKtXFKJ/vkZcha0Nk/3GTzLjKU+5VejFsKO1o1uBmU3dukZFrVtGI5DaUF4kV7YCmRaugOA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4899.namprd12.prod.outlook.com (2603:10b6:208:1cf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Mon, 7 Jun
 2021 19:42:02 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 19:42:02 +0000
Subject: Re: [PATCH] drm/amdgpu: Use PSP to program IH_RB_CNTL_RING1/2 on SRIOV
To: Rohit Khaire <rohit.khaire@amd.com>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Emily Deng <Emily.Deng@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Peng Ju Zhou <PengJu.Zhou@amd.com>,
 Horace Chen <Horace.Chen@amd.com>
References: <9c5b5cc7-4abc-9805-7da9-88abb9890fc6@gmail.com>
 <20210607193929.24239-1-rohit.khaire@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <9a2f4e4d-8f5e-e3db-9d90-73fe3f46c2ae@amd.com>
Date: Mon, 7 Jun 2021 21:41:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210607193929.24239-1-rohit.khaire@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:9451:3bc0:8c2c:c09b]
X-ClientProxiedBy: AM4PR0202CA0004.eurprd02.prod.outlook.com
 (2603:10a6:200:89::14) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:9451:3bc0:8c2c:c09b]
 (2a02:908:1252:fb60:9451:3bc0:8c2c:c09b) by
 AM4PR0202CA0004.eurprd02.prod.outlook.com (2603:10a6:200:89::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23 via Frontend
 Transport; Mon, 7 Jun 2021 19:42:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24cc1b85-82d4-40f1-528e-08d929ec524a
X-MS-TrafficTypeDiagnostic: BL0PR12MB4899:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4899268710EE33DDCC138D1383389@BL0PR12MB4899.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fU6FVwGph9FEapSTg6O+6QVoCKlioXX0OE/v+oea3TuK61R2VZ7eyMv1FRi/l8LijEpp6XBXEJ2v4k7Yy1i2DlfjPUHdAy+ctBuvv8TaHqHqEJRcDkxSN8ccY/5esuAwG0Kwwxo9DPLmAVStP3W6siRZK8FPsGr+oFx3s8UgN4YSu7JE5LP+6w0WhkMkStxX7p4Myjhrg4W/Z+YvCDfzc+QAYV0g3NCiFUuBE9iRlzLvCf/lQB9dI7OJAVaaXjshR9bclvkEBC7/ukqhmZTA8WQwjHQrkPsB/Hw3l1sJckHfDebrLSp5VT4tiYFOCtzY3o+MQD8uNTwqCdpJDH/JlTsFao9eGJFpdsml9rnTgXp0h3oaOrfzd5gppPcCGNFABgfGy9j7siVmcpUnNgGroXlwkZpcbqnMqneT81rlQDxyTPwBINwCmAK5B1caW/HcWpD7OI+tFzc3ngb7sesCNoLiSpHeaYsSGzlSoeGFOMqcLu+XxRMF6G35LFlWP3PBNViLvdnodaZ55A2F3gGHm40xJ1SAtOrdLb6FBVsSHGrQlwzNKjRTx71akE556AeqUmAQWLMpv4CHgfBaVhXI0eMGAuY4x2c4BefFnsdn4P0Mf/lpFcw+dTrloVg2Ye2MRoBbeAhfYOXmb42yUddf/PbFbusHrG8vXlGSmce5joCLSj80PnBDxj8BmgYR3+Tp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(38100700002)(66946007)(110136005)(66476007)(4326008)(5660300002)(186003)(16526019)(2906002)(66556008)(8936002)(478600001)(86362001)(6636002)(36756003)(31686004)(316002)(6486002)(66574015)(31696002)(83380400001)(6666004)(8676002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?U1VCSHlxbEJoeXNVcVlRa1RucFhObmNlOXZIbzh2RG8vdUhzc1NqUk4wU0tO?=
 =?utf-8?B?RVplZkZIRThXTVA2OWxzNERVdWJvdVE1ellyR01qM1dtQVY0RzMvdTgwVWlw?=
 =?utf-8?B?U3puMFF5REJLN043Q3BlMWJWbVBlRHNCdlozb3lVeDFFcTN1QzNvS3NyUGRH?=
 =?utf-8?B?ZEJzMlVlQUQ2RWlCU2swMXpTOS91b0RMWWZzT09zWmg0amIvS2orVXJoUTZP?=
 =?utf-8?B?WC9OMXJxR2UzazRpNFhxRzlxdWhWdC9oaFJOczRBTW14Y0wvcHAwcHBhNS9T?=
 =?utf-8?B?SWlwSkJFUnlqRkNIN2pwcTJreGhNUDlZR3Y1UGFDZkR6Q1djZ3ljY1g1MllV?=
 =?utf-8?B?c3hOMEx0TjZta1NQRElFMnJ2WVRQcE0wVVBsOXAyeTFidHpNSnZ5Nkc0SFZk?=
 =?utf-8?B?bG5oNkgyUDgvS0FKQ3IxT0FVUWNUc1Nmb1JwR04wT0RnMDZYNG1jcHo5Q1RD?=
 =?utf-8?B?dTZmRjFEU1VmNjdRS2VGNHZNcjFGa1BEdHFVQkxQR3dOOFlIcGI1a0d2R1dG?=
 =?utf-8?B?RjA4b3VTL0E0OVoxSEd1RnFXbWVVZ0QxdEtCdjFTelh0NW9vTFE5ZTR1c3pN?=
 =?utf-8?B?U3dqNU5xcVFxc3ZUaHFpL3g0djBHSTM3dFV2NStvc3hGamdDS3Z5TTJiOTls?=
 =?utf-8?B?RTlBeFRzZDBUTUZ4MWhiYjF1ZjdTM1NDL3lYT3FLTEtadnM4Y05EMGduZ0lv?=
 =?utf-8?B?U3U0NXVJMFcrVlZKeFN4a1RFMlJBK1QxRndPQUxCZ0swbWFDcUdPY1BtMC9Y?=
 =?utf-8?B?bGdMUm1mYkRjbm9najAvbUwySGljSlNmMFVETXI1TGo0bjRQaUJwUnVCajRj?=
 =?utf-8?B?bGN3dkkwbFE4MHJNWmNDclZZQzk2T2tzQ3NCWkQ2d0VWT29ML0lFZ1VWSWhh?=
 =?utf-8?B?S1FqdWtVRzdZcUk0NVZ3WUk4QStiWFR0OEV4bWdXc0JHR25hZDIvdjRMMjRw?=
 =?utf-8?B?OEp6UVJ2MitTRnRUdERqeUg0OXlYU2lNb3IzS2gvM29Mb2ZFVXFmRlZvOHcz?=
 =?utf-8?B?ZWJmak91bUpvWTMxM1RyTmMrd3UwZGxpSXYxa1RDeHBEVThBbGlDVXE5bXBu?=
 =?utf-8?B?TVdNcEVBcmVVU0lLZjgwa1ZwNFNqVkxPZ0ZnOUpPTDduNS9zcFMzSjhRb0d2?=
 =?utf-8?B?MmRGem1sWWxJTVFCb0ZYQ1lzelZWRlRZVEhOdzJsNnZtdk40aXJrZ1FuLzc4?=
 =?utf-8?B?RTJBeWhVVENjZU50a01BNVVLRjR4ejkwUEgyTE9RMkI4T09KTkFaV1ZRbjd5?=
 =?utf-8?B?ZmQ2VGVYWW5JcWJ6VEhZQS9MUThzUTZmMXFtR2lrQ3l5RXppdms5amNmT2JK?=
 =?utf-8?B?VVpsZDliVVgyOVRkKzVQM0V6TUtwNFpweHUzRUdESVgwVE5PZjZjclVEV1U2?=
 =?utf-8?B?R1h1Yi9uTFFaS001Mit2ZmhjRFo0RlFGUEQ4a0tCbE8wcTNnRWQyT1M4YkFD?=
 =?utf-8?B?YkNLMVN2V3VwOWhuRVN5M2orNmpRRHJ3cit4bmVSRS9PWTJiUkRidGU0Viti?=
 =?utf-8?B?KzRYbDFJVDU3Rm9kYm5TdzdQSktZZThOcmx1MWRXQ3JwZkZ1UkRmMlpOeVZt?=
 =?utf-8?B?Y2FSU29DN1NsRSsyR29zWk9yZXNsVU9sb21GenBVaHIyd0ZFRmlkK3Uxek1m?=
 =?utf-8?B?WittQlQ0elBPemNIV2JtMUtXd3RMcFEybG1iT21FZC9NaWZzSllncFk2K1Y3?=
 =?utf-8?B?UGtiL2UrT1NUVVZvMzRybVRhR1ZVRy93VEd2YytnZldGNytobCsxcXdCQmtL?=
 =?utf-8?B?UXZZNlFSdjNIK2Zpem4vL29uT0ZvZnoyaUlnY2Y3YitXcFFTRnJnTUE1aTJE?=
 =?utf-8?B?UDc0U2FwMHlCR1RWQ3BxR0pPd3JoQUFoSDVCcnRJOWZ4Zk1WenNxSERMeHB2?=
 =?utf-8?Q?tEY415UE16iyP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24cc1b85-82d4-40f1-528e-08d929ec524a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 19:42:02.1467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFHs43jMmeJ7r9U/6yBopwMOydhFAvH9rRqkbbr0rMJNsyHa9TSlGIOlCZ8gQvcR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4899
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
Cc: Davis Ming <Davis.Ming@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAwNy4wNi4yMSB1bSAyMTozOSBzY2hyaWViIFJvaGl0IEtoYWlyZToKPiBUaGlzIGlzIHNp
bWlsYXIgdG8gSUhfUkJfQ05UTCBwcm9ncmFtbWluZyBpbgo+IG5hdmkxMF9paF90b2dnbGVfcmlu
Z19pbnRlcnJ1cHRzCj4KPiBTaWduZWQtb2ZmLWJ5OiBSb2hpdCBLaGFpcmUgPHJvaGl0LmtoYWly
ZUBhbWQuY29tPgoKQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNw
LmMgfCAgMiArKwo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2loLmMgIHwg
MjAgKysrKysrKysrKysrKysrLS0tLS0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9u
cygrKSwgNSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcHNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cHNwLmMKPiBpbmRleCA0N2NlYjc4M2UyYTUuLjA1OGIxYjEyNzFlMSAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKPiBAQCAtNjgzLDYgKzY4Myw4IEBAIGludCBw
c3BfcmVnX3Byb2dyYW0oc3RydWN0IHBzcF9jb250ZXh0ICpwc3AsIGVudW0gcHNwX3JlZ19wcm9n
X2lkIHJlZywKPiAgIAo+ICAgCXBzcF9wcmVwX3JlZ19wcm9nX2NtZF9idWYoY21kLCByZWcsIHZh
bHVlKTsKPiAgIAlyZXQgPSBwc3BfY21kX3N1Ym1pdF9idWYocHNwLCBOVUxMLCBjbWQsIHBzcC0+
ZmVuY2VfYnVmX21jX2FkZHIpOwo+ICsJaWYgKHJldCkKPiArCQlEUk1fRVJST1IoIlBTUCBmYWls
ZWQgdG8gcHJvZ3JhbSByZWcgaWQgJWQiLCByZWcpOwo+ICAgCj4gICAJa2ZyZWUoY21kKTsKPiAg
IAlyZXR1cm4gcmV0Owo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9u
YXZpMTBfaWguYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25hdmkxMF9paC5jCj4gaW5k
ZXggZWFjNTY0ZThkZDUyLi4zNzZlYTI4MWM0YTcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvbmF2aTEwX2loLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9uYXZpMTBfaWguYwo+IEBAIC0xMjAsMTEgKzEyMCwyMyBAQCBmb3JjZV91cGRhdGVfd3B0
cl9mb3Jfc2VsZl9pbnQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJaWhfcmJfY250
bCA9IFJFR19TRVRfRklFTEQoaWhfcmJfY250bCwgSUhfUkJfQ05UTF9SSU5HMSwKPiAgIAkJCQkg
ICBSQl9VU0VEX0lOVF9USFJFU0hPTEQsIHRocmVzaG9sZCk7Cj4gICAKPiAtCVdSRUczMl9TT0Mx
NShPU1NTWVMsIDAsIG1tSUhfUkJfQ05UTF9SSU5HMSwgaWhfcmJfY250bCk7Cj4gKwlpZiAoYW1k
Z3B1X3NyaW92X3ZmKGFkZXYpICYmIGFtZGdwdV9zcmlvdl9yZWdfaW5kaXJlY3RfaWgoYWRldikp
IHsKPiArCQlpZiAocHNwX3JlZ19wcm9ncmFtKCZhZGV2LT5wc3AsIFBTUF9SRUdfSUhfUkJfQ05U
TF9SSU5HMSwgaWhfcmJfY250bCkpCj4gKwkJCXJldHVybjsKPiArCX0gZWxzZSB7Cj4gKwkJV1JF
RzMyX1NPQzE1KE9TU1NZUywgMCwgbW1JSF9SQl9DTlRMX1JJTkcxLCBpaF9yYl9jbnRsKTsKPiAr
CX0KPiArCj4gICAJaWhfcmJfY250bCA9IFJSRUczMl9TT0MxNShPU1NTWVMsIDAsIG1tSUhfUkJf
Q05UTF9SSU5HMik7Cj4gICAJaWhfcmJfY250bCA9IFJFR19TRVRfRklFTEQoaWhfcmJfY250bCwg
SUhfUkJfQ05UTF9SSU5HMiwKPiAgIAkJCQkgICBSQl9VU0VEX0lOVF9USFJFU0hPTEQsIHRocmVz
aG9sZCk7Cj4gLQlXUkVHMzJfU09DMTUoT1NTU1lTLCAwLCBtbUlIX1JCX0NOVExfUklORzIsIGlo
X3JiX2NudGwpOwo+ICsJaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSAmJiBhbWRncHVfc3Jpb3Zf
cmVnX2luZGlyZWN0X2loKGFkZXYpKSB7Cj4gKwkJaWYgKHBzcF9yZWdfcHJvZ3JhbSgmYWRldi0+
cHNwLCBQU1BfUkVHX0lIX1JCX0NOVExfUklORzIsIGloX3JiX2NudGwpKQo+ICsJCQlyZXR1cm47
Cj4gKwl9IGVsc2Ugewo+ICsJCVdSRUczMl9TT0MxNShPU1NTWVMsIDAsIG1tSUhfUkJfQ05UTF9S
SU5HMiwgaWhfcmJfY250bCk7Cj4gKwl9Cj4gKwo+ICAgCVdSRUczMl9TT0MxNShPU1NTWVMsIDAs
IG1tSUhfQ05UTDIsIGloX2NudGwpOwo+ICAgfQo+ICAgCj4gQEAgLTE1MywxMCArMTY1LDggQEAg
c3RhdGljIGludCBuYXZpMTBfaWhfdG9nZ2xlX3JpbmdfaW50ZXJydXB0cyhzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwKPiAgIAkJdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIElIX1JCX0NOVEws
IEVOQUJMRV9JTlRSLCAoZW5hYmxlID8gMSA6IDApKTsKPiAgIAo+ICAgCWlmIChhbWRncHVfc3Jp
b3ZfdmYoYWRldikgJiYgYW1kZ3B1X3NyaW92X3JlZ19pbmRpcmVjdF9paChhZGV2KSkgewo+IC0J
CWlmIChwc3BfcmVnX3Byb2dyYW0oJmFkZXYtPnBzcCwgaWhfcmVncy0+cHNwX3JlZ19pZCwgdG1w
KSkgewo+IC0JCQlEUk1fRVJST1IoIlBTUCBwcm9ncmFtIElIX1JCX0NOVEwgZmFpbGVkIVxuIik7
Cj4gKwkJaWYgKHBzcF9yZWdfcHJvZ3JhbSgmYWRldi0+cHNwLCBpaF9yZWdzLT5wc3BfcmVnX2lk
LCB0bXApKQo+ICAgCQkJcmV0dXJuIC1FVElNRURPVVQ7Cj4gLQkJfQo+ICAgCX0gZWxzZSB7Cj4g
ICAJCVdSRUczMihpaF9yZWdzLT5paF9yYl9jbnRsLCB0bXApOwo+ICAgCX0KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
