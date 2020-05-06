Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9467C28CBC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 03:34:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F9F22073B
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 03:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9F22073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 320296E112;
	Wed,  6 May 2020 03:34:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AFB96E112
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 03:34:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnEPpbhUp/iYDZD11JC8gilqJ98dfx5vZd1+oAkD/RYiLnMEdRnA0bu3iBMwXZBwcOrShlwq9LoO3c8+tKp4fiatiLOw97kbmyi9MxouTu1PNth9nj15+NGMMhHHIHVTc+fYdUL0/2jCVJgJuuBfyj3jrfZw3SLOhZCOCCuEzo87WfodgYKTQSoRV12bCMHwy0lXpAlJcxEMZnUM0ti+vcEIlrFeemkerkX8f4PCCvsXwBd2JDDnRPZ2yY37mzVl6iiT2SQcPpNz85Uv0HPBvfLxqgNS51ywaZbMC0dqYkfqIn3EHJYOjmcIcru1ejd5tQqMC8Z5BpXeyw3zUGWx9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yWCXlan2P0JyCoDxNOkXeEWCnuroHRvJzIFWAaQd0s=;
 b=GWNfWbyAKYLzJisaueuKr4mKaptwVv0jKsfxlWoKDZH7gH/YsMEy1wLZdJ+UyM0/s2DYAkM6skjjUQ85yrKMEp3/iQHm1Bfdv16nF1DjaYNPw+qW9MnSRVU3cUXal1Cscu6H6HgAz/sgvA87JbS7nV4zKgUlBtJ+zxqLTn/eMtA4ANihrdqn+KhS7JvgSJPl9obhW3gk1OznOcP+S2HKap5ZL844LwS7jex1ovM8HHmibUHjLj4imfh3YD9baUfd80JuY7IjIZ4UmCzrJQ1sd5Icvq8k/L1N15kh18X5d3te7a/plPG6lo1B2tTaiADMrP9ove9DPTHfmEZQi2NCLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yWCXlan2P0JyCoDxNOkXeEWCnuroHRvJzIFWAaQd0s=;
 b=26SMUtDBKWwSN0Cce19wx1YIIUQVUG5xys+2bcltZYeg+h+jkEe/s2Iqh3FZuNBMsiKsqpdNw/GaaHEuyaqlcI2m5IKFbkHuReFgmbwnYLcrTeeFL8ZMk1nWpP1hfblAijoUKQm4uPECR67m4mldShpeDkvbgRSjLL6Ta2cEW30=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3466.namprd12.prod.outlook.com (2603:10b6:5:3b::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.29; Wed, 6 May 2020 03:34:03 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 03:34:03 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: address the static checker warnings V2
Thread-Topic: [PATCH] drm/amdgpu: address the static checker warnings V2
Thread-Index: AQHWHc9eAXt0RN+DB0GckQBjhhv2aKiacq+Q
Date: Wed, 6 May 2020 03:34:03 +0000
Message-ID: <DM6PR12MB26198B78157C046901D23660E4A40@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200429023847.1321-1-evan.quan@amd.com>
In-Reply-To: <20200429023847.1321-1-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=02e75b01-99c9-4e2c-bb10-000040d9ff5c;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-06T03:33:48Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6133468b-0acb-4488-a0b1-08d7f16e52aa
x-ms-traffictypediagnostic: DM6PR12MB3466:|DM6PR12MB3466:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3466A4E858519AF3A5DF8344E4A40@DM6PR12MB3466.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ++Np+qkVfC9Pv3KtaVcxp39CnEFAYpNLGLe/ijYe2KmB/jGNp+CsEerpuchGZqpJaTsZlh4sHIh3/LniqekKcqk0E4v8XD2eBz1x+N2UBd0pUv2GSqmWFaZ48FbKwNELM0aqYDBRUi9ihpf2F2PJPLIei5eu6vHDcTNVKGObolXsvXTW2jIBSp0uultVWwgYKYKYmvYkedPbHAOZSAnuA2CfMqeK4SN6wHg5vEFiS1Mi11B7Is6G+iBsOc7nIzIVdWpKi9SJvbkj3AX3F8j0/MLaVKZahkNu4W4FPwlgkRS6JDgfErSAI4Q/jXbUhHZ9vcVZyQnp3XvmBW4AqqRaQaQy7cgsddWlvXnqCcpUP+OFXg6rpFYHZ9ku82l1WY7IZnDaFyLA/YOqFqyupH67++tvRwvUuqxr/vItvl/3J4QsdVp+T11n72wDFT7/eUk/ql9E8jLJ1Sa8a64s1lVB1eGf+yQcLvauYhtf4JyGLvhVSrMx+NQnCT9bb+d9OmR3eGQirMS3Bp3UyoyZJw1DCw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(33430700001)(54906003)(316002)(478600001)(66446008)(66556008)(186003)(52536014)(26005)(66946007)(64756008)(76116006)(66476007)(33440700001)(53546011)(6506007)(86362001)(7696005)(4326008)(6916009)(5660300002)(55016002)(71200400001)(9686003)(8936002)(33656002)(8676002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 0aQafUBUkM/fDbwfxdqfOehUR9mzQyfBF3NUONZ0a4Bl6M9zeYt01a8wpqFRWSnlEuqYxRIS+CxzVsooipuigGnhaYmzFSBcbcsolE4h+l2YvGJdMt36PoscSb2Zy+Vybqr8mSpZ9CVbz4/H25BPWWoFymM5+3er7vakRO4OkcwY1hwvyKT5DMHVicELMBI0Cy46PWIGJSYKKUv6R7muzHcNUsixhQom5Ra2N8chldOzbioIqhjyoS5EnwCYNrz8dRlc2/dFGUk0aImsrWjnifWwXekAN/L4EmxmwdaX6Gjv9NfPwQBEujeqt2PsSKYx88LYUxSCRJFb2fskVdzKMGSvgo6cB9aPsnMyBhzKNAhDk1UjDj7PWpr/6/TEH1yDHgOHGnytGW4ZzYgBcEL9mhCxdymxpb6XQPnpkESXbxdz/Z4aWX8RyukeX3I+Py8ZGZLyexKUTYv6r931bpzsT46Qol1Z7nrisQ4lXnyJBGT0010Bji5GMm1Caki+x85zsXM2SC0/NVJcy36qX1s6i566ZjGkbw55M2rwn/mua/l2LsAC+VEnQaFrigEdnF5612msbJ7oSUXPsl5U4Nf1lfQQSaLBzmWELh9zbCXG1YhieLLW2nrwtIA1KLcZGL2xhzTnGxyx9auip6RL7jAGYqv4/jTd5fZEZmsnfObpoCVDpqZhPwpU82LQWZx/LOES7NSyqnXyqDflkil45mGaakvQUz4r08d6iQpf4CPfPVPmblduUUaloVlJVUNUeBkyutKcghszmTLaWO8+fZRQOl0DmweLM+yc/FXLkcaCPfk=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6133468b-0acb-4488-a0b1-08d7f16e52aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 03:34:03.0886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JGfqj0dWCDUOiZwi2aQ84l6dxhZ74RnLkdhzy+ZdK50X+OtTcBXuYZg86eFo6EdN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3466
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Ping..

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Wednesday, April 29, 2020 10:39 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; dan.carpenter@oracle.com; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amdgpu: address the static checker warnings V2

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:4199 amdgpu_device_gpu_recover()
error: we previously assumed 'hive' could be null (see line 4196)

This is introduced by "drm/amdgpu: optimize the gpu reset for XGMI setup V2".

V2: drop this mutex release needed for XGMI since XGMI never fails on
    this

Change-Id: I9c22b57abc9f512114112f93fb035f1fecf26beb
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 71278942f9f0..900c636c64be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4274,7 +4274,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 if (!amdgpu_device_lock_adev(tmp_adev, !hive)) {
 DRM_INFO("Bailing on TDR for s_job:%llx, as another already in progress",
   job ? job->base.id : -1);
-mutex_unlock(&hive->hive_lock);
 return 0;
 }

--
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
