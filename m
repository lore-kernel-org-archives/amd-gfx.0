Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7314CC00A89
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 15:33:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D512E20729
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 15:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fFmu6ZZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D512E20729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D2426EDFE;
	Fri, 30 Oct 2020 15:33:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F27086EDFD
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 15:33:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKItOUiiYx01OQWDmDCANUhhpRBiaygV0sHEKofyNv7Vug6PIGUerDd4lg6UtYqtenSOxHloCxTFrtfsKGgBGd6b8cKO8rkXMpQpNDvRkxMNe/5bldFpWqbfdJJll0OSvPe1vz32rEzQSrTocw+RWYqRZpGMVCgmX/e3fI/jIPq7EGPfQ0pwj25VgMEC1SSE+Bq440oo+XRZSCKNpj6eyX6P382NHAjcB693vY9aMDQ5vYV6KN6GAkWmT1ql5sLp2QfmBbvzKVPhVvcsC0mxOvuK8yRc2lKTgVb52EAonFdlk17GaiYcueYHg3/XekJl2ZB9T+lXlzG+jw9DkBe0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/trpKcPajSvHOIl34reT2yvUrfWnxjKcVgtd1p9kK14=;
 b=WG5rANbDE/fQOrtP0cYCPdbgl5DnckhNILWs4jBPGu10s4XShE4uBB/cdzGt3L6PGGxM69VJC51NNNSuos1RBx0a2VLKRDLf16DaFKoJniwVGDSyLEIrWixoEXJcwuQrdG7V1ZpFOrEjuhUF1sGx7mJCv2blDZHpQKDbUG69sVjiNL/+gzFvwCpoP8eAsqrIh8oqdMy2oPJ2PS81QTV7cuNxVcMGnMlVfPhcZksBEpClTkwJ+npfI0Wd2GvSJgb2OwICbXEoI32MrO2p10j5HhQUZ2y1/GtRyTd9OkY31KxKaZRq5ZR5U7xzQU9I/K230Hx0hsio8Iohwze5CpwVqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/trpKcPajSvHOIl34reT2yvUrfWnxjKcVgtd1p9kK14=;
 b=fFmu6ZZ1K4jmFOCK3+gxPtWm7CIETXMx2ZFodUAGm+b/+Wv3SccvP30LO9TM9GjwFF9Li7mIaTSe3+Pi2eiG2/9j17IZZEz4L5hS7QrSznYbwfH2K+riXHQyTlp4vY1U1CzKcta6MDdk0PPcAWLLELfxnYYVKpMwkVovbaYv510=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW3PR12MB4523.namprd12.prod.outlook.com (2603:10b6:303:5b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Fri, 30 Oct
 2020 15:33:43 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::e8c1:7ef6:c905:247d]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::e8c1:7ef6:c905:247d%8]) with mapi id 15.20.3499.019; Fri, 30 Oct 2020
 15:33:43 +0000
