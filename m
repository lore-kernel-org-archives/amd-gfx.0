Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6759DC352A3
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 07:42:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3054C206D7
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 07:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sPjA+iZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3054C206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A31A86E2D6;
	Tue, 11 Feb 2020 07:42:49 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770085.outbound.protection.outlook.com [40.107.77.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A817F6E2D6
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 07:42:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHqAC6H9eIhd6WWTpRMp0OEIyI+zWQ19Eibdhiw0lIqZhcMvsJyMwr45tNU4zPyE8+mM4bLtaKy07dATCDSZraLqxPz1maHRLXuIlOK3KowjMo8cpALTiUZSDGaDPBbzItHE2EWjC5wFy+znZQ3sW4J3WEv6jBbvdKocQNPmdLgwy2t0k/XVUN6MME6K3lr/59Y0V1WNsZghXyu9vYR8LFJYxRtgsldkzohQGi35A4vQjoOIjqipZlbrQbTGNHX2ox7Xs1tCXsadnYMITHUODJn/MXHkObNzstMTKMv1AFVX4u1ezWUFrVnggZwMskATB6UzalaPioc926sLfsKUHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1waPuT86Fb26LuXHMUTs5jMLyJl22ly8xu2/UwdKRNA=;
 b=hhsavqGPLks6+nbLyNhsJXRzc2rLmytJBgBi3jv2y2WyJCGIdzJDMAc4e5xhO9XYkKGvw7Fu81+4XR1Mi5SiXl007Vec8FKM8Rm23YIn14ReaGJt55CjwtKNcbkGcDg/kxnt+sLCybpZ1jwM0uoPG2iDoa21e1CKIwLYKchTgZnx2OulWap9jDp6nlFAKUXHRWtgKaiZJ2rktds3VeB1r5yZs/PiXV5il5Crp8x+fF0RH+wd3km4hpDr89+wNEtTgFnctnXzTLO6tUG7e1ABL4rpGCaIrTNpAUsbdB5tTuJdICB1sGNAz168bza4oSteclax0ZcZG94jGMPtJlBYHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1waPuT86Fb26LuXHMUTs5jMLyJl22ly8xu2/UwdKRNA=;
 b=sPjA+iZ5u1aAtJBHcVJFnzHflEIAr03Mz7Aq+xBEFiHm8/mMH+RGRXQ/2NRqp9QsRPCwgkJJYGzEap38O3bDzcUS29tqvI8o37ePIylY/2ZppU6ChtpCL3uazgQ988lKDTBwEF0ksziHzPK/g9WfOTqV+9QxgbhnqcULX2YGBkQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1483.namprd12.prod.outlook.com (10.172.38.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Tue, 11 Feb 2020 07:42:44 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2707.028; Tue, 11 Feb
 2020 07:42:44 +0000
Subject: Re: [PATCH] drm/amdgpu: correct comment to clear up the confusion
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com
References: <20200211041607.9828-1-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <c3a64b5d-111a-98a8-6aaa-bb7a80135f29@amd.com>
Date: Tue, 11 Feb 2020 08:42:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200211041607.9828-1-guchun.chen@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR08CA0058.eurprd08.prod.outlook.com
 (2603:10a6:205:2::29) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR08CA0058.eurprd08.prod.outlook.com (2603:10a6:205:2::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Tue, 11 Feb 2020 07:42:43 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e10f6060-e49f-45c0-dc2e-08d7aec5fb2f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1483:|DM5PR12MB1483:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB14830BD59DF748E8C27C5F6083180@DM5PR12MB1483.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(199004)(189003)(2616005)(478600001)(6666004)(52116002)(66574012)(31696002)(2906002)(186003)(36756003)(16526019)(5660300002)(8936002)(86362001)(66946007)(8676002)(66476007)(6636002)(6486002)(66556008)(31686004)(316002)(81166006)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1483;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YGB2MasZNywbb5TvlwbcPZWqp4jKLeYF4ik2xdIFV156KpzaIhPpT3tGH71iXOD9GAltVkTPwXsShDpOEsovZ2zHTDbWJ1l8x81Mbi+QmnFL9+kELC49nIlpFBBnaW7vmaYoLiyjyxlXWLFMEitHjwhp4eT2lDBSeMZWM+SeiZwmzhFA67ZAzuD/rIO2XiTxXYMXJZ+NdaHpkzcKE6CJZC4bYgrg4mPhqgJVynpfK2V2Sr5L/7+4fAwrHBDtM35N5VC1YWwK2WvEL7Mfu8KnRuCw0aF49PvjgAweIWKU6F6SxqcOyoVXF9nnajtYandtS/XtsnpCThWdJ9TeETUNOSiMO8QG2QelYzxFoqXNvsYT8CUjguAt+pFO7a1X6nJFK1yW3sghfpHLWeVACJgCbjP+DONuxGMTvtSzTmVuMYXGPc7fFbcSmhJdM7EglKk0
X-MS-Exchange-AntiSpam-MessageData: uP0wFCBszhA4iGTGG7R/5GTg6uZEbnQnFtFEyphaSZrjPPEeq70dGr0J0ZLWU9AU4cGmdlDxk2jTvlAWaef5hAWc2tR8iMCer9cuZPmwSaYtkdWmjhm8vCWDV7ofCu2lNwbVK3Su4LZBKluFQbJ+ztOgzZ4r3JOWVFmX4PRUoG5vt2Xcix9T+edf5rdTcZdYgXc7icnIcJQoDGeDdABG6w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e10f6060-e49f-45c0-dc2e-08d7aec5fb2f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 07:42:44.5561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZZxgr5FgrL2c4/eRx/+nQJEDu8DoyL7s9Xi1Kekwn3b7+8zmm4NGsJPAPj6teur
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1483
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

QW0gMTEuMDIuMjAgdW0gMDU6MTYgc2NocmllYiBHdWNodW4gQ2hlbjoKPiBGb3JtZXIgY29tbWVu
dCBsb29rcyB0byBiZSBvbmUgaW50ZW5kZWQgYmVoYXZpb3IgaW4gY29kZSwKPiBhY3R1YWxseSBp
dCdzIG5vdC4gU28gY29ycmVjdCBpdC4KPgo+IFN1Z2dlc3RlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEd1Y2h1biBDaGVu
IDxndWNodW4uY2hlbkBhbWQuY29tPgoKQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjlfMC5jIHwgNyArKysrKystCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMK
PiBpbmRleCBhZjM0MWEyNzJlMzAuLjgyNDc2ZjZhY2ZhZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3Y5XzAuYwo+IEBAIC00Mzc0LDcgKzQzNzQsMTIgQEAgc3RhdGljIGludCBn
ZnhfdjlfMF9lY2NfbGF0ZV9pbml0KHZvaWQgKmhhbmRsZSkKPiAgIAlzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWhhbmRsZTsKPiAgIAlpbnQgcjsK
PiAgIAo+IC0JLyogbGltaXQgZ2RzIGNsZWFyaW5nIG9wZXJhdGlvbiBpbiBjb2xkIGJvb3Qgc2Vx
dWVuY2UgKi8KPiArCS8qCj4gKwkgKiBUZW1wIHdvcmthcm91bmQgdG8gZml4IHRoZSBpc3N1ZSB0
aGF0IENQIGZpcm13YXJlIGZhaWxzIHRvCj4gKwkgKiB1cGRhdGUgcmVhZCBwb2ludGVyIHdoZW4g
Q1BETUEgaXMgd3JpdGluZyBjbGVhcmluZyBvcGVyYXRpb24KPiArCSAqIHRvIEdEUyBpbiBzdXNw
ZW5kL3Jlc3VtZSBzZXF1ZW5jZSBvbiBzZXZlcmFsIGNhcmRzLiBTbyBqdXN0Cj4gKwkgKiBsaW1p
dCB0aGlzIG9wZXJhdGlvbiBpbiBjb2xkIGJvb3Qgc2VxdWVuY2UuCj4gKwkgKi8KPiAgIAlpZiAo
IWFkZXYtPmluX3N1c3BlbmQpIHsKPiAgIAkJciA9IGdmeF92OV8wX2RvX2VkY19nZHNfd29ya2Fy
b3VuZHMoYWRldik7Cj4gICAJCWlmIChyKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
