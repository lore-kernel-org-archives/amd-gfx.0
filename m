Return-Path: <SRS0=Hu2c=BR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C851BC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 15:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98BDC21744
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 15:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q+IADXFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BDC21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44E1D6E0AD;
	Fri,  7 Aug 2020 15:06:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 057B86E0AD
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2020 15:06:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A27B6SjKD458W1B8KZbMDPUMRM/K4UOnSWixpDpesaZXzlvTh7ZhWKEHzZojFUg1VA0AuPrliEH2BD8O91nSak69RbivYuZr1ahD1WdL0VGmLXl2X0zDzDm5Ab3GG/kDFI4gOczoYPkNBb8yqntID7oW3Y0VnncX4gGbId4LuN6B5rtU2tvJLe57sbj2h7QWKlNEWS8blMRdmKzgSuTkt6WJBxGGfT/vT8nYQ2t8io1V84BxBrZ49eTUeotS3sRgny9WXSxK/HxpQWhjElswgzPJ/sLLypzoyLQs7Tx9LQZpZx8gjbZDGgNEcwyVXWF4uicI8A0aQDE2yLBKtN6r/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNN7ffCyWidGgVkqC/mzIMLqVMgHQztHzoCLNqfSmlo=;
 b=dTZCHiOHSuw0RzJMC7FYLY5XBNtv2Pk7CTSiJRinaOCqvcaAhYgqdygZVvUFqYqzOFgfvRlvzr77J2D3itKLeS/P8JgckspRjyft5r/MY08HBRKTufaO0sgb7pHbtM1YtTJFgqXcA+Zxt9MO9UgzskLvFD/xN7QctSGLToybClp7cLyKlTf2OkWTnA4pO0EI23vUjXaKpsGJorJUG9S7rcZbQXC9g1xkiAGKCctxjoPQ+R8eS3fOkypeiVlhlJyqtPb7gNRzAvkGGlGqI6ZFOrhHOZzoum/sMYx7ZyS+URQ9df/PcnjuxgSXRu0LzRIrga8pg9fhWA9UfYooYBOKyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNN7ffCyWidGgVkqC/mzIMLqVMgHQztHzoCLNqfSmlo=;
 b=q+IADXFXpXIemfp4Fd6BdjEF/QWi28nhHf6deqwL4CA2eYPCENjhkFCrmASuiQNkcVox/sVEow8UIe64JFSnbKyc2K+CIqxScnMYvH0VT0/C4aqIoP+eQjllO++icD6JI8ipTejI+XrGtmZl3WnGF24Q7FB2ttpY3QdS/B9sZaQ=
Authentication-Results: daenzer.net; dkim=none (message not signed)
 header.d=none;daenzer.net; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2541.namprd12.prod.outlook.com (2603:10b6:802:24::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Fri, 7 Aug
 2020 15:06:42 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::657c:114:220c:88f9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::657c:114:220c:88f9%7]) with mapi id 15.20.3239.023; Fri, 7 Aug 2020
 15:06:42 +0000
