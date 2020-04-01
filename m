Return-Path: <SRS0=/bSq=5R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16E6C43331
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 20:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 877F6206CC
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 20:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yGnHM1tG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877F6206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A3E5892E7;
	Wed,  1 Apr 2020 20:57:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85B85892E7
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2020 20:57:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DefCAfMKpfgpJ2oNyVcQkxhw5k4aXvQi+7kulIhUgOl0qKEEIMBBUgtFcGyYhFGUF6ETrCXUv+I+V1crKRV+FHbaxb3PC9UVfZAsup2RyFfI0KPWBSk3Kru3x0ayaxN9Szcq9jRJWULCiOY7fneudLZw/7PXblJrPU1dr8WS4i6T3dgl3EprRgHuHEwhYy0hp4PoAM/hHXQldiQ3YMv2KSBFrQWvfwzjnEfrJRq97GVr2j48a5hgJp0hcEWocm5mS43x8RKoQ5bc68ae+URGkdbnbcVsRBT3SOjRTtrRptPAX3BOn71Cb4J5vUjzG+hq5cYqnJPVQEFWRrDE69Pmng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSl47tNu8OD1NyuOCuX9zpkWpApcswt+Zg7WXdSwHLQ=;
 b=dq5SxipSCxpS2aEvSO0OncRz1kjQWNKhnUph7/yLe3FUD2X2qICLVc6e8XFAGCkWfCdzunIAyrqYKUg4a3rKVVWP2Eevkt4XM+H0InzxzBgizBNQZvMRM5h1dV4li+2LLSLTEmCN7Lo61JS3nbcfPROhEiIHNvtLOQXh5HILL7Gv0jZuufGfvzdAJjMaJL1Z47fON6M0iMrJYHpczj15yGQLMqRzjfrna8xDWJL48IOSR6uSQd/BZDpXSrv05A0vidYtB6gw2d891uSKUaQ0B5oF1/Rtjd6U7w/nYZUXqOstNWYOpijzDolnR5WZEE/Tobs8NNBsazi74KLWteDXhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSl47tNu8OD1NyuOCuX9zpkWpApcswt+Zg7WXdSwHLQ=;
 b=yGnHM1tGJHI/hnN8kWeHQXG5ImbqIib5pv0i6QZkFMRrNXeqVGzgxkhleS6+WvMpK673TFJNyYFB0LCqLKxjTKx1MY7E92q8ToFfbWuQafLumYlDHzRxIEHmmRSuUK3yA6mE5sSUUYtBuqcS4Om9lvuPHOgm1dEmLImkTpopExI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2431.namprd12.prod.outlook.com (2603:10b6:802:27::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Wed, 1 Apr
 2020 20:57:31 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 20:57:31 +0000
Subject: Re: [PATCH] drm/amdkfd: kfree the wrong pointer
To: Jack Zhang <Jack.Zhang1@amd.com>, amd-gfx@lists.freedesktop.org
References: <1585743160-30110-1-git-send-email-Jack.Zhang1@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <54e5a182-036c-3749-7c13-3ce76b52f8e8@amd.com>
Date: Wed, 1 Apr 2020 16:57:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1585743160-30110-1-git-send-email-Jack.Zhang1@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::27) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YTXPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Wed, 1 Apr 2020 20:57:30 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2fb59105-a7e1-49d5-aed7-08d7d67f4b45
X-MS-TrafficTypeDiagnostic: SN1PR12MB2431:|SN1PR12MB2431:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2431EC526EB5F6D409C40E9C92C90@SN1PR12MB2431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(186003)(81166006)(66476007)(52116002)(66556008)(2616005)(44832011)(86362001)(31696002)(8676002)(478600001)(956004)(81156014)(16576012)(5660300002)(2906002)(8936002)(26005)(66946007)(31686004)(316002)(36756003)(6486002)(16526019);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bdeH1wBsGG946LH+7yDi31/C5REgyezABciuMS7VRfbrT9qNFwdV00Dh7XrhZorMP7RVn9e3Wo5+TE78+pHTVy4W98t6bN08YHDPU3o3UBh09u9Dql5fFBbvzEfhc2cOLG+d62AL8gNphKuXb4GwHIOrMfG/uEHYVx87/FRgk4Vs+y6Q7NMTNXAIVc/OXBzqTasjCC2PYgWQGc5m524Z7n6oDP+qT5vaiHyMP/R5En5Zh6kupSXUntU6ADsYmbEzICMPZsg9QmKdsAiobakTvZpc4+eBybFcr3fIMy9uVOuqeT+Qn/npiKLudaABQlhIvio7sWSv/HZFHeLuZWOsdvluG+9KccH1XZLBTZwMB6a0hBU0xTEDEWEVSL105DFtB9tkrMagO0zWH7viBHrhm1XFW/fF6AaCtHhE70fDdOVVSb244B1751MasPWjX3Pp
X-MS-Exchange-AntiSpam-MessageData: Wm7Dw85LAAE3v+viuyiy69iaxkTufrWSllXZKyOKi8tEiKnDrDxqntoKKzugx5CCxwp3sX6mIXS3vKAVf+Wj2bRx9Py/Tb5AFeSezZFzygkcC0crftz70XU99CmJX3s0jIku5dUg2NtC4yO7CfnsgA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb59105-a7e1-49d5-aed7-08d7d67f4b45
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 20:57:30.9732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13gDMxby7FB7QixavkOVp+cOG/zZOV8kZdRCQ+LyCFIgcVyLm/bX68R88XBZ+eFwWKmu0AZNcePuSggs7Zy8nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2431
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

