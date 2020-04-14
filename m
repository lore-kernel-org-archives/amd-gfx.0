Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA19C2BA19
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 14:22:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4110C206D5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 14:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OwHGYERm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4110C206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E18B36E142;
	Tue, 14 Apr 2020 14:22:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 464876E142
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 14:22:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoYtGAwPhpGKRsrvbDTlB6/MHqkFp2MDdZ0ksilrSwaDrs3tzdarv4hPX4Mnn+igwtKqFTpdfuNsenuF/gwp6Biu2ruHJI4dvv15O1dfCjNZZI5M4BXLao676RvqBrU9vvpnsntY834w3lK8BN+VsOXbST2+pPoxfuAesqsXjGnE/UB9q6/s7rVfiTx/TFlVMmf9vAppDHS3fi+kJYReW2aRK/jeX+ABpfaw6gRUp7cGiDc3B3aTvDnxyk7fzO6XDJKgT+OCCcZeAd1QB/9qgHJs+UbuYzmY3QfapQvs763hHxSwsYZWAMWwelxFPYVDvVvuftBVSdalR//Rr2T9Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQUTJ/UoZQfDHB6AsnkSVCuori7PjEy8+v5BkklRk/U=;
 b=DjDdL8v20s6xkuTUedgG/SIlEklI+x3HreuyZunMILnmuj9mBOGcOIX+tLAx6IBK0sg3U60ndhM2WbhbPDxla1j5/9osBMb3r+KuitUSpxVyfOu9OzyHcSbELll8KtEZIPg3idforqzeyEg65yyATG1KbuK4YfSMR/f1zon4bRNt6+yC5cZ3PEJXVQyuBLudbeJyKyFBf+wUXLmhJkE1JTIPu4809+xG3Qzuz0n+0oZUyvlYNOc5G2Rrm4OoTFSvGuQzRQ8XZMYRm20HMCFf75Ry65oVPHDC6pCPhPQC9wvA/vdOCeLvGHHZCSlEXWVReaqCWL7Bc+29rN/v+xtFZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQUTJ/UoZQfDHB6AsnkSVCuori7PjEy8+v5BkklRk/U=;
 b=OwHGYERmyBpX9/WcZm0s4AbFP3XFlRW54RFLISEph0UjA1PdQlk+uFTsOWcns6nmjY+ohlZtsx5XVXeE9lwjuvG7aFDChWnD0f79rMkEPodt2gJNOYp0ph1GEBwvuakGYbBBLbMnCyR/Z8xRVGsHToY8+Y29eMUi2epnoF6W2ek=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB3753.namprd12.prod.outlook.com (2603:10b6:5:1c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Tue, 14 Apr
 2020 14:22:34 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 14:22:34 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/scheduler: fix drm_sched_get_cleanup_job
Date: Tue, 14 Apr 2020 10:22:17 -0400
Message-Id: <20200414142217.5736-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::43)
 To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YT1PR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15 via Frontend Transport; Tue, 14 Apr 2020 14:22:33 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3d464449-85ec-407d-0305-08d7e07f45df
X-MS-TrafficTypeDiagnostic: DM6PR12MB3753:|DM6PR12MB3753:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB37530FDDF5A77489CAAA3B4885DA0@DM6PR12MB3753.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(6486002)(66574012)(81156014)(1076003)(4744005)(8676002)(4326008)(44832011)(956004)(2616005)(86362001)(186003)(16526019)(66946007)(66476007)(66556008)(8936002)(2906002)(6916009)(6666004)(5660300002)(26005)(316002)(36756003)(478600001)(7696005)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YLyQ30f4+gYI8pLzolPOjPbuVDxQYsBzFeOUZtbgg0cwHc/R6ts6g40alGPiMhMM8CO5y8CXJ8bXVpjVEXTIr5d8dM/nFHBV0p0kOXo86gOT/A1DIZA0hunnpl+9T3tdg908eevTd3AWc+gYN64Vp0r6WBghOl8r9RFW22lbA524KZtZ++o4HCFBBnPXaA+DA6pYwOS6hLkHqlbEJZFSrtum3dR5AVa7uv1zMqHr1hodoMWzks19XJ5/Zu3r27+n981+IFSdvKIqefrtsavzQxo5yDXJZJtws1OqPzZEYVqZuIbnSkge0a1pLNjCrAKkeZXyVRROc9OSYhmWsqnMlUUMlWyrEdKSmUAWFdoSMpuMaw8RwJCs1zynUiSYAEoZQanOJ50pBNnDSvEgY/XcyQtC0/r+DzdDk29OVAJFmKhx3SG8t4SPo0PdXeHIjji9
X-MS-Exchange-AntiSpam-MessageData: X27DSMcEqqTXM17G9fhfE2djnyC28Egr0neACgi40VCAI7wlVXaR7eYdmPPTTXR6+aPRTpxqcMg0ppyXN8TtmkN/VgoljU/ZXe66gjjbCpk6jHubmYaN9fc3dDPgewVwVLQMHZeie9jhPhqqmwsWGA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d464449-85ec-407d-0305-08d7e07f45df
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 14:22:34.0782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KaejktW0PWdn1ku3/qIBgiqWRXQGVVQCy6mAG12EGY3le+MaCZU1OjP7KlJrwibv/iqnP+SjtIDgaQztdracyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3753
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKV2UgYXJl
IHJhY2luZyB0byBpbml0aWFsaXplIHNjaGVkLT50aHJlYWQgaGVyZSwganVzdCBhbHdheXMgY2hl
Y2sgdGhlCmN1cnJlbnQgdGhyZWFkLgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEtvZW5pZyA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTogS2VudCBSdXNzZWxsIDxrZW50
LnJ1c3NlbGxAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21h
aW4uYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jIGIv
ZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMKaW5kZXggOGU3MzFlZDBkOWQ5
Li4yZjMxOTEwMmFlOWYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2No
ZWRfbWFpbi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCkBA
IC02NzYsNyArNjc2LDcgQEAgZHJtX3NjaGVkX2dldF9jbGVhbnVwX2pvYihzdHJ1Y3QgZHJtX2dw
dV9zY2hlZHVsZXIgKnNjaGVkKQogCSAqLwogCWlmICgoc2NoZWQtPnRpbWVvdXQgIT0gTUFYX1ND
SEVEVUxFX1RJTUVPVVQgJiYKIAkgICAgIWNhbmNlbF9kZWxheWVkX3dvcmsoJnNjaGVkLT53b3Jr
X3RkcikpIHx8Ci0JICAgIF9fa3RocmVhZF9zaG91bGRfcGFyayhzY2hlZC0+dGhyZWFkKSkKKwkg
ICAga3RocmVhZF9zaG91bGRfcGFyaygpKQogCQlyZXR1cm4gTlVMTDsKIAogCXNwaW5fbG9jaygm
c2NoZWQtPmpvYl9saXN0X2xvY2spOwotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
