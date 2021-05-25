Return-Path: <SRS0=WUpi=KU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78DCC2B9F8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 19:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9BB16140F
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 19:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BB16140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A1616E426;
	Tue, 25 May 2021 19:16:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F25D6E426
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 May 2021 19:16:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMPgeWIOxdxbg+Kom6LxWUd8TslhbxxB2/wZPCa7i96Z0iXTU3NI34P9DQ6Zg3crnkQz3OA+TyhCkKojyCayzZauYq7UBeDLiRfOR7HGUcVLTnOs3HGzTPNooUzy+T0Z+mw7qrtXjUqCU9tfgC0+kg51/f9oISxS7VKeJYNu3EEBPj0H2P2JaXI11OY5sQ0t+1g7hrSpfohObLtQOGY3L/bVz5Pcu4jB5pFsRSMxM27HwEsuBlU9Yf7OeiFOu3+AaK+Q7oTpGUPJMsqmOJ7Q7ecRl1exa7IeTeSIRkn/fkdhezpR8IrxJIKihvn83HlXzNKvgDChQWDogde7kx55jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8JbDnTKriwx4+dF9mvnh8fSQx6/7c7Tm+esGckb2mc=;
 b=CdXs9WYYyGfW6MLPLLtI4Qj51JxsFThlP6eJNuHdMs1k26lw/AszFypKRadEkB1dfLTNDu31i1Q3ecrqeeEtdUrak0DyKTHWJzxJWBO2CouHgINFyt7bcOcUGxu6NKMVDR4xZsyIpKUFTFmcz1DXxKzsSiZMaCjseP6G63V0iRH/uUnHgK+hw2d5rBwY65I4TDuAFomMiD+F2o+qif3Bumhoc2voBs5Ca2hT+p8yib7klltDmeX/BU4NpLojIjt2dxnh43UwdNgXX8IL3K3vultCwuSSp/k+EFVwg7Z2/gHDXMT7BdUtmk+5SHHJPH10adNQzAwGkklM3NDJpn1wDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8JbDnTKriwx4+dF9mvnh8fSQx6/7c7Tm+esGckb2mc=;
 b=EQvehf1tUT8Q1qyj+sqUOqiESAMu4kIo0qevz2A7WtkYZGjb1dL1F+36E2hSQFD0e/OO2Ue/JWzzHxbZULtAAMuVn24McSmoflGrm5eF25+23K/yMNYFRztjo+K0dtFZLpzrAz8EGH8H5DhcuG1jqUL14TU98zNpnZXX1gC+UiU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Tue, 25 May
 2021 19:16:13 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 19:16:13 +0000
Subject: Re: [PATCH] drm/amdkfd: move flushing TLBs from map to unmap
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <fab1b78c-d6a9-2c23-368c-9cb1999e3aa8@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <b19402db-5b60-2cc2-991b-87c6190ac630@amd.com>
Date: Tue, 25 May 2021 15:16:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <fab1b78c-d6a9-2c23-368c-9cb1999e3aa8@amd.com>
Content-Language: en-US
X-Originating-IP: [142.186.56.206]
X-ClientProxiedBy: YT1PR01CA0132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::11) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.56.206) by
 YT1PR01CA0132.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.27 via Frontend Transport; Tue, 25 May 2021 19:16:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 918cb415-d77a-496a-c02d-08d91fb18fdd
