Return-Path: <SRS0=FRS3=EE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4957C4363A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2020 17:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7F620759
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2020 17:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Kj+ryTnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7F620759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C6C589D2E;
	Thu, 29 Oct 2020 17:14:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7CC96E8A7
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2020 17:14:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBN62ByK3nyDoJF4XvWtyJp0oRkupn/TUaP0VHGNj7B+M32gDmum6j9r+6KOXQxPmxB+QhnLVUAmWT9TUzfekpKEBVxCEltydwGS/U0o3VH1rb/lQBLqpzbwAfwook+oYe9oK5RRemwQGwiNHyZn0jIrV3xMwUwxr/Ip9xlJke+Gv1f4fSqDogtv0Zl46aNnoOLnqZ6B3Vn1eU167/uRZd7LSnKAuUH9l0UjN3Qd+Hhi8KoGpKO9ZNrQhd8zEkMfvXcfWdaFa5ViXIo+XrGWoCsTFaDVTcxrOBLBZVPVTejLC13pIdb2vXdZ0w0om3Ng2fjWJeDXQ2ERY4nGPTlBpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktLrYgzp5CcrjI9ivn1qlSXzB2s8txIvJ+pFvOnlndI=;
 b=ToaKrCLE6IJFcFqrs/k7XPskw3AXy9Gke6QWB4qFPUXFBh2JSOBtreFU7l5GbIlzb4PP1AMmp9hMvmglX7teh8/2tyz6XTZDryiQHa2LtinQ9YHD6I8JBvdXXhmRNaPw4GmDTVVa5ZzZRSsfc5pvSTBHi2iOxM/HNH6g2yHRgdjG0fBtDx/g0NoPBCyEQk7fxecDCRnzAyzzfSArJutIa1s8ZNNs5dp33jwAPvmfOzxana7C+UG5DQBaaCbj2okIMjAVCGd4Ui6HxrX04l2zWEam+e8qlEbyduWynNSsoI7k115rnQkllR67cobrrrTC7ESpOuLT756vQ6nDu5pifw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktLrYgzp5CcrjI9ivn1qlSXzB2s8txIvJ+pFvOnlndI=;
 b=Kj+ryTnPSSSyQ3y0HTS9NgNpY65rpGxEuKdkjZxP5BkaGxv8WLjlO1mV995h0gH3UpVzmTh2ib8WubBpE5Q+330Zp0qqDvPYnhxWvgoq7NUxrfYNoJ1ab6yXu9wrd4ouZ8Om9B4g+uS1PupDno71jIFiMcEYo18J7imchzCDyDc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 29 Oct
 2020 17:14:53 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::935:a67:59f8:7067]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::935:a67:59f8:7067%7]) with mapi id 15.20.3499.027; Thu, 29 Oct 2020
 17:14:53 +0000
Subject: Re: [PATCH] drm/amdgpu: Add kernel parameter to force no xgmi
To: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20201028145502.2703-1-alex.sierra@amd.com>
 <7d27dd5f-e178-188a-6537-6b4d6d31b205@gmail.com>
 <4306b2ef-736c-57a3-4110-6fb953fb76d4@amd.com>
 <SA0PR12MB44307151BBED365DF7BB440AFD170@SA0PR12MB4430.namprd12.prod.outlook.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <47fceadf-fe94-e35c-b8af-ec97b3563008@amd.com>
