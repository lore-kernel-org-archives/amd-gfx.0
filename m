Return-Path: <SRS0=Ny8F=5J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872FFC10DCE
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 03:40:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51109205ED
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 03:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="agOILvN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51109205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DF8C6E0A6;
	Tue, 24 Mar 2020 03:40:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3D006E0A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 03:40:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aU/ywQWNGBJHacwOpfzcycBFY8hm0kujqur5ET8OoQ+85ZhTDHZSZNwd2KhPyZ6yV00W9z6FS4KbGH+gQyeoDesMk4W2zxHb43oU48reDdzoa1rJpCDklfUqo1ygUFj6+gSCEvu09h035ZJowuhPazfZwUbLFpwBGjRusod49OBWpT6VwkMYkHTQa+10wlPSGCSmuzEANP14pN7Vrtzpxa2kZh42o3l/8RkSY9094MYXd8LH64zxpBRSLoB4OQL1SH5WLiROypXAsH5O+MWa+ktflRuivjmPN9MwgYVGwDQUSmghw9xPdglT9ryvuqx29fGxF8YHZ6CDs26eSLO0Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ua/O+lXjwj4PiF9lOQfkjr1n1uKXoL7mlzj7ewZbrY=;
 b=kGZcl5fnj4boH+NuwTlX6RtH1eHP0R5wwC4FwN3iOeWNgdmhU5vSjSX9jP6LhWf5cFOA+YE6Xng08WoSeApO6vu+bhaSZPTD613nxQXZG0E1/5R5l8HgVN/j8f3+5XEfspPw7kZP1Bp+s886MN+/+If9emeTY7wLeFRhMFWuGgAvbguZDbPzQCGfP4roiIRQaR5/sXfasjNUmktMXJ8V084pIFqcRObRXIW3dDrBDDV+EvIRf/+JUAijme4ohF4wx0lOCWjFaWTfJyTJywJnMUY4vGv/Rqfr1INOl97b0+ce/krMDR41Dk3VrjSJ13cGBs2Qon3qPsh6/kbd9PgIfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ua/O+lXjwj4PiF9lOQfkjr1n1uKXoL7mlzj7ewZbrY=;
 b=agOILvN78Lvokjr8dh3H4tZY6XsqjFfYvR7MVhv3yz7Ry5EbVco9ru3pnA2NKcDRc/YuQP2Ucz5CknxB0Hd1ubHX34xbH280Q48SMka3evYqgIWazz/woumcg3yxrU7hFSIw0+mxKpHhmupat6cYJL3S9aTXghi2B1ZW6SoLA7U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (2603:10b6:301:e::22)
 by MWHPR12MB1840.namprd12.prod.outlook.com (2603:10b6:300:114::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Tue, 24 Mar
 2020 03:40:09 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150%6]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 03:40:08 +0000
Subject: Re: [PATCH] drm/amdgpu: hold the reference of finished fence
To: Yintian Tao <yttao@amd.com>, christian.koenig@amd.com,
 Alexander.Deucher@amd.com
References: <20200323142247.3175-1-yttao@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <2a6a579f-062c-3911-d06a-d4e51f5815a3@amd.com>
Date: Mon, 23 Mar 2020 23:40:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <20200323142247.3175-1-yttao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::21) To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:fc00:75ba:3733:a94f:ae13]
 (2607:fea8:3edf:fc00:75ba:3733:a94f:ae13) by
 YTBPR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.15 via Frontend Transport; Tue, 24 Mar 2020 03:40:08 +0000
