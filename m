Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC398C2D0CE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 20:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A98B24125
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 20:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="shy4SefW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A98B24125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36EA66E24E;
	Tue, 21 Jan 2020 20:30:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F22096EE89
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 20:30:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LF5rZr9wbdZiGPXp2ckld2mbfzeGtvI5e1ycrh0BVe3mRM25OCKCgGM63JxmV/WWYqb2ZpDX3iVhky/TyDTSJclfzYAnkW0BzkXU/XVzz+1DqTED03UpJm9snFxJUQzzytWuWG7GLmY1GsSyLIR+aEbHv9k9V92bkcNU6GMGob4CNWOy6/FNsa7067D4G0gi7NqgaR7tNUnKpuA78MLe9t9nAs5Ku79ZR1G0c149zkxV4TJzgrL3vgbIr5PBBNq3OaAv2kRTKuXK95oOuq7z7vChc0hnxlHIKCDLSSgMUbHuVSuIwgUPj7guqPAMqBRTUXhiWRq52rBfFmvHTrGcbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziyS4rlub3rVZJRS8D242644qcQtjxmiCTTtaNYfWx4=;
 b=NhIOJhlK/Bhv4iJH5mxUVrGUMdtaU438nqm3kMWqBETONH5z/EpSk3z6zIQoB8r1mbUgEgDemCryj6lJf3Wa1dPZ5HCPiJpbyE+QA5p3CDERmh2XM2TwaSUVQJM2nP6CV7q47qoxxOQFOWOeu67IGoTOIe/jNDa+/+hvlgZb8XCKPmom65uzh8m0OuOxWaBDujHdCBDGHXPJgQBCxIQrNtXeZ2IBT2wT1cIBkMsMhRwDWhnJxZHdQCsOkgF8LWy5B2EFI6w2HYnYLxtBOLGtwIhxjVbn88VFlgNPzjTXmhYtRtvHLj5xL3eEu9kzydKc3ffmuhNrMrxlIrEV09hPuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziyS4rlub3rVZJRS8D242644qcQtjxmiCTTtaNYfWx4=;
 b=shy4SefWfI3pTOl55GS0cJs5JpbMQ2XXQJraNM4BYOsC+eOdrWN+VfXDSk24H2/bX3sLkfaXfxRPVgGAx2A//aC7d7caa3Mb3OA7Hp6V1UB19ph7mYvcF8jh1snFJv66Cc+UKkdnxGnwVOgqVWE67QFZ63HofUh6Ev8ZZzeFGII=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (10.255.174.32) by
 DM6PR12MB3209.namprd12.prod.outlook.com (20.179.105.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Tue, 21 Jan 2020 20:30:08 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 20:30:08 +0000
Subject: Re: [PATCH 4/4] drm/amdgpu/vcn: use inst_idx relacing inst
To: James Zhu <jamesz@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1579623556-30941-1-git-send-email-James.Zhu@amd.com>
 <1579623556-30941-4-git-send-email-James.Zhu@amd.com>
 <67ae3044-0701-1e76-e5ef-683222b4f458@amd.com>
 <cd7c56b2-6c0a-a594-1970-ce9849c7c17d@amd.com>
From: Leo Liu <leo.liu@amd.com>
Organization: AMD
Message-ID: <18b47160-2b45-b313-42be-a35dc88fa68f@amd.com>
Date: Tue, 21 Jan 2020 15:30:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <cd7c56b2-6c0a-a594-1970-ce9849c7c17d@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::30) To DM6PR12MB3914.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::32)
MIME-Version: 1.0
Received: from [172.27.228.95] (165.204.55.251) by
 YTBPR01CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19 via Frontend Transport; Tue, 21 Jan 2020 20:30:08 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 29c5ff50-f299-42e8-fcab-08d79eb0b517
