Return-Path: <SRS0=Inwe=AH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E69C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 06:57:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE909207E8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 06:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qwqXO8dO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE909207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47C1E6E05F;
	Fri, 26 Jun 2020 06:57:53 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770075.outbound.protection.outlook.com [40.107.77.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0343B6E05F
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2020 06:57:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2ROYn2uDitX8Vn5XP/RWLjlaaZ7CV79jDPlI6Y8xqOliRLi4VdtsUUco0IQRnDJzsZ/zsJqnrlPB41+i7XJNEOhcsY3K+UhRUDcS/yMF8WhtKwavaAuoprQMEsSJXjfo4ItztHKwHdXpOvMYaddyS/9CIV/m701s0IG63xkUWE/fU5CF7+isdaS3vCUlm2qlHmWRHiQ69W4voEu3StxZcf0DBNFct67Iz78oh7Ge2y8PDCZftZ+fFOfR+h7GncaTVTubKFaeZ5eIJN+EfmvThqnSEyFAXVV/EOljWsOhrVdrv/MzLXrDOJoCLaGK/spOPcVIwX1kgejbTi4mG5vxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exK9ytDNLA3f+ZGHtfnVn9E5PV4ekHZmxBwNVn4s5B0=;
 b=j6gZT4ZXc5OyIIZ1DqMa7qx6DX+bc1CqfUBXPP92N57SJXlKjVYIII71H4eBMlwoLJC89q5sNKmXJUeZ3t4JXeNIWh75DDjQwd6zMX+6J+CxIRD3AEC52klN7oju6YoOsHpLussDncSVDctp4Rky6QivAgpf46wLG4N/1FmzOPx2aXRznvuHssGb33YLRqI06sGWLEe5nuNFSIrBA2f5JJUs+6vaq1g/ZDTub/z07kxt9Pko9uVnXgTrRswd+KSYggDK2niraFl21SnUY38yfhI87EWtXRRyxV99VzJwKH8742JPeCidBiVwHdvopM5fD1S396N+cVK+069nMeQriA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exK9ytDNLA3f+ZGHtfnVn9E5PV4ekHZmxBwNVn4s5B0=;
 b=qwqXO8dO66Q1+88DILQgB4jD1C9uUM9xUeePXG5G0V2P2gs421ndFD7aPYkF3wUc/0HZ4DspVJ6rQThqZrWc3hmdbr4eBO3K5C9NfQJG1qDO74CT+fuwOVXpdcCUCSqZL1nTWAcxyJDPT9gWwHfYuhVF3k71cuFnCc+kh6gmwVQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3786.namprd12.prod.outlook.com (2603:10b6:5:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Fri, 26 Jun
 2020 06:57:49 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::a045:f8c0:8edb:1ef1]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::a045:f8c0:8edb:1ef1%9]) with mapi id 15.20.3131.025; Fri, 26 Jun 2020
 06:57:49 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: Let KFD use more VMIDs on Arcturus
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200625031834.16122-1-Felix.Kuehling@amd.com>
 <20200625031834.16122-2-Felix.Kuehling@amd.com>
 <48a11576-b734-7525-dc39-c4aef67d5d35@gmail.com>
 <77c53962-fd2e-7004-76ab-aae4580a49b9@amd.com>
 <841359ec-a1cd-7722-55e6-182b6e2b6578@amd.com>
 <e3261861-cec0-09da-3632-be8e25a22844@amd.com>
 <abdd1def-1407-65f0-33b8-981efd5c6817@amd.com>
 <1960cd33-03f1-f79a-7dd1-320577ae4121@amd.com>
 <4c2d9e27-864c-0086-6167-97fe1483b183@amd.com>
 <bcca1d9b-a260-347e-be7c-b57ab4b0a700@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <927d4503-536d-53e9-0a13-9a01b6ab2f0a@amd.com>
