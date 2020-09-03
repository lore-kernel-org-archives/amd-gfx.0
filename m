Return-Path: <SRS0=hFGi=CM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A85C433E2
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 15:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDCB520775
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 15:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AgVHTRkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDCB520775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80BFC6E17A;
	Thu,  3 Sep 2020 15:45:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BF146E091
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2020 15:45:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oh+bd/99md9/MECAOH9zvVZocq9lmU4KVz7sEQD2dxeH7Ey9Hqn1XdjnM54dy7NjI8GJ9k5f7IRtkQ50ut+aJNpNEw7wKX8G8VUQygjX1cDfJybNl8hvLHOkLmmTqcsMr5XrMkJ/eGH419qlUZ+xYGFPA6JqfLWgdTolHtN36LWhnwBHEZoloB0ZK3cN3h8eh1jyx73whpcrhJ/vGFXJbV8KkKwClI2cJN4PM1IKn7x3QLdzMk2gwKTInfa2pjITkz3QCtE7rxTq79Dhdg9nyuPDDAc8cR8TvXFrNrGmXusgMG6vq2vCpP+lkSBvBfHMBERJMjhsRWeHtQSrWuhu7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoEpJwpuGn+nasSPZCr5cmCjqodpJ3Y10aI7LzLqfDs=;
 b=mOL2MPwWHLrGi1+1086odgiYCMGfZuEqJPzY96ztfSey62I+22+FOEGW4yZB0iBIxgMROBSt0AgD5Ye0H9exZjsXWi1d/25OZuZd2QKXRsSdUNY2/BR3u6Y2n3Imfsu27Vd8lHMCQin6Scm/jwNI1zZE4wkIlryS/tf285vmPxU88EnTXkdcpAy640a9GDJ3YOUd9M1A3/AUj986DEY9vTwuA0iMxR22TzcLk9pKGdrr7z7bclIxhV2KcK1m+SfMN1E6noaIbxp1Ae0CXRCZ4pftIQc1AuU+n+n0ZRee1prsvdevKAuKDpRMx+B0NP2omuJtObgEKpPUpwzpN7V+Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoEpJwpuGn+nasSPZCr5cmCjqodpJ3Y10aI7LzLqfDs=;
 b=AgVHTRktb0xsTO9OvMnP4igPfeukfEZ9VktMzpy8nbfS9P7aeImgp/jJx9G3C4Vg6zobaPB5kqtMIPS1J+AG/o1G/U6GtJVby+Sw9Fh0zbADlCu7vrhotzFFW5xRZYZCk61lJYv9MFsO49eR2PlC+V4C2rFYS5tOp5Um26bU6iQ=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM5PR12MB2487.namprd12.prod.outlook.com (2603:10b6:4:af::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Thu, 3 Sep 2020 15:45:27 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983%3]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 15:45:27 +0000