X-MS-TrafficTypeDiagnostic: DM6PR12MB3209:|DM6PR12MB3209:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3209ACF1A3F134817D5F039EE50D0@DM6PR12MB3209.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(189003)(199004)(6486002)(53546011)(5660300002)(478600001)(36916002)(8936002)(52116002)(81166006)(81156014)(8676002)(2616005)(44832011)(66946007)(956004)(66476007)(66556008)(2906002)(16576012)(31686004)(36756003)(26005)(316002)(110136005)(86362001)(31696002)(16526019)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3209;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f3wKaFqNsDs7Y/pieJxWjfnZ4mb6M9boPnyhsjWxl4dalIRRtrjl32F1U7ZVnuI/wBL2vEdR+FahgHWuYRcJN6sIEU7Rf/UmFfhkBL3xUtWSqweZKKdH2SS8vhZ8k6Oxlpp7B9KGRooH8K6kVYroJfrGLEoAAqOb/lt6FQBj+QwnUAo7P8NLRaFxRO9aqJP+caO/0GgBcv/jyMuXqUiFhsKlz4nXdgx2vek+1mdZntCckjZssjIeo1wjpii4uz30/3LMqcKYLzQuih/NdPZd0Dukhp5SO1lZiyvsYzi6Cvq8IN2d4Wm7CU4ThOPXzGF5uSwi/7MVYftQ2dP8IAcsnG5TOKvoSr+XNerHn/rDu/pKzQ+j/rjMJTtrH1ubVcSddVkz5xXEEyS44eEBm0ACUbIM12EPL733430GKPB/et64oJGmsRMYWF5GVFy4rPJq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c5ff50-f299-42e8-fcab-08d79eb0b517
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 20:30:08.7764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 990uIoggeoDe2VaTufvoIHvjmY/RmkiqOzAqvRov1VWjinmG5dOqqec3TiYvMBKB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3209
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

