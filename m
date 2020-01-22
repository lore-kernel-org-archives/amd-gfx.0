Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D437C2D0DB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 18:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 472FD2465A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 18:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VN1MVyz6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472FD2465A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF58E6F62D;
	Wed, 22 Jan 2020 18:11:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 419BF6F62D
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 18:11:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNKQJ2LEIArQqT4F/GDWnMwOfTcUn2LXTIRe2dC+nr1vYmmeGTu8cjsW+8qeWjNx15grWCLDt+FHRTVxZvW7tMUcAQ9sYAz9e0aGEnHHv8UV0mzetvV/LycX8iX0zkhfdf/Ju09xM/IGSAMVZkkp0W7pGH5pvTGNXHMFn2TcGCT6TXo56IIwRczwn3oRouhNuQHqkm9+QYECWIUcq9vOenZxGDycj53tyryuCTjOXv5FvyoOH6zyQkwb1cbJIAnZeixwH2qQJrEgxPGCr0sJVgoec0hIUxOHRGD/pLJAb2nKqHKiz5Ca0TDtThTnb+EqTS90WKoNGy4wbXmaQwR3hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGuPbxecoGVR0tBSx4+F96oFZLDcxxHOjKS2Y3v7o4g=;
 b=dMhsXCgSGbegKHnpNiioqHa29nu+SmAhyuS6jgg1OU/id4V79GK3gbHlGfbXYQt0V0eaFlr/QXO0ITDvoDV0NypBs3Tj4n3hWl5jihNQPEioHuUtnPwwXmu1Fz4vUKdWoQa4ZOL88CdPJR6tZOnBVacbed55t9YDFXzc5jnFjCnk6vIcyjC1uGBaRUCs0Q6HkREV2/JD9R6fqOdpJWUh884eOYDApPxAxIcvHklLqxfBKJV/cCX5sNtaiMCPYBHIbibfvNYqay50nn/qHQY8/dK7eavcVhKlxXDDBv1NukgjiL7RQ4QXkvWJIMotQ/gh10XnuvGi7UEso2D9+c5yig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGuPbxecoGVR0tBSx4+F96oFZLDcxxHOjKS2Y3v7o4g=;
 b=VN1MVyz6FMYcklaeYC5r6QcwIt0LZCLtjkABnfgmPaMm8z/Ezg2FSMe1kL6vwrgaIIasv64K38EYHBwYP/16klyfEF2jZ2BpgYvicVYMmxRFEaC0M0+/HsqNPCcLJRnkRLeOqRuQ2M/jEBHJ28SipqfFFnQ5uthu5/jfy0s0Pv4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB3547.namprd12.prod.outlook.com (20.179.106.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Wed, 22 Jan 2020 18:11:27 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a%7]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 18:11:27 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: return EINVAL instead of ENOENT in the VM
 code
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 tom.stdenis@amd.com, amd-gfx@lists.freedesktop.org
References: <20200122140303.14411-1-christian.koenig@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <816d058c-cd19-a6c0-fe50-4fc84646c94a@amd.com>
Date: Wed, 22 Jan 2020 13:11:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200122140303.14411-1-christian.koenig@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::33) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
Received: from localhost.localdomain (165.204.55.250) by
 YTXPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Wed, 22 Jan 2020 18:11:26 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 52a71186-1268-4ea9-764c-08d79f667f52
X-MS-TrafficTypeDiagnostic: DM6PR12MB3547:|DM6PR12MB3547:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3547778BD75DED86B351657D990C0@DM6PR12MB3547.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 029097202E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(189003)(199004)(6512007)(44832011)(2906002)(36756003)(26005)(6486002)(16526019)(186003)(956004)(2616005)(4744005)(5660300002)(31686004)(66574012)(66556008)(316002)(478600001)(31696002)(81166006)(8936002)(8676002)(66946007)(81156014)(53546011)(66476007)(6506007)(52116002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3547;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xUHo36iftsweKQ2n6/PSo7neVLY0lbQyWgr/SGWNhfWugaiqgUiS6B/y7Wa10+QR2cM2FXMPrSpWwQr0Bw1IOGIkw+UHQekBJrI3fvhv5aQq1rBMkOSgv4+IAuqKTrDooGHH1yqrD3Iw9eLaDsMqyk7JNwGfonElKL9bUYMzW9v4q/2ALyeZADWTAVUCHqzFz9xEMbGmZFxW1vCKcv1cOo3yp0aFdzXSFl0hh9V82ptGqocWpmzR+QKYkYZGqO7fcXPkP//iZNEkEIHaYPCIRAWq/nfwahUwregKdVmAO6Fl3KSCipTqxbLBb4z2A04tkrFXOr/LTK4BC21hJLEz21rzDBS6x+OOmvTGs0uA9aPT7B8QdLOnmQd7ZTjrC/FDNzUf2sFnArrzk5kWg2dWwYr9xuAodkvHjijL7BElsMpNT95wSUhRdnTFdwjci0xW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a71186-1268-4ea9-764c-08d79f667f52
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 18:11:27.1383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7TTbCkvscoXuIZcu+cMmVj7jQcwrFRAYR/UZIz5EeMn0cTfWhD+NAA98CECvp+P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3547
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

RG8gd2UgaGF2ZSB1c2VyLXNwYWNlL2xpYnMgcmVseSBvbiB0aGlzIGVycm5vIGluIHBhcnRpY3Vs
YXI/CgpPbiAyMDIwLTAxLTIyIDk6MDMgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBU
aGF0IHdlIGNhbid0IGZpbmQgYSBQRCBhYm92ZSB0aGUgcm9vdCBpcyBleHBlY3RlZCBjYW4gb25s
eSBoYXBwZW4gaWYKPiB3ZSB0cnkgdG8gdXBkYXRlIGEgbGFyZ2VyIHJhbmdlIHRoYW4gYWN0dWFs
bHkgbWFuYWdlZCBieSB0aGUgVk0uCj4gCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdm0uYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmMKPiBpbmRleCA1Y2IxODIyMzFmNWQuLjgxMTlmMzJjYTk0ZCAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gQEAgLTE0NzUsNyArMTQ3NSw3IEBAIHN0YXRpYyBp
bnQgYW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAq
cGFyYW1zLAo+ICAJCQkgKiBzaGlmdCB3ZSBzaG91bGQgZ28gdXAgb25lIGxldmVsIGFuZCBjaGVj
ayBpdCBhZ2Fpbi4KPiAgCQkJICovCj4gIAkJCWlmICghYW1kZ3B1X3ZtX3B0X2FuY2VzdG9yKCZj
dXJzb3IpKQo+IC0JCQkJcmV0dXJuIC1FTk9FTlQ7Cj4gKwkJCQlyZXR1cm4gLUVJTlZBTDsKPiAg
CQkJY29udGludWU7Cj4gIAkJfQo+ICAKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