Subject: Re: [PATCH v4 4/8] drm/amdgpu: Fix consecutive DPC recovery failures.
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20200902222359.GA272485@bjorn-Precision-5520>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <8388b5b2-b39b-03bd-602b-22cf960396ac@amd.com>
Date: Thu, 3 Sep 2020 11:45:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <20200902222359.GA272485@bjorn-Precision-5520>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::15) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YTBPR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Thu, 3 Sep 2020 15:45:26 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f9322ad3-054e-436b-f425-08d8502060e4
X-MS-TrafficTypeDiagnostic: DM5PR12MB2487:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB248791949014105972DE5452EA2C0@DM5PR12MB2487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b6tkFblFqSKxXZZyY/u5ikdP2XFmXW1yh9x0S4y+TCLzyC57XtmpMtOqiZDxDSPxnH1HrrrB9CfPOpLTrJp1i2H5xRi/zieaIEsivoCJqSdjuaCHMs2ygBHYUo3KgqHobod522idmtix4BYhU/x2DhwYuor6JcenSx74484jjFPKeMWS+wMfz9O5yfQMjcV/k2LaxB06h06mX7a3Cr/dp1A74OH+EXCFRv4zg9hTpgcb3RhyePtQpfVxCjq6DgxwNu2OqiMhqIWIUQsFelg9feITwjTsx58A3VQcNvc3sCuedKgjqFn0IJ2X1GfKQNGswK8EDqfkzfTczaMqNsjRmEDvr10NhIasAPr6ZUx+nTDVq+j1wMR9AN1FtpCsDTga
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(2906002)(86362001)(8936002)(5660300002)(66476007)(66946007)(66556008)(31696002)(8676002)(16576012)(186003)(31686004)(4326008)(83380400001)(2616005)(6486002)(956004)(36756003)(52116002)(478600001)(316002)(26005)(53546011)(6916009)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: NjqNM1KbsTbVTri7DGTWgy1d3Zdj6Pyh0a85K4/qpi3UDjwUg1b0py47qjgPT8zlQNJVolFK7mOMgYwZiPyavvsuJLry4Go6eZal9BY/ZcG5mrpvmKnJVUTKYlnwUjXUUMEKV0SZXgcBhTKlR9thW650l07psiQzKWo1U/PKck9FWzGm/2qnwb1UJpAxfJOeqsrzisiovar1M7ECOCsjgl0SRZMaBDHMAKe8n8ODAVMo/kkVn+NF+NglN7Ojv94O2W/RDcitWNghYNPU3sSAPlIlcl9qZh2LWQCQ2ev1ESESTb7kGY8WwQgsYNr0OXSuZAs6aue17Bb2MYzvrc7tqHELwZ87huG5UAMe+5ziYL/jgzFMveq2+NNlCsz+PCnMZjOaW5tg7WYQ98QfWrHGaKoFPSf0evI/jObevq8Rxsa0ayDNV4NlU+ddPq1hSTeVWVS5FiwDnBbAwJdxkrLpeP5l1zlLumWAokAaPZRrde7+o/tzMRWM9rlGfp3RYrt/oGIhxzpIPPYskM1VXRyePhaL/X7GefoRX84fF3tkSVBtU8eVGcWwQpNOgFd2/G4lohzdXyKOH49Bw1KhLVVvUdADz2hKvbZMeJ8VA9rKHXmatKbzLAA/hAUXZgPhcI9CER02ba3RWm5FSgoJ8diGhw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9322ad3-054e-436b-f425-08d8502060e4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 15:45:26.9619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a79owDzgYGG2+DSY3VJgGXL7s3bLh8VM/J3PST2BkzdphfXAFnfHHOdaTOJxCBa57fB5WlhQEUx/4TDUwovD2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2487
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
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, linux-pci@vger.kernel.org,
 nirmodas@amd.com, amd-gfx@lists.freedesktop.org, bhelgaas@google.com,
 luben.tuikov@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 Dennis.Li@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDkvMi8yMCA2OjIzIFBNLCBCam9ybiBIZWxnYWFzIHdyb3RlOgo+IE9uIFdlZCwgU2VwIDAy
