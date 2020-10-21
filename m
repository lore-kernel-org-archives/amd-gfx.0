Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079EFC4363D
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 02:48:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63A7522240
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 02:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uLHTewhp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A7522240
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 921296E841;
	Wed, 21 Oct 2020 02:48:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46C6D6E841
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 02:48:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCiCMp45Xxr0pq6c6C3hzvXwhdEmUL+bhkNwwIBDLMlVuyejcBZ9LrBQb/soZ5ZF8BuI0ayzVCsbHV+1GYCCyu/WEHbxDIDAMlXgxE2GosgaDCqjXD50smddkRS6BhcBYJaQGVH2zsmSW78qL8x1QCWAc6yW35R4hMLrw0WerPaYuvkauXPWsq2BHah1+z8Mj78pWm1XWBshxoBJ6Douf12/k9QtJCuxBykXNKUDr1Tq7zvnZOaSG1P5/8qY5oCWWK7VFK1T6V7W887uL4IhraPoJTeq1KbMiMOnKH+iCH06ow+lUmM2iQsImEeXtf3dG2TkXSkDdUTun+L+TeG1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0lh5Ie26nrSiNcDmGXBAj+fCo6yzRhUqKGZtoG1RRQ=;
 b=l2dwzZGpQfeKB8Eu2YwFR8Mc0Q5GmeYdmK4udVA7qf/EcJaT+8IHVhVbyScF3jyzONSOk2d3cJrSg8w9bR3+WyG3UkkRzmfzBoTFNJwgjDXmCLVxMHEvWoZlyktHRq0RA9+AExFRTGaFWtlOpPzM2dnYTbZfS80XjimHOwGqdUAANdOEoDpY0o3oE3PtEnhxomF/IysP+6zgm8hVPe14CY43RKTBAeP8jArebnWifWqchU0YHIuer9ZxEznQvNMF3M49NTEJZMkbTWwETqqGwPb5KRM1hdrkfy1tWXnfCXd1CYqVHkEQK7vOfJ1Tj76570bpyVYfXTaxvzNA3RoU4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0lh5Ie26nrSiNcDmGXBAj+fCo6yzRhUqKGZtoG1RRQ=;
 b=uLHTewhpkK6CLeHKfT+uYpGuBSHzD85mAV7bMd0hKmFDQMYsL6e9G4xF7QJ7k6WeV50VDrP1+aSEMp4EkXMO4i8yGCIj5G5Kv8+hUfxjFnbPr4+ArnnswcJ8Q7hhdL9suAA0KyLxFIogjjrjjUNebkGYacc7SKfopB5pm44jl0o=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR1201MB0096.namprd12.prod.outlook.com (2603:10b6:301:55::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Wed, 21 Oct
 2020 02:48:47 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624%11]) with mapi id 15.20.3499.018; Wed, 21 Oct
 2020 02:48:47 +0000
