Return-Path: <SRS0=Hy8X=AR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A59C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 11:40:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEAEC206E9
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 11:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2rdt/saZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEAEC206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A2A489F8B;
	Mon,  6 Jul 2020 11:40:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D284F89F8B
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2020 11:40:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRscnbLvxeYgqUS8IQgB/7LmCgA/S8esOzLQAyiU9Djh1Tu7qFC6IriIYsjZP57b40d4tuxU2EqhkIW3ceEB2Z6OJg6vGyQyJM9h5YSbMVtzOD0QYqVSz0fHpeQHj9C2BmIN3ApQyyl3NerKEyEnV/9f6vDV6PoliwIa22e4FkwaEi+LM+dPhlGPppiXot8QaK9GnsyBUy4j6m9mkKmjWpn2QCQlKQWDt9zvIgYp/DjzAoPKJlN+Ie98InKTPEI2rwqx09GJOCSnGW+7w47xewzjsOwewVH3QcWLyN2j4GrMmR6qD8d15gVz0cHV+YF6SBf0ihvA6C7C2FW0c82E/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTNKbUQNwxUpcEZmXEPrafkAihukAxZz9TKHmlo+eA0=;
 b=gYnIAjs8AOJo7mq8Qybn2M+lOPD25v2DvocSJrPlbkxtl0irKgWCYNiC5JD+X57ZanSSSd42b3q6Cv8TrnYRNwjvqQOht7n9A2mUeXyBvCOv+cT5caaDBG8UjiZIoHVo2VZAlnt2ihj/R+HUfEp1hIXfkvDK5lNb56UWthSUdOhiejzMaNmxCsWAWqbwD89RZdCCt/gmd6Rc68NzTVnBYGCb5qmwRiVozt9E+4lY97h4bUvl6AgNsMZJ8Znk7dLLDBOt3CBTXffr2owd6OyrZA/qtj/+7hkdac9TijCfDIm7LRqC6mEmX8I+cUlfreIgRdVvO2cD5TAoJ1fwFVoKyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTNKbUQNwxUpcEZmXEPrafkAihukAxZz9TKHmlo+eA0=;
 b=2rdt/saZinYvKu+3LVB5GLSrqa63hJfgvbO0wpp3ZgiHWCPPnVqCmTmiiiYeyxhUASqLQx0A5fjvdQRGKjyv56GyomkY+Gpsjga+urEr4TlGLJnJPZdm/Tbh6iridZLlZ+UqTJfmGKSUxBp/XfYad5PZ8FT3Vn6kuM4tUilGUYs=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3177.namprd12.prod.outlook.com (2603:10b6:5:187::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.27; Mon, 6 Jul 2020 11:40:09 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::81eb:c31f:a63a:20eb]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::81eb:c31f:a63a:20eb%8]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 11:40:09 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix coding error of mmhub pg enablement
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix coding error of mmhub pg enablement
Thread-Index: AQHWU3w6QLvOm7aOrUKmhEzbpAGvUKj6bUww
Date: Mon, 6 Jul 2020 11:40:09 +0000
Message-ID: <DM6PR12MB4075AE5A452084DAF0C444FEFC690@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200706095933.2952832-1-likun.gao@amd.com>
In-Reply-To: <20200706095933.2952832-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-06T11:40:05Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=cc4dd65b-58c9-48b2-81a9-00003f7bb1e4;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-06T11:40:00Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 2ff734d5-b18c-4ab0-b12f-000079b12673
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-06T11:40:06Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: baf8b24d-5493-4d91-8d35-0000341c1c8a
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 293c73d2-72f2-4ef4-56e9-08d821a1562f
x-ms-traffictypediagnostic: DM6PR12MB3177:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3177222DB024BCC493A0A095FC690@DM6PR12MB3177.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A5yTgWFJNBtahUxDqhFOc1R4yVrKj8aUX7pKUsTfmXFksFTmJmKmkeQALuMElzPdAzs0WJF8wAlbQYhAAj1wctuceifxUcCZjP8HfQsBmEijfzEV8igkEZ3tJRhLwXpP9E9dHqI6n4wilBiInFYqnOQrwNG+dXA6k6YswOHm9VQAFyLd6J71bu6TzmF6OvChDILOO+B05OkmSEPp7gtiYCBDLadlXCsCJl2JCMd5hpYz0qRzQLMF3otHUHywp7XJaV+wKaCuFnhAJNNS6CGq+4rHr7JdXnRRajV+XKhAqa8ayDDfAHjNPMEp5qrbFVa7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(52536014)(9686003)(66556008)(64756008)(66446008)(6506007)(66476007)(83380400001)(478600001)(53546011)(4326008)(7696005)(86362001)(76116006)(8676002)(5660300002)(316002)(2906002)(186003)(110136005)(8936002)(26005)(55016002)(71200400001)(66946007)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Xn690u3PupyVvyiri4bh3eug+2MslkKC4bn76WEm+kglIP5jPf3ZzOQhZa4f7HgqD6wr+xPsb8vkHDQF+Uzvxh+hrTjsROG9gwIGOdYBEUYHVSlZTsXBuc6CgJ71pqwYGMk9LMD30zmg6iBNo91fA/DfvN6iAggD+RU8GL0ibv6oDym+q8kFIxsvbJ18IZ8xnTfsGwGxs/0VPFJFPKy7lOOe1wHPwxHsC0Fsy5w6PKhu9lip8PKMa/e1mADv3HCu+ySFgAMFNqqDS24FCuddkZ9VXOLcve134MDpOTpNa37yiXgEukjUBnNKm0r8YY1ieRReAId6Ap+9bGmw2JA+w7onHXTFRZ700fpijUThoP8zk2io40Yv28eYHZwGuYeixBgoDlquGE7Td0VYGzTrqfvSHFhIXShGnavmJUU80TB/8YmKlFxbGcjlGuutY7mrZwKiX8dGm/ONKElXRu4+0Fj7GKJBF/Bn8H1QZKOc/r6URrKEcOLM6xItnzCuF6Uh
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 293c73d2-72f2-4ef4-56e9-08d821a1562f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 11:40:09.0845 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zyCG2oyH32cRxwokHQcF2LPhhwkhf6Xde1Jt9S+INIxdxXccEoF8uLJHk/ADgq3pBkpCBZJ36Sa0k0uaIeG5Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3177
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Monday, July 6, 2020 18:00
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: fix coding error of mmhub pg enablement

From: Likun Gao <Likun.Gao@amd.com>

MMHUB powergating should be disabled on navi12 and enabled on sienna cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I0b0e6801408df3c13322c4f9ed8e13b6ffc9ec25
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 4b87506cb005..356849136d1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -707,8 +707,7 @@ static int nv_common_early_init(void *handle)
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG |
-			AMD_PG_SUPPORT_ATHUB |
-			AMD_PG_SUPPORT_MMHUB;
+			AMD_PG_SUPPORT_ATHUB;
 		/* guest vm gets 0xffffffff when reading RCC_DEV0_EPF0_STRAP0,
 		 * as a consequence, the rev_id and external_rev_id are wrong.
 		 * workaround it by hardcoding rev_id to 0 (default value).
@@ -731,7 +730,8 @@ static int nv_common_early_init(void *handle)
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG |
-			AMD_PG_SUPPORT_ATHUB;
+			AMD_PG_SUPPORT_ATHUB |
+			AMD_PG_SUPPORT_MMHUB;
 		adev->external_rev_id = adev->rev_id + 0x28;
 		break;
 	default:
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
