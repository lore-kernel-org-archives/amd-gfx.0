Return-Path: <SRS0=r20P=DW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6832C43457
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 18:10:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BBD722284
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 18:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xnA7T9RO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BBD722284
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89BF66E04E;
	Thu, 15 Oct 2020 18:10:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BEE06E04E
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2020 18:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgzxIdhHlM2DYuDN6B/rLO9+QZJT7WOo84KbFi9gX3H8vlVpZSK9iAPeM5yifr7uz1mb8Egz3LaeG6ya7p0cbeQwC1QCA0jHge83/33Bfs+0FF8SvrXvGH52eFO7l8XTF+6WYPLr5JsVfDLYzz9eMuR1qvCCDcXPtlgHhMcaSKrAi+ZXCn9Thduqb77QJJAj7qB7sZzKAHZFOFa/9nTJdgUSvQCVvbFAvn7O5RybblHLO95rZ8zw6PaA1Y0OUKltOuoey5vll4r5fyH28WQvfL4QduaIrSJXJDEsbjUhkMG8kpyOrQCRDrySsxGLbUPSs0owk9FzLf+HiFSPJW5sHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ra+uhTMGA2oYZp/p5G68i05guWMeaR1G5X1F5cZeer4=;
 b=T4WuOwwBB0ka+tG9EoeVDePo3BmDgvNqrtao31z8o6+pH+tBWvwqKRLUeKK4Fsf5QZ0exyutWBQ3aI+95dFUJKMicxgXUB+R8OLps/8Bw+oHWnCrqy+5PwHDp1dcTMrt+fNN5FBS+NjSHjJQl0aSJeVn3WmdMMyoDdlPK5/UJv/wAbyFQbmaY4d2Gr6RJoZK3xhm4XPvCmioTrGbr7Yi4S2yB4KNzsBMwgFZPFMRQr3TEV4+1wNi9qbf7aEXrORCz8jd3Mrqlk9jEcxv5zfTlGMZFYdZcfFajZuJ2iR91TGMfKeV9BcGZi1vc5koJ9WFUtrNk7JMCS/5Ss/tw5uyxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ra+uhTMGA2oYZp/p5G68i05guWMeaR1G5X1F5cZeer4=;
 b=xnA7T9ROSvDAbgF5gIrHUvct//oDaS0DlKN0p37n+4GHUKkPyNk4TaPDhmkb0bGEKNVPAhmMVnkk6pHJfM6W3XZ5pXIBY8Tz8LPKs51U2+6AEzDfL+B1yoXqZuUtW2F0D1fO/pbETb8VJPFS820aKdEJ5hV6KzwjVVkhTXuqjW4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2987.namprd12.prod.outlook.com (2603:10b6:5:3b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Thu, 15 Oct
 2020 18:10:16 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::935:a67:59f8:7067]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::935:a67:59f8:7067%7]) with mapi id 15.20.3477.020; Thu, 15 Oct 2020
 18:10:15 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: nuke amdgpu_vm_bo_split_mapping
To: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
References: <20201013170820.1548-1-christian.koenig@amd.com>
 <20201013170820.1548-2-christian.koenig@amd.com>
 <2eff0639-03df-b8e7-1895-1390cd6773b5@amd.com>
 <b6c3412a-245d-f1a2-02f4-9f0e2a0f05f0@gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <81c5cb44-f93e-52bf-63c0-641e345b38f1@amd.com>
Date: Thu, 15 Oct 2020 14:10:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <b6c3412a-245d-f1a2-02f4-9f0e2a0f05f0@gmail.com>
Content-Language: en-CA
X-Originating-IP: [108.162.131.176]
X-ClientProxiedBy: YT1PR01CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::29) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.2] (108.162.131.176) by
 YT1PR01CA0060.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.20 via Frontend Transport; Thu, 15 Oct 2020 18:10:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c2e64cea-cd32-47fc-947e-08d871359116
