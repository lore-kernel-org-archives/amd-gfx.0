Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9E2C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 14:17:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A6D920639
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 14:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6D920639
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 467D06E400;
	Wed, 19 Aug 2020 14:17:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 732756E400
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 14:17:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImBh2xNyMw5hc9sg8INdi1PBs/z8dFZ6SSQMh+ie9J+MFU4qJolnLblI1fkW61cIxQz1AX591eFGcJEQYWb54kQphUIXwsaipCfx3GEQHGZVk7qtC3K7808kf3AJ/TMJLFfLpAanRIdrwR8LnhYFpzUwBx8kNZ6A17AQaknAbBOKQXkLUB1iDbAKyo8VjLMVoVo+P3P8wfqGPn0pVfTd0qjXq2kKpnsWPsNxuT2GGWVl4eEFTPUV95ZFMyweeROYct/0j5d4N2AibMlbM47Wa5rVDPRPO208kYf0r6dL7XlnzXpR9SrlJ0gcf9wNAaxdtI3sxZAty2pJGOWTB86TUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geAf5gGJV+fnAxBQqRZ9SUH93raiLG4FEgckKThDw/c=;
 b=flTSORUw82BGdWs/cu56UFBo/5vR/uujl4Wr5fDUKy9igFfK8a2hy8B2xs+rZxcMRM+ivqUOy1lgDA5D+2gvY4RSiJe1jXIZnEP/6MmTahOVHOQmE5n5a1DBKp+aLlgNse2EhukowfTKEJYdBsxCZ4Z/myv5SSyTG+3grgX4T/GXkgArf/l9WRpvCDW/xQzrXWhITTHWIlfOeI6Y93AqDJNYcbDtklub4cvZv6kAytnAHDL9YnEWjqfyOXTd9nVoP38sZlpAPxsS8FN6RKs2d/xVuD3K7Uj6M1ukbgmXgnCQXWJGuYck9Yhpax1AFcRMNUiPhWJELLZhcdtn8YzM8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geAf5gGJV+fnAxBQqRZ9SUH93raiLG4FEgckKThDw/c=;
 b=TldBGSSjqERMmlRc7DRYjdk987YvUkRoImIR6yKRQGULZVjIe/Sopl6PJO/dNyT2br57NCJspUSyiBmfqi0aRcDO8WNGh775pIA8Ds8Xy+8NXgZ0wMq7ZhJIdkReRYd5+BBoL29XtyugHP3xeQ2zDnACxpP5sH0YDWrU+luacWg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Wed, 19 Aug
 2020 14:17:36 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::1852:d129:e9ca:ebd4]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::1852:d129:e9ca:ebd4%5]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 14:17:36 +0000
Subject: Re: [PATCH v4] drm/amdgpu: add new trace event for page table update
 v3
To: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
References: <20200813030414.188468-1-shashank.sharma@amd.com>
 <35be9cda-025a-8f45-1648-00b96f57720e@amd.com>
 <ea572a64-37e4-d3db-f884-59f34bbdce38@amd.com>
 <7dbb15c2-9b28-6c30-872c-e64fc51d4879@amd.com>
 <3cc6b2fe-995d-581a-5e56-913a0cf60b42@amd.com>
 <42ef3112-81fb-d58b-4335-c19655f5db07@gmail.com>
 <99ecca3a-c2bb-f11a-6786-e0dfb853ba88@amd.com>
 <451e4ec1-40a8-f00e-d4c7-cbb34927062c@amd.com>
 <0a707d0d-935e-464a-388a-e25c9c0c6c41@amd.com>
 <eea173dc-459b-5653-47f8-a563724391d6@gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
Message-ID: <4a65a5d3-85f7-57d7-1d4e-2dec5ac6875d@amd.com>
Date: Wed, 19 Aug 2020 19:47:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
In-Reply-To: <eea173dc-459b-5653-47f8-a563724391d6@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: MAXPR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::24) To BYAPR12MB3126.namprd12.prod.outlook.com
 (2603:10b6:a03:df::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.113] (106.51.110.102) by
 MAXPR01CA0082.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Wed, 19 Aug 2020 14:17:34 +0000