Date: Fri, 26 Jun 2020 08:57:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <bcca1d9b-a260-347e-be7c-b57ab4b0a700@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::20) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FR2P281CA0033.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21 via Frontend Transport; Fri, 26 Jun 2020 06:57:47 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b5faf209-2001-4517-6370-08d8199e3ca8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3786:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB378647112D4D3AA97128DF7A83930@DM6PR12MB3786.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tTLpcLpLwXhBQaN8CfMQP88XZamOi3sY4SbPLG+0zPCc/IJoZH1KE+guCFTuuvbloQ/Va+U991NT9RgbDT6jjciwEJ61kH6eFZuBRsu1pT5mC8LGQVY7S13fdtOOZ/lQxt2+F6Jef5DltfEg838cUEV+OTjLAiREfQDphyIS3n/1u1cy2IOqhWXF+B3HixJmQLNWs7Qs7evzKBRQpa07eK64I6G36uWzr+xK+JOi7d3xhs7zQ1OeX8YlaZbbWfyOZdRXUfLuab75/y68jR6JotDxkUQSD7Ln8axTV0HK5EFMOUy6uEW1UshaMnsywPFMkbY0uZjsMvvQXtTzb975DU5G/xo+QgUpl5aWHh/oXBZHJzlo0llFkrLJLOTfhbju
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(478600001)(66556008)(186003)(66476007)(31696002)(6666004)(52116002)(31686004)(16526019)(66946007)(86362001)(8676002)(5660300002)(83380400001)(36756003)(6486002)(2906002)(53546011)(8936002)(2616005)(316002)(66574015)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: eLUUk+8zOPgHhSWfcQnmHH8I88sEn6fnIhlFFR6nhwABoZTuxbOV6+D2SzphDYgATphdz39D+vQi6Bg7i3cp22WeTQlEDV0I4n7UxJnVdQymud8DxAniQcfcGyRAUWXbqkF1TeIto8lKTxL6uNT2KuoW0o6O2+a9m2mPZiCxhl/A1NrtstqDqXprTG50dBOHu55DsgRZTcyVPv7rDmWJP1K3KRvCcLVvBdAaGaaFQ508nuG8gjlMhptJmgxcQUkh0L4OvZtg+h98JleXFq6wqMWVkKjql/EOdLkU5d8pIxr7py7wKJMuXgFVZYtzquv3sOU6gXnAmFfdhaDB9Hjx7eHZPwL4JIkf9k38gTB4TfjwiLM7jU9rNNo82IXkv1QVY2SDOWswMcfG9yBLaAZFoZRteA/9ZFWnSnh23hXlE88VA7oIgdEDtVzPTmw12oQ5tH+vskjY/QYzTsGFUHerkiG1UUZFta4ExpROl6r3wXNRTWQjkZFqIAuAAR1dqQa476ARC/d99gxy+ExwZfYkOib2sgRMHHwdAfynAMrR8cNkM0Qt3zOTNDZp5hlGW3I8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5faf209-2001-4517-6370-08d8199e3ca8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 06:57:49.4105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFz4J/yhayJH3hw1vx9aNqBMdH+WcVvlMwpverLm1PGrCBa2R0/DufdHUbQWJVeY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3786
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjUuMDYuMjAgdW0gMjI6Mzkgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPgo+IE9uIDIwMjAt
MDYtMjUgMTI6MDEgcC5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMjUuMDYuMjAg
dW0gMTc6NTggc2NocmllYiBGZWxpeCBLdWVobGluZzoKPj4+IEFtIDIwMjAtMDYtMjUgdW0gMTE6
NTAgYS5tLiBzY2hyaWViIENocmlzdGlhbiBLw7ZuaWc6Cj4+Pj4gQW0gMjUuMDYuMjAgdW0gMTc6
NDMgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPj4+Pj4gQW0gMjAyMC0wNi0yNSB1bSAxMTozOCBh
Lm0uIHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPj4+Pj4+IEFtIDI1LjA2LjIwIHVtIDE3OjE1
IHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4+Pj4+Pj4gQW0gMjAyMC0wNi0yNSB1bSA0OjE5IGEu
bS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+Pj4+Pj4+PiBBbSAyNS4wNi4yMCB1bSAwNTox
OCBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+Pj4+Pj4+Pj4gV2hlbiB0aGVyZSBpcyBubyBncmFw
aGljcyBzdXBwb3J0LCBLRkQgY2FuIHVzZSBtb3JlIG9mIHRoZSBWTUlEcy4KPj4+Pj4+Pj4+IEdy
YXBoaWNzCj4+Pj4+Pj4+PiBWTUlEcyBhcmUgb25seSB1c2VkIGZvciB2aWRlbyBkZWNvZGluZy9l
bmNvZGluZyBhbmQgcG9zdCAKPj4+Pj4+Pj4+IHByb2Nlc3NpbmcuCj4+Pj4+Pj4+PiBXaXRoCj4+
Pj4+Pj4+PiB0d28gVkNFIGVuZ2luZXMsIHRoZXJlIGlzIG5vIHJlYXNvbiB0byByZXNlcnZlIG1v
cmUgdGhhbiAyIAo+Pj4+Pj4+Pj4gVk1JRHMgZm9yCj4+Pj4+Pj4+PiB0aGF0Lgo+Pj4+Pj4+PiBJ
SVJDIHRoZSBleHBlY3RhdGlvbiBpcyB0aGF0IHdlIHN0aWxsIHVzZSB0aGUgY29tcHV0ZSBxdWV1
ZXMgCj4+Pj4+Pj4+IGZvciBwb3N0Cj4+Pj4+Pj4+IHByb2Nlc3NpbmcgYW5kIG5vdCB0aGUgS0ZE
Lgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBTbyB3ZSB3aWxsIG5lZWQgYXQgbGVhc3QgVk1JRHMgZm9yIHRo
YXQgYXMgd2VsbC4KPj4+Pj4+PiBDb3JyZWN0LiBQb3N0IHByb2Nlc3NpbmcgdXNlcyBjb21wdXRl
IHF1ZXVlcyBhbmQgVk1JRHMgaW4gdGhlIAo+Pj4+Pj4+IEdGWEhVQi4KPj4+Pj4+PiBWQ0UgdXNl
cyBWTUlEcyBpbiB0aGUgTU1IVUIuIEkgYmVsaWV2ZSBpbiBNZXNhIHRoZXkgdXNlIHRoZSBzYW1l
IFZNCj4+Pj4+Pj4gY29udGV4dC4gU28gY2FuJ3QgdGhleSBzaGFyZSB0aGUgc2FtZSBWTUlEcz8K
Pj4+Pj4+IEFoISBHb29kIHBvaW50LCBCdXQgd2Ugc3RpbGwgbmVlZCBhdCBsZWFzdCAzIFZNSUQg
d2hlbiBWTUlECj4+Pj4+PiByZXNlcnZhdGlvbiBpcyBhY3RpdmUuCj4+Pj4+IEkgZG9uJ3Qga25v
dyBhbnl0aGluZyBhYm91dCB0aGF0IFZNSUQgcmVzZXJ2YXRpb24gZmVhdHVyZS4gV2hhdCBpcyBp
dAo+Pj4+PiB1c2VkIGZvcj8gV2hvIGlzIHVzaW5nIGl0PyBIb3cgbWFueSBWTUlEcyBjYW4gYmUg
cmVzZXJ2ZWQ/Cj4+Pj4+Cj4+Pj4+IElmIG9uZSBWTUlEIGlzIHJlc2VydmVkLCB0aGVyZSB3b3Vs
ZCBzdGlsbCBiZSBvbmUgVk1JRCBsZWZ0IGZvciB2aWRlbwo+Pj4+PiBwb3N0IHByb2Nlc3Npbmcu
IFRoYXQncyBub3QgaWRlYWwsIGJ1dCBJIGRvbid0IHRoaW5rIGl0IHdvdWxkIGJlIAo+Pj4+PiBm
YXRhbC4KPj4+Pj4gQnV0IGlzIGl0IGEgcmVhbGlzdGljIHVzZSBjYXNlIHRoYXQgVk1JRCByZXNl
cnZhdGlvbiBhbmQgUk9DbSt2aWRlbwo+Pj4+PiBwcm9jZXNzaW5nIHdvdWxkIGhhcHBlbiBvbiB0
aGUgc2FtZSBzeXN0ZW0gYXQgdGhlIHNhbWUgdGltZT8KPj4+PiBWTUlEIHJlc2VydmF0aW9uIGlz
IHVzZWQgZm9yIGRlYnVnZ2luZyBhbmQgeWVzIHRoZXJlIGNhbiBvbmx5IGJlIG9uZQo+Pj4+IHJl
c2VydmVkLgo+Pj4+Cj4+Pj4gQnV0IEkgdGhpbmsgd2UgbmVlZCBhdCBsZWFzdCB0d28gZm9yIGR5
bmFtaWMgYXNzaWdubWVudCBvciB3ZSBtaWdodAo+Pj4+IHJ1biBpbnRvIGEgQlVHX09OKCkgd2hp
bGUgZ2l2aW5nIFZNSURzIHRvIGpvYnMuCj4+PiBJIGRvbid0IHNlZSBhbnkgQlVHcyBvciBCVUdf
T05zIGluIGFtZGdwdV9pZHMuYy4gV2hhdCBzaG91bGQgSSBiZQo+Pj4gbG9va2luZyBvdXQgZm9y
Pwo+Pgo+PiBXZSB1c2VkIHRvIGhhdmUgYSBCVUdfT04oKSB3aGVuIHdlIGNvdWxkbid0IGZpbmQg
YSBWTUlEIGFzIAo+PiBhbHRlcm5hdGl2ZSBpZiB0aGUgcHJvY2VzcyBhbHJlYWR5IGhhcyBvbmUg
YnV0IG5lZWRzIHRvIGZsdXNoIGl0Lgo+Pgo+PiBCdXQgaXQncyBhIGxvbmcgdGltZSBhZ28gdGhh
dCBJIGxhc3QgbG9va2VkIGludG8gdGhpcy4KPj4KPj4+PiBCdXQgSSBjZXJ0YWlubHkgbmVlZCB0
byB0ZXN0IHRoaXMgYXMgd2VsbC4gSXQncyBwb3NzaWJsZSB0aGF0IDEgVk1JRAo+Pj4+IGluZGVl
ZCB3b3JrcyBhcyBleHBlY3RlZC4KPj4+IEkgY291bGQgcnVuIHRoZSB0ZXN0LCBpZiB5b3UgZGVz
Y3JpYmUgdGhlIHByb2JsZW1hdGljIHNjZW5hcmlvIHlvdSBoYXZlCj4+PiBpbiBtaW5kLgo+Pgo+
PiBKdXN0IHRyeSB0byBzZXQgdGhlIGF2YWlsYWJsZSBWTUlEcyB0byAxIGFuZCBzZWUgaWYgR0ZY
L0NvbXB1dGUgYW5kIAo+PiBNTSBzdWJtaXNzaW9uIHdvcmsgYXQgdGhlIHNhbWUgdGltZSBmcm9t
IG11bHRpcGxlIHByb2Nlc3Nlcy4KPj4KPj4gQSBmZXcgVVZEIHZpZGVvIHBsYXliYWNrcyBhdCB0
aGUgc2FtZSB0aW1lIHNob3VsZCBkbyB0aGUgam9iLgo+Cj4gSSB0ZXN0ZWQgaXQgb24gRmlqaSB3
aXRoIGZpcnN0X2tmZF92bWlkPTIsIHJ1bm5pbmcgMyBpbnN0YW5jZXMgb2YgVkxDIAo+IHBsYXlp
bmcgYSAxMDgwcCBoLjI2NCB2aWRlbyB1c2luZyBWRFBBVS4gKEZvciBzb21lIHJlYXNvbiBWQS1B
UEkgaXMgCj4gYnJva2VuOiB2YURlcml2ZUltYWdlOiBvcGVyYXRpb24gZmFpbGVkKS4gSnVzdCB0
byBiZSBzdXJlIGl0IHdhcyAKPiByZWFsbHkgdXNpbmcgVVZELCBJIGRpc2FibGVkIEhXIGFjY2Vs
ZXJhdGlvbiBpbiBWTEMgYW5kIHNhdyBDUFUgdXNhZ2UgCj4gaW5jcmVhc2UuIEV2ZXJ5dGhpbmcg
c2VlbXMgdG8gYmUgd29ya2luZyBmaW5lLgoKSW4gdGhpcyBjYXNlIHRoZSBwYXRjaCBpcyBSZXZp
ZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyAKPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4K
PiBSZWdhcmRzLAo+IMKgIEZlbGl4Cj4KPgo+Pgo+PiBSZWdhcmRzLAo+PiBDaHJpc3RpYW4uCj4+
Cj4+Pgo+Pj4gVGhhbmtzLAo+Pj4gwqDCoCBGZWxpeAo+Pj4KPj4+Cj4+Pj4gUmVnYXJkcywKPj4+
PiBDaHJpc3RpYW4uCj4+Pj4KPj4+Pj4gVGhhbmtzLAo+Pj4+PiDCoMKgwqAgRmVsaXgKPj4+Pj4K
Pj4+Pj4KPj4+Pj4+IEkgZG9uJ3QgdGhpbmsgeW91IGNhbiBnbyBiZWxvdyB0aGlzLgo+Pj4+Pj4K
Pj4+Pj4+IFJlZ2FyZHMsCj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Pgo+Pj4+Pj4+IFJlZ2FyZHMs
Cj4+Pj4+Pj4gwqDCoMKgwqAgRmVsaXgKPj4+Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Pj4+PiBTaWduZWQt
b2ZmLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KPj4+Pj4+Pj4+
IC0tLQo+Pj4+Pj4+Pj4gwqDCoMKgwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5
XzAuYyB8IDExICsrKysrKysrLS0tCj4+Pj4+Pj4+PiDCoMKgwqDCoCAxIGZpbGUgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCj4+Pj4+Pj4+PiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPj4+Pj4+Pj4+IGluZGV4IDZl
MTBiNDJjNTdlNS4uMzQ3MDkyOWU1YjhlIDEwMDY0NAo+Pj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+Pj4+Pj4+Pj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+Pj4+Pj4+Pj4gQEAgLTEyNDUsMTAgKzEyNDUsMTUg
QEAgc3RhdGljIGludCBnbWNfdjlfMF9zd19pbml0KHZvaWQgKmhhbmRsZSkKPj4+Pj4+Pj4+IMKg
wqDCoMKgwqDCoMKgwqAgLyoKPj4+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAqIG51bWJlciBv
ZiBWTXMKPj4+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAqIFZNSUQgMCBpcyByZXNlcnZlZCBm
b3IgU3lzdGVtCj4+Pj4+Pj4+PiAtwqDCoMKgwqAgKiBhbWRncHUgZ3JhcGhpY3MvY29tcHV0ZSB3
aWxsIHVzZSBWTUlEcyAxLTcKPj4+Pj4+Pj4+IC3CoMKgwqDCoCAqIGFtZGtmZCB3aWxsIHVzZSBW
TUlEcyA4LTE1Cj4+Pj4+Pj4+PiArwqDCoMKgwqAgKiBhbWRncHUgZ3JhcGhpY3MvY29tcHV0ZSB3
aWxsIHVzZSBWTUlEcyAxLi5uLTEKPj4+Pj4+Pj4+ICvCoMKgwqDCoCAqIGFtZGtmZCB3aWxsIHVz
ZSBWTUlEcyBuLi4xNQo+Pj4+Pj4+Pj4gK8KgwqDCoMKgICoKPj4+Pj4+Pj4+ICvCoMKgwqDCoCAq
IFRoZSBmaXJzdCBLRkQgVk1JRCBpcyA4IGZvciBHUFVzIHdpdGggZ3JhcGhpY3MsIDMgZm9yCj4+
Pj4+Pj4+PiArwqDCoMKgwqAgKiBjb21wdXRlLW9ubHkgR1BVcy4gT24gY29tcHV0ZS1vbmx5IEdQ
VXMgdGhhdCBsZWF2ZXMgMiAKPj4+Pj4+Pj4+IFZNSURzCj4+Pj4+Pj4+PiArwqDCoMKgwqAgKiBm
b3IgdmlkZW8gcHJvY2Vzc2luZy4KPj4+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+Pj4+
Pj4+Pj4gLcKgwqDCoCBhZGV2LT52bV9tYW5hZ2VyLmZpcnN0X2tmZF92bWlkID0gODsKPj4+Pj4+
Pj4+ICvCoMKgwqAgYWRldi0+dm1fbWFuYWdlci5maXJzdF9rZmRfdm1pZCA9Cj4+Pj4+Pj4+PiAr
wqDCoMKgwqDCoMKgwqAgYWRldi0+YXNpY190eXBlID09IENISVBfQVJDVFVSVVMgPyAzIDogODsK
Pj4+Pj4+Pj4+IMKgwqDCoMKgIMKgwqDCoMKgwqAgYW1kZ3B1X3ZtX21hbmFnZXJfaW5pdChhZGV2
KTsKPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
