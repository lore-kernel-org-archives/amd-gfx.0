Return-Path: <SRS0=E5im=JG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10ADC433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 14:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A7C461041
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 14:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7C461041
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 327216EC32;
	Fri,  9 Apr 2021 14:52:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9107A6EC32
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Apr 2021 14:52:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AU0b/LxN6DKEWAqQJVvs28tn4aRh9DXTgR4TyHsXkdxwJWapM7o8SiXxxMthPNwGbhWCPSM7aJ4ntTCaK02vWK3v1j3pjTdXimIheHulxSXvJNi9OXkw7scih1bRaYvMW4T2TioFveVtsAfnYTPxWMZ7mbm/0/Dk3ohdPsGP5budnHvCCevGQbe5DGJFWfL0efR7qouN/+zZak6nPdJrHZGaykBUq18ZQwdpFkgIvyqVlzrrEq5zQuO7kka+Kk4xQFWsC0dnapn+NRsLZDQc9HnlQ5k1rJAHfqPXkZ3FUWbNDnitEvDL75xAml6oQlGVEBuRrUDiCSER+cY22bCqgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f00nsoRFVq11UgB+Y8Jo00LsarOwT907GckS5bBEy/M=;
 b=MhvK9qcVRshtQDlnwDgAhW7PssKF5b05coUDmSsUHvJ3N5i9YzWc+v/AamcIfz6sShYHLg0q7DEgai1rNUQHt1FdpOhxCWQuOaYFT5WFSTNjyxEXYIrZBTSr8pKiYrl+2n4mSRmoo4zUJ4W/YH+kcWrqF0Pv7AzFdcc+Qd34IpQFDqggz13CrUhaC/MLkcK1AcMALRSWMHrR0T4vkkS5MmbWl+lVkzCNHZIwWrWoY/Fkzx9FpLox2jXCncsb6n8EJ+LhTEl7+g9+73/v6rtQGde//3QX3Xe94G76zeHeG2wX5hgrAfPJygf1C6so0clKrSPNMyDJ7hIAvF7lPm8EBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f00nsoRFVq11UgB+Y8Jo00LsarOwT907GckS5bBEy/M=;
 b=YEsKgjWrsiY/RyN7tJu1U0n4XZrtenspeIc168gpIMbFz1nCECjT4zcwkxEGis74Vl9XALK3UHRsni2q+NjuIj85riS+5yvX3QingujN/UfATq97R6JXAK/t7Kk1wTiXfK0uS1BPmnx7fwUyV/yyWNyxn+QGHJiUJjOwFpni828=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM6PR12MB3994.namprd12.prod.outlook.com (2603:10b6:5:1cd::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.28; Fri, 9 Apr 2021 14:52:29 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::c5db:878f:cbb4:f136]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::c5db:878f:cbb4:f136%7]) with mapi id 15.20.3999.033; Fri, 9 Apr 2021
 14:52:29 +0000
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: Introduce functions for vram physical addr
 calculation
