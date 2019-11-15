Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE6DC432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 12:50:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A29C620728
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 12:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29C620728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 630FA6E5D0;
	Fri, 15 Nov 2019 12:50:36 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760055.outbound.protection.outlook.com [40.107.76.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF9646E5D4
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 12:50:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaiUkKdh9xKjuuvfIJUpkICwyG3E0WkMZ7ywBzTPANvx7Lf0ahVbcC4nOx0+c37f+Qw0WvqsrWew1V0sL/aKQtJk/4JU53F/x/HcFHDmd4GCoU1FqRs5v7d1GBxv3KJhtkTNHf8SSWLa8+YkosB1++O746l6nN6nR5mXgUmaE+R6+g4SwZXnA9zgQpzj2d8+/EQIGMRZyDV06mKWUwehG+KNt4cx/mAKFi+t8tlV5w0ztW+bGBi9fBP9F+QUBuPZlJIE7rXaA+rQObqF8GcU/KXOPkuCCdujTTozRl522kwXZSH5itCURQEojvWTFjjPdf9bBw4ossLWuZMaSh4rAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9Oaj5RW5oer3KUZTKMz83NtsHpzm8YVUvF4MbYdPSc=;
 b=WtEzzltSvF+ppfQ1oev8SYaLEehvoFSWQL5weiWVqBgTTYqWLmAVMNDCW49kM96880dcBGMGkNymTKAQbcQJL6Y7K8Z99PHnKBNnE9vGZUmAVQIo7TcKeAzSx0l3+9BpQ5+OPQZ8FnamyA4zb6QGFnM2UrL3EeOPw1U9wC0SghMMWkANYF3ZOPhWHSv/Hh/VLJdBimEX8qbb1jF5U0q18LNwbKenJ+iPlkq3piBEs9dYyT7MKFLjmvyJay1fhwQYkgaf40wHQ+UkP4/L4bPETxFpmhjiiYiXsnuWAvtOfISMMK49oFLbawXuG6YtDONB5zpTfFs9KVpn/HIrt+XirQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN6PR12MB1699.namprd12.prod.outlook.com (10.175.97.148) by
 BN6PR12MB1154.namprd12.prod.outlook.com (10.168.227.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Fri, 15 Nov 2019 12:50:33 +0000
Received: from BN6PR12MB1699.namprd12.prod.outlook.com
 ([fe80::68e1:ddf5:df4c:b554]) by BN6PR12MB1699.namprd12.prod.outlook.com
 ([fe80::68e1:ddf5:df4c:b554%9]) with mapi id 15.20.2451.027; Fri, 15 Nov 2019
 12:50:32 +0000
Subject: Re: [PATCH 07/12] amdgpu: using IB flags for TMZ or non-TMZ
To: Huang Rui <ray.huang@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
 <1573788895-3936-7-git-send-email-aaron.liu@amd.com>
 <20191115093220.GA20622@ray.huang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ea9f95d8-a444-270c-85e6-ab062954320f@amd.com>
Date: Fri, 15 Nov 2019 13:50:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191115093220.GA20622@ray.huang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR05CA0009.eurprd05.prod.outlook.com (2603:10a6:205::22)
 To BN6PR12MB1699.namprd12.prod.outlook.com
 (2603:10b6:404:ff::20)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ec1f53c-1301-4fa8-337a-08d769ca66a5
X-MS-TrafficTypeDiagnostic: BN6PR12MB1154:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1154CD1F2A1C829B8FD3CA0183700@BN6PR12MB1154.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02229A4115
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(199004)(189003)(36756003)(229853002)(31696002)(23676004)(52116002)(86362001)(110136005)(6116002)(46003)(2486003)(54906003)(76176011)(65806001)(2906002)(65956001)(50466002)(6506007)(47776003)(476003)(2616005)(230700001)(14454004)(486006)(14444005)(99286004)(186003)(66946007)(6246003)(305945005)(66476007)(66556008)(25786009)(81156014)(81166006)(8676002)(316002)(8936002)(7736002)(478600001)(31686004)(6512007)(6486002)(386003)(11346002)(58126008)(446003)(6666004)(6436002)(5660300002)(4326008)(6636002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1154;
 H:BN6PR12MB1699.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VDMiFHHsW6jG4iSIubXvNDmQpFv+R/N6kMJDfYEIZydXKbcYqNDKsoVnh8WYId1lRmvYdLaSbFvPnmpduJJsmXcCAYneoI2agGuqL2ivOLLMB/dh1fGHLJ4zPPUdI27guC1FzmKHdJROH4GAgBsa80gPSTp1Z4Oi/56Nalwebq4tLjkOOILs9X1pVPSa8oDQGZKDbPS6we1KnCfxDDu18nUeGn3E9LvYpUu7nxLKDsXWy8pmCpow6XKzMyiTynG5GP0hU3YjTOXSDw2bWzxvBwbb8HzIeMzClnAcK25L8vtrsgt0NMsa9vgbEMaxA/EOx9M0wtufUSl+dh8mvbXfUevlNieSB0leNOMk+oDsa53/m4JBabyXOgsEAUoRzya7vhWK9zZIRpXQndhPqwVog8c7/K3xsxI2JY+iT89KQH21JtMKiNkUdxhB1jolRFLt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec1f53c-1301-4fa8-337a-08d769ca66a5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 12:50:32.7355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0D+wUylvv0E2fe3JrNCWKpDO5ZxVXm1fyYJgQobdlbMKsmRcyxIBj/DRGwVCRPBQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1154
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9Oaj5RW5oer3KUZTKMz83NtsHpzm8YVUvF4MbYdPSc=;
 b=t7Mp+boM4TcR3h+pY7fhFBf3ZLvY1xH1n5Y5GBayo70vDy5xSWDJDFOa8cEUp7oNXd5UbarmmpXoN1kczC7j+giP+WGsKbR7r7aLCyH8YMBQx6BsDdzDLtaHDUb/l9XujJBaDVXtUPr/ADzRHU/sFz4869oTjyUhdUH7qt2KAwo=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Olsak,
 Marek" <Marek.Olsak@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Liu,
 Leo" <Leo.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115125026.LFZFr-YhoE-8jrywbw_rwu5Js2h7rdx_bw5VtTNF2V8@z>

QW0gMTUuMTEuMTkgdW0gMTA6MzIgc2NocmllYiBIdWFuZyBSdWk6Cj4gT24gRnJpLCBOb3YgMTUs
IDIwMTkgYXQgMTE6MzQ6NTBBTSArMDgwMCwgTGl1LCBBYXJvbiB3cm90ZToKPj4gSW4ga2VybmVs
LCBjcy0+aW4uZmxhZ3MgaXMgdXNlZCBmb3IgVE1aLiBIZW5jZSBsaWJkcm0gc2hvdWxkIHRyYW5z
ZmVyCj4+IHRoZSBmbGFnIHRvIGtlcm5lbC4KPj4KPj4gU2lnbmVkLW9mZi1ieTogQWFyb24gTGl1
IDxhYXJvbi5saXVAYW1kLmNvbT4KPj4gLS0tCj4+ICAgYW1kZ3B1L2FtZGdwdS5oICAgIHwgNCAr
KystCj4+ICAgYW1kZ3B1L2FtZGdwdV9jcy5jIHwgNCArKysrCj4+ICAgMiBmaWxlcyBjaGFuZ2Vk
LCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2FtZGdw
dS9hbWRncHUuaCBiL2FtZGdwdS9hbWRncHUuaAo+PiBpbmRleCBmNDVmOWY3Li5hZWUzZjNkIDEw
MDY0NAo+PiAtLS0gYS9hbWRncHUvYW1kZ3B1LmgKPj4gKysrIGIvYW1kZ3B1L2FtZGdwdS5oCj4+
IEBAIC0zNDIsNyArMzQyLDkgQEAgc3RydWN0IGFtZGdwdV9jc19mZW5jZV9pbmZvIHsKPj4gICAg
KiBcc2EgYW1kZ3B1X2NzX3N1Ym1pdCgpCj4+ICAgKi8KPj4gICBzdHJ1Y3QgYW1kZ3B1X2NzX3Jl
cXVlc3Qgewo+PiAtCS8qKiBTcGVjaWZ5IGZsYWdzIHdpdGggYWRkaXRpb25hbCBpbmZvcm1hdGlv
biAqLwo+PiArCS8qKiBTcGVjaWZ5IGZsYWdzIHdpdGggYWRkaXRpb25hbCBpbmZvcm1hdGlvbgo+
PiArCSAqIDAtbm9ybWFsLCAxLXRtego+PiArCSAqLwo+PiAgIAl1aW50NjRfdCBmbGFnczsKPj4g
ICAKPj4gICAJLyoqIFNwZWNpZnkgSFcgSVAgYmxvY2sgdHlwZSB0byB3aGljaCB0byBzZW5kIHRo
ZSBJQi4gKi8KPj4gZGlmZiAtLWdpdCBhL2FtZGdwdS9hbWRncHVfY3MuYyBiL2FtZGdwdS9hbWRn
cHVfY3MuYwo+PiBpbmRleCA0MzdjNGE0Li42ZjcwNzcxIDEwMDY0NAo+PiAtLS0gYS9hbWRncHUv
YW1kZ3B1X2NzLmMKPj4gKysrIGIvYW1kZ3B1L2FtZGdwdV9jcy5jCj4+IEBAIC0yNTQsNiArMjU0
LDEwIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2NzX3N1Ym1pdF9vbmUoYW1kZ3B1X2NvbnRleHRfaGFu
ZGxlIGNvbnRleHQsCj4+ICAgCW1lbXNldCgmY3MsIDAsIHNpemVvZihjcykpOwo+PiAgIAljcy5p
bi5jaHVua3MgPSAodWludDY0X3QpKHVpbnRwdHJfdCljaHVua19hcnJheTsKPj4gICAJY3MuaW4u
Y3R4X2lkID0gY29udGV4dC0+aWQ7Cj4+ICsJLyogaW4ga2VybmVsLCBfcGFkIGlzIHVzZWQgYXMg
ZmxhZ3MKPj4gKwkgKiAjZGVmaW5lIEFNREdQVV9DU19GTEFHU19TRUNVUkUgICAgICAgICAgKDEg
PDwgMCkKPj4gKwkgKi8KPj4gKwljcy5pbi5fcGFkID0gKHVpbnQzMl90KWlic19yZXF1ZXN0LT5m
bGFnczsKPiBfcGFkIGlzIG5vdCBnb29kIGhlcmUuIEJlY2F1c2UgaXQncyB1c2VkIHRvIHBhc3Mg
dGhlIGZsYWdzIHRvIGlucHV0IHBhcmFtLgo+Cj4gSXQncyBiZXR0ZXIgdG8gcmVuYW1lICJfcGFk
IiBpbiBkcm1fYW1kZ3B1X2NzX2luIGFzICJmbGFncyIgaGVyZS4KCkFjdHVhbGx5IEkgZG9uJ3Qg
dGhpbmsgd2UgbmVlZCB0aGF0IHN0dWZmIGFsdG9nZXRoZXIsIHBsZWFzZSBzeW5jIHVwIAp3aXRo
IE1hcmVrIG9uIHRoaXMuCgpBcyBmYXIgYXNJIGtub3cgdGhlIHdob2xlIGFtZGdwdV9jc19zdWJt
aXQgaW50ZXJmYWNlIHdhcyBkZXByZWNhdGVkIGluIApmYXZvciBvZiB0aGUgbmV3IGFtZGdwdV9j
c19zdWJtaXRfcmF3KCkgaW50ZXJmYWNlLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPgo+IFRoYW5r
cywKPiBSYXkKPgo+PiAgIAlpZiAoaWJzX3JlcXVlc3QtPnJlc291cmNlcykKPj4gICAJCWNzLmlu
LmJvX2xpc3RfaGFuZGxlID0gaWJzX3JlcXVlc3QtPnJlc291cmNlcy0+aGFuZGxlOwo+PiAgIAlj
cy5pbi5udW1fY2h1bmtzID0gaWJzX3JlcXVlc3QtPm51bWJlcl9vZl9pYnM7Cj4+IC0tIAo+PiAy
LjcuNAo+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
