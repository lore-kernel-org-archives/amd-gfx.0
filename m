Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1771FC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 09:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2191206A4
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 09:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VWyU8ril"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2191206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 664EE89D58;
	Tue,  2 Jun 2020 09:30:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD7F089A92
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 09:30:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4JZXhDu/k68ufs9RhVQluKc4Q6HtnFtQ/FCsb7SifTDMududd8avQMdHIcsuWgsfFts7BDA9NG/OeJdogIelNF0LxF6lAJPAxhc3jdTcT93IMPrNAUIb64rW1vL8vG6M9gr/exNrk46tfQDEmC7KXWdR5lV6ScmuM4oL9LhD2tHIOUic3WOoNP/sGUt7yksj0E8tgW5YbbWZmcvPOler1vs0Y202THI3eVWsARyjWXPCThN5m0AMzXQ8JqeAxi/XUqBKHietCTUHnYBtAssnzfGtPs3CH27+04rkWZrFPd4kxPG7sPuhESSAyIQ21HGScPZ1NbsqTALcBsQzPI4Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wD+3jxPeEmAVc4OcHwBdDhTJ0xN/2J+DW5nOYnv6kMg=;
 b=Oe7Vd3qwAmEpYklOqa8SHfo5vxP8Vy3x+PhUZobCRxjyUHc2fHZ7SeAggqR2fcRw22CFxDpsvRI0lfC7rqUSSptPa8BJ5/7qhpbs7c77YZo4MiVdj5vT77/i/fOwvuTmfOqx3d5FemrUPnaqGqru2YqzUKZd50p5Hlajf9C0W8pVsxjGQKA+IDj7jnxqUAKcZB29CTMMuAF8YSuLMdfJbR9Mv4ftBiIoSEHM0ZkTRQttbq7+x0mZXoFWTGQWyazIZ5KE2rYbau5Qu5i6lyE526fpitC7rVnVoGfmgAnEZqxe5Tyaqrw8qVEsoRHGP0lJ1GHjWUY1zzTflyLTWM5xYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wD+3jxPeEmAVc4OcHwBdDhTJ0xN/2J+DW5nOYnv6kMg=;
 b=VWyU8rilttfJm7LrXrNVsOs2JEX3uY2+PE26rJ72ZGFEfEmkbRtz8bjmlbkXgmkTGV7RginNqEMivBAdaTR0iIWm8X9fMHIErM/LTXpq9LZ64ib7RfVKTsok7K9Mv3Moo+su6bFhmspV66Ma3LZJMBFl6+/XNMao1n80YOPtPmU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3146.namprd12.prod.outlook.com (2603:10b6:5:11b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 2 Jun
 2020 09:30:11 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 09:30:11 +0000
Subject: Re: [PATCH 077/207] drm/amdgpu: no need to set up GPU scheduler for
 mes ring
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
 <20200601180239.1267430-74-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <9640f151-cfe9-600f-cc4f-7b056c09be0f@amd.com>
Date: Tue, 2 Jun 2020 11:30:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200601180239.1267430-74-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::24)
 To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FRYP281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19 via Frontend Transport; Tue, 2 Jun 2020 09:30:10 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 83191e3c-e628-4aff-ec2a-08d806d78c09
