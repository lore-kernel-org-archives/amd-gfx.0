Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85B6C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 20:20:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A6C965272
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 20:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6C965272
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38D396E876;
	Mon,  8 Mar 2021 20:20:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 673186E876
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 20:20:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FH7iDiuNFNr29LWYhMeqTZHzbc6rAcCSEPbAwHbiBgTv0A6Z6LlD9htAEtRrKNatKEvua5ZizmhpZEGijBRu0XO1NpQm97bXh7V/8zaNRax5CKowZiBJAiC8k9gaQEXSGE/JqIN7k6E/u4rvUbkAYgy4vFUtEyoQeyDEjBOltFC0qfC+QsjQbm0YMy6iOUxbymZOQ9wzae9+DyfLyxcMSEqfE3lU+nc4RUhPmTBM0t208Rs1jjzjxA8t9N8W0rn+34okmmIzqMJNjx5nIC3huPFD7xRx5unxl00HN2efaoYxg1KwYSqz6donSDI8G6DX7h7INMJnshRhfT20WKAiIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uusCaYo6MvRnge4pT7qMACOw6l+p/mFsFpwhxge4VA8=;
 b=YHVY4DnH9HRPuT+SYtmKI0+tLCPHfvcfSd9C4SW7OnC6FSoTR5JdNyGM+S52gLfwqCWQgqtKJ+bID8AJrTaoPGPXhHkTNFd3MnG0sbKi3Ju2GeL4nKMnZpTiwIF9HtdUQrkWammkA/3YtH9EtPcaIDFuCYbVbsYGHisZ4l4IEoktp+sjraw7eBG/5nxrlGJ+XkRQUmLI8fJyQrrs+rhjVez8Voq4flq4woqOJO7Fr7gvxE2ES1Sx0GZxhRGXM+LFTxRJ7fjG3Vo6HWgMIhN9+AmUNFTO2tsILeaUdBz0gRzsLcsybXO4mxzHKfWUCpEjX1lSbzM87q3xF6vKtgapEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uusCaYo6MvRnge4pT7qMACOw6l+p/mFsFpwhxge4VA8=;
 b=dsLI3ro1ZeQVNVNFkW/2VtjYuiOXQV759+N5+B+nyAx+3WxQ2vVErgkUTMV7LZkWREgUo2dmpuxS0PZgfSk1xnM1oPm9kMhZ/AILvKx9FYvP73mKUe0wdPyWF+tgaKxCNbhMKZ1z0yTHjH5gwGPhyKduf0yMVUjv7o1vb1r9mZU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4334.namprd12.prod.outlook.com (2603:10b6:208:1d1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Mon, 8 Mar
 2021 20:20:46 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 20:20:46 +0000
Subject: Re: [PATCH 3/5] drm/amdgpu: fb BO should be ttm_bo_type_device
To: Nirmoy Das <nirmoy.das@amd.com>
References: <20210308153705.37414-1-nirmoy.das@amd.com>
 <20210308153705.37414-3-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <409b3da2-1f31-89f8-be28-0fb7854d594d@amd.com>
Date: Mon, 8 Mar 2021 21:20:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210308153705.37414-3-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a01:c23:6c03:dc00:772e:c5dc:d360:4620]
X-ClientProxiedBy: AM0PR10CA0012.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::22) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a01:c23:6c03:dc00:772e:c5dc:d360:4620]
 (2a01:c23:6c03:dc00:772e:c5dc:d360:4620) by
 AM0PR10CA0012.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Mon, 8 Mar 2021 20:20:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ea73ee2-da0d-4033-2e97-08d8e26fa7da
