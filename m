Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD599C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 04:28:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 661C8601FD
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 04:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661C8601FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5D526E8DE;
	Fri, 26 Feb 2021 04:28:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D52746E8DE
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 04:28:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCGq2R+WPc+z+O1WPXYi6IzwcIfgBzU5P3sVF9cuoiJi3dfB053CvnWdm76sYhPKzUBysgoO1AkX5pdQKIrtjphVoiJnLk/vWBi5L7t12VA8hyNIXYQSEdT7Zg1Fw9rWPx2J+OxNLcO4rEn3yhiTlqUlnr+Eu+/U9j4UvQfNX4x/dn+DU7TJL4avRCpeiwQnGLK+vUEWlRJkiVwj33jJ4Xl0bS8ZA77QsmdqTt/0hL+ZM2EjpTaDbmfB+w5Dc+uYeSI9yv3C6/DUruuF4mJ9wHV75sYHf806xmcmGr9fEwxmxuxP/1fL7HFfij+tHZymlWqZr7Ba2V4js1u72wi1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrpGThxcX/GrArg/t3tiW0mOSglYICcZz4ZIQTLoWv4=;
 b=QmBf9zeEGIRjdavCaR83cuAcAcL93Ct0cbtMfejwjvipYrAKfiFWxtX+OKUr3Qa0WS22486dQ/l30z/2plkcm+bQRIu+FG+qRjtq3MEuftgcqxXP77HlJRqAR00Bj6ERY1TL18SYUTlSZXDkAbr8zlJrZpswigz+Cfd+uFqA2dE7KVoQJQr8UKT+jTkMzWFiydrupXgXHTLYVHxMNa+goDEwp8uTlyPHZ303zsfU8+sasFBQZqs7e6Vo/wPizncYEDg5n5X2t6pw4JPaoSC+rVjkDmse0RK42n7cTkuSPu4HN5DaSLJ3AlG5AKvKdAJTvIYybvh88Lmy06mho3aDJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrpGThxcX/GrArg/t3tiW0mOSglYICcZz4ZIQTLoWv4=;
 b=ASKsiHq7aP81efDZifdjQILGW9ICOS9GVS5XSuhTqCczOZXRFKDVhqZwnYNuMOpNby/3n58qu/Ws5AC9cxdXPqWbDoXm+yDyYS5WsNt6MMkS7T++0On8s8JKM8DpC25Y3ue49bLHmzCg54cdDpo56iT19UvbQAY34azRNP5f3ak=
Received: from MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 26 Feb
 2021 04:28:17 +0000
Received: from MN2PR12MB4078.namprd12.prod.outlook.com
 ([fe80::f8e7:bfb4:8183:b7d2]) by MN2PR12MB4078.namprd12.prod.outlook.com
 ([fe80::f8e7:bfb4:8183:b7d2%8]) with mapi id 15.20.3846.047; Fri, 26 Feb 2021
 04:28:16 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add RAP TA version print in
 amdgpu_firmware_info
Thread-Topic: [PATCH] drm/amdgpu: add RAP TA version print in
 amdgpu_firmware_info
