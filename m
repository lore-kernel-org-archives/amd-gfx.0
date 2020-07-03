Return-Path: <SRS0=khk6=AO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430F1C433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 07:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8ED2088E
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 07:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iZpogXBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8ED2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FC846E9A3;
	Fri,  3 Jul 2020 07:50:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7862B6E9A3
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2020 07:50:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErNNE88BuFLvwoG3GIFVawKb+A53QvaLApmfjZZvKHur3Ho38VSOrk+L+/w341Z2uy2l6xDcuk/LEdF0iiQf/J/3LPovtIeItS42NsafNGmJ5vIcXsOaLRljvS0J0GUs9wRSXytcBDwAYAtJrN4ZDZNz55cc/2moEiUBgd7sfxN/P8idm5zJy6hwI8IFA10hgwOKLXTDUXBXOxHXiwn8jvukmteF7epxKru2YtOtSz0+ooVc4j3X71/Fj5WH8n/kkDv8Og2oveANc2TabE6ev+lRxsWUrwHwecttbW9QVoft5T+JWj9a+es6dPoqoCTzQhPvVUZbWWp0lh1bEGBHHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuS1GbDePAJBFvwK1eSYUckKK+QTignUjTj3HdmKS3Y=;
 b=lqhOMRLE8LNknXqybkBqmDZMNN0BAU6gDt5F2AwluViSHhoe5HH7wFZOY5FffbijDX7SizuRXSm8Evf0US76YrRhPTCq4QKFpP5v9iBHyU28LNMT/t043Xx8DhI8q0QZpWUB6pCJu0K+Ey/TCgLio6pMzNhZv83oUr6riTFInHbQ8jukleiankELOhYRAf1Pu+O2Kt1L5YrbpGfiwflA2pcMdWOXNhuUo0WxAsO/zaG7zhbboxEKwL8jKxNF/hl+NPGuqllM75Tcv4hffUPSKl0qqqV5/FEnoeDEiuAy9uebs3mP0End8qB0VLS+QDq3xSufBnauzf95+I+l3VUbUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuS1GbDePAJBFvwK1eSYUckKK+QTignUjTj3HdmKS3Y=;
 b=iZpogXBl7pQYgx95B891pp8GMvLMKcgSHFv2lOiNn//ICDtRF6InfBOQrvEDnMLeoqawB1GTUNVXlZkizgzI2JdB40hCEhm79LitvSdMXVSFVVerIMx4+j1IfcOTLc6BrHdtyPpUmCTP0Y1rRRB89MMiBiV30WREZo5uy5prma0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3887.namprd12.prod.outlook.com (2603:10b6:208:168::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Fri, 3 Jul
 2020 07:50:37 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3153.028; Fri, 3 Jul 2020
 07:50:37 +0000
Subject: Re: [PATCH] drm/amdgpu: return an error for hw access in INFO ioctl
 when in reset
To: Felix Kuehling <felix.kuehling@amd.com>, "Li, Dennis"
 <Dennis.Li@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20200626140423.1425349-1-alexander.deucher@amd.com>
 <CADnq5_MzKqWxOdzGSVUWU3cJaXwXNNB3T0igMP8dyRpLMGpgEw@mail.gmail.com>
 <50d38fa7-5efd-e6ec-d3bd-313cc0138666@gmail.com>
 <DM5PR12MB253318A2BF34A961F75176C0ED6C0@DM5PR12MB2533.namprd12.prod.outlook.com>
 <ba40ec07-b7b3-4b12-283b-d001a3adbc74@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <8e41e787-4c70-fd84-b1ef-5e33165a5547@amd.com>
Date: Fri, 3 Jul 2020 09:50:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <ba40ec07-b7b3-4b12-283b-d001a3adbc74@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0026.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::36) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR10CA0026.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend
 Transport; Fri, 3 Jul 2020 07:50:35 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c7540a21-7ec9-4313-760a-08d81f25c5dd
