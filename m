Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5E3C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 03:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C0F64EC4
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 03:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C0F64EC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 816B26EC33;
	Thu, 25 Feb 2021 03:22:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DCE06EC33
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 03:22:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMQ9SypHM2vPei9KXpvvSjXUTJ/NOlyUSS2KFbKPU0wa6yVJmtjcQtQrnxgBdCoqTo0NrpNk0U2RpwtkB+ev1z/yeshOwZTKX269i7XNgQY0VhJEIdQ//fN/D0o/FiHINpwAV80DwxC7KbhAgvZaYIfremvgm1sAWrV32HxmwYozcpleHtq4q1eKPtbY+K7rKJbMTZh+FQDY3SoMZaP2/8FZhOYiHw72gfcdaZD5zBpJ9whGjK6K3iV5ffzgPNbJosysK2z6h4JniE1EafXN2J8rNLHMxvhvMUBPGAJZ1m1+5zder+FOsruxhHTLNX6mtgJivcZAcXSroHz0kLVVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iC63MtsWis9e9MVKeRzsrQQZQ4GlxKiUMShnXKvwxS8=;
 b=HX3x/NINfOXXW8ZNiKE/G8gsEtCeNSkhLmMJqjwYcCzXsjdA0s8a1FiJu3GWZklqLzA6L+SA2d022UYdrhVs90m1k1aEzOMhPX3pqzDISUoWU/AjMkA1ZY23yYgSP0MBDBfsuUIMym7I7hBI81wJXEv+BPbHy+exX7r35CY3eAUQBIIGwcp0Ljl0LD4j1FtlbKPg2S3SI99hDLmYcdt1Vzn8Sl5r2C9fzPBdCV3VfaHI114j1OJ1SBngmgLVKweSzO1+sw2A53ipKOA631K+GguUPfzNGXydw6pHBSE7daNWv8fzvCuEbo33UbPPmT1ZJr0EnlWbvsOgl3MDEbfz6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iC63MtsWis9e9MVKeRzsrQQZQ4GlxKiUMShnXKvwxS8=;
 b=CeJLMp6O77FvAgHDsPjfInZUFFg76jzzXPDPOiM0jMF4dajN863mEv8ysgPLjywMSjKbLTYKE/43kbp3va+Z+J4UVQ58ooebeoskMlujZJ/TLBYSVGOUtM24PftEIv1rgRntQ/i27PkiHD02OR59F+rtJRKPR3JhyxYfx1bhjjo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB4756.namprd12.prod.outlook.com (2603:10b6:208:8d::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 03:22:53 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%8]) with mapi id 15.20.3784.030; Thu, 25 Feb 2021
 03:22:53 +0000
Subject: Re: [PATCH 147/159] drm/amdgpu: restore aldebaran save ttmp and trap
 config on init (v2)
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
 <20210224221859.3068810-140-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <0b302303-9964-5c82-3722-33c5d66cde1b@amd.com>
Date: Wed, 24 Feb 2021 22:22:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210224221859.3068810-140-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::35) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YTOPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32 via Frontend
 Transport; Thu, 25 Feb 2021 03:22:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 77aa3f86-5a17-4142-4833-08d8d93ca344
