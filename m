Return-Path: <SRS0=opbO=4I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF11C11D05
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 15:21:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7FB720659
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 15:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="E3/2EKVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7FB720659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F09E6E8EB;
	Thu, 20 Feb 2020 15:21:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07C4A6E8EB
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2020 15:21:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJhnQ89X4zRXBjA48w3Yxrtbw0WnmQYU5Xrkv9iZvMqrttPMvYMjowf7lt5j08Qmi5ju6AMWTvlEhGdP26Xt1rltPTKAHS2kK3flGyPv5H3CfLeNvl5NF5rX47eWNeLkLo0N+aKScZ/Q3u3cptx6SmQvpQPX4QzuzIjuiBTg7/8JrfEcq7oHFyx+KFiby5m85OjUfZhx96RctmXnp7p7VNK/RdQXY1F77DW89Oa8MKQaAeMZXKq8BW6pBnUWocAoqlLAph5YKjpahwW8dxcZnWBDER3QMlHaCp49WgkbFukjTrQS8w0BjUVQnfas0VNNAqFtOyubcRAEYlps2fx2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3tpifHYc5CdTEEqWVyff+W6Zv5GfIOKVyVYYMBzt/w=;
 b=TG6qxc7saDI2M9i5PVGAku9O9GTHenpVNgKkwRXoOJePsZyCb0e0iAq+SqjydRnOL4S1W2jGW8VqDSU8SCTb5x42QcMjcEfHW4gu74VqouyDDeuepS7PEjPnYq+gjO23zN6b1AwMwl7ltcENN9lo6J5OBJKy+tmIP0L/TYlti53w2xpNDf5QxvtjYBWh7DxCgt+9ndYAJdLRm090BKj6MWxf64TF3Q4o6QGRf0wJTIhQ5RMrtyfHrgLx+ew2gYm7rkSndkpgxtVY6vg/lCHAtioJQpxgvDgGEJDouP8Xj/S1PoKMVwlCVTKhfPCxI/lnXCupnYGGntGUltbsVgN1XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3tpifHYc5CdTEEqWVyff+W6Zv5GfIOKVyVYYMBzt/w=;
 b=E3/2EKVBflHyluD/pWxnej8uCj9JLBAT6MZ6QfJfUuFx4rvf3wObC6P69dOE1iK9827c4qKMaqnGkWenrwrulqcUPUKeBJkzhchvRH9lwRaTwbXSoPOrBonjlOLo+qoW4A0dZaAMTG7GQ/ibxrV8axX5XzszDiofuROk63LAxcY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1625.namprd12.prod.outlook.com (10.172.37.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Thu, 20 Feb 2020 15:18:05 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2750.016; Thu, 20 Feb 2020
 15:18:05 +0000
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBkcm0vYW1kZ3B1OiBmaXggYSBidWcg?=
 =?UTF-8?Q?NULL_pointer_dereference?=
To: amd-gfx@lists.freedesktop.org
References: <20200219040445.11112-1-Dennis.Li@amd.com>
 <DM5PR12MB1418062D884DBE08E1FB9997FC100@DM5PR12MB1418.namprd12.prod.outlook.com>
 <e7ea478f-95ff-69c6-e81e-709b44904209@gmail.com>
 <DM6PR12MB393104A6C93ED039BAA5ED1C84100@DM6PR12MB3931.namprd12.prod.outlook.com>
 <MN2PR12MB3167C68A5B6AF0E97613A6A4ED130@MN2PR12MB3167.namprd12.prod.outlook.com>
 <DM6PR12MB39317635C3FB63265B9216D084130@DM6PR12MB3931.namprd12.prod.outlook.com>
 <DM6PR12MB39317F37CBE569725C00ABD284130@DM6PR12MB3931.namprd12.prod.outlook.com>
 <a8e8df99-aaed-5c0a-10ee-7cb63861c283@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <c778adb5-1ded-3b66-3f74-120f3388d611@amd.com>
Date: Thu, 20 Feb 2020 16:20:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <a8e8df99-aaed-5c0a-10ee-7cb63861c283@amd.com>
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0027.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::14) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2c:5d00:8d2:968:f382:8499]
 (2003:c5:8f2c:5d00:8d2:968:f382:8499) by
 ZR0P278CA0027.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Thu, 20 Feb 2020 15:18:01 +0000
