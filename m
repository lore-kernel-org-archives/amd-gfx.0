Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10F9C34031
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 21:46:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CBFF206E2
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 21:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bkRCEjXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CBFF206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A9E5891B5;
	Tue, 18 Feb 2020 21:46:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8134A6EA93
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 21:46:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeSk/8jN8D0onwYfWQhENR2YI+0DJIDhPpMnY55X/N9C+X3olWvwbVgk+75t9qvkwPpziHQWWUwgfnMQxx+BccAxd47nzK2o/qWPZgxyKl8yxrTiRtsupeicYpWhN1wOW40YkEYQecK1M6YsGuPSMmaBiBjJAQXfuZ1CfmjUOZOo3O1suVWb9vkIb+f5WWJc0PZfPJyFAWAUox4J4Pw/X0azSs+oQaCmI8tRaU+fHPYFD54LQp8FaN8s8CkBGf7SHmdG5rqZuvsZGP7rbAkSMAYEgKscLAN30BoX6Sls6zGRx3dTgCL85KpUz20Xf6VpzdgtKQcLmmjQIavnLo+maw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLRuEtPdbqUbkMmR/9gFcIO5zejhc5BW1GFwZshpoWI=;
 b=juqqSVKxQEchaz0EhOJ6JqZI1cT0iAkSjIIBedfaWmqcMeFQGNb7imw/JCcoIw96Kbcv2o+9Uke16K803UU2sw03woKsAepV3gayztMrWwA/7z5TIaiPWwz02WynmMHw8+jJTgssL0Bk+pNfsX5SG+AQGufPop1E5Z9zge5UiP8OlStJrgoz0bDz3Sq0jSy1TkFgof+4x2d34UT2bLBacKR1sw1M+CxJjzya0nqZ5yBJS4n/2jikhAD2eDtWlVKZmFYOdzhTEYheFyOePtzzx42X/vvrp8Im/1Y8RsGVBenIQJ1W2DPip0q/aj2YrO/DtlsPQ60cls39EKYBeA/Tdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLRuEtPdbqUbkMmR/9gFcIO5zejhc5BW1GFwZshpoWI=;
 b=bkRCEjXSPksQhm/YrhEuGduCX7Ajn6tm78PxQ1v/F0TH08RaeMggWUnY4jVbwajyElPXj0LPXw99e26qQooMXhMeX3EzjrV2hPKpjTOdCs4qax7r/FcAM38fhsP0Cfm4KIP1qn9LEGFGXzfBJDZx9RzhuZKd4PTcRpLVkh1DLps=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB4092.namprd12.prod.outlook.com (10.141.185.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Tue, 18 Feb 2020 21:46:23 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 21:46:23 +0000
Subject: Re: [PATCH] drm/amdgpu: Add a GEM_CREATE mask and bugfix
To: christian.koenig@amd.com, Alex Deucher <alexdeucher@gmail.com>
References: <20200215001714.605727-1-luben.tuikov@amd.com>
 <CADnq5_NQnRx-=zRru0zLcp61cLFhdL6xr7+PDcfh1oQCBTPpHQ@mail.gmail.com>
 <91d5bf04-6d71-4902-9ac9-f40f724abdc9@gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <46047362-745c-5a7f-0ba5-b36bb08f8d28@amd.com>
Date: Tue, 18 Feb 2020 16:46:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <91d5bf04-6d71-4902-9ac9-f40f724abdc9@gmail.com>
Content-Language: en-CA
X-ClientProxiedBy: YTOPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::49) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
Received: from localhost.localdomain (165.204.55.250) by
 YTOPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::49) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23 via Frontend
 Transport; Tue, 18 Feb 2020 21:46:22 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 206874ac-09f5-4b22-0d5d-08d7b4bbff21