X-MS-TrafficTypeDiagnostic: BL0PR12MB4756:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB47561F8296307EA6CC0BDD94929E9@BL0PR12MB4756.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5sKrtvb+qCBdLrt+V8oO+19Oe7KRLtK/vFc8V5gKnny+0UfHRcTJFwdqKhsqqyy/3TIMHqa/aDwp0dZ0R18Rz/IGX4919zIOHO2Y8fvVWlBwgAtH8ovLGey5tevD4rLyvYTQYXyZhjCM6e8B9RiiLnmmUvyhqNXpyphu+jfYbFLvK/sR4NgzswrS1UglKIqmMHW60NtexoMuBbYz//BkSsrsFKXaH6mrXSssFcqFOLuS69/eTaFg8bu7yRBF6GXz560OASCHMVPgFWRXnzw4pTorfHzwqIWURf/1fYeoEPiSpIpo+xcBi8S4uYm2pSysKxKYNCpQprmAWJe2d4CFTnSEz0ps499TOU7wApdUtCkcHpueUhvv3xfOUjmD8nI09Ra6D11rAYXsign2z/kZSmioR7tjvJ3OWSfijnmC5qjVhu6109BB65Dc5AGUu84UQM+U9BvsKKXuQ5N6ODoTaxjOBCjJzisz/2n3kYyCUK8sdEujIqlII+pQcQy4chXNmR3MnwKHJc2DhZeTFG0eOCso8D6/ukGx/9Xl5AAz2yNQjH1MK6Eq76RGp8LXSJPMEVoPtz/fTUX0DR1IVl2fNPiGzD0PtodB6L43PaGyl/w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(4326008)(53546011)(36916002)(31686004)(956004)(2616005)(6486002)(52116002)(66946007)(186003)(5660300002)(2906002)(44832011)(478600001)(83380400001)(86362001)(36756003)(16526019)(31696002)(8676002)(26005)(16576012)(316002)(66556008)(66476007)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ekt5ZXNRK2FLRC9GSllxTkZldExYeUR0Z1N3MmhpRW1MajhyMDlKdG1BdVhx?=
 =?utf-8?B?ekMwNjNOaGdvbWJITkJyTThPbElqOTlFVmVMRnhnbVh6SGFhcHc4TSsxOUhl?=
 =?utf-8?B?cm5MRGlFT3pEYmZ6VGF2aXplNHpQK2dRMXZidklwYkg3cS9rYVBMUkhiRGUr?=
 =?utf-8?B?R1IrdUhYdHZEL2huZ1hpUkVWQ2ZTNlVGdDdjQlo1ckRrNkFPQnNqQ0R1SExm?=
 =?utf-8?B?ZjRzRWhCZFh4eXFBUnRBUTgwNlJJcHFkYStHUG1rQzFtdzRoU1lIaWhNUEFO?=
 =?utf-8?B?enFoWWNMOUpySXRpdzJnSVBnN1VUNTNmZ0Rud3lFYjQ3bEgzcEtIK1hCUjV0?=
 =?utf-8?B?M3FPVzRtR0tERmd0LzU1VkRwRHNpWmR2VUNwOVBSZjNmZlhiekdIT0NWaEVW?=
 =?utf-8?B?RmgrN205OWRrdkxsNXQ3QjdWMlRlUHpyOGRtMWh4ZXJGQ0FCUDZOK1UrYzd1?=
 =?utf-8?B?NVI1UHYrVmRaMlliUm5STXFuNEtFWWxva2hMUkY0dVBuSGFCYUVuUm5VVFRM?=
 =?utf-8?B?Qm1nMHN0dXk3NS9GQ0V4ZHpRTFdxeXdCc0k0UmVmNzNNb3FLQWVaRTdrTmV5?=
 =?utf-8?B?aDhNazJVT3ovZVV1YTBka20zQ2J0WTc1a1UvcGp2cGJPY3dMWXZYV1kzWThI?=
 =?utf-8?B?cExtNmNWOUtqczBpakg2ckoycEp1cVlTRHJvNk0yVUFDUzF4QW9nVUY4ckty?=
 =?utf-8?B?OWtuZTNYT3pMdFJ3TjFKemZmakdPTlJiMENWREp5bTdqZVF6Lzd3clM3MFNs?=
 =?utf-8?B?RUJlclZTcnZxaUhFYlZ1YUk2Y05kM0Y0VXlNejR4b3NHd2VWZDlZK1Bab0ts?=
 =?utf-8?B?OEkxTWlhU1NsKy9OTk9EeXBtb01IQWp4VUpsOUpCeHB2M2dWbWUwY091TlRC?=
 =?utf-8?B?aUdWS0tpR1F1c3ZqcEFtbXRwaWtpMTg0YzFnWXFMd1JueGlvWUR2YXNGSmx0?=
 =?utf-8?B?STRIcVpTTUZSNThBYkJuQ2lWZ05NSVVkVktnSnpqcUE3OXozczJZNUZWcktR?=
 =?utf-8?B?cnVaU2FwcHQrYlRsd1lQR0l1MjdNdGx6QUxvMS9yZUlzci9QMkRLYy9zNFZ0?=
 =?utf-8?B?aDRsSmQrY29oMS9YaHBaMk1jOUVwOUFkSW5tc0ZQQUNJak5qODRyNDhLdVVu?=
 =?utf-8?B?YU5VOWpKWlFGSmE3a1B6azBBTWx5cFdOUkR2ZDBqUHZOUkJkSEdkZWNqUTFL?=
 =?utf-8?B?LzFJWnZ3RTZUVkVnMGlsUDdVQjFjWnJaSmFBYms1SGhzOHY4TWxjcCtJMHo2?=
 =?utf-8?B?MzY0SGc3UWViL0RwOEdwNkFSdE1CNjFrdE8xSXdRYkVJY3pIbDg1SzdzTWdo?=
 =?utf-8?B?dWJjWmRTV2tvNmFxM2pKcTU3US9kNm9qUFhUUk5rUHFsZmN4a3NMTENpcFlu?=
 =?utf-8?B?QlNSYlI3YWd0WER2bGNzNzlMUis3STIxZmVvMGI0d0dQS0VPbFRRcWxxWjMw?=
 =?utf-8?B?SXF3VENmVkJqbDViWGh3R3E0QWpvNGZWN0hhSjU2SVJHZEZIVi9abHNnT3R6?=
 =?utf-8?B?UURkbWNGb0lZSUZRd1h1RjJDMWRldXhjNjQ1K0hEUmFlY3RUVTNYcWo4ZU10?=
 =?utf-8?B?TDNMcXYxbzEvN0dRSUVPNEl3UEd4N1NRSVB6Z0YrZ1Y0VWR5Vy9ud2NNamZv?=
 =?utf-8?B?Z3JUVTNsTGpVVHFUYzl1UmRCVk1GdCtQeEJmdERQcWF0MkUxYWVMSTRVN2t2?=
 =?utf-8?B?MGxpZnNTNWZHVy9icTRyTWw4MTAwcnE1L0dkR0loVjlGMVZ1WFJkUllSa05w?=
 =?utf-8?Q?o/2zlgFN4QnzWG8FI2l1gyBdHuLynFyCUTnhhM/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77aa3f86-5a17-4142-4833-08d8d93ca344
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 03:22:53.5153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kk/UPeY9/IyCdnQk2GcQBwxSxsjHN6KqN7KxhzutFa377eg9NWTwvXzodBFUry3mqCNtvNViLkqBIBFiVFmMeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4756
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
Cc: Jonathan Kim <Jonathan.Kim@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBwYXRjaCBpcyBmb3IgdGhlIGRlYnVnZ2VyIGZ1bmN0aW9uYWxpdHkgdGhhdCdzIG5vdCBv
biAKYW1kLXN0YWdpbmctZHJtLW5leHQgeWV0LiBZb3UgY2FuIHByb2JhYmx5IGRyb3AgdGhpcyBw
YXRjaCBmb3Igbm93LgoKUmVnYXJkcywKIMKgIEZlbGl4CgpPbiAyMDIxLTAyLTI0IDU6MTggcC5t
LiwgQWxleCBEZXVjaGVyIHdyb3RlOgo+IEZyb206IEpvbmF0aGFuIEtpbSA8Sm9uYXRoYW4uS2lt
QGFtZC5jb20+Cj4KPiBJbml0aWFsaXphdGlvbiBvZiBUUkFQX0RBVEEwLzEgaXMgc3RpbGwgcmVx
dWlyZWQgZm9yIHRoZSBkZWJ1Z2dlciB0byBkZXRlY3QKPiBuZXcgd2F2ZXMgb24gQWxkZWJhcmFu
LiAgQWxzbywgcGVyLXZtaWQgZ2xvYmFsIHRyYXAgZW5hYmxlbWVudCBtYXkgYmUKPiByZXF1aXJl
ZCBvdXRzaWRlIG9mIGRlYnVnZ2VyIHNjb3BlIHNvIG1vdmUgdG8gaW5pdCBwaGFzZS4KPgo+IHYy
OiBqdXN0IGFkZCB0aGUgZ2Z4IDkuNC4yIGNoYW5nZXMgKEFsZXgpCj4KPiBTaWduZWQtb2ZmLWJ5
OiBKb25hdGhhbiBLaW0gPEpvbmF0aGFuLktpbUBhbWQuY29tPgo+IFJldmlld2VkLWJ5OiBGZWxp
eCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9NYWtlZmlsZSAgICAgfCAgMSArCj4gICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjlfMC5jICAgfCAgMSArCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjlfNF8yLmMgfCA1MCArKysrKysrKysrKysrKysrKysrKysrKysrCj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfNF8yLmggfCAzMCArKysrKysrKysrKysrKysK
PiAgIDQgZmlsZXMgY2hhbmdlZCwgODIgaW5zZXJ0aW9ucygrKQo+ICAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV80XzIuYwo+ICAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV80XzIuaAo+Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L01ha2VmaWxlIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvTWFrZWZpbGUKPiBpbmRleCBjNWVjOTI2YmM2ZDUuLjc0MWI2ODg3
NGU1MyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9NYWtlZmlsZQo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L01ha2VmaWxlCj4gQEAgLTEyMyw2ICsx
MjMsNyBAQCBhbWRncHUteSArPSBcCj4gICAJZ2Z4X3Y4XzAubyBcCj4gICAJZ2Z4X3Y5XzAubyBc
Cj4gICAJZ2Z4X3Y5XzQubyBcCj4gKwlnZnhfdjlfNF8yLm8gXAo+ICAgCWdmeF92MTBfMC5vCj4g
ICAKPiAgICMgYWRkIGFzeW5jIERNQSBibG9jawo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3Y5XzAuYwo+IGluZGV4IDViYWM1NjU5ZTcwNy4uNzhiYjRlMjhjMjdjIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCj4gQEAgLTQ5LDYgKzQ5LDcgQEAKPiAgIAo+ICAg
I2luY2x1ZGUgImdmeF92OV80LmgiCj4gICAjaW5jbHVkZSAiZ2Z4X3Y5XzAuaCIKPiArI2luY2x1
ZGUgImdmeF92OV80XzIuaCIKPiAgIAo+ICAgI2luY2x1ZGUgImFzaWNfcmVnL3B3ci9wd3JfMTBf
MF9vZmZzZXQuaCIKPiAgICNpbmNsdWRlICJhc2ljX3JlZy9wd3IvcHdyXzEwXzBfc2hfbWFzay5o
Igo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfNF8yLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfNF8yLmMKPiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NAo+IGluZGV4IDAwMDAwMDAwMDAwMC4uMGMyY2NiZTMyN2FiCj4gLS0tIC9kZXYvbnVs
bAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV80XzIuYwo+IEBAIC0w
LDAgKzEsNTAgQEAKPiArLyoKPiArICogQ29weXJpZ2h0IDIwMjAgQWR2YW5jZWQgTWljcm8gRGV2
aWNlcywgSW5jLgo+ICsgKgo+ICsgKiBQZXJtaXNzaW9uIGlzIGhlcmVieSBncmFudGVkLCBmcmVl
IG9mIGNoYXJnZSwgdG8gYW55IHBlcnNvbiBvYnRhaW5pbmcgYQo+ICsgKiBjb3B5IG9mIHRoaXMg
c29mdHdhcmUgYW5kIGFzc29jaWF0ZWQgZG9jdW1lbnRhdGlvbiBmaWxlcyAodGhlICJTb2Z0d2Fy
ZSIpLAo+ICsgKiB0byBkZWFsIGluIHRoZSBTb2Z0d2FyZSB3aXRob3V0IHJlc3RyaWN0aW9uLCBp
bmNsdWRpbmcgd2l0aG91dCBsaW1pdGF0aW9uCj4gKyAqIHRoZSByaWdodHMgdG8gdXNlLCBjb3B5
LCBtb2RpZnksIG1lcmdlLCBwdWJsaXNoLCBkaXN0cmlidXRlLCBzdWJsaWNlbnNlLAo+ICsgKiBh
bmQvb3Igc2VsbCBjb3BpZXMgb2YgdGhlIFNvZnR3YXJlLCBhbmQgdG8gcGVybWl0IHBlcnNvbnMg
dG8gd2hvbSB0aGUKPiArICogU29mdHdhcmUgaXMgZnVybmlzaGVkIHRvIGRvIHNvLCBzdWJqZWN0
IHRvIHRoZSBmb2xsb3dpbmcgY29uZGl0aW9uczoKPiArICoKPiArICogVGhlIGFib3ZlIGNvcHly
aWdodCBub3RpY2UgYW5kIHRoaXMgcGVybWlzc2lvbiBub3RpY2Ugc2hhbGwgYmUgaW5jbHVkZWQg
aW4KPiArICogYWxsIGNvcGllcyBvciBzdWJzdGFudGlhbCBwb3J0aW9ucyBvZiB0aGUgU29mdHdh
cmUuCj4gKyAqCj4gKyAqIFRIRSBTT0ZUV0FSRSBJUyBQUk9WSURFRCAiQVMgSVMiLCBXSVRIT1VU
IFdBUlJBTlRZIE9GIEFOWSBLSU5ELCBFWFBSRVNTIE9SCj4gKyAqIElNUExJRUQsIElOQ0xVRElO
RyBCVVQgTk9UIExJTUlURUQgVE8gVEhFIFdBUlJBTlRJRVMgT0YgTUVSQ0hBTlRBQklMSVRZLAo+
ICsgKiBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRSBBTkQgTk9OSU5GUklOR0VNRU5U
LiAgSU4gTk8gRVZFTlQgU0hBTEwKPiArICogVEhFIENPUFlSSUdIVCBIT0xERVIoUykgT1IgQVVU
SE9SKFMpIEJFIExJQUJMRSBGT1IgQU5ZIENMQUlNLCBEQU1BR0VTIE9SCj4gKyAqIE9USEVSIExJ
QUJJTElUWSwgV0hFVEhFUiBJTiBBTiBBQ1RJT04gT0YgQ09OVFJBQ1QsIFRPUlQgT1IgT1RIRVJX
SVNFLAo+ICsgKiBBUklTSU5HIEZST00sIE9VVCBPRiBPUiBJTiBDT05ORUNUSU9OIFdJVEggVEhF
IFNPRlRXQVJFIE9SIFRIRSBVU0UgT1IKPiArICogT1RIRVIgREVBTElOR1MgSU4gVEhFIFNPRlRX
QVJFLgo+ICsgKgo+ICsgKi8KPiArI2luY2x1ZGUgImFtZGdwdS5oIgo+ICsjaW5jbHVkZSAic29j
MTUuaCIKPiArCj4gKyNpbmNsdWRlICJnYy9nY185XzRfMl9vZmZzZXQuaCIKPiArI2luY2x1ZGUg
ImdjL2djXzlfNF8yX3NoX21hc2suaCIKPiArCj4gK3ZvaWQgZ2Z4X3Y5XzRfMl9kZWJ1Z190cmFw
X2NvbmZpZ19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICsJCQkJdWludDMyX3Qg
Zmlyc3Rfdm1pZCwKPiArCQkJCXVpbnQzMl90IGxhc3Rfdm1pZCkKPiArewo+ICsJdWludDMyX3Qg
ZGF0YTsKPiArCWludCBpOwo+ICsKPiArCW11dGV4X2xvY2soJmFkZXYtPnNyYm1fbXV0ZXgpOwo+
ICsKPiArCWZvciAoaSA9IGZpcnN0X3ZtaWQ7IGkgPCBsYXN0X3ZtaWQ7IGkrKykgewo+ICsJCWRh
dGEgPSAwOwo+ICsJCXNvYzE1X2dyYm1fc2VsZWN0KGFkZXYsIDAsIDAsIDAsIGkpOwo+ICsJCWRh
dGEgPSBSRUdfU0VUX0ZJRUxEKGRhdGEsIFNQSV9HREJHX1BFUl9WTUlEX0NOVEwsIFRSQVBfRU4s
IDEpOwo+ICsJCWRhdGEgPSBSRUdfU0VUX0ZJRUxEKGRhdGEsIFNQSV9HREJHX1BFUl9WTUlEX0NO
VEwsIEVYQ1BfRU4sIDApOwo+ICsJCWRhdGEgPSBSRUdfU0VUX0ZJRUxEKGRhdGEsIFNQSV9HREJH
X1BFUl9WTUlEX0NOVEwsIEVYQ1BfUkVQTEFDRSwKPiArCQkJCQkwKTsKPiArCQlXUkVHMzIoU09D
MTVfUkVHX09GRlNFVChHQywgMCwgcmVnU1BJX0dEQkdfUEVSX1ZNSURfQ05UTCksIGRhdGEpOwo+
ICsJfQo+ICsKPiArCXNvYzE1X2dyYm1fc2VsZWN0KGFkZXYsIDAsIDAsIDAsIDApOwo+ICsJbXV0
ZXhfdW5sb2NrKCZhZGV2LT5zcmJtX211dGV4KTsKPiArfQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfNF8yLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjlfNF8yLmgKPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+IGluZGV4IDAwMDAwMDAw
MDAwMC4uNWIxNzVjMTBkZTIzCj4gLS0tIC9kZXYvbnVsbAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92OV80XzIuaAo+IEBAIC0wLDAgKzEsMzAgQEAKPiArLyoKPiArICog
Q29weXJpZ2h0IDIwMjAgQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLgo+ICsgKgo+ICsgKiBQ
ZXJtaXNzaW9uIGlzIGhlcmVieSBncmFudGVkLCBmcmVlIG9mIGNoYXJnZSwgdG8gYW55IHBlcnNv
biBvYnRhaW5pbmcgYQo+ICsgKiBjb3B5IG9mIHRoaXMgc29mdHdhcmUgYW5kIGFzc29jaWF0ZWQg
ZG9jdW1lbnRhdGlvbiBmaWxlcyAodGhlICJTb2Z0d2FyZSIpLAo+ICsgKiB0byBkZWFsIGluIHRo
ZSBTb2Z0d2FyZSB3aXRob3V0IHJlc3RyaWN0aW9uLCBpbmNsdWRpbmcgd2l0aG91dCBsaW1pdGF0
aW9uCj4gKyAqIHRoZSByaWdodHMgdG8gdXNlLCBjb3B5LCBtb2RpZnksIG1lcmdlLCBwdWJsaXNo
LCBkaXN0cmlidXRlLCBzdWJsaWNlbnNlLAo+ICsgKiBhbmQvb3Igc2VsbCBjb3BpZXMgb2YgdGhl
IFNvZnR3YXJlLCBhbmQgdG8gcGVybWl0IHBlcnNvbnMgdG8gd2hvbSB0aGUKPiArICogU29mdHdh
cmUgaXMgZnVybmlzaGVkIHRvIGRvIHNvLCBzdWJqZWN0IHRvIHRoZSBmb2xsb3dpbmcgY29uZGl0
aW9uczoKPiArICoKPiArICogVGhlIGFib3ZlIGNvcHlyaWdodCBub3RpY2UgYW5kIHRoaXMgcGVy
bWlzc2lvbiBub3RpY2Ugc2hhbGwgYmUgaW5jbHVkZWQgaW4KPiArICogYWxsIGNvcGllcyBvciBz
dWJzdGFudGlhbCBwb3J0aW9ucyBvZiB0aGUgU29mdHdhcmUuCj4gKyAqCj4gKyAqIFRIRSBTT0ZU
V0FSRSBJUyBQUk9WSURFRCAiQVMgSVMiLCBXSVRIT1VUIFdBUlJBTlRZIE9GIEFOWSBLSU5ELCBF
WFBSRVNTIE9SCj4gKyAqIElNUExJRUQsIElOQ0xVRElORyBCVVQgTk9UIExJTUlURUQgVE8gVEhF
IFdBUlJBTlRJRVMgT0YgTUVSQ0hBTlRBQklMSVRZLAo+ICsgKiBGSVRORVNTIEZPUiBBIFBBUlRJ
Q1VMQVIgUFVSUE9TRSBBTkQgTk9OSU5GUklOR0VNRU5ULiAgSU4gTk8gRVZFTlQgU0hBTEwKPiAr
ICogVEhFIENPUFlSSUdIVCBIT0xERVIoUykgT1IgQVVUSE9SKFMpIEJFIExJQUJMRSBGT1IgQU5Z
IENMQUlNLCBEQU1BR0VTIE9SCj4gKyAqIE9USEVSIExJQUJJTElUWSwgV0hFVEhFUiBJTiBBTiBB
Q1RJT04gT0YgQ09OVFJBQ1QsIFRPUlQgT1IgT1RIRVJXSVNFLAo+ICsgKiBBUklTSU5HIEZST00s
IE9VVCBPRiBPUiBJTiBDT05ORUNUSU9OIFdJVEggVEhFIFNPRlRXQVJFIE9SIFRIRSBVU0UgT1IK
PiArICogT1RIRVIgREVBTElOR1MgSU4gVEhFIFNPRlRXQVJFLgo+ICsgKgo+ICsgKi8KPiArCj4g
KyNpZm5kZWYgX19HRlhfVjlfNF8yX0hfXwo+ICsjZGVmaW5lIF9fR0ZYX1Y5XzRfMl9IX18KPiAr
Cj4gK3ZvaWQgZ2Z4X3Y5XzRfMl9kZWJ1Z190cmFwX2NvbmZpZ19pbml0KHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LAo+ICsJCQkJdWludDMyX3QgZmlyc3Rfdm1pZCwgdWludDMyX3QgbGFzdF92
bWlkKTsKPiArCj4gKyNlbmRpZiAvKiBfX0dGWF9WOV80XzJfSF9fICovCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
