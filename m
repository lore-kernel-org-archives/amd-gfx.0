Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF85C3F2D1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 09:25:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A31A320732
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 09:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mNmSX4fm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A31A320732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D6566EAF8;
	Wed,  4 Mar 2020 09:25:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 109D46EAF8
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 09:25:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wt0n8tlTxEQRG/iT0DNM95QKOIr5csq2BqNrwXjJcAEhd0XeEAINxNQR1lxO6tyUIWghGRtS+UH7f8SvzPB6DPTkfoYwTrY2kAQLwoKViEQz2UHs0joLhKDKSFokXR62Cd8VnKqvPRfTbZpZKKoAQeGLyOBrffWCPto0EUFZ0YWXu7vx2sO3ZyCKAtVgYsnscmlKZ7FmwwRJTHlLiqkDM1utsC2tPF0q817G/KtDmTn0oJ4XbHWk35BJMEk0fgBLGXLtRI7XKRFGYZTFQGTS1cXqWGK10r8noG4Y10UewCqhFfLKkGmZ3ojuy+spSNpYJbYShIcnu82EILBm/jEhpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83ILuEL9jUgpaqg6XsSWU3svGfbWMZ2BuVuWlQw+eto=;
 b=T3BaqX4w32sWW5WYFdc4S+poCO93bsv1TM1/KbRz14YC9D6w2J9TjvAOwB8dMCstLBtj18aux9rAKIE+oDiINXZ36A+QBIDODXkPZZVkxsMDo1fVz4rjwNtMDQxdpF6W365QWpCVz7LWnWU2tGDC4FZoLpv4CaEDsgXJx5MeAx2C16CYONlEJrNwch+3Jr+voSRA+N3ISQ3NuwxyYRS25RaLUA/+4b7lUwSUle4oRLM03HDnILtH2YfHiZJ2P6+BVCqRsxvGKrG+dl56yFeggSDkaDxgfDsLw58OaXN/FyGq/FUP8a4BgnyoDB1+dHrj9WgJ7vEwHwCjtPAYH6z8rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83ILuEL9jUgpaqg6XsSWU3svGfbWMZ2BuVuWlQw+eto=;
 b=mNmSX4fm3zBvdYn7kvuOd8idQXAJNuMGU9Ua2WJnb7gx+l5UvmnIDwXXbl1Ce23NBJFh45womfC5Gp1c189GAlwpq//50cFmUZ1d2YKAOJ1sLtUNo007s0k9mexneii0xQCfAXZnh4Wf2qqvZQ/w0IcICV/1eUSszYNq6JU/N44=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB1548.namprd12.prod.outlook.com (2603:10b6:4:a::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.14; Wed, 4 Mar 2020 09:25:34 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 09:25:34 +0000
Subject: Re: [PATCH v6 1/1] drm/amdgpu: set compute queue priority at mqd_init
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200303125039.53141-1-nirmoy.das@amd.com>
 <99ff4cb5-3d6a-c14c-20c6-553d2b22df50@amd.com>
 <478f74f6-db21-0e52-9b19-e968d2fa6924@amd.com>
 <b866db7d-f084-158b-c891-32221109b839@gmail.com>
 <1f70969c-a608-bd1b-d13c-c25bcf9cd389@amd.com>
 <dcdb61d6-f675-e6ad-982d-27717a8e55d9@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <c3bcfce5-e851-7ba4-dd29-9ac2b2010c5c@amd.com>
