Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013D4C3F2C6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 19:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEA952073B
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 19:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dFZm8BjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA952073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 609276E940;
	Tue,  3 Mar 2020 19:07:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CF396E940
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 19:06:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DM5owDVvnMCDzatsSFEtk9LJVwwhlXoQJ/ppGp+K8xakoAI3yS4G+oavVV2DCAUbD3H4mvDzQOWpPrHs6jK1ONHnSE820ZhOBtxFebFmzXuLNWyLW81aW881OF2lm8jO3eeqMfHd8UhM0O7doQj3RGlNLFZYFkzP9y+hqU8G1Lkr9Cwa219p6LkJEQUn9gT3eCWW+sxHNYfZiMro7Oro1uGa9INPSaCznsiGsrsWwLSBmdH0M2qKHfIqa3SJZZzXBYa3lDy2zb2TcR868EBwLydqJro5atsxjOJowDd9T0B4hgX+hCDYgoEkBy1Xin/Ayi7FbV2GhvfZIUYQWW1OOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNTTymXbySy8MDbEt4vhpxRuSAu5NhqzA3XnjLs/lmE=;
 b=KTc4v3kxFixYAHawJYCGhFcou2X75Xe0qeFbvPDvDcs82ZB8SRmoMJ2ngV/6aoypEbBNdZR04UKC0ql7Wrup8Fyuczn+0pz6EtZ2zFXsRe10KZzJ6LELoHB5ITk8gr9Vt6NqdvZdm39ilAiMFHM3Lzp9rK8E+EdZZqKud+SX4KB6yx//cY5Q7lKrnJsF8oaieunloZlQ15wb9px+HVVgyYeIJCHJ0LJrgjFfZ44+AxUmzyJVEwDLOxFS9CGOAfYrpJ2IUbc1bP0ZkfTPvHwXfVt34A6o3Gd3zenXaOp5gXJ4jF4LlSyMzJLXNeL8iZcpNBRUArwo359y3F0Haiy5Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNTTymXbySy8MDbEt4vhpxRuSAu5NhqzA3XnjLs/lmE=;
 b=dFZm8BjW0wtWqeXMuTDc2YICtlx/IgR/MhjPKkx/+Ibq4uvNQ6AQB+VD+g+uPdIJglYb7CzCHHMHsixlF+OhlPqQ3aCs2COWDc35rkn8CAaOgtCUkxMJ4rzEjOSnb2dpK76nsDio0fc+U1PVauCsko0QSvu59A+JhZXVx2s6pXk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22)
 by DM5PR12MB1516.namprd12.prod.outlook.com (2603:10b6:4:5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Tue, 3 Mar 2020 19:06:58 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 19:06:57 +0000
Subject: Re: [RFC PATCH 2/4] drm/scheduler: implement a function to modify
 sched list
To: Luben Tuikov <luben.tuikov@amd.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>, 
 amd-gfx@lists.freedesktop.org
References: <20200227214012.3383-1-nirmoy.das@amd.com>
 <20200227214012.3383-2-nirmoy.das@amd.com>
 <46106fdd-55ed-cb09-902e-a1c0cffd7b0d@amd.com>
 <d87c9952-1eb8-5295-a1bc-475f5e94fc78@amd.com>
 <069d5a87-9792-87e5-432a-6c6456beeed6@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <21eef828-c01e-0c39-12cf-42cad5af8ed2@amd.com>
Date: Tue, 3 Mar 2020 20:06:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <069d5a87-9792-87e5-432a-6c6456beeed6@amd.com>
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0019.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::6) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 ZR0P278CA0019.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Tue, 3 Mar 2020 19:06:56 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 98a2953c-b42a-476c-0b40-08d7bfa60b6b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1516:|DM5PR12MB1516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1516F4754C9E0196B771D38083E40@DM5PR12MB1516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(199004)(189003)(2616005)(5660300002)(31696002)(31686004)(6666004)(86362001)(316002)(4326008)(52116002)(110136005)(6486002)(53546011)(8936002)(66476007)(8676002)(66946007)(66574012)(66556008)(36756003)(16526019)(186003)(81156014)(2906002)(81166006)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1516;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EYaVXj9lN86vjaSFh1ubIMBE+ufZumgPa+S31fWAZ5TeRmKlVzPjmLgkX+fLWjiW80UHS4sJXrNWRk7963HIfl1jhOPpCbtw5MlZXV8Fa5uPDDRnhTryQnwGf8iXFizvpqHEzv/4pVehOt7URjljJnngW3OhISrGgeajkSliep/COK3F1TT32Hi0TaFy5cj5ilnh6q9KlmMxNOJ1Zq7VEcwHwN4coFaYv1UV7AWwmm8/2DVYrKWzMWoTVJ0zgrm+reQNLkzvxYVBWyjLJ7PFaoCZ+2s1xK1L45JzdCqriJJE9+PaMF3QSugX3Y41ueUQDLdZd+UQWb+H4gYorAinKqUlH0jBCtbVNXwN29U3qRL1BXs1tGrTnOWKIvb6dK2nwgS5tzlNgwWurm5JB9KLQFoTxv56jlYYoEM8yjhauD5wOmWfDPNExTnlTpNrZuHW
X-MS-Exchange-AntiSpam-MessageData: 9CBAtgmQB6f1xt6K6q+2EKYMqURhL2TAC8aCwt1gXqdlvN14VzoA4pyYst4OFLZRFXbWJvKO9CxJTSOTRvCp83LoHqPkklwDlwCCR/rm8v4TJFb6PRPN0k6aMMrWWf+aEDS5NB28NgQ5Ea1ag46Ik5DMT/FijWXSfi/lDB3Nt+tZ7L4Nkg9AsCQAyK86iOSbB8vva4J8cqapRQS24aWV+Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a2953c-b42a-476c-0b40-08d7bfa60b6b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 19:06:57.6653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EV3IXy7kA2wlFJCN1ItjLVJU6rDleSbF+q99OeVIpmpOxPJd0X9s3fIiNclaWKak
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1516
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

