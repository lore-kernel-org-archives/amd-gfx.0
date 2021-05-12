Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0526DC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 14:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EEF061411
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 14:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEF061411
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AC6E6E082;
	Wed, 12 May 2021 14:27:10 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2040.outbound.protection.outlook.com [40.107.102.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBBBA6E079;
 Wed, 12 May 2021 14:27:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jS5RAF8o5mrHr9N1fu1aZIRQlgsHFjuMpUIBEpCrTafHH6nTO8iNwazNVupEyg+Z79D/+vSIsGu1m3r89fX5I+IhbXULVTQsE8yrYarkAxW+1TubW0UWEKVGjd0vCSk0x8/vwne6mIBAgjx5Bre4g34nZZMXl3SCN7m/A8EBNTCGj1rKQxHEbstf8M9Ad3DlIsyDmL7I6eaAkxxvLyz49g1hMBkjVZRV/n84qQdene3obYb18Z+X/gezj4Dsf9Ocjha/tixq1AJEBlhSxvtjlgz+WxH1wKqpxSTPXaXJtZZBeIGqQgQK1IkiQGYqvfGb0lDNLUmxBUJMEFOLCaS5zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8CHomDLolHWYr6vXq3Rl7552WLkWchm5KRWiP0lHhI=;
 b=UnSgnzomTf/Uvl8LCWJAF8oEo6eEBA2sO2x7SFtS+1vI38X8KndCis4hf+v2rz13xOEuArVcKgmGjyDg7tzpvYROY48YaJrsr1TvqcGdHlj0DHP0Ol8OYKIBhWaFXj+uHr3OOWuAX7BOqPX30Ar3J4Zh96GUUSyR6cbB9JH76PCp4Xz5pG8B04he4T/9t7NWzxZ1g3Vg6ruhQEtJI2JJtyAAUC1N7q7aKYmIQ8mV4VjQvBX2Ox/uGerxuwYaDpVySADtxMYKEzD5Jfbhl8EzAisehQqPxEt2uwHU7Pfcal9xQoVndpsMf+9l50cfyz9FZPTHrfFlLwhh4MNp37ksHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8CHomDLolHWYr6vXq3Rl7552WLkWchm5KRWiP0lHhI=;
 b=MElGLQMI/LtmlnN1NF/t0kC4QD2NtiXxqxBhhdrWOULFfbiK/fsH5vywCJ685aaQBjt0ddVTOZunL924TRgNF+B1JIKxnwfAAp8Ax8pB4f67XlfCPp3P96c9nupCsSkrFzmVvbK6Jmii7DgxrgSBhb2h7Tf6DW4vqTPAqLFgGEI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Wed, 12 May
 2021 14:27:07 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 14:27:07 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
 daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
Subject: [PATCH v7 01/16] drm/ttm: Remap all page faults to per process dummy
 page.
Date: Wed, 12 May 2021 10:26:33 -0400
Message-Id: <20210512142648.666476-2-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
References: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
X-Originating-IP: [2607:fea8:3edf:49b0:7576:4f76:97d8:1487]
X-ClientProxiedBy: YTOPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::45) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from agrodzovsky-All-Series.hitronhub.home
 (2607:fea8:3edf:49b0:7576:4f76:97d8:1487) by
 YTOPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.30 via Frontend
 Transport; Wed, 12 May 2021 14:27:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 975d7753-45e7-4525-b5b4-08d915520562
