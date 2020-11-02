Return-Path: <SRS0=PoT7=EI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D514FC00A89
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 18:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 692CD22245
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 18:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sSUcixgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692CD22245
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9A7E6E117;
	Mon,  2 Nov 2020 18:00:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFD2B6E117
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2020 18:00:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEks+YAymN0q04GLvCdeOv6F6XbASxQ7SK1+O54w6EhbPGNdr5ee0xTTogDaRGcAdHPhyHtETi30NLCtPmYM9q3qkaMuPkVSQ+BFH1IEajYaz1f7IqLLTgRAmR6PEbsgY198FkEXZxIDrk1uY4fQiGWGHYTWEsyaQ+H41IgREaTtEOt3h/RZxy5X1okN8eSLMhCuLLvB4MEAcYFaGMFouAM/kQIW+Crd10woStmsjNePERfgIDuRUWuWpFfZZD3DgJCwXXSeDh+T9cQXoncUUZEivhLbaZrG+Jue8iKZQ+LGRdi0/XvoE9gUT/I+q5NfU3Q2z5lw4NiMrsipCd1+xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvUOkvPsX1woALXrXHuUIZMb7itShA4lBFViABjrMKc=;
 b=fj2ZiKz59ZVn0YSBlk+fih+3Jm1FQWvp+K2C8XGMtHI3/+/LW7f4eBgRvuAf2c3YPgfdZWefOxLsc1jSNpUsRPUlGwrlt+Bnb0TSSYNw2rq7Qf9+TW/xA7gvVqnzkjWjplkDp2ne0FZON6aaK9RANL3dTaIEDYCagKzTCI+7iAf+ce+nckzpJ86mZffx16DTbMRIn2Alo9chktWsXcmISHG7S0ZlqWuztdT5f/ZFiylJzPx7YyghzZ1pERBLxElNg718/8738WZpU1ycq7jqErc0nRJLbyBKGmCAyw4RXWPWwgKcC2oOlCYQW02zla9OrbCxQRqLm0ZEqIJ0J6oTAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvUOkvPsX1woALXrXHuUIZMb7itShA4lBFViABjrMKc=;
 b=sSUcixghze+ESmKtNCQ9H0qUvcrc3Q+idk0usY3L0TjTj6nmPl1/RrD/Y92azv4hQN1Nb0WQnjxhFSijC5FTbWZQxPU/CHF8BjWVQo8xgXoCNwD948iKkzllZ/gfA9I43IwWNiXHLTvVnxefSumpISECWOlPgFAe+I/8F06qUhI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB4898.namprd12.prod.outlook.com (2603:10b6:208:1c7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 18:00:40 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8%9]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 18:00:40 +0000
Subject: Re: [PATCH] drm/amdgpu: fix off by one in amdgpu_vm_handle_fault
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20201102162351.1493-1-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <937e28dc-51c3-d0cb-2e97-445894f3c4b3@amd.com>
Date: Mon, 2 Nov 2020 13:00:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201102162351.1493-1-christian.koenig@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.13.173]
X-ClientProxiedBy: YQXPR01CA0112.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::41) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.13.173) by
 YQXPR01CA0112.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:41::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Mon, 2 Nov 2020 18:00:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 89d054a1-0e5a-44ef-2927-08d87f59359f
