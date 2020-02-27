Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868BDC54FD1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 14:17:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56C2224690
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 14:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uH0T5tu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C2224690
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC9DC6E8D8;
	Thu, 27 Feb 2020 14:17:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13CAB6E8D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 14:17:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrrHAkeUZpZE29/syR/1HpfqViHKz1Wg8eHMM5HW7u1fieKiGqLr/YaKXMkDL/20UDWKcR5zuf3baNgDoeiKKHEoCcTaTI4JPAHO6+SoKYKeHhnfllVqMO2g6DngRILsiuQg9IW0FtLGPZbG+Ya6CcLYZrPL4OHJ9nOxcCModzXFNb3UFT5j7DpzLohwB/l9CN+e7+m+SgJBHG9DqBMPMubBkp53W9QE6knu2LMOPYL4ru3YA0rR8EZINOFEvIVkV4V89bUfRUsSJSYZ7dczo0o1umwo1qgV+mZsKWUR3f6s6eV9ZC/MJMrFQ5MK6fe7hvwEQaT7ckRoTpQ3IWuaaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkKT8VKM1ydlQ+xewWCqm+vaxjID7MyY5LrbegViUJI=;
 b=M728iOvI2RK9v2AMBrU79hA10stO+10u43JmvSR94Ktn83MDm0g7baAIsSFGhtrDuXv11wv1wlUhQceMZdtGm1d+yWw/+hHx3DBNVtWTUwWytV0tH1cj03SLbxaS57lBhSlwkFy5Qam/t98KBmyqblgEFaoyhu2pK1j9I+VbBx4RCg2XuBO3sCeQh4dFttYqU5nB2wTPK9Pnajngsu9jAPW2DZMSe0TJ/m04CdepvOFyXgYeBu0HnW9+VaajSMYZ/3pGBmB40kj2/L37/HOmxfhR0ARM1j7/HnZmYVDxJ97rXk3opgf1m+SqSC2h+eQ7VsEHgs2lD/OYEB9Fvv0iUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkKT8VKM1ydlQ+xewWCqm+vaxjID7MyY5LrbegViUJI=;
 b=uH0T5tu+7zdZHLzzDDQq6/j78yQ11BkNZ97zzqyv1sXqzrzrREvEjx8Swl06HbDWELz/SMuSpKOBL6K2EZzX/ihaCCqBUTNHVko+yoFPRDh2PSqW/ghhoS/zc+ojChCQOxpjpS+32S42Ef+bc3UyJo7kEMpU7H96rdOiq0+dX+8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from BN6PR12MB1699.namprd12.prod.outlook.com (2603:10b6:404:ff::20)
 by BN6PR12MB1124.namprd12.prod.outlook.com (2603:10b6:404:19::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Thu, 27 Feb
 2020 14:17:48 +0000
Received: from BN6PR12MB1699.namprd12.prod.outlook.com
 ([fe80::64:3847:8cd3:9e0a]) by BN6PR12MB1699.namprd12.prod.outlook.com
 ([fe80::64:3847:8cd3:9e0a%6]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 14:17:48 +0000
Subject: Re: [PATCH] drm/amdgpu: miss to remove pp_sclk file
To: Yintian Tao <yttao@amd.com>, Alexander.Deucher@amd.com
References: <20200227141118.3271-1-yttao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a0cce90e-3b77-3983-fa11-848bf1df748d@amd.com>
Date: Thu, 27 Feb 2020 15:17:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200227141118.3271-1-yttao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0001.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::11) To BN6PR12MB1699.namprd12.prod.outlook.com
 (2603:10b6:404:ff::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 ZR0P278CA0001.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 14:17:47 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 40493caf-39cc-4f6e-bab1-08d7bb8fd281
X-MS-TrafficTypeDiagnostic: BN6PR12MB1124:|BN6PR12MB1124:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1124FF22EF5D552AC52A935383EB0@BN6PR12MB1124.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:612;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(189003)(199004)(16526019)(4744005)(186003)(316002)(5660300002)(52116002)(4326008)(31696002)(86362001)(2616005)(478600001)(6666004)(2906002)(66556008)(36756003)(6636002)(8936002)(81166006)(6486002)(31686004)(66476007)(81156014)(8676002)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1124;
 H:BN6PR12MB1699.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s9tcVFmfCH/fsG7NI9j6A0cX/QgJ2WnAtM/g9hcuCZrn5raHqVjhIWA1TlGm4mHCh218FiZF6Mo/NewafW/g8vkrbq7V+QeKdSfcGBlI80eK7K2a4ikzt/tvraq14ZgMGj0+0R5VTIvNIEXIJAfVAKkcCR4GwevTh85ZfcLxHstc4nshKA4BIrU1KYtUcSVF6045QeZmD4KWabVWsxBVJmvYrU237M7wKcQF1LY0sYOOHr/ne77AGptgtoM5SujcgI/CSjv4pGiYH4kfM+atrqjcPNxAgKnYiaY8pqOjvIHbqpsLRoS+vrY7iUuf+mZRGIjYd0vB7Svvrn1D2bBTt3FukpxfyNay9JMi4kJiymY0FRSUjfV38U7mI2rzF7kfnnCr4IWmTwguYEbj/i9BqLcFyAi0sdFSUnOwCIeitmlkmXudwxRRZKx4e2YeaP76
X-MS-Exchange-AntiSpam-MessageData: 8ZmW3I92XjVltB4EkQMfeM3KvDzIsqAPjlR4bszwDYjiyrIyJYTDy8FQA5tK2GNEOzS1/0EOjfZ9VBdGHThJQTOJZgWgqq/UNI4oFDhN+mzKE/m2T5BmqTxqvBnFzAYV/yGlO0vj9nZMhqsPsNvUj5ttUT1qHQaUzz1Q48t58wCL4w9/dXA/qouV9DDXt9vHhDpsoylDaPK6+0ydap1UBA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40493caf-39cc-4f6e-bab1-08d7bb8fd281
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 14:17:48.4618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BeIsHLHJFd0SLCJGrGFAj7Iq12FvxylyBrdo72FQR4vJIrlkZ9PZU7k2AVqylVT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1124
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjcuMDIuMjAgdW0gMTU6MTEgc2NocmllYiBZaW50aWFuIFRhbzoKPiBNaXNzIHRvIHJlbW92
ZSBwcF9zY2xrIGZpbGUKPgo+IFNpZ25lZC1vZmYtYnk6IFlpbnRpYW4gVGFvIDx5dHRhb0BhbWQu
Y29tPgoKTG9va3MgcmVhc29uYWJsZSB0byBtZSwgYnV0IEFsZXggY2FuIHByb2JhYmx5IGJldHRl
ciBqdWRnZS4KCkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BtLmMg
fCAxICsKPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BtLmMKPiBpbmRleCA5ZGVmZjhjYzk3MjMuLmE0M2ZjMWM4ZmZk
MCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uYwo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jCj4gQEAgLTM0NzEs
NiArMzQ3MSw3IEBAIHZvaWQgYW1kZ3B1X3BtX3N5c2ZzX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpCj4gICAJZGV2aWNlX3JlbW92ZV9maWxlKGFkZXYtPmRldiwgJmRldl9hdHRyX3Bw
X2N1cl9zdGF0ZSk7Cj4gICAJZGV2aWNlX3JlbW92ZV9maWxlKGFkZXYtPmRldiwgJmRldl9hdHRy
X3BwX2ZvcmNlX3N0YXRlKTsKPiAgIAlkZXZpY2VfcmVtb3ZlX2ZpbGUoYWRldi0+ZGV2LCAmZGV2
X2F0dHJfcHBfdGFibGUpOwo+ICsJZGV2aWNlX3JlbW92ZV9maWxlKGFkZXYtPmRldiwgJmRldl9h
dHRyX3BwX3NjbGspOwo+ICAgCj4gICAJZGV2aWNlX3JlbW92ZV9maWxlKGFkZXYtPmRldiwgJmRl
dl9hdHRyX3BwX2RwbV9zY2xrKTsKPiAgIAlkZXZpY2VfcmVtb3ZlX2ZpbGUoYWRldi0+ZGV2LCAm
ZGV2X2F0dHJfcHBfZHBtX21jbGspOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
