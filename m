Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BD4C55178
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 15:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43EFB247D0
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 15:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2rcUxl0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43EFB247D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8F7A6E483;
	Wed, 28 Oct 2020 15:54:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 185CB6E483
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 15:54:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrDz3X06otl6lO1A33pIFei03mHq2B/aJuYXNttWbCLcTlLkBLY6TalGo7hz2kpZpVN2/3gvh3BCQm2OXmXM1g7ITD+Oa2REvgAYBylt6G8SajwF/U7kiNIiHUN4gOs59X+6qXfopC4V9QsxbQaXTjkDsX9NkfO0Ou5nMJbNURkDq3irNwWBxREhI3OxbeeqVPRD+uUQseoAlLrOJuMmV3sCsXAQ4SowQe2v+/SuUe1D2r3lLDOUFbnXcQQ6kCFhEMnXlTb4JVs0/p4phiqs54OFedcpTRUv6pkPSdEE3VvzMOrCfHibjqCzf+MariBF+6BnHfKOAnU7kTFjxcwuAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDvzDGGAoy9WUv1k5rw+H8WXKojujAuXREsKjNvNENY=;
 b=e8t783B/SeN7fbIApmP31KL2mM8gG5r1T7sgiSRf0JuR/hz8OddPvKoRh41DrSVNHJFFhXG0AVA2KyMwWJsMfqZC3N0vb3dPLA7/cVX0iXL84PrtOA8ujhMQxx/d+RWpJAcXDoqH8xdj+SxoeU2dFe7qVGwcKvinpN96zRNOwRai7zYJXiqJvNzURjT1NvXYVd8uVY/oEZb0H93grK9pFl8RnZI4GZnI0+guOysy3SXmVEMc39tH7D+xD9nprSYkBIvH3mhvwgTbyTGhFigaNsHZnC20CwWAhz4jBMmqmEllepOBCFJ8ihvoxEB5hA925wqUM+BxyDIPY2N4m6svHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDvzDGGAoy9WUv1k5rw+H8WXKojujAuXREsKjNvNENY=;
 b=2rcUxl0WGP2/nfzoMi9SJg6Bgl29UFO+WFRVcW384raGV54pl0OPfTB9EA+1rxzGuDk8GLCcbBhpVAd6Qvn1LQWHFJSrSIEg/FfF4v/zS/RKZvM0T0tjwwZhB6bW/HorKt32jBk+3XAAShDXuT6tl7pHOAGKhLe4OUl+oN4xToo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4317.namprd12.prod.outlook.com (2603:10b6:208:1d0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 28 Oct
 2020 15:54:33 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8%9]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 15:54:33 +0000
Subject: Re: [PATCH 2/2] drm/amdkfd: Change unique_id to print hex format
To: amd-gfx@lists.freedesktop.org, "Russell, Kent" <Kent.Russell@amd.com>
References: <20201028152218.18485-1-kent.russell@amd.com>
 <20201028152218.18485-2-kent.russell@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <077bdbef-51f2-ac28-6392-84727a640525@amd.com>
Date: Wed, 28 Oct 2020 11:54:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201028152218.18485-2-kent.russell@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.113.11]
X-ClientProxiedBy: YT1PR01CA0125.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::34) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YT1PR01CA0125.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 15:54:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dadc071f-6162-406a-0c06-08d87b59c34c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43174C2FFF6E63F2B8F0C93E92170@MN2PR12MB4317.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:114;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wLYBc17s+EGzd43IsIjVb0eStxb99eIkxqFdDAnsRjIQpIFNRLFPgi/BIPnN5VMTi8dBMRg59RZ4Wb14cWB03e8Qt0P2Vl3v47O20Z5ykm9hY13MtQGuTFr32DHL5SJp8t8EEKRz2mRSABfaXr1/x2acrwm3KJIi+YrkUYIMeRTFx07fO4OFTqAkQFdSWRGPb7hZYYNtjXyR4qiDMyVcT2il5+uzJMTUbgAiy28/8NvDReUl6LkQ9jbK4jomC8g1bF26kHg7GY3MN637kZMKb8AW8G4CVSaADOMq/RSrDO++anBJ/nUL2ewBMxP3bhO3uMsLYJ91gFBxXn9Pi6cJ/t1SvC3lmGW0E2moOGfbXz0MOmMOW3rInGwA+vib7aql
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(83380400001)(6862004)(6486002)(44832011)(956004)(2616005)(26005)(316002)(16576012)(31686004)(16526019)(186003)(6636002)(8676002)(2906002)(478600001)(52116002)(37006003)(8936002)(86362001)(66476007)(66946007)(66556008)(31696002)(4001150100001)(36756003)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: RNOs9VpOO0GTry4MqcxQOnnMCSiVGC9SapNxKek1R1vm4THZyyURzIWnnwW9vXj0f5w7nXWn8MkJZhSP1dYFEMhe/fpQi62CZaehb2gX25BhIWE7kR0T+lpctBQZhcvNBsTtZIFmDUVVildhKsM6/WoWvr2FxlYZYDSa+DUD7Hs7CuG/BC1Akt9v4PERb3C9fKqL/a/Ec/GW1Sgrsxz9F+hEeL16Uc0HCAU9D35cu0WV+scoyEREh72Z1ipJgkyT+linqLzdkkOd+YaNHmq2Uk9IAngvcyx4KDzeXy9rJMiU9pQ7y+dBenUT8Ykq1eMWN9TQYP0fcuAdhvLLCHuUOrATRrqYeni9crlAAOTAkFK5KFF9+7VikhCG2cZhgvqfwkRMRtaZFYbUGC1o3Lf7RFKBVA3csmdFGzWby1EJWpX+ER0lMMrCrIqWFCqhMkzotos8/HV3rd07VzuVjsyqzj62T94ZFjtIglH+KNz+uz5pA/AB1NmOawnpa4HtjiEJOVJmkkNSFvXECZo+dsF8Au8lReoaaXfSNThtKcDIR42T4Qn4r+IkwNN4MCVN0IPIHyh8ubh5uf3+PKDo7kxa48Vn4aA843SAur7qOpLGnxrEpTWPTsYInDY0Vyv19MMr/lLGdcgIZ3IYvGSvitIcbw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dadc071f-6162-406a-0c06-08d87b59c34c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 15:54:33.3374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3wFSt74f+YaWR/qXkSVtIFQH1mApSr6jYVn4y8m65A1P40+AymK+f4hjg6phbuZc4JaurxDp25jJZ6Lh+ncew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4317
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