X-MS-TrafficTypeDiagnostic: DM6PR12MB3146:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3146267BBFB4E436531C6E1B838B0@DM6PR12MB3146.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ZOzicMLB463aDU6uNjwJp8fJXjoQ4VgovwmyZ2uF6PIxys2eUCchm6TubHVkj72VY2U1HQ3+Cv+EfpWO8dMiMpJ1Kvv7Ra/LJL6eY0lViK05+DT1Q6gVpywBMRSJ4pkXouO3x8QH90gDkbOqoJ7KHsPvNwwvygt+ndPGN0qN+4v82HOTqYAtywbZwyn79WUglTCKbxlARMi8tSvGV33z00o2M3B9qCFB62pvqAj4IoeOaGmuBI04yZexky0imdBJFqBVCl+cnEarnoIrc30pCUYoZps1Ch7ccK1rZOkoPPwjXyxPBYhvvCcCpVM5FD11uRSk8ZrQshbddy95/WSH2QcdsTNtx5XQhJUo5JTFrs3UMXfEFvslL+AltmQq62g
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(8936002)(316002)(8676002)(52116002)(6486002)(4326008)(6666004)(5660300002)(66476007)(66946007)(86362001)(66556008)(83380400001)(2616005)(16526019)(54906003)(36756003)(2906002)(186003)(478600001)(31696002)(31686004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: SwUBaB5qnt0sh/8cxt/fKK81ND0SN83xAQht57Ax7+fcpffe3shRJ8G48VR6o3BD3CnCa+8Y/Lo5rfoNE5OPQ/7WlixVfV+Zg4EjbQSQ1wlkE3HfjGh+mPw7OuAtADkWYqhJH0Zw4D4pfxzCEFDGMOCMjw+sIoCmyqge0YrLxqSCmTHaY8lqQWCUl4LhVJMA7oAng2dJKfLHRX/DSVEPtmJMTBW0tBTyUnuFp5WvOyhRIpWlbxr1EszVhTvRjyBM0boNRqxilYtnoj+r9loXADiB7WKK3GbhdDbD/byqlus31ad4hZgAzmxfWBkJuHSbjaUa/KlvIAa2nhK7ll4b62pBHn7fqk6qrK/uGD+YafmGETmMO4yFuEDKF9vJs9DdlNu6Q5qn1mBV9fJLZOoWo0NeGhdvJrFUjtuA5pjn76xIvGdVDdYcg3iPQV96a5IrbyB8xeKWjkuaGFxKj78A7ulTHaUn3NQX9ctzzxkyDE+cY90/Cs6JUwmlkwfAxLrG3Ic+ujn+/I/l4LYAcuti8a3oSHpEd9Q6e/6ClPAea4MY8tOvutWdWG+kcIKTcDYW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83191e3c-e628-4aff-ec2a-08d806d78c09
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 09:30:11.1913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W16QHwIuu9WcTA5H2bkTpDH/9q4vBD626ThSfcRzInHBF5vHziens68Pin73i3fp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3146
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDEuMDYuMjAgdW0gMjA6MDAgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gRnJvbTogSmFjayBY
aWFvIDxKYWNrLlhpYW9AYW1kLmNvbT4KPgo+IEFzIG1lcyByaW5nIGRpcmVjdGx5IHN1Ym1pdHMg
dG8gaGFyZHdhcmVkLAo+IGl0J3Mgbm8gbmVlZCB0byBzZXQgdXAgR1BVIHNjaGVkdWxlciBmb3Ig
bWVzIHJpbmcuCj4KPiBTaWduZWQtb2ZmLWJ5OiBKYWNrIFhpYW8gPEphY2suWGlhb0BhbWQuY29t
Pgo+IEFja2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4g
UmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KPiBSZXZp
ZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IFNp
Z25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiAt
LS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jIHwgNSArKyst
LQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jCj4gaW5kZXggMzQxNGUx
MTlmMGNiLi44NzEyYTJlMWI4NjkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2ZlbmNlLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZmVuY2UuYwo+IEBAIC00NjksOCArNDY5LDkgQEAgaW50IGFtZGdwdV9mZW5jZV9kcml2
ZXJfaW5pdF9yaW5nKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywKPiAgIAlpZiAoIXJpbmctPmZl
bmNlX2Rydi5mZW5jZXMpCj4gICAJCXJldHVybiAtRU5PTUVNOwo+ICAgCj4gLQkvKiBObyBuZWVk
IHRvIHNldHVwIHRoZSBHUFUgc2NoZWR1bGVyIGZvciBLSVEgcmluZyAqLwo+IC0JaWYgKHJpbmct
PmZ1bmNzLT50eXBlICE9IEFNREdQVV9SSU5HX1RZUEVfS0lRKSB7Cj4gKwkvKiBObyBuZWVkIHRv
IHNldHVwIHRoZSBHUFUgc2NoZWR1bGVyIGZvciBLSVEgYW5kIE1FUyByaW5nICovCj4gKwlpZiAo
cmluZy0+ZnVuY3MtPnR5cGUgIT0gQU1ER1BVX1JJTkdfVFlQRV9LSVEgfHwKPiArCSAgICByaW5n
LT5mdW5jcy0+dHlwZSAhPSBBTURHUFVfUklOR19UWVBFX01FUykgewoKQlRXOiBNYWtpbmcgdGhp
cyBhIGZsYWcgaW4gdGhlIHJpbmctPmZ1bmNzIHN0cnVjdCB3b3VsZCBwcm9iYWJseSBiZSAKY2xl
YW5lciB0aGFuIGNoZWNraW5nIHRoZSB0d28gdHlwZXMgaGVyZS4KCkJ1dCBub3QgYSBtdXN0IGhh
dmUgcmlnaHQgbm93LgoKQ2hyaXN0aWFuLgoKPiAgIAkJc3dpdGNoIChyaW5nLT5mdW5jcy0+dHlw
ZSkgewo+ICAgCQljYXNlIEFNREdQVV9SSU5HX1RZUEVfR0ZYOgo+ICAgCQkJdGltZW91dCA9IGFk
ZXYtPmdmeF90aW1lb3V0OwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
