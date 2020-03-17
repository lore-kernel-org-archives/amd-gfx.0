Return-Path: <SRS0=ZDaT=5C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E03C1975A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2020 20:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9A1B20714
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2020 20:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JL2yDNnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A1B20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFF8B89E41;
	Tue, 17 Mar 2020 20:46:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68C9789E26
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2020 20:46:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+yP1FnYjaCFvs9IHtYspObiEPyLHoc2zSq10w4IvLnxmd2vSAEEpa0bjVzQDov/sOzbsSjvPqPu5rD4Qy29+8V8mz9IMPH5rJKcM3+IvON+h6aJxuEyCiUvHpV0xFvnnLINFojj3CvY4UhLhmWo78+kpY7zZmpBiYwrA7wRfIinmUD1dOfrnP2ffUVgpGt1uazvl5XL26z0jIRm7H3O6nmhSfdYKJmcDMlWOLs+9vxXOalbZdrA+Q29Z6rX0xfjYwVjb47RNg5Qlnn4Yw1q2jck25GllVGn3Vkyqd3aXMJK6BsUsHNma/jagq+7sBvctOeEuV3whDE3bcBMcnM5Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ll/ddcUMY8tYq910uhpXGMSMYYdaqgF8H2s8ThviSdY=;
 b=BaVjeV9KaemUwmCZgCZmJXE9XHtZNhvPV8PP3DvXJaGst3dEiqab2AZ98WB5PAWoTzz6n3F9Y0sBWmOl1CtWnj1/tkJ6UECsGvjJlSnIkNHeRqDPqSHhvt94socCkJEVvzXuqzI0qap2XCom9ynvHvtmcSnVYY4QQTYrGXC19/4tuzbzGlzr0gotJcnI6RJtN+ADbPThI11jkRpeWWjNYLvg5R/xoWUoaKPnJkdXYimD7Bt6NjqS11z3m1ney0JIC4UYDW5dgppPdFqRDcAIjiPLjgArV/tPgnWJOwJdu2DfRVVQinc8C7/sfO8/0mEfN7b48YRhnlo7DD0P71QlTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ll/ddcUMY8tYq910uhpXGMSMYYdaqgF8H2s8ThviSdY=;
 b=JL2yDNnwDix1yQ5jLVwXsSjDDRi2YGxDn4BREqmZKP67FOmlu7ZewUENQ7y+TFCpDKQfC+eqhiBfUlpXB7ofbJsLt114U7XnwuT1CNH7LgiETyp3Z/c4IpheGoeNt0nSNlkzNTtyz4PiOTaWlqU6Ic6J6VcIwqZbpplFXQ0Q+wc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Tue, 17 Mar
 2020 20:46:26 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 20:46:26 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: disable gpu_sched load balancer for vcn
 jobs
To: Nirmoy <nirmodas@amd.com>, christian.koenig@amd.com,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200311200032.50502-1-nirmoy.das@amd.com>
 <4fc782f4-8274-f69a-e4f8-8b087511a94d@amd.com>
 <745e7c4e-1dd7-ec7c-a787-88410414faab@amd.com>
 <4ee422df-5b57-ea1e-ae42-0ef702a657a8@amd.com>
 <ee63269d-8c95-cbb2-c64d-55a5061feb44@amd.com>
 <8b7ea4fd-01b3-72d8-8fa3-4745fe011fce@amd.com>
 <f007d1af-08e8-eb20-1ef5-5d6f18e56273@gmail.com>
 <3fac4046-0c2c-7fa9-7c83-6af9149e50bf@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <4616f7cc-ce70-d74c-5a62-d736fec08085@amd.com>
Date: Tue, 17 Mar 2020 16:46:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <3fac4046-0c2c-7fa9-7c83-6af9149e50bf@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::36)
 To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.4] (108.162.131.176) by
 YT1PR01CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.16 via Frontend Transport; Tue, 17 Mar 2020 20:46:24 +0000