X-Originating-IP: [2003:c5:8f2c:5d00:8d2:968:f382:8499]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b44d57bb-455b-4956-59a4-08d7b6181573
X-MS-TrafficTypeDiagnostic: DM5PR12MB1625:
X-Microsoft-Antispam-PRVS: <DM5PR12MB16254BFA0BD3DA34AA985E2D8B130@DM5PR12MB1625.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(6916009)(45080400002)(186003)(16526019)(81166006)(6666004)(2906002)(31686004)(5660300002)(53546011)(52116002)(81156014)(224303003)(36756003)(6486002)(31696002)(966005)(66946007)(478600001)(66476007)(8936002)(2616005)(316002)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1625;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V/zIAmYZxLoJeGRFQqwL/gP0a3fFaK6mloUzWGtjiXRxVg/AawXpxSJ4rh90ENgOdcNGJjOR/7mSM1Y2M3uRbyAL1pEjnPa0+D7BOc27nfwYNrEOBP6qKzTMpNiMaZhlgdSNj0b6/0kJRVVg2ysHD64mv4AAw0Lsy4ihbOjp38hGk1XCXS+Z4uL50kdhVVvzl37KXvS1TFCJy/wRdHnPAdk+HVw+uNacofXa95JZlp0A0xnIrF9aqayIXHE6dZEjtzOkELDExVo/3jlif2ZC7qecEkEO/Y8SoWel9EPDEILV9A88WOzCVIIfzlQbOscIgBOpCv5RS7ELjfd5gdplvaONmxRtU2RfMPA+bsxI1sfHKGWyQIjyUu9k+W+KbgdJbXgCMFJL38DJBD5BPFdMAYLmMGDOJs/A70L24TzVKoAoFPeN2qCbY5z7W+xSYQP+5LH0XTf5gbzGhDfkQufNdFdBI4IoN6KCeXACcHJ8zeQx7R/1VJGkUKZmJFujsMFA
X-MS-Exchange-AntiSpam-MessageData: k5CRQgqOvC0p34U9ynqKiSCYrEFFjqHYP2Uy9WMXW90QY4saPQHUYiHnNtGcMDu004SYyPAQjCJRn+atsI988xAQRJsHuP5DtGw80SZR/bV1MS/6IBr0fRC7EI40cmw/CkW13LO1j1L8lZTX+9E9lXjz7VsadvHu/BREAwRZrvqA1ciEJv2fry91jLSrUFE4CxccwYM8MtMAbQxekvYW8Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b44d57bb-455b-4956-59a4-08d7b6181573
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 15:18:05.2755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ahhqE7gNxmSZr/QOs8bxydNgOxbRHjB+2af4LoiIAEm5FAk+JKI5sIJD5Zd25sipE2eGYbH8EheLXnoR2Bp1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1625
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

