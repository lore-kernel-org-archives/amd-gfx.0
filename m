Return-Path: <SRS0=Ai3v=23=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0C4C33C9B
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 14:08:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3D93207FD
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 14:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yhk/G0eQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D93207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AF1A6E2BC;
	Mon,  6 Jan 2020 14:08:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDFB76E2BC
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2020 14:08:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbu7kKGAT6oqo+07p1TNYGevPQSG3lCkJ/5oWr12afdGCxNbWR/KLOXvp9hywEC/mmcNo4xBbiKj+coMMsYKMPRK/OFIF3XTpiSbQqAuokWxbyFOy0YN+wDz7xS0rZcKrzkof3w+7S6lac7V+VuZT4JYtmPbPYj9O3445r4KRLP0o2A7K/ngxLuVT5cIad7SnFrCfsvbGn616YnGt/PXhrsDGgjzGk9fjYLfiznA55BBDVL4a78IDE7Zw95XTG/EHEEzx6c47SUADM4VfVsC9a/RinM6/uvqP1ccj8E9hLEthMI93HDtDd4A2u0L6e8Vf5YYvMrP05IaqOzyhvAXCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXzMi4+r13IvuJ/ir8A+SMGm32tj96WDfpNY8If1LmM=;
 b=ike1NtZ6NU3NDHY5CxRQxWlBCX3bspcstDgkdY24KanJhDFqsGRasM/6XN5wLS5LuSMwxrAZ5V1QmBZ6ULZVV7QeyyO2PaYYHYvhRjvi+9eYX/ym1CBBI+1FFg6P88J9uSvkspCOwSGmjp49lDAWL/vIUNEY3CkAloVF4lNccpVHCFNPZLv0AS/cyssWIu0cgiqTi+9JuDT1P2diaHol4pdlL/FWWEcFJw9coI966blPB9l87AT2vdabc9dP2dwe33wEtwQw716+AlcKTQU7A6AOSVg5gOHfnhtprxwCjCmLTWVXQZUFYbs/FHJGG20KM4CuSMjyWkXGZfbetWr9+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXzMi4+r13IvuJ/ir8A+SMGm32tj96WDfpNY8If1LmM=;
 b=yhk/G0eQmifRWyMNM4gieClGPlbdmRArwA0oq1RUt79CxlOTmUuIFNHmDfy197RTI8c1Sj4YeyrG3cuqzIF95pFD0tEXLLUWjkkOWPm5nO+/G3ZudFqp33jaHddsffSIr+f+mOqH9hP/QAkdVmumOO9r5AR18mZw+ij+BGOi6kA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB2455.namprd12.prod.outlook.com (52.132.142.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Mon, 6 Jan 2020 14:08:04 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89%2]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 14:08:04 +0000
Subject: Re: Warning: check cp_fw_version and update it to realize GRBM
 requires 1-cycle delay in cp firmware
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Alex Deucher <alexdeucher@gmail.com>,
 Paul Menzel <pmenzel+amd-gfx@molgen.mpg.de>
References: <745c5951-5304-9651-34f1-6b3f6a713ece@molgen.mpg.de>
 <CADnq5_PH=ww4nNzRmC6PkyfPNomH_1FXWeMTJpS2pt6CpuRZMA@mail.gmail.com>
 <3553af46-c9c5-cd33-e7f9-bf7a1a5f49a7@daenzer.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <9e4d867b-cd30-eb2d-406b-d6a462bdb04c@amd.com>