X-Originating-IP: [106.51.110.102]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4c51a3ac-741f-4218-b581-08d8444a9f1b
X-MS-TrafficTypeDiagnostic: BY5PR12MB4115:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4115CEAA4951C5F54CC15F4EF25D0@BY5PR12MB4115.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mYSJ7BJ0igsmyhFcfOupmO9hUNjiEqpZAyw7WK1Ez1uPG8CIQFvUZEc9P2DjzqxvNzdrz1wNt+bncilLSynhxmvMlmo2z5kfwrNBh4NpRpvS2w8LvHhPsaJXzkJOrYh2zcgScamTkUCFtVJeJF7z+vrt1xwj5y4bYPBWzgTt/GKB1zrBVkwyYe56USRAEVF+5MdPJeFCAfucRVZCUvQScv7ftEMcqximVVxJbrgPbOLufFghyv+skDt0zxhRGO4FTiaTIgzpSUqFfL5RJykz9U78MFjmLObKmUSEoy+jVnpWc/RMV+ULgUFuqHoDkUvvm6OjQjmoH82memDg922WcihiA0smn4U73jqh3fRTkQY6S5PG/ogyZgEwnlEGiqPL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(66946007)(186003)(2616005)(478600001)(52116002)(956004)(16526019)(26005)(1006002)(15650500001)(8936002)(36756003)(44832011)(316002)(31686004)(66476007)(55236004)(86362001)(53546011)(66556008)(66574015)(16576012)(8676002)(6666004)(4326008)(6486002)(31696002)(5660300002)(83380400001)(2906002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 10vUjlkhdQOFtTfX+GlgW/nkdnLgWd/oXXIiKaleuwJ1qPKhbL6JiRzIw6wwrrM5xj8PXvi8QH+bjULYIttsmTn+duDu1OzePv3dNaOrmt+Llw6W7KIKTHKt8m/BWZqVddwwO2Esac6JBpN5szvTTMHYUU292oqSEAjH+BJOR4KHcCTqKhOmv7yR/aAGbdVir+0oBIXwdTsVMN2J2G5kecV+zrnkIL5N+0C/RRfJxxNZT97PMQtHAs2/vNRLFpiNctRaM26AuskLSEL7U14KgD8iljg5f8MdK6GRvagf4IttirfK5ShBQJhdmYLej0EVPzuoBJNciBCxgazoGf/9cwNMjXltV5R0kgx9LDq4Nt+RbVeYtCsDJt6ReQLvcbXWke7oczZZODqDGRtA/x2XOxNJydJdUnSJ3X/xNvnJTtsxva4XWBgXu2YSux2W66nCv+XXPtVwOQxjr4avubcge8A/gaYEpkdEVWOU5rtE97soQSgz4sQzffbDxrbHkWiD4uhrUkRvUn0yg4dv0YdY9Qgsk0RWclLrx9oAkv9Z5SyNiuJOtvQ+rAQ3UH14JV157QaAatCMW6ny3tx4fGWBfg/FP0Y1ioBfdJ4u1nkEQHHVGLdZflELR/Vbo3l3XYFWL3sxcpZIif01R6ZKzT0Iaw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c51a3ac-741f-4218-b581-08d8444a9f1b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 14:17:36.2496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAvLT26zVXEdDHiM8hH6RrZmKjf2gjyQyDDlMa9SRtgUqtBxapZ8b2sQEeoNuHMorDjctXUmD/vO9af5zpujcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4115
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDE5LzA4LzIwIDc6MDAgcG0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTkuMDgu
MjAgdW0gMTU6MDggc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4+IE9uIDE5LzA4LzIwIDY6MzQg
cG0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBBbSAxOS4wOC4yMCB1bSAxNDozNyBzY2hy
aWViIFNoYXNoYW5rIFNoYXJtYToKPj4+PiBPbiAxOS8wOC8yMCA2OjAzIHBtLCBDaHJpc3RpYW4g
S8O2bmlnIHdyb3RlOgo+Pj4+PiBBbSAxOS4wOC4yMCB1bSAxNDoxOSBzY2hyaWViIFNoYXNoYW5r
IFNoYXJtYToKPj4+Pj4+IE9uIDE5LzA4LzIwIDU6MzggcG0sIENocmlzdGlhbiBLw7ZuaWcgd3Jv
dGU6Cj4+Pj4+Pj4gQW0gMTkuMDguMjAgdW0gMTM6NTIgc2NocmllYiBTaGFzaGFuayBTaGFybWE6
Cj4+Pj4+Pj4+IE9uIDEzLzA4LzIwIDE6MjggcG0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+
Pj4+Pj4+PiBBbSAxMy4wOC4yMCB1bSAwNTowNCBzY2hyaWViIFNoYXNoYW5rIFNoYXJtYToKPj4+
Pj4+Pj4+PiBUaGlzIHBhdGNoIGFkZHMgYSBuZXcgdHJhY2UgZXZlbnQgdG8gdHJhY2sgdGhlIFBU
RSB1cGRhdGUKPj4+Pj4+Pj4+PiBldmVudHMuIFRoaXMgc3BlY2lmaWMgZXZlbnQgd2lsbCBwcm92
aWRlIGluZm9ybWF0aW9uIGxpa2U6Cj4+Pj4+Pj4+Pj4gLSBzdGFydCBhbmQgZW5kIG9mIHZpcnR1
YWwgbWVtb3J5IG1hcHBpbmcKPj4+Pj4+Pj4+PiAtIEhXIGVuZ2luZSBmbGFncyBmb3IgdGhlIG1h
cAo+Pj4+Pj4+Pj4+IC0gcGh5c2ljYWwgYWRkcmVzcyBmb3IgbWFwcGluZwo+Pj4+Pj4+Pj4+Cj4+
Pj4+Pj4+Pj4gVGhpcyB3aWxsIGJlIHBhcnRpY3VsYXJseSB1c2VmdWwgZm9yIG1lbW9yeSBwcm9m
aWxpbmcgdG9vbHMKPj4+Pj4+Pj4+PiAobGlrZSBSTVYpIHdoaWNoIGFyZSBtb25pdG9yaW5nIHRo
ZSBwYWdlIHRhYmxlIHVwZGF0ZSBldmVudHMuCj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiBWMjogQWRk
ZWQgcGh5c2ljYWwgYWRkcmVzcyBsb29rdXAgbG9naWMgaW4gdHJhY2UgcG9pbnQKPj4+Pj4+Pj4+
PiBWMzogc3dpdGNoIHRvIHVzZSBfX2R5bmFtaWNfYXJyYXkKPj4+Pj4+Pj4+PiAgICAgICAgICBh
ZGRlZCBucHRlcyBpbnQgdGhlIFRQcHJpbnQgYXJndW1lbnRzIGxpc3QKPj4+Pj4+Pj4+PiAgICAg
ICAgICBhZGRlZCBwYWdlIHNpemUgaW4gdGhlIGFyZyBsaXN0Cj4+Pj4+Pj4+Pj4gVjQ6IEFkZHJl
c3NlZCBDaHJpc3RpYW4ncyByZXZpZXcgY29tbWVudHMKPj4+Pj4+Pj4+PiAgICAgICAgICBhZGQg
c3RhcnQvZW5kIGluc3RlYWQgb2Ygc2VnCj4+Pj4+Pj4+Pj4gICAgICAgICAgdXNlIGluY3IgaW5z
dGVhZCBvZiBwYWdlX3N6IHRvIGJlIGFjY3VyYXRlCj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiBDYzog
Q2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Pj4+Pj4+Pj4+IENj
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4+Pj4+Pj4+Pj4gU2ln
bmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+
Pj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFNoYXNoYW5rIFNoYXJtYSA8c2hhc2hhbmsuc2hhcm1h
QGFtZC5jb20+Cj4+Pj4+Pj4+Pj4gLS0tCj4+Pj4+Pj4+Pj4gICAgICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmggfCAzNyArKysrKysrKysrKysrKysrKysrKysrKwo+
Pj4+Pj4+Pj4+ICAgICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jICAg
IHwgIDkgKysrKy0tCj4+Pj4+Pj4+Pj4gICAgICAgMiBmaWxlcyBjaGFuZ2VkLCA0NCBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmgKPj4+Pj4+Pj4+PiBpbmRleCA2M2U3MzRhMTI1
ZmIuLmRmMTJjZjg0NjZjMiAxMDA2NDQKPj4+Pj4+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaAo+Pj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oCj4+Pj4+Pj4+Pj4gQEAgLTMyMSw2ICszMjEsNDMg
QEAgREVGSU5FX0VWRU5UKGFtZGdwdV92bV9tYXBwaW5nLCBhbWRncHVfdm1fYm9fY3MsCj4+Pj4+
Pj4+Pj4gICAgICAgCSAgICBUUF9BUkdTKG1hcHBpbmcpCj4+Pj4+Pj4+Pj4gICAgICAgKTsKPj4+
Pj4+Pj4+PiAgICAgICAKPj4+Pj4+Pj4+PiArVFJBQ0VfRVZFTlQoYW1kZ3B1X3ZtX3VwZGF0ZV9w
dGVzLAo+Pj4+Pj4+Pj4+ICsJICAgIFRQX1BST1RPKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3Bh
cmFtcyAqcCwKPj4+Pj4+Pj4+PiArCQkgICAgIHVpbnQ2NF90IHN0YXJ0LCB1aW50NjRfdCBlbmQs
Cj4+Pj4+Pj4+Pj4gKwkJICAgICB1bnNpZ25lZCBpbnQgbnB0ZXMsIHVpbnQ2NF90IGRzdCwKPj4+
Pj4+Pj4+PiArCQkgICAgIHVpbnQ2NF90IGluY3IsIHVpbnQ2NF90IGZsYWdzKSwKPj4+Pj4+Pj4+
PiArCVRQX0FSR1MocCwgc3RhcnQsIGVuZCwgbnB0ZXMsIGRzdCwgaW5jciwgZmxhZ3MpLAo+Pj4+
Pj4+Pj4+ICsJVFBfU1RSVUNUX19lbnRyeSgKPj4+Pj4+Pj4+PiArCQkJIF9fZmllbGQodTY0LCBz
dGFydCkKPj4+Pj4+Pj4+PiArCQkJIF9fZmllbGQodTY0LCBlbmQpCj4+Pj4+Pj4+Pj4gKwkJCSBf
X2ZpZWxkKHU2NCwgZmxhZ3MpCj4+Pj4+Pj4+Pj4gKwkJCSBfX2ZpZWxkKHVuc2lnbmVkIGludCwg
bnB0ZXMpCj4+Pj4+Pj4+Pj4gKwkJCSBfX2ZpZWxkKHU2NCwgaW5jcikKPj4+Pj4+Pj4+PiArCQkJ
IF9fZHluYW1pY19hcnJheSh1NjQsIGRzdCwgbnB0ZXMpCj4+Pj4+Pj4+PiBBcyBkaXNjdXNzZWQg
d2l0aCB0aGUgdHJhY2Ugc3Vic3lzdGVtIG1haW50YWluZXIgd2UgbmVlZCB0byBhZGQgdGhlIHBp
ZAo+Pj4+Pj4+Pj4gYW5kIHByb2JhYmx5IHRoZSBWTSBjb250ZXh0IElEIHdlIHVzZSBoZXJlIHRv
IGlkZW50aWZ5IHRoZSB1cGRhdGVkIFZNLgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IENocmlzdGlhbi4K
Pj4+Pj4+Pj4gSSBwcmludGVkIGJvdGggdm0tPnRhc2tfaW5mby5waWQgVnMgY3VycmVudC0+cGlk
IGZvciB0ZXN0aW5nLCBhbmQgSSBjYW4gc2VlIGRpZmZlcmVudCB2YWx1ZXMgY29taW5nIG91dCBv
ZiAuCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IGdub21lLXNoZWxsLTIxMTTCoCBbMDExXcKgwqDCoCA0MS44
MTI4OTQ6IGFtZGdwdV92bV91cGRhdGVfcHRlczogc3RhcnQ6MHgwODAwMTAyZTgwIGVuZDoweDA4
MDAxMDJlODIsIGZsYWdzOjB4ODAsIGluY3I6NDA5NiwgcGlkPTIxMjggdm1pZD0wIGNwaWQ9MjEx
NAo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBwaWQgaXMgdm0tPnRhc2tfaW5mby5waWQ9MjEyOCB3aGVyZWFz
IGNwaWQ9MjExNCBpcyBjdXJyZW50LnBpZC4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gV2hpY2ggaXMgdGhl
IG9uZSB3ZSB3YW50IHRvIHNlbmQgd2l0aCB0aGUgZXZlbnQgPwo+Pj4+Pj4+IFRoYXQgaXMgdm0t
PnRhc2tfaW5mby5waWQsIHNpbmNlIHRoaXMgaXMgdGhlIFBJRCB3aGljaCBpcyB1c2luZyB0aGUg
Vk0KPj4+Pj4+PiBmb3IgY29tbWFuZCBzdWJtaXNzaW9uLgo+Pj4+Pj4gZ290IGl0Lgo+Pj4+Pj4+
PiBUcmFjZSBldmVudCBieSBkZWZhdWx0IHNlZW1zIHRvIGJlIGFkZGluZyB0aGUgcHJvY2VzcyBu
YW1lIGFuZCBpZCBhdCB0aGUgaGVhZGVyIG9mIHRoZSBldmVudCAoZ25vbWUtc2hlbGwtMjExNCks
IHdoaWNoIGlzIHNhbWUgYXMgY3VycmVudC5waWQKPj4+Pj4+Pj4KPj4+Pj4+Pj4KPj4+Pj4+Pj4g
QWxzbywgaXMgaXQgb2sgdG8gZXh0cmFjdCB2bWlkIGZyb20gam9iLT52bWlkID8KPj4+Pj4+PiBP
bmx5IGluIHRyYWNlX2FtZGdwdV92bV9ncmFiX2lkKCksIGluIGFsbCBvdGhlciBjYXNlcyBpdCdz
IHByb2JhYmx5IG5vdAo+Pj4+Pj4+IGFzc2lnbmVkIHlldC4KPj4+Pj4+IE9rLCBsZXQgbWUgY2hl
Y2sgaG93IGNhbiB3ZSBnZXQgdm1pZCBmcm9tIHRoaXMgY29udGV4dCB3ZSBhcmUgc2VuZGluZyB0
aGUgZXZlbnQgZnJvbS4gT3IgbWF5YmUgSSB3ZSBzaG91bGTCoCBrZWVwIFY1IHdpdGggcGlkIG9u
bHksIGFuZCBsYXRlciBzZW5kIGEgc2VwYXJhdGUgcGF0Y2ggdG8gYWRkIHZtaWQgPwo+Pj4+PiBJ
J20gbm90IHN1cmUgaG93IHlvdSB3YW50IHRvIGdldCBhIFZNSUQgaW4gdGhlIGZpcnN0IHBsYWNl
LiBXZQo+Pj4+PiBkeW5hbWljYWxseSBhc3NpZ24gVk1JRHMgZHVyaW5nIGNvbW1hbmQgc3VibWlz
c2lvbi4KPj4+Pj4KPj4+Pj4gU2VlIHRoZSBhbWRncHVfdm1fZ3JhYl9pZCB0cmFjZSBwb2ludC4K
Pj4+PiBBY3R1YWxseSBJIHdhcyBhZGRpbmcgdm1pZCB0byBhZGRyZXNzIHRoaXMgbGFzdCBjb21t
ZW50IG9uIFY0Ogo+Pj4+PiBhbmQgcHJvYmFibHkgdGhlIFZNIGNvbnRleHQgSUQgd2UgdXNlIGhl
cmUgdG8gaWRlbnRpZnkgdGhlIHVwZGF0ZWQgVk0uCj4+Pj4gSSBhc3N1bWVkIHlvdSBtZWFudCB0
aGUgdm1pZCBieSB0aGlzLCBpcyB0aGF0IG5vdCBzbyA/Cj4+PiBBaCEgTm8gdGhhdCdzIHNvbWV0
aGluZyBjb21wbGV0ZWx5IGRpZmZlcmVudCA6KQo+Pj4KPj4+IFRoZSBWTUlEIGlzIGEgNGJpdCBo
YXJkd2FyZSBpZGVudGlmaWVyIHVzZWQgZm9yIFRMQiBvcHRpbWl6YXRpb24uCj4+Pgo+Pj4gVGhl
IFZNIGNvbnRleHQgSUQgaXMgYW4gdW5pcXVlIDY0Yml0IG51bWJlciwgd2UgdXN1YWxseSB1c2UK
Pj4+IHZtLT5pbW1lZGlhdGUuZmVuY2VfY29udGV4dCBmb3IgdGhpcy4KPj4gRGFtbiwgd2h5IGlz
IGl0IG5ldmVyIHdoYXQgeW91IGhvcGUgaXQgdG8gYmUgOikuIFRoYW5rcyBmb3IgdGhpcyBpbmZv
cm1hdGlvbiwgSSB3aWxsIGNoZWNrIHRoaXMgb3V0IGZpcnN0Lgo+IE11bHRpcGxlIHJlYXNvbnMg
OikKPgo+IE9uZSBpcyB0aGF0IEknbSBub3QgYSBuYXRpdmUgc3BlYWtlciBvZiBFbmdsaXNoIGFu
ZCBvbmx5IGhhZCB2ZXJ5IAo+IGxpbWl0ZWQgZm9ybWFsIGVkdWNhdGlvbiBpbiB0aGUgbGFuZ3Vh
Z2UgOikKPgo+IEFub3RoZXIgb25lIGlzIHRoYXQgdGhlIGhhcmR3YXJlIGFuZCBkcml2ZXIgaXMg
cmF0aGVyIGNvbXBsaWNhdGVkLgoKTmFoLCBJIHRoaW5rIHlvdSB3ZXJlIHByZXR0eSBjbGVhciBp
biB0aGUgY29tbXVuaWNhdGlvbiwKCkkgd2lsbCBiZSBhIGdvb2Qgc29mdHdhcmUgZW5naW5lZXIs
IGFuZCBnbyBhaGVhZCBhbmQgYmxhbWUgaXQgb24gdGhlIGhhcmR3YXJlIDpELgoKVGhhbmtzIGFn
YWluLCBJIHdpbGwgY2hlY2sgdG8gYWRkIHRoZSB2bSBjb250ZXh0IGhlcmUuCgotIFNoYXNoYW5r
Cgo+Cj4gUmVnYXJkcywKPiBDaHJpc3RpYW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
