Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5397DC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 10:28:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB9220658
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 10:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fPMSvs4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB9220658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7DEF6E931;
	Thu, 20 Aug 2020 10:27:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 400826E931
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 10:27:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2Dm9N+moKowAPrDai+tPblxXcAt3NKxGYjR3lugIFXuI4K9hgbHxNhinKLgV33v6dCCKwIBJrY2m1JFlj3ZcB+HHKxRbJp4kU7JBCHFYsqISkCipTNhcS5KsAoH+tVJyo0nOjlDJ0ENLiRr6h9dKd2bCdSxWPt//XqLJFTdg6y5zW4cfvj8OdsjKnW2zAdFfX8yTpimfH9cbt7jtPqMmqWyZwL7S3PPwlSAk3cz1/cgpIyJ7Acff2GjEWt979Rle+UA5TXa60hZznj26gZsXDhcDVJqiEIZXJ0xleDJsEjS8Oe6JHb4dsOgnaMt9DukPb2YPTYil0BIix8E9NLY4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnE6ssyAEq+3TkXhZi2xra5PMJMeVP+C0LlQd2jpOrg=;
 b=Ld2jlXDftfFE2zVGkLQZX0bZXqi8Z6tsfVX27mHja9npYqyorOnK/VewJziQwGSjfCD897qWaT+vjmDDnLBAisDiFcNhjfFfdPRRzLE+f27OK4wZvKmcqUVf1ODAeYPtDC0sak326gKXwH70yZ3u8Xlvgd8CTcXv7MXtwkfEyxYZ48T3OJ3LWfxtDihlgmpfHko8Fn/0MYDat/aVmfBhBqG8VITBiip9Nns8faagrfBGRQSTq/3g9RPnIOKU3KKPRFP/Uldn0mm51kmsHPhGa3qcf8SwM3ei/WY3X0f7X5MT23M6ouz0qp7KUIx5AhzVH+nr5kV6uHzaVHExhJve2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnE6ssyAEq+3TkXhZi2xra5PMJMeVP+C0LlQd2jpOrg=;
 b=fPMSvs4rdJ4zpwx7jHLxHzq1BQKfr1SW/wBGM0u6snaE7wfrYIubRswB6VvtfzCEvdll8e+aAr2FisBGoW/mA09b8oNKe5zciIP2WwWQ1VVSje0NqCvg3Y7wVb2aLIkV9PmKE/kWXwyJeKlA5G6/0sq3lpkAurd6M863qWmxyqA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BY5PR12MB3796.namprd12.prod.outlook.com (2603:10b6:a03:1ae::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Thu, 20 Aug
 2020 10:27:56 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::1852:d129:e9ca:ebd4]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::1852:d129:e9ca:ebd4%5]) with mapi id 15.20.3305.025; Thu, 20 Aug 2020
 10:27:56 +0000
Subject: Re: [PATCH v5] drm/amdgpu: add new trace event for page table update
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200820052705.14468-1-shashank.sharma@amd.com>
 <448fc685-b28f-77e9-4785-c8d9f0e4caba@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
