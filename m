Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70972C4363D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 17:36:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81B742086A
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 17:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="m+calMI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B742086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D12E16E057;
	Fri, 25 Sep 2020 17:36:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCEC86E055
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 17:36:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i08wSMlBv+wsDIggcLLD2myT7YZ+OCOwy6zM39tmYNKRf1tVgkDKxcGTNeGu/fJWTXT1ZvO+ahAB0wgZHRLSzCmvxBgcTQ+SIfksxTsGiGbqUZk0yXMBIsOzAMDWUGgnvjKjyMrBMrNw7+ukoJSx5DqZTDW4/glyzxwHucOY7bTZWxpk40zvrc/i5rTQ7/qCksVA0CA2oSXREqjhpYO9VGIyzN5xW2xdOeI23dIcmiHRxYPfKDVgeEu4Y4i11weOrnKS32yGOgW60p7nQq7h+88yj/jY6fzEhZHDygjYXbHmyU50C7mmKbjfczOc+WED++a6S5gAuRwXgHNyr5momA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DK23OnXr37yP53BArFwNXVbEKCrT/DVXV6+Lsof3Nto=;
 b=SeyO/8m0ZTXqhrXx4u+Z8TS2THXtMzqQJ2MJqxcASaXmtdOAcReR0ZRgvDpJ4vDDUxWTdgtNAfht2OA7++2wiSEW2/ySWGdwOx1binPt+TkfQucbLQRSWgO8EbWxXG3BMLJLRPSBT5bbek29fvCcBUFTHgiKr1IHdZ/pAxRsZ5BaJaNMzbUPdPWcT+eNTd79LMKMZxeReskGvpU9mpMqEmOVPFH6BUumirsqls4kVUe8CTAZXu+/snc4ybSjd1XSmdtNQ6gZP4KLEY9KL+/kwIQ3U2uZA59cukJ4JNW/AwtAUmCF/kgNDWuFLgOyO5W23x1fS3VrzRoaPoUtm92dvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DK23OnXr37yP53BArFwNXVbEKCrT/DVXV6+Lsof3Nto=;
 b=m+calMI0nrKRJPF8NWzTXAOdBXpzM9UoWOCnWNdvRsO/GK6tKXONfiMLU1ljPvICDyHUV77bG9vCQgple++6AcKZEbub54AEY9rpNj/2XbSPeY1SIeocg8haO3K3Ptpvtg2VgWG590QRx86G6NaUE5cypsj+jNvXCBo8OG79KCY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2795.namprd12.prod.outlook.com (2603:10b6:5:41::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.22; Fri, 25 Sep
 2020 17:36:03 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933%3]) with mapi id 15.20.3412.025; Fri, 25 Sep 2020
 17:36:02 +0000
Subject: Re: [PATCH] drm/amdgpu: fix a warning in amdgpu_ras.c
To: Nirmoy <nirmodas@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200925143127.1588029-1-alexander.deucher@amd.com>
 <41d3580f-9267-308b-dcff-e2b828812348@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <990614f9-3a57-0a25-f672-5ffcf9e26989@amd.com>
Date: Fri, 25 Sep 2020 13:36:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <41d3580f-9267-308b-dcff-e2b828812348@amd.com>
Content-Language: en-CA
X-Originating-IP: [108.162.131.176]
X-ClientProxiedBy: YT1PR01CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::11) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.6] (108.162.131.176) by
 YT1PR01CA0042.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Fri, 25 Sep 2020 17:36:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8845e986-6e45-4fd8-00d5-08d861797923
