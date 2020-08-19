Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1CFC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 11:53:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E5A20888
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 11:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VnJjcQp1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E5A20888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D16486E2E4;
	Wed, 19 Aug 2020 11:53:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB3656E2E4
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 11:53:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDjx2qvGqZNXWsx0v1o2r6qvD9rY4N/ZC+O9QoHPTWv7wn/AbG/CHr9dkgY4F3Bt0aKq0kOwC3eV5hQ2doDD5FkGyv3BL3Q9KXAnI1o/FGpl8i2R/F65BpaEyaE3dCG4GovA2MRP6tVaBjRzj32k8OzQtYu/yBuX0QUg98Azqj0rnqpFCOducScMFPmu4Y7SSYei0Ten4hU+WGPLO5jZ4i79+fAdYWd0FJWn/nNppOZVm7ZUjobmTNd2tTZyDp16OgApQGmcdE+DPVin3xJytDnaYZqSQdxQIDzRdhO77SCBaXXCY95YnFnra20EI2EXWITcSdGXcvFWBPtY85SRXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CD2cN8Zq+RJj0AApgSldZwFfXYbZz33Xs9tKyPRWg5U=;
 b=HUO9dlpHLVbKUUdqZNP+AKtLtoLaC9Qfq4uG+8DHW9tFibWXaPWFoAIaCX5sxW9xCSgEbe2M5iGOjT9zAzGEz7snqI0A6bSI+RfkV/HM9v6yipq4Ua4vRLZ+f4zodAGTritNl0Rvcz6Id5jHl8ykkIYlQqNHLyAXBbdkp8sPm1E3HC2lGdlOrV2axPj+hP4ybQ2XZw8/WtYbzRNpgEMVq9TfaABSCd/x82l3e3DKXXY85gnW0VY6F9JKBcS+gexWibjzPF7lmrEywzfmOmtbOdVPsGVU/KDKBRbISdmuQCFPHpJLy8Kb/ZQjuj9Ecx634utKE/UT2ECoQqG3dR0HoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CD2cN8Zq+RJj0AApgSldZwFfXYbZz33Xs9tKyPRWg5U=;
 b=VnJjcQp1RWkvSIQxqs+By0AiJ27CqZx+3NswfdkXR3uwCwY8MM0f9ZFIitt8A3izDFrASCXIpIbOYbIwQ97GnBlsYQedVv4dx/DRUsgbd6zb4rvmEPqCpP8f7h4u+LI53FeeT7AsA6jIr9YUMHetipt99IKbqQEgwX6rlHXLSTM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BY5PR12MB3971.namprd12.prod.outlook.com (2603:10b6:a03:1a5::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 19 Aug
 2020 11:53:04 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::1852:d129:e9ca:ebd4]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::1852:d129:e9ca:ebd4%5]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 11:53:04 +0000
Subject: Re: [PATCH v4] drm/amdgpu: add new trace event for page table update
 v3
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200813030414.188468-1-shashank.sharma@amd.com>
 <35be9cda-025a-8f45-1648-00b96f57720e@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
Message-ID: <ea572a64-37e4-d3db-f884-59f34bbdce38@amd.com>
Date: Wed, 19 Aug 2020 17:22:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
In-Reply-To: <35be9cda-025a-8f45-1648-00b96f57720e@amd.com>
Content-Language: en-US
X-ClientProxiedBy: MA1PR01CA0149.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::19) To BYAPR12MB3126.namprd12.prod.outlook.com
 (2603:10b6:a03:df::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.113] (106.51.110.102) by
 MA1PR01CA0149.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Wed, 19 Aug 2020 11:53:03 +0000
