Return-Path: <SRS0=MTnY=7D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D23C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 17:06:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDCCC20759
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 17:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nM5MVm5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDCCC20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BC526E950;
	Thu, 21 May 2020 17:06:19 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680049.outbound.protection.outlook.com [40.107.68.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A0626E951
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 17:06:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIHrwJdKhWvOlBj5h8N8wcy3D4QCiR7y6eKTjxKTwFffDYJ8OEEv0gHZfpECfB1DXUakZRldvfeQLMNGf6d991rPljx8xGLHpKFsh1qi51o6xF2M/LCm8z63h4ba6jP47ON/xLVQkUsqVRkbWdaYVoygYeyqDcuMKyoD6nO5bZCkgAD19ySqYod0ucaF2wdd8+VVw10KrHuXt8i6Jele4/6u9S1wiQmG+C1ejLo8ztW8eihv7/395R26YQGAfdFP62Z5I9jBQ304BbWCEeez2uHYNsOtGrJmhVbd1iU91W64GaPJSK59iJu8wlcIz/u7Y9eN6KPozBNro4cdo1tQHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQPXLFo6rVv6w0C5If8/lHCR6mpLTDiROnmPfoQsqGA=;
 b=GH7zBIUuimEquAJEGv2s+vNB5a9oML/TmCLJF7isbabWR3p/qJSsYil4Q3gSZBi1YkMtVuhgZaSnW//tvB8ELeCIKojYLyfBeQuwxiMQCOQqGFgz6asiIgfmGmH7QBOkKOxsuku8zOvvKbqQuNZFYlXJqPQVisTpiY7tTowQDlz7fzhQTmljDj8b7bzqP54A2/qGhD+/ogm6iqc3shPJr0vHWDqXx2nxzkaD3lGqKxgM3TbxsYlPKLNnh7mHsWVvY6BFqYp2abQjFKRf0x+qTlq+W+vfdEbosyq3PK2evlt50flYp1cwBXuRoB35ws9BzqV2AlnNDPQYnL8oBvKizg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQPXLFo6rVv6w0C5If8/lHCR6mpLTDiROnmPfoQsqGA=;
 b=nM5MVm5wue1AhAQUduTN0r29Y7Sx25+Y6KluUZmuf1F42LypsmQjH/BZNBpnPsJDIRSyNpL/ANnlzJpO6FjlzbJ2WqSsY9H5KGlqeIUk+HhYYczzc+noewPln6OSgzW9k5NpiwW8FEtDUIw76woZgNtSdrOTVaVoL0mo+PP9eEc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2543.namprd12.prod.outlook.com (2603:10b6:802:2a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.31; Thu, 21 May
 2020 17:06:16 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 17:06:16 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: Sync with VM root BO when switching VM to
 CPU update mode
To: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
References: <20200520225159.977-1-Felix.Kuehling@amd.com>
 <14ac63e1-a212-7540-fe65-523451bf6a89@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <2cd1235f-9d2c-7f48-66ea-90e361d5178b@amd.com>
Date: Thu, 21 May 2020 13:06:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <14ac63e1-a212-7540-fe65-523451bf6a89@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::40) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YTOPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend
 Transport; Thu, 21 May 2020 17:06:15 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a151121d-80ad-42a2-7b2a-08d7fda945ae
X-MS-TrafficTypeDiagnostic: SN1PR12MB2543:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25433DD6BF563AB8352A6D4B92B70@SN1PR12MB2543.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eTIgQkgEUivueK94QO4O85yGFbRUTixXp0/jv4hgHoYoqHtne+qPVhWg9JAc/HPaEh3XUBF2YrT4+jpUQ3C0LNyiv6f+RKaX8cKZ9AxEkKXVnQKv6Z6JDSxgXcfZMtSBMgPjBTWq2GlCrV0P1WEzPIAYGEZ951uGVFhYdZ2VsY6xjpras5kXyEYscfFwJ4k6TSUoHZLFiVkKPqHq70YkOQc409Ma9STz9H5SHmTK/GCy6ebF7xnH3t7uNqLGyqDHPMNbdPmGIdnsr//q8UYjCB4zM7Etyx2Fl5aQOcDHlZOiunD2ASQOLOglseE2avq8NIKlYWFHpxStgCvV3zH5VZXr/XdfhmO6ZibXKEJ0zqF4u3ajJXxBpmUSv9l1a7auG2nWtqUAP62y2Qhi9vCDlo5J0YiQ1UyxjuQdeNHIDXdANHcmduV7FLwWdXH0vdmYCi+l+7/8bMZs/Q8slZARYtubcl6lDovcHsTMVqfJN2UiWfTeG/nSMVKg5kqyD3bA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(66556008)(16526019)(4326008)(316002)(66476007)(31696002)(16576012)(44832011)(15650500001)(2906002)(31686004)(6486002)(2616005)(66946007)(956004)(86362001)(5660300002)(36756003)(66574014)(186003)(8676002)(478600001)(26005)(8936002)(52116002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: MfmMRGkEhamXbBiQIHt08L+st8sk0VpRHBEz7yTWhDLeg6CKrgZB797NpKpmMv1hKkcT6wrbIP5deEzBgSzTjaJrMqg8emRqTqoSeg3WPUcsYlosxfdXFKH1ZBS2p2kACH29+yocY6nQTjdZmeLV9eF/8fqx3XEhbViD5RRqW9JcgcWUdOOfuJuVGw7+CfuuD80TNG9T8ULAMQ9NJqFOtP61w/+KEHWi7aISgNsDTnQQDNdKVp9PuuQ+ak78UE59qu5nnEe0FyCY5JkhXB3PV9zraM7j1MvODEbmSvoRcUmXCinolhZ1d50Df1n2As92YHz8KWUs18ubaNzeIEDxwh1Z/AV50z0yY1FFVZ4YudMvENpVn3wqQu8ceXPxuyLsT0CK+phjVZiP1HYHWH4JYNWMlQwWG7B1WoUjXMFRpAH20AhzGOFuIgTnWJ4OkGQ5AECmJK+DASwlhgO9HvE0VR1u7NfqnOMvHCnkcZdbO3zemcy9UAoDfMrXZIg764pm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a151121d-80ad-42a2-7b2a-08d7fda945ae
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 17:06:16.2404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2P+mAN6BWaIxvyF6W7ef4jhRil1G3Kcm+2BQ+Y4zmSq71nFPD2cPj7R5mc5gPOk4sHMOPn1ZchANiO0IyeDlGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2543
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
Cc: jay.cornwall@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CkFtIDIwMjAtMDUtMjEgdW0gOTo1MCBhLm0uIHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPiBB
bSAyMS4wNS4yMCB1bSAwMDo1MSBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+PiBUaGlzIGZpeGVz
IGFuIGludGVybWl0dGVudCBidWcgd2hlcmUgYSByb290IFBEIGNsZWFyIG9wZXJhdGlvbiBzdGls
bCBpbgo+PiBwcm9ncmVzcyBjb3VsZCBvdmVyd3JpdGUgYSBQREUgdXBkYXRlIGRvbmUgYnkgdGhl
IENQVSwgcmVzdWx0aW5nIGluIGEKPj4gVk0gZmF1bHQuCj4KPiBNaG0sIG1heWJlIGJldHRlciBh
ZGQgdGhpcyB0byBhbWRncHVfdm1fY3B1X3ByZXBhcmUoKS4KPgo+IFRoaXMgd2F5IHdlIGNvdWxk
IChpbiB0aGVvcnkpIHN3aXRjaCBiZXR3ZWVuIENQVSBhbmQgU0RNQSBiYXNlZAo+IHVwZGF0ZXMg
b24gdGhlIGZseSBlbHNld2hlcmUgYXMgd2VsbC4KClRoYXQgd29uJ3Qgd29yay4gSSB3YW50IHRv
IHdhaXQgZm9yIEZFTkNFX09XTkVSX1ZNIGZlbmNlcywgc28gSSBuZWVkIHRvCnVzZSBGRU5DRV9P
V05FUl9VTkRFRklORUQuIEJ1dCB0aGVuIEkgd291bGQgYWxzbyBlbmQgdXAgd2FpdGluZyBmb3IK
RkVOQ0VfT1dORVJfS0ZEIGV2aWN0aW9uIGZlbmNlcywgd2hpY2ggd291bGQgdHJpZ2dlciB1bndh
bnRlZCBldmljdGlvbnMuCgpUaGlzIHdvcmtzIE9LIGluIGFtZGdwdV92bV9tYWtlX2NvbXB1dGUg
YmVjYXVzZSBpdCBydW5zIGJlZm9yZSB0aGUKZXZpY3Rpb24gZmVuY2UgaXMgYXR0YWNoZWQgdG8g
dGhlIFZNLgoKUmVnYXJkcywKwqAgRmVsaXgKCgo+Cj4gQ2hyaXN0aWFuLgo+Cj4+Cj4+IEZpeGVz
OiAxMDhiNGQ5MjhjMDMgKCJkcm0vYW1kL2FtZGdwdTogVXBkYXRlIFZNIGZ1bmN0aW9uIHBvaW50
ZXIiKQo+PiBSZXBvcnRlZC1ieTogSmF5IENvcm53YWxsIDxKYXkuQ29ybndhbGxAYW1kLmNvbT4K
Pj4gVGVzdGVkLWJ5OiBKYXkgQ29ybndhbGwgPEpheS5Db3Jud2FsbEBhbWQuY29tPgo+PiBTaWdu
ZWQtb2ZmLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KPj4gLS0t
Cj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMTEgKysrKysr
KysrLS0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5jCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4gaW5kZXgg
NDE0YTBiMWMyZTVhLi43NDE3NzU0ZTkxNDEgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jCj4+IEBAIC0zMDAwLDEwICszMDAwLDE3IEBAIGludCBhbWRncHVfdm1f
bWFrZV9jb21wdXRlKHN0cnVjdAo+PiBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1
X3ZtICp2bSwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICFhbWRncHVfZ21jX3ZyYW1fZnVs
bF92aXNpYmxlKCZhZGV2LT5nbWMpKSwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiQ1BVIHVw
ZGF0ZSBvZiBWTSByZWNvbW1lbmRlZCBvbmx5IGZvciBsYXJnZSBCQVIgc3lzdGVtXG4iKTsKPj4g
wqAgLcKgwqDCoCBpZiAodm0tPnVzZV9jcHVfZm9yX3VwZGF0ZSkKPj4gK8KgwqDCoCBpZiAodm0t
PnVzZV9jcHVfZm9yX3VwZGF0ZSkgewo+PiArwqDCoMKgwqDCoMKgwqAgLyogU3luYyB3aXRoIGxh
c3QgU0RNQSB1cGRhdGUvY2xlYXIgYmVmb3JlIHN3aXRjaGluZyB0byBDUFUgKi8KPj4gK8KgwqDC
oMKgwqDCoMKgIHIgPSBhbWRncHVfYm9fc3luY193YWl0KHZtLT5yb290LmJhc2UuYm8sCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBBTURHUFVfRkVOQ0VfT1dORVJf
VU5ERUZJTkVELCB0cnVlKTsKPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChyKQo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBnb3RvIGZyZWVfaWRyOwo+PiArCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB2
bS0+dXBkYXRlX2Z1bmNzID0gJmFtZGdwdV92bV9jcHVfZnVuY3M7Cj4+IC3CoMKgwqAgZWxzZQo+
PiArwqDCoMKgIH0gZWxzZSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB2bS0+dXBkYXRlX2Z1bmNz
ID0gJmFtZGdwdV92bV9zZG1hX2Z1bmNzOwo+PiArwqDCoMKgIH0KPj4gwqDCoMKgwqDCoCBkbWFf
ZmVuY2VfcHV0KHZtLT5sYXN0X3VwZGF0ZSk7Cj4+IMKgwqDCoMKgwqAgdm0tPmxhc3RfdXBkYXRl
ID0gTlVMTDsKPj4gwqDCoMKgwqDCoCB2bS0+aXNfY29tcHV0ZV9jb250ZXh0ID0gdHJ1ZTsKPgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