X-MS-TrafficTypeDiagnostic: DM6PR12MB4092:|DM6PR12MB4092:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB40927A021AED29EA0C7C33E199110@DM6PR12MB4092.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(189003)(199004)(966005)(4326008)(31696002)(36756003)(44832011)(26005)(5660300002)(31686004)(478600001)(956004)(66574012)(66946007)(8936002)(52116002)(16526019)(186003)(6916009)(81166006)(81156014)(8676002)(45080400002)(2616005)(6486002)(86362001)(66476007)(66556008)(53546011)(6506007)(2906002)(6512007)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4092;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6bTWq2C5OhRP/WwqifP2erGbMi6EuE87vKAOzcE99clGv6O+LBhw/5tb+UA0rV2pebFv853ST5SRWwJECWe78x00y1Kq+ioInQpl/u2CF1hh1oOD9di155WMNcPFh/g4oKPeSJLPSiqyXX2c/ZP8OE8BLM9TyvA62pxJXFBnfbIXnHWdN/WFc7uKA1HypxqRSwWmx2O/jfyMijPkTOTEax4UpQmSuhKFeYgMML96xpCCp5muWQGqcYMoJfHsQm3r5MNrv1Fdns8NU0kayNqcVzeObJlgQ4DXHLUGA4RzhwnJA4vC0Fczruejr3u0CYtnrnQ2XulAI3cyZ9z0khrS0Zn4IiZK8FItWKqkb3pKlzbmLEcuz1KP15ks/FIJCG6Rz/wraM/oS9Js0v/cAll7WIQt4mfnyGdkezQDipDkt4vU/u9LUWtp6Wu1bKg07JWvWYzJLhRckvJfEL9jVo4O58lSobnfxN+wWCwKCjmgN3VrxhIKz13dNPxxXoYB3g8EobqFCvCYlZhp1G3osK7+LQ==
X-MS-Exchange-AntiSpam-MessageData: lIoS4jMr/C5/VK8IvpCl7ZeHXIQJD36uv0PZ6kwoZfjlb+aIk9x0VfuyyhzPy5pznDdOJnR/Mzr0idJx5GP3IRbVertHylMsZwdzgSL+vyt5yo7hioxrpkMYpDB1Rl0xv0FdzlZezuxNnHaLHnjR6g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 206874ac-09f5-4b22-0d5d-08d7b4bbff21
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 21:46:23.0053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1uSmqRIMlPGr1o0rAlxZQXFjnrvqr814ruFduJHldNhhJt1eOhthOckgI7jjaQDY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092
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

