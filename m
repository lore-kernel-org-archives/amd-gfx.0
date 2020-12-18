Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D32C4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 10:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 877E923A82
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 10:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877E923A82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25C5D6E02A;
	Fri, 18 Dec 2020 10:57:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D996E02A
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 10:57:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVriS6BYovqVEamKBGqpFb8ljto457ZtBTFD/dkzjEt73F+vSbVqjJxsGqo2Q23g80H3hvuDRIcgYs+i/vUHN4smUVn7cLZSgaS9YnZipP6I5jFw4V39LXRefVmMa7riLrpgIlPPQ2GdZb67nn8Hg5Tm376GAZwsCJyIS6TVCL/Kse5GMcSaNLfBqHUOwuUoiOaNqlCumGbKXVqohsgoCYr7Q/wXJ/Qpb5gJfQ5No7JRhobX0ACi785p3yDbn+fyCykALAalEEkJtHG48ea1if9Ael/AGR14YCAlGq1Fisn2kKU6yn1NKJeRtHjvBKOo+5m7wxrBx0DyI2nSBAeLkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64MyHJPcz88btCaNGOKFnAVSUKWJgRLe1ksUqtWdcX0=;
 b=RxzeM+KTqlM0RH2yk1kSPTmCLy8P8BesCvB2HgustTWs3Dao+66EhMZXdUinazd8BBYl/dONnQdaOX/nz2hxVrSX2RCocdjx2UMQGmBtJnnpwgoGcelCnI0tAljjNQ80cFVPOWNfLNCzYhWYL5PKXBXLYupdrKH4J1d3DcW5mx2ItFywUaDLUIYlj1QfFEAH5FKC15gXF6hR3JWxOE25otfOU6N/M57LRSw+CU8J08jLdKqrEzFo/hsf9pvHiAFDIZ31iDtYynCqfA/cxzeQRBM8epCYt08foORpDkg+00a6H4yIAqol3ts48MxKvtVMds8wIMCSbGFuWglTamVIbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64MyHJPcz88btCaNGOKFnAVSUKWJgRLe1ksUqtWdcX0=;
 b=2CKYbogOhMKOxXWK1mJB/cFRFFkCKnOgvYoaQH5hVeki1+y72ZrUh0WELUEtxCm6wRPxDk5QpNylpsDfCEUrJ6EAp1fr/yladtTCL522DSIYU1Sq8zvuuQLmME9pFEezLUYgiNtbukCq5bkgwUfZ+ggoVtpjbi6TyiDlS/iRMxc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3162.namprd12.prod.outlook.com (2603:10b6:5:15c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Fri, 18 Dec
 2020 10:57:31 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e%7]) with mapi id 15.20.3676.025; Fri, 18 Dec 2020
 10:57:31 +0000
Subject: Re: [PATCH v2 1/1] drm/amdgpu: clean up bo in vce and vcn test
To: christian.koenig@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <772be2aa-56f0-14d5-3de4-343c556e1dc2@gmail.com>
 <20201208185916.4569-1-nirmoy.das@amd.com>
 <2823362e-9a76-b3f7-6d26-7143d7a8f40c@amd.com>
 <612b0789-81cf-4347-fc80-d5f64b7e3432@amd.com>
 <20b2f767-46b3-468e-8fe3-56e431999429@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <7dc1bb7e-cf5d-a927-4aa8-e04e04f87239@amd.com>
