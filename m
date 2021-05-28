Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EABAC4708C
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 10:56:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF8D3611BD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 10:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8D3611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D09E6ED9D;
	Fri, 28 May 2021 10:56:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3EB46E3E3
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 10:56:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pu2jjZI2JiK9rwbBOPmjFHXgt/q3cSKZFpshiseJd7UU9oLFZ/qgEG5Xh61VJI4LHe+4jzFV6JF3xt6rxDv8fSY2tDn7z/xmSQ7kN5eB772W/Biuo95w9tqE0BZ1WcPospyfrVIQT9nK4zzZDUfKKJUdyxZViDViuFMNW2l0roqh4khX5bavAKqROsdT3qOWMXaxCsUBp8Ch3W45wY3yUi7unNJdAWVXWKJYPyVpL4RjKpcPJ6kyp2zfMfg+7XMkDpS8bnuqr2yPSdddM5u4lhLgGFWOR2iAW1cuzWeOD7F3GE5BnJN6AuM0DsjQZWrfl0lY3F7o14q0VuXy38EQMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWBIvOBU96h16C/Csbfl2iEUB5uRs+18xWArbnR/SV4=;
 b=HTKF4zAaasT6fZ7UjXLR4OvyOUucMfhLfxs0OVeXbl4rGKzGMOS9WlCWsddPtJPm/2nSkEMPXFBXkCiaxuli6s4Ee77wDA69DETgUzWMVovlo/zphBo7k8lhydwocIvgLM8KvaSdkZXIBIl39jJnWXt22zHjuppSyO3TvJPGjRoIweE1iNFQG0fBXh3uDpDVfFHjDUHJ/xH6GNLXE81+AjfzfvudwUgzafn28uvfInT3SZ5ts6JZRKxepngQXEha9TrQY08pm0Il7IictieeHGWyC2n2DM1fVguKH3wFd6DsNrx2kYCbe+SDLE+IjM198h1e4lmpV7NP6+UAr26f9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWBIvOBU96h16C/Csbfl2iEUB5uRs+18xWArbnR/SV4=;
 b=1AzmeoE9hnhksKi3u4bfqhh1i7XLKvrljR5sXyb6YSWB9ne5ba4iNJq8AFXocZhIecLNaCGJKxNfE+dcE18qsJLmWO0BxiOCpHJbpuB4ahDHIBaiyHYFRY9bqls5Cae3o/xhyog9GtSIWZAUZnIYhXFY0/76JSq5E5K9DXRn510=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM8PR12MB5416.namprd12.prod.outlook.com (2603:10b6:8:28::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Fri, 28 May
 2021 10:56:41 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.022; Fri, 28 May 2021
 10:56:41 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/6] drm/admgpu: add two shadow BO helper functions
Date: Fri, 28 May 2021 12:56:20 +0200
Message-Id: <20210528105623.28148-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528105623.28148-1-nirmoy.das@amd.com>
References: <20210528105623.28148-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.100.114]
X-ClientProxiedBy: PR3P189CA0081.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::26) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.100.114) by
 PR3P189CA0081.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:b4::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 10:56:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1a9b9d8-a003-4fb7-9a37-08d921c7468d
