Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4EFC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 14:27:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A7D613E9
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 14:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A7D613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DB636E079;
	Wed, 12 May 2021 14:27:18 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A1226E079;
 Wed, 12 May 2021 14:27:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qwf5r8AfWrRbfO0kWP9Z3w8tP55sHFPhLqGDcbohMp+jzONLHzbCS9jBtPViP5BZgtzyKMFh936Qr2TEGpcxhm8/W/wOqk2i/PA6U19R8vERL8JKCNwXA1QiHanTQ2IWeky972pD+i4i8cjzIuoQxhgX6Z7yAozQ3jzjJUeT+Hrbg/WFsKRacWUW4IxhtPZJnzXxeBpkO6XVGR2tY33gxCj0oS9jXyhll/SgV/TolY8/AXXXMnHpcIjCeWC3/U8nUQr7BguWSeK3dO/Ztnkx/5bJLvq/FRHqRwfZzwnIUGj1VW44SJkxVagD9DH1PBZghspawgcrdUAfrypdIAcq8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4f76bDjmlOpO1JyP2h+5eU+QH8A/4mNsiKFTRoZXVXM=;
 b=L0HTceAVIYPoSOgcP0SamgoUazIyguYMCkCC2mpBgTmejK7ankvtEE035z8fFBy892Cfe1CSMwHZdk7m7Ff1yb1Av0s449et6RFzANLGYEgjrHkO3OhNagyL2wRXRp0EddC+Ho04BgOhpA9h8rx/sPuNFQIr6uasAA9O3H14scpRqu0ritQIG0DRorDWP1q1E+Yat9DhaydHa46u4Yam024VYt4lUkUzPQUDHqxWU+oHY5E3mTD3UHVDlPOuVd+JfW3wByw2cvX+DGvbGkSoUA3B+uPmlsII0edKZ0ZAjwxV2RRKlcZAcW+sewi4D/7gg54SePjXT3/YGa9ct2uQcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4f76bDjmlOpO1JyP2h+5eU+QH8A/4mNsiKFTRoZXVXM=;
 b=1hkQt4g3bDxNe3an6O7ZbvX4PCX8YOw7/a/4xupN0RkJ4KXfNxS3duWx1pP3BAm6BVbZa59uPViFrglbn5rTqRdC6djZJ6wTawo6smnUa7+GOciuKDktw4ap63JuTc+VIQodbixvzQUgfPnztPPf1DtJgVz6BvP9ziTJNUZdzP8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Wed, 12 May
 2021 14:27:15 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 14:27:15 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
 daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
Subject: [PATCH v7 04/16] drm/amdgpu: Add early fini callback
Date: Wed, 12 May 2021 10:26:36 -0400
Message-Id: <20210512142648.666476-5-andrey.grodzovsky@amd.com>
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
 Transport; Wed, 12 May 2021 14:27:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9392f4b3-d6d9-4062-2df4-08d915520a42