Message-ID: <75445c08-2406-c26e-390e-84a3d30369ce@amd.com>
Date: Thu, 20 Aug 2020 15:57:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
In-Reply-To: <448fc685-b28f-77e9-4785-c8d9f0e4caba@amd.com>
Content-Language: en-US
X-ClientProxiedBy: MAXPR0101CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::21) To BYAPR12MB3126.namprd12.prod.outlook.com
 (2603:10b6:a03:df::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 MAXPR0101CA0059.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Thu, 20 Aug 2020 10:27:55 +0000
X-Originating-IP: [106.51.110.102]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e4af8581-8475-4986-e89d-08d844f3b411
X-MS-TrafficTypeDiagnostic: BY5PR12MB3796:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB379696F1B77205E2360BA375F25A0@BY5PR12MB3796.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +44Wi40ylowmGfKl2PHV6id2Bqgai8d+/vvZsxxkWOkGD6YDP6ebk7fH1/+xkVcoOPuCYLRXwaEF1y2CTnQBwmcMK1xDKR8/g4pi53r3HEoxb+RNzB8O/GQw1umD9Z6JcsCBjKVTwLimIdGPUsOEy7q224GnITb2giCZoZCgvIbUcMHiMX4GsfKNda+/lgI5him7yaAERBDMS6pGqrw+ocGGxe6wgbntaomNdWk7cNSPtpVgFJqkiqAyhOPdAfx7dfpWX8axKef3xYelWLkMLiUa1enjhAAtNfKQoXMbsugC0QvQ5o9Xi95vd3ze4ONHGXKEVtOvpTeuT12WaQNUGmZYN3F3+k07dxrVs3QGfjBxNu+HTdA1bBM+7aRpvcBAL9v43PyXcXkpR5oVaPD8ekl3vd6E4+ZsstQVU5OvV4g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(316002)(15650500001)(83380400001)(52116002)(66574015)(8936002)(186003)(16576012)(66556008)(66476007)(66946007)(110011004)(478600001)(44832011)(5660300002)(4326008)(6666004)(36756003)(2616005)(26005)(53546011)(86362001)(6486002)(956004)(31686004)(31696002)(55236004)(8676002)(2906002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: euCTO6I4UR+K17sq6DvAQPj/202ulGlcVzVmhiOKcMP723DRsCkrnH1tVSG17NJJyhEGjU+aaMuEeDYdE7QwqGu/YeyTSU63oVuQyhx+8r+e22weQZBTr+o6kwkwKhSgYJRngwRprixqFO3VH3Uxp5XNpwOee1kS5eH4Mt+On2Zm0o2ixTMXk/ScOYn+9dlItkoYnBJR4fotrJ49kpeifGr8sy8iZMaU/UkoDggdssDGUc9Z8niDpT4DquEG4PjPxc9Lg69YhPAEOHi+ylX4sTESMKRCwWYvjrQb0sxoqchOvqMUmkpzC7S/YMLBa2oTxcXjQCZVvELZgDvUwacbdMfr6y4AB3pwGlCfuUQdTNV4lO9Iz9N/lVN/iKW1rfE/aMbZX9W769rDXsOPH9Q9c9q9bPhh2M0UFCJKY/muz9g8cOB1fUAAEpNOLMBqZ3uf2QN09WVSEWphWWumdwl6OMoqCeQ2wZbpa0PP3q/nRfKXAo2jNklmW8esk7WvkujkmdoL9RcAFevwa1yGFRldqBn/jHfsKCEG5SxjEYlB7VFHYRhHUDimBb3dFnNSYzzVzUlzimQd6mpqGAxhk74XDim5W2fujLPcNBSmWVv7/nQIk918tqSJAA6Bvi5eMoMmMxtlU0i3MobeHYHGT1+tYg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4af8581-8475-4986-e89d-08d844f3b411
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 10:27:56.4517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nwZ2Vx3yC0VsuIs/7z+BTEM/9rvKoPmf8C/eLjGHhLTVungYpOWmjVcLl09MWbzVtrVBGxeuqtg4CvvRGGFb3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3796
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDIwLzA4LzIwIDI6MjggcG0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMjAuMDgu
MjAgdW0gMDc6Mjcgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4+IFRoaXMgcGF0Y2ggYWRkcyBh
IG5ldyB0cmFjZSBldmVudCB0byB0cmFjayB0aGUgUFRFIHVwZGF0ZQo+PiBldmVudHMuIFRoaXMg
c3BlY2lmaWMgZXZlbnQgd2lsbCBwcm92aWRlIGluZm9ybWF0aW9uIGxpa2U6Cj4+IC0gc3RhcnQg
YW5kIGVuZCBvZiB2aXJ0dWFsIG1lbW9yeSBtYXBwaW5nCj4+IC0gSFcgZW5naW5lIGZsYWdzIGZv
ciB0aGUgbWFwCj4+IC0gcGh5c2ljYWwgYWRkcmVzcyBmb3IgbWFwcGluZwo+Pgo+PiBUaGlzIHdp
bGwgYmUgcGFydGljdWxhcmx5IHVzZWZ1bCBmb3IgbWVtb3J5IHByb2ZpbGluZyB0b29scwo+PiAo
bGlrZSBSTVYpIHdoaWNoIGFyZSBtb25pdG9yaW5nIHRoZSBwYWdlIHRhYmxlIHVwZGF0ZSBldmVu
dHMuCj4+Cj4+IFYyOiBBZGRlZCBwaHlzaWNhbCBhZGRyZXNzIGxvb2t1cCBsb2dpYyBpbiB0cmFj
ZSBwb2ludAo+PiBWMzogc3dpdGNoIHRvIHVzZSBfX2R5bmFtaWNfYXJyYXkKPj4gICAgICBhZGRl
ZCBucHRlcyBpbnQgdGhlIFRQcHJpbnQgYXJndW1lbnRzIGxpc3QKPj4gICAgICBhZGRlZCBwYWdl
IHNpemUgaW4gdGhlIGFyZyBsaXN0Cj4+IFY0OiBBZGRyZXNzZWQgQ2hyaXN0aWFuJ3MgcmV2aWV3
IGNvbW1lbnRzCj4+ICAgICAgYWRkIHN0YXJ0L2VuZCBpbnN0ZWFkIG9mIHNlZwo+PiAgICAgIHVz
ZSBpbmNyIGluc3RlYWQgb2YgcGFnZV9zeiB0byBiZSBhY2N1cmF0ZQo+PiBWNTogQWRkcmVzc2Vk
IENocmlzdGlhbidzIHJldmlldyBjb21tZW50czoKPj4gICAgICBhZGQgcGlkIGFuZCB2bSBjb250
ZXh0IGluZm9ybWF0aW9uIGluIHRoZSBldmVudAo+Pgo+PiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+PiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IFNoYXNoYW5rIFNoYXJtYSA8
c2hhc2hhbmsuc2hhcm1hQGFtZC5jb20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV90cmFjZS5oIHwgNDMgKysrKysrKysrKysrKysrKysrKysrKysKPj4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyAgICB8IDExICsrKystLQo+PiAg
IDIgZmlsZXMgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmgKPj4gaW5kZXggNjNlNzM0
YTEyNWZiLi4wMjQwNmZjNmRiMGYgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV90cmFjZS5oCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV90cmFjZS5oCj4+IEBAIC0zMjEsNiArMzIxLDQ5IEBAIERFRklORV9FVkVOVChhbWRn
cHVfdm1fbWFwcGluZywgYW1kZ3B1X3ZtX2JvX2NzLAo+PiAgIAkgICAgVFBfQVJHUyhtYXBwaW5n
KQo+PiAgICk7Cj4+ICAgCj4+ICtUUkFDRV9FVkVOVChhbWRncHVfdm1fdXBkYXRlX3B0ZXMsCj4+
ICsJICAgIFRQX1BST1RPKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcCwKPj4gKwkJ
ICAgICB1aW50NjRfdCBzdGFydCwgdWludDY0X3QgZW5kLAo+PiArCQkgICAgIHVuc2lnbmVkIGlu
dCBucHRlcywgdWludDY0X3QgZHN0LAo+PiArCQkgICAgIHVpbnQ2NF90IGluY3IsIHVpbnQ2NF90
IGZsYWdzLAo+PiArCQkgICAgIHVpbnQ2NF90IHBpZCwgdWludDY0X3Qgdm1fY3R4KSwKPj4gKwlU
UF9BUkdTKHAsIHN0YXJ0LCBlbmQsIG5wdGVzLCBkc3QsIGluY3IsIGZsYWdzLCBwaWQsIHZtX2N0
eCksCj4+ICsJVFBfU1RSVUNUX19lbnRyeSgKPj4gKwkJCSBfX2ZpZWxkKHU2NCwgc3RhcnQpCj4+
ICsJCQkgX19maWVsZCh1NjQsIGVuZCkKPj4gKwkJCSBfX2ZpZWxkKHU2NCwgZmxhZ3MpCj4+ICsJ
CQkgX19maWVsZCh1bnNpZ25lZCBpbnQsIG5wdGVzKQo+PiArCQkJIF9fZmllbGQodTY0LCBpbmNy
KQo+PiArCQkJIF9fZmllbGQodTY0LCBwaWQpCj4gUGxlYXNlIHVzZSBwaWRfdCBmb3IgdGhlIHBp
ZCBoZXJlLgpnb3QgaXQsCj4+ICsJCQkgX19maWVsZCh1NjQsIHZtX2N0eCkKPj4gKwkJCSBfX2R5
bmFtaWNfYXJyYXkodTY0LCBkc3QsIG5wdGVzKQo+PiArCSksCj4+ICsKPj4gKwlUUF9mYXN0X2Fz
c2lnbigKPj4gKwkJCXVuc2lnbmVkIGludCBpOwo+PiArCj4+ICsJCQlfX2VudHJ5LT5zdGFydCA9
IHN0YXJ0Owo+PiArCQkJX19lbnRyeS0+ZW5kID0gZW5kOwo+PiArCQkJX19lbnRyeS0+ZmxhZ3Mg
PSBmbGFnczsKPj4gKwkJCV9fZW50cnktPmluY3IgPSBpbmNyOwo+PiArCQkJX19lbnRyeS0+bnB0
ZXMgPSBucHRlczsKPj4gKwkJCV9fZW50cnktPnBpZCA9IHBpZDsKPj4gKwkJCV9fZW50cnktPnZt
X2N0eCA9IHZtX2N0eDsKPj4gKwkJCWZvciAoaSA9IDA7IGkgPCBucHRlczsgKytpKSB7Cj4+ICsJ
CQkJdTY0IGFkZHIgPSBwLT5wYWdlc19hZGRyID8gYW1kZ3B1X3ZtX21hcF9nYXJ0KAo+PiArCQkJ
CQlwLT5wYWdlc19hZGRyLCBkc3QpIDogZHN0Owo+PiArCj4+ICsJCQkJKCh1NjQgKilfX2dldF9k
eW5hbWljX2FycmF5KGRzdCkpW2ldID0gYWRkcjsKPj4gKwkJCQlkc3QgKz0gaW5jcjsKPj4gKwkJ
CX0KPj4gKwkpLAo+PiArCVRQX3ByaW50aygic3RhcnQ6MHglMDEwbGx4IGVuZDoweCUwMTBsbHgs
IGZsYWdzOjB4JWxseCwgaW5jcjolbGx1LCIKPj4gKwkJICAiIHBpZDolbGxkIHZtX2N0eDoweCVs
bHggZHN0OlxuJXMiLCBfX2VudHJ5LT5zdGFydCwKPiBJIHdvdWxkIHJlb3JkZXIgdGhpcyB0byAi
cGlkLCB2bV9jdHgsIHN0YXJ0LCBlbmQsIGZsYWdzLCBpbmNyLCBkc3QiLiBBbmQgCj4gYmV0dGVy
IHVzZSAldSBmb3IgdGhlIHBpZC4KPgo+IEFwYXJ0IGZyb20gdGhhdCB0aGlzIGxvb2tzIGdvb2Qg
dG8gbWUuCj4KVGhhbmtzLCB3aWxsIHJlLWFycmFuZ2UgdGhpcy4KCi0gU2hhc2hhbmsKCj4gQ2hy
aXN0aWFuLgo+Cj4+ICsJCSAgX19lbnRyeS0+ZW5kLCBfX2VudHJ5LT5mbGFncywgX19lbnRyeS0+
aW5jciwgX19lbnRyeS0+cGlkLAo+PiArCQkgIF9fZW50cnktPnZtX2N0eCwgX19wcmludF9hcnJh
eShfX2dldF9keW5hbWljX2FycmF5KGRzdCksCj4+ICsJCSAgX19lbnRyeS0+bnB0ZXMsIDgpKQo+
PiArKTsKPj4gKwo+PiAgIFRSQUNFX0VWRU5UKGFtZGdwdV92bV9zZXRfcHRlcywKPj4gICAJICAg
IFRQX1BST1RPKHVpbnQ2NF90IHBlLCB1aW50NjRfdCBhZGRyLCB1bnNpZ25lZCBjb3VudCwKPj4g
ICAJCSAgICAgdWludDMyX3QgaW5jciwgdWludDY0X3QgZmxhZ3MsIGJvb2wgZGlyZWN0KSwKPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4gaW5kZXggOGJjMjI1MzkzOWJl
Li4zZDI1NzM5YjQxNTggMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bS5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5jCj4+IEBAIC0xNTExLDE5ICsxNTExLDI2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX3VwZGF0
ZV9wdGVzKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcGFyYW1zLAo+PiAgIAkJZW50
cnlfZW5kID0gbWluKGVudHJ5X2VuZCwgZW5kKTsKPj4gICAKPj4gICAJCWRvIHsKPj4gKwkJCXN0
cnVjdCBhbWRncHVfdm0gKnZtID0gcGFyYW1zLT52bTsKPj4gICAJCQl1aW50NjRfdCB1cGRfZW5k
ID0gbWluKGVudHJ5X2VuZCwgZnJhZ19lbmQpOwo+PiAgIAkJCXVuc2lnbmVkIG5wdGVzID0gKHVw
ZF9lbmQgLSBmcmFnX3N0YXJ0KSA+PiBzaGlmdDsKPj4gKwkJCXVpbnQ2NF90IHVwZF9mbGFncyA9
IGZsYWdzIHwgQU1ER1BVX1BURV9GUkFHKGZyYWcpOwo+PiAgIAo+PiAgIAkJCS8qIFRoaXMgY2Fu
IGhhcHBlbiB3aGVuIHdlIHNldCBoaWdoZXIgbGV2ZWwgUERzIHRvCj4+ICAgCQkJICogc2lsZW50
IHRvIHN0b3AgZmF1bHQgZmxvb2RzLgo+PiAgIAkJCSAqLwo+PiAgIAkJCW5wdGVzID0gbWF4KG5w
dGVzLCAxdSk7Cj4+ICsKPj4gKwkJCXRyYWNlX2FtZGdwdV92bV91cGRhdGVfcHRlcyhwYXJhbXMs
IGZyYWdfc3RhcnQsIHVwZF9lbmQsCj4+ICsJCQkJCQkgICAgbnB0ZXMsIGRzdCwgaW5jciwgdXBk
X2ZsYWdzLAo+PiArCQkJCQkJICAgIHZtLT50YXNrX2luZm8ucGlkLAo+PiArCQkJCQkJICAgIHZt
LT5pbW1lZGlhdGUuZmVuY2VfY29udGV4dCk7Cj4+ICAgCQkJYW1kZ3B1X3ZtX3VwZGF0ZV9mbGFn
cyhwYXJhbXMsIHB0LCBjdXJzb3IubGV2ZWwsCj4+ICAgCQkJCQkgICAgICAgcGVfc3RhcnQsIGRz
dCwgbnB0ZXMsIGluY3IsCj4+IC0JCQkJCSAgICAgICBmbGFncyB8IEFNREdQVV9QVEVfRlJBRyhm
cmFnKSk7Cj4+ICsJCQkJCSAgICAgICB1cGRfZmxhZ3MpOwo+PiAgIAo+PiAgIAkJCXBlX3N0YXJ0
ICs9IG5wdGVzICogODsKPj4gLQkJCWRzdCArPSAodWludDY0X3QpbnB0ZXMgKiBBTURHUFVfR1BV
X1BBR0VfU0laRSA8PCBzaGlmdDsKPj4gKwkJCWRzdCArPSBucHRlcyAqIGluY3I7Cj4+ICAgCj4+
ICAgCQkJZnJhZ19zdGFydCA9IHVwZF9lbmQ7Cj4+ICAgCQkJaWYgKGZyYWdfc3RhcnQgPj0gZnJh
Z19lbmQpIHsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
