Return-Path: <SRS0=dhbh=HE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4E0C4332E
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 16:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9483164F49
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 16:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9483164F49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 457956E946;
	Tue,  2 Feb 2021 16:01:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5646C6E946
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Feb 2021 16:01:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqeGrkamtOSAQuo2VihKpokm4bHEXvmV8XIy07yhUK16UkeNFK51hQjCT/MpskyGproTDlDc4m4b+ZzXsweV54v8VKoC5TxGMg1O10ubpfdQD4+61K27Y+AAsPgOozv8lxFLXKLrqZ9p2JIqY3biPprDIxLSczSKZ19358KRDpsJhsrLyjvq17ffOibmZCol3cEY1XcVbmxbcFfO49Nc1kP74NROADEfHLYUA3sfqFsm9OxPzDwyO2v/sPcOlQaTgjjuC/N4aOhHGKMLEPbkngA33mQN3qqRiDoj76QXzCt6Q/Yjcn3bGlB7o0LtFvXWTLmGFZzx84qZrR1QcOqQHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfOd3SoWMPi8GEJQa7zic5+xgdbZMTUt+aOs7RPLrSw=;
 b=isOFd7U5CdjLrb0HbsC2hw1p9y/8s7S0V7kF/TB1V8u/fNKFlCCnV4PPJqI1ywkL5V/3LR2jG6asRHfhCVwStUNLZPucFEd4LRCbmWmprl1xfeN9QZMiNxjUuN4mzyRCJqCNlpklHeVV71dSb0wOjz6AWI3GtyPOuYywnOzrtU+1YiTSztD+lEo8YHLfxMRk7pSWWFc78mHWuaWJxr/M+bJwukeQfx1mK0L/QdFGJGlOgewNc2VDgKV+S8KXCTsYOfAJYmtFNmRzg7rGB1vqNIrRd5EiWxocMNUGEmASVdZnMpOyjOMdCw30jQb5vQ55Dljg/vjAJanKwJQzapnzLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfOd3SoWMPi8GEJQa7zic5+xgdbZMTUt+aOs7RPLrSw=;
 b=plxDzFKE16b5Q75oKraVOFoST8rkk3cx2xnT+Z+c3EBL696yf0fRI+GFQ2ugQb9jxUYdnpRasAmdF/qSRYv6HUciowo8cRiLivMcoTQrRqQzwtRCNtsGtQcl9gtLwMq8G8siFuhM7p4x4eUy9fABKEvHJtCuCxKacSGZd8l9ljg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB1131.namprd12.prod.outlook.com (2603:10b6:3:73::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Tue, 2 Feb
 2021 16:01:16 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3805.027; Tue, 2 Feb 2021
 16:01:16 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: add wave limit functionality for gfx8,9
Date: Tue,  2 Feb 2021 17:00:49 +0100
Message-Id: <20210202160050.59777-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202160050.59777-1-nirmoy.das@amd.com>
References: <20210202160050.59777-1-nirmoy.das@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR17CA0026.namprd17.prod.outlook.com
 (2603:10b6:405:75::15) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.amd.com (165.204.84.11) by
 BN6PR17CA0026.namprd17.prod.outlook.com (2603:10b6:405:75::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.17 via Frontend Transport; Tue, 2 Feb 2021 16:01:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5559984c-31ae-402f-6d71-08d8c793c569
X-MS-TrafficTypeDiagnostic: DM5PR12MB1131:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB11319D270766138502F9A9A78BB59@DM5PR12MB1131.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+tvO5sejHerKu6uRh2xqFLvUxWL6We86XsbOpx9SPl1ZO8TLZ8vwCjOnpRsct/90aGEl6cR5zl7ZDzfNQZ5zXew169gOXOL8lVmk1/GFsSWWti1cWlCIo+gAiTaeDpHWil1MY/9JyZPUCE2TDEsF84wEkRuSC0TowSlojjwG2V57xv1BwIxCR6gK0AO6dx/sFaUNANLsZ6AR7LXhl5bG/69a/xUcC9I/v4UcZiwRpUDL8WPzqfkdz+cwmyxxEkbnf9TS7gmHDiZ1UvZvsO7pufZAUXPlDzCDbemartfbL3aMPP2UrZDpaXhH8T/hMLKhx5KF/aFFYvaxXuwEvustFiK2dHGtTOMJgG1KqxbShQW21xWuMRo8kiv3pNOCEVzrNofvUeKp/kZak7oZSx+4xmsJ6vA/8QcqkBFdhDgXZ++4y4igD/ZzERpn6QBqcrvK4YONjRIujNjOrjo/VK6mYMRr2yfKUSzM2KjG8W9wD6leiiL+epp9Knm9Xaz6rys7vDcR4t06S87K9QFc/2Bhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(26005)(8676002)(2906002)(2616005)(66574015)(6486002)(186003)(16526019)(83380400001)(4326008)(52116002)(7696005)(66556008)(44832011)(66946007)(316002)(5660300002)(1076003)(478600001)(36756003)(86362001)(956004)(6666004)(66476007)(6916009)(8936002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dHArR2hhNlUyaTlIZTVVMlVkRUdVVmZLN2drdmZUc1Q3Q3JUVWJQNGt5bHRo?=
 =?utf-8?B?dmRoUllBcnM2dFArY2NSMmsxSFpWYVJmT0tzcnlnYWZvam04RDl2am43VnIz?=
 =?utf-8?B?S3c4KytHWFltdTJpSVA4TUZwZ2xWY1RoblNxNWdHNFp0bWhYamF5ZXVUQlhG?=
 =?utf-8?B?YVA2cTdzR3dnVHF5ajFVR20xd3JTeFhpT0pCWDBpeWxDWEFFdGJGelg3OEdW?=
 =?utf-8?B?d252WndOMUl5Y0FDNkorM1dmLzlzT1huaTVJa0dVZEhUc3lWKzl1VWR6bUk3?=
 =?utf-8?B?dHFjcU00TVNPZFhuOE1rRXhydlI5QUZrVVArZDhjTFQ4T3lJRlpsaWZjbVB4?=
 =?utf-8?B?Rm0vYlZFVzU4T21YNkdPUVd2dmRmUmZCTVAzc1hkWWRIMENDeTF5QTh4QnA1?=
 =?utf-8?B?S1UyQVE1YUFkbDZZODE5NHh2L2xsNjROVHZLTkViNU15bmZRM29hVnIvRFo0?=
 =?utf-8?B?N1FGbUNERHJUNnNIMVowTlN5Mzd1SHV1V0x5ZFdDYTZaTVp0VUdpd2pGbEhW?=
 =?utf-8?B?NWpGS29TaGNhNDhnUkJvenVJT092R1paaFB3WDVGVDdSaGFWMnQ4TkR3Q3dY?=
 =?utf-8?B?aEFLTjN3d0RsbXNCQjBFVTF3YWlqaFJVS05TRWhzY21BVmdHaG5ZYUp1bEtl?=
 =?utf-8?B?MDdKOGRhUjg3VlJmYWszeEZOYm0yU3djWHErSjhVbkM3Q3F4SzNUM2ZuLzIw?=
 =?utf-8?B?aVJMcjlXVHJjSHRjRDNNZHJ6dkVyUVpmMlRDRVcvSHV1b0RtcXQ4OFY2NzB3?=
 =?utf-8?B?Tld1TXZ5VTc2L00xZVVhOFJ6MnU1VUtZWlZycDNCM1I3UXd4MkNLblcwVCts?=
 =?utf-8?B?VzZZck9RTC9DMU5QY0lvcGdzNjFySVlxajVEZkFHdUdwYzYyUjdacU1vcnFY?=
 =?utf-8?B?MGNqdzdOYXRwbFA3NzUyZFI3VWhIcUtaRjg0VDAxbVlEbW1qNlJBZUVsNFM4?=
 =?utf-8?B?dHpDbVplQXVYZkp4T1gyOWtiNllVZCtkeURSNXZhTGZNeTQ0b0h1eUVGNE8r?=
 =?utf-8?B?YlRGSExJbTJiV3h0aWhKakRJbldSZkRVNU5LMzZ3dyt6RllEcnl3SFlJZXlL?=
 =?utf-8?B?UEdQY2s4ZW5hMENoZGNGaFdON3dIdi9rcjJ6Zk1MSG1MeWhZWmhoZlE3RlFV?=
 =?utf-8?B?eEhjL2NFS0IwRDNwZ2Z6K0xiVktIUmNnQ3M1aVA5cXMwRVZPWHBaN29sSTRG?=
 =?utf-8?B?LzQ4aEd0VzJLbi9yUmQ1SVkxSjc1aFdOdVpVMWkwbXZteFRXaThMRjZ4ZjZF?=
 =?utf-8?B?K2R2ZXhvRGQ3R0hndS93SmNlQkFrSmkzQ01zYnNQcVRFdDlQVjRsSHFsMG9U?=
 =?utf-8?B?YkR5U1IrczZpb3ZvMHFZS3dVVDBhNVUrWWRWcmFMVHAxMEE2Z0R2QVV5SWJo?=
 =?utf-8?B?WUlMZ1JFbFJRbmtud2lDd2kxM2VLZCs4SmFCaEhaOGIwb3Nld0ZqMEdHbm9z?=
 =?utf-8?Q?eOhI0SLV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5559984c-31ae-402f-6d71-08d8c793c569
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 16:01:16.4632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WokfRt+Lms5JLJjkNcKz84J44rNGguoTrF5h4PeiJQLo4y99h8U89CYY56VsvG+VOp+yCquMqmu0B5wL1IPWyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1131
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
Cc: Alan.Harrison@amd.com, Felix.Kuehling@amd.com,
 Nirmoy Das <nirmoy.das@amd.com>, ray.huang@amd.com,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

V2F2ZSBsaW1pdGluZyBjYW4gYmUgdXNlIHRvIGxvYWQgYmFsYW5jZSBoaWdoIHByaW9yaXR5CmNv
bXB1dGUgam9icyBhbG9uZyB3aXRoIGdmeCBqb2JzLiBXaGVuIGVuYWJsZWQsIHRoaXMgd2lsbCBy
ZXNlcnZlCn43NSUgb2Ygd2F2ZXMgZm9yIGNvbXB1dGUgam9icy4KCldlIGRvIG5vdCBuZWVkIHRo
aXMgZnJvbSBnZngxMCBvbndhcmRzIGJlY2F1c2UgPj1nZngxMCBoYXMKYXN5bmNocm9ub3VzIGNv
bXB1dGUgdHVubmVsaW5nIHRvIHJlcGxhY2Ugd2F2ZSBsaW1pdCByZXF1aXJlbWVudC4KClNpZ25l
ZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5oIHwgIDEgKwogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3Y4XzAuYyAgICB8IDE4ICsrKysrKysrKysrKysrKysrLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyAgICB8IDIxICsrKysrKysrKysrKysrKysrKysrLQog
MyBmaWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmggYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5oCmluZGV4IDJhZGE4MGNlNDJmNS4uNTZh
Y2VjMTA3NWFjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cmluZy5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmgKQEAg
LTE5Nyw2ICsxOTcsNyBAQCBzdHJ1Y3QgYW1kZ3B1X3JpbmdfZnVuY3MgewogCXZvaWQgKCpzb2Z0
X3JlY292ZXJ5KShzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsIHVuc2lnbmVkIHZtaWQpOwogCWlu
dCAoKnByZWVtcHRfaWIpKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZyk7CiAJdm9pZCAoKmVtaXRf
bWVtX3N5bmMpKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZyk7CisJdm9pZCAoKmVtaXRfd2F2ZV9s
aW1pdCkoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCBib29sIGVuYWJsZSk7CiB9OwogCiBzdHJ1
Y3QgYW1kZ3B1X3JpbmcgewpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3Y4XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMKaW5kZXgg
YjAyODRjNDY1OWJhLi5iZGZkMjlhMjJiM2QgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92OF8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3Y4XzAuYwpAQCAtMjksNiArMjksNyBAQAogCiAjaW5jbHVkZSAiYW1kZ3B1LmgiCiAjaW5jbHVk
ZSAiYW1kZ3B1X2dmeC5oIgorI2luY2x1ZGUgImFtZGdwdV9yaW5nLmgiCiAjaW5jbHVkZSAidmku
aCIKICNpbmNsdWRlICJ2aV9zdHJ1Y3RzLmgiCiAjaW5jbHVkZSAidmlkLmgiCkBAIC02ODQ1LDYg
KzY4NDYsMTkgQEAgc3RhdGljIHZvaWQgZ2Z4X3Y4XzBfZW1pdF9tZW1fc3luY19jb21wdXRlKHN0
cnVjdCBhbWRncHVfcmluZyAqcmluZykKIAlhbWRncHVfcmluZ193cml0ZShyaW5nLCAweDAwMDAw
MDBBKTsJLyogcG9sbCBpbnRlcnZhbCAqLwogfQogCisjZGVmaW5lIG1tU1BJX1dDTF9QSVBFX1BF
UkNFTlRfR0ZYX0RFRkFVTFQJMHgwN2ZmZmZmZgorc3RhdGljIHZvaWQgZ2Z4X3Y4XzBfZW1pdF93
YXZlX2xpbWl0KHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywgYm9vbCBlbmFibGUpCit7CisJdWlu
dDMyX3QgdmFsOworCisJLyogbW1TUElfV0NMX1BJUEVfUEVSQ0VOVF9HRlggaXMgNyBiaXQgbXVs
dGlwbGllciByZWdpc3RlciB0byBsaW1pdAorCSAqIG51bWJlciBvZiBnZnggd2F2ZXMuIFNldHRp
bmcgNSBiaXQgd2lsbCBtYWtlIHN1cmUgZ2Z4IG9ubHkgZ2V0cworCSAqIGFyb3VuZCAyNSUgb2Yg
Z3B1IHJlc291cmNlcy4KKwkgKi8KKwl2YWwgPSBlbmFibGUgPyAweDFmIDogbW1TUElfV0NMX1BJ
UEVfUEVSQ0VOVF9HRlhfREVGQVVMVDsKKwlhbWRncHVfcmluZ19lbWl0X3dyZWcocmluZywgbW1T
UElfV0NMX1BJUEVfUEVSQ0VOVF9HRlgsIHZhbCk7Cit9CisKIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
YW1kX2lwX2Z1bmNzIGdmeF92OF8wX2lwX2Z1bmNzID0gewogCS5uYW1lID0gImdmeF92OF8wIiwK
IAkuZWFybHlfaW5pdCA9IGdmeF92OF8wX2Vhcmx5X2luaXQsCkBAIC02OTI4LDcgKzY5NDIsOCBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9yaW5nX2Z1bmNzIGdmeF92OF8wX3JpbmdfZnVu
Y3NfY29tcHV0ZSA9IHsKIAkJNyArIC8qIGdmeF92OF8wX3JpbmdfZW1pdF9waXBlbGluZV9zeW5j
ICovCiAJCVZJX0ZMVVNIX0dQVV9UTEJfTlVNX1dSRUcgKiA1ICsgNyArIC8qIGdmeF92OF8wX3Jp
bmdfZW1pdF92bV9mbHVzaCAqLwogCQk3ICsgNyArIDcgKyAvKiBnZnhfdjhfMF9yaW5nX2VtaXRf
ZmVuY2VfY29tcHV0ZSB4MyBmb3IgdXNlciBmZW5jZSwgdm0gZmVuY2UgKi8KLQkJNywgLyogZ2Z4
X3Y4XzBfZW1pdF9tZW1fc3luY19jb21wdXRlICovCisJCTcgKyAvKiBnZnhfdjhfMF9lbWl0X21l
bV9zeW5jX2NvbXB1dGUgKi8KKwkJNSwgLyogZ2Z4X3Y4XzBfZW1pdF93YXZlX2xpbWl0IGZvciB1
cGRhdGluZyBtbVNQSV9XQ0xfUElQRV9QRVJDRU5UX0dGWCByZWdpc3RlciAqLwogCS5lbWl0X2li
X3NpemUgPQk3LCAvKiBnZnhfdjhfMF9yaW5nX2VtaXRfaWJfY29tcHV0ZSAqLwogCS5lbWl0X2li
ID0gZ2Z4X3Y4XzBfcmluZ19lbWl0X2liX2NvbXB1dGUsCiAJLmVtaXRfZmVuY2UgPSBnZnhfdjhf
MF9yaW5nX2VtaXRfZmVuY2VfY29tcHV0ZSwKQEAgLTY5NDIsNiArNjk1Nyw3IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgYW1kZ3B1X3JpbmdfZnVuY3MgZ2Z4X3Y4XzBfcmluZ19mdW5jc19jb21wdXRl
ID0gewogCS5wYWRfaWIgPSBhbWRncHVfcmluZ19nZW5lcmljX3BhZF9pYiwKIAkuZW1pdF93cmVn
ID0gZ2Z4X3Y4XzBfcmluZ19lbWl0X3dyZWcsCiAJLmVtaXRfbWVtX3N5bmMgPSBnZnhfdjhfMF9l
bWl0X21lbV9zeW5jX2NvbXB1dGUsCisJLmVtaXRfd2F2ZV9saW1pdCA9IGdmeF92OF8wX2VtaXRf
d2F2ZV9saW1pdCwKIH07CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X3JpbmdfZnVuY3Mg
Z2Z4X3Y4XzBfcmluZ19mdW5jc19raXEgPSB7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5
XzAuYwppbmRleCA3YjEzZjlkZDk2NWEuLjAyNzk5N2U5NWU0NiAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nZnhfdjlfMC5jCkBAIC01Miw2ICs1Miw3IEBACiAKICNpbmNsdWRlICJhc2ljX3Jl
Zy9wd3IvcHdyXzEwXzBfb2Zmc2V0LmgiCiAjaW5jbHVkZSAiYXNpY19yZWcvcHdyL3B3cl8xMF8w
X3NoX21hc2suaCIKKyNpbmNsdWRlICJhc2ljX3JlZy9nYy9nY185XzBfZGVmYXVsdC5oIgogCiAj
ZGVmaW5lIEdGWDlfTlVNX0dGWF9SSU5HUyAgICAgMQogI2RlZmluZSBHRlg5X01FQ19IUERfU0la
RSA0MDk2CkBAIC02NjY3LDYgKzY2NjgsMjIgQEAgc3RhdGljIHZvaWQgZ2Z4X3Y5XzBfZW1pdF9t
ZW1fc3luYyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCiAJYW1kZ3B1X3Jpbmdfd3JpdGUocmlu
ZywgMHgwMDAwMDAwQSk7IC8qIFBPTExfSU5URVJWQUwgKi8KIH0KIAorc3RhdGljIHZvaWQgZ2Z4
X3Y5XzBfZW1pdF93YXZlX2xpbWl0KHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywgYm9vbCBlbmFi
bGUpCit7CisJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSByaW5nLT5hZGV2OworCXVpbnQz
Ml90IHZhbDsKKworCisJLyogbW1TUElfV0NMX1BJUEVfUEVSQ0VOVF9HRlggaXMgNyBiaXQgbXVs
dGlwbGllciByZWdpc3RlciB0byBsaW1pdAorCSAqIG51bWJlciBvZiBnZnggd2F2ZXMuIFNldHRp
bmcgNSBiaXQgd2lsbCBtYWtlIHN1cmUgZ2Z4IG9ubHkgZ2V0cworCSAqIGFyb3VuZCAyNSUgb2Yg
Z3B1IHJlc291cmNlcy4KKwkgKi8KKwl2YWwgPSBlbmFibGUgPyAweDFmIDogbW1TUElfV0NMX1BJ
UEVfUEVSQ0VOVF9HRlhfREVGQVVMVDsKKwlhbWRncHVfcmluZ19lbWl0X3dyZWcocmluZywKKwkJ
CSAgICAgIFNPQzE1X1JFR19PRkZTRVQoR0MsIDAsIG1tU1BJX1dDTF9QSVBFX1BFUkNFTlRfR0ZY
KSwKKwkJCSAgICAgIHZhbCk7Cit9CisKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kX2lwX2Z1bmNz
IGdmeF92OV8wX2lwX2Z1bmNzID0gewogCS5uYW1lID0gImdmeF92OV8wIiwKIAkuZWFybHlfaW5p
dCA9IGdmeF92OV8wX2Vhcmx5X2luaXQsCkBAIC02NzU2LDcgKzY3NzMsOCBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IGFtZGdwdV9yaW5nX2Z1bmNzIGdmeF92OV8wX3JpbmdfZnVuY3NfY29tcHV0ZSA9
IHsKIAkJU09DMTVfRkxVU0hfR1BVX1RMQl9OVU1fUkVHX1dBSVQgKiA3ICsKIAkJMiArIC8qIGdm
eF92OV8wX3JpbmdfZW1pdF92bV9mbHVzaCAqLwogCQk4ICsgOCArIDggKyAvKiBnZnhfdjlfMF9y
aW5nX2VtaXRfZmVuY2UgeDMgZm9yIHVzZXIgZmVuY2UsIHZtIGZlbmNlICovCi0JCTcsIC8qIGdm
eF92OV8wX2VtaXRfbWVtX3N5bmMgKi8KKwkJNyArIC8qIGdmeF92OV8wX2VtaXRfbWVtX3N5bmMg
Ki8KKwkJNSwgLyogZ2Z4X3Y5XzBfZW1pdF93YXZlX2xpbWl0IGZvciB1cGRhdGluZyBtbVNQSV9X
Q0xfUElQRV9QRVJDRU5UX0dGWCByZWdpc3RlciAqLwogCS5lbWl0X2liX3NpemUgPQk3LCAvKiBn
ZnhfdjlfMF9yaW5nX2VtaXRfaWJfY29tcHV0ZSAqLwogCS5lbWl0X2liID0gZ2Z4X3Y5XzBfcmlu
Z19lbWl0X2liX2NvbXB1dGUsCiAJLmVtaXRfZmVuY2UgPSBnZnhfdjlfMF9yaW5nX2VtaXRfZmVu
Y2UsCkBAIC02NzcyLDYgKzY3OTAsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9yaW5n
X2Z1bmNzIGdmeF92OV8wX3JpbmdfZnVuY3NfY29tcHV0ZSA9IHsKIAkuZW1pdF9yZWdfd2FpdCA9
IGdmeF92OV8wX3JpbmdfZW1pdF9yZWdfd2FpdCwKIAkuZW1pdF9yZWdfd3JpdGVfcmVnX3dhaXQg
PSBnZnhfdjlfMF9yaW5nX2VtaXRfcmVnX3dyaXRlX3JlZ193YWl0LAogCS5lbWl0X21lbV9zeW5j
ID0gZ2Z4X3Y5XzBfZW1pdF9tZW1fc3luYywKKwkuZW1pdF93YXZlX2xpbWl0ID0gZ2Z4X3Y5XzBf
ZW1pdF93YXZlX2xpbWl0LAogfTsKIAogc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfcmluZ19m
dW5jcyBnZnhfdjlfMF9yaW5nX2Z1bmNzX2tpcSA9IHsKLS0gCjIuMzAuMAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