Date: Thu, 29 Oct 2020 13:14:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <SA0PR12MB44307151BBED365DF7BB440AFD170@SA0PR12MB4430.namprd12.prod.outlook.com>
Content-Language: en-CA
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YT1PR01CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::8) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.35.64] (165.204.54.211) by
 YT1PR01CA0069.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Thu, 29 Oct 2020 17:14:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9ed96df4-94a5-4bdd-aec6-08d87c2e266f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4385:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4385A56069A010499F84A50499140@DM6PR12MB4385.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uuu4zEKhn/7ancO7ppUU9IKQcgHz/Bv92r85auQCldQTnT8Y8US1mBrNpGtERED4phGVpvZs5YFON2KJ7v56EAgDWqwKfJ7dJZlN8VQXujzYsr1gfe5QO0zanrm0j+qHaxaKVnIi0zO5cg/mJk6SPTlhM1+PnY1B2NSns0uCVUoluF7SjGc2Bfv0R9XtsRXx9lqZ3Eql52xw4ZYcBgvaJi5rVHHU8CEsuQmVMSvb+PF/rmmz1E4XDE+7njUljHwt+TQPeG8jMsuR6VKzpM9d7pHK2lolWyg5Z1zd/kYY0/7/DPZQuD0L8m1DaoBdJs/itbOoWkxPjRrk7jIaRg12T7GndBV8tgOrrl2sl4ZfYlBnTTy41kcDr0rV2AUAOUKS8Z5nytv03uOmyVm1AZN06nbberjn+qp1QPT3XgfDtrrAX0fRPREaMs6gZy9r/BwzvrSS6EQOES7EA5uGgWpGhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(66574015)(66476007)(36756003)(8936002)(66946007)(66556008)(86362001)(4001150100001)(5660300002)(6486002)(8676002)(966005)(83380400001)(31686004)(53546011)(44832011)(478600001)(45080400002)(31696002)(52116002)(110136005)(26005)(2906002)(2616005)(956004)(16576012)(316002)(186003)(16526019)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: O5ENgcP8AFNAEnn6Geroxep8h5l5XaX02bo4D7yYiqXH6RxtzSxS51awES7X3zIOEC9CnRO++fjTErmo75k1B6YVC2ijGHtwI/8slsGhD31F/2+EwwvQwnKb52OkOguzOSXEe3IqlDKNa+7uT1CfjbWx1G5KLpmOli4gmvnHkH7n7NOvIiHny1uHcy/7h9a6hpKuA5uLuuaHBkEF+TUXPi7cIX8/MJWXrTINpYZsCaaHqHQzL//VLdpfLBm3T7nc9KYpSwOHG/svgB1ivzEzjiHSOdxkjP7NVUmFKuXY0kZhumci5p3b0ICUbytTJ5mPonDlkaOldkuOUXXMLWActUDweSAWBxo/ItG2FBuMFMC6NKrerSCWNdI66ChS+uyyL2g/vzR/m659UQ1acUBnXjoV+t5QaurS9IajWSrlz/ybaks7x9Qv1y19yGhvSGVM6RRK37/JvB8LZhpuMqaM7pJeFGWA/iKvB1E3mKTUT8eLWF9HrfTWfmMYaruejdKB8sZpLYcsRKKe8Kl6DMWUF/Tgr6XJqVrDv8xErW56+Tjl30ESWkGv7yIKakYJG+jJrNNEnogVCHvp0UPX5oNQlbZE0EgaACJBv0Is6xE0QFwsLNUNQ+zcme9LcaFJLf+9DnyKJZK3zHszgHdu5R7CaA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed96df4-94a5-4bdd-aec6-08d87c2e266f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2020 17:14:53.0716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qW5ri1RHgf4gmqTvEF4ayTJIJ6a0/sLgZMRTWiXO0aCvQqpDHeHgB4K8ymP7l3bT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385
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

