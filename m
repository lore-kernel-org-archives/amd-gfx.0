Return-Path: <SRS0=VPxi=76=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B792C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 20:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0F7E214DB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 20:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hncCSkPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F7E214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B54356E17F;
	Wed, 17 Jun 2020 20:27:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED68B6E17F
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 20:27:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5f9YTFM7FF65offBrEe9jCAcgw0O/5pdbbLV2iK5ZA6OLpXx0ARTUurR+r5qgUQrjxtbakvB93UNMRLik+XJRcGIrIq408MCEZtKI/Y0rWLOdN2tHoy8wjTQe5JoY4xnXGATtD6qBPRKTAPwydiMVL0yoUe8DcVjjirCKZZXhMyN+E/lf9f3l0grhIX/CVPnkO2wgEKhv/h0b8dxCrsxJ2Q+H66ryxrg1YmiqYHCbMbCytgEvmafPVFSfkW1KGWn2vrOAoIR5RomCoKUoZSu7qG3RPHFKI425UEdHtiJx4AJHPMuZ9borwbtDu0iDBHUUwaSKD/oWSVqmc2l4I4EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bFRlcKhjxJSWFXzz5sIt+LcS3UgVsScUNblmuOy8ls=;
 b=j+PTIcQXnk4qTA8MEVFSBkXCos54BbS6D13Vy1PCimWCkYMieIefmmxU4cVPQ5JtB1iCIs1rPNfQYNXgG1QP1QF8Bqpz9MECP7pdghF4mgrbRhtE7JSEhlHhzq6ncsD5hv/l4bBxAjqzrVUyV2nH/+pUIor8YcYrhuvhNMcDF5pFiKjQAzQ0nWAx/s8JMcsGriBoh9L9IzTKYFmuY7v/OTzpaov/zX9hy8TWh8t2/sKeOSEw6tg3Xn81rLVrrgmt9Fu76/vo2Pb2G76aJUTGbHpKFHvTUII3a9rD9iu8WJjgdeZoXtcLi6dQKhbAMxpMHts+6itGFg8r1ajUqGe/+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bFRlcKhjxJSWFXzz5sIt+LcS3UgVsScUNblmuOy8ls=;
 b=hncCSkPRgcp8cSqAHLX4NwJU/4ju/E+rdpXJhFn8Vl25W4HPF3R9J0+9TbQPIjqYMU+uuO6pmSFTjz5RiRZvjbogZjNzib1I/ON6dls3vaLfmQC3Zf4PE/oPF/nkBkZvN0m+nXH1WbSlfhB9Au856hKtAjtJDr1NFugR7VKT4P8=
