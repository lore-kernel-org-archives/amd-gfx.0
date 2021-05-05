Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D4EC43461
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 07:30:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C22B6117A
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 07:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C22B6117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31CBA6E431;
	Wed,  5 May 2021 07:30:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 696666E42D
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 07:30:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyEbDPuoWw11w60N8acvyBwpK3UpPxl1bKqHe8/1ldgne8Q96xed8UUoQrQ2KyOMW5JzpSrWxfNXaHBqGhwpv3jI1vSvH7rRSh44Ydvfh2m9VJJQSlyWIKdZUPQRADOuySodBBMew/PzpnMsvwrS9EYVwDJ/cBhR5Y9uWPxMXdzgNcjp5kMXYpxS9+wqN1fJGdPdXLZSYs3q8viAB4QCssSkswftxqhCqLL+98OjZXQm+OgtdAASgZyEnAGISZ94lV3wRFUAowbpqq1NWjf4WwYNxhbAg6j01btzh8tjt202k3ltNfyQH664NrtifUcf+J3oN29u86UvXX6Yx2TUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5un4oymikY8JE+a31t8/WPvsSgs+qPRS4Z12QAwRXW8=;
 b=FXfMImvUVqanplEWUq1qZANqflp572Icq533gmzcCtSN6fAb7tC9mzU1nud98i7NbZXmmFMy9vAeYySNQBEwC6+Mhe4r23DAk6auMH80c3rEZtj3gNKGDKrdwyBMOslXsxMD0ecG4m/o6ttkaDMONVPlDMDoT8fJJDw8dQGcPXsExfSTI5UT2BWtQDQTjwpS2PpoDGf8o9/k4GuvniAyUrmQxYfAqUQWMxJG5P5aQQr0m29XSYiPFTFRUB0EEG2T6iCdKQs87ue/kolvXg7MVCM5dz07JPvdjt5kKnXxJ5baSYQis0xyDmNG9ni0wvmtr2U88GpyC+KMuva129xDEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5un4oymikY8JE+a31t8/WPvsSgs+qPRS4Z12QAwRXW8=;
 b=WicBPLma8pkJEezSQGJ9slK+V/4rD0VgqtYeaH6OSVUX6csKlNOaVBtyHIuP3Zg9d8L3M++cOozU0W9gF4L1Pk/AwLgC3h6WSZsCjMLJfbyEC7WcVMMNtIib41oiSeyeZG9r7T8eB46TmT4K3QnX0eLmOJW8syluMhX9zTPMcVA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1866.namprd12.prod.outlook.com (2603:10b6:3:10c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Wed, 5 May
 2021 07:30:19 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4108.025; Wed, 5 May 2021
 07:30:19 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/4] Normalize redundant variables