Date: Fri, 18 Dec 2020 11:57:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
In-Reply-To: <20b2f767-46b3-468e-8fe3-56e431999429@gmail.com>
Content-Language: en-US
X-Originating-IP: [93.229.45.20]
X-ClientProxiedBy: AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::15) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (93.229.45.20) by
 AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.28 via Frontend
 Transport; Fri, 18 Dec 2020 10:57:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f7f2a996-27b3-433c-a224-08d8a343b79a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3162:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3162FE37D05E07CAD5BAB1388BC30@DM6PR12MB3162.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q2TapOX7zROxbUh2E0m+XPiP9DSfCajOIPz/zegGNCP0BlAAdKkT0nIWKCe+bYKpqlN+kQgOB6/md/uMqsYLaO4dbYDThgTHFXnls9cOkfm9tpgyoigzIGQaTqdHaOeMB1ekgBDj1d4pruAAgRkHIcoW/d5HfwlzmguZgVh9a26JyPGF+YdXbJFcBmHWs8g9AlVgYopTrcM41zTVIdrHPeADo7xB/eKEO1rg6U0feEEQiO6HyqCXoR7L/7CuNx+JBTKhU05MS6gOegm5cFRFP5rlSEz2t76Z7TuWX8lHSbCPewsstIIxMorcOnUHCECYdK5NpZCiKjPOR9Gu3PdNh7WWLaEFvHkQSlli4vy2rWcquU9sqxCvCCqrxTm/HW2U60tAKQrrq30eKy5T2pdP2RQ8Do9ytS27Hdx2JNbGI8ybp+R+3m4Y9O7U8gOVBGbo1fX+tI63AUVnxahpmCWs2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(66574015)(16576012)(53546011)(16526019)(36756003)(52116002)(45080400002)(4326008)(31686004)(66476007)(2616005)(186003)(83380400001)(8676002)(6666004)(478600001)(5660300002)(2906002)(66946007)(66556008)(956004)(26005)(316002)(6486002)(31696002)(966005)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MEszNjdiTVJPb0ZZVlVFMVFHN2tRbHVjd3dweXVxQlhrYkx5VzA3ZFB6OVpu?=
 =?utf-8?B?SWlDRXF6elptNml5RC91TjVhSmdSa0RMOGQ5VExqSUgrU2JzelBsQzJRaWk0?=
 =?utf-8?B?TVVCQVhPM0pjbUFTb1ViWlVVWk9lR3ArTVZGTlBBK0lZNTd0RXZKSTNNRGx6?=
 =?utf-8?B?RUYzVDRWaHBmVEdobzRYM1MxczZDN2lGdXczRGdQbkFuRUdFd3k4MytJRTNV?=
 =?utf-8?B?VUtHQ2huNG9mWThOeGx0RmtYd2hJRmd3eTEzZCt3ajNjd3ovbkgyZlYreXRu?=
 =?utf-8?B?b0RKeVA2YXdSd0gyTHI0TE5iWVEzczkzSDk2bGxHd2RrSzBENlVsWEpQRWdD?=
 =?utf-8?B?RkhKeFJxczFNVmQ2QVJ6SDVlTGdFZXZZT01rTTRpeEpZeXJSRmljdXZ4UVAz?=
 =?utf-8?B?SnpLZGMyWlRwL2ZzbFFFSjRBOWtSYkRnNFlGQndPT3dRK3JFclE4TlFqUTFX?=
 =?utf-8?B?VTJoVUNSYmovQ05lcHI5Mk10UUJUeEEvaEgrbmN6dGlseDZyMmQvSkpVaTdD?=
 =?utf-8?B?ZUo5QjltN2Z5cGJCcHZYVDg0a0JXVURlL0ZyRTRKdVF6SEVncDNzQ0o2N2sv?=
 =?utf-8?B?amZHNU9nM0gyNVBGWW1TdG1kN2tGZHYyQUVoWk0vdGY0ZzVwbkQ1aWNUZGRx?=
 =?utf-8?B?bXQwOXdjRk9TQ0xxTjUzWk5yK1ZjZzdudGg1cmZPYkNpTmxHd0toeWN0cDNU?=
 =?utf-8?B?Wks2WWUrWVBWL2NRSGs3RHZkUmVMelA3cW1rbjJ1VW9SSHJaSzBIdCtUVUN1?=
 =?utf-8?B?QmVOdFB4REc2S1NLWHhwUDgyYVlvMDk1NklPTWRVMERHb3g0TXhOcTQ3MW5m?=
 =?utf-8?B?SXJja0NCaE1OdDVXVjE5TUI0VzBaWW1jWUdkcUtLTitkUklKSmJKQWx6S0kr?=
 =?utf-8?B?S1o3YUJXU3hIYUkrU2NOVlZJR25SelBQaE10L1JJMENtSnB0WXZIdXBsT0h5?=
 =?utf-8?B?SlRUNXBiZlRGMU15WFJVVzEyS1luWWhTVFExb05MYk9KNXNOWC9yVER3U1N6?=
 =?utf-8?B?Y1JDK1lRNHhodm5wOW5vQ29mZW13R25vbElSRmh6MWJyU1JyQlpJVmoyVENV?=
 =?utf-8?B?aWlnVkhuMnpaRUFuZGhoRHVZNm02eUQ4RERUS0N5ZW1hYld4MmFxVngxejhw?=
 =?utf-8?B?NXBWNW1rUnMreXFzcDNmU3hTRVBzWkp0SU5ZbkxSV2Vac0J5SGFFb2o2R2lk?=
 =?utf-8?B?N1ZXcU5CamFqemVZeC8vZ3Budkc0RnJkcDR0YW9lN1RIU0FyMDZaZTQyc21z?=
 =?utf-8?B?UW1rK2hKTS81MkR5cW5nWmZQdTFEdWpkSHp5V2xVQysyNlRJeWpySzlwRW5Q?=
 =?utf-8?Q?omTOKiiMN4v1sRsQqtzxl9iIHNQV8ifSFS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 10:57:31.0636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f2a996-27b3-433c-a224-08d8a343b79a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VzYReB1WT7Boe8gbYRSI0H4Pai1f5wClNjbMDI92ZBPNFBPKts9ApsxnPs5tn5d3MvlRozsQuv3QnMmFiN6dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3162
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
Cc: alexander.deucher@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgQ2hyaXN0aWFuLAoKT24gMTIvMTcvMjAgMzoyNSBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90
ZToKPiBBbSAwOC4xMi4yMCB1bSAyMDozOSBzY2hyaWViIE5pcm1veToKPj4KPj4gT24gMTIvOC8y
MCA4OjA0IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4gQW0gMDguMTIuMjAgdW0gMTk6
NTkgc2NocmllYiBOaXJtb3kgRGFzOgo+Pj4+IEJPIGNyZWF0ZWQgd2l0aCBhbWRncHVfYm9fY3Jl
YXRlX3Jlc2VydmVkKCkgd2Fzbid0IGNsZWFuCj4+Pj4gcHJvcGVybHkgYmVmb3JlLCB3aGljaCBj
YXVzZXM6Cj4+Pj4KPj4+PiBbwqDCoCAyMS4wNTYyMThdIFdBUk5JTkc6IENQVTogMCBQSUQ6IDcg
YXQgCj4+Pj4gZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYzo1MTggdHRtX2JvX3JlbGVhc2Ur
MHgyYmYvMHgzMTAgW3R0bV0KPj4+PiA8c25pcD4KPj4+PiBbwqDCoCAyMS4wNTY0MzBdIENhbGwg
VHJhY2U6Cj4+Pj4gW8KgwqAgMjEuMDU2NTI1XcKgIGFtZGdwdV9ib191bnJlZisweDFhLzB4MzAg
W2FtZGdwdV0KPj4+PiBbwqDCoCAyMS4wNTY2MzVdwqAgYW1kZ3B1X3Zjbl9kZWNfc2VuZF9tc2cr
MHgxYjIvMHgyNzAgW2FtZGdwdV0KPj4+PiBbwqDCoCAyMS4wNTY3NDBdIGFtZGdwdV92Y25fZGVj
X2dldF9jcmVhdGVfbXNnLmNvbnN0cHJvcC4wKzB4ZDgvMHgxMDAgCj4+Pj4gW2FtZGdwdV0KPj4+
PiBbwqDCoCAyMS4wNTY4NDNdwqAgYW1kZ3B1X3Zjbl9kZWNfcmluZ190ZXN0X2liKzB4MjcvMHgx
ODAgW2FtZGdwdV0KPj4+PiBbwqDCoCAyMS4wNTY5MzZdwqAgYW1kZ3B1X2liX3JpbmdfdGVzdHMr
MHhmMS8weDE1MCBbYW1kZ3B1XQo+Pj4+IFvCoMKgIDIxLjA1NzAyNF0gYW1kZ3B1X2RldmljZV9k
ZWxheWVkX2luaXRfd29ya19oYW5kbGVyKzB4MTEvMHgzMCAKPj4+PiBbYW1kZ3B1XQo+Pj4+IFvC
oMKgIDIxLjA1NzAzMF3CoCBwcm9jZXNzX29uZV93b3JrKzB4MWRmLzB4MzcwCj4+Pj4gW8KgwqAg
MjEuMDU3MDMzXcKgIHdvcmtlcl90aHJlYWQrMHg0Ni8weDM0MAo+Pj4+IFvCoMKgIDIxLjA1NzAz
NF3CoCA/IHByb2Nlc3Nfb25lX3dvcmsrMHgzNzAvMHgzNzAKPj4+PiBbwqDCoCAyMS4wNTcwMzdd
wqAga3RocmVhZCsweDExYi8weDE0MAo+Pj4+IFvCoMKgIDIxLjA1NzAzOV3CoCA/IF9fa3RocmVh
ZF9iaW5kX21hc2srMHg2MC8weDYwCj4+Pj4gW8KgwqAgMjEuMDU3MDQzXcKgIHJldF9mcm9tX2Zv
cmsrMHgyMi8weDMwCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3ku
ZGFzQGFtZC5jb20+Cj4+Pgo+Pj4gQXQgc29tZSBwb2ludCB3ZSBzaG91bGQgcHJvYmFibHkgc3dp
dGNoIHRvIHVzaW5nIGFuIFNBIEJPIGFuZCBzdG9wIAo+Pj4gdGhpcyBtZXNzIGhlcmUuCj4+Cj4+
Cj4+IEkgd2lsbCBsb29rIGludG8gdGhpcy4KPgo+IFBsZWFzZSBsZWF2ZSBtZSBhIG5vdGUgd2hl
biB5b3UgY2FuIGRvIHRoaXMgc2luY2Ugd2Ugc3R1bWJsZWQgaW50byAKPiBwcm9ibGVtcyB3aXRo
IHRoYXQuCgoKSSBzaG91bGQgaGF2ZSBhIHBhdGNoIHJlYWR5IGJ5IHRvZGF5LgoKClJlZ2FyZHMs
CgpOaXJtb3kKCgo+Cj4gVGhhbmtzLAo+IENocmlzdGlhbi4KPgo+Pj4gQnV0IGZvciBub3cgdGhl
IHBhdGNoIGlzIFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIAo+Pj4gPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4KPj4KPj4gVGhhbmtzLAo+Pgo+PiBOaXJtb3kKPj4KPj4+Cj4+Pj4gLS0t
Cj4+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZjZS5jIHwgMiArLQo+
Pj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYyB8IDkgKysrKysr
LS0tCj4+Pj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZjZS5jIAo+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZjZS5j
Cj4+Pj4gaW5kZXggZWNhYTJkNzQ4M2IyLi43OGE0ZGQ5YmYxMWYgMTAwNjQ0Cj4+Pj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZjZS5jCj4+Pj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZjZS5jCj4+Pj4gQEAgLTExNTEsNiArMTE1MSw2
IEBAIGludCBhbWRncHVfdmNlX3JpbmdfdGVzdF9pYihzdHJ1Y3QgCj4+Pj4gYW1kZ3B1X3Jpbmcg
KnJpbmcsIGxvbmcgdGltZW91dCkKPj4+PiDCoCBlcnJvcjoKPj4+PiDCoMKgwqDCoMKgIGRtYV9m
ZW5jZV9wdXQoZmVuY2UpOwo+Pj4+IMKgwqDCoMKgwqAgYW1kZ3B1X2JvX3VucmVzZXJ2ZShibyk7
Cj4+Pj4gLcKgwqDCoCBhbWRncHVfYm9fdW5yZWYoJmJvKTsKPj4+PiArwqDCoMKgIGFtZGdwdV9i
b19mcmVlX2tlcm5lbCgmYm8sIE5VTEwsIE5VTEwpOwo+Pj4+IMKgwqDCoMKgwqAgcmV0dXJuIHI7
Cj4+Pj4gwqAgfQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdmNuLmMgCj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNu
LmMKPj4+PiBpbmRleCA3ZTE5YTY2NTY3MTUuLjkyMWI4MTA1NGMxYiAxMDA2NDQKPj4+PiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMKPj4+PiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMKPj4+PiBAQCAtNDY1LDYgKzQ2NSw3
IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Zjbl9kZWNfc2VuZF9tc2coc3RydWN0IAo+Pj4+IGFtZGdw
dV9yaW5nICpyaW5nLAo+Pj4+IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9qb2IgKmpvYjsKPj4+
PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfaWIgKmliOwo+Pj4+IMKgwqDCoMKgwqAgdWludDY0
X3QgYWRkcjsKPj4+PiArwqDCoMKgIHZvaWQgKm1zZyA9IE5VTEw7Cj4+Pj4gwqDCoMKgwqDCoCBp
bnQgaSwgcjsKPj4+PiDCoCDCoMKgwqDCoMKgIHIgPSBhbWRncHVfam9iX2FsbG9jX3dpdGhfaWIo
YWRldiwgNjQsCj4+Pj4gQEAgLTQ3NCw2ICs0NzUsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV92Y25f
ZGVjX3NlbmRfbXNnKHN0cnVjdCAKPj4+PiBhbWRncHVfcmluZyAqcmluZywKPj4+PiDCoCDCoMKg
wqDCoMKgIGliID0gJmpvYi0+aWJzWzBdOwo+Pj4+IMKgwqDCoMKgwqAgYWRkciA9IGFtZGdwdV9i
b19ncHVfb2Zmc2V0KGJvKTsKPj4+PiArwqDCoMKgIG1zZyA9IGFtZGdwdV9ib19rcHRyKGJvKTsK
Pj4+PiDCoMKgwqDCoMKgIGliLT5wdHJbMF0gPSBQQUNLRVQwKGFkZXYtPnZjbi5pbnRlcm5hbC5k
YXRhMCwgMCk7Cj4+Pj4gwqDCoMKgwqDCoCBpYi0+cHRyWzFdID0gYWRkcjsKPj4+PiDCoMKgwqDC
oMKgIGliLT5wdHJbMl0gPSBQQUNLRVQwKGFkZXYtPnZjbi5pbnRlcm5hbC5kYXRhMSwgMCk7Cj4+
Pj4gQEAgLTQ5Miw3ICs0OTQsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV92Y25fZGVjX3NlbmRfbXNn
KHN0cnVjdCAKPj4+PiBhbWRncHVfcmluZyAqcmluZywKPj4+PiDCoCDCoMKgwqDCoMKgIGFtZGdw
dV9ib19mZW5jZShibywgZiwgZmFsc2UpOwo+Pj4+IMKgwqDCoMKgwqAgYW1kZ3B1X2JvX3VucmVz
ZXJ2ZShibyk7Cj4+Pj4gLcKgwqDCoCBhbWRncHVfYm9fdW5yZWYoJmJvKTsKPj4+PiArwqDCoMKg
IGFtZGdwdV9ib19mcmVlX2tlcm5lbCgmYm8sIE5VTEwsICh2b2lkICoqKSZtc2cpOwo+Pj4+IMKg
IMKgwqDCoMKgwqAgaWYgKGZlbmNlKQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAqZmVuY2UgPSBk
bWFfZmVuY2VfZ2V0KGYpOwo+Pj4+IEBAIC01MDUsNyArNTA3LDcgQEAgc3RhdGljIGludCBhbWRn
cHVfdmNuX2RlY19zZW5kX21zZyhzdHJ1Y3QgCj4+Pj4gYW1kZ3B1X3JpbmcgKnJpbmcsCj4+Pj4g
wqAgwqAgZXJyOgo+Pj4+IMKgwqDCoMKgwqAgYW1kZ3B1X2JvX3VucmVzZXJ2ZShibyk7Cj4+Pj4g
LcKgwqDCoCBhbWRncHVfYm9fdW5yZWYoJmJvKTsKPj4+PiArwqDCoMKgIGFtZGdwdV9ib19mcmVl
X2tlcm5lbCgmYm8sIE5VTEwsICh2b2lkICoqKSZtc2cpOwo+Pj4+IMKgwqDCoMKgwqAgcmV0dXJu
IHI7Cj4+Pj4gwqAgfQo+Pj4+IMKgIEBAIC03NjEsNiArNzYzLDcgQEAgaW50IGFtZGdwdV92Y25f
ZW5jX3JpbmdfdGVzdF9pYihzdHJ1Y3QgCj4+Pj4gYW1kZ3B1X3JpbmcgKnJpbmcsIGxvbmcgdGlt
ZW91dCkKPj4+PiDCoCBlcnJvcjoKPj4+PiDCoMKgwqDCoMKgIGRtYV9mZW5jZV9wdXQoZmVuY2Up
Owo+Pj4+IMKgwqDCoMKgwqAgYW1kZ3B1X2JvX3VucmVzZXJ2ZShibyk7Cj4+Pj4gLcKgwqDCoCBh
bWRncHVfYm9fdW5yZWYoJmJvKTsKPj4+PiArwqDCoMKgIGFtZGdwdV9ib19mcmVlX2tlcm5lbCgm
Ym8sIE5VTEwsIE5VTEwpOwo+Pj4+ICsKPj4+PiDCoMKgwqDCoMKgIHJldHVybiByOwo+Pj4+IMKg
IH0KPj4+Cj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1o
dHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUy
RmFtZC1nZngmYW1wO2RhdGE9MDQlN0MwMSU3Q05pcm1veS5EYXMlNDBhbWQuY29tJTdDZTBjMDA3
Yzc1MzU4NGVjOTI3MWYwOGQ4YTI5NzhjMmMlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRl
MTgzZCU3QzAlN0MwJTdDNjM3NDM4MTE5MDY4MjcyNjI5JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNk
OGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pY
VkNJNk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRhPTN3QVdCTWQ1dkhuMlVvRUJkaHRPNkN2bEkwaHJk
ZzdIc0ZucUFiZzNKbmclM0QmYW1wO3Jlc2VydmVkPTAgCj4+Cj4KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
