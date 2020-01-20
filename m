Return-Path: <SRS0=J303=3J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E487C2D0DB
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 13:09:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12CAE22464
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 13:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TUusO/xB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12CAE22464
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA3666E946;
	Mon, 20 Jan 2020 13:09:48 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700077.outbound.protection.outlook.com [40.107.70.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8C1C6E946
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2020 13:09:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7MEG0s2A+73iINK3YRHRMQt1q4tru8za+xJsfb1/V3PcitnL7HqFCPduRaUH3CtKOKSlrQaEyMXn5225UbHzLGY+wawXkHhA3TKaogRJWXeByVn1N8FooUBhYRXSdyYvexdKBO4Vq8rysp2hT8K+Q++av73qZuWySBBXbeGL1tRvI5TIPhrknHniOJo5Z8TQDgVF9N5evAx1pSju2zcdpnmFon1lHnpSU/2hRETK1gWjRM+BIyar+uBQly5iNGjGdx92Wzruf0upYUzWJODNW+G6CkcDE8mPN8dizmjNhkMVfPeaz9ndvzCI8iaYdRs75N3ANjRY2Ub+Sfj9rKJ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWFfAzfnJ6h3Hxm7ttanJkjBCG8q1YvGV1OE1bs0U4M=;
 b=CuudwjU4mQ2uXl51/z1WsknDQ/P9MxmKW2o0QoU3LevuYCUHaz7Lr9h6etqBCrUdNk1/jibomBu4iBqLOMSQGcWiHg9Tjt0ga8xjNc2gMpNAwPD29yHG2g7ycfZ+3j8MeViXGAZuwv7NptvEK8vUHuz10YSwZHd0haPZRot27Tp/epSQo3Xc0mOUFw3KFn0tiK8wv3aqkj+oPIxbFGHVCM7Bc72UQR2BOWA0N+Xv0jNC7uAWGVAyad5q3IY6Ne6P6HI0//fyaatrFhCRWhrFUWciGYa0FErnwSDXzeaJcphu1ecBVwaIUUsQSaw4wrB72uVs36kYY4munoKHulxp+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWFfAzfnJ6h3Hxm7ttanJkjBCG8q1YvGV1OE1bs0U4M=;
 b=TUusO/xBR0D2hu0EK8PD/1HjtYi27W3OeaTavRivTt2WAdYv43GtZAvhFKJG+vdspQFFgn1c+jutqlyNxC/7tpUdDP2lDIt0PKp76/p8JzMjdWskQISTMzRy0jXu9wKqk6kDwVR3DXilf+E7pn1EtvGNAKBpTCJg9IC3pz83hU0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB2454.namprd12.prod.outlook.com (52.132.208.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Mon, 20 Jan 2020 13:09:44 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89%2]) with mapi id 15.20.2644.026; Mon, 20 Jan 2020
 13:09:44 +0000
Subject: Re: [RFC PATCH] drm/amdgpu: allocate entities on demand
To: Nirmoy <nirmodas@amd.com>, alexander.deucher@amd.com, kenny.ho@amd.com
References: <20191125231719.108949-1-nirmoy.das@amd.com>
 <2e514ab3-1582-6508-d81a-cbc2d12f42d7@amd.com>
 <74fd0faf-fd99-e33e-8d7a-95f9bb8be26a@gmail.com>
 <2c917837-6f3a-d6a6-1bb0-3ec1fc33a202@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ec9e1793-dc42-1172-ed3a-44749fcd28b4@amd.com>
