Return-Path: <SRS0=uBoY=42=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5663CC10F25
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 19:30:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2754D20578
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 19:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0g7O4cTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2754D20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7AAF6E525;
	Mon,  9 Mar 2020 19:30:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25CFB6E525
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2020 19:30:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cc5sN8YHcE6OMLcmoiVOynckQAUlfNNrgG5M+LnAMezvVcAAg+w/QW1/lizDcTu1UDK9fEGKM206uPy6+3xJ178gw8nfVZUKk9Y69hJNHmRV92a4gVimNWkUn/qULEaPM3gDolFegMcZyYRYlD8P/w7iYigfuZUcPBGovZ1R2oTCigG00KfX4k0eJUiQbv1a06KxFk+BQsdUq2CyMqOFFhkFxZnCu8tDkG7ES/t7xB1EqYcXfyYwbz19xypGOENINfJc+q+jg6WL+1nmOulSG6Q/23on3R0EtjT46XiKRG8nNYJK6oS2n5+YHOiLY1ciUJYDz/r0VHMda4xK4o6aXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYbamhYvukdyWMpPlG32joJgeaYbDF6S/FciclchCjs=;
 b=K0IU3nl27+bdT48KIj+5nTvmn26h3NZVkIsE4soQ+lZb0Awyte0+Kq0deB3sxX7RIQ3z4cPQK/cBFaRTPZSLCicx5ThicKQ0BIaDO/eTA2y+/Ldu2xqmVGZmDBpf1CMIfFh3AmNRc5Ibpsfi5zq/g2TuYfdW8qAh3OaaTyccTWs0UbX0UN6CMiatcP4k6TnOc6rB5htTeyZTIjKJ5c+RWiZT99rxxRuyU41/WWs+/rEGy+5NRXVKMxTG+X4CyRcYCGi1EN5kxafmhP3lXSMsVS8jC8G4BMceEaq4tx213BCBg3/EqMSLwBvVo102vgOcmY9X0REbJFjxaDuYf2/pMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYbamhYvukdyWMpPlG32joJgeaYbDF6S/FciclchCjs=;
 b=0g7O4cTbNt4JbooTWYCf2/zp1wu6Co2j0ujizu2wmNYOlcf0Nzw+CA+ZpxGXSdYxL+IVaaSHWNo1qVS10j5dTiBvsLRngDXuat2oP3mo6kvj0R2HnicZtsYupsIIpRYQQUpYlpKy1ggjrfp951dPk+V5Neh110rP4n9deE1n/bQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (2603:10b6:4:53::12)
 by DM5PR1201MB2553.namprd12.prod.outlook.com (2603:10b6:3:eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Mon, 9 Mar
 2020 19:30:49 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a%6]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 19:30:48 +0000
Subject: Re: [PATCH] drm/amdkfd: Use pr_debug to print the message of reaching
 event limit
