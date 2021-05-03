Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3202C433ED
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 19:13:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42E8D6135F
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 19:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E8D6135F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1AFC6E141;
	Mon,  3 May 2021 19:13:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1B036E141
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 May 2021 19:13:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFGB8KksQguoxzSVfNZr4omgsDTgfC1OzdsKxT6qITRsi+mS8aHtfy6XY3ADTEiJviaNM4VHsnpj/8UgaWOJdnDB0eAgO2SOtzZV42BbLYR9aKieUnl50kMaZhGTAH/JAIzHLWMeeTSbFZlslfBAJv+2pnbjggiGmORupWQmGGyePbG36GStDsLMQhlLAuS6q7OvXBhS9tMLElC9Kt2+eeIZb6cl71bgZPReAVVL5tYpuaB7ww5/vk0KTXK1r20EExbineO/gkEC2v//B6KEqh//BuysURO8AS4M8XEemlBRCmYC9GgIugXE+BEpWA3rFDQHhOdk4eTGPJRvMqA1uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=la598tkSyW8gpJ6r7twUr5dN8FPW9JYUJg+gIVeEHVQ=;
 b=E3K2dJ0eYPjHOd84VYQIivzyFAtMpFkFkn9+qc+CeB0B5l/DYs6oKKQYXZXmrR4QUAkuiii55nX1n1K5KwM+lkxfnpXihFzqA6hqukK/S5MUDezi6Py9hlD0b39Aw53TFD/JdiJwrNhjv9OhsPdPwjEXqWcBYvruwgEh//kwKzvfMD5A3Btywt/kuXZFB0U1pgWl1iUyeenN3N/5m3Cjc98frhKT6En4QlO7Sa5GwY3aWYJGt4/rG064OKA6ab1ZKIB8wGjrK+sWdB95kuYjFuqsCj9uf5QJ6iKyWDG8W9NyzQjO6l+SvS4xGEhSdm6/5Zpxu+N1b76lSGRWWSL3Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=la598tkSyW8gpJ6r7twUr5dN8FPW9JYUJg+gIVeEHVQ=;
 b=jrD0jvourkCb+8ZteIbmahTSEJv7bilnUp1ySHQ+yUMP1QK7hz0HQb6wRClJS6ctOAYD93eGR45KEoI7QFgEqpnSa2A8xgpHhTe5542z/XXuEh3hJcn9uBSY5OlWbKeYczCVXqFEM+fzpId1h4+sitZyi2Zgw95jO2rGtowhhkc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5274.namprd12.prod.outlook.com (2603:10b6:408:11f::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Mon, 3 May
 2021 19:13:36 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4087.039; Mon, 3 May 2021
 19:13:36 +0000
Subject: Re: [PATCH] drm/amdkfd: add ACPI SRAT parsing for topology
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210503144753.9795-1-jinhuieric.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <d8cecb2d-438c-f503-022a-b1b8f7ce0c06@amd.com>
Date: Mon, 3 May 2021 15:13:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210503144753.9795-1-jinhuieric.huang@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.138.207]
X-ClientProxiedBy: YT1PR01CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::11) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.138.207) by
 YT1PR01CA0072.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.37 via Frontend Transport; Mon, 3 May 2021 19:13:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c7b2cbb-9dbe-446b-b69b-08d90e678d19