X-MS-TrafficTypeDiagnostic: MN2PR12MB3887:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3887A76E08334A00C772F930836A0@MN2PR12MB3887.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u249xYkM3BQZgqf6hBMCngi31bHK09vAHOPN+sg9g02XN3H1GESaLe5T2X5bgS/nOBPMAMYJGqil0wThUmSEvpkqg9bnFfTjr4J9dThNQ5ThAVoPcwAzcb0XRv8dq6+5yyPRjJCnvYhFdNNgqIWzWCZ9lZeITPF53ChdcyfNjC5VFruUqDNMJ54FyiWIZMM6gifA6f6BTPFPH9gf17NEiO7YMVNOO+z3c/glEPPFRPjbyvce4KZ/KzXLl80uGVY1KZBYNfrxZNsxsY2CcQe18MbfQkT3OFib6/P5LQg7YVp6TyS39gcYABp70RwiF+nzTrLiihsKhvTkbOPzxlVAwE13Aoa0p+8nkP6+acGGXZIBJlq94vAhsX/18bUnlpOB8DP811dTzW3vprtEFn7MHW0I9St5/ca+ETIvXuN8oPY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(86362001)(53546011)(316002)(110136005)(31696002)(66574015)(966005)(8676002)(2906002)(8936002)(52116002)(478600001)(6486002)(2616005)(4326008)(31686004)(83380400001)(36756003)(66556008)(5660300002)(16526019)(66946007)(6666004)(186003)(66476007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: DE0Vlm3Je8XmMX75xgxYWhjvRMOcAYvxvb1FarbZ7Mv0akmU7Dd6/DGydil2t4wb+7hrOH9ZVIoA1L1oger8bYrPjMRiXcEBGO/i6Ni5pa7QLNJLiJL+hEreOQTEQYshSjvT5XtYWaVoSvTjo4EkqoHGHTUJuknnQYuXh/+WReFVPSgDSINyMabNxSZiaHaVHXy805t9oRspFBGxVsG8MIP+xreKqSjWENTF2JePMiRRZrMLgclt0fI8IbEPJ0Yz4H3o1IVpZn9PgI3thQRRw4uMA9qXAri1fusm51jrf2dxj1eiwrWIGr3oOmfgPn5VQrIRLm7rKeeTRTF7+NGVoTCtrgWZz9Vmz1IRMcN4eL4M2nqtaB6QTOWnVdMYHCiwf9Zm7MxV/1XGruESMlbsIFa1gT9kqrxCwmiH0e9L6TQhV9NbKC9IpVinOpGjmgk2cyfBNXRoRbKWtWcT5EqFlMDDUCguDzwUx1o/Mboxe+I8wSfkT9mT09RD58Q1TTBls7aLPTh5x0zKnJyyHfmWTCG7tM9Gj96COH/rv+a6Pa+HKUWrBhQTKpVFg0KaVKVO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7540a21-7ec9-4313-760a-08d81f25c5dd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 07:50:37.5606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2SKusf5FHSw5wCSOuk6QspE9eqCMu1xt19iAATPvdHGsq0TA/Jta3C7/bD+UzoPe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3887
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDMuMDcuMjAgdW0gMDg6MDUgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBBbSAyMDIwLTA3
LTAxIHVtIDEwOjM0IGEubS4gc2NocmllYiBMaSwgRGVubmlzOgo+PiBbQU1EIE9mZmljaWFsIFVz
ZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldCj4+Cj4+IEhpLCBDaHJpc3RpYW4g
YW5kIEFsZXgKPj4gICAgICAgIE5vdCBvbmx5IGFtZGdwdSBpb2N0bHMsIGJ1dCBhbWRrZmQgaW9j
dGxzIGFsc28gaGF2ZSB0aGUgc2FtZSBpc3N1ZS4KPiBNb3N0IEtGRCBpb2N0bHMgZG9uJ3QgYWNj
ZXNzIEhXIGRpcmVjdGx5LiBUaGUgb25seSBwbGFjZSB0aGF0IGludGVyYWN0cwo+IHdpdGggSFcg
aW4gS0ZEIGlzIHRoZSBkZXZpY2UgcXVldWVzIG1hbmFnZXIgKERRTSkgYW5kIGJlbmVhdGggaXQg
dGhlCj4gcGFja2V0IG1hbmFnZXIuIEluIERRTSB3ZSBhbHJlYWR5IGhhdmUgcHJvdGVjdGlvbnMg
dG8gYXZvaWQgSFcgYWNjZXNzCj4gd2hpbGUgYSByZXNldCBpcyBpbiBwcm9ncmVzcy4KPgo+IEZv
ciBvdGhlciBIVyBhY2Nlc3MsIEtGRCBnb2VzIHRocm91Z2ggaGVscGVyIGZ1bmN0aW9ucyBpbiBh
bWRncHUuCj4KPiBNZW1vcnkgbWFuYWdlbWVudCBpb2N0bHMgaW5kaXJlY3RseSBhY2Nlc3MgSFcg
Zm9yIHBhZ2UgdGFibGUgdXBkYXRlcy4KPiBIb3dldmVyLCB0aGF0IHJlcXVpcmVzIHZhbGlkYXRp
bmcgdGhlIHBhZ2UgdGFibGUgQk9zIGZpcnN0LiBBcmUgVlJBTSBCT3MKPiBjb25zaWRlcmVkICJ2
YWxpZCIgZHVyaW5nIGEgR1BVIHJlc2V0PyBXaGVuIHVzaW5nIFNETUEgZm9yIHBhZ2UgdGFibGUK
PiB1cGRhdGVzLCB0aGUgRFJNIEdQVSBzY2hlZHVsZXIgaXMgYWxzbyBpbnZvbHZlZC4gSXMgdGhh
dCBzdXNwZW5kZWQKPiBkdXJpbmcgYSBHUFUgcmVzZXQ/CgpUaGF0IHN0dWZmIHNob3VsZCB3b3Jr
IGNvbmN1cnJlbnRseS4gVGhlIHNjaGVkdWxlciBpcyBzdG9wcGVkIGR1cmluZyBhIApyZXNldCwg
YnV0IHdlIGNhbiBzdGlsbCBwdXNoIG5ldyBqb2JzIHRvIHRoZSBxdWV1ZXMuCgpTdHVmZiBsaWtl
IFRMQiBmbHVzaGVzIGFyZSBhbHNvIGhhcm1sZXNzIHNpbmNlIGFmdGVyIGEgcmVzZXQgd2UgY2Fu
IApzYWZlbHkgYXNzdW1lIHRoYXQgdGhlIFRMQiBpcyBjb21wbGV0ZWx5IGVtcHR5LgoKPiBUaGUg
b25seSBvdGhlciBLRkQgaW9jdGwgdGhhdCBsb29rcyBsaWtlIGl0IG1pZ2h0IGFjY2VzcyBIVyBk
dXJpbmcgYSBHUFUKPiByZXNldCBpcyBrZmRfaW9jdGxfZ2V0X2Nsb2NrX2NvdW50ZXJzIGJ5IGNh
bGxpbmcKPiBhbWRncHVfYW1ka2ZkX2dldF9ncHVfY2xvY2tfY291bnRlci4KClllYWgsIHRoYXQg
aXMgaW5kZWVkIGEgcHJvYmxlbSB3aGljaCBuZWVkcyBoYW5kbGluZy4KCkNocmlzdGlhbi4KCj4K
PiBSZWdhcmRzLAo+ICDCoCBGZWxpeAo+Cj4KPgo+PiBCZXN0IFJlZ2FyZHMKPj4gRGVubmlzIExp
Cj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4+IEZyb206IGFtZC1nZnggPGFtZC1nZngt
Ym91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBDaHJpc3RpYW4gS8O2
bmlnCj4+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAxLCAyMDIwIDQ6MjAgUE0KPj4gVG86IEFsZXgg
RGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPjsgYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZz4KPj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVy
LkRldWNoZXJAYW1kLmNvbT4KPj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogcmV0
dXJuIGFuIGVycm9yIGZvciBodyBhY2Nlc3MgaW4gSU5GTyBpb2N0bCB3aGVuIGluIHJlc2V0Cj4+
Cj4+IEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyBhIGdvb2QgaWRlYSwgd2Ugc2hvdWxkIHByb2JhYmx5
IHJhdGhlciB3YWl0IGZvciB0aGUgR1BVIHJlc2V0IHRvIGZpbmlzaCBieSB0YWtpbmcgdGhlIGFw
cHJvcHJpYXRlIGxvY2suCj4+Cj4+IENocmlzdGlhbi4KPj4KPj4gQW0gMDEuMDcuMjAgdW0gMDc6
MzMgc2NocmllYiBBbGV4IERldWNoZXI6Cj4+PiBwaW5nPwo+Pj4KPj4+IE9uIEZyaSwgSnVuIDI2
LCAyMDIwIGF0IDEwOjA0IEFNIEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPiB3
cm90ZToKPj4+PiBXaGVuIHRoZSBHUFUgaXMgaW4gcmVzZXQsIGFjY2Vzc2luZyB0aGUgaHcgaXMg
dW5yZWxpYWJsZSBhbmQgY291bGQKPj4+PiBpbnRlcmZlcmUgd2l0aCB0aGUgcmVzZXQuICBSZXR1
cm4gYW4gZXJyb3IgaW4gdGhvc2UgY2FzZXMuCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4+Pj4gLS0tCj4+Pj4gICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jIHwgNiArKysrKysKPj4+PiAgICAx
IGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jCj4+Pj4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKPj4+PiBpbmRleCAzNDFkMDcyZWRkOTUuLmZkNTFk
NjU1NGVlMiAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfa21zLmMKPj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21z
LmMKPj4+PiBAQCAtNjg0LDYgKzY4NCw5IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2luZm9faW9jdGwo
c3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSwgc3RydWN0IGRybV9maWxlCj4+Pj4g
ICAgICAgICAgICAgICAgICAgaWYgKGluZm8tPnJlYWRfbW1yX3JlZy5jb3VudCA+IDEyOCkKPj4+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+Pj4+Cj4+Pj4gKyAg
ICAgICAgICAgICAgIGlmIChhZGV2LT5pbl9ncHVfcmVzZXQpCj4+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIC1FUEVSTTsKPj4+PiArCj4+Pj4gICAgICAgICAgICAgICAgICAgcmVn
cyA9IGttYWxsb2NfYXJyYXkoaW5mby0+cmVhZF9tbXJfcmVnLmNvdW50LCBzaXplb2YoKnJlZ3Mp
LCBHRlBfS0VSTkVMKTsKPj4+PiAgICAgICAgICAgICAgICAgICBpZiAoIXJlZ3MpCj4+Pj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsgQEAgLTg1NCw2ICs4NTcsOSBA
QCBzdGF0aWMKPj4+PiBpbnQgYW1kZ3B1X2luZm9faW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRl
diwgdm9pZCAqZGF0YSwgc3RydWN0IGRybV9maWxlCj4+Pj4gICAgICAgICAgICAgICAgICAgaWYg
KCFhZGV2LT5wbS5kcG1fZW5hYmxlZCkKPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiAtRU5PRU5UOwo+Pj4+Cj4+Pj4gKyAgICAgICAgICAgICAgIGlmIChhZGV2LT5pbl9ncHVf
cmVzZXQpCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FUEVSTTsKPj4+PiAr
Cj4+Pj4gICAgICAgICAgICAgICAgICAgc3dpdGNoIChpbmZvLT5zZW5zb3JfaW5mby50eXBlKSB7
Cj4+Pj4gICAgICAgICAgICAgICAgICAgY2FzZSBBTURHUFVfSU5GT19TRU5TT1JfR0ZYX1NDTEs6
Cj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBnZXQgc2NsayBpbiBNaHogKi8KPj4+
PiAtLQo+Pj4+IDIuMjUuNAo+Pj4+Cj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwo+Pj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4+IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCj4+PiBodHRwczovL2xpc3QKPj4+IHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo+Pj4gbm5pcy5MaSU0MGFtZC5jb20lN0NlZmVlZGE0
YjZkMTk0NjYwZmJjNTA4ZDgxZDk3OTFhMyU3QzNkZDg5NjFmZTQ4ODRlNgo+Pj4gMDhlMTFhODJk
OTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzI5MTg4NDEyMzM2MDM0MCZhbXA7c2RhdGE9R05QV1FObmRV
Skt4Nwo+Pj4gNzBmRFR1UkdCbkp6Zm1SVVFqRDRCMUhCaWUzeFVRJTNEJmFtcDtyZXNlcnZlZD0w
Cj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+IGFt
ZC1nZnggbWFpbGluZyBsaXN0Cj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+IGh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo+PiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBhbWQtZ2Z4
IG1haWxpbmcgbGlzdAo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
