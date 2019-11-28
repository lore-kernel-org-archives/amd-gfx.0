Return-Path: <SRS0=UwKb=ZU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F51EC432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 20:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1806721781
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 20:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1806721781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFF966E037;
	Thu, 28 Nov 2019 20:30:29 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750070.outbound.protection.outlook.com [40.107.75.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 244546E037
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2019 20:30:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6kIj7ZYcUOl2WRKpHholYeEiME0iksqYZcfXOB4F4u647mUxh3WKFjiQ9bad8KS2K9KwwGwEyKNJkOfp/LaRH8Ak+2Z1gWlnQkiWkst4OzVbARM56pHWlj3N2J5JvKbmxbwnd1fHCZqIK1oAgnXZZaW6C+rtMIAGV8GKX9/i35magPEoaqpBXkoVNGf+XDM4d3cPpDlg/LwQ9jE3c3PURmVwBQ+ju87HhzuvFABX1eJrh70nUMVZJ5Vmz+TLtJNxMuHAesP54H8dO8UOs32XOGWRTqt+nEk0rDM8bD74ZZvOG2RI796i/CvOkV76XJqoJzHdTj7OPrk/odJV6Y18w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BBmJ7XPWAzRtNBY9IGKtY0BZvtQ1lWLNREXK7LK3CQ=;
 b=XLSPOwXmDePE20o0qmS/stSEo1n0I1Un9eq8mw7bxDcrDDSvGBqrQpGOKYqsjI86ZwkCZtC0qF26Gb/SbYg1C+y5qAPq7+2XdSfLak/BQVFJshUYgrNFbpqqq39GZf3FNYls2e5tdLswIyp4myCLKk32sKux8MC/EDNLYhHPkFeJJmjmuyv3/jQGRi6AN1ejuSx1sd7YyWamJsaULyT7gSmhg+L7wbooFv9IdCgXN8MKhicE7SONPnmQugWk6KPvVU6wEiE1JL0gIp+affaCixLBFzAg/fb06aA5f8sCsD6iUGWygqZ7nqQ7r2QOIUI6ZT5oU8gofPqie/EUnpAsPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) by
 DM6PR12MB3387.namprd12.prod.outlook.com (20.178.198.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Thu, 28 Nov 2019 20:30:26 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560%3]) with mapi id 15.20.2495.014; Thu, 28 Nov 2019
 20:30:25 +0000
Subject: Re: Deadlock on PTEs update for HMM
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>
References: <SN6PR12MB26216A095D9839500242F489FD440@SN6PR12MB2621.namprd12.prod.outlook.com>
 <10b23ec2-f91e-51db-6d31-ba8a654e78bb@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <cbd0179f-c635-3cb6-9480-15ae47b26e8e@amd.com>
Date: Thu, 28 Nov 2019 15:30:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <10b23ec2-f91e-51db-6d31-ba8a654e78bb@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::19) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:148::30)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b0db6e8d-ef20-4053-7434-08d77441cce3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3387:|DM6PR12MB3387:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB338718AD9F203807D286AE2592470@DM6PR12MB3387.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0235CBE7D0
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(199004)(189003)(51874003)(52314003)(76114002)(66946007)(36916002)(6506007)(23676004)(6246003)(305945005)(14454004)(66556008)(316002)(14444005)(229853002)(2906002)(26005)(66476007)(2870700001)(6512007)(4326008)(5660300002)(86362001)(110136005)(31696002)(99286004)(58126008)(7736002)(36756003)(66574012)(6636002)(81156014)(8676002)(6116002)(3846002)(8936002)(4001150100001)(50466002)(2616005)(25786009)(11346002)(446003)(47776003)(186003)(65956001)(6486002)(6436002)(31686004)(66066001)(15650500001)(76176011)(65806001)(478600001)(53546011)(44832011)(2486003)(52116002)(386003)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3387;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HZ5iotdEwdG2xYfqZ/8jjVAV+X5k3EUflHxQ3/z4NUsC5BgK3gUIbynM4NCNgbTSctmwt2of30SMW6aT7onObnBG+1w7I2KQF4/YCJ8Zd4ne/fnv69trEmhvRG3QB6YrnzhnAIVMHsb0sZVSuPPtQD00xKX11AkCD61qOKvZtK8+C6IrpZfrUXHiTI02mMA2kTgYyMn6ogP8NAEdu7wrfSuYlgcY5JbvFyyoNIKxXSUQz3uc1np6Y1cPZrqJCgDyhau/u3WYOG84cNbCrby2WTqMcG0z17rxL20OhC8ZsV0uCxG8kdthDn/PCNMJDL2sz2p9D80KS/L38ZOt81I01YJ+2kci86Kfr5HEPXrT9rVsZEruKWaAgVjHXyzE99ruCUfmE5QCzFSPzlhq31fBN6T0uCiXOymoPkJiwtFN+c2PiOcAidf8wmttNdGUII8+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0db6e8d-ef20-4053-7434-08d77441cce3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2019 20:30:25.7637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jh+o1Fh1UQvZPM/ZsS3+QC/HKe0CSY2Ml8Npbbg8rocyYYaj0l4k3G+hDuuQDw8UlK8dADTHtR0kASK046FuPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3387
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BBmJ7XPWAzRtNBY9IGKtY0BZvtQ1lWLNREXK7LK3CQ=;
 b=FnxkslkUVayDSQ/LYwARYMQ9TaEI9kLVtF0Sxt9b+KZ74M7rQ1xTsZHYORDpJI/CyNmhnyN5qm9COybQqPLVQEKDoRtkjcdqspaLl2CxVcoMnVbNjKcvhmJE5u2cFh2oQ2efzkHgFGEt+vvuKzPvG/sLBG/0WtyEK2Xyltfnfw8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191128203024.eWHD_rx9ydcZHkyoPSTknUpeGzuTw4bqoW8tRzrJd4s@z>

