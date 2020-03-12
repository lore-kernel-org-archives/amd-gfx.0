Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847DBC1975A
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 10:53:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5191320716
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 10:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XaqZh+cO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5191320716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C94B6E14C;
	Thu, 12 Mar 2020 10:53:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A59FD6E14C
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 10:53:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6ia/LWoPmzJ41jqdymKtmvez55wrTMVVpZfixZUzrpDNiR+nANjFcOpTGiPrOYmn3RJFfXlLVBrv3GPYG6AF1OMEEpfNCKgQTThPoYtqwbeaaAr4/psY5uYGIoPOHiqDiejmPuSC1i5CM4EpYc7YpbZLTczJwoSktt6kgiDKN0sa5D0I4dt/1ThW3D18L5cie6Ney3r5jI8GscBSxq1Ry7Mpxaoa78Ibckz6DJzr6/3JVD9kqUlGidZqqgitNXGaYEldhLiyX3kyveYFmsASgsg++LaWTNtSMAJNK0p8BNC4BoxJyG8OqQZULnv4yQZAqfuYC4/QnbG1Mox0YKgnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cX2Npa7YSXLHbrSCfr9nAwwwPJ9DI879rPgaN8Vcc0g=;
 b=YNmrIeAC+J+Q1CqLRijQMePey6gUU3847HPq0koFUn7qupoN7cRXIJypmJrXi5PEuf1RzQvy/yvPeR4ActWQv22t22VWRbvdlYxP6cmhzXeVsdP38WJH+rKy5Moas8irW0weyVhNC0AiIOLvrOUAZGpVQdN3falliRzQWw9cRV+AGxD+cdN3Z8oElEIcZ7ML1Jced25FyTSmPXeoScvms7q1vCwvyh/X0WW/Ko4bait+46ZQCcvc8jBZ77i6DIr0xKJbdR8eM/CmEMidy+4rSp5Jk2izaVclWzfWquz6ILpFT4Ib0SpyTtCGWaZFOfFFRxXY/i9kleGr37YdpcYBsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cX2Npa7YSXLHbrSCfr9nAwwwPJ9DI879rPgaN8Vcc0g=;
 b=XaqZh+cOuXdaUPJN2ZHnM3A4qd+wNON3wc/+GXdFmf0o9KPy71IHpPDcv2gMxHM9kZG5ajR6q7iDIal7x0/jg0deNCjVxmD97F3/QVDAqHfoYzJxMsHIeAtTxc9CqH0tcdFqEN7ZjsVZGrcSwaMpNzuH/bYLZDDyLsSBaiwhnEI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB1930.namprd12.prod.outlook.com (2603:10b6:3:10d::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16; Thu, 12 Mar 2020 10:53:01 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 10:53:01 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: disable gpu_sched load balancer for vcn
 jobs
To: christian.koenig@amd.com, Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200311200032.50502-1-nirmoy.das@amd.com>
 <4fc782f4-8274-f69a-e4f8-8b087511a94d@amd.com>
 <745e7c4e-1dd7-ec7c-a787-88410414faab@amd.com>
 <4ee422df-5b57-ea1e-ae42-0ef702a657a8@amd.com>
 <ee63269d-8c95-cbb2-c64d-55a5061feb44@amd.com>
 <8b7ea4fd-01b3-72d8-8fa3-4745fe011fce@amd.com>
 <f007d1af-08e8-eb20-1ef5-5d6f18e56273@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <3fac4046-0c2c-7fa9-7c83-6af9149e50bf@amd.com>
Date: Thu, 12 Mar 2020 11:56:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <f007d1af-08e8-eb20-1ef5-5d6f18e56273@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: ZRAP278CA0014.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::24) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2a:a600:4a84:7cc6:5ea4:121a]
 (2003:c5:8f2a:a600:4a84:7cc6:5ea4:121a) by
 ZRAP278CA0014.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16 via Frontend Transport; Thu, 12 Mar 2020 10:52:59 +0000
