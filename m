Return-Path: <SRS0=PoT7=EI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6F4C00A89
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 18:59:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5C812225E
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 18:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2CSodIce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C812225E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EADB6E16D;
	Mon,  2 Nov 2020 18:59:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C83B89A16
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2020 18:59:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVmAe/yiFAdpBp4DqpbA4eU9JnR7spIJcIe1pa96UhHDpOX1F/Zl7e7VGcJjz9tjIgWuZ8ijbwZclGw6qxIhHWOXy3AzQ2wjzV0wCnrqvs1R8cvkKMzbV8tvibPeLMNAEpMK4rqEQjUvXMUh+S3lQM1cAbYbnv5XbKFm3PqQ+GYMiK3ad0WuBdZwnYzAZAHEGAtsPM0hMhvIpZEPI3pRsZG894lzbhL5h8FNeO6ohgBWt5Ye9hEEMHwCGJWnZI+JyysIzPZohwCdUtkeIvazixSFES/NzJ34mHGLdOLA02x7o20YuEUyD9IiHp0fvFibfS4mHe7d8xsq1D/2G22PjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzsDWRamaD7qPqP8XvkSuHnEu/X2cozpthKHBn+Qg14=;
 b=cF3Bzur2kMiJbxlYOq9gBJWmBA8Ss891iRQCo//+5uAEm1FUnovTjkR59/96zc1w3D2ilaSPnJ0b7Sm6i9IpthhUbgR11UHDAGJYFTnN+y3BBZKnUfvEJC+HvhOV3kdXyHBfU9OTC9zdoJsUWDsbthGkIQm5NayM6cAKf/rcvQNzalj6/lZXVa+5CBifLUr/FSo67/kcnmtoFw+g8VCYOgpzgHlDWTA/gCAaXngWZsBR5oxcUGTJ1d7YWpG0ZYDX1jcXHY2YMevosqxUjOSAOjDUpjJqWwWqA68r9ApHmvXtaL+Q5Q3k0rDd0k8gUuAUEESFF4eu9cpdDJxi5T7Ziw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzsDWRamaD7qPqP8XvkSuHnEu/X2cozpthKHBn+Qg14=;
 b=2CSodIceTtv2IXntvmKkYCFa9JjDZuLmRZRaEiUBtlKob8vDnPUevlol+9ov5EkT9HiWVk8bvkFBuYNfpDdVnOdqfhFALZDRqezNjzj42lvU5NHqrwpn7V2ip2oP0DUKUi1yVnBTvXtNEs6FpeIPIdkLWjzTbJP6f5t+JbcuIFY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB3694.namprd12.prod.outlook.com (2603:10b6:208:165::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Mon, 2 Nov
 2020 18:59:20 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8%9]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 18:59:20 +0000
Subject: Re: [PATCH 2/3] drm/amdgpu: enabled software IH ring for Vega
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20201102113353.1422-1-christian.koenig@amd.com>
 <20201102113353.1422-2-christian.koenig@amd.com>
 <CADnq5_PfY=f9gC6pEu-xzO_Z-Z1ggnW5UrR56oh9e4z96MYNBA@mail.gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <29159f4d-e769-193c-b304-d21693519be1@amd.com>
Date: Mon, 2 Nov 2020 13:59:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CADnq5_PfY=f9gC6pEu-xzO_Z-Z1ggnW5UrR56oh9e4z96MYNBA@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [142.116.13.173]
X-ClientProxiedBy: YQBPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::35) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.13.173) by
 YQBPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.19 via Frontend Transport; Mon, 2 Nov 2020 18:59:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b98ab45a-ce47-440b-7849-08d87f61679f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3694:
