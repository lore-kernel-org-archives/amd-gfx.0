Return-Path: <SRS0=khk6=AO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A265C433E1
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 06:05:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 275FA20870
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 06:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cD/4R3NX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275FA20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 929AC6E8C8;
	Fri,  3 Jul 2020 06:05:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA9B46E8C8
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2020 06:05:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGCakMrBaTo+hAfKMbD+TCgi7SyscImCoNiestmioZySsrgVC8G4XKCZSgVSVJgnRefE87RtHKd5TpiZcLxPHhssKrBUC7lZOlCQp5ysNX345YDq7+itpJT4Ga8Q4cbBCi5Ei+jpJxJuyH0z/RRvGok2LQCi/Iu0NVgSgufWFJArZBax5gwqG1OQ5o/3/fEnPYOHv2AxDYuL56PYl88/Qd7z2cwc41SYigr077GqQ+h5FLiV35Cq8iGk1Xj7vov3K5bYgVlZ947sOT3EDW0wndc7KPD7Q7WI+3gWvuZ9f7/EnzD6qwFdqyfZv36hqqbmAXuOt0/j6hB9u2AoDFbPBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4urY/dBNSBryxIzyNz3lhaCYiXim5jVqp30Imiiq/8U=;
 b=ghBUm2DeaBHHss622PrwS4N+BTAMrBrMqjv7iQXsYwOA6gr73dPEU2tiH/FFZPVgI/3Op4+lF6lmEdhX5KedC+fLC0Dy5ZNgMeOfk9BpFWn7C7DXDJNn+q0KH2g2pj9ryp//8gRJn4Mnq7NyACKPJs+imgTcYkhQUltyrdkJuf0ADL/qHttCbFVdF3LzlWzMk1b8uf7ChaiL9P0Y5zMw26pcYUUZzM0tP11WeL92ceYBve7UUpfathN2aSd7s8hN9zvcQxZmlr0ZLwoe2c1lky7G3KLIDGh4e8p6W+NwZ+eIUjmClmDsBE+PHk/+SqwHNP0Qr3yVX1Cz51Fsn+HY4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4urY/dBNSBryxIzyNz3lhaCYiXim5jVqp30Imiiq/8U=;
 b=cD/4R3NXFesrOrYaVdfKRwVttuH6kOrSEKACg/to9f6yM9TEotUoXsTIX/aTOF/yNmw/HpMqgMxbgo9HslEFr78ayDM5YAH9sXs0aTi8qUmT5dYwGEn5tY/UiWNL2CCbf14uUTeLto2r94IQzxETb9yp5X40bldcN9Efwr+WodE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Fri, 3 Jul
 2020 06:05:46 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::180c:9e60:d3cd:e89d]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::180c:9e60:d3cd:e89d%3]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 06:05:46 +0000
Subject: Re: [PATCH] drm/amdgpu: return an error for hw access in INFO ioctl
 when in reset
To: "Li, Dennis" <Dennis.Li@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20200626140423.1425349-1-alexander.deucher@amd.com>
 <CADnq5_MzKqWxOdzGSVUWU3cJaXwXNNB3T0igMP8dyRpLMGpgEw@mail.gmail.com>
 <50d38fa7-5efd-e6ec-d3bd-313cc0138666@gmail.com>
 <DM5PR12MB253318A2BF34A961F75176C0ED6C0@DM5PR12MB2533.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <ba40ec07-b7b3-4b12-283b-d001a3adbc74@amd.com>
Date: Fri, 3 Jul 2020 02:05:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <DM5PR12MB253318A2BF34A961F75176C0ED6C0@DM5PR12MB2533.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::28) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.53.25) by
 YTXPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.21 via Frontend Transport; Fri, 3 Jul 2020 06:05:45 +0000