VGhpcyBpcyBhbiBBQkktYnJlYWtpbmcgY2hhbmdlLiBJcyBhbnkgdXNlciBtb2RlIGNvZGUgdXNp
bmcgdGhpcyBhbHJlYWR5PwoKUmVnYXJkcywKwqAgRmVsaXgKCkFtIDIwMjAtMTAtMjggdW0gMTE6
MjIgYS5tLiBzY2hyaWViIEtlbnQgUnVzc2VsbDoKPiBhbWRncHUncyB1bmlxdWVfaWQgcHJpbnRz
IGluIGhleCBmb3JtYXQsIHNvIGNoYW5nZSB0b3BvbG9neSdzIHByaW50b3V0Cj4gdG8gaGV4IGJ5
IGFkZGluZyBhIG5ldyBzeXNmc19wcmludCBtYWNybyBzcGVjaWZpY2FsbHkgZm9yIGhleCBvdXRw
dXQsCj4gYW5kIHVzZSBpdCBmb3IgdW5pcXVlX2lkCj4KPiBTaWduZWQtb2ZmLWJ5OiBLZW50IFJ1
c3NlbGwgPGtlbnQucnVzc2VsbEBhbWQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfdG9wb2xvZ3kuYyB8IDQgKysrLQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfdG9wb2xvZ3kuYwo+IGluZGV4IGEzZmMyMzg3MzgxOS4uZDEzYzY4YzUyYmJjIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMKPiBAQCAtMjE3LDYgKzIx
Nyw4IEBAIHN0cnVjdCBrZmRfdG9wb2xvZ3lfZGV2aWNlICprZmRfY3JlYXRlX3RvcG9sb2d5X2Rl
dmljZSgKPiAgCQlzeXNmc19zaG93X2dlbl9wcm9wKGJ1ZmZlciwgb2ZmcywgIiVzICV1XG4iLCBu
YW1lLCB2YWx1ZSkKPiAgI2RlZmluZSBzeXNmc19zaG93XzY0Yml0X3Byb3AoYnVmZmVyLCBvZmZz
LCBuYW1lLCB2YWx1ZSkgXAo+ICAJCXN5c2ZzX3Nob3dfZ2VuX3Byb3AoYnVmZmVyLCBvZmZzLCAi
JXMgJWxsdVxuIiwgbmFtZSwgdmFsdWUpCj4gKyNkZWZpbmUgc3lzZnNfc2hvd182NGJpdF9wcm9w
X2hleChidWZmZXIsIG9mZnMsIG5hbWUsIHZhbHVlKSBcCj4gKwkJc3lzZnNfc2hvd19nZW5fcHJv
cChidWZmZXIsIG9mZnMsICIlcyAlbGx4XG4iLCBuYW1lLCB2YWx1ZSkKPiAgI2RlZmluZSBzeXNm
c19zaG93XzMyYml0X3ZhbChidWZmZXIsIG9mZnMsIHZhbHVlKSBcCj4gIAkJc3lzZnNfc2hvd19n
ZW5fcHJvcChidWZmZXIsIG9mZnMsICIldVxuIiwgdmFsdWUpCj4gICNkZWZpbmUgc3lzZnNfc2hv
d19zdHJfdmFsKGJ1ZmZlciwgb2ZmcywgdmFsdWUpIFwKPiBAQCAtNDk3LDcgKzQ5OSw3IEBAIHN0
YXRpYyBzc2l6ZV90IG5vZGVfc2hvdyhzdHJ1Y3Qga29iamVjdCAqa29iaiwgc3RydWN0IGF0dHJp
YnV0ZSAqYXR0ciwKPiAgCQkJICAgICAgZGV2LT5ub2RlX3Byb3BzLm51bV9zZG1hX3F1ZXVlc19w
ZXJfZW5naW5lKTsKPiAgCXN5c2ZzX3Nob3dfMzJiaXRfcHJvcChidWZmZXIsIG9mZnMsICJudW1f
Y3BfcXVldWVzIiwKPiAgCQkJICAgICAgZGV2LT5ub2RlX3Byb3BzLm51bV9jcF9xdWV1ZXMpOwo+
IC0Jc3lzZnNfc2hvd182NGJpdF9wcm9wKGJ1ZmZlciwgb2ZmcywgInVuaXF1ZV9pZCIsCj4gKwlz
eXNmc19zaG93XzY0Yml0X3Byb3BfaGV4KGJ1ZmZlciwgb2ZmcywgInVuaXF1ZV9pZCIsCj4gIAkJ
CSAgICAgIGRldi0+bm9kZV9wcm9wcy51bmlxdWVfaWQpOwo+ICAKPiAgCWlmIChkZXYtPmdwdSkg
ewpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