X-Microsoft-Antispam-PRVS: <MN2PR12MB36948CA2B471E585C2BDA69592100@MN2PR12MB3694.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HmO5H+PS45LDKEDUSTrHSttQxznCV6KFuL6BtM/ViqyM3sUFYa2k4jPWgyuZqUlCy4yQw61VThprAUKKCcJtN6XM+TRe3PQ/IxwWzExPF7SURnL5LTFPMR+H2bQcBfFbAPdUNsg93AsH4HikewNltZO81xSD9+zYdWGm/S8nPi6QSg6C+4mEMutMXUsWQCDjMp0gIdAGonlnHlZWm6Z7Rs7lbLc7jrrTTXwrgPa/EKW2SLI877v5kDinLWqYiPwQoH9X0MSeqjVrqgKcQLUi2b9AnNF3H7MRSKyLyKF+R9lr+dApupPTd2KQV9Zd6/C6itJgFrAjdi3XqKVsd9/7N/Nlb47q2ynnb5znfj4HZmPcoA8jEk4GYMvuE7Ka9FQNVtnyWfHwAnhQKgSWmZ/+Qm7659/TLdWQsw9+UTmwk0c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(52116002)(956004)(86362001)(53546011)(4326008)(31686004)(36756003)(6486002)(2616005)(26005)(478600001)(316002)(66556008)(66946007)(66574015)(16576012)(5660300002)(966005)(66476007)(44832011)(8676002)(8936002)(2906002)(16526019)(186003)(83380400001)(31696002)(110136005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: NClMT49Bp9Ioq/dwW4SS9xxbnvrW1wLTzACrm4hYxarNBYX0QDk/CvN41spZGTMQQ6lDExn/uqUNlDjtlN3MYJtepDYc1FPK8OEhpI3w1WTayyf74vh2Ay9cjeFdFWipCYTc/1q2VWW8qpZN/yEKnXpSLWXGBXkIREheXVGRWenoTfilbX0yhaCxRUidH/uCTbbgwFqDJkfQ9o+TJ36aGD5PGsGxkVsDsHJyyhqOc0cCMzo39KQY7BG9cJUl9TifOApZIOWICPIPMEv0Fa0CiEWBnNFXcJ1sjMHtl/7dsy0urcRhUAATS+p3qpIj+x+35/fToRcXKz55Em/Hwy68182fXACyUoZXFp/A0pLjg3HHpRzbFJCwQ+K4w3eZUMPu9l30/U5TA9cKZMcR6kUuuhfhjPuX/c0iUGSqIVrh/AYCr8hPBT3y9uT/OmsQnNGJBwhomM8UEClOPI1uCy3Ak50bPsBh6eEUefGIxhYyfe0v/PmnEcLvTVxlNaF5EJjfgZGcWHW0MuXnv9Ab2cYjx5jKahbL9zT0j4VeZZ+s5kaPaQzFe8cqZhn7wQdrxCaOMu3koP0AppeRUkHgwLvG+17nw2KeVhyErQyMXTLOwzgiGTJ8Km7un5UfbGcwmNTrrykV3W4fRXiu4AZxnvehZQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b98ab45a-ce47-440b-7849-08d87f61679f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 18:59:20.1458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhojmpEKh/1Judyr0CZ8BqPvv8eodHgRtuyShxwHKvy3WMGECrPG3h/rF9QhQdE4MBjPU1cojIt+xWTcegwAOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3694
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMC0xMS0wMiB1bSAxOjUzIHAubS4gc2NocmllYiBBbGV4IERldWNoZXI6Cj4gT24gTW9u
LCBOb3YgMiwgMjAyMCBhdCA2OjM0IEFNIENocmlzdGlhbiBLw7ZuaWcKPiA8Y2tvZW5pZy5sZWlj
aHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOgo+PiBTZWVtcyBsaWtlIHdlIHdvbid0IGdldCB0
aGUgaGFyZHdhcmUgSUgxLzIgcmluZ3Mgb24gVmVnYTIwIHdvcmtpbmcuCj4+Cj4+IFNpZ25lZC1v
ZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4gLS0t
Cj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMTBfaWguYyB8IDcgKysrKysrKwo+
PiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS92ZWdhMTBfaWguYwo+PiBpbmRleCA0MDdjNjA5M2MyZWMuLmNlZjYxZGQ0NmEzNyAx
MDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMKPj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMKPj4gQEAgLTkxLDYg
KzkxLDkgQEAgc3RhdGljIHZvaWQgdmVnYTEwX2loX2VuYWJsZV9pbnRlcnJ1cHRzKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQo+PiAgICAgICAgICAgICAgICAgfQo+PiAgICAgICAgICAgICAg
ICAgYWRldi0+aXJxLmloMi5lbmFibGVkID0gdHJ1ZTsKPj4gICAgICAgICB9Cj4+ICsKPj4gKyAg
ICAgICBpZiAoYWRldi0+aXJxLmloX3NvZnQucmluZ19zaXplKQo+PiArICAgICAgICAgICAgICAg
YWRldi0+aXJxLmloX3NvZnQuZW5hYmxlZCA9IHRydWU7Cj4+ICB9Cj4+Cj4+ICAvKioKPj4gQEAg
LTYwNiw2ICs2MDksMTAgQEAgc3RhdGljIGludCB2ZWdhMTBfaWhfc3dfaW5pdCh2b2lkICpoYW5k
bGUpCj4+ICAgICAgICAgYWRldi0+aXJxLmloMi51c2VfZG9vcmJlbGwgPSB0cnVlOwo+PiAgICAg
ICAgIGFkZXYtPmlycS5paDIuZG9vcmJlbGxfaW5kZXggPSAoYWRldi0+ZG9vcmJlbGxfaW5kZXgu
aWggKyAyKSA8PCAxOwo+Pgo+PiArICAgICAgIHIgPSBhbWRncHVfaWhfcmluZ19pbml0KGFkZXYs
ICZhZGV2LT5pcnEuaWhfc29mdCwgUEFHRV9TSVpFLCB0cnVlKTsKPj4gKyAgICAgICBpZiAocikK
Pj4gKyAgICAgICAgICAgICAgIHJldHVybiByOwo+PiArCj4gU2hvdWxkIHdlIG9ubHkgZW5hYmxl
IHRoaXMgb24gdmVnYTIwPwoKSXQgYWZmZWN0cyBvdGhlciBHUFVzIGFzIHdlbGwuIEluY2x1ZGlu
ZyBwcm9iYWJseSBzb21lIE5hdmkgR1BVcy4gV2UnbGwKcHJvYmFibHkgbmVlZCBhIHNpbWlsYXIg
Y2hhbmdlIGluIG5hdmkxMF9paC5jLgoKSXMgdGhlcmUgYSB3YXkgdG8gcmVsaWFibHkgZGV0ZWN0
IHdoZXRoZXIgSUggcmVkaXJlY3Rpb24gd29ya3MuIE9yIGRvIHdlCm5lZWQgdG8gYWxsb2NhdGUg
dGhlIHNvZnQgSUggcmluZyB1bmNvbmRpdGlvbmFsbHk/CgpSZWdhcmRzLArCoCBGZWxpeAoKCj4K
PiBBbGV4Cj4KPgo+PiAgICAgICAgIHIgPSBhbWRncHVfaXJxX2luaXQoYWRldik7Cj4+Cj4+ICAg
ICAgICAgcmV0dXJuIHI7Cj4+IC0tCj4+IDIuMjUuMQo+Pgo+PiBfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+PiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