X-Originating-IP: [106.51.110.102]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 309b60ab-b56e-4a1c-5d01-08d844366e67
X-MS-TrafficTypeDiagnostic: BY5PR12MB3971:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3971774E801C6C953E2F7B00F25D0@BY5PR12MB3971.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0JmbJs1d1SLmGZ6xazD12ukjMnprhfHnJYTAb9DVUlQWeTGHASpSAzGZgR+RNmnLlGGV8CQMA3Zz0c9x87jAPmD2pcyQ51MPCITKldEnCh/BQbvYFgTQNmpjMsxfzXP2VPVDA3BCQs2uZ1yvj8FNBISsi2ZoN5b1hG6Cu3SMQrYHDNRyYyZmxeYei50MKLOKzJL7fqQr5F1dLUzjfOfGiJR3C1lUbCVsSJQZvp9lyc65gjhFrveLy+5PPqTUsuhZt/G12xoJSQKXedr1/2bBXdS4bB9Y3Pau9TChGHn8wfoEzdQnPMqugfTS53dfymqGYVDwe699Jf3drqOaIEXs/7VfRvSGRJAzcVgf7jx5grG116vK1beY1v6r6r6AQYLf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(66476007)(44832011)(66556008)(53546011)(8676002)(2616005)(31696002)(956004)(66946007)(6666004)(1006002)(478600001)(83380400001)(31686004)(6486002)(8936002)(4326008)(66574015)(15650500001)(86362001)(52116002)(26005)(16526019)(186003)(55236004)(2906002)(36756003)(16576012)(316002)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: dOPoAotAunZbksaioVULEg8URApiDCS+30KN8xozMthTWYCsVUlmJAZ0t8Tlnr7tEU1esxEb9u+vq7roFkypEizogp5lNQrDI9K4JPZyHZds1jAIfZhiUXdrfWim6wiBGKcZ/lagEv46vO3UeGSnpHPlZqQC87O7IdjW0hHmgByo0k1EWQZ7rUOtCqzPZpcyns/q2x5GMfWww156AHWoQxFL5mvHmLyj+ncTYNwYogQBzPKSQN4kmTstnFWFYiba7D1G46pt9XWoU+CVaj2yFSCo/gQ0AC+NrJxzS8G+Sj54HqSOFUBcYF2GJAQifC0p/NHnyEfb4zPC9O/mFv4f8PN7GXuOQ5G3Z+5QNm/S8hGZ+29DUPSRsHzObG+t1Sw0clcCdIXbDa2ilSOkepGa26TaC9jPsZ1t9o0Q0p9FhrJ1nnPAn7ZoQm9jJE1+NwCdYiBw7RSDWySKnsR9QJteQitC1a4zFjWGk922AXvlFxTLNDNr60GgB8iky7FoUeLrwymAj8m6WpPC2GZyhPzDI6vNM1G91xaW8IL4o8X4UpEMspcrNzvenCHwCgr8JZKTIKY6d3ruo9m9yyIivG+mmeOHLBR/W8B8+DMP/2lH7kb4G1Q1g7Hc2S/fc3Ee/d0mezsKw+OlSOzRDJJVQINQhg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 309b60ab-b56e-4a1c-5d01-08d844366e67
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 11:53:04.5115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: si4p2yPhdvIEbSpxO8CJoN9GkTrEx4al7yyu2ksM3UqtSeEfA2c3gogk8d0HoMJy+EhZzeNtYhPPP0XpHQxcHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3971
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