Subject: Re: Potential freesync Arithmetic Issue
To: Bryan Angelo <bangelo@gmail.com>, amd-gfx@lists.freedesktop.org
References: <CAOvTWHuRNXyUNm1H_vz40iAE2-3Z3zGZO8=-7OJGu1wMMWYiUQ@mail.gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <14b91d5e-2122-697d-7875-6428035c6708@amd.com>
Date: Fri, 30 Oct 2020 11:33:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <CAOvTWHuRNXyUNm1H_vz40iAE2-3Z3zGZO8=-7OJGu1wMMWYiUQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR04CA0084.namprd04.prod.outlook.com
 (2603:10b6:404:8d::34) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.6.72] (165.204.84.11) by
 BN6PR04CA0084.namprd04.prod.outlook.com (2603:10b6:404:8d::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Fri, 30 Oct 2020 15:33:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d26fc143-fb30-4446-e6c4-08d87ce92ed3
X-MS-TrafficTypeDiagnostic: MW3PR12MB4523:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4523065F8A8868F7B032B08A8C150@MW3PR12MB4523.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2NDoXdKukmtAvZJu4153ghv6yP3+AMbm6Msgxjhwjp1YNK6/1npoqiqioke5dD0TC6pCvp4IadCUewdF7vPkyxLOtLH+TYOo41HYp4aNophW4cGtIHUcNYyqJJxfZJ2kvYyVVKQzcKEhhTIynEWH2jrb1OrGIoKWkMQ13Hu3+UZer9rAaR39TaxBGv0SBL/ozTYLRNWQEhvbzK1wcqwq/76hFxk0fY4iZhupUz/cUr2NRpeNr0nl+XqXVDFkBJt/iYRL5EOKytVWo9dT524s6xLEFWg2e/7r6dn+L4h47+jf2WtipceOJKtGBe13N60qQKXJ4P+hTw/FbMxLk5SCNVdE4k75crosOVrRcF/BT3uEi6jHNyNRNMRBTN1+oV/DPNpZGGyoVy5FhHOneeYbdnXcdTqLHzelt0dlP1REkiYt9RGgq1/GZc9B1oewYwI5e0/1BGAisj5CAYiLv+i3xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(16526019)(186003)(26005)(6486002)(966005)(44832011)(3480700007)(478600001)(4001150100001)(45080400002)(2616005)(6666004)(83380400001)(31686004)(956004)(66556008)(36756003)(8676002)(5660300002)(66476007)(52116002)(31696002)(53546011)(2906002)(316002)(8936002)(86362001)(66946007)(16576012)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 41m7S2SoW3ZykqRn1OqcgTgmtiAZZuSncIwU15D3Q95DNm6Wg8m+kJRN4Tcuavc9yOxMcXL9sfV23OlRVmVXa7ynjOQShUp/JEw++bk4luPxMngmhhq8QMH/B6qE/kKmnGM4gx8Ny/VMIwxyQ7rIiNWFrNaaW71EOX3+qvgPQIUlWPhSJYM0WOtBg3wqsY0stsDGZwnwiruQ6wHnhQL83hSTH1hvUbS31Z5PtmFXNOv3E9cc33wBhVgoMDJ/cOdA9tfki1RVyfwyVnQoa61MxRiZ0T4WaLiHf1lLvT6a/xWbswmgY3ZShB2KR48SLG5WYbc8wp7Lwft+lQPKZZQpCEIZfIQkQdmegHgZfJH0zEW9gdfSip7WWVJOyTzoYAN1LcVoVXLB1D8UnA/Qxr1wUttHC7EbxqfHFzWOotDQ1555jmvGiDnMTUYMWh2WYyVNAFYQVcCeqhNaOh2ZK4RJF2nSmiDaOUbpKRYt7RoRIk+V1ELnmdPnhUIVS3V27is5j1L9AjesOA0dQmaZI7aNp3xzhisgmfHM7hFYKYDYWnOxPaHHqWDD/zS5nrAMGdK7FEnYJX0+6kHUWWM++6JL8xTQ0Vpmkd4kUepaR4MPl9DG+WiwqOdThNyzU5caE6Zp1rRPLMNmtcuSdVLYGfOwIA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26fc143-fb30-4446-e6c4-08d87ce92ed3
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2020 15:33:43.1074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgwbM6/+jwl30eDsjji7MqdU20GeGvh2WDgPMcwosUXYw1qdpr/GOlAqRvggBb1n7WVXhmeozJYAiZOaZb3ZUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4523
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

VGhhbmtzLCBCcnlhbiwgZm9yIHlvdXIgcmVwb3J0LiBJdCB3YXMgaW5kZWVkIGFuIGlzc3VlIHdp
dGggdGhlIG1lcmdlLiAKVGhlIGZpeCB3aWxsIGJlIGluIG5leHQgd2VlaydzIHNldCBvZiBEQyBw
YXRjaGVzLgoKSGFycnkKCgoKT24gMjAyMC0xMC0yOCAxOjM5IHAubS4sIEJyeWFuIEFuZ2VsbyB3
cm90ZToKPiBXaGlsZSBsb29raW5nIGF0IHRoZSBmb2xsb3dpbmcgY29tbWl0LCBJIG5vdGljZWQg
d2hhdCBtaWdodCBiZSBhbiAKPiBhcml0aG1ldGljIGlzc3VlIHBvdGVudGlhbGx5IHN0ZW1taW5n
IGZyb20gc29tZSBtZXJnZS9wYXRjaCBjb25mbGljdCAKPiByZXNvbHV0aW9uLgo+IAo+IGNvbW1p
dCBhZDMzOWY2OTExNGE2YTE0NWZjOTRkNDQzNzY4NTFjNTNkZWUzNDc1Cj4gQXV0aG9yOiBKYWVo
eXVuIENodW5nIDxqYWVoeXVuLmNodW5nQGFtZC5jb20gPG1haWx0bzpqYWVoeXVuLmNodW5nQGFt
ZC5jb20+Pgo+IERhdGU6IMKgIFRodSBKdW4gMTggMTU6Mjc6MzUgMjAyMCAtMDQwMAo+IAo+ICDC
oCDCoCBkcm0vYW1kL2Rpc3BsYXk6IEZpeCBpbmNvcnJlY3Qgcm91bmRpbmcgZm9yIDEwSHogcmVm
cmVzaCByYW5nZQo+IAo+ICDCoCDCoCBbV2h5XQo+ICDCoCDCoCBJbiBjYXNlcyB3aGVyZSByZWZy
ZXNoIHJhbmdlIGlzIHNsaWdodGx5IGJlbG93IDEwLCBGcmVlU3luYyBpcyBub3QKPiAgwqAgwqAg
YWN0aXZlIG9yIHN1cHBvcnRlZC4gTmVlZCB0byByb3VuZCB2YWx1ZXMgYmVmb3JlIGNoZWNraW5n
IHJlZnJlc2ggcmFuZ2UKPiAgwqAgwqAgaW4gb3JkZXIgdG8gaGF2ZSBGcmVlU3luYyBzdXBwb3J0
ZWQgaW4gdGhlc2UgY2FzZXMuCj4gCj4gIMKgIMKgIFtIb3ddCj4gIMKgIMKgIFJlbW92ZSByZWR1
bmRhbnQgdmFsdWVzIGFuZCByb3VuZCB2YWx1ZXMgYmVmb3JlIGNoZWNraW5nIHZhbGlkIAo+IHJl
ZnJlc2ggcmFuZ2UuCj4gCj4gIMKgIMKgIFNpZ25lZC1vZmYtYnk6IEphZWh5dW4gQ2h1bmcgPGph
ZWh5dW4uY2h1bmdAYW1kLmNvbSAKPiA8bWFpbHRvOmphZWh5dW4uY2h1bmdAYW1kLmNvbT4+Cj4g
IMKgIMKgIFJldmlld2VkLWJ5OiBBcmljIEN5ciA8QXJpYy5DeXJAYW1kLmNvbSA8bWFpbHRvOkFy
aWMuQ3lyQGFtZC5jb20+Pgo+ICDCoCDCoCBBY2tlZC1ieTogQW50aG9ueSBLb28gPEFudGhvbnku
S29vQGFtZC5jb20gCj4gPG1haWx0bzpBbnRob255Lktvb0BhbWQuY29tPj4KPiAgwqAgwqAgQWNr
ZWQtYnk6IEVyeWsgQnJvbCA8ZXJ5ay5icm9sQGFtZC5jb20gPG1haWx0bzplcnlrLmJyb2xAYW1k
LmNvbT4+Cj4gIMKgIMKgIFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRl
dWNoZXJAYW1kLmNvbSAKPiA8bWFpbHRvOmFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Pgo+IAo+
IFRoZXJlIGFwcGVhcnMgdG8gYmUgYW4gZXJyYW50IHBsdXMgc2lnbiB3aGVuIGNhbGN1bGF0aW5n
IHRoZSAKPiByZWZyZXNoX3JhbmdlIC0gCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L21vZHVsZXMvZnJlZXN5bmMvZnJlZXN5bmMuYz9oPXY1LjEwLXJjMSNuOTQ4
IAo+IDxodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9
aHR0cHMlM0ElMkYlMkZnaXQua2VybmVsLm9yZyUyRnB1YiUyRnNjbSUyRmxpbnV4JTJGa2VybmVs
JTJGZ2l0JTJGdG9ydmFsZHMlMkZsaW51eC5naXQlMkZ0cmVlJTJGZHJpdmVycyUyRmdwdSUyRmRy
bSUyRmFtZCUyRmRpc3BsYXklMkZtb2R1bGVzJTJGZnJlZXN5bmMlMkZmcmVlc3luYy5jJTNGaCUz
RHY1LjEwLXJjMSUyM245NDgmZGF0YT0wNCU3QzAxJTdDSEFSUlkuV0VOVExBTkQlNDBhbWQuY29t
JTdDZDc1YTdmN2QwZjNjNDFhMjA3OTgwOGQ4N2I3MzFkY2UlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUx
MWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3Mzk1MDgyMTA4MjQ3MDYzJTdDVW5rbm93biU3Q1RX
RnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsx
aGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzIwMDAmc2RhdGE9TUJzS0N0ZW9UOVFneWRPUnlVMmUlMkZN
V3lDUDBhZTBkcDhjaEJ6SGN6YlNvJTNEJnJlc2VydmVkPTA+Cj4gCj4gIMKgIHJlZnJlc2hfcmFu
Z2UgPSBkaXZfdTY0KGluX291dF92cnItPm1heF9yZWZyZXNoX2luX3VoeiArIDUwMDAwMCwgCj4g
MTAwMDAwMCkgLQo+ICsgZGl2X3U2NChpbl9vdXRfdnJyLT5taW5fcmVmcmVzaF9pbl91aHogKyA1
MDAwMDAsIDEwMDAwMDApOwo+IAo+IEkgYW0gdW5mYW1pbGlhciB3aXRoIHRoZSBmcmVlc3luYyBj
b2RlYmFzZSBzbyBJIG9wdGVkIHRvIHByZXNlbnQgdGhlIAo+IHBvdGVudGlhbCBpc3N1ZSBoZXJl
IGFzIG9wcG9zZWQgdG8gcHJlcGFyaW5nIGEgcGF0Y2guCj4gCj4gVGhhbmtzLgo+IAo+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWls
aW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbmFtMTEu
c2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3Rz
LmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9
MDQlN0MwMSU3Q0hBUlJZLldFTlRMQU5EJTQwYW1kLmNvbSU3Q2Q3NWE3ZjdkMGYzYzQxYTIwNzk4
MDhkODdiNzMxZGNlJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3
QzYzNzM5NTA4MjEwODI2NzAyNSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdM
akF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0My
MDAwJmFtcDtzZGF0YT1zZ09RaiUyQlJmcXBFdmdiM1Nqd215T0JxNUd6anp0dHRZTGltcWwzTSUy
RmlTQSUzRCZhbXA7cmVzZXJ2ZWQ9MAo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