Date: Wed,  5 May 2021 03:30:01 -0400
Message-Id: <20210505073005.5128-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.0.97.g1424303384
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::10) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0041.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.40 via Frontend Transport; Wed, 5 May 2021 07:30:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c55d8d41-bf25-40c5-4e87-08d90f97a29b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1866:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1866E0E062E73F27389A41DB99599@DM5PR12MB1866.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3IH3Qfbda0fexvBcDooOimx3U4ZuudVWOVdFpgd78FGf4BhbFlmoWl9rfWXwWjomgaKEckgsN93lLVXJQRI1hw9lUP2FlY532PKIwP8QmztPfAKizhc/8NMB7Sobsqx4rcVsEaksztEEt+qc96Lp01ZrvZhkZj/9bgnTCSOc4AkHa6Y7u3JnzTXR9vOmYY6TcOFgtQnWXZv4LOD1IAqaGpvEWOeewruMBo+tzhgpWMcpt3G5u6oYANdSU48E0L5tiemGG1n85svsSdOaQybepmlyCM7tCToUbROZI4/UyUWjI58VIDh5FAsQDDQuNEkWS4SnBuRJossoc+9s5MgPks7G5yDo+fQ598/HVFUEXnmfE8RqMpRXZEw6BqAvZagD8UpVE2zw5EG3dFwIjPABQzdjdrghWr2qu8VZq0AUu+WbWp3fA5Zj3Y80c9erpNNCg457eOmF2OgOWRzuvL20iUuKdHOzC97DvAwwTk4Q8kDxVs4sYgFxfMvACo3ci5yLFAsvUSWdkjH7BXGSuHXPm+oFrxh07G+fUwHBfME+j0qSEG1iobUvO1PsRXkqZMNYnRV08SRY4/r276Z/hj5thOebFB17aiQfjGnn7UGMwoQcsUitjXNx0xTA9YLnjCGn2bVTvSqKnhi5Bghh+LWkAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(36756003)(4326008)(956004)(8676002)(44832011)(26005)(2906002)(54906003)(1076003)(6666004)(2616005)(316002)(5660300002)(8936002)(6916009)(52116002)(6506007)(6512007)(83380400001)(66476007)(66556008)(38350700002)(186003)(16526019)(6486002)(38100700002)(86362001)(66946007)(478600001)(55236004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NjJ0dXVobE0zTFZESGpUSklRVjFpbm52Z3pXZS8wQXlnalJLZXdaMEo3UDVM?=
 =?utf-8?B?elJKS3Yya3puVU9QNUNhZHJPOFdQZ1JKc1FyblpUVy9XWEpEOEVkbVFrSFd5?=
 =?utf-8?B?eGtaZ3phNnc0aEQzQ0FTMzUwL2c2R3E1UVZrQVU5dWJKMjFYVXIrRVN5dU11?=
 =?utf-8?B?UWFWU2ROSURkRmhpcFl5NWhtN05PZExCYU5IRHprakU2Z29IUVQ5TUYyRGkz?=
 =?utf-8?B?ZmF3SkFqZnRhbVRPSHptV09qNFdieHBzVkxLRHZGWjJlZEFEamNJektNcDFE?=
 =?utf-8?B?akRBdWt2TXRVNXRySmRSZjlGQ2ZERkppbW13YkN6UW1MUmQwNi9xTk1nSVRL?=
 =?utf-8?B?akdtMXlDYVp4RU43cGxYbW53cFRhalV0TDFYdmFpUlZSYURZM0tPQ0JuYVZh?=
 =?utf-8?B?b2ZpbFpWTUFMSVlNUU9KTTZ3WTFTWEJBSTFlVElIV09ZeFhUQzRPd3Q4TU9L?=
 =?utf-8?B?K29sMktLaldEMi8wTVZiM1VwZjM3WUt1Sjl2c2ZMYWM3SUdKOUt0Nmw5RStv?=
 =?utf-8?B?TUtvR1d0NGQ4Z3NmeEN5RTd0T2NSTmhqU1BWSmh6STMyTmZpWjVZU200Vncx?=
 =?utf-8?B?MHNzNmdYOUZkNVcyTWlrRHA2Uk1RdFdTZlUrbExQOEw1eW9DVVI0VHY4dGpM?=
 =?utf-8?B?Z0RIV1pzcDlQR3hhRkFFOTFJVXBBTWlHcXZkTDNTdk9Qbnl6bks4cFh0ZllV?=
 =?utf-8?B?dU1wUzB2TmxoemdFYTBINmdkdjNNempSV2RGYStpbTZIZzFQZ1J0NEM2a29Z?=
 =?utf-8?B?d1JRbnpZOEJ6OUJkWllSNVNVSVJXR2FXL1RkdzlnWHljSTQ4N1phNi9pcVpy?=
 =?utf-8?B?dlZKZE03VzlXQi9lSkRHTE9ma3JUVWVjRHJWdU9CM2tNclRKSUlYRzY4Q3FM?=
 =?utf-8?B?c3h0T1B6bGM2ZWlqWEhjbUxZQXp5cTFIdlc2UnVsV2QvWjhiK1NpbTl3L2F3?=
 =?utf-8?B?UG9MSFl4YUZBSFhRbUpRN2FxcFhsdTBENHU4OTB2WjBwQlludnVhOFlvdmpP?=
 =?utf-8?B?UVgrSXA3VUVRT3dLMURITEp4TG4wK2p0cE9UaGpmUDEzVVYrWlVtU0JocDBV?=
 =?utf-8?B?VmxMQnlreGNxbTNiS0tpNWlOMzh6UUpKMkNRbDNOc1hNR3dPRHA4cHJvS0dH?=
 =?utf-8?B?VnBPbGRYMUJvblVxVkx0YkZ3NTVTcmp1a01VSTI2Q3JYMTJ1Q1VQc2pNdjNy?=
 =?utf-8?B?bjMwL2dFdWtrZG1QeEt6cmxheW42czAvMlZlYVVUc20zRENzZGFaOUdSZG5p?=
 =?utf-8?B?czlRQmt2ZnZOOEQ0YVFGUkVMQnZqQXEzZXVGUjV3YjBIZ1RjSVViU0twYkNl?=
 =?utf-8?B?RGNWeGRHSVZVZjVNMEFrdmRBeW5lVEthSzZZeTVuM0NhYWUxelJNOEk3K0l5?=
 =?utf-8?B?bkdPTENZV2NmZGFjd1Rjc3RjaHRRZWFOTkgreU80MmdnR3dPRGRCTHhibVc2?=
 =?utf-8?B?Y29ZSHJGU2FuYmN5RlFIV21Pei9TVkh1QzlKRWlSeVNLWGpnT0M2MTdqUEMr?=
 =?utf-8?B?UXYxM1hlaElhSkNBcjJ5VGZtQ2RLWE54Q05tNEtEdDVTYjJ4Si9XWm50L3Y4?=
 =?utf-8?B?SVArVTB3aHRObEZPeDNzRlpubVlNc3d2YWtqZklmcUR0N0NYdnEvSitBb1RP?=
 =?utf-8?B?bDFGZHliQ0RTclVrRFExM1A2WVFBVElSU3Eya2IzNVptNVM3cU92UTBHRnZ4?=
 =?utf-8?B?UkVkb214SUZKV0IwTytuT2JacDhTZ242cURhVVNuUUxocDRqM24xNCswNThk?=
 =?utf-8?Q?45JaSA6/hFCYdN3/ZyaAOnstEUPb+40AO2aQntm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c55d8d41-bf25-40c5-4e87-08d90f97a29b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 07:30:19.4300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QatqAlfWIZlUY6Z8seW4LQTCK042y+RkSBzzrFfovqF5uCJP5vYsLHQYiIPDfrlM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1866
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, John Clements <john.clements@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Q2xhc3NpYyBub3JtYWxpemF0aW9uIG9mIGEgcmVkdW5kYW50IHZhcmlhYmxlLgpUaGVyZSBpcyBu
byBuZWVkIHRvIGhhdmUgdHdvIHZhcmlhYmxlcyByZXByZXNlbnRpbmcKdGhlIHNhbWUgcXVhbnRp
dHkuIE1vdmUgdXAgdG8gdGhlIHN0cnVjdHVyZSB3aGljaApyZXByZXNlbnRzIHRoZSBvYmplY3Qg
d2hpY2ggZGV0ZXJtaW5lcyB0aGVpciB2YWx1ZXMuClJlbmFtZSB0byBhIGNvbnNpc3RlbnQgbmFt
ZSwgYW5kIGV4cG9ydCB0byBkZWJ1Z2ZzCmZvciBkZWJ1Z2dpbmcuCgpMdWJlbiBUdWlrb3YgKDQp
OgogIGRybS9hbWRncHU6IFJlbW92ZSByZWR1bmRhbnQgcmFzLT5zdXBwb3J0ZWQKICBkcm0vYW1k
Z3B1OiBNb3ZlIHVwIHJhc19od19zdXBwb3J0ZWQKICBkcm0vYW1kZ3B1OiBSZW5hbWUgdG8gcmFz
XypfZW5hYmxlZAogIGRybS9hbWRncHU6IEV4cG9ydCByYXNfKl9lbmFibGVkIHRvIGRlYnVnZnMK
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCAgICAgICAgICAgfCAgMyArLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jICAgIHwgIDYgKy0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyAgICAgICB8ICAyICstCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgICAgICAgfCAgMiArLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jICAgICAgIHwgOTEgKysrKysrKysrLS0t
LS0tLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5oICAgICAgIHwg
IDUgKy0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgICAgICAgICB8ICAy
ICstCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jICAgICAgICAgICAgfCAgNyAr
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMgICAgIHwgIDYgKy0K
IC4uLi9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci92ZWdhMjBfYmFjby5jICB8ICAyICstCiAu
Li4vZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvc211X3YxMV8wLmMgICAgfCAgMyArLQogMTEg
ZmlsZXMgY2hhbmdlZCwgNjMgaW5zZXJ0aW9ucygrKSwgNjYgZGVsZXRpb25zKC0pCgpDYzogQWxl
eGFuZGVyIERldWNoZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+CkNjOiBKb2huIENsZW1l
bnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+CkNjOiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpo
YW5nQGFtZC5jb20+CkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+CgotLSAKMi4zMS4wLjk3LmcxNDI0MzAzMzg0CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
