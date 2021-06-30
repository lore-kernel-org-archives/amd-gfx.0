Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C155C11F66
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 22:44:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496EF610E5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 22:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496EF610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E93E56EA8E;
	Wed, 30 Jun 2021 22:44:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF2256EA8C
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 22:44:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQ0VQEUMkNnUC0GfMoQh/ZamX06Qlq1bfOKKhyrxDFGeHlHt1Gk0zlLJB77NiSro5T2DS6MkNEAFf+V+8vGthL35yymtU7q13ahrErCkzL6N93m0lKODx0AM3p+4NEXMGLupSgFeXQO5I+Vdp7FfMTAbO9ZWs1lzqqj9wcqiY4c7TpMGVsiXNVDBLkrzNJVg0/DBvV44/+9nRLVCGsIU9NEDjTfj5K51bv7eMqT4KfEBlMUVcxzKSYEjE8LyXbD27pkkdi0ThTTiUzLhyzPZO2bmM9TOMZdn7UjhS4n224aNGKy/PgPpiUTqSEPcsZmi/0fS4V9ohHj4O0HnsNeiug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4w2vesFDyOCYc8xUPoata3QErOyeIWuY07WnP251Rp4=;
 b=KdEcSzYn+M7o0w8w4EfNweqtaKYAL2W0NwmJIItywI159Ff6wtJcL5Ef/D4cuO2TeX16k2Vz5aAu+9BIJDvRUEPojRuBTkgTWbQQTBvvg/n783zhmbmD5QzAq2i6GPgGAT/58a9Z3LDsIyct9Ed7NfiO4oTCrsCwWpyB8iXW3p78PJsui4nT7ND+M92A0wqc3ogyEbTKNfYpMG0XqVwTsJPzL2q1AS1tB/KeMEemdQHHJrzD0qDAYAMzxPKAnd+9rZ9UX/6Vuq8bcqLhBxRB/n1pLrYbq7/DsA0mUqTsCS2MitOrotPHvtqUFd3sgKQfGtcKFhd2GKb7bzCBv+z7MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4w2vesFDyOCYc8xUPoata3QErOyeIWuY07WnP251Rp4=;
 b=1p9+YP07BqrTrZabcBZdhecym0s3+mlECr+4SQyREr4cpNMlOibComHX4sx1HPfiQTcIEC6714lMGdmGSrecrGTGGQqMv+iwYROGPLQtWTmC3+dRNASirEBvJwBfYPXYy2tdX6aVWvM8A8OV1Ht+WpegGH5DoYNrXNT9oeAz5Ek=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5260.namprd12.prod.outlook.com (2603:10b6:408:101::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Wed, 30 Jun
 2021 22:44:32 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 22:44:32 +0000
Subject: Re: [PATCH] drm/amdkfd: Only apply TLB flush optimization on ALdebaran
To: amd-gfx@lists.freedesktop.org
References: <20210630220331.62246-1-jinhuieric.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <1d701acc-eeeb-da70-5211-10aed38d1157@amd.com>
Date: Wed, 30 Jun 2021 18:44:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210630220331.62246-1-jinhuieric.huang@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT2PR01CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::28) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YT2PR01CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 22:44:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08efe699-a4ad-4d92-ed4a-08d93c18a080
X-MS-TrafficTypeDiagnostic: BN9PR12MB5260:
X-Microsoft-Antispam-PRVS: <BN9PR12MB52609A773D53F7E770B8BFE792019@BN9PR12MB5260.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gVJ6BWWqI14zXum0b4dSZqhOU1BnZSs20OMcX+Q+lwWr1QoWAi9LxBrpKIivEo0JVaBfBZ+tmpLNfGWIxb8b6cQJH3gcu6iOow60aEeFqi9tEMVDyVz7BBnxhoTpsRUki4s90hhJbgwviZMEbrH4Kq0Q7jBDIzlpoks6IbHTAeJjWB9jO9CPNJetVtLxrwbVJ5XnzEfUh6fSGW8FCbAGVTNK+/UnvABZtUp/4m3Ko1qluYq9ucvh0mRhfQFjxxRvf1N+TNHmAQDqgs5JmBJtxMnEYEr0KStkVqKsxKwtUAcvrL5uUMYuSphuJtrip1SbYaLFLZ60SYy5gg7yPoZoTV7FQHw6OdOq+ljqu2rcnnpoLvKNYgrs84uHEKNYh1zacWz5VTYouK5MpLlJWopBIpZ4fOqonG6qfTHzvocjF4xEnqxCdEU6tCnoPdI9w8rfnKWhwImIUKOYp6/urE+OabtbIAM+3VxcnBdVvkLFw5s62FoaJ72ThJ8cEXhiIOp7hp+MDTT7F8VKcB5vAhpSXObeIOlo7HbliJV0WiqOvPGyU4OW3IKC7C2Lcupnkk0ZvO+i3u7jvyfy4Zm5sIF6uYp8qRpYgwdIWFKizKMs0Jpida7Z1mv3ge6sCjn+JCIQrM5WLA2NLtEk4KAK8MT06nC9BrCfdmk7qnX2fNKWKZTaLA6cvflfG4IXCMX3aq31Oz8vHnGQg9F9uV+jlcuhbdNqBdIfyMutPazHmgROjbk5/TBdxYxMUZviyvieN2G3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(44832011)(38100700002)(2906002)(83380400001)(316002)(478600001)(6916009)(26005)(2616005)(8936002)(53546011)(16526019)(186003)(31696002)(86362001)(36916002)(6486002)(36756003)(956004)(16576012)(31686004)(66946007)(5660300002)(66556008)(66476007)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0x6SmhGeVdvQ2Jad2xZM3NLaERXakpLWnI2dSsxdEFIbUlRenp5czBWWXA5?=
 =?utf-8?B?VEQybCtKaVoxejQwVXFac0pJNlRjdTMvRVhzRGg3UVFQaytOZ0xVamo3RTg1?=
 =?utf-8?B?VEZtMEp1Y1IzUjhwOEhxaWJHMjlzRktKWjB3blhpY1ZzUmZaeS9zUUdqcHBU?=
 =?utf-8?B?cUZpVG5ubUx6SDBMaVZJTkt0eGJ3cnlkUFowYjl4OHA5cWx4bExPZEtOVU4z?=
 =?utf-8?B?aW5PNlBLMWNCaFZ5RFZYd0ZJNS9kMW5YYVp3aUR2VmNUMXV4ekZTRnhZSnFY?=
 =?utf-8?B?K1ZrT3JzTVp3QVErSlhlVXlUbi9tN1ZjS0hKU2hpb2FJeFE5bmlGRVVlL3N1?=
 =?utf-8?B?emxFUEhvSXJ0N3F3cVlUZ1RsN1hGM1R6SnNaUkU4Z0pIZHFhOHF1aFNEekVk?=
 =?utf-8?B?ekptUk5XQU1pSWUwQ0FYWXRVUkRwZmlyeGxwblVKNGNSV3dVaHo2YzluSUpp?=
 =?utf-8?B?b2lZa1NHNEFkTWM2aTBtWjFkaEpvS3lYZ1hlblpETDM2Mjl5UDBUWTcyUGhI?=
 =?utf-8?B?MlBDeXdHbnpoQVBuR1ZQb3J0MDUzQ29xRkpSUDhWQjBNUFRKYTZhdzhWU3Av?=
 =?utf-8?B?V1ZHeTB1MzE5VkFsTHh3akxadGU5ZFVLb2I2NFVTL0RUdndBTmpkbnA1NU0v?=
 =?utf-8?B?OUNmbFFROXJJMkZDQjhpWTAvOG9YZVVhUjlhWC9SSXNxck5qS0hndTAxcGNV?=
 =?utf-8?B?ZjM3ZkVLVUg3SnZVcytiOWNqSE41ODBNZEhWTlFEbVh0Rmd3SXZ4TG8rTU5H?=
 =?utf-8?B?LytFWkNiZXJUelFCYmhicHh4aVpKcWFpbFF5b3dpWFhyYzkxTnhRRlZWVmN6?=
 =?utf-8?B?R0dkU2R4WGNXTS9qQzZESXArNnRSSzhNTWJWblJ6Rkp1cDBHOTlGb2tTbm5K?=
 =?utf-8?B?UTI0ZG1EVzJpY1VFSTBOOGU4dEM1Rzc3dkxXdm95Q29CcWJKbjVaVWZUSnI2?=
 =?utf-8?B?OFBDTUFmdUhSNVBYYVFFOGdhUEM0TlhLaURLVi9kODlRSElZamVhN3pBTnhW?=
 =?utf-8?B?VlRUQ2hCbkpHOXlISWVCK2ZXU0lZRlkzTE9VVm5DTkVmNDVhdDFUVmE1dENj?=
 =?utf-8?B?UXBDZGpmbEVDOHNDQ25xRUM0VUFHN1hodzRsdDJtdkxzVUR0cnlGUS92cC8v?=
 =?utf-8?B?eEVteXhSN3N4UXM2dms3b0Z5b2RDYWZ5UTYvRFZ4bnZnTWFXbFlIVndvVWVX?=
 =?utf-8?B?Z0h6cEhhV1lqWDNJbno3SU90NEJlL3NVblVWUStxQzAwNmsxWjd4TGZxL3J0?=
 =?utf-8?B?K3dYME9udHpnZXExbmRCNXdETUNic3FPcFBTczZCSE9Sbng0eWE0dXUyY0Mz?=
 =?utf-8?B?NFJXb05NUkpSeEtuYng1cVdveU1RS0tvNjQ2d2RzekU1QzQyM0NaUkFkdTV3?=
 =?utf-8?B?OUo1Rnc2MjM5c09zMDBuK010dnZ5VFFOakNTdUdyazZ5QlJJeS9EeEpnd2xT?=
 =?utf-8?B?UmdVRy9zcTNZRWJGRnZ6SG1BVkNadzg1REU2QWx3bWVTRy9EUnVWc1hZaGoz?=
 =?utf-8?B?c293b2ZoQnN3RGNZcGptUlFKRE1HcHVvS294aDFocm80bThQZml0eDdvcU5T?=
 =?utf-8?B?eGFnOEFyeHp5eks1UFE5Z3VwY20xNVBSUXNWaEsrRnIwSHNzOWp3TE1HZHJo?=
 =?utf-8?B?bFlFYjIyb2VMRzJsZnM2MEwzUHZ2NUJBb0ZMVEgvQlVPdzdFYmJsT0lZUG5R?=
 =?utf-8?B?Ly9kZlR2WHNSeXpMVGJ3MDN1RjNGTmVOcitFQzY2U2xIQ0VxQlJiNUtubmVW?=
 =?utf-8?Q?PH+AEQ4Y9ROL0YR6trVUNXidyxES/eXSM4UDtt6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08efe699-a4ad-4d92-ed4a-08d93c18a080
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 22:44:32.1730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1a19xemMtHNbUspqzgjre4lkr15zQd4Wb4YViG1CykuKRMWZdnK1964t2AX+FQvvBP+i56FrBQdBMVmInQhS0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5260
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

