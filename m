Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13606C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 23:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF879207E8
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 23:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QiGJRbv/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF879207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74FFB6E02E;
	Tue, 28 Jul 2020 23:29:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C616E02E
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 23:29:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzPhFVP/CBustodXLtEfowyg0kjG3Qeo+4kG/sq3It/c0QN8noMAF3VFrAL0QtuaS5iUllnc1XLLLJdy3+sN3T1pZ1Aud8LvgXqBoueorMr5NEf7wdXbYJmZ7TJZQZciRsNiNkYflXby+09YHCcFanBRDydaiLMRXrBk3gGVoN35BEt5O2gLrh5neIQxBCGKXKmQ5DuqWRl8AFiOf9lMUSzksT3qwwrO2YOBlQlVAIazROQsWWW+9RP3oympD/rPyWec1fBnPBwmN/0/BqtgM1YeSFs5It6EKobEo9bNPrHQxmsM7rSwZ37o6a6X2ID8kdcmVDdfnvvOpLutEWE+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVuzrQ/PvGv7FFwxXPSG4F7SMqVYhGKjqQhZq62BQM0=;
 b=cQ/zgNMks8Co1AZ82Qm4R+W+QkLtI8+eoRRTF+xTmckoLlF4KTDCBRHBX2drkOO+XzcuMHyAYj5XR//xtjv1VrxE3BVxCRobL8qN/EivaEjmO0OZBB31Qvf9HQt+rqtlsFnrrHuWogVLPHMwBHb2H+/heIrIxasxKGnpM+T0acGCbELJMeSP7g47PN76tfUIKtkJ+8w4EARZpfrxtgKDwS6Ciw276au9OngaQeYQED59RBJvtEpAY/DmZyVg7aFjB2MqrXFZ3nBokMBfyp66KfBHDVpQg2AKLPzYKK0mAt2oSR89eQ51t78YudXHrv+xb/5lqaVbOlCAhmn9lER7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVuzrQ/PvGv7FFwxXPSG4F7SMqVYhGKjqQhZq62BQM0=;
 b=QiGJRbv/85ITuvIz/Ma+sLYNLYmBN3BbrqCFaA5LNErpme2DMAeWbTDKyWZyIaJTLJZYXYe1goJ1iQLL5LZGZzpRPG3wVuP+DwtzWtaXNofo39HiOSkSo+JGKhG4FtJWkWorhtPQyxUGDd+EA2hPavX4d9z79N5tbZQwcFBgn6s=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2407.namprd12.prod.outlook.com (2603:10b6:4:b4::24) by
 DM5PR12MB1609.namprd12.prod.outlook.com (2603:10b6:4:10::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20; Tue, 28 Jul 2020 23:29:00 +0000
Received: from DM5PR12MB2407.namprd12.prod.outlook.com
 ([fe80::9c20:aa3e:1b50:7ce5]) by DM5PR12MB2407.namprd12.prod.outlook.com
 ([fe80::9c20:aa3e:1b50:7ce5%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 23:29:00 +0000
Subject: Re: [PATCH 14/14] drm/amdgpu/gmc: disable keep_stolen_vga_memory on
 arcturus
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20200728224605.3919-1-alexander.deucher@amd.com>
 <20200728224605.3919-15-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <da0539e2-69bf-61e2-8e88-cbe2af6bfd77@amd.com>
Date: Tue, 28 Jul 2020 19:28:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200728224605.3919-15-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::46) To DM5PR12MB2407.namprd12.prod.outlook.com
 (2603:10b6:4:b4::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.61.76) by
 YTBPR01CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23 via Frontend Transport; Tue, 28 Jul 2020 23:29:00 +0000
X-Originating-IP: [142.117.61.76]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 79b4daf4-d9fb-478f-97e3-08d8334e01d1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1609:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1609E9D53C73C24F4B8E8EAA92730@DM5PR12MB1609.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mIwWRY6jEpe5f3vptZpg6Yuf1tAG+mvrmVCzqfBOaDkJ3PIBNcJHfQq1cV6QQBxB5Cvl0n3n/dR2vyHUMwt1TwRqj+1+Wgz8jCYyU5l5sdSJC2Cxxoa70jwo92uPMybueeCsQoNqm77z4GLGNUtrWYjgvq5S/NqD8HQJcJEkyNgOGaCtkNzBKmvRgihw+w7iXxcZ84PF8xoh+13ZMguXlY5ijZgHABu1kiP3VRzjN32Jul4YqH+UCdfAvrxkbCpOf5n++Rq3ugTQDKCs2t50iSpC4nuo+UHUpiUBPSLfJOE7zmPA+/tPJA4sk2aGoVQSYg1+SarY+8m6rMjCWbAVf/fEA8KSHVQG4EFz5GtziSu9XWIGkxlH5McnkQB6Rlcr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2407.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(66946007)(2906002)(66476007)(66556008)(26005)(478600001)(6486002)(16576012)(956004)(8936002)(110136005)(316002)(36756003)(2616005)(186003)(16526019)(5660300002)(8676002)(83380400001)(31686004)(86362001)(44832011)(52116002)(31696002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: rpr0x0zj3ckuTzkANM2ppkhzo0vWwYTQilZ5u1LCiAnnPdj2SmlyFfS81tu84CmuGkTgHC3KsApJdPrCBX7QFnMmqsU0HGU4l9t/977u1XrLdEWrXxpqUQWWXQ6PZ2XkRHmrePze3SC5X8Zo92UdT836133xuRqqJTKYT4iEStrbvIdKdJ8/T3CwaETJHrb+Zb1PkO4+cslKviwJi+An/9y+1Ktl+macU+RkHX8y9CpWcJ5h+fLWKIrueBPFLx75L3dkit3otQ5Pbkfk4cmFKD2McXF0lUqPXwI3NV1Yq2hK76+EctIeeGDEgl1lWhBgaqo8PAkrnqLd0wzK2UkSOYD6MdL8tIv6LOm6jnnqHw4vyGIRDKOcH+vr+NjQpfhiQ535OE4oriS5tCPoAV3QBCdUlt/jXP4IPZByIa6T1n97OuTT6CUlHFAHNhWSUAQ4zEWPZm35Ku9h52IWt2Y69/DGudBdx1B7Bj/rB/GXEqoLcNg9RiBnR1GI8/cFliAZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b4daf4-d9fb-478f-97e3-08d8334e01d1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 23:29:00.5912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USkDpZx618/kwwGePLOxxeYF+kWoovHvcGsMD4lOFzOqCluBnKN7IwJVx/qPwe52v6z9DYO9h1xOR0aO2U9GyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1609
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

QW0gMjAyMC0wNy0yOCB1bSA2OjQ2IHAubS4gc2NocmllYiBBbGV4IERldWNoZXI6Cj4gSSBzdXNw
ZWN0IHRoZSBvbmx5IHJlYXNvbiB0aGlzIHdhcyBzZXQgd2FzIHRvIGF2b2lkIHRvdWNoaW5nCj4g
dGhlIGRpc3BsYXkgcmVsYXRlZCByZWdpc3RlcnMgb24gYXJjdHVydXMuICBTb21lb25lIHNob3Vs
ZAo+IGRvdWJsZSBjaGVjayB0aGlzIG9uIGFyY3R1cnVzIHdpdGggUzMuCgpTb3VuZHMgcmVhc29u
YWJsZSwgZ2l2ZW4gdGhhdCB0aGUgb3RoZXIgb2ZmZW5kZXJzIGhlcmUgYXJlIGFsbCBBUFVzLgpB
RkFJSywgd2UgaGF2ZW4ndCB0cmllZCBTMyBvbiBBcmN0dXJ1cy4gRG9lc24ndCBzZWVtIGxpa2Ug
c29tZXRoaW5nIG9uZQp3b3VsZCBkbyBvbiBhIHNlcnZlci4KClNlZSBvbmUgbW9yZSBjb21tZW50
IG9uIHBhdGNoIDEuIE90aGVyIHRoYW4gdGhhdCB0aGUgc2VyaWVzIGlzCgpSZXZpZXdlZC1ieTog
RmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+CgpSZWdhcmRzLArCoCBGZWxp
eAoKCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYyB8
IDEgLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9nbWMuYwo+IGluZGV4IGZjOWUxOGFhYTc2ZS4uMGJkN2IzNzk3NTM0
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYwo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYwo+IEBAIC00NDgs
NyArNDQ4LDYgQEAgdm9pZCBhbWRncHVfZ21jX2dldF92Ymlvc19hbGxvY2F0aW9ucyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikKPiAgCXN3aXRjaCAoYWRldi0+YXNpY190eXBlKSB7Cj4gIAlj
YXNlIENISVBfVkVHQTEwOgo+ICAJY2FzZSBDSElQX1JBVkVOOgo+IC0JY2FzZSBDSElQX0FSQ1RV
UlVTOgo+ICAJY2FzZSBDSElQX1JFTk9JUjoKPiAgCQlhZGV2LT5nbWMua2VlcF9zdG9sZW5fdmdh
X21lbW9yeSA9IHRydWU7Cj4gIAkJYnJlYWs7Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