QW0gMjAyMC0wNC0wMSB1bSA4OjEyIGEubS4gc2NocmllYiBKYWNrIFpoYW5nOgo+IE9yaWdpbmFs
bHksIGl0IGtmcmVlcyB0aGUgd3JvbmcgcG9pbnRlciBmb3IgbWVtX29iai4KPiBJdCB3b3VsZCBj
YXVzZSBtZW1vcnkgbGVhayB1bmRlciBzdHJlc3MgdGVzdC4KPgo+IFNpZ25lZC1vZmYtYnk6IEph
Y2sgWmhhbmcgPEphY2suWmhhbmcxQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxp
bmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+CgpUaGFua3MgZm9yIGNhdGNoaW5nIHRoaXMuIERp
ZCB5b3UgYWN0dWFsbHkgcnVuIGludG8gdGhpcyBjb2RlIHBhdGg/IEluCnRoYXQgY2FzZSB3ZSBt
YXkgYWxzbyBuZWVkIHRvIGluY3JlYXNlIHRoZSBHVFQgbWVtb3J5IHJlc2VydmVkIGZvciB0aGlz
CnN1YmFsbG9jYXRvci4KClRoYW5rcywKwqAgRmVsaXgKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYyB8IDQgKystLQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9kZXZpY2UuYwo+IGluZGV4IDc4NjZjZDA2Li4wNDkxYWIyIDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYwo+IEBAIC0xMTM0LDkgKzExMzQsOSBAQCBpbnQg
a2ZkX2d0dF9zYV9hbGxvY2F0ZShzdHJ1Y3Qga2ZkX2RldiAqa2ZkLCB1bnNpZ25lZCBpbnQgc2l6
ZSwKPiAgCXJldHVybiAwOwo+ICAKPiAga2ZkX2d0dF9ub19mcmVlX2NodW5rOgo+IC0JcHJfZGVi
dWcoIkFsbG9jYXRpb24gZmFpbGVkIHdpdGggbWVtX29iaiA9ICVwXG4iLCBtZW1fb2JqKTsKPiAr
CXByX2RlYnVnKCJBbGxvY2F0aW9uIGZhaWxlZCB3aXRoIG1lbV9vYmogPSAlcFxuIiwgKm1lbV9v
YmopOwo+ICAJbXV0ZXhfdW5sb2NrKCZrZmQtPmd0dF9zYV9sb2NrKTsKPiAtCWtmcmVlKG1lbV9v
YmopOwo+ICsJa2ZyZWUoKm1lbV9vYmopOwo+ICAJcmV0dXJuIC1FTk9NRU07Cj4gIH0KPiAgCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