SGkgTW9uaywKCkhvd8KgIGNhbiBJIHJlcHJvZHVjZSB0aGlzIGJ1ZyA/CgpSZWdhcmRzLAoKTmly
bW95CgpPbiAyLzIwLzIwIDQ6MTUgUE0sIE5pcm1veSB3cm90ZToKPgo+IE9uIDIvMjAvMjAgMjoz
NSBQTSwgTGl1LCBNb25rIHdyb3RlOgo+PiBTb3JyeSwgbXkgcHJldmlvdXMgaWRlYSBzdGlsbCBs
ZWF2ZSBSUSBudWxsLCBwbGVhc2UgY2hlY2sgaWYgYmVsb3cgCj4+IG1ldGhvZCB3b3JrczoKPj4K
Pj4gMjkgc3RhdGljIHN0cnVjdCBkcm1fc2NoZWRfcnEgKgo+PiAxMzAgZHJtX3NjaGVkX2VudGl0
eV9nZXRfZnJlZV9zY2hlZChzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0eSAqZW50aXR5KQo+PiAxMzEg
ewo+PiAxMzLCoMKgwqDCoCBzdHJ1Y3QgZHJtX3NjaGVkX3JxICpycSA9IE5VTEw7Cj4+IDEzM8Kg
wqDCoMKgIHVuc2lnbmVkIGludCBtaW5fam9icyA9IFVJTlRfTUFYLCBudW1fam9iczsKPj4gMTM0
wqDCoMKgwqAgaW50IGk7Cj4+Cj4+IDEzNQo+PiDCoMKgwqDCoMKgwqDCoCBXaGlsZSAoIW11dGV4
X3RyeWxvY2soLi4uLikpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgU2xlZXAoKQo+IFdlIGNh
bid0IGRvIHRoYXQgZHJtX3NjaGVkX2VudGl0eV9nZXRfZnJlZV9zY2hlZCBpcyBpbiBhbm90aGVy
IAo+IG1vZHVsZShkcm0gc2NoZWR1bGVyKSBpbmRlcGVuZGVudCBvZiBhbWRncHUKPj4gMTM2wqDC
oMKgwqAgZm9yIChpID0gMDsgaSA8IGVudGl0eS0+bnVtX3JxX2xpc3Q7ICsraSkgewo+PiAxMzfC
oMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqc2NoZWQgPSBlbnRpdHkt
PnJxX2xpc3RbaV0tPnNjaGVkOwo+PiAxMzgKPj4gMTM5wqDCoMKgwqDCoMKgwqDCoCBpZiAoIWVu
dGl0eS0+cnFfbGlzdFtpXS0+c2NoZWQtPnJlYWR5KSB7IC8vd2UgdGFrZSB0aGUgCj4+IGdwdSBy
ZXNldCBtdXRleCBsb2NrLCBzbyBub3cgc2NoZWQtPnJlYWR5IHdvbid0IGJlIHNldCB0byAibm90
IHJlYWR5Igo+PiAxNDDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRFJNX1dBUk4oInNjaGVkJXMg
aXMgbm90IHJlYWR5LCBza2lwcGluZyIsIHNjaGVkLT5uYW1lKTsKPj4gMTQxwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+PiAxNDLCoMKgwqDCoMKgwqDCoMKgIH0KPj4gMTQzCj4+
IDE0NMKgwqDCoMKgwqDCoMKgwqAgbnVtX2pvYnMgPSBhdG9taWNfcmVhZCgmc2NoZWQtPm51bV9q
b2JzKTsKPj4gMTQ1wqDCoMKgwqDCoMKgwqDCoCBpZiAobnVtX2pvYnMgPCBtaW5fam9icykgewo+
PiAxNDbCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWluX2pvYnMgPSBudW1fam9iczsKPj4gMTQ3
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJxID0gZW50aXR5LT5ycV9saXN0W2ldOwo+PiAxNDjC
oMKgwqDCoMKgwqDCoMKgIH0KPj4gMTQ5wqDCoMKgwqAgfQo+Pgo+PiDCoMKgwqDCoMKgwqDCoCBN
dXRleF91bmxvY2soLi4uKQo+Pgo+PiAxNTAKPj4gMTUxwqDCoMKgwqAgcmV0dXJuIHJxOwo+PiAx
NTIgfQo+Pgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRw
cyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFt
ZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q25pcm1veS5kYXMlNDBhbWQuY29tJTdDNDJkMTg0OGEz
NjhjNDM3MTA2OWEwOGQ3YjYxNzU3NzklN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgz
ZCU3QzAlN0MwJTdDNjM3MTc4MDgzNjkzMzQ4Nzc3JmFtcDtzZGF0YT1GV2Vld3pKOGpZQmxCeEFW
TWtNZXElMkJJRU96R2FwcU1pUmZXMjJWWXIxU0klM0QmYW1wO3Jlc2VydmVkPTAgCj4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
