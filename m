Return-Path: <SRS0=W31V=3Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0950C32771
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jan 2020 09:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B53592071E
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jan 2020 09:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2otyzWzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53592071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 619476E4B6;
	Mon, 27 Jan 2020 09:34:17 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750040.outbound.protection.outlook.com [40.107.75.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47B366E4B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jan 2020 09:34:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQPMYzdUN7F/rivR3eC2tnVgZSg7GgV7QFbXC8mMpnGtKbkc8KaMhW8QpKr0T4tNZlDcKZKsCcL3VepPyswphvNjfHq9iwplyz18UnQTW0oPAkoYzxOLphH6jIn1+6DpW2/gOVg4h2vGwnf0isw4E8fLXRVRtFeTfzCr02Bf6yGsExexdlfH29lAgnU2ZLQOCAjUCtPsf52nYGDLDAAFE2nlmMKIcvE6II1A/KdWopZWtJsXUyvoWBwDuoEHugo6gHCM95LEdypaMS621ixUTiSGUO9efaealaD0aQ1172BShK3RG5q/ukWMSBGMzI18PkpMSU2VtMx9DM8Tfnw3QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kHbfyqBa7TnKE5UCI4uodUSchww4AeXfczPVowqSYQ=;
 b=CS6r6gV4UiesvbpMyhZctoIdQbx49kJtNO/OqZgRJmlEhSV8RuJABDgssYKA2ZGoxHr6h6YZpYjDPpCXhLab+rg90jIdjNXkV6X2Ohou49jd63YAyVU6n3ztjTJcwKNuo/9hunYKpPSvb1gA7PvQjmW4/lhf3zSzstL1re2eVCq+JRr34tGZubv5XxlHN9s4Z/s8bEXwtLgS49tWrGUUUpo4zGRhWHlvIyHwbTo9XH+B1rorSGBALxqjQIfgTMcilmSGMBRe3azzfmAN/r2IssQkMG3itRsarHF2VQPfQXWl2EWjwtAZ4ttNUf6MjPKD1xEjhzK0IM+J5QV5GhxkHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kHbfyqBa7TnKE5UCI4uodUSchww4AeXfczPVowqSYQ=;
 b=2otyzWzGifGVf/9NIYlywFd2lHRqNDNz4JI1pmpwj5EO67A8Q02P4qV5jbK55g/NEMTcalMEGJkvu2zwpNcBxkB9i75IzccuOqUoJflt/Zm1AaEJYqSDLHQJaqYPVGGzc0bm0d7r2uuMZoCbFoL8dS7hY4eDOk22PUp22OJ6XEc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB2474.namprd12.prod.outlook.com (10.172.87.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Mon, 27 Jan 2020 09:34:14 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2665.017; Mon, 27 Jan 2020
 09:34:14 +0000
Subject: Re: Raven: freeze at 'modprobe amdgpu' in early console with
 android-x86
To: amd-gfx@lists.freedesktop.org, issor.oruam@gmail.com
References: <CAEQFVGa9tzYgZeGLs5UY6yHfSHNZ0+Uqo3rTUzPjO+d7E2o-bA@mail.gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <ab79188c-70fd-5f35-71f6-bf6bcf773c94@amd.com>
Date: Mon, 27 Jan 2020 04:34:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <CAEQFVGa9tzYgZeGLs5UY6yHfSHNZ0+Uqo3rTUzPjO+d7E2o-bA@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::21) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.31.19.228] (165.204.54.211) by
 YTXPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22 via Frontend Transport; Mon, 27 Jan 2020 09:34:13 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4736e69d-0773-4cca-b2d7-08d7a30c1230
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2474:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB24742BC6E2582059A95A5748920B0@DM5PR1201MB2474.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02951C14DC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(16526019)(186003)(8676002)(16576012)(316002)(956004)(2616005)(6486002)(44832011)(4326008)(966005)(2906002)(8936002)(66946007)(66556008)(66476007)(53546011)(31686004)(26005)(45080400002)(478600001)(36756003)(31696002)(86362001)(5660300002)(81156014)(52116002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB2474;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PYTwoZitFaXXMiuZ8OgpYDEgSHeydFZgIScIJikAcriIsZb3RoUIXMQC/WWQaXRsxNHmy11njVoZtMcF4q9J3/Q8oYgR8FprRY6KIrqu6/d/XRfnp/EdtoHUz77Up44otmy4n29G5sRctf+lqqivSjoH95y2QNPu2MsPa9UQJA9UwY43rvQZ+mIImGa8RdIBCdvt5SAG5n59ki4O866wgqvuJCGzm4TxGCg1NF8jpyUo08FW4s1MoJlu+3dob9NIye8KAsUhp2XYChDwzhiXcXTgQ65kWGuO63BFK3A2b1NGlMPz3SnEFZdW9vhtlU15yDYZNtlC7F0CkCOtPZwInFZ385rBQwfNdLkgG5m88oia0jVkjs5xYsVuyDuHn7rg2CYXdD2zMTCpO/oVFAiGifSihjTJD2SHrUJ/iAKYsFQp1QoImDH6cRGeaLbV5/pRKSNWZF0s/PZv6ndNLfTxfWJl4brjK0KFBT/Zpdec4pC5UO3J95yckO2O/LEipoIW32Dt3U6UrCiD1ApGWd2r+A==
X-MS-Exchange-AntiSpam-MessageData: zUQ36jIlK+oKyeBMCsMkpOyWqPT76RVliQq5/siwxHyFdbWNXix73hYolrFx0tXiqtiBQsFOFMF/0yu/2V7bE9xLwn5zgN3kmoPAxwrDm0+VXUz3jZGCuoJQBlDcdoez7QMakGc+OZkTo6c0vyYoUw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4736e69d-0773-4cca-b2d7-08d7a30c1230
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2020 09:34:14.0539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqWvCIVCmgtcMpNh58vJYfR+xHRnRi3iIBtJ21BWrTSxXylequQA8xxdWZWbuTY2i0EcrikUTGkoKNPdB3PsxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2474
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
Cc: cwhuang@android-x86.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SSd2ZSBzZWVuIGhhbmdzIG9uIGEgUmF2ZW4gQU00IHN5c3RlbSBhZnRlciB0aGUgVWJ1bnR1IHVw
Z3JhZGUgdG8ga2VybmVsIAo1LjMuIEkgYW0gYWJsZSB0byB3b3JrIGFyb3VuZCBpdCBieSBkaXNh
Ymxpbmcgc3R1dHRlciBtb2RlIHdpdGggdGhlIAptb2R1bGUgcGFyYW1ldGVyIGFtZGdwdS5wcGZl
YXR1cmVtYXNrPTB4ZmZmZGJmZmYuIElmIHRoYXQgZG9lc24ndCBoZWxwLCAKeW91IGNvdWxkIGFs
c28gdHJ5IGRpc2FibGluZyBHRlhPRkYgd2l0aCBhbWRncHUucHBmZWF0dXJlbWFzaz0weGZmZmQz
ZmZmLgoKUmVnYXJkcywKIMKgIEZlbGl4CgpPbiAyMDIwLTAxLTI2IDExOjEzLCBNYXVybyBSb3Nz
aSB3cm90ZToKPiBIZWxsbywKPiBJIGFtIGhhdmluZyBwcm9ibGVtIHRvIGxvYWQgYW1kZ3B1IG1v
ZHVsZSB3aXRoIEF0aGxvbiAyMDBHRSwgb24gYQo+IG1vdGhlcmJvYXJkIE1TSSBCNDUwTS1BIFBy
byBNYXggd2l0aCBsYXRlc3QgQklPUyBhbmQgYSBEVkktRCBtb25pdG9yLgo+Cj4gVGhlIHNhbWUg
SFcgc2V0dXAgIGJvb3RzIFVidW50dSAxOS4xMCBHbm9tZSBEZXNrdG9wIEVudmlyb25tZW50IHdp
dGgKPiBBUFUgSFcgYWNjZWxlcmF0aW9uIHdpdGhvdXQgYW55IGlzc3VlLgo+Cj4gV2hlbiBpc3N1
ZWluZyB0aGUgY29tbWFuZCAnbW9kcHJvYmUgYW1kZ3B1JyBpbiBlYXJseSBjb25zb2xlIHRoZQo+
IHNjcmVlbiBqdXN0IGZyZWV6ZXMsIGJ1dCBJIGRvbid0IHNlZSBhbnkgW2RybV0gYW1kZ3B1IG91
dHB1dCBvbiB0aGUKPiBzY3JlZW4gYW5kIHRoZSBtb2Rlc2V0dGluZyBoYXMgY2xlYXJseSBmYWls
ZWQuCj4KPiBJIGhhdmUgdHJpZWQgd2l0aCBrZXJuZWwgNS4zLCB0aGUgc2FtZSBhcyB0aGUgb25l
IHVzZWQgaW4gVWJ1bnR1Cj4gMTkuMTAsIGFuZCByZXBsaWNhdGVkIHRoZSAlQU1EJSBrZXJuZWwg
Y29uZmlnIG9wdGlvbnMgZXh0cmFjdGVkIGZyb20KPiBVYnVudHUuCj4gSSBoYXZlIHRoZSBzYW1l
IGlzc3VlIGFsc28gd2l0aCBrZXJuZWwgNS41cmM3IGFuZCB1cCB0byBkYXRlIGxpbnV4LWZpcm13
YXJlLgo+Cj4gSW4gY2FzZSB5b3UgaGF2ZSBleHBlcmllbmNlZCBvciBrbm93IGFib3V0IHNpbWls
YXIgaXNzdWVzLAo+IGNvdWxkIHlvdSBwbGVhc2UgcHJvdmlkZSBzb21lIGluZm8vc3VnZ2VzdGlv
biBmb3IgbWUgdG8gdHJ5IHRvCj4gb3ZlcmNvbWUgdGhlIHByb2JsZW0/Cj4KPiBBcmUgdGhlcmUg
c29tZSBpbXBsaWNpdCBhZGRpdGlvbmFsIGtlcm5lbCBjb25maWcgb3B0aW9ucyByZXF1aXJlZCBi
ZXNpZGVzCj4gQ09ORklHX0RSTV9BTURHUFU9bSwgQ09ORklHX0FNRF9EQz15LCBDT05GSUdfQU1E
X0RDX0RDTjFfMD15LAo+Cj4gb3Igc29tZSB1bmRvY3VtZW50ZWQgbW9kdWxlIGRlcGVuZGVuY2ll
cywgd2hpY2ggYXJlIG1hbmRhdG9yeSBmb3IgdGhlCj4gUmF2ZW4gQVBVcyBjb3JyZWN0IGRldGVj
dGlvbj8KPgo+IFRoYW5rcyBmb3IgYW55IGluZm8KPgo+IE1hdXJvIFJvc3NpCj4gYW5kcm9pZC14
ODYgdGVhbSB2b2x1bnRlZXIKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKPiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29t
Lz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlz
dGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0NmZWxpeC5rdWVobGluZyU0MGFtZC5j
b20lN0NmM2IzNjFlYWM2OWY0ODc4YWY0MjA4ZDdhMjdhYWI2MiU3QzNkZDg5NjFmZTQ4ODRlNjA4
ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcxNTY1MjA0MDgxMjg4OTYmYW1wO3NkYXRhPVJj
MjB5JTJCRm9oMDZ2JTJGelk2VGRNODk2QjJLWmlMJTJCQ3ElMkZNQUpxa1kzME02USUzRCZhbXA7
cmVzZXJ2ZWQ9MApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
