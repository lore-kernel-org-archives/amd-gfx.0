Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1BFC433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 07:27:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C29620781
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 07:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RSIlGB62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C29620781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 055C96E54C;
	Thu, 13 Aug 2020 07:27:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D34006E54C
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 07:27:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ji4MqsafpWK7DMZ4z8RNPQimez0EpbkYu8LalfqHg3A+3mM4epxAYmI4JTVXhLyno6SX5biDv6b+1jbQW8OjpyBDGrwN50cUeU43XnFF2j3jJET4GJEx8/JNQo9GQldxyh+2OzNLW3Hl+/lnFiZJb3F6324ho4Jd7WaGtlCRPIdqwnsj86aWBTxjoMCwaacaZC1mQ4szMQKAjejOVOv4THdc1GU4VapSYiM/dSX50EBvU2dkHxZz0HDDq8i3mDovpZ6tCB2MkEqjI+5EGjKmAKVeWDiCXJILjaMaPyVWfF9d5kBvFjDU1TmVePth1FClRmPb9UHKgzHPFX5NEXbkCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtB9AZ8JDb8P9AtFZJ/J32ehca2o4IEl/y74rm2nebE=;
 b=gSKBrCJ7+GAmCUShIpGDdnL0YBeRcnC4gHWDWvkaCbbEbh/V92ynNCqUYQgy8b9/+G4sRWYYe+feWuH8q0CZfDbrJ9W/JXyOW6BkpnD3Q48/4/MVC6d5C6I71pyzElV7Z2+wq0q6lSKOnkrvJaZ5t65Wt/nmvyMedL6y/tCd37ucj0OIa7HOjUPiCRdYzSCqiRM6lydq3hXsyFsaOf1SPSRZyNmdeY3EBendD7BmLvayEJyl67D5Icsjb49dVl24plq8KoAS6v/gccQneUDUFaYvo6QlGgrY5DevXGHhi7a+JCj9Q1u7k4JtEWiIuer5wSaTr+H/ke+HvZyKNaF7qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtB9AZ8JDb8P9AtFZJ/J32ehca2o4IEl/y74rm2nebE=;
 b=RSIlGB620SSKCVSrZ0oYRGh6bt3P1vquAa12AZlzeiJo7LSTXB77MNur66nqznhh2gRCbt3Q/32u8085k9c+RweNPDY4cRIPLkNYuPOR3MsranDxMjPe4aT6QYbYuySaM15p3+XXP3KQDfHwolrPX6Jp9Phd/oKYFWus8H4VQuY=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM5PR1201MB0139.namprd12.prod.outlook.com (2603:10b6:4:4e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.22; Thu, 13 Aug 2020 07:27:08 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63%7]) with mapi id 15.20.3283.016; Thu, 13 Aug 2020
 07:27:08 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: guard ras debugfs creation/removal based on
 CONFIG_DEBUG_FS
Thread-Topic: [PATCH] drm/amdgpu: guard ras debugfs creation/removal based on
 CONFIG_DEBUG_FS