X-Originating-IP: [142.117.53.25]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ff70b203-883a-47b2-1e53-08d81f172057
X-MS-TrafficTypeDiagnostic: SA0PR12MB4365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4365D94982B8B15E6DDB5AA8926A0@SA0PR12MB4365.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +MYk9OzgwulBOZSyhaLdl+XAdKwJtLE3FmJedOUmApAhbrDMinWlj7RvlwDKywUaYH0QXMvcjewRrU+5qPiEt/spbdcX3+pPY6aQ1WM565Wd0yE/FSYJuxMQ7sESMSMcBcNkN5f7kfIf4Ad7G1PX0tRR9RGpY3RoJhTXvJrCOXcmVONofxoaNoolJL9ZjOzoNi6Q1SSQm6XjETsMuA7mwsNRaFRKPLLDRgsP3Qq0+RZwsZDeRbwIcicTa/7DiXn+azGQRhVQfI3InVh4I3G4Aul+Byuf8FhjRxbSms7QZTALnjgvXGjN5qjXGJ4Jt2Hf04BRViUtoeibgW7V7qMMbWhWqr9lNkD/NSX75FX1S97aUJ8qqpw4V6yepbCfHx1yW7wJZIE2T46WekL7QMBezptZzwI+xQ+Dgv3tZLdxusE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(2906002)(66476007)(66556008)(16526019)(16576012)(26005)(8936002)(966005)(66946007)(478600001)(31686004)(44832011)(4326008)(52116002)(31696002)(36756003)(186003)(316002)(86362001)(66574015)(83380400001)(8676002)(53546011)(2616005)(956004)(6486002)(5660300002)(110136005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ZIi23iCswH1CbL89AmxUwTeGnQocMKs39KTmv/yoZZFNL8teLrvCsf9HYFym6lyVA54xB7xwXr65ziTXx63vK8o14gw0kh6LJfzF9LOxQYuYysrktS5LAGS0xTXDkBCB+xP9wrnFBWB0mV7F49LkD9mjxa0+1EOmtvwk0vqfNyfH517YJgNcBqa29Wz3FVwZ/wrI34JsXpP2c8MaG8Hj2GA4bbxtzkVolVWYm1ECh3RyEMo3tmkGGUnKQcBW029w6RV+QOCCFqRF7PkXU3lLen55zBdJS3HemJZ4gFqUcJ7V84Bb3b4weKUn4Ulf0j0Y49WwYrkbef2Z8RJeOOTjqhxr1RiXeDe/NU6VOEbe1xFDLP8iqiXXtHS3qM0z5nqBV8vQ/QITPSOwWmCZITxffwSt1UoW0FNYiIkSbkPJGVt5sAo44Bb/cqD6fbvk7ibSgXWLwXweQvGXmskTiI1lL3YztyF0oUWdhZVGB9VqZGw=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff70b203-883a-47b2-1e53-08d81f172057
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 06:05:46.2153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+qkEBDs70MrzUUS5JljemTvg2jb3ShE/Sz1N0ORRHL+y0lJCve7BIS97UITpaVmT4TVaf14bEHPkpIb/O67LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CkFtIDIwMjAtMDctMDEgdW0gMTA6MzQgYS5tLiBzY2hyaWViIExpLCBEZW5uaXM6Cj4gW0FNRCBP
ZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQo+Cj4gSGksIENo
cmlzdGlhbiBhbmQgQWxleAo+ICAgICAgIE5vdCBvbmx5IGFtZGdwdSBpb2N0bHMsIGJ1dCBhbWRr
ZmQgaW9jdGxzIGFsc28gaGF2ZSB0aGUgc2FtZSBpc3N1ZS4gCgpNb3N0IEtGRCBpb2N0bHMgZG9u
J3QgYWNjZXNzIEhXIGRpcmVjdGx5LiBUaGUgb25seSBwbGFjZSB0aGF0IGludGVyYWN0cwp3aXRo
IEhXIGluIEtGRCBpcyB0aGUgZGV2aWNlIHF1ZXVlcyBtYW5hZ2VyIChEUU0pIGFuZCBiZW5lYXRo
IGl0IHRoZQpwYWNrZXQgbWFuYWdlci4gSW4gRFFNIHdlIGFscmVhZHkgaGF2ZSBwcm90ZWN0aW9u
cyB0byBhdm9pZCBIVyBhY2Nlc3MKd2hpbGUgYSByZXNldCBpcyBpbiBwcm9ncmVzcy4KCkZvciBv
dGhlciBIVyBhY2Nlc3MsIEtGRCBnb2VzIHRocm91Z2ggaGVscGVyIGZ1bmN0aW9ucyBpbiBhbWRn
cHUuCgpNZW1vcnkgbWFuYWdlbWVudCBpb2N0bHMgaW5kaXJlY3RseSBhY2Nlc3MgSFcgZm9yIHBh
Z2UgdGFibGUgdXBkYXRlcy4KSG93ZXZlciwgdGhhdCByZXF1aXJlcyB2YWxpZGF0aW5nIHRoZSBw
YWdlIHRhYmxlIEJPcyBmaXJzdC4gQXJlIFZSQU0gQk9zCmNvbnNpZGVyZWQgInZhbGlkIiBkdXJp
bmcgYSBHUFUgcmVzZXQ/IFdoZW4gdXNpbmcgU0RNQSBmb3IgcGFnZSB0YWJsZQp1cGRhdGVzLCB0
aGUgRFJNIEdQVSBzY2hlZHVsZXIgaXMgYWxzbyBpbnZvbHZlZC4gSXMgdGhhdCBzdXNwZW5kZWQK
ZHVyaW5nIGEgR1BVIHJlc2V0PwoKVGhlIG9ubHkgb3RoZXIgS0ZEIGlvY3RsIHRoYXQgbG9va3Mg
bGlrZSBpdCBtaWdodCBhY2Nlc3MgSFcgZHVyaW5nIGEgR1BVCnJlc2V0IGlzIGtmZF9pb2N0bF9n
ZXRfY2xvY2tfY291bnRlcnMgYnkgY2FsbGluZwphbWRncHVfYW1ka2ZkX2dldF9ncHVfY2xvY2tf
Y291bnRlci4KClJlZ2FyZHMsCsKgIEZlbGl4CgoKCj4KPiBCZXN0IFJlZ2FyZHMKPiBEZW5uaXMg
TGkKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IGFtZC1nZnggPGFtZC1nZngt
Ym91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBDaHJpc3RpYW4gS8O2
bmlnCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDEsIDIwMjAgNDoyMCBQTQo+IFRvOiBBbGV4IERl
dWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT47IGFtZC1nZnggbGlzdCA8YW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmc+Cj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRl
dWNoZXJAYW1kLmNvbT4KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiByZXR1cm4g
YW4gZXJyb3IgZm9yIGh3IGFjY2VzcyBpbiBJTkZPIGlvY3RsIHdoZW4gaW4gcmVzZXQKPgo+IEkg
ZG9uJ3QgdGhpbmsgdGhpcyBpcyBhIGdvb2QgaWRlYSwgd2Ugc2hvdWxkIHByb2JhYmx5IHJhdGhl
ciB3YWl0IGZvciB0aGUgR1BVIHJlc2V0IHRvIGZpbmlzaCBieSB0YWtpbmcgdGhlIGFwcHJvcHJp
YXRlIGxvY2suCj4KPiBDaHJpc3RpYW4uCj4KPiBBbSAwMS4wNy4yMCB1bSAwNzozMyBzY2hyaWVi
IEFsZXggRGV1Y2hlcjoKPj4gcGluZz8KPj4KPj4gT24gRnJpLCBKdW4gMjYsIDIwMjAgYXQgMTA6
MDQgQU0gQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+IHdyb3RlOgo+Pj4gV2hl
biB0aGUgR1BVIGlzIGluIHJlc2V0LCBhY2Nlc3NpbmcgdGhlIGh3IGlzIHVucmVsaWFibGUgYW5k
IGNvdWxkIAo+Pj4gaW50ZXJmZXJlIHdpdGggdGhlIHJlc2V0LiAgUmV0dXJuIGFuIGVycm9yIGlu
IHRob3NlIGNhc2VzLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFu
ZGVyLmRldWNoZXJAYW1kLmNvbT4KPj4+IC0tLQo+Pj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfa21zLmMgfCA2ICsrKysrKwo+Pj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9rbXMuYyAKPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2tt
cy5jCj4+PiBpbmRleCAzNDFkMDcyZWRkOTUuLmZkNTFkNjU1NGVlMiAxMDA2NDQKPj4+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYwo+Pj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jCj4+PiBAQCAtNjg0LDYgKzY4NCw5IEBA
IHN0YXRpYyBpbnQgYW1kZ3B1X2luZm9faW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9p
ZCAqZGF0YSwgc3RydWN0IGRybV9maWxlCj4+PiAgICAgICAgICAgICAgICAgIGlmIChpbmZvLT5y
ZWFkX21tcl9yZWcuY291bnQgPiAxMjgpCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIC1FSU5WQUw7Cj4+Pgo+Pj4gKyAgICAgICAgICAgICAgIGlmIChhZGV2LT5pbl9ncHVfcmVz
ZXQpCj4+PiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVQRVJNOwo+Pj4gKwo+Pj4g
ICAgICAgICAgICAgICAgICByZWdzID0ga21hbGxvY19hcnJheShpbmZvLT5yZWFkX21tcl9yZWcu
Y291bnQsIHNpemVvZigqcmVncyksIEdGUF9LRVJORUwpOwo+Pj4gICAgICAgICAgICAgICAgICBp
ZiAoIXJlZ3MpCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07IEBA
IC04NTQsNiArODU3LDkgQEAgc3RhdGljIAo+Pj4gaW50IGFtZGdwdV9pbmZvX2lvY3RsKHN0cnVj
dCBkcm1fZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEsIHN0cnVjdCBkcm1fZmlsZQo+Pj4gICAgICAg
ICAgICAgICAgICBpZiAoIWFkZXYtPnBtLmRwbV9lbmFibGVkKQo+Pj4gICAgICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiAtRU5PRU5UOwo+Pj4KPj4+ICsgICAgICAgICAgICAgICBpZiAoYWRl
di0+aW5fZ3B1X3Jlc2V0KQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FUEVS
TTsKPj4+ICsKPj4+ICAgICAgICAgICAgICAgICAgc3dpdGNoIChpbmZvLT5zZW5zb3JfaW5mby50
eXBlKSB7Cj4+PiAgICAgICAgICAgICAgICAgIGNhc2UgQU1ER1BVX0lORk9fU0VOU09SX0dGWF9T
Q0xLOgo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgIC8qIGdldCBzY2xrIGluIE1oeiAqLwo+
Pj4gLS0KPj4+IDIuMjUuNAo+Pj4KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KPj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKPj4gaHR0cHM6Ly9saXN0Cj4+IHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo+PiBubmlzLkxpJTQwYW1kLmNvbSU3Q2VmZWVkYTRiNmQxOTQ2
NjBmYmM1MDhkODFkOTc5MWEzJTdDM2RkODk2MWZlNDg4NGU2Cj4+IDA4ZTExYTgyZDk5NGUxODNk
JTdDMCU3QzAlN0M2MzcyOTE4ODQxMjMzNjAzNDAmYW1wO3NkYXRhPUdOUFdRTm5kVUpLeDcKPj4g
NzBmRFR1UkdCbkp6Zm1SVVFqRDRCMUhCaWUzeFVRJTNEJmFtcDtyZXNlcnZlZD0wCj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxp
bmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
