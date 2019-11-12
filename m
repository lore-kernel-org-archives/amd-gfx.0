Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF802C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 16:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8EF20679
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 16:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8EF20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3362D6E497;
	Tue, 12 Nov 2019 16:06:54 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790075.outbound.protection.outlook.com [40.107.79.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 418C16E497
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 16:06:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ec5sORykwGhnMJjAMtceyv68z7fyfy2gPm60X9Qe4yYfNJgkqSKVnQjhNuWHF2WKOrEKfw7xUodiz+/rOB8M/NslesdN+LG8sw255eXTI9fCaHswz2+5TZ0AwZcsoPC+kfwE3Yd9t2TjVCRIOB/IWP3hPnuYeo3+HlAtMFNX1fSm+TWE1T0Z/afMftT3fToNB+WDDbRujlxLBWNzNFSs0EXAUiJUDwGotXr3Un78jf7trVHtBTTQD6UhC+A0NnALU2ZPGjPEgp1UOH1T31OUbfJgs8ArlUB8LCYrnF40FblzLAtIXjYGIubxv67CaBsHfA1lN4UlSruvOBDXNtLoCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9gaGIp9WwInU45Gz05+Af78eFKTcKDMe/ITcaPWvM4=;
 b=VBTXY5JnIX3c0UNlc/knjUfIzXBcefSgzWGzoKAGtwyCtz1l4m5bMQRA88lbL/58tYxuKVPkeotFnw70zU0FeU38OrSJYNZQ6i1m106TJ0z0ecETuXbDjS3yZxe5IYMS+HOgy2PNNWdUCL7bgFvYT5s9Y/iZAW3NOcG4hPWR5l16i100aicTtmYVJ3vH/cVR5WAkOAvPm5Tvtaor1nrgmdCS4ztwLNRuJL3VFYgl2MCXhf+rjbyFl/bIh+Ch8W4VWOgeNFmHYugJIEwiERzXbWUC6VWxFw32F9THZW6lWrX8j0SahUhAKYGPbmhYx9XepQk+FN3jpYjyqRjivbFcgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB3637.namprd12.prod.outlook.com (20.178.54.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 12 Nov 2019 16:06:49 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f950:f7be:9139:7c26]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f950:f7be:9139:7c26%7]) with mapi id 15.20.2408.025; Tue, 12 Nov 2019
 16:06:49 +0000
Subject: Re: [PATCH 2/2] drm/amd/display: Fix coding error in connector atomic
 check
To: mikita.lipski@amd.com, amd-gfx@lists.freedesktop.org,
 harry.wentland@amd.com
References: <20191112151532.8192-1-mikita.lipski@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <49131859-4ff9-8e7b-95cc-60714b168ec2@amd.com>
Date: Tue, 12 Nov 2019 11:06:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20191112151532.8192-1-mikita.lipski@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::32)
 To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e16b1a90-e0e0-4531-68af-08d7678a5331