Thread-Index: AQHXC/dGLk/+AdB+5EWsGnZ2SbYWwapp13gA
Date: Fri, 26 Feb 2021 04:28:16 +0000
Message-ID: <MN2PR12MB4078034BF6186F6C81114CC0FC9D9@MN2PR12MB4078.namprd12.prod.outlook.com>
References: <20210226042359.39108-1-kevin1.wang@amd.com>
In-Reply-To: <20210226042359.39108-1-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-02-26T04:28:14Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=ad435942-6664-44e5-8646-6e8d501f0fef;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 742e3338-af37-4fe4-8e61-08d8da0ef029
x-ms-traffictypediagnostic: MN2PR12MB4063:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB40638E1E0206DEE829A37415FC9D9@MN2PR12MB4063.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:159;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7cp0/zQBHWM+JpSVpVwGrDFJ04WlhHt20xrNiVUB0ywEf/OsIVqddzih+GcS42RcXMUF8EyIsOrYuYRifhwrNkQAADFzIzd8dvoMiXREsPImoMBOVT/7AY/qsYXV1p13YEVaf7oaq4z9IzlQxyIyEtNCvt2KIipaUpYB5yHyR4wj9lqSvczgSlYd6DmfKgw5tkQRdzp5wmOKEfhSNlzeydzkUH07dBmxNOXJ5qCeNwWh2O3JpkqFfW/1cclbWAOPzNpUdS5bPHXTWbgP4CWaAlfKJ7F592gyk2iz/mXPzDsvHCoxQPyN/wHK3ZatzVCe42I6TWs1YvtE72lUmLjnJqLaIf3J3jCGlXodS2vxvJzlS+Logv/KovpU2tIJ2p26Pjz/XNG69XjGmTcYBKDSy2HtIrqZrw/fTGCU6QHwe9UvdYvKeadbCM7GA84HAplqu0GRTyJmyuWcIMeeG5jICLVEwPfiV/UPkbNZGfsn/d8NRhTUJ28hq5G5zoBkU7yluWzsC41fVfn2rLWYn4aH8Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4078.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(64756008)(66946007)(55016002)(86362001)(66446008)(76116006)(66556008)(71200400001)(8676002)(26005)(66476007)(7696005)(186003)(4326008)(33656002)(53546011)(9686003)(8936002)(52536014)(478600001)(83380400001)(5660300002)(6506007)(2906002)(316002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HRbqkWSfcUG0SCiXoZEORGmaGCehc+Qgp9xKUgTiVHD7xQgHHoetxxklVOlk?=
 =?us-ascii?Q?cyVcUpZmk61HbEyMovOlF/VjSWlgSoibKkPV4NurXtkkPmxAgW/vSuTkifSZ?=
 =?us-ascii?Q?O6gv8szZs8eAbKH3cJx2X1U8lEDbaE0X9vFiHV28WhJc8Avg1BOgy5+n3IPq?=
 =?us-ascii?Q?YhkEZTre0cUwKQCHwX8UXeJkIrKceZDPgjNgZLK5jsZL9akLskD9XZ7SinjA?=
 =?us-ascii?Q?eCEhWD33V12OzD8RRvG64obvIWB8IZBxbgGvMF9sZb8BUPuS3zRqCJOE1RXI?=
 =?us-ascii?Q?XXq8TDw0/UOj63PxiOP30Nm8Yg30mPdX+A18Sizu6Np9J7IT8g7LWAJK+ZQ4?=
 =?us-ascii?Q?Xx11IQxma9PhrQSu0Br2+F/dycJ/S3nyt54wT8FwED0ht9+l4qsJK6G9o1QX?=
 =?us-ascii?Q?dPDuLktmkd5XEye5/POm9D3Q3dQ4B4mWqoIdMUtQFyL09FcqFOekzWiDglmO?=
 =?us-ascii?Q?8pVDsV47LlF5zwJTTbvFOn5rbki8B76+6wDFwqHfr0dRl+YnAPQ13LuLjZVa?=
 =?us-ascii?Q?ZyAL5dOXYsZTsghErUxsvcbcxcJwfZ2Vg97Wn9mnMAkQLT3t+4JH/m4OD0U+?=
 =?us-ascii?Q?umJuBOX42mwf1CrOv7tHFkjbIG28GNqG9ZTpOVx+vJf84H/VxBt4F3NRK+fY?=
 =?us-ascii?Q?gNYq4+72qL01HgpzKr0w5d0PkT1t/Q4U7XjOdOgFD6YodOJDKBrP26VFcYvL?=
 =?us-ascii?Q?liLEBvyEcx9smKFyES5xEKV6tYO0YIzvI05BTso7L3yHjuBOAiP7D7HmurmG?=
 =?us-ascii?Q?Nvd8+DfCAX02k/ZmTuVlctgC/acWMV63llIbzt7JlHG6ebliamhvDCt8rymD?=
 =?us-ascii?Q?PItF24qN6xuIODvpBgl25/8JATC6+vR1h5DPOWlfOquqZ7jXemXnLikDmVHs?=
 =?us-ascii?Q?q9xJXGOnoIRIuzp5+YZ3BEgVlDRkKEu4PqlKzdGUkMyJgvtrtEP8FFlwd7AI?=
 =?us-ascii?Q?7CzDLYVKHgeMEs3KmlavlJFEy8P46auAzv52heRC5TUdE16GLLY5dZU0Plo2?=
 =?us-ascii?Q?JE/CxZwY/zhHQKDyS6hQxEzN8ISuTK5at3QpK0DyRO+180qd9rPYR+e55t+q?=
 =?us-ascii?Q?evwpZy/IT7m9KUe98UTP/KK7TF3cvxrZ+hEsSj6JHh0+gE1z6EXVZj8+tzsx?=
 =?us-ascii?Q?keZG6f654MGccNf1ztQPwGnsFMpFsPH4rFN0ZIrSpNwQmd59UI1yyapnaCJ5?=
 =?us-ascii?Q?f5bsbEOIKCAqPcLIQ07Ad/5LEc2e4R+8NO018HgJt0w9SPssoCW3hG5dBJFg?=
 =?us-ascii?Q?oIBugleCgel+YuFYuyvTRigVFRRZUxNdu80rq4p7bsv3cwNAId/5tetA0XVe?=
 =?us-ascii?Q?ggpEPkOrPBHAzw6jCkCjD8hd?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4078.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 742e3338-af37-4fe4-8e61-08d8da0ef029
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 04:28:16.5233 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cdFes3UbvhOiDL81y7hNGCIM8LWJxuor4ZBV6h8wJV6ISj4KK4u1w+agM+KZv83eerLhmxut9U83+i/ARHqd3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

-----Original Message-----
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com> 
Sent: Friday, February 26, 2021 12:24
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: add RAP TA version print in amdgpu_firmware_info

add RAP TA version print in amdgpu_firmware_info.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index ce031a77cda5..a5ed9530f542 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -305,6 +305,10 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
 			fw_info->ver = adev->psp.ta_fw_version;
 			fw_info->feature = adev->psp.ta_dtm_ucode_version;
 			break;
+		case 4:
+			fw_info->ver = adev->psp.ta_fw_version;
+			fw_info->feature = adev->psp.ta_rap_ucode_version;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -1490,6 +1494,10 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
 					"DTM", fw_info.feature, fw_info.ver);
 			break;
+		case 4:
+			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
+					"RAP", fw_info.feature, fw_info.ver);
+			break;
 		default:
 			return -EINVAL;
 		}
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
