Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B5CC2BA1A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 16:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 787A72076E
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 16:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BObTdjTE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787A72076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32AED6E120;
	Tue,  7 Apr 2020 16:13:22 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690060.outbound.protection.outlook.com [40.107.69.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1D5C6E121
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 16:13:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VD23P81kicVGCIm7Gz+xguBs3UBl/wAtcbYOLU/Pyx2liKEnenLx8sIKyfSKjOndKu4rZEdtFA230bJT7x3sl3DHTAXUauwi40awUAV9Id+AWVN1z9821PPiRR15gTnYIPQbV8jLr8QL4rBaJnap1H0FWWvNoMozGV3LVeVeNqHDE8zbmupR492nFwGe96LjnadCrrBUu50bmd0D5AgQSGLjwpShIHFzmh2N+iPtEFivZmOm/zIUlABABINgyxmlMFt5M+LCkADGhM2v0QG2npFS2hl+BH03PAq84TryFuUfqg7Eh5ECkUSXjtMIZLCvI+L3SQrAUjHefCjOJs6Xfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nk45kd934yKo5aUfN901yHNrBWmlnD0atOPwDFVd5s4=;
 b=Hs4brfA5hqtlxhT0RdEeRPR65Ll27Ao2SMsTvu97sCavioocuPrDAQk+g/zRLbhL7MVzUchTZOFpV4mWQBmBzW60Qe3scRIYwO8b8ly3RhQsA2FGKM1oRFGLLPQ1uknWPbXmYLH99pPCq5BJ4icPo+o8agiKi56PUpAzWR6snhaHqHA6loiuZvDDj3uLOHFMbXNJ4saIYelN57uRUtmEIGSbiM/ozm3YfG9dQzkrFFQFaMyxAggCE93BfDX8xnSRysX9lASCDOQCALGb4c1IFe2R4LCaTXhHFm6A2wyMWDofhwg89jK9FW2Nqw6IzlUBaF4G9njONPJBVaMel0OiMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nk45kd934yKo5aUfN901yHNrBWmlnD0atOPwDFVd5s4=;
 b=BObTdjTEOWDioZ5YfOED5EwIImWqQERcidinHRub0sG14B9fy7pH6ytAZSIu86nCeg+cI6DMe8iDi5RHzB/lC6hm/O/18tedMy0Iy+gudcJy0XsOhhc3ejWDSMTRFEKJbxUoFyLsyHsrwLkeMJTmxwPXzQuL0i86Z+OOlX7cx5s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2430.namprd12.prod.outlook.com (2603:10b6:802:30::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Tue, 7 Apr
 2020 16:08:53 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 16:08:53 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset in gpu
 reset
To: Jack Zhang <Jack.Zhang1@amd.com>, amd-gfx@lists.freedesktop.org
References: <1586247246-823-1-git-send-email-Jack.Zhang1@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <a9f3a445-fe79-cda3-cf7e-a3c6448f28aa@amd.com>
Date: Tue, 7 Apr 2020 12:08:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1586247246-823-1-git-send-email-Jack.Zhang1@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::23) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YTBPR01CA0010.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15 via Frontend Transport; Tue, 7 Apr 2020 16:08:52 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c8129dce-abdd-43b5-16e0-08d7db0df772
X-MS-TrafficTypeDiagnostic: SN1PR12MB2430:|SN1PR12MB2430:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24304FBFEE029E111B126ACB92C30@SN1PR12MB2430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(81166006)(478600001)(5660300002)(2616005)(8936002)(316002)(36756003)(44832011)(956004)(81156014)(16576012)(8676002)(52116002)(86362001)(186003)(66556008)(31696002)(66476007)(66946007)(26005)(6486002)(16526019)(2906002)(31686004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zTRUZRDq2rMbHGSERuocxK3eIAUuO5jU09l8LqhPV+oC+NjSpJUJpenn5yJSfP7vLi2mt4DcRqwLIVZxrDiMMvtQHM1D9M4OaeD6S6I5pk2kbDHupf0BQtiFsQsgMqh44Lk3xKM8igDXPZs8KpuwbUvym5QzjisaQNH+aPmCmMLAiafOX3B97C89fAxDUW/6PQldlRMOKj9A9vZDklVi9lUIJD5wbE6eB0uH32UCpbET70VaNAqoV7zxjd3ZYcYdjyc103DeI5TgjlD1/Yz50dady0KpLxEx4hLOhdWhKSS15Joh/3Qt9SNCOWM55viQ/oH1855VwrP3pOr+JeowahUA1eAXIFMmDAkbUCFY7wa8xrkw/3CYkUrvzsx9SDR7IW3tAbqUIt6zN93KAkuoNJ4Frj8MK/m75MHfpL6CjQ/2YiULw2ocvmPeJHL20Kkj
X-MS-Exchange-AntiSpam-MessageData: NEWJEswihtdEQo+sik5u/oXIGouPofMbF+dFN2J1779LkNXE2SoAWi5JTvYr+S6TrL1jcfv55RJ2vQZG2YcMZvux2Vltsg5gI5N5Wo3nmMZmlLl5i/ojbziKggGb6iDophhHNmZG0arF+ui0JCPTWA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8129dce-abdd-43b5-16e0-08d7db0df772
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 16:08:53.0470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nRkjAfxAGjDYpQCqFp70gL/A//7bgnV3bIS2Wb8x0baNbGY4xoWySGPFQuLSx5BvskkGBSdqOwjVfcSidOCZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2430
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

SSBkb24ndCBrbm93IHdoYXQgaGFwcGVuZWQgdG8gcGF0Y2ggMyBpbiB0aGlzIGxhc3QgcmV2aXNp
b24uIEFueXdheSwgdGhlCnNlcmllcyBpcwpSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxpbmcgPEZl
bGl4Lkt1ZWhsaW5nQGFtZC5jb20+CgpUaGFua3MsCsKgIEZlbGl4CgpBbSAyMDIwLTA0LTA3IHVt
IDQ6MTQgYS5tLiBzY2hyaWViIEphY2sgWmhhbmc6Cj4gW1BBVENIIDIvMl0KPiBrZmRfcHJlX3Jl
c2V0IHdpbGwgZnJlZSBtZW1fb2JqcyBhbGxvY2F0ZWQgYnkga2ZkX2d0dF9zYV9hbGxvY2F0ZQo+
Cj4gV2l0aG91dCB0aGlzIGNoYW5nZSwgc3Jpb3YgdGRyIGNvZGUgcGF0aCB3aWxsIG5ldmVyIGZy
ZWUgdGhvc2UKPiBhbGxvY2F0ZWQgbWVtb3JpZXMgYW5kIGdldCBtZW1vcnkgbGVhay4KPgo+IFNp
Z25lZC1vZmYtYnk6IEphY2sgWmhhbmcgPEphY2suWmhhbmcxQGFtZC5jb20+Cj4gLS0tCj4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDIgKysKPiAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYwo+IGluZGV4IGQ5NGVmZjkuLjJlMWY5NTUgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gQEAgLTM4NTIsNiArMzg1Miw4
IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RldmljZV9yZXNldF9zcmlvdihzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwKPiAgCWlmIChyKQo+ICAJCXJldHVybiByOwo+ICAKPiArCWFtZGdwdV9hbWRr
ZmRfcHJlX3Jlc2V0KGFkZXYpOwo+ICsKPiAgCS8qIFJlc3VtZSBJUCBwcmlvciB0byBTTUMgKi8K
PiAgCXIgPSBhbWRncHVfZGV2aWNlX2lwX3JlaW5pdF9lYXJseV9zcmlvdihhZGV2KTsKPiAgCWlm
IChyKQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
