Return-Path: <SRS0=opbO=4I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22510C11D04
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 10:36:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAC012467A
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 10:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i3ha5bza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC012467A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83FC46ED1D;
	Thu, 20 Feb 2020 10:36:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E593F6ED1D
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2020 10:36:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7wZ4SQENmlEzQHqB/y5PJSp0zGJhoDjx9iCk5BDy0mrajZOSkNNsfcfr0T0pYqKgTx9qmZsA++ZSex/YCbDJqJK98r8vaehNqSOCJnp48VZ9Z3URQzxxQNTq+kczmcrcfz7Hjbr7qTotTU7GFhVvpipYmYE9Y82FYRAoeW0EtcvzjQM2Mk0JgtJowuF5UXgfCGi12Bkfk0BD0HbPqendhFxZEw+URBOOnnQUsCUiiGf9CD4u0nUwCVzjj1JwK42n2VeyTy8Gmv9t/1r/e7BkJdkhbfCauabgd5wTVyha8fkIpCtvcxRqJEeoudlwZ7jS3HDqF8M54tRRfpzdqK2yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvNRO7o0GhplRK+nTSXObH0If3lRBPTkfAw/appTnpA=;
 b=QKgVxd1w1hcqxSAPB09NxhpEwwM98GOMv0wv0I7OmZo4NFBY2io6bgzTuq7HiOPf9MyfQospUo6RhJSY2izrXKAjfXjRHgV0L8r0HjAZ1lYnZzgMwQXhnCKv++AuvO1JN31971imjVxbORSnZjEUmtJc7dY/2Y8Yg4BZxNVU/CK8HN/GroOTPxY5iC3qOBAPmonMu1XX+G/nnClRLnti/ffuAx6NFkvgd5N41MCOMOzHx4nIPdKNxVXjpdit33zlOmcFTOUL1MTEp+3p/YRLw+vpJVs562T2YZ+c4v0v3/7BqEzhE1ekWoKkgVFI46qA6H/IPF955yNB/sYE/51lIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvNRO7o0GhplRK+nTSXObH0If3lRBPTkfAw/appTnpA=;
 b=i3ha5bzaKIGIdiuEngZrrGYAkKjvyzq+FtmQavw++uxFLq1ZI8fAzlcq/UuTMsGoEleyR/PWBHjt9ewTLEzWjNMl8eT0j4TSVlVCIoClm/MxZ5EhyogKJyQv6UgjWHkG0SshNaNqpQaH0wQZfEREUxVe3dAGT2FR6vIp0LMadKs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1723.namprd12.prod.outlook.com (10.175.90.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Thu, 20 Feb 2020 10:36:47 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2750.016; Thu, 20 Feb 2020
 10:36:47 +0000
Subject: Re: [PATCH] drm/amdgpu: fix a bug NULL pointer dereference
To: amd-gfx@lists.freedesktop.org
References: <20200219040445.11112-1-Dennis.Li@amd.com>
 <DM5PR12MB1418062D884DBE08E1FB9997FC100@DM5PR12MB1418.namprd12.prod.outlook.com>
 <e7ea478f-95ff-69c6-e81e-709b44904209@gmail.com>
 <DM6PR12MB393104A6C93ED039BAA5ED1C84100@DM6PR12MB3931.namprd12.prod.outlook.com>
 <MN2PR12MB3167C68A5B6AF0E97613A6A4ED130@MN2PR12MB3167.namprd12.prod.outlook.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <c87ad9b2-d467-4714-29e2-0a881451c9f2@amd.com>
Date: Thu, 20 Feb 2020 11:39:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <MN2PR12MB3167C68A5B6AF0E97613A6A4ED130@MN2PR12MB3167.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0081.eurprd02.prod.outlook.com
 (2603:10a6:208:154::22) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2c:5d00:8d2:968:f382:8499]
 (2003:c5:8f2c:5d00:8d2:968:f382:8499) by
 AM0PR02CA0081.eurprd02.prod.outlook.com (2603:10a6:208:154::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Thu, 20 Feb 2020 10:36:46 +0000
X-Originating-IP: [2003:c5:8f2c:5d00:8d2:968:f382:8499]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e9c68f46-60a9-453c-ecd3-08d7b5f0c92c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1723:
X-Microsoft-Antispam-PRVS: <DM5PR12MB172336198A1487C3E462B76E8B130@DM5PR12MB1723.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:473;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(199004)(189003)(16526019)(186003)(6916009)(5660300002)(316002)(81156014)(52116002)(36756003)(6486002)(8936002)(2616005)(31686004)(8676002)(81166006)(966005)(2906002)(66556008)(66476007)(53546011)(478600001)(31696002)(45080400002)(66946007)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1723;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Le1Vx6LpjI3QN62/0pOk/Qsb2SnZ9bDqx/tOkbzbSMeX5cRu9rXk48o/z6DQr6Nm/1jedkoSP109QIbBlLivD8T/6RMD+njJVfMarvkEIJBFe2dx0NdnDzfQzzBAS0DWgY8XBo4HwXoFyCJceXL4rfIfeA6ViokVL9gVcmzrf23yDKE290JiFfGHHlxCsCiRouuRPWp1DbabMJUE/oW7HtV2M2Ahv+/FjtnCNkCYEMOYfAvoQJT1FE/rFIli+bmgr4Ky7PMCFXXq+NJBvXn1+hLXVXXxjrsWqISl8O8H3ugIuIjjIOcS2aXjRloa5dPuDqoQuiRpjF5Bd4F9VjtZukyQbvSHLaNTqkicgvqH0wI+tHf32Hu4MTUZ7APLkC8Kk5R8bP7aueY8Xjfy5Riku9XClNubQZH2/BMvB/1lYOP21q2bKR90EvianWf9Z5eN0I/e7rlVh/jVvW//PWLQEHrcSgXWxBkMEfqBx6RRVahO5RtfNVPJ1GYz9xuNrkq3YHjFoRuhAL04GvyVlb/s4P484NHhhNnBvxaBzx/vgRYFevzoWQ2eWH7mpR2IQ2jwWuETxwoVaVJBj0DBlRe7sMhUd3MgZv1NiMSfNR30sAmIAlt8eCdM2UmN7GVT+fv
X-MS-Exchange-AntiSpam-MessageData: jakDqMMLgXiGh6uNUvgFp4O3OPZDr/DOJSwFSrAXLZCp2dEYYfQ8NaoSZiBbx8ggod1t4TvuDk+L36G5vB05O2oVJ2oQasx1b1is3Kf8Nj7o4qnWUalY7ojNdKClIZeQxG6JE0Mg4tB6xe1RdGt1vsaNYwo+lESguy2+Tjt16F43VXcCqrZzZfx6hxTa+v8f02p/e7b3NJpXKdK/1PNubw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c68f46-60a9-453c-ecd3-08d7b5f0c92c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 10:36:47.1355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MTcdMs41VFX0lGY+nNoNiN3vPQLuVUgEHFLI7Tbb6KVo4qt8DLdu76lwersxGoAqf5nfP3OE6m94Ey4BegRqRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1723
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

Ck9uIDIvMjAvMjAgOTo0MSBBTSwgTGksIERlbm5pcyB3cm90ZToKPiBbQU1EIE9mZmljaWFsIFVz
ZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldCj4KPiBIaSwgQ2hyaXN0aWFuIGFu
ZCBNb25rLAo+ICAgICAgICBXaGVuIGRvaW5nIFNETUEgY29weSwgYSBSQVMgdW5jb3JyZWN0YWJs
ZSBlcnJvciBoYXBwZW5zLCB3aGljaCB3aWxsIGNhdXNlIHRoaXMgaXNzdWUuICBUaGUgUkFTIHVu
Y29ycmVjdGFibGUgZXJyb3IgZXZlbnQgd2lsbCB0cmlnZ2VyIGRyaXZlciB0byBkbyBCQUNPIHJl
c2V0IHdoaWNoIHdpbGwgc2V0IHRoZSBzdGF0dXMgb2YgU0RNQSBzY2hlZHVsZXIgdG8gbm8gcmVh
ZHkuIEFuZCB0aGVuIGRybV9zY2hlZF9lbnRpdHlfZ2V0X2ZyZWVfc2NoZWQgd2lsbCByZXR1cm4g
TlVMTCBpbiBkcm1fc2NoZWRfZW50aXR5X3NlbGVjdF9ycSwgd2hpY2ggY2F1c2UgZW50aXR5LT5y
cSB0byBOVUxMLgoKVGhpcyBjYW4gaGFwcGVuIG9ubHkgaW4gZHJtX3NjaGVkX2pvYl9pbml0KCkg
d2hpY2ggZ2V0cyBjYWxsZWQgaW4gCmFtZGdwdV9qb2Jfc3VibWl0KCkgd2hpY2ggaXMgYWZ0ZXIg
d2hlbiB3ZSBnZXQgdGhpcyBOVUxMIHB0ciBleGNlcHRpb24uCgogwqDCoMKgwqDCoMKgwqAgZW50
aXR5ID0gcC0+ZGlyZWN0ID8gJnAtPnZtLT5kaXJlY3QgOiAmcC0+dm0tPmRlbGF5ZWQ7CiDCoMKg
wqDCoMKgwqDCoCByaW5nID0gY29udGFpbmVyX29mKGVudGl0eS0+cnEtPnNjaGVkLCBzdHJ1Y3Qg
YW1kZ3B1X3JpbmcsIHNjaGVkKTsKCiDCoMKgwqDCoMKgwqDCoCBXQVJOX09OKGliLT5sZW5ndGhf
ZHcgPT0gMCk7CiDCoMKgwqDCoMKgwqDCoCBhbWRncHVfcmluZ19wYWRfaWIocmluZywgaWIpOwog
wqDCoMKgwqDCoMKgwqAgV0FSTl9PTihpYi0+bGVuZ3RoX2R3ID4gcC0+bnVtX2R3X2xlZnQpOwog
wqDCoMKgwqDCoMKgwqAgciA9IGFtZGdwdV9qb2Jfc3VibWl0KHAtPmpvYiwgZW50aXR5LCBBTURH
UFVfRkVOQ0VfT1dORVJfVk0sIAomZik7wqAgPC0tIEhlcmUKIMKgwqDCoMKgwqDCoMKgIGlmIChy
KQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJyb3I7CgpDb3VsZCBpdCBi
ZSBwb3NzaWJsZSB0aGF0IHdlIGFyZSBkb2luZ8KgIGRybV9zY2hlZF9lbnRpdHlfaW5pdCgpIGZv
ciAKZGlyZWN0IGFuZCBpbmRpcmVjdCBlbnRpdHkgd2l0aCB6ZXJvIHNjaGVkcyBpbiBhbWRncHVf
dm1faW5pdCgpID8KCgpSZWdhcmRzLAoKTmlybW95Cgo+IEJlc3QgUmVnYXJkcwo+IERlbm5pcyBM
aQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gRnJvbTogTGl1LCBNb25rIDxNb25rLkxp
dUBhbWQuY29tPgo+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgMTksIDIwMjAgNzozMCBQTQo+
IFRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgWmhhbmcs
IEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IExpLCBEZW5uaXMgPERlbm5pcy5MaUBh
bWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRl
ciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQu
Y29tPjsgQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPgo+IFN1YmplY3Q6IOWbnuWk
jTogW1BBVENIXSBkcm0vYW1kZ3B1OiBmaXggYSBidWcgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNl
Cj4KPj4gKwlpZiAoIWVudGl0eS0+cnEpCj4+ICsJCXJldHVybiAwOwo+PiArCj4gWWVzLCBzdXBw
b3NlZGx5IHdlIHNob3VsZG4ndCBnZXQgJ2VudGl0eS0+cnEgPT0gTlVMTCcgY2FzZSAsIHRoYXQg
bG9va3MgdGhlIHRydWUgYnVnCj4KPiAtLS0tLemCruS7tuWOn+S7ti0tLS0tCj4g5Y+R5Lu25Lq6
OiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiDku6Pooagg
Q2hyaXN0aWFuIEs/bmlnCj4g5Y+R6YCB5pe26Ze0OiAyMDIw5bm0MuaciDE55pelIDE4OjUwCj4g
5pS25Lu25Lq6OiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgTGksIERl
bm5pcyA8RGVubmlzLkxpQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsg
RGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhvdTEsIFRh
byA8VGFvLlpob3UxQGFtZC5jb20+OyBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+
Cj4g5Li76aKYOiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBmaXggYSBidWcgTlVMTCBwb2ludGVy
IGRlcmVmZXJlbmNlCj4KPiBXZWxsIG9mIGhhbmQgdGhpcyBwYXRjaCBsb29rcyBsaWtlIGEgY2xl
YXIgTkFLIHRvIG1lLgo+Cj4gUmV0dXJuaW5nIHdpdGhvdXQgcmFpc2luZyBhbiBlcnJvciBpcyBj
ZXJ0YWlubHkgdGhlIHdyb25nIHRoaW5nIHRvIGRvIGhlcmUgYmVjYXVzZSB3ZSBqdXN0IGRyb3Ag
dGhlIG5lY2Vzc2FyeSBwYWdlIHRhYmxlIHVwZGF0ZXMuCj4KPiBIb3cgZG9lcyB0aGUgZW50aXR5
LT5ycSBlbmRzIHVwIGFzIE5VTEwgaW4gdGhlIGZpcnN0IHBsYWNlPwo+Cj4gUmVnYXJkcywKPiBD
aHJpc3RpYW4uCj4KPiBBbSAxOS4wMi4yMCB1bSAwNzoyNiBzY2hyaWViIFpoYW5nLCBIYXdraW5n
Ogo+PiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHld
Cj4+Cj4+IFJldmlld2VkLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+
Cj4+Cj4+IFJlZ2FyZHMsCj4+IEhhd2tpbmcKPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0K
Pj4gRnJvbTogRGVubmlzIExpIDxEZW5uaXMuTGlAYW1kLmNvbT4KPj4gU2VudDogV2VkbmVzZGF5
LCBGZWJydWFyeSAxOSwgMjAyMCAxMjowNQo+PiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmc7IERldWNoZXIsIEFsZXhhbmRlcgo+PiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47
IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPjsgWmhhbmcsCj4+IEhhd2tpbmcgPEhhd2tp
bmcuWmhhbmdAYW1kLmNvbT47IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT4KPj4g
Q2M6IExpLCBEZW5uaXMgPERlbm5pcy5MaUBhbWQuY29tPgo+PiBTdWJqZWN0OiBbUEFUQ0hdIGRy
bS9hbWRncHU6IGZpeCBhIGJ1ZyBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UKPj4KPj4gY2hlY2sg
d2hldGhlciB0aGUgcXVldWUgb2YgZW50aXR5IGlzIG51bGwgdG8gYXZvaWQgbnVsbCBwb2ludGVy
IGRlcmVmZXJlbmNlLgo+Pgo+PiBDaGFuZ2UtSWQ6IEkwOGQ1Njc3NDAxMmNmMjI5YmEyZmU3YTAx
MWMxMzU5ZThkMWUyNzgxCj4+IFNpZ25lZC1vZmYtYnk6IERlbm5pcyBMaSA8RGVubmlzLkxpQGFt
ZC5jb20+Cj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm1fc2RtYS5jCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3Nk
bWEuYwo+PiBpbmRleCA0Y2M3ODgxZjQzOGMuLjY3Y2NhNDYzZGRjYyAxMDA2NDQKPj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYwo+PiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fc2RtYS5jCj4+IEBAIC05NSw2ICs5NSw5
IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX3NkbWFfY29tbWl0KHN0cnVjdCBhbWRncHVfdm1fdXBk
YXRlX3BhcmFtcyAqcCwKPj4gICAgCWludCByOwo+PiAgICAKPj4gICAgCWVudGl0eSA9IHAtPmRp
cmVjdCA/ICZwLT52bS0+ZGlyZWN0IDogJnAtPnZtLT5kZWxheWVkOwo+PiArCWlmICghZW50aXR5
LT5ycSkKPj4gKwkJcmV0dXJuIDA7Cj4+ICsKPj4gICAgCXJpbmcgPSBjb250YWluZXJfb2YoZW50
aXR5LT5ycS0+c2NoZWQsIHN0cnVjdCBhbWRncHVfcmluZywgc2NoZWQpOwo+PiAgICAKPj4gICAg
CVdBUk5fT04oaWItPmxlbmd0aF9kdyA9PSAwKTsKPj4gLS0KPj4gMi4xNy4xCj4+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+IGFtZC1nZnggbWFpbGlu
ZyBsaXN0Cj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+IGh0dHBzOi8vbmFtMTEu
c2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3QK
Pj4gcy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtk
YXRhPTAyJTdDMDElN0Ntbwo+PiBuay5saXUlNDBhbWQuY29tJTdDMjhlNzI2MGFmM2EyNGVlYzc1
OGYwOGQ3YjUyOTc1ZTMlN0MzZGQ4OTYxZmU0ODg0ZTYwCj4+IDhlMTFhODJkOTk0ZTE4M2QlN0Mw
JTdDMCU3QzYzNzE3NzA2MjAwMzIxMzQzMSZhbXA7c2RhdGE9dk1YbWh3VGxOOGxBYXYKPj4gdXFo
WWhwbUtMTTZWJTJGJTJCMiUyRnViRkJic2slMkJHWSUyQmp3JTNEJmFtcDtyZXNlcnZlZD0wCj4g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4
IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9u
YW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJG
bGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7
ZGF0YT0wMiU3QzAxJTdDbmlybW95LmRhcyU0MGFtZC5jb20lN0MzYWY5NDBkYjYxZGQ0NzRlYjNm
NjA4ZDdiNWUwYTVjYiU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAl
N0M2MzcxNzc4NDg3ODg0MDgyMjAmYW1wO3NkYXRhPVFpS0ZiNUtBSTIxRzQlMkI1T2lOeGYyMk9J
bG1TdTAwNzh4aEZxdURWcklYQSUzRCZhbXA7cmVzZXJ2ZWQ9MAo+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnBy
b3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9w
Lm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q25p
cm1veS5kYXMlNDBhbWQuY29tJTdDM2FmOTQwZGI2MWRkNDc0ZWIzZjYwOGQ3YjVlMGE1Y2IlN0Mz
ZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTc3ODQ4Nzg4NDA4
MjIwJmFtcDtzZGF0YT1RaUtGYjVLQUkyMUc0JTJCNU9pTnhmMjJPSWxtU3UwMDc4eGhGcXVEVnJJ
WEElM0QmYW1wO3Jlc2VydmVkPTAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