X-Originating-IP: [2607:fea8:3edf:fc00:75ba:3733:a94f:ae13]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6154681c-cc96-4c17-348a-08d7cfa50cac
X-MS-TrafficTypeDiagnostic: MWHPR12MB1840:|MWHPR12MB1840:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1840D86992F4D235E4604C9BEAF10@MWHPR12MB1840.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:449;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(316002)(53546011)(186003)(6486002)(16526019)(36756003)(66946007)(66476007)(66556008)(86362001)(31696002)(478600001)(8936002)(8676002)(5660300002)(6636002)(2616005)(31686004)(2906002)(52116002)(81166006)(4326008)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1840;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X4Yqckxpx2aVY3ajv/m5sRHZPAhHG7dNVOqgmk+lFPnUkRfNK6iqm2DnQtNlRXukba2eeJm5wbiLTZMREL18WZ09toGy8yXEqzjJAiNAspXqgJc5qRFhNyMuR8uvAfm/jfGL7sV50k6qkCkLsixYBZ7Xbsan4kiFHKjc/8BpiCHOw7kOdLvJ5d9OHiyXmpCe2L6hDFrCEa/RlCh/jeyQIhda2/98VK/vb75/snp1faezpX5Ie5FsLTE/7pL4e4ayFLncBp/eS/RU/j3EG9OOQ/hBzr1xfJ75qZtmdmFia8AZKkCLNGFODpipQCX0JyXUcId39gcXwl/TRtn7FiK2woNrInUiIZDZP6tVfTU5mOkDcbJYFuEjxtuKEtHxSO+l4n8h/jOLvRsL38H0Jh05QvyXEkCenPEMGcVaQfrp+Kuzfm2okFEQwFDslzk75wbI
X-MS-Exchange-AntiSpam-MessageData: h/zAhBvTdeb6mXAzfqqaXOQ9s2cdFg+ikNL5NYG+7ebB7YXJ2yfIZ4Pgc5TVgSpVTiwb4OJqK5E0UGwahMCC+VHoxvNdVJ7XNPxopW5GiMUBmkiZNooZxgMPoZuktIhwN80XLPTS1ZrY+tEt6Bv3PUztdrcwY+XIzXy/iLvhOZP9OubTi080LyVKUs4lqdtIe4gj07GaPAZQifX4eTXN0g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6154681c-cc96-4c17-348a-08d7cfa50cac
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 03:40:08.7939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDRJK6nI6Qr4fGW75o8VAqtDaB6Zq4PPNeUXIlcaJb/JTPShaahABH6PcrDSVmjTC70pBcW/yMLAf1msI43EHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1840
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

