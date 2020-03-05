Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B621C3F2D1
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 16:01:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 513242072D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 16:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xsf0GeU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513242072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1649D6EBD5;
	Thu,  5 Mar 2020 16:01:12 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690045.outbound.protection.outlook.com [40.107.69.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9BD26EBD5
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 16:01:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJ3DkTQ4oPwmURrYKh9Ecq6wHTG0iwmHKGQSz4SWY37ILn8YC3532dR6SGuScdOhoLWU3KVM4DN0J2UoMOuReVdyW4ihmvrwmlRL1URK8Dc1R3dzHnLOROmozfFMBkHzIOsm621nCJH6EfBIwialo0xJ2JfDxqn4B7iSug+xVwYeMy7I+ohzn94dCnGtPYrkC8HALCFh5fMsjylRmiN2xQtPzmzZbbCsrGsda6z0WforGhBGwZhk8VOqH/ohTz6Tmd4clLNX2OXf5olptPe3XxHNbhWrJIGnUMi/0Q1YHRibmetb2Vz9f1to04S82pBhfB2m9eBYHZppUP8uqzTSxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFya1m/c56KiSWq4AOsJ8C2YtpTMUpSdQd4avmObXOY=;
 b=Km/q5WPexIZ7Qr9S0cs32ah4fq2IrJbyC1bkER1nB7l/HoMVhozTKBHhq2Uw1gVusvJW6L7Y6oeEopVKw65XB64auqTTzpqwHYnBm1ICegGyoX81QSVj6JVjdJsf+eB32bhoaETOoadGcJxUvCJn69jLlSNAg/TkiM231Jh580A39YcT6RZ6KLULYRuvrggWYbAnyX2nz74WaEkTEl5Qf+Yj4wBJ7SpZLqu9XF2yAwtOzilCMlehz/9XkQn7TGDHoPk+Vx188uGfEnCv0mMudUnHrG0MRYurtEWiUYYks8CdC++nSj5+fbhM4DnRR01V6dqlliY8nT2zlaRyrW9QIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFya1m/c56KiSWq4AOsJ8C2YtpTMUpSdQd4avmObXOY=;
 b=xsf0GeU7iLrbDSBo/OPyBBvMdWrR31Hwj9l40IOEG182Oi0uhNBEicvIis3ootRhZxAXjXJxBxemBEY4S9XJrYPjzSHsOr/FjuMgupDkt9/9GqqGAeoTr6JV0Pr3UcntLC4GzG+wkgFjhe1FE5rE9I7H4j0aCPt5FtR7tsdItQw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (2603:10b6:5:1c9::32)
 by DM6PR12MB3306.namprd12.prod.outlook.com (2603:10b6:5:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Thu, 5 Mar
 2020 16:01:10 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::7c3d:1072:f9d8:8686]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::7c3d:1072:f9d8:8686%6]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 16:01:10 +0000
Subject: Re: [enable VCN2.0 for NV12 SRIOV 2/6] drm/amdgpu: disable jpeg block
 for SRIOV
To: "Liu, Monk" <Monk.Liu@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1583415187-16594-1-git-send-email-Monk.Liu@amd.com>
 <1583415187-16594-2-git-send-email-Monk.Liu@amd.com>
 <32d7916b-c783-4762-b1ad-5627011ba6b4@gmail.com>
 <DM6PR12MB3931DC79623D336FE09770BE84E20@DM6PR12MB3931.namprd12.prod.outlook.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <8d6ef4dc-a5a2-dd2c-a354-91b640ae5cf6@amd.com>
Date: Thu, 5 Mar 2020 11:01:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <DM6PR12MB3931DC79623D336FE09770BE84E20@DM6PR12MB3931.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::18) To DM6PR12MB3914.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:a200:445:917c:58ca:660b:c965]
 (2607:fea8:a200:445:917c:58ca:660b:c965) by
 YTXPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11 via Frontend
 Transport; Thu, 5 Mar 2020 16:01:10 +0000
X-Originating-IP: [2607:fea8:a200:445:917c:58ca:660b:c965]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6e554c5d-5d25-4336-6977-08d7c11e6c20
X-MS-TrafficTypeDiagnostic: DM6PR12MB3306:|DM6PR12MB3306:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB330671C19617E3EF2C0D3EFCE5E20@DM6PR12MB3306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 03333C607F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(199004)(189003)(16526019)(186003)(5660300002)(66574012)(966005)(478600001)(36756003)(2906002)(6486002)(31696002)(31686004)(53546011)(8936002)(45080400002)(52116002)(316002)(81156014)(44832011)(8676002)(81166006)(66556008)(66476007)(66946007)(2616005)(110136005)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3306;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d7U8+SZ5LzX1jtywn9mXczUH8BT960PHIHhZVEVCzPlbOd5RjkVSsgwD7WdhvI1Thh2A9oECKZ3klDD5bZRdUZmfodv5SKcvjbB+phsEqiVNR6Qk5oMQu/ovo0CB8C0zyMl95LLYlxz3ahY6ptv4KvuSNLb8ARqdECfhIVJb55Ef/6ERBYEteeBynaKAlHU5fkQUlBvNP7yPHqyiA16Vai9jmRzq/SYSnnmyUP0sJejiv+lLwX01v3d9xPVjr7r8+geBSNE7xLBSYjG5w2gy00kEbYGgs3+/MyTZ7kPpi3Si8z9+0m6O2/FJgxKS9fYVCFGQcB64p7yrHwtRTkIm1W7KYBcQmE89ghIrU/AnKOUya+MO8YZWXQF2u0VODsd7kD6TNZ3R/w3WGPc1GCNNrLYcbSWJeHeTxzTV68PY64q5EVmYQuBwi1qbf4I6gQfSqvl3anj1iD+pf3X0ZXw3D7jipAFFogEogsgaZQofN34=
X-MS-Exchange-AntiSpam-MessageData: WYjDBzxzVw70L7QPwV1bGmq72+oghBYBDD+ITXo9qv1Wtu2ePmhWNP8MyKByDfP9/roytjERtnpBQ+ciYAxcAKgdQsNnONeoPDCjWGZDYeu3Gad9An1QG6dwMnyrQTDjtdGJCG5tTebS/Kutyn579qoOHys25xqRXim0NCEgNALUKTENLqvQIwhQliohIv5kQGC91joS9Q7h2JAK8F8bnA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e554c5d-5d25-4336-6977-08d7c11e6c20
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 16:01:10.5666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ty30PenOmRUiptZmBL/LTSP9Inwmu0GRJOTnwnED8vr3ayvDlcjYBuUCpELXqg4i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3306
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