X-MS-TrafficTypeDiagnostic: DM8PR12MB5416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB54165D8FE52793C9A5060B488B229@DM8PR12MB5416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1mQDyxF8VqoyQOTsOY8chxRw9H6gp0uUe9e7FKrCMXZuy5hypWwENnWxWzlNE2A0vIrbRos/lw547RGYfhIaDRlzFjzhV6lmcDwUvliKFhuORMDPWtKpMVGjNfCYnf3Ti/ADZZZCCjKVfjO8ffMKVrqB7LA/O2lxM4AKB/E4Bed/MvZnZeUGZyvM5cTz5zKULSgsg6mtJwX9cDKhjMWGE4rfuJh9XSYSIteOOhISjpvEE6Oh6z7OzU9xTiwQ4qztlEtn066v+b79fyr31kA22MTLl06b9wjHWyGrcSfsy8HsOpFNKsXu6Jx4yG63bjgu+qXuA3CEe3DI6nv+qanLszZ8km//xjfEuUi825vbHDVTBV1LctgmKTTNeT1LE4Ks+cWSJb/v4rT37Bag3TE5cGpFo96vsQzKhCIw+TrAoB/BtI/q8MsQ++/bYPUrvyKTwoAektNupR1OQlp2j27iiR1LkaJiWL9Pjt9nE026KqES5i+yKBT2KSXpNVwzuDYuKZkN8Yg53dyGrA/XgGkGWgRdge0tDaynccSQC37XtzH0F98v+ODzkWzpQaJiJMdyKgrmDjXCztYLEgbq5RYpYN3Jj/nOuYyT3S2cOuARejaVKgvK0GK1FFfvpoWwlCnXIv78EhjkcxSrJwfpoxjKME4O+GeZ8Lq23I2ESy8blDA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39850400004)(366004)(346002)(136003)(376002)(6486002)(2906002)(6512007)(38350700002)(38100700002)(6916009)(36756003)(44832011)(16526019)(5660300002)(66476007)(186003)(66556008)(66946007)(86362001)(956004)(2616005)(26005)(8936002)(83380400001)(66574015)(6506007)(478600001)(52116002)(1076003)(54906003)(8676002)(6666004)(316002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dVFmRUo2WFBXVkVCQ3dpZGJhSHkvVElNbVZHd1lLT0ZhQ0ZGTXdBNWh2U1Vp?=
 =?utf-8?B?MDdtbDRhaUJTZHV2SDJjcVZuU2V3NzY0R3lXRUNXZkRIY1VmVnQyeS8vYmJi?=
 =?utf-8?B?RG9WRFZxVXlGVDNDZlBKS1hVMW5IdEVNSzNRbWlFNUVPdnNBeHRxdDMvNG43?=
 =?utf-8?B?Sjk5bFZEMUgzd2hnY0t5Z0VCTWt4YjVKZm4zK1RwU0c0T3lsdVlxNlFCcStm?=
 =?utf-8?B?V2NiNXhSeUlGUkRKdTYzWEZMU1czd3RiUEZQenBJWi95eEtxMkEyWGd1ZHJw?=
 =?utf-8?B?K0h2Zm5kUUZwb0VRLzVQS2luaUVHMDBSUS9XYkdTUkhZQXZlMnljYXJTMlRG?=
 =?utf-8?B?N2FwTzQ1Q2VZeVp1Q25sZnVISExyaEpIZ2k0YzUxRjVnSUlJcWdEV1RFQkJn?=
 =?utf-8?B?Skc5T0pPNVRvZzQ5Tk92VmF2NE1PUldoZ2NCMGdvR3REVjQ0U2J4bmI1RUti?=
 =?utf-8?B?Zm5sZjdvc0tSUkMwTHZkRkozUVN6bTlnZTJRMzUydktuM3V2bUtQV203czVY?=
 =?utf-8?B?ZkwyWXhjUFFWZ2V1UEI2dWVJVWlBTlpIN3BXdHVaRWZiM0tLTTJpdmgrRXE3?=
 =?utf-8?B?S3orcXBRSjMwWStxQzkvSk45TWVFSG1xQWZ5ZnF4bUVsOFY3UWZqTFo1THY3?=
 =?utf-8?B?Y3M4bVRRMHF2ZkE1VEJmK0Fzd0c5bjJWdUU3NEtwOVJ6ZVRLZ1NxUmFsNndx?=
 =?utf-8?B?cDlkUUhpVGkrNUUwQis2dmRLMlpjWWhOSWx0bnQ3NEloTEhybTZHK2NWelM1?=
 =?utf-8?B?WVBqcXR0UWlHM2lScS8xWGhNbjJKZ1BDWXlwbzhhVm90QWpWSzA3QmFTZU0r?=
 =?utf-8?B?dlcvYVBMSk9NaWJHNEhFc2dJZmlPQ04zOU1Jc2RXdU44VVlKUGhENkxISTlw?=
 =?utf-8?B?WGpmMkI1aUlGYkUwZUxtMHliR1YxMWVaOGd6eVRpTjUvbC9wZk9SdFl0eWNm?=
 =?utf-8?B?Y2hGWUNVQWZqOE1lOUxlbm5HaWNaVFBiQm9WWEc0VmJHeXlDQ1JRTmlyNlpo?=
 =?utf-8?B?T0JYOEJWTmpvMEdxdjRZZDdMaUVVaHMxaVIzQzkydmJhd2RDajdzdGNFeDIw?=
 =?utf-8?B?SUdXWVlCMGJONmFCQ3JROWcrMkFtZFN5UE5sWmJZL0VNNUUzdzkrb1VSZkFR?=
 =?utf-8?B?L2xSUFo4aDFxY3I5aGdQZDBOWlhETll4YjBldHJJWklrckR5elp2SzBqV2hB?=
 =?utf-8?B?QkdvMmFSR29zcG4zbFAvdFd0TXcwRWRKUmpTVU5HU3FCdHNtYU02aDRSTkI3?=
 =?utf-8?B?NEpJTFRMMkt5c3BBWjI1cTY3MEZveU9TaHFsRW1CZm1Jc3h3L2pCN2hac2NS?=
 =?utf-8?B?NndDRVJMRFVCOGp1MDdFN3NRTGgyQk1Ra3dqemZvMjdUR09WWllzR2NHODE3?=
 =?utf-8?B?V3hQaU92ZWtWMmhsSytnazNySFpmSGQ4d2NqQzVpQnRwY0t0aG50eUxRb2Q0?=
 =?utf-8?B?TzZibVlmZGg0K2MyVFFGRGprWFg4SW9tRXJ3eHZ5c3Z4L1dmbVN1VWJmbVRy?=
 =?utf-8?B?cSt1Z2phZ2FseWdvQ2JiWFJNNFc0eFJrYUVXWlNCdTI3RklZakh3czdVWTFM?=
 =?utf-8?B?THZBNEVQMWQzODlzSDltWnJUK2xGbmlIalJQRThwQ0hiMFM4RlRvaThzU1Fs?=
 =?utf-8?B?bER1Y1dGaVZzVTk0Qk1rWVBONTF0SzVOTGZ0bDgzZGJvRFR3SnF0RkU1TDJs?=
 =?utf-8?B?dVlFa0g1UC9ObFlna3Q3Rm5VbmxudzEzQURBQ0VuTEs4QkFTZWJlNjdOZU9j?=
 =?utf-8?Q?I/Kt+SDRwo/A+/lPU2gL0YXuaSO2Sj2c/dZka1u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a9b9d8-a003-4fb7-9a37-08d921c7468d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 10:56:41.6584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hq/WLXf6t7bowUf5CHcjIP6NBTT4yXPCcSd0A9P91H3Qz+uxbXvRBAJ7/hygJL+nNGOW2rcirQGyzINyUAQRFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5416
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QWRkIGFtZGdwdV9ib19hZGRfdG9fc2hhZG93X2xpc3QoKSB0byBoYW5kbGUgc2hhZG93IGxpc3QK
YWRkaXRpb25zIGFuZCBhbWRncHVfYm9fc2hhZG93ZWQoKSB0byBjaGVjayBpZiBhIEJPIGlzIHNo
YWRvd2VkLgoKU2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgpS
ZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyB8IDE2ICsrKysr
KysrKysrKysrKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaCB8
IDE3ICsrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKaW5kZXggMmU1NDI2
YWIyNGE4Li44OWJhNjEyYTUwODAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9vYmplY3QuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfb2JqZWN0LmMKQEAgLTc2MCw2ICs3NjAsMjIgQEAgaW50IGFtZGdwdV9ib192YWxpZGF0ZShz
dHJ1Y3QgYW1kZ3B1X2JvICpibykKIAlyZXR1cm4gcjsKIH0KIAorLyoqCisgKiBhbWRncHVfYm9f
YWRkX3RvX3NoYWRvd19saXN0IC0gYWRkIGEgQk8gdG8gdGhlIHNoYWRvdyBsaXN0CisgKgorICog
QGJvOiBCTyB0aGF0IHdpbGwgYmUgaW5zZXJ0ZWQgaW50byB0aGUgc2hhZG93IGxpc3QKKyAqCisg
KiBJbnNlcnQgYSBCTyB0byB0aGUgc2hhZG93IGxpc3QuCisgKi8KK3ZvaWQgYW1kZ3B1X2JvX2Fk
ZF90b19zaGFkb3dfbGlzdChzdHJ1Y3QgYW1kZ3B1X2JvICpibykKK3sKKwlzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiA9IGFtZGdwdV90dG1fYWRldihiby0+dGJvLmJkZXYpOworCisJbXV0ZXhf
bG9jaygmYWRldi0+c2hhZG93X2xpc3RfbG9jayk7CisJbGlzdF9hZGRfdGFpbCgmYm8tPnNoYWRv
d19saXN0LCAmYWRldi0+c2hhZG93X2xpc3QpOworCW11dGV4X3VubG9jaygmYWRldi0+c2hhZG93
X2xpc3RfbG9jayk7Cit9CisKIC8qKgogICogYW1kZ3B1X2JvX3Jlc3RvcmVfc2hhZG93IC0gcmVz
dG9yZSBhbiAmYW1kZ3B1X2JvIHNoYWRvdwogICoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9vYmplY3QuaAppbmRleCBhN2ZiZjVmNzA1MWUuLjlhZmNjZjZjNjZmMiAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5oCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaApAQCAtMjU5LDYgKzI1OSwy
MiBAQCBzdGF0aWMgaW5saW5lIGJvb2wgYW1kZ3B1X2JvX2VuY3J5cHRlZChzdHJ1Y3QgYW1kZ3B1
X2JvICpibykKIAlyZXR1cm4gYm8tPmZsYWdzICYgQU1ER1BVX0dFTV9DUkVBVEVfRU5DUllQVEVE
OwogfQogCisvKioKKyAqIGFtZGdwdV9ib19zaGFkb3dlZCAtIGNoZWNrIGlmIHRoZSBCTyBpcyBz
aGFkb3dlZAorICoKKyAqIEBibzogQk8gdG8gYmUgdGVzdGVkLgorICoKKyAqIFJldHVybnM6Cisg
KiBOVUxMIGlmIG5vdCBzaGFkb3dlZCBvciBlbHNlIHJldHVybiBhIEJPIHBvaW50ZXIuCisgKi8K
K3N0YXRpYyBpbmxpbmUgc3RydWN0IGFtZGdwdV9ibyAqYW1kZ3B1X2JvX3NoYWRvd2VkKHN0cnVj
dCBhbWRncHVfYm8gKmJvKQoreworCWlmIChiby0+dGJvLnR5cGUgPT0gdHRtX2JvX3R5cGVfa2Vy
bmVsKQorCQlyZXR1cm4gdG9fYW1kZ3B1X2JvX3ZtKGJvKS0+c2hhZG93OworCisJcmV0dXJuIE5V
TEw7Cit9CisKIGJvb2wgYW1kZ3B1X2JvX2lzX2FtZGdwdV9ibyhzdHJ1Y3QgdHRtX2J1ZmZlcl9v
YmplY3QgKmJvKTsKIHZvaWQgYW1kZ3B1X2JvX3BsYWNlbWVudF9mcm9tX2RvbWFpbihzdHJ1Y3Qg
YW1kZ3B1X2JvICphYm8sIHUzMiBkb21haW4pOwogCkBAIC0zMjIsNiArMzM4LDcgQEAgdTY0IGFt
ZGdwdV9ib19ncHVfb2Zmc2V0X25vX2NoZWNrKHN0cnVjdCBhbWRncHVfYm8gKmJvKTsKIGludCBh
bWRncHVfYm9fdmFsaWRhdGUoc3RydWN0IGFtZGdwdV9ibyAqYm8pOwogdm9pZCBhbWRncHVfYm9f
Z2V0X21lbW9yeShzdHJ1Y3QgYW1kZ3B1X2JvICpibywgdWludDY0X3QgKnZyYW1fbWVtLAogCQkJ
CXVpbnQ2NF90ICpndHRfbWVtLCB1aW50NjRfdCAqY3B1X21lbSk7Cit2b2lkIGFtZGdwdV9ib19h
ZGRfdG9fc2hhZG93X2xpc3Qoc3RydWN0IGFtZGdwdV9ibyAqYm8pOwogaW50IGFtZGdwdV9ib19y
ZXN0b3JlX3NoYWRvdyhzdHJ1Y3QgYW1kZ3B1X2JvICpzaGFkb3csCiAJCQkgICAgIHN0cnVjdCBk
bWFfZmVuY2UgKipmZW5jZSk7CiB1aW50MzJfdCBhbWRncHVfYm9fZ2V0X3ByZWZlcnJlZF9waW5f
ZG9tYWluKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAotLSAKMi4zMS4xCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
