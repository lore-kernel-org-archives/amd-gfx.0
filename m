Return-Path: <SRS0=U106=CU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C088BC433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 08:09:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63DB120659
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 08:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="V7p4midc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DB120659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB9CB6E392;
	Fri, 11 Sep 2020 08:09:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 875636E384
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2020 08:09:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUirEcVFygQcZv/IoDgfZH5ZxN6tWEBzy4t1UDEkaW5+0mej5kL0amTGtDK58VX+vX/y0QOgflQy3PibqPV/4U70VBnzXtFAeTLXDHwk2jt/Gwvk5icEuuPsIY1OBP0utNJZZHOvbDxTkb/BwZNVfXhX8oGop9kCMFmJp2X8JnQxif9EQsTiYQaXUIyDWaeoPT2kMfoWKRvJrMIuV+yr+/NvdozaLGhd+tdXCmUCLEmM1RKJBwS+0WOq2Io7EhLZuOU0ETSwj9NpG0e/eaaqrA+Hfsram3pQ04lc6nBmGPZHXhz9RGqq90N773ggcnV536EMxXhG2EozVhbvG1C3Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJ6ls0OaCfHY5/ZTg5F8KE7hYBS5mfJk0Jnaow5n4TE=;
 b=ThFV3DqEJ9GYTq61j2uS0E5O42jrUff2pTzpaalL7ZmHJeM1cc0cKT+VCCQkY05OvypCAMSBolU9402HVEH2F7SKkJKZmm28DxxC0JzI9YUJqrOFOsvy1TkQ910jJ7akQVlYE/Ioz+nYoRiR2q6yk1/nX+txIbIHebjxZwkgzuwbaidpATNS5j3IA/ZvVu2KH+dhiIetm+e65HUT+CQJCEKBaAY20EfHFmdeIYkCtKGTT6ykctHPI/nDWINCzth9p0G4mVTZHzTOfqyzl8XNvlPNtNI2w00sd5u2MrYyUEDY+xTfpU1n4xLC3AWka5pwfdmQq7UByYA1oT6AIch+Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJ6ls0OaCfHY5/ZTg5F8KE7hYBS5mfJk0Jnaow5n4TE=;
 b=V7p4midcRNBKu7Xew5AWhlvu7IWUiTVqR4peJSkE7e7cOa9mx/2FP2yn0LEzNmKeT2McXmUSe8xDzAMcHjQ6rl36emXQ11GVTJmPm7ZTSG11k5RoqQPmvH/hTZ1eIRYAHqFVbtlIPb505cBVozZ1vksVmvLfQuf+ij8Y1EvlG7Y=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB2698.namprd12.prod.outlook.com (2603:10b6:5:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 08:09:33 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3370.016; Fri, 11 Sep 2020
 08:09:33 +0000
Subject: Re: [PATCH] drm/radeon: revert "Prefer lower feedback dividers"
To: amd-gfx@lists.freedesktop.org
References: <20200909111655.1102-1-christian.koenig@amd.com>
 <f4505fa5-99a1-0010-7832-2d0e8e2c4410@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <6cfb68bd-efba-33ba-29a5-f3f907a5df9a@amd.com>
Date: Fri, 11 Sep 2020 10:14:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <f4505fa5-99a1-0010-7832-2d0e8e2c4410@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0047.eurprd04.prod.outlook.com
 (2603:10a6:208:1::24) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.121.210) by
 AM0PR04CA0047.eurprd04.prod.outlook.com (2603:10a6:208:1::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 08:09:32 +0000
X-Originating-IP: [217.86.121.210]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 383cb514-d234-48b9-a80e-08d8562a0456
X-MS-TrafficTypeDiagnostic: DM6PR12MB2698:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2698AF88664FAAC5216A96678B240@DM6PR12MB2698.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kSBENu4yattq8LtHgVvgSjQWfZMvoVJrKuvmH0kL0xTX9/VHCwwbMROS2M5UZaXBN3lYhaiBjN+vJE/5ZQOszj6crzN22gwUmgxIRKkMiYlL6WOGefn787P+UJdsK2MnDfiIoLqtCzwNdljyUVGU5U6eOmdfqGtzXu/V4Vrz43IJnlGeDY2fatiBXStOKVmXkTjWOQKdGrGegUArasInQxzbKUtqGkkAprmvshVaA4SQmBS3em/Ezzowk6Zm2wuv8XPyAmUR10YzpZhbCzxZwzChHrhChhZS5sRPEObhr3Cv5znZDbj8AI1dms+AoHe6mkqleoWLw1xK4p5hQSxEFndpBVIclj29XrOr9E3TVWnQcZhSQ2EoARCBVVaQfMpv1UO+6QlbPfVI83RhbgB3H7Wu0+1SGz0ipORsP7p0keDRhcTsOUyr+JtiytXCl3AS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(26005)(16526019)(2906002)(8676002)(52116002)(4326008)(16576012)(66476007)(66556008)(53546011)(316002)(6916009)(8936002)(186003)(66946007)(5660300002)(2616005)(6486002)(31686004)(66574015)(83380400001)(956004)(966005)(45080400002)(478600001)(31696002)(36756003)(6666004)(154273002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: hlFFPmH15/N8qe2l4xWgLOMLxU/39+igcQPKYcwBBNOoNYcDYa+vurSF8HVckFk1E/NIlNYwcxLkNLRP1Mwtvt/B8zbbWAHYfaoj29eaKiJQV7lgUVzsaNqs3bPJS7p2n+owQuC9JiuA1uvKZ7gnvubSVb/Vi+3n4Mpkgq6qrW4ZGSsJhbzAwQ25QBIKpi0QJO2olZXr1DyHcIinZ6w87qQOREGhvpzUs6LtwNCTAWvbvyonHT9BG0wyPW6QZLI9veVvvNruT91ub8vt3VN6oUC12smE5RsfSBskRadO0+5HlPFpEAimIqSbsrErT+8oS1HinY+vQyj5WJFpNIDAwCKexh5+StIWvpooHQMfdUOTIhvRQxaG0myXqI11YGuuzCHwtFIWLL0yFdZPOo6DU4CH+fetfdeTzxEPP4dnN0xE9Ur+ZjBYmk9oit4LUqOIvrU68xQYJeTADcOKB3No/kdrtL9SKd8ddNIxsDs+EDb2z4pMPZnXOuNWg2PHimWrSTlDatoEJoAjo9hXqTRF6pA/17PLGryrGQ7qJIYGWbxgIMfuQyaeXZ/rBCflEREkak80OzvqPWM7ADREX7kDmqWqH9L+huSx7emxJNIGKL0UkTMTWnm7ib2llfYnW2vh4Gb+zyyYDhIEtZcnYNg9Fw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383cb514-d234-48b9-a80e-08d8562a0456
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 08:09:33.6007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YtJLFiVSQghDUQDYBjA01wSNmz2uF2K5dqZ7pMqSfVBckVrADu34F+YyPN+dM2cgPqeWiepBwBGZk54l70UUnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2698
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SSBkb24ndCBrbm93IG11Y2ggYWJvdXQgZGlzcGxheSBjb2RlIGJ1dCB0aGlzIGlzCgpBY2tlZC1i
eTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPiBhcyBTb25ueSBjb25maXJtZWQgdGhh
dCB0aGUKCnJldmVydCBmaXhlcyBkaXNwbGF5IGNvcnJ1cHRpb24uCgoKT24gOS8xMS8yMCA5OjM1
IEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IFBpbmcsIHdlIG5lZWQgdG8gcmV2ZXJ0IHRo
aXMgQVNBUC4KPgo+IENocmlzdGlhbi4KPgo+IEFtIDA5LjA5LjIwIHVtIDEzOjE2IHNjaHJpZWIg
Q2hyaXN0aWFuIEvDtm5pZzoKPj4gVHVybnMgb3V0IHRoaXMgYnJlYWtzIGEgbG90IG9mIGRpZmZl
cmVudCBoYXJkd2FyZS4KPj4KPj4gVGhpcyByZXZlcnRzIGNvbW1pdCA1MjJmZjNhOGI2ZDczYTMx
MDg0YjRiMDg3YjQ1OGY3ZmEwYWMxZTE0Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4g
S8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMgfCAyICstCj4+IMKgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGlzcGxheS5jIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9y
YWRlb24vcmFkZW9uX2Rpc3BsYXkuYwo+PiBpbmRleCA3YjY5ZDZkZmU0NGEuLmUwYWU5MTFlZjQy
NyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGlzcGxheS5j
Cj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rpc3BsYXkuYwo+PiBAQCAt
OTMzLDcgKzkzMyw3IEBAIHN0YXRpYyB2b2lkIGF2aXZvX2dldF9mYl9yZWZfZGl2KHVuc2lnbmVk
IG5vbSwgCj4+IHVuc2lnbmVkIGRlbiwgdW5zaWduZWQgcG9zdF9kaXYsCj4+IMKgIMKgwqDCoMKg
wqAgLyogZ2V0IG1hdGNoaW5nIHJlZmVyZW5jZSBhbmQgZmVlZGJhY2sgZGl2aWRlciAqLwo+PiDC
oMKgwqDCoMKgICpyZWZfZGl2ID0gbWluKG1heChkZW4vcG9zdF9kaXYsIDF1KSwgcmVmX2Rpdl9t
YXgpOwo+PiAtwqDCoMKgICpmYl9kaXYgPSBtYXgobm9tICogKnJlZl9kaXYgKiBwb3N0X2RpdiAv
IGRlbiwgMXUpOwo+PiArwqDCoMKgICpmYl9kaXYgPSBESVZfUk9VTkRfQ0xPU0VTVChub20gKiAq
cmVmX2RpdiAqIHBvc3RfZGl2LCBkZW4pOwo+PiDCoCDCoMKgwqDCoMKgIC8qIGxpbWl0IGZiIGRp
dmlkZXIgdG8gaXRzIG1heGltdW0gKi8KPj4gwqDCoMKgwqDCoCBpZiAoKmZiX2RpdiA+IGZiX2Rp
dl9tYXgpIHsKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zwo+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1o
dHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUy
RmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q25pcm1veS5kYXMlNDBhbWQuY29tJTdDZjc4M2Rh
YWI3MGI3NGU5ZWIzZjkwOGQ4NTYyNTRmMTMlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRl
MTgzZCU3QzAlN0MwJTdDNjM3MzU0MDY1NTYxODY1NDgwJmFtcDtzZGF0YT0lMkZyRWdVeiUyRmNm
RmtJNEpITVo5TDU2VUhLRElEMnpIRFJ6d3dCTnJIWU5tVSUzRCZhbXA7cmVzZXJ2ZWQ9MCAKPgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