QW0gMDIuMDMuMjAgdW0gMjE6NDcgc2NocmllYiBMdWJlbiBUdWlrb3Y6Cj4gT24gMjAyMC0wMi0y
OCAyOjQ3IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDI4LjAyLjIwIHVtIDA2
OjA4IHNjaHJpZWIgTHViZW4gVHVpa292Ogo+Pj4gT24gMjAyMC0wMi0yNyA0OjQwIHAubS4sIE5p
cm1veSBEYXMgd3JvdGU6Cj4+Pj4gW1NOSVBdCj4+Pj4gKwlpZiAoIShlbnRpdHkgJiYgc2NoZWRf
bGlzdCAmJiAobnVtX3NjaGVkX2xpc3QgPT0gMCB8fCBzY2hlZF9saXN0WzBdKSkpCj4+Pj4gKwkJ
cmV0dXJuIC1FSU5WQUw7Cj4+PiBUaGlzIHNlZW1zIHVubWFpbnRhaW5hYmxlLiBJJ2Qgd3JpdGUg
aXQgaW4gaXRzIG5hdHVyYWwgZm9ybToKPj4gVGhpcyBpcyBwcm9iYWJseSBqdXN0IGNvcHkgJiBw
YXN0ZWQgZnJvbSB0aGUgaW5pdCBmdW5jdGlvbiBhbmQgY29tcGxldGUKPj4gb3ZlcmtpbGwgaGVy
ZS4KPiBJdCBzaG91bGQgYmUgYW4gZWFzeSByZWplY3Rpb24gdGhlbi4gU3RhdGVtZW50cyBsaWtl
IHRoaXMgbWFrZQo+IHRoZSBjb2RlIHVubWFpbnRhaW5hYmxlLiBSZWdhcmRsZXNzIG9mIHdoZXRo
ZXIgaXQgd2FzIGNvcHktYW5kLXBhc3RlZAo+IEkgd2FudGVkIHRvIGVtcGhhc2l6ZSB0aGUgbGFj
ayBvZiBzaW1wbGlmaWNhdGlvbiBvZiB3aGF0Cj4gd2FzIGJlaW5nIGRvbmUuCgpUaGUgcHJvYmxl
bSBpcyBldmVuIGRlZXBlci4gQXMgeW91IG5vdGljZWQgYXMgd2VsbCB0aGlzIGlzIGNoZWNraW5n
IGZvciAKaW4ga2VybmVsIGNvZGluZyBlcnJvciBhbmQgbm90IGFwcGxpY2F0aW9uIGVycm9ycy4K
ClRoYXQgY2hlY2sgc2hvdWxkbid0IGhhdmUgYmVlbiBpbiB0aGUgaW5pdCBmdW5jdGlvbiBpbiB0
aGUgZmlyc3QgcGxhY2UsIApidXQgbm9ib2R5IGhhZCB0aW1lIHRvIGxvb2sgaW50byB0aGF0IHNv
IGZhci4KCj4gV2UgbmVlZCB0byBwdXQgaW50ZW50aW9uIGFuZCBzZW5zZSBpbnRvIHdoYXQgd2Un
cmUgZG9pbmcsIHNjcnV0aW5pemluZwo+IGV2ZXJ5IGxpbmUgd2UgcHV0IGludG8gYSBwYXRjaC4g
VGhpcyBpcyB3aHkgSSBzdWdnZXN0ZWQKPiB0aGUgc2ltcGxpZmljYXRpb24gaGVyZToKPgo+Pj4g
aW50IGRybV9zY2hlZF9lbnRpdHlfbW9kaWZ5X3NjaGVkKHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5
ICplbnRpdHksCj4+PiAJCQkJICBzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKipzY2hlZF9saXN0
LAo+Pj4gCQkJCSAgdW5zaWduZWQgaW50IG51bV9zY2hlZF9saXN0KQo+Pj4gewo+Pj4gCWlmIChl
bnRpdHkgJiYgc2NoZWRfbGlzdCAmJiAobnVtX3NjaGVkX2xpc3QgPT0gMCB8fCBzY2hlZF9saXN0
WzBdICE9IE5VTEwpKSB7Cj4+PiAJCWVudGl0eS0+c2NoZWRfbGlzdCA9IG51bV9zY2hlZF9saXN0
ID4gMSA/IHNjaGVkX2xpc3QgOiBOVUxMOwo+Pj4gCQllbnRpdHktPm51bV9zY2hlZF9saXN0ID0g
bnVtX3NjaGVkX2xpc3Q7Cj4+PiAJCXJldHVybiAwOwo+Pj4gCX0gZWxzZSB7Cj4+PiAJCXJldHVy
biAtRUlOVkFMOwo+Pj4gCX0KPj4+IH0KPj4gQWN0dWFsbHkgdGhhdCdzIGEgcmF0aGVyIGJhZCBp
ZGVhLiBFcnJvciBoYW5kbGluZyBzaG91bGQgYWx3YXlzIGJlIGluCj4gSSBhY3R1YWxseSBkb24n
dCB0aGluayB0aGF0IGl0IGlzIGEgInJhdGhlciBiYWQgaWRlYSIuIEF0IGFsbC4KPiBJIGFjdHVh
bGx5IHRoaW5rIHRoYXQgaXQgbWFrZXMgdGhpcyBsZWFmIGZ1bmN0aW9uIG1vcmUgY2xlYXIgdG8K
PiB1bmRlcnN0YW5kIGFzIHRoZSBjb25kaXRpb25hbCB3b3VsZCByZWFkIGxpa2UgYSBzZW50ZW5j
ZSBpbiBwcm9zZS4KClRoZSBjb25kaXRpb24gaXMgaW5kZWVkIGVhc2llciB0byByZWFkLCBidXQg
Zm9yIHRoZSBzYWNyaWZpY2Ugb2YgZWFybGllciAKcmV0dXJuIGFuZCBrZWVwaW5nIHByZXJlcXVp
c2l0ZSBjaGVja2luZyBvdXQgb2YgdGhlIGNvZGUuCgo+IFtTTklQXQo+PiBXaGF0IHdlIHNob3Vs
ZCBkbyBpbnN0ZWFkIGlzIGp1c3Q6IFdBUk5fT04oIW51bV9zY2hlZF9saXN0IHx8ICFzY2hlZF9s
aXN0KTsKPiBBZ2Fpbiwgd2hhdCBkb2VzIHRoYXQgKm1lYW4qPyBXaGF0IGRvZXMgdGhlIGNoZWNr
IG1lYW4gYW5kIHdoYXQKPiBkb2VzIHRoZSBudW1fc2NoZWRfbGlzdCA9PSAwIG9yIHNjaGVkX2xp
c3QgPT0gTlVMTCBtZWFuPwo+IEFuZCBob3cgZGlkIHdlIGdldCBpbnRvIGEgc2l0dWF0aW9uIGxp
a2UgdGhpcyB3aGVyZSBlaXRoZXIgb3IgYm90aAo+IGNvdWxkIGJlIG5pbD8KCkl0J3MgYW4gaW4g
a2VybmVsIGNvZGluZyBlcnJvciB0byBkbyB0aGlzLiBUaGUgY2FsbGVyIHNob3VsZCBhdCBsZWFz
dCAKYWx3YXlzIHByb3ZpZGUgYSBsaXN0IHdpdGggc29tZSBlbnRyaWVzIGluIGl0LgoKQSBXQVJO
X09OKCkgaXMgYXBwcm9wcmlhdGUgc2luY2UgaXQgaGVscHMgdG8gbmFycm93cyBkb3duIHRoZSBp
bmNvcnJlY3QgCmJlaGF2aW9yIGZvbGxvd2luZyBmcm9tIHRoYXQuCgo+IFdvdWxkbid0IGl0IGJl
IGJldHRlciB0byBzaW1wbGlmeSBvciByZS1hcmNoaXRlY3R1cmUgdGhpcyAod2Ugb25seSByZWNl
bnRseQo+IGRlY2lkZWQgdG8gaGlkZSBwaHlzaWNhbCByaW5ncyBmcm9tIHVzZXItc3BhY2UpLCBz
byB0aGF0IHRoZSBjb2RlCj4gaXMgZWxlZ2FudCAobWVhbmluZyBubyBpZi1lbHNlKSB5ZXQgZmxl
eGlibGUgYW5kIHN0cmFpZ2h0Zm9yd2FyZD8KClRoYXQgd2FzIG5vdCByZWNlbnRseSBhdCBhbGws
IGhpZGluZyBwaHlzaWNhbCByaW5ncyB3YXMgZG9uZSBuZWFybHkgNSAKeWVhcnMgYWdvIHNob3J0
bHkgYWZ0ZXIgdGhlIGRyaXZlciB3YXMgaW5pdGlhbGx5IHJlbGVhc2VkLgoKPj4+IFdoeSBub3Qg
Zml4IHRoZSBhcmNoaXRlY3R1cmUgc28gdGhhdCB0aGlzIGlzIHNpbXBseSBjb3BpZWQ/Cj4+IFdl
IGhhZCB0aGF0IGFuZCBtb3ZlZCBhd2F5IGZyb20gaXQgYmVjYXVzZSB0aGUgc2NoZWR1bGVyIGxp
c3QgaXMKPj4gYWN0dWFsbHkgY29uc3QgYW5kIHNob3VsZG4ndCBiZSBhbGxvY2F0ZWQgd2l0aCBl
YWNoIGVudGl0eSAod2hpY2ggd2UgY2FuCj4+IGVhc2lseSBoYXZlIHRob3VzYW5kcyBvZikuCj4g
SSB0aGluayB0aGF0IHBlcHBlcmluZyB0aGUgY29kZSB3aXRoIGlmLWVsc2UgY29uZGl0aW9uYWxz
Cj4gZXZlcnl3aGVyZSBhcyB0aGVzZSBwYXRjaC1zZXJpZXMgaW50byB0aGUgRFJNIHNjaGVkdWxl
ciBoYXZlIGJlZW4sCj4gd291bGQgbWFrZSB0aGUgY29kZSB1bm1haW50YWluYWJsZSBpbiB0aGUg
bG9uZyBydW4uCgpUaGF0J3Mgc29tZXRoaW5nIEkgY2FuIGFncmVlIG9uLiBVc2luZyBhIHN3aXRj
aCB0byBtYXAgdGhlIHByaW9yaXR5IHRvIAp0aGUgYmFja2VuZCBpbXBsZW1lbnRhdGlvbiBzZWVt
cyBsaWtlIHRoZSBiZXN0IGlkZWEgdG8gbWUuCgpFLmcuIGZ1bmN0aW9uIGFtZGdwdV90b19zY2hl
ZF9wcmlvcml0eSgpIHNob3VsZCBub3Qgb25seSBtYXAgdGhlIElPQ1RMIAp2YWx1ZXMgdG8gdGhl
IHNjaGVkdWxlciB2YWx1ZXMsIGJ1dCBhbHNvIHJldHVybiB0aGUgYXJyYXkgd2hpY2ggaHcgcmlu
Z3MgCnRvIHVzZS4KClJlZ2FyZHMsCkNocmlzdGlhbi4KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