Ck9uIDMvMjMvMjAgMTA6MjIgQU0sIFlpbnRpYW4gVGFvIHdyb3RlOgo+IFRoZXJlIGlzIG9uZSBv
bmUgY29ybmVyIGNhc2UgYXQgZG1hX2ZlbmNlX3NpZ25hbF9sb2NrZWQKPiB3aGljaCB3aWxsIHJh
aXNlIHRoZSBOVUxMIHBvaW50ZXIgcHJvYmxlbSBqdXN0IGxpa2UgYmVsb3cuCj4gLT5kbWFfZmVu
Y2Vfc2lnbmFsCj4gICAgICAtPmRtYV9mZW5jZV9zaWduYWxfbG9ja2VkCj4gCS0+dGVzdF9hbmRf
c2V0X2JpdAo+IGhlcmUgdHJpZ2dlciBkbWFfZmVuY2VfcmVsZWFzZSBoYXBwZW4gZHVlIHRvIHRo
ZSB6ZXJvIG9mIGZlbmNlIHJlZmNvdW50LgoKCkRpZCB5b3UgZmluZCBvdXQgd2h5IHRoZSB6ZXJv
IHJlZmNvdW50IG9uIHRoZSBmaW5pc2hlZCBmZW5jZSBoYXBwZW5zIApiZWZvcmUgdGhlIGZlbmNl
IHdhcyBzaWduYWxlZCA/IFRoZSBmaW5pc2hlZCBmZW5jZSBpcyBjcmVhdGVkIHdpdGggCnJlZmNv
dW50IHNldCB0byAxIGluIGRybV9zY2hlZF9mZW5jZV9jcmVhdGUtPmRtYV9mZW5jZV9pbml0IGFu
ZCB0aGVuIHRoZSAKcmVmY291bnQgaXMgZGVjcmVtZW50ZWQgaW4gCmRybV9zY2hlZF9tYWluLT5h
bWRncHVfam9iX2ZyZWVfY2ItPmRybV9zY2hlZF9qb2JfY2xlYW51cC4gVGhpcyBzaG91bGQgCm9u
bHkgaGFwcGVuIGFmdGVyIGZlbmNlIGlzIGFscmVhZHkgc2lnbmFsZWQgKHNlZSAKZHJtX3NjaGVk
X2dldF9jbGVhbnVwX2pvYikuIE9uIHRvcCBvZiB0aGF0IHRoZSBmaW5pc2hlZCBmZW5jZSBpcyAK
cmVmZXJlbmNlZCBmcm9tIG90aGVyIHBsYWNlcyAoZS5nLiBlbnRpdHktPmxhc3Rfc2NoZWR1bGVk
IGUudC5jKS4uLgoKCj4KPiAtPmRtYV9mZW5jZV9wdXQKPiAgICAgIC0+ZG1hX2ZlbmNlX3JlbGVh
c2UKPiAJLT5kcm1fc2NoZWRfZmVuY2VfcmVsZWFzZV9zY2hlZHVsZWQKPiAJICAgIC0+Y2FsbF9y
Y3UKPiBoZXJlIG1ha2UgdGhlIHVuaW9uIGZsZWQg4oCcY2JfbGlzdOKAnSBhdCBmaW5pc2hlZCBm
ZW5jZQo+IHRvIE5VTEwgYmVjYXVzZSBzdHJ1Y3QgcmN1X2hlYWQgY29udGFpbnMgdHdvIHBvaW50
ZXIKPiB3aGljaCBpcyBzYW1lIGFzIHN0cnVjdCBsaXN0X2hlYWQgY2JfbGlzdAo+Cj4gVGhlcmVm
b3JlLCB0byBob2xkIHRoZSByZWZlcmVuY2Ugb2YgZmluaXNoZWQgZmVuY2UgYXQgZHJtX3NjaGVk
X3Byb2Nlc3Nfam9iCj4gdG8gcHJldmVudCB0aGUgbnVsbCBwb2ludGVyIGR1cmluZyBmaW5pc2hl
ZCBmZW5jZSBkbWFfZmVuY2Vfc2lnbmFsCj4KPiBbICA3MzIuOTEyODY3XSBCVUc6IGtlcm5lbCBO
VUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UsIGFkZHJlc3M6IDAwMDAwMDAwMDAwMDAwMDgKPiBbICA3
MzIuOTE0ODE1XSAjUEY6IHN1cGVydmlzb3Igd3JpdGUgYWNjZXNzIGluIGtlcm5lbCBtb2RlCj4g
WyAgNzMyLjkxNTczMV0gI1BGOiBlcnJvcl9jb2RlKDB4MDAwMikgLSBub3QtcHJlc2VudCBwYWdl
Cj4gWyAgNzMyLjkxNjYyMV0gUEdEIDAgUDREIDAKPiBbICA3MzIuOTE3MDcyXSBPb3BzOiAwMDAy
IFsjMV0gU01QIFBUSQo+IFsgIDczMi45MTc2ODJdIENQVTogNyBQSUQ6IDAgQ29tbTogc3dhcHBl
ci83IFRhaW50ZWQ6IEcgICAgICAgICAgIE9FICAgICA1LjQuMC1yYzcgIzEKPiBbICA3MzIuOTE4
OTgwXSBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAxOTk2
KSwgQklPUyByZWwtMS44LjItMC1nMzNmYmUxMyBieSBxZW11LXByb2plY3Qub3JnIDA0LzAxLzIw
MTQKPiBbICA3MzIuOTIwOTA2XSBSSVA6IDAwMTA6ZG1hX2ZlbmNlX3NpZ25hbF9sb2NrZWQrMHgz
ZS8weDEwMAo+IFsgIDczMi45Mzg1NjldIENhbGwgVHJhY2U6Cj4gWyAgNzMyLjkzOTAwM10gIDxJ
UlE+Cj4gWyAgNzMyLjkzOTM2NF0gIGRtYV9mZW5jZV9zaWduYWwrMHgyOS8weDUwCj4gWyAgNzMy
Ljk0MDAzNl0gIGRybV9zY2hlZF9mZW5jZV9maW5pc2hlZCsweDEyLzB4MjAgW2dwdV9zY2hlZF0K
PiBbICA3MzIuOTQwOTk2XSAgZHJtX3NjaGVkX3Byb2Nlc3Nfam9iKzB4MzQvMHhhMCBbZ3B1X3Nj
aGVkXQo+IFsgIDczMi45NDE5MTBdICBkbWFfZmVuY2Vfc2lnbmFsX2xvY2tlZCsweDg1LzB4MTAw
Cj4gWyAgNzMyLjk0MjY5Ml0gIGRtYV9mZW5jZV9zaWduYWwrMHgyOS8weDUwCj4gWyAgNzMyLjk0
MzQ1N10gIGFtZGdwdV9mZW5jZV9wcm9jZXNzKzB4OTkvMHgxMjAgW2FtZGdwdV0KPiBbICA3MzIu
OTQ0MzkzXSAgc2RtYV92NF8wX3Byb2Nlc3NfdHJhcF9pcnErMHg4MS8weGEwIFthbWRncHVdCj4K
PiB2MjogaG9sZCB0aGUgZmluaXNoZWQgZmVuY2UgYXQgZHJtX3NjaGVkX3Byb2Nlc3Nfam9iIGlu
c3RlYWQgb2YKPiAgICAgIGFtZGdwdV9mZW5jZV9wcm9jZXNzCj4gdjM6IHJlc3VtZSB0aGUgYmxh
bmsgbGluZQo+Cj4gU2lnbmVkLW9mZi1ieTogWWludGlhbiBUYW8gPHl0dGFvQGFtZC5jb20+Cj4g
LS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYyB8IDIgKysKPiAg
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVs
ZXIvc2NoZWRfbWFpbi5jCj4gaW5kZXggYTE4ZWFiZjY5MmU0Li44ZTczMWVkMGQ5ZDkgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYwo+IEBAIC02NTEsNyArNjUxLDkg
QEAgc3RhdGljIHZvaWQgZHJtX3NjaGVkX3Byb2Nlc3Nfam9iKHN0cnVjdCBkbWFfZmVuY2UgKmYs
IHN0cnVjdCBkbWFfZmVuY2VfY2IgKmNiKQo+ICAgCj4gICAJdHJhY2VfZHJtX3NjaGVkX3Byb2Nl
c3Nfam9iKHNfZmVuY2UpOwo+ICAgCj4gKwlkbWFfZmVuY2VfZ2V0KCZzX2ZlbmNlLT5maW5pc2hl
ZCk7Cj4gICAJZHJtX3NjaGVkX2ZlbmNlX2ZpbmlzaGVkKHNfZmVuY2UpOwoKCklmIHRoZSBmZW5j
ZSB3YXMgYWxyZWFkeSByZWxlYXNlZCBkdXJpbmcgY2FsbCB0byAKZHJtX3NjaGVkX2ZlbmNlX2Zp
bmlzaGVkLT5kbWFfZmVuY2Vfc2lnbmFsLT4uLi4gd2h5IGlzIGl0IHNhZmUgdG8gCnJlZmVyZW5j
ZSB0aGUgc19mZW5jZSBqdXN0IGJlZm9yZSB0aGF0IGNhbGwgPyBDYW4ndCBpdCBhbHJlYWR5IGJl
IApyZWxlYXNlZCBieSB0aGlzIHRpbWUgPwoKQW5kcmV5CgoKCj4gKwlkbWFfZmVuY2VfcHV0KCZz
X2ZlbmNlLT5maW5pc2hlZCk7Cj4gICAJd2FrZV91cF9pbnRlcnJ1cHRpYmxlKCZzY2hlZC0+d2Fr
ZV91cF93b3JrZXIpOwo+ICAgfQo+ICAgCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