T24gMjAyMS0wNi0zMCA2OjAzIHAubS4sIEVyaWMgSHVhbmcgd3JvdGU6Cj4gSXQgaXMgYmFzZWQg
b24gcmV2ZXJ0aW5nIHR3byBwYXRjaGVzIGJhY2suCj4gICAgZHJtL2FtZGtmZDogTWFrZSBUTEIg
Zmx1c2ggY29uZGl0aW9uYWwgb24gbWFwcGluZwo+ICAgIGRybS9hbWRncHU6IEFkZCB0YWJsZV9m
cmVlZCBwYXJhbWV0ZXIgdG8gYW1kZ3B1X3ZtX2JvX3VwZGF0ZQo+Cj4gU2lnbmVkLW9mZi1ieTog
RXJpYyBIdWFuZyA8amluaHVpZXJpYy5odWFuZ0BhbWQuY29tPgoKSSdkIHByZWZlciB0byBwdXQg
SFctc3BlY2lmaWMgd29ya2Fyb3VuZHMgaW4gCmFtZGdwdV9hbWRrZmRfZ3B1dm1fbWFwX21lbW9y
eV90b19ncHUuCgpSZWdhcmRzLAogwqAgRmVsaXgKCgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYyB8IDYgKysrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX2NoYXJkZXYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2
LmMKPiBpbmRleCBjZmFhNWY4OGU2MzAuLmY4NTllZTdlOGMxMyAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYwo+IEBAIC0xNjU5LDYgKzE2NTksMTIgQEAgc3Rh
dGljIGludCBrZmRfaW9jdGxfbWFwX21lbW9yeV90b19ncHUoc3RydWN0IGZpbGUgKmZpbGVwLAo+
ICAgCQlnb3RvIHN5bmNfbWVtb3J5X2ZhaWxlZDsKPiAgIAl9Cj4gICAKPiArCS8qIE9ubHkgYXBw
bHkgbm8gVExCIGZsdXNoIG9uIEFsZGViYXJhbiB0bwo+ICsJICogd29ya2Fyb3VuZCByZWdyZXNz
aW9ucyBvbiBvdGhlciBBc2ljcwo+ICsJICovCj4gKwlpZiAoZGV2LT5kZXZpY2VfaW5mby0+YXNp
Y19mYW1pbHkgIT0gQ0hJUF9BTERFQkFSQU4pCj4gKwkJdGFibGVfZnJlZWQgPSB0cnVlOwo+ICsK
PiAgIAkvKiBGbHVzaCBUTEJzIGFmdGVyIHdhaXRpbmcgZm9yIHRoZSBwYWdlIHRhYmxlIHVwZGF0
ZXMgdG8gY29tcGxldGUgKi8KPiAgIAlpZiAodGFibGVfZnJlZWQpIHsKPiAgIAkJZm9yIChpID0g
MDsgaSA8IGFyZ3MtPm5fZGV2aWNlczsgaSsrKSB7Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
