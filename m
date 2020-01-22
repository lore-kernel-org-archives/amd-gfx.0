Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853E5C2D0DB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 15:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4799821835
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 15:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="d45ByTil"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4799821835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18C616F5A6;
	Wed, 22 Jan 2020 15:51:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C04526F5A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 15:51:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=js+jeoVs2RmlBlW6pHxOHIIvzX1nHbx00dHX9O08xFdzQhEqK17IJMMTcvArNBPUbRJYA5oeY5Mhdt1VOIgTBaDS4Siyun1SCVHnFGNOlpX06aRrqW+6ofgaVw3CjyammKba6rBGzQxSI1+KSPGag1eE2E8DVDK17Dae+dSURgsGT2qagmgwJrr2QuLGV/A3WnYYLEXcllCgAmOWhboVfB9bnOxl5qOQTyLBOhmTtS4jWiu6uYz1U71xbtQWXzdwoH8jvjTj5lznYb+SuurFr8r7HEBvNRYDFtsfrw6bI2TnEZ7BxcGVjYurCr9LiPM8s+YBLozdjWkM7nHTS6YInQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tkq7znC9UkAzGvByd+XpbPiyCfTBEmD8xllmr12FDQ=;
 b=BedsV8bW3tt0k0GXzH2pS23numg2U+g59lJf4NMgvOEDsVXe2YS4nqC+9/JfFjs2NeUXjnOj2AwJlqj+0rWpF41YzRFam4OLGvjTlv8qDCe2xiu1ko+8l6Nyw490zFNA21VyM7OkS80TYg4Bfh/V5iPRrGxdfeCBRwDdcUpWLmDUew4O3Jhiy5pt8kpFkDOw8nvO9qzUEJ6V8fhoouH3bbP50s5Ws/7tT92bNLwk+APFDrumwO9gakq2BQCopwpuZwPbYNLjTP6CMiWRycPSVEervba3ITYZzgsZe29Q80JODNeAsTC2XdOMoTqFR2N4iSx7LY0YANP4+fVs8+gw1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tkq7znC9UkAzGvByd+XpbPiyCfTBEmD8xllmr12FDQ=;
 b=d45ByTil0RTaFcqNSkGbJxC3/It94KAltFcS1CxPfJ1cPwb9GdzS+1f9WS5UabAsaa+pDhVZJjOX5ZaN5WtPE5JwkMjf2Jx4mMA3Tf/jX8gWqSnyVGPrQyvDG0V59jpZ36oJNy2jQUYSOLb0/Zi6IMg80C8/V4iFtZQhW7umzKc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB3401.namprd12.prod.outlook.com (20.178.198.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Wed, 22 Jan 2020 15:51:53 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a%7]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 15:51:53 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: allocate entities on demand
To: Nirmoy <nirmodas@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200121165002.3709-1-nirmoy.das@amd.com>
 <20200121165002.3709-2-nirmoy.das@amd.com>
 <50c72f0a-bc2d-3467-0312-edb0bb858fb4@amd.com>
 <d3a300b7-1516-b332-0e60-6acb36100a29@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <406c7e5c-6e43-23ce-2be7-b39968c98da2@amd.com>
Date: Wed, 22 Jan 2020 10:51:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <d3a300b7-1516-b332-0e60-6acb36100a29@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTOPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::42) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
Received: from localhost.localdomain (165.204.55.250) by
 YTOPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Wed, 22 Jan 2020 15:51:52 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c1c3b753-ea35-494d-b9ab-08d79f530021