X-Originating-IP: [2003:c5:8f2a:a600:4a84:7cc6:5ea4:121a]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c1b6a3c4-5896-450f-cb0c-08d7c6738880
X-MS-TrafficTypeDiagnostic: DM5PR12MB1930:|DM5PR12MB1930:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1930FA81422B99EFD7F9AC728BFD0@DM5PR12MB1930.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(199004)(66476007)(52116002)(81156014)(8936002)(4326008)(66574012)(81166006)(66556008)(5660300002)(6486002)(36756003)(478600001)(53546011)(66946007)(186003)(31696002)(16526019)(8676002)(6666004)(2616005)(2906002)(31686004)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1930;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r2pBfpVlHVFmv7ibaGOrFQwgqk+4vRa1JRpC/OZysab6ER/SfrzrUvhTH1dfbKicbPVVi2Xee9YDVy9vtR100W5d39MtgT3sAHKFySZ5BQJZvvRLglWVpSaA2jPc3zI51W//7mPJD8d/82vWQxOqqoASa1AezWMXKQRtHAVKgpjHnkZ08Q20beVHaXRVm068JpaCeslkDx2QQutPE8Qed509U1yS4QyHF2ZLtmk43an/LsDWHFl0FN++h5KHSJHsXvis9K9E6EgOOBsmZ2XQUvJ3RAoQE2pUovMGI3+bvIj/QQ/QFCccDwIcPDPcFb8MhrtXcqS4ENNXIgXWy04AoJRXhQmO2XFfZcLgOwwMe7D20cLvgov1WgLBfthyJhNvIlNpwKkuo7VD81RfRS7vhgyHWtH61qeXmfvmJl5mr0pGGlsvztz1hHDkIOBFRtlV
X-MS-Exchange-AntiSpam-MessageData: HQlj7qq0Y37kGPkkpnC4zG6Y/ksN/u2CyhqPK28NlcRSs1rmd/GZpG3PtwpZRyms0AvjuXyd1vTy6713cq1xZf+IJWna+4wa7oZUt6nKrq8p+r6qUmhzXl/riogKhPEdSJHx5ucRSugjAIqN8pinvjlDcZN35CIni1gRUKs9qIHnfpXgpg2e44SpvhNXoG2FRaWjOsMmGRlS9n1sD4OqZg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b6a3c4-5896-450f-cb0c-08d7c6738880
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 10:53:01.5302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSRPPlsOulfM+uM4yZkaBBZvUkQiU9O61+hYPavENAaz/Wi+Pb7V67581QNO6QxO+Ua1mv0iXAvMQ0jpVpl/tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1930
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
Cc: alexander.deucher@amd.com, Boyuan.Zhang@amd.com, nirmoy.das@amd.com,
 Leo.Liu@amd.com, James.Zhu@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDMvMTIvMjAgOTo1MCBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAxMS4wMy4y