Subject: Re: [PATCH] drm/amdgpu: stop touching bo->tbo.ttm
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200807123302.139759-1-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <58eb348a-4db3-4878-f1e3-1d9ea7743d8f@amd.com>
Date: Fri, 7 Aug 2020 11:06:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200807123302.139759-1-christian.koenig@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YQBPR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::15) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YQBPR01CA0079.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19 via Frontend Transport; Fri, 7 Aug 2020 15:06:41 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f5906d92-4afc-4268-e87f-08d83ae37dfc
X-MS-TrafficTypeDiagnostic: SN1PR12MB2541:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2541AB681EBA4867A72150AB92490@SN1PR12MB2541.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zb4EqjJLrypL7rekEuHlvOxgaLrGDc3LfAun6Jl8OoJIsyLnFljlsLmLPYN8HUYoggleo5Joo7uSHBxsTrmAmh7DRi7E+V4Sd8DjIe0zMv0z0Yz61nmHCl2MCohMd//rO9PFcF1ZD3pCzASAZer+eGtygqYeRFD8GQThVZ1+Iol71wh1gP1EoXrE8QXF7bKUPUvjk1Bi1vanHh3h49TQCdy1J2cUGwfMj2qCUAdlzj48Np0qjJpOe4Ey3y9/PEzpdLdeWiKomp8JcQCAELV4k1omMqD1ZXz+pyhLNPcQgsrTH+SiC2OL6xkG1gXOvVM4nEmFqbT6oIbkUcYcvnhSXbBK7wOGS8VRpajRY28gIfyud6loRNecMSqUEMeN0Blm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(44832011)(83380400001)(31696002)(5660300002)(4326008)(16526019)(66574015)(66946007)(36756003)(66556008)(26005)(186003)(66476007)(956004)(6486002)(316002)(2616005)(16576012)(52116002)(86362001)(2906002)(8936002)(8676002)(31686004)(478600001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: cXJnaeRQJB0rpXM2L+5uC7P11y1EIA55rTU9t6HY62hEoMlZYRkjTNiZnWgWK0FY9jmTT1/OH9468E2sV3j2WiBLfjeVktz+AWtoocUHM6VIu015phH3zB3FyexQArqx5jz/0WgyM4yfvQpdVIY9++37pd5im32ZzWhW41ce8CV/zM6Aq4i1Sj9d8nM9incd9Wl5gy2UAg86E3p5G+LSs7KS0a/4fASG0lYhVM61LT62hOmN8izne38d4uUhYSLsmBsiYy8W6bcor4A8owpYh1K5aCQ6XJbk2MUKRczCg87JnVPYa5DOFsvVLC6a7joM9gDJVQUEnkmWktJMf7UHpQAiyRKUeFLoHXZGXksC2A8aCeF6erWsIX4rTLBmDAicCsowkoZYCeMfvyBJbwyuML0pgFdY4H3sg0Dz7uqLsveQETVHjCYs+QCmvGIZ/xTuHG1LQIZpoFw86Q6j7JPNkH7FDUPj4YMPnEL8oqMqAPUJ/crQ8gBh1nRgXIXqrpi08znPpI5vosjU8CqchXYrE8MCY4uiXD+xcoGDXGWhFW0+8m+txKwdELC2pmT+e71hfMcYDmGLcAO9ZYghldSomJgJzPUEIOWX0Sojwixg4F5BkiFYB/1U/crd40T4dGLa+dw/qHUxubcruCKLdzgxEQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5906d92-4afc-4268-e87f-08d83ae37dfc
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 15:06:42.3006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YehEexcdy4IUaTAq/bbNpz+OKc4W3+0ciH68E2XpxA/vKKhB9VIYKvbPmh4ScrPzjJHFKmmBokfdA5sl2v6ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2541
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
Cc: michel@daenzer.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CkFtIDIwMjAtMDgtMDcgdW0gODozMyBhLm0uIHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPiBU
aGlzIGlzIG5vdCBhbGxvY2F0ZWQgYW55IG1vcmUgZm9yIFNHIEJPcy4KQ2FuIHlvdSBwb2ludCBt
ZSBhdCB0aGUgcmVsZXZhbnQgVFRNIGNoYW5nZXMgdGhhdCByZXF1aXJlIHRoaXMgY2hhbmdlPwoK
V2UnZCBuZWVkIHRvIHRlc3QgdGhhdCB0aGUgU0cgQk8gaXMgc3RpbGwgd29ya2luZyBhcyBleHBl
Y3RlZC4gQQpkb29yYmVsbCBzZWxmLXJpbmcgdGVzdCBvciBhIEdQVSBIRFAgZmx1c2ggdGVzdCBp
biBLRkRUZXN0IHNob3VsZCBkbyB0aGUKdHJpY2suCgpSZWdhcmRzLArCoCBGZWxpeAoKCj4KPiBT
aWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0u
YyB8IDQgKy0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25z
KC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ft
ZGtmZF9ncHV2bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9n
cHV2bS5jCj4gaW5kZXggOTAxNWM3Yjc2ZDYwLi4yNDcwYjkxMzAzOGIgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4gQEAgLTEy
MzIsMTAgKzEyMzIsOCBAQCBpbnQgYW1kZ3B1X2FtZGtmZF9ncHV2bV9hbGxvY19tZW1vcnlfb2Zf
Z3B1KAo+ICAJCQkJZG9tYWluX3N0cmluZyhhbGxvY19kb21haW4pLCByZXQpOwo+ICAJCWdvdG8g
ZXJyX2JvX2NyZWF0ZTsKPiAgCX0KPiAtCWlmIChib190eXBlID09IHR0bV9ib190eXBlX3NnKSB7
Cj4gKwlpZiAoYm9fdHlwZSA9PSB0dG1fYm9fdHlwZV9zZykKPiAgCQliby0+dGJvLnNnID0gc2c7
Cj4gLQkJYm8tPnRiby50dG0tPnNnID0gc2c7Cj4gLQl9Cj4gIAliby0+a2ZkX2JvID0gKm1lbTsK
PiAgCSgqbWVtKS0+Ym8gPSBibzsKPiAgCWlmICh1c2VyX2FkZHIpCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