X-MS-TrafficTypeDiagnostic: DM6PR12MB3401:|DM6PR12MB3401:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3401C2026B882B3687E5AB26990C0@DM6PR12MB3401.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 029097202E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(189003)(199004)(2616005)(6486002)(316002)(186003)(16526019)(478600001)(31696002)(86362001)(81156014)(2906002)(8936002)(8676002)(81166006)(53546011)(6506007)(66946007)(66476007)(66556008)(52116002)(4326008)(6512007)(31686004)(5660300002)(44832011)(36756003)(26005)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3401;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +yqsGJpdGmVKNn4v2CSBlx2xIpkD/AhsVP7izsipCnnTjYc2DLemWPerunS84Z15lYJkE7RD0An+ODGMFTaAaX2u4HvresehW3QOI39gqWF4fXMbHSJrMEH51hBSbzm+/hEs6D3I257XNUlpqrKtavjYMZXnppsLbMj5FCEQds218rAQSlmyQNLHaOf0ur998Nk4xKDU1PTJDx6+I+yNcM/P4VyedmHOe3ykLqjACea1Jde4HTkRR7Fwk2uvQ75wVXLryJPM0HgHZWJIQ30EtEQti+L0HLIw8m6pipAhsgGBDeFtWFznWApFzoTvCv5PPqSEKrSKd7JepE3ljBoYCOL+zV9V5UsNeSUXlQl9eQZ2iPc78TgzB4j1cc9NW+YFPQUXQ0D+ShKLlXktvekUNNFt4/FAoC0GEK4IuTzQDrAaN3API6YiB8hCkQsWp1AK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c3b753-ea35-494d-b9ab-08d79f530021
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 15:51:53.1625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GeSg67lUWq8v3W9jbQgc9+h0eNrFyGyGiUPAXOV8KYPauUKbuDnULLJ5xh7oELof
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3401
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wMS0yMiA0OjI1IGEubS4sIE5pcm1veSB3cm90ZToKPiBIaSBMdWJlbiwKPiAKPiBU
aGFua3MgZm9yIHJldmlld2luZy7CoCBXYXMgZXhwZWN0aW5nIGxvdCBmcm9tIHZpbSBhdXRvLWlu
ZGVudCA6LwoKWWVzLCBubyBwcm9ibGVtLiBJdCdzIGEgbGVhcm5pbmcgZXhwZXJpZW5jZSBmb3Ig
bWUgYXMgd2VsbC4KCklmIHlvdSB1c2UgRW1hY3MsIHByZXNzaW5nIFRBQiBhbnl3aGVyZSBvbiBh
IGxpbmUsIHdpbGwgaW5kZW50Cml0IGFjY29yZGluZyB0byB0aGUgbW9kZS4gKEl0IHJ1bnMgdGhl
IChjLWluZGVudC1saW5lLW9yLXJlZ2lvbikKTGlzcCBmdW5jdGlvbiwgd2hlbiB0aGUgbWFqb3Ig
bW9kZSBpcyAiQyIuKSBQcmVzc2luZyBUQUIgYW55d2hlcmUKaW4gYSBsaW5lIHdoaWNoIGhhcyBh
bHJlYWR5IGJlZW4gaW5kZW50ZWQgYWNjb3JkaW5nIHRvIG1vZGUsIGRvZXMKbm90aGluZy4KCllv
dSBjYW4gYWxzbyBpbmRlbnQgdGhlIHdob2xlIGZpbGUgKHJlZ2lvbikgYnkgcHJlc3NpbmcgQy1N
LVwuCgo+IAo+IE9uIDEvMjIvMjAgMTowNyBBTSwgTHViZW4gVHVpa292IHdyb3RlOgo+PiBPbiAy
MDIwLTAxLTIxIDExOjUwIGEubS4sIE5pcm1veSBEYXMgd3JvdGU6Cj4+Cj4+PiAtCQlzd2l0Y2gg
KGkpIHsKPj4+ICsJcHJpb3JpdHkgPSAoY3R4LT5vdmVycmlkZV9wcmlvcml0eSA9PSBEUk1fU0NI
RURfUFJJT1JJVFlfVU5TRVQpID8KPj4+ICsJCQkJY3R4LT5pbml0X3ByaW9yaXR5IDogY3R4LT5v
dmVycmlkZV9wcmlvcml0eTsKPj4gWW91IGRvbid0IG5lZWQgcGFyZW50aGVzaXMgYXJvdW5kIHRo
ZSByZWxhdGlvbmFsIGVxdWFsaXR5IG9wZXJhdG9yIHVzZWQgaGVyZS4KPj4gSXQgaGFzIGhpZ2hl
ciBwcmVjZWRlbmNlIHRoYW4gdGhlIHRlcm5hcnkgY29uZGl0aW9uYWwsIGluIHdoaWNoIGl0IGlz
IGVtYmVkZGVkLgo+IAo+IFBhcmVudGhlc2lzIG1ha2VzIGl0IG1vcmUgaHVtYW4gcmVhZGFibGUu
Cj4gCj4gCj4+PiArCWludCByOwo+Pj4gKwo+Pj4gKwlpZiAocHJpb3JpdHkgPCAwIHx8IHByaW9y
aXR5ID49IERSTV9TQ0hFRF9QUklPUklUWV9NQVgpCj4+PiArCQlyZXR1cm4gLUVJTlZBTDsKPj4g
VGhpcyBzaG91bGRuJ3QgYmUgcG9zc2libGUgc2luY2UgaXQgaXMgYW4gZW51bS4uLgo+IFdoYXQg
c2hvdWxkIG5vdCBiZSBwb3NzaWJsZSA/Cj4+IEJ1dCB3aHkgbm90IGRvIHRoaXMgY2hlY2sgaW4g
ImFtZGdwdV9jdHhfcHJpb3JpdHlfcGVybWl0KCkiCj4+IHdoaWNoIGlzIGludHJvZHVjZWQgYnkg
dGhpcyBwYXRjaHNldCBhbmQgdXNlZCBpbiB0aGUgaW1lZGlhdGVseQo+PiBmb2xsb3dpbmcgbGlu
ZT8KPiBNYWtlcyBzZW5zZS4KPj4KPj4gT3IgcGVyaGFwcyBmaXggdXAgYW1kZ3B1X3RvX3NjaGVk
X3ByaW9yaXR5KCkgd2hlcmUgaXQgaXMgbWFzc2FnZWQKPj4gZnJvbSB0aGUgaW9jdGwgYXJndW1l
bnQgd2hpY2ggaXMgYW4gaW50ZWdlci4KPj4KPj4gT24gYSBzaWRlIG5vdGU6IEkgbm90aWNlZCB0
aGF0IHRoZSBlbnVtIGRybV9zY2hlZF9wcmlvcml0eQo+PiBoYXMgbm8gRFJNX1NDSEVEX1BSSU9S
SVRZX05PTkUuCj4+Cj4+IEkndmUgZm91bmQgdmFsdWUgaW4gc2V0dGluZyB0aGUgZmlyc3QgdmFs
dWUgb2YgYW4gZW51bSB0bwo+PiAiX05PTkUiICh1bmxlc3MgemVybyBhY3R1YWxseSBoYXMgYSBt
ZWFuaW5nIGFzIHNldCBieSBIVy9ldGMuLCBhbnl3YXkpLgo+PiBFbnVtIGRybV9zY2hlZF9wcmlv
cml0eSBzdGFydHMgd2l0aCAiX01JTiIgYW5kICJfTE9XIiB3aGljaAo+PiBhcmUgYm90aCBzZXQg
dG8gdGhlIHNhbWUgKHplcm8pIHZhbHVlLgo+Pgo+PiBTbyBoYXZpbmcgRFJNX1NDSEVEX1BSSU9S
SVRZX05PTkUsIGNvdWxkIGJlIHVzZWQgdG8gZGVub3RlCj4+IHRoYXQgbm8gcHJpb3JpdHkgd2Fz
IGdpdmVuIGFuZCBhbnkgaXMgZmluZSwgb3IgdG8gbWVhbgo+PiB0aGF0IGlmIHRoZSBwcmlvcml0
eSB3YXMgZ2l2ZW4gb3V0IG9mIHJhbmdlLCBzZXQgaXQgdG8gIm5vbmUiLAo+PiB0byBtZWFuIHBp
Y2sgYW55Lgo+IAo+IE5vdCBzdXJlIGFib3V0IGlmIEhXIGFjY2VwdHMgMC4KCkV4YWN0bHkhIFdl
IHVzZSAiMCIgdG8gbWVhbiwgYXMgSSBkZXNjcmliZWQgYWJvdmUsCiJ0aGF0IG5vIHByaW9yaXR5
IHdhcyBnaXZlbiBhbmQgYW55IGlzIGZpbmUsIG9yIHRvIG1lYW4KdGhhdCBpZiB0aGUgcHJpb3Jp
dHkgZ2l2ZW4gW2J5IHRoZSB1c2VyXSBpcyBvdXQgb2YgcmFuZ2UsCnNldCBpdCB0byBgYG5vbmUn
JyB0byBtZWFuIHBpY2sgYW55IiwgdGhhdCBpcyBzbyB0aGF0CndlIGFjdHVhbGx5IGlucHV0IHRv
IGhhcmR3YXJlIGEgbWVhbmluZ2Z1bCB2YWx1ZS4KCkl0J3MganVzdCBhIGNvbnZleWFuY2UuCgpV
c2luZy9hZGRpbmcgIl9OT05FIiBpbiBlbnVtcyAoYXMgdXN1YWxseSB0aGUgZmlyc3QgZW51bWVy
YXRlZCBsaXRlcmFsICgwKSkKcmVhbGx5IGNoYW5nZXMgYWxnb3JpdGhtcywgYXMgaXQgbWFrZXMg
cmVwcmVzZW50aW5nIGNvbmNlcHRzIGVhc2llci4KKEtpbmQgb2YgbGlrZSB3aGVuIHdlIHNhaWQs
IGxldCBpID0gc3FydCgtMSkuKQoKUmVnYXJkcywKTHViZW4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