X-MS-TrafficTypeDiagnostic: BN9PR12MB5338:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB533831B39726C9ED978E918292259@BN9PR12MB5338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oXg3gGxadkEBxkpt6ok+FD2IHGEelIcpzeKXke1+usYq7rLyt20Ce8O7hjfO4SwSlA4LpmuhsW1Dd1X3ojlt/iu2hWldZDfQxw/0D+2ea8y1sVmlJ7iFm50uu2H0q15oqVsKupUVFR+w6gM/xV3b3dzGC8ILTEMMb1HsKQybxY2ebw7p4PjYLJ31aUUQCwiRuyN5bMNHwfS6dO94t5JJQo0+AsiBCYtTvbTXYKlNx96n9lla8lVsKUQk9CMPNYF3End6itJY2CQdppY+db+zHc/0ksDB7qDZBfuX0EZuBIpQOXHafwtWk8G30BNKhIBs/Zvl310CuGkRntsoJDu4SrUAtN9an8nkphvjha+lgKkrzX2spgZ4q+6BpyAGLG6+kGjw0Oa1jFK+HtlPxt3QsWA+RLkJyM3b24jPW8jR2D2yAsaPiioKm0VebI24QmWqGulE13iMR8TBGnFAAkZ/wAq6IwYq2N7SRwJtqUSPJlss2CEZTQljCS/6ZQzczQ7RsBNCUWFPqMEHWBPHxM0nCdp40O8UjgdCswudBAGN69g9Y+nKwX8o19tRxHzWaV5qFEhE5PeA50SPUlw1pX+YvsNHqwowL1FfxIA3r6Ja3z1RV38Zf52yHVRjGb/C7oPX2RIS1a1VU5DoFQzZxo+rRSXjg0MALNSCGTUvbYYek1DrKpp1FFsORlT7Hc2oGt/gxpdruQUtoQTHboLBFvns+1LOiI7o0zYY7TueMKsIs8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(366004)(39850400004)(136003)(44832011)(16526019)(186003)(6486002)(31686004)(86362001)(31696002)(2616005)(8936002)(16576012)(2906002)(36756003)(38100700002)(66476007)(478600001)(66946007)(66556008)(5660300002)(83380400001)(966005)(8676002)(956004)(26005)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dC80T3E4VVNQbmhNSW9LYWJaK3pjZmtjcXFsM1ZqdWducmRNb1l3YS9tTG9q?=
 =?utf-8?B?OHYwb2ZpQUgvNG1VbCtPRzJIRTlPWGZxSjhtaDd6aDJqa3JuSFdRYkZsNGVW?=
 =?utf-8?B?S2o5SG5mZlhUaFE2STY1M0VEcm5xVDlZNE94eTNuQ2lydGdRUXVIbFYzNkha?=
 =?utf-8?B?aDFWbU42VERyKzJobWp0ZnJZYitmUnB1VlhrbkQ5Y2VNdW1MczZLYmJra0dC?=
 =?utf-8?B?WEhWR2FDdWEvL3I3NG83ckVqLzBNRU9SRldkbCszb1N5RXhYSXVVZWRLNklx?=
 =?utf-8?B?S2tsbEJMKzNjT1hXSlA3N2ZNdlk2OTNndkRlVE9VMFdtcnlWK0FMT25KcXht?=
 =?utf-8?B?SDMwbHVoQ2MxQkI5ZHh6REc2S3dBNXl0STFnUXRHaTV5dDR6THlUKzhWR0Q5?=
 =?utf-8?B?bFlJQ3E4NkVLVUo1eVBiaU1TcUdSeXNTbVZPdEFTd25oR3N4ZDdnMTc0Qm9v?=
 =?utf-8?B?V2NyMVhCVytkRnRzakFlcktRY1M0eFJTSHcyYTZiMVB3VG1KcjdqZnVwRnlu?=
 =?utf-8?B?WjNadFF0K1cya3l5YUZxOFhxNloxQkl0cnVTNEJFR0lOM21YZGJSdVJLY2sz?=
 =?utf-8?B?TkpzZG9DSE9iVHRBY0htWmRJRlNlVG4zLzNYR1NVN1BuREJ6cE9FZ1hpWnVT?=
 =?utf-8?B?bUQ5NDdheUN2UzFhSEVkOWMydEIxblRvVmpLQmpxNkU0a2xOblZTRXA2bm1H?=
 =?utf-8?B?MUYrRWdxODhUenhMb3Rnb05lYkhvN2tTNDJkZnhTb2ExNko1TC9EMGtuN1JQ?=
 =?utf-8?B?Y1V2eUxiMms3bGdSd081Mnc1aGxOVHZlZlFMMGZETksxS2xLdDFCTUJWNXlr?=
 =?utf-8?B?QmlRTmp1RVRQMVkvbGlINEFBZTI5U2VGc2xaOWVESitYc3ZLaE5SbVFrNG0y?=
 =?utf-8?B?UUxWV3hhVFQzazhISUUwMW5ubmI4NnF6Wm5tbmZydU9yQU1OV1R2ZmNLckc3?=
 =?utf-8?B?TklaNDlvS1MybnJTUVBzN3RndDIvajBPZ3grTzliOVVSRUt0a0ZlOXZqU0Ni?=
 =?utf-8?B?TVk3Wi9QSmwvNy81TXpSR2JDT3V4WVBaRGZuQVlSdWdYVUJDTFU3bjFybGtl?=
 =?utf-8?B?VGU3L0djR1BweFY4RXhQSjJCQ2FPbTBjTGMxQjgrTWtvcUNnUUU3aUpoNFRN?=
 =?utf-8?B?TnM3cXplcXhuZTRCY2daR25XemRBdGdTRnFkYkkvOE1uUmF2dEljOWp3YXZM?=
 =?utf-8?B?bHNDczZmUzdYVkFHdE5BT2s3RFFONHkzeE5Wa1Y2RzJOanZwalZnbGdKTWNO?=
 =?utf-8?B?L2gxUVp2SEdic2UxTTZXSWMySHg5dVBRd2tvRmoxMGoyWG40SG5BdUlHOGJh?=
 =?utf-8?B?dEFtZEkrOGVqZkFEZEJnNWRHMWxIdjRvMURPVzdESDA0ZEZRYTMzTis1a2hM?=
 =?utf-8?B?RmJXbWpWaXZEbTIrQnEwcWQrVks0UnB4NkJPNkYrQzlxTE82U3RpSUxKdWp1?=
 =?utf-8?B?N0g5bjJ1QVpsam1rWGc5aCs5UHpyY2UzOHVya2RwK3pzUTNCeXp2VE82dnl1?=
 =?utf-8?B?ejJvaWJIVDlJL3ZtWkdFejR6QVRTYlE3a2RDQmdvOVdrMnNTeE15U1hIdlNn?=
 =?utf-8?B?S0FGNkJsNDRWTW15YTZsS1VaSlpvakxwY28rZWdMcEovZm4za21tTEdNeU1F?=
 =?utf-8?B?VEN5NFA2eTBxL01GRVhiSTNMTWI3dWdXbGZ5Ukw5T1B2VEJ6K1k1Y0tJZzVj?=
 =?utf-8?B?MU9zTXBHL1N6MWpWL3R3UFQzN3o4eVg1ZS9kazU5bTAxWDlYd3hyYkZNNWla?=
 =?utf-8?Q?QTjGb+89Ela4QQ61ZwI7BB0r7mmSc3zeKPYuohb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 918cb415-d77a-496a-c02d-08d91fb18fdd
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 19:16:13.4944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Yzcvp/eJKxqytkOMQ9Qt99witAfW8ApuMW4sC8ipPlFyIUFxquXpinzB8LbD/o6GNVM5K8MzuATC66V5/12lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U2ltaWxhciB0byBhIHJlY2VudCBmaXggYnkgUGhpbGlwIFlhbmcgNzZlMDhiMzdkMGFhICgiZHJt
L2FtZGdwdTogZmx1c2gKVExCIGlmIHZhbGlkIFBERSB0dXJucyBpbnRvIFBURSIpLCB0aGVyZSBu
ZWVkcyB0byBiZSBhIGNvbmRpdGlvbmFsIFRMQgpmbHVzaCBhZnRlciBtYXAsIGlmIGFueSBQREVz
IHdlcmUgdW5tYXBwZWQgYW5kIHR1cm5lZCBpbnRvIFBURXMgaW4gdGhlCnByb2Nlc3MuIFRoaXMg
aXMgY3VycmVudGx5IHJldHVybmVkIGJ5IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZyBpbgp0
aGUgInRhYmxlX2ZyZWVkIiBwYXJhbWV0ZXIuIFRoaXMgbmVlZHMgdG8gYmUgYWxzbyByZXR1cm5l
ZCBieQphbWRncHVfdm1fYm9fdXBkYXRlIGFuZCByZXBvcnRlZCBiYWNrIHRvIEtGRCwgc28gS0ZE
IGNhbiBkbyB0aGUgVExCCmZsdXNoIGFmdGVyIG1hcCwgaWYgbmVlZGVkLgoKa2ZkX2ZsdXNoX3Rs
YiBwcm9iYWJseSBuZWVkcyBhIG5ldyBwYXJhbWV0ZXIgdG8gZGV0ZXJtaW5lIHRoZSBmbHVzaAp0
eXBlLiBUaGUgZmx1c2ggYWZ0ZXIgbWFwIGNhbiBiZSBhICJsZWdhY3kiIGZsdXNoICh0eXBlIDAp
LiBUaGUgZmx1c2gKYWZ0ZXIgdW5tYXAgbXVzdCBiZSBhICJoZWF2eS13ZWlnaHQiIGZsdXNoICh0
eXBlIDIpIHRvIG1ha2Ugc3VyZSB3ZQpkb24ndCBldmljdCBjYWNoZSBsaW5lcyBpbnRvIHBhZ2Vz
IHRoYXQgd2Ugbm8gbG9uZ2VyIG93bi4KCkZpbmFsbHksIGluIHRoZSB0aWNrZXQgSSB0aG91Z2h0
IGFib3V0IHBvc3NpYmxlIG9wdGltaXphdGlvbnMgdXNpbmcgYQp3b3JrZXIgdG8gbWluaW1pemUg
dGhlIGltcGFjdCBvZiBUTEIgZmx1c2hlcyBvbiB1bm1hcCBsYXRlbmN5LiBUaGF0CmNvdWxkIGJl
IGEgZm9sbG93IHVwIGNvbW1pdC4KClJlZ2FyZHMsCsKgIEZlbGl4CgoKQW0gMjAyMS0wNS0yNSB1
bSAxOjUzIHAubS4gc2NocmllYiBFcmljIEh1YW5nOgo+IEl0IGl0IHRvIG9wdGltaXplIG1lbW9y
eSBhbGxvY2F0aW9uIGxhdGVuY3kuCj4KPiBTaWduZWQtb2ZmLWJ5OiBFcmljIEh1YW5nIDxqaW5o
dWllcmljLmh1YW5nQGFtZC5jb20+Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2NoYXJkZXYuYwo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X2NoYXJkZXYuYwo+IGluZGV4IDk2MDkxM2EzNWVlNC4uYWI3Mzc0MWVkYjk3IDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMKPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jCj4gQEAgLTE2NTcsMjAgKzE2NTcs
NiBAQCBzdGF0aWMgaW50IGtmZF9pb2N0bF9tYXBfbWVtb3J5X3RvX2dwdShzdHJ1Y3QKPiBmaWxl
ICpmaWxlcCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBzeW5jX21lbW9y
eV9mYWlsZWQ7Cj4gwqDCoMKgwqDCoMKgwqAgfQo+Cj4gLcKgwqDCoMKgwqDCoCAvKiBGbHVzaCBU
TEJzIGFmdGVyIHdhaXRpbmcgZm9yIHRoZSBwYWdlIHRhYmxlIHVwZGF0ZXMgdG8KPiBjb21wbGV0
ZSAqLwo+IC3CoMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IGFyZ3MtPm5fZGV2aWNlczsgaSsr
KSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGVlciA9IGtmZF9kZXZpY2VfYnlf
aWQoZGV2aWNlc19hcnJbaV0pOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChX
QVJOX09OX09OQ0UoIXBlZXIpKQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBjb250aW51ZTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwZWVy
X3BkZCA9IGtmZF9nZXRfcHJvY2Vzc19kZXZpY2VfZGF0YShwZWVyLCBwKTsKPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoV0FSTl9PTl9PTkNFKCFwZWVyX3BkZCkpCj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghYW1kZ3B1X3JlYWRfbG9jayhwZWVyLT5kZGV2
LCB0cnVlKSkgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBrZmRfZmx1c2hfdGxiKHBlZXJfcGRkKTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X3JlYWRfdW5sb2NrKHBlZXItPmRkZXYpOwo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiAtwqDCoMKgwqDCoMKgIH0KPiAtCj4gwqDCoMKg
wqDCoMKgwqAga2ZyZWUoZGV2aWNlc19hcnIpOwo+Cj4gwqDCoMKgwqDCoMKgwqAgdHJhY2Vfa2Zk
X21hcF9tZW1vcnlfdG9fZ3B1X2VuZChwLAo+IEBAIC0xNzY2LDYgKzE3NTIsNyBAQCBzdGF0aWMg
aW50Cj4ga2ZkX2lvY3RsX3VubWFwX21lbW9yeV9mcm9tX2dwdShzdHJ1Y3QgZmlsZSAqZmlsZXAs
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVf
cmVhZF91bmxvY2socGVlci0+ZGRldik7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBnb3RvIHVubWFwX21lbW9yeV9mcm9tX2dwdV9mYWlsZWQ7Cj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBrZmRfZmx1c2hfdGxiKHBlZXJfcGRkKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgYW1kZ3B1X3JlYWRfdW5sb2NrKHBlZXItPmRkZXYpOwo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBhcmdzLT5uX3N1Y2Nlc3MgPSBpKzE7Cj4gwqDCoMKgwqDCoMKgwqAgfQo+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdm
eCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