LCAyMDIwIGF0IDAyOjQyOjA2UE0gLTA0MDAsIEFuZHJleSBHcm9kem92c2t5IHdyb3RlOgo+PiBD
YWNoZSB0aGUgUENJIHN0YXRlIG9uIGJvb3QgYW5kIGJlZm9yZSBlYWNoIGNhc2Ugd2hlcmUgd2Ug
bWlnaHQKPj4gbG9vc2UgaXQuCj4gcy9sb29zZS9sb3NlLwo+Cj4+IHYyOiBBZGQgcGNpX3Jlc3Rv
cmVfc3RhdGUgd2hpbGUgY2FjaGluZyB0aGUgUENJIHN0YXRlIHRvIGF2b2lkCj4+IGJyZWFraW5n
IFBDSSBjb3JlIGxvZ2ljIGZvciBzdHVmZiBsaWtlIHN1c3BlbmQvcmVzdW1lLgo+Pgo+PiB2Mzog
RXh0cmFjdCBwY2lfcmVzdG9yZV9zdGF0ZSBmcm9tIGFtZGdwdV9kZXZpY2VfY2FjaGVfcGNpX3N0
YXRlCj4+IHRvIGF2b2lkIHN1cGVyZmxvdXMgcmVzdG9yZXMgZHVyaW5nIEdQVSByZXNldHMgYW5k
IHN1c3BlbmQvcmVzdW1lcy4KPj4KPj4gdjQ6IFN0eWxlIGZpeGVzLgo+IElzIHRoZSBEUk0gY29u
dmVudGlvbiB0byBrZWVwIHRoZSB2Mi92My92NCBzdHVmZiBpbiB0aGUgY29tbWl0IGxvZz8gIEkK
PiBrZWVwIHRob3NlIGJlbG93IHRoZSAiLS0tIiBvciBtYW51YWxseSByZW1vdmUgdGhlbSBmb3Ig
UENJLCBidXQgdXNlCj4gdGhlIGxvY2FsIGNvbnZlbnRpb24sIG9mIGNvdXJzZS4KPgo+PiArCS8q
IEhhdmUgc3RvcmVkIHBjaSBjb25mc3BhY2UgYXQgaGFuZCBmb3IgcmVzdG9yZSBpbiBzdWRkZW4g
UENJIGVycm9yICovCj4gSSBhc3N1bWUgdGhhdCBhdCBsZWFzdCBmcm9tIHRoZSBwZXJzcGVjdGl2
ZSBvZiB0aGlzIGNvZGUsIGFsbCBQQ0kKPiBlcnJvcnMgYXJlICJzdWRkZW4iLiAgT3IgaWYgdGhl
eSdyZSBub3QsIEknbSBjdXJpb3VzIGFib3V0IHdoaWNoIHdvdWxkCj4gYmUgc3VkZGVuIGFuZCB3
aGljaCB3b3VsZCBub3QuCgoKWWVzLCBhbGwgUENJIGVycm9ycyBhcmUgc3VkZGVuIGZyb20gZHJp
dmVycyBwb2ludCBvZiB2aWV3IGluZGVlZCwgSSBhbSBqdXN0IApzdHJlc3NpbmcKdGhlIGZhY3Qg
dGhhdCBpIGhhdmUgdG8gJ3BsYW4gYWhlYWQnIGFuZCBzdG9yZSB3b3JraW5nIFBDSSBjb25maWcg
YmVjYXVzZSB0byBteSAKdW5kZXJzdGF0aW5nIGJ5IHRoZQp0aW1lIHdoZW4gd2UgYXJlIG5vdGlm
aWVkIG9mIHRoZSBQQ0kgZXJyb3IgaW4gZXJyX2RldGVjdGVkIGNhbGxiYWNrIHRoZSBkZXZpY2Ug
CmFuZCBpdCdzIFBDSSBjb25mc3BhY2UKcmVnaXN0ZXJzIGFyZSBhbHJlYWR5IGluYWNjZXNzaWJs
ZcKgIGFuZCBzbyBpdCdzIHRvIGxhdGUgdG8gdHJ5IGFuZCBzYXZlIHRoZSAKY29uZnNwYWNlIGF0
IHRoaXMgdGltZS4KCgo+Cj4+ICsJaWYgKGFtZGdwdV9kZXZpY2VfY2FjaGVfcGNpX3N0YXRlKGFk
ZXYtPnBkZXYpKQo+PiArCQlwY2lfcmVzdG9yZV9zdGF0ZShwZGV2KTsKPj4gK2Jvb2wgYW1kZ3B1
X2RldmljZV9jYWNoZV9wY2lfc3RhdGUoc3RydWN0IHBjaV9kZXYgKnBkZXYpCj4+ICt7Cj4+ICsJ
c3RydWN0IGRybV9kZXZpY2UgKmRldiA9IHBjaV9nZXRfZHJ2ZGF0YShwZGV2KTsKPj4gKwlzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGRybV90b19hZGV2KGRldik7Cj4+ICsJaW50IHI7Cj4+
ICsKPj4gKwlyID0gcGNpX3NhdmVfc3RhdGUocGRldik7Cj4+ICsJaWYgKCFyKSB7Cj4+ICsJCWtm
cmVlKGFkZXYtPnBjaV9zdGF0ZSk7Cj4+ICsKPj4gKwkJYWRldi0+cGNpX3N0YXRlID0gcGNpX3N0
b3JlX3NhdmVkX3N0YXRlKHBkZXYpOwo+PiArCj4+ICsJCWlmICghYWRldi0+cGNpX3N0YXRlKSB7
Cj4+ICsJCQlEUk1fRVJST1IoIkZhaWxlZCB0byBzdG9yZSBQQ0kgc2F2ZWQgc3RhdGUiKTsKPj4g
KwkJCXJldHVybiBmYWxzZTsKPj4gKwkJfQo+PiArCX0gZWxzZSB7Cj4+ICsJCURSTV9XQVJOKCJG
YWlsZWQgdG8gc2F2ZSBQQ0kgc3RhdGUsIGVycjolZFxuIiwgcik7Cj4+ICsJCXJldHVybiBmYWxz
ZTsKPj4gKwl9Cj4+ICsKPj4gKwlyZXR1cm4gdHJ1ZTsKPj4gK30KPj4gKwo+PiArYm9vbCBhbWRn
cHVfZGV2aWNlX2xvYWRfcGNpX3N0YXRlKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQo+PiArewo+PiAr
CXN0cnVjdCBkcm1fZGV2aWNlICpkZXYgPSBwY2lfZ2V0X2RydmRhdGEocGRldik7Cj4+ICsJc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBkcm1fdG9fYWRldihkZXYpOwo+PiArCWludCByOwo+
PiArCj4+ICsJaWYgKCFhZGV2LT5wY2lfc3RhdGUpCj4+ICsJCXJldHVybiBmYWxzZTsKPj4gKwo+
PiArCXIgPSBwY2lfbG9hZF9zYXZlZF9zdGF0ZShwZGV2LCBhZGV2LT5wY2lfc3RhdGUpOwo+IEkn
bSBhIGxpdHRsZSBiaXQgaGVzaXRhbnQgdG8gcGNpX2xvYWRfc2F2ZWRfc3RhdGUoKSBhbmQKPiBw
Y2lfc3RvcmVfc2F2ZWRfc3RhdGUoKSBiZWluZyB1c2VkIGhlcmUsIHNpbXBseSBiZWNhdXNlIHRo
ZXkncmUKPiBjdXJyZW50bHkgb25seSB1c2VkIGJ5IFZGSU8sIFhlbiwgYW5kIG52bWUuICBTbyBJ
IGRvbid0IGhhdmUgYSByZWFsCj4gb2JqZWN0aW9uLCBidXQganVzdCBwb2ludGluZyBvdXQgdGhh
dCBhcHBhcmVudGx5IHlvdSdyZSBkb2luZwo+IHNvbWV0aGluZyByZWFsbHkgc3BlY2lhbCB0aGF0
IGlzbid0IGNvbW1vbmx5IHVzZWQgYW5kIHRlc3RlZCwgc28gaXQncwo+IG1vcmUgbGlrZWx5IHRv
IGJlIGJyb2tlbiBvciBpbmNvbXBsZXRlLgoKClNlZSBteSBhc3N1bXB0aW9uIGFib3ZlLCBJIGFz
c3VtZSBJIGhhdmUgdG8gZXhwbGljaXRseSBzYXZlIChjYWNoZSkgdGhlIFBDSSAKc3RhdGUgd2hp
bGUKdGhlIGRldmljZSBpcyBmdWxseSBvcGVyYXRpb25hbCBzaW5jZSBJIGFzc3VtZSBpdCdzIG5v
dCBwb3NzaWJsZSB3aGVuIFBDSSBlcnJvciAKb2NjdXJzIGFuZApEUEMgaXNvbGF0ZXMgdGhlIGRl
dmljZS4gSSBkbyBzcG90IFBDSSBjb3JlIGNhbGxpbmcgcGNpX2Rldl9zYXZlX2FuZF9kaXNhYmxl
IGFuZCAKcGNpX2Rldl9yZXN0b3JlCmFzIHBhcnQgb2YgcGNpZV9kb19yZWNvdmVyeS0+cGNpX3Jl
c2V0X2J1cyBhbmQgdGhvc2UgZnVuY3Rpb25zIGRvIHN0b3JlIGFuZCAKcmVzdG9yZSB0aGUgUENJ
IGNvbmZwc2FjZQpidXQgSSBhbSBub3Qgc3VyZSB0aGlzIGNvZGUgZXhlY3V0ZXMgaW4gYWxsIGNh
c2VzIGFuZCAKcGNpZV9kb19yZWNvdmVyeS0+cGNpX3Jlc2V0X2J1cwp3YXMganVzdCBhZGRlZCBu
b3cgYnkgbGFzdCBzYXRoeWFuYXJheWFuYW4ncyBwYXRjaCBoZSBnYXZlIG1lIGFueXdheS4uLgoK
QW5kcmV5CgoKPgo+IFRoZXJlJ3MgbG90cyBvZiBzdGF0ZSB0aGF0IHRoZSBQQ0kgY29yZSAqY2Fu
J3QqIHNhdmUvcmVzdG9yZSwgYW5kCj4gcGNpX2xvYWRfc2F2ZWRfc3RhdGUoKSBkb2Vzbid0IGV2
ZW4gaGFuZGxlIGFsbCB0aGUgYXJjaGl0ZWN0ZWQgUENJCj4gc3RhdGUsIGkuZS4sIHdlIG9ubHkg
Y2FsbCBwY2lfYWRkX2NhcF9zYXZlX2J1ZmZlcigpIG9yCj4gcGNpX2FkZF9leHRfY2FwX3NhdmVf
YnVmZmVyKCkgZm9yIGEgZmV3IG9mIHRoZSBjYXBhYmlsaXRpZXMuCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