X-MS-TrafficTypeDiagnostic: SA0PR12MB4576:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4576891F974AADAB30BADABEEA529@SA0PR12MB4576.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UFHUdEwcyTwLchxUswSHmi1j6WFGVrMRTJi4PnqCwCNZLAgRZl+JbFPbLhoeX2crB47CQgIaYHThMZrTjg1kyyv3gNSkC3MydPKkELX4pm1KsVYUNlNyZwUUU0DIPImE8ulpkfOsr7vAtLQ4uVTS9/l7PXXvloFuX15RTVSZD5URfAfPNwzscvttYRcs2E1wX7ILqUByPyRLJXwcVFlYwWZEfUvALbWmmjce+5nskBV5V9/RhUtppQG6rrgB7QxfZfH3aVzm/EeWRAeQFwHUiyposg3FQ4YaYsYXxd3yP43nzjWOzLQExIjWPQk8ABqy7U/8yh8Zp5YAJwWTbGijeLl1ZjSOFC0BNfgOrfxjIiKSPbdcKR4BpRhRfG9zLyQGEmMWhVPZ08bBwsNNawg0iqlSMLrQ70o/k/tPwkO4D5HJ2zZHzGts/xwZBdV3WBEiw9/AoSC8r8zNL8utBZmyTWBxlO3jmVgttKiAu11V/3eulXUhMZBLmloqOMgzPSKQ9bJI+3WDssyprQ9exGgylvQUmHWS6aAh0W5j8K8L0BeacsDlz6WscYGFl0r8h4yNBwID2oTWgSjhpWTJiQjayw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(66574015)(38100700002)(5660300002)(1076003)(6666004)(186003)(316002)(16526019)(8676002)(83380400001)(66476007)(2906002)(6636002)(86362001)(52116002)(36756003)(54906003)(2616005)(66946007)(66556008)(8936002)(6512007)(6506007)(44832011)(478600001)(4326008)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aWptWnhudDAveGY2ejZzUmt1WW5vR3IyQ0JUcnZNSmd2OHhEbDlJdkwxMTVj?=
 =?utf-8?B?cGd0ejZyQmI3cjg3bk5Tb3lSV3NQNGp0bDgwclpCMUYrSmVuamIweDc2VjRw?=
 =?utf-8?B?RndZZ0grK2pUZnlTczdmcjNmbGFrSml5N1dybVp1TXRIbjhhQXBKU0k5WGVv?=
 =?utf-8?B?OEFjSHBZMHFPZUtkcWg0N1RqVThCdWlkQ3l1cnArODdzd2hQUjlhc3VPZ1BD?=
 =?utf-8?B?emdVY1N5a0llaGptT0cyckNKZ081d3QweFFiUWpWVkN0VlYyTDVtSnQzeWha?=
 =?utf-8?B?NUpsWTRGYXBZY1p2MldiT1p6N2JRRWdZV1VFcVk2WGpYbFZmZUdSRTkrOG5M?=
 =?utf-8?B?ekwyZnNtVXhWaGxwYy9JbEh3U052dU12NDBOcGlxcU1rcm5MU1pMZ0VGNGJw?=
 =?utf-8?B?ODRuVDE1RGprNmlkSFJTMTRzK1J0K3FXUGJqNE15Si9VVUsydExKbVhJTnRy?=
 =?utf-8?B?bXduWEF1OGlRZGdCQXcvQkloYnpXcWZWQTg5R0JoUHJpbFUyT0JUMXpLQ3dZ?=
 =?utf-8?B?b2VmeVl2YUR6RlVnaG5tbHh4Ti9Edlp5ODdtSEhzVVRjbC9XdHBNSmVuRndK?=
 =?utf-8?B?UWg4MW5kdXMxdXQybm8vZC9PaWZ6bUVBeFA4NUY0NGVKc054eHlxQlpOa1d5?=
 =?utf-8?B?a3ZwSTV4OFJOc3FrUi9IcncyOVJON3BYTmIxckNLQ09EYjVzeldGbVRKNUZ3?=
 =?utf-8?B?ZU9SQkV2QUFCaW5HQzdRVUtaanhZNTVrY1QzOGhzMDhZUE9YZFBtRFdZQ0hH?=
 =?utf-8?B?aDlsejRjU0FhN0VoVXV3c3N0OXlHK2JjU1Z3cmtybmZyRkUySEpaY0VlYmlE?=
 =?utf-8?B?bndZSk5UaEhRSkhZamZIa2pkdjBHVDAwd2oxKy96RTM3UzRNYjhJOWJFVDBj?=
 =?utf-8?B?RnVNMCtoR3hQMVBWdlhLNmR3ZDVsMDYzMTd0SG52ZlI5MkpVWS9lRkpia2xN?=
 =?utf-8?B?RXNvRFpOdysrdTZ0VkF3c0p4cFllcmVzUW5XMTN4Ky9SaUUwdzFQaGVRN3p0?=
 =?utf-8?B?ZHcvYXpoTk5ZeVc4d0FQbGE4Rzd6VkhvZ21yMVdIbjhPS09pbmt4M20yNUFD?=
 =?utf-8?B?N0FEQzM0QndYQ3AxN1Z1QzV0cVdIcm5QMnM0Q3VNSEhlY0M2SjZ3WmxnQThG?=
 =?utf-8?B?YmVFQXlXTXRmWUZUMk10a3E0VmwzRW5Qc0RKaHYvS3gyMUl6WVFHSzFoSkw3?=
 =?utf-8?B?OTNDWEo5OWV0Ym1lOWNSc0h6d0Vkc2szZEtWS05BaDJWdWZZNEt2K2x1VjdD?=
 =?utf-8?B?VE0xNDhYdEwzMUkyZHZNSXR1cmdlWmVCUUw0cCtSK3VBN1ZIL3UxYlNiSEU2?=
 =?utf-8?B?N2h1SXZlOEZSU0RJcUVERUxuZGRLZGI2TG5NVlp6UUdEQ3RubmZsTFlKa1dp?=
 =?utf-8?B?ZW5KdzhrSnBISjZlUVg2WHQrRVRoamY5TTRzWGozM2JJbFB0Z1lYRDVRRTNn?=
 =?utf-8?B?eW9qMFdJZ09BT2FGaGZpdURqYmIybTl1dVphU29uWHMzYmc4dk4waGlBcU12?=
 =?utf-8?B?WnI1UUpuMjF1VnFBTWswYnZCUDRyRDFEL0pQVTNqaFpUQWFXWk02UnZvSlN6?=
 =?utf-8?B?N3NYckY1OXlHeS9WS0tTVDZlMUg2dVRQWGZkR01ZZ2FiV2sxRE1kRno3Ris2?=
 =?utf-8?B?OHBaTDdOYWV4Y0hYci93dDBlRzBSZFF2U3NIeURuenI2OTZkRmJ4cnAxWGQ3?=
 =?utf-8?B?QnZRZ3luYlpZaGVoL1NpMjRWVG9nRjI0b1VxMVZMQTZyK2JMdnZSYVlZZnVO?=
 =?utf-8?B?TFkxYUpYaS81U3FDM0hjR0p2V05ESWhuQ1Y5L3RPbTBYY1lVSFhkWTRoaUkw?=
 =?utf-8?B?ZEloSmcwSGViNE9YSGwwZjF5NnBvRzJqeTNrZUZ3NU5HU2lIbllxMmFMVi9Q?=
 =?utf-8?B?a1RtRndlZVRJT2RtVkw3TndPcUtFWmhURHhzL3NBZnAzTHc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9392f4b3-d6d9-4062-2df4-08d915520a42
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 14:27:15.4885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: liFYfae1W6+s8/aIwfxYDzjFQSW5hCvgMd17cUKymWclMlydyqDz4/6rAhmhL9ZeOwG8Q1tLnq/uByJjuLgvNg==
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