To: Yong Zhao <Yong.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200309182511.25716-1-Yong.Zhao@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <13950c0d-3efa-0080-c5dd-c45cc8a7e5d3@amd.com>
Date: Mon, 9 Mar 2020 15:30:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200309182511.25716-1-Yong.Zhao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::37) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.229.252] (165.204.55.251) by
 YTOPR0101CA0060.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend
 Transport; Mon, 9 Mar 2020 19:30:48 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f3a8fc93-dd14-4255-618b-08d7c4605edc
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2553:|DM5PR1201MB2553:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB25538BDF3FCDA79B5F941DFC92FE0@DM5PR1201MB2553.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(189003)(199004)(5660300002)(53546011)(52116002)(66556008)(16576012)(66476007)(66946007)(6486002)(316002)(36756003)(44832011)(2906002)(15650500001)(86362001)(478600001)(16526019)(186003)(31696002)(956004)(2616005)(81156014)(31686004)(8676002)(8936002)(81166006)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB2553;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SalhsUqZ+gXgKUyBcq8dbWYK3bROtWdGxVk+8MGsafcW4o43PSLbmxeCwPOIc5V6tFUKs3YQe+uuXmuOUzLabP8RghEtm6JJf8u+vTkioBR/dK0RlOlsT5Kkjdgg/d6kAHFz24NWI7zTpBDrjvEzj0d7/TrbiLtf0Y0vlAzabBuaP5eH3fKEm7ObZLz1/dmctuNsPIP9A5eEDS9JPK61N7Sdla+Hl4llhsaYqTYB9YHriUtErl5lmwegu0GKtRv3uSN2372cHYiI1dyqbgcPGffi3BjSL9qpO/g9C6whGUDNdES8cyXVDvd6glPh55j79tP0yZca7r728naEntgsXJ4P86S+Hccu92ZkcSHyK2XbAUufuhqFw1OHs/73MArtHvSgLkofqDHgKIR2Fpo0qny08kdw0LGfbARIrElbsqqw1hxfJEgtJw9W0l577vcX
X-MS-Exchange-AntiSpam-MessageData: HD2NsH/kSwKXrd+vOr15lWmAor9VXYw2aVis72Yp7PuJiUAmygSYVg7B+K6X+HIMcF27wtrey0lFbZuljEe6IgzLKUlHcy61oO7BALFwK8h7/UieYXR0jmMtB1eyAN6WZ3vGvyC0iRVafQdmboGr3Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a8fc93-dd14-4255-618b-08d7c4605edc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 19:30:48.6738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PS1YJoVJkCJR4xnuWqlDYlfVerwc7uPEHkec5SYsVDIaSWZ/UX3GrneMKQg7mBzJBKnzJT/wAFrxWa54t3XJlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2553
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

T24gMjAyMC0wMy0wOSAxNDoyNSwgWW9uZyBaaGFvIHdyb3RlOgo+IFBlb3BsZSBhcmUgaW5jbGlu
ZWQgdG8gdGhpbmsgb2YgdGhlIHByZXZpb3VzIHByX3dhcm4gbWVzc2FnZSBhcyBhbgo+IGVycm9y
LCBzbyB1c2UgcHJlX2RlYnVnIGluc3RlYWQuCj4KPiBDaGFuZ2UtSWQ6IEkzYWM1NjVhMmJkM2I4
ZDU3MzQ1ODEyMTA0Yzg3MjE4Mzg5OGQyMzdmCj4gU2lnbmVkLW9mZi1ieTogWW9uZyBaaGFvIDxZ
b25nLlpoYW9AYW1kLmNvbT4KClJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3Vl
aGxpbmdAYW1kLmNvbT4KClRoYW5rcywKIMKgIEZlbGl4Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX2V2ZW50cy5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX2V2ZW50cy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX2V2ZW50cy5jCj4gaW5kZXggMWY4MzY1NTc1YjEyLi4xNTQ3NmZjYThmYTYgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2V2ZW50cy5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2V2ZW50cy5jCj4gQEAgLTE4Nyw3ICsxODcsNyBA
QCBzdGF0aWMgaW50IGNyZWF0ZV9zaWduYWxfZXZlbnQoc3RydWN0IGZpbGUgKmRldmtmZCwKPiAg
IAlpZiAocC0+c2lnbmFsX21hcHBlZF9zaXplICYmCj4gICAJICAgIHAtPnNpZ25hbF9ldmVudF9j
b3VudCA9PSBwLT5zaWduYWxfbWFwcGVkX3NpemUgLyA4KSB7Cj4gICAJCWlmICghcC0+c2lnbmFs
X2V2ZW50X2xpbWl0X3JlYWNoZWQpIHsKPiAtCQkJcHJfd2FybigiU2lnbmFsIGV2ZW50IHdhc24n
dCBjcmVhdGVkIGJlY2F1c2UgbGltaXQgd2FzIHJlYWNoZWRcbiIpOwo+ICsJCQlwcl9kZWJ1Zygi
U2lnbmFsIGV2ZW50IHdhc24ndCBjcmVhdGVkIGJlY2F1c2UgbGltaXQgd2FzIHJlYWNoZWRcbiIp
Owo+ICAgCQkJcC0+c2lnbmFsX2V2ZW50X2xpbWl0X3JlYWNoZWQgPSB0cnVlOwo+ICAgCQl9Cj4g
ICAJCXJldHVybiAtRU5PU1BDOwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
