Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9480C33C9E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 19:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8052724656
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 19:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Km70iFdA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8052724656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C6896E030;
	Tue, 14 Jan 2020 19:20:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6E046E454
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 19:20:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIDcuomroHrr5hNIt6ObqB9fXScUB/ZByO57uJVQIWVo2xoADzhiVdz1vokkfJP4vAM6mdrG25DO+rbPu2UWIdgNy59jjKjsFJc8qfc7ohr5s0YzroUMDDUIfP7bJnVrJegzvquXoJ9SpezACcV0QCyQ0CVrKDz9rZxn04Tqv05gTLE4oxztW+XLuTZ9odzMIMNSCvPUITnA7TEFU30aFQ1klzDO+UFEexKQgWfp5eNxrmdod91ISMtxJSb6v3oSDsTU2njvPscmUY76lvXe3Ae5Ono3ma2NdFHntubCDvK+90ZwsiZFC6PEpLEH8tOdtKetbnwE2g3qaMAbi3oPFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOsoAAe/JU5ZbjKVQp1+BRhnpfzplIeL+WoBnwl7+wE=;
 b=P9yLI/zve0ehMVOjPe9/2o+DOmOmC0zWfh1CWL6za64HqVzCmyWxodnWRdmgV7iMgmMWEDsGELnuPY2GTH72wU6zOST7Eg1JZGmIRodFBHOcYg8kVDMilu1bFQC0C7Yi3VmW2Nbdm102eEq6fF1c3NZ9rQ9t/zfUYOq97VGDh6poGsYDEqhZ4Dp6ZrAfOwBCJPDdxy9H8aIViK6KlpcMVGH431qZ5eTahz75qOPD+ZqKKS2dOL1NDh06/zrvVTQN7+PVss9MEZ1s0lEOKotjOicAWbR+Gs2hrplW3pWU7aDgnwOsNURnuFHNs2DDMPn6KfVL80nJy/mh/q+RJYAYGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOsoAAe/JU5ZbjKVQp1+BRhnpfzplIeL+WoBnwl7+wE=;
 b=Km70iFdArkjiVpRHXzUE0HU2iAIsuNG4jVxUi8p3kTDrbrouTHrrDMg4MiU0U/xZi3rq7XkXPbyll2pboP36Phg6wp/Ucj8EjmjR1BRzNfK5kFnHj309xkRvRBvVQ/AQSnx9GH/35CuavDQL/LdTxgkZskywg79wvPsYwPOBHUE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB3334.namprd12.prod.outlook.com (20.178.55.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 19:20:39 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2644.015; Tue, 14 Jan 2020
 19:20:39 +0000
Subject: Re: [PATCH 4/6] drm/amdgpu/vcn2.5: add dpg pause mode
To: Leo Liu <leo.liu@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1579024702-27996-1-git-send-email-James.Zhu@amd.com>
 <1579024702-27996-5-git-send-email-James.Zhu@amd.com>
 <d810d136-a253-a2d3-eba5-a9bb82c9bde1@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <ddf74e7f-cbf3-3209-bab5-3b3db6e95e33@amd.com>
Date: Tue, 14 Jan 2020 14:20:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <d810d136-a253-a2d3-eba5-a9bb82c9bde1@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::44)
 To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from [172.27.233.155] (165.204.55.251) by
 YT1PR01CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10 via Frontend Transport; Tue, 14 Jan 2020 19:20:38 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a98710a-158b-4076-177d-08d79926d700
X-MS-TrafficTypeDiagnostic: BYAPR12MB3334:|BYAPR12MB3334:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB333459DC338A6F99C88DF185E4340@BYAPR12MB3334.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(199004)(189003)(8936002)(81166006)(81156014)(5660300002)(36756003)(8676002)(16576012)(6486002)(316002)(110136005)(66946007)(26005)(66556008)(66476007)(16526019)(186003)(52116002)(2906002)(478600001)(53546011)(31696002)(956004)(31686004)(36916002)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3334;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +aKg9Qy4dgQQBAm9cEI/ymn+iNIXkPV5SkS/kOiytgXv9BvtohPy1FSBdwreUV3QKDVxFNXWT9Ty/8888Rna8MHlRmhl3ZgLU0dMwSpLiY2B/yuCXd60RR7tQcdGxM8vk22XolvvzWY5DwbK/+oOiCiCCtbvcBpmXdzAThMBwoYdAiH3l9XlnUBElfDgFKPPYn8zFz2gKLGED+OcRrtLA5hrjJ8jvY4J7MESHVGcVDYt8pRQjv1g5Ophme7MMA/Z1bUff02a9Dq1WZ7PAdzCRFDomd+MhI36ZAkQHFVRBcfjtpP7CtegsKSDxBha50XB/605TV0yHpRqaKi9dT/+m23SzIcqsKIQWmGVH0MBd0U9rEj0BDpwYMMP0hnPv6I+Pf9xHjpe49DVrkb/MPRHwU3XdeFbrcw261IJjWTOTmWXiSUF7bDRirgeDjTpdK+1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a98710a-158b-4076-177d-08d79926d700
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 19:20:39.2668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gY1ft4jvyn9/p6BbcLehFse3tGYnJbEEJJRlb1aD2sX0j5OiXoiJg8+ANNFTHqxD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3334
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