X-MS-TrafficTypeDiagnostic: MN2PR12MB4334:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4334A95A04603C01F0EDCB0B83939@MN2PR12MB4334.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JLPH27i1C2yjYVqvMPnGLe3sVJ2N7LT6xK4q5kIc1raYEA6H3MzJEhLRLPDfN9yaOfpOKIkY8pcFA+YlP2YaMUZErkYhA+G7HFqyhA/VIzBN1Tdan07t/WHni/qGuh8Q0qng/bY1mSuwizlS+8vUTWKaDAjyUVhtpyDctan8Z6IpU4tPAizRimevTytnOqZ0mk03psDdC74GlyZOF2UqsQSuuNpy3M6gyxKa2HdvoetBU+ZlvlHODiZkeBFEPHfPdxnQyzgcbj6Tfy8bQTalwTjsVenmHMK1UzrcZu0SYRIcgNSoB06rNZK/LS96yER1QWyzWbiwpRflteEnoGL/rmCIEhICE9uCE/lQb86OixG7nWziPA8ZvndN0YUlaKyNns2iAExnyKV1Cu7Pdx8OIH0TgWbQtkj+VacMSrEp/u8ynk+KD0yI4yysaU16mhZKhlM0BhNOkG+P72fH6tATHV0EaMNbx2yyItZm63hiwXBr9gnz75TNQ/1a7bhZomh3ZMPJSkl6fWtsfBBkwHBmfIXYj+eb3uBm3vcaK39CdaNUCX+IKu415k677e7DzSt3pjhli4B1n7+h7Ko5kF0bRthizWhEC57gRinzTcpLEaQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(2906002)(2616005)(8936002)(8676002)(31696002)(6862004)(83380400001)(66574015)(66556008)(186003)(16526019)(66476007)(5660300002)(52116002)(316002)(4326008)(6636002)(36756003)(66946007)(37006003)(31686004)(86362001)(478600001)(6486002)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MkpSUFlwL3prcWtzeEx3ZStYNGFPU2UzMFRzL3dmN3hSaWlXWGtkK0t4dndj?=
 =?utf-8?B?clZwTEVqeUF2YjE1R2dKZ3NnMEpYdWNENGk1VzBBRWZ0R3RTWVNsZ1FXckJZ?=
 =?utf-8?B?R3VjRm1HL3JsN3g1QzNObzN1dHV0LysybHBnNjBHWTJXZVZMclMvclpPMEQy?=
 =?utf-8?B?cXFGeEhNQUt1NnFmSjdIWlhzUDFyMVhCbG55Q0s4bUE4SVJOOHljRi9xMFJi?=
 =?utf-8?B?bFl5Qk5UQWFCVUVoZnBRK2UwZmt6SEZlU293WkJtUUxQMHJ0ZDc0V3hNTU8r?=
 =?utf-8?B?SzFJV1hGWk45eVNSRlh0OU0wUDZoM1JTSkpKSXpzN3N4QzFmMWd4eUtYNW8y?=
 =?utf-8?B?dG9TOHJqUU1LWktkQ2dBMUo4NG9Xd0ErN3Aza2E5UkZFa1dUOXBER2JYcmtB?=
 =?utf-8?B?V2FYeVhCWWxnbEgwZVkyWXpETE5kTXEzKzJFU3BjZThtUWVLMjYrNFZaOERZ?=
 =?utf-8?B?akpianp6VE81dmVudGt5Z3kwTUZqUnlBY2thVG16SVY1OHRGQllXeHdjdlVC?=
 =?utf-8?B?SkhPdUhteVJEZ3U0YlRYUWdSaW9wVmVwUk4wUGswSTgxN0pJTnZ6VkxMQVJv?=
 =?utf-8?B?S3Q2V0ZJYmdzbm80RlJ5SllOdXFxVW0rbWVlaUxGSVZTNHpvTVhOc1hSVHBK?=
 =?utf-8?B?bERzUnBRKzhQYWQ1Zm5OQTh5SFpxVDg4ZExXdVY3VVlMNmpUR1pLVDFjeVo3?=
 =?utf-8?B?SG9ERnB1UmlmVlRySDZzamY0bFBFenU4TXB4VDZVeU1SV1E3OTNYNFE0dXNQ?=
 =?utf-8?B?amFRNnFMYTJYckgzSmxPbnVUSXU0OVBuSkV3Q3BLRlpOMnptSDEwZmpiV3NT?=
 =?utf-8?B?SGFJY2NGY3hQMVBTV2dRT216bGNuOHpscnMyNjVoWTB1WWczSHNPRnd5cHV0?=
 =?utf-8?B?Q1NLdU1zSGJ2L3dIL3kvV0ZTYmRvbkFaRE4zbWRSRmhOSDhGOWYxVmFIb1RZ?=
 =?utf-8?B?NFZ6WHhPRUNSeXlVS3gydzVYQlNwTGVqenZxcVpFOVo2VTJwazY3LzhXeGJ5?=
 =?utf-8?B?NSsvV0FQbnZpTC9CN0dhbTB6Yzl1b2VNdHpnTjlvN3hoT3VFSlpCWnZDMnAr?=
 =?utf-8?B?bkk2blFlTmZGOHhRVEl4dUliK0oxTHNGMzJaVmxsbldOV1hoMDZrbU5ER28w?=
 =?utf-8?B?Zkl5SzE2VC9PR2RxdkVtc3p5SzRTbmM2SFROMzl5d3VMK0FPT05sb05yMUdo?=
 =?utf-8?B?TzJRODUyRk5UUnNFVm9ab0VHdnJ5UlFtU0RmUnNFY1p1NlJET0drVU1DbVZX?=
 =?utf-8?B?aHdnNU90ZFppeGtkVk41aFRnQll5RmNFTXM0bVpVWEJkb2RFeWNvdUFjWlln?=
 =?utf-8?B?Qk1iS01BNlBpVUxwS1dtM0Rob0ZYcHV6aTBadGJkVVEzc1UxYTM2UDF3SUxW?=
 =?utf-8?B?TWxrQ3JrMHUvMmR2eCtKbXJGUGNtTUF5Ri9XeGo3aHA5dTVteFd6Rm9LUHhT?=
 =?utf-8?B?ZElVbkRVZUVIYldKaVhrSnl6cEl1d2xnWVEwVnVNVlZOM1A1OTVXMjc1QUxC?=
 =?utf-8?B?cmlxK0tRZFF1VENETE54V3FFRXlFQzJZWVdPQ2ZCZDllUk9JUXp1VEQ0ZXps?=
 =?utf-8?B?UEhYMU1FTkZpekhsc2tuc1RTbzF0QXl4U2tuQkFIaWJhbzRRNU9Sb29SK3FT?=
 =?utf-8?B?NG1xWFZYc3oyc2RMMW42TWk3MnlOa1ZBK0tLWFprWXVvbS9aQ3lsOXBKS3d5?=
 =?utf-8?B?Qk9qeE44MG9vODI2QmR2ekZ5cDREQnVCa25IZlFjYnNnUDFaYm03Ny9CSURW?=
 =?utf-8?B?bldmUERpY0RpSkF2andWblUrY1JmTUhLNTBhaS9TY2FjRGJnWWUxbkcvSnFT?=
 =?utf-8?B?VHFtaHF2MjBQdkZ2WHltUTlMZnNGRWQ5eWJ1OFEwTXFaR0xOeWV5N3c4QmFZ?=
 =?utf-8?Q?vAruxX07dAIqP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea73ee2-da0d-4033-2e97-08d8e26fa7da
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 20:20:46.4502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qAgP6kCeCzYPhvTvBXX25Qufwa76YAvK2JEzWp46/J+kUeMRIz2folnOJBeI2c1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4334
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDguMDMuMjEgdW0gMTY6Mzcgc2NocmllYiBOaXJtb3kgRGFzOgo+IEZCIEJPIHNob3VsZCBu
b3QgYmUgdHRtX2JvX3R5cGVfa2VybmVsIHR5cGUgYW5kCj4gYW1kZ3B1ZmJfY3JlYXRlX3Bpbm5l
ZF9vYmplY3QoKSBwaW5zIHRoZSBGQiBCTyBhbnl3YXkuCgpNaG0sIHdoeSB0aGUgaGVjayB3YXMg
dGhhdCBhIGtlcm5lbCBvYmplY3Q/Cgo+Cj4gU2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8bmly
bW95LmRhc0BhbWQuY29tPgoKQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZmIuYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9mYi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZiLmMKPiBpbmRleCA1
MWNkNDljNmYzOGYuLjI0MDEwY2FjZjdkMCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZmIuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9mYi5jCj4gQEAgLTE0Niw3ICsxNDYsNyBAQCBzdGF0aWMgaW50IGFtZGdwdWZiX2Ny
ZWF0ZV9waW5uZWRfb2JqZWN0KHN0cnVjdCBhbWRncHVfZmJkZXYgKnJmYmRldiwKPiAgIAlzaXpl
ID0gbW9kZV9jbWQtPnBpdGNoZXNbMF0gKiBoZWlnaHQ7Cj4gICAJYWxpZ25lZF9zaXplID0gQUxJ
R04oc2l6ZSwgUEFHRV9TSVpFKTsKPiAgIAlyZXQgPSBhbWRncHVfZ2VtX29iamVjdF9jcmVhdGUo
YWRldiwgYWxpZ25lZF9zaXplLCAwLCBkb21haW4sIGZsYWdzLAo+IC0JCQkJICAgICAgIHR0bV9i
b190eXBlX2tlcm5lbCwgTlVMTCwgJmdvYmopOwo+ICsJCQkJICAgICAgIHR0bV9ib190eXBlX2Rl
dmljZSwgTlVMTCwgJmdvYmopOwo+ICAgCWlmIChyZXQpIHsKPiAgIAkJcHJfZXJyKCJmYWlsZWQg
dG8gYWxsb2NhdGUgZnJhbWVidWZmZXIgKCVkKVxuIiwgYWxpZ25lZF9zaXplKTsKPiAgIAkJcmV0
dXJuIC1FTk9NRU07CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