VXNlIGl0IHRvIGNhbGwgZGlzcGx5IGNvZGUgZGVwZW5kZW50IG9uIGRldmljZS0+ZHJ2X2RhdGEK
YmVmb3JlIGl0J3Mgc2V0IHRvIE5VTEwgb24gZGV2aWNlIHVucGx1ZwoKdjU6IE1vdmUgSFcgZmlu
aWxpemF0aW9uIGludG8gdGhpcyBjYWxsYmFjayB0byBwcmV2ZW50IE1NSU8gYWNjZXNzZXMKICAg
IHBvc3QgY3BpIHJlbW92ZS4KClNpZ25lZC1vZmYtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRy
ZXkuZ3JvZHpvdnNreUBhbWQuY29tPgpBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYyAgICB8IDU5ICsrKysrKysrKysrKystLS0tLS0KIC4uLi9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDEyICsrKy0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvaW5jbHVkZS9hbWRfc2hhcmVkLmggICAgICB8ICAyICsKIDMgZmlsZXMgY2hhbmdlZCwgNTIg
aW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jCmluZGV4IDM3NjBjZTdkOGZmOC4uMTg1OThlZGExOGY2IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCkBAIC0yNTU4LDM0ICsy
NTU4LDI2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RldmljZV9pcF9sYXRlX2luaXQoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpCiAJcmV0dXJuIDA7CiB9CiAKLS8qKgotICogYW1kZ3B1X2Rldmlj
ZV9pcF9maW5pIC0gcnVuIGZpbmkgZm9yIGhhcmR3YXJlIElQcwotICoKLSAqIEBhZGV2OiBhbWRn
cHVfZGV2aWNlIHBvaW50ZXIKLSAqCi0gKiBNYWluIHRlYXJkb3duIHBhc3MgZm9yIGhhcmR3YXJl
IElQcy4gIFRoZSBsaXN0IG9mIGFsbCB0aGUgaGFyZHdhcmUKLSAqIElQcyB0aGF0IG1ha2UgdXAg
dGhlIGFzaWMgaXMgd2Fsa2VkIGFuZCB0aGUgaHdfZmluaSBhbmQgc3dfZmluaSBjYWxsYmFja3MK
LSAqIGFyZSBydW4uICBod19maW5pIHRlYXJzIGRvd24gdGhlIGhhcmR3YXJlIGFzc29jaWF0ZWQg
d2l0aCBlYWNoIElQCi0gKiBhbmQgc3dfZmluaSB0ZWFycyBkb3duIGFueSBzb2Z0d2FyZSBzdGF0
ZSBhc3NvY2lhdGVkIHdpdGggZWFjaCBJUC4KLSAqIFJldHVybnMgMCBvbiBzdWNjZXNzLCBuZWdh
dGl2ZSBlcnJvciBjb2RlIG9uIGZhaWx1cmUuCi0gKi8KLXN0YXRpYyBpbnQgYW1kZ3B1X2Rldmlj
ZV9pcF9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQorc3RhdGljIGludCBhbWRncHVf
ZGV2aWNlX2lwX2ZpbmlfZWFybHkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiB7CiAJaW50
IGksIHI7CiAKLQlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpICYmIGFkZXYtPnZpcnQucmFzX2lu
aXRfZG9uZSkKLQkJYW1kZ3B1X3ZpcnRfcmVsZWFzZV9yYXNfZXJyX2hhbmRsZXJfZGF0YShhZGV2
KTsKKwlmb3IgKGkgPSAwOyBpIDwgYWRldi0+bnVtX2lwX2Jsb2NrczsgaSsrKSB7CisJCWlmICgh
YWRldi0+aXBfYmxvY2tzW2ldLnZlcnNpb24tPmZ1bmNzLT5lYXJseV9maW5pKQorCQkJY29udGlu
dWU7CiAKLQlhbWRncHVfcmFzX3ByZV9maW5pKGFkZXYpOworCQlyID0gYWRldi0+aXBfYmxvY2tz
W2ldLnZlcnNpb24tPmZ1bmNzLT5lYXJseV9maW5pKCh2b2lkICopYWRldik7CisJCWlmIChyKSB7
CisJCQlEUk1fREVCVUcoImVhcmx5X2Zpbmkgb2YgSVAgYmxvY2sgPCVzPiBmYWlsZWQgJWRcbiIs
CisJCQkJICBhZGV2LT5pcF9ibG9ja3NbaV0udmVyc2lvbi0+ZnVuY3MtPm5hbWUsIHIpOworCQl9
CisJfQogCi0JaWYgKGFkZXYtPmdtYy54Z21pLm51bV9waHlzaWNhbF9ub2RlcyA+IDEpCi0JCWFt
ZGdwdV94Z21pX3JlbW92ZV9kZXZpY2UoYWRldik7CisJYW1kZ3B1X2FtZGtmZF9zdXNwZW5kKGFk
ZXYsIGZhbHNlKTsKIAogCWFtZGdwdV9kZXZpY2Vfc2V0X3BnX3N0YXRlKGFkZXYsIEFNRF9QR19T
VEFURV9VTkdBVEUpOwogCWFtZGdwdV9kZXZpY2Vfc2V0X2NnX3N0YXRlKGFkZXYsIEFNRF9DR19T
VEFURV9VTkdBVEUpOwogCi0JYW1kZ3B1X2FtZGtmZF9kZXZpY2VfZmluaShhZGV2KTsKLQogCS8q
IG5lZWQgdG8gZGlzYWJsZSBTTUMgZmlyc3QgKi8KIAlmb3IgKGkgPSAwOyBpIDwgYWRldi0+bnVt
X2lwX2Jsb2NrczsgaSsrKSB7CiAJCWlmICghYWRldi0+aXBfYmxvY2tzW2ldLnN0YXR1cy5odykK
QEAgLTI2MTYsNiArMjYwOCwzMyBAQCBzdGF0aWMgaW50IGFtZGdwdV9kZXZpY2VfaXBfZmluaShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAkJYWRldi0+aXBfYmxvY2tzW2ldLnN0YXR1cy5o
dyA9IGZhbHNlOwogCX0KIAorCXJldHVybiAwOworfQorCisvKioKKyAqIGFtZGdwdV9kZXZpY2Vf
aXBfZmluaSAtIHJ1biBmaW5pIGZvciBoYXJkd2FyZSBJUHMKKyAqCisgKiBAYWRldjogYW1kZ3B1
X2RldmljZSBwb2ludGVyCisgKgorICogTWFpbiB0ZWFyZG93biBwYXNzIGZvciBoYXJkd2FyZSBJ
UHMuICBUaGUgbGlzdCBvZiBhbGwgdGhlIGhhcmR3YXJlCisgKiBJUHMgdGhhdCBtYWtlIHVwIHRo
ZSBhc2ljIGlzIHdhbGtlZCBhbmQgdGhlIGh3X2ZpbmkgYW5kIHN3X2ZpbmkgY2FsbGJhY2tzCisg
KiBhcmUgcnVuLiAgaHdfZmluaSB0ZWFycyBkb3duIHRoZSBoYXJkd2FyZSBhc3NvY2lhdGVkIHdp
dGggZWFjaCBJUAorICogYW5kIHN3X2ZpbmkgdGVhcnMgZG93biBhbnkgc29mdHdhcmUgc3RhdGUg
YXNzb2NpYXRlZCB3aXRoIGVhY2ggSVAuCisgKiBSZXR1cm5zIDAgb24gc3VjY2VzcywgbmVnYXRp
dmUgZXJyb3IgY29kZSBvbiBmYWlsdXJlLgorICovCitzdGF0aWMgaW50IGFtZGdwdV9kZXZpY2Vf
aXBfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKK3sKKwlpbnQgaSwgcjsKKworCWlm
IChhbWRncHVfc3Jpb3ZfdmYoYWRldikgJiYgYWRldi0+dmlydC5yYXNfaW5pdF9kb25lKQorCQlh
bWRncHVfdmlydF9yZWxlYXNlX3Jhc19lcnJfaGFuZGxlcl9kYXRhKGFkZXYpOworCisJYW1kZ3B1
X3Jhc19wcmVfZmluaShhZGV2KTsKKworCWlmIChhZGV2LT5nbWMueGdtaS5udW1fcGh5c2ljYWxf
bm9kZXMgPiAxKQorCQlhbWRncHVfeGdtaV9yZW1vdmVfZGV2aWNlKGFkZXYpOworCisJYW1kZ3B1
X2FtZGtmZF9kZXZpY2VfZmluaV9zdyhhZGV2KTsKIAogCWZvciAoaSA9IGFkZXYtPm51bV9pcF9i
bG9ja3MgLSAxOyBpID49IDA7IGktLSkgewogCQlpZiAoIWFkZXYtPmlwX2Jsb2Nrc1tpXS5zdGF0
dXMuc3cpCkBAIC0zNjgzLDYgKzM3MDIsOCBAQCB2b2lkIGFtZGdwdV9kZXZpY2VfZmluaV9odyhz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAlhbWRncHVfZmJkZXZfZmluaShhZGV2KTsKIAog
CWFtZGdwdV9pcnFfZmluaV9odyhhZGV2KTsKKworCWFtZGdwdV9kZXZpY2VfaXBfZmluaV9lYXJs
eShhZGV2KTsKIH0KIAogdm9pZCBhbWRncHVfZGV2aWNlX2Zpbmlfc3coc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1k
Z3B1X2RtL2FtZGdwdV9kbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9k
bS9hbWRncHVfZG0uYwppbmRleCAyOTY3MDRjZTM3NjguLjZjMmM2YTUxY2U2YyAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCkBAIC0x
MjUxLDYgKzEyNTEsMTUgQEAgc3RhdGljIGludCBhbWRncHVfZG1faW5pdChzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldikKIAlyZXR1cm4gLUVJTlZBTDsKIH0KIAorc3RhdGljIGludCBhbWRncHVf
ZG1fZWFybHlfZmluaSh2b2lkICpoYW5kbGUpCit7CisJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKiloYW5kbGU7CisKKwlhbWRncHVfZG1fYXVkaW9f
ZmluaShhZGV2KTsKKworCXJldHVybiAwOworfQorCiBzdGF0aWMgdm9pZCBhbWRncHVfZG1fZmlu
aShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsKIAlpbnQgaTsKQEAgLTEyNTksOCArMTI2
OCw2IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9kbV9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQogCQlkcm1fZW5jb2Rlcl9jbGVhbnVwKCZhZGV2LT5kbS5tc3RfZW5jb2RlcnNbaV0uYmFz
ZSk7CiAJfQogCi0JYW1kZ3B1X2RtX2F1ZGlvX2ZpbmkoYWRldik7Ci0KIAlhbWRncHVfZG1fZGVz
dHJveV9kcm1fZGV2aWNlKCZhZGV2LT5kbSk7CiAKICNpZiBkZWZpbmVkKENPTkZJR19EUk1fQU1E
X1NFQ1VSRV9ESVNQTEFZKQpAQCAtMjI5OCw2ICsyMzA1LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBhbWRfaXBfZnVuY3MgYW1kZ3B1X2RtX2Z1bmNzID0gewogCS5sYXRlX2luaXQgPSBkbV9sYXRl
X2luaXQsCiAJLnN3X2luaXQgPSBkbV9zd19pbml0LAogCS5zd19maW5pID0gZG1fc3dfZmluaSwK
KwkuZWFybHlfZmluaSA9IGFtZGdwdV9kbV9lYXJseV9maW5pLAogCS5od19pbml0ID0gZG1faHdf
aW5pdCwKIAkuaHdfZmluaSA9IGRtX2h3X2ZpbmksCiAJLnN1c3BlbmQgPSBkbV9zdXNwZW5kLApk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9zaGFyZWQuaCBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hbWRfc2hhcmVkLmgKaW5kZXggNDNlZDYyOTFiMmI4
Li4xYWQ1NmRhNDg2ZTQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9h
bWRfc2hhcmVkLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9zaGFyZWQu
aApAQCAtMjQwLDYgKzI0MCw3IEBAIGVudW0gYW1kX2RwbV9mb3JjZWRfbGV2ZWw7CiAgKiBAbGF0
ZV9pbml0OiBzZXRzIHVwIGxhdGUgZHJpdmVyL2h3IHN0YXRlIChwb3N0IGh3X2luaXQpIC0gT3B0
aW9uYWwKICAqIEBzd19pbml0OiBzZXRzIHVwIGRyaXZlciBzdGF0ZSwgZG9lcyBub3QgY29uZmln
dXJlIGh3CiAgKiBAc3dfZmluaTogdGVhcnMgZG93biBkcml2ZXIgc3RhdGUsIGRvZXMgbm90IGNv
bmZpZ3VyZSBodworICogQGVhcmx5X2Zpbmk6IHRlYXJzIGRvd24gc3R1ZmYgYmVmb3JlIGRldiBk
ZXRhY2hlZCBmcm9tIGRyaXZlcgogICogQGh3X2luaXQ6IHNldHMgdXAgdGhlIGh3IHN0YXRlCiAg
KiBAaHdfZmluaTogdGVhcnMgZG93biB0aGUgaHcgc3RhdGUKICAqIEBsYXRlX2Zpbmk6IGZpbmFs
IGNsZWFudXAKQEAgLTI2OCw2ICsyNjksNyBAQCBzdHJ1Y3QgYW1kX2lwX2Z1bmNzIHsKIAlpbnQg
KCpsYXRlX2luaXQpKHZvaWQgKmhhbmRsZSk7CiAJaW50ICgqc3dfaW5pdCkodm9pZCAqaGFuZGxl
KTsKIAlpbnQgKCpzd19maW5pKSh2b2lkICpoYW5kbGUpOworCWludCAoKmVhcmx5X2ZpbmkpKHZv
aWQgKmhhbmRsZSk7CiAJaW50ICgqaHdfaW5pdCkodm9pZCAqaGFuZGxlKTsKIAlpbnQgKCpod19m
aW5pKSh2b2lkICpoYW5kbGUpOwogCXZvaWQgKCpsYXRlX2ZpbmkpKHZvaWQgKmhhbmRsZSk7Ci0t
IAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