T24gMjAyMC0wMi0xNyAxMDowOCBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDE3
LjAyLjIwIHVtIDE1OjQ0IHNjaHJpZWIgQWxleCBEZXVjaGVyOgo+PiBPbiBGcmksIEZlYiAxNCwg
MjAyMCBhdCA3OjE3IFBNIEx1YmVuIFR1aWtvdiA8bHViZW4udHVpa292QGFtZC5jb20+IHdyb3Rl
Ogo+Pj4gQWRkIGEgQU1ER1BVX0dFTV9DUkVBVEVfTUFTSyBhbmQgdXNlIGl0IHRvIGNoZWNrCj4+
PiBmb3IgdmFsaWQvaW52YWxpZCBHRU0gY3JlYXRlIGZsYWdzIGNvbWluZyBpbiBmcm9tCj4+PiB1
c2Vyc3BhY2UuCj4+Pgo+Pj4gRml4IGEgYnVnIGluIGNoZWNraW5nIHdoZXRoZXIgVE1aIGlzIHN1
cHBvcnRlZCBhdAo+Pj4gR0VNIGNyZWF0ZSB0aW1lLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IEx1
YmVuIFR1aWtvdiA8bHViZW4udHVpa292QGFtZC5jb20+Cj4+PiAtLS0KPj4+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jIHwgMTEgKystLS0tLS0tLS0KPj4+ICAgaW5j
bHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmggICAgICAgICAgIHwgIDIgKysKPj4+ICAgMiBmaWxl
cyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwo+Pj4gaW5kZXggYjUxYTA2MGM2MzdkLi43
NGJiNzllNjRmYTMgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZ2VtLmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9n
ZW0uYwo+Pj4gQEAgLTIyMSwyMSArMjIxLDE0IEBAIGludCBhbWRncHVfZ2VtX2NyZWF0ZV9pb2N0
bChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB2b2lkICpkYXRhLAo+Pj4gICAgICAgICAgaW50IHI7
Cj4+Pgo+Pj4gICAgICAgICAgLyogcmVqZWN0IGludmFsaWQgZ2VtIGZsYWdzICovCj4+PiAtICAg
ICAgIGlmIChmbGFncyAmIH4oQU1ER1BVX0dFTV9DUkVBVEVfQ1BVX0FDQ0VTU19SRVFVSVJFRCB8
Cj4+PiAtICAgICAgICAgICAgICAgICAgICAgQU1ER1BVX0dFTV9DUkVBVEVfTk9fQ1BVX0FDQ0VT
UyB8Cj4+PiAtICAgICAgICAgICAgICAgICAgICAgQU1ER1BVX0dFTV9DUkVBVEVfQ1BVX0dUVF9V
U1dDIHwKPj4+IC0gICAgICAgICAgICAgICAgICAgICBBTURHUFVfR0VNX0NSRUFURV9WUkFNX0NM
RUFSRUQgfAo+Pj4gLSAgICAgICAgICAgICAgICAgICAgIEFNREdQVV9HRU1fQ1JFQVRFX1ZNX0FM
V0FZU19WQUxJRCB8Cj4+PiAtICAgICAgICAgICAgICAgICAgICAgQU1ER1BVX0dFTV9DUkVBVEVf
RVhQTElDSVRfU1lOQyB8Cj4+PiAtICAgICAgICAgICAgICAgICAgICAgQU1ER1BVX0dFTV9DUkVB
VEVfRU5DUllQVEVEKSkKPj4+IC0KPj4gSSdkIHJhdGhlciBrZWVwIHRoZSBsaXN0IGV4cGxpY2l0
IHNvIG5vIG9uZSBlbmRzIHVwIGZvcmdldHRpbmcgdG8KPj4gdXBkYXRlIHRoZSBtYXNrIHRoZSBu
ZXh0IHRpbWUgbmV3IGZsYWdzIGFyZSBhZGRlZC4KPiAKPiBBZGRpdGlvbmFsIHRvIHRoYXQgdGhp
cyBwYXRjaCBpcyBib2d1cy4KClNvIHRoZSBvbmx5ICJhZGRpdGlvbmFsIiB0aGluZyB5b3UncmUg
Y29udHJpYnV0aW5nIHRvIHRoZSByZXZpZXcgb2YKdGhpcyBwYXRjaCBpcyBjYWxsaW5nIGl0ICJi
b2d1cyIuIENoYXJhY3Rlcml6aW5nIHRoZSBwYXRjaCB3aXRoIGFuIGFkamVjdGl2ZQphcyAiYm9n
dXMiIGlzIHZlcnkgZGlzdHVyYmluZy4gV2hhdCdzIG5leHQ/Cgo+IAo+IFdlIGludGVudGlvbmFs
bHkgZmlsdGVyIG91dCB0aGUgZmxhZ3MgaGVyZSB3aGljaCB1c2Vyc3BhY2UgaXMgYWxsb3dlZCB0
byAKPiBzcGVjaWZ5IGluIHRoZSBHRU0gaW50ZXJmYWNlLCBidXQgYWZ0ZXIgdGhpcyBwYXRjaCB3
ZSB3b3VsZCBhbGxvdyBhbGwgCj4gZmxhZ3MgdG8gYmUgc3BlY2lmaWVkLgoKSSB0aG91Z2h0IHRo
YXQgdGhhdCBjb3VsZCBiZSB0aGUgY2FzZS4gQnV0IGluIHlvdXIgcmV2aWV3IHdoeSBub3QKcmVj
b21tZW5kIHdlIGhhdmUgYSBtYXNrIHRvIGNoZWNrIHVzZXItc2V0dGFibGUgZmxhZ3M/IFNvIHRo
ZQphY3R1YWwgZmxhZ3MgYXJlIGNvbGxlY3RlZCBhbmQgdmlzaWJsZSBpbiBvbmUgcGxhY2UgYW5k
IHdlbGwKdW5kZXJzdG9vZCB0aGF0IHRoYXQgaXMgd2hhdCBpcyBiZWluZyBjaGVja2VkIGFuZCB3
ZWxsLWRlZmluZWQKYnkgYSBtYWNybyB3aXRoIGFuIGFwcHJvcHJpYXRlIG5hbWU/CgpXaHkgZGlk
IE5PIE9ORSBjb21tZW50IG9uIHRoZSBidWcgZml4IGJlbG93PyBObyBvbmUuCgpSZWdhcmRzLApM
dWJlbgoKPiAKPiBDaHJpc3RpYW4uCj4gCj4gCj4gCj4+Cj4+IEFsZXgKPj4KPj4+ICsgICAgICAg
aWYgKGZsYWdzICYgfkFNREdQVV9HRU1fQ1JFQVRFX01BU0spCj4+PiAgICAgICAgICAgICAgICAg
IHJldHVybiAtRUlOVkFMOwo+Pj4KPj4+ICAgICAgICAgIC8qIHJlamVjdCBpbnZhbGlkIGdlbSBk
b21haW5zICovCj4+PiAgICAgICAgICBpZiAoYXJncy0+aW4uZG9tYWlucyAmIH5BTURHUFVfR0VN
X0RPTUFJTl9NQVNLKQo+Pj4gICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPj4+Cj4+
PiAtICAgICAgIGlmIChhbWRncHVfaXNfdG16KGFkZXYpICYmIChmbGFncyAmIEFNREdQVV9HRU1f
Q1JFQVRFX0VOQ1JZUFRFRCkpIHsKPj4+ICsgICAgICAgaWYgKCFhbWRncHVfaXNfdG16KGFkZXYp
ICYmIGZsYWdzICYgQU1ER1BVX0dFTV9DUkVBVEVfRU5DUllQVEVEKSB7Cj4+PiAgICAgICAgICAg
ICAgICAgIERSTV9FUlJPUigiQ2Fubm90IGFsbG9jYXRlIHNlY3VyZSBidWZmZXIgc2luY2UgVE1a
IGlzIGRpc2FibGVkXG4iKTsKPj4+ICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4+
PiAgICAgICAgICB9Cj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJt
LmggYi9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaAo+Pj4gaW5kZXggZWFmOTRhNDIxOTAx
Li5jODQ2M2NkZjQ0NDggMTAwNjQ0Cj4+PiAtLS0gYS9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9k
cm0uaAo+Pj4gKysrIGIvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgKPj4+IEBAIC0xNDEs
NiArMTQxLDggQEAgZXh0ZXJuICJDIiB7Cj4+PiAgICAqLwo+Pj4gICAjZGVmaW5lIEFNREdQVV9H
RU1fQ1JFQVRFX0VOQ1JZUFRFRCAgICAgICAgICAgICgxIDw8IDEwKQo+Pj4KPj4+ICsjZGVmaW5l
IEFNREdQVV9HRU1fQ1JFQVRFX01BU0sgICAgICAgICAgICAgICAgICAoKDEgPDwgMTEpLTEpCj4+
PiArCj4+PiAgIHN0cnVjdCBkcm1fYW1kZ3B1X2dlbV9jcmVhdGVfaW4gIHsKPj4+ICAgICAgICAg
IC8qKiB0aGUgcmVxdWVzdGVkIG1lbW9yeSBzaXplICovCj4+PiAgICAgICAgICBfX3U2NCBib19z
aXplOwo+Pj4gLS0KPj4+IDIuMjUuMC4yMzIuZ2Q4NDM3YzU3ZmEKPj4+Cj4+PiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4gYW1kLWdmeCBtYWlsaW5n
IGxpc3QKPj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+PiBodHRwczovL25hbTEx
LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0
cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRh
PTAyJTdDMDElN0NsdWJlbi50dWlrb3YlNDBhbWQuY29tJTdDYjFmZGMzOTcwYTIyNGZjNjFmZGMw
OGQ3YjNiYjQ2MTMlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdD
NjM3MTc1NDg5MjQwMDc3MjUwJmFtcDtzZGF0YT1yRThBNmpLQUlYMDgxWmh4eGNNYyUyQnBHZFh2
c0xVZHJBVzRBa0xzVHBOeGclM0QmYW1wO3Jlc2VydmVkPTAKPj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4g
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3Mu
cHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0
b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdD
bHViZW4udHVpa292JTQwYW1kLmNvbSU3Q2IxZmRjMzk3MGEyMjRmYzYxZmRjMDhkN2IzYmI0NjEz
JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzE3NTQ4OTI0
MDA3NzI1MCZhbXA7c2RhdGE9ckU4QTZqS0FJWDA4MVpoeHhjTWMlMkJwR2RYdnNMVWRyQVc0QWtM
c1RwTnhnJTNEJmFtcDtyZXNlcnZlZD0wCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