X-MS-TrafficTypeDiagnostic: BYAPR12MB3637:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3637528B6276CD917D062481EC770@BYAPR12MB3637.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(199004)(189003)(81156014)(8676002)(99286004)(81166006)(31686004)(2906002)(230700001)(5660300002)(476003)(2616005)(25786009)(11346002)(446003)(486006)(58126008)(66066001)(65956001)(65806001)(6116002)(3846002)(229853002)(316002)(8936002)(47776003)(6246003)(6512007)(66946007)(6636002)(478600001)(14454004)(76176011)(6486002)(2486003)(6436002)(23676004)(52116002)(4001150100001)(53546011)(386003)(50466002)(66476007)(66556008)(6506007)(31696002)(305945005)(7736002)(4326008)(186003)(26005)(86362001)(36756003)(14444005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3637;
 H:BYAPR12MB3560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mNC9xmFMXwLhemFIkvtZVi5oOlS3RQzM/04RGgLIcG5p2qp3qxINPKRC3bfS2kF+hbXh0sde20DGcMAua8cE7QGujDok986lknqjUgVMRcF+0IdbizWwufaHUi3p6wtUZwxoks5Hi/KqkVj5ZLxj9uqpIFd3uktWULnVbQfLoLWHowKg2pwosDEZ2OJGv+ArSws3ld2bQElWkeOse2iLBkFvxjRuBhusAxhIW0cfufPRMrpcWGBLEkyznGoKid/VGq85hcWCrTNfvB9YUlQOGiq0JmssOyK0bg10CCCYpvI9HIhIGsGSg4oCFAfPQowOP/Wvaya4Oyux6PiKstjxsOJ5Buz3a4t4HdaROuCHcGSbN74ExMJAiAi/3wlA04Yvl+zCKzLEk1kl6RpVKRsSlV2bwxZp7oVkp6IJYJNkY35d3TQYpJyvkSw+7FLaGTPj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16b1a90-e0e0-4531-68af-08d7678a5331
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 16:06:49.7927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CuRk3+1/or3tHSPjKWHsLVsPC4DqbgugIzDDccdO5c+LA7EiOi7mNvfAQN85DBJ6GFbjydyEtv4Nlo6E3JgfAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3637
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9gaGIp9WwInU45Gz05+Af78eFKTcKDMe/ITcaPWvM4=;
 b=0A0/0WvAfgHJpG51zkjAKNy4XmUFd8JM8mvtKbKRRIz9abWvgaDqyb9bGBSpWNSyZR+KH48w8ABtWBlsDqtC0xYX+n8v2QgObLL8jYQ5cziib+HB3DvK2SG7HsEo214BeHMT6Fc2zPEmGThfwgGLuFcUZ/CXghMQi7CzNdxkA7M=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
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
Cc: alexander.deucher@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112160647.A8I5ihWxG43JLdDCc2yXj32lAZ3l_REsFoVlrrQC6Yg@z>

T24gMjAxOS0xMS0xMiAxMDoxNSBhLm0uLCBtaWtpdGEubGlwc2tpQGFtZC5jb20gd3JvdGU6Cj4g
RnJvbTogTWlraXRhIExpcHNraSA8bWlraXRhLmxpcHNraUBhbWQuY29tPgo+IAo+IFt3aHldCj4g
Rm9yIE1TVCBjb25uZWN0b3IgYXRvbWljIGNoZWNrIHdlIGhhdmUgdG8gY2hlY2sgYSBuZXcgQ1JU
QyBzdGF0ZQo+IGluc3RlYWQgb2YgYW4gb2xkIG9uZSwgd2hlbiBjaGVja2luZyBpZiBDUlRDIGlz
IGRpc2FibGVkIHRvCj4gcmVsZWFzZSBWQ1BJIHNsb3RzIGFsbG9jYXRlZC4KPiAKPiBTaWduZWQt
b2ZmLWJ5OiBNaWtpdGEgTGlwc2tpIDxtaWtpdGEubGlwc2tpQGFtZC5jb20+CgpSZXZpZXdlZC1i
eTogTmljaG9sYXMgS2F6bGF1c2thcyA8bmljaG9sYXMua2F6bGF1c2thc0BhbWQuY29tPgoKTmlj
aG9sYXMgS2F6bGF1c2thcwoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9h
bWRncHVfZG0vYW1kZ3B1X2RtX21zdF90eXBlcy5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX21zdF90eXBlcy5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fbXN0X3R5cGVzLmMK
PiBpbmRleCAyMWYwOWI2MWVlODguLjAwY2IyZjEwOTg1MyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9tc3RfdHlwZXMuYwo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX21zdF90
eXBlcy5jCj4gQEAgLTI5OSw3ICsyOTksNyBAQCBzdGF0aWMgaW50IGRtX2RwX21zdF9hdG9taWNf
Y2hlY2soc3RydWN0IGRybV9jb25uZWN0b3IgKmNvbm5lY3RvciwKPiAgIAkJcmV0dXJuIDA7Cj4g
ICAKPiAgIAlpZiAobmV3X2Nvbm5fc3RhdGUtPmNydGMpIHsKPiAtCQluZXdfY3J0Y19zdGF0ZSA9
IGRybV9hdG9taWNfZ2V0X29sZF9jcnRjX3N0YXRlKHN0YXRlLCBuZXdfY29ubl9zdGF0ZS0+Y3J0
Yyk7Cj4gKwkJbmV3X2NydGNfc3RhdGUgPSBkcm1fYXRvbWljX2dldF9uZXdfY3J0Y19zdGF0ZShz
dGF0ZSwgbmV3X2Nvbm5fc3RhdGUtPmNydGMpOwo+ICAgCQlpZiAoIW5ld19jcnRjX3N0YXRlIHx8
Cj4gICAJCSAgICAhZHJtX2F0b21pY19jcnRjX25lZWRzX21vZGVzZXQobmV3X2NydGNfc3RhdGUp
IHx8Cj4gICAJCSAgICBuZXdfY3J0Y19zdGF0ZS0+ZW5hYmxlKQo+IAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