X-Originating-IP: [108.162.131.176]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 540694fd-a727-467f-3f43-08d7cab442ad
X-MS-TrafficTypeDiagnostic: DM6PR12MB4417:|DM6PR12MB4417:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4417310207E8991BF253472299F60@DM6PR12MB4417.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(199004)(4326008)(31686004)(966005)(45080400002)(478600001)(81166006)(8676002)(81156014)(66574012)(2616005)(66946007)(16526019)(66556008)(36756003)(26005)(186003)(2906002)(956004)(5660300002)(66476007)(44832011)(86362001)(31696002)(6486002)(16576012)(53546011)(316002)(52116002)(55236004)(8936002)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4417;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BIMwCNlAVXxFdRJ6d3A6Xu3j+7Ap06k4WobKUzcfQUy8bn8WNYXni/bpOFIIxxsHnUA3dI0KoZTyDkjIfXfejQEF+hkPSMfGuidGaH1k5YTCgKzsfJ6wRVr6EjrLRVF12lx0XI/2MWvv4cydpjkvpf/gj8OvpmCmtFVYm4YNuyRXaQli8NnhW98f33ZvRHMr6yD0wp54C8AG2IzY5LpkW2ENc9EaZFIVtT4Q2S8pZlDSdvWxQElw7H91NcdxQW11jC6gdDcgWEJKXW4H2vwbk02w1PKV2gIHukECJVf8a7EHoSDe852WtnSwWtkVj6F7wwsL4Iw+PHHsYFpmzwSrf0kzByLMbXmTzsfizCnKo0+6EGoarXwtULtlaJPVNa4PqoNvA07FMo+lIr7RUe7Hhfb2jk2Vuyk4lMN8O8MmiUCl3qa1DJhfvgLCFqDqGMoMf/POYkurDNGkBeifcyGzjx8VzgV7Pdl9HIcf5KZF094=
X-MS-Exchange-AntiSpam-MessageData: xprOwrMsZz2AXZF/pSlzwH3N8y7Rn5mXkQSTFCIdsPudEndZjw6kgjYasScA2lRZiUaBBUWIYfyNTLPlyTCZ5xuUlmoQnnE5+c8/HRnZvhyMr42Dgh3BWVpqhhznO65lO5lOZOC5Ghg6eNlg1gatpw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540694fd-a727-467f-3f43-08d7cab442ad
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 20:46:26.0427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/Gtzq0Ut5k8xSarOg4c7F38gFqIp9r9AJyZc8ZMZp06EhXRcoKPUl4vQildIAji
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wMy0xMiAwNjo1NiwgTmlybW95IHdyb3RlOgo+IAo+IE9uIDMvMTIvMjAgOTo1MCBB
TSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMTEuMDMuMjAgdW0gMjE6NTUgc2Nocmll
YiBOaXJtb3k6Cj4+Pgo+Pj4gT24gMy8xMS8yMCA5OjM1IFBNLCBBbmRyZXkgR3JvZHpvdnNreSB3
cm90ZToKPj4+Pgo+Pj4+IE9uIDMvMTEvMjAgNDozMiBQTSwgTmlybW95IHdyb3RlOgo+Pj4+Pgo+
Pj4+PiBPbiAzLzExLzIwIDk6MDIgUE0sIEFuZHJleSBHcm9kem92c2t5IHdyb3RlOgo+Pj4+Pj4K
Pj4+Pj4+IE9uIDMvMTEvMjAgNDowMCBQTSwgQW5kcmV5IEdyb2R6b3Zza3kgd3JvdGU6Cj4+Pj4+
Pj4KPj4+Pj4+PiBPbiAzLzExLzIwIDQ6MDAgUE0sIE5pcm1veSBEYXMgd3JvdGU6Cj4+Pj4+Pj4+
IFtTTklQXQo+Pj4+Pj4+PiBAQCAtMTI1Nyw2ICsxMjU4LDkgQEAgc3RhdGljIGludCBhbWRncHVf
Y3Nfc3VibWl0KHN0cnVjdCAKPj4+Pj4+Pj4gYW1kZ3B1X2NzX3BhcnNlciAqcCwKPj4+Pj4+Pj4g
wqDCoMKgwqDCoCBwcmlvcml0eSA9IGpvYi0+YmFzZS5zX3ByaW9yaXR5Owo+Pj4+Pj4+PiDCoMKg
wqDCoMKgIGRybV9zY2hlZF9lbnRpdHlfcHVzaF9qb2IoJmpvYi0+YmFzZSwgZW50aXR5KTsKPj4+
Pj4+Pj4gwqAgK8KgwqDCoCBpZiAocmluZy0+ZnVuY3MtPm5vX2dwdV9zY2hlZF9sb2FkYmFsYW5j
ZSkKPj4+Pj4+Pj4gKyBhbWRncHVfY3R4X2Rpc2FibGVfZ3B1X3NjaGVkX2xvYWRfYmFsYW5jZShl
bnRpdHkpOwo+Pj4+Pj4+PiArCj4+Pj4+Pj4KPj4+Pj4+Pgo+Pj4+Pj4+IFdoeSB0aGlzIG5lZWRz
IHRvIGJlIGRvbmUgZWFjaCB0aW1lIGEgam9iIGlzIHN1Ym1pdHRlZCBhbmQgbm90IAo+Pj4+Pj4+
IG9uY2UgaW4gZHJtX3NjaGVkX2VudGl0eV9pbml0IChzYW1lIGZvcmFtZGdwdV9qb2Jfc3VibWl0
IGJlbGxvdyA/KQo+Pj4+Pj4+Cj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+IE15
IGJhZCAtIG5vdCBpbiBkcm1fc2NoZWRfZW50aXR5X2luaXQgYnV0IGluIHJlbGV2YW50IGFtZGdw
dSBjb2RlLgo+Pj4+Pgo+Pj4+Pgo+Pj4+PiBIaSBBbmRyZXksCj4+Pj4+Cj4+Pj4+IERvIHlvdSBt
ZWFuIGRybV9zY2hlZF9qb2JfaW5pdCgpIG9yIGFmdGVyIGNyZWF0aW5nIFZDTiBlbnRpdGllcz8K
Pj4+Pj4KPj4+Pj4KPj4+Pj4gTmlybW95Cj4+Pj4KPj4+Pgo+Pj4+IEkgZ3Vlc3MgYWZ0ZXIgY3Jl
YXRpbmcgdGhlIFZDTiBlbnRpdGllcyAoaGFzIHRvIGJlIGFtZGdwdSBzcGVjaWZpYyAKPj4+PiBj
b2RlKSAtIEkganVzdCBkb24ndCBnZXQgd2h5IGl0IG5lZWRzIHRvIGJlIGRvbmUgZWFjaCB0aW1l
IGpvYiBpcyAKPj4+PiBzdWJtaXR0ZWQsIEkgbWVhbiAtIHNpbmNlIHlvdSBzZXQgLm5vX2dwdV9z
Y2hlZF9sb2FkYmFsYW5jZSA9IHRydWUgCj4+Pj4gYW55d2F5IHRoaXMgaXMgYWx3YXlzIHRydWUg
YW5kIHNvIHNob3VsZG4ndCB5b3UganVzdCBpbml0aWFsaXplIHRoZSAKPj4+PiBWQ04gZW50aXR5
IHdpdGggYSBzY2hlZHVsZXJzIGxpc3QgY29uc2lzdGluZyBvZiBvbmUgc2NoZWR1bGVyIGFuZCAK
Pj4+PiB0aGF0IGl0ID8KPj4+Cj4+Pgo+Pj4gQXNzdW1wdGlvbjogSWYgSSB1bmRlcnN0YW5kIGNv
cnJlY3RseSB3ZSBzaG91bGRuJ3QgYmUgZG9pbmcgbG9hZCAKPj4+IGJhbGFuY2UgYW1vbmcgVkNO
IGpvYnMgaW4gdGhlIHNhbWUgY29udGV4dC4gQ2hyaXN0aWFuLCBKYW1lcyBhbmQgTGVvIAo+Pj4g
Y2FuIGNsYXJpZnkgdGhhdCBpZiBJIGFtIHdyb25nLgo+Pj4KPj4+IEJ1dCB3ZSBjYW4gc3RpbGwg
ZG8gbG9hZCBiYWxhbmNlIG9mIFZOQyBqb2JzIGFtb25nIG11bHRpcGxlIGNvbnRleHRzLiAKPj4+
IFRoYXQgbG9hZCBiYWxhbmNlIGRlY2lzaW9uIGhhcHBlbnMgaW4gZHJtX3NjaGVkX2VudGl0eV9p
bml0KCkuIElmIHdlIAo+Pj4gaW5pdGlhbGl6ZSBWQ04gZW50aXR5IHdpdGggb25lIHNjaGVkdWxl
ciB0aGVuCj4+Pgo+Pj4gYWxsIGVudGl0aWVzIGlycmVzcGVjdGl2ZSBvZiBjb250ZXh0IGdldHMg
dGhhdCBvbmUgc2NoZWR1bGVyIHdoaWNoIAo+Pj4gbWVhbnMgd2UgYXJlIG5vdCB1dGlsaXppbmcg
ZXh0cmEgVk5DIGluc3RhbmNlcy4KPj4KPj4gQW5kcmV5IGhhcyBhIHZlcnkgZ29vZCBwb2ludCBo
ZXJlLiBTbyBmYXIgd2Ugb25seSBsb29rZWQgYXQgdGhpcyBmcm9tIAo+PiB0aGUgaGFyZHdhcmUg
cmVxdWlyZW1lbnQgc2lkZSB0aGF0IHdlIGNhbid0IGNoYW5nZSB0aGUgcmluZyBhZnRlciB0aGUg
Cj4+IGZpcnN0IHN1Ym1pc3Npb24gYW55IG1vcmUuCj4+Cj4+IEJ1dCBpdCBpcyBjZXJ0YWlubHkg
dmFsdWFibGUgdG8ga2VlcCB0aGUgZXh0cmEgb3ZlcmhlYWQgb3V0IG9mIHRoZSBob3QgCj4+IHBh
dGggZHVyaW5nIGNvbW1hbmQgc3VibWlzc2lvbi4KPiAKPiAKPiAKPj4KPj4+IElkZWFsbHkgd2Ug
c2hvdWxkIGJlIGNhbGxpbmcgCj4+PiBhbWRncHVfY3R4X2Rpc2FibGVfZ3B1X3NjaGVkX2xvYWRf
YmFsYW5jZSgpIG9ubHkgb25jZSBhZnRlciAxc3QgY2FsbCAKPj4+IG9mIGRybV9zY2hlZF9lbnRp
dHlfaW5pdCgpIG9mIGEgVkNOIGpvYi4gSSBhbSBub3Qgc3VyZSBob3cgdG8gZG8gdGhhdCAKPj4+
IGVmZmljaWVudGx5Lgo+Pj4KPj4+IEFub3RoZXIgb3B0aW9uIG1pZ2h0IGJlIHRvIGNvcHkgdGhl
IGxvZ2ljIG9mIAo+Pj4gZHJtX3NjaGVkX2VudGl0eV9nZXRfZnJlZV9zY2hlZCgpIGFuZCBjaG9v
c2Ugc3VpdGFibGUgVk5DIHNjaGVkIAo+Pj4gYXQvYWZ0ZXIgVkNOIGVudGl0eSBjcmVhdGlvbi4K
Pj4KPj4gWWVzLCBidXQgd2Ugc2hvdWxkIG5vdCBjb3B5IHRoZSBsb2dpYyBidXQgcmF0aGVyIHJl
ZmFjdG9yIGl0IDopCj4+Cj4+IEJhc2ljYWxseSB3ZSBuZWVkIGEgZHJtX3NjaGVkX3BpY2tfYmVz
dCgpIGZ1bmN0aW9uIHdoaWNoIGdldHMgYW4gYXJyYXkgCj4+IG9mIGRybV9ncHVfc2NoZWR1bGVy
IHN0cnVjdHVyZXMgYW5kIHJldHVybnMgdGhlIG9uZSB3aXRoIHRoZSBsZWFzdCAKPj4gbG9hZCBv
biBpdC4KPj4KPj4gVGhpcyBmdW5jdGlvbiBjYW4gdGhlbiBiZSB1c2VkIGJ5IFZDTiB0byBwaWNr
IG9uZSBpbnN0YW5jZSBiZWZvcmUgCj4+IGluaXRpYWxpemluZyB0aGUgZW50aXR5IGFzIHdlbGwg
YXMgYSByZXBsYWNlbWVudCBmb3IgCj4+IGRybV9zY2hlZF9lbnRpdHlfZ2V0X2ZyZWVfc2NoZWQo
KSB0byBjaGFuZ2UgdGhlIHNjaGVkdWxlciBmb3IgbG9hZCAKPj4gYmFsYW5jaW5nLgo+IAo+IAo+
IFRoaXMgc291bmRzIGxpa2UgYSBvcHRpbXVtIHNvbHV0aW9uIGhlcmUuCj4gCj4gVGhhbmtzIEFu
ZHJleSBhbmQgQ2hyaXN0aWFuLiBJIHdpbGwgcmVzZW5kIHdpdGggc3VnZ2VzdGVkIGNoYW5nZXMu
CgpOb3RlIHRoYXQgdGhpcyBpc24ndCBhbiBvcHRpbWFsIHNvbHV0aW9uLiBOb3RlIHRoYXQgZHJt
X3NjaGVkX3BpY2tfYmVzdCgpCmFuZCBkcm1fc2NoZWRfZW50aXR5X2dldF9mcmVlX3NjaGVkKCkg
KHRoZXNlIG5hbWVzIGFyZSB0b28gbG9uZyksIGFyZSBzaW1pbGFyCmluIHdoYXQgdGhleSBkbywg
aW4gdGhhdCB0aGV5IHBpY2sgYSBzY2hlZHVsZXIsIHdoaWNoIGlzIHN0aWxsIGEgY2VudHJhbGl6
ZWQKZGVjaXNpb24gbWFraW5nLgoKQW4gb3B0aW1hbCBzb2x1dGlvbiB3b3VsZCBiZSBmb3IgZWFj
aCBleGVjdXRpb24gdW5pdCB0byBwaWNrIHdvcmsKd2hlbiB3b3JrIGlzIGF2YWlsYWJsZSwgd2hp
Y2ggaXMgYSBkZWNlbnRyYWxpemVkIGRlY2lzaW9uIG1vZGVsLgoKTm90IHN1cmUgaG93IGFuIGFy
cmF5IHdvdWxkIGJlIHVzZWQsIGFzIHRoZSBwcm9wb3NpdGlvbiBoZXJlIGlzCmxhaWQgb3V0LS13
b3VsZCB0aGF0IGJlIGFuIE8obikgc2VhcmNoIHRocm91Z2ggdGhlIGFycmF5PwoKSW4gYW55IGNh
c2UsIGNlbnRyYWxpemVkIGRlY2lzaW9uIG1ha2luZyBpbnRyb2R1Y2VzIGEgYm90dGxlbmVjay4g
RGVjZW50cmFsaXplZApzb2x1dGlvbnMgYXJlIGF2YWlsYWJsZSBmb3Igc2NoZWR1bGluZyB3aXRo
IE8oMSkgdGltZSBjb21wbGV4aXR5LgoKUmVnYXJkcywKTHViZW4KCgo+IAo+IAo+Pgo+PiBSZWdh
cmRzLAo+PiBDaHJpc3RpYW4uCj4+Cj4+Pgo+Pj4KPj4+IFJlZ2FyZHMsCj4+Pgo+Pj4gTmlybW95
Cj4+Pgo+Pgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRw
cyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFt
ZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q2x1YmVuLnR1aWtvdiU0MGFtZC5jb20lN0M5MDNiN2Iz
YTZmYWY0ODBmMWE3OTA4ZDdjNjczOGJhZSU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUx
ODNkJTdDMCU3QzAlN0M2MzcxOTYwNzE4OTU2NDA3NjQmYW1wO3NkYXRhPVJyUHJaNWFIVk9oTWQ1
SDh3RXFDdCUyRlBQU0JOTEN5UlZ3RG9MQlU0cDNJdyUzRCZhbXA7cmVzZXJ2ZWQ9MAo+IAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