Date: Wed, 21 Oct 2020 10:48:37 +0800
From: Huang Rui <ray.huang@amd.com>
To: Marek =?utf-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: Re: [PATCH] drm/amd/display: Initialize num_pkrs on VANGOGH.
Message-ID: <20201021024837.GA896161@hr-amd>
References: <20201020223113.310402-1-bas@basnieuwenhuizen.nl>
 <CAAxE2A5HdVj41F7BhnXzZzEpGLDowPat0tWxVrAA0trvZ6p8JQ@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CAAxE2A5HdVj41F7BhnXzZzEpGLDowPat0tWxVrAA0trvZ6p8JQ@mail.gmail.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR04CA0088.apcprd04.prod.outlook.com
 (2603:1096:202:15::32) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK2PR04CA0088.apcprd04.prod.outlook.com (2603:1096:202:15::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 02:48:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7385ca5e-ddba-40c3-9a22-08d8756bd4d7
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0096:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0096627DADC7BB60CB1E72DCEC1C0@MWHPR1201MB0096.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wCUPEcQ+o4TuUD5H2Jq3tBb/QhqGaNdQUQRCvENhd/1L00NziXtD2GLMK+RO1lCwjBE7bJ4Qowhg/aRBrtGPhWOEvP0GF213SFL2A1NRnw9woSMlY+bsfMO5XbC007qyRjNpU0dcumFZlJ++7Yb/hYjJjNT3Ro17ocgbUo7cjOXqv2MKpCpOXdVf9GWCG5OlhCix5pUpKd7OgQxWwKtVa7fd0p1bLUXXLji4u4oHQ7pPwjNqdA3BbxQputfbisPVQNx+7FBLvdH8cJIEAvsBP4T1llPUwUxMJ9juVZcEu5mEjk9IWnoUuEumqSyAhQS5+UPIdDMWF6y3BRBrDhWC88E9JWjIgc1vKLRNM7nzvfQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(5660300002)(66476007)(33716001)(83380400001)(110136005)(6666004)(2906002)(9686003)(54906003)(316002)(66556008)(66946007)(1076003)(4326008)(966005)(956004)(55016002)(478600001)(8936002)(33656002)(45080400002)(86362001)(8676002)(26005)(16526019)(186003)(6496006)(52116002)(53546011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: X8+Pwz0gcMqYP4NkU40fb1JotFr65ReCrVhhkfoFNTJApnhhNSGqd71NqgywpajfAn7krkJfHFRrguhfHPBEz90+47aStbvCcNL3rhE5qEM0Nrot0fWit4ZH/AWQvmllFErwn/OYD3OMqUkVMjtVs7E25a+WmFc234JT+YnAm51nJfLPEHZqOb7lDgl7oiBtHb5VE4k0kFR2MRWvnqsAWpWvQ0uSBCKRU6XE6m3lS8mbQCKTjz1lxuWLy2mqE9wR2F8nzdS6HH4MBtvcicS2WI3+7r/6X9HlkN0on2WVu8SAhX4VCqd1VgmQ+0ODMKY547dRbWhRx/pMjWBvxRzsXDbRta4FxH/nLzzxZpEZVIfoSawLWJdSGpHpFkDL8+3SCI5oDT/0G2VmteCYimdfnHCtw7NIzjEIR2is1nQE+dpNVRPS0cpTuvhbkLlpXBFq0o4uycYwlEKVJTrspb2q5skwOAWYAIlOBO1R7nV8qJwTlgaQKXGnAdeooVPA/o2G10lWcnTuT7WQ9/zwRTcP0YW91encS3hjiYMfgn0yxjWw13o8YUj4FbRdOVYLUGQ65xCezgdbTcong0SGkaSnFFAW+N3g0aua8oNkK1lAp9wV4WATcxnaHPchm/z+8PZsC0Y9B8Uglc3rUdfZ5WYdBA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7385ca5e-ddba-40c3-9a22-08d8756bd4d7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 02:48:47.0852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEBSJKG/jFV0Ae33ZL7nRx4RwPt4fcf+MXtdPmM6eiQ6AN53faHa0RJ2a7+irUDpMzzQ9k9a+9PoiJP7heDiZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0096
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, Roman.Li@amd.com,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBPY3QgMjAsIDIwMjAgYXQgMDc6NDc6NDJQTSAtMDQwMCwgTWFyZWsgT2zFocOhayB3
cm90ZToKPiBGWUksIHRoaXMgZml4ZXMgdGlsaW5nIG9uIFZhbkdvZ2guCj4gCj4gUmV2aWV3ZWQt
Ynk6IE1hcmVrIE9sxaHDoWsgPG1hcmVrLm9sc2FrQGFtZC5jb20+Cj4gCj4gTWFyZWsKPiAKPiBP
biBUdWUsIE9jdCAyMCwgMjAyMCBhdCA2OjMxIFBNIEJhcyBOaWV1d2VuaHVpemVuIDxiYXNAYmFz
bmlldXdlbmh1aXplbi5ubD4KPiB3cm90ZToKPiAKPiA+IEFzIGZhciBhIEkgY2FuIHRlbGwgdXNl
cyBhIHZhcmlhbnQgb2YgRENOM3h4IHdoaWNoIHVzZXMgbnVtX3BrcnMuCj4gPgo+ID4gSWYgd2Ug
ZG8gbm90IGluaXRpYWxpemUgdGhlIHZhcmlhYmxlIHdlIHdpbGwgc2V0IHRoZSByZWdpc3RlciBm
aWVsZAo+ID4gdG8gaWxvZzIoMCkgPSAtMSwgdGhvdWdoIHRoZSBtYXNrIHdpbGwgcmVkdWNlIHRo
YXQgdG8gNy4gUHJldHR5IHN1cmUKPiA+IDcgaXMgbm90IHRoZSB2YWx1ZSB3ZSB3YW50IGhlcmUu
Cj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogQmFzIE5pZXV3ZW5odWl6ZW4gPGJhc0BiYXNuaWV1d2Vu
aHVpemVuLm5sPgo+ID4gLS0tCj4gPgo+ID4gRm91bmQgd2hpbGUgcmViYXNpbmcgbXkgbW9kaWZp
ZXJzIHNlcmllcy4gTm90IHRlc3RlZCBvbiBIVy4KClllcyEgVGhhbmsgeW91IHNvIG11Y2gsIEJh
cyEKCkkganVzdCB2ZXJpZmllZCB0aGUgdGlsaW5nIGlzc3VlIGdvdCByZXNvdmxlZCB3aXRoIHlv
dXIgcGF0Y2ghIDotKQoKQXBwbGllZC4KClJldmlld2VkLWFuZC1UZXN0ZWQtYnk6IEh1YW5nIFJ1
aSA8cmF5Lmh1YW5nQGFtZC5jb20+Cgo+ID4KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHwgMyArKy0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiA+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+ID4gaW5kZXggNjg1NWFh
ZDdmMzEyLi4yNzEzY2FhYzRmMmEgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4gPiBAQCAtNDA3NCw3ICs0MDc0LDgg
QEAgZmlsbF9wbGFuZV9idWZmZXJfYXR0cmlidXRlcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZQo+ID4g
KmFkZXYsCj4gPiAgI2lmZGVmIENPTkZJR19EUk1fQU1EX0RDX0RDTjNfMAo+ID4gICAgICAgICAg
ICAgICAgIGlmIChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9TSUVOTkFfQ0lDSExJRCB8fAo+ID4g
ICAgICAgICAgICAgICAgICAgICBhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9OQVZZX0ZMT1VOREVS
IHx8Cj4gPiAtICAgICAgICAgICAgICAgICAgIGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX0RJTUdS
RVlfQ0FWRUZJU0gpCj4gPiArICAgICAgICAgICAgICAgICAgIGFkZXYtPmFzaWNfdHlwZSA9PSBD
SElQX0RJTUdSRVlfQ0FWRUZJU0ggfHwKPiA+ICsgICAgICAgICAgICAgICAgICAgYWRldi0+YXNp
Y190eXBlID09IENISVBfVkFOR09HSCkKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHRpbGlu
Z19pbmZvLT5nZng5Lm51bV9wa3JzID0KPiA+IGFkZXYtPmdmeC5jb25maWcuZ2JfYWRkcl9jb25m
aWdfZmllbGRzLm51bV9wa3JzOwo+ID4gICNlbmRpZgo+ID4gICAgICAgICAgICAgICAgIHJldCA9
IGZpbGxfcGxhbmVfZGNjX2F0dHJpYnV0ZXMoYWRldiwgYWZiLCBmb3JtYXQsCj4gPiByb3RhdGlv
biwKPiA+IC0tCj4gPiAyLjI4LjAKPiA+Cj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwo+ID4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiA+IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gPiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0
aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmcl
MkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTA0JTdDMDElN0NyYXkuaHVh
bmclNDBhbWQuY29tJTdDOWFmZGI0ZTBhMmU5NDk2NTVjOWIwOGQ4NzU1MmExYmYlN0MzZGQ4OTYx
ZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3Mzg4MzQ1MDcwMjY1MzgyJTdD
VW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJ
aUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRhPVNib2pPVExh
T1h0ODVPU2JZanlSUG96TEFzcUJ3WHB2b1lWQnU3YzBJZG8lM0QmYW1wO3Jlc2VydmVkPTAKPiA+
Cgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1k
LWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBz
Oi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUy
RiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngm
YW1wO2RhdGE9MDQlN0MwMSU3Q3JheS5odWFuZyU0MGFtZC5jb20lN0M5YWZkYjRlMGEyZTk0OTY1
NWM5YjA4ZDg3NTUyYTFiZiU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3
QzAlN0M2MzczODgzNDUwNzAzMDUzNjAlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lN
QzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNE
JTdDMTAwMCZhbXA7c2RhdGE9dVB1aTlTNmJ4d3AlMkI0SjR1YXY0RmVrUjF6T1o5VmVIWWNkck9T
QTlaRktnJTNEJmFtcDtyZXNlcnZlZD0wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
