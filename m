Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E532DC388F7
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 16:51:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B1B6217A0
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 16:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zgrMskAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1B6217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E82576E51C;
	Fri, 13 Nov 2020 16:51:54 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760047.outbound.protection.outlook.com [40.107.76.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D88D6E51C
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 16:51:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lk21pcEeUaCcAWRf7BsvjmBp9vpFiXmTVH/icMP1zNvqELJGBEED67Q1bljWp5qzwTlNeKNF+7Aje8w5IDk13jHCVfFaWAufql2r59kXZE157DtpHcBvrKoGuYFM8dfVW9gA0cc/Hp2MIyUuxLLtnNCzGzIMU6Haezg3mesLBWZezwM/PMN/dXS+lECMjQGtEeSM7Yv7HFAJKYXblV4kY8z8rjn1yC8CUO4trywkcph/KHL6R79pZNGVjjtitQ2IdNJ5NEuvX2RwW2p8TB/sxs432T7igDovqJSf1+JS6suR06an5b9uyiw6KuRcx1lxqDYfZRyJctnHFpFK6YQ34w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVJpGbxVQkuuaZ+x6cTEi0YBSzCT61U1q5UH0BbaCKI=;
 b=X4AlaI0Fs242nx4iwiFSASXSpIaRxTH8a8NONY3OmvDM07lVQMEs/l3xKza0z7IBtmQdjAgTCUyak/dFrwDAFnbDUiI2wRCEvS4Ue8mJzwvUmV4Wf+tudF3qMcfSyqmUZXvLKjF35xvYNztxO31DGkOozF/7EJvrxk3aOom5FeSBXOh/NCh4IqHhRVDp5xBppCm694vlmwzwSQVyhDtRxlgsfsTmZYZqQAu1u7Lr7PmmDYAfLAy+pWv7mD7juhZC3mKMkL896RKzIgGRnt2J1TAKNsA6PKaiRPikVXPyyfeYXZCLpb7E5e/QBhdE97qSZ7bo1L6jnLFLQ+T8eWhfZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVJpGbxVQkuuaZ+x6cTEi0YBSzCT61U1q5UH0BbaCKI=;
 b=zgrMskAivWFM1cEeXC4GA0S84zxtkuErMwUXomNH6WQLitOuP/kzqD0K9pc/Cz0QVAhsAdp9/9dYGqZgX9LZ5zQckJx30DTf52l/oe7Gcc2lbb/xsntcK5wS7LH/Q/dsnPXkMRwswXS90wvY3Ej9L3oLitld/QmEP2dlsJ6reDs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3785.namprd12.prod.outlook.com (2603:10b6:5:1cd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.28; Fri, 13 Nov
 2020 16:51:51 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e%7]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 16:51:51 +0000
Subject: Re: [RFC PATCH 1/1] drm/amdgpu: fix usable gart size calculation
To: christian.koenig@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20201113161740.20685-1-nirmoy.das@amd.com>
 <46bfa315-227c-47c2-d950-47a9a866b070@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <5b429baf-39a3-da9b-b5ed-06e5d6d51f2f@amd.com>
Date: Fri, 13 Nov 2020 17:51:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <46bfa315-227c-47c2-d950-47a9a866b070@gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR16CA0024.namprd16.prod.outlook.com
 (2603:10b6:404:f5::34) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.6.241] (165.204.84.11) by
 BN6PR16CA0024.namprd16.prod.outlook.com (2603:10b6:404:f5::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.25 via Frontend Transport; Fri, 13 Nov 2020 16:51:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 95e3512a-e64d-47f6-3208-08d887f46b1c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3785:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3785BB31132B72F7E868F24B8BE60@DM6PR12MB3785.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CecBWM3kU4CLFGLvWL7bj5ZPHVFj/gPSbAkuRU2wa58722cB1Eh16NVSSbaSNG8+qcoPGo0CaMXTrLvPOGLfgf4BoFraxLw/yC07oB4wCPvSI0//B/dV1VkjdGwBj0cvI1Vd2CEynbLYC6yNq9HqfhKW54i7GINPGNq5g5ML2fYagIpcDDiogXYt/+Yq9OmrA9rsN2W6U4V8Mha5oRUjS2F+Bo2lyMy0FlYCrv9tbPLj93CWvymw9+ez9V1CaZ9HNILWXfaToygqkeULBK+QYumMJvLeFpG8XZFhcIc/ds5h5Qt5JwV1w2doHrw44YYC2xFhxboJgJNeuUasBqfgIK4R8G0rXz77a6AUoNej0JdU/i+CozZd77Ak6d4K//f+9ITLwy86IFh+iUWw9TE6zWRuDm2gmRBJC6Vx01Pvvc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(31686004)(186003)(26005)(478600001)(45080400002)(8936002)(956004)(6486002)(66476007)(31696002)(16526019)(2616005)(6666004)(8676002)(66556008)(5660300002)(53546011)(66946007)(2906002)(16576012)(4326008)(52116002)(966005)(83380400001)(36756003)(316002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: bB1oALzV/xH2OrsNh0eAKLBokJRStxDeyfHWmmVXkimXE/aXNhKmKkLqcfs4h9kgfMNht7n1+eYDOIlb9MvEKnh9dX+i7mw8qOplMzn/LI3x1eZyjMoXBXvqdiEhyPx4gJMGO74Kq5gicz83eLQzeErzhddzw1LKBc58BOAPzryMTXNSVaXijWoEbFhQ4cJh827VPNblOZ16tqsy3/Hr4j19zTaXAoo/zENzObSprXKH0jjSSu6Ctl7GyAFItAjKCpu4sQgFgqL0TGAQMdghqO6r3ZVlvY3KzPMR+/cWI7r8rUpjsDfo02/dkSpObnFoa+vCCGQj6qwpSw91h0LIcgPQ59pZP7SsrnwJRUeitDQMb0F9o5yqfLK0+mDXxLV0Hlg9Gtb6OOmDRa0QcT1m5gLSmy1GtOTyt6/wvJLYZRkzH1v2PAnEW08Z1C4n6sEdqL9mUuh5pOB4mLUkd8jYg1ZDKanLDuc61dbqxE7L8jB7vJp7W7MtmfVIC8Z+EtxxC7HTpnZJR3K0EveNrx63GeCHyfpPzn8ePgXnnI+IMaUHLFve6E2lZ7KPsEDe8LbWjdGIJuwo/7OMrEanNZ0qZVzxJFijJ4DVpscICdsUTkz34oDeOHWEhzlB4VaGv5ZPxNIxbuSJucy+o36tkUUX6uhY6nDap/nNJA13CHpaHUZ6134YF8gMhT26os1X04ruja/j7zE4A2iNpReIBv+w+A5jBdHkLSDlLAHm8QoyDpePocd3qYnAbUtwwNSBaOKsHMoOtSmtAUTNqJdP2d9VKLwRqNgQfsQiE/ON33rsAuVe6qzmOdjMv5K37qmi16/qOMaTnytuFn6c+5oiIltXyVHII+vQPslecjdnJhrYZVdWFaN4WvIuBgLioLWVFFyhjAOFUG26HJWI6jQ+H6d6xg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e3512a-e64d-47f6-3208-08d887f46b1c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 16:51:51.3953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1BIOWtzb3fBEMAPnHzDxTj9uLq3G0fekCCBzOELAfa6FFEoypOex3pyy1FDbTGhHWQTcjSHpyZgwbuD1XTbpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3785
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

Ck9uIDExLzEzLzIwIDU6MjEgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTMuMTEu
MjAgdW0gMTc6MTcgc2NocmllYiBOaXJtb3kgRGFzOgo+PiBhbWRncHVfZG9fdGVzdF9tb3Zlcygp
IGlzIGZhaWxpbmcgYmVjYXVzZSBvZiB3cm9uZwo+PiB1c2FibGUgZ2FydCBzaXplIGNhbGN1bGF0
aW9uIGFuZCB0aHJvd2luZzoKPj4KPj4gW2RybTphbWRncHVfZG9fdGVzdF9tb3ZlcyBbYW1kZ3B1
XV0gKkVSUk9SKiAwMDAwMDAwMDIwYmRjOWYzIGJpbmQgZmFpbGVkCj4+Cj4+IFNpZ25lZC1vZmYt
Ynk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KPj4gLS0tCj4+Cj4+IFRoaXMgc3Rp
bGwgZG9lc24ndCB3b3JrLiBBcyBwZXIgbXkgY2FsY3VsYXRpb24gMXN0IDRNQiBvZiBHQVJUIGlz
IG5vdAo+PiBhY2NvdW50ZWQgZm9yIGluIGFkZXYtPmdtYy5nYXJ0X3NpemUgLSAKPj4gYXRvbWlj
NjRfcmVhZCgmYWRldi0+Z2FydF9waW5fc2l6ZSkuCj4KPiBUaGUgbWVtYmVyIGdhcnRfcGluX3Np
emUgc2hvdWxkIHByb2JhYmx5IGJlIHJlbmFtZWQgdG8gZ3R0X3Bpbl9zaXplLCAKPiBidXQgc2lu
Y2UgYSBndHQgcGluIGlzIGFsc28gYXV0b21hdGljYWxseSB2aXNpYmxlIGluIHRoZSBHQVJUIHRo
YXQgCj4gc2hvdWxkIHByb2JhYmx5IGJlIG9rIGZvciBub3cuCj4KPj4gV2hhdCBhbSBJIG1pc3Np
bmcgPwo+Cj4gVGhlIHR3byAyTUIgd2luZG93cyBpbiB0aGUgR0FSVCB3aGljaCBhcmUgdXNlZCBm
b3IgYnVmZmVyIG1vdmVzLgo+Cj4gU2VlIEFNREdQVV9HVFRfTUFYX1RSQU5TRkVSX1NJWkUgYW5k
IEFNREdQVV9HVFRfTlVNX1RSQU5TRkVSX1dJTkRPV1MuCgoKVGhhbmtzLCBJIHNob3VsZCd2ZSBh
c2tlZCBtdWNoIGVhcmxpZXIgOikKCgpOaXJtb3kKCj4KPiBSZWdhcmRzLAo+IENocmlzdGlhbi4K
Pgo+Pgo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdGVzdC5jIHwgMTEg
KystLS0tLS0tLS0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgOSBkZWxl
dGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV90ZXN0LmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Rlc3Qu
Ywo+PiBpbmRleCA2MDQyYjNiODFhNGMuLmQ5ODNjNzI5OTk3ZiAxMDA2NDQKPj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Rlc3QuYwo+PiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdGVzdC5jCj4+IEBAIC00MiwxNiArNDIsOSBAQCBzdGF0
aWMgdm9pZCBhbWRncHVfZG9fdGVzdF9tb3ZlcyhzdHJ1Y3QgCj4+IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpCj4+IMKgwqDCoMKgwqAgc2l6ZSA9IDEwMjQgKiAxMDI0Owo+Pgo+PiDCoMKgwqDCoMKgIC8q
IE51bWJlciBvZiB0ZXN0cyA9Cj4+IC3CoMKgwqDCoCAqIChUb3RhbCBHVFQgLSBJQiBwb29sIC0g
d3JpdGViYWNrIHBhZ2UgLSByaW5nIGJ1ZmZlcnMpIC8gdGVzdCAKPj4gc2l6ZQo+PiArwqDCoMKg
wqAgKiAoVG90YWwgR1RUIC0gZ2FydF9waW5fc2l6ZSkgLyB0ZXN0IHNpemUKPj4gwqDCoMKgwqDC
oMKgICovCj4+IC3CoMKgwqAgbiA9IGFkZXYtPmdtYy5nYXJ0X3NpemUgLSBBTURHUFVfSUJfUE9P
TF9TSVpFOwo+PiAtwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBBTURHUFVfTUFYX1JJTkdTOyArK2kp
Cj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAoYWRldi0+cmluZ3NbaV0pCj4+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIG4gLT0gYWRldi0+cmluZ3NbaV0tPnJpbmdfc2l6ZTsKPj4gLcKgwqDCoCBpZiAo
YWRldi0+d2Iud2Jfb2JqKQo+PiAtwqDCoMKgwqDCoMKgwqAgbiAtPSBBTURHUFVfR1BVX1BBR0Vf
U0laRTsKPj4gLcKgwqDCoCBpZiAoYWRldi0+aXJxLmloLnJpbmdfb2JqKQo+PiAtwqDCoMKgwqDC
oMKgwqAgbiAtPSBhZGV2LT5pcnEuaWgucmluZ19zaXplOwo+PiArwqDCoMKgIG4gPSBhZGV2LT5n
bWMuZ2FydF9zaXplIC0gYXRvbWljNjRfcmVhZCgmYWRldi0+Z2FydF9waW5fc2l6ZSk7Cj4+IMKg
wqDCoMKgwqAgbiAvPSBzaXplOwo+Pgo+PiDCoMKgwqDCoMKgIGd0dF9vYmogPSBrY2FsbG9jKG4s
IHNpemVvZigqZ3R0X29iaiksIEdGUF9LRVJORUwpOwo+PiAtLSAKPj4gMi4yOS4wCj4+Cj4+IF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+IGFtZC1nZngg
bWFpbGluZyBsaXN0Cj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+IGh0dHBzOi8v
bmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUy
Rmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1w
O2RhdGE9MDQlN0MwMSU3Q25pcm1veS5kYXMlNDBhbWQuY29tJTdDYzljNjFmY2ZlNWI3NDRiNDk0
YzIwOGQ4ODdmMDQzMGUlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0Mw
JTdDNjM3NDA4ODEzMjcxNjg3ODg4JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0
d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3
QzMwMDAmYW1wO3NkYXRhPW85dzRhS2lITkFadmtjV1BIVGlaUVpDNW5yT1lkanM3VHFNcFozZDhB
SjAlM0QmYW1wO3Jlc2VydmVkPTAgCj4+Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