X-MS-TrafficTypeDiagnostic: BL0PR12MB4898:
X-Microsoft-Antispam-PRVS: <BL0PR12MB489840FDE0348109018B152992100@BL0PR12MB4898.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SjlIVVzPFvV++EnL2MPn1wXQ//SWjy09HU75vji24VxjP83k2I1sjRH4Ol9Xbts5EkjXlno4mJtpJ77lU+xakfJksdHe6A4XerRJFS0ihXy++8nGTxGLfT29FsXp3GZScwJ7BaOWCDMq3crb+MbVrtA7E3cAViHurD+giBh8U7OOBUsb7neG0PqRabT8bwh+pw3v4t5RnFdVI+yGhH5kzQ9lDmo3/WN7O8rGPlKP3x6ucp/7Y8arNHQyXZlLJ1WrcC2fLFS4zunsKCugpQ8ebCaVxBecUcIQXaEa8lY9D9kydEiCAqYk8eHTwrpKLm3L/wjrueYfsFTrb8K4TmupY/11YauCFDtCk0UKSGr9NoyTBlVUKc9MldDbItrPTsAY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(16526019)(26005)(5660300002)(66574015)(186003)(956004)(31686004)(83380400001)(478600001)(2906002)(2616005)(31696002)(52116002)(6486002)(86362001)(4744005)(44832011)(8676002)(66556008)(8936002)(36756003)(16576012)(316002)(66476007)(66946007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: EPpetrGFesBRxz2VHxoYvxaEe/aZ+8StZjbULKph179o1zQh7mGdcDIvQnXc2ljTqX/MCxYhaybNo2WG0dDqX1xDYy4PiJl0NS6qYWpMFTOM6xC1k36dKOrnliyeMHRukEowaSkAwAiDarKSjUWf13SmpxEM99Be7FiVbuMJ4wZjHzmjq0CNmj7iCQECLF5bgPEHltfzaOKUxkgiLyVQz5X7iCO/sM5a8cZDhDbYGLgLRKGguab5I7l9IixVuwgrdgzel8lG7R/d820p8h+jGp+L259bNQG8dIWvxBjHYAA3GYy9Fk89/p7z0Njfyz2eRnOIzrzu64lM0lAqJLcDGIqT4IHNPrg5oiJ3rFzXScBTRWxOIDVEYu0K0e48oc/jIDi272l3TI0+EbdQT+EqEvBMXrQBeIo7VQTOcLO3gaod+c3DjFbskHz9qyjh/ndwbdjfAis7hDJXiJbjkr2Rs7sgZuFhEAXQE8M3GqVBHl4mAUrbwESRbbEG5x29hqRkyZCAgDhr2XU/ZlpSLPgk7AEyInusHZY+KIuf8khcIHWgTSpoZVZvwM8m28gD37RkbhBtH5wGDcztOt0JViwRKG3hwM60w7/2KpekKdMPrODYQ//HWB/BB12nb8hRHecNAbzyBPL8G9Yu74FH6V8AsQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d054a1-0e5a-44ef-2927-08d87f59359f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 18:00:40.2938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s38piN+VLo8pU/fwMRQivkdGeT74tBVuVJyvfND89Zi+2yuVREGkDQP0vRKdU1vDq26mPf/MIDkB+Me4MabGNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4898
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

CkFtIDIwMjAtMTEtMDIgdW0gMTE6MjMgYS5tLiBzY2hyaWViIENocmlzdGlhbiBLw7ZuaWc6Cj4g
VGhlIHZhbHVlIGlzIGluY2x1c2l2ZSwgbm90IGV4Y2x1c2l2ZS4KPgo+IFNpZ25lZC1vZmYtYnk6
IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KClJldmlld2VkLWJ5
OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KCgo+IC0tLQo+ICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYwo+IGluZGV4IGRjMGJjNTUwZTQyYi4uZmRiZTdkNGU4YjhiIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBAQCAtMzM1MSw3ICszMzUx
LDcgQEAgYm9vbCBhbWRncHVfdm1faGFuZGxlX2ZhdWx0KHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LCB1bnNpZ25lZCBpbnQgcGFzaWQsCj4gIAl9Cj4gIAo+ICAJciA9IGFtZGdwdV92bV9ib191
cGRhdGVfbWFwcGluZyhhZGV2LCBhZGV2LCB2bSwgdHJ1ZSwgZmFsc2UsIE5VTEwsIGFkZHIsCj4g
LQkJCQkJYWRkciArIDEsIGZsYWdzLCB2YWx1ZSwgTlVMTCwgTlVMTCwKPiArCQkJCQlhZGRyLCBm
bGFncywgdmFsdWUsIE5VTEwsIE5VTEwsCj4gIAkJCQkJTlVMTCk7Cj4gIAlpZiAocikKPiAgCQln
b3RvIGVycm9yX3VubG9jazsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