Date: Mon, 20 Jan 2020 14:09:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <2c917837-6f3a-d6a6-1bb0-3ec1fc33a202@amd.com>
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0052.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::21) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 ZR0P278CA0052.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18 via Frontend Transport; Mon, 20 Jan 2020 13:09:42 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d551960c-5351-48d9-2e6e-08d79daa045d
X-MS-TrafficTypeDiagnostic: DM5PR12MB2454:|DM5PR12MB2454:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2454D475F1CAC09ECEFA5A3483320@DM5PR12MB2454.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0288CD37D9
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(199004)(189003)(2616005)(36756003)(52116002)(53546011)(5660300002)(16526019)(186003)(4326008)(316002)(2906002)(6636002)(86362001)(6486002)(478600001)(31686004)(6666004)(31696002)(81156014)(81166006)(8676002)(66476007)(66556008)(66946007)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2454;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nACoYwj+BX35VcmFdc2dBi8V07DiRad5HNz5RDTMLgPfVv1flXHGYTIGHK+fIerlhXEYMFkHGanvDSJdDN2BnyUK+WyZLAVMkWrwtL5Gc2AaEQgH+8vfENAn7b2qlA2JFTZ8yvOJSDu9f47mGA0BDZF7IBaUgXo+6s4ZvObDIlPKASS3gJ+idG8Q6uj4sEksEbfDwRnmUsQBHSBWcPoR4/lIlkaWkXfsOmzACAYwXvoi5tpUbZfQFrjk+ziweov07ckMWCr4hlwmFZLDohi+3O6oL7q1N7nJmElB1h6Hu1nQemZiBhFzqs23y0TVTc48t8m4ozES9uFL2DrdMwF+rGb29YDLiYGA31e1s66clq5VGs1xyW5sgJxDerLjOmoMxh3oc7fkUwaLN2pGsBFbVkh5kpWuJDVFbe1TjlJT0Id9URr+yYURR33WHim/M69G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d551960c-5351-48d9-2e6e-08d79daa045d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2020 13:09:44.1770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yu4Qw2Pv04MLmUtOZe6/bppVYxxFFuAIeomafsP1/2udMF1OKy0aAfiH9sn8WVX/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2454
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
Cc: nirmoy.das@amd.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAuMDEuMjAgdW0gMTQ6MDUgc2NocmllYiBOaXJtb3k6Cj4gSGkgQ2hyaXN0aWFuLAo+Cj4g
T24gMTEvMjYvMTkgMTA6NDUgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEl0IGxvb2tz
IGxpa2UgYSBzdGFydCwgYnV0IHRoZXJlIG51bWVyb3VzIHRoaW5ncyB3aGljaCBuZWVkcyB0byBi
ZSAKPj4gZml4ZWQuCj4+Cj4+IFF1ZXN0aW9uIG51bWJlciBvbmUgaXM6IFdoYXQncyB0aGF0IGdv
b2QgZm9yPyBFbnRpdGllcyBhcmUgbm90IHRoZSAKPj4gcHJvYmxlbSBoZXJlLiBUaGUgcmVhbCBp
c3N1ZSBpcyB0aGUgZmVuY2UgcmluZyBhbmQgdGhlIHJxX2xpc3QuCj4+Cj4+IFRoZSBycV9saXN0
IGNvdWxkIGFjdHVhbGx5IGJlIG1hZGUgY29uc3RhbnQgc2luY2UgaXQgc2hvdWxkIG5ldmVyIGJl
IAo+PiBjaGFuZ2VkIGJ5IHRoZSBlbnRpdHkuIEl0IGlzIG9ubHkgY2hhbmdlZCBmb3IgYmFja3dh
cmQgY29tcGF0aWJpbGl0eSAKPj4gaW4gZHJtX3NjaGVkX2VudGl0eV9zZXRfcHJpb3JpdHkoKS4K
Pj4KPj4gU28gSSB3b3VsZCBzdGFydCB0aGVyZSBhbmQgY2xlYW51cCB0aGUgCj4+IGRybV9zY2hl
ZF9lbnRpdHlfc2V0X3ByaW9yaXR5KCkgdG8gYWN0dWFsbHkganVzdCBzZXQgYSBuZXcgY29uc3Rh
bnQgCj4+IHJxIGxpc3QgaW5zdGVhZC4KPj4KPj4gVGhlbiB3ZSBjb3VsZCBlbWJlZCB0aGUgZmVu
Y2VzIGluIGFtZGdwdV9jdHhfZW50aXR5IGFzIGR5bmFtaWMgYXJyYXkgCj4+IGF0IHRoZSBlbmQg
b2YgdGhlIHN0cnVjdHVyZS4KPj4KPiBhbWRncHVfY3R4X2VudGl0eSBhbHJlYWR5IGNvbnRhaW5z
IGEgZmVuY2UgYXJyYXkuIERvIHlvdSBtZWFuIGFub3RoZXIgCj4gZmVuY2UgYXJyYXkgPwoKTm8g
SSBtZWFudCB0aGF0IG9uZS4gU2VlIGN1cnJlbnRseSB0aGlzIGZlbmNlIGFycmF5IGlzIGFsbG9j
YXRlZCAKc2VwYXJhdGVseSBiZWNhdXNlIGl0cyBzaXplIGRlcGVuZHMgb24gYSBtb2R1bGUgcGFy
YW1ldGVyIChJSVJDIHRoYXQgd2FzIApvbmUgYmlnIGFsbG9jYXRpb24gZm9yIGFsbCBlbnRpdGll
cykuCgpXaGVyZSB3ZSB3YW50IHRvIGdldCBpcyB0aGF0IGl0IGlzIGFsbG9jYXRlZCB0b2dldGhl
ciB3aXRoIHRoZSAKYW1kZ3B1X2N0eF9lbnRpdHkgYXMgYSBkeW5hbWljIGFycmF5LgoKUmVnYXJk
cywKQ2hyaXN0aWFuLgoKPgo+IHN0cnVjdCBhbWRncHVfY3R4X2VudGl0eSB7Cj4KPiDCoMKgwqDC
oMKgwqDCoCB1aW50NjRfdMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZXF1ZW5jZTsK
PiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZG1hX2ZlbmNlwqDCoMKgwqDCoMKgwqAgKipmZW5jZXM7
Cj4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRybV9zY2hlZF9lbnRpdHkgZW50aXR5Owo+IH07Cj4K
Pgo+Cj4gUmVnYXJkcywKPgo+IE5pcm1veQo+Cj4+IEFuZCBsYXN0IHdlIGNhbiBzdGFydCB0byBk
eW5hbWljIGFsbG9jYXRlIGFuZCBpbml0aWFsaXplIHRoZSAKPj4gYW1kZ3B1X2N0eF9lbnRpdHko
KSBzdHJ1Y3R1cmVzLgo+Pgo+PiBSZWdhcmRzLAo+PiBDaHJpc3RpYW4uCj4+Cj4+CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