Ck9uIDIwMjAtMDMtMDUgODozOSBhLm0uLCBMaXUsIE1vbmsgd3JvdGU6Cj4gVGhpcyBpcyBub3Qg
c3VwcG9ydGVkIGJ5IE1NU0NIIEZXLi4uCgpXaXRoIHRoaXMgYWRkZWQgdG8gY29tbWl0IG1lc3Nh
Z2UsIHRoaXMgcGF0Y2ggaXM6CgpSZXZpZXdlZC1ieTogTGVvIExpdSA8bGVvLmxpdUBhbWQuY29t
PgoKCgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IE1vbmsgTGl1
fEdQVSBWaXJ0dWFsaXphdGlvbiBUZWFtIHxBTUQKPgo+Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0KPiBGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdt
YWlsLmNvbT4KPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggNSwgMjAyMCA5OjM4IFBNCj4gVG86IExp
dSwgTW9uayA8TW9uay5MaXVAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cj4gU3ViamVjdDogUmU6IFtlbmFibGUgVkNOMi4wIGZvciBOVjEyIFNSSU9WIDIvNl0gZHJtL2Ft
ZGdwdTogZGlzYWJsZSBqcGVnIGJsb2NrIGZvciBTUklPVgo+Cj4gQSBjb21taXQgbWVzc2FnZSBl
eHBsYWluaW5nIHdoeSB3ZSBkaXNhYmxlIGl0IGFuZCBpZiBpdCBjb3VsZCBiZSBlbmFibGVkIGFn
YWluIG9yIGlmIHRoaXMgaXMgcGVybWFuZW50IHdvdWxkIGJlIG5pY2UgdG8gaGF2ZS4KPgo+IENo
cmlzdGlhbi4KPgo+IEFtIDA1LjAzLjIwIHVtIDE0OjMzIHNjaHJpZWIgTW9uayBMaXU6Cj4+IFNp
Z25lZC1vZmYtYnk6IE1vbmsgTGl1IDxNb25rLkxpdUBhbWQuY29tPgo+PiAtLS0KPj4gICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYyB8IDMgKystCj4+ICAgIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9udi5jIGluZGV4IDJkMWJlYmQuLjAzM2NiYmMgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L252LmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
bnYuYwo+PiBAQCAtNTE2LDcgKzUxNiw4IEBAIGludCBudl9zZXRfaXBfYmxvY2tzKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQo+PiAgICAJCSAgICAhYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQo+
PiAgICAJCQlhbWRncHVfZGV2aWNlX2lwX2Jsb2NrX2FkZChhZGV2LCAmc211X3YxMV8wX2lwX2Js
b2NrKTsKPj4gICAgCQlhbWRncHVfZGV2aWNlX2lwX2Jsb2NrX2FkZChhZGV2LCAmdmNuX3YyXzBf
aXBfYmxvY2spOwo+PiAtCQlhbWRncHVfZGV2aWNlX2lwX2Jsb2NrX2FkZChhZGV2LCAmanBlZ192
Ml8wX2lwX2Jsb2NrKTsKPj4gKwkJaWYgKCFhbWRncHVfc3Jpb3ZfdmYoYWRldikpCj4+ICsJCQlh
bWRncHVfZGV2aWNlX2lwX2Jsb2NrX2FkZChhZGV2LCAmanBlZ192Ml8wX2lwX2Jsb2NrKTsKPj4g
ICAgCQlicmVhazsKPj4gICAgCWRlZmF1bHQ6Cj4+ICAgIAkJcmV0dXJuIC1FSU5WQUw7Cj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1h
aWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9uYW0x
MS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlz
dHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0
YT0wMiU3QzAxJTdDbGVvLmxpdSU0MGFtZC5jb20lN0M3M2YyOGM5M2U4ODI0MWJjNGM1OTA4ZDdj
MTBhOTZlMyU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzcx
OTAxMjM1NTUxMzAzNjYmYW1wO3NkYXRhPUNWY2FjOWRFV2MzbVIwb05rY3JrT1R0eFhxdmR0anpF
Tjc4YyUyRkJZdHk4RSUzRCZhbXA7cmVzZXJ2ZWQ9MApfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