Received: from BN6PR12MB1155.namprd12.prod.outlook.com (2603:10b6:404:1b::17)
 by BN8PR12MB3026.namprd12.prod.outlook.com (2603:10b6:408:41::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 20:27:56 +0000
Received: from BN6PR12MB1155.namprd12.prod.outlook.com
 ([fe80::6c17:115:fa26:adf2]) by BN6PR12MB1155.namprd12.prod.outlook.com
 ([fe80::6c17:115:fa26:adf2%12]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 20:27:56 +0000
From: "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/4] drm/amdgpu/fence: fix ref count leak when
 pm_runtime_get_sync fails
Thread-Topic: [PATCH 3/4] drm/amdgpu/fence: fix ref count leak when
 pm_runtime_get_sync fails
Thread-Index: AQHWRNnbPStYGvlf10qIgHeJTmpNsKjdQcsA
Date: Wed, 17 Jun 2020 20:27:55 +0000
Message-ID: <BN6PR12MB1155BDECA1EF5732F4F28914FE9A0@BN6PR12MB1155.namprd12.prod.outlook.com>
References: <20200617190212.3519907-1-alexander.deucher@amd.com>
 <20200617190212.3519907-3-alexander.deucher@amd.com>
In-Reply-To: <20200617190212.3519907-3-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-17T20:27:50Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=983f0840-0b11-49fe-9516-000070ca4169;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-06-17T20:27:50Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 54d96c5f-3434-4e94-9499-0000b640da30
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [38.121.83.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f7279fc-7012-4efe-fc29-08d812fceb41
x-ms-traffictypediagnostic: BN8PR12MB3026:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB302640FFEA7E9B40F5DBB296FE9A0@BN8PR12MB3026.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WNgLtOiCba+RRUUgb6ZOHV0rjmF+pV3/yp6YfzQXn0p5wRyUDcVol1ojVdNyRN6+NQxhCk4eoFfc5JKKFw86zAK3czmDTnReHB7SBxfE7TW1aHM2njjAU/g/g7XxedSa21OxNZ67Nnk2wm7ZTKJN9pl3U8LHzD/nf9qh57geoAGc9T5e+aCOwcP4HOcNl0umOdYYnHdmbDXkwJ85x+PIODn5yH1ACDVgkehMLedgaAD1CbiLZ3aIGEws/H7y5B9TRWz0c1tDZEW4+S6vl8Ky2rWX3+kTDv017FK19t3nJEZ8e6+sriIIe3G8KVuO6XZZY42fLMMUjDNNIRNCBrZh97awY82jDxV7gNV/2/MfbP8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1155.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(52536014)(83380400001)(45080400002)(53546011)(478600001)(8676002)(71200400001)(6506007)(8936002)(86362001)(7696005)(55016002)(186003)(2906002)(26005)(966005)(4326008)(316002)(76116006)(9686003)(33656002)(64756008)(66946007)(66556008)(66446008)(110136005)(5660300002)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: kNMwXCrp5YwSIxn/3Wc8Hu3u2FJfnil2csxst0KwkY+DA4bR8bff6uKFKF8IkL3+A+1NgoYXfTlBh23OevUGksEcKRbh3CKUp+tkg8fyd+LvpLbvQY/D+AdPILMZfj9HrwaDpDtNp5U1jtlMOY32eOea2cdT5K1j4YPp7S7TLAFdH1qDEDpfXyhMlGOxkngVViTGHZH71pqUb9mFI5OHPgtalq7fFI3h3ykFEEzQLEaFYEAbIZx3x6D0c1y6YzWg8UXeOqxHO5h/YhgvJh/F/CNnAvhF7ulqX5dhvelcMy056xkt49Gew1kDfWnmDYkVUAbYXAXqQ1ovCOXQZJ0TnrL5VB0NJbxqoeaotKR/fbx3Io0RfwZmbC8t/gHOS4jcHfRKLeGQqC9F4JpjYXu5JZbnY21W9GCkXZpY5aZ/83MH2o32KO8avzkS3vqt9z0bL6Kkhg8McnZNIqeR5TI/L4ZuWodJLI18UqXLT12uuJY=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7279fc-7012-4efe-fc29-08d812fceb41
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 20:27:55.9974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l/Fkw/IVhUwfFjQdTrIg79h9Yd3BBjVXymyDDyWtSkevMcniQuQ00dULwfVo6JJXlBjimERY4c6mmDrn0FdZpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3026
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, June 17, 2020 3:02 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu/fence: fix ref count leak when pm_runtime_get_sync fails

[CAUTION: External Email]

The call to pm_runtime_get_sync increments the counter even in case of failure, leading to incorrect ref count.
In case of failure, decrement the ref count before returning.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 8537f4704348..60b323d7caf2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -755,8 +755,10 @@ static int amdgpu_debugfs_gpu_recover(struct seq_file *m, void *data)
        int r;

        r = pm_runtime_get_sync(dev->dev);
-       if (r < 0)
+       if (r < 0) {
+               pm_runtime_put_autosuspend(dev->dev);
                return 0;
+       }

        seq_printf(m, "gpu recover\n");
        amdgpu_device_gpu_recover(adev, NULL);
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Crajneesh.bhardwaj%40amd.com%7Cdcc3842e55284da6689f08d812f0fb07%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637280173535571918&amp;sdata=NU1AzDtdUzmvXItL05quhP35rT1plj4%2B3vOJE9Rr2lA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