X-MS-TrafficTypeDiagnostic: BN9PR12MB5274:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5274A3D9B27C3254273315DC925B9@BN9PR12MB5274.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yv0l9bRnQvJR1Elm6LVA3nYJLmUnkgpmGkG3LCQikxFqePdBYewcTlBEiuDgz1Uw7KuA2DErCBYCAPKh7XVz50e/UYVOHBYpXxbjlBB0Jss+OTh2gBIkZDgVQlS5gkl5pJtpzXYpgC/035b87mHDj1Awe/Rtpp9Mn7p/b/TqkwZjVapq0M/UMc875NDG8MUgzXzAkFdV3M+J/4W4yfUrfOlnLWHidrEovZg+jpEEohRp/ilUvgjgrsnMeYGDnRO0jrcqULMnOtlCEQsHJWEBEQQjwFfQr6/mbvnVwLX0+q6jCu5wkSpPBS1flyYFul6S5sCw6rSz6+Y1xCP808+O1L9fYSZ4LAdl4Ie7PhouKhVMWLVsFPpQ3E0N0+9piN/GBdztKnQg+FNb2C23l7RR5Kzjq67GcZBTnNPLTtmFHvNPgI4D1sg0tZvKfKost/lGS5xVZkVPQx16wxkE1vi2gsJe/mIAiisBerF69Ttw+cqPqHnfMTwPhxQWr06EayzYrElH0am3pt59OWyaItdslb5yPLgCtLWgUGiVFR3sQwOgPEuot6sA04RHmwKJnCbfAOR1OGSKsMoGC/UCYnfAufJ8j8dJb1wm6Qn7buR/OM8Ybd10yhEk5Nv8LiSX3vyBIN1nwI2b6Td92y3mY6EBCqev4EbW1/SsUpoVkF6TgPO0xiVk+KUD3/g032FG3Bm3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(39850400004)(396003)(346002)(83380400001)(478600001)(2906002)(66476007)(66556008)(26005)(66946007)(8936002)(186003)(44832011)(5660300002)(16576012)(36756003)(316002)(31696002)(6486002)(8676002)(956004)(31686004)(2616005)(38100700002)(16526019)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d3ZIazVPK1NzMHh5eTl0MjJ4MUkvUWJBcTNiQTBVVllDOXlpNnFObWlCWmJk?=
 =?utf-8?B?b3NNL2tLd3o3ajkwQWIxVXRmK0w3NlVFb2RnalVkckxua3NSSGRSbTJmdXFl?=
 =?utf-8?B?dmh2bXl2QnhqVUlHZnk0anBkajl4TGo2WTNZRVp0QUh6OUJKcEJhSEU1VGhE?=
 =?utf-8?B?dEhzVXY2MFNpemNIYVpEMEhpdE8vWjBpbmtEcnNzYUtkUlF1R2F3cjhtZHI3?=
 =?utf-8?B?ZlJyaW9UdUR3V1AyaXo3T0t1dzdvS2QvN0dFcm1vazc5UFo2WEUrb0JBSUQ5?=
 =?utf-8?B?TkRxUjRKT0J6SUdtRzM4QXV2RzFGWmMwOFhmREF6U2tEZjlhM0ZyU0JxNkJz?=
 =?utf-8?B?UUhwa0FHZ2RwVVlGYUVvS0NkUlJiYVBKNVAyN2Y2NFhPVlhRdThoTTQrZVph?=
 =?utf-8?B?QThWdEZOZHhGdk9kRzBKbTk1WERlazFZYjNrK3BZdXJNQXd4c0xSNm5QeUhw?=
 =?utf-8?B?VEx5YWFqbTF5UFN0Wi9uQ29ZVlhoZE1WVHJGZlp3Si9XN1l0L3IzTk5raUpk?=
 =?utf-8?B?Q0d4aWlzb3gweXRSeTdabEF6MFdUQ0FMZ1dtQVVSRDJsNjM4SnhZemJuWmZL?=
 =?utf-8?B?aStsMU5SNDl3SElvSUtMSzJTNWVZSGlxUmFITy85eDd2WUJ1TG9CNW5yWHZM?=
 =?utf-8?B?c3Vvd2ZVei8rVnRRajhYaVJlZVI1Vko1d1VHVkptSlJ6S3lJU01KZmRDQ2Ns?=
 =?utf-8?B?TWJRSnh6TXk2ZGRFWC8wemZablN0OHdwb2JjOVlGR0gzYjFCZWNmV0xUTHNI?=
 =?utf-8?B?eGY3MGVsSWxnczlqdUUrVVZmNkdIemtIOC8zK3B3Q2sxQWxkQ1JoMkhEbXBv?=
 =?utf-8?B?WlpKZEs3Z2VlMHdwSXJpaVdpbVFqOHdnaDBTMVE2ZlMyTlg2Z09sbUg3d3BZ?=
 =?utf-8?B?U0l6ZHYyamZiajBkaXc5QU1XWVhyck9udk9rMXFkczBDM3hSTVZ2WndOTGNh?=
 =?utf-8?B?M3Q3c2VJUnIwVG9FTzZ1c0YwK00yT1pBT1V3TUxsZE0vaDBON3I0UG1HWURQ?=
 =?utf-8?B?YVptdkJ4aXlyblBGZ2xKS0FXOFFYWFNaVWFMSmptN1U4ZU5OMXhUTC80RWdH?=
 =?utf-8?B?N0hRTmNGNXE5Q1JiTGQzN1doYzNMSXRXSURlMGY5NlM2MWY4aHU3eEh6Wlhv?=
 =?utf-8?B?blBrdjZ6d3BnMWN2a29jdFhIdTV6NWtvZUtyR21SdXBEanNMNllwbXVZOGZ0?=
 =?utf-8?B?OTZDMFBVVGo0M0hpellZN2ljcE5TTEpHTlFLWkpGRnFScXRQNEpYYVpTazNT?=
 =?utf-8?B?ZVBaeUQzcWgwWFF1TURNR3o0Mld5UW1tV1kzWlQxK2owcy8xNjU3ZStzbVJj?=
 =?utf-8?B?UXR0N0tKSUFyMDdneW5pS3R2aDFtM1RuMGFPUzNiYU1ycTZCalpjK0tmYldv?=
 =?utf-8?B?YTFsK3NCYnpmU1FtTzN3N2tjRmRlVUtuVGxsR0pJSHVRSVNlK3M1WUNXL2M2?=
 =?utf-8?B?aUFmZWV3cUxxTng2aDRCeXRRdHpnYzgvOXJKNyt4S1FTd3pQcmtacFppR3JT?=
 =?utf-8?B?YXArSTBzWnU3bGhLOTF0OTRDckxvQXpjeUwvTHkyS253Q1VselVsTmFoL2lQ?=
 =?utf-8?B?OWpRUW5IemNnKzErOFl6WlZBWUpQVDVBanFtTWNRMWdsLzd5bEtsUWpEd2JE?=
 =?utf-8?B?T1A3VXdKQUFiamcrT3FVSnpJdHFUaE8yNmtOODNLMWlyeXM5Zndxa0JnSXYz?=
 =?utf-8?B?ZVY4Ynppb0VRcVRycmVRV25uMVhpMFArRnZITGMyUWNsMjhiL3Q1M2tEZHlx?=
 =?utf-8?Q?7NFZuku87FIxRvVwgWPkgKXaU5aeewJfvwLxoJC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7b2cbb-9dbe-446b-b69b-08d90e678d19
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 19:13:36.3349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ku75XdEclMBidvUjTJVMErUWu8qlwa2jNg5t3zXV3rYKBT3C7Yet9nGW6mAOhKvKWlkeyYpHc/Cd/5QpPLrpLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5274
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