X-MS-TrafficTypeDiagnostic: SA0PR12MB4576:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4576B7E47A621593392FF689EA529@SA0PR12MB4576.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: etRnEnff2z2ZPq+iDnCEn6lAqBYiED72ykSUMSeOX/aYUCJF4AXk1i7ykQgIsxkTepOwTquWwDGKf+7gqXiiAmZFoh49JBzhWijeuHaYXs9j5M9Pdw8gE6pO/Vfi6JOIvRg4JlR7xOJYo21sighKrL9ljmXzzdaPV8RTV8O+nHFNqPwSQZCjc707IhmJ5T/nuRYKQ6xcpUBjLTl8RFOYqQdwbQAw2PWRF1Kapok7nkTydnEqN1Sia66E58Or1L26RD+Wvz2c2Enbe6/hmqtesE0dSeWSFO+9xYMS5X1W0B/olq/7nCsFiP+yEKg6ZdMlUancXt5HV8oNKKgi7V/g5bieXor0dO94Nt1NMCs46ilMNak0U2D0hajIf8hGl2lU9G5jIjhxSjMvqY3Z3o1r9jF7WPK1qMnLZULUQkhOPeWUz3Mvslrjb5k6ZmWb73Q6BxqXpgObxJOjyPUyD6vyKCHDZ23CLSTvb6azTT12DzCCzIcddZGMgWrEWYfCfIPHMpxnRcBQNp8q3h17H+gkE5A5E9eqcpEb1nBccJwtWHOWETJzwhc1xobe7lRJbu62JehEKdbBieOlnN4v8hgQuDf7qCR8Fs99MWQT6m2A0NQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(66574015)(38100700002)(5660300002)(1076003)(6666004)(186003)(316002)(16526019)(8676002)(83380400001)(66476007)(2906002)(6636002)(86362001)(52116002)(36756003)(54906003)(2616005)(66946007)(66556008)(8936002)(6512007)(6506007)(44832011)(478600001)(4326008)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VTcvWktXN3FmMlJHMWYweVZOTlFvaS80L0NSdkdGRkhPdlVJaVRWeWt0clY2?=
 =?utf-8?B?OWExRFViUFR0WmYvaUxOTDFDcWh2cm5aamhVaXg3am5ranJUTTNMaCtXdXpo?=
 =?utf-8?B?aFh1QXJSanpJUW9qb1QralFTQmlWVzhKMVErLzdLUFFKbE5rb0Zyc2FaK01C?=
 =?utf-8?B?djcyd1VacFJDYS9uTk42YXBwK2FiV2RhbzlQNm8rWDNWVmE0d1pGSDZmTDA2?=
 =?utf-8?B?TE9JS2cvRXpJZStnNU5Gd2xuZ09EbmxLMnEyR1RVV2w0S0ExbzBWbkIvclll?=
 =?utf-8?B?eEprdndxem9Sa2F1R1Q5aXU1M0JmeGg4MUdUUDZ4ekNjc0M4NzFVM1djVnB3?=
 =?utf-8?B?bWZYMUlMUzF3bUFHazhMdktLcHlFaEpjWUphckVpZGVVazJjWkE5V1BweFU1?=
 =?utf-8?B?NlZUZVh3ekQ2b0hudWtCc1pUU3RWTjVXN2VJT2RKZXEyUnp3cHd6amtKRnlV?=
 =?utf-8?B?UWdqWk9IMXVxQ0l0R3VrVmNCczFvWkJyMndEamh0NVRaUld0ZHgyM2V5ZCtq?=
 =?utf-8?B?cU5oNmt2WFV0YUg5TXNFMFlod1pQQUpVSVRrVEtSbVR4aG9QVE4wVDZGQXdH?=
 =?utf-8?B?TVhBZUZjUk5GV2sxVkQ0MXhHK1Z0R0Q2S0orSkRpbDF2K3dTbEJRWkZocENX?=
 =?utf-8?B?cWNlWWZIb0tWR0JRSHNIY3dXT3FQUmNOSHpjQjYrOUltMWRmQ2pCMGZSWGVE?=
 =?utf-8?B?TGJiaEZ4eUw4U0xKdjhybkhPdFVmVDJJY1Z0cTBDUUxpdkU5TDBHTXBKWHNZ?=
 =?utf-8?B?a1BCRURmMmQxMGtFSzlLa1pYYWs3TzBZNllEUGxSS1NKOVA1d1RxSjFIdUxJ?=
 =?utf-8?B?YzBwemZTUkprc0tRalRSMEVBMFF2Rk9GQjFMZ3RtQitGenU0Nll2K3k1N3N1?=
 =?utf-8?B?T3UzM0FOL0pZeTRTOFZGZ2EyK0ZEYzJDWURoSUhNWFp6MEcxOTMyUnJzbUJW?=
 =?utf-8?B?cXRhOGpxS002ZSs4U1crTTVLVlNuUmtUdzNYNm91V255cXBXOXlCaE9FQ25B?=
 =?utf-8?B?L2Z1ejJzOUdKMGVkMU9HTXd4M1ZvUUFDL1lqN21RbmRjTUJqZzlhdC9vd0hM?=
 =?utf-8?B?bTRnYzBYZVVidlJ6aDV2bkdRVGZCSVRYVWNZSnhvQWpORnYrb1VNYmtia25W?=
 =?utf-8?B?TTR3R3ZGZ1VnVkJuVHFQNmM4OVhYcFAzVmdwcXpaS0h1YTJsS3RXZjdMdHRT?=
 =?utf-8?B?dnp3azF1dkh5bTZ3SnpxcHpnbXRBMEtFcmZCNHNFRWpzK3VZeXNicWk0MWRP?=
 =?utf-8?B?TTNVN2VUSG1COUpwZWdFcFRSYmloNld1cHRBWXlyK05xMTZDQmZBTFRiclFO?=
 =?utf-8?B?S2xGWnh3REdtQ2d4SEh1UUtid1VoVnNQUDZXM0k4ZFo3QlozbkN3cWMvRFNW?=
 =?utf-8?B?aXNXOU1GdklLQlpZVkxYam1xdFBCcC8reFAzK0FkKzhGL2diSGR6dE9LdkZx?=
 =?utf-8?B?Y2k0cGhIblhPZmFxSFg1dno0YVQ0NHpraUh6dnZyR1dLYWVDdXRjSXYvUkxY?=
 =?utf-8?B?aW9pa0NKcW5vOUFoL0w1Z3hNQ2g4MUNudVF5bThRWGNwcnJvSWdsWjFqdkMv?=
 =?utf-8?B?dUYyZmg2WFg1OVVEYlNQcnArL2s0aVhtN2tjNm5GM0w2eXYvMjJKbVNHL0Z5?=
 =?utf-8?B?QnA1NG9xc3VyTTBXMExkZXpENGFENkh0Rk9yU0hRd3V3Z1pRZVFBOWJGRTZ2?=
 =?utf-8?B?c3RFa0lJNzhPaFBDbVEyRWFuMGZENEtZUWg3TExJaFBXUEdTSk0xL1NUN1pQ?=
 =?utf-8?B?Sjd3dGlzY2tmZDlKT2pBMTNJVG0reHpCT3NTOXNRY1NaNmx1UUVTaUcxTjE3?=
 =?utf-8?B?dXJvd0NJd3hRK0FqdW05K2diM0FDcE42YUszRm1hemNMWGFpcHVyRHd6L2Nj?=
 =?utf-8?Q?Wxc41HIjO5NKi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975d7753-45e7-4525-b5b4-08d915520562
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 14:27:07.3141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdMMo6DCYooIsq5NApc7PlP9izUHeDiqnCKOpVX2DIKb/wqPVcJw6nG6c0ALf9FFAfw0mi0nZ+dKFtSvgDfsrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4576
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>, gregkh@linuxfoundation.org,
 Felix.Kuehling@amd.com, ppaalanen@gmail.com, helgaas@kernel.org,
 Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gZGV2aWNlIHJlbW92YWwgcmVyb3V0ZSBhbGwgQ1BVIG1hcHBpbmdzIHRvIGR1bW15IHBhZ2Uu