T24gMjAyMC0xMC0yOCAxNTowOSwgU2llcnJhIEd1aXphLCBBbGVqYW5kcm8gKEFsZXgpIHdyb3Rl
Ogo+IFtBTUQgUHVibGljIFVzZV0KPiAKPiBQbGVhc2UgaWdub3JlIHRoaXMgcGF0Y2gsIGl0IHNo
b3VsZCBiZSBpbiBhIGRpZmZlcmVudCBicmFuY2guIEFzIFBDSWUgcDJwIGlzIG5vdCBzdXBwb3J0
ZWQgaW4gdXBzdHJlYW0uCgpObyBwcm9ibGVtLCBidXQgaWYgeW91IGRvIGFkZCBpdCBlbHNld2hl
cmUsIHBsZWFzZSB1c2Ugc29tZXRoaW5nIG1vcmUgc3BlY2lmaWMsIGxpa2UKCglhbWRncHVfeGdt
aV9wMnAKCmFzIHRoZSAocG9zaXRpdmUtY29udHJvbGxlZCkgZmxhZywgc2luY2UgbW9yZSBnZW5l
cmljIGZsYWdzIGNvdWxkIGJlIGFkZGVkIGxhdGVyLAp0byBjb250cm9sIGEgbW9yZSBlbmNvbXBh
c3NpbmcgYmVoYXZpb3VyLgoKUmVnYXJkcywKTHViZW4KCj4gCj4gUmVnYXJkcywKPiBBbGV4IFNp
ZXJyYQo+IAo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+PiBGcm9tOiBhbWQtZ2Z4IDxh
bWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YKPj4gU2ll
cnJhIEd1aXphLCBBbGVqYW5kcm8gKEFsZXgpCj4+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAy
OCwgMjAyMCAxOjA5IFBNCj4+IFRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5p
Z0BhbWQuY29tPjsgYW1kLQo+PiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+IFN1YmplY3Q6
IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IEFkZCBrZXJuZWwgcGFyYW1ldGVyIHRvIGZvcmNlIG5v
IHhnbWkKPj4KPj4KPj4gT24gMTAvMjgvMjAyMCA5OjU4IEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdy
b3RlOgo+Pj4gQW0gMjguMTAuMjAgdW0gMTU6NTUgc2NocmllYiBBbGV4IFNpZXJyYToKPj4+PiBC
eSBlbmFibGluZyB0aGlzIHBhcmFtZXRlciwgdGhlIHN5c3RlbSB3aWxsIGJlIGZvcmNlZCB0byB1
c2UgcGNpZQo+Pj4+IGludGVyZmFjZSBvbmx5IGZvciBwMnAgdHJhbnNhY3Rpb25zLgo+Pj4KPj4+
IEJldHRlciBuYW1lIHRoYXQgYW1kZ3B1X3hnbWkgd2l0aCBhIGRlZmF1bHQgdmFsdWUgb2YgZW5h
YmxlZC4KPj4+Cj4+PiBPciBtYXliZSBhZGQgYW5vdGhlciBiaXQgdmFsdWUgZm9yIGFtZGdwdV92
bV9kZWJ1ZyBpbnN0ZWFkLgo+Pgo+PiBBY2sKPj4KPj4gUmVnYXJkcywKPj4gQWxleCBTaWVycmEK
Pj4KPj4+Cj4+Pgo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogQWxleCBTaWVycmEgPGFsZXguc2ll
cnJhQGFtZC5jb20+Cj4+Pj4gLS0tCj4+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1LmjCoMKgwqDCoMKgwqDCoCB8IDEgKwo+Pj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDIgKy0KPj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZHJ2LmPCoMKgwqAgfCA5ICsrKysrKysrKwo+Pj4+IMKgIDMgZmlsZXMg
Y2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pj4+Cj4+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCj4+Pj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaAo+Pj4+IGluZGV4IGJhNjVkNGYyYWI2Ny4uMzY0
NWYwMGU5ZjYxIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdS5oCj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKPj4+
PiBAQCAtMTg4LDYgKzE4OCw3IEBAIGV4dGVybiBpbnQgYW1kZ3B1X2Rpc2NvdmVyeTsKPj4+PiDC
oCBleHRlcm4gaW50IGFtZGdwdV9tZXM7Cj4+Pj4gwqAgZXh0ZXJuIGludCBhbWRncHVfbm9yZXRy
eTsKPj4+PiDCoCBleHRlcm4gaW50IGFtZGdwdV9mb3JjZV9hc2ljX3R5cGU7Cj4+Pj4gK2V4dGVy
biBpbnQgYW1kZ3B1X2ZvcmNlX25vX3hnbWk7Cj4+Pj4gwqAgI2lmZGVmIENPTkZJR19IU0FfQU1E
Cj4+Pj4gwqAgZXh0ZXJuIGludCBzY2hlZF9wb2xpY3k7Cj4+Pj4gwqAgZXh0ZXJuIGJvb2wgZGVi
dWdfZXZpY3Rpb25zOwo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGV2aWNlLmMKPj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYwo+Pj4+IGluZGV4IDFmZTg1MGUwYTk0ZC4uMGE1ZDk3YTg0MDE3IDEwMDY0NAo+
Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+Pj4+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+Pj4+IEBA
IC0yMjU3LDcgKzIyNTcsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9kZXZpY2VfaXBfaW5pdChzdHJ1
Y3QKPj4+PiBhbWRncHVfZGV2aWNlICphZGV2KQo+Pj4+IMKgwqDCoMKgwqAgaWYgKHIpCj4+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gaW5pdF9mYWlsZWQ7Cj4+Pj4gwqAgLcKgwqDCoCBpZiAo
YWRldi0+Z21jLnhnbWkubnVtX3BoeXNpY2FsX25vZGVzID4gMSkKPj4+PiArwqDCoMKgIGlmICgh
YW1kZ3B1X2ZvcmNlX25vX3hnbWkgJiYgYWRldi0KPj4+IGdtYy54Z21pLm51bV9waHlzaWNhbF9u
b2RlcyA+Cj4+Pj4gKzEpCj4+Pgo+Pj4gTWhtLCB0aGlzIHdpbGwgbW9zdCBsaWtlbHkgY2F1c2Ug
cHJvYmxlbXMuIFlvdSBzdGlsbCBuZWVkIHRvIGFkZCB0aGUKPj4+IGRldmljZSB0byB0aGUgaGl2
ZSBiZWNhdXNlIG90aGVyd2lzZSBHUFUgd29uJ3Qgd29yay4KPj4KPj4gV2hhdCBraW5kIG9mIHBy
b2JsZW1zPyBTbyBmYXIsIEkgaGF2ZSB2YWxpZGF0ZWQgdGhpcyB1c2luZyBhIHN5c3RlbSB3aXRo
Cj4+IG11bHRpcGxlIGRldmljZXMgYW5kIHJ1bm5pbmcgLi9yb2NtX2JhbmR3aWR0aF90ZXN0IC10
LiBXaXRoIGFuZCB3aXRob3V0Cj4+IHRoZSBwYXJhbWV0ZXIgc2V0Lgo+Pgo+PiBSZWdhcmRzLAo+
PiBBbGV4IFNpZXJyYQo+Pgo+Pj4KPj4+IEFwYXJ0IGZyb20gdGhhdCBzb3VuZHMgbGlrZSBhIGdv
b2QgaWRlYSBpbiBnZW5lcmFsLgo+Pj4KPj4+IENocmlzdGlhbi4KPj4+Cj4+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgIGFtZGdwdV94Z21pX2FkZF9kZXZpY2UoYWRldik7Cj4+Pj4gwqDCoMKgwqDCoCBh
bWRncHVfYW1ka2ZkX2RldmljZV9pbml0KGFkZXYpOwo+Pj4+IMKgIGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPj4+PiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwo+Pj4+IGluZGV4IDRiNzhlY2ZkMzVmNy4uMjI0ODUw
NjdjZjMxIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kcnYuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYu
Ywo+Pj4+IEBAIC0xNjAsNiArMTYwLDcgQEAgaW50IGFtZGdwdV9mb3JjZV9hc2ljX3R5cGUgPSAt
MTsKPj4+PiDCoCBpbnQgYW1kZ3B1X3RteiA9IDA7Cj4+Pj4gwqAgaW50IGFtZGdwdV9yZXNldF9t
ZXRob2QgPSAtMTsgLyogYXV0byAqLwo+Pj4+IMKgIGludCBhbWRncHVfbnVtX2tjcSA9IC0xOwo+
Pj4+ICtpbnQgYW1kZ3B1X2ZvcmNlX25vX3hnbWkgPSAwOwo+Pj4+IMKgIMKgIHN0cnVjdCBhbWRn
cHVfbWdwdV9pbmZvIG1ncHVfaW5mbyA9IHsKPj4+PiDCoMKgwqDCoMKgIC5tdXRleCA9IF9fTVVU
RVhfSU5JVElBTElaRVIobWdwdV9pbmZvLm11dGV4KSwKPj4+PiBAQCAtNTIyLDYgKzUyMywxNCBA
QCBtb2R1bGVfcGFyYW1fbmFtZWQocmFzX2VuYWJsZSwKPj4+PiBhbWRncHVfcmFzX2VuYWJsZSwg
aW50LCAwNDQ0KTsKPj4+PiDCoCBNT0RVTEVfUEFSTV9ERVNDKHJhc19tYXNrLCAiTWFzayBvZiBS
QVMgZmVhdHVyZXMgdG8gZW5hYmxlCj4+IChkZWZhdWx0Cj4+Pj4gMHhmZmZmZmZmZiksIG9ubHkg
dmFsaWQgd2hlbiByYXNfZW5hYmxlID09IDEiKTsKPj4+PiDCoCBtb2R1bGVfcGFyYW1fbmFtZWQo
cmFzX21hc2ssIGFtZGdwdV9yYXNfbWFzaywgdWludCwgMDQ0NCk7Cj4+Pj4gwqAgKy8qKgo+Pj4+
ICsgKiBET0M6IGZvcmNlX25vX3hnbWkgKHVpbnQpCj4+Pj4gKyAqIEZvcmNlcyBub3QgdG8gdXNl
IHhnbWkgaW50ZXJmYWNlICgwID0gZGlzYWJsZSwgMSA9IGVuYWJsZSkuCj4+Pj4gKyAqIERlZmF1
bHQgaXMgMCAoZGlzYWJsZWQpLgo+Pj4+ICsgKi8KPj4+PiArTU9EVUxFX1BBUk1fREVTQyhmb3Jj
ZV9ub194Z21pLCAiRm9yY2Ugbm90IHRvIHVzZSB4Z21pCj4+IGludGVyZmFjZSIpOwo+Pj4+ICtt
b2R1bGVfcGFyYW1fbmFtZWQoZm9yY2Vfbm9feGdtaSwgYW1kZ3B1X2ZvcmNlX25vX3hnbWksIGlu
dCwKPj4gMDYwMCk7Cj4+Pj4gKwo+Pj4+IMKgIC8qKgo+Pj4+IMKgwqAgKiBET0M6IHNpX3N1cHBv
cnQgKGludCkKPj4+PiDCoMKgICogU2V0IFNJIHN1cHBvcnQgZHJpdmVyLiBUaGlzIHBhcmFtZXRl
ciB3b3JrcyBhZnRlciBzZXQgY29uZmlnCj4+Pj4gQ09ORklHX0RSTV9BTURHUFVfU0kuIEZvciBT
SSBhc2ljLCB3aGVuIHJhZGVvbiBkcml2ZXIgaXMgZW5hYmxlZCwKPj4+Cj4+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+IGFtZC1nZnggbWFpbGluZyBs
aXN0Cj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+IGh0dHBzOi8vbmFtMTEuc2Fm
ZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLgo+
PiBmcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtCj4+IGdmeCZhbXA7
ZGF0YT0wNCU3QzAxJTdDYWxleC5zaWVycmElNDBhbWQuY29tJTdDNmEyZTM0NDI3ZmI0NDk4NjUK
Pj4gOTEyMDhkODdiNmM4YzA1JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0Mw
JTdDMCU3QzYzCj4+IDczOTUwNTM0NTczNDc2MzMlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlK
V0lqb2lNQzR3TGpBd01ECj4+IEFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pY
VkNJNk1uMCUzRCU3QzMwMDAmYW1wO3NkYXRhPQo+PiBzMmhYVkFWRnRISnNOTkJ3aHp6S0RqTWxF
akVTOXVOR2JZaTZHZGVENWNjJTNEJmFtcDtyZXNlcnZlZD0wCj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJv
dGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Au
b3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wNCU3QzAxJTdDbHVi
ZW4udHVpa292JTQwYW1kLmNvbSU3Q2VkZDQ3OWY0OTVmZjQyYzMwNTk0MDhkODdiNzUwNzBiJTdD
M2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzM5NTA4OTg4Mjk2
NjM3NSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9p
VjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT1L
M0FLRDV0YnI4MndWTVpES2xDaVZPMVAzTWtWJTJGeXJ5cXhGM0t5T2wxdVUlM0QmYW1wO3Jlc2Vy
dmVkPTAKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