SGkgQ2hyaXN0aWFuLAoKSSdtIHRoaW5raW5nIGFib3V0IHRoaXMgcHJvYmxlbSwgdHJ5aW5nIHRv
IGNvbWUgdXAgd2l0aCBhIHNvbHV0aW9uLiBUaGUgCmZ1bmRhbWVudGFsIHByb2JsZW0gaXMgdGhh
dCB3ZSBuZWVkIGxvdy1vdmVyaGVhZCBhY2Nlc3MgdG8gdGhlIHBhZ2UgCnRhYmxlIGluIHRoZSBN
TVUgbm90aWZpZXIsIHdpdGhvdXQgbXVjaCBtZW1vcnkgbWFuYWdlbWVudCBvciBsb2NraW5nLgoK
VGhlcmUgaXMgb25lICJkcml2ZXIgbG9jayIgdGhhdCB3ZSdyZSBzdXBwb3NlZCB0byB0YWtlIGlu
IHRoZSBNTVUgCm5vdGlmaWVyIGFzIHdlbGwgYXMgd2hlbiB3ZSB1cGRhdGUgcGFnZSB0YWJsZXMg
dGhhdCBpcyBwcmVzY3JpYmVkIGJ5IHRoZSAKSE1NIGRvY3VtZW50YXRpb24gKERvY3VtZW50YXRp
b24vdm0vaG1tLnJzdCkuIEkgZG9uJ3QgY3VycmVudGx5IHNlZSBzdWNoIAphIGxvY2sgaW4gYW1k
Z3B1LiBXZSdsbCBwcm9iYWJseSBuZWVkIHRvIGFkZCB0aGF0IGFueXdheSwgd2l0aCBhbGwgdGhl
IAp1c3VhbCBwcmVjYXV0aW9ucyBhYm91dCBsb2NrIGRlcGVuZGVuY2llcyBhcm91bmQgTU1VIG5v
dGlmaWVycy4gVGhlbiB3ZSAKY291bGQgdXNlIHRoYXQgbG9jayB0byBwcm90ZWN0IHBhZ2UgdGFi
bGUgcmVzaWRlbmN5IHN0YXRlLCBpbiBhZGRpdGlvbiAKdG8gdGhlIHJlc2VydmF0aW9uIG9mIHRo
ZSB0b3AtbGV2ZWwgcGFnZSBkaXJlY3RvcnkuCgpXZSBkb24ndCB3YW50IHRvIGJsb2NrIGV2aWN0
aW9uIG9mIHBhZ2UgdGFibGVzIHVuY29uZGl0aW9uYWxseSwgc28gdGhlIApNTVUgbm90aWZpZXIg
bXVzdCBiZSBhYmxlIHRvIGRlYWwgd2l0aCB0aGUgc2l0dWF0aW9uIHRoYXQgcGFnZSB0YWJsZXMg
CmFyZSBub3QgcmVzaWRlbnQgYXQgdGhlIG1vbWVudC4gQnV0IHRoZSBsb2NrIGNhbiBkZWxheSBw
YWdlIHRhYmxlcyBmcm9tIApiZWluZyBldmljdGVkIHdoaWxlIGFuIE1NVSBub3RpZmllciBpcyBp
biBwcm9ncmVzcyBhbmQgcHJvdGVjdCB1cyBmcm9tIApyYWNlIGNvbmRpdGlvbnMgYmV0d2VlbiBN
TVUgbm90aWZpZXJzIGludmFsaWRhdGluZyBQVEVzLCBhbmQgcGFnZSB0YWJsZXMgCmdldHRpbmcg
ZXZpY3RlZC4KCmFtZGdwdV92bV9ib19pbnZhbGlkYXRlIGNvdWxkIGRldGVjdCB3aGVuIGEgcGFn
ZSB0YWJsZSBpcyBiZWluZyBldmljdGVkLCAKYW5kIHVwZGF0ZSBhIG5ldyAidm1fcmVzaWRlbnQi
IGZsYWcgaW5zaWRlIHRoZSBhbWRncHVfdm0gd2hpbGUgaG9sZGluZyAKdGhlICJITU0gZHJpdmVy
IGxvY2siLiBJZiBhbiBNTVUgbm90aWZpZXIgaXMgaW4gcHJvZ3Jlc3MsIHRyeWluZyB0byB0YWtl
IAp0aGUgIkhNTSBkcml2ZXIgbG9jayIgd2lsbCBkZWxheSB0aGUgZXZpY3Rpb24gbG9uZyBlbm91
Z2ggZm9yIGFueSAKcGVuZGluZyBQVEUgaW52YWxpZGF0aW9uIHRvIGNvbXBsZXRlLgoKSW4gdGhl
IGNhc2UgdGhhdCBwYWdlIHRhYmxlcyBhcmUgbm90IHJlc2lkZW50ICh2bV9yZXNpZGVudCBmbGFn
IGlzIApmYWxzZSksIGl0IG1lYW5zIHRoZSBHUFUgaXMgY3VycmVudGx5IG5vdCBhY2Nlc3Npbmcg
YW55IG1lbW9yeSBpbiB0aGF0IAphbWRncHVfdm0gYWRkcmVzcyBzcGFjZS4gU28gd2UgZG9uJ3Qg
bmVlZCB0byBpbnZhbGlkYXRlIHRoZSBQVEVzIHJpZ2h0IAphd2F5LiBJIHRoaW5rIHdlIGNvdWxk
IGltcGxlbWVudCBhIGRlZmVycmVkIGludmFsaWRhdGlvbiBtZWNoYW5pc20gZm9yIAp0aGlzIGNh
c2UsIHRoYXQgZGVsYXlzIHRoZSBpbnZhbGlkYXRpb24gdW50aWwgdGhlIG5leHQgdGltZSB0aGUg
cGFnZSAKdGFibGVzIGFyZSBtYWRlIHJlc2lkZW50LiBhbWRncHVfYW1ka2ZkX2dwdXZtX3Jlc3Rv
cmVfcHJvY2Vzc19ib3Mgd291bGQgCnJlcGxheSBhbnkgZGVmZXJyZWQgUFRFIGludmFsaWRhdGlv
bnMgYWZ0ZXIgdmFsaWRhdGluZyB0aGUgcGFnZSB0YWJsZXMgCmJ1dCBiZWZvcmUgcmVzdGFydGlu
ZyB0aGUgdXNlciBtb2RlIHF1ZXVlcyBmb3IgdGhlIHByb2Nlc3MuIElmIGdyYXBoaWNzIApldmVy
IGltcGxlbWVudHMgcGFnZS1mYXVsdC1iYXNlZCBtZW1vcnkgbWFuYWdlbWVudCwgeW91J2QgbmVl
ZCB0byBkbyAKc29tZXRoaW5nIHNpbWlsYXIgaW4gYW1kZ3B1X2NzLgoKT25jZSBhbGwgdGhhdCBp
cyBpbiBwbGFjZSwgd2Ugc2hvdWxkIGJlIGFibGUgdG8gdXBkYXRlIFBURXMgaW4gTU1VIApub3Rp
ZmllcnMgd2l0aG91dCByZXNlcnZpbmcgdGhlIHBhZ2UgdGFibGVzLgoKSWYgd2UgdXNlIFNETUEg
Zm9yIHVwZGF0aW5nIHBhZ2UgdGFibGVzLCB3ZSBtYXkgbmVlZCBhIHByZS1hbGxvY2F0ZWQgSUIg
CmZvciB1c2UgaW4gTU1VIG5vdGlmaWVycy4gQW5kIHRoZXJlIGlzIHByb2JsYWJseSBvdGhlciBk
ZXRhaWxzIHRvIGJlIAp3b3JrZWQgb3V0IGFib3V0IGV4YWN0bHkgaG93IHdlIGltcGxlbWVudCB0
aGUgUFRFIGludmFsaWRhdGlvbiBpbiBNTVUgCm5vdGlmaWVycyBhbmQgcmVmbGVjdGluZyB0aGF0
IGluIHRoZSBzdGF0ZSBvZiB0aGUgYW1kZ3B1X3ZtIGFuZCAKYW1kZ3B1X2JvX3ZhX21hcHBpbmcu
CgpEb2VzIHRoaXMgaWRlYSBzb3VuZCByZWFzb25hYmxlIHRvIHlvdT8gQ2FuIHlvdSB0aGluayBv
ZiBhIHNpbXBsZXIgc29sdXRpb24/CgpUaGFua3MsCiDCoCBGZWxpeAoKT24gMjAxOS0xMS0yNyAx
MDowMiBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEhpIEFsZWphbmRybywKPgo+IHll
cyBJJ20gdmVyeSBhd2FyZSBvZiB0aGlzIGlzc3VlLCBidXQgdW5mb3J0dW5hdGVseSBjYW4ndCBn
aXZlIGFuIGVhc3kgCj4gc29sdXRpb24gZWl0aGVyLgo+Cj4gSSdtIHdvcmtpbmcgZm9yIG92ZXIg
YSB5ZWFyIG5vdyBvbiBnZXR0aW5nIHRoaXMgZml4ZWQsIGJ1dCAKPiB1bmZvcnR1bmF0ZWx5IGl0
IHR1cm5lZCBvdXQgdGhhdCB0aGlzIHByb2JsZW0gaXMgbXVjaCBiaWdnZXIgdGhhbiAKPiBpbml0
aWFsbHkgdGhvdWdodC4KPgo+IFNldHRpbmcgdGhlIGFwcHJvcHJpYXRlIEdGUCBmbGFncyBmb3Ig
dGhlIGpvYiBhbGxvY2F0aW9uIGlzIGFjdHVhbGx5IAo+IHRoZSB0cml2aWFsIHBhcnQuCj4KPiBU
aGUgcmVhbGx5IHJlYWxseSBoYXJkIHRoaW5nIGlzIHRoYXQgd2Ugc29tZWhvdyBuZWVkIHRvIGFk
ZCBhIGxvY2sgdG8gCj4gcHJldmVudCB0aGUgcGFnZSB0YWJsZXMgZnJvbSBiZWluZyBldmljdGVk
LiBBbmQgYXMgeW91IGFsc28gZmlndXJlZCAKPiBvdXQgdGhhdCBsb2NrIGNhbid0IGJlIHRha2Vu
IGVhc2lseSBhbnl3aGVyZSBlbHNlLgo+Cj4gSSd2ZSBhbHJlYWR5IHdyb3RlIGEgcHJvdG90eXBl
IGZvciB0aGlzLCBidXQgZGlkbid0IGhhZCB0aW1lIHRvIGhhbW1lciAKPiBpdCBpbnRvIHNoYXBl
IGZvciB1cHN0cmVhbWluZyB5ZXQuCj4KPiBSZWdhcmRzLAo+IENocmlzdGlhbi4KPgo+IEFtIDI3
LjExLjE5IHVtIDE1OjU1IHNjaHJpZWIgU2llcnJhIEd1aXphLCBBbGVqYW5kcm8gKEFsZXgpOgo+
Pgo+PiBIaSBDaHJpc3RpYW4sCj4+Cj4+IEFzIHlvdSBrbm93LCB3ZeKAmXJlIHdvcmtpbmcgb24g
dGhlIEhNTSBlbmFibGVtZW50LiBJbSB3b3JraW5nIG9uIHRoZSAKPj4gZEdQVSBwYWdlIHRhYmxl
IGVudHJpZXMgaW52YWxpZGF0aW9uIG9uIHRoZSB1c2VycHRyIG1hcHBpbmcgY2FzZS4gCj4+IEN1
cnJlbnRseSwgdGhlIE1NVSBub3RpZmllcnMgaGFuZGxlIHN0b3BzIGFsbCB1c2VyIG1vZGUgcXVl
dWVzLCAKPj4gc2NoZWR1bGUgYSBkZWxheWVkIHdvcmtlciB0byByZS12YWxpZGF0ZSB1c2VycHRy
IG1hcHBpbmdzIGFuZCByZXN0YXJ0IAo+PiB0aGUgcXVldWVzLgo+Pgo+PiBQYXJ0IG9mIHRoZSBI
TU0gZnVuY3Rpb25hbGl0eSwgd2UgbmVlZCB0byBpbnZhbGlkYXRlIHRoZSBwYWdlIHRhYmxlIAo+
PiBlbnRyaWVzIGluc3RlYWQgb2Ygc3RvcHBpbmcgdGhlIHF1ZXVlcy4gQXQgdGhlIHNhbWUgdGlt
ZSB3ZSBuZWVkIHRvIAo+PiBtb3ZlIHRoZSByZXZhbGlkYXRpb24gb2YgdGhlIHVzZXJwdHIgbWFw
cGluZ3MgaW50byB0aGUgcGFnZSBmYXVsdCAKPj4gaGFuZGxlci4KPj4KPj4gV2XigJlyZSBzZWVp
bmcgYSBkZWFkbG9jayB3YXJuaW5nIGFmdGVyIHdlIHRyeSB0byBpbnZhbGlkYXRlIHRoZSBQVEVz
IAo+PiBpbnNpZGUgdGhlIE1NVSBub3RpZmllciBoYW5kbGVyLiBNb3JlIHNwZWNpZmljLCB3aGVu
IHdlIHRyeSB0byB1cGRhdGUgCj4+IHRoZSBCT3MgdG8gaW52YWxpZGF0ZSBQVEVzIHVzaW5nIGFt
ZGdwdV92bV9ib191cGRhdGUuIFRoaXMgdXNlcyAKPj4ga21hbGxvYyBvbiB0aGUgYW1kZ3B1X2pv
Yl9hbGxvYyB3aGljaCBzZWVtcyB0byBiZSBjYXVzaW5nIHRoaXMgcHJvYmxlbS4KPj4KPj4gQmFz
ZWQgb24gQEt1ZWhsaW5nLCBGZWxpeCA8bWFpbHRvOkZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+IGNv
bW1lbnRzLCAKPj4ga21hbGxvYyB3aXRob3V0IGFueSBzcGVjaWFsIGZsYWdzIGNhbiBjYXVzZSBt
ZW1vcnkgcmVjbGFpbS4gRG9pbmcgCj4+IHRoYXQgaW5zaWRlIGFuIE1NVSBub3RpZmllciBpcyBw
cm9ibGVtYXRpYywgYmVjYXVzZSBhbiBNTVUgbm90aWZpZXIgCj4+IG1heSBiZSBjYWxsZWQgaW5z
aWRlIGEgbWVtb3J5LXJlY2xhaW0gb3BlcmF0aW9uIGl0c2VsZi4gVGhhdCB3b3VsZCAKPj4gcmVz
dWx0IGluIHJlY3Vyc2lvbi4gQWxzbywgcmVjbGFpbSBzaG91bGRuJ3QgYmUgZG9uZSB3aGlsZSBo
b2xkaW5nIGEgCj4+IGxvY2sgdGhhdCBjYW4gYmUgdGFrZW4gaW4gYW4gTU1VIG5vdGlmaWVyIGZv
ciB0aGUgc2FtZSByZWFzb24uIElmIHlvdSAKPj4gY2F1c2UgYSByZWNsYWltIHdoaWxlIGhvbGRp
bmcgdGhhdCBsb2NrLCB0aGVuIGFuwqBNTVUgbm90aWZpZXIgY2FsbGVkIAo+PiBieSB0aGUgcmVj
bGFpbSBjYW7CoGRlYWRsb2NrIHRyeWluZyB0byB0YWtlIHRoZSBzYW1lIGxvY2suCj4+Cj4+IFBs
ZWFzZSBsZXQgdXMga25vdyBpZiB5b3UgaGF2ZSBhbnkgYWR2aWNlIHRvIGVuYWJsZSB0aGlzIHRo
ZSByaWdodCB3YXkKPj4KPj4gVGhhbmtzIGluIGFkdmFuY2VkLAo+Pgo+PiBBbGVqYW5kcm8KPj4K
PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