Cgp2MzoKUmVtb3ZlIGxvb3AgdG8gZmluZCBEUk0gZmlsZSBhbmQgaW5zdGVhZCBhY2Nlc3MgaXQK
Ynkgdm1hLT52bV9maWxlLT5wcml2YXRlX2RhdGEuIE1vdmUgZHVtbXkgcGFnZSBpbnN0YWxsYXRp
b24KaW50byBhIHNlcGFyYXRlIGZ1bmN0aW9uLgoKdjQ6Ck1hcCB0aGUgZW50aXJlIEJPcyBWQSBz
cGFjZSBpbnRvIG9uIGRlbWFuZCBhbGxvY2F0ZWQgZHVtbXkgcGFnZQpvbiB0aGUgZmlyc3QgZmF1
bHQgZm9yIHRoYXQgQk8uCgp2NTogUmVtb3ZlIGR1cGxpY2F0ZSByZXR1cm4uCgp2NjogUG9saXNo
IHR0bV9ib192bV9kdW1teV9wYWdlLCByZW1vdmUgc3VwZXJmbHVvdXMgY29kZS4KClNpZ25lZC1v
ZmYtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPgpSZXZp
ZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3ZtLmMgfCA1NCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0KIGluY2x1ZGUvZHJtL3R0bS90dG1fYm9fYXBpLmggICAgfCAgMiArKwog
MiBmaWxlcyBjaGFuZ2VkLCA1NSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9fdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS90
dG0vdHRtX2JvX3ZtLmMKaW5kZXggYjMxYjE4MDU4OTY1Li43ZmY5ZmQ1NTEzNTcgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3ZtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L3R0bS90dG1fYm9fdm0uYwpAQCAtMzQsNiArMzQsOCBAQAogI2luY2x1ZGUgPGRybS90dG0vdHRt
X2JvX2RyaXZlci5oPgogI2luY2x1ZGUgPGRybS90dG0vdHRtX3BsYWNlbWVudC5oPgogI2luY2x1
ZGUgPGRybS9kcm1fdm1hX21hbmFnZXIuaD4KKyNpbmNsdWRlIDxkcm0vZHJtX2Rydi5oPgorI2lu
Y2x1ZGUgPGRybS9kcm1fbWFuYWdlZC5oPgogI2luY2x1ZGUgPGxpbnV4L21tLmg+CiAjaW5jbHVk
ZSA8bGludXgvcGZuX3QuaD4KICNpbmNsdWRlIDxsaW51eC9yYnRyZWUuaD4KQEAgLTM4MCwxOSAr
MzgyLDY5IEBAIHZtX2ZhdWx0X3QgdHRtX2JvX3ZtX2ZhdWx0X3Jlc2VydmVkKHN0cnVjdCB2bV9m
YXVsdCAqdm1mLAogfQogRVhQT1JUX1NZTUJPTCh0dG1fYm9fdm1fZmF1bHRfcmVzZXJ2ZWQpOwog
CitzdGF0aWMgdm9pZCB0dG1fYm9fcmVsZWFzZV9kdW1teV9wYWdlKHN0cnVjdCBkcm1fZGV2aWNl
ICpkZXYsIHZvaWQgKnJlcykKK3sKKwlzdHJ1Y3QgcGFnZSAqZHVtbXlfcGFnZSA9IChzdHJ1Y3Qg
cGFnZSAqKXJlczsKKworCV9fZnJlZV9wYWdlKGR1bW15X3BhZ2UpOworfQorCit2bV9mYXVsdF90
IHR0bV9ib192bV9kdW1teV9wYWdlKHN0cnVjdCB2bV9mYXVsdCAqdm1mLCBwZ3Byb3RfdCBwcm90
KQoreworCXN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hID0gdm1mLT52bWE7CisJc3RydWN0IHR0
bV9idWZmZXJfb2JqZWN0ICpibyA9IHZtYS0+dm1fcHJpdmF0ZV9kYXRhOworCXN0cnVjdCBkcm1f
ZGV2aWNlICpkZGV2ID0gYm8tPmJhc2UuZGV2OworCXZtX2ZhdWx0X3QgcmV0ID0gVk1fRkFVTFRf
Tk9QQUdFOworCXVuc2lnbmVkIGxvbmcgYWRkcmVzczsKKwl1bnNpZ25lZCBsb25nIHBmbjsKKwlz
dHJ1Y3QgcGFnZSAqcGFnZTsKKworCS8qIEFsbG9jYXRlIG5ldyBkdW1teSBwYWdlIHRvIG1hcCBh
bGwgdGhlIFZBIHJhbmdlIGluIHRoaXMgVk1BIHRvIGl0Ki8KKwlwYWdlID0gYWxsb2NfcGFnZShH
RlBfS0VSTkVMIHwgX19HRlBfWkVSTyk7CisJaWYgKCFwYWdlKQorCQlyZXR1cm4gVk1fRkFVTFRf
T09NOworCisJLyogU2V0IHRoZSBwYWdlIHRvIGJlIGZyZWVkIHVzaW5nIGRybW0gcmVsZWFzZSBh
Y3Rpb24gKi8KKwlpZiAoZHJtbV9hZGRfYWN0aW9uX29yX3Jlc2V0KGRkZXYsIHR0bV9ib19yZWxl
YXNlX2R1bW15X3BhZ2UsIHBhZ2UpKQorCQlyZXR1cm4gVk1fRkFVTFRfT09NOworCisJcGZuID0g
cGFnZV90b19wZm4ocGFnZSk7CisKKwkvKiBQcmVmYXVsdCB0aGUgZW50aXJlIFZNQSByYW5nZSBy
aWdodCBhd2F5IHRvIGF2b2lkIGZ1cnRoZXIgZmF1bHRzICovCisJZm9yIChhZGRyZXNzID0gdm1h
LT52bV9zdGFydDsgYWRkcmVzcyA8IHZtYS0+dm1fZW5kOyBhZGRyZXNzICs9IFBBR0VfU0laRSkg
eworCisJCWlmICh2bWEtPnZtX2ZsYWdzICYgVk1fTUlYRURNQVApCisJCQlyZXQgPSB2bWZfaW5z
ZXJ0X21peGVkX3Byb3Qodm1hLCBhZGRyZXNzLAorCQkJCQkJICAgIF9fcGZuX3RvX3Bmbl90KHBm
biwgUEZOX0RFViksCisJCQkJCQkgICAgcHJvdCk7CisJCWVsc2UKKwkJCXJldCA9IHZtZl9pbnNl
cnRfcGZuX3Byb3Qodm1hLCBhZGRyZXNzLCBwZm4sIHByb3QpOworCX0KKworCXJldHVybiByZXQ7
Cit9CitFWFBPUlRfU1lNQk9MKHR0bV9ib192bV9kdW1teV9wYWdlKTsKKwogdm1fZmF1bHRfdCB0
dG1fYm9fdm1fZmF1bHQoc3RydWN0IHZtX2ZhdWx0ICp2bWYpCiB7CiAJc3RydWN0IHZtX2FyZWFf
c3RydWN0ICp2bWEgPSB2bWYtPnZtYTsKIAlwZ3Byb3RfdCBwcm90OwogCXN0cnVjdCB0dG1fYnVm
ZmVyX29iamVjdCAqYm8gPSB2bWEtPnZtX3ByaXZhdGVfZGF0YTsKKwlzdHJ1Y3QgZHJtX2Rldmlj
ZSAqZGRldiA9IGJvLT5iYXNlLmRldjsKIAl2bV9mYXVsdF90IHJldDsKKwlpbnQgaWR4OwogCiAJ
cmV0ID0gdHRtX2JvX3ZtX3Jlc2VydmUoYm8sIHZtZik7CiAJaWYgKHJldCkKIAkJcmV0dXJuIHJl
dDsKIAogCXByb3QgPSB2bWEtPnZtX3BhZ2VfcHJvdDsKLQlyZXQgPSB0dG1fYm9fdm1fZmF1bHRf
cmVzZXJ2ZWQodm1mLCBwcm90LCBUVE1fQk9fVk1fTlVNX1BSRUZBVUxULCAxKTsKKwlpZiAoZHJt
X2Rldl9lbnRlcihkZGV2LCAmaWR4KSkgeworCQlyZXQgPSB0dG1fYm9fdm1fZmF1bHRfcmVzZXJ2
ZWQodm1mLCBwcm90LCBUVE1fQk9fVk1fTlVNX1BSRUZBVUxULCAxKTsKKwkJZHJtX2Rldl9leGl0
KGlkeCk7CisJfSBlbHNlIHsKKwkJcmV0ID0gdHRtX2JvX3ZtX2R1bW15X3BhZ2Uodm1mLCBwcm90
KTsKKwl9CiAJaWYgKHJldCA9PSBWTV9GQVVMVF9SRVRSWSAmJiAhKHZtZi0+ZmxhZ3MgJiBGQVVM
VF9GTEFHX1JFVFJZX05PV0FJVCkpCiAJCXJldHVybiByZXQ7CiAKZGlmZiAtLWdpdCBhL2luY2x1
ZGUvZHJtL3R0bS90dG1fYm9fYXBpLmggYi9pbmNsdWRlL2RybS90dG0vdHRtX2JvX2FwaS5oCmlu
ZGV4IDYzOTUyMTg4MGMyOS4uMjU0ZWRlOTdmOGUzIDEwMDY0NAotLS0gYS9pbmNsdWRlL2RybS90
dG0vdHRtX2JvX2FwaS5oCisrKyBiL2luY2x1ZGUvZHJtL3R0bS90dG1fYm9fYXBpLmgKQEAgLTYy
MCw0ICs2MjAsNiBAQCBpbnQgdHRtX2JvX3ZtX2FjY2VzcyhzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3Qg
KnZtYSwgdW5zaWduZWQgbG9uZyBhZGRyLAogCQkgICAgIHZvaWQgKmJ1ZiwgaW50IGxlbiwgaW50
IHdyaXRlKTsKIGJvb2wgdHRtX2JvX2RlbGF5ZWRfZGVsZXRlKHN0cnVjdCB0dG1fZGV2aWNlICpi
ZGV2LCBib29sIHJlbW92ZV9hbGwpOwogCit2bV9mYXVsdF90IHR0bV9ib192bV9kdW1teV9wYWdl
KHN0cnVjdCB2bV9mYXVsdCAqdm1mLCBwZ3Byb3RfdCBwcm90KTsKKwogI2VuZGlmCi0tIAoyLjI1
LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