QW0gMjAyMS0wNS0wMyB1bSAxMDo0NyBhLm0uIHNjaHJpZWIgRXJpYyBIdWFuZzoKPiBJbiBOUFM0
IEJJT1Mgd2UgbmVlZCB0byBmaW5kIHRoZSBjbG9zZXN0IG51bWEgbm9kZSB3aGVuIGNyZWF0aW5n
Cj4gdG9wb2xvZ3kgaW8gbGluayBiZXR3ZWVuIGNwdSBhbmQgZ3B1LCBpZiBQQ0kgZHJpdmVyIGRv
ZXNuJ3Qgc2V0Cj4gaXQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBFcmljIEh1YW5nIDxqaW5odWllcmlj
Lmh1YW5nQGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9j
cmF0LmMgfCA5NSArKysrKysrKysrKysrKysrKysrKysrKysrKy0KPiAgMSBmaWxlIGNoYW5nZWQs
IDkzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9jcmF0LmMKPiBpbmRleCAzOGQ0NTcxMTY3NWYuLjU4YzY3MzhkZTc3NCAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY3JhdC5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYwo+IEBAIC0xNzU5LDYgKzE3NTksOTEg
QEAgc3RhdGljIGludCBrZmRfZmlsbF9ncHVfbWVtb3J5X2FmZmluaXR5KGludCAqYXZhaWxfc2l6
ZSwKPiAgCXJldHVybiAwOwo+ICB9Cj4gIAo+ICsjaWZkZWYgQ09ORklHX0FDUElfTlVNQQo+ICtz
dGF0aWMgdm9pZCBrZmRfZmluZF9udW1hX25vZGVfaW5fc3JhdChzdHJ1Y3Qga2ZkX2RldiAqa2Rl
dikKPiArewo+ICsJc3RydWN0IGFjcGlfdGFibGVfaGVhZGVyICp0YWJsZV9oZWFkZXIgPSBOVUxM
Owo+ICsJc3RydWN0IGFjcGlfc3VidGFibGVfaGVhZGVyICpzdWJfaGVhZGVyID0gTlVMTDsKPiAr
CXVuc2lnbmVkIGxvbmcgdGFibGVfZW5kLCBzdWJ0YWJsZV9sZW47Cj4gKwl1MzIgcGNpX2lkID0g
cGNpX2RvbWFpbl9ucihrZGV2LT5wZGV2LT5idXMpIDw8IDE2IHwKPiArCQkJcGNpX2Rldl9pZChr
ZGV2LT5wZGV2KTsKPiArCXUzMiBiZGY7Cj4gKwlhY3BpX3N0YXR1cyBzdGF0dXM7Cj4gKwlzdHJ1
Y3QgYWNwaV9zcmF0X2NwdV9hZmZpbml0eSAqY3B1Owo+ICsJc3RydWN0IGFjcGlfc3JhdF9nZW5l
cmljX2FmZmluaXR5ICpncHU7Cj4gKwlpbnQgcHhtID0gMCwgbWF4X3B4bSA9IDA7Cj4gKwlpbnQg
bnVtYV9ub2RlID0gTlVNQV9OT19OT0RFOwo+ICsJYm9vbCBmb3VuZCA9IGZhbHNlOwo+ICsKPiAr
CS8qIEZldGNoIHRoZSBTUkFUIHRhYmxlIGZyb20gQUNQSSAqLwo+ICsJc3RhdHVzID0gYWNwaV9n
ZXRfdGFibGUoQUNQSV9TSUdfU1JBVCwgMCwgJnRhYmxlX2hlYWRlcik7Cj4gKwlpZiAoc3RhdHVz
ID09IEFFX05PVF9GT1VORCkgewo+ICsJCXByX3dhcm4oIlNSQVQgdGFibGUgbm90IGZvdW5kXG4i
KTsKPiArCQlyZXR1cm47Cj4gKwl9IGVsc2UgaWYgKEFDUElfRkFJTFVSRShzdGF0dXMpKSB7Cj4g
KwkJY29uc3QgY2hhciAqZXJyID0gYWNwaV9mb3JtYXRfZXhjZXB0aW9uKHN0YXR1cyk7Cj4gKwkJ
cHJfZXJyKCJTUkFUIHRhYmxlIGVycm9yOiAlc1xuIiwgZXJyKTsKPiArCQlyZXR1cm47Cj4gKwl9
Cj4gKwo+ICsJdGFibGVfZW5kID0gKHVuc2lnbmVkIGxvbmcpdGFibGVfaGVhZGVyICsgdGFibGVf
aGVhZGVyLT5sZW5ndGg7Cj4gKwo+ICsJLyogUGFyc2UgYWxsIGVudHJpZXMgbG9va2luZyBmb3Ig
YSBtYXRjaC4gKi8KPiArCXN1Yl9oZWFkZXIgPSAoc3RydWN0IGFjcGlfc3VidGFibGVfaGVhZGVy
ICopCj4gKwkJCSgodW5zaWduZWQgbG9uZyl0YWJsZV9oZWFkZXIgKwo+ICsJCQlzaXplb2Yoc3Ry
dWN0IGFjcGlfdGFibGVfc3JhdCkpOwo+ICsJc3VidGFibGVfbGVuID0gc3ViX2hlYWRlci0+bGVu
Z3RoOwo+ICsKPiArCXdoaWxlICgoKHVuc2lnbmVkIGxvbmcpc3ViX2hlYWRlcikgKyBzdWJ0YWJs
ZV9sZW4gIDwgdGFibGVfZW5kKSB7Cj4gKwkJLyoKPiArCQkgKiBJZiBsZW5ndGggaXMgMCwgYnJl
YWsgZnJvbSB0aGlzIGxvb3AgdG8gYXZvaWQKPiArCQkgKiBpbmZpbml0ZSBsb29wLgo+ICsJCSAq
Lwo+ICsJCWlmIChzdWJ0YWJsZV9sZW4gPT0gMCkgewo+ICsJCQlwcl9lcnIoIlNSQVQgaW52YWxp
ZCB6ZXJvIGxlbmd0aFxuIik7Cj4gKwkJCWJyZWFrOwo+ICsJCX0KPiArCj4gKwkJc3dpdGNoIChz
dWJfaGVhZGVyLT50eXBlKSB7Cj4gKwkJY2FzZSBBQ1BJX1NSQVRfVFlQRV9DUFVfQUZGSU5JVFk6
Cj4gKwkJCWNwdSA9IChzdHJ1Y3QgYWNwaV9zcmF0X2NwdV9hZmZpbml0eSAqKXN1Yl9oZWFkZXI7
Cj4gKwkJCXB4bSA9ICooKHUzMiAqKWNwdS0+cHJveGltaXR5X2RvbWFpbl9oaSkgPDwgOCB8Cj4g
KwkJCQkJY3B1LT5wcm94aW1pdHlfZG9tYWluX2xvOwo+ICsJCQlpZiAocHhtID4gbWF4X3B4bSkK
PiArCQkJCW1heF9weG0gPSBweG07Cj4gKwkJCWJyZWFrOwo+ICsJCWNhc2UgQUNQSV9TUkFUX1RZ
UEVfR0VORVJJQ19BRkZJTklUWToKPiArCQkJZ3B1ID0gKHN0cnVjdCBhY3BpX3NyYXRfZ2VuZXJp
Y19hZmZpbml0eSAqKXN1Yl9oZWFkZXI7Cj4gKwkJCWJkZiA9ICooKHUxNiAqKSgmZ3B1LT5kZXZp
Y2VfaGFuZGxlWzBdKSkgPDwgMTYgfAo+ICsJCQkJCSooKHUxNiAqKSgmZ3B1LT5kZXZpY2VfaGFu
ZGxlWzJdKSk7Cj4gKwkJCWlmIChiZGYgPT0gcGNpX2lkKSB7Cj4gKwkJCQlmb3VuZCA9IHRydWU7
Cj4gKwkJCQludW1hX25vZGUgPSBweG1fdG9fbm9kZShncHUtPnByb3hpbWl0eV9kb21haW4pOwo+
ICsJCQl9Cj4gKwkJCWJyZWFrOwo+ICsJCWRlZmF1bHQ6Cj4gKwkJCWJyZWFrOwo+ICsJCX0KPiAr
Cj4gKwkJaWYgKGZvdW5kKQo+ICsJCQlicmVhazsKPiArCj4gKwkJc3ViX2hlYWRlciA9IChzdHJ1
Y3QgYWNwaV9zdWJ0YWJsZV9oZWFkZXIgKikKPiArCQkJCSgodW5zaWduZWQgbG9uZylzdWJfaGVh
ZGVyICsgc3VidGFibGVfbGVuKTsKPiArCQlzdWJ0YWJsZV9sZW4gPSBzdWJfaGVhZGVyLT5sZW5n
dGg7Cj4gKwl9Cj4gKwo+ICsJYWNwaV9wdXRfdGFibGUodGFibGVfaGVhZGVyKTsKPiArCj4gKwkv
KiBXb3JrYXJvdW5kIGJhZCBjcHUtZ3B1IGJpbmRpbmcgY2FzZSAqLwo+ICsJaWYgKGZvdW5kICYm
IChudW1hX25vZGUgPCAwIHx8IG51bWFfbm9kZSA+IG1heF9weG0pKQo+ICsJCW51bWFfbm9kZSA9
IDA7Cj4gKwo+ICsJaWYgKG51bWFfbm9kZSAhPSBOVU1BX05PX05PREUpCj4gKwkJc2V0X2Rldl9u
b2RlKCZrZGV2LT5wZGV2LT5kZXYsIG51bWFfbm9kZSk7Cj4gK30KPiArI2VuZGlmCj4gKwo+ICAv
KiBrZmRfZmlsbF9ncHVfZGlyZWN0X2lvX2xpbmsgLSBGaWxsIGluIGRpcmVjdCBpbyBsaW5rIGZy
b20gR1BVCj4gICAqIHRvIGl0cyBOVU1BIG5vZGUKPiAgICoJQGF2YWlsX3NpemU6IEF2YWlsYWJs
ZSBzaXplIGluIHRoZSBtZW1vcnkKPiBAQCAtMTgwNCwxMCArMTg4OSwxNiBAQCBzdGF0aWMgaW50
IGtmZF9maWxsX2dwdV9kaXJlY3RfaW9fbGlua190b19jcHUoaW50ICphdmFpbF9zaXplLAo+ICAJ
fQo+ICAKPiAgCXN1Yl90eXBlX2hkci0+cHJveGltaXR5X2RvbWFpbl9mcm9tID0gcHJveGltaXR5
X2RvbWFpbjsKPiAtI2lmZGVmIENPTkZJR19OVU1BCj4gKwo+ICsjaWZkZWYgQ09ORklHX0FDUElf
TlVNQQo+ICAJaWYgKGtkZXYtPnBkZXYtPmRldi5udW1hX25vZGUgPT0gTlVNQV9OT19OT0RFKQo+
ICsJCWtmZF9maW5kX251bWFfbm9kZV9pbl9zcmF0KGtkZXYpOwo+ICsjZW5kaWYKPiArI2lmZGVm
IENPTkZJR19OVU1BCj4gKwlpZiAoa2Rldi0+cGRldi0+ZGV2Lm51bWFfbm9kZSA9PSBOVU1BX05P
X05PREUpIHsKPiAgCQlzdWJfdHlwZV9oZHItPnByb3hpbWl0eV9kb21haW5fdG8gPSAwOwo+IC0J
ZWxzZQo+ICsJCXNldF9kZXZfbm9kZSgma2Rldi0+cGRldi0+ZGV2LCAwKTsKClRoaXMgc2hvdWxk
IG5vdCBiZSBoZXJlLiBJZiB5b3UgcmVhbGx5IHdhbnQgdG8gbGllIGFib3V0IHRoZSBOVU1BIG5v
ZGUKYW5kIHByZXRlbmQgdGhhdCBpdCdzIDAgYW5kIG5vdCBOT19OT0RFLCB0aGVuIHRoYXQgc2hv
dWxkIGJlIGRvbmUgaW4Ka2ZkX2ZpbmRfbnVtYV9ub2RlX2luX3NyYXQuIFRoYXQgc2hvdWxkIGJl
IHRoZSBvbmx5IGZ1bmN0aW9uIHRoYXQKY2hhbmdlcyB0aGUgZGV2LT5udW1hX25vZGUuIExpa2Ug
T2FrIHBvaW50ZWQgb3V0LCBldmVudHVhbGx5IHRoYXQgc2hvdWxkCm1heWJlIG5vdCBldmVuIGJl
IHBhcnQgb2YgdGhlIGRyaXZlci4gQnV0IEknbSBPSyB3aXRoIGtlZXBpbmcgaXQgYXMgYQpmYWxs
YmFjayBpbiB0aGUgZHJpdmVyIGZvciB0aGUgY2FzZSB0aGF0IG9uZSBhIEdQVSBkb2Vzbid0IGhh
dmUgYSBOVU1BCm5vZGUgYXNzaWduZWQgYnkgdGhlIGtlcm5lbC4KCkJ1dCBpcyBzZXR0aW5nIHRo
ZSBkZXYtPm51bWFfbm9kZSB0byAwIHJlYWxseSBuZWNlc3Nhcnk/IERvZXMgYW55dGhpbmcKZWxz
ZSBpbiBLRkQgZGVwZW5kIG9uIHRoZSBkZXYtPm51bWFfbm9kZSBiZWluZyAwPyBUaGlzIGZ1bmN0
aW9uIGlzIG9ubHkKc3VwcG9zZWQgdG8gZmlsbCB0aGUgcHJveGltaXR5X2RvbWFpbiBpbiB0aGUg
Q1JBVCB0YWJsZS4gU2V0dGluZwpkZXYtPm51bWFfbm9kZSBpcyBhIHNpZGUgZWZmZWN0LiBJZiB3
ZSBjYW4ndCBmaWd1cmUgb3V0IHRoZSBjb3JyZWN0IE5VTUEKbm9kZSwgd2Ugc2hvdWxkbid0IGp1
c3QgZ3Vlc3MgMCBpbiBhIHdheSB0aGF0IHBvdGVudGlhbGx5IGFmZmVjdHMgb3RoZXIKcGFydHMg
b2YgdGhlIGtlcm5lbC4KClJlZ2FyZHMsCsKgIEZlbGl4CgoKPiArCX0gZWxzZQo+ICAJCXN1Yl90
eXBlX2hkci0+cHJveGltaXR5X2RvbWFpbl90byA9IGtkZXYtPnBkZXYtPmRldi5udW1hX25vZGU7
Cj4gICNlbHNlCj4gIAlzdWJfdHlwZV9oZHItPnByb3hpbWl0eV9kb21haW5fdG8gPSAwOwpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