X-MS-TrafficTypeDiagnostic: DM6PR12MB2795:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB27957307321CCC66B588220C99360@DM6PR12MB2795.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c3OTndOx+r1sNa2c1NlAZpa6NtsV6nPdFznpG7bVvUAsytnyzoI7iHTGN8zx61sf2sPMst+mrKnXrTOlL6At2Oedf6+wk8lxrAbbEeWIiRu9MXtEWl6qkf01RnLPjZuUXgnMEmnJ8UJJlFwI/I8DS5A5F5pxvvwGfRN1yUu54ARndM1/LRe/a8jKkxqD1kBPh4Unwi5gTAs7ho24rZklDYJtT0hEmFNyZZo1wxG9B7SajgumK9skXwCsA2waCCY6/YP9ZEwCAZcxpYI3If3caTVzEm5YQwoqRFWZHnBAp2HmOZ6460LfSNvATDl6NLcgEbjmNZjTJq8KWtrxGLO8pmCi0hsY4WwN/Y3CcUDo8aw+PVsCnJFyhIwpMzIyzKgRARwVjf9f2sJTZ4EeRjOoyd6WvWaaNLW5NbFVgsQfg5U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(31686004)(2616005)(2906002)(6486002)(45080400002)(83380400001)(36756003)(478600001)(956004)(186003)(31696002)(26005)(55236004)(53546011)(966005)(16526019)(66556008)(8936002)(316002)(66476007)(66946007)(4326008)(16576012)(110136005)(86362001)(44832011)(5660300002)(8676002)(52116002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: enLGwpqlNATTUf5vXDKWrHeTFMWi/Mzv3z8Gk3hrMGrcpyY7ERWdTQ5nokw+FQX1s1L+9zO1sKFKuYiHZFhpc36xzQavtataBg8BaTNvHh2w/ViuGNSNJlheZzZPYRVI/8thwjOMY/dnK2aqJwo0V0xoq7E1CJ/Lcg7+Kr7R/Wc7fRL0xQIwH1iU1hUdZxHr+AeW8Fl19MJMCKi7LPLVcG7fLCRO3pVyNcvRfS8UiJm9RRCPkufn6sHJqt6AmXJGy3yfZbXc0OYBax2mUgAPyPXM0r1S98n6B8tfo39ZWLFpdP+qFvcKplwWyLKdHOJm8egAAxK36R2j/3ghn3eJzu5d9eGAmu2H9fGp1psfRHEfKDrfgTyF419x2UM1DyB3vJcBGjJkTH85qW7x/9s7lNLRTwY28pmFVY89Td8swtitCQ6BvB0WNccNO3b60N3aw0tiu3qpq5aijxdEYCUUpvtpQwbIaBKFnXrHorSOwf5olTmCHztu+t1Z3koo+bsAkQd1UZo9cF3cVxayQzK40GhmvbtOt+Pd5OhPEjxNkXgZ8uJc/hFDjVmE1bYSPzY444zmFtXFhVdoUBlltB0L/ecGt+L55tagnrZ2nmhGPJ6Od4GMCMtem8YO07rA+Tw3BvKP9aQ9/nb3iy7tJ6mDkQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8845e986-6e45-4fd8-00d5-08d861797923
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 17:36:02.7697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPfUudFe8cPdOOKyDiPuOjgbrpkCeDPENd+oKjyQjwVydh0ipZ1t1LBzlANlXwIv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2795
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

T24gMjAyMC0wOS0yNSAxMTowMCwgTmlybW95IHdyb3RlOgo+IEFja2VkLWJ5OiBOaXJtb3kgRGFz
IDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4gCj4gT24gOS8yNS8yMCA0OjMxIFBNLCBBbGV4IERldWNo
ZXIgd3JvdGU6Cj4+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYzogSW4g
ZnVuY3Rpb24g4oCYYW1kZ3B1X3Jhc19mc19pbml04oCZOgo+PiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcmFzLmM6MTI4NDoyOiB3YXJuaW5nOiBpZ25vcmluZyByZXR1cm4gdmFs
dWUgb2Yg4oCYc3lzZnNfY3JlYXRlX2dyb3Vw4oCZLCBkZWNsYXJlZCB3aXRoIGF0dHJpYnV0ZSB3
YXJuX3VudXNlZF9yZXN1bHQgWy1XdW51c2VkLXJlc3VsdF0KPj4gICAxMjg0IHwgIHN5c2ZzX2Ny
ZWF0ZV9ncm91cCgmYWRldi0+ZGV2LT5rb2JqLCAmZ3JvdXApOwo+PiAgICAgICAgfCAgXn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KPj4KPj4gU2lnbmVkLW9mZi1i
eTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+PiAtLS0KPj4KPj4g
RG8gd2UgY2FyZSB3aGV0aGVyIHRoaXMgZmFpbHMgb3Igbm90Pwo+IAo+IAo+IEkgdGhpbmsgd2Ug
c2hvdWxkLiBGYWlsdXJlIGluIHN5c2ZzX2NyZWF0ZV9ncm91cCgpIG1lYW5zIG1lbW9yeSBzdGFy
dmVkCj4gCj4gc3lzdGVtIG9yIHdlIGFyZSBkb2luZyBzb21ldGhpbmcgaW4gdGhlIGRyaXZlciBj
b2RlLgo+IAo+IElNTyBpbiBib3RoIGNhc2VzLCB3ZSBzaG91bGQgZXJyb3Igb3V0LgoKSSBkaXNh
Z3JlZS4gV2Ugc2hvdWxkIHRyeSB0byBicmluZyB1cCBhIGRpc3BsYXkgYXMgbXVjaCBhcyBwb3Nz
aWJsZS4Kc3lzZnMgZmFpbGluZyBzaG91bGRuJ3QgbmVjZXNzYXJpbHkgYnJpbmcgZG93biB0aGUg
c3lzdGVtLgpUaGUgc3lzdGVtIHNob3VsZCBiZSBhcyByZXNpbGllbnQgYXMgcG9zc2libGUgYW5k
IHRyeSB0byBzdXJ2aXZlCmFzIG11Y2ggYXMgcG9zc2libGUuCgpJZiBpbmRlZWQgd2UgaGFkIGhh
ZCBhIG1lbW9yeSBzdGFydmF0aW9uLCBvdGhlciB0aGluZ3Mgd291bGQgZmFpbCwKYmVmb3JlIG9y
IGFmdGVyIHRoaXMgc2VxdWVuY2UuIEFuZCBpZiB0aG9zZSB0aGluZ3MgYXJlIHRlcm1pbmFsLAp3
aGljaCBzeXNmcyBpcyBub3QsIHRoZW4gbGV0IHRob3NlIG90aGVyIGVycm9ycywgc3VjaCBhcyBu
byBtZW1vcnkKZm9yIEJPcywgYnJpbmcgdGhlIGRpc3BsYXkgYnJpbmctdXAgZG93bi4KClJlZ2Fy
ZHMsCkx1YmVuCgoKPiAKPiAKPiBOaXJtb3kKPiAKPj4KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcmFzLmMgfCA0ICstLS0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDMgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcmFzLmMKPj4gaW5kZXggNDlkMTAzMzBiZjY0Li42NzcyNDA0OWEwZmMgMTAwNjQ0Cj4+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwo+PiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKPj4gQEAgLTEyODEsOSArMTI4
MSw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Jhc19mc19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KQo+PiAgIAkJc3lzZnNfYmluX2F0dHJfaW5pdChiaW5fYXR0cnNbMF0pOwo+PiAgIAl9
Cj4+ICAgCj4+IC0Jc3lzZnNfY3JlYXRlX2dyb3VwKCZhZGV2LT5kZXYtPmtvYmosICZncm91cCk7
Cj4+IC0KPj4gLQlyZXR1cm4gMDsKPj4gKwlyZXR1cm4gc3lzZnNfY3JlYXRlX2dyb3VwKCZhZGV2
LT5kZXYtPmtvYmosICZncm91cCk7Cj4+ICAgfQo+PiAgIAo+PiAgIHN0YXRpYyBpbnQgYW1kZ3B1
X3Jhc19mc19maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QK
PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtz
LnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNr
dG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3
Q2x1YmVuLnR1aWtvdiU0MGFtZC5jb20lN0NkM2EyOWViMzIyM2I0YjU4ZmY2YjA4ZDg2MTYzYzhh
OSU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzczNjY0Mjg1
NjAyNDU3MTImYW1wO3NkYXRhPWJZV2prMms4SWVFb2xHMndjSkxBN0olMkJ4MmQlMkZPU1hOSU9w
TE9iayUyRjNqU1ElM0QmYW1wO3Jlc2VydmVkPTAKPiAKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