Ck9uIDEzLzA4LzIwIDE6MjggcG0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTMuMDgu
MjAgdW0gMDU6MDQgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4+IFRoaXMgcGF0Y2ggYWRkcyBh
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
ZSBpbmNyIGluc3RlYWQgb2YgcGFnZV9zeiB0byBiZSBhY2N1cmF0ZQo+Pgo+PiBDYzogQ2hyaXN0
aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+PiBDYzogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4g
S8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IFNoYXNo
YW5rIFNoYXJtYSA8c2hhc2hhbmsuc2hhcm1hQGFtZC5jb20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oIHwgMzcgKysrKysrKysrKysrKysrKysr
KysrKysKPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyAgICB8ICA5
ICsrKystLQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV90cmFjZS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmgKPj4g
aW5kZXggNjNlNzM0YTEyNWZiLi5kZjEyY2Y4NDY2YzIgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oCj4+IEBAIC0zMjEsNiArMzIxLDQzIEBAIERFRklO
RV9FVkVOVChhbWRncHVfdm1fbWFwcGluZywgYW1kZ3B1X3ZtX2JvX2NzLAo+PiAgIAkgICAgVFBf
QVJHUyhtYXBwaW5nKQo+PiAgICk7Cj4+ICAgCj4+ICtUUkFDRV9FVkVOVChhbWRncHVfdm1fdXBk
YXRlX3B0ZXMsCj4+ICsJICAgIFRQX1BST1RPKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFt
cyAqcCwKPj4gKwkJICAgICB1aW50NjRfdCBzdGFydCwgdWludDY0X3QgZW5kLAo+PiArCQkgICAg
IHVuc2lnbmVkIGludCBucHRlcywgdWludDY0X3QgZHN0LAo+PiArCQkgICAgIHVpbnQ2NF90IGlu
Y3IsIHVpbnQ2NF90IGZsYWdzKSwKPj4gKwlUUF9BUkdTKHAsIHN0YXJ0LCBlbmQsIG5wdGVzLCBk
c3QsIGluY3IsIGZsYWdzKSwKPj4gKwlUUF9TVFJVQ1RfX2VudHJ5KAo+PiArCQkJIF9fZmllbGQo
dTY0LCBzdGFydCkKPj4gKwkJCSBfX2ZpZWxkKHU2NCwgZW5kKQo+PiArCQkJIF9fZmllbGQodTY0
LCBmbGFncykKPj4gKwkJCSBfX2ZpZWxkKHVuc2lnbmVkIGludCwgbnB0ZXMpCj4+ICsJCQkgX19m
aWVsZCh1NjQsIGluY3IpCj4+ICsJCQkgX19keW5hbWljX2FycmF5KHU2NCwgZHN0LCBucHRlcykK
PiBBcyBkaXNjdXNzZWQgd2l0aCB0aGUgdHJhY2Ugc3Vic3lzdGVtIG1haW50YWluZXIgd2UgbmVl
ZCB0byBhZGQgdGhlIHBpZCAKPiBhbmQgcHJvYmFibHkgdGhlIFZNIGNvbnRleHQgSUQgd2UgdXNl
IGhlcmUgdG8gaWRlbnRpZnkgdGhlIHVwZGF0ZWQgVk0uCj4KPiBDaHJpc3RpYW4uCgpJIHByaW50
ZWQgYm90aCB2bS0+dGFza19pbmZvLnBpZCBWcyBjdXJyZW50LT5waWQgZm9yIHRlc3RpbmcsIGFu
ZCBJIGNhbiBzZWUgZGlmZmVyZW50IHZhbHVlcyBjb21pbmcgb3V0IG9mIC4KCmdub21lLXNoZWxs
LTIxMTTCoCBbMDExXcKgwqDCoCA0MS44MTI4OTQ6IGFtZGdwdV92bV91cGRhdGVfcHRlczogc3Rh
cnQ6MHgwODAwMTAyZTgwIGVuZDoweDA4MDAxMDJlODIsIGZsYWdzOjB4ODAsIGluY3I6NDA5Niwg
cGlkPTIxMjggdm1pZD0wIGNwaWQ9MjExNAoKcGlkIGlzIHZtLT50YXNrX2luZm8ucGlkPTIxMjgg
d2hlcmVhcyBjcGlkPTIxMTQgaXMgY3VycmVudC5waWQuCgpXaGljaCBpcyB0aGUgb25lIHdlIHdh
bnQgdG8gc2VuZCB3aXRoIHRoZSBldmVudCA/CgpUcmFjZSBldmVudCBieSBkZWZhdWx0IHNlZW1z
IHRvIGJlIGFkZGluZyB0aGUgcHJvY2VzcyBuYW1lIGFuZCBpZCBhdCB0aGUgaGVhZGVyIG9mIHRo
ZSBldmVudCAoZ25vbWUtc2hlbGwtMjExNCksIHdoaWNoIGlzIHNhbWUgYXMgY3VycmVudC5waWQK
CgpBbHNvLCBpcyBpdCBvayB0byBleHRyYWN0IHZtaWQgZnJvbSBqb2ItPnZtaWQgPwoKClJlZ2Fy
ZHMKClNoYXNoYW5rCgo+Cj4+ICsJKSwKPj4gKwo+PiArCVRQX2Zhc3RfYXNzaWduKAo+PiArCQkJ
dW5zaWduZWQgaW50IGk7Cj4+ICsKPj4gKwkJCV9fZW50cnktPnN0YXJ0ID0gc3RhcnQ7Cj4+ICsJ
CQlfX2VudHJ5LT5lbmQgPSBlbmQ7Cj4+ICsJCQlfX2VudHJ5LT5mbGFncyA9IGZsYWdzOwo+PiAr
CQkJX19lbnRyeS0+aW5jciA9IGluY3I7Cj4+ICsJCQlfX2VudHJ5LT5ucHRlcyA9IG5wdGVzOwo+
PiArCQkJZm9yIChpID0gMDsgaSA8IG5wdGVzOyArK2kpIHsKPj4gKwkJCQl1NjQgYWRkciA9IHAt
PnBhZ2VzX2FkZHIgPyBhbWRncHVfdm1fbWFwX2dhcnQoCj4+ICsJCQkJCXAtPnBhZ2VzX2FkZHIs
IGRzdCkgOiBkc3Q7Cj4+ICsKPj4gKwkJCQkoKHU2NCAqKV9fZ2V0X2R5bmFtaWNfYXJyYXkoZHN0
KSlbaV0gPSBhZGRyOwo+PiArCQkJCWRzdCArPSBpbmNyOwo+PiArCQkJfQo+PiArCSksCj4+ICsJ
VFBfcHJpbnRrKCJzdGFydDoweCUwMTBsbHggZW5kOjB4JTAxMGxseCwgZmxhZ3M6MHglbGx4LCBp
bmNyOiVsbHUsIgo+PiArCQkgICIgZHN0OlxuJXMiLCBfX2VudHJ5LT5zdGFydCwgX19lbnRyeS0+
ZW5kLCBfX2VudHJ5LT5mbGFncywKPj4gKwkJICBfX2VudHJ5LT5pbmNyLCBfX3ByaW50X2FycmF5
KAo+PiArCQkgIF9fZ2V0X2R5bmFtaWNfYXJyYXkoZHN0KSwgX19lbnRyeS0+bnB0ZXMsIDgpKQo+
PiArKTsKPj4gKwo+PiAgIFRSQUNFX0VWRU5UKGFtZGdwdV92bV9zZXRfcHRlcywKPj4gICAJICAg
IFRQX1BST1RPKHVpbnQ2NF90IHBlLCB1aW50NjRfdCBhZGRyLCB1bnNpZ25lZCBjb3VudCwKPj4g
ICAJCSAgICAgdWludDMyX3QgaW5jciwgdWludDY0X3QgZmxhZ3MsIGJvb2wgZGlyZWN0KSwKPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4gaW5kZXggNzFlMDA1Y2YyOTUy
Li5iNWRiYjVlOGJjNjEgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bS5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5jCj4+IEBAIC0xNTEzLDE3ICsxNTEzLDIyIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX3VwZGF0
ZV9wdGVzKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcGFyYW1zLAo+PiAgIAkJZG8g
ewo+PiAgIAkJCXVpbnQ2NF90IHVwZF9lbmQgPSBtaW4oZW50cnlfZW5kLCBmcmFnX2VuZCk7Cj4+
ICAgCQkJdW5zaWduZWQgbnB0ZXMgPSAodXBkX2VuZCAtIGZyYWdfc3RhcnQpID4+IHNoaWZ0Owo+
PiArCQkJdWludDY0X3QgdXBkX2ZsYWdzID0gZmxhZ3MgfCBBTURHUFVfUFRFX0ZSQUcoZnJhZyk7
Cj4+ICAgCj4+ICAgCQkJLyogVGhpcyBjYW4gaGFwcGVuIHdoZW4gd2Ugc2V0IGhpZ2hlciBsZXZl
bCBQRHMgdG8KPj4gICAJCQkgKiBzaWxlbnQgdG8gc3RvcCBmYXVsdCBmbG9vZHMuCj4+ICAgCQkJ
ICovCj4+ICAgCQkJbnB0ZXMgPSBtYXgobnB0ZXMsIDF1KTsKPj4gKwo+PiArCQkJdHJhY2VfYW1k
Z3B1X3ZtX3VwZGF0ZV9wdGVzKHBhcmFtcywgZnJhZ19zdGFydCwgdXBkX2VuZCwKPj4gKwkJCQkJ
CSAgICBucHRlcywgZHN0LCBpbmNyLAo+PiArCQkJCQkJICAgIHVwZF9mbGFncyk7Cj4+ICAgCQkJ
YW1kZ3B1X3ZtX3VwZGF0ZV9mbGFncyhwYXJhbXMsIHB0LCBjdXJzb3IubGV2ZWwsCj4+ICAgCQkJ
CQkgICAgICAgcGVfc3RhcnQsIGRzdCwgbnB0ZXMsIGluY3IsCj4+IC0JCQkJCSAgICAgICBmbGFn
cyB8IEFNREdQVV9QVEVfRlJBRyhmcmFnKSk7Cj4+ICsJCQkJCSAgICAgICB1cGRfZmxhZ3MpOwo+
PiAgIAo+PiAgIAkJCXBlX3N0YXJ0ICs9IG5wdGVzICogODsKPj4gLQkJCWRzdCArPSAodWludDY0
X3QpbnB0ZXMgKiBBTURHUFVfR1BVX1BBR0VfU0laRSA8PCBzaGlmdDsKPj4gKwkJCWRzdCArPSBu
cHRlcyAqIGluY3I7Cj4+ICAgCj4+ICAgCQkJZnJhZ19zdGFydCA9IHVwZF9lbmQ7Cj4+ICAgCQkJ
aWYgKGZyYWdfc3RhcnQgPj0gZnJhZ19lbmQpIHsKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
