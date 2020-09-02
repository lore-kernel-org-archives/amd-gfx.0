Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CE9C433E7
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 18:28:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF09207EA
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 18:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RE4y7M9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF09207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A54DC6E4CA;
	Wed,  2 Sep 2020 18:28:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02E666E4CA
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 18:28:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyQlRv9OOArLfYiOVoDv85Pt6+mb54C0GLvc/b3ahLE5CeiWNAcFDfyk+Gap4N4DhKy4jEOP2dppIVqwSlQkMxUEBR6K+wn+DqiQLx5iaMOhsyc1KcZLk4PUV0nOHQilLAvkDTdh+j+vlbywVSAkBEZAUVwVoY4AnzvVq8CxzxwPBJxMmSSzLKL4IY6k4tOGOamGjUZkS5X/swiTBfr5vYiA/aRI+YrEwSVx05W0xcdkKkPk70/2c+/eSyYAkYs/gWd+3joUeQ2ikCAFnz/CRnYQS4yv4OLZ+I9FloTqKt1y2VxD89PgukiqYHP7646zRhSqQqOuWQ4J8oMGRcScuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hlo7989SluV/plKYEDGgBY9KHxG849BapukK8pL2nk=;
 b=YHs/fkqJWsFhYkawQr+Jtz863NDMsh3h1y33AZcniPMoBq6dMXLXSZUd6Hisqz8XCf1ljfHkItGwhsil5DGHUb5WESWCdO/BQ+0+iSrrCPx4t/AqJp+6bpV5TK+yRf9PZSjmHnyDW4MC2Ol2seAYoFrg4pP2BOLRgB7z14oida/mlhFuDQ2nGRO1IAigYklh7Ol03QNLjfahl2RlHSkBzeA83yz4zuwHOJonVuFAXGFl6WPr5uaAjmg5wg659GlAD+96EhXpq+P6z/prRHaOGEqtosanK7d9PuvrMzwsDscKTEU8UiLwl6Rx8mB0LdpbnxapBXpzwcmc3xKbfh1P8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hlo7989SluV/plKYEDGgBY9KHxG849BapukK8pL2nk=;
 b=RE4y7M9jws/DB8Oz49NhkunLhUXRKdrGeVTn8qbzVw2v4pJw2mOUuV608oAnnE/xhD1VUEK5GKErc4g1B7YaHneV2pT+9VPFHbFu+DpM9rE/kf1vm3d9knjeBPGqqsrxYqoYL5jLzpzBefjn6wn4UvF88PBhyBU2yhTJVEP1x3o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2509.namprd12.prod.outlook.com (2603:10b6:802:29::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 18:28:03 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 18:28:03 +0000
Subject: Re: [PATCH] drm/amdgpu: enable ih1 ih2 for Arcturus only
To: Alex Deucher <alexdeucher@gmail.com>, Alex Sierra <alex.sierra@amd.com>
References: <20200902170118.30751-1-alex.sierra@amd.com>
 <CADnq5_NRFr5vYfuwgMHQ5Y+19_UqXPoJYomBkwGMoWkvjpA_Fw@mail.gmail.com>
 <CADnq5_MFC=r=NxhzZ2OmO7EaodZXtGDQxgqw2146DGQoioShwA@mail.gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <2ea7e8e2-8a96-8006-a5ee-41ebfecbf6f1@amd.com>
Date: Wed, 2 Sep 2020 14:28:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CADnq5_MFC=r=NxhzZ2OmO7EaodZXtGDQxgqw2146DGQoioShwA@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::20) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YTXPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Wed, 2 Sep 2020 18:28:03 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 58a07d4f-0798-4596-d97b-08d84f6dedce
X-MS-TrafficTypeDiagnostic: SN1PR12MB2509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2509967112A422C790EED480922F0@SN1PR12MB2509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ViJ1mk3/EMuouUBaIRFTJgE0gzdvHlXRkC+wVr+9t85FA2l8mD9/PXO87umuoEqG27cfGdFuJAc+cA55VreI2oS+/6k3CTvQd0Q2pmljy51g7bHNV4FeEm081zjdyp5ss8BXjxsumyioz59Bsamx0E87ab4Gcm1YH5r7+GEUiQ80Y99Vdm9eQ/M/pwQ/IuZde6rqfVSg4bcxYxNw85MiLCA90I2nGagmzCsF2UG0GF10rLjMI/ybj0Vqmlh4czn86f06GQuy3m8aGkwb1k/IrYul1vcYVI37F0/TvlHKezypF31RLDYRyFJ3xIHoW0/SQHi9tfzy9X4+BjKdCXJRavBEngPaJWB/kghNzk/zExIsG+geML1bA8Seq/uH9dx0f7G9QfW4jUchFY3hs7nrx1hEc4LQorasqt0Z4wXBrR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(44832011)(6636002)(52116002)(956004)(66556008)(2616005)(4326008)(316002)(53546011)(66946007)(66476007)(6486002)(5660300002)(966005)(186003)(83380400001)(26005)(8676002)(31696002)(31686004)(8936002)(36756003)(2906002)(478600001)(16576012)(110136005)(86362001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Nml2VHDShRBXioOzBDKvIrM9ByOH8azBAhFE64SXhsmoj7IoUf0k+FKxEyUmX5d+sGAB913c94v8tZpYayCGItQZL058V6HRKjtiMPTN4phy4WxUDU9mKHSQtcXuGoBhvE0kD44+jFdu/vLAV4bT4s7rufe29CdKHx7W73YqB8EVYG8TIDMK+wCmqtxq+GBAtZvizPceBUmyeolSdHxMk8Wp7KuMIyb3xPOatSLwlgLqIqOn+KqY/hAoA6raMHbLubk4oIxZ1doT+2sXzKvLeWpmlKBIAnBBVXmt4G28FLtNFwhysmrz13U8DhYqmAhG2PhBJGsUTUTEVKNTrQU1JcV4EkRYfURumVuhoMMGicQp0wIs3tMfoXBBpsLORTgC2N/AKL6yFizBcdI3NqB8/29sII1SLTrG8n5Djk3Mw6WEf4ohr1QGermVmHvqDKRI7dKIe5E5wQDwPd+SRFsG35BHrC+kQXANijjEUSLitWP9Y0KgIvj9Xhe8zvhZG9MjAYhJf8mP0pEcLL6xyPmS3K0GxhKh+AHx6BzrAKRETtDWWSxh8OOSLbHUTFZzeui/JrrVn2cOnnMUGWUwxA9jj65BnAW89pNdEKVyWqS3fkl/9BhxOLdNIbXTiuHBH6pI7G83kT10wmeY0mxQr/xwlA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a07d4f-0798-4596-d97b-08d84f6dedce
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 18:28:03.4629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fk5/cEmSH0R08/0bdU6uPZKdUH4eWkR630A69TMsKvd9wlXd4DB22pjM+0X+ql/gl6FJ2ZqKGbZ6g8cFY20BHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2509
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMC0wOS0wMiB1bSAyOjEzIHAubS4gc2NocmllYiBBbGV4IERldWNoZXI6Cj4gT24gV2Vk
LCBTZXAgMiwgMjAyMCBhdCAyOjA4IFBNIEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwu
Y29tPiB3cm90ZToKPj4gT24gV2VkLCBTZXAgMiwgMjAyMCBhdCAxOjAxIFBNIEFsZXggU2llcnJh
IDxhbGV4LnNpZXJyYUBhbWQuY29tPiB3cm90ZToKPj4+IEVuYWJsZSBtdWx0aS1yaW5nIGloMSBh
bmQgaWgyIGZvciBBcmN0dXJ1cyBvbmx5Lgo+Pj4gRm9yIE5hdmkxMCBmYW1pbHkgbXVsdGktcmlu
ZyBoYXMgYmVlbiBkaXNhYmxlZC4KPj4+IEFwcGFyZW50bHksIGhhdmluZyBtdWx0aS1yaW5nIGVu
YWJsZWQgaW4gTmF2aSB3YXMgY2F1c2luZwo+Pj4gY29udGludXMgcGFnZSBmYXVsdCBpbnRlcnJ1
cHRzLgo+Pj4gRnVydGhlciBpbnZlc3RpZ2F0aW9uIGlzIG5lZWRlZCB0byBnZXQgdG8gdGhlIHJv
b3QgY2F1c2UuCj4+PiBSZWxhdGVkIGlzc3VlIGxpbms6Cj4+PiBodHRwczovL2dpdGxhYi5mcmVl
ZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy8xMjc5Cj4+Pgo+PiBCZWZvcmUgY29tbWl0dGlu
ZywgbGV0J3MgdmVyaWZ5IHRoYXQgaXQgZml4ZXMgdGhhdCBpc3N1ZS4KPiBMb29raW5nIGF0IHRo
ZSBidWcgcmVwb3J0LCB0aGUgT1NTIChwcmVzdW1hYmx5IElIKSBibG9jayBpcyBjYXVzaW5nIGEK
PiB3cml0ZSBmYXVsdCBzbyBJIHN1c3BlY3QgYXJjdHVydXMgbWF5IGJlIGFmZmVjdGVkIGJ5IHRo
aXMgYXMgd2VsbC4gIFdlCj4gc2hvdWxkIGRvdWJsZSBjaGVjayB0aGUgcmluZyBzaXplcyBhbmQg
YWxsb2NhdGlvbnMuCgpBbGVqYW5kcm8gaGFzIGJlZW4gZG9pbmcgYSBsb3Qgb2YgdGVzdGluZyBv
biBBcmN0dXJ1cyBhbmQgZGlkbid0IHJ1bgppbnRvIHRoaXMgcHJvYmxlbS4gVGhhdCdzIHdoeSBJ
IHN1Z2dlc3RlZCBvbmx5IGRpc2FibGluZyB0aGUgSUggcmluZ3Mgb24KTmF2aTEwIGZvciBub3cu
IFdlIG5lZWQgdGhlIGV4dHJhIHJpbmdzIG9uIEFyY3R1cnVzIGZvciBvdXIgSE1NIHdvcmsuCgpS
ZWdhcmRzLArCoCBGZWxpeAoKCj4KPiBBbGV4Cj4KPgo+PiBBbGV4Cj4+Cj4+Cj4+PiBTaWduZWQt
b2ZmLWJ5OiBBbGV4IFNpZXJyYSA8YWxleC5zaWVycmFAYW1kLmNvbT4KPj4+IC0tLQo+Pj4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25hdmkxMF9paC5jIHwgMzAgKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0KPj4+ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMTEgZGVs
ZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L25hdmkxMF9paC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2loLmMKPj4+
IGluZGV4IDM1MGYxYmYwNjNjNi4uNGQ3Mzg2OTg3MGFiIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2loLmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L25hdmkxMF9paC5jCj4+PiBAQCAtMzA2LDcgKzMwNiw4IEBAIHN0YXRpYyBp
bnQgbmF2aTEwX2loX2lycV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+Pj4gICAg
ICAgICB9IGVsc2Ugewo+Pj4gICAgICAgICAgICAgICAgIFdSRUczMl9TT0MxNShPU1NTWVMsIDAs
IG1tSUhfUkJfQ05UTCwgaWhfcmJfY250bCk7Cj4+PiAgICAgICAgIH0KPj4+IC0gICAgICAgbmF2
aTEwX2loX3Jlcm91dGVfaWgoYWRldik7Cj4+PiArICAgICAgIGlmIChhZGV2LT5hc2ljX3R5cGUg
PT0gQ0hJUF9BUkNUVVJVUykKPj4+ICsgICAgICAgICAgICAgICBuYXZpMTBfaWhfcmVyb3V0ZV9p
aChhZGV2KTsKPj4+Cj4+PiAgICAgICAgIGlmICh1bmxpa2VseShhZGV2LT5maXJtd2FyZS5sb2Fk
X3R5cGUgPT0gQU1ER1BVX0ZXX0xPQURfRElSRUNUKSkgewo+Pj4gICAgICAgICAgICAgICAgIGlm
IChpaC0+dXNlX2J1c19hZGRyKSB7Cj4+PiBAQCAtNjY4LDE5ICs2NjksMjYgQEAgc3RhdGljIGlu
dCBuYXZpMTBfaWhfc3dfaW5pdCh2b2lkICpoYW5kbGUpCj4+PiAgICAgICAgIGFkZXYtPmlycS5p
aC51c2VfZG9vcmJlbGwgPSB0cnVlOwo+Pj4gICAgICAgICBhZGV2LT5pcnEuaWguZG9vcmJlbGxf
aW5kZXggPSBhZGV2LT5kb29yYmVsbF9pbmRleC5paCA8PCAxOwo+Pj4KPj4+IC0gICAgICAgciA9
IGFtZGdwdV9paF9yaW5nX2luaXQoYWRldiwgJmFkZXYtPmlycS5paDEsIFBBR0VfU0laRSwgdHJ1
ZSk7Cj4+PiAtICAgICAgIGlmIChyKQo+Pj4gLSAgICAgICAgICAgICAgIHJldHVybiByOwo+Pj4g
KyAgICAgICBhZGV2LT5pcnEuaWgxLnJpbmdfc2l6ZSA9IDA7Cj4+PiArICAgICAgIGFkZXYtPmly
cS5paDIucmluZ19zaXplID0gMDsKPj4+Cj4+PiAtICAgICAgIGFkZXYtPmlycS5paDEudXNlX2Rv
b3JiZWxsID0gdHJ1ZTsKPj4+IC0gICAgICAgYWRldi0+aXJxLmloMS5kb29yYmVsbF9pbmRleCA9
IChhZGV2LT5kb29yYmVsbF9pbmRleC5paCArIDEpIDw8IDE7Cj4+PiArICAgICAgIGlmIChhZGV2
LT5hc2ljX3R5cGUgPT0gQ0hJUF9BUkNUVVJVUykgewo+Pj4gKyAgICAgICAgICAgICAgIHIgPSBh
bWRncHVfaWhfcmluZ19pbml0KGFkZXYsICZhZGV2LT5pcnEuaWgxLCBQQUdFX1NJWkUsIHRydWUp
Owo+Pj4gKyAgICAgICAgICAgICAgIGlmIChyKQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIHI7Cj4+Pgo+Pj4gLSAgICAgICByID0gYW1kZ3B1X2loX3JpbmdfaW5pdChhZGV2LCAm
YWRldi0+aXJxLmloMiwgUEFHRV9TSVpFLCB0cnVlKTsKPj4+IC0gICAgICAgaWYgKHIpCj4+PiAt
ICAgICAgICAgICAgICAgcmV0dXJuIHI7Cj4+PiArICAgICAgICAgICAgICAgYWRldi0+aXJxLmlo
MS51c2VfZG9vcmJlbGwgPSB0cnVlOwo+Pj4gKyAgICAgICAgICAgICAgIGFkZXYtPmlycS5paDEu
ZG9vcmJlbGxfaW5kZXggPQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIChhZGV2LT5kb29yYmVsbF9pbmRleC5paCArIDEpIDw8IDE7Cj4+PiArCj4+PiArICAgICAg
ICAgICAgICAgciA9IGFtZGdwdV9paF9yaW5nX2luaXQoYWRldiwgJmFkZXYtPmlycS5paDIsIFBB
R0VfU0laRSwgdHJ1ZSk7Cj4+PiArICAgICAgICAgICAgICAgaWYgKHIpCj4+PiArICAgICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gcjsKPj4+Cj4+PiAtICAgICAgIGFkZXYtPmlycS5paDIudXNl
X2Rvb3JiZWxsID0gdHJ1ZTsKPj4+IC0gICAgICAgYWRldi0+aXJxLmloMi5kb29yYmVsbF9pbmRl
eCA9IChhZGV2LT5kb29yYmVsbF9pbmRleC5paCArIDIpIDw8IDE7Cj4+PiArICAgICAgICAgICAg
ICAgYWRldi0+aXJxLmloMi51c2VfZG9vcmJlbGwgPSB0cnVlOwo+Pj4gKyAgICAgICAgICAgICAg
IGFkZXYtPmlycS5paDIuZG9vcmJlbGxfaW5kZXggPQo+Pj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIChhZGV2LT5kb29yYmVsbF9pbmRleC5paCArIDIpIDw8IDE7Cj4+
PiArICAgICAgIH0KPj4+Cj4+PiAgICAgICAgIHIgPSBhbWRncHVfaXJxX2luaXQoYWRldik7Cj4+
Pgo+Pj4gLS0KPj4+IDIuMTcuMQo+Pj4KPj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCj4+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+Pj4gYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKPj4+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
