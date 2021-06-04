Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C372AC07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 08:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90CFA61404
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 08:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CFA61404
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 393E66F5DB;
	Fri,  4 Jun 2021 08:35:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CFD86E97B;
 Fri,  4 Jun 2021 08:35:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCoL/kf2sBbXFfFiqkExHMOVqDYEgvox8clEDbU+fWsLKlDkbGH0lqqc/HO1PKYlJzEwLequxevBhdx0NW278ttMFOjDg+BMUr6Lwm6SFZQRd9PldL462sxK7Y/OJ4GNLVwU8VM0ky2TzkxaT5L0UhBLNC9i6UzEv0vtKYZYBftXddNEpnHpioJBSBMCQBuOY6BY+Bello/TUgT+4hjverYKDYT98XJ0RDd6P6aj9u8WT+2Hw6i9nfFqs83sNjrkOwLY4+sQ5/w+jm3e7YR9ZduOKwNpmU5F7ds5SPPsd4FG41TfZy22vCWbhIAYr6rc6kdjg7pjol4ZR/vh2oqwdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVIsiyNTi/CzBASnSvckYnwI40nRWhrvL9or+RJpgzg=;
 b=KRaV8dCovsX/VATA7nt+kBbDDWkh/SzakCtyVYbzEoo3wa1BDBBK1vrR29mQhZpfNdk3B8MwvV0kfJQzAxgArAAgo5ZXDjOMxpV2pxZ6iOi5kSvhGsbuKovmjgaZ+gfTYwgGUnsRPgV/dhfsegtuaY9KqZ/QYKUmU1XNgNgs2hxZ0KnxNiIjEXBmc4sv+sQaWR7b0R2pdF1mZI5xIPJUnH6TLEn30SLAfDGm1lT8DBbIJmn+c4J1QEAGuj5XJf8yVOrQMEsNP0tWBXKsA9+J2WT7BZ6lFuVCnEfqXbovAri3z8tsD39ez1WmVFN2f5HMnVSKLlfQoG3LjT4S9JYKdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVIsiyNTi/CzBASnSvckYnwI40nRWhrvL9or+RJpgzg=;
 b=ZHqmA2jG412YUzMWpyRcH+mC7hxYT41LT/lzPkYPHhxJpg5Zn5y2IvjVWzgVPhsE8uXpTdVv+8t8dmnoNMtA2ibd7DOkwGvrKxJ2BLWB1oPs46aLtWpFBgvOvxg4TqzMfrsbr8WWhXgo2WVIfVfSwhSuBmcSDL650jU1JCGZ5CQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3678.namprd12.prod.outlook.com (2603:10b6:208:158::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 08:35:56 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 08:35:56 +0000
Subject: Re: [PATCH v3 2/2] radeon: use memcpy_to/fromio for UVD fw upload
To: Chen Li <chenli@uniontech.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <87o8cnfr3s.wl-chenli@uniontech.com>
 <87im2ufhyz.wl-chenli@uniontech.com>
 <0689a006-a0a2-698a-12d8-cb11156e469a@gmail.com>
 <877djacbfx.wl-chenli@uniontech.com>
 <c4941cb6-8c40-aad1-e61a-2786ba1ab225@gmail.com>
 <875yyuc9tt.wl-chenli@uniontech.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7bf7e03a-4733-bf66-4a81-ac712582539c@amd.com>
Date: Fri, 4 Jun 2021 10:31:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <875yyuc9tt.wl-chenli@uniontech.com>
Content-Language: en-US
X-Originating-IP: [178.202.40.45]
X-ClientProxiedBy: AM0PR02CA0202.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::9) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.137.54] (178.202.40.45) by
 AM0PR02CA0202.eurprd02.prod.outlook.com (2603:10a6:20b:28f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.22 via Frontend Transport; Fri, 4 Jun 2021 08:35:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e48312c8-5196-41d6-3630-08d92733c51b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3678:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3678358BE189C244613CF7EE833B9@MN2PR12MB3678.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VTj++Rls/sMf3vHIxX4I9hxKX7x3Fh0otbO6BjROPu0Wk07ZQtNu40DbJ30AvfvC8iDka0KwwL6R8RB+HqFZ5SbNMMXZrZFAZXKtev574H8DeFgY5CUbgFkkxwGezldRf8K5XrZ8PjgfHDcCXqYk7Vw1erS1Bnc+wJpgTb6lMN40huGocw8XJzKOz5g5B0fYaoVM2XlZQAMSgRgVIbBw+cOQvcMqasCoajt0TBxU+5GFHULJ5eIZ5XYL7pjCY9PBbS9JtIeoCvJx/kikoeaHIFZe3MXUZbVNzT7Rm3mn7GMqm+WjHcbZiAiXicIw9Jti1DDBIJieQ0BVmiKslOoA4OPUgcogwRM89uJGD8z7Kwtpz0yJbtewG3RTVQ+QMVb3IRHmE3ADkwzBAa/B5Ag+LRpizE0MZy1zZLkhbu6ex9JO8/GCYCc0GeJSuHZWgrlQ8IPXSh4UPwKjTE5jHCr8pJ/4VG59TdEwA/a6LdMBaMQHpEYpKTs1Czr00jb5Q7RRMLrtX87CxWjCslmIaIWKqx+NQNhDDbAQpOI39d3lyafTULWo5LtwVAPGelCM2qH3Um0FiDhCsAZReOmQMCg/okgqnR1otgm6jWQYxfn495sC7msgNOVtQDa0Hbiwwnj5XuSHJ17oQckzXj/z0glhUL7o+tQKqdg64nicsFwU1Q37hZ7BxLEK/Ysu1w7Q46in5CO1ggammdYGJrKnj6jEPfnGzYtbL3jknHHciNbfp6vt8VgklUXJxXi929a1EAC0QO/HFDHQvQeNg6wlrEqIvh1LE8Ve25dhWoqpBqT1xBY+BzvAB4YQLvPKzjFkOep1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(966005)(45080400002)(478600001)(38100700002)(83380400001)(2906002)(4326008)(5660300002)(6666004)(36756003)(16526019)(186003)(26005)(316002)(16576012)(66556008)(110136005)(66476007)(66946007)(31686004)(2616005)(956004)(8676002)(86362001)(31696002)(6486002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Sk9DZExjSzh6dzFBNkdjKzhLa09Td1hDN3lld1RPOVNqWVJidUhxT0RpNGh3?=
 =?utf-8?B?cW5uK1lPWXA1RUM0bEw2elJOenVENVJpc0lQbzZaRVdlZVZ4ZUJUclVKcXlY?=
 =?utf-8?B?TzkybXorbUhOczh6eGpjVFl3OXU4bXJ1WWlWTUFEUUF3UmtINjRNN2ZnVVE4?=
 =?utf-8?B?bTFUU0R4MFNieTNRSGhKT2tNVXhWM1RyRHBiQ0tXMERMRnJkWSt6VnN4YnJS?=
 =?utf-8?B?QkwrcHZQUnJzRGk2SC9pZVRKSnRMNzdoLzFMc2lyRmNoMTl5U0N5RjJGVFhp?=
 =?utf-8?B?NzcrcWtzWHB4UW1lRUt2M2pEY2pNdlRvNlNpNDFsZ2VmcjUrbGg4QzBEcjlp?=
 =?utf-8?B?VzZUcVFiSzk3VUdEeGhheVE0enh4Nm1mbnYzMHphZDlEM1JlN2p2eC8ycy9V?=
 =?utf-8?B?UUFYbG1YaWZhaEtuZTZsSmRzOFZuOU1Tcm5OeHRacVVSMWE1Z1JBUnJRYWdV?=
 =?utf-8?B?SHdzQUxPMkg3TXpieldOZzB4b2xmSkliVGcvUEcrMjhreHBNZVY0b2RCSkw2?=
 =?utf-8?B?UlpmWHU4VlllWlY4bU4zVDA4TVhrU1l3Q09VM2xKZFhrVWxaS1g3Yjl4SnlP?=
 =?utf-8?B?bTUrYzF1S3UvNFRhU2dtSzNKS1RJbVJpSzdRNnNUcEJkanF6Zjllc1IzYnNi?=
 =?utf-8?B?bWN1SnNnamNaQkVqNEpkYmI0VW9vbU9sRjJkNkdDOWNxb1BzbVh5eUl3aDEy?=
 =?utf-8?B?eE12NEpEdFFHK1d2VXBROG03cHgwa01HYWliSEtDUFp2clpFYnZuSFZDM3dY?=
 =?utf-8?B?d3AxUmxWUFBJd1k4Y3V2VXVFY1VYYTFZZG9vS055aVRyUExnNVA4Ulp0SGFH?=
 =?utf-8?B?VisrL1JkVTVReEdPWEJndkFSSlZLbFp1SmczVHF5U1p1djhLcEl4U3pZZTlM?=
 =?utf-8?B?RDlZekc2VEpOYm9SZ1UrVlpWeFZzN3FJczNNN0NFWWpkdG1ISG44ZjRZNW45?=
 =?utf-8?B?aWdSYWkzQlU5WjlkN1R4NkV5bDZwTE9POWt4VVZ3cWx6akxjc1NaWmhCUncr?=
 =?utf-8?B?RXFZVzBJWUxrZVlieXQ5Rk81TUFSc2VuK2xGTkJXb2l5QW5nMDN4Z1lQOGZH?=
 =?utf-8?B?VG1Eek1DQWhWZXFtYm5SN2JORnpDMUZTZWdueDE3Sk1jS3psQ0YraHNycHF6?=
 =?utf-8?B?TytQYXRGZWZ4RUh3bm5TT1JPTFc2cXZDaHhYL1FFOVRHd2xrdTlnc0JtRnNL?=
 =?utf-8?B?bTlqdzNnS3BjR1EyMm9ra3V4UXExVjVCeUhrV3BHZWtOd0dyZGttSEpPa2VC?=
 =?utf-8?B?V2V5UWJFa0VUb2VTQTdvV0U3T1NLT3FCL0FMd3d5ZGJ4b1VHWW5ZblJaUmhL?=
 =?utf-8?B?RVZSbEFnRjFtQXBwcDNKNitNWVhraHdNNzRieUVoa25jQVBpMkxJVmI0eDlm?=
 =?utf-8?B?clVNODJQMStYcU5mNHRIcThIQVc1Qy9MSHN2ZVVVOW41UFptSFFYaFBacktP?=
 =?utf-8?B?NGxlSktJR3NYaXJxTUg3UmtRMHRKcFk2SDhUaXJsMHpucEwrYTg5M05sdStR?=
 =?utf-8?B?cWw5TUhIRHFhSkJGcUQ2Rm91SFFZamVvOFltT1dqWWVtZ1hkUUF2T0tsZHhx?=
 =?utf-8?B?OUFVUmxrZmhraHFlV1MzNVNTUkF6N2hQS1pSQWZ0bzNybkZDUVJHMnhQUzdD?=
 =?utf-8?B?cUQ3Tmw0T05Oc1FTWHhkOTJqcHBHWVJOd2VRTkV1aDFLL1c5NHA1L1ltRUti?=
 =?utf-8?B?M1Yyc0Fyek8xbG1zakZwbnczVThlS2F6THdNckh2SCtraDBnVTZobitDcDBt?=
 =?utf-8?Q?9gEnrbBHnwvpv4pceG/ArffgWbanrXpQTjTgjaL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e48312c8-5196-41d6-3630-08d92733c51b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 08:35:55.8033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fHCiTFuWqqAhYrJCagqJFNFTpU5ciWOqMUgiR6rz3KNQxwEmqdZjDnhskJ/bmTZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3678
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAwNC4wNi4yMSB1bSAxMDoyOCBzY2hyaWViIENoZW4gTGk6Cj4gT24gRnJpLCAwNCBKdW4g
MjAyMSAxNjowODoyNiArMDgwMCwKPiBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pgo+Pgo+PiBB
bSAwNC4wNi4yMSB1bSAwOTo1MyBzY2hyaWViIENoZW4gTGk6Cj4+PiBJIG1ldCBhIGdwdSBhZGRy
IGJ1ZyByZWNlbnRseSBhbmQgdGhlIGtlcm5lbCBsb2cKPj4+IHRlbGxzIG1lIHRoZSBwYyBpcyBt
ZW1jcHkvbWVtc2V0IGFuZCBsaW5rIHJlZ2lzdGVyIGlzCj4+PiByYWRlb25fdXZkX3Jlc3VtZS4K
Pj4+Cj4+PiBBcyB3ZSBrbm93LCBpbiBzb21lIGFyY2hpdGVjdHVyZXMsIG9wdGltaXplZCBtZW1j
cHkvbWVtc2V0Cj4+PiBtYXkgbm90IHdvcmsgd2VsbCBvbiBkZXZpY2UgbWVtb3J5LiBUcml2YWwg
bWVtY3B5X3RvaW8vbWVtc2V0X2lvCj4+PiBjYW4gZml4IHRoaXMgcHJvYmxlbS4KPj4+Cj4+PiBC
VFcsIGFtZGdwdSBoYXMgYWxyZWFkeSBkb25lIGl0IGluOgo+Pj4gY29tbWl0IGJhMGIyMjc1YTY3
OCAoImRybS9hbWRncHU6IHVzZSBtZW1jcHlfdG8vZnJvbWlvIGZvciBVVkQgZncgdXBsb2FkIiks
Cj4+PiB0aGF0J3Mgd2h5IGl0IGhhcyBubyB0aGlzIGlzc3VlIG9uIHRoZSBzYW1lIGdwdSBhbmQg
cGxhdGZvcm0uCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogQ2hlbiBMaSA8Y2hlbmxpQHVuaW9udGVj
aC5jb20+Cj4+PiAtLS0KPj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3V2ZC5j
IHwgNiArKysrLS0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFk
ZW9uX3V2ZC5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdXZkLmMKPj4+IGluZGV4
IDg1YTFmMmMzMTc0OS4uNTVhYmY5YTk2MjNiIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9yYWRlb25fdXZkLmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24v
cmFkZW9uX3V2ZC5jCj4+PiBAQCAtMjg4LDcgKzI4OCw5IEBAIGludCByYWRlb25fdXZkX3Jlc3Vt
ZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldikKPj4+ICAgIAlpZiAocmRldi0+dXZkLnZjcHVf
Ym8gPT0gTlVMTCkKPj4+ICAgIAkJcmV0dXJuIC1FSU5WQUw7Cj4+PiAgICAtCW1lbWNweShyZGV2
LT51dmQuY3B1X2FkZHIsIHJkZXYtPnV2ZF9mdy0+ZGF0YSwgcmRldi0+dXZkX2Z3LT5zaXplKTsK
Pj4+ICsJbWVtY3B5X3RvaW8oKHZvaWQgX19pb21lbSAqKXJkZXYtPnV2ZC5jcHVfYWRkciwKPj4+
ICsJCQkJcmRldi0+dXZkX2Z3LT5kYXRhLAo+Pj4gKwkJCQlyZGV2LT51dmRfZnctPnNpemUpOwo+
PiBUaGUgY29kaW5nIHN0eWxlIHN0aWxsIGxvb2tzIHdyb25nIGhlcmUsIGUuZy4gaXQgaXMgaW5k
ZW50ZWQgdG8gZmFyIHRvIHRoZSByaWdodAo+PiBhbmQgZGF0YS9zaXplIGNhbiBiZSBvbiBvbmUg
bGluZS4KPiBJdCdzIHJlYWxseSB3ZXJpZCB0aGF0IHRoZSBwYXRjaCBiZWZvcmUgYmVpbmcgcmVw
bHllZCBoYXMgbm90IHRoaXMgY29kaW5nIHN0eWxlIGlzc3VlIGFuZCBkbyBhbHdheXMgaW5kZW50
IHRoZSBzYW1lIHdpdGggcHJldmlvdXMgbWVtY3B5KGluIGFsbCBvZiB2MSwgdjIgYW5kIHYzKSwK
PiB5b3UgY2FuIGNoZWNrIGF0IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0
bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnBhdGNod29yay5rZXJuZWwub3JnJTJGcHJvamVj
dCUyRmRyaS1kZXZlbCUyRnBhdGNoJTJGODdpbTJ1Zmh5ei53bC1jaGVubGklNDB1bmlvbnRlY2gu
Y29tJTJGJmFtcDtkYXRhPTA0JTdDMDElN0NjaHJpc3RpYW4ua29lbmlnJTQwYW1kLmNvbSU3QzNm
YWYwNjFjMTliNTRhNjhlNzI1MDhkOTI3MzJjZDVlJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJk
OTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzU4MzkyMTQ1MDQwNjE0OCU3Q1Vua25vd24lN0NUV0ZwYkda
c2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dp
TENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT1iMDcyNk9Sd3llTFFzS1Z6cWpmWkVNYVU0
Vmk1NDNzenBGWW9IZWtQTUlVJTNEJmFtcDtyZXNlcnZlZD0wIENhbm5vdCBmaWd1cmUgb3V0IHdo
YXQgaGFwcGVuZWQsIHNvcnJ5Lgo+Cj4gSSdsbCB0YWtlIG1lcmdlIHRoZW0gaW4gc2luZ2xlIGxp
bmUgaW4gdGhlIG5leHQgc2VyaWVzLCB0aGFua3MuCgpJdCdzIG5vdCBtdWNoIG9mIGFuIGlzc3Vl
LCBqdXN0IG1ha2Ugc3VyZSB0aGF0IGNoZWNrcGF0Y2gucGwgZG9lc24ndCAKY29tcGxhaW4uCgpD
aHJpc3RpYW4uCgo+PiBBcGFydCBmcm9tIHRoYXQgdGhlIHBhdGNoIGlzIFJldmlld2VkLWJ5OiBD
aHJpc3RpYW4gS8O2bmlnCj4+IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4+Cj4+IFJlZ2Fy
ZHMsCj4+IENocmlzdGlhbi4KPj4KPj4+ICAgICAgCXNpemUgPSByYWRlb25fYm9fc2l6ZShyZGV2
LT51dmQudmNwdV9ibyk7Cj4+PiAgICAJc2l6ZSAtPSByZGV2LT51dmRfZnctPnNpemU7Cj4+PiBA
QCAtMjk2LDcgKzI5OCw3IEBAIGludCByYWRlb25fdXZkX3Jlc3VtZShzdHJ1Y3QgcmFkZW9uX2Rl
dmljZSAqcmRldikKPj4+ICAgIAlwdHIgPSByZGV2LT51dmQuY3B1X2FkZHI7Cj4+PiAgICAJcHRy
ICs9IHJkZXYtPnV2ZF9mdy0+c2l6ZTsKPj4+ICAgIC0JbWVtc2V0KHB0ciwgMCwgc2l6ZSk7Cj4+
PiArCW1lbXNldF9pbygodm9pZCBfX2lvbWVtICopcHRyLCAwLCBzaXplKTsKPj4+ICAgICAgCXJl
dHVybiAwOwo+Pj4gICAgfQo+Pgo+Pgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