Thread-Index: AQHWcT/2pmaNPr9GvkmyNiMjnN/mJKk1o51A
Date: Thu, 13 Aug 2020 07:27:08 +0000
Message-ID: <DM5PR12MB253390347668CD2F7F483592ED430@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <20200813070359.31132-1-guchun.chen@amd.com>
In-Reply-To: <20200813070359.31132-1-guchun.chen@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-13T07:27:02Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=6b76bbec-f45f-4a8e-8ff1-11c75795cb1c;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 40b8070a-d8fc-4191-6ddb-08d83f5a499f
x-ms-traffictypediagnostic: DM5PR1201MB0139:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0139C832FDA6D23E4E6818A0ED430@DM5PR1201MB0139.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ihvdoQb5hgFqvpdUyg+00fvDZh6+bzmnG8C4VI7OkIskU96WYFGJkHa8Ub3FDiIaTjjuKb8sPcltHfJ46wTGrKRlBq7p/XE0C2As/ufQBROoSstA9C5FTwW1GLNE7J9uFkwEkUtyy30Bv5frDuLkInBQVZRTeF7gnxcZPMN7DhdJ7rBRCHnro7LyZoyjv8ZT84friguQsn22+gPmSXLXPaZpd2iUYXSRqV5DOrGhDr3Qnf0dhT5q3fmtWb95au547nwFIie7wuk4OFvApF4oIyHB8x0mzndc+Zexb6sfROjqQbqcwfvv4w/DprDF/jyfGHaduOT95rNKQDPKiMFUDd7xKbyDd4rnRCz2tfFToehl/nrCv6822CjgGYwhS4Zx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(8936002)(8676002)(6636002)(86362001)(478600001)(2906002)(110136005)(33656002)(83380400001)(76116006)(6506007)(186003)(66476007)(66946007)(26005)(66446008)(66556008)(64756008)(71200400001)(52536014)(5660300002)(316002)(53546011)(7696005)(55016002)(9686003)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: JG8anRm91YECUUg6jSYNwELlrBSADqKGLsOpCldEd37OumDLmhEYMa1cT00YQfa5hrXej1ToteWdsaLn99LdHxzKNp+RIHAXkrtr5w7wN3f3Bt5FKfXPNjWBxFL6iWI43Jf6z1N/pKOUXqLSSh784ndeinR94ifFdAJAVbb0ACUnrxqoU3PmCtCqNAzWIfCVeKXlINxQQlT7uu74Jp+tkFwc76KLl2sbuA95pfJbN7rnKeAaFuVWottYbKbyye6AI5CedQGf/vyO7x9SfuhAE0rvuzz46xINOeMXkHIIME93ka8wBH6ipFLI5NXjeEfmwnnBlKPjpVAGz5n6iN0CbktAzF8TzH+CCtzlFX0N7/5ZN9IJkiNUOSh77Ks3BofJkxikj4a2uMPz0RwJ8dI9p+kzrlM1pGIyqxwqOm39bqOm6BhTZEV2tUNS+HrQcfcIqgQ0P3ZeutDxdKtLL7Kp0zgnDKzLfJwe/3a0CP8YfC0ZqLa0EMiOz8kPQH/TBCBiNBPb/TAtY592PJnAVPRYd2ZF9CYA+WTgd5981Xih1FUBcX25E/RCLcpuCa4O22MPSxS5ZqSxckD3ExVZFmvyKw0tNKVcgG1ijtGeo7k9FaTKiXnWDG/emH3eafngEnnFQJ+364ezU10p8ybHbgaKnw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b8070a-d8fc-4191-6ddb-08d83f5a499f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 07:27:08.5927 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7+nlfx+mwHiNk1qyfHFtIDRHePJzRiPLOPanQhNINDWhy25f787FdUtSzVb95AEO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0139
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]


Reviewed-by: Dennis Li <Dennis.Li@amd.com>

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Thursday, August 13, 2020 3:04 PM
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: guard ras debugfs creation/removal based on CONFIG_DEBUG_FS

It can avoid potential build warn/error when CONFIG_DEBUG_FS is not set.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 35d5bf9e6f6f..e1d78cb448e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1244,6 +1244,7 @@ void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
 
 void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)  {
+#if defined(CONFIG_DEBUG_FS)
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_manager *obj;
 	struct ras_fs_if fs_info;
@@ -1266,6 +1267,7 @@ void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
 			amdgpu_ras_debugfs_create(adev, &fs_info);
 		}
 	}
+#endif
 }
 
 void amdgpu_ras_debugfs_remove(struct amdgpu_device *adev, @@ -1282,6 +1284,7 @@ void amdgpu_ras_debugfs_remove(struct amdgpu_device *adev,
 
 static void amdgpu_ras_debugfs_remove_all(struct amdgpu_device *adev)  {
+#if defined(CONFIG_DEBUG_FS)
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_manager *obj, *tmp;
 
@@ -1290,6 +1293,7 @@ static void amdgpu_ras_debugfs_remove_all(struct amdgpu_device *adev)
 	}
 
 	con->dir = NULL;
+#endif
 }
 /* debugfs end */
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