Ck9uIDIwMjAtMDEtMjEgMTI6NTAgcC5tLiwgSmFtZXMgWmh1IHdyb3RlOgo+Cj4gT24gMjAyMC0w
MS0yMSAxMjo0MyBwLm0uLCBMZW8gTGl1IHdyb3RlOgo+Pgo+PiBPbiAyMDIwLTAxLTIxIDExOjE5
IGEubS4sIEphbWVzIFpodSB3cm90ZToKPj4+IFVzZSBpbnN0X2lkeCByZWxhY2luZyBpbnN0IGlu
IFNPQzE1X0RQR19NT0RFIG1hY3JvCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogSmFtZXMgWmh1IDxK
YW1lcy5aaHVAYW1kLmNvbT4KPj4+IC0tLQo+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Zjbi5oIHwgMjIgKysrKysrKysrKystLS0tLS0tLS0tLQo+Pj4gwqAgMSBmaWxl
IGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmggCj4+PiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uaAo+Pj4gaW5kZXggNjBmZTNjNC4u
OThjMTg5MyAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92Y24uaAo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5o
Cj4+PiBAQCAtNjUsMjMgKzY1LDIzIEBACj4+PiDCoCAvKiAxIHNlY29uZCB0aW1lb3V0ICovCj4+
PiDCoCAjZGVmaW5lIFZDTl9JRExFX1RJTUVPVVTCoMKgwqAgbXNlY3NfdG9famlmZmllcygxMDAw
KQo+Pj4gwqAgLSNkZWZpbmUgUlJFRzMyX1NPQzE1X0RQR19NT0RFKGlwLCBpbnN0LCByZWcsIG1h
c2ssIAo+Pj4gc3JhbV9zZWwpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+Pj4g
LcKgwqDCoCAoe8KgwqDCoCBXUkVHMzJfU09DMTUoaXAsIGluc3QsIG1tVVZEX0RQR19MTUFfTUFT
SywgCj4+PiBtYXNrKTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+Pj4gLcKgwqDCoMKgwqDC
oMKgIFdSRUczMl9TT0MxNShpcCwgaW5zdCwgbW1VVkRfRFBHX0xNQV9DVEwswqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+Pj4gKyNkZWZpbmUgUlJFRzMyX1NPQzE1X0RQR19NT0RF
KGlwLCBpbnN0X2lkeCwgcmVnLCBtYXNrLCAKPj4+IHNyYW1fc2VsKcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBcCj4+PiArwqDCoMKgICh7wqDCoMKgIFdSRUczMl9TT0MxNShpcCwgaW5zdF9pZHgs
IG1tVVZEX0RQR19MTUFfTUFTSywgCj4+PiBtYXNrKTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
XAo+Pj4gK8KgwqDCoMKgwqDCoMKgIFdSRUczMl9TT0MxNShpcCwgaW5zdF9pZHgsIAo+Pj4gbW1V
VkRfRFBHX0xNQV9DVEwswqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+Pgo+PiBJ
IGhhdmUgb25seSBzZWVuIHlvdSBhcmUgdXNpbmcgaW5zdF9pZHggdG8gcmVwbGFjZSBpbnN0LCBo
YXZuJ3QgeW91PyAKPj4gdGhpcyBpcyBub3QgbmVjZXNzYXJ5LCBiZWNhdXNlIHdlIGFyZSB1c2lu
ZyBpbnN0IGFzIHRoZSBpZHguCj4KPiBTaW5jZSB3ZSB1c2UgaW5zdCBmb3IgaW5zdGFuY2UgaW4g
c3RydWN0IGFtZGdwdV92Y24uIFRvIGF2b2lkIAo+IGNvbmZ1c2luZywgSSBjcmVhdGUgdGhpcyBw
YXRjaCwKCklmIG9ubHkgdmFyaWFibGUgbmFtZSBjaGFuZ2VzLCBwbGVhc2UgZHJvcCB0aGVzZSBw
YXRjaCwgd2UgYXJlIHVzaW5nIAppbnN0IGFsbCB0aGUgcGxhY2VzLgoKTGVvCgoKCgo+Cj4gSmFt
ZXMKPgo+Pgo+PiBMZW8KPj4KPj4KPj4KPj4+IFVWRF9EUEdfTE1BX0NUTF9fTUFTS19FTl9NQVNL
IHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+PiAtICgoYWRldi0+cmVnX29m
ZnNldFtpcCMjX0hXSVBdW2luc3RdW3JlZyMjX0JBU0VfSURYXSArIHJlZynCoMKgwqDCoCBcCj4+
PiArICgoYWRldi0+cmVnX29mZnNldFtpcCMjX0hXSVBdW2luc3RfaWR4XVtyZWcjI19CQVNFX0lE
WF0gKyByZWcpwqDCoMKgwqAgXAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPDwgVVZE
X0RQR19MTUFfQ1RMX19SRUFEX1dSSVRFX0FERFJfX1NISUZUKSAKPj4+IHzCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgXAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHNyYW1fc2VsIDw8
IAo+Pj4gVVZEX0RQR19MTUFfQ1RMX19TUkFNX1NFTF9fU0hJRlQpKTvCoMKgwqDCoMKgwqDCoMKg
IFwKPj4+IC3CoMKgwqDCoMKgwqDCoCBSUkVHMzJfU09DMTUoaXAsIGluc3QsIG1tVVZEX0RQR19M
TUFfREFUQSk7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+Pj4gK8KgwqDCoMKg
wqDCoMKgIFJSRUczMl9TT0MxNShpcCwgaW5zdF9pZHgsIG1tVVZEX0RQR19MTUFfREFUQSk7wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4+IMKgwqDCoMKgwqAgfSkKPj4+IMKgIC0jZGVmaW5l
IFdSRUczMl9TT0MxNV9EUEdfTU9ERShpcCwgaW5zdCwgcmVnLCB2YWx1ZSwgbWFzaywgCj4+PiBz
cmFtX3NlbCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+Pj4gKyNkZWZpbmUgV1JFRzMyX1NP
QzE1X0RQR19NT0RFKGlwLCBpbnN0X2lkeCwgcmVnLCB2YWx1ZSwgbWFzaywgCj4+PiBzcmFtX3Nl
bCnCoMKgwqDCoMKgwqDCoMKgIFwKPj4+IMKgwqDCoMKgwqAgZG8ge8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIFwKPj4+IC3CoMKgwqDCoMKgwqDCoCBXUkVHMzJfU09DMTUoaXAsIGluc3QsIG1tVVZE
X0RQR19MTUFfREFUQSwgCj4+PiB2YWx1ZSk7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4+
IC3CoMKgwqDCoMKgwqDCoCBXUkVHMzJfU09DMTUoaXAsIGluc3QsIG1tVVZEX0RQR19MTUFfTUFT
SywgCj4+PiBtYXNrKTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+Pj4gLcKgwqDCoMKgwqDC
oMKgIFdSRUczMl9TT0MxNShpcCwgaW5zdCwgbW1VVkRfRFBHX0xNQV9DVEwswqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+Pj4gK8KgwqDCoMKgwqDCoMKgIFdSRUczMl9TT0MxNShp
cCwgaW5zdF9pZHgsIG1tVVZEX0RQR19MTUFfREFUQSwgCj4+PiB2YWx1ZSk7wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIFwKPj4+ICvCoMKgwqDCoMKgwqDCoCBXUkVHMzJfU09DMTUoaXAsIGluc3Rf
aWR4LCBtbVVWRF9EUEdfTE1BX01BU0ssIAo+Pj4gbWFzayk7wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFwKPj4+ICvCoMKgwqDCoMKgwqDCoCBXUkVHMzJfU09DMTUoaXAsIGluc3RfaWR4LCAKPj4+
IG1tVVZEX0RQR19MTUFfQ1RMLMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFVWRF9EUEdfTE1BX0NUTF9fUkVBRF9XUklURV9N
QVNLIHwgXAo+Pj4gLSAoKGFkZXYtPnJlZ19vZmZzZXRbaXAjI19IV0lQXVtpbnN0XVtyZWcjI19C
QVNFX0lEWF0gKyByZWcpwqDCoMKgwqAgXAo+Pj4gKyAoKGFkZXYtPnJlZ19vZmZzZXRbaXAjI19I
V0lQXVtpbnN0X2lkeF1bcmVnIyNfQkFTRV9JRFhdICsgcmVnKcKgwqDCoMKgIFwKPj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIDw8IFVWRF9EUEdfTE1BX0NUTF9fUkVBRF9XUklURV9BRERS
X19TSElGVCkgCj4+PiB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIChzcmFtX3NlbCA8PCAKPj4+IFVWRF9EUEdfTE1BX0NUTF9fU1JBTV9T
RUxfX1NISUZUKSk7wqDCoMKgwqDCoMKgwqDCoCBcCj4+PiDCoMKgwqDCoMKgIH0gd2hpbGUgKDAp
Cj4+PiBAQCAtMTExLDcgKzExMSw3IEBACj4+PiDCoCDCoCAjZGVmaW5lIFJSRUczMl9TT0MxNV9E
UEdfTU9ERV8yXzAoaW5zdF9pZHgsIG9mZnNldCwgCj4+PiBtYXNrX2VuKcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+Pj4gwqDCoMKgwqDCoCAoe8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4+IC3CoMKgwqDCoMKgwqDCoCBXUkVHMzJfU09DMTUoVkNO
LCBpbnN0LCAKPj4+IG1tVVZEX0RQR19MTUFfQ1RMLMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgXAo+Pj4gK8KgwqDCoMKgwqDCoMKgIFdSRUczMl9TT0MxNShWQ04sIGlu
c3RfaWR4LCAKPj4+IG1tVVZEX0RQR19MTUFfQ1RMLMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgXAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDB4MCA8PCBV
VkRfRFBHX0xNQV9DVExfX1JFQURfV1JJVEVfX1NISUZUIAo+Pj4gfMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBcCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtYXNrX2VuIDw8
IFVWRF9EUEdfTE1BX0NUTF9fTUFTS19FTl9fU0hJRlQgCj4+PiB8wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIFwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9mZnNldCA8PCAK
Pj4+IFVWRF9EUEdfTE1BX0NUTF9fUkVBRF9XUklURV9BRERSX19TSElGVCkpO8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgXApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