Date: Wed, 4 Mar 2020 10:28:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <dcdb61d6-f675-e6ad-982d-27717a8e55d9@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR03CA0054.eurprd03.prod.outlook.com
 (2603:10a6:207:5::12) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f26:9100:77f7:329c:558a:14d0]
 (2003:c5:8f26:9100:77f7:329c:558a:14d0) by
 AM3PR03CA0054.eurprd03.prod.outlook.com (2603:10a6:207:5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18 via Frontend Transport; Wed, 4 Mar 2020 09:25:32 +0000
X-Originating-IP: [2003:c5:8f26:9100:77f7:329c:558a:14d0]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: acd40de8-a706-478f-4e7d-08d7c01dfdc8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1548:|DM5PR12MB1548:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB154868B493DD1A3A2E3DE7368BE50@DM5PR12MB1548.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(199004)(189003)(4326008)(31686004)(66946007)(478600001)(6486002)(2906002)(16526019)(186003)(53546011)(8676002)(6666004)(110136005)(81156014)(8936002)(2616005)(81166006)(66476007)(316002)(66574012)(31696002)(36756003)(52116002)(4744005)(66556008)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1548;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9yCY3J/3ejOQtvGC/VWGvIzLcqZ2x34zkXdpMFlodkylRsSuRFHJghJ+t7l7Az7es2g7lzSc5P0t7ZMfz/NaMyZJHGAUzbHjjwF/uCF1wAS8fqO8l+0FMzEpXqR3/rDE42T5ET/XEyYwxWlioaAS3L4d9bN97d7GnImQ8OzaVbyzjMF2WhH1zH21FyQDZrP/lPIEvwaQup/1jSZ5jjrFcDWXNYUDVO1hpmsc/u/GBNAdzBxO4pFFc1FiGuqYzEAuxCXPvr27n/uFj3QhDMFjPXUvyXOrp5FHzN3rJ6NHbdfI+hX635wvsw1E75kQJuuS7OOT4PGvxqqx1YM04Nwb2JhuH4gp7oBCFslIBfbZXFTBXvVyKI8RUcNl6rOom7kj1fPftX1WoDclpWAF2WUEOed87s8UcR+atYsaEycCXn4APSSZALrE+/vVsbObU5z2
X-MS-Exchange-AntiSpam-MessageData: yD7fIa3wORPliJqOLpbwrapBnoLpg5cA2RUkVmBWTJ6lDYLfLa0yTISvjocIe7qr1cVSHeSkpHl662AGUdm03LPM7ujell6xuVmSdgI/NfmaM0puGkEnr4sJiWpKNdE6KQQtbRKliu/7c9+hjWRT5/x4CuK7wXkDzSwa5KpjsVsn6JUefBBcqLKd2czJZmkA2x3CLWD38gNB35+pbBveIA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd40de8-a706-478f-4e7d-08d7c01dfdc8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 09:25:34.2590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S13gGD4R+uO/3sRZ6yBmn8YgEfQEUn618Q0jhPBU5jpB6gL6uIHu1eEZqk0u3l6BSqIfgVEUv6vP5wEEDQSgXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1548
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDMvMy8yMCA0OjMwIFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDAzLjAzLjIw
IHVtIDE2OjIyIHNjaHJpZWIgTmlybW95Ogo+PiBIaSBDaHJpc3RpYW4sCj4+Cj4+IE9uIDMvMy8y
MCA0OjE0IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4KPj4+Pj4gSSBtZWFuIHRoZSBk
cm1fZ3B1X3NjaGVkdWxlciAqIGFycmF5IGRvZXNuJ3QgbmVlZHMgdG8gYmUgCj4+Pj4+IGNvbnN0
cnVjdGVkIGJ5IHRoZSBjb250ZXh0IGNvZGUgaW4gdGhlIGZpcnN0IHBsYWNlLgo+Pj4+IERvIHlv
dSBtZWFuIGFtZGdwdV9jdHhfaW5pdF9zY2hlZCgpIHNob3VsZCBiZWxvbmcgdG8gc29tZXdoZXJl
IGVsc2UgCj4+Pj4gbWF5IGJlIGluIGFtZGdwdV9yaW5nLmMgPwo+Pj4KPj4+IFRoYXQncyBvbmUg
cG9zc2liaWxpdHksIHllcy4gT24gdGhlIG90aGVyIGhhbmQgZmVlbCBmcmVlIHRvIGdvIGFoZWFk
IAo+Pj4gd2l0aCB0aGUgYm9vbGVhbiBmb3Igbm93LiBcCj4+Cj4+IEFyZSB5b3UgZmluZSB3aXRo
IHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAKPj4gKipjb21wdXRlX3ByaW9fc2NoZWRbQU1ER1BV
X0dGWF9QSVBFX1BSSU9fTUFYXTsgZm9yIG5vdyBhcyB3ZWxsID8KPgo+IFllYWgsIHRoYXQgc2hv
dWxkIHdvcmsgYW55d2F5LiBNeSBvbmx5IGNvbmNlcm4gd2FzIGFkZGluZyB0aGUgYm9vbGVhbiAK
PiB0byB0aGUgcmluZyBzdHJ1Y3R1cmUuCgpUaGFua3MuCgpJIHdpbGwgbGF0ZXIgd29yayBvbiB0
aGUgY3R4IGNvZGUgY2xlYW51cCB0byBtb3ZlIGRybV9ncHVfc2NoZWR1bGVyIAphcnJheSBjb25z
dHJ1Y3Rpb24gdG8gYSBwcm9wZXIgcGxhY2UuCgoKUmVnYXJkcywKCk5pcm1veQoKPgo+IHJlZ2Fy
ZHMsCj4gQ2hyaXN0aWFuLgo+Cj4+Cj4+Cj4+IFJlZ2FyZHMsCj4+Cj4+IE5pcm1veQo+Pgo+Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
