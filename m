Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69405C43446
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D8852075D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R20yu+JB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8852075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2C086E02E;
	Tue, 28 Jul 2020 23:35:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AD346E02E
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 23:35:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BM+TvAwFM0FdZYlEm17cd8DVPCni3mYgMLwxY+is4fXwKE4QXpXUP/Pz93mnSxh7w/52Be+Gur5vk54dUNT6VTaxo/hwXq1UgoCY3r7bb3my11/NhCut8r6KLQv7URrST2AXdFHe764IRP8nf+KNBzg3xHA3/5U+aHn4kmf97Y42nensrhT8bikDq5Jj4wKJdueGNY1qCdDZuwQ0eVCG9FjOqCehzOsfFdntFRfAtl37ZUi3LNlltcRb7loGHQ4LFQ+s5PPvZVioG1ymVXvbdXugW7K1/anf5icE3WY/WvrsW7M1tUZ4tH+7HKVkiSbyZp2mJ78C8iQq9PDvFwpf9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ph23AjPcFQJgxIvTkZjiqHqR6zx55EkBWTzuTZ20oB4=;
 b=ehEln3avNf6Lwsn1Axs3MfwFJllB3zo3Sbypq84hnrG7UNS+3sX2L/rkZwdx6IVH/4C6/GsfJgrUQJgtNrMQro+CHWqpDKXQwF4dgMVNWeZXYVBveVxuqsXZtCmH/UxeyK07GPPIR0nbIzX+dnbiTUDRpNFIZJPDRL5ttOUMg8PKV7/UCEU5bZp3wMHTFEokkn0N2PED+lZyn3WLwS7wkihJA5SYgrlWhL6ffHPY5UlTpo5ynWt1XXKxej6csNHr5DGIa9NBSFkgqVsXfVieBGtfxNMhAIFBsBfO9laTRUdphoGCm1RXAZ8vCSRywGUCpUa8gbO67nUymSPJMx4lNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ph23AjPcFQJgxIvTkZjiqHqR6zx55EkBWTzuTZ20oB4=;
 b=R20yu+JB5VMVqNzjlRdlJRTHWdIU1Z7cgl/7WI/dnb/OrY5wQXQNrOiT91bFkE2PEQkxkt6SoCz4Xrs2ZYcZSqindAMPra53EGV2G8NyWAdmVEkMx5HO3y8KX1UM6Scda5S8DGl8ILOWiayaMpsbZAKsfCrq4neHd4/Mi5kNPMM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2407.namprd12.prod.outlook.com (2603:10b6:4:b4::24) by
 DM6PR12MB4563.namprd12.prod.outlook.com (2603:10b6:5:28e::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23; Tue, 28 Jul 2020 23:35:20 +0000
Received: from DM5PR12MB2407.namprd12.prod.outlook.com
 ([fe80::9c20:aa3e:1b50:7ce5]) by DM5PR12MB2407.namprd12.prod.outlook.com
 ([fe80::9c20:aa3e:1b50:7ce5%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 23:35:20 +0000
Subject: Re: [PATCH 01/14] drm/amdgpu: handle bo size 0 in
 amdgpu_bo_create_kernel_at
To: amd-gfx@lists.freedesktop.org
References: <20200728224605.3919-1-alexander.deucher@amd.com>
 <20200728224605.3919-2-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <f002c7a7-27f6-b35d-851f-ded643768bf1@amd.com>
Date: Tue, 28 Jul 2020 19:35:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200728224605.3919-2-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::24) To DM5PR12MB2407.namprd12.prod.outlook.com
 (2603:10b6:4:b4::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.61.76) by
 YTOPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Tue, 28 Jul 2020 23:35:19 +0000
X-Originating-IP: [142.117.61.76]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8a6e1ef6-8b8d-4415-a86c-08d8334ee407
X-MS-TrafficTypeDiagnostic: DM6PR12MB4563:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4563B5F381744AC75B69D6AE92730@DM6PR12MB4563.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ykci9nRrRyuOuYUceBgFool3sUOM3Ddxi1bSUtddDbP/weCHBXy/3XGzADaHmb7VRGCmXp83vIq38495keMt1+MCHlkWCO+63b7KDh4YBNosJtlBWO3EYrkCNy5XnXAjTool7/RxjJpSZKOd2DQ1GD8StXNZ2wJdwCf9KndGP8VrEQVMFDRUMOhKukPmPKtbZyGBnFqtbwEtH6xjbNQ/PVMn8ygpPnx4n8NWrQssMFgsToYksZ9dGLpGSrZcdkAjp6pogAvotvYk9VMsiZ1HXnXWEfOn/MgO8Aamn30FwDBOaEVYRCRMI2fc72EPR4+SKom5DfJQu+OHFaTHEtnzc7Jk66LNlK/6BzrIeACuNwKivmF6ALefXuc4pSI4CyPN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2407.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(16576012)(316002)(66946007)(86362001)(6486002)(6916009)(66556008)(66476007)(16526019)(31686004)(478600001)(186003)(26005)(52116002)(2616005)(2906002)(8936002)(44832011)(956004)(4744005)(36756003)(5660300002)(31696002)(8676002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 75Mr8HcPGCcgqfHzTHX4qtTxJ3oWcVChRoaX5h1L/S/GK7dbxDFEAyfGdmiU/jzSrNPyMNYTcSc0RSBBvX6JUQ/JTvvU9wG8n3ZzhGwUn64FGp3nsifISRNnRrcs6bi0baR1DrbbYBmPB18FC8SK4yKRxX3r5Mrc3I5JvkOig0Eo3RnY+G8Um+LYpdN15YXOjkhAeeXw9w9ba64h705eL9HrxrGLW0kmgkkUYVuoWGUp5i8PU/dddn+vxFDocszo1jtj6satpmMLvphDv96hRG2Wnmswcr9A5CUF79I+l2/s8IQ1uu6svb8w4kFmWxTt1E9NGwfE/ez4FjGbUD4WgeIJlot9Z1KB3py4aggmheKju1dNz1zLFXHwcf9SbtB1eUQtzTXg+iMm7zNQPfa+UX8M5psPLEffj0notHjTa9qkP4TU/t7NFENBlr4/rj836Ix/HziRXSqAYu6lDnIzFcQrsXNIOpqiDsnjkYL9TiNAuJ7Zoo91kl/oNWUtCioZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6e1ef6-8b8d-4415-a86c-08d8334ee407
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 23:35:20.0587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QAWN4xY7Jfef0y3boIybj0X3kz0nrIZB3Iaw0JxXLXz56RdWSiM5hRoTeAAY0J4/Kzqa5iB9cMTS3/ehCpHDsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4563
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

QW0gMjAyMC0wNy0yOCB1bSA2OjQ1IHAubS4gc2NocmllYiBBbGV4IERldWNoZXI6Cj4gSnVzdCBy
ZXR1cm4gZWFybHkgdG8gbWF0Y2ggb3RoZXIgYm9fY3JlYXRlIGZ1bmN0aW9ucy4KPgo+IFNpZ25l
ZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiAtLS0K
PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIHwgNSArKysrKwo+
ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4gaW5kZXggNWFjN2I1NTYxNDc1Li4xNmEzN2NhYTY1
NGEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVj
dC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4g
QEAgLTM2Niw2ICszNjYsMTEgQEAgaW50IGFtZGdwdV9ib19jcmVhdGVfa2VybmVsX2F0KHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAJdW5zaWduZWQgaW50IGk7Cj4gIAlpbnQgcjsKPiAg
Cj4gKwlpZiAoIXNpemUpIHsKPiArCQlhbWRncHVfYm9fdW5yZWYoYm9fcHRyKTsKCkkgd2FzIGdv
aW5nIHRvIHNheSwgdW5yZWZmaW5nIHRoZSBib19wdHIgYmVmb3JlIGFsbG9jYXRpbmcgYW55dGhp
bmcKc2VlbXMgd2VpcmQuIEJ1dCBhbWRncHVfYm9fY3JlYXRlX3Jlc2VydmVkLCB3aGljaCBpcyBj
YWxsZWQganVzdCBiZWxvdywKZG9lcyB0aGUgc2FtZSB0aGluZy4gU28gdGhpcyBkb2Vzbid0IHJl
YWxseSBjaGFuZ2UgYW55dGhpbmcuIE5ldmVyIG1pbmQuCgpSZWdhcmRzLArCoCBGZWxpeAoKCj4g
KwkJcmV0dXJuIDA7Cj4gKwl9Cj4gKwo+ICAJb2Zmc2V0ICY9IFBBR0VfTUFTSzsKPiAgCXNpemUg
PSBBTElHTihzaXplLCBQQUdFX1NJWkUpOwo+ICAKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