X-MS-TrafficTypeDiagnostic: DM6PR12MB2987:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB298727F1A00FA6833C4FDB0B99020@DM6PR12MB2987.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YP32j0cByLnNHr7ndt+OVgIkGqM3bZA4OJm/sTU6SBD8hCVtH147BUxRM2R8y+lY+rACTldD34i6oln/VtPPDIhRbDgkhElpEr5doyZiHsDXtFr8zDHzj70rxR/o6KZALwyDKdx2NvsZObMBQZX5TekR7pH1gSYlbpbae1V5EkcFwG+8NCKHXuH0gS1krLKKpCDhjOGncmsU847TxlKCoCrz8CBOIFk9qu/wQIb6g5vER+x8KcqgzJyXElKhjI5vDE+56az93ryteXo57kjwhIYbtIJOVDmNF2E+5fLxtLgjtjjoVxBAOSo2zhvPgbB1M5NNyXpDf4OKmM+SNFbidy6MyHEPKjiq+65m76ptkdn+qp1x9PnLPRD7+hEZj9JpG5VCajAgRhKKbLK629CTc1udzAThMgbJ/zeETDTtCCE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(956004)(26005)(478600001)(31686004)(52116002)(55236004)(4326008)(8936002)(2906002)(8676002)(16526019)(4001150100001)(186003)(34490700002)(6486002)(36756003)(31696002)(53546011)(4744005)(16576012)(2616005)(6666004)(86362001)(5660300002)(316002)(66556008)(66946007)(66476007)(44832011)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: JZBnkTW25YI5aU0ZZQNgyXcuYSL1kRABnqEqpqkWz97Z8weNBZ6k89fmipaWzV0/umcgF1t2JmFORZvm1u8E8lL2Q0D8CAmvwZuuDOI3n6DoqcZjE5d1VHOZawzVIptu2NBI6wiH9We9PEGEk9AAOjxg7nbci85DcQl/FPnr/gbWC8VdzZ9Ne8aW2HOQ25KZwXCHRvDfXVGaZBHWmS7zGgWkCysGbEj0vUTAqVSWutl4QE5H8qcyjPOvh5VgCdb67vakv/x6sCEA0ePS2q2Um/Fo5/T8UX6TVUPEh+8lNDFpNPfCaXiePGoHj6Cdbj0UE/hh9VV7QjQ8U8125DtP1pgx0AVdbUH9XeVaPpbl5kiIFDkFlFPpHBFsA75Z76AVe7j7TQF7nbjba/3rd5T8z9joiofKBb30ljxU3NZDPI55EGVZw9STGmPl+BcDlGYDM1BMmGyD08xv3AI3qXAmkpYZ4dN1MVcuqDHbL3QHiV+NkMHRLBllgVN5RKNfyZIIcafIjdpv+8AEScuadB1JUQjrd3+cQcc4Dnvh3Ay2p7nFDoeVPFULd2yoYaN4PT7BDzOTQFTWeFz/Kh/atd4d22tLtGug//uUuIGdEmJOuG7GMmVy/R6lhSF8elGlRsWDi2EsJAC5555lomsOMTypIA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e64cea-cd32-47fc-947e-08d871359116
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 18:10:15.8394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxPB/eNmiiNomHJ1mvlNhTzUycL/ue81WpzzIH4Pi3Bq0nV/yn2/Btt/XitRdslw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2987
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
Cc: Madhav.Chauhan@amd.com, xinhui.pan@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0xMC0xNSAwMzowNCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+ICAgCj4+PiAr
CXBmbiA9IG9mZnNldCA+PiBQQUdFX1NISUZUOwo+Pj4gKwlpZiAobm9kZXMpIHsKPj4+ICsJCXdo
aWxlIChwZm4gPj0gbm9kZXMtPnNpemUpIHsKPj4+ICsJCQlwZm4gLT0gbm9kZXMtPnNpemU7Cj4+
PiArCQkJKytub2RlczsKPj4+ICsJCX0KPj4+ICsJfQo+Pj4gKwo+PiBJIGJlbGlldmUgaGVyZSB5
b3UgY2FuIGp1c3QgZG86Cj4+Cj4+IAlpZiAobm9kZXMpCj4+IAkJbm9kZXMgKz0gcGZuIC8gbm9k
ZXMtPnNpemU7Cj4+Cj4+IFNvIGxvbmcgYXMgcGZuIGFuZCBub2Rlcy0+c2l6ZSBhcmUgbm9uLW5l
Z2F0aXZlCj4+IGludGVnZXJzIGFuZCBub2Rlcy0+c2l6ZSBpcyBub24temVybywgd2hpY2gKPj4g
Y29uZGl0aW9ucyBhcHBlYXIgdG8gYmUgc2F0aXNmaWVkLgo+IFRoYXQgd29uJ3Qgd29yaywgdGhl
IG5vZGVzLT5zaXplIGlzIG5vdCBjb25zdGFudCBidXQgYmFzZWQgb24gd2hpY2ggYml0cyAKPiB3
aGVyZSBzZXQgaW4gdGhlIG9yaWdpbmFsIGFsbG9jYXRpb24gc2l6ZS4KPiAKPiBJbiBvdGhlciB3
b3JkcyBpZiB5b3UgYWxsb2NhdGUgODRLaUIgb2YgbWVtb3J5IHlvdSBnZXQgbm9kZSBzaXplcyBv
ZiAKPiA2NEtpQiwgMTZLaUIsIDRLaUIgSUlSQy4KPiAKPiBUaGUgZXhjZXB0aW9uIGlzIGlmIHdl
IGhhdmUgYW4gYWxsb2NhdGlvbiBsYXJnZXIgdGhhbiAyTWlCIGFuZCBhcmUgaW4gYW4gCj4gb3V0
IG9mIG1lbW9yeSBzaXR1YXRpb24uIEluIHRoaXMgY2FzZSB3ZSBjYXAgYXQgMk1pQiBhbGxvY2F0
aW9ucy4gQnV0IAo+IHRoaXMgY2FzZSBpcyBzbyByYXJlIHRoYXQgaXQgaXMgcHJvYmFibHkgbm90
IHdvcnRoIHRoZSBleHRyYSBoYW5kbGluZy4KCkFoLCB5ZXMsIHRoYW5rcyBmb3IgY2xhcmlmeWlu
Zy4KClJlZ2FyZHMsCkx1YmVuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