Ck9uIDIwMjAtMDEtMTQgMjoxMCBwLm0uLCBMZW8gTGl1IHdyb3RlOgo+Cj4gT24gMjAyMC0wMS0x
NCAxMjo1OCBwLm0uLCBKYW1lcyBaaHUgd3JvdGU6Cj4+IEFkZCBkcGcgcGF1c2UgbW9kZSBzdXBw
b3J0IGZvciB2Y24yLjUKPj4KPj4gU2lnbmVkLW9mZi1ieTogSmFtZXMgWmh1IDxKYW1lcy5aaHVA
YW1kLmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml81
LmMgfCA3MCAKPj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPj4gwqAgMSBm
aWxlIGNoYW5nZWQsIDcwIGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml81LmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvdmNuX3YyXzUuYwo+PiBpbmRleCBlYTcwYWE4Li44ZGU1MWM5IDEwMDY0NAo+PiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfNS5jCj4+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml81LmMKPj4gQEAgLTYwLDYgKzYwLDggQEAgc3RhdGlj
IHZvaWQgdmNuX3YyXzVfc2V0X2VuY19yaW5nX2Z1bmNzKHN0cnVjdCAKPj4gYW1kZ3B1X2Rldmlj
ZSAqYWRldik7Cj4+IMKgIHN0YXRpYyB2b2lkIHZjbl92Ml81X3NldF9pcnFfZnVuY3Moc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwo+PiDCoCBzdGF0aWMgaW50IHZjbl92Ml81X3NldF9wb3dl
cmdhdGluZ19zdGF0ZSh2b2lkICpoYW5kbGUsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZW51bSBhbWRfcG93ZXJnYXRpbmdfc3RhdGUgc3RhdGUpOwo+PiArc3RhdGljIGlu
dCB2Y25fdjJfNV9wYXVzZV9kcGdfbW9kZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgaW5zdF9pZHgsIHN0cnVjdCBkcGdf
cGF1c2Vfc3RhdGUgKm5ld19zdGF0ZSk7Cj4+IMKgIHN0YXRpYyBpbnQgdmNuX3YyXzVfc3Jpb3Zf
c3RhcnQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwo+PiDCoCDCoCBzdGF0aWMgaW50IGFt
ZGdwdV9paF9jbGllbnRpZF92Y25zW10gPSB7Cj4+IEBAIC0yMTcsNiArMjE5LDkgQEAgc3RhdGlj
IGludCB2Y25fdjJfNV9zd19pbml0KHZvaWQgKmhhbmRsZSkKPj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIHI7Cj4+IMKgwqDCoMKgwqAgfQo+PiDCoCArwqDCoMKgIGlmIChhZGV2
LT5wZ19mbGFncyAmIEFNRF9QR19TVVBQT1JUX1ZDTl9EUEcpCj4+ICvCoMKgwqDCoMKgwqDCoCBh
ZGV2LT52Y24ucGF1c2VfZHBnX21vZGUgPSB2Y25fdjJfNV9wYXVzZV9kcGdfbW9kZTsKPj4gKwo+
PiDCoMKgwqDCoMKgIHJldHVybiAwOwo+PiDCoCB9Cj4+IMKgIEBAIC0xMzI3LDYgKzEzMzIsNjcg
QEAgc3RhdGljIGludCB2Y25fdjJfNV9zdG9wKHN0cnVjdCAKPj4gYW1kZ3B1X2RldmljZSAqYWRl
dikKPj4gwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4gwqAgfQo+PiDCoCArc3RhdGljIGludCB2Y25f
djJfNV9wYXVzZV9kcGdfbW9kZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgaW5zdF9pZHgsIHN0cnVjdCBkcGdfcGF1c2Vf
c3RhdGUgKm5ld19zdGF0ZSkKPgo+IEkgdGhpbmsgaGVyZSBpcyB0aGUgc2FtZSB0aGluZywgYWRk
IGluc3RhbmNlIHRvIHYyXzAsIGFuZCBhdm9pZCB0aGUgCj4gZHVwbGljYXRpb24uCj4KdmNuMi41
IGFuZCB2Y24yLjAgYXJlIG5vdCBleGFjdGx5IHRoZSBzYW1lLgoKSmFtZXMKCj4KPiBSZWdhcmRz
LAo+Cj4gTGVvCj4KPgo+PiArewo+PiArwqDCoMKgIHN0cnVjdCBhbWRncHVfcmluZyAqcmluZzsK
Pj4gK8KgwqDCoCB1aW50MzJfdCByZWdfZGF0YSA9IDA7Cj4+ICvCoMKgwqAgaW50IHJldF9jb2Rl
Owo+PiArCj4+ICvCoMKgwqAgLyogcGF1c2UvdW5wYXVzZSBpZiBzdGF0ZSBpcyBjaGFuZ2VkICov
Cj4+ICvCoMKgwqAgaWYgKGFkZXYtPnZjbi5wYXVzZV9zdGF0ZS5md19iYXNlZCAhPSBuZXdfc3Rh
dGUtPmZ3X2Jhc2VkKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBEUk1fREVCVUcoImRwZyBwYXVzZSBz
dGF0ZSBjaGFuZ2VkICVkIC0+ICVkIiwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWRldi0+
dmNuLnBhdXNlX3N0YXRlLmZ3X2Jhc2VkLCBuZXdfc3RhdGUtPmZ3X2Jhc2VkKTsKPj4gK8KgwqDC
oMKgwqDCoMKgIHJlZ19kYXRhID0gUlJFRzMyX1NPQzE1KFVWRCwgaW5zdF9pZHgsIG1tVVZEX0RQ
R19QQVVTRSkgJgo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoflVWRF9EUEdfUEFVU0VfX05K
X1BBVVNFX0RQR19BQ0tfTUFTSyk7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChuZXdfc3Rh
dGUtPmZ3X2Jhc2VkID09IFZDTl9EUEdfU1RBVEVfX1BBVVNFKSB7Cj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldF9jb2RlID0gMDsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgU09DMTVf
V0FJVF9PTl9SUkVHKFVWRCwgaW5zdF9pZHgsIG1tVVZEX1BPV0VSX1NUQVRVUywgMHgxLAo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFVWRF9QT1dFUl9TVEFUVVNfX1VWRF9QT1dF
Ul9TVEFUVVNfTUFTSywgcmV0X2NvZGUpOwo+PiArCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGlmICghcmV0X2NvZGUpIHsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBw
YXVzZSBEUEcgKi8KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWdfZGF0YSB8
PSBVVkRfRFBHX1BBVVNFX19OSl9QQVVTRV9EUEdfUkVRX01BU0s7Cj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgV1JFRzMyX1NPQzE1KFVWRCwgaW5zdF9pZHgsIG1tVVZEX0RQR19Q
QVVTRSwgcmVnX2RhdGEpOwo+PiArCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Lyogd2FpdCBmb3IgQUNLICovCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgU09D
MTVfV0FJVF9PTl9SUkVHKFVWRCwgaW5zdF9pZHgsIG1tVVZEX0RQR19QQVVTRSwKPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFVWRF9EUEdfUEFVU0VfX05K
X1BBVVNFX0RQR19BQ0tfTUFTSywKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIFVWRF9EUEdfUEFVU0VfX05KX1BBVVNFX0RQR19BQ0tfTUFTSywgcmV0X2Nv
ZGUpOwo+PiArCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogUmVzdG9yZSAq
Lwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJpbmcgPSAmYWRldi0+dmNuLmlu
c3RbaW5zdF9pZHhdLnJpbmdfZW5jWzBdOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFdSRUczMl9TT0MxNShVVkQsIGluc3RfaWR4LCBtbVVWRF9SQl9CQVNFX0xPLCAKPj4gcmlu
Zy0+Z3B1X2FkZHIpOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFdSRUczMl9T
T0MxNShVVkQsIGluc3RfaWR4LCBtbVVWRF9SQl9CQVNFX0hJLCAKPj4gdXBwZXJfMzJfYml0cyhy
aW5nLT5ncHVfYWRkcikpOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFdSRUcz
Ml9TT0MxNShVVkQsIGluc3RfaWR4LCBtbVVWRF9SQl9TSVpFLCAKPj4gcmluZy0+cmluZ19zaXpl
IC8gNCk7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgV1JFRzMyX1NPQzE1KFVW
RCwgaW5zdF9pZHgsIG1tVVZEX1JCX1JQVFIsIAo+PiBsb3dlcl8zMl9iaXRzKHJpbmctPndwdHIp
KTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBXUkVHMzJfU09DMTUoVVZELCBp
bnN0X2lkeCwgbW1VVkRfUkJfV1BUUiwgCj4+IGxvd2VyXzMyX2JpdHMocmluZy0+d3B0cikpOwo+
PiArCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmluZyA9ICZhZGV2LT52Y24u
aW5zdFtpbnN0X2lkeF0ucmluZ19lbmNbMV07Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgV1JFRzMyX1NPQzE1KFVWRCwgaW5zdF9pZHgsIG1tVVZEX1JCX0JBU0VfTE8yLCAKPj4g
cmluZy0+Z3B1X2FkZHIpOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFdSRUcz
Ml9TT0MxNShVVkQsIGluc3RfaWR4LCBtbVVWRF9SQl9CQVNFX0hJMiwgCj4+IHVwcGVyXzMyX2Jp
dHMocmluZy0+Z3B1X2FkZHIpKTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBX
UkVHMzJfU09DMTUoVVZELCBpbnN0X2lkeCwgbW1VVkRfUkJfU0laRTIsIAo+PiByaW5nLT5yaW5n
X3NpemUgLyA0KTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBXUkVHMzJfU09D
MTUoVVZELCBpbnN0X2lkeCwgbW1VVkRfUkJfUlBUUjIsIAo+PiBsb3dlcl8zMl9iaXRzKHJpbmct
PndwdHIpKTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBXUkVHMzJfU09DMTUo
VVZELCBpbnN0X2lkeCwgbW1VVkRfUkJfV1BUUjIsIAo+PiBsb3dlcl8zMl9iaXRzKHJpbmctPndw
dHIpKTsKPj4gKwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFdSRUczMl9TT0Mx
NShVVkQsIGluc3RfaWR4LCBtbVVWRF9SQkNfUkJfV1BUUiwKPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJSRUczMl9TT0MxNShVVkQsIGluc3RfaWR4LCBt
bVVWRF9TQ1JBVENIMikgJiAKPj4gMHg3RkZGRkZGRik7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBTT0MxNV9XQUlUX09OX1JSRUcoVVZELCBpbnN0X2lkeCwgbW1VVkRf
UE9XRVJfU1RBVFVTLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgMHgwLCBVVkRfUE9XRVJfU1RBVFVTX19VVkRfUE9XRVJfU1RBVFVTX01BU0ssIAo+PiBy
ZXRfY29kZSk7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4gK8KgwqDCoMKgwqDCoMKg
IH0gZWxzZSB7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIHVucGF1c2UgZHBnLCBubyBu
ZWVkIHRvIHdhaXQgKi8KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVnX2RhdGEgJj0gflVW
RF9EUEdfUEFVU0VfX05KX1BBVVNFX0RQR19SRVFfTUFTSzsKPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgV1JFRzMyX1NPQzE1KFVWRCwgaW5zdF9pZHgsIG1tVVZEX0RQR19QQVVTRSwgcmVnX2Rh
dGEpOwo+PiArwqDCoMKgwqDCoMKgwqAgfQo+PiArwqDCoMKgwqDCoMKgwqAgYWRldi0+dmNuLnBh
dXNlX3N0YXRlLmZ3X2Jhc2VkID0gbmV3X3N0YXRlLT5md19iYXNlZDsKPj4gK8KgwqDCoCB9Cj4+
ICsKPj4gK8KgwqDCoCByZXR1cm4gMDsKPj4gK30KPj4gKwo+PiDCoCAvKioKPj4gwqDCoCAqIHZj
bl92Ml81X2RlY19yaW5nX2dldF9ycHRyIC0gZ2V0IHJlYWQgcG9pbnRlcgo+PiDCoMKgICoKPj4g
QEAgLTEzNjksNiArMTQzNSwxMCBAQCBzdGF0aWMgdm9pZCB2Y25fdjJfNV9kZWNfcmluZ19zZXRf
d3B0cihzdHJ1Y3QgCj4+IGFtZGdwdV9yaW5nICpyaW5nKQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAg
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSByaW5nLT5hZGV2Owo+PiDCoCArwqDCoMKgIGlm
IChhZGV2LT5wZ19mbGFncyAmIEFNRF9QR19TVVBQT1JUX1ZDTl9EUEcpCj4+ICvCoMKgwqDCoMKg
wqDCoCBXUkVHMzJfU09DMTUoVVZELCByaW5nLT5tZSwgbW1VVkRfU0NSQVRDSDIsCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGxvd2VyXzMyX2JpdHMocmluZy0+d3B0cikgfCAweDgwMDAwMDAw
KTsKPj4gKwo+PiDCoMKgwqDCoMKgIGlmIChyaW5nLT51c2VfZG9vcmJlbGwpIHsKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIGFkZXYtPndiLndiW3JpbmctPndwdHJfb2Zmc10gPSBsb3dlcl8zMl9iaXRz
KHJpbmctPndwdHIpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgV0RPT1JCRUxMMzIocmluZy0+ZG9v
cmJlbGxfaW5kZXgsIGxvd2VyXzMyX2JpdHMocmluZy0+d3B0cikpOwpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