Date: Fri,  9 Apr 2021 10:47:31 -0400
Message-Id: <20210409144734.1591798-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To DM6PR12MB2761.namprd12.prod.outlook.com
 (2603:10b6:5:41::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from harish-base-compute.amd.com (165.204.55.251) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.32 via Frontend Transport; Fri, 9 Apr 2021 14:52:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbcf9540-958e-402b-cd38-08d8fb67190b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3994:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3994E957146093092FAC3B9D8C739@DM6PR12MB3994.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:451;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: otDL+8UrNBdzJ1IbOhRuWnMQPAJlnAUtQbWwlIER9R7Ds8fS7UwO506mFhO+4pLh70w0+c0+Zfuaf6O84r3djQoe09RghpHk1wcjjDaywoa+xQ5dMfJ5JTLueViK/9yZYeqboH0W8tDJwE0RG4xTG7W687IHt2YbDEu5os7QBzK6dLeWnThk3BisavYTzfziAtgH/YOKvkTtFK04rr3hc+IkK6W/u7uZRsrvdJjUHFOeHVWDq4dHXHowhX3NBQnPL0PGmkV1xtGahf/5YDSZ0jAo/aeNigfZDv4jLaYhKW20mEBrX+/v+bR9454VInVfa7IWMGqALxI33nqposCGRYWuOL1UzI6S/UOLviDVUVWTvbvD37lURo3QPXAjcb1j4m+Kqw3e2TeRXIWCeXbknf3XMiA5yHFS1qvrDVQa5PgXthQaHU7DPCUq3a8GU1ri6b6LG8oRGgeAmEHhQ82Txtm1v5prQJ3kEVpVlvmzrTTt2SEBtJv6zmwLvAr80uqoXY1gj4QiEgYtuaaURyS9kj1q+qxoxRQdfL1a46ClPc+MiuxVj9dlTAWjXj2jcLr72/8JtpN6f9sP7iktrp4RMlDwdvliNzulz7ggTlYMAVPhFHrwHHGw0NfWYSeIRZ3c9WMsdVXRhzi8f3iVfPZ5xCcsoemqYK0Ajrb6MTZNkq8sXnSfm4tXChl+jiPK+vBJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(36756003)(1076003)(478600001)(4326008)(8676002)(38350700001)(186003)(38100700001)(26005)(6666004)(16526019)(2906002)(6916009)(66946007)(86362001)(8936002)(2616005)(956004)(5660300002)(316002)(52116002)(7696005)(54906003)(66556008)(6486002)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cnpvSVY5VzA1SS9hVG4xcWxuOHF5ajNTMlR1cEdBK1JNTGxXZmpEajVBWlZr?=
 =?utf-8?B?T05UbE56RDRQbWpvN08xbXo3YVhkcitrUUtRc3V6ZXNjSGJKNE1NdGNrajRl?=
 =?utf-8?B?blBXVHZ3WHdHMXJtVEgwSjQvdTRMODJ1SVJ4WEhzTEk4ZjBDb1hqWFl5dlh4?=
 =?utf-8?B?MmhudkF6bDhqOVlTTFptYlZBbzVqRG84Ujc5WVpFRExoQjBITnArN0wwQUF5?=
 =?utf-8?B?Wi9jWUxnTzY0MndtclQzcUYrcU5YTXdybCtyOENjbDNBZjJwQUhTQWFxL2JU?=
 =?utf-8?B?SERhNUZCNFJoVkVRd2FSaFlvM3hJN1dpM3dvelNNa3pqZGpuUEUySFBkT0Yy?=
 =?utf-8?B?d3E1UkhMNWNldUExOCtXYjRydzJVU05XcFFaNXd5WW1XUmVsT1VGaDhvTjEy?=
 =?utf-8?B?NEV3Y3R3NnZQNjFUemM4UUpuZDJiSjRlL3BSZlVJbEhteDhIeVFHaCtWYjdx?=
 =?utf-8?B?WGVnY0Y0anNIbGo2c1p4QjMxR3o2Q0pGTklzYkx6Ukk2aWJPVzBuL0tMSUpn?=
 =?utf-8?B?ZlgxSEcrcGxQRmVnRXduUDVQTEFiNVFKWnEvWVNZVmlmeGpiUVJ4alhZcDRz?=
 =?utf-8?B?RkJERGJZWUZFRTd4dDNuWXJDaTdKNnRKNSsxV1RTTkNqN3VCekE1NDdGb2pp?=
 =?utf-8?B?aFdNMG5SbDI4UmJyZ1pIc1JBcm9HUlB4QVA2dFVveFRDbGNIbldSVzVONCtk?=
 =?utf-8?B?MytNdFlOOS9oU21XVjgxTjI4ckNnNDJPNndPSkloeHhubUYxcnNUQjFsaTRy?=
 =?utf-8?B?V2tKQ2orUFloN3BwWEZlejRHYStHMHhuY1k4ZmNMSUVVM2IvTjNrUmNTclYz?=
 =?utf-8?B?azZiUkRwWk1zMVBGYy9WQThxemZBYm5jaTFzWktPRWpPUnkrR1FCZXBhUkpI?=
 =?utf-8?B?cGpEWmxXa3I5KzNhSzFhS091dVBUQ1AyQjAvRWhEVjB0di9xTUxaZjR5aXdq?=
 =?utf-8?B?S3RYT090Q0RnNkpwU0s5NnlReGNyQjk1UU44ZHNQd0hNSlN0ajB3RFpiOUVO?=
 =?utf-8?B?clA4TFIwUEo3OGdHR05raUt0UTRaazJicFBHSDNudzNzck1nT2JrZTRuYkps?=
 =?utf-8?B?SXFNMDVSTmhMRjFiRzc1LzFXUUc1Y05Sd2pTeC9DNXFFcm82dVRkMFM5endF?=
 =?utf-8?B?SFRLc2drS1g3WkhRTHZNRCs0YVhHWHBJdFJOWHhsSzIzVWhrRkFOM1V2WG5p?=
 =?utf-8?B?ZnJGSzNsNVNPOGZQTjlPbmJFL3YxSHJzdVgvclhjRjlaUi9XTTlQSkt1Wm90?=
 =?utf-8?B?Z1pXZG9kYlVlMFp4R2pMTUk4ajAxeHZVaVNmbE1veXFwbENyWVJJUzJmbTZV?=
 =?utf-8?B?K0RCOXVOVEZ1dlYyU1NMVlJFbDZlZmh5Yk1mN2JmRmZMVWFHT0hYR04rYUEx?=
 =?utf-8?B?eFNoUUhSQUtKVFk3Vzlmd2kybjU2cFBybE00Nk1SakRGS3JkZzhIUW1PTzJK?=
 =?utf-8?B?dGpPRUE0Slh0ek9jWk4zYnN0K1FYMFJVQ1VmRTJzVGJOcU4xdXZ2bi9pNWtG?=
 =?utf-8?B?ZGxZcVEyeUk4Tk0xcFdQYmRaMHplK1JaQlBRYkNCVmhDNGZWT2hCSzBJczQ2?=
 =?utf-8?B?Y3B5UWR1U2VkcE82RTNzTWZPVk5JUm1CWEFqcDRMWmlZVXdqWkx3R0Jqdjhi?=
 =?utf-8?B?VkRMNE1Jdm1rUmRjdnNZTTBVK1cvYjl0WEFRSjV0Z201SDlibTVIVWZtSjA1?=
 =?utf-8?B?R3RnSS92ZUwwbnQwUkNXM201VUNwa2dpUHZ2UDBvSXRVNzJRaTFvV0kyeWlQ?=
 =?utf-8?Q?TbGne1QADA1kA1gQW7Adv06IzjXcG/b5M9sJdZ4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbcf9540-958e-402b-cd38-08d8fb67190b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 14:52:29.5221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugl0bvXxh00YuVwqKyXr5t/EvVZslydRjoa8Mk2fkMKgU42BUQkvhqvNYUslrgqxhG+7h8uZ4fq8mc+AqFq9vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3994
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
Cc: Oak Zeng <Oak.Zeng@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogT2FrIFplbmcgPE9hay5aZW5nQGFtZC5jb20+CgpBZGQgb25lIGZ1bmN0aW9uIHRvIGNh
bGN1bGF0ZSBCTydzIEdQVSBwaHlzaWNhbCBhZGRyZXNzLgpBbmQgYW5vdGhlciBmdW5jdGlvbiB0
byBjYWxjdWxhdGUgQk8ncyBDUFUgcGh5c2ljYWwgYWRkcmVzcy4KCnYyOiBVc2UgZnVuY3Rpb25z
IHZzIG1hY3JvcyAoQ2hyaXN0aWFuKQogICAgVXNlIG1vcmUgcHJvcGVyIGZ1bmN0aW9uIG5hbWVz
IChDaHJpc3RpYW4pCgpTaWduZWQtb2ZmLWJ5OiBPYWsgWmVuZyA8T2FrLlplbmdAYW1kLmNvbT4K
U3VnZ2VzdGVkLWJ5OiBMaWpvIExhemFyIDxsaWpvLmxhemFyQGFtZC5jb20+ClJldmlld2VkLWJ5
OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jIHwgMzYgKysrKysrKysrKysrKysrKysr
KysrKysrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oIHwgIDMgKysr
CiAyIGZpbGVzIGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZ21jLmMKaW5kZXggNGQzMjIzM2NkZTkyLi41NTk1ODJmYWMzNWUgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMKQEAgLTY4NSwzICs2ODUsMzkgQEAg
dm9pZCBhbWRncHVfZ21jX2luaXRfcGRiMChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAkv
KiBSZXF1aXJlcyBnYXJ0X3B0Yl9ncHVfcGEgdG8gYmUgNEsgYWxpZ25lZCAqLwogCWFtZGdwdV9n
bWNfc2V0X3B0ZV9wZGUoYWRldiwgYWRldi0+Z21jLnB0cl9wZGIwLCBpLCBnYXJ0X3B0Yl9ncHVf
cGEsIGZsYWdzKTsKIH0KKworLyoqCisgKiBhbWRncHVfZ21jX3ZyYW1fbWMycGEgLSBjYWxjdWxh
dGUgdnJhbSBidWZmZXIncyBwaHlzaWNhbCBhZGRyZXNzIGZyb20gTUMKKyAqIGFkZHJlc3MKKyAq
CisgKiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyCisgKiBAbWNfYWRkcjogTUMgYWRkcmVz
cyBvZiBidWZmZXIKKyAqLwordWludDY0X3QgYW1kZ3B1X2dtY192cmFtX21jMnBhKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LCB1aW50NjRfdCBtY19hZGRyKQoreworCXJldHVybiBtY19hZGRy
IC0gYWRldi0+Z21jLnZyYW1fc3RhcnQgKyBhZGV2LT52bV9tYW5hZ2VyLnZyYW1fYmFzZV9vZmZz
ZXQ7Cit9CisKKy8qKgorICogYW1kZ3B1X2dtY192cmFtX3BhIC0gY2FsY3VsYXRlIHZyYW0gYnVm
ZmVyIG9iamVjdCdzIHBoeXNpY2FsIGFkZHJlc3MgZnJvbQorICogR1BVJ3MgdmlldworICoKKyAq
IEBhZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50ZXIKKyAqIEBibzogYW1kZ3B1IGJ1ZmZlciBvYmpl
Y3QKKyAqLwordWludDY0X3QgYW1kZ3B1X2dtY192cmFtX3BhKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X2JvICpibykKK3sKKwlyZXR1cm4gYW1kZ3B1X2dtY192cmFt
X21jMnBhKGFkZXYsIGFtZGdwdV9ib19ncHVfb2Zmc2V0KGJvKSk7Cit9CisKKy8qKgorICogYW1k
Z3B1X2dtY192cmFtX2NwdV9wYSAtIGNhbGN1bGF0ZSB2cmFtIGJ1ZmZlciBvYmplY3QncyBwaHlz
aWNhbCBhZGRyZXNzCisgKiBmcm9tIENQVSdzIHZpZXcKKyAqCisgKiBAYWRldjogYW1kZ3B1X2Rl
dmljZSBwb2ludGVyCisgKiBAYm86IGFtZGdwdSBidWZmZXIgb2JqZWN0CisgKi8KK3VpbnQ2NF90
IGFtZGdwdV9nbWNfdnJhbV9jcHVfcGEoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVj
dCBhbWRncHVfYm8gKmJvKQoreworCXJldHVybiBhbWRncHVfYm9fZ3B1X29mZnNldChibykgLSBh
ZGV2LT5nbWMudnJhbV9zdGFydCArIGFkZXYtPmdtYy5hcGVyX2Jhc2U7Cit9CmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmggYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmgKaW5kZXggY2JiNzczNWM2OTg4Li5iMmY0NzNjZmY2
N2IgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaAor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmgKQEAgLTM0MSw0ICsz
NDEsNyBAQCBhbWRncHVfZ21jX3NldF92bV9mYXVsdF9tYXNrcyhzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwgaW50IGh1Yl90eXBlLAogdm9pZCBhbWRncHVfZ21jX2dldF92Ymlvc19hbGxvY2F0
aW9ucyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7CiAKIHZvaWQgYW1kZ3B1X2dtY19pbml0
X3BkYjAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwordWludDY0X3QgYW1kZ3B1X2dtY192
cmFtX21jMnBhKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1aW50NjRfdCBtY19hZGRyKTsK
K3VpbnQ2NF90IGFtZGdwdV9nbWNfdnJhbV9wYShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwg
c3RydWN0IGFtZGdwdV9ibyAqYm8pOwordWludDY0X3QgYW1kZ3B1X2dtY192cmFtX2NwdV9wYShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV9ibyAqYm8pOwogI2VuZGlm
Ci0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