MCB1bSAyMTo1NSBzY2hyaWViIE5pcm1veToKPj4KPj4gT24gMy8xMS8yMCA5OjM1IFBNLCBBbmRy
ZXkgR3JvZHpvdnNreSB3cm90ZToKPj4+Cj4+PiBPbiAzLzExLzIwIDQ6MzIgUE0sIE5pcm1veSB3
cm90ZToKPj4+Pgo+Pj4+IE9uIDMvMTEvMjAgOTowMiBQTSwgQW5kcmV5IEdyb2R6b3Zza3kgd3Jv
dGU6Cj4+Pj4+Cj4+Pj4+IE9uIDMvMTEvMjAgNDowMCBQTSwgQW5kcmV5IEdyb2R6b3Zza3kgd3Jv
dGU6Cj4+Pj4+Pgo+Pj4+Pj4gT24gMy8xMS8yMCA0OjAwIFBNLCBOaXJtb3kgRGFzIHdyb3RlOgo+
Pj4+Pj4+IFtTTklQXQo+Pj4+Pj4+IEBAIC0xMjU3LDYgKzEyNTgsOSBAQCBzdGF0aWMgaW50IGFt
ZGdwdV9jc19zdWJtaXQoc3RydWN0IAo+Pj4+Pj4+IGFtZGdwdV9jc19wYXJzZXIgKnAsCj4+Pj4+
Pj4gwqDCoMKgwqDCoCBwcmlvcml0eSA9IGpvYi0+YmFzZS5zX3ByaW9yaXR5Owo+Pj4+Pj4+IMKg
wqDCoMKgwqAgZHJtX3NjaGVkX2VudGl0eV9wdXNoX2pvYigmam9iLT5iYXNlLCBlbnRpdHkpOwo+
Pj4+Pj4+IMKgICvCoMKgwqAgaWYgKHJpbmctPmZ1bmNzLT5ub19ncHVfc2NoZWRfbG9hZGJhbGFu
Y2UpCj4+Pj4+Pj4gKyBhbWRncHVfY3R4X2Rpc2FibGVfZ3B1X3NjaGVkX2xvYWRfYmFsYW5jZShl
bnRpdHkpOwo+Pj4+Pj4+ICsKPj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4gV2h5IHRoaXMgbmVlZHMgdG8g
YmUgZG9uZSBlYWNoIHRpbWUgYSBqb2IgaXMgc3VibWl0dGVkIGFuZCBub3QgCj4+Pj4+PiBvbmNl
IGluIGRybV9zY2hlZF9lbnRpdHlfaW5pdCAoc2FtZSBmb3JhbWRncHVfam9iX3N1Ym1pdCBiZWxs
b3cgPykKPj4+Pj4+Cj4+Pj4+PiBBbmRyZXkKPj4+Pj4KPj4+Pj4KPj4+Pj4gTXkgYmFkIC0gbm90
IGluIGRybV9zY2hlZF9lbnRpdHlfaW5pdCBidXQgaW4gcmVsZXZhbnQgYW1kZ3B1IGNvZGUuCj4+
Pj4KPj4+Pgo+Pj4+IEhpIEFuZHJleSwKPj4+Pgo+Pj4+IERvIHlvdSBtZWFuIGRybV9zY2hlZF9q
b2JfaW5pdCgpIG9yIGFmdGVyIGNyZWF0aW5nIFZDTiBlbnRpdGllcz8KPj4+Pgo+Pj4+Cj4+Pj4g
TmlybW95Cj4+Pgo+Pj4KPj4+IEkgZ3Vlc3MgYWZ0ZXIgY3JlYXRpbmcgdGhlIFZDTiBlbnRpdGll
cyAoaGFzIHRvIGJlIGFtZGdwdSBzcGVjaWZpYyAKPj4+IGNvZGUpIC0gSSBqdXN0IGRvbid0IGdl
dCB3aHkgaXQgbmVlZHMgdG8gYmUgZG9uZSBlYWNoIHRpbWUgam9iIGlzIAo+Pj4gc3VibWl0dGVk
LCBJIG1lYW4gLSBzaW5jZSB5b3Ugc2V0IC5ub19ncHVfc2NoZWRfbG9hZGJhbGFuY2UgPSB0cnVl
IAo+Pj4gYW55d2F5IHRoaXMgaXMgYWx3YXlzIHRydWUgYW5kIHNvIHNob3VsZG4ndCB5b3UganVz
dCBpbml0aWFsaXplIHRoZSAKPj4+IFZDTiBlbnRpdHkgd2l0aCBhIHNjaGVkdWxlcnMgbGlzdCBj
b25zaXN0aW5nIG9mIG9uZSBzY2hlZHVsZXIgYW5kIAo+Pj4gdGhhdCBpdCA/Cj4+Cj4+Cj4+IEFz
c3VtcHRpb246IElmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHkgd2Ugc2hvdWxkbid0IGJlIGRvaW5n
IGxvYWQgCj4+IGJhbGFuY2UgYW1vbmcgVkNOIGpvYnMgaW4gdGhlIHNhbWUgY29udGV4dC4gQ2hy
aXN0aWFuLCBKYW1lcyBhbmQgTGVvIAo+PiBjYW4gY2xhcmlmeSB0aGF0IGlmIEkgYW0gd3Jvbmcu
Cj4+Cj4+IEJ1dCB3ZSBjYW4gc3RpbGwgZG8gbG9hZCBiYWxhbmNlIG9mIFZOQyBqb2JzIGFtb25n
IG11bHRpcGxlIGNvbnRleHRzLiAKPj4gVGhhdCBsb2FkIGJhbGFuY2UgZGVjaXNpb24gaGFwcGVu
cyBpbiBkcm1fc2NoZWRfZW50aXR5X2luaXQoKS4gSWYgd2UgCj4+IGluaXRpYWxpemUgVkNOIGVu
dGl0eSB3aXRoIG9uZSBzY2hlZHVsZXIgdGhlbgo+Pgo+PiBhbGwgZW50aXRpZXMgaXJyZXNwZWN0
aXZlIG9mIGNvbnRleHQgZ2V0cyB0aGF0IG9uZSBzY2hlZHVsZXIgd2hpY2ggCj4+IG1lYW5zIHdl
IGFyZSBub3QgdXRpbGl6aW5nIGV4dHJhIFZOQyBpbnN0YW5jZXMuCj4KPiBBbmRyZXkgaGFzIGEg
dmVyeSBnb29kIHBvaW50IGhlcmUuIFNvIGZhciB3ZSBvbmx5IGxvb2tlZCBhdCB0aGlzIGZyb20g
Cj4gdGhlIGhhcmR3YXJlIHJlcXVpcmVtZW50IHNpZGUgdGhhdCB3ZSBjYW4ndCBjaGFuZ2UgdGhl
IHJpbmcgYWZ0ZXIgdGhlIAo+IGZpcnN0IHN1Ym1pc3Npb24gYW55IG1vcmUuCj4KPiBCdXQgaXQg
aXMgY2VydGFpbmx5IHZhbHVhYmxlIHRvIGtlZXAgdGhlIGV4dHJhIG92ZXJoZWFkIG91dCBvZiB0
aGUgaG90IAo+IHBhdGggZHVyaW5nIGNvbW1hbmQgc3VibWlzc2lvbi4KCgoKPgo+PiBJZGVhbGx5
IHdlIHNob3VsZCBiZSBjYWxsaW5nIAo+PiBhbWRncHVfY3R4X2Rpc2FibGVfZ3B1X3NjaGVkX2xv
YWRfYmFsYW5jZSgpIG9ubHkgb25jZSBhZnRlciAxc3QgY2FsbCAKPj4gb2YgZHJtX3NjaGVkX2Vu
dGl0eV9pbml0KCkgb2YgYSBWQ04gam9iLiBJIGFtIG5vdCBzdXJlIGhvdyB0byBkbyB0aGF0IAo+
PiBlZmZpY2llbnRseS4KPj4KPj4gQW5vdGhlciBvcHRpb24gbWlnaHQgYmUgdG8gY29weSB0aGUg
bG9naWMgb2YgCj4+IGRybV9zY2hlZF9lbnRpdHlfZ2V0X2ZyZWVfc2NoZWQoKSBhbmQgY2hvb3Nl
IHN1aXRhYmxlIFZOQyBzY2hlZCAKPj4gYXQvYWZ0ZXIgVkNOIGVudGl0eSBjcmVhdGlvbi4KPgo+
IFllcywgYnV0IHdlIHNob3VsZCBub3QgY29weSB0aGUgbG9naWMgYnV0IHJhdGhlciByZWZhY3Rv
ciBpdCA6KQo+Cj4gQmFzaWNhbGx5IHdlIG5lZWQgYSBkcm1fc2NoZWRfcGlja19iZXN0KCkgZnVu
Y3Rpb24gd2hpY2ggZ2V0cyBhbiBhcnJheSAKPiBvZiBkcm1fZ3B1X3NjaGVkdWxlciBzdHJ1Y3R1
cmVzIGFuZCByZXR1cm5zIHRoZSBvbmUgd2l0aCB0aGUgbGVhc3QgCj4gbG9hZCBvbiBpdC4KPgo+
IFRoaXMgZnVuY3Rpb24gY2FuIHRoZW4gYmUgdXNlZCBieSBWQ04gdG8gcGljayBvbmUgaW5zdGFu
Y2UgYmVmb3JlIAo+IGluaXRpYWxpemluZyB0aGUgZW50aXR5IGFzIHdlbGwgYXMgYSByZXBsYWNl
bWVudCBmb3IgCj4gZHJtX3NjaGVkX2VudGl0eV9nZXRfZnJlZV9zY2hlZCgpIHRvIGNoYW5nZSB0
aGUgc2NoZWR1bGVyIGZvciBsb2FkIAo+IGJhbGFuY2luZy4KCgpUaGlzIHNvdW5kcyBsaWtlIGEg
b3B0aW11bSBzb2x1dGlvbiBoZXJlLgoKVGhhbmtzIEFuZHJleSBhbmQgQ2hyaXN0aWFuLiBJIHdp
bGwgcmVzZW5kIHdpdGggc3VnZ2VzdGVkIGNoYW5nZXMuCgoKPgo+IFJlZ2FyZHMsCj4gQ2hyaXN0
aWFuLgo+Cj4+Cj4+Cj4+IFJlZ2FyZHMsCj4+Cj4+IE5pcm1veQo+Pgo+Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