Date: Mon, 6 Jan 2020 15:07:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <3553af46-c9c5-cd33-e7f9-bf7a1a5f49a7@daenzer.net>
Content-Language: en-US
X-ClientProxiedBy: AM4PR07CA0020.eurprd07.prod.outlook.com
 (2603:10a6:205:1::33) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR07CA0020.eurprd07.prod.outlook.com (2603:10a6:205:1::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.4 via Frontend Transport; Mon, 6 Jan 2020 14:08:02 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5d8f66ea-4912-4271-5e3d-08d792b1d8d3
X-MS-TrafficTypeDiagnostic: DM5PR12MB2455:|DM5PR12MB2455:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB245582A61F2C5D9B12DB060F833C0@DM5PR12MB2455.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0274272F87
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(199004)(189003)(6666004)(5660300002)(6486002)(2616005)(66574012)(53546011)(2906002)(52116002)(86362001)(8936002)(8676002)(16526019)(186003)(81166006)(81156014)(31696002)(15650500001)(66556008)(66476007)(66946007)(4001150100001)(4326008)(36756003)(31686004)(316002)(54906003)(478600001)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2455;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Z3gsyt4i6VMxY3C5DWoV/4UX5OwIel5jRGl9NN86BPVf8qiNoLqbRcgPxIjNPSw5bIB1JOIHlm1aSz2NB024Hn/IAy12pUg3CeiQ5f7oXuovfpwRFS20FkAe2g7++pa5/QRgutiXENjsxNm8IkZEKUUK65fMq0LdidFfmpv0ExYkOnmLriETrRQyaXtKAfseDwTbfFtE8r2FThWP9PLmj9tQVd5FcgUDt79ctPy9G2fEPWJ85l33S+qhMIdwLFnGeO2eNOKoWTiC7+poGIqA8+zqFJpJ3WsLYTknlSJQiRnhsPGCCqSo6mmC8mQ9i/c2q4Tp8fnEy+VY+r3jPcjPu+WWCGIqElEr6k5caOcwMDLrZmPS1QTEPYJCOwiV6LJ4cxeaXJg1SVLle+AK6gLAQW7lA40uFUvpHlyAxvoRc3ZH9xM9nBNeDNFYQ7YKZbx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8f66ea-4912-4271-5e3d-08d792b1d8d3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2020 14:08:04.8628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGCcmF3ZLPNKwNh3JJUv38o6LIo4cPn0j3lF4+bjaWmzp3HBXuDGg8qYA80OWfg/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2455
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
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Chang Zhu <Changfeng.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDYuMDEuMjAgdW0gMTI6Mjkgc2NocmllYiBNaWNoZWwgRMOkbnplcjoKPiBPbiAyMDE5LTEy
LTI2IDU6NTMgcC5tLiwgQWxleCBEZXVjaGVyIHdyb3RlOgo+PiBPbiBUaHUsIERlYyAyNiwgMjAx
OSBhdCA1OjExIEFNIFBhdWwgTWVuemVsCj4+Pj4gWyAgIDEzLjQ0Njk3NV0gW2RybV0gV2Fybmlu
ZzogY2hlY2sgY3BfZndfdmVyc2lvbiBhbmQgdXBkYXRlIGl0IHRvIHJlYWxpemUgICAgICAgICAg
ICAgICAgICAgICAgICAgIEdSQk0gcmVxdWlyZXMgMS1jeWNsZSBkZWxheSBpbiBjcCBmaXJtd2Fy
ZQo+Pj4gQ2hhbmcsIGl0IGxvb2tzIGxpa2UgeW91IGFkZGVkIHRoYXQgd2FybmluZyBpbiBjb21t
aXQgMTFjNjEwODkzNC4KPj4+Cj4+Pj4gZHJtL2FtZGdwdTogYWRkIHdhcm5pbmcgZm9yIEdSQk0g
MS1jeWNsZSBkZWxheSBpc3N1ZSBpbiBnZng5Cj4+Pj4KPj4+PiBJdCBuZWVkcyB0byBhZGQgd2Fy
bmluZyB0byB1cGRhdGUgZmlybXdhcmUgaW4gZ2Z4OQo+Pj4+IGluIGNhc2UgdGhhdCBmaXJtd2Fy
ZSBpcyB0b28gb2xkIHRvIGhhdmUgZnVuY3Rpb24gdG8KPj4+PiByZWFsaXplIGR1bW15IHJlYWQg
aW4gY3AgZmlybXdhcmUuCj4+PiBVbmZvcnR1bmF0ZWx5LCBpdCBsb29rcyBsaWtlIHlvdSBkaWQg
bm90IGV2ZW4gY2hlY2sgaG93IHRoZSB3YXJuaW5nIGlzCj4+PiBmb3JtYXR0ZWQgKG5lZWRsZXNz
IHNwYWNlcyksIHNvIEkgZ3Vlc3MgdGhpcyB3YXMgdG90YWxseSB1bnRlc3RlZC4gQWxzbywKPj4+
IHdoYXQgaXMgdGhhdCB3YXJuaW5nIGFib3V0LCBhbmQgd2hhdCBpcyB0aGUgdXNlciBzdXBwb3Nl
ZCB0byBkbz8gSSBhbQo+Pj4gdW5hYmxlIHRvIGZpbmQgYGNwX2Z3X3ZlcnNpb25gIGluIHRoZSBz
b3VyY2UgY29kZSBhdCBhbGwuCj4+Pgo+PiBUaGUgY29kZSBsb29rcyBmaW5lLiAgTm90IHN1cmUg
d2h5IGl0J3MgcmVuZGVyaW5nIGZ1bm55IGluIHlvdXIgbG9nLgo+PiAgICAgICAgICAgICAgICAg
RFJNX1dBUk5fT05DRSgiV2FybmluZzogY2hlY2sgY3BfZndfdmVyc2lvbiBhbmQgdXBkYXRlCj4+
IGl0IHRvIHJlYWxpemUgXAo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBHUkJNIHJl
cXVpcmVzIDEtY3ljbGUgZGVsYXkgaW4gY3AgZmlybXdhcmVcbiIpOwo+IExvb2tzIGxpa2UgdGhl
IGxlYWRpbmcgc3BhY2VzIGFmdGVyIHRoZSBiYWNrc2xhc2ggYXJlIGluY2x1ZGVkIGluIHRoZQo+
IHN0cmluZy4gU29tZXRoaW5nIGxpa2UgdGhpcyBzaG91bGQgYmUgYmV0dGVyOgo+Cj4gICAgICAg
ICAgRFJNX1dBUk5fT05DRSgiV2FybmluZzogY2hlY2sgY3BfZndfdmVyc2lvbiBhbmQgdXBkYXRl
ICIKPiAgICAgICAgICAgICAgICAgICAgICAgICJHUkJNIHJlcXVpcmVzIDEtY3ljbGUgZGVsYXkg
aW4gY3AgZmlybXdhcmVcbiIpOwoKV2FybmluZyBhbmQgZXJyb3IgbWVzc2FnZXMgaW4gdGhlIGtl
cm5lbCBzaG91bGQgYmUgb24gYSBzaW5nbGUgbGluZSBpZiAKcG9zc2libGUgdG8gYWxsb3cgZm9y
IHNlYXJjaGluZyB0aGUga2VybmVsIGNvZGUgZm9yIHRoZSBzdHJpbmcgb2YgdGhlIAptZXNzYWdl
LgoKSSBzdWdnZXN0IHRvIGp1c3Qgc2hvcnRlbiB0aGUgbWVzc2FnZS4gRXNwZWNpYWxseSBpdCBp
cyBpcnJlbGV2YW50IHdoeSAKdGhlIENQIGZpcm13YXJlIGlzIHRvIG9sZCwgdGhhdCBpcyBkZWJ1
Z2dpbmcgaW5mbyBhdCBiZXN0LiBBZGRpdGlvbmFsIHRvIAp0aGF0IHRoZSAiV2FybmluZzoiIGlz
IHN1cGVyZmx1b3VzLgoKU29tZXRoaW5nIGxpa2UgRFJNX1dBUk5fT05DRSgiQ1AgZmlybXdhcmUg
dmVyc2lvbiB0byBvbGQsIHBsZWFzZSAKdXBkYXRlISIpIHNob3VsZCBwZXJmZWN0bHkgZG8gaXQu
CgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+Cj4gKG9yIG1heWJlIHRoZSBpbnRlbnRpb24gd2FzIHRv
IHB1dCB0aGUgc2Vjb25kIHNlbnRlbmNlIG9uIGEgbmV3IGxpbmU/KQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
